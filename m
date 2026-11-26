Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E91606A69F
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 09:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=verwilst.be header.i=@verwilst.be header.a=rsa-sha256 header.s=protonmail3 header.b=ZnMhHBJX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 789DD112966;
	Fri, 27 Nov 2026 09:58:49 +0000 (UTC)
X-Greylist: delayed 23471 seconds by postgrey-1.36 at gabe;
 Thu, 26 Nov 2026 17:32:38 UTC
Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch
 [79.135.106.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC10511263C
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Nov 2026 17:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verwilst.be;
 s=protonmail3; t=1795714356; x=1795973556;
 bh=eeNcwp/TXVCSok/gP9Prh19hCuOo7CNRFJOiYoxreGY=;
 h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=ZnMhHBJXcoRQC2JMGjL4EuQzvROfQeN44/jpZvGVd+r2e3WEYuHHy46h5aoQh0M7X
 CxZmBqKqdTM5/Z++QmqQiuuFQY7Tl1ziqHWSp7Fxu4U7Sz4h8Iti/76kdjbrWakNzT
 OdSAO6zvW83JHmjoc94F12pboEFSxGexCqYKKRIk8VtKtG+AVVHry7ZftV5BqwGeXm
 6Et9eigtIHwMnpyzOEAwrM+Djtg/IXE3F1ucUobrrInpuIvcCcCETWQmkWR7+FjGAd
 Mk2/c8Mx3qYSYNPPWNwZjxZin+3eqmtWxSKwbNBkDNIczlHsA83eGsj5nQ+SrNkogE
 5avXvpe83LXTw==
X-Pm-Submission-Id: 4jb3XK6PXhz1DDWb
From: Bart Verwilst <bart@verwilst.be>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, Wayne.Lin@amd.com
Subject: [PATCH v3 2/2] drm/amd/display: don't tear down a shared link for a
 stale SST/MST stream
Date: Thu, 26 Nov 2026 18:31:56 +0100
Message-ID: <20261126173156.13147-3-bart@verwilst.be>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261126173156.13147-1-bart@verwilst.be>
References: <20261126173156.13147-1-bart@verwilst.be>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Nov 2026 09:58:44 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

A sink can switch between SST and MST on the same link. The Samsung
Odyssey Neo G9 57" does that when Picture-by-Picture is toggled in its
OSD: PbP is a 3840x2160 SST stream, fullscreen is a 7680x2160 MST stream
with DSC, both over UHBR.

The stream of the previous mode stays in the dc state until userspace
disables its CRTC. On PbP off, the MST stream is already up (UHBR13.5
trained, payload allocated, ACT done) when the compositor disables the old
SST CRTC on the same link. link_set_dpms_off_v1() treats that as a regular
SST teardown:

  link_set_dpms_off ... signal=20 link=2 sink_count=1
  DPCD 0x00600 AUX <- 02          (sink to D3)

update_sst_payload(false) rewrites the payload allocation of the shared
128b/132b link encoder, and disable_link() powers the sink down and turns
the PHY off while the MST stream is still running on it.
disable_link_dp() only protects a link with active MST payloads when the
stream being disabled is itself an MST stream. On Navi 48 (DCN 4.0.1) the
GPU locks up about 2.5 s later and needs a hard reset. The mirrored case,
a stale MST stream disabled on a link that is now SST, does the same
through deallocate_mst_payload() and disable_link().

When another enabled stream of the other mode (SST vs. MST) is present on
the same link in the current state, only release the disabled stream's own
resources: blank it, clear its own VC rate and hblank settings while the
link runs 128b/132b, disable the stream and its DSC, and do the MST
bookkeeping in software. Leave the sink power and DSC enable, the PHY,
USB4 bandwidth and the link encoder's payload table to the stream of the
new mode. Without such a stream, e.g. during link verification on
detection, the teardown is unchanged.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5671
Signed-off-by: Bart Verwilst <bart@verwilst.be>
---
 .../drm/amd/display/dc/link/link_dpms_v1.c    | 96 +++++++++++++++++--
 1 file changed, 90 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.c
index 1a6fe2e..c229366 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.c
@@ -2403,6 +2403,42 @@ static struct vpg *get_vpg(struct pipe_ctx *pipe_ctx)
 		return pipe_ctx->stream_res.stream_enc->vpg;
 }
 
+/*
+ * A sink can switch between SST and MST on the same link, e.g. a monitor
+ * toggling Picture-by-Picture. The stream of the previous mode stays in the
+ * state until userspace disables its CRTC, which can happen after a stream of
+ * the new mode is already lit on this link. Returns true if such a stream of
+ * the other mode is enabled on the link, i.e. the link must stay up.
+ */
+static bool link_in_use_by_other_mode(const struct dc_link *link,
+				      const struct dc_stream_state *stream)
+{
+	const struct dc *dc = link->dc;
+	bool is_mst = stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST;
+	int i;
+
+	if (!dc_is_dp_signal(stream->signal) || !dc->current_state)
+		return false;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		const struct pipe_ctx *pipe =
+				&dc->current_state->res_ctx.pipe_ctx[i];
+		bool other_is_mst;
+
+		if (!pipe->stream || pipe->stream == stream ||
+		    !is_master_pipe_for_link(link, pipe) ||
+		    pipe->stream->dpms_off ||
+		    !dc_is_dp_signal(pipe->stream->signal))
+			continue;
+
+		other_is_mst = pipe->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST;
+		if (other_is_mst != is_mst)
+			return true;
+	}
+
+	return false;
+}
+
 enum dc_status link_set_dpms_off_v1(struct pipe_ctx *pipe_ctx)
 {
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
@@ -2411,6 +2447,7 @@ enum dc_status link_set_dpms_off_v1(struct pipe_ctx *pipe_ctx)
 	struct dc_link *link = stream->link;
 	struct vpg *vpg = get_vpg(pipe_ctx);
 	enum dp_panel_mode panel_mode_dp = dp_get_panel_mode(link);
+	bool stale_on_link;
 
 	ASSERT(is_master_pipe_for_link(link, pipe_ctx));
 
@@ -2418,6 +2455,17 @@ enum dc_status link_set_dpms_off_v1(struct pipe_ctx *pipe_ctx)
 		/* No real hardware to program for virtual signals. */
 		return DC_DPMS_SKIPPED_HANDSHAKE;
 
+	/*
+	 * Tearing down the stale stream of a previous SST/MST mode must not
+	 * touch what the new mode's stream shares with it: sink power
+	 * (DP_SET_POWER), sink DSC, the PHY, USB4 bandwidth, or the link
+	 * encoder's payload allocation. Only release the stream's own resources.
+	 */
+	stale_on_link = link_in_use_by_other_mode(link, stream);
+	if (stale_on_link)
+		DC_LOG_WARNING("%s: stale signal %x on link %u, link in use, kept up\n",
+			       __func__, stream->signal, link->link_index);
+
 	if (stream->sink) {
 		if (stream->sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
 			stream->sink->sink_signal != SIGNAL_TYPE_NONE) {
@@ -2440,14 +2488,45 @@ enum dc_status link_set_dpms_off_v1(struct pipe_ctx *pipe_ctx)
 	dc->hwss.blank_stream(pipe_ctx);
 
 	if (pipe_ctx->link_config.dp_tunnel_settings.should_use_dp_bw_allocation &&
-	    stream->sink)
+	    stream->sink && !stale_on_link)
 		deallocate_usb4_bandwidth(stream);
 
-	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
+	if (stale_on_link) {
+		const struct link_hwss *link_hwss =
+				get_link_hwss(link, &pipe_ctx->link_res);
+		const struct dc_link_settings empty_link_settings = {0};
+
+		/*
+		 * Clear this stream encoder's own VC rate and hblank settings.
+		 * Those registers are only clocked while the link runs
+		 * 128b/132b.
+		 */
+		if (link_dp_get_encoding_format(&link->cur_link_settings) ==
+				DP_128b_132b_ENCODING &&
+		    dp_is_128b_132b_signal(pipe_ctx)) {
+			if (link_hwss->ext.set_throttled_vcp_size)
+				link_hwss->ext.set_throttled_vcp_size(pipe_ctx,
+						dc_fixpt_from_int(0));
+			if (link_hwss->ext.set_hblank_min_symbol_width)
+				link_hwss->ext.set_hblank_min_symbol_width(pipe_ctx,
+						&empty_link_settings,
+						dc_fixpt_from_int(0));
+		}
+
+		/* bookkeeping only, the link belongs to the new mode now */
+		if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
+			remove_stream_from_alloc_table(link,
+						       pipe_ctx->stream_res.stream_enc,
+						       pipe_ctx->stream_res.hpo_dp_stream_enc);
+			dm_helpers_dp_mst_update_mst_mgr_for_deallocation(stream->ctx,
+									  stream);
+		}
+	} else if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST) {
 		deallocate_mst_payload(pipe_ctx);
-	else if (dc_is_dp_sst_signal(stream->signal) &&
-			dp_is_128b_132b_signal(pipe_ctx))
+	} else if (dc_is_dp_sst_signal(stream->signal) &&
+			dp_is_128b_132b_signal(pipe_ctx)) {
 		update_sst_payload(pipe_ctx, false);
+	}
 
 	if (dc_is_hdmi_signal(stream->signal)) {
 		struct ext_hdmi_settings settings = {0};
@@ -2472,7 +2551,9 @@ enum dc_status link_set_dpms_off_v1(struct pipe_ctx *pipe_ctx)
 		}
 	}
 
-	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT &&
+	if (stale_on_link) {
+		dc->hwss.disable_stream(pipe_ctx);
+	} else if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT &&
 			!dp_is_128b_132b_signal(pipe_ctx)) {
 
 		/* In DP1.x SST mode, our encoder will go to TPS1
@@ -2491,7 +2572,10 @@ enum dc_status link_set_dpms_off_v1(struct pipe_ctx *pipe_ctx)
 	edp_set_panel_assr(link, pipe_ctx, &panel_mode_dp, false);
 
 	if (stream->timing.flags.DSC) {
-		if (dc_is_dp_signal(stream->signal))
+		if (stale_on_link)
+			/* release our DSC, leave the sink's DSC_ENABLE alone */
+			link_set_dsc_on_stream(pipe_ctx, false);
+		else if (dc_is_dp_signal(stream->signal))
 			link_set_dsc_enable(pipe_ctx, false);
 		else if (dc_is_hdmi_frl_signal(stream->signal))
 			link_set_dsc_on_stream(pipe_ctx, false);
-- 
2.56.1


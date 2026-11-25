Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC672606A31C
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Nov 2026 08:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=verwilst.be header.i=@verwilst.be header.a=rsa-sha256 header.s=protonmail3 header.b=ADbdVbvY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0494E112122;
	Thu, 26 Nov 2026 08:10:26 +0000 (UTC)
Received: from mail-106110.protonmail.ch (mail-106110.protonmail.ch
 [79.135.106.110])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D01E410FF02
 for <amd-gfx@lists.freedesktop.org>; Wed, 25 Nov 2026 18:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=verwilst.be;
 s=protonmail3; t=1795632154; x=1795891354;
 bh=owDKhfYCN+cNzsVqQuwcUudTbCNXlgtFSXO8Rfaok+w=;
 h=From:To:Cc:Subject:Date:Message-ID:From:To:Cc:Date:Subject:
 Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=ADbdVbvYUQtUgFT1kj/LMlaugIwo3iZuNAjd7GK/Py+3+fdZT6EqqT8+520D1sDmP
 6Zjlv5S0qafPtV+BNYTeHNVVIoMnSdWiRbxaHqLGO7ZUfm80Skau9i8yA1k6vhfY5x
 R3lr4b0LWrCjuAI1w98nDDVv9hFCOmJUlUmvC3+AlwcKpJcVGjGReFDHPKpm2PbpYc
 uE15+ilTp184LnE6D/fVzyO5CrHBX7ehBAqwT09wLj7XHJk4IF4sXYvCXuRJid2eGo
 BTmN8j8ugQiWG4a3oK6VeuQ7EjoAVZ8CxyENGCBeDkSjteC9Ak7RG1KNnU/PNXu30x
 3u8K2IYxka1PQ==
X-Pm-Submission-Id: 4jZT7X3W8zz2ScmT
From: Bart Verwilst <bart@verwilst.be>
To: amd-gfx@lists.freedesktop.org
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, Wayne.Lin@amd.com
Subject: [PATCH] drm/amd/display: don't tear down a shared link for a stale
 SST/MST stream
Date: Wed, 25 Nov 2026 19:42:08 +0100
Message-ID: <20261125184208.36789-1-bart@verwilst.be>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 26 Nov 2026 08:09:32 +0000
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
SST CRTC on the same link. link_set_dpms_off() treats that as a regular
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

Detect a stream whose signal no longer matches the link's connection type
and only release the stream's own resources for it: blank, disable the
stream, and do the MST bookkeeping in software. Leave the sink power, the
PHY and the link encoder's payload table to the stream of the new mode.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5671
Signed-off-by: Bart Verwilst <bart@verwilst.be>
---
Tested on an RX 9070 XT (Navi 48, DCN 4.0.1) with a Samsung Odyssey
Neo G9 57" on 7.3.5: toggling PbP hard-locked the machine every time.
With this patch it switches both ways within a few seconds. Logs and
analysis are in the issue. The patch is against amd-staging-drm-next,
where the function is now link_set_dpms_off_v1(). The same change
applies to link_set_dpms_off() in mainline 7.4-rc4.

 .../drm/amd/display/dc/link/link_dpms_v1.c    | 41 +++++++++++++++++--
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.c
index 1a6fe2e..fd37e68 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms_v1.c
@@ -2411,6 +2411,7 @@ enum dc_status link_set_dpms_off_v1(struct pipe_ctx *pipe_ctx)
 	struct dc_link *link = stream->link;
 	struct vpg *vpg = get_vpg(pipe_ctx);
 	enum dp_panel_mode panel_mode_dp = dp_get_panel_mode(link);
+	bool stale_on_link;
 
 	ASSERT(is_master_pipe_for_link(link, pipe_ctx));
 
@@ -2418,6 +2419,26 @@ enum dc_status link_set_dpms_off_v1(struct pipe_ctx *pipe_ctx)
 		/* No real hardware to program for virtual signals. */
 		return DC_DPMS_SKIPPED_HANDSHAKE;
 
+	/*
+	 * A sink can switch between SST and MST on the same link, e.g. a
+	 * monitor toggling Picture-by-Picture. The stream created for the
+	 * previous mode stays in the state until userspace disables its CRTC,
+	 * which can happen after a stream of the new mode is already lit on
+	 * this link. Tearing such a stale stream down must not touch what is
+	 * shared with the new mode: powering the sink down (DP_SET_POWER),
+	 * disabling the PHY, or rewriting the link encoder's payload
+	 * allocation. Only release the stream's own resources.
+	 */
+	stale_on_link =
+		(dc_is_dp_sst_signal(stream->signal) &&
+		 link->type == dc_connection_mst_branch) ||
+		(stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST &&
+		 (link->type == dc_connection_single ||
+		  link->type == dc_connection_sst_branch));
+	if (stale_on_link)
+		DC_LOG_WARNING("%s: stale signal %x on link %u (type %d), link kept up\n",
+			       __func__, stream->signal, link->link_index, link->type);
+
 	if (stream->sink) {
 		if (stream->sink->sink_signal != SIGNAL_TYPE_VIRTUAL &&
 			stream->sink->sink_signal != SIGNAL_TYPE_NONE) {
@@ -2443,11 +2464,21 @@ enum dc_status link_set_dpms_off_v1(struct pipe_ctx *pipe_ctx)
 	    stream->sink)
 		deallocate_usb4_bandwidth(stream);
 
-	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST)
+	if (stale_on_link) {
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
@@ -2472,7 +2503,9 @@ enum dc_status link_set_dpms_off_v1(struct pipe_ctx *pipe_ctx)
 		}
 	}
 
-	if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT &&
+	if (stale_on_link) {
+		dc->hwss.disable_stream(pipe_ctx);
+	} else if (stream->signal == SIGNAL_TYPE_DISPLAY_PORT &&
 			!dp_is_128b_132b_signal(pipe_ctx)) {
 
 		/* In DP1.x SST mode, our encoder will go to TPS1
-- 
2.56.1


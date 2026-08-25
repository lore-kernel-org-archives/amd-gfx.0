Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDF75C5DF97
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Aug 2026 12:46:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51FE910ECD2;
	Wed, 26 Aug 2026 12:46:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WlXY2JkL";
	dkim-atps=neutral
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com
 [209.85.222.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A727710E1A7
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 21:18:56 +0000 (UTC)
Received: by mail-ua1-f42.google.com with SMTP id
 a1e0cc1a2514c-969524c1aefso82426241.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 25 Aug 2026 14:18:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787692735; x=1788297535; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+eIjrt6KeI3I2h6Zo1iGh+SOtnehC55eS3yDc43Zaig=;
 b=WlXY2JkLb+uNQZ3h8B9w/qdB5i7RxjWKrbbFNTmOFqAva/IC4vq5BBwvuwF8HhELD/
 waCMDGjBWqsRWbgk4ipAqd9puCu/HXYjUVRnesfgjxv5Oa8uhyZMVnxxuTlrjaa44pKF
 ogUuUbT7eFUnedYOFLmNywsHrI6YYNNjoGno1gGl/FZUeDZ6QtQBTl3DS6eOoDIAX/KC
 3wV+Gr2bcCX+Yfrg4DEGYvf6tLcReWqfHYgRXrBKYlml4iFpXQTiZsADtz4krkH9crL/
 cKjSGGcDBxQbT0/OecOLKc1JrHJH/L7ywwJnyleNQVb+dmAKus0VDA1rqO2zx7TF4thO
 E1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787692735; x=1788297535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=+eIjrt6KeI3I2h6Zo1iGh+SOtnehC55eS3yDc43Zaig=;
 b=GTnWpf1r1SfIX3Q8emFtQ7g0AIrnz8Kd4pkbEgIeGJ7C9db/UFZULc5AehBFGbQJW1
 D5KQiKa6Gfow2C2w0+PzKx5MGlgoIKZpX1A9/22chxXqn5TLInaqyP3o3xmGYjbU7su3
 p7zpckzW2k3Vyj2FSsT+NpnnT5uI6/U+O5S/ubnbQrZaQv7IMCqWL6z1y54ezyFcupgd
 es+UakclPSXfQEYdOdy4CQnnpyxeJUYhdPGTSSWxHShTbvzvFQRHcXjLc0YPkj1ghzWZ
 vW0D6EAxZ8zpWFrCfJZkMe9UX3Yjv8fjp1paUdTQrWR4a5W8VNjwvU8XCVMwpu2gdhy+
 hR/g==
X-Gm-Message-State: AFuF++nRRx+7kpkYmY5XnQcLADPumdYsxbs1Mh+yc87iOOdIFkTGZBJ8
 9rXtQGLMTIEhrnbN5uTvFaELwXW9wrTGdCQJNMaL7xqLdunknBYsfAe7UlAEwmIkF6g=
X-Gm-Gg: AR+sD13/OoIs1kVsNSFLeqXYZ/1C/1nhCP35LS7P1UHo7qNuUnNZi3lJr9mk0tXyhJi
 Ub9wiYQYyKcV6yVAQpai4WB9LyHAdVwaiB3/CCmn1dI7gxPIdwLFCuGpmI5nbual92dRl49KhKl
 EToczN6LY2oK12BruF90MZnEL9L5ncMa+AWoL6twtst9e7UrSwB4ASIUuGWmM2iuYTj9UBj5W1x
 K4YQgGBTpgHfDMxlgr/7qESikWRexySDArSk/7FUwEA7ydZCbPC0BTXAP86LM5xztIHYjy6SdI8
 X2LGIUhDaaByt1SbYTuF6r/SvfyvzrXFG5RsFafmEKbOdfXW6bfVeLrTaCD9fOePoqAUE3IKJrh
 D6TBXpxZsGOjw9wskd06AVKESnF4BK7vP7NSeVlg8a+5fyEZ4iRYB/GR3YuBhPJe7OxXVDrhPc1
 dpKvNiy4Toa9ScfShnuhFmSjrAqLhA4i2vg3a41kJJN0PVhPPnnrYG/kciYhFWwQteMRQ=
X-Received: by 2002:a05:6102:448a:b0:778:9b4:55a4 with SMTP id
 ada2fe7eead31-782c1c06621mr671271137.12.1787692735490; 
 Tue, 25 Aug 2026 14:18:55 -0700 (PDT)
Received: from t14 ([189.39.221.242]) by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-78307cb51b9sm47611137.7.2026.08.25.14.18.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 14:18:54 -0700 (PDT)
From: Mauricio Bellon <mauriciobellon@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Wayne Lin <Wayne.Lin@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Mauricio Bellon <mbellon@lenovo.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com,
 stable@vger.kernel.org
Subject: [PATCH 1/2] drm/amd/display: stabilize DCN35 ODM update sequencing
Date: Tue, 25 Aug 2026 18:18:18 -0300
Message-ID: <20260825211819.100210-2-mauriciobellon@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260825211819.100210-1-mauriciobellon@gmail.com>
References: <20260825211819.100210-1-mauriciobellon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 26 Aug 2026 12:46:21 +0000
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Mauricio Bellon <mbellon@lenovo.com>

Two related direct DisplayPort failures occur with a high-refresh DSC
stream using two-way ODM on DCN35. A normal transition from 4K120 to
4K144 can commit successfully but produce no visible output. After 4K144
is working, a long-pulse hotplug can reconstruct the same DSC/ODM stream
but leave the monitor black.

The horizontal timing divider changes together with the ODM topology.
DCN35 does not expose wait_odm_doublebuffer_pending_clear(), so the
common completion path can continue before the divider update has
latched. Hook up the compatible DCN32 wait implementation and wait
immediately after dcn35_update_odm() programs combine or bypass.

Keep the divider under manual control while changing the ODM topology.
After the pending update completes, restore manual mode explicitly from
the target stream using the same FRL, horizontal-timing divisibility, and
virtual-signal policy as stream timing setup. Keep that restoration
separate from hwss_wait_for_odm_update_pending_complete() so the wait
helper remains limited to waiting for hardware updates.

The affected 4K144 timing has odd horizontal blank boundaries and
requires manual divider mode, while the 4K120 timing is divisible by two
and uses automatic mode. The ODM combine and bypass functions explicitly
program OTG_H_TIMING_DIV_MODE before completion.

Cc: stable@vger.kernel.org
Signed-off-by: Mauricio Bellon <mbellon@lenovo.com>
---
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 20 +++++++++++++++++--
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |  2 ++
 2 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 6e1079377..a5b914b81 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -433,18 +433,30 @@ void dcn35_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 {
 	(void)context;
 	struct pipe_ctx *odm_pipe;
+	struct pipe_ctx *current_pipe_ctx =
+		&dc->current_state->res_ctx.pipe_ctx[pipe_ctx->pipe_idx];
+	struct timing_generator *tg = pipe_ctx->stream_res.tg;
 	int opp_cnt = 0;
 	int opp_inst[MAX_PIPES] = {0};
 	int odm_slice_width = resource_get_odm_slice_dst_width(pipe_ctx, false);
 	int last_odm_slice_width = resource_get_odm_slice_dst_width(pipe_ctx, true);
 	struct mpc *mpc = dc->res_pool->mpc;
+	bool target_manual_mode;
+	bool update_odm;
 	int i;
 
 	opp_cnt = get_odm_config(pipe_ctx, opp_inst);
+	update_odm = opp_cnt > 1 || current_pipe_ctx->next_odm_pipe;
+	target_manual_mode = dc_is_hdmi_frl_signal(pipe_ctx->stream->signal) ||
+		!is_h_timing_divisible_by_2(pipe_ctx->stream) ||
+		dc_is_virtual_signal(pipe_ctx->stream->signal);
 
 	if (!(pipe_ctx->stream_res.hpo_frl_stream_enc &&
 			pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_fifo_odm_enabled &&
 			pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_fifo_odm_enabled(pipe_ctx->stream_res.hpo_frl_stream_enc))) {
+		if (update_odm && tg->funcs->set_h_timing_div_manual_mode)
+			tg->funcs->set_h_timing_div_manual_mode(tg, true);
+
 	if (opp_cnt > 1)
 		pipe_ctx->stream_res.tg->funcs->set_odm_combine(
 				pipe_ctx->stream_res.tg,
@@ -454,6 +466,12 @@ void dcn35_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 		pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
 				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
 
+		if (update_odm && tg->funcs->wait_odm_doublebuffer_pending_clear)
+			tg->funcs->wait_odm_doublebuffer_pending_clear(tg);
+
+		if (update_odm && tg->funcs->set_h_timing_div_manual_mode)
+			tg->funcs->set_h_timing_div_manual_mode(tg, target_manual_mode);
+
 	if (mpc->funcs->set_out_rate_control) {
 		for (i = 0; i < opp_cnt; ++i) {
 			mpc->funcs->set_out_rate_control(
@@ -472,8 +490,6 @@ void dcn35_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *
 	}
 
 	if (pipe_ctx->stream_res.dsc) {
-		struct pipe_ctx *current_pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[pipe_ctx->pipe_idx];
-
 		update_dsc_on_stream(pipe_ctx, pipe_ctx->stream->timing.flags.DSC != 0);
 
 		/* Check if no longer using pipe for ODM, then need to disconnect DSC for that pipe */
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index 897f857db..c26a2fd70 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -603,6 +603,8 @@ static const struct timing_generator_funcs dcn35_tg_funcs = {
 		.set_odm_combine = optc35_set_odm_combine,
 		.get_optc_source = optc2_get_optc_source,
 		.wait_otg_disable = optc35_wait_otg_disable,
+		.wait_odm_doublebuffer_pending_clear =
+			optc32_wait_odm_doublebuffer_pending_clear,
 		.set_h_timing_div_manual_mode = optc32_set_h_timing_div_manual_mode,
 		.set_out_mux = optc3_set_out_mux,
 		.set_drr_trigger_window = optc3_set_drr_trigger_window,
-- 
2.53.0


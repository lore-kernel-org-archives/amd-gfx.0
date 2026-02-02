Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D17D5E7315B
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 11:25:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58F3110E441;
	Mon,  2 Feb 2026 11:25:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KgG2zVkQ";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42E7810E441
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 11:25:18 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-42fbc305552so4009116f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 03:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770031517; x=1770636317; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SSbG58Qee9Nqog279hUEY+NlLYHT7LRyIX97Fdz/WFI=;
 b=KgG2zVkQg+vc5aPkdc5UosTh5MKLDPWKWJ+BQjV1WjmlPNIEUpSJObx9aTiJx9ovhD
 O/KvypfNUtta1ggMCuKGlJ8P4TJRQlbl4lMt38BwBamSuwx3nSY+6VLt1iLUF3w9KqVI
 KF7ItNfoBpdHtCe+PsTJo7nlJxpXYIH2pUNL70scVc24mNXnURk9FFES/CgIr4P5/N7J
 qirXAANZNdmnBUzpPZfG1kcQv9wtCnprAeVIb8OLgdc8+LRL/SyREXEfHpP9BmtoSS9a
 gJiT8DYMiIr4CxNWmvnh84x+vKwDFClvGgTHzrcfpr1lRlBqyvanoK5j60EhuqCnhham
 QrtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770031517; x=1770636317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SSbG58Qee9Nqog279hUEY+NlLYHT7LRyIX97Fdz/WFI=;
 b=ipb6Jc6k6tdSWan8A4NT/wC9GhFmpka8Gbkgb176zF1g0DWjk1bX2ltNaAEkn2SDEn
 +rkgluwPDkvni/+XE3hg+1S+sKPHAOWqqDHGTd4xt+9BykiLFxzRRkhCk+l0KreNQCN5
 uT4dAWW7u2NyPDHJdBtj/v7ZgjH7RDAo6kgdSwD7k+fW/w2mmyfKfTrdlnBwIa3kzlYw
 LfwJJCAmNMQNRVn1B3yCbFqHitSwJ2DZWZJ2S9qE4pv7nRnWqz+QwjfauoE/yKieePvV
 j/SYxBsxZLILf9+CQDYXZKSTyIJ9Vr01uc/cyFKW2jZddk40Nzse3P8jiVhCr+BIdJX1
 77GQ==
X-Gm-Message-State: AOJu0YwHLbGWJHs7cR10Q7e/qHrTxb/6pfbtBfg2LwzI1EpQEA7vHtv2
 hD4rU6SuvETWKjhWODkzDziw1l5K/2bJViiVl6D1+niYERdu0/YACntyBQyYTB8L
X-Gm-Gg: AZuq6aJwVyaJ3pL2wLBx7G+xM6+a2ON5SYth+HfVHADFejMtsgBv23Oy5T6H95uCSlp
 fLZiQ8oA9pHcsMuIP2ha0VkKaNQgbgykGFzTtTXN2bgD/ex7CT966FuPkSsrAr+hotaRkQA+HYk
 jE39IB56JA0YgmavHJGajHogw0ph1PC9jc/138j3IOEyHwaUeQ0Ttzy6PEWcj4+2cYbT982Vwxt
 rpYt2mzcK50MMAzocTma9MyIpwHOdVy0YX0HlfQHFdcrnZ9N4dt6UCyw/9ITeGPzmzgepP4QYTX
 nshrAzhUO897CJk8kEVCODJBpCyKGzBhsBFMqTUhQQnUFir6KgkzoAyLRrqn4IdEOtqmM5gsQS5
 LHUqyXpaKY2Dfn3mB+aHH5b0XzH5IVfZpcjBWyVRwbKzDMHDcCc/r10zZONSimvPt6CWQ+3Gglw
 zl9dLBzf7uk+Ak
X-Received: by 2002:a05:6000:1ac7:b0:435:b7b9:a39a with SMTP id
 ffacd0b85a97d-435f3aaa47cmr17231153f8f.38.1770031516530; 
 Mon, 02 Feb 2026 03:25:16 -0800 (PST)
Received: from Timur-Max ([109.137.72.15]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e46cesm43306225f8f.7.2026.02.02.03.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 03:25:16 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Alex Hung <alex.hung@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 siqueira@igalia.com, Mauro Rossi <issor.oruam@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 6/8] drm/amd/display: Set CRTC source for DAC using registers
Date: Mon,  2 Feb 2026 12:25:06 +0100
Message-ID: <20260202112508.43000-7-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260202112508.43000-1-timur.kristof@gmail.com>
References: <20260202112508.43000-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Apparently the VBIOS SelectCRTC_Source function overwrites
a few registers (such as FMT_*) which DC writes in a different
place, which can cause problems.

Instead of using the SelectCRTC_Source function from the
VBIOS, use the DAC_SOURCE_SELECT register directly, similarly
to how it is done for digital link encoders.

Fixes: 3be26d81b150 ("drm/amd/display: Support DAC in dce110_hwseq")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Tested-by: Mauro Rossi <issor.oruam@gmail.com>
---
 .../amd/display/dc/dce/dce_stream_encoder.c   | 23 +++++++++++++---
 .../amd/display/dc/dce/dce_stream_encoder.h   | 12 +++++++--
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 26 +------------------
 .../dc/resource/dce100/dce100_resource.c      |  6 +++--
 .../dc/resource/dce60/dce60_resource.c        |  7 +++--
 .../dc/resource/dce80/dce80_resource.c        |  6 +++--
 6 files changed, 43 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
index 574618d5d4a4..87c19f17c799 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
@@ -1498,7 +1498,10 @@ static void dig_connect_to_otg(
 {
 	struct dce110_stream_encoder *enc110 = DCE110STRENC_FROM_STRENC(enc);
 
-	REG_UPDATE(DIG_FE_CNTL, DIG_SOURCE_SELECT, tg_inst);
+	if (enc->id == ENGINE_ID_DACA || enc->id == ENGINE_ID_DACB)
+		REG_UPDATE(DAC_SOURCE_SELECT, DAC_SOURCE_SELECT, tg_inst);
+	else
+		REG_UPDATE(DIG_FE_CNTL, DIG_SOURCE_SELECT, tg_inst);
 }
 
 static unsigned int dig_source_otg(
@@ -1507,7 +1510,10 @@ static unsigned int dig_source_otg(
 	uint32_t tg_inst = 0;
 	struct dce110_stream_encoder *enc110 = DCE110STRENC_FROM_STRENC(enc);
 
-	REG_GET(DIG_FE_CNTL, DIG_SOURCE_SELECT, &tg_inst);
+	if (enc->id == ENGINE_ID_DACA || enc->id == ENGINE_ID_DACB)
+		REG_GET(DAC_SOURCE_SELECT, DAC_SOURCE_SELECT, &tg_inst);
+	else
+		REG_GET(DIG_FE_CNTL, DIG_SOURCE_SELECT, &tg_inst);
 
 	return tg_inst;
 }
@@ -1568,16 +1574,25 @@ void dce110_stream_encoder_construct(
 	enc110->se_mask = se_mask;
 }
 
-static const struct stream_encoder_funcs dce110_an_str_enc_funcs = {};
+static const struct stream_encoder_funcs dce110_an_str_enc_funcs = {
+	.dig_connect_to_otg  = dig_connect_to_otg,
+	.dig_source_otg = dig_source_otg,
+};
 
 void dce110_analog_stream_encoder_construct(
 	struct dce110_stream_encoder *enc110,
 	struct dc_context *ctx,
 	struct dc_bios *bp,
-	enum engine_id eng_id)
+	enum engine_id eng_id,
+	const struct dce110_stream_enc_registers *regs,
+	const struct dce_stream_encoder_shift *se_shift,
+	const struct dce_stream_encoder_mask *se_mask)
 {
 	enc110->base.funcs = &dce110_an_str_enc_funcs;
 	enc110->base.ctx = ctx;
 	enc110->base.id = eng_id;
 	enc110->base.bp = bp;
+	enc110->regs = regs;
+	enc110->se_shift = se_shift;
+	enc110->se_mask = se_mask;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
index 068de1392121..342c0afe6a94 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
@@ -65,6 +65,7 @@
 	SRI(AFMT_60958_1, DIG, id), \
 	SRI(AFMT_60958_2, DIG, id), \
 	SRI(DIG_FE_CNTL, DIG, id), \
+	SR(DAC_SOURCE_SELECT), \
 	SRI(HDMI_CONTROL, DIG, id), \
 	SRI(HDMI_GC, DIG, id), \
 	SRI(HDMI_GENERIC_PACKET_CONTROL0, DIG, id), \
@@ -290,7 +291,8 @@
 #define SE_COMMON_MASK_SH_LIST_DCE80_100(mask_sh)\
 	SE_COMMON_MASK_SH_LIST_DCE_COMMON(mask_sh),\
 	SE_SF(TMDS_CNTL, TMDS_PIXEL_ENCODING, mask_sh),\
-	SE_SF(TMDS_CNTL, TMDS_COLOR_FORMAT, mask_sh)
+	SE_SF(TMDS_CNTL, TMDS_COLOR_FORMAT, mask_sh),\
+	SE_SF(DAC_SOURCE_SELECT, DAC_SOURCE_SELECT, mask_sh)
 
 #define SE_COMMON_MASK_SH_LIST_DCE110(mask_sh)\
 	SE_COMMON_MASK_SH_LIST_DCE_COMMON(mask_sh),\
@@ -494,6 +496,7 @@ struct dce_stream_encoder_shift {
 	uint8_t DP_VID_N_MUL;
 	uint8_t DP_VID_M_DOUBLE_VALUE_EN;
 	uint8_t DIG_SOURCE_SELECT;
+	uint8_t DAC_SOURCE_SELECT;
 };
 
 struct dce_stream_encoder_mask {
@@ -626,6 +629,7 @@ struct dce_stream_encoder_mask {
 	uint32_t DP_VID_N_MUL;
 	uint32_t DP_VID_M_DOUBLE_VALUE_EN;
 	uint32_t DIG_SOURCE_SELECT;
+	uint32_t DAC_SOURCE_SELECT;
 };
 
 struct dce110_stream_enc_registers {
@@ -653,6 +657,7 @@ struct dce110_stream_enc_registers {
 	uint32_t AFMT_60958_1;
 	uint32_t AFMT_60958_2;
 	uint32_t DIG_FE_CNTL;
+	uint32_t DAC_SOURCE_SELECT;
 	uint32_t DP_MSE_RATE_CNTL;
 	uint32_t DP_MSE_RATE_UPDATE;
 	uint32_t DP_PIXEL_FORMAT;
@@ -712,7 +717,10 @@ void dce110_analog_stream_encoder_construct(
 	struct dce110_stream_encoder *enc110,
 	struct dc_context *ctx,
 	struct dc_bios *bp,
-	enum engine_id eng_id);
+	enum engine_id eng_id,
+	const struct dce110_stream_enc_registers *regs,
+	const struct dce_stream_encoder_shift *se_shift,
+	const struct dce_stream_encoder_mask *se_mask);
 
 void dce110_se_audio_mute_control(
 	struct stream_encoder *enc, bool mute);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index c53c61a4cb5e..72e4bb6883a4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1581,25 +1581,6 @@ static enum dc_status dce110_enable_stream_timing(
 	return DC_OK;
 }
 
-static void
-dce110_select_crtc_source(struct pipe_ctx *pipe_ctx)
-{
-	struct dc_link *link = pipe_ctx->stream->link;
-	struct dc_bios *bios = link->ctx->dc_bios;
-	struct bp_crtc_source_select crtc_source_select = {0};
-	enum engine_id engine_id = link->link_enc->preferred_engine;
-
-	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
-		engine_id = link->link_enc->analog_engine;
-
-	crtc_source_select.controller_id = CONTROLLER_ID_D0 + pipe_ctx->stream_res.tg->inst;
-	crtc_source_select.color_depth = pipe_ctx->stream->timing.display_color_depth;
-	crtc_source_select.engine_id = engine_id;
-	crtc_source_select.sink_signal = pipe_ctx->stream->signal;
-
-	bios->funcs->select_crtc_source(bios, &crtc_source_select);
-}
-
 enum dc_status dce110_apply_single_controller_ctx_to_hw(
 		struct pipe_ctx *pipe_ctx,
 		struct dc_state *context,
@@ -1619,10 +1600,6 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 		hws->funcs.disable_stream_gating(dc, pipe_ctx);
 	}
 
-	if (pipe_ctx->stream->signal == SIGNAL_TYPE_RGB) {
-		dce110_select_crtc_source(pipe_ctx);
-	}
-
 	if (pipe_ctx->stream_res.audio != NULL) {
 		struct audio_output audio_output = {0};
 
@@ -1702,8 +1679,7 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 		pipe_ctx->stream_res.tg->funcs->set_static_screen_control(
 				pipe_ctx->stream_res.tg, event_triggers, 2);
 
-	if (!dc_is_virtual_signal(pipe_ctx->stream->signal) &&
-		!dc_is_rgb_signal(pipe_ctx->stream->signal))
+	if (!dc_is_virtual_signal(pipe_ctx->stream->signal))
 		pipe_ctx->stream_res.stream_enc->funcs->dig_connect_to_otg(
 			pipe_ctx->stream_res.stream_enc,
 			pipe_ctx->stream_res.tg->inst);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
index d40d91ec2035..c7e3feecaf85 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce100/dce100_resource.c
@@ -242,7 +242,8 @@ static const struct dce110_stream_enc_registers stream_enc_regs[] = {
 	stream_enc_regs(3),
 	stream_enc_regs(4),
 	stream_enc_regs(5),
-	stream_enc_regs(6)
+	stream_enc_regs(6),
+	{SR(DAC_SOURCE_SELECT),} /* DACA */
 };
 
 static const struct dce_stream_encoder_shift se_shift = {
@@ -491,7 +492,8 @@ static struct stream_encoder *dce100_stream_encoder_create(
 		return NULL;
 
 	if (eng_id == ENGINE_ID_DACA || eng_id == ENGINE_ID_DACB) {
-		dce110_analog_stream_encoder_construct(enc110, ctx, ctx->dc_bios, eng_id);
+		dce110_analog_stream_encoder_construct(enc110, ctx, ctx->dc_bios, eng_id,
+			&stream_enc_regs[eng_id], &se_shift, &se_mask);
 		return &enc110->base;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index 068fb1df8d88..a26046c5dd38 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -258,7 +258,9 @@ static const struct dce110_stream_enc_registers stream_enc_regs[] = {
 	stream_enc_regs(2),
 	stream_enc_regs(3),
 	stream_enc_regs(4),
-	stream_enc_regs(5)
+	stream_enc_regs(5),
+	{0},
+	{SR(DAC_SOURCE_SELECT),} /* DACA */
 };
 
 static const struct dce_stream_encoder_shift se_shift = {
@@ -607,7 +609,8 @@ static struct stream_encoder *dce60_stream_encoder_create(
 		return NULL;
 
 	if (eng_id == ENGINE_ID_DACA || eng_id == ENGINE_ID_DACB) {
-		dce110_analog_stream_encoder_construct(enc110, ctx, ctx->dc_bios, eng_id);
+		dce110_analog_stream_encoder_construct(enc110, ctx, ctx->dc_bios, eng_id,
+			&stream_enc_regs[eng_id], &se_shift, &se_mask);
 		return &enc110->base;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
index 8687104cabb7..809b507fb4a3 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce80/dce80_resource.c
@@ -258,7 +258,8 @@ static const struct dce110_stream_enc_registers stream_enc_regs[] = {
 	stream_enc_regs(3),
 	stream_enc_regs(4),
 	stream_enc_regs(5),
-	stream_enc_regs(6)
+	stream_enc_regs(6),
+	{SR(DAC_SOURCE_SELECT),} /* DACA */
 };
 
 static const struct dce_stream_encoder_shift se_shift = {
@@ -614,7 +615,8 @@ static struct stream_encoder *dce80_stream_encoder_create(
 		return NULL;
 
 	if (eng_id == ENGINE_ID_DACA || eng_id == ENGINE_ID_DACB) {
-		dce110_analog_stream_encoder_construct(enc110, ctx, ctx->dc_bios, eng_id);
+		dce110_analog_stream_encoder_construct(enc110, ctx, ctx->dc_bios, eng_id,
+			&stream_enc_regs[eng_id], &se_shift, &se_mask);
 		return &enc110->base;
 	}
 
-- 
2.52.0


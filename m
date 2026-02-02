Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C91E7315A
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 11:25:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 230AA10E454;
	Mon,  2 Feb 2026 11:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ItoFuj8I";
	dkim-atps=neutral
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com
 [209.85.221.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0846B10E441
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 11:25:19 +0000 (UTC)
Received: by mail-wr1-f67.google.com with SMTP id
 ffacd0b85a97d-42fbc544b09so4027678f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 03:25:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770031517; x=1770636317; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5MKTz9Rw0cTE4CjIkFTkGdecbtRrYLpz4sCrXr6Qw6M=;
 b=ItoFuj8IjBYdkDKzS0GrDQ8n04xPS+Wdktie9/DBFZkaeBzVEWJSuSIdox6/QJZZGZ
 VmROsO5LzXA+lYojzfHXcrwxijJi7avKgs5Yb5bwQGsejUlwT6geHH1hgaY2i98VIfZT
 trlpsG/J8QAXfK/6InnEENVLB9zIz9JpuokDOdtOIEf4fW2+PB3sb8jRJkKxtcON0J1j
 8hkzcNKg140hsQzPWZy721YwtmQReOqzOI5Gc1i64TGyFTbjS7sXqU35epS8L/JfHGxb
 Jd/ZcyernHlj1JmXHsqgu0mBi3Lbsff3LRGBCevAp4kL6TOmLbrtSyNz9kEO5NP9dJd+
 q6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770031517; x=1770636317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5MKTz9Rw0cTE4CjIkFTkGdecbtRrYLpz4sCrXr6Qw6M=;
 b=ATzm15wsUAGHo8f/PQsX1OBKFNSlUu2AWNDKK3xuaFhvsGoQmIpC5BmbtYTtjfqFvi
 upQkCIrFCt9zd4sH9oI7XeYXDfK+LSY23Cgpa3Gsz26TexSSRLwysC/0wN4Bit0ze8VI
 IGtMKH1b8Mv0z45r5qAm0d0KKJLbjHq31+VaImLaNlE+okgyhyTg4bBBzplbbtG7BkoL
 i/2nph+qxgqISVecqqep2lHlTzBE48oR1n4nxsFcbkPcnRrr226SJqlVTzsa87lJw2kJ
 hegwOjeENWqD4UddpKE7GcbNyoM+oEkn5mKP26y32azDHUtcXade8I6sUarADwP7auh2
 0U4Q==
X-Gm-Message-State: AOJu0Yw2XOc1LDTn84xPuAF12Vh6o/oe8Y/hiBzKeE8S4Y5NL0IG+JQk
 nfx3HoNMAZsNNs+elun1Mq7O3Ii99UhntIsxvPr8ot30ISQyxTIT/5eJNp4VvdeB7IE=
X-Gm-Gg: AZuq6aIfIllF5ReDJKt0J36sK+0hwlZsCk2rb0IVnZCKeDaWv7+/hDmy8wn19kBqcyj
 p2aPoRjKnZPnXBpIRZx3mzQ3h00AUXyJfocbfLm8O+eZG4IHtjWOgIVh66kpE0WGBCZqjOxcprQ
 xZxTqatSOppJmPeoVZ9rXIY8xNopltzDgZJ7Wy+FHZYYMvrGAMSSeOtS7w9OgEMAOTfTAKm1teY
 T4SHEoLiidvNSP6jowE5Ylsha0foCbtLWn0l3+/vU1zqIkQdLRxgT3SlVrI+7mdpGBmEeLcpyfK
 X49XdAxKDh0mXALTNWdWB5Cwl6neFhNIs6DxKiPyDcYX3EMyADbVn0iL6EepmTAiQup/QCMUpjq
 j9TW1OfNdJbZKxSYZVNf+2/GmKWhoQp2uCxn/MlUdksPA0w8u4QKW4FLMF0IFWGW3+0/5tnqnjM
 m3BAX0qGhZDoCR
X-Received: by 2002:a5d:5f84:0:b0:430:f3fb:35fa with SMTP id
 ffacd0b85a97d-435f3ab32a1mr18077925f8f.57.1770031517426; 
 Mon, 02 Feb 2026 03:25:17 -0800 (PST)
Received: from Timur-Max ([109.137.72.15]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e46cesm43306225f8f.7.2026.02.02.03.25.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 03:25:17 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Alex Hung <alex.hung@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 siqueira@igalia.com, Mauro Rossi <issor.oruam@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 7/8] drm/amd/display: Enable DAC in DCE link encoder
Date: Mon,  2 Feb 2026 12:25:07 +0100
Message-ID: <20260202112508.43000-8-timur.kristof@gmail.com>
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

Ensure that the DAC output is enabled at the correct time by
moving it to the DCE link encoder similarly to how digital
outputs are enabled.

This also removes the call to DAC1EncoderControl from the DCE
HWSS, which always felt like it was a hacky solution.

Fixes: 0fbe321a93ce ("drm/amd/display: Implement DCE analog link encoders (v2)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Tested-by: Mauro Rossi <issor.oruam@gmail.com>
---
 .../drm/amd/display/dc/dce/dce_link_encoder.c | 18 +++++++++++++
 .../drm/amd/display/dc/dce/dce_link_encoder.h |  5 ++++
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 27 +++++++------------
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  2 ++
 .../drm/amd/display/dc/inc/hw/link_encoder.h  |  2 ++
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 14 +++++++++-
 6 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 8903bdb89c66..2ba3d3a3aac5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -102,6 +102,7 @@ static const struct link_encoder_funcs dce110_lnk_enc_funcs = {
 	.enable_dp_output = dce110_link_encoder_enable_dp_output,
 	.enable_dp_mst_output = dce110_link_encoder_enable_dp_mst_output,
 	.enable_lvds_output = dce110_link_encoder_enable_lvds_output,
+	.enable_analog_output = dce110_link_encoder_enable_analog_output,
 	.disable_output = dce110_link_encoder_disable_output,
 	.dp_set_lane_settings = dce110_link_encoder_dp_set_lane_settings,
 	.dp_set_phy_pattern = dce110_link_encoder_dp_set_phy_pattern,
@@ -1200,6 +1201,22 @@ void dce110_link_encoder_enable_lvds_output(
 	}
 }
 
+void dce110_link_encoder_enable_analog_output(
+	struct link_encoder *enc,
+	uint32_t pixel_clock)
+{
+	struct dce110_link_encoder *enc110 = TO_DCE110_LINK_ENC(enc);
+	enum bp_result result;
+
+	result = link_dac_encoder_control(enc110, ENCODER_CONTROL_ENABLE, pixel_clock);
+
+	if (result != BP_RESULT_OK) {
+		DC_LOG_ERROR("%s: Failed to execute VBIOS command table!\n",
+			__func__);
+		BREAK_TO_DEBUGGER();
+	}
+}
+
 /* enables DP PHY output */
 void dce110_link_encoder_enable_dp_output(
 	struct link_encoder *enc,
@@ -1818,6 +1835,7 @@ static const struct link_encoder_funcs dce60_lnk_enc_funcs = {
 	.enable_dp_output = dce60_link_encoder_enable_dp_output,
 	.enable_dp_mst_output = dce60_link_encoder_enable_dp_mst_output,
 	.enable_lvds_output = dce110_link_encoder_enable_lvds_output,
+	.enable_analog_output = dce110_link_encoder_enable_analog_output,
 	.disable_output = dce110_link_encoder_disable_output,
 	.dp_set_lane_settings = dce110_link_encoder_dp_set_lane_settings,
 	.dp_set_phy_pattern = dce60_link_encoder_dp_set_phy_pattern,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
index 9ba533aa6f88..f853e3c3fc75 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
@@ -268,6 +268,11 @@ void dce110_link_encoder_enable_lvds_output(
 	enum clock_source_id clock_source,
 	uint32_t pixel_clock);
 
+/* enables analog output from the DAC */
+void dce110_link_encoder_enable_analog_output(
+	struct link_encoder *enc,
+	uint32_t pixel_clock);
+
 /* disable PHY output */
 void dce110_link_encoder_disable_output(
 	struct link_encoder *enc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 72e4bb6883a4..84652fbacd21 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -660,20 +660,6 @@ void dce110_update_info_frame(struct pipe_ctx *pipe_ctx)
 	}
 }
 
-static void
-dce110_dac_encoder_control(struct pipe_ctx *pipe_ctx, bool enable)
-{
-	struct dc_link *link = pipe_ctx->stream->link;
-	struct dc_bios *bios = link->ctx->dc_bios;
-	struct bp_encoder_control encoder_control = {0};
-
-	encoder_control.action = enable ? ENCODER_CONTROL_ENABLE : ENCODER_CONTROL_DISABLE;
-	encoder_control.engine_id = link->link_enc->analog_engine;
-	encoder_control.pixel_clock = pipe_ctx->stream->timing.pix_clk_100hz / 10;
-
-	bios->funcs->encoder_control(bios, &encoder_control);
-}
-
 void dce110_enable_stream(struct pipe_ctx *pipe_ctx)
 {
 	enum dc_lane_count lane_count =
@@ -703,9 +689,6 @@ void dce110_enable_stream(struct pipe_ctx *pipe_ctx)
 		early_control = lane_count;
 
 	tg->funcs->set_early_control(tg, early_control);
-
-	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
-		dce110_dac_encoder_control(pipe_ctx, true);
 }
 
 static enum bp_result link_transmitter_control(
@@ -3277,6 +3260,15 @@ void dce110_enable_tmds_link_output(struct dc_link *link,
 	link->phy_state.symclk_state = SYMCLK_ON_TX_ON;
 }
 
+static void dce110_enable_analog_link_output(
+		struct dc_link *link,
+		uint32_t pix_clk_100hz)
+{
+	link->link_enc->funcs->enable_analog_output(
+			link->link_enc,
+			pix_clk_100hz);
+}
+
 void dce110_enable_dp_link_output(
 		struct dc_link *link,
 		const struct link_resource *link_res,
@@ -3414,6 +3406,7 @@ static const struct hw_sequencer_funcs dce110_funcs = {
 	.enable_lvds_link_output = dce110_enable_lvds_link_output,
 	.enable_tmds_link_output = dce110_enable_tmds_link_output,
 	.enable_dp_link_output = dce110_enable_dp_link_output,
+	.enable_analog_link_output = dce110_enable_analog_link_output,
 	.disable_link_output = dce110_disable_link_output,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 51b0f0fd8fcd..4632a5761b16 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -1184,6 +1184,8 @@ struct hw_sequencer_funcs {
 			const struct link_resource *link_res,
 			enum clock_source_id clock_source,
 			uint32_t pixel_clock);
+	void (*enable_analog_link_output)(struct dc_link *link,
+			uint32_t pixel_clock);
 	void (*disable_link_output)(struct dc_link *link,
 			const struct link_resource *link_res,
 			enum signal_type signal);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
index d795fc43dc9d..5abbf485d273 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/link_encoder.h
@@ -132,6 +132,8 @@ struct link_encoder_funcs {
 	void (*enable_lvds_output)(struct link_encoder *enc,
 		enum clock_source_id clock_source,
 		uint32_t pixel_clock);
+	void (*enable_analog_output)(struct link_encoder *enc,
+		uint32_t pixel_clock);
 	void (*disable_output)(struct link_encoder *link_enc,
 		enum signal_type signal);
 	void (*dp_set_lane_settings)(struct link_encoder *enc,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 91742bde4dc2..9b1d34c3438b 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -2155,6 +2155,18 @@ static enum dc_status enable_link_dp_mst(
 	return enable_link_dp(state, pipe_ctx);
 }
 
+static enum dc_status enable_link_analog(
+		struct dc_state *state,
+		struct pipe_ctx *pipe_ctx)
+{
+	struct dc_link *link = pipe_ctx->stream->link;
+
+	link->dc->hwss.enable_analog_link_output(
+		link, pipe_ctx->stream->timing.pix_clk_100hz);
+
+	return DC_OK;
+}
+
 static enum dc_status enable_link_virtual(struct pipe_ctx *pipe_ctx)
 {
 	struct dc_link *link = pipe_ctx->stream->link;
@@ -2210,7 +2222,7 @@ static enum dc_status enable_link(
 		status = DC_OK;
 		break;
 	case SIGNAL_TYPE_RGB:
-		status = DC_OK;
+		status = enable_link_analog(state, pipe_ctx);
 		break;
 	case SIGNAL_TYPE_VIRTUAL:
 		status = enable_link_virtual(pipe_ctx);
-- 
2.52.0


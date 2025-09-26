Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F83FCAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:03:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB96810EAC5;
	Fri, 26 Sep 2025 18:03:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TiIAaHRB";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82FB410EACE
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:03:23 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-244580523a0so27157275ad.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758909803; x=1759514603; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=csi/IHJ3F5X0PT3/d7Ns0VZiBYRGAupiDLQETpzL6UA=;
 b=TiIAaHRBfOx48xVTq1yX/Qiz8lTLpV/XSiPU58reLZdlZ3wTxHKq5e26xBdVLiI0zB
 Z/ixTRHWzjkQaCYSw439gwYEnTKp0wbZQLsGF5JJF0/FSqOVUiZKa0ZLzCeEmCzf3dWV
 k0ZSxzush/I/6aPQZQGnR7y/TUcrs/doqyBrktdp1vIGa/wR59jEo3LzVRF0bUdfJAMR
 jjkLEb+fzuDjTPCwtyBjwaydzcgtJZKbuAtU/H8kKPpK60A3F6OeFJ8/XUjYBVsuGPT8
 M/kZEnltJ7TGNQCKa3j3fZXca7qtSW0H6qHGZmBmUaoPRgddpbjMH85jG3PMFDUAnkrP
 5PaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758909803; x=1759514603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=csi/IHJ3F5X0PT3/d7Ns0VZiBYRGAupiDLQETpzL6UA=;
 b=RIKdkbIgMkckcyiouIik3ZlcrdVBp5OQDp5u6gQKCrqGUX914QwzWRouW3GHKD1G0p
 rHHhtOm8ojj8IjQZ1VWaKL17FRxhQ5hnPs/4PMfbc6gJV6cyuOg+6uGGUUm1eknoM6Kh
 E6obcZ2BksfNyY6niMe2aSLYWyEONQrt8uJf+Es70+czXX9Za7DbsgUBCqIfKelpT7JT
 neDGYEk9XXbKOOgpYvxBc6MuU375gjODck81rwx06tL77ECgt+PjU64PsaiLSW1gSENY
 9E5i7DKldeO6l9LBntGfRbNwtiOLK94zGpS5EH8b4mcF1Ba9C6v5FCW9+ccFNcnaUskA
 3jlA==
X-Gm-Message-State: AOJu0YysKyQ1cXD+oO+xNAFmIERCsCf4VZf+mQnubCPKVheFWJhkK3og
 W1Zgk1Uo41VmzjITgJWNRFw09R1PnRtrd0xNhFkUgLYQrpLAGFfhlh3osu16XA==
X-Gm-Gg: ASbGncuS3BprewU4EbYEWNHsVegp7vbcIYtycSkxBXzdXi2T9AgnEBhcFVrmCrI9DET
 y82nWW8zlnf+jJjofd61OgpB52No0JJCl07Tt1OTrnsIpVla6tlbsmgLCn5ig8Nx5UoAnYmQD5S
 zvOL2J99XDcvURy7gveHHC5L2fxAxMmeTnBQWSeuNc2n79xWhUh/fv86IDw90PcDU0URBnH3ZKv
 qOizAyua9s3Ow59rtLhZO/ig8/kmj/nyffN6XnzgfR5M+Gl638CMRTcutq3Jir1P/B4ifzzrqtU
 Dir/mTexAaNXzikSfygpgm7jonT4TqEuO66JKtT4Vv5s/pLg6MO6OFJjIicCeTscmh3FQLpYJzS
 hbWP3nxyZQP/QcNin5cS13mWKSXosTeftDC5bH76efuYaj1jwpGxwv/Py6AQN/nstgq+nep1PIU
 aJm/eJVsoejSapviT8wzOVrGv+Z497tA==
X-Google-Smtp-Source: AGHT+IH2gfxfIBzC2/b1S23IKJE9GXfB3RMKZvjrvnt2fvH7HrMBjIGP3bmaXHTMmcq2u0PYtPObeQ==
X-Received: by 2002:a17:903:2305:b0:269:a2bc:799f with SMTP id
 d9443c01a7336-27ed4a31680mr89876685ad.29.1758909802922; 
 Fri, 26 Sep 2025 11:03:22 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27f1d2ef8c5sm22186835ad.151.2025.09.26.11.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:03:22 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 13/23] drm/amd/display: Support DAC in dce110_hwseq
Date: Fri, 26 Sep 2025 20:01:53 +0200
Message-ID: <20250926180203.16690-14-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250926180203.16690-1-timur.kristof@gmail.com>
References: <20250926180203.16690-1-timur.kristof@gmail.com>
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

The dce110_hwseq is used by all DCE hardware,
so add the DAC support here.

When enabling/disabling a stream for a RGB signal,
this will call the VBIOS to enable/disable the DAC.
Additionally, when applying the controller context,
call SelectCRTC_Source from VBIOS in order to
direct the CRTC output to the DAC.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 75 ++++++++++++++++++-
 1 file changed, 73 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 24184b4eb352..975913375d05 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -659,6 +659,20 @@ void dce110_update_info_frame(struct pipe_ctx *pipe_ctx)
 	}
 }
 
+static void
+dce110_dac_encoder_control(struct pipe_ctx *pipe_ctx, bool enable)
+{
+	struct dc_link *link = pipe_ctx->stream->link;
+	struct dc_bios *bios = link->ctx->dc_bios;
+	struct bp_encoder_control encoder_control = {0};
+
+	encoder_control.action = enable ? ENCODER_CONTROL_ENABLE : ENCODER_CONTROL_DISABLE;
+	encoder_control.engine_id = link->link_enc->analog_engine;
+	encoder_control.pixel_clock = pipe_ctx->stream->timing.pix_clk_100hz / 10;
+
+	bios->funcs->encoder_control(bios, &encoder_control);
+}
+
 void dce110_enable_stream(struct pipe_ctx *pipe_ctx)
 {
 	enum dc_lane_count lane_count =
@@ -689,6 +703,9 @@ void dce110_enable_stream(struct pipe_ctx *pipe_ctx)
 		early_control = lane_count;
 
 	tg->funcs->set_early_control(tg, early_control);
+
+	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
+		dce110_dac_encoder_control(pipe_ctx, true);
 }
 
 static enum bp_result link_transmitter_control(
@@ -1176,7 +1193,8 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 		pipe_ctx->stream_res.stream_enc->funcs->stop_dp_info_packets(
 			pipe_ctx->stream_res.stream_enc);
 
-	dc->hwss.disable_audio_stream(pipe_ctx);
+	if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
+		dc->hwss.disable_audio_stream(pipe_ctx);
 
 	link_hwss->reset_stream_encoder(pipe_ctx);
 
@@ -1196,6 +1214,9 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 		dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_enc_inst,
 					       link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 	}
+
+	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
+		dce110_dac_encoder_control(pipe_ctx, false);
 }
 
 void dce110_unblank_stream(struct pipe_ctx *pipe_ctx,
@@ -1581,6 +1602,51 @@ static enum dc_status dce110_enable_stream_timing(
 	return DC_OK;
 }
 
+static void
+dce110_select_crtc_source(struct pipe_ctx *pipe_ctx)
+{
+	struct dc_link *link = pipe_ctx->stream->link;
+	struct dc_bios *bios = link->ctx->dc_bios;
+	struct bp_crtc_source_select crtc_source_select = {0};
+	enum engine_id engine_id = link->link_enc->preferred_engine;
+	uint8_t bit_depth;
+
+	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
+		engine_id = link->link_enc->analog_engine;
+
+	switch (pipe_ctx->stream->timing.display_color_depth) {
+	case COLOR_DEPTH_UNDEFINED:
+		bit_depth = 0;
+		break;
+	case COLOR_DEPTH_666:
+		bit_depth = 6;
+		break;
+	default:
+	case COLOR_DEPTH_888:
+		bit_depth = 8;
+		break;
+	case COLOR_DEPTH_101010:
+		bit_depth = 10;
+		break;
+	case COLOR_DEPTH_121212:
+		bit_depth = 12;
+		break;
+	case COLOR_DEPTH_141414:
+		bit_depth = 14;
+		break;
+	case COLOR_DEPTH_161616:
+		bit_depth = 16;
+		break;
+	}
+
+	crtc_source_select.controller_id = CONTROLLER_ID_D0 + pipe_ctx->stream_res.tg->inst;
+	crtc_source_select.bit_depth = bit_depth;
+	crtc_source_select.engine_id = engine_id;
+	crtc_source_select.sink_signal = pipe_ctx->stream->signal;
+
+	bios->funcs->select_crtc_source(bios, &crtc_source_select);
+}
+
 enum dc_status dce110_apply_single_controller_ctx_to_hw(
 		struct pipe_ctx *pipe_ctx,
 		struct dc_state *context,
@@ -1600,6 +1666,10 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 		hws->funcs.disable_stream_gating(dc, pipe_ctx);
 	}
 
+	if (pipe_ctx->stream->signal == SIGNAL_TYPE_RGB) {
+		dce110_select_crtc_source(pipe_ctx);
+	}
+
 	if (pipe_ctx->stream_res.audio != NULL) {
 		struct audio_output audio_output = {0};
 
@@ -1679,7 +1749,8 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 		pipe_ctx->stream_res.tg->funcs->set_static_screen_control(
 				pipe_ctx->stream_res.tg, event_triggers, 2);
 
-	if (!dc_is_virtual_signal(pipe_ctx->stream->signal))
+	if (!dc_is_virtual_signal(pipe_ctx->stream->signal) &&
+		!dc_is_rgb_signal(pipe_ctx->stream->signal))
 		pipe_ctx->stream_res.stream_enc->funcs->dig_connect_to_otg(
 			pipe_ctx->stream_res.stream_enc,
 			pipe_ctx->stream_res.tg->inst);
-- 
2.51.0


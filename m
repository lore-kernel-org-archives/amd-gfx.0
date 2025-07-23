Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68EA6C87FCC
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 15:58:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FB2B10E80B;
	Wed, 23 Jul 2025 15:58:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DkxqbAXU";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A623B10E80C
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 15:58:31 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4561ca74829so75622175e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 08:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286310; x=1753891110; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0RGXvlUNkk/YL1sdJJYKS2dJUEu+ZQpbtYjx+RT8DDQ=;
 b=DkxqbAXU3ctqYEeZM++GEncgooHpGq7mhBK+Gin7TdsCuVTe3f2RGycn5rFHtsIzMJ
 ylB4jXkwhei+4CvamutpJnaGaG53yiOp/pNPUUhbkFRfrsuEpJRwXsr+BPelFk3W96Co
 TOnCuMhvmgmDwD4/IQbnrPLrBEc0ahIMbL9q3eiRIdkdci3zMZ/TzoEGRZlcA9sWP8v2
 TYRDbHb8bqDW4xnrvqsSE8It6P/lRYRO/b1OL3tXSqgP7opyMEgq2LAxGQz+BHt3sPZS
 ZPI4hMPDJC9rn6d2iJghqmWQpQbLxh8FilpL/+CrUIY3T9tjqajJPRRimlka/hoGHenQ
 nphA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286310; x=1753891110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0RGXvlUNkk/YL1sdJJYKS2dJUEu+ZQpbtYjx+RT8DDQ=;
 b=JUC0Kk58IixylTqpMjE//5qdc20SzdIlFTye61TI0NtrzQFkMwcBTo0fzYHQBO+Wcy
 Wcetqkkp11X8ae4gpZZfrAr8wsdmCHY1xP0a6dJkIP0eKJWnooA0W7qo7pB7rvoVTx/m
 JXGT4qJH/Nu1OSru9/HaJtcAe+gAyxzM82pkJA/TmIo4vRgeNcb44RfVw0aV0rAwHVvT
 JC28skmVuCMeQ0hfVx9euoCY3Sn8Xr5XNlwkl1GY/nFroeaPZX1cwNeSSRkeYnMnpXFp
 EXALIMJraE3wvvGmt6bfjC9CFXMeSlRGxuOpuesJ/HYrixMfjl9aUrRInkYHUVTm+tMy
 0d9Q==
X-Gm-Message-State: AOJu0YxxSRCyaZcRgAex85cENenr8TAGmKQtMjEYn1zJh8GpnABvjDRO
 Trp09vsL+q9UTCL7oQ2t+tlzED4fUklvISu5Qq0/DBVSW+gDJ2+gntyB3kemlA==
X-Gm-Gg: ASbGncsbetz2uVtvsgQoi+WjyfmD/LhVKUIrZyFfXEZZYawKdJIbWvgpwNl7VSo6AVZ
 T0F29jN/mh/tA83JwMWVliSJOy6va00c1JUtsEaIYZ0XvybeTHJHuZG62xx6YLS+Dmz91W0napS
 P53fADbYIo8RQu3BCSV5Ql6AEGq8i37HdhqD9QZX8SeHCF3Tja5G40TF1bmguUkK7SVDsNhw4Pt
 oIiOOX1YVQB8hCPbL2RROfaQq88O1OGyBeQXdxO3X4bGPmAPqEgLa3dn0kJqcmioAvEwJfM+6th
 UksuJNQ4els9aULz/I0zuYK3Ndgz6RYidDvT31hk6AhawUqU8SeLyZK32X2YGDI8AZtP7K0m9Nd
 yX3ukNF+4udbe2pyi7ksFVK45W7AD/ffDsUcCXq4w9YOCJUlnXmz4hJs216afY0P20xPTMj9k1X
 IdkHGV5BHtcgdgxQ4SP7KowyCZGg==
X-Google-Smtp-Source: AGHT+IHgo1T73BaanEHrZM7JJi3YPdNN8P/cSKqF0YUtohIVEho+riHJ1VhLSbugONRWY55NtqPpGw==
X-Received: by 2002:a05:600c:a08e:b0:450:30e4:bdf6 with SMTP id
 5b1f17b1804b1-45868d43d42mr30433675e9.19.1753286309703; 
 Wed, 23 Jul 2025 08:58:29 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4D24D8FC008443E005DD6C3C62.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:8443:e005:dd6c:3c62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bf99sm16710468f8f.32.2025.07.23.08.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:58:29 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 12/20] drm/amd/display: Support DAC in dce110_hwseq
Date: Wed, 23 Jul 2025 17:58:05 +0200
Message-ID: <20250723155813.9101-13-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250723155813.9101-1-timur.kristof@gmail.com>
References: <20250723155813.9101-1-timur.kristof@gmail.com>
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
index 4ea13d0bf815..cc1f899f37e8 100644
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
@@ -688,6 +702,9 @@ void dce110_enable_stream(struct pipe_ctx *pipe_ctx)
 		early_control = lane_count;
 
 	tg->funcs->set_early_control(tg, early_control);
+
+	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
+		dce110_dac_encoder_control(pipe_ctx, true);
 }
 
 static enum bp_result link_transmitter_control(
@@ -1175,7 +1192,8 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 		pipe_ctx->stream_res.stream_enc->funcs->stop_dp_info_packets(
 			pipe_ctx->stream_res.stream_enc);
 
-	dc->hwss.disable_audio_stream(pipe_ctx);
+	if (!dc_is_rgb_signal(pipe_ctx->stream->signal))
+		dc->hwss.disable_audio_stream(pipe_ctx);
 
 	link_hwss->reset_stream_encoder(pipe_ctx);
 
@@ -1195,6 +1213,9 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 		dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_enc_inst,
 					       link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 	}
+
+	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
+		dce110_dac_encoder_control(pipe_ctx, false);
 }
 
 void dce110_unblank_stream(struct pipe_ctx *pipe_ctx,
@@ -1580,6 +1601,51 @@ static enum dc_status dce110_enable_stream_timing(
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
@@ -1599,6 +1665,10 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 		hws->funcs.disable_stream_gating(dc, pipe_ctx);
 	}
 
+	if (pipe_ctx->stream->signal == SIGNAL_TYPE_RGB) {
+		dce110_select_crtc_source(pipe_ctx);
+	}
+
 	if (pipe_ctx->stream_res.audio != NULL) {
 		struct audio_output audio_output = {0};
 
@@ -1678,7 +1748,8 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 		pipe_ctx->stream_res.tg->funcs->set_static_screen_control(
 				pipe_ctx->stream_res.tg, event_triggers, 2);
 
-	if (!dc_is_virtual_signal(pipe_ctx->stream->signal))
+	if (!dc_is_virtual_signal(pipe_ctx->stream->signal) &&
+		!dc_is_rgb_signal(pipe_ctx->stream->signal))
 		pipe_ctx->stream_res.stream_enc->funcs->dig_connect_to_otg(
 			pipe_ctx->stream_res.stream_enc,
 			pipe_ctx->stream_res.tg->inst);
-- 
2.50.1


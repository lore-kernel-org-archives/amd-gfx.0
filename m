Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCA4D3ABDA
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Dec 2025 02:31:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9743D10EBDB;
	Sat,  6 Dec 2025 02:31:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CR/K4LfV";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0ECA10EBDB
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Dec 2025 02:31:13 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4779cc419b2so30843465e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Dec 2025 18:31:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764988272; x=1765593072; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FsecgqOvf2x4EB1xpNhLjZs3KXtrjbrmpgphI99E5lg=;
 b=CR/K4LfVRo4kWDMPziinUaRfsZDJmHmUqp1IvpQ5hWbe5vtqdWsTdQkXS/yFjIbHmJ
 /Mzc0O2RoJV+Lpp0+ueCSG3wSwIBpyu9fIenpXYXHmgTYlVp20LtwzIexCz6zdn/6oxC
 jTPWk2WdQ7Ku2WjojhZIl12zYsGL9XytfnHaFlA9Md/ToV6gstMb9c7CuvDdB8Z5BdUh
 xxKU1wFLijLSUI8Jx4cuofc+/VCbmLUqngaqDH3iGuU0pmNBzX0fcrVv8gV7bcXQvzIO
 zaA1WFKvB1ZnwRJhTXal63w58geKsqC5prhODRBWBF6l405+sJKkMhTZ5TG/5wJj8DTV
 Rl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764988272; x=1765593072;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FsecgqOvf2x4EB1xpNhLjZs3KXtrjbrmpgphI99E5lg=;
 b=XGS4c/67u1C49D/j8Xk2Bgfe/3qt+/9xKR6nZrGAKiPLaudYEvYt706KyBPRwxxTNV
 davuCa59toNrr7PuXU8nJoUtE0OE91uXO2YPYB+YJAe8DhyCd9r0NhFJQv2DgqWaa9rG
 klHQgu0HFwtIKVSVmh2VsIQ1HVvRN1ny5wyK+8qYUco10g4eH/uRZ/7ADEqkblqLX48a
 ezBkWHGGxO+QXaY+kci4WewAhLlQXzovN33Lh6mCVCM0fZMjwWOBVvw+XqoRCrGKNn2Q
 J/AemYk03/PrKi7BbVnj2EAnt7OZRVVCnZXbP3tkABuSO2ovzQNeYkYPOUu3Jv17I0iA
 Gd0g==
X-Gm-Message-State: AOJu0YwNyXQ4pCnU9CyQNRDWWcEWGM6j8GQYMyoilfvIbYRK2F+iBXvT
 ZgBnuSn2fGWwIQRA51b6jg3idxJ/m9kPvl5dTOTxAS1wkclL4NaL4/2sNIYf8w==
X-Gm-Gg: ASbGncuGvqqjNx0R+TU6NdnhsP2ox+m3fWvUS4dleExJP8pwVfwABPV+VT/t08HEXzK
 JJ7BdaO4g38yAdc2XfYW/HHr9GvZAJuWXlgVU20a2HAXmfNn7DZL5Dgmjbrs9sbNZoL83pYwEmY
 FLvnlVcESMOiU0zDJLzw5ZvjosrZ6lWSqgvtu3+gJJwseDgeZAGbbca8yd2UWhoGk3P5/ycvhJx
 Ok4JsjCPQwYhUu9MUGr0nMsx5qoc9nuypRF7SV2fvcCDYszaD1jKWYmsCY5gQ4bBWBw1YFj/3jb
 zR0hBbCr6wP5a6SOLzvVAOkR4ruR1uhApRY6wwxuRXGMhptRHxZZGFCyAVkdxa5055TXRnY1Mn0
 1WtHcNnAElAgE0oO8z6zpdaaOlBrivaM9T8GboR5K+VfjmuMSylRMQKptpuoIeERy0Jmp0Iuca4
 psAmu7qiXsNw+dKpmnjYuKeVuXdhW2A/AXrpv3WKqsjWSrwEK94B29bAACZRcso5YuwmPFU8bHg
 zbFw/Vz60cx33BHo/A=
X-Google-Smtp-Source: AGHT+IGJUC0/OhYhehWkD0JW48wPPye0JyT3xNRxHwoy7chfS3hBcmptByZ6DZZsXaJ5EeOy/bX6/w==
X-Received: by 2002:a05:6000:40cb:b0:42f:760a:764e with SMTP id
 ffacd0b85a97d-42f89f61c0cmr1204721f8f.32.1764988272223; 
 Fri, 05 Dec 2025 18:31:12 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24E095001DEDB2C8B6514266.dsl.pool.telekom.hu.
 [2001:4c4e:24e0:9500:1ded:b2c8:b651:4266])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbff320sm12133689f8f.18.2025.12.05.18.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 18:31:11 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 alexander.deucher@amd.com, siqueira@igalia.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/5] drm/amd/display: Correct color depth for SelectCRTC_Source
Date: Sat,  6 Dec 2025 03:31:03 +0100
Message-ID: <20251206023106.8875-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251206023106.8875-1-timur.kristof@gmail.com>
References: <20251206023106.8875-1-timur.kristof@gmail.com>
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

Pass the correct enum values as expected by the VBIOS.
Previously the actual bit depth integer value was passed,
which was a mistake.

Fixes: 523aabc65da0 ("drm/amd/display: Add SelectCRTC_Source to BIOS parser")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../drm/amd/display/dc/bios/command_table.c   | 25 ++++++++++++++++-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 28 +------------------
 .../amd/display/include/bios_parser_types.h   |  2 +-
 3 files changed, 26 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index 22457f417e65..d56c0d3763dd 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -1797,7 +1797,30 @@ static enum bp_result select_crtc_source_v3(
 		&params.ucEncodeMode))
 		return BP_RESULT_BADINPUT;
 
-	params.ucDstBpc = bp_params->bit_depth;
+	switch (bp_params->color_depth) {
+	case COLOR_DEPTH_UNDEFINED:
+		params.ucDstBpc = PANEL_BPC_UNDEFINE;
+		break;
+	case COLOR_DEPTH_666:
+		params.ucDstBpc = PANEL_6BIT_PER_COLOR;
+		break;
+	default:
+	case COLOR_DEPTH_888:
+		params.ucDstBpc = PANEL_8BIT_PER_COLOR;
+		break;
+	case COLOR_DEPTH_101010:
+		params.ucDstBpc = PANEL_10BIT_PER_COLOR;
+		break;
+	case COLOR_DEPTH_121212:
+		params.ucDstBpc = PANEL_12BIT_PER_COLOR;
+		break;
+	case COLOR_DEPTH_141414:
+		dm_error("14-bit color not supported by SelectCRTC_Source v3\n");
+		break;
+	case COLOR_DEPTH_161616:
+		params.ucDstBpc = PANEL_16BIT_PER_COLOR;
+		break;
+	}
 
 	if (EXEC_BIOS_CMD_TABLE(SelectCRTC_Source, params))
 		result = BP_RESULT_OK;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 94e66d96c403..6f6eacf62b5f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1611,38 +1611,12 @@ dce110_select_crtc_source(struct pipe_ctx *pipe_ctx)
 	struct dc_bios *bios = link->ctx->dc_bios;
 	struct bp_crtc_source_select crtc_source_select = {0};
 	enum engine_id engine_id = link->link_enc->preferred_engine;
-	uint8_t bit_depth;
 
 	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
 		engine_id = link->link_enc->analog_engine;
 
-	switch (pipe_ctx->stream->timing.display_color_depth) {
-	case COLOR_DEPTH_UNDEFINED:
-		bit_depth = 0;
-		break;
-	case COLOR_DEPTH_666:
-		bit_depth = 6;
-		break;
-	default:
-	case COLOR_DEPTH_888:
-		bit_depth = 8;
-		break;
-	case COLOR_DEPTH_101010:
-		bit_depth = 10;
-		break;
-	case COLOR_DEPTH_121212:
-		bit_depth = 12;
-		break;
-	case COLOR_DEPTH_141414:
-		bit_depth = 14;
-		break;
-	case COLOR_DEPTH_161616:
-		bit_depth = 16;
-		break;
-	}
-
 	crtc_source_select.controller_id = CONTROLLER_ID_D0 + pipe_ctx->stream_res.tg->inst;
-	crtc_source_select.bit_depth = bit_depth;
+	crtc_source_select.color_depth = pipe_ctx->stream->timing.display_color_depth;
 	crtc_source_select.engine_id = engine_id;
 	crtc_source_select.sink_signal = pipe_ctx->stream->signal;
 
diff --git a/drivers/gpu/drm/amd/display/include/bios_parser_types.h b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
index 973b6bdbac63..f40dc612ec73 100644
--- a/drivers/gpu/drm/amd/display/include/bios_parser_types.h
+++ b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
@@ -136,7 +136,7 @@ struct bp_crtc_source_select {
 	enum engine_id engine_id;
 	enum controller_id controller_id;
 	enum signal_type sink_signal;
-	uint8_t bit_depth;
+	enum dc_color_depth color_depth;
 };
 
 struct bp_transmitter_control {
-- 
2.52.0


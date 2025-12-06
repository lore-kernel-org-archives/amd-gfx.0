Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9197DD3ABE5
	for <amd-gfx@archiver.kernel.org>; Sat,  6 Dec 2025 02:31:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0AE710EBDD;
	Sat,  6 Dec 2025 02:31:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JE2b0Uzb";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1169D10EBDB
 for <amd-gfx@lists.freedesktop.org>; Sat,  6 Dec 2025 02:31:16 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-42b38de7940so1465111f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Dec 2025 18:31:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764988274; x=1765593074; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CZ9Guz3A4G4mZu/RIkdKbfn60j+XSBBzHteqOeciYKs=;
 b=JE2b0UzbiFL/3YV8N4rSAMBY74d4MzYjGmCXe6FzMzPyVwBbnBdp6Rj+3mszGyiNWX
 tZ82BtIq9Q7DTRqpaVb6y/T1rpdkq51iJWH4pAxKEfSSi2KycXKvbcL9ICFIwec+9KBS
 0DN2I2R8YNqupLI+tNXnucXMEX+3PFFbEAcmWLcD7NPdaGHuGVvcCoktDeQ80yOJ6lSF
 sklA2KZCtmh8QU4AYbnYXMQHKVD62gAr6QPJ6201w0A5DoDV8YqO0EDrs2NLPP5B47Yf
 c3Wp06ZRFuuUwf42zQDmxWYbKBdX0nNKVwdVXAGK7Z7AGr3qyO6Ogp1ebqLpoDfrUIxi
 EMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764988274; x=1765593074;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CZ9Guz3A4G4mZu/RIkdKbfn60j+XSBBzHteqOeciYKs=;
 b=Cg41IisGAqZKjbpRA2bWKqquqKAdqIFNel+cR7xp/jFl3o1Al+CfF5JtnYh4aoycRN
 Jfr4vWGoPZ2CNuzW42Yjr5+q7RZ1cV1fwqcJ4VU18qxa2Z72HzQzXdXt6jzI6LYcU7uv
 4JFFht+2q2WwvilzqYkbWi53LtQ/tAvSKtaOVUeVN365ar2fjjAY4NI5l5oJS0tP8k2z
 L4Edtr24ifHkNSCkgMyPOBzMYlLRE5zWQqH794zglOWXVoDO6a8eaLgAvbtjzYn16PUW
 Puq+2atPPaFkxnnk6wXIfomPY/QFUFdanNqEvP1PBEq3rEtZ0XPjbHHMTs+cgEB5kCYv
 k/Ww==
X-Gm-Message-State: AOJu0YxFCZZI2AaGuhr+uM72u+02DT8NqfZ+gKBHKVZdmJNhbPiJIylZ
 aAVTeJx3aZKnHT5cTd3GE/tlStjlcuJqrjLH8T7TtfkpdT8YSOnwjGQdJLJAZA==
X-Gm-Gg: ASbGncsaAIaHsE3ek0OuRcqY1n9wrnZhwOLZa1Yx4jeE3DKMe81//1PnvFNNMYpBT8h
 9eAZRYejpDF57aY1tNZX5LfnVozjt1xjycP3CvukDFMeoHbELp9qTNIvuqtfPiItQ/mSJuaipDV
 OxDa8fJ4I55dpo16JK4btqiCZXBUVnv7LyV1pLOL7GoMzRYCle54BBe2TEfyvGiBHhsCLvd13mD
 4BTP/xWvdx/u8bDJXkESb3jkSJw8K2CJHKkentwdWs+Wgio6oHRYVjrCNBZEvk5+2EyDrNniXsu
 vMYQpA6xdOirlwTcsmsPnPt9gl0ndTmd4YUsjGyElHA9VfvxdAJhwRzwUiYtLf/QD/77r7Oen9k
 bLMbyqPpjGsFN+HzJ9y+4Oa7QMGEZkZzEhMlp/BZL4l2oAQy4n2CfZPL2MR+AmPUx/61jKEJBZj
 dKgvsGRtbRzT8NAThptgnzowzjBhTDY+OWKkqYamAWebezdH+ckWGBl1TJtbrDAgN9lC9suF+/n
 wgJt63ZtdOOayci4Sc=
X-Google-Smtp-Source: AGHT+IGwc8jk+BSnUu1H65/MaTGbqAxb6s8KDx5JcKqRNm62fSI523RuADgshb77AQWqmiZDgPLRTg==
X-Received: by 2002:a05:6000:200b:b0:426:d5a0:bac8 with SMTP id
 ffacd0b85a97d-42f89f633ecmr945712f8f.56.1764988274446; 
 Fri, 05 Dec 2025 18:31:14 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24E095001DEDB2C8B6514266.dsl.pool.telekom.hu.
 [2001:4c4e:24e0:9500:1ded:b2c8:b651:4266])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7cbff320sm12133689f8f.18.2025.12.05.18.31.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Dec 2025 18:31:13 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Hung <alex.hung@amd.com>,
 Harry Wentland <Harry.Wentland@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 alexander.deucher@amd.com, siqueira@igalia.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/5] drm/amd/display: Add missing encoder setup to
 DACnEncoderControl
Date: Sat,  6 Dec 2025 03:31:04 +0100
Message-ID: <20251206023106.8875-4-timur.kristof@gmail.com>
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

Apparently the DAC encoder needs to be set up before use.
The BIOS parser in DC did not support this so I assumed it was
not necessary, but the DAC doesn't work without it on some GPUs.

Fixes: 6c51114c17d6 ("drm/amd/display: Hook up DAC to bios_parser_encoder_control")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |  4 ++--
 .../drm/amd/display/dc/bios/command_table.c   | 19 +++++++++++--------
 .../drm/amd/display/dc/bios/command_table.h   |  4 ++--
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 4120d6c4c5e4..7c49a4d59cd9 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -763,14 +763,14 @@ static enum bp_result bios_parser_encoder_control(
 			return BP_RESULT_FAILURE;
 
 		return bp->cmd_tbl.dac1_encoder_control(
-			bp, cntl->action == ENCODER_CONTROL_ENABLE,
+			bp, cntl->action,
 			cntl->pixel_clock, ATOM_DAC1_PS2);
 	} else if (cntl->engine_id == ENGINE_ID_DACB) {
 		if (!bp->cmd_tbl.dac2_encoder_control)
 			return BP_RESULT_FAILURE;
 
 		return bp->cmd_tbl.dac2_encoder_control(
-			bp, cntl->action == ENCODER_CONTROL_ENABLE,
+			bp, cntl->action,
 			cntl->pixel_clock, ATOM_DAC1_PS2);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index d56c0d3763dd..76a3559f0ddc 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -1838,12 +1838,12 @@ static enum bp_result select_crtc_source_v3(
 
 static enum bp_result dac1_encoder_control_v1(
 	struct bios_parser *bp,
-	bool enable,
+	enum bp_encoder_control_action action,
 	uint32_t pixel_clock,
 	uint8_t dac_standard);
 static enum bp_result dac2_encoder_control_v1(
 	struct bios_parser *bp,
-	bool enable,
+	enum bp_encoder_control_action action,
 	uint32_t pixel_clock,
 	uint8_t dac_standard);
 
@@ -1869,12 +1869,15 @@ static void init_dac_encoder_control(struct bios_parser *bp)
 
 static void dac_encoder_control_prepare_params(
 	DAC_ENCODER_CONTROL_PS_ALLOCATION *params,
-	bool enable,
+	enum bp_encoder_control_action action,
 	uint32_t pixel_clock,
 	uint8_t dac_standard)
 {
 	params->ucDacStandard = dac_standard;
-	if (enable)
+	if (action == ENCODER_CONTROL_SETUP ||
+	    action == ENCODER_CONTROL_INIT)
+		params->ucAction = ATOM_ENCODER_INIT;
+	else if (action == ENCODER_CONTROL_ENABLE)
 		params->ucAction = ATOM_ENABLE;
 	else
 		params->ucAction = ATOM_DISABLE;
@@ -1887,7 +1890,7 @@ static void dac_encoder_control_prepare_params(
 
 static enum bp_result dac1_encoder_control_v1(
 	struct bios_parser *bp,
-	bool enable,
+	enum bp_encoder_control_action action,
 	uint32_t pixel_clock,
 	uint8_t dac_standard)
 {
@@ -1896,7 +1899,7 @@ static enum bp_result dac1_encoder_control_v1(
 
 	dac_encoder_control_prepare_params(
 		&params,
-		enable,
+		action,
 		pixel_clock,
 		dac_standard);
 
@@ -1908,7 +1911,7 @@ static enum bp_result dac1_encoder_control_v1(
 
 static enum bp_result dac2_encoder_control_v1(
 	struct bios_parser *bp,
-	bool enable,
+	enum bp_encoder_control_action action,
 	uint32_t pixel_clock,
 	uint8_t dac_standard)
 {
@@ -1917,7 +1920,7 @@ static enum bp_result dac2_encoder_control_v1(
 
 	dac_encoder_control_prepare_params(
 		&params,
-		enable,
+		action,
 		pixel_clock,
 		dac_standard);
 
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.h b/drivers/gpu/drm/amd/display/dc/bios/command_table.h
index e89b1ba0048b..78bdbcaa61c8 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.h
@@ -57,12 +57,12 @@ struct cmd_tbl {
 		struct bp_crtc_source_select *bp_params);
 	enum bp_result (*dac1_encoder_control)(
 		struct bios_parser *bp,
-		bool enable,
+		enum bp_encoder_control_action action,
 		uint32_t pixel_clock,
 		uint8_t dac_standard);
 	enum bp_result (*dac2_encoder_control)(
 		struct bios_parser *bp,
-		bool enable,
+		enum bp_encoder_control_action action,
 		uint32_t pixel_clock,
 		uint8_t dac_standard);
 	enum bp_result (*dac1_output_control)(
-- 
2.52.0


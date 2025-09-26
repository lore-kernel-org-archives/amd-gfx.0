Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96BCDCAC5B8
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:02:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2917310EAB9;
	Fri, 26 Sep 2025 18:02:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PO/zWDqs";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B43A10EAB9
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:02:42 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-b54a74f9150so2280945a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758909762; x=1759514562; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lnK60gIyS3cBkY6FyWyjwY3/2WQyfR7hGwBAFoozXig=;
 b=PO/zWDqs/DUhCM/SJiwjdezimyaBV3urcc5E0IQj9EoaSXpYz8QiNz3+3Kryo6fQh5
 XSsHBW2ucuQ83iz9IhM/ywLL47fsIss3CV4ACsnN19/HpQbvRImZUe7AlTKUzhL5ANTv
 Yylw9xXTVFa+hDqnagpA/vISz2ye9hFmZVVDGutP8LY+D2TIYbnkNrgq5ec/vtRISl8o
 VmF9g5ZibfXo8wC0vBb8YWi0tRyaz8+x3EKz/iACLVLat3caCmuDf1tUdKLoWq12gMg5
 QbVi8fvYEifRrKjH2QwN0aVx6dtTlrSVjiuR4WutuQB84M5f0iuNoIyxg47ol5s5oeGJ
 +LWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758909762; x=1759514562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lnK60gIyS3cBkY6FyWyjwY3/2WQyfR7hGwBAFoozXig=;
 b=IikfkyLEvPCIw9jzsYKF2G4cnwvvXimUnDvsraKIfG1J65/6fwv0gpgCCDLBb/Bzv2
 i5TP32X2vqLYu6NYqYcJ1XrwOqfDzdqsaW4l55kO28N75d/UboKngpyBCbjAG+V3BA2I
 XP6WscEYN2VjQW8KT9C0OxbHmLcgrok1/bbZcaZOQSnks+r0dR+O/oACl7YXuaqB9wTm
 iotWQJ5DTncBW0Y+fnN6gr5Vz3AiI8WdNACsMfHrE+bkZDJju3tf5cui47BPALWkDrw0
 pVBvVM/al1Epan/M2ylKUiTzN3Ki5GYc5RezCRpFGCuXutKmc7qaQseDJtDNWr9XvWXU
 /wqw==
X-Gm-Message-State: AOJu0YyD5mxZ7UhEX/JmlU25GTkPUZrssPLk4vLY8gRPGoyYoqDwEwxw
 Tr/C2AREDWij6/SdjJZL+5EN3CCwYTwsjE/rnP9I8lMROy4peljKEKPxnPyatA==
X-Gm-Gg: ASbGncvTFTVleKNFffRY4RwsqKkTPy57W3CSGKV98xEC4KJR1BoibweabV/2XdoqXtv
 t4FCDX/nlE6tNmKRcrooG3mLGOppS5hP5/0rhW9s6tV3n1y790tSMQO3uv4lerYJjAlVeHN+dPW
 58XvzEb0oxXIDBrF+yzAA6OS+VHhg7+g+eXtGY/CRXzUbFDFAbj1217tkCy9Dwn/bwA2Pz8NzmN
 zljx3T6LCRONeP1MTNOCJxeoW0wk5zeI1EuCqtXPCTIvNkc8VSnqy/p5jx/KfLVQlbb6jqRBbOZ
 LGqoWCGc8HUDBYPiHEtescOmqkPDR3ZBNnzKo+5kJFpy50dVUtc4t1C/pa7g39zoPzK6HRa4P3e
 0TWpCzDwJkGCxmn+xe2iFW0ySIlCTayug0f1si0eqT39yqzzhjNOmKF1K1Fn+a3oHi2LhonlxKt
 SjXYoQHs0hQJHKpFGgSB/1BJdcLuNbFg==
X-Google-Smtp-Source: AGHT+IFYi6EpCNhAO3tXOvRYl5zX4tl/mHVoQ8/BxAiWNja1fCAOreF3+jpD7UmVIBnbgpwyYkM9bA==
X-Received: by 2002:a17:903:4b04:b0:271:479d:3de2 with SMTP id
 d9443c01a7336-27ed4a1a2cdmr80944705ad.13.1758909761801; 
 Fri, 26 Sep 2025 11:02:41 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27f1d2ef8c5sm22186835ad.151.2025.09.26.11.02.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:02:41 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 05/23] drm/amd/display: Add SelectCRTC_Source to BIOS parser
Date: Fri, 26 Sep 2025 20:01:45 +0200
Message-ID: <20250926180203.16690-6-timur.kristof@gmail.com>
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

The SelectCRTC_Source command will be used to change which CRTC
should be connected to which encoder.

For reference, see the legacy display code:
amdgpu_atombios_encoder_set_crtc_source

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser.c |  14 ++
 .../drm/amd/display/dc/bios/command_table.c   | 194 ++++++++++++++++++
 .../drm/amd/display/dc/bios/command_table.h   |   3 +
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |   3 +
 .../amd/display/include/bios_parser_types.h   |   6 +-
 5 files changed, 215 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 318be0bb5549..c7875edea321 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -736,6 +736,18 @@ static enum bp_result bios_parser_transmitter_control(
 	return bp->cmd_tbl.transmitter_control(bp, cntl);
 }
 
+static enum bp_result bios_parser_select_crtc_source(
+	struct dc_bios *dcb,
+	struct bp_crtc_source_select *bp_params)
+{
+	struct bios_parser *bp = BP_FROM_DCB(dcb);
+
+	if (!bp->cmd_tbl.select_crtc_source)
+		return BP_RESULT_FAILURE;
+
+	return bp->cmd_tbl.select_crtc_source(bp, bp_params);
+}
+
 static enum bp_result bios_parser_encoder_control(
 	struct dc_bios *dcb,
 	struct bp_encoder_control *cntl)
@@ -2845,6 +2857,8 @@ static const struct dc_vbios_funcs vbios_funcs = {
 	.is_device_id_supported = bios_parser_is_device_id_supported,
 
 	/* COMMANDS */
+	.select_crtc_source = bios_parser_select_crtc_source,
+
 	.encoder_control = bios_parser_encoder_control,
 
 	.transmitter_control = bios_parser_transmitter_control,
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index 58e88778da7f..dbd84477ceb7 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -52,6 +52,7 @@ static void init_transmitter_control(struct bios_parser *bp);
 static void init_set_pixel_clock(struct bios_parser *bp);
 static void init_enable_spread_spectrum_on_ppll(struct bios_parser *bp);
 static void init_adjust_display_pll(struct bios_parser *bp);
+static void init_select_crtc_source(struct bios_parser *bp);
 static void init_dac_encoder_control(struct bios_parser *bp);
 static void init_dac_output_control(struct bios_parser *bp);
 static void init_set_crtc_timing(struct bios_parser *bp);
@@ -69,6 +70,7 @@ void dal_bios_parser_init_cmd_tbl(struct bios_parser *bp)
 	init_set_pixel_clock(bp);
 	init_enable_spread_spectrum_on_ppll(bp);
 	init_adjust_display_pll(bp);
+	init_select_crtc_source(bp);
 	init_dac_encoder_control(bp);
 	init_dac_output_control(bp);
 	init_set_crtc_timing(bp);
@@ -1609,6 +1611,198 @@ static enum bp_result adjust_display_pll_v3(
 	return result;
 }
 
+/*******************************************************************************
+ ********************************************************************************
+ **
+ **                  SELECT CRTC SOURCE
+ **
+ ********************************************************************************
+ *******************************************************************************/
+
+static enum bp_result select_crtc_source_v1(
+	struct bios_parser *bp,
+	struct bp_crtc_source_select *bp_params);
+static enum bp_result select_crtc_source_v2(
+	struct bios_parser *bp,
+	struct bp_crtc_source_select *bp_params);
+static enum bp_result select_crtc_source_v3(
+	struct bios_parser *bp,
+	struct bp_crtc_source_select *bp_params);
+
+static void init_select_crtc_source(struct bios_parser *bp)
+{
+	switch (BIOS_CMD_TABLE_PARA_REVISION(SelectCRTC_Source)) {
+	case 1:
+		bp->cmd_tbl.select_crtc_source = select_crtc_source_v1;
+		break;
+	case 2:
+		bp->cmd_tbl.select_crtc_source = select_crtc_source_v2;
+		break;
+	case 3:
+		bp->cmd_tbl.select_crtc_source = select_crtc_source_v3;
+		break;
+	default:
+		bp->cmd_tbl.select_crtc_source = NULL;
+		break;
+	}
+}
+
+static enum bp_result select_crtc_source_v1(
+	struct bios_parser *bp,
+	struct bp_crtc_source_select *bp_params)
+{
+	enum bp_result result = BP_RESULT_FAILURE;
+	SELECT_CRTC_SOURCE_PS_ALLOCATION params;
+
+	if (!bp->cmd_helper->controller_id_to_atom(bp_params->controller_id, &params.ucCRTC))
+		return BP_RESULT_BADINPUT;
+
+	switch (bp_params->engine_id) {
+	case ENGINE_ID_DACA:
+		params.ucDevice = ATOM_DEVICE_CRT1_INDEX;
+		break;
+	case ENGINE_ID_DACB:
+		params.ucDevice = ATOM_DEVICE_CRT2_INDEX;
+		break;
+	default:
+		return BP_RESULT_BADINPUT;
+	}
+
+	if (EXEC_BIOS_CMD_TABLE(SelectCRTC_Source, params))
+		result = BP_RESULT_OK;
+
+	return result;
+}
+
+static bool select_crtc_source_v2_encoder_id(
+	enum engine_id engine_id, uint8_t *out_encoder_id)
+{
+	uint8_t encoder_id = 0;
+
+	switch (engine_id) {
+	case ENGINE_ID_DIGA:
+		encoder_id = ASIC_INT_DIG1_ENCODER_ID;
+		break;
+	case ENGINE_ID_DIGB:
+		encoder_id = ASIC_INT_DIG2_ENCODER_ID;
+		break;
+	case ENGINE_ID_DIGC:
+		encoder_id = ASIC_INT_DIG3_ENCODER_ID;
+		break;
+	case ENGINE_ID_DIGD:
+		encoder_id = ASIC_INT_DIG4_ENCODER_ID;
+		break;
+	case ENGINE_ID_DIGE:
+		encoder_id = ASIC_INT_DIG5_ENCODER_ID;
+		break;
+	case ENGINE_ID_DIGF:
+		encoder_id = ASIC_INT_DIG6_ENCODER_ID;
+		break;
+	case ENGINE_ID_DIGG:
+		encoder_id = ASIC_INT_DIG7_ENCODER_ID;
+		break;
+	case ENGINE_ID_DACA:
+		encoder_id = ASIC_INT_DAC1_ENCODER_ID;
+		break;
+	case ENGINE_ID_DACB:
+		encoder_id = ASIC_INT_DAC2_ENCODER_ID;
+		break;
+	default:
+		return false;
+	}
+
+	*out_encoder_id = encoder_id;
+	return true;
+}
+
+static bool select_crtc_source_v2_encoder_mode(
+	enum signal_type signal_type, uint8_t *out_encoder_mode)
+{
+	uint8_t encoder_mode = 0;
+
+	switch (signal_type) {
+	case SIGNAL_TYPE_DVI_SINGLE_LINK:
+	case SIGNAL_TYPE_DVI_DUAL_LINK:
+		encoder_mode = ATOM_ENCODER_MODE_DVI;
+		break;
+	case SIGNAL_TYPE_HDMI_TYPE_A:
+		encoder_mode = ATOM_ENCODER_MODE_HDMI;
+		break;
+	case SIGNAL_TYPE_LVDS:
+		encoder_mode = ATOM_ENCODER_MODE_LVDS;
+		break;
+	case SIGNAL_TYPE_RGB:
+		encoder_mode = ATOM_ENCODER_MODE_CRT;
+		break;
+	case SIGNAL_TYPE_DISPLAY_PORT:
+		encoder_mode = ATOM_ENCODER_MODE_DP;
+		break;
+	case SIGNAL_TYPE_DISPLAY_PORT_MST:
+		encoder_mode = ATOM_ENCODER_MODE_DP_MST;
+		break;
+	case SIGNAL_TYPE_EDP:
+		encoder_mode = ATOM_ENCODER_MODE_DP;
+		break;
+	default:
+		return false;
+	}
+
+	*out_encoder_mode = encoder_mode;
+	return true;
+}
+
+static enum bp_result select_crtc_source_v2(
+	struct bios_parser *bp,
+	struct bp_crtc_source_select *bp_params)
+{
+	enum bp_result result = BP_RESULT_FAILURE;
+	SELECT_CRTC_SOURCE_PARAMETERS_V3 params;
+
+	if (!bp->cmd_helper->controller_id_to_atom(bp_params->controller_id, &params.ucCRTC))
+		return BP_RESULT_BADINPUT;
+
+	if (!select_crtc_source_v2_encoder_id(
+		bp_params->engine_id,
+		&params.ucEncoderID))
+		return BP_RESULT_BADINPUT;
+	if (!select_crtc_source_v2_encoder_mode(
+		bp_params->sink_signal,
+		&params.ucEncodeMode))
+		return BP_RESULT_BADINPUT;
+
+	if (EXEC_BIOS_CMD_TABLE(SelectCRTC_Source, params))
+		result = BP_RESULT_OK;
+
+	return result;
+}
+
+static enum bp_result select_crtc_source_v3(
+	struct bios_parser *bp,
+	struct bp_crtc_source_select *bp_params)
+{
+	enum bp_result result = BP_RESULT_FAILURE;
+	SELECT_CRTC_SOURCE_PARAMETERS_V3 params;
+
+	if (!bp->cmd_helper->controller_id_to_atom(bp_params->controller_id, &params.ucCRTC))
+		return BP_RESULT_BADINPUT;
+
+	if (!select_crtc_source_v2_encoder_id(
+		bp_params->engine_id,
+		&params.ucEncoderID))
+		return BP_RESULT_BADINPUT;
+	if (!select_crtc_source_v2_encoder_mode(
+		bp_params->sink_signal,
+		&params.ucEncodeMode))
+		return BP_RESULT_BADINPUT;
+
+	params.ucDstBpc = bp_params->bit_depth;
+
+	if (EXEC_BIOS_CMD_TABLE(SelectCRTC_Source, params))
+		result = BP_RESULT_OK;
+
+	return result;
+}
+
 /*******************************************************************************
  ********************************************************************************
  **
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.h b/drivers/gpu/drm/amd/display/dc/bios/command_table.h
index ad533775e724..8b04b903e93d 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.h
@@ -52,6 +52,9 @@ struct cmd_tbl {
 	enum bp_result (*adjust_display_pll)(
 		struct bios_parser *bp,
 		struct bp_adjust_pixel_clock_parameters *bp_params);
+	enum bp_result (*select_crtc_source)(
+		struct bios_parser *bp,
+		struct bp_crtc_source_select *bp_params);
 	enum bp_result (*dac1_encoder_control)(
 		struct bios_parser *bp,
 		bool enable,
diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
index 5fa5e2b63fb7..545ce1e15eae 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
@@ -91,6 +91,9 @@ struct dc_vbios_funcs {
 		struct device_id id);
 	/* COMMANDS */
 
+	enum bp_result (*select_crtc_source)(
+		struct dc_bios *bios,
+		struct bp_crtc_source_select *bp_params);
 	enum bp_result (*encoder_control)(
 		struct dc_bios *bios,
 		struct bp_encoder_control *cntl);
diff --git a/drivers/gpu/drm/amd/display/include/bios_parser_types.h b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
index 812377d9e48f..d9e58a6a0d36 100644
--- a/drivers/gpu/drm/amd/display/include/bios_parser_types.h
+++ b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
@@ -135,12 +135,8 @@ struct bp_external_encoder_control {
 struct bp_crtc_source_select {
 	enum engine_id engine_id;
 	enum controller_id controller_id;
-	/* from GPU Tx aka asic_signal */
-	enum signal_type signal;
-	/* sink_signal may differ from asicSignal if Translator encoder */
 	enum signal_type sink_signal;
-	enum display_output_bit_depth display_output_bit_depth;
-	bool enable_dp_audio;
+	uint8_t bit_depth;
 };
 
 struct bp_transmitter_control {
-- 
2.51.0


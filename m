Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E07AC83F1A
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 15:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A5B8810E17F;
	Wed, 23 Jul 2025 15:58:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FToPqED4";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A3ED10E80C
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 15:58:35 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-3b45edf2303so6167558f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 08:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286314; x=1753891114; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bKax2/t7veYi2bUg4zHxsytdb5eA/uf4Xo5mkjMzBaQ=;
 b=FToPqED4s7CCqSFc5/d6+daOwabdzOd1BRhe/p2ZdkDoN9zoFzq9f2jJyN36o69Ude
 8m1zyjAWu6vSHv2diQMREY++ee3Bh/Hplm3K8/HrHHPD8A2LGU0psAqrfxwsENdZyvxq
 Zro2sIcmIdFwUCbmd8ykntUItotqTXbk69+pXM17Vip62sgpN0TC+FLfOTPToHEi9T1F
 0kuYUOvX8JnGeAidOzcqWQLqXTqjBiGWei7zh+fAdLbwDcxHmwSAaIlszvH82xcoeXHi
 Z6jkTb1tvPmN4OXmcrgf0uX2Rk0QpEdxWWDHmzbN2TX2fpCZR0NhzXA1DkL3jplS/l7m
 JWLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286314; x=1753891114;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bKax2/t7veYi2bUg4zHxsytdb5eA/uf4Xo5mkjMzBaQ=;
 b=pRQkQCWk6aX7ZkwNFOFvy759+BEEc3Z+De/rxOW1cbsmZuPX3g/v0bK8E3dAOJil3s
 eLmdbujRuYarDXhixxoP6Rpj3tub+MNdnekgdJO7BNWgS5Em24BLnLFFR0+6krolIPvu
 N0J56/32BHxEEztyZRPorwRG0hU5uKA074OY/lybXyCn5cuV/5fvswa1bJU30AK76ZXj
 23UL6+a1RvM+sSaZ2d3tpWnAuWkqCmAL6WETZdBW507xOxsSSg5YyBqVTp2qDmEelz+Z
 bRGKapTTWeN2adMFFBJCFRiWUMpdCN9W3jfHPFIsnDGVbnynPzYnpf4l3Va4tD4enBxi
 PSMA==
X-Gm-Message-State: AOJu0YymOdWJRQYy97PUHRYtrvLHOLLeRf1L+6Pp3d0ZstGyVMHx2Qq3
 9vD0aI34WrVTnINXFbXQNd7tYBKaLrq3QVHQtYiSZJnkSgEww+F0bT3rC+uRLA==
X-Gm-Gg: ASbGncszkzIh0jr51hpGtrrNReCFmG79O4ZoTLpKxEFzXc6/F9lDDCZ0psbW7tHTZOe
 lavWRVlFvXyd5wyA+l7u1HaiyuBnu3cY+iN6Ocsk+qri6r+H1CnjEfuzAsy2AoAMBkfuhvbNHJJ
 bdGKVrlBfxWa+2spOGn6GqeVlGVI4YsRJmABvCycyZukz9hSs+pa8rQ86ZZGmit/MsCzaCgzE+v
 Vi9gSJvQyRBUICq0tG4LQl1ZRVEm7kM8ZXwsWS9/5wDgFmWttWjZtALTQXuQVfb3uVltfGZpG60
 D4XcjB5pmpxrjqifitwr9F7t5tUOw9bMoXga0FPxW8HmSffpKc9DsZ+bd89SAinmhAkWJP+QUhJ
 h0iuNtd7SlpAcyv1vXn6uKXVo9GyXCfx5LZs+GUDe0h/27VPgWLf0KDEQYSPYawbiEvft7PGZJy
 qTOZ8hmmwLbM0lBedzx7Z1eo0Jkw==
X-Google-Smtp-Source: AGHT+IE/Q0iX1tk8BeTklJMHY7UxLulTARzCtuQcYdDSTzPrx221vvlcVPMgHmdlEI4Ab0jO1neBfQ==
X-Received: by 2002:a5d:588a:0:b0:3a4:ee51:8144 with SMTP id
 ffacd0b85a97d-3b768ea0012mr3006274f8f.13.1753286313427; 
 Wed, 23 Jul 2025 08:58:33 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4D24D8FC008443E005DD6C3C62.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:8443:e005:dd6c:3c62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bf99sm16710468f8f.32.2025.07.23.08.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:58:33 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 17/20] drm/amd/display: Add DAC_LoadDetection to BIOS parser
Date: Wed, 23 Jul 2025 17:58:10 +0200
Message-ID: <20250723155813.9101-18-timur.kristof@gmail.com>
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

DAC_LoadDetection can be used to determine whether something
is connected to an analog connector, primarily when the connected
display doesn't have an EDID.

As a reference, I used the following function:
amdgpu_atombios_encoder_dac_load_detect

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser.c | 50 ++++++++++
 .../drm/amd/display/dc/bios/command_table.c   | 92 +++++++++++++++++++
 .../drm/amd/display/dc/bios/command_table.h   |  3 +
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |  5 +
 .../amd/display/include/bios_parser_types.h   |  5 +
 5 files changed, 155 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 44f71757508f..58a7f6012936 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -783,6 +783,54 @@ static enum bp_result bios_parser_encoder_control(
 	return bp->cmd_tbl.dig_encoder_control(bp, cntl);
 }
 
+static enum bp_result bios_parser_dac_load_detection(
+	struct dc_bios *dcb,
+	enum engine_id engine_id,
+	enum dal_device_type device_type,
+	uint32_t enum_id)
+{
+	struct bios_parser *bp = BP_FROM_DCB(dcb);
+	struct dc_context *ctx = dcb->ctx;
+	struct bp_load_detection_parameters bp_params = {0};
+	enum bp_result bp_result;
+	uint32_t bios_0_scratch;
+
+	bp_params.engine_id = engine_id;
+	bp_params.device_id = get_support_mask_for_device_id(device_type, enum_id);
+
+	if (engine_id != ENGINE_ID_DACA &&
+	    engine_id != ENGINE_ID_DACB)
+		return BP_RESULT_UNSUPPORTED;
+
+	if (!bp->cmd_tbl.dac_load_detection)
+		return BP_RESULT_UNSUPPORTED;
+
+	/* BIOS will write the detected devices to BIOS_SCRATCH_0, clear the register */
+	dm_write_reg(ctx, bp->base.regs->BIOS_SCRATCH_0, 0);
+
+	bp_result = bp->cmd_tbl.dac_load_detection(bp, &bp_params);
+
+	if (bp_result != BP_RESULT_OK)
+		return bp_result;
+
+	bios_0_scratch = dm_read_reg(ctx, bp->base.regs->BIOS_SCRATCH_0);
+
+	switch (bp_params.device_id) {
+	case ATOM_DEVICE_CRT1_SUPPORT:
+		if (bios_0_scratch & ATOM_S0_CRT1_MASK)
+			return BP_RESULT_OK;
+		break;
+	case ATOM_DEVICE_CRT2_SUPPORT:
+		if (bios_0_scratch & ATOM_S0_CRT2_MASK)
+			return BP_RESULT_OK;
+		break;
+	default:
+		break;
+	}
+
+	return BP_RESULT_FAILURE;
+}
+
 static enum bp_result bios_parser_adjust_pixel_clock(
 	struct dc_bios *dcb,
 	struct bp_adjust_pixel_clock_parameters *bp_params)
@@ -2867,6 +2915,8 @@ static const struct dc_vbios_funcs vbios_funcs = {
 
 	.encoder_control = bios_parser_encoder_control,
 
+	.dac_load_detection = bios_parser_dac_load_detection,
+
 	.transmitter_control = bios_parser_transmitter_control,
 
 	.enable_crtc = bios_parser_enable_crtc,
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index 8983220d2a4b..7899e952b68a 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
@@ -54,6 +54,7 @@ static void init_enable_spread_spectrum_on_ppll(struct bios_parser *bp);
 static void init_adjust_display_pll(struct bios_parser *bp);
 static void init_select_crtc_source(struct bios_parser *bp);
 static void init_dac_encoder_control(struct bios_parser *bp);
+static void init_dac_load_detection(struct bios_parser *bp);
 static void init_dac_output_control(struct bios_parser *bp);
 static void init_set_crtc_timing(struct bios_parser *bp);
 static void init_enable_crtc(struct bios_parser *bp);
@@ -72,6 +73,7 @@ void dal_bios_parser_init_cmd_tbl(struct bios_parser *bp)
 	init_adjust_display_pll(bp);
 	init_select_crtc_source(bp);
 	init_dac_encoder_control(bp);
+	init_dac_load_detection(bp);
 	init_dac_output_control(bp);
 	init_set_crtc_timing(bp);
 	init_enable_crtc(bp);
@@ -1902,6 +1904,96 @@ static enum bp_result dac2_encoder_control_v1(
 	return result;
 }
 
+/*******************************************************************************
+ ********************************************************************************
+ **
+ **                  DAC LOAD DETECTION
+ **
+ ********************************************************************************
+ *******************************************************************************/
+
+static enum bp_result dac_load_detection_v1(
+	struct bios_parser *bp,
+	struct bp_load_detection_parameters *bp_params);
+
+static enum bp_result dac_load_detection_v3(
+	struct bios_parser *bp,
+	struct bp_load_detection_parameters *bp_params);
+
+static void init_dac_load_detection(struct bios_parser *bp)
+{
+	switch (BIOS_CMD_TABLE_PARA_REVISION(DAC_LoadDetection)) {
+	case 1:
+	case 2:
+		bp->cmd_tbl.dac_load_detection = dac_load_detection_v1;
+		break;
+	case 3:
+	default:
+		bp->cmd_tbl.dac_load_detection = dac_load_detection_v3;
+		break;
+	}
+}
+
+static void dac_load_detect_prepare_params(
+	struct _DAC_LOAD_DETECTION_PS_ALLOCATION *params,
+	enum engine_id engine_id,
+	uint16_t device_id,
+	uint8_t misc)
+{
+	uint8_t dac_type = ENGINE_ID_DACA;
+
+	if (engine_id == ENGINE_ID_DACB)
+		dac_type = ATOM_DAC_B;
+
+	params->sDacload.usDeviceID = cpu_to_le16(device_id);
+	params->sDacload.ucDacType = dac_type;
+	params->sDacload.ucMisc = misc;
+}
+
+static enum bp_result dac_load_detection_v1(
+	struct bios_parser *bp,
+	struct bp_load_detection_parameters *bp_params)
+{
+	enum bp_result result = BP_RESULT_FAILURE;
+	DAC_LOAD_DETECTION_PS_ALLOCATION params;
+
+	dac_load_detect_prepare_params(
+		&params,
+		bp_params->engine_id,
+		bp_params->device_id,
+		0);
+
+	if (EXEC_BIOS_CMD_TABLE(DAC_LoadDetection, params))
+		result = BP_RESULT_OK;
+
+	return result;
+}
+
+static enum bp_result dac_load_detection_v3(
+	struct bios_parser *bp,
+	struct bp_load_detection_parameters *bp_params)
+{
+	enum bp_result result = BP_RESULT_FAILURE;
+	DAC_LOAD_DETECTION_PS_ALLOCATION params;
+
+	uint8_t misc = 0;
+
+	if (bp_params->device_id == ATOM_DEVICE_CV_SUPPORT ||
+	    bp_params->device_id == ATOM_DEVICE_TV1_SUPPORT)
+		misc = DAC_LOAD_MISC_YPrPb;
+
+	dac_load_detect_prepare_params(
+		&params,
+		bp_params->engine_id,
+		bp_params->device_id,
+		misc);
+
+	if (EXEC_BIOS_CMD_TABLE(DAC_LoadDetection, params))
+		result = BP_RESULT_OK;
+
+	return result;
+}
+
 /*******************************************************************************
  ********************************************************************************
  **
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.h b/drivers/gpu/drm/amd/display/dc/bios/command_table.h
index 8b04b903e93d..e89b1ba0048b 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/command_table.h
+++ b/drivers/gpu/drm/amd/display/dc/bios/command_table.h
@@ -71,6 +71,9 @@ struct cmd_tbl {
 	enum bp_result (*dac2_output_control)(
 		struct bios_parser *bp,
 		bool enable);
+	enum bp_result (*dac_load_detection)(
+		struct bios_parser *bp,
+		struct bp_load_detection_parameters *bp_params);
 	enum bp_result (*set_crtc_timing)(
 		struct bios_parser *bp,
 		struct bp_hw_crtc_timing_parameters *bp_params);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
index 50c8906b74c5..40d7a7d83c40 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
@@ -97,6 +97,11 @@ struct dc_vbios_funcs {
 	enum bp_result (*encoder_control)(
 		struct dc_bios *bios,
 		struct bp_encoder_control *cntl);
+	enum bp_result (*dac_load_detection)(
+		struct dc_bios *bios,
+		enum engine_id engine_id,
+		enum dal_device_type device_type,
+		uint32_t enum_id);
 	enum bp_result (*transmitter_control)(
 		struct dc_bios *bios,
 		struct bp_transmitter_control *cntl);
diff --git a/drivers/gpu/drm/amd/display/include/bios_parser_types.h b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
index d9e58a6a0d36..973b6bdbac63 100644
--- a/drivers/gpu/drm/amd/display/include/bios_parser_types.h
+++ b/drivers/gpu/drm/amd/display/include/bios_parser_types.h
@@ -162,6 +162,11 @@ struct bp_transmitter_control {
 	bool single_pll_mode;
 };
 
+struct bp_load_detection_parameters {
+	enum engine_id engine_id;
+	uint16_t device_id;
+};
+
 struct bp_hw_crtc_timing_parameters {
 	enum controller_id controller_id;
 	/* horizontal part */
-- 
2.50.1


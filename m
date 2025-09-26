Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DBF1CAC5AE
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Sep 2025 18:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D98D910EAC7;
	Fri, 26 Sep 2025 18:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ng0tcHOp";
	dkim-atps=neutral
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com
 [209.85.215.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4575910EAC7
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 18:03:55 +0000 (UTC)
Received: by mail-pg1-f179.google.com with SMTP id
 41be03b00d2f7-b58445361e8so581018a12.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Sep 2025 11:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758909835; x=1759514635; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zAfzgbDz2hKnMPMgAD0KCzDKy1dVxT+8v+VKzXQwsew=;
 b=Ng0tcHOpPo9QQdleZrgKMqv5spq3ebtNg8batUYelk15mXzqq7uFX1NRe/V16e7QyY
 ZaEi+wMhJeycqXqGxu95TS8ftmhu2giw6yZhiV+mp9jP/KwkEG+TWSyW26t7Om2if82t
 5D12vosVxR/VjapFQjUKD5l7ozNtNWyn4iodmTQ+KUH5tPoLHJUceLGYHrv08io0l8g5
 yMrq1UIjC8f7U0/SvUGfpUhq4V8AU0OJ5o/++09pYzp4rDOto2ZlObT9pC77arsOkPJc
 cuXg3guZTtpBQebcBTTORxyL00UxuNsA6aS8JBLuMS7oyMkMkHb3oNym4lLXjOLkxI7G
 XHsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758909835; x=1759514635;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zAfzgbDz2hKnMPMgAD0KCzDKy1dVxT+8v+VKzXQwsew=;
 b=mLwo871d3ibjPMcoQIIzAZbTutfuEKZzhRMdeLkhVGURhqLXPj818gC5YbgxIkYGE6
 IclheORKDSMxbCGfq18V+94FYjYumh8iLe7VZabmBkzpuE29zoJ7XY3o862TUr3iO0Q5
 VHtdGvJaAA5272V4NdxkRE6ckpKSq5e+o00VmDGgeq1X2XM2FV4+u/SxzBnQ289YnuUZ
 kiJRaWrF+Hx8JsbvdOTPn900AV3Sn2JkAQL+9jUDaCfIA5YvE9bC+S9gKLWzHyViNBr4
 UU1bvlIMHGA+AjESlTT8QlIAU9fnieggFmOS3H43bbB2XVlL+eCb4+aZdR9eS+rhl6nX
 MUiw==
X-Gm-Message-State: AOJu0YwKfDjvG7SgUElVkcLyYP0tiy3OcBPCs4kn3izsAvYGffA7XZ/t
 VcIDQ6ZdWy/AVKEyHUOxH0A5a9DHCRmvL6yfCkbjYuzkClNREY4fSTxP3ipBiQ==
X-Gm-Gg: ASbGncuLokKyP7ZoziJwpC3owxvLkPkJmOnPbsf/gH0zR/0++NuuUd0xDTsi/aB4sDF
 IslC7qaP5e0IWcZl9jU1G7UuQsEWy12barDI45Rp8vmfVXzlBhrcKC5+4Qw3sTZBo2EjSAua1UQ
 2zih0mv73wiGME1lmbej5hcxZ/32cE0r7psbiEp50ldJ42ibBni8Ks+mLvQOIgbh1PtNUKJES57
 Z2ahyxzkzkJVjBUPBOfZv49nbAIBi8tOJa0issvabzSXvsUu/HyYr6S8KCTIAgYWY6Ct1u6Zl2q
 znrD7CfNwfT1dJYG2LFmCkRlGjY7dCft71utFACGfvRvM0MnHNWini8YfbBBY+s/0PCH28EdO/e
 jSJ8MLrDhOWBsUGs167dCTNSqNK6MRvCfUaT8ANWsXYbt+4qFWjtCrDjlH6d1AYrwARTWjjNA9G
 jCSQWeWwWA0W9dNtsCdXQrOplFgcjKpQ==
X-Google-Smtp-Source: AGHT+IG7CqQsb2gmv2LrU2mxcW/bn5YrO5/EvxKCmCFH6wtaBM0GZBrdzQtxTDloZFx9Vfa3wklJ5Q==
X-Received: by 2002:a17:902:e5c7:b0:249:71f5:4e5a with SMTP id
 d9443c01a7336-27ed7206701mr73164815ad.26.1758909834559; 
 Fri, 26 Sep 2025 11:03:54 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24D067005D2C718B079018C4.dsl.pool.telekom.hu.
 [2001:4c4e:24d0:6700:5d2c:718b:790:18c4])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-27f1d2ef8c5sm22186835ad.151.2025.09.26.11.03.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 11:03:54 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, alex.hung@amd.com, harry.wentland@amd.com,
 siqueira@igalia.com, christian.koenig@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 19/23] drm/amd/display: Add DAC_LoadDetection to BIOS parser
 (v2)
Date: Fri, 26 Sep 2025 20:01:59 +0200
Message-ID: <20250926180203.16690-20-timur.kristof@gmail.com>
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

DAC_LoadDetection can be used to determine whether something
is connected to an analog connector by determining if there is
an analog load. This causes visible flickering on displays, so
we only resort to using this when the connected display doesn't
have an EDID.

For reference, see the legacy display code:
amdgpu_atombios_encoder_dac_load_detect

v2:
Only clear corresponding bit from BIOS_SCRATCH_0.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser.c | 50 ++++++++++
 .../drm/amd/display/dc/bios/command_table.c   | 92 +++++++++++++++++++
 .../drm/amd/display/dc/bios/command_table.h   |  3 +
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |  5 +
 .../amd/display/include/bios_parser_types.h   |  5 +
 5 files changed, 155 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index a126ca3a53fb..4120d6c4c5e4 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -780,6 +780,54 @@ static enum bp_result bios_parser_encoder_control(
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
+	uint32_t device_id_mask = 0;
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
+	if (bp_params.device_id == ATOM_DEVICE_CRT1_SUPPORT)
+		device_id_mask = ATOM_S0_CRT1_MASK;
+	else if (bp_params.device_id == ATOM_DEVICE_CRT1_SUPPORT)
+		device_id_mask = ATOM_S0_CRT2_MASK;
+	else
+		return BP_RESULT_UNSUPPORTED;
+
+	/* BIOS will write the detected devices to BIOS_SCRATCH_0, clear corresponding bit */
+	bios_0_scratch = dm_read_reg(ctx, bp->base.regs->BIOS_SCRATCH_0);
+	bios_0_scratch &= ~device_id_mask;
+	dm_write_reg(ctx, bp->base.regs->BIOS_SCRATCH_0, bios_0_scratch);
+
+	bp_result = bp->cmd_tbl.dac_load_detection(bp, &bp_params);
+
+	if (bp_result != BP_RESULT_OK)
+		return bp_result;
+
+	bios_0_scratch = dm_read_reg(ctx, bp->base.regs->BIOS_SCRATCH_0);
+
+	if (bios_0_scratch & device_id_mask)
+		return BP_RESULT_OK;
+
+	return BP_RESULT_FAILURE;
+}
+
 static enum bp_result bios_parser_adjust_pixel_clock(
 	struct dc_bios *dcb,
 	struct bp_adjust_pixel_clock_parameters *bp_params)
@@ -2864,6 +2912,8 @@ static const struct dc_vbios_funcs vbios_funcs = {
 
 	.encoder_control = bios_parser_encoder_control,
 
+	.dac_load_detection = bios_parser_dac_load_detection,
+
 	.transmitter_control = bios_parser_transmitter_control,
 
 	.enable_crtc = bios_parser_enable_crtc,
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index dbd84477ceb7..22457f417e65 100644
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
2.51.0


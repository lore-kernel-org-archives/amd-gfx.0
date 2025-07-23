Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74474C83F1A
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Jul 2025 15:58:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F8DF10E807;
	Wed, 23 Jul 2025 15:58:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IZCGQ7DY";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25F1C10E7FC
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 15:58:26 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-3b45edf2303so6167391f8f.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Jul 2025 08:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753286305; x=1753891105; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PUhf7vvlQ2QoKPK4m2srI8VOVK+Q+O4nuDajyDmuqX4=;
 b=IZCGQ7DYjIuZUMhfekZxOqKOZB7bnn98EkJAuzUpmE2sjzi6EyR7tzRH5tiZJdf4Rv
 pyUYjuJ0kjeDXNCTBiA2+fJ6JzwFUJOwAM+dWDZWxznDVB4jZdU5K1rBOJNPJITU9uLO
 EOvc6TZMn4jtpv4g3n6R0yellSHD+SGjB+ntglL6FvoaSBfvVhqb2VFGlTU3XkJLqUUy
 twFnm4bWKXPStSappir3PQ5h2DvJPyciI+d4Lvl8tcujZAQuzvUIw8wuNFMPUNPKVl2g
 hkZLsACK3DmNSxvb3zUWpGgW42BInzjm2FAUque6WORp/Xb7/CLJzNOYRT/wlfaamjtM
 F+kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753286305; x=1753891105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PUhf7vvlQ2QoKPK4m2srI8VOVK+Q+O4nuDajyDmuqX4=;
 b=GbbQ+mWhZSPZUTl7OBseA6zU68fQQ4iajOz+GXmNb5KZwFVc00Xx5z8xjK8NQq9+wi
 j7QcdEOCyBZHAnFinMVRRaitmDPCvr1mJoZtFmL1EKGI2Tu8tXB0+TvROqcHK7GalIso
 DyLovlBOoalr1sh2Gb/EwRHWD3+Yqy263EfgfXPBdxPN3gWztyvtLNHcaiEXu9s0llPP
 e9RlyDXetiUD3XDiXL20Te98JtMsQgXuDVrHYFTMShZIsWk/ltvDJbv+82s4ZMiuG7N6
 y6K9JaaPDKaSglDsHQ/Yk4VIgcq5aAuaytK8jmTx8RhA6p24rayj1M7rVVrN0y69BaDp
 ZkkQ==
X-Gm-Message-State: AOJu0YzcQq9OXGLrdGn9Xiw6B6gXDcujz+p9Wrz4QYa0pm3jV7iiglO1
 l34J92mFU+EMDIME7+yoCMuQ77ZdjYRiManfNtBdFtzqV5wcABPJUqCdHT1SdA==
X-Gm-Gg: ASbGncvogPk64TnPJnlgLmlNXX6OSYgEBhHxtUlk7J/OW52y0yguAOrsnCi8PKzlFTd
 dtNatcxNmko8oz2loVFUjsVdgdYu390fdUyxq9GBZNjRlse4NjrR+PqHSJ8+b72cK64BdGi4Dh7
 ykDCWURBfam+mnADGBGtxBciabXCNb/OvIGW6lFwKY3dpo9+7KDQsjA0MvXJ9CR53/l5WGn4A9z
 ysFpExaZU0KFmvUaoK5huIeRrkAHDkJGtR0h6KaenHUC5u1d4MHu46kWKOpyhxD8s23Ahou3I5G
 T44rw3yjX2lugt3GMM2ObeGC4o9jHJ7RmRzReS47cWz41UFhl8rx3j7HUuN80bI6TW8JAXiR0+S
 EIVgNaf3HCcQER3iHRr9xRVFuvO5FYeJimDIhRikiOD21fkSUf/8UtLCEB5iNCwROh0DP8IDMll
 0fDGhRr/0kZ3tHTw0Z+jWudffT/g==
X-Google-Smtp-Source: AGHT+IGG6aRAA7pwE4qONDNlCcxry0btPw8Tjuj91++Vau7uJh87njryQIcD9A0gywtytw81IMtWDQ==
X-Received: by 2002:a05:6000:24c9:b0:3b7:61e5:a8a5 with SMTP id
 ffacd0b85a97d-3b768f0760emr2836356f8f.47.1753286304402; 
 Wed, 23 Jul 2025 08:58:24 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4D24D8FC008443E005DD6C3C62.dsl.pool.telekom.hu.
 [2001:4c4d:24d8:fc00:8443:e005:dd6c:3c62])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca2bf99sm16710468f8f.32.2025.07.23.08.58.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 08:58:24 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 05/20] drm/amd/display: Add SelectCRTC_Source to BIOS parser
Date: Wed, 23 Jul 2025 17:57:58 +0200
Message-ID: <20250723155813.9101-6-timur.kristof@gmail.com>
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

The SelectCRTC_Source command will be used to change which CRTC
should be connected to which encoder.

To implement this, I used the legacy display code as reference:
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
index 6914dd6944b7..bfacfd2a5376 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -739,6 +739,18 @@ static enum bp_result bios_parser_transmitter_control(
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
@@ -2848,6 +2860,8 @@ static const struct dc_vbios_funcs vbios_funcs = {
 	.is_device_id_supported = bios_parser_is_device_id_supported,
 
 	/* COMMANDS */
+	.select_crtc_source = bios_parser_select_crtc_source,
+
 	.encoder_control = bios_parser_encoder_control,
 
 	.transmitter_control = bios_parser_transmitter_control,
diff --git a/drivers/gpu/drm/amd/display/dc/bios/command_table.c b/drivers/gpu/drm/amd/display/dc/bios/command_table.c
index 2bcae0643e61..8983220d2a4b 100644
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
2.50.1


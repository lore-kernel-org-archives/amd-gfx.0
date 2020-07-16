Return-Path: <SRS0=xwQz=A3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5727FC433F7
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25BC120787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PO1NHbzS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BC120787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1C556ECED;
	Thu, 16 Jul 2020 21:23:27 +0000 (UTC)
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com
 [IPv6:2a00:1450:4864:20::343])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51A706ECED
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:25 +0000 (UTC)
Received: by mail-wm1-x343.google.com with SMTP id o2so13178866wmh.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rtv4i8MMwkzTKf+SmHguIDfFOZ7poQYPzd9r/5xReJc=;
 b=PO1NHbzSTtUu9tfBsQh7OTO6cdps7VYRpG3UC56oqR6tdY8BZU70kB2ydD5VojnepL
 vE+EsuT12hUR0fk+2wmF+7QK6c7A7TuzpK8FumYiKaB+MJ4ps+HTNRPu8kU0ya9DIJAA
 JKt48/cDtahpxfX9gNoDZZlCzpW01imQB1xsLO+5ywk6V/l9Hf2iUjUtu75hWdJM7qm1
 f9ET6Inm3Na8Efw3Z0GQRG1c8z4611ALl14m+GDIyHhpgnLuTMzZN8EB0y1c4bYOi0wJ
 RPmPAcIG/fO09kzukhr0vzL0LzKP3AR5MzbGwJAraXj7e2grVHSvUnVnaa04/VBEYadV
 XTqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rtv4i8MMwkzTKf+SmHguIDfFOZ7poQYPzd9r/5xReJc=;
 b=kRYdX0S3ywLzd9O3A+j2QSr7eckhLcCgOWbP+hraA6lYDF0Pd1Ta/zKApVgonO5GqU
 NuytfPLEZCAG6Kdj1O+EY9TFxV1vTCTiP+yfS6JT7eqkHCV+InhFF6SCRRYd/h91TAQl
 8Xn39ihffljsCQlNRoCSnf0ux57P0xLk2MhkkK6G+KgAzLblaX/XpDYSzHm4xV3suqOD
 D1usedZnUCm1l/3Uaew0O1r/zh+hJbfMLBcL1i6LaNKw+FFqvm9KgcD/4+B0yLAZCktK
 qWNzW3xwhGFYmqBWuqN1DiLNnX1/YS0IFmTnChqYaQp6hNpuyCpaET60YKurnN1sWgS7
 6q2w==
X-Gm-Message-State: AOAM531jyQy41q7ffwdkqeG4BvoSJSQ+y95X4cBOwwBgjE3L12KAmH2c
 DLU0yLmc3/DNwtrMdejqx2PFSjT/83Q=
X-Google-Smtp-Source: ABdhPJxFAybm4+7QS4OoLpWOcdfHi6zxZ9ES2ztdNihZ9/UmpGBoGMHdcBEWKu89WTy0dYERf4eYkA==
X-Received: by 2002:a1c:23d0:: with SMTP id j199mr6396739wmj.12.1594934603418; 
 Thu, 16 Jul 2020 14:23:23 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:23 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 15/27] drm/amd/display: dce_link_encoder: add DCE6 specific
 macros, functions
Date: Thu, 16 Jul 2020 23:22:39 +0200
Message-Id: <20200716212251.1539094-16-issor.oruam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716212251.1539094-1-issor.oruam@gmail.com>
References: <20200716212251.1539094-1-issor.oruam@gmail.com>
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, Mauro Rossi <issor.oruam@gmail.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
DCE6 has no DP_DPHY_SCRAM_CNTL register

[How]
Add DCE6 specific macros definitions for LE registers
DCE6 LE macros will avoid buiding errors when using DCE6 headers
Add dce60_set_dp_phy_pattern_hbr2_compliance_cp2520_2() w/o Scramble Control programming
Add dce60_set_dp_phy_pattern_passthrough_mode() w/o Scramble Control programming
Add dce60_configure_encoder() w/o Scramble Control programming
Add dce60_link_encoder_enable_dp_output() w/ dce60_configure_encoder
Add dce60_link_encoder_enable_dp_mst_output() w/ dce60_configure_encoder
Add dce60_link_encoder_dp_set_phy_pattern() w/ dce60_set_dp_phy_pattern_passthrough_mode
Use dce60_link_encoder_enable_dp_output() in dce60_lnk_enc_funcs
Use dce60_link_encoder_enable_dp_mst_output() in dce60_lnk_enc_funcs
Use dce60_link_encoder_dp_set_phy_pattern() in dce60_lnk_enc_funcs
Add DCE6 specific dce60_link_encoder_construct

Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
---
 .../drm/amd/display/dc/dce/dce_link_encoder.c | 369 ++++++++++++++++++
 .../drm/amd/display/dc/dce/dce_link_encoder.h |  38 ++
 2 files changed, 407 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
index 8d8c84c81b34..b409f6b2bfd8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.c
@@ -425,6 +425,59 @@ static void set_dp_phy_pattern_hbr2_compliance_cp2520_2(
 	enable_phy_bypass_mode(enc110, false);
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+static void dce60_set_dp_phy_pattern_hbr2_compliance_cp2520_2(
+	struct dce110_link_encoder *enc110,
+	unsigned int cp2520_pattern)
+{
+
+	/* previously there is a register DP_HBR2_EYE_PATTERN
+	 * that is enabled to get the pattern.
+	 * But it does not work with the latest spec change,
+	 * so we are programming the following registers manually.
+	 *
+	 * The following settings have been confirmed
+	 * by Nick Chorney and Sandra Liu */
+
+	/* Disable PHY Bypass mode to setup the test pattern */
+
+	enable_phy_bypass_mode(enc110, false);
+
+	/* Setup DIG encoder in DP SST mode */
+	enc110->base.funcs->setup(&enc110->base, SIGNAL_TYPE_DISPLAY_PORT);
+
+	/* ensure normal panel mode. */
+	setup_panel_mode(enc110, DP_PANEL_MODE_DEFAULT);
+
+	/* no vbid after BS (SR)
+	 * DP_LINK_FRAMING_CNTL changed history Sandra Liu
+	 * 11000260 / 11000104 / 110000FC */
+	REG_UPDATE_3(DP_LINK_FRAMING_CNTL,
+			DP_IDLE_BS_INTERVAL, 0xFC,
+			DP_VBID_DISABLE, 1,
+			DP_VID_ENHANCED_FRAME_MODE, 1);
+
+	/* DCE6 has no DP_DPHY_SCRAM_CNTL register, skip swap BS with SR */
+
+	/* select cp2520 patterns */
+	if (REG(DP_DPHY_HBR2_PATTERN_CONTROL))
+		REG_UPDATE(DP_DPHY_HBR2_PATTERN_CONTROL,
+				DP_DPHY_HBR2_PATTERN_CONTROL, cp2520_pattern);
+	else
+		/* pre-DCE11 can only generate CP2520 pattern 2 */
+		ASSERT(cp2520_pattern == 2);
+
+	/* set link training complete */
+	set_link_training_complete(enc110, true);
+
+	/* disable video stream */
+	REG_UPDATE(DP_VID_STREAM_CNTL, DP_VID_STREAM_ENABLE, 0);
+
+	/* Disable PHY Bypass mode to setup the test pattern */
+	enable_phy_bypass_mode(enc110, false);
+}
+#endif
+
 static void set_dp_phy_pattern_passthrough_mode(
 	struct dce110_link_encoder *enc110,
 	enum dp_panel_mode panel_mode)
@@ -452,6 +505,35 @@ static void set_dp_phy_pattern_passthrough_mode(
 	disable_prbs_mode(enc110);
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+static void dce60_set_dp_phy_pattern_passthrough_mode(
+	struct dce110_link_encoder *enc110,
+	enum dp_panel_mode panel_mode)
+{
+	/* program correct panel mode */
+	setup_panel_mode(enc110, panel_mode);
+
+	/* restore LINK_FRAMING_CNTL
+	 * in case we were doing HBR2 compliance pattern before
+	 */
+	REG_UPDATE_3(DP_LINK_FRAMING_CNTL,
+			DP_IDLE_BS_INTERVAL, 0x2000,
+			DP_VBID_DISABLE, 0,
+			DP_VID_ENHANCED_FRAME_MODE, 1);
+
+	/* DCE6 has no DP_DPHY_SCRAM_CNTL register, skip DPHY_SCRAMBLER_BS_COUNT restore */
+
+	/* set link training complete */
+	set_link_training_complete(enc110, true);
+
+	/* Disable PHY Bypass mode to setup the test pattern */
+	enable_phy_bypass_mode(enc110, false);
+
+	/* Disable PRBS mode */
+	disable_prbs_mode(enc110);
+}
+#endif
+
 /* return value is bit-vector */
 static uint8_t get_frontend_source(
 	enum engine_id engine)
@@ -490,6 +572,20 @@ static void configure_encoder(
 	REG_UPDATE(DP_DPHY_SCRAM_CNTL, DPHY_SCRAMBLER_ADVANCE, 1);
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+static void dce60_configure_encoder(
+	struct dce110_link_encoder *enc110,
+	const struct dc_link_settings *link_settings)
+{
+	/* set number of lanes */
+
+	REG_SET(DP_CONFIG, 0,
+			DP_UDI_LANES, link_settings->lane_count - LANE_COUNT_ONE);
+
+	/* DCE6 has no DP_DPHY_SCRAM_CNTL register, skip setup scrambler */
+}
+#endif
+
 static void aux_initialize(
 	struct dce110_link_encoder *enc110)
 {
@@ -1059,6 +1155,87 @@ void dce110_link_encoder_enable_dp_mst_output(
 		BREAK_TO_DEBUGGER();
 	}
 }
+
+#if defined(CONFIG_DRM_AMD_DC_SI)
+/* enables DP PHY output */
+void dce60_link_encoder_enable_dp_output(
+	struct link_encoder *enc,
+	const struct dc_link_settings *link_settings,
+	enum clock_source_id clock_source)
+{
+	struct dce110_link_encoder *enc110 = TO_DCE110_LINK_ENC(enc);
+	struct bp_transmitter_control cntl = { 0 };
+	enum bp_result result;
+
+	/* Enable the PHY */
+
+	/* number_of_lanes is used for pixel clock adjust,
+	 * but it's not passed to asic_control.
+	 * We need to set number of lanes manually.
+	 */
+	dce60_configure_encoder(enc110, link_settings);
+	cntl.connector_obj_id = enc110->base.connector;
+	cntl.action = TRANSMITTER_CONTROL_ENABLE;
+	cntl.engine_id = enc->preferred_engine;
+	cntl.transmitter = enc110->base.transmitter;
+	cntl.pll_id = clock_source;
+	cntl.signal = SIGNAL_TYPE_DISPLAY_PORT;
+	cntl.lanes_number = link_settings->lane_count;
+	cntl.hpd_sel = enc110->base.hpd_source;
+	cntl.pixel_clock = link_settings->link_rate
+						* LINK_RATE_REF_FREQ_IN_KHZ;
+	/* TODO: check if undefined works */
+	cntl.color_depth = COLOR_DEPTH_UNDEFINED;
+
+	result = link_transmitter_control(enc110, &cntl);
+
+	if (result != BP_RESULT_OK) {
+		DC_LOG_ERROR("%s: Failed to execute VBIOS command table!\n",
+			__func__);
+		BREAK_TO_DEBUGGER();
+	}
+}
+
+/* enables DP PHY output in MST mode */
+void dce60_link_encoder_enable_dp_mst_output(
+	struct link_encoder *enc,
+	const struct dc_link_settings *link_settings,
+	enum clock_source_id clock_source)
+{
+	struct dce110_link_encoder *enc110 = TO_DCE110_LINK_ENC(enc);
+	struct bp_transmitter_control cntl = { 0 };
+	enum bp_result result;
+
+	/* Enable the PHY */
+
+	/* number_of_lanes is used for pixel clock adjust,
+	 * but it's not passed to asic_control.
+	 * We need to set number of lanes manually.
+	 */
+	dce60_configure_encoder(enc110, link_settings);
+
+	cntl.action = TRANSMITTER_CONTROL_ENABLE;
+	cntl.engine_id = ENGINE_ID_UNKNOWN;
+	cntl.transmitter = enc110->base.transmitter;
+	cntl.pll_id = clock_source;
+	cntl.signal = SIGNAL_TYPE_DISPLAY_PORT_MST;
+	cntl.lanes_number = link_settings->lane_count;
+	cntl.hpd_sel = enc110->base.hpd_source;
+	cntl.pixel_clock = link_settings->link_rate
+						* LINK_RATE_REF_FREQ_IN_KHZ;
+	/* TODO: check if undefined works */
+	cntl.color_depth = COLOR_DEPTH_UNDEFINED;
+
+	result = link_transmitter_control(enc110, &cntl);
+
+	if (result != BP_RESULT_OK) {
+		DC_LOG_ERROR("%s: Failed to execute VBIOS command table!\n",
+			__func__);
+		BREAK_TO_DEBUGGER();
+	}
+}
+#endif
+
 /*
  * @brief
  * Disable transmitter and its encoder
@@ -1208,6 +1385,63 @@ void dce110_link_encoder_dp_set_phy_pattern(
 	}
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+/* set DP PHY test and training patterns */
+void dce60_link_encoder_dp_set_phy_pattern(
+	struct link_encoder *enc,
+	const struct encoder_set_dp_phy_pattern_param *param)
+{
+	struct dce110_link_encoder *enc110 = TO_DCE110_LINK_ENC(enc);
+
+	switch (param->dp_phy_pattern) {
+	case DP_TEST_PATTERN_TRAINING_PATTERN1:
+		dce110_link_encoder_set_dp_phy_pattern_training_pattern(enc, 0);
+		break;
+	case DP_TEST_PATTERN_TRAINING_PATTERN2:
+		dce110_link_encoder_set_dp_phy_pattern_training_pattern(enc, 1);
+		break;
+	case DP_TEST_PATTERN_TRAINING_PATTERN3:
+		dce110_link_encoder_set_dp_phy_pattern_training_pattern(enc, 2);
+		break;
+	case DP_TEST_PATTERN_TRAINING_PATTERN4:
+		dce110_link_encoder_set_dp_phy_pattern_training_pattern(enc, 3);
+		break;
+	case DP_TEST_PATTERN_D102:
+		set_dp_phy_pattern_d102(enc110);
+		break;
+	case DP_TEST_PATTERN_SYMBOL_ERROR:
+		set_dp_phy_pattern_symbol_error(enc110);
+		break;
+	case DP_TEST_PATTERN_PRBS7:
+		set_dp_phy_pattern_prbs7(enc110);
+		break;
+	case DP_TEST_PATTERN_80BIT_CUSTOM:
+		set_dp_phy_pattern_80bit_custom(
+			enc110, param->custom_pattern);
+		break;
+	case DP_TEST_PATTERN_CP2520_1:
+		dce60_set_dp_phy_pattern_hbr2_compliance_cp2520_2(enc110, 1);
+		break;
+	case DP_TEST_PATTERN_CP2520_2:
+		dce60_set_dp_phy_pattern_hbr2_compliance_cp2520_2(enc110, 2);
+		break;
+	case DP_TEST_PATTERN_CP2520_3:
+		dce60_set_dp_phy_pattern_hbr2_compliance_cp2520_2(enc110, 3);
+		break;
+	case DP_TEST_PATTERN_VIDEO_MODE: {
+		dce60_set_dp_phy_pattern_passthrough_mode(
+			enc110, param->dp_panel_mode);
+		break;
+	}
+
+	default:
+		/* invalid phy pattern */
+		ASSERT_CRITICAL(false);
+		break;
+	}
+}
+#endif
+
 static void fill_stream_allocation_row_info(
 	const struct link_mst_stream_allocation *stream_allocation,
 	uint32_t *src,
@@ -1407,3 +1641,138 @@ void dce110_link_encoder_get_max_link_cap(struct link_encoder *enc,
 
 	*link_settings = max_link_cap;
 }
+
+#if defined(CONFIG_DRM_AMD_DC_SI)
+static const struct link_encoder_funcs dce60_lnk_enc_funcs = {
+	.validate_output_with_stream =
+		dce110_link_encoder_validate_output_with_stream,
+	.hw_init = dce110_link_encoder_hw_init,
+	.setup = dce110_link_encoder_setup,
+	.enable_tmds_output = dce110_link_encoder_enable_tmds_output,
+	.enable_dp_output = dce60_link_encoder_enable_dp_output,
+	.enable_dp_mst_output = dce60_link_encoder_enable_dp_mst_output,
+	.enable_lvds_output = dce110_link_encoder_enable_lvds_output,
+	.disable_output = dce110_link_encoder_disable_output,
+	.dp_set_lane_settings = dce110_link_encoder_dp_set_lane_settings,
+	.dp_set_phy_pattern = dce60_link_encoder_dp_set_phy_pattern,
+	.update_mst_stream_allocation_table =
+		dce110_link_encoder_update_mst_stream_allocation_table,
+	.psr_program_dp_dphy_fast_training =
+			dce110_psr_program_dp_dphy_fast_training,
+	.psr_program_secondary_packet = dce110_psr_program_secondary_packet,
+	.connect_dig_be_to_fe = dce110_link_encoder_connect_dig_be_to_fe,
+	.enable_hpd = dce110_link_encoder_enable_hpd,
+	.disable_hpd = dce110_link_encoder_disable_hpd,
+	.is_dig_enabled = dce110_is_dig_enabled,
+	.destroy = dce110_link_encoder_destroy,
+	.get_max_link_cap = dce110_link_encoder_get_max_link_cap
+};
+
+void dce60_link_encoder_construct(
+	struct dce110_link_encoder *enc110,
+	const struct encoder_init_data *init_data,
+	const struct encoder_feature_support *enc_features,
+	const struct dce110_link_enc_registers *link_regs,
+	const struct dce110_link_enc_aux_registers *aux_regs,
+	const struct dce110_link_enc_hpd_registers *hpd_regs)
+{
+	struct bp_encoder_cap_info bp_cap_info = {0};
+	const struct dc_vbios_funcs *bp_funcs = init_data->ctx->dc_bios->funcs;
+	enum bp_result result = BP_RESULT_OK;
+
+	enc110->base.funcs = &dce60_lnk_enc_funcs;
+	enc110->base.ctx = init_data->ctx;
+	enc110->base.id = init_data->encoder;
+
+	enc110->base.hpd_source = init_data->hpd_source;
+	enc110->base.connector = init_data->connector;
+
+	enc110->base.preferred_engine = ENGINE_ID_UNKNOWN;
+
+	enc110->base.features = *enc_features;
+
+	enc110->base.transmitter = init_data->transmitter;
+
+	/* set the flag to indicate whether driver poll the I2C data pin
+	 * while doing the DP sink detect
+	 */
+
+/*	if (dal_adapter_service_is_feature_supported(as,
+		FEATURE_DP_SINK_DETECT_POLL_DATA_PIN))
+		enc110->base.features.flags.bits.
+			DP_SINK_DETECT_POLL_DATA_PIN = true;*/
+
+	enc110->base.output_signals =
+		SIGNAL_TYPE_DVI_SINGLE_LINK |
+		SIGNAL_TYPE_DVI_DUAL_LINK |
+		SIGNAL_TYPE_LVDS |
+		SIGNAL_TYPE_DISPLAY_PORT |
+		SIGNAL_TYPE_DISPLAY_PORT_MST |
+		SIGNAL_TYPE_EDP |
+		SIGNAL_TYPE_HDMI_TYPE_A;
+
+	/* For DCE 8.0 and 8.1, by design, UNIPHY is hardwired to DIG_BE.
+	 * SW always assign DIG_FE 1:1 mapped to DIG_FE for non-MST UNIPHY.
+	 * SW assign DIG_FE to non-MST UNIPHY first and MST last. So prefer
+	 * DIG is per UNIPHY and used by SST DP, eDP, HDMI, DVI and LVDS.
+	 * Prefer DIG assignment is decided by board design.
+	 * For DCE 8.0, there are only max 6 UNIPHYs, we assume board design
+	 * and VBIOS will filter out 7 UNIPHY for DCE 8.0.
+	 * By this, adding DIGG should not hurt DCE 8.0.
+	 * This will let DCE 8.1 share DCE 8.0 as much as possible
+	 */
+
+	enc110->link_regs = link_regs;
+	enc110->aux_regs = aux_regs;
+	enc110->hpd_regs = hpd_regs;
+
+	switch (enc110->base.transmitter) {
+	case TRANSMITTER_UNIPHY_A:
+		enc110->base.preferred_engine = ENGINE_ID_DIGA;
+	break;
+	case TRANSMITTER_UNIPHY_B:
+		enc110->base.preferred_engine = ENGINE_ID_DIGB;
+	break;
+	case TRANSMITTER_UNIPHY_C:
+		enc110->base.preferred_engine = ENGINE_ID_DIGC;
+	break;
+	case TRANSMITTER_UNIPHY_D:
+		enc110->base.preferred_engine = ENGINE_ID_DIGD;
+	break;
+	case TRANSMITTER_UNIPHY_E:
+		enc110->base.preferred_engine = ENGINE_ID_DIGE;
+	break;
+	case TRANSMITTER_UNIPHY_F:
+		enc110->base.preferred_engine = ENGINE_ID_DIGF;
+	break;
+	case TRANSMITTER_UNIPHY_G:
+		enc110->base.preferred_engine = ENGINE_ID_DIGG;
+	break;
+	default:
+		ASSERT_CRITICAL(false);
+		enc110->base.preferred_engine = ENGINE_ID_UNKNOWN;
+	}
+
+	/* default to one to mirror Windows behavior */
+	enc110->base.features.flags.bits.HDMI_6GB_EN = 1;
+
+	result = bp_funcs->get_encoder_cap_info(enc110->base.ctx->dc_bios,
+						enc110->base.id, &bp_cap_info);
+
+	/* Override features with DCE-specific values */
+	if (BP_RESULT_OK == result) {
+		enc110->base.features.flags.bits.IS_HBR2_CAPABLE =
+				bp_cap_info.DP_HBR2_EN;
+		enc110->base.features.flags.bits.IS_HBR3_CAPABLE =
+				bp_cap_info.DP_HBR3_EN;
+		enc110->base.features.flags.bits.HDMI_6GB_EN = bp_cap_info.HDMI_6GB_EN;
+	} else {
+		DC_LOG_WARNING("%s: Failed to get encoder_cap_info from VBIOS with error code %d!\n",
+				__func__,
+				result);
+	}
+	if (enc110->base.ctx->dc->debug.hdmi20_disable) {
+		enc110->base.features.flags.bits.HDMI_6GB_EN = 0;
+	}
+}
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
index 384389f0e2c3..40ea2220330c 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_link_encoder.h
@@ -75,6 +75,34 @@
 	SRI(DP_DPHY_INTERNAL_CTRL, DP, id), \
 	SR(DCI_MEM_PWR_STATUS)
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+#define LE_DCE60_REG_LIST(id)\
+	SRI(DP_DPHY_INTERNAL_CTRL, DP, id), \
+	SR(DMCU_RAM_ACCESS_CTRL), \
+	SR(DMCU_IRAM_RD_CTRL), \
+	SR(DMCU_IRAM_RD_DATA), \
+	SR(DMCU_INTERRUPT_TO_UC_EN_MASK), \
+	SRI(DIG_BE_CNTL, DIG, id), \
+	SRI(DIG_BE_EN_CNTL, DIG, id), \
+	SRI(DP_CONFIG, DP, id), \
+	SRI(DP_DPHY_CNTL, DP, id), \
+	SRI(DP_DPHY_PRBS_CNTL, DP, id), \
+	SRI(DP_DPHY_SYM0, DP, id), \
+	SRI(DP_DPHY_SYM1, DP, id), \
+	SRI(DP_DPHY_SYM2, DP, id), \
+	SRI(DP_DPHY_TRAINING_PATTERN_SEL, DP, id), \
+	SRI(DP_LINK_CNTL, DP, id), \
+	SRI(DP_LINK_FRAMING_CNTL, DP, id), \
+	SRI(DP_MSE_SAT0, DP, id), \
+	SRI(DP_MSE_SAT1, DP, id), \
+	SRI(DP_MSE_SAT2, DP, id), \
+	SRI(DP_MSE_SAT_UPDATE, DP, id), \
+	SRI(DP_SEC_CNTL, DP, id), \
+	SRI(DP_VID_STREAM_CNTL, DP, id), \
+	SRI(DP_DPHY_FAST_TRAINING, DP, id), \
+	SRI(DP_SEC_CNTL1, DP, id)
+#endif
+
 #define LE_DCE80_REG_LIST(id)\
 	SRI(DP_DPHY_INTERNAL_CTRL, DP, id), \
 	LE_COMMON_REG_LIST_BASE(id)
@@ -169,6 +197,16 @@ void dce110_link_encoder_construct(
 	const struct dce110_link_enc_aux_registers *aux_regs,
 	const struct dce110_link_enc_hpd_registers *hpd_regs);
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+void dce60_link_encoder_construct(
+	struct dce110_link_encoder *enc110,
+	const struct encoder_init_data *init_data,
+	const struct encoder_feature_support *enc_features,
+	const struct dce110_link_enc_registers *link_regs,
+	const struct dce110_link_enc_aux_registers *aux_regs,
+	const struct dce110_link_enc_hpd_registers *hpd_regs);
+#endif
+
 bool dce110_link_encoder_validate_dvi_output(
 	const struct dce110_link_encoder *enc110,
 	enum signal_type connector_signal,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

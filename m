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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 560FDC433F8
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22F8820787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHe34k2z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22F8820787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6ACD6ECF6;
	Thu, 16 Jul 2020 21:23:29 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E975E6ECF9
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:28 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id 17so13148676wmo.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mxao9o31/pSkCHCKjhluWXxojL1oqpx3hdJaDq1d3Hg=;
 b=AHe34k2zDVv0lssEK5B9LKVgdEHl/9Sqv8/tJUtvo/XOIR5OXWc26jM/zlVsekBqIz
 t4LpTM1B+yyTaNWC8Dn/k++worgbgH6lpaqEgedr4RkPHkkcjz+cZrCag98+tPYWVANZ
 c1FssUER3XlWFGzdK0bSGh3p8dWuJxbiIxsmslG3KBipNRIodGOdtnDwDPOtSYr47osg
 e/A/RAOpoOOyJP91RNXQ7g3juwggxUn6vg+Uc7hrMvOJuPDMAXnimv9WWEv8B/jdBFM2
 30oXTTRtb9BJov8/bKmxd56qDjzFTqITTCV7r2wih7pSkDWXuBonJgHe2qcaMjIgCPiD
 Ou8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mxao9o31/pSkCHCKjhluWXxojL1oqpx3hdJaDq1d3Hg=;
 b=NJUOvuimDguiQYtzvr6cot2g95TQ+LYVWVXuy4H6wdBMU8/GKmuXCMJDYFAFBvv6As
 AFpFzRRCGO+I/APdBFWzasNGK6c2aIVfwnIEIDVfBBZToiDzweaDok6a15Nvl8Q4HA03
 HacKyGGRDlQzfwR6QkWCEeZcLp2usx2oEDYPuDNxuL+diqaQqVldrt3Uz7/FVeZPub/u
 gZg4UrmwJvPREhXYS2sEP6BKl5C8MlkGlmsCi7rsd0OgwCj7plPYGqQtik3EfL0Zhg/7
 ZAMQQkrmu/9x+CODCslynqGUElO0yH9z+UGw6nCs0Z0JkeE1nnFg9EPyFLt8gunt9bF4
 zYaQ==
X-Gm-Message-State: AOAM532abJuohGE+/kzVWRKdGsa74rWPObHKYDFV7CdK2zu0zRK/Vm9y
 o7AkP4V378I9zwzbsk65eaHhyPQi0AU=
X-Google-Smtp-Source: ABdhPJy81fIX1qeT6amXUFC6YUnUysoN0xgGl8HA1mnt8w2BvBmfOEwMK6ftMNFU1lAfK9tSHQZcqA==
X-Received: by 2002:a1c:bb44:: with SMTP id l65mr6363119wmf.51.1594934606930; 
 Thu, 16 Jul 2020 14:23:26 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:26 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 18/27] drm/amd/display: dce_transform: add DCE6 specific
 macros, functions
Date: Thu, 16 Jul 2020 23:22:42 +0200
Message-Id: <20200716212251.1539094-19-issor.oruam@gmail.com>
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
DCE6 has no SCL_MODE and no SCL_{HORZ,VERT}_FILTER_INIT registers
DCE6 has no SCL_BOUNDARY_MODE bit in SCL_CONTROL register
DCE6 has Line Buffer programming registers (DC_LB_MEMORY_SPLIT,DC_LB_MEM_SIZE)
DCE6 DATA_FORMAT register has only INTERLEAVE_EN bit
DCE6 has no Out Clamp Control programming registers (OUT_CLAMP_CONTROL_*)

[How]
Add DCE6 specific macros definitions for XFM registers and masks
Add DCE6 specific registers to dce_transform_registers struct
Add DCE6 specific masks to dce_transform_mask struct
DCE6 XFM macros/structs changes will avoid buiding errors when using DCE6 headers
Add dce60_setup_scaling_configuration() w/o missing Scaling registers/bit programming
Add dce60_transform_set_scaler() using DCE6 Line Buffer programming registers
Add dce60_program_bit_depth_reduction() w/o Out Clamp Control programming
Add dce60_transform_set_pixel_storage_depth() use dce60_program_bit_depth_reduction()
Use dce60_transform_set_scaler() in dce60_transform_funcs
Use dce60_transform_set_pixel_storage_depth() in dce60_transform_funcs
Add DCE6 specific dce60_transform_construct

Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
---
 .../drm/amd/display/dc/dce/dce_transform.c    | 268 ++++++++++++++++++
 .../drm/amd/display/dc/dce/dce_transform.h    | 150 ++++++++++
 2 files changed, 418 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index ab63d0d0304c..3303d01c1aae 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
@@ -146,6 +146,33 @@ static bool setup_scaling_configuration(
 	return true;
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+static bool dce60_setup_scaling_configuration(
+	struct dce_transform *xfm_dce,
+	const struct scaler_data *data)
+{
+	REG_SET(SCL_BYPASS_CONTROL, 0, SCL_BYPASS_MODE, 0);
+
+	if (data->taps.h_taps + data->taps.v_taps <= 2) {
+		/* Set bypass */
+
+		/* DCE6 has no SCL_MODE register, skip scale mode programming */
+
+		return false;
+	}
+
+	REG_SET_2(SCL_TAP_CONTROL, 0,
+			SCL_H_NUM_OF_TAPS, data->taps.h_taps - 1,
+			SCL_V_NUM_OF_TAPS, data->taps.v_taps - 1);
+
+	/* DCE6 has no SCL_MODE register, skip scale mode programming */
+
+	/* DCE6 has no SCL_BOUNDARY_MODE bit, skip replace out of bound pixels */
+
+	return true;
+}
+#endif
+
 static void program_overscan(
 		struct dce_transform *xfm_dce,
 		const struct scaler_data *data)
@@ -399,6 +426,89 @@ static void dce_transform_set_scaler(
 	REG_UPDATE(LB_DATA_FORMAT, ALPHA_EN, data->lb_params.alpha_en);
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+static void dce60_transform_set_scaler(
+	struct transform *xfm,
+	const struct scaler_data *data)
+{
+	struct dce_transform *xfm_dce = TO_DCE_TRANSFORM(xfm);
+	bool is_scaling_required;
+	bool filter_updated = false;
+	const uint16_t *coeffs_v, *coeffs_h;
+
+	/*Use whole line buffer memory always*/
+	REG_SET(DC_LB_MEMORY_SPLIT, 0,
+		DC_LB_MEMORY_CONFIG, 0);
+
+	REG_SET(DC_LB_MEM_SIZE, 0,
+		DC_LB_MEM_SIZE, xfm_dce->lb_memory_size);
+
+	/* Clear SCL_F_SHARP_CONTROL value to 0 */
+	REG_WRITE(SCL_F_SHARP_CONTROL, 0);
+
+	/* 1. Program overscan */
+	program_overscan(xfm_dce, data);
+
+	/* 2. Program taps and configuration */
+	is_scaling_required = dce60_setup_scaling_configuration(xfm_dce, data);
+
+	if (is_scaling_required) {
+		/* 3. Calculate and program ratio, filter initialization */
+		struct scl_ratios_inits inits = { 0 };
+
+		calculate_inits(xfm_dce, data, &inits);
+
+		program_scl_ratios_inits(xfm_dce, &inits);
+
+		coeffs_v = get_filter_coeffs_16p(data->taps.v_taps, data->ratios.vert);
+		coeffs_h = get_filter_coeffs_16p(data->taps.h_taps, data->ratios.horz);
+
+		if (coeffs_v != xfm_dce->filter_v || coeffs_h != xfm_dce->filter_h) {
+			/* 4. Program vertical filters */
+			if (xfm_dce->filter_v == NULL)
+				REG_SET(SCL_VERT_FILTER_CONTROL, 0,
+						SCL_V_2TAP_HARDCODE_COEF_EN, 0);
+			program_multi_taps_filter(
+					xfm_dce,
+					data->taps.v_taps,
+					coeffs_v,
+					FILTER_TYPE_RGB_Y_VERTICAL);
+			program_multi_taps_filter(
+					xfm_dce,
+					data->taps.v_taps,
+					coeffs_v,
+					FILTER_TYPE_ALPHA_VERTICAL);
+
+			/* 5. Program horizontal filters */
+			if (xfm_dce->filter_h == NULL)
+				REG_SET(SCL_HORZ_FILTER_CONTROL, 0,
+						SCL_H_2TAP_HARDCODE_COEF_EN, 0);
+			program_multi_taps_filter(
+					xfm_dce,
+					data->taps.h_taps,
+					coeffs_h,
+					FILTER_TYPE_RGB_Y_HORIZONTAL);
+			program_multi_taps_filter(
+					xfm_dce,
+					data->taps.h_taps,
+					coeffs_h,
+					FILTER_TYPE_ALPHA_HORIZONTAL);
+
+			xfm_dce->filter_v = coeffs_v;
+			xfm_dce->filter_h = coeffs_h;
+			filter_updated = true;
+		}
+	}
+
+	/* 6. Program the viewport */
+	program_viewport(xfm_dce, &data->viewport);
+
+	/* DCE6 does not have bit to flip to new coefficient memory */
+
+	/* DCE6 DATA_FORMAT register does not support ALPHA_EN */
+}
+#endif
+
 /*****************************************************************************
  * set_clamp
  *
@@ -664,6 +774,67 @@ static void program_bit_depth_reduction(
 		   bit_depth_params->flags.HIGHPASS_RANDOM);
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+/*****************************************************************************
+ * dce60_transform_bit_depth_reduction program
+ *
+ * @brief
+ *     Programs the DCP bit depth reduction registers (Clamp, Round/Truncate,
+ *      Dither) for dce
+ *
+ * @param depth : bit depth to set the clamp to (should match denorm)
+ *
+ ******************************************************************************/
+static void dce60_program_bit_depth_reduction(
+	struct dce_transform *xfm_dce,
+	enum dc_color_depth depth,
+	const struct bit_depth_reduction_params *bit_depth_params)
+{
+	enum dcp_out_trunc_round_depth trunc_round_depth;
+	enum dcp_out_trunc_round_mode trunc_mode;
+	bool spatial_dither_enable;
+
+	ASSERT(depth < COLOR_DEPTH_121212); /* Invalid clamp bit depth */
+
+	spatial_dither_enable = bit_depth_params->flags.SPATIAL_DITHER_ENABLED;
+	/* Default to 12 bit truncation without rounding */
+	trunc_round_depth = DCP_OUT_TRUNC_ROUND_DEPTH_12BIT;
+	trunc_mode = DCP_OUT_TRUNC_ROUND_MODE_TRUNCATE;
+
+	if (bit_depth_params->flags.TRUNCATE_ENABLED) {
+		/* Don't enable dithering if truncation is enabled */
+		spatial_dither_enable = false;
+		trunc_mode = bit_depth_params->flags.TRUNCATE_MODE ?
+			     DCP_OUT_TRUNC_ROUND_MODE_ROUND :
+			     DCP_OUT_TRUNC_ROUND_MODE_TRUNCATE;
+
+		if (bit_depth_params->flags.TRUNCATE_DEPTH == 0 ||
+		    bit_depth_params->flags.TRUNCATE_DEPTH == 1)
+			trunc_round_depth = DCP_OUT_TRUNC_ROUND_DEPTH_8BIT;
+		else if (bit_depth_params->flags.TRUNCATE_DEPTH == 2)
+			trunc_round_depth = DCP_OUT_TRUNC_ROUND_DEPTH_10BIT;
+		else {
+			/*
+			 * Invalid truncate/round depth. Setting here to 12bit
+			 * to prevent use-before-initialize errors.
+			 */
+			trunc_round_depth = DCP_OUT_TRUNC_ROUND_DEPTH_12BIT;
+			BREAK_TO_DEBUGGER();
+		}
+	}
+
+	/* DCE6 has no OUT_CLAMP_CONTROL_* registers - set_clamp() is skipped */
+	set_round(xfm_dce, trunc_mode, trunc_round_depth);
+	set_dither(xfm_dce,
+		   spatial_dither_enable,
+		   DCP_SPATIAL_DITHER_MODE_A_AA_A,
+		   DCP_SPATIAL_DITHER_DEPTH_30BPP,
+		   bit_depth_params->flags.FRAME_RANDOM,
+		   bit_depth_params->flags.RGB_RANDOM,
+		   bit_depth_params->flags.HIGHPASS_RANDOM);
+}
+#endif
+
 static int dce_transform_get_max_num_of_supported_lines(
 	struct dce_transform *xfm_dce,
 	enum lb_pixel_depth depth,
@@ -797,6 +968,59 @@ static void dce_transform_set_pixel_storage_depth(
 	}
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+static void dce60_transform_set_pixel_storage_depth(
+	struct transform *xfm,
+	enum lb_pixel_depth depth,
+	const struct bit_depth_reduction_params *bit_depth_params)
+{
+	struct dce_transform *xfm_dce = TO_DCE_TRANSFORM(xfm);
+	int pixel_depth, expan_mode;
+	enum dc_color_depth color_depth;
+
+	switch (depth) {
+	case LB_PIXEL_DEPTH_18BPP:
+		color_depth = COLOR_DEPTH_666;
+		pixel_depth = 2;
+		expan_mode  = 1;
+		break;
+	case LB_PIXEL_DEPTH_24BPP:
+		color_depth = COLOR_DEPTH_888;
+		pixel_depth = 1;
+		expan_mode  = 1;
+		break;
+	case LB_PIXEL_DEPTH_30BPP:
+		color_depth = COLOR_DEPTH_101010;
+		pixel_depth = 0;
+		expan_mode  = 1;
+		break;
+	case LB_PIXEL_DEPTH_36BPP:
+		color_depth = COLOR_DEPTH_121212;
+		pixel_depth = 3;
+		expan_mode  = 0;
+		break;
+	default:
+		color_depth = COLOR_DEPTH_101010;
+		pixel_depth = 0;
+		expan_mode  = 1;
+		BREAK_TO_DEBUGGER();
+		break;
+	}
+
+	set_denormalization(xfm_dce, color_depth);
+	dce60_program_bit_depth_reduction(xfm_dce, color_depth, bit_depth_params);
+
+	/* DATA_FORMAT in DCE6 does not have PIXEL_DEPTH and PIXEL_EXPAN_MODE masks */
+
+	if (!(xfm_dce->lb_pixel_depth_supported & depth)) {
+		/*we should use unsupported capabilities
+		 *  unless it is required by w/a*/
+		DC_LOG_WARNING("%s: Capability not supported",
+			__func__);
+	}
+}
+#endif
+
 static void program_gamut_remap(
 	struct dce_transform *xfm_dce,
 	const uint16_t *reg_val)
@@ -1335,6 +1559,21 @@ static const struct transform_funcs dce_transform_funcs = {
 	.transform_get_optimal_number_of_taps = dce_transform_get_optimal_number_of_taps
 };
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+static const struct transform_funcs dce60_transform_funcs = {
+	.transform_reset = dce_transform_reset,
+	.transform_set_scaler = dce60_transform_set_scaler,
+	.transform_set_gamut_remap = dce_transform_set_gamut_remap,
+	.opp_set_csc_adjustment = dce110_opp_set_csc_adjustment,
+	.opp_set_csc_default = dce110_opp_set_csc_default,
+	.opp_power_on_regamma_lut = dce110_opp_power_on_regamma_lut,
+	.opp_program_regamma_pwl = dce110_opp_program_regamma_pwl,
+	.opp_set_regamma_mode = dce110_opp_set_regamma_mode,
+	.transform_set_pixel_storage_depth = dce60_transform_set_pixel_storage_depth,
+	.transform_get_optimal_number_of_taps = dce_transform_get_optimal_number_of_taps
+};
+#endif
+
 /*****************************************/
 /* Constructor, Destructor               */
 /*****************************************/
@@ -1365,3 +1604,32 @@ void dce_transform_construct(
 	xfm_dce->lb_bits_per_entry = LB_BITS_PER_ENTRY;
 	xfm_dce->lb_memory_size = LB_TOTAL_NUMBER_OF_ENTRIES; /*0x6B0*/
 }
+
+#if defined(CONFIG_DRM_AMD_DC_SI)
+void dce60_transform_construct(
+	struct dce_transform *xfm_dce,
+	struct dc_context *ctx,
+	uint32_t inst,
+	const struct dce_transform_registers *regs,
+	const struct dce_transform_shift *xfm_shift,
+	const struct dce_transform_mask *xfm_mask)
+{
+	xfm_dce->base.ctx = ctx;
+
+	xfm_dce->base.inst = inst;
+	xfm_dce->base.funcs = &dce60_transform_funcs;
+
+	xfm_dce->regs = regs;
+	xfm_dce->xfm_shift = xfm_shift;
+	xfm_dce->xfm_mask = xfm_mask;
+
+	xfm_dce->prescaler_on = true;
+	xfm_dce->lb_pixel_depth_supported =
+			LB_PIXEL_DEPTH_18BPP |
+			LB_PIXEL_DEPTH_24BPP |
+			LB_PIXEL_DEPTH_30BPP;
+
+	xfm_dce->lb_bits_per_entry = LB_BITS_PER_ENTRY;
+	xfm_dce->lb_memory_size = LB_TOTAL_NUMBER_OF_ENTRIES; /*0x6B0*/
+}
+#endif
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
index 948281d8b6af..95b28dadc8c5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
@@ -108,6 +108,68 @@
 	SRI(DCFE_MEM_PWR_CTRL, DCFE, id), \
 	SRI(DCFE_MEM_PWR_STATUS, DCFE, id)
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+#define XFM_COMMON_REG_LIST_DCE60_BASE(id) \
+	SRI(DATA_FORMAT, LB, id), \
+	SRI(GAMUT_REMAP_CONTROL, DCP, id), \
+	SRI(GAMUT_REMAP_C11_C12, DCP, id), \
+	SRI(GAMUT_REMAP_C13_C14, DCP, id), \
+	SRI(GAMUT_REMAP_C21_C22, DCP, id), \
+	SRI(GAMUT_REMAP_C23_C24, DCP, id), \
+	SRI(GAMUT_REMAP_C31_C32, DCP, id), \
+	SRI(GAMUT_REMAP_C33_C34, DCP, id), \
+	SRI(OUTPUT_CSC_C11_C12, DCP, id), \
+	SRI(OUTPUT_CSC_C13_C14, DCP, id), \
+	SRI(OUTPUT_CSC_C21_C22, DCP, id), \
+	SRI(OUTPUT_CSC_C23_C24, DCP, id), \
+	SRI(OUTPUT_CSC_C31_C32, DCP, id), \
+	SRI(OUTPUT_CSC_C33_C34, DCP, id), \
+	SRI(OUTPUT_CSC_CONTROL, DCP, id), \
+	SRI(REGAMMA_CNTLA_START_CNTL, DCP, id), \
+	SRI(REGAMMA_CNTLA_SLOPE_CNTL, DCP, id), \
+	SRI(REGAMMA_CNTLA_END_CNTL1, DCP, id), \
+	SRI(REGAMMA_CNTLA_END_CNTL2, DCP, id), \
+	SRI(REGAMMA_CNTLA_REGION_0_1, DCP, id), \
+	SRI(REGAMMA_CNTLA_REGION_2_3, DCP, id), \
+	SRI(REGAMMA_CNTLA_REGION_4_5, DCP, id), \
+	SRI(REGAMMA_CNTLA_REGION_6_7, DCP, id), \
+	SRI(REGAMMA_CNTLA_REGION_8_9, DCP, id), \
+	SRI(REGAMMA_CNTLA_REGION_10_11, DCP, id), \
+	SRI(REGAMMA_CNTLA_REGION_12_13, DCP, id), \
+	SRI(REGAMMA_CNTLA_REGION_14_15, DCP, id), \
+	SRI(REGAMMA_LUT_WRITE_EN_MASK, DCP, id), \
+	SRI(REGAMMA_LUT_INDEX, DCP, id), \
+	SRI(REGAMMA_LUT_DATA, DCP, id), \
+	SRI(REGAMMA_CONTROL, DCP, id), \
+	SRI(DENORM_CONTROL, DCP, id), \
+	SRI(DCP_SPATIAL_DITHER_CNTL, DCP, id), \
+	SRI(OUT_ROUND_CONTROL, DCP, id), \
+	SRI(SCL_TAP_CONTROL, SCL, id), \
+	SRI(SCL_CONTROL, SCL, id), \
+	SRI(SCL_BYPASS_CONTROL, SCL, id), \
+	SRI(EXT_OVERSCAN_LEFT_RIGHT, SCL, id), \
+	SRI(EXT_OVERSCAN_TOP_BOTTOM, SCL, id), \
+	SRI(SCL_VERT_FILTER_CONTROL, SCL, id), \
+	SRI(SCL_HORZ_FILTER_CONTROL, SCL, id), \
+	SRI(SCL_COEF_RAM_SELECT, SCL, id), \
+	SRI(SCL_COEF_RAM_TAP_DATA, SCL, id), \
+	SRI(VIEWPORT_START, SCL, id), \
+	SRI(VIEWPORT_SIZE, SCL, id), \
+	SRI(SCL_HORZ_FILTER_SCALE_RATIO, SCL, id), \
+	SRI(SCL_VERT_FILTER_SCALE_RATIO, SCL, id), \
+	SRI(SCL_VERT_FILTER_INIT, SCL, id), \
+	SRI(SCL_AUTOMATIC_MODE_CONTROL, SCL, id), \
+	SRI(DC_LB_MEMORY_SPLIT, LB, id), \
+	SRI(DC_LB_MEM_SIZE, LB, id), \
+	SRI(DCFE_MEM_LIGHT_SLEEP_CNTL, CRTC, id), \
+	SRI(SCL_UPDATE, SCL, id), \
+	SRI(SCL_F_SHARP_CONTROL, SCL, id)
+
+#define XFM_COMMON_REG_LIST_DCE60(id) \
+	XFM_COMMON_REG_LIST_DCE60_BASE(id), \
+	SRI(DCFE_MEM_LIGHT_SLEEP_CNTL, CRTC, id)
+#endif
+
 #define XFM_SF(reg_name, field_name, post_fix)\
 	.field_name = reg_name ## __ ## field_name ## post_fix
 
@@ -204,6 +266,75 @@
 	XFM_SF(DCFE_MEM_PWR_STATUS, DCP_REGAMMA_MEM_PWR_STATE, mask_sh),\
 	XFM_SF(SCL_MODE, SCL_PSCL_EN, mask_sh)
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+#define XFM_COMMON_MASK_SH_LIST_DCE60(mask_sh) \
+	XFM_COMMON_MASK_SH_LIST_DCE60_COMMON_BASE(mask_sh), \
+	OPP_SF(DCFE_MEM_LIGHT_SLEEP_CNTL, REGAMMA_LUT_LIGHT_SLEEP_DIS, mask_sh),\
+	OPP_SF(DCFE_MEM_LIGHT_SLEEP_CNTL, DCP_LUT_LIGHT_SLEEP_DIS, mask_sh),\
+	OPP_SF(DCFE_MEM_LIGHT_SLEEP_CNTL, REGAMMA_LUT_MEM_PWR_STATE, mask_sh)
+
+#define XFM_COMMON_MASK_SH_LIST_DCE60_COMMON_BASE(mask_sh) \
+	XFM_SF(OUT_ROUND_CONTROL, OUT_ROUND_TRUNC_MODE, mask_sh), \
+	XFM_SF(DCP_SPATIAL_DITHER_CNTL, DCP_SPATIAL_DITHER_EN, mask_sh), \
+	XFM_SF(DCP_SPATIAL_DITHER_CNTL, DCP_SPATIAL_DITHER_MODE, mask_sh), \
+	XFM_SF(DCP_SPATIAL_DITHER_CNTL, DCP_SPATIAL_DITHER_DEPTH, mask_sh), \
+	XFM_SF(DCP_SPATIAL_DITHER_CNTL, DCP_FRAME_RANDOM_ENABLE, mask_sh), \
+	XFM_SF(DCP_SPATIAL_DITHER_CNTL, DCP_RGB_RANDOM_ENABLE, mask_sh), \
+	XFM_SF(DCP_SPATIAL_DITHER_CNTL, DCP_HIGHPASS_RANDOM_ENABLE, mask_sh), \
+	XFM_SF(DENORM_CONTROL, DENORM_MODE, mask_sh), \
+	XFM_SF(DATA_FORMAT, INTERLEAVE_EN, mask_sh), \
+	XFM_SF(GAMUT_REMAP_C11_C12, GAMUT_REMAP_C11, mask_sh), \
+	XFM_SF(GAMUT_REMAP_C11_C12, GAMUT_REMAP_C12, mask_sh), \
+	XFM_SF(GAMUT_REMAP_C13_C14, GAMUT_REMAP_C13, mask_sh), \
+	XFM_SF(GAMUT_REMAP_C13_C14, GAMUT_REMAP_C14, mask_sh), \
+	XFM_SF(GAMUT_REMAP_C21_C22, GAMUT_REMAP_C21, mask_sh), \
+	XFM_SF(GAMUT_REMAP_C21_C22, GAMUT_REMAP_C22, mask_sh), \
+	XFM_SF(GAMUT_REMAP_C23_C24, GAMUT_REMAP_C23, mask_sh), \
+	XFM_SF(GAMUT_REMAP_C23_C24, GAMUT_REMAP_C24, mask_sh), \
+	XFM_SF(GAMUT_REMAP_C31_C32, GAMUT_REMAP_C31, mask_sh), \
+	XFM_SF(GAMUT_REMAP_C31_C32, GAMUT_REMAP_C32, mask_sh), \
+	XFM_SF(GAMUT_REMAP_C33_C34, GAMUT_REMAP_C33, mask_sh), \
+	XFM_SF(GAMUT_REMAP_C33_C34, GAMUT_REMAP_C34, mask_sh), \
+	XFM_SF(GAMUT_REMAP_CONTROL, GRPH_GAMUT_REMAP_MODE, mask_sh), \
+	XFM_SF(OUTPUT_CSC_C11_C12, OUTPUT_CSC_C11, mask_sh),\
+	XFM_SF(OUTPUT_CSC_C11_C12, OUTPUT_CSC_C12, mask_sh),\
+	XFM_SF(OUTPUT_CSC_CONTROL, OUTPUT_CSC_GRPH_MODE, mask_sh),\
+	XFM_SF(REGAMMA_CNTLA_START_CNTL, REGAMMA_CNTLA_EXP_REGION_START, mask_sh),\
+	XFM_SF(REGAMMA_CNTLA_START_CNTL, REGAMMA_CNTLA_EXP_REGION_START_SEGMENT, mask_sh),\
+	XFM_SF(REGAMMA_CNTLA_SLOPE_CNTL, REGAMMA_CNTLA_EXP_REGION_LINEAR_SLOPE, mask_sh),\
+	XFM_SF(REGAMMA_CNTLA_END_CNTL1, REGAMMA_CNTLA_EXP_REGION_END, mask_sh),\
+	XFM_SF(REGAMMA_CNTLA_END_CNTL2, REGAMMA_CNTLA_EXP_REGION_END_BASE, mask_sh),\
+	XFM_SF(REGAMMA_CNTLA_END_CNTL2, REGAMMA_CNTLA_EXP_REGION_END_SLOPE, mask_sh),\
+	XFM_SF(REGAMMA_CNTLA_REGION_0_1, REGAMMA_CNTLA_EXP_REGION0_LUT_OFFSET, mask_sh),\
+	XFM_SF(REGAMMA_CNTLA_REGION_0_1, REGAMMA_CNTLA_EXP_REGION0_NUM_SEGMENTS, mask_sh),\
+	XFM_SF(REGAMMA_CNTLA_REGION_0_1, REGAMMA_CNTLA_EXP_REGION1_LUT_OFFSET, mask_sh),\
+	XFM_SF(REGAMMA_CNTLA_REGION_0_1, REGAMMA_CNTLA_EXP_REGION1_NUM_SEGMENTS, mask_sh),\
+	XFM_SF(REGAMMA_LUT_WRITE_EN_MASK, REGAMMA_LUT_WRITE_EN_MASK, mask_sh),\
+	XFM_SF(REGAMMA_CONTROL, GRPH_REGAMMA_MODE, mask_sh),\
+	XFM_SF(SCL_TAP_CONTROL, SCL_H_NUM_OF_TAPS, mask_sh), \
+	XFM_SF(SCL_TAP_CONTROL, SCL_V_NUM_OF_TAPS, mask_sh), \
+	XFM_SF(SCL_BYPASS_CONTROL, SCL_BYPASS_MODE, mask_sh), \
+	XFM_SF(EXT_OVERSCAN_LEFT_RIGHT, EXT_OVERSCAN_LEFT, mask_sh), \
+	XFM_SF(EXT_OVERSCAN_LEFT_RIGHT, EXT_OVERSCAN_RIGHT, mask_sh), \
+	XFM_SF(EXT_OVERSCAN_TOP_BOTTOM, EXT_OVERSCAN_TOP, mask_sh), \
+	XFM_SF(EXT_OVERSCAN_TOP_BOTTOM, EXT_OVERSCAN_BOTTOM, mask_sh), \
+	XFM_SF(SCL_COEF_RAM_SELECT, SCL_C_RAM_FILTER_TYPE, mask_sh), \
+	XFM_SF(SCL_COEF_RAM_SELECT, SCL_C_RAM_PHASE, mask_sh), \
+	XFM_SF(SCL_COEF_RAM_SELECT, SCL_C_RAM_TAP_PAIR_IDX, mask_sh), \
+	XFM_SF(SCL_COEF_RAM_TAP_DATA, SCL_C_RAM_EVEN_TAP_COEF_EN, mask_sh), \
+	XFM_SF(SCL_COEF_RAM_TAP_DATA, SCL_C_RAM_EVEN_TAP_COEF, mask_sh), \
+	XFM_SF(SCL_COEF_RAM_TAP_DATA, SCL_C_RAM_ODD_TAP_COEF_EN, mask_sh), \
+	XFM_SF(SCL_COEF_RAM_TAP_DATA, SCL_C_RAM_ODD_TAP_COEF, mask_sh), \
+	XFM_SF(VIEWPORT_START, VIEWPORT_X_START, mask_sh), \
+	XFM_SF(VIEWPORT_START, VIEWPORT_Y_START, mask_sh), \
+	XFM_SF(VIEWPORT_SIZE, VIEWPORT_HEIGHT, mask_sh), \
+	XFM_SF(VIEWPORT_SIZE, VIEWPORT_WIDTH, mask_sh), \
+	XFM_SF(SCL_HORZ_FILTER_SCALE_RATIO, SCL_H_SCALE_RATIO, mask_sh), \
+	XFM_SF(SCL_VERT_FILTER_SCALE_RATIO, SCL_V_SCALE_RATIO, mask_sh), \
+	XFM_SF(DC_LB_MEMORY_SPLIT, DC_LB_MEMORY_CONFIG, mask_sh), \
+	XFM_SF(DC_LB_MEM_SIZE, DC_LB_MEM_SIZE, mask_sh)
+#endif
+
 #define XFM_COMMON_MASK_SH_LIST_SOC_BASE(mask_sh) \
 	XFM_SF(DCP0_OUT_CLAMP_CONTROL_B_CB, OUT_CLAMP_MIN_B_CB, mask_sh), \
 	XFM_SF(DCP0_OUT_CLAMP_CONTROL_B_CB, OUT_CLAMP_MAX_B_CB, mask_sh), \
@@ -302,6 +433,7 @@
 	type DCP_RGB_RANDOM_ENABLE; \
 	type DCP_HIGHPASS_RANDOM_ENABLE; \
 	type DENORM_MODE; \
+	type INTERLEAVE_EN; \
 	type PIXEL_DEPTH; \
 	type PIXEL_EXPAN_MODE; \
 	type GAMUT_REMAP_C11; \
@@ -367,6 +499,8 @@
 	type SCL_H_INIT_FRAC; \
 	type SCL_V_INIT_INT; \
 	type SCL_V_INIT_FRAC; \
+	type DC_LB_MEMORY_CONFIG; \
+	type DC_LB_MEM_SIZE; \
 	type LB_MEMORY_CONFIG; \
 	type LB_MEMORY_SIZE; \
 	type SCL_V_2TAP_HARDCODE_COEF_EN; \
@@ -383,6 +517,9 @@ struct dce_transform_mask {
 };
 
 struct dce_transform_registers {
+#if defined(CONFIG_DRM_AMD_DC_SI)
+	uint32_t DATA_FORMAT;
+#endif
 	uint32_t LB_DATA_FORMAT;
 	uint32_t GAMUT_REMAP_CONTROL;
 	uint32_t GAMUT_REMAP_C11_C12;
@@ -440,6 +577,10 @@ struct dce_transform_registers {
 	uint32_t SCL_HORZ_FILTER_INIT;
 	uint32_t SCL_VERT_FILTER_INIT;
 	uint32_t SCL_AUTOMATIC_MODE_CONTROL;
+#if defined(CONFIG_DRM_AMD_DC_SI)
+	uint32_t DC_LB_MEMORY_SPLIT;
+	uint32_t DC_LB_MEM_SIZE;
+#endif
 	uint32_t LB_MEMORY_CTRL;
 	uint32_t SCL_UPDATE;
 	uint32_t SCL_F_SHARP_CONTROL;
@@ -489,6 +630,15 @@ void dce_transform_construct(struct dce_transform *xfm_dce,
 	const struct dce_transform_shift *xfm_shift,
 	const struct dce_transform_mask *xfm_mask);
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+void dce60_transform_construct(struct dce_transform *xfm_dce,
+	struct dc_context *ctx,
+	uint32_t inst,
+	const struct dce_transform_registers *regs,
+	const struct dce_transform_shift *xfm_shift,
+	const struct dce_transform_mask *xfm_mask);
+#endif
+
 bool dce_transform_get_optimal_number_of_taps(
 	struct transform *xfm,
 	struct scaler_data *scl_data,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

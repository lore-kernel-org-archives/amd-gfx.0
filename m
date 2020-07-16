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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9141C433FB
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B8EF20787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tX2MOg3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B8EF20787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 416776ECF9;
	Thu, 16 Jul 2020 21:23:30 +0000 (UTC)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20::344])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A5A6C6ECED
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:27 +0000 (UTC)
Received: by mail-wm1-x344.google.com with SMTP id a6so6119314wmm.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=5oxbm+OwYrXJfeu8fsvHEXPJKp4UzzNYF3dRL7NE5CA=;
 b=tX2MOg3+ZHKBlX03kERqo7NI43lVs6PtSmZSDvdo8HccrmTpE+eb5EWqPv6QNFWxlw
 ZkMRqbN5DKxMtk4biYesN3tPlKlW5NxcXN0TWfZzqllNoerq5U/3dsotRZsgX9/weWuu
 A90ruhNswY3g8r7Vrs1ryBBRCcEvwB3MCbKXa01rcVYVzL7iLbeqjlbbenEn5E22dDJI
 KpdMLRvaEzhAwCmxaSyESdacv5fj8k5SdMB/DWv6/NgCWIRbu3MFUW+L5Kpzo7qFlGNc
 PEAS7EqQZ0zrS70iDpjgJRug5KaNOUP/h3YQMAuq/Vqcy1SWcSoiMnktjoMlXczPSCDu
 fQ0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=5oxbm+OwYrXJfeu8fsvHEXPJKp4UzzNYF3dRL7NE5CA=;
 b=j2xGGLmhrgLwK0NOEh50RlWZm/yKlqIB/7iL7qOp1Hra42XJEe93+mfQqCPBcVgsP/
 YfEzaccZ3Ob4/qpWxM2n+Y7JwEiAv7x3bMk/uCXYU5FNnUpRKFwEP7AfOShpvr5LgbZM
 0Fxfq/HOTDyVO4Rz/e+CvrV1SuW8jp5Ib+ye2+whIn+4H/ZSZEmlPKizOxXAlhZidqEV
 HBdzKumsFx+dB3qZbfk6ogUazVSQn/bE5wPDrQv0ovOJbNVMr9a/ovrxRYrn1YGH48/X
 zmqu/GOs/Qg8TWj1Wc/oUZuxQpstmKkGMiGIlajclJ1Cftondy4WZJkA1/J0k0xs5yOk
 cNMg==
X-Gm-Message-State: AOAM5324GZPMLvRt4v3ZzGrpQlKBxx+eWUckmi1uhtjRJ3Ofz6NDWJni
 bRQ9zpBWJDGTiIo9wLpEZxl0iqWa8jM=
X-Google-Smtp-Source: ABdhPJzin89YDoZLf6G1SwQjFSoM0FR65gZf7IpZuG5aKNwzW6CVXRDl8HLEI0xeHycDmZ7C84JcDg==
X-Received: by 2002:a1c:f219:: with SMTP id s25mr5859419wmc.2.1594934605851;
 Thu, 16 Jul 2020 14:23:25 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:25 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 17/27] drm/amd/display: dce_opp: add DCE6 specific macros,
 functions
Date: Thu, 16 Jul 2020 23:22:41 +0200
Message-Id: <20200716212251.1539094-18-issor.oruam@gmail.com>
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
DCE6 has no FMT_TRUNCATE_MODE bit in FMT_BIT_DEPTH_CONTROL register
DCE6 has no FMT_CLAMP_COMPONENT_{R,G,B} registers
DCE6 has no FMT_SUBSAMPLING_{MODE,ORDER} bits in FMT_CONTROL register

[How]
Add DCE6 specific macros definitions for OPP registers and masks
DCE6 OPP macros will avoid buiding errors when using DCE6 headers
Add dce60_set_truncation() w/o FMT_TRUNCATE_MODE bit programming
Add dce60_opp_set_clamping() w/o Format Clamp Component programming
Add dce60_opp_program_fmt() w/o Format Subsampling bits programming
Add dce60_opp_program_bit_depth_reduction() with dce60_set_truncation
Use dce60_opp_program_fmt() in dce60_opp_funcs
Use dce60_opp_program_bit_depth_reduction() in dce60_opp_funcs
Add DCE6 specific dce60_opp_construct

Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.c | 205 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dce/dce_opp.h |  49 +++++
 2 files changed, 254 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
index 51081d9ae3fb..e459ae65aaf7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.c
@@ -141,6 +141,47 @@ static void set_truncation(
 				params->flags.TRUNCATE_MODE);
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+/**
+ *	dce60_set_truncation
+ *	1) set truncation depth: 0 for 18 bpp or 1 for 24 bpp
+ *	2) enable truncation
+ *	3) HW remove 12bit FMT support for DCE11 power saving reason.
+ */
+static void dce60_set_truncation(
+		struct dce110_opp *opp110,
+		const struct bit_depth_reduction_params *params)
+{
+	/* DCE6 has no FMT_TRUNCATE_MODE bit in FMT_BIT_DEPTH_CONTROL reg */
+
+	/*Disable truncation*/
+	REG_UPDATE_2(FMT_BIT_DEPTH_CONTROL,
+			FMT_TRUNCATE_EN, 0,
+			FMT_TRUNCATE_DEPTH, 0);
+
+	if (params->pixel_encoding == PIXEL_ENCODING_YCBCR422) {
+		/*  8bpc trunc on YCbCr422*/
+		if (params->flags.TRUNCATE_DEPTH == 1)
+			REG_UPDATE_2(FMT_BIT_DEPTH_CONTROL,
+					FMT_TRUNCATE_EN, 1,
+					FMT_TRUNCATE_DEPTH, 1);
+		else if (params->flags.TRUNCATE_DEPTH == 2)
+			/*  10bpc trunc on YCbCr422*/
+			REG_UPDATE_2(FMT_BIT_DEPTH_CONTROL,
+					FMT_TRUNCATE_EN, 1,
+					FMT_TRUNCATE_DEPTH, 2);
+		return;
+	}
+	/* on other format-to do */
+	if (params->flags.TRUNCATE_ENABLED == 0)
+		return;
+	/*Set truncation depth and Enable truncation*/
+	REG_UPDATE_2(FMT_BIT_DEPTH_CONTROL,
+				FMT_TRUNCATE_EN, 1,
+				FMT_TRUNCATE_DEPTH,
+				params->flags.TRUNCATE_DEPTH);
+}
+#endif
 
 /**
  *	set_spatial_dither
@@ -373,6 +414,57 @@ void dce110_opp_set_clamping(
 	}
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+/**
+ *	Set Clamping for DCE6 parts
+ *	1) Set clamping format based on bpc - 0 for 6bpc (No clamping)
+ *		1 for 8 bpc
+ *		2 for 10 bpc
+ *		3 for 12 bpc
+ *		7 for programable
+ *	2) Enable clamp if Limited range requested
+ */
+void dce60_opp_set_clamping(
+	struct dce110_opp *opp110,
+	const struct clamping_and_pixel_encoding_params *params)
+{
+	REG_SET_2(FMT_CLAMP_CNTL, 0,
+		FMT_CLAMP_DATA_EN, 0,
+		FMT_CLAMP_COLOR_FORMAT, 0);
+
+	switch (params->clamping_level) {
+	case CLAMPING_FULL_RANGE:
+		break;
+	case CLAMPING_LIMITED_RANGE_8BPC:
+		REG_SET_2(FMT_CLAMP_CNTL, 0,
+			FMT_CLAMP_DATA_EN, 1,
+			FMT_CLAMP_COLOR_FORMAT, 1);
+		break;
+	case CLAMPING_LIMITED_RANGE_10BPC:
+		REG_SET_2(FMT_CLAMP_CNTL, 0,
+			FMT_CLAMP_DATA_EN, 1,
+			FMT_CLAMP_COLOR_FORMAT, 2);
+		break;
+	case CLAMPING_LIMITED_RANGE_12BPC:
+		REG_SET_2(FMT_CLAMP_CNTL, 0,
+			FMT_CLAMP_DATA_EN, 1,
+			FMT_CLAMP_COLOR_FORMAT, 3);
+		break;
+	case CLAMPING_LIMITED_RANGE_PROGRAMMABLE:
+		/*Set clamp control*/
+		REG_SET_2(FMT_CLAMP_CNTL, 0,
+			FMT_CLAMP_DATA_EN, 1,
+			FMT_CLAMP_COLOR_FORMAT, 7);
+
+		/* DCE6 does have FMT_CLAMP_COMPONENT_{R,G,B} registers */
+
+		break;
+	default:
+		break;
+	}
+}
+#endif
+
 /**
  *	set_pixel_encoding
  *
@@ -408,6 +500,39 @@ static void set_pixel_encoding(
 
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+/**
+ *	dce60_set_pixel_encoding
+ *	DCE6 has no FMT_SUBSAMPLING_{MODE,ORDER} bits in FMT_CONTROL reg
+ *	Set Pixel Encoding
+ *		0: RGB 4:4:4 or YCbCr 4:4:4 or YOnly
+ *		1: YCbCr 4:2:2
+ */
+static void dce60_set_pixel_encoding(
+	struct dce110_opp *opp110,
+	const struct clamping_and_pixel_encoding_params *params)
+{
+	if (opp110->opp_mask->FMT_CBCR_BIT_REDUCTION_BYPASS)
+		REG_UPDATE_2(FMT_CONTROL,
+				FMT_PIXEL_ENCODING, 0,
+				FMT_CBCR_BIT_REDUCTION_BYPASS, 0);
+	else
+		REG_UPDATE(FMT_CONTROL,
+				FMT_PIXEL_ENCODING, 0);
+
+	if (params->pixel_encoding == PIXEL_ENCODING_YCBCR422) {
+		REG_UPDATE(FMT_CONTROL,
+				FMT_PIXEL_ENCODING, 1);
+	}
+	if (params->pixel_encoding == PIXEL_ENCODING_YCBCR420) {
+		REG_UPDATE_2(FMT_CONTROL,
+				FMT_PIXEL_ENCODING, 2,
+				FMT_CBCR_BIT_REDUCTION_BYPASS, 1);
+	}
+
+}
+#endif
+
 void dce110_opp_program_bit_depth_reduction(
 	struct output_pixel_processor *opp,
 	const struct bit_depth_reduction_params *params)
@@ -419,6 +544,19 @@ void dce110_opp_program_bit_depth_reduction(
 	set_temporal_dither(opp110, params);
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+void dce60_opp_program_bit_depth_reduction(
+	struct output_pixel_processor *opp,
+	const struct bit_depth_reduction_params *params)
+{
+	struct dce110_opp *opp110 = TO_DCE110_OPP(opp);
+
+	dce60_set_truncation(opp110, params);
+	set_spatial_dither(opp110, params);
+	set_temporal_dither(opp110, params);
+}
+#endif
+
 void dce110_opp_program_clamping_and_pixel_encoding(
 	struct output_pixel_processor *opp,
 	const struct clamping_and_pixel_encoding_params *params)
@@ -429,6 +567,19 @@ void dce110_opp_program_clamping_and_pixel_encoding(
 	set_pixel_encoding(opp110, params);
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+void dce60_opp_program_clamping_and_pixel_encoding(
+	struct output_pixel_processor *opp,
+	const struct clamping_and_pixel_encoding_params *params)
+{
+	struct dce110_opp *opp110 = TO_DCE110_OPP(opp);
+
+	dce60_opp_set_clamping(opp110, params);
+	dce60_set_pixel_encoding(opp110, params);
+}
+#endif
+
+
 static void program_formatter_420_memory(struct output_pixel_processor *opp)
 {
 	struct dce110_opp *opp110 = TO_DCE110_OPP(opp);
@@ -526,7 +677,32 @@ void dce110_opp_program_fmt(
 	return;
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+void dce60_opp_program_fmt(
+	struct output_pixel_processor *opp,
+	struct bit_depth_reduction_params *fmt_bit_depth,
+	struct clamping_and_pixel_encoding_params *clamping)
+{
+	/* dithering is affected by <CrtcSourceSelect>, hence should be
+	 * programmed afterwards */
+
+	if (clamping->pixel_encoding == PIXEL_ENCODING_YCBCR420)
+		program_formatter_420_memory(opp);
+
+	dce60_opp_program_bit_depth_reduction(
+		opp,
+		fmt_bit_depth);
+
+	dce60_opp_program_clamping_and_pixel_encoding(
+		opp,
+		clamping);
+
+	if (clamping->pixel_encoding == PIXEL_ENCODING_YCBCR420)
+		program_formatter_reset_dig_resync_fifo(opp);
 
+	return;
+}
+#endif
 
 
 
@@ -541,6 +717,15 @@ static const struct opp_funcs funcs = {
 	.opp_program_bit_depth_reduction = dce110_opp_program_bit_depth_reduction
 };
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+static const struct opp_funcs dce60_opp_funcs = {
+	.opp_set_dyn_expansion = dce110_opp_set_dyn_expansion,
+	.opp_destroy = dce110_opp_destroy,
+	.opp_program_fmt = dce60_opp_program_fmt,
+	.opp_program_bit_depth_reduction = dce60_opp_program_bit_depth_reduction
+};
+#endif
+
 void dce110_opp_construct(struct dce110_opp *opp110,
 	struct dc_context *ctx,
 	uint32_t inst,
@@ -559,6 +744,26 @@ void dce110_opp_construct(struct dce110_opp *opp110,
 	opp110->opp_mask = opp_mask;
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+void dce60_opp_construct(struct dce110_opp *opp110,
+	struct dc_context *ctx,
+	uint32_t inst,
+	const struct dce_opp_registers *regs,
+	const struct dce_opp_shift *opp_shift,
+	const struct dce_opp_mask *opp_mask)
+{
+	opp110->base.funcs = &dce60_opp_funcs;
+
+	opp110->base.ctx = ctx;
+
+	opp110->base.inst = inst;
+
+	opp110->regs = regs;
+	opp110->opp_shift = opp_shift;
+	opp110->opp_mask = opp_mask;
+}
+#endif
+
 void dce110_opp_destroy(struct output_pixel_processor **opp)
 {
 	if (*opp)
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.h b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.h
index 2ab0147cbd9d..4d484ef60f35 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_opp.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_opp.h
@@ -81,6 +81,17 @@ enum dce110_opp_reg_type {
 	OPP_COMMON_REG_LIST_BASE(id), \
 	SRI(CONTROL, FMT_MEMORY, id)
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+#define OPP_DCE_60_REG_LIST(id) \
+	SRI(FMT_DYNAMIC_EXP_CNTL, FMT, id), \
+	SRI(FMT_BIT_DEPTH_CONTROL, FMT, id), \
+	SRI(FMT_CONTROL, FMT, id), \
+	SRI(FMT_DITHER_RAND_R_SEED, FMT, id), \
+	SRI(FMT_DITHER_RAND_G_SEED, FMT, id), \
+	SRI(FMT_DITHER_RAND_B_SEED, FMT, id), \
+	SRI(FMT_CLAMP_CNTL, FMT, id)
+#endif
+
 #define OPP_SF(reg_name, field_name, post_fix)\
 	.field_name = reg_name ## __ ## field_name ## post_fix
 
@@ -192,6 +203,35 @@ enum dce110_opp_reg_type {
 	OPP_SF(FMT0_FMT_CONTROL, FMT_SUBSAMPLING_ORDER, mask_sh),\
 	OPP_SF(FMT0_FMT_CONTROL, FMT_CBCR_BIT_REDUCTION_BYPASS, mask_sh)
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+#define OPP_COMMON_MASK_SH_LIST_DCE_60(mask_sh)\
+	OPP_SF(FMT_DYNAMIC_EXP_CNTL, FMT_DYNAMIC_EXP_EN, mask_sh),\
+	OPP_SF(FMT_DYNAMIC_EXP_CNTL, FMT_DYNAMIC_EXP_MODE, mask_sh),\
+	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TRUNCATE_EN, mask_sh),\
+	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TRUNCATE_DEPTH, mask_sh),\
+	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_SPATIAL_DITHER_EN, mask_sh),\
+	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_SPATIAL_DITHER_DEPTH, mask_sh),\
+	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_SPATIAL_DITHER_MODE, mask_sh),\
+	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_HIGHPASS_RANDOM_ENABLE, mask_sh),\
+	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_FRAME_RANDOM_ENABLE, mask_sh),\
+	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_RGB_RANDOM_ENABLE, mask_sh),\
+	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_EN, mask_sh),\
+	OPP_SF(FMT_DITHER_RAND_R_SEED, FMT_RAND_R_SEED, mask_sh),\
+	OPP_SF(FMT_DITHER_RAND_G_SEED, FMT_RAND_G_SEED, mask_sh),\
+	OPP_SF(FMT_DITHER_RAND_B_SEED, FMT_RAND_B_SEED, mask_sh),\
+	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_EN, mask_sh),\
+	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_RESET, mask_sh),\
+	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_OFFSET, mask_sh),\
+	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_DITHER_DEPTH, mask_sh),\
+	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_TEMPORAL_LEVEL, mask_sh),\
+	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_25FRC_SEL, mask_sh),\
+	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_50FRC_SEL, mask_sh),\
+	OPP_SF(FMT_BIT_DEPTH_CONTROL, FMT_75FRC_SEL, mask_sh),\
+	OPP_SF(FMT_CLAMP_CNTL, FMT_CLAMP_DATA_EN, mask_sh),\
+	OPP_SF(FMT_CLAMP_CNTL, FMT_CLAMP_COLOR_FORMAT, mask_sh),\
+	OPP_SF(FMT_CONTROL, FMT_PIXEL_ENCODING, mask_sh)
+#endif
+
 #define OPP_REG_FIELD_LIST(type) \
 	type FMT_DYNAMIC_EXP_EN; \
 	type FMT_DYNAMIC_EXP_MODE; \
@@ -279,6 +319,15 @@ void dce110_opp_construct(struct dce110_opp *opp110,
 	const struct dce_opp_shift *opp_shift,
 	const struct dce_opp_mask *opp_mask);
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+void dce60_opp_construct(struct dce110_opp *opp110,
+	struct dc_context *ctx,
+	uint32_t inst,
+	const struct dce_opp_registers *regs,
+	const struct dce_opp_shift *opp_shift,
+	const struct dce_opp_mask *opp_mask);
+#endif
+
 void dce110_opp_destroy(struct output_pixel_processor **opp);
 
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

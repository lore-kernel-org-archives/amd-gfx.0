Return-Path: <SRS0=xwQz=A3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFAEC433F2
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E60207DD
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LWbEx36j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E60207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C73B6ECF4;
	Thu, 16 Jul 2020 21:23:25 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1891C6ECF4
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:24 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id b6so8601197wrs.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=iwTPI0esP17Kv/FIvD6deYVyRSVj2+zzjLrHO6SV/Jg=;
 b=LWbEx36j+C1JcaTs+b3/Zre6oVvi2bs4vtAM/T6x2m6Cjs/0R9aJDihGqWg+bI7jFn
 nzK1lDi10A2Mso+EZTeR/4duMwCwfSjO5wdGNXWQQvbhXpCSsvq08r2zA0Dbzd11tcfJ
 zz1EXRIWCBKTwcSX/KuyC14UkXL5SRnAlF9Gei34bpQ/O7fSjN/HF2xvASyHb6X49F4O
 U0RjJ1ArGH6XnHDrdXkBBZ9+SIxslFNVGjHvlmca4b2RgMXJaXagXdAez3d3hWb/dSRR
 orm/pQmwGOgOmr0AeBvI2gdUycZbkCjr8Dhk6pwSF00/L8Vux0Xlhm9JtXC83rnrl0Ca
 KL3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=iwTPI0esP17Kv/FIvD6deYVyRSVj2+zzjLrHO6SV/Jg=;
 b=i+THBqhdIOWyjO+GS4IN5My052y4j54wDXCg7xUcij9iPCpgKwud5X93WpZBnrmw54
 H7Vh7PxEmXDOde9TEJ3WHqVGga8ZMApIAFYiGHgCdZtehMeywE00vUblp53DZpNxOZcJ
 3J8ePYDrRRCI85HdgiI8C3hhQly0cB7JgK2k35k/cpYrMJPtaOEKS656ZjnwFd1Ps+At
 afgldX4SfWB23AEBvi1cdf2oB2glDTazS4bQhQbj4Wj9gigXzhRbN5fn9vMOvPfmYwjv
 3EIYQr/ffq2f5FBWVZH7v+tzxm1LPiVFi3HG7TqenNzsgcXNv0T7vWTOYSw0xO+wZWpG
 VpYA==
X-Gm-Message-State: AOAM530tJEOf4D0onXQhPIXljvveZ7mjPIjBaOJXaDAv+b3rRiK4dy55
 Zt9wRVi12DHpVGTRfcqcrKtI029JnTw=
X-Google-Smtp-Source: ABdhPJxJYRZ49c4+qrYWVe+rQSXStLsMJKmj1jpM/RFzD6JuCyarzdHyZD9/P9BvR9W93XCivMgGjw==
X-Received: by 2002:a5d:628b:: with SMTP id k11mr6902798wru.107.1594934602376; 
 Thu, 16 Jul 2020 14:23:22 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:22 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 14/27] drm/amd/display: dce_ipp: add DCE6 specific macros,
 functions
Date: Thu, 16 Jul 2020 23:22:38 +0200
Message-Id: <20200716212251.1539094-15-issor.oruam@gmail.com>
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
DCE6 does not have CURSOR2_DEGAMMA_MODE bit in DEGAMMA_CONTROL register

[How]
Add DCE6 specific macros definitions for IPP masks
DCE6 IPP macros will avoid buiding errors when using DCE6 headers
Add dce60_ipp_set_degamma() function w/o Cursor2 Degamma programming
Use dce60_ipp_set_degamma() in ipp_funcs dce60_ipp_funcs
Add DCE6 specific dce60_ipp_construct

Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c | 46 ++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dce/dce_ipp.h | 49 ++++++++++++++++++++
 2 files changed, 95 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c b/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c
index ce30dbf579d4..80569a2734eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.c
@@ -231,6 +231,22 @@ static void dce_ipp_set_degamma(
 		  CURSOR2_DEGAMMA_MODE, degamma_type);
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+static void dce60_ipp_set_degamma(
+	struct input_pixel_processor *ipp,
+	enum ipp_degamma_mode mode)
+{
+	struct dce_ipp *ipp_dce = TO_DCE_IPP(ipp);
+	uint32_t degamma_type = (mode == IPP_DEGAMMA_MODE_HW_sRGB) ? 1 : 0;
+
+	ASSERT(mode == IPP_DEGAMMA_MODE_BYPASS || mode == IPP_DEGAMMA_MODE_HW_sRGB);
+	/* DCE6 does not have CURSOR2_DEGAMMA_MODE bit in DEGAMMA_CONTROL reg */
+	REG_SET_2(DEGAMMA_CONTROL, 0,
+		  GRPH_DEGAMMA_MODE, degamma_type,
+		  CURSOR_DEGAMMA_MODE, degamma_type);
+}
+#endif
+
 static const struct ipp_funcs dce_ipp_funcs = {
 	.ipp_cursor_set_attributes = dce_ipp_cursor_set_attributes,
 	.ipp_cursor_set_position = dce_ipp_cursor_set_position,
@@ -239,6 +255,17 @@ static const struct ipp_funcs dce_ipp_funcs = {
 	.ipp_set_degamma = dce_ipp_set_degamma
 };
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+static const struct ipp_funcs dce60_ipp_funcs = {
+	.ipp_cursor_set_attributes = dce_ipp_cursor_set_attributes,
+	.ipp_cursor_set_position = dce_ipp_cursor_set_position,
+	.ipp_program_prescale = dce_ipp_program_prescale,
+	.ipp_program_input_lut = dce_ipp_program_input_lut,
+	.ipp_set_degamma = dce60_ipp_set_degamma
+};
+#endif
+
+
 /*****************************************/
 /* Constructor, Destructor               */
 /*****************************************/
@@ -260,6 +287,25 @@ void dce_ipp_construct(
 	ipp_dce->ipp_mask = ipp_mask;
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+void dce60_ipp_construct(
+	struct dce_ipp *ipp_dce,
+	struct dc_context *ctx,
+	int inst,
+	const struct dce_ipp_registers *regs,
+	const struct dce_ipp_shift *ipp_shift,
+	const struct dce_ipp_mask *ipp_mask)
+{
+	ipp_dce->base.ctx = ctx;
+	ipp_dce->base.inst = inst;
+	ipp_dce->base.funcs = &dce60_ipp_funcs;
+
+	ipp_dce->regs = regs;
+	ipp_dce->ipp_shift = ipp_shift;
+	ipp_dce->ipp_mask = ipp_mask;
+}
+#endif
+
 void dce_ipp_destroy(struct input_pixel_processor **ipp)
 {
 	kfree(TO_DCE_IPP(*ipp));
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.h b/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.h
index ca04e97d44c3..0028d4bdd81b 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_ipp.h
@@ -147,6 +147,46 @@
 	IPP_SF(DCP0_DEGAMMA_CONTROL, CURSOR_DEGAMMA_MODE, mask_sh), \
 	IPP_SF(DCP0_DEGAMMA_CONTROL, CURSOR2_DEGAMMA_MODE, mask_sh)
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+#define IPP_DCE60_MASK_SH_LIST_DCE_COMMON_BASE(mask_sh) \
+	IPP_SF(CUR_UPDATE, CURSOR_UPDATE_LOCK, mask_sh), \
+	IPP_SF(CUR_CONTROL, CURSOR_EN, mask_sh), \
+	IPP_SF(CUR_CONTROL, CURSOR_MODE, mask_sh), \
+	IPP_SF(CUR_CONTROL, CURSOR_2X_MAGNIFY, mask_sh), \
+	IPP_SF(CUR_CONTROL, CUR_INV_TRANS_CLAMP, mask_sh), \
+	IPP_SF(CUR_POSITION, CURSOR_X_POSITION, mask_sh), \
+	IPP_SF(CUR_POSITION, CURSOR_Y_POSITION, mask_sh), \
+	IPP_SF(CUR_HOT_SPOT, CURSOR_HOT_SPOT_X, mask_sh), \
+	IPP_SF(CUR_HOT_SPOT, CURSOR_HOT_SPOT_Y, mask_sh), \
+	IPP_SF(CUR_COLOR1, CUR_COLOR1_BLUE, mask_sh), \
+	IPP_SF(CUR_COLOR1, CUR_COLOR1_GREEN, mask_sh), \
+	IPP_SF(CUR_COLOR1, CUR_COLOR1_RED, mask_sh), \
+	IPP_SF(CUR_COLOR2, CUR_COLOR2_BLUE, mask_sh), \
+	IPP_SF(CUR_COLOR2, CUR_COLOR2_GREEN, mask_sh), \
+	IPP_SF(CUR_COLOR2, CUR_COLOR2_RED, mask_sh), \
+	IPP_SF(CUR_SIZE, CURSOR_WIDTH, mask_sh), \
+	IPP_SF(CUR_SIZE, CURSOR_HEIGHT, mask_sh), \
+	IPP_SF(CUR_SURFACE_ADDRESS_HIGH, CURSOR_SURFACE_ADDRESS_HIGH, mask_sh), \
+	IPP_SF(CUR_SURFACE_ADDRESS, CURSOR_SURFACE_ADDRESS, mask_sh), \
+	IPP_SF(PRESCALE_GRPH_CONTROL, GRPH_PRESCALE_BYPASS, mask_sh), \
+	IPP_SF(PRESCALE_VALUES_GRPH_R, GRPH_PRESCALE_SCALE_R, mask_sh), \
+	IPP_SF(PRESCALE_VALUES_GRPH_R, GRPH_PRESCALE_BIAS_R, mask_sh), \
+	IPP_SF(PRESCALE_VALUES_GRPH_G, GRPH_PRESCALE_SCALE_G, mask_sh), \
+	IPP_SF(PRESCALE_VALUES_GRPH_G, GRPH_PRESCALE_BIAS_G, mask_sh), \
+	IPP_SF(PRESCALE_VALUES_GRPH_B, GRPH_PRESCALE_SCALE_B, mask_sh), \
+	IPP_SF(PRESCALE_VALUES_GRPH_B, GRPH_PRESCALE_BIAS_B, mask_sh), \
+	IPP_SF(INPUT_GAMMA_CONTROL, GRPH_INPUT_GAMMA_MODE, mask_sh), \
+	IPP_SF(DC_LUT_WRITE_EN_MASK, DC_LUT_WRITE_EN_MASK, mask_sh), \
+	IPP_SF(DC_LUT_RW_MODE, DC_LUT_RW_MODE, mask_sh), \
+	IPP_SF(DC_LUT_CONTROL, DC_LUT_DATA_R_FORMAT, mask_sh), \
+	IPP_SF(DC_LUT_CONTROL, DC_LUT_DATA_G_FORMAT, mask_sh), \
+	IPP_SF(DC_LUT_CONTROL, DC_LUT_DATA_B_FORMAT, mask_sh), \
+	IPP_SF(DC_LUT_RW_INDEX, DC_LUT_RW_INDEX, mask_sh), \
+	IPP_SF(DC_LUT_SEQ_COLOR, DC_LUT_SEQ_COLOR, mask_sh), \
+	IPP_SF(DEGAMMA_CONTROL, GRPH_DEGAMMA_MODE, mask_sh), \
+	IPP_SF(DEGAMMA_CONTROL, CURSOR_DEGAMMA_MODE, mask_sh)
+#endif
+
 #define IPP_REG_FIELD_LIST(type) \
 	type CURSOR_UPDATE_LOCK; \
 	type CURSOR_EN; \
@@ -233,6 +273,15 @@ void dce_ipp_construct(struct dce_ipp *ipp_dce,
 	const struct dce_ipp_shift *ipp_shift,
 	const struct dce_ipp_mask *ipp_mask);
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+void dce60_ipp_construct(struct dce_ipp *ipp_dce,
+	struct dc_context *ctx,
+	int inst,
+	const struct dce_ipp_registers *regs,
+	const struct dce_ipp_shift *ipp_shift,
+	const struct dce_ipp_mask *ipp_mask);
+#endif
+
 void dce_ipp_destroy(struct input_pixel_processor **ipp);
 
 #endif /* _DCE_IPP_H_ */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

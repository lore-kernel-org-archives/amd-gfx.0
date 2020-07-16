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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEA16C433FC
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:32 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8030620787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SD2QhcAy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8030620787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21D6E6ECF8;
	Thu, 16 Jul 2020 21:23:32 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FFEC6ECFA
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:30 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id z2so8668378wrp.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=WPA8YI4EMiyXJ9siv1XMPxcQyUraoARWxACqmUOxRhw=;
 b=SD2QhcAynDO+8TR4zb343xic/F1W6W6+uS7XbQhfOB+E1WdGORB24ke+Jj/zWEPez0
 dPVVrPJRuxXJFpueB9JswBOGHg19RD1ye6gWWSwt5VtuBIrgUOH7UHh+Uedq+oYemtXg
 RQ4du9vM+3mclo26e6L6/jHEaZKprafHM3q8m7pHoKSukE48Q1YNVsdbwqv7sXvUfgDv
 wdv4H10vhRnCAcwIxJM4Td3fzmCbAdpK6TiBdIWneVK+fIbaLQKiCnYic+bXXQBUMTyj
 zvnw8v700aD8mCSt2l0zxq8kF/OuxFt1LhtDvQwctA/Lclegj6RL6EUBjXezrAanc9bO
 e3qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WPA8YI4EMiyXJ9siv1XMPxcQyUraoARWxACqmUOxRhw=;
 b=R83Vr6QR96cqbrpYJuCksNooCzpwnxtPact9iuEOLtIfj765mSQZ7sFsIdAtWPZfPU
 TbTZ5t5YmNi2AYz2lAdajV2lCZZPkVphvDL/L9wqvyeBINu8bBvQOWszkyWoMc/8hsdj
 yGlKrarrFWNWIXGVHvUagBn9cbBbv4bGiST6zUMJ0M936gnC7I388DZIJ5RJZHYrPkPn
 kp8/inqe79Pe/jx3q38tAY72XRVA7h0BQJclb619uUdZZylOggA8Le1iQhzlTpv3TyCb
 zUEKk6rt62Ott6tkKWJwKdKtqeuZrrqUjVzbHp5KjL3YzFFbd+iNdfabc5amZEZmv9SS
 QsVQ==
X-Gm-Message-State: AOAM5334rMDDrxe0fySLA84weZjAd4FooxdZLp0aUAKj+N8NS1xu5bDV
 ijcyE7zzqjS904hMYLegV0siWSQe5Z0=
X-Google-Smtp-Source: ABdhPJwWeosr+JTmxoyuM4SkPNAKRAsPRnIFeiNDVuRExqJjoXSHzEAy0LxDmvtSBtXXWKj3wd/QtA==
X-Received: by 2002:adf:d08a:: with SMTP id y10mr383308wrh.361.1594934608675; 
 Thu, 16 Jul 2020 14:23:28 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:28 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 20/27] drm/amd/display: dce_transform: DCE6 Scaling
 Horizontal Filter Init
Date: Thu, 16 Jul 2020 23:22:44 +0200
Message-Id: <20200716212251.1539094-21-issor.oruam@gmail.com>
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
DCE6 has specific SCL_HORZ_FILTER_INIT_{LUMA_RGB,CHROMA} registers
In DCE6 h_init_luma and h_init_chroma initialization is required
Some DCE6 specific SCL_{HORZ,VERT}_FILTER_CONTROL masks were not listed

[How]
Add the registers and masks in dce_transform.h
Add DCE6 specific struct sclh_ratios_inits in dce_transform.h
Add dce60_calculate_inits() function
Add dce60_program_scl_ratios_inits() function
Fix dce60_transform_set_scaler() function

Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
---
 .../drm/amd/display/dc/dce/dce_transform.c    | 73 +++++++++++++++++--
 .../drm/amd/display/dc/dce/dce_transform.h    | 28 +++++++
 2 files changed, 96 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
index 3303d01c1aae..51ad48e36a8a 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.c
@@ -306,6 +306,37 @@ static void calculate_inits(
 	inits->v_init.fraction = dc_fixpt_u0d19(v_init) << 5;
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+static void dce60_calculate_inits(
+	struct dce_transform *xfm_dce,
+	const struct scaler_data *data,
+	struct sclh_ratios_inits *inits)
+{
+	struct fixed31_32 h_init;
+	struct fixed31_32 v_init;
+
+	inits->h_int_scale_ratio =
+		dc_fixpt_u2d19(data->ratios.horz) << 5;
+	inits->v_int_scale_ratio =
+		dc_fixpt_u2d19(data->ratios.vert) << 5;
+
+	/* DCE6 h_init_luma setting inspired by DCE110 */
+	inits->h_init_luma.integer = 1;
+
+	/* DCE6 h_init_chroma setting inspired by DCE110 */
+	inits->h_init_chroma.integer = 1;
+
+	v_init =
+		dc_fixpt_div_int(
+			dc_fixpt_add(
+				data->ratios.vert,
+				dc_fixpt_from_int(data->taps.v_taps + 1)),
+				2);
+	inits->v_init.integer = dc_fixpt_floor(v_init);
+	inits->v_init.fraction = dc_fixpt_u0d19(v_init) << 5;
+}
+#endif
+
 static void program_scl_ratios_inits(
 	struct dce_transform *xfm_dce,
 	struct scl_ratios_inits *inits)
@@ -328,6 +359,36 @@ static void program_scl_ratios_inits(
 	REG_WRITE(SCL_AUTOMATIC_MODE_CONTROL, 0);
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+static void dce60_program_scl_ratios_inits(
+	struct dce_transform *xfm_dce,
+	struct sclh_ratios_inits *inits)
+{
+
+	REG_SET(SCL_HORZ_FILTER_SCALE_RATIO, 0,
+			SCL_H_SCALE_RATIO, inits->h_int_scale_ratio);
+
+	REG_SET(SCL_VERT_FILTER_SCALE_RATIO, 0,
+			SCL_V_SCALE_RATIO, inits->v_int_scale_ratio);
+
+	/* DCE6 has SCL_HORZ_FILTER_INIT_RGB_LUMA register */
+	REG_SET_2(SCL_HORZ_FILTER_INIT_RGB_LUMA, 0,
+			SCL_H_INIT_INT_RGB_Y, inits->h_init_luma.integer,
+			SCL_H_INIT_FRAC_RGB_Y, inits->h_init_luma.fraction);
+
+	/* DCE6 has SCL_HORZ_FILTER_INIT_CHROMA register */
+	REG_SET_2(SCL_HORZ_FILTER_INIT_CHROMA, 0,
+			SCL_H_INIT_INT_CBCR, inits->h_init_chroma.integer,
+			SCL_H_INIT_FRAC_CBCR, inits->h_init_chroma.fraction);
+
+	REG_SET_2(SCL_VERT_FILTER_INIT, 0,
+			SCL_V_INIT_INT, inits->v_init.integer,
+			SCL_V_INIT_FRAC, inits->v_init.fraction);
+
+	REG_WRITE(SCL_AUTOMATIC_MODE_CONTROL, 0);
+}
+#endif
+
 static const uint16_t *get_filter_coeffs_16p(int taps, struct fixed31_32 ratio)
 {
 	if (taps == 4)
@@ -453,12 +514,14 @@ static void dce60_transform_set_scaler(
 	is_scaling_required = dce60_setup_scaling_configuration(xfm_dce, data);
 
 	if (is_scaling_required) {
-		/* 3. Calculate and program ratio, filter initialization */
-		struct scl_ratios_inits inits = { 0 };
+		/* 3. Calculate and program ratio, DCE6 filter initialization */
+		struct sclh_ratios_inits inits = { 0 };
 
-		calculate_inits(xfm_dce, data, &inits);
+		/* DCE6 has specific calculate_inits() function */
+		dce60_calculate_inits(xfm_dce, data, &inits);
 
-		program_scl_ratios_inits(xfm_dce, &inits);
+		/* DCE6 has specific program_scl_ratios_inits() function */
+		dce60_program_scl_ratios_inits(xfm_dce, &inits);
 
 		coeffs_v = get_filter_coeffs_16p(data->taps.v_taps, data->ratios.vert);
 		coeffs_h = get_filter_coeffs_16p(data->taps.h_taps, data->ratios.horz);
@@ -503,7 +566,7 @@ static void dce60_transform_set_scaler(
 	/* 6. Program the viewport */
 	program_viewport(xfm_dce, &data->viewport);
 
-	/* DCE6 does not have bit to flip to new coefficient memory */
+	/* DCE6 has no SCL_COEF_UPDATE_COMPLETE bit to flip to new coefficient memory */
 
 	/* DCE6 DATA_FORMAT register does not support ALPHA_EN */
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
index 95b28dadc8c5..cbce194ec7b8 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_transform.h
@@ -331,6 +331,14 @@
 	XFM_SF(VIEWPORT_SIZE, VIEWPORT_WIDTH, mask_sh), \
 	XFM_SF(SCL_HORZ_FILTER_SCALE_RATIO, SCL_H_SCALE_RATIO, mask_sh), \
 	XFM_SF(SCL_VERT_FILTER_SCALE_RATIO, SCL_V_SCALE_RATIO, mask_sh), \
+	XFM_SF(SCL_HORZ_FILTER_INIT_RGB_LUMA, SCL_H_INIT_INT_RGB_Y, mask_sh), \
+	XFM_SF(SCL_HORZ_FILTER_INIT_RGB_LUMA, SCL_H_INIT_FRAC_RGB_Y, mask_sh), \
+	XFM_SF(SCL_HORZ_FILTER_INIT_CHROMA, SCL_H_INIT_INT_CBCR, mask_sh), \
+	XFM_SF(SCL_HORZ_FILTER_INIT_CHROMA, SCL_H_INIT_FRAC_CBCR, mask_sh), \
+	XFM_SF(SCL_VERT_FILTER_INIT, SCL_V_INIT_INT, mask_sh), \
+	XFM_SF(SCL_VERT_FILTER_INIT, SCL_V_INIT_FRAC, mask_sh), \
+	XFM_SF(SCL_HORZ_FILTER_CONTROL, SCL_H_FILTER_PICK_NEAREST, mask_sh), \
+	XFM_SF(SCL_VERT_FILTER_CONTROL, SCL_V_FILTER_PICK_NEAREST, mask_sh), \
 	XFM_SF(DC_LB_MEMORY_SPLIT, DC_LB_MEMORY_CONFIG, mask_sh), \
 	XFM_SF(DC_LB_MEM_SIZE, DC_LB_MEM_SIZE, mask_sh)
 #endif
@@ -497,6 +505,10 @@
 	type SCL_V_SCALE_RATIO; \
 	type SCL_H_INIT_INT; \
 	type SCL_H_INIT_FRAC; \
+	type SCL_H_INIT_INT_RGB_Y; \
+	type SCL_H_INIT_FRAC_RGB_Y; \
+	type SCL_H_INIT_INT_CBCR; \
+	type SCL_H_INIT_FRAC_CBCR; \
 	type SCL_V_INIT_INT; \
 	type SCL_V_INIT_FRAC; \
 	type DC_LB_MEMORY_CONFIG; \
@@ -505,6 +517,8 @@
 	type LB_MEMORY_SIZE; \
 	type SCL_V_2TAP_HARDCODE_COEF_EN; \
 	type SCL_H_2TAP_HARDCODE_COEF_EN; \
+	type SCL_V_FILTER_PICK_NEAREST; \
+	type SCL_H_FILTER_PICK_NEAREST; \
 	type SCL_COEF_UPDATE_COMPLETE; \
 	type ALPHA_EN
 
@@ -575,6 +589,10 @@ struct dce_transform_registers {
 	uint32_t SCL_HORZ_FILTER_SCALE_RATIO;
 	uint32_t SCL_VERT_FILTER_SCALE_RATIO;
 	uint32_t SCL_HORZ_FILTER_INIT;
+#if defined(CONFIG_DRM_AMD_DC_SI)
+	uint32_t SCL_HORZ_FILTER_INIT_RGB_LUMA;
+	uint32_t SCL_HORZ_FILTER_INIT_CHROMA;
+#endif
 	uint32_t SCL_VERT_FILTER_INIT;
 	uint32_t SCL_AUTOMATIC_MODE_CONTROL;
 #if defined(CONFIG_DRM_AMD_DC_SI)
@@ -598,6 +616,16 @@ struct scl_ratios_inits {
 	struct init_int_and_frac v_init;
 };
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+struct sclh_ratios_inits {
+	uint32_t h_int_scale_ratio;
+	uint32_t v_int_scale_ratio;
+	struct init_int_and_frac h_init_luma;
+	struct init_int_and_frac h_init_chroma;
+	struct init_int_and_frac v_init;
+};
+#endif
+
 enum ram_filter_type {
 	FILTER_TYPE_RGB_Y_VERTICAL	= 0, /* 0 - RGB/Y Vertical filter */
 	FILTER_TYPE_CBCR_VERTICAL	= 1, /* 1 - CbCr  Vertical filter */
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

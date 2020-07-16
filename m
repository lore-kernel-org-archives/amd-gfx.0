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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C052C43458
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6EB7220787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pNuipgmt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6EB7220787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 338386ECFE;
	Thu, 16 Jul 2020 21:23:37 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com
 [IPv6:2a00:1450:4864:20::430])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB1646ECFB
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:33 +0000 (UTC)
Received: by mail-wr1-x430.google.com with SMTP id r12so8549160wrj.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YHwJQcedQhttw7mtON6s0uW8hl2PvBEhpvVb9iB6wH8=;
 b=pNuipgmtiwMPQrHOU2Vl98zUNTqud4cfshffRYdmSpo+lZKPrLIY7alsUwVKMMFn/I
 KzYqoMmAlQr2A0NLZppJbu3RiIAODut1hY1PDlZuvHWrXKAU05F0jMembSxdZQEKm2m+
 oYcdhHhRtfZI+b0ct7TI5FANtV/0H3VoEdZybvp3+uEPJzAItfcKE2VTS2DrFL5+UFNQ
 gN86QjIG2Y5G9ookomLZbgwhoiOQoJlcgq+6HizhfCr6DhIzu/jc8fpwamhO2Tu4O4he
 YVRXp8PAAzimdJajcloliJLC1mbg7oaiV2WISqVKbDNKhJxj9dilv0bokAgTo1LFCEoc
 5hIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YHwJQcedQhttw7mtON6s0uW8hl2PvBEhpvVb9iB6wH8=;
 b=B/GOQho+S3ABPcnmodhWjUZsVr0jEKNHWig2bEne3m5wVG61gnxEXhTh9YTuL43j/6
 a/zuV4RJDHQEQtMyyksOllyovbLL1y8zaKYqU4sjBWtrnyiLNRY2lXbZe+ai9tQK8dva
 NXGFFHRGfO+uJ7P4nNorwHO3aB27kxoqt54XbGSGMqj3Yoqd9SpoH+LsQNowSFlrcwgD
 OVG+NnK4WVPU/K8rta6xg6mqyK5IeeBl8hKMG+W7i7H8bueS9NfEJwhviF9w7IFMEnr6
 x6EbswXEQxjgK7CdcFpOcxdjU5nUxHLd2YrtFTvQKoEOVFyibNOSNXLBE+DPq+PrMb/E
 rjwA==
X-Gm-Message-State: AOAM532XN+fWkKpEDF/jj446B719nQAOYltFgAdcKjzshKxkuGmnG9/H
 rafAggagSE8j0Q3/ylYhNZwPLVkhHos=
X-Google-Smtp-Source: ABdhPJyxSQhjC97WLpTJ6c3eEHNfdBgsm6771nPSpA++xgx5YOjwO7NauAZXPkft0uf0DxER92caPw==
X-Received: by 2002:adf:a111:: with SMTP id o17mr6683460wro.257.1594934611943; 
 Thu, 16 Jul 2020 14:23:31 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:31 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 23/27] drm/amd/display: dce60_timing_generator: add DCE6
 specific functions
Date: Thu, 16 Jul 2020 23:22:47 +0200
Message-Id: <20200716212251.1539094-24-issor.oruam@gmail.com>
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
DCE6 has CRTC_PREFETCH_EN bit in CRTC_CONTROL register
DCE6 has no CRTC_LEGACY_REQUESTOR_EN bit in CRTC_START_LINE_CONTROL register
DCE6 has no CRTC_CRC_CNTL register

[How]
Modify dce60_timing_generator_enable_advanced_request() function
Add dce60_configure_crc() function and dce60_is_tg_enabled() kept as static
Use dce60_configure_crc() function in dce60_tg_funcs

Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
---
 .../display/dc/dce60/dce60_timing_generator.c | 57 +++++++++++++------
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  | 11 ++++
 2 files changed, 50 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c
index eb9705e9d40a..4a5b7a0940c6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_timing_generator.c
@@ -128,20 +128,12 @@ static void dce60_timing_generator_enable_advanced_request(
 	struct dce110_timing_generator *tg110 = DCE110TG_FROM_TG(tg);
 	uint32_t addr = CRTC_REG(mmCRTC_START_LINE_CONTROL);
 	uint32_t value = dm_read_reg(tg->ctx, addr);
+	/* DCE6 has CRTC_PREFETCH_EN bit in CRTC_CONTROL register */
+	uint32_t addr2 = CRTC_REG(mmCRTC_CONTROL);
+	uint32_t value2 = dm_read_reg(tg->ctx, addr2);
 
-	if (enable) {
-		set_reg_field_value(
-			value,
-			0,
-			CRTC_START_LINE_CONTROL,
-			CRTC_LEGACY_REQUESTOR_EN);
-	} else {
-		set_reg_field_value(
-			value,
-			1,
-			CRTC_START_LINE_CONTROL,
-			CRTC_LEGACY_REQUESTOR_EN);
-	}
+	/* DCE6 does not support CRTC_LEGACY_REQUESTOR_EN bit
+	   so here is not possible to set bit based on enable argument */
 
 	if ((timing->v_sync_width + timing->v_front_porch) <= 3) {
 		set_reg_field_value(
@@ -150,9 +142,9 @@ static void dce60_timing_generator_enable_advanced_request(
 			CRTC_START_LINE_CONTROL,
 			CRTC_ADVANCED_START_LINE_POSITION);
 		set_reg_field_value(
-			value,
+			value2,
 			0,
-			CRTC_START_LINE_CONTROL,
+			CRTC_CONTROL,
 			CRTC_PREFETCH_EN);
 	} else {
 		set_reg_field_value(
@@ -161,9 +153,9 @@ static void dce60_timing_generator_enable_advanced_request(
 			CRTC_START_LINE_CONTROL,
 			CRTC_ADVANCED_START_LINE_POSITION);
 		set_reg_field_value(
-			value,
+			value2,
 			1,
-			CRTC_START_LINE_CONTROL,
+			CRTC_CONTROL,
 			CRTC_PREFETCH_EN);
 	}
 
@@ -180,6 +172,35 @@ static void dce60_timing_generator_enable_advanced_request(
 		CRTC_INTERLACE_START_LINE_EARLY);
 
 	dm_write_reg(tg->ctx, addr, value);
+	dm_write_reg(tg->ctx, addr2, value2);
+}
+
+static bool dce60_is_tg_enabled(struct timing_generator *tg)
+{
+	uint32_t addr = 0;
+	uint32_t value = 0;
+	uint32_t field = 0;
+	struct dce110_timing_generator *tg110 = DCE110TG_FROM_TG(tg);
+
+	addr = CRTC_REG(mmCRTC_CONTROL);
+	value = dm_read_reg(tg->ctx, addr);
+	field = get_reg_field_value(value, CRTC_CONTROL,
+				    CRTC_CURRENT_MASTER_EN_STATE);
+	return field == 1;
+}
+
+bool dce60_configure_crc(struct timing_generator *tg,
+			  const struct crc_params *params)
+{
+	struct dce110_timing_generator *tg110 = DCE110TG_FROM_TG(tg);
+
+	/* Cannot configure crc on a CRTC that is disabled */
+	if (!dce60_is_tg_enabled(tg))
+		return false;
+
+	/* DCE6 has no CRTC_CRC_CNTL register, nothing to do */
+
+	return true;
 }
 
 static const struct timing_generator_funcs dce60_tg_funcs = {
@@ -217,7 +238,7 @@ static const struct timing_generator_funcs dce60_tg_funcs = {
 		/* DCE6.0 overrides */
 		.enable_advanced_request =
 				dce60_timing_generator_enable_advanced_request,
-		.configure_crc = dce110_configure_crc,
+		.configure_crc = dce60_configure_crc,
 		.get_crc = dce110_get_crc,
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index 4e6e18bbef5d..ca9eedb643f2 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -88,6 +88,11 @@ enum dentist_divider_range {
 	.DPREFCLK_CNTL = mmDPREFCLK_CNTL, \
 	.DENTIST_DISPCLK_CNTL = mmDENTIST_DISPCLK_CNTL
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+#define CLK_COMMON_REG_LIST_DCE60_BASE() \
+	SR(DENTIST_DISPCLK_CNTL)
+#endif
+
 #define CLK_COMMON_REG_LIST_DCN_BASE() \
 	SR(DENTIST_DISPCLK_CNTL)
 
@@ -114,6 +119,12 @@ enum dentist_divider_range {
 	CLK_SF(DPREFCLK_CNTL, DPREFCLK_SRC_SEL, mask_sh), \
 	CLK_SF(DENTIST_DISPCLK_CNTL, DENTIST_DPREFCLK_WDIVIDER, mask_sh)
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+#define CLK_COMMON_MASK_SH_LIST_DCE60_COMMON_BASE(mask_sh) \
+	CLK_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, mask_sh),\
+	CLK_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, mask_sh)
+#endif
+
 #define CLK_COMMON_MASK_SH_LIST_DCN_COMMON_BASE(mask_sh) \
 	CLK_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, mask_sh),\
 	CLK_SF(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, mask_sh)
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

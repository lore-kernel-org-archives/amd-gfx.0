Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C18AC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63F5C2073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:22:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iG0/Lunq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63F5C2073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 117AB89EB7;
	Mon,  1 Jun 2020 18:22:57 +0000 (UTC)
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com
 [IPv6:2607:f8b0:4864:20::741])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 765F089E35
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:22:54 +0000 (UTC)
Received: by mail-qk1-x741.google.com with SMTP id v79so9972912qkb.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=UyhlU1aaELr/1RpadqNLkz9sQgU5CxA4BKWEkgoqFlE=;
 b=iG0/Lunq7xPeaq0UeHGeav7RppUg52t/NjRRyoP++RtbvnQ8TgeTOohFWDIilpUoLy
 HrhCwhEMiH99JlMp/EpujXuDdeW+wqxh/Cn2hTxOfrPl3pxs/2NoXGqUUjiEDtjKrQhD
 9Jqc9HvS/+hMF/gP+SJja869fWU3yEa5LjLdb1SF2sioAt5Q7g+23GSwqtXT9btNuplf
 y7lyK1d+tjutltamTh9d9LQzdXLhWvhR23bDcTbNPTbFeLxW58LTpdf+udBNi95CtbyJ
 s4rxMxLBO8w7FI2JruVoe/PxlaV84gBD6kA7fmCfTPEZTrVo/PrNO/t8EH764z+s+AmN
 5GwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UyhlU1aaELr/1RpadqNLkz9sQgU5CxA4BKWEkgoqFlE=;
 b=WHFe4aBjZoCrSY1ymvVGtixX6lykNeDdk7Cpot83oUHHnrtjRmdiIlkOIoB3IbZMMJ
 RqQNhGM4pMiufzfEAr9OF9uPutNYH7TrtQevJM3VgQ9hBmK7O9+zwl1k2GBKpR5HHusr
 eXxYYbmc5S9bdOtPstkE9ijXO7DbGgDfiTHGlgIRK34nCkOVDSViuGudy0UqjglHZrne
 aFDQeHd8E6rZlwI9iSGWLjIEefIMsYKlnzFv0m7qJ/jAM00lPGRq780FUsLK5cJXlqim
 5Q03eAnfdGqTs3Pasbpf2O7W+NXtVkIneDbsjr5a7RRAm4FtZ61hrl4Rr+FUVpeiK2AN
 wZ1A==
X-Gm-Message-State: AOAM531pnFSWaj5EGFrOmWGawS3y2GMjG9TQsYDNNreOOGK1GpHmqnwC
 AHS44+9o11qmzoPw5zUwou3TAJyn
X-Google-Smtp-Source: ABdhPJyYANCuOtD2NKum1MpmuYx+vxekN4IkvHdKU3UlxDj8rTCTjOAFSIi3U1LaPUXCrjZxsBZ0Xw==
X-Received: by 2002:a37:6851:: with SMTP id d78mr20961545qkc.86.1591035773345; 
 Mon, 01 Jun 2020 11:22:53 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:22:52 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 172/207] drm/amd/powerplay: update smu function for
 sienna_cichlid
Date: Mon,  1 Jun 2020 14:20:19 -0400
Message-Id: <20200601182054.1267858-83-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601182054.1267858-1-alexander.deucher@amd.com>
References: <20200601182054.1267858-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Add function to check whether baco is support for sienna cichlid.
Remove fucntion of get clock by type with latency as it will not be
called.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 101 ++++++++----------
 1 file changed, 45 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index c924ecf2899f..ce16cabb0780 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -21,7 +21,6 @@
  *
  */
 
-#include "pp_debug.h"
 #include <linux/firmware.h>
 #include <linux/pci.h>
 #include "amdgpu.h"
@@ -36,8 +35,9 @@
 #include "sienna_cichlid_ppt.h"
 #include "smu_v11_0_pptable.h"
 #include "smu_v11_0_7_ppsmc.h"
-
+#include "nbio/nbio_2_3_offset.h"
 #include "nbio/nbio_2_3_sh_mask.h"
+
 #include "asic_reg/mp/mp_11_0_sh_mask.h"
 
 #define FEATURE_MASK(feature) (1ULL << feature)
@@ -516,6 +516,10 @@ static int sienna_cichlid_tables_init(struct smu_context *smu, struct smu_table
 		return -ENOMEM;
 	smu_table->metrics_time = 0;
 
+	smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
+	if (!smu_table->watermarks_table)
+		return -ENOMEM;
+
 	return 0;
 }
 
@@ -867,40 +871,6 @@ static int sienna_cichlid_populate_umd_state_clk(struct smu_context *smu)
 	return ret;
 }
 
-static int sienna_cichlid_get_clock_by_type_with_latency(struct smu_context *smu,
-						 enum smu_clk_type clk_type,
-						 struct pp_clock_levels_with_latency *clocks)
-{
-	int ret = 0, i = 0;
-	uint32_t level_count = 0, freq = 0;
-
-	switch (clk_type) {
-	case SMU_GFXCLK:
-	case SMU_DCEFCLK:
-	case SMU_SOCCLK:
-		ret = smu_get_dpm_level_count(smu, clk_type, &level_count);
-		if (ret)
-			return ret;
-
-		level_count = min(level_count, (uint32_t)MAX_NUM_CLOCKS);
-		clocks->num_levels = level_count;
-
-		for (i = 0; i < level_count; i++) {
-			ret = smu_get_dpm_freq_by_index(smu, clk_type, i, &freq);
-			if (ret)
-				return ret;
-
-			clocks->data[i].clocks_in_khz = freq * 1000;
-			clocks->data[i].latency_in_us = 0;
-		}
-		break;
-	default:
-		break;
-	}
-
-	return ret;
-}
-
 static int sienna_cichlid_pre_display_config_changed(struct smu_context *smu)
 {
 	int ret = 0;
@@ -930,23 +900,13 @@ static int sienna_cichlid_display_config_changed(struct smu_context *smu)
 {
 	int ret = 0;
 
-	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
-	    !(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
-		ret = smu_write_watermarks_table(smu);
-		if (ret)
-			return ret;
-
-		smu->watermarks_bitmap |= WATERMARKS_LOADED;
-	}
-
 	if ((smu->watermarks_bitmap & WATERMARKS_EXIST) &&
 	    smu_feature_is_supported(smu, SMU_FEATURE_DPM_DCEFCLK_BIT) &&
 	    smu_feature_is_supported(smu, SMU_FEATURE_DPM_SOCCLK_BIT)) {
-		/* Sienna_Cichlid do not support to change display num currently */
-		ret = 0;
 #if 0
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_NumOfDisplays,
-						  smu->display_config->num_display, NULL);
+						  smu->display_config->num_display,
+						  NULL);
 #endif
 		if (ret)
 			return ret;
@@ -1211,8 +1171,6 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
 	}
 
 	if (smu->power_profile_mode == PP_SMC_POWER_PROFILE_CUSTOM) {
-		if (size < 0)
-			return -EINVAL;
 
 		ret = smu_update_table(smu,
 				       SMU_TABLE_ACTIVITY_MONITOR_COEFF, WORKLOAD_PPLIB_CUSTOM_BIT,
@@ -1338,8 +1296,14 @@ static int sienna_cichlid_notify_smc_display_config(struct smu_context *smu)
 		ret = smu_v11_0_display_clock_voltage_request(smu, &clock_req);
 		if (!ret) {
 			if (smu_feature_is_supported(smu, SMU_FEATURE_DS_DCEFCLK_BIT)) {
-				pr_err("Attempt to set divider for DCEFCLK Failed as it not support currently!");
-				return ret;
+				ret = smu_send_smc_msg_with_param(smu,
+								  SMU_MSG_SetMinDeepSleepDcefclk,
+								  min_clocks.dcef_clock_in_sr/100,
+								  NULL);
+				if (ret) {
+					pr_err("Attempt to set divider for DCEFCLK Failed!");
+					return ret;
+				}
 			}
 		} else {
 			pr_info("Attempt to set Hard Min for DCEFCLK Failed!");
@@ -1363,6 +1327,7 @@ static int sienna_cichlid_set_watermarks_table(struct smu_context *smu,
 				       *clock_ranges)
 {
 	int i;
+	int ret = 0;
 	Watermarks_t *table = watermarks;
 
 	if (!table || !clock_ranges)
@@ -1414,6 +1379,17 @@ static int sienna_cichlid_set_watermarks_table(struct smu_context *smu,
 				clock_ranges->wm_mcif_clocks_ranges[i].wm_set_id;
         }
 
+	smu->watermarks_bitmap |= WATERMARKS_EXIST;
+
+	if (!(smu->watermarks_bitmap & WATERMARKS_LOADED)) {
+		ret = smu_write_watermarks_table(smu);
+		if (ret) {
+			pr_err("Failed to update WMTABLE!");
+			return ret;
+		}
+		smu->watermarks_bitmap |= WATERMARKS_LOADED;
+	}
+
 	return 0;
 }
 
@@ -1705,8 +1681,10 @@ static int sienna_cichlid_update_pcie_parameters(struct smu_context *smu,
 					pcie_width_cap);
 
 		ret = smu_send_smc_msg_with_param(smu,
-						  SMU_MSG_OverridePcieParameters,
-						  smu_pcie_arg, NULL);
+					  SMU_MSG_OverridePcieParameters,
+					  smu_pcie_arg,
+					  NULL);
+
 		if (ret)
 			return ret;
 
@@ -1751,6 +1729,18 @@ int sienna_cichlid_set_soft_freq_limited_range(struct smu_context *smu,
 	return ret;
 }
 
+static bool sienna_cichlid_is_baco_supported(struct smu_context *smu)
+{
+	struct amdgpu_device *adev = smu->adev;
+	uint32_t val;
+
+	if (!smu_v11_0_baco_is_support(smu))
+		return false;
+
+	val = RREG32_SOC15(NBIO, 0, mmRCC_BIF_STRAP0);
+	return (val & RCC_BIF_STRAP0__STRAP_PX_CAPABLE_MASK) ? true : false;
+}
+
 static void sienna_cichlid_dump_pptable(struct smu_context *smu)
 {
 	struct smu_table_context *table_context = &smu->smu_table;
@@ -2438,7 +2428,6 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.print_clk_levels = sienna_cichlid_print_clk_levels,
 	.force_clk_levels = sienna_cichlid_force_clk_levels,
 	.populate_umd_state_clk = sienna_cichlid_populate_umd_state_clk,
-	.get_clock_by_type_with_latency = sienna_cichlid_get_clock_by_type_with_latency,
 	.pre_display_config_changed = sienna_cichlid_pre_display_config_changed,
 	.display_config_changed = sienna_cichlid_display_config_changed,
 	.notify_smc_display_config = sienna_cichlid_notify_smc_display_config,
@@ -2500,7 +2489,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.register_irq_handler = smu_v11_0_register_irq_handler,
 	.set_azalia_d3_pme = smu_v11_0_set_azalia_d3_pme,
 	.get_max_sustainable_clocks_by_dc = smu_v11_0_get_max_sustainable_clocks_by_dc,
-	.baco_is_support= smu_v11_0_baco_is_support,
+	.baco_is_support= sienna_cichlid_is_baco_supported,
 	.baco_get_state = smu_v11_0_baco_get_state,
 	.baco_set_state = smu_v11_0_baco_set_state,
 	.baco_enter = smu_v11_0_baco_enter,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

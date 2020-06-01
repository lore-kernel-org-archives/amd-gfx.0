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
	by smtp.lore.kernel.org (Postfix) with ESMTP id F351DC433E0
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBB412073B
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ivtMw7O8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBB412073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 815C16E30D;
	Mon,  1 Jun 2020 18:21:52 +0000 (UTC)
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com
 [IPv6:2607:f8b0:4864:20::841])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 010DB6E30D
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:21:50 +0000 (UTC)
Received: by mail-qt1-x841.google.com with SMTP id j32so8458472qte.10
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=aiiJC2WS7SxzSSJYIKLvCFdEyKhD/EdMlKIOsX/dCkM=;
 b=ivtMw7O8mjVDB8unBCm2b38usdPUomhXzCAstwvEMd0TJKwGlAFwbXfAROpr05VeXx
 Sz2B+1s3dkFinZu9NarOuJWyMsBOTIMifVo3RI2l2vhIJ/+y/a2j33BS3B45ubzgYFUD
 Hbc7G82nZHUlXMXJaF79bSwAxCynd5UE5akYm6quLogCKUam3BdohwrnHevBt8bKGpsh
 4NVEr72NQC9bMcHgkSGqKCgUKwIrbBRQBP8EK4WalV7ROLF6+mZxNsBK1O2LvVdl8F2q
 uk29PX3c+UJH5EltD5cXPJjJF4f+7EOGLp55fRLbWOZWSD+V1/Q9824H+2KUcuGJ9T4c
 hnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=aiiJC2WS7SxzSSJYIKLvCFdEyKhD/EdMlKIOsX/dCkM=;
 b=LMfrto0v3+piOGBJ7T2vYxLFIB0gzlYoHNRGu7AVEHcRI/UUJlP4eb167toVmVIuml
 XfQbmX6cmFHoWoyDcm77xBdN9hVTy2Xy+HQDl3Y0chKjlM30bCUYTS6jfox6t2qh0eAh
 fAYYaeYIttMSb4X69jfpDBosIsTxsqKwrSZaFnEIzQrebSljpzDbxT9TOCbyQtAlmpfO
 79e9913zHn5SQ8OvptaNNK7dsXFHAgQ5z1n/ssKpyw2qDjR5q1u9GQhREGXY2g7A/K0+
 Gcc4NekUDWVLntRmwGO93y2/yCU7dzGoNWpDuyVyiI28iPMIPrnEhgB1FMzSwwPdF1LU
 teEw==
X-Gm-Message-State: AOAM5336/7pxRodOpDxqFWCL52THozrB1tXQd7SssqcQ2kzfF2SYIl0k
 iuNHb6Y5M6WitQn0695gKddjxJQa
X-Google-Smtp-Source: ABdhPJyLn7NID6QeTvW20HdoromELQ6PvEL6Fjd8meWhtfL+iMyJbyPAuo47Wy1ls5bXGSb3NDyuJQ==
X-Received: by 2002:aed:29c5:: with SMTP id o63mr23714970qtd.386.1591035709959; 
 Mon, 01 Jun 2020 11:21:49 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id w10sm106849qtc.15.2020.06.01.11.21.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:21:49 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 124/207] drm/amd/powerplay: enable MM DPM PG for
 sienna_cichlid (v2)
Date: Mon,  1 Jun 2020 14:19:31 -0400
Message-Id: <20200601182054.1267858-35-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Kenneth Feng <kenneth.feng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Enable VCN dpm set for sienna_cichlid.
Enable JPEG dpm set for sienna_cichlid.

v2: squash in BACO fix (Kenneth)

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Kenneth Feng <kenneth.feng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/inc/smu_types.h |  1 +
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 51 +++++++++++++++++--
 2 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h b/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
index 1ef791f36888..3efadf2cff9c 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_types.h
@@ -247,6 +247,7 @@ enum smu_clk_type {
        __SMU_DUMMY_MAP(FW_DSTATE),                     	\
        __SMU_DUMMY_MAP(BACO),                          	\
        __SMU_DUMMY_MAP(VCN_PG),                        	\
+       __SMU_DUMMY_MAP(MM_DPM_PG),                     	\
        __SMU_DUMMY_MAP(JPEG_PG),                       	\
        __SMU_DUMMY_MAP(USB_PG),                        	\
        __SMU_DUMMY_MAP(RSMU_SMN_CG),                   	\
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 2d844569ed8d..80a099877a68 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -141,6 +141,7 @@ static struct smu_11_0_cmn2aisc_mapping sienna_cichlid_feature_mask_map[SMU_FEAT
 	FEA_MAP(FW_DSTATE),
 	FEA_MAP(GFXOFF),
 	FEA_MAP(BACO),
+	FEA_MAP(MM_DPM_PG),
 	FEA_MAP(RSMU_SMN_CG),
 	FEA_MAP(PPT),
 	FEA_MAP(TDC),
@@ -327,6 +328,10 @@ sienna_cichlid_get_allowed_feature_mask(struct smu_context *smu,
 	if (adev->pm.pp_feature & PP_SCLK_DEEP_SLEEP_MASK)
 		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_DS_GFXCLK_BIT);
 
+	if (smu->adev->pg_flags & AMD_PG_SUPPORT_VCN ||
+	    smu->adev->pg_flags & AMD_PG_SUPPORT_JPEG)
+		*(uint64_t *)feature_mask |= FEATURE_MASK(FEATURE_MM_DPM_PG_BIT);
+
 	return 0;
 }
 
@@ -485,15 +490,21 @@ static int sienna_cichlid_dpm_set_uvd_enable(struct smu_context *smu, bool enabl
 
 	if (enable) {
 		/* vcn dpm on is a prerequisite for vcn power gate messages */
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
-			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 1, NULL);
+		if (smu_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 0, NULL);
+			if (ret)
+				return ret;
+			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerUpVcn, 0x10000, NULL);
 			if (ret)
 				return ret;
 		}
 		power_gate->vcn_gated = false;
 	} else {
-		if (smu_feature_is_enabled(smu, SMU_FEATURE_VCN_PG_BIT)) {
-			ret = smu_send_smc_msg(smu, SMU_MSG_PowerDownVcn, NULL);
+		if (smu_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerDownVcn, 0, NULL);
+			if (ret)
+				return ret;
+			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerDownVcn, 0x10000, NULL);
 			if (ret)
 				return ret;
 		}
@@ -503,6 +514,37 @@ static int sienna_cichlid_dpm_set_uvd_enable(struct smu_context *smu, bool enabl
 	return ret;
 }
 
+static int sienna_cichlid_dpm_set_jpeg_enable(struct smu_context *smu, bool enable)
+{
+	struct smu_power_context *smu_power = &smu->smu_power;
+	struct smu_power_gate *power_gate = &smu_power->power_gate;
+	int ret = 0;
+
+	if (enable) {
+		if (smu_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerUpJpeg, 0, NULL);
+			if (ret)
+				return ret;
+			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerUpJpeg, 0x10000, NULL);
+			if (ret)
+				return ret;
+		}
+		power_gate->jpeg_gated = false;
+	} else {
+		if (smu_feature_is_enabled(smu, SMU_FEATURE_MM_DPM_PG_BIT)) {
+			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerDownJpeg, 0, NULL);
+			if (ret)
+				return ret;
+			ret = smu_send_smc_msg_with_param(smu, SMU_MSG_PowerDownJpeg, 0x10000, NULL);
+			if (ret)
+				return ret;
+		}
+		power_gate->jpeg_gated = true;
+	}
+
+	return ret;
+}
+
 static int sienna_cichlid_get_current_clk_freq_by_table(struct smu_context *smu,
 				       enum smu_clk_type clk_type,
 				       uint32_t *value)
@@ -2214,6 +2256,7 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_allowed_feature_mask = sienna_cichlid_get_allowed_feature_mask,
 	.set_default_dpm_table = sienna_cichlid_set_default_dpm_table,
 	.dpm_set_uvd_enable = sienna_cichlid_dpm_set_uvd_enable,
+	.dpm_set_jpeg_enable = sienna_cichlid_dpm_set_jpeg_enable,
 	.get_current_clk_freq_by_table = sienna_cichlid_get_current_clk_freq_by_table,
 	.print_clk_levels = sienna_cichlid_print_clk_levels,
 	.force_clk_levels = sienna_cichlid_force_clk_levels,
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

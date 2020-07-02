Return-Path: <SRS0=uuOW=AN=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 323F0C433DF
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 09:45:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC93320760
	for <amd-gfx@archiver.kernel.org>; Thu,  2 Jul 2020 09:45:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ncciGHac"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC93320760
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 498C76EAB4;
	Thu,  2 Jul 2020 09:45:14 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760053.outbound.protection.outlook.com [40.107.76.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AC336EAB4
 for <amd-gfx@lists.freedesktop.org>; Thu,  2 Jul 2020 09:45:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lx5s5K5pVQ1BA4YDDomCa/W9H5NON+njZEiBn1k16vboIescNkmSqpYdXzepvtoexOFvKx4YxXReK1uA5N+nqqWwpLeDxkG+M1C5n1dMVratneC1VHUNqb0Rht226BOXFmnI2uF10pHLbKPcoz+cMrk/cpVLuxUUM54BwnxTEG2gifOAZ9lmNXh2b4oTY+Ng7mM8rVKcza91EfPldrj+53HqgN2A7uOG/9HiPbplBSiKTbjBNQULQNB06SBQJAp5H3xwRiLQex6v1zI3486wTF6d2wByIqkySHQeu0tK3j800m36xp8Mnq8jYU/uHAj6fD3cJhB2BshD8dgj2OTlhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nulCbou0k4+7nkPRKFn8HGTR/nnF7dU5EIaFaPFuIyU=;
 b=GvdMbNX3zCulEJygu71g2lSLsaTKD9kaYiP/mNh0zmoo/XmhpSx3z158KZlsVblJO81DXmIkahEKNIWxBJnRYiwsuRtKloO2ZGFu4NvT6xwTEsXSeENPc8icL6L2q+VuT5heDkVlEh8qVI9jTzyJbeBaq0bCx6fP/5oy9OqkIp4JRPsuO3YM3pNODAO12kvgpTEpvyQQ88wtgtjPnEFtXYIWFd2PNBC3/zR2IMfaJaFI8H7U1looZd91ElFKx0FMU+IuFCEVJHEssixAi9A7+kdrNmIndtVXzbvjzC5IDQR2Aeapfbgegul3rj97CpDEjbAEXOtfwaPj3you/SB0Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nulCbou0k4+7nkPRKFn8HGTR/nnF7dU5EIaFaPFuIyU=;
 b=ncciGHacv+3cyFAnqgIwspRUPwLRVZiE2kLh5fB8eQ6hj6ATFiD2vWrLa+CcA48NnQ5OaRLoQ+3Q457xLI5DllHaCYQV25gTqHxqx0pYQ0R1CcBSCTSxFRZmob9Cz5Kq1ZUFWl8PE+hjnawIVgQUgfc22iV5yeqlwlUm8hyDtmI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR1201MB0219.namprd12.prod.outlook.com (2603:10b6:4:56::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3131.21; Thu, 2 Jul 2020 09:45:09 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Thu, 2 Jul 2020
 09:45:09 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amd/powerplay: drop unnecessary wrappers around clock
 retrieving
Date: Thu,  2 Jul 2020 17:44:44 +0800
Message-Id: <20200702094447.8158-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
X-ClientProxiedBy: HK2PR02CA0186.apcprd02.prod.outlook.com
 (2603:1096:201:21::22) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0186.apcprd02.prod.outlook.com (2603:1096:201:21::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.21 via Frontend Transport; Thu, 2 Jul 2020 09:45:07 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 643a668c-9c16-4a03-3141-08d81e6c9b83
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0219:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR1201MB0219AD0F5D85A18DEE8B2A32E46D0@DM5PR1201MB0219.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:147;
X-Forefront-PRVS: 0452022BE1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ksPRu+vDGQXysgxrCjZ8QqDgQPf8Cf3xf5G29PI61QYHv/c66euCNrNz8QEsLqzdRwjxyt16aCwUOtGgmvD8M/ybcnizTg9SQ1XEOFQ2R664UmzySkoNHu+a2WDeneEY3pvB8wWDCUqUZPZV03mfpLEIOvcvaH4WtYGGxpqWzmmMyS2/SCJafIT1sJ2hP+VLkV4SfQ3SgjiVlf0N4bWaE1Expbr2BgT+elYBnn3eCQtQPxCGO5pnNiu2euJMAa+oIsjKuRTURoHlM9pXqoRFNdxd9E3Q1yBBvlrxYiZTd+cyU1DIt7ket/FmaHt6JHNz
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(7696005)(52116002)(5660300002)(83380400001)(26005)(8676002)(186003)(16526019)(86362001)(6916009)(2616005)(316002)(6486002)(36756003)(956004)(8936002)(66556008)(66476007)(2906002)(66946007)(1076003)(44832011)(6666004)(478600001)(4326008);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Jxp899vN0IP7zJdTNxkhTMu8wWo1OE6J4S9OA78Lk3tZlXHIakd8kP+fos/CkuJ85eedRtB7EswT+im8uGhZo3ab5glL1Kp71EH62Hac6FFKYS/8AbtvmL5XG9cA9dQNeNw7JnxCPiZ1fo+ZlDcbiuW6+8Adzs2l/4A25K7aFDRijZ8zXC6Br4ctWO5Q1Jg+0UzSyqsQ3E2VMyftR3ABDfkCLu76QQmPKK+HclFsQiMK+oOSgrHzy8+jKRiT4rdVeRIf6Wmteo57vRINHjnm3J98OfLfei668LRO+3Ua1+QtiPw0tMxalgPT5He8Do8hLTZK6oQMhyzjkvnuGobfP7wQbQRm3HrxV3LfW+4/KYQCF2OA4uqxExfEeYJFXH+lq092ggAIWZTlsq7+yRbGX4lSnv2HpWwdQ5hUc1ZJJ8izQitHsP26wUpJNyaZt0yE29hwP0KRoUKiirf6GdCU93Yg2sLJdubrg5bY9Dwoy/txnaU/NgNX4fgrhXxJXwq7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 643a668c-9c16-4a03-3141-08d81e6c9b83
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2020 09:45:08.9971 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BKL3NRnIU/vBn8wnYZjvao72+OOuY6kyeM7ViFvZ7/p8PapcDfJUnVsAPlY+fqtN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0219
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

By calling the target APIs directly.

Change-Id: Ic1c92f26f7aeab334632a26bf75c3e232d1db0e1
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c       | 9 ++++-----
 drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h     | 1 -
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c         | 3 +--
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c         | 1 -
 drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c | 3 +--
 drivers/gpu/drm/amd/powerplay/smu_internal.h       | 1 -
 drivers/gpu/drm/amd/powerplay/smu_v11_0.c          | 4 ++--
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c          | 4 ++--
 8 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index d93f8a43a96f..dc0178349c28 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -661,7 +661,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 
 	switch (type) {
 	case SMU_SCLK:
-		ret = smu_get_current_clk_freq(smu, SMU_GFXCLK, &now);
+		ret = smu_v11_0_get_current_clk_freq(smu, SMU_GFXCLK, &now);
 		if (ret) {
 			dev_err(smu->adev->dev, "Attempt to get current gfx clk Failed!");
 			return ret;
@@ -688,7 +688,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 		break;
 
 	case SMU_MCLK:
-		ret = smu_get_current_clk_freq(smu, SMU_UCLK, &now);
+		ret = smu_v11_0_get_current_clk_freq(smu, SMU_UCLK, &now);
 		if (ret) {
 			dev_err(smu->adev->dev, "Attempt to get current mclk Failed!");
 			return ret;
@@ -711,7 +711,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 		break;
 
 	case SMU_SOCCLK:
-		ret = smu_get_current_clk_freq(smu, SMU_SOCCLK, &now);
+		ret = smu_v11_0_get_current_clk_freq(smu, SMU_SOCCLK, &now);
 		if (ret) {
 			dev_err(smu->adev->dev, "Attempt to get current socclk Failed!");
 			return ret;
@@ -734,7 +734,7 @@ static int arcturus_print_clk_levels(struct smu_context *smu,
 		break;
 
 	case SMU_FCLK:
-		ret = smu_get_current_clk_freq(smu, SMU_FCLK, &now);
+		ret = smu_v11_0_get_current_clk_freq(smu, SMU_FCLK, &now);
 		if (ret) {
 			dev_err(smu->adev->dev, "Attempt to get current fclk Failed!");
 			return ret;
@@ -2597,7 +2597,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.get_enabled_mask = smu_v11_0_get_enabled_mask,
 	.notify_display_change = NULL,
 	.set_power_limit = smu_v11_0_set_power_limit,
-	.get_current_clk_freq = smu_v11_0_get_current_clk_freq,
 	.init_max_sustainable_clocks = smu_v11_0_init_max_sustainable_clocks,
 	.enable_thermal_alert = smu_v11_0_enable_thermal_alert,
 	.disable_thermal_alert = smu_v11_0_disable_thermal_alert,
diff --git a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
index 7b349e038972..f3bc1f16b0a4 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/amdgpu_smu.h
@@ -521,7 +521,6 @@ struct pptable_funcs {
 	int (*get_enabled_mask)(struct smu_context *smu, uint32_t *feature_mask, uint32_t num);
 	int (*notify_display_change)(struct smu_context *smu);
 	int (*set_power_limit)(struct smu_context *smu, uint32_t n);
-	int (*get_current_clk_freq)(struct smu_context *smu, enum smu_clk_type clk_id, uint32_t *value);
 	int (*init_max_sustainable_clocks)(struct smu_context *smu);
 	int (*enable_thermal_alert)(struct smu_context *smu);
 	int (*disable_thermal_alert)(struct smu_context *smu);
diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index 4f7d064e16e4..6046cb6db4a1 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -877,7 +877,7 @@ static int navi10_print_clk_levels(struct smu_context *smu,
 	case SMU_UCLK:
 	case SMU_FCLK:
 	case SMU_DCEFCLK:
-		ret = smu_get_current_clk_freq(smu, clk_type, &cur_value);
+		ret = smu_v11_0_get_current_clk_freq(smu, clk_type, &cur_value);
 		if (ret)
 			return size;
 
@@ -2438,7 +2438,6 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.get_enabled_mask = smu_v11_0_get_enabled_mask,
 	.notify_display_change = smu_v11_0_notify_display_change,
 	.set_power_limit = smu_v11_0_set_power_limit,
-	.get_current_clk_freq = smu_v11_0_get_current_clk_freq,
 	.init_max_sustainable_clocks = smu_v11_0_init_max_sustainable_clocks,
 	.enable_thermal_alert = smu_v11_0_enable_thermal_alert,
 	.disable_thermal_alert = smu_v11_0_disable_thermal_alert,
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index f286c1e1934f..a52d562addc2 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -953,7 +953,6 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.fini_smc_tables = smu_v12_0_fini_smc_tables,
 	.set_default_dpm_table = smu_v12_0_set_default_dpm_tables,
 	.get_enabled_mask = smu_v12_0_get_enabled_mask,
-	.get_current_clk_freq = smu_v12_0_get_current_clk_freq,
 	.get_dpm_ultimate_freq = smu_v12_0_get_dpm_ultimate_freq,
 	.mode2_reset = smu_v12_0_mode2_reset,
 	.set_soft_freq_limited_range = smu_v12_0_set_soft_freq_limited_range,
diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index dc5ca9121db5..cbd596475d19 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -781,7 +781,7 @@ static int sienna_cichlid_print_clk_levels(struct smu_context *smu,
 	case SMU_UCLK:
 	case SMU_FCLK:
 	case SMU_DCEFCLK:
-		ret = smu_get_current_clk_freq(smu, clk_type, &cur_value);
+		ret = smu_v11_0_get_current_clk_freq(smu, clk_type, &cur_value);
 		if (ret)
 			goto print_clk_out;
 
@@ -2518,7 +2518,6 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.get_enabled_mask = smu_v11_0_get_enabled_mask,
 	.notify_display_change = NULL,
 	.set_power_limit = smu_v11_0_set_power_limit,
-	.get_current_clk_freq = smu_v11_0_get_current_clk_freq,
 	.init_max_sustainable_clocks = smu_v11_0_init_max_sustainable_clocks,
 	.enable_thermal_alert = smu_v11_0_enable_thermal_alert,
 	.disable_thermal_alert = smu_v11_0_disable_thermal_alert,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_internal.h b/drivers/gpu/drm/amd/powerplay/smu_internal.h
index afd786b6c0b4..f0fb74a05f80 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_internal.h
+++ b/drivers/gpu/drm/amd/powerplay/smu_internal.h
@@ -59,7 +59,6 @@
 #define smu_set_default_dpm_table(smu)					smu_ppt_funcs(set_default_dpm_table, 0, smu)
 #define smu_populate_umd_state_clk(smu)					smu_ppt_funcs(populate_umd_state_clk, 0, smu)
 #define smu_set_default_od8_settings(smu)				smu_ppt_funcs(set_default_od8_settings, 0, smu)
-#define smu_get_current_clk_freq(smu, clk_id, value)			smu_ppt_funcs(get_current_clk_freq, 0, smu, clk_id, value)
 #define smu_tables_init(smu, tab)					smu_ppt_funcs(tables_init, 0, smu, tab)
 #define smu_set_thermal_fan_table(smu)					smu_ppt_funcs(set_thermal_fan_table, 0, smu)
 #define smu_enable_thermal_alert(smu)					smu_ppt_funcs(enable_thermal_alert, 0, smu)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
index 48e15885e9c3..4e913fb4ac5d 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v11_0.c
@@ -1183,11 +1183,11 @@ int smu_v11_0_read_sensor(struct smu_context *smu,
 
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_GFX_MCLK:
-		ret = smu_get_current_clk_freq(smu, SMU_UCLK, (uint32_t *)data);
+		ret = smu_v11_0_get_current_clk_freq(smu, SMU_UCLK, (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GFX_SCLK:
-		ret = smu_get_current_clk_freq(smu, SMU_GFXCLK, (uint32_t *)data);
+		ret = smu_v11_0_get_current_clk_freq(smu, SMU_GFXCLK, (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_VDDGFX:
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index b03127273d56..1d7caaf57b70 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -214,11 +214,11 @@ int smu_v12_0_read_sensor(struct smu_context *smu,
 
 	switch (sensor) {
 	case AMDGPU_PP_SENSOR_GFX_MCLK:
-		ret = smu_get_current_clk_freq(smu, SMU_UCLK, (uint32_t *)data);
+		ret = smu_v12_0_get_current_clk_freq(smu, SMU_UCLK, (uint32_t *)data);
 		*size = 4;
 		break;
 	case AMDGPU_PP_SENSOR_GFX_SCLK:
-		ret = smu_get_current_clk_freq(smu, SMU_GFXCLK, (uint32_t *)data);
+		ret = smu_v12_0_get_current_clk_freq(smu, SMU_GFXCLK, (uint32_t *)data);
 		*size = 4;
 		break;
 	default:
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

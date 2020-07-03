Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D313C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:34:01 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F86B207FF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pkoHHIpS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F86B207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D24156E1F2;
	Fri,  3 Jul 2020 08:34:00 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDD126E1F2
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 08:33:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WA3HzGIB0MTwRk2WnZHF0oFKnner6+WEEevUqAweWbcF6e+BzN3V5AFHlq+WFkIMOzuHWMOaoNv5rJYWtiXuAKNB8AR4aUdYzNKectMXWbkM9aXHtt+UitnEzCD9Fq/EBPuGzj7ZXj+Q46EiAHXZZTyOOye0Gk3hq3pgO/7k/Uuvkz0431wB1M2SKVaKfGNBRZiHDSsPava0i4KIOR2NKrIirmtHA/3gLnM+5ZaGcXwW4UCqHVOq+YUjzQb/j5W/ZICUcVq/0qAD85uqdSNR40VsDwNU3PjuDgTl1BiiOepr32r1WW5jQVT1TiH1Ee6JqUe24la/z0jNMPLFO+9E9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iFrs6zt91+r8heIkasp4rkOFTrVqKoX6w3O0U5Jwhk=;
 b=jdg2bY9ea8GcCTOwjfteeyupppgevoHlejBzGJZurQJVMOcG4mdwN9ctdyPgNSpopFuo3b1uK9zKZOzpUSKoL0o1y9GWslHiNxIR4TEocgjUHUVQADGlX3PaGq7oVT+In+sYF7E9ni/iQ4xuYTjCadYw7xnDiN7xrJPqOoDFFvKGLUkd8mEK7GfD4y1eQnXbrlL+CfRmH5+On9dY5r6zIFj2Eumyux6/YFEF2rVQO6Ygx8XB+9OKcUEOKeNxhfuiIe4RxEKulHZjPrFWPH5161akPj2smIhhTDeL2dTMcMW7qpLOxWQuJs3suBJ92LdMiZq6LKBTbXn4Ci+Wc5hBDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1iFrs6zt91+r8heIkasp4rkOFTrVqKoX6w3O0U5Jwhk=;
 b=pkoHHIpSaGDXebjWrYfJhXDSuaqobTpyU4WxvOByM5qXCBtwr6HVYleGnjGiGOE7KL+GNErs4htaLH/LrGUkTDRZa3NAoZERTJWeHxUTmIjFfYxRYU0zWSMNM60g76gdPTd6axPEH9oj77+/ZLwS9t66uJhz+7RRopw+vm6PkXo=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.27; Fri, 3 Jul 2020 08:33:58 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 08:33:58 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/14] drm/amd/powerplay: drop unnecessary Navi1x specific APIs
Date: Fri,  3 Jul 2020 16:32:58 +0800
Message-Id: <20200703083303.478-9-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200703083303.478-1-evan.quan@amd.com>
References: <20200703083303.478-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0139.apcprd02.prod.outlook.com
 (2603:1096:202:16::23) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0139.apcprd02.prod.outlook.com (2603:1096:202:16::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.22 via Frontend Transport; Fri, 3 Jul 2020 08:33:57 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8cebb93e-3b92-4413-b2c7-08d81f2bd4b5
X-MS-TrafficTypeDiagnostic: DM6PR12MB3962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB39622CEF047754656AC64AE8E46A0@DM6PR12MB3962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/rXlTeVTB6WNXM4F1r1xvTWQGt4cTv6EyW5WcvEIgNfkjgoJydnaWVcjgtRgLhb8GGKuOH0WGmEykqvDtrLGMhb42oYj6F6Lmwdb9sN+irtqfM+Sq3NxGWJFj1hYiDpGVTs+uzG2OLz6LyeZTNMMOW5WbLbqGAo8oIaQ/W5cU+hldv4itwvgiRKm+pdOfVaJwSldQeFDZnuTiPw5bGUNKDv3eKlg2cgEhI57z+tDqF78YLhPw0bJO+8+1nzLrvZkTh2tm1ddqXMdJw1xfBfpJ2Qdj1k1X12Kmm9Faobpi6MgnzQ7YCG7k1kemBEcGSxAtUnJFUxiLVQxn+eN43dPN+KWnBU1vDd1iZvgtqdNdZPM4u2EDbOS8Z+z1uuby5c
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(83380400001)(44832011)(4326008)(36756003)(8936002)(7696005)(956004)(2616005)(6486002)(52116002)(478600001)(66946007)(16526019)(26005)(186003)(66476007)(5660300002)(1076003)(66556008)(8676002)(316002)(86362001)(6916009)(2906002)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: KHm3Hd2rFaCJiHaD0O2Fe7zLwtewIFTjtl4dlm3ARHNLeOIqBUhQbUA/x5SoVw2Ctek3pNfbqmd1XoG4uozqk35FvyFdEpZ24M5hOUxJHAtoomWp4DQseRZwiiJ+4R/gzAUUD6MyuyOaNN8cYwMYuenU5rKMztNFLDjUEISmkQK6JSDo+mbAEouOtMK9fz3szv505R+wAp70dt/fEUdLanZrK5dAvh9Zpy7p1P17iEdEtqOy8WuMlaz+h8mwY6hoiofe/s/PRUJFecH/RVvuUSXv9543Wrn3rdEDehTRbhbko4I78l78qEQ2CoNG9QY2w+d5UpvKl2izCnSBLXH3F7bpHYWR6kL7no0oB4wLbdHYm0vaNDwBAN8jh4P9ogNPZdk2KECuziljKL4AXKtbgD+ujtYZrcCSrCEDMeX3Ok2cl+F+m8a6BBg7KUnCtKecyHbZkvamZ93DDXRpGR3MO5TaiSCFxaoI4WC8xkQuIVuzSJmU8t/27VxwGhdu8YKj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cebb93e-3b92-4413-b2c7-08d81f2bd4b5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:33:58.8515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b7uhLdy/uSZGlKlhHUjYqsM6Rtnhv2gmxaFMnPSxvjLSVnAU6Kc3POI7IVoNpywy
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3962
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

As a common performance level setting API is used. Then these
ASIC specific APIs are not needed any more.

Change-Id: I2c8831b9d00618c6578ee42b34e26892c5dba515
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 drivers/gpu/drm/amd/powerplay/navi10_ppt.c | 248 +--------------------
 1 file changed, 1 insertion(+), 247 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
index d3e11d81c0ad..6d638a67bc4d 100644
--- a/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/navi10_ppt.c
@@ -1376,59 +1376,6 @@ static int navi10_display_config_changed(struct smu_context *smu)
 	return ret;
 }
 
-static int navi10_force_dpm_limit_value(struct smu_context *smu, bool highest)
-{
-	int ret = 0, i = 0;
-	uint32_t min_freq, max_freq, force_freq;
-	enum smu_clk_type clk_type;
-
-	enum smu_clk_type clks[] = {
-		SMU_GFXCLK,
-		SMU_MCLK,
-		SMU_SOCCLK,
-	};
-
-	for (i = 0; i < ARRAY_SIZE(clks); i++) {
-		clk_type = clks[i];
-		ret = smu_v11_0_get_dpm_ultimate_freq(smu, clk_type, &min_freq, &max_freq);
-		if (ret)
-			return ret;
-
-		force_freq = highest ? max_freq : min_freq;
-		ret = smu_v11_0_set_soft_freq_limited_range(smu, clk_type, force_freq, force_freq);
-		if (ret)
-			return ret;
-	}
-
-	return ret;
-}
-
-static int navi10_unforce_dpm_levels(struct smu_context *smu)
-{
-	int ret = 0, i = 0;
-	uint32_t min_freq, max_freq;
-	enum smu_clk_type clk_type;
-
-	enum smu_clk_type clks[] = {
-		SMU_GFXCLK,
-		SMU_MCLK,
-		SMU_SOCCLK,
-	};
-
-	for (i = 0; i < ARRAY_SIZE(clks); i++) {
-		clk_type = clks[i];
-		ret = smu_v11_0_get_dpm_ultimate_freq(smu, clk_type, &min_freq, &max_freq);
-		if (ret)
-			return ret;
-
-		ret = smu_v11_0_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq);
-		if (ret)
-			return ret;
-	}
-
-	return ret;
-}
-
 static int navi10_get_gpu_power(struct smu_context *smu, uint32_t *value)
 {
 	if (!value)
@@ -1681,47 +1628,6 @@ static int navi10_set_power_profile_mode(struct smu_context *smu, long *input, u
 	return ret;
 }
 
-static int navi10_get_profiling_clk_mask(struct smu_context *smu,
-					 enum amd_dpm_forced_level level,
-					 uint32_t *sclk_mask,
-					 uint32_t *mclk_mask,
-					 uint32_t *soc_mask)
-{
-	int ret = 0;
-	uint32_t level_count = 0;
-
-	if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK) {
-		if (sclk_mask)
-			*sclk_mask = 0;
-	} else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK) {
-		if (mclk_mask)
-			*mclk_mask = 0;
-	} else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {
-		if(sclk_mask) {
-			ret = smu_v11_0_get_dpm_level_count(smu, SMU_SCLK, &level_count);
-			if (ret)
-				return ret;
-			*sclk_mask = level_count - 1;
-		}
-
-		if(mclk_mask) {
-			ret = smu_v11_0_get_dpm_level_count(smu, SMU_MCLK, &level_count);
-			if (ret)
-				return ret;
-			*mclk_mask = level_count - 1;
-		}
-
-		if(soc_mask) {
-			ret = smu_v11_0_get_dpm_level_count(smu, SMU_SOCCLK, &level_count);
-			if (ret)
-				return ret;
-			*soc_mask = level_count - 1;
-		}
-	}
-
-	return ret;
-}
-
 static int navi10_notify_smc_display_config(struct smu_context *smu)
 {
 	struct smu_clocks min_clocks = {0};
@@ -1954,155 +1860,6 @@ static int navi10_get_uclk_dpm_states(struct smu_context *smu, uint32_t *clocks_
 	return 0;
 }
 
-static int navi10_set_performance_level(struct smu_context *smu,
-					enum amd_dpm_forced_level level);
-
-static int navi10_set_standard_performance_level(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	int ret = 0;
-	uint32_t sclk_freq = 0, uclk_freq = 0;
-
-	switch (adev->asic_type) {
-	case CHIP_NAVI10:
-		sclk_freq = NAVI10_UMD_PSTATE_PROFILING_GFXCLK;
-		uclk_freq = NAVI10_UMD_PSTATE_PROFILING_MEMCLK;
-		break;
-	case CHIP_NAVI14:
-		sclk_freq = NAVI14_UMD_PSTATE_PROFILING_GFXCLK;
-		uclk_freq = NAVI14_UMD_PSTATE_PROFILING_MEMCLK;
-		break;
-	default:
-		/* by default, this is same as auto performance level */
-		return navi10_set_performance_level(smu, AMD_DPM_FORCED_LEVEL_AUTO);
-	}
-
-	ret = smu_v11_0_set_soft_freq_limited_range(smu, SMU_SCLK, sclk_freq, sclk_freq);
-	if (ret)
-		return ret;
-	ret = smu_v11_0_set_soft_freq_limited_range(smu, SMU_UCLK, uclk_freq, uclk_freq);
-	if (ret)
-		return ret;
-
-	return ret;
-}
-
-static int navi10_set_peak_performance_level(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	int ret = 0;
-	uint32_t sclk_freq = 0, uclk_freq = 0;
-
-	switch (adev->asic_type) {
-	case CHIP_NAVI10:
-		switch (adev->pdev->revision) {
-		case 0xf0: /* XTX */
-		case 0xc0:
-			sclk_freq = NAVI10_PEAK_SCLK_XTX;
-			break;
-		case 0xf1: /* XT */
-		case 0xc1:
-			sclk_freq = NAVI10_PEAK_SCLK_XT;
-			break;
-		default: /* XL */
-			sclk_freq = NAVI10_PEAK_SCLK_XL;
-			break;
-		}
-		break;
-	case CHIP_NAVI14:
-		switch (adev->pdev->revision) {
-		case 0xc7: /* XT */
-		case 0xf4:
-			sclk_freq = NAVI14_UMD_PSTATE_PEAK_XT_GFXCLK;
-			break;
-		case 0xc1: /* XTM */
-		case 0xf2:
-			sclk_freq = NAVI14_UMD_PSTATE_PEAK_XTM_GFXCLK;
-			break;
-		case 0xc3: /* XLM */
-		case 0xf3:
-			sclk_freq = NAVI14_UMD_PSTATE_PEAK_XLM_GFXCLK;
-			break;
-		case 0xc5: /* XTX */
-		case 0xf6:
-			sclk_freq = NAVI14_UMD_PSTATE_PEAK_XLM_GFXCLK;
-			break;
-		default: /* XL */
-			sclk_freq = NAVI14_UMD_PSTATE_PEAK_XL_GFXCLK;
-			break;
-		}
-		break;
-	case CHIP_NAVI12:
-		sclk_freq = NAVI12_UMD_PSTATE_PEAK_GFXCLK;
-		break;
-	default:
-		ret = smu_v11_0_get_dpm_level_range(smu,
-						    SMU_SCLK,
-						    NULL,
-						    &sclk_freq);
-		if (ret)
-			return ret;
-	}
-
-	ret = smu_v11_0_get_dpm_level_range(smu,
-					    SMU_UCLK,
-					    NULL,
-					    &uclk_freq);
-	if (ret)
-		return ret;
-
-	ret = smu_v11_0_set_soft_freq_limited_range(smu, SMU_SCLK, sclk_freq, sclk_freq);
-	if (ret)
-		return ret;
-	ret = smu_v11_0_set_soft_freq_limited_range(smu, SMU_UCLK, uclk_freq, uclk_freq);
-	if (ret)
-		return ret;
-
-	return ret;
-}
-
-static int navi10_set_performance_level(struct smu_context *smu,
-					enum amd_dpm_forced_level level)
-{
-	int ret = 0;
-	uint32_t sclk_mask, mclk_mask, soc_mask;
-
-	switch (level) {
-	case AMD_DPM_FORCED_LEVEL_HIGH:
-		ret = smu_force_dpm_limit_value(smu, true);
-		break;
-	case AMD_DPM_FORCED_LEVEL_LOW:
-		ret = smu_force_dpm_limit_value(smu, false);
-		break;
-	case AMD_DPM_FORCED_LEVEL_AUTO:
-		ret = smu_unforce_dpm_levels(smu);
-		break;
-	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
-		ret = navi10_set_standard_performance_level(smu);
-		break;
-	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
-	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
-		ret = smu_get_profiling_clk_mask(smu, level,
-						 &sclk_mask,
-						 &mclk_mask,
-						 &soc_mask);
-		if (ret)
-			return ret;
-		smu_force_clk_levels(smu, SMU_SCLK, 1 << sclk_mask, false);
-		smu_force_clk_levels(smu, SMU_MCLK, 1 << mclk_mask, false);
-		smu_force_clk_levels(smu, SMU_SOCCLK, 1 << soc_mask, false);
-		break;
-	case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
-		ret = navi10_set_peak_performance_level(smu);
-		break;
-	case AMD_DPM_FORCED_LEVEL_MANUAL:
-	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
-	default:
-		break;
-	}
-	return ret;
-}
-
 static int navi10_get_thermal_temperature_range(struct smu_context *smu,
 						struct smu_temperature_range *range)
 {
@@ -2622,18 +2379,15 @@ static const struct pptable_funcs navi10_ppt_funcs = {
 	.pre_display_config_changed = navi10_pre_display_config_changed,
 	.display_config_changed = navi10_display_config_changed,
 	.notify_smc_display_config = navi10_notify_smc_display_config,
-	.force_dpm_limit_value = navi10_force_dpm_limit_value,
-	.unforce_dpm_levels = navi10_unforce_dpm_levels,
 	.is_dpm_running = navi10_is_dpm_running,
 	.get_fan_speed_percent = navi10_get_fan_speed_percent,
 	.get_fan_speed_rpm = navi10_get_fan_speed_rpm,
 	.get_power_profile_mode = navi10_get_power_profile_mode,
 	.set_power_profile_mode = navi10_set_power_profile_mode,
-	.get_profiling_clk_mask = navi10_get_profiling_clk_mask,
 	.set_watermarks_table = navi10_set_watermarks_table,
 	.read_sensor = navi10_read_sensor,
 	.get_uclk_dpm_states = navi10_get_uclk_dpm_states,
-	.set_performance_level = navi10_set_performance_level,
+	.set_performance_level = smu_v11_0_set_performance_level,
 	.get_thermal_temperature_range = navi10_get_thermal_temperature_range,
 	.display_disable_memory_clock_switch = navi10_display_disable_memory_clock_switch,
 	.get_power_limit = navi10_get_power_limit,
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

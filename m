Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA034C433E1
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFCB720720
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="pIjFtVdI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFCB720720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A7BD6EB72;
	Fri, 10 Jul 2020 04:48:38 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71D5D6EB72
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 04:48:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WCmFF7OfydUz3zsUknNRZjmlkMhcapJ6DP/dKFRAyUJ91fUlltVCKNTTOmsIv5+tlnHa12Dw/pBVgkf2WkaCz18WzT0FaCkbAYOEzGEVPSaIGINH4CPKJjvHhM+LaXMK5qFeZlZjKOnrlIKHNgL58qR2oWMJIf9Cp3JP3HwoYxkcFUdFzk7nruwML0w2x61TFwJgUk4TcP0cfZEE8oT1kJlG+r5odkeFM8m6SnSu3Xz3JyPxExlz2Cqd5u7DCwTBMa9mEIs74GCUBi6BVXDHwaEIV8B6BarIq0p6KXdsUd2NaLJwO2x/h65Y0gkQd/zh6aHmbij/PZXLttNN6XCoyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80HOB+KoctVOfBzk6+yIc9O01hc1K76pVEWBb2uPdcg=;
 b=OgOFHWjaOeGdDjDIRPCxY5+mYW2qhSxKukjGKOvCSgwlZtb0RAxvOtAEWPcV9z+N2/ALURnX9ucZka9yoT+x5jfDVXEcnTmaKeDpsLSeVE1ToAJc950xV9/DjffHeajCZTO7W9RZE+ssJV4e/42jQaapDLvPVOnzQZLz0AkwF08RP1Uk4ez83OUZW7GSyffFLuns2D+shfpR0QUJT0Sti9WL9slR6Jn9hBSz5jxHr7ZcFQBUQbWe9m9jdxMnSpZ0mOxn/ES5BBvNwMk3Rea6f2lPr1F5TdxiCewleUfBk22/oWI7922A/c38Q3kFW7tpXu9OdKZDAKRDfKkcVpT+sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=80HOB+KoctVOfBzk6+yIc9O01hc1K76pVEWBb2uPdcg=;
 b=pIjFtVdIIJAip05/Nkx2/+AjUX3LAzec59LE07joYjQU+FQDpWGhFE5jGT5M5HLo7iXD0Ogqsd6X9BQEmxrN0oCXCaBRzmlGsO78ODmIzUjJSQy7gA4hI6vzmkPhMMHcpcyJ7GM9axG49aYoRfey8yHhgSN6pFGZXgHIcMn9KzU=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Fri, 10 Jul 2020 04:48:36 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 04:48:35 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/16] drm/amd/powerplay: drop smu_v12_0.c unnecessary wrapper
Date: Fri, 10 Jul 2020 12:47:45 +0800
Message-Id: <20200710044746.23538-15-evan.quan@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710044746.23538-1-evan.quan@amd.com>
References: <20200710044746.23538-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR03CA0059.apcprd03.prod.outlook.com
 (2603:1096:202:17::29) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR03CA0059.apcprd03.prod.outlook.com (2603:1096:202:17::29) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3195.9 via Frontend Transport; Fri, 10 Jul 2020 04:48:34 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b85063c0-3d96-4ee4-8d22-08d8248c8136
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB23609F979AAB39A8917AE74BE4650@DM5PR12MB2360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: J3l2wwhg8E/TPEzaYp6Ouhd22kiJCt/o3zvH5z1TTi1eaIlG43llQaNq9/0KQtLmxmaMFdD1Lre3Bzq2Lrg6nfzbjCARvcxZnJPZqedsSXE663S8Mx/bYAyVMRRkgoCpkR0ldqHcvmcxDJshxH6YdBlVKrU3q1CnOvVxoZH3Thi2SVH0Fz/QcionnmeMOGMUSF93/GfNCCyr0jMK/W69H8VizSgvAHkEJRf1vUg7UWERn9+joFu+RsbTkfXHhZWlV4u0ciUHw3c5MVu/FOF+rXIs4j7BQumUGWqhodXygDJr4A6YXrwX6tDSUJ0BPycpG+MESMq2DrdSGejvQLIGtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(2906002)(4326008)(8676002)(8936002)(83380400001)(6486002)(44832011)(7696005)(52116002)(186003)(16526019)(956004)(2616005)(26005)(6916009)(316002)(478600001)(30864003)(86362001)(6666004)(5660300002)(66556008)(1076003)(66476007)(36756003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 7PRWujWyUsp/mqoY5To4otsGCPpy5oW8kPI15BV+aOYxfXcHhR1+6BUrUOS7re/2gbKOMgET5EWUZ9yzRAld6xg4dfrkNbmA8CeFktFBv7JnDvSadu6pqLBbm3yDFqCnTSkRhj5ZE+HMv/4SADZeTDcnewdj7cHKvdunv/NTYSqmNWBq1Wo+5Sl9fKb9PmRSIoDWS0ROmwJSIb7FzounqHhxe5fJiZhTLduGTW9z36elWJ6PueFkyBt7NAScatZqbYiYDYSkTxcgJRhXYNb4N4Wjz5pyuQuYd0Fi+78pN4HcZvwkNj15kO83JR3fiyKLvlGFPQ+wNfR1kzGmGP8lWOPRpQqLCo46ry164i5FP742AZSbFccdjjX1tk0Kcbb+0KQRNS0iVF9qho8b/5v/wYk+dN+1QYNh0Tq6oi/WvEuJ/gXdNxh5IL+n6K3snIUJyGpH20/8yAUGbJO2fQWehEONZQxh8WTsTactM5LJuYs8tqWPJDTXvrkiMUShf3ld
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b85063c0-3d96-4ee4-8d22-08d8248c8136
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 04:48:35.8700 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E0duFDiuqwfExiEFjooMYokD7f8UpJS8dFfHGvaGWIwllnzt1jSssi+UgCiHBo8k
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2360
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

By moving the implemention to renoir_ppt.c considering
it's really ASIC specific.

Change-Id: I6f7a594235dffdf75b56d1de5b9dc6d49833d7e8
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |   3 -
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    | 172 ++++++++++++++----
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c     | 100 ----------
 3 files changed, 138 insertions(+), 137 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
index 0c1e1455c68f..fd83a723f32c 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
@@ -73,9 +73,6 @@ int smu_v12_0_set_default_dpm_tables(struct smu_context *smu);
 int smu_v12_0_get_enabled_mask(struct smu_context *smu,
 				      uint32_t *feature_mask, uint32_t num);
 
-int smu_v12_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
-						 uint32_t *min, uint32_t *max);
-
 int smu_v12_0_mode2_reset(struct smu_context *smu);
 
 int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_type clk_type,
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 49a8d636ef4d..5b76d67d03d7 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -241,6 +241,137 @@ static int renoir_get_dpm_clk_limited(struct smu_context *smu, enum smu_clk_type
 	return 0;
 }
 
+static int renoir_get_profiling_clk_mask(struct smu_context *smu,
+					 enum amd_dpm_forced_level level,
+					 uint32_t *sclk_mask,
+					 uint32_t *mclk_mask,
+					 uint32_t *soc_mask)
+{
+
+	if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK) {
+		if (sclk_mask)
+			*sclk_mask = 0;
+	} else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK) {
+		if (mclk_mask)
+			*mclk_mask = 0;
+	} else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {
+		if(sclk_mask)
+			/* The sclk as gfxclk and has three level about max/min/current */
+			*sclk_mask = 3 - 1;
+
+		if(mclk_mask)
+			*mclk_mask = NUM_MEMCLK_DPM_LEVELS - 1;
+
+		if(soc_mask)
+			*soc_mask = NUM_SOCCLK_DPM_LEVELS - 1;
+	}
+
+	return 0;
+}
+
+static int renoir_get_dpm_ultimate_freq(struct smu_context *smu,
+					enum smu_clk_type clk_type,
+					uint32_t *min,
+					uint32_t *max)
+{
+	int ret = 0;
+	uint32_t mclk_mask, soc_mask;
+	uint32_t clock_limit;
+
+	if (!smu_clk_dpm_is_enabled(smu, clk_type)) {
+		switch (clk_type) {
+		case SMU_MCLK:
+		case SMU_UCLK:
+			clock_limit = smu->smu_table.boot_values.uclk;
+			break;
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			clock_limit = smu->smu_table.boot_values.gfxclk;
+			break;
+		case SMU_SOCCLK:
+			clock_limit = smu->smu_table.boot_values.socclk;
+			break;
+		default:
+			clock_limit = 0;
+			break;
+		}
+
+		/* clock in Mhz unit */
+		if (min)
+			*min = clock_limit / 100;
+		if (max)
+			*max = clock_limit / 100;
+
+		return 0;
+	}
+
+	if (max) {
+		ret = renoir_get_profiling_clk_mask(smu,
+						    AMD_DPM_FORCED_LEVEL_PROFILE_PEAK,
+						    NULL,
+						    &mclk_mask,
+						    &soc_mask);
+		if (ret)
+			goto failed;
+
+		switch (clk_type) {
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			ret = smu_send_smc_msg(smu, SMU_MSG_GetMaxGfxclkFrequency, max);
+			if (ret) {
+				dev_err(smu->adev->dev, "Attempt to get max GX frequency from SMC Failed !\n");
+				goto failed;
+			}
+			break;
+		case SMU_UCLK:
+		case SMU_FCLK:
+		case SMU_MCLK:
+			ret = renoir_get_dpm_clk_limited(smu, clk_type, mclk_mask, max);
+			if (ret)
+				goto failed;
+			break;
+		case SMU_SOCCLK:
+			ret = renoir_get_dpm_clk_limited(smu, clk_type, soc_mask, max);
+			if (ret)
+				goto failed;
+			break;
+		default:
+			ret = -EINVAL;
+			goto failed;
+		}
+	}
+
+	if (min) {
+		switch (clk_type) {
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			ret = smu_send_smc_msg(smu, SMU_MSG_GetMinGfxclkFrequency, min);
+			if (ret) {
+				dev_err(smu->adev->dev, "Attempt to get min GX frequency from SMC Failed !\n");
+				goto failed;
+			}
+			break;
+		case SMU_UCLK:
+		case SMU_FCLK:
+		case SMU_MCLK:
+			ret = renoir_get_dpm_clk_limited(smu, clk_type, 0, min);
+			if (ret)
+				goto failed;
+			break;
+		case SMU_SOCCLK:
+			ret = renoir_get_dpm_clk_limited(smu, clk_type, 0, min);
+			if (ret)
+				goto failed;
+			break;
+		default:
+			ret = -EINVAL;
+			goto failed;
+		}
+	}
+failed:
+	return ret;
+}
+
 static int renoir_print_clk_levels(struct smu_context *smu,
 			enum smu_clk_type clk_type, char *buf)
 {
@@ -264,7 +395,7 @@ static int renoir_print_clk_levels(struct smu_context *smu,
 	case SMU_SCLK:
 		/* retirve table returned paramters unit is MHz */
 		cur_value = metrics.ClockFrequency[CLOCK_GFXCLK];
-		ret = smu_v12_0_get_dpm_ultimate_freq(smu, SMU_GFXCLK, &min, &max);
+		ret = renoir_get_dpm_ultimate_freq(smu, SMU_GFXCLK, &min, &max);
 		if (!ret) {
 			/* driver only know min/max gfx_clk, Add level 1 for all other gfx clks */
 			if (cur_value  == max)
@@ -434,7 +565,7 @@ static int renoir_force_dpm_limit_value(struct smu_context *smu, bool highest)
 
 	for (i = 0; i < ARRAY_SIZE(clks); i++) {
 		clk_type = clks[i];
-		ret = smu_v12_0_get_dpm_ultimate_freq(smu, clk_type, &min_freq, &max_freq);
+		ret = renoir_get_dpm_ultimate_freq(smu, clk_type, &min_freq, &max_freq);
 		if (ret)
 			return ret;
 
@@ -468,7 +599,7 @@ static int renoir_unforce_dpm_levels(struct smu_context *smu) {
 
 		clk_type = clk_feature_map[i].clk_type;
 
-		ret = smu_v12_0_get_dpm_ultimate_freq(smu, clk_type, &min_freq, &max_freq);
+		ret = renoir_get_dpm_ultimate_freq(smu, clk_type, &min_freq, &max_freq);
 		if (ret)
 			return ret;
 
@@ -552,33 +683,6 @@ static int renoir_get_workload_type(struct smu_context *smu, uint32_t profile)
 	return pplib_workload;
 }
 
-static int renoir_get_profiling_clk_mask(struct smu_context *smu,
-					 enum amd_dpm_forced_level level,
-					 uint32_t *sclk_mask,
-					 uint32_t *mclk_mask,
-					 uint32_t *soc_mask)
-{
-
-	if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK) {
-		if (sclk_mask)
-			*sclk_mask = 0;
-	} else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK) {
-		if (mclk_mask)
-			*mclk_mask = 0;
-	} else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {
-		if(sclk_mask)
-			/* The sclk as gfxclk and has three level about max/min/current */
-			*sclk_mask = 3 - 1;
-
-		if(mclk_mask)
-			*mclk_mask = NUM_MEMCLK_DPM_LEVELS - 1;
-
-		if(soc_mask)
-			*soc_mask = NUM_SOCCLK_DPM_LEVELS - 1;
-	}
-
-	return 0;
-}
 
 /**
  * This interface get dpm clock table for dc
@@ -633,7 +737,7 @@ static int renoir_force_clk_levels(struct smu_context *smu,
 			return -EINVAL;
 		}
 
-		ret = smu_v12_0_get_dpm_ultimate_freq(smu, SMU_GFXCLK, &min_freq, &max_freq);
+		ret = renoir_get_dpm_ultimate_freq(smu, SMU_GFXCLK, &min_freq, &max_freq);
 		if (ret)
 			return ret;
 		ret = smu_send_smc_msg_with_param(smu, SMU_MSG_SetSoftMaxGfxClk,
@@ -716,7 +820,7 @@ static int renoir_set_peak_clock_by_device(struct smu_context *smu)
 	int ret = 0;
 	uint32_t sclk_freq = 0, uclk_freq = 0;
 
-	ret = smu_v12_0_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &sclk_freq);
+	ret = renoir_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &sclk_freq);
 	if (ret)
 		return ret;
 
@@ -724,7 +828,7 @@ static int renoir_set_peak_clock_by_device(struct smu_context *smu)
 	if (ret)
 		return ret;
 
-	ret = smu_v12_0_get_dpm_ultimate_freq(smu, SMU_UCLK, NULL, &uclk_freq);
+	ret = renoir_get_dpm_ultimate_freq(smu, SMU_UCLK, NULL, &uclk_freq);
 	if (ret)
 		return ret;
 
@@ -961,7 +1065,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.fini_smc_tables = smu_v12_0_fini_smc_tables,
 	.set_default_dpm_table = smu_v12_0_set_default_dpm_tables,
 	.get_enabled_mask = smu_v12_0_get_enabled_mask,
-	.get_dpm_ultimate_freq = smu_v12_0_get_dpm_ultimate_freq,
+	.get_dpm_ultimate_freq = renoir_get_dpm_ultimate_freq,
 	.mode2_reset = smu_v12_0_mode2_reset,
 	.set_soft_freq_limited_range = smu_v12_0_set_soft_freq_limited_range,
 	.set_driver_table_location = smu_v12_0_set_driver_table_location,
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index 6400a0acad63..4e1b11d07438 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -316,106 +316,6 @@ int smu_v12_0_get_enabled_mask(struct smu_context *smu,
 	return ret;
 }
 
-int smu_v12_0_get_dpm_ultimate_freq(struct smu_context *smu, enum smu_clk_type clk_type,
-						 uint32_t *min, uint32_t *max)
-{
-	int ret = 0;
-	uint32_t mclk_mask, soc_mask;
-	uint32_t clock_limit;
-
-	if (!smu_clk_dpm_is_enabled(smu, clk_type)) {
-		switch (clk_type) {
-		case SMU_MCLK:
-		case SMU_UCLK:
-			clock_limit = smu->smu_table.boot_values.uclk;
-			break;
-		case SMU_GFXCLK:
-		case SMU_SCLK:
-			clock_limit = smu->smu_table.boot_values.gfxclk;
-			break;
-		case SMU_SOCCLK:
-			clock_limit = smu->smu_table.boot_values.socclk;
-			break;
-		default:
-			clock_limit = 0;
-			break;
-		}
-
-		/* clock in Mhz unit */
-		if (min)
-			*min = clock_limit / 100;
-		if (max)
-			*max = clock_limit / 100;
-
-		return 0;
-	}
-
-	if (max) {
-		ret = smu_get_profiling_clk_mask(smu, AMD_DPM_FORCED_LEVEL_PROFILE_PEAK,
-						 NULL,
-						 &mclk_mask,
-						 &soc_mask);
-		if (ret)
-			goto failed;
-
-		switch (clk_type) {
-		case SMU_GFXCLK:
-		case SMU_SCLK:
-			ret = smu_send_smc_msg(smu, SMU_MSG_GetMaxGfxclkFrequency, max);
-			if (ret) {
-				dev_err(smu->adev->dev, "Attempt to get max GX frequency from SMC Failed !\n");
-				goto failed;
-			}
-			break;
-		case SMU_UCLK:
-		case SMU_FCLK:
-		case SMU_MCLK:
-			ret = smu_get_dpm_clk_limited(smu, clk_type, mclk_mask, max);
-			if (ret)
-				goto failed;
-			break;
-		case SMU_SOCCLK:
-			ret = smu_get_dpm_clk_limited(smu, clk_type, soc_mask, max);
-			if (ret)
-				goto failed;
-			break;
-		default:
-			ret = -EINVAL;
-			goto failed;
-		}
-	}
-
-	if (min) {
-		switch (clk_type) {
-		case SMU_GFXCLK:
-		case SMU_SCLK:
-			ret = smu_send_smc_msg(smu, SMU_MSG_GetMinGfxclkFrequency, min);
-			if (ret) {
-				dev_err(smu->adev->dev, "Attempt to get min GX frequency from SMC Failed !\n");
-				goto failed;
-			}
-			break;
-		case SMU_UCLK:
-		case SMU_FCLK:
-		case SMU_MCLK:
-			ret = smu_get_dpm_clk_limited(smu, clk_type, 0, min);
-			if (ret)
-				goto failed;
-			break;
-		case SMU_SOCCLK:
-			ret = smu_get_dpm_clk_limited(smu, clk_type, 0, min);
-			if (ret)
-				goto failed;
-			break;
-		default:
-			ret = -EINVAL;
-			goto failed;
-		}
-	}
-failed:
-	return ret;
-}
-
 int smu_v12_0_mode2_reset(struct smu_context *smu){
 	return smu_v12_0_send_msg_with_param(smu, SMU_MSG_GfxDeviceDriverReset, SMU_RESET_MODE_2, NULL);
 }
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

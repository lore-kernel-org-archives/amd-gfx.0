Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DC9C433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8237120720
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="fZlOt6u5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8237120720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A4326EB6E;
	Fri, 10 Jul 2020 04:48:27 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2052.outbound.protection.outlook.com [40.107.92.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 37DC46EB6E
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 04:48:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P1y6IsJRZMkkyhbQ/etYozUo8Zw5Bp9NgehNkosMqWaRvjkx4AR8TSvRzSnnXtG7u5gW8dVMHz9JeAl1ASX77cqKYox743onQedAT79wHWnppF/FJMR4jEUkRpIPcCwWlFdIgTy16uIRKoyUwvU731hq08oCTH34SWb0n9KNXbw+0as5oldkkI/n+e1eyqK6Nx24XExCIqruBSKpRdbYOc9sLKClLljvQ2glmEQhs0ZUo+RqHAF4O+5aF5bOEwBeDD/FrmVHgFVgE7kVXz1E7QPqD0+yyFYEqb9lGvEUmgAfkIVMoOqe7h62pdFb8TllDL+Y79qizJJPnK0VG0YhEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDpKPlTwI/zdGfvR1Ze0aJrFRV5qcnleS+TH7sA8rjU=;
 b=lqDiuh0zFww4/Pit6P9Bujx7ZrHNWZICOqyo3LIq0N6mXh+6y45+Gu2sWwwyyPsnHM8EweUEAX9TuhOUCbM8pdNLbhtxHJEczClNmR4GwYXq+BCjmb0USZjQ9KCtigztqXH6sxCU23acZnsioFfmAjgbdkCuAzwWE6rbX8BOX1KE9gqVa28XPhPStAoDp3M+Y6YSA5bhqgapEyx3U/2W1d//8ku9Jvrt7WXvkJviqkiGMT33BN+0AaK6wWz1bdR8GhwBhCjL5MDkauehmNtZtckYRkQR7PIEe0jVh2JfxbLp39Jzqz+Hwg2kv22rI4BEDzXriLIw9xcm0UkGe8G3aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDpKPlTwI/zdGfvR1Ze0aJrFRV5qcnleS+TH7sA8rjU=;
 b=fZlOt6u5rErXAGRMx6gcc6QQtfGPYegw2eADq7HXDEwjBmRUIcapSMXhG4nCe5SOCSo/S8C/Xz6FVXNbugbd14QtbKvngcUK4UCWpxpvvDjhjZ70hNV2syaHE/k4W43P5abjDgXukSqJEbpQnyP5AU79f+OOXakIxsvve9wS5mI=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Fri, 10 Jul 2020 04:48:24 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 04:48:24 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/16] drm/amd/powerplay: drop unnecessary Arcturus specific
 APIs
Date: Fri, 10 Jul 2020 12:47:39 +0800
Message-Id: <20200710044746.23538-9-evan.quan@amd.com>
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
 15.20.3195.9 via Frontend Transport; Fri, 10 Jul 2020 04:48:23 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: de7027d6-c669-4e47-6126-08d8248c7a9c
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB23606DA77BD61F7E201AB852E4650@DM5PR12MB2360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:303;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GGq8Z1StEY35I7f9rotVDR6tz7wrxB04xYPjleyQywURIPS1FoiwyzxQFFj7BivOL2lyFfBUnIAJU4Cb+mZw1DhudP5GVschl8I+w4AN5ybHsaxyINNuopkrw33GVBg4yZrxmWKRRs8pAzuqeilIknwdILlGbiUUl/2dHwUlTMAwZLKmJnFNFx5ObTMQ2bJi8GrjYm8xqgo7AEMyQyjfHjWslYAyY9ndZv9fsvwfsf4Ltm7dYWZoT14N+QAPRwm8gN6hdFstC/8SYEsfiyv0at7iD+9aFiv+jwr/5Ruwuwq6ht2FM2rLBwXvHZkOanXhOKW1nGEQ+yNPuvIxVAiiJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(2906002)(4326008)(8676002)(8936002)(83380400001)(6486002)(44832011)(7696005)(52116002)(186003)(16526019)(956004)(2616005)(26005)(6916009)(316002)(478600001)(86362001)(6666004)(5660300002)(66556008)(1076003)(66476007)(36756003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: E5fxK/Um2oOodAVzkYzLdMvy5d8Gg3jlokKPGUSVntIr+qBjJJaHTRno0cufFWGTCuerTMpSAKHCPBP6pJ4ClqYX3FCh4t6I1GT4dg7j1Low6L3I+5Gk0PGK4yRJYcnHXAE0uky4A6mBJvs6lQWAg0+Si5YwH0yUkXZprVLrckiLMkJ+8mMiIOBK3sKaqAiwVW5PmLBQmkdqNgSOIYj6JV6GbXkuHQY4MleEUtSordJpTA2kGzuKLuX9oDFktiYB6ceu1tSdCfOa+8WXntFGlxns1N+lENQ6jd1/l4RNaY6y4p5Ezq9skz+YhZEhv8HgtQA2TCeQtNoLxVwg1ydg8NF608tM0yx9af9/0mK98vHq856W4G7cZvtor+WtfZ2eTW+zfZ6yWMfQ48vUPVjChe6H3Z937njBIsd3sFJCXhPFQeXHDyuTYTcLXLRYB6AJcan6MdTyEPkRa8Dm/J3vga1M6LJcZNwVyezW3OAb6WM3Y95UF7+vwQ2k9FGB3IDN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de7027d6-c669-4e47-6126-08d8248c7a9c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 04:48:24.6034 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lrFAFyKa2yXdHw3Sk3qf3hhi1OehMjOcWWksWCADQBzIUI2CvzIfdkrqMy2MLRBw
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

As a common performance level setting API is used. Then these
ASIC specific APIs are not needed any more.

Change-Id: Icd96ce42218d78d670dd0c1f88663fd42108b311
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/arcturus_ppt.c | 170 -------------------
 1 file changed, 170 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
index 33d472ffb2be..afd07c497205 100644
--- a/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/arcturus_ppt.c
@@ -1218,173 +1218,6 @@ static int arcturus_get_fan_speed_percent(struct smu_context *smu,
 	return ret;
 }
 
-static uint32_t arcturus_find_lowest_dpm_level(struct smu_11_0_dpm_table *table)
-{
-	uint32_t i;
-
-	for (i = 0; i < table->count; i++) {
-		if (table->dpm_levels[i].enabled)
-			break;
-	}
-	if (i >= table->count) {
-		i = 0;
-		table->dpm_levels[i].enabled = true;
-	}
-
-	return i;
-}
-
-static uint32_t arcturus_find_highest_dpm_level(struct smu_context *smu,
-						struct smu_11_0_dpm_table *table)
-{
-	int i = 0;
-
-	if (table->count <= 0) {
-		dev_err(smu->adev->dev, "[%s] DPM Table has no entry!", __func__);
-		return 0;
-	}
-	if (table->count > MAX_DPM_NUMBER) {
-		dev_err(smu->adev->dev, "[%s] DPM Table has too many entries!", __func__);
-		return MAX_DPM_NUMBER - 1;
-	}
-
-	for (i = table->count - 1; i >= 0; i--) {
-		if (table->dpm_levels[i].enabled)
-			break;
-	}
-	if (i < 0) {
-		i = 0;
-		table->dpm_levels[i].enabled = true;
-	}
-
-	return i;
-}
-
-static int arcturus_force_dpm_limit_value(struct smu_context *smu, bool highest)
-{
-	struct smu_11_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(smu->adev, 0);
-	uint32_t soft_level;
-	int ret = 0;
-
-	/* gfxclk */
-	if (highest)
-		soft_level = arcturus_find_highest_dpm_level(smu, &(dpm_context->dpm_tables.gfx_table));
-	else
-		soft_level = arcturus_find_lowest_dpm_level(&(dpm_context->dpm_tables.gfx_table));
-
-	ret = arcturus_upload_dpm_level(smu,
-					false,
-					FEATURE_DPM_GFXCLK_MASK,
-					soft_level);
-	if (ret) {
-		dev_err(smu->adev->dev, "Failed to upload boot level to %s!\n",
-				highest ? "highest" : "lowest");
-		return ret;
-	}
-
-	ret = arcturus_upload_dpm_level(smu,
-					true,
-					FEATURE_DPM_GFXCLK_MASK,
-					soft_level);
-	if (ret) {
-		dev_err(smu->adev->dev, "Failed to upload dpm max level to %s!\n!",
-				highest ? "highest" : "lowest");
-		return ret;
-	}
-
-	if (hive)
-		/*
-		 * Force XGMI Pstate to highest or lowest
-		 * TODO: revise this when xgmi dpm is functional
-		 */
-		ret = smu_v11_0_set_xgmi_pstate(smu, highest ? 1 : 0);
-
-	return ret;
-}
-
-static int arcturus_unforce_dpm_levels(struct smu_context *smu)
-{
-	struct smu_11_0_dpm_context *dpm_context =
-		(struct smu_11_0_dpm_context *)smu->smu_dpm.dpm_context;
-	struct amdgpu_hive_info *hive = amdgpu_get_xgmi_hive(smu->adev, 0);
-	uint32_t soft_min_level, soft_max_level;
-	int ret = 0;
-
-	/* gfxclk */
-	soft_min_level = arcturus_find_lowest_dpm_level(&(dpm_context->dpm_tables.gfx_table));
-	soft_max_level = arcturus_find_highest_dpm_level(smu, &(dpm_context->dpm_tables.gfx_table));
-
-	ret = arcturus_upload_dpm_level(smu,
-					false,
-					FEATURE_DPM_GFXCLK_MASK,
-					soft_min_level);
-	if (ret) {
-		dev_err(smu->adev->dev, "Failed to upload DPM Bootup Levels!");
-		return ret;
-	}
-
-	ret = arcturus_upload_dpm_level(smu,
-					true,
-					FEATURE_DPM_GFXCLK_MASK,
-					soft_max_level);
-	if (ret) {
-		dev_err(smu->adev->dev, "Failed to upload DPM Max Levels!");
-		return ret;
-	}
-
-	if (hive)
-		/*
-		 * Reset XGMI Pstate back to default
-		 * TODO: revise this when xgmi dpm is functional
-		 */
-		ret = smu_v11_0_set_xgmi_pstate(smu, 0);
-
-	return ret;
-}
-
-static int
-arcturus_get_profiling_clk_mask(struct smu_context *smu,
-				enum amd_dpm_forced_level level,
-				uint32_t *sclk_mask,
-				uint32_t *mclk_mask,
-				uint32_t *soc_mask)
-{
-	struct smu_11_0_dpm_context *dpm_context =
-		(struct smu_11_0_dpm_context *)smu->smu_dpm.dpm_context;
-	struct smu_11_0_dpm_table *gfx_dpm_table;
-	struct smu_11_0_dpm_table *mem_dpm_table;
-	struct smu_11_0_dpm_table *soc_dpm_table;
-
-	gfx_dpm_table = &dpm_context->dpm_tables.gfx_table;
-	mem_dpm_table = &dpm_context->dpm_tables.uclk_table;
-	soc_dpm_table = &dpm_context->dpm_tables.soc_table;
-
-	*sclk_mask = 0;
-	*mclk_mask = 0;
-	*soc_mask  = 0;
-
-	if (gfx_dpm_table->count > ARCTURUS_UMD_PSTATE_GFXCLK_LEVEL &&
-	    mem_dpm_table->count > ARCTURUS_UMD_PSTATE_MCLK_LEVEL &&
-	    soc_dpm_table->count > ARCTURUS_UMD_PSTATE_SOCCLK_LEVEL) {
-		*sclk_mask = ARCTURUS_UMD_PSTATE_GFXCLK_LEVEL;
-		*mclk_mask = ARCTURUS_UMD_PSTATE_MCLK_LEVEL;
-		*soc_mask  = ARCTURUS_UMD_PSTATE_SOCCLK_LEVEL;
-	}
-
-	if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK) {
-		*sclk_mask = 0;
-	} else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK) {
-		*mclk_mask = 0;
-	} else if (level == AMD_DPM_FORCED_LEVEL_PROFILE_PEAK) {
-		*sclk_mask = gfx_dpm_table->count - 1;
-		*mclk_mask = mem_dpm_table->count - 1;
-		*soc_mask  = soc_dpm_table->count - 1;
-	}
-
-	return 0;
-}
-
 static int arcturus_get_power_limit(struct smu_context *smu)
 {
 	struct smu_11_0_powerplay_table *powerplay_table =
@@ -2534,9 +2367,6 @@ static const struct pptable_funcs arcturus_ppt_funcs = {
 	.read_sensor = arcturus_read_sensor,
 	.get_fan_speed_percent = arcturus_get_fan_speed_percent,
 	.get_fan_speed_rpm = arcturus_get_fan_speed_rpm,
-	.force_dpm_limit_value = arcturus_force_dpm_limit_value,
-	.unforce_dpm_levels = arcturus_unforce_dpm_levels,
-	.get_profiling_clk_mask = arcturus_get_profiling_clk_mask,
 	.get_power_profile_mode = arcturus_get_power_profile_mode,
 	.set_power_profile_mode = arcturus_set_power_profile_mode,
 	.set_performance_level = arcturus_set_performance_level,
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

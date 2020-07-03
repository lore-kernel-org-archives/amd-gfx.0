Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0367AC433DF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:33:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDA3E20826
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="kWfgCDYR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA3E20826
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 951376E339;
	Fri,  3 Jul 2020 08:33:58 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC99E6E339
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 08:33:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BsnuYZMmQuhWUbMlZJ8riD2KcPiY0028rJEW7hv0fRUFFmvV6u8EWWk2XfdKlDFDcv8zqT7Uwn9f406siT3SLSGIAHnDJhwq+ZBYBSWBcPgMwVKxtuZmForQ9OEXoYr+U29v76vGW9AEUmX8s5aZ9QoGpQvhjj+C93EKX3rN1ihoR5ITnZjsDBq2hzoJVgO2R2g7VKaKmiINim4gHu5GD1MAwlStcwmliwkmcX3DGlQ+5gHe4sZAbC5nUMfJL/Ne29BQIbsWrFV8l+2KX+4EE7j3qUtosElDheMkIsjNeiPtSKyJHw4YwttDM0t2hINy2GmRmPBRKfoWd/nbIothDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tS21JrtN+SxpPvtkffNTFz2UnLcUWecO7XCxuVF4Qc=;
 b=evURIDfEVeF6g1nlglQRAtPTNE3qnIPWXHCiA04g4hrKmdSWK1BQo/d4Erlpkm4bSjUUCFtXhxcAkFcmCdSFyHJGYxYYWoTH4raSvUK9EGK+TtO8waI6AVLNdupuB08i1VhyVQwPyYTmMYa0aUueLXqnoX30dINi71i2g9iBEMmWTQgsS4Yz5XnyBSj/wJRNg8RAY9hJaIJfF5+M31sueCmwEXtJWiXq21+//EJokZuwrZmOb4MGb5yIHYguNactx3nc8PCXTeQU3iDnEIbTT5+k4kxBgJ4AD198OG771crmBCEPpaOIbj1Vs88KC7s2ZKES7L1+ElsnsFzNis+ZzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5tS21JrtN+SxpPvtkffNTFz2UnLcUWecO7XCxuVF4Qc=;
 b=kWfgCDYRuJTrYfk/qQpBT+j7A37L/1TuczMwq9bbNtPJQFa0ecU7P5mLt2kulJ6PgDfPSUKeO/i9xnw7Vwh9L/cE1KWtUn6x6OFV1iv54ZA8cIv0/OIPo3Lg+EJTbbHRUYjqH5VtbBIzSZ+w/CAACUVLH+aN0AxXCAySMvTSU4w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.27; Fri, 3 Jul 2020 08:33:56 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 08:33:56 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/14] drm/amd/powerplay: drop unnecessary Arcturus specific
 APIs
Date: Fri,  3 Jul 2020 16:32:57 +0800
Message-Id: <20200703083303.478-8-evan.quan@amd.com>
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
 15.20.3153.22 via Frontend Transport; Fri, 3 Jul 2020 08:33:54 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: d8ccedc6-cf65-4b48-2878-08d81f2bd2f0
X-MS-TrafficTypeDiagnostic: DM6PR12MB3962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB396219E667FC05BD7CA0A0E8E46A0@DM6PR12MB3962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:303;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 122yfytQxzLSg6P0gP1d4gBRQSCrYq8ZKfSCzEiZAuoskqvNE1GFzRg0fhuHfEOY67wJSh4f5HkGWteC03aetbkkoQ6OF2sxqe1I/yxZJdhxffAiDto9PKNolOBZfhiC4txmPane5852A5eIJRib8/JkEI77gUrHlKngVEphFxnLp9bh+5FALO3gI1iGM8uGp90I/znvM0k+GVY4a7vieaYEYfQ3tUsbAu1ErfYiZrd5A9QNhjOyzGxxvCQIUlixE1AX7XZmW+0hk97KCXY/0nZh/uCWuS9gmUREPGeSRelCz4bFY8U47hLOanJr/qCi9iPUuKd09kKRIgQbznw9Wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(83380400001)(44832011)(4326008)(36756003)(8936002)(7696005)(956004)(2616005)(6486002)(52116002)(478600001)(66946007)(16526019)(26005)(186003)(66476007)(5660300002)(1076003)(66556008)(8676002)(316002)(86362001)(6916009)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: Bro2HZMTaKYqnkDmNtCJkWMPkPnA96lO5788Y67ut9/GhddJiL/kjZb9Ar15GH17fFKiQQ8xrb6lD4Z5bVZ6U/EleCKkzT8X2lzqEAxksRveV2LnrA/cmXNwuXgGzXPddAilWgyEuzTzDLjPQiCFp3KNBRKgEWk3UaB+9CjcdU62cau7qfmF9oaLT5d+FCCU7PxtCMfKgIcKdqdPVc9KLYTrI5DnpTcRL4tw0Ws67gYp+aJ/PZPHHiGrjqaJKR0MybqTgZDu7KpFqXAtcZGCl/SJ7E4/qe8yXdwsjM1OegrxyJV4KU6CehPx2RUWk/crEwuwy/6j9vCh8U2T1Z2he+ijLElOCd76+h5cUNW7yj8JZlKwQpx7F4AKmmXsVkVPzOwte+b+jDNlirPJ9f6FZOt1l+gW3iz8VIt/iwJG3+ArBxxpPVaLeHCSX+8ogXoFybwqePTBVIr0vO6YTOQwyMLUzoiKlaJkqOBKB6xXdgaqHD6MN6PdUJgzgxRnOYKr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8ccedc6-cf65-4b48-2878-08d81f2bd2f0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:33:55.9322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a+B91XcJfqn0HaDVtI8/LjWqhM3egYUrGZ4xBfMeNJK4DTFhsu8RKBBWtNMpHzB1
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

Change-Id: Icd96ce42218d78d670dd0c1f88663fd42108b311
Signed-off-by: Evan Quan <evan.quan@amd.com>
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

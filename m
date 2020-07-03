Return-Path: <SRS0=khk6=AO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B972C433E0
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:34:04 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13238207FF
	for <amd-gfx@archiver.kernel.org>; Fri,  3 Jul 2020 08:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="uWpdzGYP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13238207FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C6B1E6E1F5;
	Fri,  3 Jul 2020 08:34:03 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2044.outbound.protection.outlook.com [40.107.244.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9350A6E1F5
 for <amd-gfx@lists.freedesktop.org>; Fri,  3 Jul 2020 08:34:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xt3+VlKfuz+VOShOzpYiRbu6jvi86mCteogRNZVXsNkgGCnwgDIMtRpxl1hSE5KtwJ0HGg4iP+uCbLCGXqlqTJjYrSyhtMVJV3eWZmh9kj/8lFzhF+X230u5nm9b7iNU1BmKHvMcBthEOYBviTn3dyKg1cxr+dunP/4Hx2S3FB4EBkXAjc92Ox4E2w0yUZomfkaZqRmMMAG+eNV+DRIKCn+8dcg0bn7vXqTuYX7xrh5KG3eSFOCRMOyc7a3L4OgKzG5GKbK1HPpwPC98URjJlDgeKkYDTO+ZuTC6h+WL6tWmJrQRuk4W23CA9P86myLzJswC8hgTNSqb3hDBGG4Paw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLvdr6uQ52VEFZK+pz88H8QX24gaybekAL0wwuMVTJQ=;
 b=KxdzRZ7a1myJKDDb0+VNFVMAMaHN24icIugvBnTYOTipW0+w2z8TRFoK2dHSYf+tChdWhQCJzYSmDouKlIePjDAuPpmdEBHH8XCVZikw8DFs3MwE451EVwhd+Ph/z67rui/xc9vViI91rrluXuQU+3sSbAL6w50kI1pgdzRUZExASDuiw+gYsUdCC+aormkYjnFVPIkUKhbTFF7xuGfdPqcJFfHIojz9Pse4Me7pFUV687SruKwQbKJM1acsW0E9YWFKgd3LaQJYOn7VTbsuoB1r/t8V4Wypex+ysVoGTWg6Q40LLpQOs7G/Lem+lxtTHig/4uF8diHP3p93FCs17w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qLvdr6uQ52VEFZK+pz88H8QX24gaybekAL0wwuMVTJQ=;
 b=uWpdzGYPIxmo1f3ThH+v/r/Lx4BU8i4rGsxMTOmzK/+2sLcEkl3UgH22iEJaJ+uvVc8i7Uwy9eFMXAqYUv980lyU0rTEWBIjkR7dEyY//sAU3x6Dy7P/F3A7svnVXH3gYCVURFouYrGkyrCKsMoUWJr/UO2wOGQ0R7g1aYobmIA=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM6PR12MB3962.namprd12.prod.outlook.com (2603:10b6:5:1ce::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3153.27; Fri, 3 Jul 2020 08:34:01 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3153.023; Fri, 3 Jul 2020
 08:34:01 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/14] drm/amd/powerplay: drop unnecessary Sienna Cichlid
 specific APIs
Date: Fri,  3 Jul 2020 16:32:59 +0800
Message-Id: <20200703083303.478-10-evan.quan@amd.com>
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
 15.20.3153.22 via Frontend Transport; Fri, 3 Jul 2020 08:34:00 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 84561c66-c47f-473d-a2c2-08d81f2bd65f
X-MS-TrafficTypeDiagnostic: DM6PR12MB3962:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR12MB396245D3497D728698045CF3E46A0@DM6PR12MB3962.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-Forefront-PRVS: 045315E1EE
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XpPD6moRWyUo5lJnUaTCkR2DJ55ucOMh8gJzB3G43kzPTgxNnYZdhBk9UVbL/xQgEufa3xkYV55XTE8DPD9jwfd/7LYF6rjnbeyR7UIMithfZMHg8j8K9KrpU9FPwgh+xOrVhrNFEa1ocRNcckFypQ4tVWSgZTRL3QPsv7u+J5wFRcDg6gRpoqDL/tY3JbyC7nmNqeG52i/bOK+hoK/joM18RVfw9Cxtmiu06AiDUq+otlEka57dmbvIqFlsX4V4sY7lUnNyVwdCRCV0mPhWLEwWdV9uzp8aA1SXoouKetXENqPvTrE0f/GP8tQrBu36dkpVKlidTv1ZDkIOOSmhMQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(376002)(346002)(39860400002)(396003)(136003)(83380400001)(44832011)(4326008)(36756003)(8936002)(7696005)(956004)(2616005)(6486002)(52116002)(478600001)(66946007)(16526019)(26005)(186003)(66476007)(5660300002)(1076003)(66556008)(8676002)(316002)(86362001)(6916009)(2906002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: 26kN5KKbMCiJQiW1aLj5qXoIcpaIaNcET2J4RgHhYEVHQxC7f6t+55G64RUT/RQQU63A9m/RvVTk+OwbIjL16Mk0cSE9OR98jPm9uAej56DLKxamKAaU3Sd1yy8rQhNs2HX+Pz4zOYaYu01zWrgrNbu/qHqFqWmh0f4MlHhIzTGHOsJO5q/DGLDXjCjh177qXz5BtL7Fm/RYsKzXGQG4oGW360YP8PHUCltlypr3KwbyKnM0Vrxj5bEdtwsGF93PZe431eG8C5VlTNLS5bFJmTnVfu5SoqBciYhVRQUTwZBoOwpmnVFXKl1Po8kv0IMOBbacSvD4N6p62CyxFaq6xNOeLmBKjKAMgNCXVFx5XTpxyrLlemp9UFQfFwCYmKJmCi6mEgnraw5chawGmDirG8ai8vU4J0gWsLRvyQj0AwOrFp0gTBUTnWF3q+Rr/Xg3GOBmAZKmnERp9RTZpJmMGxZ0uJsT5sYyLCKenhOsTARNPXq5tnJcEM3p9lpisCqw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84561c66-c47f-473d-a2c2-08d81f2bd65f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2020 08:34:01.6480 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F/rrjOmg3vQPjDcs4emFyQGeiJSpyyd1A6iUp0SJYBUwZzSyO4MhyEh+fXoJkTvw
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

Change-Id: I04c810859794b07ce8905a8df797ed6b5ae116a8
Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../drm/amd/powerplay/sienna_cichlid_ppt.c    | 178 +-----------------
 1 file changed, 1 insertion(+), 177 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
index 8fae7dd982c7..27f77bde184f 100644
--- a/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/sienna_cichlid_ppt.c
@@ -1181,59 +1181,6 @@ static int sienna_cichlid_display_config_changed(struct smu_context *smu)
 	return ret;
 }
 
-static int sienna_cichlid_force_dpm_limit_value(struct smu_context *smu, bool highest)
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
-		ret = sienna_cichlid_set_soft_freq_limited_range(smu, clk_type, force_freq, force_freq);
-		if (ret)
-			return ret;
-	}
-
-	return ret;
-}
-
-static int sienna_cichlid_unforce_dpm_levels(struct smu_context *smu)
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
-		ret = sienna_cichlid_set_soft_freq_limited_range(smu, clk_type, min_freq, max_freq);
-		if (ret)
-			return ret;
-	}
-
-	return ret;
-}
-
 static int sienna_cichlid_get_gpu_power(struct smu_context *smu, uint32_t *value)
 {
 	if (!value)
@@ -1486,50 +1433,6 @@ static int sienna_cichlid_set_power_profile_mode(struct smu_context *smu, long *
 	return ret;
 }
 
-static int sienna_cichlid_get_profiling_clk_mask(struct smu_context *smu,
-					 enum amd_dpm_forced_level level,
-					 uint32_t *sclk_mask,
-					 uint32_t *mclk_mask,
-					 uint32_t *soc_mask)
-{
-	struct amdgpu_device *adev = smu->adev;
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
-			amdgpu_gfx_off_ctrl(adev, false);
-			ret = smu_v11_0_get_dpm_level_count(smu, SMU_SCLK, &level_count);
-			amdgpu_gfx_off_ctrl(adev, true);
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
 static int sienna_cichlid_notify_smc_display_config(struct smu_context *smu)
 {
 	struct smu_clocks min_clocks = {0};
@@ -1761,82 +1664,6 @@ static int sienna_cichlid_get_uclk_dpm_states(struct smu_context *smu, uint32_t
 	return 0;
 }
 
-static int sienna_cichlid_set_performance_level(struct smu_context *smu,
-					enum amd_dpm_forced_level level);
-
-static int sienna_cichlid_set_standard_performance_level(struct smu_context *smu)
-{
-	struct amdgpu_device *adev = smu->adev;
-	int ret = 0;
-	uint32_t sclk_freq = 0, uclk_freq = 0;
-
-	switch (adev->asic_type) {
-	/* TODO: need to set specify clk value by asic type, not support yet*/
-	default:
-		/* by default, this is same as auto performance level */
-		return sienna_cichlid_set_performance_level(smu, AMD_DPM_FORCED_LEVEL_AUTO);
-	}
-
-	ret = sienna_cichlid_set_soft_freq_limited_range(smu, SMU_SCLK, sclk_freq, sclk_freq);
-	if (ret)
-		return ret;
-	ret = sienna_cichlid_set_soft_freq_limited_range(smu, SMU_UCLK, uclk_freq, uclk_freq);
-	if (ret)
-		return ret;
-
-	return ret;
-}
-
-static int sienna_cichlid_set_peak_performance_level(struct smu_context *smu)
-{
-	int ret = 0;
-
-	/* TODO: not support yet*/
-	return ret;
-}
-
-static int sienna_cichlid_set_performance_level(struct smu_context *smu,
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
-		ret = sienna_cichlid_set_standard_performance_level(smu);
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
-		ret = sienna_cichlid_set_peak_performance_level(smu);
-		break;
-	case AMD_DPM_FORCED_LEVEL_MANUAL:
-	case AMD_DPM_FORCED_LEVEL_PROFILE_EXIT:
-	default:
-		break;
-	}
-	return ret;
-}
-
 static int sienna_cichlid_get_thermal_temperature_range(struct smu_context *smu,
 						struct smu_temperature_range *range)
 {
@@ -2684,18 +2511,15 @@ static const struct pptable_funcs sienna_cichlid_ppt_funcs = {
 	.pre_display_config_changed = sienna_cichlid_pre_display_config_changed,
 	.display_config_changed = sienna_cichlid_display_config_changed,
 	.notify_smc_display_config = sienna_cichlid_notify_smc_display_config,
-	.force_dpm_limit_value = sienna_cichlid_force_dpm_limit_value,
-	.unforce_dpm_levels = sienna_cichlid_unforce_dpm_levels,
 	.is_dpm_running = sienna_cichlid_is_dpm_running,
 	.get_fan_speed_percent = sienna_cichlid_get_fan_speed_percent,
 	.get_fan_speed_rpm = sienna_cichlid_get_fan_speed_rpm,
 	.get_power_profile_mode = sienna_cichlid_get_power_profile_mode,
 	.set_power_profile_mode = sienna_cichlid_set_power_profile_mode,
-	.get_profiling_clk_mask = sienna_cichlid_get_profiling_clk_mask,
 	.set_watermarks_table = sienna_cichlid_set_watermarks_table,
 	.read_sensor = sienna_cichlid_read_sensor,
 	.get_uclk_dpm_states = sienna_cichlid_get_uclk_dpm_states,
-	.set_performance_level = sienna_cichlid_set_performance_level,
+	.set_performance_level = smu_v11_0_set_performance_level,
 	.get_thermal_temperature_range = sienna_cichlid_get_thermal_temperature_range,
 	.display_disable_memory_clock_switch = sienna_cichlid_display_disable_memory_clock_switch,
 	.get_power_limit = sienna_cichlid_get_power_limit,
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4DFC433E0
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A749720720
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="2dRTf4NE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A749720720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7506A6EB67;
	Fri, 10 Jul 2020 04:48:31 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0D666EB68
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 04:48:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ntplxdev5HELDCewh0/ZJmGNiwP8t2Sto0/cHB2B7C7qz8TeoDPmzASRkPFOKrQxzVwHZTVekbUqVQtEyShbEsSoE4Cai/PtrG4l61N+j9HPq/HmH0CcjyZ3lIXgsI97d4c2Qy6mxlGHUmw8VeBv3J9fUuSPW+EmJV9Pu1riXjP92aXNqU2mn4h2OyaxZZRk4MaFLBM69ZTd+CMQiuKCfdL3rCFe2MZSJUD9KnEt7DfbHvnjkKNOiOsEZz8wYhlNlv0MAzpPZPp/g54l9mSP3YcUe4gKJH+lngvaSvxauNDPyB0+wzNkbWFruNTRsl+DCDvdP2/YZOK7Dz7QGPpcUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fh+6TwlXoTax4u5HZBNoT1k/phmMucvjHM2k7ovyRcY=;
 b=U+/yEKmTQXKfnm4OmaTSP7xHmBCal960X8oXD9YP4KwAw8vhonus/gG6ozVlIHE+eEApm47R0s4aMtz84JhdqYO72411jWYy0q2/tDzJdw0k0KCnifnuuJb3Mm01e5+7IcVPOMhNhqmghPi0fSzmnI0V3w2ZAAyh1L5OaqSfsWS4M1WQuVzG1HIdWLpYMUeQdBgxtxYZJrXHaQ8U1GNmzvrBl3MLhsAoJ3T/d4CLfi9UMIDv+Wx5HSx356NcXVIyAcwZyEu24c1t3vQ8F20ox2XtmaVGf7TzcA+VBnWLTSlheXViCLZHj9zX46g9PMKbOZeNkZkl+9x4BZuzgiWL+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fh+6TwlXoTax4u5HZBNoT1k/phmMucvjHM2k7ovyRcY=;
 b=2dRTf4NEdsO78hGaWN/vpiQtJEQ+eeqUneqag8N2s45Lq7ilO3TkZfJ+1K4DBYf7Nx5joODM8FY+hXxmCaH1gyOvBqGI91iwO02i4Ro7H6AI6NSFQdu82EldZjnSr+N/No9soQBqyKo2AM89riTNussbBbWicyVwMTrC4DztfXk=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Fri, 10 Jul 2020 04:48:28 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 04:48:28 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/16] drm/amd/powerplay: drop unnecessary Sienna Cichlid
 specific APIs
Date: Fri, 10 Jul 2020 12:47:41 +0800
Message-Id: <20200710044746.23538-11-evan.quan@amd.com>
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
 15.20.3195.9 via Frontend Transport; Fri, 10 Jul 2020 04:48:26 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 732dc288-aaba-4e54-fa06-08d8248c7cc3
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2360C31348CF85BA41F90692E4650@DM5PR12MB2360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f2CWVYn80Hd0FhwsISXjka/y2lNC6vGTXh2Ux0lj+dJw9pFEVmGR7SaLbiBKrbeWBl31BpZAWl7SPAQgR5s3XRfcnDMjBxXu28rBFqn9CvddAQDhboQpKkrOqW+dq7RrdClVGJWGxffWgT/dzxE4NMivyvq07IYBR9Pmzq96ii/72UvlQHOiGxBM9zbM2IhPie+mfQgYMe/nqJeHAtT0h7faKVcu1wRkS8pok7TILmg+JxrTMd/yCih/H94EUhYUuGhgVdMe5mUqZCsExD7B/XIBjKqv2zJ6ETZyaLw6LvNizvt6f7cm5wV3fFpJix49p9+yBzSVdmhnivzPpNVLCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(2906002)(4326008)(8676002)(8936002)(83380400001)(6486002)(44832011)(7696005)(52116002)(186003)(16526019)(956004)(2616005)(26005)(6916009)(316002)(478600001)(86362001)(6666004)(5660300002)(66556008)(1076003)(66476007)(36756003)(66946007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: O8ziOrGu9c7TPJxIyQTdb8o0JeR2JdCz6Ulcids87As2BXBwacM7eSwtdW0qnYL/MUVTzbe6YB4l8p7nKrpKK4FMX3+FkyIc9MZZ22TNpcfjVTgF8n9FEmEJWI6Nm9D/nfuIrhZfN6AElATyCximDQ2KjB+BmVrD2Qz/ToQEk1O0W57aa4/jLAxc8WlcjiMJ+kmPRYac8O+RB3o/rVBp9t+i3u6mbZK9BcAGT7Zr/udkmqR8mIrhGpP65S+mVjxsqARBT2aJ0yzzEhn6+34hExiLr3JT6/8TccyAMbEPE6C1l/DGVLlgDw/4JfNU+6s9zTyJXxd7d4puzUiISBpfyJMjsPaqi4MpnplRWbLnn8EJKuK0mzEQvaHRrl/vvBiQ++sLNhbc56/CgwOf7bDrAPZIRbToHzRawo00gkWUZsTy7lIf/ZMCsfHO/lIomJfd160TI//M0t/mPSsZTR62ZfT/DwpQ5D2U4NH0/yUKo4QFK8XS4raMnD9/Nkf9EoeG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 732dc288-aaba-4e54-fa06-08d8248c7cc3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 04:48:28.2693 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GfOaDmadSM5fTGIJ9eXotPPCb0V5d87A7ACn1ow4Qt1xKFJDmUwURpfOpraRKSVu
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

Change-Id: I04c810859794b07ce8905a8df797ed6b5ae116a8
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
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

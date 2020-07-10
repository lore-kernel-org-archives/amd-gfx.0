Return-Path: <SRS0=NsFz=AV=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A43C433DF
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B68BE20720
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2020 04:48:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="WZweZR3l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B68BE20720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F5E76EB6F;
	Fri, 10 Jul 2020 04:48:29 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2055.outbound.protection.outlook.com [40.107.92.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10C276EB6F
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2020 04:48:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gTu0b8D4DKy4GBNGeYlFiFLisO8jQMycsjfv2gNzsyJEXDZzaohgVs1twtg9bWiL+/KJ240bJAZmkeyHG0BKHGllHGZe2d3EoPNeUlHQdIPV46JOWSgh/4FMXwvlzkvbbkukNWpO0mY6tE+9ME9a26bNlMMdsYiFq1K0IVkbRZdpONUJxwkow9Ay0RGxUJPRXA2Fpb50Kymw8Rb1CYp662zyK3iFAqa9DsdBx5NCtv3ZMy2+ErcE+FEKiZdeHcTbO1+XU6r9Cx8qzH/6xZm3J5ZjfRqJ1+9aivTw1gmWWDnArPKPL/gCBHQD98QjAFBalFgGuTvvMMyKsSP3D3ORiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwR7pkpLas6UfUPUoE60ABZptaKqjNqyK/hY46ykYfQ=;
 b=ndNRNv/gaf5+XJWvrNOjRlMIpEG5CDOzN8/ObmfYSs0fxrLVkwFWLY8UAn2Bor3Q8atDlnMmwKu6LzLmAVMdcgtaYXNoXkzrP+NWdGYwSHCJ4MKsAnjeF9qY/MuMeccWqn6ex+QKngXiSR4WPeD8dN/gthe5TOM/IhZlgAL0pIOCbuwF/A0VuMWv5OsxgQLbo+QqiNF0pSLtVfHGHPiYnz/qKBdObp8SUaBWq1RbefqbvM3buUaS5rrD3DMYSVF55FLKhwbFvUk449ayif1lglYNdMOOLEONKskbDCemIqgAvXxln+rnPKLTFOoTK8toSpC66UuTyOZnEDH/KViOjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PwR7pkpLas6UfUPUoE60ABZptaKqjNqyK/hY46ykYfQ=;
 b=WZweZR3l/BslTzmKHr39nmMkMGMmo3/eibAQglQSjcf72VR8Co3EC7k5RcZ6rqp10/r08DcorDf1sPhXLdbfwZ5ULDw5JE0QJ1BxUXYr+bILIepp2Mwjg0/ukuk3OT/Bw5AnQrFEcascmGqM3keIulQ+DI94e2auXtPg21z5Z7w=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB2360.namprd12.prod.outlook.com (2603:10b6:4:bb::21) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.21; Fri, 10 Jul 2020 04:48:26 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::c157:8999:dcc3:536f%3]) with mapi id 15.20.3174.023; Fri, 10 Jul 2020
 04:48:26 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/16] drm/amd/powerplay: drop unnecessary Navi1x specific APIs
Date: Fri, 10 Jul 2020 12:47:40 +0800
Message-Id: <20200710044746.23538-10-evan.quan@amd.com>
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
 15.20.3195.9 via Frontend Transport; Fri, 10 Jul 2020 04:48:25 +0000
X-Mailer: git-send-email 2.27.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: ec16c32d-3c71-45a4-11ba-08d8248c7bab
X-MS-TrafficTypeDiagnostic: DM5PR12MB2360:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB2360EE226FC1C223D956F30EE4650@DM5PR12MB2360.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:341;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r8G9jTcuzUQ4s/vUcSHMKF3kKyy6P+UvL4ax0sUSCHASPhtDGEhKDg6NcYUoHl3MSoWEbHJ/1AQ69PWKhqRqhUeVB8slRGkNY8a8sKoqQY7zK2drCkZfDzoBEMROxXSfPNrGJTO+KAgQl6Z1TI8wkxmrJvuQLZYY+yw8z/oCtdxNmb3kCuP6qT9ZMxVHq4l7VrPGAI8alzUrkdX7gsWBcJenuqlCWyKuRzHcvDqqW+Cr3LdIR8qmTvmzUbZtdsnuimaJ9QmTw23aZQhckuTEHFtB3gN0Megp5xDgN982XK1aE+IjD3lK9CPyTECpPjQJCVRRXgtR0sWFifOW8+mHffb8rVEz1IQgtELjJq0vBGhKpdEdv/MYZNiidoTL2Kgl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(2906002)(4326008)(8676002)(8936002)(83380400001)(6486002)(44832011)(7696005)(52116002)(186003)(16526019)(956004)(2616005)(26005)(6916009)(316002)(478600001)(86362001)(6666004)(5660300002)(66556008)(1076003)(66476007)(36756003)(66946007)(32563001);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: KJ4aoAzlTrYaVSx0g2tgc4ARJ10mn3eL1+/fTDSoKPj4XP7syR4rmtHccGdmysXoZusMs/9gzmoY1TWeb9c6zptSkY6h27EJ2yt6FPBDlzKoO3HDAWR8NfBw58d6sseWkbZvmgBB5BYRsigMQImLQPtsrNw7sS+BM+TBfR7faJI3nkvvi0lHH37fxLJIYbVnoKOkHJzs7HNrbGCh/GCrmhNDNtl1m4cUJOP+8HqmymEC2dZb+Hsg+iysLxU/lxaeBI7gajxCL/b6rAck3M21EhUvzW0cRM0WCqydtvS4L9hivEJwXm5rjTDnR/vOkiPdME+Jop4UL1VN01NQj1/fM+7ZwLdA4YbXll4WwGKXOGnUaasHwvdb2oxtSVwztVaYsblPYVcYBfe/F2J41gqoZgBsj2KbfmiphUgrYD2KH/+to6O/iYtwXRSmqkwfDySUv8FnVgzJIFCNMKipPkYWESYRGjsOWkt/m3pdV0Cdu+AOUrqwumc5z/FTYx7b6Fs2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec16c32d-3c71-45a4-11ba-08d8248c7bab
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2020 04:48:26.4303 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/SIUE/Jm/5QTVxBQU5yNfYerXqq3vIZ6sKAwoxUH/R8XzXbHcns3YY6ygKqmzLG
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

Change-Id: I2c8831b9d00618c6578ee42b34e26892c5dba515
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
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

Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EE8EC433DF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 03:30:42 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3008622B48
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 03:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="lfs3xPVV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3008622B48
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB73E6E850;
	Thu, 30 Jul 2020 03:30:41 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42D6A6E850
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 03:30:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hNUWzSgrM2TrmwtVV8dVEUCUQYmdS9L88CuoHCh+OR9HOmyjCgufDfsoP0LV4uakQXbYfFmSFNaceTJC1hd12HTjZsGD2gz6aSS3wHul2GeATkZhu7HVHmxy4tXbzxZeiht+k/zAAv+1+/tJIHPtnS2MIj4eLKdwfPQycAkSGXbDLHVfKDSuWwZgTvE1mzPZ7ImKAq8d/8grxuHIa4bF2/gVRy3UJootPmkTmJ53JKmRqgVoI0aAGvpu1wTLMOguTkzkl6RKJFk+vHDYrFmZgQY9uaqDq2nRPhWFbdxzHlFYsONBA05Q41QdqOekQeWTrSTcwAR4m/9k77rgW1PT1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NA4qJnwxjqO2+nNT+/RXNQYM6WNyRryfUPNJckimORo=;
 b=OT9H2vZkuvXr0cFzHfEELDrzrPoBE80WXpbzZeofEGfRK5iUWfwXEVyLlKMkWJVv+T2nZ52W2DfJiEA4fUdT6VBM56+QWWbtSlSrJ43JnO0BUOQhJn4HU96tZeRECP9v7u0JAh1EdxR2okXC0GSg3LKpiLmiv9GKAvVhxt4Jq99cBWFBkZw5KFepQmL7hwR2vz1wvD3uu6lEamoi8n53MFAFxooAfqr3MY0G24KWi93SEURG8GYZ1bZ41qQdDsc5VzAyGB9GR74lNHO03ludz3jEOBIekl5xf+J/bAZ2KVJCPUDS8vg0jSzqhVPuOO8+TmioLikoZPR/1Q+510ed7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NA4qJnwxjqO2+nNT+/RXNQYM6WNyRryfUPNJckimORo=;
 b=lfs3xPVVvzzqDMouc/XAPjI1wz78fOvFGSUK4PFNxivNT+0rDToyclQpj8ZwmENbJTLSZyGgrTE/geHGsu2d7+O0FZBNNN66O4bcNg/J6dT/wDVHUTNihZ4d7deZqO2nvRUcTmBbkziEzSL5lOYDOTSkoOWjQt0L8F1CMGC+te0=
Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none; lists.freedesktop.org;
 dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB2619.namprd12.prod.outlook.com (2603:10b6:5:45::18) by
 DM5PR12MB1355.namprd12.prod.outlook.com (2603:10b6:3:6e::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17; Thu, 30 Jul 2020 03:30:39 +0000
Received: from DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66]) by DM6PR12MB2619.namprd12.prod.outlook.com
 ([fe80::fcd0:74a:b9d0:6b66%2]) with mapi id 15.20.3239.018; Thu, 30 Jul 2020
 03:30:38 +0000
From: Evan Quan <evan.quan@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 8/8] drm/amd/powerplay: add Renoir support for gpu metrics
 export
Date: Thu, 30 Jul 2020 11:28:39 +0800
Message-Id: <20200730032839.2517-8-evan.quan@amd.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200730032839.2517-1-evan.quan@amd.com>
References: <20200730032839.2517-1-evan.quan@amd.com>
X-ClientProxiedBy: HK2PR02CA0176.apcprd02.prod.outlook.com
 (2603:1096:201:21::12) To DM6PR12MB2619.namprd12.prod.outlook.com
 (2603:10b6:5:45::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from equan-buildpc.amd.com (58.247.170.242) by
 HK2PR02CA0176.apcprd02.prod.outlook.com (2603:1096:201:21::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Thu, 30 Jul 2020 03:30:37 +0000
X-Mailer: git-send-email 2.28.0
X-Originating-IP: [58.247.170.242]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 8612f1e1-2832-4c2e-f882-08d83438edbb
X-MS-TrafficTypeDiagnostic: DM5PR12MB1355:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB13559438CB08E563D226543DE4710@DM5PR12MB1355.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:346;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wzR8G9A6pchA80oGAadb/pDtN52kFcSWx1TUmAu5r4rltHyTLQTj5ERE2/Mbk7573E3QcZF/u1WEFTqNOCRgYpyeRQyNZ+b/xK5pB44OAZC2g+O20c0W++/6SvVSjIZsGuycseFHWaam9/47bYBNgEYM/IEiZJGtJHhvFlbjm78dw0EDq/gJdJKZuVmb7WFlJajv1NcSebJrjWNijRRRsk0zmsWFxk0WQUxMl00/ZZFOYLR+Qee2Hxy5ELOC+JHXwkzLlx0joEqBw+MT+1WtNpUITuQ+IVFXFqA3sCLUqHXvPxJ0o2iqsx8i5G+51lr9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM6PR12MB2619.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(136003)(376002)(396003)(346002)(366004)(186003)(83380400001)(4326008)(6916009)(36756003)(2906002)(8676002)(8936002)(478600001)(66946007)(44832011)(2616005)(956004)(26005)(66476007)(66556008)(1076003)(6486002)(5660300002)(86362001)(52116002)(7696005)(16526019)(316002);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: YsnqOubx1ZyIr0QARuvjEMT/qNERm1iZMT8r8s/wk7TDHv/i4NGC0Z2hixNIsUfAcObiz/u7GzGddU1xPuGsM4PaCESUvG7COluVUQRAktN9WKulbqKp6SCKYbzmUXPodMaKffe1EN/yZ0YMbnDjbxUN0T/UYNXOWihjSBqKElIc2Tk/KhsDiAmfvf4JDQmdi4X5FVag60isB07DCyd2JkrdOLQAIiskLB3EJS6PWUJrZwOK/66TTvOvNJcmhJiuWZclGJw9ic3ui63RCQw8xQFrZAhRpSqXvOjO6sGKBvw/mnKMA0ay8rtrojPN31o9C4fY1bq2McWHfaVSoEDwR+WXgVqr6+kCKgfVtoaCVs0YC3apWpTDYMAua/fyZGEORcIQP43L8KzfvEDwua6TizXrMv9aHJ+JSxd93NYPgpk/ieJfaXRBg1ErWCx6Q9pFlef+cV7tFAIXH9ppdZae86bIHyo9zJ+dCkTVEdNWvgQJOxNDRflr/qQmSFHsaWpL9UwDCMtX1O5dgLi80nHBNnfR/m6PrLZe/TfThjoJoz7F5yU19Ylk/3SLXnuh8q1TzlXGCszGoPcoIUcquIhWW7JiXu1rLr7aoRu3nKlRYJt1x7pcZvF3EeP6wZURSG9WRZ6tQy5RdpcT2SG+Da2EWA==
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8612f1e1-2832-4c2e-f882-08d83438edbb
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB2619.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 03:30:38.8454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Dd6CoDu8fkHFqCVfaRISAfo/6Hs1Tyq4jJFwXlCRR7wmpk4X7rar5GwqLQHLmiEE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1355
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

Add Renoir gpu metrics export interface.

Change-Id: Ic83265536eeaa9e458dc395b2be18ea49da4c68a
Signed-off-by: Evan Quan <evan.quan@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h |  2 +
 drivers/gpu/drm/amd/powerplay/renoir_ppt.c    | 95 ++++++++++++++++++-
 drivers/gpu/drm/amd/powerplay/smu_v12_0.c     | 10 ++
 3 files changed, 104 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
index 02de3b6199e5..fa2e8cb07967 100644
--- a/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
+++ b/drivers/gpu/drm/amd/powerplay/inc/smu_v12_0.h
@@ -60,5 +60,7 @@ int smu_v12_0_set_soft_freq_limited_range(struct smu_context *smu, enum smu_clk_
 
 int smu_v12_0_set_driver_table_location(struct smu_context *smu);
 
+void smu_v12_0_init_gpu_metrics_v2_0(struct gpu_metrics_v2_0 *gpu_metrics);
+
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
index 575ae4be98a2..8d73781775bc 100644
--- a/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
+++ b/drivers/gpu/drm/amd/powerplay/renoir_ppt.c
@@ -166,18 +166,32 @@ static int renoir_init_smc_tables(struct smu_context *smu)
 
 	smu_table->clocks_table = kzalloc(sizeof(DpmClocks_t), GFP_KERNEL);
 	if (!smu_table->clocks_table)
-		return -ENOMEM;
+		goto err0_out;
 
 	smu_table->metrics_table = kzalloc(sizeof(SmuMetrics_t), GFP_KERNEL);
 	if (!smu_table->metrics_table)
-		return -ENOMEM;
+		goto err1_out;
 	smu_table->metrics_time = 0;
 
 	smu_table->watermarks_table = kzalloc(sizeof(Watermarks_t), GFP_KERNEL);
 	if (!smu_table->watermarks_table)
-		return -ENOMEM;
+		goto err2_out;
+
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v2_0);
+	smu_table->gpu_metrics_table = kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
+	if (!smu_table->gpu_metrics_table)
+		goto err3_out;
 
 	return 0;
+
+err3_out:
+	kfree(smu_table->watermarks_table);
+err2_out:
+	kfree(smu_table->metrics_table);
+err1_out:
+	kfree(smu_table->clocks_table);
+err0_out:
+	return -ENOMEM;
 }
 
 /**
@@ -995,6 +1009,80 @@ static bool renoir_is_dpm_running(struct smu_context *smu)
 
 }
 
+static ssize_t renoir_get_gpu_metrics(struct smu_context *smu,
+				      void **table)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct gpu_metrics_v2_0 *gpu_metrics =
+		(struct gpu_metrics_v2_0 *)smu_table->gpu_metrics_table;
+	SmuMetrics_t metrics;
+	int ret = 0;
+
+	ret = renoir_get_metrics_table(smu, &metrics);
+	if (ret)
+		return ret;
+
+	smu_v12_0_init_gpu_metrics_v2_0(gpu_metrics);
+
+	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
+	gpu_metrics->temperature_soc = metrics.SocTemperature;
+	gpu_metrics->temperature_core[0] = metrics.CoreTemperature[0];
+	gpu_metrics->temperature_core[1] = metrics.CoreTemperature[1];
+	gpu_metrics->temperature_core[2] = metrics.CoreTemperature[2];
+	gpu_metrics->temperature_core[3] = metrics.CoreTemperature[3];
+	gpu_metrics->temperature_core[4] = metrics.CoreTemperature[4];
+	gpu_metrics->temperature_core[5] = metrics.CoreTemperature[5];
+	gpu_metrics->temperature_core[6] = metrics.CoreTemperature[6];
+	gpu_metrics->temperature_core[7] = metrics.CoreTemperature[7];
+	gpu_metrics->temperature_l3[0] = metrics.L3Temperature[0];
+	gpu_metrics->temperature_l3[1] = metrics.L3Temperature[1];
+
+	gpu_metrics->average_gfx_activity = metrics.AverageGfxActivity;
+	gpu_metrics->average_mm_activity = metrics.AverageUvdActivity;
+
+	gpu_metrics->average_socket_power = metrics.CurrentSocketPower;
+	gpu_metrics->average_cpu_power = metrics.Power[0];
+	gpu_metrics->average_soc_power = metrics.Power[1];
+	gpu_metrics->average_core_power[0] = metrics.CorePower[0];
+	gpu_metrics->average_core_power[1] = metrics.CorePower[1];
+	gpu_metrics->average_core_power[2] = metrics.CorePower[2];
+	gpu_metrics->average_core_power[3] = metrics.CorePower[3];
+	gpu_metrics->average_core_power[4] = metrics.CorePower[4];
+	gpu_metrics->average_core_power[5] = metrics.CorePower[5];
+	gpu_metrics->average_core_power[6] = metrics.CorePower[6];
+	gpu_metrics->average_core_power[7] = metrics.CorePower[7];
+
+	gpu_metrics->average_gfxclk_frequency = metrics.AverageGfxclkFrequency;
+	gpu_metrics->average_socclk_frequency = metrics.AverageSocclkFrequency;
+	gpu_metrics->average_fclk_frequency = metrics.AverageFclkFrequency;
+	gpu_metrics->average_vclk_frequency = metrics.AverageVclkFrequency;
+
+	gpu_metrics->current_gfxclk = metrics.ClockFrequency[CLOCK_GFXCLK];
+	gpu_metrics->current_socclk = metrics.ClockFrequency[CLOCK_SOCCLK];
+	gpu_metrics->current_uclk = metrics.ClockFrequency[CLOCK_UMCCLK];
+	gpu_metrics->current_fclk = metrics.ClockFrequency[CLOCK_FCLK];
+	gpu_metrics->current_vclk = metrics.ClockFrequency[CLOCK_VCLK];
+	gpu_metrics->current_dclk = metrics.ClockFrequency[CLOCK_DCLK];
+	gpu_metrics->current_coreclk[0] = metrics.CoreFrequency[0];
+	gpu_metrics->current_coreclk[1] = metrics.CoreFrequency[1];
+	gpu_metrics->current_coreclk[2] = metrics.CoreFrequency[2];
+	gpu_metrics->current_coreclk[3] = metrics.CoreFrequency[3];
+	gpu_metrics->current_coreclk[4] = metrics.CoreFrequency[4];
+	gpu_metrics->current_coreclk[5] = metrics.CoreFrequency[5];
+	gpu_metrics->current_coreclk[6] = metrics.CoreFrequency[6];
+	gpu_metrics->current_coreclk[7] = metrics.CoreFrequency[7];
+	gpu_metrics->current_l3clk[0] = metrics.L3Frequency[0];
+	gpu_metrics->current_l3clk[1] = metrics.L3Frequency[1];
+
+	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
+
+	gpu_metrics->fan_pwm = metrics.FanPwm;
+
+	*table = (void *)gpu_metrics;
+
+	return sizeof(struct gpu_metrics_v2_0);
+}
+
 static const struct pptable_funcs renoir_ppt_funcs = {
 	.set_power_state = NULL,
 	.print_clk_levels = renoir_print_clk_levels,
@@ -1029,6 +1117,7 @@ static const struct pptable_funcs renoir_ppt_funcs = {
 	.is_dpm_running = renoir_is_dpm_running,
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_pp_feature_mask = smu_cmn_set_pp_feature_mask,
+	.get_gpu_metrics = renoir_get_gpu_metrics,
 };
 
 void renoir_set_ppt_funcs(struct smu_context *smu)
diff --git a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
index 31456437bb18..533b0f04c85c 100644
--- a/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
+++ b/drivers/gpu/drm/amd/powerplay/smu_v12_0.c
@@ -274,3 +274,13 @@ int smu_v12_0_set_driver_table_location(struct smu_context *smu)
 
 	return ret;
 }
+
+void smu_v12_0_init_gpu_metrics_v2_0(struct gpu_metrics_v2_0 *gpu_metrics)
+{
+	memset(gpu_metrics, 0xFF, sizeof(struct gpu_metrics_v2_0));
+
+	gpu_metrics->common_header.structure_size =
+				sizeof(struct gpu_metrics_v2_0);
+	gpu_metrics->common_header.format_revision = 2;
+	gpu_metrics->common_header.content_revision = 0;
+}
-- 
2.28.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

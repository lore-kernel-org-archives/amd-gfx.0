Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBDFBC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Feb 2022 14:49:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1550310E6EF;
	Thu, 24 Feb 2022 14:49:02 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2082.outbound.protection.outlook.com [40.107.96.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86F8489BB2
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 14:49:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KQUIf/cia0/DyjUMT6oqjkfTJRJ2sOnxcKQD04ZrE56LY8JwS3e6R8ga6NPtHCkPoGGz14lT6IM7MeCWSgiKmGHukyVfcEgTZ8MsKJX/x3hBUPG+ML6Ogv6tT33MwTyGpfYhQIwcmlhg4gXdvtibBEPFeJsnWq8SnlnyCitHXmPTKTAxnJoLlGRhDkdgJnkS3XrHg2RsOwDms4RVX3cpsh7Gskh+by1ytWak7U6tburxeKGm6Hl3HhuNgiJVTCv11KIRgGK/c14pTm0kOe+CDMVcoeBm7GSyNnn6JxEfKrfYD2ox1YAhmsifvOjxxRMv8o4pxDCuVEpDnQXllpjrXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WjElpTjQi4JYwsJat5B5jF0EmJ++rVk4NPBEmIDvlWA=;
 b=kdEP7Lxhxv1kUHRSrXw585Na1sqPdqP2GgL9tWHlcshEMXQ9sADMfvpgDHF5gqHK5ytra9hI5WDVl+rP64ULkWGcxA+/J0yeNlzEBS6nzXVJdlz4w6xl0TlsLH04cRJUZVuiNq78DBu99cbJnwqnBr9qIqTwhWex0X0v3oftleG7Q7uO0E/qSihfifjk5M5i5Xwb4JOVd2MUs3cQbD1GknwwZi1anPhcVwsGOV5xZjRzpp2I8wJa5raPHKwLkdHtaiHqGnoBooUH9JH2FQnwUIK8ZpSs3Y5OxSZOLZqanQ1asrk0297QlWV8Y4Si92Ezho5Ow3Y/TXCFv6QdWlDfIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WjElpTjQi4JYwsJat5B5jF0EmJ++rVk4NPBEmIDvlWA=;
 b=F4WbH7sYSTSNO+0IhysStR2ORwG+C5l9UcCefQwaQfFhXlBRxHFeTtn7QNCzZJO/CG2o2lF8dI98tKJVU7iX9o0p2FjGvCVf9ztnVYmteXj9ztc4MUVDsDGtsC1OdY8e0K3U0DaKdKtqxCRiUFGaiIAszNj8IgURxJDRqpZSxdE=
Received: from BN0PR04CA0028.namprd04.prod.outlook.com (2603:10b6:408:ee::33)
 by BL1PR12MB5317.namprd12.prod.outlook.com (2603:10b6:208:31f::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 24 Feb
 2022 14:48:58 +0000
Received: from BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::3f) by BN0PR04CA0028.outlook.office365.com
 (2603:10b6:408:ee::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Thu, 24 Feb 2022 14:48:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT049.mail.protection.outlook.com (10.13.177.157) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 14:48:57 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 08:48:55 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: refine smu 13.0.5 pp table code
Date: Thu, 24 Feb 2022 22:48:14 +0800
Message-ID: <20220224144814.1997116-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: acafad82-4993-4841-5c1d-08d9f7a4c993
X-MS-TrafficTypeDiagnostic: BL1PR12MB5317:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB531731044F919EA0D99096E5C13D9@BL1PR12MB5317.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xMwXIPYHkz5xBj5v+7uKD+VEEKVASg+I6LUhb2s2PSWP5PEIRKHWdhkSbZYNPJwd1n6+AvJpTF+qggtuQqJ0GzcZnGSrjxvDUD4FYC6VwHygUFzrk7iaSHn0irCdKkdaJtnjHto5dgh4gAXca/eaE2ZNGSU6/fltGiBX7Ci/rNrb+fLarClzAd91AElIBCaAR7nJVdX4OC7yulTFrAa0vswWHr4MohB99hW5x8b1xT4iGRCJhr8hUBc3nRtzhxeIfZC1lRZgGCPU/EXffN9QHd09mcpRU0cObHuhTiI9No15qLB5eDSVCaoQnQ+y94Kjo7t8zpafsuFCCY9lIpdRpTZ0wkFQ8UxGssJSSI0ia6bk4qfTMmkkl4NTi5OWS6Kcenq5JQKbRhm5oaQyqDe8Ox5nGNsCZ3i8jCGzrQlWRKpzItUxhU8kdpo9ij4lnPFEvGfApe/ph858K4FhcjJD1JCUfV47ej6yrAucFxVoqBiYNBbFujtdCJvl9sxhVzJfd4H4P41vf/0rbsK7P1Mn7F88XBZGyNJR6VrgE+5ES0b/nKfJ90uy+WWIhjzK506H+4wkKNCnTK3mkNXZFCwhtqq3MuYFXcTUOl3mV5EOJMNDRpzmTqmz3HAQA9J3b0FnRilFHSxIo38tbLYLCS+rpGPNnP71P85xeI4NiSRFzZysVoHcQgjaD8X5E8rPohWaIM7HUl8ZP+AgAFLwqJAiNg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(82310400004)(70586007)(4326008)(70206006)(5660300002)(8676002)(40460700003)(8936002)(36756003)(47076005)(36860700001)(2906002)(7696005)(426003)(83380400001)(508600001)(26005)(356005)(2616005)(86362001)(316002)(336012)(186003)(81166007)(6666004)(16526019)(54906003)(6916009)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 14:48:57.7585 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: acafad82-4993-4841-5c1d-08d9f7a4c993
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT049.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5317
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Ray.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Based on smu 13.0.5 features, refine pp table code.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  | 134 ++++--------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h  |   1 +
 2 files changed, 28 insertions(+), 107 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 8ee5bcb60370..7bfac029e513 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -57,8 +57,6 @@
 static struct cmn2asic_msg_mapping smu_v13_0_5_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			1),
 	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,		1),
-	MSG_MAP(EnableGfxOff,             PPSMC_MSG_EnableGfxOff,		1),
-	MSG_MAP(DisableGfxOff,                   PPSMC_MSG_DisableGfxOff,			1),
 	MSG_MAP(PowerDownVcn,                    PPSMC_MSG_PowerDownVcn,			1),
 	MSG_MAP(PowerUpVcn,                 PPSMC_MSG_PowerUpVcn,		1),
 	MSG_MAP(SetHardMinVcn,                   PPSMC_MSG_SetHardMinVcn,			1),
@@ -227,22 +225,6 @@ static bool smu_v13_0_5_is_dpm_running(struct smu_context *smu)
 	return !!(feature_enabled & SMC_DPM_FEATURE);
 }
 
-static int smu_v13_0_5_post_smu_init(struct smu_context *smu)
-{
-	/*
-	struct amdgpu_device *adev = smu->adev;
-	*/
-	int ret = 0;
-
-	/* allow message will be sent after enable gfxoff on smu 13.0.5 */
-	/*
-	ret = smu_cmn_send_smc_msg(smu, SMU_MSG_EnableGfxOff, NULL);
-	if (ret)
-		dev_err(adev->dev, "Failed to Enable GfxOff!\n");
-	*/
-	return ret;
-}
-
 static int smu_v13_0_5_mode_reset(struct smu_context *smu, int type)
 {
 	int ret = 0;
@@ -314,30 +296,6 @@ static int smu_v13_0_5_get_smu_metrics_data(struct smu_context *smu,
 	case METRICS_VOLTAGE_VDDSOC:
 		*value = metrics->Voltage[1];
 		break;
-#if 0
-	case METRICS_SS_APU_SHARE:
-		/* return the percentage of APU power with respect to APU's power limit.
-		 * percentage is reported, this isn't boost value. Smartshift power
-		 * boost/shift is only when the percentage is more than 100.
-		 */
-		if (metrics->StapmOpnLimit > 0)
-			*value =  (metrics->ApuPower * 100) / metrics->StapmOpnLimit;
-		else
-			*value = 0;
-		break;
-	case METRICS_SS_DGPU_SHARE:
-		/* return the percentage of dGPU power with respect to dGPU's power limit.
-		 * percentage is reported, this isn't boost value. Smartshift power
-		 * boost/shift is only when the percentage is more than 100.
-		 */
-		if ((metrics->dGpuPower > 0) &&
-		    (metrics->StapmCurrentLimit > metrics->StapmOpnLimit))
-			*value = (metrics->dGpuPower * 100) /
-				  (metrics->StapmCurrentLimit - metrics->StapmOpnLimit);
-		else
-			*value = 0;
-		break;
-#endif
 	default:
 		*value = UINT_MAX;
 		break;
@@ -503,12 +461,6 @@ static ssize_t smu_v13_0_5_get_gpu_metrics(struct smu_context *smu,
 
 	gpu_metrics->temperature_gfx = metrics.GfxTemperature;
 	gpu_metrics->temperature_soc = metrics.SocTemperature;
-	/*
-	memcpy(&gpu_metrics->temperature_core[0],
-		&metrics.CoreTemperature[0],
-		sizeof(uint16_t) * 8);
-	gpu_metrics->temperature_l3[0] = metrics.L3Temperature;
-	*/
 
 	gpu_metrics->average_gfx_activity = metrics.GfxActivity;
 	gpu_metrics->average_mm_activity = metrics.UvdActivity;
@@ -516,28 +468,13 @@ static ssize_t smu_v13_0_5_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->average_socket_power = metrics.CurrentSocketPower;
 	gpu_metrics->average_gfx_power = metrics.Power[0];
 	gpu_metrics->average_soc_power = metrics.Power[1];
-	/*
-	memcpy(&gpu_metrics->average_core_power[0],
-		&metrics.CorePower[0],
-		sizeof(uint16_t) * 8);
-	*/
-
 	gpu_metrics->average_gfxclk_frequency = metrics.GfxclkFrequency;
 	gpu_metrics->average_socclk_frequency = metrics.SocclkFrequency;
 	gpu_metrics->average_uclk_frequency = metrics.MemclkFrequency;
 	gpu_metrics->average_fclk_frequency = metrics.MemclkFrequency;
 	gpu_metrics->average_vclk_frequency = metrics.VclkFrequency;
 	gpu_metrics->average_dclk_frequency = metrics.DclkFrequency;
-
-	/*
-	memcpy(&gpu_metrics->current_coreclk[0],
-		&metrics.CoreFrequency[0],
-		sizeof(uint16_t) * 8);
-	gpu_metrics->current_l3clk[0] = metrics.L3Frequency;
-	*/
-
 	gpu_metrics->throttle_status = metrics.ThrottlerStatus;
-
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
 	*table = (void *)gpu_metrics;
@@ -652,9 +589,11 @@ static int smu_v13_0_5_get_current_clk_freq(struct smu_context *smu,
 	case SMU_MCLK:
 		member_type = METRICS_AVERAGE_UCLK;
 		break;
-	case SMU_FCLK:
+	case SMU_GFXCLK:
+	case SMU_SCLK:
 		return smu_cmn_send_smc_msg_with_param(smu,
-				SMU_MSG_GetFclkFrequency, 0, value);
+				SMU_MSG_GetGfxclkFrequency, 0, value);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -891,14 +830,6 @@ static int smu_v13_0_5_set_soft_freq_limited_range(struct smu_context *smu,
 		msg_set_min = SMU_MSG_SetHardMinGfxClk;
 		msg_set_max = SMU_MSG_SetSoftMaxGfxClk;
 		break;
-	case SMU_FCLK:
-		msg_set_min = SMU_MSG_SetHardMinFclkByFreq;
-		msg_set_max = SMU_MSG_SetSoftMaxFclkByFreq;
-		break;
-	case SMU_SOCCLK:
-		msg_set_min = SMU_MSG_SetHardMinSocclkByFreq;
-		msg_set_max = SMU_MSG_SetSoftMaxSocclkByFreq;
-		break;
 	case SMU_VCLK:
 	case SMU_DCLK:
 		msg_set_min = SMU_MSG_SetHardMinVcn;
@@ -925,6 +856,7 @@ static int smu_v13_0_5_print_clk_levels(struct smu_context *smu,
 {
 	int i, size = 0, ret = 0;
 	uint32_t cur_value = 0, value = 0, count = 0;
+	uint32_t min = 0, max = 0;
 
 	smu_cmn_get_sysfs_buf(&buf, &size);
 
@@ -945,7 +877,6 @@ static int smu_v13_0_5_print_clk_levels(struct smu_context *smu,
 	case SMU_VCLK:
 	case SMU_DCLK:
 	case SMU_MCLK:
-	case SMU_FCLK:
 		ret = smu_v13_0_5_get_current_clk_freq(smu, clk_type, &cur_value);
 		if (ret)
 			goto print_clk_out;
@@ -963,6 +894,27 @@ static int smu_v13_0_5_print_clk_levels(struct smu_context *smu,
 					cur_value == value ? "*" : "");
 		}
 		break;
+	case SMU_GFXCLK:
+	case SMU_SCLK:
+		ret = smu_v13_0_5_get_current_clk_freq(smu, clk_type, &cur_value);
+		if (ret)
+			goto print_clk_out;
+		min = (smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq;
+		max = (smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq;
+		if (cur_value  == max)
+			i = 2;
+		else if (cur_value == min)
+			i = 0;
+		else
+			i = 1;
+		size += sysfs_emit_at(buf, size, "0: %uMhz %s\n", min,
+				i == 0 ? "*" : "");
+		size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
+				i == 1 ? cur_value : SMU_13_0_5_UMD_PSTATE_GFXCLK,
+				i == 1 ? "*" : "");
+		size += sysfs_emit_at(buf, size, "2: %uMhz %s\n", max,
+				i == 2 ? "*" : "");
+		break;
 	default:
 		break;
 	}
@@ -971,6 +923,7 @@ static int smu_v13_0_5_print_clk_levels(struct smu_context *smu,
 	return size;
 }
 
+
 static int smu_v13_0_5_force_clk_levels(struct smu_context *smu,
 				enum smu_clk_type clk_type, uint32_t mask)
 {
@@ -982,8 +935,6 @@ static int smu_v13_0_5_force_clk_levels(struct smu_context *smu,
 	soft_max_level = mask ? (fls(mask) - 1) : 0;
 
 	switch (clk_type) {
-	case SMU_SOCCLK:
-	case SMU_FCLK:
 	case SMU_VCLK:
 	case SMU_DCLK:
 		ret = smu_v13_0_5_get_dpm_freq_by_index(smu, clk_type, soft_min_level, &min_freq);
@@ -1012,31 +963,19 @@ static int smu_v13_0_5_set_performance_level(struct smu_context *smu,
 {
 	struct amdgpu_device *adev = smu->adev;
 	uint32_t sclk_min = 0, sclk_max = 0;
-	uint32_t fclk_min = 0, fclk_max = 0;
-	uint32_t socclk_min = 0, socclk_max = 0;
 	int ret = 0;
 
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
 		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &sclk_max);
-		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &fclk_max);
-		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &socclk_max);
 		sclk_min = sclk_max;
-		fclk_min = fclk_max;
-		socclk_min = socclk_max;
 		break;
 	case AMD_DPM_FORCED_LEVEL_LOW:
 		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, NULL);
-		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min, NULL);
-		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, NULL);
 		sclk_max = sclk_min;
-		fclk_max = fclk_min;
-		socclk_max = socclk_min;
 		break;
 	case AMD_DPM_FORCED_LEVEL_AUTO:
 		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, &sclk_max);
-		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min, &fclk_max);
-		smu_v13_0_5_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, &socclk_max);
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
@@ -1064,24 +1003,6 @@ static int smu_v13_0_5_set_performance_level(struct smu_context *smu,
 		smu->gfx_actual_soft_max_freq = sclk_max;
 	}
 
-	if (fclk_min && fclk_max) {
-		ret = smu_v13_0_5_set_soft_freq_limited_range(smu,
-							    SMU_FCLK,
-							    fclk_min,
-							    fclk_max);
-		if (ret)
-			return ret;
-	}
-
-	if (socclk_min && socclk_max) {
-		ret = smu_v13_0_5_set_soft_freq_limited_range(smu,
-							    SMU_SOCCLK,
-							    socclk_min,
-							    socclk_max);
-		if (ret)
-			return ret;
-	}
-
 	return ret;
 }
 
@@ -1117,7 +1038,6 @@ static const struct pptable_funcs smu_v13_0_5_ppt_funcs = {
 	.get_pp_feature_mask = smu_cmn_get_pp_feature_mask,
 	.set_driver_table_location = smu_v13_0_set_driver_table_location,
 	.gfx_off_control = smu_v13_0_gfx_off_control,
-	.post_init = smu_v13_0_5_post_smu_init,
 	.mode2_reset = smu_v13_0_5_mode2_reset,
 	.get_dpm_ultimate_freq = smu_v13_0_5_get_dpm_ultimate_freq,
 	.od_edit_dpm_table = smu_v13_0_5_od_edit_dpm_table,
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h
index d2e872c93650..40bc0f8e6d61 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h
@@ -24,5 +24,6 @@
 #define __SMU_V13_0_5_PPT_H__
 
 extern void smu_v13_0_5_set_ppt_funcs(struct smu_context *smu);
+#define SMU_13_0_5_UMD_PSTATE_GFXCLK   1100
 
 #endif
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 752EAC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Feb 2022 11:31:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 02E2310FB0D;
	Thu, 24 Feb 2022 11:31:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2088.outbound.protection.outlook.com [40.107.94.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 331B710FB0C
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 11:31:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A/5UdBORe2cwIzJ6L6noeTgDH3oso2PaHxodbL7VId+Kky1zWrcoAbK54zhzBB2VnTUCYBYoITyDvu9UhMl2Mf+XnK2txgC9ZRX2fVYfm6eazZekZzchblxcE8HkEy/5sMVSIpYuAYO5FhPHaeCfDN5X9BjdqHAI1eQTGhx18b/qiuM2cOjSBGyn6gKxwUilzVZVYbi4WzvEeUcYlls0t7g1HAOKO3Gz7kUjSn6UikjZQ3c55Y220fW7G3XysFljqEwle+No+kfqBgxoZNSv8g9Q9OkohlmgWgi9BVi+GjUsLjEztIpOgBW0A+CyagGWnEfkvE5Rvf25CYWGXL7elg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6wal69PAdKeudadcYEzcurEVh7F7dP4tjd6TtPahTyU=;
 b=aU+oTZKDk7D7k2mzas5/ZmSJkzQTEH3uOzsFB724LlNwhJWbsu7UqqpP3Y6rDl0WcdCpiYdH0QzAqVPWWysn4FxbIGncTRHNqH9o4vaq3mUFA8lr/ljrLuOplDvNi656Y1uel//209XzL8E68i4B8WVMpWceCaCj+kySxH+TGR0TDPZ+S9h9fmpxszSbZpCO/+X/zXQk9x1CW8FH9Wg2dtF2HmK/ntGEj2E9R/p8rsvNjjZ5Y2bOKNNmBR0tBVwfQowBKDWQVO0q7WfU07a2RcsF5cakc2VqM5IstDtIeMC+oDUMpTdr7hW/9X/w74fSRt0O6KUKPgc1MCZfUiytZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6wal69PAdKeudadcYEzcurEVh7F7dP4tjd6TtPahTyU=;
 b=yPiEqYfkTkCE5PjxOxlpKtg6FG0mQ6z0KR/+222T5WCvv2ZHkBYl4zpZAgYGI0V4PaCzKG7TU8+HfbhBPu3165ZlTIaoncnAnQU+UfHrIHtroFhqVIMycFkjTtORMAuo/bdJ2pZBrcu9F7bTcvmP/bjjHT9YX211Q2MBVsUkR9Y=
Received: from DM5PR10CA0007.namprd10.prod.outlook.com (2603:10b6:4:2::17) by
 DM6PR12MB4547.namprd12.prod.outlook.com (2603:10b6:5:2a9::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.22; Thu, 24 Feb 2022 11:30:55 +0000
Received: from DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:2:cafe::5a) by DM5PR10CA0007.outlook.office365.com
 (2603:10b6:4:2::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.23 via Frontend
 Transport; Thu, 24 Feb 2022 11:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT012.mail.protection.outlook.com (10.13.173.109) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 11:30:55 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 05:30:53 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/2] drm/amd/pm: refine smu 13.0.5 pp table code
Date: Thu, 24 Feb 2022 19:30:19 +0800
Message-ID: <20220224113019.1917098-2-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224113019.1917098-1-yifan1.zhang@amd.com>
References: <20220224113019.1917098-1-yifan1.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bed5b48-24c4-43c8-5a2f-08d9f7891f2a
X-MS-TrafficTypeDiagnostic: DM6PR12MB4547:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB4547EC6898ACE272DF207DE9C13D9@DM6PR12MB4547.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XoZIasWKwWSbIGttz5rKB1WqQ1V8M/8Q9IW2NeeLRpP/8rwSZ/kjRZuGai/+1mjpVSGoDEp5jFfERGtS71UyEgbhnZotNqsR74xklPvoAFtHkWRfbbMoDJGM1oShQHPZGFKBevDsqAC0UJWlc+LCMtFpU1/gLrBPwDCsJJsZtNxopg/KT2MBTXDAiERcO2WJqYiSgMIc05tt2zOxCv17vxFcuJjW2GlZF8oaFZGjEBxY7aOg3OGQKANFPp5gwCwpp4Fn6E5UQqNZrYlh8YDCbz/GgdYRZ3qsom6UpmIVE4imov1v19lvCghA5uAuU2U2ravJJqzGbUIKxUd4nFlnNYdx3rxA2t77IPyd2OvkVfSPcRNSuMgHQJfaL5ZcbcCiZcQ7omdLqtPXniQtmwPTHRN2P3U2+l58cskXqF1hSrg/z8caWZwyDfTvvn1Fpzx44neGGDkd2G2fFD089ELshzsfbwMPY52L/IXvcUb8l9/CNVIjSWBQq2SlLPUkDpREIy8TQsSLWb0LZGN80QYpvOC04JYWnpQbT3h3Mk7mJOo3Ra4UWqZIXmmZO9ALWLUASK2YL60pXfLfESJSMPNuy9P7HCRUmJPl1EMjtTXhLTeHCvN7LGf/NXGs/wuZ6VfYea5MtnJZz1TLaBaJfo/drb5Wss2YbTX4JTLwmuVXrBpt68xgrKifz+AqEQmBI/Gg+tX5o1Ku8ClBl5yo3Km6qw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(336012)(1076003)(6916009)(2616005)(26005)(6666004)(426003)(316002)(47076005)(7696005)(54906003)(83380400001)(82310400004)(86362001)(36860700001)(508600001)(186003)(70586007)(16526019)(2906002)(356005)(8936002)(36756003)(40460700003)(81166007)(8676002)(5660300002)(70206006)(4326008)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 11:30:55.3991 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bed5b48-24c4-43c8-5a2f-08d9f7891f2a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT012.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4547
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
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  | 131 ++++--------------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.h  |   1 +
 2 files changed, 27 insertions(+), 105 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 0bc15ff822a5..f938eb1809cc 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -225,22 +225,6 @@ static bool smu_v13_0_5_is_dpm_running(struct smu_context *smu)
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
@@ -312,30 +296,6 @@ static int smu_v13_0_5_get_smu_metrics_data(struct smu_context *smu,
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
@@ -501,12 +461,6 @@ static ssize_t smu_v13_0_5_get_gpu_metrics(struct smu_context *smu,
 
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
@@ -514,28 +468,13 @@ static ssize_t smu_v13_0_5_get_gpu_metrics(struct smu_context *smu,
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
@@ -650,9 +589,11 @@ static int smu_v13_0_5_get_current_clk_freq(struct smu_context *smu,
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
@@ -889,14 +830,6 @@ static int smu_v13_0_5_set_soft_freq_limited_range(struct smu_context *smu,
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
@@ -943,7 +876,6 @@ static int smu_v13_0_5_print_clk_levels(struct smu_context *smu,
 	case SMU_VCLK:
 	case SMU_DCLK:
 	case SMU_MCLK:
-	case SMU_FCLK:
 		ret = smu_v13_0_5_get_current_clk_freq(smu, clk_type, &cur_value);
 		if (ret)
 			goto print_clk_out;
@@ -961,6 +893,27 @@ static int smu_v13_0_5_print_clk_levels(struct smu_context *smu,
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
@@ -969,6 +922,7 @@ static int smu_v13_0_5_print_clk_levels(struct smu_context *smu,
 	return size;
 }
 
+
 static int smu_v13_0_5_force_clk_levels(struct smu_context *smu,
 				enum smu_clk_type clk_type, uint32_t mask)
 {
@@ -980,8 +934,6 @@ static int smu_v13_0_5_force_clk_levels(struct smu_context *smu,
 	soft_max_level = mask ? (fls(mask) - 1) : 0;
 
 	switch (clk_type) {
-	case SMU_SOCCLK:
-	case SMU_FCLK:
 	case SMU_VCLK:
 	case SMU_DCLK:
 		ret = smu_v13_0_5_get_dpm_freq_by_index(smu, clk_type, soft_min_level, &min_freq);
@@ -1010,31 +962,19 @@ static int smu_v13_0_5_set_performance_level(struct smu_context *smu,
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
@@ -1062,24 +1002,6 @@ static int smu_v13_0_5_set_performance_level(struct smu_context *smu,
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
 
@@ -1115,7 +1037,6 @@ static const struct pptable_funcs smu_v13_0_5_ppt_funcs = {
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


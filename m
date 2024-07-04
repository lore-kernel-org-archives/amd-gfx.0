Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A83CC2BD09
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jul 2024 00:17:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A85010E21F;
	Thu,  4 Jul 2024 00:17:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="I89nDa8c";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062.outbound.protection.outlook.com [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2393E10E1C1
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jul 2024 00:17:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ejVxKkn/jJC97oTsoJJtE1Z/U62j4pFl3GbvgrOd1kPNzCA3OB87lOzfi9ZFm18dO1IW4pP9VZigFtp8xwQ13kBrT+HlI0pZyyRX0KqeAAaBNaDKbJIJc8iiqb+g95GebsQPUnnxw4HKoVC+OiqzhjkRS9k81/nrLsLkRQDpRb0dFscmjIxfQo1xtpwL3yx+D29tkCzi0GQ8oxtbtiHykM+h22IL5eSJ6w/bCrIzVde35y/1pwTZOms+BlmPhZWHA+ofpYsRQ3IjEkuhwc5fMbpFjjubtI5sy5o7RKoJ7o7Q0GDgO7Y5Fc/6dYq3pKg5+sOBYJKFi3y0tzD2vPkOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egxSIOstL/Q/8ueR8G4WLCSF/VDtRIU8ddG6PWxWwvg=;
 b=UX8TdMYBJyjPwOGNLOXDKePFBWlWjM6Ir2M9dqPIvV6SuOWQOi+/SnacMnPZ4qWm8JhcRMhUW6mEE27Oo6cy8jApaeu93+ttUsYPA0XAdaZeU9TG6ga9tLbD8h7n2wpKkkh7myD/U29H46JQLmGY7+UViUAJcNfDbiXnMDNMVOmIwXIhWpQmOP0aJn6nCt0CRjgXl5Hu9xgkzrmuslZ6cZiNhL/LAno0//ZyWa6vECE2eg3kBDpMa3+Ggcq8uviYrml6GZRTp1HL7oAVu+ayNS48IRlEsOPIzuw9xunE5Iy4qWuJX/pnGZc1xxsUYhNtME9JGEpl0J/Ifhc3kv0/Dg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egxSIOstL/Q/8ueR8G4WLCSF/VDtRIU8ddG6PWxWwvg=;
 b=I89nDa8c0VOVymnLsHOJ8b4obm8AADUlR1y5yy1hZJeiS5HQ9kTohyVvHEcjUzz2vwVAsZFF+lHrJ/vh8eqOSkEeqmw+9W9gdumIAUDMRH9p/xrhxQB0Kl2Sut/3pmFlzBuPlqs5gVwNmrSNWv4wB1Aoc+mfeFHqOsuO3lVLAcw=
Received: from CH2PR12CA0015.namprd12.prod.outlook.com (2603:10b6:610:57::25)
 by SA0PR12MB4430.namprd12.prod.outlook.com (2603:10b6:806:70::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26; Thu, 4 Jul
 2024 00:17:12 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:57:cafe::7c) by CH2PR12CA0015.outlook.office365.com
 (2603:10b6:610:57::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Thu, 4 Jul 2024 00:17:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Thu, 4 Jul 2024 00:17:11 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 19:17:11 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 3 Jul
 2024 19:17:10 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Wed, 3 Jul 2024 19:17:10 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] amdgpu/pm: support gpu_metrics sysfs interface for smu
 v14.0.2/3
Date: Thu, 4 Jul 2024 08:16:59 +0800
Message-ID: <20240704001659.36563-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|SA0PR12MB4430:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e1ba0d4-4505-48d5-8a81-08dc9bbea689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nOFyor2LaBtqyksJhgPVNiHB6PTpVIZLMzU9g5x+78VXKUIf1dWkyV1QgYYC?=
 =?us-ascii?Q?jNy/CmLMshYNRjCy5ATGcjBXVZMRHtvzFRFD6bQzgqi9EW9+lGPfrzUr5rul?=
 =?us-ascii?Q?xewPvcW0/R34sWTFgHTitzqkvTCBIvI+tjHNLPTC/wR6SxUKOWPRhD4VErRK?=
 =?us-ascii?Q?QsibGQKAe9+tRmqIl/+ldr1uD4DGhMBhiEo4JkGphQ/EX3rUTfvoMVhPpNJX?=
 =?us-ascii?Q?riMbrUEaXNrEEFlnH5qjzkG1bJvFJS0wOfgFBw4IBDlaRfoT1mB8Ghof6MTu?=
 =?us-ascii?Q?lFpOBeTm4Q/oCTeEhsMZOk+UWZK8UWzj7vreOL6SySmyS99OcrK6EDCnYRso?=
 =?us-ascii?Q?ylJk9W9xenXIAeCpUk/+/5IMeV0BBHuculauL+dxBRud301RDQ89yGu2LE5N?=
 =?us-ascii?Q?rAff011n69PmAGJvHeElWjTsFaMIprm0fIr5cENvEIzw7k5RvqkmYS9hWS1d?=
 =?us-ascii?Q?VeP1tMkNIT2TeFXxrxDzuK3PqJFUlurIV+GjHfbsqT3+z7I40lF0vyBR3zHn?=
 =?us-ascii?Q?6uaWsnaG4gWiFPfOZk8uHt4/ykakocbxAlbBJUan3ix130tews+VROoRsAfF?=
 =?us-ascii?Q?H+wbw7QuhG04ZQmKbfItG2U8QQoSyXOgrTWT8i3TAMZGhp56K1ppHX5XC+yI?=
 =?us-ascii?Q?+9pvbhWFzy3XtiCZNwotEbxBeiBagzfTUwRjN3ogXeGj4o82o/y9xJ9MoGCf?=
 =?us-ascii?Q?KPaXf7YY0Kp30aeAbeobh24qeZtVAN89r4QCsXqAeTxuHf+zSpMiFN7RQA7c?=
 =?us-ascii?Q?BmsMdmMGS2I5Hu+yvrlik1P+SOdxH3iKeLUHc5rPrkH1Ph/98LzgEhbBFs5s?=
 =?us-ascii?Q?5IhV2dzDWS8p0XaojZnN21p8S/xAlsmQht7ZY9G8cVGJKlQXMYBEwMg1UZzv?=
 =?us-ascii?Q?RTuiFYtruKIiUIH+7s6aLp1p636wmwHaxFkHyoPRGw5ssTtFkdrjZ8ylSQ0Y?=
 =?us-ascii?Q?/ngHdNPiQGHxMzFvMwDHl8rRS9WpbfHHK3aWTlWZYv3wXFDuF8TVfoVeRzJz?=
 =?us-ascii?Q?vMW3DB1zh30+3vEplMdICIVpMsFjmbSRuKsmSUQBAKKswQjQELp1SbFbtTIK?=
 =?us-ascii?Q?bwQhdcZanZyltAtfavfcR6G83VzRDDCAY3fuVyeqBiRC1UFCO9bcbLgMKB5k?=
 =?us-ascii?Q?fEEZM/hBtyK84WKWzOhTG2AEovX/ExwoQnai+SuzaEF3o40KizTyEu+qivGI?=
 =?us-ascii?Q?W0RKg3XYd0Hso26g517ksU23kdFOR3pVyTV0NWbYaJQqGRNnjAtImmwrA5j9?=
 =?us-ascii?Q?lEobYFGKW/2MhISvXvn0GJy+LQzk7edzLEJyx/3cs0puIp9WuNy4+S29hwkn?=
 =?us-ascii?Q?iB9fUgQNjruqGqVomD27ItkjGg6L54iYv7rjnV4dMub6LZ7ihtPbpXIx5jED?=
 =?us-ascii?Q?RySa7NyecNzxuEWll3PWujuugFv8SYtF6uNeCWVARMLhgAUuzGsx6HmHFJDa?=
 =?us-ascii?Q?MvW3QZITgGrus/MF86E+fir6ZGJPULBu?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 00:17:11.9109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1ba0d4-4505-48d5-8a81-08dc9bbea689
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4430
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

support gpu_metrics sysfs interface for smu v14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 86 ++++++++++++++++++-
 1 file changed, 84 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index 98ea58d792ca..e1a27903c80a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -66,6 +66,7 @@
 
 #define MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE	0x4000
 #define DEBUGSMC_MSG_Mode1Reset        2
+#define LINK_SPEED_MAX					3
 
 static struct cmn2asic_msg_mapping smu_v14_0_2_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
@@ -221,7 +222,6 @@ static struct cmn2asic_mapping smu_v14_0_2_workload_map[PP_SMC_POWER_PROFILE_COU
 	WORKLOAD_MAP(PP_SMC_POWER_PROFILE_WINDOW3D,		WORKLOAD_PPLIB_WINDOW_3D_BIT),
 };
 
-#if 0
 static const uint8_t smu_v14_0_2_throttler_map[] = {
 	[THROTTLER_PPT0_BIT]		= (SMU_THROTTLER_PPT0_BIT),
 	[THROTTLER_PPT1_BIT]		= (SMU_THROTTLER_PPT1_BIT),
@@ -241,7 +241,6 @@ static const uint8_t smu_v14_0_2_throttler_map[] = {
 	[THROTTLER_GFX_APCC_PLUS_BIT]	= (SMU_THROTTLER_APCC_BIT),
 	[THROTTLER_FIT_BIT]		= (SMU_THROTTLER_FIT_BIT),
 };
-#endif
 
 static int
 smu_v14_0_2_get_allowed_feature_mask(struct smu_context *smu,
@@ -1869,6 +1868,88 @@ static ssize_t smu_v14_0_2_get_ecc_info(struct smu_context *smu,
 	return ret;
 }
 
+static ssize_t smu_v14_0_2_get_gpu_metrics(struct smu_context *smu,
+					   void **table)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct gpu_metrics_v1_3 *gpu_metrics =
+		(struct gpu_metrics_v1_3 *)smu_table->gpu_metrics_table;
+	SmuMetricsExternal_t metrics_ext;
+	SmuMetrics_t *metrics = &metrics_ext.SmuMetrics;
+	int ret = 0;
+
+	ret = smu_cmn_get_metrics_table(smu,
+					&metrics_ext,
+					true);
+	if (ret)
+		return ret;
+
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 3);
+
+	gpu_metrics->temperature_edge = metrics->AvgTemperature[TEMP_EDGE];
+	gpu_metrics->temperature_hotspot = metrics->AvgTemperature[TEMP_HOTSPOT];
+	gpu_metrics->temperature_mem = metrics->AvgTemperature[TEMP_MEM];
+	gpu_metrics->temperature_vrgfx = metrics->AvgTemperature[TEMP_VR_GFX];
+	gpu_metrics->temperature_vrsoc = metrics->AvgTemperature[TEMP_VR_SOC];
+	gpu_metrics->temperature_vrmem = max(metrics->AvgTemperature[TEMP_VR_MEM0],
+					     metrics->AvgTemperature[TEMP_VR_MEM1]);
+
+	gpu_metrics->average_gfx_activity = metrics->AverageGfxActivity;
+	gpu_metrics->average_umc_activity = metrics->AverageUclkActivity;
+	gpu_metrics->average_mm_activity = max(metrics->Vcn0ActivityPercentage,
+					       metrics->Vcn1ActivityPercentage);
+
+	gpu_metrics->average_socket_power = metrics->AverageSocketPower;
+	gpu_metrics->energy_accumulator = metrics->EnergyAccumulator;
+
+	if (metrics->AverageGfxActivity <= SMU_14_0_2_BUSY_THRESHOLD)
+		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPostDs;
+	else
+		gpu_metrics->average_gfxclk_frequency = metrics->AverageGfxclkFrequencyPreDs;
+
+	if (metrics->AverageUclkActivity <= SMU_14_0_2_BUSY_THRESHOLD)
+		gpu_metrics->average_uclk_frequency = metrics->AverageMemclkFrequencyPostDs;
+	else
+		gpu_metrics->average_uclk_frequency = metrics->AverageMemclkFrequencyPreDs;
+
+	gpu_metrics->average_vclk0_frequency = metrics->AverageVclk0Frequency;
+	gpu_metrics->average_dclk0_frequency = metrics->AverageDclk0Frequency;
+	gpu_metrics->average_vclk1_frequency = metrics->AverageVclk1Frequency;
+	gpu_metrics->average_dclk1_frequency = metrics->AverageDclk1Frequency;
+
+	gpu_metrics->current_gfxclk = gpu_metrics->average_gfxclk_frequency;
+	gpu_metrics->current_socclk = metrics->CurrClock[PPCLK_SOCCLK];
+	gpu_metrics->current_uclk = metrics->CurrClock[PPCLK_UCLK];
+	gpu_metrics->current_vclk0 = metrics->CurrClock[PPCLK_VCLK_0];
+	gpu_metrics->current_dclk0 = metrics->CurrClock[PPCLK_DCLK_0];
+	gpu_metrics->current_vclk1 = metrics->CurrClock[PPCLK_VCLK_0];
+	gpu_metrics->current_dclk1 = metrics->CurrClock[PPCLK_DCLK_0];
+
+	gpu_metrics->throttle_status =
+			smu_v14_0_2_get_throttler_status(metrics);
+	gpu_metrics->indep_throttle_status =
+			smu_cmn_get_indep_throttler_status(gpu_metrics->throttle_status,
+							   smu_v14_0_2_throttler_map);
+
+	gpu_metrics->current_fan_speed = metrics->AvgFanRpm;
+
+	gpu_metrics->pcie_link_width = metrics->PcieWidth;
+	if ((metrics->PcieRate - 1) > LINK_SPEED_MAX)
+		gpu_metrics->pcie_link_speed = pcie_gen_to_speed(1);
+	else
+		gpu_metrics->pcie_link_speed = pcie_gen_to_speed(metrics->PcieRate);
+
+	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
+
+	gpu_metrics->voltage_gfx = metrics->AvgVoltage[SVI_PLANE_VDD_GFX];
+	gpu_metrics->voltage_soc = metrics->AvgVoltage[SVI_PLANE_VDD_SOC];
+	gpu_metrics->voltage_mem = metrics->AvgVoltage[SVI_PLANE_VDDIO_MEM];
+
+	*table = (void *)gpu_metrics;
+
+	return sizeof(struct gpu_metrics_v1_3);
+}
+
 static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
 	.get_allowed_feature_mask = smu_v14_0_2_get_allowed_feature_mask,
 	.set_default_dpm_table = smu_v14_0_2_set_default_dpm_table,
@@ -1905,6 +1986,7 @@ static const struct pptable_funcs smu_v14_0_2_ppt_funcs = {
 	.enable_thermal_alert = smu_v14_0_enable_thermal_alert,
 	.disable_thermal_alert = smu_v14_0_disable_thermal_alert,
 	.notify_memory_pool_location = smu_v14_0_notify_memory_pool_location,
+	.get_gpu_metrics = smu_v14_0_2_get_gpu_metrics,
 	.set_soft_freq_limited_range = smu_v14_0_set_soft_freq_limited_range,
 	.init_pptable_microcode = smu_v14_0_init_pptable_microcode,
 	.populate_umd_state_clk = smu_v14_0_2_populate_umd_state_clk,
-- 
2.34.1


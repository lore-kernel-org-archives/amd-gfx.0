Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 045FECA0EE0
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 23:28:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C40510E7E4;
	Wed, 13 Aug 2025 23:28:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="qvG1L9Pz";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B55810E7E6
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 23:27:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q0D+zUxLiO8VaF6NcrsBMo/rg/MxacUe5LwoQpJQl2CqakZoePm8nNLFgIkF9Z5M8jl/5RD2eRtkPaDj47sW59mkPVSIvqvCG0vHt5zReeCelWLL+SOqsFUfSwtbllkYYoWGD/PJdVDJb1VxINSbflzxAu98oc4+M6CtlxnQ/bw0uHFqFUX0rIM55avgQJq4hN67VBKRq9eCM+OMaDejr6FHpLSVTbKDUCDF7bx82fQSANnT9vBX/j1TxxX5lj519Y3q3bs2uNhufhWHYIckX6NxUPCwl43nog1stgC8IN4weQdKmWCs9GqMKnqi7JMZ/FT7bVgXcH1P6nSX5Fex2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DBHq3o5+rfHqW3Dwz3G5Aefup6oME1cWxRPfRYjZ2WQ=;
 b=Ms+dn9mxjLntqU+p133TEZ2OhwBuO+fgKk1CGg4DHEp9ApzUbTwHE4XqX2bbKug23nlizAlrbzGHGzDcZrfK10c6hR9fTYUjVrIYSAKyoB336HrMbaS/+EUZEXbhYlfEWNsSNslRDiOvtgHAsEyP8lpT5H4eL9wDkhDPMHfpFWv5FytxxGxSKuKck9Tk1wIT8hUMBjm/7se9S+CE4aPrDT8vDHgLxa5gKkny1SN65LOyra2Sduq36xP3qijgl1GcpqHyCwe9nIhnVzcgOBQ1H5HziB1RxXlFsC2kc0vCVZOABM3wThtKN8Oi4VAoPmM2vnXq13lYPsaMqC37xWuGSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DBHq3o5+rfHqW3Dwz3G5Aefup6oME1cWxRPfRYjZ2WQ=;
 b=qvG1L9Pzcz5xdU20ZAZldWfrR7HoxyPuWURyqDPdbMLJLd+LMmLPkgGhslvVlu6YVCPHjnc0ASYHJlplKSNNs4xGDUm3EHbzYWXeKjc2DU1TbAIm5AEost/tELLsyjnx0Hjr4k5LcuFAzCASwxqrvaMpd82xjlHu7EOsRbtyZVY=
Received: from DM6PR01CA0025.prod.exchangelabs.com (2603:10b6:5:296::30) by
 IA1PR12MB7661.namprd12.prod.outlook.com (2603:10b6:208:426::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.24; Wed, 13 Aug
 2025 23:27:55 +0000
Received: from DS1PEPF00017095.namprd03.prod.outlook.com
 (2603:10b6:5:296:cafe::80) by DM6PR01CA0025.outlook.office365.com
 (2603:10b6:5:296::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.16 via Frontend Transport; Wed,
 13 Aug 2025 23:29:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017095.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 23:27:54 +0000
Received: from SATLEXMB03.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 18:27:52 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 06/11] drm/amd/display: Setup Second Stutter Watermark
 Implementation
Date: Wed, 13 Aug 2025 17:18:14 -0600
Message-ID: <20250813232532.2661638-7-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250813232532.2661638-1-alex.hung@amd.com>
References: <20250813232532.2661638-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017095:EE_|IA1PR12MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: a749916e-abf2-4beb-e73b-08dddac107b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZpFcByOL6f0bvNLfL786r9N+9aaoY0hZo5DlEnxsGVEzAYIWSs9h9oxc3xBl?=
 =?us-ascii?Q?3jFRFsezmkJUKwV4q5uWKe03N67+eJblpvvxpsaDaXlL71Y34PEcxl3iwKqg?=
 =?us-ascii?Q?oc5KtFz6nH366g8mFFAGxQp7/ryV1zG+UB3avQd7My8jswxTbkhjWuuZvq5m?=
 =?us-ascii?Q?8BuWgJsONOn8Hgw8w1djf+a/e9AvGcS48UbIPhvLuc2ulNql8tCCuXQudmNI?=
 =?us-ascii?Q?nTUH03TYPhdjhRp7KlrAfagMsZ5uciPB7yJTuN4U37/WOVw6gMIrvkb4+j41?=
 =?us-ascii?Q?WWC5ziOXkCOqHokWn3EgyH7TuJbk1yV8KEPahKDgFb66kAbr5Sfl0KeALbDU?=
 =?us-ascii?Q?E0WTs2fv26TyE0z1cv9R+t/E2A39/SSQucl42JpcE/2N1r5XxIQ8fkAfNPbW?=
 =?us-ascii?Q?FmKMvDGjFGesyj1vVB3HuZZ7e5AASX+9koPhrIzMMdLLiwRxi9wj3TIeQjSy?=
 =?us-ascii?Q?gahQtNFjqpO5/C0fRmP+OK9PT03dUDf90iwa1vtWBdPFnFChxFflq8dwW2OF?=
 =?us-ascii?Q?9Pjfc26zjl7t3Bdp9DPRMaov7Yr+VXGqsUA/G/5FQUOLyKCAYNfO8WgqKIKm?=
 =?us-ascii?Q?UI8nmM/um/tc9q97ZPB/UO+ipS3qiPiRXyVkQugPQZQagFffFiWdJPSz1euo?=
 =?us-ascii?Q?/CiK0Lu2x8SdjZVy5vz4QRNXmuqBXAatxqXy/JjjQfWMzuOrhRFwbSd9w3wc?=
 =?us-ascii?Q?rMtkQAys5GVgfDLCCxLlivrtWRQY+pp+e5iukj4J2a9lbOXh5WKLKGba86Y2?=
 =?us-ascii?Q?fFqImVMluVHr1at/KafTIeQrMZEFvKWKfm2R7Gqu6JBAQ7+NP7Nlee+eJirL?=
 =?us-ascii?Q?in4uSr55TWD5LgLcpQO+zIyodblxuVwqAvJztWE6i2YrrzoJ9rLtBs3tpNar?=
 =?us-ascii?Q?5UmahxmSbu4/VCFbOr3ixiWuMc5PaO1/dFlDJDixT/n24Acyi5hOHLRNAtGj?=
 =?us-ascii?Q?/YK2j111LMQuRRDaO1k19ASZioVi30ckBc+DqYhFH5hCd6NbDp8bwM2tvwJO?=
 =?us-ascii?Q?zqBZM1X6qCE0PSquu0LhFpmxQ+J+xjknBsiYgcefvuvpdVGYeXNKrTL7sw9O?=
 =?us-ascii?Q?xDxrGprNsN23vjT2VqRQLkr7GniWCLf0KchHzWZMYnyfhAg9nhZGN482FCgP?=
 =?us-ascii?Q?RF2edlZ3XPHFoUvtwkGXFt9qSYdG44Q662q5yumiVRHbUhZCN48sceJ6PTse?=
 =?us-ascii?Q?HQnYBfpPsTucfVowGL8dCm08BERjHsivh0Jy0/fhEd2v/OF2RxeOJMI9ZZOm?=
 =?us-ascii?Q?UUQGJxiHmMzpgDG5ly8bSWscfvbhFl09ZACdrvPeABAtLBOypp3kTOggTI7T?=
 =?us-ascii?Q?sD9FmuFYcby9VkAcBm61/i7A5wpUs0Xlo9vYe11PsALnr569VbrwbUjrB1M2?=
 =?us-ascii?Q?eEDHKOhhKv6yRJRSk9i9itAzDvXh9rrtnSe6yCROBzJT+CjR9DEk6GoWDQPn?=
 =?us-ascii?Q?ikBwXlHY+BypmREFlW88r14JceB4ACed51yQ9G8A4xPe3Ab2swQkp5FIddLZ?=
 =?us-ascii?Q?lxbd9AB0S+/wLBDzShoiZ2arrT3TgT+nww/v?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 23:27:54.8623 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a749916e-abf2-4beb-e73b-08dddac107b6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017095.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7661
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

From: Austin Zheng <Austin.Zheng@amd.com>

[WHY & HOW]
Setup initial changes required to program another set of watermarks
for a 2nd stutter mode. The 2nd stutter mode will be lower power but
have higher enter/exit latencies.

PMFW to choose which stutter mode to use based on stutter efficiences
to see if original stutter (LP1) or low power stutter (LP2) will result
in better power savings.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h                  |  9 +++++++++
 .../display/dc/dml2/dml21/dml21_translation_helper.c |  2 ++
 .../dc/dml2/dml21/inc/dml_top_dchub_registers.h      |  2 ++
 .../dc/dml2/dml21/inc/dml_top_soc_parameter_types.h  |  2 ++
 .../amd/display/dc/dml2/dml21/inc/dml_top_types.h    |  2 ++
 .../dml21/src/dml2_core/dml2_core_shared_types.h     | 12 ++++++++++++
 6 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1ab05eabbddb..29aaa38cc784 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -694,6 +694,15 @@ struct dc_clocks {
 	int idle_fclk_khz;
 	int subvp_prefetch_dramclk_khz;
 	int subvp_prefetch_fclk_khz;
+
+	/* Stutter efficiency is technically not clock values
+	 * but stored here so the values are part of the update_clocks call similar to num_ways
+	 * Efficiencies are stored as percentage (0-100)
+	 */
+	struct {
+		uint8_t base_efficiency; //LP1
+		uint8_t low_power_efficiency; //LP2
+	} stutter_efficiency;
 };
 
 struct dc_bw_validation_profile {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
index a06217a9eef6..23fdb17f851a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/dml21_translation_helper.c
@@ -1165,6 +1165,8 @@ void dml21_copy_clocks_to_dc_state(struct dml2_context *in_ctx, struct dc_state
 	context->bw_ctx.bw.dcn.clk.socclk_khz = in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.socclk_khz;
 	context->bw_ctx.bw.dcn.clk.subvp_prefetch_dramclk_khz = in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.svp_prefetch_no_throttle.uclk_khz;
 	context->bw_ctx.bw.dcn.clk.subvp_prefetch_fclk_khz = in_ctx->v21.mode_programming.programming->min_clocks.dcn4x.svp_prefetch_no_throttle.fclk_khz;
+	context->bw_ctx.bw.dcn.clk.stutter_efficiency.base_efficiency = in_ctx->v21.mode_programming.programming->stutter.base_percent_efficiency;
+	context->bw_ctx.bw.dcn.clk.stutter_efficiency.low_power_efficiency = in_ctx->v21.mode_programming.programming->stutter.low_power_percent_efficiency;
 }
 
 static struct dml2_dchub_watermark_regs *wm_set_index_to_dc_wm_set(union dcn_watermark_set *watermarks, const enum dml2_dchub_watermark_reg_set_index wm_index)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_dchub_registers.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_dchub_registers.h
index b05030926ce8..91955bbe24b8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_dchub_registers.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_dchub_registers.h
@@ -159,6 +159,8 @@ struct dml2_dchub_watermark_regs {
 	uint32_t sr_exit;
 	uint32_t sr_enter_z8;
 	uint32_t sr_exit_z8;
+	uint32_t sr_enter_low_power;
+	uint32_t sr_exit_low_power;
 	uint32_t uclk_pstate;
 	uint32_t fclk_pstate;
 	uint32_t temp_read_or_ppt;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_soc_parameter_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_soc_parameter_types.h
index 8c9f414aa6bf..176f55947664 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_soc_parameter_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_soc_parameter_types.h
@@ -96,6 +96,8 @@ struct dml2_soc_power_management_parameters {
 	double g7_temperature_read_blackout_us;
 	double stutter_enter_plus_exit_latency_us;
 	double stutter_exit_latency_us;
+	double low_power_stutter_enter_plus_exit_latency_us;
+	double low_power_stutter_exit_latency_us;
 	double z8_stutter_enter_plus_exit_latency_us;
 	double z8_stutter_exit_latency_us;
 	double z8_min_idle_time;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
index 98c0234e2f47..7de10a95cfdb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/inc/dml_top_types.h
@@ -417,6 +417,8 @@ struct dml2_display_cfg_programming {
 
 	struct {
 		bool supported_in_blank; // Changing to configurations where this is false requires stutter to be disabled during the transition
+		uint8_t base_percent_efficiency; //LP1
+		uint8_t low_power_percent_efficiency; //LP2
 	} stutter;
 
 	struct {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
index 28687565ac22..ffb8c09f37a5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -201,6 +201,8 @@ struct dml2_core_internal_watermarks {
 	double WritebackFCLKChangeWatermark;
 	double StutterExitWatermark;
 	double StutterEnterPlusExitWatermark;
+	double LowPowerStutterExitWatermark;
+	double LowPowerStutterEnterPlusExitWatermark;
 	double Z8StutterExitWatermark;
 	double Z8StutterEnterPlusExitWatermark;
 	double USRRetrainingWatermark;
@@ -877,6 +879,9 @@ struct dml2_core_internal_mode_program {
 	double Z8StutterEfficiency;
 	unsigned int Z8NumberOfStutterBurstsPerFrame;
 	double Z8StutterEfficiencyNotIncludingVBlank;
+	double LowPowerStutterEfficiency;
+	double LowPowerStutterEfficiencyNotIncludingVBlank;
+	unsigned int LowPowerNumberOfStutterBurstsPerFrame;
 	double StutterPeriod;
 	double Z8StutterEfficiencyBestCase;
 	unsigned int Z8NumberOfStutterBurstsPerFrameBestCase;
@@ -1016,6 +1021,8 @@ struct dml2_core_internal_SOCParametersList {
 	double FCLKChangeLatency;
 	double SRExitTime;
 	double SREnterPlusExitTime;
+	double SRExitTimeLowPower;
+	double SREnterPlusExitTimeLowPower;
 	double SRExitZ8Time;
 	double SREnterPlusExitZ8Time;
 	double USRRetrainingLatency;
@@ -1851,9 +1858,11 @@ struct dml2_core_calcs_CalculateStutterEfficiency_params {
 	unsigned int CompbufReservedSpaceZs;
 	bool hw_debug5;
 	double SRExitTime;
+	double SRExitTimeLowPower;
 	double SRExitZ8Time;
 	bool SynchronizeTimings;
 	double StutterEnterPlusExitWatermark;
+	double LowPowerStutterEnterPlusExitWatermark;
 	double Z8StutterEnterPlusExitWatermark;
 	bool ProgressiveToInterlaceUnitInOPP;
 	double *MinTTUVBlank;
@@ -1879,7 +1888,10 @@ struct dml2_core_calcs_CalculateStutterEfficiency_params {
 	// output
 	double *StutterEfficiencyNotIncludingVBlank;
 	double *StutterEfficiency;
+	double *LowPowerStutterEfficiencyNotIncludingVBlank;
+	double *LowPowerStutterEfficiency;
 	unsigned int *NumberOfStutterBurstsPerFrame;
+	unsigned int *LowPowerNumberOfStutterBurstsPerFrame;
 	double *Z8StutterEfficiencyNotIncludingVBlank;
 	double *Z8StutterEfficiency;
 	unsigned int *Z8NumberOfStutterBurstsPerFrame;
-- 
2.43.0


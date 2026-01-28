Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CAC7D35663
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Jan 2026 02:00:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8A6110E601;
	Wed, 28 Jan 2026 02:00:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f83jlWFZ";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012037.outbound.protection.outlook.com
 [40.107.200.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F04210E5FE
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Jan 2026 02:00:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NZLS1K6spXTeaw4LaqnbGDN/iM3X+nYBkv9+zmvy5ldMk+TRLy6bkoUcaddQaYhCxqeqCJGK3Si6PWy2uOALbBEQeR/cCqCpE3z8muTexJFVduQK4GcREajXN74p4y/gm+oJd5pIK0c8AIfYo04qmSCPXf/qpGMmwHXtmoWpijinqeFtLLZ66BOn3zgiLkW5gR71piYFQo2TfLtFYTPLQzU0KjIFWPFuhqJvVorCNfxpwjWaMZrUEDhQB7fJ/+pNhSd0bZ+FIp+KMHLc0Ivv8dKYQTFy45IZL3rBV10iyAnEoEP++Pl9J4EzQceNazbYOMbULMKwlfBUV0D5MvaexQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Itnw+LN7tuir5UbQW9sgU9EpsPRNsD0xq/jl2blV16g=;
 b=oDZUHg4/RK9pyNlE8lLNDrxwdBaNUu+Y8zOHotV9jD7oqXzSpfRR0HaeuhoGM6xaDJgUTD+4GG2Ij10ZKNHPUYQJkZ1fXO4TibUPjo/A8+mY4tW9HOVPBmihxq00fgjztRKcyOF12zBHEZoEboEi+5a8dNc2GcwvyRfgsMXJpy0zufCHV32tYST8o80ibUUovbYdhE4BC8r74UkxsukGlRmzCdBVV6JJ/Y0tZ+ykjLPYXouvDxcFwqX3V1eXt9tZKvdxnCNjgzYVQw3et+4gMATRTk+v7igK16RbcCxn1PefP6ws+yPj/xZq8XEnEljK2m5kQer970SEHVQurF8ITQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Itnw+LN7tuir5UbQW9sgU9EpsPRNsD0xq/jl2blV16g=;
 b=f83jlWFZtF/PGANkgEjBn8DE7AUaRKLUI9VYI/DbexixljKJQNggWZSCexq9LAysbAXhbVEoBIdvghvH72+++myLHQs5IZCheIg1jXpGR2NQdPW2l+lVmElfHL00khKXW3CtCmBXMEXPeIW4AcP4+Vk+pFt6oMQuVn4AnVjaeVo=
Received: from BLAPR03CA0164.namprd03.prod.outlook.com (2603:10b6:208:32f::20)
 by LV8PR12MB9360.namprd12.prod.outlook.com (2603:10b6:408:205::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.7; Wed, 28 Jan
 2026 02:00:20 +0000
Received: from BL02EPF00021F6E.namprd02.prod.outlook.com
 (2603:10b6:208:32f:cafe::fd) by BLAPR03CA0164.outlook.office365.com
 (2603:10b6:208:32f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Wed,
 28 Jan 2026 02:00:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL02EPF00021F6E.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Wed, 28 Jan 2026 02:00:19 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 20:00:13 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 20:00:12 -0600
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 27 Jan 2026 20:00:09 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Zheng Austin <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 15/21] drm/amd/display: Match expected data types
Date: Wed, 28 Jan 2026 09:51:40 +0800
Message-ID: <20260128015538.568712-16-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260128015538.568712-1-Wayne.Lin@amd.com>
References: <20260128015538.568712-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6E:EE_|LV8PR12MB9360:EE_
X-MS-Office365-Filtering-Correlation-Id: cb9513aa-53fd-41c8-5f0c-08de5e10fd84
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|30052699003|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s9Q7H7Xgh8V6F/U4K08GURx3BhE6ntbguK83UMtuZXpcFOB0RRfU8AKRywFh?=
 =?us-ascii?Q?J4oF6VcpCUyvf8Nl/gZUvqqgB3et9ULd7OTUQPowilHIwfr0Q744LKX0yECN?=
 =?us-ascii?Q?W2alWex2Yr7lFhbcm2SGUupuRyNkPx+d1+xDE7hKE3DHJyRl99Vx+0UgTIbs?=
 =?us-ascii?Q?pQDYQw3xd0iKLS4NyJIDuGqt3bg893RTXr+fmBM4r8Qsr1HbYYw+T62Sug6S?=
 =?us-ascii?Q?bAqBZSuWcrPttUHYdQUWe3I75xXZH1jSVt3/6BbMQI+xPSQ+TZ61polzDjPu?=
 =?us-ascii?Q?MN/3gspfUtQp/qF96o1Jm3gxzJaasp9DfCUWa9WbClaF0UlLzMRIUXU3RasH?=
 =?us-ascii?Q?gTMEEo2vpc2IR1bEyKeOv0VdGqpYUSobRrbfrAD+BoJFWOceSOIXHBWsMTN4?=
 =?us-ascii?Q?6MKg2AiXlPdYAE5St8/RTuLmqH5O20xe8T5ItRyRcIvjYSYFhqqodkLOz0dn?=
 =?us-ascii?Q?gVHiy84KsaSTrrWp4tD7GbOO/UEHN+TfCpL6CDx/TTZTCRYjrv0FhNJFOwoa?=
 =?us-ascii?Q?ZrQKnYtINtwR6+UqmoyvjHMAfAi+9UEpmRmMJl/eMbrHWcd/1JL+a6KW03K4?=
 =?us-ascii?Q?QZx2FvkdGXJ2XB5GovsxL/nhI3KiMvH9QYCPP1iuTNQoYbZZ69r8mzDhRxp3?=
 =?us-ascii?Q?O16gMFQDTGW1cayNcOfdGFnrIbBM9deo/H9lTui1mBHSjor9YX2G2Y5pa9/Q?=
 =?us-ascii?Q?libQj3dTYwvWCHXP04UUSq+GipkmPFJYF8uXwaxDuWGuLEAH3Hxg+rWsRNnH?=
 =?us-ascii?Q?OCLXEgtlV0XdJzh+E2Qig1OtJ2i86VhTMup1bn6pV9Yl9liXP2T0XFBL1e26?=
 =?us-ascii?Q?I5gBRNW8jauUzVFMCycnCYmyhzZMqMH8U5pjX6qwZdRo5vMQuiXFNqitRh/B?=
 =?us-ascii?Q?6KLpYuTTIpl5rzZXLPouf2t8eRLQkS2MgYJEVEZrIwV/LQlIBj3NyUsy0bZK?=
 =?us-ascii?Q?PjiVU/l2TYJx0VjDJibg8DzTZIUV8pPLRLhkYCSFNRC+XgS6Icm01Y4IpFdP?=
 =?us-ascii?Q?kqE6CrsjWrsbO9aL+5AZibfTOSBFDBHt9tjqigZf/FIdZFQEtMuEKLRRHcVY?=
 =?us-ascii?Q?w/7bVeA4t1yKPL1spEs8rw/shWMqALpGgAjNZfMXQUe59HXxLkjkv2nTV5Lc?=
 =?us-ascii?Q?XdJXKMF61GqLuiXDrdZ6LjdHf4//+GPPWxU/LyMpcx3D9Z2ybUYi0+EYvUyB?=
 =?us-ascii?Q?vHPMVe/vW4mQ9IPuxe4we1kDjgzjW10yZbb2TUhTxBF3qtg6PVOAWmngJa8h?=
 =?us-ascii?Q?dVx5abT1q9xmju1lk9FcHRKywGuwKL7F4g3aCyrxPrY3vm5bAfJYBAx7RX/g?=
 =?us-ascii?Q?5uhbkhDWnfuZI68vrTHyfLTdNpE/kwIiHA20/2HHJtCVfJxvxI/UQLNyfX9R?=
 =?us-ascii?Q?JscoGkOzaUv/xpMgO29f1RNR1w+hWPZ3Wnou9TOieAqNVzr5vKheKlVRyXm7?=
 =?us-ascii?Q?U1a7D7X8lbUjkYlYoTQJ30QpKq4YseunyZeOLzOpze5kiLskuoNLFClVx9OP?=
 =?us-ascii?Q?4YdntdeNDmGCSFbBQuD2TFJivaLEjd30IB3zU0+8yFXjf92mChs17Tks6I2F?=
 =?us-ascii?Q?BUweNi1c2p18TPHwnFw4ehoCMjoCI21NyilB6xMDJagTQ0L1dDdNlfuU9WZj?=
 =?us-ascii?Q?EiI4DX6qy8Q1rzPjdResIVyRot4ZIMbDaDTMs/lJfuc34RlyJrEzgtGwXvQQ?=
 =?us-ascii?Q?r/ujag=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(30052699003)(1800799024);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2026 02:00:19.8642 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb9513aa-53fd-41c8-5f0c-08de5e10fd84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9360
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

From: Zheng Austin <Austin.Zheng@amd.com>

[Why/How]
Data types should match what is expected.
Update/cast data accordingly.

Also change ASSERT to use DML_ASSERT instead

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Zheng Austin <Austin.Zheng@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../src/dml2_core/dml2_core_dcn4_calcs.c      |  4 +--
 .../dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c      | 34 +++++++++----------
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 37699cc9e5c1..ca5ac3c0deb5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -7080,7 +7080,7 @@ static void calculate_excess_vactive_bandwidth_required(
 static double uclk_khz_to_dram_bw_mbps(unsigned long uclk_khz, const struct dml2_dram_params *dram_config, const struct dml2_mcg_dram_bw_to_min_clk_table *dram_bw_table)
 {
 	double bw_mbps = 0;
-	int i;
+	unsigned int i;
 
 	if (!dram_config->alt_clock_bw_conversion)
 		bw_mbps = ((double)uclk_khz * dram_config->channel_count * dram_config->channel_width_bytes * dram_config->transactions_per_clock) / 1000.0;
@@ -7091,7 +7091,7 @@ static double uclk_khz_to_dram_bw_mbps(unsigned long uclk_khz, const struct dml2
 				break;
 			}
 
-	ASSERT(bw_mbps > 0);
+	DML_ASSERT(bw_mbps > 0);
 
 	return bw_mbps;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
index 5c713f2e6eca..9d7741fd0adb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_dpmm/dml2_dpmm_dcn4.c
@@ -17,7 +17,7 @@ static double dram_bw_kbps_to_uclk_khz(unsigned long long bandwidth_kbps, const
 		uclk_bytes_per_tick = dram_config->channel_count * dram_config->channel_width_bytes * dram_config->transactions_per_clock;
 		uclk_khz = (double)bandwidth_kbps / uclk_bytes_per_tick;
 	} else {
-		int i;
+		unsigned int i;
 		/* For lpddr5 bytes per tick changes with mpstate, use table to find uclk*/
 		for (i = 0; i < dram_bw_table->num_entries; i++)
 			if (dram_bw_table->entries[i].pre_derate_dram_bw_kbps >= bandwidth_kbps) {
@@ -63,17 +63,17 @@ static void calculate_system_active_minimums(struct dml2_dpmm_map_mode_to_soc_dp
 	double min_uclk_latency, min_fclk_latency, min_dcfclk_latency;
 	const struct dml2_core_mode_support_result *mode_support_result = &in_out->display_cfg->mode_support_result;
 
-	min_uclk_avg = dram_bw_kbps_to_uclk_khz(mode_support_result->global.active.average_bw_dram_kbps
-											/ ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_average.dram_derate_percent_pixel / 100),
+	min_uclk_avg = dram_bw_kbps_to_uclk_khz((unsigned long long)(mode_support_result->global.active.average_bw_dram_kbps
+											/ ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_average.dram_derate_percent_pixel / 100)),
 							&in_out->soc_bb->clk_table.dram_config, &in_out->min_clk_table->dram_bw_table);
 
 	if (in_out->display_cfg->display_config.hostvm_enable)
-		min_uclk_urgent = dram_bw_kbps_to_uclk_khz(mode_support_result->global.active.urgent_bw_dram_kbps
-										/ ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_urgent.dram_derate_percent_pixel_and_vm / 100),
+		min_uclk_urgent = dram_bw_kbps_to_uclk_khz((unsigned long long)(mode_support_result->global.active.urgent_bw_dram_kbps
+										/ ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_urgent.dram_derate_percent_pixel_and_vm / 100)),
 							 &in_out->soc_bb->clk_table.dram_config, &in_out->min_clk_table->dram_bw_table);
 	else
-		min_uclk_urgent = dram_bw_kbps_to_uclk_khz(mode_support_result->global.active.urgent_bw_dram_kbps
-										/ ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_urgent.dram_derate_percent_pixel / 100),
+		min_uclk_urgent = dram_bw_kbps_to_uclk_khz((unsigned long long)(mode_support_result->global.active.urgent_bw_dram_kbps
+										/ ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_urgent.dram_derate_percent_pixel / 100)),
 							 &in_out->soc_bb->clk_table.dram_config, &in_out->min_clk_table->dram_bw_table);
 
 	min_uclk_bw = min_uclk_urgent > min_uclk_avg ? min_uclk_urgent : min_uclk_avg;
@@ -111,12 +111,12 @@ static void calculate_svp_prefetch_minimums(struct dml2_dpmm_map_mode_to_soc_dpm
 	const struct dml2_core_mode_support_result *mode_support_result = &in_out->display_cfg->mode_support_result;
 
 	/* assumes DF throttling is enabled */
-	min_uclk_avg = dram_bw_kbps_to_uclk_khz(mode_support_result->global.svp_prefetch.average_bw_dram_kbps
-								/ ((double)in_out->soc_bb->qos_parameters.derate_table.dcn_mall_prefetch_average.dram_derate_percent_pixel / 100),
+	min_uclk_avg = dram_bw_kbps_to_uclk_khz((unsigned long long)(mode_support_result->global.svp_prefetch.average_bw_dram_kbps
+								/ ((double)in_out->soc_bb->qos_parameters.derate_table.dcn_mall_prefetch_average.dram_derate_percent_pixel / 100)),
 						&in_out->soc_bb->clk_table.dram_config, &in_out->min_clk_table->dram_bw_table);
 
-	min_uclk_urgent = dram_bw_kbps_to_uclk_khz(mode_support_result->global.svp_prefetch.urgent_bw_dram_kbps
-								/ ((double)in_out->soc_bb->qos_parameters.derate_table.dcn_mall_prefetch_urgent.dram_derate_percent_pixel / 100),
+	min_uclk_urgent = dram_bw_kbps_to_uclk_khz((unsigned long long)(mode_support_result->global.svp_prefetch.urgent_bw_dram_kbps
+								/ ((double)in_out->soc_bb->qos_parameters.derate_table.dcn_mall_prefetch_urgent.dram_derate_percent_pixel / 100)),
 						 &in_out->soc_bb->clk_table.dram_config, &in_out->min_clk_table->dram_bw_table);
 
 	min_uclk_bw = min_uclk_urgent > min_uclk_avg ? min_uclk_urgent : min_uclk_avg;
@@ -144,12 +144,12 @@ static void calculate_svp_prefetch_minimums(struct dml2_dpmm_map_mode_to_soc_dpm
 	in_out->programming->min_clocks.dcn4x.svp_prefetch.dcfclk_khz = dml_round_up(min_dcfclk_bw > min_dcfclk_latency ? min_dcfclk_bw : min_dcfclk_latency);
 
 	/* assumes DF throttling is disabled */
-	min_uclk_avg = dram_bw_kbps_to_uclk_khz(mode_support_result->global.svp_prefetch.average_bw_dram_kbps
-										/ ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_average.dram_derate_percent_pixel / 100),
+	min_uclk_avg = dram_bw_kbps_to_uclk_khz((unsigned long long)(mode_support_result->global.svp_prefetch.average_bw_dram_kbps
+										/ ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_average.dram_derate_percent_pixel / 100)),
 								&in_out->soc_bb->clk_table.dram_config, &in_out->min_clk_table->dram_bw_table);
 
-	min_uclk_urgent = dram_bw_kbps_to_uclk_khz(mode_support_result->global.svp_prefetch.urgent_bw_dram_kbps
-										/ ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_urgent.dram_derate_percent_pixel / 100),
+	min_uclk_urgent = dram_bw_kbps_to_uclk_khz((unsigned long long)(mode_support_result->global.svp_prefetch.urgent_bw_dram_kbps
+										/ ((double)in_out->soc_bb->qos_parameters.derate_table.system_active_urgent.dram_derate_percent_pixel / 100)),
 								&in_out->soc_bb->clk_table.dram_config, &in_out->min_clk_table->dram_bw_table);
 
 	min_uclk_bw = min_uclk_urgent > min_uclk_avg ? min_uclk_urgent : min_uclk_avg;
@@ -185,8 +185,8 @@ static void calculate_idle_minimums(struct dml2_dpmm_map_mode_to_soc_dpm_params_
 	double min_uclk_latency, min_fclk_latency, min_dcfclk_latency;
 	const struct dml2_core_mode_support_result *mode_support_result = &in_out->display_cfg->mode_support_result;
 
-	min_uclk_avg = dram_bw_kbps_to_uclk_khz(mode_support_result->global.active.average_bw_dram_kbps
-										/ ((double)in_out->soc_bb->qos_parameters.derate_table.system_idle_average.dram_derate_percent_pixel / 100),
+	min_uclk_avg = dram_bw_kbps_to_uclk_khz((unsigned long long)(mode_support_result->global.active.average_bw_dram_kbps
+										/ ((double)in_out->soc_bb->qos_parameters.derate_table.system_idle_average.dram_derate_percent_pixel / 100)),
 								&in_out->soc_bb->clk_table.dram_config, &in_out->min_clk_table->dram_bw_table);
 
 	min_fclk_avg = (double)mode_support_result->global.active.average_bw_sdp_kbps / in_out->soc_bb->fabric_datapath_to_dcn_data_return_bytes;
-- 
2.43.0


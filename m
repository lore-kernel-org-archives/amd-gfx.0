Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08BDCC61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:09:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7536F10EFDB;
	Wed,  2 Sep 2026 05:08:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4e+mUUSO";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A917D10EFDB
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:08:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lkqKlQCcu/I+QkTG7pT6S5TgmUB08c0V3IDGrQKjtJTMeeVt7Tv1STEMZNDhX76WLzQp8tMAExcKTEWLYeH1C4Ez5cESeIiV7zjqtfiWcXSQtbeHTQcBR7VPE0t21IKo3T5beVEQirWk07NnZ57AILEfSNbXj7g4ChU4Tn5IcbkebdC+UUVmgH45au4DD75G6+1Xn8RZd4arfFhhqUVmQ0jO7iNPwBRJXwbIPIRoC35XOVogCpn5oIXK+sUfjayFwZcQ6aGWCzmKzFeT1i5lrUjtoFVWixqegD6Ukd2gMrx4QIgKVPfAcrGOBwq84okn304yU+Gt7jCrgrMva6Rrbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=re0uAJGbAwTRwo/ynBkfKt/SpWYfofyf4GkJYItMpJY=;
 b=viREM8L5/Waxfy/08Eu5l6pvv+stND7JoLGZBPDwYNOAq1sHCAsexOSHbdV2SH6EONNqD4JmblIFUvyZuV3H+cZFLaZ6e/iZROl470cicC5S6EsIjkr5ShPYu3t0piSIEGseubnRAOnmqMwKzrizcwTz3JhfidDLUzTD4e8ip2AWhQNLat58H+8RgJS58XaOjynBX3N8iKdw78thv5tEMsz6OdlSuu9KtnPMNd6KzstR2nquFf6fp6KYFQ59fU/3TcAUSMp2vvVyWv1KGb+RlREeVCdxQDFsd/YrLnJUiXNmkjZ1AYm2s0ZWlm8BsnlFbcuJvMYA2HrWHEzFJzEi2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=re0uAJGbAwTRwo/ynBkfKt/SpWYfofyf4GkJYItMpJY=;
 b=4e+mUUSOri9q22i6bluUT7eyQvaZL8Gx/9Zx3bWBMePSGbTKFCRmWGnnea4iEU7xvW1fTQ687d+9hhpv4s44VI/FT0hJxtlUgmfXU2aFmhCNc3oWAOHXhDlLeO/ocs7IKwB8qDj43HoUPdUvlX5huwhKUAOIR2jIcsd55vKUkkw=
Received: from BN0PR10CA0020.namprd10.prod.outlook.com (2603:10b6:408:143::11)
 by IA1PR12MB9524.namprd12.prod.outlook.com (2603:10b6:208:596::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:08:52 +0000
Received: from LV8PEPF00000069.namprd03.prod.outlook.com
 (2603:10b6:408:143:cafe::a3) by BN0PR10CA0020.outlook.office365.com
 (2603:10b6:408:143::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 05:08:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF00000069.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:08:52 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:08:52 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:08:43 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Austin Zheng <Austin.Zheng@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 30/40] drm/amd/display: Update Urgent Burst Calculation To
 Account For Unbounded Requests
Date: Wed, 2 Sep 2026 12:58:52 +0800
Message-ID: <20260902050411.3473916-31-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000069:EE_|IA1PR12MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: db3289aa-e4a9-4b58-25c2-08df08b04813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|1800799024|82310400026|30052699003|11063799006|5023799004|10067099003|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: zMI+/eJr+nQLghT75LZcozSe330gsX+O2KYwxC0LIp00PVGEB8AT3ceI5Q6M5O4/7EjsRT3TWVMKdJcffabgPlWy1vuExo/X6y9aplH5LXR2sEFj4bGngxvNSxIM7JLYznT5I7inRFQ++7AhIq3jZZSbjR13d7xqw5u3WCyu/CI3HeLM1lkFpffUJT3vT5m1jJdQENHOjWXjylJwCrPaZqFHbY10yzPMlcldbRIchd8EkcdRfGQrg6PWAc+vhxxIrahikAa6DCEWfpFGlKybJU+0p1FyxRCYYoh4NWZLZAkIBN/yL1xcqXNgPX33u6t0ToUcAIRHINKsRuT1P8wXY3dTxQsWjKyb1FLZavhf35jjxiRtMHlOY0zN3sHDdlL6jamgfVc+yYnJ9y/qKL2g8loqSk+55QgAdOFqV7ZaUvv1jPErX66aB04yKPr0Ufmlc+UqfcFxuy2T3ixA1rRu+9i5omvX7exVxLPceMODa5zf1WS7fTbK36cvQRnCd2TuB8tEr+nFhuJdTosREOeD/uDOnUO64fPowWPQ56UJFexE6GXYTu8wQSTdoDtkr+LJK/Vj5duIUlA7c0XTQNrnvh2aQO2R+2hg3won1G3uc35PyjPJ0L3+bKfeHpxLv220Afl5BYR1ZH/bclf2o7xZNMsNtIeOI3ZWZk79kGYqcPqJE8PKGgJFd9sf75KP2R8FsEX1/Gp6upNpA6j51TKOXQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(1800799024)(82310400026)(30052699003)(11063799006)(5023799004)(10067099003)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: MnrcgNEmYETGgjAzASHmnQsmn94bJXwJ9pfn3mMN7PbyQ9eVK2MwE13dkcGeunkxJXNFK8GFs0Pqf375vVdx6ZpZK7UIjMB3pnQciP5jOdHSD9cs0O3YeRI98CisUHh/AdnxL7VWQsh/bZsaWD5Eey++BLVtHN/fMH+qCRMcm7DpsPjyR3uEVQYm4gF/ftRv+K+LPQp217AxPY9qKf0zhCl03pHtq36uo2at0QZ2PsdqWq564xi6w2+ic/G6lxQgoFhtmbqzcutqkqs/2K0Ax7o90UME6g7IMMimFWcCC4HomDady6v4sq+nlFbO2S7efUmOoZAdyRZl36y0EpETG/7FIYT8unktEifteyWt512e2rmv3pi4GXyRC4B/HjZBo9K+FbD5TLdeMcrWoAplXAMuDYfzm5fC6FfkhluhpS4YQQlLHvGGk+bhZ9OiNexF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:08:52.5946 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db3289aa-e4a9-4b58-25c2-08df08b04813
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000069.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9524
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

[Why & How]
dcn5_calculate_urgent_burst_factor function is aware of unbounded
request mode making the buffer larger

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../amd/display/dc/dml2_0/dml21/inc/dml_top_types.h  | 12 ++++++++++++
 .../dc/dml2_0/dml21/src/dml2_cga/dml2_cga_dcn6.c     |  4 +++-
 .../dml21/src/dml2_core/dml2_core_dcn4_calcs.c       |  4 ++++
 .../dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c |  7 ++++++-
 .../dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.h |  2 ++
 .../dml2_core_dcn5_funcs_mode_programming.c          |  4 ++++
 .../dml2_core/dml2_core_dcn5_funcs_mode_support.c    |  4 ++++
 .../dml2_core_dcn6_funcs_mode_programming.c          |  2 ++
 .../dml2_core/dml2_core_dcn6_funcs_mode_support.c    |  4 ++++
 .../dml21/src/dml2_core/dml2_core_shared_types.h     |  1 +
 .../dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c |  5 +++++
 .../dml21/src/inc/dml2_internal_shared_types.h       |  2 ++
 12 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
index c241ecaf4d7a..5e056839aaf7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/dml_top_types.h
@@ -380,6 +380,10 @@ struct dml2_mode_support_info {
 	bool temp_read_or_ppt_support;
 	bool qos_bandwidth_support;
 	bool dcfclk_support;
+	bool alternate_channel_size_support;
+	bool EnoughUrgentLatencyHidingSupport;
+	bool DSCSlicesODMModeSupported;
+	bool HActiveForDSCSupported;
 }; // dml2_mode_support_info
 
 struct dml2_memory_path_latency {
@@ -544,6 +548,14 @@ struct dml2_display_cfg_programming {
 			double max_active_fclk_change_latency_supported;
 			unsigned int min_return_latency_in_dcfclk;
 
+			struct {
+				struct {
+					double sdp_bw_mbps;
+					double dram_bw_mbps;
+					double dram_vm_only_bw_mbps;
+				} sys_active;
+			} non_urg_bw_available;
+
 			struct {
 				struct {
 					double sdp_bw_mbps;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_cga/dml2_cga_dcn6.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_cga/dml2_cga_dcn6.c
index 8c3dd030e775..43ee8a0b21b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_cga/dml2_cga_dcn6.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_cga/dml2_cga_dcn6.c
@@ -56,7 +56,9 @@ static double cga_dcn6_adjust_to_dfs_clock_value_mhz(const struct dml2_clock_gra
 	double vco_divider;
 	double adjusted_clock_mhz;
 
-	DML_ASSERT_MSG(adjuster->dispclk_dppclk_vco_speed_mhz > 1, "invalid dispclk_dppclk_vco_speed_mhz value!\n");
+	if (adjuster->dispclk_dppclk_vco_speed_mhz == 0.0)
+		return clk_mhz;
+
 	if (clk_mhz == 0)
 		/* There are cases when a clock is not needed */
 		return 0;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 64417736a4d9..4f5c95648834 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -357,6 +357,8 @@ dml_get_var_func(svp_prefetch_urg_bw_available_sdp, double, mode_lib->mp.urg_ban
 dml_get_var_func(svp_prefetch_urg_bw_available_dram, double, mode_lib->mp.urg_bandwidth_available[dml2_core_internal_soc_state_svp_prefetch][dml2_core_internal_bw_dram]);
 dml_get_var_func(svp_prefetch_urg_bw_available_dram_vm_only, double, mode_lib->mp.urg_bandwidth_available_vm_only[dml2_core_internal_soc_state_svp_prefetch]);
 
+dml_get_var_func(sys_active_non_urg_bw_available_sdp, double, mode_lib->mp.non_urg_bandwidth_available[dml2_core_internal_soc_state_sys_active][dml2_core_internal_bw_sdp]);
+
 dml_get_var_func(urgent_latency, double, mode_lib->mp.UrgentLatency);
 dml_get_var_func(max_urgent_latency_us, double, mode_lib->ms.support.max_urgent_latency_us);
 dml_get_var_func(max_non_urgent_latency_us, double, mode_lib->ms.support.max_non_urgent_latency_us);
@@ -13350,6 +13352,8 @@ void dml2_core_calcs_get_informative(const struct dml2_core_internal_display_mod
 	out->informative.qos.urg_bw_available.svp_prefetch.dram_bw_mbps = dml_get_svp_prefetch_urg_bw_available_dram(mode_lib);
 	out->informative.qos.urg_bw_available.svp_prefetch.dram_vm_only_bw_mbps = dml_get_svp_prefetch_urg_bw_available_dram_vm_only(mode_lib);
 
+	out->informative.qos.non_urg_bw_available.sys_active.sdp_bw_mbps = dml_get_sys_active_non_urg_bw_available_sdp(mode_lib);
+
 	out->informative.qos.urg_bw_required.sys_active.sdp_bw_mbps = dml_get_sys_active_urg_bw_required_sdp(mode_lib);
 	out->informative.qos.urg_bw_required.sys_active.dram_bw_mbps = dml_get_sys_active_urg_bw_required_dram(mode_lib);
 	out->informative.qos.urg_bw_required.svp_prefetch.sdp_bw_mbps = dml_get_svp_prefetch_urg_bw_required_sdp(mode_lib);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
index 09047661a411..f00a45f87101 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.c
@@ -1811,6 +1811,9 @@ void dcn5_calculate_urgent_burst_factor(
 		double VRatioC,
 		double BytePerPixelInDETY,
 		double BytePerPixelInDETC,
+		bool UnboundedRequestEnabled,
+		unsigned int CompressedBufferSizeInkByte,
+
 		unsigned int DETBufferSizeY,
 		unsigned int DETBufferSizeC,
 		// Output
@@ -1837,7 +1840,9 @@ void dcn5_calculate_urgent_burst_factor(
 	DML_LOG_VERBOSE("DML::%s: LineTime = %f\n", __func__, LineTime);
 	DML_ASSERT(VRatio > 0);
 
-	LinesInDETLuma = DETBufferSizeY / BytePerPixelInDETY / swath_width_luma_ub;
+	unsigned int EffectiveBufferY = DETBufferSizeY + (UnboundedRequestEnabled ? CompressedBufferSizeInkByte * 1024 : 0);
+
+	LinesInDETLuma = EffectiveBufferY / BytePerPixelInDETY / swath_width_luma_ub;
 
 	DETBufferSizeInTimeLuma = math_floor2(LinesInDETLuma, SwathHeightY) * LineTime / VRatio;
 	if (DETBufferSizeInTimeLuma - UrgentLatency <= 0) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.h
index d4869571db9d..7b5268e100ed 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_calcs_dchub.h
@@ -103,6 +103,8 @@ void dcn5_calculate_urgent_burst_factor(
 		double VRatioC,
 		double BytePerPixelInDETY,
 		double BytePerPixelInDETC,
+		bool UnboundedRequestEnabled,
+		unsigned int CompressedBufferSizeInkByte,
 		unsigned int DETBufferSizeY,
 		unsigned int DETBufferSizeC,
 		// Output
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_programming.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_programming.c
index 297e21e7c68d..d7a48ca44b68 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_programming.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_programming.c
@@ -592,6 +592,8 @@ static bool dcn5_mode_programming(struct dml2_core_calcs_mode_programming_ex *in
 			display_cfg->plane_descriptors[k].composition.scaler_info.plane1.v_ratio,
 			mode_lib->mp.BytePerPixelInDETY[k],
 			mode_lib->mp.BytePerPixelInDETC[k],
+			mode_lib->mp.UnboundedRequestEnabled,
+			mode_lib->mp.CompressedBufferSizeInkByte,
 			mode_lib->mp.DETBufferSizeY[k],
 			mode_lib->mp.DETBufferSizeC[k],
 
@@ -801,6 +803,8 @@ static bool dcn5_mode_programming(struct dml2_core_calcs_mode_programming_ex *in
 					mode_lib->mp.VRatioPrefetchC[k],
 					mode_lib->mp.BytePerPixelInDETY[k],
 					mode_lib->mp.BytePerPixelInDETC[k],
+					mode_lib->mp.UnboundedRequestEnabled,
+					mode_lib->mp.CompressedBufferSizeInkByte,
 					mode_lib->mp.DETBufferSizeY[k],
 					mode_lib->mp.DETBufferSizeC[k],
 					/* Output */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.c
index fde2e0ad2529..09519f0f2251 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.c
@@ -1547,6 +1547,8 @@ static void dcn5_ms_calculate_det_buffer_time_value_urgent_burst_factor_and_urge
 				plane->composition.scaler_info.plane1.v_ratio,
 				mode_lib->ms.BytePerPixelInDETY[k],
 				mode_lib->ms.BytePerPixelInDETC[k],
+				mode_lib->ms.UnboundedRequestEnabled,
+				mode_lib->ms.CompressedBufferSizeInkByte,
 				mode_lib->ms.DETBufferSizeY[k],
 				mode_lib->ms.DETBufferSizeC[k],
 
@@ -2095,6 +2097,8 @@ static void dcn5_ms_calculate_urgent_burst_factor_for_prefetch(
 				mode_lib->ms.VRatioPreC[k],
 				mode_lib->ms.BytePerPixelInDETY[k],
 				mode_lib->ms.BytePerPixelInDETC[k],
+				mode_lib->ms.UnboundedRequestEnabled,
+				mode_lib->ms.CompressedBufferSizeInkByte,
 				mode_lib->ms.DETBufferSizeY[k],
 				mode_lib->ms.DETBufferSizeC[k],
 				/* Output */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
index 39f0cd14ca3e..00194c608f8b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
@@ -1110,6 +1110,8 @@ static void dcn6_mp_initialize_from_solution(struct dml2_core_internal_mode_prog
 	outputs->min_available_urgent_bandwidth_MBps = solution->validation_result.mode_support.bandwidth_upper_bound.dcn5.urgent_bandwidth_kbps / 1000.0;
 	**outputs->urg_bandwidth_available = math_min2(solution->sop_constraint.dcn5.min_available_urgent_bandwidth_KBps / 1000.0,
 		outputs->Dcfclk * utm_soc_bb->urgent_sdp_derate_percent / 100.0 * utm_soc_bb->return_bus_width_bytes);
+	**outputs->non_urg_bandwidth_available = math_min2(solution->sop_constraint.dcn5.min_available_non_urgent_bandwidth_KBps / 1000.0,
+		outputs->Dcfclk * utm_soc_bb->nominal_sdp_derate_percent / 100.0 * utm_soc_bb->return_bus_width_bytes);
 
 	outputs->UrgentLatency = solution->sop_constraint.dcn5.latency.dcn5.urgent_ramp;
 	outputs->TripToMemory = math_max2(solution->sop_constraint.dcn5.latency.dcn5.urgent_ramp,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
index de81815f098a..166022bb3096 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
@@ -2140,6 +2140,8 @@ static void dcn6_ms_calculate_det_buffer_time_value_urgent_burst_factor_and_urge
 				plane->composition.scaler_info.plane1.v_ratio,
 				inputs->BytePerPixelInDETY[k],
 				inputs->BytePerPixelInDETC[k],
+				inputs->UnboundedRequestEnabled,
+				inputs->CompressedBufferSizeInkByte,
 				inputs->DETBufferSizeY[k],
 				inputs->DETBufferSizeC[k],
 
@@ -3030,6 +3032,8 @@ static void dcn6_ms_calculate_urgent_burst_factor_for_prefetch(
 				inputs->VRatioPreC[k],
 				inputs->BytePerPixelInDETY[k],
 				inputs->BytePerPixelInDETC[k],
+				inputs->UnboundedRequestEnabled,
+				inputs->CompressedBufferSizeInkByte,
 				inputs->DETBufferSizeY[k],
 				inputs->DETBufferSizeC[k],
 				/* Output */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
index 289ed250f477..9eabee1fc001 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_shared_types.h
@@ -1070,6 +1070,7 @@ struct dml2_core_internal_mode_program {
 	double urg_bandwidth_available[dml2_core_internal_soc_state_max][dml2_core_internal_bw_max];
 	double urg_bandwidth_available_vm_only[dml2_core_internal_soc_state_max]; // the min of sdp bw and dram_vm_only bw, sdp has no different derate for vm/non-vm traffic etc.
 	double urg_bandwidth_available_pixel_and_vm[dml2_core_internal_soc_state_max]; // the min of sdp bw and dram_pixel_and_vm bw, sdp has no different derate for vm/non-vm etc.
+	double non_urg_bandwidth_available[dml2_core_internal_soc_state_max][dml2_core_internal_bw_max];
 
 	double dcc_dram_bw_nom_overhead_factor_p0[DML2_MAX_PLANES];
 	double dcc_dram_bw_nom_overhead_factor_p1[DML2_MAX_PLANES];
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c
index 937205f1f086..67722c45c224 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn6.c
@@ -32,6 +32,8 @@ static void dcn6_sop_table_get_sop_constraint_at_index(const struct dml2_sop_tab
 	constraint->dcn5.latency.dcn5.avg_req_latency_non_urg = dchub->latencies[index].avg_req_latency_non_urg_ps / 1000000.0;
 	constraint->dcn5.latency.dcn5.df_response_time_us = dchub->latencies[index].df_response_time_ps / 1000000.0;
 	constraint->dcn5.min_available_urgent_bandwidth_KBps = table->sop_min_available_urgent_bandwidths_KBps[index];
+	constraint->dcn5.min_available_non_urgent_bandwidth_KBps = table->sop_min_available_non_urgent_bandwidths_KBps[index];
+
 	constraint->dcn5.min_sop_index = index;
 }
 
@@ -134,6 +136,9 @@ static void dml2_utm_soc_bb_dcn6_build_sop_table(struct dml2_sop_table *table,
 		table->sop_min_available_urgent_bandwidths_KBps[i] = (uint32_t) math_floor(
 				total_available_bandwidth.urgent_bandwidth_KBps
 				* (utm_soc_bb->qos_model.dchub_v2->min_urgent_utm_budget_percent / 100.0));
+		table->sop_min_available_non_urgent_bandwidths_KBps[i] = (uint32_t)math_floor(
+			total_available_bandwidth.nominal_bandwidth_KBps
+			* (utm_soc_bb->qos_model.dchub_v2->min_nominal_utm_budget_percent / 100.0));
 	}
 
 	DML_ASSERT_MSG(table->model->sop_count > 0, "qos_model must contain at least 1 sop\n");
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
index 4289f7f998ff..077e4480575a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
@@ -87,6 +87,7 @@ struct dml2_sop_constraint {
 			struct dml2_memory_path_latency latency;
 			struct dml2_soc_operating_point clocks;
 			double min_available_urgent_bandwidth_KBps; // minimum guaranteed urgent bandwidth at active
+			double min_available_non_urgent_bandwidth_KBps; // minimum guaranteed nominal bandwidth at active
 		} dcn5;
 	};
 };
@@ -95,6 +96,7 @@ struct dml2_sop_table {
 	bool is_initialized;
 	const struct utm_qos_model *model;
 	uint32_t sop_min_available_urgent_bandwidths_KBps[MAX_UTM_SOP_COUNT];
+	uint32_t sop_min_available_non_urgent_bandwidths_KBps[MAX_UTM_SOP_COUNT];
 	uint32_t sop_optimal_dcfclks_khz[MAX_UTM_SOP_COUNT];
 	unsigned int (*get_highest_sop_index)(const struct dml2_sop_table *sop_table);
 	void (*get_sop_constraint_at_index)(const struct dml2_sop_table *sop_table, unsigned int index, struct dml2_sop_constraint *constraint);
-- 
2.43.0


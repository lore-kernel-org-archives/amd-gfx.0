Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CDF7C369BD
	for <amd-gfx@archiver.kernel.org>; Tue, 15 Apr 2025 14:59:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FE1110E7BC;
	Tue, 15 Apr 2025 14:59:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="AjMThES8";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2041.outbound.protection.outlook.com [40.107.243.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 202B810E7BC
 for <amd-gfx@lists.freedesktop.org>; Tue, 15 Apr 2025 14:59:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jvHGKMreUCutRrstW/3wVJObPihrc299wjBePGGlqrCn2b17bPBitvVC9fnc0u9pVMWuBHdWdQ/U3vOzEnMAwYzc3yCgoqV+0TqSSyAvPMOhHg2xTyMoBKHbAYmxTo9DoEDFPsmxzT5KMFWo8FI1lvYMpqyVGdUGBJ/G7YdYP7tWOprTKKHoQ7bqna4zWXc2FGXd6s1OQGHcqm4cIQBvE59Spg5Hup+bwYB7OHPiDR6jHtqcQnATMK1l/e+BTj6psUTp70k5TjKNZZ2Iv/96rBXCx7H1c8QRnS6tNPxVvJzGJWrtUFECkOvyskbrN8EMpGvbD3cQZGj/6HRIcDK2Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TiyuJ9YuYlVY+zz7bSBj9pJMkNd2ey0oqJ3HOfYebCg=;
 b=flhRSIp2cfLlfjUJ6r+r2eT0lnCGbzzW15tb/wayXNWw6ed54593RKwKNFdKSWtjMVmLam3ZUSDwTDWw626xueRM/cI33Ki4M+ugKSRxT7LexcwNsDul5eL3uHEg2DYAr67+POftb9RzPEBfiW45mK0eXtsK25iw7rRdTjElWP5NiepJ8GELAu/Efa7A6iWRk2WuEh3HN1sKTPN4rcM1B7f2LaHowc+7Sh04i+WNcU46+RtVW2qTonodL4FfaEQMNB4ElOaD8XC3/6J+/saSNsDecLNCbo/edIKH55eWm3Eqbv6h39TENJMOej+iGVGTiUMGkxQH9xPrxASKS5Z2hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TiyuJ9YuYlVY+zz7bSBj9pJMkNd2ey0oqJ3HOfYebCg=;
 b=AjMThES8EFxNZuq6j4SH2RwtdIN349E24Dd0tCwXFkq3ikHjvNPwHMTcvted4WbGme1sObXAJv1Ww20a88wBavRGaNFvDUxeGBPEynoBIicFhxjMqeuRGoEAlCmkz/Lke3oXm2u+vf3vBCwe5/S6U7HTIcddd6QK0pOTRoYWY7g=
Received: from DS7PR03CA0027.namprd03.prod.outlook.com (2603:10b6:5:3b8::32)
 by DM4PR12MB9736.namprd12.prod.outlook.com (2603:10b6:8:225::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.32; Tue, 15 Apr
 2025 14:59:39 +0000
Received: from SA2PEPF000015C8.namprd03.prod.outlook.com
 (2603:10b6:5:3b8:cafe::e0) by DS7PR03CA0027.outlook.office365.com
 (2603:10b6:5:3b8::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Tue,
 15 Apr 2025 14:59:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C8.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Tue, 15 Apr 2025 14:59:39 +0000
Received: from mkmmarleung05.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 15 Apr
 2025 09:59:36 -0500
From: Zaeem Mohamed <zaeem.mohamed@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Austin
 Zheng <Austin.Zheng@amd.com>
Subject: [PATCH 05/22] drm/amd/display: Move Mode Support Prefetch Checks To
 Its Own Function
Date: Tue, 15 Apr 2025 10:58:51 -0400
Message-ID: <20250415145908.3790253-6-zaeem.mohamed@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
References: <20250415145908.3790253-1-zaeem.mohamed@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C8:EE_|DM4PR12MB9736:EE_
X-MS-Office365-Filtering-Correlation-Id: 524a205c-81b4-4b26-d26f-08dd7c2e257a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|30052699003|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QVGaWdhi/YSL02Qh3AI22C7lZsPN4MqxMhMCMYJmAy+iJgogSAXyccXuv9rs?=
 =?us-ascii?Q?ZvYpm3BqVaqFiQ7HIQqOX7di9bu/5Qswcg3ee9KPRW6KaIGBUrJByXcoQf8T?=
 =?us-ascii?Q?nbQny8+wFVSRTuTf1h53kgPcMl5aHqZYFnLVcaA5C+7zq48IdE2TQd5W445P?=
 =?us-ascii?Q?l4+Dsz3O3i65wk2qrvlVQoJCsKd3WnnH1TZALlbwiDmgD2/Hdz3Z1JE05u81?=
 =?us-ascii?Q?NjdCASrnoINGzQg7nRdeb4pqnNd0Y5Q5iuV0CD4YgQHKWmINfzSGW33YOa8Y?=
 =?us-ascii?Q?o9QMYUdrevKNVtAHx3t6XyKj8zZiOpL+j/Us4mY2GfnW+L9IKhE75IMbDhLO?=
 =?us-ascii?Q?qxAP8tPDrwAtRfPODMMtx84uHeUPdpjneibi6Zp/tIOXaRZ48x0xe9KOLqeE?=
 =?us-ascii?Q?EU273lg7a/8YD0pslsiKYEa0RAinkn8bpmAHzARstiWOyhikHdeq7Y6ZRbgh?=
 =?us-ascii?Q?CPoMrTJ1UbhHp8kilNHCsPkkgfnGo8Eu5JA7KKuiM5Rn7xHEJAJJJ6fgjsg9?=
 =?us-ascii?Q?2xrlmc2kdhYgEMP4KuFnjwsTsEE2AzxZoo6ZkyUkTabmSs2DRIfFf0k1si7O?=
 =?us-ascii?Q?cU0NgBi5uBFbEq0RpFHwSXDZctZfTN6/xWdoDYFnKa9Y0gP1YNwOHDnl4aop?=
 =?us-ascii?Q?kDwmHQXXNj/w76gDplZZpQf66MIADU+lrUmROgW2rq5a6AYElypITbB5PqSq?=
 =?us-ascii?Q?tQxjZI9AVhy8fV7rEytB+G8xkgkQMHOntmqNi44y+dVMW4HXHNtYqB7gHEuA?=
 =?us-ascii?Q?2HO3CI6RvVR7XRMZSa0n1Ox7XCQD061Jvplj27jr1hqdR+y1mkvOmrt1Mw8h?=
 =?us-ascii?Q?776MBa6o2DEuC+VtG1JUpoRBa44HZfxB6dKeDbdhd2/uqsNucVJdir9Sy5/r?=
 =?us-ascii?Q?kSJLPqscai/TRqeYgpxlrSFyWoPX5aPHKYJqqAwUmUfnISKYvE/jTMygJDJr?=
 =?us-ascii?Q?6+URfjAId3djMb4iA80VyeTEiLmT6x11RS6jSLxLzZcdKwLKNTKjAHSDEetF?=
 =?us-ascii?Q?nGjLGoP5GI+ycxAqMCw3zSa7Wrnxab1cLbGKPeInPERM8GFsYUz63NRkFWpi?=
 =?us-ascii?Q?HcSKIKo9ebdzmMMjBdhIKhfo7wv5J+A/Ryav1NhQpe3UAPh93B7SzQPBMYLY?=
 =?us-ascii?Q?xtghfkiqqFDub3vE5kkVwMxpkYlqribrwziC5iCbjlrGEFQaAxf5RM8njBQy?=
 =?us-ascii?Q?1OvJk9j4oxH9XSSAdiS9McHunK8PkMRr19KHRssfFJP1maVI4YpWbzmmQz0x?=
 =?us-ascii?Q?5TiSl+bugIZW9BuKH4xMR/xW998DyqYIyjCTfCR8f5y63zjO4AVPtMc8aRz7?=
 =?us-ascii?Q?29eSSyoPW3HtwNl/jtqZnwZG6q6G+EXT5mk1SUW5le0ZI1KcTX8eBNHp+n0F?=
 =?us-ascii?Q?TAj+Rsa5lJjyYqR3RmSZxi8tWkcMfuNK2G245OLlNHAgj2K7LOZE2H0t7ou8?=
 =?us-ascii?Q?bwUn0ZEHuio3mteTfnslWPOGORi+NuEtMS2qk4zQoJLAyfwtkUrWynK6mWFz?=
 =?us-ascii?Q?tFEQHW8G2bc0cTChvL9zUUeEwnR1Gi5JrZWG?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(30052699003)(82310400026);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 14:59:39.4999 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 524a205c-81b4-4b26-d26f-08dd7c2e257a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015C8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB9736
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

[Why]
Large stack size observed in DCN4 mode support when compiling with clang.
Additional instrumentation added by compiler adds to stack size.
dml_core_mode_support ends up going over the stack size limit
due to the size of the function.

[How]
Move checks and calculations for prefetch to its own function.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Austin Zheng <Austin.Zheng@amd.com>
Signed-off-by: Zaeem Mohamed <zaeem.mohamed@amd.com>
---
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 1277 +++++++++--------
 1 file changed, 642 insertions(+), 635 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index a27409464616..6f71b7221384 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -7264,6 +7264,647 @@ static void calculate_pstate_keepout_dst_lines(
 	}
 }
 
+static noinline_for_stack void dml_core_ms_prefetch_check(struct dml2_core_internal_display_mode_lib *mode_lib,
+	const struct dml2_display_cfg *display_cfg)
+{
+	struct dml2_core_calcs_mode_support_locals *s = &mode_lib->scratch.dml_core_mode_support_locals;
+	struct dml2_core_calcs_calculate_tdlut_setting_params *calculate_tdlut_setting_params = &mode_lib->scratch.calculate_tdlut_setting_params;
+	struct dml2_core_calcs_CalculatePrefetchSchedule_params *CalculatePrefetchSchedule_params = &mode_lib->scratch.CalculatePrefetchSchedule_params;
+	struct dml2_core_calcs_calculate_peak_bandwidth_required_params *calculate_peak_bandwidth_params = &mode_lib->scratch.calculate_peak_bandwidth_params;
+#ifdef DML_GLOBAL_PREFETCH_CHECK
+	struct dml2_core_calcs_CheckGlobalPrefetchAdmissibility_params *CheckGlobalPrefetchAdmissibility_params = &mode_lib->scratch.CheckGlobalPrefetchAdmissibility_params;
+#endif
+	struct dml2_core_calcs_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport_params *CalculateWatermarks_params = &mode_lib->scratch.CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport_params;
+
+	double min_return_bw_for_latency;
+	unsigned int k;
+
+	mode_lib->ms.TimeCalc = 24 / mode_lib->ms.dcfclk_deepsleep;
+
+	calculate_hostvm_inefficiency_factor(
+			&s->HostVMInefficiencyFactor,
+			&s->HostVMInefficiencyFactorPrefetch,
+
+			display_cfg->gpuvm_enable,
+			display_cfg->hostvm_enable,
+			mode_lib->ip.remote_iommu_outstanding_translations,
+			mode_lib->soc.max_outstanding_reqs,
+			mode_lib->ms.support.urg_bandwidth_available_pixel_and_vm[dml2_core_internal_soc_state_sys_active],
+			mode_lib->ms.support.urg_bandwidth_available_vm_only[dml2_core_internal_soc_state_sys_active]);
+
+	mode_lib->ms.Total3dlutActive = 0;
+	for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+		if (display_cfg->plane_descriptors[k].tdlut.setup_for_tdlut)
+			mode_lib->ms.Total3dlutActive = mode_lib->ms.Total3dlutActive + 1;
+
+		// Calculate tdlut schedule related terms
+		calculate_tdlut_setting_params->dispclk_mhz = mode_lib->ms.RequiredDISPCLK;
+		calculate_tdlut_setting_params->setup_for_tdlut = display_cfg->plane_descriptors[k].tdlut.setup_for_tdlut;
+		calculate_tdlut_setting_params->tdlut_width_mode = display_cfg->plane_descriptors[k].tdlut.tdlut_width_mode;
+		calculate_tdlut_setting_params->tdlut_addressing_mode = display_cfg->plane_descriptors[k].tdlut.tdlut_addressing_mode;
+		calculate_tdlut_setting_params->cursor_buffer_size = mode_lib->ip.cursor_buffer_size;
+		calculate_tdlut_setting_params->gpuvm_enable = display_cfg->gpuvm_enable;
+		calculate_tdlut_setting_params->gpuvm_page_size_kbytes = display_cfg->plane_descriptors[k].overrides.gpuvm_min_page_size_kbytes;
+		calculate_tdlut_setting_params->tdlut_mpc_width_flag = display_cfg->plane_descriptors[k].tdlut.tdlut_mpc_width_flag;
+		calculate_tdlut_setting_params->is_gfx11 = dml_get_gfx_version(display_cfg->plane_descriptors[k].surface.tiling);
+
+		// output
+		calculate_tdlut_setting_params->tdlut_pte_bytes_per_frame = &s->tdlut_pte_bytes_per_frame[k];
+		calculate_tdlut_setting_params->tdlut_bytes_per_frame = &s->tdlut_bytes_per_frame[k];
+		calculate_tdlut_setting_params->tdlut_groups_per_2row_ub = &s->tdlut_groups_per_2row_ub[k];
+		calculate_tdlut_setting_params->tdlut_opt_time = &s->tdlut_opt_time[k];
+		calculate_tdlut_setting_params->tdlut_drain_time = &s->tdlut_drain_time[k];
+		calculate_tdlut_setting_params->tdlut_bytes_to_deliver = &s->tdlut_bytes_to_deliver[k];
+		calculate_tdlut_setting_params->tdlut_bytes_per_group = &s->tdlut_bytes_per_group[k];
+
+		calculate_tdlut_setting(&mode_lib->scratch, calculate_tdlut_setting_params);
+	}
+
+	min_return_bw_for_latency = mode_lib->ms.support.urg_bandwidth_available_min_latency[dml2_core_internal_soc_state_sys_active];
+
+	if (mode_lib->soc.qos_parameters.qos_type == dml2_qos_param_type_dcn3)
+		s->ReorderingBytes = (unsigned int)(mode_lib->soc.clk_table.dram_config.channel_count * math_max3(mode_lib->soc.qos_parameters.qos_params.dcn32x.urgent_out_of_order_return_per_channel_pixel_only_bytes,
+										mode_lib->soc.qos_parameters.qos_params.dcn32x.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes,
+										mode_lib->soc.qos_parameters.qos_params.dcn32x.urgent_out_of_order_return_per_channel_vm_only_bytes));
+
+	CalculateExtraLatency(
+		display_cfg,
+		mode_lib->ip.rob_buffer_size_kbytes,
+		mode_lib->soc.qos_parameters.qos_params.dcn32x.loaded_round_trip_latency_fclk_cycles,
+		s->ReorderingBytes,
+		mode_lib->ms.DCFCLK,
+		mode_lib->ms.FabricClock,
+		mode_lib->ip.pixel_chunk_size_kbytes,
+		min_return_bw_for_latency,
+		mode_lib->ms.num_active_planes,
+		mode_lib->ms.NoOfDPP,
+		mode_lib->ms.dpte_group_bytes,
+		s->tdlut_bytes_per_group,
+		s->HostVMInefficiencyFactor,
+		s->HostVMInefficiencyFactorPrefetch,
+		mode_lib->soc.hostvm_min_page_size_kbytes,
+		mode_lib->soc.qos_parameters.qos_type,
+		!(display_cfg->overrides.max_outstanding_when_urgent_expected_disable),
+		mode_lib->soc.max_outstanding_reqs,
+		mode_lib->ms.support.request_size_bytes_luma,
+		mode_lib->ms.support.request_size_bytes_chroma,
+		mode_lib->ip.meta_chunk_size_kbytes,
+		mode_lib->ip.dchub_arb_to_ret_delay,
+		mode_lib->ms.TripToMemory,
+		mode_lib->ip.hostvm_mode,
+
+		// output
+		&mode_lib->ms.ExtraLatency,
+		&mode_lib->ms.ExtraLatency_sr,
+		&mode_lib->ms.ExtraLatencyPrefetch);
+
+	for (k = 0; k < mode_lib->ms.num_active_planes; k++)
+		s->impacted_dst_y_pre[k] = 0;
+
+	s->recalc_prefetch_schedule = 0;
+	s->recalc_prefetch_done = 0;
+	do {
+		mode_lib->ms.support.PrefetchSupported = true;
+
+		for (k = 0; k < mode_lib->ms.num_active_planes; k++) {
+			s->line_times[k] = display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_total / ((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.pixel_clock_khz / 1000);
+			s->pixel_format[k] = display_cfg->plane_descriptors[k].pixel_format;
+
+			s->lb_source_lines_l[k] = get_num_lb_source_lines(mode_lib->ip.max_line_buffer_lines, mode_lib->ip.line_buffer_size_bits,
+																mode_lib->ms.NoOfDPP[k],
+																display_cfg->plane_descriptors[k].composition.viewport.plane0.width,
+																display_cfg->plane_descriptors[k].composition.viewport.plane0.height,
+																display_cfg->plane_descriptors[k].composition.scaler_info.plane0.h_ratio,
+																display_cfg->plane_descriptors[k].composition.rotation_angle);
+
+			s->lb_source_lines_c[k] = get_num_lb_source_lines(mode_lib->ip.max_line_buffer_lines, mode_lib->ip.line_buffer_size_bits,
+																mode_lib->ms.NoOfDPP[k],
+																display_cfg->plane_descriptors[k].composition.viewport.plane1.width,
+																display_cfg->plane_descriptors[k].composition.viewport.plane1.height,
+																display_cfg->plane_descriptors[k].composition.scaler_info.plane1.h_ratio,
+																display_cfg->plane_descriptors[k].composition.rotation_angle);
+
+			struct dml2_core_internal_DmlPipe *myPipe = &s->myPipe;
+
+			mode_lib->ms.TWait[k] = CalculateTWait(
+				display_cfg->plane_descriptors[k].overrides.reserved_vblank_time_ns,
+				mode_lib->ms.UrgLatency,
+				mode_lib->ms.TripToMemory,
+				!dml_is_phantom_pipe(&display_cfg->plane_descriptors[k]) && display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.drr_config.enabled ?
+				get_g6_temp_read_blackout_us(&mode_lib->soc, (unsigned int)(mode_lib->ms.uclk_freq_mhz * 1000), mode_lib->ms.state_idx) : 0.0);
+
+			myPipe->Dppclk = mode_lib->ms.RequiredDPPCLK[k];
+			myPipe->Dispclk = mode_lib->ms.RequiredDISPCLK;
+			myPipe->PixelClock = ((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.pixel_clock_khz / 1000);
+			myPipe->DCFClkDeepSleep = mode_lib->ms.dcfclk_deepsleep;
+			myPipe->DPPPerSurface = mode_lib->ms.NoOfDPP[k];
+			myPipe->ScalerEnabled = display_cfg->plane_descriptors[k].composition.scaler_info.enabled;
+			myPipe->VRatio = display_cfg->plane_descriptors[k].composition.scaler_info.plane0.v_ratio;
+			myPipe->VRatioChroma = display_cfg->plane_descriptors[k].composition.scaler_info.plane1.v_ratio;
+			myPipe->VTaps = display_cfg->plane_descriptors[k].composition.scaler_info.plane0.v_taps;
+			myPipe->VTapsChroma = display_cfg->plane_descriptors[k].composition.scaler_info.plane1.v_taps;
+			myPipe->RotationAngle = display_cfg->plane_descriptors[k].composition.rotation_angle;
+			myPipe->mirrored = display_cfg->plane_descriptors[k].composition.mirrored;
+			myPipe->BlockWidth256BytesY = mode_lib->ms.Read256BlockWidthY[k];
+			myPipe->BlockHeight256BytesY = mode_lib->ms.Read256BlockHeightY[k];
+			myPipe->BlockWidth256BytesC = mode_lib->ms.Read256BlockWidthC[k];
+			myPipe->BlockHeight256BytesC = mode_lib->ms.Read256BlockHeightC[k];
+			myPipe->InterlaceEnable = display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.interlaced;
+			myPipe->NumberOfCursors = display_cfg->plane_descriptors[k].cursor.num_cursors;
+			myPipe->VBlank = display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.v_total - display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.v_active;
+			myPipe->HTotal = display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_total;
+			myPipe->HActive = display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_active;
+			myPipe->DCCEnable = display_cfg->plane_descriptors[k].surface.dcc.enable;
+			myPipe->ODMMode = mode_lib->ms.ODMMode[k];
+			myPipe->SourcePixelFormat = display_cfg->plane_descriptors[k].pixel_format;
+			myPipe->BytePerPixelY = mode_lib->ms.BytePerPixelY[k];
+			myPipe->BytePerPixelC = mode_lib->ms.BytePerPixelC[k];
+			myPipe->ProgressiveToInterlaceUnitInOPP = mode_lib->ip.ptoi_supported;
+
+#ifdef __DML_VBA_DEBUG__
+			DML_LOG_VERBOSE("DML::%s: Calling CalculatePrefetchSchedule for k=%u\n", __func__, k);
+			DML_LOG_VERBOSE("DML::%s: MaximumVStartup = %u\n", __func__, s->MaximumVStartup[k]);
+#endif
+			CalculatePrefetchSchedule_params->display_cfg = display_cfg;
+			CalculatePrefetchSchedule_params->HostVMInefficiencyFactor = s->HostVMInefficiencyFactorPrefetch;
+			CalculatePrefetchSchedule_params->myPipe = myPipe;
+			CalculatePrefetchSchedule_params->DSCDelay = mode_lib->ms.DSCDelay[k];
+			CalculatePrefetchSchedule_params->DPPCLKDelaySubtotalPlusCNVCFormater = mode_lib->ip.dppclk_delay_subtotal + mode_lib->ip.dppclk_delay_cnvc_formatter;
+			CalculatePrefetchSchedule_params->DPPCLKDelaySCL = mode_lib->ip.dppclk_delay_scl;
+			CalculatePrefetchSchedule_params->DPPCLKDelaySCLLBOnly = mode_lib->ip.dppclk_delay_scl_lb_only;
+			CalculatePrefetchSchedule_params->DPPCLKDelayCNVCCursor = mode_lib->ip.dppclk_delay_cnvc_cursor;
+			CalculatePrefetchSchedule_params->DISPCLKDelaySubtotal = mode_lib->ip.dispclk_delay_subtotal;
+			CalculatePrefetchSchedule_params->DPP_RECOUT_WIDTH = (unsigned int)(mode_lib->ms.SwathWidthY[k] / display_cfg->plane_descriptors[k].composition.scaler_info.plane0.h_ratio);
+			CalculatePrefetchSchedule_params->OutputFormat = display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].output.output_format;
+			CalculatePrefetchSchedule_params->MaxInterDCNTileRepeaters = mode_lib->ip.max_inter_dcn_tile_repeaters;
+			CalculatePrefetchSchedule_params->VStartup = s->MaximumVStartup[k];
+			CalculatePrefetchSchedule_params->HostVMMinPageSize = mode_lib->soc.hostvm_min_page_size_kbytes;
+			CalculatePrefetchSchedule_params->DynamicMetadataEnable = display_cfg->plane_descriptors[k].dynamic_meta_data.enable;
+			CalculatePrefetchSchedule_params->DynamicMetadataVMEnabled = mode_lib->ip.dynamic_metadata_vm_enabled;
+			CalculatePrefetchSchedule_params->DynamicMetadataLinesBeforeActiveRequired = display_cfg->plane_descriptors[k].dynamic_meta_data.lines_before_active_required;
+			CalculatePrefetchSchedule_params->DynamicMetadataTransmittedBytes = display_cfg->plane_descriptors[k].dynamic_meta_data.transmitted_bytes;
+			CalculatePrefetchSchedule_params->UrgentLatency = mode_lib->ms.UrgLatency;
+			CalculatePrefetchSchedule_params->ExtraLatencyPrefetch = mode_lib->ms.ExtraLatencyPrefetch;
+			CalculatePrefetchSchedule_params->TCalc = mode_lib->ms.TimeCalc;
+			CalculatePrefetchSchedule_params->vm_bytes = mode_lib->ms.vm_bytes[k];
+			CalculatePrefetchSchedule_params->PixelPTEBytesPerRow = mode_lib->ms.DPTEBytesPerRow[k];
+			CalculatePrefetchSchedule_params->PrefetchSourceLinesY = mode_lib->ms.PrefetchLinesY[k];
+			CalculatePrefetchSchedule_params->VInitPreFillY = mode_lib->ms.PrefillY[k];
+			CalculatePrefetchSchedule_params->MaxNumSwathY = mode_lib->ms.MaxNumSwathY[k];
+			CalculatePrefetchSchedule_params->PrefetchSourceLinesC = mode_lib->ms.PrefetchLinesC[k];
+			CalculatePrefetchSchedule_params->VInitPreFillC = mode_lib->ms.PrefillC[k];
+			CalculatePrefetchSchedule_params->MaxNumSwathC = mode_lib->ms.MaxNumSwathC[k];
+			CalculatePrefetchSchedule_params->swath_width_luma_ub = mode_lib->ms.swath_width_luma_ub[k];
+			CalculatePrefetchSchedule_params->swath_width_chroma_ub = mode_lib->ms.swath_width_chroma_ub[k];
+			CalculatePrefetchSchedule_params->SwathHeightY = mode_lib->ms.SwathHeightY[k];
+			CalculatePrefetchSchedule_params->SwathHeightC = mode_lib->ms.SwathHeightC[k];
+			CalculatePrefetchSchedule_params->TWait = mode_lib->ms.TWait[k];
+			CalculatePrefetchSchedule_params->Ttrip = mode_lib->ms.TripToMemory;
+			CalculatePrefetchSchedule_params->Turg = mode_lib->ms.UrgLatency;
+			CalculatePrefetchSchedule_params->setup_for_tdlut = display_cfg->plane_descriptors[k].tdlut.setup_for_tdlut;
+			CalculatePrefetchSchedule_params->tdlut_pte_bytes_per_frame = s->tdlut_pte_bytes_per_frame[k];
+			CalculatePrefetchSchedule_params->tdlut_bytes_per_frame = s->tdlut_bytes_per_frame[k];
+			CalculatePrefetchSchedule_params->tdlut_opt_time = s->tdlut_opt_time[k];
+			CalculatePrefetchSchedule_params->tdlut_drain_time = s->tdlut_drain_time[k];
+			CalculatePrefetchSchedule_params->num_cursors = (display_cfg->plane_descriptors[k].cursor.cursor_width > 0);
+			CalculatePrefetchSchedule_params->cursor_bytes_per_chunk = s->cursor_bytes_per_chunk[k];
+			CalculatePrefetchSchedule_params->cursor_bytes_per_line = s->cursor_bytes_per_line[k];
+			CalculatePrefetchSchedule_params->dcc_enable = display_cfg->plane_descriptors[k].surface.dcc.enable;
+			CalculatePrefetchSchedule_params->mrq_present = mode_lib->ip.dcn_mrq_present;
+			CalculatePrefetchSchedule_params->meta_row_bytes = mode_lib->ms.meta_row_bytes[k];
+			CalculatePrefetchSchedule_params->mall_prefetch_sdp_overhead_factor = mode_lib->ms.mall_prefetch_sdp_overhead_factor[k];
+			CalculatePrefetchSchedule_params->impacted_dst_y_pre = s->impacted_dst_y_pre[k];
+			CalculatePrefetchSchedule_params->vactive_sw_bw_l = mode_lib->ms.vactive_sw_bw_l[k];
+			CalculatePrefetchSchedule_params->vactive_sw_bw_c = mode_lib->ms.vactive_sw_bw_c[k];
+
+			// output
+			CalculatePrefetchSchedule_params->DSTXAfterScaler = &s->DSTXAfterScaler[k];
+			CalculatePrefetchSchedule_params->DSTYAfterScaler = &s->DSTYAfterScaler[k];
+			CalculatePrefetchSchedule_params->dst_y_prefetch = &mode_lib->ms.dst_y_prefetch[k];
+			CalculatePrefetchSchedule_params->dst_y_per_vm_vblank = &mode_lib->ms.LinesForVM[k];
+			CalculatePrefetchSchedule_params->dst_y_per_row_vblank = &mode_lib->ms.LinesForDPTERow[k];
+			CalculatePrefetchSchedule_params->VRatioPrefetchY = &mode_lib->ms.VRatioPreY[k];
+			CalculatePrefetchSchedule_params->VRatioPrefetchC = &mode_lib->ms.VRatioPreC[k];
+			CalculatePrefetchSchedule_params->RequiredPrefetchPixelDataBWLuma = &mode_lib->ms.RequiredPrefetchPixelDataBWLuma[k]; // prefetch_sw_bw_l
+			CalculatePrefetchSchedule_params->RequiredPrefetchPixelDataBWChroma = &mode_lib->ms.RequiredPrefetchPixelDataBWChroma[k]; // prefetch_sw_bw_c
+			CalculatePrefetchSchedule_params->RequiredPrefetchBWOTO = &mode_lib->ms.RequiredPrefetchBWOTO[k];
+			CalculatePrefetchSchedule_params->NotEnoughTimeForDynamicMetadata = &mode_lib->ms.NoTimeForDynamicMetadata[k];
+			CalculatePrefetchSchedule_params->Tno_bw = &mode_lib->ms.Tno_bw[k];
+			CalculatePrefetchSchedule_params->Tno_bw_flip = &mode_lib->ms.Tno_bw_flip[k];
+			CalculatePrefetchSchedule_params->prefetch_vmrow_bw = &mode_lib->ms.prefetch_vmrow_bw[k];
+			CalculatePrefetchSchedule_params->Tdmdl_vm = &s->dummy_single[0];
+			CalculatePrefetchSchedule_params->Tdmdl = &s->dummy_single[1];
+			CalculatePrefetchSchedule_params->TSetup = &s->dummy_single[2];
+			CalculatePrefetchSchedule_params->Tvm_trips = &s->Tvm_trips[k];
+			CalculatePrefetchSchedule_params->Tr0_trips = &s->Tr0_trips[k];
+			CalculatePrefetchSchedule_params->Tvm_trips_flip = &s->Tvm_trips_flip[k];
+			CalculatePrefetchSchedule_params->Tr0_trips_flip = &s->Tr0_trips_flip[k];
+			CalculatePrefetchSchedule_params->Tvm_trips_flip_rounded = &s->Tvm_trips_flip_rounded[k];
+			CalculatePrefetchSchedule_params->Tr0_trips_flip_rounded = &s->Tr0_trips_flip_rounded[k];
+			CalculatePrefetchSchedule_params->VUpdateOffsetPix = &s->dummy_integer[0];
+			CalculatePrefetchSchedule_params->VUpdateWidthPix = &s->dummy_integer[1];
+			CalculatePrefetchSchedule_params->VReadyOffsetPix = &s->dummy_integer[2];
+			CalculatePrefetchSchedule_params->prefetch_cursor_bw = &mode_lib->ms.prefetch_cursor_bw[k];
+			CalculatePrefetchSchedule_params->prefetch_sw_bytes = &s->prefetch_sw_bytes[k];
+			CalculatePrefetchSchedule_params->Tpre_rounded = &s->Tpre_rounded[k];
+			CalculatePrefetchSchedule_params->Tpre_oto = &s->Tpre_oto[k];
+			CalculatePrefetchSchedule_params->prefetch_swath_time_us = &s->prefetch_swath_time_us[k];
+
+			mode_lib->ms.NoTimeForPrefetch[k] = CalculatePrefetchSchedule(&mode_lib->scratch, CalculatePrefetchSchedule_params);
+
+			mode_lib->ms.support.PrefetchSupported &= !mode_lib->ms.NoTimeForPrefetch[k];
+			DML_LOG_VERBOSE("DML::%s: k=%d, dst_y_per_vm_vblank = %f\n", __func__, k, *CalculatePrefetchSchedule_params->dst_y_per_vm_vblank);
+			DML_LOG_VERBOSE("DML::%s: k=%d, dst_y_per_row_vblank = %f\n", __func__, k, *CalculatePrefetchSchedule_params->dst_y_per_row_vblank);
+		} // for k num_planes
+
+		CalculateDCFCLKDeepSleepTdlut(
+			display_cfg,
+			mode_lib->ms.num_active_planes,
+			mode_lib->ms.BytePerPixelY,
+			mode_lib->ms.BytePerPixelC,
+			mode_lib->ms.SwathWidthY,
+			mode_lib->ms.SwathWidthC,
+			mode_lib->ms.NoOfDPP,
+			mode_lib->ms.PSCL_FACTOR,
+			mode_lib->ms.PSCL_FACTOR_CHROMA,
+			mode_lib->ms.RequiredDPPCLK,
+			mode_lib->ms.vactive_sw_bw_l,
+			mode_lib->ms.vactive_sw_bw_c,
+			mode_lib->soc.return_bus_width_bytes,
+			mode_lib->ms.RequiredDISPCLK,
+			s->tdlut_bytes_to_deliver,
+			s->prefetch_swath_time_us,
+
+			/* Output */
+			&mode_lib->ms.dcfclk_deepsleep);
+
+		for (k = 0; k < mode_lib->ms.num_active_planes; k++) {
+			if (mode_lib->ms.dst_y_prefetch[k] < 2.0
+				|| mode_lib->ms.LinesForVM[k] >= 32.0
+				|| mode_lib->ms.LinesForDPTERow[k] >= 16.0
+				|| mode_lib->ms.NoTimeForPrefetch[k] == true
+				|| s->DSTYAfterScaler[k] > 8) {
+				mode_lib->ms.support.PrefetchSupported = false;
+				DML_LOG_VERBOSE("DML::%s: k=%d, dst_y_prefetch=%f (should not be < 2)\n", __func__, k, mode_lib->ms.dst_y_prefetch[k]);
+				DML_LOG_VERBOSE("DML::%s: k=%d, LinesForVM=%f (should not be >= 32)\n", __func__, k, mode_lib->ms.LinesForVM[k]);
+				DML_LOG_VERBOSE("DML::%s: k=%d, LinesForDPTERow=%f (should not be >= 16)\n", __func__, k, mode_lib->ms.LinesForDPTERow[k]);
+				DML_LOG_VERBOSE("DML::%s: k=%d, DSTYAfterScaler=%d (should be <= 8)\n", __func__, k, s->DSTYAfterScaler[k]);
+				DML_LOG_VERBOSE("DML::%s: k=%d, NoTimeForPrefetch=%d\n", __func__, k, mode_lib->ms.NoTimeForPrefetch[k]);
+			}
+		}
+
+		mode_lib->ms.support.DynamicMetadataSupported = true;
+		for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
+			if (mode_lib->ms.NoTimeForDynamicMetadata[k] == true) {
+				mode_lib->ms.support.DynamicMetadataSupported = false;
+			}
+		}
+
+		mode_lib->ms.support.VRatioInPrefetchSupported = true;
+		for (k = 0; k < mode_lib->ms.num_active_planes; k++) {
+			if (mode_lib->ms.VRatioPreY[k] > __DML2_CALCS_MAX_VRATIO_PRE__ ||
+				mode_lib->ms.VRatioPreC[k] > __DML2_CALCS_MAX_VRATIO_PRE__) {
+				mode_lib->ms.support.VRatioInPrefetchSupported = false;
+				DML_LOG_VERBOSE("DML::%s: k=%d VRatioPreY = %f (should be <= %f)\n", __func__, k, mode_lib->ms.VRatioPreY[k], __DML2_CALCS_MAX_VRATIO_PRE__);
+				DML_LOG_VERBOSE("DML::%s: k=%d VRatioPreC = %f (should be <= %f)\n", __func__, k, mode_lib->ms.VRatioPreC[k], __DML2_CALCS_MAX_VRATIO_PRE__);
+				DML_LOG_VERBOSE("DML::%s: VRatioInPrefetchSupported = %u\n", __func__, mode_lib->ms.support.VRatioInPrefetchSupported);
+			}
+		}
+
+		mode_lib->ms.support.PrefetchSupported &= mode_lib->ms.support.VRatioInPrefetchSupported;
+
+		// By default, do not recalc prefetch schedule
+		s->recalc_prefetch_schedule = 0;
+
+		// Only do urg vs prefetch bandwidth check, flip schedule check, power saving feature support check IF the Prefetch Schedule Check is ok
+		if (mode_lib->ms.support.PrefetchSupported) {
+			for (k = 0; k < mode_lib->ms.num_active_planes; k++) {
+				// Calculate Urgent burst factor for prefetch
+#ifdef __DML_VBA_DEBUG__
+				DML_LOG_VERBOSE("DML::%s: k=%d, Calling CalculateUrgentBurstFactor (for prefetch)\n", __func__, k);
+				DML_LOG_VERBOSE("DML::%s: k=%d, VRatioPreY=%f\n", __func__, k, mode_lib->ms.VRatioPreY[k]);
+				DML_LOG_VERBOSE("DML::%s: k=%d, VRatioPreC=%f\n", __func__, k, mode_lib->ms.VRatioPreC[k]);
+#endif
+				CalculateUrgentBurstFactor(
+					&display_cfg->plane_descriptors[k],
+					mode_lib->ms.swath_width_luma_ub[k],
+					mode_lib->ms.swath_width_chroma_ub[k],
+					mode_lib->ms.SwathHeightY[k],
+					mode_lib->ms.SwathHeightC[k],
+					s->line_times[k],
+					mode_lib->ms.UrgLatency,
+					mode_lib->ms.VRatioPreY[k],
+					mode_lib->ms.VRatioPreC[k],
+					mode_lib->ms.BytePerPixelInDETY[k],
+					mode_lib->ms.BytePerPixelInDETC[k],
+					mode_lib->ms.DETBufferSizeY[k],
+					mode_lib->ms.DETBufferSizeC[k],
+					/* Output */
+					&mode_lib->ms.UrgentBurstFactorLumaPre[k],
+					&mode_lib->ms.UrgentBurstFactorChromaPre[k],
+					&mode_lib->ms.NotEnoughUrgentLatencyHidingPre[k]);
+			}
+
+			// Calculate urgent bandwidth required, both urg and non urg peak bandwidth
+			// assume flip bw is 0 at this point
+			for (k = 0; k < mode_lib->ms.num_active_planes; k++)
+				mode_lib->ms.final_flip_bw[k] = 0;
+
+			calculate_peak_bandwidth_params->urg_vactive_bandwidth_required = mode_lib->ms.support.urg_vactive_bandwidth_required;
+			calculate_peak_bandwidth_params->urg_bandwidth_required = mode_lib->ms.support.urg_bandwidth_required;
+			calculate_peak_bandwidth_params->urg_bandwidth_required_qual = mode_lib->ms.support.urg_bandwidth_required_qual;
+			calculate_peak_bandwidth_params->non_urg_bandwidth_required = mode_lib->ms.support.non_urg_bandwidth_required;
+			calculate_peak_bandwidth_params->surface_avg_vactive_required_bw = mode_lib->ms.surface_avg_vactive_required_bw;
+			calculate_peak_bandwidth_params->surface_peak_required_bw = mode_lib->ms.surface_peak_required_bw;
+
+			calculate_peak_bandwidth_params->display_cfg = display_cfg;
+			calculate_peak_bandwidth_params->inc_flip_bw = 0;
+			calculate_peak_bandwidth_params->num_active_planes =  mode_lib->ms.num_active_planes;
+			calculate_peak_bandwidth_params->num_of_dpp = mode_lib->ms.NoOfDPP;
+			calculate_peak_bandwidth_params->dcc_dram_bw_nom_overhead_factor_p0 = mode_lib->ms.dcc_dram_bw_nom_overhead_factor_p0;
+			calculate_peak_bandwidth_params->dcc_dram_bw_nom_overhead_factor_p1 = mode_lib->ms.dcc_dram_bw_nom_overhead_factor_p1;
+			calculate_peak_bandwidth_params->dcc_dram_bw_pref_overhead_factor_p0 = mode_lib->ms.dcc_dram_bw_pref_overhead_factor_p0;
+			calculate_peak_bandwidth_params->dcc_dram_bw_pref_overhead_factor_p1 = mode_lib->ms.dcc_dram_bw_pref_overhead_factor_p1;
+			calculate_peak_bandwidth_params->mall_prefetch_sdp_overhead_factor = mode_lib->ms.mall_prefetch_sdp_overhead_factor;
+			calculate_peak_bandwidth_params->mall_prefetch_dram_overhead_factor = mode_lib->ms.mall_prefetch_dram_overhead_factor;
+
+			calculate_peak_bandwidth_params->surface_read_bandwidth_l = mode_lib->ms.vactive_sw_bw_l;
+			calculate_peak_bandwidth_params->surface_read_bandwidth_c = mode_lib->ms.vactive_sw_bw_c;
+			calculate_peak_bandwidth_params->prefetch_bandwidth_l = mode_lib->ms.RequiredPrefetchPixelDataBWLuma;
+			calculate_peak_bandwidth_params->prefetch_bandwidth_c = mode_lib->ms.RequiredPrefetchPixelDataBWChroma;
+			calculate_peak_bandwidth_params->prefetch_bandwidth_oto = mode_lib->ms.RequiredPrefetchBWOTO;
+			calculate_peak_bandwidth_params->excess_vactive_fill_bw_l = mode_lib->ms.excess_vactive_fill_bw_l;
+			calculate_peak_bandwidth_params->excess_vactive_fill_bw_c = mode_lib->ms.excess_vactive_fill_bw_c;
+			calculate_peak_bandwidth_params->cursor_bw = mode_lib->ms.cursor_bw;
+			calculate_peak_bandwidth_params->dpte_row_bw = mode_lib->ms.dpte_row_bw;
+			calculate_peak_bandwidth_params->meta_row_bw = mode_lib->ms.meta_row_bw;
+			calculate_peak_bandwidth_params->prefetch_cursor_bw = mode_lib->ms.prefetch_cursor_bw;
+			calculate_peak_bandwidth_params->prefetch_vmrow_bw = mode_lib->ms.prefetch_vmrow_bw;
+			calculate_peak_bandwidth_params->flip_bw = mode_lib->ms.final_flip_bw;
+			calculate_peak_bandwidth_params->urgent_burst_factor_l = mode_lib->ms.UrgentBurstFactorLuma;
+			calculate_peak_bandwidth_params->urgent_burst_factor_c = mode_lib->ms.UrgentBurstFactorChroma;
+			calculate_peak_bandwidth_params->urgent_burst_factor_cursor = mode_lib->ms.UrgentBurstFactorCursor;
+			calculate_peak_bandwidth_params->urgent_burst_factor_prefetch_l = mode_lib->ms.UrgentBurstFactorLumaPre;
+			calculate_peak_bandwidth_params->urgent_burst_factor_prefetch_c = mode_lib->ms.UrgentBurstFactorChromaPre;
+			calculate_peak_bandwidth_params->urgent_burst_factor_prefetch_cursor = mode_lib->ms.UrgentBurstFactorCursorPre;
+
+			calculate_peak_bandwidth_required(
+					&mode_lib->scratch,
+					calculate_peak_bandwidth_params);
+
+			// Check urg peak bandwidth against available urg bw
+			// check at SDP and DRAM, for all soc states (SVP prefetch an Sys Active)
+			check_urgent_bandwidth_support(
+				&s->dummy_single[0], // double* frac_urg_bandwidth
+				&s->dummy_single[1], // double* frac_urg_bandwidth_mall
+				&mode_lib->ms.support.UrgVactiveBandwidthSupport,
+				&mode_lib->ms.support.PrefetchBandwidthSupported,
+
+				mode_lib->soc.mall_allocated_for_dcn_mbytes,
+				mode_lib->ms.support.non_urg_bandwidth_required,
+				mode_lib->ms.support.urg_vactive_bandwidth_required,
+				mode_lib->ms.support.urg_bandwidth_required,
+				mode_lib->ms.support.urg_bandwidth_available);
+
+			mode_lib->ms.support.PrefetchSupported &= mode_lib->ms.support.PrefetchBandwidthSupported;
+			DML_LOG_VERBOSE("DML::%s: PrefetchBandwidthSupported=%0d\n", __func__, mode_lib->ms.support.PrefetchBandwidthSupported);
+
+			for (k = 0; k < mode_lib->ms.num_active_planes; k++) {
+				if (mode_lib->ms.NotEnoughUrgentLatencyHidingPre[k]) {
+					mode_lib->ms.support.PrefetchSupported = false;
+					DML_LOG_VERBOSE("DML::%s: k=%d, NotEnoughUrgentLatencyHidingPre=%d\n", __func__, k, mode_lib->ms.NotEnoughUrgentLatencyHidingPre[k]);
+				}
+			}
+
+#ifdef DML_GLOBAL_PREFETCH_CHECK
+			if (mode_lib->ms.support.PrefetchSupported && mode_lib->ms.num_active_planes > 1 && s->recalc_prefetch_done == 0) {
+				CheckGlobalPrefetchAdmissibility_params->num_active_planes =  mode_lib->ms.num_active_planes;
+				CheckGlobalPrefetchAdmissibility_params->pixel_format = s->pixel_format;
+				CheckGlobalPrefetchAdmissibility_params->chunk_bytes_l = mode_lib->ip.pixel_chunk_size_kbytes * 1024;
+				CheckGlobalPrefetchAdmissibility_params->chunk_bytes_c = mode_lib->ip.pixel_chunk_size_kbytes * 1024;
+				CheckGlobalPrefetchAdmissibility_params->lb_source_lines_l = s->lb_source_lines_l;
+				CheckGlobalPrefetchAdmissibility_params->lb_source_lines_c = s->lb_source_lines_c;
+				CheckGlobalPrefetchAdmissibility_params->swath_height_l =  mode_lib->ms.SwathHeightY;
+				CheckGlobalPrefetchAdmissibility_params->swath_height_c =  mode_lib->ms.SwathHeightC;
+				CheckGlobalPrefetchAdmissibility_params->rob_buffer_size_kbytes = mode_lib->ip.rob_buffer_size_kbytes;
+				CheckGlobalPrefetchAdmissibility_params->compressed_buffer_size_kbytes = mode_lib->ms.CompressedBufferSizeInkByte;
+				CheckGlobalPrefetchAdmissibility_params->detile_buffer_size_bytes_l = mode_lib->ms.DETBufferSizeY;
+				CheckGlobalPrefetchAdmissibility_params->detile_buffer_size_bytes_c = mode_lib->ms.DETBufferSizeC;
+				CheckGlobalPrefetchAdmissibility_params->full_swath_bytes_l = s->full_swath_bytes_l;
+				CheckGlobalPrefetchAdmissibility_params->full_swath_bytes_c = s->full_swath_bytes_c;
+				CheckGlobalPrefetchAdmissibility_params->prefetch_sw_bytes = s->prefetch_sw_bytes;
+				CheckGlobalPrefetchAdmissibility_params->Tpre_rounded = s->Tpre_rounded;
+				CheckGlobalPrefetchAdmissibility_params->Tpre_oto = s->Tpre_oto;
+				CheckGlobalPrefetchAdmissibility_params->estimated_urg_bandwidth_required_mbps = mode_lib->ms.support.urg_bandwidth_required[dml2_core_internal_soc_state_sys_active][dml2_core_internal_bw_sdp];
+				CheckGlobalPrefetchAdmissibility_params->line_time = s->line_times;
+				CheckGlobalPrefetchAdmissibility_params->dst_y_prefetch = mode_lib->ms.dst_y_prefetch;
+				if (CheckGlobalPrefetchAdmissibility_params->estimated_urg_bandwidth_required_mbps < 10 * 1024)
+					CheckGlobalPrefetchAdmissibility_params->estimated_urg_bandwidth_required_mbps = 10 * 1024;
+
+				CheckGlobalPrefetchAdmissibility_params->estimated_dcfclk_mhz = (CheckGlobalPrefetchAdmissibility_params->estimated_urg_bandwidth_required_mbps / (double) mode_lib->soc.return_bus_width_bytes) /
+																				((double)mode_lib->soc.qos_parameters.derate_table.system_active_urgent.dcfclk_derate_percent / 100.0);
+
+				// if recalc_prefetch_schedule is set, recalculate the prefetch schedule with the new impacted_Tpre, prefetch should be possible
+				CheckGlobalPrefetchAdmissibility_params->recalc_prefetch_schedule = &s->recalc_prefetch_schedule;
+				CheckGlobalPrefetchAdmissibility_params->impacted_dst_y_pre = s->impacted_dst_y_pre;
+				mode_lib->ms.support.PrefetchSupported = CheckGlobalPrefetchAdmissibility(&mode_lib->scratch, CheckGlobalPrefetchAdmissibility_params);
+				s->recalc_prefetch_done = 1;
+				s->recalc_prefetch_schedule = 1;
+			}
+#endif
+		} // prefetch schedule ok, do urg bw and flip schedule
+	} while (s->recalc_prefetch_schedule);
+
+	// Flip Schedule
+	// Both prefetch schedule and BW okay
+	if (mode_lib->ms.support.PrefetchSupported == true) {
+		mode_lib->ms.BandwidthAvailableForImmediateFlip =
+			get_bandwidth_available_for_immediate_flip(
+				dml2_core_internal_soc_state_sys_active,
+				mode_lib->ms.support.urg_bandwidth_required_qual, // no flip
+				mode_lib->ms.support.urg_bandwidth_available);
+
+		mode_lib->ms.TotImmediateFlipBytes = 0;
+		for (k = 0; k < mode_lib->ms.num_active_planes; k++) {
+			if (display_cfg->plane_descriptors[k].immediate_flip) {
+				s->per_pipe_flip_bytes[k] = get_pipe_flip_bytes(
+								s->HostVMInefficiencyFactor,
+								mode_lib->ms.vm_bytes[k],
+								mode_lib->ms.DPTEBytesPerRow[k],
+								mode_lib->ms.meta_row_bytes[k]);
+			} else {
+				s->per_pipe_flip_bytes[k] = 0;
+			}
+			mode_lib->ms.TotImmediateFlipBytes += s->per_pipe_flip_bytes[k] * mode_lib->ms.NoOfDPP[k];
+
+		}
+
+		for (k = 0; k < mode_lib->ms.num_active_planes; k++) {
+			CalculateFlipSchedule(
+				&mode_lib->scratch,
+				display_cfg->plane_descriptors[k].immediate_flip,
+				1, // use_lb_flip_bw
+				s->HostVMInefficiencyFactor,
+				s->Tvm_trips_flip[k],
+				s->Tr0_trips_flip[k],
+				s->Tvm_trips_flip_rounded[k],
+				s->Tr0_trips_flip_rounded[k],
+				display_cfg->gpuvm_enable,
+				mode_lib->ms.vm_bytes[k],
+				mode_lib->ms.DPTEBytesPerRow[k],
+				mode_lib->ms.BandwidthAvailableForImmediateFlip,
+				mode_lib->ms.TotImmediateFlipBytes,
+				display_cfg->plane_descriptors[k].pixel_format,
+				(display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_total / ((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.pixel_clock_khz / 1000)),
+				display_cfg->plane_descriptors[k].composition.scaler_info.plane0.v_ratio,
+				display_cfg->plane_descriptors[k].composition.scaler_info.plane1.v_ratio,
+				mode_lib->ms.Tno_bw_flip[k],
+				mode_lib->ms.dpte_row_height[k],
+				mode_lib->ms.dpte_row_height_chroma[k],
+				mode_lib->ms.use_one_row_for_frame_flip[k],
+				mode_lib->ip.max_flip_time_us,
+				mode_lib->ip.max_flip_time_lines,
+				s->per_pipe_flip_bytes[k],
+				mode_lib->ms.meta_row_bytes[k],
+				s->meta_row_height_luma[k],
+				s->meta_row_height_chroma[k],
+				mode_lib->ip.dcn_mrq_present && display_cfg->plane_descriptors[k].surface.dcc.enable,
+
+				/* Output */
+				&mode_lib->ms.dst_y_per_vm_flip[k],
+				&mode_lib->ms.dst_y_per_row_flip[k],
+				&mode_lib->ms.final_flip_bw[k],
+				&mode_lib->ms.ImmediateFlipSupportedForPipe[k]);
+		}
+
+		calculate_peak_bandwidth_params->urg_vactive_bandwidth_required = s->dummy_bw;
+		calculate_peak_bandwidth_params->urg_bandwidth_required = mode_lib->ms.support.urg_bandwidth_required_flip;
+		calculate_peak_bandwidth_params->urg_bandwidth_required_qual = s->dummy_bw;
+		calculate_peak_bandwidth_params->non_urg_bandwidth_required = mode_lib->ms.support.non_urg_bandwidth_required_flip;
+		calculate_peak_bandwidth_params->surface_avg_vactive_required_bw = s->surface_dummy_bw;
+		calculate_peak_bandwidth_params->surface_peak_required_bw = mode_lib->ms.surface_peak_required_bw;
+
+		calculate_peak_bandwidth_params->display_cfg = display_cfg;
+		calculate_peak_bandwidth_params->inc_flip_bw = 1;
+		calculate_peak_bandwidth_params->num_active_planes = mode_lib->ms.num_active_planes;
+		calculate_peak_bandwidth_params->num_of_dpp = mode_lib->ms.NoOfDPP;
+		calculate_peak_bandwidth_params->dcc_dram_bw_nom_overhead_factor_p0 = mode_lib->ms.dcc_dram_bw_nom_overhead_factor_p0;
+		calculate_peak_bandwidth_params->dcc_dram_bw_nom_overhead_factor_p1 = mode_lib->ms.dcc_dram_bw_nom_overhead_factor_p1;
+		calculate_peak_bandwidth_params->dcc_dram_bw_pref_overhead_factor_p0 = mode_lib->ms.dcc_dram_bw_pref_overhead_factor_p0;
+		calculate_peak_bandwidth_params->dcc_dram_bw_pref_overhead_factor_p1 = mode_lib->ms.dcc_dram_bw_pref_overhead_factor_p1;
+		calculate_peak_bandwidth_params->mall_prefetch_sdp_overhead_factor = mode_lib->ms.mall_prefetch_sdp_overhead_factor;
+		calculate_peak_bandwidth_params->mall_prefetch_dram_overhead_factor = mode_lib->ms.mall_prefetch_dram_overhead_factor;
+
+		calculate_peak_bandwidth_params->surface_read_bandwidth_l = mode_lib->ms.vactive_sw_bw_l;
+		calculate_peak_bandwidth_params->surface_read_bandwidth_c = mode_lib->ms.vactive_sw_bw_c;
+		calculate_peak_bandwidth_params->prefetch_bandwidth_l = mode_lib->ms.RequiredPrefetchPixelDataBWLuma;
+		calculate_peak_bandwidth_params->prefetch_bandwidth_c = mode_lib->ms.RequiredPrefetchPixelDataBWChroma;
+		calculate_peak_bandwidth_params->prefetch_bandwidth_oto = mode_lib->ms.RequiredPrefetchBWOTO;
+		calculate_peak_bandwidth_params->excess_vactive_fill_bw_l = mode_lib->ms.excess_vactive_fill_bw_l;
+		calculate_peak_bandwidth_params->excess_vactive_fill_bw_c = mode_lib->ms.excess_vactive_fill_bw_c;
+		calculate_peak_bandwidth_params->cursor_bw = mode_lib->ms.cursor_bw;
+		calculate_peak_bandwidth_params->dpte_row_bw = mode_lib->ms.dpte_row_bw;
+		calculate_peak_bandwidth_params->meta_row_bw = mode_lib->ms.meta_row_bw;
+		calculate_peak_bandwidth_params->prefetch_cursor_bw = mode_lib->ms.prefetch_cursor_bw;
+		calculate_peak_bandwidth_params->prefetch_vmrow_bw = mode_lib->ms.prefetch_vmrow_bw;
+		calculate_peak_bandwidth_params->flip_bw = mode_lib->ms.final_flip_bw;
+		calculate_peak_bandwidth_params->urgent_burst_factor_l = mode_lib->ms.UrgentBurstFactorLuma;
+		calculate_peak_bandwidth_params->urgent_burst_factor_c = mode_lib->ms.UrgentBurstFactorChroma;
+		calculate_peak_bandwidth_params->urgent_burst_factor_cursor = mode_lib->ms.UrgentBurstFactorCursor;
+		calculate_peak_bandwidth_params->urgent_burst_factor_prefetch_l = mode_lib->ms.UrgentBurstFactorLumaPre;
+		calculate_peak_bandwidth_params->urgent_burst_factor_prefetch_c = mode_lib->ms.UrgentBurstFactorChromaPre;
+		calculate_peak_bandwidth_params->urgent_burst_factor_prefetch_cursor = mode_lib->ms.UrgentBurstFactorCursorPre;
+
+		calculate_peak_bandwidth_required(
+				&mode_lib->scratch,
+				calculate_peak_bandwidth_params);
+
+		calculate_immediate_flip_bandwidth_support(
+			&s->dummy_single[0], // double* frac_urg_bandwidth_flip
+			&mode_lib->ms.support.ImmediateFlipSupport,
+
+			dml2_core_internal_soc_state_sys_active,
+			mode_lib->ms.support.urg_bandwidth_required_flip,
+			mode_lib->ms.support.non_urg_bandwidth_required_flip,
+			mode_lib->ms.support.urg_bandwidth_available);
+
+		for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
+			if (display_cfg->plane_descriptors[k].immediate_flip == true && mode_lib->ms.ImmediateFlipSupportedForPipe[k] == false)
+				mode_lib->ms.support.ImmediateFlipSupport = false;
+		}
+
+	} else { // if prefetch not support, assume iflip is not supported too
+		mode_lib->ms.support.ImmediateFlipSupport = false;
+	}
+
+	s->mSOCParameters.UrgentLatency = mode_lib->ms.UrgLatency;
+	s->mSOCParameters.ExtraLatency = mode_lib->ms.ExtraLatency;
+	s->mSOCParameters.ExtraLatency_sr = mode_lib->ms.ExtraLatency_sr;
+	s->mSOCParameters.WritebackLatency = mode_lib->soc.qos_parameters.writeback.base_latency_us;
+	s->mSOCParameters.DRAMClockChangeLatency = mode_lib->soc.power_management_parameters.dram_clk_change_blackout_us;
+	s->mSOCParameters.FCLKChangeLatency = mode_lib->soc.power_management_parameters.fclk_change_blackout_us;
+	s->mSOCParameters.SRExitTime = mode_lib->soc.power_management_parameters.stutter_exit_latency_us;
+	s->mSOCParameters.SREnterPlusExitTime = mode_lib->soc.power_management_parameters.stutter_enter_plus_exit_latency_us;
+	s->mSOCParameters.SRExitZ8Time = mode_lib->soc.power_management_parameters.z8_stutter_exit_latency_us;
+	s->mSOCParameters.SREnterPlusExitZ8Time = mode_lib->soc.power_management_parameters.z8_stutter_enter_plus_exit_latency_us;
+	s->mSOCParameters.USRRetrainingLatency = 0;
+	s->mSOCParameters.SMNLatency = 0;
+	s->mSOCParameters.g6_temp_read_blackout_us = get_g6_temp_read_blackout_us(&mode_lib->soc, (unsigned int)(mode_lib->ms.uclk_freq_mhz * 1000), mode_lib->ms.state_idx);
+	s->mSOCParameters.max_urgent_latency_us = get_max_urgent_latency_us(&mode_lib->soc.qos_parameters.qos_params.dcn4x, mode_lib->ms.uclk_freq_mhz, mode_lib->ms.FabricClock, mode_lib->ms.state_idx);
+	s->mSOCParameters.df_response_time_us = mode_lib->soc.qos_parameters.qos_params.dcn4x.df_qos_response_time_fclk_cycles / mode_lib->ms.FabricClock;
+	s->mSOCParameters.qos_type = mode_lib->soc.qos_parameters.qos_type;
+
+	CalculateWatermarks_params->display_cfg = display_cfg;
+	CalculateWatermarks_params->USRRetrainingRequired = false;
+	CalculateWatermarks_params->NumberOfActiveSurfaces = mode_lib->ms.num_active_planes;
+	CalculateWatermarks_params->MaxLineBufferLines = mode_lib->ip.max_line_buffer_lines;
+	CalculateWatermarks_params->LineBufferSize = mode_lib->ip.line_buffer_size_bits;
+	CalculateWatermarks_params->WritebackInterfaceBufferSize = mode_lib->ip.writeback_interface_buffer_size_kbytes;
+	CalculateWatermarks_params->DCFCLK = mode_lib->ms.DCFCLK;
+	CalculateWatermarks_params->SynchronizeTimings = display_cfg->overrides.synchronize_timings;
+	CalculateWatermarks_params->SynchronizeDRRDisplaysForUCLKPStateChange = display_cfg->overrides.synchronize_ddr_displays_for_uclk_pstate_change;
+	CalculateWatermarks_params->dpte_group_bytes = mode_lib->ms.dpte_group_bytes;
+	CalculateWatermarks_params->mmSOCParameters = s->mSOCParameters;
+	CalculateWatermarks_params->WritebackChunkSize = mode_lib->ip.writeback_chunk_size_kbytes;
+	CalculateWatermarks_params->SOCCLK = mode_lib->ms.SOCCLK;
+	CalculateWatermarks_params->DCFClkDeepSleep = mode_lib->ms.dcfclk_deepsleep;
+	CalculateWatermarks_params->DETBufferSizeY = mode_lib->ms.DETBufferSizeY;
+	CalculateWatermarks_params->DETBufferSizeC = mode_lib->ms.DETBufferSizeC;
+	CalculateWatermarks_params->SwathHeightY = mode_lib->ms.SwathHeightY;
+	CalculateWatermarks_params->SwathHeightC = mode_lib->ms.SwathHeightC;
+	CalculateWatermarks_params->SwathWidthY = mode_lib->ms.SwathWidthY;
+	CalculateWatermarks_params->SwathWidthC = mode_lib->ms.SwathWidthC;
+	CalculateWatermarks_params->DPPPerSurface = mode_lib->ms.NoOfDPP;
+	CalculateWatermarks_params->BytePerPixelDETY = mode_lib->ms.BytePerPixelInDETY;
+	CalculateWatermarks_params->BytePerPixelDETC = mode_lib->ms.BytePerPixelInDETC;
+	CalculateWatermarks_params->DSTXAfterScaler = s->DSTXAfterScaler;
+	CalculateWatermarks_params->DSTYAfterScaler = s->DSTYAfterScaler;
+	CalculateWatermarks_params->UnboundedRequestEnabled = mode_lib->ms.UnboundedRequestEnabled;
+	CalculateWatermarks_params->CompressedBufferSizeInkByte = mode_lib->ms.CompressedBufferSizeInkByte;
+	CalculateWatermarks_params->meta_row_height_l = s->meta_row_height_luma;
+	CalculateWatermarks_params->meta_row_height_c = s->meta_row_height_chroma;
+
+	// Output
+	CalculateWatermarks_params->Watermark = &mode_lib->ms.support.watermarks; // Watermarks *Watermark
+	CalculateWatermarks_params->DRAMClockChangeSupport = mode_lib->ms.support.DRAMClockChangeSupport;
+	CalculateWatermarks_params->global_dram_clock_change_supported = &mode_lib->ms.support.global_dram_clock_change_supported;
+	CalculateWatermarks_params->MaxActiveDRAMClockChangeLatencySupported = &s->dummy_single_array[0]; // double *MaxActiveDRAMClockChangeLatencySupported[]
+	CalculateWatermarks_params->SubViewportLinesNeededInMALL = mode_lib->ms.SubViewportLinesNeededInMALL; // unsigned int SubViewportLinesNeededInMALL[]
+	CalculateWatermarks_params->FCLKChangeSupport = mode_lib->ms.support.FCLKChangeSupport;
+	CalculateWatermarks_params->global_fclk_change_supported = &mode_lib->ms.support.global_fclk_change_supported;
+	CalculateWatermarks_params->MaxActiveFCLKChangeLatencySupported = &s->dummy_single[0]; // double *MaxActiveFCLKChangeLatencySupported
+	CalculateWatermarks_params->USRRetrainingSupport = &mode_lib->ms.support.USRRetrainingSupport;
+	CalculateWatermarks_params->g6_temp_read_support = &mode_lib->ms.support.g6_temp_read_support;
+	CalculateWatermarks_params->VActiveLatencyHidingMargin = mode_lib->ms.VActiveLatencyHidingMargin;
+	CalculateWatermarks_params->VActiveLatencyHidingUs = mode_lib->ms.VActiveLatencyHidingUs;
+
+	CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(&mode_lib->scratch, CalculateWatermarks_params);
+
+	calculate_pstate_keepout_dst_lines(display_cfg, &mode_lib->ms.support.watermarks, s->dummy_integer_array[0]);
+	DML_LOG_VERBOSE("DML::%s: Done prefetch calculation\n", __func__);
+
+}
+
 static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out_params)
 {
 	struct dml2_core_internal_display_mode_lib *mode_lib = in_out_params->mode_lib;
@@ -7271,19 +7912,11 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	const struct dml2_mcg_min_clock_table *min_clk_table = in_out_params->min_clk_table;
 
 	double outstanding_latency_us = 0;
-	double min_return_bw_for_latency;
 
 	struct dml2_core_calcs_mode_support_locals *s = &mode_lib->scratch.dml_core_mode_support_locals;
-	struct dml2_core_calcs_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport_params *CalculateWatermarks_params = &mode_lib->scratch.CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport_params;
 	struct dml2_core_calcs_CalculateVMRowAndSwath_params *CalculateVMRowAndSwath_params = &mode_lib->scratch.CalculateVMRowAndSwath_params;
 	struct dml2_core_calcs_CalculateSwathAndDETConfiguration_params *CalculateSwathAndDETConfiguration_params = &mode_lib->scratch.CalculateSwathAndDETConfiguration_params;
-	struct dml2_core_calcs_CalculatePrefetchSchedule_params *CalculatePrefetchSchedule_params = &mode_lib->scratch.CalculatePrefetchSchedule_params;
-#ifdef DML_GLOBAL_PREFETCH_CHECK
-	struct dml2_core_calcs_CheckGlobalPrefetchAdmissibility_params *CheckGlobalPrefetchAdmissibility_params = &mode_lib->scratch.CheckGlobalPrefetchAdmissibility_params;
-#endif
-	struct dml2_core_calcs_calculate_tdlut_setting_params *calculate_tdlut_setting_params = &mode_lib->scratch.calculate_tdlut_setting_params;
 	struct dml2_core_calcs_calculate_mcache_setting_params *calculate_mcache_setting_params = &mode_lib->scratch.calculate_mcache_setting_params;
-	struct dml2_core_calcs_calculate_peak_bandwidth_required_params *calculate_peak_bandwidth_params = &mode_lib->scratch.calculate_peak_bandwidth_params;
 	struct dml2_core_calcs_calculate_bytes_to_fetch_required_to_hide_latency_params *calculate_bytes_to_fetch_required_to_hide_latency_params = &mode_lib->scratch.calculate_bytes_to_fetch_required_to_hide_latency_params;
 	unsigned int k, m, n;
 
@@ -8806,633 +9439,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 		}
 	}
 
-	/* Prefetch Check */
-	{
-		mode_lib->ms.TimeCalc = 24 / mode_lib->ms.dcfclk_deepsleep;
-
-		calculate_hostvm_inefficiency_factor(
-				&s->HostVMInefficiencyFactor,
-				&s->HostVMInefficiencyFactorPrefetch,
-
-				display_cfg->gpuvm_enable,
-				display_cfg->hostvm_enable,
-				mode_lib->ip.remote_iommu_outstanding_translations,
-				mode_lib->soc.max_outstanding_reqs,
-				mode_lib->ms.support.urg_bandwidth_available_pixel_and_vm[dml2_core_internal_soc_state_sys_active],
-				mode_lib->ms.support.urg_bandwidth_available_vm_only[dml2_core_internal_soc_state_sys_active]);
-
-		mode_lib->ms.Total3dlutActive = 0;
-		for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
-			if (display_cfg->plane_descriptors[k].tdlut.setup_for_tdlut)
-				mode_lib->ms.Total3dlutActive = mode_lib->ms.Total3dlutActive + 1;
-
-			// Calculate tdlut schedule related terms
-			calculate_tdlut_setting_params->dispclk_mhz = mode_lib->ms.RequiredDISPCLK;
-			calculate_tdlut_setting_params->setup_for_tdlut = display_cfg->plane_descriptors[k].tdlut.setup_for_tdlut;
-			calculate_tdlut_setting_params->tdlut_width_mode = display_cfg->plane_descriptors[k].tdlut.tdlut_width_mode;
-			calculate_tdlut_setting_params->tdlut_addressing_mode = display_cfg->plane_descriptors[k].tdlut.tdlut_addressing_mode;
-			calculate_tdlut_setting_params->cursor_buffer_size = mode_lib->ip.cursor_buffer_size;
-			calculate_tdlut_setting_params->gpuvm_enable = display_cfg->gpuvm_enable;
-			calculate_tdlut_setting_params->gpuvm_page_size_kbytes = display_cfg->plane_descriptors[k].overrides.gpuvm_min_page_size_kbytes;
-			calculate_tdlut_setting_params->tdlut_mpc_width_flag = display_cfg->plane_descriptors[k].tdlut.tdlut_mpc_width_flag;
-			calculate_tdlut_setting_params->is_gfx11 = dml_get_gfx_version(display_cfg->plane_descriptors[k].surface.tiling);
-
-			// output
-			calculate_tdlut_setting_params->tdlut_pte_bytes_per_frame = &s->tdlut_pte_bytes_per_frame[k];
-			calculate_tdlut_setting_params->tdlut_bytes_per_frame = &s->tdlut_bytes_per_frame[k];
-			calculate_tdlut_setting_params->tdlut_groups_per_2row_ub = &s->tdlut_groups_per_2row_ub[k];
-			calculate_tdlut_setting_params->tdlut_opt_time = &s->tdlut_opt_time[k];
-			calculate_tdlut_setting_params->tdlut_drain_time = &s->tdlut_drain_time[k];
-			calculate_tdlut_setting_params->tdlut_bytes_to_deliver = &s->tdlut_bytes_to_deliver[k];
-			calculate_tdlut_setting_params->tdlut_bytes_per_group = &s->tdlut_bytes_per_group[k];
-
-			calculate_tdlut_setting(&mode_lib->scratch, calculate_tdlut_setting_params);
-		}
-
-		min_return_bw_for_latency = mode_lib->ms.support.urg_bandwidth_available_min_latency[dml2_core_internal_soc_state_sys_active];
-
-		if (mode_lib->soc.qos_parameters.qos_type == dml2_qos_param_type_dcn3)
-			s->ReorderingBytes = (unsigned int)(mode_lib->soc.clk_table.dram_config.channel_count * math_max3(mode_lib->soc.qos_parameters.qos_params.dcn32x.urgent_out_of_order_return_per_channel_pixel_only_bytes,
-											mode_lib->soc.qos_parameters.qos_params.dcn32x.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes,
-											mode_lib->soc.qos_parameters.qos_params.dcn32x.urgent_out_of_order_return_per_channel_vm_only_bytes));
-
-		CalculateExtraLatency(
-			display_cfg,
-			mode_lib->ip.rob_buffer_size_kbytes,
-			mode_lib->soc.qos_parameters.qos_params.dcn32x.loaded_round_trip_latency_fclk_cycles,
-			s->ReorderingBytes,
-			mode_lib->ms.DCFCLK,
-			mode_lib->ms.FabricClock,
-			mode_lib->ip.pixel_chunk_size_kbytes,
-			min_return_bw_for_latency,
-			mode_lib->ms.num_active_planes,
-			mode_lib->ms.NoOfDPP,
-			mode_lib->ms.dpte_group_bytes,
-			s->tdlut_bytes_per_group,
-			s->HostVMInefficiencyFactor,
-			s->HostVMInefficiencyFactorPrefetch,
-			mode_lib->soc.hostvm_min_page_size_kbytes,
-			mode_lib->soc.qos_parameters.qos_type,
-			!(display_cfg->overrides.max_outstanding_when_urgent_expected_disable),
-			mode_lib->soc.max_outstanding_reqs,
-			mode_lib->ms.support.request_size_bytes_luma,
-			mode_lib->ms.support.request_size_bytes_chroma,
-			mode_lib->ip.meta_chunk_size_kbytes,
-			mode_lib->ip.dchub_arb_to_ret_delay,
-			mode_lib->ms.TripToMemory,
-			mode_lib->ip.hostvm_mode,
-
-			// output
-			&mode_lib->ms.ExtraLatency,
-			&mode_lib->ms.ExtraLatency_sr,
-			&mode_lib->ms.ExtraLatencyPrefetch);
-
-		for (k = 0; k < mode_lib->ms.num_active_planes; k++)
-			s->impacted_dst_y_pre[k] = 0;
-
-		s->recalc_prefetch_schedule = 0;
-		s->recalc_prefetch_done = 0;
-		do {
-			mode_lib->ms.support.PrefetchSupported = true;
-
-			for (k = 0; k < mode_lib->ms.num_active_planes; k++) {
-				s->line_times[k] = display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_total / ((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.pixel_clock_khz / 1000);
-				s->pixel_format[k] = display_cfg->plane_descriptors[k].pixel_format;
-
-				s->lb_source_lines_l[k] = get_num_lb_source_lines(mode_lib->ip.max_line_buffer_lines, mode_lib->ip.line_buffer_size_bits,
-																	mode_lib->ms.NoOfDPP[k],
-																	display_cfg->plane_descriptors[k].composition.viewport.plane0.width,
-																	display_cfg->plane_descriptors[k].composition.viewport.plane0.height,
-																	display_cfg->plane_descriptors[k].composition.scaler_info.plane0.h_ratio,
-																	display_cfg->plane_descriptors[k].composition.rotation_angle);
-
-				s->lb_source_lines_c[k] = get_num_lb_source_lines(mode_lib->ip.max_line_buffer_lines, mode_lib->ip.line_buffer_size_bits,
-																	mode_lib->ms.NoOfDPP[k],
-																	display_cfg->plane_descriptors[k].composition.viewport.plane1.width,
-																	display_cfg->plane_descriptors[k].composition.viewport.plane1.height,
-																	display_cfg->plane_descriptors[k].composition.scaler_info.plane1.h_ratio,
-																	display_cfg->plane_descriptors[k].composition.rotation_angle);
-
-				struct dml2_core_internal_DmlPipe *myPipe = &s->myPipe;
-
-				mode_lib->ms.TWait[k] = CalculateTWait(
-					display_cfg->plane_descriptors[k].overrides.reserved_vblank_time_ns,
-					mode_lib->ms.UrgLatency,
-					mode_lib->ms.TripToMemory,
-					!dml_is_phantom_pipe(&display_cfg->plane_descriptors[k]) && display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.drr_config.enabled ?
-					get_g6_temp_read_blackout_us(&mode_lib->soc, (unsigned int)(mode_lib->ms.uclk_freq_mhz * 1000), in_out_params->min_clk_index) : 0.0);
-
-				myPipe->Dppclk = mode_lib->ms.RequiredDPPCLK[k];
-				myPipe->Dispclk = mode_lib->ms.RequiredDISPCLK;
-				myPipe->PixelClock = ((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.pixel_clock_khz / 1000);
-				myPipe->DCFClkDeepSleep = mode_lib->ms.dcfclk_deepsleep;
-				myPipe->DPPPerSurface = mode_lib->ms.NoOfDPP[k];
-				myPipe->ScalerEnabled = display_cfg->plane_descriptors[k].composition.scaler_info.enabled;
-				myPipe->VRatio = display_cfg->plane_descriptors[k].composition.scaler_info.plane0.v_ratio;
-				myPipe->VRatioChroma = display_cfg->plane_descriptors[k].composition.scaler_info.plane1.v_ratio;
-				myPipe->VTaps = display_cfg->plane_descriptors[k].composition.scaler_info.plane0.v_taps;
-				myPipe->VTapsChroma = display_cfg->plane_descriptors[k].composition.scaler_info.plane1.v_taps;
-				myPipe->RotationAngle = display_cfg->plane_descriptors[k].composition.rotation_angle;
-				myPipe->mirrored = display_cfg->plane_descriptors[k].composition.mirrored;
-				myPipe->BlockWidth256BytesY = mode_lib->ms.Read256BlockWidthY[k];
-				myPipe->BlockHeight256BytesY = mode_lib->ms.Read256BlockHeightY[k];
-				myPipe->BlockWidth256BytesC = mode_lib->ms.Read256BlockWidthC[k];
-				myPipe->BlockHeight256BytesC = mode_lib->ms.Read256BlockHeightC[k];
-				myPipe->InterlaceEnable = display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.interlaced;
-				myPipe->NumberOfCursors = display_cfg->plane_descriptors[k].cursor.num_cursors;
-				myPipe->VBlank = display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.v_total - display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.v_active;
-				myPipe->HTotal = display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_total;
-				myPipe->HActive = display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_active;
-				myPipe->DCCEnable = display_cfg->plane_descriptors[k].surface.dcc.enable;
-				myPipe->ODMMode = mode_lib->ms.ODMMode[k];
-				myPipe->SourcePixelFormat = display_cfg->plane_descriptors[k].pixel_format;
-				myPipe->BytePerPixelY = mode_lib->ms.BytePerPixelY[k];
-				myPipe->BytePerPixelC = mode_lib->ms.BytePerPixelC[k];
-				myPipe->ProgressiveToInterlaceUnitInOPP = mode_lib->ip.ptoi_supported;
-
-#ifdef __DML_VBA_DEBUG__
-				DML_LOG_VERBOSE("DML::%s: Calling CalculatePrefetchSchedule for k=%u\n", __func__, k);
-				DML_LOG_VERBOSE("DML::%s: MaximumVStartup = %u\n", __func__, s->MaximumVStartup[k]);
-#endif
-				CalculatePrefetchSchedule_params->display_cfg = display_cfg;
-				CalculatePrefetchSchedule_params->HostVMInefficiencyFactor = s->HostVMInefficiencyFactorPrefetch;
-				CalculatePrefetchSchedule_params->myPipe = myPipe;
-				CalculatePrefetchSchedule_params->DSCDelay = mode_lib->ms.DSCDelay[k];
-				CalculatePrefetchSchedule_params->DPPCLKDelaySubtotalPlusCNVCFormater = mode_lib->ip.dppclk_delay_subtotal + mode_lib->ip.dppclk_delay_cnvc_formatter;
-				CalculatePrefetchSchedule_params->DPPCLKDelaySCL = mode_lib->ip.dppclk_delay_scl;
-				CalculatePrefetchSchedule_params->DPPCLKDelaySCLLBOnly = mode_lib->ip.dppclk_delay_scl_lb_only;
-				CalculatePrefetchSchedule_params->DPPCLKDelayCNVCCursor = mode_lib->ip.dppclk_delay_cnvc_cursor;
-				CalculatePrefetchSchedule_params->DISPCLKDelaySubtotal = mode_lib->ip.dispclk_delay_subtotal;
-				CalculatePrefetchSchedule_params->DPP_RECOUT_WIDTH = (unsigned int)(mode_lib->ms.SwathWidthY[k] / display_cfg->plane_descriptors[k].composition.scaler_info.plane0.h_ratio);
-				CalculatePrefetchSchedule_params->OutputFormat = display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].output.output_format;
-				CalculatePrefetchSchedule_params->MaxInterDCNTileRepeaters = mode_lib->ip.max_inter_dcn_tile_repeaters;
-				CalculatePrefetchSchedule_params->VStartup = s->MaximumVStartup[k];
-				CalculatePrefetchSchedule_params->HostVMMinPageSize = mode_lib->soc.hostvm_min_page_size_kbytes;
-				CalculatePrefetchSchedule_params->DynamicMetadataEnable = display_cfg->plane_descriptors[k].dynamic_meta_data.enable;
-				CalculatePrefetchSchedule_params->DynamicMetadataVMEnabled = mode_lib->ip.dynamic_metadata_vm_enabled;
-				CalculatePrefetchSchedule_params->DynamicMetadataLinesBeforeActiveRequired = display_cfg->plane_descriptors[k].dynamic_meta_data.lines_before_active_required;
-				CalculatePrefetchSchedule_params->DynamicMetadataTransmittedBytes = display_cfg->plane_descriptors[k].dynamic_meta_data.transmitted_bytes;
-				CalculatePrefetchSchedule_params->UrgentLatency = mode_lib->ms.UrgLatency;
-				CalculatePrefetchSchedule_params->ExtraLatencyPrefetch = mode_lib->ms.ExtraLatencyPrefetch;
-				CalculatePrefetchSchedule_params->TCalc = mode_lib->ms.TimeCalc;
-				CalculatePrefetchSchedule_params->vm_bytes = mode_lib->ms.vm_bytes[k];
-				CalculatePrefetchSchedule_params->PixelPTEBytesPerRow = mode_lib->ms.DPTEBytesPerRow[k];
-				CalculatePrefetchSchedule_params->PrefetchSourceLinesY = mode_lib->ms.PrefetchLinesY[k];
-				CalculatePrefetchSchedule_params->VInitPreFillY = mode_lib->ms.PrefillY[k];
-				CalculatePrefetchSchedule_params->MaxNumSwathY = mode_lib->ms.MaxNumSwathY[k];
-				CalculatePrefetchSchedule_params->PrefetchSourceLinesC = mode_lib->ms.PrefetchLinesC[k];
-				CalculatePrefetchSchedule_params->VInitPreFillC = mode_lib->ms.PrefillC[k];
-				CalculatePrefetchSchedule_params->MaxNumSwathC = mode_lib->ms.MaxNumSwathC[k];
-				CalculatePrefetchSchedule_params->swath_width_luma_ub = mode_lib->ms.swath_width_luma_ub[k];
-				CalculatePrefetchSchedule_params->swath_width_chroma_ub = mode_lib->ms.swath_width_chroma_ub[k];
-				CalculatePrefetchSchedule_params->SwathHeightY = mode_lib->ms.SwathHeightY[k];
-				CalculatePrefetchSchedule_params->SwathHeightC = mode_lib->ms.SwathHeightC[k];
-				CalculatePrefetchSchedule_params->TWait = mode_lib->ms.TWait[k];
-				CalculatePrefetchSchedule_params->Ttrip = mode_lib->ms.TripToMemory;
-				CalculatePrefetchSchedule_params->Turg = mode_lib->ms.UrgLatency;
-				CalculatePrefetchSchedule_params->setup_for_tdlut = display_cfg->plane_descriptors[k].tdlut.setup_for_tdlut;
-				CalculatePrefetchSchedule_params->tdlut_pte_bytes_per_frame = s->tdlut_pte_bytes_per_frame[k];
-				CalculatePrefetchSchedule_params->tdlut_bytes_per_frame = s->tdlut_bytes_per_frame[k];
-				CalculatePrefetchSchedule_params->tdlut_opt_time = s->tdlut_opt_time[k];
-				CalculatePrefetchSchedule_params->tdlut_drain_time = s->tdlut_drain_time[k];
-				CalculatePrefetchSchedule_params->num_cursors = (display_cfg->plane_descriptors[k].cursor.cursor_width > 0);
-				CalculatePrefetchSchedule_params->cursor_bytes_per_chunk = s->cursor_bytes_per_chunk[k];
-				CalculatePrefetchSchedule_params->cursor_bytes_per_line = s->cursor_bytes_per_line[k];
-				CalculatePrefetchSchedule_params->dcc_enable = display_cfg->plane_descriptors[k].surface.dcc.enable;
-				CalculatePrefetchSchedule_params->mrq_present = mode_lib->ip.dcn_mrq_present;
-				CalculatePrefetchSchedule_params->meta_row_bytes = mode_lib->ms.meta_row_bytes[k];
-				CalculatePrefetchSchedule_params->mall_prefetch_sdp_overhead_factor = mode_lib->ms.mall_prefetch_sdp_overhead_factor[k];
-				CalculatePrefetchSchedule_params->impacted_dst_y_pre = s->impacted_dst_y_pre[k];
-				CalculatePrefetchSchedule_params->vactive_sw_bw_l = mode_lib->ms.vactive_sw_bw_l[k];
-				CalculatePrefetchSchedule_params->vactive_sw_bw_c = mode_lib->ms.vactive_sw_bw_c[k];
-
-				// output
-				CalculatePrefetchSchedule_params->DSTXAfterScaler = &s->DSTXAfterScaler[k];
-				CalculatePrefetchSchedule_params->DSTYAfterScaler = &s->DSTYAfterScaler[k];
-				CalculatePrefetchSchedule_params->dst_y_prefetch = &mode_lib->ms.dst_y_prefetch[k];
-				CalculatePrefetchSchedule_params->dst_y_per_vm_vblank = &mode_lib->ms.LinesForVM[k];
-				CalculatePrefetchSchedule_params->dst_y_per_row_vblank = &mode_lib->ms.LinesForDPTERow[k];
-				CalculatePrefetchSchedule_params->VRatioPrefetchY = &mode_lib->ms.VRatioPreY[k];
-				CalculatePrefetchSchedule_params->VRatioPrefetchC = &mode_lib->ms.VRatioPreC[k];
-				CalculatePrefetchSchedule_params->RequiredPrefetchPixelDataBWLuma = &mode_lib->ms.RequiredPrefetchPixelDataBWLuma[k]; // prefetch_sw_bw_l
-				CalculatePrefetchSchedule_params->RequiredPrefetchPixelDataBWChroma = &mode_lib->ms.RequiredPrefetchPixelDataBWChroma[k]; // prefetch_sw_bw_c
-				CalculatePrefetchSchedule_params->RequiredPrefetchBWOTO = &mode_lib->ms.RequiredPrefetchBWOTO[k];
-				CalculatePrefetchSchedule_params->NotEnoughTimeForDynamicMetadata = &mode_lib->ms.NoTimeForDynamicMetadata[k];
-				CalculatePrefetchSchedule_params->Tno_bw = &mode_lib->ms.Tno_bw[k];
-				CalculatePrefetchSchedule_params->Tno_bw_flip = &mode_lib->ms.Tno_bw_flip[k];
-				CalculatePrefetchSchedule_params->prefetch_vmrow_bw = &mode_lib->ms.prefetch_vmrow_bw[k];
-				CalculatePrefetchSchedule_params->Tdmdl_vm = &s->dummy_single[0];
-				CalculatePrefetchSchedule_params->Tdmdl = &s->dummy_single[1];
-				CalculatePrefetchSchedule_params->TSetup = &s->dummy_single[2];
-				CalculatePrefetchSchedule_params->Tvm_trips = &s->Tvm_trips[k];
-				CalculatePrefetchSchedule_params->Tr0_trips = &s->Tr0_trips[k];
-				CalculatePrefetchSchedule_params->Tvm_trips_flip = &s->Tvm_trips_flip[k];
-				CalculatePrefetchSchedule_params->Tr0_trips_flip = &s->Tr0_trips_flip[k];
-				CalculatePrefetchSchedule_params->Tvm_trips_flip_rounded = &s->Tvm_trips_flip_rounded[k];
-				CalculatePrefetchSchedule_params->Tr0_trips_flip_rounded = &s->Tr0_trips_flip_rounded[k];
-				CalculatePrefetchSchedule_params->VUpdateOffsetPix = &s->dummy_integer[0];
-				CalculatePrefetchSchedule_params->VUpdateWidthPix = &s->dummy_integer[1];
-				CalculatePrefetchSchedule_params->VReadyOffsetPix = &s->dummy_integer[2];
-				CalculatePrefetchSchedule_params->prefetch_cursor_bw = &mode_lib->ms.prefetch_cursor_bw[k];
-				CalculatePrefetchSchedule_params->prefetch_sw_bytes = &s->prefetch_sw_bytes[k];
-				CalculatePrefetchSchedule_params->Tpre_rounded = &s->Tpre_rounded[k];
-				CalculatePrefetchSchedule_params->Tpre_oto = &s->Tpre_oto[k];
-				CalculatePrefetchSchedule_params->prefetch_swath_time_us = &s->prefetch_swath_time_us[k];
-
-				mode_lib->ms.NoTimeForPrefetch[k] = CalculatePrefetchSchedule(&mode_lib->scratch, CalculatePrefetchSchedule_params);
-
-				mode_lib->ms.support.PrefetchSupported &= !mode_lib->ms.NoTimeForPrefetch[k];
-				DML_LOG_VERBOSE("DML::%s: k=%d, dst_y_per_vm_vblank = %f\n", __func__, k, *CalculatePrefetchSchedule_params->dst_y_per_vm_vblank);
-				DML_LOG_VERBOSE("DML::%s: k=%d, dst_y_per_row_vblank = %f\n", __func__, k, *CalculatePrefetchSchedule_params->dst_y_per_row_vblank);
-			} // for k num_planes
-
-			CalculateDCFCLKDeepSleepTdlut(
-				display_cfg,
-				mode_lib->ms.num_active_planes,
-				mode_lib->ms.BytePerPixelY,
-				mode_lib->ms.BytePerPixelC,
-				mode_lib->ms.SwathWidthY,
-				mode_lib->ms.SwathWidthC,
-				mode_lib->ms.NoOfDPP,
-				mode_lib->ms.PSCL_FACTOR,
-				mode_lib->ms.PSCL_FACTOR_CHROMA,
-				mode_lib->ms.RequiredDPPCLK,
-				mode_lib->ms.vactive_sw_bw_l,
-				mode_lib->ms.vactive_sw_bw_c,
-				mode_lib->soc.return_bus_width_bytes,
-				mode_lib->ms.RequiredDISPCLK,
-				s->tdlut_bytes_to_deliver,
-				s->prefetch_swath_time_us,
-
-				/* Output */
-				&mode_lib->ms.dcfclk_deepsleep);
-
-			for (k = 0; k < mode_lib->ms.num_active_planes; k++) {
-				if (mode_lib->ms.dst_y_prefetch[k] < 2.0
-					|| mode_lib->ms.LinesForVM[k] >= 32.0
-					|| mode_lib->ms.LinesForDPTERow[k] >= 16.0
-					|| mode_lib->ms.NoTimeForPrefetch[k] == true
-					|| s->DSTYAfterScaler[k] > 8) {
-					mode_lib->ms.support.PrefetchSupported = false;
-					DML_LOG_VERBOSE("DML::%s: k=%d, dst_y_prefetch=%f (should not be < 2)\n", __func__, k, mode_lib->ms.dst_y_prefetch[k]);
-					DML_LOG_VERBOSE("DML::%s: k=%d, LinesForVM=%f (should not be >= 32)\n", __func__, k, mode_lib->ms.LinesForVM[k]);
-					DML_LOG_VERBOSE("DML::%s: k=%d, LinesForDPTERow=%f (should not be >= 16)\n", __func__, k, mode_lib->ms.LinesForDPTERow[k]);
-					DML_LOG_VERBOSE("DML::%s: k=%d, DSTYAfterScaler=%d (should be <= 8)\n", __func__, k, s->DSTYAfterScaler[k]);
-					DML_LOG_VERBOSE("DML::%s: k=%d, NoTimeForPrefetch=%d\n", __func__, k, mode_lib->ms.NoTimeForPrefetch[k]);
-				}
-			}
-
-			mode_lib->ms.support.DynamicMetadataSupported = true;
-			for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
-				if (mode_lib->ms.NoTimeForDynamicMetadata[k] == true) {
-					mode_lib->ms.support.DynamicMetadataSupported = false;
-				}
-			}
-
-			mode_lib->ms.support.VRatioInPrefetchSupported = true;
-			for (k = 0; k < mode_lib->ms.num_active_planes; k++) {
-				if (mode_lib->ms.VRatioPreY[k] > __DML2_CALCS_MAX_VRATIO_PRE__ ||
-					mode_lib->ms.VRatioPreC[k] > __DML2_CALCS_MAX_VRATIO_PRE__) {
-					mode_lib->ms.support.VRatioInPrefetchSupported = false;
-					DML_LOG_VERBOSE("DML::%s: k=%d VRatioPreY = %f (should be <= %f)\n", __func__, k, mode_lib->ms.VRatioPreY[k], __DML2_CALCS_MAX_VRATIO_PRE__);
-					DML_LOG_VERBOSE("DML::%s: k=%d VRatioPreC = %f (should be <= %f)\n", __func__, k, mode_lib->ms.VRatioPreC[k], __DML2_CALCS_MAX_VRATIO_PRE__);
-					DML_LOG_VERBOSE("DML::%s: VRatioInPrefetchSupported = %u\n", __func__, mode_lib->ms.support.VRatioInPrefetchSupported);
-				}
-			}
-
-			mode_lib->ms.support.PrefetchSupported &= mode_lib->ms.support.VRatioInPrefetchSupported;
-
-			// By default, do not recalc prefetch schedule
-			s->recalc_prefetch_schedule = 0;
-
-			// Only do urg vs prefetch bandwidth check, flip schedule check, power saving feature support check IF the Prefetch Schedule Check is ok
-			if (mode_lib->ms.support.PrefetchSupported) {
-				for (k = 0; k < mode_lib->ms.num_active_planes; k++) {
-					// Calculate Urgent burst factor for prefetch
-#ifdef __DML_VBA_DEBUG__
-					DML_LOG_VERBOSE("DML::%s: k=%d, Calling CalculateUrgentBurstFactor (for prefetch)\n", __func__, k);
-					DML_LOG_VERBOSE("DML::%s: k=%d, VRatioPreY=%f\n", __func__, k, mode_lib->ms.VRatioPreY[k]);
-					DML_LOG_VERBOSE("DML::%s: k=%d, VRatioPreC=%f\n", __func__, k, mode_lib->ms.VRatioPreC[k]);
-#endif
-					CalculateUrgentBurstFactor(
-						&display_cfg->plane_descriptors[k],
-						mode_lib->ms.swath_width_luma_ub[k],
-						mode_lib->ms.swath_width_chroma_ub[k],
-						mode_lib->ms.SwathHeightY[k],
-						mode_lib->ms.SwathHeightC[k],
-						s->line_times[k],
-						mode_lib->ms.UrgLatency,
-						mode_lib->ms.VRatioPreY[k],
-						mode_lib->ms.VRatioPreC[k],
-						mode_lib->ms.BytePerPixelInDETY[k],
-						mode_lib->ms.BytePerPixelInDETC[k],
-						mode_lib->ms.DETBufferSizeY[k],
-						mode_lib->ms.DETBufferSizeC[k],
-						/* Output */
-						&mode_lib->ms.UrgentBurstFactorLumaPre[k],
-						&mode_lib->ms.UrgentBurstFactorChromaPre[k],
-						&mode_lib->ms.NotEnoughUrgentLatencyHidingPre[k]);
-				}
-
-				// Calculate urgent bandwidth required, both urg and non urg peak bandwidth
-				// assume flip bw is 0 at this point
-				for (k = 0; k < mode_lib->ms.num_active_planes; k++)
-					mode_lib->ms.final_flip_bw[k] = 0;
-
-				calculate_peak_bandwidth_params->urg_vactive_bandwidth_required = mode_lib->ms.support.urg_vactive_bandwidth_required;
-				calculate_peak_bandwidth_params->urg_bandwidth_required = mode_lib->ms.support.urg_bandwidth_required;
-				calculate_peak_bandwidth_params->urg_bandwidth_required_qual = mode_lib->ms.support.urg_bandwidth_required_qual;
-				calculate_peak_bandwidth_params->non_urg_bandwidth_required = mode_lib->ms.support.non_urg_bandwidth_required;
-				calculate_peak_bandwidth_params->surface_avg_vactive_required_bw = mode_lib->ms.surface_avg_vactive_required_bw;
-				calculate_peak_bandwidth_params->surface_peak_required_bw = mode_lib->ms.surface_peak_required_bw;
-
-				calculate_peak_bandwidth_params->display_cfg = display_cfg;
-				calculate_peak_bandwidth_params->inc_flip_bw = 0;
-				calculate_peak_bandwidth_params->num_active_planes =  mode_lib->ms.num_active_planes;
-				calculate_peak_bandwidth_params->num_of_dpp = mode_lib->ms.NoOfDPP;
-				calculate_peak_bandwidth_params->dcc_dram_bw_nom_overhead_factor_p0 = mode_lib->ms.dcc_dram_bw_nom_overhead_factor_p0;
-				calculate_peak_bandwidth_params->dcc_dram_bw_nom_overhead_factor_p1 = mode_lib->ms.dcc_dram_bw_nom_overhead_factor_p1;
-				calculate_peak_bandwidth_params->dcc_dram_bw_pref_overhead_factor_p0 = mode_lib->ms.dcc_dram_bw_pref_overhead_factor_p0;
-				calculate_peak_bandwidth_params->dcc_dram_bw_pref_overhead_factor_p1 = mode_lib->ms.dcc_dram_bw_pref_overhead_factor_p1;
-				calculate_peak_bandwidth_params->mall_prefetch_sdp_overhead_factor = mode_lib->ms.mall_prefetch_sdp_overhead_factor;
-				calculate_peak_bandwidth_params->mall_prefetch_dram_overhead_factor = mode_lib->ms.mall_prefetch_dram_overhead_factor;
-
-				calculate_peak_bandwidth_params->surface_read_bandwidth_l = mode_lib->ms.vactive_sw_bw_l;
-				calculate_peak_bandwidth_params->surface_read_bandwidth_c = mode_lib->ms.vactive_sw_bw_c;
-				calculate_peak_bandwidth_params->prefetch_bandwidth_l = mode_lib->ms.RequiredPrefetchPixelDataBWLuma;
-				calculate_peak_bandwidth_params->prefetch_bandwidth_c = mode_lib->ms.RequiredPrefetchPixelDataBWChroma;
-				calculate_peak_bandwidth_params->prefetch_bandwidth_oto = mode_lib->ms.RequiredPrefetchBWOTO;
-				calculate_peak_bandwidth_params->excess_vactive_fill_bw_l = mode_lib->ms.excess_vactive_fill_bw_l;
-				calculate_peak_bandwidth_params->excess_vactive_fill_bw_c = mode_lib->ms.excess_vactive_fill_bw_c;
-				calculate_peak_bandwidth_params->cursor_bw = mode_lib->ms.cursor_bw;
-				calculate_peak_bandwidth_params->dpte_row_bw = mode_lib->ms.dpte_row_bw;
-				calculate_peak_bandwidth_params->meta_row_bw = mode_lib->ms.meta_row_bw;
-				calculate_peak_bandwidth_params->prefetch_cursor_bw = mode_lib->ms.prefetch_cursor_bw;
-				calculate_peak_bandwidth_params->prefetch_vmrow_bw = mode_lib->ms.prefetch_vmrow_bw;
-				calculate_peak_bandwidth_params->flip_bw = mode_lib->ms.final_flip_bw;
-				calculate_peak_bandwidth_params->urgent_burst_factor_l = mode_lib->ms.UrgentBurstFactorLuma;
-				calculate_peak_bandwidth_params->urgent_burst_factor_c = mode_lib->ms.UrgentBurstFactorChroma;
-				calculate_peak_bandwidth_params->urgent_burst_factor_cursor = mode_lib->ms.UrgentBurstFactorCursor;
-				calculate_peak_bandwidth_params->urgent_burst_factor_prefetch_l = mode_lib->ms.UrgentBurstFactorLumaPre;
-				calculate_peak_bandwidth_params->urgent_burst_factor_prefetch_c = mode_lib->ms.UrgentBurstFactorChromaPre;
-				calculate_peak_bandwidth_params->urgent_burst_factor_prefetch_cursor = mode_lib->ms.UrgentBurstFactorCursorPre;
-
-				calculate_peak_bandwidth_required(
-						&mode_lib->scratch,
-						calculate_peak_bandwidth_params);
-
-				// Check urg peak bandwidth against available urg bw
-				// check at SDP and DRAM, for all soc states (SVP prefetch an Sys Active)
-				check_urgent_bandwidth_support(
-					&s->dummy_single[0], // double* frac_urg_bandwidth
-					&s->dummy_single[1], // double* frac_urg_bandwidth_mall
-					&mode_lib->ms.support.UrgVactiveBandwidthSupport,
-					&mode_lib->ms.support.PrefetchBandwidthSupported,
-
-					mode_lib->soc.mall_allocated_for_dcn_mbytes,
-					mode_lib->ms.support.non_urg_bandwidth_required,
-					mode_lib->ms.support.urg_vactive_bandwidth_required,
-					mode_lib->ms.support.urg_bandwidth_required,
-					mode_lib->ms.support.urg_bandwidth_available);
-
-				mode_lib->ms.support.PrefetchSupported &= mode_lib->ms.support.PrefetchBandwidthSupported;
-				DML_LOG_VERBOSE("DML::%s: PrefetchBandwidthSupported=%0d\n", __func__, mode_lib->ms.support.PrefetchBandwidthSupported);
-
-				for (k = 0; k < mode_lib->ms.num_active_planes; k++) {
-					if (mode_lib->ms.NotEnoughUrgentLatencyHidingPre[k]) {
-						mode_lib->ms.support.PrefetchSupported = false;
-						DML_LOG_VERBOSE("DML::%s: k=%d, NotEnoughUrgentLatencyHidingPre=%d\n", __func__, k, mode_lib->ms.NotEnoughUrgentLatencyHidingPre[k]);
-					}
-				}
-
-#ifdef DML_GLOBAL_PREFETCH_CHECK
-				if (mode_lib->ms.support.PrefetchSupported && mode_lib->ms.num_active_planes > 1 && s->recalc_prefetch_done == 0) {
-					CheckGlobalPrefetchAdmissibility_params->num_active_planes =  mode_lib->ms.num_active_planes;
-					CheckGlobalPrefetchAdmissibility_params->pixel_format = s->pixel_format;
-					CheckGlobalPrefetchAdmissibility_params->chunk_bytes_l = mode_lib->ip.pixel_chunk_size_kbytes * 1024;
-					CheckGlobalPrefetchAdmissibility_params->chunk_bytes_c = mode_lib->ip.pixel_chunk_size_kbytes * 1024;
-					CheckGlobalPrefetchAdmissibility_params->lb_source_lines_l = s->lb_source_lines_l;
-					CheckGlobalPrefetchAdmissibility_params->lb_source_lines_c = s->lb_source_lines_c;
-					CheckGlobalPrefetchAdmissibility_params->swath_height_l =  mode_lib->ms.SwathHeightY;
-					CheckGlobalPrefetchAdmissibility_params->swath_height_c =  mode_lib->ms.SwathHeightC;
-					CheckGlobalPrefetchAdmissibility_params->rob_buffer_size_kbytes = mode_lib->ip.rob_buffer_size_kbytes;
-					CheckGlobalPrefetchAdmissibility_params->compressed_buffer_size_kbytes = mode_lib->ms.CompressedBufferSizeInkByte;
-					CheckGlobalPrefetchAdmissibility_params->detile_buffer_size_bytes_l = mode_lib->ms.DETBufferSizeY;
-					CheckGlobalPrefetchAdmissibility_params->detile_buffer_size_bytes_c = mode_lib->ms.DETBufferSizeC;
-					CheckGlobalPrefetchAdmissibility_params->full_swath_bytes_l = s->full_swath_bytes_l;
-					CheckGlobalPrefetchAdmissibility_params->full_swath_bytes_c = s->full_swath_bytes_c;
-					CheckGlobalPrefetchAdmissibility_params->prefetch_sw_bytes = s->prefetch_sw_bytes;
-					CheckGlobalPrefetchAdmissibility_params->Tpre_rounded = s->Tpre_rounded;
-					CheckGlobalPrefetchAdmissibility_params->Tpre_oto = s->Tpre_oto;
-					CheckGlobalPrefetchAdmissibility_params->estimated_urg_bandwidth_required_mbps = mode_lib->ms.support.urg_bandwidth_required[dml2_core_internal_soc_state_sys_active][dml2_core_internal_bw_sdp];
-					CheckGlobalPrefetchAdmissibility_params->line_time = s->line_times;
-					CheckGlobalPrefetchAdmissibility_params->dst_y_prefetch = mode_lib->ms.dst_y_prefetch;
-					if (CheckGlobalPrefetchAdmissibility_params->estimated_urg_bandwidth_required_mbps < 10 * 1024)
-						CheckGlobalPrefetchAdmissibility_params->estimated_urg_bandwidth_required_mbps = 10 * 1024;
-
-					CheckGlobalPrefetchAdmissibility_params->estimated_dcfclk_mhz = (CheckGlobalPrefetchAdmissibility_params->estimated_urg_bandwidth_required_mbps / (double) mode_lib->soc.return_bus_width_bytes) /
-																					((double)mode_lib->soc.qos_parameters.derate_table.system_active_urgent.dcfclk_derate_percent / 100.0);
-
-					// if recalc_prefetch_schedule is set, recalculate the prefetch schedule with the new impacted_Tpre, prefetch should be possible
-					CheckGlobalPrefetchAdmissibility_params->recalc_prefetch_schedule = &s->recalc_prefetch_schedule;
-					CheckGlobalPrefetchAdmissibility_params->impacted_dst_y_pre = s->impacted_dst_y_pre;
-					mode_lib->ms.support.PrefetchSupported = CheckGlobalPrefetchAdmissibility(&mode_lib->scratch, CheckGlobalPrefetchAdmissibility_params);
-					s->recalc_prefetch_done = 1;
-					s->recalc_prefetch_schedule = 1;
-				}
-#endif
-			} // prefetch schedule ok, do urg bw and flip schedule
-		} while (s->recalc_prefetch_schedule);
-
-		// Flip Schedule
-		// Both prefetch schedule and BW okay
-		if (mode_lib->ms.support.PrefetchSupported == true) {
-			mode_lib->ms.BandwidthAvailableForImmediateFlip =
-				get_bandwidth_available_for_immediate_flip(
-					dml2_core_internal_soc_state_sys_active,
-					mode_lib->ms.support.urg_bandwidth_required_qual, // no flip
-					mode_lib->ms.support.urg_bandwidth_available);
-
-			mode_lib->ms.TotImmediateFlipBytes = 0;
-			for (k = 0; k < mode_lib->ms.num_active_planes; k++) {
-				if (display_cfg->plane_descriptors[k].immediate_flip) {
-					s->per_pipe_flip_bytes[k] = get_pipe_flip_bytes(
-									s->HostVMInefficiencyFactor,
-									mode_lib->ms.vm_bytes[k],
-									mode_lib->ms.DPTEBytesPerRow[k],
-									mode_lib->ms.meta_row_bytes[k]);
-				} else {
-					s->per_pipe_flip_bytes[k] = 0;
-				}
-				mode_lib->ms.TotImmediateFlipBytes += s->per_pipe_flip_bytes[k] * mode_lib->ms.NoOfDPP[k];
-
-			}
-
-			for (k = 0; k < mode_lib->ms.num_active_planes; k++) {
-				CalculateFlipSchedule(
-					&mode_lib->scratch,
-					display_cfg->plane_descriptors[k].immediate_flip,
-					1, // use_lb_flip_bw
-					s->HostVMInefficiencyFactor,
-					s->Tvm_trips_flip[k],
-					s->Tr0_trips_flip[k],
-					s->Tvm_trips_flip_rounded[k],
-					s->Tr0_trips_flip_rounded[k],
-					display_cfg->gpuvm_enable,
-					mode_lib->ms.vm_bytes[k],
-					mode_lib->ms.DPTEBytesPerRow[k],
-					mode_lib->ms.BandwidthAvailableForImmediateFlip,
-					mode_lib->ms.TotImmediateFlipBytes,
-					display_cfg->plane_descriptors[k].pixel_format,
-					(display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.h_total / ((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.pixel_clock_khz / 1000)),
-					display_cfg->plane_descriptors[k].composition.scaler_info.plane0.v_ratio,
-					display_cfg->plane_descriptors[k].composition.scaler_info.plane1.v_ratio,
-					mode_lib->ms.Tno_bw_flip[k],
-					mode_lib->ms.dpte_row_height[k],
-					mode_lib->ms.dpte_row_height_chroma[k],
-					mode_lib->ms.use_one_row_for_frame_flip[k],
-					mode_lib->ip.max_flip_time_us,
-					mode_lib->ip.max_flip_time_lines,
-					s->per_pipe_flip_bytes[k],
-					mode_lib->ms.meta_row_bytes[k],
-					s->meta_row_height_luma[k],
-					s->meta_row_height_chroma[k],
-					mode_lib->ip.dcn_mrq_present && display_cfg->plane_descriptors[k].surface.dcc.enable,
-
-					/* Output */
-					&mode_lib->ms.dst_y_per_vm_flip[k],
-					&mode_lib->ms.dst_y_per_row_flip[k],
-					&mode_lib->ms.final_flip_bw[k],
-					&mode_lib->ms.ImmediateFlipSupportedForPipe[k]);
-			}
-
-			calculate_peak_bandwidth_params->urg_vactive_bandwidth_required = s->dummy_bw;
-			calculate_peak_bandwidth_params->urg_bandwidth_required = mode_lib->ms.support.urg_bandwidth_required_flip;
-			calculate_peak_bandwidth_params->urg_bandwidth_required_qual = s->dummy_bw;
-			calculate_peak_bandwidth_params->non_urg_bandwidth_required = mode_lib->ms.support.non_urg_bandwidth_required_flip;
-			calculate_peak_bandwidth_params->surface_avg_vactive_required_bw = s->surface_dummy_bw;
-			calculate_peak_bandwidth_params->surface_peak_required_bw = mode_lib->ms.surface_peak_required_bw;
-
-			calculate_peak_bandwidth_params->display_cfg = display_cfg;
-			calculate_peak_bandwidth_params->inc_flip_bw = 1;
-			calculate_peak_bandwidth_params->num_active_planes = mode_lib->ms.num_active_planes;
-			calculate_peak_bandwidth_params->num_of_dpp = mode_lib->ms.NoOfDPP;
-			calculate_peak_bandwidth_params->dcc_dram_bw_nom_overhead_factor_p0 = mode_lib->ms.dcc_dram_bw_nom_overhead_factor_p0;
-			calculate_peak_bandwidth_params->dcc_dram_bw_nom_overhead_factor_p1 = mode_lib->ms.dcc_dram_bw_nom_overhead_factor_p1;
-			calculate_peak_bandwidth_params->dcc_dram_bw_pref_overhead_factor_p0 = mode_lib->ms.dcc_dram_bw_pref_overhead_factor_p0;
-			calculate_peak_bandwidth_params->dcc_dram_bw_pref_overhead_factor_p1 = mode_lib->ms.dcc_dram_bw_pref_overhead_factor_p1;
-			calculate_peak_bandwidth_params->mall_prefetch_sdp_overhead_factor = mode_lib->ms.mall_prefetch_sdp_overhead_factor;
-			calculate_peak_bandwidth_params->mall_prefetch_dram_overhead_factor = mode_lib->ms.mall_prefetch_dram_overhead_factor;
-
-			calculate_peak_bandwidth_params->surface_read_bandwidth_l = mode_lib->ms.vactive_sw_bw_l;
-			calculate_peak_bandwidth_params->surface_read_bandwidth_c = mode_lib->ms.vactive_sw_bw_c;
-			calculate_peak_bandwidth_params->prefetch_bandwidth_l = mode_lib->ms.RequiredPrefetchPixelDataBWLuma;
-			calculate_peak_bandwidth_params->prefetch_bandwidth_c = mode_lib->ms.RequiredPrefetchPixelDataBWChroma;
-			calculate_peak_bandwidth_params->prefetch_bandwidth_oto = mode_lib->ms.RequiredPrefetchBWOTO;
-			calculate_peak_bandwidth_params->excess_vactive_fill_bw_l = mode_lib->ms.excess_vactive_fill_bw_l;
-			calculate_peak_bandwidth_params->excess_vactive_fill_bw_c = mode_lib->ms.excess_vactive_fill_bw_c;
-			calculate_peak_bandwidth_params->cursor_bw = mode_lib->ms.cursor_bw;
-			calculate_peak_bandwidth_params->dpte_row_bw = mode_lib->ms.dpte_row_bw;
-			calculate_peak_bandwidth_params->meta_row_bw = mode_lib->ms.meta_row_bw;
-			calculate_peak_bandwidth_params->prefetch_cursor_bw = mode_lib->ms.prefetch_cursor_bw;
-			calculate_peak_bandwidth_params->prefetch_vmrow_bw = mode_lib->ms.prefetch_vmrow_bw;
-			calculate_peak_bandwidth_params->flip_bw = mode_lib->ms.final_flip_bw;
-			calculate_peak_bandwidth_params->urgent_burst_factor_l = mode_lib->ms.UrgentBurstFactorLuma;
-			calculate_peak_bandwidth_params->urgent_burst_factor_c = mode_lib->ms.UrgentBurstFactorChroma;
-			calculate_peak_bandwidth_params->urgent_burst_factor_cursor = mode_lib->ms.UrgentBurstFactorCursor;
-			calculate_peak_bandwidth_params->urgent_burst_factor_prefetch_l = mode_lib->ms.UrgentBurstFactorLumaPre;
-			calculate_peak_bandwidth_params->urgent_burst_factor_prefetch_c = mode_lib->ms.UrgentBurstFactorChromaPre;
-			calculate_peak_bandwidth_params->urgent_burst_factor_prefetch_cursor = mode_lib->ms.UrgentBurstFactorCursorPre;
-
-			calculate_peak_bandwidth_required(
-					&mode_lib->scratch,
-					calculate_peak_bandwidth_params);
-
-			calculate_immediate_flip_bandwidth_support(
-				&s->dummy_single[0], // double* frac_urg_bandwidth_flip
-				&mode_lib->ms.support.ImmediateFlipSupport,
-
-				dml2_core_internal_soc_state_sys_active,
-				mode_lib->ms.support.urg_bandwidth_required_flip,
-				mode_lib->ms.support.non_urg_bandwidth_required_flip,
-				mode_lib->ms.support.urg_bandwidth_available);
-
-			for (k = 0; k <= mode_lib->ms.num_active_planes - 1; k++) {
-				if (display_cfg->plane_descriptors[k].immediate_flip == true && mode_lib->ms.ImmediateFlipSupportedForPipe[k] == false)
-					mode_lib->ms.support.ImmediateFlipSupport = false;
-			}
-
-		} else { // if prefetch not support, assume iflip is not supported too
-			mode_lib->ms.support.ImmediateFlipSupport = false;
-		}
-
-		s->mSOCParameters.UrgentLatency = mode_lib->ms.UrgLatency;
-		s->mSOCParameters.ExtraLatency = mode_lib->ms.ExtraLatency;
-		s->mSOCParameters.ExtraLatency_sr = mode_lib->ms.ExtraLatency_sr;
-		s->mSOCParameters.WritebackLatency = mode_lib->soc.qos_parameters.writeback.base_latency_us;
-		s->mSOCParameters.DRAMClockChangeLatency = mode_lib->soc.power_management_parameters.dram_clk_change_blackout_us;
-		s->mSOCParameters.FCLKChangeLatency = mode_lib->soc.power_management_parameters.fclk_change_blackout_us;
-		s->mSOCParameters.SRExitTime = mode_lib->soc.power_management_parameters.stutter_exit_latency_us;
-		s->mSOCParameters.SREnterPlusExitTime = mode_lib->soc.power_management_parameters.stutter_enter_plus_exit_latency_us;
-		s->mSOCParameters.SRExitZ8Time = mode_lib->soc.power_management_parameters.z8_stutter_exit_latency_us;
-		s->mSOCParameters.SREnterPlusExitZ8Time = mode_lib->soc.power_management_parameters.z8_stutter_enter_plus_exit_latency_us;
-		s->mSOCParameters.USRRetrainingLatency = 0;
-		s->mSOCParameters.SMNLatency = 0;
-		s->mSOCParameters.g6_temp_read_blackout_us = get_g6_temp_read_blackout_us(&mode_lib->soc, (unsigned int)(mode_lib->ms.uclk_freq_mhz * 1000), in_out_params->min_clk_index);
-		s->mSOCParameters.max_urgent_latency_us = get_max_urgent_latency_us(&mode_lib->soc.qos_parameters.qos_params.dcn4x, mode_lib->ms.uclk_freq_mhz, mode_lib->ms.FabricClock, in_out_params->min_clk_index);
-		s->mSOCParameters.df_response_time_us = mode_lib->soc.qos_parameters.qos_params.dcn4x.df_qos_response_time_fclk_cycles / mode_lib->ms.FabricClock;
-		s->mSOCParameters.qos_type = mode_lib->soc.qos_parameters.qos_type;
-
-		CalculateWatermarks_params->display_cfg = display_cfg;
-		CalculateWatermarks_params->USRRetrainingRequired = false;
-		CalculateWatermarks_params->NumberOfActiveSurfaces = mode_lib->ms.num_active_planes;
-		CalculateWatermarks_params->MaxLineBufferLines = mode_lib->ip.max_line_buffer_lines;
-		CalculateWatermarks_params->LineBufferSize = mode_lib->ip.line_buffer_size_bits;
-		CalculateWatermarks_params->WritebackInterfaceBufferSize = mode_lib->ip.writeback_interface_buffer_size_kbytes;
-		CalculateWatermarks_params->DCFCLK = mode_lib->ms.DCFCLK;
-		CalculateWatermarks_params->SynchronizeTimings = display_cfg->overrides.synchronize_timings;
-		CalculateWatermarks_params->SynchronizeDRRDisplaysForUCLKPStateChange = display_cfg->overrides.synchronize_ddr_displays_for_uclk_pstate_change;
-		CalculateWatermarks_params->dpte_group_bytes = mode_lib->ms.dpte_group_bytes;
-		CalculateWatermarks_params->mmSOCParameters = s->mSOCParameters;
-		CalculateWatermarks_params->WritebackChunkSize = mode_lib->ip.writeback_chunk_size_kbytes;
-		CalculateWatermarks_params->SOCCLK = mode_lib->ms.SOCCLK;
-		CalculateWatermarks_params->DCFClkDeepSleep = mode_lib->ms.dcfclk_deepsleep;
-		CalculateWatermarks_params->DETBufferSizeY = mode_lib->ms.DETBufferSizeY;
-		CalculateWatermarks_params->DETBufferSizeC = mode_lib->ms.DETBufferSizeC;
-		CalculateWatermarks_params->SwathHeightY = mode_lib->ms.SwathHeightY;
-		CalculateWatermarks_params->SwathHeightC = mode_lib->ms.SwathHeightC;
-		CalculateWatermarks_params->SwathWidthY = mode_lib->ms.SwathWidthY;
-		CalculateWatermarks_params->SwathWidthC = mode_lib->ms.SwathWidthC;
-		CalculateWatermarks_params->DPPPerSurface = mode_lib->ms.NoOfDPP;
-		CalculateWatermarks_params->BytePerPixelDETY = mode_lib->ms.BytePerPixelInDETY;
-		CalculateWatermarks_params->BytePerPixelDETC = mode_lib->ms.BytePerPixelInDETC;
-		CalculateWatermarks_params->DSTXAfterScaler = s->DSTXAfterScaler;
-		CalculateWatermarks_params->DSTYAfterScaler = s->DSTYAfterScaler;
-		CalculateWatermarks_params->UnboundedRequestEnabled = mode_lib->ms.UnboundedRequestEnabled;
-		CalculateWatermarks_params->CompressedBufferSizeInkByte = mode_lib->ms.CompressedBufferSizeInkByte;
-		CalculateWatermarks_params->meta_row_height_l = s->meta_row_height_luma;
-		CalculateWatermarks_params->meta_row_height_c = s->meta_row_height_chroma;
-
-		// Output
-		CalculateWatermarks_params->Watermark = &mode_lib->ms.support.watermarks; // Watermarks *Watermark
-		CalculateWatermarks_params->DRAMClockChangeSupport = mode_lib->ms.support.DRAMClockChangeSupport;
-		CalculateWatermarks_params->global_dram_clock_change_supported = &mode_lib->ms.support.global_dram_clock_change_supported;
-		CalculateWatermarks_params->MaxActiveDRAMClockChangeLatencySupported = &s->dummy_single_array[0]; // double *MaxActiveDRAMClockChangeLatencySupported[]
-		CalculateWatermarks_params->SubViewportLinesNeededInMALL = mode_lib->ms.SubViewportLinesNeededInMALL; // unsigned int SubViewportLinesNeededInMALL[]
-		CalculateWatermarks_params->FCLKChangeSupport = mode_lib->ms.support.FCLKChangeSupport;
-		CalculateWatermarks_params->global_fclk_change_supported = &mode_lib->ms.support.global_fclk_change_supported;
-		CalculateWatermarks_params->MaxActiveFCLKChangeLatencySupported = &s->dummy_single[0]; // double *MaxActiveFCLKChangeLatencySupported
-		CalculateWatermarks_params->USRRetrainingSupport = &mode_lib->ms.support.USRRetrainingSupport;
-		CalculateWatermarks_params->g6_temp_read_support = &mode_lib->ms.support.g6_temp_read_support;
-		CalculateWatermarks_params->VActiveLatencyHidingMargin = mode_lib->ms.VActiveLatencyHidingMargin;
-		CalculateWatermarks_params->VActiveLatencyHidingUs = mode_lib->ms.VActiveLatencyHidingUs;
-
-		CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport(&mode_lib->scratch, CalculateWatermarks_params);
-
-		calculate_pstate_keepout_dst_lines(display_cfg, &mode_lib->ms.support.watermarks, s->dummy_integer_array[0]);
-	}
-	DML_LOG_VERBOSE("DML::%s: Done prefetch calculation\n", __func__);
-	// End of Prefetch Check
+	dml_core_ms_prefetch_check(mode_lib, display_cfg);
 
 	mode_lib->ms.support.max_urgent_latency_us = s->mSOCParameters.max_urgent_latency_us;
 
-- 
2.34.1


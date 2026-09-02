Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A935C61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D68B610EFDC;
	Wed,  2 Sep 2026 05:09:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="JzGws3y+";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010013.outbound.protection.outlook.com
 [52.101.193.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D707710EFDC
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:09:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCWUHoKPuPTQZwIUGY4AwX47dwD6M4FAJWMQREe7OhCrW3BVWqRiSdRMyV6Y3HsDDNvxgOIErdxorEr4cW61hspnEvEEzEgBO/ZR69qmGDnNwfT0drQ7CxubKWDiWeMc+gSXM2sTcISn3WPgi7kiBg13SuWbEuWiZBTSCkGvlXmLtNyz2OI5glq5amK+25YzaywWBs41wrXuIkLxAtymnXvVa+eSoAhSGMT+jx057b1OuXaajrBqT1zSDenyQbv77p2HCrKu37zevo7EhxvmMLZdrbvtHXXjG7XtngTYQGyKdEp1hKN5KTPAp+pvqPe2afx6QrFthBkLcHF9m89dmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2135B3MeRJ2IZySV+K9JFFp2BiSRDoXX+cuw6DBDPgM=;
 b=nV+mhmRC7lGWeaQpTwlgLCLHdRZ+rLo5g1cvJFOQDof5yt9Bwb32NPelUBQUDB+mC7a6kl0ENHEDMuSJYOspbYyjmDr6AfktYsI95suLxP5FiQvaT8IcFdzLU9HmZu6DXtdSI99XlVqB82IhJlU9MLeWl4dXPQ5mZI9oLMYUSe+CIRnsKzGKHhfdBGFjXo0RZ5k4c3MsWAzpeEjNF2KevIFUAGPXjl6BQElUBiVBNsR5elkTarPK+qKDudUKDbFnPgsOCdEFseGk4QXpg/stFXPAeWs2cCCQhlsC6GvhWdqdNMimRUOKcQ0Is/+Z3afwU++u5IEUU0p5IG6aUWMT7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2135B3MeRJ2IZySV+K9JFFp2BiSRDoXX+cuw6DBDPgM=;
 b=JzGws3y+gE8rm3dY1+wKLakov7YeLJkNHXXP+BEL0dvRqWxBR1Vj5bECleyTTcAxik+PWCXkngXS+ngIbGY/jPwWBMnApfkp98C+FZ/IOOZTExiyI4MUC4VmB6T3w9UODmeJwyYmcdSbpbh4IjF+TDekvGkYkYfD4RjUhSJBMKw=
Received: from BN9P222CA0023.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::28)
 by PH7PR12MB5686.namprd12.prod.outlook.com (2603:10b6:510:13d::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Wed, 2 Sep 2026
 05:09:20 +0000
Received: from LV8PEPF00000067.namprd03.prod.outlook.com
 (2603:10b6:408:10c:cafe::37) by BN9P222CA0023.outlook.office365.com
 (2603:10b6:408:10c::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.11 via Frontend Transport; Wed, 2
 Sep 2026 05:09:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF00000067.mail.protection.outlook.com (10.167.248.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:09:20 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:09:19 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:09:10 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Austin Zheng
 <austin.zheng@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 33/40] drm/amd/display: Add dml2_core_dcn6_calcs function
 pointer table
Date: Wed, 2 Sep 2026 12:58:55 +0800
Message-ID: <20260902050411.3473916-34-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000067:EE_|PH7PR12MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: cf29cf2a-d1ed-4898-94a2-08df08b05876
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|1800799024|376014|30052699003|23010399003|10067099003|18002099003|22082099003|56012099006|11063799006|6133799003|3023799007|5023799004;
X-Microsoft-Antispam-Message-Info: s5Uaqz+zon6E3e2dNbvCkweCH8aMEVMYDT9iWXbrK8V9CLu17pqr0mD8Gr1ewckvM4DXuExurDPYC6yFrkI1nUFxKmmfACoKo3O8gsNEzbh6jWVPkX5ZlBWLRV5d6/lWFuigDupk+cQxQuGvyUkSxJg1YAwWedwpY0Hic3OAbuXJT7QGWcXkTBqvJW6QJDzKivisZHBh+eyXdZiBpxVDzY3VqnaI8Whex9bODTcC96cX8cc+hEyxOG+aBONNmwhWmhNCBhKGCEmzFGHiePyZ5SO5GHU7hT75Xc2Nos4nod3kNyYDE6w6ONgEpQP/Y+II5QsCgdANz+heqMtzbR4X1MXPTwjfSdquIJGoTzrLUWc0/8/2LYu5qkZzIy1uBHVInLtajIsq7pjlc5n8HJlHWcnnNK0PHCzL/cJZgkOjIRkKP4zV2dewnVidnlfEXHpxi+A1QIRBsVKwpmL6yERbKGaoUZPG+OvFJkytXakBFwyUJmxRQbJwlrBLea3UT1HCVfanML3eUflAk31t78mFtU/ben/v+EqaeYwcr/jxqy9/y30ZW+rDKgRAKaoHnArjPheBu9ItHzMLBLew9c9DuvHBHV2V/MrvUxfvUem23gauWu5lc7mFjYE+S1Pbkw/uXgeLYbnrneogFPO3reWoxZLt5UIAjO5QMJI5l54z85T3D5/Y5JqlkVb5MDk4VKKEG6fFhoJkN7X17Hti+FjBhg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(30052699003)(23010399003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(6133799003)(3023799007)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CR7xHm6AEyaewMu0obFuWafNfLZyOc9Qp7EJGwbenoSlGXLwZtM3rQheMOwafeOfGLp1HJbrKxlvxKC50quuUXhZ9y7XxK2AA6YoNJazdaXqMXoFucH4lyefcUAx6vLB8yAla5hivm4GYKbAGbQUifkSbIR8r0e7SUFJvCLLgvHRLKfyNXDAdfjTSVq3ZJre1hr+4oRXNTqEwhY1yq/eWb7XmWjIR24roTYf7vCvi6Kq1oIHT3AzTj9lbibdJZaryC9a8YJCO8q/NeP4gxK5NoXm6u4WZD9pDo/f28tHZ6eyAxhZN7dtJUCUDfldcO19Ab9LNnHgSVsO0yntlIvI4NSS3+EVDDpN1egetV+ykx5pA9DwshB2HiNz9XVjH7Cik/Yc7EbU3p6dbOaRyOpIhnosaWqaQczHPGyMugtuAQKzuHO5HatMeTzZv5jGhFXB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:09:20.0911 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf29cf2a-d1ed-4898-94a2-08df08b05876
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000067.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5686
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

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
DCN6 core mode support/programming call DCN5 and DCN6 calcs
functions directly by name. The calcs layer needs one seam the
funcs layer can go through instead of hardcoding a generation.

[How]
Add union dml2_core_calcs holding one function pointer table
per generation, plus a calcs field on dml2_core_instance and on
the mode support/programming contexts.
Add dml2_core_dcn6_calcs.c/.h defining struct
dml2_core_dcn6_calcs, a flat table covering every DCN6 calcs
function and every DCN5 calcs function DCN6 reuses, and
dml2_core_dcn6_calcs_init() to populate it.
Call dml2_core_dcn6_calcs_init() from
dml2_core_dcn6_funcs_initialize().

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/dc/dml2_0/Makefile    |   1 +
 .../src/dml2_core/dml2_core_dcn6_calcs.c      |  63 ++-
 .../src/dml2_core/dml2_core_dcn6_calcs.h      | 468 ++++++++++++++++++
 .../dml2_core_dcn6_funcs_initialize.c         |   2 +
 .../src/inc/dml2_internal_shared_types.h      |  14 +
 5 files changed, 544 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
index 5ea79e8d84db..7ebe799e3b24 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/Makefile
@@ -128,6 +128,7 @@ DML21 += src/dml2_utm_soc_bb/dml2_utm_soc_bb_dcn5.o
 DML21 += src/dml2_utm_soc_bb/dml2_utm_soc_bb_factory.o
 DML21 += src/dml2_cga/dml2_cga_dcn6.o
 DML21 += src/dml2_cga/dml2_cga_factory.o
+DML21 += src/dml2_core/dml2_core_dcn6_calcs.o
 DML21 += src/dml2_core/dml2_core_dcn6_calcs_dchub.o
 DML21 += src/dml2_core/dml2_core_dcn6_funcs_initialize.o
 DML21 += src/dml2_core/dml2_core_dcn6_funcs_mode_programming.o
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs.c
index c86e9c5feec4..a20eaaf9f1e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs.c
@@ -3,9 +3,64 @@
 // Copyright 2026 Advanced Micro Devices, Inc.
 
 #include "dml2_core_dcn6_calcs.h"
+#include "dml2_core_dcn6_calcs_dchub.h"
+#include "dml2_core_dcn5_calcs_dchub.h"
+#include "dml2_core_dcn5_calcs_display_pipe.h"
 
-/*
- * Placeholder for future DCN6 calcs table implementation.
- * Remove this typedef once real declarations are added here.
+static const struct dml2_core_dcn6_calcs dcn6_calcs_funcs = {
+	.calculate_max_vstartup = dcn6_calculate_max_vstartup,
+	.calculate_alternate_params = dcn6_calculate_alternate_params,
+	.calculate_alternate_svp_lines = dcn6_calculate_alternate_svp_lines,
+	.calculate_flip_schedule = dcn6_calculate_flip_schedule,
+	.get_pipe_regs = dcn6_get_pipe_regs,
+	.calculate_watermarks_and_dram_speed_change_support = dcn6_calculate_watermarks_and_dram_speed_change_support,
+	.calculate_stutter_efficiency = dcn6_calculate_stutter_efficiency,
+	.get_watermarks = dcn6_get_watermarks,
+	.calculate_excess_vactive_bandwidth_required = dcn6_calculate_excess_vactive_bandwidth_required,
+	.calculate_pstate_schedule_windows = dcn6_calculate_pstate_schedule_windows,
+	.calculate_pstate_schedule_admissibility = dcn6_calculate_pstate_schedule_admissibility,
+
+	.calculate_max_det_and_min_compressed_buffer_size = dcn5_calculate_max_det_and_min_compressed_buffer_size,
+	.adjust_pixel_clock_for_progressive_to_interlace_unit = dcn5_adjust_pixel_clock_for_progressive_to_interlace_unit,
+	.calculate_byte_per_pixel_and_block_sizes = dcn5_calculate_byte_per_pixel_and_block_sizes,
+	.calculate_single_pipe_dppclk_and_scl_throughput = dcn5_calculate_single_pipe_dppclk_and_scl_throughput,
+	.calculate_swath_and_det_configuration = dcn5_calculate_swath_and_det_configuration,
+	.calculate_output_link = dcn5_calculate_output_link,
+	.calculate_odm_mode = dcn5_calculate_odm_mode,
+	.calculate_write_back_dispclk = dcn5_calculate_write_back_dispclk,
+	.calculate_required_dtbclk = dcn5_calculate_required_dtbclk,
+	.calculate_dsc_delay_requirement = dcn5_calculate_dsc_delay_requirement,
+	.calculate_vm_row_and_swath = dcn5_calculate_vm_row_and_swath,
+	.calculate_bytes_to_fetch_required_to_hide_latency = dcn5_calculate_bytes_to_fetch_required_to_hide_latency,
+	.calculate_cursor_req_attributes = dcn5_calculate_cursor_req_attributes,
+	.calculate_cursor_urgent_burst_factor = dcn5_calculate_cursor_urgent_burst_factor,
+	.calculate_urgent_burst_factor = dcn5_calculate_urgent_burst_factor,
+	.calculate_dcfclk_deep_sleep = dcn5_calculate_dcfclk_deep_sleep,
+	.calculate_write_back_delay = dcn5_calculate_write_back_delay,
+	.calculate_mcache_setting = dcn5_calculate_mcache_setting,
+	.calculate_avg_bandwidth_required = dcn5_calculate_avg_bandwidth_required,
+	.calculate_hostvm_inefficiency_factor = dcn5_calculate_hostvm_inefficiency_factor,
+	.calculate_tdlut_setting = dcn5_calculate_tdlut_setting,
+	.calculate_extra_latency = dcn5_calculate_extra_latency,
+	.calculate_t_wait = dcn5_calculate_t_wait,
+	.calculate_prefetch_schedule = dcn5_calculate_prefetch_schedule,
+	.calculate_peak_bandwidth_required = dcn5_calculate_peak_bandwidth_required,
+	.calculate_vactive_det_fill_latency = dcn5_calculate_vactive_det_fill_latency,
+	.calculate_dcc_configuration = dcn5_calculate_dcc_configuration,
+	.calculate_pixel_delivery_times = dcn5_calculate_pixel_delivery_times,
+	.calculate_meta_and_pte_times = dcn5_calculate_meta_and_pte_times,
+	.calculate_vm_group_and_request_times = dcn5_calculate_vm_group_and_request_times,
+	.calculate_pstate_keepout_dst_lines = dcn5_calculate_pstate_keepout_dst_lines,
+	.get_arb_params = dcn5_get_arb_params,
+};
+
+/**
+ * dml2_core_dcn6_calcs_init() - Register the DCN6 calcs function pointer table.
+ * @calcs: calcs union to populate.
+ *
+ * Return: void
  */
-typedef int dml2_core_dcn6_calcs_placeholder;
+void dml2_core_dcn6_calcs_init(union dml2_core_calcs *calcs)
+{
+	calcs->dcn6 = &dcn6_calcs_funcs;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs.h
index 35f7d8a050a7..87252b658c16 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_calcs.h
@@ -4,5 +4,473 @@
 
 #ifndef __DML2_CORE_DCN6_CALCS_H__
 #define __DML2_CORE_DCN6_CALCS_H__
+#include "dml2_internal_shared_types.h"
+
+/*
+ * Flat table of every calcs function reachable from the DCN6 funcs layer
+ * (both DCN6-specific calcs and DCN5 calcs reused unmodified by DCN6).
+ * Slot names carry no generation prefix, only the assigned symbols do.
+ */
+struct dml2_core_dcn6_calcs {
+	unsigned int (*calculate_max_vstartup)(
+			bool ptoi_supported,
+			unsigned int vblank_nom_default_us,
+			const struct dml2_timing_cfg *timing,
+			enum dml2_uclk_pstate_change_strategy pstate_strategy,
+			double write_back_delay_us,
+			unsigned int svp_lines);
+	void (*calculate_alternate_params)(struct dml2_core_calcs_calculate_alternate_params *p);
+	void (*calculate_alternate_svp_lines)(struct dml2_core_calcs_calculate_alternate_svp_lines *p);
+	void (*calculate_flip_schedule)(
+			struct dml2_core_internal_scratch *s,
+			bool iflip_enable,
+			bool ihostvm_enable,
+			bool iffbm_enable,
+			double HostVMInefficiencyFactor,
+			double Tvm_trips_flip,
+			double Tr0_trips_flip,
+			double Tvm_trips_flip_rounded,
+			double Tr0_trips_flip_rounded,
+			bool GPUVMEnable,
+			double vm_bytes,
+			double DPTEBytesPerRow,
+			enum dml2_source_format_class SourcePixelFormat,
+			double LineTime,
+			double VRatio,
+			double VRatioChroma,
+			double Tno_bw_flip,
+			unsigned int dpte_row_height,
+			unsigned int dpte_row_height_chroma,
+			unsigned int max_flip_time_us,
+			unsigned int max_flip_time_lines,
+			unsigned int meta_row_height,
+			unsigned int meta_row_height_chroma,
+
+			// Output
+			double *dst_y_per_vm_flip,
+			double *dst_y_per_row_flip,
+			double *final_flip_bw,
+			bool *ImmediateFlipSupportedForPipe);
+	void (*get_pipe_regs)(const struct dml2_display_cfg *display_cfg,
+			const struct dml2_core_internal_display_mode_lib *mode_lib,
+			struct dml2_dchub_per_pipe_register_set *out, int pipe_index, const struct dml2_utm_soc_bb *utm_soc_bb,
+			struct dml2_core_internal_scratch *s);
+	void (*calculate_watermarks_and_dram_speed_change_support)(
+			struct dml2_core_internal_scratch *scratch,
+			struct dml2_core_calcs_CalculateWatermarksMALLUseAndDRAMSpeedChangeSupport_params *p);
+	void (*calculate_stutter_efficiency)(struct dml2_core_internal_scratch *scratch,
+			struct dml2_core_calcs_CalculateStutterEfficiency_params *p);
+	void (*get_watermarks)(const struct dml2_display_cfg *display_cfg, const struct dml2_core_internal_display_mode_lib *mode_lib,
+			const struct dml2_utm_soc_bb *utm_soc_bb, struct dml2_dchub_watermark_regs *out);
+	void (*calculate_excess_vactive_bandwidth_required)(
+			const struct dml2_display_cfg *display_cfg,
+			unsigned int bytes_required_l[dml2_pstate_type_count][DML2_MAX_PLANES],
+			unsigned int bytes_required_c[dml2_pstate_type_count][DML2_MAX_PLANES],
+			/* outputs */
+			double excess_vactive_fill_bw_l[],
+			double excess_vactive_fill_bw_c[]);
+	void (*calculate_pstate_schedule_windows)(
+			int num_active_planes,
+			const unsigned int v_blank_start[DML2_MAX_PLANES],
+			const unsigned int v_blank_end[DML2_MAX_PLANES],
+			const double otg_vline_time_us[DML2_MAX_PLANES],
+			const double det_fill_delay_us[DML2_MAX_PLANES],
+			const double reserved_vblank_us[DML2_MAX_PLANES],
+			const double blackout_us,
+			// Outputs
+			double allow_start_us[DML2_MAX_PLANES],
+			double allow_end_us[DML2_MAX_PLANES]);
+	void (*calculate_pstate_schedule_admissibility)(
+			uint32_t num_active_planes,
+			double max_allow_delay_us,
+			double min_allow_width_us,
+			const uint32_t timing_group_id[DML2_MAX_PLANES],
+			uint32_t timing_group_count,
+			const double frame_time_us[DML2_MAX_PLANES],
+			const double allow_start_us[DML2_MAX_PLANES],
+			const double allow_end_us[DML2_MAX_PLANES],
+			const enum dml2_pstate_method pstate_method[DML2_MAX_PLANES],
+			const bool drr_enabled[DML2_MAX_DCN_PIPES],
+			// Output
+			double allow_window_us[DML2_MAX_DCN_PIPES],
+			double disallow_window_us[DML2_MAX_DCN_PIPES],
+			bool *pstate_admissible);
+
+	/* DCN5 calcs reused unmodified by DCN6 */
+	void (*calculate_max_det_and_min_compressed_buffer_size)(
+			unsigned int ConfigReturnBufferSizeInKByte,
+			unsigned int ConfigReturnBufferSegmentSizeInKByte,
+			unsigned int ROBBufferSizeInKByte,
+			unsigned int MaxNumDPP,
+			unsigned int nomDETInKByteOverrideEnable,
+			unsigned int nomDETInKByteOverrideValue,
+			bool is_mrq_present,
+
+			// Output
+			unsigned int *MaxTotalDETInKByte,
+			unsigned int *nomDETInKByte,
+			unsigned int *MinCompressedBufferSizeInKByte);
+	void (*adjust_pixel_clock_for_progressive_to_interlace_unit)(const struct dml2_display_cfg *display_cfg,
+			bool ptoi_supported, double *PixelClockBackEnd);
+	void (*calculate_byte_per_pixel_and_block_sizes)(
+			enum dml2_source_format_class SourcePixelFormat,
+			enum dml2_swizzle_mode SurfaceTiling,
+			unsigned int pitch_y,
+			unsigned int pitch_c,
+
+			// Output
+			unsigned int *BytePerPixelY,
+			unsigned int *BytePerPixelC,
+			double *BytePerPixelDETY,
+			double *BytePerPixelDETC,
+			unsigned int *BlockHeight256BytesY,
+			unsigned int *BlockHeight256BytesC,
+			unsigned int *BlockWidth256BytesY,
+			unsigned int *BlockWidth256BytesC,
+			unsigned int *MacroTileHeightY,
+			unsigned int *MacroTileHeightC,
+			unsigned int *MacroTileWidthY,
+			unsigned int *MacroTileWidthC,
+			bool *surf_linear128_l,
+			bool *surf_linear128_c);
+	void (*calculate_single_pipe_dppclk_and_scl_throughput)(
+			double HRatio,
+			double HRatioChroma,
+			double VRatio,
+			double VRatioChroma,
+			double MaxDCHUBToPSCLThroughput,
+			double MaxPSCLToLBThroughput,
+			double PixelClock,
+			enum dml2_source_format_class SourcePixelFormat,
+			unsigned int HTaps,
+			unsigned int HTapsChroma,
+			unsigned int VTaps,
+			unsigned int VTapsChroma,
+
+			// Output
+			double *PSCL_THROUGHPUT,
+			double *PSCL_THROUGHPUT_CHROMA,
+			double *DPPCLKUsingSingleDPP);
+	void (*calculate_swath_and_det_configuration)(struct dml2_core_internal_scratch *scratch,
+			struct dml2_core_calcs_CalculateSwathAndDETConfiguration_params *p);
+	void (*calculate_output_link)(
+			struct dml2_core_internal_scratch *s,
+			double PHYCLK,
+			double PHYCLKD18,
+			double PHYCLKD32,
+			double Downspreading,
+			enum dml2_output_encoder_class Output,
+			enum dml2_output_format_class OutputFormat,
+			unsigned int HTotal,
+			unsigned int HActive,
+			double PixelClockBackEnd,
+			double ForcedOutputLinkBPP,
+			unsigned int DSCInputBitPerComponent,
+			unsigned int NumberOfDSCSlices,
+			double AudioSampleRate,
+			unsigned int AudioSampleLayout,
+			enum dml2_odm_mode ODMModeNoDSC,
+			enum dml2_odm_mode ODMModeDSC,
+			enum dml2_dsc_enable_option DSCEnable,
+			unsigned int OutputLinkDPLanes,
+			enum dml2_output_link_dp_rate OutputLinkDPRate,
+
+			// Output
+			bool *RequiresDSC,
+			bool *RequiresFEC,
+			double *OutBpp,
+			enum dml2_core_internal_output_type *OutputType,
+			enum dml2_core_internal_output_type_rate *OutputRate,
+			unsigned int *RequiredSlots);
+	void (*calculate_odm_mode)(
+			unsigned int MaximumPixelsPerLinePerDSCUnit,
+			unsigned int HActive,
+			enum dml2_output_format_class OutFormat,
+			enum dml2_output_encoder_class Output,
+			enum dml2_odm_mode ODMUse,
+			double MaxDispclk,
+			bool DSCEnable,
+			unsigned int TotalNumberOfActiveDPP,
+			unsigned int MaxNumDPP,
+			double PixelClock,
+			unsigned int MaximumSlicesPerDSCUnit,
+			unsigned int NumberOfDSCSlices,
+			unsigned int odm_combine_support_mask,
+
+			// Output
+			bool *TotalAvailablePipesSupport,
+			unsigned int *NumberOfDPP,
+			enum dml2_odm_mode *ODMMode,
+			double *RequiredDISPCLKPerSurface);
+	double (*calculate_write_back_dispclk)(
+			enum dml2_source_format_class WritebackPixelFormat,
+			double PixelClock,
+			enum dml2_odm_mode ODMMode,
+			double WritebackHRatio,
+			double WritebackVRatio,
+			unsigned int WritebackHTaps,
+			unsigned int WritebackVTaps,
+			unsigned int WritebackHTapsChroma,
+			unsigned int WritebackVTapsChroma,
+			unsigned int WritebackSourceWidth,
+			unsigned int WritebackDestinationWidth,
+			unsigned int HTotal,
+			unsigned int WritebackLineBufferSize);
+	double (*calculate_required_dtbclk)(
+			bool DSCEnable,
+			double PixelClock,
+			enum dml2_output_format_class OutputFormat,
+			double OutputBpp,
+			unsigned int DSCSlices,
+			unsigned int HTotal,
+			unsigned int HActive,
+			unsigned int AudioRate,
+			unsigned int AudioLayout);
+	unsigned int (*calculate_dsc_delay_requirement)(
+			bool DSCEnabled,
+			enum dml2_odm_mode ODMMode,
+			unsigned int DSCInputBitPerComponent,
+			double OutputBpp,
+			unsigned int HActive,
+			unsigned int HTotal,
+			unsigned int NumberOfDSCSlices,
+			enum dml2_output_format_class OutputFormat,
+			enum dml2_output_encoder_class Output,
+			double PixelClock,
+			double PixelClockBackEnd,
+			bool use_legacy_dsc_delay_formula);
+	void (*calculate_vm_row_and_swath)(struct dml2_core_internal_scratch *scratch,
+			struct dml2_core_calcs_CalculateVMRowAndSwath_params *p);
+	void (*calculate_bytes_to_fetch_required_to_hide_latency)(
+			struct dml2_core_calcs_calculate_bytes_to_fetch_required_to_hide_latency_params *p);
+	void (*calculate_cursor_req_attributes)(
+			unsigned int cursor_width,
+			unsigned int cursor_bpp,
+
+			// output
+			unsigned int *cursor_lines_per_chunk,
+			unsigned int *cursor_bytes_per_line,
+			unsigned int *cursor_bytes_per_chunk,
+			unsigned int *cursor_bytes);
+	void (*calculate_cursor_urgent_burst_factor)(
+			unsigned int CursorBufferSize,
+			unsigned int CursorWidth,
+			unsigned int cursor_bytes_per_chunk,
+			unsigned int cursor_lines_per_chunk,
+			double LineTime,
+			double UrgentLatency,
+
+			double *UrgentBurstFactorCursor,
+			bool *NotEnoughUrgentLatencyHiding);
+	void (*calculate_urgent_burst_factor)(
+			const struct dml2_plane_parameters *plane_cfg,
+			unsigned int swath_width_luma_ub,
+			unsigned int swath_width_chroma_ub,
+			unsigned int SwathHeightY,
+			unsigned int SwathHeightC,
+			double LineTime,
+			double UrgentLatency,
+			double VRatio,
+			double VRatioC,
+			double BytePerPixelInDETY,
+			double BytePerPixelInDETC,
+			bool UnboundedRequestEnabled,
+			unsigned int CompressedBufferSizeInkByte,
+			unsigned int DETBufferSizeY,
+			unsigned int DETBufferSizeC,
+			// Output
+			double *UrgentBurstFactorLuma,
+			double *UrgentBurstFactorChroma,
+			bool *NotEnoughUrgentLatencyHiding);
+	void (*calculate_dcfclk_deep_sleep)(
+			const struct dml2_display_cfg *display_cfg,
+			unsigned int NumberOfActiveSurfaces,
+			unsigned int BytePerPixelY[],
+			unsigned int BytePerPixelC[],
+			unsigned int SwathWidthY[],
+			unsigned int SwathWidthC[],
+			unsigned int DPPPerSurface[],
+			double PSCL_THROUGHPUT[],
+			double PSCL_THROUGHPUT_CHROMA[],
+			double Dppclk[],
+			double ReadBandwidthLuma[],
+			double ReadBandwidthChroma[],
+			unsigned int ReturnBusWidth,
+
+			// Output
+			double *DCFClkDeepSleep);
+	double (*calculate_write_back_delay)(
+			enum dml2_source_format_class WritebackPixelFormat,
+			double WritebackHRatio,
+			double WritebackVRatio,
+			unsigned int WritebackVTaps,
+			unsigned int WritebackVTapsChroma,
+			unsigned int WritebackDestinationWidth,
+			unsigned int WritebackDestinationHeight,
+			unsigned int WritebackSourceWidth,
+			unsigned int WritebackSourceHeight,
+			unsigned int HTotal);
+	void (*calculate_mcache_setting)(
+			struct dml2_core_internal_scratch *scratch,
+			struct dml2_core_calcs_calculate_mcache_setting_params *p);
+	void (*calculate_avg_bandwidth_required)(
+			double *avg_bandwidth_required,
+
+			// input
+			unsigned int num_active_planes,
+			double ReadBandwidthLuma[],
+			double ReadBandwidthChroma[],
+			double cursor_bw[],
+			double dcc_dram_bw_nom_overhead_factor_p0[],
+			double dcc_dram_bw_nom_overhead_factor_p1[]);
+	void (*calculate_hostvm_inefficiency_factor)(
+			double *HostVMInefficiencyFactor,
+			double *HostVMInefficiencyFactorPrefetch,
+
+			bool gpuvm_enable,
+			bool hostvm_enable,
+			unsigned int remote_iommu_outstanding_translations,
+			unsigned int max_outstanding_reqs,
+			double urg_bandwidth_avail_active_pixel_and_vm,
+			double urg_bandwidth_avail_active_vm_only);
+	void (*calculate_tdlut_setting)(
+			struct dml2_core_internal_scratch *scratch,
+			struct dml2_core_calcs_calculate_tdlut_setting_params *p);
+	void (*calculate_extra_latency)(
+			const struct dml2_display_cfg *display_cfg,
+			unsigned int ROBBufferSizeInKByte,
+			unsigned int RoundTripPingLatencyCycles,
+			unsigned int ReorderingBytes,
+			double DCFCLK,
+			double FabricClock,
+			unsigned int PixelChunkSizeInKByte,
+			double ReturnBW,
+			unsigned int NumberOfActiveSurfaces,
+			unsigned int NumberOfDPP[],
+			unsigned int dpte_group_bytes[],
+			unsigned int tdlut_bytes_per_group[],
+			double HostVMInefficiencyFactor,
+			double HostVMInefficiencyFactorPrefetch,
+			enum dml2_qos_param_type qos_type,
+			bool max_outstanding_when_urgent_expected,
+			unsigned int max_outstanding_requests,
+			unsigned int request_size_bytes_luma[],
+			unsigned int request_size_bytes_chroma[],
+			unsigned int MetaChunkSize,
+			unsigned int dchub_arb_to_ret_delay,
+			double Ttrip,
+			unsigned int hostvm_mode,
+
+			// output
+			double *ExtraLatency,
+			double *ExtraLatency_sr,
+			double *ExtraLatencyPrefetch);
+	double (*calculate_t_wait)(
+			long reserved_vblank_time_ns,
+			double UrgentLatency,
+			double Ttrip,
+			double temp_read_or_ppt_blackout_us,
+			bool drr_enabled);
+	bool (*calculate_prefetch_schedule)(struct dml2_core_internal_scratch *scratch, struct dml2_core_calcs_CalculatePrefetchSchedule_params *p);
+	void (*calculate_peak_bandwidth_required)(
+			struct dml2_core_internal_scratch *s,
+			struct dml2_core_calcs_calculate_peak_bandwidth_required_params *p);
+	void (*calculate_vactive_det_fill_latency)(
+			const struct dml2_display_cfg *display_cfg,
+			unsigned int num_active_planes,
+			unsigned int bytes_required_l[],
+			unsigned int bytes_required_c[],
+			double dcc_dram_bw_nom_overhead_factor_p0[],
+			double dcc_dram_bw_nom_overhead_factor_p1[],
+			double surface_read_bw_l[],
+			double surface_read_bw_c[],
+			double surface_avg_vactive_required_bw[],
+			double surface_peak_required_bw[],
+			/* output */
+			double vactive_det_fill_delay_us[]);
+	void (*calculate_dcc_configuration)(
+			bool DCCEnabled,
+			bool DCCProgrammingAssumesScanDirectionUnknown,
+			enum dml2_source_format_class SourcePixelFormat,
+			unsigned int SurfaceWidthLuma,
+			unsigned int SurfaceWidthChroma,
+			unsigned int SurfaceHeightLuma,
+			unsigned int SurfaceHeightChroma,
+			unsigned int nomDETInKByte,
+			unsigned int RequestHeight256ByteLuma,
+			unsigned int RequestHeight256ByteChroma,
+			enum dml2_swizzle_mode TilingFormat,
+			unsigned int BytePerPixelY,
+			unsigned int BytePerPixelC,
+			double BytePerPixelDETY,
+			double BytePerPixelDETC,
+			enum dml2_rotation_angle RotationAngle,
+
+			// Output
+			enum dml2_core_internal_request_type *RequestLuma,
+			enum dml2_core_internal_request_type *RequestChroma,
+			unsigned int *MaxUncompressedBlockLuma,
+			unsigned int *MaxUncompressedBlockChroma,
+			unsigned int *MaxCompressedBlockLuma,
+			unsigned int *MaxCompressedBlockChroma,
+			unsigned int *IndependentBlockLuma,
+			unsigned int *IndependentBlockChroma);
+	void (*calculate_pixel_delivery_times)(
+			const struct dml2_display_cfg *display_cfg,
+			unsigned int NoOfDPP[DML2_MAX_PLANES],
+			unsigned int NumberOfActiveSurfaces,
+			double VRatioPrefetchY[],
+			double VRatioPrefetchC[],
+			unsigned int swath_width_luma_ub[],
+			unsigned int swath_width_chroma_ub[],
+			double PSCL_THROUGHPUT[],
+			double PSCL_THROUGHPUT_CHROMA[],
+			double Dppclk[],
+			double DCFCLKDeepSleep,
+			unsigned int BytePerPixelY[],
+			unsigned int BytePerPixelC[],
+			unsigned int req_per_swath_ub_l[],
+			unsigned int req_per_swath_ub_c[],
+
+			// Output
+			double DisplayPipeLineDeliveryTimeLuma[],
+			double DisplayPipeLineDeliveryTimeChroma[],
+			double DisplayPipeLineDeliveryTimeLumaPrefetch[],
+			double DisplayPipeLineDeliveryTimeChromaPrefetch[],
+			double DisplayPipeRequestDeliveryTimeLuma[],
+			double DisplayPipeRequestDeliveryTimeChroma[],
+			double DisplayPipeRequestDeliveryTimeLumaPrefetch[],
+			double DisplayPipeRequestDeliveryTimeChromaPrefetch[]);
+	void (*calculate_meta_and_pte_times)(struct dml2_core_shared_CalculateMetaAndPTETimes_params *p);
+	void (*calculate_vm_group_and_request_times)(
+			const struct dml2_display_cfg *display_cfg,
+			unsigned int NumberOfActiveSurfaces,
+			unsigned int BytePerPixelC[],
+			double dst_y_per_vm_vblank[],
+			double dst_y_per_vm_flip[],
+			unsigned int dpte_row_width_luma_ub[],
+			unsigned int dpte_row_width_chroma_ub[],
+			unsigned int vm_group_bytes[],
+			unsigned int dpde0_bytes_per_frame_ub_l[],
+			unsigned int dpde0_bytes_per_frame_ub_c[],
+			unsigned int tdlut_pte_bytes_per_frame[],
+			unsigned int meta_pte_bytes_per_frame_ub_l[],
+			unsigned int meta_pte_bytes_per_frame_ub_c[],
+			bool mrq_present,
+
+			// Output
+			double TimePerVMGroupVBlank[],
+			double TimePerVMGroupFlip[],
+			double TimePerVMRequestVBlank[],
+			double TimePerVMRequestFlip[]);
+	void (*calculate_pstate_keepout_dst_lines)(
+			const struct dml2_display_cfg *display_cfg,
+			const struct dml2_core_internal_watermarks *watermarks,
+			unsigned int pstate_keepout_dst_lines[]);
+	void (*get_arb_params)(const struct dml2_display_cfg *display_cfg, const struct dml2_core_internal_display_mode_lib *mode_lib,
+			const struct dml2_utm_soc_bb *utm_soc_bb, struct dml2_display_arb_regs *out);
+};
+
+void dml2_core_dcn6_calcs_init(union dml2_core_calcs *calcs);
 
 #endif /* __DML2_CORE_DCN6_CALCS_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_initialize.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_initialize.c
index 5abce647da0a..f20cee3c46fa 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_initialize.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_initialize.c
@@ -3,6 +3,7 @@
 // Copyright 2024 Advanced Micro Devices, Inc.
 
 #include "dml2_core_dcn6_funcs_initialize.h"
+#include "dml2_core_dcn6_calcs.h"
 #include "dml2_debug.h"
 
 struct dml2_core_ip_params core_dcn6_ip_caps_base = {
@@ -160,6 +161,7 @@ bool dml2_core_dcn6_funcs_initialize(struct dml2_core_initialize_in_out *in_out)
 	memcpy(&core->clean_me_up.mode_lib.ip_caps, in_out->ip_caps, sizeof(struct dml2_ip_capabilities));
 	core->utm_soc_bb = in_out->utm_soc_bb;
 	core->clock_adjuster = in_out->clock_adjuster;
+	dml2_core_dcn6_calcs_init(&core->calcs);
 
 	DML_LOG_DEBUG("%s exit with true\n", __func__);
 	DML_LOG_COMP_IF_EXIT();
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
index 077e4480575a..8e83e81a5f3e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/inc/dml2_internal_shared_types.h
@@ -833,6 +833,17 @@ struct dml2_core_internal_state_inputs {
 struct dml2_core_internal_state_intermediates {
 	unsigned int dummy;
 };
+/*
+ * Per-generation table of DML2 core "calcs" (leaf computation) functions.
+ * Each generation registers exactly one table pointer in this union.  The funcs
+ * layer reaches the active table through get_calcs(ctx), keeping it free of
+ * direct references to generation-specific calcs symbols.
+ */
+struct dml2_core_dcn6_calcs;
+
+union dml2_core_calcs {
+	const struct dml2_core_dcn6_calcs *dcn6;
+};
 
 struct dml2_core_calculate_mp_context {
 	const struct dml2_display_cfg *display_cfg;
@@ -841,6 +852,7 @@ struct dml2_core_calculate_mp_context {
 	const struct dml2_core_internal_mode_support *ms;
 	struct dml2_core_calcs_mode_programming_locals *dummies;
 	struct dml2_core_internal_scratch *func_params;
+	union dml2_core_calcs *calcs;
 };
 struct dml2_core_calculate_ms_context {
 	const struct dml2_display_cfg *display_cfg;
@@ -849,6 +861,7 @@ struct dml2_core_calculate_ms_context {
 	const struct dml2_clock_granularity_adjuster *clock_adjuster;
 	struct dml2_core_calcs_mode_support_locals *dummies;
 	struct dml2_core_internal_scratch *func_params;
+	union dml2_core_calcs *calcs;
 };
 
 struct dml2_core_mode_support_locals {
@@ -903,6 +916,7 @@ struct dml2_core_instance {
 	struct {
 		struct dml2_core_internal_display_mode_lib mode_lib;
 	} clean_me_up;
+	union dml2_core_calcs calcs;
 };
 
 /*
-- 
2.43.0


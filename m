Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E21B8C61DD6
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:09:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62E7810EFDF;
	Wed,  2 Sep 2026 05:09:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fYLiFqPt";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012053.outbound.protection.outlook.com
 [40.107.200.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D96C10EFDF
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:09:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuxKmzu67kaqEtJskMLmuTX9x6kzqSN8XUS4CER4w0tx7JtuSDf41yZnxAmTVbwRgrIRb3YSPuzqF8971BKKam+lgaHs3HDOf2E/lzx4Jbeokf18nslCob+P8/SywtFrA5ZjVLm+216rZNGDCRjMzcrxVe7sOx9/AAuu7qOXZdu64lSN1Y/b5ItjpHi4cOnmOz6KheeJXgw+t5NFAqZBX3Ltfe7ekw4RWIqrz0X/Ws9rLh7pdeTAiVw0rNekEsb6rXQwkE5t7xp2YlnHYPGj2Br73fVlHEKnRaQ7fRnlSsd4sByD+7KPmTsKTegmjbruy111zZUISE8sLlmQvBA6tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/kKuCwuy/2i11tZp24AYlvIjF03CLnXY/EIjh2gZ9k=;
 b=e/QZU/IIezVP3qgNIxnTgHdSpmO0IyLhyLObBfPiURaZrYNfwSA8j0+AjlJ05gBfYoWq57SRsrpZCnuRGSv4g10OoJdQoPXdSzgvmwbgUAaQjIYXq1BA6Y8cbkv+W8iiW1H3nlLMX3/dA3IRBm1dBSw1QA8OvgAphyAl5htNSM6tT86kLuqZ+xUW3WIpufsh4PuXF3bK/a3DYi1WYODGn/WLf50xxlRpgxbLzbvHis3J+6WALtqlPnLEylD1iL2IZcvBFz0BWY5Kt4LZyyA37ew3FctC3qcVEaj+3e8FvXbhDqHattA73oHmhRz/Q6fLcp22Yg8391125rQL2DP3OA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/kKuCwuy/2i11tZp24AYlvIjF03CLnXY/EIjh2gZ9k=;
 b=fYLiFqPtSrj/7NIWqVFa6hSlBKX/p63MVDKMj316TYoCYVzYvunMxiw+n/EEfRkvB5Qz95Clx/J+yfiltgU6Ah0aww1H4AwbHrx7EhR3nqFPnbjGNRTz8+AqjVmrWx2FoUEuXwnjqAyrQOqieNsFg6aEmE+R4Q79vaDwUKC8630=
Received: from MW4PR03CA0031.namprd03.prod.outlook.com (2603:10b6:303:8e::6)
 by SJ5PPF0AEDE5C3D.namprd12.prod.outlook.com (2603:10b6:a0f:fc02::989) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:09:39 +0000
Received: from SJ1PEPF00002315.namprd03.prod.outlook.com
 (2603:10b6:303:8e:cafe::a8) by MW4PR03CA0031.outlook.office365.com
 (2603:10b6:303:8e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 05:09:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002315.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:09:38 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:09:38 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:09:37 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:09:29 -0500
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
Subject: [PATCH 35/40] drm/amd/display: Route DCN6 mode programming calcs
 through function pointer table
Date: Wed, 2 Sep 2026 12:58:57 +0800
Message-ID: <20260902050411.3473916-36-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002315:EE_|SJ5PPF0AEDE5C3D:EE_
X-MS-Office365-Filtering-Correlation-Id: 1423b5db-f9a0-440c-1df9-08df08b063af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|82310400026|1800799024|10067099003|6133799003|22082099003|18002099003|3023799007|11063799006|56012099006|5023799004;
X-Microsoft-Antispam-Message-Info: fkcgacXQuoTa8G4IgsSEYwY6rJnG4R+2eG7sii59anlkkh2n0Cz/LKN4WGGOUJqa4PRlyvM+yFS9rPWE6k8rV39Li53a0l9mXuA4aYMeWh4Z2X0H/jKUH3ZOnrrTBezfu/k/o0RKsD48lK0D0GxzAfMzFRu6VDIru2r8gkifB+t3IiO2KD+4G7nuOKKLRw8XI4AZoley97YDPf2d3SAVeGVTa1fQBKsQzF0Eg+09e88NlcjW6Yv+BqeqkzCrK9WbjjaF1P10+XAaBcAQf2wX0Kp7apw/3ZipojVRPufSheUrKcV8ZyAgRbPYQXFPE0/Slf2Iq4lGeYzKottMTp+Vnk9NtECrDibtxnAZWVHIaKJcKIQ+7/WlTTa2pXYn7g0Un8DcBOaoYFVyV63Q4/CuVHKtq23HxffvGh2K5g2ZRswmSjAUPN2GFcMp3bwvZTzLHVBBdkWCBoDC+CPTjJwD5LM60zuPjmkKYlj0epnwEDXFwboWQhi4Qw+KL4Bd0skV26bA3F1toczGHztcZrR/OPS6woxJ2vdqorLLIYEcjsQlio6iwEiuuqHaTAAG6TvrPRxhOfv/izXyu7sHG8b67Vv8gTp+rK82UbWx395n97w5LauFFP/9onkairGgpczpi3boMR52sJ0ZJciafO0XEV1/5m+wxyDmc1/FZgMGbYfLv8zn5LczY5lv9YWSSLS2y5ssPIti/BpCJjpOeu9dVA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(82310400026)(1800799024)(10067099003)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(56012099006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: zma81wi63bdjSLNjQq0M0G73G9MdxtRspUZPADGcFQb+O9At6UWko/63vCF616pVOW+urftELhj67zXGKCAdJlwy7TKlUVfOfIeix3rs7tpFGbyppIK1cNsrd6KxNRaiAgJFUuzkA5ZsN12Ijy4xIhWpTMQvNq2dK4NtPr/9RWbpLOHq9gJ/KbN4FxdX5PcymMmoRPackKR4WzIjilqFfrtVY/T3Oby84nf0bckV/ogQsyN+eLPHFBYWBNjAbIQbotJj2sNTfQxHerFzXaOtIGUsGsK8bsyv5trkN3sneZItRAMEmEIRqIwrVcWSuCOcp5gUUi952OkR+sjn2wwjrLuluzhFOrj8WpcX54fz6RU+cFLN+dqaHma7a4/6P+O7VpfFLDV6BUQwgO9ynQpKR1qlcVexnlCjb6cUxt64cjED5VFe2xOzB2EcdUzj2rmH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:09:38.8306 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1423b5db-f9a0-440c-1df9-08df08b063af
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002315.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF0AEDE5C3D
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
dml2_core_dcn6_funcs_mode_programming.c called DCN5 and DCN6
calcs functions directly by name, coupling the mode programming
flow to specific generations. Routing through the calcs table
lets a future core generation reuse this flow without editing it.

[How]
Add a static get_calcs(ctx) helper returning ctx->calcs->dcn6.
Replace every direct dcn5_*/dcn6_* calcs call with
get_calcs(ctx)->slot(...). dcn6_populate_mode_programming() did
not previously receive the mp context, so thread
calc_mp_ctx through it to reach get_calcs() for its three calcs
calls. Assign ctx->calcs from core->calcs in
dcn6_mp_build_calculate_mp_context(). Drop the now-unused
dml2_core_dcn5_calcs_dchub.h, dml2_core_dcn5_calcs_display_pipe.h,
and dml2_core_dcn6_calcs_dchub.h includes in favor of
dml2_core_dcn6_calcs.h.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../dml2_core_dcn6_funcs_mode_programming.c   | 38 +++++++++++--------
 1 file changed, 23 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
index 00194c608f8b..9382745fc2a2 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_programming.c
@@ -2,11 +2,14 @@
 //
 // Copyright 2025 Advanced Micro Devices, Inc.
 #include "dml2_core_dcn6_funcs_mode_programming.h"
-#include "dml2_core_dcn5_calcs_dchub.h"
-#include "dml2_core_dcn6_calcs_dchub.h"
-#include "dml2_core_dcn5_calcs_display_pipe.h"
+#include "dml2_core_dcn6_calcs.h"
 #include "dml2_core_utils.h"
 
+static const struct dml2_core_dcn6_calcs *get_calcs(const struct dml2_core_calculate_mp_context *ctx)
+{
+	return ctx->calcs->dcn6;
+}
+
 static void dcn6_mp_populate_odm_mode(const struct dml2_display_solution *solution,
 		struct dml2_core_internal_mode_program *outputs)
 {
@@ -58,7 +61,7 @@ static void dcn6_mp_calculate_dcc_configurations(struct dml2_core_calculate_mp_c
 
 	for (k = 0; k < display_cfg->num_planes; ++k) {
 		DML_LOG_VERBOSE("DML::%s: Calculate DCC configuration for surface k=%u\n", __func__, k);
-		dcn5_calculate_dcc_configuration(
+		get_calcs(ctx)->calculate_dcc_configuration(
 				display_cfg->plane_descriptors[k].surface.dcc.enable,
 				display_cfg->overrides.dcc_programming_assumes_scan_direction_unknown,
 				display_cfg->plane_descriptors[k].pixel_format,
@@ -96,7 +99,7 @@ static void dcn6_mp_calculate_pixel_delivery_times(struct dml2_core_calculate_mp
 	struct dml2_core_internal_mode_program *outputs = states;
 
 	//Display Pipeline Delivery Time in Prefetch, Groups
-	dcn5_calculate_pixel_delivery_times(
+	get_calcs(ctx)->calculate_pixel_delivery_times(
 			display_cfg,
 			inputs->NoOfDPP,
 			display_cfg->num_planes,
@@ -185,7 +188,7 @@ static void dcn6_mp_calculate_meta_and_pte_times(struct dml2_core_calculate_mp_c
 	p->TimePerMetaChunkFlip = outputs->TimePerMetaChunkFlip;
 	p->TimePerChromaMetaChunkFlip = outputs->TimePerChromaMetaChunkFlip;
 
-	dcn5_calculate_meta_and_pte_times(p);
+	get_calcs(ctx)->calculate_meta_and_pte_times(p);
 }
 
 static void dcn6_mp_calculate_vm_group_and_request_times(struct dml2_core_calculate_mp_context *ctx,
@@ -196,7 +199,7 @@ static void dcn6_mp_calculate_vm_group_and_request_times(struct dml2_core_calcul
 	struct dml2_core_internal_mode_program *inputs = states;
 	struct dml2_core_internal_mode_program *outputs = states;
 
-	dcn5_calculate_vm_group_and_request_times(
+	get_calcs(ctx)->calculate_vm_group_and_request_times(
 		display_cfg,
 		display_cfg->num_planes,
 		inputs->BytePerPixelC,
@@ -431,7 +434,7 @@ static void dcn6_mp_calculate_stutter_efficiency(struct dml2_core_calculate_mp_c
 	p->DCHUBBUB_ARB_CSTATE_MAX_CAP_MODE = &outputs->DCHUBBUB_ARB_CSTATE_MAX_CAP_MODE;
 
 	// Stutter Efficiency
-	dcn6_calculate_stutter_efficiency(func_params, p);
+	get_calcs(ctx)->calculate_stutter_efficiency(func_params, p);
 
 #ifdef __DML_VBA_ALLOW_DELTA__
 	// Calculate z8 stutter eff assuming 0 reserved space
@@ -444,7 +447,7 @@ static void dcn6_mp_calculate_stutter_efficiency(struct dml2_core_calculate_mp_c
 	p->StutterPeriod = &outputs->StutterPeriodBestCase;
 
 	// Stutter Efficiency
-	dcn6_calculate_stutter_efficiency(func_params, p);
+	get_calcs(ctx)->calculate_stutter_efficiency(func_params, p);
 #else
 	outputs->Z8StutterEfficiencyNotIncludingVBlankBestCase = outputs->Z8StutterEfficiencyNotIncludingVBlank;
 	outputs->Z8StutterEfficiencyBestCase = outputs->Z8StutterEfficiency;
@@ -506,7 +509,7 @@ static void dcn6_mp_calculate_pstate_keepout_dst_lines(struct dml2_core_calculat
 	struct dml2_core_internal_mode_program *inputs = states;
 	struct dml2_core_internal_mode_program *outputs = states;
 
-	dcn5_calculate_pstate_keepout_dst_lines(display_cfg, &inputs->Watermark,
+	get_calcs(ctx)->calculate_pstate_keepout_dst_lines(display_cfg, &inputs->Watermark,
 			outputs->pstate_keepout_dst_lines);
 }
 
@@ -958,7 +961,8 @@ static void dcn6_populate_qos_bound(struct dml2_display_cfg_programming *program
 	programming->qos_bound.lsdma_bandwidth_lb_kbps = solution->validation_result.mode_support.global.lsdma_bw_req_for_alt_kbps;
 }
 
-static void dcn6_populate_mode_programming(struct dml2_display_cfg_programming *programming,
+static void dcn6_populate_mode_programming(struct dml2_core_calculate_mp_context *ctx,
+		struct dml2_display_cfg_programming *programming,
 		struct dml2_core_internal_scratch *s,
 		const struct dml2_core_internal_display_mode_lib *mode_lib,
 		const struct dml2_display_solution *solution,
@@ -976,9 +980,10 @@ static void dcn6_populate_mode_programming(struct dml2_display_cfg_programming *
 
 	memcpy(&programming->display_config, &solution->dispcfg, sizeof(struct dml2_display_cfg));
 	dcn6_populate_min_clocks(programming, solution, utm_soc_bb);
-	dcn5_get_arb_params(&programming->display_config, mode_lib, utm_soc_bb, &programming->global_regs.arb_regs);
+	get_calcs(ctx)->get_arb_params(&programming->display_config, mode_lib, utm_soc_bb, &programming->global_regs.arb_regs);
 	programming->global_regs.num_watermark_sets = 1;
-	dcn6_get_watermarks(&programming->display_config, mode_lib, utm_soc_bb, &programming->global_regs.wm_regs[0]);
+	get_calcs(ctx)->get_watermarks(&programming->display_config, mode_lib, utm_soc_bb,
+			&programming->global_regs.wm_regs[0]);
 	dcn6_populate_stutter_support(programming, mode_lib, solution, utm_soc_bb);
 	dcn6_populate_mcache_allocation(programming, solution);
 	dcn6_populate_qos_bound(programming, solution);
@@ -1023,7 +1028,9 @@ static void dcn6_populate_mode_programming(struct dml2_display_cfg_programming *
 			total_pipe_regs_copied++;
 
 			// Populate
-			dcn6_get_pipe_regs(&programming->display_config, mode_lib, programming->plane_programming[plane_index].pipe_regs[pipe_offset], dml_internal_pipe_index, utm_soc_bb, s);
+			get_calcs(ctx)->get_pipe_regs(&programming->display_config, mode_lib,
+					programming->plane_programming[plane_index].pipe_regs[pipe_offset],
+					dml_internal_pipe_index, utm_soc_bb, s);
 
 			main_stream_index = programming->display_config.plane_descriptors[plane_index].stream_index;
 
@@ -1138,6 +1145,7 @@ static void dcn6_mp_build_calculate_mp_context(struct dml2_core_calculate_mp_con
 	ctx->ms = &mode_lib->ms;
 	ctx->dummies = &mode_lib->scratch.dml_core_mode_programming_locals;
 	ctx->func_params = &mode_lib->scratch;
+	ctx->calcs = &core->calcs;
 }
 
 static void dcn6_mp_initialize_from_ms(struct dml2_core_internal_mode_program *outputs,
@@ -1383,7 +1391,7 @@ enum dml2_status dml2_core_dcn6_funcs_populate_programming(struct dml2_core_inst
 	dcn6_mp_initialize_from_solution(&mode_lib->mp, solution, core->utm_soc_bb);
 	dcn6_mp_build_calculate_mp_context(calc_mp_ctx, core, solution);
 	dcn6_calculate_mode_programming(calc_mp_ctx, &mode_lib->mp);
-	dcn6_populate_mode_programming(programming, &mode_lib->scratch, mode_lib, solution, core->utm_soc_bb);
+	dcn6_populate_mode_programming(calc_mp_ctx, programming, &mode_lib->scratch, mode_lib, solution, core->utm_soc_bb);
 
 	DML_LOG_DEBUG("%s exit\n", __func__);
 	DML_LOG_COMP_IF_EXIT();
-- 
2.43.0


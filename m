Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E66C7C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:48:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7DEEC10F0AA;
	Wed, 15 Jul 2026 13:48:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="V+DPgz1t";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010039.outbound.protection.outlook.com [52.101.46.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DE9F10F0B9
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:48:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M57ecNeDiTukFNnkSWNR/NdWdF7t3SpinD8kfqjJRntVBM8UyCKHFOFruzycU4FOE+1nEbw9gLCUsgIXzv3ftmJio5NYlXlHgNYZfYvTefHp46CXI9xECnbQi+O8U+o/FNNOTA5pWZv5lscDFGZXcngAtkD6Sp3HpppT03XYSffq7M0QeocrPWMEt4iMOqwkvZ5o6dii7nSl1GqPrKh4qV51OkzF7/YigdCdmhPHNytHyDe9MauP1md46nTERBm3ONfdv9bblFcq5wJMJrW05sv5p5IslV0RAi+k3JxsTj9Ynhw95uLQe6gyA8hIiA2cglVgE4qBUJ8+gMNzOau18w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kGESt3lFsWo/Q2DxSk64JITodyx4Ajn/bzMs+YzTNI0=;
 b=YRliqeVwOUgIEc6d1ok6/XfnPLH+TpjCTps8ngN92V5Uqws4II10vBokRbj3U/ytvIPiM9B8eXIFsuEtmpmrT66dToPGfCpgFfB/rUTi9PuvubO9UJbkymSLbeOYQN+2eog4o1ycrQ2AZgQsbi7NKz9Ji5F+xRLgzOKn/yCuRMBDgZf+bQg12+T/N872SIBtb2el+XPwxPSl1QsMr2IFo8Ofg6mvtIR30huD63rkmb4cBAriqWop3+lTigR89UufQydjRq9coKAeJFR5d/DOsNkhopHdrWx2zFzb1J5NftKhB2aJ/smRkPXQyJL3p8hcycKlm6b/V9x9uJBF32MQcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kGESt3lFsWo/Q2DxSk64JITodyx4Ajn/bzMs+YzTNI0=;
 b=V+DPgz1tJARG/1Iqs/z8lILKKdUOT+RYFCMwq7ZVNbc3iBQADgxGATF2zCM6kle2KCZVbjRMCYqQ0b59VI25IMohrAdF1OMysaLKCQBbPKg0UFpEzHCeBQZ9D/ypARWRDJW7VPZVRXBqNxif3+4eD9bErGQEh2EesRzPRwcdDRI=
Received: from BY5PR03CA0023.namprd03.prod.outlook.com (2603:10b6:a03:1e0::33)
 by PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:48:27 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::9e) by BY5PR03CA0023.outlook.office365.com
 (2603:10b6:a03:1e0::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.10 via Frontend Transport; Wed,
 15 Jul 2026 13:48:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:48:26 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:48:21 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:48:20 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:48:17 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Dominik Kaszewski
 <dominik.kaszewski@amd.com>
Subject: [PATCH 55/70] drm/amd/display: Introduce program_perfmon hwss hook
 and BLS perfmon sequence
Date: Wed, 15 Jul 2026 21:38:05 +0800
Message-ID: <20260715134432.1975118-56-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|PH8PR12MB6914:EE_
X-MS-Office365-Filtering-Correlation-Id: c8cf3096-e8ab-4152-c4b4-08dee277bf42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|30052699003|1800799024|23010399003|36860700016|56012099006|5023799004|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HG+F06+I5TIGY6nX+317NJunIMAQKUvpfp1+mDKcHXaco2FHgF1zQTmFJM14lFHimz6F9N9oS61i2/Z6A1TwlAcAPfrtozef0mqjkfEvnVXQGNoDi3IZQB/BPxjD5dKEDUGUx5sIjUsf/9r5JDoih9vPhYdKwQ1R5MuEENF7xVyZQm0D5hMU1yeAaEAtHVxcgU5oBEbCJg2D7TYMH9fJLO2jFrhhkAsS1vxf0pz6KLWpNoCXupwhNrjyxKBfccCQtp03vi5veeNWNgoEXJCBJhRR3m7ujtkVNFwTeB1YBDsnneSB9GJKp6VOPq3pvZM1cSDndaaYIwXKo6KsQ3lu89Za4Q5735xmAFUoAGJ1MjIJcf1zKtjgFPjjF+ljK7ptDqhLiN0Z5+/lHbuFwvXNZZpTQVUE7K9nV27xWns+yOdTv+QGEQaaILNx6rtd2BgIEAJeEDvP0lnB6YMQ9eorm7XqISI3Cl6y+GMR8VMSmdgdPPuXMPr1AsZ09OotoYYVrzNO3tCO/HE7zC47RY620ag30Yyydsv/88Uasbcpwh0rHCzCWzVQ3yZYOL2SqgrOJdwzd19y+T85usF8U2NkPEZT9HOc82esWd9BoRtSPBYbXVRAtNKx7VqjHR1o1UUAHJO/OI3FgcvKIqgmf78MtNCUahXcAffryEt+G6f+2NAAlWuYubKKItQ3Tbdty+hR0XLRYIHhooLzmmvLtIkvKw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(30052699003)(1800799024)(23010399003)(36860700016)(56012099006)(5023799004)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aJ4ojwgzKaDqpkfklOWPhGs0lavpMZhpfYPK5Ss7K25A60HXihpyEZ6Mwk1HYjmQaXyBTgTz+8dSKk0IdVkabU7IU2cbHkw+VeHHM0elHRHMqH3EadQRukZSajZ4aqIB8NrlcREnWT7PFU2qgHU4D4oEWUJsEaWOW1BZIk2n+d0yZ2t5bFBY8sf281rQU2uKWFrp4iiwK40QJppFkT0dG3MEEGl59cy1R/K1omEUPTMBolo/DSKZTas2MTDn7gsgRr2UfMeO+qVYXeWITUIi8HhvQY64S3MuDRBTKL/2YsMIz/1jZjMPO1r1tdf48C9b5UVyBrXJcx7cASrJVTzlXJwsFV0uVJmPc2gs+oFRzJb2dVgfVoqDNYwrKm9B8kLmsigKjOInyHGwFoPO+mEmrvdiZschQJ+3tAtzo95W98DN1ch7otksyyjx7N/8DruX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:48:26.9710 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8cf3096-e8ab-4152-c4b4-08dee277bf42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6914
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
The hubbub perfmon peak-bandwidth path used a monolithic function
combining counter configuration and enable in one call, and wrote results
into a caller-supplied struct outside the dc_state model. A BLS-driven
approach builds the measurement from stateless primitives, gates it to OTG
frame boundaries, and stores results in dc_state.

[How]
- Rename the peak-BW vtable members from "unbounded_bandwidth" to
  "out_of_order_bandwidth" and split them into arm and start operations.
- Add the full set of perfmon BLS primitives - param structs, union
  members, enum entries, executors, and hwss_add_* builders - for reset,
  arm, every start_measuring_* and every get_* operation.
- Add dc_probe_status (valid, type, result union) plus probe_status[] to
  dc_state.
- Replace the measure_memory_qos hook with program_perfmon(dc, context),
  which writes results into probe_status[].
- dc_get_qos_info no longer calls the removed hook.

Reviewed-by: Dominik Kaszewski <dominik.kaszewski@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  17 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 337 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_state.c    |   1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 191 +++++++++-
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  27 ++
 .../gpu/drm/amd/display/dc/inc/hw/dchubbub.h  |  12 +-
 6 files changed, 562 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 3fa577a02df1..a3665c49a381 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -8125,24 +8125,13 @@ void dc_log_preos_dmcub_info(const struct dc *dc)
 bool dc_get_qos_info(struct dc *dc, struct dc_qos_info *info)
 {
 	const struct dc_clocks *clk = &dc->current_state->bw_ctx.bw.dcn.clk;
-	struct dc_measured_memory_qos measured = {};
 	struct dc_requested_memory_qos requested = {};
 
 	memset(info, 0, sizeof(*info));
 
-	// Check if measurement function is available
-	if (!dc->hwss.measure_memory_qos) {
-		return false;
-	}
-
-	dc->hwss.measure_memory_qos(dc, &measured);
-
-	info->actual_peak_bw_in_mbps    = measured.peak_bw_mbps;
-	info->actual_avg_bw_in_mbps     = measured.avg_bw_mbps;
-	info->actual_min_latency_in_ns  = measured.min_latency_ns;
-	info->actual_max_latency_in_ns  = measured.max_latency_ns;
-	info->actual_avg_latency_in_ns  = measured.avg_latency_ns;
-	info->dcn_bandwidth_ub_in_mbps  = (uint32_t)(clk->fclk_khz / 1000 * 64);
+	/* TODO: remove the actual_* fields from struct dc_qos_info once all callers
+	 * read measured QoS from dc_state probe_status instead of this struct. */
+	info->dcn_bandwidth_ub_in_mbps = (uint32_t)(clk->fclk_khz / 1000 * 64);
 
 	if (dc->clk_mgr && dc->clk_mgr->funcs->get_requested_memory_qos) {
 		dc->clk_mgr->funcs->get_requested_memory_qos(dc->clk_mgr, &requested);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 6002175420a0..07ec00e11f2d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1495,6 +1495,48 @@ void hwss_execute_sequence(struct dc *dc,
 		case HUBBUB_SOFT_RESET:
 			hwss_hubbub_soft_reset(params);
 			break;
+		case HUBBUB_PERFMON_RESET:
+			hwss_hubbub_perfmon_reset(params);
+			break;
+		case HUBBUB_PERFMON_ARM_OUT_OF_ORDER_BW:
+			hwss_hubbub_perfmon_arm_out_of_order_bw(params);
+			break;
+		case HUBBUB_PERFMON_START_OUT_OF_ORDER_BW:
+			hwss_hubbub_perfmon_start_out_of_order_bw(params);
+			break;
+		case HUBBUB_PERFMON_START_IN_ORDER_BW:
+			hwss_hubbub_perfmon_start_in_order_bw(params);
+			break;
+		case HUBBUB_PERFMON_START_MEMORY_LATENCIES:
+			hwss_hubbub_perfmon_start_memory_latencies(params);
+			break;
+		case HUBBUB_PERFMON_START_URGENT_ASSERTION_COUNT:
+			hwss_hubbub_perfmon_start_urgent_assertion_count(params);
+			break;
+		case HUBBUB_PERFMON_START_URGENT_RAMP_LATENCY:
+			hwss_hubbub_perfmon_start_urgent_ramp_latency(params);
+			break;
+		case HUBBUB_PERFMON_START_PREFETCH_DATA_SIZE:
+			hwss_hubbub_perfmon_start_prefetch_data_size(params);
+			break;
+		case HUBBUB_PERFMON_GET_OUT_OF_ORDER_BW:
+			hwss_hubbub_perfmon_get_out_of_order_bw(params);
+			break;
+		case HUBBUB_PERFMON_GET_IN_ORDER_BW:
+			hwss_hubbub_perfmon_get_in_order_bw(params);
+			break;
+		case HUBBUB_PERFMON_GET_MEMORY_LATENCIES:
+			hwss_hubbub_perfmon_get_memory_latencies(params);
+			break;
+		case HUBBUB_PERFMON_GET_URGENT_ASSERTION_COUNT:
+			hwss_hubbub_perfmon_get_urgent_assertion_count(params);
+			break;
+		case HUBBUB_PERFMON_GET_PREFETCH_DATA_SIZE:
+			hwss_hubbub_perfmon_get_prefetch_data_size(params);
+			break;
+		case HUBBUB_PERFMON_GET_URGENT_RAMP_LATENCY:
+			hwss_hubbub_perfmon_get_urgent_ramp_latency(params);
+			break;
 		case HUBP_CLK_CNTL:
 			hwss_hubp_clk_cntl(params);
 			break;
@@ -3251,6 +3293,139 @@ void hwss_hubbub_soft_reset(union block_sequence_params *params)
 		params->hubbub_soft_reset_params.hubbub_soft_reset(hubbub, reset);
 }
 
+void hwss_hubbub_perfmon_reset(union block_sequence_params *params)
+{
+	struct hubbub *hubbub = params->hubbub_perfmon_reset_params.hubbub;
+
+	if (hubbub && hubbub->funcs->perfmon.reset)
+		hubbub->funcs->perfmon.reset(hubbub);
+}
+
+void hwss_hubbub_perfmon_arm_out_of_order_bw(union block_sequence_params *params)
+{
+	struct hubbub *hubbub = params->hubbub_perfmon_arm_out_of_order_bw_params.hubbub;
+
+	if (hubbub && hubbub->funcs->perfmon.arm_measuring_out_of_order_bandwidth)
+		hubbub->funcs->perfmon.arm_measuring_out_of_order_bandwidth(hubbub);
+}
+
+void hwss_hubbub_perfmon_start_out_of_order_bw(union block_sequence_params *params)
+{
+	struct hubbub *hubbub = params->hubbub_perfmon_start_out_of_order_bw_params.hubbub;
+
+	if (hubbub && hubbub->funcs->perfmon.start_measuring_out_of_order_bandwidth)
+		hubbub->funcs->perfmon.start_measuring_out_of_order_bandwidth(hubbub);
+}
+
+void hwss_hubbub_perfmon_start_in_order_bw(union block_sequence_params *params)
+{
+	struct hubbub *hubbub = params->hubbub_perfmon_start_in_order_bw_params.hubbub;
+
+	if (hubbub && hubbub->funcs->perfmon.start_measuring_in_order_bandwidth)
+		hubbub->funcs->perfmon.start_measuring_in_order_bandwidth(hubbub);
+}
+
+void hwss_hubbub_perfmon_start_memory_latencies(union block_sequence_params *params)
+{
+	struct hubbub *hubbub = params->hubbub_perfmon_start_memory_latencies_params.hubbub;
+
+	if (hubbub && hubbub->funcs->perfmon.start_measuring_memory_latencies)
+		hubbub->funcs->perfmon.start_measuring_memory_latencies(hubbub);
+}
+
+void hwss_hubbub_perfmon_start_urgent_assertion_count(union block_sequence_params *params)
+{
+	struct hubbub *hubbub = params->hubbub_perfmon_start_urgent_assertion_count_params.hubbub;
+
+	if (hubbub && hubbub->funcs->perfmon.start_measuring_urgent_assertion_count)
+		hubbub->funcs->perfmon.start_measuring_urgent_assertion_count(hubbub);
+}
+
+void hwss_hubbub_perfmon_start_urgent_ramp_latency(union block_sequence_params *params)
+{
+	struct hubbub *hubbub = params->hubbub_perfmon_start_urgent_ramp_latency_params.hubbub;
+
+	if (hubbub && hubbub->funcs->perfmon.start_measuring_urgent_ramp_latency)
+		hubbub->funcs->perfmon.start_measuring_urgent_ramp_latency(
+				hubbub,
+				&params->hubbub_perfmon_start_urgent_ramp_latency_params.latency_params);
+}
+
+void hwss_hubbub_perfmon_start_prefetch_data_size(union block_sequence_params *params)
+{
+	struct hubbub *hubbub = params->hubbub_perfmon_start_prefetch_data_size_params.hubbub;
+
+	if (hubbub && hubbub->funcs->perfmon.start_measuring_prefetch_data_size)
+		hubbub->funcs->perfmon.start_measuring_prefetch_data_size(hubbub);
+}
+
+void hwss_hubbub_perfmon_get_out_of_order_bw(union block_sequence_params *params)
+{
+	struct hubbub *hubbub = params->hubbub_perfmon_get_out_of_order_bw_params.hubbub;
+	uint32_t refclk_mhz  = params->hubbub_perfmon_get_out_of_order_bw_params.refclk_mhz;
+	uint32_t *mbps       = params->hubbub_perfmon_get_out_of_order_bw_params.bandwidth_mbps;
+	uint32_t *duration   = params->hubbub_perfmon_get_out_of_order_bw_params.duration_ns;
+
+	if (hubbub && hubbub->funcs->perfmon.get_out_of_order_bandwidth_mbps && mbps)
+		*mbps = hubbub->funcs->perfmon.get_out_of_order_bandwidth_mbps(
+				hubbub, refclk_mhz, duration);
+}
+
+void hwss_hubbub_perfmon_get_in_order_bw(union block_sequence_params *params)
+{
+	struct hubbub *hubbub     = params->hubbub_perfmon_get_in_order_bw_params.hubbub;
+	uint32_t refclk_mhz       = params->hubbub_perfmon_get_in_order_bw_params.refclk_mhz;
+	uint32_t min_duration_ns  = params->hubbub_perfmon_get_in_order_bw_params.min_duration_ns;
+	uint32_t *mbps            = params->hubbub_perfmon_get_in_order_bw_params.bandwidth_mbps;
+	uint32_t *duration        = params->hubbub_perfmon_get_in_order_bw_params.duration_ns;
+
+	if (hubbub && hubbub->funcs->perfmon.get_in_order_bandwidth_mbps && mbps)
+		*mbps = hubbub->funcs->perfmon.get_in_order_bandwidth_mbps(
+				hubbub, refclk_mhz, min_duration_ns, duration);
+}
+
+void hwss_hubbub_perfmon_get_memory_latencies(union block_sequence_params *params)
+{
+	struct hubbub *hubbub = params->hubbub_perfmon_get_memory_latencies_params.hubbub;
+	uint32_t refclk_mhz  = params->hubbub_perfmon_get_memory_latencies_params.refclk_mhz;
+	struct hubbub_system_latencies *result = params->hubbub_perfmon_get_memory_latencies_params.result;
+
+	if (hubbub && hubbub->funcs->perfmon.get_memory_latencies_ns && result)
+		hubbub->funcs->perfmon.get_memory_latencies_ns(
+				hubbub, refclk_mhz, &result->min_latency_ns, &result->max_latency_ns, &result->avg_latency_ns);
+}
+
+void hwss_hubbub_perfmon_get_urgent_assertion_count(union block_sequence_params *params)
+{
+	struct hubbub *hubbub   = params->hubbub_perfmon_get_urgent_assertion_count_params.hubbub;
+	uint32_t refclk_mhz    = params->hubbub_perfmon_get_urgent_assertion_count_params.refclk_mhz;
+	uint32_t *count         = params->hubbub_perfmon_get_urgent_assertion_count_params.assertion_count;
+
+	if (hubbub && hubbub->funcs->perfmon.get_urgent_assertion_count)
+		hubbub->funcs->perfmon.get_urgent_assertion_count(
+				hubbub, refclk_mhz, count, NULL, NULL);
+}
+
+void hwss_hubbub_perfmon_get_prefetch_data_size(union block_sequence_params *params)
+{
+	struct hubbub *hubbub     = params->hubbub_perfmon_get_prefetch_data_size_params.hubbub;
+	uint32_t *prefetch_size   = params->hubbub_perfmon_get_prefetch_data_size_params.prefetch_data_size;
+
+	if (hubbub && hubbub->funcs->perfmon.get_prefetch_data_size && prefetch_size)
+		*prefetch_size = hubbub->funcs->perfmon.get_prefetch_data_size(hubbub);
+}
+
+void hwss_hubbub_perfmon_get_urgent_ramp_latency(union block_sequence_params *params)
+{
+	struct hubbub *hubbub = params->hubbub_perfmon_get_urgent_ramp_latency_params.hubbub;
+	uint32_t refclk_mhz  = params->hubbub_perfmon_get_urgent_ramp_latency_params.refclk_mhz;
+	uint32_t *latency_ns = params->hubbub_perfmon_get_urgent_ramp_latency_params.latency_ns;
+
+	if (hubbub && hubbub->funcs->perfmon.get_urgent_ramp_latency_ns && latency_ns)
+		*latency_ns = hubbub->funcs->perfmon.get_urgent_ramp_latency_ns(
+				hubbub, refclk_mhz);
+}
+
 void hwss_hubp_clk_cntl(union block_sequence_params *params)
 {
 	struct hubp *hubp = params->hubp_clk_cntl_params.hubp;
@@ -4422,6 +4597,168 @@ void hwss_add_hubbub_soft_reset(struct block_sequence_state *seq_state,
 	}
 }
 
+void hwss_add_hubbub_perfmon_reset(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBBUB_PERFMON_RESET;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_reset_params.hubbub = hubbub;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hubbub_perfmon_arm_out_of_order_bw(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBBUB_PERFMON_ARM_OUT_OF_ORDER_BW;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_arm_out_of_order_bw_params.hubbub = hubbub;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hubbub_perfmon_start_out_of_order_bw(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBBUB_PERFMON_START_OUT_OF_ORDER_BW;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_start_out_of_order_bw_params.hubbub = hubbub;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hubbub_perfmon_start_in_order_bw(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBBUB_PERFMON_START_IN_ORDER_BW;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_start_in_order_bw_params.hubbub = hubbub;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hubbub_perfmon_start_memory_latencies(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBBUB_PERFMON_START_MEMORY_LATENCIES;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_start_memory_latencies_params.hubbub = hubbub;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hubbub_perfmon_start_urgent_assertion_count(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBBUB_PERFMON_START_URGENT_ASSERTION_COUNT;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_start_urgent_assertion_count_params.hubbub = hubbub;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hubbub_perfmon_start_urgent_ramp_latency(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub,
+		const struct hubbub_urgent_latency_params *latency_params)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBBUB_PERFMON_START_URGENT_RAMP_LATENCY;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_start_urgent_ramp_latency_params.hubbub = hubbub;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_start_urgent_ramp_latency_params.latency_params =
+				*latency_params;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hubbub_perfmon_start_prefetch_data_size(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBBUB_PERFMON_START_PREFETCH_DATA_SIZE;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_start_prefetch_data_size_params.hubbub = hubbub;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hubbub_perfmon_get_out_of_order_bw(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub, uint32_t refclk_mhz,
+		uint32_t *bandwidth_mbps, uint32_t *duration_ns)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBBUB_PERFMON_GET_OUT_OF_ORDER_BW;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_out_of_order_bw_params.hubbub = hubbub;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_out_of_order_bw_params.refclk_mhz = refclk_mhz;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_out_of_order_bw_params.bandwidth_mbps = bandwidth_mbps;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_out_of_order_bw_params.duration_ns = duration_ns;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hubbub_perfmon_get_in_order_bw(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub, uint32_t refclk_mhz, uint32_t min_duration_ns,
+		uint32_t *bandwidth_mbps, uint32_t *duration_ns)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBBUB_PERFMON_GET_IN_ORDER_BW;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_in_order_bw_params.hubbub = hubbub;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_in_order_bw_params.refclk_mhz = refclk_mhz;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_in_order_bw_params.min_duration_ns = min_duration_ns;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_in_order_bw_params.bandwidth_mbps = bandwidth_mbps;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_in_order_bw_params.duration_ns = duration_ns;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hubbub_perfmon_get_memory_latencies(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub, uint32_t refclk_mhz,
+		struct hubbub_system_latencies *result)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBBUB_PERFMON_GET_MEMORY_LATENCIES;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_memory_latencies_params.hubbub = hubbub;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_memory_latencies_params.refclk_mhz = refclk_mhz;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_memory_latencies_params.result = result;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hubbub_perfmon_get_urgent_assertion_count(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub, uint32_t refclk_mhz,
+		uint32_t *assertion_count)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBBUB_PERFMON_GET_URGENT_ASSERTION_COUNT;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_urgent_assertion_count_params.hubbub = hubbub;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_urgent_assertion_count_params.refclk_mhz = refclk_mhz;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_urgent_assertion_count_params.assertion_count = assertion_count;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hubbub_perfmon_get_prefetch_data_size(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub, uint32_t *prefetch_data_size)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBBUB_PERFMON_GET_PREFETCH_DATA_SIZE;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_prefetch_data_size_params.hubbub = hubbub;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_prefetch_data_size_params.prefetch_data_size = prefetch_data_size;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_hubbub_perfmon_get_urgent_ramp_latency(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub, uint32_t refclk_mhz,
+		uint32_t *latency_ns)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HUBBUB_PERFMON_GET_URGENT_RAMP_LATENCY;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_urgent_ramp_latency_params.hubbub = hubbub;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_urgent_ramp_latency_params.refclk_mhz = refclk_mhz;
+		seq_state->steps[*seq_state->num_steps].params.hubbub_perfmon_get_urgent_ramp_latency_params.latency_ns = latency_ns;
+		(*seq_state->num_steps)++;
+	}
+}
+
 void hwss_add_hubp_clk_cntl(struct block_sequence_state *seq_state,
 		struct hubp *hubp,
 		bool enable)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_state.c b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
index 03cb40e94d58..a62a435054c6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_state.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_state.c
@@ -362,6 +362,7 @@ void dc_state_destruct(struct dc_state *state)
 	state->phantom_plane_count = 0;
 
 	memset(state->probes, 0, sizeof(state->probes));
+	memset(state->probe_status, 0, sizeof(state->probe_status));
 	state->probe_count = 0;
 
 	state->stream_mask = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index e8bf96a7d63a..6754da1e6ee2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -32,6 +32,7 @@
 #include "inc/hw/link_encoder.h"
 #include "inc/core_status.h"
 #include "inc/hw/hw_shared.h"
+#include "inc/hw/dchubbub.h"
 #include "dsc/dsc.h"
 #include "link_service_types.h"
 
@@ -53,7 +54,6 @@ struct drr_params;
 struct dc_underflow_debug_data;
 struct dsc_optc_config;
 struct vm_system_aperture_param;
-struct dc_measured_memory_qos;
 struct stream_encoder;
 struct hpo_dp_stream_encoder;
 struct hpo_frl_stream_encoder;
@@ -580,6 +580,77 @@ struct hubbub_soft_reset_params {
 	bool reset;
 };
 
+struct hubbub_perfmon_reset_params {
+	struct hubbub *hubbub;
+};
+
+struct hubbub_perfmon_arm_out_of_order_bw_params {
+	struct hubbub *hubbub;
+};
+
+struct hubbub_perfmon_start_out_of_order_bw_params {
+	struct hubbub *hubbub;
+};
+
+struct hubbub_perfmon_start_in_order_bw_params {
+	struct hubbub *hubbub;
+};
+
+struct hubbub_perfmon_start_memory_latencies_params {
+	struct hubbub *hubbub;
+};
+
+struct hubbub_perfmon_start_urgent_assertion_count_params {
+	struct hubbub *hubbub;
+};
+
+struct hubbub_perfmon_start_urgent_ramp_latency_params {
+	struct hubbub *hubbub;
+	struct hubbub_urgent_latency_params latency_params;
+};
+
+struct hubbub_perfmon_start_prefetch_data_size_params {
+	struct hubbub *hubbub;
+};
+
+struct hubbub_perfmon_get_out_of_order_bw_params {
+	struct hubbub *hubbub;
+	uint32_t       refclk_mhz;
+	uint32_t      *bandwidth_mbps;
+	uint32_t      *duration_ns;
+};
+
+struct hubbub_perfmon_get_in_order_bw_params {
+	struct hubbub *hubbub;
+	uint32_t       refclk_mhz;
+	uint32_t       min_duration_ns;
+	uint32_t      *bandwidth_mbps;
+	uint32_t      *duration_ns;
+};
+
+struct hubbub_perfmon_get_memory_latencies_params {
+	struct hubbub                        *hubbub;
+	uint32_t                              refclk_mhz;
+	struct hubbub_system_latencies       *result;
+};
+
+struct hubbub_perfmon_get_urgent_assertion_count_params {
+	struct hubbub *hubbub;
+	uint32_t       refclk_mhz;
+	uint32_t      *assertion_count;
+};
+
+struct hubbub_perfmon_get_prefetch_data_size_params {
+	struct hubbub *hubbub;
+	uint32_t      *prefetch_data_size;
+};
+
+struct hubbub_perfmon_get_urgent_ramp_latency_params {
+	struct hubbub *hubbub;
+	uint32_t       refclk_mhz;
+	uint32_t      *latency_ns;
+};
+
 struct hubp_clk_cntl_params {
 	struct hubp *hubp;
 	bool enable;
@@ -1031,6 +1102,20 @@ union block_sequence_params {
 	struct hubp_set_blank_en_params hubp_set_blank_en_params;
 	struct hubp_disable_control_params hubp_disable_control_params;
 	struct hubbub_soft_reset_params hubbub_soft_reset_params;
+	struct hubbub_perfmon_reset_params hubbub_perfmon_reset_params;
+	struct hubbub_perfmon_arm_out_of_order_bw_params hubbub_perfmon_arm_out_of_order_bw_params;
+	struct hubbub_perfmon_start_out_of_order_bw_params hubbub_perfmon_start_out_of_order_bw_params;
+	struct hubbub_perfmon_start_in_order_bw_params hubbub_perfmon_start_in_order_bw_params;
+	struct hubbub_perfmon_start_memory_latencies_params hubbub_perfmon_start_memory_latencies_params;
+	struct hubbub_perfmon_start_urgent_assertion_count_params hubbub_perfmon_start_urgent_assertion_count_params;
+	struct hubbub_perfmon_start_urgent_ramp_latency_params hubbub_perfmon_start_urgent_ramp_latency_params;
+	struct hubbub_perfmon_start_prefetch_data_size_params hubbub_perfmon_start_prefetch_data_size_params;
+	struct hubbub_perfmon_get_out_of_order_bw_params hubbub_perfmon_get_out_of_order_bw_params;
+	struct hubbub_perfmon_get_in_order_bw_params hubbub_perfmon_get_in_order_bw_params;
+	struct hubbub_perfmon_get_memory_latencies_params hubbub_perfmon_get_memory_latencies_params;
+	struct hubbub_perfmon_get_urgent_assertion_count_params hubbub_perfmon_get_urgent_assertion_count_params;
+	struct hubbub_perfmon_get_prefetch_data_size_params hubbub_perfmon_get_prefetch_data_size_params;
+	struct hubbub_perfmon_get_urgent_ramp_latency_params hubbub_perfmon_get_urgent_ramp_latency_params;
 	struct hubp_clk_cntl_params hubp_clk_cntl_params;
 	struct hubp_init_params hubp_init_params;
 	struct hubp_set_vm_system_aperture_settings_params hubp_set_vm_system_aperture_settings_params;
@@ -1258,6 +1343,20 @@ enum block_sequence_func {
 	HUBBUB_PROGRAM_WATERMARKS,
 	HUBBUB_PROGRAM_ARBITER,
 	HUBBUB_PROGRAM_COMPBUF_SEGMENTS,
+	HUBBUB_PERFMON_RESET,
+	HUBBUB_PERFMON_ARM_OUT_OF_ORDER_BW,
+	HUBBUB_PERFMON_START_OUT_OF_ORDER_BW,
+	HUBBUB_PERFMON_START_IN_ORDER_BW,
+	HUBBUB_PERFMON_START_MEMORY_LATENCIES,
+	HUBBUB_PERFMON_START_URGENT_ASSERTION_COUNT,
+	HUBBUB_PERFMON_START_URGENT_RAMP_LATENCY,
+	HUBBUB_PERFMON_START_PREFETCH_DATA_SIZE,
+	HUBBUB_PERFMON_GET_OUT_OF_ORDER_BW,
+	HUBBUB_PERFMON_GET_IN_ORDER_BW,
+	HUBBUB_PERFMON_GET_MEMORY_LATENCIES,
+	HUBBUB_PERFMON_GET_URGENT_ASSERTION_COUNT,
+	HUBBUB_PERFMON_GET_PREFETCH_DATA_SIZE,
+	HUBBUB_PERFMON_GET_URGENT_RAMP_LATENCY,
 	/* This must be the last value in this enum, add new ones above */
 	HWSS_BLOCK_SEQUENCE_FUNC_COUNT
 };
@@ -1591,14 +1690,16 @@ struct hw_sequencer_funcs {
 			struct dc_underflow_debug_data *out_data);
 
 	/**
-	 * measure_memory_qos - Measure memory QoS metrics
-	 * @dc: DC structure
-	 * @qos: Pointer to dc_measured_memory_qos struct to populate with measured values
+	 * program_perfmon - Program/transition perfmon probes for a commit.
+	 * @dc:      DC structure
+	 * @context: target state; probes, probe_count, and probe_status are
+	 *           read from and written to this object
 	 *
-	 * Populates the provided dc_measured_memory_qos struct with peak bandwidth, average bandwidth,
-	 * max latency, min latency, and average latency from hardware performance counters.
+	 * Invoked during the execute phase of dc_update_state. The hook resolves
+	 * each probe's transition by diffing @context against dc->current_state
+	 * and latches MEASURED results into @context->probe_status.
 	 */
-	void (*measure_memory_qos)(struct dc *dc, struct dc_measured_memory_qos *qos);
+	void (*program_perfmon)(struct dc *dc, struct dc_state *context);
 
 };
 
@@ -1875,6 +1976,34 @@ void hwss_hubp_disable_control(union block_sequence_params *params);
 
 void hwss_hubbub_soft_reset(union block_sequence_params *params);
 
+void hwss_hubbub_perfmon_reset(union block_sequence_params *params);
+
+void hwss_hubbub_perfmon_arm_out_of_order_bw(union block_sequence_params *params);
+
+void hwss_hubbub_perfmon_start_out_of_order_bw(union block_sequence_params *params);
+
+void hwss_hubbub_perfmon_start_in_order_bw(union block_sequence_params *params);
+
+void hwss_hubbub_perfmon_start_memory_latencies(union block_sequence_params *params);
+
+void hwss_hubbub_perfmon_start_urgent_assertion_count(union block_sequence_params *params);
+
+void hwss_hubbub_perfmon_start_urgent_ramp_latency(union block_sequence_params *params);
+
+void hwss_hubbub_perfmon_start_prefetch_data_size(union block_sequence_params *params);
+
+void hwss_hubbub_perfmon_get_out_of_order_bw(union block_sequence_params *params);
+
+void hwss_hubbub_perfmon_get_in_order_bw(union block_sequence_params *params);
+
+void hwss_hubbub_perfmon_get_memory_latencies(union block_sequence_params *params);
+
+void hwss_hubbub_perfmon_get_urgent_assertion_count(union block_sequence_params *params);
+
+void hwss_hubbub_perfmon_get_prefetch_data_size(union block_sequence_params *params);
+
+void hwss_hubbub_perfmon_get_urgent_ramp_latency(union block_sequence_params *params);
+
 void hwss_hubp_clk_cntl(union block_sequence_params *params);
 
 void hwss_hubp_init(union block_sequence_params *params);
@@ -2213,6 +2342,54 @@ void hwss_add_hubbub_soft_reset(struct block_sequence_state *seq_state,
 		void (*hubbub_soft_reset)(struct hubbub *hubbub, bool reset),
 		bool reset);
 
+void hwss_add_hubbub_perfmon_reset(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub);
+
+void hwss_add_hubbub_perfmon_arm_out_of_order_bw(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub);
+
+void hwss_add_hubbub_perfmon_start_out_of_order_bw(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub);
+
+void hwss_add_hubbub_perfmon_start_in_order_bw(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub);
+
+void hwss_add_hubbub_perfmon_start_memory_latencies(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub);
+
+void hwss_add_hubbub_perfmon_start_urgent_assertion_count(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub);
+
+void hwss_add_hubbub_perfmon_start_urgent_ramp_latency(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub,
+		const struct hubbub_urgent_latency_params *latency_params);
+
+void hwss_add_hubbub_perfmon_start_prefetch_data_size(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub);
+
+void hwss_add_hubbub_perfmon_get_out_of_order_bw(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub, uint32_t refclk_mhz,
+		uint32_t *bandwidth_mbps, uint32_t *duration_ns);
+
+void hwss_add_hubbub_perfmon_get_in_order_bw(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub, uint32_t refclk_mhz, uint32_t min_duration_ns,
+		uint32_t *bandwidth_mbps, uint32_t *duration_ns);
+
+void hwss_add_hubbub_perfmon_get_memory_latencies(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub, uint32_t refclk_mhz,
+		struct hubbub_system_latencies *result);
+
+void hwss_add_hubbub_perfmon_get_urgent_assertion_count(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub, uint32_t refclk_mhz,
+		uint32_t *assertion_count);
+
+void hwss_add_hubbub_perfmon_get_prefetch_data_size(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub, uint32_t *prefetch_data_size);
+
+void hwss_add_hubbub_perfmon_get_urgent_ramp_latency(struct block_sequence_state *seq_state,
+		struct hubbub *hubbub, uint32_t refclk_mhz,
+		uint32_t *latency_ns);
+
 void hwss_add_hubp_clk_cntl(struct block_sequence_state *seq_state,
 		struct hubp *hubp,
 		bool enable);
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index c42626101cd7..ac3e9eaa569c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -33,6 +33,7 @@
 #include "dc_bios_types.h"
 #include "mem_input.h"
 #include "hubp.h"
+#include "hw/dchubbub.h"
 #include "mpc.h"
 #include "dwb.h"
 #include "hw/dio.h"
@@ -609,6 +610,27 @@ struct dc_dmub_cmd {
 	enum dm_dmub_wait_type wait_type;
 };
 
+/**
+ * struct dc_probe_status - DC-internal latched perfmon results for a probe.
+ * @valid: true if a measurement was latched this commit.
+ * @type: type of the probe that produced this result.
+ * @u.bandwidth_mbps:         peak BW in Mbps (DC_PROBE_PEAK_MEM_BW).
+ * @u.latency:                min/max/avg memory latency in ns (DC_PROBE_MEM_LATENCY),
+ *                            stored as struct hubbub_system_latencies.
+ * @u.urgent_assertion_count: number of urgent assertion events (DC_PROBE_URGENT_ASSERTION_COUNT).
+ * @u.prefetch_data_size:     total prefetch data in bytes (DC_PROBE_PREFETCH_DATA_SIZE).
+ */
+struct dc_probe_status {
+	bool                       valid;
+	enum dc_probe_type         type;
+	union {
+		uint32_t bandwidth_mbps;
+		struct hubbub_system_latencies latency;
+		uint32_t urgent_assertion_count;
+		uint32_t prefetch_data_size;
+	} u;
+};
+
 /**
  * struct dc_state - The full description of a state requested by users
  */
@@ -652,6 +674,11 @@ struct dc_state {
 	 */
 	struct dc_probe_state probes[MAX_PROBES];
 
+	/**
+	 * @probe_status: Committed absolute set of probe results.
+	 */
+	struct dc_probe_status probe_status[MAX_PROBES];
+
 	/**
 	 * @probe_count: Number of valid entries in @probes.
 	 */
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
index 4307362749f0..fd742b320128 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dchubbub.h
@@ -158,6 +158,12 @@ struct hubbub_urgent_latency_params {
 	uint32_t bw_factor_x1000;
 };
 
+struct hubbub;
+struct dchub_init_data;
+struct dc_dcc_surface_param;
+struct dc_surface_dcc_cap;
+union dcn_watermark_set;
+struct dml2_display_arb_regs;
 struct hubbub_funcs {
 	void (*update_dchub)(
 			struct hubbub *hubbub,
@@ -274,9 +280,11 @@ struct hubbub_funcs {
 				const struct hubbub_urgent_latency_params *params);
 		uint32_t (*get_urgent_ramp_latency_ns)(struct hubbub *hubbub,
 				uint32_t refclk_mhz);
-		void (*start_measuring_unbounded_bandwidth)(
+		void (*arm_measuring_out_of_order_bandwidth)(
 				struct hubbub *hubbub);
-		uint32_t (*get_unbounded_bandwidth_mbps)(struct hubbub *hubbub,
+		void (*start_measuring_out_of_order_bandwidth)(
+				struct hubbub *hubbub);
+		uint32_t (*get_out_of_order_bandwidth_mbps)(struct hubbub *hubbub,
 				uint32_t refclk_mhz, uint32_t *duration_ns);
 		void (*start_measuring_in_order_bandwidth)(
 				struct hubbub *hubbub);
-- 
2.43.0


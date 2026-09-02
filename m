Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 123E1C61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8CBD610EFD6;
	Wed,  2 Sep 2026 05:09:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sjj+tkbQ";
	dkim-atps=neutral
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013040.outbound.protection.outlook.com
 [40.93.201.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DBA710EFD6
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:09:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YDE740vFyoKlK3XspfOKXNNAsE56siQdgzDbaHnFriF8RgCWb08pfD8mAzZ+TVbvBDRnsNrcfwgNQeKeofEi9Finz3hibhskLCA3kJl2VC1dtBV0l8CCs53/FE4buwJQU9gZzK/t6uaCnrXYbIXgFRM0PVNosMzb4v/zIV+nw/kI+5VUGSQiSGrMh3grQSb2j/pmXSYkS9mqMIlxtZIhhHEAPg6cS0YucVsHcqI331OCvpW+SocquU0xHkL6/YEQUAmjC7awNJmEJwL7uPpF8K6ig2GCSZjCYsIOBHAbVwDYKDzlaFVF5kTeEHaBmtVukUo8Ipb+jQ8CtZJVAEBdyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lvmyG/bK6MpR2lTnNAELiLIm7atEG5FPltLeFZt9Rlg=;
 b=juEZFgdT7J1AQPZUOd4t9UodzgH9L5fp3fKYUUablUltzsApA09K+zM6p1gynpFb+8o5k1BdqPRHN3ADvYUwIDTlOxRVIVUDL6+hDKP0RZya2WBBnoMBtxM4vElITVLFfwPeoxmV7gOlBstQfHmo7pNYGcSjU5pxFIq+VrCrXH+q21j++nyHWjz45KRtH6t4qpBBHWI+GsqREN0iN6zAE0s2M5tOtPT11LiheJHA6nZxmDUa9O+TM5lHwcty8nSGvu26Y5P5SOHvqZ8KyxMYzoB+oy8rEepE0JmjijJ5AdvypM61FTWCXOi0J6+waQY0E9Q1CcwXNLStRpMBWqQq7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lvmyG/bK6MpR2lTnNAELiLIm7atEG5FPltLeFZt9Rlg=;
 b=sjj+tkbQD6ZrlVbVfaLdrfRZhQ1SOj3U8x+dYPATrZK107Lurs4lUWm4FmVQClGXDNom/lLy6FCid8YkO6I6yijolp3HO9UK8u6ZgMCgwBjmuUBSvss+qMRHdnb/efvVEXOSQNIp9xQyQgUDEoTvbUFNk69ISYpBzZoD1qriYgw=
Received: from BN9PR03CA0056.namprd03.prod.outlook.com (2603:10b6:408:fb::31)
 by MW3PR12MB4361.namprd12.prod.outlook.com (2603:10b6:303:5a::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:09:02 +0000
Received: from LV8PEPF00000068.namprd03.prod.outlook.com
 (2603:10b6:408:fb:cafe::19) by BN9PR03CA0056.outlook.office365.com
 (2603:10b6:408:fb::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.360.13 via Frontend Transport; Wed, 2
 Sep 2026 05:09:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF00000068.mail.protection.outlook.com (10.167.248.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:09:01 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:09:01 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:08:52 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Wenjing Liu <wenjing.liu@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 31/40] drm/amd/display: Add stressed peak bandwidth probe with
 DMA contention
Date: Wed, 2 Sep 2026 12:58:53 +0800
Message-ID: <20260902050411.3473916-32-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF00000068:EE_|MW3PR12MB4361:EE_
X-MS-Office365-Filtering-Correlation-Id: 8884c4ad-62c5-47c1-838f-08df08b04d81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|6133799003|3023799007|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FG6KjI1DDtiRmPNVWfVLaiNH9xVfYdZJBOrQmhrqLTijpmsitMAeru243rFvMa0/UifG6cMoOKfJuXGKMbPxZZyaLtTwCwgjFwqhhNhj27Dqm5B9sd6/WvaHDY6/4FUKfEwWhXLleytKEQfHo/p6c7DRa4q74Xi9aBn3BUroHBkvwGkJ5dQYsI/ARpQqBjoPeLmLyofcdPE80EK32gCSessjvPEV34QMLHEwu8GMLLKQA+MiBHgixP7fMvDpcrQ0rNEAzKxmNzwWewl7ilzR+ZXy+pU6qTI1csnDLQLWSTHKo6Nr9A9r9OjJj7sVnkJXDN+jINUX0yIvt3sFJqVwNUtqGgAVrhCaPRBUf6EiObjUTrmT6UgNvTUKhmbSJV9eWjT3RG/IeCE6X2nw6RY1inA5klY/W1k0QHMywV/M4DyMIvSg19qRVZHnK4NGn+v+z2XsPxodpWFr0iBxFDcSaAOYKysQGEMpi0wOQYsoKbZabmFes4ysc2oxJDP21ZG91hLNt7L9+FQSaAJZtLw9/cg1jTQjf3oZWOdLL9kzmo0GUnWIuU9P4eOm4HqpRNQVDYk346B2Rg5h71mvYpu1ySyxRBbZ5M/B+4S0JkS+MNTM/5hZctLL9gibEDUV7vgRkm4VPKQuwus0HwODyfMFTctts3S9FXkLVtDLZ3hxJkwYm5jT/CjKNMZSEXXkC2t49Nea1VZ+oFPK5HBBM0oqTQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(6133799003)(3023799007)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: aV5d39seV5A6bq/i+6mWqg6EsLMhzHqu1eDOtTGhsYuuzqQDzEObtQ0N+/z5ZNBPaY4Q5VgMHVo9XyzpkNjxZWHy4moPpgnmWlG0AqwoWdTD9ZnYHQS2MQ8SW/VFEMzBTGEMPSP8t264tKU3QLMUbJqd36z6azI4dpjCdIyF1Ze4R34XM33OSa0qmdx7H0Zg6RDKWj9CpmHPMIDLaU5EMN4cR0PIHY/uTC+9W2tvIIjLR9WWyjqTI11SbrL6M5lmLxr51BElb7+t0jeA7iuvJNsV/lyxL3vq1XbCgDKPqXRjNyBRz2CVsEqNwUBQd0Y4eVuWLCrIWIUZnDuP1wqJab8qcmeVnaS4n1/zs0HNSkGTr7JRNtPS89xHcHHPKjnn6N8H3PXZQ53ulpG7wShBBxll9jKBAbfZJ8ysUpwwQ7GEDbY6CYLcXGVV1RRdGy0e
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:09:01.7071 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8884c4ad-62c5-47c1-838f-08df08b04d81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: LV8PEPF00000068.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4361
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
Peak-bandwidth-under-contention validation currently needs an
external tool to manufacture memory contention while querying
peak bandwidth. Expose this as an explicit probe variant so the
driver can generate that contention itself.

[How]
Add a new probe type that builds the same gated perfmon sequence
as the plain peak-BW probe, with a DMA copy of the current
surface into a scratch buffer inserted before the measurement
window to synthesize a competing memory client. Move the scratch
buffer fields onto the base resource pool struct instead of an
ASIC-specific subclass, and reject the probe with a new status
code when the buffer was never allocated. Also fixes a stack-
corruption bug where a local variable's address was captured by
a deferred callback and used after the local went out of scope,
and a missing NULL check on a similar output parameter used by
an early-return path.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_debug.c    |  2 ++
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 29 +++++++++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  4 +++
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 drivers/gpu/drm/amd/display/dc/dc_probe.h     |  1 +
 .../display/dc/hubbub/dcn60/dcn60_hubbub.c    |  3 +-
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   | 26 +++++++++++++++--
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 14 +++++++++
 .../gpu/drm/amd/display/dc/inc/core_status.h  |  2 ++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  9 ++++++
 .../dc/resource/dcn60/dcn60_resource.c        | 19 ++++++++++++
 11 files changed, 106 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
index 2933b660e3d7..f3348e0cb1d6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_debug.c
@@ -274,6 +274,8 @@ char *dc_status_to_str(enum dc_status status)
 		return "HW Cursor not supported";
 	case DC_FAIL_DP_TUNNEL_BW_VALIDATE:
 		return "Fail DP Tunnel BW validation";
+	case DC_NO_DRAM_BUFFER_RESOURCE:
+		return "No DRAM buffer resource";
 	case DC_ERROR_UNEXPECTED:
 		return "Unexpected error";
 	default:
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index de1772f75293..b54466e4f42b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1797,6 +1797,9 @@ void hwss_execute_sequence(struct dc *dc,
 		case DMUB_SEND_DMCUB_CMD:
 			hwss_send_dmcub_cmd(params);
 			break;
+		case LSDMA_SEND_PIO_COPY:
+			hwss_lsdma_send_pio_copy(params);
+			break;
 		case DMUB_SUBVP_SAVE_SURF_ADDR:
 			hwss_subvp_save_surf_addr(params);
 			break;
@@ -2670,6 +2673,17 @@ void hwss_send_dmcub_cmd(union block_sequence_params *params)
 	dc_wake_and_execute_dmub_cmd(ctx, cmd, wait_type);
 }
 
+void hwss_lsdma_send_pio_copy(union block_sequence_params *params)
+{
+	struct dc_dmub_srv *dc_dmub_srv = params->lsdma_send_pio_copy_params.dc_dmub_srv;
+	uint64_t src_addr = params->lsdma_send_pio_copy_params.src_addr;
+	uint64_t dst_addr = params->lsdma_send_pio_copy_params.dst_addr;
+	uint32_t byte_count = params->lsdma_send_pio_copy_params.byte_count;
+	uint32_t overlap_disable = params->lsdma_send_pio_copy_params.overlap_disable;
+
+	dmub_lsdma_send_pio_copy_command(dc_dmub_srv, src_addr, dst_addr, byte_count, overlap_disable);
+}
+
 /*
  * Helper function to add TG program global sync to block sequence
  */
@@ -5214,6 +5228,21 @@ void hwss_add_hubbub_perfmon_arm_out_of_order_bw(struct block_sequence_state *se
 	}
 }
 
+void hwss_add_lsdma_send_pio_copy(struct block_sequence_state *seq_state,
+		struct dc_dmub_srv *dc_dmub_srv, uint64_t src_addr, uint64_t dst_addr,
+		uint32_t byte_count, uint32_t overlap_disable)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = LSDMA_SEND_PIO_COPY;
+		seq_state->steps[*seq_state->num_steps].params.lsdma_send_pio_copy_params.dc_dmub_srv = dc_dmub_srv;
+		seq_state->steps[*seq_state->num_steps].params.lsdma_send_pio_copy_params.src_addr = src_addr;
+		seq_state->steps[*seq_state->num_steps].params.lsdma_send_pio_copy_params.dst_addr = dst_addr;
+		seq_state->steps[*seq_state->num_steps].params.lsdma_send_pio_copy_params.byte_count = byte_count;
+		seq_state->steps[*seq_state->num_steps].params.lsdma_send_pio_copy_params.overlap_disable = overlap_disable;
+		(*seq_state->num_steps)++;
+	}
+}
+
 void hwss_add_hubbub_perfmon_start_out_of_order_bw(struct block_sequence_state *seq_state,
 		struct hubbub *hubbub)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index ac558e715b72..8e7a42fd3cd3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4470,6 +4470,10 @@ enum dc_status resource_validate_probe_set(struct dc *dc,
 
 		if (probes[i].scope.type != DC_PROBE_SCOPE_GLOBAL)
 			return DC_NOT_SUPPORTED;
+
+		if (probes[i].type == DC_PROBE_PEAK_MEM_BW_STRESSED &&
+				!dc->res_pool->lsdma_scratch.buffer)
+			return DC_NO_DRAM_BUFFER_RESOURCE;
 	}
 
 	return DC_OK;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 4b85727aaff9..f7511580e36f 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -584,6 +584,7 @@ struct dc_config {
 	bool forced_clocks;
 	union allow_lttpr_non_transparent_mode allow_lttpr_non_transparent_mode;
 	bool multi_mon_pp_mclk_switch;
+	bool lsdma_peak_bw_contention_support;
 	bool disable_dmcu;
 	bool allow_4to1MPC;
 	bool enable_windowed_mpo_odm;
diff --git a/drivers/gpu/drm/amd/display/dc/dc_probe.h b/drivers/gpu/drm/amd/display/dc/dc_probe.h
index ebf33b162b63..52bffbebf7ad 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_probe.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_probe.h
@@ -20,6 +20,7 @@ enum dc_probe_type {
 	DC_PROBE_URGENT_RAMP_LATENCY,
 	DC_PROBE_URGENT_ASSERTION_COUNT,
 	DC_PROBE_PREFETCH_DATA_SIZE,
+	DC_PROBE_PEAK_MEM_BW_STRESSED, /* peak BW under synthetic memory contention */
 };
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
index f1e6b2a1000d..0169ffcd9343 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn60/dcn60_hubbub.c
@@ -1713,7 +1713,8 @@ static uint32_t hubbub60_perfmon_get_in_order_bandwidth_mbps(
 		return 0;
 
 	measuring_duration_ns = count4 * 1000 / refclk_mhz;
-	*duration_ns = measuring_duration_ns;
+	if (duration_ns)
+		*duration_ns = measuring_duration_ns;
 	if (min_duration_ns > measuring_duration_ns)
 		return 0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
index 8ee9791b2c46..0e6526e92544 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
@@ -893,7 +893,6 @@ static void dcn60_build_hubbub_perfmon_sequence(
 	uint32_t refclk_mhz = dc->res_pool->ref_clocks.dchub_ref_clock_inKhz / 1000;
 	struct timing_generator *ref_tg = dcn60_get_ref_tg_for_hubbub_probe(context);
 	struct block_sequence_state seq_state = { .steps = block_sequence, .num_steps = num_steps };
-	uint32_t duration_ns = 0;
 
 	if (!hubbub || !hubbub->funcs || !hubbub->funcs->perfmon.reset)
 		return;
@@ -910,6 +909,7 @@ static void dcn60_build_hubbub_perfmon_sequence(
 
 	switch (probe->type) {
 	case DC_PROBE_PEAK_MEM_BW:
+	case DC_PROBE_PEAK_MEM_BW_STRESSED:
 		/* Start at the vblank edge and stop at the next vactive so the counter
 		 * spans exactly one prefetch window, capturing prefetch traffic only. */
 		if (!hubbub->funcs->perfmon.arm_measuring_out_of_order_bandwidth ||
@@ -919,12 +919,30 @@ static void dcn60_build_hubbub_perfmon_sequence(
 
 		hwss_add_hubbub_perfmon_reset(&seq_state, hubbub);
 		hwss_add_hubbub_perfmon_arm_out_of_order_bw(&seq_state, hubbub);
+
+		if (probe->type == DC_PROBE_PEAK_MEM_BW_STRESSED) {
+			struct dc_plane_state *plane = (context->stream_status[0].plane_count > 0) ?
+					context->stream_status[0].plane_states[0] : NULL;
+
+			if (dc->res_pool->lsdma_scratch.buffer && plane) {
+				unsigned int surface_bytes = plane->plane_size.surface_pitch *
+						plane->plane_size.surface_size.height;
+				unsigned int copy_bytes = (surface_bytes < dc->res_pool->lsdma_scratch.size) ?
+						surface_bytes : dc->res_pool->lsdma_scratch.size;
+
+				hwss_add_lsdma_send_pio_copy(&seq_state, dc->ctx->dmub_srv,
+						(uint64_t)plane->address.grph.addr.quad_part,
+						(uint64_t)dc->res_pool->lsdma_scratch.pa,
+						copy_bytes, /* overlap_disable */ 1);
+			}
+		}
+
 		hwss_add_tg_wait_for_state(&seq_state, ref_tg, CRTC_STATE_VACTIVE);
 		hwss_add_tg_wait_for_state(&seq_state, ref_tg, CRTC_STATE_VBLANK);
 		hwss_add_hubbub_perfmon_start_out_of_order_bw(&seq_state, hubbub);
 		hwss_add_tg_wait_for_state(&seq_state, ref_tg, CRTC_STATE_VACTIVE);
 		hwss_add_hubbub_perfmon_get_out_of_order_bw(&seq_state, hubbub,
-				refclk_mhz, &status->u.bandwidth_mbps, &duration_ns);
+				refclk_mhz, &status->u.bandwidth_mbps, NULL);
 		break;
 
 	case DC_PROBE_AVG_MEM_BW:
@@ -941,7 +959,7 @@ static void dcn60_build_hubbub_perfmon_sequence(
 		hwss_add_tg_wait_for_state(&seq_state, ref_tg, CRTC_STATE_VACTIVE);
 		hwss_add_tg_wait_for_state(&seq_state, ref_tg, CRTC_STATE_VBLANK);
 		hwss_add_hubbub_perfmon_get_in_order_bw(&seq_state, hubbub,
-				refclk_mhz, 0, &status->u.bandwidth_mbps, &duration_ns);
+				refclk_mhz, 0, &status->u.bandwidth_mbps, NULL);
 		break;
 
 	case DC_PROBE_MEM_LATENCY:
@@ -1006,6 +1024,7 @@ static void dcn60_update_probe_status(struct dc_probe_status *status)
 {
 	switch (status->type) {
 	case DC_PROBE_PEAK_MEM_BW:
+	case DC_PROBE_PEAK_MEM_BW_STRESSED:
 	case DC_PROBE_AVG_MEM_BW:
 		/* Zero bandwidth means the counter did not fire — treat as invalid. */
 		status->valid = (status->u.bandwidth_mbps != 0);
@@ -1029,6 +1048,7 @@ static bool is_probe_measurement_type_for_hubbub(enum dc_probe_type type)
 {
 	switch (type) {
 	case DC_PROBE_PEAK_MEM_BW:
+	case DC_PROBE_PEAK_MEM_BW_STRESSED:
 	case DC_PROBE_AVG_MEM_BW:
 	case DC_PROBE_MEM_LATENCY:
 	case DC_PROBE_URGENT_ASSERTION_COUNT:
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 3f9eda74fb1b..f75e34a09dca 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -142,6 +142,14 @@ struct send_dmcub_cmd_params {
 	enum dm_dmub_wait_type wait_type;
 };
 
+struct lsdma_send_pio_copy_params {
+	struct dc_dmub_srv *dc_dmub_srv;
+	uint64_t src_addr;
+	uint64_t dst_addr;
+	uint32_t byte_count;
+	uint32_t overlap_disable;
+};
+
 struct setup_dpp_params {
 	struct pipe_ctx *pipe_ctx;
 };
@@ -1058,6 +1066,7 @@ union block_sequence_params {
 	struct update_info_frame_params update_info_frame_params;
 	struct program_manual_trigger_params program_manual_trigger_params;
 	struct send_dmcub_cmd_params send_dmcub_cmd_params;
+	struct lsdma_send_pio_copy_params lsdma_send_pio_copy_params;
 	struct setup_dpp_params setup_dpp_params;
 	struct program_bias_and_scale_params program_bias_and_scale_params;
 	struct set_output_transfer_func_params set_output_transfer_func_params;
@@ -1236,6 +1245,7 @@ enum block_sequence_func {
 	HUBP_SET_DMDATA_ATTRIBUTES,
 	OPTC_PROGRAM_MANUAL_TRIGGER,
 	DMUB_SEND_DMCUB_CMD,
+	LSDMA_SEND_PIO_COPY,
 	DPP_SETUP_DPP,
 	DPP_PROGRAM_BIAS_AND_SCALE,
 	DPP_SET_OUTPUT_TRANSFER_FUNC,
@@ -1847,6 +1857,7 @@ void hwss_process_outstanding_hw_updates(struct dc *dc,
 		struct dc_state *dc_context);
 
 void hwss_send_dmcub_cmd(union block_sequence_params *params);
+void hwss_lsdma_send_pio_copy(union block_sequence_params *params);
 
 void hwss_program_manual_trigger(union block_sequence_params *params);
 
@@ -2205,6 +2216,9 @@ void hwss_add_dmub_send_dmcub_cmd(struct block_sequence_state *seq_state,
 void hwss_add_dmub_subvp_save_surf_addr(struct block_sequence_state *seq_state,
 		struct dc_dmub_srv *dc_dmub_srv, struct dc_plane_address *addr, uint8_t subvp_index);
 
+void hwss_add_lsdma_send_pio_copy(struct block_sequence_state *seq_state,
+		struct dc_dmub_srv *dc_dmub_srv, uint64_t src_addr, uint64_t dst_addr,
+		uint32_t byte_count, uint32_t overlap_disable);
 void hwss_add_hubp_wait_pipe_read_start(struct block_sequence_state *seq_state,
 		struct hubp *hubp);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_status.h b/drivers/gpu/drm/amd/display/dc/inc/core_status.h
index 1a17e727ed04..69215d0e8f46 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_status.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_status.h
@@ -72,6 +72,8 @@ enum dc_status {
 	/// Handshake failed, programming aborted, DCN may be in inconsistent state.
 	DC_DPMS_FAILED_INCOMPLETE = 33,
 
+	DC_NO_DRAM_BUFFER_RESOURCE = 34,
+
 	DC_ERROR_UNEXPECTED = -1
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index b18d607fb222..d2cca2c97a41 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -247,6 +247,8 @@ struct audio_support{
 #define NO_UNDERLAY_PIPE -1
 
 struct resource_pool {
+	struct dc_context *ctx;
+
 	struct mem_input *mis[MAX_PIPES];
 	struct hubp *hubps[MAX_PIPES];
 	struct input_pixel_processor *ipps[MAX_PIPES];
@@ -264,6 +266,13 @@ struct resource_pool {
 	struct dce_i2c_sw *sw_i2cs[MAX_PIPES];
 	bool i2c_hw_buffer_in_use;
 
+	/* LSDMA scratch memory. buffer is NULL when not allocated. */
+	struct {
+		void *buffer;
+		long long pa;
+		unsigned int size;
+	} lsdma_scratch;
+
 	struct dwbc *dwbc[MAX_DWB_PIPES];
 	struct mcif_wb *mcif_wb[MAX_DWB_PIPES];
 	struct {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
index b52d2179532e..534adb1e0ba6 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn60/dcn60_resource.c
@@ -3,6 +3,7 @@
 // Copyright 2024 Advanced Micro Devices, Inc.
 
 #include "dm_services.h"
+#include "dm_helpers.h"
 #include "dc.h"
 
 #include "dcn32/dcn32_init.h"
@@ -84,6 +85,8 @@
 #include "dml2_wrapper/dml2_wrapper.h"
 #include "dml2_wrapper/dml21_wrapper/dml21_wrapper.h"
 
+#define LSDMA_CONTENTION_BUFFER_SIZE (64 * 1024 * 1024)
+
 #define DC_LOGGER_INIT(logger)
 
 /* begin *********************
@@ -1627,6 +1630,12 @@ static void dcn60_resource_destruct(struct dcn60_resource_pool *pool)
 {
 	unsigned int i;
 
+	if (pool->base.lsdma_scratch.buffer) {
+		dm_helpers_free_gpu_mem(pool->base.ctx,
+				DC_MEM_ALLOC_TYPE_GART, pool->base.lsdma_scratch.buffer);
+		pool->base.lsdma_scratch.buffer = NULL;
+	}
+
 	for (i = 0; i < pool->base.stream_enc_count; i++) {
 		if (pool->base.stream_enc[i] != NULL) {
 			if (pool->base.stream_enc[i]->vpg != NULL) {
@@ -2043,6 +2052,16 @@ static bool dcn60_resource_construct(
 	dc->caps.utm_support = true;
 	dc->caps.max_v_total = (1 << 15) - 1;
 
+	pool->base.ctx = ctx;
+
+	if (dc->config.lsdma_peak_bw_contention_support) {
+		pool->base.lsdma_scratch.buffer = dm_helpers_allocate_gpu_mem(ctx,
+				DC_MEM_ALLOC_TYPE_GART, LSDMA_CONTENTION_BUFFER_SIZE,
+				&pool->base.lsdma_scratch.pa);
+		if (pool->base.lsdma_scratch.buffer)
+			pool->base.lsdma_scratch.size = LSDMA_CONTENTION_BUFFER_SIZE;
+	}
+
 	if (ASICREV_IS_GC_12_0_1_A0(dc->ctx->asic_id.hw_internal_rev))
 		dc->caps.dcc_plane_width_limit = 7680;
 
-- 
2.43.0


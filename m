Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E299C982CC
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F95710ED16;
	Wed, 16 Sep 2026 17:53:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="s+NIvkbE";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C46210EBD2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rrEGJT1eZZdaSrRoVKa4jUGsZ29/s0TT6NkS7foHyDjRhOy3A9ad24oaav9KSjBNYgIOQAWtb5vXv5svHtYJHkAQOVlrIiInXzMYqyPsniaSXmly8qdpyifyB/wKmaaSg4SNYS2Bcni1V5nEjHNxSVb/Z0ivKwbRzcYYjUUk/TNIt98hb/PvZJFRU4lWZjwdxCedCd88hAgZloBPFxP7V0g8oVpUPMrKQPR2tKiIg2N70FZDzDidw61coZA7GUyFRv/6pCyv6TwluNF85kAVTalrmGGnqhz4N5myA6eK3yMb2VfIwA/NNx5koojONZdzD+JBIX4zSCQ3RfgK69SK2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kCHn+94zcxiJ9p96D1dxogT9mlAnzb5H/c8Z2yE3QHg=;
 b=DcyQkaah0Alh9ZmSaCzVFDruci2bXnSBXZ++OdwimXhl2zawTtib9NrpKgXLBB0MiY47OVuutqYmdX040Fdaier5OY++pUHFJFtkv5bs+InaheZTnHXIeZWuNPA2WfAOG8H+NtqQDLt1bav18G6pbeXQE8q0LJDf+ZSWkI+rYb7n+fk0xs8XGtrAs4oTx94XBAyKJP8OjBJACw9pR4ETBSypuI+5txHNmv3unQ3HUfonMYx/PALoVNI2W2R3qvAePG2WTGdpOh74NFDecaGurOp2jqlsujqMBsCK4leB6JU6BAEBve0S6B26oMr/WORGZ8LynwjluCcuo23FIjOpPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCHn+94zcxiJ9p96D1dxogT9mlAnzb5H/c8Z2yE3QHg=;
 b=s+NIvkbETfuLAT8BFQdjTQ4unPaQbUCNjE5/H30M7zi0NHWSip3SqKxsDr/O0CFOu57s5hSSthMLKXPTqusukBzs00oR4Ullz7Tb1eFT/HiAvp3t6Nr9g6ckcYZGhhE8GzvG8zoVRrtVB6DMjI2vR02sKrlaXoTCdfkD7rTL9RI=
Received: from CH2PR10CA0007.namprd10.prod.outlook.com (2603:10b6:610:4c::17)
 by DS0PR12MB999106.namprd12.prod.outlook.com (2603:10b6:8:301::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.9; Wed, 16 Sep
 2026 17:53:07 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::3d) by CH2PR10CA0007.outlook.office365.com
 (2603:10b6:610:4c::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.11 via Frontend Transport; Wed,
 16 Sep 2026 17:53:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:53:07 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:55 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Rafal Ostrowski <rafal.ostrowski@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 54/64] drm/amd/display: Drop pipe_ctx from hwss block sequence
 operations
Date: Wed, 16 Sep 2026 13:52:09 -0400
Message-ID: <20260916175301.368306-55-george.zhang@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916175301.368306-1-george.zhang@amd.com>
References: <20260916175301.368306-1-george.zhang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|DS0PR12MB999106:EE_
X-MS-Office365-Filtering-Correlation-Id: f1caaa09-cd9a-4cf2-94ad-08df141b5d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|23010399003|11063799006|3023799007|56012099006|6133799003|22082099003|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: oB1LCqNpe/11cUigoqxUEPP1nJks/5qZ3n3L+WPLSjWgLesd7hAqjqUFM+IqDLThpc/UZ1enqc9U/LJ7o6AuMrFVmgCy/D/LP5YKAnYjzCOEgkFDdqLKRzNkmYsqzFo7jpuZD09swksj6fwME+xSlcPqImkE6GfR86ym1knyVj5Si3YXnuwf4V2zib+VsuHi4hsZerxOG4B9vrCLE9rSwtIlhr8p//Jf1CCyxKh796C3B9VXUPGSMC3pS79mpmqXJpHkVpL5Een/FhQkx+C2X/b6OGfgUs+wpMIhVK1gp8T4HOrZEt8b/acZIZt5o7ym5ZRjSxuQSaT5MLeyTFK095oQ1w3hzAmZq/s+5Os71uW5IFm9PNgPSa1+xlwBh4ZgvtxuYQ2j+0H/FQ7wbMrk2n8yyOpiGRApfXruAg3Krx0QllDYfJX27JAAbD/Ch2tqpkR9oKlSA+V25QDzOrr8y4VRu8k+Q9ho6P+sUa1jLhrOVRyHOevxqB4Puv42+CwxaTfSpjxGT8VcSeSzO7aZac+8W7LXkOLH50dlVg+L/wJOk/LY5PG/a+oWW2t0b+aBctR8uEr2RZ4k8CfK+NJlze1DibXJIhE22ZZMt7c5qhNnX6PG2zieh4e2YVYuqYFdnKX4oPPfjVpcfz1q7Yl6C1fwyjb3lEkaalik15ic2sq8j+gFGB9HVKwdCMYxYydcbcQ5ib540T3gxFrHAUmmKQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(23010399003)(11063799006)(3023799007)(56012099006)(6133799003)(22082099003)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uX3tcLMEq4Epnt269seGOCa5zy0tFcdvqn+R34DCaQBexntugLYtWtFtS+Tf/ynUZVyepaNhnI8lnEKV1MpwTZ455fcuPsefAeZjIEGL8IUslHvLfQY0tjIiRFu2h0Mm296vq4riurzK+ln0RwdFriL1/bhLncsyF4Cf7Dyxa9bhPbqDMhjdYoi6YTZIA/49R4Tt9rDFuJwR8qDENB1uzkHLoVYySf+OJdij6h66uNUjAKMcs0v111WoQjUZkejyfflvaVm/CjNxzzPyi0rd/h4goLVSDvNWWpKE7+QtVymTQYScrCkd5qlyGecXpSrSax520fGWmQaLagM96cfOtwwuAA4ev1M5FmHAIzD/BFkLEVep1vJxAqEORPg96mE7o7VFKXjidEsAyjEpINJjs3itjIqKu49PEhHejcN/eWvSgT/5xi7sVkaYBzt1Asyp
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:53:07.1656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f1caaa09-cd9a-4cf2-94ad-08df141b5d51
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB999106
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

From: Rafal Ostrowski <rafal.ostrowski@amd.com>

[Why]
pipe_ctx is not allowed to reach a block sequence step. Several operations
still carried it into the executor, which then walked the logical state at
execute time (pipe_ctx->stream->timing, pipe_ctx->plane_state and similar)
instead of acting on data resolved during build.

[How]
Give each operation a flat parameter list holding only the hardware objects
and values the final hwss call needs, and change the matching hooks to take
it. The function pointer, the params struct, the executor, the builder
helpers and all call sites are updated together.

Operations covered:
- OPTC_PROGRAM_MANUAL_TRIGGER - takes tg
- HUBP_PROGRAM_TRIPLEBUFFER - program_triplebuffer takes (hubp, bool)
- DPP_SETUP_DPP, DPP_PROGRAM_BIAS_AND_SCALE - take (dpp, plane_state)
- DSC_ENABLE_WITH_OPP - takes (dsc, opp_inst)
- OPP_PROGRAM_BIT_DEPTH_REDUCTION - opp

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Rafal Ostrowski <rafal.ostrowski@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |   4 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 165 ++++++++++--------
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  12 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.h   |   3 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |   6 +-
 .../amd/display/dc/hwss/dcn50/dcn50_hwseq.c   |   4 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  34 ++--
 7 files changed, 128 insertions(+), 100 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7eb08d7d91b6..369569e3b701 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -5140,7 +5140,7 @@ static void commit_planes_for_stream(struct dc *dc,
 		if (dc->hwss.program_triplebuffer != NULL && dc->debug.enable_tri_buf) {
 			/*turn off triple buffer for full update*/
 			dc->hwss.program_triplebuffer(
-				dc, pipe_ctx, pipe_ctx->plane_state->triplebuffer_flips);
+				pipe_ctx->plane_res.hubp, pipe_ctx->plane_state->triplebuffer_flips);
 		}
 	}
 
@@ -5215,7 +5215,7 @@ static void commit_planes_for_stream(struct dc *dc,
 				if (dc->hwss.program_triplebuffer != NULL && dc->debug.enable_tri_buf) {
 					/*only enable triplebuffer for fast_update*/
 					dc->hwss.program_triplebuffer(
-						dc, pipe_ctx, pipe_ctx->plane_state->triplebuffer_flips);
+						pipe_ctx->plane_res.hubp, pipe_ctx->plane_state->triplebuffer_flips);
 				}
 				if (pipe_ctx->plane_state->update_bits.addr_update)
 					dc->hwss.update_plane_addr(dc, pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 2c13f76d764b..f33562dff6ac 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -855,7 +855,9 @@ void hwss_build_full_sequence(struct dc *dc,
 
 			if (pipe->plane_state) {
 				/* Turn off triple buffer for full update */
-				hwss_add_hubp_program_triplebuffer(&seq_state, dc, pipe, pipe->plane_state->triplebuffer_flips);
+				hwss_add_hubp_program_triplebuffer(&seq_state,
+					pipe->plane_res.hubp,
+					pipe->plane_state->triplebuffer_flips);
 			}
 		}
 	}
@@ -1465,11 +1467,9 @@ void hwss_build_fast_sequence(struct dc *dc,
 					(*num_steps)++;
 				}
 				if (dc->hwss.program_triplebuffer && dc->debug.enable_tri_buf && dc_pipe_update_bits_is_any_set(&current_mpc_pipe->plane_state->update_bits)) {
-					block_sequence[*num_steps].params.program_triplebuffer_params.dc = dc;
-					block_sequence[*num_steps].params.program_triplebuffer_params.pipe_ctx = current_mpc_pipe;
-					block_sequence[*num_steps].params.program_triplebuffer_params.enableTripleBuffer = current_mpc_pipe->plane_state->triplebuffer_flips;
-					block_sequence[*num_steps].func = HUBP_PROGRAM_TRIPLEBUFFER;
-					(*num_steps)++;
+					hwss_add_hubp_program_triplebuffer(&seq_state,
+							current_mpc_pipe->plane_res.hubp,
+							current_mpc_pipe->plane_state->triplebuffer_flips);
 				}
 				if (dc->hwss.prepare_plane_addr_update && current_mpc_pipe->plane_state->update_bits.addr_update) {
 					if (resource_is_pipe_type(current_mpc_pipe, OTG_MASTER) &&
@@ -1551,14 +1551,14 @@ void hwss_build_fast_sequence(struct dc *dc,
 					(*num_steps)++;
 				}
 				if (current_mpc_pipe->plane_state->update_bits.input_csc_change) {
-					block_sequence[*num_steps].params.setup_dpp_params.pipe_ctx = current_mpc_pipe;
-					block_sequence[*num_steps].func = DPP_SETUP_DPP;
-					(*num_steps)++;
+					hwss_add_dpp_setup_dpp(&seq_state,
+						current_mpc_pipe->plane_res.dpp,
+						current_mpc_pipe->plane_state);
 				}
 				if (current_mpc_pipe->plane_state->update_bits.coeff_reduction_change) {
-					block_sequence[*num_steps].params.program_bias_and_scale_params.pipe_ctx = current_mpc_pipe;
-					block_sequence[*num_steps].func = DPP_PROGRAM_BIAS_AND_SCALE;
-					(*num_steps)++;
+					hwss_add_dpp_program_bias_and_scale(&seq_state,
+						current_mpc_pipe->plane_res.dpp,
+						current_mpc_pipe->plane_state);
 				}
 				if (current_mpc_pipe->plane_state->update_bits.cm_hist_change) {
 					block_sequence[*num_steps].params.control_cm_hist_params.dpp
@@ -1665,9 +1665,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 					(*num_steps)++;
 				}
 
-				block_sequence[*num_steps].params.program_manual_trigger_params.pipe_ctx = current_mpc_pipe;
-				block_sequence[*num_steps].func = OPTC_PROGRAM_MANUAL_TRIGGER;
-				(*num_steps)++;
+				hwss_add_optc_program_manual_trigger(&seq_state, current_mpc_pipe->stream_res.tg);
 			}
 			current_mpc_pipe = current_mpc_pipe->bottom_pipe;
 		}
@@ -1705,9 +1703,7 @@ void hwss_execute_sequence(struct dc *dc,
 				params->set_flip_control_gsl_params.flip_immediate);
 			break;
 		case HUBP_PROGRAM_TRIPLEBUFFER:
-			dc->hwss.program_triplebuffer(params->program_triplebuffer_params.dc,
-					params->program_triplebuffer_params.pipe_ctx,
-					params->program_triplebuffer_params.enableTripleBuffer);
+			hwss_program_triplebuffer(params);
 			break;
 		case HUBP_UPDATE_PLANE_ADDR:
 			params->update_plane_addr_params.hubp->funcs->hubp_program_surface_flip_and_addr(
@@ -2317,13 +2313,14 @@ void hwss_add_hubp_set_flip_control_gsl(struct block_sequence_state *seq_state,
  * Helper function to add HUBP program triplebuffer to block sequence
  */
 void hwss_add_hubp_program_triplebuffer(struct block_sequence_state *seq_state,
-		struct dc *dc,
-		struct pipe_ctx *pipe_ctx,
+		struct hubp *hubp,
 		bool enableTripleBuffer)
 {
+	if (!hubp || !hubp->funcs->hubp_enable_tripleBuffer)
+		return;
+
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].params.program_triplebuffer_params.dc = dc;
-		seq_state->steps[*seq_state->num_steps].params.program_triplebuffer_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].params.program_triplebuffer_params.hubp = hubp;
 		seq_state->steps[*seq_state->num_steps].params.program_triplebuffer_params.enableTripleBuffer = enableTripleBuffer;
 		seq_state->steps[*seq_state->num_steps].func = HUBP_PROGRAM_TRIPLEBUFFER;
 		(*seq_state->num_steps)++;
@@ -2406,11 +2403,18 @@ void hwss_add_dpp_program_gamut_remap(struct block_sequence_state *seq_state,
 /*
  * Helper function to add DPP program bias and scale to block sequence
  */
-void hwss_add_dpp_program_bias_and_scale(struct block_sequence_state *seq_state, struct pipe_ctx *pipe_ctx)
+void hwss_add_dpp_program_bias_and_scale(struct block_sequence_state *seq_state,
+		struct dpp *dpp,
+		struct dc_plane_state *plane_state)
 {
+	if (!plane_state)
+		return;
+
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].params.program_bias_and_scale_params.pipe_ctx = pipe_ctx;
 		seq_state->steps[*seq_state->num_steps].func = DPP_PROGRAM_BIAS_AND_SCALE;
+		seq_state->steps[*seq_state->num_steps].params.program_bias_and_scale_params.dpp = dpp;
+		seq_state->steps[*seq_state->num_steps].params.program_bias_and_scale_params.bias_and_scale =
+			plane_state->bias_and_scale;
 		(*seq_state->num_steps)++;
 	}
 }
@@ -2419,10 +2423,13 @@ void hwss_add_dpp_program_bias_and_scale(struct block_sequence_state *seq_state,
  * Helper function to add OPTC program manual trigger to block sequence
  */
 void hwss_add_optc_program_manual_trigger(struct block_sequence_state *seq_state,
-		struct pipe_ctx *pipe_ctx)
+		struct timing_generator *tg)
 {
+	if (!tg)
+		return;
+
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].params.program_manual_trigger_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].params.program_manual_trigger_params.tg = tg;
 		seq_state->steps[*seq_state->num_steps].func = OPTC_PROGRAM_MANUAL_TRIGGER;
 		(*seq_state->num_steps)++;
 	}
@@ -2929,44 +2936,44 @@ void hwss_add_hubp_enable_3dlut_fl(struct block_sequence_state *seq_state,
 	}
 }
 
+void hwss_program_triplebuffer(union block_sequence_params *params)
+{
+	struct hubp *hubp = params->program_triplebuffer_params.hubp;
+
+	if (hubp && hubp->funcs->hubp_enable_tripleBuffer)
+		hubp->funcs->hubp_enable_tripleBuffer(hubp,
+				params->program_triplebuffer_params.enableTripleBuffer);
+}
+
 void hwss_program_manual_trigger(union block_sequence_params *params)
 {
-	struct pipe_ctx *pipe_ctx = params->program_manual_trigger_params.pipe_ctx;
+	struct timing_generator *tg = params->program_manual_trigger_params.tg;
 
-	if (pipe_ctx->stream_res.tg->funcs->program_manual_trigger)
-		pipe_ctx->stream_res.tg->funcs->program_manual_trigger(pipe_ctx->stream_res.tg);
+	if (tg && tg->funcs->program_manual_trigger)
+		tg->funcs->program_manual_trigger(tg);
 }
 
 void hwss_setup_dpp(union block_sequence_params *params)
 {
-	struct pipe_ctx *pipe_ctx = params->setup_dpp_params.pipe_ctx;
-	struct dpp *dpp = pipe_ctx->plane_res.dpp;
-	struct dc_plane_state *plane_state = pipe_ctx->plane_state;
-
-	if (!plane_state)
-		return;
+	struct setup_dpp_params *p = &params->setup_dpp_params;
 
-	if (dpp && dpp->funcs->dpp_setup) {
-		// program the input csc
-		dpp->funcs->dpp_setup(dpp,
-				plane_state->format,
+	if (p->dpp && p->dpp->funcs->dpp_setup) {
+		p->dpp->funcs->dpp_setup(p->dpp,
+				p->format,
 				EXPANSION_MODE_ZERO,
-				plane_state->input_csc_color_matrix,
-				plane_state->color_space,
+				p->input_csc_color_matrix,
+				p->color_space,
 				NULL);
 	}
 }
 
 void hwss_program_bias_and_scale(union block_sequence_params *params)
 {
-	struct pipe_ctx *pipe_ctx = params->program_bias_and_scale_params.pipe_ctx;
-	struct dpp *dpp = pipe_ctx->plane_res.dpp;
-	struct dc_plane_state *plane_state = pipe_ctx->plane_state;
-	struct dc_bias_and_scale bns_params = plane_state->bias_and_scale;
+	struct program_bias_and_scale_params *p = &params->program_bias_and_scale_params;
 
 	//TODO :for CNVC set scale and bias registers if necessary
-	if (dpp->funcs->dpp_program_bias_and_scale)
-		dpp->funcs->dpp_program_bias_and_scale(dpp, &bns_params);
+	if (p->dpp && p->dpp->funcs->dpp_program_bias_and_scale)
+		p->dpp->funcs->dpp_program_bias_and_scale(p->dpp, &p->bias_and_scale);
 }
 
 void hwss_program_upsp(union block_sequence_params *params)
@@ -3366,11 +3373,10 @@ void hwss_dsc_calculate_and_set_config(union block_sequence_params *params)
 
 void hwss_dsc_enable_with_opp(union block_sequence_params *params)
 {
-	struct pipe_ctx *pipe_ctx = params->dsc_enable_with_opp_params.pipe_ctx;
-	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
+	struct display_stream_compressor *dsc = params->dsc_enable_with_opp_params.dsc;
 
 	if (dsc && dsc->funcs->dsc_enable)
-		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
+		dsc->funcs->dsc_enable(dsc, params->dsc_enable_with_opp_params.opp_inst);
 }
 
 void hwss_tg_program_global_sync(union block_sequence_params *params)
@@ -3509,17 +3515,10 @@ void hwss_opp_program_fmt(union block_sequence_params *params)
 void hwss_opp_program_bit_depth_reduction(union block_sequence_params *params)
 {
 	struct output_pixel_processor *opp = params->opp_program_bit_depth_reduction_params.opp;
-	bool use_default_params = params->opp_program_bit_depth_reduction_params.use_default_params;
-	struct pipe_ctx *pipe_ctx = params->opp_program_bit_depth_reduction_params.pipe_ctx;
-	struct bit_depth_reduction_params bit_depth_params;
-
-	if (use_default_params)
-		memset(&bit_depth_params, 0, sizeof(bit_depth_params));
-	else
-		resource_build_bit_depth_reduction_params(pipe_ctx->stream, &bit_depth_params);
 
-	if (opp->funcs->opp_program_bit_depth_reduction)
-		opp->funcs->opp_program_bit_depth_reduction(opp, &bit_depth_params);
+	if (opp && opp->funcs->opp_program_bit_depth_reduction)
+		opp->funcs->opp_program_bit_depth_reduction(opp,
+			&params->opp_program_bit_depth_reduction_params.bit_depth_params);
 }
 
 void hwss_opp_set_disp_pattern_generator(union block_sequence_params *params)
@@ -4774,9 +4773,15 @@ void hwss_add_hubp_disconnect(struct block_sequence_state *seq_state,
 void hwss_add_dsc_enable_with_opp(struct block_sequence_state *seq_state,
 		struct pipe_ctx *pipe_ctx)
 {
+	if (!pipe_ctx || !pipe_ctx->stream_res.dsc || !pipe_ctx->stream_res.opp)
+		return;
+
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
 		seq_state->steps[*seq_state->num_steps].func = DSC_ENABLE_WITH_OPP;
-		seq_state->steps[*seq_state->num_steps].params.dsc_enable_with_opp_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].params.dsc_enable_with_opp_params.dsc =
+			pipe_ctx->stream_res.dsc;
+		seq_state->steps[*seq_state->num_steps].params.dsc_enable_with_opp_params.opp_inst =
+			pipe_ctx->stream_res.opp->inst;
 		(*seq_state->num_steps)++;
 	}
 }
@@ -4928,13 +4933,23 @@ void hwss_add_opp_program_bit_depth_reduction(struct block_sequence_state *seq_s
 		bool use_default_params,
 		struct pipe_ctx *pipe_ctx)
 {
-	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].func = OPP_PROGRAM_BIT_DEPTH_REDUCTION;
-		seq_state->steps[*seq_state->num_steps].params.opp_program_bit_depth_reduction_params.opp = opp;
-		seq_state->steps[*seq_state->num_steps].params.opp_program_bit_depth_reduction_params.use_default_params = use_default_params;
-		seq_state->steps[*seq_state->num_steps].params.opp_program_bit_depth_reduction_params.pipe_ctx = pipe_ctx;
-		(*seq_state->num_steps)++;
-	}
+	struct opp_program_bit_depth_reduction_params *bdr_params;
+
+	if (!opp)
+		return;
+
+	if (*seq_state->num_steps >= MAX_HWSS_BLOCK_SEQUENCE_SIZE)
+		return;
+
+	bdr_params = &seq_state->steps[*seq_state->num_steps].params.opp_program_bit_depth_reduction_params;
+	memset(bdr_params, 0, sizeof(*bdr_params));
+	bdr_params->opp = opp;
+
+	if (!use_default_params && pipe_ctx)
+		resource_build_bit_depth_reduction_params(pipe_ctx->stream, &bdr_params->bit_depth_params);
+
+	seq_state->steps[*seq_state->num_steps].func = OPP_PROGRAM_BIT_DEPTH_REDUCTION;
+	(*seq_state->num_steps)++;
 }
 
 void hwss_add_dpp_program_cm_hist(struct block_sequence_state *seq_state,
@@ -5657,11 +5672,21 @@ void hwss_add_hubp_program_surface_config(struct block_sequence_state *seq_state
 }
 
 void hwss_add_dpp_setup_dpp(struct block_sequence_state *seq_state,
-		struct pipe_ctx *pipe_ctx)
+		struct dpp *dpp,
+		struct dc_plane_state *plane_state)
 {
+	if (!plane_state)
+		return;
+
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		struct setup_dpp_params *p =
+			&seq_state->steps[*seq_state->num_steps].params.setup_dpp_params;
+
 		seq_state->steps[*seq_state->num_steps].func = DPP_SETUP_DPP;
-		seq_state->steps[*seq_state->num_steps].params.setup_dpp_params.pipe_ctx = pipe_ctx;
+		p->dpp = dpp;
+		p->format = plane_state->format;
+		p->input_csc_color_matrix = plane_state->input_csc_color_matrix;
+		p->color_space = plane_state->color_space;
 		(*seq_state->num_steps)++;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index e5f266b0013d..e7ca38bcaabf 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -394,14 +394,12 @@ void dcn20_disable_vga(
 }
 
 void dcn20_program_triple_buffer(
-	const struct dc *dc,
-	struct pipe_ctx *pipe_ctx,
+	struct hubp *hubp,
 	bool enable_triple_buffer)
 {
-	(void)dc;
-	if (pipe_ctx->plane_res.hubp && pipe_ctx->plane_res.hubp->funcs) {
-		pipe_ctx->plane_res.hubp->funcs->hubp_enable_tripleBuffer(
-			pipe_ctx->plane_res.hubp,
+	if (hubp && hubp->funcs) {
+		hubp->funcs->hubp_enable_tripleBuffer(
+			hubp,
 			enable_triple_buffer);
 	}
 }
@@ -2110,7 +2108,7 @@ void dcn20_program_front_end_for_ctx(
 				ASSERT(!pipe->plane_state->triplebuffer_flips);
 				/*turn off triple buffer for full update*/
 				dc->hwss.program_triplebuffer(
-					dc, pipe, pipe->plane_state->triplebuffer_flips);
+					pipe->plane_res.hubp, pipe->plane_state->triplebuffer_flips);
 			}
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
index 9711b8bc9083..9a5addaa9a03 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
@@ -114,8 +114,7 @@ void dcn20_hubp_pg_control(
 		unsigned int hubp_inst,
 		bool power_on);
 void dcn20_program_triple_buffer(
-	const struct dc *dc,
-	struct pipe_ctx *pipe_ctx,
+	struct hubp *hubp,
 	bool enable_triple_buffer);
 void dcn20_enable_writeback(
 		struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 8f202206c3c4..3dd3dacfe5ee 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -2533,7 +2533,7 @@ void dcn401_program_front_end_for_ctx(
 
 				/*turn off triple buffer for full update*/
 				dc->hwss.program_triplebuffer(
-					dc, pipe, pipe->plane_state->triplebuffer_flips);
+					pipe->plane_res.hubp, pipe->plane_state->triplebuffer_flips);
 			}
 		}
 	}
@@ -3686,7 +3686,7 @@ void dcn401_update_dchubp_dpp_sequence(struct dc *dc,
 			plane_state->update_bits.input_csc_change ||
 			plane_state->update_bits.color_space_change ||
 			plane_state->update_bits.coeff_reduction_change) {
-		hwss_add_dpp_setup_dpp(seq_state, pipe_ctx);
+		hwss_add_dpp_setup_dpp(seq_state, dpp, plane_state);
 
 		/* Step 8: DPP cursor matrix setup */
 		if (dpp->funcs->set_cursor_matrix) {
@@ -3696,7 +3696,7 @@ void dcn401_update_dchubp_dpp_sequence(struct dc *dc,
 
 		/* Step 9: DPP program bias and scale */
 		if (dpp->funcs->dpp_program_bias_and_scale)
-			hwss_add_dpp_program_bias_and_scale(seq_state, pipe_ctx);
+			hwss_add_dpp_program_bias_and_scale(seq_state, dpp, plane_state);
 	}
 
 	/* Step 10: MPCC updates */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
index b1a916ac04e7..f1c044fe0ba2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
@@ -315,7 +315,7 @@ void dcn50_update_dchubp_dpp_sequence(struct dc *dc,
 			plane_state->update_bits.input_csc_change ||
 			plane_state->update_bits.color_space_change ||
 			plane_state->update_bits.coeff_reduction_change) {
-		hwss_add_dpp_setup_dpp(seq_state, pipe_ctx);
+		hwss_add_dpp_setup_dpp(seq_state, dpp, plane_state);
 
 		/* Step 8: DPP cursor matrix setup */
 		if (dpp->funcs->set_cursor_matrix) {
@@ -325,7 +325,7 @@ void dcn50_update_dchubp_dpp_sequence(struct dc *dc,
 
 		/* Step 9: DPP program bias and scale */
 		if (dpp->funcs->dpp_program_bias_and_scale)
-			hwss_add_dpp_program_bias_and_scale(seq_state, pipe_ctx);
+			hwss_add_dpp_program_bias_and_scale(seq_state, dpp, plane_state);
 	}
 
 	/* Step 10: MPCC updates */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index cc1c54c46e25..c902a28b3220 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -87,8 +87,7 @@ struct set_flip_control_gsl_params {
 };
 
 struct program_triplebuffer_params {
-	const struct dc *dc;
-	struct pipe_ctx *pipe_ctx;
+	struct hubp *hubp;
 	bool enableTripleBuffer;
 };
 
@@ -138,7 +137,7 @@ struct update_info_frame_params {
 };
 
 struct program_manual_trigger_params {
-	struct pipe_ctx *pipe_ctx;
+	struct timing_generator *tg;
 };
 
 struct send_dmcub_cmd_params {
@@ -156,11 +155,15 @@ struct lsdma_send_pio_copy_params {
 };
 
 struct setup_dpp_params {
-	struct pipe_ctx *pipe_ctx;
+	struct dpp *dpp;
+	enum surface_pixel_format format;
+	struct dc_csc_transform input_csc_color_matrix;
+	enum dc_color_space color_space;
 };
 
 struct program_bias_and_scale_params {
-	struct pipe_ctx *pipe_ctx;
+	struct dpp *dpp;
+	struct dc_bias_and_scale bias_and_scale;
 };
 
 struct set_output_transfer_func_params {
@@ -313,7 +316,8 @@ struct dsc_calculate_and_set_config_params {
 };
 
 struct dsc_enable_with_opp_params {
-	struct pipe_ctx *pipe_ctx;
+	struct display_stream_compressor *dsc;
+	int opp_inst;
 };
 
 struct program_tg_params {
@@ -412,8 +416,7 @@ struct opp_program_fmt_params {
 
 struct opp_program_bit_depth_reduction_params {
 	struct output_pixel_processor *opp;
-	bool use_default_params;
-	struct pipe_ctx *pipe_ctx;
+	struct bit_depth_reduction_params bit_depth_params;
 };
 
 struct opp_set_disp_pattern_generator_params {
@@ -1463,8 +1466,7 @@ struct hw_sequencer_funcs {
 	void (*edp_backlight_control)(
 			struct dc_link *link,
 			bool enable);
-	void (*program_triplebuffer)(const struct dc *dc,
-		struct pipe_ctx *pipe_ctx, bool enableTripleBuffer);
+	void (*program_triplebuffer)(struct hubp *hubp, bool enableTripleBuffer);
 	void (*update_pending_status)(struct pipe_ctx *pipe_ctx);
 	void (*update_dsc_pg)(struct dc *dc, struct dc_state *context, bool safe_to_disable);
 	void (*clear_surface_dcc_and_tiling)(struct pipe_ctx *pipe_ctx, struct dc_plane_state *plane_state, bool clear_tiling);
@@ -1871,6 +1873,8 @@ void hwss_process_outstanding_hw_updates(struct dc *dc,
 void hwss_send_dmcub_cmd(union block_sequence_params *params);
 void hwss_lsdma_send_pio_copy(union block_sequence_params *params);
 
+void hwss_program_triplebuffer(union block_sequence_params *params);
+
 void hwss_program_manual_trigger(union block_sequence_params *params);
 
 void hwss_setup_dpp(union block_sequence_params *params);
@@ -2188,7 +2192,7 @@ void hwss_add_hubp_set_flip_control_gsl(struct block_sequence_state *seq_state,
 		struct hubp *hubp, bool flip_immediate);
 
 void hwss_add_hubp_program_triplebuffer(struct block_sequence_state *seq_state,
-		struct dc *dc, struct pipe_ctx *pipe_ctx, bool enableTripleBuffer);
+		struct hubp *hubp, bool enableTripleBuffer);
 
 void hwss_add_hubp_update_plane_addr(struct block_sequence_state *seq_state,
 		struct dc *dc, struct pipe_ctx *pipe_ctx);
@@ -2200,10 +2204,11 @@ void hwss_add_dpp_program_gamut_remap(struct block_sequence_state *seq_state,
 		struct pipe_ctx *pipe_ctx);
 
 void hwss_add_dpp_program_bias_and_scale(struct block_sequence_state *seq_state,
-		struct pipe_ctx *pipe_ctx);
+		struct dpp *dpp,
+		struct dc_plane_state *plane_state);
 
 void hwss_add_optc_program_manual_trigger(struct block_sequence_state *seq_state,
-		struct pipe_ctx *pipe_ctx);
+		struct timing_generator *tg);
 
 void hwss_add_dpp_set_output_transfer_func(struct block_sequence_state *seq_state,
 		struct dc *dc, struct pipe_ctx *pipe_ctx);
@@ -2581,7 +2586,8 @@ void hwss_add_hubp_program_surface_config(struct block_sequence_state *seq_state
 		int compat_level);
 
 void hwss_add_dpp_setup_dpp(struct block_sequence_state *seq_state,
-		struct pipe_ctx *pipe_ctx);
+		struct dpp *dpp,
+		struct dc_plane_state *plane_state);
 
 void hwss_add_dpp_set_cursor_matrix(struct block_sequence_state *seq_state,
 		struct dpp *dpp,
-- 
2.55.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262B6CD11DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:51:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2BE710F2D5;
	Thu, 28 Mar 2024 19:51:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="17QNgoAS";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2049.outbound.protection.outlook.com [40.107.220.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C9CC10F2D5
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:51:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZsrmYP4ZN+g4kbuxV88XqeNF2quZlUL9ZXytyEmg01pdLP/kMH47tNhI801xkq6EZoxQY0otweBflvvxF4HM04QCD7AQjxkECLxhyecOFbCZhjfGp8kS9Yw57THvjJsYSE86aQMMV5vmq597QI11NNU39sGC2gqijvX7nI1XpH20eOzFggJly9MeNfnPCqHBbdgyn2vxmhMerkblkBSOdqQmwpS2VpHmCzPQk/YmtSd264rdf7D6Ew/8yjJjQ+qO4wLDdp+BHvAe4C5Bx1nFqmfPDNEt16weNvNvh+6w/XfyjR6uWUflIPPR3t9qZolTWk059n7T/cekwf7I6gQo6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3/MbH2Oa938lo43iGEFOl0kQLTriaua9otvEC3NVFF0=;
 b=SbWYsuEOUfwDON+tFFlHwfH8LYNtYGorFnSA3FZPeGW62MsCRvhjNq7QbCg2dZ1heMpH8SqZKqTqoVpIPhaDTv40OCx2qLOf9vIvueb9+A5CXArA8NKaY/HgN+OK2ye5tPQLj3DMzF6+kruS0m+wo/C60d0bQAUSjD6xUrLPtlHkJ0aQiyPrf/8EkczvfbQ4j2SjGtaKvsavVpef5uHNC/QbheEfrU72KQnq4FEdd0z5CrC73KhTETTSzLZF+nVtXkUEoApW53yYSXFLx+jHQ4rDD9O5ltTWL75eD6iLKizRIkTXzLQesdrJTDltECdMYhHWTc1ne59qQ6D6cKz8GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3/MbH2Oa938lo43iGEFOl0kQLTriaua9otvEC3NVFF0=;
 b=17QNgoASMUbWfns7fJA9WXxK05ABmVyrgNF3F8o/+rARlH7CKi6UE/oDsLQgYAvRfCR/uFF1tpgqp7o1zBlQCx5K1nLz6umdLmFPyiT8hAzTn0yaZgRPrWKAQ28eUovJ98fsOZH5pVM5Y7a/RwY5M/Hb4lzdTkLOrd6eNnuTcVA=
Received: from SJ0PR03CA0354.namprd03.prod.outlook.com (2603:10b6:a03:39c::29)
 by IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 19:51:35 +0000
Received: from CO1PEPF000042AE.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::85) by SJ0PR03CA0354.outlook.office365.com
 (2603:10b6:a03:39c::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 19:51:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AE.mail.protection.outlook.com (10.167.243.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:51:34 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:27 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:27 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:51:26 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, Samson Tam
 <samson.tam@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 03/43] drm/amd/display: fix underflow in some two display
 subvp/non-subvp configs
Date: Thu, 28 Mar 2024 15:50:07 -0400
Message-ID: <20240328195047.2843715-4-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AE:EE_|IA1PR12MB8359:EE_
X-MS-Office365-Filtering-Correlation-Id: b0e3aa2d-a712-468d-2107-08dc4f607929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +7Fb6rioKdRq26VVD0mUe4FO98S9qVSRdoVGoWDLtzZWkqoRwG4KdYkVuYQT5g1H83f/PM9ScIpJgiru2BRIg5VpWkouqvUgD50B7JqahRtq5PUEK39QsZnOALkawZNpVE38h9XLYMq6UD4l0dkYwYOBIty6KMk/56xsnvhmiSlJ6WSIKOh+XmAa2CEBmqMLi2BcZueR17/bTlQ9IO57B9HQN9hBInQb2USmcC35r6WMCedJyOhlKmLUbNOSxTebs3UUmEt5G43iGrsUvv7CoTaWAQ2HcShb7cmwU37a9p7KLnJ00n4YPlC6hI7CmsZBxe+UtTcUWSzJzeR/0CHYbbyGUkud/4AicQqgKj1DTwWpBzuQcVTQplxDuUnPRiIaVwLRfp46hciCsBpwlFrN1/8vyj7zNS30bbKkTOtvMO0pbx1CVM8w3M0aC3KQYPKJXix1wss8MQXPTbVNzj9ncIk3Y9oDUKvQDhMvPY6m+Kf6U2Idj555NgAdwyzPQ2bIoqV5Ad00g45nZX6KarxmkzqrClkfpitN6BxAraTxGNE2eo2JokNRCvQhmiVHGddAhB3FUCTzG/7Ob+oiBf/Fqd3PLtjEHqTOyvzC9eGQuCcXToed9wUkc5me99sPw/XgSR0JTq8i5KI9cjDEGFPEX2+BHepoTDqdzHsfuTaER2Y49B2giyDuSfHmK/x8xbSh9A8eLel1O0qUEDx+iyzm+YsNE4NGXoUlFIVoxfRfAQE3ZNPYxExheQ45LOyldZEF
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004)(1800799015)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:51:34.5773 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0e3aa2d-a712-468d-2107-08dc4f607929
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359
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

From: Samson Tam <samson.tam@amd.com>

[Why]
In two display configuration, switching between subvp and non-subvp
 may cause underflow because it moves an existing pipe between
 displays

[How]
Create helper function for applying pipe split flags
Apply pipe split flags prior to deciding on subvp
During subvp check, do not merge pipes, so it can retain previous
 pipe configuration
Add check for prev odm pipe in subvp check
For single display subvp case, use same odm policy for phantom pipes
 as main subvp pipe

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Samson Tam <samson.tam@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 259 ++++++++++--------
 .../dc/resource/dcn32/dcn32_resource.c        |  70 ++++-
 2 files changed, 199 insertions(+), 130 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index a0a65e099104..8c0e1ab29aa9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -180,6 +180,9 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_2_soc = {
 	.urgent_latency_adjustment_fabric_clock_reference_mhz = 3000,
 };
 
+static bool dcn32_apply_merge_split_flags_helper(struct dc *dc, struct dc_state *context,
+	bool *repopulate_pipes, int *split, bool *merge);
+
 void dcn32_build_wm_range_table_fpu(struct clk_mgr_internal *clk_mgr)
 {
 	/* defaults */
@@ -622,7 +625,7 @@ static bool dcn32_assign_subvp_pipe(struct dc *dc,
 		 *   to combine this with SubVP can cause issues with the scheduling).
 		 * - Not TMZ surface
 		 */
-		if (pipe->plane_state && !pipe->top_pipe && !dcn32_is_center_timing(pipe) &&
+		if (pipe->plane_state && !pipe->top_pipe && !pipe->prev_odm_pipe && !dcn32_is_center_timing(pipe) &&
 				!(pipe->stream->timing.pix_clk_100hz / 10000 > DCN3_2_MAX_SUBVP_PIXEL_RATE_MHZ) &&
 				(!dcn32_is_psr_capable(pipe) || (context->stream_count == 1 && dc->caps.dmub_caps.subvp_psr)) &&
 				dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_NONE &&
@@ -1425,13 +1428,14 @@ static bool is_test_pattern_enabled(
 	return false;
 }
 
-static void dcn32_full_validate_bw_helper(struct dc *dc,
+static bool dcn32_full_validate_bw_helper(struct dc *dc,
 				   struct dc_state *context,
 				   display_e2e_pipe_params_st *pipes,
 				   int *vlevel,
 				   int *split,
 				   bool *merge,
-				   int *pipe_cnt)
+				   int *pipe_cnt,
+				   bool *repopulate_pipes)
 {
 	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
 	unsigned int dc_pipe_idx = 0;
@@ -1461,6 +1465,12 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 		vba->VoltageLevel = *vlevel;
 	}
 
+	/* Apply split and merge flags before checking for subvp */
+	if (!dcn32_apply_merge_split_flags_helper(dc, context, repopulate_pipes, split, merge))
+		return false;
+	memset(split, 0, MAX_PIPES * sizeof(int));
+	memset(merge, 0, MAX_PIPES * sizeof(bool));
+
 	/* Conditions for setting up phantom pipes for SubVP:
 	 * 1. Not force disable SubVP
 	 * 2. Full update (i.e. !fast_validate)
@@ -1475,19 +1485,7 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 	    vba->DRAMClockChangeSupport[*vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported ||
 	    dc->debug.force_subvp_mclk_switch)) {
 
-		dcn32_merge_pipes_for_subvp(dc, context);
-		memset(merge, 0, MAX_PIPES * sizeof(bool));
-
 		vlevel_temp = *vlevel;
-		/* to re-initialize viewport after the pipe merge */
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-
-			if (!pipe_ctx->plane_state || !pipe_ctx->stream)
-				continue;
-
-			resource_build_scaling_params(pipe_ctx);
-		}
 
 		while (!found_supported_config && dcn32_enough_pipes_for_subvp(dc, context) &&
 			dcn32_assign_subvp_pipe(dc, context, &dc_pipe_idx)) {
@@ -1576,8 +1574,6 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 			 * add phantom pipes. If pipe split (ODM / MPC) is required, both the main
 			 * and phantom pipes will be split in the regular pipe splitting sequence.
 			 */
-			memset(split, 0, MAX_PIPES * sizeof(int));
-			memset(merge, 0, MAX_PIPES * sizeof(bool));
 			*vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, *vlevel, split, merge);
 			vba->VoltageLevel = *vlevel;
 			// Note: We can't apply the phantom pipes to hardware at this time. We have to wait
@@ -1590,6 +1586,7 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 		try_odm_power_optimization_and_revalidate(
 				dc, context, pipes, split, merge, vlevel, *pipe_cnt);
 
+	return true;
 }
 
 static bool is_dtbclk_required(struct dc *dc, struct dc_state *context)
@@ -1929,106 +1926,23 @@ static bool dcn32_split_stream_for_mpc_or_odm(
 	return true;
 }
 
-bool dcn32_internal_validate_bw(struct dc *dc,
-				struct dc_state *context,
-				display_e2e_pipe_params_st *pipes,
-				int *pipe_cnt_out,
-				int *vlevel_out,
-				bool fast_validate)
+static bool dcn32_apply_merge_split_flags_helper(
+		struct dc *dc,
+		struct dc_state *context,
+		bool *repopulate_pipes,
+		int *split,
+		bool *merge)
 {
-	bool out = false;
-	bool repopulate_pipes = false;
-	int split[MAX_PIPES] = { 0 };
-	bool merge[MAX_PIPES] = { false };
+	int i, pipe_idx;
 	bool newly_split[MAX_PIPES] = { false };
-	int pipe_cnt, i, pipe_idx;
-	int vlevel = context->bw_ctx.dml.soc.num_states;
 	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
 
-	dc_assert_fp_enabled();
-
-	ASSERT(pipes);
-	if (!pipes)
-		return false;
-
-	// For each full update, remove all existing phantom pipes first
-	dc_state_remove_phantom_streams_and_planes(dc, context);
-	dc_state_release_phantom_streams_and_planes(dc, context);
-
-	dc->res_pool->funcs->update_soc_for_wm_a(dc, context);
-
-	pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, fast_validate);
-
-	if (!pipe_cnt) {
-		out = true;
-		goto validate_out;
-	}
-
-	dml_log_pipe_params(&context->bw_ctx.dml, pipes, pipe_cnt);
-	context->bw_ctx.dml.soc.max_vratio_pre = dcn32_determine_max_vratio_prefetch(dc, context);
-
-	if (!fast_validate)
-		dcn32_full_validate_bw_helper(dc, context, pipes, &vlevel, split, merge, &pipe_cnt);
-
-	if (fast_validate ||
-			(dc->debug.dml_disallow_alternate_prefetch_modes &&
-			(vlevel == context->bw_ctx.dml.soc.num_states ||
-				vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported))) {
-		/*
-		 * If dml_disallow_alternate_prefetch_modes is false, then we have already
-		 * tried alternate prefetch modes during full validation.
-		 *
-		 * If mode is unsupported or there is no p-state support, then
-		 * fall back to favouring voltage.
-		 *
-		 * If Prefetch mode 0 failed for this config, or passed with Max UCLK, then try
-		 * to support with Prefetch mode 1 (dm_prefetch_support_fclk_and_stutter == 2)
-		 */
-		context->bw_ctx.dml.soc.allow_for_pstate_or_stutter_in_vblank_final =
-			dm_prefetch_support_none;
-
-		context->bw_ctx.dml.validate_max_state = fast_validate;
-		vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
-
-		context->bw_ctx.dml.validate_max_state = false;
-
-		if (vlevel < context->bw_ctx.dml.soc.num_states) {
-			memset(split, 0, sizeof(split));
-			memset(merge, 0, sizeof(merge));
-			vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
-			// dcn20_validate_apply_pipe_split_flags can modify voltage level outside of DML
-			vba->VoltageLevel = vlevel;
-		}
-	}
-
-	dml_log_mode_support_params(&context->bw_ctx.dml);
-
-	if (vlevel == context->bw_ctx.dml.soc.num_states)
-		goto validate_fail;
-
-	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-		struct pipe_ctx *mpo_pipe = pipe->bottom_pipe;
-
-		if (!pipe->stream)
-			continue;
-
-		if (vba->ODMCombineEnabled[vba->pipe_plane[pipe_idx]] != dm_odm_combine_mode_disabled
-				&& !dc->config.enable_windowed_mpo_odm
-				&& pipe->plane_state && mpo_pipe
-				&& memcmp(&mpo_pipe->plane_state->clip_rect,
-						&pipe->stream->src,
-						sizeof(struct rect)) != 0) {
-			ASSERT(mpo_pipe->plane_state != pipe->plane_state);
-			goto validate_fail;
-		}
-		pipe_idx++;
-	}
-
 	if (dc->config.enable_windowed_mpo_odm) {
-		repopulate_pipes = update_pipes_with_split_flags(
-				dc, context, vba, split, merge);
+		if (update_pipes_with_split_flags(
+			dc, context, vba, split, merge))
+			*repopulate_pipes = true;
 	} else {
+
 		/* the code below will be removed once windowed mpo odm is fully
 		 * enabled.
 		 */
@@ -2085,7 +1999,7 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 				memset(&pipe->plane_res, 0, sizeof(pipe->plane_res));
 				memset(&pipe->stream_res, 0, sizeof(pipe->stream_res));
 				memset(&pipe->link_res, 0, sizeof(pipe->link_res));
-				repopulate_pipes = true;
+				*repopulate_pipes = true;
 			} else if (pipe->top_pipe && pipe->top_pipe->plane_state == pipe->plane_state) {
 				struct pipe_ctx *top_pipe = pipe->top_pipe;
 				struct pipe_ctx *bottom_pipe = pipe->bottom_pipe;
@@ -2101,7 +2015,7 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 				memset(&pipe->plane_res, 0, sizeof(pipe->plane_res));
 				memset(&pipe->stream_res, 0, sizeof(pipe->stream_res));
 				memset(&pipe->link_res, 0, sizeof(pipe->link_res));
-				repopulate_pipes = true;
+				*repopulate_pipes = true;
 			} else
 				ASSERT(0); /* Should never try to merge master pipe */
 
@@ -2140,15 +2054,15 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 				hsplit_pipe = dcn32_find_split_pipe(dc, context, old_index);
 				ASSERT(hsplit_pipe);
 				if (!hsplit_pipe)
-					goto validate_fail;
+					return false;
 
 				if (!dcn32_split_stream_for_mpc_or_odm(
 						dc, &context->res_ctx,
 						pipe, hsplit_pipe, odm))
-					goto validate_fail;
+					return false;
 
 				newly_split[hsplit_pipe->pipe_idx] = true;
-				repopulate_pipes = true;
+				*repopulate_pipes = true;
 			}
 			if (split[i] == 4) {
 				struct pipe_ctx *pipe_4to1;
@@ -2163,11 +2077,11 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 				pipe_4to1 = dcn32_find_split_pipe(dc, context, old_index);
 				ASSERT(pipe_4to1);
 				if (!pipe_4to1)
-					goto validate_fail;
+					return false;
 				if (!dcn32_split_stream_for_mpc_or_odm(
 						dc, &context->res_ctx,
 						pipe, pipe_4to1, odm))
-					goto validate_fail;
+					return false;
 				newly_split[pipe_4to1->pipe_idx] = true;
 
 				if (odm && old_pipe->next_odm_pipe && old_pipe->next_odm_pipe->next_odm_pipe
@@ -2182,11 +2096,11 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 				pipe_4to1 = dcn32_find_split_pipe(dc, context, old_index);
 				ASSERT(pipe_4to1);
 				if (!pipe_4to1)
-					goto validate_fail;
+					return false;
 				if (!dcn32_split_stream_for_mpc_or_odm(
 						dc, &context->res_ctx,
 						hsplit_pipe, pipe_4to1, odm))
-					goto validate_fail;
+					return false;
 				newly_split[pipe_4to1->pipe_idx] = true;
 			}
 			if (odm)
@@ -2198,10 +2112,113 @@ bool dcn32_internal_validate_bw(struct dc *dc,
 
 			if (pipe->plane_state) {
 				if (!resource_build_scaling_params(pipe))
-					goto validate_fail;
+					return false;
 			}
 		}
 	}
+	return true;
+}
+
+bool dcn32_internal_validate_bw(struct dc *dc,
+				struct dc_state *context,
+				display_e2e_pipe_params_st *pipes,
+				int *pipe_cnt_out,
+				int *vlevel_out,
+				bool fast_validate)
+{
+	bool out = false;
+	bool repopulate_pipes = false;
+	int split[MAX_PIPES] = { 0 };
+	bool merge[MAX_PIPES] = { false };
+	int pipe_cnt, i, pipe_idx;
+	int vlevel = context->bw_ctx.dml.soc.num_states;
+	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
+
+	dc_assert_fp_enabled();
+
+	ASSERT(pipes);
+	if (!pipes)
+		return false;
+
+	/* For each full update, remove all existing phantom pipes first */
+	dc_state_remove_phantom_streams_and_planes(dc, context);
+	dc_state_release_phantom_streams_and_planes(dc, context);
+
+	dc->res_pool->funcs->update_soc_for_wm_a(dc, context);
+
+	pipe_cnt = dc->res_pool->funcs->populate_dml_pipes(dc, context, pipes, fast_validate);
+
+	if (!pipe_cnt) {
+		out = true;
+		goto validate_out;
+	}
+
+	dml_log_pipe_params(&context->bw_ctx.dml, pipes, pipe_cnt);
+	context->bw_ctx.dml.soc.max_vratio_pre = dcn32_determine_max_vratio_prefetch(dc, context);
+
+	if (!fast_validate) {
+		if (!dcn32_full_validate_bw_helper(dc, context, pipes, &vlevel, split, merge,
+			&pipe_cnt, &repopulate_pipes))
+			goto validate_fail;
+	}
+
+	if (fast_validate ||
+			(dc->debug.dml_disallow_alternate_prefetch_modes &&
+			(vlevel == context->bw_ctx.dml.soc.num_states ||
+				vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported))) {
+		/*
+		 * If dml_disallow_alternate_prefetch_modes is false, then we have already
+		 * tried alternate prefetch modes during full validation.
+		 *
+		 * If mode is unsupported or there is no p-state support, then
+		 * fall back to favouring voltage.
+		 *
+		 * If Prefetch mode 0 failed for this config, or passed with Max UCLK, then try
+		 * to support with Prefetch mode 1 (dm_prefetch_support_fclk_and_stutter == 2)
+		 */
+		context->bw_ctx.dml.soc.allow_for_pstate_or_stutter_in_vblank_final =
+			dm_prefetch_support_none;
+
+		context->bw_ctx.dml.validate_max_state = fast_validate;
+		vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
+
+		context->bw_ctx.dml.validate_max_state = false;
+
+		if (vlevel < context->bw_ctx.dml.soc.num_states) {
+			memset(split, 0, sizeof(split));
+			memset(merge, 0, sizeof(merge));
+			vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, vlevel, split, merge);
+			/* dcn20_validate_apply_pipe_split_flags can modify voltage level outside of DML */
+			vba->VoltageLevel = vlevel;
+		}
+	}
+
+	dml_log_mode_support_params(&context->bw_ctx.dml);
+
+	if (vlevel == context->bw_ctx.dml.soc.num_states)
+		goto validate_fail;
+
+	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *mpo_pipe = pipe->bottom_pipe;
+
+		if (!pipe->stream)
+			continue;
+
+		if (vba->ODMCombineEnabled[vba->pipe_plane[pipe_idx]] != dm_odm_combine_mode_disabled
+				&& !dc->config.enable_windowed_mpo_odm
+				&& pipe->plane_state && mpo_pipe
+				&& memcmp(&mpo_pipe->plane_state->clip_rect,
+						&pipe->stream->src,
+						sizeof(struct rect)) != 0) {
+			ASSERT(mpo_pipe->plane_state != pipe->plane_state);
+			goto validate_fail;
+		}
+		pipe_idx++;
+	}
+
+	if (!dcn32_apply_merge_split_flags_helper(dc, context, &repopulate_pipes, split, merge))
+		goto validate_fail;
 
 	/* Actual dsc count per stream dsc validation*/
 	if (!dcn20_validate_dsc(dc, context)) {
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index da15ad845147..0c8dd71148b4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1815,9 +1815,47 @@ int dcn32_populate_dml_pipes_from_context(
 	struct pipe_ctx *pipe = NULL;
 	bool subvp_in_use = false;
 	struct dc_crtc_timing *timing;
+	int subvp_main_pipe_index = -1;
+	enum mall_stream_type mall_type;
+	bool single_display_subvp = false;
+	struct dc_stream_state *stream = NULL;
+	int num_subvp_main = 0;
+	int num_subvp_phantom = 0;
+	int num_subvp_none = 0;
 
 	dcn20_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
 
+	/* For single display subvp, look for subvp main so if we have phantom
+	 *  pipe, we can set odm policy to match main pipe
+	 */
+	for (i = 0; i < context->stream_count; i++) {
+		stream = context->streams[i];
+		mall_type = dc_state_get_stream_subvp_type(context, stream);
+		if (mall_type == SUBVP_MAIN)
+			num_subvp_main++;
+		else if (mall_type == SUBVP_PHANTOM)
+			num_subvp_phantom++;
+		else
+			num_subvp_none++;
+	}
+	if (num_subvp_main == 1 && num_subvp_phantom == 1 && num_subvp_none == 0)
+		single_display_subvp = true;
+
+	if (single_display_subvp) {
+		for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
+			pipe = &res_ctx->pipe_ctx[i];
+			if (!res_ctx->pipe_ctx[i].stream)
+				continue;
+
+			mall_type = dc_state_get_pipe_subvp_type(context, pipe);
+			if (mall_type == SUBVP_MAIN) {
+				if (resource_is_pipe_type(pipe, OTG_MASTER))
+					subvp_main_pipe_index = pipe_cnt;
+			}
+			pipe_cnt++;
+		}
+	}
+
 	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
 
 		if (!res_ctx->pipe_ctx[i].stream)
@@ -1832,19 +1870,33 @@ int dcn32_populate_dml_pipes_from_context(
 		pipes[pipe_cnt].pipe.dest.vfront_porch = timing->v_front_porch;
 		if (dc->config.enable_windowed_mpo_odm &&
 				dc->debug.enable_single_display_2to1_odm_policy) {
-			switch (resource_get_odm_slice_count(pipe)) {
-			case 2:
-				pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
-				break;
-			case 4:
-				pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_4to1;
-				break;
-			default:
-				pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
+			/* For single display subvp, if pipe is phantom pipe,
+			 *  then copy odm policy from subvp main pipe
+			 */
+			mall_type = dc_state_get_pipe_subvp_type(context, pipe);
+			if (single_display_subvp && (mall_type == SUBVP_PHANTOM)) {
+				if (subvp_main_pipe_index < 0) {
+					ASSERT(0);
+				} else {
+					pipes[pipe_cnt].pipe.dest.odm_combine_policy =
+						pipes[subvp_main_pipe_index].pipe.dest.odm_combine_policy;
+				}
+			} else {
+				switch (resource_get_odm_slice_count(pipe)) {
+				case 2:
+					pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
+					break;
+				case 4:
+					pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_4to1;
+					break;
+				default:
+					pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
+				}
 			}
 		} else {
 			pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
 		}
+
 		pipes[pipe_cnt].pipe.src.gpuvm_min_page_size_kbytes = 256; // according to spreadsheet
 		pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
 		pipes[pipe_cnt].pipe.scale_ratio_depth.lb_depth = dm_lb_19;
-- 
2.34.1


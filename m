Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 589B1C44501
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:46:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF88210F076;
	Wed, 15 Jul 2026 13:46:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sLWawEH0";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011004.outbound.protection.outlook.com [52.101.57.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC6B910F076
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:46:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PaIrvyJFc9tw0e3eQG//ZdrbGfG2Uk9Pqtf8aO36SRosqPzNJITjaGtdsb9dts0EHlVQEPcUoo6oFC2ntvUlVki46FjAc847gjUedzRf6LTkyf/jh9oodozXlWpFsq5XKWyjCVGPMw2C1JhAlzQOy5M/w4tirNGaQA5WCRJUi9FtoDgS47ySWbVv3WPtjazk/31viY4+VydmLZvzCt/Gh9IElA2Aayk0OF9vDyFGj5Q1mJvDRi3oZ/YGwG3PPWDGwDsyy27R7uB5RQtk3tWH8rKanp3k59s3c77XL4mRgUP3jBC3zmuYiDu7KIbewFqcBIGfichfz5nuPtyyy59ZeA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mj9h4ArDQ95c5y/J/zjGu9l7ZsOZw0+iNXFuXA438es=;
 b=XQXjazhryg9wqTiG1W9kYZwszO+D6znx8ma7yEOtT7k5tdGrmfPZGmwx2zXqYqlmDzgKohTJavqAPD2j6AQCLF+DQmnDf74Q11cIck3d0xnMKMV68XaKNWNBknYE1XhVRilAaTDT4vHXFAyhxWa4rhs15cUouWprFM8q9kzWvdEP3CzBiNOgmo5UFQaUvVBU94wsqnSZ+/JOXD4E994K3zyJ62H3LLfyQKM0HJ88C6rYFj1dtf7fRayRySvFLvXD8lo7W/4q5F62Q72vUnpMve5zmpBpfU1+00gb3BYDNyhRv9V7InzVO5gcqClUksdiClDWRIjMqCtGWnLQuPk8kA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mj9h4ArDQ95c5y/J/zjGu9l7ZsOZw0+iNXFuXA438es=;
 b=sLWawEH0ibtp5KXvswa1fR0ic+4bLqMeqAfkx4TL7LrVaiPYhKQTuggN5Xep2rrzpsPfv8podMLbGE9OZ6XWEWquuAwLqirmfJXd0VdzNGlAUebwRqk0GEMYx3sDbA4rNWro82oHVh+qKp+ZU/Pi5VAGUIAdrKI1roRT16ZBOMM=
Received: from SJ0PR13CA0115.namprd13.prod.outlook.com (2603:10b6:a03:2c5::30)
 by DS0PR12MB6439.namprd12.prod.outlook.com (2603:10b6:8:c9::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.202.19; Wed, 15 Jul 2026 13:45:55 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::73) by SJ0PR13CA0115.outlook.office365.com
 (2603:10b6:a03:2c5::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.4 via Frontend Transport; Wed, 15
 Jul 2026 13:45:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:45:55 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:45:39 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:45:38 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:45:35 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tomasz Siemek <tomasz.siemek@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 12/70] drm/amd/display: Refactor DPP_SET_OUTPUT_TRANSFER_FUNC
 to drop pipe_ctx
Date: Wed, 15 Jul 2026 21:37:22 +0800
Message-ID: <20260715134432.1975118-13-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|DS0PR12MB6439:EE_
X-MS-Office365-Filtering-Correlation-Id: e3872a21-eff7-417e-1957-08dee27764e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|3023799007|18002099003|22082099003|56012099006|6133799003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: /08NoPTOWginOx/EgngUc32BguiKUvaxsi6TMOePLaMA8bceIHxajqPsITlqtyZxrgWxNyEI+hABCrOtXiuzEjdFusfv8SyySguFesvshjumyCQYiX/9FKKlAEzPUd9x7Us8la3QA+lrFSuTlgVOl6310E4CXhTD7KhhCZff9BRvZBRZoT8FMQlOS83bdtlrFJzB7F9GSpFAbL+JpCnlJkeThpAolUYiVeOtv2rQfbG2HZpvbvyND4RWUCcKHFyN80NU4/klvLnjLtUAoMJyeJey+5493+tk9Yg05qrQQWLb076uI2/xikGbdbh62BQ6W6tl2d5Lu6FeVDHqkURyuIxa8TNEhFMsQPYE0U7M6izkft4mMBCJBZ83noIBo5OVTwtOFRxvvpiWsuAMODfOZDZk5HUEjgkuuk3UgzqvfflKlC+PiH9AaMKx0d/LyQHjzjn+E2Zk7TcLisJQBbrclWtOiSd376tnLUeR8ykM+jEJOgOc6VNjWgPFRUD7Xe+B6TQiqPKkNKufRVgzmaWiJ22+Okwk2GNZONWPtAgNgtUypyGm44s8/AoWFv9FNam3xEnRlF9F2aoeO0AVOZ0G2bQkIWo0XNeB4GfxQVn64iUupiByYw+JmZsZPGDupAnIBldN82Zgc7K5zdVOXkDo4+CqoT4HAOx8JevQG3uwbkaf5OEK+G3/v54SFU6Cs+piTim1jsAMZKEeRel8YWrpmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(3023799007)(18002099003)(22082099003)(56012099006)(6133799003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: LhmF8rr3m76dKUgtMU4adg3kiFHzEauNxQxkI4aZOMV2McrYFNa1jQSfaK1vfFzO8Vo2r3OsqLypatm/QsIi4J/mq8wtIgf1gGdYkfEaZ2DZ3e6r25BucZLKWx55ekQaA8lWbNEIRbgTazluml+s9jvp7puNXhk60NnGhvZI7KioruYf+Va9IHFkq/Cbf/ZZlLuKAmcS3V2Nb5TViXzdxh4N+39j37YV5+qdgMIPZJ8jqNzAI0vlyFd8wEKQNz5I5vRh5RVVSkl95TCS1LaqInC1gouLNGGkNy8h07w7sTRpDN+ZeUe9pd2r1aw+c/VA0pgBlmzM8I1oP7wgQoWFBFlAG+hqlbUjFyODDXTssu9aBHIT5v8VFEQM9qNoGUgcDsBVRzCbapXXurn7gHgTIremw7mjsnZLupYNMREY9pFomlumS3EEDRiTlVN4U+cu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:45:55.3845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3872a21-eff7-417e-1957-08dee27764e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6439
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

From: Tomasz Siemek <tomasz.siemek@amd.com>

[why]
Pipe_ctx shouldn't be passed as block sequence block parameter.

[how]
Adjust arguments for set_output_transfer_func and implementations.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Tomasz Siemek <tomasz.siemek@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 50 ++++++++++++++-----
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  9 ++--
 .../amd/display/dc/hwss/dce60/dce60_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 11 ++--
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |  3 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 20 +++++---
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.h   |  3 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   | 31 ++++++------
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |  4 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 31 ++++++------
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |  8 ++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 22 ++++----
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  4 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 11 ++--
 .../display/dc/hwss/hw_sequencer_private.h    |  6 +--
 15 files changed, 119 insertions(+), 96 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 4f30d9ac4a0d..6002175420a0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1111,10 +1111,16 @@ void hwss_build_fast_sequence(struct dc *dc,
 					(*num_steps)++;
 				}
 			}
-			if (hws->funcs.set_output_transfer_func && current_mpc_pipe->stream->update_flags.bits.out_tf) {
-				block_sequence[*num_steps].params.set_output_transfer_func_params.dc = dc;
-				block_sequence[*num_steps].params.set_output_transfer_func_params.pipe_ctx = current_mpc_pipe;
-				block_sequence[*num_steps].params.set_output_transfer_func_params.stream = current_mpc_pipe->stream;
+			if (current_mpc_pipe->stream->update_flags.bits.out_tf) {
+				struct set_output_transfer_func_params *otf_params =
+					&block_sequence[*num_steps].params.set_output_transfer_func_params;
+
+				otf_params->dpp = current_mpc_pipe->plane_res.dpp;
+				otf_params->xfm = current_mpc_pipe->plane_res.xfm;
+				otf_params->mpc = dc->res_pool->mpc;
+				otf_params->mpcc_id = current_mpc_pipe->plane_res.hubp->inst;
+				otf_params->is_top_pipe = resource_is_pipe_type(pipe_ctx, OPP_HEAD);
+				otf_params->stream = current_mpc_pipe->stream;
 				block_sequence[*num_steps].func = DPP_SET_OUTPUT_TRANSFER_FUNC;
 				(*num_steps)++;
 			}
@@ -1271,9 +1277,7 @@ void hwss_execute_sequence(struct dc *dc,
 			hwss_program_manual_trigger(params);
 			break;
 		case DPP_SET_OUTPUT_TRANSFER_FUNC:
-			hws->funcs.set_output_transfer_func(params->set_output_transfer_func_params.dc,
-					params->set_output_transfer_func_params.pipe_ctx,
-					params->set_output_transfer_func_params.stream);
+			hws->funcs.set_output_transfer_func(&params->set_output_transfer_func_params);
 			break;
 		case MPC_UPDATE_VISUAL_CONFIRM:
 			dc->hwss.update_visual_confirm_color(params->update_visual_confirm_params.dc,
@@ -1829,19 +1833,39 @@ void hwss_add_optc_program_manual_trigger(struct block_sequence_state *seq_state
  * Helper function to add DPP set output transfer function to block sequence
  */
 void hwss_add_dpp_set_output_transfer_func(struct block_sequence_state *seq_state,
-		struct dc *dc,
-		struct pipe_ctx *pipe_ctx,
-		struct dc_stream_state *stream)
+		struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].params.set_output_transfer_func_params.dc = dc;
-		seq_state->steps[*seq_state->num_steps].params.set_output_transfer_func_params.pipe_ctx = pipe_ctx;
-		seq_state->steps[*seq_state->num_steps].params.set_output_transfer_func_params.stream = stream;
+		seq_state->steps[*seq_state->num_steps].params.set_output_transfer_func_params =
+		(struct set_output_transfer_func_params) {
+			.xfm = pipe_ctx->plane_res.xfm,
+			.dpp = pipe_ctx->plane_res.dpp,
+			.mpc = dc->res_pool->mpc,
+			.mpcc_id = pipe_ctx->plane_res.hubp->inst,
+			.is_top_pipe = resource_is_pipe_type(pipe_ctx, OPP_HEAD),
+			.stream = pipe_ctx->stream,
+		};
 		seq_state->steps[*seq_state->num_steps].func = DPP_SET_OUTPUT_TRANSFER_FUNC;
 		(*seq_state->num_steps)++;
 	}
 }
 
+void hwss_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx)
+{
+	if (dc->hwseq->funcs.set_output_transfer_func) {
+		dc->hwseq->funcs.set_output_transfer_func(
+			&(struct set_output_transfer_func_params) {
+				.xfm = pipe_ctx->plane_res.xfm,
+				.dpp = pipe_ctx->plane_res.dpp,
+				.mpc = dc->res_pool->mpc,
+				.mpcc_id = pipe_ctx->plane_res.hubp->inst,
+				.is_top_pipe = resource_is_pipe_type(pipe_ctx, OPP_HEAD),
+				.stream = pipe_ctx->stream,
+			}
+		);
+	}
+}
+
 /*
  * Helper function to add MPC update visual confirm to block sequence
  */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 74b046ab3bc3..4830a0d94177 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -607,11 +607,10 @@ dce110_translate_regamma_to_hw_format(const struct dc_transfer_func *output_tf,
 }
 
 static bool
-dce110_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
-				const struct dc_stream_state *stream)
+dce110_set_output_transfer_func(struct set_output_transfer_func_params *params)
 {
-	(void)dc;
-	struct transform *xfm = pipe_ctx->plane_res.xfm;
+	struct transform *xfm = params->xfm;
+	const struct dc_stream_state *stream = params->stream;
 
 	xfm->funcs->opp_power_on_regamma_lut(xfm, true);
 	xfm->regamma_params.hw_points_num = GAMMA_HW_POINTS_NUM;
@@ -3181,7 +3180,7 @@ static void dce110_program_front_end_for_pipe(
 		hws->funcs.set_input_transfer_func(dc, pipe_ctx, pipe_ctx->plane_state);
 
 	if (pipe_ctx->plane_state->update_bits.full_update)
-		hws->funcs.set_output_transfer_func(dc, pipe_ctx, pipe_ctx->stream);
+		hwss_set_output_transfer_func(dc, pipe_ctx);
 
 	DC_LOG_SURFACE(
 			"Pipe:%d %p: addr hi:0x%x, "
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce60/dce60_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce60/dce60_hwseq.c
index 26aa303b8237..221996b348ab 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce60/dce60_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce60/dce60_hwseq.c
@@ -338,7 +338,7 @@ dce60_program_front_end_for_pipe(
 		hws->funcs.set_input_transfer_func(dc, pipe_ctx, pipe_ctx->plane_state);
 
 	if (pipe_ctx->plane_state->update_bits.full_update)
-		hws->funcs.set_output_transfer_func(dc, pipe_ctx, pipe_ctx->stream);
+		hwss_set_output_transfer_func(dc, pipe_ctx);
 
 	DC_LOG_SURFACE(
 			"Pipe:%d %p: addr hi:0x%x, "
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 8c636698d6d4..3be0bde5aea1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -2154,10 +2154,11 @@ static void log_tf(struct dc_context *ctx,
 	}
 }
 
-bool dcn10_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
-				const struct dc_stream_state *stream)
+bool dcn10_set_output_transfer_func(struct set_output_transfer_func_params *params)
 {
-	struct dpp *dpp = pipe_ctx->plane_res.dpp;
+	struct dpp *dpp = params->dpp;
+	const struct dc_stream_state *stream = params->stream;
+	struct dc *dc;
 
 	if (!stream)
 		return false;
@@ -2165,6 +2166,8 @@ bool dcn10_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 	if (dpp == NULL)
 		return false;
 
+	dc = dpp->ctx->dc;
+
 	dpp->regamma_params.hw_points_num = GAMMA_HW_POINTS_NUM;
 
 	if (stream->out_transfer_func.type == TF_TYPE_PREDEFINED &&
@@ -3301,7 +3304,7 @@ void dcn10_program_pipe(
 	 * doing heavy calculation and programming
 	 */
 	if (pipe_ctx->plane_state->update_bits.full_update)
-		hws->funcs.set_output_transfer_func(dc, pipe_ctx, pipe_ctx->stream);
+		hwss_set_output_transfer_func(dc, pipe_ctx);
 }
 
 void dcn10_wait_for_pending_cleared(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
index 162972dfdbe8..2cb674ba54e1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
@@ -73,8 +73,7 @@ void dcn10_program_output_csc(struct dc *dc,
 		enum dc_color_space colorspace,
 		uint16_t *matrix,
 		int opp_id);
-bool dcn10_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
-				const struct dc_stream_state *stream);
+bool dcn10_set_output_transfer_func(struct set_output_transfer_func_params *params);
 bool dcn10_set_input_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 			const struct dc_plane_state *plane_state);
 void dcn10_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 83794d5b838c..98778d5e114e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1019,26 +1019,30 @@ void dcn20_program_output_csc(struct dc *dc,
 	}
 }
 
-bool dcn20_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
-				const struct dc_stream_state *stream)
+bool dcn20_set_output_transfer_func(struct set_output_transfer_func_params *otf_params)
 {
-	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
-	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
+	struct dpp *dpp = otf_params->dpp;
+	struct mpc *mpc = otf_params->mpc;
+	int mpcc_id = otf_params->mpcc_id;
+	bool is_top_pipe = otf_params->is_top_pipe;
+	const struct dc_stream_state *stream = otf_params->stream;
+	struct dc *dc = dpp->ctx->dc;
 	const struct pwl_params *params = NULL;
+
 	/*
 	 * program OGAM only for the top pipe
 	 * if there is a pipe split then fix diagnostic is required:
 	 * how to pass OGAM parameter for stream.
 	 * if programming for all pipes is required then remove condition
-	 * pipe_ctx->top_pipe == NULL ,but then fix the diagnostic.
+	 * is_top_pipe ,but then fix the diagnostic.
 	 */
 	if (mpc->funcs->power_on_mpc_mem_pwr)
 		mpc->funcs->power_on_mpc_mem_pwr(mpc, mpcc_id, true);
-	if (pipe_ctx->top_pipe == NULL
+	if (is_top_pipe
 			&& mpc->funcs->set_output_gamma) {
 		if (stream->out_transfer_func.type == TF_TYPE_HWPWL)
 			params = &stream->out_transfer_func.pwl;
-		else if (pipe_ctx->stream->out_transfer_func.type ==
+		else if (stream->out_transfer_func.type ==
 			TF_TYPE_DISTRIBUTED_POINTS &&
 			cm_helper_translate_curve_to_hw_format(dc->ctx,
 			&stream->out_transfer_func,
@@ -1991,7 +1995,7 @@ static void dcn20_program_pipe(
 	if (pipe_ctx->update_flags.bits.enable ||
 	    pipe_ctx->update_flags.bits.plane_changed ||
 	    pipe_ctx->stream->update_flags.bits.out_tf)
-		hws->funcs.set_output_transfer_func(dc, pipe_ctx, pipe_ctx->stream);
+		hwss_set_output_transfer_func(dc, pipe_ctx);
 
 	/* If the pipe has been enabled or has a different opp, we
 	 * should reprogram the fmt. This deals with cases where
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
index 9d1ad3b29ca5..749348d3c793 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.h
@@ -44,8 +44,7 @@ void dcn20_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx);
 void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx);
 bool dcn20_set_input_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
 			const struct dc_plane_state *plane_state);
-bool dcn20_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
-			const struct dc_stream_state *stream);
+bool dcn20_set_output_transfer_func(struct set_output_transfer_func_params *params);
 void dcn20_program_output_csc(struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
 		enum dc_color_space colorspace,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 82a662efa49f..59184e146fc9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -256,13 +256,10 @@ bool dcn30_set_blend_lut(
 	return result;
 }
 
-static bool dcn30_set_mpc_shaper_3dlut(struct pipe_ctx *pipe_ctx,
-				       const struct dc_stream_state *stream)
+static bool dcn30_set_mpc_shaper_3dlut(struct dpp *dpp, struct mpc *mpc,
+				       int mpcc_id, const struct dc_stream_state *stream)
 {
-	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
-	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
-	struct dc *dc = pipe_ctx->stream->ctx->dc;
-	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
+	struct dc *dc = dpp->ctx->dc;
 	bool result = false;
 	uint32_t acquired_rmu = 0;
 	int mpcc_id_projected = 0;
@@ -274,8 +271,8 @@ static bool dcn30_set_mpc_shaper_3dlut(struct pipe_ctx *pipe_ctx,
 			shaper_lut = &stream->func_shaper->pwl;
 		} else if (stream->func_shaper->type == TF_TYPE_DISTRIBUTED_POINTS) {
 			cm_helper_translate_curve_to_hw_format(stream->ctx, stream->func_shaper,
-							       &dpp_base->shaper_params, true);
-			shaper_lut = &dpp_base->shaper_params;
+							       &dpp->shaper_params, true);
+			shaper_lut = &dpp->shaper_params;
 		}
 	}
 
@@ -398,23 +395,25 @@ void dcn30_program_gamut_remap(struct program_gamut_remap_params *params)
 	mpc->funcs->set_gamut_remap(mpc, mpcc_id, &mpc_adjust);
 }
 
-bool dcn30_set_output_transfer_func(struct dc *dc,
-				struct pipe_ctx *pipe_ctx,
-				const struct dc_stream_state *stream)
+bool dcn30_set_output_transfer_func(struct set_output_transfer_func_params *otf_params)
 {
-	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
-	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
+	struct dpp *dpp = otf_params->dpp;
+	struct mpc *mpc = otf_params->mpc;
+	int mpcc_id = otf_params->mpcc_id;
+	bool is_top_pipe = otf_params->is_top_pipe;
+	const struct dc_stream_state *stream = otf_params->stream;
+	struct dc *dc = dpp->ctx->dc;
 	const struct pwl_params *params = NULL;
 	bool ret = false;
 
 	/* program OGAM or 3DLUT only for the top pipe*/
-	if (pipe_ctx->top_pipe == NULL) {
+	if (is_top_pipe) {
 		/*program rmu shaper and 3dlut in MPC*/
-		ret = dcn30_set_mpc_shaper_3dlut(pipe_ctx, stream);
+		ret = dcn30_set_mpc_shaper_3dlut(dpp, mpc, mpcc_id, stream);
 		if (ret == false && mpc->funcs->set_output_gamma) {
 			if (stream->out_transfer_func.type == TF_TYPE_HWPWL)
 				params = &stream->out_transfer_func.pwl;
-			else if (pipe_ctx->stream->out_transfer_func.type ==
+			else if (stream->out_transfer_func.type ==
 					TF_TYPE_DISTRIBUTED_POINTS &&
 					cm3_helper_translate_curve_to_hw_format(stream->ctx,
 					&stream->out_transfer_func,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
index 4182cf399424..0399642076eb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
@@ -65,9 +65,7 @@ bool dcn30_set_input_transfer_func(struct dc *dc,
 
 void dcn30_program_gamut_remap(struct program_gamut_remap_params *params);
 
-bool dcn30_set_output_transfer_func(struct dc *dc,
-				struct pipe_ctx *pipe_ctx,
-				const struct dc_stream_state *stream);
+bool dcn30_set_output_transfer_func(struct set_output_transfer_func_params *params);
 void dcn30_set_avmute(struct pipe_ctx *pipe_ctx, bool enable);
 void dcn30_update_info_frame(struct pipe_ctx *pipe_ctx);
 void dcn30_program_dmdata_engine(struct pipe_ctx *pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index c2ea25927765..c5f6eb482f07 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -443,13 +443,10 @@ void dcn32_subvp_pipe_control_lock_fast(union block_sequence_params *params)
 	}
 }
 
-bool dcn32_set_mpc_shaper_3dlut(
-	struct pipe_ctx *pipe_ctx, const struct dc_stream_state *stream)
+bool dcn32_set_mpc_shaper_3dlut(struct dpp *dpp, struct mpc *mpc,
+	int mpcc_id, const struct dc_stream_state *stream)
 {
-	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
-	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
-	struct dc *dc = pipe_ctx->stream->ctx->dc;
-	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
+	struct dc *dc = dpp->ctx->dc;
 	bool result = false;
 
 	const struct pwl_params *shaper_lut = NULL;
@@ -460,8 +457,8 @@ bool dcn32_set_mpc_shaper_3dlut(
 		else if (stream->func_shaper->type == TF_TYPE_DISTRIBUTED_POINTS) {
 			cm_helper_translate_curve_to_hw_format(stream->ctx,
 					stream->func_shaper,
-					&dpp_base->shaper_params, true);
-			shaper_lut = &dpp_base->shaper_params;
+					&dpp->shaper_params, true);
+			shaper_lut = &dpp->shaper_params;
 		}
 	}
 
@@ -566,24 +563,24 @@ bool dcn32_set_input_transfer_func(struct dc *dc,
 	return result;
 }
 
-bool dcn32_set_output_transfer_func(struct dc *dc,
-				struct pipe_ctx *pipe_ctx,
-				const struct dc_stream_state *stream)
+bool dcn32_set_output_transfer_func(struct set_output_transfer_func_params *otf_params)
 {
-	(void)dc;
-	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
-	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
+	struct dpp *dpp = otf_params->dpp;
+	struct mpc *mpc = otf_params->mpc;
+	int mpcc_id = otf_params->mpcc_id;
+	bool is_top_pipe = otf_params->is_top_pipe;
+	const struct dc_stream_state *stream = otf_params->stream;
 	const struct pwl_params *params = NULL;
 	bool ret = false;
 
 	/* program OGAM or 3DLUT only for the top pipe*/
-	if (resource_is_pipe_type(pipe_ctx, OPP_HEAD)) {
+	if (is_top_pipe) {
 		/*program shaper and 3dlut in MPC*/
-		ret = dcn32_set_mpc_shaper_3dlut(pipe_ctx, stream);
+		ret = dcn32_set_mpc_shaper_3dlut(dpp, mpc, mpcc_id, stream);
 		if (ret == false && mpc->funcs->set_output_gamma) {
 			if (stream->out_transfer_func.type == TF_TYPE_HWPWL)
 				params = &stream->out_transfer_func.pwl;
-			else if (pipe_ctx->stream->out_transfer_func.type ==
+			else if (stream->out_transfer_func.type ==
 					TF_TYPE_DISTRIBUTED_POINTS &&
 					cm3_helper_translate_curve_to_hw_format(stream->ctx,
 					&stream->out_transfer_func,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
index 0303a5953673..090d94d38343 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
@@ -54,12 +54,10 @@ bool dcn32_set_input_transfer_func(struct dc *dc,
 				struct pipe_ctx *pipe_ctx,
 				const struct dc_plane_state *plane_state);
 
-bool dcn32_set_mpc_shaper_3dlut(
-	struct pipe_ctx *pipe_ctx, const struct dc_stream_state *stream);
+bool dcn32_set_mpc_shaper_3dlut(struct dpp *dpp_base, struct mpc *mpc,
+	int mpcc_id, const struct dc_stream_state *stream);
 
-bool dcn32_set_output_transfer_func(struct dc *dc,
-				struct pipe_ctx *pipe_ctx,
-				const struct dc_stream_state *stream);
+bool dcn32_set_output_transfer_func(struct set_output_transfer_func_params *params);
 
 void dcn32_init_hw(struct dc *dc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 5c1ba5d88c7a..161ef57ebce1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -696,24 +696,24 @@ bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
 	return result;
 }
 
-bool dcn401_set_output_transfer_func(struct dc *dc,
-				struct pipe_ctx *pipe_ctx,
-				const struct dc_stream_state *stream)
+bool dcn401_set_output_transfer_func(struct set_output_transfer_func_params *otf_params)
 {
-	(void)dc;
-	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
-	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
+	struct dpp *dpp = otf_params->dpp;
+	struct mpc *mpc = otf_params->mpc;
+	int mpcc_id = otf_params->mpcc_id;
+	bool is_top_pipe = otf_params->is_top_pipe;
+	const struct dc_stream_state *stream = otf_params->stream;
 	const struct pwl_params *params = NULL;
 	bool ret = false;
 
 	/* program OGAM or 3DLUT only for the top pipe*/
-	if (resource_is_pipe_type(pipe_ctx, OPP_HEAD)) {
+	if (is_top_pipe) {
 		/*program shaper and 3dlut in MPC*/
-		ret = dcn32_set_mpc_shaper_3dlut(pipe_ctx, stream);
+		ret = dcn32_set_mpc_shaper_3dlut(dpp, mpc, mpcc_id, stream);
 		if (ret == false && mpc->funcs->set_output_gamma) {
 			if (stream->out_transfer_func.type == TF_TYPE_HWPWL)
 				params = &stream->out_transfer_func.pwl;
-			else if (pipe_ctx->stream->out_transfer_func.type ==
+			else if (stream->out_transfer_func.type ==
 					TF_TYPE_DISTRIBUTED_POINTS &&
 					cm3_helper_translate_curve_to_hw_format(stream->ctx,
 					&stream->out_transfer_func,
@@ -2397,7 +2397,7 @@ void dcn401_program_pipe(
 	if (pipe_ctx->update_flags.bits.enable ||
 	    pipe_ctx->update_flags.bits.plane_changed ||
 	    pipe_ctx->stream->update_flags.bits.out_tf)
-		hws->funcs.set_output_transfer_func(dc, pipe_ctx, pipe_ctx->stream);
+		hwss_set_output_transfer_func(dc, pipe_ctx);
 
 	/* If the pipe has been enabled or has a different opp, we
 	 * should reprogram the fmt. This deals with cases where
@@ -2555,7 +2555,7 @@ void dcn401_program_pipe_sequence(
 	if (pipe_ctx->update_flags.bits.enable ||
 			pipe_ctx->update_flags.bits.plane_changed ||
 			pipe_ctx->stream->update_flags.bits.out_tf) {
-		hwss_add_dpp_set_output_transfer_func(seq_state, dc, pipe_ctx, pipe_ctx->stream);
+		hwss_add_dpp_set_output_transfer_func(seq_state, dc, pipe_ctx);
 	}
 
 	/* If the pipe has been enabled or has a different opp, we
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index 6d2e93149811..f90e25243ead 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -38,9 +38,7 @@ void dcn401_init_hw(struct dc *dc);
 
 bool dcn401_set_mcm_luts(struct pipe_ctx *pipe_ctx,
 				const struct dc_plane_state *plane_state);
-bool dcn401_set_output_transfer_func(struct dc *dc,
-				struct pipe_ctx *pipe_ctx,
-				const struct dc_stream_state *stream);
+bool dcn401_set_output_transfer_func(struct set_output_transfer_func_params *params);
 void dcn401_trigger_3dlut_dma_load(struct dc *dc,
 				struct pipe_ctx *pipe_ctx);
 void dcn401_calculate_dccg_tmds_div_value(struct pipe_ctx *pipe_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index d8398b39a119..e8bf96a7d63a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -138,8 +138,11 @@ struct program_bias_and_scale_params {
 };
 
 struct set_output_transfer_func_params {
-	struct dc *dc;
-	struct pipe_ctx *pipe_ctx;
+	struct transform *xfm;
+	struct dpp *dpp;
+	struct mpc *mpc;
+	int mpcc_id;
+	bool is_top_pipe;
 	const struct dc_stream_state *stream;
 };
 
@@ -1993,7 +1996,9 @@ void hwss_add_optc_program_manual_trigger(struct block_sequence_state *seq_state
 		struct pipe_ctx *pipe_ctx);
 
 void hwss_add_dpp_set_output_transfer_func(struct block_sequence_state *seq_state,
-		struct dc *dc, struct pipe_ctx *pipe_ctx, struct dc_stream_state *stream);
+		struct dc *dc, struct pipe_ctx *pipe_ctx);
+
+void hwss_set_output_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx);
 
 void hwss_add_mpc_update_visual_confirm(struct block_sequence_state *seq_state,
 		struct dc *dc, struct pipe_ctx *pipe_ctx, int mpcc_id);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index b4956893ae9a..31ace62a37d9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -67,6 +67,8 @@ struct dc_phy_addr_space_config;
 struct dc_virtual_addr_space_config;
 struct hubp;
 struct dpp;
+struct transform;
+struct mpc;
 struct dce_hwseq;
 struct timing_generator;
 struct tg_color;
@@ -92,9 +94,7 @@ struct hwseq_private_funcs {
 	bool (*set_input_transfer_func)(struct dc *dc,
 				struct pipe_ctx *pipe_ctx,
 				const struct dc_plane_state *plane_state);
-	bool (*set_output_transfer_func)(struct dc *dc,
-				struct pipe_ctx *pipe_ctx,
-				const struct dc_stream_state *stream);
+	bool (*set_output_transfer_func)(struct set_output_transfer_func_params *params);
 	void (*power_down)(struct dc *dc);
 	void (*enable_display_pipe_clock_gating)(struct dc_context *ctx,
 					bool clock_gating);
-- 
2.43.0


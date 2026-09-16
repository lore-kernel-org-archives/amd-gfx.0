Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63B9C88E7F
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:52:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3966810EBD9;
	Wed, 16 Sep 2026 17:52:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="TRpFUlmk";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3907410ECB9
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v81tzzBCjjuFiw7tWKupiEU0fRmLOy320Z+q0PD6ZaDn0vTtJUBk4ar8L0yYociZzJ3CbTWRvQWhweEnmbBOLk6i6WT8oX8PeLxPNCTSubhAWFXvcsoEx40c7aUQ8USereh+Fm5wXzji7raUH5M3BmzcEa8NugYAwJXNQsrNlKo+HeBldu1geswXQOOO3TIVrtxb2d1tqs29pCK1/EekgwjoXFGPeQ7yvjH33/PfvHUlrbKv5i1MJOkzBvQo/d/XAbm/24zBXZH+/PAuzlkXvu69mbRIYf9NokNvAsIurfWy8qDOQE48eaTbm8gITGYiajvFr5/EUpWsXAy0gtuQDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YRsHKg2ywqoQvV74slRC5F/K1g4vH/8NH9bFuEE7FqA=;
 b=g1MnClqwfXz8zqsog8QcQLal2bQfDxSpRK7Vpvm8CXBHPr1McBZ+KSuZkSFBKnTvqncO0wjybjo+8t/DcV3yeL8gjGld8X1jY4T3+6nwPmdCY15lTOfCc8UwgiqS8jziA6zcs/6zuxXjh/YQrbhXvsLDxL+s8gl7bFbgdffUoqKBKYEWxjCB3/eVC5lGgEp3D/GpY+XSKOVvDiGqu0ywQis3tW+3ZKd++qO5U3ed0+ieacYHhZFLDRF3ynWNnPsJGNZV8EQuGMKoi8clo0EWkOqgW+CazXz8vWokSf2ae86ai+tfKWP5SWzgreGl5i3X7I6s3iEDizrwKmAZNVMUJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YRsHKg2ywqoQvV74slRC5F/K1g4vH/8NH9bFuEE7FqA=;
 b=TRpFUlmkl0LXzaoy4WiQ6DbZZclR6rycKbezF1CtCMCIvMxC/KBNWSFplZPLv4yIKBeviQG5JOWnrD8p+yZHXW5XABgQWOa2vds3HZ7Y4eiIznCgjijk/jTQfVV+hx9P15hOkh/fPkeXeNU7Zc+llVTb4ruA9EmtA+SMgPefKNM=
Received: from CH2PR10CA0016.namprd10.prod.outlook.com (2603:10b6:610:4c::26)
 by CY1PR12MB9628.namprd12.prod.outlook.com (2603:10b6:930:105::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.11; Wed, 16 Sep
 2026 17:52:41 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::5c) by CH2PR10CA0016.outlook.office365.com
 (2603:10b6:610:4c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:52:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:52:41 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:31 -0500
From: George Zhang <george.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Piotr Maziarz <piotr.maziarz@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>, George Zhang <george.zhang@amd.com>
Subject: [PATCH 23/64] drm/amd/display: Remove phantom SW state ops from block
 sequence
Date: Wed, 16 Sep 2026 13:51:38 -0400
Message-ID: <20260916175301.368306-24-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|CY1PR12MB9628:EE_
X-MS-Office365-Filtering-Correlation-Id: e9cf75e7-781a-4ec9-21ce-08df141b4e1d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|23010399003|82310400026|56012099006|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: XBfkgBfaI3s7lAmRsC5Q5MN4+kCA8JUfTyB56bFrjC1bvQ0tWfoUDD2dxDBWAIq2JvYKllqeUsPLMgzjwQH1hQqBpL6Z7jC/QiVX7ubK5t2lssFtPirCt2kvvI5ec6kWNsi79TLb/EFjSfVQ/wY8C31cCi7oGVeWqSz9+vSCPEMJYSa9FPyVrZhtyUqkzGyUz4Kz1cWt8AzQPqFAxRyVZNepIqlsnw/vGhfiuqBK3Zrki4bRlomUt+rKJLMqtGlAnULmlX/2ACaHQ2ctWv3cbTSK3yeagA6ov+sjv+RnwJxa31OoZKZBlj8yaLU++zVrnUnjUpl+7mwrSbiQgQUEtZPUqmzyG6ztlaVaUDP5ksayL7Dfrm7r4BbHqQ9qmv2q6ZSrarSviJ2SmeAs4O3DYrwOqnlev+KhdbcOzdiq43xLZDSIOMIRtrlWOS1mQ7PwI3BSpFZ2LBwG75A+i2zo0KlpvgOOi2UOZ4HMN+2exqu1l+IX/G8O4jr3jeHldHJ8bGWlfALr1B5ANgATkSvAEOu62opGloETZYOmWdtPtOadKJZAeyXuCL7x09iGiN7yluY968puroxnYmwgSSx1ruBWZZk3tw0Jvt84QtsuY0Ur9SUbg+r1K9LPIHXmXA5/C43Tgzdo4T79gnZM1e4mSMVLIRgVFEmwKhxw55WETOck7Hu+mms1x6HtEhAAaG6AF2Z5oFWXecG6Z+1MWfG+7w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(23010399003)(82310400026)(56012099006)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jPSD714vdBk7NK33kwbSko3yeng0biHpjpRqJTozzWSsj8Lk9zU2J0Z1iK014IVmOFQMdTHXnStlXrV4oeRFYc+5pEPTAtEwoX4UlNy0H1fs9MW2KGO+17WRCJTaEKJoG+CMyo/B683QB3iV7R+3qDaOpY1IGmkazAOV53EybXcsC/Mie4UDPcKqWGsctpVeDdPE/y9paotD7C4RnczGTNppzIYsE0mK1bUYsMkPEOxTm9GZjd6Tur22/+J5GALtpnGcwGylODRUJ80u8W7ApGrZWjp5EOd6k74vgLxC8evSaVMgkKKHi/IfybN2rWjvPXYv/88Z7T8meAYjNbNbRKoN0Ybbo3swDDLwmjirINbSsbTfQRqEIygwFJKJxAMVKUi7jqIp6taYmwsvsQKYUWXOwp1CZxsHE/4vre/YtSeDZnaNkiUx/QCR28zkj+gm
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:52:41.6521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cf75e7-781a-4ec9-21ce-08df141b4e1d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9628
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

From: Piotr Maziarz <piotr.maziarz@amd.com>

[Why]
HWS_APPLY_UPDATE_FLAGS_FOR_PHANTOM and HWS_UPDATE_PHANTOM_VP_POSITION
program no hardware. They only mutate driver state: pipe update flags,
the phantom plane viewport and the phantom scaling params.

A block sequence is built first and executed later, so both ops ran only
after the builder had already inspected pipe_ctx->update_flags to decide
which steps to emit. The phantom pipe was therefore built from stale
flags.

[How]
Call apply_update_flags_for_phantom() and update_phantom_vp_position()
directly from hwss_build_post_unlock_full_sequence(), before
program_pipe_sequence(), matching the legacy
dcn401_post_unlock_program_front_end() ordering.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Piotr Maziarz <piotr.maziarz@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 46 ++-----------------
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 20 --------
 2 files changed, 5 insertions(+), 61 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index b3270f5bb56e..2c13f76d764b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1102,11 +1102,13 @@ void hwss_build_post_unlock_full_sequence(struct dc *dc,
 		if (pipe->plane_state && !pipe->top_pipe) {
 			while (pipe) {
 				if (pipe->stream && dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_PHANTOM) {
-					/* Apply update flags for phantom pipes using existing HWS functions */
+					/* Phantom SW state must be updated before the pipe sequence is built,
+					 * since the build reads the update flags and scaling params.
+					 */
 					if (dc->hwss.apply_update_flags_for_phantom)
-						hwss_add_hws_apply_update_flags_for_phantom(&seq_state, pipe);
+						dc->hwss.apply_update_flags_for_phantom(pipe);
 					if (dc->hwss.update_phantom_vp_position)
-						hwss_add_hws_update_phantom_vp_position(&seq_state, dc, context, pipe);
+						dc->hwss.update_phantom_vp_position(dc, context, pipe);
 
 					/* Program the phantom pipe - use program_pipe_sequence if available */
 					if (dc->hwseq && dc->hwseq->funcs.program_pipe_sequence)
@@ -1804,14 +1806,6 @@ void hwss_execute_sequence(struct dc *dc,
 			params->hubp_wait_pipe_read_start_params.hubp->funcs->hubp_wait_pipe_read_start(
 				params->hubp_wait_pipe_read_start_params.hubp);
 			break;
-		case HWS_APPLY_UPDATE_FLAGS_FOR_PHANTOM:
-			dc->hwss.apply_update_flags_for_phantom(params->apply_update_flags_for_phantom_params.pipe_ctx);
-			break;
-		case HWS_UPDATE_PHANTOM_VP_POSITION:
-			dc->hwss.update_phantom_vp_position(params->update_phantom_vp_position_params.dc,
-				params->update_phantom_vp_position_params.context,
-				params->update_phantom_vp_position_params.pipe_ctx);
-			break;
 		case OPTC_SET_ODM_COMBINE:
 			hwss_set_odm_combine(params);
 			break;
@@ -2590,36 +2584,6 @@ void hwss_add_hubp_wait_pipe_read_start(struct block_sequence_state *seq_state,
 	}
 }
 
-/*
- * Helper function to add HWS apply update flags for phantom to block sequence
- */
-void hwss_add_hws_apply_update_flags_for_phantom(struct block_sequence_state *seq_state,
-		struct pipe_ctx *pipe_ctx)
-{
-	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].params.apply_update_flags_for_phantom_params.pipe_ctx = pipe_ctx;
-		seq_state->steps[*seq_state->num_steps].func = HWS_APPLY_UPDATE_FLAGS_FOR_PHANTOM;
-		(*seq_state->num_steps)++;
-	}
-}
-
-/*
- * Helper function to add HWS update phantom VP position to block sequence
- */
-void hwss_add_hws_update_phantom_vp_position(struct block_sequence_state *seq_state,
-		struct dc *dc,
-		struct dc_state *context,
-		struct pipe_ctx *pipe_ctx)
-{
-	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].params.update_phantom_vp_position_params.dc = dc;
-		seq_state->steps[*seq_state->num_steps].params.update_phantom_vp_position_params.context = context;
-		seq_state->steps[*seq_state->num_steps].params.update_phantom_vp_position_params.pipe_ctx = pipe_ctx;
-		seq_state->steps[*seq_state->num_steps].func = HWS_UPDATE_PHANTOM_VP_POSITION;
-		(*seq_state->num_steps)++;
-	}
-}
-
 /*
  * Helper function to add OPTC set ODM combine to block sequence
  */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 7d4310c0ef3f..cc1c54c46e25 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -249,16 +249,6 @@ struct hubp_wait_pipe_read_start_params {
 	struct hubp *hubp;
 };
 
-struct apply_update_flags_for_phantom_params {
-	struct pipe_ctx *pipe_ctx;
-};
-
-struct update_phantom_vp_position_params {
-	struct dc *dc;
-	struct pipe_ctx *pipe_ctx;
-	struct dc_state *context;
-};
-
 struct set_odm_combine_params {
 	struct timing_generator *tg;
 	int opp_inst[MAX_PIPES];
@@ -1098,8 +1088,6 @@ union block_sequence_params {
 	struct control_cm_hist_params control_cm_hist_params;
 	struct program_cursor_update_now_params program_cursor_update_now_params;
 	struct hubp_wait_pipe_read_start_params hubp_wait_pipe_read_start_params;
-	struct apply_update_flags_for_phantom_params apply_update_flags_for_phantom_params;
-	struct update_phantom_vp_position_params update_phantom_vp_position_params;
 	struct set_odm_combine_params set_odm_combine_params;
 	struct set_odm_bypass_params set_odm_bypass_params;
 	struct opp_pipe_clock_control_params opp_pipe_clock_control_params;
@@ -1278,8 +1266,6 @@ enum block_sequence_func {
 	DPP_PROGRAM_CM_HIST,
 	PROGRAM_CURSOR_UPDATE_NOW,
 	HUBP_WAIT_PIPE_READ_START,
-	HWS_APPLY_UPDATE_FLAGS_FOR_PHANTOM,
-	HWS_UPDATE_PHANTOM_VP_POSITION,
 	OPTC_SET_ODM_COMBINE,
 	OPTC_SET_ODM_BYPASS,
 	OPP_PIPE_CLOCK_CONTROL,
@@ -2248,12 +2234,6 @@ void hwss_add_lsdma_send_pio_copy(struct block_sequence_state *seq_state,
 void hwss_add_hubp_wait_pipe_read_start(struct block_sequence_state *seq_state,
 		struct hubp *hubp);
 
-void hwss_add_hws_apply_update_flags_for_phantom(struct block_sequence_state *seq_state,
-		struct pipe_ctx *pipe_ctx);
-
-void hwss_add_hws_update_phantom_vp_position(struct block_sequence_state *seq_state,
-		struct dc *dc, struct dc_state *context, struct pipe_ctx *pipe_ctx);
-
 void hwss_add_optc_set_odm_combine(struct block_sequence_state *seq_state,
 		struct timing_generator *tg, int opp_inst[MAX_PIPES], int opp_head_count,
 		int odm_slice_width, int last_odm_slice_width);
-- 
2.55.0


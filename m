Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E28C4450A
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:45:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC74310F070;
	Wed, 15 Jul 2026 13:45:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="mw39FD+A";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010061.outbound.protection.outlook.com
 [40.93.198.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4ECA10F07A
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:45:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1H3k4nOzexiV5K258sS34kK6S3xTAb7E0+cD31oJEFer7OhW/jfIjzCUaA1Lchy0SGKzn8iO7STmqWfCxtldG/SmRWyCLE222SKcDR5OwjoPcNvuOtLoGltjNXWIFsIrF7/aaRm4CX5d+gv/uHrj7JfOLDvD+3vhkL3dq+iH0BI7LAOQuIBmf4eo4Ko6eDT+TRjp4dWXOc1b29bJBs/PJCBfFfI7ILvHS4KhXaiaYBqam4hztWVT6qivnJcYZqGDYYzhcHoDzYVlzgXnDht18EFiUQAP0vG7z3XnIGRURrfudwQUqEGMhDoFlv15KvARIUjl90UmA0XXifrNUqN+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=REoQj8vCWMKTNbnyhfBIhKqLgME4NNFyt2miTjC3A/Y=;
 b=EZi/uEmnjhx2P9f4Cw8hHHQ7YMujiaPPY4cb7GdsN9oViJ2jCJzSyUoCdjfJRCtLaVsN9QehODzMAisc+GsbC7UGXDoFOHbsc+etS0O+vsd0xbPI7sUpkCg/4UdGQzKuTFLHGgPZfElUdNgMokyIpQDvyrOLR2y/0mMPeglvZQ6epKTEL39MhjCSJqZgUrA05BRuJCcIPcxmJKpeaXZvHYjBp3clGr7BSlssONykZGaDZgfPYWoMIdvYuVUOi/F7560kw5q03ujftJcbB+X+sLU1XRNqf239TS/u/NEWRiQDQyIkQVEUtJEnLCZuUTpw0f4dLy4tRp80AmkpN/lmow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=REoQj8vCWMKTNbnyhfBIhKqLgME4NNFyt2miTjC3A/Y=;
 b=mw39FD+AeXlUP5+iv6g8bPQ00QZusvaboZMz218un/d11AKl3YlufBtJlfwmLz2d51Ej0sn9XxSlmfVTFOPFwHlHE2LrVL5h9gRmcSqOyWM1vPlssLiTbvDUMeFI8rmPsPQIGCvzi64UivLjP/la9/yUSMkh/PqM8uByOklmAjI=
Received: from SJ0PR03CA0289.namprd03.prod.outlook.com (2603:10b6:a03:39e::24)
 by CH1PR12MB9693.namprd12.prod.outlook.com (2603:10b6:610:2b0::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Wed, 15 Jul
 2026 13:45:52 +0000
Received: from SJ5PEPF000001F4.namprd05.prod.outlook.com
 (2603:10b6:a03:39e:cafe::77) by SJ0PR03CA0289.outlook.office365.com
 (2603:10b6:a03:39e::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.11 via Frontend Transport; Wed,
 15 Jul 2026 13:45:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F4.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:45:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:45:34 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:45:31 -0500
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
Subject: [PATCH 11/70] drm/amd/display: Refactor DPP_PROGRAM_GAMUT_REMAP to
 drop pipe_ctx param
Date: Wed, 15 Jul 2026 21:37:21 +0800
Message-ID: <20260715134432.1975118-12-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F4:EE_|CH1PR12MB9693:EE_
X-MS-Office365-Filtering-Correlation-Id: c253ca27-7fab-440d-57d7-08dee27762de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|23010399003|36860700016|376014|11063799006|6133799003|56012099006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PqohLiC+fxZFX7Zyq82ngwoiesihCJqeTy6lNeQTDicq/DOpATE6eYoA21uHq4xixFXQ+8ll+0Syq3XvPXvL1+fAE+cEBgsEN6emfBaEfee9dcbZuzq9Y5XPoisPSr1ELM/Q4adDGAq6SKvJZuEizSzDmCcTiYuBCMHEtOEVPDw9GwayhPmGGUMXpbcCRw4ij0dFRiruFv/8AlORMPlVHhWckrioHs+w3/i6oWutp2uDWatdae9dPJzikZB2c5YLQYbZrNdB84QAhpUiMtvLPPC345ihJFpnb3T2SWBwAA5PnNP2lyeyabRITfw8EWlOBOf0EQAfo9OPxKV27Z7KPKOHeClezjQU/O81WxTiuYzQ9/pvxkz+T6dlcBe2CGz+R8tDMlp1csVQkDBk+ynVEl7cHBhszAkiB6Lq4fX4+GGKoxZNgxOseiSBb/JlEP6ilAjkzcewYKJlYB56HUiyJa2Djb0noIJ91KJaB9s8w6JlL8X4vAYSMnFRAMzaqTJPfbzqPe313QPPB64XUEoNwJ5bLg/oTO/3/5iRLYjOBF1lywtNTyPykaVGozwHyTEHZgRXIM4r2lMHcji3zIQR+nEOmYN2YaqGgCL07H8/JYyyKQDmw3WvDYOc1XZTXfu97E3yi4VvZ0YDbyYKpV0m8TiWwT6eY0nCvcHun1WDJUthw9N4mveQe8y2VRlAKCcbR7uE5ioPXQBWOQVnsqQaxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(23010399003)(36860700016)(376014)(11063799006)(6133799003)(56012099006)(10067099003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NrAHWxtapguJ0K0/wC7U0f2yll5supLO3lEfiV1jbrYrdu89zhj0o4tG25Yz/SCmB40iZPsaXzb7dtIIN9ifdlXDaG4trUbl+IzhzYxftZixp3jnjuiTbbodH2Aq6xf5JS5VYhxTGyGMCRx7dd3sO73ymiz5vBmr7P3EI2ViyQj/19XkfPlHdwMPW4DwNr4gzlN/8m/hTwEMw/I2sj6pW1F+bXJp1oazjPh8ZOE7DVwEdbZqFdjhMIQoikj+3T9cDBC4OBh0t3KOmZOmgtkR8G2HlRGG6oIvhNh7JyRHQOdzGs/3F9LYRqy+dp1iTEYOWHiiZSSAysTzit23iHQiOXpz3lhQ85MElrM4grNVSXWvJo+WoESIL24zS5BcaCSnauqBbHRaRdGt/78qza2MwFgIygY2PpwouMe+HXKh8M1F+b64hEaxKmMlDg4Il0lP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:45:51.9645 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c253ca27-7fab-440d-57d7-08dee27762de
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9693
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
- Adjust program_gamut_remap_params struct.
- Adjust program_gamut_remap interface and implementations.
- Adjust program_gamut_remap callsites to match new signature.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Tomasz Siemek <tomasz.siemek@amd.com>
Signed-off-by: Wayne Lin <wayne.lin@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 10 ++++-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 37 +++++++++++++++----
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 11 ++++--
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 20 ++++++----
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |  2 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   | 24 +++++++-----
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.h   |  2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c | 25 +++++++------
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  2 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 12 ++++--
 11 files changed, 99 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 7b3a83ba7459..188615873791 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -831,7 +831,15 @@ bool dc_stream_set_gamut_remap(struct dc *dc, const struct dc_stream_state *stre
 	for (i = 0; i < MAX_PIPES; i++) {
 		if (dc->current_state->res_ctx.pipe_ctx[i].stream == stream) {
 			pipes = &dc->current_state->res_ctx.pipe_ctx[i];
-			dc->hwss.program_gamut_remap(pipes);
+			dc->hwss.program_gamut_remap(&(struct program_gamut_remap_params) {
+				.xfm = pipes->plane_res.xfm,
+				.dpp = pipes->plane_res.dpp,
+				.mpc = dc->res_pool->mpc,
+				.mpcc_id = pipes->plane_res.mpcc_inst,
+				.stream = pipes->stream,
+				.plane = pipes->plane_state,
+				.is_top_pipe = pipes->top_pipe == NULL,
+			});
 			ret = true;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index e47c8cf5d036..4f30d9ac4a0d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1069,7 +1069,14 @@ void hwss_build_fast_sequence(struct dc *dc,
 				if (dc->hwss.program_gamut_remap &&
 						(current_mpc_pipe->plane_state->update_bits.gamut_remap_change ||
 						 current_mpc_pipe->stream->update_flags.bits.gamut_remap)) {
-					block_sequence[*num_steps].params.program_gamut_remap_params.pipe_ctx = current_mpc_pipe;
+					struct program_gamut_remap_params *params = &block_sequence[*num_steps].params.program_gamut_remap_params;
+					params->dpp = current_mpc_pipe->plane_res.dpp;
+					params->mpc = dc->res_pool->mpc;
+					params->xfm = current_mpc_pipe->plane_res.xfm;
+					params->mpcc_id = current_mpc_pipe->plane_res.hubp->inst;
+					params->plane = current_mpc_pipe->plane_state;
+					params->stream = current_mpc_pipe->stream;
+					params->is_top_pipe = current_mpc_pipe->top_pipe == NULL;
 					block_sequence[*num_steps].func = DPP_PROGRAM_GAMUT_REMAP;
 					(*num_steps)++;
 				}
@@ -1236,7 +1243,8 @@ void hwss_execute_sequence(struct dc *dc,
 					params->set_input_transfer_func_params.plane_state);
 			break;
 		case DPP_PROGRAM_GAMUT_REMAP:
-			hwss_program_gamut_remap(params);
+			if (dc->hwss.program_gamut_remap)
+				dc->hwss.program_gamut_remap(&params->program_gamut_remap_params);
 			break;
 		case HUBP_ENABLE_3DLUT_FL:
 			hwss_hubp_enable_3dlut_fl(params);
@@ -1779,7 +1787,14 @@ void hwss_add_dpp_program_gamut_remap(struct block_sequence_state *seq_state,
 		struct pipe_ctx *pipe_ctx)
 {
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].params.program_gamut_remap_params.pipe_ctx = pipe_ctx;
+		struct program_gamut_remap_params *params = &seq_state->steps[*seq_state->num_steps].params.program_gamut_remap_params;
+		params->xfm = pipe_ctx->plane_res.xfm;
+		params->dpp = pipe_ctx->plane_res.dpp;
+		params->mpc = pipe_ctx->stream->ctx->dc->res_pool->mpc;
+		params->mpcc_id = pipe_ctx->plane_res.hubp->inst;
+		params->plane = pipe_ctx->plane_state;
+		params->stream = pipe_ctx->stream;
+		params->is_top_pipe = pipe_ctx->top_pipe == NULL;
 		seq_state->steps[*seq_state->num_steps].func = DPP_PROGRAM_GAMUT_REMAP;
 		(*seq_state->num_steps)++;
 	}
@@ -3617,12 +3632,20 @@ void hwss_set_cursor_sdr_white_level(union block_sequence_params *params)
 		dc->hwss.set_cursor_sdr_white_level(pipe_ctx);
 }
 
-void hwss_program_gamut_remap(union block_sequence_params *params)
+void hwss_program_gamut_remap(struct pipe_ctx *pipe_ctx)
 {
-	struct dc *dc = params->program_gamut_remap_params.pipe_ctx->stream->ctx->dc;
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
 
-	if (dc && dc->hwss.program_gamut_remap)
-		dc->hwss.program_gamut_remap(params->program_gamut_remap_params.pipe_ctx);
+	if (dc->hwss.program_gamut_remap)
+		dc->hwss.program_gamut_remap(&(struct program_gamut_remap_params) {
+			.xfm = pipe_ctx->plane_res.xfm,
+			.dpp = pipe_ctx->plane_res.dpp,
+			.mpc = dc->res_pool->mpc,
+			.mpcc_id = pipe_ctx->plane_res.hubp->inst,
+			.stream = pipe_ctx->stream,
+			.plane = pipe_ctx->plane_state,
+			.is_top_pipe = pipe_ctx->top_pipe == NULL,
+		});
 }
 
 void hwss_program_output_csc(union block_sequence_params *params)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index cce4f3065575..74b046ab3bc3 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -2810,23 +2810,26 @@ static void program_surface_visibility(const struct dc *dc,
 
 }
 
-static void program_gamut_remap(struct pipe_ctx *pipe_ctx)
+static void program_gamut_remap(struct program_gamut_remap_params *params)
 {
+	struct transform *xfm = params->xfm;
+	const struct dc_stream_state *stream = params->stream;
 	int i = 0;
 	struct xfm_grph_csc_adjustment adjust;
+
 	memset(&adjust, 0, sizeof(adjust));
 	adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_BYPASS;
 
 
-	if (pipe_ctx->stream->gamut_remap_matrix.enable_remap == true) {
+	if (stream->gamut_remap_matrix.enable_remap == true) {
 		adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_SW;
 
 		for (i = 0; i < CSC_TEMPERATURE_MATRIX_SIZE; i++)
 			adjust.temperature_matrix[i] =
-				pipe_ctx->stream->gamut_remap_matrix.matrix[i];
+				stream->gamut_remap_matrix.matrix[i];
 	}
 
-	pipe_ctx->plane_res.xfm->funcs->transform_set_gamut_remap(pipe_ctx->plane_res.xfm, &adjust);
+	xfm->funcs->transform_set_gamut_remap(xfm, &adjust);
 }
 static void update_plane_addr(const struct dc *dc,
 		struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index f75a1794ae2a..8c636698d6d4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -2814,28 +2814,32 @@ static void dcn10_enable_plane(
 
 }
 
-void dcn10_program_gamut_remap(struct pipe_ctx *pipe_ctx)
+void dcn10_program_gamut_remap(struct program_gamut_remap_params *params)
 {
+	struct dpp *dpp = params->dpp;
+	const struct dc_stream_state *stream = params->stream;
+	const struct dc_plane_state *plane = params->plane;
 	int i = 0;
 	struct dpp_grph_csc_adjustment adjust;
+
 	memset(&adjust, 0, sizeof(adjust));
 	adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_BYPASS;
 
 
-	if (pipe_ctx->stream->gamut_remap_matrix.enable_remap == true) {
+	if (stream->gamut_remap_matrix.enable_remap == true) {
 		adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_SW;
 		for (i = 0; i < CSC_TEMPERATURE_MATRIX_SIZE; i++)
 			adjust.temperature_matrix[i] =
-				pipe_ctx->stream->gamut_remap_matrix.matrix[i];
-	} else if (pipe_ctx->plane_state &&
-		   pipe_ctx->plane_state->gamut_remap_matrix.enable_remap == true) {
+				stream->gamut_remap_matrix.matrix[i];
+	} else if (plane &&
+		   plane->gamut_remap_matrix.enable_remap == true) {
 		adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_SW;
 		for (i = 0; i < CSC_TEMPERATURE_MATRIX_SIZE; i++)
 			adjust.temperature_matrix[i] =
-				pipe_ctx->plane_state->gamut_remap_matrix.matrix[i];
+				plane->gamut_remap_matrix.matrix[i];
 	}
 
-	pipe_ctx->plane_res.dpp->funcs->dpp_set_gamut_remap(pipe_ctx->plane_res.dpp, &adjust);
+	dpp->funcs->dpp_set_gamut_remap(dpp, &adjust);
 }
 
 
@@ -3152,7 +3156,7 @@ static void dcn10_update_dchubp_dpp(
 
 	if (plane_state->update_bits.full_update) {
 		/*gamut remap*/
-		dc->hwss.program_gamut_remap(pipe_ctx);
+		hwss_program_gamut_remap(pipe_ctx);
 
 		dc->hwss.program_output_csc(dc,
 				pipe_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
index 476095c5dd0c..162972dfdbe8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
@@ -108,7 +108,7 @@ void dcn10_program_pipe(
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
 		struct dc_state *context);
-void dcn10_program_gamut_remap(struct pipe_ctx *pipe_ctx);
+void dcn10_program_gamut_remap(struct program_gamut_remap_params *params);
 void dcn10_init_hw(struct dc *dc);
 void dcn10_init_pipes(struct dc *dc, struct dc_state *context);
 void dcn10_power_down_on_boot(struct dc *dc);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 95e5b6a6ba0f..83794d5b838c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1815,7 +1815,7 @@ void dcn20_update_dchubp_dpp(
 			|| plane_state->update_bits.gamut_remap_change
 			|| pipe_ctx->stream->update_flags.bits.out_csc) {
 		/* dpp/cm gamut remap*/
-		dc->hwss.program_gamut_remap(pipe_ctx);
+		hwss_program_gamut_remap(pipe_ctx);
 
 		/*call the dcn2 method which uses mpc csc*/
 		dc->hwss.program_output_csc(dc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index aa7707b2b25b..82a662efa49f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -357,37 +357,41 @@ bool dcn30_set_input_transfer_func(struct dc *dc,
 	return result;
 }
 
-void dcn30_program_gamut_remap(struct pipe_ctx *pipe_ctx)
+void dcn30_program_gamut_remap(struct program_gamut_remap_params *params)
 {
+	struct dpp *dpp = params->dpp;
+	struct mpc *mpc = params->mpc;
+	int mpcc_id = params->mpcc_id;
+	const struct dc_stream_state *stream = params->stream;
+	const struct dc_plane_state *plane = params->plane;
+	bool is_top_pipe = params->is_top_pipe;
 	int i = 0;
 	struct dpp_grph_csc_adjustment dpp_adjust;
 	struct mpc_grph_gamut_adjustment mpc_adjust;
-	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
-	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
 
 	memset(&dpp_adjust, 0, sizeof(dpp_adjust));
 	dpp_adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_BYPASS;
 
-	if (pipe_ctx->plane_state &&
-	    pipe_ctx->plane_state->gamut_remap_matrix.enable_remap == true) {
+	if (plane &&
+	    plane->gamut_remap_matrix.enable_remap == true) {
 		dpp_adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_SW;
 		for (i = 0; i < CSC_TEMPERATURE_MATRIX_SIZE; i++)
 			dpp_adjust.temperature_matrix[i] =
-				pipe_ctx->plane_state->gamut_remap_matrix.matrix[i];
+				plane->gamut_remap_matrix.matrix[i];
 	}
 
-	pipe_ctx->plane_res.dpp->funcs->dpp_set_gamut_remap(pipe_ctx->plane_res.dpp,
+	dpp->funcs->dpp_set_gamut_remap(dpp,
 							    &dpp_adjust);
 
 	memset(&mpc_adjust, 0, sizeof(mpc_adjust));
 	mpc_adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_BYPASS;
 
-	if (pipe_ctx->top_pipe == NULL) {
-		if (pipe_ctx->stream->gamut_remap_matrix.enable_remap == true) {
+	if (is_top_pipe) {
+		if (stream->gamut_remap_matrix.enable_remap == true) {
 			mpc_adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_SW;
 			for (i = 0; i < CSC_TEMPERATURE_MATRIX_SIZE; i++)
 				mpc_adjust.temperature_matrix[i] =
-					pipe_ctx->stream->gamut_remap_matrix.matrix[i];
+					stream->gamut_remap_matrix.matrix[i];
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
index a963d360a368..4182cf399424 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.h
@@ -63,7 +63,7 @@ bool dcn30_set_input_transfer_func(struct dc *dc,
 				struct pipe_ctx *pipe_ctx,
 				const struct dc_plane_state *plane_state);
 
-void dcn30_program_gamut_remap(struct pipe_ctx *pipe_ctx);
+void dcn30_program_gamut_remap(struct program_gamut_remap_params *params);
 
 bool dcn30_set_output_transfer_func(struct dc *dc,
 				struct pipe_ctx *pipe_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 308085d24775..5c1ba5d88c7a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -89,28 +89,31 @@ void dcn401_initialize_min_clocks(struct dc *dc)
 			true);
 }
 
-void dcn401_program_gamut_remap(struct pipe_ctx *pipe_ctx)
+void dcn401_program_gamut_remap(struct program_gamut_remap_params *params)
 {
+	struct mpc *mpc = params->mpc;
+	int mpcc_id = params->mpcc_id;
+	const struct dc_stream_state *stream = params->stream;
+	const struct dc_plane_state *plane = params->plane;
+	bool is_top_pipe = params->is_top_pipe;
 	unsigned int i = 0;
 	struct mpc_grph_gamut_adjustment mpc_adjust;
-	unsigned int mpcc_id = pipe_ctx->plane_res.mpcc_inst;
-	struct mpc *mpc = pipe_ctx->stream_res.opp->ctx->dc->res_pool->mpc;
 
 	//For now assert if location is not pre-blend
-	if (pipe_ctx->plane_state)
-		ASSERT(pipe_ctx->plane_state->mcm_location == MPCC_MOVABLE_CM_LOCATION_BEFORE);
+	if (plane)
+		ASSERT(plane->mcm_location == MPCC_MOVABLE_CM_LOCATION_BEFORE);
 
 	// program MPCC_MCM_FIRST_GAMUT_REMAP
 	memset(&mpc_adjust, 0, sizeof(mpc_adjust));
 	mpc_adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_BYPASS;
 	mpc_adjust.mpcc_gamut_remap_block_id = MPCC_MCM_FIRST_GAMUT_REMAP;
 
-	if (pipe_ctx->plane_state &&
-		pipe_ctx->plane_state->gamut_remap_matrix.enable_remap == true) {
+	if (plane &&
+		plane->gamut_remap_matrix.enable_remap == true) {
 		mpc_adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_SW;
 		for (i = 0; i < CSC_TEMPERATURE_MATRIX_SIZE; i++)
 			mpc_adjust.temperature_matrix[i] =
-			pipe_ctx->plane_state->gamut_remap_matrix.matrix[i];
+			plane->gamut_remap_matrix.matrix[i];
 	}
 
 	mpc->funcs->set_gamut_remap(mpc, mpcc_id, &mpc_adjust);
@@ -126,12 +129,12 @@ void dcn401_program_gamut_remap(struct pipe_ctx *pipe_ctx)
 	mpc_adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_BYPASS;
 	mpc_adjust.mpcc_gamut_remap_block_id = MPCC_OGAM_GAMUT_REMAP;
 
-	if (pipe_ctx->top_pipe == NULL) {
-		if (pipe_ctx->stream->gamut_remap_matrix.enable_remap == true) {
+	if (is_top_pipe) {
+		if (stream->gamut_remap_matrix.enable_remap == true) {
 			mpc_adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_SW;
 			for (i = 0; i < CSC_TEMPERATURE_MATRIX_SIZE; i++)
 				mpc_adjust.temperature_matrix[i] =
-				pipe_ctx->stream->gamut_remap_matrix.matrix[i];
+				stream->gamut_remap_matrix.matrix[i];
 		}
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index a760050eea8c..6d2e93149811 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -32,7 +32,7 @@ struct ips_ono_region_state {
 	uint32_t current_pwr_state;
 };
 
-void dcn401_program_gamut_remap(struct pipe_ctx *pipe_ctx);
+void dcn401_program_gamut_remap(struct program_gamut_remap_params *params);
 
 void dcn401_init_hw(struct dc *dc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 65df8002d3d7..d8398b39a119 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -95,7 +95,13 @@ struct set_input_transfer_func_params {
 };
 
 struct program_gamut_remap_params {
-	struct pipe_ctx *pipe_ctx;
+	struct transform *xfm;
+	struct dpp *dpp;
+	struct mpc *mpc;
+	int mpcc_id;
+	const struct dc_stream_state *stream;
+	const struct dc_plane_state *plane;
+	bool is_top_pipe;
 };
 
 struct hubp_enable_3dlut_fl_params {
@@ -1389,7 +1395,7 @@ struct hw_sequencer_funcs {
 	void (*program_cursor_offload_now)(struct dc *dc, const struct pipe_ctx *pipe);
 
 	/* Colour Related */
-	void (*program_gamut_remap)(struct pipe_ctx *pipe_ctx);
+	void (*program_gamut_remap)(struct program_gamut_remap_params *params);
 	void (*program_output_csc)(struct dc *dc, struct pipe_ctx *pipe_ctx,
 			enum dc_color_space colorspace,
 			uint16_t *matrix, int opp_id);
@@ -1940,7 +1946,7 @@ void hwss_set_cursor_position(union block_sequence_params *params);
 
 void hwss_set_cursor_sdr_white_level(union block_sequence_params *params);
 
-void hwss_program_gamut_remap(union block_sequence_params *params);
+void hwss_program_gamut_remap(struct pipe_ctx *pipe_ctx);
 
 void hwss_program_output_csc(union block_sequence_params *params);
 
-- 
2.43.0


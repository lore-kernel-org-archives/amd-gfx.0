Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 755AFC61DFD
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Sep 2026 05:04:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0493610E454;
	Wed,  2 Sep 2026 05:04:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Jw0UN7j0";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011007.outbound.protection.outlook.com [52.101.52.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B034B10E454
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Sep 2026 05:04:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zWDOpcJIemKiioEUSRkQWjGYU4gwRBgzAAmNKe4jHDqEspQFQgRSA83YiexMBZXJhTGgd1fK8UGCoY6cbEbkIWmsjgw7VNLHX7rEZ5Awxe9GV9ymwvyMugDE5Gxps3obGIqctivseEJ2FMvY8G7Wj2Y1fB5K99SdF451bGDaxiwTuNhg2gd3CH9SEQlMLh9xLOtmrLV6AyFw/EPc4bBwJjShe9nSWdPOmWEckQkfwsi1/O/MoN/P7dVHRKpR/+Q2l+6/EMaQQpVqq3FGNkSriKfJEPsjeZAyqGK5oJrwSLhFSW2jzGNDNNLuvumL9w1VMN0PUn3mN1f9wKKi/Sikvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q7R0PdmkWLWAQu2plNorOEAy+5tGyPCfl3+WAiu5ZIU=;
 b=hty2GBBlgsYeaxQDZJC2FU+dIE2Mn9vIYtTSIZw3Tu5yUcVJTXtbyenCvtg06CWHw9hiojSjAewjHnVcxvisqOxVaWzDYlZMjTRKxqC9+sdeA+T63m+Gnc6z/A87SBlzTrloyCFxnn8mierCmngPAoFSmqs6Dp70tgnqkIoiCMVGULq7F1zxz2wQdneanN6DvnKZIwQXe1iUbNaz1rlreDah3VGTFyhETuUbQa9tXT4XJpl03tcMz159grDgsIzpilceYPkTFail95mBVtJ7Pz2HajP5Lc1JaaUOD6rgkV9E4vaE7arH6e93ndOtzGfQT07v6PiHVILwB2xJqwyEBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q7R0PdmkWLWAQu2plNorOEAy+5tGyPCfl3+WAiu5ZIU=;
 b=Jw0UN7j0OrZC0AoaPp5Ay/+wuY0Xf9IJMT6JEi0cvzc3v9QFBXLY6Qeu1UDeEqqfexQNaeX1stEnachvtADFTT9FMKW4hudfdfL+ZL3fzRT4gwhkwoCxTMxqxv91mdFIR28qbuSjjoIla6Xm66dHd01DOkS3Yz0oy/KEl8Yq1v4=
Received: from CH0PR03CA0211.namprd03.prod.outlook.com (2603:10b6:610:e7::6)
 by DM4PR12MB6208.namprd12.prod.outlook.com (2603:10b6:8:a5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.8; Wed, 2 Sep 2026
 05:04:46 +0000
Received: from CH3PEPF00000010.namprd04.prod.outlook.com
 (2603:10b6:610:e7:cafe::82) by CH0PR03CA0211.outlook.office365.com
 (2603:10b6:610:e7::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.10 via Frontend Transport; Wed, 2
 Sep 2026 05:04:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000010.mail.protection.outlook.com (10.167.244.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.382.8 via Frontend Transport; Wed, 2 Sep 2026 05:04:46 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:04:43 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 2 Sep
 2026 00:04:41 -0500
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Wed, 2 Sep 2026 00:04:32 -0500
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tomasz Siemek <tomasz.siemek@amd.com>, Ilya Bakoulin
 <ilya.bakoulin@amd.com>, Ray Wu <ray.wu@amd.com>
Subject: [PATCH 02/40] drm/amd/display: Refactor DC_SEND_CURSOR_INFO_TO_DMU to
 drop pipe_ctx
Date: Wed, 2 Sep 2026 12:58:24 +0800
Message-ID: <20260902050411.3473916-3-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260902050411.3473916-1-ray.wu@amd.com>
References: <20260902050411.3473916-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000010:EE_|DM4PR12MB6208:EE_
X-MS-Office365-Filtering-Correlation-Id: 1d696184-657d-4934-091b-08df08afb52b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: lz2kofuNT4H/meb7rRE7eSX63A1dAGyDq4FIxEXMxrZli8cxdjUqbpygMTmsEtgEijX7CHo1hNoJuf7QI1TcA51IpFhUwCkuyMQ1QB5XEnId5e51TnyG7JtDtEhVeySJ1GdjVfF8yX6DGYBrTdskGtkPbSFdxinxKQEvLtY0DxENnw3w23sYL9jvatLdktYqhCnMzEtvLvcG2768Q+yMzdSl9sCv7BVJIq5bglc5Y5mZXmHvUB8Vd9o8rgwdsZlDXfFmm577tvDj+oFZT7SbITZfbVhfZqfFGG5mrUSO4w8YdmCjxWlxwNy3U/cWLvxheMzB0dXT8juTL43J/SL4ySuQMHn/HmJDvbfVNo3i8uW40xLXzvjl46k55hZGUXha1NrgZE72KcqSv4RCgJbY64CNF+gXZWFvIKjXYm8nx207kR4dCoWuP/xbvEbMrQGpPkIpWGjgj2dcqsLpUBsWCWlhvtEPweQdf3UOtnXDkv+aulLVhzb+S5zhyPcLbs0Jb0flE2tAY4fyr8vsGIWCBu9xzrEp64vAIQaqf4/C7PRNzL/hkEdbMYlLRcikchcEAANO6ZjGdQ7aNNi6wxVIbk1YRYWpeyzi0pGc1hKyN5L8Br6+ZLRkAxvDNq7nYc4LlArOLOqXD9TIlhI4WlB5HoSI4/Kr7rGSdS+xU4NcBBqXTqCo8s2C+Sfef3iGjzrrTugEVMdEU69w4RGtjklBGg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7sBTTwv4mt1iobPrm9Cz+YJ1BsEaODanW5+uPpgKJ7+t24H/WCZ7zBLROyiqWlwIrzO/0pRPHwFYBmwlC8CjNpnWIdjXLIK+J+v1RQQ9dpPTl8n/jkBZEYgZgIqPBfr0UiCXltWlyc9Ev5MdybJFECAGq14A1cwd/uICZAPUURSeOWqhnZOL2hleZf5TedBGVdV3FlKb6UTZ+XqHeyUcmPKdsa9w0aXZZIlSmpXiXd1kZckQWI1JiErERQfu9JRuQri9NKyIxD7tk7NC7XXZ0u9APH5C5tsFY/vDUYogWRXK/zZRkvvNLEL0cmBMw1UGY3S6ZktEY3k+7EmufEz1FfBRnOUvv+AOOfP3f/zkmtv7UC3lgUMDBo+ZJfHzqGodLsdJzztX2pYbimouaflxDAoJMZYKB4sbMFdQHTjEil9MIkWkfOmHB26RNEBnBQye
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:04:46.1299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d696184-657d-4934-091b-08df08afb52b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000010.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6208
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

[Why]
Pipe_ctx shouldn't be passed as block sequence parameter.

[How]
Pass needed parameters explicitly to executor.

Reviewed-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
Signed-off-by: Tomasz Siemek <tomasz.siemek@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  4 +-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 57 +++++++++++--------
 .../gpu/drm/amd/display/dc/core/dc_stream.c   | 21 +++++--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 42 +++++++-------
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  7 ++-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    | 11 ++--
 6 files changed, 87 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ebbd81995c38..5b9cf0bb10a3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3956,7 +3956,7 @@ static void program_cursor_attributes_sequence(
 
 		hwss_add_set_cursor_attribute(seq_state, dc, tmp_pipe);
 		if (dc->ctx->dmub_srv)
-			hwss_add_send_update_cursor_info_to_dmu(seq_state, tmp_pipe, k);
+			hwss_add_send_update_cursor_info_to_dmu(seq_state, tmp_pipe);
 		hwss_add_set_cursor_sdr_white_level(seq_state, tmp_pipe);
 		if (enable_cursor_offload && dc->hwss.update_cursor_offload_pipe)
 			hwss_add_update_cursor_offload_pipe(seq_state, dc, tmp_pipe);
@@ -4007,7 +4007,7 @@ static void program_cursor_position_sequence(
 			hwss_add_update_cursor_offload_pipe(seq_state, dc, tmp_pipe);
 
 		if (dc->ctx->dmub_srv)
-			hwss_add_send_update_cursor_info_to_dmu(seq_state, tmp_pipe, k);
+			hwss_add_send_update_cursor_info_to_dmu(seq_state, tmp_pipe);
 	}
 
 	if (pipe_to_program) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 0e2c85b28e7c..de1772f75293 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1356,14 +1356,10 @@ void hwss_build_fast_sequence(struct dc *dc,
 			block_sequence[*num_steps].func = DPP_SET_CURSOR_ATTRIBUTES;
 			(*num_steps)++;
 
-			if (dc->ctx->dmub_srv) {
-				block_sequence[*num_steps].params.send_cursor_info_to_dmu_params.pipe_ctx =
-					current_pipe;
-				block_sequence[*num_steps].params.send_cursor_info_to_dmu_params.pipe_idx =
-					current_pipe->pipe_idx;
-				block_sequence[*num_steps].func = DC_SEND_CURSOR_INFO_TO_DMU;
-				(*num_steps)++;
-			}
+			if (dc->ctx->dmub_srv)
+				hwss_add_send_update_cursor_info_to_dmu(
+					&(struct block_sequence_state){ block_sequence, num_steps },
+					current_pipe);
 
 			hwss_add_set_cursor_sdr_white_level(&seq_state, current_pipe);
 
@@ -1448,14 +1444,10 @@ void hwss_build_fast_sequence(struct dc *dc,
 				(*num_steps)++;
 			}
 
-			if (dc->ctx->dmub_srv) {
-				block_sequence[*num_steps].params.send_cursor_info_to_dmu_params.pipe_ctx =
-					current_pipe;
-				block_sequence[*num_steps].params.send_cursor_info_to_dmu_params.pipe_idx =
-					current_pipe->pipe_idx;
-				block_sequence[*num_steps].func = DC_SEND_CURSOR_INFO_TO_DMU;
-				(*num_steps)++;
-			}
+			if (dc->ctx->dmub_srv)
+				hwss_add_send_update_cursor_info_to_dmu(
+					&(struct block_sequence_state){ block_sequence, num_steps },
+					current_pipe);
 		}
 
 		/* Unlock cursor position after all pipes have been programmed */
@@ -4363,10 +4355,13 @@ void hwss_update_cursor_offload_pipe(union block_sequence_params *params)
 
 void hwss_send_cursor_info_to_dmu(union block_sequence_params *params)
 {
-	struct pipe_ctx *pipe_ctx = params->send_cursor_info_to_dmu_params.pipe_ctx;
-	int pipe_idx = params->send_cursor_info_to_dmu_params.pipe_idx;
-
-	dc_send_update_cursor_info_to_dmu(pipe_ctx, (uint8_t)pipe_idx);
+	dc_send_update_cursor_info_to_dmu(
+		params->send_cursor_info_to_dmu_params.ctx,
+		params->send_cursor_info_to_dmu_params.pipe_idx,
+		params->send_cursor_info_to_dmu_params.hubp,
+		params->send_cursor_info_to_dmu_params.dpp,
+		params->send_cursor_info_to_dmu_params.otg_inst,
+		params->send_cursor_info_to_dmu_params.panel_inst);
 }
 
 void hwss_set_cursor_attribute(union block_sequence_params *params)
@@ -5914,13 +5909,27 @@ void hwss_add_cursor_lock(struct block_sequence_state *seq_state,
 }
 
 void hwss_add_send_update_cursor_info_to_dmu(struct block_sequence_state *seq_state,
-		struct pipe_ctx *pipe_ctx,
-		int index)
+		struct pipe_ctx *pipe_ctx)
 {
+	unsigned int panel_inst = 0;
+
+	if (!dc_dmub_should_update_cursor_data(pipe_ctx))
+		return;
+
+	dc_get_edp_link_panel_inst(pipe_ctx->stream->ctx->dc,
+			pipe_ctx->stream->link, &panel_inst);
+
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		struct send_cursor_info_to_dmu_params *p =
+			&seq_state->steps[*seq_state->num_steps].params.send_cursor_info_to_dmu_params;
+
 		seq_state->steps[*seq_state->num_steps].func = DC_SEND_CURSOR_INFO_TO_DMU;
-		seq_state->steps[*seq_state->num_steps].params.send_cursor_info_to_dmu_params.pipe_ctx = pipe_ctx;
-		seq_state->steps[*seq_state->num_steps].params.send_cursor_info_to_dmu_params.pipe_idx = index;
+		p->ctx = pipe_ctx->stream->ctx;
+		p->pipe_idx = pipe_ctx->pipe_idx;
+		p->hubp = pipe_ctx->plane_res.hubp;
+		p->dpp = pipe_ctx->plane_res.dpp;
+		p->otg_inst = (uint8_t)pipe_ctx->stream_res.tg->inst;
+		p->panel_inst = (uint8_t)panel_inst;
 		(*seq_state->num_steps)++;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 9f3068e899e1..35d4d0d5ae34 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -284,6 +284,21 @@ struct dc_link *dc_stream_get_link(
 	return stream->link;
 }
 
+static void update_cursor_info_to_dmu(struct dc *dc, struct pipe_ctx *pipe_ctx)
+{
+	unsigned int panel_inst;
+
+	if (!dc->ctx->dmub_srv || !dc_dmub_should_update_cursor_data(pipe_ctx))
+		return;
+
+	if (!dc_get_edp_link_panel_inst(dc, pipe_ctx->stream->link, &panel_inst))
+		panel_inst = 0;
+
+	dc_send_update_cursor_info_to_dmu(pipe_ctx->stream->ctx, pipe_ctx->pipe_idx,
+			pipe_ctx->plane_res.hubp, pipe_ctx->plane_res.dpp,
+			(uint8_t)pipe_ctx->stream_res.tg->inst, (uint8_t)panel_inst);
+}
+
 void program_cursor_attributes(
 	struct dc *dc,
 	struct dc_stream_state *stream)
@@ -317,8 +332,7 @@ void program_cursor_attributes(
 		}
 
 		dc->hwss.set_cursor_attribute(pipe_ctx);
-		if (dc->ctx->dmub_srv)
-			dc_send_update_cursor_info_to_dmu(pipe_ctx, i);
+		update_cursor_info_to_dmu(dc, pipe_ctx);
 		if (dc->hwss.set_cursor_sdr_white_level)
 			dc->hwss.set_cursor_sdr_white_level(pipe_ctx);
 		if (enable_cursor_offload && dc->hwss.update_cursor_offload_pipe)
@@ -480,8 +494,7 @@ void program_cursor_position(
 		if (enable_cursor_offload && dc->hwss.update_cursor_offload_pipe)
 			dc->hwss.update_cursor_offload_pipe(dc, pipe_ctx);
 
-		if (dc->ctx->dmub_srv)
-			dc_send_update_cursor_info_to_dmu(pipe_ctx, i);
+		update_cursor_info_to_dmu(dc, pipe_ctx);
 	}
 
 	if (pipe_to_program) {
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 4723e0974647..143facdbde54 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -1016,7 +1016,7 @@ void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv)
 	DC_LOG_DEBUG("    is_pwait           : %d", dc_dmub_srv->dmub->debug.is_pwait);
 }
 
-static bool dc_dmub_should_update_cursor_data(struct pipe_ctx *pipe_ctx)
+bool dc_dmub_should_update_cursor_data(struct pipe_ctx *pipe_ctx)
 {
 	if (pipe_ctx->plane_state != NULL) {
 		if (pipe_ctx->plane_state->address.type == PLN_ADDR_TYPE_VIDEO_PROGRESSIVE ||
@@ -1036,20 +1036,16 @@ static bool dc_dmub_should_update_cursor_data(struct pipe_ctx *pipe_ctx)
 }
 
 static void dc_build_cursor_update_payload0(
-		struct pipe_ctx *pipe_ctx, uint8_t p_idx,
+		const struct dc_context *ctx, uint8_t p_idx,
+		struct hubp *hubp, uint8_t otg_inst, uint8_t panel_inst,
 		struct dmub_cmd_update_cursor_payload0 *payload)
 {
-	struct dc *dc = pipe_ctx->stream->ctx->dc;
-	struct hubp *hubp = pipe_ctx->plane_res.hubp;
-	unsigned int panel_inst = 0;
+	struct dc *dc = ctx->dc;
 
 	if (dc->config.frame_update_cmd_version2 == true) {
 		/* Don't need panel_inst for command version2 */
 		payload->cmd_version = DMUB_CMD_CURSOR_UPDATE_VERSION_2;
 	} else {
-		if (!dc_get_edp_link_panel_inst(hubp->ctx->dc,
-			pipe_ctx->stream->link, &panel_inst))
-			return;
 		payload->cmd_version = DMUB_CMD_CURSOR_UPDATE_VERSION_1;
 	}
 
@@ -1064,8 +1060,8 @@ static void dc_build_cursor_update_payload0(
 
 	payload->enable      = (uint8_t)hubp->pos.cur_ctl.bits.cur_enable;
 	payload->pipe_idx    = p_idx;
-	payload->panel_inst  = (uint8_t)panel_inst;
-	payload->otg_inst    = (uint8_t)pipe_ctx->stream_res.tg->inst;
+	payload->panel_inst  = panel_inst;
+	payload->otg_inst    = otg_inst;
 }
 
 static void dc_build_cursor_position_update_payload0(
@@ -1102,14 +1098,21 @@ static void dc_build_cursor_attribute_update_payload1(
 /**
  * dc_send_update_cursor_info_to_dmu - Populate the DMCUB Cursor update info command
  *
- * @pCtx: [in] pipe context
+ * @ctx: [in] dc context
  * @pipe_idx: [in] pipe index
+ * @hubp: [in] hubp resource providing cursor position/attribute caches
+ * @dpp: [in] dpp resource providing cursor position/attribute caches
+ * @otg_inst: [in] OTG instance driving the pipe
+ * @panel_inst: [in] eDP panel instance (command version 1 only)
  *
  * This function would store the cursor related information and pass it into
- * dmub
+ * dmub. The caller is responsible for gating with
+ * dc_dmub_should_update_cursor_data().
  */
 void dc_send_update_cursor_info_to_dmu(
-		struct pipe_ctx *pCtx, uint8_t pipe_idx)
+		const struct dc_context *ctx, uint8_t pipe_idx,
+		struct hubp *hubp, struct dpp *dpp,
+		uint8_t otg_inst, uint8_t panel_inst)
 {
 	union dmub_rb_cmd cmd[2];
 	union dmub_cmd_update_cursor_info_data *update_cursor_info_0 =
@@ -1117,8 +1120,6 @@ void dc_send_update_cursor_info_to_dmu(
 
 	memset(cmd, 0, sizeof(cmd));
 
-	if (!dc_dmub_should_update_cursor_data(pCtx))
-		return;
 	/*
 	 * Since we use multi_cmd_pending for dmub command, the 2nd command is
 	 * only assigned to store cursor attributes info.
@@ -1138,11 +1139,12 @@ void dc_send_update_cursor_info_to_dmu(
 		cmd[0].update_cursor_info.header.multi_cmd_pending = 1; //To combine multi dmu cmd, 1st cmd
 
 		/* Prepare Payload */
-		dc_build_cursor_update_payload0(pCtx, pipe_idx, &update_cursor_info_0->payload0);
+		dc_build_cursor_update_payload0(ctx, pipe_idx, hubp, otg_inst, panel_inst,
+				&update_cursor_info_0->payload0);
 
 		dc_build_cursor_position_update_payload0(&update_cursor_info_0->payload0, pipe_idx,
-				pCtx->plane_res.hubp, pCtx->plane_res.dpp);
-		}
+				hubp, dpp);
+	}
 	{
 		/* Build Payload#1 Header */
 		cmd[1].update_cursor_info.header.type = DMUB_CMD__UPDATE_CURSOR_INFO;
@@ -1151,10 +1153,10 @@ void dc_send_update_cursor_info_to_dmu(
 
 		dc_build_cursor_attribute_update_payload1(
 				&cmd[1].update_cursor_info.update_cursor_info_data.payload1.attribute_cfg,
-				pipe_idx, pCtx->plane_res.hubp, pCtx->plane_res.dpp);
+				pipe_idx, hubp, dpp);
 
 		/* Combine 2nd cmds update_curosr_info to DMU */
-		dc_wake_and_execute_dmub_cmd_list(pCtx->stream->ctx, 2, cmd, DM_DMUB_WAIT_TYPE_WAIT);
+		dc_wake_and_execute_dmub_cmd_list(ctx, 2, cmd, DM_DMUB_WAIT_TYPE_WAIT);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index ab026847e38b..5737c78853fc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -31,7 +31,10 @@
 
 struct dmub_srv;
 struct dc;
+struct dc_context;
 struct pipe_ctx;
+struct hubp;
+struct dpp;
 struct dc_crtc_timing_adjust;
 struct dc_crtc_timing;
 struct dc_state;
@@ -91,7 +94,9 @@ bool dc_dmub_srv_get_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv);
 void dc_dmub_setup_subvp_dmub_command(struct dc *dc, struct dc_state *context, bool enable);
 void dc_dmub_srv_log_diagnostic_data(struct dc_dmub_srv *dc_dmub_srv);
 
-void dc_send_update_cursor_info_to_dmu(struct pipe_ctx *pCtx, uint8_t pipe_idx);
+bool dc_dmub_should_update_cursor_data(struct pipe_ctx *pipe_ctx);
+void dc_send_update_cursor_info_to_dmu(const struct dc_context *ctx, uint8_t pipe_idx,
+		struct hubp *hubp, struct dpp *dpp, uint8_t otg_inst, uint8_t panel_inst);
 bool dc_dmub_check_min_version(struct dmub_srv *srv);
 
 void dc_dmub_srv_enable_dpia_trace(const struct dc *dc);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index e7ab30e041d5..3f9eda74fb1b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -847,8 +847,12 @@ struct setup_periodic_interrupt_params {
 };
 
 struct send_cursor_info_to_dmu_params {
-	struct pipe_ctx *pipe_ctx;
-	int pipe_idx;
+	const struct dc_context *ctx;
+	uint8_t pipe_idx;
+	struct hubp *hubp;
+	struct dpp *dpp;
+	uint8_t otg_inst;
+	uint8_t panel_inst;
 };
 
 struct set_cursor_attribute_params {
@@ -2663,8 +2667,7 @@ void hwss_add_cursor_lock(struct block_sequence_state *seq_state,
 		bool lock);
 
 void hwss_add_send_update_cursor_info_to_dmu(struct block_sequence_state *seq_state,
-		struct pipe_ctx *pipe_ctx,
-		int index);
+		struct pipe_ctx *pipe_ctx);
 
 void hwss_add_update_cursor_offload_pipe(struct block_sequence_state *seq_state,
 		struct dc *dc,
-- 
2.43.0


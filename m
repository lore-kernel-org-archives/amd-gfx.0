Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D4C5C79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:34:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC9B010EB07;
	Tue,  8 Sep 2026 11:34:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MFdYdLHr";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012040.outbound.protection.outlook.com
 [40.107.200.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 431EF10EB07
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:34:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ue3wpNDWuhMk5ayFbBQTQ/7l5Kwh/HdcKWh3iBTZFj6zFTXOLAerVyNSzJ3pVDv48QAsHbo03KjT42UXGGIEQ0+PPLbWWpHbkO6xqvWYm8NIHwxYOkyeXCbsDRjZYLCNFbP16rXVqHAEzeFSu65Vyw9esOy44q+6ObNY4GdPoNzTAsGaiMXDxB9fWCFME6XzfZrLVpWosaCBSH01b5PTsV2GmVcgXEE1mhq5RaFzkRxWH2Kh8kMecEzQVUm69BS24ZKSS32GFEzxd6oDI+8l0kbCQVipszw+6i2r80j5wHhQNa+VhjanbDg+aJccKchaI6GRkVOhm+YidU4t/cz1pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICN5oW6E+ZlT0g5Etl/DRJwg9JSNkNCEmX2dxZuQ44M=;
 b=f+iPjXBRI81ZZOOKblxNqAVOUwLaf6GGU0H74OtEDCL4BIBhZ/f8t6rYhsn9/NWhliHaopzsEv5FdKhSbb6c3rDEisnEjTqcJBMqX+aWcu+l++CRK/zfx1AOpBW430Ruq8E3Wce7ryXvQoJDAJ9wp1kuFVEPdkZS1/VA27lLJrP7hvB0UUv7si2ZeO36ABYp70rG5bDPvUU6KN7PS8TsI4cLJCKSOlDj9Dv9b0Lj6Q6e7nB5kiZqcGMqfDrwsV7tYOTrNP4mN6engTkfYtgqYwgNo4gNGxvwteFRtEeup+9S9XtY5dVbV51tnux/qio7UrSSAoESoitOkrlq4VuKBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ICN5oW6E+ZlT0g5Etl/DRJwg9JSNkNCEmX2dxZuQ44M=;
 b=MFdYdLHrCNFICcGO8pkt4yOfhJEpwEs41d7Yc+mkv3YLobXKp+8puakClycK0Jio7mjv0oD47iZu7ZY/5DHc6hqWHh5TuPus+xvfCJDveWblgw4PWnbzY83yS/GRpVyc9j/52d/Zfvc+UJnVY4PuzW9JYcVo9fzghnReAG4tmr0=
Received: from DS7P222CA0009.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::11) by
 IA0PPFD4454CAA9.namprd12.prod.outlook.com (2603:10b6:20f:fc04::be5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.6; Tue, 8 Sep 2026
 11:34:02 +0000
Received: from DS1PEPF0001708F.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::77) by DS7P222CA0009.outlook.office365.com
 (2603:10b6:8:2e::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.382.15 via Frontend Transport; Tue, 8
 Sep 2026 11:34:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF0001708F.mail.protection.outlook.com (10.167.17.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:34:01 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:33:53 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:33:44 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Tomasz Siemek <tomasz.siemek@amd.com>, Ilya Bakoulin
 <ilya.bakoulin@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 01/66] drm/amd/display: Decouple cursor offload hwss executors
 from pipe context
Date: Tue, 8 Sep 2026 19:30:54 +0800
Message-ID: <20260908113338.2433445-2-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708F:EE_|IA0PPFD4454CAA9:EE_
X-MS-Office365-Filtering-Correlation-Id: 946f44fd-1b75-40ae-a452-08df0d9d149f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|10067099003|6133799003|3023799007|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Fc6BcIng76aowhZrJiv+lmcIXHFnNv+AdhLH8xSA9SAopCQqumfa/XfM5I+veXtjGy+WxRd5Dh91JQ1Rt/A4m9W/nnUfQ9CiJhDX5Y4k7Jta601QJQ/UyMKl9XnxR15D/NjLfz6mR4ZaZ0jNHjrMNEOioqqslh8dzfbl3wSG/Cdi7xoqEFm7oikFv8E/SbR5D+Xr1C8FP2P+tFMWUyq03M/mymLoHY27nZBadxXJLksHORDKI3AcwrTwMB7gXlyJFWGlai2VHr8/aYKvgPe/yYf5fK1von0jPSLXi4qJdqiUcqQpj2xsnbcOlanO7+Sg91YmiTd8Aqxk6/DhBZxlQAov6ibScDx7DdCxDCLhmibWP9tz9ohMbyu5Scn3xMR+R3DwZo9PaQBwImYZktXtce7L3BsKEFys66WwSEYOiEuoqlOlmhBfn/FY2m3HDAuOR17x/XyR/lQvSmPDJTt1JSn3hjps8Asjs5SV0r3Aen7zP6OZMSx+3ebUa1Q8B3tFLvvbXber0Y5CvgKg3dNniERtIy5EJ03NUKejQ+xNA8RlH16mTS5tlFaP9EeurE1UdrfAv1qPRSk2IxWwYqJ696B2bTBPBlXNj/vGlv3IjMC8fDwJQz58VFTa0B6r7pilO40k7o6Km5HVNQW2LZPkn109qDvGJEJSWFzaBjEN6RY5SD36ruh/b04JdJ1d/HoCnKH2dbNkrMzY/ZYI9agVIw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(10067099003)(6133799003)(3023799007)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 0Kcg0gwRG273r0yTBm5D7wZcJfEZjgGQAuSAJkSaRpjZBk9IZxxd/q8iFOLcnzD7BmBqsA+HTCuR2NMLwWO2h+KcQShlXkMwojCJrp8voJH2V5Ao5nol9Nxmp/K9zJqNMtzTbVqprgP97iGlCSwLxtD0cGKnD8exy33/QBNWJhP3FK5QccwZbZBhWTpHRL0xeq3RIB2TpMmLFmISdVa8oC5sm8zCBtVx5wjd+RvhXtl04SEXxBGPR020P+X3X8gMo8YTJ6/BeSCPGmiE9M1iaS7EPH2V1gjezaUGezu247xfIQT4t/iBcLAzlcjuD1i5Vkg8aR5uuc/kDzWi303T+i2mVYqbthcnLsXo3aDbVj7XQxVRnu8OceP/k28pVAFPDNn4KI7cdTNd81I/giBzsOw3aQcbKItgUJolhhgIHkDYeWciNvVwW8lTUsn1P2Q6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:34:01.6530 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 946f44fd-1b75-40ae-a452-08df0d9d149f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD4454CAA9
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
Hwss executors shouldn't be coupled to complex dc structs such as
pipe_ctx.

[How]
Refactor cursor offload hardware sequencer extension to accept only
the parameters required for programming cursor offload state.
Extract these parameters in the generic HWSS layer for both immediate execution
and block-sequence construction.

Reviewed-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
Signed-off-by: Tomasz Siemek <tomasz.siemek@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 211 ++++++++++--------
 .../gpu/drm/amd/display/dc/core/dc_stream.c   |  58 ++++-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  10 +-
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   |  10 +-
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  67 +++---
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  10 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  18 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   3 +-
 .../amd/display/dc/hwss/dcn50/dcn50_hwseq.c   |  10 +-
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.c   |  18 +-
 .../amd/display/dc/hwss/dcn60/dcn60_hwseq.h   |   3 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  56 +++--
 12 files changed, 274 insertions(+), 200 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index b54466e4f42b..4b8af67ff4b5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1319,11 +1319,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 				cursor_pipe_to_program = current_pipe;
 
 				if (enable_cursor_offload && dc->hwss.begin_cursor_offload_update) {
-					block_sequence[*num_steps].params.begin_cursor_offload_update_params.dc = dc;
-					block_sequence[*num_steps].params.begin_cursor_offload_update_params.pipe_ctx =
-						current_pipe;
-					block_sequence[*num_steps].func = HWSS_BEGIN_CURSOR_OFFLOAD_UPDATE;
-					(*num_steps)++;
+					hwss_add_begin_cursor_offload_update(&seq_state, dc, current_pipe);
 				} else {
 					block_sequence[*num_steps].params.cursor_lock_params.dc = dc;
 					block_sequence[*num_steps].params.cursor_lock_params.pipe_ctx = current_pipe;
@@ -1364,22 +1360,14 @@ void hwss_build_fast_sequence(struct dc *dc,
 			hwss_add_set_cursor_sdr_white_level(&seq_state, current_pipe);
 
 			if (enable_cursor_offload && dc->hwss.update_cursor_offload_pipe) {
-				block_sequence[*num_steps].params.update_cursor_offload_pipe_params.dc = dc;
-				block_sequence[*num_steps].params.update_cursor_offload_pipe_params.pipe_ctx =
-					current_pipe;
-				block_sequence[*num_steps].func = HWSS_UPDATE_CURSOR_OFFLOAD_PIPE;
-				(*num_steps)++;
+				hwss_add_update_cursor_offload_pipe(&seq_state, dc, current_pipe);
 			}
 		}
 
 		/* Unlock cursor attributes after all pipes have been programmed */
 		if (cursor_pipe_to_program) {
 			if (enable_cursor_offload && dc->hwss.commit_cursor_offload_update) {
-				block_sequence[*num_steps].params.commit_cursor_offload_update_params.dc = dc;
-				block_sequence[*num_steps].params.commit_cursor_offload_update_params.pipe_ctx =
-					cursor_pipe_to_program;
-				block_sequence[*num_steps].func = HWSS_COMMIT_CURSOR_OFFLOAD_UPDATE;
-				(*num_steps)++;
+				hwss_add_commit_cursor_offload_update(&seq_state, dc, cursor_pipe_to_program);
 			} else {
 				block_sequence[*num_steps].params.cursor_lock_params.dc = dc;
 				block_sequence[*num_steps].params.cursor_lock_params.pipe_ctx = cursor_pipe_to_program;
@@ -1417,11 +1405,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 				cursor_pipe_to_program = current_pipe;
 
 				if (enable_cursor_offload && dc->hwss.begin_cursor_offload_update) {
-					block_sequence[*num_steps].params.begin_cursor_offload_update_params.dc = dc;
-					block_sequence[*num_steps].params.begin_cursor_offload_update_params.pipe_ctx =
-						current_pipe;
-					block_sequence[*num_steps].func = HWSS_BEGIN_CURSOR_OFFLOAD_UPDATE;
-					(*num_steps)++;
+					hwss_add_begin_cursor_offload_update(&seq_state, dc, current_pipe);
 				} else {
 					block_sequence[*num_steps].params.cursor_lock_params.dc = dc;
 					block_sequence[*num_steps].params.cursor_lock_params.pipe_ctx = current_pipe;
@@ -1437,11 +1421,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 			(*num_steps)++;
 
 			if (enable_cursor_offload && dc->hwss.update_cursor_offload_pipe) {
-				block_sequence[*num_steps].params.update_cursor_offload_pipe_params.dc = dc;
-				block_sequence[*num_steps].params.update_cursor_offload_pipe_params.pipe_ctx =
-					current_pipe;
-				block_sequence[*num_steps].func = HWSS_UPDATE_CURSOR_OFFLOAD_PIPE;
-				(*num_steps)++;
+				hwss_add_update_cursor_offload_pipe(&seq_state, dc, current_pipe);
 			}
 
 			if (dc->ctx->dmub_srv)
@@ -1453,11 +1433,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 		/* Unlock cursor position after all pipes have been programmed */
 		if (cursor_pipe_to_program) {
 			if (enable_cursor_offload && dc->hwss.commit_cursor_offload_update) {
-				block_sequence[*num_steps].params.commit_cursor_offload_update_params.dc = dc;
-				block_sequence[*num_steps].params.commit_cursor_offload_update_params.pipe_ctx =
-					cursor_pipe_to_program;
-				block_sequence[*num_steps].func = HWSS_COMMIT_CURSOR_OFFLOAD_UPDATE;
-				(*num_steps)++;
+				hwss_add_commit_cursor_offload_update(&seq_state, dc, cursor_pipe_to_program);
 			} else {
 				block_sequence[*num_steps].params.cursor_lock_params.dc = dc;
 				block_sequence[*num_steps].params.cursor_lock_params.pipe_ctx = cursor_pipe_to_program;
@@ -2127,20 +2103,20 @@ void hwss_execute_sequence(struct dc *dc,
 		case HUBP_MEM_PROGRAM_VIEWPORT:
 			hwss_hubp_mem_program_viewport(params);
 			break;
-		case ABORT_CURSOR_OFFLOAD_UPDATE:
-			hwss_abort_cursor_offload_update(params);
-			break;
 		case HWSS_CURSOR_LOCK:
 			hwss_cursor_lock(params);
 			break;
 		case HWSS_BEGIN_CURSOR_OFFLOAD_UPDATE:
-			hwss_begin_cursor_offload_update(params);
+			hwss_begin_cursor_offload_update(dc, params);
 			break;
 		case HWSS_COMMIT_CURSOR_OFFLOAD_UPDATE:
-			hwss_commit_cursor_offload_update(params);
+			hwss_commit_cursor_offload_update(dc, params);
 			break;
 		case HWSS_UPDATE_CURSOR_OFFLOAD_PIPE:
-			hwss_update_cursor_offload_pipe(params);
+			hwss_update_cursor_offload_pipe(dc, params);
+			break;
+		case ABORT_CURSOR_OFFLOAD_UPDATE:
+			hwss_abort_cursor_offload_update(dc, params);
 			break;
 		case DC_SEND_CURSOR_INFO_TO_DMU:
 			hwss_send_cursor_info_to_dmu(params);
@@ -4321,15 +4297,6 @@ void hwss_hubp_mem_program_viewport(union block_sequence_params *params)
 		hubp->funcs->mem_program_viewport(hubp, viewport, viewport_c);
 }
 
-void hwss_abort_cursor_offload_update(union block_sequence_params *params)
-{
-	struct dc *dc = params->abort_cursor_offload_update_params.dc;
-	struct pipe_ctx *pipe_ctx = params->abort_cursor_offload_update_params.pipe_ctx;
-
-	if (dc && dc->hwss.abort_cursor_offload_update)
-		dc->hwss.abort_cursor_offload_update(dc, pipe_ctx);
-}
-
 void hwss_cursor_lock(union block_sequence_params *params)
 {
 	struct dc *dc = params->cursor_lock_params.dc;
@@ -4340,31 +4307,45 @@ void hwss_cursor_lock(union block_sequence_params *params)
 		dc->hwss.cursor_lock(dc, pipe_ctx, lock);
 }
 
-void hwss_begin_cursor_offload_update(union block_sequence_params *params)
+void hwss_begin_cursor_offload_update(struct dc *dc, union block_sequence_params *params)
 {
-	struct dc *dc = params->begin_cursor_offload_update_params.dc;
-	struct pipe_ctx *pipe_ctx = params->begin_cursor_offload_update_params.pipe_ctx;
-
-	if (dc && dc->hwss.begin_cursor_offload_update)
-		dc->hwss.begin_cursor_offload_update(dc, pipe_ctx);
+	if (dc->hwss.begin_cursor_offload_update)
+		dc->hwss.begin_cursor_offload_update(
+			params->begin_cursor_offload_update_params.dmub,
+			params->begin_cursor_offload_update_params.dpp,
+			params->begin_cursor_offload_update_params.hubp,
+			params->begin_cursor_offload_update_params.stream_idx);
 }
 
-void hwss_commit_cursor_offload_update(union block_sequence_params *params)
+void hwss_commit_cursor_offload_update(struct dc *dc, union block_sequence_params *params)
 {
-	struct dc *dc = params->commit_cursor_offload_update_params.dc;
-	struct pipe_ctx *pipe_ctx = params->commit_cursor_offload_update_params.pipe_ctx;
-
-	if (dc && dc->hwss.commit_cursor_offload_update)
-		dc->hwss.commit_cursor_offload_update(dc, pipe_ctx);
+	if (dc->hwss.commit_cursor_offload_update)
+		dc->hwss.commit_cursor_offload_update(
+			params->commit_cursor_offload_update_params.dmub,
+			params->commit_cursor_offload_update_params.dpp,
+			params->commit_cursor_offload_update_params.hubp,
+			params->commit_cursor_offload_update_params.stream_idx);
 }
 
-void hwss_update_cursor_offload_pipe(union block_sequence_params *params)
+void hwss_update_cursor_offload_pipe(struct dc *dc, union block_sequence_params *params)
 {
-	struct dc *dc = params->update_cursor_offload_pipe_params.dc;
-	struct pipe_ctx *pipe_ctx = params->update_cursor_offload_pipe_params.pipe_ctx;
+	if (dc->hwss.update_cursor_offload_pipe)
+		dc->hwss.update_cursor_offload_pipe(
+			params->update_cursor_offload_pipe_params.dmub,
+			params->update_cursor_offload_pipe_params.stream_idx,
+			params->update_cursor_offload_pipe_params.pipe_idx,
+			params->update_cursor_offload_pipe_params.dpp,
+			params->update_cursor_offload_pipe_params.hubp);
+}
 
-	if (dc && dc->hwss.update_cursor_offload_pipe)
-		dc->hwss.update_cursor_offload_pipe(dc, pipe_ctx);
+void hwss_abort_cursor_offload_update(struct dc *dc, union block_sequence_params *params)
+{
+	if (dc->hwss.abort_cursor_offload_update)
+		dc->hwss.abort_cursor_offload_update(
+			params->abort_cursor_offload_update_params.dmub,
+			params->abort_cursor_offload_update_params.dpp,
+			params->abort_cursor_offload_update_params.hubp,
+			params->abort_cursor_offload_update_params.stream_idx);
 }
 
 void hwss_send_cursor_info_to_dmu(union block_sequence_params *params)
@@ -5755,18 +5736,6 @@ void hwss_add_hubp_mem_program_viewport(struct block_sequence_state *seq_state,
 	}
 }
 
-void hwss_add_abort_cursor_offload_update(struct block_sequence_state *seq_state,
-		struct dc *dc,
-		struct pipe_ctx *pipe_ctx)
-{
-	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].func = ABORT_CURSOR_OFFLOAD_UPDATE;
-		seq_state->steps[*seq_state->num_steps].params.abort_cursor_offload_update_params.dc = dc;
-		seq_state->steps[*seq_state->num_steps].params.abort_cursor_offload_update_params.pipe_ctx = pipe_ctx;
-		(*seq_state->num_steps)++;
-	}
-}
-
 void hwss_add_set_cursor_attribute(struct block_sequence_state *seq_state,
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx)
@@ -5907,18 +5876,6 @@ void hwss_add_tg_get_frame_count(struct block_sequence_state *seq_state,
 	}
 }
 
-void hwss_add_begin_cursor_offload_update(struct block_sequence_state *seq_state,
-		struct dc *dc,
-		struct pipe_ctx *pipe_ctx)
-{
-	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].func = HWSS_BEGIN_CURSOR_OFFLOAD_UPDATE;
-		seq_state->steps[*seq_state->num_steps].params.begin_cursor_offload_update_params.dc = dc;
-		seq_state->steps[*seq_state->num_steps].params.begin_cursor_offload_update_params.pipe_ctx = pipe_ctx;
-		(*seq_state->num_steps)++;
-	}
-}
-
 void hwss_add_cursor_lock(struct block_sequence_state *seq_state,
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
@@ -5967,10 +5924,27 @@ void hwss_add_update_cursor_offload_pipe(struct block_sequence_state *seq_state,
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx)
 {
+	const struct pipe_ctx *top_pipe;
+
+	if (!dc->hwss.update_cursor_offload_pipe)
+		return;
+
+	top_pipe = resource_get_otg_master(pipe_ctx);
+	if (!top_pipe)
+		return;
+
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
 		seq_state->steps[*seq_state->num_steps].func = HWSS_UPDATE_CURSOR_OFFLOAD_PIPE;
-		seq_state->steps[*seq_state->num_steps].params.update_cursor_offload_pipe_params.dc = dc;
-		seq_state->steps[*seq_state->num_steps].params.update_cursor_offload_pipe_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].params.update_cursor_offload_pipe_params.dmub =
+			dc->ctx->dmub_srv->dmub;
+		seq_state->steps[*seq_state->num_steps].params.update_cursor_offload_pipe_params.stream_idx =
+			top_pipe->pipe_idx;
+		seq_state->steps[*seq_state->num_steps].params.update_cursor_offload_pipe_params.pipe_idx =
+			pipe_ctx->pipe_idx;
+		seq_state->steps[*seq_state->num_steps].params.update_cursor_offload_pipe_params.dpp =
+			pipe_ctx->plane_res.dpp;
+		seq_state->steps[*seq_state->num_steps].params.update_cursor_offload_pipe_params.hubp =
+			pipe_ctx->plane_res.hubp;
 		(*seq_state->num_steps)++;
 	}
 }
@@ -5979,10 +5953,67 @@ void hwss_add_commit_cursor_offload_update(struct block_sequence_state *seq_stat
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx)
 {
+	const struct pipe_ctx *top_pipe = resource_get_otg_master(pipe_ctx);
+
+	if (!top_pipe)
+		return;
+
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
 		seq_state->steps[*seq_state->num_steps].func = HWSS_COMMIT_CURSOR_OFFLOAD_UPDATE;
-		seq_state->steps[*seq_state->num_steps].params.commit_cursor_offload_update_params.dc = dc;
-		seq_state->steps[*seq_state->num_steps].params.commit_cursor_offload_update_params.pipe_ctx = pipe_ctx;
+		seq_state->steps[*seq_state->num_steps].params.commit_cursor_offload_update_params.dmub =
+			dc->ctx->dmub_srv->dmub;
+		seq_state->steps[*seq_state->num_steps].params.commit_cursor_offload_update_params.stream_idx =
+			top_pipe->pipe_idx;
+		seq_state->steps[*seq_state->num_steps].params.commit_cursor_offload_update_params.dpp =
+			 pipe_ctx->plane_res.dpp;
+		seq_state->steps[*seq_state->num_steps].params.commit_cursor_offload_update_params.hubp =
+			pipe_ctx->plane_res.hubp;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_begin_cursor_offload_update(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx)
+{
+	const struct pipe_ctx *top_pipe = resource_get_otg_master(pipe_ctx);
+
+	if (!top_pipe)
+		return;
+
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = HWSS_BEGIN_CURSOR_OFFLOAD_UPDATE;
+		seq_state->steps[*seq_state->num_steps].params.begin_cursor_offload_update_params.dmub =
+			dc->ctx->dmub_srv->dmub;
+		seq_state->steps[*seq_state->num_steps].params.begin_cursor_offload_update_params.stream_idx =
+			top_pipe->pipe_idx;
+		seq_state->steps[*seq_state->num_steps].params.begin_cursor_offload_update_params.dpp =
+			 pipe_ctx->plane_res.dpp;
+		seq_state->steps[*seq_state->num_steps].params.begin_cursor_offload_update_params.hubp =
+			pipe_ctx->plane_res.hubp;
+		(*seq_state->num_steps)++;
+	}
+}
+
+void hwss_add_abort_cursor_offload_update(struct block_sequence_state *seq_state,
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx)
+{
+	const struct pipe_ctx *top_pipe = resource_get_otg_master(pipe_ctx);
+
+	if (!top_pipe)
+		return;
+
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		seq_state->steps[*seq_state->num_steps].func = ABORT_CURSOR_OFFLOAD_UPDATE;
+		seq_state->steps[*seq_state->num_steps].params.abort_cursor_offload_update_params.dmub =
+			dc->ctx->dmub_srv->dmub;
+		seq_state->steps[*seq_state->num_steps].params.abort_cursor_offload_update_params.stream_idx =
+			top_pipe->pipe_idx;
+		seq_state->steps[*seq_state->num_steps].params.abort_cursor_offload_update_params.dpp =
+			 pipe_ctx->plane_res.dpp;
+		seq_state->steps[*seq_state->num_steps].params.abort_cursor_offload_update_params.hubp =
+			pipe_ctx->plane_res.hubp;
 		(*seq_state->num_steps)++;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
index 35d4d0d5ae34..c05428f52d88 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_stream.c
@@ -323,7 +323,12 @@ void program_cursor_attributes(
 			pipe_to_program = pipe_ctx;
 
 			if (enable_cursor_offload && dc->hwss.begin_cursor_offload_update) {
-				dc->hwss.begin_cursor_offload_update(dc, pipe_ctx);
+				struct pipe_ctx *top_pipe = resource_get_otg_master(pipe_ctx);
+
+				if (top_pipe)
+					dc->hwss.begin_cursor_offload_update(dc->ctx->dmub_srv->dmub,
+						pipe_ctx->plane_res.dpp, pipe_ctx->plane_res.hubp,
+						top_pipe->pipe_idx);
 			} else {
 				dc->hwss.cursor_lock(dc, pipe_to_program, true);
 				if (pipe_to_program->next_odm_pipe)
@@ -335,13 +340,24 @@ void program_cursor_attributes(
 		update_cursor_info_to_dmu(dc, pipe_ctx);
 		if (dc->hwss.set_cursor_sdr_white_level)
 			dc->hwss.set_cursor_sdr_white_level(pipe_ctx);
-		if (enable_cursor_offload && dc->hwss.update_cursor_offload_pipe)
-			dc->hwss.update_cursor_offload_pipe(dc, pipe_ctx);
+		if (enable_cursor_offload && dc->hwss.update_cursor_offload_pipe) {
+			struct pipe_ctx *top_pipe = resource_get_otg_master(pipe_ctx);
+
+			if (top_pipe)
+				dc->hwss.update_cursor_offload_pipe(dc->ctx->dmub_srv->dmub,
+					top_pipe->pipe_idx, pipe_ctx->pipe_idx,
+					pipe_ctx->plane_res.dpp, pipe_ctx->plane_res.hubp);
+		}
 	}
 
 	if (pipe_to_program) {
 		if (enable_cursor_offload && dc->hwss.commit_cursor_offload_update) {
-			dc->hwss.commit_cursor_offload_update(dc, pipe_to_program);
+			struct pipe_ctx *top_pipe = resource_get_otg_master(pipe_to_program);
+
+			if (top_pipe)
+				dc->hwss.commit_cursor_offload_update(dc->ctx->dmub_srv->dmub,
+					pipe_to_program->plane_res.dpp, pipe_to_program->plane_res.hubp,
+					top_pipe->pipe_idx);
 		} else {
 			dc->hwss.cursor_lock(dc, pipe_to_program, false);
 			if (pipe_to_program->next_odm_pipe)
@@ -484,24 +500,42 @@ void program_cursor_position(
 		if (!pipe_to_program) {
 			pipe_to_program = pipe_ctx;
 
-			if (enable_cursor_offload && dc->hwss.begin_cursor_offload_update)
-				dc->hwss.begin_cursor_offload_update(dc, pipe_ctx);
-			else
+			if (enable_cursor_offload && dc->hwss.begin_cursor_offload_update) {
+				struct pipe_ctx *top_pipe = resource_get_otg_master(pipe_ctx);
+
+				if (top_pipe)
+					dc->hwss.begin_cursor_offload_update(dc->ctx->dmub_srv->dmub,
+						pipe_ctx->plane_res.dpp, pipe_ctx->plane_res.hubp,
+						top_pipe->pipe_idx);
+			} else {
 				dc->hwss.cursor_lock(dc, pipe_to_program, true);
+			}
 		}
 
 		dc->hwss.set_cursor_position(pipe_ctx);
-		if (enable_cursor_offload && dc->hwss.update_cursor_offload_pipe)
-			dc->hwss.update_cursor_offload_pipe(dc, pipe_ctx);
+		if (enable_cursor_offload && dc->hwss.update_cursor_offload_pipe) {
+			struct pipe_ctx *top_pipe = resource_get_otg_master(pipe_ctx);
+
+			if (top_pipe)
+				dc->hwss.update_cursor_offload_pipe(dc->ctx->dmub_srv->dmub,
+					top_pipe->pipe_idx, pipe_ctx->pipe_idx,
+					pipe_ctx->plane_res.dpp, pipe_ctx->plane_res.hubp);
+		}
 
 		update_cursor_info_to_dmu(dc, pipe_ctx);
 	}
 
 	if (pipe_to_program) {
-		if (enable_cursor_offload && dc->hwss.commit_cursor_offload_update)
-			dc->hwss.commit_cursor_offload_update(dc, pipe_to_program);
-		else
+		if (enable_cursor_offload && dc->hwss.commit_cursor_offload_update) {
+			struct pipe_ctx *top_pipe = resource_get_otg_master(pipe_to_program);
+
+			if (top_pipe)
+				dc->hwss.commit_cursor_offload_update(dc->ctx->dmub_srv->dmub,
+					pipe_to_program->plane_res.dpp, pipe_to_program->plane_res.hubp,
+					top_pipe->pipe_idx);
+		} else {
 			dc->hwss.cursor_lock(dc, pipe_to_program, false);
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 1b0fc0853045..5a163711498a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3145,8 +3145,14 @@ static void dcn10_update_dchubp_dpp(
 	}
 
 	if (pipe_ctx->stream->cursor_attributes.address.quad_part != 0) {
-		if (dc->hwss.abort_cursor_offload_update)
-			dc->hwss.abort_cursor_offload_update(dc, pipe_ctx);
+		if (dc_dmub_srv_is_cursor_offload_enabled(dc) && dc->hwss.abort_cursor_offload_update) {
+			struct pipe_ctx *top_pipe = resource_get_otg_master(pipe_ctx);
+
+			if (top_pipe)
+				dc->hwss.abort_cursor_offload_update(dc->ctx->dmub_srv->dmub,
+					pipe_ctx->plane_res.dpp, pipe_ctx->plane_res.hubp,
+					top_pipe->pipe_idx);
+		}
 
 		dc->hwss.set_cursor_attribute(pipe_ctx);
 		dc->hwss.set_cursor_position(pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 1e60b852e61f..4e7a005d27ef 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1834,8 +1834,14 @@ void dcn20_update_dchubp_dpp(
 	if ((pipe_ctx->update_flags.bits.enable || pipe_ctx->update_flags.bits.opp_changed ||
 			pipe_ctx->update_flags.bits.scaler || viewport_changed == true) &&
 			pipe_ctx->stream->cursor_attributes.address.quad_part != 0) {
-		if (dc->hwss.abort_cursor_offload_update)
-			dc->hwss.abort_cursor_offload_update(dc, pipe_ctx);
+		if (dc_dmub_srv_is_cursor_offload_enabled(dc) && dc->hwss.abort_cursor_offload_update) {
+			struct pipe_ctx *top_pipe = resource_get_otg_master(pipe_ctx);
+
+			if (top_pipe)
+				dc->hwss.abort_cursor_offload_update(dc->ctx->dmub_srv->dmub,
+					pipe_ctx->plane_res.dpp, pipe_ctx->plane_res.hubp,
+					top_pipe->pipe_idx);
+		}
 
 		dc->hwss.set_cursor_attribute(pipe_ctx);
 		dc->hwss.set_cursor_position(pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 6e1079377f48..16526c66c2d1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1642,10 +1642,9 @@ void dcn35_hardware_release(struct dc *dc)
 		dc->hwss.hw_block_power_up(dc, &pg_update_state);
 }
 
-void dcn35_abort_cursor_offload_update(struct dc *dc, const struct pipe_ctx *pipe)
+void dcn35_abort_cursor_offload_update(struct dmub_srv *dmub, struct dpp *dpp, struct hubp *hubp, uint32_t stream_idx)
 {
-	if (!dc_dmub_srv_is_cursor_offload_enabled(dc))
-		return;
+	struct dc *dc = dpp->ctx->dc;
 
 	/*
 	 * Insert a blank update to modify the write index and set pipe_mask to 0.
@@ -1664,56 +1663,46 @@ void dcn35_abort_cursor_offload_update(struct dc *dc, const struct pipe_ctx *pip
 	 */
 
 	if (dc->hwss.begin_cursor_offload_update)
-		dc->hwss.begin_cursor_offload_update(dc, pipe);
+		dc->hwss.begin_cursor_offload_update(dmub, dpp, hubp, stream_idx);
 
 	if (dc->hwss.commit_cursor_offload_update)
-		dc->hwss.commit_cursor_offload_update(dc, pipe);
+		dc->hwss.commit_cursor_offload_update(dmub, dpp, hubp, stream_idx);
 }
 
-void dcn35_begin_cursor_offload_update(struct dc *dc, const struct pipe_ctx *pipe)
+void dcn35_begin_cursor_offload_update(struct dmub_srv *dmub, struct dpp *dpp, struct hubp *hubp, uint32_t stream_idx)
 {
-	volatile struct dmub_cursor_offload_v1 *cs = dc->ctx->dmub_srv->dmub->cursor_offload_v1;
-	const struct pipe_ctx *top_pipe = resource_get_otg_master(pipe);
-	uint32_t stream_idx, write_idx, payload_idx;
-
-	if (!top_pipe)
-		return;
+	volatile struct dmub_cursor_offload_v1 *cs = dmub->cursor_offload_v1;
+	uint32_t write_idx, payload_idx;
 
-	stream_idx = top_pipe->pipe_idx;
 	write_idx = cs->offload_streams[stream_idx].write_idx + 1; /*  new payload (+1) */
 	payload_idx = write_idx % ARRAY_SIZE(cs->offload_streams[stream_idx].payloads);
 
 	cs->offload_streams[stream_idx].payloads[payload_idx].write_idx_start = write_idx;
 	cs->offload_streams[stream_idx].payloads[payload_idx].pipe_mask = 0;
 
-	if (pipe->plane_res.hubp)
-		pipe->plane_res.hubp->cursor_offload = true;
+	if (hubp)
+		hubp->cursor_offload = true;
 
-	if (pipe->plane_res.dpp)
-		pipe->plane_res.dpp->cursor_offload = true;
+	if (dpp)
+		dpp->cursor_offload = true;
 }
 
-void dcn35_commit_cursor_offload_update(struct dc *dc, const struct pipe_ctx *pipe)
+void dcn35_commit_cursor_offload_update(struct dmub_srv *dmub, struct dpp *dpp, struct hubp *hubp, uint32_t stream_idx)
 {
-	volatile struct dmub_cursor_offload_v1 *cs = dc->ctx->dmub_srv->dmub->cursor_offload_v1;
+	volatile struct dmub_cursor_offload_v1 *cs = dmub->cursor_offload_v1;
 	volatile struct dmub_shared_state_cursor_offload_stream_v1 *shared_stream;
-	const struct pipe_ctx *top_pipe = resource_get_otg_master(pipe);
-	uint32_t stream_idx, write_idx, payload_idx;
+	uint32_t write_idx, payload_idx;
 
-	if (pipe->plane_res.hubp)
-		pipe->plane_res.hubp->cursor_offload = false;
+	if (hubp)
+		hubp->cursor_offload = false;
 
-	if (pipe->plane_res.dpp)
-		pipe->plane_res.dpp->cursor_offload = false;
+	if (dpp)
+		dpp->cursor_offload = false;
 
-	if (!top_pipe)
-		return;
-
-	stream_idx = top_pipe->pipe_idx;
 	write_idx = cs->offload_streams[stream_idx].write_idx + 1; /*  new payload (+1) */
 	payload_idx = write_idx % ARRAY_SIZE(cs->offload_streams[stream_idx].payloads);
 
-	shared_stream = &dc->ctx->dmub_srv->dmub->shared_state[DMUB_SHARED_STATE_FEATURE__CURSOR_OFFLOAD_V1]
+	shared_stream = &dmub->shared_state[DMUB_SHARED_STATE_FEATURE__CURSOR_OFFLOAD_V1]
 				 .data.cursor_offload_v1.offload_streams[stream_idx];
 
 	shared_stream->last_write_idx = write_idx;
@@ -1722,23 +1711,17 @@ void dcn35_commit_cursor_offload_update(struct dc *dc, const struct pipe_ctx *pi
 	cs->offload_streams[stream_idx].payloads[payload_idx].write_idx_finish = write_idx;
 }
 
-void dcn35_update_cursor_offload_pipe(struct dc *dc, const struct pipe_ctx *pipe)
+void dcn35_update_cursor_offload_pipe(struct dmub_srv *dmub, uint32_t stream_idx,
+		uint8_t pipe_idx, const struct dpp *dpp, const struct hubp *hubp)
 {
-	volatile struct dmub_cursor_offload_v1 *cs = dc->ctx->dmub_srv->dmub->cursor_offload_v1;
-	const struct pipe_ctx *top_pipe = resource_get_otg_master(pipe);
-	const struct hubp *hubp = pipe->plane_res.hubp;
-	const struct dpp *dpp = pipe->plane_res.dpp;
+	volatile struct dmub_cursor_offload_v1 *cs = dmub->cursor_offload_v1;
 	volatile struct dmub_cursor_offload_pipe_data_dcn30_v1 *p;
-	uint32_t stream_idx, write_idx, payload_idx;
-
-	if (!top_pipe || !hubp || !dpp)
-		return;
+	uint32_t write_idx, payload_idx;
 
-	stream_idx = top_pipe->pipe_idx;
 	write_idx = cs->offload_streams[stream_idx].write_idx + 1; /*  new payload (+1) */
 	payload_idx = write_idx % ARRAY_SIZE(cs->offload_streams[stream_idx].payloads);
 
-	p = &cs->offload_streams[stream_idx].payloads[payload_idx].pipe_data[pipe->pipe_idx].dcn30;
+	p = &cs->offload_streams[stream_idx].payloads[payload_idx].pipe_data[pipe_idx].dcn30;
 
 	p->CURSOR0_0_CURSOR_SURFACE_ADDRESS = hubp->att.SURFACE_ADDR;
 	p->CURSOR0_0_CURSOR_SURFACE_ADDRESS_HIGH = hubp->att.SURFACE_ADDR_HIGH;
@@ -1767,7 +1750,7 @@ void dcn35_update_cursor_offload_pipe(struct dc *dc, const struct pipe_ctx *pipe
 	p->HUBPREQ0_CURSOR_SETTINGS__CURSOR0_DST_Y_OFFSET = hubp->att.settings.bits.dst_y_offset;
 	p->HUBPREQ0_CURSOR_SETTINGS__CURSOR0_CHUNK_HDL_ADJUST = hubp->att.settings.bits.chunk_hdl_adjust;
 
-	cs->offload_streams[stream_idx].payloads[payload_idx].pipe_mask |= (1u << pipe->pipe_idx);
+	cs->offload_streams[stream_idx].payloads[payload_idx].pipe_mask |= (1u << pipe_idx);
 }
 
 void dcn35_notify_cursor_offload_drr_update(struct dc *dc, struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index 235ebf00bd1f..fce9acb5c2fc 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -103,10 +103,12 @@ bool dcn35_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx);
 
 void dcn35_hardware_release(struct dc *dc);
 
-void dcn35_abort_cursor_offload_update(struct dc *dc, const struct pipe_ctx *pipe);
-void dcn35_begin_cursor_offload_update(struct dc *dc, const struct pipe_ctx *pipe);
-void dcn35_commit_cursor_offload_update(struct dc *dc, const struct pipe_ctx *pipe);
-void dcn35_update_cursor_offload_pipe(struct dc *dc, const struct pipe_ctx *pipe);
+void dcn35_abort_cursor_offload_update(struct dmub_srv *dmub, struct dpp *dpp, struct hubp *hubp, uint32_t stream_idx);
+void dcn35_begin_cursor_offload_update(struct dmub_srv *dmub, struct dpp *dpp, struct hubp *hubp, uint32_t stream_idx);
+void dcn35_commit_cursor_offload_update(struct dmub_srv *dmub, struct dpp *dpp,
+	struct hubp *hubp, uint32_t stream_idx);
+void dcn35_update_cursor_offload_pipe(struct dmub_srv *dmub, uint32_t stream_idx,
+		uint8_t pipe_idx, const struct dpp *dpp, const struct hubp *hubp);
 void dcn35_notify_cursor_offload_drr_update(struct dc *dc, struct dc_state *context,
 					    const struct dc_stream_state *stream);
 void dcn35_program_cursor_offload_now(struct dc *dc, const struct pipe_ctx *pipe);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 7b089ae5c9c3..3a5dde5c8120 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -3089,23 +3089,17 @@ void dcn401_plane_atomic_power_down(struct dc *dc,
 		hws->funcs.dpp_root_clock_control(hws, dpp->inst, false);
 }
 
-void dcn401_update_cursor_offload_pipe(struct dc *dc, const struct pipe_ctx *pipe)
+void dcn401_update_cursor_offload_pipe(struct dmub_srv *dmub, uint32_t stream_idx,
+		uint8_t pipe_idx, const struct dpp *dpp, const struct hubp *hubp)
 {
-	volatile struct dmub_cursor_offload_v1 *cs = dc->ctx->dmub_srv->dmub->cursor_offload_v1;
-	const struct pipe_ctx *top_pipe = resource_get_otg_master(pipe);
-	const struct hubp *hubp = pipe->plane_res.hubp;
-	const struct dpp *dpp = pipe->plane_res.dpp;
+	volatile struct dmub_cursor_offload_v1 *cs = dmub->cursor_offload_v1;
 	volatile struct dmub_cursor_offload_pipe_data_dcn401_v1 *p;
-	uint32_t stream_idx, write_idx, payload_idx;
+	uint32_t write_idx, payload_idx;
 
-	if (!top_pipe || !hubp || !dpp)
-		return;
-
-	stream_idx = top_pipe->pipe_idx;
 	write_idx = cs->offload_streams[stream_idx].write_idx + 1; /*  new payload (+1) */
 	payload_idx = write_idx % ARRAY_SIZE(cs->offload_streams[stream_idx].payloads);
 
-	p = &cs->offload_streams[stream_idx].payloads[payload_idx].pipe_data[pipe->pipe_idx].dcn401;
+	p = &cs->offload_streams[stream_idx].payloads[payload_idx].pipe_data[pipe_idx].dcn401;
 
 	p->CURSOR0_0_CURSOR_SURFACE_ADDRESS = hubp->att.SURFACE_ADDR;
 	p->CURSOR0_0_CURSOR_SURFACE_ADDRESS_HIGH = hubp->att.SURFACE_ADDR_HIGH;
@@ -3142,7 +3136,7 @@ void dcn401_update_cursor_offload_pipe(struct dc *dc, const struct pipe_ctx *pip
 	p->HUBPREQ0_CURSOR_SETTINGS__CURSOR0_CHUNK_HDL_ADJUST = hubp->att.settings.bits.chunk_hdl_adjust;
 	p->HUBP0_DCHUBP_MALL_CONFIG__USE_MALL_FOR_CURSOR = hubp->use_mall_for_cursor;
 
-	cs->offload_streams[stream_idx].payloads[payload_idx].pipe_mask |= (1u << pipe->pipe_idx);
+	cs->offload_streams[stream_idx].payloads[payload_idx].pipe_mask |= (1u << pipe_idx);
 }
 
 void dcn401_plane_atomic_power_down_sequence(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index 756b2d98a930..81e3700d728b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -136,7 +136,8 @@ void dcn401_blank_pixel_data_sequence(
 	bool blank,
 	struct block_sequence_state *seq_state);
 void dcn401_initialize_min_clocks(struct dc *dc);
-void dcn401_update_cursor_offload_pipe(struct dc *dc, const struct pipe_ctx *pipe);
+void dcn401_update_cursor_offload_pipe(struct dmub_srv *dmub, uint32_t stream_idx,
+		uint8_t pipe_idx, const struct dpp *dpp, const struct hubp *hubp);
 
 void dcn401_program_all_writeback_pipes_in_tree_sequence(
 		struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
index c13d1ad8d000..8b63e75e5ee2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn50/dcn50_hwseq.c
@@ -201,8 +201,14 @@ void dcn50_update_dchubp_dpp(
 	if ((pipe_ctx->update_flags.bits.enable || pipe_ctx->update_flags.bits.opp_changed ||
 		pipe_ctx->update_flags.bits.scaler || viewport_changed == true) &&
 		pipe_ctx->stream->cursor_attributes.address.quad_part != 0) {
-		if (dc->hwss.abort_cursor_offload_update)
-			dc->hwss.abort_cursor_offload_update(dc, pipe_ctx);
+		if (dc_dmub_srv_is_cursor_offload_enabled(dc) && dc->hwss.abort_cursor_offload_update) {
+			struct pipe_ctx *top_pipe = resource_get_otg_master(pipe_ctx);
+
+			if (top_pipe)
+				dc->hwss.abort_cursor_offload_update(dc->ctx->dmub_srv->dmub,
+					pipe_ctx->plane_res.dpp, pipe_ctx->plane_res.hubp,
+					top_pipe->pipe_idx);
+		}
 
 		dc->hwss.set_cursor_attribute(pipe_ctx);
 		dc->hwss.set_cursor_position(pipe_ctx);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
index 0e6526e92544..5936f389d936 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.c
@@ -790,23 +790,17 @@ void dcn60_set_cursor_attribute(struct pipe_ctx *pipe_ctx)
 		pipe_ctx->plane_res.dpp, attributes);
 }
 
-void dcn60_update_cursor_offload_pipe(struct dc *dc, const struct pipe_ctx *pipe)
+void dcn60_update_cursor_offload_pipe(struct dmub_srv *dmub, uint32_t stream_idx,
+		uint8_t pipe_idx, const struct dpp *dpp, const struct hubp *hubp)
 {
-	volatile struct dmub_cursor_offload_v1 *cs = dc->ctx->dmub_srv->dmub->cursor_offload_v1;
-	const struct pipe_ctx *top_pipe = resource_get_otg_master(pipe);
-	const struct hubp *hubp = pipe->plane_res.hubp;
-	const struct dpp *dpp = pipe->plane_res.dpp;
+	volatile struct dmub_cursor_offload_v1 *cs = dmub->cursor_offload_v1;
 	volatile struct dmub_cursor_offload_pipe_data_dcn60_v1 *p;
-	uint32_t stream_idx, write_idx, payload_idx;
+	uint32_t write_idx, payload_idx;
 
-	if (!top_pipe || !hubp || !dpp)
-		return;
-
-	stream_idx = top_pipe->pipe_idx;
 	write_idx = cs->offload_streams[stream_idx].write_idx + 1; /*  new payload (+1) */
 	payload_idx = write_idx % ARRAY_SIZE(cs->offload_streams[stream_idx].payloads);
 
-	p = &cs->offload_streams[stream_idx].payloads[payload_idx].pipe_data[pipe->pipe_idx].dcn60;
+	p = &cs->offload_streams[stream_idx].payloads[payload_idx].pipe_data[pipe_idx].dcn60;
 
 	p->CURSOR0_0_CURSOR_SURFACE_ADDRESS = hubp->att.SURFACE_ADDR;
 	p->CURSOR0_0_CURSOR_SURFACE_ADDRESS_HIGH = hubp->att.SURFACE_ADDR_HIGH;
@@ -843,7 +837,7 @@ void dcn60_update_cursor_offload_pipe(struct dc *dc, const struct pipe_ctx *pipe
 	p->HUBPREQ0_CURSOR_SETTINGS__CURSOR0_CHUNK_HDL_ADJUST = hubp->att.settings.bits.chunk_hdl_adjust;
 	p->HUBPREQ0_CURSOR_SETTINGS__FORCE_CURSOR_TO_DISP_PREF = hubp->att.settings.bits.force_cursor_to_disp_pref;
 
-	cs->offload_streams[stream_idx].payloads[payload_idx].pipe_mask |= (1u << pipe->pipe_idx);
+	cs->offload_streams[stream_idx].payloads[payload_idx].pipe_mask |= (1u << pipe_idx);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h
index b57d22d310b0..3a34150096df 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_hwseq.h
@@ -24,7 +24,8 @@ enum dc_status dcn60_apply_single_controller_ctx_to_hw(
 
 void dcn60_init_hw(struct dc *dc);
 void dcn60_set_cursor_attribute(struct pipe_ctx *pipe_ctx);
-void dcn60_update_cursor_offload_pipe(struct dc *dc, const struct pipe_ctx *pipe);
+void dcn60_update_cursor_offload_pipe(struct dmub_srv *dmub, uint32_t stream_idx,
+	uint8_t pipe_idx, const struct dpp *dpp, const struct hubp *hubp);
 
 void dcn60_program_perfmon(struct dc *dc, struct dc_state *context);
 bool dcn60_apply_idle_power_optimizations(struct dc *dc, bool enable);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index f75e34a09dca..0133c6156897 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -837,11 +837,6 @@ struct hubp_program_mcache_id_and_split_coordinate_params {
 	struct mcache_regs_struct *mcache_regs;
 };
 
-struct abort_cursor_offload_update_params {
-	struct dc *dc;
-	struct pipe_ctx *pipe_ctx;
-};
-
 struct cursor_lock_params {
 	struct dc *dc;
 	struct pipe_ctx *pipe_ctx;
@@ -906,18 +901,32 @@ struct phantom_hubp_post_enable_params {
 };
 
 struct begin_cursor_offload_update_params {
-	struct dc *dc;
-	struct pipe_ctx *pipe_ctx;
+	struct dmub_srv *dmub;
+	struct dpp *dpp;
+	struct hubp *hubp;
+	uint32_t stream_idx;
 };
 
 struct update_cursor_offload_pipe_params {
-	struct dc *dc;
-	struct pipe_ctx *pipe_ctx;
+	struct dmub_srv *dmub;
+	const struct dpp *dpp;
+	const struct hubp *hubp;
+	uint32_t stream_idx;
+	uint8_t pipe_idx;
 };
 
 struct commit_cursor_offload_update_params {
-	struct dc *dc;
-	struct pipe_ctx *pipe_ctx;
+	struct dmub_srv *dmub;
+	struct dpp *dpp;
+	struct hubp *hubp;
+	uint32_t stream_idx;
+};
+
+struct abort_cursor_offload_update_params {
+	struct dmub_srv *dmub;
+	struct dpp *dpp;
+	struct hubp *hubp;
+	uint32_t stream_idx;
 };
 
 struct stream_enc_update_hdmi_info_packets_params {
@@ -1535,10 +1544,17 @@ struct hw_sequencer_funcs {
 	void (*set_cursor_position)(struct pipe_ctx *pipe);
 	void (*set_cursor_attribute)(struct pipe_ctx *pipe);
 	void (*set_cursor_sdr_white_level)(struct pipe_ctx *pipe);
-	void (*abort_cursor_offload_update)(struct dc *dc, const struct pipe_ctx *pipe);
-	void (*begin_cursor_offload_update)(struct dc *dc, const struct pipe_ctx *pipe);
-	void (*commit_cursor_offload_update)(struct dc *dc, const struct pipe_ctx *pipe);
-	void (*update_cursor_offload_pipe)(struct dc *dc, const struct pipe_ctx *pipe);
+	void (*abort_cursor_offload_update)(struct dmub_srv *dmub, struct dpp *dpp,
+			struct hubp *hubp, uint32_t stream_idx);
+	void (*begin_cursor_offload_update)(struct dmub_srv *dmub, struct dpp *dpp,
+			struct hubp *hubp, uint32_t stream_idx);
+	void (*commit_cursor_offload_update)(struct dmub_srv *dmub, struct dpp *dpp,
+			struct hubp *hubp, uint32_t stream_idx);
+	void (*update_cursor_offload_pipe)(struct dmub_srv *dmub,
+			uint32_t stream_idx,
+			uint8_t pipe_idx,
+			const struct dpp *dpp,
+			const struct hubp *hubp);
 	void (*notify_cursor_offload_drr_update)(struct dc *dc, struct dc_state *context,
 						 const struct dc_stream_state *stream);
 	void (*program_cursor_offload_now)(struct dc *dc, const struct pipe_ctx *pipe);
@@ -2126,8 +2142,6 @@ void hwss_dpp_set_scaler(union block_sequence_params *params);
 
 void hwss_hubp_mem_program_viewport(union block_sequence_params *params);
 
-void hwss_abort_cursor_offload_update(union block_sequence_params *params);
-
 void hwss_send_cursor_info_to_dmu(union block_sequence_params *params);
 
 void hwss_set_cursor_attribute(union block_sequence_params *params);
@@ -2152,11 +2166,13 @@ void hwss_phantom_hubp_post_enable(union block_sequence_params *params);
 
 void hwss_cursor_lock(union block_sequence_params *params);
 
-void hwss_begin_cursor_offload_update(union block_sequence_params *params);
+void hwss_begin_cursor_offload_update(struct dc *dc, union block_sequence_params *params);
+
+void hwss_commit_cursor_offload_update(struct dc *dc, union block_sequence_params *params);
 
-void hwss_commit_cursor_offload_update(union block_sequence_params *params);
+void hwss_update_cursor_offload_pipe(struct dc *dc, union block_sequence_params *params);
 
-void hwss_update_cursor_offload_pipe(union block_sequence_params *params);
+void hwss_abort_cursor_offload_update(struct dc *dc, union block_sequence_params *params);
 
 void hwss_setup_periodic_interrupt(struct dc *dc, struct pipe_ctx *pipe_ctx);
 
-- 
2.43.0


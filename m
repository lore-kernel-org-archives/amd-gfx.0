Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB2A8C982D1
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Sep 2026 17:53:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CF9F10ECE2;
	Wed, 16 Sep 2026 17:53:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YI9JQ8e7";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010009.outbound.protection.outlook.com [52.101.201.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 22A7D10EBD2
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Sep 2026 17:53:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SjSrpX78aZp0zIlC5T8GRi5hTs0CZivOXWaBYHKtMqYNNG8EtD6FQCxOQcCuZCTcFaRWgXDqOGBUvNlWenw6sUJFip5Jbge7XaDliHxN85WuyDrhbUvf+ZDB0syVXf2oZOnzo5w0VJ9QXLSZ2xQU86x41Om3RBlsOFnjvYSOhpc8KB1X+PIOv1/xW9sHavwZDYDIB8hkcMrIk/FLgU3DR3WI8x8nq9tOGxWul2AWITFHZD9M6ulHHRsOZSuXpIR8jugpyrae7urkKJbyK57OLGkstF1FXok0s7fyQtd7wmPavKQR8myexM/Cx1CvLoZOi0UXOaDIsMVOX/QB+JkvIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZfxsyJ5AZB63Y3KsPFtqVbaGnyeKsirIGI9D62sQr+U=;
 b=Qn6jjnILUSSFAfTSSwfySyEl2m/X018iOVuBKT9nOiONgU37XY9yXoS9LjHC+pLN+ni/URdygcB+uf8q+NwnXp3u0EFtHF80Sx0TqB2uj69srTFDpmIJap3PUGIg49vHasicx9SIfNsFip7CpbiG1N/lvGoGnUl/849jUbB1aLwmafJZLvWm4/noouI08vsy4Kbvjlr9ggO+3fD8dE7qKegpfqJDelMd5m3D7sGCuYZw5627Ft/Kn7HOKQkcYJ7CUUI1rNcyqeYhyEZNr/eV79y3066H0MMSvAkFy6dytcEpB0J6qTwQsEiuypG/S/V2kPiq7aHCDOcRVEzlJx0N4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZfxsyJ5AZB63Y3KsPFtqVbaGnyeKsirIGI9D62sQr+U=;
 b=YI9JQ8e7g9okMr/CWtNKMMJGaLEiI1FhOrXeYxkfhJ0j6yUvjzh3IAehjvKuR/7L1itFaDj9tUyzVUVyU7vD9hHeXw11E3UgtZAupsen++3Y9dh0/bJTUzSKBgTumfAJRA8dBjS1Fp2DzblRvF2E7F65cbBp875aojOjLBzLNiw=
Received: from CH5P220CA0018.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::25)
 by PH7PR12MB5710.namprd12.prod.outlook.com (2603:10b6:510:1e1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 17:53:10 +0000
Received: from CH3PEPF0000000D.namprd04.prod.outlook.com
 (2603:10b6:610:1ef:cafe::97) by CH5P220CA0018.outlook.office365.com
 (2603:10b6:610:1ef::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.11 via Frontend Transport; Wed,
 16 Sep 2026 17:53:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000D.mail.protection.outlook.com (10.167.244.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.428.7 via Frontend Transport; Wed, 16 Sep 2026 17:53:10 +0000
Received: from georzhanmkm.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 16 Sep
 2026 12:52:59 -0500
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
Subject: [PATCH 58/64] drm/amd/display: Rename build_cursor_position to
 dcn10_build_cursor_pos_update_params
Date: Wed, 16 Sep 2026 13:52:13 -0400
Message-ID: <20260916175301.368306-59-george.zhang@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000D:EE_|PH7PR12MB5710:EE_
X-MS-Office365-Filtering-Correlation-Id: d3faedc5-8091-4da5-a9b8-08df141b5f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|82310400026|36860700016|376014|10067099003|3023799007|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: ihcRzhoQgbBB9WpkHBHcMw2oCoR+DNbb8hu6L1Sg7p6CSRxRqX7Q1scQFEOgwjSM7eOBljk2Wqh/7ih3nZAO1iQysNsXrc0akPW+AmH6hzcIcYKNPHdlYv8oPHpLpIM6iqeVYVkmlcHjrNbPvmcPRYgpeex08RdKDSHBL+KDxNw1Axe0Wsda9jzgNDkbPzWDC95SuspchPW6mJsGdeIiYmPvahzD+Lq1WesCPr0gXUBLhC3aDU9sFcgUCei/I4ieI08A1bd0qIbgKIUqydmbUt8E8E1tOrEt1NHUN6DVRbxGsTlt5Qzi4j5MBnNwbBbN3Gxcb9swCAGInywPqDFfJ9jqOGtAgeQXorySaRfU95pNLHHCn+3cTQSvfJhVi6dTB7gYblrjsSC6BocsrgnHz4YZxTfVraMM3vv90fJfFbYPOeFXWqk4qLkDowAqwE1u8P5QdSpWK2X0PM4L9jlrO+HkMTMxZlFp7+1B4eqvfoj6pydnH8xkSlIiurBwIpkiAx68rQYklg1hOaveV1rFxX1taqu6FluMzKUEWfJXX+DyGxmEm6nde4glT2ppjy6YUW5uVAsNaZJjU74aX0G3ArdL0HhSENwHqYKiZdZNDiSlrTKsWe/Inq0xgJqRZqLSVFLB90sj0frZVXfp0pyEyMDxF26klCL95KXnXfr47sh5ZAzaMcQXqAGaFw70uIN3yPZnvTt3pCQ+oytPkQ7F8Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(82310400026)(36860700016)(376014)(10067099003)(3023799007)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: eGmfYqhAMKC6RxHl/jgP2SDRxMIfFmoibhwvP5NXTyaPn2pcri7n09VWzMjJ9pYs/I0Z/yLdW+8353MurdCZ8U+QQYGdgw3kJueEuRq9s/dQYuMzcJ25sY/pJANaULZYkeCSnYGsrkCCiFLsmJEizHCZUeCh6TR02PcYjcI0z1i9Ej4mw8S+HWUkwUzNm0K5bLIdOCcrHvyQ6QsjzdV8wwpqx4wnhLelxTydKosgePL8nw2/NQ8wK5oaJxn9LzbgNDTNZP5yntby31moKFGyBBe8v1gwuChVwjP/SqkPplDy0u0sQpYfUu04uSCOAUHKL3daV6GJPEtLwTNy+lxZxxV5jRehY453uasrPNRVgOERZDBn64t7Bw5jmwk6R4EPl4KKGQhcPoyxUHuw4Cx6Yylp1T1R9PAckHFiPWspJYa9Y7f0Jo2Z8iBCOBM7z3dx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 17:53:10.0542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3faedc5-8091-4da5-a9b8-08df141b5f0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5710
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

This commit contains renames, adding const to pipe_ctx in
build_cursor_pos_update_params and also removing unnecessary checks
before dc_dmub_srv_is_cursor_offload_enabled().

[Why]
It improves code clarity.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Piotr Maziarz <piotr.maziarz@amd.com>
Signed-off-by: George Zhang <george.zhang@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 19 +++++++------------
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  6 +++---
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   |  2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |  2 +-
 .../amd/display/dc/hwss/dcn10/dcn10_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn20/dcn20_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn201/dcn201_init.c  |  2 +-
 .../amd/display/dc/hwss/dcn21/dcn21_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn30/dcn30_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn301/dcn301_init.c  |  2 +-
 .../amd/display/dc/hwss/dcn31/dcn31_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn314/dcn314_init.c  |  2 +-
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |  2 +-
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |  2 +-
 .../amd/display/dc/hwss/dcn42/dcn42_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn60/dcn60_init.c    |  2 +-
 .../display/dc/hwss/hw_sequencer_private.h    |  2 +-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  2 +-
 22 files changed, 30 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 0a7408692cbe..28897addb553 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -1301,12 +1301,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 	}
 
 	/* Track cursor lock state - separate locks for attribute and position updates */
-	bool enable_cursor_offload = false;
-
-	if ((dc->hwss.set_cursor_attribute && stream->update_flags.bits.cursor_attr) ||
-		(dc->hwseq && dc->hwseq->funcs.build_cursor_position &&
-			dc->hwss.set_cursor_position && stream->update_flags.bits.cursor_pos))
-		enable_cursor_offload = dc_dmub_srv_is_cursor_offload_enabled(dc);
+	bool enable_cursor_offload = dc_dmub_srv_is_cursor_offload_enabled(dc);
 
 	/* Cursor attribute updates - separate lock/iterate/unlock */
 	if (dc->hwss.set_cursor_attribute && stream->update_flags.bits.cursor_attr) {
@@ -1391,7 +1386,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 	}
 
 	/* Cursor position updates */
-	if (dc->hwseq && dc->hwseq->funcs.build_cursor_position &&
+	if (dc->hwseq && dc->hwseq->funcs.build_cursor_pos_update_params &&
 			dc->hwss.set_cursor_position && stream->update_flags.bits.cursor_pos) {
 		struct pipe_ctx *cursor_pipe_to_program = NULL;
 
@@ -1422,7 +1417,7 @@ void hwss_build_fast_sequence(struct dc *dc,
 				}
 			}
 
-			dc->hwseq->funcs.build_cursor_position(current_pipe, &pos, &param);
+			dc->hwseq->funcs.build_cursor_pos_update_params(current_pipe, &pos, &param);
 
 			block_sequence[*num_steps].params.set_cursor_position_params.dc = dc;
 			block_sequence[*num_steps].params.set_cursor_position_params.hubp = current_pipe->plane_res.hubp;
@@ -4379,11 +4374,11 @@ void hwss_set_cursor_position(union block_sequence_params *params)
 
 void hwss_program_cursor_position(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
-	if (dc->hwseq && dc->hwseq->funcs.build_cursor_position && dc->hwss.set_cursor_position) {
+	if (dc->hwseq && dc->hwseq->funcs.build_cursor_pos_update_params && dc->hwss.set_cursor_position) {
 		struct dc_cursor_position pos;
 		struct dc_cursor_mi_param param;
 
-		dc->hwseq->funcs.build_cursor_position(pipe_ctx, &pos, &param);
+		dc->hwseq->funcs.build_cursor_pos_update_params(pipe_ctx, &pos, &param);
 		dc->hwss.set_cursor_position(pipe_ctx->plane_res.hubp,
 				pipe_ctx->plane_res.dpp, &pos, &param);
 	} else if (dc->hwss.set_cursor_position_legacy) {
@@ -5812,12 +5807,12 @@ void hwss_add_set_cursor_position(struct block_sequence_state *seq_state,
 		struct pipe_ctx *pipe_ctx)
 {
 	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE &&
-			dc->hwseq && dc->hwseq->funcs.build_cursor_position &&
+			dc->hwseq && dc->hwseq->funcs.build_cursor_pos_update_params &&
 			dc->hwss.set_cursor_position) {
 		struct dc_cursor_position pos;
 		struct dc_cursor_mi_param param;
 
-		dc->hwseq->funcs.build_cursor_position(pipe_ctx, &pos, &param);
+		dc->hwseq->funcs.build_cursor_pos_update_params(pipe_ctx, &pos, &param);
 
 		seq_state->steps[*seq_state->num_steps].func = SET_CURSOR_POSITION;
 		seq_state->steps[*seq_state->num_steps].params.set_cursor_position_params.dc = dc;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index ecbd2b4a0c22..549f9885b762 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1049,7 +1049,7 @@ static struct rect calculate_mpc_slice_in_timing_active(
 	return mpc_rec;
 }
 
-static void calculate_adjust_recout_for_visual_confirm(struct pipe_ctx *pipe_ctx,
+static void calculate_adjust_recout_for_visual_confirm(const struct pipe_ctx *pipe_ctx,
 	unsigned int *base_offset, unsigned int *dpp_offset)
 {
 	struct dc *dc = pipe_ctx->stream->ctx->dc;
@@ -1070,7 +1070,7 @@ static void calculate_adjust_recout_for_visual_confirm(struct pipe_ctx *pipe_ctx
 }
 
 static void reverse_adjust_recout_for_visual_confirm(struct rect *recout,
-		struct pipe_ctx *pipe_ctx)
+		const struct pipe_ctx *pipe_ctx)
 {
 	unsigned int dpp_offset, base_offset;
 
@@ -1775,7 +1775,7 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 	return res;
 }
 
-bool resource_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx)
+bool resource_can_pipe_disable_cursor(const struct pipe_ctx *pipe_ctx)
 {
 	struct pipe_ctx *test_pipe, *split_pipe;
 	struct rect r1 = pipe_ctx->plane_res.scl_data.recout;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 613f1f62cd80..884319b22cc1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -3729,7 +3729,7 @@ void dcn10_update_dchub(struct dce_hwseq *hws, struct dchub_init_data *dh_data)
 	hubbub->funcs->update_dchub(hubbub, dh_data);
 }
 
-void dcn10_build_cursor_position(struct pipe_ctx *pipe_ctx,
+void dcn10_build_cursor_pos_update_params(const struct pipe_ctx *pipe_ctx,
 		struct dc_cursor_position *pos_out,
 		struct dc_cursor_mi_param *param_out)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
index 9c4f1186ca9f..383998531503 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
@@ -177,7 +177,7 @@ void dce110_edp_power_control(
 void dce110_edp_wait_for_hpd_ready(
 		struct dc_link *link,
 		bool power_up);
-void dcn10_build_cursor_position(struct pipe_ctx *pipe_ctx,
+void dcn10_build_cursor_pos_update_params(const struct pipe_ctx *pipe_ctx,
 		struct dc_cursor_position *pos,
 		struct dc_cursor_mi_param *param);
 void dcn10_set_cursor_position(struct hubp *hubp, struct dpp *dpp,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
index ddd52722bc49..bc3ac96de688 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_init.c
@@ -94,7 +94,7 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn10_private_funcs = {
-	.build_cursor_position = dcn10_build_cursor_position,
+	.build_cursor_pos_update_params = dcn10_build_cursor_pos_update_params,
 	.init_pipes = dcn10_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.program_pipe = dcn10_program_pipe,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
index 5817fb44d2e0..789bde439192 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_init.c
@@ -107,7 +107,7 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn20_private_funcs = {
-	.build_cursor_position = dcn10_build_cursor_position,
+	.build_cursor_pos_update_params = dcn10_build_cursor_pos_update_params,
 	.init_pipes = dcn10_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
index d421bc813cbd..33c22d9bbd2e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_init.c
@@ -99,7 +99,7 @@ static const struct hw_sequencer_funcs dcn201_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn201_private_funcs = {
-	.build_cursor_position = dcn10_build_cursor_position,
+	.build_cursor_pos_update_params = dcn10_build_cursor_pos_update_params,
 	.init_pipes = NULL,
 	.plane_atomic_disconnect = dcn201_plane_atomic_disconnect,
 	.program_pipe = dcn10_program_pipe,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
index e691e86629c5..39bf0e51ec7c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn21/dcn21_init.c
@@ -110,7 +110,7 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn21_private_funcs = {
-	.build_cursor_position = dcn10_build_cursor_position,
+	.build_cursor_pos_update_params = dcn10_build_cursor_pos_update_params,
 	.init_pipes = dcn10_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
index f7a095796039..ce42b8216f3b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_init.c
@@ -117,7 +117,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn30_private_funcs = {
-	.build_cursor_position = dcn10_build_cursor_position,
+	.build_cursor_pos_update_params = dcn10_build_cursor_pos_update_params,
 	.init_pipes = dcn10_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
index 191245bde1ca..5ed4305e4663 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn301/dcn301_init.c
@@ -113,7 +113,7 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn301_private_funcs = {
-	.build_cursor_position = dcn10_build_cursor_position,
+	.build_cursor_pos_update_params = dcn10_build_cursor_pos_update_params,
 	.init_pipes = dcn10_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
index 5500eb46dedb..c7055312cc3d 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_init.c
@@ -119,7 +119,7 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn31_private_funcs = {
-	.build_cursor_position = dcn10_build_cursor_position,
+	.build_cursor_pos_update_params = dcn10_build_cursor_pos_update_params,
 	.init_pipes = dcn10_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
index b278f58b844d..2b04598b0935 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_init.c
@@ -122,7 +122,7 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn314_private_funcs = {
-	.build_cursor_position = dcn10_build_cursor_position,
+	.build_cursor_pos_update_params = dcn10_build_cursor_pos_update_params,
 	.init_pipes = dcn10_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index 49387de29382..9d3c7b40b21f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -130,7 +130,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn32_private_funcs = {
-	.build_cursor_position = dcn10_build_cursor_position,
+	.build_cursor_pos_update_params = dcn10_build_cursor_pos_update_params,
 	.init_pipes = dcn10_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index e4864b9606ff..b1933a80fc47 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -140,7 +140,7 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn35_private_funcs = {
-	.build_cursor_position = dcn10_build_cursor_position,
+	.build_cursor_pos_update_params = dcn10_build_cursor_pos_update_params,
 	.init_pipes = dcn35_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index f57c0f6adccf..dbd8480b9e05 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -129,7 +129,7 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn351_private_funcs = {
-	.build_cursor_position = dcn10_build_cursor_position,
+	.build_cursor_pos_update_params = dcn10_build_cursor_pos_update_params,
 	.init_pipes = dcn35_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn20_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 98398dac9861..7780f37c615c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1045,7 +1045,7 @@ void dcn401_disable_link_output(struct dc_link *link,
 	dc->link_srv->dp_trace_source_sequence(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
 }
 
-void dcn401_build_cursor_position(struct pipe_ctx *pipe_ctx,
+void dcn401_build_cursor_pos_update_params(const struct pipe_ctx *pipe_ctx,
 		struct dc_cursor_position *pos_out,
 		struct dc_cursor_mi_param *param_out)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index f958ea34a3c6..66a0fc8de8ba 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -55,7 +55,7 @@ void dcn401_disable_link_output(struct dc_link *link,
 		const struct link_resource *link_res,
 		enum signal_type signal);
 
-void dcn401_build_cursor_position(struct pipe_ctx *pipe_ctx,
+void dcn401_build_cursor_pos_update_params(const struct pipe_ctx *pipe_ctx,
 		struct dc_cursor_position *pos,
 		struct dc_cursor_mi_param *param);
 void dcn401_set_cursor_position(struct hubp *hubp, struct dpp *dpp,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index ac5ebe546d0c..2d3c46c4e00c 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -125,7 +125,7 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn401_private_funcs = {
-	.build_cursor_position = dcn401_build_cursor_position,
+	.build_cursor_pos_update_params = dcn401_build_cursor_pos_update_params,
 	.init_pipes = dcn10_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.plane_atomic_disconnect_sequence = dcn401_plane_atomic_disconnect_sequence,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
index eba34f124e39..a28149411821 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn42/dcn42_init.c
@@ -129,7 +129,7 @@ static const struct hw_sequencer_funcs dcn42_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn42_private_funcs = {
-	.build_cursor_position = dcn401_build_cursor_position,
+	.build_cursor_pos_update_params = dcn401_build_cursor_pos_update_params,
 	.init_pipes = dcn35_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.update_mpcc = dcn42_update_mpcc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
index ce0905820f7e..c89051a542cb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn60/dcn60_init.c
@@ -128,7 +128,7 @@ static const struct hw_sequencer_funcs dcn60_funcs = {
 };
 
 static const struct hwseq_private_funcs dcn60_private_funcs = {
-	.build_cursor_position = dcn401_build_cursor_position,
+	.build_cursor_pos_update_params = dcn401_build_cursor_pos_update_params,
 	.init_pipes = dcn10_init_pipes,
 	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
 	.plane_atomic_disconnect_sequence = dcn401_plane_atomic_disconnect_sequence,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index 136c2c2eab1c..9586029dcec1 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -229,7 +229,7 @@ struct hwseq_private_funcs {
 	void (*program_cm_hist)(struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
 		const struct dc_plane_state *plane_state);
-	void (*build_cursor_position)(struct pipe_ctx *pipe_ctx,
+	void (*build_cursor_pos_update_params)(const struct pipe_ctx *pipe_ctx,
 		struct dc_cursor_position *pos,
 		struct dc_cursor_mi_param *param);
 };
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 21a6f90956e8..0d9c9771ea7c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -172,7 +172,7 @@ bool resource_attach_surfaces_to_context(
 		struct dc_state *context,
 		const struct resource_pool *pool);
 
-bool resource_can_pipe_disable_cursor(struct pipe_ctx *pipe_ctx);
+bool resource_can_pipe_disable_cursor(const struct pipe_ctx *pipe_ctx);
 
 #define FREE_PIPE_INDEX_NOT_FOUND -1
 
-- 
2.55.0


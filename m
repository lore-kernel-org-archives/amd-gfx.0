Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06AD0C001DB
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 20:09:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4375910E787;
	Wed,  1 Nov 2023 20:09:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2087.outbound.protection.outlook.com [40.107.237.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1110F10E783
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 20:09:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IS8eYaXH0iECCkxpXDlkplw1r1rWRRdDf8RMKL8nzCGNBYQ6Nf2/q3fpra/Tr9GnsguVfepP/2ETgkKAKo9EbVwFQAhHIhDpmIzxCGSyvvwvnx0IPhBMdwtLwIFi9f05vVJFQnTcn4iIjJDyC56eEVhfNVODIq7h1PKwkB944DixRKxj4osJl12n5cATHNJ5go6ymp9WHvFeLLw59Rvg/WY1nJvf0hSvoTVA7rNGDcJK4IZPG4WMVHlGXeyD+Eb5VDBLeV+cQ0hjeoB5Ikohf5D89mUfrt+pDidRcUshY9ReQXXks9XISEg05eRcHMg6+qBAIF3xZvqNxfS+zgK0Ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Onz4qoOi0qppIqSf1lXsKG+TR3gUSjvmuCZnmBNghMQ=;
 b=aCB2vE4gHTAzk0zxICw76W4BHhtWgmz6yHCIN17j7ob7EqAfQ3Ex0wL+sW72xZojVJyobOo0ucJTb8dSk/r0zpebzsXWC6SUuECUAK/KiMkvI3yoWJe4AxSN68seTQVqxg+VTdgb3JNpvV2M7hYX4iSbQcrqwANqXj6/aGMVyQQ4vLulXhkpcjzxaAev+H1IYX5Eu/vfSeBz0dD+zMAdcDPL/mbSfqtl93gXarcS38CSUrjqPiy3RwK6N0uDjUUKbNXktT8fHdtAlTcNW7QbN/mp2D7IH+RiC+1rseZSU06H8zhzOl4dUVHa7DC8QKl5YWhyvOmDw/IKUB1MFk2USQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Onz4qoOi0qppIqSf1lXsKG+TR3gUSjvmuCZnmBNghMQ=;
 b=4n+P3ZD2Y/dfB0oa5dcNKl/Ai50eghb4byL8SEAKid1iTIcfw0pG2CDH4V5so/hJgqjt/WcVlMJdzCpZ9TtnKM57wdMMQvuXOBcqkgOgxSLxdutpLZSOX4rHMhQKi2Oza5Ha2R8g8AVaNHEl5VG2G+bgyuoG8tmGOxPGUsR9OYY=
Received: from DM6PR08CA0058.namprd08.prod.outlook.com (2603:10b6:5:1e0::32)
 by LV3PR12MB9259.namprd12.prod.outlook.com (2603:10b6:408:1b0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 20:09:09 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::58) by DM6PR08CA0058.outlook.office365.com
 (2603:10b6:5:1e0::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19 via Frontend
 Transport; Wed, 1 Nov 2023 20:09:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 20:09:09 +0000
Received: from SATLEXMB08.amd.com (10.181.40.132) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 15:09:07 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB08.amd.com
 (10.181.40.132) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 13:09:06 -0700
Received: from hersenwu-Majolica-CZN.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Wed, 1 Nov 2023 15:09:05 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/12] drm/amd/display: Fix handling duplicate planes on one
 stream
Date: Wed, 1 Nov 2023 16:08:31 -0400
Message-ID: <20231101200832.995436-12-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231101200832.995436-1-hersenxs.wu@amd.com>
References: <20231101200832.995436-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|LV3PR12MB9259:EE_
X-MS-Office365-Filtering-Correlation-Id: b273ef18-cd22-4718-e10f-08dbdb1668d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Foj3MJ2Lgwx5umqgTDtJucaV8D5gianNz77B4zHFTlh9eOPGWdv+9LJtLxuwGYgDlw1Vj4i2D99wlwI0a390KsTQbS853qI6Y0wjVMYHWDWdP6dt2tp2CdjCtk0DPct153DEccuQe+8s+qjv1xmXT4iQRA/PwOOSt2XBDQ2tGbHbUcgLyfUNY1B1m1podTxPzOsmL1JJryGrAVa2+fcZ1VewCU6DuUGLc6Y55JThtYw5gTmHTn9OwwvKTWqHmG7U6v+8fT3en8rN8kg7M8nGyBPTurIlc6XYG+071HNuxaRxMMjIAugTrla+XUcrbQ7Dc5uwoUHk4AY0zkWGHqqftucBY8PdTRgn3js9GOZWLN4lxHbcPCPDW/9blTYqmzrDD1JLIKu1nyFnoX7aND6vMSE1KdJkzITNhKspDO7NsyZ0ke1WWOcf4beJoC4hKwotg3cs3duqOaqHQwZ8gmlbvWv68hIcNMKH8knUVgBoQzrcmMqhfhQ+LbNvNjMElxz87Wj213eVRKKreERQukBhGfrqKDdOrcu9ZP6ifXTJsWMqRLuR4aRGrvp5y5F7MGVwPLHhEb+/qPMKQSq89L1A25fl5GqImQCFPmRlagimmMBnfizfQnz6PIKLre+DQik9ip8WQRm7M0WNoQ5tf9/sY4HEbtdiK7wcuZGdaZeUQle0lYk4uXPsyXTlaa52BY3MmH+87zLS8C2+Y4Wm6IvNi/njEa5G6Ogdwr3TT7+sNGkxjfuYJNgl2yetfss6bhuvwPgCDivekeK1lJAAjczTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(82310400011)(1800799009)(186009)(46966006)(40470700004)(36840700001)(40480700001)(1076003)(26005)(2616005)(40460700003)(36756003)(356005)(86362001)(82740400003)(30864003)(81166007)(5660300002)(2906002)(83380400001)(7696005)(36860700001)(336012)(478600001)(47076005)(426003)(4326008)(6666004)(8936002)(8676002)(316002)(54906003)(41300700001)(70206006)(6916009)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 20:09:09.4658 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b273ef18-cd22-4718-e10f-08dbdb1668d2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9259
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
Cc: stylon.wang@amd.com, chiahsuan.chung@amd.com, Sunpeng.Li@amd.com,
 Sung Joon Kim <sungkim@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hersenxs.wu@amd.com,
 wayne.lin@amd.com, Xi Liu <xi.liu@amd.com>, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

[why]
DML2 does not handle the case when we have
a single stream sourcing 2 or more planes
that are duplicates of one another. To properly
handle this scenario, pipe index to plane index
mapping is used to decide which plane is being
processed and programmed.

[how]
Create static array of pipe index to plane index map.
Populate the array properly and use in appropriate places.

Reviewed-by: Xi (Alex) Liu <xi.liu@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   | 45 ++++++++++------
 .../amd/display/dc/dml2/dml2_internal_types.h |  3 ++
 .../display/dc/dml2/dml2_translation_helper.c | 54 ++++++++++++++++---
 .../display/dc/dml2/dml2_translation_helper.h |  2 +-
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  | 18 ++++---
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  2 +-
 6 files changed, 90 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index 82a1152e18b5..1a2b24cc6b61 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -55,10 +55,11 @@ struct dc_pipe_mapping_scratch {
 	struct dc_plane_pipe_pool pipe_pool;
 };
 
-static bool get_plane_id(const struct dc_state *state, const struct dc_plane_state *plane,
-	unsigned int stream_id, unsigned int *plane_id)
+static bool get_plane_id(struct dml2_context *dml2, const struct dc_state *state, const struct dc_plane_state *plane,
+	unsigned int stream_id, unsigned int plane_index, unsigned int *plane_id)
 {
 	int i, j;
+	bool is_plane_duplicate = dml2->v20.scratch.plane_duplicate_exists;
 
 	if (!plane_id)
 		return false;
@@ -66,7 +67,8 @@ static bool get_plane_id(const struct dc_state *state, const struct dc_plane_sta
 	for (i = 0; i < state->stream_count; i++) {
 		if (state->streams[i]->stream_id == stream_id) {
 			for (j = 0; j < state->stream_status[i].plane_count; j++) {
-				if (state->stream_status[i].plane_states[j] == plane) {
+				if (state->stream_status[i].plane_states[j] == plane &&
+					(!is_plane_duplicate || (is_plane_duplicate && (j == plane_index)))) {
 					*plane_id = (i << 16) | j;
 					return true;
 				}
@@ -123,8 +125,9 @@ static struct pipe_ctx *find_master_pipe_of_plane(struct dml2_context *ctx,
 	unsigned int plane_id_assigned_to_pipe;
 
 	for (i = 0; i < ctx->config.dcn_pipe_count; i++) {
-		if (state->res_ctx.pipe_ctx[i].plane_state && get_plane_id(state, state->res_ctx.pipe_ctx[i].plane_state,
-			state->res_ctx.pipe_ctx[i].stream->stream_id, &plane_id_assigned_to_pipe)) {
+		if (state->res_ctx.pipe_ctx[i].plane_state && get_plane_id(ctx, state, state->res_ctx.pipe_ctx[i].plane_state,
+			state->res_ctx.pipe_ctx[i].stream->stream_id,
+			ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_index[state->res_ctx.pipe_ctx[i].pipe_idx], &plane_id_assigned_to_pipe)) {
 			if (plane_id_assigned_to_pipe == plane_id)
 				return &state->res_ctx.pipe_ctx[i];
 		}
@@ -141,8 +144,9 @@ static unsigned int find_pipes_assigned_to_plane(struct dml2_context *ctx,
 	unsigned int plane_id_assigned_to_pipe;
 
 	for (i = 0; i < ctx->config.dcn_pipe_count; i++) {
-		if (state->res_ctx.pipe_ctx[i].plane_state && get_plane_id(state, state->res_ctx.pipe_ctx[i].plane_state,
-			state->res_ctx.pipe_ctx[i].stream->stream_id, &plane_id_assigned_to_pipe)) {
+		if (state->res_ctx.pipe_ctx[i].plane_state && get_plane_id(ctx, state, state->res_ctx.pipe_ctx[i].plane_state,
+			state->res_ctx.pipe_ctx[i].stream->stream_id,
+			ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_index[state->res_ctx.pipe_ctx[i].pipe_idx], &plane_id_assigned_to_pipe)) {
 			if (plane_id_assigned_to_pipe == plane_id)
 				pipes[num_found++] = i;
 		}
@@ -609,6 +613,7 @@ static struct pipe_ctx *assign_pipes_to_plane(struct dml2_context *ctx, struct d
 		const struct dc_plane_state *plane,
 		int odm_factor,
 		int mpc_factor,
+		int plane_index,
 		struct dc_plane_pipe_pool *pipe_pool,
 		const struct dc_state *existing_state)
 {
@@ -620,7 +625,7 @@ static struct pipe_ctx *assign_pipes_to_plane(struct dml2_context *ctx, struct d
 	unsigned int next_pipe_to_assign;
 	int odm_slice, mpc_slice;
 
-	if (!get_plane_id(state, plane, stream->stream_id, &plane_id)) {
+	if (!get_plane_id(ctx, state, plane, stream->stream_id, plane_index, &plane_id)) {
 		ASSERT(false);
 		return master_pipe;
 	}
@@ -667,12 +672,16 @@ static void free_pipe(struct pipe_ctx *pipe)
 }
 
 static void free_unused_pipes_for_plane(struct dml2_context *ctx, struct dc_state *state,
-	const struct dc_plane_state *plane, const struct dc_plane_pipe_pool *pool, unsigned int stream_id)
+	const struct dc_plane_state *plane, const struct dc_plane_pipe_pool *pool, unsigned int stream_id, int plane_index)
 {
 	int i;
+	bool is_plane_duplicate = ctx->v20.scratch.plane_duplicate_exists;
+
 	for (i = 0; i < ctx->config.dcn_pipe_count; i++) {
 		if (state->res_ctx.pipe_ctx[i].plane_state == plane &&
 			state->res_ctx.pipe_ctx[i].stream->stream_id == stream_id &&
+			(!is_plane_duplicate || (is_plane_duplicate &&
+			ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_index[state->res_ctx.pipe_ctx[i].pipe_idx] == plane_index)) &&
 			!is_pipe_used(pool, state->res_ctx.pipe_ctx[i].pipe_idx)) {
 			free_pipe(&state->res_ctx.pipe_ctx[i]);
 		}
@@ -717,19 +726,20 @@ static void map_pipes_for_stream(struct dml2_context *ctx, struct dc_state *stat
 }
 
 static void map_pipes_for_plane(struct dml2_context *ctx, struct dc_state *state, const struct dc_stream_state *stream, const struct dc_plane_state *plane,
-		struct dc_pipe_mapping_scratch *scratch, const struct dc_state *existing_state)
+		int plane_index, struct dc_pipe_mapping_scratch *scratch, const struct dc_state *existing_state)
 {
 	int odm_slice_index;
 	unsigned int plane_id;
 	struct pipe_ctx *master_pipe = NULL;
 	int i;
 
-	if (!get_plane_id(state, plane, stream->stream_id, &plane_id)) {
+	if (!get_plane_id(ctx, state, plane, stream->stream_id, plane_index, &plane_id)) {
 		ASSERT(false);
 		return;
 	}
 
-	master_pipe = assign_pipes_to_plane(ctx, state, stream, plane, scratch->odm_info.odm_factor, scratch->mpc_info.mpc_factor, &scratch->pipe_pool, existing_state);
+	master_pipe = assign_pipes_to_plane(ctx, state, stream, plane, scratch->odm_info.odm_factor,
+			scratch->mpc_info.mpc_factor, plane_index, &scratch->pipe_pool, existing_state);
 	sort_pipes_for_splitting(&scratch->pipe_pool);
 
 	for (odm_slice_index = 0; odm_slice_index < scratch->odm_info.odm_factor; odm_slice_index++) {
@@ -755,7 +765,7 @@ static void map_pipes_for_plane(struct dml2_context *ctx, struct dc_state *state
 		}
 	}
 
-	free_unused_pipes_for_plane(ctx, state, plane, &scratch->pipe_pool, stream->stream_id);
+	free_unused_pipes_for_plane(ctx, state, plane, &scratch->pipe_pool, stream->stream_id, plane_index);
 }
 
 static unsigned int get_mpc_factor(struct dml2_context *ctx,
@@ -768,7 +778,7 @@ static unsigned int get_mpc_factor(struct dml2_context *ctx,
 	unsigned int plane_id;
 	unsigned int cfg_idx;
 
-	get_plane_id(state, status->plane_states[plane_idx], stream_id, &plane_id);
+	get_plane_id(ctx, state, status->plane_states[plane_idx], stream_id, plane_idx, &plane_id);
 	cfg_idx = find_disp_cfg_idx_by_plane_id(mapping, plane_id);
 	if (ctx->architecture == dml2_architecture_20)
 		return (unsigned int)disp_cfg->hw.DPPPerSurface[cfg_idx];
@@ -946,8 +956,8 @@ bool dml2_map_dc_pipes(struct dml2_context *ctx, struct dc_state *state, const s
 
 		for (plane_index = 0; plane_index < state->stream_status[stream_index].plane_count; plane_index++) {
 			// Planes are ordered top to bottom.
-			if (get_plane_id(state, state->stream_status[stream_index].plane_states[plane_index],
-				stream_id, &plane_id)) {
+			if (get_plane_id(ctx, state, state->stream_status[stream_index].plane_states[plane_index],
+				stream_id, plane_index, &plane_id)) {
 				plane_disp_cfg_index = find_disp_cfg_idx_by_plane_id(mapping, plane_id);
 
 				// Setup mpc_info for this plane
@@ -971,7 +981,8 @@ bool dml2_map_dc_pipes(struct dml2_context *ctx, struct dc_state *state, const s
 				// Clear the pool assignment scratch (which is per plane)
 				memset(&scratch.pipe_pool, 0, sizeof(struct dc_plane_pipe_pool));
 
-				map_pipes_for_plane(ctx, state, state->streams[stream_index], state->stream_status[stream_index].plane_states[plane_index], &scratch, existing_state);
+				map_pipes_for_plane(ctx, state, state->streams[stream_index],
+					state->stream_status[stream_index].plane_states[plane_index], plane_index, &scratch, existing_state);
 			} else {
 				// Plane ID cannot be generated, therefore no DML mapping can be performed.
 				ASSERT(false);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h
index df46a866f801..1cf8a884c0fb 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h
@@ -75,6 +75,8 @@ struct dml2_dml_to_dc_pipe_mapping {
 	bool dml_pipe_idx_to_stream_id_valid[__DML2_WRAPPER_MAX_STREAMS_PLANES__];
 	unsigned int dml_pipe_idx_to_plane_id[__DML2_WRAPPER_MAX_STREAMS_PLANES__];
 	bool dml_pipe_idx_to_plane_id_valid[__DML2_WRAPPER_MAX_STREAMS_PLANES__];
+	unsigned int dml_pipe_idx_to_plane_index[__DML2_WRAPPER_MAX_STREAMS_PLANES__];
+	bool dml_pipe_idx_to_plane_index_valid[__DML2_WRAPPER_MAX_STREAMS_PLANES__];
 };
 
 struct dml2_wrapper_scratch {
@@ -96,6 +98,7 @@ struct dml2_wrapper_scratch {
 
 	struct dml2_dml_to_dc_pipe_mapping dml_to_dc_pipe_mapping;
 	bool enable_flexible_pipe_mapping;
+	bool plane_duplicate_exists;
 };
 
 struct dml2_helper_det_policy_scratch {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index 159a0956893f..75171bee6f71 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -931,10 +931,11 @@ static unsigned int map_stream_to_dml_display_cfg(const struct dml2_context *dml
 	return location;
 }
 
-static bool get_plane_id(const struct dc_state *context, const struct dc_plane_state *plane,
-		unsigned int stream_id, unsigned int *plane_id)
+static bool get_plane_id(struct dml2_context *dml2, const struct dc_state *context, const struct dc_plane_state *plane,
+		unsigned int stream_id, unsigned int plane_index, unsigned int *plane_id)
 {
 	int i, j;
+	bool is_plane_duplicate = dml2->v20.scratch.plane_duplicate_exists;
 
 	if (!plane_id)
 		return false;
@@ -942,7 +943,8 @@ static bool get_plane_id(const struct dc_state *context, const struct dc_plane_s
 	for (i = 0; i < context->stream_count; i++) {
 		if (context->streams[i]->stream_id == stream_id) {
 			for (j = 0; j < context->stream_status[i].plane_count; j++) {
-				if (context->stream_status[i].plane_states[j] == plane) {
+				if (context->stream_status[i].plane_states[j] == plane &&
+					(!is_plane_duplicate || (is_plane_duplicate && (j == plane_index)))) {
 					*plane_id = (i << 16) | j;
 					return true;
 				}
@@ -954,13 +956,13 @@ static bool get_plane_id(const struct dc_state *context, const struct dc_plane_s
 }
 
 static unsigned int map_plane_to_dml_display_cfg(const struct dml2_context *dml2, const struct dc_plane_state *plane,
-		const struct dc_state *context, const struct dml_display_cfg_st *dml_dispcfg, unsigned int stream_id)
+		const struct dc_state *context, const struct dml_display_cfg_st *dml_dispcfg, unsigned int stream_id, int plane_index)
 {
 	unsigned int plane_id;
 	int i = 0;
 	int location = -1;
 
-	if (!get_plane_id(context, plane, stream_id, &plane_id)) {
+	if (!get_plane_id(context->bw_ctx.dml2, context, plane, stream_id, plane_index, &plane_id)) {
 		ASSERT(false);
 		return -1;
 	}
@@ -991,7 +993,41 @@ static void apply_legacy_svp_drr_settings(struct dml2_context *dml2, const struc
 	}
 }
 
-void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, const struct dc_state *context, struct dml_display_cfg_st *dml_dispcfg)
+static void dml2_populate_pipe_to_plane_index_mapping(struct dml2_context *dml2, struct dc_state *state)
+{
+	unsigned int i;
+	unsigned int pipe_index = 0;
+	unsigned int plane_index = 0;
+	struct dml2_dml_to_dc_pipe_mapping *dml_to_dc_pipe_mapping = &dml2->v20.scratch.dml_to_dc_pipe_mapping;
+
+	for (i = 0; i < __DML2_WRAPPER_MAX_STREAMS_PLANES__; i++) {
+		dml_to_dc_pipe_mapping->dml_pipe_idx_to_plane_index_valid[i] = false;
+		dml_to_dc_pipe_mapping->dml_pipe_idx_to_plane_index[i] = 0;
+	}
+
+	for (i = 0; i < __DML2_WRAPPER_MAX_STREAMS_PLANES__; i++) {
+		struct pipe_ctx *pipe = &state->res_ctx.pipe_ctx[i];
+
+		if (!pipe || !pipe->stream || !pipe->plane_state)
+			continue;
+
+		while (pipe) {
+			pipe_index = pipe->pipe_idx;
+
+			if (pipe->stream && dml_to_dc_pipe_mapping->dml_pipe_idx_to_plane_index_valid[pipe_index] == false) {
+				dml_to_dc_pipe_mapping->dml_pipe_idx_to_plane_index[pipe_index] = plane_index;
+				plane_index++;
+				dml_to_dc_pipe_mapping->dml_pipe_idx_to_plane_index_valid[pipe_index] = true;
+			}
+
+			pipe = pipe->bottom_pipe;
+		}
+
+		plane_index = 0;
+	}
+}
+
+void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_state *context, struct dml_display_cfg_st *dml_dispcfg)
 {
 	int i = 0, j = 0;
 	int disp_cfg_stream_location, disp_cfg_plane_location;
@@ -1008,6 +1044,8 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, const struct d
 	dml_dispcfg->plane.GPUVMMaxPageTableLevels = 4;
 	dml_dispcfg->plane.HostVMEnable = false;
 
+	dml2_populate_pipe_to_plane_index_mapping(dml2, context);
+
 	for (i = 0; i < context->stream_count; i++) {
 		disp_cfg_stream_location = map_stream_to_dml_display_cfg(dml2, context->streams[i], dml_dispcfg);
 
@@ -1044,7 +1082,7 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, const struct d
 		} else {
 			for (j = 0; j < context->stream_status[i].plane_count; j++) {
 				disp_cfg_plane_location = map_plane_to_dml_display_cfg(dml2,
-					context->stream_status[i].plane_states[j], context, dml_dispcfg, context->streams[i]->stream_id);
+					context->stream_status[i].plane_states[j], context, dml_dispcfg, context->streams[i]->stream_id, j);
 
 				if (disp_cfg_plane_location < 0)
 					disp_cfg_plane_location = dml_dispcfg->num_surfaces++;
@@ -1068,7 +1106,7 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, const struct d
 
 				dml_dispcfg->plane.BlendingAndTiming[disp_cfg_plane_location] = disp_cfg_stream_location;
 
-				if (get_plane_id(context, context->stream_status[i].plane_states[j], context->streams[i]->stream_id,
+				if (get_plane_id(dml2, context, context->stream_status[i].plane_states[j], context->streams[i]->stream_id, j,
 					&dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id[disp_cfg_plane_location]))
 					dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id_valid[disp_cfg_plane_location] = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.h
index dac6d27b14cd..d764773938f4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.h
@@ -34,7 +34,7 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 void dml2_translate_ip_params(const struct dc *in_dc, struct ip_params_st *out);
 void dml2_translate_socbb_params(const struct dc *in_dc, struct soc_bounding_box_st *out);
 void dml2_translate_soc_states(const struct dc *in_dc, struct soc_states_st *out, int num_states);
-void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, const struct dc_state *context, struct dml_display_cfg_st *dml_dispcfg);
+void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_state *context, struct dml_display_cfg_st *dml_dispcfg);
 void dml2_update_pipe_ctx_dchub_regs(struct _vcs_dpi_dml_display_rq_regs_st *rq_regs, struct _vcs_dpi_dml_display_dlg_regs_st *disp_dlg_regs, struct _vcs_dpi_dml_display_ttu_regs_st *disp_ttu_regs, struct pipe_ctx *out);
 bool is_dp2p0_output_encoder(const struct pipe_ctx *pipe);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index 69fd96f4f3b0..2498b8341199 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -209,10 +209,11 @@ static int find_dml_pipe_idx_by_plane_id(struct dml2_context *ctx, unsigned int
 	return -1;
 }
 
-static bool get_plane_id(const struct dc_state *state, const struct dc_plane_state *plane,
-	unsigned int stream_id, unsigned int *plane_id)
+static bool get_plane_id(struct dml2_context *dml2, const struct dc_state *state, const struct dc_plane_state *plane,
+	unsigned int stream_id, unsigned int plane_index, unsigned int *plane_id)
 {
 	int i, j;
+	bool is_plane_duplicate = dml2->v20.scratch.plane_duplicate_exists;
 
 	if (!plane_id)
 		return false;
@@ -220,7 +221,8 @@ static bool get_plane_id(const struct dc_state *state, const struct dc_plane_sta
 	for (i = 0; i < state->stream_count; i++) {
 		if (state->streams[i]->stream_id == stream_id) {
 			for (j = 0; j < state->stream_status[i].plane_count; j++) {
-				if (state->stream_status[i].plane_states[j] == plane) {
+				if (state->stream_status[i].plane_states[j] == plane &&
+					(!is_plane_duplicate || (is_plane_duplicate && (j == plane_index)))) {
 					*plane_id = (i << 16) | j;
 					return true;
 				}
@@ -304,8 +306,9 @@ void dml2_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_state *cont
 		 * there is a need to know which DML pipe index maps to which DC pipe. The code below
 		 * finds a dml_pipe_index from the plane id if a plane is valid. If a plane is not valid then
 		 * it finds a dml_pipe_index from the stream id. */
-		if (get_plane_id(context, context->res_ctx.pipe_ctx[dc_pipe_ctx_index].plane_state,
-			context->res_ctx.pipe_ctx[dc_pipe_ctx_index].stream->stream_id, &plane_id)) {
+		if (get_plane_id(in_ctx, context, context->res_ctx.pipe_ctx[dc_pipe_ctx_index].plane_state,
+			context->res_ctx.pipe_ctx[dc_pipe_ctx_index].stream->stream_id,
+			in_ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_index[context->res_ctx.pipe_ctx[dc_pipe_ctx_index].pipe_idx], &plane_id)) {
 			dml_pipe_idx = find_dml_pipe_idx_by_plane_id(in_ctx, plane_id);
 		} else {
 			dml_pipe_idx = dml2_helper_find_dml_pipe_idx_by_stream_id(in_ctx, context->res_ctx.pipe_ctx[dc_pipe_ctx_index].stream->stream_id);
@@ -445,8 +448,9 @@ bool dml2_verify_det_buffer_configuration(struct dml2_context *in_ctx, struct dc
 	for (i = 0; i < MAX_PIPES; i++) {
 		if (!display_state->res_ctx.pipe_ctx[i].stream)
 			continue;
-		if (get_plane_id(display_state, display_state->res_ctx.pipe_ctx[i].plane_state,
-			display_state->res_ctx.pipe_ctx[i].stream->stream_id, &plane_id))
+		if (get_plane_id(in_ctx, display_state, display_state->res_ctx.pipe_ctx[i].plane_state,
+			display_state->res_ctx.pipe_ctx[i].stream->stream_id,
+			in_ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_index[display_state->res_ctx.pipe_ctx[i].pipe_idx], &plane_id))
 			dml_pipe_idx = find_dml_pipe_idx_by_plane_id(in_ctx, plane_id);
 		else
 			dml_pipe_idx = dml2_helper_find_dml_pipe_idx_by_stream_id(in_ctx, display_state->res_ctx.pipe_ctx[i].stream->stream_id);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 0a06bf3b135a..8f231418870f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -639,7 +639,7 @@ static bool dml2_validate_and_build_resource(const struct dc *in_dc, struct dc_s
 	return result;
 }
 
-static bool dml2_validate_only(const struct dc_state *context)
+static bool dml2_validate_only(struct dc_state *context)
 {
 	struct dml2_context *dml2 = context->bw_ctx.dml2;
 	unsigned int result = 0;
-- 
2.25.1


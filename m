Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97343C4167D
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Nov 2023 20:09:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F395710E780;
	Wed,  1 Nov 2023 20:09:02 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2084.outbound.protection.outlook.com [40.107.94.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43D1910E77C
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Nov 2023 20:09:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJMDaAlhFnzwiez06Wxbmaz5bxJji9qSkBH4ARIH8BRQCIEooIgV5ow44IKi6cNjY3E4sd+VH6pkCbszBe2my07xHMR9+LA9vHf53dyGbjzifIqGCk0dym1Ekn6ySPx7sv+qLwvNCh+fTjt7kd3vFjplI7fGl9dpqmg78a94hgZym61cUnL98D2dhJy/5PVgRnrm4UCdnUy+h91G5+wcT3h/hNgwKZaYdHYDKvoPGJBbjADDdSH8yLl8F4HFEgDt3QZ3wfVGbXa37E+ZJckqWV0AlcpKUhthf3fnXjSuOfuQBzBu3lzc+cWPMn42E4KZqrEALyEUacyz4jC4kSEibw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGPRmT3/ryxaVhPEg9oZ6TwV7sznwqRxIuR6RSpNJ3Q=;
 b=BFc7qvIbXyYUnPWhZ6VZiY7ZBi7iiZyrsqdlEKlrEdHNnCpRIXSrMLqdvpQaqSiq6bKl1HooueJkz4oh1QMT6AFNYm0PBhDXGehmM3I4W2pjQHPQ4iJgY2AxBXw/TtRWiRCX+vcEXRluTa8sxxH5CIkzQCYAR9/Mup79Rw63BQLIikXCImBVJguv7IUae/EXY6o2CCgEqd8Ihn0qkO41T3mRGonxYN14OY11E7YpG0XdBrvs8Jq7fUUBvUEv8CsOYWG5aI7u031zGsZs7PdCgwtJ+EbIYTCi/NRz6bTBxhXQVOcK+c3IILHpKuEjCCAfIZdW5My50PWydLq4cvp1RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGPRmT3/ryxaVhPEg9oZ6TwV7sznwqRxIuR6RSpNJ3Q=;
 b=z3hal7HGexR1UZwv1dFeD8Rl6KnG5QTZTCnVi2Kc0smpz9WfdhIDHdygJBGur/k6aEHqFsZSpavYo8KiRxXPLR/tyZFr7UXDbCIlruE8cblmRbQSMKWSHOVVVSBLZllJt5uuajTSA09rmmAgSy2TwhZlhTQHiKHa0oX6G4Xo1mw=
Received: from DM6PR08CA0061.namprd08.prod.outlook.com (2603:10b6:5:1e0::35)
 by DM6PR12MB4354.namprd12.prod.outlook.com (2603:10b6:5:28f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.19; Wed, 1 Nov
 2023 20:08:57 +0000
Received: from DS2PEPF00003442.namprd04.prod.outlook.com
 (2603:10b6:5:1e0:cafe::da) by DM6PR08CA0061.outlook.office365.com
 (2603:10b6:5:1e0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.29 via Frontend
 Transport; Wed, 1 Nov 2023 20:08:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS2PEPF00003442.mail.protection.outlook.com (10.167.17.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6954.19 via Frontend Transport; Wed, 1 Nov 2023 20:08:56 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 15:08:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Wed, 1 Nov
 2023 15:08:53 -0500
Received: from hersenwu-Majolica-CZN.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32
 via Frontend Transport; Wed, 1 Nov 2023 15:08:52 -0500
From: Hersen Wu <hersenxs.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/12] drm/amd/display: Revert Fix handling duplicate planes
 on one stream
Date: Wed, 1 Nov 2023 16:08:25 -0400
Message-ID: <20231101200832.995436-6-hersenxs.wu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231101200832.995436-1-hersenxs.wu@amd.com>
References: <20231101200832.995436-1-hersenxs.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003442:EE_|DM6PR12MB4354:EE_
X-MS-Office365-Filtering-Correlation-Id: 3510290b-a583-466a-edde-08dbdb166161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FHsZW9s7URvhuMUoT2Z1VxEFRz0lkIsxmkFAPCeTXxUC7Hfem0uSLWir3VRPCOeFTzejbMSViuCcs1oIuNiw7GI8px6UU7GoCS4bkHeq/Ij/y7MoNu4ERnrSULfUuSN4Z9hP5hRFpFvv5kvR6YbpjTa3udccIwa/GN8hpUPbRB0Ihmf8DdpRhUnxhjxrTxvdadL56iKJOAQcdO8mTXMyNxzju2T7AUL0MTrvixIIDzsZabV8wO+DZ5im5IpWbDe2t0x25tBhGORY3gpF+CnacEZx7Bpu8wEl4oTgY3dTfA5tEyXmCHgM7CJrZ9b6vNkDXnZpcOCn+HfO0WGauynqMD6pdy1uEN1wyN2ngkkmuCcSPlBO4bBVBhZbUJSroOeX7bLYEC7BsyJPCH82DyaLlvBV0fQyHL/tDOnsxRUXfNr/3XNlR/HqcD/SWebWylSrhjRxrNdflktbp9rD6uDK26L4sEo6BUwZeBs1mMpziydJOWFgR46GtKloE/npO29If78fg90PjYmsiGdDyHEvgO55YrsOP0BcivPYtmVfiFHouSYkVG5UzOd1tmQf52o7cbdCOqCuKNh2cnwMHPeFxEw7BKJ7DPdJtfcfzFDC57kQQGZMrfe8h2fTsqsktPBxF58TeplioIOCTG/lwJ7ddY9CRfi8ZIYHVR/zHEzpSbnU4pCvM5lwOgB2y683EUUYv3J2SSme5J77Y4iLV/iVLA7L8DPkmh5wrg9jkzbHWUaJCkpLKac7S1KW53jStlY2MorXmMORQLunoyV1UzbehQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(39860400002)(396003)(376002)(346002)(230922051799003)(1800799009)(64100799003)(82310400011)(451199024)(186009)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(47076005)(36860700001)(5660300002)(41300700001)(2616005)(1076003)(2906002)(30864003)(86362001)(8676002)(426003)(8936002)(4326008)(82740400003)(83380400001)(36756003)(356005)(26005)(81166007)(70206006)(336012)(7696005)(478600001)(6666004)(316002)(6916009)(54906003)(70586007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Nov 2023 20:08:56.9503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3510290b-a583-466a-edde-08dbdb166161
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003442.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4354
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Sung Joon Kim <sungkim@amd.com>, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

This reverts commit 2b30049e735fce887108ed4d01726c4daf69ed3d

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Hersen Wu <hersenxs.wu@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
Signed-off-by: Hersen Wu <hersenxs.wu@amd.com>
---
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   | 45 ++++-------
 .../amd/display/dc/dml2/dml2_internal_types.h |  3 -
 .../display/dc/dml2/dml2_translation_helper.c | 78 ++-----------------
 .../display/dc/dml2/dml2_translation_helper.h |  2 +-
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  | 18 ++---
 .../drm/amd/display/dc/dml2/dml2_wrapper.c    |  2 +-
 6 files changed, 34 insertions(+), 114 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index 38cfea3ea755..d2046e770c50 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -55,11 +55,10 @@ struct dc_pipe_mapping_scratch {
 	struct dc_plane_pipe_pool pipe_pool;
 };
 
-static bool get_plane_id(struct dml2_context *dml2, const struct dc_state *state, const struct dc_plane_state *plane,
-	unsigned int stream_id, unsigned int plane_index, unsigned int *plane_id)
+static bool get_plane_id(const struct dc_state *state, const struct dc_plane_state *plane,
+	unsigned int stream_id, unsigned int *plane_id)
 {
 	int i, j;
-	bool is_plane_duplicate = dml2->v20.scratch.plane_duplicate_exists;
 
 	if (!plane_id)
 		return false;
@@ -67,8 +66,7 @@ static bool get_plane_id(struct dml2_context *dml2, const struct dc_state *state
 	for (i = 0; i < state->stream_count; i++) {
 		if (state->streams[i]->stream_id == stream_id) {
 			for (j = 0; j < state->stream_status[i].plane_count; j++) {
-				if (state->stream_status[i].plane_states[j] == plane &&
-					(!is_plane_duplicate || (is_plane_duplicate && (j == plane_index)))) {
+				if (state->stream_status[i].plane_states[j] == plane) {
 					*plane_id = (i << 16) | j;
 					return true;
 				}
@@ -125,9 +123,8 @@ static struct pipe_ctx *find_master_pipe_of_plane(struct dml2_context *ctx,
 	unsigned int plane_id_assigned_to_pipe;
 
 	for (i = 0; i < ctx->config.dcn_pipe_count; i++) {
-		if (state->res_ctx.pipe_ctx[i].plane_state && get_plane_id(ctx, state, state->res_ctx.pipe_ctx[i].plane_state,
-			state->res_ctx.pipe_ctx[i].stream->stream_id,
-			ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_index[state->res_ctx.pipe_ctx[i].pipe_idx], &plane_id_assigned_to_pipe)) {
+		if (state->res_ctx.pipe_ctx[i].plane_state && get_plane_id(state, state->res_ctx.pipe_ctx[i].plane_state,
+			state->res_ctx.pipe_ctx[i].stream->stream_id, &plane_id_assigned_to_pipe)) {
 			if (plane_id_assigned_to_pipe == plane_id)
 				return &state->res_ctx.pipe_ctx[i];
 		}
@@ -144,9 +141,8 @@ static unsigned int find_pipes_assigned_to_plane(struct dml2_context *ctx,
 	unsigned int plane_id_assigned_to_pipe;
 
 	for (i = 0; i < ctx->config.dcn_pipe_count; i++) {
-		if (state->res_ctx.pipe_ctx[i].plane_state && get_plane_id(ctx, state, state->res_ctx.pipe_ctx[i].plane_state,
-			state->res_ctx.pipe_ctx[i].stream->stream_id,
-			ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_index[state->res_ctx.pipe_ctx[i].pipe_idx], &plane_id_assigned_to_pipe)) {
+		if (state->res_ctx.pipe_ctx[i].plane_state && get_plane_id(state, state->res_ctx.pipe_ctx[i].plane_state,
+			state->res_ctx.pipe_ctx[i].stream->stream_id, &plane_id_assigned_to_pipe)) {
 			if (plane_id_assigned_to_pipe == plane_id)
 				pipes[num_found++] = i;
 		}
@@ -613,7 +609,6 @@ static struct pipe_ctx *assign_pipes_to_plane(struct dml2_context *ctx, struct d
 		const struct dc_plane_state *plane,
 		int odm_factor,
 		int mpc_factor,
-		int plane_index,
 		struct dc_plane_pipe_pool *pipe_pool,
 		const struct dc_state *existing_state)
 {
@@ -625,7 +620,7 @@ static struct pipe_ctx *assign_pipes_to_plane(struct dml2_context *ctx, struct d
 	unsigned int next_pipe_to_assign;
 	int odm_slice, mpc_slice;
 
-	if (!get_plane_id(ctx, state, plane, stream->stream_id, plane_index, &plane_id)) {
+	if (!get_plane_id(state, plane, stream->stream_id, &plane_id)) {
 		ASSERT(false);
 		return master_pipe;
 	}
@@ -672,16 +667,12 @@ static void free_pipe(struct pipe_ctx *pipe)
 }
 
 static void free_unused_pipes_for_plane(struct dml2_context *ctx, struct dc_state *state,
-	const struct dc_plane_state *plane, const struct dc_plane_pipe_pool *pool, unsigned int stream_id, int plane_index)
+	const struct dc_plane_state *plane, const struct dc_plane_pipe_pool *pool, unsigned int stream_id)
 {
 	int i;
-	bool is_plane_duplicate = ctx->v20.scratch.plane_duplicate_exists;
-
 	for (i = 0; i < ctx->config.dcn_pipe_count; i++) {
 		if (state->res_ctx.pipe_ctx[i].plane_state == plane &&
 			state->res_ctx.pipe_ctx[i].stream->stream_id == stream_id &&
-			(!is_plane_duplicate || (is_plane_duplicate &&
-			ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_index[state->res_ctx.pipe_ctx[i].pipe_idx] == plane_index)) &&
 			!is_pipe_used(pool, state->res_ctx.pipe_ctx[i].pipe_idx)) {
 			free_pipe(&state->res_ctx.pipe_ctx[i]);
 		}
@@ -726,20 +717,19 @@ static void map_pipes_for_stream(struct dml2_context *ctx, struct dc_state *stat
 }
 
 static void map_pipes_for_plane(struct dml2_context *ctx, struct dc_state *state, const struct dc_stream_state *stream, const struct dc_plane_state *plane,
-		int plane_index, struct dc_pipe_mapping_scratch *scratch, const struct dc_state *existing_state)
+		struct dc_pipe_mapping_scratch *scratch, const struct dc_state *existing_state)
 {
 	int odm_slice_index;
 	unsigned int plane_id;
 	struct pipe_ctx *master_pipe = NULL;
 	int i;
 
-	if (!get_plane_id(ctx, state, plane, stream->stream_id, plane_index, &plane_id)) {
+	if (!get_plane_id(state, plane, stream->stream_id, &plane_id)) {
 		ASSERT(false);
 		return;
 	}
 
-	master_pipe = assign_pipes_to_plane(ctx, state, stream, plane, scratch->odm_info.odm_factor,
-			scratch->mpc_info.mpc_factor, plane_index, &scratch->pipe_pool, existing_state);
+	master_pipe = assign_pipes_to_plane(ctx, state, stream, plane, scratch->odm_info.odm_factor, scratch->mpc_info.mpc_factor, &scratch->pipe_pool, existing_state);
 	sort_pipes_for_splitting(&scratch->pipe_pool);
 
 	for (odm_slice_index = 0; odm_slice_index < scratch->odm_info.odm_factor; odm_slice_index++) {
@@ -765,7 +755,7 @@ static void map_pipes_for_plane(struct dml2_context *ctx, struct dc_state *state
 		}
 	}
 
-	free_unused_pipes_for_plane(ctx, state, plane, &scratch->pipe_pool, stream->stream_id, plane_index);
+	free_unused_pipes_for_plane(ctx, state, plane, &scratch->pipe_pool, stream->stream_id);
 }
 
 static unsigned int get_mpc_factor(struct dml2_context *ctx,
@@ -778,7 +768,7 @@ static unsigned int get_mpc_factor(struct dml2_context *ctx,
 	unsigned int plane_id;
 	unsigned int cfg_idx;
 
-	get_plane_id(ctx, state, status->plane_states[plane_idx], stream_id, plane_idx, &plane_id);
+	get_plane_id(state, status->plane_states[plane_idx], stream_id, &plane_id);
 	cfg_idx = find_disp_cfg_idx_by_plane_id(mapping, plane_id);
 	if (ctx->architecture == dml2_architecture_20)
 		return (unsigned int)disp_cfg->hw.DPPPerSurface[cfg_idx];
@@ -968,8 +958,8 @@ bool dml2_map_dc_pipes(struct dml2_context *ctx, struct dc_state *state, const s
 
 		for (plane_index = 0; plane_index < state->stream_status[stream_index].plane_count; plane_index++) {
 			// Planes are ordered top to bottom.
-			if (get_plane_id(ctx, state, state->stream_status[stream_index].plane_states[plane_index],
-				stream_id, plane_index, &plane_id)) {
+			if (get_plane_id(state, state->stream_status[stream_index].plane_states[plane_index],
+				stream_id, &plane_id)) {
 				plane_disp_cfg_index = find_disp_cfg_idx_by_plane_id(mapping, plane_id);
 
 				// Setup mpc_info for this plane
@@ -993,8 +983,7 @@ bool dml2_map_dc_pipes(struct dml2_context *ctx, struct dc_state *state, const s
 				// Clear the pool assignment scratch (which is per plane)
 				memset(&scratch.pipe_pool, 0, sizeof(struct dc_plane_pipe_pool));
 
-				map_pipes_for_plane(ctx, state, state->streams[stream_index],
-					state->stream_status[stream_index].plane_states[plane_index], plane_index, &scratch, existing_state);
+				map_pipes_for_plane(ctx, state, state->streams[stream_index], state->stream_status[stream_index].plane_states[plane_index], &scratch, existing_state);
 			} else {
 				// Plane ID cannot be generated, therefore no DML mapping can be performed.
 				ASSERT(false);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h
index 0f2b3d112fa8..ed5b767d46e0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h
@@ -75,8 +75,6 @@ struct dml2_dml_to_dc_pipe_mapping {
 	bool dml_pipe_idx_to_stream_id_valid[__DML2_WRAPPER_MAX_STREAMS_PLANES__];
 	unsigned int dml_pipe_idx_to_plane_id[__DML2_WRAPPER_MAX_STREAMS_PLANES__];
 	bool dml_pipe_idx_to_plane_id_valid[__DML2_WRAPPER_MAX_STREAMS_PLANES__];
-	unsigned int dml_pipe_idx_to_plane_index[__DML2_WRAPPER_MAX_STREAMS_PLANES__];
-	bool dml_pipe_idx_to_plane_index_valid[__DML2_WRAPPER_MAX_STREAMS_PLANES__];
 };
 
 struct dml2_wrapper_scratch {
@@ -98,7 +96,6 @@ struct dml2_wrapper_scratch {
 
 	struct dml2_dml_to_dc_pipe_mapping dml_to_dc_pipe_mapping;
 	bool enable_flexible_pipe_mapping;
-	bool plane_duplicate_exists;
 };
 
 struct dml2_helper_det_policy_scratch {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index eec4799bed61..159a0956893f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -931,11 +931,10 @@ static unsigned int map_stream_to_dml_display_cfg(const struct dml2_context *dml
 	return location;
 }
 
-static bool get_plane_id(struct dml2_context *dml2, const struct dc_state *context, const struct dc_plane_state *plane,
-		unsigned int stream_id, unsigned int plane_index, unsigned int *plane_id)
+static bool get_plane_id(const struct dc_state *context, const struct dc_plane_state *plane,
+		unsigned int stream_id, unsigned int *plane_id)
 {
 	int i, j;
-	bool is_plane_duplicate = dml2->v20.scratch.plane_duplicate_exists;
 
 	if (!plane_id)
 		return false;
@@ -943,8 +942,7 @@ static bool get_plane_id(struct dml2_context *dml2, const struct dc_state *conte
 	for (i = 0; i < context->stream_count; i++) {
 		if (context->streams[i]->stream_id == stream_id) {
 			for (j = 0; j < context->stream_status[i].plane_count; j++) {
-				if (context->stream_status[i].plane_states[j] == plane &&
-					(!is_plane_duplicate || (is_plane_duplicate && (j == plane_index)))) {
+				if (context->stream_status[i].plane_states[j] == plane) {
 					*plane_id = (i << 16) | j;
 					return true;
 				}
@@ -956,13 +954,13 @@ static bool get_plane_id(struct dml2_context *dml2, const struct dc_state *conte
 }
 
 static unsigned int map_plane_to_dml_display_cfg(const struct dml2_context *dml2, const struct dc_plane_state *plane,
-		const struct dc_state *context, const struct dml_display_cfg_st *dml_dispcfg, unsigned int stream_id, int plane_index)
+		const struct dc_state *context, const struct dml_display_cfg_st *dml_dispcfg, unsigned int stream_id)
 {
 	unsigned int plane_id;
 	int i = 0;
 	int location = -1;
 
-	if (!get_plane_id(context->bw_ctx.dml2, context, plane, stream_id, plane_index, &plane_id)) {
+	if (!get_plane_id(context, plane, stream_id, &plane_id)) {
 		ASSERT(false);
 		return -1;
 	}
@@ -993,63 +991,7 @@ static void apply_legacy_svp_drr_settings(struct dml2_context *dml2, const struc
 	}
 }
 
-static bool find_duplicate_plane(struct dml2_context *in_ctx, struct dc_state *state)
-{
-	unsigned int i = 0;
-	unsigned int j = 0;
-	bool is_duplicate_plane = false;
-
-	for (i = 0; i < MAX_PIPES; i++) {
-		struct pipe_ctx *pipe_prev = &state->res_ctx.pipe_ctx[i];
-
-		if (!pipe_prev || !pipe_prev->stream || !pipe_prev->plane_state)
-			continue;
-
-		for (j = i + 1; j < MAX_PIPES; j++) {
-			struct pipe_ctx *pipe_next = &state->res_ctx.pipe_ctx[j];
-
-			if (!pipe_next || !pipe_next->stream || !pipe_next->plane_state)
-				continue;
-
-			if (pipe_prev->plane_state == pipe_next->plane_state) {
-				is_duplicate_plane = true;
-				break;
-			}
-		}
-	}
-
-	return is_duplicate_plane;
-}
-
-static void initialize_pipe_to_plane_index_mapping(struct dc_state *state, struct dml2_dml_to_dc_pipe_mapping *dml_to_dc_pipe_mapping)
-{
-	unsigned int i;
-	unsigned int pipe_index = 0;
-	unsigned int plane_index = 0;
-
-	for (i = 0; i < __DML2_WRAPPER_MAX_STREAMS_PLANES__; i++) {
-		struct pipe_ctx *pipe = &state->res_ctx.pipe_ctx[i];
-
-		if (!pipe || !pipe->stream || !pipe->plane_state)
-			continue;
-
-		while (pipe) {
-			pipe_index = pipe->pipe_idx;
-
-			if (pipe->stream && dml_to_dc_pipe_mapping->dml_pipe_idx_to_plane_index_valid[pipe_index] == false) {
-				dml_to_dc_pipe_mapping->dml_pipe_idx_to_plane_index[pipe_index] = plane_index;
-				plane_index++;
-				dml_to_dc_pipe_mapping->dml_pipe_idx_to_plane_index_valid[pipe_index] = true;
-			}
-
-			pipe = pipe->bottom_pipe;
-		}
-
-		plane_index = 0;
-	}
-}
-
-void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_state *context, struct dml_display_cfg_st *dml_dispcfg)
+void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, const struct dc_state *context, struct dml_display_cfg_st *dml_dispcfg)
 {
 	int i = 0, j = 0;
 	int disp_cfg_stream_location, disp_cfg_plane_location;
@@ -1059,7 +1001,6 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 		dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id_valid[i] = false;
 		dml2->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_stream_id_valid[i] = false;
 		dml2->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_id_valid[i] = false;
-		dml2->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_index_valid[i] = false;
 	}
 
 	//Generally these are set by referencing our latest BB/IP params in dcn32_resource.c file
@@ -1067,9 +1008,6 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 	dml_dispcfg->plane.GPUVMMaxPageTableLevels = 4;
 	dml_dispcfg->plane.HostVMEnable = false;
 
-	initialize_pipe_to_plane_index_mapping(context, &dml2->v20.scratch.dml_to_dc_pipe_mapping);
-	dml2->v20.scratch.plane_duplicate_exists = find_duplicate_plane(dml2, context);
-
 	for (i = 0; i < context->stream_count; i++) {
 		disp_cfg_stream_location = map_stream_to_dml_display_cfg(dml2, context->streams[i], dml_dispcfg);
 
@@ -1106,7 +1044,7 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 		} else {
 			for (j = 0; j < context->stream_status[i].plane_count; j++) {
 				disp_cfg_plane_location = map_plane_to_dml_display_cfg(dml2,
-					context->stream_status[i].plane_states[j], context, dml_dispcfg, context->streams[i]->stream_id, j);
+					context->stream_status[i].plane_states[j], context, dml_dispcfg, context->streams[i]->stream_id);
 
 				if (disp_cfg_plane_location < 0)
 					disp_cfg_plane_location = dml_dispcfg->num_surfaces++;
@@ -1130,7 +1068,7 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_stat
 
 				dml_dispcfg->plane.BlendingAndTiming[disp_cfg_plane_location] = disp_cfg_stream_location;
 
-				if (get_plane_id(dml2, context, context->stream_status[i].plane_states[j], context->streams[i]->stream_id, j,
+				if (get_plane_id(context, context->stream_status[i].plane_states[j], context->streams[i]->stream_id,
 					&dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id[disp_cfg_plane_location]))
 					dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id_valid[disp_cfg_plane_location] = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.h
index d764773938f4..dac6d27b14cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.h
@@ -34,7 +34,7 @@ void dml2_init_soc_states(struct dml2_context *dml2, const struct dc *in_dc,
 void dml2_translate_ip_params(const struct dc *in_dc, struct ip_params_st *out);
 void dml2_translate_socbb_params(const struct dc *in_dc, struct soc_bounding_box_st *out);
 void dml2_translate_soc_states(const struct dc *in_dc, struct soc_states_st *out, int num_states);
-void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, struct dc_state *context, struct dml_display_cfg_st *dml_dispcfg);
+void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, const struct dc_state *context, struct dml_display_cfg_st *dml_dispcfg);
 void dml2_update_pipe_ctx_dchub_regs(struct _vcs_dpi_dml_display_rq_regs_st *rq_regs, struct _vcs_dpi_dml_display_dlg_regs_st *disp_dlg_regs, struct _vcs_dpi_dml_display_ttu_regs_st *disp_ttu_regs, struct pipe_ctx *out);
 bool is_dp2p0_output_encoder(const struct pipe_ctx *pipe);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index 2498b8341199..69fd96f4f3b0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -209,11 +209,10 @@ static int find_dml_pipe_idx_by_plane_id(struct dml2_context *ctx, unsigned int
 	return -1;
 }
 
-static bool get_plane_id(struct dml2_context *dml2, const struct dc_state *state, const struct dc_plane_state *plane,
-	unsigned int stream_id, unsigned int plane_index, unsigned int *plane_id)
+static bool get_plane_id(const struct dc_state *state, const struct dc_plane_state *plane,
+	unsigned int stream_id, unsigned int *plane_id)
 {
 	int i, j;
-	bool is_plane_duplicate = dml2->v20.scratch.plane_duplicate_exists;
 
 	if (!plane_id)
 		return false;
@@ -221,8 +220,7 @@ static bool get_plane_id(struct dml2_context *dml2, const struct dc_state *state
 	for (i = 0; i < state->stream_count; i++) {
 		if (state->streams[i]->stream_id == stream_id) {
 			for (j = 0; j < state->stream_status[i].plane_count; j++) {
-				if (state->stream_status[i].plane_states[j] == plane &&
-					(!is_plane_duplicate || (is_plane_duplicate && (j == plane_index)))) {
+				if (state->stream_status[i].plane_states[j] == plane) {
 					*plane_id = (i << 16) | j;
 					return true;
 				}
@@ -306,9 +304,8 @@ void dml2_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_state *cont
 		 * there is a need to know which DML pipe index maps to which DC pipe. The code below
 		 * finds a dml_pipe_index from the plane id if a plane is valid. If a plane is not valid then
 		 * it finds a dml_pipe_index from the stream id. */
-		if (get_plane_id(in_ctx, context, context->res_ctx.pipe_ctx[dc_pipe_ctx_index].plane_state,
-			context->res_ctx.pipe_ctx[dc_pipe_ctx_index].stream->stream_id,
-			in_ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_index[context->res_ctx.pipe_ctx[dc_pipe_ctx_index].pipe_idx], &plane_id)) {
+		if (get_plane_id(context, context->res_ctx.pipe_ctx[dc_pipe_ctx_index].plane_state,
+			context->res_ctx.pipe_ctx[dc_pipe_ctx_index].stream->stream_id, &plane_id)) {
 			dml_pipe_idx = find_dml_pipe_idx_by_plane_id(in_ctx, plane_id);
 		} else {
 			dml_pipe_idx = dml2_helper_find_dml_pipe_idx_by_stream_id(in_ctx, context->res_ctx.pipe_ctx[dc_pipe_ctx_index].stream->stream_id);
@@ -448,9 +445,8 @@ bool dml2_verify_det_buffer_configuration(struct dml2_context *in_ctx, struct dc
 	for (i = 0; i < MAX_PIPES; i++) {
 		if (!display_state->res_ctx.pipe_ctx[i].stream)
 			continue;
-		if (get_plane_id(in_ctx, display_state, display_state->res_ctx.pipe_ctx[i].plane_state,
-			display_state->res_ctx.pipe_ctx[i].stream->stream_id,
-			in_ctx->v20.scratch.dml_to_dc_pipe_mapping.dml_pipe_idx_to_plane_index[display_state->res_ctx.pipe_ctx[i].pipe_idx], &plane_id))
+		if (get_plane_id(display_state, display_state->res_ctx.pipe_ctx[i].plane_state,
+			display_state->res_ctx.pipe_ctx[i].stream->stream_id, &plane_id))
 			dml_pipe_idx = find_dml_pipe_idx_by_plane_id(in_ctx, plane_id);
 		else
 			dml_pipe_idx = dml2_helper_find_dml_pipe_idx_by_stream_id(in_ctx, display_state->res_ctx.pipe_ctx[i].stream->stream_id);
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
index 8f231418870f..0a06bf3b135a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.c
@@ -639,7 +639,7 @@ static bool dml2_validate_and_build_resource(const struct dc *in_dc, struct dc_s
 	return result;
 }
 
-static bool dml2_validate_only(struct dc_state *context)
+static bool dml2_validate_only(const struct dc_state *context)
 {
 	struct dml2_context *dml2 = context->bw_ctx.dml2;
 	unsigned int result = 0;
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A10ECD11DF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 19:51:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBE5E10E9C8;
	Thu, 28 Mar 2024 19:51:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hP49LTQl";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 64B4C10E516
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 19:51:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGEY5YLtsgqjLlFzFYzrhiIHLg+LPSNuP7OjqdK5m7Bm92jcbq+0MnaSnKwxut+UJa9PXtxO61UGnHOBccqyfzOWyvce534wCXJtVwnr/qqY8ZsIVVbop6VPj6bDmvbzluJH71eGwhgXU4Ng4IcKDATmdGvuUsimI3BJRQl7+U9m+VBNfBIDPCe5j1Fk7FgQE1gLbiuI31Msgmr+fmmsuyIZcxGG0YWBtEJucse/oaZrs43o2i1r9aU4ZaN1uLZrLFF0ufSs3N6TT24wx3HsF8NgWd4l/4gHUI3JL9i7cyHRc9rDMrMZA12Ehrn2C2nvgvqi+AoYoKbP4BJptpod8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IZbawp6CqrMUWD+03p9TDFfZbKOneOjLlr9ruIMsVjM=;
 b=ndu6Txjh6P9hNwERdS9wR2xZIjHsAZpLxxPrAm1ADh1JXWn9F3wh6NPA4yCF1ew1EsirGc/b4syCXKMZqIUJjkzGJ4A2HCMaO/dMzJOxWaTZynKVQJZEuS4MIFKka0XsKXnLSyaaDrk0yynK9Dgl7mJzvNhUFzBy/KL48xy1FpBPH5zhAlIqIVnaHqwaPulaYg0LpmjtueLPIjf401Xz43qOiXXl0XJGCgVSQyjz/0isjDKdYUlEbPBL1hMsVD74X7POfBZIiwFUbHtuDOaBNlRtD/k0Ld7DvPNQa7whmirMX0hE8DdKHsVlT2tjMmil/j5ON8sNwLaZurO6Jfh0YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IZbawp6CqrMUWD+03p9TDFfZbKOneOjLlr9ruIMsVjM=;
 b=hP49LTQlCEPfx37TRnAJzvDJ5RFunxUsNeo04oKp6TMLHPABzON7KbMi5a+OPl3AF+DFfmPN2bS4necRNHyoLXosZeAjzsEDhQTDYgS6JxNZmrJiJKTWWV33U4abhR+za3YcndG9uHbFfKKIknrJrAomUUzX9I2Ig10MFElXLJA=
Received: from CH2PR14CA0056.namprd14.prod.outlook.com (2603:10b6:610:56::36)
 by SJ2PR12MB8134.namprd12.prod.outlook.com (2603:10b6:a03:4fa::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Thu, 28 Mar
 2024 19:51:29 +0000
Received: from CH1PEPF0000AD7A.namprd04.prod.outlook.com
 (2603:10b6:610:56:cafe::2d) by CH2PR14CA0056.outlook.office365.com
 (2603:10b6:610:56::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27 via Frontend
 Transport; Thu, 28 Mar 2024 19:51:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD7A.mail.protection.outlook.com (10.167.244.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 19:51:28 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 28 Mar
 2024 14:51:27 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 28 Mar 2024 14:51:27 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Daniel Wheeler <daniel.wheeler@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, 
 <roman.li@amd.com>, <wayne.lin@amd.com>, <solomon.chiu@amd.com>,
 <agustin.gutierrez@amd.com>, <hamza.mahfooz@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Dillon Varone <dillon.varone@amd.com>
Subject: [PATCH 04/43] drm/amd/display: optimize dml2 pipe resource allocation
 order
Date: Thu, 28 Mar 2024 15:50:08 -0400
Message-ID: <20240328195047.2843715-5-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240328195047.2843715-1-Roman.Li@amd.com>
References: <20240328195047.2843715-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD7A:EE_|SJ2PR12MB8134:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b856c47-eb3c-43cf-ee5d-08dc4f6075e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: azF09BV30vh3v0Ik8rzVnqcEL00rsnugDYBHIFPgc4w740UDCNPr1lcjWqZO6G1oVnpg3/T1lKlDjM4AiFix7qgan1WN9O5Wqyb6qeX//xK4E0bj4IcTYasMskRRqjFSGJbCAhTAB67H6YwkpfFfxokGeEONQ+rnbyZ2iYHFNZBZCTDZmQCLPLAlue43iajKmR9YAZAxhjsVSAe6wWc4wNEMPoMvaQTMpq9MbCzrXVhPgH6cIYYtoCK5TStQSMuXaOo9QPDni9Jk0k53JInruRdB2B3pioUjKcX4l0sLZC2NRgIjWczk3jf4FcKy3Dmbvdg+skIUjL/tPFnu8V03oJVX7O6uO4aI80cY960YxHhotPSUUR/t8rUMx3v/DwTg50z9UNRCiG1rN4eCslHG2aCbUqq5gYjGYt21u+EEvO0xXN5NeJoLbp9Zqc8S6QI7yYn2XBKH6C6Z8PXgW6aYWIxhAMEFVxgL96KFZIhSVY/CDALi2AjTGeO3JhVXvnrb9G2flFHKPFexLEP5Xn6CFXo2mVkqxIcW58YdQFZJvqAJwm1wN6AT2bifVBULG3xbn59Tcqa3d4GdvHVPSE5y70lI66ITVbtPNeU0BAaNskk0aLD+dMKyKq+mbTjETpHo4xjjF7pjB+usDg0tDFV7Z1gU1S6m8gh35+t4ixyutGaomKzuJHqh19Rf3HyrKfhXMX5NZDLqihRwLFvo2UBreLRptWz3BFQ8BVILDvZMl0fJL7u6AewZXRO2nvUShtdo
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(82310400014)(36860700004)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 19:51:28.7066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b856c47-eb3c-43cf-ee5d-08dc4f6075e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD7A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8134
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

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
There could be cases that we are transition from MPC to ODM combine.
In this case if we map pipes before unmapping MPC pipes, we might
temporarly run out of pipes. The change reorders pipe resource
allocation. So we unmapping pipes before mapping new pipes.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c |   2 +
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   | 126 ++++++++++++------
 .../amd/display/dc/dml2/dml2_internal_types.h |  11 ++
 .../drm/amd/display/dc/dml2/dml2_wrapper.h    |   2 +
 4 files changed, 97 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index dd0428024173..601af21b2df9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -5052,7 +5052,9 @@ void resource_init_common_dml2_callbacks(struct dc *dc, struct dml2_configuratio
 	dml2_options->callbacks.update_pipes_for_stream_with_slice_count = &resource_update_pipes_for_stream_with_slice_count;
 	dml2_options->callbacks.update_pipes_for_plane_with_slice_count = &resource_update_pipes_for_plane_with_slice_count;
 	dml2_options->callbacks.get_mpc_slice_index = &resource_get_mpc_slice_index;
+	dml2_options->callbacks.get_mpc_slice_count = &resource_get_mpc_slice_count;
 	dml2_options->callbacks.get_odm_slice_index = &resource_get_odm_slice_index;
+	dml2_options->callbacks.get_odm_slice_count = &resource_get_odm_slice_count;
 	dml2_options->callbacks.get_opp_head = &resource_get_opp_head;
 	dml2_options->callbacks.get_otg_master_for_stream = &resource_get_otg_master_for_stream;
 	dml2_options->callbacks.get_opp_heads_for_otg_master = &resource_get_opp_heads_for_otg_master;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index b64e0160d482..27d9da8ad7c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -793,7 +793,7 @@ static void map_pipes_for_plane(struct dml2_context *ctx, struct dc_state *state
 	free_unused_pipes_for_plane(ctx, state, plane, &scratch->pipe_pool, stream->stream_id, plane_index);
 }
 
-static unsigned int get_mpc_factor(struct dml2_context *ctx,
+static unsigned int get_target_mpc_factor(struct dml2_context *ctx,
 		struct dc_state *state,
 		const struct dml_display_cfg_st *disp_cfg,
 		struct dml2_dml_to_dc_pipe_mapping *mapping,
@@ -822,7 +822,7 @@ static unsigned int get_mpc_factor(struct dml2_context *ctx,
 	return mpc_factor;
 }
 
-static unsigned int get_odm_factor(
+static unsigned int get_target_odm_factor(
 		const struct dml2_context *ctx,
 		struct dc_state *state,
 		const struct dml_display_cfg_st *disp_cfg,
@@ -849,79 +849,117 @@ static unsigned int get_odm_factor(
 	return 1;
 }
 
+static unsigned int get_source_odm_factor(const struct dml2_context *ctx,
+		struct dc_state *state,
+		const struct dc_stream_state *stream)
+{
+	struct pipe_ctx *otg_master = ctx->config.callbacks.get_otg_master_for_stream(&state->res_ctx, stream);
+
+	return ctx->config.callbacks.get_odm_slice_count(otg_master);
+}
+
+static unsigned int get_source_mpc_factor(const struct dml2_context *ctx,
+		struct dc_state *state,
+		const struct dc_plane_state *plane)
+{
+	struct pipe_ctx *dpp_pipes[MAX_PIPES];
+	int dpp_pipe_count = ctx->config.callbacks.get_dpp_pipes_for_plane(plane,
+			&state->res_ctx, dpp_pipes);
+
+	ASSERT(dpp_pipe_count > 0);
+	return ctx->config.callbacks.get_mpc_slice_count(dpp_pipes[0]);
+}
+
+
 static void populate_mpc_factors_for_stream(
 		struct dml2_context *ctx,
 		const struct dml_display_cfg_st *disp_cfg,
 		struct dml2_dml_to_dc_pipe_mapping *mapping,
 		struct dc_state *state,
 		unsigned int stream_idx,
-		unsigned int odm_factor,
-		unsigned int mpc_factors[MAX_PIPES])
+		struct dml2_pipe_combine_factor odm_factor,
+		struct dml2_pipe_combine_factor mpc_factors[MAX_PIPES])
 {
 	const struct dc_stream_status *status = &state->stream_status[stream_idx];
 	int i;
 
-	for (i = 0; i < status->plane_count; i++)
-		if (odm_factor == 1)
-			mpc_factors[i] = get_mpc_factor(
-					ctx, state, disp_cfg, mapping, status,
-					state->streams[stream_idx], i);
-		else
-			mpc_factors[i] = 1;
+	for (i = 0; i < status->plane_count; i++) {
+		mpc_factors[i].source = get_source_mpc_factor(ctx, state, status->plane_states[i]);
+		mpc_factors[i].target = (odm_factor.target == 1) ?
+				get_target_mpc_factor(ctx, state, disp_cfg, mapping, status, state->streams[stream_idx], i) : 1;
+	}
 }
 
 static void populate_odm_factors(const struct dml2_context *ctx,
 		const struct dml_display_cfg_st *disp_cfg,
 		struct dml2_dml_to_dc_pipe_mapping *mapping,
 		struct dc_state *state,
-		unsigned int odm_factors[MAX_PIPES])
+		struct dml2_pipe_combine_factor odm_factors[MAX_PIPES])
 {
 	int i;
 
-	for (i = 0; i < state->stream_count; i++)
-		odm_factors[i] = get_odm_factor(
+	for (i = 0; i < state->stream_count; i++) {
+		odm_factors[i].source = get_source_odm_factor(ctx, state, state->streams[i]);
+		odm_factors[i].target = get_target_odm_factor(
 				ctx, state, disp_cfg, mapping, state->streams[i]);
+	}
 }
 
-static bool map_dc_pipes_for_stream(struct dml2_context *ctx,
+static bool unmap_dc_pipes_for_stream(struct dml2_context *ctx,
 		struct dc_state *state,
 		const struct dc_state *existing_state,
 		const struct dc_stream_state *stream,
 		const struct dc_stream_status *status,
-		unsigned int odm_factor,
-		unsigned int mpc_factors[MAX_PIPES])
+		struct dml2_pipe_combine_factor odm_factor,
+		struct dml2_pipe_combine_factor mpc_factors[MAX_PIPES])
 {
 	int plane_idx;
 	bool result = true;
 
-	if (odm_factor == 1)
-		/*
-		 * ODM and MPC combines are by DML design mutually exclusive.
-		 * ODM factor of 1 means MPC factors may be greater than 1.
-		 * In this case, we want to set ODM factor to 1 first to free up
-		 * pipe resources from previous ODM configuration before setting
-		 * up MPC combine to acquire more pipe resources.
-		 */
+	for (plane_idx = 0; plane_idx < status->plane_count; plane_idx++)
+		if (mpc_factors[plane_idx].target < mpc_factors[plane_idx].source)
+			result &= ctx->config.callbacks.update_pipes_for_plane_with_slice_count(
+					state,
+					existing_state,
+					ctx->config.callbacks.dc->res_pool,
+					status->plane_states[plane_idx],
+					mpc_factors[plane_idx].target);
+	if (odm_factor.target < odm_factor.source)
 		result &= ctx->config.callbacks.update_pipes_for_stream_with_slice_count(
 				state,
 				existing_state,
 				ctx->config.callbacks.dc->res_pool,
 				stream,
-				odm_factor);
+				odm_factor.target);
+	return result;
+}
+
+static bool map_dc_pipes_for_stream(struct dml2_context *ctx,
+		struct dc_state *state,
+		const struct dc_state *existing_state,
+		const struct dc_stream_state *stream,
+		const struct dc_stream_status *status,
+		struct dml2_pipe_combine_factor odm_factor,
+		struct dml2_pipe_combine_factor mpc_factors[MAX_PIPES])
+{
+	int plane_idx;
+	bool result = true;
+
 	for (plane_idx = 0; plane_idx < status->plane_count; plane_idx++)
-		result &= ctx->config.callbacks.update_pipes_for_plane_with_slice_count(
-				state,
-				existing_state,
-				ctx->config.callbacks.dc->res_pool,
-				status->plane_states[plane_idx],
-				mpc_factors[plane_idx]);
-	if (odm_factor > 1)
+		if (mpc_factors[plane_idx].target > mpc_factors[plane_idx].source)
+			result &= ctx->config.callbacks.update_pipes_for_plane_with_slice_count(
+					state,
+					existing_state,
+					ctx->config.callbacks.dc->res_pool,
+					status->plane_states[plane_idx],
+					mpc_factors[plane_idx].target);
+	if (odm_factor.target > odm_factor.source)
 		result &= ctx->config.callbacks.update_pipes_for_stream_with_slice_count(
 				state,
 				existing_state,
 				ctx->config.callbacks.dc->res_pool,
 				stream,
-				odm_factor);
+				odm_factor.target);
 	return result;
 }
 
@@ -931,20 +969,20 @@ static bool map_dc_pipes_with_callbacks(struct dml2_context *ctx,
 		struct dml2_dml_to_dc_pipe_mapping *mapping,
 		const struct dc_state *existing_state)
 {
-	unsigned int odm_factors[MAX_PIPES];
-	unsigned int mpc_factors_for_stream[MAX_PIPES];
 	int i;
 	bool result = true;
 
-	populate_odm_factors(ctx, disp_cfg, mapping, state, odm_factors);
-	for (i = 0; i < state->stream_count; i++) {
+	populate_odm_factors(ctx, disp_cfg, mapping, state, ctx->pipe_combine_scratch.odm_factors);
+	for (i = 0; i < state->stream_count; i++)
 		populate_mpc_factors_for_stream(ctx, disp_cfg, mapping, state,
-				i, odm_factors[i], mpc_factors_for_stream);
-		result &= map_dc_pipes_for_stream(ctx, state, existing_state,
-				state->streams[i],
-				&state->stream_status[i],
-				odm_factors[i], mpc_factors_for_stream);
-	}
+				i, ctx->pipe_combine_scratch.odm_factors[i], ctx->pipe_combine_scratch.mpc_factors[i]);
+	for (i = 0; i < state->stream_count; i++)
+		result &= unmap_dc_pipes_for_stream(ctx, state, existing_state, state->streams[i],
+				&state->stream_status[i], ctx->pipe_combine_scratch.odm_factors[i], ctx->pipe_combine_scratch.mpc_factors[i]);
+	for (i = 0; i < state->stream_count; i++)
+		result &= map_dc_pipes_for_stream(ctx, state, existing_state, state->streams[i],
+				&state->stream_status[i], ctx->pipe_combine_scratch.odm_factors[i], ctx->pipe_combine_scratch.mpc_factors[i]);
+
 	return result;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h
index 1cf8a884c0fb..9dab4e43c511 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_internal_types.h
@@ -109,10 +109,21 @@ enum dml2_architecture {
 	dml2_architecture_20,
 };
 
+struct dml2_pipe_combine_factor {
+	unsigned int source;
+	unsigned int target;
+};
+
+struct dml2_pipe_combine_scratch {
+	struct dml2_pipe_combine_factor odm_factors[MAX_PIPES];
+	struct dml2_pipe_combine_factor mpc_factors[MAX_PIPES][MAX_PIPES];
+};
+
 struct dml2_context {
 	enum dml2_architecture architecture;
 	struct dml2_configuration_options config;
 	struct dml2_helper_det_policy_scratch det_helper_scratch;
+	struct dml2_pipe_combine_scratch pipe_combine_scratch;
 	union {
 		struct {
 			struct display_mode_lib_st dml_core_ctx;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
index 6e97337863e0..54aff9beb73a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_wrapper.h
@@ -86,7 +86,9 @@ struct dml2_dc_callbacks {
 			const struct dc_plane_state *plane,
 			int slice_count);
 	int (*get_odm_slice_index)(const struct pipe_ctx *opp_head);
+	int (*get_odm_slice_count)(const struct pipe_ctx *opp_head);
 	int (*get_mpc_slice_index)(const struct pipe_ctx *dpp_pipe);
+	int (*get_mpc_slice_count)(const struct pipe_ctx *dpp_pipe);
 	struct pipe_ctx *(*get_opp_head)(const struct pipe_ctx *pipe_ctx);
 	struct pipe_ctx *(*get_otg_master_for_stream)(
 		struct resource_context *res_ctx,
-- 
2.34.1


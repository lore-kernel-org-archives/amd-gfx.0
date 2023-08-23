Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70A9EE49B2
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 16:04:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 19CAC10E468;
	Wed, 23 Aug 2023 16:04:34 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2087.outbound.protection.outlook.com [40.107.223.87])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E16710E467
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 16:04:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SgDSb3qyItCwYMO1kJCnTmKX3QvSUTI78XIt9+huGgkC5ctGHmxPwqzNwvImLW7B5l0qC8MR1Ezp5MMcn124UIRu5cqOJPqtquNPccGZ2EOgrG4/CbT58ET4jDqK8iWVXFTlkk1XnI35+Kdm72xBNwY1sunVHjLjU6p7/dnAhDK6+1YhBFyqdTpsVpxY6C3ohnvGSZacJ+6MFWZuCTSwpSi8+HQm/93Mfz6+pURndClb9X2VL5yOiWqx2g/1dsyYHrlotyCF+eVgl5pWgpxpp5ed1Ar/27NNC7ppFwkBlzkZf8lFrtKXDHiuR+DW+Hzw73l6yOgKPzjLmuQYzQCYxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8KJMO7yo/a/PvQ3doon/rTlLoxTDdYl0dGPAyOGkzNI=;
 b=BIQw9tosLd+oFj6zNUuI2xY4Av7ua5RFaBkPWx7rseLLAjSTzPcShXgpM9U/pS1rtD0NUXdSAZ6dJTBZ+6pOZSBTn5P049BzSSBIZxkQupaaLK1k3nqgUqwKmiKv1uYxXG+D0GbqJPjRW9WiiQvFCGbXiGo9kcYroxLZZfW64XbktcY/XzzIgiQb6d3ZeS0496Wx8b51YbknywgAAyeM4A3DQaFKCVamei6/zETRT7XkqdGo1wkVkza0jCiVzSd8GYw3zpUY0vAV5eAvxzbNCgvh9MfS9iZwvFkYf1InPM8ptGMOl/4Q8gcUd8QIhHu3u+zSKcDBVtvWD8KKP+pvmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8KJMO7yo/a/PvQ3doon/rTlLoxTDdYl0dGPAyOGkzNI=;
 b=rip5H0jEkqNQrRNSWm9lTKx2/T3LSm+Fc1my79D/p/9ZKKsbNNgw3Ujf/lacp7K8uqDIXmsSVfJV+JpMamPQ5VhqWoYBML23wDmShkn052do1f+Cnq/YDj8jiuu/Ne9D1jKuAgDu3KlGKMwVC9oUAbgTkn/JLeXGbTXTmaIu3x4=
Received: from SJ0PR13CA0129.namprd13.prod.outlook.com (2603:10b6:a03:2c6::14)
 by CY8PR12MB8315.namprd12.prod.outlook.com (2603:10b6:930:7e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26; Wed, 23 Aug
 2023 16:04:27 +0000
Received: from SN1PEPF000252A0.namprd05.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::19) by SJ0PR13CA0129.outlook.office365.com
 (2603:10b6:a03:2c6::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.15 via Frontend
 Transport; Wed, 23 Aug 2023 16:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000252A0.mail.protection.outlook.com (10.167.242.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 16:04:26 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 11:04:24 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 08/21] drm/amd/display: rename function to add otg master for
 stream
Date: Wed, 23 Aug 2023 11:58:10 -0400
Message-ID: <20230823160347.176991-9-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823160347.176991-1-hamza.mahfooz@amd.com>
References: <20230823160347.176991-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A0:EE_|CY8PR12MB8315:EE_
X-MS-Office365-Filtering-Correlation-Id: d7658b5c-e60d-434e-7a6f-08dba3f2a00c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cG4CKN2b/1ydlHGbNw554bLG03Zusvrhk1wXzMjK8fWboVySw9aRMqv3Sede+yuay+3f4H0l4vYAQeutEeil5Kwz8QiBvx3UWh/s+6ks2YYpHD1yOJqUj9q6KVvyOS/zYPHmPU/SAFKRVLD3/rjyakZkWPDeJovFyxWMw7gQvHd0VeFgxSl9QUDwAMRl57tcM5rMgUckxCKZxTucCgip1f1O1Ex4qugXyCdKDnXvBwBZsGc5DbJa/VsNHa1q3DOO1yldZuyhNbFkK/Ya4ipWIipGMEUAnERvceppFBD7X0jEb6PgtEoJ/X9Kb2U2aAZGZuQuI3ZF3AqNnThUQ2Jdt1Sm3ZPKFF/mY2tQEiZBVHNBrvUlQfGApuKSu911NWm8uc9rclBAkdqORfFVKlNkGXa+y+NBbErUjQvsMAwJKZYr7GKsPtiRA4HhSeVQ+LSl+ZWnyqSflAccypsPNHqr1fXXl+EnyHhKMAHL6Pqc5/6gocMmPERU2w81IHAUqC8oCK/PBz8hCbpOrvYcG4A+cKosUoL//YDIgHlYvLvEoFNfyw22tOYE+FSzz7xD2n3dUQFKAEAgoeApeKz2/Z28Msl6IbuDccfi2moh7Jf16xocZ9sM+tgo4jadvUUqDp5co4LtwGb3GGvKgA6yt4hw1EY5ugrQKFv/ONeaJXixFpzYMvjjXF0r0yKhH4evS6qcTZreqSMohdIstTNrq3lVMcvmWXJ6drad0ViUuhU+a6xnbhoYciLD4j99rfLz63z/ZjmmI+uxGfQbZAoJyu3PHsQd3+Ivxtv73kb5tmAcYXm/QkEgPRTT36T2dlX3H3eZ
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(1800799009)(186009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(356005)(82740400003)(6666004)(81166007)(40460700003)(336012)(426003)(1076003)(40480700001)(16526019)(26005)(47076005)(83380400001)(36756003)(36860700001)(2616005)(316002)(6916009)(2906002)(41300700001)(54906003)(70586007)(70206006)(44832011)(5660300002)(8676002)(4326008)(8936002)(86362001)(478600001)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 16:04:26.5017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7658b5c-e60d-434e-7a6f-08dba3f2a00c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8315
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Jun Lei <jun.lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

We are renaming acquire first free pipe to add
otg master pipe for stream because the former name
doesn't indicate that it acquires the first free pipe
to use as an otg master pipe. This could cause coding
errors if someone uses it to acquire a different pipe type.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 113 +++++++++++-------
 1 file changed, 69 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index e4fb76d8e603..a2705771d790 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1825,7 +1825,7 @@ static int acquire_first_split_pipe(
 			return i;
 		}
 	}
-	return UNABLE_TO_SPLIT;
+	return FREE_PIPE_INDEX_NOT_FOUND;
 }
 
 /* For each OPP head of an OTG master, add top plane at plane index 0.
@@ -1953,6 +1953,66 @@ static bool acquire_secondary_dpp_pipes_and_add_plane(
 	return true;
 }
 
+/*
+ * Acquire a pipe as OTG master and assign to the stream in new dc context.
+ * return - true if OTG master pipe is acquired and new dc context is updated.
+ * false if it fails to acquire an OTG master pipe for this stream.
+ *
+ * In the example below, we acquired pipe 0 as OTG master pipe for the stream.
+ * After the function its Inter-pipe Relation is represented by the diagram
+ * below.
+ *
+ *       Inter-pipe Relation
+ *        __________________________________________________
+ *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
+ *       |        |               |           |             |
+ *       |   0    |               |blank ------------------ |
+ *       |________|_______________|___________|_____________|
+ */
+static bool acquire_otg_master_pipe_for_stream(
+		struct dc_state *new_ctx,
+		const struct resource_pool *pool,
+		struct dc_stream_state *stream)
+{
+	/* TODO: Move this function to DCN specific resource file and acquire
+	 * DSC resource here. The reason is that the function should have the
+	 * same level of responsibility as when we acquire secondary OPP head.
+	 * We acquire DSC when we acquire secondary OPP head, so we should
+	 * acquire DSC when we acquire OTG master.
+	 */
+	int pipe_idx;
+	struct pipe_ctx *pipe_ctx = NULL;
+
+	pipe_idx = resource_find_any_free_pipe(&new_ctx->res_ctx, pool);
+	if (pipe_idx != FREE_PIPE_INDEX_NOT_FOUND) {
+		pipe_ctx = &new_ctx->res_ctx.pipe_ctx[pipe_idx];
+		memset(pipe_ctx, 0, sizeof(*pipe_ctx));
+		pipe_ctx->pipe_idx = pipe_idx;
+		pipe_ctx->stream_res.tg = pool->timing_generators[pipe_idx];
+		pipe_ctx->plane_res.mi = pool->mis[pipe_idx];
+		pipe_ctx->plane_res.hubp = pool->hubps[pipe_idx];
+		pipe_ctx->plane_res.ipp = pool->ipps[pipe_idx];
+		pipe_ctx->plane_res.xfm = pool->transforms[pipe_idx];
+		pipe_ctx->plane_res.dpp = pool->dpps[pipe_idx];
+		pipe_ctx->stream_res.opp = pool->opps[pipe_idx];
+		if (pool->dpps[pipe_idx])
+			pipe_ctx->plane_res.mpcc_inst = pool->dpps[pipe_idx]->inst;
+
+		if (pipe_idx >= pool->timing_generator_count) {
+			int tg_inst = pool->timing_generator_count - 1;
+
+			pipe_ctx->stream_res.tg = pool->timing_generators[tg_inst];
+			pipe_ctx->stream_res.opp = pool->opps[tg_inst];
+		}
+
+		pipe_ctx->stream = stream;
+	} else {
+		pipe_idx = acquire_first_split_pipe(&new_ctx->res_ctx, pool, stream);
+	}
+
+	return pipe_idx != FREE_PIPE_INDEX_NOT_FOUND;
+}
+
 bool dc_add_plane_to_context(
 		const struct dc *dc,
 		struct dc_stream_state *stream,
@@ -2372,42 +2432,6 @@ void update_audio_usage(
 	}
 }
 
-static int acquire_first_free_pipe(
-		struct resource_context *res_ctx,
-		const struct resource_pool *pool,
-		struct dc_stream_state *stream)
-{
-	int i;
-
-	for (i = 0; i < pool->pipe_count; i++) {
-		if (!res_ctx->pipe_ctx[i].stream) {
-			struct pipe_ctx *pipe_ctx = &res_ctx->pipe_ctx[i];
-
-			pipe_ctx->stream_res.tg = pool->timing_generators[i];
-			pipe_ctx->plane_res.mi = pool->mis[i];
-			pipe_ctx->plane_res.hubp = pool->hubps[i];
-			pipe_ctx->plane_res.ipp = pool->ipps[i];
-			pipe_ctx->plane_res.xfm = pool->transforms[i];
-			pipe_ctx->plane_res.dpp = pool->dpps[i];
-			pipe_ctx->stream_res.opp = pool->opps[i];
-			if (pool->dpps[i])
-				pipe_ctx->plane_res.mpcc_inst = pool->dpps[i]->inst;
-			pipe_ctx->pipe_idx = i;
-
-			if (i >= pool->timing_generator_count) {
-				int tg_inst = pool->timing_generator_count - 1;
-
-				pipe_ctx->stream_res.tg = pool->timing_generators[tg_inst];
-				pipe_ctx->stream_res.opp = pool->opps[tg_inst];
-			}
-
-			pipe_ctx->stream = stream;
-			return i;
-		}
-	}
-	return -1;
-}
-
 static struct hpo_dp_stream_encoder *find_first_free_match_hpo_dp_stream_enc_for_link(
 		struct resource_context *res_ctx,
 		const struct resource_pool *pool,
@@ -2770,6 +2794,7 @@ enum dc_status resource_map_pool_resources(
 	struct dc_context *dc_ctx = dc->ctx;
 	struct pipe_ctx *pipe_ctx = NULL;
 	int pipe_idx = -1;
+	bool acquired = false;
 
 	calculate_phy_pix_clks(stream);
 
@@ -2783,20 +2808,20 @@ enum dc_status resource_map_pool_resources(
 		if (pipe_idx < 0)
 			/* hw resource was assigned to other stream */
 			stream->apply_seamless_boot_optimization = false;
+		else
+			acquired = true;
 	}
 
-	if (pipe_idx < 0)
+	if (!acquired)
 		/* acquire new resources */
-		pipe_idx = acquire_first_free_pipe(&context->res_ctx, pool, stream);
+		acquired = acquire_otg_master_pipe_for_stream(
+				context, pool, stream);
 
-	if (pipe_idx < 0)
-		pipe_idx = acquire_first_split_pipe(&context->res_ctx, pool, stream);
+	pipe_ctx = resource_get_otg_master_for_stream(&context->res_ctx, stream);
 
-	if (pipe_idx < 0 || context->res_ctx.pipe_ctx[pipe_idx].stream_res.tg == NULL)
+	if (!pipe_ctx || pipe_ctx->stream_res.tg == NULL)
 		return DC_NO_CONTROLLER_RESOURCE;
 
-	pipe_ctx = &context->res_ctx.pipe_ctx[pipe_idx];
-
 	pipe_ctx->stream_res.stream_enc =
 		dc->res_pool->funcs->find_first_free_match_stream_enc_for_link(
 			&context->res_ctx, pool, stream);
-- 
2.41.0


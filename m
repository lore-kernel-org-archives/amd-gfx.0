Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF90DEE4993
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 16:04:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F81410E469;
	Wed, 23 Aug 2023 16:04:39 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B16210E469
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 16:04:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTZUgrpryr0OlwjxMmr6s/S6JVXSLEUAKQDjdVvwd7K5K7VieJumCpfm9oIHPzj+ZI4a0P/9cNDDjQVxQY8GE5w788d1axTNGvrCoo4+QOzYZorO8IceuQveIKLE861RjudNzA1IHkj2/Y2FB9cZJn06EDwPA9rHPrEvVxGO8Qo93vzKb+ZxBdieF9zSud8c83fEzSPnwcN7Jpp4UiAs8PZ9w3SfI4uMtXIKX/hev0uLe4eSrGISZ+fCMXMpIK4R9262UH/kXbZ5/uNz3XIR1o+zoe6FY67sWT1WTiau9BgKq8vI5dOGBfUaWl2qwXtZz/qhhg9oj3VbUnQGJxM2kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sJL9md98b5K6RA9urpmZRs4rXcx37E7Ac6ol7knyNpI=;
 b=AM+ErA+6SNrjQBK9AQ8d/cPqVbUbu422CyX80KcMw04uSY0Ah6qUghq+sSnjBJI545mvmsp6T1M1ZXCo6ZMXOMsXJXgv2b16Fhlcf8UpOkj3s+98CLBoPAspwweJnH2cU2QifgZDIut9AzD0DKkI2Fm826b2tpGg+gDXtDXVXhdzWYgvWlIwtYWNFBHaWQXsrl12K9OhRrqs3isntDnWIXP5kbXLOklsxEv4z/0hiWU8NYkhzeE0N7DBtbtIxNMrORbXJ0jO5EJbqqmnQ38F73nrT6SRvP08Eh2zF1sAoILa237ThjaFulIJdnDZWWHh+AQYIYfD5dyaRFI7NYLviA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sJL9md98b5K6RA9urpmZRs4rXcx37E7Ac6ol7knyNpI=;
 b=TJJQq3pedbUy/nXhCBpgVpZTqYcuGzrz5tRmUgwn88BSrKxlFY30ttAnMhRo5ZESQzmwuQeDDc9XKOsCMuGPxNLq8B+97dusBWDK6sdrirzPl8jblGKAQkoyrdqYBmJoSGuOSq/aN2hMz8yxKpniPsinOpyJNW6CPy7cFARASJA=
Received: from PH7PR17CA0043.namprd17.prod.outlook.com (2603:10b6:510:323::9)
 by DS0PR12MB7701.namprd12.prod.outlook.com (2603:10b6:8:133::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 16:04:30 +0000
Received: from SN1PEPF0002529F.namprd05.prod.outlook.com
 (2603:10b6:510:323:cafe::11) by PH7PR17CA0043.outlook.office365.com
 (2603:10b6:510:323::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 16:04:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002529F.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 16:04:29 +0000
Received: from hamza-pc.localhost (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 11:04:27 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/21] drm/amd/display: add new resource interfaces to update
 odm mpc slice count
Date: Wed, 23 Aug 2023 11:58:12 -0400
Message-ID: <20230823160347.176991-11-hamza.mahfooz@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529F:EE_|DS0PR12MB7701:EE_
X-MS-Office365-Filtering-Correlation-Id: 857f28b1-1430-475a-b1c9-08dba3f2a1e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7ShcGC5fxPfduRsoqz3ZetLfCEQ+Byf/k2SEzCeOSd33ha9qqKm+uvmLMm0f+zykYlmTbsPmqMTcnilQruhYvdD2K4YzCNcdcX0dORMO9QIuM7j1Xh5uv8/SOulkZV1yvcQeUr8nrNPCEaZz4CE4ANF6L6+xgTd//nbOSgG/Yh6VLLKr/flh+1C6VnogtPnGNTtRQhaQHM3+fMzEziM5M6WTvDnLtaAHTsymfEoYRAt2j5mDyovC0mY4r0CqfMR+4nLNcvD7WPf3P2/5aSpidmmUpEgZzWvzUh1jL1UQ/Bko0Ue++T9VaSZLyOvNb4bwOYD7Ddii27iz5iZmCKza34sLz3P1pKzcpnSlSL2hNzAEHizGNW2xF8zmmspT4iMjk/X9/6msjnBcW2pyjWyX3m7Zhte4a/0tjznvuwjYbQD3bMd36hE+CkHVFj3em24HVpXA3Y7DF3IFLFXYqQ2UQfOnBtG8k7HzhzxQG62ACo0igainmjMtWQUH6xaQS2yBpu+ugpHzf7LuyH2p9+1PHwqfUdjbRRxlAITMmEmOr/Ned1a8ftKfb3zfXCfPCaCFWRkQ2jun6mc8mNMgDJhiB9yRmh+S+B7C8wliyWPiQOk5zutP26cJwj7JRufjtxSn0JfYUqkbIAzvpsPIbqE/hCtqGD41wk5H5W4h/AITOlXUVeLUdQ4M1USC81fgCe/r1C8Js6xEkYMH0n8O90LGF+f+EJC3vRL1W78dXdpTr6F2raJpuFT4Jar/Yn/PQr8kG1Iw5+nSalsEUGzi6RJPfLUQkogKlWOCz3o/dzrABKiEJ/q0MokTW1Dk5eyPRFKy
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39860400002)(1800799009)(451199024)(82310400011)(186009)(36840700001)(40470700004)(46966006)(6666004)(40480700001)(8676002)(8936002)(4326008)(478600001)(316002)(6916009)(54906003)(70206006)(70586007)(41300700001)(47076005)(81166007)(82740400003)(356005)(36860700001)(426003)(36756003)(26005)(16526019)(83380400001)(336012)(40460700003)(44832011)(5660300002)(1076003)(2616005)(86362001)(2906002)(15650500001)(30864003)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 16:04:29.6095 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 857f28b1-1430-475a-b1c9-08dba3f2a1e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002529F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7701
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

Define two new interfaces to update mpc and odm slice count.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 369 +++++++++++++++++-
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  69 +++-
 2 files changed, 432 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 20f9da625267..b7ab357d1b9d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -763,7 +763,7 @@ int resource_get_num_odm_splits(const struct pipe_ctx *pipe)
 	return odm_split_count;
 }
 
-static int get_odm_split_index(struct pipe_ctx *pipe_ctx)
+int resource_get_odm_split_index(struct pipe_ctx *pipe_ctx)
 {
 	int index = 0;
 
@@ -779,7 +779,7 @@ static int get_odm_split_index(struct pipe_ctx *pipe_ctx)
 	return index;
 }
 
-static int get_mpc_split_index(struct pipe_ctx *pipe_ctx)
+int resource_get_mpc_split_index(struct pipe_ctx *pipe_ctx)
 {
 	struct pipe_ctx *split_pipe = pipe_ctx->top_pipe;
 	int index = 0;
@@ -845,7 +845,7 @@ static struct rect calculate_odm_slice_in_timing_active(struct pipe_ctx *pipe_ct
 {
 	const struct dc_stream_state *stream = pipe_ctx->stream;
 	int odm_slice_count = resource_get_num_odm_splits(pipe_ctx) + 1;
-	int odm_slice_idx = get_odm_split_index(pipe_ctx);
+	int odm_slice_idx = resource_get_odm_split_index(pipe_ctx);
 	bool is_last_odm_slice = (odm_slice_idx + 1) == odm_slice_count;
 	int h_active = stream->timing.h_addressable +
 			stream->timing.h_border_left +
@@ -963,7 +963,7 @@ static struct rect calculate_mpc_slice_in_timing_active(
 {
 	const struct dc_stream_state *stream = pipe_ctx->stream;
 	int mpc_slice_count = resource_get_num_mpc_splits(pipe_ctx) + 1;
-	int mpc_slice_idx = get_mpc_split_index(pipe_ctx);
+	int mpc_slice_idx = resource_get_mpc_split_index(pipe_ctx);
 	int epimo = mpc_slice_count - plane_clip_rec->width % mpc_slice_count - 1;
 	struct rect mpc_rec;
 
@@ -1814,6 +1814,59 @@ static struct pipe_ctx *get_tail_pipe(
 	return head_pipe;
 }
 
+static struct pipe_ctx *get_last_opp_head(
+		struct pipe_ctx *opp_head)
+{
+	ASSERT(resource_is_pipe_type(opp_head, OPP_HEAD));
+	while (opp_head->next_odm_pipe)
+		opp_head = opp_head->next_odm_pipe;
+	return opp_head;
+}
+
+static struct pipe_ctx *get_last_dpp_pipe_in_mpcc_combine(
+		struct pipe_ctx *dpp_pipe)
+{
+	ASSERT(resource_is_pipe_type(dpp_pipe, DPP_PIPE));
+	while (dpp_pipe->bottom_pipe &&
+			dpp_pipe->plane_state == dpp_pipe->bottom_pipe->plane_state)
+		dpp_pipe = dpp_pipe->bottom_pipe;
+	return dpp_pipe;
+}
+
+static bool update_pipe_params_after_odm_slice_count_change(
+		const struct dc_stream_state *stream,
+		struct dc_state *context,
+		const struct resource_pool *pool)
+{
+	int i;
+	struct pipe_ctx *pipe;
+	bool result = true;
+
+	for (i = 0; i < pool->pipe_count && result; i++) {
+		pipe = &context->res_ctx.pipe_ctx[i];
+		if (pipe->stream == stream && pipe->plane_state)
+			result = resource_build_scaling_params(pipe);
+	}
+	return result;
+}
+
+static bool update_pipe_params_after_mpc_slice_count_change(
+		const struct dc_plane_state *plane,
+		struct dc_state *context,
+		const struct resource_pool *pool)
+{
+	int i;
+	struct pipe_ctx *pipe;
+	bool result = true;
+
+	for (i = 0; i < pool->pipe_count && result; i++) {
+		pipe = &context->res_ctx.pipe_ctx[i];
+		if (pipe->plane_state == plane)
+			result = resource_build_scaling_params(pipe);
+	}
+	return result;
+}
+
 static int acquire_first_split_pipe(
 		struct resource_context *res_ctx,
 		const struct resource_pool *pool,
@@ -2034,6 +2087,302 @@ static bool acquire_otg_master_pipe_for_stream(
 	return pipe_idx != FREE_PIPE_INDEX_NOT_FOUND;
 }
 
+/*
+ * Increase ODM slice count by 1 by acquiring pipes and adding a new ODM slice
+ * at the last index.
+ * return - true if a new ODM slice is added and required pipes are acquired.
+ * false if new_ctx is no longer a valid state after new ODM slice is added.
+ *
+ * This is achieved by duplicating MPC blending tree from previous ODM slice.
+ * In the following example, we have a single MPC tree and 1 ODM slice 0. We
+ * want to add a new odm slice by duplicating the MPC blending tree and add
+ * ODM slice 1.
+ *
+ *       Inter-pipe Relation (Before Acquiring and Adding ODM Slice)
+ *        __________________________________________________
+ *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
+ *       |        |  plane 0      | slice 0   |             |
+ *       |   0    | -------------MPC---------ODM----------- |
+ *       |        |  plane 1    | |           |             |
+ *       |   1    | ------------- |           |             |
+ *       |________|_______________|___________|_____________|
+ *
+ *       Inter-pipe Relation (After Acquiring and Adding ODM Slice)
+ *        __________________________________________________
+ *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
+ *       |        |  plane 0      | slice 0   |             |
+ *       |   0    | -------------MPC---------ODM----------- |
+ *       |        |  plane 1    | |         | |             |
+ *       |   1    | ------------- |         | |             |
+ *       |        |  plane 0      | slice 1 | |             |
+ *       |   2    | -------------MPC--------- |             |
+ *       |        |  plane 1    | |           |             |
+ *       |   3    | ------------- |           |             |
+ *       |________|_______________|___________|_____________|
+ */
+static bool acquire_pipes_and_add_odm_slice(
+		struct pipe_ctx *otg_master_pipe,
+		struct dc_state *new_ctx,
+		const struct dc_state *cur_ctx,
+		const struct resource_pool *pool)
+{
+	struct pipe_ctx *last_opp_head = get_last_opp_head(otg_master_pipe);
+	struct pipe_ctx *new_opp_head = pool->funcs->acquire_free_pipe_as_secondary_opp_head(
+					cur_ctx, new_ctx, pool,
+					otg_master_pipe);
+	struct pipe_ctx *last_top_dpp_pipe, *last_bottom_dpp_pipe,
+			*new_top_dpp_pipe, *new_bottom_dpp_pipe;
+
+	if (!new_opp_head)
+		return false;
+
+	last_opp_head->next_odm_pipe = new_opp_head;
+	new_opp_head->prev_odm_pipe = last_opp_head;
+	new_opp_head->next_odm_pipe = NULL;
+	new_opp_head->plane_state = last_opp_head->plane_state;
+	last_top_dpp_pipe = last_opp_head;
+	new_top_dpp_pipe = new_opp_head;
+
+	while (last_top_dpp_pipe->bottom_pipe) {
+		last_bottom_dpp_pipe = last_top_dpp_pipe->bottom_pipe;
+		new_bottom_dpp_pipe = pool->funcs->acquire_free_pipe_as_secondary_dpp_pipe(
+				cur_ctx, new_ctx, pool,
+				new_opp_head);
+		if (!new_bottom_dpp_pipe)
+			return false;
+
+		new_bottom_dpp_pipe->plane_state = last_bottom_dpp_pipe->plane_state;
+		new_top_dpp_pipe->bottom_pipe = new_bottom_dpp_pipe;
+		new_bottom_dpp_pipe->top_pipe = new_top_dpp_pipe;
+		last_bottom_dpp_pipe->next_odm_pipe = new_bottom_dpp_pipe;
+		new_bottom_dpp_pipe->prev_odm_pipe = last_bottom_dpp_pipe;
+		new_bottom_dpp_pipe->next_odm_pipe = NULL;
+		last_top_dpp_pipe = last_bottom_dpp_pipe;
+	}
+
+	return true;
+}
+
+/*
+ * Decrease ODM slice count by 1 by releasing pipes and removing the ODM slice
+ * at the last index.
+ * return - true if the last ODM slice is removed and related pipes are
+ * released. false if there is no removable ODM slice.
+ *
+ * In the following example, we have 2 MPC trees and ODM slice 0 and slice 1.
+ * We want to remove the last ODM i.e slice 1. We are releasing secondary DPP
+ * pipe 3 and OPP head pipe 2.
+ *
+ *       Inter-pipe Relation (Before Releasing and Removing ODM Slice)
+ *        __________________________________________________
+ *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
+ *       |        |  plane 0      | slice 0   |             |
+ *       |   0    | -------------MPC---------ODM----------- |
+ *       |        |  plane 1    | |         | |             |
+ *       |   1    | ------------- |         | |             |
+ *       |        |  plane 0      | slice 1 | |             |
+ *       |   2    | -------------MPC--------- |             |
+ *       |        |  plane 1    | |           |             |
+ *       |   3    | ------------- |           |             |
+ *       |________|_______________|___________|_____________|
+ *
+ *       Inter-pipe Relation (After Releasing and Removing ODM Slice)
+ *        __________________________________________________
+ *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
+ *       |        |  plane 0      | slice 0   |             |
+ *       |   0    | -------------MPC---------ODM----------- |
+ *       |        |  plane 1    | |           |             |
+ *       |   1    | ------------- |           |             |
+ *       |________|_______________|___________|_____________|
+ */
+static bool release_pipes_and_remove_odm_slice(
+		struct pipe_ctx *otg_master_pipe,
+		struct dc_state *context,
+		const struct resource_pool *pool)
+{
+	struct pipe_ctx *last_opp_head = get_last_opp_head(otg_master_pipe);
+	struct pipe_ctx *tail_pipe = get_tail_pipe(last_opp_head);
+
+	if (resource_is_pipe_type(last_opp_head, OTG_MASTER))
+		return false;
+
+	while (tail_pipe->top_pipe) {
+		tail_pipe->prev_odm_pipe->next_odm_pipe = NULL;
+		tail_pipe = tail_pipe->top_pipe;
+		pool->funcs->release_pipe(context, tail_pipe->bottom_pipe, pool);
+		tail_pipe->bottom_pipe = NULL;
+	}
+	last_opp_head->prev_odm_pipe->next_odm_pipe = NULL;
+	pool->funcs->release_pipe(context, last_opp_head, pool);
+
+	return true;
+}
+
+/*
+ * Increase MPC slice count by 1 by acquiring a new DPP pipe and add it as the
+ * last MPC slice of the plane associated with dpp_pipe.
+ *
+ * return - true if a new MPC slice is added and required pipes are acquired.
+ * false if new_ctx is no longer a valid state after new MPC slice is added.
+ *
+ * In the following example, we add a new MPC slice for plane 0 into the
+ * new_ctx. To do so we pass pipe 0 as dpp_pipe. The function acquires a new DPP
+ * pipe 2 for plane 0 as the bottom most pipe for plane 0.
+ *
+ *       Inter-pipe Relation (Before Acquiring and Adding MPC Slice)
+ *        __________________________________________________
+ *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
+ *       |        |  plane 0      |           |             |
+ *       |   0    | -------------MPC----------------------- |
+ *       |        |  plane 1    | |           |             |
+ *       |   1    | ------------- |           |             |
+ *       |________|_______________|___________|_____________|
+ *
+ *       Inter-pipe Relation (After Acquiring and Adding MPC Slice)
+ *        __________________________________________________
+ *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
+ *       |        |  plane 0      |           |             |
+ *       |   0    | -------------MPC----------------------- |
+ *       |        |  plane 0    | |           |             |
+ *       |   2    | ------------- |           |             |
+ *       |        |  plane 1    | |           |             |
+ *       |   1    | ------------- |           |             |
+ *       |________|_______________|___________|_____________|
+ */
+static bool acquire_dpp_pipe_and_add_mpc_slice(
+		struct pipe_ctx *dpp_pipe,
+		struct dc_state *new_ctx,
+		const struct dc_state *cur_ctx,
+		const struct resource_pool *pool)
+{
+	struct pipe_ctx *last_dpp_pipe =
+			get_last_dpp_pipe_in_mpcc_combine(dpp_pipe);
+	struct pipe_ctx *opp_head = resource_get_opp_head(dpp_pipe);
+	struct pipe_ctx *new_dpp_pipe = pool->funcs->acquire_free_pipe_as_secondary_dpp_pipe(
+			cur_ctx, new_ctx, pool, opp_head);
+
+	if (!new_dpp_pipe || resource_get_num_odm_splits(dpp_pipe) > 0)
+		return false;
+
+	new_dpp_pipe->bottom_pipe = last_dpp_pipe->bottom_pipe;
+	if (new_dpp_pipe->bottom_pipe)
+		new_dpp_pipe->bottom_pipe->top_pipe = new_dpp_pipe;
+	new_dpp_pipe->top_pipe = last_dpp_pipe;
+	last_dpp_pipe->bottom_pipe = new_dpp_pipe;
+	new_dpp_pipe->plane_state = last_dpp_pipe->plane_state;
+
+	return true;
+}
+
+/*
+ * Reduce MPC slice count by 1 by releasing the bottom DPP pipe in MPCC combine
+ * with dpp_pipe and removing last MPC slice of the plane associated with
+ * dpp_pipe.
+ *
+ * return - true if the last MPC slice of the plane associated with dpp_pipe is
+ * removed and last DPP pipe in MPCC combine with dpp_pipe is released.
+ * false if there is no removable MPC slice.
+ *
+ * In the following example, we remove an MPC slice for plane 0 from the
+ * context. To do so we pass pipe 0 as dpp_pipe. The function releases pipe 1 as
+ * it is the last pipe for plane 0.
+ *
+ *       Inter-pipe Relation (Before Releasing and Removing MPC Slice)
+ *        __________________________________________________
+ *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
+ *       |        |  plane 0      |           |             |
+ *       |   0    | -------------MPC----------------------- |
+ *       |        |  plane 0    | |           |             |
+ *       |   1    | ------------- |           |             |
+ *       |        |  plane 1    | |           |             |
+ *       |   2    | ------------- |           |             |
+ *       |________|_______________|___________|_____________|
+ *
+ *       Inter-pipe Relation (After Releasing and Removing MPC Slice)
+ *        __________________________________________________
+ *       |PIPE IDX|   DPP PIPES   | OPP HEADS | OTG MASTER  |
+ *       |        |  plane 0      |           |             |
+ *       |   0    | -------------MPC----------------------- |
+ *       |        |  plane 1    | |           |             |
+ *       |   2    | ------------- |           |             |
+ *       |________|_______________|___________|_____________|
+ */
+static bool release_dpp_pipe_and_remove_mpc_slice(
+		struct pipe_ctx *dpp_pipe,
+		struct dc_state *context,
+		const struct resource_pool *pool)
+{
+	struct pipe_ctx *last_dpp_pipe =
+			get_last_dpp_pipe_in_mpcc_combine(dpp_pipe);
+
+	if (resource_is_pipe_type(last_dpp_pipe, OPP_HEAD) ||
+			resource_get_num_odm_splits(dpp_pipe) > 0)
+		return false;
+
+	last_dpp_pipe->top_pipe->bottom_pipe = last_dpp_pipe->bottom_pipe;
+	if (last_dpp_pipe->bottom_pipe)
+		last_dpp_pipe->bottom_pipe->top_pipe = last_dpp_pipe->top_pipe;
+	pool->funcs->release_pipe(context, last_dpp_pipe, pool);
+
+	return true;
+}
+
+bool resource_update_pipes_with_odm_slice_count(
+		struct pipe_ctx *otg_master,
+		struct dc_state *new_ctx,
+		const struct dc_state *cur_ctx,
+		const struct resource_pool *pool,
+		int new_slice_count)
+{
+	int i;
+	int cur_slice_count = resource_get_num_odm_splits(otg_master) + 1;
+	bool result = true;
+
+	if (new_slice_count == cur_slice_count)
+		return result;
+
+	if (new_slice_count > cur_slice_count)
+		for (i = 0; i < new_slice_count - cur_slice_count && result; i++)
+			result = acquire_pipes_and_add_odm_slice(
+					otg_master, new_ctx, cur_ctx, pool);
+	else
+		for (i = 0; i < cur_slice_count - new_slice_count && result; i++)
+			result = release_pipes_and_remove_odm_slice(
+					otg_master, new_ctx, pool);
+	if (result)
+		result = update_pipe_params_after_odm_slice_count_change(
+				otg_master->stream, new_ctx, pool);
+	return result;
+}
+
+bool resource_update_pipes_with_mpc_slice_count(
+		struct pipe_ctx *dpp_pipe,
+		struct dc_state *new_ctx,
+		const struct dc_state *cur_ctx,
+		const struct resource_pool *pool,
+		int new_slice_count)
+{
+	int i;
+	int cur_slice_count = resource_get_num_mpc_splits(dpp_pipe) + 1;
+	bool result = true;
+
+	if (new_slice_count == cur_slice_count)
+		return result;
+
+	if (new_slice_count > cur_slice_count)
+		for (i = 0; i < new_slice_count - cur_slice_count && result; i++)
+			result = acquire_dpp_pipe_and_add_mpc_slice(
+					dpp_pipe, new_ctx, cur_ctx, pool);
+	else
+		for (i = 0; i < cur_slice_count - new_slice_count && result; i++)
+			result = release_dpp_pipe_and_remove_mpc_slice(
+					dpp_pipe, new_ctx, pool);
+	if (result)
+		result = update_pipe_params_after_mpc_slice_count_change(
+				dpp_pipe->plane_state, new_ctx, pool);
+	return result;
+}
+
 bool dc_add_plane_to_context(
 		const struct dc *dc,
 		struct dc_stream_state *stream,
@@ -4342,7 +4691,17 @@ bool is_h_timing_divisible_by_2(struct dc_stream_state *stream)
 	return divisible;
 }
 
-bool dc_resource_acquire_secondary_pipe_for_mpc_odm(
+/* This interface is deprecated for new DCNs. It is replaced by the following
+ * new interfaces. These two interfaces encapsulate pipe selection priority
+ * with DCN specific minimum hardware transition optimization algorithm. With
+ * the new interfaces caller no longer needs to know the implementation detail
+ * of a pipe topology.
+ *
+ * resource_update_pipes_with_odm_slice_count
+ * resource_update_pipes_with_mpc_slice_count
+ *
+ */
+bool dc_resource_acquire_secondary_pipe_for_mpc_odm_legacy(
 		const struct dc *dc,
 		struct dc_state *state,
 		struct pipe_ctx *pri_pipe,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 7a503d87fe9f..4344c5a239e1 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -213,6 +213,21 @@ bool resource_attach_surfaces_to_context(
  *       |        |               |           |             |
  *       |   5    |  (FREE)       |           |             |
  *       |________|_______________|___________|_____________|
+ *
+ * The following is a quick reference of the class relation:
+ *
+ *	DC state            ---1--------0..N---           streams
+ *
+ *	stream              ---1-----------1---           OTG Master pipe
+ *
+ *	OTG Master pipe     ---1--------1..N---           OPP Head pipes
+ *
+ *	OPP Head pipe       ---1--------0..N---           DPP pipes
+ *
+ *	stream              ---1--------0..N---           Planes
+ *
+ *	Plane               ---1--------1..N---           DPP pipes
+ *
  */
 enum pipe_type {
 	/* free pipe - free pipe is an uninitialized pipe without a stream
@@ -354,6 +369,9 @@ struct pipe_ctx *resource_find_free_secondary_pipe_legacy(
  */
 int resource_get_num_mpc_splits(const struct pipe_ctx *pipe);
 
+int resource_get_mpc_split_index(struct pipe_ctx *pipe_ctx);
+
+
 /*
  * Get number of ODM "cuts" of the timing associated with the pipe. ODM slice
  * count is equal to ODM splits + 1. For example if a timing is cut 3 times, it
@@ -363,6 +381,8 @@ int resource_get_num_mpc_splits(const struct pipe_ctx *pipe);
  */
 int resource_get_num_odm_splits(const struct pipe_ctx *pipe);
 
+int resource_get_odm_split_index(struct pipe_ctx *pipe_ctx);
+
 /*
  * Get the OTG master pipe in resource context associated with the stream.
  * return - NULL if not found. Otherwise the OTG master pipe associated with the
@@ -386,6 +406,53 @@ struct pipe_ctx *resource_get_otg_master(const struct pipe_ctx *pipe_ctx);
  */
 struct pipe_ctx *resource_get_opp_head(const struct pipe_ctx *pipe_ctx);
 
+/*
+ * Update ODM slice count by acquiring or releasing pipes. If new slices need
+ * to be added, it is going to add them to the last ODM index. If existing
+ * slices need to be removed, it is going to remove them from the last ODM
+ * index.
+ *
+ * return - true if ODM slices are updated and required pipes are acquired. All
+ * affected pipe parameters are updated.
+ *
+ * false if resource fails to complete this update. The function is not designed
+ * to recover the creation of invalid topologies. Returning false is typically
+ * an indication of insufficient validation in caller's stack. The function will
+ * return the new_ctx up until the last valid step performed in the function.
+ * Caller may use the returned new_ctx for debugging the error or it may attempt
+ * to restore new_ctx by calling this function again with original slice count.
+ */
+bool resource_update_pipes_with_odm_slice_count(
+		struct pipe_ctx *otg_master_pipe,
+		struct dc_state *new_ctx,
+		const struct dc_state *cur_ctx,
+		const struct resource_pool *pool,
+		int slice_count);
+
+/*
+ * Update MPC slice count by acquiring or releasing DPP pipes. If new slices
+ * need to be added it is going to add to the last MPC index. If existing
+ * slices need to be removed, it is going to remove them from the last MPC
+ * index.
+ *
+ * @dpp_pipe - top most dpp pipe for MPCC combine.
+ *
+ * return - true if MPC slices are updated and required pipes are acquired. All
+ * affected pipe parameters are updated.
+ *
+ * false if resource fails to complete this update. The function is not designed
+ * to recover the creation of invalid topologies. Returning false is typically
+ * an indication of insufficient validation in caller's stack. The function will
+ * return the new_ctx up until the last valid step performed in the function.
+ * Caller may use the returned new_ctx for debugging the error or it may attempt
+ * to restore new_ctx by calling this function again with original slice count.
+ */
+bool resource_update_pipes_with_mpc_slice_count(
+		struct pipe_ctx *dpp_pipe,
+		struct dc_state *new_ctx,
+		const struct dc_state *cur_ctx,
+		const struct resource_pool *pool,
+		int slice_count);
 
 bool resource_validate_attach_surfaces(
 		const struct dc_validation_set set[],
@@ -451,7 +518,7 @@ const struct link_hwss *get_link_hwss(const struct dc_link *link,
 
 bool is_h_timing_divisible_by_2(struct dc_stream_state *stream);
 
-bool dc_resource_acquire_secondary_pipe_for_mpc_odm(
+bool dc_resource_acquire_secondary_pipe_for_mpc_odm_legacy(
 		const struct dc *dc,
 		struct dc_state *state,
 		struct pipe_ctx *pri_pipe,
-- 
2.41.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE29E936E7
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 21:22:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDBBF10E3C3;
	Wed,  4 Oct 2023 21:22:21 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2063.outbound.protection.outlook.com [40.107.95.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1696D89EAC
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 21:22:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eT+J1PKp1LGDOQ1LswMmVSY59hY7X0Qjmiiw5mjOaS2aJtFNlQkhk76Xi/sqRMALiiwcmIPq/u/Z+w3Ywvdze1AFcslBVtuQv1f2GOU3U2IgCXI5OavepWWXvQv7VpUeB2iy6j1JU8Sb4ZHCy8vMuZDO99bxHvQbqmg3R7Lg39dqOY9glgW2pm8jgDo1nrGrrbaQcw2tYUeTa3rebzXjTiTR1ILY1awSOe80tuStxE0/b60Vab1XtQOGc2BonUFFTn14YP9cOqRHjFQJXAR3wWiZi7AuFYBDD5b4xfTzMvsXpC1lKIgyi4uVTFmiWTbOIvKbkG95Je74siCkJoKZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRSsoal7kyrSL05UXD6arJB1wzwVt48z8zPH7Nq3i8E=;
 b=BmLljZD+Tha0hthGMcJ5zBepkL1MZT9afeQ6HFkQWQvFXMnBEhBB1WHp6tAcNpgEwB1ee7UFuBBnWIomdj3wLfYtjRkfZYE5DDbKEIDPu1VpHCEOja1GEdV8d8r4Qrbve4LpWhhRmIcfHZVCtta4IZtBFerGOyaoa06xUVSMTP5R0Tr7pjFh2vM5pLLM5EeBmNl6evWZdoEcNBA8CbY9uHkEER5I+emN+HjBXJF02m6P0i9rCMnjnb7JTvyF9K5MGLB26vfvSu0IxRctFrhDp9bBFsxXTGq4TfKQPK6oVsqfL+F0jMUpW6TtrYjiBfOLRv64/GBv6csREMkbo4LQ1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRSsoal7kyrSL05UXD6arJB1wzwVt48z8zPH7Nq3i8E=;
 b=PH7UNmA8PvAgysYJ7bR4EM0qVO/sWHu1fMqDspjtw5Trsi8PlRr+dhkSdL4zJYIshPnviNECsE+xIBmpbNMs/J9WrjmKwcFsoOlX7hwsCFhZXNX2zHgbC0QkD0dWQrJqvVVGauSS8uwvJlzkod9xeWCFxvt60Tgu0O1mAvZsWNs=
Received: from BL1PR13CA0131.namprd13.prod.outlook.com (2603:10b6:208:2bb::16)
 by SA1PR12MB8742.namprd12.prod.outlook.com (2603:10b6:806:373::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.37; Wed, 4 Oct
 2023 21:21:52 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2bb:cafe::d4) by BL1PR13CA0131.outlook.office365.com
 (2603:10b6:208:2bb::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 21:21:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 21:21:52 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 16:21:50 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 08/16] drm/amd/display: Handle multiple streams sourcing
 same surface
Date: Wed, 4 Oct 2023 15:21:02 -0600
Message-ID: <20231004212110.3753955-9-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
References: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|SA1PR12MB8742:EE_
X-MS-Office365-Filtering-Correlation-Id: 49b35914-a697-4588-687f-08dbc51fedad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B2x9fNQbpegbFDwBRsifrA57+4/LwmpNTRAAmfBJSqnPcOSuyNNPHraetF7upGi+dV5BloLPqaud1zXQ2SFuV/FV26LJAPyjiIM7H9NU6t4JkZN/80omcM+EZ+RuKkRd2w6MUV6unh0I8GVsRQJ/4Fm1Q8Dn0+kBbXdvV6/MxRxPfH72mCdOX/FcBxBPZyc5LfOPF9OLKwcCUAxvssCfl6HLdWNqcRXzZI2EMNBTBJEgjNNNLxGox0GPWu4Fzl9ACm2720wPEY1t0xOvUHvm34xUdqAmhHjW8/46nRjaf9iVfxTUU8htUxxEXcSpA3bpnIUMcHFhlHqlX3b27pUVsVj+jO3oOxtCSdxlmtERs/ldG/p/JzpqmphllKpOPHpbhEwTn60/lLtLs9Jq1WZ2oMA+BloylBxtol0HAg53ehvP/pxIqDLl/77oSxiHGSMVpE2EZT49LusZQ7WCyZQ5UesMLnBSg4cHeWIivhUpoPGd+Zz1kJKNkPcw4hWQvxSjTKRWit8WJ870z7HkeVdACodAcEua/vGXFZArY1CPq5vzWqZsowY8Dhb2UAfM0AsS8z+2EKR1BokVmh6nRUYWMtIPPyxt3kXpF1PEVPhoaqFH4Yc7MNVi1tExi+efsKHOD2MzDMVhrv5uMoWI1zB0mJ2IU10r0SPiLCyrR90LLDD+rxHmXMo79guWdS42Mjf6134FRyO6k6vvVuQcllx9NkXW8VTOYRcRh52uHHJvOe80Y88f3TPdObRM2hoxk/cMO0XxS25vhbojkuC1PiF0KA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(82310400011)(186009)(46966006)(40470700004)(36840700001)(2906002)(5660300002)(8936002)(4326008)(8676002)(30864003)(41300700001)(70586007)(2616005)(40460700003)(6916009)(316002)(54906003)(70206006)(40480700001)(26005)(16526019)(336012)(426003)(6666004)(36756003)(1076003)(86362001)(356005)(81166007)(82740400003)(83380400001)(47076005)(36860700001)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 21:21:52.4811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 49b35914-a697-4588-687f-08dbc51fedad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8742
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
Cc: Charlene Liu <charlene.liu@amd.com>, Sunpeng.Li@amd.com,
 richard.gong@amd.com, Qingqing
 Zhuo <Qingqing.Zhuo@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 jerry.zuo@amd.com, Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com,
 wayne.lin@amd.com, Alex Deucher <alexander.deucher@amd.com>,
 Harry.Wentland@amd.com, Sung Joon Kim <sungkim@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Sung Joon Kim <sungkim@amd.com>

[why]
There are cases where more than 1 stream can be mapped to the same
surface. DML2.0 does not seem to handle these cases.

[how]
Make sure to account for the stream id when deriving the plane id. By
doing this, each plane id will be unique based on the stream id.

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Sung Joon Kim <sungkim@amd.com>
Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
---
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   | 41 ++++++++++++-------
 .../display/dc/dml2/dml2_translation_helper.c | 25 ++++++-----
 .../gpu/drm/amd/display/dc/dml2/dml2_utils.c  | 19 +++++----
 3 files changed, 53 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index 7fd0e1c3d552..8da145fd4d7b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -53,7 +53,8 @@ struct dc_pipe_mapping_scratch {
 	struct dc_plane_pipe_pool pipe_pool;
 };
 
-static bool get_plane_id(const struct dc_state *state, const struct dc_plane_state *plane, unsigned int *plane_id)
+static bool get_plane_id(const struct dc_state *state, const struct dc_plane_state *plane,
+	unsigned int stream_id, unsigned int *plane_id)
 {
 	int i, j;
 
@@ -61,10 +62,12 @@ static bool get_plane_id(const struct dc_state *state, const struct dc_plane_sta
 		return false;
 
 	for (i = 0; i < state->stream_count; i++) {
-		for (j = 0; j < state->stream_status[i].plane_count; j++) {
-			if (state->stream_status[i].plane_states[j] == plane) {
-				*plane_id = (i << 16) | j;
-				return true;
+		if (state->streams[i]->stream_id == stream_id) {
+			for (j = 0; j < state->stream_status[i].plane_count; j++) {
+				if (state->stream_status[i].plane_states[j] == plane) {
+					*plane_id = (i << 16) | j;
+					return true;
+				}
 			}
 		}
 	}
@@ -111,13 +114,15 @@ static struct pipe_ctx *find_master_pipe_of_stream(struct dml2_context *ctx, str
 	return NULL;
 }
 
-static struct pipe_ctx *find_master_pipe_of_plane(struct dml2_context *ctx, struct dc_state *state, unsigned int plane_id)
+static struct pipe_ctx *find_master_pipe_of_plane(struct dml2_context *ctx,
+	struct dc_state *state, unsigned int plane_id)
 {
 	int i;
 	unsigned int plane_id_assigned_to_pipe;
 
 	for (i = 0; i < ctx->config.dcn_pipe_count; i++) {
-		if (state->res_ctx.pipe_ctx[i].plane_state && get_plane_id(state, state->res_ctx.pipe_ctx[i].plane_state, &plane_id_assigned_to_pipe)) {
+		if (state->res_ctx.pipe_ctx[i].plane_state && get_plane_id(state, state->res_ctx.pipe_ctx[i].plane_state,
+			state->res_ctx.pipe_ctx[i].stream->stream_id, &plane_id_assigned_to_pipe)) {
 			if (plane_id_assigned_to_pipe == plane_id)
 				return &state->res_ctx.pipe_ctx[i];
 		}
@@ -126,14 +131,16 @@ static struct pipe_ctx *find_master_pipe_of_plane(struct dml2_context *ctx, stru
 	return NULL;
 }
 
-static unsigned int find_pipes_assigned_to_plane(struct dml2_context *ctx, struct dc_state *state, unsigned int plane_id, unsigned int *pipes)
+static unsigned int find_pipes_assigned_to_plane(struct dml2_context *ctx,
+	struct dc_state *state, unsigned int plane_id, unsigned int *pipes)
 {
 	int i;
 	unsigned int num_found = 0;
 	unsigned int plane_id_assigned_to_pipe;
 
 	for (i = 0; i < ctx->config.dcn_pipe_count; i++) {
-		if (state->res_ctx.pipe_ctx[i].plane_state && get_plane_id(state, state->res_ctx.pipe_ctx[i].plane_state, &plane_id_assigned_to_pipe)) {
+		if (state->res_ctx.pipe_ctx[i].plane_state && get_plane_id(state, state->res_ctx.pipe_ctx[i].plane_state,
+			state->res_ctx.pipe_ctx[i].stream->stream_id, &plane_id_assigned_to_pipe)) {
 			if (plane_id_assigned_to_pipe == plane_id)
 				pipes[num_found++] = i;
 		}
@@ -499,7 +506,7 @@ static struct pipe_ctx *assign_pipes_to_plane(struct dml2_context *ctx, struct d
 	unsigned int next_pipe_to_assign;
 	int odm_slice, mpc_slice;
 
-	if (!get_plane_id(state, plane, &plane_id)) {
+	if (!get_plane_id(state, plane, stream->stream_id, &plane_id)) {
 		ASSERT(false);
 		return master_pipe;
 	}
@@ -545,11 +552,14 @@ static void free_pipe(struct pipe_ctx *pipe)
 	memset(pipe, 0, sizeof(struct pipe_ctx));
 }
 
-static void free_unused_pipes_for_plane(struct dml2_context *ctx, struct dc_state *state, const struct dc_plane_state *plane, const struct dc_plane_pipe_pool *pool)
+static void free_unused_pipes_for_plane(struct dml2_context *ctx, struct dc_state *state,
+	const struct dc_plane_state *plane, const struct dc_plane_pipe_pool *pool, unsigned int stream_id)
 {
 	int i;
 	for (i = 0; i < ctx->config.dcn_pipe_count; i++) {
-		if (state->res_ctx.pipe_ctx[i].plane_state == plane && !is_pipe_used(pool, state->res_ctx.pipe_ctx[i].pipe_idx)) {
+		if (state->res_ctx.pipe_ctx[i].plane_state == plane &&
+			state->res_ctx.pipe_ctx[i].stream->stream_id == stream_id &&
+			!is_pipe_used(pool, state->res_ctx.pipe_ctx[i].pipe_idx)) {
 			free_pipe(&state->res_ctx.pipe_ctx[i]);
 		}
 	}
@@ -600,7 +610,7 @@ static void map_pipes_for_plane(struct dml2_context *ctx, struct dc_state *state
 	struct pipe_ctx *master_pipe = NULL;
 	int i;
 
-	if (!get_plane_id(state, plane, &plane_id)) {
+	if (!get_plane_id(state, plane, stream->stream_id, &plane_id)) {
 		ASSERT(false);
 		return;
 	}
@@ -631,7 +641,7 @@ static void map_pipes_for_plane(struct dml2_context *ctx, struct dc_state *state
 		}
 	}
 
-	free_unused_pipes_for_plane(ctx, state, plane, &scratch->pipe_pool);
+	free_unused_pipes_for_plane(ctx, state, plane, &scratch->pipe_pool, stream->stream_id);
 }
 
 bool dml2_map_dc_pipes(struct dml2_context *ctx, struct dc_state *state, const struct dml_display_cfg_st *disp_cfg, struct dml2_dml_to_dc_pipe_mapping *mapping, const struct dc_state *existing_state)
@@ -688,7 +698,8 @@ bool dml2_map_dc_pipes(struct dml2_context *ctx, struct dc_state *state, const s
 
 		for (plane_index = 0; plane_index < state->stream_status[stream_index].plane_count; plane_index++) {
 			// Planes are ordered top to bottom.
-			if (get_plane_id(state, state->stream_status[stream_index].plane_states[plane_index], &plane_id)) {
+			if (get_plane_id(state, state->stream_status[stream_index].plane_states[plane_index],
+				stream_id, &plane_id)) {
 				plane_disp_cfg_index = find_disp_cfg_idx_by_plane_id(mapping, plane_id);
 
 				// Setup mpc_info for this plane
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
index de58c7b867e8..2dd8eedfc17d 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_translation_helper.c
@@ -926,7 +926,8 @@ static unsigned int map_stream_to_dml_display_cfg(const struct dml2_context *dml
 	return location;
 }
 
-static bool get_plane_id(const struct dc_state *context, const struct dc_plane_state *plane, unsigned int *plane_id)
+static bool get_plane_id(const struct dc_state *context, const struct dc_plane_state *plane,
+		unsigned int stream_id, unsigned int *plane_id)
 {
 	int i, j;
 
@@ -934,10 +935,12 @@ static bool get_plane_id(const struct dc_state *context, const struct dc_plane_s
 		return false;
 
 	for (i = 0; i < context->stream_count; i++) {
-		for (j = 0; j < context->stream_status[i].plane_count; j++) {
-			if (context->stream_status[i].plane_states[j] == plane) {
-				*plane_id = (i << 16) | j;
-				return true;
+		if (context->streams[i]->stream_id == stream_id) {
+			for (j = 0; j < context->stream_status[i].plane_count; j++) {
+				if (context->stream_status[i].plane_states[j] == plane) {
+					*plane_id = (i << 16) | j;
+					return true;
+				}
 			}
 		}
 	}
@@ -945,14 +948,14 @@ static bool get_plane_id(const struct dc_state *context, const struct dc_plane_s
 	return false;
 }
 
-static unsigned int map_plane_to_dml_display_cfg(const struct dml2_context *dml2,
-		const struct dc_plane_state *plane, const struct dc_state *context, const struct dml_display_cfg_st *dml_dispcfg)
+static unsigned int map_plane_to_dml_display_cfg(const struct dml2_context *dml2, const struct dc_plane_state *plane,
+		const struct dc_state *context, const struct dml_display_cfg_st *dml_dispcfg, unsigned int stream_id)
 {
 	unsigned int plane_id;
 	int i = 0;
 	int location = -1;
 
-	if (!get_plane_id(context, plane, &plane_id)) {
+	if (!get_plane_id(context, plane, stream_id, &plane_id)) {
 		ASSERT(false);
 		return -1;
 	}
@@ -1035,7 +1038,8 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, const struct d
 			dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id_valid[disp_cfg_plane_location] = true;
 		} else {
 			for (j = 0; j < context->stream_status[i].plane_count; j++) {
-				disp_cfg_plane_location = map_plane_to_dml_display_cfg(dml2, context->stream_status[i].plane_states[j], context, dml_dispcfg);
+				disp_cfg_plane_location = map_plane_to_dml_display_cfg(dml2,
+					context->stream_status[i].plane_states[j], context, dml_dispcfg, context->streams[i]->stream_id);
 
 				if (disp_cfg_plane_location < 0)
 					disp_cfg_plane_location = dml_dispcfg->num_surfaces++;
@@ -1059,7 +1063,8 @@ void map_dc_state_into_dml_display_cfg(struct dml2_context *dml2, const struct d
 
 				dml_dispcfg->plane.BlendingAndTiming[disp_cfg_plane_location] = disp_cfg_stream_location;
 
-				if (get_plane_id(context, context->stream_status[i].plane_states[j], &dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id[disp_cfg_plane_location]))
+				if (get_plane_id(context, context->stream_status[i].plane_states[j], context->streams[i]->stream_id,
+					&dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id[disp_cfg_plane_location]))
 					dml2->v20.scratch.dml_to_dc_pipe_mapping.disp_cfg_to_plane_id_valid[disp_cfg_plane_location] = true;
 
 				if (j >= 1) {
diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
index da18c4b8c257..946a98af0020 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_utils.c
@@ -207,7 +207,8 @@ static int find_dml_pipe_idx_by_plane_id(struct dml2_context *ctx, unsigned int
 	return -1;
 }
 
-static bool get_plane_id(const struct dc_state *state, const struct dc_plane_state *plane, unsigned int *plane_id)
+static bool get_plane_id(const struct dc_state *state, const struct dc_plane_state *plane,
+	unsigned int stream_id, unsigned int *plane_id)
 {
 	int i, j;
 
@@ -215,10 +216,12 @@ static bool get_plane_id(const struct dc_state *state, const struct dc_plane_sta
 		return false;
 
 	for (i = 0; i < state->stream_count; i++) {
-		for (j = 0; j < state->stream_status[i].plane_count; j++) {
-			if (state->stream_status[i].plane_states[j] == plane) {
-				*plane_id = (i << 16) | j;
-				return true;
+		if (state->streams[i]->stream_id == stream_id) {
+			for (j = 0; j < state->stream_status[i].plane_count; j++) {
+				if (state->stream_status[i].plane_states[j] == plane) {
+					*plane_id = (i << 16) | j;
+					return true;
+				}
 			}
 		}
 	}
@@ -299,7 +302,8 @@ void dml2_calculate_rq_and_dlg_params(const struct dc *dc, struct dc_state *cont
 		 * there is a need to know which DML pipe index maps to which DC pipe. The code below
 		 * finds a dml_pipe_index from the plane id if a plane is valid. If a plane is not valid then
 		 * it finds a dml_pipe_index from the stream id. */
-		if (get_plane_id(context, context->res_ctx.pipe_ctx[dc_pipe_ctx_index].plane_state, &plane_id)) {
+		if (get_plane_id(context, context->res_ctx.pipe_ctx[dc_pipe_ctx_index].plane_state,
+			context->res_ctx.pipe_ctx[dc_pipe_ctx_index].stream->stream_id, &plane_id)) {
 			dml_pipe_idx = find_dml_pipe_idx_by_plane_id(in_ctx, plane_id);
 		} else {
 			dml_pipe_idx = dml2_helper_find_dml_pipe_idx_by_stream_id(in_ctx, context->res_ctx.pipe_ctx[dc_pipe_ctx_index].stream->stream_id);
@@ -435,7 +439,8 @@ bool dml2_verify_det_buffer_configuration(struct dml2_context *in_ctx, struct dc
 	for (i = 0; i < MAX_PIPES; i++) {
 		if (!display_state->res_ctx.pipe_ctx[i].stream)
 			continue;
-		if (get_plane_id(display_state, display_state->res_ctx.pipe_ctx[i].plane_state, &plane_id))
+		if (get_plane_id(display_state, display_state->res_ctx.pipe_ctx[i].plane_state,
+			display_state->res_ctx.pipe_ctx[i].stream->stream_id, &plane_id))
 			dml_pipe_idx = find_dml_pipe_idx_by_plane_id(in_ctx, plane_id);
 		else
 			dml_pipe_idx = dml2_helper_find_dml_pipe_idx_by_stream_id(in_ctx, display_state->res_ctx.pipe_ctx[i].stream->stream_id);
-- 
2.40.1


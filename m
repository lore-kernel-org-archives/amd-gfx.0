Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4170DC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:38:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C72258DF26;
	Fri, 22 Jul 2022 20:38:50 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E674D8DE4B
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:38:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VUvfWP4XWD9LIGzPbil0HpVGBUuOkNCyhzxHpERahMOnQioIm6dMt3rMOpNVoU2gElvOEaUKy7Y3V4MRnqngCJOYYhfQEGJCXPzB0Z4U8gRLIFkY3GLVEGQK5ibG36gz/VRj0c5z3ddPq8VcQIniPZbg/iyIkDbq6Iy4mXZUatfYqQKKaP1dJL4PivIPMvJQnHHA/8FfT3yzsJAo6Nfckb2VluI0Ai1DYXEoZE6xkjSOqTVTp9iImUI0jHnfkF7oG+CVHAjYSQjKbG0IoSduFlNxSwR9l1rb07J6GRBlmEaFhFei/7Th1gF/1BCohoYzhN+AauNoCOiaUKI+vkqxqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZPSvOgFH8oQG3Ke7WyPBwa8uGyGLfaZY4GOI1QtRTik=;
 b=BAznYupUeCl6oWSUB+iP5Z4IJZeUBIU+vuMQH6mKFO1JLaHRj7xKIH56f6zxRdQvonl2DMqm6CTcQdSCNjvV9IWkg7quXwL6/7CUjZUSGmuzPAd5STzcjqY9cwR8gbWsHD7jv+wOyWJ4QF2RlO/w++JKjg5VWHXRxGwNMxIwjOnVzzCHEuS71bXkDEj2sVlM0RngXjyARVh5cM/0/qTgyxs89XTRmZTX+okZG2WUSZcdIPR/R7DDnTNjI29WF/gklqrK0nAxr+B80geddUD5yNMTsf5MXZw2yiN9IQcagBSxlZbsUrl88/04NPB94T2WZqFWeNab3WI2usAtYhpWkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZPSvOgFH8oQG3Ke7WyPBwa8uGyGLfaZY4GOI1QtRTik=;
 b=CeUfDpo2hvKJ8E4AC+mmQHGAALeLRaz1l2KxrLfRFtKqT2bDiTK/SI5Gd5Rpfdne9ErXAgq83sKsYLHsvuKW5UPoJAoxFeYHa3e8P2Nh+6QrW+Fkga5cm3SeaSlcrl9k25OasHpTSy3u2v55hg2/jwMFmpkllt1fk7G9HqC1d1g=
Received: from MW4PR04CA0177.namprd04.prod.outlook.com (2603:10b6:303:85::32)
 by CH2PR12MB5513.namprd12.prod.outlook.com (2603:10b6:610:68::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 20:38:47 +0000
Received: from CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::cf) by MW4PR04CA0177.outlook.office365.com
 (2603:10b6:303:85::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19 via Frontend
 Transport; Fri, 22 Jul 2022 20:38:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT044.mail.protection.outlook.com (10.13.175.188) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:38:47 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:38:44 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/31] drm/amd/display: Fix two MPO videos in single display
 ODM combine mode
Date: Fri, 22 Jul 2022 14:31:12 -0600
Message-ID: <20220722203137.4043516-7-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8d20e2ea-5d93-4f97-1e7e-08da6c222db1
X-MS-TrafficTypeDiagnostic: CH2PR12MB5513:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dJRvslAc0fAyZszsrflaikO+ObWnVftg5e0A4hWag0ZJZSqP/aCcZ1rcjyelaIuj2anGZMJaNmXCnt0PtapT3hfzyWI3QJl/a6Ur+AKMUVvHUVrFyTr0Mz/kQlUIu6WctgNJSINn6L2A2rw2Z9Fx9P8mTkZRMHqyli6vuQ15krOYdzQ9QzoIq7S4YIoUS4snxbDdL7fwLbZLhuxlzbNxkXZ0MSm6zex1+l2D41/0moBuQMJAVOsUdlN4VO36Tl7MYx3pv1mvi+J0VSQVB4jZl0yn+MAfL4TTRLbloIHyiXiLuYCY4VkfV5BkexurIlUhPvLI2QrWc8vSgar7mw4Nivp196XsuS/k7Yh7QjfQxvSnHZj+EwzbBwy73ezPGyfp71wCJTniJDQShYW6JSB/jjYYTbuBvK5wWz/UvHbBPnQU0WCU9C60ND+E129zhWqHixh4f6gLjsc7qXrZsunczFVlqKetJ2VqIOx3b9jEBMbpMLJ+lINhbmCL8qoR3y9I4crhwoWVbU7/cxhGW49v0arzjtsGyOilzmMq3BaTkXl48EzqLwAet3c/UMXeEmMfB0Q56rpJjxyR93hJhUiJESctzNetfoGZTF5ahPhNMbWzDqe/eV3afiGM0tuukNx+3kc3F4q4ro4fapI8n+fkUspVgf3d1BrS8mvUxP2Z5oPtbbNavQsav3pT8mpdloJPOpxo1Gqorg43jhyNBoTpjwVOYEcNOF/iY+zgXfdUXxE/lETnw7jdWM2yFluGqtVyKXrAx37lb+aW2Vwj6xgOPSVDag8bRp+9cF80pFKq1GLeM68gExPleNhczBjRDpzQ788wmmjpS1aJksbEsegTTg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(39860400002)(136003)(376002)(396003)(36840700001)(46966006)(40470700004)(41300700001)(6666004)(2906002)(40460700003)(26005)(478600001)(86362001)(6916009)(30864003)(44832011)(82310400005)(5660300002)(1076003)(8936002)(2616005)(47076005)(336012)(186003)(16526019)(426003)(83380400001)(7696005)(82740400003)(36860700001)(40480700001)(81166007)(356005)(54906003)(4326008)(8676002)(70206006)(70586007)(36756003)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:38:47.5741 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d20e2ea-5d93-4f97-1e7e-08da6c222db1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT044.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB5513
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Samson Tam <Samson.Tam@amd.com>, solomon.chiu@amd.com,
 daniel.wheeler@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <Samson.Tam@amd.com>

[Why]
In single display ODM combine mode, two MPO videos ( three
 planes ) are not working

[How]
When we detect three planes, don't set odm combine 2to1 policy
 for the MPO planes.  Otherwise, we run out of pipes available
Add support for two MPO videos in dc_add_plane_to_context().
 Don't allow both videos to be on the same side of the
 display.
Add extra check when fetching free pipe for two MPO videos.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 136 +++++++++++++---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 149 ++++++++++++++++--
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   6 +
 3 files changed, 260 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 752ba4ab2b1e..ffc0f1c0ea93 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1463,6 +1463,7 @@ bool dc_add_plane_to_context(
 	struct dc_stream_status *stream_status = NULL;
 	struct pipe_ctx *prev_right_head = NULL;
 	struct pipe_ctx *free_right_pipe = NULL;
+	struct pipe_ctx *prev_left_head = NULL;
 
 	DC_LOGGER_INIT(stream->ctx->logger);
 	for (i = 0; i < context->stream_count; i++)
@@ -1514,8 +1515,16 @@ bool dc_add_plane_to_context(
 
 			/* ODM + window MPO, where MPO window is on right half only */
 			if (free_pipe->plane_state &&
-					(free_pipe->plane_state->clip_rect.x >= free_pipe->stream->src.x + free_pipe->stream->src.width/2) &&
-					tail_pipe->next_odm_pipe) {
+				(free_pipe->plane_state->clip_rect.x >= free_pipe->stream->src.x + free_pipe->stream->src.width/2) &&
+				tail_pipe->next_odm_pipe) {
+
+				/* For ODM + window MPO, in 3 plane case, if we already have a MPO window on
+				 *  the right side, then we will invalidate a 2nd one on the right side
+				 */
+				if (head_pipe->next_odm_pipe && tail_pipe->next_odm_pipe->bottom_pipe) {
+					dc_plane_state_release(plane_state);
+					return false;
+				}
 
 				DC_LOG_SCALER("%s - ODM + window MPO(right). free_pipe:%d  tail_pipe->next_odm_pipe:%d\n",
 						__func__,
@@ -1530,20 +1539,42 @@ bool dc_add_plane_to_context(
 				 * - If not, continue to use free_pipe
 				 * - If the right side already has a pipe, use that pipe instead if its available
 				 */
+
+				/*
+				 * We also want to avoid the case where with three plane ( 2 MPO videos ), we have
+				 *  both videos on the left side so one of the videos is invalidated.  Then we
+				 *  move the invalidated video back to the right side.  If the order of the plane
+				 *  states is such that the right MPO plane is processed first, the free pipe
+				 *  selected by the head will be the left MPO pipe. But since there was no right
+				 *  MPO pipe, it will assign the free pipe to the right MPO pipe instead and
+				 *  a pipe reallocation will occur.
+				 * Check the old context to see if the left side already has a pipe allocated
+				 * - If not, continue to use free_pipe
+				 * - If the left side is already using this pipe, then pick another pipe for right
+				 */
+
 				prev_right_head = &dc->current_state->res_ctx.pipe_ctx[tail_pipe->next_odm_pipe->pipe_idx];
-				if ((prev_right_head->bottom_pipe) && (free_pipe->pipe_idx != prev_right_head->bottom_pipe->pipe_idx)) {
+				if ((prev_right_head->bottom_pipe) &&
+					(free_pipe->pipe_idx != prev_right_head->bottom_pipe->pipe_idx)) {
 					free_right_pipe = acquire_free_pipe_for_head(context, pool, tail_pipe->next_odm_pipe);
-					if (free_right_pipe) {
-						free_pipe->stream = NULL;
-						memset(&free_pipe->stream_res, 0, sizeof(struct stream_resource));
-						memset(&free_pipe->plane_res, 0, sizeof(struct plane_resource));
-						free_pipe->plane_state = NULL;
-						free_pipe->pipe_idx = 0;
-						free_right_pipe->plane_state = plane_state;
-						free_pipe = free_right_pipe;
+				} else {
+					prev_left_head = &dc->current_state->res_ctx.pipe_ctx[head_pipe->pipe_idx];
+					if ((prev_left_head->bottom_pipe) &&
+						(free_pipe->pipe_idx == prev_left_head->bottom_pipe->pipe_idx)) {
+						free_right_pipe = acquire_free_pipe_for_head(context, pool, head_pipe);
 					}
 				}
 
+				if (free_right_pipe) {
+					free_pipe->stream = NULL;
+					memset(&free_pipe->stream_res, 0, sizeof(struct stream_resource));
+					memset(&free_pipe->plane_res, 0, sizeof(struct plane_resource));
+					free_pipe->plane_state = NULL;
+					free_pipe->pipe_idx = 0;
+					free_right_pipe->plane_state = plane_state;
+					free_pipe = free_right_pipe;
+				}
+
 				free_pipe->stream_res.tg = tail_pipe->next_odm_pipe->stream_res.tg;
 				free_pipe->stream_res.abm = tail_pipe->next_odm_pipe->stream_res.abm;
 				free_pipe->stream_res.opp = tail_pipe->next_odm_pipe->stream_res.opp;
@@ -1553,7 +1584,63 @@ bool dc_add_plane_to_context(
 
 				free_pipe->top_pipe = tail_pipe->next_odm_pipe;
 				tail_pipe->next_odm_pipe->bottom_pipe = free_pipe;
+			} else if (free_pipe->plane_state &&
+				(free_pipe->plane_state->clip_rect.x >= free_pipe->stream->src.x + free_pipe->stream->src.width/2)
+				&& head_pipe->next_odm_pipe) {
+
+				/* For ODM + window MPO, support 3 plane ( 2 MPO ) case.
+				 * Here we have a desktop ODM + left window MPO and a new MPO window appears
+				 *  on the right side only.  It fails the first case, because tail_pipe is the
+				 *  left window MPO, so it has no next_odm_pipe.  So in this scenario, we check
+				 *  for head_pipe->next_odm_pipe instead
+				 */
+				DC_LOG_SCALER("%s - ODM + win MPO (left) + win MPO (right). free_pipe:%d  head_pipe->next_odm:%d\n",
+						__func__,
+						free_pipe->pipe_idx,
+						head_pipe->next_odm_pipe ? head_pipe->next_odm_pipe->pipe_idx : -1);
+
+				/*
+				 * We want to avoid the case where the right side already has a pipe assigned to
+				 *  it and is different from free_pipe ( which would cause trigger a pipe
+				 *  reallocation ).
+				 * Check the old context to see if the right side already has a pipe allocated
+				 * - If not, continue to use free_pipe
+				 * - If the right side already has a pipe, use that pipe instead if its available
+				 */
+				prev_right_head = &dc->current_state->res_ctx.pipe_ctx[head_pipe->next_odm_pipe->pipe_idx];
+				if ((prev_right_head->bottom_pipe) &&
+					(free_pipe->pipe_idx != prev_right_head->bottom_pipe->pipe_idx)) {
+					free_right_pipe = acquire_free_pipe_for_head(context, pool, head_pipe->next_odm_pipe);
+					if (free_right_pipe) {
+						free_pipe->stream = NULL;
+						memset(&free_pipe->stream_res, 0, sizeof(struct stream_resource));
+						memset(&free_pipe->plane_res, 0, sizeof(struct plane_resource));
+						free_pipe->plane_state = NULL;
+						free_pipe->pipe_idx = 0;
+						free_right_pipe->plane_state = plane_state;
+						free_pipe = free_right_pipe;
+					}
+				}
+
+				free_pipe->stream_res.tg = head_pipe->next_odm_pipe->stream_res.tg;
+				free_pipe->stream_res.abm = head_pipe->next_odm_pipe->stream_res.abm;
+				free_pipe->stream_res.opp = head_pipe->next_odm_pipe->stream_res.opp;
+				free_pipe->stream_res.stream_enc = head_pipe->next_odm_pipe->stream_res.stream_enc;
+				free_pipe->stream_res.audio = head_pipe->next_odm_pipe->stream_res.audio;
+				free_pipe->clock_source = head_pipe->next_odm_pipe->clock_source;
+
+				free_pipe->top_pipe = head_pipe->next_odm_pipe;
+				head_pipe->next_odm_pipe->bottom_pipe = free_pipe;
 			} else {
+
+				/* For ODM + window MPO, in 3 plane case, if we already have a MPO window on
+				 *  the left side, then we will invalidate a 2nd one on the left side
+				 */
+				if (head_pipe->next_odm_pipe && tail_pipe->top_pipe) {
+					dc_plane_state_release(plane_state);
+					return false;
+				}
+
 				free_pipe->stream_res.tg = tail_pipe->stream_res.tg;
 				free_pipe->stream_res.abm = tail_pipe->stream_res.abm;
 				free_pipe->stream_res.opp = tail_pipe->stream_res.opp;
@@ -1564,21 +1651,28 @@ bool dc_add_plane_to_context(
 				free_pipe->top_pipe = tail_pipe;
 				tail_pipe->bottom_pipe = free_pipe;
 
-				if (!free_pipe->next_odm_pipe && tail_pipe->next_odm_pipe && tail_pipe->next_odm_pipe->bottom_pipe) {
-					free_pipe->next_odm_pipe = tail_pipe->next_odm_pipe->bottom_pipe;
-					tail_pipe->next_odm_pipe->bottom_pipe->prev_odm_pipe = free_pipe;
-				}
-				if (!free_pipe->prev_odm_pipe && tail_pipe->prev_odm_pipe && tail_pipe->prev_odm_pipe->bottom_pipe) {
-					free_pipe->prev_odm_pipe = tail_pipe->prev_odm_pipe->bottom_pipe;
-					tail_pipe->prev_odm_pipe->bottom_pipe->next_odm_pipe = free_pipe;
+				/* Connect MPO pipes together if MPO window is in the centre */
+				if (!(free_pipe->plane_state &&
+						(free_pipe->plane_state->clip_rect.x + free_pipe->plane_state->clip_rect.width <=
+						free_pipe->stream->src.x + free_pipe->stream->src.width/2))) {
+					if (!free_pipe->next_odm_pipe &&
+						tail_pipe->next_odm_pipe && tail_pipe->next_odm_pipe->bottom_pipe) {
+						free_pipe->next_odm_pipe = tail_pipe->next_odm_pipe->bottom_pipe;
+						tail_pipe->next_odm_pipe->bottom_pipe->prev_odm_pipe = free_pipe;
+					}
+					if (!free_pipe->prev_odm_pipe &&
+						tail_pipe->prev_odm_pipe && tail_pipe->prev_odm_pipe->bottom_pipe) {
+						free_pipe->prev_odm_pipe = tail_pipe->prev_odm_pipe->bottom_pipe;
+						tail_pipe->prev_odm_pipe->bottom_pipe->next_odm_pipe = free_pipe;
+					}
 				}
 			}
 		}
 
 		/* ODM + window MPO, where MPO window is on left half only */
 		if (free_pipe->plane_state &&
-				(free_pipe->plane_state->clip_rect.x + free_pipe->plane_state->clip_rect.width <=
-				free_pipe->stream->src.x + free_pipe->stream->src.width/2)) {
+			(free_pipe->plane_state->clip_rect.x + free_pipe->plane_state->clip_rect.width <=
+			free_pipe->stream->src.x + free_pipe->stream->src.width/2)) {
 			DC_LOG_SCALER("%s - ODM + window MPO(left). free_pipe:%d\n",
 					__func__,
 					free_pipe->pipe_idx);
@@ -1586,7 +1680,7 @@ bool dc_add_plane_to_context(
 		}
 		/* ODM + window MPO, where MPO window is on right half only */
 		if (free_pipe->plane_state &&
-				(free_pipe->plane_state->clip_rect.x >= free_pipe->stream->src.x + free_pipe->stream->src.width/2)) {
+			(free_pipe->plane_state->clip_rect.x >= free_pipe->stream->src.x + free_pipe->stream->src.width/2)) {
 			DC_LOG_SCALER("%s - ODM + window MPO(right). free_pipe:%d\n",
 					__func__,
 					free_pipe->pipe_idx);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index e551d2936d03..314dec5712b5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1820,11 +1820,12 @@ int dcn32_populate_dml_pipes_from_context(
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe;
 	bool subvp_in_use = false, is_pipe_split_expected[MAX_PIPES];
+	int plane_count = 0;
+	struct dc_crtc_timing *timing;
 
 	dcn20_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
 
 	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
-		struct dc_crtc_timing *timing;
 
 		if (!res_ctx->pipe_ctx[i].stream)
 			continue;
@@ -1876,11 +1877,12 @@ int dcn32_populate_dml_pipes_from_context(
 			}
 		}
 
-		pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
-		if (context->stream_count == 1) {
-			if (dc->debug.enable_single_display_2to1_odm_policy)
-				pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
-		}
+		/* Calculate the number of planes we have so we can determine
+		 *  whether to apply ODM 2to1 policy or not
+		 */
+		if (pipe->stream && !pipe->prev_odm_pipe &&
+				(!pipe->top_pipe || pipe->top_pipe->plane_state != pipe->plane_state))
+			++plane_count;
 
 		DC_FP_START();
 		is_pipe_split_expected[i] = dcn32_predict_pipe_split(context, pipes[i].pipe, i);
@@ -1889,6 +1891,28 @@ int dcn32_populate_dml_pipes_from_context(
 		pipe_cnt++;
 	}
 
+	/* Determine whether we will apply ODM 2to1 policy
+	 * Applies to single display and where the number of planes is less than 3
+	 * For 3 plane case ( 2 MPO planes ), we will not set the policy for the MPO pipes
+	 */
+	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
+		if (!res_ctx->pipe_ctx[i].stream)
+			continue;
+		pipe = &res_ctx->pipe_ctx[i];
+		timing = &pipe->stream->timing;
+
+		pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
+		res_ctx->pipe_ctx[i].stream->odm_2to1_policy_applied  = false;
+		if (context->stream_count == 1 && timing->dsc_cfg.num_slices_h != 1) {
+			if (dc->debug.enable_single_display_2to1_odm_policy) {
+				if (!((plane_count > 2) && pipe->top_pipe))
+					pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
+			}
+			res_ctx->pipe_ctx[i].stream->odm_2to1_policy_applied = true;
+		}
+		pipe_cnt++;
+	}
+
 	/* For DET allocation, we don't want to use DML policy (not optimal for utilizing all
 	 * the DET available for each pipe). Use the DET override input to maintain our driver
 	 * policy.
@@ -1947,7 +1971,7 @@ static struct resource_funcs dcn32_res_pool_funcs = {
 	.validate_bandwidth = dcn32_validate_bandwidth,
 	.calculate_wm_and_dlg = dcn32_calculate_wm_and_dlg,
 	.populate_dml_pipes = dcn32_populate_dml_pipes_from_context,
-	.acquire_idle_pipe_for_layer = dcn20_acquire_idle_pipe_for_layer,
+	.acquire_idle_pipe_for_head_pipe_in_layer = dcn32_acquire_idle_pipe_for_head_pipe_in_layer,
 	.add_stream_to_ctx = dcn30_add_stream_to_ctx,
 	.add_dsc_to_stream_resource = dcn20_add_dsc_to_stream_resource,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
@@ -1976,7 +2000,7 @@ static bool dcn32_resource_construct(
 	uint32_t pipe_fuses = 0;
 	uint32_t num_pipes  = 4;
 
-    DC_FP_START();
+	DC_FP_START();
 
 	ctx->dc_bios->regs = &bios_regs;
 
@@ -2316,13 +2340,13 @@ static bool dcn32_resource_construct(
 		pool->base.oem_device = NULL;
 	}
 
-    DC_FP_END();
+	DC_FP_END();
 
 	return true;
 
 create_fail:
 
-    DC_FP_END();
+	DC_FP_END();
 
 	dcn32_resource_destruct(pool);
 
@@ -2346,3 +2370,108 @@ struct resource_pool *dcn32_create_resource_pool(
 	kfree(pool);
 	return NULL;
 }
+
+static struct pipe_ctx *find_idle_secondary_pipe_check_mpo(
+		struct resource_context *res_ctx,
+		const struct resource_pool *pool,
+		const struct pipe_ctx *primary_pipe)
+{
+	int i;
+	struct pipe_ctx *secondary_pipe = NULL;
+	struct pipe_ctx *next_odm_mpo_pipe = NULL;
+	int primary_index, preferred_pipe_idx;
+	struct pipe_ctx *old_primary_pipe = NULL;
+
+	/*
+	 * Modified from find_idle_secondary_pipe
+	 * With windowed MPO and ODM, we want to avoid the case where we want a
+	 *  free pipe for the left side but the free pipe is being used on the
+	 *  right side.
+	 * Add check on current_state if the primary_pipe is the left side,
+	 *  to check the right side ( primary_pipe->next_odm_pipe ) to see if
+	 *  it is using a pipe for MPO ( primary_pipe->next_odm_pipe->bottom_pipe )
+	 * - If so, then don't use this pipe
+	 * EXCEPTION - 3 plane ( 2 MPO plane ) case
+	 * - in this case, the primary pipe has already gotten a free pipe for the
+	 *  MPO window in the left
+	 * - when it tries to get a free pipe for the MPO window on the right,
+	 *  it will see that it is already assigned to the right side
+	 *  ( primary_pipe->next_odm_pipe ).  But in this case, we want this
+	 *  free pipe, since it will be for the right side.  So add an
+	 *  additional condition, that skipping the free pipe on the right only
+	 *  applies if the primary pipe has no bottom pipe currently assigned
+	 */
+	if (primary_pipe) {
+		primary_index = primary_pipe->pipe_idx;
+		old_primary_pipe = &primary_pipe->stream->ctx->dc->current_state->res_ctx.pipe_ctx[primary_index];
+		if ((old_primary_pipe->next_odm_pipe) && (old_primary_pipe->next_odm_pipe->bottom_pipe)
+			&& (!primary_pipe->bottom_pipe))
+			next_odm_mpo_pipe = old_primary_pipe->next_odm_pipe->bottom_pipe;
+
+		preferred_pipe_idx = (pool->pipe_count - 1) - primary_pipe->pipe_idx;
+		if ((res_ctx->pipe_ctx[preferred_pipe_idx].stream == NULL) &&
+			!(next_odm_mpo_pipe && next_odm_mpo_pipe->pipe_idx == preferred_pipe_idx)) {
+			secondary_pipe = &res_ctx->pipe_ctx[preferred_pipe_idx];
+			secondary_pipe->pipe_idx = preferred_pipe_idx;
+		}
+	}
+
+	/*
+	 * search backwards for the second pipe to keep pipe
+	 * assignment more consistent
+	 */
+	if (!secondary_pipe)
+		for (i = pool->pipe_count - 1; i >= 0; i--) {
+			if ((res_ctx->pipe_ctx[i].stream == NULL) &&
+				!(next_odm_mpo_pipe && next_odm_mpo_pipe->pipe_idx == i)) {
+				secondary_pipe = &res_ctx->pipe_ctx[i];
+				secondary_pipe->pipe_idx = i;
+				break;
+			}
+		}
+
+	return secondary_pipe;
+}
+
+struct pipe_ctx *dcn32_acquire_idle_pipe_for_head_pipe_in_layer(
+		struct dc_state *state,
+		const struct resource_pool *pool,
+		struct dc_stream_state *stream,
+		struct pipe_ctx *head_pipe)
+{
+	struct resource_context *res_ctx = &state->res_ctx;
+	struct pipe_ctx *idle_pipe, *pipe;
+	struct resource_context *old_ctx = &stream->ctx->dc->current_state->res_ctx;
+	int head_index;
+
+	if (!head_pipe)
+		ASSERT(0);
+
+	/*
+	 * Modified from dcn20_acquire_idle_pipe_for_layer
+	 * Check if head_pipe in old_context already has bottom_pipe allocated.
+	 * - If so, check if that pipe is available in the current context.
+	 * --  If so, reuse pipe from old_context
+	 */
+	head_index = head_pipe->pipe_idx;
+	pipe = &old_ctx->pipe_ctx[head_index];
+	if (pipe->bottom_pipe && res_ctx->pipe_ctx[pipe->bottom_pipe->pipe_idx].stream == NULL) {
+		idle_pipe = &res_ctx->pipe_ctx[pipe->bottom_pipe->pipe_idx];
+		idle_pipe->pipe_idx = pipe->bottom_pipe->pipe_idx;
+	} else {
+		idle_pipe = find_idle_secondary_pipe_check_mpo(res_ctx, pool, head_pipe);
+		if (!idle_pipe)
+			return NULL;
+	}
+
+	idle_pipe->stream = head_pipe->stream;
+	idle_pipe->stream_res.tg = head_pipe->stream_res.tg;
+	idle_pipe->stream_res.opp = head_pipe->stream_res.opp;
+
+	idle_pipe->plane_res.hubp = pool->hubps[idle_pipe->pipe_idx];
+	idle_pipe->plane_res.ipp = pool->ipps[idle_pipe->pipe_idx];
+	idle_pipe->plane_res.dpp = pool->dpps[idle_pipe->pipe_idx];
+	idle_pipe->plane_res.mpcc_inst = pool->dpps[idle_pipe->pipe_idx]->inst;
+
+	return idle_pipe;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index fc0fe48023a0..efd449804d7b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -99,6 +99,12 @@ bool dcn32_subvp_in_use(struct dc *dc,
 
 bool dcn32_mpo_in_use(struct dc_state *context);
 
+struct pipe_ctx *dcn32_acquire_idle_pipe_for_head_pipe_in_layer(
+		struct dc_state *state,
+		const struct resource_pool *pool,
+		struct dc_stream_state *stream,
+		struct pipe_ctx *head_pipe);
+
 void dcn32_determine_det_override(struct dc_state *context, display_e2e_pipe_params_st *pipes,
 		bool *is_pipe_split_expected, int pipe_cnt);
 
-- 
2.37.1


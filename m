Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6BFC001DF
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Aug 2023 06:52:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5796010E4B0;
	Wed,  2 Aug 2023 06:52:47 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2062.outbound.protection.outlook.com [40.107.94.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2863310E4B0
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Aug 2023 06:52:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmWwzfl74CeiXDnlqHTM6O1ElvCmCDtoyg9Y+0T4PXI6WzIXyyzm+QYWOtw1w7983FmoxBqDGnCnIxZT/kATGcnJpZSIGl1QeMQB/JxylKqakZhsS8jxzZvg1Yt8o9Dv40G7trIpbK/1xioZKaLJIWEZtOKl++UcGwLIdDu2UhCBAL8wJ6sZD7//6IPfCfmn+6KKksDIWOYgdR1KPPV2TtvOg+CKyiDPhCHL6Egw17quen1owfyzwGywA7tZpiPd4zsUjg2/ITUxEAm+M5jybzAyDRcg/OHyAoCtqAMLLR+acS2gFjAdfvZz8c6ZMATUbujjvTLFHtTITn4y6XkW/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyMhuftlqu/rwsUOIo7/lSMqnhJlepuRyVXJ9kPN98w=;
 b=ZUx4CcIrR/B2pgtOFb9KCc4h5jBCRvBxgDQWKaRQ7qVBzDXDsXjNIvQA5Fc8jDPkLjaLqVRIfO4gw8tMnOaPrK9CsbUQqmY8ls5WQ1qOFj9kq1Pf43PyONF2mWsYr6IdnLzKCTRgFMQDlyqtIhp8IbSjXz3BCQkmjdXYzm1+0J3HNa9YT3sJ81zHNXlzkd1Rqn31nuMtKz2WL4rBxwzBL5wbnRs9Xdzb0ZTT1mCL2MwIdhS7mW0WHVGG6ls1wPv622ZH/c1E84oUAj+Dh8ZhVTBTKPrawzirsNSMSGoOoXc/BbpzjgNdk2FIwG82SsbhcO7eBQZMqh0pxgToOeiFPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyMhuftlqu/rwsUOIo7/lSMqnhJlepuRyVXJ9kPN98w=;
 b=zbWPaPkq02lUH22hR451bMADhjcWHrWYQXtnSsA0XKrjeio/IcRSmGoXYtD94P33hIaod7ECPI/8tliSqXx9E4GLUjoSX+DcT4Vlk45e0eGI6YRzy1cG+T6mRr78asuJEHaMQvZN1nQEEV58KeiIXjXNjvlrOH8bzDct10LISEU=
Received: from MW4PR03CA0160.namprd03.prod.outlook.com (2603:10b6:303:8d::15)
 by MW3PR12MB4363.namprd12.prod.outlook.com (2603:10b6:303:56::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.45; Wed, 2 Aug
 2023 06:52:42 +0000
Received: from MWH0EPF000989EB.namprd02.prod.outlook.com
 (2603:10b6:303:8d:cafe::f) by MW4PR03CA0160.outlook.office365.com
 (2603:10b6:303:8d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44 via Frontend
 Transport; Wed, 2 Aug 2023 06:52:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000989EB.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.19 via Frontend Transport; Wed, 2 Aug 2023 06:52:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:52:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 2 Aug
 2023 01:52:37 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Wed, 2 Aug 2023 01:52:34 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/22] drm/amd/display: always acquire MPO pipe for every
 blending tree
Date: Wed, 2 Aug 2023 14:51:19 +0800
Message-ID: <20230802065132.3129932-10-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
References: <20230802065132.3129932-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EB:EE_|MW3PR12MB4363:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ae5fe8-420c-481a-2603-08db932511db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2u9BsagpG6Nz49/Pt+BIEtTI+ipqSsgh1prjqdnJDnKeT3OxLXpV1NTeOXCLayRDrIoM4D4DJTA2VJL16jiehF9q44ByHPT93sHeiz/B3AnWdYqu1tae0AIKH7nBTo01dwXMhKlZN5GNVdPGpBxl52obcc/SsnT6Jek9e+bxfbCkbP8WYiqPorf6BJwsAfpgsGfqIknGdCrCP23WubsGIehD417L9b/CIEewoqdKJsoEX/AVBGCp5xKPJtrDUiMfLNCLWXFoMeT0j25kA89ycinnahZ6cJ44EsRp/GT6ez7AybxvmUVAC2iuCn9zNOlWP4ikOp36iOZ0x0e3zip3ArvfdVY1Zn0JgZpMgMzJnM8i2+wN4p6mQ7LrkruCz5O4zl7O1ve9/67rKyAJ+J3xjtyss1rgx1fjs1P3j2Z5EztmFeEPWrERzFw2+jbLMYbFqTWQqY9S+2wb9J4pUWvlTJWBs6NJCfqk3qYRRljzgY8u4Ho1lnLgOWg5EFFZ1Q+9p04NldfOqZKGgMmu4zgXZNJWjGUWZphFBh31sjJBrrFCjThVcXWZwPI4EEqdxc3pn/hHcQAgleZNna9dFlAC7H8PeHN13kX+b9iUEtaNvAyHVCS/tolsC5z3kl2buehVV7LMMlTpVv54f0WfKXLjRMwRUm7tFSEAIMGEyLf61d7XQy5wWVnSqVX+srDN6YcnmftwKuSvjedqDdJzO2oF7rKPIzOgZ/UgLTXC0NivmWY0x+MbIaLn13R5NVMDekbwDcyD+6E4l6vRI/HYsZLM/A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(376002)(136003)(396003)(346002)(82310400008)(451199021)(46966006)(40470700004)(36840700001)(40480700001)(336012)(40460700003)(2616005)(186003)(316002)(86362001)(478600001)(81166007)(54906003)(70586007)(70206006)(6666004)(356005)(7696005)(6916009)(4326008)(82740400003)(36756003)(41300700001)(26005)(426003)(8676002)(5660300002)(8936002)(47076005)(1076003)(30864003)(2906002)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2023 06:52:42.3986 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ae5fe8-420c-481a-2603-08db932511db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4363
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Jun Lei <jun.lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
We only acquire MPO pipe for blending tree where the plane clip will
be rendered. If an MPO plane is outside current ODM slice rect, we will
skip pipe allocation. With new programming policy we want to allocate
pipes for every ODM slice blending tree even for those whose ODM slice
rect doesn't intersect with plane clip. This is aligned with DML validation
so the pipe topology is programmed independently from the plane's
position and dst plane size.

[how]
- Remove the logic to allocate pipe only when the MPO plane intersects
with ODM slice and replace with the new logic to always allocate pipes.
- Remove the logic to tear down ODM configuration in favor for supporting
secondary MPO planes.
- Remove the logic to use full update when MPO goes accross ODM slice
boundary.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  94 -------
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 235 +-----------------
 2 files changed, 12 insertions(+), 317 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 4326daa21094..413258db6746 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2701,96 +2701,6 @@ static enum surface_update_type check_update_surfaces_for_stream(
 	return overall_type;
 }
 
-static bool dc_check_is_fullscreen_video(struct rect src, struct rect clip_rect)
-{
-	int view_height, view_width, clip_x, clip_y, clip_width, clip_height;
-
-	view_height = src.height;
-	view_width = src.width;
-
-	clip_x = clip_rect.x;
-	clip_y = clip_rect.y;
-
-	clip_width = clip_rect.width;
-	clip_height = clip_rect.height;
-
-	/* check for centered video accounting for off by 1 scaling truncation */
-	if ((view_height - clip_y - clip_height <= clip_y + 1) &&
-			(view_width - clip_x - clip_width <= clip_x + 1) &&
-			(view_height - clip_y - clip_height >= clip_y - 1) &&
-			(view_width - clip_x - clip_width >= clip_x - 1)) {
-
-		/* when OS scales up/down to letter box, it may end up
-		 * with few blank pixels on the border due to truncating.
-		 * Add offset margin to account for this
-		 */
-		if (clip_x <= 4 || clip_y <= 4)
-			return true;
-	}
-
-	return false;
-}
-
-static enum surface_update_type check_boundary_crossing_for_windowed_mpo_with_odm(struct dc *dc,
-		struct dc_surface_update *srf_updates, int surface_count,
-		enum surface_update_type update_type)
-{
-	enum surface_update_type new_update_type = update_type;
-	int i, j;
-	struct pipe_ctx *pipe = NULL;
-	struct dc_stream_state *stream;
-
-	/* Check that we are in windowed MPO with ODM
-	 * - look for MPO pipe by scanning pipes for first pipe matching
-	 *   surface that has moved ( position change )
-	 * - MPO pipe will have top pipe
-	 * - check that top pipe has ODM pointer
-	 */
-	if ((surface_count > 1) && dc->config.enable_windowed_mpo_odm) {
-		for (i = 0; i < surface_count; i++) {
-			if (srf_updates[i].surface && srf_updates[i].scaling_info
-					&& srf_updates[i].surface->update_flags.bits.position_change) {
-
-				for (j = 0; j < dc->res_pool->pipe_count; j++) {
-					if (srf_updates[i].surface == dc->current_state->res_ctx.pipe_ctx[j].plane_state) {
-						pipe = &dc->current_state->res_ctx.pipe_ctx[j];
-						stream = pipe->stream;
-						break;
-					}
-				}
-
-				if (pipe && pipe->top_pipe && (get_num_odm_splits(pipe->top_pipe) > 0) && stream
-						&& !dc_check_is_fullscreen_video(stream->src, srf_updates[i].scaling_info->clip_rect)) {
-					struct rect old_clip_rect, new_clip_rect;
-					bool old_clip_rect_left, old_clip_rect_right, old_clip_rect_middle;
-					bool new_clip_rect_left, new_clip_rect_right, new_clip_rect_middle;
-
-					old_clip_rect = srf_updates[i].surface->clip_rect;
-					new_clip_rect = srf_updates[i].scaling_info->clip_rect;
-
-					old_clip_rect_left = ((old_clip_rect.x + old_clip_rect.width) <= (stream->src.x + (stream->src.width/2)));
-					old_clip_rect_right = (old_clip_rect.x >= (stream->src.x + (stream->src.width/2)));
-					old_clip_rect_middle = !old_clip_rect_left && !old_clip_rect_right;
-
-					new_clip_rect_left = ((new_clip_rect.x + new_clip_rect.width) <= (stream->src.x + (stream->src.width/2)));
-					new_clip_rect_right = (new_clip_rect.x >= (stream->src.x + (stream->src.width/2)));
-					new_clip_rect_middle = !new_clip_rect_left && !new_clip_rect_right;
-
-					if (old_clip_rect_left && new_clip_rect_middle)
-						new_update_type = UPDATE_TYPE_FULL;
-					else if (old_clip_rect_middle && new_clip_rect_right)
-						new_update_type = UPDATE_TYPE_FULL;
-					else if (old_clip_rect_right && new_clip_rect_middle)
-						new_update_type = UPDATE_TYPE_FULL;
-					else if (old_clip_rect_middle && new_clip_rect_left)
-						new_update_type = UPDATE_TYPE_FULL;
-				}
-			}
-		}
-	}
-	return new_update_type;
-}
-
 /*
  * dc_check_update_surfaces_for_stream() - Determine update type (fast, med, or full)
  *
@@ -2822,10 +2732,6 @@ enum surface_update_type dc_check_update_surfaces_for_stream(
 			updates[i].surface->update_flags.raw = 0xFFFFFFFF;
 	}
 
-	if (type == UPDATE_TYPE_MED)
-		type = check_boundary_crossing_for_windowed_mpo_with_odm(dc,
-				updates, surface_count, type);
-
 	if (type == UPDATE_TYPE_FAST) {
 		// If there's an available clock comparator, we use that.
 		if (dc->clk_mgr->funcs->are_clock_states_equal) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index ea09830a649c..dc6ebfa205b0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -76,7 +76,6 @@
 
 #define DC_LOGGER_INIT(logger)
 
-#define HEAD_NOT_IN_ODM -2
 #define UNABLE_TO_SPLIT -1
 
 enum dce_version resource_parse_asic_id(struct hw_asic_id asic_id)
@@ -1715,48 +1714,6 @@ static int acquire_first_split_pipe(
 			split_pipe->plane_res.mpcc_inst = pool->dpps[i]->inst;
 			split_pipe->pipe_idx = i;
 
-			split_pipe->stream = stream;
-			return i;
-		} else if (split_pipe->prev_odm_pipe &&
-				split_pipe->prev_odm_pipe->plane_state == split_pipe->plane_state) {
-
-			// Fix case where ODM slice has child planes
-			// Re-attach child planes
-			struct pipe_ctx *temp_head_pipe = resource_get_head_pipe_for_stream(res_ctx, split_pipe->stream);
-
-			if (split_pipe->bottom_pipe && temp_head_pipe) {
-
-				struct pipe_ctx *temp_tail_pipe = resource_get_tail_pipe(res_ctx, temp_head_pipe);
-
-				if (temp_tail_pipe) {
-
-					split_pipe->bottom_pipe->top_pipe = temp_tail_pipe;
-					temp_tail_pipe->bottom_pipe = split_pipe->bottom_pipe;
-				}
-			}
-
-			split_pipe->prev_odm_pipe->next_odm_pipe = split_pipe->next_odm_pipe;
-
-			if (split_pipe->next_odm_pipe)
-				split_pipe->next_odm_pipe->prev_odm_pipe = split_pipe->prev_odm_pipe;
-
-			if (split_pipe->prev_odm_pipe->plane_state)
-				resource_build_scaling_params(split_pipe->prev_odm_pipe);
-
-			memset(split_pipe, 0, sizeof(*split_pipe));
-
-			// We cannot split if head pipe is not odm
-			if (temp_head_pipe && !temp_head_pipe->next_odm_pipe && !temp_head_pipe->prev_odm_pipe)
-				return HEAD_NOT_IN_ODM;
-
-			split_pipe->stream_res.tg = pool->timing_generators[i];
-			split_pipe->plane_res.hubp = pool->hubps[i];
-			split_pipe->plane_res.ipp = pool->ipps[i];
-			split_pipe->plane_res.dpp = pool->dpps[i];
-			split_pipe->stream_res.opp = pool->opps[i];
-			split_pipe->plane_res.mpcc_inst = pool->dpps[i]->inst;
-			split_pipe->pipe_idx = i;
-
 			split_pipe->stream = stream;
 			return i;
 		}
@@ -1774,9 +1731,6 @@ bool dc_add_plane_to_context(
 	struct resource_pool *pool = dc->res_pool;
 	struct pipe_ctx *head_pipe, *tail_pipe, *free_pipe;
 	struct dc_stream_status *stream_status = NULL;
-	struct pipe_ctx *prev_right_head = NULL;
-	struct pipe_ctx *free_right_pipe = NULL;
-	struct pipe_ctx *prev_left_head = NULL;
 
 	DC_LOGGER_INIT(stream->ctx->logger);
 	for (i = 0; i < context->stream_count; i++)
@@ -1813,10 +1767,6 @@ bool dc_add_plane_to_context(
 			int pipe_idx = acquire_first_split_pipe(&context->res_ctx, pool, stream);
 			if (pipe_idx >= 0)
 				free_pipe = &context->res_ctx.pipe_ctx[pipe_idx];
-			else if (pipe_idx == HEAD_NOT_IN_ODM)
-				break;
-			else
-				ASSERT(false);
 		}
 
 		if (!free_pipe) {
@@ -1830,184 +1780,23 @@ bool dc_add_plane_to_context(
 			tail_pipe = resource_get_tail_pipe(&context->res_ctx, head_pipe);
 			ASSERT(tail_pipe);
 
-			/* ODM + window MPO, where MPO window is on right half only */
-			if (free_pipe->plane_state &&
-				(free_pipe->plane_state->clip_rect.x >= free_pipe->stream->src.x + free_pipe->stream->src.width/2) &&
-				tail_pipe->next_odm_pipe) {
-
-				/* For ODM + window MPO, in 3 plane case, if we already have a MPO window on
-				 *  the right side, then we will invalidate a 2nd one on the right side
-				 */
-				if (head_pipe->next_odm_pipe && tail_pipe->next_odm_pipe->bottom_pipe) {
-					dc_plane_state_release(plane_state);
-					return false;
-				}
-
-				DC_LOG_SCALER("%s - ODM + window MPO(right). free_pipe:%d  tail_pipe->next_odm_pipe:%d\n",
-						__func__,
-						free_pipe->pipe_idx,
-						tail_pipe->next_odm_pipe ? tail_pipe->next_odm_pipe->pipe_idx : -1);
-
-				/*
-				 * We want to avoid the case where the right side already has a pipe assigned to
-				 *  it and is different from free_pipe ( which would cause trigger a pipe
-				 *  reallocation ).
-				 * Check the old context to see if the right side already has a pipe allocated
-				 * - If not, continue to use free_pipe
-				 * - If the right side already has a pipe, use that pipe instead if its available
-				 */
-
-				/*
-				 * We also want to avoid the case where with three plane ( 2 MPO videos ), we have
-				 *  both videos on the left side so one of the videos is invalidated.  Then we
-				 *  move the invalidated video back to the right side.  If the order of the plane
-				 *  states is such that the right MPO plane is processed first, the free pipe
-				 *  selected by the head will be the left MPO pipe. But since there was no right
-				 *  MPO pipe, it will assign the free pipe to the right MPO pipe instead and
-				 *  a pipe reallocation will occur.
-				 * Check the old context to see if the left side already has a pipe allocated
-				 * - If not, continue to use free_pipe
-				 * - If the left side is already using this pipe, then pick another pipe for right
-				 */
-
-				prev_right_head = &dc->current_state->res_ctx.pipe_ctx[tail_pipe->next_odm_pipe->pipe_idx];
-				if ((prev_right_head->bottom_pipe) &&
-					(free_pipe->pipe_idx != prev_right_head->bottom_pipe->pipe_idx)) {
-					free_right_pipe = acquire_free_pipe_for_head(context, pool, tail_pipe->next_odm_pipe);
-				} else {
-					prev_left_head = &dc->current_state->res_ctx.pipe_ctx[head_pipe->pipe_idx];
-					if ((prev_left_head->bottom_pipe) &&
-						(free_pipe->pipe_idx == prev_left_head->bottom_pipe->pipe_idx)) {
-						free_right_pipe = acquire_free_pipe_for_head(context, pool, head_pipe);
-					}
-				}
-
-				if (free_right_pipe) {
-					free_pipe->stream = NULL;
-					memset(&free_pipe->stream_res, 0, sizeof(struct stream_resource));
-					memset(&free_pipe->plane_res, 0, sizeof(struct plane_resource));
-					free_pipe->plane_state = NULL;
-					free_pipe->pipe_idx = 0;
-					free_right_pipe->plane_state = plane_state;
-					free_pipe = free_right_pipe;
-				}
-
-				free_pipe->stream_res.tg = tail_pipe->next_odm_pipe->stream_res.tg;
-				free_pipe->stream_res.abm = tail_pipe->next_odm_pipe->stream_res.abm;
-				free_pipe->stream_res.opp = tail_pipe->next_odm_pipe->stream_res.opp;
-				free_pipe->stream_res.stream_enc = tail_pipe->next_odm_pipe->stream_res.stream_enc;
-				free_pipe->stream_res.audio = tail_pipe->next_odm_pipe->stream_res.audio;
-				free_pipe->clock_source = tail_pipe->next_odm_pipe->clock_source;
-
-				free_pipe->top_pipe = tail_pipe->next_odm_pipe;
-				tail_pipe->next_odm_pipe->bottom_pipe = free_pipe;
-			} else if (free_pipe->plane_state &&
-				(free_pipe->plane_state->clip_rect.x >= free_pipe->stream->src.x + free_pipe->stream->src.width/2)
-				&& head_pipe->next_odm_pipe) {
-
-				/* For ODM + window MPO, support 3 plane ( 2 MPO ) case.
-				 * Here we have a desktop ODM + left window MPO and a new MPO window appears
-				 *  on the right side only.  It fails the first case, because tail_pipe is the
-				 *  left window MPO, so it has no next_odm_pipe.  So in this scenario, we check
-				 *  for head_pipe->next_odm_pipe instead
-				 */
-				DC_LOG_SCALER("%s - ODM + win MPO (left) + win MPO (right). free_pipe:%d  head_pipe->next_odm:%d\n",
-						__func__,
-						free_pipe->pipe_idx,
-						head_pipe->next_odm_pipe ? head_pipe->next_odm_pipe->pipe_idx : -1);
-
-				/*
-				 * We want to avoid the case where the right side already has a pipe assigned to
-				 *  it and is different from free_pipe ( which would cause trigger a pipe
-				 *  reallocation ).
-				 * Check the old context to see if the right side already has a pipe allocated
-				 * - If not, continue to use free_pipe
-				 * - If the right side already has a pipe, use that pipe instead if its available
-				 */
-				prev_right_head = &dc->current_state->res_ctx.pipe_ctx[head_pipe->next_odm_pipe->pipe_idx];
-				if ((prev_right_head->bottom_pipe) &&
-					(free_pipe->pipe_idx != prev_right_head->bottom_pipe->pipe_idx)) {
-					free_right_pipe = acquire_free_pipe_for_head(context, pool, head_pipe->next_odm_pipe);
-					if (free_right_pipe) {
-						free_pipe->stream = NULL;
-						memset(&free_pipe->stream_res, 0, sizeof(struct stream_resource));
-						memset(&free_pipe->plane_res, 0, sizeof(struct plane_resource));
-						free_pipe->plane_state = NULL;
-						free_pipe->pipe_idx = 0;
-						free_right_pipe->plane_state = plane_state;
-						free_pipe = free_right_pipe;
-					}
-				}
-
-				free_pipe->stream_res.tg = head_pipe->next_odm_pipe->stream_res.tg;
-				free_pipe->stream_res.abm = head_pipe->next_odm_pipe->stream_res.abm;
-				free_pipe->stream_res.opp = head_pipe->next_odm_pipe->stream_res.opp;
-				free_pipe->stream_res.stream_enc = head_pipe->next_odm_pipe->stream_res.stream_enc;
-				free_pipe->stream_res.audio = head_pipe->next_odm_pipe->stream_res.audio;
-				free_pipe->clock_source = head_pipe->next_odm_pipe->clock_source;
-
-				free_pipe->top_pipe = head_pipe->next_odm_pipe;
-				head_pipe->next_odm_pipe->bottom_pipe = free_pipe;
-			} else {
-
-				/* For ODM + window MPO, in 3 plane case, if we already have a MPO window on
-				 *  the left side, then we will invalidate a 2nd one on the left side
-				 */
-				if (head_pipe->next_odm_pipe && tail_pipe->top_pipe) {
-					dc_plane_state_release(plane_state);
-					return false;
-				}
-
-				free_pipe->stream_res.tg = tail_pipe->stream_res.tg;
-				free_pipe->stream_res.abm = tail_pipe->stream_res.abm;
-				free_pipe->stream_res.opp = tail_pipe->stream_res.opp;
-				free_pipe->stream_res.stream_enc = tail_pipe->stream_res.stream_enc;
-				free_pipe->stream_res.audio = tail_pipe->stream_res.audio;
-				free_pipe->clock_source = tail_pipe->clock_source;
-
-				free_pipe->top_pipe = tail_pipe;
-				tail_pipe->bottom_pipe = free_pipe;
-
-				/* Connect MPO pipes together if MPO window is in the centre */
-				if (!(free_pipe->plane_state &&
-						(free_pipe->plane_state->clip_rect.x + free_pipe->plane_state->clip_rect.width <=
-						free_pipe->stream->src.x + free_pipe->stream->src.width/2))) {
-					if (!free_pipe->next_odm_pipe &&
-						tail_pipe->next_odm_pipe && tail_pipe->next_odm_pipe->bottom_pipe &&
-						tail_pipe->next_odm_pipe->bottom_pipe->plane_state == free_pipe->plane_state) {
-						free_pipe->next_odm_pipe = tail_pipe->next_odm_pipe->bottom_pipe;
-						tail_pipe->next_odm_pipe->bottom_pipe->prev_odm_pipe = free_pipe;
-					}
-					if (!free_pipe->prev_odm_pipe &&
-						tail_pipe->prev_odm_pipe && tail_pipe->prev_odm_pipe->bottom_pipe &&
-						tail_pipe->prev_odm_pipe->bottom_pipe->plane_state == free_pipe->plane_state) {
-						free_pipe->prev_odm_pipe = tail_pipe->prev_odm_pipe->bottom_pipe;
-						tail_pipe->prev_odm_pipe->bottom_pipe->next_odm_pipe = free_pipe;
-					}
-				}
+			free_pipe->stream_res.tg = tail_pipe->stream_res.tg;
+			free_pipe->stream_res.abm = tail_pipe->stream_res.abm;
+			free_pipe->stream_res.opp = tail_pipe->stream_res.opp;
+			free_pipe->stream_res.stream_enc = tail_pipe->stream_res.stream_enc;
+			free_pipe->stream_res.audio = tail_pipe->stream_res.audio;
+			free_pipe->clock_source = tail_pipe->clock_source;
+			free_pipe->top_pipe = tail_pipe;
+			tail_pipe->bottom_pipe = free_pipe;
+			if (tail_pipe->prev_odm_pipe) {
+				tail_pipe->prev_odm_pipe->bottom_pipe->next_odm_pipe = free_pipe;
+				free_pipe->prev_odm_pipe = tail_pipe->prev_odm_pipe->bottom_pipe;
 			}
 		}
 
-		/* ODM + window MPO, where MPO window is on left half only */
-		if (free_pipe->plane_state &&
-			(free_pipe->plane_state->clip_rect.x + free_pipe->plane_state->clip_rect.width <=
-			free_pipe->stream->src.x + free_pipe->stream->src.width/2)) {
-			DC_LOG_SCALER("%s - ODM + window MPO(left). free_pipe:%d\n",
-					__func__,
-					free_pipe->pipe_idx);
-			break;
-		}
-		/* ODM + window MPO, where MPO window is on right half only */
-		if (free_pipe->plane_state &&
-			(free_pipe->plane_state->clip_rect.x >= free_pipe->stream->src.x + free_pipe->stream->src.width/2)) {
-			DC_LOG_SCALER("%s - ODM + window MPO(right). free_pipe:%d\n",
-					__func__,
-					free_pipe->pipe_idx);
-			break;
-		}
-
 		head_pipe = head_pipe->next_odm_pipe;
 	}
+
 	/* assign new surfaces*/
 	stream_status->plane_states[stream_status->plane_count] = plane_state;
 
-- 
2.25.1


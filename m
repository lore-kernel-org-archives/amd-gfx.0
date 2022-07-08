Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F162ECCA47F
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 16:36:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1F8610E22D;
	Fri,  8 Jul 2022 16:36:44 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56FF810E22D
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 16:36:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QAbgqX/nwcNOm02ztm4J5jkMBEG+W23jzLhiIgES8HiABWubj1kWp1TJR0B8DgRrv17NONM7lxivM1SOlfbd5EcgwzhpRYlD+CPCaswSjVYnbQejr41TVxZm41aDxr5Ong4eD0z4wiaVGV9bZBd/Ef+9Fjbn7W+N0spmHjAtxiTxUwMP4RVOIN4zQ9oGSekv3MZN/QOXK8dxgW6ISKi1BHB3W6x3+NaqR2tZiUN1Qa1W/bYnj5WsvvYl7Z5+DOOfRExt7bGmj8bpaB5dA34wrC9rMvKssmESlYs26Jr1agOoFotsZ5XEGUbvapzsoYE3diX4qd+b7ox61SDLvYxxpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c5uCzmsjGKdTxQy/RGt4NvqPnr6Heiwjlvwn6knWga8=;
 b=NebY9xH6aMqeUDZVYbgga7Fu0fg4u46gPgRnSXQfxCcWOTtVOu2eeH3FR33joNZc6YlUhuAGyrFFbl3E4qkF/yL5Oiy0w1bPBYFHeZVWvRiMKeg+sopHHK5RPA3fB43O1fCGHJteBOrDrlD0nGnxCHzoU25HeiLoVIhGin8unBLQtjZKo3GKfHL8d5H/nwWG+vSjxZfaRXHIuSGug3VM30UM6mwLnKB4ku2QpqQcpVNljXHdANdovPuCR5+WpMj4oWQnE5b2sZPoRaLbjOEMkqhGqAn8gmEib1Ek7OnERKnkALkTNzT2GtpEvx5Yad5Iv6Q27+wz8k8OwNY13csVQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c5uCzmsjGKdTxQy/RGt4NvqPnr6Heiwjlvwn6knWga8=;
 b=ExxLTrIW0HjxVOQc+2bIboanjLIJOSa08gtYoJg57RxevGKyAfjQYvAEqaErMLNJpkRWTdjrysQoSUNgZvvR+RvROjRXYzvggqdJVyxN31gYjq5CzwNDRxDuBXncLZmEliK3EBTCargEFu3PYPGj1cNiKrtU+6sO4PhtpzqUbI4=
Received: from BN9PR03CA0922.namprd03.prod.outlook.com (2603:10b6:408:107::27)
 by BN8PR12MB3362.namprd12.prod.outlook.com (2603:10b6:408:44::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Fri, 8 Jul
 2022 16:36:39 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:107:cafe::54) by BN9PR03CA0922.outlook.office365.com
 (2603:10b6:408:107::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Fri, 8 Jul 2022 16:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 16:36:38 +0000
Received: from ryzen32.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 11:36:22 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/21] drm/amd/display: Fix windowed MPO video with ODM
 combine for DCN32
Date: Sat, 9 Jul 2022 00:35:13 +0800
Message-ID: <20220708163529.3534276-6-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708163529.3534276-1-solomon.chiu@amd.com>
References: <20220708163529.3534276-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fbe3c523-3473-4e6b-f9b8-08da6100080d
X-MS-TrafficTypeDiagnostic: BN8PR12MB3362:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UiG5AkWcI32AjApfyXBtlD2EYyUqbEtZ4pHX1eYPyxnkDlfVvGdtjyqGg4sTjDK+u2s07oMRtRBb7Hxpc8VXIVKd+OMJPfhZTguWwH9/8szGtmr5XXg1UvdZyjp26AZbpwJD6FotUc4JQEy1NhcaTs/dj1nKDmW6V5OcIojQ2/EimlYBbRhVSN+9iI5v0nD4/CqFPtMbEgCt2ZbnckgFHWlzqZBygkZBGkwC61QD/xECCbUDm8mjdU4DJo8s0Sv0nWyk141fm1EvGG1keBApqw94AFiWk5pF83VqJkOtDNJFEaiGtLNutRRUGEQA0poAL6SprVtB3//ILDOt8ZsTLJUVLXMco9zag/oKOcvP5uvm4VfBpUS5qngzK4S/0+oOAxol/zQZgJA02+vYdNeyDE4J+sFuJwx2ITgJnnpo49UTCg3BRc1ZpEiQZtrRpK5aqT7KdTTq+gZ8UWDXUO6pYFxFKwaDEVPjw8HswqIsXVn2aXoyWJJvm8MIClFE+Z5jcvt/gjmgzRrU74IbVpnP9iANvC2KS6YVi1jVLOR2+b2UEKSZISjlgVc91s8dSxIM8uiA72N32AIZbb12l2v6Fenv+ELlcDDTO2yuczqCSRZO6raLKWbc2C+DancNdyyTQ/IIew8go6J3Xg9k7+K0rdOkKssyLgopGbrRAJRFtzBqvWTMsyAZ3i1luKAEutjxNW5ifoYZ/Jsp5XSDAMYy4MwGN75Mlsq4lHcKKLc+1A9NJgzQJuN64rgODtPpQjIt5xOTIBEe8DYiRHNz/JxwMDLj39kz9Hn0WR6aaKArXsLfTpJQy9MoDJZM7CzIy1ZL0PzAPT2IWFpBDpJmkphHd6FThy9FD9+xjkh/fvBXrkSZOqVHSSR2FKfh+opHUmPc
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(376002)(136003)(396003)(39860400002)(40470700004)(36840700001)(46966006)(86362001)(8936002)(44832011)(30864003)(81166007)(54906003)(40480700001)(5660300002)(6916009)(478600001)(40460700003)(356005)(4326008)(8676002)(47076005)(82740400003)(70586007)(41300700001)(70206006)(426003)(2906002)(316002)(83380400001)(6666004)(26005)(1076003)(16526019)(2616005)(186003)(82310400005)(7696005)(34020700004)(36756003)(36860700001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 16:36:38.8593 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbe3c523-3473-4e6b-f9b8-08da6100080d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3362
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Samson Tam <Samson.Tam@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <Samson.Tam@amd.com>

[Why]
In single display configuration, windowed MPO does not work
 with ODM combine.

[How]
For ODM + MPO window on one half of ODM, only 3 pipes should
 be allocated and scaling parameters adjusted to handle this case.
 Otherwise, we use 4 pipes.
Move copy_surface_update_to_plane() before dc_add_plane_to_context()
 so that it gets the updated rect information when setting up
 the pipes.
Add dc_check_boundary_crossing_for_windowed_mpo_with_odm() to force
 a full update when we cross a boundary requiring us to reconfigure
 the number of pipes between 3 and 4 pipes.
Set config.enable_windowed_mpo_odm to true when we have the
 debug.enable_single_display_2to1_odm_policy set to true.
Don't fail validating ODM with windowed MPO if
 config.enable_windowed_mpo_odm is true.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  94 ++++++++++++++
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 115 ++++++++++++++----
 2 files changed, 188 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e13bf66f70e0..a448696ee8f2 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2415,6 +2415,96 @@ static enum surface_update_type check_update_surfaces_for_stream(
 	return overall_type;
 }
 
+static bool dc_check_is_fullscreen_video(struct rect src, struct rect clip_rect)
+{
+	int view_height, view_width, clip_x, clip_y, clip_width, clip_height;
+
+	view_height = src.height;
+	view_width = src.width;
+
+	clip_x = clip_rect.x;
+	clip_y = clip_rect.y;
+
+	clip_width = clip_rect.width;
+	clip_height = clip_rect.height;
+
+	/* check for centered video accounting for off by 1 scaling truncation */
+	if ((view_height - clip_y - clip_height <= clip_y + 1) &&
+			(view_width - clip_x - clip_width <= clip_x + 1) &&
+			(view_height - clip_y - clip_height >= clip_y - 1) &&
+			(view_width - clip_x - clip_width >= clip_x - 1)) {
+
+		/* when OS scales up/down to letter box, it may end up
+		 * with few blank pixels on the border due to truncating.
+		 * Add offset margin to account for this
+		 */
+		if (clip_x <= 4 || clip_y <= 4)
+			return true;
+	}
+
+	return false;
+}
+
+static enum surface_update_type check_boundary_crossing_for_windowed_mpo_with_odm(struct dc *dc,
+		struct dc_surface_update *srf_updates, int surface_count,
+		enum surface_update_type update_type)
+{
+	enum surface_update_type new_update_type = update_type;
+	int i, j;
+	struct pipe_ctx *pipe = NULL;
+	struct dc_stream_state *stream;
+
+	/* Check that we are in windowed MPO with ODM
+	 * - look for MPO pipe by scanning pipes for first pipe matching
+	 *   surface that has moved ( position change )
+	 * - MPO pipe will have top pipe
+	 * - check that top pipe has ODM pointer
+	 */
+	if ((surface_count > 1) && dc->config.enable_windowed_mpo_odm) {
+		for (i = 0; i < surface_count; i++) {
+			if (srf_updates[i].surface && srf_updates[i].scaling_info
+					&& srf_updates[i].surface->update_flags.bits.position_change) {
+
+				for (j = 0; j < dc->res_pool->pipe_count; j++) {
+					if (srf_updates[i].surface == dc->current_state->res_ctx.pipe_ctx[j].plane_state) {
+						pipe = &dc->current_state->res_ctx.pipe_ctx[j];
+						stream = pipe->stream;
+						break;
+					}
+				}
+
+				if (pipe && pipe->top_pipe && (get_num_odm_splits(pipe->top_pipe) > 0) && stream
+						&& !dc_check_is_fullscreen_video(stream->src, srf_updates[i].scaling_info->clip_rect)) {
+					struct rect old_clip_rect, new_clip_rect;
+					bool old_clip_rect_left, old_clip_rect_right, old_clip_rect_middle;
+					bool new_clip_rect_left, new_clip_rect_right, new_clip_rect_middle;
+
+					old_clip_rect = srf_updates[i].surface->clip_rect;
+					new_clip_rect = srf_updates[i].scaling_info->clip_rect;
+
+					old_clip_rect_left = ((old_clip_rect.x + old_clip_rect.width) <= (stream->src.x + (stream->src.width/2)));
+					old_clip_rect_right = (old_clip_rect.x >= (stream->src.x + (stream->src.width/2)));
+					old_clip_rect_middle = !old_clip_rect_left && !old_clip_rect_right;
+
+					new_clip_rect_left = ((new_clip_rect.x + new_clip_rect.width) <= (stream->src.x + (stream->src.width/2)));
+					new_clip_rect_right = (new_clip_rect.x >= (stream->src.x + (stream->src.width/2)));
+					new_clip_rect_middle = !new_clip_rect_left && !new_clip_rect_right;
+
+					if (old_clip_rect_left && new_clip_rect_middle)
+						new_update_type = UPDATE_TYPE_FULL;
+					else if (old_clip_rect_middle && new_clip_rect_right)
+						new_update_type = UPDATE_TYPE_FULL;
+					else if (old_clip_rect_right && new_clip_rect_middle)
+						new_update_type = UPDATE_TYPE_FULL;
+					else if (old_clip_rect_middle && new_clip_rect_left)
+						new_update_type = UPDATE_TYPE_FULL;
+				}
+			}
+		}
+	}
+	return new_update_type;
+}
+
 /*
  * dc_check_update_surfaces_for_stream() - Determine update type (fast, med, or full)
  *
@@ -2446,6 +2536,10 @@ enum surface_update_type dc_check_update_surfaces_for_stream(
 			updates[i].surface->update_flags.raw = 0xFFFFFFFF;
 	}
 
+	if (type == UPDATE_TYPE_MED)
+		type = check_boundary_crossing_for_windowed_mpo_with_odm(dc,
+				updates, surface_count, type);
+
 	if (type == UPDATE_TYPE_FAST) {
 		// If there's an available clock comparator, we use that.
 		if (dc->clk_mgr->funcs->are_clock_states_equal) {
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 2aa42c710488..9eb7e7027622 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -757,6 +757,10 @@ static void calculate_split_count_and_index(struct pipe_ctx *pipe_ctx, int *spli
 			(*split_idx)++;
 			split_pipe = split_pipe->top_pipe;
 		}
+
+		/* MPO window on right side of ODM split */
+		if (split_pipe && split_pipe->prev_odm_pipe && !pipe_ctx->prev_odm_pipe)
+			(*split_idx)++;
 	} else {
 		/*Get odm split index*/
 		struct pipe_ctx *split_pipe = pipe_ctx->prev_odm_pipe;
@@ -803,7 +807,11 @@ static void calculate_recout(struct pipe_ctx *pipe_ctx)
 	/*
 	 * Only the leftmost ODM pipe should be offset by a nonzero distance
 	 */
-	if (!pipe_ctx->prev_odm_pipe || split_idx == split_count) {
+	if (pipe_ctx->top_pipe && pipe_ctx->top_pipe->prev_odm_pipe && !pipe_ctx->prev_odm_pipe) {
+		/* MPO window on right side of ODM split */
+		data->recout.x = stream->dst.x + (surf_clip.x - stream->src.x - stream->src.width/2) *
+				stream->dst.width / stream->src.width;
+	} else if (!pipe_ctx->prev_odm_pipe || split_idx == split_count) {
 		data->recout.x = stream->dst.x;
 		if (stream->src.x < surf_clip.x)
 			data->recout.x += (surf_clip.x - stream->src.x) * stream->dst.width
@@ -1001,6 +1009,8 @@ static void calculate_inits_and_viewports(struct pipe_ctx *pipe_ctx)
 			* stream->dst.height / stream->src.height;
 	if (pipe_ctx->prev_odm_pipe && split_idx)
 		ro_lb = data->h_active * split_idx - recout_full_x;
+	else if (pipe_ctx->top_pipe && pipe_ctx->top_pipe->prev_odm_pipe)
+		ro_lb = data->h_active * split_idx - recout_full_x + data->recout.x;
 	else
 		ro_lb = data->recout.x - recout_full_x;
 	ro_tb = data->recout.y - recout_full_y;
@@ -1106,9 +1116,26 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 			timing->h_border_left + timing->h_border_right;
 	pipe_ctx->plane_res.scl_data.v_active = timing->v_addressable +
 		timing->v_border_top + timing->v_border_bottom;
-	if (pipe_ctx->next_odm_pipe || pipe_ctx->prev_odm_pipe)
+	if (pipe_ctx->next_odm_pipe || pipe_ctx->prev_odm_pipe) {
 		pipe_ctx->plane_res.scl_data.h_active /= get_num_odm_splits(pipe_ctx) + 1;
 
+		DC_LOG_SCALER("%s pipe %d: next_odm_pipe:%d   prev_odm_pipe:%d\n",
+				__func__,
+				pipe_ctx->pipe_idx,
+				pipe_ctx->next_odm_pipe ? pipe_ctx->next_odm_pipe->pipe_idx : -1,
+				pipe_ctx->prev_odm_pipe ? pipe_ctx->prev_odm_pipe->pipe_idx : -1);
+	}	/* ODM + windows MPO, where window is on either right or left ODM half */
+	else if (pipe_ctx->top_pipe && (pipe_ctx->top_pipe->next_odm_pipe || pipe_ctx->top_pipe->prev_odm_pipe)) {
+
+		pipe_ctx->plane_res.scl_data.h_active /= get_num_odm_splits(pipe_ctx->top_pipe) + 1;
+
+		DC_LOG_SCALER("%s ODM + windows MPO: pipe:%d top_pipe:%d   top_pipe->next_odm_pipe:%d   top_pipe->prev_odm_pipe:%d\n",
+				__func__,
+				pipe_ctx->pipe_idx,
+				pipe_ctx->top_pipe->pipe_idx,
+				pipe_ctx->top_pipe->next_odm_pipe ? pipe_ctx->top_pipe->next_odm_pipe->pipe_idx : -1,
+				pipe_ctx->top_pipe->prev_odm_pipe ? pipe_ctx->top_pipe->prev_odm_pipe->pipe_idx : -1);
+	}
 	/* depends on h_active */
 	calculate_recout(pipe_ctx);
 	/* depends on pixel format */
@@ -1116,10 +1143,12 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 	/* depends on scaling ratios and recout, does not calculate offset yet */
 	calculate_viewport_size(pipe_ctx);
 
-	/* Stopgap for validation of ODM + MPO on one side of screen case */
-	if (pipe_ctx->plane_res.scl_data.viewport.height < 1 ||
-			pipe_ctx->plane_res.scl_data.viewport.width < 1)
-		return false;
+	if (!pipe_ctx->stream->ctx->dc->config.enable_windowed_mpo_odm) {
+		/* Stopgap for validation of ODM + MPO on one side of screen case */
+		if (pipe_ctx->plane_res.scl_data.viewport.height < 1 ||
+				pipe_ctx->plane_res.scl_data.viewport.width < 1)
+			return false;
+	}
 
 	/*
 	 * LB calculations depend on vp size, h/v_active and scaling ratios
@@ -1420,6 +1449,7 @@ bool dc_add_plane_to_context(
 	struct pipe_ctx *head_pipe, *tail_pipe, *free_pipe;
 	struct dc_stream_status *stream_status = NULL;
 
+	DC_LOGGER_INIT(stream->ctx->logger);
 	for (i = 0; i < context->stream_count; i++)
 		if (context->streams[i] == stream) {
 			stream_status = &context->stream_status[i];
@@ -1466,23 +1496,66 @@ bool dc_add_plane_to_context(
 		if (head_pipe != free_pipe) {
 			tail_pipe = resource_get_tail_pipe(&context->res_ctx, head_pipe);
 			ASSERT(tail_pipe);
-			free_pipe->stream_res.tg = tail_pipe->stream_res.tg;
-			free_pipe->stream_res.abm = tail_pipe->stream_res.abm;
-			free_pipe->stream_res.opp = tail_pipe->stream_res.opp;
-			free_pipe->stream_res.stream_enc = tail_pipe->stream_res.stream_enc;
-			free_pipe->stream_res.audio = tail_pipe->stream_res.audio;
-			free_pipe->clock_source = tail_pipe->clock_source;
-			free_pipe->top_pipe = tail_pipe;
-			tail_pipe->bottom_pipe = free_pipe;
-			if (!free_pipe->next_odm_pipe && tail_pipe->next_odm_pipe && tail_pipe->next_odm_pipe->bottom_pipe) {
-				free_pipe->next_odm_pipe = tail_pipe->next_odm_pipe->bottom_pipe;
-				tail_pipe->next_odm_pipe->bottom_pipe->prev_odm_pipe = free_pipe;
-			}
-			if (!free_pipe->prev_odm_pipe && tail_pipe->prev_odm_pipe && tail_pipe->prev_odm_pipe->bottom_pipe) {
-				free_pipe->prev_odm_pipe = tail_pipe->prev_odm_pipe->bottom_pipe;
-				tail_pipe->prev_odm_pipe->bottom_pipe->next_odm_pipe = free_pipe;
+
+			/* ODM + window MPO, where MPO window is on right half only */
+			if (free_pipe->plane_state &&
+					(free_pipe->plane_state->clip_rect.x >= free_pipe->stream->src.x + free_pipe->stream->src.width/2) &&
+					tail_pipe->next_odm_pipe) {
+
+				DC_LOG_SCALER("%s - ODM + window MPO(right). free_pipe:%d  tail_pipe->next_odm_pipe:%d\n",
+						__func__,
+						free_pipe->pipe_idx,
+						tail_pipe->next_odm_pipe ? tail_pipe->next_odm_pipe->pipe_idx : -1);
+
+				free_pipe->stream_res.tg = tail_pipe->next_odm_pipe->stream_res.tg;
+				free_pipe->stream_res.abm = tail_pipe->next_odm_pipe->stream_res.abm;
+				free_pipe->stream_res.opp = tail_pipe->next_odm_pipe->stream_res.opp;
+				free_pipe->stream_res.stream_enc = tail_pipe->next_odm_pipe->stream_res.stream_enc;
+				free_pipe->stream_res.audio = tail_pipe->next_odm_pipe->stream_res.audio;
+				free_pipe->clock_source = tail_pipe->next_odm_pipe->clock_source;
+
+				free_pipe->top_pipe = tail_pipe->next_odm_pipe;
+				tail_pipe->next_odm_pipe->bottom_pipe = free_pipe;
+			} else {
+				free_pipe->stream_res.tg = tail_pipe->stream_res.tg;
+				free_pipe->stream_res.abm = tail_pipe->stream_res.abm;
+				free_pipe->stream_res.opp = tail_pipe->stream_res.opp;
+				free_pipe->stream_res.stream_enc = tail_pipe->stream_res.stream_enc;
+				free_pipe->stream_res.audio = tail_pipe->stream_res.audio;
+				free_pipe->clock_source = tail_pipe->clock_source;
+
+				free_pipe->top_pipe = tail_pipe;
+				tail_pipe->bottom_pipe = free_pipe;
+
+				if (!free_pipe->next_odm_pipe && tail_pipe->next_odm_pipe && tail_pipe->next_odm_pipe->bottom_pipe) {
+					free_pipe->next_odm_pipe = tail_pipe->next_odm_pipe->bottom_pipe;
+					tail_pipe->next_odm_pipe->bottom_pipe->prev_odm_pipe = free_pipe;
+				}
+				if (!free_pipe->prev_odm_pipe && tail_pipe->prev_odm_pipe && tail_pipe->prev_odm_pipe->bottom_pipe) {
+					free_pipe->prev_odm_pipe = tail_pipe->prev_odm_pipe->bottom_pipe;
+					tail_pipe->prev_odm_pipe->bottom_pipe->next_odm_pipe = free_pipe;
+				}
 			}
 		}
+
+		/* ODM + window MPO, where MPO window is on left half only */
+		if (free_pipe->plane_state &&
+				(free_pipe->plane_state->clip_rect.x + free_pipe->plane_state->clip_rect.width <=
+				free_pipe->stream->src.x + free_pipe->stream->src.width/2)) {
+			DC_LOG_SCALER("%s - ODM + window MPO(left). free_pipe:%d\n",
+					__func__,
+					free_pipe->pipe_idx);
+			break;
+		}
+		/* ODM + window MPO, where MPO window is on right half only */
+		if (free_pipe->plane_state &&
+				(free_pipe->plane_state->clip_rect.x >= free_pipe->stream->src.x + free_pipe->stream->src.width/2)) {
+			DC_LOG_SCALER("%s - ODM + window MPO(right). free_pipe:%d\n",
+					__func__,
+					free_pipe->pipe_idx);
+			break;
+		}
+
 		head_pipe = head_pipe->next_odm_pipe;
 	}
 	/* assign new surfaces*/
-- 
2.25.1


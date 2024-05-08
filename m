Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF34AC04FFE
	for <amd-gfx@archiver.kernel.org>; Wed,  8 May 2024 17:17:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 348C711311F;
	Wed,  8 May 2024 17:17:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="txQuCW55";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2073.outbound.protection.outlook.com [40.107.237.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A19FD11311F
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 May 2024 17:17:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fW62OpvzYI7M3Tc8EqgJ+1pxjp160FVcL5/rCWf9sqDAZmZQhJpgmY6l5kpDGEyqC+O8vs8a5adXydQ6z992dtg6bl50l+JOxUCpRBfAmkyJ32KfHQccZimipHtmIIxC9uKb/DywgoxnjPeAl8uY/inq+JC5pMcE4Vw0z9iuhS9jMUaOeyjoQdPJQpDp2lk6lsGRItIPNoHPw62ekRkhPxGxNE/3FetUpbbhw2yWS/GdUdQI05kRD/qd5IawLnRAnskqOQtquqMNJha0FD61/0JqM6GrXYfDnifGBSR2/EZjfiXXQyqqf2uuv/uXw8Ja9QuvyRZftp5KbM3WLsCS1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NU/UJbzRu/ht/CMoTIGVdAS24XDCjUzRDgqA82KI+LA=;
 b=dmCCnhKNoJR3P0L8J/228765L1h6xXry8K6tx/UAjs3SuXgsFSDwZAD4hvl/KXkFza9KcPOuqropPwH7U1aWB5pynxFoFBCIMHSyErxXT3wtTkCld6ejs0ZnLhVOLcIUH2FU34J0DjuDr+wYs7cWu4g5gr3o5YvmMljV0sutyJk+FT5060Gor3yCpztXfm+LddoN4EO0cznW+gMknVXUACmTk5FATifoxD7qxFrBHlEXLWNMoUV+UJkWKRQIM6q7rAjheBlm0YW/LoFqgQZEgcINhb7VPmmsGE9WbtCXXiWTptgEv+d7IsFsomc5koRoU2h3QPml+jopdpJ2e6l4Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NU/UJbzRu/ht/CMoTIGVdAS24XDCjUzRDgqA82KI+LA=;
 b=txQuCW55U1P+9beJ2oNSjYe0/XzzOXPn/BUHEIpHZCVUlnxo4jQpwRa7QlRJkzZ07A0usSdZkGtrICoFshy6NFm0A7cV2SBgOOaGCdNG9bIHua0soHA0gJO+Sotm/epB9CDtok/HVGaKknNSHLWrr2Nk7+pza8H3AdurskAKU5I=
Received: from BL1PR13CA0155.namprd13.prod.outlook.com (2603:10b6:208:2bd::10)
 by MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Wed, 8 May
 2024 17:17:00 +0000
Received: from BN2PEPF000044A7.namprd04.prod.outlook.com
 (2603:10b6:208:2bd:cafe::96) by BL1PR13CA0155.outlook.office365.com
 (2603:10b6:208:2bd::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46 via Frontend
 Transport; Wed, 8 May 2024 17:17:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044A7.mail.protection.outlook.com (10.167.243.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7544.18 via Frontend Transport; Wed, 8 May 2024 17:17:00 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 8 May
 2024 12:16:58 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, George Shen <george.shen@amd.com>, Alex Hung
 <alex.hung@amd.com>
Subject: [PATCH 09/20] drm/amd/display: Add resource interfaces for get ODM
 slice rect
Date: Wed, 8 May 2024 11:13:09 -0600
Message-ID: <20240508171320.3292065-10-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240508171320.3292065-1-alex.hung@amd.com>
References: <20240508171320.3292065-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A7:EE_|MN2PR12MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: 59412375-ec90-47d3-e93d-08dc6f82ac1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|1800799015|376005|82310400017|36860700004; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?6/zGGnfb4bbkkBsc9voMdoktjN7IlteXdKHQ7a12v670C+5rCvoSRNRh9gXo?=
 =?us-ascii?Q?M0wc6tYtwQ4I8u6GqQOdof5cosCMeCLvDDGHA/3wfiw1GGkhPPJTf+2/wTYu?=
 =?us-ascii?Q?euM5j6BG7Muplo+SDk/qARrmqqJE91bF1+LmHp24uFRzSnrUMzElkOHGTPHC?=
 =?us-ascii?Q?TmJ4GWuNI6kn7mHPbp0h4Kh+Q0vrdHyQ+xU1cSs5Xn5jX4vH3Qd+zQdBuFa0?=
 =?us-ascii?Q?Ythmh0sS56PxhUofBo+aDEaOePfyZS9pAZ7KugI7DplKU6K3DH+iildQWg4r?=
 =?us-ascii?Q?9ZTxkFYy0utifpTZ3bW9fEst8H4yim398RgBw3YN4yiKoo715pZjTEhu5LLG?=
 =?us-ascii?Q?0al6VqvQjwXqXUZ1SBN1GtQdTcqaSvnaMA6c/EPWoZVwQ/iiEvMLeVUTz9fr?=
 =?us-ascii?Q?955NiXeeMqbthwItGJWQYdEKKo0UDguUBZjhf3R5EKLETSjc4oCrxXddJ7Cn?=
 =?us-ascii?Q?pEPoTG6GOxfF0t6XKzmB1A3mVZo1HMAfG9ztVv4swBHcFqhu1+2UyEMPxOFO?=
 =?us-ascii?Q?M8gE4Co1LPt2wF1kkCDu4lg1m5li8jAp22odOJNqTDCRQyCqYPqYw+6EmqZ9?=
 =?us-ascii?Q?/VfnpTC84Cq3C2aZklusNMbbBSuQSwg3yn+0GNCUx2INH6lf+SujS2UwtQsu?=
 =?us-ascii?Q?nupdShpF2QvWVT6bdnwfGaxe/IgMArTcGmMpQFhG9j20Feg88IziB33IUh4N?=
 =?us-ascii?Q?TvdtsgweHPoBgAYPDoy1VYaTnQ89Y7JG/z56MA5nZkNmM4xtdR8PnEzqEGhJ?=
 =?us-ascii?Q?OCKxQ0TEugXoCRWmtngGrt5v0GYjpmIAsU/9nW+UES5EfOXpBCuTlYafLH/w?=
 =?us-ascii?Q?18CeH5Hv8A4gVz8YGZ6uPnNu2TuLxaFOGF5zd7/RVR63KW60EJOCvlYifWzZ?=
 =?us-ascii?Q?yjaugy0bYkuwCi9Wy1DE4M+8KJwi8zKcKlH676eW/tvNJksp77KLabOiW5s7?=
 =?us-ascii?Q?02wkYVfTahaKII0/aiREhQZyCFFphyMQQDqZjCaO58O/cmxBizzaIQhVQSFS?=
 =?us-ascii?Q?QccvtUouzSQZ8hdbNgFixoawOUuXR/4VGqd4vTkJaL1l9j64kh11s0h997tJ?=
 =?us-ascii?Q?fynQpZhv1l6UmrPP7vrgNDRopch9ewyvrbo5poiGzTC4sTsNBFZb33QY1huX?=
 =?us-ascii?Q?IBAOVw1iNJWb+Bw3X/BMYO6hSIx4jtX1Ptn3bRJogT/o6u5vyQlR0m+d+YZr?=
 =?us-ascii?Q?FyZluJNn04vAzxPCd9b6DLhmeC9cueGVSRZOg218KO/RIdZmX5rwTdnYE6oE?=
 =?us-ascii?Q?uLxlYMfprDqyzgoudoIfCfsDBRuQXXPH+QMcTgEaDdenpoD1+e69E3xsXyO0?=
 =?us-ascii?Q?Tcj8yANsQbjHS1y30aXSd6HKZPxx56Ia/OuWGAvtt0UNVfD+6ppwrJp769dg?=
 =?us-ascii?Q?VOfKzRg=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(376005)(82310400017)(36860700004); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 17:17:00.3503 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59412375-ec90-47d3-e93d-08dc6f82ac1f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000044A7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304
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

[WHY]
We need an unified location to perform ODM slice rect calculation.

[HOW]
Add three interfaces for ODM slice rect/width calucaltion in resource.h

Reviewed-by: George Shen <george.shen@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 137 ++++++++++--------
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  10 ++
 2 files changed, 83 insertions(+), 64 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 532882ee7b2b..fd03d7129ffa 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -816,37 +816,6 @@ static struct rect shift_rec(const struct rect *rec_in, int x, int y)
 	return rec_out;
 }
 
-static struct rect calculate_odm_slice_in_timing_active(struct pipe_ctx *pipe_ctx)
-{
-	const struct dc_stream_state *stream = pipe_ctx->stream;
-	int odm_slice_count = resource_get_odm_slice_count(pipe_ctx);
-	int odm_slice_idx = resource_get_odm_slice_index(pipe_ctx);
-	bool is_last_odm_slice = (odm_slice_idx + 1) == odm_slice_count;
-	int h_active = stream->timing.h_addressable +
-			stream->timing.h_border_left +
-			stream->timing.h_border_right;
-	int odm_slice_width = h_active / odm_slice_count;
-	struct rect odm_rec;
-	bool is_two_pixels_per_container =
-			pipe_ctx->stream_res.tg->funcs->is_two_pixels_per_container(&stream->timing);
-
-	if ((odm_slice_width % 2) && is_two_pixels_per_container)
-		odm_slice_width++;
-
-	odm_rec.x = odm_slice_width * odm_slice_idx;
-	odm_rec.width = is_last_odm_slice ?
-			/* last slice width is the reminder of h_active */
-			h_active - odm_slice_width * (odm_slice_count - 1) :
-			/* odm slice width is the floor of h_active / count */
-			odm_slice_width;
-	odm_rec.y = 0;
-	odm_rec.height = stream->timing.v_addressable +
-			stream->timing.v_border_bottom +
-			stream->timing.v_border_top;
-
-	return odm_rec;
-}
-
 static struct rect calculate_plane_rec_in_timing_active(
 		struct pipe_ctx *pipe_ctx,
 		const struct rect *rec_in)
@@ -1134,7 +1103,7 @@ static void calculate_recout(struct pipe_ctx *pipe_ctx)
 	 */
 	struct rect plane_clip;
 	struct rect mpc_slice_of_plane_clip;
-	struct rect odm_slice;
+	struct rect odm_slice_src;
 	struct rect overlapping_area;
 
 	plane_clip = calculate_plane_rec_in_timing_active(pipe_ctx,
@@ -1144,16 +1113,16 @@ static void calculate_recout(struct pipe_ctx *pipe_ctx)
 				&pipe_ctx->stream->dst);
 	mpc_slice_of_plane_clip = calculate_mpc_slice_in_timing_active(
 			pipe_ctx, &plane_clip);
-	odm_slice = calculate_odm_slice_in_timing_active(pipe_ctx);
-	overlapping_area = intersect_rec(&mpc_slice_of_plane_clip, &odm_slice);
+	odm_slice_src = resource_get_odm_slice_src_rect(pipe_ctx);
+	overlapping_area = intersect_rec(&mpc_slice_of_plane_clip, &odm_slice_src);
 	if (overlapping_area.height > 0 &&
 			overlapping_area.width > 0) {
 		/* shift the overlapping area so it is with respect to current
-		 * ODM slice's position
+		 * ODM slice source's position
 		 */
 		pipe_ctx->plane_res.scl_data.recout = shift_rec(
 				&overlapping_area,
-				-odm_slice.x, -odm_slice.y);
+				-odm_slice_src.x, -odm_slice_src.y);
 		adjust_recout_for_visual_confirm(
 				&pipe_ctx->plane_res.scl_data.recout,
 				pipe_ctx);
@@ -1290,13 +1259,13 @@ static void calculate_inits_and_viewports(struct pipe_ctx *pipe_ctx)
 	struct rect recout_clip_in_active_timing;
 	struct rect recout_clip_in_recout_dst;
 	struct rect overlap_in_active_timing;
-	struct rect odm_slice = calculate_odm_slice_in_timing_active(pipe_ctx);
+	struct rect odm_slice_src = resource_get_odm_slice_src_rect(pipe_ctx);
 	int vpc_div = (data->format == PIXEL_FORMAT_420BPP8
 				|| data->format == PIXEL_FORMAT_420BPP10) ? 2 : 1;
 	bool orthogonal_rotation, flip_vert_scan_dir, flip_horz_scan_dir;
 
 	recout_clip_in_active_timing = shift_rec(
-			&data->recout, odm_slice.x, odm_slice.y);
+			&data->recout, odm_slice_src.x, odm_slice_src.y);
 	recout_dst_in_active_timing = calculate_plane_rec_in_timing_active(
 			pipe_ctx, &plane_state->dst_rect);
 	overlap_in_active_timing = intersect_rec(&recout_clip_in_active_timing,
@@ -1465,20 +1434,13 @@ static enum controller_dp_color_space convert_dp_to_controller_color_space(
 void resource_build_test_pattern_params(struct resource_context *res_ctx,
 				struct pipe_ctx *otg_master)
 {
-	int odm_slice_width, last_odm_slice_width, offset = 0;
 	struct pipe_ctx *opp_heads[MAX_PIPES];
 	struct test_pattern_params *params;
-	int odm_cnt = 1;
+	int odm_cnt;
 	enum controller_dp_test_pattern controller_test_pattern;
 	enum controller_dp_color_space controller_color_space;
 	enum dc_color_depth color_depth = otg_master->stream->timing.display_color_depth;
-	int h_active = otg_master->stream->timing.h_addressable +
-		otg_master->stream->timing.h_border_left +
-		otg_master->stream->timing.h_border_right;
-	int v_active = otg_master->stream->timing.v_addressable +
-		otg_master->stream->timing.v_border_bottom +
-		otg_master->stream->timing.v_border_top;
-	bool is_two_pixels_per_container = otg_master->stream_res.tg->funcs->is_two_pixels_per_container(&otg_master->stream->timing);
+	struct rect odm_slice_src;
 	int i;
 
 	controller_test_pattern = convert_dp_to_controller_test_pattern(
@@ -1491,25 +1453,15 @@ void resource_build_test_pattern_params(struct resource_context *res_ctx,
 
 	odm_cnt = resource_get_opp_heads_for_otg_master(otg_master, res_ctx, opp_heads);
 
-	odm_slice_width = h_active / odm_cnt;
-	if ((odm_slice_width % 2) && is_two_pixels_per_container)
-		odm_slice_width++;
-	last_odm_slice_width = h_active - odm_slice_width * (odm_cnt - 1);
-
 	for (i = 0; i < odm_cnt; i++) {
+		odm_slice_src = resource_get_odm_slice_src_rect(opp_heads[i]);
 		params = &opp_heads[i]->stream_res.test_pattern_params;
 		params->test_pattern = controller_test_pattern;
 		params->color_space = controller_color_space;
 		params->color_depth = color_depth;
-		params->height = v_active;
-		params->offset = offset;
-
-		if (i < odm_cnt - 1)
-			params->width = odm_slice_width;
-		else
-			params->width = last_odm_slice_width;
-
-		offset += odm_slice_width;
+		params->height = odm_slice_src.height;
+		params->offset = odm_slice_src.x;
+		params->width = odm_slice_src.width;
 	}
 }
 
@@ -1517,7 +1469,7 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 {
 	const struct dc_plane_state *plane_state = pipe_ctx->plane_state;
 	struct dc_crtc_timing *timing = &pipe_ctx->stream->timing;
-	const struct rect odm_slice_rec = calculate_odm_slice_in_timing_active(pipe_ctx);
+	const struct rect odm_slice_src = resource_get_odm_slice_src_rect(pipe_ctx);
 	bool res = false;
 
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
@@ -1540,8 +1492,8 @@ bool resource_build_scaling_params(struct pipe_ctx *pipe_ctx)
 	pipe_ctx->stream->dst.y += timing->v_border_top;
 
 	/* Calculate H and V active size */
-	pipe_ctx->plane_res.scl_data.h_active = odm_slice_rec.width;
-	pipe_ctx->plane_res.scl_data.v_active = odm_slice_rec.height;
+	pipe_ctx->plane_res.scl_data.h_active = odm_slice_src.width;
+	pipe_ctx->plane_res.scl_data.v_active = odm_slice_src.height;
 	pipe_ctx->plane_res.scl_data.format = convert_pixel_format_to_dalsurface(
 			pipe_ctx->plane_state->format);
 
@@ -2114,6 +2066,63 @@ int resource_get_odm_slice_index(const struct pipe_ctx *pipe_ctx)
 	return index;
 }
 
+int resource_get_odm_slice_dst_width(struct pipe_ctx *otg_master,
+		bool is_last_segment)
+{
+	const struct dc_crtc_timing *timing = &otg_master->stream->timing;
+	int count = resource_get_odm_slice_count(otg_master);
+	int h_active = timing->h_addressable +
+			timing->h_border_left +
+			timing->h_border_right;
+	int width = h_active / count;
+	bool two_pixel_alignment_required =
+			otg_master->stream_res.tg->funcs->is_two_pixels_per_container(timing);
+
+	if ((width % 2) && two_pixel_alignment_required)
+		width++;
+
+	return is_last_segment ?
+			h_active - width * (count - 1) :
+			width;
+}
+
+struct rect resource_get_odm_slice_dst_rect(struct pipe_ctx *pipe_ctx)
+{
+	const struct dc_stream_state *stream = pipe_ctx->stream;
+	bool is_last_odm_slice = pipe_ctx->next_odm_pipe == NULL;
+	struct pipe_ctx *otg_master = resource_get_otg_master(pipe_ctx);
+	int odm_slice_idx = resource_get_odm_slice_index(pipe_ctx);
+	int odm_segment_offset = resource_get_odm_slice_dst_width(otg_master, false);
+	struct rect odm_slice_dst;
+
+	odm_slice_dst.x = odm_segment_offset * odm_slice_idx;
+	odm_slice_dst.width = resource_get_odm_slice_dst_width(otg_master, is_last_odm_slice);
+	odm_slice_dst.y = 0;
+	odm_slice_dst.height = stream->timing.v_addressable +
+			stream->timing.v_border_bottom +
+			stream->timing.v_border_top;
+
+	return odm_slice_dst;
+}
+
+struct rect resource_get_odm_slice_src_rect(struct pipe_ctx *pipe_ctx)
+{
+	struct rect odm_slice_dst;
+	struct rect odm_slice_src;
+	struct pipe_ctx *opp_head = resource_get_opp_head(pipe_ctx);
+	uint32_t left_edge_extra_pixel_count;
+
+	odm_slice_dst = resource_get_odm_slice_dst_rect(opp_head);
+	odm_slice_src = odm_slice_dst;
+
+	left_edge_extra_pixel_count = 0;
+
+	odm_slice_src.x -= left_edge_extra_pixel_count;
+	odm_slice_src.width += left_edge_extra_pixel_count;
+
+	return odm_slice_src;
+}
+
 bool resource_is_pipe_topology_changed(const struct dc_state *state_a,
 		const struct dc_state *state_b)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 5c980644591d..96d40d33a1f9 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -442,6 +442,16 @@ int resource_get_odm_slice_count(const struct pipe_ctx *pipe);
 /* Get the ODM slice index counting from 0 from left most slice */
 int resource_get_odm_slice_index(const struct pipe_ctx *opp_head);
 
+/* Get ODM slice source rect in timing active as input to OPP block */
+struct rect resource_get_odm_slice_src_rect(struct pipe_ctx *pipe_ctx);
+
+/* Get ODM slice destination rect in timing active as output from OPP block */
+struct rect resource_get_odm_slice_dst_rect(struct pipe_ctx *pipe_ctx);
+
+/* Get ODM slice destination width in timing active as output from OPP block */
+int resource_get_odm_slice_dst_width(struct pipe_ctx *otg_master,
+		bool is_last_segment);
+
 /* determine if pipe topology is changed between state a and state b */
 bool resource_is_pipe_topology_changed(const struct dc_state *state_a,
 		const struct dc_state *state_b);
-- 
2.34.1


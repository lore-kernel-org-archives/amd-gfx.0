Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE06C7EE2A
	for <amd-gfx@archiver.kernel.org>; Wed, 10 May 2023 20:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 75F9B10E523;
	Wed, 10 May 2023 20:49:21 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2084.outbound.protection.outlook.com [40.107.220.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20B1110E522
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 May 2023 20:49:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CanzcgMlj5GbZrxYdqdRLQsvnptfbyoX7Z3nTSzKzRZbAML58qseCpBrqhppWF1FMB5IUgOzU2QoC9QBHNM/A/ZEZFWDnMMWJHUNJ0iCuxXyBrbzSg3h2mj64Nko/LOzfQSp77602doUHTt5mDm6rz1XvsEsugrMxt5tg3W2bGGZDSqhSpoNi4FJOeahZGBi44QNIlog+zGyw9dGwHVnQoUSIlvSL59kjYQfHu/TzwXIHoLxD4DGe9h/6+QTIPHITSM6fZELDnEy51sQLq79O4+rOkyk+h0jAJooIyAiL0t02qSbSsbA7RlNgF66HMw8JbMQosuxP36IolTy2ONEGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wjZ3/ZCE6xq3WQm/zRZvQhLicP5i7eHTqZt0Mpkuxx0=;
 b=dakrMvzKDH10rsAi66ANgT3OcD1abiMNNkWS8JyPNga/IFzXXXH0mW9rnQTR1B/ZKWvgcwTEgfO0wNEk6cuxBMAUCAYrioNevPYhTfLtovaiEMy6eG4sUlEcxkiJoer3URF5bO8JAGdgR43orNHCkeZTL+ncWRKfZmSC9hCPTPP4N55UmauWumoXp8VRxFtYu/UJciXcTRoggD9KbusKxk7lxGPhXD7fwLjSZRywZjjDowKHF8HAvJ8WYsC+Dv44rChxnf7a7vxH4PSirj08mHQVJhQCaNK3+kEf16uR3/W/dhSUIaGIDz3x8l02cs0K3f3JeCss0l99n3yi+B3PxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wjZ3/ZCE6xq3WQm/zRZvQhLicP5i7eHTqZt0Mpkuxx0=;
 b=ImNK6a6WQsAy05QcU9q9z0PScZz5Dq1JRi9f+CMuOGLZKN/P5IVzfxNMU0ahpfW4jXgXVp9MylDwmNJ3mXVNQTBrc9Rg0bkr557kN8OfT8xplm82VsE+yzCp3FY19S4H1kMLRMbn6jwTqoea0KnW0TlASjDsvW5ZBZirwvONScs=
Received: from BN0PR04CA0002.namprd04.prod.outlook.com (2603:10b6:408:ee::7)
 by PH7PR12MB6665.namprd12.prod.outlook.com (2603:10b6:510:1a7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.20; Wed, 10 May
 2023 20:49:15 +0000
Received: from BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ee:cafe::5d) by BN0PR04CA0002.outlook.office365.com
 (2603:10b6:408:ee::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.18 via Frontend
 Transport; Wed, 10 May 2023 20:49:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT098.mail.protection.outlook.com (10.13.177.196) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6387.18 via Frontend Transport; Wed, 10 May 2023 20:49:15 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 15:49:13 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 10 May
 2023 13:49:13 -0700
Received: from fedaura-ryzen.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Wed, 10 May 2023 15:49:12 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/10] drm/amd/display: Add visual confirm color support for
 MCLK switch
Date: Wed, 10 May 2023 16:48:56 -0400
Message-ID: <20230510204900.949963-7-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230510204900.949963-1-aurabindo.pillai@amd.com>
References: <20230510204900.949963-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT098:EE_|PH7PR12MB6665:EE_
X-MS-Office365-Filtering-Correlation-Id: 89428553-56ef-4bd3-1014-08db5198048b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fYk3hrxfWd+AjJnbGMz8GBcw7+SUh6Ccu2s3/DMpLrGXydg64oCjKNAzljUDdHRXaSXnF0+ysamsXrY6ebaEQg9clX/7SkD3oUpgrrMMJYg3KiNmeTNZfwH5eh3ZW9AXepcyEjwVZeZCyr5Mt3QvyWrGP3IMXSg32hdMz8IGYiujfUHRjodG0CQd0EOev3Mjt3wMQlZTOfg44vEkxOOPlbYWd+4r8qe8UdZ/XhFB34HEdqSzL98qpvJ5oC5XyXmLsk0wKd8Y+FRXHCnYDzqXWE9n54skYvJeS8dOp1Sj0OknbD8ElWu/clw9Y+8xqzEIZyCsGqOJphjbDjSocn4tdoQSBdz+iPHFtYnqvScO07XqKr0fbRDFLcgQt+FXhhY2JDONBIVJkUuTG0F9Nd27LnD5hB3c5NhEmb+Za5Jyj+zbzSEV6Gkj9TFgktNCRi+NxH0cFQRCjTuMpxK2SjpQI1bI/HzC8C8QVc3z+7RhBEn4KXC4bZMBGP8mxxeWEw5+A9uI9Z7EjQz8MfbUrt7IK2IR0G5gLGJgNc1IN7ZDyzibkSQhHiwCD1HpOFpXe8wmD+/ri5hAT4W1jGG73Q6ihLd7xN64DGQkVJn/bj3T1mxS/XUcYAsW9BJP4QHj2ntYJqAukj6qC+0B7k6fQzHbnx9N9TQEztZ9MIOS2iCN6hnNKChLGy9jbQt3MmJxWZzRlyv+92hwSMloa/Wnhdv8K3WuHqh7+rJ7wGOcBi1fzDAPXsCopz440k2qKxVrBVCK0dcq1wPlr2doPGjMYO40QF3mbwhIJAD85NdyHgVpTXc=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(46966006)(40470700004)(36840700001)(54906003)(6916009)(36860700001)(478600001)(8676002)(7696005)(86362001)(82310400005)(356005)(6666004)(316002)(4326008)(70206006)(70586007)(83380400001)(336012)(426003)(47076005)(2616005)(36756003)(41300700001)(81166007)(40460700003)(44832011)(82740400003)(8936002)(186003)(30864003)(26005)(2906002)(1076003)(5660300002)(40480700001)(36900700001)(44824005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2023 20:49:15.5689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 89428553-56ef-4bd3-1014-08db5198048b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6665
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 "Leo \(Hanghong\) Ma" <hanghong.ma@amd.com>, Jun Lei <jun.lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

[Why && How]
We would like to have visual confirm color support for MCLK switch.
	1. Set visual confirm color to yellow: Vblank MCLK switch.
	2. Set visual confirm color to cyan: FPO + Vblank MCLK
	switch.
	3. Set visual confirm color to pink: Vactive MCLK switch.

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 47 +++++++++++++++--
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 50 +++++++++++++++++--
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 22 +++-----
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |  1 -
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 26 +---------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |  5 --
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  2 +-
 .../drm/amd/display/dc/dcn201/dcn201_hwseq.c  |  4 +-
 .../drm/amd/display/dc/dcn201/dcn201_init.c   |  2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  2 +-
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |  2 +-
 .../gpu/drm/amd/display/dc/dcn31/dcn31_init.c |  2 +-
 .../drm/amd/display/dc/dcn314/dcn314_init.c   |  2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  2 +-
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  7 +++
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  2 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  9 +++-
 19 files changed, 125 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 9be18ebb1c17..adf5d0e1a7c5 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1119,6 +1119,33 @@ static void phantom_pipe_blank(
 		hws->funcs.wait_for_blank_complete(opp);
 }
 
+static void dc_update_viusal_confirm_color(struct dc *dc, struct dc_state *context, struct pipe_ctx *pipe_ctx)
+{
+	if (dc->ctx->dce_version >= DCN_VERSION_1_0) {
+		memset(&pipe_ctx->visual_confirm_color, 0, sizeof(struct tg_color));
+
+		if (dc->debug.visual_confirm == VISUAL_CONFIRM_HDR)
+			get_hdr_visual_confirm_color(pipe_ctx, &(pipe_ctx->visual_confirm_color));
+		else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SURFACE)
+			get_surface_visual_confirm_color(pipe_ctx, &(pipe_ctx->visual_confirm_color));
+		else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SWIZZLE)
+			get_surface_tile_visual_confirm_color(pipe_ctx, &(pipe_ctx->visual_confirm_color));
+		else {
+			if (dc->ctx->dce_version < DCN_VERSION_2_0)
+				color_space_to_black_color(
+					dc, pipe_ctx->stream->output_color_space, &(pipe_ctx->visual_confirm_color));
+		}
+		if (dc->ctx->dce_version >= DCN_VERSION_2_0) {
+			if (dc->debug.visual_confirm == VISUAL_CONFIRM_MPCTREE)
+				get_mpctree_visual_confirm_color(pipe_ctx, &(pipe_ctx->visual_confirm_color));
+			else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SUBVP)
+				get_subvp_visual_confirm_color(dc, context, pipe_ctx, &(pipe_ctx->visual_confirm_color));
+			else if (dc->debug.visual_confirm == VISUAL_CONFIRM_MCLK_SWITCH)
+				get_mclk_switch_visual_confirm_color(dc, context, pipe_ctx, &(pipe_ctx->visual_confirm_color));
+		}
+	}
+}
+
 static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 {
 	int i, j;
@@ -1189,6 +1216,9 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 			dc_rem_all_planes_for_stream(dc, old_stream, dangling_context);
 			disable_all_writeback_pipes_for_stream(dc, old_stream, dangling_context);
 
+			if (pipe->stream && pipe->plane_state)
+				dc_update_viusal_confirm_color(dc, context, pipe);
+
 			if (dc->hwss.apply_ctx_for_surface) {
 				apply_ctx_interdependent_lock(dc, dc->current_state, old_stream, true);
 				dc->hwss.apply_ctx_for_surface(dc, old_stream, 0, dangling_context);
@@ -3456,6 +3486,14 @@ static void commit_planes_for_stream(struct dc *dc,
 		}
 	}
 
+	if (dc->debug.visual_confirm)
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+			if (pipe->stream && pipe->plane_state)
+				dc_update_viusal_confirm_color(dc, context, pipe);
+		}
+
 	if (stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE) {
 		struct pipe_ctx *mpcc_pipe;
 		struct pipe_ctx *odm_pipe;
@@ -3539,15 +3577,14 @@ static void commit_planes_for_stream(struct dc *dc,
 		for (j = 0; j < dc->res_pool->pipe_count; j++) {
 			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
 
-			if (dc->debug.visual_confirm == VISUAL_CONFIRM_SUBVP &&
+			if ((dc->debug.visual_confirm == VISUAL_CONFIRM_SUBVP ||
+				dc->debug.visual_confirm == VISUAL_CONFIRM_MCLK_SWITCH) &&
 				pipe_ctx->stream && pipe_ctx->plane_state) {
-				/* Only update visual confirm for SUBVP here.
+				/* Only update visual confirm for SUBVP and Mclk switching here.
 				 * The bar appears on all pipes, so we need to update the bar on all displays,
 				 * so the information doesn't get stale.
 				 */
-				struct mpcc_blnd_cfg blnd_cfg = { 0 };
-
-				dc->hwss.update_visual_confirm_color(dc, pipe_ctx, &blnd_cfg.black_color,
+				dc->hwss.update_visual_confirm_color(dc, pipe_ctx,
 						pipe_ctx->plane_res.hubp->inst);
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 2acbf692193f..8a98b8dd008e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -421,6 +421,7 @@ void get_hdr_visual_confirm_color(
 
 void get_subvp_visual_confirm_color(
 		struct dc *dc,
+		struct dc_state *context,
 		struct pipe_ctx *pipe_ctx,
 		struct tg_color *color)
 {
@@ -428,15 +429,17 @@ void get_subvp_visual_confirm_color(
 	bool enable_subvp = false;
 	int i;
 
-	if (!dc->ctx || !dc->ctx->dmub_srv || !pipe_ctx)
+	if (!dc->ctx || !dc->ctx->dmub_srv || !pipe_ctx || !context)
 		return;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
 		if (pipe->stream && pipe->stream->mall_stream_config.paired_stream &&
 		    pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
 			/* SubVP enable - red */
+			color->color_g_y = 0;
+			color->color_b_cb = 0;
 			color->color_r_cr = color_value;
 			enable_subvp = true;
 
@@ -448,12 +451,51 @@ void get_subvp_visual_confirm_color(
 
 	if (enable_subvp && pipe_ctx->stream->mall_stream_config.type == SUBVP_NONE) {
 		color->color_r_cr = 0;
-		if (pipe_ctx->stream->ignore_msa_timing_param == 1)
+		if (pipe_ctx->stream->allow_freesync == 1) {
 			/* SubVP enable and DRR on - green */
+			color->color_b_cb = 0;
 			color->color_g_y = color_value;
-		else
+		} else {
 			/* SubVP enable and No DRR - blue */
+			color->color_g_y = 0;
+			color->color_b_cb = color_value;
+		}
+	}
+}
+
+void get_mclk_switch_visual_confirm_color(
+		struct dc *dc,
+		struct dc_state *context,
+		struct pipe_ctx *pipe_ctx,
+		struct tg_color *color)
+{
+	uint32_t color_value = MAX_TG_COLOR_VALUE;
+	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
+
+	if (!dc->ctx || !dc->ctx->dmub_srv || !pipe_ctx || !vba || !context)
+		return;
+
+	if (vba->DRAMClockChangeSupport[vba->VoltageLevel][vba->maxMpcComb] !=
+			dm_dram_clock_change_unsupported) {
+		/* MCLK switching is supported */
+		if (!pipe_ctx->has_vactive_margin) {
+			/* In Vblank - yellow */
+			color->color_r_cr = color_value;
+			color->color_g_y = color_value;
+
+			if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
+				/* FPO + Vblank - cyan */
+				color->color_r_cr = 0;
+				color->color_g_y  = color_value;
+				color->color_b_cb = color_value;
+			}
+		} else {
+			/* In Vactive - pink */
+			color->color_r_cr = color_value;
 			color->color_b_cb = color_value;
+		}
+		/* SubVP */
+		get_subvp_visual_confirm_color(dc, context, pipe_ctx, color);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 1ebb8d3573f4..8be2e6d6d888 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -426,6 +426,7 @@ enum visual_confirm {
 	VISUAL_CONFIRM_FAMS = 7,
 	VISUAL_CONFIRM_SWIZZLE = 9,
 	VISUAL_CONFIRM_SUBVP = 14,
+	VISUAL_CONFIRM_MCLK_SWITCH = 16,
 };
 
 enum dc_psr_power_opts {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index a7ad1d7bc43e..905246a2ece4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2602,23 +2602,15 @@ static void dcn10_update_dpp(struct dpp *dpp, struct dc_plane_state *plane_state
 		dpp->funcs->dpp_program_bias_and_scale(dpp, &bns_params);
 }
 
-void dcn10_update_visual_confirm_color(struct dc *dc, struct pipe_ctx *pipe_ctx, struct tg_color *color, int mpcc_id)
+void dcn10_update_visual_confirm_color(struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		int mpcc_id)
 {
 	struct mpc *mpc = dc->res_pool->mpc;
 
-	if (dc->debug.visual_confirm == VISUAL_CONFIRM_HDR)
-		get_hdr_visual_confirm_color(pipe_ctx, color);
-	else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SURFACE)
-		get_surface_visual_confirm_color(pipe_ctx, color);
-	else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SWIZZLE)
-		get_surface_tile_visual_confirm_color(pipe_ctx, color);
-	else
-		color_space_to_black_color(
-				dc, pipe_ctx->stream->output_color_space, color);
-
 	if (mpc->funcs->set_bg_color) {
-		memcpy(&pipe_ctx->plane_state->visual_confirm_color, color, sizeof(struct tg_color));
-		mpc->funcs->set_bg_color(mpc, color, mpcc_id);
+		memcpy(&pipe_ctx->plane_state->visual_confirm_color, &(pipe_ctx->visual_confirm_color), sizeof(struct tg_color));
+		mpc->funcs->set_bg_color(mpc, &(pipe_ctx->visual_confirm_color), mpcc_id);
 	}
 }
 
@@ -2671,7 +2663,7 @@ void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	/* If there is no full update, don't need to touch MPC tree*/
 	if (!pipe_ctx->plane_state->update_flags.bits.full_update) {
 		mpc->funcs->update_blending(mpc, &blnd_cfg, mpcc_id);
-		dc->hwss.update_visual_confirm_color(dc, pipe_ctx, &blnd_cfg.black_color, mpcc_id);
+		dc->hwss.update_visual_confirm_color(dc, pipe_ctx, mpcc_id);
 		return;
 	}
 
@@ -2693,7 +2685,7 @@ void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 			NULL,
 			hubp->inst,
 			mpcc_id);
-	dc->hwss.update_visual_confirm_color(dc, pipe_ctx, &blnd_cfg.black_color, mpcc_id);
+	dc->hwss.update_visual_confirm_color(dc, pipe_ctx, mpcc_id);
 
 	ASSERT(new_mpcc != NULL);
 	hubp->opp_id = pipe_ctx->stream_res.opp->inst;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
index 0ef7bf7ddb75..ef6d56da417c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
@@ -202,7 +202,6 @@ void dcn10_get_dcc_en_bits(struct dc *dc, int *dcc_en_bits);
 void dcn10_update_visual_confirm_color(
 		struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
-		struct tg_color *color,
 		int mpcc_id);
 
 #endif /* __DC_HWSS_DCN10_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index f49c1c0d6274..b3e187b1347d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2580,28 +2580,6 @@ void dcn20_reset_hw_ctx_wrap(
 	}
 }
 
-void dcn20_update_visual_confirm_color(struct dc *dc, struct pipe_ctx *pipe_ctx, struct tg_color *color, int mpcc_id)
-{
-	struct mpc *mpc = dc->res_pool->mpc;
-
-	// input to MPCC is always RGB, by default leave black_color at 0
-	if (dc->debug.visual_confirm == VISUAL_CONFIRM_HDR)
-		get_hdr_visual_confirm_color(pipe_ctx, color);
-	else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SURFACE)
-		get_surface_visual_confirm_color(pipe_ctx, color);
-	else if (dc->debug.visual_confirm == VISUAL_CONFIRM_MPCTREE)
-		get_mpctree_visual_confirm_color(pipe_ctx, color);
-	else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SWIZZLE)
-		get_surface_tile_visual_confirm_color(pipe_ctx, color);
-	else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SUBVP)
-		get_subvp_visual_confirm_color(dc, pipe_ctx, color);
-
-	if (mpc->funcs->set_bg_color) {
-		memcpy(&pipe_ctx->plane_state->visual_confirm_color, color, sizeof(struct tg_color));
-		mpc->funcs->set_bg_color(mpc, color, mpcc_id);
-	}
-}
-
 void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
 	struct hubp *hubp = pipe_ctx->plane_res.hubp;
@@ -2657,7 +2635,7 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	if (!pipe_ctx->plane_state->update_flags.bits.full_update &&
 		!pipe_ctx->update_flags.bits.mpcc) {
 		mpc->funcs->update_blending(mpc, &blnd_cfg, mpcc_id);
-		dc->hwss.update_visual_confirm_color(dc, pipe_ctx, &blnd_cfg.black_color, mpcc_id);
+		dc->hwss.update_visual_confirm_color(dc, pipe_ctx, mpcc_id);
 		return;
 	}
 
@@ -2679,7 +2657,7 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 			NULL,
 			hubp->inst,
 			mpcc_id);
-	dc->hwss.update_visual_confirm_color(dc, pipe_ctx, &blnd_cfg.black_color, mpcc_id);
+	dc->hwss.update_visual_confirm_color(dc, pipe_ctx, mpcc_id);
 
 	ASSERT(new_mpcc != NULL);
 	hubp->opp_id = pipe_ctx->stream_res.opp->inst;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
index 33a36c02b2f8..01901b08644c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
@@ -150,10 +150,5 @@ void dcn20_set_disp_pattern_generator(const struct dc *dc,
 		const struct tg_color *solid_color,
 		int width, int height, int offset);
 
-void dcn20_update_visual_confirm_color(struct dc *dc,
-		struct pipe_ctx *pipe_ctx,
-		struct tg_color *color,
-		int mpcc_id);
-
 #endif /* __DC_HWSS_DCN20_H__ */
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index 7c5817c426fa..4192c522e59a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -102,7 +102,7 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.disable_link_output = dce110_disable_link_output,
 	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
-	.update_visual_confirm_color = dcn20_update_visual_confirm_color
+	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
 };
 
 static const struct hwseq_private_funcs dcn20_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
index 1aeb04fbd89d..75472d53ff52 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_hwseq.c
@@ -496,7 +496,7 @@ void dcn201_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 
 	/* If there is no full update, don't need to touch MPC tree*/
 	if (!pipe_ctx->plane_state->update_flags.bits.full_update) {
-		dc->hwss.update_visual_confirm_color(dc, pipe_ctx, &blnd_cfg.black_color, mpcc_id);
+		dc->hwss.update_visual_confirm_color(dc, pipe_ctx, mpcc_id);
 		mpc->funcs->update_blending(mpc, &blnd_cfg, mpcc_id);
 		return;
 	}
@@ -521,7 +521,7 @@ void dcn201_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 					dc->res_pool->mpc, mpcc_id);
 
 	/* Call MPC to insert new plane */
-	dc->hwss.update_visual_confirm_color(dc, pipe_ctx, &blnd_cfg.black_color, mpcc_id);
+	dc->hwss.update_visual_confirm_color(dc, pipe_ctx, mpcc_id);
 	new_mpcc = mpc->funcs->insert_plane(dc->res_pool->mpc,
 			mpc_tree_params,
 			&blnd_cfg,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c
index 9c16633e473a..92dd4cddbab8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_init.c
@@ -91,7 +91,7 @@ static const struct hw_sequencer_funcs dcn201_funcs = {
 	.enable_dp_link_output = dce110_enable_dp_link_output,
 	.disable_link_output = dce110_disable_link_output,
 	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
-	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
+	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
 };
 
 static const struct hwseq_private_funcs dcn201_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index fe1a8e2e08ef..8b58ce1db035 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -106,7 +106,7 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.is_abm_supported = dcn21_is_abm_supported,
 	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
-	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
+	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
 };
 
 static const struct hwseq_private_funcs dcn21_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index 3216d10c58ba..18e94d8ae54f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -106,7 +106,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.disable_link_output = dce110_disable_link_output,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
-	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
+	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
 	.is_abm_supported = dcn21_is_abm_supported
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
index 6192851c59ed..257df8660b4c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
@@ -107,7 +107,7 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 	.optimize_pwr_state = dcn21_optimize_pwr_state,
 	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
-	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
+	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
 };
 
 static const struct hwseq_private_funcs dcn301_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
index 8598ea233ef3..ba9e7dee6e5e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_init.c
@@ -110,7 +110,7 @@ static const struct hw_sequencer_funcs dcn31_funcs = {
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.optimize_pwr_state = dcn21_optimize_pwr_state,
 	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
-	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
+	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
 };
 
 static const struct hwseq_private_funcs dcn31_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
index ed8a1b94c006..7a28c7bb25d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_init.c
@@ -112,7 +112,7 @@ static const struct hw_sequencer_funcs dcn314_funcs = {
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.optimize_pwr_state = dcn21_optimize_pwr_state,
 	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
-	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
+	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
 };
 
 static const struct hwseq_private_funcs dcn314_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index 8085f2acb1a9..24a890d879b8 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -109,7 +109,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.commit_subvp_config = dcn32_commit_subvp_config,
 	.enable_phantom_streams = dcn32_enable_phantom_streams,
 	.subvp_pipe_control_lock = dcn32_subvp_pipe_control_lock,
-	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
+	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
 	.update_phantom_vp_position = dcn32_update_phantom_vp_position,
 	.update_dsc_pg = dcn32_update_dsc_pg,
 	.apply_update_flags_for_phantom = dcn32_apply_update_flags_for_phantom,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 8c60b88c7d1a..d8d8fcd5ef1f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1324,6 +1324,7 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 	int i, pipe_idx, active_hubp_count = 0;
 	bool usr_retraining_support = false;
 	bool unbounded_req_enabled = false;
+	struct vba_vars_st *vba = &context->bw_ctx.dml.vba;
 
 	dc_assert_fp_enabled();
 
@@ -1405,6 +1406,11 @@ static void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context,
 
 		context->res_ctx.pipe_ctx[i].surface_size_in_mall_bytes = get_surface_size_in_mall(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
 
+		if (vba->ActiveDRAMClockChangeLatencyMarginPerState[vba->VoltageLevel][vba->maxMpcComb][vba->pipe_plane[pipe_idx]] > 0)
+			context->res_ctx.pipe_ctx[i].has_vactive_margin = true;
+		else
+			context->res_ctx.pipe_ctx[i].has_vactive_margin = false;
+
 		/* MALL Allocation Sizes */
 		/* count from active, top pipes per plane only */
 		if (context->res_ctx.pipe_ctx[i].stream && context->res_ctx.pipe_ctx[i].plane_state &&
@@ -2015,6 +2021,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 				maxMpcComb = context->bw_ctx.dml.vba.maxMpcComb;
 				dcfclk_from_fw_based_mclk_switching = context->bw_ctx.dml.vba.DCFCLKState[vlevel][context->bw_ctx.dml.vba.maxMpcComb];
 				pstate_en = true;
+				context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] = dm_dram_clock_change_vblank;
 			} else {
 				/* Restore FCLK latency and re-run validation to go back to original validation
 				 * output if we find that enabling FPO does not give us any benefit (i.e. lower
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 2eb597a24425..b4c1cc6dc857 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -426,6 +426,8 @@ struct pipe_ctx {
 	struct dwbc *dwbc;
 	struct mcif_wb *mcif_wb;
 	union pipe_update_flags update_flags;
+	struct tg_color visual_confirm_color;
+	bool has_vactive_margin;
 };
 
 /* Data used for dynamic link encoder assignment.
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 88ac723d10aa..df160c6a630c 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -257,7 +257,6 @@ struct hw_sequencer_funcs {
 
 	void (*update_visual_confirm_color)(struct dc *dc,
 			struct pipe_ctx *pipe_ctx,
-			struct tg_color *color,
 			int mpcc_id);
 
 	void (*update_phantom_vp_position)(struct dc *dc,
@@ -294,6 +293,7 @@ void get_surface_visual_confirm_color(
 
 void get_subvp_visual_confirm_color(
 	struct dc *dc,
+	struct dc_state *context,
 	struct pipe_ctx *pipe_ctx,
 	struct tg_color *color);
 
@@ -306,4 +306,11 @@ void get_mpctree_visual_confirm_color(
 void get_surface_tile_visual_confirm_color(
 		struct pipe_ctx *pipe_ctx,
 		struct tg_color *color);
+
+void get_mclk_switch_visual_confirm_color(
+		struct dc *dc,
+		struct dc_state *context,
+		struct pipe_ctx *pipe_ctx,
+		struct tg_color *color);
+
 #endif /* __DC_HW_SEQUENCER_H__ */
-- 
2.40.0


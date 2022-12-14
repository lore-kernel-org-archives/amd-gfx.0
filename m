Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E93FCC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 20:22:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA23510E477;
	Wed, 14 Dec 2022 20:22:12 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 072E310E472
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 20:22:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F16+bDLq+K13Bn9lo6VrVfgGPOu5Pz7R4NlT1LTTHfhW8xDanDL8HZX25dl3Jtw9ZGQgdcwi77FCtIiK7Ylum1XmOhB6HTQTgKxlb9Aih1zmoTRVLMrHIJnFNnGBqccn9beEDNxH000GphumPVQOz7tbJvVWX3Ei5sFXa4B2aLfk/AlR11EVJQ0zlF7MiEEwzGh4uCsYEmSwISJpFA7n7jbsOg9TgrHrtn7jRvUUlHcypP3l69AenOqJw+6NGsrQ/pAAY+r05jEs4IxQ6Sv7SLfuRHh+BKZ7vixziNglUuXm3Lo7vWgLIEP4B0q+gKM7L3QEzsuOhyz/amCQlnZByg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSYz+si5gzU1bmKIQYOjSKkHv0tZ7A5s7GRwUiX2Dgc=;
 b=MPEp4Ipv3AE8HN9m8ZFuiRCFCLJTz6Zo0HXtxh7SHgXtPfir0/ypr9ytA1ihsxUByiJKUtJ+4VDhaIix9G9tcIAfZl6WbYfCKFZw8u7DO5xCPC9NoCSFuP9pcMdpuKviH8Lk26/VGayrXwF/DqbniiZf4BBJuAiy+alB6+Ns6Bj0cf/BWhObGZ/CjR5SlPhTTLQSIKnB7eoJmaj6Wz9WP/MyLJvi51nmGTy+CtFc7LAmu2QEfYIG4NLvwesOQTZlcXa6gZULLNwGfFw+RQHNpRwso4zxjU2eoAv9Nz29f8UoCNWHfMWxvTydydVbl1uxt/nmKeaqwDvi/KnaeOq68w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSYz+si5gzU1bmKIQYOjSKkHv0tZ7A5s7GRwUiX2Dgc=;
 b=vH1/0DQaQA4DCfKUNYGy25kR8PwOR+tkws3uM7Oc/fzVbXo4SzKhrhYv7wNsnk0uDYSz3bS01c+EgJCvyUgFC8XP5m88Z7uBGl6CXgQUJfhQdb8qIx5dM6qLPGuvy2D9rWq3O4gduwuRXY1o2xUEVYUfOXnHmGtZbd5NJ9xwtTA=
Received: from MW4PR03CA0108.namprd03.prod.outlook.com (2603:10b6:303:b7::23)
 by SA3PR12MB7902.namprd12.prod.outlook.com (2603:10b6:806:305::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 20:22:02 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::96) by MW4PR03CA0108.outlook.office365.com
 (2603:10b6:303:b7::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 20:22:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 20:22:01 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:21:56 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:21:56 -0600
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 14 Dec 2022 14:21:55 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/18] drm/amd/display: Turn on phantom OTG before disabling
 phantom pipe
Date: Wed, 14 Dec 2022 15:21:30 -0500
Message-ID: <20221214202141.1721178-8-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|SA3PR12MB7902:EE_
X-MS-Office365-Filtering-Correlation-Id: fa6c22a6-6ffa-471e-af12-08dade10dbf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QzNa84RQTSYcuT6IRlkT073i9f9AA3sPsOCGvs1GpA4lOvMpeq/qSMF5frMlIkmaFUe5mh+2mtDthZse4QIO1kgsT+A4QQOkIVa5k7hraq7FOg5YDAgnkD5jMoFnb2+yR213qrbvTtDU+XW8qbB8bKUajyjokkvx/IDlb04F4W0E9Ry/Lc9qjtzsWv2+roRne1gCuUUSrzWPJUhysWf+mphJ/uZ6Utjp0WURpgdvg1hpaxeCCXFNZ63l7wGsB7Hk+g4PmB5rTzOTmPseaP2s5F28zjp7tIAk9n480wzkoKtK2HLsmGfIdw4GblbEG9+5OFyA9ydDeX6Qn7DO7pWNYGb4fHaQTpJAOxhyYbTE9VQMZXk/r3Kt1DoHAv+7kO1wf/qIqfr9PXaRSgQ3mjOc1mu7zyvJ8C2TLmEB50uGfGtKiTBI6BfB/We+3mDOKIaQk9fimd+r7yLLK7hi031rpef4b47L6/RPDILSSob7lMyXMdpAYOX/QI4vyzIXHBiyJUvQ5vyucyZJ4MBdEJLS6Ml1GNWn8qrzbxhdWwHIjCA6dv6TdJUEVMtctny63MRh1NtfrEVGTV6QEYLkqvAL5SR32sw4pcCoZTtZPKCCRP77gqVQugcJWlSoZxBOJfdzE8OhEg9uS8TlcwQP+ybCuVOVyW+k3aSVldaoAvU13ELevPIMrTScdIzalSjp2MZB2ug3IjGraEBarwpGd7PNNCXq+ie0G6A84IibT6WcBug=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(346002)(136003)(396003)(39860400002)(451199015)(40470700004)(46966006)(36840700001)(6666004)(82310400005)(36756003)(83380400001)(186003)(47076005)(426003)(26005)(7696005)(86362001)(6916009)(40480700001)(316002)(8676002)(36860700001)(70586007)(82740400003)(4326008)(478600001)(70206006)(54906003)(41300700001)(336012)(2616005)(81166007)(356005)(1076003)(44832011)(40460700003)(5660300002)(2906002)(8936002)(30864003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 20:22:01.5807 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fa6c22a6-6ffa-471e-af12-08dade10dbf3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7902
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, "Lee,
 Alvin" <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Lee, Alvin" <Alvin.Lee2@amd.com>

[Description]
- Proper phantom pipe disable sequence was missing in
  commit_planes_for_stream
- If disabling phantom pipe, turn on phantom OTG first, and turn
  off the phantom OTG after the plane is disabled
- Also update sequence for enabling / disabling phantom streams
  (apply_ctx_to_hw). When enabling phantom pipes, enable before
  doing front end programming for phantom pipes. If disabling
  phantom pipes, disable after front end programming (i.e. after
  phantom plane disable)
- TODO: Still need to properly handle transition case when a phantom
  pipe is transitioned directly into a real pipe (need to fully disable
  the phantom pipe first)

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 58 ++++++++-----------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 24 ++++++++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 36 ++++++++++++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |  2 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  1 +
 6 files changed, 88 insertions(+), 34 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e265faff4c3d..f41933845d2a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3326,6 +3326,7 @@ static void commit_planes_for_stream(struct dc *dc,
 	struct pipe_ctx *top_pipe_to_program = NULL;
 	bool should_lock_all_pipes = (update_type != UPDATE_TYPE_FAST);
 	bool subvp_prev_use = false;
+	bool subvp_curr_use = false;
 
 	// Once we apply the new subvp context to hardware it won't be in the
 	// dc->current_state anymore, so we have to cache it before we apply
@@ -3382,6 +3383,15 @@ static void commit_planes_for_stream(struct dc *dc,
 			break;
 	}
 
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (pipe->stream && pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
+			subvp_curr_use = true;
+			break;
+		}
+	}
+
 	if (stream->test_pattern.type != DP_TEST_PATTERN_VIDEO_MODE) {
 		struct pipe_ctx *mpcc_pipe;
 		struct pipe_ctx *odm_pipe;
@@ -3653,42 +3663,22 @@ static void commit_planes_for_stream(struct dc *dc,
 					top_pipe_to_program->stream_res.tg);
 		}
 
-	/* For phantom pipe OTG enable, it has to be done after any previous pipe
-	 * that was in use has already been programmed at gotten its double buffer
-	 * update for "disable".
-	 */
-	if (update_type != UPDATE_TYPE_FAST) {
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-			struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
-
-			/* If an active, non-phantom pipe is being transitioned into a phantom
-			 * pipe, wait for the double buffer update to complete first before we do
-			 * ANY phantom pipe programming.
-			 */
-			if (pipe->stream && pipe->stream->mall_stream_config.type == SUBVP_PHANTOM &&
-					old_pipe->stream && old_pipe->stream->mall_stream_config.type != SUBVP_PHANTOM) {
-				old_pipe->stream_res.tg->funcs->wait_for_state(
-						old_pipe->stream_res.tg,
-						CRTC_STATE_VBLANK);
-				old_pipe->stream_res.tg->funcs->wait_for_state(
-						old_pipe->stream_res.tg,
-						CRTC_STATE_VACTIVE);
-			}
+	if (subvp_curr_use) {
+		/* If enabling subvp or transitioning from subvp->subvp, enable the
+		 * phantom streams before we program front end for the phantom pipes.
+		 */
+		if (update_type != UPDATE_TYPE_FAST) {
+			if (dc->hwss.enable_phantom_streams)
+				dc->hwss.enable_phantom_streams(dc, context);
 		}
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			struct pipe_ctx *new_pipe = &context->res_ctx.pipe_ctx[i];
+	}
 
-			if ((new_pipe->stream && new_pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) ||
-					subvp_prev_use) {
-				// If old context or new context has phantom pipes, apply
-				// the phantom timings now. We can't change the phantom
-				// pipe configuration safely without driver acquiring
-				// the DMCUB lock first.
-				dc->hwss.apply_ctx_to_hw(dc, context);
-				break;
-			}
-		}
+	if (subvp_prev_use && !subvp_curr_use) {
+		/* If disabling subvp, disable phantom streams after front end
+		 * programming has completed (we turn on phantom OTG in order
+		 * to complete the plane disable for phantom pipes).
+		 */
+		dc->hwss.apply_ctx_to_hw(dc, context);
 	}
 
 	if (update_type != UPDATE_TYPE_FAST)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 6291a241158a..366ba05cf8ef 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -582,6 +582,9 @@ void dcn20_plane_atomic_disable(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	if (pipe_ctx->stream_res.gsl_group != 0)
 		dcn20_setup_gsl_group_as_lock(dc, pipe_ctx, false);
 
+	if (hubp->funcs->hubp_update_mall_sel)
+		hubp->funcs->hubp_update_mall_sel(hubp, 0, false);
+
 	dc->hwss.set_flip_control_gsl(pipe_ctx, false);
 
 	hubp->funcs->hubp_clk_cntl(hubp, false);
@@ -605,6 +608,9 @@ void dcn20_plane_atomic_disable(struct dc *dc, struct pipe_ctx *pipe_ctx)
 
 void dcn20_disable_plane(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
+	bool is_phantom = pipe_ctx->plane_state && pipe_ctx->plane_state->is_phantom;
+	struct timing_generator *tg = is_phantom ? pipe_ctx->stream_res.tg : NULL;
+
 	DC_LOGGER_INIT(dc->ctx->logger);
 
 	if (!pipe_ctx->plane_res.hubp || pipe_ctx->plane_res.hubp->power_gated)
@@ -612,6 +618,12 @@ void dcn20_disable_plane(struct dc *dc, struct pipe_ctx *pipe_ctx)
 
 	dcn20_plane_atomic_disable(dc, pipe_ctx);
 
+	/* Turn back off the phantom OTG after the phantom plane is fully disabled
+	 */
+	if (is_phantom)
+		if (tg && tg->funcs->disable_phantom_crtc)
+			tg->funcs->disable_phantom_crtc(tg);
+
 	DC_LOG_DC("Power down front end %d\n",
 					pipe_ctx->pipe_idx);
 }
@@ -1803,6 +1815,18 @@ void dcn20_program_front_end_for_ctx(
 		dcn20_detect_pipe_changes(&dc->current_state->res_ctx.pipe_ctx[i],
 				&context->res_ctx.pipe_ctx[i]);
 
+	/* When disabling phantom pipes, turn on phantom OTG first (so we can get double
+	 * buffer updates properly)
+	 */
+	for (i = 0; i < dc->res_pool->pipe_count; i++)
+		if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable
+				&& dc->current_state->res_ctx.pipe_ctx[i].stream->mall_stream_config.type == SUBVP_PHANTOM) {
+			struct timing_generator *tg = dc->current_state->res_ctx.pipe_ctx[i].stream_res.tg;
+
+			if (tg->funcs->enable_crtc)
+				tg->funcs->enable_crtc(tg);
+		}
+
 	/* OTG blank before disabling all front ends */
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
 		if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 2f0ebe1f6c45..c10d8a60380a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1451,3 +1451,39 @@ void dcn32_update_dsc_pg(struct dc *dc,
 		}
 	}
 }
+
+void dcn32_enable_phantom_streams(struct dc *dc, struct dc_state *context)
+{
+	unsigned int i;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+
+		/* If an active, non-phantom pipe is being transitioned into a phantom
+		 * pipe, wait for the double buffer update to complete first before we do
+		 * ANY phantom pipe programming.
+		 */
+		if (pipe->stream && pipe->stream->mall_stream_config.type == SUBVP_PHANTOM &&
+				old_pipe->stream && old_pipe->stream->mall_stream_config.type != SUBVP_PHANTOM) {
+			old_pipe->stream_res.tg->funcs->wait_for_state(
+					old_pipe->stream_res.tg,
+					CRTC_STATE_VBLANK);
+			old_pipe->stream_res.tg->funcs->wait_for_state(
+					old_pipe->stream_res.tg,
+					CRTC_STATE_VACTIVE);
+		}
+	}
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *new_pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (new_pipe->stream && new_pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
+			// If old context or new context has phantom pipes, apply
+			// the phantom timings now. We can't change the phantom
+			// pipe configuration safely without driver acquiring
+			// the DMCUB lock first.
+			dc->hwss.apply_ctx_to_hw(dc, context);
+			break;
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
index 7de36529cf99..e9e9534f3668 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
@@ -102,4 +102,6 @@ void dcn32_update_dsc_pg(struct dc *dc,
 		struct dc_state *context,
 		bool safe_to_disable);
 
+void dcn32_enable_phantom_streams(struct dc *dc, struct dc_state *context);
+
 #endif /* __DC_HWSS_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index dc4649458567..330d7cbc7398 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -106,6 +106,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 	.commit_subvp_config = dcn32_commit_subvp_config,
+	.enable_phantom_streams = dcn32_enable_phantom_streams,
 	.subvp_pipe_control_lock = dcn32_subvp_pipe_control_lock,
 	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
 	.update_phantom_vp_position = dcn32_update_phantom_vp_position,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index c43523f9ff6d..88ac723d10aa 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -266,6 +266,7 @@ struct hw_sequencer_funcs {
 	void (*apply_update_flags_for_phantom)(struct pipe_ctx *phantom_pipe);
 
 	void (*commit_subvp_config)(struct dc *dc, struct dc_state *context);
+	void (*enable_phantom_streams)(struct dc *dc, struct dc_state *context);
 	void (*subvp_pipe_control_lock)(struct dc *dc,
 			struct dc_state *context,
 			bool lock,
-- 
2.39.0


Return-Path: <SRS0=KaZi=BP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191A0C433E1
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 17:41:09 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E09232073E
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 17:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="B2Kqep4Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E09232073E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 914CA89DDF;
	Wed,  5 Aug 2020 17:41:08 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BA4B89DDF
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2020 17:41:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=atOlILnSWbUNCnJZM7qAILNBrW4NvheU1VLOE3r7g3ERF+7cSXhtdF3BEXfHwpjf5Ow6pBVvuKMF2Umkt0x0sFN1oGacRjgUjvRwLbtrz2JxEFCujlA5uGPxNNnB9r994oYywc0q5ieHQCV24rGO6djRBfar5/jglg/NjU/AWqWDk50zHq/83opItfVhHA7R1iqGqQXoXLTT88Xu0nfgY5vp3ocj0fjEuc4Ux4IQEn7lHQygrv+UOP2qRwZkTOaCTncE7Fp0xao6T78pKOuBGRHMuYtEG5AOHo+IBoWjs5W9UQS5zrmqiGfHQXy8GQu5HIWNpPyy5gBpNHzToCEXDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu3gkguj1VWRGR03T5jP/LjetBHU31LNMdTgA7scWrM=;
 b=a8em1Dvg374w5dERqFFVE+6/hQ+gCPnrX4fqBadk/x5Wrsc2frz7hJ9ngv2/H9zgjztl3OGi9WjQG3dYocoveGdMLssIKqMXA/Cl/jTuSt1KOzAwxjOy8CA37qQX4OlZvxCoi5DncEcntZgi6Vw9owfOk8DXHwjhhYBLhOdlFf+kjY3cjgijnW42JPy1h3kLXwrIHpKpnCyLsIgNYPKHPWEC/ymJHm06DMGAXP/0xDrtnLqsd+3W+/1HqQA34tzT9lEFfjqX8ohQPS3+kOnOQN/5hflAKQvJMPKXgINuHp5r857u5GakYzHmdr0SVx2uIcrM0GTHllug2JU47NlKmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Hu3gkguj1VWRGR03T5jP/LjetBHU31LNMdTgA7scWrM=;
 b=B2Kqep4ZzobPZatGafyscWYSyqtbvspLS1RMSkBLPmuQRu7ZOVO7eP2NHuDMKfAeG4iC6/8hg4jrEAbpALaMHek15gSzhTOV8TvT4eFD/PE19NHDRP0jMnDpQhWbzm3uU5vQM2qp0o8ILHV3OJpYKK9kkWxZgZ/DPgn/yBavBDc=
Received: from CO1PR15CA0084.namprd15.prod.outlook.com (2603:10b6:101:20::28)
 by DM5PR12MB1676.namprd12.prod.outlook.com (2603:10b6:4:8::22) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.20; Wed, 5 Aug 2020 17:41:05 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:20:cafe::df) by CO1PR15CA0084.outlook.office365.com
 (2603:10b6:101:20::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Wed, 5 Aug 2020 17:41:04 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3261.16 via Frontend Transport; Wed, 5 Aug 2020 17:41:04 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 5 Aug 2020
 12:41:01 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 5 Aug 2020 12:41:00 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/9] drm/amd/display: Revert regression
Date: Wed, 5 Aug 2020 13:40:52 -0400
Message-ID: <20200805174058.11736-4-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805174058.11736-1-qingqing.zhuo@amd.com>
References: <20200805174058.11736-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33196659-0a93-4d70-b9e8-08d83966ba24
X-MS-TrafficTypeDiagnostic: DM5PR12MB1676:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM5PR12MB1676AAA0F2B65B69F52D4F4AFB4B0@DM5PR12MB1676.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:331;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s/Gzz3aXbc6xbtqkIIH9DY8arUlJqNHPQoYtBg+cOZuOHx+act+iy81EQn4DZTTUzQHnPIQDPTNfTCOlPnqpE9my+z7PQgO3nwcOADZkvxLyvz5HREs597kCmm1aIC9aqIHLUbd6RF7xsrCXTyr4PQBRsKJJz87PBLRslOCxb9roQKEwcuLqVL8PGDqW+MSED7pwMHBjy0D2NgZPC/QqOM/hUTJ0aJC9RKHMW5I09eyVlqw1fcyxzPs33DuCzcWE3fqLTh6KCs8h3LRSyjJ7nZuB8tRRJEtG/tcBwmn9ub4j4LY3TEo4BmaVgAJgrhIfpFSnRr5/rbjseLKEaUXj04U2NvlOjMJEvJfJJFKPVCUAqwMYRbECwR1ionkCXks4m1/7iRP1o7P8akf8Ij9hFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(46966005)(44832011)(82740400003)(426003)(81166007)(8676002)(82310400002)(83380400001)(316002)(2616005)(336012)(47076004)(6916009)(356005)(36756003)(54906003)(4326008)(26005)(70586007)(5660300002)(8936002)(186003)(478600001)(2906002)(1076003)(6666004)(86362001)(70206006);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 17:41:04.3702 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33196659-0a93-4d70-b9e8-08d83966ba24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1676
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
Caused pipe split regression

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  10 --
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 114 ------------------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |   7 --
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   2 -
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   2 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   2 -
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   4 -
 7 files changed, 141 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index ebbb8182228d..5aa3b89471c3 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2300,7 +2300,6 @@ static void commit_planes_for_stream(struct dc *dc,
 		enum surface_update_type update_type,
 		struct dc_state *context)
 {
-	bool mpcc_disconnected = false;
 	int i, j;
 	struct pipe_ctx *top_pipe_to_program = NULL;
 
@@ -2331,15 +2330,6 @@ static void commit_planes_for_stream(struct dc *dc,
 		context_clock_trace(dc, context);
 	}
 
-	if (update_type != UPDATE_TYPE_FAST && dc->hwss.interdependent_update_lock &&
-		dc->hwss.disconnect_pipes && dc->hwss.wait_for_pending_cleared){
-		dc->hwss.interdependent_update_lock(dc, context, true);
-		mpcc_disconnected = dc->hwss.disconnect_pipes(dc, context);
-		dc->hwss.interdependent_update_lock(dc, context, false);
-		if (mpcc_disconnected)
-			dc->hwss.wait_for_pending_cleared(dc, context);
-	}
-
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 73eb4e76a0b1..66180b4332f1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1624,120 +1624,6 @@ static void dcn20_program_pipe(
 	}
 }
 
-bool dcn20_disconnect_pipes(
-		struct dc *dc,
-		struct dc_state *context)
-{
-		int i;
-		struct dce_hwseq *hws = dc->hwseq;
-		bool mpcc_disconnected = false;
-		DC_LOGGER_INIT(dc->ctx->logger);
-
-		/* Set pipe update flags and lock pipes */
-		for (i = 0; i < dc->res_pool->pipe_count; i++)
-			dcn20_detect_pipe_changes(&dc->current_state->res_ctx.pipe_ctx[i],
-					&context->res_ctx.pipe_ctx[i]);
-
-		if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
-			/* OTG blank before disabling all front ends */
-			for (i = 0; i < dc->res_pool->pipe_count; i++) {
-				if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable
-					&& !context->res_ctx.pipe_ctx[i].top_pipe
-					&& !context->res_ctx.pipe_ctx[i].prev_odm_pipe
-					&& context->res_ctx.pipe_ctx[i].stream) {
-					hws->funcs.blank_pixel_data(dc, &context->res_ctx.pipe_ctx[i], true);
-				}
-			}
-
-			/* Disconnect mpcc */
-			for (i = 0; i < dc->res_pool->pipe_count; i++) {
-				if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable) {
-					hws->funcs.plane_atomic_disconnect(dc, &dc->current_state->res_ctx.pipe_ctx[i]);
-					DC_LOG_DC("Reset mpcc for pipe %d\n", dc->current_state->res_ctx.pipe_ctx[i].pipe_idx);
-					mpcc_disconnected = true;
-				}
-			}
-		}
-
-		if (mpcc_disconnected) {
-			for (i = 0; i < dc->res_pool->pipe_count; i++) {
-				struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-				struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
-				struct dc_plane_state *plane_state = pipe_ctx->plane_state;
-				struct hubp *hubp = pipe_ctx->plane_res.hubp;
-
-				if (!pipe_ctx || !plane_state || !pipe_ctx->stream)
-					continue;
-
-			// Only update scaler and viewport here if we lose a pipe split.
-			// This is to prevent half the screen from being black when we
-			// unlock after disconnecting MPCC.
-			if (!(old_pipe && !pipe_ctx->top_pipe &&
-				!pipe_ctx->bottom_pipe && old_pipe->bottom_pipe))
-				continue;
-
-			if (pipe_ctx->update_flags.raw || pipe_ctx->plane_state->update_flags.raw || pipe_ctx->stream->update_flags.raw) {
-				if (pipe_ctx->update_flags.bits.scaler ||
-					plane_state->update_flags.bits.scaling_change ||
-					plane_state->update_flags.bits.position_change ||
-					plane_state->update_flags.bits.per_pixel_alpha_change ||
-					pipe_ctx->stream->update_flags.bits.scaling) {
-
-					pipe_ctx->plane_res.scl_data.lb_params.alpha_en = pipe_ctx->plane_state->per_pixel_alpha;
-					ASSERT(pipe_ctx->plane_res.scl_data.lb_params.depth == LB_PIXEL_DEPTH_30BPP);
-					/* scaler configuration */
-					pipe_ctx->plane_res.dpp->funcs->dpp_set_scaler(
-					pipe_ctx->plane_res.dpp, &pipe_ctx->plane_res.scl_data);
-				}
-
-				if (pipe_ctx->update_flags.bits.viewport ||
-					(context == dc->current_state && plane_state->update_flags.bits.position_change) ||
-					(context == dc->current_state && plane_state->update_flags.bits.scaling_change) ||
-					(context == dc->current_state && pipe_ctx->stream->update_flags.bits.scaling)) {
-
-					hubp->funcs->mem_program_viewport(
-						hubp,
-						&pipe_ctx->plane_res.scl_data.viewport,
-						&pipe_ctx->plane_res.scl_data.viewport_c);
-				}
-			}
-		}
-	}
-	return mpcc_disconnected;
-}
-
-void dcn20_wait_for_pending_cleared(struct dc *dc,
-		struct dc_state *context)
-{
-		struct pipe_ctx *pipe_ctx;
-		struct timing_generator *tg;
-		int i;
-
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			pipe_ctx = &context->res_ctx.pipe_ctx[i];
-			tg = pipe_ctx->stream_res.tg;
-
-			/*
-			 * Only wait for top pipe's tg penindg bit
-			 * Also skip if pipe is disabled.
-			 */
-			if (pipe_ctx->top_pipe ||
-			    !pipe_ctx->stream || !pipe_ctx->plane_state ||
-			    !tg->funcs->is_tg_enabled(tg))
-				continue;
-
-			/*
-			 * Wait for VBLANK then VACTIVE to ensure we get VUPDATE.
-			 * For some reason waiting for OTG_UPDATE_PENDING cleared
-			 * seems to not trigger the update right away, and if we
-			 * lock again before VUPDATE then we don't get a separated
-			 * operation.
-			 */
-			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
-			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
-		}
-}
-
 void dcn20_program_front_end_for_ctx(
 		struct dc *dc,
 		struct dc_state *context)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
index 7befd35a2359..83220e34c1a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
@@ -131,13 +131,6 @@ void dcn20_dccg_init(struct dce_hwseq *hws);
 int dcn20_init_sys_ctx(struct dce_hwseq *hws,
 		struct dc *dc,
 		struct dc_phy_addr_space_config *pa_config);
-bool dcn20_disconnect_pipes(
-		struct dc *dc,
-		struct dc_state *context);
-
-void dcn20_wait_for_pending_cleared(struct dc *dc,
-		struct dc_state *context);
-                
 
 #ifndef TRIM_FSFT
 bool dcn20_optimize_timing_for_fsft(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index 55afb70d33e5..3dde6f26de47 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -34,8 +34,6 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
-	.disconnect_pipes = dcn20_disconnect_pipes,
-	.wait_for_pending_cleared = dcn20_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
 	.update_dchub = dcn10_update_dchub,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index 264302b27d4f..b187f71afa65 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -35,8 +35,6 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
-	.disconnect_pipes = dcn20_disconnect_pipes,
-	.wait_for_pending_cleared = dcn20_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
 	.update_dchub = dcn10_update_dchub,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index 845aaf1c816c..9afee7160490 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -35,8 +35,6 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
-	.disconnect_pipes = dcn20_disconnect_pipes,
-	.wait_for_pending_cleared = dcn20_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
 	.update_dchub = dcn10_update_dchub,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 64c1be818b0e..3c986717dcd5 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -67,10 +67,6 @@ struct hw_sequencer_funcs {
 			int num_planes, struct dc_state *context);
 	void (*program_front_end_for_ctx)(struct dc *dc,
 			struct dc_state *context);
-	bool (*disconnect_pipes)(struct dc *dc,
-			struct dc_state *context);
-	void (*wait_for_pending_cleared)(struct dc *dc,
-			struct dc_state *context);
 	void (*post_unlock_program_front_end)(struct dc *dc,
 			struct dc_state *context);
 	void (*update_plane_addr)(const struct dc *dc,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=KaZi=BP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFAFC433DF
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 17:41:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 848B8206B6
	for <amd-gfx@archiver.kernel.org>; Wed,  5 Aug 2020 17:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="Qe8PIqtQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 848B8206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46B6F6E834;
	Wed,  5 Aug 2020 17:41:17 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2052.outbound.protection.outlook.com [40.107.223.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1717B6E833
 for <amd-gfx@lists.freedesktop.org>; Wed,  5 Aug 2020 17:41:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h3rYDXen4OIaZ0+wPzsWzr5cJO3hdFlZsa8Qs790m19LPTtlZMSIQWT+GPYJwSzrN0D8nDgoXj1wPkvyBGE5ztl5iQ2+MAtnj2yZd4TIkCY1dZsMmcy05W+HaC4Mc7tIUp5O4mVObQ+O/ZwWtaD80JTZNGC8vLCKQYBcjbyBncnnSqyoYuaErfflizhtKg3ljibCRKWc4j9DCCiYR4FSES3NHowXX8P17CMMtK0P8CQXyh0BC12a+EfjXqO033ZU3RCrFbk6mDEwY0jEcIHvZ0VsKAr85NUZzetOSkjahH6Ezt2xfieD7pl//vHP5e8jORjBtKoUxwEG6xia3Wa/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sf+bv1EYHQja9KhPmF6S3Y5XDEzOPf+/sX9oAauuQpA=;
 b=hSdbCbSFdictwJsDrfct4OabHFZ6lP7K0/ocYjr/YG6d341jnOflVGCSdUl+C5GKLGAe7tHfLAirha2AOBilYz572lCkVcRETQl7jqr18c6N+GX9ZORmKarY9EmIcAlZwt0JQ2kFzACMcTKb8CiL8tgOcMsmFymhaWKxUqTBNmbKwe5SwyGJ3puAHhKxok7CO4RDiEAVzUjEmrXGWd+0YQHY/SgUZ+KLJqSBf0pKWsZIgCUDEHjEEp3vKeIuHSJpYOKOH+uRir6gq5iSnbiP3mM9cSSJsEcUdJ2LLyjBHWInHw+k3TCeHAQ3EVOvyit//uwpBE4q6RQob4On7dPZAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sf+bv1EYHQja9KhPmF6S3Y5XDEzOPf+/sX9oAauuQpA=;
 b=Qe8PIqtQjFKtxGJDDcG35PAeVrsyafg5Bgq9ZxFkFiujlWHs14pZBtj9QMDoEf+1sNfW3CbdkzcrVh3LDNYcz1Xez7BOD3yxcXpuaBY2lhl2fLZ19u/jOtM9kF40EMaBs6m9XE5Iuzy0OOwyYa4xAbCSaO7jC8Js6EtFAHFSKUE=
Received: from CO1PR15CA0085.namprd15.prod.outlook.com (2603:10b6:101:20::29)
 by CY4PR12MB1845.namprd12.prod.outlook.com (2603:10b6:903:126::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17; Wed, 5 Aug
 2020 17:41:09 +0000
Received: from CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:101:20:cafe::ed) by CO1PR15CA0085.outlook.office365.com
 (2603:10b6:101:20::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Wed, 5 Aug 2020 17:41:09 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT068.mail.protection.outlook.com (10.13.175.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3261.16 via Frontend Transport; Wed, 5 Aug 2020 17:41:09 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Wed, 5 Aug 2020
 12:41:03 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Wed, 5 Aug 2020 12:41:03 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 7/9] drm/amd/display: Disconnect pipe separetely when disable
 pipe split
Date: Wed, 5 Aug 2020 13:40:56 -0400
Message-ID: <20200805174058.11736-8-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200805174058.11736-1-qingqing.zhuo@amd.com>
References: <20200805174058.11736-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 00305439-1fb7-4fb7-626f-08d83966bd04
X-MS-TrafficTypeDiagnostic: CY4PR12MB1845:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <CY4PR12MB184516B0F45C2B8C2EE93C23FB4B0@CY4PR12MB1845.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1148;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MGy5+bLwI7MpVvrUqr9sUF/FS+I+K2sg4NTsPHWmtdjK7CsOVuPnHVEx8wrJL4Wc5zADwL4aLBh/5s69Cgrfef/cV95v8j3Gfs8S8qArp7JKX2Lqu2tCmv2t5ubnoyV7Q6NFBoT7JUHBoFsjSgT1jdoqh4HixFFG3JLjWE1o7XA7Fs3mbLO9S+pHs57FfBoIz+TqHBv22X/SlW61UqKpl2zXByTlzKTZFVpqR3fugAQskYLNjo1Y+IjlkfIRxFSKzqzB2mNWqfmFVHzM/L2mS/5NnvPmDKHffxC1th6qWrwxqN6pB3GrZOmeW6JUGP8jC81p38Xcxpp815w8s0qQIfgQH/O95QZqi5URJam1l8ghbSaqzA6PHZtO3p13GmtXI5XYzcx1b9ns9rBFQ0D1bw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39860400002)(376002)(136003)(346002)(396003)(46966005)(44832011)(5660300002)(6666004)(316002)(30864003)(70586007)(70206006)(2906002)(6916009)(4326008)(86362001)(2616005)(54906003)(1076003)(336012)(426003)(478600001)(8936002)(8676002)(36756003)(82310400002)(82740400003)(81166007)(47076004)(356005)(83380400001)(26005)(186003);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 17:41:09.1924 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 00305439-1fb7-4fb7-626f-08d83966bd04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1845
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
When changing pixel formats for HDR (e.g. ARGB -> FP16)
there are configurations that change from 2 pipes to 1 pipe.
In these cases, it seems that disconnecting MPCC and doing
a surface update at the same time(after unlocking) causes
some registers to be updated slightly faster than others
after unlocking (e.g. if the pixel format is updated to FP16
before the new surface address is programmed, we get
corruption on the screen because the pixel formats aren't
matching). We separate disconnecting MPCC from the rest
of  the  pipe programming sequence to prevent this.

[How]
Move MPCC disconnect into separate operation than the
rest of the pipe programming.

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  10 ++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 146 ++++++++++++++++++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   6 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   2 +
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   2 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   2 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   2 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   4 +
 8 files changed, 174 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5aa3b89471c3..ebbb8182228d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2300,6 +2300,7 @@ static void commit_planes_for_stream(struct dc *dc,
 		enum surface_update_type update_type,
 		struct dc_state *context)
 {
+	bool mpcc_disconnected = false;
 	int i, j;
 	struct pipe_ctx *top_pipe_to_program = NULL;
 
@@ -2330,6 +2331,15 @@ static void commit_planes_for_stream(struct dc *dc,
 		context_clock_trace(dc, context);
 	}
 
+	if (update_type != UPDATE_TYPE_FAST && dc->hwss.interdependent_update_lock &&
+		dc->hwss.disconnect_pipes && dc->hwss.wait_for_pending_cleared){
+		dc->hwss.interdependent_update_lock(dc, context, true);
+		mpcc_disconnected = dc->hwss.disconnect_pipes(dc, context);
+		dc->hwss.interdependent_update_lock(dc, context, false);
+		if (mpcc_disconnected)
+			dc->hwss.wait_for_pending_cleared(dc, context);
+	}
+
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 57cd52789606..95e9d05f884b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2752,6 +2752,152 @@ static struct pipe_ctx *dcn10_find_top_pipe_for_stream(
 	return NULL;
 }
 
+bool dcn10_disconnect_pipes(
+		struct dc *dc,
+		struct dc_state *context)
+{
+		bool found_stream = false;
+		int i, j;
+		struct dce_hwseq *hws = dc->hwseq;
+		struct dc_state *old_ctx = dc->current_state;
+		bool mpcc_disconnected = false;
+		struct pipe_ctx *old_pipe;
+		struct pipe_ctx *new_pipe;
+		DC_LOGGER_INIT(dc->ctx->logger);
+
+		/* Set pipe update flags and lock pipes */
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+			new_pipe = &context->res_ctx.pipe_ctx[i];
+			new_pipe->update_flags.raw = 0;
+
+			if (!old_pipe->plane_state && !new_pipe->plane_state)
+				continue;
+
+			if (old_pipe->plane_state && !new_pipe->plane_state)
+				new_pipe->update_flags.bits.disable = 1;
+
+			/* Check for scl update */
+			if (memcmp(&old_pipe->plane_res.scl_data, &new_pipe->plane_res.scl_data, sizeof(struct scaler_data)))
+					new_pipe->update_flags.bits.scaler = 1;
+
+			/* Check for vp update */
+			if (memcmp(&old_pipe->plane_res.scl_data.viewport, &new_pipe->plane_res.scl_data.viewport, sizeof(struct rect))
+					|| memcmp(&old_pipe->plane_res.scl_data.viewport_c,
+						&new_pipe->plane_res.scl_data.viewport_c, sizeof(struct rect)))
+				new_pipe->update_flags.bits.viewport = 1;
+
+		}
+
+		if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
+			/* Disconnect mpcc here only if losing pipe split*/
+			for (i = 0; i < dc->res_pool->pipe_count; i++) {
+				if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable &&
+					old_ctx->res_ctx.pipe_ctx[i].top_pipe) {
+
+					/* Find the top pipe in the new ctx for the bottom pipe that we
+					 * want to remove by comparing the streams. If both pipes are being
+					 * disabled then do it in the regular pipe programming sequence
+					 */
+					for (j = 0; j < dc->res_pool->pipe_count; j++) {
+						if (old_ctx->res_ctx.pipe_ctx[i].top_pipe->stream == context->res_ctx.pipe_ctx[j].stream &&
+							!context->res_ctx.pipe_ctx[j].top_pipe &&
+							!context->res_ctx.pipe_ctx[j].update_flags.bits.disable) {
+							found_stream = true;
+							break;
+						}
+					}
+
+					// Disconnect if the top pipe lost it's pipe split
+					if (found_stream && !context->res_ctx.pipe_ctx[j].bottom_pipe) {
+						hws->funcs.plane_atomic_disconnect(dc, &dc->current_state->res_ctx.pipe_ctx[i]);
+						DC_LOG_DC("Reset mpcc for pipe %d\n", dc->current_state->res_ctx.pipe_ctx[i].pipe_idx);
+						mpcc_disconnected = true;
+					}
+				}
+				found_stream = false;
+			}
+		}
+
+		if (mpcc_disconnected) {
+			for (i = 0; i < dc->res_pool->pipe_count; i++) {
+				struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+				struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+				struct dc_plane_state *plane_state = pipe_ctx->plane_state;
+				struct hubp *hubp = pipe_ctx->plane_res.hubp;
+
+				if (!pipe_ctx || !plane_state || !pipe_ctx->stream)
+					continue;
+
+				// Only update scaler and viewport here if we lose a pipe split.
+				// This is to prevent half the screen from being black when we
+				// unlock after disconnecting MPCC.
+				if (!(old_pipe && !pipe_ctx->top_pipe &&
+					!pipe_ctx->bottom_pipe && old_pipe->bottom_pipe))
+					continue;
+
+				if (pipe_ctx->update_flags.raw || pipe_ctx->plane_state->update_flags.raw || pipe_ctx->stream->update_flags.raw) {
+					if (pipe_ctx->update_flags.bits.scaler ||
+						plane_state->update_flags.bits.scaling_change ||
+						plane_state->update_flags.bits.position_change ||
+						plane_state->update_flags.bits.per_pixel_alpha_change ||
+						pipe_ctx->stream->update_flags.bits.scaling) {
+
+						pipe_ctx->plane_res.scl_data.lb_params.alpha_en = pipe_ctx->plane_state->per_pixel_alpha;
+						ASSERT(pipe_ctx->plane_res.scl_data.lb_params.depth == LB_PIXEL_DEPTH_30BPP);
+						/* scaler configuration */
+						pipe_ctx->plane_res.dpp->funcs->dpp_set_scaler(
+						pipe_ctx->plane_res.dpp, &pipe_ctx->plane_res.scl_data);
+					}
+
+					if (pipe_ctx->update_flags.bits.viewport ||
+						(context == dc->current_state && plane_state->update_flags.bits.position_change) ||
+						(context == dc->current_state && plane_state->update_flags.bits.scaling_change) ||
+						(context == dc->current_state && pipe_ctx->stream->update_flags.bits.scaling)) {
+
+						hubp->funcs->mem_program_viewport(
+							hubp,
+							&pipe_ctx->plane_res.scl_data.viewport,
+							&pipe_ctx->plane_res.scl_data.viewport_c);
+					}
+				}
+			}
+		}
+	return mpcc_disconnected;
+}
+
+void dcn10_wait_for_pending_cleared(struct dc *dc,
+		struct dc_state *context)
+{
+		struct pipe_ctx *pipe_ctx;
+		struct timing_generator *tg;
+		int i;
+
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			pipe_ctx = &context->res_ctx.pipe_ctx[i];
+			tg = pipe_ctx->stream_res.tg;
+
+			/*
+			 * Only wait for top pipe's tg penindg bit
+			 * Also skip if pipe is disabled.
+			 */
+			if (pipe_ctx->top_pipe ||
+			    !pipe_ctx->stream || !pipe_ctx->plane_state ||
+			    !tg->funcs->is_tg_enabled(tg))
+				continue;
+
+			/*
+			 * Wait for VBLANK then VACTIVE to ensure we get VUPDATE.
+			 * For some reason waiting for OTG_UPDATE_PENDING cleared
+			 * seems to not trigger the update right away, and if we
+			 * lock again before VUPDATE then we don't get a separated
+			 * operation.
+			 */
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
+		}
+}
+
 void dcn10_apply_ctx_for_surface(
 		struct dc *dc,
 		const struct dc_stream_state *stream,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
index 6d891166da8a..e5691e499023 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
@@ -194,6 +194,12 @@ void dcn10_get_surface_visual_confirm_color(
 void dcn10_get_hdr_visual_confirm_color(
 		struct pipe_ctx *pipe_ctx,
 		struct tg_color *color);
+bool dcn10_disconnect_pipes(
+		struct dc *dc,
+		struct dc_state *context);
+
+void dcn10_wait_for_pending_cleared(struct dc *dc,
+		struct dc_state *context);
 void dcn10_set_hdr_multiplier(struct pipe_ctx *pipe_ctx);
 void dcn10_verify_allow_pstate_change_high(struct dc *dc);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
index 5c98b71c1d47..a1d1559bb5d7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
@@ -34,6 +34,8 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = dcn10_apply_ctx_for_surface,
 	.post_unlock_program_front_end = dcn10_post_unlock_program_front_end,
+	.disconnect_pipes = dcn10_disconnect_pipes,
+	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.update_plane_addr = dcn10_update_plane_addr,
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index 3dde6f26de47..966e1790b9bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -34,6 +34,8 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
+	.disconnect_pipes = dcn10_disconnect_pipes,
+	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
 	.update_dchub = dcn10_update_dchub,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index b187f71afa65..2ba880c3943c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -35,6 +35,8 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
+	.disconnect_pipes = dcn10_disconnect_pipes,
+	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
 	.update_dchub = dcn10_update_dchub,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index 9afee7160490..19daa456e3bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -35,6 +35,8 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
+	.disconnect_pipes = dcn10_disconnect_pipes,
+	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
 	.update_dchub = dcn10_update_dchub,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 3c986717dcd5..64c1be818b0e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -67,6 +67,10 @@ struct hw_sequencer_funcs {
 			int num_planes, struct dc_state *context);
 	void (*program_front_end_for_ctx)(struct dc *dc,
 			struct dc_state *context);
+	bool (*disconnect_pipes)(struct dc *dc,
+			struct dc_state *context);
+	void (*wait_for_pending_cleared)(struct dc *dc,
+			struct dc_state *context);
 	void (*post_unlock_program_front_end)(struct dc *dc,
 			struct dc_state *context);
 	void (*update_plane_addr)(const struct dc *dc,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

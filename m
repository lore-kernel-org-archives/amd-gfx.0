Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660CAC56202
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F10112224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="urjYgm0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F10112224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C0646EDD2;
	Wed, 21 Oct 2020 14:23:26 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2052.outbound.protection.outlook.com [40.107.93.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A69416EDCA
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BxjdH4qKvTdZpwUophg054Qt9z2C91/5fXG/73lrMHKxvwCyoIUwXzIpD4RyqTeHVYiOUXu9jC+Z8khdlVc60UDmoZ1PNsYLomy0glcQpO/szuZbDxvMJaHeP9ENXj8eGzz162oCs95Qe2JFdi46lpgdmc8oITXf8xq3MOOuJM+Vy8/x3ZdXRlPT2VR/j0W0WDi6xIxZBqNfCX95bJ7TDHKV22DpJcLL0RY5nQyAEUfFxTAvLjRZzBvr05wbCqdFZJFMD6U918CkfQAxZyjmUWklT7/bgp5svyXFr3bZ8o1iHk/sUOIHg9pJcXaLYGjl0VCIjPqDYK5enJsmLF9w3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBnnPpVZnfWfYivhpbKndliW0/NcgZLGKv1Yz7R/wwI=;
 b=X2RxwOePA/JIl+/m+ZJM4d35bbauS8FrrD0XoQt32ZoB3zSmnRm1YZHzz5TZ2rBO9/sJdh9ErBBXTNXYup6FBfhbQc5VOasuLf/bA1/8msIX2yx3Xref5VqsYNgYj5wpSN1jGFCaLYj3DKa+3LgBf3u8thBt/PHqsmcq1irzFKwsrdYiIEqcvhHk6pYhLRBwNNbarYlaP8+pfjR4WXNkwsFo+be1Fl74REDAnA2ouDNQoeeQGMxefF+ahMBXaot2L7hCikIu+CTc/KRg3Td5JOiIE5qm4MBur1zkZoVRehzGJkH96ML3RPGTAXf8fK57zZoMAsO4S7c0FTK5hpc46w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBnnPpVZnfWfYivhpbKndliW0/NcgZLGKv1Yz7R/wwI=;
 b=urjYgm0FiW8WWtGQFM5+Ue4G2l4PSDvk1Htrz6dYBhpw8ZzIiq8LufxbYg4QI/7syPfnNrBDntBpByDVvjmz4Xfe3QUnr3kdXQJZe/bLFe1fSMBsf7VnqmJWfRe8UBgqC93VleMatHKuQQv8ojROt+AKgcd0lIMKND2C6P+1Rnk=
Received: from DM5PR12CA0019.namprd12.prod.outlook.com (2603:10b6:4:1::29) by
 BY5PR12MB3860.namprd12.prod.outlook.com (2603:10b6:a03:1ac::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Wed, 21 Oct
 2020 14:23:20 +0000
Received: from DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::72) by DM5PR12CA0019.outlook.office365.com
 (2603:10b6:4:1::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:20 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT041.mail.protection.outlook.com (10.13.172.98) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:20 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:19 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:18 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 19/33] drm/amd/display: Update GSL state if leaving immediate
 flip
Date: Wed, 21 Oct 2020 10:22:43 -0400
Message-ID: <20201021142257.190969-20-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8aa7d430-4065-4fae-1758-08d875ccdc55
X-MS-TrafficTypeDiagnostic: BY5PR12MB3860:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR12MB38601CD6BE8A19BCD04F71208B1C0@BY5PR12MB3860.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:556;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4xQMHEKxTplXqOkCrF5SMkccfYwpea0O8/bKzl+jCogIXDcsm26nnZvci0nQbmDEoTmZ8FL8uv74W5zVAd1aKeq+S+xu2HsQXUk9YdOEyVK5OWmW0HTMDUmV412f+HtZmQM+H9PZUH7wvapfU1/E60gF1F/q0gvuXYM8UXXdEXs2gjkk+K2wLHsa73frveRPaKzn2dYK/a3l5AsLbBZDATk9EflKmzPbNXoKlyAkiZizG5sKhmNWE75UUJdfBDUpoDVUjc/doiOcKI48N+KhnWN/33YCy6N7c/kwwpXh0L5Xku8LifaB8NYZ4HBdebTCe/aieqU7LsWVtHz9AUNhbhRiggen9XzpfUYW7eH4n+IGT5nkAaR9qPWBHEukGyrXz5r+CkFyCCtVFwBRD6rQpkxZ13SJh7yQg/I1/HLjvrU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(396003)(39860400002)(136003)(376002)(46966005)(2906002)(4326008)(426003)(44832011)(36756003)(70586007)(6666004)(70206006)(15650500001)(336012)(86362001)(7696005)(5660300002)(30864003)(83380400001)(54906003)(82310400003)(82740400003)(316002)(8936002)(6916009)(2616005)(478600001)(26005)(186003)(8676002)(356005)(81166007)(1076003)(47076004)(14773001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:20.2327 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa7d430-4065-4fae-1758-08d875ccdc55
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT041.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3860
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
Cc: Aric Cyr <aric.cyr@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <alvin.lee2@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
We should leave GSL if we're not doing immediate flip no matter if
we're doing pipe split or not

[How]
Check for updating GSL state whenever we're not doing
immediate flip

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  11 --
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 116 ------------------
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   1 -
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   2 +-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   1 -
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   1 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   1 -
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   2 -
 8 files changed, 1 insertion(+), 134 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 21423ebc9c04..f188af1b310a 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2380,7 +2380,6 @@ static void commit_planes_for_stream(struct dc *dc,
 		enum surface_update_type update_type,
 		struct dc_state *context)
 {
-	bool mpcc_disconnected = false;
 	int i, j;
 	struct pipe_ctx *top_pipe_to_program = NULL;
 
@@ -2411,15 +2410,6 @@ static void commit_planes_for_stream(struct dc *dc,
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
 
@@ -2458,7 +2448,6 @@ static void commit_planes_for_stream(struct dc *dc,
 		 */
 		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, true);
 
-
 	// Stream updates
 	if (stream_update)
 		commit_planes_do_stream_update(dc, stream, stream_update, update_type, context);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index b7046d8eb114..08227f0d13f2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2775,122 +2775,6 @@ static struct pipe_ctx *dcn10_find_top_pipe_for_stream(
 	return NULL;
 }
 
-bool dcn10_disconnect_pipes(
-		struct dc *dc,
-		struct dc_state *context)
-{
-		bool found_pipe = false;
-		int i, j;
-		struct dce_hwseq *hws = dc->hwseq;
-		struct dc_state *old_ctx = dc->current_state;
-		bool mpcc_disconnected = false;
-		struct pipe_ctx *old_pipe;
-		struct pipe_ctx *new_pipe;
-		DC_LOGGER_INIT(dc->ctx->logger);
-
-		/* Set pipe update flags and lock pipes */
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
-			new_pipe = &context->res_ctx.pipe_ctx[i];
-			new_pipe->update_flags.raw = 0;
-
-			if (!old_pipe->plane_state && !new_pipe->plane_state)
-				continue;
-
-			if (old_pipe->plane_state && !new_pipe->plane_state)
-				new_pipe->update_flags.bits.disable = 1;
-
-			/* Check for scl update */
-			if (memcmp(&old_pipe->plane_res.scl_data, &new_pipe->plane_res.scl_data, sizeof(struct scaler_data)))
-					new_pipe->update_flags.bits.scaler = 1;
-
-			/* Check for vp update */
-			if (memcmp(&old_pipe->plane_res.scl_data.viewport, &new_pipe->plane_res.scl_data.viewport, sizeof(struct rect))
-					|| memcmp(&old_pipe->plane_res.scl_data.viewport_c,
-						&new_pipe->plane_res.scl_data.viewport_c, sizeof(struct rect)))
-				new_pipe->update_flags.bits.viewport = 1;
-
-		}
-
-		if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
-			/* Disconnect mpcc here only if losing pipe split*/
-			for (i = 0; i < dc->res_pool->pipe_count; i++) {
-				if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable &&
-					old_ctx->res_ctx.pipe_ctx[i].top_pipe) {
-
-					/* Find the top pipe in the new ctx for the bottom pipe that we
-					 * want to remove by comparing the streams and planes. If both
-					 * pipes are being disabled then do it in the regular pipe
-					 * programming sequence
-					 */
-					for (j = 0; j < dc->res_pool->pipe_count; j++) {
-						if (old_ctx->res_ctx.pipe_ctx[i].top_pipe->stream == context->res_ctx.pipe_ctx[j].stream &&
-							old_ctx->res_ctx.pipe_ctx[i].top_pipe->plane_state == context->res_ctx.pipe_ctx[j].plane_state &&
-							!context->res_ctx.pipe_ctx[j].top_pipe &&
-							!context->res_ctx.pipe_ctx[j].update_flags.bits.disable) {
-							found_pipe = true;
-							break;
-						}
-					}
-
-					// Disconnect if the top pipe lost it's pipe split
-					if (found_pipe && !context->res_ctx.pipe_ctx[j].bottom_pipe) {
-						hws->funcs.plane_atomic_disconnect(dc, &dc->current_state->res_ctx.pipe_ctx[i]);
-						DC_LOG_DC("Reset mpcc for pipe %d\n", dc->current_state->res_ctx.pipe_ctx[i].pipe_idx);
-						mpcc_disconnected = true;
-					}
-				}
-				found_pipe = false;
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
-				// Only update scaler and viewport here if we lose a pipe split.
-				// This is to prevent half the screen from being black when we
-				// unlock after disconnecting MPCC.
-				if (!(old_pipe && !pipe_ctx->top_pipe &&
-					!pipe_ctx->bottom_pipe && old_pipe->bottom_pipe))
-					continue;
-
-				if (pipe_ctx->update_flags.raw || pipe_ctx->plane_state->update_flags.raw || pipe_ctx->stream->update_flags.raw) {
-					if (pipe_ctx->update_flags.bits.scaler ||
-						plane_state->update_flags.bits.scaling_change ||
-						plane_state->update_flags.bits.position_change ||
-						plane_state->update_flags.bits.per_pixel_alpha_change ||
-						pipe_ctx->stream->update_flags.bits.scaling) {
-
-						pipe_ctx->plane_res.scl_data.lb_params.alpha_en = pipe_ctx->plane_state->per_pixel_alpha;
-						ASSERT(pipe_ctx->plane_res.scl_data.lb_params.depth == LB_PIXEL_DEPTH_30BPP);
-						/* scaler configuration */
-						pipe_ctx->plane_res.dpp->funcs->dpp_set_scaler(
-						pipe_ctx->plane_res.dpp, &pipe_ctx->plane_res.scl_data);
-					}
-
-					if (pipe_ctx->update_flags.bits.viewport ||
-						(context == dc->current_state && plane_state->update_flags.bits.position_change) ||
-						(context == dc->current_state && plane_state->update_flags.bits.scaling_change) ||
-						(context == dc->current_state && pipe_ctx->stream->update_flags.bits.scaling)) {
-
-						hubp->funcs->mem_program_viewport(
-							hubp,
-							&pipe_ctx->plane_res.scl_data.viewport,
-							&pipe_ctx->plane_res.scl_data.viewport_c);
-					}
-				}
-			}
-		}
-	return mpcc_disconnected;
-}
-
 void dcn10_wait_for_pending_cleared(struct dc *dc,
 		struct dc_state *context)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
index b24c8ae8b1ec..254300b06b43 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
@@ -34,7 +34,6 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = dcn10_apply_ctx_for_surface,
 	.post_unlock_program_front_end = dcn10_post_unlock_program_front_end,
-	.disconnect_pipes = dcn10_disconnect_pipes,
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.update_plane_addr = dcn10_update_plane_addr,
 	.update_dchub = dcn10_update_dchub,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 04b939f3cdcc..71499c131947 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1191,7 +1191,7 @@ void dcn20_pipe_control_lock(
 	/* In flip immediate and pipe splitting case, we need to use GSL
 	 * for synchronization. Only do setup on locking and on flip type change.
 	 */
-	if (lock && pipe->bottom_pipe != NULL)
+	if (lock && (pipe->bottom_pipe != NULL || !flip_immediate))
 		if ((flip_immediate && pipe->stream_res.gsl_group == 0) ||
 		    (!flip_immediate && pipe->stream_res.gsl_group > 0))
 			dcn20_setup_gsl_group_as_lock(dc, pipe, flip_immediate);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index 072193c5ffe6..f4bc2a44f806 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -34,7 +34,6 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
-	.disconnect_pipes = dcn10_disconnect_pipes,
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index 4ab29911508d..3e3eca1778cb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -35,7 +35,6 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
-	.disconnect_pipes = dcn10_disconnect_pipes,
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index ba247571fed1..b829cb116916 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -35,7 +35,6 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
-	.disconnect_pipes = dcn10_disconnect_pipes,
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index fa3005c2e37e..f728928cda5a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -70,8 +70,6 @@ struct hw_sequencer_funcs {
 			int num_planes, struct dc_state *context);
 	void (*program_front_end_for_ctx)(struct dc *dc,
 			struct dc_state *context);
-	bool (*disconnect_pipes)(struct dc *dc,
-			struct dc_state *context);
 	void (*wait_for_pending_cleared)(struct dc *dc,
 			struct dc_state *context);
 	void (*post_unlock_program_front_end)(struct dc *dc,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D7BC369DC
	for <amd-gfx@archiver.kernel.org>; Sun,  4 May 2025 22:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A10B010E0A7;
	Sun,  4 May 2025 22:12:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="WW8TM61K";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDB6710E0A7
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 May 2025 22:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oPraoCrItN5nK7ZuC0um7aiU01NY86Im/ONrnVcrQa0=; b=WW8TM61KTZOKcqDCnrakijT2X6
 p8A0n+ScaX9mGH0CssgSTK2nEbpy7HEWmPBujY8OmI/jUj/16lySCEpVF+KEwgppqxbg0TqymLcNo
 5zzbqgKw495+DYBh1Xc2OxeQumwIgma3MvJaDAODcfZVO5uuFlT0dAAdlzoUMPcytOywE2zy/PRaW
 ypmBF9GVDSyZk0Rhq9MQHQsEHax7b2aHDdpjXf3hN1DsJZcJnkugikEEoFKC+KhuWVPRX9lIECuVb
 D0M8oLK7wLxojNmQ2KIvozRN5ILtUBITy8YYv0TVzoWogo5ylAuOvQn3hEakkg62ccLooRJRge0yf
 4xpEGInw==;
Received: from [193.32.248.132] (helo=debian.lan)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1uBhWb-003Pr1-RS; Mon, 05 May 2025 00:12:25 +0200
From: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?=27Christian=20K=C3=B6nig=27?= <christian.koenig@amd.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Hung <alex.hung@amd.com>
Cc: amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 4/4] drm/amd/display: Replace dcn35_update_odm with
 dcn314_update_odm
Date: Sun,  4 May 2025 16:11:31 -0600
Message-ID: <20250504221154.409695-5-siqueira@igalia.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250504221154.409695-1-siqueira@igalia.com>
References: <20250504221154.409695-1-siqueira@igalia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

dcn35_update_odm has the same implementation as dcn314_update_odm. This
commit removes the duplicate implementation by using dcn314_update_odm
in the DCN35 code.

Signed-off-by: Rodrigo Siqueira <siqueira@igalia.com>
---
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 52 -------------------
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |  2 -
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |  2 +-
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |  3 +-
 4 files changed, 3 insertions(+), 56 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 922b8d71cf1a..abcbd1759465 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -420,58 +420,6 @@ static unsigned int get_odm_config(struct pipe_ctx *pipe_ctx, unsigned int *opp_
 	return opp_count;
 }
 
-void dcn35_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *pipe_ctx)
-{
-	struct pipe_ctx *odm_pipe;
-	int opp_cnt = 0;
-	int opp_inst[MAX_PIPES] = {0};
-	int odm_slice_width = resource_get_odm_slice_dst_width(pipe_ctx, false);
-	int last_odm_slice_width = resource_get_odm_slice_dst_width(pipe_ctx, true);
-	struct mpc *mpc = dc->res_pool->mpc;
-	int i;
-
-	opp_cnt = get_odm_config(pipe_ctx, opp_inst);
-
-	if (opp_cnt > 1)
-		pipe_ctx->stream_res.tg->funcs->set_odm_combine(
-				pipe_ctx->stream_res.tg,
-				opp_inst, opp_cnt,
-				odm_slice_width, last_odm_slice_width);
-	else
-		pipe_ctx->stream_res.tg->funcs->set_odm_bypass(
-				pipe_ctx->stream_res.tg, &pipe_ctx->stream->timing);
-
-	if (mpc->funcs->set_out_rate_control) {
-		for (i = 0; i < opp_cnt; ++i) {
-			mpc->funcs->set_out_rate_control(
-					mpc, opp_inst[i],
-					false,
-					0,
-					NULL);
-		}
-	}
-
-	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
-		odm_pipe->stream_res.opp->funcs->opp_pipe_clock_control(
-				odm_pipe->stream_res.opp,
-				true);
-	}
-
-	if (pipe_ctx->stream_res.dsc) {
-		struct pipe_ctx *current_pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[pipe_ctx->pipe_idx];
-
-		update_dsc_on_stream(pipe_ctx, pipe_ctx->stream->timing.flags.DSC);
-
-		/* Check if no longer using pipe for ODM, then need to disconnect DSC for that pipe */
-		if (!pipe_ctx->next_odm_pipe && current_pipe_ctx->next_odm_pipe &&
-				current_pipe_ctx->next_odm_pipe->stream_res.dsc) {
-			struct display_stream_compressor *dsc = current_pipe_ctx->next_odm_pipe->stream_res.dsc;
-			/* disconnect DSC block from stream */
-			dsc->funcs->dsc_disconnect(dsc);
-		}
-	}
-}
-
 void dcn35_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool clock_on)
 {
 	if (!hws->ctx->dc->debug.root_clock_optimization.bits.dpp)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index 0b1d6f608edd..6ca6924e7379 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -31,8 +31,6 @@
 
 struct dc;
 
-void dcn35_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *pipe_ctx);
-
 void dcn35_dsc_pg_control(struct dce_hwseq *hws, unsigned int dsc_inst, bool power_on);
 
 void dcn35_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool clock_on);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index a3ccf805bd16..3a14c6374324 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -155,7 +155,7 @@ static const struct hwseq_private_funcs dcn35_private_funcs = {
 	.dpstream_root_clock_control = dcn35_dpstream_root_clock_control,
 	.physymclk_root_clock_control = dcn35_physymclk_root_clock_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
-	.update_odm = dcn35_update_odm,
+	.update_odm = dcn314_update_odm,
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
 	.verify_allow_pstate_change_high = dcn10_verify_allow_pstate_change_high,
 	.wait_for_blank_complete = dcn20_wait_for_blank_complete,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index 58f2be2a326b..24bd1bbf4461 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -30,6 +30,7 @@
 #include "dcn30/dcn30_hwseq.h"
 #include "dcn301/dcn301_hwseq.h"
 #include "dcn31/dcn31_hwseq.h"
+#include "dcn314/dcn314_hwseq.h"
 #include "dcn32/dcn32_hwseq.h"
 #include "dcn35/dcn35_hwseq.h"
 #include "dcn351/dcn351_hwseq.h"
@@ -150,7 +151,7 @@ static const struct hwseq_private_funcs dcn351_private_funcs = {
 	.dpstream_root_clock_control = dcn35_dpstream_root_clock_control,
 	.physymclk_root_clock_control = dcn35_physymclk_root_clock_control,
 	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
-	.update_odm = dcn35_update_odm,
+	.update_odm = dcn314_update_odm,
 	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
 	.verify_allow_pstate_change_high = dcn10_verify_allow_pstate_change_high,
 	.wait_for_blank_complete = dcn20_wait_for_blank_complete,
-- 
2.47.2


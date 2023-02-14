Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10A72C61DA4
	for <amd-gfx@archiver.kernel.org>; Tue, 14 Feb 2023 12:14:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 276E410E8AB;
	Tue, 14 Feb 2023 12:14:18 +0000 (UTC)
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2505010E89C
 for <amd-gfx@lists.freedesktop.org>; Tue, 14 Feb 2023 12:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eYSpjz7o38JdMJjHK2uieOmBHCjJl4/xRnrpLSURMcU=; b=eAx5m6zmV1XEb1hgp3aygmo08r
 8j1BtrKW/rWPyFQYCoeIuxnC0ro8htQ21UTP2yF//k1+v+MEwcGGDRxXuXrm88jR5pWjM7gWGnvyF
 iOmBscyXYny+b94IjQLa7vBu+Of9jr1ak9PFhrtCoqbmdevle68EaAVPaYypXXqUfkFz/e0n6v7G+
 RLzu+3ZW098Fo+CAR2InrzIzBPqeijw8KqtuF6ZPIq6GxkyIDmcjE64QYFxxZdsK4P5WeATbmJ4ph
 PJ08AxxK0HD5taI8l70VSqf1LWiI7Qrgg3fqqfLELd4DB6cgtjzBuVwN8LC3NqEdPDL/d4nZC3dQM
 cKhnvCjQ==;
Received: from [38.44.66.31] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1pRuCH-0022pF-Om; Tue, 14 Feb 2023 13:14:09 +0100
From: Melissa Wen <mwen@igalia.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/6] drm/amd/display: clean code-style issues in
 dcn30_set_mpc_shaper_3dlut
Date: Tue, 14 Feb 2023 11:14:02 -0100
Message-Id: <20230214121406.97750-3-mwen@igalia.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230214121406.97750-1-mwen@igalia.com>
References: <20230214121406.97750-1-mwen@igalia.com>
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
Cc: sunpeng.li@amd.com, Xinhui.Pan@amd.com, Rodrigo.Siqueira@amd.com,
 kernel-dev@igalia.com, alexander.deucher@amd.com, harry.wentland@amd.com,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This function has many conditions and all code style issues (identation,
missing braces, etc.) make reading it really annoying.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 37 ++++++++++---------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 9ce86f288130..df787fcf8e86 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -90,8 +90,8 @@ bool dcn30_set_blend_lut(
 	return result;
 }
 
-static bool dcn30_set_mpc_shaper_3dlut(
-	struct pipe_ctx *pipe_ctx, const struct dc_stream_state *stream)
+static bool dcn30_set_mpc_shaper_3dlut(struct pipe_ctx *pipe_ctx,
+				       const struct dc_stream_state *stream)
 {
 	struct dpp *dpp_base = pipe_ctx->plane_res.dpp;
 	int mpcc_id = pipe_ctx->plane_res.hubp->inst;
@@ -103,19 +103,18 @@ static bool dcn30_set_mpc_shaper_3dlut(
 	const struct pwl_params *shaper_lut = NULL;
 	//get the shaper lut params
 	if (stream->func_shaper) {
-		if (stream->func_shaper->type == TF_TYPE_HWPWL)
+		if (stream->func_shaper->type == TF_TYPE_HWPWL) {
 			shaper_lut = &stream->func_shaper->pwl;
-		else if (stream->func_shaper->type == TF_TYPE_DISTRIBUTED_POINTS) {
-			cm_helper_translate_curve_to_hw_format(
-					stream->func_shaper,
-					&dpp_base->shaper_params, true);
+		} else if (stream->func_shaper->type == TF_TYPE_DISTRIBUTED_POINTS) {
+			cm_helper_translate_curve_to_hw_format(stream->func_shaper,
+							       &dpp_base->shaper_params, true);
 			shaper_lut = &dpp_base->shaper_params;
 		}
 	}
 
 	if (stream->lut3d_func &&
-		stream->lut3d_func->state.bits.initialized == 1 &&
-		stream->lut3d_func->state.bits.rmu_idx_valid == 1) {
+	    stream->lut3d_func->state.bits.initialized == 1 &&
+	    stream->lut3d_func->state.bits.rmu_idx_valid == 1) {
 		if (stream->lut3d_func->state.bits.rmu_mux_num == 0)
 			mpcc_id_projected = stream->lut3d_func->state.bits.mpc_rmu0_mux;
 		else if (stream->lut3d_func->state.bits.rmu_mux_num == 1)
@@ -124,20 +123,22 @@ static bool dcn30_set_mpc_shaper_3dlut(
 			mpcc_id_projected = stream->lut3d_func->state.bits.mpc_rmu2_mux;
 		if (mpcc_id_projected != mpcc_id)
 			BREAK_TO_DEBUGGER();
-		/*find the reason why logical layer assigned a differant mpcc_id into acquire_post_bldn_3dlut*/
+		/* find the reason why logical layer assigned a different
+		 * mpcc_id into acquire_post_bldn_3dlut
+		 */
 		acquired_rmu = mpc->funcs->acquire_rmu(mpc, mpcc_id,
-				stream->lut3d_func->state.bits.rmu_mux_num);
+						       stream->lut3d_func->state.bits.rmu_mux_num);
 		if (acquired_rmu != stream->lut3d_func->state.bits.rmu_mux_num)
 			BREAK_TO_DEBUGGER();
-		result = mpc->funcs->program_3dlut(mpc,
-								&stream->lut3d_func->lut_3d,
-								stream->lut3d_func->state.bits.rmu_mux_num);
+
+		result = mpc->funcs->program_3dlut(mpc, &stream->lut3d_func->lut_3d,
+						   stream->lut3d_func->state.bits.rmu_mux_num);
 		result = mpc->funcs->program_shaper(mpc, shaper_lut,
-				stream->lut3d_func->state.bits.rmu_mux_num);
-	} else
-		/*loop through the available mux and release the requested mpcc_id*/
+						    stream->lut3d_func->state.bits.rmu_mux_num);
+	} else {
+		// loop through the available mux and release the requested mpcc_id
 		mpc->funcs->release_rmu(mpc, mpcc_id);
-
+	}
 
 	return result;
 }
-- 
2.39.0


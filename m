Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63646C02181
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jan 2025 19:49:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10D2A10E47F;
	Mon, 20 Jan 2025 19:49:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IWoa6qEX";
	dkim-atps=neutral
Received: from nyc.source.kernel.org (nyc.source.kernel.org [147.75.193.91])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23A4310E47F
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jan 2025 19:49:23 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 55164A40077;
 Mon, 20 Jan 2025 19:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433ACC4CEDD;
 Mon, 20 Jan 2025 19:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1737402561;
 bh=qA99Y+YVFc4aLPmNowW+qfsgFGRsZCaCgY9NkDuikrs=;
 h=From:To:Cc:Subject:Date:From;
 b=IWoa6qEX0vF8r1t1M6vmlAlyTxQ02thrs5TpXI14P7W5tIkhTuq7B4VSp9IJeJ7Yw
 tM9JR8+05sn1Wad9JV3pR/kTvGpEcT9LvGeeCc5eKioYCdg2wYe4kErGQMXMu5GoTo
 2QeqseVQ4zHJknPtZgsWO8dGuGmvMRSKilKRoYscrTxonm2avT5M0fn6St646y09kf
 kNGYFoY2O2x6NDI34IOadY9cfzeDwB/3V9nyEo27K8Z6CrKITpXkkQ/6Ojj/XVfjha
 ft5NZZaar+QRI9V9O5HSsyIOrDdACg/HyARvhu3q2MsXLgEzKZ1SC7d053nih7hB3U
 kQJ5355/Pk4Iw==
From: Mario Limonciello <superm1@kernel.org>
To: Harry Wentland <Harry.Wentland@amd.com>,
 "amd-gfx @ lists . freedesktop . org" <amd-gfx@lists.freedesktop.org>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 1/4] drm/amd/display: Add debug messages for
 dc_validate_boot_timing()
Date: Mon, 20 Jan 2025 13:49:00 -0600
Message-ID: <20250120194903.1048811-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
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

From: Mario Limonciello <mario.limonciello@amd.com>

dc_validate_boot_timing() runs through an exhaustive list of checks to
determine whether a boot stream can be marked as seamless. When the
checks fail, a user will be left guessing what the reason was

Add debug statements that will be helpful to validate the specific
reason.

Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c | 114 +++++++++++++++++------
 1 file changed, 86 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2723558049d65..0df1d7b94eba6 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1650,17 +1650,23 @@ bool dc_validate_boot_timing(const struct dc *dc,
 		return false;
 	}
 
-	if (dc->debug.force_odm_combine)
+	if (dc->debug.force_odm_combine) {
+		DC_LOG_DEBUG("boot timing validation failed due to force_odm_combine\n");
 		return false;
+	}
 
 	/* Check for enabled DIG to identify enabled display */
-	if (!link->link_enc->funcs->is_dig_enabled(link->link_enc))
+	if (!link->link_enc->funcs->is_dig_enabled(link->link_enc)) {
+		DC_LOG_DEBUG("boot timing validation failed due to disabled DIG\n");
 		return false;
+	}
 
 	enc_inst = link->link_enc->funcs->get_dig_frontend(link->link_enc);
 
-	if (enc_inst == ENGINE_ID_UNKNOWN)
+	if (enc_inst == ENGINE_ID_UNKNOWN) {
+		DC_LOG_DEBUG("boot timing validation failed due to unknown DIG engine ID\n");
 		return false;
+	}
 
 	for (i = 0; i < dc->res_pool->stream_enc_count; i++) {
 		if (dc->res_pool->stream_enc[i]->id == enc_inst) {
@@ -1674,62 +1680,98 @@ bool dc_validate_boot_timing(const struct dc *dc,
 	}
 
 	// tg_inst not found
-	if (i == dc->res_pool->stream_enc_count)
+	if (i == dc->res_pool->stream_enc_count) {
+		DC_LOG_DEBUG("boot timing validation failed due to timing generator instance not found\n");
 		return false;
+	}
 
-	if (tg_inst >= dc->res_pool->timing_generator_count)
+	if (tg_inst >= dc->res_pool->timing_generator_count) {
+		DC_LOG_DEBUG("boot timing validation failed due to invalid timing generator count\n");
 		return false;
+	}
 
-	if (tg_inst != link->link_enc->preferred_engine)
+	if (tg_inst != link->link_enc->preferred_engine) {
+		DC_LOG_DEBUG("boot timing validation failed due to non-preferred timing generator\n");
 		return false;
+	}
 
 	tg = dc->res_pool->timing_generators[tg_inst];
 
-	if (!tg->funcs->get_hw_timing)
+	if (!tg->funcs->get_hw_timing) {
+		DC_LOG_DEBUG("boot timing validation failed due to missing get_hw_timing callback\n");
 		return false;
+	}
 
-	if (!tg->funcs->get_hw_timing(tg, &hw_crtc_timing))
+	if (!tg->funcs->get_hw_timing(tg, &hw_crtc_timing)) {
+		DC_LOG_DEBUG("boot timing validation failed due to failed get_hw_timing return\n");
 		return false;
+	}
 
-	if (crtc_timing->h_total != hw_crtc_timing.h_total)
+	if (crtc_timing->h_total != hw_crtc_timing.h_total) {
+		DC_LOG_DEBUG("boot timing validation failed due to h_total mismatch\n");
 		return false;
+	}
 
-	if (crtc_timing->h_border_left != hw_crtc_timing.h_border_left)
+	if (crtc_timing->h_border_left != hw_crtc_timing.h_border_left) {
+		DC_LOG_DEBUG("boot timing validation failed due to h_border_left mismatch\n");
 		return false;
+	}
 
-	if (crtc_timing->h_addressable != hw_crtc_timing.h_addressable)
+	if (crtc_timing->h_addressable != hw_crtc_timing.h_addressable) {
+		DC_LOG_DEBUG("boot timing validation failed due to h_addressable mismatch\n");
 		return false;
+	}
 
-	if (crtc_timing->h_border_right != hw_crtc_timing.h_border_right)
+	if (crtc_timing->h_border_right != hw_crtc_timing.h_border_right) {
+		DC_LOG_DEBUG("boot timing validation failed due to h_border_right mismatch\n");
 		return false;
+	}
 
-	if (crtc_timing->h_front_porch != hw_crtc_timing.h_front_porch)
+	if (crtc_timing->h_front_porch != hw_crtc_timing.h_front_porch) {
+		DC_LOG_DEBUG("boot timing validation failed due to h_front_porch mismatch\n");
 		return false;
+	}
 
-	if (crtc_timing->h_sync_width != hw_crtc_timing.h_sync_width)
+	if (crtc_timing->h_sync_width != hw_crtc_timing.h_sync_width) {
+		DC_LOG_DEBUG("boot timing validation failed due to h_sync_width mismatch\n");
 		return false;
+	}
 
-	if (crtc_timing->v_total != hw_crtc_timing.v_total)
+	if (crtc_timing->v_total != hw_crtc_timing.v_total) {
+		DC_LOG_DEBUG("boot timing validation failed due to v_total mismatch\n");
 		return false;
+	}
 
-	if (crtc_timing->v_border_top != hw_crtc_timing.v_border_top)
+	if (crtc_timing->v_border_top != hw_crtc_timing.v_border_top) {
+		DC_LOG_DEBUG("boot timing validation failed due to v_border_top mismatch\n");
 		return false;
+	}
 
-	if (crtc_timing->v_addressable != hw_crtc_timing.v_addressable)
+	if (crtc_timing->v_addressable != hw_crtc_timing.v_addressable) {
+		DC_LOG_DEBUG("boot timing validation failed due to v_addressable mismatch\n");
 		return false;
+	}
 
-	if (crtc_timing->v_border_bottom != hw_crtc_timing.v_border_bottom)
+	if (crtc_timing->v_border_bottom != hw_crtc_timing.v_border_bottom) {
+		DC_LOG_DEBUG("boot timing validation failed due to v_border_bottom mismatch\n");
 		return false;
+	}
 
-	if (crtc_timing->v_front_porch != hw_crtc_timing.v_front_porch)
+	if (crtc_timing->v_front_porch != hw_crtc_timing.v_front_porch) {
+		DC_LOG_DEBUG("boot timing validation failed due to v_front_porch mismatch\n");
 		return false;
+	}
 
-	if (crtc_timing->v_sync_width != hw_crtc_timing.v_sync_width)
+	if (crtc_timing->v_sync_width != hw_crtc_timing.v_sync_width) {
+		DC_LOG_DEBUG("boot timing validation failed due to v_sync_width mismatch\n");
 		return false;
+	}
 
 	/* block DSC for now, as VBIOS does not currently support DSC timings */
-	if (crtc_timing->flags.DSC)
+	if (crtc_timing->flags.DSC) {
+		DC_LOG_DEBUG("boot timing validation failed due to DSC\n");
 		return false;
+	}
 
 	if (dc_is_dp_signal(link->connector_signal)) {
 		unsigned int pix_clk_100hz = 0;
@@ -1751,39 +1793,55 @@ bool dc_validate_boot_timing(const struct dc *dc,
 		} else if (se && se->funcs->get_pixels_per_cycle) {
 			uint32_t pixels_per_cycle = se->funcs->get_pixels_per_cycle(se);
 
-			if (pixels_per_cycle != 1 && !dc->debug.enable_dp_dig_pixel_rate_div_policy)
+			if (pixels_per_cycle != 1 && !dc->debug.enable_dp_dig_pixel_rate_div_policy) {
+				pr_info("boot timing validation failed due to pixels_per_cycle\n");
 				return false;
+			}
 
 			pix_clk_100hz *= pixels_per_cycle;
 		}
 
 		// Note: In rare cases, HW pixclk may differ from crtc's pixclk
 		// slightly due to rounding issues in 10 kHz units.
-		if (crtc_timing->pix_clk_100hz != pix_clk_100hz)
+		if (crtc_timing->pix_clk_100hz != pix_clk_100hz) {
+			DC_LOG_DEBUG("boot timing validation failed due to pix_clk_100hz mismatch\n");
 			return false;
+		}
 
-		if (!se || !se->funcs->dp_get_pixel_format)
+		if (!se || !se->funcs->dp_get_pixel_format) {
+			DC_LOG_DEBUG("boot timing validation failed due to missing dp_get_pixel_format\n");
 			return false;
+		}
 
 		if (!se->funcs->dp_get_pixel_format(
 			se,
 			&hw_crtc_timing.pixel_encoding,
-			&hw_crtc_timing.display_color_depth))
+			&hw_crtc_timing.display_color_depth)) {
+			DC_LOG_DEBUG("boot timing validation failed due to dp_get_pixel_format failure\n");
 			return false;
+		}
 
-		if (hw_crtc_timing.display_color_depth != crtc_timing->display_color_depth)
+		if (hw_crtc_timing.display_color_depth != crtc_timing->display_color_depth) {
+			DC_LOG_DEBUG("boot timing validation failed due to display_color_depth mismatch\n");
 			return false;
+		}
 
-		if (hw_crtc_timing.pixel_encoding != crtc_timing->pixel_encoding)
+		if (hw_crtc_timing.pixel_encoding != crtc_timing->pixel_encoding) {
+			DC_LOG_DEBUG("boot timing validation failed due to pixel_encoding mismatch\n");
 			return false;
+		}
 	}
 
+
 	if (link->dpcd_caps.dprx_feature.bits.VSC_SDP_COLORIMETRY_SUPPORTED) {
+		DC_LOG_DEBUG("boot timing validation failed due to VSC SDP colorimetry\n");
 		return false;
 	}
 
-	if (link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED)
+	if (link->dpcd_caps.channel_coding_cap.bits.DP_128b_132b_SUPPORTED) {
+		DC_LOG_DEBUG("boot timing validation failed due to DP 128b/132b\n");
 		return false;
+	}
 
 	if (dc->link_srv->edp_is_ilr_optimization_required(link, crtc_timing)) {
 		DC_LOG_EVENT_LINK_TRAINING("Seamless boot disabled to optimize eDP link rate\n");
-- 
2.43.0


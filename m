Return-Path: <SRS0=xwQz=A3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 324E4C43459
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03B4020787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qun7go3U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03B4020787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F9656ECFF;
	Thu, 16 Jul 2020 21:23:37 +0000 (UTC)
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com
 [IPv6:2a00:1450:4864:20::442])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 349A66ECFB
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:32 +0000 (UTC)
Received: by mail-wr1-x442.google.com with SMTP id o11so8628607wrv.9
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T3KodtiSpmMJvjN8ChJXoDrmzGriUEjRbsU2pNIabpQ=;
 b=Qun7go3Uv9HH2m0VaCJ/iBj30P3RHBqDAtcGyHhAUNF7wdNXyMTDz5Ux6eNlNsbRQR
 43q+KuPg9/c+tCVQtzt0rkXmjX+XJgz+c3btn1OLqKq08lO6s7PPl/Va0mozqBQNnZuN
 5w1UTs9lZFKW42RJPZ+3VzD6x2MnO6kLA02WFsiJyJDGu/Eq0NxDrhziw8xmN4RYzagy
 FXhdMIVI5BWbjATq0R15VlBmedKvbALdtDzH95Cg1YVHBA9Mtip/3y11wYOgOlCrBe8e
 W0sk+U1105uuVyZtbjJLc13bwwQNgtzZhKf8ICrgs4xkMgk+1ZUjRf4LUCOwMZWHMTNA
 6qDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T3KodtiSpmMJvjN8ChJXoDrmzGriUEjRbsU2pNIabpQ=;
 b=ha958utRhRyoZK3bSq8bQVu5TJ/VpQi99xuJJuIOy7xlJz58b4K3dJ+2oq4pwJqyC6
 fmd4GsolOozNonUqBRlBG6swHbGaKjmQDUQRAV70ccjiWmIzLMm07Eh87y1jIaZVIvm1
 V27Vz0PsH9h5v5X5fyiiudmg6eaDVQUb4z8Pgw+k/BM+EA9alMzd+tVFWK3EuywDnCrd
 f1yGKFkJ7LuFkq6RrY1o8vKI2dYDrUZlfT4tHceKvP0UAQ06qgV7PbkcldpRNXaYEe4A
 AebVw50oSevt88qX9Zo/wMUpbWO7JABrJtZcdZHDsjFjAyuBgGSfYDmevKOIQ568qHxb
 Sl+g==
X-Gm-Message-State: AOAM530n19SzHrYRurvzAEgNQkpssLzKUiXCOEmKA78OSnLp8BsyHls8
 U7/o7LdxtVzCoWA2LKRm6R7GDnw2ScE=
X-Google-Smtp-Source: ABdhPJwagOOC4D07CQvcTDsU8GvbV22mEUueLHc6/Bqqkjydq1NSeROtqNlijW9mGg5ufxyULiNs3A==
X-Received: by 2002:adf:84e2:: with SMTP id 89mr7079471wrg.139.1594934610131; 
 Thu, 16 Jul 2020 14:23:30 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:29 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 21/27] drm/amd/display: dce60_hw_sequencer: add DCE6
 specific functions
Date: Thu, 16 Jul 2020 23:22:45 +0200
Message-Id: <20200716212251.1539094-22-issor.oruam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200716212251.1539094-1-issor.oruam@gmail.com>
References: <20200716212251.1539094-1-issor.oruam@gmail.com>
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, Mauro Rossi <issor.oruam@gmail.com>,
 harry.wentland@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why]
DCE6 has no bottom_pipe and no Blender HW
DCE6 needs 'blank_target' set to false in order to turn on the display
DCE6 has a specific dce60_pipe_control_lock() fuction that is a no op

[How]
Add DCE6 specific functions with needed private dce60_* dependent fuctions
Comment DCE6 specific CTRC program visibility implementation
Fix a typo in the initial header includes comment 's/DCE8/DCE6/g'
Use dce60_apply_ctx_for_surface() in dce60_hw_sequencer_construct
Use dce60_pipe_control_lock() in dce60_hw_sequencer_construct

Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
---
 .../amd/display/dc/dce60/dce60_hw_sequencer.c | 381 +++++++++++++++++-
 1 file changed, 379 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c
index e30e3510ec4a..37bd91883926 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_hw_sequencer.c
@@ -32,22 +32,399 @@
 #include "dce110/dce110_hw_sequencer.h"
 #include "dce100/dce100_hw_sequencer.h"
 
-/* include DCE8 register header files */
+/* include DCE6 register header files */
 #include "dce/dce_6_0_d.h"
 #include "dce/dce_6_0_sh_mask.h"
 
+#define DC_LOGGER_INIT()
+
 /*******************************************************************************
  * Private definitions
  ******************************************************************************/
 
 /***************************PIPE_CONTROL***********************************/
 
+/*
+ *  Check if FBC can be enabled
+ */
+static bool dce60_should_enable_fbc(struct dc *dc,
+		struct dc_state *context,
+		uint32_t *pipe_idx)
+{
+	uint32_t i;
+	struct pipe_ctx *pipe_ctx = NULL;
+	struct resource_context *res_ctx = &context->res_ctx;
+	unsigned int underlay_idx = dc->res_pool->underlay_pipe_index;
+
+
+	ASSERT(dc->fbc_compressor);
+
+	/* FBC memory should be allocated */
+	if (!dc->ctx->fbc_gpu_addr)
+		return false;
+
+	/* Only supports single display */
+	if (context->stream_count != 1)
+		return false;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		if (res_ctx->pipe_ctx[i].stream) {
+
+			pipe_ctx = &res_ctx->pipe_ctx[i];
+
+			if (!pipe_ctx)
+				continue;
+
+			/* fbc not applicable on underlay pipe */
+			if (pipe_ctx->pipe_idx != underlay_idx) {
+				*pipe_idx = i;
+				break;
+			}
+		}
+	}
+
+	if (i == dc->res_pool->pipe_count)
+		return false;
+
+	if (!pipe_ctx->stream->link)
+		return false;
+
+	/* Only supports eDP */
+	if (pipe_ctx->stream->link->connector_signal != SIGNAL_TYPE_EDP)
+		return false;
+
+	/* PSR should not be enabled */
+	if (pipe_ctx->stream->link->psr_settings.psr_feature_enabled)
+		return false;
+
+	/* Nothing to compress */
+	if (!pipe_ctx->plane_state)
+		return false;
+
+	/* Only for non-linear tiling */
+	if (pipe_ctx->plane_state->tiling_info.gfx8.array_mode == DC_ARRAY_LINEAR_GENERAL)
+		return false;
+
+	return true;
+}
+
+/*
+ *  Enable FBC
+ */
+static void dce60_enable_fbc(
+		struct dc *dc,
+		struct dc_state *context)
+{
+	uint32_t pipe_idx = 0;
+
+	if (dce60_should_enable_fbc(dc, context, &pipe_idx)) {
+		/* Program GRPH COMPRESSED ADDRESS and PITCH */
+		struct compr_addr_and_pitch_params params = {0, 0, 0};
+		struct compressor *compr = dc->fbc_compressor;
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[pipe_idx];
+
+		params.source_view_width = pipe_ctx->stream->timing.h_addressable;
+		params.source_view_height = pipe_ctx->stream->timing.v_addressable;
+		params.inst = pipe_ctx->stream_res.tg->inst;
+		compr->compr_surface_address.quad_part = dc->ctx->fbc_gpu_addr;
+
+		compr->funcs->surface_address_and_pitch(compr, &params);
+		compr->funcs->set_fbc_invalidation_triggers(compr, 1);
+
+		compr->funcs->enable_fbc(compr, &params);
+	}
+}
+
+
+/*******************************************************************************
+ * Front End programming
+ ******************************************************************************/
+
+static void dce60_set_default_colors(struct pipe_ctx *pipe_ctx)
+{
+	struct default_adjustment default_adjust = { 0 };
+
+	default_adjust.force_hw_default = false;
+	default_adjust.in_color_space = pipe_ctx->plane_state->color_space;
+	default_adjust.out_color_space = pipe_ctx->stream->output_color_space;
+	default_adjust.csc_adjust_type = GRAPHICS_CSC_ADJUST_TYPE_SW;
+	default_adjust.surface_pixel_format = pipe_ctx->plane_res.scl_data.format;
+
+	/* display color depth */
+	default_adjust.color_depth =
+		pipe_ctx->stream->timing.display_color_depth;
+
+	/* Lb color depth */
+	default_adjust.lb_color_depth = pipe_ctx->plane_res.scl_data.lb_params.depth;
+
+	pipe_ctx->plane_res.xfm->funcs->opp_set_csc_default(
+					pipe_ctx->plane_res.xfm, &default_adjust);
+}
+
+/*******************************************************************************
+ * In order to turn on surface we will program
+ * CRTC
+ *
+ * DCE6 has no bottom_pipe and no Blender HW
+ * We need to set 'blank_target' to false in order to turn on the display
+ *
+ * |-----------|------------|---------|
+ * |curr pipe  | set_blank  |         |
+ * |Surface    |blank_target|  CRCT   |
+ * |visibility |  argument  |         |
+ * |-----------|------------|---------|
+ * |    off    |   true     | blank   |
+ * |    on     |   false    | unblank |
+ * |-----------|------------|---------|
+ *
+ ******************************************************************************/
+static void dce60_program_surface_visibility(const struct dc *dc,
+		struct pipe_ctx *pipe_ctx)
+{
+	bool blank_target = false;
+
+	/* DCE6 has no bottom_pipe and no Blender HW */
+
+	if (!pipe_ctx->plane_state->visible)
+		blank_target = true;
+
+	/* DCE6 skip dce_set_blender_mode() but then proceed to 'unblank' CRTC */
+	pipe_ctx->stream_res.tg->funcs->set_blank(pipe_ctx->stream_res.tg, blank_target);
+
+}
+
+
+static void dce60_get_surface_visual_confirm_color(const struct pipe_ctx *pipe_ctx,
+		struct tg_color *color)
+{
+	uint32_t color_value = MAX_TG_COLOR_VALUE * (4 - pipe_ctx->stream_res.tg->inst) / 4;
+
+	switch (pipe_ctx->plane_res.scl_data.format) {
+	case PIXEL_FORMAT_ARGB8888:
+		/* set boarder color to red */
+		color->color_r_cr = color_value;
+		break;
+
+	case PIXEL_FORMAT_ARGB2101010:
+		/* set boarder color to blue */
+		color->color_b_cb = color_value;
+		break;
+	case PIXEL_FORMAT_420BPP8:
+		/* set boarder color to green */
+		color->color_g_y = color_value;
+		break;
+	case PIXEL_FORMAT_420BPP10:
+		/* set boarder color to yellow */
+		color->color_g_y = color_value;
+		color->color_r_cr = color_value;
+		break;
+	case PIXEL_FORMAT_FP16:
+		/* set boarder color to white */
+		color->color_r_cr = color_value;
+		color->color_b_cb = color_value;
+		color->color_g_y = color_value;
+		break;
+	default:
+		break;
+	}
+}
+
+static void dce60_program_scaler(const struct dc *dc,
+		const struct pipe_ctx *pipe_ctx)
+{
+	struct tg_color color = {0};
+
+	/* DCE6 skips DCN TOFPGA check for transform_set_pixel_storage_depth == NULL */
+
+	if (dc->debug.visual_confirm == VISUAL_CONFIRM_SURFACE)
+		dce60_get_surface_visual_confirm_color(pipe_ctx, &color);
+	else
+		color_space_to_black_color(dc,
+				pipe_ctx->stream->output_color_space,
+				&color);
+
+	pipe_ctx->plane_res.xfm->funcs->transform_set_pixel_storage_depth(
+		pipe_ctx->plane_res.xfm,
+		pipe_ctx->plane_res.scl_data.lb_params.depth,
+		&pipe_ctx->stream->bit_depth_params);
+
+	if (pipe_ctx->stream_res.tg->funcs->set_overscan_blank_color) {
+		/*
+		 * The way 420 is packed, 2 channels carry Y component, 1 channel
+		 * alternate between Cb and Cr, so both channels need the pixel
+		 * value for Y
+		 */
+		if (pipe_ctx->stream->timing.pixel_encoding == PIXEL_ENCODING_YCBCR420)
+			color.color_r_cr = color.color_g_y;
+
+		pipe_ctx->stream_res.tg->funcs->set_overscan_blank_color(
+				pipe_ctx->stream_res.tg,
+				&color);
+	}
+
+	pipe_ctx->plane_res.xfm->funcs->transform_set_scaler(pipe_ctx->plane_res.xfm,
+		&pipe_ctx->plane_res.scl_data);
+}
+
+
+dce60_program_front_end_for_pipe(
+		struct dc *dc, struct pipe_ctx *pipe_ctx)
+{
+	struct mem_input *mi = pipe_ctx->plane_res.mi;
+	struct dc_plane_state *plane_state = pipe_ctx->plane_state;
+	struct xfm_grph_csc_adjustment adjust;
+	struct out_csc_color_matrix tbl_entry;
+	unsigned int i;
+	struct dce_hwseq *hws = dc->hwseq;
+
+	DC_LOGGER_INIT();
+	memset(&tbl_entry, 0, sizeof(tbl_entry));
+
+	memset(&adjust, 0, sizeof(adjust));
+	adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_BYPASS;
+
+	dce_enable_fe_clock(dc->hwseq, mi->inst, true);
+
+	dce60_set_default_colors(pipe_ctx);
+	if (pipe_ctx->stream->csc_color_matrix.enable_adjustment
+			== true) {
+		tbl_entry.color_space =
+			pipe_ctx->stream->output_color_space;
+
+		for (i = 0; i < 12; i++)
+			tbl_entry.regval[i] =
+			pipe_ctx->stream->csc_color_matrix.matrix[i];
+
+		pipe_ctx->plane_res.xfm->funcs->opp_set_csc_adjustment
+				(pipe_ctx->plane_res.xfm, &tbl_entry);
+	}
+
+	if (pipe_ctx->stream->gamut_remap_matrix.enable_remap == true) {
+		adjust.gamut_adjust_type = GRAPHICS_GAMUT_ADJUST_TYPE_SW;
+
+		for (i = 0; i < CSC_TEMPERATURE_MATRIX_SIZE; i++)
+			adjust.temperature_matrix[i] =
+				pipe_ctx->stream->gamut_remap_matrix.matrix[i];
+	}
+
+	pipe_ctx->plane_res.xfm->funcs->transform_set_gamut_remap(pipe_ctx->plane_res.xfm, &adjust);
+
+	pipe_ctx->plane_res.scl_data.lb_params.alpha_en = pipe_ctx->bottom_pipe != 0;
+
+	dce60_program_scaler(dc, pipe_ctx);
+
+	mi->funcs->mem_input_program_surface_config(
+			mi,
+			plane_state->format,
+			&plane_state->tiling_info,
+			&plane_state->plane_size,
+			plane_state->rotation,
+			NULL,
+			false);
+	if (mi->funcs->set_blank)
+		mi->funcs->set_blank(mi, pipe_ctx->plane_state->visible);
+
+	if (dc->config.gpu_vm_support)
+		mi->funcs->mem_input_program_pte_vm(
+				pipe_ctx->plane_res.mi,
+				plane_state->format,
+				&plane_state->tiling_info,
+				plane_state->rotation);
+
+	/* Moved programming gamma from dc to hwss */
+	if (pipe_ctx->plane_state->update_flags.bits.full_update ||
+			pipe_ctx->plane_state->update_flags.bits.in_transfer_func_change ||
+			pipe_ctx->plane_state->update_flags.bits.gamma_change)
+		hws->funcs.set_input_transfer_func(dc, pipe_ctx, pipe_ctx->plane_state);
+
+	if (pipe_ctx->plane_state->update_flags.bits.full_update)
+		hws->funcs.set_output_transfer_func(dc, pipe_ctx, pipe_ctx->stream);
+
+	DC_LOG_SURFACE(
+			"Pipe:%d %p: addr hi:0x%x, "
+			"addr low:0x%x, "
+			"src: %d, %d, %d,"
+			" %d; dst: %d, %d, %d, %d;"
+			"clip: %d, %d, %d, %d\n",
+			pipe_ctx->pipe_idx,
+			(void *) pipe_ctx->plane_state,
+			pipe_ctx->plane_state->address.grph.addr.high_part,
+			pipe_ctx->plane_state->address.grph.addr.low_part,
+			pipe_ctx->plane_state->src_rect.x,
+			pipe_ctx->plane_state->src_rect.y,
+			pipe_ctx->plane_state->src_rect.width,
+			pipe_ctx->plane_state->src_rect.height,
+			pipe_ctx->plane_state->dst_rect.x,
+			pipe_ctx->plane_state->dst_rect.y,
+			pipe_ctx->plane_state->dst_rect.width,
+			pipe_ctx->plane_state->dst_rect.height,
+			pipe_ctx->plane_state->clip_rect.x,
+			pipe_ctx->plane_state->clip_rect.y,
+			pipe_ctx->plane_state->clip_rect.width,
+			pipe_ctx->plane_state->clip_rect.height);
+
+	DC_LOG_SURFACE(
+			"Pipe %d: width, height, x, y\n"
+			"viewport:%d, %d, %d, %d\n"
+			"recout:  %d, %d, %d, %d\n",
+			pipe_ctx->pipe_idx,
+			pipe_ctx->plane_res.scl_data.viewport.width,
+			pipe_ctx->plane_res.scl_data.viewport.height,
+			pipe_ctx->plane_res.scl_data.viewport.x,
+			pipe_ctx->plane_res.scl_data.viewport.y,
+			pipe_ctx->plane_res.scl_data.recout.width,
+			pipe_ctx->plane_res.scl_data.recout.height,
+			pipe_ctx->plane_res.scl_data.recout.x,
+			pipe_ctx->plane_res.scl_data.recout.y);
+}
+
+static void dce60_apply_ctx_for_surface(
+		struct dc *dc,
+		const struct dc_stream_state *stream,
+		int num_planes,
+		struct dc_state *context)
+{
+	int i;
+
+	if (num_planes == 0)
+		return;
+
+	if (dc->fbc_compressor)
+		dc->fbc_compressor->funcs->disable_fbc(dc->fbc_compressor);
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+		if (pipe_ctx->stream != stream)
+			continue;
+
+		/* Need to allocate mem before program front end for Fiji */
+		pipe_ctx->plane_res.mi->funcs->allocate_mem_input(
+				pipe_ctx->plane_res.mi,
+				pipe_ctx->stream->timing.h_total,
+				pipe_ctx->stream->timing.v_total,
+				pipe_ctx->stream->timing.pix_clk_100hz / 10,
+				context->stream_count);
+
+		dce60_program_front_end_for_pipe(dc, pipe_ctx);
+
+		dc->hwss.update_plane_addr(dc, pipe_ctx);
+
+		dce60_program_surface_visibility(dc, pipe_ctx);
+
+	}
+
+	if (dc->fbc_compressor)
+		dce60_enable_fbc(dc, context);
+}
+
 void dce60_hw_sequencer_construct(struct dc *dc)
 {
 	dce110_hw_sequencer_construct(dc);
 
 	dc->hwseq->funcs.enable_display_power_gating = dce100_enable_display_power_gating;
-	dc->hwss.pipe_control_lock = dce_pipe_control_lock;
+	dc->hwss.apply_ctx_for_surface = dce60_apply_ctx_for_surface;
+	dc->hwss.pipe_control_lock = dce60_pipe_control_lock;
 	dc->hwss.prepare_bandwidth = dce100_prepare_bandwidth;
 	dc->hwss.optimize_bandwidth = dce100_optimize_bandwidth;
 }
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

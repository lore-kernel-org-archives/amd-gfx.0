Return-Path: <SRS0=xwQz=A3=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URG_BIZ,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6020FC433F4
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:29 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FEE620787
	for <amd-gfx@archiver.kernel.org>; Thu, 16 Jul 2020 21:23:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEUqJa7w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FEE620787
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA3D66ECF7;
	Thu, 16 Jul 2020 21:23:28 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 870BA6ECF7
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 21:23:26 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id o2so13178958wmh.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 Jul 2020 14:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+94iN5jmV4vW7sjBL7GViScIdGhXe7wMUmgKWTXosoA=;
 b=nEUqJa7wydhN3LXKUFlp/JkWkdeGelpdFG3dcC8MhPhGa0W8rcuTIpRZhydy/GCJFx
 Yuu4xKe9espwQ0iQITecsuD2Ru5aeCDAeqQp+LA8LAFNPCJnfluglTZO7hwJ/qoYa6UZ
 G3jVszGKlCxXndl7s6vFv0vg3gKS6JtvBTqCoWAsP1ITqKJuQ1k88zlyfmJzXw50CclM
 AgyDJrNfqto9ncKj3Ys9fOUYSr/D4c4WCPTHISlxQ61yVBXtaYL6c85wEO+WiMd9YKrM
 qBb/PSBDjjBW3UJQhwL9acdWX9X/5dNnkV5eKnk2EiWxsxd924BuG4B7565cs8G5Bc9b
 b4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+94iN5jmV4vW7sjBL7GViScIdGhXe7wMUmgKWTXosoA=;
 b=rc44ndb020jq/PU4IEv9LSDYNQxSrAVn+dLY5Qw0XebVnZ8QkI4OzfW0gag0EqYsIW
 42W80b0gFHoiYRCXjdMiov59zPKrHFPGwbFEI/PgRBo3PI4tI5dc1/sbjVcqiU4E7EFT
 pY4QhdVm+KnzyRLNNWrtzqlrs0kEtWA8DjiU5HO0y//twVx7ZdNAlBDEsZkk8YcT6Iz9
 Sy9+Ek5efc680caVlpKKlBIjvcAy8i+aRtefndNhX/UbeBPVcuwFdC6ppjMX7ttXP7YF
 yhx7hp803AaUeVyHi25M0j52NAAo6uPLVeSrgAomLqFzVRwRXzYpS//A7xttSnkm4wtR
 mMOQ==
X-Gm-Message-State: AOAM530dJ/cz4K3V0BeiHUsSfv7drizqxRvlKhwYP773W5/wuT9jv3SF
 j+uPspBKAOsoWvCjfyV+kkozgDxXeK0=
X-Google-Smtp-Source: ABdhPJwGf46w+MIjWp9EkJ6rhpZEhc3/DhzPRrpcWmTfFS3uzksXpkSo6quMFm259gq3hT3UOt/73g==
X-Received: by 2002:a1c:49d4:: with SMTP id w203mr6411660wma.13.1594934604493; 
 Thu, 16 Jul 2020 14:23:24 -0700 (PDT)
Received: from utente-Giga.homenet.telecomitalia.it
 (host-79-21-65-179.retail.telecomitalia.it. [79.21.65.179])
 by smtp.googlemail.com with ESMTPSA id c15sm10288696wme.23.2020.07.16.14.23.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2020 14:23:24 -0700 (PDT)
From: Mauro Rossi <issor.oruam@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 16/27] drm/amd/display: dce_mem_input: add DCE6 specific
 macros, functions
Date: Thu, 16 Jul 2020 23:22:40 +0200
Message-Id: <20200716212251.1539094-17-issor.oruam@gmail.com>
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
DCE6 has DPG_PIPE_ARBITRATION_CONTROL3 register for Line Buffer watermark selection
DCE6 has STUTTER_EXIT_SELF_REFRESH_WATERMARK_MASK mask for Stutter watermark selection
DCE6 has NB_PSTATE_CHANGE_WATERMARK_MASK mask for North Bridge watermark selection
DCE6 has no GRPH_MICRO_TILE_MODE mask
DCE6 has no HW_ROTATION register

[How]
Add DCE6 specific macros definitions for MI registers and masks
Add DCE6 specific registers to dce_mem_input_registers struct
Add DCE6 specific masks to dce_mem_input_masks struct
DCE6 MI macros/structs changes will avoid buiding errors when using DCE6 headers
Add dce60_program_urgency_watermark() function
Add dce60_program_nbp_watermark() function
Add dce60_program_stutter_watermark() function
Add dce60_mi_program_display_marks() function w/ new DCE6 watermark programming
Add DCE6 specific tiling programming and modify DCE8 case
Add dce60_program_size() fuction w/o Rotation processing
Add dce60_mi_program_surface_config() fuction
Use dce60_mi_program_display_marks() in dce60_mi_funcs
Use dce60_mi_program_surface_config() in dce60_mi_funcs
Add DCE6 specific dce60_mem_input_construct

Signed-off-by: Mauro Rossi <issor.oruam@gmail.com>
---
 .../drm/amd/display/dc/dce/dce_mem_input.c    | 177 +++++++++++++++++-
 .../drm/amd/display/dc/dce/dce_mem_input.h    | 103 ++++++++++
 2 files changed, 279 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
index 51481e922eb9..422a9fc61b71 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.c
@@ -174,6 +174,22 @@ static void program_urgency_watermark(
 		URGENCY_HIGH_WATERMARK, urgency_high_wm);
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+static void dce60_program_urgency_watermark(
+	struct dce_mem_input *dce_mi,
+	uint32_t wm_select,
+	uint32_t urgency_low_wm,
+	uint32_t urgency_high_wm)
+{
+	REG_UPDATE(DPG_PIPE_ARBITRATION_CONTROL3,
+		URGENCY_WATERMARK_MASK, wm_select);
+
+	REG_SET_2(DPG_PIPE_URGENCY_CONTROL, 0,
+		URGENCY_LOW_WATERMARK, urgency_low_wm,
+		URGENCY_HIGH_WATERMARK, urgency_high_wm);
+}
+#endif
+
 static void dce120_program_urgency_watermark(
 	struct dce_mem_input *dce_mi,
 	uint32_t wm_select,
@@ -193,6 +209,25 @@ static void dce120_program_urgency_watermark(
 
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+static void dce60_program_nbp_watermark(
+	struct dce_mem_input *dce_mi,
+	uint32_t wm_select,
+	uint32_t nbp_wm)
+{
+	REG_UPDATE(DPG_PIPE_NB_PSTATE_CHANGE_CONTROL,
+		NB_PSTATE_CHANGE_WATERMARK_MASK, wm_select);
+
+	REG_UPDATE_3(DPG_PIPE_NB_PSTATE_CHANGE_CONTROL,
+		NB_PSTATE_CHANGE_ENABLE, 1,
+		NB_PSTATE_CHANGE_URGENT_DURING_REQUEST, 1,
+		NB_PSTATE_CHANGE_NOT_SELF_REFRESH_DURING_REQUEST, 1);
+
+	REG_UPDATE(DPG_PIPE_NB_PSTATE_CHANGE_CONTROL,
+		NB_PSTATE_CHANGE_WATERMARK, nbp_wm);
+}
+#endif
+
 static void program_nbp_watermark(
 	struct dce_mem_input *dce_mi,
 	uint32_t wm_select,
@@ -225,6 +260,20 @@ static void program_nbp_watermark(
 	}
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+static void dce60_program_stutter_watermark(
+	struct dce_mem_input *dce_mi,
+	uint32_t wm_select,
+	uint32_t stutter_mark)
+{
+	REG_UPDATE(DPG_PIPE_STUTTER_CONTROL,
+		STUTTER_EXIT_SELF_REFRESH_WATERMARK_MASK, wm_select);
+
+	REG_UPDATE(DPG_PIPE_STUTTER_CONTROL,
+		STUTTER_EXIT_SELF_REFRESH_WATERMARK, stutter_mark);
+}
+#endif
+
 static void dce120_program_stutter_watermark(
 	struct dce_mem_input *dce_mi,
 	uint32_t wm_select,
@@ -286,6 +335,34 @@ static void dce_mi_program_display_marks(
 	program_stutter_watermark(dce_mi, 1, stutter_exit.d_mark); /* set d */
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+static void dce60_mi_program_display_marks(
+	struct mem_input *mi,
+	struct dce_watermarks nbp,
+	struct dce_watermarks stutter_exit,
+	struct dce_watermarks stutter_enter,
+	struct dce_watermarks urgent,
+	uint32_t total_dest_line_time_ns)
+{
+	struct dce_mem_input *dce_mi = TO_DCE_MEM_INPUT(mi);
+	uint32_t stutter_en = mi->ctx->dc->debug.disable_stutter ? 0 : 1;
+
+	dce60_program_urgency_watermark(dce_mi, 2, /* set a */
+			urgent.a_mark, total_dest_line_time_ns);
+	dce60_program_urgency_watermark(dce_mi, 1, /* set d */
+			urgent.d_mark, total_dest_line_time_ns);
+
+	REG_UPDATE_2(DPG_PIPE_STUTTER_CONTROL,
+		STUTTER_ENABLE, stutter_en,
+		STUTTER_IGNORE_FBC, 1);
+	dce60_program_nbp_watermark(dce_mi, 2, nbp.a_mark); /* set a */
+	dce60_program_nbp_watermark(dce_mi, 1, nbp.d_mark); /* set d */
+
+	dce60_program_stutter_watermark(dce_mi, 2, stutter_exit.a_mark); /* set a */
+	dce60_program_stutter_watermark(dce_mi, 1, stutter_exit.d_mark); /* set d */
+}
+#endif
+
 static void dce112_mi_program_display_marks(struct mem_input *mi,
 	struct dce_watermarks nbp,
 	struct dce_watermarks stutter_exit,
@@ -369,7 +446,7 @@ static void program_tiling(
 		 */
 	}
 
-	if (dce_mi->masks->GRPH_ARRAY_MODE) { /* GFX8 */
+	if (dce_mi->masks->GRPH_MICRO_TILE_MODE) { /* GFX8 */
 		REG_UPDATE_9(GRPH_CONTROL,
 				GRPH_NUM_BANKS, info->gfx8.num_banks,
 				GRPH_BANK_WIDTH, info->gfx8.bank_width,
@@ -385,6 +462,23 @@ static void program_tiling(
 				GRPH_Z, 0);
 				*/
 	}
+
+	if (dce_mi->masks->GRPH_ARRAY_MODE) { /* GFX6 but reuses gfx8 struct */
+		REG_UPDATE_8(GRPH_CONTROL,
+				GRPH_NUM_BANKS, info->gfx8.num_banks,
+				GRPH_BANK_WIDTH, info->gfx8.bank_width,
+				GRPH_BANK_HEIGHT, info->gfx8.bank_height,
+				GRPH_MACRO_TILE_ASPECT, info->gfx8.tile_aspect,
+				GRPH_TILE_SPLIT, info->gfx8.tile_split,
+				/* DCE6 has no GRPH_MICRO_TILE_MODE mask */
+				GRPH_PIPE_CONFIG, info->gfx8.pipe_config,
+				GRPH_ARRAY_MODE, info->gfx8.array_mode,
+				GRPH_COLOR_EXPANSION_MODE, 1);
+		/* 01 - DCP_GRPH_COLOR_EXPANSION_MODE_ZEXP: zero expansion for YCbCr */
+		/*
+				GRPH_Z, 0);
+				*/
+	}
 }
 
 
@@ -429,6 +523,37 @@ static void program_size_and_rotation(
 			GRPH_ROTATION_ANGLE, rotation_angles[rotation]);
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+static void dce60_program_size(
+	struct dce_mem_input *dce_mi,
+	enum dc_rotation_angle rotation, /* not used in DCE6 */
+	const struct plane_size *plane_size)
+{
+	const struct rect *in_rect = &plane_size->surface_size;
+	struct rect hw_rect = plane_size->surface_size;
+	/* DCE6 has no HW rotation, skip rotation_angles declaration */
+
+	/* DCE6 has no HW rotation, skip ROTATION_ANGLE_* processing */
+
+	REG_SET(GRPH_X_START, 0,
+			GRPH_X_START, hw_rect.x);
+
+	REG_SET(GRPH_Y_START, 0,
+			GRPH_Y_START, hw_rect.y);
+
+	REG_SET(GRPH_X_END, 0,
+			GRPH_X_END, hw_rect.width);
+
+	REG_SET(GRPH_Y_END, 0,
+			GRPH_Y_END, hw_rect.height);
+
+	REG_SET(GRPH_PITCH, 0,
+			GRPH_PITCH, plane_size->surface_pitch);
+
+	/* DCE6 has no HW_ROTATION register, skip setting rotation_angles */
+}
+#endif
+
 static void program_grph_pixel_format(
 	struct dce_mem_input *dce_mi,
 	enum surface_pixel_format format)
@@ -521,6 +646,28 @@ static void dce_mi_program_surface_config(
 		program_grph_pixel_format(dce_mi, format);
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+static void dce60_mi_program_surface_config(
+	struct mem_input *mi,
+	enum surface_pixel_format format,
+	union dc_tiling_info *tiling_info,
+	struct plane_size *plane_size,
+	enum dc_rotation_angle rotation, /* not used in DCE6 */
+	struct dc_plane_dcc_param *dcc,
+	bool horizontal_mirror)
+{
+	struct dce_mem_input *dce_mi = TO_DCE_MEM_INPUT(mi);
+	REG_UPDATE(GRPH_ENABLE, GRPH_ENABLE, 1);
+
+	program_tiling(dce_mi, tiling_info);
+	dce60_program_size(dce_mi, rotation, plane_size);
+
+	if (format >= SURFACE_PIXEL_FORMAT_GRPH_BEGIN &&
+		format < SURFACE_PIXEL_FORMAT_VIDEO_BEGIN)
+		program_grph_pixel_format(dce_mi, format);
+}
+#endif
+
 static uint32_t get_dmif_switch_time_us(
 	uint32_t h_total,
 	uint32_t v_total,
@@ -741,6 +888,20 @@ static const struct mem_input_funcs dce_mi_funcs = {
 	.mem_input_is_flip_pending = dce_mi_is_flip_pending
 };
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+static const struct mem_input_funcs dce60_mi_funcs = {
+	.mem_input_program_display_marks = dce60_mi_program_display_marks,
+	.allocate_mem_input = dce_mi_allocate_dmif,
+	.free_mem_input = dce_mi_free_dmif,
+	.mem_input_program_surface_flip_and_addr =
+			dce_mi_program_surface_flip_and_addr,
+	.mem_input_program_pte_vm = dce_mi_program_pte_vm,
+	.mem_input_program_surface_config =
+			dce60_mi_program_surface_config,
+	.mem_input_is_flip_pending = dce_mi_is_flip_pending
+};
+#endif
+
 static const struct mem_input_funcs dce112_mi_funcs = {
 	.mem_input_program_display_marks = dce112_mi_program_display_marks,
 	.allocate_mem_input = dce_mi_allocate_dmif,
@@ -783,6 +944,20 @@ void dce_mem_input_construct(
 	dce_mi->masks = mi_mask;
 }
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+void dce60_mem_input_construct(
+	struct dce_mem_input *dce_mi,
+	struct dc_context *ctx,
+	int inst,
+	const struct dce_mem_input_registers *regs,
+	const struct dce_mem_input_shift *mi_shift,
+	const struct dce_mem_input_mask *mi_mask)
+{
+	dce_mem_input_construct(dce_mi, ctx, inst, regs, mi_shift, mi_mask);
+	dce_mi->base.funcs = &dce60_mi_funcs;
+}
+#endif
+
 void dce112_mem_input_construct(
 	struct dce_mem_input *dce_mi,
 	struct dc_context *ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
index d15b0d7f47fc..23db5c72f07e 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_mem_input.h
@@ -58,6 +58,31 @@
 	SRI(DVMM_PTE_CONTROL, DCP, id),\
 	SRI(DVMM_PTE_ARB_CONTROL, DCP, id)
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+#define MI_DCE6_REG_LIST(id)\
+	SRI(GRPH_ENABLE, DCP, id),\
+	SRI(GRPH_CONTROL, DCP, id),\
+	SRI(GRPH_X_START, DCP, id),\
+	SRI(GRPH_Y_START, DCP, id),\
+	SRI(GRPH_X_END, DCP, id),\
+	SRI(GRPH_Y_END, DCP, id),\
+	SRI(GRPH_PITCH, DCP, id),\
+	SRI(GRPH_SWAP_CNTL, DCP, id),\
+	SRI(PRESCALE_GRPH_CONTROL, DCP, id),\
+	SRI(GRPH_UPDATE, DCP, id),\
+	SRI(GRPH_FLIP_CONTROL, DCP, id),\
+	SRI(GRPH_PRIMARY_SURFACE_ADDRESS, DCP, id),\
+	SRI(GRPH_PRIMARY_SURFACE_ADDRESS_HIGH, DCP, id),\
+	SRI(GRPH_SECONDARY_SURFACE_ADDRESS, DCP, id),\
+	SRI(GRPH_SECONDARY_SURFACE_ADDRESS_HIGH, DCP, id),\
+	SRI(DPG_PIPE_ARBITRATION_CONTROL1, DMIF_PG, id),\
+	SRI(DPG_PIPE_ARBITRATION_CONTROL3, DMIF_PG, id),\
+	SRI(DPG_PIPE_NB_PSTATE_CHANGE_CONTROL, DMIF_PG, id),\
+	SRI(DPG_PIPE_URGENCY_CONTROL, DMIF_PG, id),\
+	SRI(DPG_PIPE_STUTTER_CONTROL, DMIF_PG, id),\
+	SRI(DMIF_BUFFER_CONTROL, PIPE, id)
+#endif
+
 #define MI_DCE8_REG_LIST(id)\
 	MI_DCE_BASE_REG_LIST(id),\
 	SRI(DPG_PIPE_NB_PSTATE_CHANGE_CONTROL, DMIF_PG, id)
@@ -104,6 +129,9 @@ struct dce_mem_input_registers {
 	uint32_t GRPH_SECONDARY_SURFACE_ADDRESS_HIGH;
 	/* DMIF_PG */
 	uint32_t DPG_PIPE_ARBITRATION_CONTROL1;
+#if defined(CONFIG_DRM_AMD_DC_SI)
+	uint32_t DPG_PIPE_ARBITRATION_CONTROL3;
+#endif
 	uint32_t DPG_WATERMARK_MASK_CONTROL;
 	uint32_t DPG_PIPE_URGENCY_CONTROL;
 	uint32_t DPG_PIPE_URGENT_LEVEL_CONTROL;
@@ -126,6 +154,18 @@ struct dce_mem_input_registers {
 #define SFB(blk_name, reg_name, field_name, post_fix)\
 	.field_name = blk_name ## reg_name ## __ ## field_name ## post_fix
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+#define MI_GFX6_TILE_MASK_SH_LIST(mask_sh, blk)\
+	SFB(blk, GRPH_CONTROL, GRPH_NUM_BANKS, mask_sh),\
+	SFB(blk, GRPH_CONTROL, GRPH_BANK_WIDTH, mask_sh),\
+	SFB(blk, GRPH_CONTROL, GRPH_BANK_HEIGHT, mask_sh),\
+	SFB(blk, GRPH_CONTROL, GRPH_MACRO_TILE_ASPECT, mask_sh),\
+	SFB(blk, GRPH_CONTROL, GRPH_TILE_SPLIT, mask_sh),\
+	SFB(blk, GRPH_CONTROL, GRPH_PIPE_CONFIG, mask_sh),\
+	SFB(blk, GRPH_CONTROL, GRPH_ARRAY_MODE, mask_sh),\
+	SFB(blk, GRPH_CONTROL, GRPH_COLOR_EXPANSION_MODE, mask_sh)
+#endif
+
 #define MI_GFX8_TILE_MASK_SH_LIST(mask_sh, blk)\
 	SFB(blk, GRPH_CONTROL, GRPH_NUM_BANKS, mask_sh),\
 	SFB(blk, GRPH_CONTROL, GRPH_BANK_WIDTH, mask_sh),\
@@ -162,6 +202,32 @@ struct dce_mem_input_registers {
 	SFB(blk, GRPH_UPDATE, GRPH_UPDATE_LOCK, mask_sh),\
 	SFB(blk, GRPH_FLIP_CONTROL, GRPH_SURFACE_UPDATE_H_RETRACE_EN, mask_sh)
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+#define MI_DCP_MASK_SH_LIST_DCE6(mask_sh, blk)\
+	SFB(blk, GRPH_ENABLE, GRPH_ENABLE, mask_sh),\
+	SFB(blk, GRPH_CONTROL, GRPH_DEPTH, mask_sh),\
+	SFB(blk, GRPH_CONTROL, GRPH_FORMAT, mask_sh),\
+	SFB(blk, GRPH_CONTROL, GRPH_NUM_BANKS, mask_sh),\
+	SFB(blk, GRPH_X_START, GRPH_X_START, mask_sh),\
+	SFB(blk, GRPH_Y_START, GRPH_Y_START, mask_sh),\
+	SFB(blk, GRPH_X_END, GRPH_X_END, mask_sh),\
+	SFB(blk, GRPH_Y_END, GRPH_Y_END, mask_sh),\
+	SFB(blk, GRPH_PITCH, GRPH_PITCH, mask_sh),\
+	SFB(blk, GRPH_SWAP_CNTL, GRPH_RED_CROSSBAR, mask_sh),\
+	SFB(blk, GRPH_SWAP_CNTL, GRPH_BLUE_CROSSBAR, mask_sh),\
+	SFB(blk, PRESCALE_GRPH_CONTROL, GRPH_PRESCALE_SELECT, mask_sh),\
+	SFB(blk, PRESCALE_GRPH_CONTROL, GRPH_PRESCALE_R_SIGN, mask_sh),\
+	SFB(blk, PRESCALE_GRPH_CONTROL, GRPH_PRESCALE_G_SIGN, mask_sh),\
+	SFB(blk, PRESCALE_GRPH_CONTROL, GRPH_PRESCALE_B_SIGN, mask_sh),\
+	SFB(blk, GRPH_SECONDARY_SURFACE_ADDRESS_HIGH, GRPH_SECONDARY_SURFACE_ADDRESS_HIGH, mask_sh),\
+	SFB(blk, GRPH_SECONDARY_SURFACE_ADDRESS, GRPH_SECONDARY_SURFACE_ADDRESS, mask_sh),\
+	SFB(blk, GRPH_PRIMARY_SURFACE_ADDRESS_HIGH, GRPH_PRIMARY_SURFACE_ADDRESS_HIGH, mask_sh),\
+	SFB(blk, GRPH_PRIMARY_SURFACE_ADDRESS, GRPH_PRIMARY_SURFACE_ADDRESS, mask_sh),\
+	SFB(blk, GRPH_UPDATE, GRPH_SURFACE_UPDATE_PENDING, mask_sh),\
+	SFB(blk, GRPH_UPDATE, GRPH_UPDATE_LOCK, mask_sh),\
+	SFB(blk, GRPH_FLIP_CONTROL, GRPH_SURFACE_UPDATE_H_RETRACE_EN, mask_sh)
+#endif
+
 #define MI_DCP_DCE11_MASK_SH_LIST(mask_sh, blk)\
 	SFB(blk, GRPH_PIPE_OUTSTANDING_REQUEST_LIMIT, GRPH_PIPE_OUTSTANDING_REQUEST_LIMIT, mask_sh)
 
@@ -172,6 +238,33 @@ struct dce_mem_input_registers {
 	SFB(blk, DVMM_PTE_ARB_CONTROL, DVMM_PTE_REQ_PER_CHUNK, mask_sh),\
 	SFB(blk, DVMM_PTE_ARB_CONTROL, DVMM_MAX_PTE_REQ_OUTSTANDING, mask_sh)
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+#define MI_DMIF_PG_MASK_SH_LIST_DCE6(mask_sh, blk)\
+	SFB(blk, DPG_PIPE_ARBITRATION_CONTROL1, PIXEL_DURATION, mask_sh),\
+	SFB(blk, DPG_PIPE_URGENCY_CONTROL, URGENCY_LOW_WATERMARK, mask_sh),\
+	SFB(blk, DPG_PIPE_URGENCY_CONTROL, URGENCY_HIGH_WATERMARK, mask_sh),\
+	SFB(blk, DPG_PIPE_STUTTER_CONTROL, STUTTER_ENABLE, mask_sh),\
+	SFB(blk, DPG_PIPE_STUTTER_CONTROL, STUTTER_IGNORE_FBC, mask_sh),\
+	SF(PIPE0_DMIF_BUFFER_CONTROL, DMIF_BUFFERS_ALLOCATED, mask_sh),\
+	SF(PIPE0_DMIF_BUFFER_CONTROL, DMIF_BUFFERS_ALLOCATION_COMPLETED, mask_sh)
+
+#define MI_DMIF_PG_MASK_SH_DCE6(mask_sh, blk)\
+	SFB(blk, DPG_PIPE_ARBITRATION_CONTROL3, URGENCY_WATERMARK_MASK, mask_sh),\
+	SFB(blk, DPG_PIPE_STUTTER_CONTROL, STUTTER_EXIT_SELF_REFRESH_WATERMARK_MASK, mask_sh),\
+	SFB(blk, DPG_PIPE_STUTTER_CONTROL, STUTTER_EXIT_SELF_REFRESH_WATERMARK, mask_sh),\
+	SFB(blk, DPG_PIPE_NB_PSTATE_CHANGE_CONTROL, NB_PSTATE_CHANGE_WATERMARK_MASK, mask_sh),\
+	SFB(blk, DPG_PIPE_NB_PSTATE_CHANGE_CONTROL, NB_PSTATE_CHANGE_ENABLE, mask_sh),\
+	SFB(blk, DPG_PIPE_NB_PSTATE_CHANGE_CONTROL, NB_PSTATE_CHANGE_URGENT_DURING_REQUEST, mask_sh),\
+	SFB(blk, DPG_PIPE_NB_PSTATE_CHANGE_CONTROL, NB_PSTATE_CHANGE_NOT_SELF_REFRESH_DURING_REQUEST, mask_sh),\
+	SFB(blk, DPG_PIPE_NB_PSTATE_CHANGE_CONTROL, NB_PSTATE_CHANGE_WATERMARK, mask_sh)
+
+#define MI_DCE6_MASK_SH_LIST(mask_sh)\
+	MI_DCP_MASK_SH_LIST_DCE6(mask_sh, ),\
+	MI_DMIF_PG_MASK_SH_LIST_DCE6(mask_sh, ),\
+	MI_DMIF_PG_MASK_SH_DCE6(mask_sh, ),\
+	MI_GFX6_TILE_MASK_SH_LIST(mask_sh, )
+#endif
+
 #define MI_DMIF_PG_MASK_SH_LIST(mask_sh, blk)\
 	SFB(blk, DPG_PIPE_ARBITRATION_CONTROL1, PIXEL_DURATION, mask_sh),\
 	SFB(blk, DPG_WATERMARK_MASK_CONTROL, URGENCY_WATERMARK_MASK, mask_sh),\
@@ -345,6 +438,16 @@ void dce_mem_input_construct(
 	const struct dce_mem_input_shift *mi_shift,
 	const struct dce_mem_input_mask *mi_mask);
 
+#if defined(CONFIG_DRM_AMD_DC_SI)
+void dce60_mem_input_construct(
+	struct dce_mem_input *dce_mi,
+	struct dc_context *ctx,
+	int inst,
+	const struct dce_mem_input_registers *regs,
+	const struct dce_mem_input_shift *mi_shift,
+	const struct dce_mem_input_mask *mi_mask);
+#endif
+
 void dce112_mem_input_construct(
 	struct dce_mem_input *dce_mi,
 	struct dc_context *ctx,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

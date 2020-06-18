Return-Path: <SRS0=7Qtl=77=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B673C433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 13:16:23 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F282073E
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Jun 2020 13:16:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rz4ANtQ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F282073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C37D16E432;
	Thu, 18 Jun 2020 13:16:22 +0000 (UTC)
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A10746E432
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 13:16:21 +0000 (UTC)
Received: by mail-qk1-x72a.google.com with SMTP id 205so5450258qkg.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Jun 2020 06:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=T0A+D3p7m8nF4nixWJ76gCRYLx5nNlBbFIXO7dxoXgo=;
 b=Rz4ANtQ2uhjg4bgwM0NxgA12C2Hl9H6TmnY2MMuNNRzNY4wEAMBMyzrIw6kv58eMeq
 IJ+ifCKSywuFhpCwxrf9vDUuvpDW+lXJyYO2vTcUiw/xEEgy2/vg0Cm9T1rZzKBkvBkO
 j35K92tY8863m1UFUYAFVpvm5zO1BQLAYb3Oqt7C/hMkgR3sEKp71h8qnq4v7E5Be8kT
 jI+NwkQu0cr3UBNrQja/2l0tgFvgXTFC4sjuSmPdunX09CUxE5orN6RW0N1h32oUQDcT
 CjUhCfMFfg4n/aYXhbMTLjOdmMHjTefrdBNeQTR/0QcObt6aq6FkW2vb5wYvHECq+Vg3
 fmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=T0A+D3p7m8nF4nixWJ76gCRYLx5nNlBbFIXO7dxoXgo=;
 b=Ms1hjb1t0BiWe2RarEFoE0iva3b7MgYREaKVKGQ9TukUBjZ7z+nMIjCLtumqowoWA1
 4tk49uVpM3w2JrtyMowlVodWXpfCGb3zh91f1J7eyI4kuJTzCc3xUBCKWszNr6RlIzg4
 whZ/rubiG3iP6Fya3/Ap5PjdroTLwAO4aGOmvCaHMgh4OA1TRmcPxjVQ+3kpgqwfvQZ3
 EzMBAS4roUPN5IUnfLFjppGWGVGO8tqodz1wQXrdIyUdjfpokiK48ZjastN1MoqqBBtX
 uDbgFnGVODI9MvhLWnUxvAAkQDeMeiNTfLDKYcmASo2PGzCqR5hBU2J7HjlLLbzcxsAw
 QEMw==
X-Gm-Message-State: AOAM532Hnxr5OgE6edGU7dpvKHmkdgOerIlSG5leBNyuDbR42dk6cJXB
 MJooHCvU8uMsBgWJ+RVVI2nJM971NdI=
X-Google-Smtp-Source: ABdhPJytrJ/yyEcaOp84yi2TZzpzeU84+g+jsrvb421mwcaPsxAA9P1enhX1P+JkbuJmU98TjZMB+A==
X-Received: by 2002:a37:8105:: with SMTP id c5mr3847846qkd.164.1592486180266; 
 Thu, 18 Jun 2020 06:16:20 -0700 (PDT)
Received: from brihaspati.amd.com
 (p200300c58f2304001ed633024609edb3.dip0.t-ipconnect.de.
 [2003:c5:8f23:400:1ed6:3302:4609:edb3])
 by smtp.gmail.com with ESMTPSA id v189sm3021933qkb.64.2020.06.18.06.16.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 06:16:19 -0700 (PDT)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amd/display: label internally used symbols as static
Date: Thu, 18 Jun 2020 15:17:12 +0200
Message-Id: <20200618131712.90389-4-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200618131712.90389-1-nirmoy.das@amd.com>
References: <20200618131712.90389-1-nirmoy.das@amd.com>
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
Cc: nirmoy.das@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Used sparse(make C=1) to find these loose ends.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 10 +++----
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  | 26 ++++++++++---------
 .../drm/amd/display/dc/dce/dce_panel_cntl.c   | 10 +++----
 .../drm/amd/display/dc/dcn20/dcn20_resource.c | 10 +++----
 4 files changed, 29 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 9ab0d8521576..93ba4ba9e564 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -700,7 +700,7 @@ static void amdgpu_dm_audio_fini(struct amdgpu_device *adev)
 	adev->mode_info.audio.enabled = false;
 }
 
-void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin)
+static  void amdgpu_dm_audio_eld_notify(struct amdgpu_device *adev, int pin)
 {
 	struct drm_audio_component *acomp = adev->dm.audio_component;
 
@@ -1586,7 +1586,7 @@ static void dm_gpureset_toggle_interrupts(struct amdgpu_device *adev,
 
 }
 
-enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
+static enum dc_status amdgpu_dm_commit_zero_streams(struct dc *dc)
 {
 	struct dc_state *context = NULL;
 	enum dc_status res = DC_ERROR_UNEXPECTED;
@@ -2706,7 +2706,7 @@ static int dm_atomic_get_state(struct drm_atomic_state *state,
 	return 0;
 }
 
-struct dm_atomic_state *
+static struct dm_atomic_state *
 dm_atomic_get_new_state(struct drm_atomic_state *state)
 {
 	struct drm_device *dev = state->dev;
@@ -2724,7 +2724,7 @@ dm_atomic_get_new_state(struct drm_atomic_state *state)
 	return NULL;
 }
 
-struct dm_atomic_state *
+static struct dm_atomic_state *
 dm_atomic_get_old_state(struct drm_atomic_state *state)
 {
 	struct drm_device *dev = state->dev;
@@ -5650,7 +5650,7 @@ dm_drm_plane_duplicate_state(struct drm_plane *plane)
 	return &dm_plane_state->base;
 }
 
-void dm_drm_plane_destroy_state(struct drm_plane *plane,
+static void dm_drm_plane_destroy_state(struct drm_plane *plane,
 				struct drm_plane_state *state)
 {
 	struct dm_plane_state *dm_plane_state = to_dm_plane_state(state);
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index a2e1a73f66b8..b3b42e279fb9 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -660,7 +660,7 @@ void pp_rv_set_hard_min_fclk_by_freq(struct pp_smu *pp, int mhz)
 	pp_funcs->set_hard_min_fclk_by_freq(pp_handle, mhz);
 }
 
-enum pp_smu_status pp_nv_set_wm_ranges(struct pp_smu *pp,
+static enum pp_smu_status pp_nv_set_wm_ranges(struct pp_smu *pp,
 		struct pp_smu_wm_range_sets *ranges)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -712,7 +712,7 @@ enum pp_smu_status pp_nv_set_wm_ranges(struct pp_smu *pp,
 	return PP_SMU_RESULT_OK;
 }
 
-enum pp_smu_status pp_nv_set_pme_wa_enable(struct pp_smu *pp)
+static enum pp_smu_status pp_nv_set_pme_wa_enable(struct pp_smu *pp)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
@@ -728,7 +728,7 @@ enum pp_smu_status pp_nv_set_pme_wa_enable(struct pp_smu *pp)
 	return PP_SMU_RESULT_OK;
 }
 
-enum pp_smu_status pp_nv_set_display_count(struct pp_smu *pp, int count)
+static enum pp_smu_status pp_nv_set_display_count(struct pp_smu *pp, int count)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
@@ -744,7 +744,8 @@ enum pp_smu_status pp_nv_set_display_count(struct pp_smu *pp, int count)
 	return PP_SMU_RESULT_OK;
 }
 
-enum pp_smu_status pp_nv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int mhz)
+static enum pp_smu_status
+pp_nv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int mhz)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
@@ -760,7 +761,7 @@ enum pp_smu_status pp_nv_set_min_deep_sleep_dcfclk(struct pp_smu *pp, int mhz)
 	return PP_SMU_RESULT_OK;
 }
 
-enum pp_smu_status pp_nv_set_hard_min_dcefclk_by_freq(
+static enum pp_smu_status pp_nv_set_hard_min_dcefclk_by_freq(
 		struct pp_smu *pp, int mhz)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -783,7 +784,8 @@ enum pp_smu_status pp_nv_set_hard_min_dcefclk_by_freq(
 	return PP_SMU_RESULT_OK;
 }
 
-enum pp_smu_status pp_nv_set_hard_min_uclk_by_freq(struct pp_smu *pp, int mhz)
+static enum pp_smu_status
+pp_nv_set_hard_min_uclk_by_freq(struct pp_smu *pp, int mhz)
 {
 	const struct dc_context *ctx = pp->dm;
 	struct amdgpu_device *adev = ctx->driver_context;
@@ -805,7 +807,7 @@ enum pp_smu_status pp_nv_set_hard_min_uclk_by_freq(struct pp_smu *pp, int mhz)
 	return PP_SMU_RESULT_OK;
 }
 
-enum pp_smu_status pp_nv_set_pstate_handshake_support(
+static enum pp_smu_status pp_nv_set_pstate_handshake_support(
 	struct pp_smu *pp, BOOLEAN pstate_handshake_supported)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -818,7 +820,7 @@ enum pp_smu_status pp_nv_set_pstate_handshake_support(
 	return PP_SMU_RESULT_OK;
 }
 
-enum pp_smu_status pp_nv_set_voltage_by_freq(struct pp_smu *pp,
+static enum pp_smu_status pp_nv_set_voltage_by_freq(struct pp_smu *pp,
 		enum pp_smu_nv_clock_id clock_id, int mhz)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -853,7 +855,7 @@ enum pp_smu_status pp_nv_set_voltage_by_freq(struct pp_smu *pp,
 	return PP_SMU_RESULT_OK;
 }
 
-enum pp_smu_status pp_nv_get_maximum_sustainable_clocks(
+static enum pp_smu_status pp_nv_get_maximum_sustainable_clocks(
 		struct pp_smu *pp, struct pp_smu_nv_clock_table *max_clocks)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -872,7 +874,7 @@ enum pp_smu_status pp_nv_get_maximum_sustainable_clocks(
 	return PP_SMU_RESULT_FAIL;
 }
 
-enum pp_smu_status pp_nv_get_uclk_dpm_states(struct pp_smu *pp,
+static enum pp_smu_status pp_nv_get_uclk_dpm_states(struct pp_smu *pp,
 		unsigned int *clock_values_in_khz, unsigned int *num_states)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -892,7 +894,7 @@ enum pp_smu_status pp_nv_get_uclk_dpm_states(struct pp_smu *pp,
 	return PP_SMU_RESULT_FAIL;
 }
 
-enum pp_smu_status pp_rn_get_dpm_clock_table(
+static enum pp_smu_status pp_rn_get_dpm_clock_table(
 		struct pp_smu *pp, struct dpm_clocks *clock_table)
 {
 	const struct dc_context *ctx = pp->dm;
@@ -911,7 +913,7 @@ enum pp_smu_status pp_rn_get_dpm_clock_table(
 	return PP_SMU_RESULT_FAIL;
 }
 
-enum pp_smu_status pp_rn_set_wm_ranges(struct pp_smu *pp,
+static enum pp_smu_status pp_rn_set_wm_ranges(struct pp_smu *pp,
 		struct pp_smu_wm_range_sets *ranges)
 {
 	const struct dc_context *ctx = pp->dm;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
index ebff9b1e312e..43781e77be43 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_panel_cntl.c
@@ -95,7 +95,7 @@ static unsigned int calculate_16_bit_backlight_from_pwm(struct dce_panel_cntl *d
 	return (uint32_t)(current_backlight);
 }
 
-uint32_t dce_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
+static uint32_t dce_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
 {
 	struct dce_panel_cntl *dce_panel_cntl = TO_DCE_PANEL_CNTL(panel_cntl);
 	uint32_t value;
@@ -155,7 +155,7 @@ uint32_t dce_panel_cntl_hw_init(struct panel_cntl *panel_cntl)
 	return current_backlight;
 }
 
-bool dce_is_panel_backlight_on(struct panel_cntl *panel_cntl)
+static bool dce_is_panel_backlight_on(struct panel_cntl *panel_cntl)
 {
 	struct dce_panel_cntl *dce_panel_cntl = TO_DCE_PANEL_CNTL(panel_cntl);
 	uint32_t value;
@@ -165,7 +165,7 @@ bool dce_is_panel_backlight_on(struct panel_cntl *panel_cntl)
 	return value;
 }
 
-bool dce_is_panel_powered_on(struct panel_cntl *panel_cntl)
+static bool dce_is_panel_powered_on(struct panel_cntl *panel_cntl)
 {
 	struct dce_panel_cntl *dce_panel_cntl = TO_DCE_PANEL_CNTL(panel_cntl);
 	uint32_t pwr_seq_state, dig_on, dig_on_ovrd;
@@ -177,7 +177,7 @@ bool dce_is_panel_powered_on(struct panel_cntl *panel_cntl)
 	return (pwr_seq_state == 1) || (dig_on == 1 && dig_on_ovrd == 1);
 }
 
-void dce_store_backlight_level(struct panel_cntl *panel_cntl)
+static void dce_store_backlight_level(struct panel_cntl *panel_cntl)
 {
 	struct dce_panel_cntl *dce_panel_cntl = TO_DCE_PANEL_CNTL(panel_cntl);
 
@@ -192,7 +192,7 @@ void dce_store_backlight_level(struct panel_cntl *panel_cntl)
 		&panel_cntl->stored_backlight_registers.LVTMA_PWRSEQ_REF_DIV_BL_PWM_REF_DIV);
 }
 
-void dce_driver_set_backlight(struct panel_cntl *panel_cntl,
+static void dce_driver_set_backlight(struct panel_cntl *panel_cntl,
 		uint32_t backlight_pwm_u16_16)
 {
 	uint32_t backlight_16bit;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index fb167393b8fe..8f51f9cbe32a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -157,7 +157,7 @@ struct _vcs_dpi_ip_params_st dcn2_0_ip = {
 	.number_of_cursors = 1,
 };
 
-struct _vcs_dpi_ip_params_st dcn2_0_nv14_ip = {
+static struct _vcs_dpi_ip_params_st dcn2_0_nv14_ip = {
 	.odm_capable = 1,
 	.gpuvm_enable = 0,
 	.hostvm_enable = 0,
@@ -226,7 +226,7 @@ struct _vcs_dpi_ip_params_st dcn2_0_nv14_ip = {
 	.number_of_cursors = 1,
 };
 
-struct _vcs_dpi_soc_bounding_box_st dcn2_0_soc = {
+static struct _vcs_dpi_soc_bounding_box_st dcn2_0_soc = {
 	/* Defaults that get patched on driver load from firmware. */
 	.clock_limits = {
 			{
@@ -338,7 +338,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_0_soc = {
 	.use_urgent_burst_bw = 0
 };
 
-struct _vcs_dpi_soc_bounding_box_st dcn2_0_nv14_soc = {
+static struct _vcs_dpi_soc_bounding_box_st dcn2_0_nv14_soc = {
 	.clock_limits = {
 			{
 				.state = 0,
@@ -449,7 +449,7 @@ struct _vcs_dpi_soc_bounding_box_st dcn2_0_nv14_soc = {
 	.use_urgent_burst_bw = 0
 };
 
-struct _vcs_dpi_soc_bounding_box_st dcn2_0_nv12_soc = { 0 };
+static struct _vcs_dpi_soc_bounding_box_st dcn2_0_nv12_soc = { 0 };
 
 #ifndef mmDP0_DP_DPHY_INTERNAL_CTRL
 	#define mmDP0_DP_DPHY_INTERNAL_CTRL		0x210f
@@ -1323,7 +1323,7 @@ static struct panel_cntl *dcn20_panel_cntl_create(const struct panel_cntl_init_d
 	return &panel_cntl->base;
 }
 
-struct clock_source *dcn20_clock_source_create(
+static struct clock_source *dcn20_clock_source_create(
 	struct dc_context *ctx,
 	struct dc_bios *bios,
 	enum clock_source_id id,
-- 
2.27.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

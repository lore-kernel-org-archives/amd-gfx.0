Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E213CCD5BA3
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 10:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F07A910EBF3;
	Tue, 19 May 2026 10:21:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l6HC7P8V";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11E0910EBE5
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 10:21:26 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso34858805e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 03:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779186084; x=1779790884; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o/v+OgXH76/fyX0XVLhQ0KmPkZnJGdH13PftH8FVtH4=;
 b=l6HC7P8VebRP55zGWFuOnUlm/NuGyJ2zVJkHKye+0l95houvWt3mwe6lmg8VOHl4tC
 vJbyP8FqViykg09nkBrq7gdHqRz70Mgr3+RDFkboWgbCEiV2zYMEorI8A5e3lywtgsmW
 LWdsH2Tju918gaMrxnN5imn7+BTMd79FKI/Nh0JI/pcs/jiieDmlztLqtD5Qz25h1vsr
 UEFUWSmZM+wRHoY6iKX09deFbekD6UQor4nnPu5oST+cv/Lb8Hm6cVmTjP2MYzVkPDzy
 CW8+6axlkX3odZKIKv0sYODrdhRwNjPT4EWx2YoL628Tdb9T7mzrWeqK82wH5MceOdxe
 ARpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779186084; x=1779790884;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o/v+OgXH76/fyX0XVLhQ0KmPkZnJGdH13PftH8FVtH4=;
 b=LwbEFqmVLHfEw67QghTU7br55r5aSt/7VDWyhUBInZFJbQqRLAvE3qg+Ng72ZPuelC
 AFvYNrkRVoapYV5EmZXTc5bzbvco9nosICFCm1rYfIzlB1D0bnKc/sDhpzg7okASZ2x6
 dcuJ7KJivRWHukvfVxhkJR5jy32gcBA006O81paFGEo+lGzwiBjA+ATGGXCXjPEmSFlu
 O4Vtm5rMPE7jFGGLT4II9Xo940gXraBoB8fBDV2FlEBU5iFEbiThDbWxbSoA/Ve1O3Lp
 VQB0Ol6G2lztHBqesV7HgdMzEu/27Mw2Iiykg+w1qVnUCaVx+IXAnvHTeXvLI/L0fM+v
 Lv3w==
X-Gm-Message-State: AOJu0YxwmTQdErKbgtuJ618Gxef3rP7klptob6W6Nx56Cw+uiItr/UeN
 /GX9OawlZ9lEYBniugN3RxtUQeQEp7vETlqJ3cEG2ZHhttQHOvLnUXTq8UJtyzPu
X-Gm-Gg: Acq92OEMwpSrIAvVUklLwYrta21DL0GzQrXloLlFF9flJEMAYLINQci8UauuE0sdIhM
 g0eYBChCrjd/KXI5xN9fcQ0DS8Ia2VU6xZm31sBxdga/gS8uAMbBIbdj0EUT99hr2HpvRKfTCbz
 Fqt46S4GGnXCadNsZVmdZEb+9PWZ65NPyMpDQRTliz4z/Y1LWj4ZiEX8MlnOPvtrmPOmoXse3GP
 DWtKfP7Tuo7HiI50hl5kvmWdrDff0dpHS18vBdIbI4wWMHAMEUq9VB7V5Fwm2HPeRQ2lYooZnRK
 M2nJWuBPL6Z2vElXSepjVBOwFGXHFs0+IfMP0eZ/FZ9u1WGR8C9yNyDZH+q9dHiCE0tSwOwX5KO
 YIKfmk99jA89ndRachAO5cjAG5uMel+iAmE9xafnnZe2TylBbM1+lTh57aAqTfWsw1jk10QVHlj
 SKPXV8/FcBgYAA0P4EsvrdfjDYYSIBlRiwYQdY+IOr63/rwDm+C/6cDf+ab3m1mdYK
X-Received: by 2002:a05:6000:603:b0:43d:7c6c:a0dd with SMTP id
 ffacd0b85a97d-45e5c609a1dmr29907521f8f.35.1779186084305; 
 Tue, 19 May 2026 03:21:24 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe0fecsm41028224f8f.26.2026.05.19.03.21.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 03:21:23 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Melissa Wen <mwen@igalia.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Alex Hung <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 03/14] drm/amd/display: Remove min/max clock levels from
 clk_mgr (v2)
Date: Tue, 19 May 2026 12:21:07 +0200
Message-ID: <20260519102118.246466-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519102118.246466-1-timur.kristof@gmail.com>
References: <20260519102118.246466-1-timur.kristof@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

These fields are not used by anything anymore.

v2:
- Delete dm_pp_get_static_clocks()
- Delete pp_to_dc_powerlevel_state()

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c  | 44 -------------------
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 14 ------
 .../dc/clk_mgr/dce112/dce112_clk_mgr.c        | 15 -------
 drivers/gpu/drm/amd/display/dc/dm_services.h  |  4 --
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  2 -
 5 files changed, 79 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 17f42201ab86..a3ee580d8dd1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -183,33 +183,6 @@ static enum amd_pp_clock_type dc_to_pp_clock_type(
 	return amd_pp_clk_type;
 }
 
-static enum dm_pp_clocks_state pp_to_dc_powerlevel_state(
-			enum PP_DAL_POWERLEVEL max_clocks_state)
-{
-	switch (max_clocks_state) {
-	case PP_DAL_POWERLEVEL_0:
-		return DM_PP_CLOCKS_DPM_STATE_LEVEL_0;
-	case PP_DAL_POWERLEVEL_1:
-		return DM_PP_CLOCKS_DPM_STATE_LEVEL_1;
-	case PP_DAL_POWERLEVEL_2:
-		return DM_PP_CLOCKS_DPM_STATE_LEVEL_2;
-	case PP_DAL_POWERLEVEL_3:
-		return DM_PP_CLOCKS_DPM_STATE_LEVEL_3;
-	case PP_DAL_POWERLEVEL_4:
-		return DM_PP_CLOCKS_DPM_STATE_LEVEL_4;
-	case PP_DAL_POWERLEVEL_5:
-		return DM_PP_CLOCKS_DPM_STATE_LEVEL_5;
-	case PP_DAL_POWERLEVEL_6:
-		return DM_PP_CLOCKS_DPM_STATE_LEVEL_6;
-	case PP_DAL_POWERLEVEL_7:
-		return DM_PP_CLOCKS_DPM_STATE_LEVEL_7;
-	default:
-		DRM_ERROR("DM_PPLIB: invalid powerlevel state: %d!\n",
-				max_clocks_state);
-		return DM_PP_CLOCKS_STATE_INVALID;
-	}
-}
-
 static void pp_to_dc_clock_levels(
 		const struct amd_pp_clocks *pp_clks,
 		struct dm_pp_clock_levels *dc_clks,
@@ -438,23 +411,6 @@ bool dm_pp_apply_clock_for_voltage_request(
 	return true;
 }
 
-bool dm_pp_get_static_clocks(
-	const struct dc_context *ctx,
-	struct dm_pp_static_clock_info *static_clk_info)
-{
-	struct amdgpu_device *adev = ctx->driver_context;
-	struct amd_pp_clock_info pp_clk_info = {0};
-
-	if (amdgpu_dpm_get_current_clocks(adev, &pp_clk_info))
-		return false;
-
-	static_clk_info->max_clocks_state = pp_to_dc_powerlevel_state(pp_clk_info.max_clocks_state);
-	static_clk_info->max_mclk_khz = pp_clk_info.max_memory_clock * 10;
-	static_clk_info->max_sclk_khz = pp_clk_info.max_engine_clock * 10;
-
-	return true;
-}
-
 static void pp_rv_set_wm_ranges(struct pp_smu *pp,
 		struct pp_smu_wm_range_sets *ranges)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index e8daee975b79..b7b72af9570a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -257,11 +257,6 @@ int dce_set_clock(
 		actual_clock = pxl_clk_params.dfs_bypass_display_clock;
 	}
 
-	/* from power down, we need mark the clock state as ClocksStateNominal
-	 * from HWReset, so when resume we will call pplib voltage regulator.*/
-	if (requested_clk_khz == 0)
-		clk_mgr_dce->cur_min_clks_state = DM_PP_CLOCKS_STATE_NOMINAL;
-
 	if (dmcu && dmcu->funcs->is_dmcu_initialized(dmcu))
 		dmcu->funcs->set_psr_wait_loop(dmcu, actual_clock / 1000 / 7);
 
@@ -425,7 +420,6 @@ void dce_clk_mgr_construct(
 		struct clk_mgr_internal *clk_mgr)
 {
 	struct clk_mgr *base = &clk_mgr->base;
-	struct dm_pp_static_clock_info static_clk_info = {0};
 
 	if (ctx->dce_version <= DCE_VERSION_6_4)
 		memcpy(clk_mgr->max_clks_by_state,
@@ -451,14 +445,6 @@ void dce_clk_mgr_construct(
 	clk_mgr->dprefclk_ss_divider = 1000;
 	clk_mgr->ss_on_dprefclk = false;
 
-	if (ctx->dce_version >= DCE_VERSION_8_0) {
-		if (dm_pp_get_static_clocks(ctx, &static_clk_info))
-			clk_mgr->max_clks_state = static_clk_info.max_clocks_state;
-		else
-			clk_mgr->max_clks_state = DM_PP_CLOCKS_STATE_NOMINAL;
-		clk_mgr->cur_min_clks_state = DM_PP_CLOCKS_STATE_INVALID;
-	}
-
 	base->clks.max_supported_dispclk_khz =
 		clk_mgr->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
index 48393c69735b..0f3f8df4df96 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
@@ -89,13 +89,6 @@ int dce112_set_clock(struct clk_mgr *clk_mgr_base, int requested_clk_khz)
 	bp->funcs->set_dce_clock(bp, &dce_clk_params);
 	actual_clock = dce_clk_params.target_clock_frequency;
 
-	/*
-	 * from power down, we need mark the clock state as ClocksStateNominal
-	 * from HWReset, so when resume we will call pplib voltage regulator.
-	 */
-	if (requested_clk_khz == 0)
-		clk_mgr_dce->cur_min_clks_state = DM_PP_CLOCKS_STATE_NOMINAL;
-
 	/*Program DP ref Clock*/
 	/*VBIOS will determine DPREFCLK frequency, so we don't set it*/
 	dce_clk_params.target_clock_frequency = 0;
@@ -143,14 +136,6 @@ int dce112_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_clk_khz)
 	bp->funcs->set_dce_clock(bp, &dce_clk_params);
 	actual_clock = dce_clk_params.target_clock_frequency;
 
-	/*
-	 * from power down, we need mark the clock state as ClocksStateNominal
-	 * from HWReset, so when resume we will call pplib voltage regulator.
-	 */
-	if (requested_clk_khz == 0)
-		clk_mgr->cur_min_clks_state = DM_PP_CLOCKS_STATE_NOMINAL;
-
-
 	if (dmcu && dmcu->funcs->is_dmcu_initialized(dmcu)) {
 		if (clk_mgr->dfs_bypass_disp_clk != actual_clock)
 			dmcu->funcs->set_psr_wait_loop(dmcu,
diff --git a/drivers/gpu/drm/amd/display/dc/dm_services.h b/drivers/gpu/drm/amd/display/dc/dm_services.h
index 1395d36bfabe..8b062b011fc6 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_services.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_services.h
@@ -228,10 +228,6 @@ bool dm_pp_apply_clock_for_voltage_request(
 	const struct dc_context *ctx,
 	struct dm_pp_clock_for_voltage_req *clock_for_voltage_req);
 
-bool dm_pp_get_static_clocks(
-	const struct dc_context *ctx,
-	struct dm_pp_static_clock_info *static_clk_info);
-
 /****** end of PP interfaces ******/
 
 struct persistent_data_flag {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index c69ccfcebeb5..e01bf6bd7f3f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -477,8 +477,6 @@ struct clk_mgr_internal {
 	 */
 	int dprefclk_ss_divider;
 
-	enum dm_pp_clocks_state max_clks_state;
-	enum dm_pp_clocks_state cur_min_clks_state;
 	bool periodic_retraining_disabled;
 
 	unsigned int cur_phyclk_req_table[MAX_LINKS];
-- 
2.54.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7048FCA0FE9
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Aug 2025 22:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B62C10E377;
	Mon, 25 Aug 2025 22:07:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KaTDFERB";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0EC010E293
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 22:07:39 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-3c6ae25978bso2219198f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Aug 2025 15:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756159658; x=1756764458; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dx9Pt6vLfxXwxLzRRYDDxp0gUdL4d0scm3FfjaT5XzE=;
 b=KaTDFERBYJXPEzKisPMOU6FCofU+xIhbH5Aw6BabRTOLe56X4lyuWTuA9zmN5QaZxl
 zbO37GFNzzeSfO+WQTFtKRYGKxoyLO7DSFzUx5GauNiRyFLRGStfGr0RAVXd2lS6pDZx
 1N1JUDCGh5oyw08c7fkdcxzwT8aU4zEVMWGO0o4bWy6cp2Te3fVrw5OLgdfJ1FbhODZE
 8HbiZ6ZGY1FfOioMVaSx4a2/iDBCWlpzkunMZ68iBnM+S0uSp5/8aIiqbEzJFunGkNpa
 L4zMHd/Qc+biRgzLWC0Evm8lkOxNxPyTwbb0q30NfUrw392mWGSiqx5bIMlbqEPi9+V8
 2fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756159658; x=1756764458;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dx9Pt6vLfxXwxLzRRYDDxp0gUdL4d0scm3FfjaT5XzE=;
 b=K0OBjMkMqxMwKoPqYVvrwm5N5fXyxjkr3tnXOVr7rfYEGNjVluF0ItfKQii8cvNUhs
 MZPAfybE/thODwGZ1P6C8dIN0adl5a6h4DTXslcZF2++BzHp0VKwQSQGrsKK1+dm0aws
 nBQj5mp4MGCAFUWJIOT1IcnIB95lu2MEZQb1AV3vMwKqCxPlLa0XC+b7UHL8pm9M9J04
 uO9bZi26dpLcdJg16ANsYEGyrcLyezUodeVQEGnrnqNcMEalchygEDGggL+WpdjK/CT3
 T0/2F9RUebQJFVxeRYg93kS9Obk7vsSJyIZA04f5kDb0beuBesaE+Nw24RpNJfDjjqqv
 tNKA==
X-Gm-Message-State: AOJu0YwaCKnQWFzNBvRcrAk4VCrDWAbXfX0Yadx/T7MBcCG58W/EbC98
 uxIh2pk3NA6JNT0r5nCiqJcyy92F8uNioun6H+YXFvxZh/it51rJucytq6/JZQ==
X-Gm-Gg: ASbGncu3Z6B07G9Pv6vRRnQ/ELFlOXMyumWDg45AV8Yq+b/J2NqVVjwkQZLWGhbc2lV
 lkXEcyZG6XYaHVe3LY/5gWJBRRCR5qjh8dBtHeRPJuBYrBrtABJkWHw97K2IxfQs9NO2GkrMH7r
 XFMFTDushuzlLteFKgph9RwFLUdGtgfrE5wkHD3pwZlrQMcY+vdnrJZGDW6f9mgUbhyM3txDrkA
 zx4A9PdSmYeYCGqyWL2mOfz/IuAGuORbxxR+E6hzHbypjJs4zmaSNHbDDvla+EJQp4LjV+PYZnE
 kbQlbsq+3KTVZuFMO9A+J1kLLXNHpV27VYeVHUv9HGXP77t83avonu8no2J7wRIG0+ivW4QWGMj
 kNTkDQCxIS+jxrogEnDGN7zUoaAOamoFzlJh8F+RBuK9s2gdOAWS1nrZ0bV3wUN6MtiwPZXxhz4
 ULQvCIAwELz7DB1/JClZcI/G/6fA==
X-Google-Smtp-Source: AGHT+IGoHNz1FCTpiRvcE1MTR/FNN/45CcBtnpG8QvPJAKO6grfpPIuxbhqOrZrkp6JyPsy56TMejg==
X-Received: by 2002:a05:6000:200e:b0:3c8:5b40:dea2 with SMTP id
 ffacd0b85a97d-3c85b40e7f4mr4962299f8f.44.1756159658277; 
 Mon, 25 Aug 2025 15:07:38 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24E36900D571F3015BAFEA47.dsl.pool.telekom.hu.
 [2001:4c4e:24e3:6900:d571:f301:5baf:ea47])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b66a64023sm1296395e9.1.2025.08.25.15.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Aug 2025 15:07:37 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexdeucher@gmail.com, alexander.deucher@amd.com, harry.wentland@amd.com,
 alex.hung@amd.com,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/3] drm/amd/pm: Use pm_display_cfg in legacy DPM
Date: Tue, 26 Aug 2025 00:07:31 +0200
Message-ID: <20250825220732.636810-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250825220732.636810-1-timur.kristof@gmail.com>
References: <20250825220732.636810-1-timur.kristof@gmail.com>
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

This commit is necessary for DC to function well with chips
that use the legacy power management code, ie. SI and KV.
Communicate display information from DC to the legacy PM code.

Currently DC uses pm_display_cfg to communicate power management
requirements from the display code to the DPM code.
However, the legacy (non-DC) code path used different fields
and therefore could not take into account anything from DC.

Change the legacy display code to fill the same pm_display_cfg
struct as DC and use the same in the legacy DPM code.

To ease review and reduce churn, this commit does not yet
delete the now unneeded code, that is done in the next commit.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c  | 67 +++++++++++++++++++
 .../gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h  |  2 +
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  4 +-
 .../gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c    |  6 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    | 64 ++++++------------
 .../gpu/drm/amd/pm/powerplay/amd_powerplay.c  | 11 +--
 6 files changed, 94 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
index 2d2d2d5e6763..9ef965e4a92e 100644
--- a/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
+++ b/drivers/gpu/drm/amd/pm/amdgpu_dpm_internal.c
@@ -100,3 +100,70 @@ u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev)
 
 	return vrefresh;
 }
+
+void amdgpu_dpm_get_display_cfg(struct amdgpu_device *adev)
+{
+	struct drm_device *ddev = adev_to_drm(adev);
+	struct amd_pp_display_configuration *cfg = &adev->pm.pm_display_cfg;
+	struct single_display_configuration *display_cfg;
+	struct drm_crtc *crtc;
+	struct amdgpu_crtc *amdgpu_crtc;
+	struct amdgpu_connector *conn;
+	int num_crtcs = 0;
+	int vrefresh;
+	u32 vblank_in_pixels, vblank_time_us;
+
+	cfg->min_vblank_time = 0xffffffff; /* if the displays are off, vblank time is max */
+
+	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
+		list_for_each_entry(crtc, &ddev->mode_config.crtc_list, head) {
+			amdgpu_crtc = to_amdgpu_crtc(crtc);
+
+			/* The array should only contain active displays. */
+			if (!amdgpu_crtc->enabled)
+				continue;
+
+			conn = to_amdgpu_connector(amdgpu_crtc->connector);
+			display_cfg = &adev->pm.pm_display_cfg.displays[num_crtcs++];
+
+			if (amdgpu_crtc->hw_mode.clock) {
+				vrefresh = drm_mode_vrefresh(&amdgpu_crtc->hw_mode);
+
+				vblank_in_pixels =
+					amdgpu_crtc->hw_mode.crtc_htotal *
+					(amdgpu_crtc->hw_mode.crtc_vblank_end -
+					amdgpu_crtc->hw_mode.crtc_vdisplay +
+					(amdgpu_crtc->v_border * 2));
+
+				vblank_time_us =
+					vblank_in_pixels * 1000 / amdgpu_crtc->hw_mode.clock;
+
+				/* The legacy (non-DC) code has issues with mclk switching
+				 * with refresh rates over 120 Hz. Disable mclk switching.
+				 */
+				if (vrefresh > 120)
+					vblank_time_us = 0;
+
+				/* Find minimum vblank time. */
+				if (vblank_time_us < cfg->min_vblank_time)
+					cfg->min_vblank_time = vblank_time_us;
+
+				/* Find vertical refresh rate of first active display. */
+				if (!cfg->vrefresh)
+					cfg->vrefresh = vrefresh;
+			}
+
+			if (amdgpu_crtc->crtc_id < cfg->crtc_index) {
+				/* Find first active CRTC and its line time. */
+				cfg->crtc_index = amdgpu_crtc->crtc_id;
+				cfg->line_time_in_us = amdgpu_crtc->line_time;
+			}
+
+			display_cfg->controller_id = amdgpu_crtc->crtc_id;
+			display_cfg->pixel_clock = conn->pixelclock_for_modeset;
+		}
+	}
+
+	cfg->display_clk = adev->clock.default_dispclk;
+	cfg->num_display = num_crtcs;
+}
diff --git a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h
index 5c2a89f0d5d5..8be11510cd92 100644
--- a/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h
+++ b/drivers/gpu/drm/amd/pm/inc/amdgpu_dpm_internal.h
@@ -29,4 +29,6 @@ u32 amdgpu_dpm_get_vblank_time(struct amdgpu_device *adev);
 
 u32 amdgpu_dpm_get_vrefresh(struct amdgpu_device *adev);
 
+void amdgpu_dpm_get_display_cfg(struct amdgpu_device *adev);
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
index 307ebf7e3226..33eb85dd68e9 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c
@@ -2299,7 +2299,7 @@ static void kv_apply_state_adjust_rules(struct amdgpu_device *adev,
 
 		if (pi->sys_info.nb_dpm_enable) {
 			force_high = (mclk >= pi->sys_info.nbp_memory_clock[3]) ||
-				pi->video_start || (adev->pm.dpm.new_active_crtc_count >= 3) ||
+				pi->video_start || (adev->pm.pm_display_cfg.num_display >= 3) ||
 				pi->disable_nb_ps3_in_battery;
 			ps->dpm0_pg_nb_ps_lo = force_high ? 0x2 : 0x3;
 			ps->dpm0_pg_nb_ps_hi = 0x2;
@@ -2358,7 +2358,7 @@ static int kv_calculate_nbps_level_settings(struct amdgpu_device *adev)
 			return 0;
 
 		force_high = ((mclk >= pi->sys_info.nbp_memory_clock[3]) ||
-			      (adev->pm.dpm.new_active_crtc_count >= 3) || pi->video_start);
+			      (adev->pm.pm_display_cfg.num_display >= 3) || pi->video_start);
 
 		if (force_high) {
 			for (i = pi->lowest_valid; i <= pi->highest_valid; i++)
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
index ea3ace882a10..3a5da3ff4d00 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/legacy_dpm.c
@@ -771,8 +771,7 @@ static struct amdgpu_ps *amdgpu_dpm_pick_power_state(struct amdgpu_device *adev,
 	int i;
 	struct amdgpu_ps *ps;
 	u32 ui_class;
-	bool single_display = (adev->pm.dpm.new_active_crtc_count < 2) ?
-		true : false;
+	bool single_display = !!adev->pm.pm_display_cfg.num_display;
 
 	/* check if the vblank period is too short to adjust the mclk */
 	if (single_display && adev->powerplay.pp_funcs->vblank_too_short) {
@@ -968,7 +967,8 @@ void amdgpu_legacy_dpm_compute_clocks(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	amdgpu_dpm_get_active_displays(adev);
+	if (!adev->dc_enabled)
+		amdgpu_dpm_get_display_cfg(adev);
 
 	amdgpu_dpm_change_power_state_locked(adev);
 }
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index 3fe6fa564e71..f9a22c2faf6a 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -3081,7 +3081,7 @@ static int si_get_vce_clock_voltage(struct amdgpu_device *adev,
 static bool si_dpm_vblank_too_short(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
-	u32 vblank_time = amdgpu_dpm_get_vblank_time(adev);
+	u32 vblank_time = adev->pm.pm_display_cfg.min_vblank_time;
 	/* we never hit the non-gddr5 limit so disable it (but treat 0 as too short) */
 	u32 switch_limit = adev->gmc.vram_type == AMDGPU_VRAM_TYPE_GDDR5 ? 450 : 1;
 
@@ -3441,9 +3441,10 @@ static void rv770_get_engine_memory_ss(struct amdgpu_device *adev)
 static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 					struct amdgpu_ps *rps)
 {
+	const struct amd_pp_display_configuration *display_cfg =
+		&adev->pm.pm_display_cfg;
 	struct  si_ps *ps = si_get_ps(rps);
 	struct amdgpu_clock_and_voltage_limits *max_limits;
-	struct amdgpu_connector *conn;
 	bool disable_mclk_switching = false;
 	bool disable_sclk_switching = false;
 	u32 mclk, sclk;
@@ -3482,14 +3483,9 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 	 * For example, 4K 60Hz and 1080p 144Hz fall into this category.
 	 * Find number of such displays connected.
 	 */
-	for (i = 0; i < adev->mode_info.num_crtc; i++) {
-		if (!(adev->pm.dpm.new_active_crtcs & (1 << i)) ||
-			!adev->mode_info.crtcs[i]->enabled)
-			continue;
-
-		conn = to_amdgpu_connector(adev->mode_info.crtcs[i]->connector);
-
-		if (conn->pixelclock_for_modeset > 297000)
+	for (i = 0; i < display_cfg->num_display; i++) {
+		/* The array only contains active displays. */
+		if (display_cfg->displays[i].pixel_clock > 297000)
 			high_pixelclock_count++;
 	}
 
@@ -3524,7 +3520,7 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 		rps->ecclk = 0;
 	}
 
-	if ((adev->pm.dpm.new_active_crtc_count > 1) ||
+	if ((adev->pm.pm_display_cfg.num_display > 1) ||
 	    si_dpm_vblank_too_short(adev))
 		disable_mclk_switching = true;
 
@@ -3672,7 +3668,7 @@ static void si_apply_state_adjust_rules(struct amdgpu_device *adev,
 						   ps->performance_levels[i].mclk,
 						   max_limits->vddc,  &ps->performance_levels[i].vddc);
 		btc_apply_voltage_dependency_rules(&adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk,
-						   adev->clock.current_dispclk,
+						   display_cfg->display_clk,
 						   max_limits->vddc,  &ps->performance_levels[i].vddc);
 	}
 
@@ -4197,16 +4193,16 @@ static void si_program_ds_registers(struct amdgpu_device *adev)
 
 static void si_program_display_gap(struct amdgpu_device *adev)
 {
+	const struct amd_pp_display_configuration *cfg = &adev->pm.pm_display_cfg;
 	u32 tmp, pipe;
-	int i;
 
 	tmp = RREG32(mmCG_DISPLAY_GAP_CNTL) & ~(CG_DISPLAY_GAP_CNTL__DISP1_GAP_MASK | CG_DISPLAY_GAP_CNTL__DISP2_GAP_MASK);
-	if (adev->pm.dpm.new_active_crtc_count > 0)
+	if (cfg->num_display > 0)
 		tmp |= R600_PM_DISPLAY_GAP_VBLANK_OR_WM << CG_DISPLAY_GAP_CNTL__DISP1_GAP__SHIFT;
 	else
 		tmp |= R600_PM_DISPLAY_GAP_IGNORE << CG_DISPLAY_GAP_CNTL__DISP1_GAP__SHIFT;
 
-	if (adev->pm.dpm.new_active_crtc_count > 1)
+	if (cfg->num_display > 1)
 		tmp |= R600_PM_DISPLAY_GAP_VBLANK_OR_WM << CG_DISPLAY_GAP_CNTL__DISP2_GAP__SHIFT;
 	else
 		tmp |= R600_PM_DISPLAY_GAP_IGNORE << CG_DISPLAY_GAP_CNTL__DISP2_GAP__SHIFT;
@@ -4216,17 +4212,8 @@ static void si_program_display_gap(struct amdgpu_device *adev)
 	tmp = RREG32(DCCG_DISP_SLOW_SELECT_REG);
 	pipe = (tmp & DCCG_DISP1_SLOW_SELECT_MASK) >> DCCG_DISP1_SLOW_SELECT_SHIFT;
 
-	if ((adev->pm.dpm.new_active_crtc_count > 0) &&
-	    (!(adev->pm.dpm.new_active_crtcs & (1 << pipe)))) {
-		/* find the first active crtc */
-		for (i = 0; i < adev->mode_info.num_crtc; i++) {
-			if (adev->pm.dpm.new_active_crtcs & (1 << i))
-				break;
-		}
-		if (i == adev->mode_info.num_crtc)
-			pipe = 0;
-		else
-			pipe = i;
+	if (cfg->num_display > 0 && pipe != cfg->crtc_index) {
+		pipe = cfg->crtc_index;
 
 		tmp &= ~DCCG_DISP1_SLOW_SELECT_MASK;
 		tmp |= DCCG_DISP1_SLOW_SELECT(pipe);
@@ -4237,7 +4224,7 @@ static void si_program_display_gap(struct amdgpu_device *adev)
 	 * This can be a problem on PowerXpress systems or if you want to use the card
 	 * for offscreen rendering or compute if there are no crtcs enabled.
 	 */
-	si_notify_smc_display_change(adev, adev->pm.dpm.new_active_crtc_count > 0);
+	si_notify_smc_display_change(adev, cfg->num_display > 0);
 }
 
 static void si_enable_spread_spectrum(struct amdgpu_device *adev, bool enable)
@@ -5546,7 +5533,7 @@ static int si_convert_power_level_to_smc(struct amdgpu_device *adev,
 	    (pl->mclk <= pi->mclk_stutter_mode_threshold) &&
 	    !eg_pi->uvd_enabled &&
 	    (RREG32(mmDPG_PIPE_STUTTER_CONTROL) & DPG_PIPE_STUTTER_CONTROL__STUTTER_ENABLE_MASK) &&
-	    (adev->pm.dpm.new_active_crtc_count <= 2)) {
+	    (adev->pm.pm_display_cfg.num_display <= 2)) {
 		level->mcFlags |= SISLANDS_SMC_MC_STUTTER_EN;
 	}
 
@@ -5702,7 +5689,7 @@ static bool si_is_state_ulv_compatible(struct amdgpu_device *adev,
 	/* XXX validate against display requirements! */
 
 	for (i = 0; i < adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.count; i++) {
-		if (adev->clock.current_dispclk <=
+		if (adev->pm.pm_display_cfg.display_clk <=
 		    adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[i].clk) {
 			if (ulv->pl.vddc <
 			    adev->pm.dpm.dyn_state.vddc_dependency_on_dispclk.entries[i].v)
@@ -5856,24 +5843,11 @@ static int si_upload_ulv_state(struct amdgpu_device *adev)
 
 static int si_upload_smc_data(struct amdgpu_device *adev)
 {
-	struct amdgpu_crtc *amdgpu_crtc = NULL;
-	int i;
-
-	if (adev->pm.dpm.new_active_crtc_count == 0)
-		return 0;
-
-	for (i = 0; i < adev->mode_info.num_crtc; i++) {
-		if (adev->pm.dpm.new_active_crtcs & (1 << i)) {
-			amdgpu_crtc = adev->mode_info.crtcs[i];
-			break;
-		}
-	}
-
-	if (amdgpu_crtc == NULL)
+	if (adev->pm.pm_display_cfg.num_display == 0)
 		return 0;
 
-	int first_crtc_id = amdgpu_crtc->crtc_id;
-	int first_crtc_line_time = amdgpu_crtc->line_time;
+	int first_crtc_id = adev->pm.pm_display_cfg.crtc_index;
+	int first_crtc_line_time = adev->pm.pm_display_cfg.line_time_in_us;
 
 	if (first_crtc_line_time <= 0)
 		return 0;
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index b48a031cbba0..554492dfa3c0 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1554,16 +1554,7 @@ static void pp_pm_compute_clocks(void *handle)
 	struct amdgpu_device *adev = hwmgr->adev;
 
 	if (!adev->dc_enabled) {
-		amdgpu_dpm_get_active_displays(adev);
-		adev->pm.pm_display_cfg.num_display = adev->pm.dpm.new_active_crtc_count;
-		adev->pm.pm_display_cfg.vrefresh = amdgpu_dpm_get_vrefresh(adev);
-		adev->pm.pm_display_cfg.min_vblank_time = amdgpu_dpm_get_vblank_time(adev);
-		/* we have issues with mclk switching with
-		 * refresh rates over 120 hz on the non-DC code.
-		 */
-		if (adev->pm.pm_display_cfg.vrefresh > 120)
-			adev->pm.pm_display_cfg.min_vblank_time = 0;
-
+		amdgpu_dpm_get_display_cfg(adev);
 		pp_display_configuration_change(handle,
 						&adev->pm.pm_display_cfg);
 	}
-- 
2.50.1


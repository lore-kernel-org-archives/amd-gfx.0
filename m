Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3276CD5BA3
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 10:21:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FBFD10EC09;
	Tue, 19 May 2026 10:21:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kjzH5cRO";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 564A110EC08
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 10:21:38 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-45297094718so2605302f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 03:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779186097; x=1779790897; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0IVfnpTZcjF+U7vHhyOQPf6AFBAZGkJjS0WBqRaCEXk=;
 b=kjzH5cROOxK6El7LJKdTEREFlPubn3oFflwxygyj/0A8675PpG3B/dCFqhOTdxeGs0
 Y2DVRQLr+/r/O3QSvNMVgrXxLBi3b/wIZZOQWhZVs+j5MlZ0vMPVxw6Je6XJLiexgl3E
 Q2NRxhl2cknULTZdD4dXovcPb5LdR7m3SFkosKYdAar2hgPLdk9vK7KWAnUfqmRPNhKS
 2n5+reXjZ3XkYgaukks+oQI8vgKnfGDU7sc46XWjNehXHwwg+ph1vajLu7IG4nxsLotD
 nAzLoL8clt8RslZ65qkqdDQOAGwr7n+s34IuAQcch+UAF12SiwAa+uH3JGwcOErMJvV2
 5WQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779186097; x=1779790897;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0IVfnpTZcjF+U7vHhyOQPf6AFBAZGkJjS0WBqRaCEXk=;
 b=Hyns2AmMcOeL0pVBD3G1fAWd3Ea9sKVjzGAz8dLqdEoPXCOm+/IoFH6BA1U8oieACa
 L25wMFtLFpMvuRSX+cfnUsiaUeGqvW9s7nShwK10fQsUKjBwKNjVWO9nTmnpi+qBAajv
 EJqkWeWMM6gACRNMGcyqbnf7p8r0UaRnuNvKPrGAqgENK67PXaDhzkWAshtbm1d9inMB
 Do8z0ruLilEqaKqqHbS0yxK33bDG7k0nFSH8Tw/0p7B/fkrxr6dt934JTDMpflaG6ydi
 RJpdz3C5G2rJs1F+gqVXFsdqYUcUXreZs44qlKv1LxS1EIHUQajj8f8RAcFbHFu/Kw6T
 t+8A==
X-Gm-Message-State: AOJu0Yw5Y0NzcvaK4raMlevT7r6llJYpEfoGEOeDBvKPpHnNGhaMNoac
 yQppiLKnTwiDfa0tWFg+caO3mnPbNmzNYPyR/Lqe7OrOsvvFNaKU+wziYWM4g3mo
X-Gm-Gg: Acq92OGKJwTs+DU9m/VdjLEdV+CwoE5aPeYjvRc+o8grFXcKdn0OgNY/MEu7yd0fQ1o
 MVxkMGHa9bDta6rJS9BSdpIsMd1lHTAKUAQFT/Gwn0w210Ros72sD778VJSU+/GLTYIxkiUzs4b
 rOPWN9h8KgfVxYBxLKrKZTYLU2Re7m7I9gnfkoi+EslTvO7mHzrp/ARizkJoBCFJV6bFcVEkEj7
 ziCCRjfr92QqnuE4J4R8RERmkkAlEWCy5z5dzZkaMER4QGlerQChk2uB5dlrR/dSL4vTUvbj1ML
 vG6CgWIx3rk1j2TMVzx3PLqtAE/l7wv7ebWfqS5xkckyZ8R8eAvekQBn9aZa35jRJLkNe98Dp8q
 TwdMpvZDRCdnd/pI1U9B4thVpZUpBEUqnMua0PKC+DHn+zwY8Vpio+utU69cpLPctbvqxgCbBGW
 +NTWaZ0sMsqa0LbqhabQ5HzvTROsX8NghBqWzgOm4B3nhyQtqRqraMeW2A368IcU3c
X-Received: by 2002:a5d:5d0e:0:b0:44e:639b:7d0f with SMTP id
 ffacd0b85a97d-45e5c36bd17mr29746943f8f.12.1779186094940; 
 Tue, 19 May 2026 03:21:34 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe0fecsm41028224f8f.26.2026.05.19.03.21.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 03:21:34 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Melissa Wen <mwen@igalia.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Alex Hung <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 13/14] drm/amd/pm: Delete get_dal_power_level
Date: Tue, 19 May 2026 12:21:17 +0200
Message-ID: <20260519102118.246466-14-timur.kristof@gmail.com>
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

Not needed anymore.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Melissa Wen <mwen@igalia.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   |  3 ---
 drivers/gpu/drm/amd/include/dm_pp_interface.h          |  1 -
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c       | 10 ----------
 .../gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c   | 10 ----------
 drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h |  3 ---
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h           |  2 --
 6 files changed, 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index a3ee580d8dd1..2cdb8fea504a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -288,7 +288,6 @@ bool dm_pp_get_clock_levels_by_type(
 		DRM_INFO("DM_PPLIB: Warning: using default validation clocks!\n");
 		validation_clks.engine_max_clock = 72000;
 		validation_clks.memory_max_clock = 80000;
-		validation_clks.level = 0;
 	}
 
 	DRM_INFO("DM_PPLIB: Validation clocks:\n");
@@ -296,8 +295,6 @@ bool dm_pp_get_clock_levels_by_type(
 			validation_clks.engine_max_clock);
 	DRM_INFO("DM_PPLIB:    memory_max_clock: %d\n",
 			validation_clks.memory_max_clock);
-	DRM_INFO("DM_PPLIB:    level           : %d\n",
-			validation_clks.level);
 
 	/* Translate 10 kHz to kHz. */
 	validation_clks.engine_max_clock *= 10;
diff --git a/drivers/gpu/drm/amd/include/dm_pp_interface.h b/drivers/gpu/drm/amd/include/dm_pp_interface.h
index 349544504c93..10747a1ceda9 100644
--- a/drivers/gpu/drm/amd/include/dm_pp_interface.h
+++ b/drivers/gpu/drm/amd/include/dm_pp_interface.h
@@ -113,7 +113,6 @@ struct amd_pp_display_configuration {
 struct amd_pp_simple_clock_info {
 	uint32_t	engine_max_clock;
 	uint32_t	memory_max_clock;
-	uint32_t	level;
 };
 
 enum PP_DAL_POWERLEVEL {
diff --git a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
index 4c2c40e8123b..a53577a83f1b 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c
@@ -1023,7 +1023,6 @@ static int pp_display_configuration_change(void *handle,
 static int pp_get_current_clocks(void *handle,
 		struct amd_pp_clock_info *clocks)
 {
-	struct amd_pp_simple_clock_info simple_clocks = { 0 };
 	struct pp_clock_info hw_clocks;
 	struct pp_hwmgr *hwmgr = handle;
 	int ret = 0;
@@ -1031,8 +1030,6 @@ static int pp_get_current_clocks(void *handle,
 	if (!hwmgr || !hwmgr->pm_en)
 		return -EINVAL;
 
-	phm_get_dal_power_level(hwmgr, &simple_clocks);
-
 	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps,
 					PHM_PlatformCaps_PowerContainment))
 		ret = phm_get_clock_info(hwmgr, &hwmgr->current_ps->hardware,
@@ -1057,11 +1054,6 @@ static int pp_get_current_clocks(void *handle,
 	clocks->max_engine_clock_in_sr = hw_clocks.max_eng_clk;
 	clocks->min_engine_clock_in_sr = hw_clocks.min_eng_clk;
 
-	if (simple_clocks.level == 0)
-		clocks->max_clocks_state = PP_DAL_POWERLEVEL_7;
-	else
-		clocks->max_clocks_state = simple_clocks.level;
-
 	if (0 == phm_get_current_shallow_sleep_clocks(hwmgr, &hwmgr->current_ps->hardware, &hw_clocks)) {
 		clocks->max_engine_clock_in_sr = hw_clocks.max_eng_clk;
 		clocks->min_engine_clock_in_sr = hw_clocks.min_eng_clk;
@@ -1138,8 +1130,6 @@ static int pp_get_display_mode_validation_clocks(void *handle,
 	if (!hwmgr || !hwmgr->pm_en || !clocks)
 		return -EINVAL;
 
-	clocks->level = PP_DAL_POWERLEVEL_7;
-
 	if (phm_cap_enabled(hwmgr->platform_descriptor.platformCaps, PHM_PlatformCaps_DynamicPatchPowerState))
 		ret = phm_get_max_high_clocks(hwmgr, clocks);
 
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
index a59677cf8dfc..72c2d3b69a03 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c
@@ -328,16 +328,6 @@ int phm_store_dal_configuration_data(struct pp_hwmgr *hwmgr,
 	return 0;
 }
 
-int phm_get_dal_power_level(struct pp_hwmgr *hwmgr,
-		struct amd_pp_simple_clock_info *info)
-{
-	PHM_FUNC_CHECK(hwmgr);
-
-	if (info == NULL || hwmgr->hwmgr_func->get_dal_power_level == NULL)
-		return -EINVAL;
-	return hwmgr->hwmgr_func->get_dal_power_level(hwmgr, info);
-}
-
 int phm_set_cpu_power_state(struct pp_hwmgr *hwmgr)
 {
 	PHM_FUNC_CHECK(hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
index 915f1b8e4dba..36dcad065fae 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h
@@ -426,9 +426,6 @@ extern int phm_check_states_equal(struct pp_hwmgr *hwmgr,
 extern int phm_store_dal_configuration_data(struct pp_hwmgr *hwmgr,
 		const struct amd_pp_display_configuration *display_config);
 
-extern int phm_get_dal_power_level(struct pp_hwmgr *hwmgr,
-		struct amd_pp_simple_clock_info *info);
-
 extern int phm_set_cpu_power_state(struct pp_hwmgr *hwmgr);
 
 extern int phm_power_down_asic(struct pp_hwmgr *hwmgr);
diff --git a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
index 1ee7e3044272..fc1ffe1b2c97 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
+++ b/drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h
@@ -292,8 +292,6 @@ struct pp_hwmgr_func {
 	int (*store_cc6_data)(struct pp_hwmgr *hwmgr, uint32_t separation_time,
 				bool cc6_disable, bool pstate_disable,
 				bool pstate_switch_disable);
-	int (*get_dal_power_level)(struct pp_hwmgr *hwmgr,
-			struct amd_pp_simple_clock_info *info);
 	int (*get_performance_level)(struct pp_hwmgr *, const struct pp_hw_power_state *,
 			PHM_PerformanceLevelDesignation, uint32_t, PHM_PerformanceLevel *);
 	int (*get_current_shallow_sleep_clocks)(struct pp_hwmgr *hwmgr,
-- 
2.54.0


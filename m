Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E98E7FDEE3F
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 19:15:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C3F510F26E;
	Thu, 23 Apr 2026 19:15:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IX0B1caR";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B97CD10F28E
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 19:15:37 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-43d74086e5bso6851750f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 12:15:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776971736; x=1777576536; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7VO6I5QnGA5nVF8e8PnB2517XCCeC0r1sjiCH5nGpbA=;
 b=IX0B1caR+B8ZkzAfeC50j4/lIw/7hUuQjUj68cBQQlYWyp2jpaVp3Q55QnX6aqZFrh
 gvNGn7BuAYM9EcHM3vAozozYTBygpMlHiFnJJM9xg1Dnxu3E202Aouvsy0VIMiYwKl2g
 80M50X0jIv8J/LW4eOO99OxSr9W9iaEd5q0FXBq0UR2KHltmoj4fJdYE4lGxADOGc6vy
 Hs+L16PUniJi1mv79xM0ItX7g4zG29OvVnuPw1xYkaRnxQbvEgzkJu7RFAhoq87ELEYw
 Ip3SlogCpV2Sru3waNUpMjaMLBCtE5ZUhlpGbUb5hcNNjU335SOB/NgFTMyUodwjX2oU
 PoYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776971736; x=1777576536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7VO6I5QnGA5nVF8e8PnB2517XCCeC0r1sjiCH5nGpbA=;
 b=XRJH7KyLD9h7IR3OrCe6i8hVIqBHuky9zTTHTxiWYcAbTUdiJ1kFYb8GF3ZI7ZbQnQ
 jrO37y7KG0cG52HXQ6JgD16BJt0XH7sttaDWLurxJHQspgP239+3RrT5NISaAEAjl3P5
 yzsvI8lg9cXHLTYmTtyQ0LfYp/aNqskvVNXehi84Z9rZzGKT6eZqnU3cALju9iEEkD1E
 pwLbXNCPMLZtp49fGo10/Zw4jffVMKJMt5aHkOgoAgAgKb71n5XvhIoVB4L+o12K/3F1
 8JP7c4yBsZ6BVurLtBxPjl/YF84a4x8o2hbhwOSxuELKaglCeYjEhlCEt5amdCDoJZLX
 dr2A==
X-Gm-Message-State: AOJu0Yyp4V2JpzLRV2+P1SxlpuUsWBu91VpKE6eiU1I03LS6pDCp1WIr
 QpfxGNYggencQFujPROBpP8/rVMfMhD/pmiMC+BBPTHnyXNF9bTkmwOlpm0yOsgp
X-Gm-Gg: AeBDiesOqC8D9XX+LYQzQRQD8x+eP9xbWiWc3ITx076QyYJ53AQb22QdQmHXoxhjYCw
 ZkzsFeV6wEux6AgLH0oXEaUApJmRUsQEChS01B9w15Cl8JD2apguKiNS7lBkujTfUGHlVT4udHH
 n1d8Gw76kvgKhEgiFObOdfLYZU6UXpT8clxzByY+qtICO/xcU5H6Qdzhwo+USHyn1BvA2M11c3Y
 eykYsZUr2XGPXG4n5tIqY8C77G0F+6uKcPxAsmk/XfTU+BdbnVFOYVybkHMqXu/VcmUkOMrZ7CO
 rDkXxp714YjJoQ5fY5fx727How154N52GecgSf2PSoarxiLOKnESvsxM+scD+1CteaFKkPQ7E/m
 SItR0U7WwDbLKyH8j+rmy8Hpg3m/a7CxKinvzaJyU04/gXnou8VI1SKgLTrXGpibEauCEUp8N+0
 s37pcKOW6b10zJkhXVMGK/MvRU+y+RmAewk36eEB16Gl9jhUNaCAF2x5bmDybpDpC9a6CaByRme
 hn4/w==
X-Received: by 2002:a05:6000:2511:b0:43d:76d8:5798 with SMTP id
 ffacd0b85a97d-43fe3e0db09mr44188935f8f.27.1776971736144; 
 Thu, 23 Apr 2026 12:15:36 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm15792782f8f.15.2026.04.23.12.15.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:15:35 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 13/14] drm/amd/pm: Delete get_dal_power_level
Date: Thu, 23 Apr 2026 21:15:18 +0200
Message-ID: <20260423191519.73127-14-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423191519.73127-1-timur.kristof@gmail.com>
References: <20260423191519.73127-1-timur.kristof@gmail.com>
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
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c   |  3 ---
 drivers/gpu/drm/amd/include/dm_pp_interface.h          |  1 -
 drivers/gpu/drm/amd/pm/powerplay/amd_powerplay.c       | 10 ----------
 .../gpu/drm/amd/pm/powerplay/hwmgr/hardwaremanager.c   | 10 ----------
 drivers/gpu/drm/amd/pm/powerplay/inc/hardwaremanager.h |  3 ---
 drivers/gpu/drm/amd/pm/powerplay/inc/hwmgr.h           |  2 --
 6 files changed, 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 2247969aa9acb..90f79d70874cd 100644
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
index 349544504c93c..10747a1ceda9a 100644
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
index 4c2c40e8123bf..a53577a83f1b3 100644
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
index a59677cf8dfc8..72c2d3b69a038 100644
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
index 915f1b8e4dbad..36dcad065faeb 100644
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
index 1ee7e3044272d..fc1ffe1b2c97f 100644
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
2.53.0


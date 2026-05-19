Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F839CD5BA3
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 10:21:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09B0010EC02;
	Tue, 19 May 2026 10:21:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bD+6oRml";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B3EB10EBE5
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 10:21:33 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-43d734223e4so2116454f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 03:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779186092; x=1779790892; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CqGAPLlG8EwaSYETtmidkLTdJdAHU8Ah+vlKDfh/0iU=;
 b=bD+6oRmlk4gi29xnoHIV4qKYg0EE2tFbfo1136OfnobssJelDhJ+50ybpNpK+dquzV
 dnIM3swzC2/zz1UgVAUlZMaYhaQFqTxmvBv743K+vex/raR7TjS9C2dQVilqTKbjrkUR
 B4/5gWsHNpyZnA85bIg/NWT5rdminiLvYYGXgtujV3D9QlBRfMOTdeJnbpUFWW2gcnuU
 gOyxN1ZkURXDyNwKuHFiYoWatIevsm7P7lHIxar0xJAquUQbpN9siNiCOc9y5fK0ZRCj
 UYHH6je54OdFDM3uBaJEvINpFHa4OcGkn7JK9XmkyBXtINtcjSoOw2Y7ZwRwWxvoKvdC
 KEhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779186092; x=1779790892;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CqGAPLlG8EwaSYETtmidkLTdJdAHU8Ah+vlKDfh/0iU=;
 b=IeWOwidnTzGu+8RM7AiNZN24oNtLPwl3aBhTRENNdcD9CPoDtfKSWAuY/+oPO15iSL
 7J/ScgTEjAvH10IZUpBMeJcm8VBDQV+di1XAJlyyRl74FQuYMXOpjte+rRomW8Zw96mH
 mhmAXQt2skWmvqxmg6valxoYTWL5dAUumT9iTv3Vtkhg/0s9RVq3F977KQkQzhxNrxcK
 mrH8A7KT2YRMNf61JJsJTZlIRH33Fdd0l5TqaqW0mxC9nSicQo0MNGi/JjWujBJV4mTI
 oRshFGcqHCnXgoDVX86nRJbb7ggVJE2fMx4RlRiiQeePbfhTpadnVZr4X4KqbU8p9iQs
 NPAQ==
X-Gm-Message-State: AOJu0YwvuXwcw6RngTRQx191p3crXFAzfX+o0x/yqmj9SXoEDbtFArOk
 uq5kHCRYs/IR6ea4Eo0HI6t8P6hrZDupFU6X3SEmouvFO+QEsgInB4oIR7ISRAaC
X-Gm-Gg: Acq92OEJ7GvC9pE/Fh0mBYWpaOlD9IGvha78LBkL2JOsfSPTwGHW+LBPxA7ar5HZR+5
 AYWvAP1HKAOGhYDHAJaFoTym6MyKkJmLYhOH+HnpFKmT2VCKvKihOhvu3N0MVmTyAwemGGVTWjE
 Ag2OK54/eiJcSxX5ZUOF19Rlet/C5dbdgiHvtfoej3CgN5SCX1cZLnTmz7CTeZZdpyv08h8HaWo
 TCoHW0XUcP9+qsxovZ/igjkQCVZZdHTrGDTS9GwY7Cv9yuYYkBVEc9BWLNejy2EIABmzEMFlTbx
 kN6n57gp9hjtF5yoFI5yoFVztTLRsVQilM1ZWJ50AxWMMH9uBGWNl5uIfnQKmFJulNpiYEdEAmB
 oSNL2yQAfm9BTK131Sc7woyM9BhZmIEl1+pbYc2E9J+jwGie3EtuzXidclFEoxPwd4qDZ8qZ+wB
 6AEM8mN5tmhS7Nq7WHkajAU95EQ3Txx/gKWtKyn9ZgKfOuBUWbiyLYuhRDR5XNPFfTxE4TpXVxf
 es=
X-Received: by 2002:a5d:4561:0:b0:45e:88f5:cd07 with SMTP id
 ffacd0b85a97d-45e88f5cf51mr2821069f8f.25.1779186091935; 
 Tue, 19 May 2026 03:21:31 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe0fecsm41028224f8f.26.2026.05.19.03.21.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 03:21:31 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Melissa Wen <mwen@igalia.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Alex Hung <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 10/14] drm/amd/pm: Delete dummy get_dal_power_level
 implementations
Date: Tue, 19 May 2026 12:21:14 +0200
Message-ID: <20260519102118.246466-11-timur.kristof@gmail.com>
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

These implementations did not actually return
the DAL power level, so they were effectively
a no-op.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Melissa Wen <mwen@igalia.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c    |  7 -------
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c   | 15 ---------------
 .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c   | 16 ----------------
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c   | 17 -----------------
 4 files changed, 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 8de8d66df95f..5be6f82ecc6f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
@@ -963,12 +963,6 @@ static int smu10_store_cc6_data(struct pp_hwmgr *hwmgr, uint32_t separation_time
 	return 0;
 }
 
-static int smu10_get_dal_power_level(struct pp_hwmgr *hwmgr,
-		struct amd_pp_simple_clock_info *info)
-{
-	return -EINVAL;
-}
-
 static int smu10_force_clock_level(struct pp_hwmgr *hwmgr,
 		enum pp_clock_type type, uint32_t mask)
 {
@@ -1664,7 +1658,6 @@ static const struct pp_hwmgr_func smu10_hwmgr_funcs = {
 	.store_cc6_data = smu10_store_cc6_data,
 	.force_clock_level = smu10_force_clock_level,
 	.emit_clock_levels = smu10_emit_clock_levels,
-	.get_dal_power_level = smu10_get_dal_power_level,
 	.get_performance_level = smu10_get_performance_level,
 	.get_current_shallow_sleep_clocks = smu10_get_current_shallow_sleep_clocks,
 	.get_clock_by_type_with_latency = smu10_get_clock_by_type_with_latency,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
index 1b8a57d98759..12f47ec87997 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c
@@ -4387,20 +4387,6 @@ static uint32_t vega10_get_fan_control_mode(struct pp_hwmgr *hwmgr)
 		return AMD_FAN_CTRL_AUTO;
 }
 
-static int vega10_get_dal_power_level(struct pp_hwmgr *hwmgr,
-		struct amd_pp_simple_clock_info *info)
-{
-	struct phm_ppt_v2_information *table_info =
-			(struct phm_ppt_v2_information *)hwmgr->pptable;
-	struct phm_clock_and_voltage_limits *max_limits =
-			&table_info->max_clock_voltage_on_ac;
-
-	info->engine_max_clock = max_limits->sclk;
-	info->memory_max_clock = max_limits->mclk;
-
-	return 0;
-}
-
 static void vega10_get_sclks(struct pp_hwmgr *hwmgr,
 		struct pp_clock_levels_with_latency *clocks)
 {
@@ -5645,7 +5631,6 @@ static const struct pp_hwmgr_func vega10_hwmgr_funcs = {
 	.set_fan_control_mode = vega10_set_fan_control_mode,
 	.get_fan_control_mode = vega10_get_fan_control_mode,
 	.read_sensor = vega10_read_sensor,
-	.get_dal_power_level = vega10_get_dal_power_level,
 	.get_clock_by_type_with_latency = vega10_get_clock_by_type_with_latency,
 	.get_clock_by_type_with_voltage = vega10_get_clock_by_type_with_voltage,
 	.set_watermarks_for_clocks_ranges = vega10_set_watermarks_for_clocks_ranges,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
index 5a987a535e73..6f2bb8fe0317 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c
@@ -1822,21 +1822,6 @@ static uint32_t vega12_get_fan_control_mode(struct pp_hwmgr *hwmgr)
 		return AMD_FAN_CTRL_AUTO;
 }
 
-static int vega12_get_dal_power_level(struct pp_hwmgr *hwmgr,
-		struct amd_pp_simple_clock_info *info)
-{
-#if 0
-	struct phm_ppt_v2_information *table_info =
-			(struct phm_ppt_v2_information *)hwmgr->pptable;
-	struct phm_clock_and_voltage_limits *max_limits =
-			&table_info->max_clock_voltage_on_ac;
-
-	info->engine_max_clock = max_limits->sclk;
-	info->memory_max_clock = max_limits->mclk;
-#endif
-	return 0;
-}
-
 static int vega12_get_clock_ranges(struct pp_hwmgr *hwmgr,
 		uint32_t *clock,
 		PPCLK_e clock_select,
@@ -2963,7 +2948,6 @@ static const struct pp_hwmgr_func vega12_hwmgr_funcs = {
 	.set_fan_control_mode = vega12_set_fan_control_mode,
 	.get_fan_control_mode = vega12_get_fan_control_mode,
 	.read_sensor = vega12_read_sensor,
-	.get_dal_power_level = vega12_get_dal_power_level,
 	.get_clock_by_type_with_latency = vega12_get_clock_by_type_with_latency,
 	.get_clock_by_type_with_voltage = vega12_get_clock_by_type_with_voltage,
 	.set_watermarks_for_clocks_ranges = vega12_set_watermarks_for_clocks_ranges,
diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
index 5193b7d0e11b..2a06d3e0253f 100644
--- a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
+++ b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c
@@ -2796,22 +2796,6 @@ static void vega20_set_fan_control_mode(struct pp_hwmgr *hwmgr, uint32_t mode)
 	}
 }
 
-static int vega20_get_dal_power_level(struct pp_hwmgr *hwmgr,
-		struct amd_pp_simple_clock_info *info)
-{
-#if 0
-	struct phm_ppt_v2_information *table_info =
-			(struct phm_ppt_v2_information *)hwmgr->pptable;
-	struct phm_clock_and_voltage_limits *max_limits =
-			&table_info->max_clock_voltage_on_ac;
-
-	info->engine_max_clock = max_limits->sclk;
-	info->memory_max_clock = max_limits->mclk;
-#endif
-	return 0;
-}
-
-
 static int vega20_get_sclks(struct pp_hwmgr *hwmgr,
 		struct pp_clock_levels_with_latency *clocks)
 {
@@ -4446,7 +4430,6 @@ static const struct pp_hwmgr_func vega20_hwmgr_funcs = {
 	/* export to DAL */
 	.get_sclk = vega20_dpm_get_sclk,
 	.get_mclk = vega20_dpm_get_mclk,
-	.get_dal_power_level = vega20_get_dal_power_level,
 	.get_clock_by_type_with_latency = vega20_get_clock_by_type_with_latency,
 	.get_clock_by_type_with_voltage = vega20_get_clock_by_type_with_voltage,
 	.set_watermarks_for_clocks_ranges = vega20_set_watermarks_for_clocks_ranges,
-- 
2.54.0


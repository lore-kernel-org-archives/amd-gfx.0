Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DDBFDEE45
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 19:15:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B48410F277;
	Thu, 23 Apr 2026 19:15:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UdVPd4An";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7BA9F10F277
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 19:15:34 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-43d7e23defbso4324924f8f.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 12:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776971733; x=1777576533; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O/Y5DYAtxi7ZOUEihVh5akVkzl0+pWKXZDEosfpq3Hw=;
 b=UdVPd4AnBGF9B4KhpKkAKAeK2savrbeGGEUXMwdb6ingzEhqkXjIGt/mJ04QZsSYf+
 AULdmE7y0e4rcb6UbAaMfqTzZPMqpGHiDi8QEvQc4HSE8RCApcLBX00sJNRDON6BAAK1
 1ynC2Nhh980Obl4TZBzh+JvXfALQS0i88kG8LHIAzKQSXycLKXJ7XEMpHqjBjyydR3WA
 RiKZAdQzc6kP7MqdOo4mgBMhr/y3Hbd8WU6DDbkWuWnZnakjKr51UT+a0M4PyGsn5sjx
 M8vGZzWAIexqizo2K14YSaVXVWzlPy+ZZ92hEkmfTf2ey3uJwEd4Mxri2qzcGwAwqnGB
 o1OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776971733; x=1777576533;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O/Y5DYAtxi7ZOUEihVh5akVkzl0+pWKXZDEosfpq3Hw=;
 b=me2AFwaFJmHa0ZHlJklbx68dIEGHxIsW2egkPWmbvPrNuQfEAft0e4vNQTWMtx8rQG
 VqBZ3cCxHEoAi3Xfjl5KtQC2pG4X26ttmyRL4eZpO42XtDgS0mJJyQ06Oypez7M+EcRu
 g+bcBL8o4MI9ADSak2zgmu9TI8dHtJTGSSSIqEnI3cdhCQ+uSYVBzI6cSHWWmFeRn9Br
 GFS166g38L7lYJVua4GgpPQCsSrsVmX6KPLmPO4oCt5a2jfcdjKZj1i8UjjWKQkMcnxo
 k6DQW7yFH7hgzkE6BJ+ncZ/mpOTQd4Zs95V1ApEyYA1bbWYxKT6bgkL7/iYGW/6+I0b+
 oPsA==
X-Gm-Message-State: AOJu0YzsshkT+urut02eERAnHBg8nRTKdQMLp6hZBHAlqm9cCD5J3uTx
 a89X6s4MU7w/hP+jMkAZKtofA6p08Ha0kAGXiRmXidFH8sBhVJIaGMzjYcYMT8k4
X-Gm-Gg: AeBDiestgOqoHNsVqq6iGRigf6ZHp+12orafoZiXI0hceu4HW0aHPtV5dacLJDZ1laO
 r3oKOwLO2lK/yC74e+twf0SStcR/q/txRRYMd/W4OvqgYmPvgDWimXFTu0ei0AvuNrxpjTx08xE
 QFh8KFXQrZfCYQeKsR7ax+DA0vbChAmNWyJOJ3oT8Pxi6mf3yJ66KV0Gk2Ibhquui0OBQLgFvOa
 xEeEybxTNvZXQSyCeTtJ/2V2OXuNPZWDT4HjPRVy7GvSmrveb/9WjIW8y56MGGKnH3joCKp46Cg
 lX3Qyl3cpjNZ4PIq+c5XD1Vc5RuE3/t4TFWLZMT83ECMt9oLTCoGPrEwzTFtk8xuxcZTKE3KRse
 U6wqsTlFBCxzBgTBPts/jjMThamz0r9ez8jOaGTdJGTqLsUxVfGpRABcS1knuo4Omy93vQxRMNq
 7odwMlrG7ieoVBPCqzHWAJW0vSNXTSKjGiVwwiKtxwYi+AvAYeIBozklR0XNrLSeShPFg186Try
 aOdPuIh99QNADgZ
X-Received: by 2002:a05:6000:25c4:b0:439:fc2c:363e with SMTP id
 ffacd0b85a97d-43fe3dc5affmr45456157f8f.13.1776971732931; 
 Thu, 23 Apr 2026 12:15:32 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm15792782f8f.15.2026.04.23.12.15.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:15:32 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 10/14] drm/amd/pm: Delete dummy get_dal_power_level
 implementations
Date: Thu, 23 Apr 2026 21:15:15 +0200
Message-ID: <20260423191519.73127-11-timur.kristof@gmail.com>
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

These implementations did not actually return
the DAL power level, so they were effectively
a no-op.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c    |  7 -------
 .../drm/amd/pm/powerplay/hwmgr/vega10_hwmgr.c   | 15 ---------------
 .../drm/amd/pm/powerplay/hwmgr/vega12_hwmgr.c   | 16 ----------------
 .../drm/amd/pm/powerplay/hwmgr/vega20_hwmgr.c   | 17 -----------------
 4 files changed, 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c b/drivers/gpu/drm/amd/pm/powerplay/hwmgr/smu10_hwmgr.c
index 8de8d66df95f4..5be6f82ecc6f5 100644
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
index 1b8a57d987597..12f47ec87997d 100644
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
index 5a987a535e73e..6f2bb8fe0317e 100644
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
index 5193b7d0e11be..2a06d3e0253fb 100644
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
2.53.0


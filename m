Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6135ACD4F57
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 10:21:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2DFA10E11D;
	Tue, 19 May 2026 10:21:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TVB79pkc";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A905910E0B0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 10:21:23 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-43fe608cb92so2069854f8f.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 03:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779186082; x=1779790882; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=me45rnp2qde7tN2W8oAuYBSfeLA8npZivIers3EqwIc=;
 b=TVB79pkcfohmOaDIO+IUP2tzo/J6pPgwFyS3DyvKTrv2Sz1IrMiP4nXmijCrShjhlG
 7QFfRVFh1Z3KXb+TNGZFg1vS8Zx/5EXI+EHnktWoLh+S5Td6S6ClNMgCbcuE4bEoQpJn
 YEd1oslE43ciP4+fHvtsbEAWvwZS7Ba4qJ5NZv7nscMBKsxbVBm6ylL7Wocyz7tFncaN
 51qYkNNf97gQu0W2mvoyWlS5fZYUkUgg+UahbRoKXy55tjw0rU+XVwQ4tUvQWFg4ui8x
 4FI52a1VqmnCD44CrQMIZk3RjLCTd//4EFfjwiBgwfOoxdJ7cv872AXo+j2gbKnyvLLI
 IJXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779186082; x=1779790882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=me45rnp2qde7tN2W8oAuYBSfeLA8npZivIers3EqwIc=;
 b=fXns9fJWAQrVQbz1IbvaCWISBGIinSFA/Pdejfmxh6cq1McU8nN2MDhBAc9kFh+1Cd
 pMdDX91ABvDLqss6iRYRfNW0JMMHpdkFOwmqI215DGyF54I4Bt5G99LiFVXY9nPvoM2O
 r/1uRGxLU/vxnZDKBKXMHWBHMBnJ+GzGcEYhPwBUL8j5mZF8qbHA/cLwQDaBgKL3O+7O
 1anUvxyECP0YVB/ewhARaXtwVJ3Wudh4Qu9a5x2tEMLexH3nqGTMhv3jR2AeOLQf0aM4
 QSubE8WwalRLS7UBoDNA+ufHTgvbATHLS3ctJWpOcJnC9KaVm8pkXMzJmc4sEvq8S5kj
 Zulg==
X-Gm-Message-State: AOJu0YwlY4QMRv14W+VF3B5BDsDqA0wKp3hzoapmro5Bc5Cbj8NIQZad
 EjFTdqIa+d6bfjZxyle6nhA5BMoh1LLq7RFFV8nZMVoayNv0uGfcBJ8yUutOdm8f
X-Gm-Gg: Acq92OHCKadGLFkAuhY1uC+6fIMAnc1yKwkE6pOPRitW/SNe7HFMTGQ1j7qVkT7CX8A
 OWRNz8as93fYWsoYjilhsbaKPyMsY20hR2o6UICqrLo/m26+RG2B0QyPAoHApI5DHv8xlDGaaht
 jCbh+KZX/7riTSunOHQm3qhCKaQXB5SFLhbxIoxfp/G2YSRYinDWXbjuzc7BGYdfnyWFtw+Br+z
 dUB0N/h9jNjx9SWt3E4WZHZvErTLqxRUduAeW/tuu3XSFcvoepkYACdnrpfpbJwDekosNRbR3Sf
 ukwjAIkToKfzqXVRpQzWaYTC7jCX82/PrF/hnhwcyHnjyxolxpmpaFxKYot+EmsO8iJL9br6NLE
 w3p8OeYp+6rAQn0qKmqp+KwtQJ2igobFGAgaIAuGKUqIsrQDPBYarku1vHv28GPtVtJatC8TJwF
 7M9OY8FCkDPeZMQ+YtVfS5vH9YpUXAJjnYLXus/064jgS9TLYXh8KeYSeTw5PD1Iao
X-Received: by 2002:a05:6000:2f8a:b0:45d:817c:b8b2 with SMTP id
 ffacd0b85a97d-45e5c5cc656mr30401856f8f.30.1779186082108; 
 Tue, 19 May 2026 03:21:22 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe0fecsm41028224f8f.26.2026.05.19.03.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 03:21:21 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Melissa Wen <mwen@igalia.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Alex Hung <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 01/14] drm/amd/display: Delete unimplemented
 dm_pp_apply_power_level_change_request() (v2)
Date: Tue, 19 May 2026 12:21:05 +0200
Message-ID: <20260519102118.246466-2-timur.kristof@gmail.com>
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

dm_pp_apply_power_level_change_request() was called from old
DCE clock manager implementations on DCE6, 8, 10, 11.2
but has not been implemented ever since the beginning of DC.

Affected GPUs have been working fine without that implementation
for many years. Let's delete it now.

v2:
- Delete dm_pp_apply_power_level_change_request too

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Melissa Wen <mwen@igalia.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c | 8 --------
 .../gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c  | 9 ---------
 .../drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c   | 9 ---------
 .../drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c   | 9 ---------
 drivers/gpu/drm/amd/display/dc/dm_services.h             | 4 ----
 drivers/gpu/drm/amd/display/dc/dm_services_types.h       | 4 ----
 6 files changed, 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 11b2ea6edf95..17f42201ab86 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
@@ -417,14 +417,6 @@ bool dm_pp_notify_wm_clock_changes(
 	return false;
 }
 
-bool dm_pp_apply_power_level_change_request(
-	const struct dc_context *ctx,
-	struct dm_pp_power_level_change_request *level_change_req)
-{
-	/* TODO: to be implemented */
-	return false;
-}
-
 bool dm_pp_apply_clock_for_voltage_request(
 	const struct dc_context *ctx,
 	struct dm_pp_clock_for_voltage_req *clock_for_voltage_req)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index 808e24f0e88f..4ccc6c742d00 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -431,19 +431,10 @@ static void dce_update_clocks(struct clk_mgr *clk_mgr_base,
 			bool safe_to_lower)
 {
 	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	struct dm_pp_power_level_change_request level_change_req;
 	const int max_disp_clk =
 		clk_mgr_dce->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
 	int patched_disp_clk = MIN(max_disp_clk, context->bw_ctx.bw.dce.dispclk_khz);
 
-	level_change_req.power_level = dce_get_required_clocks_state(clk_mgr_base, context);
-	/* get max clock state from PPLIB */
-	if ((level_change_req.power_level < clk_mgr_dce->cur_min_clks_state && safe_to_lower)
-			|| level_change_req.power_level > clk_mgr_dce->cur_min_clks_state) {
-		if (dm_pp_apply_power_level_change_request(clk_mgr_base->ctx, &level_change_req))
-			clk_mgr_dce->cur_min_clks_state = level_change_req.power_level;
-	}
-
 	if (should_set_clock(safe_to_lower, patched_disp_clk, clk_mgr_base->clks.dispclk_khz)) {
 		patched_disp_clk = dce_set_clock(clk_mgr_base, patched_disp_clk);
 		clk_mgr_base->clks.dispclk_khz = patched_disp_clk;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
index b35a44976477..d3cd542063db 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
@@ -257,21 +257,12 @@ static void dce11_update_clocks(struct clk_mgr *clk_mgr_base,
 			bool safe_to_lower)
 {
 	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	struct dm_pp_power_level_change_request level_change_req;
 	int patched_disp_clk = context->bw_ctx.bw.dce.dispclk_khz;
 
 	/*TODO: W/A for dal3 linux, investigate why this works */
 	if (!clk_mgr_dce->dfs_bypass_active)
 		patched_disp_clk = patched_disp_clk * 115 / 100;
 
-	level_change_req.power_level = dce_get_required_clocks_state(clk_mgr_base, context);
-	/* get max clock state from PPLIB */
-	if ((level_change_req.power_level < clk_mgr_dce->cur_min_clks_state && safe_to_lower)
-			|| level_change_req.power_level > clk_mgr_dce->cur_min_clks_state) {
-		if (dm_pp_apply_power_level_change_request(clk_mgr_base->ctx, &level_change_req))
-			clk_mgr_dce->cur_min_clks_state = level_change_req.power_level;
-	}
-
 	if (should_set_clock(safe_to_lower, patched_disp_clk, clk_mgr_base->clks.dispclk_khz)) {
 		context->bw_ctx.bw.dce.dispclk_khz = dce_set_clock(clk_mgr_base, patched_disp_clk);
 		clk_mgr_base->clks.dispclk_khz = patched_disp_clk;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
index 1f36ad8a7de4..48393c69735b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
@@ -193,21 +193,12 @@ static void dce112_update_clocks(struct clk_mgr *clk_mgr_base,
 			bool safe_to_lower)
 {
 	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	struct dm_pp_power_level_change_request level_change_req;
 	int patched_disp_clk = context->bw_ctx.bw.dce.dispclk_khz;
 
 	/*TODO: W/A for dal3 linux, investigate why this works */
 	if (!clk_mgr_dce->dfs_bypass_active)
 		patched_disp_clk = patched_disp_clk * 115 / 100;
 
-	level_change_req.power_level = dce_get_required_clocks_state(clk_mgr_base, context);
-	/* get max clock state from PPLIB */
-	if ((level_change_req.power_level < clk_mgr_dce->cur_min_clks_state && safe_to_lower)
-			|| level_change_req.power_level > clk_mgr_dce->cur_min_clks_state) {
-		if (dm_pp_apply_power_level_change_request(clk_mgr_base->ctx, &level_change_req))
-			clk_mgr_dce->cur_min_clks_state = level_change_req.power_level;
-	}
-
 	if (should_set_clock(safe_to_lower, patched_disp_clk, clk_mgr_base->clks.dispclk_khz)) {
 		patched_disp_clk = dce112_set_clock(clk_mgr_base, patched_disp_clk);
 		clk_mgr_base->clks.dispclk_khz = patched_disp_clk;
diff --git a/drivers/gpu/drm/amd/display/dc/dm_services.h b/drivers/gpu/drm/amd/display/dc/dm_services.h
index fbbf9c757b3c..1395d36bfabe 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_services.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_services.h
@@ -224,10 +224,6 @@ bool dm_pp_apply_display_requirements(
 	const struct dc_context *ctx,
 	const struct dm_pp_display_configuration *pp_display_cfg);
 
-bool dm_pp_apply_power_level_change_request(
-	const struct dc_context *ctx,
-	struct dm_pp_power_level_change_request *level_change_req);
-
 bool dm_pp_apply_clock_for_voltage_request(
 	const struct dc_context *ctx,
 	struct dm_pp_clock_for_voltage_req *clock_for_voltage_req);
diff --git a/drivers/gpu/drm/amd/display/dc/dm_services_types.h b/drivers/gpu/drm/amd/display/dc/dm_services_types.h
index 3b093b8699ab..cae3ed6056d6 100644
--- a/drivers/gpu/drm/amd/display/dc/dm_services_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dm_services_types.h
@@ -246,10 +246,6 @@ enum dm_acpi_display_type {
 	AcpiDisplayType_DFP6 = 12
 };
 
-struct dm_pp_power_level_change_request {
-	enum dm_pp_clocks_state power_level;
-};
-
 struct dm_pp_clock_for_voltage_req {
 	enum dm_pp_clock_type clk_type;
 	uint32_t clocks_in_khz;
-- 
2.54.0


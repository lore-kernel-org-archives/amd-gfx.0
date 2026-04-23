Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCF45FDEE3F
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 19:15:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7637210F240;
	Thu, 23 Apr 2026 19:15:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Oxho1OmR";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CE4010F236
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 19:15:25 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-48909558b3aso63857125e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 12:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776971724; x=1777576524; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IqsoOrnvDJ46ubFgr1djQI0jyKv8swbMpRnTCmSWrAI=;
 b=Oxho1OmR7YP5T9LxMsVUsoeDCwZEsndn90bFIu9WxUQTMX4l+T1SqiwJqIOCeNCDqt
 luVsFXiR8/0/83wT1qVCmWMuZYA/+FfhzvdggBKvT8oWTsM5Nz6W85oIr8drywZkSgE6
 QmDAqGRn8EQnIpg9CwY4UH5J1Ry3rle3ggUWZS6ObiC5uMmYosZp3mH4j+e0qVOYyyFv
 EJ4v3Ap3NL/5XeY4WzlB4Xg6AwhCjz30F4NLk1wEZBhpwwKPNaUFpaFCcaMjEXa+a+De
 qEZmB7q55Ly84ZIWyjlAQ73A8E7SWTDxQLYr0WO8BRg/jrR0ZfDnBuYcxGBoC01wxzO1
 eXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776971724; x=1777576524;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IqsoOrnvDJ46ubFgr1djQI0jyKv8swbMpRnTCmSWrAI=;
 b=a4fXEb7q7m5uMaIuKE4xBA27zsiTyAj22ywNN3R+Yy2Y7GP4nUT3PsGip0+dVXN/a7
 ezSaXPJP2BNZhKRDgQqrU+JsKDvO1/dwsX6EjORkG12NelZc9nn/bcBPhY3nTciM9TGV
 B4QZ2/eA8JGcSUuRZJMTjTdlwQf5uZAoX0t37rm9WpnLHlimGy9bgIsE2yKMRUlFUt8S
 egYJUbFrFCL/Iez6DIeQcs2Aq9/iWPZLweNuhBtt6nBfjWg9+gMyDoWC4X0Tdoq6ZC9x
 fxQGrMdgD3qMz3KH+uyIXtoRvdoqjDzjiGB9M5wmCYLrH8+x1QkVj3ayg6GeTgR8qyil
 J8IA==
X-Gm-Message-State: AOJu0YyRg2qd2gM3LsIzr3NYjmvfQtpyiWRD9OyT/+87ZxU082niVH5f
 /g7Rkft9++JlFtj1eKDn3ZEOKCh39XSPyKwqJ19hZv0Se7EJSvq0ZLsA/+FaLqfd
X-Gm-Gg: AeBDieugBWZNkqOKmTXqwVqQqyEJlAOYmw+eRGbYg49sxiSceuS2YkqAxfWbjfHMnZI
 kvhK8bNibLPY2NAwCLtmrQFk8iL53d3PQLSdgkY9V57v1qjiZ3LJg/W0J6d/lzrlDLvU4sBcrI6
 u7vXPJ1h1iXBsL+8BVsUddQKwelaGaD+zspd8Qgr0W9Zo7oX1i/2lzLnaIG3RoJzsxDEw2EJFjf
 m+EyQFBFU/oEVkWtkYguF2BRZOtbmkHMfKx5WJebKVjP7CEd+sree0/oNkQwWeTbKP8P3fcHTwv
 h+YUiPczUzTKt1yYEqkEc4Tl1SZQbgrsiqZBcOfSaG9uvY/X/Yed8NyXrvbRcYWHhUsmOo+V2t1
 IPk7M7cYLAaZiajQjpxBFlpElJM7j6SsQ3LFS1JujRbrPBExmcb0nJpbANqn4vXV4r0hy/YYz0q
 iV+xr4qDSSIgmj/FgtpWch2eNkkGi5kStBRxvTf9d5MSLnE/MLMfhT6ce7TwGIQCaGEckhGvgUC
 NL8xQ==
X-Received: by 2002:a05:600c:4746:b0:488:9439:881a with SMTP id
 5b1f17b1804b1-488fb738412mr380647705e9.2.1776971723714; 
 Thu, 23 Apr 2026 12:15:23 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm15792782f8f.15.2026.04.23.12.15.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:15:23 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 01/14] drm/amd/display: Delete unimplemented
 dm_pp_apply_power_level_change_request()
Date: Thu, 23 Apr 2026 21:15:06 +0200
Message-ID: <20260423191519.73127-2-timur.kristof@gmail.com>
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

dm_pp_apply_power_level_change_request() was called from old
DCE clock manager implementations on DCE6, 8, 10, 11.2
but has not been implemented ever since the beginning of DC.

Affected GPUs have been working fine without that implementation
for many years. Let's delete it now.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c | 8 --------
 .../gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c  | 9 ---------
 .../drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c   | 9 ---------
 .../drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c   | 9 ---------
 drivers/gpu/drm/amd/display/dc/dm_services.h             | 4 ----
 5 files changed, 39 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_pp_smu.c
index 11b2ea6edf953..17f42201ab862 100644
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
index 6d41df52d7c9b..ffb70120362e7 100644
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
index 13296c6ec08f4..ae922f1a31ff8 100644
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
index 1f36ad8a7de46..48393c69735b6 100644
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
index fbbf9c757b3c3..1395d36bfabe9 100644
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
-- 
2.53.0


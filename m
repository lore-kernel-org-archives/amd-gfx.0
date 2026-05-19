Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A3C7CD5BA4
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 10:21:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A267610EBF8;
	Tue, 19 May 2026 10:21:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GFRhhjG9";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1530F10EBF4
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 10:21:29 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-45297094718so2605095f8f.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 03:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779186088; x=1779790888; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U16zJTSnbffX1dN21R+EflW0v6/pU9yFvzxByHGVqc0=;
 b=GFRhhjG9HG5Xcf6kTDcEAhJhaSZ4jJs3EcFR34TR1KKUlLlhpXnVdiqBZyEGNKpDNM
 qW/5FOadC5lPaASvqBAzl6d7y+r9uofg7L2eounLs6se07aAG+DvV0nJfDZvRUuvelix
 +1opYeoPsCovGJ5bAtseOewWkdBLHT9xrUBgQPoUXbYCBXOHe3FxIq1EZTEkXQM7nwnI
 NaiapyjSxKYFBGm2BrO0pn0wJmfCjCFJGoLbR2XEr8wKhzNC3uBeRjb+c7hwZ4L7aUDd
 CxYYgG4MQ4s1t3FWrEUEaEx7ogb6V8BDFPlIOjn3PSu7g0CqxNI3sOFi2xJg/Svpcgb2
 Rn7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779186088; x=1779790888;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=U16zJTSnbffX1dN21R+EflW0v6/pU9yFvzxByHGVqc0=;
 b=gSMfx+grvuD4I7Bz/u/XN/W/EO+a8nOZYd9fobN2hKdk004abhwY9+pPqyTrh0s6GR
 FgjzmwczwssbgJ9qU/SYrtoyvxoU/kXAml48bk3e/0+c2Jm1DZvrTc+qKH6jgJ64orQ0
 9OZgO8uFIuvXe1NSw+LyiOG5HGn2SxqTTmf7MBTo+o2pVu/wThxy5FR4QGwbezXu7Iyq
 7ffqb6VVo+tyi/9CvyCq0iyDEhwYQ8YqW8FilKiaftRvUWTgb7w+17AdH30/0II1pZ7M
 J2Yco6QOQrc/ZWNxfAFwbv2bedQdfbeTP8y9jnn6uCIfcJsfPI53BsQ1ZeqQmmVCsZKq
 EiOg==
X-Gm-Message-State: AOJu0Yy5fFGKsoMxSBg5kpMIRuI55IqZxIXtuNZk/lECWHNv399zmEhP
 KsaW1z+2op1RrHiXy/RyFlyZJSebj6h8CC0QPm/+5SpbkBLQKDD7wZcQHx29yqkt
X-Gm-Gg: Acq92OGnjOZGva8wKMrFoRFIzW9JOJihksyY7ouVSGJi8/w5IAwrmbaUlGnuivXCSrj
 9xYPnZIUN7DI9VBYRznPLGLOAPJxK53sXzbScLMKugZJB11rT/GjhfZCYVQ7XMIsAdzBzkb45Yy
 FlLWrh1EfXR9WkVJ7Lps4hAD9bhHZ//uFUX9TUHmplU4hk/EgFWTdwC3P0R7EsKfb0LXvhhVZiP
 VNl/EVJLMxh95YPKzUwX6eSRXZw9MSwsC2pp9xCxZWp9/AGdfk8moTjp4H/XUQAVnxehUdXAsj/
 julUuLdhAOPd4kOrzQdBFt+XWYHwo7n2Yj4Ncdlz8Wt951jb9tCU6gve01JQokKsIF6xrHbtyp1
 +Hs68qrRLrwwLJTaiOsPonuN7Fi7SQSQwBL/945zcuF7E141uiYEZM7fbICebwNgJkZHifuwV4h
 v6wTWZHZUn2Md3xS4ICDCBJmrlFk/Bm9TS9CkK9oTd2wtyyvyyYQu+HwP2ov+r8x8l
X-Received: by 2002:a05:6000:2c03:b0:45e:7997:8b7a with SMTP id
 ffacd0b85a97d-45e79978bc7mr15731408f8f.16.1779186087392; 
 Tue, 19 May 2026 03:21:27 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe0fecsm41028224f8f.26.2026.05.19.03.21.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 03:21:27 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Melissa Wen <mwen@igalia.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Alex Hung <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 06/14] drm/amd/display: Delete max_clks_by_state from DCE
 clock manager (v2)
Date: Tue, 19 May 2026 12:21:10 +0200
Message-ID: <20260519102118.246466-7-timur.kristof@gmail.com>
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

It was not used by anything anymore.

Note that the parts of DC that need this information actually
already query it from the pplib and don't use the hardcoded
information from max_clks_by_state.

v2:
- Also delete state_dependent_clocks

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Melissa Wen <mwen@igalia.com>
---
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 71 -------------------
 .../dc/clk_mgr/dce110/dce110_clk_mgr.c        | 16 -----
 .../dc/clk_mgr/dce112/dce112_clk_mgr.c        | 17 -----
 .../dc/clk_mgr/dce120/dce120_clk_mgr.c        | 16 -----
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  8 ---
 5 files changed, 128 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index 978bbc307991..d891b3bfe2a1 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -62,32 +62,6 @@ static const struct clk_mgr_mask disp_clk_mask = {
 		CLK_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(_MASK)
 };
 
-/* Max clock values for each state indexed by "enum clocks_state": */
-static const struct state_dependent_clocks dce60_max_clks_by_state[] = {
-/* ClocksStateInvalid - should not be used */
-{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
-/* ClocksStateUltraLow - not expected to be used for DCE 6.0 */
-{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
-/* ClocksStateLow */
-{ .display_clk_khz = 352000, .pixel_clk_khz = 330000},
-/* ClocksStateNominal */
-{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 },
-/* ClocksStatePerformance */
-{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 } };
-
-/* Max clock values for each state indexed by "enum clocks_state": */
-static const struct state_dependent_clocks dce80_max_clks_by_state[] = {
-/* ClocksStateInvalid - should not be used */
-{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
-/* ClocksStateUltraLow - not expected to be used for DCE 8.0 */
-{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
-/* ClocksStateLow */
-{ .display_clk_khz = 352000, .pixel_clk_khz = 330000},
-/* ClocksStateNominal */
-{ .display_clk_khz = 625000, .pixel_clk_khz = 400000 },
-/* ClocksStatePerformance */
-{ .display_clk_khz = 625000, .pixel_clk_khz = 400000 } };
-
 unsigned int dentist_get_divider_from_did(unsigned int did)
 {
 	if (did < DENTIST_BASE_DID_1)
@@ -268,7 +242,6 @@ static void dce_clock_read_integrated_info(struct clk_mgr_internal *clk_mgr_dce)
 {
 	struct dc_debug_options *debug = &clk_mgr_dce->base.ctx->dc->debug;
 	struct dc_bios *bp = clk_mgr_dce->base.ctx->dc_bios;
-	int i;
 
 	if (bp->integrated_info)
 		clk_mgr_dce->base.dentist_vco_freq_khz = bp->integrated_info->dentist_vco_freq;
@@ -278,40 +251,6 @@ static void dce_clock_read_integrated_info(struct clk_mgr_internal *clk_mgr_dce)
 			clk_mgr_dce->base.dentist_vco_freq_khz = 3600000;
 	}
 
-	/*update the maximum display clock for each power state*/
-	for (i = 0; i < NUMBER_OF_DISP_CLK_VOLTAGE; ++i) {
-		enum dm_pp_clocks_state clk_state = DM_PP_CLOCKS_STATE_INVALID;
-
-		switch (i) {
-		case 0:
-			clk_state = DM_PP_CLOCKS_STATE_ULTRA_LOW;
-			break;
-
-		case 1:
-			clk_state = DM_PP_CLOCKS_STATE_LOW;
-			break;
-
-		case 2:
-			clk_state = DM_PP_CLOCKS_STATE_NOMINAL;
-			break;
-
-		case 3:
-			clk_state = DM_PP_CLOCKS_STATE_PERFORMANCE;
-			break;
-
-		default:
-			clk_state = DM_PP_CLOCKS_STATE_INVALID;
-			break;
-		}
-
-		/*Do not allow bad VBIOS/SBIOS to override with invalid values,
-		 * check for > 100MHz*/
-		if (bp->integrated_info)
-			if (bp->integrated_info->disp_clk_voltage[i].max_supported_clk >= 100000)
-				clk_mgr_dce->max_clks_by_state[clk_state].display_clk_khz =
-					bp->integrated_info->disp_clk_voltage[i].max_supported_clk;
-	}
-
 	if (!debug->disable_dfs_bypass && bp->integrated_info)
 		if (bp->integrated_info->gpu_cap_info & DFS_BYPASS_ENABLE)
 			clk_mgr_dce->dfs_bypass_enabled = true;
@@ -419,16 +358,6 @@ void dce_clk_mgr_construct(
 {
 	struct clk_mgr *base = &clk_mgr->base;
 
-	if (ctx->dce_version <= DCE_VERSION_6_4)
-		memcpy(clk_mgr->max_clks_by_state,
-			dce60_max_clks_by_state,
-			sizeof(dce60_max_clks_by_state));
-	else
-		memcpy(clk_mgr->max_clks_by_state,
-			dce80_max_clks_by_state,
-			sizeof(dce80_max_clks_by_state));
-
-
 	base->ctx = ctx;
 	base->funcs = &dce_funcs;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
index d3cd542063db..d52789ba2613 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
@@ -51,18 +51,6 @@ static const struct clk_mgr_mask disp_clk_mask = {
 		CLK_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(_MASK)
 };
 
-static const struct state_dependent_clocks dce110_max_clks_by_state[] = {
-/*ClocksStateInvalid - should not be used*/
-{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
-/*ClocksStateUltraLow - currently by HW design team not supposed to be used*/
-{ .display_clk_khz = 352000, .pixel_clk_khz = 330000 },
-/*ClocksStateLow*/
-{ .display_clk_khz = 352000, .pixel_clk_khz = 330000 },
-/*ClocksStateNominal*/
-{ .display_clk_khz = 467000, .pixel_clk_khz = 400000 },
-/*ClocksStatePerformance*/
-{ .display_clk_khz = 643000, .pixel_clk_khz = 400000 } };
-
 static uint32_t determine_sclk_from_bounding_box(
 		const struct dc *dc,
 		uint32_t required_sclk)
@@ -281,10 +269,6 @@ void dce110_clk_mgr_construct(
 {
 	dce_clk_mgr_construct(ctx, clk_mgr);
 
-	memcpy(clk_mgr->max_clks_by_state,
-		dce110_max_clks_by_state,
-		sizeof(dce110_max_clks_by_state));
-
 	clk_mgr->regs = &disp_clk_regs;
 	clk_mgr->clk_mgr_shift = &disp_clk_shift;
 	clk_mgr->clk_mgr_mask = &disp_clk_mask;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
index 0f3f8df4df96..08ed6f88025f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
@@ -53,19 +53,6 @@ static const struct clk_mgr_mask disp_clk_mask = {
 		CLK_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(_MASK)
 };
 
-static const struct state_dependent_clocks dce112_max_clks_by_state[] = {
-/*ClocksStateInvalid - should not be used*/
-{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
-/*ClocksStateUltraLow - currently by HW design team not supposed to be used*/
-{ .display_clk_khz = 389189, .pixel_clk_khz = 346672 },
-/*ClocksStateLow*/
-{ .display_clk_khz = 459000, .pixel_clk_khz = 400000 },
-/*ClocksStateNominal*/
-{ .display_clk_khz = 667000, .pixel_clk_khz = 600000 },
-/*ClocksStatePerformance*/
-{ .display_clk_khz = 1132000, .pixel_clk_khz = 600000 } };
-
-
 //TODO: remove use the two broken down functions
 int dce112_set_clock(struct clk_mgr *clk_mgr_base, int requested_clk_khz)
 {
@@ -202,10 +189,6 @@ void dce112_clk_mgr_construct(
 {
 	dce_clk_mgr_construct(ctx, clk_mgr);
 
-	memcpy(clk_mgr->max_clks_by_state,
-		dce112_max_clks_by_state,
-		sizeof(dce112_max_clks_by_state));
-
 	clk_mgr->regs = &disp_clk_regs;
 	clk_mgr->clk_mgr_shift = &disp_clk_shift;
 	clk_mgr->clk_mgr_mask = &disp_clk_mask;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce120/dce120_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce120/dce120_clk_mgr.c
index c9ba7b3fd2c3..f8ef3a4710fc 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce120/dce120_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce120/dce120_clk_mgr.c
@@ -32,18 +32,6 @@
 #include "dce100/dce_clk_mgr.h"
 #include "dce120/dce120_hwseq.h"
 
-static const struct state_dependent_clocks dce120_max_clks_by_state[] = {
-/*ClocksStateInvalid - should not be used*/
-{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
-/*ClocksStateUltraLow - currently by HW design team not supposed to be used*/
-{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
-/*ClocksStateLow*/
-{ .display_clk_khz = 460000, .pixel_clk_khz = 400000 },
-/*ClocksStateNominal*/
-{ .display_clk_khz = 670000, .pixel_clk_khz = 600000 },
-/*ClocksStatePerformance*/
-{ .display_clk_khz = 1133000, .pixel_clk_khz = 600000 } };
-
 /**
  * dce121_clock_patch_xgmi_ss_info() - Save XGMI spread spectrum info
  * @clk_mgr_dce: clock manager internal structure
@@ -129,10 +117,6 @@ void dce120_clk_mgr_construct(struct dc_context *ctx, struct clk_mgr_internal *c
 {
 	dce_clk_mgr_construct(ctx, clk_mgr);
 
-	memcpy(clk_mgr->max_clks_by_state,
-		dce120_max_clks_by_state,
-		sizeof(dce120_max_clks_by_state));
-
 	clk_mgr->base.dprefclk_khz = 600000;
 	clk_mgr->base.funcs = &dce120_funcs;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index e01bf6bd7f3f..450bce3d8e02 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -405,12 +405,6 @@ enum clock_type {
 	clock_type_dtbclk,
 };
 
-
-struct state_dependent_clocks {
-	int display_clk_khz;
-	int pixel_clk_khz;
-};
-
 struct clk_mgr_internal {
 	struct clk_mgr base;
 	int smu_ver;
@@ -429,8 +423,6 @@ struct clk_mgr_internal {
 	const struct clk_mgr_shift *clk_mgr_shift;
 	const struct clk_mgr_mask *clk_mgr_mask;
 
-	struct state_dependent_clocks max_clks_by_state[DM_PP_CLOCKS_MAX_STATES];
-
 	/*TODO: figure out which of the below fields should be here vs in asic specific portion */
 	/* Cache the status of DFS-bypass feature*/
 	bool dfs_bypass_enabled;
-- 
2.54.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B21DDD4A5F4
	for <amd-gfx@archiver.kernel.org>; Sun, 18 Jan 2026 17:32:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F75210E2E4;
	Sun, 18 Jan 2026 17:32:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BNgVBMLK";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E1D2410E2D8
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 17:31:58 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-64b921d9e67so5987086a12.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 18 Jan 2026 09:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768757517; x=1769362317; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QP5W03q4k2YPgLxe28s5gIjJCZJKhVjZZAA2CzJRCSE=;
 b=BNgVBMLKPzlQ3GfDpMuzVPd+GM3LRHt9hwrtlQVAYZ6pGehVA+760wqGKT5YvMo4jK
 ux03jIBPnH4nEkD6HETDSNtnU/AywRugLlFhALa0MvbDDfWULxAt1rf8IpT2IJmGfWEy
 8o6B4BTvXH5MX+avU4FMRLTKnZEfvL0W/5NUKD0Qiy/Ro+tqQVQ2698et6ZNEsFo/HFb
 weO1z/Y7EaMzo+1TlkjacX1BQnRge5cCqCIsxjjXjdnNIPcyzGq/Zr4ZHQj+/P1FL/N8
 aV1/Htq/+ey34hZO75HcK/XdVu+7WCM9plVrU27jZFzJHeO0mFQ7gRsYg3blukD/HaOJ
 GhAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768757517; x=1769362317;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QP5W03q4k2YPgLxe28s5gIjJCZJKhVjZZAA2CzJRCSE=;
 b=mkRW2x4GSZqLmI1A/7HKML6xhxBgISXH1rqiCZ6tGONh4I1RPg8jaThS4JR9XywTIH
 ELvWXw8QUKJh2/bVLIDHQGIl8AkFqVyVytbaYY3egcfbr/6c2r/Oasm35G7kYmyoImot
 VpTSgy+wCOiDuOXJ3YBpyRsyG8nAN016CVVQUSeooMLQkFOt1+9CBtbbeeQATbw70H4g
 dUKj0mTGIwu8H0RK8YRvFHmyUgyfYCneQZCRJRZE5lYD4L12G5c7wO6QdoyONrdXJ4cJ
 aPGR12YCl4do5AxtjSdGAZar8Bz1uphjmEijfQ9YKKRKOdsdIAmYrFECzyOh28ayZB+g
 Zu6w==
X-Gm-Message-State: AOJu0Yyu1afGP0sRgOz+wWFxdTjmhtlmCqMNJ6uKTgfiphzWxu1frEvY
 /XsnHQlHkCxFnMi08+knZfzSnrwlzl2+zGGQFUfqvzh3kQxOq58hWCBiC5Snrg==
X-Gm-Gg: AY/fxX7WI26yzemcWkeK4YhdH0x6uFLg1YmUrCNvoUCFPdDc1NvDc5k6unpB/iYidIK
 UCijiqoMu8ej2/HM7pgJuVsCfKF+4NEQvwOUoxRtgwqEU28d7RFnqWIXoqdTz6xAjKowmulF2z0
 QK2q3ySFKEk34oW/c0iuj/GZbJiAZfWpeTNQ/iBtrvJ8/Gk8gY0y+6nmo+rfdDiPE3VEHHBjIhy
 PlQG7S3hPmWhhZu+zFQWHesjhvp1CwqEwTiamJty2pAZaZ6CXt7DN7bTLuwPE+rE64CPjs4lNo9
 z1BFksX4h7SJ19YQoCQ1T7jV++arrOnElm4WkKOsd/wmN29A9QXyZLGYTkyiQn72qyNid39A3zx
 k6fB6tP4B58yttm+FU7R+EVKJ667J6cI2rtkyAos/YEUFIvtCbW+oZiDTlo6CiSX94jbNFHpHHi
 f1wXt8LxF24NWA6Wf6nOzdvAemn2uRxLBGR+7ckTpNqfuSr3bnpTLN1xqXI7rP0Q3cllCpXFsQb
 m9Nt57n8QBO
X-Received: by 2002:a17:907:94c3:b0:b73:4fbb:37a2 with SMTP id
 a640c23a62f3a-b87968d1791mr801082466b.5.1768757517175; 
 Sun, 18 Jan 2026 09:31:57 -0800 (PST)
Received: from Timur-Hyperion
 (20014C4E24E47400AD77F2CC91C9A6FE.dsl.pool.telekom.hu.
 [2001:4c4e:24e4:7400:ad77:f2cc:91c9:a6fe])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b879513e735sm876868466b.13.2026.01.18.09.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 09:31:56 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, harry.wentland@amd.com,
 Leo Li <sunpeng.li@amd.com>, Alex Hung <alex.hung@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/5] drm/amd/display: Handle DCE 6 in dce_clk_mgr.c
Date: Sun, 18 Jan 2026 18:31:49 +0100
Message-ID: <20260118173150.19790-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260118173150.19790-1-timur.kristof@gmail.com>
References: <20260118173150.19790-1-timur.kristof@gmail.com>
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

dce60_clk_mgr was basically identical to dce_clk_mgr other than
a few minor details. They can be all handled in the same file,
reducing duplicated code and easing the maintenance burden for
old DCE versions.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c  |  12 +-
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |  64 ++++++--
 .../display/dc/clk_mgr/dce60/dce60_clk_mgr.c  | 142 ------------------
 .../display/dc/clk_mgr/dce60/dce60_clk_mgr.h  |  36 -----
 4 files changed, 52 insertions(+), 202 deletions(-)
 delete mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
 delete mode 100644 drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
index 15cf13ec5302..9206eb8b0365 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/clk_mgr.c
@@ -34,7 +34,6 @@
 #include "dce110/dce110_clk_mgr.h"
 #include "dce112/dce112_clk_mgr.h"
 #include "dce120/dce120_clk_mgr.h"
-#include "dce60/dce60_clk_mgr.h"
 #include "dcn10/rv1_clk_mgr.h"
 #include "dcn10/rv2_clk_mgr.h"
 #include "dcn20/dcn20_clk_mgr.h"
@@ -150,16 +149,7 @@ struct clk_mgr *dc_clk_mgr_create(struct dc_context *ctx, struct pp_smu_funcs *p
 
 	switch (asic_id.chip_family) {
 #if defined(CONFIG_DRM_AMD_DC_SI)
-	case FAMILY_SI: {
-		struct clk_mgr_internal *clk_mgr = kzalloc(sizeof(*clk_mgr), GFP_KERNEL);
-
-		if (clk_mgr == NULL) {
-			BREAK_TO_DEBUGGER();
-			return NULL;
-		}
-		dce60_clk_mgr_construct(ctx, clk_mgr);
-		return &clk_mgr->base;
-	}
+	case FAMILY_SI:
 #endif
 	case FAMILY_CI:
 	case FAMILY_KV: {
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index 6131ede2db7a..d02d03c154b3 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -62,6 +62,18 @@ static const struct clk_mgr_mask disp_clk_mask = {
 		CLK_COMMON_MASK_SH_LIST_DCE_COMMON_BASE(_MASK)
 };
 
+/* Max clock values for each state indexed by "enum clocks_state": */
+static const struct state_dependent_clocks dce60_max_clks_by_state[] = {
+/* ClocksStateInvalid - should not be used */
+{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
+/* ClocksStateUltraLow - not expected to be used for DCE 6.0 */
+{ .display_clk_khz = 0, .pixel_clk_khz = 0 },
+/* ClocksStateLow */
+{ .display_clk_khz = 352000, .pixel_clk_khz = 330000},
+/* ClocksStateNominal */
+{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 },
+/* ClocksStatePerformance */
+{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 } };
 
 /* Max clock values for each state indexed by "enum clocks_state": */
 static const struct state_dependent_clocks dce80_max_clks_by_state[] = {
@@ -126,8 +138,25 @@ int dce_adjust_dp_ref_freq_for_ss(struct clk_mgr_internal *clk_mgr_dce, int dp_r
 	return dp_ref_clk_khz;
 }
 
+static int dce60_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	struct dc_context *ctx = clk_mgr_base->ctx;
+	int dp_ref_clk_khz = 0;
+
+	if (ASIC_REV_IS_TAHITI_P(ctx->asic_id.hw_internal_rev))
+		dp_ref_clk_khz = ctx->dc_bios->fw_info.default_display_engine_pll_frequency;
+	else
+		dp_ref_clk_khz = clk_mgr_base->clks.dispclk_khz;
+
+	return dce_adjust_dp_ref_freq_for_ss(clk_mgr, dp_ref_clk_khz);
+}
+
 int dce_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
 {
+	if (clk_mgr_base->ctx->dce_version <= DCE_VERSION_6_4)
+		return dce60_get_dp_ref_freq_khz(clk_mgr_base);
+
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	int dprefclk_wdivider;
 	int dprefclk_src_sel;
@@ -441,27 +470,37 @@ void dce_clk_mgr_construct(
 	struct clk_mgr *base = &clk_mgr->base;
 	struct dm_pp_static_clock_info static_clk_info = {0};
 
-	memcpy(clk_mgr->max_clks_by_state,
-		dce80_max_clks_by_state,
-		sizeof(dce80_max_clks_by_state));
+	if (ctx->dce_version <= DCE_VERSION_6_4)
+		memcpy(clk_mgr->max_clks_by_state,
+			dce60_max_clks_by_state,
+			sizeof(dce60_max_clks_by_state));
+	else
+		memcpy(clk_mgr->max_clks_by_state,
+			dce80_max_clks_by_state,
+			sizeof(dce80_max_clks_by_state));
+
 
 	base->ctx = ctx;
 	base->funcs = &dce_funcs;
 
-	clk_mgr->regs = &disp_clk_regs;
-	clk_mgr->clk_mgr_shift = &disp_clk_shift;
-	clk_mgr->clk_mgr_mask = &disp_clk_mask;
-	clk_mgr->dfs_bypass_disp_clk = 0;
+	if (ctx->dce_version >= DCE_VERSION_8_0) {
+		clk_mgr->regs = &disp_clk_regs;
+		clk_mgr->clk_mgr_shift = &disp_clk_shift;
+		clk_mgr->clk_mgr_mask = &disp_clk_mask;
+	}
 
+	clk_mgr->dfs_bypass_disp_clk = 0;
 	clk_mgr->dprefclk_ss_percentage = 0;
 	clk_mgr->dprefclk_ss_divider = 1000;
 	clk_mgr->ss_on_dprefclk = false;
 
-	if (dm_pp_get_static_clocks(ctx, &static_clk_info))
-		clk_mgr->max_clks_state = static_clk_info.max_clocks_state;
-	else
-		clk_mgr->max_clks_state = DM_PP_CLOCKS_STATE_NOMINAL;
-	clk_mgr->cur_min_clks_state = DM_PP_CLOCKS_STATE_INVALID;
+	if (ctx->dce_version >= DCE_VERSION_8_0) {
+		if (dm_pp_get_static_clocks(ctx, &static_clk_info))
+			clk_mgr->max_clks_state = static_clk_info.max_clocks_state;
+		else
+			clk_mgr->max_clks_state = DM_PP_CLOCKS_STATE_NOMINAL;
+		clk_mgr->cur_min_clks_state = DM_PP_CLOCKS_STATE_INVALID;
+	}
 
 	base->clks.max_supported_dispclk_khz =
 		clk_mgr->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
@@ -469,4 +508,3 @@ void dce_clk_mgr_construct(
 	dce_clock_read_integrated_info(clk_mgr);
 	dce_clock_read_ss_info(clk_mgr);
 }
-
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
deleted file mode 100644
index 1fdf344efe1a..000000000000
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
+++ /dev/null
@@ -1,142 +0,0 @@
-/*
- * Copyright 2020 Mauro Rossi <issor.oruam@gmail.com>
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
-
-
-#include "dccg.h"
-#include "clk_mgr_internal.h"
-#include "dce100/dce_clk_mgr.h"
-#include "dce110/dce110_clk_mgr.h"
-#include "dce60_clk_mgr.h"
-#include "reg_helper.h"
-#include "dmcu.h"
-#include "core_types.h"
-#include "dal_asic_id.h"
-
-/*
- * Currently the register shifts and masks in this file are used for dce60
- * which has no DPREFCLK_CNTL register
- * TODO: remove this when DENTIST_DISPCLK_CNTL
- * is moved to dccg, where it belongs
- */
-#include "dce/dce_6_0_d.h"
-#include "dce/dce_6_0_sh_mask.h"
-
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
-static int dce60_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
-{
-	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	struct dc_context *ctx = clk_mgr_base->ctx;
-	int dp_ref_clk_khz = 0;
-
-	if (ASIC_REV_IS_TAHITI_P(ctx->asic_id.hw_internal_rev))
-		dp_ref_clk_khz = ctx->dc_bios->fw_info.default_display_engine_pll_frequency;
-	else
-		dp_ref_clk_khz = clk_mgr_base->clks.dispclk_khz;
-
-	return dce_adjust_dp_ref_freq_for_ss(clk_mgr, dp_ref_clk_khz);
-}
-
-static void dce60_pplib_apply_display_requirements(
-	struct dc *dc,
-	struct dc_state *context)
-{
-	struct dm_pp_display_configuration *pp_display_cfg = &context->pp_display_cfg;
-
-	dce110_fill_display_configs(context, pp_display_cfg);
-
-	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
-		dm_pp_apply_display_requirements(dc->ctx, pp_display_cfg);
-}
-
-static void dce60_update_clocks(struct clk_mgr *clk_mgr_base,
-			struct dc_state *context,
-			bool safe_to_lower)
-{
-	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	struct dm_pp_power_level_change_request level_change_req;
-	const int max_disp_clk =
-		clk_mgr_dce->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
-	int patched_disp_clk = MIN(max_disp_clk, context->bw_ctx.bw.dce.dispclk_khz);
-
-	level_change_req.power_level = dce_get_required_clocks_state(clk_mgr_base, context);
-	/* get max clock state from PPLIB */
-	if ((level_change_req.power_level < clk_mgr_dce->cur_min_clks_state && safe_to_lower)
-			|| level_change_req.power_level > clk_mgr_dce->cur_min_clks_state) {
-		if (dm_pp_apply_power_level_change_request(clk_mgr_base->ctx, &level_change_req))
-			clk_mgr_dce->cur_min_clks_state = level_change_req.power_level;
-	}
-
-	if (should_set_clock(safe_to_lower, patched_disp_clk, clk_mgr_base->clks.dispclk_khz)) {
-		patched_disp_clk = dce_set_clock(clk_mgr_base, patched_disp_clk);
-		clk_mgr_base->clks.dispclk_khz = patched_disp_clk;
-	}
-	dce60_pplib_apply_display_requirements(clk_mgr_base->ctx->dc, context);
-}
-
-
-
-
-
-
-
-
-static struct clk_mgr_funcs dce60_funcs = {
-	.get_dp_ref_clk_frequency = dce60_get_dp_ref_freq_khz,
-	.update_clocks = dce60_update_clocks
-};
-
-void dce60_clk_mgr_construct(
-		struct dc_context *ctx,
-		struct clk_mgr_internal *clk_mgr)
-{
-	struct clk_mgr *base = &clk_mgr->base;
-
-	dce_clk_mgr_construct(ctx, clk_mgr);
-
-	memcpy(clk_mgr->max_clks_by_state,
-		dce60_max_clks_by_state,
-		sizeof(dce60_max_clks_by_state));
-
-	clk_mgr->regs = NULL;
-	clk_mgr->clk_mgr_shift = NULL;
-	clk_mgr->clk_mgr_mask = NULL;
-	clk_mgr->base.funcs = &dce60_funcs;
-
-	base->clks.max_supported_dispclk_khz =
-		clk_mgr->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
-}
-
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h
deleted file mode 100644
index eca3e5168089..000000000000
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.h
+++ /dev/null
@@ -1,36 +0,0 @@
-/*
- * Copyright 2020 Mauro Rossi <issor.oruam@gmail.com>
- *
- * Permission is hereby granted, free of charge, to any person obtaining a
- * copy of this software and associated documentation files (the "Software"),
- * to deal in the Software without restriction, including without limitation
- * the rights to use, copy, modify, merge, publish, distribute, sublicense,
- * and/or sell copies of the Software, and to permit persons to whom the
- * Software is furnished to do so, subject to the following conditions:
- *
- * The above copyright notice and this permission notice shall be included in
- * all copies or substantial portions of the Software.
- *
- * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
- * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
- * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
- * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
- * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
- * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
- * OTHER DEALINGS IN THE SOFTWARE.
- *
- * Authors: AMD
- *
- */
-
-
-#ifndef DAL_DC_DCE_DCE60_CLK_MGR_H_
-#define DAL_DC_DCE_DCE60_CLK_MGR_H_
-
-#include "dc.h"
-
-void dce60_clk_mgr_construct(
-		struct dc_context *ctx,
-		struct clk_mgr_internal *clk_mgr_dce);
-
-#endif /* DAL_DC_DCE_DCE60_CLK_MGR_H_ */
-- 
2.52.0


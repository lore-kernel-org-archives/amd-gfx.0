Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 347FCFDEE45
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 19:15:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C625D10F260;
	Thu, 23 Apr 2026 19:15:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SqN4FdAb";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D0F410F260
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 19:15:30 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-43d77f60944so5552039f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 12:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776971729; x=1777576529; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IRG3OpRi657DkcBZjfY1NMClyATmtLIMEeUDxf99h4I=;
 b=SqN4FdAbXrc2lj0DZ44uCSi2z5Guo8T/Fu5EdJqpGEwo8nHpSoZFyOC+zLyblJH4A6
 FnkLJgbLEo35n6XpQRh2S8ChR1WlZUu69vvWNt+DmLgqNfY1EO1eoFLTTZnsrmkBMLS9
 saSfgky3vEv77v8nZ3FK7tuNn4q3nTsShpPrZCEJ1qF/CaBmH+/HqotCaIhoqRG3QAwv
 +Eh9zKgevi8kiHaCthzLPutTJD4cXzAKE7mgkNFS64u+op3FrP0DSDUW/nTTy2hFF38y
 DSepRbaybPxgjp6VvXtQ1oT7dZ12ejRqhEypua551BkdT6QHJQcLPaFsjNiD5ca2E/Zl
 rLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776971729; x=1777576529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IRG3OpRi657DkcBZjfY1NMClyATmtLIMEeUDxf99h4I=;
 b=K/rPzxU2wEzQYJMWszI5/Vy/fO53pcrdn1Rv/L+wuB7gWCYdyhLvTjAKPn0NlJjBqa
 Iex+b1ZmCFblGz/0Ums/jA5es/ldSBxu4W5RaNoXXHT3rgfJYme59nGyf8j5eXoaqYOw
 cRj1ULNDLTMvfrkBtWsqKlbrW7S0zaLUFBqRmxWuyCmD+j/MEOcbgKfuNmuptMHnFtL+
 cnA20nrgXR0xiYixjY9+5E0GBioC1dCLg1GyjFQjG/NmHxWcJNdazwNvHtYH6O/oHCUz
 phUZw6BP+ew3tndeDmFZA35iJUtvCA96eH28rbyQcWyDmzZQGCIBk3AuInO4YZsL0Ci+
 Yt4A==
X-Gm-Message-State: AOJu0YxUsVxCXAe6rZ5UUGD38uesdhYvy4S0vM4B+qFdAq6ivi+VBh/U
 HNtIt+xlX8/cQu13CZZJs6nl9/uws9cVCA1yKK4+7Ai/AidP/rSbLhmld3bp16OX
X-Gm-Gg: AeBDievtD6TWc/cjexnfnUH4wcZjGu8byV0TKk/fnJn7M2L6JCRuz9y+PQSkVJCilqB
 hozjgumSZTldhO8sdFkCLu8pLPA6ZN1ibRlUJz0+GJGSi79r68Fa3Cg/aKsikeh/aS9kOVee0Gd
 kxp7ztJhZKIKSmx382ushRuJ5Pb447936LIz8p+K++Gqr5SbKowr9EZu47Ls6caq6+Dq6PBBiMr
 r05g66wCL8eQZOOWGkKRvAetN1ftoiO9ByH2OmYT7w0MR+dsQbfZC1LeEwdZGTY0gfS2eqMC2pk
 AtOGhTgGjlivwujnDTRrzG+uLtUtOhdLV5S0GUhVPfVSiWHQnpmaGBaVzR5dJTR8xod0RYcEkx2
 /HrAc17kdaaIlHDcVcOCpFhJ9cfgIuDYTjBA6plgzpuM69jdDvyP/u9Vr5ShQQWfEeTBwdtdznM
 a9PBbTML6fHanvHHcnYH4p4+8jNCjNxOi/wtZ/GAFwB+IzzK9hb7df+mQDiYlpWlVJVbQd6pWs2
 g5lBg==
X-Received: by 2002:a5d:4350:0:b0:43f:e721:76b8 with SMTP id
 ffacd0b85a97d-43fe72178cbmr31648153f8f.37.1776971728820; 
 Thu, 23 Apr 2026 12:15:28 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm15792782f8f.15.2026.04.23.12.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:15:28 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 06/14] drm/amd/display: Delete max_clks_by_state from DCE
 clock manager
Date: Thu, 23 Apr 2026 21:15:11 +0200
Message-ID: <20260423191519.73127-7-timur.kristof@gmail.com>
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

It was not used by anything anymore.

Note that the parts of DC that need this information actually
already query it from the pplib and don't use the hardcoded
information from max_clks_by_state.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 71 -------------------
 .../dc/clk_mgr/dce110/dce110_clk_mgr.c        | 16 -----
 .../dc/clk_mgr/dce112/dce112_clk_mgr.c        | 17 -----
 .../dc/clk_mgr/dce120/dce120_clk_mgr.c        | 16 -----
 .../amd/display/dc/inc/hw/clk_mgr_internal.h  |  2 -
 5 files changed, 122 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index bef9a72f3382f..4303a42a7fe37 100644
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
 int dentist_get_divider_from_did(int did)
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
index ae922f1a31ff8..6144c03e14207 100644
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
 static int determine_sclk_from_bounding_box(
 		const struct dc *dc,
 		int required_sclk)
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
index 0f3f8df4df96a..08ed6f88025fa 100644
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
index c9ba7b3fd2c32..f8ef3a4710fc2 100644
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
index e01bf6bd7f3f4..5accf076a3747 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -429,8 +429,6 @@ struct clk_mgr_internal {
 	const struct clk_mgr_shift *clk_mgr_shift;
 	const struct clk_mgr_mask *clk_mgr_mask;
 
-	struct state_dependent_clocks max_clks_by_state[DM_PP_CLOCKS_MAX_STATES];
-
 	/*TODO: figure out which of the below fields should be here vs in asic specific portion */
 	/* Cache the status of DFS-bypass feature*/
 	bool dfs_bypass_enabled;
-- 
2.53.0


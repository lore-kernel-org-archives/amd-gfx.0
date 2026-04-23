Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF446FDEE47
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 19:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 88B8110F24F;
	Thu, 23 Apr 2026 19:15:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SeH0Vrbm";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A60710F24F
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 19:15:27 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-488b3f8fa2bso70845325e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 12:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776971726; x=1777576526; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PyzjHn1+4x3a8NDfXNzldgyxCZU5mudONlR0gNcG9B8=;
 b=SeH0VrbmXy121L4vWcQ5MtJw36QcW7Cs1AT1aFIq+bM3YL4tTzYOynr5WvytwOiW49
 oSibl+lE2LfYl5g5X9k+MexuCVm9ILrVAFuukjzJVosgPEQPr13Jwj5CPcuLsGe5zMZa
 HGBNwS3NHM3Vikfq8fR0Vf2RJ6sS8Pru3IO0Y8I7lSXO+WpqTY40T9lisEehzM7ZJ5RI
 d+nmVlU0gofZkYr+GWPW6wyxEDyrwodU0Jxe7w4Ga2zJ76qwcDyXO7LyrrcA15XfHaHk
 FNNKe5X1O89qS8EIgZ7RUC4ZKRihNPecNXJVKWIEkibDsdFKegt6npxk0iPHBir6C9c1
 uQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776971726; x=1777576526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PyzjHn1+4x3a8NDfXNzldgyxCZU5mudONlR0gNcG9B8=;
 b=qhjBGYiJsa1Ukdt+1eM/4AYMaOy5xVjXqmxAm7TUBVc49ElZidyyJ3GHGLm5b39G6w
 lfKVRkFCXS86eCsJZQ4Vof2hVx6APGmrRmIawfc00Ki842yfAxywHPhjf5LEILdmuXqz
 joSLTAUqEqETstUZyv9/eQM1HQerBgOoM7ZiOn84+5V1Tx1iI5rZx6ceuzhYy9UQZTEx
 ZrygMH8r2i2HrOO6LVgJ//otG7tdCWujJomgBxKA8A3mmiFpTK2Nz4oMEWRN9b36qFc6
 SCZv+WtEfGhwCn45aRJnkFIR7lSJSYeaMui3+nho3rGBne4iiXgkp8UMUVfwQfLUU8+r
 3Fww==
X-Gm-Message-State: AOJu0YznyK63p+mSeAl/5s5G7FT7SZoa/CWOUgwVEY80YuuEwKbvcCL+
 F7lJpfQRAZZfOOV/3UoEPRLgwu7caGo3PW5e3qPyJNO/rpCIBYxsl2ih0JRPPjW7
X-Gm-Gg: AeBDieu9L8JmQtMJTQjZkXv+5TE+ne0coRRwPBqFNG4uarYugOBcqotJN4Y6KoEYjEX
 kpcY1MduWtRWkRyx3qKx+POfdImqDIZrbiSzJlkCY3DXY79NUULOnlkaoB+UXIHHhp171SoMI2E
 hI7CWAV+go9CmFrvSzyjN4M1FeDozNrnaAmbB30Zmrm6cI81BRIRS9RNP71Kv12wko5mMFYbMCD
 OExqI9kjrnTH1h/3JQoRqm13NQeWw6yOAmP3VADFGIHqLnwhU2oT+Gpd+FSyuwf3HqGfiJLFxtI
 Ykkge2S1augqq/QpyYAAzmtPDpn+73gr9HUiuSFNTUxNKY4qn/788ECSuytjG6qWoimAZkEk5IM
 xkynOW1ViUXlMIYvx6mIOXCQZ6OK98rnIvaqa6yuqiSpUKL2lbngBrhfCVhytuIayRZTFhcXa9D
 xPFK6mklhEBCnhDoqBv7RYYY0wBl+g7WsDkp/j3oe29E7vXNm91Uj3O5BlaVjZh6NX3UPh6F+HL
 nI0MA==
X-Received: by 2002:a05:600c:a410:b0:48a:5821:6006 with SMTP id
 5b1f17b1804b1-48a5821692dmr143202705e9.4.1776971725738; 
 Thu, 23 Apr 2026 12:15:25 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm15792782f8f.15.2026.04.23.12.15.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:15:25 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 03/14] drm/amd/display: Remove min/max clock levels from
 clk_mgr
Date: Thu, 23 Apr 2026 21:15:08 +0200
Message-ID: <20260423191519.73127-4-timur.kristof@gmail.com>
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

These fields are not used by anything anymore.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 14 --------------
 .../display/dc/clk_mgr/dce112/dce112_clk_mgr.c    | 15 ---------------
 .../drm/amd/display/dc/inc/hw/clk_mgr_internal.h  |  2 --
 3 files changed, 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index 988eb6f841f54..2ba341df7fffd 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -257,11 +257,6 @@ int dce_set_clock(
 		actual_clock = pxl_clk_params.dfs_bypass_display_clock;
 	}
 
-	/* from power down, we need mark the clock state as ClocksStateNominal
-	 * from HWReset, so when resume we will call pplib voltage regulator.*/
-	if (requested_clk_khz == 0)
-		clk_mgr_dce->cur_min_clks_state = DM_PP_CLOCKS_STATE_NOMINAL;
-
 	if (dmcu && dmcu->funcs->is_dmcu_initialized(dmcu))
 		dmcu->funcs->set_psr_wait_loop(dmcu, actual_clock / 1000 / 7);
 
@@ -425,7 +420,6 @@ void dce_clk_mgr_construct(
 		struct clk_mgr_internal *clk_mgr)
 {
 	struct clk_mgr *base = &clk_mgr->base;
-	struct dm_pp_static_clock_info static_clk_info = {0};
 
 	if (ctx->dce_version <= DCE_VERSION_6_4)
 		memcpy(clk_mgr->max_clks_by_state,
@@ -451,14 +445,6 @@ void dce_clk_mgr_construct(
 	clk_mgr->dprefclk_ss_divider = 1000;
 	clk_mgr->ss_on_dprefclk = false;
 
-	if (ctx->dce_version >= DCE_VERSION_8_0) {
-		if (dm_pp_get_static_clocks(ctx, &static_clk_info))
-			clk_mgr->max_clks_state = static_clk_info.max_clocks_state;
-		else
-			clk_mgr->max_clks_state = DM_PP_CLOCKS_STATE_NOMINAL;
-		clk_mgr->cur_min_clks_state = DM_PP_CLOCKS_STATE_INVALID;
-	}
-
 	base->clks.max_supported_dispclk_khz =
 		clk_mgr->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
 
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
index 48393c69735b6..0f3f8df4df96a 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce112/dce112_clk_mgr.c
@@ -89,13 +89,6 @@ int dce112_set_clock(struct clk_mgr *clk_mgr_base, int requested_clk_khz)
 	bp->funcs->set_dce_clock(bp, &dce_clk_params);
 	actual_clock = dce_clk_params.target_clock_frequency;
 
-	/*
-	 * from power down, we need mark the clock state as ClocksStateNominal
-	 * from HWReset, so when resume we will call pplib voltage regulator.
-	 */
-	if (requested_clk_khz == 0)
-		clk_mgr_dce->cur_min_clks_state = DM_PP_CLOCKS_STATE_NOMINAL;
-
 	/*Program DP ref Clock*/
 	/*VBIOS will determine DPREFCLK frequency, so we don't set it*/
 	dce_clk_params.target_clock_frequency = 0;
@@ -143,14 +136,6 @@ int dce112_set_dispclk(struct clk_mgr_internal *clk_mgr, int requested_clk_khz)
 	bp->funcs->set_dce_clock(bp, &dce_clk_params);
 	actual_clock = dce_clk_params.target_clock_frequency;
 
-	/*
-	 * from power down, we need mark the clock state as ClocksStateNominal
-	 * from HWReset, so when resume we will call pplib voltage regulator.
-	 */
-	if (requested_clk_khz == 0)
-		clk_mgr->cur_min_clks_state = DM_PP_CLOCKS_STATE_NOMINAL;
-
-
 	if (dmcu && dmcu->funcs->is_dmcu_initialized(dmcu)) {
 		if (clk_mgr->dfs_bypass_disp_clk != actual_clock)
 			dmcu->funcs->set_psr_wait_loop(dmcu,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
index c69ccfcebeb5a..e01bf6bd7f3f4 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/clk_mgr_internal.h
@@ -477,8 +477,6 @@ struct clk_mgr_internal {
 	 */
 	int dprefclk_ss_divider;
 
-	enum dm_pp_clocks_state max_clks_state;
-	enum dm_pp_clocks_state cur_min_clks_state;
 	bool periodic_retraining_disabled;
 
 	unsigned int cur_phyclk_req_table[MAX_LINKS];
-- 
2.53.0


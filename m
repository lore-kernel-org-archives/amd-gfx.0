Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21445CD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 10:21:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9D72410EBF2;
	Tue, 19 May 2026 10:21:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L7YhoqYw";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C558110E11D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 10:21:24 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-43d75312379so2905997f8f.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 03:21:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779186083; x=1779790883; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/5h6+/8MJZa6Cby2pmNL+RCgWakAl+Bq919J1iD/4d8=;
 b=L7YhoqYwrKyFEWgTVOd6WzNQLkUNxx8hEJ8Ui8xAjeBBZQh4LQ7T4JxhMH7rkL+l8t
 xvuw1ZSbb7n3AzyFNup2LuehjcdehiRXYfkzQZKq9rKJwTCA3QTF2+oV2oUXbDdSWGP9
 wpFMsBiE3aKQzIVs18fMVcUdZuRCwAaKLIzPHVZ/TzTie0B8gQBk6NrGV0eOzk/W/YwP
 ftwygU2I+A8nPCIHb+olddWaCYzoDADlNR+ekMKqftSgaXisuEqTMjFo7hulvNuyBfbt
 qdoazXg4lY3x8OelYA9f0BFBM1dHwWtzbFxKzNEPniAzGtSNsB85zp91Di6xmR2+tzBG
 1CTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779186083; x=1779790883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/5h6+/8MJZa6Cby2pmNL+RCgWakAl+Bq919J1iD/4d8=;
 b=G6asrhVN6Qzn6qTO+GKskvxllSjAEDPpkn+hyh+JusqK6ZGo/Us3gV5sef2w5lnh/s
 vCKX13Td8swp6WKywBbOsvyy2U7zLwjWlC/2NB1Vv2WewsvoU/oiWdUu4DYVk3bioSla
 9e9Ohwbu45Cht+0iAaIJfycQSMOxsXRTciJD/374B4xRy20L93DZG5yWahMSYfp57JP7
 ZB7+tMQKklBQuwrOX63qUi5WkS+Ll+GcDAi7phOlcU7SdzAHEAGpCpW0Z7+3afMSvXME
 9Y7951sgkTz8Zd0v6GkMhHtdozFaY0sGofk5Ore6L5fSLvfAi/Tyu/aAV/Hdh4tKivc2
 jqaw==
X-Gm-Message-State: AOJu0YwiIhDFDbBm8KvCc7C7p+JgzWqviYoW4LkBm1+jfyb3KYNAPRl6
 5w7M6EVV+1bftDeF+icwjSw3ysiBncr+oR7vm6j0lbHxgxynLrzgAUbFPHJUbBVT
X-Gm-Gg: Acq92OGsuEWLfkUGclzznrAoyWVMah22no3ihzwd0vhMVPcrUiEt54NIlxjH+jeKXq6
 cWwzHFBfysaGcP1Ahjd7FXtWn80HseSmFPom4Mi87tuYGmNVq9C7izyNC1fBnftHt5VFDdSKTim
 yWnZHaPtxKWbqX+3SsuZRCvUOVsId2MVlGhP132Kk+JzAJKKToacqg3ZkPlSR/IO7yfpFSQ8b9l
 pq5FP5/q73u8wYgXK8C08JgZVmrhPbwdw9j7f36X21O1NhJKopQ+K5eT/J0+rai3nL/Oi7ARekx
 QnngaL8bKBxL/G9S7xmIhZrCckkGQl+6i0Bgey+uwOUeXQACY84ioJH4uKMWGtr/zFab9n3Y2Nl
 9jZUbykfl37jqOkmKDOY29FLWd/qk6MeOjcGUS4Yn+5pzAUvWzzifof1vOHO7CsrxPsaytAiB3z
 82J505lkLIKyTYemPBhm3HUlKGp7slz/XWpV2WMyT38dl5P8MWrDJ+adDUGHB52+CH
X-Received: by 2002:a05:6000:4b07:b0:44f:69f4:39b5 with SMTP id
 ffacd0b85a97d-45d9502e84dmr35187412f8f.29.1779186083195; 
 Tue, 19 May 2026 03:21:23 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe0fecsm41028224f8f.26.2026.05.19.03.21.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 03:21:22 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Melissa Wen <mwen@igalia.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Alex Hung <alex.hung@amd.com>, Roman Li <Roman.Li@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Mario Limonciello <mario.limonciello@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 02/14] drm/amd/display: Delete dce_get_required_clocks_state()
Date: Tue, 19 May 2026 12:21:06 +0200
Message-ID: <20260519102118.246466-3-timur.kristof@gmail.com>
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

It is not called from anywhere anymore.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Melissa Wen <mwen@igalia.com>
---
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 34 -------------------
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.h   |  3 --
 2 files changed, 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index 4ccc6c742d00..e8daee975b79 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -220,40 +220,6 @@ uint32_t dce_get_max_pixel_clock_for_all_paths(struct dc_state *context)
 	return max_pix_clk;
 }
 
-enum dm_pp_clocks_state dce_get_required_clocks_state(
-	struct clk_mgr *clk_mgr_base,
-	struct dc_state *context)
-{
-	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	int i;
-	enum dm_pp_clocks_state low_req_clk;
-	int max_pix_clk = dce_get_max_pixel_clock_for_all_paths(context);
-
-	/* Iterate from highest supported to lowest valid state, and update
-	 * lowest RequiredState with the lowest state that satisfies
-	 * all required clocks
-	 */
-	for (i = clk_mgr_dce->max_clks_state; i >= DM_PP_CLOCKS_STATE_ULTRA_LOW; i--)
-		if (context->bw_ctx.bw.dce.dispclk_khz >
-				clk_mgr_dce->max_clks_by_state[i].display_clk_khz
-			|| max_pix_clk >
-				clk_mgr_dce->max_clks_by_state[i].pixel_clk_khz)
-			break;
-
-	low_req_clk = i + 1;
-	if (low_req_clk > clk_mgr_dce->max_clks_state) {
-		/* set max clock state for high phyclock, invalid on exceeding display clock */
-		if (clk_mgr_dce->max_clks_by_state[clk_mgr_dce->max_clks_state].display_clk_khz
-				< context->bw_ctx.bw.dce.dispclk_khz)
-			low_req_clk = DM_PP_CLOCKS_STATE_INVALID;
-		else
-			low_req_clk = clk_mgr_dce->max_clks_state;
-	}
-
-	return low_req_clk;
-}
-
-
 /* TODO: remove use the two broken down functions */
 int dce_set_clock(
 	struct clk_mgr *clk_mgr_base,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.h
index 9ea1b0a9923d..e1c6a92d7957 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.h
@@ -32,9 +32,6 @@
 /* functions shared by other dce clk mgrs */
 int dce_adjust_dp_ref_freq_for_ss(struct clk_mgr_internal *clk_mgr_dce, int dp_ref_clk_khz);
 int dce_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base);
-enum dm_pp_clocks_state dce_get_required_clocks_state(
-	struct clk_mgr *clk_mgr_base,
-	struct dc_state *context);
 
 uint32_t dce_get_max_pixel_clock_for_all_paths(struct dc_state *context);
 
-- 
2.54.0


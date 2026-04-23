Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2300BFDEE3F
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 19:15:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A013B10F27C;
	Thu, 23 Apr 2026 19:15:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="C6kE4b8a";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6517510F260
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 19:15:29 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so114898635e9.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 12:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776971728; x=1777576528; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DGBypz7KjMRiprMNN1ArhcF5SuS8vqhuh2C5+Uj/zuc=;
 b=C6kE4b8aESwVreNJZBzEh+YFArbv7teVu5SMB3U4prdUphHNYjKJcN5yg4qnY9Zppi
 2yYwfKwbqkY83PbwrGUkHT5hNDdEtyxtUHG5OneHaIjAbAMWBVN/WfNNmXCP5q+AcPEh
 ChBntu7xRg3C7NM0xe+6eEGqJgD8HRAX4UDepuXg8qmnixdcGQkdbMEIrJiJvpt9tVEp
 +Z5XXh9NZI6ubpqn5QJ7PN76hUsGQpyugNeBsT0vBnondidmlpb4V7A/dU2z6loG9muS
 jZ9+eP3449fp1ZrW2Y5v1IMpl2Cfa3wk+N5PYCAHQ9EaP3dVOZ5Sbp9evM1wWDmkbYlw
 ampg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776971728; x=1777576528;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DGBypz7KjMRiprMNN1ArhcF5SuS8vqhuh2C5+Uj/zuc=;
 b=sqcKtJ8WQU980IUBpmIvmwcrrnAzAJT7iDPhB/CAUvZMGpaUrQtm7vmSfRXQAG+yPk
 nRO0eMQqRMMDO60B+9KmsTd7pwSz5XGiAPukCe0dDvlY7kbMPOZHxnQ6/3t7xNVOb5HG
 EHeIWb7dAvliSIq/CQs2gcpBx6lhyaKftqqsybzF7+H1QSmO7ZhN3Xp2DT9Vgyj/QQ7E
 sMwSXNgZ33eDy47nUrfLzUpq5oh2lUAg7YWfFS7aPf8vFaQjnRSdI9u+vdBN48F5Edho
 okdJ93tPQYZqtADDvd60QuPKlzdXgiqrC4sqLawtp/pJbC7QdW05FMdjt7PyNQAHZI75
 ROAg==
X-Gm-Message-State: AOJu0YzY7c4QzHzk1wh7Jmgfu+MW/wcyQFkVG2kp6tiqUWJSu8zdP7QC
 vOSmJ0dTUjxMekUSE4NmCdDE0WeLMcOXtWvWoIGaOk6Ee/yHTifJCs24AidtnXdW
X-Gm-Gg: AeBDiesUtpyEXXXcro8E3uTKc+vmWcw4Y3xRdV/Cm6TBEtdraPETL+jJ5qoE8Wnp2SE
 bGeCPR0VY/BhY3XlE9DZ0Q/6vGBwYzNH6ZzefuAT3G5JGstubcquW4RlzqEyAZfAxAAVvW2LKlW
 fh73SB+bD9K1dGCNV2TiKPz8CWQMerQwprM0UvGHgVP7+oUXT4hloCBzYZVBsBfrMnbQpIZviz6
 /djvXg8J7incelP4Q8BtAx9y5zv/diUDDU+zfakebljtRburDgR4qnhUptlcq3Zxb1NVFElJZ/8
 WN6i9oqdXmchbjmlBWmV4HCJ6P/azOW3GZgF+saN116mDCN71DAN7hYOUcaGrGjAoplXORNfG2U
 XkLeH5KrMT6s9qIsWEfwhNRCyRRUMIOF3+qmrQfzc5P11GjoobLBYi3hRhkCo9kC8qaXZSXt8Ay
 Mw2uySHjKGRaf+RaGjL4Y9F2aFyvXCZUIOjPmsDAvHVwDN865fahcosb+mrkGQ4tkITrv5uwbgv
 uLV+A==
X-Received: by 2002:a05:600d:8408:b0:485:46fd:7887 with SMTP id
 5b1f17b1804b1-488fb74c61fmr315370925e9.13.1776971727838; 
 Thu, 23 Apr 2026 12:15:27 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm15792782f8f.15.2026.04.23.12.15.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:15:27 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 05/14] drm/amd/display: Set max supported display clock
 without max_clks_by_state
Date: Thu, 23 Apr 2026 21:15:10 +0200
Message-ID: <20260423191519.73127-6-timur.kristof@gmail.com>
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

The max_clks_by_state was based on hardcoded values, which are
not really used anywhere, only to know the maximum clock.
Just hardcode the same maximum clock for each DCE version.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c  | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index 2ba341df7fffd..bef9a72f3382f 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -391,9 +391,7 @@ static void dce_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
 			bool safe_to_lower)
 {
-	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	const int max_disp_clk =
-		clk_mgr_dce->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
+	const int max_disp_clk = clk_mgr_base->clks.max_supported_dispclk_khz;
 	int patched_disp_clk = MIN(max_disp_clk, context->bw_ctx.bw.dce.dispclk_khz);
 
 	if (should_set_clock(safe_to_lower, patched_disp_clk, clk_mgr_base->clks.dispclk_khz)) {
@@ -445,8 +443,16 @@ void dce_clk_mgr_construct(
 	clk_mgr->dprefclk_ss_divider = 1000;
 	clk_mgr->ss_on_dprefclk = false;
 
-	base->clks.max_supported_dispclk_khz =
-		clk_mgr->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
+	if (ctx->dce_version >= DCE_VERSION_12_0)
+		base->clks.max_supported_dispclk_khz = 1133000;
+	else if (ctx->dce_version >= DCE_VERSION_11_2)
+		base->clks.max_supported_dispclk_khz = 1108000;
+	else if (ctx->dce_version >= DCE_VERSION_11_0)
+		base->clks.max_supported_dispclk_khz = 643000;
+	else if (ctx->dce_version >= DCE_VERSION_8_0)
+		base->clks.max_supported_dispclk_khz = 625000;
+	else
+		base->clks.max_supported_dispclk_khz = 600000;
 
 	dce_clock_read_integrated_info(clk_mgr);
 	dce_clock_read_ss_info(clk_mgr);
-- 
2.53.0


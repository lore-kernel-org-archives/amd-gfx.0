Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA392FDEE48
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 19:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77B3B10F264;
	Thu, 23 Apr 2026 19:15:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f7VQ4QjZ";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5689910F23D
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 19:15:26 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-43fe62837baso4286536f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 12:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776971725; x=1777576525; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wbwvXexGBuwDQrR6bVA4Yq59xFwjuTbqWzJZyNZMULY=;
 b=f7VQ4QjZqhwUW9u8UJcXpNzEc37ytQwEKDf+zyk/1kfLBOxavBu/aQNOgPZHw5Z0ue
 5Q35nNk2wGsUM40WQ9b5J0/NtClF2XBvIVM77HWfa/lLYbfyzdH1+LrVSZBCWUlbpFf7
 8s56FQc9wSvhA/fWQEp3InY5nf7bNzNCn6pd+lYGQa6kz/MeWO2j+f4BKcYot2SOLDBM
 y0+r7EJ/c+PZ/7mJcsiYUV4CjNnDb+MxQ4sfDO+wd2WjrlzpSHZ39F9COzkWu8ewfczI
 8d8e884a8+uqkyIYxjJYdhqTP8rUkgpRs91+PV/O3euMNKQRHOCkE8IGdBbgekKxyu/K
 XNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776971725; x=1777576525;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wbwvXexGBuwDQrR6bVA4Yq59xFwjuTbqWzJZyNZMULY=;
 b=Uon3WPOOAJQd2D5BVuFo4bphP5naW3fFqvfsNtCyBWTuYs1F75TGfiY1BkYXInrsTi
 /Gf5L85qPDp7yeBz71F/wzFwL0iIkPKjnHg5ZBGNN56mRlRHRiKJ9Se6t01Xqe0nbJRp
 AuoteQaOrm3FufAedxc+nGC8+PTB6aCAVEchwAz7O5Pn32TJ4s/uyXb96Wv6hpcsUaDY
 VA7xeWbxdC+6JI6OuioG559xkqn4v2KPw4puk+DeuDzYboFBlVb4R900xxul6KC9NF3P
 KGbfbqNwAP2/EdpCTKx4HcmbNelusql9GXJNegpDoidoTzUv/eXe1nmRVAAXrogbilrS
 dFGw==
X-Gm-Message-State: AOJu0Yw9mE79s+/kWFMZy87bz2+xuNel2zzaCF2P3LHONeqOr7riu88T
 t1OcK5KyWK1QguIHnbGL8b7QGeVxMBi/VFBEERoWNWQmCqpAmTLC+4hhRNnlAv2h
X-Gm-Gg: AeBDietjuDmgWxpseDZr05bFmmO+srVKVYFyhtkZajBUDSfhUgRSDanzmY70/ikZGmP
 z93DUxq/VOoTETyLHnIA+kKxmRV5P3VkDAoQOpINc8BopWX+IRdUFmh0H3A7z3Hs7J7eUCXT50D
 wP77jdAUhAmImjIL723wc979Gbch2MByZpIA5XUEguv14wxbazBkAMVvxISXuCqv+3Q05qcknQb
 q7mS7+FkhBZu8Ay10yJ/DWNo5xfYhWdeZ+AFC1Kg1wBMLvr5jsloD8mKUonFyw3k/wLhWNQQXdC
 ilwzB9LmLXa8un7Qvdn1nGTBxLFV7zLSOwOvp4PFMPr8jnyO5fTfjwwA4JszcdEf8GaN6mfMHAR
 inEkRo4e1VASpB2oHsQ42QnDOEj255HcwZWlq43nORrKYHMvFX5f4vij1QPsvx85m9nc3a8o9Q1
 QjZ4yd+60vyLQzkN29KOwIioxBS2KNIyOWJHvX3F9ApPyPHIOoDrnhr/zAD4p7vv7NnFGaFqQYq
 j7I6w==
X-Received: by 2002:a05:6000:26c6:b0:43c:f66e:f31 with SMTP id
 ffacd0b85a97d-43fe3df24f7mr42578857f8f.27.1776971724705; 
 Thu, 23 Apr 2026 12:15:24 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44123d23e0bsm15792782f8f.15.2026.04.23.12.15.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 12:15:24 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 Alex Hung <alex.hung@amd.com>, Harry Wentland <Harry.Wentland@amd.com>,
 Roman Li <Roman.Li@amd.com>, Leo Li <sunpeng.li@amd.com>,
 David Airlie <airlied@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Ivan Lipski <ivan.lipski@amd.com>, Melissa Wen <mwen@igalia.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 02/14] drm/amd/display: Delete dce_get_required_clocks_state()
Date: Thu, 23 Apr 2026 21:15:07 +0200
Message-ID: <20260423191519.73127-3-timur.kristof@gmail.com>
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

It is not called from anywhere anymore.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   | 34 -------------------
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.h   |  3 --
 2 files changed, 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index ffb70120362e7..988eb6f841f54 100644
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
index f6622f58f62eb..f9f0cfa2a7b20 100644
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
2.53.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0599C87FCD
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 15:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 729A110E2FA;
	Tue, 22 Jul 2025 15:58:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AzTknBd9";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 872CD10E2FA
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 15:58:48 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-45619d70c72so314515e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 08:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753199927; x=1753804727; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CEMJLmIA/DHay/MeC34nnofln2Etw/1jb54/DLsbupo=;
 b=AzTknBd9HMhdI9jgMPEfF6pjjjUzjQ5fUHoccPUscQN0YNGKu2PtqaJ20SXGN9WAFh
 m8cf0XJsGqKSIvvCkjGWiR0OqepRHAIzOR78Cqn6NidGJR/0WVLMsNtsUwCS4hbazGEs
 az4ktyUb5BEz0QuE3FAEKfqx5HUOaHhFUGOLvz8cPTPCa4teg3PTe5YfOkqiqX/gVlGS
 djYU3fHrJh7KpZZpvp3HlcP4Z7BasVDiOQytZgh7fgdYE1cY7wETVlVAqf0PZdvyWNzJ
 XxJfwt/7TCmeaDBpnSiVDzyjyA5UHtIsqClWzfj8Fko028DcsfHwevXOTqEdgKMZeVrz
 xcBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753199927; x=1753804727;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CEMJLmIA/DHay/MeC34nnofln2Etw/1jb54/DLsbupo=;
 b=D4nj6wBkGc7wIHjzb2X2gmAuM/u1L4ndz7zKqJslBQJkPOVrARItwDWqPeT8cgtrlk
 GR920dSBG9QDr2IY2LN8r5G0ApNpzuSb3czfEqqoyMP1aSV4JEsuKQhdMAM26hSdfQaZ
 4OEBGQoTKqy9wTDx4JQ82ERAFPCodMSUfJFu9w55sdpWEUPPxrvWSNRg52WReIv6lfl3
 3v5BhyqMquH7AHWkjbCKBmvl3e4VseXnaF0G8ZuTpQ53tRup0FAjBr8aliEdk+6J9Mh+
 CvSMGIFvwQ2CR7Xk627EizRWBlz3ujl0a6ADMoOPos4dn0Bi+R2d94trSd7VBpzZ6tQi
 X6Wg==
X-Gm-Message-State: AOJu0YybiH/Q96odTC4MXRbFEyzaO4mafmss7zPUm02ldeLImy/6RjWu
 MIOdchImIPIGHu9r0RpuLPtnVhcuquKJ9GfR89x4wbrGgYTbBRcGAqZKQ83Mdw==
X-Gm-Gg: ASbGncve7X0XN4ASQuKj0NwIdwBD4YNkdN3Hy2ggNcVzwASpUOwO7n0Vy/02SsZoszV
 3vPBQJq6ulUhUvBXUASh+EJO+M8qDqpyQ1wtXxNKTZjGUMS2r43R0X55zPWIb8cmfgR25kGw94/
 /Oyd+VUKoDydeS/NPnJvFnunf11PhfP8U15pecBv7Q9MuVXGUfJzrv+Z8ME8tBuLp8nrI9677PI
 h0GyM9wwHjmn933J57LCpRHWMPIaxZl/zDZDgbGjfmxQd2yrUx3V+9Q31NOzeWUAR4uwtc4GZtF
 zdtWB2mCPZiKRRO2yKuva5cX8vbzur0IqXywywTDg/jeH7POBrI8BY7/Jg9E/mLWMVsPFSUHbbl
 Bwby5ZWYBEMJHkDH4PzO/Uy12UNyqhSHZRabRiz6q4vo=
X-Google-Smtp-Source: AGHT+IElGUZZ9XOfZN+CPwef0pQ1dNht8X0aQ0W6nd9YBJtHk/Exzl1K2qlyLO3RTohUzef/r3kZPw==
X-Received: by 2002:a05:6000:2508:b0:3a4:f7dd:6fad with SMTP id
 ffacd0b85a97d-3b7634b048bmr3608451f8f.14.1753199926803; 
 Tue, 22 Jul 2025 08:58:46 -0700 (PDT)
Received: from Timur-Hyperion ([2a0a:f640:1810:c696:604:c93:8102:bad7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4893fsm13948241f8f.52.2025.07.22.08.58.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 08:58:46 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/3] drm/amd/display: Fix DCE 6.0 and 6.4 PLL programming.
Date: Tue, 22 Jul 2025 17:58:30 +0200
Message-ID: <20250722155830.67401-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250722155830.67401-1-timur.kristof@gmail.com>
References: <20250722155830.67401-1-timur.kristof@gmail.com>
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

Apparently, both DCE 6.0 and 6.4 have 3 PLLs, but PLL0 can only
be used for DP. Make sure to initialize the correct amount of PLLs
in DC for these DCE versions and use PLL0 only for DP.

Also, on DCE 6.0 and 6.4, the PLL0 needs to be powered on at
initialization as opposed to DCE 6.1 and 7.x which use a different
clock source for DFS.

The following functions were used as reference from the	old
radeon driver implementation of	DCE 6.x:
- radeon_atom_pick_pll
- atombios_crtc_set_disp_eng_pll

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |  5 +++
 .../dc/resource/dce60/dce60_resource.c        | 34 +++++++++++--------
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index 26feefbb8990..f5ad0a177038 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -245,6 +245,11 @@ int dce_set_clock(
 	pxl_clk_params.target_pixel_clock_100hz = requested_clk_khz * 10;
 	pxl_clk_params.pll_id = CLOCK_SOURCE_ID_DFS;
 
+	/* DCE 6.0, DCE 6.4: engine clock is the same as PLL0 */
+	if (clk_mgr_base->ctx->dce_version == DCE_VERSION_6_0 ||
+	    clk_mgr_base->ctx->dce_version == DCE_VERSION_6_4)
+		pxl_clk_params.pll_id = CLOCK_SOURCE_ID_PLL0;
+
 	if (clk_mgr_dce->dfs_bypass_active)
 		pxl_clk_params.flags.SET_DISPCLK_DFS_BYPASS = true;
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
index 58b59d52dc9d..53b60044653f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dce60/dce60_resource.c
@@ -373,7 +373,7 @@ static const struct resource_caps res_cap = {
 		.num_timing_generator = 6,
 		.num_audio = 6,
 		.num_stream_encoder = 6,
-		.num_pll = 2,
+		.num_pll = 3,
 		.num_ddc = 6,
 };
 
@@ -389,7 +389,7 @@ static const struct resource_caps res_cap_64 = {
 		.num_timing_generator = 2,
 		.num_audio = 2,
 		.num_stream_encoder = 2,
-		.num_pll = 2,
+		.num_pll = 3,
 		.num_ddc = 2,
 };
 
@@ -973,21 +973,24 @@ static bool dce60_construct(
 
 	if (bp->fw_info_valid && bp->fw_info.external_clock_source_frequency_for_dp != 0) {
 		pool->base.dp_clock_source =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_EXTERNAL, NULL, true);
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_EXTERNAL, NULL, true);
 
+		/* DCE 6.0 and 6.4: PLL0 can only be used with DP. Don't initialize it here. */
 		pool->base.clock_sources[0] =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL0, &clk_src_regs[0], false);
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[1], false);
 		pool->base.clock_sources[1] =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[1], false);
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL2, &clk_src_regs[2], false);
 		pool->base.clk_src_count = 2;
 
 	} else {
 		pool->base.dp_clock_source =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL0, &clk_src_regs[0], true);
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL0, &clk_src_regs[0], true);
 
 		pool->base.clock_sources[0] =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[1], false);
-		pool->base.clk_src_count = 1;
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[1], false);
+		pool->base.clock_sources[1] =
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL2, &clk_src_regs[2], false);
+		pool->base.clk_src_count = 2;
 	}
 
 	if (pool->base.dp_clock_source == NULL) {
@@ -1365,21 +1368,24 @@ static bool dce64_construct(
 
 	if (bp->fw_info_valid && bp->fw_info.external_clock_source_frequency_for_dp != 0) {
 		pool->base.dp_clock_source =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_EXTERNAL, NULL, true);
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_EXTERNAL, NULL, true);
 
+		/* DCE 6.0 and 6.4: PLL0 can only be used with DP. Don't initialize it here. */
 		pool->base.clock_sources[0] =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[0], false);
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[1], false);
 		pool->base.clock_sources[1] =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL2, &clk_src_regs[1], false);
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL2, &clk_src_regs[2], false);
 		pool->base.clk_src_count = 2;
 
 	} else {
 		pool->base.dp_clock_source =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[0], true);
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL0, &clk_src_regs[0], true);
 
 		pool->base.clock_sources[0] =
-				dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL2, &clk_src_regs[1], false);
-		pool->base.clk_src_count = 1;
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL1, &clk_src_regs[1], false);
+		pool->base.clock_sources[1] =
+			dce60_clock_source_create(ctx, bp, CLOCK_SOURCE_ID_PLL2, &clk_src_regs[2], false);
+		pool->base.clk_src_count = 2;
 	}
 
 	if (pool->base.dp_clock_source == NULL) {
-- 
2.50.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87F5310FCACA
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Apr 2026 18:19:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1CBFA10EEC6;
	Wed,  1 Apr 2026 18:19:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bzBFSz6A";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F61E10EB2C
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Apr 2026 00:39:40 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso6814873eec.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 31 Mar 2026 17:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775003979; x=1775608779; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8f7Ntg2BX3ujyAv43r3p8dJoIwxn/3R/KWzzyEF1YhY=;
 b=bzBFSz6AVLvVvmfpr/LKgUqERV7ccoRLnVScyD/VLn7trqQC/0l7sIEMoUpgoIAmLf
 GcuK+YBlgjSsYs0o80TIkk4EFbll5ur9MMdAjsgVEbqpwFqZP1l1ijYaG2gFSW/qmy6P
 N+bYG9iYmYaLGq645YdE7YkiNJAULoVfHJmL2pOCbE3VS/C0r44WA+TXqo9fkr9DlJoe
 peBPEgGLnYT2pYYxjwm6/cn8qaiLYabrC8bt1xMxE38C9FZ9SCrfgwWz94WgVSNLvAz2
 pyd8ZnSexm2dHm3sk9GUlX78qNxDLhcFj35I6gjwSHlMeUfTDuZdSzeBKbp1d5lTXka0
 NYzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775003979; x=1775608779;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8f7Ntg2BX3ujyAv43r3p8dJoIwxn/3R/KWzzyEF1YhY=;
 b=Cn6LgU+gGctp0mNBwXsdiZ3eVLM34WdnuC4MKbUyUFf6OVJv28IN+qRlIzaonsSBkp
 05L5S2jz3XlU+OfNF2Jj3h+8oz1vmPh/IvoLRs8miDJHqsB8HHEST5rptKlAHjAoJ6as
 A9nmgKZo52tIy5yvkgHA+r7FMT+8PGza//sLnwT3yH5MAq6t5r8bZBke1ueS8K7mzx4g
 wewUAP0q6r//RIwEiGDDh8qnz2T6jI3iQWOoyLU60ZaBEadBEU52e2zRoAbhq1NkOmMA
 6umJT4ZCWgFuayBVaO6G7I+Qe0AeMyQ9yFm0k39v8JBx1kKvyJkDmkkaeKJqQ4Xng395
 Xk8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWscO+NGsImRbBWGQ77lWCRipLZWI4m1/SrneoaDskKqBWlwvmZzqBvauIF6QW6QPwshwMv0Jqy@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yys3AwjBTA75rW6zDRIUdhJ/4Ocy/XAnYpcOohhp6zyj/+TDqej
 S1cikl+r8DOzyPeOZlkNIudfZXWnkY3NSQypDvy9Jf3WU6TvcG1T04F5
X-Gm-Gg: ATEYQzxkt5a5zVXogp8Ei47ztHxModEasaIh56g3DLzdEiqOkioH+52pRb92JkIJ54w
 Bh+Zzv3HhPASLNnEdIjhf3tQghBxn545YWc+LKfKU7P/dPfXF4y25tTLnG6ZBLkkbuC6CGKxp7Y
 4wBuQXBGhN9ycS/hpsAjVt3bkTdhoy4s9DzCFMjaCDbxQJ5ERuJ480RWaMVEBreQ4RJPr9Q/a8C
 8JjQRKP0xjZcbS7R7AlNPS9eTnUpuRQlcwk+knTcCUBIi/uaH9h1wba6xY0qBtP8kwmBoPflOhG
 ftj77vc8SB1tEutCPi4IZpnpksuEWSHLqcofkho7p+vMx7tR5SR7IkXOQW2AU7ljh6SFyxc/3RA
 We1kf0OUiDQQUHotqf0tIe6YdgUYeb52jAKdIe5O6uzvx0Y5X0yTdB2KD7Rt0WSj4+MFaSNM8fW
 jGRHbWQp4DUJCEUJEjXUjjEi5n2Au2hxSogNDn2eckw+ey9F4VNfYmSTJHaMQL/ImOSw==
X-Received: by 2002:a05:7300:5707:b0:2c7:3a7:c7b1 with SMTP id
 5a478bee46e88-2c930b80368mr875953eec.1.1775003979256; 
 Tue, 31 Mar 2026 17:39:39 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c3c3bd9894sm11543019eec.4.2026.03.31.17.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Mar 2026 17:39:38 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Ray Wu <ray.wu@amd.com>, Wayne Lin <wayne.lin@amd.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alex Hung <alex.hung@amd.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 for 6.12 06/10] drm/amd/display: Fix DCE 6.0 and 6.4 PLL
 programming.
Date: Tue, 31 Mar 2026 17:39:04 -0700
Message-ID: <20260401003908.3438-7-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401003908.3438-1-rosenp@gmail.com>
References: <20260401003908.3438-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 01 Apr 2026 18:19:20 +0000
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

From: Timur Kristóf <timur.kristof@gmail.com>

[ Upstream commit 35222b5934ec8d762473592ece98659baf6bc48e ]

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

Reviewed-by: Rodrigo Siqueira <siqueira@igalia.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../display/dc/clk_mgr/dce100/dce_clk_mgr.c   |  5 +++
 .../drm/amd/display/dc/dce60/dce60_resource.c | 34 +++++++++++--------
 2 files changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index a2e100aa3cba..5dbe89d9b72d 100644
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
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index c4d7fa60d654..978c024c97ba 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -374,7 +374,7 @@ static const struct resource_caps res_cap = {
 		.num_timing_generator = 6,
 		.num_audio = 6,
 		.num_stream_encoder = 6,
-		.num_pll = 2,
+		.num_pll = 3,
 		.num_ddc = 6,
 };
 
@@ -390,7 +390,7 @@ static const struct resource_caps res_cap_64 = {
 		.num_timing_generator = 2,
 		.num_audio = 2,
 		.num_stream_encoder = 2,
-		.num_pll = 2,
+		.num_pll = 3,
 		.num_ddc = 2,
 };
 
@@ -990,21 +990,24 @@ static bool dce60_construct(
 
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
@@ -1382,21 +1385,24 @@ static bool dce64_construct(
 
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
2.53.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0619C87FD2
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Jul 2025 09:44:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4A97810E74C;
	Thu, 31 Jul 2025 09:44:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mGXS9bgS";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DA8D10E746
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 09:44:21 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4563bc166a5so3450135e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 02:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753955060; x=1754559860; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MwCZJXSMmvHrsnIp10Hf83hQzd8xnS9Rxu7PUkFA4N8=;
 b=mGXS9bgSDA9flkhIXs4uir09qv4LXitWBG2RV75KpNYSAxc+6SWMLVVuI/WgCqAGb8
 UQ1IovETAVv4xsGo88KOyujmmASmqo+PuVh/+WheRuTHKcPV6zqlHHdzTZN2A9ME4wME
 IVxWxLV/m9yiXaULLItx2MUi6ANpdKP8DUo7Td0Z3eJAdmc39CTDXNXpz72qwbecqYDV
 pDrqoTC4I5mB1Mb6xh7vsL+KbFy2aylDtMFF8MXPAJgKH3wlWeeijicBhy7I+wn9Nx1f
 4MSGxeVjIY6uN2UUhvgp7K6RCMGwptS4tqWq6A6OWuK20RJpDSklnEt7KR8WBgWRylUt
 ZIWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753955060; x=1754559860;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MwCZJXSMmvHrsnIp10Hf83hQzd8xnS9Rxu7PUkFA4N8=;
 b=BVTFgiMt9YzUJ6OxXVET853G4q00ma+JCYRv8xiBAh7DpftnwkBZDAar4l5aHvtJPQ
 Ht63LeuR3yys6UZQyoWpTheBLmsMbDFojX+alCz5pSLz1hUlR4qN1ugKRVn6ttH56N7g
 pjJjnktTG8cik4c1KaESDJoGTCruTCEGBMzEbCCoLodkbNQ06MrtagNKMODdUlT5VEbu
 G3i5dCGqc2m6ef5P/uvIOJ9qg5EAIgtTI3sR8ZD5+KVfuPxSebsNRj0kgbMaTtOGiK0o
 J/3UUGXU0Cjqr2OsLSQlT/4xX1COhAuFBKFzspDHHiGzNQukdWtJi+4lZnQfV+HcAnt1
 efgA==
X-Gm-Message-State: AOJu0YyMG7LNUPtM4dq7uZoW5r6v9gu40r+FxtqydQuW98oLzTsBugKy
 UC+CAyOVDDdAP76uzLo+D7NCon6YUv+nJXcBy+YB786B4tYdPpfyfvVMCvng8A==
X-Gm-Gg: ASbGnctydyG3gXeUebqdqTPa4CN8T8pDDdw3jhEZqPiII3uAH0ia9ArE4Brog5doUNW
 /DLUz+vEvQ5umMtxwXMl63hEOx73unNqzXrSoxZI3dYEUuCKGd4IpS1p1rAkuazxQngKZmn+xWO
 vhyYswAHxugTvuDuBmh+cgbqR2v1lJlitd97NmgNxJxqhUfvGrIKpRY9NWhd48NgkYYptBu4f9N
 biK7Kr0G23vNuUWiznVlQ/4nqkadjaz9zafJ91lKzPsZJj+BVcNsiTfcBBh9JNsZA4AceC/oeXw
 9zw+xv3lKHASF2BrFHpTSG4cBdIxWEvcxnCJHFUIhOEXHXtM/iyfwpJIv4HzszONardoWQIuKhu
 Kgye8vVzbCUsLUqLrTAjNUHDEnLXuQGJk42lEThy8PRXPyajjf+eOlPqIuEzq8xKoTHUtWdFuHW
 yeza4TufwxBkq/aARw4wcYB+Li370fXA==
X-Google-Smtp-Source: AGHT+IFiFxz/zxMD6OxCY5uvw8XcUEKhSaolNAcq4KJtKSkmNcQDfr9N42NsnRBdzkqcVoGEhdGFfQ==
X-Received: by 2002:a05:600c:3acf:b0:455:f7d5:1224 with SMTP id
 5b1f17b1804b1-458a2220fa2mr12911065e9.9.1753955059572; 
 Thu, 31 Jul 2025 02:44:19 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24DDB700267C66B850A0E369.dsl.pool.telekom.hu.
 [2001:4c4e:24dd:b700:267c:66b8:50a0:e369])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589536b3b4sm58252835e9.3.2025.07.31.02.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 02:44:18 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/7] drm/amd/display: Fill display clock and vblank time in
 dce110_fill_display_configs
Date: Thu, 31 Jul 2025 11:43:49 +0200
Message-ID: <20250731094352.29528-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250731094352.29528-1-timur.kristof@gmail.com>
References: <20250731094352.29528-1-timur.kristof@gmail.com>
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

Also needed by DCE 6.
This way the code that gathers this info can be shared between
different DCE versions and doesn't have to be repeated.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c    |  2 --
 .../drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c | 10 +++-------
 .../drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c   |  2 --
 3 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index 69e9540f553b..17a8b46b0818 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -386,8 +386,6 @@ static void dce_pplib_apply_display_requirements(
 {
 	struct dm_pp_display_configuration *pp_display_cfg = &context->pp_display_cfg;
 
-	pp_display_cfg->avail_mclk_switch_time_us = dce110_get_min_vblank_time_us(context);
-
 	dce110_fill_display_configs(context, pp_display_cfg);
 
 	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
index baeac8f1c04f..13cf415e38e5 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce110/dce110_clk_mgr.c
@@ -124,6 +124,9 @@ void dce110_fill_display_configs(
 	int j;
 	int num_cfgs = 0;
 
+	pp_display_cfg->avail_mclk_switch_time_us = dce110_get_min_vblank_time_us(context);
+	pp_display_cfg->disp_clk_khz = dc->clk_mgr->clks.dispclk_khz;
+	pp_display_cfg->avail_mclk_switch_time_in_disp_active_us = 0;
 	pp_display_cfg->crtc_index = dc->res_pool->res_cap->num_timing_generator;
 
 	for (j = 0; j < context->stream_count; j++) {
@@ -243,13 +246,6 @@ void dce11_pplib_apply_display_requirements(
 	pp_display_cfg->min_engine_clock_deep_sleep_khz
 			= context->bw_ctx.bw.dce.sclk_deep_sleep_khz;
 
-	pp_display_cfg->avail_mclk_switch_time_us =
-						dce110_get_min_vblank_time_us(context);
-	/* TODO: dce11.2*/
-	pp_display_cfg->avail_mclk_switch_time_in_disp_active_us = 0;
-
-	pp_display_cfg->disp_clk_khz = dc->clk_mgr->clks.dispclk_khz;
-
 	dce110_fill_display_configs(context, pp_display_cfg);
 
 	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
index cfd7309f2c6a..7044b437fe9d 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
@@ -109,8 +109,6 @@ static void dce60_pplib_apply_display_requirements(
 {
 	struct dm_pp_display_configuration *pp_display_cfg = &context->pp_display_cfg;
 
-	pp_display_cfg->avail_mclk_switch_time_us = dce110_get_min_vblank_time_us(context);
-
 	dce110_fill_display_configs(context, pp_display_cfg);
 
 	if (memcmp(&dc->current_state->pp_display_cfg, pp_display_cfg, sizeof(*pp_display_cfg)) !=  0)
-- 
2.50.1


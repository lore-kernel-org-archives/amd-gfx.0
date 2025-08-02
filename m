Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0ED5C87FD2
	for <amd-gfx@archiver.kernel.org>; Sat,  2 Aug 2025 15:52:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34FBD10E046;
	Sat,  2 Aug 2025 15:52:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lOm3AIzU";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5912310E046
 for <amd-gfx@lists.freedesktop.org>; Sat,  2 Aug 2025 15:52:01 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-455b00339c8so19022765e9.3
 for <amd-gfx@lists.freedesktop.org>; Sat, 02 Aug 2025 08:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754149920; x=1754754720; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HWImIGeB7dT3EoNwaQLvUOg2NBOdzfKSQ4sb4n6zOgw=;
 b=lOm3AIzUgwhf6vUZ1iFS8ghkW5NJVO6X/66vfUN+38+auEu00y1n9Y/c58Jh5UFjk2
 TMo4WK2sFcEC0mBasUOzhZZvmUzpLYVtKXhnwffgCyvj6wOU7eAwFqGWI2T3bMvXQIsl
 yJ8htyKXz3POWR/fm7HhCpVYfsjd4RESM/Hz8i89AhYv9JuPz3kq5nxJ44cF2lXO8uf5
 TWV2MiriYi4y6MyWewx2ESvWNAynKWRb8yh4ok4+2wolg6eyCRS/UdwwsBDAzxwdN09H
 1f8rqMAZyf5KZJrwWSGFU9js89A9Ao3rq9QeQL0oSB9GzdF2G+NTVLonhNnwFXVH2HMw
 yTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754149920; x=1754754720;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HWImIGeB7dT3EoNwaQLvUOg2NBOdzfKSQ4sb4n6zOgw=;
 b=v7++bopyBiCBNZJzO3pdzlLL5q1NVPJSFCOzOGU6U7Xy/5aJ/P/GGI6JzXHBi0rJgQ
 7Ql6gOFoeIegN4WLhVevq2EtTrlfHMM2VanMLrtswQ+Djjuy/YVhsVgsqwKSMRzsxiVv
 mmqxyEGO/l3qGyr5OtWeycaVqkNEc0EfhetNYI8FHdbMQlfxDxL1PxNh8DYKAd9h2Ezk
 n8lUcSuuA7x1y7SgnbkSMXHJYXSQREjt7ctuRBMANup4yTo1Zz42ugQzYn+z58+0V3jy
 uQDswgRJSZTzXgM3n/38bpj1N+ucErYObQDd97BhM4FVOufKbxyTahOOfWsizPH5B6zp
 Inlg==
X-Gm-Message-State: AOJu0YwVOdBKo9++yVn6PjDVeLDFAmUMddJDtzXAfLp+yKIiFqQUvySC
 RiEyuxR3KGCc+EoY8lS9LHCFb2jQXhlXJX82zPZTdq6hwNsrbmEz/62p+yl7Wg==
X-Gm-Gg: ASbGncsriPlE5UFmUhYg2R3MLWCjWnxRp9i1iUDU/ty9s+Hx0DADKe8djlq2O9dnpB9
 mt8Zt/v0rEvYY4ej0dkH2iDn28Mh2RtcCHJcXZG/P4QDxAI1h24SfB108tL/svvYEm8r40XhSIx
 bxBBXfsJlu6UDglPRBFS1RFmR9xUvNJerqNBes3OZtLprBGnuo+ydAXD6dKpPRH1x+5PdEW+s+V
 CTKy+WxiRTaac/ojW/TfXDjElOAeTd/nGhlIuoVI0c4eTmYfSVBkguokI+nmPWq+tq1c756ntkc
 5lxi07apZj7T7DF1y/9XcfsiHW60kfLMcxFde5ffpfqustChANhrF3REHQREHcMjHqEIVKR4spE
 7F2lVwqujcAhtjRiD1b5qVLS/lJnM0BvNr1O//k1v7Ic54zsjD3a4GMT5euy1QpIP9Nfy61SKqp
 vOsRZJIBr4AlD7klnr5rHwmVaKqkdU4A==
X-Google-Smtp-Source: AGHT+IHaJpMIloi/MYAqKpUicwL+gClcixhn9HPcFPObcZqst5TQ0FGXAheGqzit7waCPmhJ+36OgA==
X-Received: by 2002:a05:600c:3112:b0:456:8eb:a35c with SMTP id
 5b1f17b1804b1-458b6b5707cmr33184155e9.31.1754149919471; 
 Sat, 02 Aug 2025 08:51:59 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24DDB700267C66B850A0E369.dsl.pool.telekom.hu.
 [2001:4c4e:24dd:b700:267c:66b8:50a0:e369])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c4818c1sm9451854f8f.65.2025.08.02.08.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 02 Aug 2025 08:51:58 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH] drm/amd/display: Fix DP audio DTO1 clock source on DCE 6.
Date: Sat,  2 Aug 2025 17:51:53 +0200
Message-ID: <20250802155153.6432-1-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.50.1
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

On DCE 6, DP audio was not working. However, it worked when an
HDMI monitor was also plugged in.

Looking at dce_aud_wall_dto_setup it seems that the main
difference is that we use DTO1 when only DP is plugged in.

When programming DTO1, it uses audio_dto_source_clock_in_khz
which is set from get_dp_ref_freq_khz

The dce60_get_dp_ref_freq_khz implementation looks incorrect,
because DENTIST_DISPCLK_CNTL seems to be always zero on DCE 6,
so it isn't usable.
I compared dce60_get_dp_ref_freq_khz to the legacy display code,
specifically dce_v6_0_audio_set_dto, and it turns out that in
case of DCE 6, it needs to use the display clock. With that,
DP audio started working on Pitcairn, Oland and Cape Verde.

However, it still didn't work on Tahiti. Despite having the
same DCE version, Tahiti seems to have a different audio device.
After some trial and error I realized that it works with the
default display clock as reported by the VBIOS, not the current
display clock.

The patch was tested on all four SI GPUs:

* Pitcairn (DCE 6.0)
* Oland (DCE 6.4)
* Cape Verde (DCE 6.0)
* Tahiti (DCE 6.0 but different)

The testing was done on Samsung Odyssey G7 LS28BG700EPXEN on
each of the above GPUs, at the following settings:

* 4K 60 Hz
* 1080p 60 Hz
* 1080p 144 Hz

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 .../display/dc/clk_mgr/dce60/dce60_clk_mgr.c  | 21 ++++++-------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
index 0267644717b2..883591706db9 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce60/dce60_clk_mgr.c
@@ -83,22 +83,13 @@ static const struct state_dependent_clocks dce60_max_clks_by_state[] = {
 static int dce60_get_dp_ref_freq_khz(struct clk_mgr *clk_mgr_base)
 {
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	int dprefclk_wdivider;
-	int dp_ref_clk_khz;
-	int target_div;
+	struct dc_context *ctx = clk_mgr_base->ctx;
+	int dp_ref_clk_khz = 0;
 
-	/* DCE6 has no DPREFCLK_CNTL to read DP Reference Clock source */
-
-	/* Read the mmDENTIST_DISPCLK_CNTL to get the currently
-	 * programmed DID DENTIST_DPREFCLK_WDIVIDER*/
-	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DPREFCLK_WDIVIDER, &dprefclk_wdivider);
-
-	/* Convert DENTIST_DPREFCLK_WDIVIDERto actual divider*/
-	target_div = dentist_get_divider_from_did(dprefclk_wdivider);
-
-	/* Calculate the current DFS clock, in kHz.*/
-	dp_ref_clk_khz = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
-		* clk_mgr->base.dentist_vco_freq_khz) / target_div;
+	if (ASIC_REV_IS_TAHITI_P(ctx->asic_id.hw_internal_rev))
+		dp_ref_clk_khz = ctx->dc_bios->fw_info.default_display_engine_pll_frequency;
+	else
+		dp_ref_clk_khz = clk_mgr_base->clks.dispclk_khz;
 
 	return dce_adjust_dp_ref_freq_for_ss(clk_mgr, dp_ref_clk_khz);
 }
-- 
2.50.1


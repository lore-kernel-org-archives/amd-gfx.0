Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 600EDC83F17
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Jul 2025 09:44:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D9B410E745;
	Thu, 31 Jul 2025 09:44:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DaHN7iJy";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B76710E745
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 09:44:18 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4561ed868b5so1702915e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Jul 2025 02:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753955057; x=1754559857; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=18EWQRVjeD48y6J2w9JLfojFWsvNuxCtAypVPakRPuE=;
 b=DaHN7iJy8WQZ0nsR+mjwb7MJJCKBx7/H0rtyDU7zb4b1kC7XjMIv+AE2gWoYqT0oB+
 IBUSnxVStO5ZH3t7W4gezcQLuVC3cryp44Zjhc8hCdvDbV2jvMYmQ6JOIVFNf6SZ0NtR
 W8JYek2EJ5pwHMh1jSlNDhHhKNiM9/wWHTJ7OXW1mcaUo4cIpkODN3cKntD2qoG1VP7x
 +0/7+69J/LkSNhhGJPOblz8EkUGbbJz8VfJSqJY/K5cGwe6Fr1wPLc5UWu0eKlzd21MB
 mtzonIltfX6KNgDSWyvgP9HSDjuV3ZYofDxj247KOPzTjuCBS4Plrz7RH2uOci89gHrI
 UV8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753955057; x=1754559857;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=18EWQRVjeD48y6J2w9JLfojFWsvNuxCtAypVPakRPuE=;
 b=kQynjdy5tdmpdajH7apw8xEJg2mnnKZUAdNIznlv90TA99+hRfKD1mP1a6+aThMAIs
 dkh2v/160mpKCRnJqfBBj6pkQbg7NPTIn2FekKZ+HnE9KJeQJCFrlSLRFgXL7orXw9D8
 h06IshESJvaS9GcNRteEEIr+G6/UJIkRS/ema6uBSaDkCccLGj7yTirI+GzysWOmfpv2
 uhCj5X46Qr6KkVup88SUxWXyh+WdDWCb8l/TlhdB+WOT0NEW1xOiJwaM88uGmXG315Il
 0gW+fY6BFBSzQECNwmLC4U6FKSB79BvFDtD95CjW6GvvM7HmjnSoJon/I6vVx4JIBHXH
 w4BA==
X-Gm-Message-State: AOJu0YykdoG0wcnvDUyjwYUtg1i1yIpKgEFQ+lAkvXLHE1piWaQEaTky
 PdNOw247Bf8luVKA2k3cECgqX5qZ2SJjHRKrNm6RiSO1NAkUw1dqtnWJOMfiSA==
X-Gm-Gg: ASbGncvjQfFy8ZKz7nQQok7nz2+CbX495je+zozYDmbgEIbh0ueK9A4TnzsO0pv16e7
 QjLGcJwh9atd3KynqQQFeoPVERLu2p/wV0IQBN5o60dyzG8YFCiXLsUlCHkcN2hkaX5P9Vag0aT
 QoB9/0FUIn/M2ngaDHaQrHuv/rT+F94V9HFEKnmZfTtjy/LZpl+tHBm6rRQtd2Rs0YjuZ1HWOZ6
 UWQrLLAVAJgQU9XK0aljZJMMv18GEUAqfgsPXmZcd8oLIMQ+H2reMKm+PAUenrnuQalXS+06cCV
 jRV2BAWIVQLclUB5M6Cb1Amv1WI2KneqEIjQ1YROup+vCjMNS5Aga/tuUqQ0jrvMzRJJBpM4H9d
 DeYz8kow9RgpG/D+8kNY+xMgWZcVm8EGl+cB8AFNeMIjIJoyh29S5732kg+QH6k79Yx8VBrqjMz
 UetF3mKcj0pUWFRG9div3LcbSTJVmaug==
X-Google-Smtp-Source: AGHT+IFuqfNxa+s2G/RjsxbaR0pynAjz4G6XgEirlVPPLjBZr6IYW0OYoXX9Un2z/CkeRbbjjJBexg==
X-Received: by 2002:a05:600c:3e8f:b0:456:201a:99f with SMTP id
 5b1f17b1804b1-45892bc022bmr62866745e9.18.1753955056969; 
 Thu, 31 Jul 2025 02:44:16 -0700 (PDT)
Received: from Timur-Hyperion
 (20014C4E24DDB700267C66B850A0E369.dsl.pool.telekom.hu.
 [2001:4c4e:24dd:b700:267c:66b8:50a0:e369])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4589536b3b4sm58252835e9.3.2025.07.31.02.44.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 02:44:15 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/7] drm/amd/display: Adjust DCE 8-10 clock,
 don't overclock by 15%
Date: Thu, 31 Jul 2025 11:43:47 +0200
Message-ID: <20250731094352.29528-3-timur.kristof@gmail.com>
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

Adjust the nominal (and performance) clocks for DCE 8-10,
and set them to 625 MHz, which is the value used by the legacy
display code in amdgpu_atombios_get_clock_info.

This was tested with Hawaii, Tonga and Fiji.
These GPUs can output 4K 60Hz (10-bit depth) at 625 MHz.

The extra 15% clock was added as a workaround for a Polaris issue
which uses DCE 11, and should not have been used on DCE 8-10 which
are already hardcoded to the highest possible display clock.
Unfortunately, the extra 15% was mistakenly copied and kept
even on code paths which don't affect Polaris.

This commit fixes that and also	adds a check to	make sure
not to exceed the maximum DCE 8-10 display clock.

Fixes: 8cd61c313d8b ("drm/amd/display: Raise dispclk value for Polaris")
Fixes: dc88b4a684d2 ("drm/amd/display: make clk mgr soc specific")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>

x
---
 .../drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c  | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
index 26feefbb8990..69e9540f553b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dce100/dce_clk_mgr.c
@@ -72,9 +72,9 @@ static const struct state_dependent_clocks dce80_max_clks_by_state[] = {
 /* ClocksStateLow */
 { .display_clk_khz = 352000, .pixel_clk_khz = 330000},
 /* ClocksStateNominal */
-{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 },
+{ .display_clk_khz = 625000, .pixel_clk_khz = 400000 },
 /* ClocksStatePerformance */
-{ .display_clk_khz = 600000, .pixel_clk_khz = 400000 } };
+{ .display_clk_khz = 625000, .pixel_clk_khz = 400000 } };
 
 int dentist_get_divider_from_did(int did)
 {
@@ -400,11 +400,9 @@ static void dce_update_clocks(struct clk_mgr *clk_mgr_base,
 {
 	struct clk_mgr_internal *clk_mgr_dce = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dm_pp_power_level_change_request level_change_req;
-	int patched_disp_clk = context->bw_ctx.bw.dce.dispclk_khz;
-
-	/*TODO: W/A for dal3 linux, investigate why this works */
-	if (!clk_mgr_dce->dfs_bypass_active)
-		patched_disp_clk = patched_disp_clk * 115 / 100;
+	const int max_disp_clk =
+		clk_mgr_dce->max_clks_by_state[DM_PP_CLOCKS_STATE_PERFORMANCE].display_clk_khz;
+	int patched_disp_clk = MIN(max_disp_clk, context->bw_ctx.bw.dce.dispclk_khz);
 
 	level_change_req.power_level = dce_get_required_clocks_state(clk_mgr_base, context);
 	/* get max clock state from PPLIB */
-- 
2.50.1


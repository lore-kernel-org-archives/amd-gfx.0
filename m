Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC39310ED671
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Mar 2026 12:41:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 049FC10EE1C;
	Fri, 27 Mar 2026 12:41:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RBlCoUK5";
	dkim-atps=neutral
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com
 [209.85.215.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 923E910EB28
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 23:47:46 +0000 (UTC)
Received: by mail-pg1-f178.google.com with SMTP id
 41be03b00d2f7-c73c990a96dso798945a12.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Mar 2026 16:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774568866; x=1775173666; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R5FyONZ8Ftg8PcUrjhCTmSRITsVvMq+p91xq+TbWIsM=;
 b=RBlCoUK5QVe8RVKoz1rCHG3QX+g6kpL+NVJ896uf3toRqAMMkqHa7LfQtms8jSsHld
 UiaLs3VfUz7jD38OATTEfoUw6cpHeFSCaSfMcJ/yznDmgWekkf5l5EveZU55e5Hjvv64
 DNwSYtf9x3JFkU9cuGYZAohz/G5KZOlQy0NGBoO+r/AyDbgPwhqp/rIMA6hi4CRFJ+yK
 V2xnSVF1bCLplcJlvm+fZ1CKhMUYBNyeIXD3OI2imMCRTsAMWw1NuS+6w+yOTvT22NyF
 RFNvdY76mwuGJ8jWxrJMvBo5n2e3itxKOjVv+Xbr8CjO8NfdycN1dfqqj43s+tBEmriO
 Tyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774568866; x=1775173666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R5FyONZ8Ftg8PcUrjhCTmSRITsVvMq+p91xq+TbWIsM=;
 b=iy1XcHAJ1pOPZGCLoV3V4/rQTUJGd/OvdXLJTfQprPL86hLLywL5dmRK7XlYWETXyM
 Py+OHr1ZW5nSDAQkJZ4UbfLXs5Ozh3wCytvaybjEFjxkwxY43UfCy/E8SKQAkZkotf8c
 r3oEiGW3tFLptSiGRI+1qtrqmDZlQjxX6FLFGhNIHXjHhDQPMoLdGdCu1s4d0qAYXpJn
 LNdNUVTBtxDv3mojEOJoM5mXV0wRz2UwSl+Xw9PZgVW741Gp+SS+wpygTRfreSP5Eu4B
 3u5Z44OvzIlUtIZRCKsp4no54vzlBM5Be9ekOCAVM/vK/KUMDWvgNPaG4jQRE03o5xjP
 SgnQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0Zd5h3SLeV6Stw3aT/MPRcAFcx4SalCDngL+zMbQlL5aS3RGl4nLmxulomUboudVtdIhIY/Rs@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyfsEPYavtOG2jqhNvhE98JSMg16v1JyjNXsrhPf68NNy+/xo0T
 m72qBY72kAH2COFYA4qFQBTVE1TmoM/Qyk2brdJgFnx0z9ruybCCUcU+
X-Gm-Gg: ATEYQzxzB4TSwHtwfhAWvipbHGhq+G8b0XYeHGZS9umyuAxgfBehTI+y0QDKboncK6g
 AHMrmABzIMiMH8kmeuVjDrOqnc+zaLwh5hfmXCUQHIndjAwIPaezo8SPh1jjEjN5Gl8OKzTpOGb
 +suI99rSQdDWSFIU7OEpp/zjLVlNRo6Xj40Cl5/qE+ZAVUcjRGZfHQBrxj2HwMwSWiSNINkTME2
 rTX3xSgGc84AAAhOympLACeGYsgxsWjaGyBDHZUt/gwlwfpcqbeAfLjEs6hHsNsS+PCm0RKc2gE
 TxVIz0TCxUqt1t9GJuubL+upF6QpUC47etULcqidsYwd0ZBsWC7BGj7VTUc00jMX9KFJqJUXw1t
 pQCxY+51i6JO3wMyrJYY1L6mPFX/5tNZllacH2c9F7tHY96ktlzU7FI4p/Yk1e9lUKNMbBtdQGH
 /A29HBRXIIM69xI89w+AsO52SCb3JEPUZURmQZYupELgXdBkc6Wv2eq9E=
X-Received: by 2002:a05:6a21:6d97:b0:398:b16f:703e with SMTP id
 adf61e73a8af0-39c87abf84fmr507549637.40.1774568866039; 
 Thu, 26 Mar 2026 16:47:46 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d::8bd])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c7673933816sm3201162a12.21.2026.03.26.16.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 16:47:45 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "Pan, Xinhui" <Xinhui.Pan@amd.com>, David Airlie <airlied@linux.ie>,
 Daniel Vetter <daniel@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>,
 Leo Li <sunpeng.li@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bin Lan <bin.lan.cn@windriver.com>, He Zhe <zhe.he@windriver.com>,
 Vitaly Prosyak <vitaly.prosyak@amd.com>, Alex Hung <alex.hung@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Mario Limonciello <Mario.Limonciello@amd.com>, Ray Wu <ray.wu@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Roman Li <Roman.Li@amd.com>,
 Eric Yang <Eric.Yang2@amd.com>, Tony Cheng <Tony.Cheng@amd.com>,
 Mauro Rossi <issor.oruam@gmail.com>,
 amd-gfx@lists.freedesktop.org (open list:RADEON and AMDGPU DRM DRIVERS),
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-kernel@vger.kernel.org (open list)
Subject: [PATCH for 6.12 5/9] drm/amd/display: Keep PLL0 running on DCE 6.0
 and 6.4
Date: Thu, 26 Mar 2026 16:47:12 -0700
Message-ID: <20260326234716.16723-6-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260326234716.16723-1-rosenp@gmail.com>
References: <20260326234716.16723-1-rosenp@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 27 Mar 2026 12:40:01 +0000
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

[ Upstream commit 0449726b58ea64ec96b95f95944f0a3650204059 ]

DC can turn off the display clock when no displays are connected
or when all displays are off, for reference see:
- dce*_validate_bandwidth

DC also assumes that the DP clock is always on and never powers
it down, for reference see:
- dce110_clock_source_power_down

In case of DCE 6.0 and 6.4, PLL0 is the clock source for both
the engine clock and DP clock, for reference see:
- radeon_atom_pick_pll
- atombios_crtc_set_disp_eng_pll

Therefore, PLL0 should be always kept running on DCE 6.0 and 6.4.
This commit achieves that by ensuring that by setting the display
clock to the corresponding value in low power state instead of
zero.

This fixes a page flip timeout on SI with DC which happens when
all connected displays are blanked.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
index 7886a2a55caf..c4d7fa60d654 100644
--- a/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dce60/dce60_resource.c
@@ -889,7 +889,16 @@ static bool dce60_validate_bandwidth(
 		context->bw_ctx.bw.dce.dispclk_khz = 681000;
 		context->bw_ctx.bw.dce.yclk_khz = 250000 * MEMORY_TYPE_MULTIPLIER_CZ;
 	} else {
-		context->bw_ctx.bw.dce.dispclk_khz = 0;
+		/* On DCE 6.0 and 6.4 the PLL0 is both the display engine clock and
+		 * the DP clock, and shouldn't be turned off. Just select the display
+		 * clock value from its low power mode.
+		 */
+		if (dc->ctx->dce_version == DCE_VERSION_6_0 ||
+			dc->ctx->dce_version == DCE_VERSION_6_4)
+			context->bw_ctx.bw.dce.dispclk_khz = 352000;
+		else
+			context->bw_ctx.bw.dce.dispclk_khz = 0;
+
 		context->bw_ctx.bw.dce.yclk_khz = 0;
 	}
 
-- 
2.53.0


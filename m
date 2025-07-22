Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D2B4C87FCA
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Jul 2025 15:58:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 334CE10E2E6;
	Tue, 22 Jul 2025 15:58:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hqBaSbNC";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7847389BEC
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 15:58:46 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-456108bf94bso40759955e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Jul 2025 08:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753199925; x=1753804725; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SlqSwLv86CV93GPyyDJLs+UYZf/H8AKD/3RSf4BX1cE=;
 b=hqBaSbNCkn7LgrOo81RtPTgcSNC9FFci8zZQfK48MqT/3BBh/TAT18uUVk3qh4GvBK
 fYHBsn4IdB7WPUyNBsS5x8gxHI3EgC3od8ECo7/ZKmWUisYcO+Lah8pB4n/qaC6Lu4Qz
 k5mpxlc2J/zJLSd1AmOHtOekWq/j4642t9jIIKahy95TfqW5nb9d8f13QGUQkOL4mcY7
 OVXgemxivkJSkA8QytkXEwVc+akIjUGrPlVP5EBhKH+TfKjZtePmkUFfDh+SeDrvYSR/
 MFRaA0yp/SC0AloFqG5nu2UxBg1VEu4xYUd7KOtwKglxb6WKJxVkPtVvEjRGEFVXw874
 P64g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753199925; x=1753804725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SlqSwLv86CV93GPyyDJLs+UYZf/H8AKD/3RSf4BX1cE=;
 b=oyh5yDpE5m6qyBx0+80ghYiSZ+kZnSMnUL/va4hlVgHGRgTDOftP4azFXv6Vqd5Gem
 qbTg/m/pEZFXz3osREd82o8cN2eIsGsfXDnvOuEM09Fh2ekitTmgB7EosBd3zFHTE4YZ
 E7u+L1CoDBQVihI1Z9BJFTF9FTloItXQ+qEtli5uQy7J4fNC8T4kc5yHg4RLtqmhqfCo
 tecaJYR9W7Q8eXYg11tQPgdfLpQQjqFi6dpyIzZ2s6dTSfW2eDOK6t6TCxrvhU11NOuD
 lxjBKxCgqfJV7N3N8BxUvuGxVUyRRN5Qcy+vO5l86tqz9aAklOAxHS1QloVRsPfLE8Ji
 mwrQ==
X-Gm-Message-State: AOJu0YwsMJM0HYxOq14RPGhkz1kg2W1dbTakXoimDXHosWz5SHreVaFE
 ujgE/x/aUvnaBjf88YFetwkN3OkTE3L0FGDsGc6CZoyIAQh3eEVi1rA/Q3H/VQ==
X-Gm-Gg: ASbGnct8lCDS/Ip1o76dnx93TIDhT8UjrwEjH6B1Q7zccBmSXflAolXeYau1OfDGnFc
 7KUfAjdFk0KltDKg0ASKYXC66WP3/weGneD4ugnYLulM6WYGlHYYDx2u+WxBekKFeAZvVXLEpWl
 DjZFfvNSAnHKpG2CGnkI/1dlufO8V1Ro7eiAc1zNKS/8VtTmG3DyTPZk3Bl98EUaSNyn5g2tWJH
 lYwRWvA4oJ1wEnwEGQi0mKZFb4bwcToEMPd+Wj1Ml/zKliAOdmPu/VUPD/SHVmP+ivaBQU24g8v
 fLLBxb/662xCn7Aum8EJv225AQ3T3ohW+dH6c9Fg9ee/LcvTj5a0d8ei1G/xJ+5HoN4iDrayoxD
 4F/mfHohCGQ+7512bW3o9f4h9E+wKM9GR
X-Google-Smtp-Source: AGHT+IEPkZbiz2bQXjAAeOvp8npWcbSTBmeFz13FcSvB75B6fPNOR6wNIvL6/pSUWYuydugVDDAx6g==
X-Received: by 2002:a05:6000:3111:b0:3a4:f66a:9d31 with SMTP id
 ffacd0b85a97d-3b60e4d6272mr21063320f8f.16.1753199924766; 
 Tue, 22 Jul 2025 08:58:44 -0700 (PDT)
Received: from Timur-Hyperion ([2a0a:f640:1810:c696:604:c93:8102:bad7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b61ca4893fsm13948241f8f.52.2025.07.22.08.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Jul 2025 08:58:44 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 1/3] drm/amd/display: Fix refactored DSC cap calculation
Date: Tue, 22 Jul 2025 17:58:28 +0200
Message-ID: <20250722155830.67401-2-timur.kristof@gmail.com>
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

After refactoring the DSC capability calculation, the
get_min_slice_count_for_odm could crash on some GPUs due to a
division by zero when max_total_throughput_mps was zero.
As a result, DC was broken when connecting a GPU that doesn't
support DSC to a monitor that supports DSC.
Tested on Oland (DCE 6) and Fiji (DCE 10).

This commit fixes it by returning zero instead.

Fixes: 4909b8b3846c ("drm/amd/display: Refactor DSC cap calculations")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
index a454d16e6586..4169ece9c535 100644
--- a/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
+++ b/drivers/gpu/drm/amd/display/dc/dsc/dc_dsc.c
@@ -642,14 +642,15 @@ static unsigned int get_min_slice_count_for_odm(
 	unsigned int max_dispclk_khz;
 
 	/* get max pixel rate and combine caps */
-	max_dispclk_khz = dsc_enc_caps->max_total_throughput_mps * 1000;
-	if (dsc && dsc->ctx->dc) {
-		if (dsc->ctx->dc->clk_mgr &&
-			dsc->ctx->dc->clk_mgr->funcs->get_max_clock_khz) {
-			/* dispclk is available */
-			max_dispclk_khz = dsc->ctx->dc->clk_mgr->funcs->get_max_clock_khz(dsc->ctx->dc->clk_mgr, CLK_TYPE_DISPCLK);
-		}
-	}
+	if (dsc && dsc->ctx->dc && dsc->ctx->dc->clk_mgr &&
+		dsc->ctx->dc->clk_mgr->funcs->get_max_clock_khz)
+		max_dispclk_khz =
+			dsc->ctx->dc->clk_mgr->funcs->get_max_clock_khz(
+				dsc->ctx->dc->clk_mgr, CLK_TYPE_DISPCLK);
+	else if (dsc_enc_caps->max_total_throughput_mps)
+		max_dispclk_khz = dsc_enc_caps->max_total_throughput_mps * 1000;
+	else
+		return 0;
 
 	/* consider minimum odm slices required due to
 	 * 1) display pipe throughput (dispclk)
-- 
2.50.1


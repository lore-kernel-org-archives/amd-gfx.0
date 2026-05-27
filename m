Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 780AFCD6E4F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 May 2026 07:29:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76AD610ED1B;
	Thu, 28 May 2026 07:29:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dNHZgWPk";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC96410EA63
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 22:25:18 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49039a8851fso66250365e9.2
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 May 2026 15:25:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779920717; x=1780525517; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C4FUK6bGlQKCBvS3S1kY5zaqGmu5ezMWJaZjhEtxgmc=;
 b=dNHZgWPkUX/vCYIxXCxDd0E0hMPjurRqjYOS1tV2jZWcuizbLkn4eUc0OkMca/mVKv
 YB3r4+2OgbG0oQzyc402dx+EgjCMWXSQEHi2XGmoLDjyWaREk2WMk613xzw7rXPNWIXQ
 dTM+JMTNAk9I46XVBdRztRcZMsh+8vks//VnRTuHNTh4H3Sa7cp01hvdSWPqbJpegMNj
 7+vhQCVImLE59Ar7n850sVWfO4mJkhm6iQ2UwNiriBTVZA0uYdB2fmMbWtxcpWbxjKtw
 rU6C4hgtoJpwlg7JJCFA56jytjaqmkSrLD4ZgO4DiUHFGsV/MGRijXULCLxxE5FwqH00
 BROQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779920717; x=1780525517;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C4FUK6bGlQKCBvS3S1kY5zaqGmu5ezMWJaZjhEtxgmc=;
 b=pnT+YC7Fo+gMu1Ew+YoPv+y4oqNAmDjijx5urOnbGaiD0XhmdQpY075IAvYMfKoUmk
 DeT1iII/iSz0dcoDuwPk6zKqyTeoL3Hwz7e/ZRa0PHKge75vfw6BV0wifYw30qNeT89U
 /spt/ZkhH5SUnUSwOFgFkU9WH8qe6Wt46hCWxjK9F4/HZdTVJc9WdC1i5C+m2b1VQI7Y
 q1jPfBQVefaGCFzMlCcAW4Czur1UQinDyKIZHwPA+RVTU6QpShku33sEpYBGnxTmLtJ6
 5Ct/bJ1DO5BLkOwFSpgvAwUg60HnrtCLU0Taj0xm63V5patRYeesIi5kgE4Xb0wQLrea
 RW7Q==
X-Gm-Message-State: AOJu0YwHcxWBcKYwmJME4OgvvOGgldQBmUKCbynEbMSEBfBw0x+b1+RJ
 uJRQNKIdn/3yYdyvFfaKGMV5F2h+DsQQuhKF07160VO3YcJCYAiMOGYo
X-Gm-Gg: Acq92OGxgCTESsrHkwWv9IbPuAparqtYO/5S0jcEEPtRafSQ9vlonJvEKKHKQsNqa7T
 zHAqgnRfFqZ4VzZYq+5gqh27XHy01jeYgm9A89PXKXiiS82FUlIDRWBzuIxEcgzE+yDBGk8sN3/
 WIL93J7MZBoFg0VvzKNF3TZNVer+OA6qPAHkcPqhBFsDE1gjeNZjwtooArxOnLi6e6U9tDdd2NA
 6iEt3aP3673JrqBibyJ0DQgra03jM5ngTDD5hLnkI1rMkAsfsRe08cLnyQTbrXkbmv5VUpi0y+v
 ZU2nEjLLei1EIImhXx3NzkGGousUcAmHWIwTO2LmA1vj8qQxdZbv72dCYFocBbQRgYJaACD6V3H
 AwUhNBmWj8Y5/OdmCGjahk2/7gr/VQ3Sd5W97fGtjMuPtGsqgIh5Yfhy2VCMi8rQKhrd5peZEn3
 CZZEs7Lmd+Jml7jxNw7jH2WS+HMSNP88NIogmeR71i5cS8pqwPbrxAGFYK/Q0W
X-Received: by 2002:a05:600c:821b:b0:490:845e:3a6 with SMTP id
 5b1f17b1804b1-490845e0467mr66028085e9.25.1779920717005; 
 Wed, 27 May 2026 15:25:17 -0700 (PDT)
Received: from skylab.fritz.box ([2a06:4944:10fb:f400:8bcf:c610:569c:aab7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904561a33dsm392712575e9.11.2026.05.27.15.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 15:25:16 -0700 (PDT)
From: Gilles Risch <gilles.risch@gmail.com>
To: alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Gilles Risch <gilles.risch@gmail.com>
Subject: [PATCH v4] drm/radeon: fix internal display on iMac11,
 1 (RV770/DCE3.1)
Date: Thu, 28 May 2026 00:20:13 +0200
Message-ID: <20260527222012.2943-2-gilles.risch@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CADnq5_Pq947+u3U-iVXLanuDQa_WxJKr_=DzJg1z+4rS334NqQ@mail.gmail.com>
References: <CADnq5_Pq947+u3U-iVXLanuDQa_WxJKr_=DzJg1z+4rS334NqQ@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 28 May 2026 07:29:41 +0000
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

The Apple iMac11,1 (27-inch, Late 2009) uses a Mobility Radeon HD 4850
(RV770/DCE3.1) with a 2560x1440 internal panel on an internal
DisplayPort path. Without this fix the display stays dark under KMS.

The same problem already exists for iMac10,1 and iMac11,2. Three fixes:

1. Introduce ASIC_IS_DCE31() for CHIP_RV770 and newer. Note that
   CHIP_RV770 precedes CHIP_RV730 in the enum, so ASIC_IS_DCE31()
   subsumes ASIC_IS_DCE32().

2. Extend the Link B encoder quirk from ASIC_IS_DCE32() to
   ASIC_IS_DCE31() and add iMac11,1 to the DMI list.

3. The 2560x1440 panel needs RADEON_PLL_USE_FRAC_FB_DIV and
   ATOM_ENCODER_CMD_DP_VIDEO_ON. These are limited to iMac11,1
   via dmi_match() to avoid affecting other DCE3.1 boards.

Signed-off-by: Gilles Risch <gilles.risch@gmail.com>
---
 drivers/gpu/drm/radeon/atombios_crtc.c     |  5 ++++-
 drivers/gpu/drm/radeon/atombios_encoders.c | 11 ++++++-----
 drivers/gpu/drm/radeon/radeon.h            |  1 +
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/radeon/atombios_crtc.c
index 2fc0334e0..075eba2d4 100644
--- a/drivers/gpu/drm/radeon/atombios_crtc.c
+++ b/drivers/gpu/drm/radeon/atombios_crtc.c
@@ -24,6 +24,8 @@
  *          Alex Deucher
  */
 
+#include <linux/dmi.h>
+
 #include <drm/drm_fixed.h>
 #include <drm/drm_fourcc.h>
 #include <drm/drm_framebuffer.h>
@@ -594,7 +596,8 @@ static u32 atombios_adjust_pll(struct drm_crtc *crtc,
 		if (((rdev->family == CHIP_RS780) || (rdev->family == CHIP_RS880))
 		    && !radeon_crtc->ss_enabled)
 			radeon_crtc->pll_flags |= RADEON_PLL_USE_FRAC_FB_DIV;
-		if (ASIC_IS_DCE32(rdev) && mode->clock > 165000)
+		if ((ASIC_IS_DCE32(rdev) || dmi_match(DMI_PRODUCT_NAME, "iMac11,1"))
+		    && mode->clock > 165000)
 			radeon_crtc->pll_flags |= RADEON_PLL_USE_FRAC_FB_DIV;
 	} else {
 		radeon_crtc->pll_flags |= RADEON_PLL_LEGACY;
diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
index 5cfd8fcfa..4de60559f 100644
--- a/drivers/gpu/drm/radeon/atombios_encoders.c
+++ b/drivers/gpu/drm/radeon/atombios_encoders.c
@@ -1707,7 +1707,7 @@ radeon_atom_encoder_dpms_dig(struct drm_encoder *encoder, int mode)
 		if (ENCODER_MODE_IS_DP(atombios_get_encoder_mode(encoder)) && connector) {
 			/* DP_SET_POWER_D0 is set in radeon_dp_link_train */
 			radeon_dp_link_train(encoder, connector);
-			if (ASIC_IS_DCE4(rdev))
+			if (ASIC_IS_DCE4(rdev) || dmi_match(DMI_PRODUCT_NAME, "iMac11,1"))
 				atombios_dig_encoder_setup(encoder, ATOM_ENCODER_CMD_DP_VIDEO_ON, 0);
 		}
 		if (radeon_encoder->devices & (ATOM_DEVICE_LCD_SUPPORT)) {
@@ -2123,12 +2123,13 @@ int radeon_atom_pick_dig_encoder(struct drm_encoder *encoder, int fe_idx)
 	}
 
 	/*
-	 * On DCE32 any encoder can drive any block so usually just use crtc id,
-	 * but Apple thinks different at least on iMac10,1 and iMac11,2, so there use linkb,
-	 * otherwise the internal eDP panel will stay dark.
+	 * On DCE31 and DCE32 any encoder can drive any block so usually just use crtc id,
+	 * but Apple thinks different at least on iMac10,1, iMac11,1 and iMac11,2,
+	 * so there use linkb, otherwise the internal eDP panel will stay dark.
 	 */
-	if (ASIC_IS_DCE32(rdev)) {
+	if (ASIC_IS_DCE31(rdev)) {
 		if (dmi_match(DMI_PRODUCT_NAME, "iMac10,1") ||
+		    dmi_match(DMI_PRODUCT_NAME, "iMac11,1") ||
 		    dmi_match(DMI_PRODUCT_NAME, "iMac11,2"))
 			enc_idx = (dig->linkb) ? 1 : 0;
 		else
diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 527b9d19d..6b7c0abe4 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -2625,6 +2625,7 @@ void r100_pll_errata_after_index(struct radeon_device *rdev);
 			    (rdev->family == CHIP_RS740)  ||	\
 			    (rdev->family >= CHIP_R600))
 #define ASIC_IS_DCE3(rdev) ((rdev->family >= CHIP_RV620))
+#define ASIC_IS_DCE31(rdev) ((rdev->family >= CHIP_RV770))
 #define ASIC_IS_DCE32(rdev) ((rdev->family >= CHIP_RV730))
 #define ASIC_IS_DCE4(rdev) ((rdev->family >= CHIP_CEDAR))
 #define ASIC_IS_DCE41(rdev) ((rdev->family >= CHIP_PALM) && \

base-commit: e7ae89a0c97ce2b68b0983cd01eda67cf373517d
-- 
2.47.3


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D314C5DF71
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Jun 2026 07:24:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41DB310ECB7;
	Tue,  2 Jun 2026 07:24:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NEDi/VSc";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4737510E568
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2026 21:20:04 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-490ace40f4bso12564945e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2026 14:20:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780348803; x=1780953603; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qnwAsy6Fhk/v2/m0U2Y/k7DuV+rs4ovp810ofu9BhuY=;
 b=NEDi/VScMjuj5aFKmTiM5JRYCjNNrMXAKTFYWWbpK+wuqXkZa1JGF0m+lfoA84OkDF
 00fIXxQMWY8qfFys1C6JAGrodAvx532OofEuy0Pzh6kTGr6Y7DG98FasV0xT0MpsAeI9
 +szfIZk91586GAMJ8ZqNWJzOUeykl6bbHIFjtMHCDA37xqz9a9RdP9iiks9sRPophwpo
 bKtzx4nPcvq5C/pcGVcq8Ir+PsKJ0KL2K9LW3OdsIqYwfgNf2jdf1xmISWLpD/Wcy1aw
 vvYg07qFVGgVgWbg/lVIKbiVVTncyUa2Cj8GWmlPclGYYTIYUYvuOGePgzMXlBa6UZJf
 Rmkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780348803; x=1780953603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=qnwAsy6Fhk/v2/m0U2Y/k7DuV+rs4ovp810ofu9BhuY=;
 b=cMQLOTShogVFc81H5/KeuXhh3JCcPuK6zTSVMEgYQOmdGNK3EVNHa9KM4xtscDvdUs
 E7lQ8mgzHjespp0CQtWytMZTNHz46b8m0yBvM1DL5L8n3J/A8ysUDW/aAxVmijJk3xkY
 iI1+Rmm592KZOrKjgREgRklQzA6rMnkjHP9MNfA3bbgyF+GaU2/RbLoomYWtlBOTQ/pJ
 18g37a9P2bEt2mWTDNr4NoLH7KYaGVeIjgxK+fbybLe36RipjZO2tXzp8HebKUcwC0gX
 AKlbc3p5bUILKT0gUotWLR2FI5NN7vE6SlExjsO27XVBhmiaC8Q51O3qY+hFyW5yn803
 FpHA==
X-Gm-Message-State: AOJu0YzqTL9oGzyZ5wDpR9lQxFquQkxTYrSSq0gfiyy9ZcEPW+L2TAb4
 L3E5JaLsShFuK1KhvKnj4o/Ub2cr/ONEp4A06yxj9THOXl++z0Kj7ILH
X-Gm-Gg: Acq92OFiYDw6+WAAeSAmIv8pR8dw8aI6tzcR/3gfkHeZTfcKY/eQyNk2Wmd0wtElXbj
 Y/+Ek43hbk6dq9xu2nDLuXvMtNS7AHBetX2zqNfhVrAs5kQWWITLbiwQJ+J0hKBRPG1znQZBq86
 kO5Bv6K8WRYGEVvA7pdz2wNw8xoIGl2a6JgYveo28WPg/2aNKs0ZwGNHaXqqDyHqMZ6N4H0FnV/
 T2dQCjaz2MqbDmuIy9FHdN+vCtmxHy0Aiz0OxwafM2tmmsw17nx6yc1R+ZnF0l8o6Edi0rlZpCS
 vijFUGDNDYaUClM5EepK/Kq+A1RhrEnyOxuQEt6xf8f9Ph0/QWUBxNJbvFeBT/F4XBE8IIkMMO/
 88Er1o4eU5wqumGRF2O64E62fJnB9B7qDFZghDav3IASaGfPIMkg7SgVnbJpVwL7lgwztR3YQ2Q
 44YsugM5edFBcvwjW80N39l/tqZ+NnxOGeyij8/SfDSRPGfxbm
X-Received: by 2002:a05:600c:4fc4:b0:490:6889:202 with SMTP id
 5b1f17b1804b1-490a29639e6mr225017555e9.29.1780348802385; 
 Mon, 01 Jun 2026 14:20:02 -0700 (PDT)
Received: from skylab.fritz.box ([2a06:4944:10fb:f400:8383:b4e3:3885:b00a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490ad63b34dsm19778925e9.27.2026.06.01.14.20.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 14:20:01 -0700 (PDT)
From: Gilles Risch <gilles.risch@gmail.com>
To: alexander.deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Gilles Risch <gilles.risch@gmail.com>
Subject: [PATCH v5] drm/radeon: fix internal display on iMac11,
 1 (RV770/DCE3.1)
Date: Mon,  1 Jun 2026 23:19:32 +0200
Message-ID: <20260601211931.2837-2-gilles.risch@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CADnq5_Os2Bk8Dd9d8m_CkK9nYSporzUqbiRA=YD85nRBB6XjMw@mail.gmail.com>
References: <CADnq5_Os2Bk8Dd9d8m_CkK9nYSporzUqbiRA=YD85nRBB6XjMw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 02 Jun 2026 07:24:17 +0000
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

This machine suffers from the same issue as iMac10,1 and iMac11,2:
Apple routes the internal display through Link B of the DIG encoder
instead of Link A. Add iMac11,1 to the existing DMI quirk and move
the Apple-specific encoder assignment into its own block, independent
of the DCE version check.

Additionally, the 2560x1440 panel requires RADEON_PLL_USE_FRAC_FB_DIV
and ATOM_ENCODER_CMD_DP_VIDEO_ON, limited to iMac11,1 via dmi_match()
to avoid affecting other boards.

Signed-off-by: Gilles Risch <gilles.risch@gmail.com>
---
 drivers/gpu/drm/radeon/atombios_crtc.c     |  5 ++++-
 drivers/gpu/drm/radeon/atombios_encoders.c | 23 ++++++++++++----------
 2 files changed, 17 insertions(+), 11 deletions(-)

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
index 5cfd8fcfa..8b3f8303a 100644
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
@@ -2123,17 +2123,20 @@ int radeon_atom_pick_dig_encoder(struct drm_encoder *encoder, int fe_idx)
 	}
 
 	/*
-	 * On DCE32 any encoder can drive any block so usually just use crtc id,
-	 * but Apple thinks different at least on iMac10,1 and iMac11,2, so there use linkb,
-	 * otherwise the internal eDP panel will stay dark.
+	 * Apple routes the internal eDP panel through Link B of the DIG encoder
+	 * instead of Link A on the iMac10,1, iMac11,1 and iMac11,2.
+	 * Use linkb to avoid a dark display.
 	 */
-	if (ASIC_IS_DCE32(rdev)) {
-		if (dmi_match(DMI_PRODUCT_NAME, "iMac10,1") ||
-		    dmi_match(DMI_PRODUCT_NAME, "iMac11,2"))
-			enc_idx = (dig->linkb) ? 1 : 0;
-		else
-			enc_idx = radeon_crtc->crtc_id;
+	if (dmi_match(DMI_PRODUCT_NAME, "iMac10,1") ||
+	    dmi_match(DMI_PRODUCT_NAME, "iMac11,1") ||
+	    dmi_match(DMI_PRODUCT_NAME, "iMac11,2")) {
+		enc_idx = (dig->linkb) ? 1 : 0;
+		goto assigned;
+	}
 
+	/* on DCE32 and encoder can driver any block so just crtc id */
+	if (ASIC_IS_DCE32(rdev)) {
+		enc_idx = radeon_crtc->crtc_id;
 		goto assigned;
 	}
 
-- 
2.47.3


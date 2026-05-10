Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 715DBCD37AC
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 12:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBA1B10E1B2;
	Mon, 11 May 2026 12:46:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ObaZCJqK";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C198B10E1D1
 for <amd-gfx@lists.freedesktop.org>; Sun, 10 May 2026 18:54:35 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so40620855e9.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 10 May 2026 11:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778439274; x=1779044074; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QuqzRHtsg71BZnzhF/X7DvgsYZCUBca3nqqVT5JC5t8=;
 b=ObaZCJqKSv1DOSw6VSceMqkFMj0howek5r78s0247gS4rre+RTtRRfF0yLSZcoijT4
 78cPqCUeEjddxnTGcUXIdYnQ2sT6kd7uhqAT70Y1cAD5TETkQT1DFVUg+2NoSCp5HJDj
 haaKj4UCGOhfmg+6luRP0fWsok97YhpLsp+peZ238mwwdAgkRMmBrZYF2OvfcFPI5H8j
 rmNcY1HGkxz0ykX7brTVOp3o+3YhpCeGwU/nSPoCuYj9OwRSvtkFSXvGFx/Saipcj4ly
 fRgyY09b9mOqyNo0UC1TlCzlnvtp3qAR988Kw9AOf59CaSKcBTN8oO3a4RjC3VlasK5r
 XMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778439274; x=1779044074;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QuqzRHtsg71BZnzhF/X7DvgsYZCUBca3nqqVT5JC5t8=;
 b=Kt/B1M4Y5ZI9ueXe12LfYwxBn98Ku9PtcOwfYFt4NCDiaeRLZU9oqBwCbxoOy7KMoH
 GMNZ43Q5oDFojMslSagReyQMSaUCrwiac5I2QJuUMCIBpAm/+mPqKnPk6/ZX8WlPOscf
 EF0gNE3/BJnf3l4QfeDRcNlp4/ogfPMJTP6VeOu1rNE6siDRu/LdYY4xtobtKSJPhvEm
 B33I5j+4IPiou1AWX+gRBL/rs2y/zy+Xf6cDyvpk+Ycy5UV1jzzfS2IxrdMROUKGLLpp
 QFsxDEy4ykUyhZ7SrTGZwY8bOaCIfCXy5bhXOj2pr2pxwtQ0GZAMuZRtU6SZACuzDBj8
 GWUQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8mZ+m56SDVSa2BgLZCHicG2eyWQPIgxe1M+n+hcT02c5vWDUczYLmhRyEoYvsl1IXpC9nHENks@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1pw1XWrg6nd0vf8muGao8L2W1HrMGMs7MUvys2lXe6NGoksM9
 Ew5lVGn5jCjeIoUQyppyx9857ORrQC7QLx+MMPG/XWoHC/dAci8YQYGh
X-Gm-Gg: Acq92OFkpQWOwYSmpI9Qb42AK398k65pmZhUSqn4Rx6Fc+7oNIs6E1oaYlXlphUvcdw
 bwU47SSJIAISh+BZ8TnV03l3ws0QrEvVpH+Au0o7VNmzUngnTyFMRZI9fzrwtH492ScZRsd7tRR
 6p/lkGWtI6wpd1v/+G+w8jDy6K5LV2vQF7lPrLssZ30OmHdrxWdMQDvgsnNViz0TueZtUMrGyLr
 Yqof8uGy3WzN8SOlfTaik8Ze7R3ejRXr9/oK7sst8ZxEqMJOga2XK6/bbzUnyl9Hr4fHfNRPtFj
 RU8dDmiwavtpeFdC6mWLtpvlQNV+Ssz65TiYloiLAxvbdoIYnPzy/W4K1KkAXGuYE7g6N10bCJv
 TnKlPQsxii9EEDb8+dsuOEQju28jRK8Z4s/GrLW3jCbv3nXCB6aWjEx5pw+cwdMyji9Ksyvf/ot
 +HVcELzlCStz10rG9vAHpXq5MuUZQ7IL/wrK78hpw=
X-Received: by 2002:a05:600c:3507:b0:489:1b0c:8b43 with SMTP id
 5b1f17b1804b1-48e706ad0e5mr110987725e9.1.1778439273999; 
 Sun, 10 May 2026 11:54:33 -0700 (PDT)
Received: from skylab.fritz.box ([2a06:4944:10fb:f400:3dc3:7b05:ba52:3241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6d8efc35sm83061965e9.2.2026.05.10.11.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 11:54:33 -0700 (PDT)
From: Gilles Risch <gilles.risch@gmail.com>
To: alexander.deucher@amd.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Gilles Risch <gilles.risch@gmail.com>
Subject: [PATCH] The Apple iMac11,
 1 (late 2009) has an integrated ATI Mobility Radeon HD 4850. This
 machine suffers from a similar problem as the iMac10,
 1 (late 2009) and the iMac11,
 2 (mid 2010). This small patch fixes the issue on this machine.
Date: Sun, 10 May 2026 20:54:26 +0200
Message-ID: <20260510185426.4264-1-gilles.risch@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 11 May 2026 12:46:36 +0000
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

Fixes freedesktop issue 164
Link: https://gitlab.freedesktop.org/xorg/driver/xf86-video-ati/-/issues/164
---
 drivers/gpu/drm/radeon/atombios_crtc.c     | 4 ++--
 drivers/gpu/drm/radeon/atombios_encoders.c | 9 +++++----
 drivers/gpu/drm/radeon/radeon.h            | 1 +
 3 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/atombios_crtc.c b/drivers/gpu/drm/radeon/atombios_crtc.c
index 2fc0334e0..3c6d33273 100644
--- a/drivers/gpu/drm/radeon/atombios_crtc.c
+++ b/drivers/gpu/drm/radeon/atombios_crtc.c
@@ -580,7 +580,7 @@ static u32 atombios_adjust_pll(struct drm_crtc *crtc,
 			radeon_crtc->pll_flags |= (/*RADEON_PLL_USE_FRAC_FB_DIV |*/
 				RADEON_PLL_PREFER_CLOSEST_LOWER);
 
-		if (ASIC_IS_DCE32(rdev) && mode->clock > 200000)	/* range limits??? */
+		if (ASIC_IS_DCE31(rdev) && mode->clock > 200000)	/* range limits??? */
 			radeon_crtc->pll_flags |= RADEON_PLL_PREFER_HIGH_FB_DIV;
 		else
 			radeon_crtc->pll_flags |= RADEON_PLL_PREFER_LOW_REF_DIV;
@@ -594,7 +594,7 @@ static u32 atombios_adjust_pll(struct drm_crtc *crtc,
 		if (((rdev->family == CHIP_RS780) || (rdev->family == CHIP_RS880))
 		    && !radeon_crtc->ss_enabled)
 			radeon_crtc->pll_flags |= RADEON_PLL_USE_FRAC_FB_DIV;
-		if (ASIC_IS_DCE32(rdev) && mode->clock > 165000)
+		if (ASIC_IS_DCE31(rdev) && mode->clock > 165000)
 			radeon_crtc->pll_flags |= RADEON_PLL_USE_FRAC_FB_DIV;
 	} else {
 		radeon_crtc->pll_flags |= RADEON_PLL_LEGACY;
diff --git a/drivers/gpu/drm/radeon/atombios_encoders.c b/drivers/gpu/drm/radeon/atombios_encoders.c
index 5cfd8fcfa..4e984973c 100644
--- a/drivers/gpu/drm/radeon/atombios_encoders.c
+++ b/drivers/gpu/drm/radeon/atombios_encoders.c
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
-- 
2.47.3


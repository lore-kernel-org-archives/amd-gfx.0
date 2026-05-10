Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DFFDCD37BE
	for <amd-gfx@archiver.kernel.org>; Mon, 11 May 2026 12:46:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABD2A10E1A8;
	Mon, 11 May 2026 12:46:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="b35ZTuRN";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5564E10E19F
 for <amd-gfx@lists.freedesktop.org>; Sun, 10 May 2026 19:05:37 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-43d73352cf2so2889427f8f.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 10 May 2026 12:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778439936; x=1779044736; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=wULIO50aMY8iqYqnteMyOQw6QvzezVAoGO8iMs+bIKs=;
 b=b35ZTuRNg3pPNM95orzQztaIQ4ywFWh6OH0OSJK3wpvTJ6YeOfDbI8BS0Z1dSMIN8R
 MEe0sUGsJhRi23SouVssiPI1NRQuS2oHsSrBFKXesk0WHTOcmJBT9vv2xA3IkYxPKDhX
 6LgKSwzMKcoID1rsttLkNQbKZGjb8/oSWhkIMBY9AHWN8W27dVaOht4oqQoHtE3/Dy/t
 /K1rp4+puE9spRpKA8T8K5cKcJO1jbzeHti9tsnUgyDefi+q7OGrB+aNYZw356pxSTw0
 9tDiZgOGNptXulz8Y+6ZbhNRCoLcfJhFEWTGwcVxEz5rW/tqD0s1scLcMcwB/WbHAUQg
 dfXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778439936; x=1779044736;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wULIO50aMY8iqYqnteMyOQw6QvzezVAoGO8iMs+bIKs=;
 b=JflxaxLLNni6Y5GnjyCXKxn/FMsmxlgnkiGBJbB6Ql19sDahJ4TDYeoA/+8Kr1rO/H
 xDef0XVK16qf4s5D50mx1fZBwLV3CvYP3TOQDr40zBQ4/2n3bVIZbDdL8nDKzLUm13tN
 bQ6fVlfYWJrUYqsHhzYTruvd0w1YRuofhVWCtBtjF6RVXhwUfNEjCl2Nk6qdOuujLBWB
 hk6aU1PdZwmba819PaWUzohvAbUDvjNQ9N6lQfcQbKwHy+cAEfWPbvcUHlvIgq05PscU
 R7qZs+5GSwsVPXJPJnJlZN7LtazhwyAXTuJkkQeQpRJi7Udp/duAfksCPODS3X1ZhzPb
 iv+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ9gPk0oPZpLqo2uS49+r/kXgyu+rEXpZoMNUCLQMRMDZ4PQDd9K5UyNONFhQlZNNMA0rBBH9tH+@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwArfOetFzho8LK9C0b+9qW79TsN9blxgl1hNq4dWKGbmNAvJHS
 6VwUJCvHl2zVDxI8326FfdCWo5yjO36NmPsJNlk9tqLN1igRRiu3zOqv
X-Gm-Gg: Acq92OFy2TQO4IdYKdUsaIB09AMVzkc7B52qZwa4xWQGI0hSu8HsfSwwf20CzJe7UuZ
 NG2JUYPtlX04IKVDQcBmb7UX/tFfKWyreetA77YMFkcvOU4ZxFefb9wQJDzyMsSho7sJUDMHold
 cPJqaDAaLRGlVD3BwnaH7zwtjjQg6Lh0Mhfht44Z8CbYP1NGoD+/kn9SzqqdCvvf/vnrfvD25Qx
 MKTpAuD/VwqdFdkJhQhNrTMhvKQMwALcNq6DHmbdTtnP6MMLluWg8cpMQs7rlW8rX26jEuqVOe/
 GN7zCgsBz7K6c08M57s7gM3hPgCypv5BcJa2q5lJEEczZN+sfoPYMYABkqOrpQDqeP0hQG2aSkV
 jTuw9EznR4G3X8cLW98ZI8bTbkv2Vm4hFIym7xFcwGCrYUvHeDK2X2RSgA++ZgEXPdkZ/tWpJGb
 kOXHYb6GUuVKBVnyETJ9XadyMNq5P5Z2WdUoWe4jM=
X-Received: by 2002:a05:600c:a02:b0:489:1c1f:35f1 with SMTP id
 5b1f17b1804b1-48e706ad0damr110613005e9.4.1778439935639; 
 Sun, 10 May 2026 12:05:35 -0700 (PDT)
Received: from skylab.fritz.box ([2a06:4944:10fb:f400:3dc3:7b05:ba52:3241])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e701e9585sm133070855e9.5.2026.05.10.12.05.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 May 2026 12:05:35 -0700 (PDT)
From: Gilles Risch <gilles.risch@gmail.com>
To: alexander.deucher@amd.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Gilles Risch <gilles.risch@gmail.com>
Subject: [PATCH] The Apple iMac11,
 1 (late 2009) has an integrated ATI Mobility Radeon HD 4850. This
 machine suffers from a similar problem as the iMac10,
 1 (late 2009) and the iMac11,
 2 (mid 2010). This small patch fixes the issue on this machine.
Date: Sun, 10 May 2026 21:05:06 +0200
Message-ID: <20260510190505.4810-2-gilles.risch@gmail.com>
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

Signed-off-by: Gilles Risch <gilles.risch@gmail.com>
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


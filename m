Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B03CCCFA13
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Nov 2025 15:41:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7998210E24C;
	Sun,  9 Nov 2025 15:41:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ES3SGdQd";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD16310E24C
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Nov 2025 15:41:13 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4711810948aso14560425e9.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Nov 2025 07:41:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762702872; x=1763307672; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OtGiziEAQRSh374dZNFTBRkqOabU3JhbZOPlATyYhr0=;
 b=ES3SGdQdq6TIqn9fQNmDYXc+KbtK/Fy5BzaWYnOalGbhntt4hcUo/QPoCVst0cD3cs
 POi7qePk+fwbVnO+Fwc0qQjJMXxOYb+GWiKdB3a5royORwmGznWGGJZPTZA6GLYEDFD/
 ihxCMGfS/RuQ0sXBGRcPaQcLY1Vi+iS2ekuiewx9y8qkgWvJgOpS6VuTswPa1gQ7+Vo0
 mZx5Y3pW+qe7T5K4fvigJ3X9c6oCeuJDkkomxpX+B3SgklrfvIi2YbTnQj+vJVTV0CBh
 +03BzS0HxTE56xFG4HNblrcQ9rfVqNtVfdfjOMjNazGaHmjJTU3FSESnd+TKq8aEW+cR
 Lqug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762702872; x=1763307672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OtGiziEAQRSh374dZNFTBRkqOabU3JhbZOPlATyYhr0=;
 b=u0RyVWbMgC4yQftX35wpDzZMJv9Rd7CI6F4c3brafntzfiNnG3fV/4iTXMoiSXSIdr
 Wf6z/6hLVxlJ2DTxld3p/YYAoInquIoSv7x+AX3Ak6CnmyQMDHUkFM9Wr1rEebh7bbYU
 f68UrgWLP9mPu3qCEnIY6TTitc/r+waX1gLAkXHq+kTHNyhUlD4Yhg6TpuZm4IKRcFOg
 8zsxAXJxoKOIzoGzwgTxW9GH4wZDzeHvn5/SVqY8lL28pdAgTjEZrkqGK06Y+VHrpe+L
 jdiNR+U6GFTm2dNYnX2CuWxhOjUA3rrKJDOv3+P/NyV5j0DfcYfR0SdtgMm4cguSd8dJ
 0A3g==
X-Gm-Message-State: AOJu0YwSM6tP66J1Dy5qlFknWGRjjieyUX6/dBqPXgTtJH320Uwe7loP
 musjMVZlH27BVNDpMRx36PlHfkbvExJp3cLqPupHtLdvC7Rea/a1woFNbtMKAw==
X-Gm-Gg: ASbGnctoWrtWY1i0grCKehj0wqczu9liwH4yfSQgYht5IqGlFdtJWp6aJoTtRr8xqj9
 2rXP4qKEkcspzBAQ+foARAtA5YzIFJXtOucu7ZfikPgxgRoccrN175O0ZGrRBCK6DzzX5uW5giy
 G+vgy6c0a6rtmCauFG7jmQb8/L7kIb2Sgc5KalZ//vfEPvI4JXLanIBO4oM5CMHxHLnSSCFdpdZ
 nEi+u8HMuepoIy5F03pBTwTVBQTp0uA4YSYk72vmPGePPPXNVqDMhK2vMZJN2B7In291ac1h4CU
 N1HLhu5fHsnZRDed4tIZusu9oTlT1JD4lLJ2ZCy/oI35lBahQLAnqtyLCKntxaZJvRET7Q82zd5
 1oA74mtkgK4xkbRO9WdeSkak2K7gaJX7tl81BQjO2ZWJnQ/3wpRBtzefaxPoVZDw9BRMGE1diWp
 i3XpRCH8dylzwRXuLp3lFMXZMrbXpv
X-Google-Smtp-Source: AGHT+IFKWPWWtoFFy7JvVAsMnrW5WfTHzuNRE5+WFv4nfbxStx2UTDcfn327nKouG52qfFjQh9bvYQ==
X-Received: by 2002:a05:600c:3553:b0:46e:49fb:4776 with SMTP id
 5b1f17b1804b1-47773239b85mr43585205e9.11.1762702872176; 
 Sun, 09 Nov 2025 07:41:12 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24e1:af00:6cff:cfe4:4da7:ae2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4776a278a32sm78918505e9.12.2025.11.09.07.41.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 07:41:11 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 1/3] drm/radeon: Refactor how SI and CIK support is determined
Date: Sun,  9 Nov 2025 16:41:04 +0100
Message-ID: <20251109154106.43279-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251109154106.43279-1-timur.kristof@gmail.com>
References: <20251109154106.43279-1-timur.kristof@gmail.com>
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

Move the determination into a separate function.
Change radeon.si_support and radeon.cik_support so that their
default value is -1 (default).

This prepares the code for changing the default driver based
on the chip.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 78 ++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 350f88af888d..ac175442d806 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -241,12 +241,12 @@ module_param_named(uvd, radeon_uvd, int, 0444);
 MODULE_PARM_DESC(vce, "vce enable/disable vce support (1 = enable, 0 = disable)");
 module_param_named(vce, radeon_vce, int, 0444);
 
-int radeon_si_support = 1;
-MODULE_PARM_DESC(si_support, "SI support (1 = enabled (default), 0 = disabled)");
+int radeon_si_support = -1;
+MODULE_PARM_DESC(si_support, "SI support (1 = enabled, 0 = disabled, -1 = default)");
 module_param_named(si_support, radeon_si_support, int, 0444);
 
-int radeon_cik_support = 1;
-MODULE_PARM_DESC(cik_support, "CIK support (1 = enabled (default), 0 = disabled)");
+int radeon_cik_support = -1;
+MODULE_PARM_DESC(cik_support, "CIK support (1 = enabled, 0 = disabled, -1 = default)");
 module_param_named(cik_support, radeon_cik_support, int, 0444);
 
 static const struct pci_device_id pciidlist[] = {
@@ -256,6 +256,50 @@ MODULE_DEVICE_TABLE(pci, pciidlist);
 
 static const struct drm_driver kms_driver;
 
+static bool radeon_support_enabled(struct device *dev,
+				   const enum radeon_family family)
+{
+	const char *gen;
+	int module_param = -1;
+	bool amdgpu_support_built = IS_ENABLED(CONFIG_DRM_AMDGPU);
+	bool support_by_default = true;
+
+	switch (family) {
+	case CHIP_TAHITI:
+	case CHIP_PITCAIRN:
+	case CHIP_VERDE:
+	case CHIP_OLAND:
+	case CHIP_HAINAN:
+		gen = "SI";
+		module_param = radeon_si_support;
+		amdgpu_support_built &= IS_ENABLED(CONFIG_DRM_AMDGPU_SI);
+		break;
+
+	case CHIP_BONAIRE:
+	case CHIP_HAWAII:
+	case CHIP_KAVERI:
+	case CHIP_KABINI:
+	case CHIP_MULLINS:
+		gen = "CIK";
+		module_param = radeon_cik_support;
+		amdgpu_support_built &= IS_ENABLED(CONFIG_DRM_AMDGPU_CIK);
+		break;
+
+	default:
+		/* All other chips are supported by radeon only */
+		return true;
+	}
+
+	if ((module_param == -1 && (support_by_default || !amdgpu_support_built)) ||
+	    module_param == 1)
+		return true;
+
+	if (!module_param)
+		dev_info(dev, "%s support disabled by module param\n", gen);
+
+	return false;
+}
+
 static int radeon_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *ent)
 {
@@ -271,30 +315,8 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 
 	flags = ent->driver_data;
 
-	if (!radeon_si_support) {
-		switch (flags & RADEON_FAMILY_MASK) {
-		case CHIP_TAHITI:
-		case CHIP_PITCAIRN:
-		case CHIP_VERDE:
-		case CHIP_OLAND:
-		case CHIP_HAINAN:
-			dev_info(dev,
-				 "SI support disabled by module param\n");
-			return -ENODEV;
-		}
-	}
-	if (!radeon_cik_support) {
-		switch (flags & RADEON_FAMILY_MASK) {
-		case CHIP_KAVERI:
-		case CHIP_BONAIRE:
-		case CHIP_HAWAII:
-		case CHIP_KABINI:
-		case CHIP_MULLINS:
-			dev_info(dev,
-				 "CIK support disabled by module param\n");
-			return -ENODEV;
-		}
-	}
+	if (!radeon_support_enabled(dev, flags & RADEON_FAMILY_MASK))
+		return -ENODEV;
 
 	if (vga_switcheroo_client_probe_defer(pdev))
 		return -EPROBE_DEFER;
-- 
2.51.1


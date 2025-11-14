Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96740CE7AF9
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Nov 2025 12:07:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3380910EA4D;
	Fri, 14 Nov 2025 12:07:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A2XFTIAk";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB65E10EA4C
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 12:07:40 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-471191ac79dso20583445e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Nov 2025 04:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763122059; x=1763726859; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=OtGiziEAQRSh374dZNFTBRkqOabU3JhbZOPlATyYhr0=;
 b=A2XFTIAkLQsIJ3a89g/9uSSSMS7lqXOw6YJg6ZYB6EB3AKiDlSajuU7+uGKtyO7Owu
 TnbefD5tP2lBJ5e1Qcgyk3uqz3lSQYKyrDZcD092CglneX262PAEd7HQFpGoTQIUvohU
 gsvYnqZbtBtvJmi9VcP3gEUUu5hWzfPWJ7JTSk0ay89BRDd5+9H0EBicpvr8X6bW+lUJ
 QhxYzUVBuctJuoVEXz35GJxPWvfp+yuQlCsScBnonLQczyC+uM8PS+hioUeCeie/uf86
 5VzWappyg606id0gxZi9m/9mP0tQvuOi65/rIouqckA/hLUEDvspLLsqY4GZyFTOyn5R
 t1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763122059; x=1763726859;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=OtGiziEAQRSh374dZNFTBRkqOabU3JhbZOPlATyYhr0=;
 b=iYW+tVSFUYjooTV25fqFSCJmbfQdxne95/h0z2vRRuSSyumOoIeYLb+OWiC5PfahYi
 oKkHNgaMCIJM1SFiDj4zWsG4SzJ75vMjs0zNbJVXKs92AkOYN8igS9CLmbSqgvwo1Ezd
 HxjjXw+4Ydf1Dcw8OkjcGk1JPFWtSXezNQh4Lm4cEOYVTR05nBDoEX1wUn36YOfwCiY+
 LQ1PpVuKBpUGMRSywc1NlnIy0TJu7LyYQ9j1ll4PWAew+X/lczYG8eF34NsqTidEMt5T
 SWM03BySPSJmyeOuQ+YxcxSYHsheUfp7ej6LwgMUMSUPbAht/ckP10rM8aX2CJdTJbUO
 EPpg==
X-Gm-Message-State: AOJu0Yxu4W8zNu2F3u65yRDOWQir4LVfgfoNIcYS6Ha/j3b9ZxUKCP32
 l6rLGaxnCVqLwuCl1DkJER41Bjh/PwRZjTU2kiL5OSqtJ3uf+8ZXvnEdMfDakQwY
X-Gm-Gg: ASbGnctjnbecD4w6AWrw4jJBROU87Ny2ASGAfnA0I3rOLshSNgzgHzuOFXFHJ4WCBQr
 3PS6l65tElal1mYvWjMAa1BbeKcEn17Thli3vayzw90VwF7EsTEAL4GwQPRN1jsczfziCDaojok
 S1xDjURoTKZkjfo3ajw1MTXv2zose3iQWbpHeXn7vc2cJuWKj+wzlAKozlqNPs0Y7UeaAbR/4hr
 nK7CMoGaUMgecry0ymhq35bg6mR/UV6V2aMfuxZYDPQg72iNGfxgXxvgCJ+k6ZKt0VfEXuaGb/9
 ShkYp7dPEKtz/v64NHFyatV+AgQnCwdtThBV0OkPsBj9dGLtHb8p8cZl8WXppHICm8lln4YumB7
 GvdsyUCYFT98sX5Ti1nd75iY4P+879Xpy6oy2jp5CziGWtsXlyH91Q7eaj/zsPJVuvbBxRYjH2r
 RkF+BGRtF8sPSvoGnYBhHZChHfwSEE8LpvQXUD3zG0EYVR8gV72wcLHrw9OPtTgatVswdanPflw
 3Ir643PL3NtxLeFNw==
X-Google-Smtp-Source: AGHT+IHmGGe0GP4ULLQLf+CWESpZ7lI5n+l/OT7qsv92Rtx3ncqOIs/YwbdaXBB70f7ye9KHqrIG7g==
X-Received: by 2002:a05:600c:8b22:b0:477:7b16:5fb1 with SMTP id
 5b1f17b1804b1-4778fe553a5mr27761705e9.7.1763122059311; 
 Fri, 14 Nov 2025 04:07:39 -0800 (PST)
Received: from Timur-Hyperion.home
 (20014C4E24E1AF00CA8B1D2C0125E560.dsl.pool.telekom.hu.
 [2001:4c4e:24e1:af00:ca8b:1d2c:125:e560])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4778bd2fa91sm42078025e9.17.2025.11.14.04.07.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Nov 2025 04:07:38 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 1/4] drm/radeon: Refactor how SI and CIK support is determined
Date: Fri, 14 Nov 2025 13:07:33 +0100
Message-ID: <20251114120736.31310-2-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251114120736.31310-1-timur.kristof@gmail.com>
References: <20251114120736.31310-1-timur.kristof@gmail.com>
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


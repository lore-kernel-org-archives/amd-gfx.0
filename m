Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02735CCFA1A
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Nov 2025 15:41:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7527610E24D;
	Sun,  9 Nov 2025 15:41:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gBwtba4O";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9FC5910E24D
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Nov 2025 15:41:14 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4775e891b5eso10905235e9.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Nov 2025 07:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762702873; x=1763307673; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8pBFpJoIN4C/at/BAqumr9Tz45C2INUCio7axZfWN7Y=;
 b=gBwtba4ONFIyzvbQ3h2wQpBwSILtRYaWzX7t31CQoEZ8rT7DppFS0rDlT3ILK/f5PF
 NY1sfpvObMZdaA4KQ8NU2CqT2XnzMsBrD2spKCweaJPfybzsaYV2pQr/9Pj5MLwrcUGz
 YaSBJA3bs1tIH2YAdJC0j+MLoRbvD8VFolSEHZNZgzyrjgN0td0NheYEBSwUuNOkubCW
 7KwOkZbi+i+fSSkAcMpnLZVhLjVW56GQqkDHwrzI6fZytN4MXiCsYzXNcbJgRf57dxyO
 U7wKzLTyvV0WkimErLztimEFkN1Euy8bmMgulxdtw8mOZR9vHBU0vsBW1jef48xY6wIm
 tuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762702873; x=1763307673;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=8pBFpJoIN4C/at/BAqumr9Tz45C2INUCio7axZfWN7Y=;
 b=XP7cg82uwI/EJY5EG8AcKWff+tU8jTRuCjhPxoeEGmn7QGe2HnhSow88AaOPMHi582
 idpjW1vN8KBL04vaxAZ5KI3B2+cYXi8h7Tnqq08AxSLsZtSmsyv1q6W5qfBrXzgTCAp6
 GorPNYwP9YRNXScJD5I+oi1R3PV+MoWkAeFCuMD9yUF4WHcQevQOzBuHzPYDfrdhPq7E
 im1pdWrHzInwVJKHO0Y83oJKfwEKE9KZc8Dw5mTsAWUUd8Uo41rdUj7UJn3J3vz7FNeE
 Zj850sdl0krSY1iLbb01waTMC3gjzR+zaY3i6uqKkj5aBpSFpMkWqsIf2+ZNcjq41e2X
 HcDg==
X-Gm-Message-State: AOJu0YxNFbvtNuXT0WsYEW0zOIOLyjTIDnJBKAEkotRXNFKUggurE3WR
 R0HdHz4e151E7y6TcrbxCIjJOFVTmz0NECwMOJX94ELRTXADganOvoLBaAdsEA==
X-Gm-Gg: ASbGnctIql0CWsUr6wd1u7IqyeoGCDL85HfEpyfuq3NzsPoLTTmYrwKurrZZSPhWTlV
 mDJDAFBm97vBm+1U6lv5gHKAGEJVDaZk1UkSvI4xFF4omayBU/pO+8Mx8nrHQQu3JBy2HwM3Dx4
 qArSLTzwsIQ5QtZc9iMsr7jLjgxrrjIz7LxtNmuSutuUQ1zdzND3o/ibuQddArLkIZdl5VaQFOD
 WUFspwANe3tulJJYdRlhcg9aayQTIt7ilCA+TqA3VmjD6mc2vF829Lh8M/jZA9S5cLtxZTp5T3y
 WHhpNlprUgcMfU7u3Ogw4O1o4ab4kOXE5onUz3p5Ct40ieG8Aq33Ezps46jRvDjy5xdVwck9nbm
 OghksHJkZKm7Sp3wds2VPB6JOwnEWmwOk3uFXdvB3X+PQCrooM4g6V/DSNerrtBzJ2/3MEzrd7Q
 XSjvuISzEHE8ARv6yoCo+SsdpKs5lP
X-Google-Smtp-Source: AGHT+IEjpT4ckynX38EQFHRV4wxz1Qefz1JWRUOCNnjKwNcjSIdnjUnjCdsHpPLoC2JLPH0rdZTuMw==
X-Received: by 2002:a05:600c:46d5:b0:477:4345:7c5c with SMTP id
 5b1f17b1804b1-47773297851mr46945025e9.38.1762702873006; 
 Sun, 09 Nov 2025 07:41:13 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24e1:af00:6cff:cfe4:4da7:ae2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4776a278a32sm78918505e9.12.2025.11.09.07.41.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Nov 2025 07:41:12 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 2/3] drm/amdgpu: Refactor how SI and CIK support is determined
Date: Sun,  9 Nov 2025 16:41:05 +0100
Message-ID: <20251109154106.43279-3-timur.kristof@gmail.com>
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
Change amdgpu.si_support and amdgpu.cik_support so that their
default	value is -1 (default).

This prepares the code for changing the	default	driver based
on the chip.

Also adjust the module param documentation.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 155 ++++++++++++++----------
 1 file changed, 88 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 3f42cf7c6193..9f3846997f82 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -618,39 +618,37 @@ module_param_named(timeout_period, amdgpu_watchdog_timer.period, uint, 0644);
 
 /**
  * DOC: si_support (int)
- * Set SI support driver. This parameter works after set config CONFIG_DRM_AMDGPU_SI. For SI asic, when radeon driver is enabled,
- * set value 0 to use radeon driver, while set value 1 to use amdgpu driver. The default is using radeon driver when it available,
- * otherwise using amdgpu driver.
- */
+ * 1 = enabled, 0 = disabled, -1 = default
+ *
+ * SI (Southern Islands) are first generation GCN GPUs, supported by both
+ * drivers: radeon (old) and amdgpu (new). This parameter controls whether
+ * amdgpu should support SI.
+ * By default, SI chips are supported by radeon (except when radeon is not built).
+ * Only relevant when CONFIG_DRM_AMDGPU_SI is enabled to build SI support in amdgpu.
+ * See also radeon.si_support which should be disabled when amdgpu.si_support is
+ * enabled, and vice versa.
+ */
+int amdgpu_si_support = -1;
 #ifdef CONFIG_DRM_AMDGPU_SI
-
-#if IS_ENABLED(CONFIG_DRM_RADEON) || IS_ENABLED(CONFIG_DRM_RADEON_MODULE)
-int amdgpu_si_support;
-MODULE_PARM_DESC(si_support, "SI support (1 = enabled, 0 = disabled (default))");
-#else
-int amdgpu_si_support = 1;
-MODULE_PARM_DESC(si_support, "SI support (1 = enabled (default), 0 = disabled)");
-#endif
-
+MODULE_PARM_DESC(si_support, "SI support (1 = enabled, 0 = disabled, -1 = default)");
 module_param_named(si_support, amdgpu_si_support, int, 0444);
 #endif
 
 /**
  * DOC: cik_support (int)
- * Set CIK support driver. This parameter works after set config CONFIG_DRM_AMDGPU_CIK. For CIK asic, when radeon driver is enabled,
- * set value 0 to use radeon driver, while set value 1 to use amdgpu driver. The default is using radeon driver when it available,
- * otherwise using amdgpu driver.
- */
+ * 1 = enabled, 0 = disabled, -1 = default
+ *
+ * CIK (Sea Islands) are second generation GCN GPUs, supported by both
+ * drivers: radeon (old) and amdgpu (new). This parameter controls whether
+ * amdgpu should support CIK.
+ * By default, CIK chips are supported by radeon (except when radeon is not built).
+ * Only relevant when CONFIG_DRM_AMDGPU_CIK is enabled to build CIK support in amdgpu.
+ * See also radeon.cik_support which should be disabled when amdgpu.cik_support is
+ * enabled, and vice versa.
+ */
+int amdgpu_cik_support = -1;
 #ifdef CONFIG_DRM_AMDGPU_CIK
-
-#if IS_ENABLED(CONFIG_DRM_RADEON) || IS_ENABLED(CONFIG_DRM_RADEON_MODULE)
-int amdgpu_cik_support;
-MODULE_PARM_DESC(cik_support, "CIK support (1 = enabled, 0 = disabled (default))");
-#else
-int amdgpu_cik_support = 1;
-MODULE_PARM_DESC(cik_support, "CIK support (1 = enabled (default), 0 = disabled)");
-#endif
-
+MODULE_PARM_DESC(cik_support, "CIK support  (1 = enabled, 0 = disabled, -1 = default)");
 module_param_named(cik_support, amdgpu_cik_support, int, 0444);
 #endif
 
@@ -2307,6 +2305,69 @@ static unsigned long amdgpu_fix_asic_type(struct pci_dev *pdev, unsigned long fl
 	return flags;
 }
 
+static bool amdgpu_support_enabled(struct device *dev,
+				   const enum amd_asic_type family)
+{
+	const char *gen;
+	const char *param;
+	int module_param = -1;
+	bool radeon_support_built = IS_ENABLED(CONFIG_DRM_RADEON);
+	bool amdgpu_support_built = false;
+	bool support_by_default = false;
+
+	switch (family) {
+	case CHIP_TAHITI:
+	case CHIP_PITCAIRN:
+	case CHIP_VERDE:
+	case CHIP_OLAND:
+	case CHIP_HAINAN:
+		gen = "SI";
+		param = "si_support";
+		module_param = amdgpu_si_support;
+		amdgpu_support_built = IS_ENABLED(CONFIG_DRM_AMDGPU_SI);
+		break;
+
+	case CHIP_BONAIRE:
+	case CHIP_HAWAII:
+	case CHIP_KAVERI:
+	case CHIP_KABINI:
+	case CHIP_MULLINS:
+		gen = "CIK";
+		param = "cik_support";
+		module_param = amdgpu_cik_support;
+		amdgpu_support_built = IS_ENABLED(CONFIG_DRM_AMDGPU_CIK);
+		break;
+
+	default:
+		/* All other chips are supported by amdgpu only */
+		return true;
+	}
+
+	if (!amdgpu_support_built) {
+		dev_info(dev, "amdgpu built without %s support\n", gen);
+		return false;
+	}
+
+	if ((module_param == -1 && (support_by_default || !radeon_support_built)) ||
+	    module_param == 1) {
+		if (radeon_support_built)
+			dev_info(dev, "%s support provided by amdgpu.\n"
+				 "Use radeon.%s=1 amdgpu.%s=0 to override.\n",
+				 gen, param, param);
+
+		return true;
+	}
+
+	if (radeon_support_built)
+		dev_info(dev, "%s support provided by radeon.\n"
+			 "Use radeon.%s=0 amdgpu.%s=1 to override.\n",
+			 gen, param, param);
+	else if (module_param == 0)
+		dev_info(dev, "%s support disabled by module param\n", gen);
+
+	return false;
+}
+
 static int amdgpu_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *ent)
 {
@@ -2354,48 +2415,8 @@ static int amdgpu_pci_probe(struct pci_dev *pdev,
 		return -ENOTSUPP;
 	}
 
-	switch (flags & AMD_ASIC_MASK) {
-	case CHIP_TAHITI:
-	case CHIP_PITCAIRN:
-	case CHIP_VERDE:
-	case CHIP_OLAND:
-	case CHIP_HAINAN:
-#ifdef CONFIG_DRM_AMDGPU_SI
-		if (!amdgpu_si_support) {
-			dev_info(&pdev->dev,
-				 "SI support provided by radeon.\n");
-			dev_info(&pdev->dev,
-				 "Use radeon.si_support=0 amdgpu.si_support=1 to override.\n"
-				);
-			return -ENODEV;
-		}
-		break;
-#else
-		dev_info(&pdev->dev, "amdgpu is built without SI support.\n");
+	if (!amdgpu_support_enabled(&pdev->dev, flags & AMD_ASIC_MASK))
 		return -ENODEV;
-#endif
-	case CHIP_KAVERI:
-	case CHIP_BONAIRE:
-	case CHIP_HAWAII:
-	case CHIP_KABINI:
-	case CHIP_MULLINS:
-#ifdef CONFIG_DRM_AMDGPU_CIK
-		if (!amdgpu_cik_support) {
-			dev_info(&pdev->dev,
-				 "CIK support provided by radeon.\n");
-			dev_info(&pdev->dev,
-				 "Use radeon.cik_support=0 amdgpu.cik_support=1 to override.\n"
-				);
-			return -ENODEV;
-		}
-		break;
-#else
-		dev_info(&pdev->dev, "amdgpu is built without CIK support.\n");
-		return -ENODEV;
-#endif
-	default:
-		break;
-	}
 
 	adev = devm_drm_dev_alloc(&pdev->dev, &amdgpu_kms_driver, typeof(*adev), ddev);
 	if (IS_ERR(adev))
-- 
2.51.1


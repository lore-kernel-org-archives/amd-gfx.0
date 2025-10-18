Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9511FCCF9E6
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Oct 2025 08:51:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0274F10ECF5;
	Sat, 18 Oct 2025 08:50:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=0x0f.com header.i=@0x0f.com header.b="Gjr6tysT";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5BE710E364
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Oct 2025 05:45:05 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-793021f348fso2491697b3a.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 17 Oct 2025 22:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=0x0f.com; s=google; t=1760766305; x=1761371105; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MQOTysCBScI2CzYaQCtToYUiGDVsPF1DI/yzJf9rUmc=;
 b=Gjr6tysTObc/jzjh/3h1vMengPF9rs+JiTONUzaspIJny0og3Bn50rPiS+yUxQnH/d
 gl7WE0FDXi9Z1I1y6hqvfPnyl0FvQCh3f/xEsTFc1La3OcDyXODi1mV76OjsU3yCU0PV
 rQiK47Tjoq2IXab1L2cfMrUj5tzFLzvTR8xtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760766305; x=1761371105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MQOTysCBScI2CzYaQCtToYUiGDVsPF1DI/yzJf9rUmc=;
 b=MNyYqOiwav8AJiv8u+874nYZ4ed+82e00YmV6GjNFil5B+3/GM62/PCBhlPxDhEEC8
 I2J1VBukdjTV921qIdd8o8dVFzG7vHQm5xQNGjG5Cq5aq8kUK7e/glfR7/nadoq9nTPP
 X02IUicT5t9LK638kg0Md5K01yAm/EGlTNNQEjXKlBJ2vhyAk7oUAyTeVJzuyHfrv5BI
 kRfUmWuufGMCEfJc6TGKmcssQvhaAod6R1gM/Lzhrfq/wISDn68TUMS3UtbgNuuwFoYG
 4/9+TEAvvtfG8RKQi8BsUG+2Ok9dFnvB8i6ZjQR4s9hl4IL3FHvEa59nWpGu6ASPuSyt
 4Gpw==
X-Gm-Message-State: AOJu0YwMmxumRQT0RspYLVS16XSm7DqXVMXarWS/gZiTbnofCpkwoTrz
 xG/YZw617mMCzFt20yhJ06JDT4ZneIMpX8WlWOZGkAFllI+r3C6zKxxMZQ63yZlXiXY=
X-Gm-Gg: ASbGncvX8F0snsedoRBKhno1L2byDIVeFRiuISiQpb6SwPLMypTXIrkpfN71RdA/Kx4
 4d41Z2oAkXeu6uL90muL6Lpy6II+hRjASCY0nV6O5PoX88DIHU8v5l0c3gXiD5XNSgaZZEXhTha
 oUjPSLt5Rhv24aOxajw4tAmZH0BaLwR3EaFAWhyuRo4e7QaDv/rmNuHAtUcCUZZBq7iJpHWO7IX
 f0e64Vc7n//n3SGgXOOg9egWpJt2yGpTb4GwC27KrrlIC1CgZ6FSdS1FgpaFewS7usnJZ56OxNF
 rAID2O7bGvi+x18JXltBw087ggqITxOmblWPWIRsAvu9n222beQMY23Svb0ZuFixYY9PTXz86p1
 lDQ1v0esVmKqHwWO5RaYR65pv/Gfr5ExRHilsfy0l4O1+a4k7S1lPJyLGdbrbbyZx+9ojE1/bra
 zITyPsgdBKRpR3ncGSiu8jilIHum/Ggwi+YsgKFz37vNQMFvmx32U=
X-Google-Smtp-Source: AGHT+IGy3J41ApbLMLRcrOO9pkHemkNxPjtpkJmBEBFlBmY9XVIw/TLuT/llEZB3A4RXYe9syKnQyg==
X-Received: by 2002:a05:6a20:b38a:b0:334:aa54:bb2c with SMTP id
 adf61e73a8af0-334aa54bbd2mr5825208637.8.1760766305361; 
 Fri, 17 Oct 2025 22:45:05 -0700 (PDT)
Received: from shiro (p1391188-ipxg00a01sizuokaden.shizuoka.ocn.ne.jp.
 [153.222.3.188]) by smtp.googlemail.com with ESMTPSA id
 41be03b00d2f7-b6a76645c61sm1657222a12.3.2025.10.17.22.45.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 22:45:04 -0700 (PDT)
From: Daniel Palmer <daniel@0x0f.com>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, wuhoipok@gmail.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 3/3] drm/radeon: Remove calls to drm_put_dev()
Date: Sat, 18 Oct 2025 14:44:51 +0900
Message-ID: <20251018054451.259432-4-daniel@0x0f.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251018054451.259432-1-daniel@0x0f.com>
References: <20251018054451.259432-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 18 Oct 2025 08:50:55 +0000
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

Since the allocation of the drivers main structure was changed to
devm_drm_dev_alloc() drm_put_dev()'ing to trigger it to be free'd
should be done by devres.

However, drm_put_dev() is still in the probe error and device remove
paths. When the driver fails to probe warnings like the following are
shown because devres is trying to drm_put_dev() after the driver
already did it.

[    5.642230] radeon 0000:01:05.0: probe with driver radeon failed with error -22
[    5.649605] ------------[ cut here ]------------
[    5.649607] refcount_t: underflow; use-after-free.
[    5.649620] WARNING: CPU: 0 PID: 357 at lib/refcount.c:28 refcount_warn_saturate+0xbe/0x110

Fixes: a9ed2f052c5c ("drm/radeon: change drm_dev_alloc to devm_drm_dev_alloc")
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index eb5138da8d5b..350f88af888d 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -315,17 +315,17 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 
 	ret = pci_enable_device(pdev);
 	if (ret)
-		goto err_free;
+		return ret;
 
 	pci_set_drvdata(pdev, ddev);
 
 	ret = radeon_driver_load_kms(ddev, flags);
 	if (ret)
-		goto err_agp;
+		goto err;
 
 	ret = drm_dev_register(ddev, flags);
 	if (ret)
-		goto err_agp;
+		goto err;
 
 	if (rdev->mc.real_vram_size <= (8 * 1024 * 1024))
 		format = drm_format_info(DRM_FORMAT_C8);
@@ -338,30 +338,14 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 
 	return 0;
 
-err_agp:
+err:
 	pci_disable_device(pdev);
-err_free:
-	drm_dev_put(ddev);
 	return ret;
 }
 
-static void
-radeon_pci_remove(struct pci_dev *pdev)
-{
-	struct drm_device *dev = pci_get_drvdata(pdev);
-
-	drm_put_dev(dev);
-}
-
 static void
 radeon_pci_shutdown(struct pci_dev *pdev)
 {
-	/* if we are running in a VM, make sure the device
-	 * torn down properly on reboot/shutdown
-	 */
-	if (radeon_device_is_virtual())
-		radeon_pci_remove(pdev);
-
 #if defined(CONFIG_PPC64) || defined(CONFIG_MACH_LOONGSON64)
 	/*
 	 * Some adapters need to be suspended before a
@@ -614,7 +598,6 @@ static struct pci_driver radeon_kms_pci_driver = {
 	.name = DRIVER_NAME,
 	.id_table = pciidlist,
 	.probe = radeon_pci_probe,
-	.remove = radeon_pci_remove,
 	.shutdown = radeon_pci_shutdown,
 	.driver.pm = &radeon_pm_ops,
 };
-- 
2.51.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08920E75450
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Dec 2025 10:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB17810EA7B;
	Wed, 24 Dec 2025 10:22:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PY8KHftP";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2994710E08A
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Dec 2025 05:02:49 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-7acd9a03ba9so6026230b3a.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Dec 2025 21:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1766552569; x=1767157369; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=b1ZnG8yLFOgNUkGkXDv15H0ovQZznReZopUu9qPxrhc=;
 b=PY8KHftPUt9Hv6M9HV4VK+j62/xgmlY8q/Zi+1sKVVnTw3KlNdVDIo+QWiNOTrPAKF
 1paKPtnAfvH9hOQkxbr9sECc+oVQQFIykitBkd7h4i/MXN0ZthA1yUdxeNWPVew43Yhj
 +w5+enDDMtcB3nSerAQ+GdurCsKuE5Geett/tyCwiP2YoczCOTYjkaX74jjnG62QzQew
 kEj+zIuKlm2CK/z/hrsx36Wb1MJumq0n2cn/smO7yZd6jWYN1vd2btgGCbJAKn1IBvhq
 IPPz/Bx9bHI82Z5fS8Y/Gx1XGwkCbBqqJ43B0Q5LX4pBQKyGCSWGEanJL6uAmJyic2cD
 /7tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766552569; x=1767157369;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b1ZnG8yLFOgNUkGkXDv15H0ovQZznReZopUu9qPxrhc=;
 b=ENhbnCBBv3rjQo4RWYL9r7qalyvmvmCIC/TGdlvEMHo/YWX0sVQ4eKm9Th/ReOzBei
 x0D+CvRr6rYkdM9C0X+lMX2DZFrJvwupq3xCNLT6LXlwpZozvHPskH4LLltpxmeolHeH
 gc+7TSSFeTRFSmpd64e6GVcuOfUXOTEXp45Aws23MiyhqJpc4pxBBymEPtGoQHVKkHUJ
 BaTA2cct0lm2wLQulaPdLfg/viBckKHN/qUbyzb2zyTSUF+nzSoIVmArNEDrd3NJGTgn
 +2Xa6LSTxBZ61Ibhj+ohauwVaHZvlGTgTdgKlw20J+MGzaXw1BYSJ+vjOxeo6IMWGuCO
 HzKQ==
X-Gm-Message-State: AOJu0YwXEfYK++pUNtErWarT3ZWKzBIHDraz3ox1ZkXRxZ39brOCxwKL
 f+Qn3QmORlidV0pgCX4hsvtrsp6akth4xhJoiWiDIUyd9M01f4CwRNH6
X-Gm-Gg: AY/fxX7RIc0dyDy2bRBdQ1ANLgMEka0wu0SCq6y4mkCASYDx/NSH4+a+PUDfRC9qRON
 NMqqnla8vZhFVe5pHWGtj9DcPlRaGiXitGeH49AFVXlYVI0qQ2vZI8SWm96PIFDv7zsh4B8DmVn
 MBuhAXxmor24PDzjUj6JQRH3RnwRT2l2Mogzdz/qxj7WsxyIj2M2BxywacsAhiccqBsCFtiN9Pw
 VDrOCyvkXHw9EmE6wyN8zdm4MBmehPO1nTex7QxZX3oHBqtATs4A7Hruk0v7nXU8OWs3lJHQUCC
 7rObQD8ZnyYPyTf1DjbUZUjyKJ3xnHY0bajAuTJ2D1QbzL/BvNlN5TxxVNWfo8jLfqk/LzCWDFd
 DrG3ag/AKSAAOrNTsx3WVnVPcUJ+xZsUanqhXVYgVcqOkjRFJ7kRUmGq2nfB6HleLcQ3z6oCwdK
 2iFUNLE8RqAy9wdQVW4AN2K2K2OaAwboFF+awwe9s=
X-Google-Smtp-Source: AGHT+IG8qBs6UzP+fV1sTduEsAkrUxh2D/JucxeWhiAHN1H0Z1Eq7FBt5DNo6v5E8BQMbS4U5T814w==
X-Received: by 2002:a05:6a00:278a:b0:79a:fd01:dfa9 with SMTP id
 d2e1a72fcca58-7ff64215308mr16709010b3a.6.1766552568538; 
 Tue, 23 Dec 2025 21:02:48 -0800 (PST)
Received: from rahul-mintos.ban-spse ([165.204.156.251])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7ff7e682870sm15349386b3a.57.2025.12.23.21.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 21:02:47 -0800 (PST)
From: Abhishek Rajput <abhiraj21put@gmail.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, abhiraj21put@gmail.com
Subject: [PATCH] drm/radeon: Convert legacy DRM logging to drm_* helpers in
 radeon_device.c
Date: Wed, 24 Dec 2025 10:32:30 +0530
Message-ID: <20251224050230.509813-1-abhiraj21put@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 24 Dec 2025 10:22:15 +0000
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

Replace DRM_INFO() and DRM_ERROR() calls in
drivers/gpu/drm/radeon/radeon_device.c with the corresponding
drm_info() and drm_err() helpers.

The drm_*() logging helpers take a struct drm_device * argument,
allowing the DRM core to prefix log messages with the correct device
name and instance. This is required to correctly distinguish log
messages on systems with multiple GPUs.

This change aligns the radeon driver with the DRM TODO item:
"Convert logging to drm_* functions with drm_device parameter".

Signed-off-by: Abhishek Rajput <abhiraj21put@gmail.com>

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 60afaa8e56b4..e80c3ff6c16c 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -337,6 +337,8 @@ void radeon_scratch_free(struct radeon_device *rdev, uint32_t reg)
  */
 static int radeon_doorbell_init(struct radeon_device *rdev)
 {
+	struct drm_device *ddev = rdev_to_drm(rdev);
+
 	/* doorbell bar mapping */
 	rdev->doorbell.base = pci_resource_start(rdev->pdev, 2);
 	rdev->doorbell.size = pci_resource_len(rdev->pdev, 2);
@@ -349,8 +351,8 @@ static int radeon_doorbell_init(struct radeon_device *rdev)
 	if (rdev->doorbell.ptr == NULL) {
 		return -ENOMEM;
 	}
-	DRM_INFO("doorbell mmio base: 0x%08X\n", (uint32_t)rdev->doorbell.base);
-	DRM_INFO("doorbell mmio size: %u\n", (unsigned)rdev->doorbell.size);
+	drm_info(ddev, "doorbell mmio base: 0x%08X\n", (uint32_t)rdev->doorbell.base);
+	drm_info(ddev, "doorbell mmio size: %pa\n", &rdev->doorbell.size);
 
 	memset(&rdev->doorbell.used, 0, sizeof(rdev->doorbell.used));
 
@@ -752,11 +754,13 @@ void radeon_update_bandwidth_info(struct radeon_device *rdev)
  */
 bool radeon_boot_test_post_card(struct radeon_device *rdev)
 {
+	struct drm_device *ddev = rdev_to_drm(rdev);
+
 	if (radeon_card_posted(rdev))
 		return true;
 
 	if (rdev->bios) {
-		DRM_INFO("GPU not posted. posting now...\n");
+		drm_info(ddev, "GPU not posted. posting now...\n");
 		if (rdev->is_atom_bios)
 			atom_asic_init(rdev->mode_info.atom_context);
 		else
@@ -975,6 +979,7 @@ int radeon_atombios_init(struct radeon_device *rdev)
 {
 	struct card_info *atom_card_info =
 	    kzalloc(sizeof(struct card_info), GFP_KERNEL);
+	struct drm_device *ddev = rdev_to_drm(rdev);
 
 	if (!atom_card_info)
 		return -ENOMEM;
@@ -988,7 +993,7 @@ int radeon_atombios_init(struct radeon_device *rdev)
 		atom_card_info->ioreg_read = cail_ioreg_read;
 		atom_card_info->ioreg_write = cail_ioreg_write;
 	} else {
-		DRM_ERROR("Unable to find PCI I/O BAR; using MMIO for ATOM IIO\n");
+		drm_err(ddev, "Unable to find PCI I/O BAR; using MMIO for ATOM IIO\n");
 		atom_card_info->ioreg_read = cail_reg_read;
 		atom_card_info->ioreg_write = cail_reg_write;
 	}
@@ -1297,7 +1302,7 @@ int radeon_device_init(struct radeon_device *rdev,
 	}
 	rdev->fence_context = dma_fence_context_alloc(RADEON_NUM_RINGS);
 
-	DRM_INFO("initializing kernel modesetting (%s 0x%04X:0x%04X 0x%04X:0x%04X 0x%02X).\n",
+	drm_info(ddev, "initializing kernel modesetting (%s 0x%04X:0x%04X 0x%04X:0x%04X 0x%02X).\n",
 		 radeon_family_name[rdev->family], pdev->vendor, pdev->device,
 		 pdev->subsystem_vendor, pdev->subsystem_device, pdev->revision);
 
@@ -1414,7 +1419,7 @@ int radeon_device_init(struct radeon_device *rdev,
 		}
 	}
 	if (rdev->rio_mem == NULL)
-		DRM_ERROR("Unable to find PCI I/O BAR\n");
+		drm_err(ddev, "Unable to find PCI I/O BAR\n");
 
 	if (rdev->flags & RADEON_IS_PX)
 		radeon_device_handle_px_quirks(rdev);
@@ -1454,7 +1459,7 @@ int radeon_device_init(struct radeon_device *rdev,
 
 	r = radeon_ib_ring_tests(rdev);
 	if (r)
-		DRM_ERROR("ib ring test failed (%d).\n", r);
+		drm_err(ddev, "ib ring test failed (%d).\n", r);
 
 	/*
 	 * Turks/Thames GPU will freeze whole laptop if DPM is not restarted
@@ -1475,19 +1480,19 @@ int radeon_device_init(struct radeon_device *rdev,
 		if (rdev->accel_working)
 			radeon_test_moves(rdev);
 		else
-			DRM_INFO("radeon: acceleration disabled, skipping move tests\n");
+			drm_info(ddev, "radeon: acceleration disabled, skipping move tests\n");
 	}
 	if ((radeon_testing & 2)) {
 		if (rdev->accel_working)
 			radeon_test_syncing(rdev);
 		else
-			DRM_INFO("radeon: acceleration disabled, skipping sync tests\n");
+			drm_info(ddev, "radeon: acceleration disabled, skipping sync tests\n");
 	}
 	if (radeon_benchmarking) {
 		if (rdev->accel_working)
 			radeon_benchmark(rdev, radeon_benchmarking);
 		else
-			DRM_INFO("radeon: acceleration disabled, skipping benchmarks\n");
+			drm_info(ddev, "radeon: acceleration disabled, skipping benchmarks\n");
 	}
 	return 0;
 
@@ -1510,7 +1515,9 @@ int radeon_device_init(struct radeon_device *rdev,
  */
 void radeon_device_fini(struct radeon_device *rdev)
 {
-	DRM_INFO("radeon: finishing device.\n");
+	struct drm_device *ddev = rdev_to_drm(rdev);
+
+	drm_info(ddev, "radeon: finishing device.\n");
 	rdev->shutdown = true;
 	/* evict vram memory */
 	radeon_bo_evict_vram(rdev);
@@ -1670,14 +1677,14 @@ int radeon_resume_kms(struct drm_device *dev, bool resume, bool notify_clients)
 
 	r = radeon_ib_ring_tests(rdev);
 	if (r)
-		DRM_ERROR("ib ring test failed (%d).\n", r);
+		drm_err(dev, "ib ring test failed (%d).\n", r);
 
 	if ((rdev->pm.pm_method == PM_METHOD_DPM) && rdev->pm.dpm_enabled) {
 		/* do dpm late init */
 		r = radeon_pm_late_init(rdev);
 		if (r) {
 			rdev->pm.dpm_enabled = false;
-			DRM_ERROR("radeon_pm_late_init failed, disabling dpm\n");
+			drm_err(dev, "radeon_pm_late_init failed, disabling dpm\n");
 		}
 	} else {
 		/* resume old pm late */
@@ -1701,7 +1708,7 @@ int radeon_resume_kms(struct drm_device *dev, bool resume, bool notify_clients)
 							     0 : 1 << 27,
 							     &radeon_crtc->cursor_addr);
 				if (r != 0)
-					DRM_ERROR("Failed to pin cursor BO (%d)\n", r);
+					drm_err(dev, "Failed to pin cursor BO (%d)\n", r);
 				radeon_bo_unreserve(robj);
 			}
 		}
@@ -1756,6 +1763,7 @@ int radeon_gpu_reset(struct radeon_device *rdev)
 {
 	unsigned ring_sizes[RADEON_NUM_RINGS];
 	uint32_t *ring_data[RADEON_NUM_RINGS];
+	struct drm_device *ddev = rdev_to_drm(rdev);
 
 	bool saved = false;
 
@@ -1807,7 +1815,7 @@ int radeon_gpu_reset(struct radeon_device *rdev)
 		r = radeon_pm_late_init(rdev);
 		if (r) {
 			rdev->pm.dpm_enabled = false;
-			DRM_ERROR("radeon_pm_late_init failed, disabling dpm\n");
+			drm_err(ddev, "radeon_pm_late_init failed, disabling dpm\n");
 		}
 	} else {
 		/* resume old pm late */
-- 
2.43.0


Return-Path: <SRS0=6/kp=FO=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086E7C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 21:45:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1E3223DE3
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Dec 2020 21:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1E3223DE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 293596EB6C;
	Thu, 10 Dec 2020 21:45:38 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 53BF76EB6C
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 21:45:37 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id s6so3229958qvn.6
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Dec 2020 13:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Crxi0Qf0d1dPJqiMwU4qjJ7LV78d3GtjtONcraGXSZo=;
 b=Fq35wsgCMrnym8Ltnu9OsmmI3wT5Q2sqjnaBDys6v9KcA0c82NEMctb2Z/NAdDkccT
 ohE8wHPNzH9I7xB8Rwws/WN9P9w8pvUqgZJtsAUIc4IEe6rALlruS46jL/npmJTfQCfv
 qgQdsNOFMfP+VXBIHHLHpzl8qOVfyCvny/CS8+qs9KpQkkis3JLcMrcj1zCCEiSfs9H+
 2O3gsRWlDfu2pyFzUCvluINWvRoCdWk5WAmxSha4v2tCYVKUQPfZ+gAJ7kcPi/2uWOO4
 GAKHL5N+6JRpcys0OaMUPdH5cuivHKWrIjhki5GO8UdfbYk/wba6yvQ7iu+w6DdzBsr9
 2Tyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Crxi0Qf0d1dPJqiMwU4qjJ7LV78d3GtjtONcraGXSZo=;
 b=o+2MQNiGg1/OR2kFQhgL1y9qd+j2YE5iIsALVaTHBciu2D8UawNoc8vCdogqwOjapu
 RsqQaM89grqoTe6OBhFoSN+DAphMyWLNyPwu4JS8+eK8hXFPRmxTX2Rw9OPBTIbGJezB
 rJD19R6ry6YX5iKSdyHljvljVgxfZtejAhVDFPh1U05aXDX9GAiPmFQ17o/b8C6Phrfi
 8CKLJu8HifUMPw9ZRcPwthaSoSsPtf8m3QzFynkZC0j3IeFh3RE3DZIAoLnfPVb5c6M7
 O2s8VDkL3T6p6I2rvxwqkUJrVR+sp78uj/y6qt1Hc9I2VyPYpEnk4ozoW3F6/WUkhm6K
 iLoQ==
X-Gm-Message-State: AOAM5319cpBvtSKsmhgvvviz7qlQe4t8XtjSkn8W8Y37h7feu2aHvzBV
 iWq4YtsNUJDbwDB9gG8fZL7NdbH1cm4=
X-Google-Smtp-Source: ABdhPJwrsAZ6HpOAI99GCLZaZn1yMSbz0zHHUaBtEufZaI9utkuBU+xr4ABvIYL9aNvNQHXf0wZDvw==
X-Received: by 2002:a05:6214:762:: with SMTP id
 f2mr11363169qvz.54.1607636736242; 
 Thu, 10 Dec 2020 13:45:36 -0800 (PST)
Received: from localhost.localdomain ([192.161.78.5])
 by smtp.gmail.com with ESMTPSA id y9sm4776989qtm.96.2020.12.10.13.45.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Dec 2020 13:45:35 -0800 (PST)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/7] drm/amdgpu: split BOCO and ATPX handling
Date: Thu, 10 Dec 2020 16:45:12 -0500
Message-Id: <20201210214518.704305-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In preparation for systems that support d3cold on dGPUs
independent of PX/HG.  No functional change intended.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 33 ++++++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 18 +++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |  4 +--
 4 files changed, 42 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 6e2953233231..38c029af60c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1230,6 +1230,7 @@ void amdgpu_device_program_register_sequence(struct amdgpu_device *adev,
 					     const u32 *registers,
 					     const u32 array_size);
 
+bool amdgpu_device_supports_atpx(struct drm_device *dev);
 bool amdgpu_device_supports_boco(struct drm_device *dev);
 bool amdgpu_device_supports_baco(struct drm_device *dev);
 bool amdgpu_device_is_peer_accessible(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 355fa0057c26..e243490462d8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -211,6 +211,23 @@ static ssize_t amdgpu_device_get_serial_number(struct device *dev,
 static DEVICE_ATTR(serial_number, S_IRUGO,
 		amdgpu_device_get_serial_number, NULL);
 
+/**
+ * amdgpu_device_supports_atpx - Is the device a dGPU with HG/PX power control
+ *
+ * @dev: drm_device pointer
+ *
+ * Returns true if the device is a dGPU with HG/PX power control,
+ * otherwise return false.
+ */
+bool amdgpu_device_supports_atpx(struct drm_device *dev)
+{
+	struct amdgpu_device *adev = drm_to_adev(dev);
+
+	if (adev->flags & AMD_IS_PX)
+		return true;
+	return false;
+}
+
 /**
  * amdgpu_device_supports_boco - Is the device a dGPU with HG/PX power control
  *
@@ -1398,7 +1415,7 @@ static void amdgpu_switcheroo_set_state(struct pci_dev *pdev,
 	struct drm_device *dev = pci_get_drvdata(pdev);
 	int r;
 
-	if (amdgpu_device_supports_boco(dev) && state == VGA_SWITCHEROO_OFF)
+	if (amdgpu_device_supports_atpx(dev) && state == VGA_SWITCHEROO_OFF)
 		return;
 
 	if (state == VGA_SWITCHEROO_ON) {
@@ -3177,7 +3194,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	struct drm_device *ddev = adev_to_drm(adev);
 	struct pci_dev *pdev = adev->pdev;
 	int r, i;
-	bool boco = false;
+	bool atpx = false;
 	u32 max_MBps;
 
 	adev->shutdown = false;
@@ -3349,15 +3366,15 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_register(adev->pdev, adev, NULL, amdgpu_device_vga_set_decode);
 
-	if (amdgpu_device_supports_boco(ddev))
-		boco = true;
+	if (amdgpu_device_supports_atpx(ddev))
+		atpx = true;
 	if (amdgpu_has_atpx() &&
 	    (amdgpu_is_atpx_hybrid() ||
 	     amdgpu_has_atpx_dgpu_power_cntl()) &&
 	    !pci_is_thunderbolt_attached(adev->pdev))
 		vga_switcheroo_register_client(adev->pdev,
-					       &amdgpu_switcheroo_ops, boco);
-	if (boco)
+					       &amdgpu_switcheroo_ops, atpx);
+	if (atpx)
 		vga_switcheroo_init_domain_pm_ops(adev->dev, &adev->vga_pm_domain);
 
 	if (amdgpu_emu_mode == 1) {
@@ -3540,7 +3557,7 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 
 failed:
 	amdgpu_vf_error_trans_all(adev);
-	if (boco)
+	if (atpx)
 		vga_switcheroo_fini_domain_pm_ops(adev->dev);
 
 failed_unmap:
@@ -3604,7 +3621,7 @@ void amdgpu_device_fini(struct amdgpu_device *adev)
 	     amdgpu_has_atpx_dgpu_power_cntl()) &&
 	    !pci_is_thunderbolt_attached(adev->pdev))
 		vga_switcheroo_unregister_client(adev->pdev);
-	if (amdgpu_device_supports_boco(adev_to_drm(adev)))
+	if (amdgpu_device_supports_atpx(adev_to_drm(adev)))
 		vga_switcheroo_fini_domain_pm_ops(adev->dev);
 	if ((adev->pdev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
 		vga_client_register(adev->pdev, NULL, NULL, NULL);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ebdab31f9de9..90b8ce762aee 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1340,7 +1340,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	}
 
 	adev->in_runpm = true;
-	if (amdgpu_device_supports_boco(drm_dev))
+	if (amdgpu_device_supports_atpx(drm_dev))
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 	drm_kms_helper_poll_disable(drm_dev);
 
@@ -1348,7 +1348,7 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (amdgpu_device_supports_boco(drm_dev)) {
+	if (amdgpu_device_supports_atpx(drm_dev)) {
 		/* Only need to handle PCI state in the driver for ATPX
 		 * PCI core handles it for _PR3.
 		 */
@@ -1361,6 +1361,11 @@ static int amdgpu_pmops_runtime_suspend(struct device *dev)
 			pci_set_power_state(pdev, PCI_D3cold);
 		}
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_DYNAMIC_OFF;
+	} else if (amdgpu_device_supports_boco(drm_dev)) {
+		/* Only need to handle PCI state in the driver for ATPX
+		 * PCI core handles it for _PR3.
+		 */
+		pci_ignore_hotplug(pdev);
 	} else if (amdgpu_device_supports_baco(drm_dev)) {
 		amdgpu_device_baco_enter(drm_dev);
 	}
@@ -1378,7 +1383,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 	if (!adev->runpm)
 		return -EINVAL;
 
-	if (amdgpu_device_supports_boco(drm_dev)) {
+	if (amdgpu_device_supports_atpx(drm_dev)) {
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_CHANGING;
 
 		/* Only need to handle PCI state in the driver for ATPX
@@ -1394,12 +1399,17 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 				return ret;
 			pci_set_master(pdev);
 		}
+	} else if (amdgpu_device_supports_boco(drm_dev)) {
+		/* Only need to handle PCI state in the driver for ATPX
+		 * PCI core handles it for _PR3.
+		 */
+		pci_set_master(pdev);
 	} else if (amdgpu_device_supports_baco(drm_dev)) {
 		amdgpu_device_baco_exit(drm_dev);
 	}
 	ret = amdgpu_device_resume(drm_dev, false);
 	drm_kms_helper_poll_enable(drm_dev);
-	if (amdgpu_device_supports_boco(drm_dev))
+	if (amdgpu_device_supports_atpx(drm_dev))
 		drm_dev->switch_power_state = DRM_SWITCH_POWER_ON;
 	adev->in_runpm = false;
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index fc12fc72366f..38fb903338a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -156,7 +156,7 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 		goto out;
 	}
 
-	if (amdgpu_device_supports_boco(dev) &&
+	if (amdgpu_device_supports_atpx(dev) &&
 	    (amdgpu_runtime_pm != 0)) { /* enable runpm by default for boco */
 		adev->runpm = true;
 	} else if (amdgpu_device_supports_baco(dev) &&
@@ -192,7 +192,7 @@ int amdgpu_driver_load_kms(struct amdgpu_device *adev, unsigned long flags)
 
 	if (adev->runpm) {
 		/* only need to skip on ATPX */
-		if (amdgpu_device_supports_boco(dev) &&
+		if (amdgpu_device_supports_atpx(dev) &&
 		    !amdgpu_is_atpx_hybrid())
 			dev_pm_set_driver_flags(dev->dev, DPM_FLAG_NO_DIRECT_COMPLETE);
 		pm_runtime_use_autosuspend(dev->dev);
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

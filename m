Return-Path: <SRS0=n+xW=KC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 267EEC433B4
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 18:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2290613C0
	for <amd-gfx@archiver.kernel.org>; Fri,  7 May 2021 18:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2290613C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA9796EE68;
	Fri,  7 May 2021 18:57:18 +0000 (UTC)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D1376EDD7;
 Fri,  7 May 2021 18:57:14 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id DB899B1D7;
 Fri,  7 May 2021 18:57:12 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@linux.ie, daniel@ffwll.ch, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, alexander.deucher@amd.com, christian.koenig@amd.com
Subject: [PATCH 1/4] drm/radeon: Move AGP helpers into radeon driver
Date: Fri,  7 May 2021 20:57:06 +0200
Message-Id: <20210507185709.22797-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210507185709.22797-1-tzimmermann@suse.de>
References: <20210507185709.22797-1-tzimmermann@suse.de>
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
Cc: Thomas Zimmermann <tzimmermann@suse.de>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Radeon calls DRMs core AGP helpers. These helpers are only required
by legacy drivers. Reimplement the code in radeon to uncouple radeon
from the legacy code.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/radeon/radeon.h     |   8 +++
 drivers/gpu/drm/radeon/radeon_agp.c | 102 ++++++++++++++++++++++++++--
 drivers/gpu/drm/radeon/radeon_drv.c |   2 +-
 3 files changed, 104 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 42281fce552e..4f9e8dc460be 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -1110,6 +1110,14 @@ typedef int (*radeon_packet0_check_t)(struct radeon_cs_parser *p,
 /*
  * AGP
  */
+#if IS_ENABLED(CONFIG_AGP)
+struct drm_agp_head *radeon_agp_head_init(struct drm_device *dev);
+#else
+static inline struct drm_agp_head *radeon_agp_head_init(struct drm_device *dev)
+{
+	return NULL;
+}
+#endif
 int radeon_agp_init(struct radeon_device *rdev);
 void radeon_agp_resume(struct radeon_device *rdev);
 void radeon_agp_suspend(struct radeon_device *rdev);
diff --git a/drivers/gpu/drm/radeon/radeon_agp.c b/drivers/gpu/drm/radeon/radeon_agp.c
index 0aca7bdf54c7..398be13c8e2b 100644
--- a/drivers/gpu/drm/radeon/radeon_agp.c
+++ b/drivers/gpu/drm/radeon/radeon_agp.c
@@ -127,6 +127,94 @@ static struct radeon_agpmode_quirk radeon_agpmode_quirk_list[] = {
 		PCI_VENDOR_ID_SONY, 0x8175, 1},
 	{ 0, 0, 0, 0, 0, 0, 0 },
 };
+
+struct drm_agp_head *radeon_agp_head_init(struct drm_device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	struct drm_agp_head *head = NULL;
+
+	head = kzalloc(sizeof(*head), GFP_KERNEL);
+	if (!head)
+		return NULL;
+	head->bridge = agp_find_bridge(pdev);
+	if (!head->bridge) {
+		head->bridge = agp_backend_acquire(pdev);
+		if (!head->bridge) {
+			kfree(head);
+			return NULL;
+		}
+		agp_copy_info(head->bridge, &head->agp_info);
+		agp_backend_release(head->bridge);
+	} else {
+		agp_copy_info(head->bridge, &head->agp_info);
+	}
+	if (head->agp_info.chipset == NOT_SUPPORTED) {
+		kfree(head);
+		return NULL;
+	}
+	INIT_LIST_HEAD(&head->memory);
+	head->cant_use_aperture = head->agp_info.cant_use_aperture;
+	head->page_mask = head->agp_info.page_mask;
+	head->base = head->agp_info.aper_base;
+
+	return head;
+}
+
+static int radeon_agp_head_acquire(struct drm_device *dev)
+{
+	struct pci_dev *pdev = to_pci_dev(dev->dev);
+
+	if (!dev->agp)
+		return -ENODEV;
+	if (dev->agp->acquired)
+		return -EBUSY;
+	dev->agp->bridge = agp_backend_acquire(pdev);
+	if (!dev->agp->bridge)
+		return -ENODEV;
+	dev->agp->acquired = 1;
+	return 0;
+}
+
+static int radeon_agp_head_release(struct drm_device *dev)
+{
+	if (!dev->agp || !dev->agp->acquired)
+		return -EINVAL;
+	agp_backend_release(dev->agp->bridge);
+	dev->agp->acquired = 0;
+	return 0;
+}
+
+static int radeon_agp_head_enable(struct drm_device *dev, struct drm_agp_mode mode)
+{
+	if (!dev->agp || !dev->agp->acquired)
+		return -EINVAL;
+
+	dev->agp->mode = mode.mode;
+	agp_enable(dev->agp->bridge, mode.mode);
+	dev->agp->enabled = 1;
+	return 0;
+}
+
+static int radeon_agp_head_info(struct drm_device *dev, struct drm_agp_info *info)
+{
+	struct agp_kern_info *kern;
+
+	if (!dev->agp || !dev->agp->acquired)
+		return -EINVAL;
+
+	kern = &dev->agp->agp_info;
+	info->agp_version_major = kern->version.major;
+	info->agp_version_minor = kern->version.minor;
+	info->mode = kern->mode;
+	info->aperture_base = kern->aper_base;
+	info->aperture_size = kern->aper_size * 1024 * 1024;
+	info->memory_allowed = kern->max_memory << PAGE_SHIFT;
+	info->memory_used = kern->current_memory << PAGE_SHIFT;
+	info->id_vendor = kern->device->vendor;
+	info->id_device = kern->device->device;
+
+	return 0;
+}
 #endif
 
 int radeon_agp_init(struct radeon_device *rdev)
@@ -141,21 +229,21 @@ int radeon_agp_init(struct radeon_device *rdev)
 	int ret;
 
 	/* Acquire AGP. */
-	ret = drm_agp_acquire(rdev->ddev);
+	ret = radeon_agp_head_acquire(rdev->ddev);
 	if (ret) {
 		DRM_ERROR("Unable to acquire AGP: %d\n", ret);
 		return ret;
 	}
 
-	ret = drm_agp_info(rdev->ddev, &info);
+	ret = radeon_agp_head_info(rdev->ddev, &info);
 	if (ret) {
-		drm_agp_release(rdev->ddev);
+		radeon_agp_head_release(rdev->ddev);
 		DRM_ERROR("Unable to get AGP info: %d\n", ret);
 		return ret;
 	}
 
 	if (rdev->ddev->agp->agp_info.aper_size < 32) {
-		drm_agp_release(rdev->ddev);
+		radeon_agp_head_release(rdev->ddev);
 		dev_warn(rdev->dev, "AGP aperture too small (%zuM) "
 			"need at least 32M, disabling AGP\n",
 			rdev->ddev->agp->agp_info.aper_size);
@@ -239,10 +327,10 @@ int radeon_agp_init(struct radeon_device *rdev)
 	}
 
 	mode.mode &= ~RADEON_AGP_FW_MODE; /* disable fw */
-	ret = drm_agp_enable(rdev->ddev, mode);
+	ret = radeon_agp_head_enable(rdev->ddev, mode);
 	if (ret) {
 		DRM_ERROR("Unable to enable AGP (mode = 0x%lx)\n", mode.mode);
-		drm_agp_release(rdev->ddev);
+		radeon_agp_head_release(rdev->ddev);
 		return ret;
 	}
 
@@ -279,7 +367,7 @@ void radeon_agp_fini(struct radeon_device *rdev)
 {
 #if IS_ENABLED(CONFIG_AGP)
 	if (rdev->ddev->agp && rdev->ddev->agp->acquired) {
-		drm_agp_release(rdev->ddev);
+		radeon_agp_head_release(rdev->ddev);
 	}
 #endif
 }
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 8885e849717d..7a9cd590d0de 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -346,7 +346,7 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 	pci_set_drvdata(pdev, dev);
 
 	if (pci_find_capability(pdev, PCI_CAP_ID_AGP))
-		dev->agp = drm_agp_init(dev);
+		dev->agp = radeon_agp_head_init(dev);
 	if (dev->agp) {
 		dev->agp->agp_mtrr = arch_phys_wc_add(
 			dev->agp->agp_info.aper_base,
-- 
2.31.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

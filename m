Return-Path: <SRS0=dvhx=GP=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC2DC433DB
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 08:10:52 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5B7E22D2C
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Jan 2021 08:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5B7E22D2C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22D106E10E;
	Tue, 12 Jan 2021 08:10:44 +0000 (UTC)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DC386E0EA;
 Tue, 12 Jan 2021 08:10:43 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id AF825B7D5;
 Tue, 12 Jan 2021 08:10:41 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, alexander.deucher@amd.com, christian.koenig@amd.com
Subject: [PATCH 5/6] drm/radeon: Store PCI controller in struct
 radeon_device.hose
Date: Tue, 12 Jan 2021 09:10:34 +0100
Message-Id: <20210112081035.6882-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210112081035.6882-1-tzimmermann@suse.de>
References: <20210112081035.6882-1-tzimmermann@suse.de>
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

Moves struct drm_device.hose into struct radeon_device. The field in
struct DRM device is only for legacy drivers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/radeon/radeon.h     | 3 +++
 drivers/gpu/drm/radeon/radeon_drv.c | 4 ----
 drivers/gpu/drm/radeon/radeon_kms.c | 4 ++++
 drivers/gpu/drm/radeon/radeon_ttm.c | 2 +-
 4 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 6bcb851d7e22..f09989bdce98 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -2313,6 +2313,9 @@ struct radeon_device {
 	struct device			*dev;
 	struct drm_device		*ddev;
 	struct pci_dev			*pdev;
+#ifdef __alpha__
+	struct pci_controller		*hose;
+#endif
 	struct rw_semaphore		exclusive_lock;
 	/* ASIC */
 	union radeon_asic_config	config;
diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 8193a2e9c415..efeb115ae70e 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -342,10 +342,6 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_free;
 
-#ifdef __alpha__
-	dev->hose = pdev->sysdata;
-#endif
-
 	pci_set_drvdata(pdev, dev);
 
 	if (pci_find_capability(pdev, PCI_CAP_ID_AGP))
diff --git a/drivers/gpu/drm/radeon/radeon_kms.c b/drivers/gpu/drm/radeon/radeon_kms.c
index 7c360d31ab6a..2479d6ab7a36 100644
--- a/drivers/gpu/drm/radeon/radeon_kms.c
+++ b/drivers/gpu/drm/radeon/radeon_kms.c
@@ -115,6 +115,10 @@ int radeon_driver_load_kms(struct drm_device *dev, unsigned long flags)
 	}
 	dev->dev_private = (void *)rdev;
 
+#ifdef __alpha__
+	rdev->hose = pdev->sysdata;
+#endif
+
 	/* update BUS flag */
 	if (pci_find_capability(pdev, PCI_CAP_ID_AGP)) {
 		flags |= RADEON_IS_AGP;
diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 35b715f82ed8..e8c66d10478f 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -324,7 +324,7 @@ static int radeon_ttm_io_mem_reserve(struct ttm_bo_device *bdev, struct ttm_reso
 		 * access, as done in ttm_bo_vm_fault().
 		 */
 		mem->bus.offset = (mem->bus.offset & 0x0ffffffffUL) +
-			rdev->ddev->hose->dense_mem_base;
+			rdev->hose->dense_mem_base;
 #endif
 		break;
 	default:
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

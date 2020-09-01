Return-Path: <SRS0=dANk=CK=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FC32C433E2
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 07:38:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 369DA2071B
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2020 07:38:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 369DA2071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D88196E804;
	Tue,  1 Sep 2020 07:38:32 +0000 (UTC)
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40ED06E5A1;
 Tue,  1 Sep 2020 06:32:36 +0000 (UTC)
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37]
 helo=localhost) by youngberry.canonical.com with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <kai.heng.feng@canonical.com>)
 id 1kCzqL-00050m-15; Tue, 01 Sep 2020 06:32:33 +0000
From: Kai-Heng Feng <kai.heng.feng@canonical.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Subject: [PATCH] drm/radeon: Reset ASIC if suspend is not managed by platform
 firmware
Date: Tue,  1 Sep 2020 14:32:27 +0800
Message-Id: <20200901063227.6057-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Tue, 01 Sep 2020 07:38:32 +0000
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
Cc: David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>,
 "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
 Kai-Heng Feng <kai.heng.feng@canonical.com>,
 "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>,
 Daniel Vetter <daniel@ffwll.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Suspend with s2idle or by the following steps cause screen frozen:
 # echo devices > /sys/power/pm_test
 # echo freeze > /sys/power/mem

[  289.625461] [drm:uvd_v1_0_ib_test [radeon]] *ERROR* radeon: fence wait timed out.
[  289.625494] [drm:radeon_ib_ring_tests [radeon]] *ERROR* radeon: failed testing IB on ring 5 (-110).

The issue doesn't happen on traditional S3, probably because firmware or
hardware provides extra power management.

Inspired by Daniel Drake's patch [1] on amdgpu, using a similar approach
can fix the issue.

[1] https://patchwork.freedesktop.org/patch/335839/

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/gpu/drm/radeon/radeon_device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 266e3cbbd09b..df823b9ad79f 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -33,6 +33,7 @@
 #include <linux/slab.h>
 #include <linux/vga_switcheroo.h>
 #include <linux/vgaarb.h>
+#include <linux/suspend.h>
 
 #include <drm/drm_cache.h>
 #include <drm/drm_crtc_helper.h>
@@ -1643,6 +1644,8 @@ int radeon_suspend_kms(struct drm_device *dev, bool suspend,
 		rdev->asic->asic_reset(rdev, true);
 		pci_restore_state(dev->pdev);
 	} else if (suspend) {
+		if (pm_suspend_no_platform())
+			rdev->asic->asic_reset(rdev, true);
 		/* Shut down the device */
 		pci_disable_device(dev->pdev);
 		pci_set_power_state(dev->pdev, PCI_D3hot);
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

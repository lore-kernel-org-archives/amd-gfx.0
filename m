Return-Path: <SRS0=wW4+=ES=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 814E3C2D0A3
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 13:21:47 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 239EE2068D
	for <amd-gfx@archiver.kernel.org>; Thu, 12 Nov 2020 13:21:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 239EE2068D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 37E0E6E288;
	Thu, 12 Nov 2020 13:21:33 +0000 (UTC)
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21E6B6E22C;
 Thu, 12 Nov 2020 13:21:31 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2C8B5AB95;
 Thu, 12 Nov 2020 13:21:29 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org
Subject: [PATCH 6/7] drm/radeon: Use fbdev shadow fb
Date: Thu, 12 Nov 2020 14:21:16 +0100
Message-Id: <20201112132117.27228-7-tzimmermann@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201112132117.27228-1-tzimmermann@suse.de>
References: <20201112132117.27228-1-tzimmermann@suse.de>
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

Fbdev framebuffer addresses are exported and mmap'ed to userspace, so the
framebuffer may not change its location. This creates memory pressure on
devices with little video RAM. Radeon mitigates this problem by reducing
the framebuffer's color depth on devices with 32 MiB or less.

Fully resolve the problem by enabling generic fbdev's shadow FB. All
userspace-visible memory is located in the shadow buffer. The underlying
BO can be evicted to system memory as needed, thus freeing video RAM for
more important uses.

Switching to a shadow framebuffer also allows to remove a special case in
BO handling, where the fbdev's BO was not evicted. Fbdev should now be
treated an any other framebuffer BO

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/radeon/radeon_device.c | 11 ++++-------
 drivers/gpu/drm/radeon/radeon_fb.c     | 17 ++---------------
 drivers/gpu/drm/radeon/radeon_mode.h   |  1 -
 3 files changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index 266e3cbbd09b..87c14f6369ee 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -1605,13 +1605,10 @@ int radeon_suspend_kms(struct drm_device *dev, bool suspend,
 			continue;
 		}
 		robj = gem_to_radeon_bo(fb->obj[0]);
-		/* don't unpin kernel fb objects */
-		if (!radeon_fbdev_robj_is_fb(rdev, robj)) {
-			r = radeon_bo_reserve(robj, false);
-			if (r == 0) {
-				radeon_bo_unpin(robj);
-				radeon_bo_unreserve(robj);
-			}
+		r = radeon_bo_reserve(robj, false);
+		if (r == 0) {
+			radeon_bo_unpin(robj);
+			radeon_bo_unreserve(robj);
 		}
 	}
 	/* evict vram memory */
diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeon/radeon_fb.c
index 50fdc2aaa463..c687d14a1b93 100644
--- a/drivers/gpu/drm/radeon/radeon_fb.c
+++ b/drivers/gpu/drm/radeon/radeon_fb.c
@@ -59,14 +59,12 @@ void radeon_fbdev_init(struct radeon_device *rdev)
 	struct drm_device *ddev = rdev->ddev;
 	int bpp_sel = 32;
 
-	/* select 8 bpp console on 8MB cards, or 16 bpp on RN50 or 32MB */
-	if (rdev->mc.real_vram_size <= (8*1024*1024))
-		bpp_sel = 8;
-	else if (ASIC_IS_RN50(rdev) || rdev->mc.real_vram_size <= (32*1024*1024))
+	if (ASIC_IS_RN50(rdev))
 		bpp_sel = 16;
 
 	/* radeon resume is fragile and needs a vt switch to help it along */
 	ddev->mode_config.require_vt_switch_fbdev = true;
+	ddev->mode_config.prefer_shadow_fbdev = true;
 
 	drm_fbdev_generic_setup(ddev, bpp_sel);
 }
@@ -75,14 +73,3 @@ void radeon_fbdev_set_suspend(struct radeon_device *rdev, int state)
 {
 	drm_fb_helper_set_suspend(rdev->ddev->fb_helper, state);
 }
-
-bool radeon_fbdev_robj_is_fb(struct radeon_device *rdev, struct radeon_bo *robj)
-{
-	if (!rdev->ddev->fb_helper)
-		return false;
-
-	if (gem_to_radeon_bo(rdev->ddev->fb_helper->buffer->gem) != robj)
-		return false;
-
-	return true;
-}
diff --git a/drivers/gpu/drm/radeon/radeon_mode.h b/drivers/gpu/drm/radeon/radeon_mode.h
index fe192ef0aafa..197423ad42c1 100644
--- a/drivers/gpu/drm/radeon/radeon_mode.h
+++ b/drivers/gpu/drm/radeon/radeon_mode.h
@@ -977,7 +977,6 @@ void dce8_program_fmt(struct drm_encoder *encoder);
 /* fbdev layer */
 void radeon_fbdev_init(struct radeon_device *rdev);
 void radeon_fbdev_set_suspend(struct radeon_device *rdev, int state);
-bool radeon_fbdev_robj_is_fb(struct radeon_device *rdev, struct radeon_bo *robj);
 
 void radeon_crtc_handle_vblank(struct radeon_device *rdev, int crtc_id);
 
-- 
2.29.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

From: Allen Pais <allen.pais@oracle.com>
Subject: [PATCH] drm/radeon: fix a potential NULL pointer dereference
Date: Wed, 18 Sep 2019 22:01:22 +0530
Message-ID: <1568824282-4081-1-git-send-email-allen.pais@oracle.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: airlied@linux.ie, linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, daniel@ffwll.ch
List-Id: amd-gfx.lists.freedesktop.org

alloc_workqueue is not checked for errors and as a result,
a potential NULL dereference could occur.

Signed-off-by: Allen Pais <allen.pais@oracle.com>
---
 drivers/gpu/drm/radeon/radeon_display.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index bd52f15..1a41764 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -683,6 +683,10 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 	drm_mode_crtc_set_gamma_size(&radeon_crtc->base, 256);
 	radeon_crtc->crtc_id = index;
 	radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc", WQ_HIGHPRI, 0);
+	if (unlikely(!radeon_crtc->flip_queue)) {
+		kfree(radeon_crtc);
+		return;
+	}
 	rdev->mode_info.crtcs[index] = radeon_crtc;
 
 	if (rdev->family >= CHIP_BONAIRE) {
-- 
1.9.1

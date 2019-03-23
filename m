From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] gpu: radeon: fix a potential NULL-pointer dereference
Date: Fri, 22 Mar 2019 21:29:55 -0500
Message-ID: <20190323022955.14326-1-kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

In case alloc_workqueue fails, the fix frees memory and
returns to avoid potential NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/gpu/drm/radeon/radeon_display.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index aa898c699101..a31305755a77 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -678,6 +678,11 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 	drm_mode_crtc_set_gamma_size(&radeon_crtc->base, 256);
 	radeon_crtc->crtc_id = index;
 	radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc", WQ_HIGHPRI, 0);
+	if (!radeon_crtc->flip_queue) {
+		DRM_ERROR("failed to allocate the flip queue\n");
+		kfree(radeon_crtc);
+		return;
+	}
 	rdev->mode_info.crtcs[index] = radeon_crtc;
 
 	if (rdev->family >= CHIP_BONAIRE) {
-- 
2.17.1

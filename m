From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH v2] gpu: radeon: fix a potential NULL-pointer dereference
Date: Mon, 25 Mar 2019 16:05:52 -0500
Message-ID: <20190325210552.12797-1-kjlu@umn.edu>
References: <0fc81efe-186b-3207-e0d0-b0bb95626069@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0fc81efe-186b-3207-e0d0-b0bb95626069@daenzer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

In case alloc_workqueue fails, the fix frees memory and
returns -ENOMEM to avoid potential NULL pointer dereference.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
v2: use radeon_crtc_destroy to properly clean up resources as
suggested by Michel Dänzer <michel@daenzer.net>
---
 drivers/gpu/drm/radeon/radeon_display.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index aa898c699101..3c6d3289316b 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -663,7 +663,7 @@ static const struct drm_crtc_funcs radeon_crtc_funcs = {
 	.page_flip_target = radeon_crtc_page_flip_target,
 };
 
-static void radeon_crtc_init(struct drm_device *dev, int index)
+static int radeon_crtc_init(struct drm_device *dev, int index)
 {
 	struct radeon_device *rdev = dev->dev_private;
 	struct radeon_crtc *radeon_crtc;
@@ -671,13 +671,18 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 
 	radeon_crtc = kzalloc(sizeof(struct radeon_crtc) + (RADEONFB_CONN_LIMIT * sizeof(struct drm_connector *)), GFP_KERNEL);
 	if (radeon_crtc == NULL)
-		return;
+		return -ENOMEM;
 
 	drm_crtc_init(dev, &radeon_crtc->base, &radeon_crtc_funcs);
 
 	drm_mode_crtc_set_gamma_size(&radeon_crtc->base, 256);
 	radeon_crtc->crtc_id = index;
 	radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc", WQ_HIGHPRI, 0);
+	if (!radeon_crtc->flip_queue) {
+		DRM_ERROR("failed to allocate the flip queue\n");
+		radeon_crtc_destroy(&radeon_crtc->base);
+		return -ENOMEM;
+	}
 	rdev->mode_info.crtcs[index] = radeon_crtc;
 
 	if (rdev->family >= CHIP_BONAIRE) {
@@ -706,6 +711,8 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 		radeon_atombios_init_crtc(dev, radeon_crtc);
 	else
 		radeon_legacy_init_crtc(dev, radeon_crtc);
+
+	return 0;
 }
 
 static const char *encoder_names[38] = {
@@ -1612,7 +1619,9 @@ int radeon_modeset_init(struct radeon_device *rdev)
 
 	/* allocate crtcs */
 	for (i = 0; i < rdev->num_crtc; i++) {
-		radeon_crtc_init(rdev->ddev, i);
+		ret = radeon_crtc_init(rdev->ddev, i);
+		if (ret)
+			return ret;
 	}
 
 	/* okay we should have all the bios connectors */
-- 
2.17.1

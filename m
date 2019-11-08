From: Will Deacon <will@kernel.org>
Subject: [PATCH v2] drm/radeon: Handle workqueue allocation failure
Date: Fri,  8 Nov 2019 15:34:46 +0000
Message-ID: <20191108153446.21244-1-will@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>, Nicolas Waisman <nico@semmle.com>
List-Id: amd-gfx.lists.freedesktop.org

In the highly unlikely event that we fail to allocate the "radeon-crtc"
workqueue, we should bail cleanly rather than blindly marching on with a
NULL pointer installed for the 'flip_queue' field of the 'radeon_crtc'
structure.

This was reported previously by Nicolas, but I don't think his fix was
correct.

Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: "Christian König" <christian.koenig@amd.com>
Cc: "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Michel Dänzer <michel@daenzer.net>
Reported-by: Nicolas Waisman <nico@semmle.com>
Link: https://lore.kernel.org/lkml/CADJ_3a8WFrs5NouXNqS5WYe7rebFP+_A5CheeqAyD_p7DFJJcg@mail.gmail.com/
Signed-off-by: Will Deacon <will@kernel.org>
---

v2: Add failure path to radeon_modeset_init(). Compile-tested only.

 drivers/gpu/drm/radeon/radeon_display.c | 29 +++++++++++++++++++------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index e81b01f8db90..177acee06620 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -668,21 +668,29 @@ static const struct drm_crtc_funcs radeon_crtc_funcs = {
 	.page_flip_target = radeon_crtc_page_flip_target,
 };
 
-static void radeon_crtc_init(struct drm_device *dev, int index)
+static int radeon_crtc_init(struct drm_device *dev, int index)
 {
 	struct radeon_device *rdev = dev->dev_private;
 	struct radeon_crtc *radeon_crtc;
+	struct workqueue_struct *wq;
 	int i;
 
 	radeon_crtc = kzalloc(sizeof(struct radeon_crtc) + (RADEONFB_CONN_LIMIT * sizeof(struct drm_connector *)), GFP_KERNEL);
 	if (radeon_crtc == NULL)
-		return;
+		return -ENOMEM;
+
+	wq = alloc_workqueue("radeon-crtc", WQ_HIGHPRI, 0);
+	if (unlikely(!wq)) {
+		kfree(radeon_crtc);
+		return - ENOMEM;
+	}
 
 	drm_crtc_init(dev, &radeon_crtc->base, &radeon_crtc_funcs);
 
 	drm_mode_crtc_set_gamma_size(&radeon_crtc->base, 256);
 	radeon_crtc->crtc_id = index;
-	radeon_crtc->flip_queue = alloc_workqueue("radeon-crtc", WQ_HIGHPRI, 0);
+	radeon_crtc->flip_queue = wq;
+
 	rdev->mode_info.crtcs[index] = radeon_crtc;
 
 	if (rdev->family >= CHIP_BONAIRE) {
@@ -711,6 +719,8 @@ static void radeon_crtc_init(struct drm_device *dev, int index)
 		radeon_atombios_init_crtc(dev, radeon_crtc);
 	else
 		radeon_legacy_init_crtc(dev, radeon_crtc);
+
+	return 0;
 }
 
 static const char *encoder_names[38] = {
@@ -1602,9 +1612,8 @@ int radeon_modeset_init(struct radeon_device *rdev)
 	rdev->ddev->mode_config.fb_base = rdev->mc.aper_base;
 
 	ret = radeon_modeset_create_props(rdev);
-	if (ret) {
-		return ret;
-	}
+	if (ret)
+		goto err_drm_mode_config_cleanup;
 
 	/* init i2c buses */
 	radeon_i2c_init(rdev);
@@ -1617,7 +1626,9 @@ int radeon_modeset_init(struct radeon_device *rdev)
 
 	/* allocate crtcs */
 	for (i = 0; i < rdev->num_crtc; i++) {
-		radeon_crtc_init(rdev->ddev, i);
+		ret = radeon_crtc_init(rdev->ddev, i);
+		if (ret)
+			goto err_drm_mode_config_cleanup;
 	}
 
 	/* okay we should have all the bios connectors */
@@ -1645,6 +1656,10 @@ int radeon_modeset_init(struct radeon_device *rdev)
 	ret = radeon_pm_late_init(rdev);
 
 	return 0;
+
+err_drm_mode_config_cleanup:
+	drm_mode_config_cleanup(rdev->ddev);
+	return ret;
 }
 
 void radeon_modeset_fini(struct radeon_device *rdev)
-- 
2.24.0.rc1.363.gb1bccd3e3d-goog

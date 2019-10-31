From: Will Deacon <will@kernel.org>
Subject: Re: [PATCH] drm/radeon: Handle workqueue allocation failure
Date: Thu, 31 Oct 2019 16:54:51 +0000
Message-ID: <20191031165450.GA28461@willie-the-truck>
References: <20191025110450.10474-1-will@kernel.org>
 <5d6a88a2-2719-a859-04df-10b0d893ff39@daenzer.net>
 <20191025161804.GA12335@willie-the-truck>
 <e2f87ecc-0a8e-253d-107c-5cf6486c4b6a@daenzer.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e2f87ecc-0a8e-253d-107c-5cf6486c4b6a@daenzer.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Michel =?iso-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Cc: amd-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, Nicolas Waisman <nico@semmle.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

On Fri, Oct 25, 2019 at 06:20:01PM +0200, Michel Dänzer wrote:
> On 2019-10-25 6:18 p.m., Will Deacon wrote:
> > On Fri, Oct 25, 2019 at 06:06:26PM +0200, Michel Dänzer wrote:
> >> On 2019-10-25 1:04 p.m., Will Deacon wrote:
> >>> In the highly unlikely event that we fail to allocate the "radeon-crtc"
> >>> workqueue, we should bail cleanly rather than blindly march on with a
> >>> NULL pointer installed for the 'flip_queue' field of the 'radeon_crtc'
> >>> structure.
> >>>
> >>> This was reported previously by Nicolas, but I don't think his fix was
> >>> correct:
> >>
> >> Neither is this one I'm afraid. See my feedback on
> >> https://patchwork.freedesktop.org/patch/331534/ .
> > 
> > Thanks. Although I agree with you wrt the original patch, I don't think
> > the workqueue allocation failure is distinguishable from the CRTC allocation
> > failure with my patch. Are you saying that the error path there is broken
> > too?
> 
> The driver won't actually work if radeon_crtc_init bails silently, it'll
> just fall over at some later point.

Ok, so how about fleshing it out as per below?

Will

--->8

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

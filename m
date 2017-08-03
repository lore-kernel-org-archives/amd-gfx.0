From: Cihangir Akturk <cakturk@gmail.com>
Subject: [PATCH 20/29] drm/radeon: switch to drm_*{get,put} helpers
Date: Thu,  3 Aug 2017 14:58:35 +0300
Message-ID: <1501761585-11757-21-git-send-email-cakturk@gmail.com>
References: <1501761585-11757-1-git-send-email-cakturk@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501761585-11757-1-git-send-email-cakturk@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Cihangir Akturk <cakturk@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

drm_*_reference() and drm_*_unreference() functions are just
compatibility alias for drm_*_get() and drm_*_put() adn should not be
used by new code. So convert all users of compatibility functions to use
the new APIs.

Signed-off-by: Cihangir Akturk <cakturk@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_cs.c      |  2 +-
 drivers/gpu/drm/radeon/radeon_cursor.c  |  6 +++---
 drivers/gpu/drm/radeon/radeon_display.c | 12 ++++++------
 drivers/gpu/drm/radeon/radeon_fb.c      |  4 ++--
 drivers/gpu/drm/radeon/radeon_gem.c     | 30 +++++++++++++++---------------
 drivers/gpu/drm/radeon/radeon_object.c  |  2 +-
 6 files changed, 28 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_cs.c b/drivers/gpu/drm/radeon/radeon_cs.c
index 00b22af..ea0db26 100644
--- a/drivers/gpu/drm/radeon/radeon_cs.c
+++ b/drivers/gpu/drm/radeon/radeon_cs.c
@@ -437,7 +437,7 @@ static void radeon_cs_parser_fini(struct radeon_cs_parser *parser, int error, bo
 			if (bo == NULL)
 				continue;
 
-			drm_gem_object_unreference_unlocked(&bo->gem_base);
+			drm_gem_object_put_unlocked(&bo->gem_base);
 		}
 	}
 	kfree(parser->track);
diff --git a/drivers/gpu/drm/radeon/radeon_cursor.c b/drivers/gpu/drm/radeon/radeon_cursor.c
index 4a4f953..9195227 100644
--- a/drivers/gpu/drm/radeon/radeon_cursor.c
+++ b/drivers/gpu/drm/radeon/radeon_cursor.c
@@ -307,7 +307,7 @@ int radeon_crtc_cursor_set2(struct drm_crtc *crtc,
 	robj = gem_to_radeon_bo(obj);
 	ret = radeon_bo_reserve(robj, false);
 	if (ret != 0) {
-		drm_gem_object_unreference_unlocked(obj);
+		drm_gem_object_put_unlocked(obj);
 		return ret;
 	}
 	/* Only 27 bit offset for legacy cursor */
@@ -317,7 +317,7 @@ int radeon_crtc_cursor_set2(struct drm_crtc *crtc,
 	radeon_bo_unreserve(robj);
 	if (ret) {
 		DRM_ERROR("Failed to pin new cursor BO (%d)\n", ret);
-		drm_gem_object_unreference_unlocked(obj);
+		drm_gem_object_put_unlocked(obj);
 		return ret;
 	}
 
@@ -352,7 +352,7 @@ int radeon_crtc_cursor_set2(struct drm_crtc *crtc,
 			radeon_bo_unpin(robj);
 			radeon_bo_unreserve(robj);
 		}
-		drm_gem_object_unreference_unlocked(radeon_crtc->cursor_bo);
+		drm_gem_object_put_unlocked(radeon_crtc->cursor_bo);
 	}
 
 	radeon_crtc->cursor_bo = obj;
diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/radeon/radeon_display.c
index 17d3daf..adbf28c 100644
--- a/drivers/gpu/drm/radeon/radeon_display.c
+++ b/drivers/gpu/drm/radeon/radeon_display.c
@@ -282,7 +282,7 @@ static void radeon_unpin_work_func(struct work_struct *__work)
 	} else
 		DRM_ERROR("failed to reserve buffer after flip\n");
 
-	drm_gem_object_unreference_unlocked(&work->old_rbo->gem_base);
+	drm_gem_object_put_unlocked(&work->old_rbo->gem_base);
 	kfree(work);
 }
 
@@ -519,7 +519,7 @@ static int radeon_crtc_page_flip_target(struct drm_crtc *crtc,
 	obj = old_radeon_fb->obj;
 
 	/* take a reference to the old object */
-	drm_gem_object_reference(obj);
+	drm_gem_object_get(obj);
 	work->old_rbo = gem_to_radeon_bo(obj);
 
 	new_radeon_fb = to_radeon_framebuffer(fb);
@@ -618,7 +618,7 @@ static int radeon_crtc_page_flip_target(struct drm_crtc *crtc,
 	radeon_bo_unreserve(new_rbo);
 
 cleanup:
-	drm_gem_object_unreference_unlocked(&work->old_rbo->gem_base);
+	drm_gem_object_put_unlocked(&work->old_rbo->gem_base);
 	dma_fence_put(work->fence);
 	kfree(work);
 	return r;
@@ -1303,7 +1303,7 @@ static void radeon_user_framebuffer_destroy(struct drm_framebuffer *fb)
 {
 	struct radeon_framebuffer *radeon_fb = to_radeon_framebuffer(fb);
 
-	drm_gem_object_unreference_unlocked(radeon_fb->obj);
+	drm_gem_object_put_unlocked(radeon_fb->obj);
 	drm_framebuffer_cleanup(fb);
 	kfree(radeon_fb);
 }
@@ -1363,14 +1363,14 @@ radeon_user_framebuffer_create(struct drm_device *dev,
 
 	radeon_fb = kzalloc(sizeof(*radeon_fb), GFP_KERNEL);
 	if (radeon_fb == NULL) {
-		drm_gem_object_unreference_unlocked(obj);
+		drm_gem_object_put_unlocked(obj);
 		return ERR_PTR(-ENOMEM);
 	}
 
 	ret = radeon_framebuffer_init(dev, radeon_fb, mode_cmd, obj);
 	if (ret) {
 		kfree(radeon_fb);
-		drm_gem_object_unreference_unlocked(obj);
+		drm_gem_object_put_unlocked(obj);
 		return ERR_PTR(ret);
 	}
 
diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeon/radeon_fb.c
index 356ad90..976d224 100644
--- a/drivers/gpu/drm/radeon/radeon_fb.c
+++ b/drivers/gpu/drm/radeon/radeon_fb.c
@@ -118,7 +118,7 @@ static void radeonfb_destroy_pinned_object(struct drm_gem_object *gobj)
 		radeon_bo_unpin(rbo);
 		radeon_bo_unreserve(rbo);
 	}
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 }
 
 static int radeonfb_create_pinned_object(struct radeon_fbdev *rfbdev,
@@ -300,7 +300,7 @@ static int radeonfb_create(struct drm_fb_helper *helper,
 
 	}
 	if (fb && ret) {
-		drm_gem_object_unreference_unlocked(gobj);
+		drm_gem_object_put_unlocked(gobj);
 		drm_framebuffer_unregister_private(fb);
 		drm_framebuffer_cleanup(fb);
 		kfree(fb);
diff --git a/drivers/gpu/drm/radeon/radeon_gem.c b/drivers/gpu/drm/radeon/radeon_gem.c
index 574bf7e..3386452 100644
--- a/drivers/gpu/drm/radeon/radeon_gem.c
+++ b/drivers/gpu/drm/radeon/radeon_gem.c
@@ -271,7 +271,7 @@ int radeon_gem_create_ioctl(struct drm_device *dev, void *data,
 	}
 	r = drm_gem_handle_create(filp, gobj, &handle);
 	/* drop reference from allocate - handle holds it now */
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 	if (r) {
 		up_read(&rdev->exclusive_lock);
 		r = radeon_gem_handle_lockup(rdev, r);
@@ -352,7 +352,7 @@ int radeon_gem_userptr_ioctl(struct drm_device *dev, void *data,
 
 	r = drm_gem_handle_create(filp, gobj, &handle);
 	/* drop reference from allocate - handle holds it now */
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 	if (r)
 		goto handle_lockup;
 
@@ -361,7 +361,7 @@ int radeon_gem_userptr_ioctl(struct drm_device *dev, void *data,
 	return 0;
 
 release_object:
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 
 handle_lockup:
 	up_read(&rdev->exclusive_lock);
@@ -395,7 +395,7 @@ int radeon_gem_set_domain_ioctl(struct drm_device *dev, void *data,
 
 	r = radeon_gem_set_domain(gobj, args->read_domains, args->write_domain);
 
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 	up_read(&rdev->exclusive_lock);
 	r = radeon_gem_handle_lockup(robj->rdev, r);
 	return r;
@@ -414,11 +414,11 @@ int radeon_mode_dumb_mmap(struct drm_file *filp,
 	}
 	robj = gem_to_radeon_bo(gobj);
 	if (radeon_ttm_tt_has_userptr(robj->tbo.ttm)) {
-		drm_gem_object_unreference_unlocked(gobj);
+		drm_gem_object_put_unlocked(gobj);
 		return -EPERM;
 	}
 	*offset_p = radeon_bo_mmap_offset(robj);
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 	return 0;
 }
 
@@ -453,7 +453,7 @@ int radeon_gem_busy_ioctl(struct drm_device *dev, void *data,
 
 	cur_placement = ACCESS_ONCE(robj->tbo.mem.mem_type);
 	args->domain = radeon_mem_type_to_domain(cur_placement);
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 	return r;
 }
 
@@ -485,7 +485,7 @@ int radeon_gem_wait_idle_ioctl(struct drm_device *dev, void *data,
 	if (rdev->asic->mmio_hdp_flush &&
 	    radeon_mem_type_to_domain(cur_placement) == RADEON_GEM_DOMAIN_VRAM)
 		robj->rdev->asic->mmio_hdp_flush(rdev);
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 	r = radeon_gem_handle_lockup(rdev, r);
 	return r;
 }
@@ -504,7 +504,7 @@ int radeon_gem_set_tiling_ioctl(struct drm_device *dev, void *data,
 		return -ENOENT;
 	robj = gem_to_radeon_bo(gobj);
 	r = radeon_bo_set_tiling_flags(robj, args->tiling_flags, args->pitch);
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 	return r;
 }
 
@@ -527,7 +527,7 @@ int radeon_gem_get_tiling_ioctl(struct drm_device *dev, void *data,
 	radeon_bo_get_tiling_flags(rbo, &args->tiling_flags, &args->pitch);
 	radeon_bo_unreserve(rbo);
 out:
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 	return r;
 }
 
@@ -661,14 +661,14 @@ int radeon_gem_va_ioctl(struct drm_device *dev, void *data,
 	r = radeon_bo_reserve(rbo, false);
 	if (r) {
 		args->operation = RADEON_VA_RESULT_ERROR;
-		drm_gem_object_unreference_unlocked(gobj);
+		drm_gem_object_put_unlocked(gobj);
 		return r;
 	}
 	bo_va = radeon_vm_bo_find(&fpriv->vm, rbo);
 	if (!bo_va) {
 		args->operation = RADEON_VA_RESULT_ERROR;
 		radeon_bo_unreserve(rbo);
-		drm_gem_object_unreference_unlocked(gobj);
+		drm_gem_object_put_unlocked(gobj);
 		return -ENOENT;
 	}
 
@@ -695,7 +695,7 @@ int radeon_gem_va_ioctl(struct drm_device *dev, void *data,
 		args->operation = RADEON_VA_RESULT_ERROR;
 	}
 out:
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 	return r;
 }
 
@@ -736,7 +736,7 @@ int radeon_gem_op_ioctl(struct drm_device *dev, void *data,
 
 	radeon_bo_unreserve(robj);
 out:
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 	return r;
 }
 
@@ -762,7 +762,7 @@ int radeon_mode_dumb_create(struct drm_file *file_priv,
 
 	r = drm_gem_handle_create(file_priv, gobj, &handle);
 	/* drop reference from allocate - handle holds it now */
-	drm_gem_object_unreference_unlocked(gobj);
+	drm_gem_object_put_unlocked(gobj);
 	if (r) {
 		return r;
 	}
diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
index 8b72229..ad2a2fd 100644
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -445,7 +445,7 @@ void radeon_bo_force_delete(struct radeon_device *rdev)
 		list_del_init(&bo->list);
 		mutex_unlock(&bo->rdev->gem.mutex);
 		/* this should unref the ttm bo */
-		drm_gem_object_unreference_unlocked(&bo->gem_base);
+		drm_gem_object_put_unlocked(&bo->gem_base);
 	}
 }
 
-- 
2.7.4

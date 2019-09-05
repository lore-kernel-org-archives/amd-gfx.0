From: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 4/8] drm/radeon: switch to gem vma offset manager
Date: Thu,  5 Sep 2019 09:05:05 +0200
Message-ID: <20190905070509.22407-5-kraxel@redhat.com>
References: <20190905070509.22407-1-kraxel@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190905070509.22407-1-kraxel@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "open list:RADEON and AMDGPU DRM DRIVERS" <amd-gfx@lists.freedesktop.org>, open list <linux-kernel@vger.kernel.org>
List-Id: amd-gfx.lists.freedesktop.org

Pass gem vma_offset_manager to ttm_bo_device_init(), so ttm uses it
instead of its own embedded struct.  This makes some gem functions
(specifically drm_gem_object_lookup) work on ttm objects.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index e2c12e59704d..a46bb3067863 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -794,7 +794,7 @@ int radeon_ttm_init(struct radeon_device *rdev)
 	r = ttm_bo_device_init(&rdev->mman.bdev,
 			       &radeon_bo_driver,
 			       rdev->ddev->anon_inode->i_mapping,
-			       NULL,
+			       rdev->ddev->vma_offset_manager,
 			       rdev->need_dma32);
 	if (r) {
 		DRM_ERROR("failed initializing buffer object driver(%d).\n", r);
-- 
2.18.1

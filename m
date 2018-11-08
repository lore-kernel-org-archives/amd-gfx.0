From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/radeon: remove set but not used variable 'rdev'
Date: Thu, 8 Nov 2018 11:53:43 +0000
Message-ID: <1541678023-143862-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie
Cc: Yue Haibing <yuehaibing@huawei.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Yue Haibing <yuehaibing@huawei.com>

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/radeon/radeon_object.c: In function 'radeon_bo_unref':
drivers/gpu/drm/radeon/radeon_object.c:317:24: warning:
 variable 'rdev' set but not used [-Wunused-but-set-variable]

It not used  any more after commit
  e7e31600d3e2 ("drm/radeon: remove taking mclk_lock from radeon_bo_unref")

Signed-off-by: Yue Haibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/radeon/radeon_object.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_object.c b/drivers/gpu/drm/radeon/radeon_object.c
index ba2fd29..c4b2e14 100644
--- a/drivers/gpu/drm/radeon/radeon_object.c
+++ b/drivers/gpu/drm/radeon/radeon_object.c
@@ -314,11 +314,9 @@ struct radeon_bo *radeon_bo_ref(struct radeon_bo *bo)
 void radeon_bo_unref(struct radeon_bo **bo)
 {
 	struct ttm_buffer_object *tbo;
-	struct radeon_device *rdev;
 
 	if ((*bo) == NULL)
 		return;
-	rdev = (*bo)->rdev;
 	tbo = &((*bo)->tbo);
 	ttm_bo_put(tbo);
 	*bo = NULL;

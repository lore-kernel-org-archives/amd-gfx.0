From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] gpu: drm: radeon: radeon_test: Replace mdelay() with msleep()
Date: Sat,  4 Aug 2018 08:01:02 +0800
Message-ID: <20180804000102.17737-1-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

radeon_test_ring_sync() and radeon_test_ring_sync2() are never 
called in atomic context.
They call mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_test.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_test.c b/drivers/gpu/drm/radeon/radeon_test.c
index f5e9abfadb56..411efa303f54 100644
--- a/drivers/gpu/drm/radeon/radeon_test.c
+++ b/drivers/gpu/drm/radeon/radeon_test.c
@@ -347,7 +347,7 @@ void radeon_test_ring_sync(struct radeon_device *rdev,
 	if (r)
 		goto out_cleanup;
 
-	mdelay(1000);
+	msleep(1000);
 
 	if (radeon_fence_signaled(fence1)) {
 		DRM_ERROR("Fence 1 signaled without waiting for semaphore.\n");
@@ -368,7 +368,7 @@ void radeon_test_ring_sync(struct radeon_device *rdev,
 		goto out_cleanup;
 	}
 
-	mdelay(1000);
+	msleep(1000);
 
 	if (radeon_fence_signaled(fence2)) {
 		DRM_ERROR("Fence 2 signaled without waiting for semaphore.\n");
@@ -441,7 +441,7 @@ static void radeon_test_ring_sync2(struct radeon_device *rdev,
 	if (r)
 		goto out_cleanup;
 
-	mdelay(1000);
+	msleep(1000);
 
 	if (radeon_fence_signaled(fenceA)) {
 		DRM_ERROR("Fence A signaled without waiting for semaphore.\n");
@@ -461,7 +461,7 @@ static void radeon_test_ring_sync2(struct radeon_device *rdev,
 	radeon_ring_unlock_commit(rdev, ringC, false);
 
 	for (i = 0; i < 30; ++i) {
-		mdelay(100);
+		msleep(100);
 		sigA = radeon_fence_signaled(fenceA);
 		sigB = radeon_fence_signaled(fenceB);
 		if (sigA || sigB)
@@ -486,7 +486,7 @@ static void radeon_test_ring_sync2(struct radeon_device *rdev,
 	radeon_semaphore_emit_signal(rdev, ringC->idx, semaphore);
 	radeon_ring_unlock_commit(rdev, ringC, false);
 
-	mdelay(1000);
+	msleep(1000);
 
 	r = radeon_fence_wait(fenceA, false);
 	if (r) {
-- 
2.17.0

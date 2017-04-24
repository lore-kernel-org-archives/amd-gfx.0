From: Pan Bian <bianpan201603@163.com>
Subject: [PATCH 1/1] drm/radeon: check return value of radeon_ring_lock
Date: Mon, 24 Apr 2017 16:38:05 +0800
Message-ID: <1493023085-11901-1-git-send-email-bianpan201603@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
List-Id: amd-gfx.lists.freedesktop.org

From: Pan Bian <bianpan2016@163.com>

Function radeon_ring_lock() returns an errno on failure, and its return
value should be validated. However, in functions r420_cp_errata_init()
and r420_cp_errata_fini(), its return value is not checked. This patch
adds the checks.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/gpu/drm/radeon/r420.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r420.c b/drivers/gpu/drm/radeon/r420.c
index 2828605..391c764 100644
--- a/drivers/gpu/drm/radeon/r420.c
+++ b/drivers/gpu/drm/radeon/r420.c
@@ -206,6 +206,7 @@ static void r420_clock_resume(struct radeon_device *rdev)
 
 static void r420_cp_errata_init(struct radeon_device *rdev)
 {
+	int r;
 	struct radeon_ring *ring = &rdev->ring[RADEON_RING_TYPE_GFX_INDEX];
 
 	/* RV410 and R420 can lock up if CP DMA to host memory happens
@@ -215,7 +216,8 @@ static void r420_cp_errata_init(struct radeon_device *rdev)
 	 * of the CP init, apparently.
 	 */
 	radeon_scratch_get(rdev, &rdev->config.r300.resync_scratch);
-	radeon_ring_lock(rdev, ring, 8);
+	r = radeon_ring_lock(rdev, ring, 8);
+	WARN_ON(r);
 	radeon_ring_write(ring, PACKET0(R300_CP_RESYNC_ADDR, 1));
 	radeon_ring_write(ring, rdev->config.r300.resync_scratch);
 	radeon_ring_write(ring, 0xDEADBEEF);
@@ -224,12 +226,14 @@ static void r420_cp_errata_init(struct radeon_device *rdev)
 
 static void r420_cp_errata_fini(struct radeon_device *rdev)
 {
+	int r;
 	struct radeon_ring *ring = &rdev->ring[RADEON_RING_TYPE_GFX_INDEX];
 
 	/* Catch the RESYNC we dispatched all the way back,
 	 * at the very beginning of the CP init.
 	 */
-	radeon_ring_lock(rdev, ring, 8);
+	r = radeon_ring_lock(rdev, ring, 8);
+	WARN_ON(r);
 	radeon_ring_write(ring, PACKET0(R300_RB3D_DSTCACHE_CTLSTAT, 0));
 	radeon_ring_write(ring, R300_RB3D_DC_FINISH);
 	radeon_ring_unlock_commit(rdev, ring, false);
-- 
1.9.1

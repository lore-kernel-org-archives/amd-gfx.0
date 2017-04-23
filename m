From: Pan Bian <bianpan201603@163.com>
Subject: [PATCH 1/1] drm/radeon: check return value of radeon_ring_lock
Date: Sun, 23 Apr 2017 21:36:43 +0800
Message-ID: <1492954603-16489-1-git-send-email-bianpan201603@163.com>
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
 drivers/gpu/drm/radeon/r420.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r420.c b/drivers/gpu/drm/radeon/r420.c
index 2828605..a8c2b37 100644
--- a/drivers/gpu/drm/radeon/r420.c
+++ b/drivers/gpu/drm/radeon/r420.c
@@ -215,7 +215,8 @@ static void r420_cp_errata_init(struct radeon_device *rdev)
 	 * of the CP init, apparently.
 	 */
 	radeon_scratch_get(rdev, &rdev->config.r300.resync_scratch);
-	radeon_ring_lock(rdev, ring, 8);
+	if (radeon_ring_lock(rdev, ring, 8))
+		return;
 	radeon_ring_write(ring, PACKET0(R300_CP_RESYNC_ADDR, 1));
 	radeon_ring_write(ring, rdev->config.r300.resync_scratch);
 	radeon_ring_write(ring, 0xDEADBEEF);
@@ -229,7 +230,8 @@ static void r420_cp_errata_fini(struct radeon_device *rdev)
 	/* Catch the RESYNC we dispatched all the way back,
 	 * at the very beginning of the CP init.
 	 */
-	radeon_ring_lock(rdev, ring, 8);
+	if (radeon_ring_lock(rdev, ring, 8))
+		return;
 	radeon_ring_write(ring, PACKET0(R300_RB3D_DSTCACHE_CTLSTAT, 0));
 	radeon_ring_write(ring, R300_RB3D_DC_FINISH);
 	radeon_ring_unlock_commit(rdev, ring, false);
-- 
1.9.1

From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] gpu: drm: radeon: r300: Replace mdelay() with msleep() and usleep_range() in r300_asic_reset()
Date: Sat,  4 Aug 2018 08:21:50 +0800
Message-ID: <20180804002150.18247-1-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

r300_asic_reset() is never called in atomic context.
It calls mdelay() to busily wait, which is not necessary.
mdelay() can be replaced with msleep() and usleep_range().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/radeon/r300.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r300.c b/drivers/gpu/drm/radeon/r300.c
index 21161aa8acbf..55cf02400d5a 100644
--- a/drivers/gpu/drm/radeon/r300.c
+++ b/drivers/gpu/drm/radeon/r300.c
@@ -434,9 +434,9 @@ int r300_asic_reset(struct radeon_device *rdev, bool hard)
 	WREG32(R_0000F0_RBBM_SOFT_RESET, S_0000F0_SOFT_RESET_VAP(1) |
 					S_0000F0_SOFT_RESET_GA(1));
 	RREG32(R_0000F0_RBBM_SOFT_RESET);
-	mdelay(500);
+	msleep(500);
 	WREG32(R_0000F0_RBBM_SOFT_RESET, 0);
-	mdelay(1);
+	usleep_range(1000, 2000);
 	status = RREG32(R_000E40_RBBM_STATUS);
 	dev_info(rdev->dev, "(%s:%d) RBBM_STATUS=0x%08X\n", __func__, __LINE__, status);
 	/* resetting the CP seems to be problematic sometimes it end up
@@ -446,9 +446,9 @@ int r300_asic_reset(struct radeon_device *rdev, bool hard)
 	 */
 	WREG32(R_0000F0_RBBM_SOFT_RESET, S_0000F0_SOFT_RESET_CP(1));
 	RREG32(R_0000F0_RBBM_SOFT_RESET);
-	mdelay(500);
+	msleep(500);
 	WREG32(R_0000F0_RBBM_SOFT_RESET, 0);
-	mdelay(1);
+	usleep_range(1000, 2000);
 	status = RREG32(R_000E40_RBBM_STATUS);
 	dev_info(rdev->dev, "(%s:%d) RBBM_STATUS=0x%08X\n", __func__, __LINE__, status);
 	/* restore PCI & busmastering */
-- 
2.17.0

From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [PATCH] gpu: drm: radeon: r600: Replace mdelay() and udelay() with msleep() and usleep_range()
Date: Sat,  4 Aug 2018 08:12:52 +0800
Message-ID: <20180804001252.17995-1-baijiaju1990@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Jia-Ju Bai <baijiaju1990@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

r600_gpu_soft_reset() and r600_gpu_pci_config_reset() are never
called in atomic context.
They call mdelay() and udelay() to busily wait, which is not necessary.
mdelay() and udelay() can be replaced with msleep() and usleep_range().

This is found by a static analysis tool named DCNS written by myself.

Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
---
 drivers/gpu/drm/radeon/r600.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
index e06e2d8feab3..de5f6d9f251e 100644
--- a/drivers/gpu/drm/radeon/r600.c
+++ b/drivers/gpu/drm/radeon/r600.c
@@ -1705,7 +1705,7 @@ static void r600_gpu_soft_reset(struct radeon_device *rdev, u32 reset_mask)
 		WREG32(DMA_RB_CNTL, tmp);
 	}
 
-	mdelay(50);
+	msleep(50);
 
 	rv515_mc_stop(rdev, &save);
 	if (r600_mc_wait_for_idle(rdev)) {
@@ -1782,7 +1782,7 @@ static void r600_gpu_soft_reset(struct radeon_device *rdev, u32 reset_mask)
 		WREG32(R_008020_GRBM_SOFT_RESET, tmp);
 		tmp = RREG32(R_008020_GRBM_SOFT_RESET);
 
-		udelay(50);
+		usleep_range(50, 100);
 
 		tmp &= ~grbm_soft_reset;
 		WREG32(R_008020_GRBM_SOFT_RESET, tmp);
@@ -1796,7 +1796,7 @@ static void r600_gpu_soft_reset(struct radeon_device *rdev, u32 reset_mask)
 		WREG32(SRBM_SOFT_RESET, tmp);
 		tmp = RREG32(SRBM_SOFT_RESET);
 
-		udelay(50);
+		usleep_range(50, 100);
 
 		tmp &= ~srbm_soft_reset;
 		WREG32(SRBM_SOFT_RESET, tmp);
@@ -1804,10 +1804,10 @@ static void r600_gpu_soft_reset(struct radeon_device *rdev, u32 reset_mask)
 	}
 
 	/* Wait a little for things to settle down */
-	mdelay(1);
+	usleep_range(1000, 2000);
 
 	rv515_mc_resume(rdev, &save);
-	udelay(50);
+	usleep_range(50, 100);
 
 	r600_print_gpu_status_regs(rdev);
 }
@@ -1835,7 +1835,7 @@ static void r600_gpu_pci_config_reset(struct radeon_device *rdev)
 	tmp &= ~DMA_RB_ENABLE;
 	WREG32(DMA_RB_CNTL, tmp);
 
-	mdelay(50);
+	msleep(50);
 
 	/* set mclk/sclk to bypass */
 	if (rdev->family >= CHIP_RV770)
@@ -1857,12 +1857,12 @@ static void r600_gpu_pci_config_reset(struct radeon_device *rdev)
 
 	/* reset */
 	radeon_pci_config_reset(rdev);
-	mdelay(1);
+	usleep_range(1000, 2000);
 
 	/* BIF reset workaround.  Not sure if this is needed on 6xx */
 	tmp = SOFT_RESET_BIF;
 	WREG32(SRBM_SOFT_RESET, tmp);
-	mdelay(1);
+	usleep_range(1000, 2000);
 	WREG32(SRBM_SOFT_RESET, 0);
 
 	/* wait for asic to come out of reset */
-- 
2.17.0

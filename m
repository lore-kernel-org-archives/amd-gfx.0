From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/4] drm/radeon: handle PCIe root ports with addressing limitations
Date: Thu, 15 Aug 2019 09:27:00 +0200
Message-ID: <20190815072703.7010-2-hch@lst.de>
References: <20190815072703.7010-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815072703.7010-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

radeon uses a need_dma32 flag to indicate to the drm core that some
allocations need to be done using GFP_DMA32, but it only checks the
device addressing capabilities to make that decision.  Unfortunately
PCIe root ports that have limited addressing exist as well.  Use the
dma_addressing_limited instead to also take those into account.

Reported-by: Atish Patra <Atish.Patra@wdc.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/radeon/radeon.h        |  1 -
 drivers/gpu/drm/radeon/radeon_device.c | 12 +++++-------
 drivers/gpu/drm/radeon/radeon_ttm.c    |  2 +-
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 32808e50be12..1a0b22526a75 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -2387,7 +2387,6 @@ struct radeon_device {
 	struct radeon_wb		wb;
 	struct radeon_dummy_page	dummy_page;
 	bool				shutdown;
-	bool				need_dma32;
 	bool				need_swiotlb;
 	bool				accel_working;
 	bool				fastfb_working; /* IGP feature*/
diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index dceb554e5674..b8cc05826667 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -1365,27 +1365,25 @@ int radeon_device_init(struct radeon_device *rdev,
 	else
 		rdev->mc.mc_mask = 0xffffffffULL; /* 32 bit MC */
 
-	/* set DMA mask + need_dma32 flags.
+	/* set DMA mask.
 	 * PCIE - can handle 40-bits.
 	 * IGP - can handle 40-bits
 	 * AGP - generally dma32 is safest
 	 * PCI - dma32 for legacy pci gart, 40 bits on newer asics
 	 */
-	rdev->need_dma32 = false;
+	dma_bits = 40;
 	if (rdev->flags & RADEON_IS_AGP)
-		rdev->need_dma32 = true;
+		dma_bits = 32;
 	if ((rdev->flags & RADEON_IS_PCI) &&
 	    (rdev->family <= CHIP_RS740))
-		rdev->need_dma32 = true;
+		dma_bits = 32;
 #ifdef CONFIG_PPC64
 	if (rdev->family == CHIP_CEDAR)
-		rdev->need_dma32 = true;
+		dma_bits = 32;
 #endif
 
-	dma_bits = rdev->need_dma32 ? 32 : 40;
 	r = pci_set_dma_mask(rdev->pdev, DMA_BIT_MASK(dma_bits));
 	if (r) {
-		rdev->need_dma32 = true;
 		dma_bits = 32;
 		pr_warn("radeon: No suitable DMA available\n");
 	}
diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index fb3696bc616d..116a27b25dc4 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -794,7 +794,7 @@ int radeon_ttm_init(struct radeon_device *rdev)
 	r = ttm_bo_device_init(&rdev->mman.bdev,
 			       &radeon_bo_driver,
 			       rdev->ddev->anon_inode->i_mapping,
-			       rdev->need_dma32);
+			       dma_addressing_limited(&rdev->pdev->dev));
 	if (r) {
 		DRM_ERROR("failed initializing buffer object driver(%d).\n", r);
 		return r;
-- 
2.20.1

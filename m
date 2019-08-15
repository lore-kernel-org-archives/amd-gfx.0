From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/4] drm/radeon: simplify and cleanup setting the dma mask
Date: Thu, 15 Aug 2019 09:27:02 +0200
Message-ID: <20190815072703.7010-4-hch@lst.de>
References: <20190815072703.7010-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815072703.7010-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Use dma_set_mask_and_coherent to set both masks in one go, and remove
the no longer required fallback, as the kernel now always accepts
larger than required DMA masks.  Fail the driver probe if we can't
set the DMA mask, as that means the system can only support a larger
mask.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/radeon/radeon_device.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_device.c b/drivers/gpu/drm/radeon/radeon_device.c
index b8cc05826667..88eb7cb522bb 100644
--- a/drivers/gpu/drm/radeon/radeon_device.c
+++ b/drivers/gpu/drm/radeon/radeon_device.c
@@ -1382,15 +1382,10 @@ int radeon_device_init(struct radeon_device *rdev,
 		dma_bits = 32;
 #endif
 
-	r = pci_set_dma_mask(rdev->pdev, DMA_BIT_MASK(dma_bits));
+	r = dma_set_mask_and_coherent(&rdev->pdev->dev, DMA_BIT_MASK(dma_bits));
 	if (r) {
-		dma_bits = 32;
 		pr_warn("radeon: No suitable DMA available\n");
-	}
-	r = pci_set_consistent_dma_mask(rdev->pdev, DMA_BIT_MASK(dma_bits));
-	if (r) {
-		pci_set_consistent_dma_mask(rdev->pdev, DMA_BIT_MASK(32));
-		pr_warn("radeon: No coherent DMA available\n");
+		return r;
 	}
 	rdev->need_swiotlb = drm_need_swiotlb(dma_bits);
 
-- 
2.20.1

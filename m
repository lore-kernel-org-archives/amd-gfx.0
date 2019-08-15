From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/4] drm/amdgpu: handle PCIe root ports with addressing limitations
Date: Thu, 15 Aug 2019 09:27:01 +0200
Message-ID: <20190815072703.7010-3-hch@lst.de>
References: <20190815072703.7010-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190815072703.7010-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: Atish Patra <Atish.Patra@wdc.com>, Alistair Francis <alistair.francis@wdc.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

amdgpu uses a need_dma32 flag to indicate to the drm core that some
allocations need to be done using GFP_DMA32, but it only checks the
device addressing capabilities to make that decision.  Unfortunately
PCIe root ports that have limited addressing exist as well.  Use the
dma_addressing_limited instead to also take those into account.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e51b48ac48eb..91f128b43b6a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1728,7 +1728,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	r = ttm_bo_device_init(&adev->mman.bdev,
 			       &amdgpu_bo_driver,
 			       adev->ddev->anon_inode->i_mapping,
-			       adev->need_dma32);
+			       dma_addressing_limited(adev->dev));
 	if (r) {
 		DRM_ERROR("failed initializing buffer object driver(%d).\n", r);
 		return r;
-- 
2.20.1

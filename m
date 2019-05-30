From: Hariprasad Kelam <hariprasad.kelam@gmail.com>
Subject: [PATCH] drm/amdgpu: Remove call to memset after dma_alloc_coherent
Date: Thu, 30 May 2019 23:55:32 +0530
Message-ID: <20190530182532.GA8370@hari-Inspiron-1545>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Huang Rui <ray.huang@amd.com>, Hariprasad Kelam <hariprasad.kelam@gmail.com>, Oak Zeng <Oak.Zeng@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

This patch fixes below warning reported by coccicheck

./drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c:63:13-31: WARNING:
dma_alloc_coherent use in ih -> ring already zeroes out memory,  so
memset is not needed

Signed-off-by: Hariprasad Kelam <hariprasad.kelam@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
index 934dfdc..d922187 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ih.c
@@ -65,7 +65,6 @@ int amdgpu_ih_ring_init(struct amdgpu_device *adev, struct amdgpu_ih_ring *ih,
 		if (ih->ring == NULL)
 			return -ENOMEM;
 
-		memset((void *)ih->ring, 0, ih->ring_size + 8);
 		ih->gpu_addr = dma_addr;
 		ih->wptr_addr = dma_addr + ih->ring_size;
 		ih->wptr_cpu = &ih->ring[ih->ring_size / 4];
-- 
2.7.4

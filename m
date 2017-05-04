From: Nikola Pajkovsky <npajkovsky@suse.cz>
Subject: [PATCH] drm/amd/amdgpu: get rid of else branch
Date: Thu,  4 May 2017 14:52:38 +0200
Message-ID: <5a3557799269f0c74694a10a5ee6a6427e2a4290.1493902309.git.npajkovsky@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Nikola Pajkovsky <npajkovsky@suse.cz>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

else branch is pointless if it's right at the end of function and use
unlikely() on err path.

Signed-off-by: Nikola Pajkovsky <npajkovsky@suse.cz>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h | 45 +++++++++++++++++++------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c1b913541739..8ab250d4761a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1594,30 +1594,31 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring, void *sr
 	unsigned occupied, chunk1, chunk2;
 	void *dst;
 
-	if (ring->count_dw < count_dw) {
+	if (unlikely(ring->count_dw < count_dw)) {
 		DRM_ERROR("amdgpu: writing more dwords to the ring than expected!\n");
-	} else {
-		occupied = ring->wptr & ring->ptr_mask;
-		dst = (void *)&ring->ring[occupied];
-		chunk1 = ring->ptr_mask + 1 - occupied;
-		chunk1 = (chunk1 >= count_dw) ? count_dw: chunk1;
-		chunk2 = count_dw - chunk1;
-		chunk1 <<= 2;
-		chunk2 <<= 2;
-
-		if (chunk1)
-			memcpy(dst, src, chunk1);
-
-		if (chunk2) {
-			src += chunk1;
-			dst = (void *)ring->ring;
-			memcpy(dst, src, chunk2);
-		}
-
-		ring->wptr += count_dw;
-		ring->wptr &= ring->ptr_mask;
-		ring->count_dw -= count_dw;
+		return;
 	}
+
+	occupied = ring->wptr & ring->ptr_mask;
+	dst = (void *)&ring->ring[occupied];
+	chunk1 = ring->ptr_mask + 1 - occupied;
+	chunk1 = (chunk1 >= count_dw) ? count_dw: chunk1;
+	chunk2 = count_dw - chunk1;
+	chunk1 <<= 2;
+	chunk2 <<= 2;
+
+	if (chunk1)
+		memcpy(dst, src, chunk1);
+
+	if (chunk2) {
+		src += chunk1;
+		dst = (void *)ring->ring;
+		memcpy(dst, src, chunk2);
+	}
+
+	ring->wptr += count_dw;
+	ring->wptr &= ring->ptr_mask;
+	ring->count_dw -= count_dw;
 }
 
 static inline struct amdgpu_sdma_instance *
-- 
2.12.2

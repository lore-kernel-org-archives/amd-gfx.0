From: Nikola Pajkovsky <npajkovsky@suse.cz>
Subject: [RFC] drm/amd/amdgpu: get rid of else branch
Date: Thu, 27 Apr 2017 18:17:44 +0200
Message-ID: <c9e022e344770c861714615c6386d1821e2fa0a5.1493307341.git.npajkovsky@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

This is super simple elimination of else branch and I should
probably even use unlikely in

 	if (ring->count_dw < count_dw) {

However, amdgpu_ring_write() has similar if condition, but does not
return after DRM_ERROR and it looks suspicious. On error, we still
adding v to ring and keeping count_dw-- below zero.

	if (ring->count_dw <= 0)
		DRM_ERROR("amdgpu: writing more dwords to the ring than expected!\n");
	ring->ring[ring->wptr++] = v;
	ring->wptr &= ring->ptr_mask;
	ring->count_dw--;

I can obviously be totaly wrong. Hmm?

--------8<--------8<--------8<--------8<--------8<--------8<--------8<--------8<--------8<
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index c1b913541739..c6f4f874ea68 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1596,28 +1596,29 @@ static inline void amdgpu_ring_write_multiple(struct amdgpu_ring *ring, void *sr
 
 	if (ring->count_dw < count_dw) {
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

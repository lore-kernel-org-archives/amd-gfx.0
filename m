From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] drm/amdgpu/sdma: fix mask in emit_pipeline_sync
Date: Tue, 27 Mar 2018 16:33:55 -0500
Message-ID: <20180327213355.18249-1-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Needs to be a 32 bit mask.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c  | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index f48ea0dad875..a7576255cc30 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -859,7 +859,7 @@ static void cik_sdma_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, addr & 0xfffffffc);
 	amdgpu_ring_write(ring, upper_32_bits(addr) & 0xffffffff);
 	amdgpu_ring_write(ring, seq); /* reference */
-	amdgpu_ring_write(ring, 0xfffffff); /* mask */
+	amdgpu_ring_write(ring, 0xffffffff); /* mask */
 	amdgpu_ring_write(ring, (0xfff << 16) | 4); /* retry count, poll interval */
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 6452101c7aab..c7190c39c4f5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -837,7 +837,7 @@ static void sdma_v2_4_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, addr & 0xfffffffc);
 	amdgpu_ring_write(ring, upper_32_bits(addr) & 0xffffffff);
 	amdgpu_ring_write(ring, seq); /* reference */
-	amdgpu_ring_write(ring, 0xfffffff); /* mask */
+	amdgpu_ring_write(ring, 0xffffffff); /* mask */
 	amdgpu_ring_write(ring, SDMA_PKT_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
 			  SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(4)); /* retry count, poll interval */
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index ecaef084dab1..be20a387d961 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -1105,7 +1105,7 @@ static void sdma_v3_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, addr & 0xfffffffc);
 	amdgpu_ring_write(ring, upper_32_bits(addr) & 0xffffffff);
 	amdgpu_ring_write(ring, seq); /* reference */
-	amdgpu_ring_write(ring, 0xfffffff); /* mask */
+	amdgpu_ring_write(ring, 0xffffffff); /* mask */
 	amdgpu_ring_write(ring, SDMA_PKT_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
 			  SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(4)); /* retry count, poll interval */
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index 2a8184082cd1..399f876f9cad 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -1121,7 +1121,7 @@ static void sdma_v4_0_ring_emit_pipeline_sync(struct amdgpu_ring *ring)
 	amdgpu_ring_write(ring, addr & 0xfffffffc);
 	amdgpu_ring_write(ring, upper_32_bits(addr) & 0xffffffff);
 	amdgpu_ring_write(ring, seq); /* reference */
-	amdgpu_ring_write(ring, 0xfffffff); /* mask */
+	amdgpu_ring_write(ring, 0xffffffff); /* mask */
 	amdgpu_ring_write(ring, SDMA_PKT_POLL_REGMEM_DW5_RETRY_COUNT(0xfff) |
 			  SDMA_PKT_POLL_REGMEM_DW5_INTERVAL(4)); /* retry count, poll interval */
 }
-- 
2.13.6

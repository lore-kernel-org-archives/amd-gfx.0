From: Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] drm/amdgpu: Fix memory leak in amdgpu_fence_emit
Date: Mon, 21 Oct 2019 13:09:40 -0500
Message-ID: <20191021180944.22183-1-navid.emamdoost@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: emamd001@umn.edu, kjlu@umn.edu, smccaman@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Evan Quan <evan.quan@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Sam Ravnborg <sam@ravnborg.org>, Jack Xiao <Jack.Xiao@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

In the impelementation of amdgpu_fence_emit() if dma_fence_wait() fails
and returns an errno, before returning the allocated memory for fence
should be released.

Fixes: 3d2aca8c8620 ("drm/amdgpu: fix old fence check in amdgpu_fence_emit")
Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index 23085b352cf2..2f59c9270a7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -166,8 +166,10 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct dma_fence **f,
 		if (old) {
 			r = dma_fence_wait(old, false);
 			dma_fence_put(old);
-			if (r)
+			if (r) {
+				dma_fence_put(fence);
 				return r;
+			}
 		}
 	}
 
-- 
2.17.1

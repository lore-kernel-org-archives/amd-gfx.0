From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.2 31/59] drm/amdgpu: fix error handling in amdgpu_cs_process_fence_dep
Date: Tue,  6 Aug 2019 17:32:51 -0400
Message-ID: <20190806213319.19203-31-sashal@kernel.org>
References: <20190806213319.19203-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190806213319.19203-1-sashal@kernel.org>
Sender: stable-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, Chunming Zhou <david1.zhou@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

From: Christian König <christian.koenig@amd.com>

[ Upstream commit 67d0859e2758ef992fd32499747ce4b1038a63c0 ]

We always need to drop the ctx reference and should check
for errors first and then dereference the fence pointer.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Chunming Zhou <david1.zhou@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 2f6239b6be6fe..fe028561dc0e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1093,29 +1093,27 @@ static int amdgpu_cs_process_fence_dep(struct amdgpu_cs_parser *p,
 			return r;
 		}
 
-		fence = amdgpu_ctx_get_fence(ctx, entity,
-					     deps[i].handle);
+		fence = amdgpu_ctx_get_fence(ctx, entity, deps[i].handle);
+		amdgpu_ctx_put(ctx);
+
+		if (IS_ERR(fence))
+			return PTR_ERR(fence);
+		else if (!fence)
+			continue;
 
 		if (chunk->chunk_id == AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES) {
-			struct drm_sched_fence *s_fence = to_drm_sched_fence(fence);
+			struct drm_sched_fence *s_fence;
 			struct dma_fence *old = fence;
 
+			s_fence = to_drm_sched_fence(fence);
 			fence = dma_fence_get(&s_fence->scheduled);
 			dma_fence_put(old);
 		}
 
-		if (IS_ERR(fence)) {
-			r = PTR_ERR(fence);
-			amdgpu_ctx_put(ctx);
+		r = amdgpu_sync_fence(p->adev, &p->job->sync, fence, true);
+		dma_fence_put(fence);
+		if (r)
 			return r;
-		} else if (fence) {
-			r = amdgpu_sync_fence(p->adev, &p->job->sync, fence,
-					true);
-			dma_fence_put(fence);
-			amdgpu_ctx_put(ctx);
-			if (r)
-				return r;
-		}
 	}
 	return 0;
 }
-- 
2.20.1

From: Pan Bian <bianpan2016@163.com>
Subject: [PATCH v2] drm/amdgpu: fix double reference dropping
Date: Wed,  6 Nov 2019 19:35:43 +0800
Message-ID: <1573040143-25820-1-git-send-email-bianpan2016@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com, David1.Zhou@amd.com, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
List-Id: amd-gfx.lists.freedesktop.org

The reference to object fence is dropped at the end of the loop.
However, it is dropped again outside the loop. The reference can be
dropped immediately after calling dma_fence_wait() in the loop and
thus the dropping operation outside the loop can be removed.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
v2: fix the bug in a more concise way
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
index 649e68c4479b..d1495e1c9289 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
@@ -33,7 +33,7 @@ static int amdgpu_benchmark_do_move(struct amdgpu_device *adev, unsigned size,
 {
 	unsigned long start_jiffies;
 	unsigned long end_jiffies;
-	struct dma_fence *fence = NULL;
+	struct dma_fence *fence;
 	int i, r;
 
 	start_jiffies = jiffies;
@@ -44,16 +44,14 @@ static int amdgpu_benchmark_do_move(struct amdgpu_device *adev, unsigned size,
 		if (r)
 			goto exit_do_move;
 		r = dma_fence_wait(fence, false);
+		dma_fence_put(fence);
 		if (r)
 			goto exit_do_move;
-		dma_fence_put(fence);
 	}
 	end_jiffies = jiffies;
 	r = jiffies_to_msecs(end_jiffies - start_jiffies);
 
 exit_do_move:
-	if (fence)
-		dma_fence_put(fence);
 	return r;
 }
 
-- 
2.7.4

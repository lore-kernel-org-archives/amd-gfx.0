From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 40/79] drm/amdgpu: amdgpu_device_recover_vram always failed if only one node in shadow_list
Date: Fri, 26 Apr 2019 21:37:59 -0400
Message-ID: <20190427013838.6596-40-sashal@kernel.org>
References: <20190427013838.6596-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190427013838.6596-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: wentalou <Wentao.Lou@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

From: wentalou <Wentao.Lou@amd.com>

[ Upstream commit 1712fb1a2f6829150032ac76eb0e39b82a549cfb ]

amdgpu_bo_restore_shadow would assign zero to r if succeeded.
r would remain zero if there is only one node in shadow_list.
current code would always return failure when r <= 0.
restart the timeout for each wait was a rather problematic bug as well.
The value of tmo SHOULD be changed, otherwise we wait tmo jiffies on each loop.

Signed-off-by: Wentao Lou <Wentao.Lou@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7ff3a28fc903..d55dd570a702 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -3158,11 +3158,16 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 			break;
 
 		if (fence) {
-			r = dma_fence_wait_timeout(fence, false, tmo);
+			tmo = dma_fence_wait_timeout(fence, false, tmo);
 			dma_fence_put(fence);
 			fence = next;
-			if (r <= 0)
+			if (tmo == 0) {
+				r = -ETIMEDOUT;
 				break;
+			} else if (tmo < 0) {
+				r = tmo;
+				break;
+			}
 		} else {
 			fence = next;
 		}
@@ -3173,8 +3178,8 @@ static int amdgpu_device_recover_vram(struct amdgpu_device *adev)
 		tmo = dma_fence_wait_timeout(fence, false, tmo);
 	dma_fence_put(fence);
 
-	if (r <= 0 || tmo <= 0) {
-		DRM_ERROR("recover vram bo from shadow failed\n");
+	if (r < 0 || tmo <= 0) {
+		DRM_ERROR("recover vram bo from shadow failed, r is %ld, tmo is %ld\n", r, tmo);
 		return -EIO;
 	}
 
-- 
2.19.1

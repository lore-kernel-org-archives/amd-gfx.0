From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] drm: amd: amdgpu: constify ttm_place structures.
Date: Sun,  2 Jul 2017 14:43:58 +0530
Message-ID: <c5a3e3c10ef3728ce16693bfff813e6269d4dd28.1498986678.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

ttm_place are not supposed to change at runtime. All functions
working with ttm_place provided by <drm/ttm/ttm_placement.h> work
with const ttm_place. So mark the non-const structs as const.

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 5db0230..a2c8380 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -186,7 +186,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
 	struct amdgpu_bo *abo;
-	static struct ttm_place placements = {
+	static const struct ttm_place placements = {
 		.fpfn = 0,
 		.lpfn = 0,
 		.flags = TTM_PL_MASK_CACHING | TTM_PL_FLAG_SYSTEM
-- 
2.7.4

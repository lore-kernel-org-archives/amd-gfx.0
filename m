From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amdgpu: remove set but not used variable 'adev'
Date: Wed, 23 Oct 2019 15:58:31 +0800
Message-ID: <20191023075831.33636-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Felix.Kuehling@amd.com, Philip.Yang@amd.com, jgg@ziepe.ca, kraxel@redhat.com, tzimmermann@suse.de, tianci.yin@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
List-Id: amd-gfx.lists.freedesktop.org

drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:1221:24: warning: variable adev set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:488:24: warning: variable adev set but not used [-Wunused-but-set-variable]
drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:547:24: warning: variable adev set but not used [-Wunused-but-set-variable]

It is never used, so can removed it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index a61b0d9..ba00262 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -485,15 +485,12 @@ static int amdgpu_move_vram_ram(struct ttm_buffer_object *bo, bool evict,
 				struct ttm_operation_ctx *ctx,
 				struct ttm_mem_reg *new_mem)
 {
-	struct amdgpu_device *adev;
 	struct ttm_mem_reg *old_mem = &bo->mem;
 	struct ttm_mem_reg tmp_mem;
 	struct ttm_place placements;
 	struct ttm_placement placement;
 	int r;
 
-	adev = amdgpu_ttm_adev(bo->bdev);
-
 	/* create space/pages for new_mem in GTT space */
 	tmp_mem = *new_mem;
 	tmp_mem.mm_node = NULL;
@@ -544,15 +541,12 @@ static int amdgpu_move_ram_vram(struct ttm_buffer_object *bo, bool evict,
 				struct ttm_operation_ctx *ctx,
 				struct ttm_mem_reg *new_mem)
 {
-	struct amdgpu_device *adev;
 	struct ttm_mem_reg *old_mem = &bo->mem;
 	struct ttm_mem_reg tmp_mem;
 	struct ttm_placement placement;
 	struct ttm_place placements;
 	int r;
 
-	adev = amdgpu_ttm_adev(bo->bdev);
-
 	/* make space in GTT for old_mem buffer */
 	tmp_mem = *new_mem;
 	tmp_mem.mm_node = NULL;
@@ -1218,11 +1212,8 @@ static struct ttm_backend_func amdgpu_backend_func = {
 static struct ttm_tt *amdgpu_ttm_tt_create(struct ttm_buffer_object *bo,
 					   uint32_t page_flags)
 {
-	struct amdgpu_device *adev;
 	struct amdgpu_ttm_tt *gtt;
 
-	adev = amdgpu_ttm_adev(bo->bdev);
-
 	gtt = kzalloc(sizeof(struct amdgpu_ttm_tt), GFP_KERNEL);
 	if (gtt == NULL) {
 		return NULL;
-- 
2.7.4

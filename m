From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH] drm: radeon: radeon_ttm: constify ttm_place structures.
Date: Sun,  2 Jul 2017 14:36:47 +0530
Message-ID: <70c8aaafe1e873e84490b099e7b9e62eaf911953.1498986195.git.arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, airlied@linux.ie, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

ttm_place are not supposed to change at runtime. All functions
working with ttm_place provided by <drm/ttm/ttm_placement.h> work
with const ttm_place. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   9235	    344	    136	   9715	   25f3 drivers/gpu/drm/radeon/radeon_ttm.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
   9267	    312	    136	   9715	   25f3 drivers/gpu/drm/radeon/radeon_ttm.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_ttm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_ttm.c b/drivers/gpu/drm/radeon/radeon_ttm.c
index 8b7623b..6499832 100644
--- a/drivers/gpu/drm/radeon/radeon_ttm.c
+++ b/drivers/gpu/drm/radeon/radeon_ttm.c
@@ -178,7 +178,7 @@ static int radeon_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
 static void radeon_evict_flags(struct ttm_buffer_object *bo,
 				struct ttm_placement *placement)
 {
-	static struct ttm_place placements = {
+	static const struct ttm_place placements = {
 		.fpfn = 0,
 		.lpfn = 0,
 		.flags = TTM_PL_MASK_CACHING | TTM_PL_FLAG_SYSTEM
-- 
2.7.4

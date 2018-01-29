From: Tom St Denis <tom.stdenis@amd.com>
Subject: [PATCH] drm/ttm: Fix 'buf' pointer update in ttm_bo_vm_access_kmap() (v2)
Date: Mon, 29 Jan 2018 09:34:10 -0500
Message-ID: <20180129143410.24323-1-tom.stdenis@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org, Tom St Denis <tom.stdenis@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

The buf pointer was not being incremented inside the loop
meaning the same block of data would be read or written
repeatedly.

Fixes: 09ac4fcb3f25 ("drm/ttm: Implement vm_operations_struct.access v2")

Signed-off-by: Tom St Denis <tom.stdenis@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>

(v2) Change 'buf' pointer to uint8_t* type
---
 drivers/gpu/drm/ttm/ttm_bo_vm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
index 08a3c324242e..60fcef1593dd 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
@@ -316,7 +316,7 @@ static void ttm_bo_vm_close(struct vm_area_struct *vma)
 
 static int ttm_bo_vm_access_kmap(struct ttm_buffer_object *bo,
 				 unsigned long offset,
-				 void *buf, int len, int write)
+				 uint8_t *buf, int len, int write)
 {
 	unsigned long page = offset >> PAGE_SHIFT;
 	unsigned long bytes_left = len;
@@ -345,6 +345,7 @@ static int ttm_bo_vm_access_kmap(struct ttm_buffer_object *bo,
 		ttm_bo_kunmap(&map);
 
 		page++;
+		buf += bytes;
 		bytes_left -= bytes;
 		offset = 0;
 	} while (bytes_left);
-- 
2.14.3

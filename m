From: "=?UTF-8?q?Christian=20K=C3=B6nig?="
        <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH 2/2] drm/ttm: once more fix ttm_bo_bulk_move_lru_tail v2
Date: Thu, 13 Sep 2018 13:22:08 +0200
Message-ID: <20180913112208.1353-2-christian.koenig@amd.com>
References: <20180913112208.1353-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180913112208.1353-1-christian.koenig@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

While cutting the lists we sometimes accidentally added a list_head from
the stack to the LRUs, effectively corrupting the list.

Remove the list cutting and use explicit list manipulation instead.

v2: separate out new list_bulk_move_tail helper

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 46 +++++++++++++++++++-------------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index 138c98902033..26b889f86670 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -247,47 +247,38 @@ void ttm_bo_move_to_lru_tail(struct ttm_buffer_object *bo,
 }
 EXPORT_SYMBOL(ttm_bo_move_to_lru_tail);
 
-static void ttm_bo_bulk_move_helper(struct ttm_lru_bulk_move_pos *pos,
-				    struct list_head *lru, bool is_swap)
-{
-	struct list_head *list;
-	LIST_HEAD(entries);
-	LIST_HEAD(before);
-
-	reservation_object_assert_held(pos->last->resv);
-	list = is_swap ? &pos->last->swap : &pos->last->lru;
-	list_cut_position(&entries, lru, list);
-
-	reservation_object_assert_held(pos->first->resv);
-	list = is_swap ? pos->first->swap.prev : pos->first->lru.prev;
-	list_cut_position(&before, &entries, list);
-
-	list_splice(&before, lru);
-	list_splice_tail(&entries, lru);
-}
-
 void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_move *bulk)
 {
 	unsigned i;
 
 	for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i) {
+		struct ttm_lru_bulk_move_pos *pos = &bulk->tt[i];
 		struct ttm_mem_type_manager *man;
 
-		if (!bulk->tt[i].first)
+		if (!pos->first)
 			continue;
 
-		man = &bulk->tt[i].first->bdev->man[TTM_PL_TT];
-		ttm_bo_bulk_move_helper(&bulk->tt[i], &man->lru[i], false);
+		reservation_object_assert_held(pos->first->resv);
+		reservation_object_assert_held(pos->last->resv);
+
+		man = &pos->first->bdev->man[TTM_PL_TT];
+		list_bulk_move_tail(&man->lru[i], &pos->first->lru,
+				    &pos->last->lru);
 	}
 
 	for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i) {
+		struct ttm_lru_bulk_move_pos *pos = &bulk->vram[i];
 		struct ttm_mem_type_manager *man;
 
-		if (!bulk->vram[i].first)
+		if (!pos->first)
 			continue;
 
-		man = &bulk->vram[i].first->bdev->man[TTM_PL_VRAM];
-		ttm_bo_bulk_move_helper(&bulk->vram[i], &man->lru[i], false);
+		reservation_object_assert_held(pos->first->resv);
+		reservation_object_assert_held(pos->last->resv);
+
+		man = &pos->first->bdev->man[TTM_PL_VRAM];
+		list_bulk_move_tail(&man->lru[i], &pos->first->lru,
+				    &pos->last->lru);
 	}
 
 	for (i = 0; i < TTM_MAX_BO_PRIORITY; ++i) {
@@ -297,8 +288,11 @@ void ttm_bo_bulk_move_lru_tail(struct ttm_lru_bulk_move *bulk)
 		if (!pos->first)
 			continue;
 
+		reservation_object_assert_held(pos->first->resv);
+		reservation_object_assert_held(pos->last->resv);
+
 		lru = &pos->first->bdev->glob->swap_lru[i];
-		ttm_bo_bulk_move_helper(&bulk->swap[i], lru, true);
+		list_bulk_move_tail(lru, &pos->first->swap, &pos->last->swap);
 	}
 }
 EXPORT_SYMBOL(ttm_bo_bulk_move_lru_tail);
-- 
2.14.1

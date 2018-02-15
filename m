From: "=?UTF-8?q?Christian=20K=C3=B6nig?="
        <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH 2/3] drm/ttm: handle already locked BOs during eviction and swapout.
Date: Thu, 15 Feb 2018 15:19:43 +0100
Message-ID: <20180215141944.4332-2-christian.koenig@amd.com>
References: <20180215141944.4332-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180215141944.4332-1-christian.koenig@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

This solves the problem that when we swapout a BO from a domain we
sometimes couldn't make room for it because holding the lock blocks all
other BOs with this reservation object.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo.c | 33 ++++++++++++++++-----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo.c b/drivers/gpu/drm/ttm/ttm_bo.c
index d90b1cf10b27..fba40e22d088 100644
--- a/drivers/gpu/drm/ttm/ttm_bo.c
+++ b/drivers/gpu/drm/ttm/ttm_bo.c
@@ -713,31 +713,30 @@ bool ttm_bo_eviction_valuable(struct ttm_buffer_object *bo,
 EXPORT_SYMBOL(ttm_bo_eviction_valuable);
 
 /**
- * Check the target bo is allowable to be evicted or swapout, including cases:
- *
- * a. if share same reservation object with ctx->resv, have assumption
- * reservation objects should already be locked, so not lock again and
- * return true directly when either the opreation allow_reserved_eviction
- * or the target bo already is in delayed free list;
- *
- * b. Otherwise, trylock it.
+ * Check if the target bo is allowed to be evicted or swapedout.
  */
 static bool ttm_bo_evict_swapout_allowable(struct ttm_buffer_object *bo,
-			struct ttm_operation_ctx *ctx, bool *locked)
+					   struct ttm_operation_ctx *ctx,
+					   bool *locked)
 {
-	bool ret = false;
+	/* First check if we can lock it */
+	*locked = reservation_object_trylock(bo->resv);
+	if (*locked)
+		return true;
 
-	*locked = false;
+	/* Check if it's locked because it is part of the current operation */
 	if (bo->resv == ctx->resv) {
 		reservation_object_assert_held(bo->resv);
-		if (ctx->allow_reserved_eviction || !list_empty(&bo->ddestroy))
-			ret = true;
-	} else {
-		*locked = reservation_object_trylock(bo->resv);
-		ret = *locked;
+		return ctx->allow_reserved_eviction ||
+			!list_empty(&bo->ddestroy);
 	}
 
-	return ret;
+	/* Check if it's locked because it was already evicted */
+	if (ww_mutex_is_owned_by(&bo->resv->lock, current, NULL))
+		return true;
+
+	/* Some other thread is using it, don't touch it */
+	return false;
 }
 
 static int ttm_mem_evict_first(struct ttm_bo_device *bdev,
-- 
2.14.1

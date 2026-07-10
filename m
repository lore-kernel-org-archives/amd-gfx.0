Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB9ADC44501
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jul 2026 19:08:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F10510F940;
	Fri, 10 Jul 2026 19:08:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="p8tK2g9D";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD68A10F940
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 19:08:00 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-493c7902f47so11924475e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jul 2026 12:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783710479; x=1784315279; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=qMLhjI2y/qOK4JKcPoZEVXQM65P9Zzy9jF1/H/uAsSA=;
 b=p8tK2g9DqzoKLONOLRv0sN8RyQqdOXSjtBovchEehwyCpYkG91LnbKouk3sb2IByjZ
 bF7lWWuR+yze3i/qA6n3lID2XitGhAFjI+wfObuhM0olL8B1I144kqsqZK0XXps4gtNp
 yxVOKRtNfEPcPWx1/0WkquEhbahmAbeFAeJ5DrlCoeuwfGiEy5I472cspL1fQxN9ZDx2
 IWBDe1NMs4mIWo98boEaLocLQu1H3ZUKiPfb7kqVxEYEPo6jZpGT16OwDm9w68BlPW3T
 DraVNRAzjLFRG0X53LWL9Gt3FHI5AAOUwfAACypargS+3QF5Y7vlfn18W0Dk9MghaTEd
 3yxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783710479; x=1784315279;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qMLhjI2y/qOK4JKcPoZEVXQM65P9Zzy9jF1/H/uAsSA=;
 b=JOX5hIE39Eo8MtN6317L2VtoMHNyeJoo1RZY9WareSV2F/DlIz2A+Va2jP7gyujhUr
 eZ4SJO8cBsrRxVyPYA95DOlKR7dOthb3tfH8Ou6ApPT2K4Al92XCbYzovjzbZZlkgqWe
 Vntn7lL4YyYWpOg1/3iFnPGyvqf2MiH7HPnvCN6JfaN4b5BtzJTO7vqMvxhNSUl7xr1p
 jURnVK7LJFRalbR3tAa8rPv/XqaT+tOYNnPMnFy2M/wcPGOrdmRtvx6KkhGfeSxtSzNK
 tCzJ6qaqFTqcwDvLyR3M7rckKEbhdgSqU02wfpoIrm989ZZdPumtzqla63oq+rvNMfu2
 E7aA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpPxv9Pq6YiCaE3H78o5s9tjWFEkCHFY7Hdnc9K0wXvsbKAxTBMV0Ycr8yj///L2f5Iy4gvvixx@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx058WnK3AbdLXv0qqS5MLQRIvG34JJxcu9aR577Ny1cv3Hibem
 fGpWRVh51fBQ0eyMNzgad69K8/2oIwnmMXX17GMIUFJyciMdepWz6ahW
X-Gm-Gg: AfdE7cljUolFWcXU+nyjfh2L0U6fiTnWJRBylI/KdXA9BrvFAM2SMy4W9ITsHP/Ej3G
 FV7VgzSkt7VVPpiLZrmCJ+3Acq+L7Jc8Ys6hSKUVJDkfaHfYEAfHQ+tjb4TIG+6Hi7AwsjZvT3L
 0ZqMb4nO762kVZ4vkt0iGO8VY7BdJdEP+M50vFYNR4JCOAFH5FfX8MrGFE1p0xOYsK6nnfoLOxR
 8Q8owWtpZOapkvwAd9zFcGhV3coOVQKadNGSKpQIJ4Umo7Nr4dm9CT9t2fI+jzIOQlUba3+qXf4
 aDGWY3C0Hs1WmoRroZfyomYgkhEjHNAsdZmbfXb+pur70ILWHndS6oTNwyw6+w42/KI9QKpDfkm
 7DC+itrhD7z/nqLMiifDuno5u8/Xn2hkRZwrHTdxz4BrGMGXKz06fiuTeKnTpvZmwbgCsxTFLRF
 nMTEJ+pdXmi8KUfFejQJHA5UGVdw==
X-Received: by 2002:a05:600c:4708:b0:492:67df:3dfa with SMTP id
 5b1f17b1804b1-493f883a7ffmr807375e9.34.1783710478935; 
 Fri, 10 Jul 2026 12:07:58 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:154f:ec00:aa08:de24:db33:4496])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f567eadfsm55000755e9.6.2026.07.10.12.07.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 12:07:58 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: thomas.hellstrom@linux.intel.com, dakr@kernel.org, ecourtney@nvidia.com,
 simona@ffwll.ch, matthew.brost@intel.com, nat@pixelcluster.dev,
 airlied@gmail.com, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Subject: [PATCH 04/12] drm/ttm: Switch LRU cursor to track dma_resv instead of
 buffer objects
Date: Fri, 10 Jul 2026 20:52:44 +0200
Message-ID: <20260710190752.2355-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260710190752.2355-1-christian.koenig@amd.com>
References: <20260710190752.2355-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Reply-To: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Refactor the LRU cursor to hold references to dma_resv directly while
locking it rather than the buffer object.

This avoid the need to grab a reference to the BO and so allows handling
of BOs with zero reference count.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/ttm/ttm_bo_util.c  | 124 +++++++++++++++--------------
 drivers/gpu/drm/ttm/ttm_resource.c |  18 +++++
 include/drm/ttm/ttm_bo.h           |  10 +--
 include/drm/ttm/ttm_resource.h     |   2 +
 4 files changed, 87 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/ttm/ttm_bo_util.c b/drivers/gpu/drm/ttm/ttm_bo_util.c
index 029c218f9fb47..1f7361604b552 100644
--- a/drivers/gpu/drm/ttm/ttm_bo_util.c
+++ b/drivers/gpu/drm/ttm/ttm_bo_util.c
@@ -819,19 +819,17 @@ int ttm_bo_pipeline_gutting(struct ttm_buffer_object *bo)
 }
 
 static bool ttm_lru_walk_trylock(struct ttm_bo_lru_cursor *curs,
-				 struct ttm_buffer_object *bo)
+				 struct dma_resv *resv)
 {
 	struct ttm_operation_ctx *ctx = curs->arg->ctx;
 
-	curs->needs_unlock = false;
-
-	if (dma_resv_trylock(bo->base.resv)) {
-		curs->needs_unlock = true;
+	if (dma_resv_trylock(resv)) {
+		curs->resv = dma_resv_get(resv);
 		return true;
 	}
 
-	if (bo->base.resv == ctx->resv && ctx->allow_res_evict) {
-		dma_resv_assert_held(bo->base.resv);
+	if (resv == ctx->resv && ctx->allow_res_evict) {
+		dma_resv_assert_held(resv);
 		return true;
 	}
 
@@ -839,18 +837,18 @@ static bool ttm_lru_walk_trylock(struct ttm_bo_lru_cursor *curs,
 }
 
 static int ttm_lru_walk_ticketlock(struct ttm_bo_lru_cursor *curs,
-				   struct ttm_buffer_object *bo)
+				   struct dma_resv *resv)
 {
 	struct ttm_lru_walk_arg *arg = curs->arg;
 	int ret;
 
 	if (arg->ctx->interruptible)
-		ret = dma_resv_lock_interruptible(bo->base.resv, arg->ticket);
+		ret = dma_resv_lock_interruptible(resv, arg->ticket);
 	else
-		ret = dma_resv_lock(bo->base.resv, arg->ticket);
+		ret = dma_resv_lock(resv, arg->ticket);
 
 	if (!ret) {
-		curs->needs_unlock = true;
+		curs->resv = dma_resv_get(resv);
 		/*
 		 * Only a single ticketlock per loop. Ticketlocks are prone
 		 * to return -EDEADLK causing the eviction to fail, so
@@ -920,14 +918,16 @@ s64 ttm_lru_walk_for_evict(struct ttm_lru_walk *walk, struct ttm_device *bdev,
 }
 EXPORT_SYMBOL(ttm_lru_walk_for_evict);
 
-static void ttm_bo_lru_cursor_cleanup_bo(struct ttm_bo_lru_cursor *curs)
+static void ttm_bo_lru_cursor_cleanup(struct ttm_bo_lru_cursor *curs)
 {
-	struct ttm_buffer_object *bo = curs->bo;
+	if (curs->resv) {
+		dma_resv_unlock(curs->resv);
+		dma_resv_put(curs->resv);
+		curs->resv = NULL;
+	}
 
-	if (bo) {
-		if (curs->needs_unlock)
-			dma_resv_unlock(bo->base.resv);
-		ttm_bo_put(bo);
+	if (curs->bo) {
+		drm_gem_object_put(&curs->bo->base);
 		curs->bo = NULL;
 	}
 }
@@ -941,7 +941,7 @@ void ttm_bo_lru_cursor_fini(struct ttm_bo_lru_cursor *curs)
 {
 	spinlock_t *lru_lock = &curs->res_curs.man->bdev->lru_lock;
 
-	ttm_bo_lru_cursor_cleanup_bo(curs);
+	ttm_bo_lru_cursor_cleanup(curs);
 	spin_lock(lru_lock);
 	ttm_resource_cursor_fini(&curs->res_curs);
 	spin_unlock(lru_lock);
@@ -972,21 +972,18 @@ ttm_bo_lru_cursor_init(struct ttm_bo_lru_cursor *curs,
 EXPORT_SYMBOL(ttm_bo_lru_cursor_init);
 
 static struct ttm_buffer_object *
-__ttm_bo_lru_cursor_next(struct ttm_bo_lru_cursor *curs)
+__ttm_bo_lru_cursor_iter(struct ttm_bo_lru_cursor *curs, bool first)
 {
 	spinlock_t *lru_lock = &curs->res_curs.man->bdev->lru_lock;
-	struct ttm_resource *res = NULL;
-	struct ttm_buffer_object *bo;
 	struct ttm_lru_walk_arg *arg = curs->arg;
-	bool first = !curs->bo;
-
-	ttm_bo_lru_cursor_cleanup_bo(curs);
+	int ret;
 
-	spin_lock(lru_lock);
 	for (;;) {
-		int mem_type, ret = 0;
-		bool bo_locked = false;
+		struct ttm_resource *res;
+
+		ttm_bo_lru_cursor_cleanup(curs);
 
+		spin_lock(lru_lock);
 		if (first) {
 			res = ttm_resource_manager_first(&curs->res_curs);
 			first = false;
@@ -996,43 +993,48 @@ __ttm_bo_lru_cursor_next(struct ttm_bo_lru_cursor *curs)
 		if (!res)
 			break;
 
-		bo = res->bo;
-		if (ttm_lru_walk_trylock(curs, bo))
-			bo_locked = true;
-		else if (!arg->ticket || arg->ctx->no_wait_gpu || arg->trylock_only)
-			continue;
-
-		if (!ttm_bo_get_unless_zero(bo)) {
-			if (curs->needs_unlock)
-				dma_resv_unlock(bo->base.resv);
-			continue;
+		if (!ttm_lru_walk_trylock(curs, res->bo->base.resv)) {
+			struct dma_resv *resv;
+
+			if (!arg->ticket || arg->ctx->no_wait_gpu ||
+			    arg->trylock_only) {
+				spin_unlock(lru_lock);
+				continue;
+			}
+
+			resv = dma_resv_get(res->bo->base.resv);
+			spin_unlock(lru_lock);
+
+			ret = ttm_lru_walk_ticketlock(curs, resv);
+			if (ret && ret != -EALREADY)
+				return ERR_PTR(ret);
+
+			/*
+			 * We need to double check that we still have the same
+			 * dma_resv object.
+			 */
+			spin_lock(lru_lock);
+			res = ttm_resource_manager_current(&curs->res_curs);
+			if (ret || !res || res->bo->base.resv != resv) {
+				spin_unlock(lru_lock);
+				dma_resv_put(resv);
+				continue;
+			}
+			dma_resv_put(resv);
 		}
-
-		mem_type = res->mem_type;
 		spin_unlock(lru_lock);
-		if (!bo_locked)
-			ret = ttm_lru_walk_ticketlock(curs, bo);
+
+		/* Grab a GEM reference to the BO if it isn't already deleted */
+		if (kref_get_unless_zero(&res->bo->base.refcount))
+			curs->bo = res->bo;
 
 		/*
-		 * Note that in between the release of the lru lock and the
-		 * ticketlock, the bo may have switched resource,
-		 * and also memory type, since the resource may have been
-		 * freed and allocated again with a different memory type.
-		 * In that case, just skip it.
+		 * The BO is now locked so it can't be released any more until
+		 * we drop both the lock and the eventual GEM reference.
 		 */
-		curs->bo = bo;
-		if (!ret && bo->resource && bo->resource->mem_type == mem_type)
-			return bo;
-
-		ttm_bo_lru_cursor_cleanup_bo(curs);
-		if (ret && ret != -EALREADY)
-			return ERR_PTR(ret);
-
-		spin_lock(lru_lock);
+		return res->bo;
 	}
-
-	spin_unlock(lru_lock);
-	return res ? bo : NULL;
+	return NULL;
 }
 
 /**
@@ -1046,7 +1048,7 @@ __ttm_bo_lru_cursor_next(struct ttm_bo_lru_cursor *curs)
  */
 struct ttm_buffer_object *ttm_bo_lru_cursor_next(struct ttm_bo_lru_cursor *curs)
 {
-	return __ttm_bo_lru_cursor_next(curs);
+	return __ttm_bo_lru_cursor_iter(curs, false);
 }
 EXPORT_SYMBOL(ttm_bo_lru_cursor_next);
 
@@ -1060,8 +1062,8 @@ EXPORT_SYMBOL(ttm_bo_lru_cursor_next);
  */
 struct ttm_buffer_object *ttm_bo_lru_cursor_first(struct ttm_bo_lru_cursor *curs)
 {
-	ttm_bo_lru_cursor_cleanup_bo(curs);
-	return __ttm_bo_lru_cursor_next(curs);
+	ttm_bo_lru_cursor_cleanup(curs);
+	return __ttm_bo_lru_cursor_iter(curs, true);
 }
 EXPORT_SYMBOL(ttm_bo_lru_cursor_first);
 
diff --git a/drivers/gpu/drm/ttm/ttm_resource.c b/drivers/gpu/drm/ttm/ttm_resource.c
index 154d6739256f8..4a765b25472c3 100644
--- a/drivers/gpu/drm/ttm/ttm_resource.c
+++ b/drivers/gpu/drm/ttm/ttm_resource.c
@@ -714,6 +714,24 @@ ttm_resource_manager_next(struct ttm_resource_cursor *cursor)
 	return NULL;
 }
 
+/* TODO */
+struct ttm_resource *
+ttm_resource_manager_current(struct ttm_resource_cursor *cursor)
+{
+	struct ttm_resource_manager *man = cursor->man;
+	struct ttm_lru_item *lru;
+
+	lockdep_assert_held(&man->bdev->lru_lock);
+
+	lru = &cursor->hitch;
+	list_for_each_entry_continue_reverse(lru, &man->lru[cursor->priority],
+					     link) {
+		if (ttm_lru_item_is_res(lru))
+			return ttm_lru_item_to_res(lru);
+	}
+	return NULL;
+}
+
 /**
  * ttm_lru_first_res_or_null() - Return the first resource on an lru list
  * @head: The list head of the lru list.
diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
index 8310bc3d55f90..30e835414e721 100644
--- a/include/drm/ttm/ttm_bo.h
+++ b/include/drm/ttm/ttm_bo.h
@@ -488,15 +488,13 @@ struct ttm_bo_lru_cursor {
 	/** @res_curs: Embedded struct ttm_resource_cursor. */
 	struct ttm_resource_cursor res_curs;
 	/**
-	 * @bo: Buffer object pointer if a buffer object is refcounted,
-	 * NULL otherwise.
+	 * @resv: reference to the locked dma_resv
 	 */
-	struct ttm_buffer_object *bo;
+	struct dma_resv *resv;
 	/**
-	 * @needs_unlock: Valid iff @bo != NULL. The bo resv needs
-	 * unlock before the next iteration or after loop exit.
+	 * @bo: TTM BO with GEM reference, NULL for deleted BOs
 	 */
-	bool needs_unlock;
+	struct ttm_buffer_object *bo;
 	/** @arg: Pointer to common BO LRU walk arguments. */
 	struct ttm_lru_walk_arg *arg;
 };
diff --git a/include/drm/ttm/ttm_resource.h b/include/drm/ttm/ttm_resource.h
index a5d386583fb6e..e8e9c8b81ce4b 100644
--- a/include/drm/ttm/ttm_resource.h
+++ b/include/drm/ttm/ttm_resource.h
@@ -488,6 +488,8 @@ struct ttm_resource *
 ttm_resource_manager_first(struct ttm_resource_cursor *cursor);
 struct ttm_resource *
 ttm_resource_manager_next(struct ttm_resource_cursor *cursor);
+struct ttm_resource *
+ttm_resource_manager_current(struct ttm_resource_cursor *cursor);
 
 struct ttm_resource *
 ttm_lru_first_res_or_null(struct list_head *head);
-- 
2.43.0


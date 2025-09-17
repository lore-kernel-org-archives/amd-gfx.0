Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E869FCAC59A
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Sep 2025 17:22:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9509910E03F;
	Wed, 17 Sep 2025 17:22:11 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CF1910E03F
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Sep 2025 17:22:09 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 58HHM3Pj3874865; Wed, 17 Sep 2025 22:52:03 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 58HHM37A3874864;
 Wed, 17 Sep 2025 22:52:03 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH] drm/amdgpu: use hmm_pfns instead of array of pages
Date: Wed, 17 Sep 2025 22:52:01 +0530
Message-Id: <20250917172201.3874839-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

we dont need to allocate local array of pages to hold
the pages returned by the hmm, instead we could use
the hmm_range structure itself to get to hmm_pfn
and get the required pages directly.

This saved alloc/free a lot of memory without
any impact on performance.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 10 +++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h   |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        | 30 ++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  5 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c       | 10 +------
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       |  8 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  5 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  2 +-
 9 files changed, 25 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index c3b34a410375..7c54fe6b0f5d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1089,7 +1089,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
 		return 0;
 	}
 
-	ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages, &range);
+	ret = amdgpu_ttm_tt_get_user_pages(bo, &range);
 	if (ret) {
 		if (ret == -EAGAIN)
 			pr_debug("Failed to get user pages, try again\n");
@@ -1103,6 +1103,9 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
 		pr_err("%s: Failed to reserve BO\n", __func__);
 		goto release_out;
 	}
+
+	amdgpu_ttm_tt_set_user_pages(bo->tbo.ttm, range);
+
 	amdgpu_bo_placement_from_domain(bo, mem->domain);
 	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 	if (ret)
@@ -2565,8 +2568,7 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
 		}
 
 		/* Get updated user pages */
-		ret = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages,
-						   &mem->range);
+		ret = amdgpu_ttm_tt_get_user_pages(bo, &mem->range);
 		if (ret) {
 			pr_debug("Failed %d to get user pages\n", ret);
 
@@ -2595,6 +2597,8 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
 			ret = 0;
 		}
 
+		amdgpu_ttm_tt_set_user_pages(bo->tbo.ttm, mem->range);
+
 		mutex_lock(&process_info->notifier_lock);
 
 		/* Mark the BO as valid unless it was invalidated
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
index 555cd6d877c3..a716c9886c74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_bo_list.h
@@ -38,7 +38,6 @@ struct amdgpu_bo_list_entry {
 	struct amdgpu_bo		*bo;
 	struct amdgpu_bo_va		*bo_va;
 	uint32_t			priority;
-	struct page			**user_pages;
 	struct hmm_range		*range;
 	bool				user_invalidated;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index defb511acc5a..744e6ff69814 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -29,6 +29,7 @@
 #include <linux/pagemap.h>
 #include <linux/sync_file.h>
 #include <linux/dma-buf.h>
+#include <linux/hmm.h>
 
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_syncobj.h>
@@ -885,24 +886,12 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		struct amdgpu_bo *bo = e->bo;
 		int i;
 
-		e->user_pages = kvcalloc(bo->tbo.ttm->num_pages,
-					 sizeof(struct page *),
-					 GFP_KERNEL);
-		if (!e->user_pages) {
-			drm_err(adev_to_drm(p->adev), "kvmalloc_array failure\n");
-			r = -ENOMEM;
-			goto out_free_user_pages;
-		}
-
-		r = amdgpu_ttm_tt_get_user_pages(bo, e->user_pages, &e->range);
-		if (r) {
-			kvfree(e->user_pages);
-			e->user_pages = NULL;
+		r = amdgpu_ttm_tt_get_user_pages(bo, &e->range);
+		if (r)
 			goto out_free_user_pages;
-		}
 
 		for (i = 0; i < bo->tbo.ttm->num_pages; i++) {
-			if (bo->tbo.ttm->pages[i] != e->user_pages[i]) {
+			if (bo->tbo.ttm->pages[i] != hmm_pfn_to_page(e->range->hmm_pfns[i])) {
 				userpage_invalidated = true;
 				break;
 			}
@@ -946,7 +935,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		}
 
 		if (amdgpu_ttm_tt_is_userptr(e->bo->tbo.ttm) &&
-		    e->user_invalidated && e->user_pages) {
+		    e->user_invalidated) {
 			amdgpu_bo_placement_from_domain(e->bo,
 							AMDGPU_GEM_DOMAIN_CPU);
 			r = ttm_bo_validate(&e->bo->tbo, &e->bo->placement,
@@ -955,11 +944,8 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 				goto out_free_user_pages;
 
 			amdgpu_ttm_tt_set_user_pages(e->bo->tbo.ttm,
-						     e->user_pages);
+						     e->range);
 		}
-
-		kvfree(e->user_pages);
-		e->user_pages = NULL;
 	}
 
 	amdgpu_cs_get_threshold_for_moves(p->adev, &p->bytes_moved_threshold,
@@ -1001,11 +987,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
 		struct amdgpu_bo *bo = e->bo;
 
-		if (!e->user_pages)
-			continue;
 		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, e->range);
-		kvfree(e->user_pages);
-		e->user_pages = NULL;
 		e->range = NULL;
 	}
 	mutex_unlock(&p->bo_list->bo_list_mutex);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index a8fa09184459..8524aa55e057 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -571,8 +571,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 		goto release_object;
 
 	if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
-		r = amdgpu_ttm_tt_get_user_pages(bo, bo->tbo.ttm->pages,
-						 &range);
+		r = amdgpu_ttm_tt_get_user_pages(bo, &range);
 		if (r)
 			goto release_object;
 
@@ -580,6 +579,8 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 		if (r)
 			goto user_pages_done;
 
+		amdgpu_ttm_tt_set_user_pages(bo->tbo.ttm, range);
+
 		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_GTT);
 		r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 		amdgpu_bo_unreserve(bo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index e36fede7f74c..4441572d6ad1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -167,7 +167,7 @@ void amdgpu_hmm_unregister(struct amdgpu_bo *bo)
 
 int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 			       uint64_t start, uint64_t npages, bool readonly,
-			       void *owner, struct page **pages,
+			       void *owner,
 			       struct hmm_range **phmm_range)
 {
 	struct hmm_range *hmm_range;
@@ -222,14 +222,6 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 	hmm_range->start = start;
 	hmm_range->hmm_pfns = pfns;
 
-	/*
-	 * Due to default_flags, all pages are HMM_PFN_VALID or
-	 * hmm_range_fault() fails. FIXME: The pages cannot be touched outside
-	 * the notifier_lock, and mmu_interval_read_retry() must be done first.
-	 */
-	for (i = 0; pages && i < npages; i++)
-		pages[i] = hmm_pfn_to_page(pfns[i]);
-
 	*phmm_range = hmm_range;
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
index e2edcd010ccc..953e1d06de20 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
@@ -33,7 +33,7 @@
 
 int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 			       uint64_t start, uint64_t npages, bool readonly,
-			       void *owner, struct page **pages,
+			       void *owner,
 			       struct hmm_range **phmm_range);
 bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 4e2486dbc0a6..280400b13c54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -707,7 +707,7 @@ struct amdgpu_ttm_tt {
  * Calling function must call amdgpu_ttm_tt_userptr_range_done() once and only
  * once afterwards to stop HMM tracking
  */
-int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages,
+int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
 				 struct hmm_range **range)
 {
 	struct ttm_tt *ttm = bo->tbo.ttm;
@@ -744,7 +744,7 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages,
 
 	readonly = amdgpu_ttm_tt_is_readonly(ttm);
 	r = amdgpu_hmm_range_get_pages(&bo->notifier, start, ttm->num_pages,
-				       readonly, NULL, pages, range);
+				       readonly, NULL, range);
 out_unlock:
 	mmap_read_unlock(mm);
 	if (r)
@@ -796,12 +796,12 @@ bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
  * that backs user memory and will ultimately be mapped into the device
  * address space.
  */
-void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct page **pages)
+void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct hmm_range *range)
 {
 	unsigned long i;
 
 	for (i = 0; i < ttm->num_pages; ++i)
-		ttm->pages[i] = pages ? pages[i] : NULL;
+		ttm->pages[i] = hmm_pfn_to_page(range->hmm_pfns[i]);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index bb17987f0447..6ac94469ed40 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -190,7 +190,7 @@ void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
 uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
 
 #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
-int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages,
+int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
 				 struct hmm_range **range);
 void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm,
 				      struct hmm_range *range);
@@ -198,7 +198,6 @@ bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
 				       struct hmm_range *range);
 #else
 static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
-					       struct page **pages,
 					       struct hmm_range **range)
 {
 	return -EPERM;
@@ -214,7 +213,7 @@ static inline bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
 }
 #endif
 
-void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct page **pages);
+void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct hmm_range *range);
 int amdgpu_ttm_tt_get_userptr(const struct ttm_buffer_object *tbo,
 			      uint64_t *user_addr);
 int amdgpu_ttm_tt_set_userptr(struct ttm_buffer_object *bo,
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 68ba239b2e5d..273f42e3afdd 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1738,7 +1738,7 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
 			WRITE_ONCE(p->svms.faulting_task, current);
 			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
-						       readonly, owner, NULL,
+						       readonly, owner,
 						       &hmm_range);
 			WRITE_ONCE(p->svms.faulting_task, NULL);
 			if (r)
-- 
2.34.1


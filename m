Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A801CCCA470
	for <amd-gfx@archiver.kernel.org>; Tue, 30 Sep 2025 13:24:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47CA110E5E3;
	Tue, 30 Sep 2025 13:24:13 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C1A810E5CF
 for <amd-gfx@lists.freedesktop.org>; Tue, 30 Sep 2025 13:24:12 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 58UDO6eX1736923; Tue, 30 Sep 2025 18:54:06 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 58UDO69D1736916;
 Tue, 30 Sep 2025 18:54:06 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
Subject: [Patch v2] drm/amdgpu: clean up amdgpu hmm range functions
Date: Tue, 30 Sep 2025 18:54:05 +0530
Message-Id: <20250930132405.1736897-1-sunil.khatri@amd.com>
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

Clean up the amdgpu hmm range functions for clearer
definition of each.

a. Split amdgpu_ttm_tt_get_user_pages_done into two:
   1. amdgpu_hmm_range_valid: To check if the user pages
      are valid and update seq num
   2. amdgpu_hmm_range_free: Clean up the hmm range
      and pfn memory.

b. amdgpu_ttm_tt_get_user_pages_done and
   amdgpu_ttm_tt_discard_user_pages are similar function so remove
   discard and directly use amdgpu_hmm_range_free to clean up the
   hmm range and pfn memory.

Suggested-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 18 +++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        | 11 +++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  7 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c       | 23 +++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h       |  5 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 32 -------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       | 13 --------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  9 ++++--
 8 files changed, 44 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 4babd37712fb..ae127c79b192 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1089,7 +1089,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
 		return 0;
 	}
 
-	range = kzalloc(sizeof(*range), GFP_KERNEL);
+	range = amdgpu_hmm_range_alloc();
 	if (unlikely(!range)) {
 		ret = -ENOMEM;
 		goto unregister_out;
@@ -1097,7 +1097,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
 
 	ret = amdgpu_ttm_tt_get_user_pages(bo, range);
 	if (ret) {
-		kfree(range);
+		amdgpu_hmm_range_free(range);
 		if (ret == -EAGAIN)
 			pr_debug("Failed to get user pages, try again\n");
 		else
@@ -1120,7 +1120,7 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
 	amdgpu_bo_unreserve(bo);
 
 release_out:
-	amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, range);
+	amdgpu_hmm_range_free(range);
 unregister_out:
 	if (ret)
 		amdgpu_hmm_unregister(bo);
@@ -1923,7 +1923,7 @@ int amdgpu_amdkfd_gpuvm_free_memory_of_gpu(
 	if (amdgpu_ttm_tt_get_usermm(mem->bo->tbo.ttm)) {
 		amdgpu_hmm_unregister(mem->bo);
 		mutex_lock(&process_info->notifier_lock);
-		amdgpu_ttm_tt_discard_user_pages(mem->bo->tbo.ttm, mem->range);
+		amdgpu_hmm_range_free(mem->range);
 		mutex_unlock(&process_info->notifier_lock);
 	}
 
@@ -2550,7 +2550,7 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
 
 		bo = mem->bo;
 
-		amdgpu_ttm_tt_discard_user_pages(bo->tbo.ttm, mem->range);
+		amdgpu_hmm_range_free(mem->range);
 		mem->range = NULL;
 
 		/* BO reservations and getting user pages (hmm_range_fault)
@@ -2574,13 +2574,13 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
 			}
 		}
 
-		mem->range = kzalloc(sizeof(*mem->range), GFP_KERNEL);
+		mem->range = amdgpu_hmm_range_alloc();
 		if (unlikely(!mem->range))
 			return -ENOMEM;
 		/* Get updated user pages */
 		ret = amdgpu_ttm_tt_get_user_pages(bo, mem->range);
 		if (ret) {
-			kfree(mem->range);
+			amdgpu_hmm_range_free(mem->range);
 			mem->range = NULL;
 			pr_debug("Failed %d to get user pages\n", ret);
 
@@ -2749,8 +2749,8 @@ static int confirm_valid_user_pages_locked(struct amdkfd_process_info *process_i
 			continue;
 
 		/* Only check mem with hmm range associated */
-		valid = amdgpu_ttm_tt_get_user_pages_done(
-					mem->bo->tbo.ttm, mem->range);
+		valid = amdgpu_hmm_range_valid(mem->range);
+		amdgpu_hmm_range_free(mem->range);
 
 		mem->range = NULL;
 		if (!valid) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index b75b53f21cbb..087e5b5497e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -41,6 +41,7 @@
 #include "amdgpu_gmc.h"
 #include "amdgpu_gem.h"
 #include "amdgpu_ras.h"
+#include "amdgpu_hmm.h"
 
 static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
 				 struct amdgpu_device *adev,
@@ -885,7 +886,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		bool userpage_invalidated = false;
 		struct amdgpu_bo *bo = e->bo;
 
-		e->range = kzalloc(sizeof(*e->range), GFP_KERNEL);
+		e->range = amdgpu_hmm_range_alloc();
 		if (unlikely(!e->range))
 			return -ENOMEM;
 
@@ -988,9 +989,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 
 out_free_user_pages:
 	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
-		struct amdgpu_bo *bo = e->bo;
-
-		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, e->range);
+		amdgpu_hmm_range_free(e->range);
 		e->range = NULL;
 	}
 	mutex_unlock(&p->bo_list->bo_list_mutex);
@@ -1321,8 +1320,8 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	 */
 	r = 0;
 	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
-		r |= !amdgpu_ttm_tt_get_user_pages_done(e->bo->tbo.ttm,
-							e->range);
+		r |= !amdgpu_hmm_range_valid(e->range);
+		amdgpu_hmm_range_free(e->range);
 		e->range = NULL;
 	}
 	if (r) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 12f0597a3659..82ddc8c22b64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -571,12 +571,12 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 		goto release_object;
 
 	if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
-		range = kzalloc(sizeof(*range), GFP_KERNEL);
+		range = amdgpu_hmm_range_alloc();
 		if (unlikely(!range))
 			return -ENOMEM;
 		r = amdgpu_ttm_tt_get_user_pages(bo, range);
 		if (r) {
-			kfree(range);
+			amdgpu_hmm_range_free(range);
 			goto release_object;
 		}
 		r = amdgpu_bo_reserve(bo, true);
@@ -600,8 +600,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 
 user_pages_done:
 	if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE)
-		amdgpu_ttm_tt_get_user_pages_done(bo->tbo.ttm, range);
-
+		amdgpu_hmm_range_free(range);
 release_object:
 	drm_gem_object_put(gobj);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index 53d405a92a14..b582fd217bd0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -226,14 +226,25 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 	return r;
 }
 
-bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range)
+bool amdgpu_hmm_range_valid(struct hmm_range *hmm_range)
 {
-	bool r;
+	if (!hmm_range)
+		return false;
+
+	return !mmu_interval_read_retry(hmm_range->notifier,
+					hmm_range->notifier_seq);
+}
+
+struct hmm_range *amdgpu_hmm_range_alloc(void)
+{
+	return kzalloc(sizeof(struct hmm_range), GFP_KERNEL);
+}
+
+void amdgpu_hmm_range_free(struct hmm_range *hmm_range)
+{
+	if (!hmm_range)
+		return;
 
-	r = mmu_interval_read_retry(hmm_range->notifier,
-				    hmm_range->notifier_seq);
 	kvfree(hmm_range->hmm_pfns);
 	kfree(hmm_range);
-
-	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
index c54e3c64251a..368dd58d13ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
@@ -35,7 +35,10 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 			       uint64_t start, uint64_t npages, bool readonly,
 			       void *owner,
 			       struct hmm_range *hmm_range);
-bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
+
+bool amdgpu_hmm_range_valid(struct hmm_range *hmm_range);
+struct hmm_range *amdgpu_hmm_range_alloc(void);
+void amdgpu_hmm_range_free(struct hmm_range *hmm_range);
 
 #if defined(CONFIG_HMM_MIRROR)
 int amdgpu_hmm_register(struct amdgpu_bo *bo, unsigned long addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 046ff2346dab..96bd0185f936 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -753,38 +753,6 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
 	return r;
 }
 
-/* amdgpu_ttm_tt_discard_user_pages - Discard range and pfn array allocations
- */
-void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm,
-				      struct hmm_range *range)
-{
-	struct amdgpu_ttm_tt *gtt = (void *)ttm;
-
-	if (gtt && gtt->userptr && range)
-		amdgpu_hmm_range_get_pages_done(range);
-}
-
-/*
- * amdgpu_ttm_tt_get_user_pages_done - stop HMM track the CPU page table change
- * Check if the pages backing this ttm range have been invalidated
- *
- * Returns: true if pages are still valid
- */
-bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
-				       struct hmm_range *range)
-{
-	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
-
-	if (!gtt || !gtt->userptr || !range)
-		return false;
-
-	DRM_DEBUG_DRIVER("user_pages_done 0x%llx pages 0x%x\n",
-		gtt->userptr, ttm->num_pages);
-
-	WARN_ONCE(!range->hmm_pfns, "No user pages to check\n");
-
-	return !amdgpu_hmm_range_get_pages_done(range);
-}
 #endif
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index a8379b925878..99c46821b961 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -192,25 +192,12 @@ uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
 #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
 int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
 				 struct hmm_range *range);
-void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm,
-				      struct hmm_range *range);
-bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
-				       struct hmm_range *range);
 #else
 static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
 					       struct hmm_range *range)
 {
 	return -EPERM;
 }
-static inline void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm,
-						    struct hmm_range *range)
-{
-}
-static inline bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
-						     struct hmm_range *range)
-{
-	return false;
-}
 #endif
 
 void amdgpu_ttm_tt_set_user_pages(struct ttm_tt *ttm, struct hmm_range *range);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 9f0f14ea93e5..53e443a243ee 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1737,13 +1737,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			}
 
 			WRITE_ONCE(p->svms.faulting_task, current);
-			hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
+			hmm_range = amdgpu_hmm_range_alloc();
 			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
 						       readonly, owner,
 						       hmm_range);
 			WRITE_ONCE(p->svms.faulting_task, NULL);
 			if (r) {
-				kfree(hmm_range);
+				amdgpu_hmm_range_free(hmm_range);
 				pr_debug("failed %d to get svm range pages\n", r);
 			}
 		} else {
@@ -1764,10 +1764,13 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 		 * Overrride return value to TRY AGAIN only if prior returns
 		 * were successful
 		 */
-		if (hmm_range && amdgpu_hmm_range_get_pages_done(hmm_range) && !r) {
+		if (hmm_range && !amdgpu_hmm_range_valid(hmm_range) && !r) {
 			pr_debug("hmm update the range, need validate again\n");
 			r = -EAGAIN;
 		}
+		/* Free the hmm range */
+		amdgpu_hmm_range_free(hmm_range);
+
 
 		if (!r && !list_empty(&prange->child_list)) {
 			pr_debug("range split by unmap in parallel, validate again\n");
-- 
2.34.1


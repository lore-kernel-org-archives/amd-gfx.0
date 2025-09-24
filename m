Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 633FECAC5A5
	for <amd-gfx@archiver.kernel.org>; Wed, 24 Sep 2025 10:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09E3510E6D8;
	Wed, 24 Sep 2025 10:02:05 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 471B010E6D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 Sep 2025 10:02:03 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 58OA1v413746272; Wed, 24 Sep 2025 15:31:57 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 58OA1uLq3746250;
 Wed, 24 Sep 2025 15:31:56 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Felix Kuehling <felix.kuehling@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Cc: Sunil Khatri <sunil.khatri@amd.com>
Subject: [Patch v2 1/2] drm/amdgpu: use user provided hmm_range buffer in
 amdgpu_ttm_tt_get_user_pages
Date: Wed, 24 Sep 2025 15:31:55 +0530
Message-Id: <20250924100156.3746229-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
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

update the amdgpu_ttm_tt_get_user_pages and all dependent function
along with it callers to use a user allocated hmm_range buffer instead
hmm layer allocates the buffer.

This is a need to get hmm_range pointers easily accessible
without accessing the bo and that is a requirement for the
userqueue to lock the userptrs effectively.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 16 ++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c           |  6 +++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c          | 10 +++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c          | 11 +----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h          |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c          |  8 +++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h          |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c             |  7 +++++--
 8 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 7c54fe6b0f5d..4babd37712fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1089,8 +1089,15 @@ static int init_user_pages(struct kgd_mem *mem, uint64_t user_addr,
 		return 0;
 	}
 
-	ret = amdgpu_ttm_tt_get_user_pages(bo, &range);
+	range = kzalloc(sizeof(*range), GFP_KERNEL);
+	if (unlikely(!range)) {
+		ret = -ENOMEM;
+		goto unregister_out;
+	}
+
+	ret = amdgpu_ttm_tt_get_user_pages(bo, range);
 	if (ret) {
+		kfree(range);
 		if (ret == -EAGAIN)
 			pr_debug("Failed to get user pages, try again\n");
 		else
@@ -2567,9 +2574,14 @@ static int update_invalid_user_pages(struct amdkfd_process_info *process_info,
 			}
 		}
 
+		mem->range = kzalloc(sizeof(*mem->range), GFP_KERNEL);
+		if (unlikely(!mem->range))
+			return -ENOMEM;
 		/* Get updated user pages */
-		ret = amdgpu_ttm_tt_get_user_pages(bo, &mem->range);
+		ret = amdgpu_ttm_tt_get_user_pages(bo, mem->range);
 		if (ret) {
+			kfree(mem->range);
+			mem->range = NULL;
 			pr_debug("Failed %d to get user pages\n", ret);
 
 			/* Return -EFAULT bad address error as success. It will
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 744e6ff69814..31eea1c7dac3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -884,9 +884,13 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	amdgpu_bo_list_for_each_userptr_entry(e, p->bo_list) {
 		bool userpage_invalidated = false;
 		struct amdgpu_bo *bo = e->bo;
+		e->range = kzalloc(sizeof(*e->range), GFP_KERNEL);
+		if (unlikely(!e->range))
+			return -ENOMEM;
+
 		int i;
 
-		r = amdgpu_ttm_tt_get_user_pages(bo, &e->range);
+		r = amdgpu_ttm_tt_get_user_pages(bo, e->range);
 		if (r)
 			goto out_free_user_pages;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 8524aa55e057..12f0597a3659 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -571,10 +571,14 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
 		goto release_object;
 
 	if (args->flags & AMDGPU_GEM_USERPTR_VALIDATE) {
-		r = amdgpu_ttm_tt_get_user_pages(bo, &range);
-		if (r)
+		range = kzalloc(sizeof(*range), GFP_KERNEL);
+		if (unlikely(!range))
+			return -ENOMEM;
+		r = amdgpu_ttm_tt_get_user_pages(bo, range);
+		if (r) {
+			kfree(range);
 			goto release_object;
-
+		}
 		r = amdgpu_bo_reserve(bo, true);
 		if (r)
 			goto user_pages_done;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
index 2c6a6b858112..53d405a92a14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.c
@@ -168,18 +168,13 @@ void amdgpu_hmm_unregister(struct amdgpu_bo *bo)
 int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 			       uint64_t start, uint64_t npages, bool readonly,
 			       void *owner,
-			       struct hmm_range **phmm_range)
+			       struct hmm_range *hmm_range)
 {
-	struct hmm_range *hmm_range;
 	unsigned long end;
 	unsigned long timeout;
 	unsigned long *pfns;
 	int r = 0;
 
-	hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
-	if (unlikely(!hmm_range))
-		return -ENOMEM;
-
 	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
 	if (unlikely(!pfns)) {
 		r = -ENOMEM;
@@ -221,15 +216,11 @@ int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 	hmm_range->start = start;
 	hmm_range->hmm_pfns = pfns;
 
-	*phmm_range = hmm_range;
-
 	return 0;
 
 out_free_pfns:
 	kvfree(pfns);
 out_free_range:
-	kfree(hmm_range);
-
 	if (r == -EBUSY)
 		r = -EAGAIN;
 	return r;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
index 953e1d06de20..c54e3c64251a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_hmm.h
@@ -34,7 +34,7 @@
 int amdgpu_hmm_range_get_pages(struct mmu_interval_notifier *notifier,
 			       uint64_t start, uint64_t npages, bool readonly,
 			       void *owner,
-			       struct hmm_range **phmm_range);
+			       struct hmm_range *hmm_range);
 bool amdgpu_hmm_range_get_pages_done(struct hmm_range *hmm_range);
 
 #if defined(CONFIG_HMM_MIRROR)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 901e0c39a594..046ff2346dab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -705,10 +705,11 @@ struct amdgpu_ttm_tt {
  * memory and start HMM tracking CPU page table update
  *
  * Calling function must call amdgpu_ttm_tt_userptr_range_done() once and only
- * once afterwards to stop HMM tracking
+ * once afterwards to stop HMM tracking. Its the caller responsibility to ensure
+ * that range is a valid memory and it is freed too.
  */
 int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
-				 struct hmm_range **range)
+				 struct hmm_range *range)
 {
 	struct ttm_tt *ttm = bo->tbo.ttm;
 	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(ttm);
@@ -718,9 +719,6 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
 	bool readonly;
 	int r = 0;
 
-	/* Make sure get_user_pages_done() can cleanup gracefully */
-	*range = NULL;
-
 	mm = bo->notifier.mm;
 	if (unlikely(!mm)) {
 		DRM_DEBUG_DRIVER("BO is not registered?\n");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 6ac94469ed40..a8379b925878 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -191,14 +191,14 @@ uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
 
 #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
 int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
-				 struct hmm_range **range);
+				 struct hmm_range *range);
 void amdgpu_ttm_tt_discard_user_pages(struct ttm_tt *ttm,
 				      struct hmm_range *range);
 bool amdgpu_ttm_tt_get_user_pages_done(struct ttm_tt *ttm,
 				       struct hmm_range *range);
 #else
 static inline int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
-					       struct hmm_range **range)
+					       struct hmm_range *range)
 {
 	return -EPERM;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 273f42e3afdd..9f0f14ea93e5 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1737,12 +1737,15 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			}
 
 			WRITE_ONCE(p->svms.faulting_task, current);
+			hmm_range = kzalloc(sizeof(*hmm_range), GFP_KERNEL);
 			r = amdgpu_hmm_range_get_pages(&prange->notifier, addr, npages,
 						       readonly, owner,
-						       &hmm_range);
+						       hmm_range);
 			WRITE_ONCE(p->svms.faulting_task, NULL);
-			if (r)
+			if (r) {
+				kfree(hmm_range);
 				pr_debug("failed %d to get svm range pages\n", r);
+			}
 		} else {
 			r = -EFAULT;
 		}
-- 
2.34.1


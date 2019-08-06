From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 06/15] mm: remove superflous arguments from hmm_range_register
Date: Tue,  6 Aug 2019 19:05:44 +0300
Message-ID: <20190806160554.14046-7-hch@lst.de>
References: <20190806160554.14046-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806160554.14046-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

The start, end and page_shift values are all saved in the range
structure, so we might as well use that for argument passing.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 Documentation/vm/hmm.rst                |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  7 +++++--
 drivers/gpu/drm/nouveau/nouveau_svm.c   |  5 ++---
 include/linux/hmm.h                     |  6 +-----
 mm/hmm.c                                | 20 +++++---------------
 5 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/Documentation/vm/hmm.rst b/Documentation/vm/hmm.rst
index ddcb5ca8b296..e63c11f7e0e0 100644
--- a/Documentation/vm/hmm.rst
+++ b/Documentation/vm/hmm.rst
@@ -222,7 +222,7 @@ The usage pattern is::
       range.flags = ...;
       range.values = ...;
       range.pfn_shift = ...;
-      hmm_range_register(&range);
+      hmm_range_register(&range, mirror);
 
       /*
        * Just wait for range to be valid, safe to ignore return value as we
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index f0821638bbc6..71d6e7087b0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -818,8 +818,11 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 				0 : range->flags[HMM_PFN_WRITE];
 	range->pfn_flags_mask = 0;
 	range->pfns = pfns;
-	hmm_range_register(range, mirror, start,
-			   start + ttm->num_pages * PAGE_SIZE, PAGE_SHIFT);
+	range->page_shift = PAGE_SHIFT;
+	range->start = start;
+	range->end = start + ttm->num_pages * PAGE_SIZE;
+
+	hmm_range_register(range, mirror);
 
 	/*
 	 * Just wait for range to be valid, safe to ignore return value as we
diff --git a/drivers/gpu/drm/nouveau/nouveau_svm.c b/drivers/gpu/drm/nouveau/nouveau_svm.c
index 98072fd48cf7..41fad4719ac6 100644
--- a/drivers/gpu/drm/nouveau/nouveau_svm.c
+++ b/drivers/gpu/drm/nouveau/nouveau_svm.c
@@ -492,9 +492,7 @@ nouveau_range_fault(struct nouveau_svmm *svmm, struct hmm_range *range)
 	range->default_flags = 0;
 	range->pfn_flags_mask = -1UL;
 
-	ret = hmm_range_register(range, &svmm->mirror,
-				 range->start, range->end,
-				 PAGE_SHIFT);
+	ret = hmm_range_register(range, &svmm->mirror);
 	if (ret) {
 		up_read(&svmm->mm->mmap_sem);
 		return (int)ret;
@@ -682,6 +680,7 @@ nouveau_svm_fault(struct nvif_notify *notify)
 			 args.i.p.addr + args.i.p.size, fn - fi);
 
 		/* Have HMM fault pages within the fault window to the GPU. */
+		range.page_shift = PAGE_SHIFT;
 		range.start = args.i.p.addr;
 		range.end = args.i.p.addr + args.i.p.size;
 		range.pfns = args.phys;
diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 59be0aa2476d..c5b51376b453 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -400,11 +400,7 @@ void hmm_mirror_unregister(struct hmm_mirror *mirror);
 /*
  * Please see Documentation/vm/hmm.rst for how to use the range API.
  */
-int hmm_range_register(struct hmm_range *range,
-		       struct hmm_mirror *mirror,
-		       unsigned long start,
-		       unsigned long end,
-		       unsigned page_shift);
+int hmm_range_register(struct hmm_range *range, struct hmm_mirror *mirror);
 void hmm_range_unregister(struct hmm_range *range);
 
 /*
diff --git a/mm/hmm.c b/mm/hmm.c
index 3a3852660757..926735a3aef9 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -843,35 +843,25 @@ static void hmm_pfns_clear(struct hmm_range *range,
  * hmm_range_register() - start tracking change to CPU page table over a range
  * @range: range
  * @mm: the mm struct for the range of virtual address
- * @start: start virtual address (inclusive)
- * @end: end virtual address (exclusive)
- * @page_shift: expect page shift for the range
+ *
  * Return: 0 on success, -EFAULT if the address space is no longer valid
  *
  * Track updates to the CPU page table see include/linux/hmm.h
  */
-int hmm_range_register(struct hmm_range *range,
-		       struct hmm_mirror *mirror,
-		       unsigned long start,
-		       unsigned long end,
-		       unsigned page_shift)
+int hmm_range_register(struct hmm_range *range, struct hmm_mirror *mirror)
 {
-	unsigned long mask = ((1UL << page_shift) - 1UL);
+	unsigned long mask = ((1UL << range->page_shift) - 1UL);
 	struct hmm *hmm = mirror->hmm;
 	unsigned long flags;
 
 	range->valid = false;
 	range->hmm = NULL;
 
-	if ((start & mask) || (end & mask))
+	if ((range->start & mask) || (range->end & mask))
 		return -EINVAL;
-	if (start >= end)
+	if (range->start >= range->end)
 		return -EINVAL;
 
-	range->page_shift = page_shift;
-	range->start = start;
-	range->end = end;
-
 	/* Prevent hmm_release() from running while the range is valid */
 	if (!mmget_not_zero(hmm->mm))
 		return -EFAULT;
-- 
2.20.1

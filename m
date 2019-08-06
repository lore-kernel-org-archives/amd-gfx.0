From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/15] mm: remove the pgmap field from struct hmm_vma_walk
Date: Tue,  6 Aug 2019 19:05:42 +0300
Message-ID: <20190806160554.14046-5-hch@lst.de>
References: <20190806160554.14046-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806160554.14046-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

There is only a single place where the pgmap is passed over a function
call, so replace it with local variables in the places where we deal
with the pgmap.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/hmm.c | 62 ++++++++++++++++++++++++--------------------------------
 1 file changed, 27 insertions(+), 35 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 9a908902e4cc..d66fa29b42e0 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -278,7 +278,6 @@ EXPORT_SYMBOL(hmm_mirror_unregister);
 
 struct hmm_vma_walk {
 	struct hmm_range	*range;
-	struct dev_pagemap	*pgmap;
 	unsigned long		last;
 	unsigned int		flags;
 };
@@ -475,6 +474,7 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
+	struct dev_pagemap *pgmap = NULL;
 	unsigned long pfn, npages, i;
 	bool fault, write_fault;
 	uint64_t cpu_flags;
@@ -490,17 +490,14 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
 	pfn = pmd_pfn(pmd) + pte_index(addr);
 	for (i = 0; addr < end; addr += PAGE_SIZE, i++, pfn++) {
 		if (pmd_devmap(pmd)) {
-			hmm_vma_walk->pgmap = get_dev_pagemap(pfn,
-					      hmm_vma_walk->pgmap);
-			if (unlikely(!hmm_vma_walk->pgmap))
+			pgmap = get_dev_pagemap(pfn, pgmap);
+			if (unlikely(!pgmap))
 				return -EBUSY;
 		}
 		pfns[i] = hmm_device_entry_from_pfn(range, pfn) | cpu_flags;
 	}
-	if (hmm_vma_walk->pgmap) {
-		put_dev_pagemap(hmm_vma_walk->pgmap);
-		hmm_vma_walk->pgmap = NULL;
-	}
+	if (pgmap)
+		put_dev_pagemap(pgmap);
 	hmm_vma_walk->last = end;
 	return 0;
 #else
@@ -520,7 +517,7 @@ static inline uint64_t pte_to_hmm_pfn_flags(struct hmm_range *range, pte_t pte)
 
 static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 			      unsigned long end, pmd_t *pmdp, pte_t *ptep,
-			      uint64_t *pfn)
+			      uint64_t *pfn, struct dev_pagemap **pgmap)
 {
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
@@ -591,9 +588,8 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 		goto fault;
 
 	if (pte_devmap(pte)) {
-		hmm_vma_walk->pgmap = get_dev_pagemap(pte_pfn(pte),
-					      hmm_vma_walk->pgmap);
-		if (unlikely(!hmm_vma_walk->pgmap))
+		*pgmap = get_dev_pagemap(pte_pfn(pte), *pgmap);
+		if (unlikely(!*pgmap))
 			return -EBUSY;
 	} else if (IS_ENABLED(CONFIG_ARCH_HAS_PTE_SPECIAL) && pte_special(pte)) {
 		*pfn = range->values[HMM_PFN_SPECIAL];
@@ -604,10 +600,10 @@ static int hmm_vma_handle_pte(struct mm_walk *walk, unsigned long addr,
 	return 0;
 
 fault:
-	if (hmm_vma_walk->pgmap) {
-		put_dev_pagemap(hmm_vma_walk->pgmap);
-		hmm_vma_walk->pgmap = NULL;
-	}
+	if (*pgmap)
+		put_dev_pagemap(*pgmap);
+	*pgmap = NULL;
+
 	pte_unmap(ptep);
 	/* Fault any virtual address we were asked to fault */
 	return hmm_vma_walk_hole_(addr, end, fault, write_fault, walk);
@@ -620,6 +616,7 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 {
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
+	struct dev_pagemap *pgmap = NULL;
 	uint64_t *pfns = range->pfns;
 	unsigned long addr = start, i;
 	pte_t *ptep;
@@ -683,23 +680,21 @@ static int hmm_vma_walk_pmd(pmd_t *pmdp,
 	for (; addr < end; addr += PAGE_SIZE, ptep++, i++) {
 		int r;
 
-		r = hmm_vma_handle_pte(walk, addr, end, pmdp, ptep, &pfns[i]);
+		r = hmm_vma_handle_pte(walk, addr, end, pmdp, ptep, &pfns[i],
+				&pgmap);
 		if (r) {
 			/* hmm_vma_handle_pte() did unmap pte directory */
 			hmm_vma_walk->last = addr;
 			return r;
 		}
 	}
-	if (hmm_vma_walk->pgmap) {
-		/*
-		 * We do put_dev_pagemap() here and not in hmm_vma_handle_pte()
-		 * so that we can leverage get_dev_pagemap() optimization which
-		 * will not re-take a reference on a pgmap if we already have
-		 * one.
-		 */
-		put_dev_pagemap(hmm_vma_walk->pgmap);
-		hmm_vma_walk->pgmap = NULL;
-	}
+	/*
+	 * We do put_dev_pagemap() here and not in hmm_vma_handle_pte() so that
+	 * we can leverage the get_dev_pagemap() optimization which will not
+	 * re-take a reference on a pgmap if we already have one.
+	 */
+	if (pgmap)
+		put_dev_pagemap(pgmap);
 	pte_unmap(ptep - 1);
 
 	hmm_vma_walk->last = addr;
@@ -714,6 +709,7 @@ static int hmm_vma_walk_pud(pud_t *pudp,
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
 	unsigned long addr = start, next;
+	struct dev_pagemap *pgmap = NULL;
 	pmd_t *pmdp;
 	pud_t pud;
 	int ret;
@@ -744,17 +740,14 @@ static int hmm_vma_walk_pud(pud_t *pudp,
 
 		pfn = pud_pfn(pud) + ((addr & ~PUD_MASK) >> PAGE_SHIFT);
 		for (i = 0; i < npages; ++i, ++pfn) {
-			hmm_vma_walk->pgmap = get_dev_pagemap(pfn,
-					      hmm_vma_walk->pgmap);
-			if (unlikely(!hmm_vma_walk->pgmap))
+			pgmap = get_dev_pagemap(pfn, pgmap);
+			if (unlikely(!pgmap))
 				return -EBUSY;
 			pfns[i] = hmm_device_entry_from_pfn(range, pfn) |
 				  cpu_flags;
 		}
-		if (hmm_vma_walk->pgmap) {
-			put_dev_pagemap(hmm_vma_walk->pgmap);
-			hmm_vma_walk->pgmap = NULL;
-		}
+		if (pgmap)
+			put_dev_pagemap(pgmap);
 		hmm_vma_walk->last = end;
 		return 0;
 	}
@@ -1002,7 +995,6 @@ long hmm_range_fault(struct hmm_range *range, unsigned int flags)
 			return -EPERM;
 		}
 
-		hmm_vma_walk.pgmap = NULL;
 		hmm_vma_walk.last = start;
 		hmm_vma_walk.flags = flags;
 		hmm_vma_walk.range = range;
-- 
2.20.1

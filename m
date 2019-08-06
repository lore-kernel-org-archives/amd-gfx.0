From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 11/15] mm: cleanup the hmm_vma_handle_pmd stub
Date: Tue,  6 Aug 2019 19:05:49 +0300
Message-ID: <20190806160554.14046-12-hch@lst.de>
References: <20190806160554.14046-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806160554.14046-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Stub out the whole function when CONFIG_TRANSPARENT_HUGEPAGE is not set
to make the function easier to read.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/hmm.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/mm/hmm.c b/mm/hmm.c
index 5e7afe685213..4aa7135f1094 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -455,13 +455,10 @@ static inline uint64_t pmd_to_hmm_pfn_flags(struct hmm_range *range, pmd_t pmd)
 				range->flags[HMM_PFN_VALID];
 }
 
-static int hmm_vma_handle_pmd(struct mm_walk *walk,
-			      unsigned long addr,
-			      unsigned long end,
-			      uint64_t *pfns,
-			      pmd_t pmd)
-{
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
+static int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
+		unsigned long end, uint64_t *pfns, pmd_t pmd)
+{
 	struct hmm_vma_walk *hmm_vma_walk = walk->private;
 	struct hmm_range *range = hmm_vma_walk->range;
 	struct dev_pagemap *pgmap = NULL;
@@ -490,11 +487,12 @@ static int hmm_vma_handle_pmd(struct mm_walk *walk,
 		put_dev_pagemap(pgmap);
 	hmm_vma_walk->last = end;
 	return 0;
-#else
-	/* If THP is not enabled then we should never reach this code ! */
-	return -EINVAL;
-#endif
 }
+#else /* CONFIG_TRANSPARENT_HUGEPAGE */
+/* stub to allow the code below to compile */
+int hmm_vma_handle_pmd(struct mm_walk *walk, unsigned long addr,
+		unsigned long end, uint64_t *pfns, pmd_t pmd);
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline uint64_t pte_to_hmm_pfn_flags(struct hmm_range *range, pte_t pte)
 {
-- 
2.20.1

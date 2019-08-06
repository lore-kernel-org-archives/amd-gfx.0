From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 05/15] mm: remove the unused vma argument to hmm_range_dma_unmap
Date: Tue,  6 Aug 2019 19:05:43 +0300
Message-ID: <20190806160554.14046-6-hch@lst.de>
References: <20190806160554.14046-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806160554.14046-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/linux/hmm.h | 1 -
 mm/hmm.c            | 2 --
 2 files changed, 3 deletions(-)

diff --git a/include/linux/hmm.h b/include/linux/hmm.h
index 82265118d94a..59be0aa2476d 100644
--- a/include/linux/hmm.h
+++ b/include/linux/hmm.h
@@ -422,7 +422,6 @@ long hmm_range_dma_map(struct hmm_range *range,
 		       dma_addr_t *daddrs,
 		       unsigned int flags);
 long hmm_range_dma_unmap(struct hmm_range *range,
-			 struct vm_area_struct *vma,
 			 struct device *device,
 			 dma_addr_t *daddrs,
 			 bool dirty);
diff --git a/mm/hmm.c b/mm/hmm.c
index d66fa29b42e0..3a3852660757 100644
--- a/mm/hmm.c
+++ b/mm/hmm.c
@@ -1121,7 +1121,6 @@ EXPORT_SYMBOL(hmm_range_dma_map);
 /**
  * hmm_range_dma_unmap() - unmap range of that was map with hmm_range_dma_map()
  * @range: range being unmapped
- * @vma: the vma against which the range (optional)
  * @device: device against which dma map was done
  * @daddrs: dma address of mapped pages
  * @dirty: dirty page if it had the write flag set
@@ -1133,7 +1132,6 @@ EXPORT_SYMBOL(hmm_range_dma_map);
  * concurrent mmu notifier or sync_cpu_device_pagetables() to make progress.
  */
 long hmm_range_dma_unmap(struct hmm_range *range,
-			 struct vm_area_struct *vma,
 			 struct device *device,
 			 dma_addr_t *daddrs,
 			 bool dirty)
-- 
2.20.1

From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 01/13] amdgpu: remove -EAGAIN handling for hmm_range_fault
Date: Tue, 30 Jul 2019 08:51:51 +0300
Message-ID: <20190730055203.28467-2-hch@lst.de>
References: <20190730055203.28467-1-hch@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730055203.28467-1-hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Jason Gunthorpe <jgg@mellanox.com>, Ben Skeggs <bskeggs@redhat.com>, Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Ralph Campbell <rcampbell@nvidia.com>, linux-mm@kvack.org, nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

hmm_range_fault can only return -EAGAIN if called with the block
argument set to false, so remove the special handling for it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 23 +++--------------------
 1 file changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 12a59ac83f72..f0821638bbc6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -778,7 +778,6 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 	struct hmm_range *range;
 	unsigned long i;
 	uint64_t *pfns;
-	int retry = 0;
 	int r = 0;
 
 	if (!mm) /* Happens during process shutdown */
@@ -822,7 +821,6 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 	hmm_range_register(range, mirror, start,
 			   start + ttm->num_pages * PAGE_SIZE, PAGE_SHIFT);
 
-retry:
 	/*
 	 * Just wait for range to be valid, safe to ignore return value as we
 	 * will use the return value of hmm_range_fault() below under the
@@ -831,24 +829,12 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 	hmm_range_wait_until_valid(range, HMM_RANGE_DEFAULT_TIMEOUT);
 
 	down_read(&mm->mmap_sem);
-
 	r = hmm_range_fault(range, 0);
-	if (unlikely(r < 0)) {
-		if (likely(r == -EAGAIN)) {
-			/*
-			 * return -EAGAIN, mmap_sem is dropped
-			 */
-			if (retry++ < MAX_RETRY_HMM_RANGE_FAULT)
-				goto retry;
-			else
-				pr_err("Retry hmm fault too many times\n");
-		}
-
-		goto out_up_read;
-	}
-
 	up_read(&mm->mmap_sem);
 
+	if (unlikely(r < 0))
+		goto out_free_pfns;
+
 	for (i = 0; i < ttm->num_pages; i++) {
 		pages[i] = hmm_device_entry_to_page(range, pfns[i]);
 		if (unlikely(!pages[i])) {
@@ -864,9 +850,6 @@ int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages)
 
 	return 0;
 
-out_up_read:
-	if (likely(r != -EAGAIN))
-		up_read(&mm->mmap_sem);
 out_free_pfns:
 	hmm_range_unregister(range);
 	kvfree(pfns);
-- 
2.20.1

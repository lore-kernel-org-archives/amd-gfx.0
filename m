From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v3 hmm 07/11] RDMA/odp: remove ib_ucontext from ib_umem
Date: Tue,  6 Aug 2019 20:15:44 -0300
Message-ID: <20190806231548.25242-8-jgg@ziepe.ca>
References: <20190806231548.25242-1-jgg@ziepe.ca>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190806231548.25242-1-jgg@ziepe.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-mm@kvack.org
Cc: Andrea Arcangeli <aarcange@redhat.com>, Christoph Hellwig <hch@lst.de>, John Hubbard <jhubbard@nvidia.com>, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, Ralph Campbell <rcampbell@nvidia.com>, "Kuehling, Felix" <Felix.Kuehling@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, Dimitri Sivanich <sivanich@sgi.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, iommu@lists.linux-foundation.org, intel-gfx@lists.freedesktop.org, Gavin Shan <shangw@linux.vnet.ibm.com>, Andrea Righi <andrea@betterlinux.com>, Jason Gunthorpe <jgg@mellanox.com>
List-Id: amd-gfx.lists.freedesktop.org

From: Jason Gunthorpe <jgg@mellanox.com>

At this point the ucontext is only being stored to access the ib_device,
so just store the ib_device directly instead. This is more natural and
logical as the umem has nothing to do with the ucontext.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/infiniband/core/umem.c     |  4 ++--
 drivers/infiniband/core/umem_odp.c | 13 ++++++-------
 include/rdma/ib_umem.h             |  2 +-
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband/core/umem.c
index c59aa57d36510f..5ab9165ffbef0a 100644
--- a/drivers/infiniband/core/umem.c
+++ b/drivers/infiniband/core/umem.c
@@ -242,7 +242,7 @@ struct ib_umem *ib_umem_get(struct ib_udata *udata, unsigned long addr,
 			return ERR_PTR(-ENOMEM);
 	}
 
-	umem->context    = context;
+	umem->ibdev = context->device;
 	umem->length     = size;
 	umem->address    = addr;
 	umem->writable   = ib_access_writable(access);
@@ -370,7 +370,7 @@ void ib_umem_release(struct ib_umem *umem)
 		return;
 	}
 
-	__ib_umem_release(umem->context->device, umem, 1);
+	__ib_umem_release(umem->ibdev, umem, 1);
 
 	atomic64_sub(ib_umem_num_pages(umem), &umem->owning_mm->pinned_vm);
 	__ib_umem_release_tail(umem);
diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infiniband/core/umem_odp.c
index a02e6e3d7b72fb..da72318e17592f 100644
--- a/drivers/infiniband/core/umem_odp.c
+++ b/drivers/infiniband/core/umem_odp.c
@@ -103,7 +103,7 @@ static void ib_umem_notifier_release(struct mmu_notifier *mn,
 		 */
 		smp_wmb();
 		complete_all(&umem_odp->notifier_completion);
-		umem_odp->umem.context->device->ops.invalidate_range(
+		umem_odp->umem.ibdev->ops.invalidate_range(
 			umem_odp, ib_umem_start(umem_odp),
 			ib_umem_end(umem_odp));
 	}
@@ -116,7 +116,7 @@ static int invalidate_range_start_trampoline(struct ib_umem_odp *item,
 					     u64 start, u64 end, void *cookie)
 {
 	ib_umem_notifier_start_account(item);
-	item->umem.context->device->ops.invalidate_range(item, start, end);
+	item->umem.ibdev->ops.invalidate_range(item, start, end);
 	return 0;
 }
 
@@ -319,7 +319,7 @@ struct ib_umem_odp *ib_umem_odp_alloc_implicit(struct ib_udata *udata,
 	if (!umem_odp)
 		return ERR_PTR(-ENOMEM);
 	umem = &umem_odp->umem;
-	umem->context = context;
+	umem->ibdev = context->device;
 	umem->writable = ib_access_writable(access);
 	umem->owning_mm = current->mm;
 	umem_odp->is_implicit_odp = 1;
@@ -364,7 +364,7 @@ struct ib_umem_odp *ib_umem_odp_alloc_child(struct ib_umem_odp *root,
 	if (!odp_data)
 		return ERR_PTR(-ENOMEM);
 	umem = &odp_data->umem;
-	umem->context    = root->umem.context;
+	umem->ibdev = root->umem.ibdev;
 	umem->length     = size;
 	umem->address    = addr;
 	umem->writable   = root->umem.writable;
@@ -477,8 +477,7 @@ static int ib_umem_odp_map_dma_single_page(
 		u64 access_mask,
 		unsigned long current_seq)
 {
-	struct ib_ucontext *context = umem_odp->umem.context;
-	struct ib_device *dev = context->device;
+	struct ib_device *dev = umem_odp->umem.ibdev;
 	dma_addr_t dma_addr;
 	int remove_existing_mapping = 0;
 	int ret = 0;
@@ -691,7 +690,7 @@ void ib_umem_odp_unmap_dma_pages(struct ib_umem_odp *umem_odp, u64 virt,
 {
 	int idx;
 	u64 addr;
-	struct ib_device *dev = umem_odp->umem.context->device;
+	struct ib_device *dev = umem_odp->umem.ibdev;
 
 	virt = max_t(u64, virt, ib_umem_start(umem_odp));
 	bound = min_t(u64, bound, ib_umem_end(umem_odp));
diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
index 1052d0d62be7d2..a91b2af64ec47b 100644
--- a/include/rdma/ib_umem.h
+++ b/include/rdma/ib_umem.h
@@ -42,7 +42,7 @@ struct ib_ucontext;
 struct ib_umem_odp;
 
 struct ib_umem {
-	struct ib_ucontext     *context;
+	struct ib_device       *ibdev;
 	struct mm_struct       *owning_mm;
 	size_t			length;
 	unsigned long		address;
-- 
2.22.0

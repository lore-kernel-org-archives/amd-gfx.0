From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v3 hmm 11/11] mm/mmu_notifiers: remove unregister_no_release
Date: Tue,  6 Aug 2019 20:15:48 -0300
Message-ID: <20190806231548.25242-12-jgg@ziepe.ca>
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

mmu_notifier_unregister_no_release() and mmu_notifier_call_srcu() no
longer have any users, they have all been converted to use
mmu_notifier_put().

So delete this difficult to use interface.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 include/linux/mmu_notifier.h |  5 -----
 mm/mmu_notifier.c            | 31 -------------------------------
 2 files changed, 36 deletions(-)

diff --git a/include/linux/mmu_notifier.h b/include/linux/mmu_notifier.h
index 31aa971315a142..52929e5ef70826 100644
--- a/include/linux/mmu_notifier.h
+++ b/include/linux/mmu_notifier.h
@@ -271,8 +271,6 @@ extern int __mmu_notifier_register(struct mmu_notifier *mn,
 				   struct mm_struct *mm);
 extern void mmu_notifier_unregister(struct mmu_notifier *mn,
 				    struct mm_struct *mm);
-extern void mmu_notifier_unregister_no_release(struct mmu_notifier *mn,
-					       struct mm_struct *mm);
 extern void __mmu_notifier_mm_destroy(struct mm_struct *mm);
 extern void __mmu_notifier_release(struct mm_struct *mm);
 extern int __mmu_notifier_clear_flush_young(struct mm_struct *mm,
@@ -513,9 +511,6 @@ static inline void mmu_notifier_range_init(struct mmu_notifier_range *range,
 	set_pte_at(___mm, ___address, __ptep, ___pte);			\
 })
 
-extern void mmu_notifier_call_srcu(struct rcu_head *rcu,
-				   void (*func)(struct rcu_head *rcu));
-
 #else /* CONFIG_MMU_NOTIFIER */
 
 struct mmu_notifier_range {
diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 4a770b5211b71d..2ec48f8ba9e288 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -21,18 +21,6 @@
 /* global SRCU for all MMs */
 DEFINE_STATIC_SRCU(srcu);
 
-/*
- * This function allows mmu_notifier::release callback to delay a call to
- * a function that will free appropriate resources. The function must be
- * quick and must not block.
- */
-void mmu_notifier_call_srcu(struct rcu_head *rcu,
-			    void (*func)(struct rcu_head *rcu))
-{
-	call_srcu(&srcu, rcu, func);
-}
-EXPORT_SYMBOL_GPL(mmu_notifier_call_srcu);
-
 /*
  * This function can't run concurrently against mmu_notifier_register
  * because mm->mm_users > 0 during mmu_notifier_register and exit_mmap
@@ -453,25 +441,6 @@ void mmu_notifier_unregister(struct mmu_notifier *mn, struct mm_struct *mm)
 }
 EXPORT_SYMBOL_GPL(mmu_notifier_unregister);
 
-/*
- * Same as mmu_notifier_unregister but no callback and no srcu synchronization.
- */
-void mmu_notifier_unregister_no_release(struct mmu_notifier *mn,
-					struct mm_struct *mm)
-{
-	spin_lock(&mm->mmu_notifier_mm->lock);
-	/*
-	 * Can not use list_del_rcu() since __mmu_notifier_release
-	 * can delete it before we hold the lock.
-	 */
-	hlist_del_init_rcu(&mn->hlist);
-	spin_unlock(&mm->mmu_notifier_mm->lock);
-
-	BUG_ON(atomic_read(&mm->mm_count) <= 0);
-	mmdrop(mm);
-}
-EXPORT_SYMBOL_GPL(mmu_notifier_unregister_no_release);
-
 static void mmu_notifier_free_rcu(struct rcu_head *rcu)
 {
 	struct mmu_notifier *mn = container_of(rcu, struct mmu_notifier, rcu);
-- 
2.22.0

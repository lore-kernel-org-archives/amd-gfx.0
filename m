From: Jason Gunthorpe <jgg-uk2M96/98Pc@public.gmane.org>
Subject: [PATCH v3 hmm 02/11] mm/mmu_notifiers: do not speculatively allocate
	a mmu_notifier_mm
Date: Tue,  6 Aug 2019 20:15:39 -0300
Message-ID: <20190806231548.25242-3-jgg@ziepe.ca>
References: <20190806231548.25242-1-jgg@ziepe.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20190806231548.25242-1-jgg-uk2M96/98Pc@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: linux-mm-Bw31MaZKKs3YtjvyW6yDsg@public.gmane.org
Cc: Andrea Arcangeli <aarcange-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, "David (ChunMing) Zhou" <David1.Zhou-5C7GfCeVMHo@public.gmane.org>, Ralph Campbell <rcampbell-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Dimitri Sivanich <sivanich-sJ/iWh9BUns@public.gmane.org>, Gavin Shan <shangw-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org>, Andrea Righi <andrea-oIIqvOZpAevzfdHfmsDf5w@public.gmane.org>, linux-rdma-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, John Hubbard <jhubbard-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, "Kuehling, Felix" <Felix.Kuehling-5C7GfCeVMHo@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>, =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>, Alex Deucher <alexander.deucher-5C7GfCeVMHo@public.gmane.org>, intel-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Christoph Hellwig <hch-jcswGhMUV9g@public.gmane.org>
List-Id: amd-gfx.lists.freedesktop.org

From: Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>

A prior commit e0f3c3f78da2 ("mm/mmu_notifier: init notifier if necessary")
made an attempt at doing this, but had to be reverted as calling
the GFP_KERNEL allocator under the i_mmap_mutex causes deadlock, see
commit 35cfa2b0b491 ("mm/mmu_notifier: allocate mmu_notifier in advance").

However, we can avoid that problem by doing the allocation only under
the mmap_sem, which is already happening.

Since all writers to mm->mmu_notifier_mm hold the write side of the
mmap_sem reading it under that sem is deterministic and we can use that to
decide if the allocation path is required, without speculation.

The actual update to mmu_notifier_mm must still be done under the
mm_take_all_locks() to ensure read-side coherency.

Signed-off-by: Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
---
 mm/mmu_notifier.c | 34 ++++++++++++++++++++++------------
 1 file changed, 22 insertions(+), 12 deletions(-)

diff --git a/mm/mmu_notifier.c b/mm/mmu_notifier.c
index 218a6f108bc2d0..696810f632ade1 100644
--- a/mm/mmu_notifier.c
+++ b/mm/mmu_notifier.c
@@ -242,27 +242,32 @@ EXPORT_SYMBOL_GPL(__mmu_notifier_invalidate_range);
  */
 int __mmu_notifier_register(struct mmu_notifier *mn, struct mm_struct *mm)
 {
-	struct mmu_notifier_mm *mmu_notifier_mm;
+	struct mmu_notifier_mm *mmu_notifier_mm = NULL;
 	int ret;
 
 	lockdep_assert_held_write(&mm->mmap_sem);
 	BUG_ON(atomic_read(&mm->mm_users) <= 0);
 
-	mmu_notifier_mm = kmalloc(sizeof(struct mmu_notifier_mm), GFP_KERNEL);
-	if (unlikely(!mmu_notifier_mm))
-		return -ENOMEM;
+	if (!mm->mmu_notifier_mm) {
+		/*
+		 * kmalloc cannot be called under mm_take_all_locks(), but we
+		 * know that mm->mmu_notifier_mm can't change while we hold
+		 * the write side of the mmap_sem.
+		 */
+		mmu_notifier_mm =
+			kmalloc(sizeof(struct mmu_notifier_mm), GFP_KERNEL);
+		if (!mmu_notifier_mm)
+			return -ENOMEM;
+
+		INIT_HLIST_HEAD(&mmu_notifier_mm->list);
+		spin_lock_init(&mmu_notifier_mm->lock);
+	}
 
 	ret = mm_take_all_locks(mm);
 	if (unlikely(ret))
 		goto out_clean;
 
-	if (!mm_has_notifiers(mm)) {
-		INIT_HLIST_HEAD(&mmu_notifier_mm->list);
-		spin_lock_init(&mmu_notifier_mm->lock);
-
-		mm->mmu_notifier_mm = mmu_notifier_mm;
-		mmu_notifier_mm = NULL;
-	}
+	/* Pairs with the mmdrop in mmu_notifier_unregister_* */
 	mmgrab(mm);
 
 	/*
@@ -273,14 +278,19 @@ int __mmu_notifier_register(struct mmu_notifier *mn, struct mm_struct *mm)
 	 * We can't race against any other mmu notifier method either
 	 * thanks to mm_take_all_locks().
 	 */
+	if (mmu_notifier_mm)
+		mm->mmu_notifier_mm = mmu_notifier_mm;
+
 	spin_lock(&mm->mmu_notifier_mm->lock);
 	hlist_add_head_rcu(&mn->hlist, &mm->mmu_notifier_mm->list);
 	spin_unlock(&mm->mmu_notifier_mm->lock);
 
 	mm_drop_all_locks(mm);
+	BUG_ON(atomic_read(&mm->mm_users) <= 0);
+	return 0;
+
 out_clean:
 	kfree(mmu_notifier_mm);
-	BUG_ON(atomic_read(&mm->mm_users) <= 0);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(__mmu_notifier_register);
-- 
2.22.0

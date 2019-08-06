From: Jason Gunthorpe <jgg-uk2M96/98Pc@public.gmane.org>
Subject: [PATCH v3 hmm 04/11] misc/sgi-gru: use mmu_notifier_get/put for
	struct gru_mm_struct
Date: Tue,  6 Aug 2019 20:15:41 -0300
Message-ID: <20190806231548.25242-5-jgg@ziepe.ca>
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

GRU is already using almost the same algorithm as get/put, it even
helpfully has a 10 year old comment to make this algorithm common, which
is finally happening.

There are a few differences and fixes from this conversion:
- GRU used rcu not srcu to read the hlist
- Unclear how the locking worked to prevent gru_register_mmu_notifier()
  from running concurrently with gru_drop_mmu_notifier() - this version is
  safe
- GRU had a release function which only set a variable without any locking
  that skiped the synchronize_srcu during unregister which looks racey,
  but this makes it reliable via the integrated call_srcu().
- It is unclear if the mmap_sem is actually held when
  __mmu_notifier_register() was called, lockdep will now warn if this is
  wrong

Signed-off-by: Jason Gunthorpe <jgg-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
---
 drivers/misc/sgi-gru/grufile.c     |  1 +
 drivers/misc/sgi-gru/grutables.h   |  2 -
 drivers/misc/sgi-gru/grutlbpurge.c | 84 +++++++++---------------------
 3 files changed, 25 insertions(+), 62 deletions(-)

diff --git a/drivers/misc/sgi-gru/grufile.c b/drivers/misc/sgi-gru/grufile.c
index a2a142ae087bfa..9d042310214ff9 100644
--- a/drivers/misc/sgi-gru/grufile.c
+++ b/drivers/misc/sgi-gru/grufile.c
@@ -573,6 +573,7 @@ static void __exit gru_exit(void)
 	gru_free_tables();
 	misc_deregister(&gru_miscdev);
 	gru_proc_exit();
+	mmu_notifier_synchronize();
 }
 
 static const struct file_operations gru_fops = {
diff --git a/drivers/misc/sgi-gru/grutables.h b/drivers/misc/sgi-gru/grutables.h
index 438191c220570c..a7e44b2eb413f6 100644
--- a/drivers/misc/sgi-gru/grutables.h
+++ b/drivers/misc/sgi-gru/grutables.h
@@ -307,10 +307,8 @@ struct gru_mm_tracker {				/* pack to reduce size */
 
 struct gru_mm_struct {
 	struct mmu_notifier	ms_notifier;
-	atomic_t		ms_refcnt;
 	spinlock_t		ms_asid_lock;	/* protects ASID assignment */
 	atomic_t		ms_range_active;/* num range_invals active */
-	char			ms_released;
 	wait_queue_head_t	ms_wait_queue;
 	DECLARE_BITMAP(ms_asidmap, GRU_MAX_GRUS);
 	struct gru_mm_tracker	ms_asids[GRU_MAX_GRUS];
diff --git a/drivers/misc/sgi-gru/grutlbpurge.c b/drivers/misc/sgi-gru/grutlbpurge.c
index 59ba0adf23cee4..10921cd2608dfa 100644
--- a/drivers/misc/sgi-gru/grutlbpurge.c
+++ b/drivers/misc/sgi-gru/grutlbpurge.c
@@ -235,83 +235,47 @@ static void gru_invalidate_range_end(struct mmu_notifier *mn,
 		gms, range->start, range->end);
 }
 
-static void gru_release(struct mmu_notifier *mn, struct mm_struct *mm)
+static struct mmu_notifier *gru_alloc_notifier(struct mm_struct *mm)
 {
-	struct gru_mm_struct *gms = container_of(mn, struct gru_mm_struct,
-						 ms_notifier);
+	struct gru_mm_struct *gms;
+
+	gms = kzalloc(sizeof(*gms), GFP_KERNEL);
+	if (!gms)
+		return ERR_PTR(-ENOMEM);
+	STAT(gms_alloc);
+	spin_lock_init(&gms->ms_asid_lock);
+	init_waitqueue_head(&gms->ms_wait_queue);
 
-	gms->ms_released = 1;
-	gru_dbg(grudev, "gms %p\n", gms);
+	return &gms->ms_notifier;
 }
 
+static void gru_free_notifier(struct mmu_notifier *mn)
+{
+	kfree(container_of(mn, struct gru_mm_struct, ms_notifier));
+	STAT(gms_free);
+}
 
 static const struct mmu_notifier_ops gru_mmuops = {
 	.invalidate_range_start	= gru_invalidate_range_start,
 	.invalidate_range_end	= gru_invalidate_range_end,
-	.release		= gru_release,
+	.alloc_notifier		= gru_alloc_notifier,
+	.free_notifier		= gru_free_notifier,
 };
 
-/* Move this to the basic mmu_notifier file. But for now... */
-static struct mmu_notifier *mmu_find_ops(struct mm_struct *mm,
-			const struct mmu_notifier_ops *ops)
-{
-	struct mmu_notifier *mn, *gru_mn = NULL;
-
-	if (mm->mmu_notifier_mm) {
-		rcu_read_lock();
-		hlist_for_each_entry_rcu(mn, &mm->mmu_notifier_mm->list,
-					 hlist)
-		    if (mn->ops == ops) {
-			gru_mn = mn;
-			break;
-		}
-		rcu_read_unlock();
-	}
-	return gru_mn;
-}
-
 struct gru_mm_struct *gru_register_mmu_notifier(void)
 {
-	struct gru_mm_struct *gms;
 	struct mmu_notifier *mn;
-	int err;
-
-	mn = mmu_find_ops(current->mm, &gru_mmuops);
-	if (mn) {
-		gms = container_of(mn, struct gru_mm_struct, ms_notifier);
-		atomic_inc(&gms->ms_refcnt);
-	} else {
-		gms = kzalloc(sizeof(*gms), GFP_KERNEL);
-		if (!gms)
-			return ERR_PTR(-ENOMEM);
-		STAT(gms_alloc);
-		spin_lock_init(&gms->ms_asid_lock);
-		gms->ms_notifier.ops = &gru_mmuops;
-		atomic_set(&gms->ms_refcnt, 1);
-		init_waitqueue_head(&gms->ms_wait_queue);
-		err = __mmu_notifier_register(&gms->ms_notifier, current->mm);
-		if (err)
-			goto error;
-	}
-	if (gms)
-		gru_dbg(grudev, "gms %p, refcnt %d\n", gms,
-			atomic_read(&gms->ms_refcnt));
-	return gms;
-error:
-	kfree(gms);
-	return ERR_PTR(err);
+
+	mn = mmu_notifier_get_locked(&gru_mmuops, current->mm);
+	if (IS_ERR(mn))
+		return ERR_CAST(mn);
+
+	return container_of(mn, struct gru_mm_struct, ms_notifier);
 }
 
 void gru_drop_mmu_notifier(struct gru_mm_struct *gms)
 {
-	gru_dbg(grudev, "gms %p, refcnt %d, released %d\n", gms,
-		atomic_read(&gms->ms_refcnt), gms->ms_released);
-	if (atomic_dec_return(&gms->ms_refcnt) == 0) {
-		if (!gms->ms_released)
-			mmu_notifier_unregister(&gms->ms_notifier, current->mm);
-		kfree(gms);
-		STAT(gms_free);
-	}
+	mmu_notifier_put(&gms->ms_notifier);
 }
 
 /*
-- 
2.22.0

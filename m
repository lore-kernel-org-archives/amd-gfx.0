From: Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v3 hmm 10/11] drm/amdkfd: use mmu_notifier_put
Date: Tue,  6 Aug 2019 20:15:47 -0300
Message-ID: <20190806231548.25242-11-jgg@ziepe.ca>
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

The sequence of mmu_notifier_unregister_no_release(),
mmu_notifier_call_srcu() is identical to mmu_notifier_put() with the
free_notifier callback.

As this is the last user of those APIs, converting it means we can drop
them.

Signed-off-by: Jason Gunthorpe <jgg@mellanox.com>
---
 drivers/gpu/drm/amd/amdkfd/kfd_priv.h    |  3 ---
 drivers/gpu/drm/amd/amdkfd/kfd_process.c | 10 ++++------
 2 files changed, 4 insertions(+), 9 deletions(-)

I'm really not sure what this is doing, but it is very strange to have a
release with no other callback. It would be good if this would change to use
get as well.

diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
index 3933fb6a371efb..9450e20d17093b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_priv.h
@@ -686,9 +686,6 @@ struct kfd_process {
 	/* We want to receive a notification when the mm_struct is destroyed */
 	struct mmu_notifier mmu_notifier;
 
-	/* Use for delayed freeing of kfd_process structure */
-	struct rcu_head	rcu;
-
 	unsigned int pasid;
 	unsigned int doorbell_index;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_process.c b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
index c06e6190f21ffa..e5e326f2f2675e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_process.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_process.c
@@ -486,11 +486,9 @@ static void kfd_process_ref_release(struct kref *ref)
 	queue_work(kfd_process_wq, &p->release_work);
 }
 
-static void kfd_process_destroy_delayed(struct rcu_head *rcu)
+static void kfd_process_free_notifier(struct mmu_notifier *mn)
 {
-	struct kfd_process *p = container_of(rcu, struct kfd_process, rcu);
-
-	kfd_unref_process(p);
+	kfd_unref_process(container_of(mn, struct kfd_process, mmu_notifier));
 }
 
 static void kfd_process_notifier_release(struct mmu_notifier *mn,
@@ -542,12 +540,12 @@ static void kfd_process_notifier_release(struct mmu_notifier *mn,
 
 	mutex_unlock(&p->mutex);
 
-	mmu_notifier_unregister_no_release(&p->mmu_notifier, mm);
-	mmu_notifier_call_srcu(&p->rcu, &kfd_process_destroy_delayed);
+	mmu_notifier_put(&p->mmu_notifier);
 }
 
 static const struct mmu_notifier_ops kfd_process_mmu_notifier_ops = {
 	.release = kfd_process_notifier_release,
+	.free_notifier = kfd_process_free_notifier,
 };
 
 static int kfd_process_init_cwsr_apu(struct kfd_process *p, struct file *filep)
-- 
2.22.0

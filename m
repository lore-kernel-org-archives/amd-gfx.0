Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71637606A326
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Nov 2026 10:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wHYTFC5Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15D0F112A24;
	Fri, 27 Nov 2026 10:57:06 +0000 (UTC)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3BB5112A24
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 10:56:59 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4bb55cda775so49267555e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Nov 2026 02:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795777018; x=1796381818; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=FK+yVSG3sqqH85o8ky8FJBOzGHMzNitv+McgUrDzPjg=;
 b=wHYTFC5ZRm/++0XcRcPSRrJOEnbX3nhn4VYjLcJh6B+mQW3G/lPBAkiSRLnOEEGNCM
 Q6cAuJyoiiRh0/AzLFW6k3CD/Ss6p5QfOvNcHDLBvIQWN4sTRixXSO0wG1QT+rBJyP0X
 T+eNFebtPzr0PLGFY0Lkxc+c9m5q6J93B1ftAuO3lg9M/wSUoQXXYicVmYU9prqpTbzf
 74rt6BfWWwn4ft0UEHQ+yDINjwY5dVJ5lKvp3O2ZiYvQpZPo6Wta64+ADYsvJ00f+LpU
 9YPDJNS7BL68xGkY+VBT2mWN6dwpUVFnXjQ64WIec7DKYC/HSyLmEgkCSb0UN8gZjZ1O
 AD3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795777018; x=1796381818;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=FK+yVSG3sqqH85o8ky8FJBOzGHMzNitv+McgUrDzPjg=;
 b=s51HXxw0WuXYIKNQic+mZTaNGBkkGT4AKgqV784ANpuJQutk0zQWOSXsCjxpUgdcml
 ASHUz5BN+DQanxsjhYnADF6jg+FvhG9Kf43eZmtJ91jjxBcnyx6nlJTGpBiVDmEjA14/
 vkahm+0EGG/uz/CSMTtWZKVopr4VtVfL/ar0N+1OHdYUvRYx3ba7NkOvm5pG81AP3B5Z
 rzGEonlN1ezqmO+1fnp3LbAg2xPjR5YoXMXjHgnFtWGymlRmwR61HAbFP8PgQcfW/rGG
 InqfYo3SV6NowJn/8QP8+ZSv6DslAYFSH8qDvI0jAIleblMgNgbFOCdth632Dj3bfdJx
 4zaw==
X-Forwarded-Encrypted: i=1;
 AL+hErEw9TbJEBj9kOjteKJ14YS4YiaJKBPrhLCIjvbckyveNIqcXARbYy8yAYaXYFmNlgKpMe9QAynA@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8y+YFsiY0W31TT6iUsj14JMhaDjL6fbOSrysdX5Fvrok7DAbq/
 JF7bdiDNnPgBth8WjHnixq0oyEtrSE5OsESQarYBa8IFehMh3ZgR5ltZp4zujQ==
X-Gm-Gg: AZFdTZevHGyyOtH8KvqH7yM9n9lB88Gyc4okPpU1PB2JBlGR3z2CeQdAc6AM67Z3w+3
 E2RTqjT8X0zD6spCbQ38HvTxUmH5icM2e48wK9/2sBTWRuZlyL781eAhmiq36IA4W6zoLLSTwZO
 5ZKnUEt5L5T6bme+KxV7rGdRLgwqSOkII/GIwjCmod3WyJh25tTrS01MRM2CgrENYKLGWGfUHKT
 nF+m46xz58kqQEuf9grU2GJQgBSN2PqHyUHZS8V7hMxio8iMPlAgvbvvE8edgBpm5ZgyEuXuahY
 3x4fI1OyEwCswX0JT6gb5ZUX6qFu/6LO4PU2M/PBGyCLrqzkRbjQndcGEJ5mP3jAyQVxDprb4S7
 qEakg2Fp4dyuKM5dbTcrJ9LHN8lF5uMAO4i00Nx3miuIjrPa3/1X0ezH6b9QTRcpRFHXuM062eW
 7LhgzspdRfYNlrTW+uCjChn4SJty2ifV/WYZJySlHabRl3HzAsaa9c2sZK3ic8OKNeq5wb+wxQY
 5pYcOp02onDCXhY5Up33qT85j5oGIhz8A1MS3p3PjKDQHw1Gh16Ske4LY3bRTkCE/L6W55OzBPR
 mwJuKPDilp5F0Ka2fMHY3mwmIRL+XQlep73hCY0JGw==
X-Received: by 2002:a05:600c:4e0b:b0:49e:65f2:db64 with SMTP id
 5b1f17b1804b1-4bb887fb66cmr505725475e9.5.1795777017819; 
 Fri, 27 Nov 2026 02:56:57 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1446:d100:321d:daeb:7f0d:9341])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884911e3sm832988905e9.6.2026.11.27.02.56.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 02:56:57 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Chong.Li@amd.com, timur.kristof@gmail.com, phasta@kernel.org,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: switch vm->tlb_seq to dma_fence_chain handling v3
Date: Fri, 27 Nov 2026 11:56:56 +0100
Message-ID: <20261127105656.3187-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Reply-To: christian.koenig@amd.com
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The vm->tlb_seq handling for per VMID based TLB invalidation was always
rather fragile and relied on grabbing the dma_fence spinlock to make sure
that callbacks executed in the right order. Otherwise it could happen that
different callbacks raced with each other (e.g. callback 1 starting
worker while callback 2 incremented the sequence which is read by
worker).

Alan now pointed out that even this doesn't work correctly because
different PTDE/PTE updates might use different locks and their signaling
is not necessarily in the same order and on the same GPU.

Ditch the whole approach and drop the callback, instead use a
dma_fence_chain to track all PDE/PTE updates and just iterate over them
to get the last completed one when asked. Also make sure that PDE updates
use the same path as PTE updates for consistency.

This not only fixes rare GPU page faults in the kernel queues but also
potentially issues with the user queues should a PDE update make a TLB
invalidation necessary.

v2: also handle the case where the chain head is already signaled as
    pointed out by Alan.
v3: keep stub fence and add NULL pointer check for CPU update

Signed-off-by: Christian König <christian.koenig@amd.com>
Reported-by: Li, Chong(Alan) <Chong.Li@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 172 +++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  32 +---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c    |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |   3 -
 .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  |   2 +-
 5 files changed, 97 insertions(+), 118 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a627a30929903..6ecf7669f3b79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -27,6 +27,7 @@
  */
 
 #include <linux/dma-fence-array.h>
+#include <linux/dma-fence-chain.h>
 #include <linux/interval_tree_generic.h>
 #include <linux/idr.h>
 #include <linux/dma-buf.h>
@@ -114,21 +115,6 @@ struct amdgpu_prt_cb {
 	struct dma_fence_cb cb;
 };
 
-/**
- * struct amdgpu_vm_tlb_seq_struct - Helper to increment the TLB flush sequence
- */
-struct amdgpu_vm_tlb_seq_struct {
-	/**
-	 * @vm: pointer to the amdgpu_vm structure to set the fence sequence on
-	 */
-	struct amdgpu_vm *vm;
-
-	/**
-	 * @cb: callback
-	 */
-	struct dma_fence_cb cb;
-};
-
 /**
  * amdgpu_vm_assert_locked - check if VM is correctly locked
  * @vm: the VM which schould be tested
@@ -1026,6 +1012,71 @@ uint64_t amdgpu_vm_map_gart(const dma_addr_t *pages_addr, uint64_t addr)
 	return result;
 }
 
+/**
+ * amdgpu_vm_tlb_seq - return tlb flush sequence number
+ * @vm: the amdgpu_vm structure to query
+ *
+ * Returns the tlb flush sequence number which indicates that the VM TLBs needs
+ * to be invalidated whenever the sequence number change.
+ */
+uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
+{
+	struct dma_fence *fence;
+	u64 tlb_seq = 0;
+
+	rcu_read_lock();
+	fence = dma_fence_get_rcu_safe(&vm->last_seq_flush);
+	rcu_read_unlock();
+
+	if (dma_fence_is_signaled(dma_fence_chain_contained(fence))) {
+		tlb_seq = fence->seqno;
+		dma_fence_put(fence);
+	} else {
+		do {
+			tlb_seq = to_dma_fence_chain(fence)->prev_seqno;
+			fence = dma_fence_chain_walk(fence);
+		} while (fence);
+	}
+	return tlb_seq;
+}
+
+/**
+ * amdgpu_vm_tlb_flush - prepare TLB flush
+ *
+ * @params: parameters for update
+ * @chain: dma_fence_chain for the signaling callback
+ * @fence: input fence to sync TLB flush with
+ *
+ * Increments the tlb sequence to make sure that future CS execute a VM flush.
+ */
+static void
+amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
+		    struct dma_fence_chain *chain,
+		    struct dma_fence *fence)
+{
+	struct amdgpu_vm *vm = params->vm;
+	struct dma_fence *prev;
+
+	++vm->tlb_seq;
+	prev = rcu_dereference_protected(vm->last_seq_flush,
+					 lockdep_is_held(&vm->eviction_lock));
+	dma_fence_chain_init(chain, prev, dma_fence_get(fence), vm->tlb_seq);
+	rcu_assign_pointer(vm->last_seq_flush, &chain->base);
+
+	/* Prepare a TLB flush fence to be attached to PTs */
+	/* The check for need_tlb_fence should be dropped once we
+	 * sort out the issues with KIQ/MES TLB invalidation timeouts.
+	 */
+	if (!params->unlocked && vm->need_tlb_fence) {
+		amdgpu_vm_tlb_fence_create(params->adev, vm, fence,
+					   &vm->last_tlb_inv);
+
+		/* Makes sure no PD/PT is freed before the flush */
+		dma_resv_add_fence(vm->root.bo->tbo.base.resv,
+				   vm->last_tlb_inv, DMA_RESV_USAGE_BOOKKEEP);
+	}
+}
+
 /**
  * amdgpu_vm_update_pdes - make sure that all directories are valid
  *
@@ -1043,6 +1094,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 {
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_vm_bo_base *entry, *tmp;
+	struct dma_fence_chain *chain;
 	bool flush_tlb_needed = false;
 	int r, idx;
 
@@ -1054,11 +1106,21 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return -ENODEV;
 
+	chain = dma_fence_chain_alloc();
+	if (!chain) {
+		r = -ENOMEM;
+		goto error_dev_exit;
+	}
+
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
 	params.immediate = immediate;
 
+	r = amdgpu_vm_begin_critical(&params);
+	if (r)
+		goto error;
+
 	r = vm->update_funcs->prepare(&params, NULL,
 				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES);
 	if (r)
@@ -1078,73 +1140,22 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 		goto error;
 
 	if (flush_tlb_needed)
-		atomic64_inc(&vm->tlb_seq);
+		amdgpu_vm_tlb_flush(&params, chain, vm->last_update);
+	else
+		dma_fence_chain_free(chain);
 
 	list_for_each_entry_safe(entry, tmp, &vm->kernel.needs_update,
 				 vm_status)
 		amdgpu_vm_bo_idle(entry);
 
 error:
+	amdgpu_vm_end_critical(&params);
+
+error_dev_exit:
 	drm_dev_exit(idx);
 	return r;
 }
 
-/**
- * amdgpu_vm_tlb_seq_cb - make sure to increment tlb sequence
- * @fence: unused
- * @cb: the callback structure
- *
- * Increments the tlb sequence to make sure that future CS execute a VM flush.
- */
-static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
-				 struct dma_fence_cb *cb)
-{
-	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
-
-	tlb_cb = container_of(cb, typeof(*tlb_cb), cb);
-	atomic64_inc(&tlb_cb->vm->tlb_seq);
-	kfree(tlb_cb);
-}
-
-/**
- * amdgpu_vm_tlb_flush - prepare TLB flush
- *
- * @params: parameters for update
- * @fence: input fence to sync TLB flush with
- * @tlb_cb: the callback structure
- *
- * Increments the tlb sequence to make sure that future CS execute a VM flush.
- */
-static void
-amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
-		    struct dma_fence *fence,
-		    struct amdgpu_vm_tlb_seq_struct *tlb_cb)
-{
-	struct amdgpu_vm *vm = params->vm;
-
-	tlb_cb->vm = vm;
-	if (fence && !dma_fence_add_callback(fence, &tlb_cb->cb,
-					     amdgpu_vm_tlb_seq_cb)) {
-		dma_fence_put(vm->last_seq_flush);
-		vm->last_seq_flush = dma_fence_get(fence);
-	} else {
-		amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
-	}
-
-	/* Prepare a TLB flush fence to be attached to PTs */
-	/* The check for need_tlb_fence should be dropped once we
-	 * sort out the issues with KIQ/MES TLB invalidation timeouts.
-	 */
-	if (!params->unlocked && vm->need_tlb_fence) {
-		amdgpu_vm_tlb_fence_create(params->adev, vm, fence,
-					   &vm->last_tlb_inv);
-
-		/* Makes sure no PD/PT is freed before the flush */
-		dma_resv_add_fence(vm->root.bo->tbo.base.resv,
-				   vm->last_tlb_inv, DMA_RESV_USAGE_BOOKKEEP);
-	}
-}
-
 /**
  * amdgpu_vm_update_range - update a range in the vm page table
  *
@@ -1177,16 +1188,16 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			   struct ttm_resource *res, dma_addr_t *pages_addr,
 			   struct dma_fence **fence)
 {
-	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_res_cursor cursor;
+	struct dma_fence_chain *chain;
 	int r, idx;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return -ENODEV;
 
-	tlb_cb = kmalloc_obj(*tlb_cb);
-	if (!tlb_cb) {
+	chain = dma_fence_chain_alloc();
+	if (!chain) {
 		drm_dev_exit(idx);
 		return -ENOMEM;
 	}
@@ -1291,14 +1302,14 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		goto error_free;
 
 	if (params.needs_flush) {
-		amdgpu_vm_tlb_flush(&params, *fence, tlb_cb);
-		tlb_cb = NULL;
+		amdgpu_vm_tlb_flush(&params, chain, *fence);
+		chain = NULL;
 	}
 
 	amdgpu_vm_pt_free_list(adev, &params);
 
 error_free:
-	kfree(tlb_cb);
+	dma_fence_chain_free(chain);
 	amdgpu_vm_end_critical(&params);
 	drm_dev_exit(idx);
 	return r;
@@ -2863,7 +2874,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	struct amdgpu_bo_va_mapping *mapping, *tmp;
 	bool prt_fini_needed = !!adev->gmc.gmc_funcs->set_prt;
 	struct amdgpu_bo *root;
-	unsigned long flags;
 	int i;
 
 	amdgpu_amdkfd_gpuvm_destroy_cb(adev, vm);
@@ -2876,10 +2886,6 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 				      false, MAX_SCHEDULE_TIMEOUT);
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
-	dma_fence_wait(vm->last_seq_flush, false);
-	/* Make sure that all fence callbacks have completed */
-	dma_fence_lock_irqsave(vm->last_seq_flush, flags);
-	dma_fence_unlock_irqrestore(vm->last_seq_flush, flags);
 	dma_fence_put(vm->last_seq_flush);
 	dma_fence_put(vm->last_tlb_inv);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index f6285a9d9e989..452409e95a5ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -329,8 +329,8 @@ struct amdgpu_vm {
 	struct drm_sched_entity	delayed;
 
 	/* Last TLB seq/fence */
-	atomic64_t		tlb_seq;
-	struct dma_fence	*last_seq_flush;
+	u64			tlb_seq;
+	struct dma_fence __rcu	*last_seq_flush;
 	atomic64_t		kfd_last_flushed_seq;
 	uint64_t		tlb_fence_context;
 	struct dma_fence	*last_tlb_inv;
@@ -545,38 +545,12 @@ int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 
 bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *vm, struct amdgpu_bo *bo);
 
-/**
- * amdgpu_vm_tlb_seq - return tlb flush sequence number
- * @vm: the amdgpu_vm structure to query
- *
- * Returns the tlb flush sequence number which indicates that the VM TLBs needs
- * to be invalidated whenever the sequence number change.
- */
-static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
-{
-	unsigned long flags;
-	spinlock_t *lock;
-
-	/*
-	 * Workaround to stop racing between the fence signaling and handling
-	 * the cb. The lock is static after initially setting it up, just make
-	 * sure that the dma_fence structure isn't freed up.
-	 */
-	rcu_read_lock();
-	lock = dma_fence_spinlock(vm->last_seq_flush);
-	rcu_read_unlock();
-
-	spin_lock_irqsave(lock, flags);
-	spin_unlock_irqrestore(lock, flags);
-
-	return atomic64_read(&vm->tlb_seq);
-}
-
 void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 				  unsigned int pasid,
 				  uint64_t addr,
 				  uint32_t status,
 				  unsigned int vmhub);
+uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm);
 void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm,
 				struct dma_fence *dep,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index d03b9bbe20c7c..0510b68846909 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -122,8 +122,10 @@ static int amdgpu_vm_cpu_commit(struct amdgpu_vm_update_params *p,
 {
 	struct amdgpu_device *adev = p->adev;
 
-	if (p->needs_flush)
-		atomic64_inc(&p->vm->tlb_seq);
+	if (fence) {
+		dma_fence_put(*fence);
+		*fence = dma_fence_get_stub();
+	}
 
 	mb();
 	/* A reset flushed the HDP anyway, so that here can be skipped when a reset is ongoing */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index d3a5e8487419e..26af3d54895b1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -117,9 +117,6 @@ static int amdgpu_vm_sdma_commit(struct amdgpu_vm_update_params *p,
 	WARN_ON(ib->length_dw == 0);
 	amdgpu_ring_pad_ib(ring, ib);
 
-	if (p->needs_flush)
-		atomic64_inc(&p->vm->tlb_seq);
-
 	WARN_ON(ib->length_dw > p->num_dw_left);
 	f = amdgpu_job_submit(p->job);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
index 180e02de73e9b..06e0fe3ee18a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
@@ -112,7 +112,7 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
 	spin_lock_init(&f->lock);
 
 	dma_fence_init64(&f->base, &amdgpu_tlb_fence_ops, &f->lock,
-			 vm->tlb_fence_context, atomic64_read(&vm->tlb_seq));
+			 vm->tlb_fence_context, vm->tlb_seq);
 
 	/* TODO: We probably need a separate wq here */
 	dma_fence_get(&f->base);
-- 
2.43.0


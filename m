Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4230C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 13:50:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53FAF10EBD8;
	Thu, 17 Mar 2022 13:50:55 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 322F210EBD5
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 13:50:54 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id b24so6627305edu.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 06:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2KVekR8hSwiWLRBMnD26Xbhy4Fp/Trj2f9Lb4eKJtCk=;
 b=BfovckebHV/hCAbC8UYss4O+lFMRdzCU24whACvz4UF+KHDat1Sik3Ca123+2KKAD6
 51S25dA76X1Dzr/3MJd+PtqGqkp093y1L0OMFFe23UYxu5hBZ8OOlBy5UB0o3B7PjvFQ
 HwIgm56nQt5H8Beox+KwggAsulLezPPfc0STXn2L4ZwERxJXrgHCyAgkaRl4viAQQ8tw
 5RZlDgKasgrTxshRe9JGVeqq9xYI6bPITuyTjJY7bQnTE7Rc67ncybxa0/jYSTHywxzu
 2PKB0+HADaw8g7tmF1dPUzcYq0KFP+x+KWJXxRJHapCuXuoqSPO83xJ4X1tk56q+M4lt
 HvcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2KVekR8hSwiWLRBMnD26Xbhy4Fp/Trj2f9Lb4eKJtCk=;
 b=KGLOjdvBKAf54bwJ95QsUOwqUeEIqJyYuF6q9VfPzSyGFkJ+EHsLz3rOr3tjYlDewe
 mgG7lthpL5vfudGV/giqgNgS8DObE9Pa4n829RHEFD22MeQ9UHBajt/06TgRkOplREhl
 TbWIR+zl48AxXIqNMqDo8HeJ8Kip2wNGEApxHgj54Z0xPDsu8UV1cn9bQnMgbD1WnS1s
 O+fP8YTIxNkywR7VbpkzOj45QNJxXWxtlBdKGOFGRDd10z/iSUpjHutoue1VisNQzz6j
 /0NyRNyodBM7JXhcFomtVouRJS31I+WCq2z64lwwzEQc9yfBX4EBvz9q9H3y1sLUxaik
 ggaQ==
X-Gm-Message-State: AOAM532bX2fs0CmzrTKLkuWe5HyOi7W32nIn6NovvrBmeWghe8mfZsqi
 ZA45+oNTEAtWK60Eenemb90ItOswciU=
X-Google-Smtp-Source: ABdhPJx54ZHgkjGeDKQc6oXHmP5+xKAGAK/z0+Q7lz1ec2nptuskt/vQvKJUMlwMc1OwqVLvmmZ1iQ==
X-Received: by 2002:a05:6402:17c4:b0:415:ed36:52cb with SMTP id
 s4-20020a05640217c400b00415ed3652cbmr4489646edy.379.1647525052407; 
 Thu, 17 Mar 2022 06:50:52 -0700 (PDT)
Received: from able.fritz.box (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a056402254900b00416b0ec98b5sm2706721edb.45.2022.03.17.06.50.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Mar 2022 06:50:52 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Felix.Kuehling@amd.com
Subject: [PATCH 4/7] drm/amdgpu: rework TLB flushing
Date: Thu, 17 Mar 2022 14:50:41 +0100
Message-Id: <20220317135044.2099-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317135044.2099-1-christian.koenig@amd.com>
References: <20220317135044.2099-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Instead of tracking the VM updates through the dependencies just use a
sequence counter for page table updates which indicates the need to
flush the TLB.

This reduces the need to flush the TLB drastically.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c   |  8 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c  |  6 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c | 20 ---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h |  2 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c   | 56 ++++++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h   | 15 +++++++
 6 files changed, 75 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index e8a3078a85cc..2d4a89fb264e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -810,7 +810,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	r = amdgpu_sync_vm_fence(&p->job->sync, fpriv->prt_va->last_pt_update);
+	r = amdgpu_sync_fence(&p->job->sync, fpriv->prt_va->last_pt_update);
 	if (r)
 		return r;
 
@@ -821,7 +821,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		if (r)
 			return r;
 
-		r = amdgpu_sync_vm_fence(&p->job->sync, bo_va->last_pt_update);
+		r = amdgpu_sync_fence(&p->job->sync, bo_va->last_pt_update);
 		if (r)
 			return r;
 	}
@@ -840,7 +840,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		if (r)
 			return r;
 
-		r = amdgpu_sync_vm_fence(&p->job->sync, bo_va->last_pt_update);
+		r = amdgpu_sync_fence(&p->job->sync, bo_va->last_pt_update);
 		if (r)
 			return r;
 	}
@@ -853,7 +853,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	r = amdgpu_sync_vm_fence(&p->job->sync, vm->last_update);
+	r = amdgpu_sync_fence(&p->job->sync, vm->last_update);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index b05c5fcb168d..93be290fc327 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -277,7 +277,7 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 	unsigned vmhub = ring->funcs->vmhub;
 	uint64_t fence_context = adev->fence_context + ring->idx;
 	bool needs_flush = vm->use_cpu_for_update;
-	uint64_t updates = sync->last_vm_update;
+	uint64_t updates = amdgpu_vm_tlb_seq(vm);
 	int r;
 
 	*id = vm->reserved_vmid[vmhub];
@@ -338,7 +338,7 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
 	unsigned vmhub = ring->funcs->vmhub;
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	uint64_t fence_context = adev->fence_context + ring->idx;
-	uint64_t updates = sync->last_vm_update;
+	uint64_t updates = amdgpu_vm_tlb_seq(vm);
 	int r;
 
 	job->vm_needs_flush = vm->use_cpu_for_update;
@@ -426,7 +426,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 			if (r)
 				goto error;
 
-			id->flushed_updates = sync->last_vm_update;
+			id->flushed_updates = amdgpu_vm_tlb_seq(vm);
 			job->vm_needs_flush = true;
 		}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index bc5ab44c5830..ff9229819b79 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -51,7 +51,6 @@ static struct kmem_cache *amdgpu_sync_slab;
 void amdgpu_sync_create(struct amdgpu_sync *sync)
 {
 	hash_init(sync->fences);
-	sync->last_vm_update = 0;
 }
 
 /**
@@ -171,23 +170,6 @@ int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f)
 	return 0;
 }
 
-/**
- * amdgpu_sync_vm_fence - remember to sync to this VM fence
- *
- * @sync: sync object to add fence to
- * @fence: the VM fence to add
- *
- * Add the fence to the sync object and remember it as VM update.
- */
-int amdgpu_sync_vm_fence(struct amdgpu_sync *sync, struct dma_fence *fence)
-{
-	if (!fence)
-		return 0;
-
-	sync->last_vm_update = max(sync->last_vm_update, fence->seqno);
-	return amdgpu_sync_fence(sync, fence);
-}
-
 /* Determine based on the owner and mode if we should sync to a fence or not */
 static bool amdgpu_sync_test_fence(struct amdgpu_device *adev,
 				   enum amdgpu_sync_mode mode,
@@ -377,8 +359,6 @@ int amdgpu_sync_clone(struct amdgpu_sync *source, struct amdgpu_sync *clone)
 		}
 	}
 
-	clone->last_vm_update = source->last_vm_update;
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
index 876c1ee8869c..2d5c613cda10 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
@@ -43,12 +43,10 @@ enum amdgpu_sync_mode {
  */
 struct amdgpu_sync {
 	DECLARE_HASHTABLE(fences, 4);
-	uint64_t	last_vm_update;
 };
 
 void amdgpu_sync_create(struct amdgpu_sync *sync);
 int amdgpu_sync_fence(struct amdgpu_sync *sync, struct dma_fence *f);
-int amdgpu_sync_vm_fence(struct amdgpu_sync *sync, struct dma_fence *fence);
 int amdgpu_sync_resv(struct amdgpu_device *adev, struct amdgpu_sync *sync,
 		     struct dma_resv *resv, enum amdgpu_sync_mode mode,
 		     void *owner);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index accebbac2f29..a43302a86254 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -88,6 +88,21 @@ struct amdgpu_prt_cb {
 	struct dma_fence_cb cb;
 };
 
+/**
+ * amdgpu_vm_tlb_seq_cb - Helper to increment the TLB flush sequence
+ */
+struct amdgpu_vm_tlb_seq_cb {
+	/**
+	 * @vm: pointer to the amdgpu_vm structure to set the fence sequence on
+	 */
+	struct amdgpu_vm *vm;
+
+	/**
+	 * @cb: callback
+	 */
+	struct dma_fence_cb cb;
+};
+
 /**
  * amdgpu_vm_set_pasid - manage pasid and vm ptr mapping
  *
@@ -760,6 +775,23 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	return r;
 }
 
+/**
+ * amdgpu_vm_tlb_seq_cb - make sure to increment tlb sequence
+ * @fence: unused
+ * @cb: the callback structure
+ *
+ * Increments the tlb sequence to make sure that future CS execute a VM flush.
+ */
+static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
+				 struct dma_fence_cb *cb)
+{
+	struct amdgpu_vm_tlb_seq_cb *tlb_cb;
+
+	tlb_cb = container_of(cb, typeof(*tlb_cb), cb);
+	atomic64_inc(&tlb_cb->vm->tlb_seq);
+	kfree(tlb_cb);
+}
+
 /**
  * amdgpu_vm_bo_update_mapping - update a mapping in the vm page table
  *
@@ -795,6 +827,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 				bool *table_freed)
 {
 	struct amdgpu_vm_update_params params;
+	struct amdgpu_vm_tlb_seq_cb *tlb_cb;
 	struct amdgpu_res_cursor cursor;
 	enum amdgpu_sync_mode sync_mode;
 	int r, idx;
@@ -802,6 +835,12 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return -ENODEV;
 
+	tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
+	if (!tlb_cb) {
+		r = -ENOMEM;
+		goto error_unlock;
+	}
+
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
@@ -820,7 +859,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 	amdgpu_vm_eviction_lock(vm);
 	if (vm->evicting) {
 		r = -EBUSY;
-		goto error_unlock;
+		goto error_free;
 	}
 
 	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
@@ -833,7 +872,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 
 	r = vm->update_funcs->prepare(&params, resv, sync_mode);
 	if (r)
-		goto error_unlock;
+		goto error_free;
 
 	amdgpu_res_first(pages_addr ? NULL : res, offset,
 			 (last - start + 1) * AMDGPU_GPU_PAGE_SIZE, &cursor);
@@ -882,7 +921,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 		tmp = start + num_entries;
 		r = amdgpu_vm_ptes_update(&params, start, tmp, addr, flags);
 		if (r)
-			goto error_unlock;
+			goto error_free;
 
 		amdgpu_res_next(&cursor, num_entries * AMDGPU_GPU_PAGE_SIZE);
 		start = tmp;
@@ -890,9 +929,20 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 
 	r = vm->update_funcs->commit(&params, fence);
 
+	if (!unlocked && (!(flags & AMDGPU_PTE_VALID) || params.table_freed)) {
+		tlb_cb->vm = vm;
+		if (!*fence || dma_fence_add_callback(*fence, &tlb_cb->cb,
+						      amdgpu_vm_tlb_seq_cb))
+			amdgpu_vm_tlb_seq_cb(*fence, &tlb_cb->cb);
+		tlb_cb = NULL;
+	}
+
 	if (table_freed)
 		*table_freed = *table_freed || params.table_freed;
 
+error_free:
+	kfree(tlb_cb);
+
 error_unlock:
 	amdgpu_vm_eviction_unlock(vm);
 	drm_dev_exit(idx);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 1731681914f5..38a1eab1ff74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -284,6 +284,9 @@ struct amdgpu_vm {
 	struct drm_sched_entity	immediate;
 	struct drm_sched_entity	delayed;
 
+	/* Last finished delayed update */
+	atomic64_t		tlb_seq;
+
 	/* Last unlocked submission to the scheduler entities */
 	struct dma_fence	*last_unlocked;
 
@@ -478,4 +481,16 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
 #endif
 
+/**
+ * amdgpu_vm_tlb_seq - return tlb flush sequence number
+ * @vm: the amdgpu_vm structure to query
+ *
+ * Returns the tlb flush sequence number which indicates that the VM TLBs needs
+ * to be invalidated whenever the sequence number change.
+ */
+static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
+{
+	return atomic64_read(&vm->tlb_seq);
+}
+
 #endif
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA633CA600B
	for <amd-gfx@archiver.kernel.org>; Thu,  8 Oct 2026 12:42:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F64210E826;
	Thu,  8 Oct 2026 12:42:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="n4BUUAaQ";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0ACA10E826
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 Oct 2026 12:42:35 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-486e8faff03so1615744f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 Oct 2026 05:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791463354; x=1792068154; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=6hmRJqh77yfomwq4WlZheDzLCtxrTh3Ye4pSpYwbK8M=;
 b=n4BUUAaQN+//aiN89FPgGeRNrnyhSXNo+O/zNn3dPPcVMLHeefphgDci43zKr9EZUB
 Zb4xN6x9R7mps0HJ4vqO+5EfaZlLzvg4uBji8dFx5AuxBWl01qpWokJI5JsPCJkAV78e
 X05pkg0j3cLDdm4stcPXzE5CPQtrROIfXqWPeQr56li+Zew5YMC/w0JA6PlfOlCqdcEQ
 dHCZPknnKJbLFDV/LC0WE5BHCP1+HLcAc05d4aBe5R5QDDEqnLgbR9YSMZrOgC3pq3yV
 oFPDJSZQ/RNUenPExOqSS4voRcUSVCmw6kSakO9jnJgh+3sBXzWQpfxK2+XnFSC77+cp
 2DRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791463354; x=1792068154;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=6hmRJqh77yfomwq4WlZheDzLCtxrTh3Ye4pSpYwbK8M=;
 b=AuahCJATJeMwZewX9eTFXEwZaZiVeluKVDTVWGXE6N58EY2XYIeedCHWahqORYRa6E
 eIcxYdsAW63UJDefWgGbP8B92Ovim241+5Qn3wrm5dQ/WcTxM0ufhDweX81qLTp5p6qB
 o5BOa4v16voBnjRgfybapKhKB6dls7q5wJp7RuIwcVU5kuqveEA/2PfyRKnOJco/s32h
 Rh1sNN7FO+noPKwENbqGMDQu6p62RbFwcjc2WwFbkM8WXzwU3aEBsl8Q3h0eDItrHJ8u
 iF8oEybo7THJxvIkzJvVAN3dSADEHYkj7Nrsum+W+wsHKNTfaV7iS0f3ziOlqEl0TTZE
 xnaw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz5Cz6nb7fBv1cvqYBJsb4ODkct3AKs92YUosdpgrdxI1GA4ffo++Xv88OF+7MO6BaC1kfJNXgl@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJMwFVg+cj7kiz2cUJ5d34W+SIPYGTtTSpcxmJqFHDuH4Yij56q
 ByARoqsFK4XuA9Szpzh3QOV+eXLFx9GvfzouMVAqa41VO53+hOLNXTTi
X-Gm-Gg: AYBFou3YZO3Lw9XwqOD/Bv6//9h4XcIsEzRapxVeMxMWQ9MPZixPpOhMMpKIry5AqfE
 5WK3VyK1X6CtdA5TJVhb3/DZc4efZ8cfsO28eVAWZl879WX8a9lanoRPzinr5iSThhvf3yDDoBq
 JZMtTDtKdBfaa4whllXlG4LDHe03afm+VnttFcW1e6Gc+V0hKiPygIC8EA2hEN6nkewCjRn0xX6
 egB+ed/AT3TQlVwdJCRqLieAiRuLneOOygElHwel+VsjFljoQ0+sC1r0r4uyaiNp4qrxDvExgHt
 Vg1BfncSSPAWdWJKpM5B/pMJEApWsB8RGjNr7zt8w/m3U3OBvFvDMCaEQeR4D3GWt9Yc7Bm0bIb
 SILqSr9OdqN8OWifaDVKQIBuJ3CY65jvluS9Lvitu0Pr/AEj1v9zKArAPj4kyi8p2/25/6GLeVg
 Er2GyVuDWVAjHOvG9he/biGRKohl+zV7PFrUULo8KHEsJyEd8rVUTomElw6Y11PIdHxYQK75tdT
 gH4UCDGZKY=
X-Received: by 2002:adf:e19c:0:b0:48c:4f94:2214 with SMTP id
 ffacd0b85a97d-48c726fcc83mr9763763f8f.3.1791463354077; 
 Thu, 08 Oct 2026 05:42:34 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1523:b100:15b6:8c15:549d:fc54])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71d13a01sm12412021f8f.29.2026.10.08.05.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Oct 2026 05:42:33 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: David.YatSin@amd.com, amd-gfx@lists.freedesktop.org, Sunil.Khatri@amd.com,
 natalie.vock@gmx.de, Bincy.Mani@amd.com, cursoragent@cursor.com
Subject: [PATCH] drm/amdgpu: fix TLB invalidation fence handling
Date: Thu,  8 Oct 2026 14:42:32 +0200
Message-ID: <20261008124232.23825-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
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
Reply-To: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

After each unmap it might be necessary to invalidate the TLB to flush out
VM changes to the HW and make it visible to executing work.

We tracked that as part of the vm->last_update fence, but as pointed out
by David it can be that this is overwritten by PDE updates when we have a
combined unmap/map operation.

In that case userspace doesn't correctly wait for the TLB invalidation to
finish leading to all kind of problems (sq_int, page faults etc...).

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 20 ++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 39 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        | 13 ++++---
 .../gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c  | 21 +++++++---
 4 files changed, 55 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 374f1322c3ee4..606725d0eb155 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -843,18 +843,24 @@ amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 		/*
 		 * For MAP/REPLACE of non per-VM BOs we need to sync to both the
 		 * bo_va->last_pt_update and vm->last_update or otherwise we
-		 * potentially miss the PDE updates.
+		 * potentially miss the PDE updates or TLB invalidation.
 		 */
 		fence = dma_fence_unwrap_merge(vm->last_update,
+					       vm->last_tlb_inv,
 					       bo_va->last_pt_update);
-		if (!fence) {
-			/* As fallback in OOM situations */
-			dma_fence_wait(vm->last_update, false);
+		if (!fence)
 			dma_fence_wait(bo_va->last_pt_update, false);
-			fence = dma_fence_get_stub();
-		}
+
 	} else {
-		fence = dma_fence_get(vm->last_update);
+		fence = dma_fence_unwrap_merge(vm->last_update,
+					       vm->last_tlb_inv);
+	}
+
+	if (!fence) {
+		/* As fallback in OOM situations */
+		dma_fence_wait(vm->last_update, false);
+		dma_fence_wait(vm->last_tlb_inv, false);
+		fence = dma_fence_get_stub();
 	}
 
 	return fence;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 7d3659ef11e53..f124320345ec4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1071,21 +1071,16 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
  */
 static void
 amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
-		    struct dma_fence **fence,
+		    struct dma_fence *fence,
 		    struct amdgpu_vm_tlb_seq_struct *tlb_cb)
 {
 	struct amdgpu_vm *vm = params->vm;
 
 	tlb_cb->vm = vm;
-	if (!fence || !*fence) {
-		amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
-		return;
-	}
-
-	if (!dma_fence_add_callback(*fence, &tlb_cb->cb,
-				    amdgpu_vm_tlb_seq_cb)) {
-		dma_fence_put(vm->last_tlb_flush);
-		vm->last_tlb_flush = dma_fence_get(*fence);
+	if (!fence || !dma_fence_add_callback(fence, &tlb_cb->cb,
+					      amdgpu_vm_tlb_seq_cb)) {
+		dma_fence_put(vm->last_seq_flush);
+		vm->last_seq_flush = dma_fence_get(fence);
 	} else {
 		amdgpu_vm_tlb_seq_cb(NULL, &tlb_cb->cb);
 	}
@@ -1095,11 +1090,12 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 	 * sort out the issues with KIQ/MES TLB invalidation timeouts.
 	 */
 	if (!params->unlocked && vm->need_tlb_fence) {
-		amdgpu_vm_tlb_fence_create(params->adev, vm, fence);
+		amdgpu_vm_tlb_fence_create(params->adev, vm, fence,
+					   &vm->last_tlb_inv);
 
 		/* Makes sure no PD/PT is freed before the flush */
-		dma_resv_add_fence(vm->root.bo->tbo.base.resv, *fence,
-				   DMA_RESV_USAGE_BOOKKEEP);
+		dma_resv_add_fence(vm->root.bo->tbo.base.resv,
+				   vm->last_tlb_inv, DMA_RESV_USAGE_BOOKKEEP);
 	}
 }
 
@@ -1248,7 +1244,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		goto error_free;
 
 	if (params.needs_flush) {
-		amdgpu_vm_tlb_flush(&params, fence, tlb_cb);
+		amdgpu_vm_tlb_flush(&params, *fence, tlb_cb);
 		tlb_cb = NULL;
 	}
 
@@ -2647,7 +2643,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	vm->last_update = dma_fence_get_stub();
 	vm->last_unlocked = dma_fence_get_stub();
-	vm->last_tlb_flush = dma_fence_get_stub();
+	vm->last_seq_flush = dma_fence_get_stub();
+	vm->last_tlb_inv = dma_fence_get_stub();
 	vm->generation = amdgpu_vm_generation(adev, NULL);
 
 	mutex_init(&vm->eviction_lock);
@@ -2691,7 +2688,8 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 error_free_delayed:
 	dma_fence_put(vm->last_update);
-	dma_fence_put(vm->last_tlb_flush);
+	dma_fence_put(vm->last_seq_flush);
+	dma_fence_put(vm->last_tlb_inv);
 	dma_fence_put(vm->last_unlocked);
 	ttm_lru_bulk_move_fini(&adev->mman.bdev, &vm->lru_bulk_move);
 	amdgpu_vm_fini_entities(vm);
@@ -2834,11 +2832,12 @@ void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm)
 	amdgpu_bo_reserve(root, true);
 	dma_fence_wait(vm->last_unlocked, false);
 	dma_fence_put(vm->last_unlocked);
-	dma_fence_wait(vm->last_tlb_flush, false);
+	dma_fence_wait(vm->last_seq_flush, false);
 	/* Make sure that all fence callbacks have completed */
-	dma_fence_lock_irqsave(vm->last_tlb_flush, flags);
-	dma_fence_unlock_irqrestore(vm->last_tlb_flush, flags);
-	dma_fence_put(vm->last_tlb_flush);
+	dma_fence_lock_irqsave(vm->last_seq_flush, flags);
+	dma_fence_unlock_irqrestore(vm->last_seq_flush, flags);
+	dma_fence_put(vm->last_seq_flush);
+	dma_fence_put(vm->last_tlb_inv);
 
 	list_for_each_entry_safe(mapping, tmp, &vm->freed, list) {
 		if (mapping->flags & AMDGPU_VM_PAGE_PRT && prt_fini_needed) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 8e478d3bda1ac..713a597027bbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -328,11 +328,12 @@ struct amdgpu_vm {
 	struct drm_sched_entity	immediate;
 	struct drm_sched_entity	delayed;
 
-	/* Last finished delayed update */
+	/* Last TLB seq/fence */
 	atomic64_t		tlb_seq;
-	struct dma_fence	*last_tlb_flush;
+	struct dma_fence	*last_seq_flush;
 	atomic64_t		kfd_last_flushed_seq;
 	uint64_t		tlb_fence_context;
+	struct dma_fence	*last_tlb_inv;
 
 	/* How many times we had to re-generate the page tables */
 	uint64_t		generation;
@@ -561,7 +562,7 @@ static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
 	 * sure that the dma_fence structure isn't freed up.
 	 */
 	rcu_read_lock();
-	lock = dma_fence_spinlock(vm->last_tlb_flush);
+	lock = dma_fence_spinlock(vm->last_seq_flush);
 	rcu_read_unlock();
 
 	spin_lock_irqsave(lock, flags);
@@ -576,9 +577,9 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 				  uint32_t status,
 				  unsigned int vmhub);
 void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
-				 struct amdgpu_vm *vm,
-				 struct dma_fence **fence);
-
+				struct amdgpu_vm *vm,
+				struct dma_fence *dep,
+				struct dma_fence **fence);
 void amdgpu_vm_print_task_info(struct amdgpu_device *adev,
 			       struct amdgpu_task_info *task_info);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
index b0002c8983861..c91417e4df4ed 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_tlb_fence.c
@@ -75,7 +75,19 @@ static const struct dma_fence_ops amdgpu_tlb_fence_ops = {
 	.get_timeline_name = amdgpu_tlb_fence_get_timeline_name
 };
 
-void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+/**
+ * amdgpu_vm_tlb_fence_create - create a TLB invalidation fence
+ * @adev: the amdgpu device
+ * @vm: the vm to use
+ * @dep: the dependency to wait for
+ * @fence: the resulting fence
+ *
+ * Creates a TLB invalidation fence which signals when all the VMIDs assigned to
+ * the PASID of the VM are invalidated.
+ */
+void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev,
+				struct amdgpu_vm *vm,
+				struct dma_fence *dep,
 				struct dma_fence **fence)
 {
 	struct amdgpu_tlb_fence *f;
@@ -86,16 +98,15 @@ void amdgpu_vm_tlb_fence_create(struct amdgpu_device *adev, struct amdgpu_vm *vm
 		 * We can't fail since the PDEs and PTEs are already updated, so
 		 * just block for the dependency and execute the TLB flush
 		 */
-		if (*fence)
-			dma_fence_wait(*fence, false);
+		if (dep)
+			dma_fence_wait(dep, false);
 
 		amdgpu_gmc_flush_gpu_tlb_pasid(adev, vm->pasid, 2, true, 0);
-		*fence = dma_fence_get_stub();
 		return;
 	}
 
 	f->adev = adev;
-	f->dependency = *fence;
+	f->dependency = dma_fence_get(dep);
 	f->pasid = vm->pasid;
 	INIT_WORK(&f->work, amdgpu_tlb_fence_work);
 	spin_lock_init(&f->lock);
-- 
2.43.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416AAC433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Mar 2022 09:00:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A60B110F6D8;
	Wed, 30 Mar 2022 09:00:37 +0000 (UTC)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E63510F6D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Mar 2022 09:00:36 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id d7so28252869wrb.7
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Mar 2022 02:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zRBH5YhI3pTWZyJdkujBppFJNyvyu2DV+eTxJBnUhCk=;
 b=njBEWqVQA2IEIUgn/rFUGOipBXXMKnm/l8dfXgmGu4qhu6kLX+mwDvzhqCZ2TQXnji
 iNUerypiZ/sXq/hkgYyQQtlc93yEaAaRXbhqsBCo5VCxOIVD1atzIR3M8eGus6X1SLN8
 QPwXncoDcsKV5EnoqP/5rrf+p2ozps1+fhujqNBVElp60hJu1Ezn2CsVknc3XR7IWR07
 a7fN3puXs9IADCcImjRlQlRgBEg1DLugFtC3NNQCa0pSdyz0kevA2xtkv70LHZ6XMPh3
 uwnydsACOWkFvdfSIRCoF4k7d4A4j5HDO04KQL3SVGmRZDmD9fMW0mJyB0pJn3gBwhj4
 DhyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=zRBH5YhI3pTWZyJdkujBppFJNyvyu2DV+eTxJBnUhCk=;
 b=J7a9cvko003vAxhqBlSG2r/7QgYS/k+8bCNJA9H5apm3Ez8J+PtZvZgqlctVjbH+be
 xH5v3vJqsLBaaJqRruIgV5FtiWWzOUmL6X3ehD74XvI8J3X5l5lKF6QTa7XpSQ6W4Dni
 CK7pOlE2lKFgLPIeTfj/3QP4xMVdPeDWUSzdUetdATajSiCNsbpJIIJNyW5OlVLJ8H1J
 Ns9IDcwpPvlSZJpcrGhXUtKOqWSgLq+J6hLN6HDMQtLClGCXqAqA5KXLMMkEgJA0nV9u
 UVseiPh9dGjIw413KCU5ZbfThwBSj8nk4lDRJft6K3vaPrjPjBqtxVRhfDmFNZAqbTEu
 Sy+w==
X-Gm-Message-State: AOAM531DFk8qw8d5WF4i6mukqACvvslr5VtNLS0YBdtIxNlpYSrUdq10
 Tht4nEYgmNv32ShI5TZqQh8RfeZBs34=
X-Google-Smtp-Source: ABdhPJzqUaEbL0vPkniAmOm9b1SkuQtrVWsrJJbCvQNCvEc+X0XBWrLirl8kpkT9LYENCvh5PlO6wQ==
X-Received: by 2002:adf:ba47:0:b0:203:e8d3:22e1 with SMTP id
 t7-20020adfba47000000b00203e8d322e1mr34587498wrg.412.1648630834676; 
 Wed, 30 Mar 2022 02:00:34 -0700 (PDT)
Received: from able.fritz.box (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a5d4141000000b00205d3d37dcdsm3017757wrq.103.2022.03.30.02.00.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Mar 2022 02:00:33 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, Philip.Yang@amd.com, felix.kuehling@amd.com
Subject: [PATCH] drm/amdgpu: fix TLB flushing during eviction
Date: Wed, 30 Mar 2022 11:00:32 +0200
Message-Id: <20220330090032.16218-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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

Testing the valid bit is not enough to figure out if we
need to invalidate the TLB or not.

During eviction it is quite likely that we move a BO from VRAM to GTT and
update the page tables immediately to the new GTT address.

Rework the whole function to get all the necessary parameters directly as
value.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 63 ++++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h | 15 +++---
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c   | 18 ++++----
 3 files changed, 48 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 9992a7311387..1cac90ee3318 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -793,18 +793,19 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
 }
 
 /**
- * amdgpu_vm_bo_update_mapping - update a mapping in the vm page table
+ * amdgpu_vm_update_range - update a range in the vm page table
  *
- * @adev: amdgpu_device pointer of the VM
- * @bo_adev: amdgpu_device pointer of the mapped BO
- * @vm: requested vm
+ * @adev: amdgpu_device pointer to use for commands
+ * @vm: the VM to update the range
  * @immediate: immediate submission in a page fault
  * @unlocked: unlocked invalidation during MM callback
+ * @flush_tlb: trigger tlb invalidation after update completed
  * @resv: fences we need to sync to
  * @start: start of mapped range
  * @last: last mapped entry
  * @flags: flags for the entries
  * @offset: offset into nodes and pages_addr
+ * @vram_base: base for vram mappings
  * @res: ttm_resource to map
  * @pages_addr: DMA addresses to use for mapping
  * @fence: optional resulting fence
@@ -812,17 +813,14 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
  * Fill in the page table entries between @start and @last.
  *
  * Returns:
- * 0 for success, -EINVAL for failure.
+ * 0 for success, negative erro code for failure.
  */
-int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
-				struct amdgpu_device *bo_adev,
-				struct amdgpu_vm *vm, bool immediate,
-				bool unlocked, struct dma_resv *resv,
-				uint64_t start, uint64_t last,
-				uint64_t flags, uint64_t offset,
-				struct ttm_resource *res,
-				dma_addr_t *pages_addr,
-				struct dma_fence **fence)
+int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			   bool immediate, bool unlocked, bool flush_tlb,
+			   struct dma_resv *resv, uint64_t start, uint64_t last,
+			   uint64_t flags, uint64_t offset, uint64_t vram_base,
+			   struct ttm_resource *res, dma_addr_t *pages_addr,
+			   struct dma_fence **fence)
 {
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_vm_tlb_seq_cb *tlb_cb;
@@ -910,8 +908,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 			}
 
 		} else if (flags & (AMDGPU_PTE_VALID | AMDGPU_PTE_PRT)) {
-			addr = bo_adev->vm_manager.vram_base_offset +
-				cursor.start;
+			addr = vram_base + cursor.start;
 		} else {
 			addr = 0;
 		}
@@ -927,7 +924,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 
 	r = vm->update_funcs->commit(&params, fence);
 
-	if (!(flags & AMDGPU_PTE_VALID) || params.table_freed) {
+	if (flush_tlb || params.table_freed) {
 		tlb_cb->vm = vm;
 		if (!fence || !*fence ||
 		    dma_fence_add_callback(*fence, &tlb_cb->cb,
@@ -1010,9 +1007,10 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 	dma_addr_t *pages_addr = NULL;
 	struct ttm_resource *mem;
 	struct dma_fence **last_update;
+	bool flush_tlb = clear;
 	struct dma_resv *resv;
+	uint64_t vram_base;
 	uint64_t flags;
-	struct amdgpu_device *bo_adev = adev;
 	int r;
 
 	if (clear || !bo) {
@@ -1037,14 +1035,18 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 	}
 
 	if (bo) {
+		struct amdgpu_device *bo_adev = adev;
+
 		flags = amdgpu_ttm_tt_pte_flags(adev, bo->tbo.ttm, mem);
 
 		if (amdgpu_bo_encrypted(bo))
 			flags |= AMDGPU_PTE_TMZ;
 
 		bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
+		vram_base = bo_adev->vm_manager.vram_base_offset;
 	} else {
 		flags = 0x0;
+		vram_base = 0;
 	}
 
 	if (clear || (bo && bo->tbo.base.resv ==
@@ -1054,7 +1056,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 		last_update = &bo_va->last_pt_update;
 
 	if (!clear && bo_va->base.moved) {
-		bo_va->base.moved = false;
+		flush_tlb = true;
 		list_splice_init(&bo_va->valids, &bo_va->invalids);
 
 	} else if (bo_va->cleared != clear) {
@@ -1077,11 +1079,11 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 
 		trace_amdgpu_vm_bo_update(mapping);
 
-		r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, false, false,
-						resv, mapping->start,
-						mapping->last, update_flags,
-						mapping->offset, mem,
-						pages_addr, last_update);
+		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb,
+					   resv, mapping->start, mapping->last,
+					   update_flags, mapping->offset,
+					   vram_base, mem, pages_addr,
+					   last_update);
 		if (r)
 			return r;
 	}
@@ -1104,6 +1106,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 
 	list_splice_init(&bo_va->invalids, &bo_va->valids);
 	bo_va->cleared = clear;
+	bo_va->base.moved = false;
 
 	if (trace_amdgpu_vm_bo_mapping_enabled()) {
 		list_for_each_entry(mapping, &bo_va->valids, list)
@@ -1272,10 +1275,10 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 		    mapping->start < AMDGPU_GMC_HOLE_START)
 			init_pte_value = AMDGPU_PTE_DEFAULT_ATC;
 
-		r = amdgpu_vm_bo_update_mapping(adev, adev, vm, false, false,
-						resv, mapping->start,
-						mapping->last, init_pte_value,
-						0, NULL, NULL, &f);
+		r = amdgpu_vm_update_range(adev, vm, false, false, true, resv,
+					   mapping->start, mapping->last,
+					   init_pte_value, 0, 0, NULL, NULL,
+					   &f);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
 			dma_fence_put(f);
@@ -2519,8 +2522,8 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		goto error_unlock;
 	}
 
-	r = amdgpu_vm_bo_update_mapping(adev, adev, vm, true, false, NULL, addr,
-					addr, flags, value, NULL, NULL, NULL);
+	r = amdgpu_vm_update_range(adev, vm, true, false, false, NULL, addr,
+				   addr, flags, value, 0, NULL, NULL, NULL);
 	if (r)
 		goto error_unlock;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 6b7682fe84f8..1a814fbffff8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -402,15 +402,12 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 			   struct amdgpu_vm *vm);
 void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 			    struct amdgpu_vm *vm, struct amdgpu_bo *bo);
-int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
-				struct amdgpu_device *bo_adev,
-				struct amdgpu_vm *vm, bool immediate,
-				bool unlocked, struct dma_resv *resv,
-				uint64_t start, uint64_t last,
-				uint64_t flags, uint64_t offset,
-				struct ttm_resource *res,
-				dma_addr_t *pages_addr,
-				struct dma_fence **fence);
+int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			   bool immediate, bool unlocked, bool flush_tlb,
+			   struct dma_resv *resv, uint64_t start, uint64_t last,
+			   uint64_t flags, uint64_t offset, uint64_t vram_base,
+			   struct ttm_resource *res, dma_addr_t *pages_addr,
+			   struct dma_fence **fence);
 int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
 			bool clear);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 27533f6057e0..907b02045824 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1188,9 +1188,9 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	pr_debug("[0x%llx 0x%llx]\n", start, last);
 
-	return amdgpu_vm_bo_update_mapping(adev, adev, vm, false, true, NULL,
-					   start, last, init_pte_value, 0,
-					   NULL, NULL, fence);
+	return amdgpu_vm_update_range(adev, vm, false, true, true, NULL, start,
+				      last, init_pte_value, 0, 0, NULL, NULL,
+				      fence);
 }
 
 static int
@@ -1277,12 +1277,12 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 			 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
 			 pte_flags);
 
-		r = amdgpu_vm_bo_update_mapping(adev, bo_adev, vm, false, false,
-						NULL, last_start,
-						prange->start + i, pte_flags,
-						last_start - prange->start,
-						NULL, dma_addr,
-						&vm->last_update);
+		r = amdgpu_vm_update_range(adev, vm, false, false, false, NULL,
+					   last_start, prange->start + i,
+					   pte_flags,
+					   last_start - prange->start,
+					   bo_adev->vm_manager.vram_base_offset,
+					   NULL, dma_addr, &vm->last_update);
 
 		for (j = last_start - prange->start; j <= i; j++)
 			dma_addr[j] |= last_domain;
-- 
2.25.1


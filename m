Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 309FACD6E43
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 11:40:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3B1710FDD4;
	Fri, 29 May 2026 11:40:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hKDnuLwg";
	dkim-atps=neutral
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCE9D10FDC7
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 11:40:53 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-bdbcc6c4500so1312324966b.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 04:40:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780054852; x=1780659652; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=c5/e5KNB7Ioy6F55LrTopq/inidNvFaTGk8fsh4NOHM=;
 b=hKDnuLwgkYDhPAYasQJgW6ek/1q7y9jPqZLXtETzxFP1iCPmNuEYXqClNVAdxUJjVC
 Xj0b/zfgP2YsiMoPnfza9ik0QmJuUfuJu6H2rjd3tEQeoccFtlHVobT5YfHqE4HalHE/
 kYyaqeon3CjYYNSDmFUEhjcyrhJFTmOz01dru1qlnY/+27W3Rn3XiA7/UQWnqsLB3vxU
 02ANXTRvsPqj2IxhzGjW6VmoU6MZL2bLwFRJfl+O1mNSP5paWQfnSf1AW3UDLIGaTqsL
 0KKOI4VwYLft1L1bYKcSOWN1cY4d7nqPK+9KHCAKzsl7IJ+SeVpFMxrCK+lnZdGGWu6U
 89MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780054852; x=1780659652;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=c5/e5KNB7Ioy6F55LrTopq/inidNvFaTGk8fsh4NOHM=;
 b=sIPZKPX91mquhS4Aj6QI8RfZQi3q9WWwfTl7ucWUBjeRAnBQkL9ECobP1Mm5kNFK8z
 4LrX4jEjXdbtQlCuAO3LFbT9AERP/kPeLKiZtE8Ptx3X6KL/kslrl2NHbiaJmd8520c7
 ho632Q1lwUMLGNKInkFW/TxpdddoEqLg1KMuHJxGQfQmMWrRA0ff/pyXghJuTCXh06SJ
 VSMgfeII1Ti6rLjGn9wqgyDlPRKWgxmTziDJ5t5qcPo1xcQvk1lFi3/2cfg43weofOaa
 6+bBkUAxJSZvcanXxafm37X499nPZQgoT4qO06BBI+gLs0vx6SLS4MLn8pqbVc+Ru/yu
 magA==
X-Gm-Message-State: AOJu0YxFNzH2JujE95VuFG9E6vJ6iz2Kz0uZu0jA+grbjJYg3AvTuR7U
 EdaytAxPcclhpjGR/Eb3FIwR2TK0hw7Z92/8q2/VToraDjJ2ik+PhMU1FJXG1QLJv14=
X-Gm-Gg: Acq92OEMp6KuPbhPuhQ6tJuGiDvNH/FYF4jjnDSQaaIa8e1/AnBJ9KWINEiJKCiRK1a
 5gYZjK1b7r1n2ObykZD2kJk/FwL3OKrgtziePTOvHz5BNOkj5sD7+O2diZ4Fn2+DqdzNRdGdq0u
 BoKB7bh3cwQGVBGXzNVWEB3RJvrsYaOaBOVO0mOxKEadFLqXFSZbmbLNuPeBU0HP2lwuYtEAoxz
 sopP//w5zBj31Qy1QJCrcfjfERQs7/WJdMmKM5DiZwLmLx/npjeTIiE1112BGx7nRbysyC1lHkA
 +Iwq51JNwriSLCR/hWZDqLvDtiYLaQ69sjwIbd+moN/CA/+0mufcnDS9v57U7lmbPmsv7pPV8Vi
 TIoomXBeWXjArtF7gnB5i9o4/sbawZSHXWAqAmIjh4yJfRNGM1Gz2cAcUBsvXA25EJXWAHJoVuV
 m9Pt8XUVptpbjSjFfklNM5EnrvjbMANuG6cdr9lCHP9s0=
X-Received: by 2002:a5d:5484:0:b0:45e:93ac:769e with SMTP id
 ffacd0b85a97d-45ef1419bcbmr3308559f8f.6.1780054841196; 
 Fri, 29 May 2026 04:40:41 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1544:8100:da55:fa26:bd:a26])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cf0dsm2993109f8f.17.2026.05.29.04.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:40:40 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/13] drm/amdgpu: drop immediate updates from
 amdgpu_vm_update_range
Date: Fri, 29 May 2026 13:24:09 +0200
Message-ID: <20260529114031.3714-8-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114031.3714-1-christian.koenig@amd.com>
References: <20260529114031.3714-1-christian.koenig@amd.com>
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

That case is handled by amdgpu_vm_update_leaves now.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 21 +++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    | 16 +++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c | 19 ++++++-------------
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c      |  4 ++--
 4 files changed, 24 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 94632a660b79..edc8b1ca2d3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1084,7 +1084,6 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
  *
  * @adev: amdgpu_device pointer to use for commands
  * @vm: the VM to update the range
- * @immediate: immediate submission in a page fault
  * @unlocked: unlocked invalidation during MM callback
  * @flush_tlb: trigger tlb invalidation after update completed
  * @allow_override: change MTYPE for local NUMA nodes
@@ -1104,12 +1103,11 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
  * 0 for success, negative erro code for failure.
  */
 int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			   bool immediate, bool unlocked, bool flush_tlb,
-			   bool allow_override, struct amdgpu_sync *sync,
-			   uint64_t start, uint64_t last, uint64_t flags,
-			   uint64_t offset, uint64_t vram_base,
-			   struct ttm_resource *res, dma_addr_t *pages_addr,
-			   struct dma_fence **fence)
+			   bool unlocked, bool flush_tlb, bool allow_override,
+			   struct amdgpu_sync *sync, uint64_t start,
+			   uint64_t last, uint64_t flags, uint64_t offset,
+			   uint64_t vram_base, struct ttm_resource *res,
+			   dma_addr_t *pages_addr, struct dma_fence **fence)
 {
 	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
 	struct amdgpu_vm_update_params params;
@@ -1139,7 +1137,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
-	params.immediate = immediate;
 	params.pages_addr = pages_addr;
 	params.unlocked = unlocked;
 	params.needs_flush = flush_tlb;
@@ -1365,7 +1362,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 
 		trace_amdgpu_vm_bo_update(mapping);
 
-		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb,
+		r = amdgpu_vm_update_range(adev, vm, false, flush_tlb,
 					   !uncached, &sync, mapping->start,
 					   mapping->last, update_flags,
 					   mapping->offset, vram_base, mem,
@@ -1568,7 +1565,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 			struct amdgpu_bo_va_mapping, list);
 		list_del(&mapping->list);
 
-		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
+		r = amdgpu_vm_update_range(adev, vm, false, true, false,
 					   &sync, mapping->start, mapping->last,
 					   0, 0, 0, NULL, NULL, &f);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
@@ -2617,7 +2614,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->tlb_fence_context = dma_fence_context_alloc(1);
 
 	r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
-				false, &root, xcp_id);
+				&root, xcp_id);
 	if (r)
 		goto error_free_delayed;
 
@@ -2633,7 +2630,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_free_root;
 
-	r = amdgpu_vm_pt_clear(adev, vm, root, false);
+	r = amdgpu_vm_pt_clear(adev, vm, root);
 	if (r)
 		goto error_free_root;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 04b32accfa3f..3e86a2a470f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -530,12 +530,11 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
 void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 			    struct amdgpu_vm *vm, struct amdgpu_bo *bo);
 int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			   bool immediate, bool unlocked, bool flush_tlb,
-			   bool allow_override, struct amdgpu_sync *sync,
-			   uint64_t start, uint64_t last, uint64_t flags,
-			   uint64_t offset, uint64_t vram_base,
-			   struct ttm_resource *res, dma_addr_t *pages_addr,
-			   struct dma_fence **fence);
+			   bool unlocked, bool flush_tlb, bool allow_override,
+			   struct amdgpu_sync *sync, uint64_t start,
+			   uint64_t last, uint64_t flags, uint64_t offset,
+			   uint64_t vram_base, struct ttm_resource *res,
+			   dma_addr_t *pages_addr, struct dma_fence **fence);
 int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
 			bool clear);
@@ -602,10 +601,9 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
 			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM]);
 
 int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		       struct amdgpu_bo_vm *vmbo, bool immediate);
+		       struct amdgpu_bo_vm *vmbo);
 int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			int level, bool immediate, struct amdgpu_bo_vm **vmbo,
-			int32_t xcp_id);
+			int level, struct amdgpu_bo_vm **vmbo, int32_t xcp_id);
 void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 
 int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 9766b6b9aecc..6f5415d5a1bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -351,7 +351,6 @@ static void amdgpu_vm_pt_next_dfs(struct amdgpu_device *adev,
  * @adev: amdgpu_device pointer
  * @vm: VM to clear BO from
  * @vmbo: BO to clear
- * @immediate: use an immediate update
  *
  * Root PD needs to be reserved when calling this.
  *
@@ -359,7 +358,7 @@ static void amdgpu_vm_pt_next_dfs(struct amdgpu_device *adev,
  * 0 on success, errno otherwise.
  */
 int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		       struct amdgpu_bo_vm *vmbo, bool immediate)
+		       struct amdgpu_bo_vm *vmbo)
 {
 	unsigned int level = adev->vm_manager.root_level;
 	struct ttm_operation_ctx ctx = { true, false };
@@ -396,7 +395,6 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
-	params.immediate = immediate;
 
 	r = vm->update_funcs->prepare(&params, NULL,
 				      AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR);
@@ -434,13 +432,11 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  * @adev: amdgpu_device pointer
  * @vm: requesting vm
  * @level: the page table level
- * @immediate: use a immediate update
  * @vmbo: pointer to the buffer object pointer
  * @xcp_id: GPU partition id
  */
 int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			int level, bool immediate, struct amdgpu_bo_vm **vmbo,
-			int32_t xcp_id)
+			int level, struct amdgpu_bo_vm **vmbo, int32_t xcp_id)
 {
 	struct amdgpu_bo_param bp;
 	unsigned int num_entries;
@@ -470,7 +466,6 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		bp.flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 
 	bp.type = ttm_bo_type_kernel;
-	bp.no_wait_gpu = immediate;
 	bp.xcp_id_plus1 = xcp_id + 1;
 
 	if (vm->root.bo)
@@ -485,7 +480,6 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  * @adev: amdgpu_device pointer
  * @vm: VM to allocate page tables for
  * @cursor: Which page table to allocate
- * @immediate: use an immediate update
  *
  * Make sure a specific page table or directory is allocated.
  *
@@ -495,8 +489,7 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
  */
 static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
 			      struct amdgpu_vm *vm,
-			      struct amdgpu_vm_pt_cursor *cursor,
-			      bool immediate)
+			      struct amdgpu_vm_pt_cursor *cursor)
 {
 	struct amdgpu_vm_bo_base *entry = cursor->entry;
 	struct amdgpu_bo *pt_bo;
@@ -507,7 +500,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
 		return 0;
 
 	amdgpu_vm_eviction_unlock(vm);
-	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt,
+	r = amdgpu_vm_pt_create(adev, vm, cursor->level, &pt,
 				vm->root.bo->xcp_id);
 	amdgpu_vm_eviction_lock(vm);
 	if (r)
@@ -519,7 +512,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
 	pt_bo = &pt->bo;
 	pt_bo->parent = amdgpu_bo_ref(cursor->parent->bo);
 	amdgpu_vm_bo_base_init(entry, vm, pt_bo);
-	r = amdgpu_vm_pt_clear(adev, vm, pt, immediate);
+	r = amdgpu_vm_pt_clear(adev, vm, pt);
 	if (r)
 		goto error_free_pt;
 
@@ -813,7 +806,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			 * address range are actually allocated
 			 */
 			r = amdgpu_vm_pt_alloc(params->adev, params->vm,
-					       &cursor, params->immediate);
+					       &cursor);
 			if (r)
 				return r;
 		}
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 72cfb4a6ab3e..37b5166e9a14 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1372,7 +1372,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		return -EINVAL;
 	}
 
-	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, gpu_start,
+	return amdgpu_vm_update_range(adev, vm, true, true, false, NULL, gpu_start,
 				      gpu_end, init_pte_value, 0, 0, NULL, NULL,
 				      fence);
 }
@@ -1489,7 +1489,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 			 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
 			 pte_flags);
 
-		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, true,
+		r = amdgpu_vm_update_range(adev, vm, false, flush_tlb, true,
 					   NULL, gpu_start, gpu_end,
 					   pte_flags,
 					   (last_start - prange->start) << PAGE_SHIFT,
-- 
2.43.0


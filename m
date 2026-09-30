Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFDBCA5FAC
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 13:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B1A2C10F401;
	Wed, 30 Sep 2026 13:33:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KCt6fUva";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98A7B10F3F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 13:33:21 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e8185e037so30747365e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 06:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790775200; x=1791380000; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=s5bof0H0hw4TuyupIuxVn3C2Ex2uoCbrk7h//576svg=;
 b=KCt6fUvaMB1tcoePAXu+IfPxu4p9FEVTti9dd9fyHo1GqIFpoRwoF05or6fYToT0bI
 Az+iCgEoNGidMpx9+7crxy8NunklnJlHDDznkUKRVQf4VfdrhPU9x4pCPWcjrNAjQfzD
 z/R7ai3Pez1s2axfhHrxWZZuSzjKu7tXgsPAptVsIXutQP4kDBg6QL31qF0ESk/rwKvE
 c/XTI9d7NcgzkgqcLCiQW7Jr3IUF0ehL3e1vYp2pRDG2HQmaMi6UorpyIlXdmBbAciFU
 QqrlGdotJuGIzeKVplX8vfiqO5mBrGhxCGE6T8h70a+37HoBGs0vQnO3xwK8/nGUyBwp
 EYUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775200; x=1791380000;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=s5bof0H0hw4TuyupIuxVn3C2Ex2uoCbrk7h//576svg=;
 b=KbJGjoQziNvrnmAleO0bJQzzfrbl9tZi0sivP/1Zhh6fjtF51Y3NKVvo3RJCS6nIPE
 D48rRKigDFcJJHeb6MAqJyAc13bwpGSzfFOW/SGtXl+ua6N7I1QkMd5M/wh6EY6hVOQV
 Jd9awdK4HIwA26aL2K8daDSViktSdSB84HtAiGCZ6EMpgQTl1qV2E7YSJC6P6UQuojby
 79gDsMF5zNFYKz8UsdQ2drPuIRhLL0SxSIt4L4uzs1RU5UPa4BULqIwPRMTKTNcaI26Q
 wjE/YMnWSe/zmSeTqhlAU7FgzhQ+e+C/StC98WgwLlJi5RqZGItjwxQ7CNV6awydheUz
 BO+w==
X-Gm-Message-State: AFuF++lwrBO//OQiSjoORj4VcoiAvvXi9lo8ciQzwVYgcdhrU4kUyeNo
 EfVp7RjmX1oQkVKqWxxuMtZu0r0ORtFHK6/08o7kNM/zhZu5TPCKzHFC
X-Gm-Gg: AYBFou1IDRMSvGsVKkkNc9x4EF0sBngc5dlAasAEYB37EuRj1GF5k2ICWaz4OMvj/+I
 qQ3uHmDq1JYpxhXDVSZ28lOke/qgZ35tzOMi1q7KCaiMbLGS8Hcw3Ha0boQmPFkenPGv0TDgR2e
 Cymv9INhJv07/MkAGZGV7PH8K3olIzG3BhfN9jJVBtRkhUg2HycPxXM1yxFS5PBFtD46pFjD4xP
 cqLp1tODHoE6FgH9e+63tyH3GRB2KhbLAiST2uoa0+tV+lgPtbzN1XBbxSBN2L3xdGnlYAZSC3a
 9kKW1BTBbQbl66zfSdZyBUWDSK4sG6UUN2cELwOrcCKQF1D/OHiXk1ekXDzc8Ihu+rCiLbuzxEo
 fdces4SBYMaidoiSJU75GyXQeoTTgFAuX1TDKbXCEftwkooMx30Zqm7VZEe9ATQPdQI+LDoeVFh
 Tqekmze/U1wxuWrh9DcThtIc5OnV/onwEF+yViAB4QvV1VZjiQ2NMVzY6fFeZXDuKTnr8wwtK0s
 RbwRHdILRU=
X-Received: by 2002:a05:600c:6815:b0:49f:f963:7093 with SMTP id
 5b1f17b1804b1-4a01b00d679mr25836335e9.23.1790775199876; 
 Wed, 30 Sep 2026 06:33:19 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:155e:6500:f261:39ca:dadd:d0c6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01771cf9fsm60407975e9.14.2026.09.30.06.33.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 06:33:19 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com,
 cascardo@igalia.com, tvrtko.ursulin@igalia.com, olivier.kaloudoff@gmail.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/8] drm/amdgpu: drop immediate updates from
 amdgpu_vm_update_range
Date: Wed, 30 Sep 2026 15:33:10 +0200
Message-ID: <20260930133315.12270-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930133315.12270-1-christian.koenig@amd.com>
References: <20260930133315.12270-1-christian.koenig@amd.com>
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
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    | 42 +++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 21 ++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        | 11 +++--
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   |  5 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 13 ++----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  4 +-
 6 files changed, 43 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 8fed28dc75023..7189ee0939ca2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -2056,9 +2056,9 @@ static int amdgpu_ualink_unmap_npa_addr(struct amdgpu_device *adev,
 		return r;
 	}
 
-	r = amdgpu_vm_update_range(adev, vm, false, false, true,
-				false, NULL, npa_addr, npa_addr + size - 1,
-				pte_value, 0, 0, NULL, NULL, &vm->last_update);
+	r = amdgpu_vm_update_range(adev, vm, false, true, false, NULL, npa_addr,
+				   npa_addr + size - 1, pte_value, 0, 0, NULL,
+				   NULL, &vm->last_update);
 	if (r) {
 		dev_err(adev->dev,
 			"Failed to unmap NPA addr (%llx) from NPA VM\n", npa_addr);
@@ -2108,10 +2108,10 @@ static int amdgpu_ualink_map_npa_addr(struct amdgpu_device *adev, u64 npa_addr,
 		return r;
 	}
 
-	r = amdgpu_vm_update_range(adev, vm, false, false, true,
-				false, NULL, npa_addr, npa_addr + size - 1,
-				pte_flags, offset, adev->vm_manager.vram_base_offset,
-				bo->tbo.resource, NULL, &vm->last_update);
+	r = amdgpu_vm_update_range(adev, vm, false, true, false, NULL, npa_addr,
+				   npa_addr + size - 1, pte_flags, offset,
+				   adev->vm_manager.vram_base_offset,
+				   bo->tbo.resource, NULL, &vm->last_update);
 	if (r) {
 		dev_warn(adev->dev,
 			"Failed to map NPA addr (%llx) into NPA VM\n", npa_addr);
@@ -2645,10 +2645,12 @@ static void amdgpu_ualink_force_retry_rpcs(struct amdgpu_device *adev,
 			"RETRY-RPC: setting PTE.X=1 for NPA:%llx remote:%u pte:0x%llx\n",
 			npa_addr, remote_acc_id, pte_flags);
 
-		r = amdgpu_vm_update_range(adev, vm, false, false, true,
-					false, NULL, npa_addr, npa_addr + size - 1,
-					pte_flags, 0, adev->vm_manager.vram_base_offset,
-					bo->tbo.resource, NULL, &vm->last_update);
+		r = amdgpu_vm_update_range(adev, vm, false, true, false, NULL,
+					   npa_addr, npa_addr + size - 1,
+					   pte_flags, 0,
+					   adev->vm_manager.vram_base_offset,
+					   bo->tbo.resource, NULL,
+					   &vm->last_update);
 
 		if (r)
 			dev_warn(adev->dev,
@@ -2781,10 +2783,10 @@ static void amdgpu_ualink_unmap_all_npa_addr(struct amdgpu_device *adev,
 			npa_addr, exp_xa_node->handle.handle_hi, exp_xa_node->handle.handle_lo,
 			remote_acc_id, pte_value);
 
-		r = amdgpu_vm_update_range(adev, vm, false,
-					   false, true, false, NULL, npa_addr,
-					   npa_addr + size - 1, pte_value, 0,
-					   0, NULL, NULL, &vm->last_update);
+		r = amdgpu_vm_update_range(adev, vm, false, true, false, NULL,
+					   npa_addr, npa_addr + size - 1,
+					   pte_value, 0, 0, NULL, NULL,
+					   &vm->last_update);
 
 		if (r)
 			dev_err(adev->dev,
@@ -4586,9 +4588,8 @@ static int amdgpu_ualink_npa_vm_map_range(struct amdgpu_device *adev, struct amd
 		offset, size_in_pages << AMDGPU_GPU_PAGE_SHIFT, pte_flags,
 		npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
 
-	r = amdgpu_vm_update_range(adev, npa_vm, false, false, true,
-				   false, NULL, npa_in_pages,
-				   npa_in_pages + size_in_pages - 1,
+	r = amdgpu_vm_update_range(adev, npa_vm, false, true, false, NULL,
+				   npa_in_pages, npa_in_pages + size_in_pages - 1,
 				   pte_flags, offset, adev->vm_manager.vram_base_offset,
 				   bo->tbo.resource, NULL, &npa_vm->last_update);
 	if (r)
@@ -4621,9 +4622,8 @@ static int amdgpu_ualink_npa_vm_unmap_range(struct amdgpu_device *adev, struct a
 		offset, size_in_pages << AMDGPU_GPU_PAGE_SHIFT, pte_flags,
 		npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
 
-	r = amdgpu_vm_update_range(adev, npa_vm, false, false, true,
-				   false, NULL, npa_in_pages,
-				   npa_in_pages + size_in_pages - 1,
+	r = amdgpu_vm_update_range(adev, npa_vm, false, true, false, NULL,
+				   npa_in_pages, npa_in_pages + size_in_pages - 1,
 				   pte_flags, offset, 0, bo->tbo.resource, NULL,
 				   &npa_vm->last_update);
 	if (r)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index eb704d07dce61..aaf702ec2acda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1108,7 +1108,6 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
  *
  * @adev: amdgpu_device pointer to use for commands
  * @vm: the VM to update the range
- * @immediate: immediate submission in a page fault
  * @unlocked: unlocked invalidation during MM callback
  * @flush_tlb: trigger tlb invalidation after update completed
  * @allow_override: change MTYPE for local NUMA nodes
@@ -1128,12 +1127,11 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
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
@@ -1163,7 +1161,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
-	params.immediate = immediate;
 	params.pages_addr = pages_addr;
 	params.unlocked = unlocked;
 	params.needs_flush = flush_tlb;
@@ -1389,7 +1386,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 
 		trace_amdgpu_vm_bo_update(mapping);
 
-		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb,
+		r = amdgpu_vm_update_range(adev, vm, false, flush_tlb,
 					   !uncached, &sync, mapping->start,
 					   mapping->last, update_flags,
 					   mapping->offset, vram_base, mem,
@@ -1600,7 +1597,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 			struct amdgpu_bo_va_mapping, list);
 		list_del(&mapping->list);
 
-		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
+		r = amdgpu_vm_update_range(adev, vm, false, true, false,
 					   &sync, mapping->start, mapping->last,
 					   0, 0, 0, NULL, NULL, &f);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
@@ -2655,7 +2652,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->tlb_fence_context = dma_fence_context_alloc(1);
 
 	r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
-				false, &root, xcp_id);
+				&root, xcp_id);
 	if (r)
 		goto error_free_delayed;
 
@@ -2671,7 +2668,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_free_root;
 
-	r = amdgpu_vm_pt_clear(adev, vm, root, false);
+	r = amdgpu_vm_pt_clear(adev, vm, root);
 	if (r)
 		goto error_free_root;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 4ba49fe045df9..f6f14f1e96b39 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -466,12 +466,11 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
index dafdb3a001b8e..89fdeff0575ef 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -116,10 +116,9 @@ struct amdgpu_vm_update_funcs {
 };
 
 int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		       struct amdgpu_bo_vm *vmbo, bool immediate);
+		       struct amdgpu_bo_vm *vmbo);
 int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			int level, bool immediate, struct amdgpu_bo_vm **vmbo,
-			int32_t xcp_id);
+			int level, struct amdgpu_bo_vm **vmbo, int32_t xcp_id);
 void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
 			 struct amdgpu_vm_bo_base *entry);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index ab39122f19b68..3b262b0d186a5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -379,7 +379,6 @@ static uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
  * @adev: amdgpu_device pointer
  * @vm: VM to clear BO from
  * @vmbo: BO to clear
- * @immediate: use an immediate update
  *
  * Root PD needs to be reserved when calling this.
  *
@@ -387,7 +386,7 @@ static uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
  * 0 on success, errno otherwise.
  */
 int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		       struct amdgpu_bo_vm *vmbo, bool immediate)
+		       struct amdgpu_bo_vm *vmbo)
 {
 	unsigned int level = adev->vm_manager.root_level;
 	struct ttm_operation_ctx ctx = { true, false };
@@ -423,7 +422,6 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
-	params.immediate = immediate;
 
 	r = vm->update_funcs->prepare(&params, NULL,
 				      AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR);
@@ -447,13 +445,11 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -484,7 +480,6 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		bp.flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 
 	bp.type = ttm_bo_type_kernel;
-	bp.no_wait_gpu = immediate;
 	bp.xcp_id_plus1 = xcp_id + 1;
 
 	if (vm->root.bo)
@@ -534,7 +529,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
 		return 0;
 
 	amdgpu_vm_end_critical(p);
-	r = amdgpu_vm_pt_create(p->adev, p->vm, cursor->level, p->immediate,
+	r = amdgpu_vm_pt_create(p->adev, p->vm, cursor->level,
 				&pt, p->vm->root.bo->xcp_id);
 	r2 = amdgpu_vm_begin_critical(p);
 	if (r)
@@ -548,7 +543,7 @@ static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
 	pt_bo = &pt->bo;
 	pt_bo->parent = amdgpu_bo_ref(cursor->parent->bo);
 	amdgpu_vm_bo_base_init(entry, p->vm, pt_bo);
-	r = amdgpu_vm_pt_clear(p->adev, p->vm, pt, p->immediate);
+	r = amdgpu_vm_pt_clear(p->adev, p->vm, pt);
 	if (r)
 		goto error_unpin;
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index a99dbedf3cd4f..411bd3394442a 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1411,7 +1411,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		return -EINVAL;
 	}
 
-	return amdgpu_vm_update_range(adev, vm, false, true, true, false, NULL, gpu_start,
+	return amdgpu_vm_update_range(adev, vm, true, true, false, NULL, gpu_start,
 				      gpu_end, init_pte_value, 0, 0, NULL, NULL,
 				      fence);
 }
@@ -1523,7 +1523,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 			 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
 			 pte_flags);
 
-		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb, true,
+		r = amdgpu_vm_update_range(adev, vm, false, flush_tlb, true,
 					   NULL, gpu_start, gpu_end,
 					   pte_flags,
 					   (last_start - prange->start) << PAGE_SHIFT,
-- 
2.43.0


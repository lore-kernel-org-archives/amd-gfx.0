Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A065CCA5FA9
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 15:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14CAB10EAD4;
	Mon, 28 Sep 2026 15:10:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D+N+9XVO";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DCD910EAB5
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 15:10:49 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6351831so1863104f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 08:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790608247; x=1791213047; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=gAJCiFk1nnvH9RVGfNBTozRGTzntHW+RvdNDSL5aCA0=;
 b=D+N+9XVO1kXanhhY/boE1uYQP+KAm6kKd0413kXg/nRJ53+ccuwhQ3lBn4nG231cWH
 tdiO7jQdMZ1oXifwTnmTzOjtgDmcR1cUeygGyUfWEK9J3+OJ8snaPu7LV9HxHmtjBjbf
 BnEFAXGT6p7+Bbiknvzcmv2Nx9xvHgv59ft8qzNaFDMQwsYyOgaoI8GhkyfdWktDBYHQ
 iSErFYA6Qz0Y4HgK32KVExXorlF43eb7prrIoFipvAZnxeMqGa640uoxSSRdGbtusilL
 30NI10OBUAbb0XqnMC7YFNE6wiSENgDcmdeKF5J5m3yWm0YKd2CuHaFbES5QjsSRT1/P
 WZ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608247; x=1791213047;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gAJCiFk1nnvH9RVGfNBTozRGTzntHW+RvdNDSL5aCA0=;
 b=A5ItujNy0ZshJVw1WO/+xQubEZsxqM/Py2Z7c4RJ79FO0QLH5ncbXt5k6eFS1MY47y
 8jOJXFM1HR74N1YSns1TN7ov8l2Tqhi4kuktv39rPj68cl7OKLjeljwo31bg/BzZ98TP
 5yrfhUvPY6lPivlbVnU0mahXmdwMvZ1eDO/xjUV60SxrGVLQaQsjR9O9Poi1ddx2/vga
 dkCP86zOW7t1nH/GK6c3W7IRrMAplHyOVwrzGAYAmBez5c2VdjqHK092r9ncIkuUvmFQ
 lxe40Qx8ZYfpjniYMSh/xbOhoVteyq9NTaVwGZ2iPwxtiTPMh0S8Vg3EBql1TIL+J/Ff
 oT+g==
X-Gm-Message-State: AFq9FYKjIjBejn0qKAL67xJPKYgzFh/LHPS6qOldsdFUe/mT6oV+NHFk
 mB83PTbAHIdQ608driaQNS07/icvcno17bCFoYgI46MuPYL+VoMPV5NY
X-Gm-Gg: AYBFou0c3qSFCv2RvrykinpHbg4ervctZNp1F8rCb4Rt7k0yCS3Or4XScQQy9AQ3U+n
 gRz1Yd8BpIFRxI1yaz66kd5kjPJbcznnClTI3OPeq55uEXL7gv5UgOG48ObeZuNDRCsKOv7wNeF
 UDv6UB50WLESI2Eg3Ei+iD255lyBQLO13Z1v8sO+HMaeniGote+RfddOK1KDTWU8eXyknLpnJnb
 43vzFvfdgImXgEav3n7ebYxjb61OikVG5TDqYtedGOc8BwgZEhbrnUxpPI98Vj1J65hhMOHR6sX
 dsPUkG6/EcpOxLdraYrngMBnwBdd3Mt1JR/zhQpi3b1iSiMB3g0VQ2yd/OS+OIbSN7hnE43kOZr
 0ArF57c2ADaYXVNoCfObbFTEX1IJCVMMUKfT0G5+7cZTbpSypC1Y1mVklQH2BSkvH8fqQtv+eJm
 uMQX1Vk/r/zJQeb+aawZdK3Y1cURnlksJozgURPU+TaQP5Phwce5ZJx19b0iAXoUxscFA1R0G32
 Eq0O0V0wyC1tzp1195PrA==
X-Received: by 2002:a05:6000:22ca:b0:487:af3:836 with SMTP id
 ffacd0b85a97d-48871764dd8mr27102331f8f.45.1790608247330; 
 Mon, 28 Sep 2026 08:10:47 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:152b:4800:8072:ed4c:898d:d82d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a35fb05sm31513965f8f.20.2026.09.28.08.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:10:46 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com,
 cascardo@igalia.com, tvrtko.ursulin@igalia.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/9] drm/amdgpu: drop immediate updates from
 amdgpu_vm_update_range
Date: Mon, 28 Sep 2026 17:10:37 +0200
Message-ID: <20260928151041.1857-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928151041.1857-1-christian.koenig@amd.com>
References: <20260928151041.1857-1-christian.koenig@amd.com>
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
index 6e937f31a5b1a..aac97dca36e33 100644
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
@@ -4567,9 +4569,8 @@ static int amdgpu_ualink_npa_vm_map_range(struct amdgpu_device *adev, struct amd
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
@@ -4602,9 +4603,8 @@ static int amdgpu_ualink_npa_vm_unmap_range(struct amdgpu_device *adev, struct a
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
index d6358cbfcc9b1..017ec0ac0870d 100644
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
@@ -2661,7 +2658,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->tlb_fence_context = dma_fence_context_alloc(1);
 
 	r = amdgpu_vm_pt_create(adev, vm, adev->vm_manager.root_level,
-				false, &root, xcp_id);
+				&root, xcp_id);
 	if (r)
 		goto error_free_delayed;
 
@@ -2677,7 +2674,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_free_root;
 
-	r = amdgpu_vm_pt_clear(adev, vm, root, false);
+	r = amdgpu_vm_pt_clear(adev, vm, root);
 	if (r)
 		goto error_free_root;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index ec5cd38fe4e34..3ff17625a8c0c 100644
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
index 27003b03b5fdb..50c41e39e2a2b 100644
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


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203EFC25B74
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 17:00:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F4751122D1;
	Mon,  6 May 2024 17:00:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="er2NJyoS";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD02E1122C0
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 17:00:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tPqVtpHbA1mUgWgVV0V7nvuQJwZfiiYpPmGA1bEn6n0=; b=er2NJyoS30mJT84X9LSjyn6+7m
 y+9JYvX/0op1a4wbK9DCRvTSyc7WqdwhgaVVcBtoGuC0nUqTn2dHiruXTrg0EpKe5mWV6wxNyD2Uq
 aJsLc3InrE4oaQOuZuFApIvjcGBiXN7VVmoC99RhoyXOED3gM1S2ZwPf4wdn8Bp/YegpcP77QVUy3
 aTjJemQN1eNTSjF1DDEostTi5GX1oDcCMZYftk0kgjCT9dxHLvvQAbKpUtoZSi5KdSfrOqI73dLgd
 +1hl4AtIBEwmbHlrHsJlJZrG22E4TMg54o1HbOAP5bhdkUVOxRnVqjgzoSYuah6//YBDqEwZSH3Sj
 rV5aIegg==;
Received: from [84.69.19.168] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1s41h4-001Qf4-MR; Mon, 06 May 2024 19:00:03 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [PATCH 1/5] drm/amdgpu: Add amdgpu_bo_is_vm_bo helper
Date: Mon,  6 May 2024 17:59:55 +0100
Message-ID: <20240506165959.50648-2-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240506165959.50648-1-tursulin@igalia.com>
References: <20240506165959.50648-1-tursulin@igalia.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Help code readability by replacing a bunch of:

bo->tbo.base.resv == vm->root.bo->tbo.base.resv

With:

amdgpu_vm_is_bo_always_valid(vm, bo)

No functional changes.

v2:
 * Rename helper and move to amdgpu_vm. (Christian)

v3:
 * Use Christian's kerneldoc.

v4:
 * Fixed logic inversion in amdgpu_vm_bo_get_memory.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 41 ++++++++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  2 ++
 3 files changed, 29 insertions(+), 16 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 67c234bcf89f..e698d65e9508 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -174,7 +174,7 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 		return -EPERM;
 
 	if (abo->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID &&
-	    abo->tbo.base.resv != vm->root.bo->tbo.base.resv)
+	    !amdgpu_vm_is_bo_always_valid(vm, abo))
 		return -EPERM;
 
 	r = amdgpu_bo_reserve(abo, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 4e2391c83d7c..9ccb9814874c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -333,7 +333,7 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 	base->next = bo->vm_bo;
 	bo->vm_bo = base;
 
-	if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
+	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
 		return;
 
 	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
@@ -1101,13 +1101,13 @@ static void amdgpu_vm_bo_get_memory(struct amdgpu_bo_va *bo_va,
 	 * For now ignore BOs which are currently locked and potentially
 	 * changing their location.
 	 */
-	if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv &&
+	if (!amdgpu_vm_is_bo_always_valid(vm, bo) &&
 	    !dma_resv_trylock(bo->tbo.base.resv))
 		return;
 
 	amdgpu_bo_get_memory(bo, stats);
-	if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
-	    dma_resv_unlock(bo->tbo.base.resv);
+	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
+		dma_resv_unlock(bo->tbo.base.resv);
 }
 
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
@@ -1203,8 +1203,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 		uncached = false;
 	}
 
-	if (clear || (bo && bo->tbo.base.resv ==
-		      vm->root.bo->tbo.base.resv))
+	if (clear || amdgpu_vm_is_bo_always_valid(vm, bo))
 		last_update = &vm->last_update;
 	else
 		last_update = &bo_va->last_pt_update;
@@ -1246,7 +1245,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 	 * the evicted list so that it gets validated again on the
 	 * next command submission.
 	 */
-	if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv) {
+	if (amdgpu_vm_is_bo_always_valid(vm, bo)) {
 		uint32_t mem_type = bo->tbo.resource->mem_type;
 
 		if (!(bo->preferred_domains &
@@ -1640,10 +1639,9 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
 	if (mapping->flags & AMDGPU_PTE_PRT)
 		amdgpu_vm_prt_get(adev);
 
-	if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
-	    !bo_va->base.moved) {
+	if (amdgpu_vm_is_bo_always_valid(vm, bo) && !bo_va->base.moved)
 		amdgpu_vm_bo_moved(&bo_va->base);
-	}
+
 	trace_amdgpu_vm_bo_map(bo_va, mapping);
 }
 
@@ -1942,7 +1940,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 		if (before->flags & AMDGPU_PTE_PRT)
 			amdgpu_vm_prt_get(adev);
 
-		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
+		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
 		    !before->bo_va->base.moved)
 			amdgpu_vm_bo_moved(&before->bo_va->base);
 	} else {
@@ -1957,7 +1955,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 		if (after->flags & AMDGPU_PTE_PRT)
 			amdgpu_vm_prt_get(adev);
 
-		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
+		if (amdgpu_vm_is_bo_always_valid(vm, bo) &&
 		    !after->bo_va->base.moved)
 			amdgpu_vm_bo_moved(&after->bo_va->base);
 	} else {
@@ -2037,7 +2035,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 
 	if (bo) {
 		dma_resv_assert_held(bo->tbo.base.resv);
-		if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
+		if (amdgpu_vm_is_bo_always_valid(vm, bo))
 			ttm_bo_set_bulk_move(&bo->tbo, NULL);
 
 		for (base = &bo_va->base.bo->vm_bo; *base;
@@ -2131,7 +2129,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
 	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
 		struct amdgpu_vm *vm = bo_base->vm;
 
-		if (evicted && bo->tbo.base.resv == vm->root.bo->tbo.base.resv) {
+		if (evicted && amdgpu_vm_is_bo_always_valid(vm, bo)) {
 			amdgpu_vm_bo_evicted(bo_base);
 			continue;
 		}
@@ -2142,7 +2140,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
 
 		if (bo->tbo.type == ttm_bo_type_kernel)
 			amdgpu_vm_bo_relocated(bo_base);
-		else if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
+		else if (amdgpu_vm_is_bo_always_valid(vm, bo))
 			amdgpu_vm_bo_moved(bo_base);
 		else
 			amdgpu_vm_bo_invalidated(bo_base);
@@ -3006,3 +3004,16 @@ void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 	xa_unlock_irqrestore(&adev->vm_manager.pasids, flags);
 }
 
+/**
+ * amdgpu_vm_is_bo_always_valid - check if the BO is VM always valid
+ *
+ * @vm: VM to test against.
+ * @abo: BO to be tested.
+ *
+ * Returns true if the BO shares the dma_resv object with the root PD and is
+ * always guaranteed to be valid inside the VM.
+ */
+bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *vm, struct amdgpu_bo *bo)
+{
+	return bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 54d7da396de0..ec688a47dec1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -561,6 +561,8 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
 
 int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 
+bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *vm, struct amdgpu_bo *bo);
+
 /**
  * amdgpu_vm_tlb_seq - return tlb flush sequence number
  * @vm: the amdgpu_vm structure to query
-- 
2.44.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39FF1C4345F
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Apr 2024 16:44:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0D4C10F1BF;
	Fri, 26 Apr 2024 16:44:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="mGq2av6i";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88B9110F6AC
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Apr 2024 16:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0saQG9JC7MLIZUR3pLXVI5rKNCCTFBL/2/pJCkPNw5c=; b=mGq2av6i4bNq6fOae9b92g76zi
 aDEfhfwduuGC9kq7N3ZkD4P9CpcrWprAx5+PR5KYV2Kb5YFfBBF0+IznVgGYfPqhbe/IHXVvkIm3i
 phBLt86nHCDyRSgUP8NSO8XoJV1PyrI7pt7DMhtoVL1fOjmaO+4/7RWi5EHpGn2fR+rLpPBy33ViZ
 657NeAKrH2+5Vfym2MHtUkhCN/XL8NIiGO61kae0F3usIKJasc7LwLFOfp2QMoPH7UcdokcIPsf2d
 0BTnZRe2i9+p18ZAI2rTtsE+vptJpN8tS44sQDfwUcr5grQgiCyENpPwmmQAxWEeE1YRVTQZHzEIk
 SrUsUTxA==;
Received: from [84.65.0.132] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1s0OgO-000CGi-RW; Fri, 26 Apr 2024 18:44:20 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 1/3] drm/amdgpu: Add amdgpu_bo_is_vm_bo helper
Date: Fri, 26 Apr 2024 17:43:53 +0100
Message-ID: <20240426164355.1563-2-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240426164355.1563-1-tursulin@igalia.com>
References: <20240426164355.1563-1-tursulin@igalia.com>
MIME-Version: 1.0
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

amdgpu_bo_is_vm_bo(bo, vm)

No functional changes.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 14 ++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 31 +++++++++-------------
 3 files changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 67c234bcf89f..32e4a9c6e805 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -174,7 +174,7 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 		return -EPERM;
 
 	if (abo->flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID &&
-	    abo->tbo.base.resv != vm->root.bo->tbo.base.resv)
+	    !amdgpu_bo_is_vm_bo(abo, vm))
 		return -EPERM;
 
 	r = amdgpu_bo_reserve(abo, false);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index be679c42b0b8..f2bb6965cc77 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -307,6 +307,20 @@ static inline struct amdgpu_bo *amdgpu_bo_shadowed(struct amdgpu_bo *bo)
 	return NULL;
 }
 
+/**
+ * amdgpu_bo_is_vm_bo - check if the BO is VM always valid
+ *
+ * @abo: BO to be tested.
+ * @vm: VM to test against.
+ *
+ * Returns true if the BO is VM always valid.
+ */
+static inline bool amdgpu_bo_is_vm_bo(struct amdgpu_bo *bo,
+				      struct amdgpu_vm *vm)
+{
+	return bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv;
+}
+
 bool amdgpu_bo_is_amdgpu_bo(struct ttm_buffer_object *bo);
 void amdgpu_bo_placement_from_domain(struct amdgpu_bo *abo, u32 domain);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 8af3f0fd3073..6d6f0e325172 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -333,7 +333,7 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 	base->next = bo->vm_bo;
 	bo->vm_bo = base;
 
-	if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
+	if (!amdgpu_bo_is_vm_bo(bo, vm))
 		return;
 
 	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
@@ -1101,13 +1101,12 @@ static void amdgpu_vm_bo_get_memory(struct amdgpu_bo_va *bo_va,
 	 * For now ignore BOs which are currently locked and potentially
 	 * changing their location.
 	 */
-	if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv &&
-	    !dma_resv_trylock(bo->tbo.base.resv))
+	if (!amdgpu_bo_is_vm_bo(bo, vm) && !dma_resv_trylock(bo->tbo.base.resv))
 		return;
 
 	amdgpu_bo_get_memory(bo, stats);
-	if (bo->tbo.base.resv != vm->root.bo->tbo.base.resv)
-	    dma_resv_unlock(bo->tbo.base.resv);
+	if (amdgpu_bo_is_vm_bo(bo, vm))
+		dma_resv_unlock(bo->tbo.base.resv);
 }
 
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
@@ -1203,8 +1202,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 		uncached = false;
 	}
 
-	if (clear || (bo && bo->tbo.base.resv ==
-		      vm->root.bo->tbo.base.resv))
+	if (clear || amdgpu_bo_is_vm_bo(bo, vm))
 		last_update = &vm->last_update;
 	else
 		last_update = &bo_va->last_pt_update;
@@ -1246,7 +1244,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 	 * the evicted list so that it gets validated again on the
 	 * next command submission.
 	 */
-	if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv) {
+	if (amdgpu_bo_is_vm_bo(bo, vm)) {
 		uint32_t mem_type = bo->tbo.resource->mem_type;
 
 		if (!(bo->preferred_domains &
@@ -1640,10 +1638,9 @@ static void amdgpu_vm_bo_insert_map(struct amdgpu_device *adev,
 	if (mapping->flags & AMDGPU_PTE_PRT)
 		amdgpu_vm_prt_get(adev);
 
-	if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
-	    !bo_va->base.moved) {
+	if (amdgpu_bo_is_vm_bo(bo, vm) && !bo_va->base.moved)
 		amdgpu_vm_bo_moved(&bo_va->base);
-	}
+
 	trace_amdgpu_vm_bo_map(bo_va, mapping);
 }
 
@@ -1922,8 +1919,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 		if (before->flags & AMDGPU_PTE_PRT)
 			amdgpu_vm_prt_get(adev);
 
-		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
-		    !before->bo_va->base.moved)
+		if (amdgpu_bo_is_vm_bo(bo, vm) && !before->bo_va->base.moved)
 			amdgpu_vm_bo_moved(&before->bo_va->base);
 	} else {
 		kfree(before);
@@ -1937,8 +1933,7 @@ int amdgpu_vm_bo_clear_mappings(struct amdgpu_device *adev,
 		if (after->flags & AMDGPU_PTE_PRT)
 			amdgpu_vm_prt_get(adev);
 
-		if (bo && bo->tbo.base.resv == vm->root.bo->tbo.base.resv &&
-		    !after->bo_va->base.moved)
+		if (amdgpu_bo_is_vm_bo(bo, vm) && !after->bo_va->base.moved)
 			amdgpu_vm_bo_moved(&after->bo_va->base);
 	} else {
 		kfree(after);
@@ -2017,7 +2012,7 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 
 	if (bo) {
 		dma_resv_assert_held(bo->tbo.base.resv);
-		if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
+		if (amdgpu_bo_is_vm_bo(bo, vm))
 			ttm_bo_set_bulk_move(&bo->tbo, NULL);
 
 		for (base = &bo_va->base.bo->vm_bo; *base;
@@ -2111,7 +2106,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
 	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
 		struct amdgpu_vm *vm = bo_base->vm;
 
-		if (evicted && bo->tbo.base.resv == vm->root.bo->tbo.base.resv) {
+		if (evicted && amdgpu_bo_is_vm_bo(bo, vm)) {
 			amdgpu_vm_bo_evicted(bo_base);
 			continue;
 		}
@@ -2122,7 +2117,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
 
 		if (bo->tbo.type == ttm_bo_type_kernel)
 			amdgpu_vm_bo_relocated(bo_base);
-		else if (bo->tbo.base.resv == vm->root.bo->tbo.base.resv)
+		else if (amdgpu_bo_is_vm_bo(bo, vm))
 			amdgpu_vm_bo_moved(bo_base);
 		else
 			amdgpu_vm_bo_invalidated(bo_base);
-- 
2.44.0


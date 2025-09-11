Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E976CA1016
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 12:09:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35B2410EAEA;
	Thu, 11 Sep 2025 12:09:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N3hF2fxn";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE7E010EAE7
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 12:09:55 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-45cb5492350so4963905e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 05:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757592594; x=1758197394; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UmZCmbLN7KoL+0dWS4ZNyh2eDpPfQCfHcCp2w03+nYQ=;
 b=N3hF2fxn56JVmBxaL3Blnruyq+YbYA9tk9yLWAQ/6qN0SamU3Kx7ieyJ4zaQAh1DOm
 kRB+UTXoWudNIsjedU75IGuT5Q1NqimYuziTyiO87Ra6zp5510AdzIkccI3vHpuYcm+O
 rqlLFSzn+TJkQwAf9stD34wm15QeLEyaNobAX1wkngsKSKOQehbwXMSry1vg9GsU/Hey
 eUn261by+pnOsdu9Ttf1iOhCR8cVENc5lVA+86xswgLq9Ga9xDu6N43vI0m353zWtKxD
 ed7JYvmjuKLfeVpPz/kqntl+T+HB5LIm2/aIwyEaZf1pR8EK3LuH0VRRif5nQxmFz8l8
 KmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757592594; x=1758197394;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UmZCmbLN7KoL+0dWS4ZNyh2eDpPfQCfHcCp2w03+nYQ=;
 b=ckNtuSUhcwgE1o7oAfM+bUSLf3ncahGTxoYQZVR/C+ZxXr0Y+9lp+Ck+8Nyli5Lqek
 0aY32N9kggsYn45bNNHTdCQ+009MN7JnqH5UxsDEWNP9h+KfCEzGJVSADSzXW0C/icQG
 ghMplHbLFIUcjuBSiqRWY/ZOVvzmqxLhGu63RzQNIOdf1etAo1WSTYfqKOGnTLHGNoEv
 6wa351hKrO2kX1CO+NRlYeFBFxhXGHQgEDMdRmwDVzCRmV3iNcgcHjG97rz0W0mFekZM
 ml27LcnmiOxlYomZ2x5hSwPLVj2aiTMMUuxIZ+4xpZ2yeT+OTqeO4T/Ozv6MhwqaMWnQ
 JeeQ==
X-Gm-Message-State: AOJu0Yz13ZeL4XWLEpqTpBfdqyA4I/PFYcpSuuDScFC6ObRkf/rLMVeA
 N38Uw37qpYewQdqP7b/2sC2fuGuNKX+JZEuAqQ5qOQY0chMonbqhb7uC
X-Gm-Gg: ASbGncvDt/UtSOIsxUBijPJrGL5bejcazhs/TzFCaBqX/MeZ8ibq6luOx4njOO2Yr85
 xncPtJSIOwRRlvvdaf9NQqs//QY5F+0fxfvl7QhoqSyV3EWz4KgPkudBup5cSCRSs0P1wnUW5o3
 v3eNDRWuN2LbudpuYrX46xt+IvaQjRPj3Ft07iP35TyEf/Exhh0/HCBoIzEXLCg/GfmhXNSclxC
 j2S7+HdFD/utBlQ7AprPbIfJyjQj+V/y2tUpMU0xgklqtNNmvvjn6lphTmTqt/25WepSARp9dJD
 5s1geYea9bWpHn1xgkHu9OfKGfOhOk8LGEoft+67/iLAEq/LgpqpBV11V1i/7CTKAGB7rnNsOTs
 QWl9kLDP3c5l1CaBoKvX5kaNTlopZmZ/Ppvlff4XjJ3jVJPw0FjHNBdLUdQ==
X-Google-Smtp-Source: AGHT+IGQlicBiqaZqCwQoT4HyRbuQmYJ4jf44NcUq5mUG6isLjG+TjoUqUAS+ylBCnTkyPyiEl/H7g==
X-Received: by 2002:a05:600c:6488:b0:45d:e0c5:7850 with SMTP id
 5b1f17b1804b1-45de0c57d85mr149462905e9.35.1757592594218; 
 Thu, 11 Sep 2025 05:09:54 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1539:fb00:efcb:f439:6900:a9d9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7607e1400sm2224744f8f.55.2025.09.11.05.09.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 05:09:53 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexdeucher@gmail.com, Sunil.Khatri@amd.com, Philip.Yang@amd.com,
 Prike.Liang@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/4] drm/amdgpu: revert to old status lock handling v3
Date: Thu, 11 Sep 2025 14:09:50 +0200
Message-ID: <20250911120950.3343-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250911120950.3343-1-christian.koenig@amd.com>
References: <20250911120950.3343-1-christian.koenig@amd.com>
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

It turned out that protecting the status of each bo_va with a
spinlock was just hiding problems instead of solving them.

Revert the whole approach, add a separate stats_lock and lockdep
assertions that the correct reservation lock is held all over the place.

This not only allows for better checks if a state transition is properly
protected by a lock, but also switching back to using list macros to
iterate over the state of lists protected by the dma_resv lock of the
root PD.

v2: re-add missing check
v3: split into two patches

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 168 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  15 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |   4 -
 4 files changed, 93 insertions(+), 102 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 0ccbd3c5d88d..428f5e8f1cfc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -679,12 +679,12 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
 	struct amdgpu_bo *bo;
 	int ret;
 
-	spin_lock(&vm->status_lock);
+	spin_lock(&vm->invalidated_lock);
 	while (!list_empty(&vm->invalidated)) {
 		bo_va = list_first_entry(&vm->invalidated,
 					 struct amdgpu_bo_va,
 					 base.vm_status);
-		spin_unlock(&vm->status_lock);
+		spin_unlock(&vm->invalidated_lock);
 
 		bo = bo_va->base.bo;
 		ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 2);
@@ -701,9 +701,9 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
 		if (ret)
 			return ret;
 
-		spin_lock(&vm->status_lock);
+		spin_lock(&vm->invalidated_lock);
 	}
-	spin_unlock(&vm->status_lock);
+	spin_unlock(&vm->invalidated_lock);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index d0c95fb0ef81..fc36d61567d0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -127,6 +127,17 @@ struct amdgpu_vm_tlb_seq_struct {
 	struct dma_fence_cb cb;
 };
 
+/**
+ * amdgpu_vm_assert_locked - check if VM is correctly locked
+ * @vm: the VM which schould be tested
+ *
+ * Asserts that the VM root PD is locked.
+ */
+static void amdgpu_vm_assert_locked(struct amdgpu_vm *vm)
+{
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
+}
+
 /**
  * amdgpu_vm_set_pasid - manage pasid and vm ptr mapping
  *
@@ -143,6 +154,8 @@ int amdgpu_vm_set_pasid(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 {
 	int r;
 
+	amdgpu_vm_assert_locked(vm);
+
 	if (vm->pasid == pasid)
 		return 0;
 
@@ -181,12 +194,11 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
 	struct amdgpu_bo *bo = vm_bo->bo;
 
 	vm_bo->moved = true;
-	spin_lock(&vm_bo->vm->status_lock);
+	amdgpu_vm_assert_locked(vm);
 	if (bo->tbo.type == ttm_bo_type_kernel)
 		list_move(&vm_bo->vm_status, &vm->evicted);
 	else
 		list_move_tail(&vm_bo->vm_status, &vm->evicted);
-	spin_unlock(&vm_bo->vm->status_lock);
 }
 /**
  * amdgpu_vm_bo_moved - vm_bo is moved
@@ -198,9 +210,8 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
 {
-	spin_lock(&vm_bo->vm->status_lock);
+	amdgpu_vm_assert_locked(vm_bo->vm);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
-	spin_unlock(&vm_bo->vm->status_lock);
 }
 
 /**
@@ -213,9 +224,8 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
 {
-	spin_lock(&vm_bo->vm->status_lock);
+	amdgpu_vm_assert_locked(vm_bo->vm);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
-	spin_unlock(&vm_bo->vm->status_lock);
 	vm_bo->moved = false;
 }
 
@@ -229,9 +239,9 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
 {
-	spin_lock(&vm_bo->vm->status_lock);
+	spin_lock(&vm_bo->vm->invalidated_lock);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
-	spin_unlock(&vm_bo->vm->status_lock);
+	spin_unlock(&vm_bo->vm->invalidated_lock);
 }
 
 /**
@@ -244,10 +254,9 @@ static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
 {
+	amdgpu_vm_assert_locked(vm_bo->vm);
 	vm_bo->moved = true;
-	spin_lock(&vm_bo->vm->status_lock);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
-	spin_unlock(&vm_bo->vm->status_lock);
 }
 
 /**
@@ -260,13 +269,11 @@ static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
 {
-	if (vm_bo->bo->parent) {
-		spin_lock(&vm_bo->vm->status_lock);
+	amdgpu_vm_assert_locked(vm_bo->vm);
+	if (vm_bo->bo->parent)
 		list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
-		spin_unlock(&vm_bo->vm->status_lock);
-	} else {
+	else
 		amdgpu_vm_bo_idle(vm_bo);
-	}
 }
 
 /**
@@ -279,9 +286,8 @@ static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
 {
-	spin_lock(&vm_bo->vm->status_lock);
+	amdgpu_vm_assert_locked(vm_bo->vm);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->done);
-	spin_unlock(&vm_bo->vm->status_lock);
 }
 
 /**
@@ -295,10 +301,13 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
 {
 	struct amdgpu_vm_bo_base *vm_bo, *tmp;
 
-	spin_lock(&vm->status_lock);
+	spin_lock(&vm->invalidated_lock);
 	list_splice_init(&vm->done, &vm->invalidated);
 	list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
 		vm_bo->moved = true;
+	spin_unlock(&vm->invalidated_lock);
+
+	amdgpu_vm_assert_locked(vm_bo->vm);
 	list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
 		struct amdgpu_bo *bo = vm_bo->bo;
 
@@ -308,14 +317,13 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
 		else if (bo->parent)
 			list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
 	}
-	spin_unlock(&vm->status_lock);
 }
 
 /**
  * amdgpu_vm_update_shared - helper to update shared memory stat
  * @base: base structure for tracking BO usage in a VM
  *
- * Takes the vm status_lock and updates the shared memory stat. If the basic
+ * Takes the vm stats_lock and updates the shared memory stat. If the basic
  * stat changed (e.g. buffer was moved) amdgpu_vm_update_stats need to be called
  * as well.
  */
@@ -327,7 +335,8 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
 	uint32_t bo_memtype = amdgpu_bo_mem_stats_placement(bo);
 	bool shared;
 
-	spin_lock(&vm->status_lock);
+	dma_resv_assert_held(bo->tbo.base.resv);
+	spin_lock(&vm->stats_lock);
 	shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
 	if (base->shared != shared) {
 		base->shared = shared;
@@ -339,7 +348,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
 			vm->stats[bo_memtype].drm.private += size;
 		}
 	}
-	spin_unlock(&vm->status_lock);
+	spin_unlock(&vm->stats_lock);
 }
 
 /**
@@ -364,11 +373,11 @@ void amdgpu_vm_bo_update_shared(struct amdgpu_bo *bo)
  *        be bo->tbo.resource
  * @sign: if we should add (+1) or subtract (-1) from the stat
  *
- * Caller need to have the vm status_lock held. Useful for when multiple update
+ * Caller need to have the vm stats_lock held. Useful for when multiple update
  * need to happen at the same time.
  */
 static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
-			    struct ttm_resource *res, int sign)
+					  struct ttm_resource *res, int sign)
 {
 	struct amdgpu_vm *vm = base->vm;
 	struct amdgpu_bo *bo = base->bo;
@@ -392,7 +401,8 @@ static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
 		 */
 		if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
 			vm->stats[res_memtype].drm.purgeable += size;
-		if (!(bo->preferred_domains & amdgpu_mem_type_to_domain(res_memtype)))
+		if (!(bo->preferred_domains &
+		      amdgpu_mem_type_to_domain(res_memtype)))
 			vm->stats[bo_memtype].evicted += size;
 	}
 }
@@ -411,9 +421,9 @@ void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
 {
 	struct amdgpu_vm *vm = base->vm;
 
-	spin_lock(&vm->status_lock);
+	spin_lock(&vm->stats_lock);
 	amdgpu_vm_update_stats_locked(base, res, sign);
-	spin_unlock(&vm->status_lock);
+	spin_unlock(&vm->stats_lock);
 }
 
 /**
@@ -439,10 +449,10 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 	base->next = bo->vm_bo;
 	bo->vm_bo = base;
 
-	spin_lock(&vm->status_lock);
+	spin_lock(&vm->stats_lock);
 	base->shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
 	amdgpu_vm_update_stats_locked(base, bo->tbo.resource, +1);
-	spin_unlock(&vm->status_lock);
+	spin_unlock(&vm->stats_lock);
 
 	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
 		return;
@@ -500,10 +510,10 @@ int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
 	int ret;
 
 	/* We can only trust prev->next while holding the lock */
-	spin_lock(&vm->status_lock);
+	spin_lock(&vm->invalidated_lock);
 	while (!list_is_head(prev->next, &vm->done)) {
 		bo_va = list_entry(prev->next, typeof(*bo_va), base.vm_status);
-		spin_unlock(&vm->status_lock);
+		spin_unlock(&vm->invalidated_lock);
 
 		bo = bo_va->base.bo;
 		if (bo) {
@@ -511,10 +521,10 @@ int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
 			if (unlikely(ret))
 				return ret;
 		}
-		spin_lock(&vm->status_lock);
+		spin_lock(&vm->invalidated_lock);
 		prev = prev->next;
 	}
-	spin_unlock(&vm->status_lock);
+	spin_unlock(&vm->invalidated_lock);
 
 	return 0;
 }
@@ -610,7 +620,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       void *param)
 {
 	uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
-	struct amdgpu_vm_bo_base *bo_base;
+	struct amdgpu_vm_bo_base *bo_base, *tmp;
 	struct amdgpu_bo *bo;
 	int r;
 
@@ -623,13 +633,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			return r;
 	}
 
-	spin_lock(&vm->status_lock);
-	while (!list_empty(&vm->evicted)) {
-		bo_base = list_first_entry(&vm->evicted,
-					   struct amdgpu_vm_bo_base,
-					   vm_status);
-		spin_unlock(&vm->status_lock);
-
+	list_for_each_entry_safe(bo_base, tmp, &vm->evicted, vm_status) {
 		bo = bo_base->bo;
 
 		r = validate(param, bo);
@@ -642,26 +646,21 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
 			amdgpu_vm_bo_relocated(bo_base);
 		}
-		spin_lock(&vm->status_lock);
 	}
-	while (ticket && !list_empty(&vm->evicted_user)) {
-		bo_base = list_first_entry(&vm->evicted_user,
-					   struct amdgpu_vm_bo_base,
-					   vm_status);
-		spin_unlock(&vm->status_lock);
 
-		bo = bo_base->bo;
-		dma_resv_assert_held(bo->tbo.base.resv);
-
-		r = validate(param, bo);
-		if (r)
-			return r;
+	if (ticket) {
+		list_for_each_entry_safe(bo_base, tmp, &vm->evicted_user,
+					 vm_status) {
+			bo = bo_base->bo;
+			dma_resv_assert_held(bo->tbo.base.resv);
 
-		amdgpu_vm_bo_invalidated(bo_base);
+			r = validate(param, bo);
+			if (r)
+				return r;
 
-		spin_lock(&vm->status_lock);
+			amdgpu_vm_bo_invalidated(bo_base);
+		}
 	}
-	spin_unlock(&vm->status_lock);
 
 	amdgpu_vm_eviction_lock(vm);
 	vm->evicting = false;
@@ -684,13 +683,13 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 {
 	bool ret;
 
+	amdgpu_vm_assert_locked(vm);
+
 	amdgpu_vm_eviction_lock(vm);
 	ret = !vm->evicting;
 	amdgpu_vm_eviction_unlock(vm);
 
-	spin_lock(&vm->status_lock);
 	ret &= list_empty(&vm->evicted);
-	spin_unlock(&vm->status_lock);
 
 	spin_lock(&vm->immediate.lock);
 	ret &= !vm->immediate.stopped;
@@ -981,16 +980,13 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm, bool immediate)
 {
 	struct amdgpu_vm_update_params params;
-	struct amdgpu_vm_bo_base *entry;
+	struct amdgpu_vm_bo_base *entry, *tmp;
 	bool flush_tlb_needed = false;
-	LIST_HEAD(relocated);
 	int r, idx;
 
-	spin_lock(&vm->status_lock);
-	list_splice_init(&vm->relocated, &relocated);
-	spin_unlock(&vm->status_lock);
+	amdgpu_vm_assert_locked(vm);
 
-	if (list_empty(&relocated))
+	if (list_empty(&vm->relocated))
 		return 0;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
@@ -1005,7 +1001,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
-	list_for_each_entry(entry, &relocated, vm_status) {
+	list_for_each_entry(entry, &vm->relocated, vm_status) {
 		/* vm_flush_needed after updating moved PDEs */
 		flush_tlb_needed |= entry->moved;
 
@@ -1021,9 +1017,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (flush_tlb_needed)
 		atomic64_inc(&vm->tlb_seq);
 
-	while (!list_empty(&relocated)) {
-		entry = list_first_entry(&relocated, struct amdgpu_vm_bo_base,
-					 vm_status);
+	list_for_each_entry_safe(entry, tmp, &vm->relocated, vm_status) {
 		amdgpu_vm_bo_idle(entry);
 	}
 
@@ -1249,9 +1243,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
 			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
 {
-	spin_lock(&vm->status_lock);
+	spin_lock(&vm->stats_lock);
 	memcpy(stats, vm->stats, sizeof(*stats) * __AMDGPU_PL_NUM);
-	spin_unlock(&vm->status_lock);
+	spin_unlock(&vm->stats_lock);
 }
 
 /**
@@ -1618,29 +1612,24 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 			   struct amdgpu_vm *vm,
 			   struct ww_acquire_ctx *ticket)
 {
-	struct amdgpu_bo_va *bo_va;
+	struct amdgpu_bo_va *bo_va, *tmp;
 	struct dma_resv *resv;
 	bool clear, unlock;
 	int r;
 
-	spin_lock(&vm->status_lock);
-	while (!list_empty(&vm->moved)) {
-		bo_va = list_first_entry(&vm->moved, struct amdgpu_bo_va,
-					 base.vm_status);
-		spin_unlock(&vm->status_lock);
-
+	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
 		/* Per VM BOs never need to bo cleared in the page tables */
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			return r;
-		spin_lock(&vm->status_lock);
 	}
 
+	spin_lock(&vm->invalidated_lock);
 	while (!list_empty(&vm->invalidated)) {
 		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
 					 base.vm_status);
 		resv = bo_va->base.bo->tbo.base.resv;
-		spin_unlock(&vm->status_lock);
+		spin_unlock(&vm->invalidated_lock);
 
 		/* Try to reserve the BO to avoid clearing its ptes */
 		if (!adev->debug_vm && dma_resv_trylock(resv)) {
@@ -1672,9 +1661,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
 			amdgpu_vm_bo_evicted_user(&bo_va->base);
 
-		spin_lock(&vm->status_lock);
+		spin_lock(&vm->invalidated_lock);
 	}
-	spin_unlock(&vm->status_lock);
+	spin_unlock(&vm->invalidated_lock);
 
 	return 0;
 }
@@ -2203,9 +2192,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 		}
 	}
 
-	spin_lock(&vm->status_lock);
+	spin_lock(&vm->invalidated_lock);
 	list_del(&bo_va->base.vm_status);
-	spin_unlock(&vm->status_lock);
+	spin_unlock(&vm->invalidated_lock);
 
 	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
 		list_del(&mapping->list);
@@ -2313,10 +2302,10 @@ void amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
 	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
 		struct amdgpu_vm *vm = bo_base->vm;
 
-		spin_lock(&vm->status_lock);
+		spin_lock(&vm->stats_lock);
 		amdgpu_vm_update_stats_locked(bo_base, bo->tbo.resource, -1);
 		amdgpu_vm_update_stats_locked(bo_base, new_mem, +1);
-		spin_unlock(&vm->status_lock);
+		spin_unlock(&vm->stats_lock);
 	}
 
 	amdgpu_vm_bo_invalidate(bo, evicted);
@@ -2583,11 +2572,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	INIT_LIST_HEAD(&vm->relocated);
 	INIT_LIST_HEAD(&vm->moved);
 	INIT_LIST_HEAD(&vm->idle);
+	spin_lock_init(&vm->invalidated_lock);
 	INIT_LIST_HEAD(&vm->invalidated);
-	spin_lock_init(&vm->status_lock);
 	INIT_LIST_HEAD(&vm->freed);
 	INIT_LIST_HEAD(&vm->done);
 	INIT_KFIFO(vm->faults);
+	spin_lock_init(&vm->stats_lock);
 
 	r = amdgpu_vm_init_entities(adev, vm);
 	if (r)
@@ -3052,7 +3042,8 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 	unsigned int total_done_objs = 0;
 	unsigned int id = 0;
 
-	spin_lock(&vm->status_lock);
+	amdgpu_vm_assert_locked(vm);
+
 	seq_puts(m, "\tIdle BOs:\n");
 	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
 		if (!bo_va->base.bo)
@@ -3090,11 +3081,13 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 	id = 0;
 
 	seq_puts(m, "\tInvalidated BOs:\n");
+	spin_lock(&vm->invalidated_lock);
 	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
 		total_invalidated += amdgpu_bo_print_info(id++,	bo_va->base.bo, m);
 	}
+	spin_unlock(&vm->invalidated_lock);
 	total_invalidated_objs = id;
 	id = 0;
 
@@ -3104,7 +3097,6 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 			continue;
 		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
 	}
-	spin_unlock(&vm->status_lock);
 	total_done_objs = id;
 
 	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 74e61e45778e..829b400cb8c0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -203,11 +203,11 @@ struct amdgpu_vm_bo_base {
 	/* protected by bo being reserved */
 	struct amdgpu_vm_bo_base	*next;
 
-	/* protected by vm status_lock */
+	/* protected by vm reservation and invalidated_lock */
 	struct list_head		vm_status;
 
 	/* if the bo is counted as shared in mem stats
-	 * protected by vm status_lock */
+	 * protected by vm BO being reserved */
 	bool				shared;
 
 	/* protected by the BO being reserved */
@@ -343,10 +343,8 @@ struct amdgpu_vm {
 	bool			evicting;
 	unsigned int		saved_flags;
 
-	/* Lock to protect vm_bo add/del/move on all lists of vm */
-	spinlock_t		status_lock;
-
-	/* Memory statistics for this vm, protected by status_lock */
+	/* Memory statistics for this vm, protected by stats_lock */
+	spinlock_t		stats_lock;
 	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
 
 	/*
@@ -354,6 +352,8 @@ struct amdgpu_vm {
 	 * PDs, PTs or per VM BOs. The state transits are:
 	 *
 	 * evicted -> relocated (PDs, PTs) or moved (per VM BOs) -> idle
+	 *
+	 * Lists are protected by the root PD dma_resv lock.
 	 */
 
 	/* Per-VM and PT BOs who needs a validation */
@@ -374,7 +374,10 @@ struct amdgpu_vm {
 	 * state transits are:
 	 *
 	 * evicted_user or invalidated -> done
+	 *
+	 * Lists are protected by the invalidated_lock.
 	 */
+	spinlock_t		invalidated_lock;
 
 	/* BOs for user mode queues that need a validation */
 	struct list_head	evicted_user;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 30022123b0bf..f57c48b74274 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -541,9 +541,7 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	entry->bo->vm_bo = NULL;
 	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
 
-	spin_lock(&entry->vm->status_lock);
 	list_del(&entry->vm_status);
-	spin_unlock(&entry->vm->status_lock);
 	amdgpu_bo_unref(&entry->bo);
 }
 
@@ -587,7 +585,6 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
 	struct amdgpu_vm_pt_cursor seek;
 	struct amdgpu_vm_bo_base *entry;
 
-	spin_lock(&params->vm->status_lock);
 	for_each_amdgpu_vm_pt_dfs_safe(params->adev, params->vm, cursor, seek, entry) {
 		if (entry && entry->bo)
 			list_move(&entry->vm_status, &params->tlb_flush_waitlist);
@@ -595,7 +592,6 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
 
 	/* enter start node now */
 	list_move(&cursor->entry->vm_status, &params->tlb_flush_waitlist);
-	spin_unlock(&params->vm->status_lock);
 }
 
 /**
-- 
2.43.0


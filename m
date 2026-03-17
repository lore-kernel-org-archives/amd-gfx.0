Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A21FFD7075
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 10:55:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A441010E5D3;
	Tue, 17 Mar 2026 10:55:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rbg1PYjb";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 025A110E5CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 10:55:10 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-43b49819938so518729f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 03:55:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773744909; x=1774349709; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r96RRc5syTLmVx0LgSBj2Sv4dg2JfZFdXV0Hp4YO0xQ=;
 b=Rbg1PYjb5x1jVLNbesCSuIlTm17Wic0Sr0Z0rEiJ9vlKW9jxhhAuui5w8paVho814D
 Z9qvgyle9Hi6JJdHLVuqZHWWi7GIDm1Pt5npMBxTWhumpMRyRxX0iz6Oj0UNhA6iyNjg
 KSFD7lPw1sKJx3IDwrHm4ugTvTx7cualfDc3KI7luIn9RSur6Mk1dY5h9D2pi+OBxlTO
 6nUDTm4V0ZRNadF9ccOuh04TiW+6TQVF0eS+JfgyvGeA7tZH0AaX0xcnrUCbZohQM9Tg
 /ILCe51kf6fy6XSxjUQwtZ60CUa7cX1dTx1yusp1D329FskdCoiqcyEF6Tub9hHgFS2I
 NgQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773744909; x=1774349709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r96RRc5syTLmVx0LgSBj2Sv4dg2JfZFdXV0Hp4YO0xQ=;
 b=SsN95svRZ3mhTyvxUqBAztojlL1vjMzt+yYI6N/KouudR4VfFMvhJDR+ktHmUkbsSR
 HlkN9EUcOuJcpkIy/L/n3tvUDlsCkNHto0qigsbqfV1mw12nlIZnDOO+ITTwGghq4ozF
 bNQXf2tSuyD+6J7+xl2Ju8Wj3Rt+opZPo+sGcMthuVM3qSy1oYkVi1xuwJbKywCvgAXr
 F/jVKoJrm0JCoLK9JTELRyga3aH7AZhvCT5tiNFxx1M46d6ZwXjaw58qtwVieTG6MWgK
 9zUm6bYvoURobBBZL/c6RZkAsEvlsTTwRNpszvuQorRTTUdaNtFSNbTAuKkQHHupvOgV
 bIYg==
X-Gm-Message-State: AOJu0YyruJHisXW+8vD/uXL53M0fNufQSC6mpx+4p28rJW6Bm+xtyxmz
 EmySbUeSb4Jg/qApRA7uSddsvkbLzPZqc90s6V+E1NIDYVbSyBh9ODKiYbR8+vyA
X-Gm-Gg: ATEYQzymDLUkap35D5W37kQVmrfvZaTkQb2e2+Azm945pM+CJcCN6FOjb5MZ1aBbNTp
 A72CQiGA7Z+/630LkuCz4MRx/1C6FFqyw6+mWY7nDBvmWo8UvXMWv/hx0qEzsyMWs10ucxvJ7Bf
 F1tyi5iMs6aOVB+TDXokffzwvEDZ4O/FY7dcaO0MwHOL/ibMTrLOAsIiJlQe1uHMPItfduNXn+/
 yeUcJJ8xpqCjQ+AWR0hsZNDG4aS0e1hPnUdvr9320FiOFi84uaAaK2XeiG41h/7C7JQVhd8v4Zp
 mpTjv/VEOY/0h0b7zrPCLE4IthHdlgWmv90/rqeEyVThvMwURrOv3P7FWHAdocMyG6YGqQTe6pe
 qOTs0a2K4TkGrz49g319tQZ/ayWo1rBGK48GyRwRU7OvfhWiKVkFpJUy6dvbsXAZjL2VzcmFDY2
 4oomqAZhLq8zXvWPIoDv5wU/i8EBUReHf8nRUn
X-Received: by 2002:a05:6000:310a:b0:439:de1d:74ae with SMTP id
 ffacd0b85a97d-43a04d868c3mr30435729f8f.22.1773744909176; 
 Tue, 17 Mar 2026 03:55:09 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1570:2300:fbdd:8811:84b7:347c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20bd9csm49852223f8f.21.2026.03.17.03.55.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 03:55:08 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: sukhatri@amd.com, tursulin@ursulin.net, Alexander.Deucher@amd.com,
 Prike.Liang@amd.com, SRINIVASAN.SHANMUGAM@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/10] drm/amdgpu: revert to old status lock handling v4
Date: Tue, 17 Mar 2026 11:54:58 +0100
Message-ID: <20260317105501.21479-8-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317105501.21479-1-christian.koenig@amd.com>
References: <20260317105501.21479-1-christian.koenig@amd.com>
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
v4: re-apply by fixing holding the VM lock at the right places.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 146 ++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  15 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |   4 -
 4 files changed, 68 insertions(+), 105 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 2c1b8bbbc903..c50a484d22e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1041,12 +1041,12 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
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
@@ -1063,9 +1063,9 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
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
index 01fef0e4f408..b89013a6aa0b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -153,12 +153,10 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
 
 	vm_bo->moved = true;
 	amdgpu_vm_assert_locked(vm);
-	spin_lock(&vm_bo->vm->status_lock);
 	if (bo->tbo.type == ttm_bo_type_kernel)
 		list_move(&vm_bo->vm_status, &vm->evicted);
 	else
 		list_move_tail(&vm_bo->vm_status, &vm->evicted);
-	spin_unlock(&vm_bo->vm->status_lock);
 }
 /**
  * amdgpu_vm_bo_moved - vm_bo is moved
@@ -171,9 +169,7 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
 static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
 {
 	amdgpu_vm_assert_locked(vm_bo->vm);
-	spin_lock(&vm_bo->vm->status_lock);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
-	spin_unlock(&vm_bo->vm->status_lock);
 }
 
 /**
@@ -187,9 +183,7 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
 static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
 {
 	amdgpu_vm_assert_locked(vm_bo->vm);
-	spin_lock(&vm_bo->vm->status_lock);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
-	spin_unlock(&vm_bo->vm->status_lock);
 	vm_bo->moved = false;
 }
 
@@ -203,9 +197,9 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
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
@@ -218,10 +212,9 @@ static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
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
@@ -235,13 +228,10 @@ static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
 static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
 {
 	amdgpu_vm_assert_locked(vm_bo->vm);
-	if (vm_bo->bo->parent) {
-		spin_lock(&vm_bo->vm->status_lock);
+	if (vm_bo->bo->parent)
 		list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
-		spin_unlock(&vm_bo->vm->status_lock);
-	} else {
+	else
 		amdgpu_vm_bo_idle(vm_bo);
-	}
 }
 
 /**
@@ -255,9 +245,7 @@ static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
 static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
 {
 	amdgpu_vm_assert_locked(vm_bo->vm);
-	spin_lock(&vm_bo->vm->status_lock);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->done);
-	spin_unlock(&vm_bo->vm->status_lock);
 }
 
 /**
@@ -271,13 +259,13 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
 {
 	struct amdgpu_vm_bo_base *vm_bo, *tmp;
 
-	amdgpu_vm_assert_locked(vm);
-
-	spin_lock(&vm->status_lock);
+	spin_lock(&vm->invalidated_lock);
 	list_splice_init(&vm->done, &vm->invalidated);
 	list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
 		vm_bo->moved = true;
+	spin_unlock(&vm->invalidated_lock);
 
+	amdgpu_vm_assert_locked(vm);
 	list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
 		struct amdgpu_bo *bo = vm_bo->bo;
 
@@ -287,14 +275,13 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
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
@@ -307,7 +294,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
 	bool shared;
 
 	dma_resv_assert_held(bo->tbo.base.resv);
-	spin_lock(&vm->status_lock);
+	spin_lock(&vm->stats_lock);
 	shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
 	if (base->shared != shared) {
 		base->shared = shared;
@@ -319,7 +306,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
 			vm->stats[bo_memtype].drm.private += size;
 		}
 	}
-	spin_unlock(&vm->status_lock);
+	spin_unlock(&vm->stats_lock);
 }
 
 /**
@@ -344,11 +331,11 @@ void amdgpu_vm_bo_update_shared(struct amdgpu_bo *bo)
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
@@ -372,7 +359,8 @@ static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
 		 */
 		if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
 			vm->stats[res_memtype].drm.purgeable += size;
-		if (!(bo->preferred_domains & amdgpu_mem_type_to_domain(res_memtype)))
+		if (!(bo->preferred_domains &
+		      amdgpu_mem_type_to_domain(res_memtype)))
 			vm->stats[bo_memtype].evicted += size;
 	}
 }
@@ -391,9 +379,9 @@ void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
 {
 	struct amdgpu_vm *vm = base->vm;
 
-	spin_lock(&vm->status_lock);
+	spin_lock(&vm->stats_lock);
 	amdgpu_vm_update_stats_locked(base, res, sign);
-	spin_unlock(&vm->status_lock);
+	spin_unlock(&vm->stats_lock);
 }
 
 /**
@@ -419,10 +407,10 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
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
@@ -481,25 +469,25 @@ int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
 	int ret;
 
 	/* We can only trust prev->next while holding the lock */
-	spin_lock(&vm->status_lock);
+	spin_lock(&vm->invalidated_lock);
 	while (!list_is_head(prev->next, &vm->done)) {
 		bo_va = list_entry(prev->next, typeof(*bo_va), base.vm_status);
 
 		bo = bo_va->base.bo;
 		if (bo) {
 			amdgpu_bo_ref(bo);
-			spin_unlock(&vm->status_lock);
+			spin_unlock(&vm->invalidated_lock);
 
 			ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 1);
 			amdgpu_bo_unref(&bo);
 			if (unlikely(ret))
 				return ret;
 
-			spin_lock(&vm->status_lock);
+			spin_lock(&vm->invalidated_lock);
 		}
 		prev = prev->next;
 	}
-	spin_unlock(&vm->status_lock);
+	spin_unlock(&vm->invalidated_lock);
 
 	return 0;
 }
@@ -595,7 +583,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       void *param)
 {
 	uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
-	struct amdgpu_vm_bo_base *bo_base;
+	struct amdgpu_vm_bo_base *bo_base, *tmp;
 	struct amdgpu_bo *bo;
 	int r;
 
@@ -608,13 +596,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -627,26 +609,21 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
+	if (ticket) {
+		list_for_each_entry_safe(bo_base, tmp, &vm->evicted_user,
+					 vm_status) {
+			bo = bo_base->bo;
+			dma_resv_assert_held(bo->tbo.base.resv);
 
-		r = validate(param, bo);
-		if (r)
-			return r;
-
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
@@ -675,9 +652,7 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 	ret = !vm->evicting;
 	amdgpu_vm_eviction_unlock(vm);
 
-	spin_lock(&vm->status_lock);
 	ret &= list_empty(&vm->evicted);
-	spin_unlock(&vm->status_lock);
 
 	spin_lock(&vm->immediate.lock);
 	ret &= !vm->immediate.stopped;
@@ -971,18 +946,13 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm, bool immediate)
 {
 	struct amdgpu_vm_update_params params;
-	struct amdgpu_vm_bo_base *entry;
+	struct amdgpu_vm_bo_base *entry, *tmp;
 	bool flush_tlb_needed = false;
-	LIST_HEAD(relocated);
 	int r, idx;
 
 	amdgpu_vm_assert_locked(vm);
 
-	spin_lock(&vm->status_lock);
-	list_splice_init(&vm->relocated, &relocated);
-	spin_unlock(&vm->status_lock);
-
-	if (list_empty(&relocated))
+	if (list_empty(&vm->relocated))
 		return 0;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
@@ -998,7 +968,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
-	list_for_each_entry(entry, &relocated, vm_status) {
+	list_for_each_entry(entry, &vm->relocated, vm_status) {
 		/* vm_flush_needed after updating moved PDEs */
 		flush_tlb_needed |= entry->moved;
 
@@ -1014,9 +984,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (flush_tlb_needed)
 		atomic64_inc(&vm->tlb_seq);
 
-	while (!list_empty(&relocated)) {
-		entry = list_first_entry(&relocated, struct amdgpu_vm_bo_base,
-					 vm_status);
+	list_for_each_entry_safe(entry, tmp, &vm->relocated, vm_status) {
 		amdgpu_vm_bo_idle(entry);
 	}
 
@@ -1243,9 +1211,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -1612,29 +1580,24 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
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
@@ -1666,9 +1629,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
 			amdgpu_vm_bo_evicted_user(&bo_va->base);
 
-		spin_lock(&vm->status_lock);
+		spin_lock(&vm->invalidated_lock);
 	}
-	spin_unlock(&vm->status_lock);
+	spin_unlock(&vm->invalidated_lock);
 
 	return 0;
 }
@@ -2211,9 +2174,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 		}
 	}
 
-	spin_lock(&vm->status_lock);
+	spin_lock(&vm->invalidated_lock);
 	list_del(&bo_va->base.vm_status);
-	spin_unlock(&vm->status_lock);
+	spin_unlock(&vm->invalidated_lock);
 
 	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
 		list_del(&mapping->list);
@@ -2321,10 +2284,10 @@ void amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
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
@@ -2596,11 +2559,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -3068,7 +3032,6 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 
 	amdgpu_vm_assert_locked(vm);
 
-	spin_lock(&vm->status_lock);
 	seq_puts(m, "\tIdle BOs:\n");
 	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
 		if (!bo_va->base.bo)
@@ -3106,11 +3069,13 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
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
 
@@ -3120,7 +3085,6 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 			continue;
 		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
 	}
-	spin_unlock(&vm->status_lock);
 	total_done_objs = id;
 
 	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index dc4b0ec672ec..ae9449d5b00c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -205,11 +205,11 @@ struct amdgpu_vm_bo_base {
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
@@ -345,10 +345,8 @@ struct amdgpu_vm {
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
@@ -356,6 +354,8 @@ struct amdgpu_vm {
 	 * PDs, PTs or per VM BOs. The state transits are:
 	 *
 	 * evicted -> relocated (PDs, PTs) or moved (per VM BOs) -> idle
+	 *
+	 * Lists are protected by the root PD dma_resv lock.
 	 */
 
 	/* Per-VM and PT BOs who needs a validation */
@@ -376,7 +376,10 @@ struct amdgpu_vm {
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
index 31a437ce9570..7bdd664f0770 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -544,9 +544,7 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	entry->bo->vm_bo = NULL;
 	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
 
-	spin_lock(&entry->vm->status_lock);
 	list_del(&entry->vm_status);
-	spin_unlock(&entry->vm->status_lock);
 	amdgpu_bo_unref(&entry->bo);
 }
 
@@ -590,7 +588,6 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
 	struct amdgpu_vm_pt_cursor seek;
 	struct amdgpu_vm_bo_base *entry;
 
-	spin_lock(&params->vm->status_lock);
 	for_each_amdgpu_vm_pt_dfs_safe(params->adev, params->vm, cursor, seek, entry) {
 		if (entry && entry->bo)
 			list_move(&entry->vm_status, &params->tlb_flush_waitlist);
@@ -598,7 +595,6 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
 
 	/* enter start node now */
 	list_move(&cursor->entry->vm_status, &params->tlb_flush_waitlist);
-	spin_unlock(&params->vm->status_lock);
 }
 
 /**
-- 
2.43.0


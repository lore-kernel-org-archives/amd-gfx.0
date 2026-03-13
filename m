Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7336107BCD5
	for <amd-gfx@archiver.kernel.org>; Fri, 13 Mar 2026 18:09:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 737F110EC4D;
	Fri, 13 Mar 2026 18:09:05 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.156.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C548A10EC4D
 for <amd-gfx@lists.freedesktop.org>; Fri, 13 Mar 2026 18:09:03 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 62DI8wdY4011201; Fri, 13 Mar 2026 23:38:58 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 62DI8vCQ4011195;
 Fri, 13 Mar 2026 23:38:57 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v1] Revert "drm/amdgpu: revert to old status lock handling v4"
Date: Fri, 13 Mar 2026 23:38:57 +0530
Message-Id: <20260313180857.4011133-1-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
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

This reverts commit 16410ab88726e098332e79f2a950b8b452ed0cb4.

Reverting due to some of the probable issues caused by this change
and CI is blocked.

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 146 ++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  15 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |   4 +
 4 files changed, 105 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index cd599b4a9d75..8681582bb3a9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1040,12 +1040,12 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
 	struct amdgpu_bo *bo;
 	int ret;
 
-	spin_lock(&vm->invalidated_lock);
+	spin_lock(&vm->status_lock);
 	while (!list_empty(&vm->invalidated)) {
 		bo_va = list_first_entry(&vm->invalidated,
 					 struct amdgpu_bo_va,
 					 base.vm_status);
-		spin_unlock(&vm->invalidated_lock);
+		spin_unlock(&vm->status_lock);
 
 		bo = bo_va->base.bo;
 		ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 2);
@@ -1062,9 +1062,9 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
 		if (ret)
 			return ret;
 
-		spin_lock(&vm->invalidated_lock);
+		spin_lock(&vm->status_lock);
 	}
-	spin_unlock(&vm->invalidated_lock);
+	spin_unlock(&vm->status_lock);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b89013a6aa0b..01fef0e4f408 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -153,10 +153,12 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
 
 	vm_bo->moved = true;
 	amdgpu_vm_assert_locked(vm);
+	spin_lock(&vm_bo->vm->status_lock);
 	if (bo->tbo.type == ttm_bo_type_kernel)
 		list_move(&vm_bo->vm_status, &vm->evicted);
 	else
 		list_move_tail(&vm_bo->vm_status, &vm->evicted);
+	spin_unlock(&vm_bo->vm->status_lock);
 }
 /**
  * amdgpu_vm_bo_moved - vm_bo is moved
@@ -169,7 +171,9 @@ static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
 static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
 {
 	amdgpu_vm_assert_locked(vm_bo->vm);
+	spin_lock(&vm_bo->vm->status_lock);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
+	spin_unlock(&vm_bo->vm->status_lock);
 }
 
 /**
@@ -183,7 +187,9 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
 static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
 {
 	amdgpu_vm_assert_locked(vm_bo->vm);
+	spin_lock(&vm_bo->vm->status_lock);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
+	spin_unlock(&vm_bo->vm->status_lock);
 	vm_bo->moved = false;
 }
 
@@ -197,9 +203,9 @@ static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
 {
-	spin_lock(&vm_bo->vm->invalidated_lock);
+	spin_lock(&vm_bo->vm->status_lock);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
-	spin_unlock(&vm_bo->vm->invalidated_lock);
+	spin_unlock(&vm_bo->vm->status_lock);
 }
 
 /**
@@ -212,9 +218,10 @@ static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
  */
 static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
 {
-	amdgpu_vm_assert_locked(vm_bo->vm);
 	vm_bo->moved = true;
+	spin_lock(&vm_bo->vm->status_lock);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
+	spin_unlock(&vm_bo->vm->status_lock);
 }
 
 /**
@@ -228,10 +235,13 @@ static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
 static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
 {
 	amdgpu_vm_assert_locked(vm_bo->vm);
-	if (vm_bo->bo->parent)
+	if (vm_bo->bo->parent) {
+		spin_lock(&vm_bo->vm->status_lock);
 		list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
-	else
+		spin_unlock(&vm_bo->vm->status_lock);
+	} else {
 		amdgpu_vm_bo_idle(vm_bo);
+	}
 }
 
 /**
@@ -245,7 +255,9 @@ static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
 static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
 {
 	amdgpu_vm_assert_locked(vm_bo->vm);
+	spin_lock(&vm_bo->vm->status_lock);
 	list_move(&vm_bo->vm_status, &vm_bo->vm->done);
+	spin_unlock(&vm_bo->vm->status_lock);
 }
 
 /**
@@ -259,13 +271,13 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
 {
 	struct amdgpu_vm_bo_base *vm_bo, *tmp;
 
-	spin_lock(&vm->invalidated_lock);
+	amdgpu_vm_assert_locked(vm);
+
+	spin_lock(&vm->status_lock);
 	list_splice_init(&vm->done, &vm->invalidated);
 	list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
 		vm_bo->moved = true;
-	spin_unlock(&vm->invalidated_lock);
 
-	amdgpu_vm_assert_locked(vm);
 	list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
 		struct amdgpu_bo *bo = vm_bo->bo;
 
@@ -275,13 +287,14 @@ static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
 		else if (bo->parent)
 			list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
 	}
+	spin_unlock(&vm->status_lock);
 }
 
 /**
  * amdgpu_vm_update_shared - helper to update shared memory stat
  * @base: base structure for tracking BO usage in a VM
  *
- * Takes the vm stats_lock and updates the shared memory stat. If the basic
+ * Takes the vm status_lock and updates the shared memory stat. If the basic
  * stat changed (e.g. buffer was moved) amdgpu_vm_update_stats need to be called
  * as well.
  */
@@ -294,7 +307,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
 	bool shared;
 
 	dma_resv_assert_held(bo->tbo.base.resv);
-	spin_lock(&vm->stats_lock);
+	spin_lock(&vm->status_lock);
 	shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
 	if (base->shared != shared) {
 		base->shared = shared;
@@ -306,7 +319,7 @@ static void amdgpu_vm_update_shared(struct amdgpu_vm_bo_base *base)
 			vm->stats[bo_memtype].drm.private += size;
 		}
 	}
-	spin_unlock(&vm->stats_lock);
+	spin_unlock(&vm->status_lock);
 }
 
 /**
@@ -331,11 +344,11 @@ void amdgpu_vm_bo_update_shared(struct amdgpu_bo *bo)
  *        be bo->tbo.resource
  * @sign: if we should add (+1) or subtract (-1) from the stat
  *
- * Caller need to have the vm stats_lock held. Useful for when multiple update
+ * Caller need to have the vm status_lock held. Useful for when multiple update
  * need to happen at the same time.
  */
 static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
-					  struct ttm_resource *res, int sign)
+			    struct ttm_resource *res, int sign)
 {
 	struct amdgpu_vm *vm = base->vm;
 	struct amdgpu_bo *bo = base->bo;
@@ -359,8 +372,7 @@ static void amdgpu_vm_update_stats_locked(struct amdgpu_vm_bo_base *base,
 		 */
 		if (bo->flags & AMDGPU_GEM_CREATE_DISCARDABLE)
 			vm->stats[res_memtype].drm.purgeable += size;
-		if (!(bo->preferred_domains &
-		      amdgpu_mem_type_to_domain(res_memtype)))
+		if (!(bo->preferred_domains & amdgpu_mem_type_to_domain(res_memtype)))
 			vm->stats[bo_memtype].evicted += size;
 	}
 }
@@ -379,9 +391,9 @@ void amdgpu_vm_update_stats(struct amdgpu_vm_bo_base *base,
 {
 	struct amdgpu_vm *vm = base->vm;
 
-	spin_lock(&vm->stats_lock);
+	spin_lock(&vm->status_lock);
 	amdgpu_vm_update_stats_locked(base, res, sign);
-	spin_unlock(&vm->stats_lock);
+	spin_unlock(&vm->status_lock);
 }
 
 /**
@@ -407,10 +419,10 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 	base->next = bo->vm_bo;
 	bo->vm_bo = base;
 
-	spin_lock(&vm->stats_lock);
+	spin_lock(&vm->status_lock);
 	base->shared = drm_gem_object_is_shared_for_memory_stats(&bo->tbo.base);
 	amdgpu_vm_update_stats_locked(base, bo->tbo.resource, +1);
-	spin_unlock(&vm->stats_lock);
+	spin_unlock(&vm->status_lock);
 
 	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
 		return;
@@ -469,25 +481,25 @@ int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
 	int ret;
 
 	/* We can only trust prev->next while holding the lock */
-	spin_lock(&vm->invalidated_lock);
+	spin_lock(&vm->status_lock);
 	while (!list_is_head(prev->next, &vm->done)) {
 		bo_va = list_entry(prev->next, typeof(*bo_va), base.vm_status);
 
 		bo = bo_va->base.bo;
 		if (bo) {
 			amdgpu_bo_ref(bo);
-			spin_unlock(&vm->invalidated_lock);
+			spin_unlock(&vm->status_lock);
 
 			ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 1);
 			amdgpu_bo_unref(&bo);
 			if (unlikely(ret))
 				return ret;
 
-			spin_lock(&vm->invalidated_lock);
+			spin_lock(&vm->status_lock);
 		}
 		prev = prev->next;
 	}
-	spin_unlock(&vm->invalidated_lock);
+	spin_unlock(&vm->status_lock);
 
 	return 0;
 }
@@ -583,7 +595,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       void *param)
 {
 	uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
-	struct amdgpu_vm_bo_base *bo_base, *tmp;
+	struct amdgpu_vm_bo_base *bo_base;
 	struct amdgpu_bo *bo;
 	int r;
 
@@ -596,7 +608,13 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			return r;
 	}
 
-	list_for_each_entry_safe(bo_base, tmp, &vm->evicted, vm_status) {
+	spin_lock(&vm->status_lock);
+	while (!list_empty(&vm->evicted)) {
+		bo_base = list_first_entry(&vm->evicted,
+					   struct amdgpu_vm_bo_base,
+					   vm_status);
+		spin_unlock(&vm->status_lock);
+
 		bo = bo_base->bo;
 
 		r = validate(param, bo);
@@ -609,21 +627,26 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
 			amdgpu_vm_bo_relocated(bo_base);
 		}
+		spin_lock(&vm->status_lock);
 	}
+	while (ticket && !list_empty(&vm->evicted_user)) {
+		bo_base = list_first_entry(&vm->evicted_user,
+					   struct amdgpu_vm_bo_base,
+					   vm_status);
+		spin_unlock(&vm->status_lock);
 
-	if (ticket) {
-		list_for_each_entry_safe(bo_base, tmp, &vm->evicted_user,
-					 vm_status) {
-			bo = bo_base->bo;
-			dma_resv_assert_held(bo->tbo.base.resv);
+		bo = bo_base->bo;
+		dma_resv_assert_held(bo->tbo.base.resv);
 
-			r = validate(param, bo);
-			if (r)
-				return r;
+		r = validate(param, bo);
+		if (r)
+			return r;
 
-			amdgpu_vm_bo_invalidated(bo_base);
-		}
+		amdgpu_vm_bo_invalidated(bo_base);
+
+		spin_lock(&vm->status_lock);
 	}
+	spin_unlock(&vm->status_lock);
 
 	amdgpu_vm_eviction_lock(vm);
 	vm->evicting = false;
@@ -652,7 +675,9 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 	ret = !vm->evicting;
 	amdgpu_vm_eviction_unlock(vm);
 
+	spin_lock(&vm->status_lock);
 	ret &= list_empty(&vm->evicted);
+	spin_unlock(&vm->status_lock);
 
 	spin_lock(&vm->immediate.lock);
 	ret &= !vm->immediate.stopped;
@@ -946,13 +971,18 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm, bool immediate)
 {
 	struct amdgpu_vm_update_params params;
-	struct amdgpu_vm_bo_base *entry, *tmp;
+	struct amdgpu_vm_bo_base *entry;
 	bool flush_tlb_needed = false;
+	LIST_HEAD(relocated);
 	int r, idx;
 
 	amdgpu_vm_assert_locked(vm);
 
-	if (list_empty(&vm->relocated))
+	spin_lock(&vm->status_lock);
+	list_splice_init(&vm->relocated, &relocated);
+	spin_unlock(&vm->status_lock);
+
+	if (list_empty(&relocated))
 		return 0;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
@@ -968,7 +998,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
-	list_for_each_entry(entry, &vm->relocated, vm_status) {
+	list_for_each_entry(entry, &relocated, vm_status) {
 		/* vm_flush_needed after updating moved PDEs */
 		flush_tlb_needed |= entry->moved;
 
@@ -984,7 +1014,9 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (flush_tlb_needed)
 		atomic64_inc(&vm->tlb_seq);
 
-	list_for_each_entry_safe(entry, tmp, &vm->relocated, vm_status) {
+	while (!list_empty(&relocated)) {
+		entry = list_first_entry(&relocated, struct amdgpu_vm_bo_base,
+					 vm_status);
 		amdgpu_vm_bo_idle(entry);
 	}
 
@@ -1211,9 +1243,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
 			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
 {
-	spin_lock(&vm->stats_lock);
+	spin_lock(&vm->status_lock);
 	memcpy(stats, vm->stats, sizeof(*stats) * __AMDGPU_PL_NUM);
-	spin_unlock(&vm->stats_lock);
+	spin_unlock(&vm->status_lock);
 }
 
 /**
@@ -1580,24 +1612,29 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 			   struct amdgpu_vm *vm,
 			   struct ww_acquire_ctx *ticket)
 {
-	struct amdgpu_bo_va *bo_va, *tmp;
+	struct amdgpu_bo_va *bo_va;
 	struct dma_resv *resv;
 	bool clear, unlock;
 	int r;
 
-	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
+	spin_lock(&vm->status_lock);
+	while (!list_empty(&vm->moved)) {
+		bo_va = list_first_entry(&vm->moved, struct amdgpu_bo_va,
+					 base.vm_status);
+		spin_unlock(&vm->status_lock);
+
 		/* Per VM BOs never need to bo cleared in the page tables */
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			return r;
+		spin_lock(&vm->status_lock);
 	}
 
-	spin_lock(&vm->invalidated_lock);
 	while (!list_empty(&vm->invalidated)) {
 		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
 					 base.vm_status);
 		resv = bo_va->base.bo->tbo.base.resv;
-		spin_unlock(&vm->invalidated_lock);
+		spin_unlock(&vm->status_lock);
 
 		/* Try to reserve the BO to avoid clearing its ptes */
 		if (!adev->debug_vm && dma_resv_trylock(resv)) {
@@ -1629,9 +1666,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
 			amdgpu_vm_bo_evicted_user(&bo_va->base);
 
-		spin_lock(&vm->invalidated_lock);
+		spin_lock(&vm->status_lock);
 	}
-	spin_unlock(&vm->invalidated_lock);
+	spin_unlock(&vm->status_lock);
 
 	return 0;
 }
@@ -2174,9 +2211,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 		}
 	}
 
-	spin_lock(&vm->invalidated_lock);
+	spin_lock(&vm->status_lock);
 	list_del(&bo_va->base.vm_status);
-	spin_unlock(&vm->invalidated_lock);
+	spin_unlock(&vm->status_lock);
 
 	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
 		list_del(&mapping->list);
@@ -2284,10 +2321,10 @@ void amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
 	for (bo_base = bo->vm_bo; bo_base; bo_base = bo_base->next) {
 		struct amdgpu_vm *vm = bo_base->vm;
 
-		spin_lock(&vm->stats_lock);
+		spin_lock(&vm->status_lock);
 		amdgpu_vm_update_stats_locked(bo_base, bo->tbo.resource, -1);
 		amdgpu_vm_update_stats_locked(bo_base, new_mem, +1);
-		spin_unlock(&vm->stats_lock);
+		spin_unlock(&vm->status_lock);
 	}
 
 	amdgpu_vm_bo_invalidate(bo, evicted);
@@ -2559,12 +2596,11 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	INIT_LIST_HEAD(&vm->relocated);
 	INIT_LIST_HEAD(&vm->moved);
 	INIT_LIST_HEAD(&vm->idle);
-	spin_lock_init(&vm->invalidated_lock);
 	INIT_LIST_HEAD(&vm->invalidated);
+	spin_lock_init(&vm->status_lock);
 	INIT_LIST_HEAD(&vm->freed);
 	INIT_LIST_HEAD(&vm->done);
 	INIT_KFIFO(vm->faults);
-	spin_lock_init(&vm->stats_lock);
 
 	r = amdgpu_vm_init_entities(adev, vm);
 	if (r)
@@ -3032,6 +3068,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 
 	amdgpu_vm_assert_locked(vm);
 
+	spin_lock(&vm->status_lock);
 	seq_puts(m, "\tIdle BOs:\n");
 	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
 		if (!bo_va->base.bo)
@@ -3069,13 +3106,11 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 	id = 0;
 
 	seq_puts(m, "\tInvalidated BOs:\n");
-	spin_lock(&vm->invalidated_lock);
 	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
 		if (!bo_va->base.bo)
 			continue;
 		total_invalidated += amdgpu_bo_print_info(id++,	bo_va->base.bo, m);
 	}
-	spin_unlock(&vm->invalidated_lock);
 	total_invalidated_objs = id;
 	id = 0;
 
@@ -3085,6 +3120,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 			continue;
 		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
 	}
+	spin_unlock(&vm->status_lock);
 	total_done_objs = id;
 
 	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index ae9449d5b00c..dc4b0ec672ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -205,11 +205,11 @@ struct amdgpu_vm_bo_base {
 	/* protected by bo being reserved */
 	struct amdgpu_vm_bo_base	*next;
 
-	/* protected by vm reservation and invalidated_lock */
+	/* protected by vm status_lock */
 	struct list_head		vm_status;
 
 	/* if the bo is counted as shared in mem stats
-	 * protected by vm BO being reserved */
+	 * protected by vm status_lock */
 	bool				shared;
 
 	/* protected by the BO being reserved */
@@ -345,8 +345,10 @@ struct amdgpu_vm {
 	bool			evicting;
 	unsigned int		saved_flags;
 
-	/* Memory statistics for this vm, protected by stats_lock */
-	spinlock_t		stats_lock;
+	/* Lock to protect vm_bo add/del/move on all lists of vm */
+	spinlock_t		status_lock;
+
+	/* Memory statistics for this vm, protected by status_lock */
 	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
 
 	/*
@@ -354,8 +356,6 @@ struct amdgpu_vm {
 	 * PDs, PTs or per VM BOs. The state transits are:
 	 *
 	 * evicted -> relocated (PDs, PTs) or moved (per VM BOs) -> idle
-	 *
-	 * Lists are protected by the root PD dma_resv lock.
 	 */
 
 	/* Per-VM and PT BOs who needs a validation */
@@ -376,10 +376,7 @@ struct amdgpu_vm {
 	 * state transits are:
 	 *
 	 * evicted_user or invalidated -> done
-	 *
-	 * Lists are protected by the invalidated_lock.
 	 */
-	spinlock_t		invalidated_lock;
 
 	/* BOs for user mode queues that need a validation */
 	struct list_head	evicted_user;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 7bdd664f0770..31a437ce9570 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -544,7 +544,9 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	entry->bo->vm_bo = NULL;
 	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
 
+	spin_lock(&entry->vm->status_lock);
 	list_del(&entry->vm_status);
+	spin_unlock(&entry->vm->status_lock);
 	amdgpu_bo_unref(&entry->bo);
 }
 
@@ -588,6 +590,7 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
 	struct amdgpu_vm_pt_cursor seek;
 	struct amdgpu_vm_bo_base *entry;
 
+	spin_lock(&params->vm->status_lock);
 	for_each_amdgpu_vm_pt_dfs_safe(params->adev, params->vm, cursor, seek, entry) {
 		if (entry && entry->bo)
 			list_move(&entry->vm_status, &params->tlb_flush_waitlist);
@@ -595,6 +598,7 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
 
 	/* enter start node now */
 	list_move(&cursor->entry->vm_status, &params->tlb_flush_waitlist);
+	spin_unlock(&params->vm->status_lock);
 }
 
 /**
-- 
2.34.1


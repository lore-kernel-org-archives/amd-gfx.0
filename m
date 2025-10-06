Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FDCCCA471
	for <amd-gfx@archiver.kernel.org>; Mon,  6 Oct 2025 10:47:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16B7210E312;
	Mon,  6 Oct 2025 10:47:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CBxSHz+i";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3A6310E312
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 Oct 2025 10:47:22 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-42557c5cedcso2436012f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 06 Oct 2025 03:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1759747641; x=1760352441; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Zfexq9Nz8eX4F9FqVUiF23fIPTyGryU+7xs9lxmiydY=;
 b=CBxSHz+iKVybvDO2wGJotxTasRokTVWG8Eqa56dHIWn3LOwAkjovS94dONVwrqbMfC
 8QMlO2BoXl3puuW96Ddw5RU7iSN/Vg9Aqe5JC6B7TBNXntjaxci+ebgGIHqgZDj936h2
 zWwovVMMwDvhNNiqRLfNLChIu8RSJ088L2xP6PIH/dyw3Fuo+QOckBlRVTqPBKFGt2vl
 fUCop92W1sfcU7lhGz6xF//jibandmAqCxI86ufmBYQ8S1mhsEhP/BEo2M/RDblYf7wT
 K8yr+rJwMGuXQSjqsOufP3IpVcylrfpZ/vv/OUltJsLE8xp6KXp2jP7vOMkWJIEvQQm6
 rEPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759747641; x=1760352441;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Zfexq9Nz8eX4F9FqVUiF23fIPTyGryU+7xs9lxmiydY=;
 b=fHCZhe01MFdivzZP5Fb9EL+oUj/fFL3mC8d8aHF47K9ULqwcCVbbFESt5Du/1V0nr1
 HF4yR5Le9i+mejNkqxvKeRMperGKeHZ76tcCHUGXEnifgMHz/1BVwt6ayNWVrjIiMsMP
 E3hs1m9ye2SgiGJt7YcqzIW5c34McEGkOT1sE6pKO7b5krxBx9SSTEAGCsK4Z0kVv5qp
 hC9GCFo9xoZgABDEjz4RvI8GO8oFzxkiv9K7QsVD7xNGWaCNfLI1yQbHhGIZWEWR9xHV
 bAfFecL7gUyL7QU+4boxL/od8/mR4EaRWueD12uVq+i7x+DUTXTs1X8fSLKkaa0o6GUr
 /zCg==
X-Gm-Message-State: AOJu0YzZaNFWk8aMbbGE9PiKW+Slux5YbVtvEz9HHLp7Bfz32/K1rv0p
 RiMyyMmM016EVLwoQuaK71Jtr57C26GXlt/K/uzAx6YCGb3/KkNf+u9Z
X-Gm-Gg: ASbGncscRCamhqGfCKd1XlVEXkAHHNASipcuUxnqp+036sVHPOrG41hJjZ6L1Qj1JX1
 Bu5pwCFib17d0+NYyEkwbFD5DfgYiny+OTxGqPNKUnv8B6fVjS2+MeHcpD9qF2EMbNZkMecKLPA
 wuJWun8GVktcbgq5SIzmp/QhbGgTLrrONjB1Li1ClB09ox3TphaSWOXND9jPhuPeSMsVh/KAr35
 B0z2kLqO2bfkNHrsQ6kdIzRQJfuZccNkh0Hwp0bb9PnEd898gfCBYuF6zqMKBN+t3/0PVnctma/
 IMUfKyiYWNbcw20O4Fmbuj4n8EaRiBcp1WaxVQoVJM2rwEQdAFOKMMs4mgb5CTWjZBPSHD+Hzbh
 ERNCPCZ9q9BSIho4vEtO5+yN3HfcHUF9cMumvk397xeE7Aj7aKnqmm3nAntc=
X-Google-Smtp-Source: AGHT+IFkm9DUTL859emdc3XL89RJF6j7ZTSgw/bt7sG6ils9YvdDpZMadyq6BSoLuJI1Rtrf9X6E8g==
X-Received: by 2002:a05:6000:2f87:b0:3ef:42fe:8539 with SMTP id
 ffacd0b85a97d-4256714c910mr8149595f8f.25.1759747640921; 
 Mon, 06 Oct 2025 03:47:20 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1585:c600:44c9:2de3:62f5:da07])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5b5f3015sm145288235e9.1.2025.10.06.03.47.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Oct 2025 03:47:20 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com,
	Kenny.Ho@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: partially revert "revert to old status lock
 handling v3"
Date: Mon,  6 Oct 2025 12:47:19 +0200
Message-ID: <20251006104719.12886-1-christian.koenig@amd.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The CI systems are pointing out list corruptions, so we still need to
fix something here.

Keep the asserts, but revert the lock changes for now.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 146 ++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  15 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |   4 +
 4 files changed, 105 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3bbe1001fda1..8dc12064da49 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -724,12 +724,12 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
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
@@ -746,9 +746,9 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
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
index 86c8288c665f..100cb6cc0cff 100644
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
@@ -469,10 +481,10 @@ int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
 	int ret;
 
 	/* We can only trust prev->next while holding the lock */
-	spin_lock(&vm->invalidated_lock);
+	spin_lock(&vm->status_lock);
 	while (!list_is_head(prev->next, &vm->done)) {
 		bo_va = list_entry(prev->next, typeof(*bo_va), base.vm_status);
-		spin_unlock(&vm->invalidated_lock);
+		spin_unlock(&vm->status_lock);
 
 		bo = bo_va->base.bo;
 		if (bo) {
@@ -480,10 +492,10 @@ int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
 			if (unlikely(ret))
 				return ret;
 		}
-		spin_lock(&vm->invalidated_lock);
+		spin_lock(&vm->status_lock);
 		prev = prev->next;
 	}
-	spin_unlock(&vm->invalidated_lock);
+	spin_unlock(&vm->status_lock);
 
 	return 0;
 }
@@ -579,7 +591,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       void *param)
 {
 	uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
-	struct amdgpu_vm_bo_base *bo_base, *tmp;
+	struct amdgpu_vm_bo_base *bo_base;
 	struct amdgpu_bo *bo;
 	int r;
 
@@ -592,7 +604,13 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -605,21 +623,26 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -648,7 +671,9 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 	ret = !vm->evicting;
 	amdgpu_vm_eviction_unlock(vm);
 
+	spin_lock(&vm->status_lock);
 	ret &= list_empty(&vm->evicted);
+	spin_unlock(&vm->status_lock);
 
 	spin_lock(&vm->immediate.lock);
 	ret &= !vm->immediate.stopped;
@@ -939,13 +964,18 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
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
@@ -960,7 +990,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
-	list_for_each_entry(entry, &vm->relocated, vm_status) {
+	list_for_each_entry(entry, &relocated, vm_status) {
 		/* vm_flush_needed after updating moved PDEs */
 		flush_tlb_needed |= entry->moved;
 
@@ -976,7 +1006,9 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (flush_tlb_needed)
 		atomic64_inc(&vm->tlb_seq);
 
-	list_for_each_entry_safe(entry, tmp, &vm->relocated, vm_status) {
+	while (!list_empty(&relocated)) {
+		entry = list_first_entry(&relocated, struct amdgpu_vm_bo_base,
+					 vm_status);
 		amdgpu_vm_bo_idle(entry);
 	}
 
@@ -1202,9 +1234,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -1571,24 +1603,29 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
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
@@ -1620,9 +1657,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
 			amdgpu_vm_bo_evicted_user(&bo_va->base);
 
-		spin_lock(&vm->invalidated_lock);
+		spin_lock(&vm->status_lock);
 	}
-	spin_unlock(&vm->invalidated_lock);
+	spin_unlock(&vm->status_lock);
 
 	return 0;
 }
@@ -2151,9 +2188,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 		}
 	}
 
-	spin_lock(&vm->invalidated_lock);
+	spin_lock(&vm->status_lock);
 	list_del(&bo_va->base.vm_status);
-	spin_unlock(&vm->invalidated_lock);
+	spin_unlock(&vm->status_lock);
 
 	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
 		list_del(&mapping->list);
@@ -2261,10 +2298,10 @@ void amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
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
@@ -2532,12 +2569,11 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -3013,6 +3049,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 
 	amdgpu_vm_assert_locked(vm);
 
+	spin_lock(&vm->status_lock);
 	seq_puts(m, "\tIdle BOs:\n");
 	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
 		if (!bo_va->base.bo)
@@ -3050,13 +3087,11 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
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
 
@@ -3066,6 +3101,7 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 			continue;
 		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
 	}
+	spin_unlock(&vm->status_lock);
 	total_done_objs = id;
 
 	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 556d0483c6bc..77207f4e448e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -203,11 +203,11 @@ struct amdgpu_vm_bo_base {
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
@@ -343,8 +343,10 @@ struct amdgpu_vm {
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
@@ -352,8 +354,6 @@ struct amdgpu_vm {
 	 * PDs, PTs or per VM BOs. The state transits are:
 	 *
 	 * evicted -> relocated (PDs, PTs) or moved (per VM BOs) -> idle
-	 *
-	 * Lists are protected by the root PD dma_resv lock.
 	 */
 
 	/* Per-VM and PT BOs who needs a validation */
@@ -374,10 +374,7 @@ struct amdgpu_vm {
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
index f57c48b74274..30022123b0bf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -541,7 +541,9 @@ static void amdgpu_vm_pt_free(struct amdgpu_vm_bo_base *entry)
 	entry->bo->vm_bo = NULL;
 	ttm_bo_set_bulk_move(&entry->bo->tbo, NULL);
 
+	spin_lock(&entry->vm->status_lock);
 	list_del(&entry->vm_status);
+	spin_unlock(&entry->vm->status_lock);
 	amdgpu_bo_unref(&entry->bo);
 }
 
@@ -585,6 +587,7 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
 	struct amdgpu_vm_pt_cursor seek;
 	struct amdgpu_vm_bo_base *entry;
 
+	spin_lock(&params->vm->status_lock);
 	for_each_amdgpu_vm_pt_dfs_safe(params->adev, params->vm, cursor, seek, entry) {
 		if (entry && entry->bo)
 			list_move(&entry->vm_status, &params->tlb_flush_waitlist);
@@ -592,6 +595,7 @@ static void amdgpu_vm_pt_add_list(struct amdgpu_vm_update_params *params,
 
 	/* enter start node now */
 	list_move(&cursor->entry->vm_status, &params->tlb_flush_waitlist);
+	spin_unlock(&params->vm->status_lock);
 }
 
 /**
-- 
2.43.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAEBCA0EFF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Aug 2025 09:59:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04AA110E7A1;
	Wed, 27 Aug 2025 09:59:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AWm4ROG8";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2D6410E79D
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 09:59:54 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-3c7edd71bbfso3669989f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Aug 2025 02:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756288793; x=1756893593; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OV55u37N3N4SxgHr4w3cViXdmhdom/3Siq85kZmIlMs=;
 b=AWm4ROG8pZkm1Tz4Z2+3USMTdboeXeHVMMFVV/tyReXPa8gg1WChS6EW842rI0bx3P
 kULqbQfk0gsYT1yw8rD4UPqA+EaMwwrp1DcW/5whm6oWAbI8RfrMqVaRAEaiVaT4RN2q
 GY0kwVGz7koxXvkM22s6odM/uFvXC2FGiRPxdwMbOEVf2itchnZ4G0JF94T7OGBpMFqv
 Yyrsf7g92Wup9X02j0SflQhDQY03GbQRlK84OvzvAhLLu/9ObAp9PLv3a0H/ZJX6QMQH
 tM0/TiJXKGv7pc4A7T3DovDYepFRP3XQc/o0EfNPLassnVEejAljjqg8jeU6nqbkZCav
 kb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756288793; x=1756893593;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OV55u37N3N4SxgHr4w3cViXdmhdom/3Siq85kZmIlMs=;
 b=uSvyLrH4r4cj2tFtVva3sbq6upPT2zIyhSVaKVaE3lXnvBCYR2PgJBYeAc8xEMG2GU
 6w4v8QoMMKGRxon2wxHk/yOMRtVNzon+wP38Kw5bHQ1VIt4qqIHeLpvcLFcyzx/W3sbM
 qiyPDUYqjgyLNole4a+hrAZNEmywMMrkjDva3hkl7REAutGgT3OC+mwSz3mYUI3UBU6J
 bd6OqYnba24yW2WMzOPz5ELqG0jlRdx2VzX26E9VlkdL8c8PAf7ux9tYPvHulskIleWW
 QYCO5rV35kAq9AOFD+n9lOIgDfuA6NUzZLlXNeQRQFadeFB8lE7pkY+qezm2Lm/+ZkGd
 GIjw==
X-Gm-Message-State: AOJu0YzmYsuWY3HjjEnNlj0DD1vXsIOTEJTmB6+6oV1LNh+zvqLMQ0o2
 HY9aDF+CEPocC/KI7C7Ibhcm93nAv1sex5ZL4n2La+kfFwYf+GVMbNAq
X-Gm-Gg: ASbGncsBFT7SySApjedlAeNEr59LBJBTsN4ql7ZQwnKD0BUI1WBLebKmyvqiqLmN484
 aoiRCmDugrM1MWs0PxSwq5J87S+oGUfdd/ABJOvVN7SS813/zmmdQZwNpkUz0sz1V2MWIs6dmTO
 +JgLpgWKVSofpeMKltB2zfARhYgP8XeWTVvCLmIxAh/lABl9q/YY+C66/Ne2WJU6USIN/VfJcP5
 +femLW0RBsbiXllgNmB5MO52RNHrnGngG1dp+f29JUbMRdQsYr8NyPj6BfHBGM1SxmpEzwwfzk/
 zZHgYHD+J8e/G7Xs7Lh0+L1TBFsdmhWEwXskMNC9h+7p0IGA2Np+/f0JjTj74wqrPJnljXFQHtU
 7rmS/2Xdn6sa8r/dKKzoi6SohDUWB60lEMeTTKECB9edC1w==
X-Google-Smtp-Source: AGHT+IG3Fw/2Qv4e27u8MK+wKVYNhA1Jf5JrCNcw/8c8T4ctTSNiDf8z/qHsYGBBmUFOrVznVGyZVQ==
X-Received: by 2002:a05:6000:230a:b0:3ca:15a3:43e8 with SMTP id
 ffacd0b85a97d-3ca15a352b4mr5385585f8f.9.1756288792726; 
 Wed, 27 Aug 2025 02:59:52 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1498:5800:1e25:9081:2109:a4cd])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b6f0c6db6sm25236415e9.2.2025.08.27.02.59.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Aug 2025 02:59:52 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com,
	Sunil.Khatri@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 3/3] drm/amdgpu: revert "Rename VM invalidate to status lock"
Date: Wed, 27 Aug 2025 11:59:50 +0200
Message-ID: <20250827095950.2672-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250827095950.2672-1-christian.koenig@amd.com>
References: <20250827095950.2672-1-christian.koenig@amd.com>
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

This reverts commit 0479956c94b1cfa6a1ab9206eff76072944ece8b.

It turned out that protecting the status of each bo_va only with a
spinlock was just hiding problems instead of solving them.

Revert the whole approach, add a separate stats_lock and lockdep
assertions that the correct reservation lock is held all over the place.

While at it also re-order fields in the VM structure and try to improve
the documentation a bit.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 145 ++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  25 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |   4 -
 4 files changed, 83 insertions(+), 99 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 3b1aae26a6c2..2de27b57b721 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -554,12 +554,12 @@ amdgpu_userq_validate_bos(struct amdgpu_device *adev, struct drm_exec *exec,
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
 		ret = drm_exec_lock_obj(exec, &bo->tbo.base);
@@ -576,9 +576,9 @@ amdgpu_userq_validate_bos(struct amdgpu_device *adev, struct drm_exec *exec,
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
index 1dec07513cd6..35573283949d 100644
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
@@ -575,7 +585,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       void *param)
 {
 	uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
-	struct amdgpu_vm_bo_base *bo_base;
+	struct amdgpu_vm_bo_base *bo_base, *tmp;
 	struct amdgpu_bo *bo;
 	int r;
 
@@ -588,13 +598,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -607,14 +611,9 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
 
+	list_for_each_entry_safe(bo_base, tmp, &vm->evicted_user, vm_status) {
 		bo = bo_base->bo;
 		dma_resv_assert_held(bo->tbo.base.resv);
 
@@ -623,10 +622,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			return r;
 
 		amdgpu_vm_bo_invalidated(bo_base);
-
-		spin_lock(&vm->status_lock);
 	}
-	spin_unlock(&vm->status_lock);
 
 	amdgpu_vm_eviction_lock(vm);
 	vm->evicting = false;
@@ -649,13 +645,13 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
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
@@ -946,16 +942,13 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
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
@@ -970,7 +963,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
-	list_for_each_entry(entry, &relocated, vm_status) {
+	list_for_each_entry(entry, &vm->relocated, vm_status) {
 		/* vm_flush_needed after updating moved PDEs */
 		flush_tlb_needed |= entry->moved;
 
@@ -986,9 +979,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (flush_tlb_needed)
 		atomic64_inc(&vm->tlb_seq);
 
-	while (!list_empty(&relocated)) {
-		entry = list_first_entry(&relocated, struct amdgpu_vm_bo_base,
-					 vm_status);
+	list_for_each_entry_safe(entry, tmp, &vm->relocated, vm_status) {
 		amdgpu_vm_bo_idle(entry);
 	}
 
@@ -1214,9 +1205,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -1583,29 +1574,24 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
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
@@ -1637,9 +1623,9 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
 			amdgpu_vm_bo_evicted_user(&bo_va->base);
 
-		spin_lock(&vm->status_lock);
+		spin_lock(&vm->invalidated_lock);
 	}
-	spin_unlock(&vm->status_lock);
+	spin_unlock(&vm->invalidated_lock);
 
 	return 0;
 }
@@ -2168,9 +2154,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 		}
 	}
 
-	spin_lock(&vm->status_lock);
+	spin_lock(&vm->invalidated_lock);
 	list_del(&bo_va->base.vm_status);
-	spin_unlock(&vm->status_lock);
+	spin_unlock(&vm->invalidated_lock);
 
 	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
 		list_del(&mapping->list);
@@ -2278,10 +2264,10 @@ void amdgpu_vm_bo_move(struct amdgpu_bo *bo, struct ttm_resource *new_mem,
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
@@ -2547,11 +2533,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -3016,7 +3003,8 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 	unsigned int total_done_objs = 0;
 	unsigned int id = 0;
 
-	spin_lock(&vm->status_lock);
+	amdgpu_vm_assert_locked(vm);
+
 	seq_puts(m, "\tIdle BOs:\n");
 	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
 		if (!bo_va->base.bo)
@@ -3054,11 +3042,13 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
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
 
@@ -3068,7 +3058,6 @@ void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
 			continue;
 		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
 	}
-	spin_unlock(&vm->status_lock);
 	total_done_objs = id;
 
 	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index f9549f6b3d1f..c90891f1f835 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -203,11 +203,11 @@ struct amdgpu_vm_bo_base {
 	/* protected by bo being reserved */
 	struct amdgpu_vm_bo_base	*next;
 
-	/* protected by vm status_lock */
+	/* protected by vm reservation and status_lock */
 	struct list_head		vm_status;
 
 	/* if the bo is counted as shared in mem stats
-	 * protected by vm status_lock */
+	 * protected by vm BO being reserved */
 	bool				shared;
 
 	/* protected by the BO being reserved */
@@ -344,18 +344,13 @@ struct amdgpu_vm {
 	bool			evicting;
 	unsigned int		saved_flags;
 
-	/* Lock to protect vm_bo add/del/move on all lists of vm */
-	spinlock_t		status_lock;
-
-	/* Memory statistics for this vm, protected by status_lock */
+	/* Memory statistics for this vm, protected by stats_lock */
+	spinlock_t		stats_lock;
 	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
 
 	/* Per-VM and PT BOs who needs a validation */
 	struct list_head	evicted;
 
-	/* BOs for user mode queues that need a validation */
-	struct list_head	evicted_user;
-
 	/* PT BOs which relocated and their parent need an update */
 	struct list_head	relocated;
 
@@ -365,15 +360,19 @@ struct amdgpu_vm {
 	/* All BOs of this VM not currently in the state machine */
 	struct list_head	idle;
 
-	/* regular invalidated BOs, but not yet updated in the PT */
+	/* Regular BOs for KFD queues that need a validation */
+	struct list_head	evicted_user;
+
+	/* Regular invalidated BOs, need to be validated and updated in the PT */
+	spinlock_t		invalidated_lock;
 	struct list_head	invalidated;
 
+	/* Regular BOs which are validated and location has been updated in the PTs */
+	struct list_head        done;
+
 	/* BO mappings freed, but not yet updated in the PT */
 	struct list_head	freed;
 
-	/* BOs which are invalidated, has been updated in the PTs */
-	struct list_head        done;
-
 	/* contains the page directory */
 	struct amdgpu_vm_bo_base     root;
 	struct dma_fence	*last_update;
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


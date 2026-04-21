Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B4FBF8FA74
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 12:55:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A66F10EC71;
	Tue, 21 Apr 2026 12:55:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="g3a4OzSb";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7CA4F10EC91
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 12:55:30 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-488ad135063so35308535e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 05:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776776129; x=1777380929; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4/bdt/tJ5/wS1u16m9jrC8QhD8k/Tr3PG1XE8wH7f7I=;
 b=g3a4OzSbYRMgs4bZX84bapCokZQCjFrs2BsCs1WAIVrkCIThQnkt+JNdktqVTvqENz
 x/B8ZkTVBV0BZk7PiBFzVd9YUsZtt3wKydHM3MGGNqpwjYL8YqvzL0vrFW9rBe0neCh2
 E9rOdhyDt666GARc7QHU1Lq9TuDJkKO0CGvxB5JPR7xwnbPwxGQdlweNFgLptBClLT+u
 jrUkkWVSBUCqNNky30STPm65XeSiyc37ONVFeubm7xPOsh0dsxl9LCQgHX4AiGjujATX
 DzSUbTPgbCisqP2czWXTSCoYFricCeDjUIiEjeXYR001kT0mqVlvNUbKsKzZ9vR49ITZ
 NLTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776776129; x=1777380929;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4/bdt/tJ5/wS1u16m9jrC8QhD8k/Tr3PG1XE8wH7f7I=;
 b=ae/uZk4MyB7YZyTynGIoLGYqlEvpxsr7jwkCcGhh5RoVFGS8lVl6vEmhfP6pwsZPWf
 VdZLrUu++CWs1IfqEJlpYU/Pb2lxbgClOxvD4kFeKOEhnFViwyzKzWlgSGfor1+hhJ7y
 rq4vdPWgi/EIZxReEz0tcaovqAiJfTRyBOt6brfDotbHX9+h2mUJ2Afv79FRR3umvgsy
 Ut6Qa03IF7O92z1wqNoYN5unSnfb8Cd5/LDA087yeqUTr54YOur/9yNxZNO+Py2nBj+Y
 14UhFrfv+dXIjNME2S0nF/43xXBlAXHvLWZCn12fq0in/GEJ26pz2KzVqbH5lT+X3Q9A
 hc5Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ptOGA/kduC1XC5Do28IMoUCsTezbmMA//vscxxqHQhRq4Mu1x9n8w2BkDgdKQuhZIeOx+OC4+@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yya59QKS2wIgjHkZ5W+e50wamZv/mAVWFlDkV9AJbGnF2vr8KWn
 tQQ35GTKfFl4+oE64CBi8GKaR/s9Orctvrgs6/Ts8btavDwgynft/S/ZgmZ1ww==
X-Gm-Gg: AeBDietsVfOzbslM7ShuHqkg9gTmlxIxMXer1TpSdwBXPM0Ntm2ygSCqvkPt4E/bxF2
 I3JmWbxm5tP20p/De3zz5cGH9iwUi657PxpHJnkLLkBsllhPgYS9uVO/mXW/OeHWk21JBiL/4ye
 rACYQHs6fxCzX/gjOTQy74hcpuT8aRwwacQDaAubXd1vcQEWhwVcRVELfvCM778G1uLQsGmY1Uh
 /MCN1lsyDcI85jpUwBsHVIlOt1+qjOCItJTPzaBKuEPSEJN+he+EfkpMC6fGJmgBbr0sp1cLaIh
 EW6P2pa85DsrHLJtcgo7BXPmhaXWcP8+yzpK+iWFJZyOrvR7of/hD7RazOBY2eWf0wDMTnx0Ibe
 X6wpX7+g4J91Y608Nmj9oLzr8vfPhH89rdvia8IDhax8kWH0WFBg26xXlWpVr/8rM7pb37Crg/U
 Fr6NCZwZgH89vO6BOBTIIAPDyXvUP+QrfQ0zY5Om+3G20uM6I=
X-Received: by 2002:a05:600c:4e4f:b0:488:ab37:b442 with SMTP id
 5b1f17b1804b1-488fb793c6bmr265613425e9.28.1776776128684; 
 Tue, 21 Apr 2026 05:55:28 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15aa:5a00:935c:42ec:dfce:89a2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb79ecb9sm154777915e9.8.2026.04.21.05.55.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 05:55:27 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com, Prike.Liang@amd.com, sukhatri@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
Subject: [PATCH 10/11] drm/amdgpu: restructure VM state machine v2
Date: Tue, 21 Apr 2026 14:55:12 +0200
Message-ID: <20260421125513.4545-10-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421125513.4545-1-christian.koenig@amd.com>
References: <20260421125513.4545-1-christian.koenig@amd.com>
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

Instead of coming up with more sophisticated names for states a VM BO
can be in, group them by the type of BO first and then by the state.

So we end with BO type kernel, always_valid and individual and then states
evicted, moved and idle.

Not much functional change, except that evicted_user is moved back
together with the other BOs again which makes the handling in
amdgpu_vm_validate() a bit more complex.

Also fixes a problem with user queues and amdgpu_vm_ready(). We didn't
considered the VM ready when user BOs were not ideally placed, harmless
performance impact for kernel queues but a complete show stopper for
userqueues.

v2: fix a few typos in comments, rename the BO types to make them more
    descriptive, fix a couple of bugs found during testing

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c |  22 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 468 ++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  64 ++-
 3 files changed, 252 insertions(+), 302 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 7fc733ba962e..9d01449e1487 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1048,12 +1048,12 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
 	struct amdgpu_bo *bo;
 	int ret;
 
-	spin_lock(&vm->invalidated_lock);
-	while (!list_empty(&vm->invalidated)) {
-		bo_va = list_first_entry(&vm->invalidated,
+	spin_lock(&vm->individual_lock);
+	while (!list_empty(&vm->always_valid.evicted)) {
+		bo_va = list_first_entry(&vm->always_valid.evicted,
 					 struct amdgpu_bo_va,
 					 base.vm_status);
-		spin_unlock(&vm->invalidated_lock);
+		spin_unlock(&vm->individual_lock);
 
 		bo = bo_va->base.bo;
 		ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 2);
@@ -1065,14 +1065,14 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
 		if (ret)
 			return ret;
 
-		/* This moves the bo_va to the done list */
+		/* This moves the bo_va to the idle list */
 		ret = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (ret)
 			return ret;
 
-		spin_lock(&vm->invalidated_lock);
+		spin_lock(&vm->individual_lock);
 	}
-	spin_unlock(&vm->invalidated_lock);
+	spin_unlock(&vm->individual_lock);
 
 	return 0;
 }
@@ -1104,7 +1104,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 		if (unlikely(ret))
 			goto unlock_all;
 
-		ret = amdgpu_vm_lock_done_list(vm, &exec, 1);
+		ret = amdgpu_vm_lock_individual(vm, &exec, 1);
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(ret))
 			goto unlock_all;
@@ -1147,7 +1147,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 
 	key = 0;
 	/* Validate User Ptr BOs */
-	list_for_each_entry(bo_va, &vm->done, base.vm_status) {
+	list_for_each_entry(bo_va, &vm->always_valid.idle, base.vm_status) {
 		bo = bo_va->base.bo;
 		if (!bo)
 			continue;
@@ -1197,10 +1197,10 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 
 	/*
 	 * We need to wait for all VM updates to finish before restarting the
-	 * queues. Using the done list like that is now ok since everything is
+	 * queues. Using the idle list like that is now ok since everything is
 	 * locked in place.
 	 */
-	list_for_each_entry(bo_va, &vm->done, base.vm_status)
+	list_for_each_entry(bo_va, &vm->always_valid.idle, base.vm_status)
 		dma_fence_wait(bo_va->last_pt_update, false);
 	dma_fence_wait(vm->last_update, false);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index e2a21a66b28f..118761e2c409 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -138,6 +138,47 @@ static void amdgpu_vm_assert_locked(struct amdgpu_vm *vm)
 	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
 }
 
+/* Initialize the amdgpu_vm_bo_status object */
+static void amdgpu_vm_bo_status_init(struct amdgpu_vm_bo_status *lists)
+{
+	INIT_LIST_HEAD(&lists->evicted);
+	INIT_LIST_HEAD(&lists->moved);
+	INIT_LIST_HEAD(&lists->idle);
+}
+
+/*
+ * Make sure we have the lock to modify the vm_bo status and return the object
+ * with the status lists.
+ */
+static struct amdgpu_vm_bo_status *
+amdgpu_vm_bo_lock_lists(struct amdgpu_vm_bo_base *vm_bo)
+{
+	struct amdgpu_vm *vm = vm_bo->vm;
+	struct amdgpu_bo *bo = vm_bo->bo;
+
+	if (amdgpu_vm_is_bo_always_valid(vm, bo)) {
+		/* No extra locking needed, protected by the root PD resv lock */
+		amdgpu_vm_assert_locked(vm);
+
+		if (bo->tbo.type == ttm_bo_type_kernel)
+			return &vm->kernel;
+
+		return &vm->always_valid;
+	}
+
+	spin_lock(&vm_bo->vm->individual_lock);
+	return &vm->individual;
+}
+
+/* Eventually unlock the status list lock again */
+static void amdgpu_vm_bo_unlock_lists(struct amdgpu_vm_bo_base *vm_bo)
+{
+	if (amdgpu_vm_is_bo_always_valid(vm_bo->vm, vm_bo->bo))
+		amdgpu_vm_assert_locked(vm_bo->vm);
+	else
+		spin_unlock(&vm_bo->vm->individual_lock);
+}
+
 /**
  * amdgpu_vm_is_bo_always_valid - check if the BO is VM always valid
  *
@@ -157,33 +198,44 @@ bool amdgpu_vm_is_bo_always_valid(struct amdgpu_vm *vm, struct amdgpu_bo *bo)
  *
  * @vm_bo: vm_bo which is evicted
  *
- * State for PDs/PTs and per VM BOs which are not at the location they should
- * be.
+ * State for vm_bo objects meaning the underlying BO was evicted and need to
+ * move in place again.
  */
 static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
 {
-	struct amdgpu_vm *vm = vm_bo->vm;
-	struct amdgpu_bo *bo = vm_bo->bo;
+	struct amdgpu_vm_bo_status *lists;
 
+	lists = amdgpu_vm_bo_lock_lists(vm_bo);
 	vm_bo->moved = true;
-	amdgpu_vm_assert_locked(vm);
-	if (bo->tbo.type == ttm_bo_type_kernel)
-		list_move(&vm_bo->vm_status, &vm->evicted);
-	else
-		list_move_tail(&vm_bo->vm_status, &vm->evicted);
+	list_move(&vm_bo->vm_status, &lists->evicted);
+	amdgpu_vm_bo_unlock_lists(vm_bo);
 }
 /**
  * amdgpu_vm_bo_moved - vm_bo is moved
  *
  * @vm_bo: vm_bo which is moved
  *
- * State for per VM BOs which are moved, but that change is not yet reflected
- * in the page tables.
+ * State for vm_bo objects meaning the underlying BO was moved but the new
+ * location not yet reflected in the page tables.
  */
 static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
 {
-	amdgpu_vm_assert_locked(vm_bo->vm);
-	list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
+	struct amdgpu_vm_bo_status *lists;
+	struct amdgpu_bo *bo = vm_bo->bo;
+
+	/*
+	 * The root PD doesn't have a parent PDE and goes directly into the
+	 * idle state.
+	 */
+	lists = amdgpu_vm_bo_lock_lists(vm_bo);
+	if (bo && bo->tbo.type == ttm_bo_type_kernel && !bo->parent) {
+		vm_bo->moved = false;
+		list_move(&vm_bo->vm_status, &lists->idle);
+	} else {
+		vm_bo->moved = true;
+		list_move(&vm_bo->vm_status, &lists->moved);
+	}
+	amdgpu_vm_bo_unlock_lists(vm_bo);
 }
 
 /**
@@ -191,104 +243,36 @@ static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
  *
  * @vm_bo: vm_bo which is now idle
  *
- * State for PDs/PTs and per VM BOs which have gone through the state machine
- * and are now idle.
+ * State for vm_bo objects meaning we are done with the state machine and no
+ * further action is necessary.
  */
 static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
 {
-	amdgpu_vm_assert_locked(vm_bo->vm);
-	list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
-	vm_bo->moved = false;
-}
-
-/**
- * amdgpu_vm_bo_invalidated - vm_bo is invalidated
- *
- * @vm_bo: vm_bo which is now invalidated
- *
- * State for normal BOs which are invalidated and that change not yet reflected
- * in the PTs.
- */
-static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
-{
-	spin_lock(&vm_bo->vm->invalidated_lock);
-	list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
-	spin_unlock(&vm_bo->vm->invalidated_lock);
-}
-
-/**
- * amdgpu_vm_bo_evicted_user - vm_bo is evicted
- *
- * @vm_bo: vm_bo which is evicted
- *
- * State for BOs used by user mode queues which are not at the location they
- * should be.
- */
-static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
-{
-	amdgpu_vm_assert_locked(vm_bo->vm);
-	vm_bo->moved = true;
-	list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
-}
+	struct amdgpu_vm_bo_status *lists;
 
-/**
- * amdgpu_vm_bo_relocated - vm_bo is reloacted
- *
- * @vm_bo: vm_bo which is relocated
- *
- * State for PDs/PTs which needs to update their parent PD.
- * For the root PD, just move to idle state.
- */
-static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
-{
-	amdgpu_vm_assert_locked(vm_bo->vm);
-	if (vm_bo->bo->parent)
-		list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
-	else
-		amdgpu_vm_bo_idle(vm_bo);
-}
-
-/**
- * amdgpu_vm_bo_done - vm_bo is done
- *
- * @vm_bo: vm_bo which is now done
- *
- * State for normal BOs which are invalidated and that change has been updated
- * in the PTs.
- */
-static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
-{
-	amdgpu_vm_assert_locked(vm_bo->vm);
-	list_move(&vm_bo->vm_status, &vm_bo->vm->done);
+	lists = amdgpu_vm_bo_lock_lists(vm_bo);
+	if (!amdgpu_vm_is_bo_always_valid(vm_bo->vm, vm_bo->bo))
+		vm_bo->moved = false;
+	list_move(&vm_bo->vm_status, &lists->idle);
+	amdgpu_vm_bo_unlock_lists(vm_bo);
 }
 
 /**
  * amdgpu_vm_bo_reset_state_machine - reset the vm_bo state machine
  * @vm: the VM which state machine to reset
  *
- * Move all vm_bo object in the VM into a state where they will be updated
- * again during validation.
+ * Move all vm_bo object in the VM into a state where their location will be
+ * updated in the page tables again.
  */
 static void amdgpu_vm_bo_reset_state_machine(struct amdgpu_vm *vm)
 {
-	struct amdgpu_vm_bo_base *vm_bo, *tmp;
-
-	spin_lock(&vm->invalidated_lock);
-	list_splice_init(&vm->done, &vm->invalidated);
-	list_for_each_entry(vm_bo, &vm->invalidated, vm_status)
-		vm_bo->moved = true;
-	spin_unlock(&vm->invalidated_lock);
-
 	amdgpu_vm_assert_locked(vm);
-	list_for_each_entry_safe(vm_bo, tmp, &vm->idle, vm_status) {
-		struct amdgpu_bo *bo = vm_bo->bo;
+	list_splice_init(&vm->kernel.idle, &vm->kernel.moved);
+	list_splice_init(&vm->always_valid.idle, &vm->always_valid.moved);
 
-		vm_bo->moved = true;
-		if (!bo || bo->tbo.type != ttm_bo_type_kernel)
-			list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
-		else if (bo->parent)
-			list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
-	}
+	spin_lock(&vm->individual_lock);
+	list_splice_init(&vm->individual.idle, &vm->individual.moved);
+	spin_unlock(&vm->individual_lock);
 }
 
 /**
@@ -416,8 +400,10 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 	base->next = NULL;
 	INIT_LIST_HEAD(&base->vm_status);
 
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
 	if (!bo)
 		return;
+
 	base->next = bo->vm_bo;
 	bo->vm_bo = base;
 
@@ -426,27 +412,22 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 	amdgpu_vm_update_stats_locked(base, bo->tbo.resource, +1);
 	spin_unlock(&vm->stats_lock);
 
-	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
+	if (!amdgpu_vm_is_bo_always_valid(vm, bo)) {
+		amdgpu_vm_bo_idle(base);
 		return;
-
-	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
+	}
 
 	ttm_bo_set_bulk_move(&bo->tbo, &vm->lru_bulk_move);
-	if (bo->tbo.type == ttm_bo_type_kernel && bo->parent)
-		amdgpu_vm_bo_relocated(base);
-	else
-		amdgpu_vm_bo_idle(base);
 
+	/*
+	 * When a per VM isn't in the desired domain put it into the evicted
+	 * state to make sure that it gets validated on the next best occasion.
+	 */
 	if (bo->preferred_domains &
 	    amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type))
-		return;
-
-	/*
-	 * we checked all the prerequisites, but it looks like this per vm bo
-	 * is currently evicted. add the bo to the evicted list to make sure it
-	 * is validated on next vm use to avoid fault.
-	 * */
-	amdgpu_vm_bo_evicted(base);
+		amdgpu_vm_bo_moved(base);
+	else
+		amdgpu_vm_bo_evicted(base);
 }
 
 /**
@@ -467,41 +448,41 @@ int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
 }
 
 /**
- * amdgpu_vm_lock_done_list - lock all BOs on the done list
+ * amdgpu_vm_lock_individual - lock all BOs on the individual idle list
  * @vm: vm providing the BOs
  * @exec: drm execution context
  * @num_fences: number of extra fences to reserve
  *
- * Lock the BOs on the done list in the DRM execution context.
+ * Lock the BOs on the individual idle list in the DRM execution context.
  */
-int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
-			     unsigned int num_fences)
+int amdgpu_vm_lock_individual(struct amdgpu_vm *vm, struct drm_exec *exec,
+			      unsigned int num_fences)
 {
-	struct list_head *prev = &vm->done;
+	struct list_head *prev = &vm->individual.idle;
 	struct amdgpu_bo_va *bo_va;
 	struct amdgpu_bo *bo;
 	int ret;
 
 	/* We can only trust prev->next while holding the lock */
-	spin_lock(&vm->invalidated_lock);
-	while (!list_is_head(prev->next, &vm->done)) {
+	spin_lock(&vm->individual_lock);
+	while (!list_is_head(prev->next, &vm->individual.idle)) {
 		bo_va = list_entry(prev->next, typeof(*bo_va), base.vm_status);
 
 		bo = bo_va->base.bo;
 		if (bo) {
 			amdgpu_bo_ref(bo);
-			spin_unlock(&vm->invalidated_lock);
+			spin_unlock(&vm->individual_lock);
 
 			ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 1);
 			amdgpu_bo_unref(&bo);
 			if (unlikely(ret))
 				return ret;
 
-			spin_lock(&vm->invalidated_lock);
+			spin_lock(&vm->individual_lock);
 		}
 		prev = prev->next;
 	}
-	spin_unlock(&vm->invalidated_lock);
+	spin_unlock(&vm->individual_lock);
 
 	return 0;
 }
@@ -598,9 +579,9 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 {
 	uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
 	struct amdgpu_vm_bo_base *bo_base, *tmp;
-	struct amdgpu_bo *bo;
 	int r;
 
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
 	if (vm->generation != new_vm_generation) {
 		vm->generation = new_vm_generation;
 		amdgpu_vm_bo_reset_state_machine(vm);
@@ -610,38 +591,59 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			return r;
 	}
 
-	list_for_each_entry_safe(bo_base, tmp, &vm->evicted, vm_status) {
-		bo = bo_base->bo;
-
-		r = validate(param, bo);
+	list_for_each_entry_safe(bo_base, tmp, &vm->kernel.evicted, vm_status) {
+		r = validate(param, bo_base->bo);
 		if (r)
 			return r;
 
-		if (bo->tbo.type != ttm_bo_type_kernel) {
-			amdgpu_vm_bo_moved(bo_base);
-		} else {
-			vm->update_funcs->map_table(to_amdgpu_bo_vm(bo));
-			amdgpu_vm_bo_relocated(bo_base);
-		}
+		vm->update_funcs->map_table(to_amdgpu_bo_vm(bo_base->bo));
+		amdgpu_vm_bo_moved(bo_base);
 	}
 
-	if (ticket) {
-		list_for_each_entry_safe(bo_base, tmp, &vm->evicted_user,
-					 vm_status) {
-			bo = bo_base->bo;
-			dma_resv_assert_held(bo->tbo.base.resv);
+	/*
+	 * As soon as all page tables are in place we can start updating them
+	 * again.
+	 */
+	amdgpu_vm_eviction_lock(vm);
+	vm->evicting = false;
+	amdgpu_vm_eviction_unlock(vm);
 
-			r = validate(param, bo);
-			if (r)
-				return r;
+	list_for_each_entry_safe(bo_base, tmp, &vm->always_valid.evicted,
+				 vm_status) {
+		r = validate(param, bo_base->bo);
+		if (r)
+			return r;
 
-			amdgpu_vm_bo_invalidated(bo_base);
-		}
+		amdgpu_vm_bo_moved(bo_base);
 	}
 
-	amdgpu_vm_eviction_lock(vm);
-	vm->evicting = false;
-	amdgpu_vm_eviction_unlock(vm);
+	if (!ticket)
+		return 0;
+
+	spin_lock(&vm->individual_lock);
+restart:
+	list_for_each_entry(bo_base, &vm->individual.evicted, vm_status) {
+		struct amdgpu_bo *bo = bo_base->bo;
+
+		if (dma_resv_locking_ctx(bo->tbo.base.resv) != ticket)
+			continue;
+
+		spin_unlock(&vm->individual_lock);
+
+		r = validate(param, bo);
+		if (r)
+			return r;
+
+		amdgpu_vm_bo_moved(bo_base);
+
+		/* It's a bit inefficient to always jump back to the start, but
+		 * we would need to re-structure the KFD for properly fixing
+		 * that.
+		 */
+		spin_lock(&vm->individual_lock);
+		goto restart;
+	}
+	spin_unlock(&vm->individual_lock);
 
 	return 0;
 }
@@ -666,7 +668,7 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 	ret = !vm->evicting;
 	amdgpu_vm_eviction_unlock(vm);
 
-	ret &= list_empty(&vm->evicted);
+	ret &= list_empty(&vm->kernel.evicted);
 
 	spin_lock(&vm->immediate.lock);
 	ret &= !vm->immediate.stopped;
@@ -966,7 +968,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 
 	amdgpu_vm_assert_locked(vm);
 
-	if (list_empty(&vm->relocated))
+	if (list_empty(&vm->kernel.moved))
 		return 0;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
@@ -982,7 +984,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
-	list_for_each_entry(entry, &vm->relocated, vm_status) {
+	list_for_each_entry(entry, &vm->kernel.moved, vm_status) {
 		/* vm_flush_needed after updating moved PDEs */
 		flush_tlb_needed |= entry->moved;
 
@@ -998,9 +1000,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (flush_tlb_needed)
 		atomic64_inc(&vm->tlb_seq);
 
-	list_for_each_entry_safe(entry, tmp, &vm->relocated, vm_status) {
+	list_for_each_entry_safe(entry, tmp, &vm->kernel.moved, vm_status)
 		amdgpu_vm_bo_idle(entry);
-	}
 
 error:
 	drm_dev_exit(idx);
@@ -1374,7 +1375,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 		else
 			amdgpu_vm_bo_idle(&bo_va->base);
 	} else {
-		amdgpu_vm_bo_done(&bo_va->base);
+		amdgpu_vm_bo_idle(&bo_va->base);
 	}
 
 	list_splice_init(&bo_va->invalids, &bo_va->valids);
@@ -1602,19 +1603,20 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 	bool clear, unlock;
 	int r;
 
-	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
+	list_for_each_entry_safe(bo_va, tmp, &vm->always_valid.moved,
+				 base.vm_status) {
 		/* Per VM BOs never need to bo cleared in the page tables */
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			return r;
 	}
 
-	spin_lock(&vm->invalidated_lock);
-	while (!list_empty(&vm->invalidated)) {
-		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
-					 base.vm_status);
+	spin_lock(&vm->individual_lock);
+	while (!list_empty(&vm->individual.moved)) {
+		bo_va = list_first_entry(&vm->individual.moved,
+					 typeof(*bo_va), base.vm_status);
 		resv = bo_va->base.bo->tbo.base.resv;
-		spin_unlock(&vm->invalidated_lock);
+		spin_unlock(&vm->individual_lock);
 
 		/* Try to reserve the BO to avoid clearing its ptes */
 		if (!adev->debug_vm && dma_resv_trylock(resv)) {
@@ -1644,11 +1646,11 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 		    drm_gem_is_imported(&bo_va->base.bo->tbo.base) &&
 		    (!bo_va->base.bo->tbo.resource ||
 		     bo_va->base.bo->tbo.resource->mem_type == TTM_PL_SYSTEM))
-			amdgpu_vm_bo_evicted_user(&bo_va->base);
+			amdgpu_vm_bo_evicted(&bo_va->base);
 
-		spin_lock(&vm->invalidated_lock);
+		spin_lock(&vm->individual_lock);
 	}
-	spin_unlock(&vm->invalidated_lock);
+	spin_unlock(&vm->individual_lock);
 
 	return 0;
 }
@@ -2186,9 +2188,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 		}
 	}
 
-	spin_lock(&vm->invalidated_lock);
+	spin_lock(&vm->individual_lock);
 	list_del(&bo_va->base.vm_status);
-	spin_unlock(&vm->invalidated_lock);
+	spin_unlock(&vm->individual_lock);
 
 	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
 		list_del(&mapping->list);
@@ -2268,14 +2270,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
 
 		if (bo_base->moved)
 			continue;
-		bo_base->moved = true;
-
-		if (bo->tbo.type == ttm_bo_type_kernel)
-			amdgpu_vm_bo_relocated(bo_base);
-		else if (amdgpu_vm_is_bo_always_valid(vm, bo))
-			amdgpu_vm_bo_moved(bo_base);
-		else
-			amdgpu_vm_bo_invalidated(bo_base);
+		amdgpu_vm_bo_moved(bo_base);
 	}
 }
 
@@ -2566,15 +2561,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	vm->va = RB_ROOT_CACHED;
 	for (i = 0; i < AMDGPU_MAX_VMHUBS; i++)
 		vm->reserved_vmid[i] = NULL;
-	INIT_LIST_HEAD(&vm->evicted);
-	INIT_LIST_HEAD(&vm->evicted_user);
-	INIT_LIST_HEAD(&vm->relocated);
-	INIT_LIST_HEAD(&vm->moved);
-	INIT_LIST_HEAD(&vm->idle);
-	spin_lock_init(&vm->invalidated_lock);
-	INIT_LIST_HEAD(&vm->invalidated);
+
+	amdgpu_vm_bo_status_init(&vm->kernel);
+	amdgpu_vm_bo_status_init(&vm->always_valid);
+	spin_lock_init(&vm->individual_lock);
+	amdgpu_vm_bo_status_init(&vm->individual);
 	INIT_LIST_HEAD(&vm->freed);
-	INIT_LIST_HEAD(&vm->done);
 	INIT_KFIFO(vm->faults);
 	spin_lock_init(&vm->stats_lock);
 
@@ -3042,100 +3034,62 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 }
 
 #if defined(CONFIG_DEBUG_FS)
-/**
- * amdgpu_debugfs_vm_bo_info  - print BO info for the VM
- *
- * @vm: Requested VM for printing BO info
- * @m: debugfs file
- *
- * Print BO information in debugfs file for the VM
- */
-void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
-{
-	struct amdgpu_bo_va *bo_va, *tmp;
-	u64 total_idle = 0;
-	u64 total_evicted = 0;
-	u64 total_relocated = 0;
-	u64 total_moved = 0;
-	u64 total_invalidated = 0;
-	u64 total_done = 0;
-	unsigned int total_idle_objs = 0;
-	unsigned int total_evicted_objs = 0;
-	unsigned int total_relocated_objs = 0;
-	unsigned int total_moved_objs = 0;
-	unsigned int total_invalidated_objs = 0;
-	unsigned int total_done_objs = 0;
-	unsigned int id = 0;
 
-	amdgpu_vm_assert_locked(vm);
+/* print the debug info for a specific set of status lists */
+static void amdgpu_debugfs_vm_bo_status_info(struct seq_file *m,
+					     struct amdgpu_vm_bo_status *lists)
+{
+	struct amdgpu_vm_bo_base *base;
+	unsigned int id;
 
-	seq_puts(m, "\tIdle BOs:\n");
-	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		total_idle += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
-	}
-	total_idle_objs = id;
 	id = 0;
-
 	seq_puts(m, "\tEvicted BOs:\n");
-	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status) {
-		if (!bo_va->base.bo)
+	list_for_each_entry(base, &lists->evicted, vm_status) {
+		if (!base->bo)
 			continue;
-		total_evicted += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
-	}
-	total_evicted_objs = id;
-	id = 0;
 
-	seq_puts(m, "\tRelocated BOs:\n");
-	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		total_relocated += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
+		amdgpu_bo_print_info(id++, base->bo, m);
 	}
-	total_relocated_objs = id;
-	id = 0;
 
+	id = 0;
 	seq_puts(m, "\tMoved BOs:\n");
-	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
-		if (!bo_va->base.bo)
+	list_for_each_entry(base, &lists->moved, vm_status) {
+		if (!base->bo)
 			continue;
-		total_moved += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
+
+		amdgpu_bo_print_info(id++, base->bo, m);
 	}
-	total_moved_objs = id;
-	id = 0;
 
-	seq_puts(m, "\tInvalidated BOs:\n");
-	spin_lock(&vm->invalidated_lock);
-	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status) {
-		if (!bo_va->base.bo)
+	id = 0;
+	seq_puts(m, "\tIdle BOs:\n");
+	list_for_each_entry(base, &lists->moved, vm_status) {
+		if (!base->bo)
 			continue;
-		total_invalidated += amdgpu_bo_print_info(id++,	bo_va->base.bo, m);
+
+		amdgpu_bo_print_info(id++, base->bo, m);
 	}
-	spin_unlock(&vm->invalidated_lock);
-	total_invalidated_objs = id;
-	id = 0;
+}
 
-	seq_puts(m, "\tDone BOs:\n");
-	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status) {
-		if (!bo_va->base.bo)
-			continue;
-		total_done += amdgpu_bo_print_info(id++, bo_va->base.bo, m);
-	}
-	total_done_objs = id;
-
-	seq_printf(m, "\tTotal idle size:        %12lld\tobjs:\t%d\n", total_idle,
-		   total_idle_objs);
-	seq_printf(m, "\tTotal evicted size:     %12lld\tobjs:\t%d\n", total_evicted,
-		   total_evicted_objs);
-	seq_printf(m, "\tTotal relocated size:   %12lld\tobjs:\t%d\n", total_relocated,
-		   total_relocated_objs);
-	seq_printf(m, "\tTotal moved size:       %12lld\tobjs:\t%d\n", total_moved,
-		   total_moved_objs);
-	seq_printf(m, "\tTotal invalidated size: %12lld\tobjs:\t%d\n", total_invalidated,
-		   total_invalidated_objs);
-	seq_printf(m, "\tTotal done size:        %12lld\tobjs:\t%d\n", total_done,
-		   total_done_objs);
+/**
+ * amdgpu_debugfs_vm_bo_info  - print BO info for the VM
+ *
+ * @vm: Requested VM for printing BO info
+ * @m: debugfs file
+ *
+ * Print BO information in debugfs file for the VM
+ */
+void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m)
+{
+	amdgpu_vm_assert_locked(vm);
+
+	seq_puts(m, "\tKernel PT/PDs:\n");
+	amdgpu_debugfs_vm_bo_status_info(m, &vm->kernel);
+
+	seq_puts(m, "\tPer VM BOs:\n");
+	amdgpu_debugfs_vm_bo_status_info(m, &vm->always_valid);
+
+	seq_puts(m, "\tIndividual BOs:\n");
+	amdgpu_debugfs_vm_bo_status_info(m, &vm->individual);
 }
 #endif
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index b5216bc1292f..cc96a3e6252f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -216,6 +216,23 @@ struct amdgpu_vm_bo_base {
 	bool				moved;
 };
 
+/*
+ * The following status lists contain amdgpu_vm_bo_base objects for
+ * either PD/PTs, per VM BOs or BOs with individual resv object.
+ *
+ * The state transits are: evicted -> moved -> idle
+ */
+struct amdgpu_vm_bo_status {
+	/* BOs evicted which need to move into place again */
+	struct list_head		evicted;
+
+	/* BOs which moved but new location hasn't been updated in the PDs/PTs */
+	struct list_head		moved;
+
+	/* BOs done with the state machine and need no further action */
+	struct list_head		idle;
+};
+
 /* provided by hw blocks that can write ptes, e.g., sdma */
 struct amdgpu_vm_pte_funcs {
 	/* number of dw to reserve per operation */
@@ -349,46 +366,25 @@ struct amdgpu_vm {
 	spinlock_t		stats_lock;
 	struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM];
 
+	/* BO's belonging to PD/PT which are internal to the kernel. */
+	struct amdgpu_vm_bo_status	kernel;
+
 	/*
-	 * The following lists contain amdgpu_vm_bo_base objects for either
-	 * PDs, PTs or per VM BOs. The state transits are:
-	 *
-	 * evicted -> relocated (PDs, PTs) or moved (per VM BOs) -> idle
-	 *
-	 * Lists are protected by the root PD dma_resv lock.
+	 * BOs allocated by userspace where the dma_resv is shared with the
+	 * root PD
 	 */
-
-	/* Per-VM and PT BOs who needs a validation */
-	struct list_head	evicted;
-
-	/* PT BOs which relocated and their parent need an update */
-	struct list_head	relocated;
-
-	/* per VM BOs moved, but not yet updated in the PT */
-	struct list_head	moved;
-
-	/* All BOs of this VM not currently in the state machine */
-	struct list_head	idle;
+	struct amdgpu_vm_bo_status	always_valid;
 
 	/*
 	 * The following lists contain amdgpu_vm_bo_base objects for BOs which
-	 * have their own dma_resv object and not depend on the root PD. Their
-	 * state transits are:
-	 *
-	 * evicted_user or invalidated -> done
+	 * have their own dma_resv object and not depend on the root PD.
 	 *
-	 * Lists are protected by the invalidated_lock.
+	 * Lists are protected by the individual_lock.
 	 */
-	spinlock_t		invalidated_lock;
-
-	/* BOs for user mode queues that need a validation */
-	struct list_head	evicted_user;
-
-	/* regular invalidated BOs, but not yet updated in the PT */
-	struct list_head	invalidated;
+	spinlock_t			individual_lock;
 
-	/* BOs which are invalidated, has been updated in the PTs */
-	struct list_head        done;
+	/* Userspace BOs with individual resv object */
+	struct amdgpu_vm_bo_status	individual;
 
 	/*
 	 * This list contains amdgpu_bo_va_mapping objects which have been freed
@@ -510,8 +506,8 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
 		      unsigned int num_fences);
-int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
-			     unsigned int num_fences);
+int amdgpu_vm_lock_individual(struct amdgpu_vm *vm, struct drm_exec *exec,
+			      unsigned int num_fences);
 bool amdgpu_vm_ready(struct amdgpu_vm *vm);
 uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-- 
2.43.0


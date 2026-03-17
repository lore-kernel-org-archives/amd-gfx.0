Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9511FD707B
	for <amd-gfx@archiver.kernel.org>; Tue, 17 Mar 2026 10:55:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E90A10E5CF;
	Tue, 17 Mar 2026 10:55:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WWAzNLnX";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05D4110E5CD
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 10:55:12 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-439b9cf8cb5so6285270f8f.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 Mar 2026 03:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773744910; x=1774349710; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SMbAIy8ZPnWDUMJVOdXuQC3slGWkNvvl8KBdiqpgNYs=;
 b=WWAzNLnXdZs2lsVjnqxOdvhWTVUke2Stx2U7UkT/ok2pGVHf/1QGfjfRCRoUw9s6nT
 PFOn4ghcJA6kwWETjQrT2qBAjKMezfJzWTI07s6AYIbxZ48DxG3pWXQZzHSRCQ2RV8Yk
 cty/+ipeYg3cIore3/3k1V2yME5T6Xer5plAVrR9CJ4AKCwLXfduYv9yr2bLxA17/nA1
 pR3MKQFYUzMyBbC8IzN1agj3/Q2jjihzVyH0RzJIEauhcVY8VWjwEivz+3ApEYwAYSF4
 wggypzpoWcirXscBsnvQL+ouJoEPu9Lv7IjK4IF6tOLvJ6rtzRP1lxh97v8VLai+0djd
 pIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773744910; x=1774349710;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SMbAIy8ZPnWDUMJVOdXuQC3slGWkNvvl8KBdiqpgNYs=;
 b=W7mvnJ66cN40hE3PmF/4XCPXzdyvAB6pMEQUa3mQWjLb0q3JR/A2Y9vPfO+7f3yyc1
 vYDxcTL4WYSN/4FBYEnnnQJvf5xLYGlNAQ9YpQFT0HJgQfT7tyLWajW55jq0xFJtogo9
 xrkLCmngNHiULcbwBwZQ09I+VfNE2ub3UvAKSG3RLkdfjtUgfnFK1hpjoVlHIpcjfJDX
 VvrY7/uJIzpuRs+/IsxUlvP4Y5jdtbpDUsvHYIJct6PlQ2Tf165ZgAPH7E0zklRr7DZP
 NbOYpc2etkZtOcW9j2RLSSXVsPY2J/1FF4y4wifWK8SC3Uc52sIph0ehnxlp4P5ycnAV
 0Y5w==
X-Gm-Message-State: AOJu0Yz92Cq1pGc6FKwL2UMsG8E5E8FBpDIY+3HXJuAi8msxC9gv5sgR
 xZ6ipM8N+xX8FkmTlSj8+A69cGUCKoQ7aPIa/XaAMR9rauDyv3vzrV4u
X-Gm-Gg: ATEYQzz3b7do0WRrJr7j0qQHfrcUDVfDiSzQLxfMsog1PAeybBIIhdXt74bN9kTVKMs
 rT0KTMjcMTy2kEPj5ZvlOOKz/mhdkPxyuUhFX6/I3ysmtq/pafiIQ++HSorkaIfBZJPO21ax2sf
 HDeBAuj64W0WRwkVc3ABtyAGDCc8NlWoA9tvl9NI6TalYAglzpfg0GQXFkoWjqwgCb+2A3nMXQh
 6DEGGg9YmgBFPxd0JxRft5oV+C+PDRXwCfsj9Z5hP39ROCAXj/pc8z7h3o4n832HVLq769T/v3I
 lhGCrCGeJRKglM1peO24g1LWguqmk4hLdd8CC4vSnHJbSt2de1S1a1H+KgGnZkoTIFI/2433TKp
 BmULl06esXv/TMrULvYSs+SI6O21lbwJB2UOSSVDEcgrygHIZScTUovMFJsiS2OT9EBnDi88E/L
 oqn9l/fRufrqLsw3MNXpwLb1bvdNsifHiQrDsm
X-Received: by 2002:a05:6000:1885:b0:439:bce5:64fb with SMTP id
 ffacd0b85a97d-43a04d88000mr30132081f8f.23.1773744910142; 
 Tue, 17 Mar 2026 03:55:10 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1570:2300:fbdd:8811:84b7:347c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe20bd9csm49852223f8f.21.2026.03.17.03.55.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 03:55:09 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: sukhatri@amd.com, tursulin@ursulin.net, Alexander.Deucher@amd.com,
 Prike.Liang@amd.com, SRINIVASAN.SHANMUGAM@amd.com, christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/10] drm/amdgpu: restructure VM state machine v2
Date: Tue, 17 Mar 2026 11:54:59 +0100
Message-ID: <20260317105501.21479-9-christian.koenig@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 466 ++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  64 ++-
 3 files changed, 251 insertions(+), 301 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index c50a484d22e0..9b2dfeead299 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -1041,12 +1041,12 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
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
@@ -1058,14 +1058,14 @@ amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
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
@@ -1097,7 +1097,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 		if (unlikely(ret))
 			goto unlock_all;
 
-		ret = amdgpu_vm_lock_done_list(vm, &exec, 1);
+		ret = amdgpu_vm_lock_individual(vm, &exec, 1);
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(ret))
 			goto unlock_all;
@@ -1140,7 +1140,7 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 
 	key = 0;
 	/* Validate User Ptr BOs */
-	list_for_each_entry(bo_va, &vm->done, base.vm_status) {
+	list_for_each_entry(bo_va, &vm->always_valid.idle, base.vm_status) {
 		bo = bo_va->base.bo;
 		if (!bo)
 			continue;
@@ -1190,10 +1190,10 @@ amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 
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
index b89013a6aa0b..1223d1e86afa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -138,143 +138,127 @@ static void amdgpu_vm_assert_locked(struct amdgpu_vm *vm)
 	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
 }
 
-/**
- * amdgpu_vm_bo_evicted - vm_bo is evicted
- *
- * @vm_bo: vm_bo which is evicted
- *
- * State for PDs/PTs and per VM BOs which are not at the location they should
- * be.
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
  */
-static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
+static struct amdgpu_vm_bo_status *
+amdgpu_vm_bo_lock_lists(struct amdgpu_vm_bo_base *vm_bo)
 {
 	struct amdgpu_vm *vm = vm_bo->vm;
 	struct amdgpu_bo *bo = vm_bo->bo;
 
-	vm_bo->moved = true;
-	amdgpu_vm_assert_locked(vm);
-	if (bo->tbo.type == ttm_bo_type_kernel)
-		list_move(&vm_bo->vm_status, &vm->evicted);
-	else
-		list_move_tail(&vm_bo->vm_status, &vm->evicted);
-}
-/**
- * amdgpu_vm_bo_moved - vm_bo is moved
- *
- * @vm_bo: vm_bo which is moved
- *
- * State for per VM BOs which are moved, but that change is not yet reflected
- * in the page tables.
- */
-static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
-{
-	amdgpu_vm_assert_locked(vm_bo->vm);
-	list_move(&vm_bo->vm_status, &vm_bo->vm->moved);
-}
+	if (amdgpu_vm_is_bo_always_valid(vm, bo)) {
+		/* No extra locking needed, protected by the root PD resv lock */
+		amdgpu_vm_assert_locked(vm);
 
-/**
- * amdgpu_vm_bo_idle - vm_bo is idle
- *
- * @vm_bo: vm_bo which is now idle
- *
- * State for PDs/PTs and per VM BOs which have gone through the state machine
- * and are now idle.
- */
-static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
-{
-	amdgpu_vm_assert_locked(vm_bo->vm);
-	list_move(&vm_bo->vm_status, &vm_bo->vm->idle);
-	vm_bo->moved = false;
+		if (bo->tbo.type == ttm_bo_type_kernel)
+			return &vm->kernel;
+
+		return &vm->always_valid;
+	}
+
+	spin_lock(&vm_bo->vm->individual_lock);
+	return &vm->individual;
 }
 
-/**
- * amdgpu_vm_bo_invalidated - vm_bo is invalidated
- *
- * @vm_bo: vm_bo which is now invalidated
- *
- * State for normal BOs which are invalidated and that change not yet reflected
- * in the PTs.
- */
-static void amdgpu_vm_bo_invalidated(struct amdgpu_vm_bo_base *vm_bo)
+/* Eventually unlock the status list lock again */
+static void amdgpu_vm_bo_unlock_lists(struct amdgpu_vm_bo_base *vm_bo)
 {
-	spin_lock(&vm_bo->vm->invalidated_lock);
-	list_move(&vm_bo->vm_status, &vm_bo->vm->invalidated);
-	spin_unlock(&vm_bo->vm->invalidated_lock);
+	if (amdgpu_vm_is_bo_always_valid(vm_bo->vm, vm_bo->bo))
+		amdgpu_vm_assert_locked(vm_bo->vm);
+	else
+		spin_unlock(&vm_bo->vm->individual_lock);
 }
 
 /**
- * amdgpu_vm_bo_evicted_user - vm_bo is evicted
+ * amdgpu_vm_bo_evicted - vm_bo is evicted
  *
  * @vm_bo: vm_bo which is evicted
  *
- * State for BOs used by user mode queues which are not at the location they
- * should be.
+ * State for vm_bo objects meaning the underlying BO was evicted and need to
+ * move in place again.
  */
-static void amdgpu_vm_bo_evicted_user(struct amdgpu_vm_bo_base *vm_bo)
+static void amdgpu_vm_bo_evicted(struct amdgpu_vm_bo_base *vm_bo)
 {
-	amdgpu_vm_assert_locked(vm_bo->vm);
+	struct amdgpu_vm_bo_status *lists;
+
+	lists = amdgpu_vm_bo_lock_lists(vm_bo);
 	vm_bo->moved = true;
-	list_move(&vm_bo->vm_status, &vm_bo->vm->evicted_user);
+	list_move(&vm_bo->vm_status, &lists->evicted);
+	amdgpu_vm_bo_unlock_lists(vm_bo);
 }
-
 /**
- * amdgpu_vm_bo_relocated - vm_bo is reloacted
+ * amdgpu_vm_bo_moved - vm_bo is moved
  *
- * @vm_bo: vm_bo which is relocated
+ * @vm_bo: vm_bo which is moved
  *
- * State for PDs/PTs which needs to update their parent PD.
- * For the root PD, just move to idle state.
+ * State for vm_bo objects meaning the underlying BO was moved but the new
+ * location not yet reflected in the page tables.
  */
-static void amdgpu_vm_bo_relocated(struct amdgpu_vm_bo_base *vm_bo)
+static void amdgpu_vm_bo_moved(struct amdgpu_vm_bo_base *vm_bo)
 {
-	amdgpu_vm_assert_locked(vm_bo->vm);
-	if (vm_bo->bo->parent)
-		list_move(&vm_bo->vm_status, &vm_bo->vm->relocated);
-	else
-		amdgpu_vm_bo_idle(vm_bo);
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
- * amdgpu_vm_bo_done - vm_bo is done
+ * amdgpu_vm_bo_idle - vm_bo is idle
  *
- * @vm_bo: vm_bo which is now done
+ * @vm_bo: vm_bo which is now idle
  *
- * State for normal BOs which are invalidated and that change has been updated
- * in the PTs.
+ * State for vm_bo objects meaning we are done with the state machine and no
+ * further action is necessary.
  */
-static void amdgpu_vm_bo_done(struct amdgpu_vm_bo_base *vm_bo)
+static void amdgpu_vm_bo_idle(struct amdgpu_vm_bo_base *vm_bo)
 {
-	amdgpu_vm_assert_locked(vm_bo->vm);
-	list_move(&vm_bo->vm_status, &vm_bo->vm->done);
+	struct amdgpu_vm_bo_status *lists;
+
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
@@ -402,8 +386,10 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 	base->next = NULL;
 	INIT_LIST_HEAD(&base->vm_status);
 
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
 	if (!bo)
 		return;
+
 	base->next = bo->vm_bo;
 	bo->vm_bo = base;
 
@@ -412,27 +398,22 @@ void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
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
@@ -453,41 +434,41 @@ int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
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
@@ -584,9 +565,9 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 {
 	uint64_t new_vm_generation = amdgpu_vm_generation(adev, vm);
 	struct amdgpu_vm_bo_base *bo_base, *tmp;
-	struct amdgpu_bo *bo;
 	int r;
 
+	dma_resv_assert_held(vm->root.bo->tbo.base.resv);
 	if (vm->generation != new_vm_generation) {
 		vm->generation = new_vm_generation;
 		amdgpu_vm_bo_reset_state_machine(vm);
@@ -596,38 +577,59 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -652,7 +654,7 @@ bool amdgpu_vm_ready(struct amdgpu_vm *vm)
 	ret = !vm->evicting;
 	amdgpu_vm_eviction_unlock(vm);
 
-	ret &= list_empty(&vm->evicted);
+	ret &= list_empty(&vm->kernel.evicted);
 
 	spin_lock(&vm->immediate.lock);
 	ret &= !vm->immediate.stopped;
@@ -952,7 +954,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 
 	amdgpu_vm_assert_locked(vm);
 
-	if (list_empty(&vm->relocated))
+	if (list_empty(&vm->kernel.moved))
 		return 0;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
@@ -968,7 +970,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (r)
 		goto error;
 
-	list_for_each_entry(entry, &vm->relocated, vm_status) {
+	list_for_each_entry(entry, &vm->kernel.moved, vm_status) {
 		/* vm_flush_needed after updating moved PDEs */
 		flush_tlb_needed |= entry->moved;
 
@@ -984,9 +986,8 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	if (flush_tlb_needed)
 		atomic64_inc(&vm->tlb_seq);
 
-	list_for_each_entry_safe(entry, tmp, &vm->relocated, vm_status) {
+	list_for_each_entry_safe(entry, tmp, &vm->kernel.moved, vm_status)
 		amdgpu_vm_bo_idle(entry);
-	}
 
 error:
 	drm_dev_exit(idx);
@@ -1357,7 +1358,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 		else
 			amdgpu_vm_bo_idle(&bo_va->base);
 	} else {
-		amdgpu_vm_bo_done(&bo_va->base);
+		amdgpu_vm_bo_idle(&bo_va->base);
 	}
 
 	list_splice_init(&bo_va->invalids, &bo_va->valids);
@@ -1585,19 +1586,20 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
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
@@ -1627,11 +1629,11 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
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
@@ -2174,9 +2176,9 @@ void amdgpu_vm_bo_del(struct amdgpu_device *adev,
 		}
 	}
 
-	spin_lock(&vm->invalidated_lock);
+	spin_lock(&vm->individual_lock);
 	list_del(&bo_va->base.vm_status);
-	spin_unlock(&vm->invalidated_lock);
+	spin_unlock(&vm->individual_lock);
 
 	list_for_each_entry_safe(mapping, next, &bo_va->valids, list) {
 		list_del(&mapping->list);
@@ -2256,14 +2258,7 @@ void amdgpu_vm_bo_invalidate(struct amdgpu_bo *bo, bool evicted)
 
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
 
@@ -2554,15 +2549,12 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
 
@@ -3005,100 +2997,62 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
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
index ae9449d5b00c..9b4a4e5c24f1 100644
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
@@ -508,8 +504,8 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
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


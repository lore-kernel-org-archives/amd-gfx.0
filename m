Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26B52C8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 15:02:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C3A9510EA10;
	Thu, 28 Aug 2025 15:02:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FoNfcrzz";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D5AC10EA10
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 15:02:04 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-3c985f13d45so746995f8f.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 08:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756393322; x=1756998122; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=EbdYFyT43pgG/EqwS5BpOEEqTgPehHrBDPoM6HVXiko=;
 b=FoNfcrzz7IkSJOhnykuW2AxfXcutpNW33dCjC8JXxvbIvlbub1q1E9rzhU+eHAUZ3+
 94RQ3/CuQywR5JQ/+zZp8I01szyzEdeij9UmdMSU213nddXYeQXo8W9RnEFLsotvdOlF
 nf33vYfzrRdcA5BhAMmaam88P7BAyO1FV4TFHu3rmjiKykY+aZD7wKKWOmk5SyRTDqaj
 G69OrUgKaqZhyL8GrCvIjpvfY+pbzZzYcLuzCdg6vsMyFO2rSC0yo1ZCTFewJRyDy0xy
 XZX7uXzIIbp+f/cFYiCfq9XN0n4jitYPRgJ3KQ7H59YSCcR205PDZaffvwUG9J2fBRQ+
 IVPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756393322; x=1756998122;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EbdYFyT43pgG/EqwS5BpOEEqTgPehHrBDPoM6HVXiko=;
 b=FPNOCXFSBOzMtg5eWqX8WhZDN6vDktHXl/SICv2UfQUYNVoXSdoXuysChCp9VtcdF5
 gObIWQ3GL0WULCzjNAt+hN3YL4Jw0NCFj1uDJ1dKXI9Qn4g8XFCMIUcl4/H9g+JZXegV
 jJXQHBeJHEdSW09JypEITPnf89BIr9gCQpw/m90FyBnM5ADRoVkAmjZ/efc4+SjqzI4r
 xaJ+CxOw1ISBxJUBzy83B6CeMr8nSxgCuK/GwuIKjWapTpvRfcDqh//zP10OIuTnLv/X
 8DaVZ8qbZIF3f2Gc9+czhiW5OLDq0x1VDk1SQwK3P3ZZAWfXQOg9/6v5aahHt3l/Uiv8
 6cww==
X-Gm-Message-State: AOJu0YzK2Gr4ecJNSJuuCIuG36vpZWMbVrZcjUG+YCWmA8IjxwZkPEZ+
 T1CqdxPUHcMj/BmalGC2lEKR1eDSXGVx7emsktLGeRQVZBRWb4MrBR4SH0RVBA==
X-Gm-Gg: ASbGncvO9s7vXxmZW4tCXV89Wbup4GIOiQxFZU1X/ugjcAaiCk7xOO4Le95Fu1drVcs
 TvT8fGx9JvxAF2cGOo8vD4rg/XiDypeDvIiW7A2XGVQD6bi4hXxbpqXAIDyXQR5fM/Bdbxng/pc
 m/LM6viVONlHzeJqJZnokJcGS2W4SypzBfnZ6AXIMLVSjq+pltNbgUpjf2JFb0rSGzAw+ezQJUl
 oLBu8durxC2I4nlkGucbDFdYCrTm3tbSvClGLSvdnsPLlSp2fOyyX+YKNI3wWe5Ezsza8e49jh0
 Ni331o8RDaXcS14s/Xu4Mab3PiabdUEXAdwBK7ziHhcEvc3WuhU5dBIQgc8OB7ywv6qhHi+SGmF
 1iDOMoOCbypGfAletf/spm2F0iMd8A3R88egTKFdhUXkJ
X-Google-Smtp-Source: AGHT+IGvFaYon8aBeI7EF1MysJrXpSkmpVIlrF+QGQDj9JhhCkluZlupipo0CbHcF0KCf5sE5n6Kqg==
X-Received: by 2002:a5d:64cc:0:b0:3b7:9d87:9808 with SMTP id
 ffacd0b85a97d-3cbb15ca448mr7641442f8f.15.1756393322004; 
 Thu, 28 Aug 2025 08:02:02 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1520:b00:8770:5cba:6330:4e5e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b71c10e3csm78212655e9.20.2025.08.28.08.02.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 08:02:01 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Sunil.Khatri@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Subject: [PATCH 1/3] drm/amdgpu: fix userq VM validation v3
Date: Thu, 28 Aug 2025 17:01:58 +0200
Message-ID: <20250828150200.4035-1-christian.koenig@amd.com>
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

That was actually complete nonsense and not validating the BOs
at all. The code just cleared all VM areas were it couldn't grab the
lock for a BO.

Try to fix this. Only compile tested at the moment.

v2: fix fence slot reservation as well as pointed out by Sunil.
    also validate PDs, PTs, per VM BOs and update PDEs
v3: grab the status_lock while working with the done list.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 136 ++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  35 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |   2 +
 3 files changed, 97 insertions(+), 76 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 424831997cb1..abc2f96bea76 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -545,108 +545,92 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 	return ret;
 }
 
-static int
-amdgpu_userq_validate_vm_bo(void *_unused, struct amdgpu_bo *bo)
+static int amdgpu_userq_validate_vm(void *param, struct amdgpu_bo *bo)
 {
 	struct ttm_operation_ctx ctx = { false, false };
-	int ret;
 
 	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
-
-	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-	if (ret)
-		DRM_ERROR("Fail to validate\n");
-
-	return ret;
+	return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 }
 
 static int
-amdgpu_userq_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
+amdgpu_userq_validate_bos(struct amdgpu_device *adev, struct drm_exec *exec,
+			  struct amdgpu_vm *vm)
 {
-	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
-	struct amdgpu_vm *vm = &fpriv->vm;
-	struct amdgpu_device *adev = uq_mgr->adev;
+	struct ttm_operation_ctx ctx = { false, false };
 	struct amdgpu_bo_va *bo_va;
-	struct ww_acquire_ctx *ticket;
-	struct drm_exec exec;
 	struct amdgpu_bo *bo;
-	struct dma_resv *resv;
-	bool clear, unlock;
-	int ret = 0;
-
-	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
-	drm_exec_until_all_locked(&exec) {
-		ret = amdgpu_vm_lock_pd(vm, &exec, 2);
-		drm_exec_retry_on_contention(&exec);
-		if (unlikely(ret)) {
-			drm_file_err(uq_mgr->file, "Failed to lock PD\n");
-			goto unlock_all;
-		}
-
-		/* Lock the done list */
-		list_for_each_entry(bo_va, &vm->done, base.vm_status) {
-			bo = bo_va->base.bo;
-			if (!bo)
-				continue;
-
-			ret = drm_exec_lock_obj(&exec, &bo->tbo.base);
-			drm_exec_retry_on_contention(&exec);
-			if (unlikely(ret))
-				goto unlock_all;
-		}
-	}
+	int ret;
 
 	spin_lock(&vm->status_lock);
-	while (!list_empty(&vm->moved)) {
-		bo_va = list_first_entry(&vm->moved, struct amdgpu_bo_va,
+	while (!list_empty(&vm->invalidated)) {
+		bo_va = list_first_entry(&vm->invalidated,
+					 struct amdgpu_bo_va,
 					 base.vm_status);
 		spin_unlock(&vm->status_lock);
 
-		/* Per VM BOs never need to bo cleared in the page tables */
+		bo = bo_va->base.bo;
+		ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 2);
+		if (unlikely(ret))
+			return ret;
+
+		amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
+		ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+		if (ret)
+			return ret;
+
+		/* This moves the bo_va to the done list */
 		ret = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (ret)
-			goto unlock_all;
+			return ret;
+
 		spin_lock(&vm->status_lock);
 	}
+	spin_unlock(&vm->status_lock);
 
-	ticket = &exec.ticket;
-	while (!list_empty(&vm->invalidated)) {
-		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
-					 base.vm_status);
-		resv = bo_va->base.bo->tbo.base.resv;
-		spin_unlock(&vm->status_lock);
+	return 0;
+}
 
-		bo = bo_va->base.bo;
-		ret = amdgpu_userq_validate_vm_bo(NULL, bo);
-		if (ret) {
-			drm_file_err(uq_mgr->file, "Failed to validate BO\n");
-			goto unlock_all;
-		}
+static int
+amdgpu_userq_update_vm(struct amdgpu_userq_mgr *uq_mgr)
+{
+	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
+	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_vm *vm = &fpriv->vm;
+	struct drm_exec exec;
+	int ret;
 
-		/* Try to reserve the BO to avoid clearing its ptes */
-		if (!adev->debug_vm && dma_resv_trylock(resv)) {
-			clear = false;
-			unlock = true;
-		/* The caller is already holding the reservation lock */
-		} else if (dma_resv_locking_ctx(resv) == ticket) {
-			clear = false;
-			unlock = false;
-		/* Somebody else is using the BO right now */
-		} else {
-			clear = true;
-			unlock = false;
-		}
+	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
+	drm_exec_until_all_locked(&exec) {
+		ret = amdgpu_vm_lock_pd(vm, &exec, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(ret))
+			goto unlock_all;
 
-		ret = amdgpu_vm_bo_update(adev, bo_va, clear);
+		ret = amdgpu_vm_lock_done(vm, &exec, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(ret))
+			goto unlock_all;
 
-		if (unlock)
-			dma_resv_unlock(resv);
-		if (ret)
+		ret = amdgpu_vm_validate(adev, vm, NULL,
+					 amdgpu_userq_validate_vm,
+					 NULL);
+		if (unlikely(ret))
 			goto unlock_all;
 
-		spin_lock(&vm->status_lock);
+		ret = amdgpu_userq_validate_bos(adev, &exec, vm);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(ret))
+			goto unlock_all;
 	}
-	spin_unlock(&vm->status_lock);
+
+	ret = amdgpu_vm_handle_moved(adev, vm, NULL);
+	if (ret)
+		goto unlock_all;
+
+	ret = amdgpu_vm_update_pdes(adev, vm, false);
+	if (ret)
+		goto unlock_all;
 
 	ret = amdgpu_eviction_fence_replace_fence(&fpriv->evf_mgr, &exec);
 	if (ret)
@@ -667,7 +651,7 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
 
 	mutex_lock(&uq_mgr->userq_mutex);
 
-	ret = amdgpu_userq_validate_bos(uq_mgr);
+	ret = amdgpu_userq_update_vm(uq_mgr);
 	if (ret) {
 		drm_file_err(uq_mgr->file, "Failed to validate BOs to restore\n");
 		goto unlock;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index bf42246a3db2..16451c9bbe1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -484,6 +484,41 @@ int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
 				    2 + num_fences);
 }
 
+/**
+ * amdgpu_vm_lock_done - lock all BOs on the done list
+ * @exec: drm execution context
+ * @num_fences: number of extra fences to reserve
+ *
+ * Lock the BOs on the done list in the DRM execution context.
+ */
+int amdgpu_vm_lock_done(struct amdgpu_vm *vm, struct drm_exec *exec,
+			unsigned int num_fences)
+{
+	struct list_head *prev = &vm->done;
+	struct amdgpu_bo_va *bo_va;
+	struct amdgpu_bo *bo;
+	int ret;
+
+	/* We can only trust prev->next while holding the lock */
+	spin_lock(&vm->status_lock);
+	while (!list_is_head(prev->next, &vm->done)) {
+		bo_va = list_entry(prev->next, typeof(*bo_va), base.vm_status);
+		spin_unlock(&vm->status_lock);
+
+		bo = bo_va->base.bo;
+		if (bo) {
+			ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 1);
+			if (unlikely(ret))
+				return ret;
+		}
+		spin_lock(&vm->status_lock);
+		prev = prev->next;
+	}
+	spin_unlock(&vm->status_lock);
+
+	return 0;
+}
+
 /**
  * amdgpu_vm_move_to_lru_tail - move all BOs to the end of LRU
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index f9549f6b3d1f..0e3884dfdb6d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -492,6 +492,8 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
 		      unsigned int num_fences);
+int amdgpu_vm_lock_done(struct amdgpu_vm *vm, struct drm_exec *exec,
+			unsigned int num_fences);
 bool amdgpu_vm_ready(struct amdgpu_vm *vm);
 uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-- 
2.43.0


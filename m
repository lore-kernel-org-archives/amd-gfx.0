Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A69F2CAC58E
	for <amd-gfx@archiver.kernel.org>; Thu, 11 Sep 2025 12:09:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2EB510EAE8;
	Thu, 11 Sep 2025 12:09:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bTIo6tLo";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A9CA10EAE2
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 12:09:53 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-45dec1ae562so5948685e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 11 Sep 2025 05:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757592592; x=1758197392; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cnK9V3zA/N1+LUv89AAcFisLzI1/tI0RUJqaHHJ2708=;
 b=bTIo6tLo2WApq2UNp1S6la/UT5GgYP490uLQ1VYX2CaX8o8uQvAVkTylU9NS1yjX/6
 TPOzi1PHfs3nhp5Tzbh4OubL245re3DTKIBRE6NZFkKZel1wxKpjEQKYcGvh6rSRnvat
 O7EL8YmeeOsf2aiDcPNguQd/4igkyjqimcvt5fdmvDtE/eYfZB/JBVsQW2w8hXw5H9Jp
 KUUEujA4u53SES1wheT26lg8NcQwdtT23j9gBGyfdOqio9uS5u959TO4xlZGhhFB7MfZ
 BdRrc8vjIBIvYe4uKiNMn9Q1ZCaZQuDAWogP5GyerUmhDoIqzLERHEzyCTo5c8N3ZgRW
 HXtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757592592; x=1758197392;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cnK9V3zA/N1+LUv89AAcFisLzI1/tI0RUJqaHHJ2708=;
 b=WZWh2dii7m/GDe9FM8/OlEl0OK850uv10JJcO+936UamJ1cHiYV3wXH8vXGZFWee02
 QgloyP4SOIuw8I3xCXZG5b7pvDXdz7oz7yuy+ZQ0S0nO8hzfEKoIYyHjrjH1pSYlRVed
 ZwICQrV0OEA15Qznf8ifhiObv5DJC9VzO7eRWqXji9qJEVCQDh5lIY7bCSffGbqJlo3M
 dWVZ25TNCPXPbX87RfsDOyOOKutjo0CGuSUE+t+pNIlJ8MuCm2b1fXF5w/oMhePRbBJn
 tUObmtu8PRwrEv8raJ5K5MYucb/96kqinv1TIzVwtbSmHlF+bZTplBbDZPO/m94dbvkC
 DReA==
X-Gm-Message-State: AOJu0Ywuob0/g6cHpK3GEmapQ0+0W/Kx+2RgzSK9hOhCn6BUSe11a6tY
 0I3u3nsL/cKdSSTU+dw0cePagnVcL4S0aCGThVD9+8ZoodiYA7oy0Im5
X-Gm-Gg: ASbGncs5MTuBE37YLOFU2OWQC4z4G3pWfMFjCEsw3fWl8QTCDbTgqiLuCtBAGoDDik8
 G5Syrdd8c20NduVUaIkZXIFfgKkcUoKS3Z3kwn9qtUnvEPTbwjJAiPf0OG28sfZJwLmarIjf+Sk
 xOOuKaAZv2Q4q2I8VuH6EH6Gxj8ZPtofjuxu4urC7uwFS5iCIA12hpw6vMK0MCZaDthqJzz8GYe
 8MKU0Wt70SmQx//MRo3KcpiaWELaCpkWGaK8ImGNdE10epx+2wEgDuYhiziGS5qU0aKviBfOTFh
 1Y9atNmPv7o3ZMN/XtXBi7Ts0v937URbRMM2L+A3GQM5O1DgxKQXSd+v8JL/OsQ32i7NRJM6QfP
 waex/WP/rvL8G3SF8H+EMDrdjq0ehqFKsnslrTUTVT6PLFvlurtU0QCuheA==
X-Google-Smtp-Source: AGHT+IH4X/z5XtB2vAU2oP/4ofI5j6K8Wkn/PBy1NrjrHubGm0CEWLTdADcQ4o8UB/M1mjMBIMbyDQ==
X-Received: by 2002:a05:600c:1987:b0:458:b01c:8f with SMTP id
 5b1f17b1804b1-45ddde8a55cmr209889925e9.8.1757592591610; 
 Thu, 11 Sep 2025 05:09:51 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1539:fb00:efcb:f439:6900:a9d9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e7607e1400sm2224744f8f.55.2025.09.11.05.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Sep 2025 05:09:51 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexdeucher@gmail.com, Sunil.Khatri@amd.com, Philip.Yang@amd.com,
 Prike.Liang@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/4] drm/amdgpu: fix userq VM validation v4
Date: Thu, 11 Sep 2025 14:09:47 +0200
Message-ID: <20250911120950.3343-1-christian.koenig@amd.com>
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
v4: rename functions, add some comments, fix waiting for updates to
    complete.
v4: rename amdgpu_vm_lock_done_list(), add some more comments

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 148 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  35 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |   2 +
 3 files changed, 110 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 9608fe3b5a9e..0ccbd3c5d88d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -661,108 +661,106 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
 	return ret;
 }
 
+static int amdgpu_userq_validate_vm(void *param, struct amdgpu_bo *bo)
+{
+	struct ttm_operation_ctx ctx = { false, false };
+
+	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
+	return ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+}
+
+/* Handle all BOs on the invalidated list, validate them and update the PTs */
 static int
-amdgpu_userq_validate_vm_bo(void *_unused, struct amdgpu_bo *bo)
+amdgpu_userq_bo_validate(struct amdgpu_device *adev, struct drm_exec *exec,
+			 struct amdgpu_vm *vm)
 {
 	struct ttm_operation_ctx ctx = { false, false };
+	struct amdgpu_bo_va *bo_va;
+	struct amdgpu_bo *bo;
 	int ret;
 
-	amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
+	spin_lock(&vm->status_lock);
+	while (!list_empty(&vm->invalidated)) {
+		bo_va = list_first_entry(&vm->invalidated,
+					 struct amdgpu_bo_va,
+					 base.vm_status);
+		spin_unlock(&vm->status_lock);
 
-	ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
-	if (ret)
-		DRM_ERROR("Fail to validate\n");
+		bo = bo_va->base.bo;
+		ret = drm_exec_prepare_obj(exec, &bo->tbo.base, 2);
+		if (unlikely(ret))
+			return ret;
 
-	return ret;
+		amdgpu_bo_placement_from_domain(bo, bo->allowed_domains);
+		ret = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+		if (ret)
+			return ret;
+
+		/* This moves the bo_va to the done list */
+		ret = amdgpu_vm_bo_update(adev, bo_va, false);
+		if (ret)
+			return ret;
+
+		spin_lock(&vm->status_lock);
+	}
+	spin_unlock(&vm->status_lock);
+
+	return 0;
 }
 
+/* Make sure the whole VM is ready to be used */
 static int
-amdgpu_userq_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
+amdgpu_userq_vm_validate(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
-	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo_va *bo_va;
-	struct ww_acquire_ctx *ticket;
 	struct drm_exec exec;
-	struct amdgpu_bo *bo;
-	struct dma_resv *resv;
-	bool clear, unlock;
-	int ret = 0;
+	int ret;
 
 	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(&exec) {
-		ret = amdgpu_vm_lock_pd(vm, &exec, 2);
+		ret = amdgpu_vm_lock_pd(vm, &exec, 1);
 		drm_exec_retry_on_contention(&exec);
-		if (unlikely(ret)) {
-			drm_file_err(uq_mgr->file, "Failed to lock PD\n");
+		if (unlikely(ret))
 			goto unlock_all;
-		}
-
-		/* Lock the done list */
-		list_for_each_entry(bo_va, &vm->done, base.vm_status) {
-			bo = bo_va->base.bo;
-			if (!bo)
-				continue;
 
-			ret = drm_exec_lock_obj(&exec, &bo->tbo.base);
-			drm_exec_retry_on_contention(&exec);
-			if (unlikely(ret))
-				goto unlock_all;
-		}
-	}
-
-	spin_lock(&vm->status_lock);
-	while (!list_empty(&vm->moved)) {
-		bo_va = list_first_entry(&vm->moved, struct amdgpu_bo_va,
-					 base.vm_status);
-		spin_unlock(&vm->status_lock);
-
-		/* Per VM BOs never need to bo cleared in the page tables */
-		ret = amdgpu_vm_bo_update(adev, bo_va, false);
-		if (ret)
+		ret = amdgpu_vm_lock_done_list(vm, &exec, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(ret))
 			goto unlock_all;
-		spin_lock(&vm->status_lock);
-	}
-
-	ticket = &exec.ticket;
-	while (!list_empty(&vm->invalidated)) {
-		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
-					 base.vm_status);
-		resv = bo_va->base.bo->tbo.base.resv;
-		spin_unlock(&vm->status_lock);
 
-		bo = bo_va->base.bo;
-		ret = amdgpu_userq_validate_vm_bo(NULL, bo);
-		if (ret) {
-			drm_file_err(uq_mgr->file, "Failed to validate BO\n");
+		/* This validates PDs, PTs and per VM BOs */
+		ret = amdgpu_vm_validate(adev, vm, NULL,
+					 amdgpu_userq_validate_vm,
+					 NULL);
+		if (unlikely(ret))
 			goto unlock_all;
-		}
 
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
+		/* This locks and validates the remaining evicted BOs */
+		ret = amdgpu_userq_bo_validate(adev, &exec, vm);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(ret))
+			goto unlock_all;
+	}
 
-		ret = amdgpu_vm_bo_update(adev, bo_va, clear);
+	ret = amdgpu_vm_handle_moved(adev, vm, NULL);
+	if (ret)
+		goto unlock_all;
 
-		if (unlock)
-			dma_resv_unlock(resv);
-		if (ret)
-			goto unlock_all;
+	ret = amdgpu_vm_update_pdes(adev, vm, false);
+	if (ret)
+		goto unlock_all;
 
-		spin_lock(&vm->status_lock);
-	}
-	spin_unlock(&vm->status_lock);
+	/*
+	 * We need to wait for all VM updates to finish before restarting the
+	 * queues. Using the done list like that is now ok since everything is
+	 * locked in place.
+	 */
+	list_for_each_entry(bo_va, &vm->done, base.vm_status)
+		dma_fence_wait(bo_va->last_pt_update, false);
+	dma_fence_wait(vm->last_update, false);
 
 	ret = amdgpu_eviction_fence_replace_fence(&fpriv->evf_mgr, &exec);
 	if (ret)
@@ -783,7 +781,7 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
 
 	mutex_lock(&uq_mgr->userq_mutex);
 
-	ret = amdgpu_userq_validate_bos(uq_mgr);
+	ret = amdgpu_userq_vm_validate(uq_mgr);
 	if (ret) {
 		drm_file_err(uq_mgr->file, "Failed to validate BOs to restore\n");
 		goto unlock;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index bd12d8ff15a4..9980c0cded94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -484,6 +484,41 @@ int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
 				    2 + num_fences);
 }
 
+/**
+ * amdgpu_vm_lock_done_list - lock all BOs on the done list
+ * @exec: drm execution context
+ * @num_fences: number of extra fences to reserve
+ *
+ * Lock the BOs on the done list in the DRM execution context.
+ */
+int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
+			     unsigned int num_fences)
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
index e045c1590d78..3409904b5c63 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -491,6 +491,8 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 void amdgpu_vm_fini(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_lock_pd(struct amdgpu_vm *vm, struct drm_exec *exec,
 		      unsigned int num_fences);
+int amdgpu_vm_lock_done_list(struct amdgpu_vm *vm, struct drm_exec *exec,
+			     unsigned int num_fences);
 bool amdgpu_vm_ready(struct amdgpu_vm *vm);
 uint64_t amdgpu_vm_generation(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-- 
2.43.0


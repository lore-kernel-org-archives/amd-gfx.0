Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C26CA1015
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Sep 2025 11:27:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 40F3C10EB82;
	Fri,  5 Sep 2025 11:27:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SLN7uov4";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BB6610EB7E
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Sep 2025 11:27:04 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-61cebce2f78so1727983a12.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Sep 2025 04:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757071623; x=1757676423; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3u+s2kprkjGJcDmifKv1gdxblPTZBEOKTiY3KNdZQ2c=;
 b=SLN7uov4g/qjutHAHO+w6vp1p92o8BBfQWoWl/vjkAOcCS+UjYwJce4Qh7Y0uVinlz
 cHzeErIpYQSuBGq5HTte68BA9zqFEHMTtO0sZNWaRefyxO/j3vxeqbs0BrxzgkpG4N8W
 1IO74RT2Pz5GpSQcjPNe0dJUBiXCg/rh/XplDN2clijdkdlcmMTvPrvCaCJV7nw69QYZ
 RlXKB+9ifyDz1qDdLpXLDBzLKbIUBRO3NmtavQ08nTO3iIlurmrZJQB/4LL1lRNlfuBI
 1l+zTGN/ulMhZlP//1lWJECcK02u5IUIvL5kbEDeD1zwua/g8fcvVZ9YmrGfgbcYC8Iu
 US3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757071623; x=1757676423;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3u+s2kprkjGJcDmifKv1gdxblPTZBEOKTiY3KNdZQ2c=;
 b=W6NdAR2WeihHIPYFZ2tZXwLoVsl3i61gK3R9+fvwFmsg5EMNXO/rui+VnZ8fmNnOZL
 tSbc4JaPAIEbn4SI3KxTeb/yoYrtW7MQrtb272elqej9r9iC8DilqK05sWCYICg4LTnn
 +3p4gMSEpkPnzYtxvL4ywjaZmLqwPC45/V2DCU7aSBNneKPWqjpXwA62LCjF0bKSpCj3
 xYH1h+Mq1t64hA6G9gQNnURB24pwGjVauGS2/AOICXEkadcH6+0v9iiyZYjXN+HzZ/og
 HlpOqGk+q5dybcH+Ng/J/KzwnCmdC+RBPNLP6d9NI95sTDp1dtOF7x7Uyx0fP9kXd+kr
 6pNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFr1x2Or94XW2FQrX9osraJlGPqo3Pu1AP7vGNZ37A+G3WhlP+YL++6j1Xm/ploeDwOc1MTseV@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwsBkJwtMmWCbJ102Z4MlbyzEF7D+Z0hWsyl8zWWWceqRvEA+cH
 kbXUK5iOikvi3y8U2jvUlw+1rm1yHl9VfooYHhFVsINL4pGlp/ybov0t
X-Gm-Gg: ASbGncuvPq4JSPsiuSmBF3n2cGT3kwGKxrKAe4st67682JNHaZVhsHMRfzC1x1G8OAE
 RH+CwLRcfR/Es+W8d7F6K7d9aNzubTLzAVQ1R2t7pEkgYVJe+JByGmrOe1bJijhpc3K2s0578vt
 wVtt9OUeKSfSyJ0WBDQX8Docyjnv3992OUEHbzsFm1NZdS+erGxq0f3qkNkihhlI0YIP17E0KfX
 Vu8LUz4qLvX1aXdJpGLaXhEljpfvzBEsxY4QGKu1uPj/VAYk60cdhqX7aaqRKh5+CB0KVUlr0Z+
 YO5iEzy7KWJh3iylFZaqx5QWBD5twhGKufX49kz3wp+1AmCLGTa8q8QHs2KifDXHrI7qdq4jXve
 j/pDgCZoLsLTI44IKO+x71mvaGfzWKX6Mw2z1o7TVKG0z5EE=
X-Google-Smtp-Source: AGHT+IF1wQ0pBGaTBW8+UzRW0fThnyLQOYjkd8fQs73WMSPLLo3yq+O8JLLIq2gxokE7EvQJuujgWw==
X-Received: by 2002:a17:907:3d09:b0:af9:eace:8a52 with SMTP id
 a640c23a62f3a-b01d978f76fmr2123484466b.50.1757071622715; 
 Fri, 05 Sep 2025 04:27:02 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15bd:7900:c026:1908:2e29:be84])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b0079183496sm1551044366b.13.2025.09.05.04.27.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 04:27:02 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Sunil.Khatri@amd.com
Cc: alexander.deucher@amd.com, amd-gfx@lists.freedesktop.org,
 Prike.Liang@amd.com
Subject: [PATCH 1/3] drm/amdgpu: fix userq VM validation v4
Date: Fri,  5 Sep 2025 13:26:59 +0200
Message-ID: <20250905112701.2443-1-christian.koenig@amd.com>
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

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 146 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    |  35 ++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |   2 +
 3 files changed, 108 insertions(+), 75 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index e228c1e6800d..cb3432b12221 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -601,108 +601,104 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
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
+		ret = amdgpu_vm_lock_done(vm, &exec, 1);
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
@@ -723,7 +719,7 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
 
 	mutex_lock(&uq_mgr->userq_mutex);
 
-	ret = amdgpu_userq_validate_bos(uq_mgr);
+	ret = amdgpu_userq_vm_validate(uq_mgr);
 	if (ret) {
 		drm_file_err(uq_mgr->file, "Failed to validate BOs to restore\n");
 		goto unlock;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index bd12d8ff15a4..ec29fec1739e 100644
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
index e045c1590d78..f86b1a6afb0c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -491,6 +491,8 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm);
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


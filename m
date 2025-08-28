Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC31AC8303F
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Aug 2025 09:41:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E1A710E963;
	Thu, 28 Aug 2025 09:41:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U7LxUNiK";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2533F10E961
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 09:41:39 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-3cbb3ff70a0so443414f8f.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Aug 2025 02:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756374097; x=1756978897; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ZwWtwQjTWX2N4zabdx0giD1FYfINVSADrPei5do7Q/Y=;
 b=U7LxUNiKgKMaMI3+dqetKsPw461eypw+1/amu8RHnhI+W6NyEI3NWE5Bu9ckqR8GwI
 ZIWpAgS9ga2GSNZvHOtcTR8Plx+0U1Tbk6heaJ6inboJRUm38Gc39xwFuEFU/oymGY8Q
 OvLdMhNxSNx5IbFJGBSfuzBDWR2dOo96HyQQLQr29XartfXZVbTiyid3+6zuPcdHtOSO
 iqvd45kZdTXzXd9yT27+1egBkVmNmZXjp4rePFttqgPliZbbKxvVjZE0+cPKk6evCfJd
 bx2bptq3p3YCfmFxi267R9Y7Y3b6GF7bEVj6bclycqMup2OY559K41wwrZXJIiPC/qlg
 wsnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756374097; x=1756978897;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZwWtwQjTWX2N4zabdx0giD1FYfINVSADrPei5do7Q/Y=;
 b=UrbMT3U6QPUmESBzycmAzy4pBu53k0s7EjO+rWAlp85/zlK6TIZH5wnak1JIx7hZs5
 wHZv0U2PXcpDldju0C7ilpgdPDsk61zV+upfrnn86y47LjP/dB5Qfyl36Jwd5Gw0Qn+q
 jtwQs8xNO/BkiPaR5YnjAmAFC49HxXUKiYPLS3+YyxDY0Q2UtRNRxaUDnAHgMPzOz4Ah
 TwE4iNDgQIVAmOZNbWP72CN9aFcpdmKD2wcRvhRfFn3ucFxilZ3fpc0stunNxjz6uogY
 5dUnhcQuOWFuSmnZ0lq6dxTv4EMVgecxoWeuamEJLiKeHIqeV/PiqmPhyl3Ix6zyFGo6
 epvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW977FcBfD5/bWMgsoc94gGKISRainMcKkOu2MvMRWRmxMYT4aNqGnrb5EJL3Bls+4CV1ScCaAL@lists.freedesktop.org
X-Gm-Message-State: AOJu0YybRPI2wBn1sPiXcMYktDM32GPpk9xo6qhR9DJKe4Z7KTsT8CYg
 UIzrt6qhgI87VXpWYAPM+amA3nj2DawGp5QU3Ea1pcZ0Ykmy7mTertQ3QUnc4+JO
X-Gm-Gg: ASbGncsve/8UzwYZ+ysnOL5LDAW1Wn0xCQGPHD6x9qcEL3XJi2fekmkDgHM6g9C+pf4
 sluFnXyq65OonxIY66/gtcbZPaYl+Gkjsvz3WI0+/ZAAXQQ32O5M/rqYWtiUl+pzcdVBBdEa9oV
 UJTNHDT28FnqCI3Coi1chHKl83xG0ve7ffad9HTadA7uL1iuFCFqKBiJK8IiJkTsvCi0yWiCwxz
 G80cz8xoZplH7d5eP/xp7jRM4XCkAUCO0i+WnUq6O6PscanEbnECohzu0obHw2rBFBw3DH4X53G
 bTEC8ewb9hSAwXQK4wphlCTMKaXiNEcXliN1ojaPOaQ/w9yc5g8ZM1x0Ugetbp5vyJ0zpryR4tc
 IT3PNYFFsnl5jNf0Wo2XEfRZisBFWMiiyQOriQyV/gzt8
X-Google-Smtp-Source: AGHT+IF4phu2V4sMjmm0gEcBT+i3O7bYI/krTz7b8FOqaor5Wj4dGCzg6Z147JC1Rx1Qw0HF58LtTA==
X-Received: by 2002:a05:6000:2481:b0:3ca:a190:c43b with SMTP id
 ffacd0b85a97d-3caa190c76emr9303897f8f.36.1756374097317; 
 Thu, 28 Aug 2025 02:41:37 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1520:b00:c238:b791:3cb4:3e9e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cd2e01dd9dsm4941135f8f.60.2025.08.28.02.41.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 02:41:36 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Sunil.Khatri@amd.com
Cc: alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: fix userq VM validation v2
Date: Thu, 28 Aug 2025 11:41:34 +0200
Message-ID: <20250828094136.40078-1-christian.koenig@amd.com>
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

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 118 ++++++++++------------
 1 file changed, 56 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 424831997cb1..11edad1951c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -545,108 +545,102 @@ amdgpu_userq_restore_all(struct amdgpu_userq_mgr *uq_mgr)
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
 static int
-amdgpu_userq_validate_vm_bo(void *_unused, struct amdgpu_bo *bo)
+amdgpu_userq_validate_bos(struct amdgpu_device *adev, struct drm_exec *exec,
+			  struct amdgpu_vm *vm)
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
 
 static int
-amdgpu_userq_validate_bos(struct amdgpu_userq_mgr *uq_mgr)
+amdgpu_userq_update_vm(struct amdgpu_userq_mgr *uq_mgr)
 {
 	struct amdgpu_fpriv *fpriv = uq_mgr_to_fpriv(uq_mgr);
-	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_device *adev = uq_mgr->adev;
+	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo_va *bo_va;
-	struct ww_acquire_ctx *ticket;
 	struct drm_exec exec;
 	struct amdgpu_bo *bo;
-	struct dma_resv *resv;
-	bool clear, unlock;
 	int ret = 0;
 
 	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
 	drm_exec_until_all_locked(&exec) {
-		ret = amdgpu_vm_lock_pd(vm, &exec, 2);
+		ret = amdgpu_vm_lock_pd(vm, &exec, 1);
 		drm_exec_retry_on_contention(&exec);
 		if (unlikely(ret)) {
 			drm_file_err(uq_mgr->file, "Failed to lock PD\n");
 			goto unlock_all;
 		}
 
-		/* Lock the done list */
 		list_for_each_entry(bo_va, &vm->done, base.vm_status) {
 			bo = bo_va->base.bo;
 			if (!bo)
 				continue;
 
-			ret = drm_exec_lock_obj(&exec, &bo->tbo.base);
+			ret = drm_exec_prepare_obj(&exec, &bo->tbo.base, 1);
 			drm_exec_retry_on_contention(&exec);
 			if (unlikely(ret))
 				goto unlock_all;
 		}
-	}
 
-	spin_lock(&vm->status_lock);
-	while (!list_empty(&vm->moved)) {
-		bo_va = list_first_entry(&vm->moved, struct amdgpu_bo_va,
-					 base.vm_status);
-		spin_unlock(&vm->status_lock);
-
-		/* Per VM BOs never need to bo cleared in the page tables */
-		ret = amdgpu_vm_bo_update(adev, bo_va, false);
-		if (ret)
+		ret = amdgpu_vm_validate(adev, vm, NULL,
+					 amdgpu_userq_validate_vm,
+					 NULL);
+		if (unlikely(ret))
 			goto unlock_all;
-		spin_lock(&vm->status_lock);
-	}
 
-	ticket = &exec.ticket;
-	while (!list_empty(&vm->invalidated)) {
-		bo_va = list_first_entry(&vm->invalidated, struct amdgpu_bo_va,
-					 base.vm_status);
-		resv = bo_va->base.bo->tbo.base.resv;
-		spin_unlock(&vm->status_lock);
-
-		bo = bo_va->base.bo;
-		ret = amdgpu_userq_validate_vm_bo(NULL, bo);
-		if (ret) {
-			drm_file_err(uq_mgr->file, "Failed to validate BO\n");
+		ret = amdgpu_userq_validate_bos(adev, &exec, vm);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(ret))
 			goto unlock_all;
-		}
-
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
-
-		ret = amdgpu_vm_bo_update(adev, bo_va, clear);
+	}
 
-		if (unlock)
-			dma_resv_unlock(resv);
-		if (ret)
-			goto unlock_all;
+	ret = amdgpu_vm_handle_moved(adev, vm, NULL);
+	if (ret)
+		goto unlock_all;
 
-		spin_lock(&vm->status_lock);
-	}
-	spin_unlock(&vm->status_lock);
+	ret = amdgpu_vm_update_pdes(adev, vm, false);
+	if (ret)
+		goto unlock_all;
 
 	ret = amdgpu_eviction_fence_replace_fence(&fpriv->evf_mgr, &exec);
 	if (ret)
@@ -667,7 +661,7 @@ static void amdgpu_userq_restore_worker(struct work_struct *work)
 
 	mutex_lock(&uq_mgr->userq_mutex);
 
-	ret = amdgpu_userq_validate_bos(uq_mgr);
+	ret = amdgpu_userq_update_vm(uq_mgr);
 	if (ret) {
 		drm_file_err(uq_mgr->file, "Failed to validate BOs to restore\n");
 		goto unlock;
-- 
2.43.0


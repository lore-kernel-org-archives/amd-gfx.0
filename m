Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5EB0D61014
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Jan 2026 12:53:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6543610E0F8;
	Thu, 29 Jan 2026 12:53:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S9rUKFIl";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A154F10E0F8
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 12:53:30 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4801bc32725so7083145e9.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Jan 2026 04:53:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1769691209; x=1770296009; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=3RRcv5YwOfpvMNimk2KgSoLACazizL3JniAldJ7HA4A=;
 b=S9rUKFIlHhYwGOBOGNyHqsR0vn4UAJxnUkOE528f+IEjxnh91AarOkaJVP1lb4sson
 6Qy8tfbPWRXUg1fUIkODg01CXATtRM84riwt9UXp+cTbVCcaRT/kEO3yoi2MnqJ5DpNX
 w8/ZI0L1h6vHK+zIVXLdLdOJ7cFkoAd5w2l15+2clriCRW+ArqwghQOiXLF0OwHUPJmu
 FyZmYPRYrbVHIA97vMdcTYsZIQQZf4gfZNhPJO5DQyYxslDrQnc3Wa4V/f+hSTmpxvIY
 dAA/vtzOwBvQDtWpk62g9l7wGw1+DEb+7J3FkKCEtBD2/h9dpdYb7T9tat18/M9jooSL
 /Clg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769691209; x=1770296009;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3RRcv5YwOfpvMNimk2KgSoLACazizL3JniAldJ7HA4A=;
 b=ixncMvp51/czRb2h/anuFN31npE45+dZwywLdF4WDJUxadvIdvWX12NePmqWEumg6w
 5/TbLfHz5qkqAYW9g5BTWzLfvPebDeKtESoHqhUFV3E2bxUZsEteGlToxdIE8pSl+HwT
 z40VNpbsOs+CSuv74m7aghcLwDUJnvvnSRpDALAKX8HtkOXIkPeKVCgZKW0fZtkQiHhl
 P+lzyMrBI9PL8eec5hUx/RbYqEYCZS7yMzJukFrPanZdWjve5Al/jSX8fVYVP8CTYKmB
 1a/zVWpLm4Fzd/kF4bvBQPwSM2DCWnKwcHYf43EKkGwkfOpVT9Re6D5u12B+4nm+VB1D
 HAyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwcExAeRUQMxWGqBtnB0OKmteClCddb8pTJEhsTnhDGB0NVlO6Brmw2ulX7Rqv977GMdoxqHtn@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvPVspl7A2zunUnFyIu/4tUYjT9H+5fI9p0XmTAbuXduBZoLEv
 lnoODlkV6z00Qr+8y1QLQO/JXKV802onMsBlQVnX/UylP4jwA2B2/qA3
X-Gm-Gg: AZuq6aLcYKrori9xJuF6iMbE1kFs7x6dvzeW0hvsuUCNLW6pGJuH8wfn0e8xJFmgnNj
 W/ZvkDVDeuBVZTMYxxoeSwRBLQX0fMv5liXcoFVAW2cG+gTPBk1ukYpi/JZg5kbAj/5D+Mc6VvB
 3rnz1kgCbdjX/4ci8IRjDBD3oOeWkzUZe8UMvPiwHGI4GYrXTG4xDRsae1Lc+VBGuLRWte+W+vR
 hbuFfgpUVO+gdqDKXxCQoK18WfxUZqXA+E+ce8vFwFVSOl5DcEoXcJRK4Yv8e/6QRtZPF/TPDq6
 +/pBdHZ/PadNuvQrOSJ7WGxXtBIj6utpGOR57WOSL+zxg19wldYiMPJuNGkKwIKJP7ckmlsPJbi
 HTMvqjH4NKlFrM4f9I4lNjDRpksvdkYsaWqQGdisUiSRpPgC0/vEywkoD96cEcuh3LtSPUdAxai
 Hi4iSVJi+TSAbYpptfizTUO6a9pKSOKJ0lxGA=
X-Received: by 2002:a05:600c:1d16:b0:47a:8088:439c with SMTP id
 5b1f17b1804b1-48069c9ec08mr125812765e9.35.1769691208672; 
 Thu, 29 Jan 2026 04:53:28 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1522:e200:97e2:f9c5:ae8b:8e89])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1354114sm15442569f8f.42.2026.01.29.04.53.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Jan 2026 04:53:28 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/7] drm/amdgpu: lock both VM and BO in amdgpu_gem_object_open
Date: Thu, 29 Jan 2026 13:53:21 +0100
Message-ID: <20260129125327.11786-1-christian.koenig@amd.com>
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

The VM was not locked in the past since we initially only cleared the
linked list element and not added it to any VM state.

But this has changed quite some time ago, we just never realized this
problem because the VM state lock was masking it.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  | 19 +++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 22 ++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       | 10 +++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  2 ++
 4 files changed, 42 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 768998c82b43..ec5130497743 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -878,6 +878,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 	struct amdgpu_bo *bo[2] = {NULL, NULL};
 	struct amdgpu_bo_va *bo_va;
 	bool same_hive = false;
+	struct drm_exec exec;
 	int i, ret;
 
 	if (!va) {
@@ -958,19 +959,25 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 			goto unwind;
 		}
 
-		/* Add BO to VM internal data structures */
-		ret = amdgpu_bo_reserve(bo[i], false);
-		if (ret) {
-			pr_debug("Unable to reserve BO during memory attach");
-			goto unwind;
+		drm_exec_init(&exec, DRM_EXEC_INTERRUPTIBLE_WAIT, 0);
+		drm_exec_until_all_locked(&exec) {
+			ret = amdgpu_vm_lock_pd(vm, &exec, 0);
+			drm_exec_retry_on_contention(&exec);
+			if (unlikely(ret))
+				goto unwind;
+			ret = drm_exec_lock_obj(&exec, &bo[i]->tbo.base);
+			drm_exec_retry_on_contention(&exec);
+			if (unlikely(ret))
+				goto unwind;
 		}
+
 		bo_va = amdgpu_vm_bo_find(vm, bo[i]);
 		if (!bo_va)
 			bo_va = amdgpu_vm_bo_add(adev, vm, bo[i]);
 		else
 			++bo_va->ref_count;
 		attachment[i]->bo_va = bo_va;
-		amdgpu_bo_unreserve(bo[i]);
+		drm_exec_fini(&exec);
 		if (unlikely(!attachment[i]->bo_va)) {
 			ret = -ENOMEM;
 			pr_err("Failed to add BO object to VM. ret == %d\n",
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 5f9fa2140f09..5c90de58cc28 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -232,6 +232,7 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo_va *bo_va;
 	struct mm_struct *mm;
+	struct drm_exec exec;
 	int r;
 
 	mm = amdgpu_ttm_tt_get_usermm(abo->tbo.ttm);
@@ -242,9 +243,18 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 	    !amdgpu_vm_is_bo_always_valid(vm, abo))
 		return -EPERM;
 
-	r = amdgpu_bo_reserve(abo, false);
-	if (r)
-		return r;
+	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
+	drm_exec_until_all_locked(&exec) {
+		r = drm_exec_prepare_obj(&exec, &abo->tbo.base, 1);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(r))
+			goto out_unlock;
+
+		r = amdgpu_vm_lock_pd(vm, &exec, 0);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(r))
+			goto out_unlock;
+	}
 
 	amdgpu_vm_bo_update_shared(abo);
 	bo_va = amdgpu_vm_bo_find(vm, abo);
@@ -260,8 +270,7 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 		amdgpu_bo_unreserve(abo);
 		return r;
 	}
-
-	amdgpu_bo_unreserve(abo);
+	drm_exec_fini(&exec);
 
 	/* Validate and add eviction fence to DMABuf imports with dynamic
 	 * attachment in compute VMs. Re-validation will be done by
@@ -294,7 +303,10 @@ static int amdgpu_gem_object_open(struct drm_gem_object *obj,
 		}
 	}
 	mutex_unlock(&vm->process_info->lock);
+	return r;
 
+out_unlock:
+	drm_exec_fini(&exec);
 	return r;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 1878e0faa722..f69332eed051 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1445,6 +1445,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_fpriv *fpriv;
+	struct drm_exec exec;
 	int r, pasid;
 
 	/* Ensure IB tests are run on ring */
@@ -1484,7 +1485,16 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	if (r)
 		goto error_pasid;
 
+	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 0);
+	drm_exec_until_all_locked(&exec) {
+		r = amdgpu_vm_lock_pd(&fpriv->vm, &exec, 0);
+		drm_exec_retry_on_contention(&exec);
+		if (unlikely(r))
+			goto error_vm;
+	}
+
 	fpriv->prt_va = amdgpu_vm_bo_add(adev, &fpriv->vm, NULL);
+	drm_exec_fini(&exec);
 	if (!fpriv->prt_va) {
 		r = -ENOMEM;
 		goto error_vm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6a2ea200d90c..b4bf1b7c214f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1735,6 +1735,8 @@ struct amdgpu_bo_va *amdgpu_vm_bo_add(struct amdgpu_device *adev,
 {
 	struct amdgpu_bo_va *bo_va;
 
+	amdgpu_vm_assert_locked(vm);
+
 	bo_va = kzalloc(sizeof(struct amdgpu_bo_va), GFP_KERNEL);
 	if (bo_va == NULL) {
 		return NULL;
-- 
2.43.0


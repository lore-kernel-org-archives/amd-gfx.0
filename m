Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB016E7315F
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Feb 2026 12:51:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51F1C10E4B6;
	Mon,  2 Feb 2026 12:51:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CblnlIhV";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 813DF10E4A8
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Feb 2026 12:51:52 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-47ee937ecf2so37420865e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 02 Feb 2026 04:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770036711; x=1770641511; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=3RRcv5YwOfpvMNimk2KgSoLACazizL3JniAldJ7HA4A=;
 b=CblnlIhVOfGOfhrSWhNKufN7K6oo6lOuYhkWskJZe9b2f8pQCW5sub8J/+OqxjINx1
 RGijb+Ntj1ODZTjT802qbsgz0+LU/gIVQEiQP4EW6vbLIeP7Ql0TDqFk8rJG1zQn5CAs
 1ofojy7Pb3/vOkmK0T9s9WwR1Pp5rWCPgHsSidH/edmcn/GtEaeZqKc1a8HN78MdkZ2X
 yG+l54e/2Eqw2wlOC8W46dq8YvQ7QEcq28J1VATO8UpquTjKNWhpgqeIx3I++90LWKog
 AlGHWJk+pkl09ofNBFgC2GNBwj5GmSYrWK8MmGWxZTYKX4OLTbSOspcAs43QTA7URAM1
 XBKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770036711; x=1770641511;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3RRcv5YwOfpvMNimk2KgSoLACazizL3JniAldJ7HA4A=;
 b=AZk08+bcP4HoYIUiGyRk+M4Zy0K9g1PvFbRCCx5fvby+SZRpN2tbhEJJga/I+1R0HA
 fjDWKHrvWd0OdtfdMvIdqjf80/ViUJBkeuaO7QNlO7JKQe7rK8UQE2kbUqlsTciSE1fY
 bjmwTNDESB7KntQO0ncsVWBJ51JRe/Nwx7EgxrLMkRdZ4Y0uL+E/zjs7QyYfQFk0vLUI
 +JYupD6FG/scQEkVb6MKaj29Rg602HIB2D3tyllhBO3BLG1CS90WQnTH4dDJE42bDv1k
 86EMdn/jLY5AawgJieD8w6T3J3pM3moTyfcBp2IbqcvV5Oyn2UusWM8thNgmDzHzf6zh
 rhaw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUcL26PJIqS6W7sYSRKzOag04NctDHDyopxxY1k9yUkeMIZsG+11oJs+elGd7OYN609x9RRBaOK@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLZIJb+os+Q5Pt9s/gyo/wiryVTIq0DSUyns5YEjTFBFc7e1ab
 Yg+yfaOAyyUsnV6BCb/dxaq1jAPU19IsGtab4uP+RleS971NZtef4bnE
X-Gm-Gg: AZuq6aIlY84Ydt4dTBdWs+JztpxwDh/CGRdQ3X7s0Ygfnuvj5YJv62Mi93tjh6+FmvI
 AzOQ6+ZzecxrYqK2kaNdEKXAh0hOSN84T9FYX+i0yo8NRFyg85nqOJ5h1aPVTa0qoyJ/73zz3Cj
 nkzEJNYHeMKxjNHSlSfQUro0LI3duM5Kd2CYJ7xNUZd2Uz+CiBSsWl/31Ce1phDid30XmWmT0kB
 APLNYTPFtusYzxpKbSvkCGfmC32gvd7+MuGVD3jRn9+bXdCMtYfHGpfV3QpMMezvyXaCpn4hVYO
 xf3lMW6Fh/QHo9hqfZgGs+RwBMBZMhi/r6CRFoQAH3XxUXGDWmF0SkM4qy/jc5miYi8OLClVHuI
 K4T7DJxLWV64kXTt/l5TnxBTS3jVBS4X+jzwz0O1HjkLRcxQps58VHVQYZk0foSj1ebJ82Snfum
 O0sJIdy3EeWg67TDP2pGbzdgY=
X-Received: by 2002:a05:600c:559a:b0:477:9a61:fd06 with SMTP id
 5b1f17b1804b1-4808289208cmr149535855e9.8.1770036710753; 
 Mon, 02 Feb 2026 04:51:50 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1570:8200:7824:9bef:268:2d37])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-482da6a042csm126165535e9.0.2026.02.02.04.51.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 04:51:50 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: tursulin@ursulin.net, Alexander.Deucher@amd.com, Prike.Liang@amd.com,
 Yogesh.Mohanmarimuthu@amd.com, SRINIVASAN.SHANMUGAM@amd.com,
 Sunil.Khatri@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/9] drm/amdgpu: lock both VM and BO in amdgpu_gem_object_open
Date: Mon,  2 Feb 2026 13:51:41 +0100
Message-ID: <20260202125149.2067-1-christian.koenig@amd.com>
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


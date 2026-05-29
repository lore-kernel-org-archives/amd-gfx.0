Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57075CD6E4C
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 06:48:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E6D910F995;
	Fri, 29 May 2026 06:48:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FeaR2+Lp";
	dkim-atps=neutral
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
 [209.85.167.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C770610F993
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 06:48:22 +0000 (UTC)
Received: by mail-lf1-f42.google.com with SMTP id
 2adb3069b0e04-5a8cb92f26aso14779218e87.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 May 2026 23:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780037301; x=1780642101; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+aMMV5ilmpFv8Pwd8WuxApxlzDJGWTTKgJEHknglssE=;
 b=FeaR2+LpaxrUCHwh9Tvv4S5HASAKoB0/tMfMCPTvboqkk/hRSqbTgi0erjI3j7NROI
 U8hoArvt64vBkgbxT7rgEeIoHzF+Tphiz8HpWYX/v4ZKEaYY0bcig8pxWQ5CWkSZ1MOd
 /FM2MkgKA+LY5lkUSnqdqeielzr5ZKqxmSQL3+k8z3RJRSDmteGQ5kpzbQh17nDJe5lE
 uo3EsN4rpQFH+xQd/kZ47NqNBy8FjzlkD5cofbcveExPB8HSQsG0Z8A8ZmuD7jf8vq3C
 Ggs2/3N4kjQ8q1wE+3xOxd5s0q4RiMfJYVrZl9WEXrtpKDqC2nIkRDbVSk0lxejnLoHt
 Y7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780037301; x=1780642101;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+aMMV5ilmpFv8Pwd8WuxApxlzDJGWTTKgJEHknglssE=;
 b=PlpE+vIj00XmXWAvtn6wjJq7VuCWGSi+fOVXXdxahxLaMhrS9VA13Ukn4MffVnLFBl
 wmKdMpbBUqz/Tj+IDwY8bPWPZAFjoRFOnYa7tQwrHbf3luQhn+SZ1v9LIAi0pySF5KlY
 mhpaYpKjan0kMVkABhNnyFJaKJKse28iF1I/rhHVetQBJQSY714V+q4G4Fq2LT1D6DzV
 aZVmqf6D2w9aBLY5WrvWFsMqKx0p9dlzXVDTU41JVWrxnK8pVltMf8YAsi0IHAHJIZnj
 URUEnFbxZJzeyJbApiDWYa4TsAUPHfKZzrz7lFVE1qpb8+VeGppI08YDhFxCC9Y2y9zT
 4EGQ==
X-Gm-Message-State: AOJu0YwVSO73ZB6SVNLVPNVj4V/2NWDCnaDDOeu27cZi3UntK2t8lg+u
 YkBixSExHUlv7uu02tDu7IJYW1QszyyiR6eqjwI64REc2ckMTyfz6ly8IXH0fs//Jhgpf4tW
X-Gm-Gg: Acq92OFZx+2JFxSr3u4k9RSMc2U3OSUQ2ihyyOonfN5NT1rtWcwDxLyQGSoJ5Ru8iWV
 cKupZd/6DXyx04MUuKBiLaLw6vAW8tKb++M3m+94zj9cC4AJnSmXoXGIMxaSy0WYYWUT6FnZl5s
 LDNgOec6IJcFC7g0T2V5mXZkagK2XvPbEXfakZpIqs5BN+HsFhdM9kSTso1IIj6ZEKzB5PiK8gF
 AHNAb3H/mh7jrlGEFhlstMolM+B6elmGz7FEEm008wgAr6CHPoWZOp/YuoMvo2SN2Qd9pCHShRD
 EpOkBlMj2gwX+I44FOHZjRZpOJW4WO6VKDZeDtCEQF1vkgJc5UkKG1dw/0UNwyD3KnaSObCHKV8
 ZaWjya7ZME4lbLiOoc/YTtE2UVQGWyaHa9FLzQtS6LAoc+UbmnIqHIcWBU7bOOR6ObFE6FonpEO
 LJwvpiFhP2imh7WBqxTBUehEqcrLj84BwLEwh4lZp6/EI=
X-Received: by 2002:a05:6512:230c:b0:5a8:f6fd:eb15 with SMTP id
 2adb3069b0e04-5aa594a7f4cmr457133e87.24.1780037300718; 
 Thu, 28 May 2026 23:48:20 -0700 (PDT)
Received: from localhost ([188.234.148.119]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5aa5b79f04dsm72147e87.83.2026.05.28.23.48.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 23:48:20 -0700 (PDT)
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org,
 Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Subject: [PATCH v6 1/2] drm/amdgpu: convert amdgpu_vm_lock_by_pasid() to
 drm_exec
Date: Fri, 29 May 2026 11:47:38 +0500
Message-ID: <20260529064740.25060-2-mikhail.v.gavrilov@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529064740.25060-1-mikhail.v.gavrilov@gmail.com>
References: <20260521150841.20625-1-mikhail.v.gavrilov@gmail.com>
 <20260529064740.25060-1-mikhail.v.gavrilov@gmail.com>
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

amdgpu_vm_lock_by_pasid() looks up a VM by PASID and reserves its root
PD with a bare amdgpu_bo_reserve(), returning the still-reserved root to
the caller. A caller that then needs to reserve further BOs (for example
the devcoredump IB dump) ends up nesting reservation_ww_class_mutex
acquires without a ww_acquire_ctx, which lockdep flags as recursive
locking.

Convert the helper to take a drm_exec context and lock the root PD with
drm_exec_lock_obj(). Callers now run it inside a
drm_exec_until_all_locked() loop and can lock additional BOs in the same
ww ticket, so there is no nested ww_mutex acquire.

The drm_exec context holds its own reference on the locked root BO, so
the helper no longer hands a root reference back to the caller: the
root output parameter is dropped, and the transient reference taken
across the PASID lookup is released before returning.

The only existing caller, amdgpu_vm_handle_fault(), is updated
accordingly. Its is_compute_context path, which previously dropped the
root reservation around svm_range_restore_pages() and re-took it, now
finalises the drm_exec context and re-initialises a fresh one; behaviour
is otherwise unchanged.

No functional change intended for the page-fault path.

Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 91 ++++++++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  2 +-
 2 files changed, 58 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index fccd758b6699..b9d93b664daf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2950,47 +2950,56 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 }
 
 /**
- * amdgpu_vm_lock_by_pasid - return an amdgpu_vm and its root bo from a pasid, if possible.
+ * amdgpu_vm_lock_by_pasid - look up a VM by PASID and lock its root PD
  * @adev: amdgpu device pointer
- * @root: root BO of the VM
  * @pasid: PASID of the VM
- * The caller needs to unreserve and unref the root bo on success.
+ * @exec: drm_exec context to lock the root PD in
+ *
+ * Must be called from within a drm_exec_until_all_locked() loop; the caller
+ * runs drm_exec_retry_on_contention() afterwards. The drm_exec context holds
+ * a reference on the root BO until it is finalised.
+ *
+ * Return: the VM on success, or NULL if the PASID has no VM, the VM is being
+ * torn down, or locking the root PD failed.
  */
 struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
-					  struct amdgpu_bo **root, u32 pasid)
+					  u32 pasid, struct drm_exec *exec)
 {
 	unsigned long irqflags;
+	struct amdgpu_bo *root;
 	struct amdgpu_vm *vm;
 	int r;
 
 	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
 	vm = xa_load(&adev->vm_manager.pasids, pasid);
-	*root = vm ? amdgpu_bo_ref(vm->root.bo) : NULL;
+	root = vm ? amdgpu_bo_ref(vm->root.bo) : NULL;
 	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
 
-	if (!*root)
+	if (!root)
 		return NULL;
 
-	r = amdgpu_bo_reserve(*root, true);
-	if (r)
-		goto error_unref;
+	r = drm_exec_lock_obj(exec, &root->tbo.base);
+	if (r) {
+		amdgpu_bo_unref(&root);
+		return NULL;
+	}
 
 	/* Double check that the VM still exists */
 	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
 	vm = xa_load(&adev->vm_manager.pasids, pasid);
-	if (vm && vm->root.bo != *root)
+	if (vm && vm->root.bo != root)
 		vm = NULL;
 	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
-	if (!vm)
-		goto error_unlock;
+	if (!vm) {
+		drm_exec_unlock_obj(exec, &root->tbo.base);
+		amdgpu_bo_unref(&root);
+		return NULL;
+	}
 
-	return vm;
-error_unlock:
-	amdgpu_bo_unreserve(*root);
+	/* The drm_exec context holds its own reference on the root BO. */
+	amdgpu_bo_unref(&root);
 
-error_unref:
-	amdgpu_bo_unref(root);
-	return NULL;
+	return vm;
 }
 
 /**
@@ -3012,33 +3021,49 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    uint64_t ts, bool write_fault)
 {
 	bool is_compute_context = false;
-	struct amdgpu_bo *root;
+	struct drm_exec exec;
 	uint64_t value, flags;
 	struct amdgpu_vm *vm;
 	int r;
 
-	vm = amdgpu_vm_lock_by_pasid(adev, &root, pasid);
-	if (!vm)
+	drm_exec_init(&exec, 0, 1);
+	drm_exec_until_all_locked(&exec) {
+		vm = amdgpu_vm_lock_by_pasid(adev, pasid, &exec);
+		drm_exec_retry_on_contention(&exec);
+		if (!vm)
+			break;
+	}
+	if (!vm) {
+		drm_exec_fini(&exec);
 		return false;
+	}
 
 	is_compute_context = vm->is_compute_context;
 
 	if (is_compute_context) {
-		/* Unreserve root since svm_range_restore_pages might try to reserve it. */
-		/* TODO: rework svm_range_restore_pages so that this isn't necessary. */
-		amdgpu_bo_unreserve(root);
+		/* Release the root PD lock since svm_range_restore_pages
+		 * might try to take it.
+		 * TODO: rework svm_range_restore_pages so that this isn't
+		 * necessary.
+		 */
+		drm_exec_fini(&exec);
 
 		if (!svm_range_restore_pages(adev, pasid, vmid,
-					     node_id, addr >> PAGE_SHIFT, ts, write_fault)) {
-			amdgpu_bo_unref(&root);
+					     node_id, addr >> PAGE_SHIFT, ts, write_fault))
 			return true;
-		}
-		amdgpu_bo_unref(&root);
 
 		/* Re-acquire the VM lock, could be that the VM was freed in between. */
-		vm = amdgpu_vm_lock_by_pasid(adev, &root, pasid);
-		if (!vm)
+		drm_exec_init(&exec, 0, 1);
+		drm_exec_until_all_locked(&exec) {
+			vm = amdgpu_vm_lock_by_pasid(adev, pasid, &exec);
+			drm_exec_retry_on_contention(&exec);
+			if (!vm)
+				break;
+		}
+		if (!vm) {
+			drm_exec_fini(&exec);
 			return false;
+		}
 	}
 
 	addr /= AMDGPU_GPU_PAGE_SIZE;
@@ -3062,7 +3087,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		value = 0;
 	}
 
-	r = dma_resv_reserve_fences(root->tbo.base.resv, 1);
+	r = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 1);
 	if (r) {
 		pr_debug("failed %d to reserve fence slot\n", r);
 		goto error_unlock;
@@ -3076,12 +3101,10 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	r = amdgpu_vm_update_pdes(adev, vm, true);
 
 error_unlock:
-	amdgpu_bo_unreserve(root);
+	drm_exec_fini(&exec);
 	if (r < 0)
 		dev_err(adev->dev, "Can't handle page fault (%d)\n", r);
 
-	amdgpu_bo_unref(&root);
-
 	return false;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index d083d7aab75c..0c6e3e0368c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -593,7 +593,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    bool write_fault);
 
 struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
-					  struct amdgpu_bo **root, u32 pasid);
+					  u32 pasid, struct drm_exec *exec);
 
 void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
 
-- 
2.54.0


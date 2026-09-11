Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFFB5C88E4D
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Sep 2026 16:48:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AD0110E40E;
	Fri, 11 Sep 2026 16:48:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kdhlx9cm";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EB7310E40E
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 16:48:05 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49a97714f5dso10368995e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Sep 2026 09:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789145284; x=1789750084; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=FGAFC99tU1tLeMYh4cRyyVe6cjnBk6w6DTZY6CEoGtY=;
 b=kdhlx9cmfp7blhMVY0rTESrxyAhD3TC/PrOL/ncxKKOjA/CJFfrjYVq2OU7Np6EFNh
 Oz9tiPQg2TvptgKvPCcqlHs74fbEoianqqsWc5QsiFlvu60cgbuC6SzHC8tDXQPR+eyY
 3poPvjs4pXVa6SZ2BfaMAiXJ/m+TAtBFoBPHdbnSppXTq1weE5Fiu2Vw1Z6xfMW4geA2
 HwPIpxcrLqwTSjdvPKAgE+h+v3jZjYDAqRwYov2T1jEEV92nPijco6LCtFtx87J2kfjq
 JqpeuEyEyR1uP9fc5dXkncovDhhjrzXVlhED4exC0XqiVylO3/d5J2kq9BAvzbKzMjCw
 H93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789145284; x=1789750084;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=FGAFC99tU1tLeMYh4cRyyVe6cjnBk6w6DTZY6CEoGtY=;
 b=owLGenQUSLQYaP0uSnCd0mVXQNTlTIpDrh4UtgpmiHQhG7aD5jUtO85OWe35hcOnSE
 Yb14oDY2dG9O8845/UHTOQsgy57q2XahQahzgXZaHRo0ZbLHWBlrVc7SpbZLML1f87Gf
 OrdC63Ejd7EM4n4+ZdpUnlA0sdRDJ0tnUhkQOBF5+ObUFUjdJTnAqYyQk2b/9ornT8BX
 GyfduLCxxTHRyRAXicaWNx1iDxa88H6rXt7/s6XABY4PRuyUITKCx51M71+PfLG2kp5E
 cLCL05orNx0XvN1O6j8huZgWg54/GKM8vRH0GBpLYmD2Wq/eiOC/xpfNjUT4xJeIAiKz
 LFSg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzgVRCW3xQYw/q62347UwBhN8gAqIfaGwt8ZYWVu5IKuZQnsymiVqfeNQPpMTAB1g1GJg82Ughd@lists.freedesktop.org
X-Gm-Message-State: AFuF++mUlR6oUMAaTMttoUIvmfKPQarbYXFvrKeNDyKOriGJ+rDJFJjS
 H1xIVpmhYdhyrpkP/Y0ANvzV4cV8JPYso7OMsX783Hhc/jY85bVc3rEP
X-Gm-Gg: AYBFou10GUkB3Nc7OgJkBCZxJlzMSyk/HxyD8cXhKIYekFOJl5kLYuORIKJTaK02JzU
 tnNwrndXgpLo2SN1BAGTPNi4L7Ad9pR48i7W3SbHcJKA0uGJoSRqqb8oX7FQARjCDKbMA2qEK4L
 Jk2nfyNCk8lDIJzr4t7jil9RZ2z58bFgtEyymsj+VcUOixQEIYw9wD80mWEp5+sBbVgBFSPJ2Si
 G9kIL5tlF9x/5ZFlNSAjgVEfR4xeqWmFIvr4+JNZF/JE8WQf2Vcjp6xAzmpNRv2uWbu7ncbldKS
 FLy/3lrS4nLRvnyA3uMpnebZ5OGzOaOj4lA8m5CuWIxElhoTM39wlMDZeLVibuLCUHZ+QtudKRL
 9hzZCV8p8cc9hRPDsAKSGpzSWw0g0EjSCeDLdr/BL4+5GB44JEaRgmfzosXzpulhMJp4oyJz+l3
 QnOcuLDGSiWLVsP/YAxWcYOYbb7eqbFHukB8hn7BVBKup5XGmygaZXhaObSE1LbGmaNCM86ggSb
 kNcEgo531C4
X-Received: by 2002:a05:600c:c16b:b0:49e:69f8:e846 with SMTP id
 5b1f17b1804b1-49e69f8e888mr16749665e9.9.1789145283462; 
 Fri, 11 Sep 2026 09:48:03 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1598:3600:fdfa:c947:bca7:ed36])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-486f0403125sm4927578f8f.8.2026.09.11.09.48.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 09:48:03 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Honglei1.Huang@amd.com, timur.kristof@gmail.com, natalie.vock@gmx.de,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: rework eviction lock handling into critical
 section v2
Date: Fri, 11 Sep 2026 18:48:01 +0200
Message-ID: <20260911164801.50175-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911164801.50175-1-christian.koenig@amd.com>
References: <20260911164801.50175-1-christian.koenig@amd.com>
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
Reply-To: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Taking the eviction lock is actually just one step which we need to do
in the critical section handling.

Rename the functions to reflect that, use the update parameters instead of the
vm to save the GFP flags.

v2: rebased and reordered

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 21 +++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  1 -
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   | 41 ++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 35 ++++++++--------
 4 files changed, 63 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 7ced26c9c651b..67dc7da1a02fa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1169,11 +1169,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.override_pte = allow_override && adev->gmc.override_pte;
 	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
 
-	amdgpu_vm_eviction_lock(vm);
-	if (vm->evicting) {
-		r = -EBUSY;
+	r = amdgpu_vm_begin_critical(&params);
+	if (r)
 		goto error_free;
-	}
 
 	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
 		struct dma_fence *tmp = dma_fence_get_stub();
@@ -1257,7 +1255,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 error_free:
 	kfree(tlb_cb);
-	amdgpu_vm_eviction_unlock(vm);
+	amdgpu_vm_end_critical(&params);
 	drm_dev_exit(idx);
 	return r;
 }
@@ -3044,6 +3042,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    u32 vmid, u32 node_id, uint64_t addr,
 			    uint64_t ts, bool write_fault)
 {
+	struct amdgpu_vm_update_params params;
 	bool is_compute_context = false;
 	struct drm_exec exec;
 	uint64_t value, flags;
@@ -3117,6 +3116,15 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		goto error_unlock;
 	}
 
+	memset(&params, 0, sizeof(params));
+	params.adev = adev;
+	params.vm = vm;
+	params.immediate = true;
+
+	r = amdgpu_vm_begin_critical(&params);
+	if (r)
+		goto error_end_critical;
+
 	r = amdgpu_vm_update_range(adev, vm, true, false, false, false,
 				   NULL, addr, addr, flags, value, 0, NULL, NULL, NULL);
 	if (r)
@@ -3124,6 +3132,9 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 
 	r = amdgpu_vm_update_pdes(adev, vm, true);
 
+error_end_critical:
+	amdgpu_vm_end_critical(&params);
+
 error_unlock:
 	drm_exec_fini(&exec);
 	if (r < 0)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 0f6634b749746..98cdd7e3475fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -289,7 +289,6 @@ struct amdgpu_vm {
 	 */
 	struct mutex		eviction_lock;
 	bool			evicting;
-	unsigned int		saved_flags;
 
 	/* Memory statistics for this vm, protected by stats_lock */
 	spinlock_t		stats_lock;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
index ca86eaac75235..77f3942d9533b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -93,6 +93,11 @@ struct amdgpu_vm_update_params {
 	 */
 	bool override_pte;
 
+	/**
+	 * @saved_flags: Saved flags for GFP reduction.
+	 */
+	unsigned int saved_flags;
+
 	/**
 	 * @tlb_flush_waitlist: temporary storage for BOs until tlb_flush
 	 */
@@ -126,21 +131,37 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
 			    struct amdgpu_vm_update_params *params);
 int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm *vm);
 
-/*
- * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
- * happens while holding this lock anywhere to prevent deadlocks when
- * an MMU notifier runs in reclaim-FS context.
+/**
+ * amdgpu_vm_begin_critical - start the critical section of the update
+ * @p: The update parameters
+ *
+ * Serialize all updates, check parameters and make sure that memory allocations
+ * don't enter the reclaim path so that we don't deadlock with MMU notifiers.
+ *
+ * Returns:
+ *
+ * 0 on success or a negative error code on failure.
+ * Even on error amdgpu_vm_end_critical() must still be called to clean up!
  */
-static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
+static inline int amdgpu_vm_begin_critical(struct amdgpu_vm_update_params *p)
 {
-	mutex_lock(&vm->eviction_lock);
-	vm->saved_flags = memalloc_noreclaim_save();
+	mutex_lock(&p->vm->eviction_lock);
+	p->saved_flags = memalloc_noreclaim_save();
+	if (p->vm->evicting)
+		return -EBUSY;
+	return 0;
 }
 
-static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
+/**
+ * amdgpu_vm_end_critical - end the critical section of the update
+ * @p: The update parameters
+ *
+ * Restore the GFP flags and drop the lock.
+ */
+static inline void amdgpu_vm_end_critical(struct amdgpu_vm_update_params *p)
 {
-	memalloc_noreclaim_restore(vm->saved_flags);
-	mutex_unlock(&vm->eviction_lock);
+	memalloc_noreclaim_restore(p->saved_flags);
+	mutex_unlock(&p->vm->eviction_lock);
 }
 
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 1cdf2b854f261..3f78202a60585 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -505,51 +505,49 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 /**
  * amdgpu_vm_pt_alloc - Allocate a specific page table
  *
- * @adev: amdgpu_device pointer
- * @vm: VM to allocate page tables for
+ * @p: see amdgpu_vm_update_params definition
  * @cursor: Which page table to allocate
- * @immediate: use an immediate update
  *
  * Make sure a specific page table or directory is allocated.
  *
  * Returns:
- * 1 if page table needed to be allocated, 0 if page table was already
- * allocated, negative errno if an error occurred.
+ *
+ * 0 on success or a negative error code on failure.
  */
-static int amdgpu_vm_pt_alloc(struct amdgpu_device *adev,
-			      struct amdgpu_vm *vm,
-			      struct amdgpu_vm_pt_cursor *cursor,
-			      bool immediate)
+static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
+			      struct amdgpu_vm_pt_cursor *cursor)
 {
 	struct amdgpu_vm_bo_base *entry = cursor->entry;
 	struct amdgpu_bo *pt_bo;
 	struct amdgpu_bo_vm *pt;
-	int r;
+	int r, r2;
 
 	if (entry->bo)
 		return 0;
 
-	amdgpu_vm_eviction_unlock(vm);
-	r = amdgpu_vm_pt_create(adev, vm, cursor->level, immediate, &pt,
-				vm->root.bo->xcp_id);
-	amdgpu_vm_eviction_lock(vm);
+	amdgpu_vm_end_critical(p);
+	r = amdgpu_vm_pt_create(p->adev, p->vm, cursor->level, p->immediate,
+				&pt, p->vm->root.bo->xcp_id);
+	r2 = amdgpu_vm_begin_critical(p);
 	if (r)
 		return r;
+	if (r2)
+		return r2;
 
 	/* Keep a reference to the root directory to avoid
 	 * freeing them up in the wrong order.
 	 */
 	pt_bo = &pt->bo;
 	pt_bo->parent = amdgpu_bo_ref(cursor->parent->bo);
-	amdgpu_vm_bo_base_init(entry, vm, pt_bo);
-	r = amdgpu_vm_pt_clear(adev, vm, pt, immediate);
+	amdgpu_vm_bo_base_init(entry, p->vm, pt_bo);
+	r = amdgpu_vm_pt_clear(p->adev, p->vm, pt, p->immediate);
 	if (r)
 		goto error_free_pt;
 
 	return 0;
 
 error_free_pt:
-	if (vm->is_npa)
+	if (p->vm->is_npa)
 		amdgpu_bo_unpin(pt_bo);
 	amdgpu_bo_unref(&pt_bo);
 	return r;
@@ -838,8 +836,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 			/* make sure that the page tables covering the
 			 * address range are actually allocated
 			 */
-			r = amdgpu_vm_pt_alloc(params->adev, params->vm,
-					       &cursor, params->immediate);
+			r = amdgpu_vm_pt_alloc(params, &cursor);
 			if (r)
 				return r;
 		}
-- 
2.43.0


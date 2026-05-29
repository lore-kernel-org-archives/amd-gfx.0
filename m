Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 689CFCD6E43
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 11:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF37410FDD3;
	Fri, 29 May 2026 11:40:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AyIiy0hh";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83D9110FDD3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 11:40:47 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-43eb05b1875so7228644f8f.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 04:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780054846; x=1780659646; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GxQTN1BukcJ8O4VHpG6rqsw7ATFjkSoIQdmZO03Qe/0=;
 b=AyIiy0hhZsOOgAqLe04NXsH5IwW2HS9kwKdqtr6+9/TL9EJuVVGsL6LpLa+GtvMfSS
 tZ4b7671P1fbrXd3EqjD35AMGevRC6I4XVjJ8z+JGBqUA+NM5DmJvjt1LhrcICHUQD+g
 /Q1xKFu2aMl6eQSnYoqs44I3AxmUhhNYbWUPLY6NGsxphEiz/cli13pZZCV3lHR5iDpX
 Q1fWBwk3sV+nSjyRIBNLHbwKG3UMtbqhJHwatPtdew8z9GTaJRNpEByIEwnlxRKrGMLf
 mP/KDRo498bfkSDdyF+wp+RzA++iORC0nWIxsvahrqiLfdxb1Fmyv7IZ8ioIiHizh5r2
 4ZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780054846; x=1780659646;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GxQTN1BukcJ8O4VHpG6rqsw7ATFjkSoIQdmZO03Qe/0=;
 b=PgZ4OXntj/PTVSQ69zcD5WI82BERQiG6vTjsws7VEZoByY3DtLONUkW+JDIPdvCZNP
 Zc2+XXQXBLOuZt1HpfeD4ZNkduL5p7Wsr4VJO0SMvxVhq6up2I1qW3C0b7tyUOwoiXx+
 H3Ok/gjLYzFJg0wJk5H2SCLO0epa610FdbKpa4sWzwZ9UY92YvgZANceBvV/u8uNZw7J
 t2QiHw+J+9RT+7RuzsEWhCpjWv4vBOW18yffzLbf8i0QxvkPskf3Vthg6zYxSPq0HWME
 m46We2eebSCKxI2O32GJpktEsVbFztsARvtlBhdBhMcWpVjxxVH8h5i1OuUNIsJstMlQ
 AXtA==
X-Gm-Message-State: AOJu0YwLBNTSq29RpGVnVYlGkKoZtYL+i7klv0h1RZC74uf2bOtEzQGB
 10zmFr6d2k/bUOqxBHQ2GXOrxRCl+lfGKXjBDudcut9LYgqurpm2KS3X
X-Gm-Gg: Acq92OFKdX0aRiDDhvyf6m1dF3LdMmcamKTQYBsw9LkT4/gj/EJo7g477pjGQK/NtBP
 QzFesK0oVGWXAy8eE530B4fFmgYzEWnJTqpYOn8WpdyAVS1Llnunb0H2AKLpHc/QmINDAFDuVai
 Cl2/w7h5ddJShMyo/h8NMuG8enheUcp+WbycdnOc0WkXWdnaQ9Rb8LpQy9Cwhl6U4rt+8sCJnaK
 IVPiMHlbkKkFewBpBFXOnT/gE9AGfkoqVJSIaxRJtWpmz82tQV7snEbczjS5+chx4HQ5bkmFo+M
 wqHggFW+++SBFacYakMz3QHrAXwVT8ZGvjE4PFUotTHk/AprCnDpQ17xmVqpPCb7AdK/U8Qo8K2
 j/QoV5nvEf5kOzi4qNIZvjsK7mg2cucPRs7oaF9JWyfU42r9nMDBC7e2nOAW6+hFs+/i+7AhV0P
 4gFZwIPv7GlvKRMx79pRYzfmxQflrL7QfAb1NNow5iwMY=
X-Received: by 2002:adf:e44c:0:b0:43d:6f0f:32fe with SMTP id
 ffacd0b85a97d-45ef146f78emr3193139f8f.31.1780054845941; 
 Fri, 29 May 2026 04:40:45 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1544:8100:da55:fa26:bd:a26])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cf0dsm2993109f8f.17.2026.05.29.04.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:40:45 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/13] drm/amdgpu: rework eviction lock handling into critical
 section
Date: Fri, 29 May 2026 13:24:14 +0200
Message-ID: <20260529114031.3714-13-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114031.3714-1-christian.koenig@amd.com>
References: <20260529114031.3714-1-christian.koenig@amd.com>
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

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 34 ++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  1 -
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   | 41 ++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 28 ++++++-------
 4 files changed, 58 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 3ac083c9f77e..d4e207db83c9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1143,11 +1143,9 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.override_pte = allow_override && adev->gmc.override_pte;
 	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
 
-	amdgpu_vm_eviction_lock(vm);
-	if (vm->evicting) {
-		r = -EBUSY;
+	r = amdgpu_vm_begin_critical(&params);
+	if (r)
 		goto error_free;
-	}
 
 	if (!dma_fence_is_signaled(vm->last_unlocked)) {
 		struct dma_fence *tmp = dma_fence_get_stub();
@@ -1229,7 +1227,7 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 error_free:
 	kfree(tlb_cb);
-	amdgpu_vm_eviction_unlock(vm);
+	amdgpu_vm_end_critical(&params);
 	drm_dev_exit(idx);
 	return r;
 }
@@ -1277,11 +1275,9 @@ int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.unlocked = true;
 	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
 
-	amdgpu_vm_eviction_lock(vm);
-	if (vm->evicting) {
-		r = -EBUSY;
+	r = amdgpu_vm_begin_critical(&params);
+	if (r)
 		goto error_free;
-	}
 
 	r = vm->update_funcs->prepare(&params, sync,
 				      AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE);
@@ -1300,7 +1296,7 @@ int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 error_free:
 	kfree(tlb_cb);
-	amdgpu_vm_eviction_unlock(vm);
+	amdgpu_vm_end_critical(&params);
 	drm_dev_exit(idx);
 	return r;
 }
@@ -3113,30 +3109,26 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		goto error_unlock;
 	}
 
-	amdgpu_vm_eviction_lock(vm);
-	if (vm->evicting) {
-		r = -EBUSY;
-		goto error_dev_exit;
-	}
-
 	memset(&params, 0, sizeof(params));
 	params.adev = adev;
 	params.vm = vm;
 	params.immediate = true;
 	params.pages_addr = NULL;
 
+	r = amdgpu_vm_begin_critical(&params);
+	if (r)
+		goto error_end_critical;
+
 	r = dma_resv_reserve_fences(root->tbo.base.resv, 1);
 	if (r) {
 		pr_debug("failed %d to reserve fence slot\n", r);
-		goto error_eviction_lock;
+		goto error_end_critical;
 	}
 
 	amdgpu_vm_update_leaves(&params, addr, addr, value, flags);
 
-error_eviction_lock:
-	amdgpu_vm_eviction_unlock(vm);
-
-error_dev_exit:
+error_end_critical:
+	amdgpu_vm_end_critical(&params);
 	drm_dev_exit(idx);
 
 error_unlock:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 21c78b18f4df..7db3c3577949 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -286,7 +286,6 @@ struct amdgpu_vm {
 	 */
 	struct mutex		eviction_lock;
 	bool			evicting;
-	unsigned int		saved_flags;
 
 	/* Memory statistics for this vm, protected by stats_lock */
 	spinlock_t		stats_lock;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
index 7276d987e9a6..29c74920f3b0 100644
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
@@ -130,21 +135,37 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
 
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
index 6026d6f27842..cf1697374416 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -478,42 +478,42 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 /**
  * amdgpu_vm_pt_alloc - Allocate a specific page table
  *
- * @adev: amdgpu_device pointer
- * @vm: VM to allocate page tables for
+ * @p: see amdgpu_vm_update_params definition
  * @cursor: Which page table to allocate
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
+static int amdgpu_vm_pt_alloc(struct amdgpu_vm_update_params *p,
 			      struct amdgpu_vm_pt_cursor *cursor)
 {
 	struct amdgpu_vm_bo_base *entry = cursor->entry;
 	struct amdgpu_bo *pt_bo;
 	struct amdgpu_bo_vm *pt;
-	int r;
+	int r, r2;
 
 	if (entry->bo)
 		return 0;
 
-	amdgpu_vm_eviction_unlock(vm);
-	r = amdgpu_vm_pt_create(adev, vm, cursor->level, &pt,
-				vm->root.bo->xcp_id);
-	amdgpu_vm_eviction_lock(vm);
+	amdgpu_vm_end_critical(p);
+	r = amdgpu_vm_pt_create(p->adev, p->vm, cursor->level, &pt,
+				p->vm->root.bo->xcp_id);
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
-	r = amdgpu_vm_pt_clear(adev, vm, pt);
+	amdgpu_vm_bo_base_init(entry, p->vm, pt_bo);
+	r = amdgpu_vm_pt_clear(p->adev, p->vm, pt);
 	if (r)
 		goto error_free_pt;
 
@@ -802,7 +802,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 		/* make sure that the page tables covering the
 		 * address range are actually allocated
 		 */
-		r = amdgpu_vm_pt_alloc(params->adev, params->vm, &cursor);
+		r = amdgpu_vm_pt_alloc(params, &cursor);
 		if (r)
 			return r;
 
-- 
2.43.0


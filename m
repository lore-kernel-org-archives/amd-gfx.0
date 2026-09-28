Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89FB9CA5FA5
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 15:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11AC010E3E8;
	Mon, 28 Sep 2026 15:10:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ms4F5mJd";
	dkim-atps=neutral
Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com
 [74.125.225.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7735F10E3E8
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 15:10:45 +0000 (UTC)
Received: by mail-wr2-f34.google.com with SMTP id
 ffacd0b85a97d-48884b0219bso1386989f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 08:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790608244; x=1791213044; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1b+J2wTA/NlUTKCKyplsYEzkGi5ZLrqHxgLKYxKpI7Y=;
 b=ms4F5mJdkDBmK3YC+hCd5uiBnJG2FY8InI4hv/xveeaaGbkti5sMYr8tszxd7qelSi
 QJIL1KeTlWyRH5Vw5ePBZQOzg0wQPxengcxEuBiAcN4+/kAEpy3pWJfVR1LxwjrcRPFd
 xeJ2x0AxdtOeUVkcHov/43+0TD/3V2Wy5Iy0Lj2dJR53OCZ/pn+08t4kYr4UmHFCBcji
 iuyGBLv0DxeGF8D1icHXiQgt9m/tDI2eTsAhsxBLpk6XIPno95+4TtsOlJrFJwsri2Xl
 Tstl0S28iWNwPDpPJbVu0NAo3S8mu8Q8kb7d7LMn42rLM0LA4I9RiDC/xTSfSfwCE/BQ
 Tbzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608244; x=1791213044;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1b+J2wTA/NlUTKCKyplsYEzkGi5ZLrqHxgLKYxKpI7Y=;
 b=wYfadQ4ELwQnbjFBDKSDnZpMpsTdckRIqLz5462PtWtt3bF0vNm+0R9qzGBB2iWPYj
 s7mW7liAh3dhs+keYFJ6USl/GvJ7OELGgWP2t0B7Lq/SRbCcjvaIYM3xYOFznXtlJ4TH
 xSISruQ34VFQozv2NLQX1CnTFlQNZotx8j2FwP6O3MaHYJDDp61tz+wrH7Obkm4c7R0n
 V1sSzQUJhMK3p6vzJTng5ynk0CUf2lZFvcuNopHEckOFA1KoBWLT1Q/ivC6/w4LgW0AA
 tbCfTnJdXpdkWNyI7EUzUiobybeDWkPvRko59aH+WEfm3S1CQPI4d5eDhrUtKXNW5F+k
 nNFQ==
X-Gm-Message-State: AFq9FYKAS3BuObbZfSPo6oky8PbL4ix9mMVQKsySgeS+Vl9x+v24GmzM
 nNMWHmKKgxkJFywzriggh4DSeM0bnMWe3tOU8P6+id8GGCZS6wPsUvPH
X-Gm-Gg: AYBFou10kn3olSYOteKWmkBBUFOgYVBtsxOqHgXKaSHifvjjsUbvN8vjAi+Khm+wsOY
 WFdWBctI2xJf+XwDcB2RxDjFPJJJUgtLRmmcZeMPKJRu+/uID4Zf1vBlzRlBW/gvKbKjITyr/7o
 MOek8MPb3prAaV4jvvOiFsB1CTRpbUNy62H/hBAGLSfkwB6jB2ktBNfpJ5TFnH5J0UJ7CIGnC6o
 oUT8rzZtsui1zwx0hl5oVlqZwiRdJWibUx1dVXFmg4Rapg3162VE7Lyjh4zwWon9+R3xjqUeBw0
 E0lUsb9yJikgTdrvVmjDxyv2pylE8mi9bsoWxh2avGyTGSV334+Aia+FZJmV518Rh6DacLl4ZsA
 OqL6IJL8DBt5EidtDdkJCmjoJPkqesUEw5cP3paAvukzUjmoTvVye1aokOwaNfjo5BIz0Thtfbk
 hK+CD6xCMrgU29QTdkinLFccUd4X4VKTiXjtrQRiw5Ft2H25TGcrdse52ZGPTGaOGNEtonjtQtm
 m10TAZ8oNY5QF92PT01HGbMr79FtzBF
X-Received: by 2002:a05:6000:1842:b0:487:452:dbd3 with SMTP id
 ffacd0b85a97d-4887db40fb3mr19241248f8f.47.1790608243655; 
 Mon, 28 Sep 2026 08:10:43 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:152b:4800:8072:ed4c:898d:d82d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a35fb05sm31513965f8f.20.2026.09.28.08.10.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:10:43 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com,
 cascardo@igalia.com, tvrtko.ursulin@igalia.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/9] drm/amdgpu: rework eviction lock handling into critical
 section v3
Date: Mon, 28 Sep 2026 17:10:33 +0200
Message-ID: <20260928151041.1857-1-christian.koenig@amd.com>
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
Reply-To: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Taking the eviction lock is actually just one step which we need to do
in the critical section handling.

Rename the functions to reflect that, use the update parameters instead of the
vm to save the GFP flags.

v2: rebased and reordered
v3: fix rebase artefact, fix error handling in amdgpu_vm_pt_alloc

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Natalie Vock <nat@pixelcluster.dev>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |  8 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  1 -
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   | 43 ++++++++++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     | 40 ++++++++---------
 4 files changed, 54 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 29a66e39f3d60..7b9494375649f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1170,11 +1170,9 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -1258,7 +1256,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 error_free:
 	kfree(tlb_cb);
-	amdgpu_vm_eviction_unlock(vm);
+	amdgpu_vm_end_critical(&params);
 	drm_dev_exit(idx);
 	return r;
 }
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
index ca86eaac75235..8ebb0b033291e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -51,7 +51,7 @@ struct amdgpu_vm_update_params {
 	struct amdgpu_device *adev;
 
 	/**
-	 * @vm: optional amdgpu_vm we do this update for
+	 * @vm: amdgpu_vm we do this update for
 	 */
 	struct amdgpu_vm *vm;
 
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
index 1cdf2b854f261..c03327f1242d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -505,52 +505,51 @@ int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
+		goto error_free_pt;
 
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
-		goto error_free_pt;
+		goto error_unpin;
 
 	return 0;
 
-error_free_pt:
-	if (vm->is_npa)
+error_unpin:
+	if (p->vm->is_npa)
 		amdgpu_bo_unpin(pt_bo);
+error_free_pt:
 	amdgpu_bo_unref(&pt_bo);
 	return r;
 }
@@ -838,8 +837,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
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


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5AA3C52D6F
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Aug 2024 12:03:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ECEEB10E8E1;
	Wed, 21 Aug 2024 12:03:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WgUq1jn2";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7EE410E8E0
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 12:03:28 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-428f5c0833bso3895795e9.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Aug 2024 05:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724241807; x=1724846607; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ss9JxRLG7GCqfdsD7zB5xZvQxPEWpm9aZSjQFEwkosM=;
 b=WgUq1jn232ArjwlOu/Hhe7mDlTE4aZj5055YyW9iJqHKDv5f/2xvuEujn0ZJk6XtIF
 GI6dTfU5y2qNxGYrKdvMbPRJuFc5mj1QFz6b7gujcLa5r9ZMFDXSPLBgSrZ/mS1wATzK
 Iz7jOB+LSZuXjtDNH0TTeXhOZuw+lc6j8wFJehxS/RA6jWE8migMV3WHztgyZBhODgt4
 BVfsLq8VO6SWLkbHcT6RBqJ/hyPB9a8F2zhsmPxXv6l3KEoEdziy1hOYwW4Vt1gxgfjn
 6+LCzS0r4lNrYGHLSOVIFt/FN23X7FbcWAiODJuJwbV2QiiAMgHupdlFns0WqHMtPwFM
 pkgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724241807; x=1724846607;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ss9JxRLG7GCqfdsD7zB5xZvQxPEWpm9aZSjQFEwkosM=;
 b=HgshzaMbJBPBjr3Z2eFd6a3SiP/FkQAaytAP4GloEEzFIHFQc6WmrcrSg+jJhsG8Hn
 M2N1cRBfY1aHIID6ZPirqUJmYRfQXiJaOeYhq5uGTWbF2J/zlK13rhSjbrzuA09+Pjuv
 Y1MHRtYbgpW7YXphBxjDt3pagTw5066B3tgsf8jL6WdWYzLHzmURg9IfvTQaRtst9OTP
 z0Hg2AmRJR59tSzZCG5znrSbUWqehBi6YigDyVLj/0ll70L1lHX2cqpliz1t4LNh4+IL
 Yr1fPRVW4+FwZFD8pWkOIQSRNd+csKfFDO77I+pCPrZOULSA0Bs5p8nfLvod3YIjsjiu
 JMUw==
X-Gm-Message-State: AOJu0YzTCh27CB9qSMkFPWwq9bODsYRIvsYIVKBlcC8mmk444nfmaUs8
 WQQcthQ8zX3HZly9wCHiOaQmnvEWOSzMZRUS/LCASgaj7OrlI5YQ
X-Google-Smtp-Source: AGHT+IGDukQaVukU7fc2Rg8e3KabnAOibKhjn7qVkqtI5hkzdmS3WYutUekCZi6Me+5f7yGfaJjUcA==
X-Received: by 2002:a05:6000:1787:b0:36b:5d86:d885 with SMTP id
 ffacd0b85a97d-372fde02d76mr1487971f8f.24.1724241806504; 
 Wed, 21 Aug 2024 05:03:26 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1526:a800:3751:35d:98bf:f3ee])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-371898ac2c6sm15534814f8f.108.2024.08.21.05.03.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Aug 2024 05:03:25 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: friedrich.vock@gmx.de, bas@basnieuwenhuizen.nl, ishitatsuyuki@gmail.com,
 felix.kuehling@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/3] drm/amdgpu: re-work VM syncing
Date: Wed, 21 Aug 2024 14:03:22 +0200
Message-Id: <20240821120324.4583-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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

Rework how VM operations synchronize to submissions. Provide an
amdgpu_sync container to the backends instead of an reservation
object and fill in the amdgpu_sync object in the higher layers
of the code.

No intended functional change, just prepares for upcomming changes.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 84 +++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h      | 11 +--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c  |  7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c | 16 +---
 5 files changed, 65 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index bcb729094521..ba99d428610a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -838,7 +838,7 @@ int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 	params.vm = vm;
 	params.immediate = immediate;
 
-	r = vm->update_funcs->prepare(&params, NULL, AMDGPU_SYNC_EXPLICIT);
+	r = vm->update_funcs->prepare(&params, NULL);
 	if (r)
 		goto error;
 
@@ -933,7 +933,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
  * @unlocked: unlocked invalidation during MM callback
  * @flush_tlb: trigger tlb invalidation after update completed
  * @allow_override: change MTYPE for local NUMA nodes
- * @resv: fences we need to sync to
+ * @sync: fences we need to sync to
  * @start: start of mapped range
  * @last: last mapped entry
  * @flags: flags for the entries
@@ -949,16 +949,16 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
  * 0 for success, negative erro code for failure.
  */
 int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			   bool immediate, bool unlocked, bool flush_tlb, bool allow_override,
-			   struct dma_resv *resv, uint64_t start, uint64_t last,
-			   uint64_t flags, uint64_t offset, uint64_t vram_base,
+			   bool immediate, bool unlocked, bool flush_tlb,
+			   bool allow_override, struct amdgpu_sync *sync,
+			   uint64_t start, uint64_t last, uint64_t flags,
+			   uint64_t offset, uint64_t vram_base,
 			   struct ttm_resource *res, dma_addr_t *pages_addr,
 			   struct dma_fence **fence)
 {
 	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_res_cursor cursor;
-	enum amdgpu_sync_mode sync_mode;
 	int r, idx;
 
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
@@ -991,14 +991,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.allow_override = allow_override;
 	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
 
-	/* Implicitly sync to command submissions in the same VM before
-	 * unmapping. Sync to moving fences before mapping.
-	 */
-	if (!(flags & AMDGPU_PTE_VALID))
-		sync_mode = AMDGPU_SYNC_EQ_OWNER;
-	else
-		sync_mode = AMDGPU_SYNC_EXPLICIT;
-
 	amdgpu_vm_eviction_lock(vm);
 	if (vm->evicting) {
 		r = -EBUSY;
@@ -1013,7 +1005,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		dma_fence_put(tmp);
 	}
 
-	r = vm->update_funcs->prepare(&params, resv, sync_mode);
+	r = vm->update_funcs->prepare(&params, sync);
 	if (r)
 		goto error_free;
 
@@ -1155,23 +1147,30 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 	struct amdgpu_bo *bo = bo_va->base.bo;
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	struct amdgpu_bo_va_mapping *mapping;
+	struct dma_fence **last_update;
 	dma_addr_t *pages_addr = NULL;
 	struct ttm_resource *mem;
-	struct dma_fence **last_update;
+	struct amdgpu_sync sync;
 	bool flush_tlb = clear;
-	bool uncached;
-	struct dma_resv *resv;
 	uint64_t vram_base;
 	uint64_t flags;
+	bool uncached;
 	int r;
 
+	amdgpu_sync_create(&sync);
 	if (clear || !bo) {
 		mem = NULL;
-		resv = vm->root.bo->tbo.base.resv;
+
+		/* Implicitly sync to command submissions in the same VM before
+		 * unmapping.
+		 */
+		r = amdgpu_sync_resv(adev, &sync, vm->root.bo->tbo.base.resv,
+				     AMDGPU_SYNC_EQ_OWNER, vm);
+		if (r)
+			goto error_free;
 	} else {
 		struct drm_gem_object *obj = &bo->tbo.base;
 
-		resv = bo->tbo.base.resv;
 		if (obj->import_attach && bo_va->is_xgmi) {
 			struct dma_buf *dma_buf = obj->import_attach->dmabuf;
 			struct drm_gem_object *gobj = dma_buf->priv;
@@ -1185,6 +1184,12 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 		if (mem && (mem->mem_type == TTM_PL_TT ||
 			    mem->mem_type == AMDGPU_PL_PREEMPT))
 			pages_addr = bo->tbo.ttm->dma_address;
+
+		/* Implicitly sync to moving fences before mapping anything */
+		r = amdgpu_sync_resv(adev, &sync, bo->tbo.base.resv,
+				     AMDGPU_SYNC_EXPLICIT, vm);
+		if (r)
+			goto error_free;
 	}
 
 	if (bo) {
@@ -1234,12 +1239,12 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 		trace_amdgpu_vm_bo_update(mapping);
 
 		r = amdgpu_vm_update_range(adev, vm, false, false, flush_tlb,
-					   !uncached, resv, mapping->start, mapping->last,
-					   update_flags, mapping->offset,
-					   vram_base, mem, pages_addr,
-					   last_update);
+					   !uncached, &sync, mapping->start,
+					   mapping->last, update_flags,
+					   mapping->offset, vram_base, mem,
+					   pages_addr, last_update);
 		if (r)
-			return r;
+			goto error_free;
 	}
 
 	/* If the BO is not in its preferred location add it back to
@@ -1267,7 +1272,9 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 			trace_amdgpu_vm_bo_mapping(mapping);
 	}
 
-	return 0;
+error_free:
+	amdgpu_sync_free(&sync);
+	return r;
 }
 
 /**
@@ -1414,25 +1421,34 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm,
 			  struct dma_fence **fence)
 {
-	struct dma_resv *resv = vm->root.bo->tbo.base.resv;
 	struct amdgpu_bo_va_mapping *mapping;
-	uint64_t init_pte_value = 0;
 	struct dma_fence *f = NULL;
+	struct amdgpu_sync sync;
 	int r;
 
+
+	/*
+	 * Implicitly sync to command submissions in the same VM before
+	 * unmapping.
+	 */
+	amdgpu_sync_create(&sync);
+	r = amdgpu_sync_resv(adev, &sync, vm->root.bo->tbo.base.resv,
+			     AMDGPU_SYNC_EQ_OWNER, vm);
+	if (r)
+		goto error_free;
+
 	while (!list_empty(&vm->freed)) {
 		mapping = list_first_entry(&vm->freed,
 			struct amdgpu_bo_va_mapping, list);
 		list_del(&mapping->list);
 
 		r = amdgpu_vm_update_range(adev, vm, false, false, true, false,
-					   resv, mapping->start, mapping->last,
-					   init_pte_value, 0, 0, NULL, NULL,
-					   &f);
+					   &sync, mapping->start, mapping->last,
+					   0, 0, 0, NULL, NULL, &f);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
 			dma_fence_put(f);
-			return r;
+			goto error_free;
 		}
 	}
 
@@ -1443,7 +1459,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 		dma_fence_put(f);
 	}
 
-	return 0;
+error_free:
+	amdgpu_sync_free(&sync);
+	return r;
 
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 046949c4b695..1a759012ce93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -304,8 +304,8 @@ struct amdgpu_vm_update_params {
 
 struct amdgpu_vm_update_funcs {
 	int (*map_table)(struct amdgpu_bo_vm *bo);
-	int (*prepare)(struct amdgpu_vm_update_params *p, struct dma_resv *resv,
-		       enum amdgpu_sync_mode sync_mode);
+	int (*prepare)(struct amdgpu_vm_update_params *p,
+		       struct amdgpu_sync *sync);
 	int (*update)(struct amdgpu_vm_update_params *p,
 		      struct amdgpu_bo_vm *bo, uint64_t pe, uint64_t addr,
 		      unsigned count, uint32_t incr, uint64_t flags);
@@ -505,9 +505,10 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
 void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 			    struct amdgpu_vm *vm, struct amdgpu_bo *bo);
 int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			   bool immediate, bool unlocked, bool flush_tlb, bool allow_override,
-			   struct dma_resv *resv, uint64_t start, uint64_t last,
-			   uint64_t flags, uint64_t offset, uint64_t vram_base,
+			   bool immediate, bool unlocked, bool flush_tlb,
+			   bool allow_override, struct amdgpu_sync *sync,
+			   uint64_t start, uint64_t last, uint64_t flags,
+			   uint64_t offset, uint64_t vram_base,
 			   struct ttm_resource *res, dma_addr_t *pages_addr,
 			   struct dma_fence **fence);
 int amdgpu_vm_bo_update(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index 3895bd7d176a..9ff59a4e6f15 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -46,13 +46,12 @@ static int amdgpu_vm_cpu_map_table(struct amdgpu_bo_vm *table)
  * Negativ errno, 0 for success.
  */
 static int amdgpu_vm_cpu_prepare(struct amdgpu_vm_update_params *p,
-				 struct dma_resv *resv,
-				 enum amdgpu_sync_mode sync_mode)
+				 struct amdgpu_sync *sync)
 {
-	if (!resv)
+	if (!sync)
 		return 0;
 
-	return amdgpu_bo_sync_wait_resv(p->adev, resv, sync_mode, p->vm, true);
+	return amdgpu_sync_wait(sync, true);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index e39d6e7643bf..a076f43097e4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -403,7 +403,7 @@ int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.vm = vm;
 	params.immediate = immediate;
 
-	r = vm->update_funcs->prepare(&params, NULL, AMDGPU_SYNC_EXPLICIT);
+	r = vm->update_funcs->prepare(&params, NULL);
 	if (r)
 		goto exit;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 9b748d7058b5..4772fba33285 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -77,32 +77,24 @@ static int amdgpu_vm_sdma_alloc_job(struct amdgpu_vm_update_params *p,
  * amdgpu_vm_sdma_prepare - prepare SDMA command submission
  *
  * @p: see amdgpu_vm_update_params definition
- * @resv: reservation object with embedded fence
- * @sync_mode: synchronization mode
+ * @sync: amdgpu_sync object with fences to wait for
  *
  * Returns:
  * Negativ errno, 0 for success.
  */
 static int amdgpu_vm_sdma_prepare(struct amdgpu_vm_update_params *p,
-				  struct dma_resv *resv,
-				  enum amdgpu_sync_mode sync_mode)
+				  struct amdgpu_sync *sync)
 {
-	struct amdgpu_sync sync;
 	int r;
 
 	r = amdgpu_vm_sdma_alloc_job(p, 0);
 	if (r)
 		return r;
 
-	if (!resv)
+	if (!sync)
 		return 0;
 
-	amdgpu_sync_create(&sync);
-	r = amdgpu_sync_resv(p->adev, &sync, resv, sync_mode, p->vm);
-	if (!r)
-		r = amdgpu_sync_push_to_job(&sync, p->job);
-	amdgpu_sync_free(&sync);
-
+	r = amdgpu_sync_push_to_job(sync, p->job);
 	if (r) {
 		p->num_dw_left = 0;
 		amdgpu_job_free(p->job);
-- 
2.34.1


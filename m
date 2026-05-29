Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 485A6CD6E43
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 11:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA55B10FDCC;
	Fri, 29 May 2026 11:40:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="tHKUAh6L";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98DE910FDC9
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 11:40:43 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49050bfe053so44291995e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 04:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780054842; x=1780659642; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Hz5mfmh+1Szrf9d9MXqXv6HkvN/P6wggT+B6h9bnSwg=;
 b=tHKUAh6LrNmGWkq7FTncCH04Dp4P8u3litxltwJuFNfiTNfiCf70x8HjflUx3rvx/6
 bADRgSYFSc6ifJdfFkUjrut3x1w5luBWSUkVrXuAR1II8tBCiDQcdDxpNMsAU/43Aw/l
 xglXzIHi708ZBv61dv6+XYp4O0juGOjHO0ztMdHazD0VW5rJaveXYbcYLT34qEyNcwHm
 hW+3o7+Z5E68I7rPzbCHeBosFSxPhBfJPsRGy/Z9HE1firK47WpLro23JO4Tlc9pVoQf
 8QcH8trxjgsjNIv0bIl9MbAGbkYCeybvop8bY3UP7hJPaXlQ29OyEiquFiHiK0Z+7Shv
 w2xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780054842; x=1780659642;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Hz5mfmh+1Szrf9d9MXqXv6HkvN/P6wggT+B6h9bnSwg=;
 b=kCC01mwdDu9uqL5mD30t7UsidaIl6q6xd9ArUHjBuTwJ5Vxr9JkKGbMqPnpZLLH/pW
 y+EYgp25+ecTxZyaEl8JPok2eV2Eezfr/Am9e43tDgN23y25YmyEc8y3OqO27VTrJHYw
 a4uMC0V/ep0aFbfrisCD2gksfDTXnX4un3gH3+lu/XJtxx90qEEqdku7AAIpvfQZWegX
 q4HvPnndXl3gSCrKPdBT0p6NczHNKPCiTqBTVrIPSxUxQ8kkTWdL3oHh2PR/S4YAtWwS
 DISpwr+ObYnW6h7gCyGLQOrvSL2NAi5lHCPw0CpTCj1b7187W9h0e/67c5JpON4Pjc0G
 b16w==
X-Gm-Message-State: AOJu0YzX+Fax+7jAI8xizUnSSwVqTsyV5qJ7iDewqPQpyRQqb751uFaO
 jR0hQubuUaYPmtiGitsUorF9F1yf7Ngvu0O5qxxwkWCdn94SQ0sMbmSeUOKggDZcI8g=
X-Gm-Gg: Acq92OGPEFleFh9k6GBNqn0zJ3XVTcLHkBeydZdcxYt7Lw6R3ZXiNcbgBX9z1KIgu1d
 ahrMNntRIGcRdrqS2ZGbq0l6uTSCTr2bO9IwyOhRqxEzI1n29TOnWwYb46dEBaYLs4Gh3xsNSgF
 YrEb7KcbflLqV0U8Ab3YkPgHJBKUYDs5UoHKiOZAwkSCc8o0dj5juWsSuAPX4pXL9tZZyVojJq3
 eG8sI3bYVwfb7PAW4fDRk4pycKO1J+SX7ILHl28yxylxNGz/vQJV1ERl4ol2cYAJeFGYcX280No
 7e+zbD6yZlZavup9qQyE2D11kxLA00ovdqBweC8SHJErwUQ2/5ahwlzjF+QQgzNcQfeXpK6Q3Qk
 LVx/Astp9PlyQ3mtG2zrUR7mOJvj7ggR2YGT/KZQf7nz2gPoxe5x1hQvkNU8WK5UvCEpIehw0L3
 IIP4rPxqEdzJMsi+vCkrQQke4/ts8AQLbVIVB+7eBitq8=
X-Received: by 2002:a05:600c:561a:b0:490:7136:ad0a with SMTP id
 5b1f17b1804b1-4909c0792admr36565715e9.4.1780054842015; 
 Fri, 29 May 2026 04:40:42 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1544:8100:da55:fa26:bd:a26])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cf0dsm2993109f8f.17.2026.05.29.04.40.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:40:41 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 08/13] drm/amdgpu: split amdgpu_vm_update_range
Date: Fri, 29 May 2026 13:24:10 +0200
Message-ID: <20260529114031.3714-9-christian.koenig@amd.com>
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

Split amdgpu_vm_update_range into two functions.

amdgpu_vm_map_range() is for mapping PTEs into a range and updates
which can be done while holding the VM lock.

amdgpu_vm_unmap_range() is for unmapping PTEs without holding the VM
lock in MMU notifiers.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h   |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c    | 112 ++++++++++++++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h    |  14 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c |  35 ++-----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c      |  16 ++--
 5 files changed, 120 insertions(+), 60 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 44fe40f9e8df..653ffa9ca0f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -47,7 +47,7 @@ enum amdgpu_ib_pool_type;
 /* Internal kernel job ids. (decreasing values, starting from U64_MAX). */
 #define AMDGPU_KERNEL_JOB_ID_VM_UPDATE              (18446744073709551615ULL)
 #define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_PDES         (18446744073709551614ULL)
-#define AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE        (18446744073709551613ULL)
+#define AMDGPU_KERNEL_JOB_ID_VM_MAP_RANGE           (18446744073709551613ULL)
 #define AMDGPU_KERNEL_JOB_ID_VM_PT_CLEAR            (18446744073709551612ULL)
 #define AMDGPU_KERNEL_JOB_ID_TTM_MAP_BUFFER         (18446744073709551611ULL)
 #define AMDGPU_KERNEL_JOB_ID_TTM_ACCESS_MEMORY_SDMA (18446744073709551610ULL)
@@ -63,6 +63,7 @@ enum amdgpu_ib_pool_type;
 #define AMDGPU_KERNEL_JOB_ID_SDMA_RING_TEST         (18446744073709551600ULL)
 #define AMDGPU_KERNEL_JOB_ID_VPE_RING_TEST          (18446744073709551599ULL)
 #define AMDGPU_KERNEL_JOB_ID_RUN_SHADER             (18446744073709551598ULL)
+#define AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE         (18446744073709551597ULL)
 
 struct amdgpu_job {
 	struct drm_sched_job    base;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index edc8b1ca2d3e..b5adfcacc55a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1080,11 +1080,10 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
 }
 
 /**
- * amdgpu_vm_update_range - update a range in the vm page table
+ * amdgpu_vm_map_range - map something to a range in the vm page tables
  *
  * @adev: amdgpu_device pointer to use for commands
  * @vm: the VM to update the range
- * @unlocked: unlocked invalidation during MM callback
  * @flush_tlb: trigger tlb invalidation after update completed
  * @allow_override: change MTYPE for local NUMA nodes
  * @sync: fences we need to sync to
@@ -1097,23 +1096,26 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
  * @pages_addr: DMA addresses to use for mapping
  * @fence: optional resulting fence
  *
- * Fill in the page table entries between @start and @last.
+ * Fill in the page table entries between @start and @last. Allocate and free
+ * new page tables as needed. Can only be called while holding the VM lock.
  *
  * Returns:
  * 0 for success, negative erro code for failure.
  */
-int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			   bool unlocked, bool flush_tlb, bool allow_override,
-			   struct amdgpu_sync *sync, uint64_t start,
-			   uint64_t last, uint64_t flags, uint64_t offset,
-			   uint64_t vram_base, struct ttm_resource *res,
-			   dma_addr_t *pages_addr, struct dma_fence **fence)
+int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			bool flush_tlb, bool allow_override,
+			struct amdgpu_sync *sync, uint64_t start,
+			uint64_t last, uint64_t flags, uint64_t offset,
+			uint64_t vram_base, struct ttm_resource *res,
+			dma_addr_t *pages_addr, struct dma_fence **fence)
 {
 	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_res_cursor cursor;
 	int r, idx;
 
+	amdgpu_vm_assert_locked(vm);
+
 	if (!drm_dev_enter(adev_to_drm(adev), &idx))
 		return -ENODEV;
 
@@ -1138,7 +1140,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.adev = adev;
 	params.vm = vm;
 	params.pages_addr = pages_addr;
-	params.unlocked = unlocked;
 	params.needs_flush = flush_tlb;
 	params.override_pte = allow_override && adev->gmc.override_pte;
 	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
@@ -1149,7 +1150,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		goto error_free;
 	}
 
-	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
+	if (!dma_fence_is_signaled(vm->last_unlocked)) {
 		struct dma_fence *tmp = dma_fence_get_stub();
 
 		amdgpu_bo_fence(vm->root.bo, vm->last_unlocked, true);
@@ -1158,7 +1159,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}
 
 	r = vm->update_funcs->prepare(&params, sync,
-				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE);
+				      AMDGPU_KERNEL_JOB_ID_VM_MAP_RANGE);
 	if (r)
 		goto error_free;
 
@@ -1234,6 +1235,77 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	return r;
 }
 
+/**
+ * amdgpu_vm_unmap_range - clear leave PTEs to unmap something
+ *
+ * @adev: amdgpu_device pointer to use for commands
+ * @vm: the VM to update the range
+ * @sync: fences we need to sync to
+ * @start: start of unmapped range
+ * @last: last unmapped entry
+ * @flags: flags for the entries
+ * @fence: optional resulting fence
+ *
+ * Fill in the page table entries between @start and @last with a fixed flags
+ * value without allocating or freeing page tables. Can be used without locking
+ * the VM.
+ *
+ * Returns:
+ * 0 for success, negative erro code for failure.
+ */
+int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			   struct amdgpu_sync *sync, uint64_t start,
+			   uint64_t last, uint64_t flags,
+			   struct dma_fence **fence)
+{
+	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
+	struct amdgpu_vm_update_params params;
+	int r, idx;
+
+	if (!drm_dev_enter(adev_to_drm(adev), &idx))
+		return -ENODEV;
+
+	tlb_cb = kmalloc(sizeof(*tlb_cb), GFP_KERNEL);
+	if (!tlb_cb) {
+		drm_dev_exit(idx);
+		return -ENOMEM;
+	}
+
+	memset(&params, 0, sizeof(params));
+	params.adev = adev;
+	params.vm = vm;
+	params.needs_flush = true;
+	params.unlocked = true;
+	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
+
+	amdgpu_vm_eviction_lock(vm);
+	if (vm->evicting) {
+		r = -EBUSY;
+		goto error_free;
+	}
+
+	r = vm->update_funcs->prepare(&params, sync,
+				      AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE);
+	if (r)
+		goto error_free;
+
+	amdgpu_vm_update_leaves(&params, start, last, 0, flags);
+
+	r = vm->update_funcs->commit(&params, fence);
+	if (r)
+		goto error_free;
+
+	amdgpu_vm_tlb_flush(&params, fence, tlb_cb);
+	amdgpu_vm_pt_free_list(adev, &params);
+	tlb_cb = NULL;
+
+error_free:
+	kfree(tlb_cb);
+	amdgpu_vm_eviction_unlock(vm);
+	drm_dev_exit(idx);
+	return r;
+}
+
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
 			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
 {
@@ -1362,11 +1434,11 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 
 		trace_amdgpu_vm_bo_update(mapping);
 
-		r = amdgpu_vm_update_range(adev, vm, false, flush_tlb,
-					   !uncached, &sync, mapping->start,
-					   mapping->last, update_flags,
-					   mapping->offset, vram_base, mem,
-					   pages_addr, last_update);
+		r = amdgpu_vm_map_range(adev, vm, flush_tlb, !uncached, &sync,
+					mapping->start, mapping->last,
+					update_flags, mapping->offset,
+					vram_base, mem, pages_addr,
+					last_update);
 		if (r)
 			goto error_free;
 	}
@@ -1565,9 +1637,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 			struct amdgpu_bo_va_mapping, list);
 		list_del(&mapping->list);
 
-		r = amdgpu_vm_update_range(adev, vm, false, true, false,
-					   &sync, mapping->start, mapping->last,
-					   0, 0, 0, NULL, NULL, &f);
+		r = amdgpu_vm_map_range(adev, vm, true, false,
+					&sync, mapping->start, mapping->last,
+					0, 0, 0, NULL, NULL, &f);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
 			dma_fence_put(f);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 3e86a2a470f0..561f2873d2ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -529,12 +529,16 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
 				uint32_t xcc_mask);
 void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 			    struct amdgpu_vm *vm, struct amdgpu_bo *bo);
-int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			   bool unlocked, bool flush_tlb, bool allow_override,
+int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			bool flush_tlb, bool allow_override,
+			struct amdgpu_sync *sync, uint64_t start,
+			uint64_t last, uint64_t flags, uint64_t offset,
+			uint64_t vram_base, struct ttm_resource *res,
+			dma_addr_t *pages_addr, struct dma_fence **fence);
+int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			   struct amdgpu_sync *sync, uint64_t start,
-			   uint64_t last, uint64_t flags, uint64_t offset,
-			   uint64_t vram_base, struct ttm_resource *res,
-			   dma_addr_t *pages_addr, struct dma_fence **fence);
+			   uint64_t last, uint64_t flags,
+			   struct dma_fence **fence);
 int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
 			bool clear);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 6f5415d5a1bc..ac3f3e31e2e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -553,7 +553,6 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
 			    struct amdgpu_vm_update_params *params)
 {
 	struct amdgpu_vm_bo_base *entry, *next;
-	bool unlocked = params->unlocked;
 
 	if (list_empty(&params->tlb_flush_waitlist))
 		return;
@@ -561,7 +560,7 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
 	/*
 	 * unlocked unmap clear page table leaves, warning to free the page entry.
 	 */
-	WARN_ON(unlocked);
+	WARN_ON(params->unlocked);
 
 	list_for_each_entry_safe(entry, next, &params->tlb_flush_waitlist, vm_status)
 		amdgpu_vm_pt_free(entry);
@@ -801,24 +800,17 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 		uint64_t incr, entry_end, pe_start;
 		struct amdgpu_bo *pt;
 
-		if (!params->unlocked) {
-			/* make sure that the page tables covering the
-			 * address range are actually allocated
-			 */
-			r = amdgpu_vm_pt_alloc(params->adev, params->vm,
-					       &cursor);
-			if (r)
-				return r;
-		}
+		/* make sure that the page tables covering the
+		 * address range are actually allocated
+		 */
+		r = amdgpu_vm_pt_alloc(params->adev, params->vm, &cursor);
+		if (r)
+			return r;
 
 		shift = amdgpu_vm_pt_level_shift(adev, cursor.level);
 		parent_shift = amdgpu_vm_pt_level_shift(adev, cursor.level - 1);
-		if (params->unlocked) {
-			/* Unlocked updates are only allowed on the leaves */
-			if (amdgpu_vm_pt_descendant(adev, &cursor))
-				continue;
-		} else if (adev->asic_type < CHIP_VEGA10 &&
-			   (flags & AMDGPU_PTE_VALID)) {
+		if (adev->asic_type < CHIP_VEGA10 &&
+		    (flags & AMDGPU_PTE_VALID)) {
 			/* No huge page support before GMC v9 */
 			if (cursor.level != AMDGPU_VM_PTB) {
 				if (!amdgpu_vm_pt_descendant(adev, &cursor))
@@ -864,14 +856,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 		mask = amdgpu_vm_pt_entries_mask(adev, cursor.level);
 		pe_start = ((cursor.pfn >> shift) & mask) * 8;
 
-		if (cursor.level < AMDGPU_VM_PTB && params->unlocked)
-			/*
-			 * MMU notifier callback unlocked unmap huge page, leave is PDE entry,
-			 * only clear one entry. Next entry search again for PDE or PTE leave.
-			 */
-			entry_end = 1ULL << shift;
-		else
-			entry_end = ((uint64_t)mask + 1) << shift;
+		entry_end = ((uint64_t)mask + 1) << shift;
 		entry_end += cursor.pfn & ~(entry_end - 1);
 		entry_end = min(entry_end, end);
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 37b5166e9a14..d0ea20dea3e1 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1372,9 +1372,8 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		return -EINVAL;
 	}
 
-	return amdgpu_vm_update_range(adev, vm, true, true, false, NULL, gpu_start,
-				      gpu_end, init_pte_value, 0, 0, NULL, NULL,
-				      fence);
+	return amdgpu_vm_unmap_range(adev, vm, NULL, gpu_start, gpu_end,
+				     init_pte_value, fence);
 }
 
 static int
@@ -1489,12 +1488,11 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 			 (last_domain == SVM_RANGE_VRAM_DOMAIN) ? 1 : 0,
 			 pte_flags);
 
-		r = amdgpu_vm_update_range(adev, vm, false, flush_tlb, true,
-					   NULL, gpu_start, gpu_end,
-					   pte_flags,
-					   (last_start - prange->start) << PAGE_SHIFT,
-					   bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
-					   NULL, dma_addr, &vm->last_update);
+		r = amdgpu_vm_map_range(adev, vm, flush_tlb, true, NULL,
+					gpu_start, gpu_end, pte_flags,
+					(last_start - prange->start) << PAGE_SHIFT,
+					bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
+					NULL, dma_addr, &vm->last_update);
 
 		for (j = last_start - prange->start; j <= i; j++)
 			dma_addr[j] |= last_domain;
-- 
2.43.0


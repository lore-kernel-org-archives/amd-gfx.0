Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D6ECA5FC7
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Sep 2026 13:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15F3610F3FA;
	Wed, 30 Sep 2026 13:33:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JXX029qJ";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8403610F3F8
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 13:33:23 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-4a00713639cso24578505e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Sep 2026 06:33:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790775202; x=1791380002; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=8P/IGfvQ42mpjtzjW/GhQ8gIFZnLcVM275opgDQCEqU=;
 b=JXX029qJE5keOxQLaPrJPlP4qFiAgBangcuk802J/nnf/Eh2VSOxVzVvXBN16NHacX
 r5wXK0bQIL5i5FoicXGKz4YoBbV/XPTujH2LqVVhP0Qzo9DjvcSnQNuprYRXshetK0uC
 m+Di6yK87W6krA+BoobdLb3cuWg3aEm527+tmUZBaafHotnbzrA+nVmz1XF2NviOnkMk
 MoWI6otgKlk7ZmWkjM2SmeDNGaD7ROQNa3TigbHkgv98F4AyD7ECCJnCRn0xk+gnupb+
 3skhkFRuLCmVUTmmQRYX5zCy0eGMAmEu0tWrY7ESlxAqWx6pslAVxp3RN0am4Pin5wEz
 dX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775202; x=1791380002;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8P/IGfvQ42mpjtzjW/GhQ8gIFZnLcVM275opgDQCEqU=;
 b=EQwVy67kLf/KsUB447UJmBMlvlMdQMfvTwV4ahhzwTrrlMmDquNjqXrmyBIdrwg2Cj
 2H6N0ksr2ycKvUQwbcgghARQfaIbR009RriyU9AQBGMWhuntKqbxEnl7kAqJmhGRvSIh
 UC0W7O7iuw1HWwDaE3vXWUrJfKV/G30nJHxFsuwLtbRkANhG1pvUO6Gsm7kjvgU1xdXX
 pY3pyITS7MX8eBqzZmOPkSiIQWTHgalPNj1ianWShx69Ja5LHPZnxx/k/TDP5+v9eajp
 g4xs1/hsLcrLR3785Tq3qzhNydpE7gyKjiZorOLxmrWfqcCODQJLEn+mowL+7L3Ch1Jm
 c1vA==
X-Gm-Message-State: AFuF++l+FswEjS0Ba4iBxc9/BqLVcRmYWPR6rj/ck3z9lPp/3Uuw1FRL
 +Y+tAFRDJUgRcXzYu4UhI5ZeTRsBMe2F4wZp6s6bsidH04tdNkDgoZ1Y
X-Gm-Gg: AYBFou1G/oeqoEiwrEop6+w2tgdyGl0kNy2Hz3qGj9YlqHmk9+RHqe4D4zYKE/OpN3F
 4EaLxBvUmbZfOsutiXzWcvyDztoc9H6Cd1Ox+entrpy9IB/CPZWUPyJFCyiJ14jsRI8USI+eotr
 dIozvnT4vjc+lkW2oqvJBQNCaW5DXTUCuWqbyMbyjg5soGI4Ko24Zl+L0nAXyb7uifPFkS9sMyc
 mAm76TINoGW4mxnXStF04Wu0Ywzrq3ApJ0a28Srp1RWgUHtxDu51OlUevV+fC+aiCkNWgM9r7ZE
 BHvE0hyEFBI6mVQMHsjJvnTKWCgwn3QgLh6UvHRTcVBsKoLbxY7bKR8+skM2o/yaekh0HwcJDmL
 RjxDPkXEqGy+XeTk5rhiCtmALWTU5zvkxp9lUJCv3qZrYKzGuQeRLZdAmP4YxEnMtClxGZzXMap
 DCNKRH5Gj0dK58dtKR/krNtiyah/BEbnZIvXDxb/BfdtTc0mz9zKomzFcCNvnB4r41RITUUl9u1
 z3ZzkQaT7g=
X-Received: by 2002:a05:600c:1d2a:b0:49c:fc6e:8caf with SMTP id
 5b1f17b1804b1-4a01b11c737mr27503015e9.19.1790775201711; 
 Wed, 30 Sep 2026 06:33:21 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:155e:6500:f261:39ca:dadd:d0c6])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a01771cf9fsm60407975e9.14.2026.09.30.06.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 06:33:21 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com,
 cascardo@igalia.com, tvrtko.ursulin@igalia.com, olivier.kaloudoff@gmail.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/8] drm/amdgpu: split amdgpu_vm_update_range v3
Date: Wed, 30 Sep 2026 15:33:12 +0200
Message-ID: <20260930133315.12270-6-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260930133315.12270-1-christian.koenig@amd.com>
References: <20260930133315.12270-1-christian.koenig@amd.com>
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

v2: add unlocked parameter and drop flags
v3: use correct clear flags

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h       |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    |  50 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 117 +++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  16 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   |   3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     |  40 ++----
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  17 ++-
 7 files changed, 157 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index ae569b4497f6a..d4a4e51f3b1da 100644
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index 708ca8d56e8c2..7915f3735016a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -2056,9 +2056,9 @@ static int amdgpu_ualink_unmap_npa_addr(struct amdgpu_device *adev,
 		return r;
 	}
 
-	r = amdgpu_vm_update_range(adev, vm, false, true, false, NULL, npa_addr,
-				   npa_addr + size - 1, pte_value, 0, 0, NULL,
-				   NULL, &vm->last_update);
+	r = amdgpu_vm_map_range(adev, vm, true, false, NULL, npa_addr,
+				npa_addr + size - 1, pte_value, 0, 0, NULL,
+				NULL, &vm->last_update);
 	if (r) {
 		dev_err(adev->dev,
 			"Failed to unmap NPA addr (%llx) from NPA VM\n", npa_addr);
@@ -2108,10 +2108,10 @@ static int amdgpu_ualink_map_npa_addr(struct amdgpu_device *adev, u64 npa_addr,
 		return r;
 	}
 
-	r = amdgpu_vm_update_range(adev, vm, false, true, false, NULL, npa_addr,
-				   npa_addr + size - 1, pte_flags, offset,
-				   adev->vm_manager.vram_base_offset,
-				   bo->tbo.resource, NULL, &vm->last_update);
+	r = amdgpu_vm_map_range(adev, vm, true, false, NULL, npa_addr,
+				npa_addr + size - 1, pte_flags, offset,
+				adev->vm_manager.vram_base_offset,
+				bo->tbo.resource, NULL, &vm->last_update);
 	if (r) {
 		dev_warn(adev->dev,
 			"Failed to map NPA addr (%llx) into NPA VM\n", npa_addr);
@@ -2645,12 +2645,12 @@ static void amdgpu_ualink_force_retry_rpcs(struct amdgpu_device *adev,
 			"RETRY-RPC: setting PTE.X=1 for NPA:%llx remote:%u pte:0x%llx\n",
 			npa_addr, remote_acc_id, pte_flags);
 
-		r = amdgpu_vm_update_range(adev, vm, false, true, false, NULL,
-					   npa_addr, npa_addr + size - 1,
-					   pte_flags, 0,
-					   adev->vm_manager.vram_base_offset,
-					   bo->tbo.resource, NULL,
-					   &vm->last_update);
+		r = amdgpu_vm_map_range(adev, vm, true, false, NULL,
+					npa_addr, npa_addr + size - 1,
+					pte_flags, 0,
+					adev->vm_manager.vram_base_offset,
+					bo->tbo.resource, NULL,
+					&vm->last_update);
 
 		if (r)
 			dev_warn(adev->dev,
@@ -2783,10 +2783,10 @@ static void amdgpu_ualink_unmap_all_npa_addr(struct amdgpu_device *adev,
 			npa_addr, exp_xa_node->handle.handle_hi, exp_xa_node->handle.handle_lo,
 			remote_acc_id, pte_value);
 
-		r = amdgpu_vm_update_range(adev, vm, false, true, false, NULL,
-					   npa_addr, npa_addr + size - 1,
-					   pte_value, 0, 0, NULL, NULL,
-					   &vm->last_update);
+		r = amdgpu_vm_map_range(adev, vm, true, false, NULL,
+					npa_addr, npa_addr + size - 1,
+					pte_value, 0, 0, NULL, NULL,
+					&vm->last_update);
 
 		if (r)
 			dev_err(adev->dev,
@@ -4588,10 +4588,10 @@ static int amdgpu_ualink_npa_vm_map_range(struct amdgpu_device *adev, struct amd
 		offset, size_in_pages << AMDGPU_GPU_PAGE_SHIFT, pte_flags,
 		npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
 
-	r = amdgpu_vm_update_range(adev, npa_vm, false, true, false, NULL,
-				   npa_in_pages, npa_in_pages + size_in_pages - 1,
-				   pte_flags, offset, adev->vm_manager.vram_base_offset,
-				   bo->tbo.resource, NULL, &npa_vm->last_update);
+	r = amdgpu_vm_map_range(adev, npa_vm, true, false, NULL,
+				npa_in_pages, npa_in_pages + size_in_pages - 1,
+				pte_flags, offset, adev->vm_manager.vram_base_offset,
+				bo->tbo.resource, NULL, &npa_vm->last_update);
 	if (r)
 		dev_dbg(adev->dev, "failed %d to map npa 0x%llx to NPA VM\n", r,
 			npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
@@ -4622,10 +4622,10 @@ static int amdgpu_ualink_npa_vm_unmap_range(struct amdgpu_device *adev, struct a
 		offset, size_in_pages << AMDGPU_GPU_PAGE_SHIFT, pte_flags,
 		npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
 
-	r = amdgpu_vm_update_range(adev, npa_vm, false, true, false, NULL,
-				   npa_in_pages, npa_in_pages + size_in_pages - 1,
-				   pte_flags, offset, 0, bo->tbo.resource, NULL,
-				   &npa_vm->last_update);
+	r = amdgpu_vm_map_range(adev, npa_vm, true, false, NULL,
+				npa_in_pages, npa_in_pages + size_in_pages - 1,
+				pte_flags, offset, 0, bo->tbo.resource, NULL,
+				&npa_vm->last_update);
 	if (r)
 		dev_dbg(adev->dev, "failed %d to unmap npa 0x%llx from NPA VM\n", r,
 			npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 75a6f9c2a8be3..d039346fda791 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1101,11 +1101,10 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
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
@@ -1118,23 +1117,26 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
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
 
@@ -1159,7 +1161,6 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.adev = adev;
 	params.vm = vm;
 	params.pages_addr = pages_addr;
-	params.unlocked = unlocked;
 	params.needs_flush = flush_tlb;
 	params.override_pte = allow_override && adev->gmc.override_pte;
 	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
@@ -1168,7 +1169,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	if (r)
 		goto error_free;
 
-	if (!unlocked && !dma_fence_is_signaled(vm->last_unlocked)) {
+	if (!dma_fence_is_signaled(vm->last_unlocked)) {
 		struct dma_fence *tmp = dma_fence_get_stub();
 
 		amdgpu_bo_fence(vm->root.bo, vm->last_unlocked, true);
@@ -1177,7 +1178,7 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}
 
 	r = vm->update_funcs->prepare(&params, sync,
-				      AMDGPU_KERNEL_JOB_ID_VM_UPDATE_RANGE);
+				      AMDGPU_KERNEL_JOB_ID_VM_MAP_RANGE);
 	if (r)
 		goto error_free;
 
@@ -1255,6 +1256,82 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	return r;
 }
 
+/**
+ * amdgpu_vm_unmap_range - clear leave PTEs to unmap something
+ *
+ * @adev: amdgpu_device pointer to use for commands
+ * @vm: the VM to update the range
+ * @unlocked: unlocked invalidation during MM callback
+ * @sync: fences we need to sync to
+ * @start: start of unmapped range
+ * @last: last unmapped entry
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
+			  bool unlocked, struct amdgpu_sync *sync,
+			  uint64_t start, uint64_t last,
+			  struct dma_fence **fence)
+{
+	struct amdgpu_vm_manager *vm_mgr = &adev->vm_manager;
+	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
+	struct amdgpu_vm_update_params params;
+	uint64_t flags[AMDGPU_VM_MAX_LEVEL];
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
+	params.unlocked = unlocked;
+	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
+
+	r = amdgpu_vm_begin_critical(&params);
+	if (r)
+		goto error_end_critical;
+
+	r = vm->update_funcs->prepare(&params, sync,
+				      AMDGPU_KERNEL_JOB_ID_VM_UNMAP_RANGE);
+	if (r)
+		goto error_free;
+
+	for (int level = AMDGPU_VM_PTB; level != vm_mgr->root_level; level--)
+		flags[level] = amdgpu_vm_pt_clear_flags(adev, vm, level);
+
+	amdgpu_vm_pt_leaves(&params, start, last + 1, NULL, flags);
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
+
+error_end_critical:
+	amdgpu_vm_end_critical(&params);
+	drm_dev_exit(idx);
+	return r;
+}
+
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
 			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM])
 {
@@ -1383,11 +1460,11 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 
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
@@ -1594,9 +1671,9 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
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
index d84e0a3ff88d4..2a6424f4a6642 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -464,12 +464,16 @@ int amdgpu_vm_flush_compute_tlb(struct amdgpu_device *adev,
 				uint32_t xcc_mask);
 void amdgpu_vm_bo_base_init(struct amdgpu_vm_bo_base *base,
 			    struct amdgpu_vm *vm, struct amdgpu_bo *bo);
-int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			   bool unlocked, bool flush_tlb, bool allow_override,
-			   struct amdgpu_sync *sync, uint64_t start,
-			   uint64_t last, uint64_t flags, uint64_t offset,
-			   uint64_t vram_base, struct ttm_resource *res,
-			   dma_addr_t *pages_addr, struct dma_fence **fence);
+int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			bool flush_tlb, bool allow_override,
+			struct amdgpu_sync *sync, uint64_t start,
+			uint64_t last, uint64_t flags, uint64_t offset,
+			uint64_t vram_base, struct ttm_resource *res,
+			dma_addr_t *pages_addr, struct dma_fence **fence);
+int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			  bool unlocked, struct amdgpu_sync *sync,
+			  uint64_t start, uint64_t last,
+			  struct dma_fence **fence);
 int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
 			bool clear);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
index 89fdeff0575ef..db748e8b3bf38 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -115,6 +115,9 @@ struct amdgpu_vm_update_funcs {
 		      struct dma_fence **fence);
 };
 
+uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
+				  struct amdgpu_vm *vm,
+				  unsigned int level);
 int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       struct amdgpu_bo_vm *vmbo);
 int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index 3b262b0d186a5..d7134fd5d7d45 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -347,9 +347,9 @@ static void amdgpu_vm_pt_next_dfs(struct amdgpu_device *adev,
 	     (entry) = (cursor).entry, amdgpu_vm_pt_next_dfs((adev), &(cursor)))
 
 /* Return the flags used for cleared PDEs/PTES */
-static uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
-					struct amdgpu_vm *vm,
-					unsigned int level)
+uint64_t amdgpu_vm_pt_clear_flags(struct amdgpu_device *adev,
+				  struct amdgpu_vm *vm,
+				  unsigned int level)
 {
 	uint64_t flags;
 
@@ -590,7 +590,6 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
 			    struct amdgpu_vm_update_params *params)
 {
 	struct amdgpu_vm_bo_base *entry, *next;
-	bool unlocked = params->unlocked;
 
 	if (list_empty(&params->tlb_flush_waitlist))
 		return;
@@ -598,7 +597,7 @@ void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
 	/*
 	 * unlocked unmap clear page table leaves, warning to free the page entry.
 	 */
-	WARN_ON(unlocked);
+	WARN_ON(params->unlocked);
 
 	list_for_each_entry_safe(entry, next, &params->tlb_flush_waitlist, vm_status)
 		amdgpu_vm_pt_free(entry);
@@ -830,23 +829,17 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
 		uint64_t incr, entry_end, pe_start;
 		struct amdgpu_bo *pt;
 
-		if (!params->unlocked) {
-			/* make sure that the page tables covering the
-			 * address range are actually allocated
-			 */
-			r = amdgpu_vm_pt_alloc(params, &cursor);
-			if (r)
-				return r;
-		}
+		/* make sure that the page tables covering the
+		 * address range are actually allocated
+		 */
+		r = amdgpu_vm_pt_alloc(params, &cursor);
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
@@ -892,14 +885,7 @@ int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
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
index af8d2ede183a1..263e68d29360d 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1396,7 +1396,6 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			 uint64_t start, uint64_t last,
 			 struct dma_fence **fence)
 {
-	uint64_t init_pte_value = adev->gmc.init_pte_flags;
 	uint64_t gpu_start, gpu_end;
 
 	/* Convert CPU page range to GPU page range */
@@ -1411,9 +1410,8 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		return -EINVAL;
 	}
 
-	return amdgpu_vm_update_range(adev, vm, true, true, false, NULL, gpu_start,
-				      gpu_end, init_pte_value, 0, 0, NULL, NULL,
-				      fence);
+	return amdgpu_vm_unmap_range(adev, vm, true, NULL, gpu_start, gpu_end,
+				     fence);
 }
 
 static int
@@ -1523,12 +1521,11 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
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


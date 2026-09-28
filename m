Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5C9CA5FA2
	for <amd-gfx@archiver.kernel.org>; Mon, 28 Sep 2026 15:10:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BCE6D10EACF;
	Mon, 28 Sep 2026 15:10:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m13rTmsL";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0246B10EAC0
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 15:10:53 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f6351831so1863159f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 28 Sep 2026 08:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790608251; x=1791213051; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=szW7LaAIhJIj272cFeUvF8d3OegbpgiUjef8vew8zz0=;
 b=m13rTmsLNMGRtQsiwfLrV/HXtW0+NhiuHo403qac22eIf3rYLQthLZY9eu05JuBlRN
 rnek13l7u3Kcun4fYsF/fcEc9SkfWEjXH2HSVaygzdRCyHuBLurCi25LdZNIpxhvW7IJ
 hzVqtE6Cw09ZOqMamw4iyI/e4Sokyb8KHowU5/JnXio4cJsy3cD/Z+YiuDVukydqhmKu
 sMNOV/Ona3yDSbpzTZDUJTTMWUlU+TydnsGoUFbR5WyK9Smr6OuvP1yOEJZpVmH1JIl+
 QE1SE5wj5sWdb7lVPJHYDoHXSfPMoObGf9KrPeLEe67iiiNWhTI8xqB7bS8CQKi9Xvx/
 QdsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790608251; x=1791213051;
 h=content-transfer-encoding:reply-to:content-type:mime-version
 :references:in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=szW7LaAIhJIj272cFeUvF8d3OegbpgiUjef8vew8zz0=;
 b=h/Xpi7NSpbVSz5fDHdk2j6pVCDd1ONl1do2Ht8TmEsxqvkM9uh+n9SV0aVXXrCzgvv
 qTgGaGpmP9oGVrv7gFpSjf1nMzZvQ8wOvTlJ9SEwm5eb0pbVyYdeyM0p7lt+79sR8Pd0
 W91PrT3EkPedyFUOK2pK5WJYkT195iAeYMZtGiVJD1gEqzfjrlCRYxuPmMWbZx23v8+r
 6LfJcr/TAMbijr+hsy89I8qKb4Ll3Hf7YWrQDPyB3xvfp1jK76S2SQFP/PtsNV1FaqKu
 8TLNmJlb78C1PtYpMtltRTPCu2l4PIhx8TZSf4IRch/6PWvx9ZK3XQXLVgxhc3ldsr3i
 hH6A==
X-Gm-Message-State: AFq9FYJvw8bpWzTJK/9KgPfRl77Fv41Buj9JwQQO2N1LfaS4G9fK5LBi
 WYNPkixziW+bnpq1FyrJdMPfpIgiUVUVZjajRdK+WE+Vi5cqi15C+cih
X-Gm-Gg: AYBFou1fFFawAVQPWk30qZPGuh7+EYlaDIkIGzDBOpXs/NZYSMafGs05nG3tnAbPtTC
 NYSztyAG0HQ4BJi8wQhJFDnrz8GXeUcTwoBUdveJUUr/IZVRRu0V5strQ5QoxBHN9tqSjA+4pcl
 puYxyZkgXK44dVWfJVcEuZsUqgm+Xt4FNgaP7U6E7IT0yOOi8cjltJ8Kv1sxner1yL4eCTcsUCU
 hxf/pb/k4cdbBygLHa2AFC5wEplHsOcjI1QGogLgA6UUloWXiSDSpNLz7ae/qxDt6MmZkl3mFW5
 aXI8tOXcjAruKsO8rFl3KlxD830n6KilXwXj5YrzEj2Z/tPuNujlSUbxUHitx4gOFQf44AH9Jlr
 3ZBCMNf1Zzc6jBN9IzFawwDvU/fLF4qTlWBBkiccnPHQc2WDhdeObgmqF3QfX3oGTxskOv7ABlH
 jZqeZ/XRXKoMTzqmqgjhn86E/cbu+Z94nVMNWMgME+6m7S01zpZNxp//4FSEnDl+qMF92nPkzIs
 JvokvO0G24=
X-Received: by 2002:a05:6000:2481:b0:487:11db:986c with SMTP id
 ffacd0b85a97d-4887177b8c8mr28075340f8f.51.1790608251228; 
 Mon, 28 Sep 2026 08:10:51 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:152b:4800:8072:ed4c:898d:d82d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a35fb05sm31513965f8f.20.2026.09.28.08.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 08:10:50 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com,
 cascardo@igalia.com, tvrtko.ursulin@igalia.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 8/9] drm/amdgpu: fix the HMM range handling for KFD SVM v2
Date: Mon, 28 Sep 2026 17:10:40 +0200
Message-ID: <20260928151041.1857-8-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260928151041.1857-1-christian.koenig@amd.com>
References: <20260928151041.1857-1-christian.koenig@amd.com>
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

It's mandatory that we have this check inside the VM handling or
otherwise page table allocation and filling PTEs doesn't work correctly.

This allows to remove the buggy SVM range lock, but that's not part of
this patch set.

Only compile tested!

v2: fix broken compile after ualink merge

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c    | 13 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 10 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  4 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   | 10 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 32 ++++++++-----------
 5 files changed, 41 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
index b7975c77b1fe2..c1bb74cb45eda 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ualink.c
@@ -2058,7 +2058,7 @@ static int amdgpu_ualink_unmap_npa_addr(struct amdgpu_device *adev,
 
 	r = amdgpu_vm_map_range(adev, vm, true, false, NULL, npa_addr,
 				npa_addr + size - 1, pte_value, 0, 0, NULL,
-				NULL, &vm->last_update);
+				NULL, NULL, &vm->last_update);
 	if (r) {
 		dev_err(adev->dev,
 			"Failed to unmap NPA addr (%llx) from NPA VM\n", npa_addr);
@@ -2111,7 +2111,7 @@ static int amdgpu_ualink_map_npa_addr(struct amdgpu_device *adev, u64 npa_addr,
 	r = amdgpu_vm_map_range(adev, vm, true, false, NULL, npa_addr,
 				npa_addr + size - 1, pte_flags, offset,
 				adev->vm_manager.vram_base_offset,
-				bo->tbo.resource, NULL, &vm->last_update);
+				bo->tbo.resource, NULL, NULL, &vm->last_update);
 	if (r) {
 		dev_warn(adev->dev,
 			"Failed to map NPA addr (%llx) into NPA VM\n", npa_addr);
@@ -2649,7 +2649,7 @@ static void amdgpu_ualink_force_retry_rpcs(struct amdgpu_device *adev,
 					npa_addr, npa_addr + size - 1,
 					pte_flags, 0,
 					adev->vm_manager.vram_base_offset,
-					bo->tbo.resource, NULL,
+					bo->tbo.resource, NULL, NULL,
 					&vm->last_update);
 
 		if (r)
@@ -2785,7 +2785,7 @@ static void amdgpu_ualink_unmap_all_npa_addr(struct amdgpu_device *adev,
 
 		r = amdgpu_vm_map_range(adev, vm, true, false, NULL,
 					npa_addr, npa_addr + size - 1,
-					pte_value, 0, 0, NULL, NULL,
+					pte_value, 0, 0, NULL, NULL, NULL,
 					&vm->last_update);
 
 		if (r)
@@ -4572,7 +4572,8 @@ static int amdgpu_ualink_npa_vm_map_range(struct amdgpu_device *adev, struct amd
 	r = amdgpu_vm_map_range(adev, npa_vm, true, false, NULL,
 				npa_in_pages, npa_in_pages + size_in_pages - 1,
 				pte_flags, offset, adev->vm_manager.vram_base_offset,
-				bo->tbo.resource, NULL, &npa_vm->last_update);
+				bo->tbo.resource, NULL, NULL,
+				&npa_vm->last_update);
 	if (r)
 		dev_dbg(adev->dev, "failed %d to map npa 0x%llx to NPA VM\n", r,
 			npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
@@ -4606,7 +4607,7 @@ static int amdgpu_ualink_npa_vm_unmap_range(struct amdgpu_device *adev, struct a
 	r = amdgpu_vm_map_range(adev, npa_vm, true, false, NULL,
 				npa_in_pages, npa_in_pages + size_in_pages - 1,
 				pte_flags, offset, 0, bo->tbo.resource, NULL,
-				&npa_vm->last_update);
+				NULL, &npa_vm->last_update);
 	if (r)
 		dev_dbg(adev->dev, "failed %d to unmap npa 0x%llx from NPA VM\n", r,
 			npa_in_pages << AMDGPU_GPU_PAGE_SHIFT);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 77ddb7fa96fb0..55bfe4eebc190 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1115,6 +1115,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
  * @vram_base: base for vram mappings
  * @res: ttm_resource to map
  * @pages_addr: DMA addresses to use for mapping
+ * @hmm_range: to check validity of DMA addresses
  * @fence: optional resulting fence
  *
  * Fill in the page table entries between @start and @last. Allocate and free
@@ -1128,7 +1129,9 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			struct amdgpu_sync *sync, uint64_t start,
 			uint64_t last, uint64_t flags, uint64_t offset,
 			uint64_t vram_base, struct ttm_resource *res,
-			dma_addr_t *pages_addr, struct dma_fence **fence)
+			dma_addr_t *pages_addr,
+			struct amdgpu_hmm_range *hmm_range,
+			struct dma_fence **fence)
 {
 	struct amdgpu_vm_tlb_seq_struct *tlb_cb;
 	struct amdgpu_vm_update_params params;
@@ -1161,6 +1164,7 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.adev = adev;
 	params.vm = vm;
 	params.pages_addr = pages_addr;
+	params.hmm_range = hmm_range;
 	params.needs_flush = flush_tlb;
 	params.override_pte = allow_override && adev->gmc.override_pte;
 	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
@@ -1463,7 +1467,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 		r = amdgpu_vm_map_range(adev, vm, flush_tlb, !uncached, &sync,
 					mapping->start, mapping->last,
 					update_flags, mapping->offset,
-					vram_base, mem, pages_addr,
+					vram_base, mem, pages_addr, NULL,
 					last_update);
 		if (r)
 			goto error_free;
@@ -1673,7 +1677,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 
 		r = amdgpu_vm_map_range(adev, vm, true, false,
 					&sync, mapping->start, mapping->last,
-					0, 0, 0, NULL, NULL, &f);
+					0, 0, 0, NULL, NULL, NULL, &f);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
 			dma_fence_put(f);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index a6f6541758609..9b07df5a2b816 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -469,7 +469,9 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			struct amdgpu_sync *sync, uint64_t start,
 			uint64_t last, uint64_t flags, uint64_t offset,
 			uint64_t vram_base, struct ttm_resource *res,
-			dma_addr_t *pages_addr, struct dma_fence **fence);
+			dma_addr_t *pages_addr,
+			struct amdgpu_hmm_range *hmm_range,
+			struct dma_fence **fence);
 int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			  bool unlocked, struct amdgpu_sync *sync,
 			  uint64_t start, uint64_t last,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
index db748e8b3bf38..8a0e5fcbd55ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -26,6 +26,7 @@
 
 #include <linux/types.h>
 #include <linux/list.h>
+#include "amdgpu_hmm.h"
 #include "amdgpu_vm.h"
 
 struct amdgpu_device;
@@ -72,6 +73,13 @@ struct amdgpu_vm_update_params {
 	 */
 	dma_addr_t *pages_addr;
 
+	/**
+	 * @hmm_range:
+	 *
+	 * Used to check the validity of pages_addr.
+	 */
+	struct amdgpu_hmm_range *hmm_range;
+
 	/**
 	 * @job: job to used for hw submission
 	 */
@@ -156,6 +164,8 @@ static inline int amdgpu_vm_begin_critical(struct amdgpu_vm_update_params *p)
 	p->saved_flags = memalloc_noreclaim_save();
 	if (p->vm->evicting)
 		return -EBUSY;
+	if (p->hmm_range && !amdgpu_hmm_range_valid(p->hmm_range))
+		return -EAGAIN;
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 263e68d29360d..8aebcfd58579b 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1465,7 +1465,8 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 static int
 svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 		     unsigned long offset, unsigned long npages, bool readonly,
-		     dma_addr_t *dma_addr, struct amdgpu_device *bo_adev,
+		     dma_addr_t *dma_addr, struct amdgpu_hmm_range *hmm_range,
+		     struct amdgpu_device *bo_adev,
 		     struct dma_fence **fence, bool flush_tlb)
 {
 	struct amdgpu_device *adev = pdd->dev->adev;
@@ -1525,7 +1526,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 					gpu_start, gpu_end, pte_flags,
 					(last_start - prange->start) << PAGE_SHIFT,
 					bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
-					NULL, dma_addr, &vm->last_update);
+					NULL, dma_addr, hmm_range, &vm->last_update);
 
 		for (j = last_start - prange->start; j <= i; j++)
 			dma_addr[j] |= last_domain;
@@ -1552,7 +1553,9 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 }
 
 static int
-svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
+svm_range_map_to_gpus(struct svm_range *prange,
+		      struct amdgpu_hmm_range *hmm_range,
+		      unsigned long offset,
 		      unsigned long npages, bool readonly,
 		      unsigned long *bitmap, bool wait, bool flush_tlb)
 {
@@ -1588,7 +1591,7 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 		set_bit(gpuidx, prange->bitmap_mapped);
 
 		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
-					 prange->dma_addr[gpuidx],
+					 prange->dma_addr[gpuidx], hmm_range,
 					 bo_adev, wait ? &fence : NULL,
 					 flush_tlb);
 		if (r)
@@ -1862,18 +1865,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
 		svm_range_lock(prange);
 
-		/* Free backing memory of hmm_range if it was initialized
-		 * Override return value to TRY AGAIN only if prior returns
-		 * were successful
-		 */
-		if (range && !amdgpu_hmm_range_valid(range) && !r) {
-			pr_debug("hmm update the range, need validate again\n");
-			r = -EAGAIN;
-		}
-
-		/* Free the hmm range */
-		amdgpu_hmm_range_free(range);
-
 		if (!r && !list_empty(&prange->child_list)) {
 			pr_debug("range split by unmap in parallel, validate again\n");
 			r = -EAGAIN;
@@ -1885,11 +1876,16 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 			if (map_start_vma <= map_last_vma) {
 				offset = map_start_vma - prange->start;
 				npages = map_last_vma - map_start_vma + 1;
-				r = svm_range_map_to_gpus(prange, offset, npages, readonly,
-							  ctx->bitmap, wait, flush_tlb);
+				r = svm_range_map_to_gpus(prange, range, offset,
+							  npages, readonly,
+							  ctx->bitmap, wait,
+							  flush_tlb);
 			}
 		}
 
+		/* Free the hmm range */
+		amdgpu_hmm_range_free(range);
+
 		if (!r && next == end)
 			prange->mapping_done = true;
 		else
-- 
2.43.0


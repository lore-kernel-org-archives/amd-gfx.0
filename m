Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AC9CCD6E4A
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 11:40:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1D1B10FDD1;
	Fri, 29 May 2026 11:40:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q6KB0yUA";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E52DF10FDD3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 11:40:48 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-45ef1629ff4so460758f8f.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 04:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780054847; x=1780659647; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LZeZXPG/3Kozt36SxNRifXvGvmOlZMKWedal0prCfW8=;
 b=Q6KB0yUAt1NZLaQvzZnzib6ufUgzFC+/DdbMpOA59lhT2XQ3E6utnUhVkhCLc6YYOt
 YO3rUDYnSTEKQGb/kQ8PDvKeSHeRhjvTeJRsdNJAKwXSiWNrTcE9GnA0cnSDQaH5p0bU
 A9g825Wifv/8f+j60UTpmUA3kzbKJLTpyT83m3LI38xxhYQCrin+mdEOuIwx+3sJRFeV
 50uqZRNdAmJob1HRhLsN6I6kQxVqCB/Yeqt6mJ3EniHdsyt0SjF5I5x/+4l8IfiLPRc3
 nS3qQgy9PilF2686cnBtxWZvVJ0u2cqmjzcLYSJ6XWkV7djBWsUdjgxqsN3z6M6vfQ+A
 zmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780054847; x=1780659647;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LZeZXPG/3Kozt36SxNRifXvGvmOlZMKWedal0prCfW8=;
 b=eVCq2X5U0cPF3Rx6WuCYlASMgii/hi8iK06SmI+CiGburbM++7CPGM7NvY8rw8a2qn
 +PtKl9vAGfVA0dL6oMf8D9UQj/wml3i6PMIBeZgBFhOqci1juAgAntwqvPq8XIL06Y25
 16g81R5notSYbAxIG/kheI59/0n+2MQhKR0XzbvBbY0GpCe2Q4ZObguFegJeR80Oki0p
 1WnwtrflB6nPB3YZNCp/y/Ndb2AZK05BvDhdaz9M35f0ZYxQaLlmJ+RQvOS1V7rn2Q/r
 0AXDU3tiCEFX3ZJXJMGy/2VyAwZglC/Jt0Sju0iuVsKhZ3yDic5gnWGo7qk4broAWInu
 0eig==
X-Gm-Message-State: AOJu0YyKCeiZkDvbbVvatspt5T9GVk3TcNxMcE5yEPnDtEYI/XSa+Q6/
 Cbqv1uScuA92P5KQUqQ/2sZN/OssPRVbHUt9mYyHTpp3nH4O/ZLt7I+EzPpfw3sxmPg=
X-Gm-Gg: Acq92OHnGWh7cDbgrwIYpcAoSwfqIoZmnc5PultdV4qkeCT0ay26WB3hB0S2ZI4ePFy
 biQQlpo2Z3vcbPogSjCVnUsy37VXKTqmeAlReql318sEjT5IcU7RswBfuqz2I/fMGhDgRW3ywsb
 fSoN+JXAtUqdff214cq2SsrHwBp6wY/1U4ahsdFgIBPFGki1PVpsdmGVMTai3K0W8YbmAKrMM6x
 oSCV64bNyQ15/ZmGmd/9W3Am8UubQ7Bt4wZl3CNavlPB+dY2nu/2c6b/GfpGtfkPM7QlGqm6z9Z
 F3LwkcquJH6XKEt1RkXhKYU7wFHP6i8t208A26dNW+4epU6T/rgfwgCm5I/irYOdkr/FM9yK9ZU
 aUUbM/R//OjuNlcOh7YzAYeeImk28+h3R3S/QcG6Z+zezRaSUkykAda4x/a58Q7FRlPidzfMJH/
 ywPuBDRvtY3fABxjmmxdxNyrmJKaaF5ZsWPXFwxO8d+rTEkV3KzpqWjg==
X-Received: by 2002:adf:f812:0:b0:45e:a225:6dfe with SMTP id
 ffacd0b85a97d-45ef143a472mr3225912f8f.25.1780054846854; 
 Fri, 29 May 2026 04:40:46 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1544:8100:da55:fa26:bd:a26])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cf0dsm2993109f8f.17.2026.05.29.04.40.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:40:46 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 13/13] drm/amdgpu: fix the HMM range handling for KFD SVM
Date: Fri, 29 May 2026 13:24:15 +0200
Message-ID: <20260529114031.3714-14-christian.koenig@amd.com>
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

It's mandatory that we have this check inside the VM handling or
otherwise page table allocation and filling PTEs doesn't work correctly.

This allows to remove the buggy SVM range lock, but that's not part of
this patch set.

Only compile tested!

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 10 ++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  4 ++-
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   | 10 ++++++
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          | 32 ++++++++-----------
 4 files changed, 34 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index d4e207db83c9..a368327cc025 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1093,6 +1093,7 @@ amdgpu_vm_tlb_flush(struct amdgpu_vm_update_params *params,
  * @vram_base: base for vram mappings
  * @res: ttm_resource to map
  * @pages_addr: DMA addresses to use for mapping
+ * @hmm_range: to check validity of DMA addresses
  * @fence: optional resulting fence
  *
  * Fill in the page table entries between @start and @last. Allocate and free
@@ -1106,7 +1107,9 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
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
@@ -1139,6 +1142,7 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	params.adev = adev;
 	params.vm = vm;
 	params.pages_addr = pages_addr;
+	params.hmm_range = hmm_range;
 	params.needs_flush = flush_tlb;
 	params.override_pte = allow_override && adev->gmc.override_pte;
 	INIT_LIST_HEAD(&params.tlb_flush_waitlist);
@@ -1432,7 +1436,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 		r = amdgpu_vm_map_range(adev, vm, flush_tlb, !uncached, &sync,
 					mapping->start, mapping->last,
 					update_flags, mapping->offset,
-					vram_base, mem, pages_addr,
+					vram_base, mem, pages_addr, NULL,
 					last_update);
 		if (r)
 			goto error_free;
@@ -1634,7 +1638,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 
 		r = amdgpu_vm_map_range(adev, vm, true, false,
 					&sync, mapping->start, mapping->last,
-					0, 0, 0, NULL, NULL, &f);
+					0, 0, 0, NULL, NULL, NULL, &f);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
 			dma_fence_put(f);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 7db3c3577949..ec1196d390bb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -459,7 +459,9 @@ int amdgpu_vm_map_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			struct amdgpu_sync *sync, uint64_t start,
 			uint64_t last, uint64_t flags, uint64_t offset,
 			uint64_t vram_base, struct ttm_resource *res,
-			dma_addr_t *pages_addr, struct dma_fence **fence);
+			dma_addr_t *pages_addr,
+			struct amdgpu_hmm_range *hmm_range,
+			struct dma_fence **fence);
 int amdgpu_vm_unmap_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 			   struct amdgpu_sync *sync, uint64_t start,
 			   uint64_t last, uint64_t flags,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
index 29c74920f3b0..d47951437f0d 100644
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
@@ -153,6 +161,8 @@ static inline int amdgpu_vm_begin_critical(struct amdgpu_vm_update_params *p)
 	p->saved_flags = memalloc_noreclaim_save();
 	if (p->vm->evicting)
 		return -EBUSY;
+	if (p->hmm_range && !amdgpu_hmm_range_valid(p->hmm_range))
+		return -EAGAIN;
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index d0ea20dea3e1..d506afff684e 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1432,7 +1432,8 @@ svm_range_unmap_from_gpus(struct svm_range *prange, unsigned long start,
 static int
 svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 		     unsigned long offset, unsigned long npages, bool readonly,
-		     dma_addr_t *dma_addr, struct amdgpu_device *bo_adev,
+		     dma_addr_t *dma_addr, struct amdgpu_hmm_range *hmm_range,
+		     struct amdgpu_device *bo_adev,
 		     struct dma_fence **fence, bool flush_tlb)
 {
 	struct amdgpu_device *adev = pdd->dev->adev;
@@ -1492,7 +1493,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 					gpu_start, gpu_end, pte_flags,
 					(last_start - prange->start) << PAGE_SHIFT,
 					bo_adev ? bo_adev->vm_manager.vram_base_offset : 0,
-					NULL, dma_addr, &vm->last_update);
+					NULL, dma_addr, hmm_range, &vm->last_update);
 
 		for (j = last_start - prange->start; j <= i; j++)
 			dma_addr[j] |= last_domain;
@@ -1519,7 +1520,9 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 }
 
 static int
-svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
+svm_range_map_to_gpus(struct svm_range *prange,
+		      struct amdgpu_hmm_range *hmm_range,
+		      unsigned long offset,
 		      unsigned long npages, bool readonly,
 		      unsigned long *bitmap, bool wait, bool flush_tlb)
 {
@@ -1553,7 +1556,7 @@ svm_range_map_to_gpus(struct svm_range *prange, unsigned long offset,
 		}
 
 		r = svm_range_map_to_gpu(pdd, prange, offset, npages, readonly,
-					 prange->dma_addr[gpuidx],
+					 prange->dma_addr[gpuidx], hmm_range,
 					 bo_adev, wait ? &fence : NULL,
 					 flush_tlb);
 		if (r)
@@ -1823,18 +1826,6 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
 
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
@@ -1846,11 +1837,16 @@ static int svm_range_validate_and_map(struct mm_struct *mm,
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
 			prange->mapped_to_gpu = true;
 
-- 
2.43.0


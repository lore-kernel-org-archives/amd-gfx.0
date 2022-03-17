Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15C3C433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Mar 2022 13:50:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FAC810EBD9;
	Thu, 17 Mar 2022 13:50:59 +0000 (UTC)
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com
 [IPv6:2a00:1450:4864:20::52d])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47A7210EBDD
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 13:50:56 +0000 (UTC)
Received: by mail-ed1-x52d.google.com with SMTP id h1so6630783edj.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Mar 2022 06:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=59qoJvuGUjV71L6q7/JpBFy4fO3JoTbBRUxAHWak26c=;
 b=XMzrGaAb+K+jfWdy0prVesvHBwdY6Lqf2eTsD5f3PpdnudEyMWnkzaCiz4ukd/Iq/9
 CFZYK/0huf4HGt2sAVLR3G7yC5VyjIadAEJa0WyqRWrfg+p3Tgwc4BhbQOWV2aVRNmWz
 MF7T12u/klLlyHeAvfEc5yb/f2p/8xznBj7kf38bVPeI//N1IbbUPBfib480G3zePAs4
 2disoNPkfcPFtkW619rctvGQyG9KmG23BWV+X7zlDXrYjxAnmjJsqgNjK7WZ4pdrynf1
 B2+br3NpD8Zgmn5Vv2MA9JEoIsKpHRULmGrRENrjYP4Iw+urg5QCtIzmSR2isMNdD5qT
 +1Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=59qoJvuGUjV71L6q7/JpBFy4fO3JoTbBRUxAHWak26c=;
 b=vDN39x7ZeurVS2sff8nO3BFRJfYfCXEbJU/Q5FOS0aGJs+F44kc/sN4DEldsGXr5E+
 Ov/X0rYGlQnhQbiPkdq8JxPbroiddithmeuet1iHONlMB5/kmXF5QIjSXPJs9FJybEX1
 kKWw8e8pHyGvhmvs7tPXVb26a+e6AkSwD5+4nCEJ3bWXDMLu0gURry3WMDcyIuGlSl34
 CefSeK20+vNgiVL40O0R+C4wgo7QqZ3Auu3vWaN0iYy5ydyVLurKK1gWIJCBux218E/e
 fcCPmaZvfZ8cUyMTU/0rCCNtyC+FuSD3gH3dX82SwkeXPgojuB2MEPd+cMEsgt/7PPH1
 8rcg==
X-Gm-Message-State: AOAM532fnkNSlvAnQRssEtXGN1WYdcb7wuoKeH7RtJ2rgU3ALYKw12Cd
 z9EDFpyBoD+TL1FaX7WfkyYRSEknNmY=
X-Google-Smtp-Source: ABdhPJx0FreXGomARNV6jXW7scOZUKiaVu4km5Hb+Wajq0TMzKnORYjuNrcTWygxkfoakKQ+PhRLSA==
X-Received: by 2002:a50:baa8:0:b0:415:b0bc:6353 with SMTP id
 x37-20020a50baa8000000b00415b0bc6353mr4672815ede.220.1647525054658; 
 Thu, 17 Mar 2022 06:50:54 -0700 (PDT)
Received: from able.fritz.box (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a056402254900b00416b0ec98b5sm2706721edb.45.2022.03.17.06.50.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Mar 2022 06:50:54 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Felix.Kuehling@amd.com
Subject: [PATCH 7/7] drm/amdgpu: remove table_freed param from the VM code
Date: Thu, 17 Mar 2022 14:50:44 +0100
Message-Id: <20220317135044.2099-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220317135044.2099-1-christian.koenig@amd.com>
References: <20220317135044.2099-1-christian.koenig@amd.com>
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Better to leave the decision when to flush the VM changes in the TLB to
the VM code.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        | 21 +++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        |  4 ++--
 drivers/gpu/drm/amd/amdkfd/kfd_svm.c          |  5 ++---
 6 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 57b521bb1eec..8b14c55a0793 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1104,7 +1104,7 @@ static int update_gpuvm_pte(struct kgd_mem *mem,
 		return ret;
 
 	/* Update the page tables  */
-	ret = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
+	ret = amdgpu_vm_bo_update(adev, bo_va, false);
 	if (ret) {
 		pr_err("amdgpu_vm_bo_update failed\n");
 		return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 2d4a89fb264e..62518c7b31c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -806,7 +806,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	r = amdgpu_vm_bo_update(adev, fpriv->prt_va, false, NULL);
+	r = amdgpu_vm_bo_update(adev, fpriv->prt_va, false);
 	if (r)
 		return r;
 
@@ -817,7 +817,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (amdgpu_mcbp || amdgpu_sriov_vf(adev)) {
 		bo_va = fpriv->csa_va;
 		BUG_ON(!bo_va);
-		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
+		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			return r;
 
@@ -836,7 +836,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		if (bo_va == NULL)
 			continue;
 
-		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
+		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			return r;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index bab6500728cb..2e16484bf606 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -618,7 +618,7 @@ static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 
 	if (operation == AMDGPU_VA_OP_MAP ||
 	    operation == AMDGPU_VA_OP_REPLACE) {
-		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
+		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			goto error;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a43302a86254..c29b12fec863 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -808,7 +808,6 @@ static void amdgpu_vm_tlb_seq_cb(struct dma_fence *fence,
  * @res: ttm_resource to map
  * @pages_addr: DMA addresses to use for mapping
  * @fence: optional resulting fence
- * @table_freed: return true if page table is freed
  *
  * Fill in the page table entries between @start and @last.
  *
@@ -823,8 +822,7 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 				uint64_t flags, uint64_t offset,
 				struct ttm_resource *res,
 				dma_addr_t *pages_addr,
-				struct dma_fence **fence,
-				bool *table_freed)
+				struct dma_fence **fence)
 {
 	struct amdgpu_vm_update_params params;
 	struct amdgpu_vm_tlb_seq_cb *tlb_cb;
@@ -937,9 +935,6 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 		tlb_cb = NULL;
 	}
 
-	if (table_freed)
-		*table_freed = *table_freed || params.table_freed;
-
 error_free:
 	kfree(tlb_cb);
 
@@ -999,7 +994,6 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
  * @adev: amdgpu_device pointer
  * @bo_va: requested BO and VM object
  * @clear: if true clear the entries
- * @table_freed: return true if page table is freed
  *
  * Fill in the page table entries for @bo_va.
  *
@@ -1007,7 +1001,7 @@ void amdgpu_vm_get_memory(struct amdgpu_vm *vm, uint64_t *vram_mem,
  * 0 for success, -EINVAL for failure.
  */
 int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
-			bool clear, bool *table_freed)
+			bool clear)
 {
 	struct amdgpu_bo *bo = bo_va->base.bo;
 	struct amdgpu_vm *vm = bo_va->base.vm;
@@ -1086,7 +1080,7 @@ int amdgpu_vm_bo_update(struct amdgpu_device *adev, struct amdgpu_bo_va *bo_va,
 						resv, mapping->start,
 						mapping->last, update_flags,
 						mapping->offset, mem,
-						pages_addr, last_update, table_freed);
+						pages_addr, last_update);
 		if (r)
 			return r;
 	}
@@ -1280,7 +1274,7 @@ int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
 		r = amdgpu_vm_bo_update_mapping(adev, adev, vm, false, false,
 						resv, mapping->start,
 						mapping->last, init_pte_value,
-						0, NULL, NULL, &f, NULL);
+						0, NULL, NULL, &f);
 		amdgpu_vm_free_mapping(adev, vm, mapping, f);
 		if (r) {
 			dma_fence_put(f);
@@ -1322,7 +1316,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 
 	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status) {
 		/* Per VM BOs never need to bo cleared in the page tables */
-		r = amdgpu_vm_bo_update(adev, bo_va, false, NULL);
+		r = amdgpu_vm_bo_update(adev, bo_va, false);
 		if (r)
 			return r;
 	}
@@ -1341,7 +1335,7 @@ int amdgpu_vm_handle_moved(struct amdgpu_device *adev,
 		else
 			clear = true;
 
-		r = amdgpu_vm_bo_update(adev, bo_va, clear, NULL);
+		r = amdgpu_vm_bo_update(adev, bo_va, clear);
 		if (r)
 			return r;
 
@@ -2525,8 +2519,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	}
 
 	r = amdgpu_vm_bo_update_mapping(adev, adev, vm, true, false, NULL, addr,
-					addr, flags, value, NULL, NULL, NULL,
-					NULL);
+					addr, flags, value, NULL, NULL, NULL);
 	if (r)
 		goto error_unlock;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 38a1eab1ff74..6b7682fe84f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -410,10 +410,10 @@ int amdgpu_vm_bo_update_mapping(struct amdgpu_device *adev,
 				uint64_t flags, uint64_t offset,
 				struct ttm_resource *res,
 				dma_addr_t *pages_addr,
-				struct dma_fence **fence, bool *free_table);
+				struct dma_fence **fence);
 int amdgpu_vm_bo_update(struct amdgpu_device *adev,
 			struct amdgpu_bo_va *bo_va,
-			bool clear, bool *table_freed);
+			bool clear);
 bool amdgpu_vm_evictable(struct amdgpu_bo *bo);
 void amdgpu_vm_bo_invalidate(struct amdgpu_device *adev,
 			     struct amdgpu_bo *bo, bool evicted);
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
index 509d915cbe69..1cb0d811dde0 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_svm.c
@@ -1190,7 +1190,7 @@ svm_range_unmap_from_gpu(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 
 	return amdgpu_vm_bo_update_mapping(adev, adev, vm, false, true, NULL,
 					   start, last, init_pte_value, 0,
-					   NULL, NULL, fence, NULL);
+					   NULL, NULL, fence);
 }
 
 static int
@@ -1283,8 +1283,7 @@ svm_range_map_to_gpu(struct kfd_process_device *pdd, struct svm_range *prange,
 						prange->start + i, pte_flags,
 						last_start - prange->start,
 						NULL, dma_addr,
-						&vm->last_update,
-						&table_freed);
+						&vm->last_update);
 
 		for (j = last_start - prange->start; j <= i; j++)
 			dma_addr[j] |= last_domain;
-- 
2.25.1


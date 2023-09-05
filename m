Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA3EC83F2C
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 06:04:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DDD910E427;
	Tue,  5 Sep 2023 06:04:23 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8A3D10E427
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 06:04:20 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52bca2e8563so2816745a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Sep 2023 23:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693893859; x=1694498659; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0pPH3cyj1McWNLsYePcGFbhWN6yJm+PweXasHPjB9hU=;
 b=E6tlQunRP/r5D3dMrnXkHILynCfghcHKKWMfKAmanZwJQP0nZpTIdrxIs1yygZizc0
 HjFVgAiVNDFsKGjAYIznmLYeXO0D+cWDyAfBONkdUxvhZqiwi0Eb5MPnj7f6CWUHQbdD
 joiW8HwJTbLPJrGX5eui7aN2a1HsacwUTyVebldJEnZw3+pVzpHgBt63vutHpKM2sWw1
 MhelAZ4xZVUnaKJONrMPkoi4DYaiVNxX04aqkSzAn839NK1g6QYjLq8rn3LFKgb+T8xx
 NEZr7VJrHpW0acUshR5qEQuZr27l0NxhcV/Bx1oNQgj6jAud9fshlcVHC5DtL9Bod/iO
 Nh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693893859; x=1694498659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0pPH3cyj1McWNLsYePcGFbhWN6yJm+PweXasHPjB9hU=;
 b=j95AE2h9fPbphJNCkbLRb65W/p+kAaOM+w/De97Mnhi3JBfzs+cGzVHfxRL6nFr1qG
 dOd3LNe7AnEvIFd0aQloXYs4RrQgY18ml3WZ+F0OtDYWWTF0vzxXvIb2sDq05+UtJ+tU
 ehsUbeCGD2lgWUccXN9nTD2KIJKUqC0htJVy3s73qxXc61xkFQiduvhTAHPeivyyCpuo
 6sTtJszw8LsplcmvFWeE+D+3gHDFTMJ4SOFn67wNyJgbQThECJhzBjX/QQxUkHk60sfO
 aEjs2OjpaUBGI2gIUKzS1lH8BHRu5YJiU/UvIcdnSc8jQx+pHl+EjyVOZ6hmRppLj7mi
 xMSw==
X-Gm-Message-State: AOJu0YzgHOnVbq0D64CHCfN0+sP1dgPVVocGyS635gTougIcniTfHKxp
 v/H2Jc9x5QrLTBegVmq9j8h18lpzC211aA==
X-Google-Smtp-Source: AGHT+IGKnb2nBVrvD9/e63LBUIvur0s6BdJ/qlSxu4xUujdpTvyWD06x6nXHaBpKNHcv4cnusarQoA==
X-Received: by 2002:aa7:dad2:0:b0:523:aef9:3b7b with SMTP id
 x18-20020aa7dad2000000b00523aef93b7bmr8954012eds.4.1693893859011; 
 Mon, 04 Sep 2023 23:04:19 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d9:7000:2f9d:c07d:1ee2:6439])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b0052a3b212157sm6631582edw.63.2023.09.04.23.04.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 23:04:18 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/11] drm/amdgpu: rework gmc_v10_0_flush_gpu_tlb
Date: Tue,  5 Sep 2023 08:04:06 +0200
Message-Id: <20230905060415.1400-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230905060415.1400-1-christian.koenig@amd.com>
References: <20230905060415.1400-1-christian.koenig@amd.com>
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
Cc: shashank.sharma@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Move the SDMA workaround necessary for Navi 1x into a higher layer.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  48 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |   5 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c |   3 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 159 ++++++-----------------
 4 files changed, 97 insertions(+), 118 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index d78bd9732543..857051093900 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -575,6 +575,54 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
 	return 0;
 }
 
+void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
+			      uint32_t vmhub, uint32_t flush_type)
+{
+	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
+	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
+	struct dma_fence *fence;
+	struct amdgpu_job *job;
+	int r;
+
+	if (!hub->sdma_invalidation_workaround || vmid ||
+	    !adev->mman.buffer_funcs_enabled ||
+	    !adev->ib_pool_ready || amdgpu_in_reset(adev) ||
+	    !ring->sched.ready) {
+		adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid, vmhub,
+						   flush_type);
+		return;
+	}
+
+	/* The SDMA on Navi 1x has a bug which can theoretically result in memory
+	 * corruption if an invalidation happens at the same time as an VA
+	 * translation. Avoid this by doing the invalidation from the SDMA
+	 * itself at least for GART.
+	 */
+	mutex_lock(&adev->mman.gtt_window_lock);
+	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.high_pr,
+				     AMDGPU_FENCE_OWNER_UNDEFINED,
+				     16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
+				     &job);
+	if (r)
+		goto error_alloc;
+
+	job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
+	job->vm_needs_flush = true;
+	job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
+	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
+	fence = amdgpu_job_submit(job);
+	mutex_unlock(&adev->mman.gtt_window_lock);
+
+	dma_fence_wait(fence, false);
+	dma_fence_put(fence);
+
+	return;
+
+error_alloc:
+	mutex_unlock(&adev->mman.gtt_window_lock);
+	DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
+}
+
 /**
  * amdgpu_gmc_tmz_set -- check and set if a device supports TMZ
  * @adev: amdgpu_device pointer
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index fdc25cd559b6..9e7df2f69123 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -117,6 +117,8 @@ struct amdgpu_vmhub {
 
 	uint32_t	vm_contexts_disable;
 
+	bool		sdma_invalidation_workaround;
+
 	const struct amdgpu_vmhub_funcs *vmhub_funcs;
 };
 
@@ -335,7 +337,6 @@ struct amdgpu_gmc {
 	u64 noretry_flags;
 };
 
-#define amdgpu_gmc_flush_gpu_tlb(adev, vmid, vmhub, type) ((adev)->gmc.gmc_funcs->flush_gpu_tlb((adev), (vmid), (vmhub), (type)))
 #define amdgpu_gmc_flush_gpu_tlb_pasid(adev, pasid, type, allhub, inst) \
 	((adev)->gmc.gmc_funcs->flush_gpu_tlb_pasid \
 	((adev), (pasid), (type), (allhub), (inst)))
@@ -401,6 +402,8 @@ int amdgpu_gmc_ras_sw_init(struct amdgpu_device *adev);
 int amdgpu_gmc_ras_late_init(struct amdgpu_device *adev);
 void amdgpu_gmc_ras_fini(struct amdgpu_device *adev);
 int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev);
+void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
+			      uint32_t vmhub, uint32_t flush_type);
 
 extern void amdgpu_gmc_tmz_set(struct amdgpu_device *adev);
 extern void amdgpu_gmc_noretry_set(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index a041c6c970e1..8521c45e8f38 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -471,6 +471,9 @@ static void gfxhub_v2_0_init(struct amdgpu_device *adev)
 		GCVM_CONTEXT1_CNTL__WRITE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK |
 		GCVM_CONTEXT1_CNTL__EXECUTE_PROTECTION_FAULT_ENABLE_INTERRUPT_MASK;
 
+	/* TODO: This is only needed on some Navi 1x revisions */
+	hub->sdma_invalidation_workaround = true;
+
 	hub->vmhub_funcs = &gfxhub_v2_0_vmhub_funcs;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index fa87a85e1017..1f70c57bcd69 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -230,20 +230,49 @@ static bool gmc_v10_0_get_atc_vmid_pasid_mapping_info(
  * by the amdgpu vm/hsa code.
  */
 
-static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
-				   unsigned int vmhub, uint32_t flush_type)
+/**
+ * gmc_v10_0_flush_gpu_tlb - gart tlb flush callback
+ *
+ * @adev: amdgpu_device pointer
+ * @vmid: vm instance to flush
+ * @vmhub: vmhub type
+ * @flush_type: the flush type
+ *
+ * Flush the TLB for the requested page table.
+ */
+static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
+					uint32_t vmhub, uint32_t flush_type)
 {
 	bool use_semaphore = gmc_v10_0_use_invalidate_semaphore(adev, vmhub);
 	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
 	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
-	u32 tmp;
 	/* Use register 17 for GART */
 	const unsigned int eng = 17;
-	unsigned int i;
 	unsigned char hub_ip = 0;
+	u32 sem, req, ack;
+	unsigned int i;
+	u32 tmp;
 
-	hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ?
-		   GC_HWIP : MMHUB_HWIP;
+	sem = hub->vm_inv_eng0_sem + hub->eng_distance * eng;
+	req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
+	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
+
+	/* flush hdp cache */
+	adev->hdp.funcs->flush_hdp(adev, NULL);
+
+	/* For SRIOV run time, driver shouldn't access the register through MMIO
+	 * Directly use kiq to do the vm invalidation instead
+	 */
+	if (adev->gfx.kiq[0].ring.sched.ready && !adev->enable_mes &&
+	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
+	    down_read_trylock(&adev->reset_domain->sem)) {
+		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
+				1 << vmid);
+		up_read(&adev->reset_domain->sem);
+		return;
+	}
+
+	hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ? GC_HWIP : MMHUB_HWIP;
 
 	spin_lock(&adev->gmc.invalidate_lock);
 	/*
@@ -257,9 +286,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	if (use_semaphore) {
 		for (i = 0; i < adev->usec_timeout; i++) {
 			/* a read return value of 1 means semaphore acuqire */
-			tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
-					 hub->eng_distance * eng, hub_ip);
-
+			tmp = RREG32_RLC_NO_KIQ(sem, hub_ip);
 			if (tmp & 0x1)
 				break;
 			udelay(1);
@@ -269,9 +296,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
 	}
 
-	WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req +
-			  hub->eng_distance * eng,
-			  inv_req, hub_ip);
+	WREG32_RLC_NO_KIQ(req, inv_req, hub_ip);
 
 	/*
 	 * Issue a dummy read to wait for the ACK register to be cleared
@@ -279,14 +304,11 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	 */
 	if ((vmhub == AMDGPU_GFXHUB(0)) &&
 	    (adev->ip_versions[GC_HWIP][0] < IP_VERSION(10, 3, 0)))
-		RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req +
-				  hub->eng_distance * eng, hub_ip);
+		RREG32_RLC_NO_KIQ(req, hub_ip);
 
 	/* Wait for ACK with a delay.*/
 	for (i = 0; i < adev->usec_timeout; i++) {
-		tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_ack +
-				  hub->eng_distance * eng, hub_ip);
-
+		tmp = RREG32_RLC_NO_KIQ(ack, hub_ip);
 		tmp &= 1 << vmid;
 		if (tmp)
 			break;
@@ -296,109 +318,12 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
 	if (use_semaphore)
-		/*
-		 * add semaphore release after invalidation,
-		 * write with 0 means semaphore release
-		 */
-		WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
-				  hub->eng_distance * eng, 0, hub_ip);
+		WREG32_RLC_NO_KIQ(sem, 0, hub_ip);
 
 	spin_unlock(&adev->gmc.invalidate_lock);
 
-	if (i < adev->usec_timeout)
-		return;
-
-	DRM_ERROR("Timeout waiting for VM flush hub: %d!\n", vmhub);
-}
-
-/**
- * gmc_v10_0_flush_gpu_tlb - gart tlb flush callback
- *
- * @adev: amdgpu_device pointer
- * @vmid: vm instance to flush
- * @vmhub: vmhub type
- * @flush_type: the flush type
- *
- * Flush the TLB for the requested page table.
- */
-static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
-					uint32_t vmhub, uint32_t flush_type)
-{
-	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
-	struct dma_fence *fence;
-	struct amdgpu_job *job;
-
-	int r;
-
-	/* flush hdp cache */
-	adev->hdp.funcs->flush_hdp(adev, NULL);
-
-	/* For SRIOV run time, driver shouldn't access the register through MMIO
-	 * Directly use kiq to do the vm invalidation instead
-	 */
-	if (adev->gfx.kiq[0].ring.sched.ready && !adev->enable_mes &&
-	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
-	    down_read_trylock(&adev->reset_domain->sem)) {
-		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
-		const unsigned int eng = 17;
-		u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
-		u32 req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
-		u32 ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
-
-		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
-				1 << vmid);
-
-		up_read(&adev->reset_domain->sem);
-		return;
-	}
-
-	mutex_lock(&adev->mman.gtt_window_lock);
-
-	if (vmhub == AMDGPU_MMHUB0(0)) {
-		gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_MMHUB0(0), 0);
-		mutex_unlock(&adev->mman.gtt_window_lock);
-		return;
-	}
-
-	BUG_ON(vmhub != AMDGPU_GFXHUB(0));
-
-	if (!adev->mman.buffer_funcs_enabled ||
-	    !adev->ib_pool_ready ||
-	    amdgpu_in_reset(adev) ||
-	    ring->sched.ready == false) {
-		gmc_v10_0_flush_vm_hub(adev, vmid, AMDGPU_GFXHUB(0), 0);
-		mutex_unlock(&adev->mman.gtt_window_lock);
-		return;
-	}
-
-	/* The SDMA on Navi has a bug which can theoretically result in memory
-	 * corruption if an invalidation happens at the same time as an VA
-	 * translation. Avoid this by doing the invalidation from the SDMA
-	 * itself.
-	 */
-	r = amdgpu_job_alloc_with_ib(ring->adev, &adev->mman.high_pr,
-				     AMDGPU_FENCE_OWNER_UNDEFINED,
-				     16 * 4, AMDGPU_IB_POOL_IMMEDIATE,
-				     &job);
-	if (r)
-		goto error_alloc;
-
-	job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
-	job->vm_needs_flush = true;
-	job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
-	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
-	fence = amdgpu_job_submit(job);
-
-	mutex_unlock(&adev->mman.gtt_window_lock);
-
-	dma_fence_wait(fence, false);
-	dma_fence_put(fence);
-
-	return;
-
-error_alloc:
-	mutex_unlock(&adev->mman.gtt_window_lock);
-	DRM_ERROR("Error flushing GPU TLB using the SDMA (%d)!\n", r);
+	if (i >= adev->usec_timeout)
+		DRM_ERROR("Timeout waiting for VM flush hub: %d!\n", vmhub);
 }
 
 /**
-- 
2.34.1


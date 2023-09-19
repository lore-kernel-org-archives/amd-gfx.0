Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D35CACD5BA2
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 12:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74E5210E37D;
	Tue, 19 Sep 2023 12:08:28 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F15BB10E1FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 12:08:25 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52c88a03f99so6497234a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 05:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695125304; x=1695730104; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=xaVpn93+6922B9Eqr2AT0gZ118e1GPSPxQdDlsu9XdI=;
 b=WNh7pfdaaC3VR1lYTD07lsqX77o6ykpkVpRwGV3mZ3wgmMgPXZCDQW+Z5IOcNYNy5n
 GtTmswZD5U3BBzbhL8VLjtZaIuS6+69jehSJc7CUHO0YpaX7Y9q23h7mrMoig99AwvvA
 odjTsrWF7QfuowjZrb4sJ3pE8U93ocM3J9+aUSPL3+ptBYqTNrZ6TrXVvklgC+q69WCM
 XsikxVp5f0XvkF1VbXMpwCbfbXfVh9+cz2Z+HEU3KYz9inTnGrS7tYabuK7r056RBE0f
 Mupm7A6Zy9zDJyCE6HUcy9rbqAph7VNl6XtOTQO46Aklxh2Ijk4MefD5OAWfJo/xgjnp
 DOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695125304; x=1695730104;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xaVpn93+6922B9Eqr2AT0gZ118e1GPSPxQdDlsu9XdI=;
 b=Cm/Rno2dThko7F+jeQjB3VrTqhdu/+pBEcxIZ/iVJgZMRkv5Oy1NWxWVithuRT5rUK
 y2+Vh9fxf4GWjG2DVUY8zlECcNJfFTu9dYbZ+vLH45nllon0dTas9Bmh4qwgneTTxy5n
 3a2jzFffSztSsDs4ifA2y/2MumS42e8C3woWwM7EiRFNWUulgRwpTJ6gNHpKFlYmU1EO
 5eoyjrnp0aCE8ASPOFmdFQF+OHMzsEJBDinWw4+DbZpEwSKPP4/R2lnotNhCE6RR2HRG
 zCOvOLR4ouvuK2T53LWfaRDXW6Cb2Yib7ZiL/fMMVZ7rHGPTXkmrVBgXB0YBMnP7Km2x
 SxlA==
X-Gm-Message-State: AOJu0YxpELe7vA5ut4vV5wd4viTNBJR32bmysqqKxuC861MWXfqeovzG
 Dj8lo3x3SriguiiatSIZW4Rb8Z0R5na36A==
X-Google-Smtp-Source: AGHT+IGYgh2itHgS7yv+SBeAt1BC+LznuDKYsT/elRcXM2pZL+UDBCy/i7ZKmYTrIo9r9TDiaNEmuw==
X-Received: by 2002:aa7:db56:0:b0:52b:d169:b373 with SMTP id
 n22-20020aa7db56000000b0052bd169b373mr8934321edt.32.1695125304332; 
 Tue, 19 Sep 2023 05:08:24 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15bc:9900:21a0:f69e:f2eb:dcf5])
 by smtp.gmail.com with ESMTPSA id
 q5-20020aa7cc05000000b0052a1a623267sm7283100edt.62.2023.09.19.05.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 05:08:23 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: felix.kuehling@amd.com, alexdeucher@gmail.com, shashank.sharma@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/11] drm/amdgpu: rework gmc_v10_0_flush_gpu_tlb v2
Date: Tue, 19 Sep 2023 14:08:13 +0200
Message-Id: <20230919120822.95241-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919120822.95241-1-christian.koenig@amd.com>
References: <20230919120822.95241-1-christian.koenig@amd.com>
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

Move the SDMA workaround necessary for Navi 1x into a higher layer.

v2: use dev_err

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c  |  48 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h  |   5 +-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c |   3 +
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c   | 160 ++++++-----------------
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c   |   2 +-
 5 files changed, 99 insertions(+), 119 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c7793db6d098..7db2884ceb3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -579,6 +579,54 @@ int amdgpu_gmc_allocate_vm_inv_eng(struct amdgpu_device *adev)
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
+	dev_err(adev->dev, "Error flushing GPU TLB using the SDMA (%d)!\n", r);
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
index e582073b57c8..70c953919089 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -231,20 +231,49 @@ static bool gmc_v10_0_get_atc_vmid_pasid_mapping_info(
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
@@ -258,9 +287,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
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
@@ -270,9 +297,7 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
 	}
 
-	WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req +
-			  hub->eng_distance * eng,
-			  inv_req, hub_ip);
+	WREG32_RLC_NO_KIQ(req, inv_req, hub_ip);
 
 	/*
 	 * Issue a dummy read to wait for the ACK register to be cleared
@@ -280,14 +305,11 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	 */
 	if ((vmhub == AMDGPU_GFXHUB(0)) &&
 	    (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(10, 3, 0)))
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
@@ -297,109 +319,13 @@ static void gmc_v10_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 
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
+		dev_err(adev->dev, "Timeout waiting for VM flush hub: %d!\n",
+			vmhub);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 69f65e9c4f93..f9c1ff2d940b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -271,7 +271,7 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	if (i < adev->usec_timeout)
 		return;
 
-	DRM_ERROR("Timeout waiting for VM flush ACK!\n");
+	dev_err(adev->dev, "Timeout waiting for VM flush ACK!\n");
 }
 
 /**
-- 
2.34.1


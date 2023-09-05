Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC414CA0FF7
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 06:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9DFCD10E431;
	Tue,  5 Sep 2023 06:04:28 +0000 (UTC)
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com
 [IPv6:2a00:1450:4864:20::52b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EE9F10E430
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 06:04:26 +0000 (UTC)
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-52683da3f5cso2841947a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Sep 2023 23:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693893865; x=1694498665; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z1MyhwOqh9zSUUKbbtGu9/nFtfkitCIsRLIwLxwq+0s=;
 b=pSE6vBi/K9UFfN8+GgEEJ8XKxs97IKJa9KyiSEyVryNLx7VWKcBSspXh7UqasX2V0y
 lO/mvTvD1sWqIK0BQefk2OElOHOiDoUcFac2mKu2uQc2fEMGYsdwx7fdwDIzV+Foya6O
 9Jj7zs3s5axNTmqJdAda6ateZ8kEspgAr90gB5ubrot4eI+dvamlr2R1GjhAGkbHm67Y
 1GrBOwtEWnH1Bjy0Xl3gRcnqQDRWoZf7lG1EinLwAeob0MYx+kj8o7+cuhV1wghznjAS
 F+0BKp/3CeWP308ks6A7ALZ20cleJpVk9XY/wcYPGjybCnCCuMVshVJNhbxVaiBytYA5
 PIXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693893865; x=1694498665;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=z1MyhwOqh9zSUUKbbtGu9/nFtfkitCIsRLIwLxwq+0s=;
 b=e4JOmtnutGExILuBmj/sLcexbpd/MmUQMtHLGUx6nWXsOFoB4Wq4oRv1pdMeS6JeIc
 EuzH9M6NuqQ5ISHTvAOS7oeVOwVAAML8rlGxQuQ3GtWspsPchnDLGbw9kQgWpuKmC/7N
 PhGECAbdA0o5zJBcXUjzw4McvTNvAz2fe7lAMAFPcYdzaWw2YQmRxYs8BOdh/JuJImmH
 h5l8zOAd1LZI11/u2D6XUK3vwJn1zmHBhQBa4mPEQDbl/q1p/Qz4tGHopms5eijrF+HO
 HKWz/RvhfnwPGKwRo+8t/Vhe4/rDGMdw+habYKTbLLsa5ezbiSAQ5OxV1DeRbbT4/sEt
 6zPw==
X-Gm-Message-State: AOJu0YzssX1AZ/l5meW6+/XkI7hZwfRy/blpQX+DlPGUZPRrQ4DxSyi+
 NDAVfjxNhDNmREKv7yEn//r1+ecjUpAH+MHv
X-Google-Smtp-Source: AGHT+IH3FGZ4OyiantGosdY0SDqR6l5/adZMsGZReeU6GKGFnLhWjxRrfHQDGfgnjrJjwyXzzgIG5Q==
X-Received: by 2002:aa7:d603:0:b0:523:4922:c9c4 with SMTP id
 c3-20020aa7d603000000b005234922c9c4mr9870007edr.11.1693893864782; 
 Mon, 04 Sep 2023 23:04:24 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d9:7000:2f9d:c07d:1ee2:6439])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b0052a3b212157sm6631582edw.63.2023.09.04.23.04.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 23:04:24 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/11] drm/amdgpu: further move TLB hw workarounds a layer up
Date: Tue,  5 Sep 2023 08:04:15 +0200
Message-Id: <20230905060415.1400-12-christian.koenig@amd.com>
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

For the PASID flushing we already handled that at a higher layer, apply
those workarounds to the standard flush as well.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 19 +++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 74 ++++++++-----------------
 2 files changed, 42 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index c24252304d48..8a5381ca7713 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -597,6 +597,14 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		if(!down_read_trylock(&adev->reset_domain->sem))
 			return;
 
+		if (adev->gmc.flush_tlb_needs_extra_type_2)
+			adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid,
+							   vmhub, 2);
+
+		if (adev->gmc.flush_tlb_needs_extra_type_0 && flush_type == 2)
+			adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid,
+							   vmhub, 0);
+
 		adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid, vmhub,
 						   flush_type);
 		up_read(&adev->reset_domain->sem);
@@ -647,6 +655,17 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 
 	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready ||
 	    !down_read_trylock(&adev->reset_domain->sem)) {
+
+		if (adev->gmc.flush_tlb_needs_extra_type_2)
+			adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
+								 2, all_hub,
+								 inst);
+
+		if (adev->gmc.flush_tlb_needs_extra_type_0 && flush_type == 2)
+			adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
+								 0, all_hub,
+								 inst);
+
 		adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
 							 flush_type, all_hub,
 							 inst);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index c5df8f052f3f..a1a6f4b63208 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -812,37 +812,18 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 					uint32_t vmhub, uint32_t flush_type)
 {
 	bool use_semaphore = gmc_v9_0_use_invalidate_semaphore(adev, vmhub);
-	u32 j, inv_req, inv_req2, tmp, sem, req, ack;
+	u32 j, inv_req, tmp, sem, req, ack;
 	const unsigned int eng = 17;
 	struct amdgpu_vmhub *hub;
 
 	BUG_ON(vmhub >= AMDGPU_MAX_VMHUBS);
 
 	hub = &adev->vmhub[vmhub];
+	inv_req = gmc_v9_0_get_invalidate_req(vmid, flush_type);
 	sem = hub->vm_inv_eng0_sem + hub->eng_distance * eng;
 	req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
 	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
-	if (adev->gmc.xgmi.num_physical_nodes &&
-	    adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 0)) {
-		/* Vega20+XGMI caches PTEs in TC and TLB. Add a
-		 * heavy-weight TLB flush (type 2), which flushes
-		 * both. Due to a race condition with concurrent
-		 * memory accesses using the same TLB cache line, we
-		 * still need a second TLB flush after this.
-		 */
-		inv_req = gmc_v9_0_get_invalidate_req(vmid, 2);
-		inv_req2 = gmc_v9_0_get_invalidate_req(vmid, flush_type);
-	} else if (flush_type == 2 &&
-		   adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 3) &&
-		   adev->rev_id == 0) {
-		inv_req = gmc_v9_0_get_invalidate_req(vmid, 0);
-		inv_req2 = gmc_v9_0_get_invalidate_req(vmid, flush_type);
-	} else {
-		inv_req = gmc_v9_0_get_invalidate_req(vmid, flush_type);
-		inv_req2 = 0;
-	}
-
 	/* This is necessary for a HW workaround under SRIOV as well
 	 * as GFXOFF under bare metal
 	 */
@@ -853,10 +834,6 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
 						   1 << vmid);
-		if (inv_req2)
-			amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack,
-							   inv_req2, 1 << vmid);
-
 		return;
 	}
 
@@ -886,34 +863,29 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
 	}
 
-	do {
-		if (vmhub >= AMDGPU_MMHUB0(0))
-			WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req);
-		else
-			WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req);
-
-		/*
-		 * Issue a dummy read to wait for the ACK register to
-		 * be cleared to avoid a false ACK due to the new fast
-		 * GRBM interface.
-		 */
-		if ((vmhub == AMDGPU_GFXHUB(0)) &&
-		    (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 4, 2)))
-			RREG32_NO_KIQ(req);
+	if (vmhub >= AMDGPU_MMHUB0(0))
+		WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req);
+	else
+		WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req);
 
-		for (j = 0; j < adev->usec_timeout; j++) {
-			if (vmhub >= AMDGPU_MMHUB0(0))
-				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack);
-			else
-				tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack);
-			if (tmp & (1 << vmid))
-				break;
-			udelay(1);
-		}
+	/*
+	 * Issue a dummy read to wait for the ACK register to
+	 * be cleared to avoid a false ACK due to the new fast
+	 * GRBM interface.
+	 */
+	if ((vmhub == AMDGPU_GFXHUB(0)) &&
+	    (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 4, 2)))
+		RREG32_NO_KIQ(req);
 
-		inv_req = inv_req2;
-		inv_req2 = 0;
-	} while (inv_req);
+	for (j = 0; j < adev->usec_timeout; j++) {
+		if (vmhub >= AMDGPU_MMHUB0(0))
+			tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack);
+		else
+			tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack);
+		if (tmp & (1 << vmid))
+			break;
+		udelay(1);
+	}
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
 	if (use_semaphore) {
-- 
2.34.1


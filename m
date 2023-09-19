Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93831CD5BA4
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 12:08:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF60F10E399;
	Tue, 19 Sep 2023 12:08:33 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com
 [IPv6:2a00:1450:4864:20::135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47F6E10E262
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 12:08:27 +0000 (UTC)
Received: by mail-lf1-x135.google.com with SMTP id
 2adb3069b0e04-50317080342so3444271e87.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 05:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695125305; x=1695730105; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=zAxj0yEQBDAZfUpcW8kKTSs2BE0ewWpIy/w2/Z4KrQU=;
 b=VFCyirayxnSo35ptPiVehOC/uuyw+MPKExb3d11pcUyNWUJ3txbHbrH35yXnC/Xhth
 2fsx9+cRvrzGAd9djLNd+DYUkRa2GfjmAuLn+wHn4qWP1o+CBkiSRhUC4mlIRX1vDnBu
 cAJkCY/4d+6HwG7Xte9kbsgu7F+jBHEUSQZE7MxfEBmJV8GzBU3nRQRYVIUPWFZQOCwF
 B9xdlSL4LxnrVVcl0/jfy/FCwpdlb08rkE9cbl2x18o1agHa1tP+D0DOhE+b9KRpf96L
 IW23CUC0ghD3YCTHxD/RpizYIh8a3HS30IDQQ00Ca4S33MFVJN+yWu/NxCnW4ybzyLh2
 j0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695125305; x=1695730105;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zAxj0yEQBDAZfUpcW8kKTSs2BE0ewWpIy/w2/Z4KrQU=;
 b=ScZQxlCTAZBS8gNtAVzXHeKcmVz2Z2Ods+Pl8ltHJjPdcrtLYx1SKaXkFjevfDF1wU
 PsVoWCqoN8pUPwj7iMevp0dZoGsROvfSpWA6bsojCXhx3d1W5d6GWQAT13B75Fvi+six
 +tRyiw6pcGlegegqzWYMJy1dHY2WqUg1f5EUSEqLnvGLXehIz4tFaRvPSjxNkjGIHsW2
 cY51GFIhokPooUwm1Nxm/NZVYZJy/hE8DfHbP9kDwvp+r7/lVK/ktI1Xo3fmRglRYmYd
 n6iW2Y+qTZzUcoX548DKMCAXnfDSkruxrPpVzQRdZzCRDVo0kB4NB83bK2yRqysevRwU
 R5Uw==
X-Gm-Message-State: AOJu0YzGbrlfilyIQMk/72JaMBq9wdsqU6V/THK1Ozl0ZJMUqRjFxe3j
 6aQuNF+gifWs7ZdYw15Tugk=
X-Google-Smtp-Source: AGHT+IEuQDKwIzqXt31WuHnmFNJrK17nI2EKB9Jv1PBB4ccovp/ouVkOzg5flpU1ldeLrPkEMoZyhw==
X-Received: by 2002:a05:6512:238b:b0:4fe:c98:789a with SMTP id
 c11-20020a056512238b00b004fe0c98789amr13838473lfv.37.1695125305005; 
 Tue, 19 Sep 2023 05:08:25 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15bc:9900:21a0:f69e:f2eb:dcf5])
 by smtp.gmail.com with ESMTPSA id
 q5-20020aa7cc05000000b0052a1a623267sm7283100edt.62.2023.09.19.05.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 05:08:24 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: felix.kuehling@amd.com, alexdeucher@gmail.com, shashank.sharma@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/11] drm/amdgpu: cleanup gmc_v11_0_flush_gpu_tlb
Date: Tue, 19 Sep 2023 14:08:14 +0200
Message-Id: <20230919120822.95241-3-christian.koenig@amd.com>
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

Remove leftovers from copying this from the gmc v10 code.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 108 ++++++++++---------------
 1 file changed, 41 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index f9c1ff2d940b..b2de44e811cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -186,27 +186,50 @@ static bool gmc_v11_0_get_vmid_pasid_mapping_info(
 	return !!(*p_pasid);
 }
 
-/*
- * GART
- * VMID 0 is the physical GPU addresses as used by the kernel.
- * VMIDs 1-15 are used for userspace clients and are handled
- * by the amdgpu vm/hsa code.
+/**
+ * gmc_v11_0_flush_gpu_tlb - gart tlb flush callback
+ *
+ * @adev: amdgpu_device pointer
+ * @vmid: vm instance to flush
+ * @vmhub: which hub to flush
+ * @flush_type: the flush type
+ *
+ * Flush the TLB for the requested page table.
  */
-
-static void gmc_v11_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
-				   unsigned int vmhub, uint32_t flush_type)
+static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
+					uint32_t vmhub, uint32_t flush_type)
 {
 	bool use_semaphore = gmc_v11_0_use_invalidate_semaphore(adev, vmhub);
 	struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
 	u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
-	u32 tmp;
 	/* Use register 17 for GART */
 	const unsigned int eng = 17;
+	unsigned char hub_ip;
+	u32 sem, req, ack;
 	unsigned int i;
-	unsigned char hub_ip = 0;
+	u32 tmp;
+
+	if ((vmhub == AMDGPU_GFXHUB(0)) && !adev->gfx.is_poweron)
+		return;
 
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
+	if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring.sched.ready) &&
+	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
+		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
+				1 << vmid);
+		return;
+	}
+
+	hub_ip = (vmhub == AMDGPU_GFXHUB(0)) ? GC_HWIP : MMHUB_HWIP;
 
 	spin_lock(&adev->gmc.invalidate_lock);
 	/*
@@ -220,8 +243,7 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 	if (use_semaphore) {
 		for (i = 0; i < adev->usec_timeout; i++) {
 			/* a read return value of 1 means semaphore acuqire */
-			tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
-					    hub->eng_distance * eng, hub_ip);
+			tmp = RREG32_RLC_NO_KIQ(sem, hub_ip);
 			if (tmp & 0x1)
 				break;
 			udelay(1);
@@ -231,12 +253,11 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 			DRM_ERROR("Timeout waiting for sem acquire in VM flush!\n");
 	}
 
-	WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req, hub_ip);
+	WREG32_RLC_NO_KIQ(req, inv_req, hub_ip);
 
 	/* Wait for ACK with a delay.*/
 	for (i = 0; i < adev->usec_timeout; i++) {
-		tmp = RREG32_RLC_NO_KIQ(hub->vm_inv_eng0_ack +
-				    hub->eng_distance * eng, hub_ip);
+		tmp = RREG32_RLC_NO_KIQ(ack, hub_ip);
 		tmp &= 1 << vmid;
 		if (tmp)
 			break;
@@ -246,12 +267,7 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 
 	/* TODO: It needs to continue working on debugging with semaphore for GFXHUB as well. */
 	if (use_semaphore)
-		/*
-		 * add semaphore release after invalidation,
-		 * write with 0 means semaphore release
-		 */
-		WREG32_RLC_NO_KIQ(hub->vm_inv_eng0_sem +
-			      hub->eng_distance * eng, 0, hub_ip);
+		WREG32_RLC_NO_KIQ(sem, 0, hub_ip);
 
 	/* Issue additional private vm invalidation to MMHUB */
 	if ((vmhub != AMDGPU_GFXHUB(0)) &&
@@ -268,50 +284,8 @@ static void gmc_v11_0_flush_vm_hub(struct amdgpu_device *adev, uint32_t vmid,
 
 	spin_unlock(&adev->gmc.invalidate_lock);
 
-	if (i < adev->usec_timeout)
-		return;
-
-	dev_err(adev->dev, "Timeout waiting for VM flush ACK!\n");
-}
-
-/**
- * gmc_v11_0_flush_gpu_tlb - gart tlb flush callback
- *
- * @adev: amdgpu_device pointer
- * @vmid: vm instance to flush
- * @vmhub: which hub to flush
- * @flush_type: the flush type
- *
- * Flush the TLB for the requested page table.
- */
-static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
-					uint32_t vmhub, uint32_t flush_type)
-{
-	if ((vmhub == AMDGPU_GFXHUB(0)) && !adev->gfx.is_poweron)
-		return;
-
-	/* flush hdp cache */
-	adev->hdp.funcs->flush_hdp(adev, NULL);
-
-	/* For SRIOV run time, driver shouldn't access the register through MMIO
-	 * Directly use kiq to do the vm invalidation instead
-	 */
-	if ((adev->gfx.kiq[0].ring.sched.ready || adev->mes.ring.sched.ready) &&
-	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
-		struct amdgpu_vmhub *hub = &adev->vmhub[vmhub];
-		const unsigned int eng = 17;
-		u32 inv_req = hub->vmhub_funcs->get_invalidate_req(vmid, flush_type);
-		u32 req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
-		u32 ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
-
-		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
-				1 << vmid);
-		return;
-	}
-
-	mutex_lock(&adev->mman.gtt_window_lock);
-	gmc_v11_0_flush_vm_hub(adev, vmid, vmhub, 0);
-	mutex_unlock(&adev->mman.gtt_window_lock);
+	if (i >= adev->usec_timeout)
+		dev_err(adev->dev, "Timeout waiting for VM flush ACK!\n");
 }
 
 /**
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B396DC83F33
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 06:04:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7041C10E428;
	Tue,  5 Sep 2023 06:04:23 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com
 [IPv6:2a00:1450:4864:20::530])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CA9E10E427
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 06:04:21 +0000 (UTC)
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-52bcd4db4e6so2826321a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Sep 2023 23:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693893860; x=1694498660; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LTFSRALKhJkxQ1FEqn2+w0oSiMeMQ5U0Zi0e1Rpojmg=;
 b=kOQ2m4YZcysVUOGY8g48DGz7JFwBWv2NcxJB9FV/JZYdWfBtNbZounboPYFxqBnlHP
 /94WCC8f4fR05z3PrmjOSOCWb/SY+iZcFlA4K8Ot6cUA32XLaAe7KOVLQHM+X15YVLW2
 i3CdKYl/YkjvfyXRU0emfAVr/Bmu7y94wvAKAr3/tz79mbEN3ApDBkxggNLJ1lx43GbD
 vb363JJ+93u6EPdIkunjE1hZRypXl7hpkSv809h2atRMOzizreYCMPrWZZdmdFH2uOqU
 xwRM5RPPouLV5WovBqUnIQUsAb/tBI3GuvzbuZuXlOrdb3nzQQLH0RsObrvGA0l1yJ87
 VRcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693893860; x=1694498660;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LTFSRALKhJkxQ1FEqn2+w0oSiMeMQ5U0Zi0e1Rpojmg=;
 b=WaQytDIwbgLjjM6gw9Op2kdkrw+hJ27SODkpaKwAHFJ9BinJTtKExeyyg+1ZhaonwL
 XxFKb4MFvoWgEY1N7VYcCAPlurewU4jfKFXvy1mZ49tFyPB/TLNE6F6f76a1YAA/5TR1
 Fj6KtyS/LGjAhqA/pPD37BUHD0xQh4lNUzPElMGW+XfilBUWD41ZR2mqnp5Ukm1OzGf4
 P/3uuKqAROvgITvcTNqp26vmCbvZgVhsFpNbyhVrSW61AVpb+cA/H6A0AX5f13aonyoe
 wPQ71zTXga2KaiUungP9d7RCsA2IC6LYeFsQwM5zaN+ozoA6OIGY707kheYsJ7zVek3G
 yvGA==
X-Gm-Message-State: AOJu0Yz48/Mbaz7W2vftwbbzq9vqpaXVpkUZ/vQDn9zucbNRd1VZTnFa
 eFw9v+9SsmRPq9phVZOMyI231zxv9dj7ew==
X-Google-Smtp-Source: AGHT+IFA/UXbxdIJkq/cj8cwrJ6NZ8OCrRZN7vYn2DElIH7TYGEDgpdKM2CA22dQiu5NiPMOzZQjDA==
X-Received: by 2002:a05:6402:1ac7:b0:522:1d1d:1de8 with SMTP id
 ba7-20020a0564021ac700b005221d1d1de8mr7147326edb.2.1693893859632; 
 Mon, 04 Sep 2023 23:04:19 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d9:7000:2f9d:c07d:1ee2:6439])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b0052a3b212157sm6631582edw.63.2023.09.04.23.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 23:04:19 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/11] drm/amdgpu: cleanup gmc_v11_0_flush_gpu_tlb
Date: Tue,  5 Sep 2023 08:04:07 +0200
Message-Id: <20230905060415.1400-4-christian.koenig@amd.com>
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

Remove leftovers from copying this from the gmc v10 code.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c | 108 ++++++++++---------------
 1 file changed, 41 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index dcbba981462e..3c3ad3f17c6a 100644
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
-	DRM_ERROR("Timeout waiting for VM flush ACK!\n");
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
+		DRM_ERROR("Timeout waiting for VM flush ACK!\n");
 }
 
 /**
-- 
2.34.1


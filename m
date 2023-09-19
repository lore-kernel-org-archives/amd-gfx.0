Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41AB6CD5BA8
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 12:08:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B53010E3A6;
	Tue, 19 Sep 2023 12:08:47 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4C7010E399
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 12:08:32 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-532aaba8747so1337456a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 05:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695125311; x=1695730111; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=pJsGUMusQcL2Op+zLbc8x0bVz3w2XJ4XJX4nO+4s1Ow=;
 b=Qsq4sY8lV7oofaHwwYzQwqD7wVTYTEZRxtw0zx+Io6zcqNJ6QnGgDEglbKQ00AJXcG
 1wriIiEkl2EXdPF/T4cU5x8RT8Y4a5yyB86swJRvhf9YvUTNgFHU7F/HTaB2jTa2ZWTF
 IisQkfcqx2INpRDdJNPGLLCj+adqNh4W6mi6+1JXwLRuNoVAzS35FO+XVdF9rMZVB6HC
 4rVYUeW5IBJHQjYbsL44G9cuC33h/hbV1OBFpXLn7X050ZJRBgJjIt0YQRr7iRTuFW8e
 FTQR+ICoS9QTXAZlGjoAFaSlCEUUrdMV97i6NLtvnD0/qK/e+yxwWYu6QyKYHCkqwcIT
 Oihg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695125311; x=1695730111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pJsGUMusQcL2Op+zLbc8x0bVz3w2XJ4XJX4nO+4s1Ow=;
 b=IJ2lBdTkPIZLTD1W/+skq7M5I2d0fRyco2oNC6NTgcyPEn0tMfs9P53srnWCV/SxUN
 rmkYtx0QJie0FXEixcISeQiQwDFqmr54xDD9EHbI3r83qBs9W6tezZrAF3C3mvF4ajy4
 CGrSjmcWxCF0lmmFTkhf0I2k8MjYSo00kVnSYCMnJgqoMqF/UI9rkNUUWywTaPWyN0Cr
 X6BuJGKP8ncIx6yb6wEMvR25sf+aBQQvjTAlfsRN+JShZ541x+133Z9jr1cbtRMm9cED
 a+rxDrn58YQe4exkKKTDWCeZiuJq1lCHDK4ctPLTFqWUDniCid6PN3Z2dv1YrjDw5yqD
 I/TQ==
X-Gm-Message-State: AOJu0Ywnf0bh1/vGRbPuwsibtp1KFl6kGoXFn52tk6/MrxjehgpzfPTG
 jGHGelJ9dktc4RuhDz0DdSI=
X-Google-Smtp-Source: AGHT+IEfEwkvWhJsETYmCS57xsZBDkgKEdZU6GILr/WU1ifgqhpSR4FL5LKrgMpa+LR8/nZ+QD7btA==
X-Received: by 2002:aa7:d394:0:b0:525:691c:cd50 with SMTP id
 x20-20020aa7d394000000b00525691ccd50mr11447008edq.24.1695125311392; 
 Tue, 19 Sep 2023 05:08:31 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15bc:9900:21a0:f69e:f2eb:dcf5])
 by smtp.gmail.com with ESMTPSA id
 q5-20020aa7cc05000000b0052a1a623267sm7283100edt.62.2023.09.19.05.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 05:08:30 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: felix.kuehling@amd.com, alexdeucher@gmail.com, shashank.sharma@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/11] drm/amdgpu: further move TLB hw workarounds a layer up
Date: Tue, 19 Sep 2023 14:08:22 +0200
Message-Id: <20230919120822.95241-11-christian.koenig@amd.com>
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

For the PASID flushing we already handled that at a higher layer, apply
those workarounds to the standard flush as well.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 19 +++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 74 ++++++++-----------------
 2 files changed, 42 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index b074dc75f59f..ff65f7fee1df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -601,6 +601,14 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		if (!down_read_trylock(&adev->reset_domain->sem))
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
@@ -651,6 +659,17 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 
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
index adb38698eac7..ba75ed60f8ba 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -814,37 +814,18 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
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
-	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 0)) {
-		/* Vega20+XGMI caches PTEs in TC and TLB. Add a
-		 * heavy-weight TLB flush (type 2), which flushes
-		 * both. Due to a race condition with concurrent
-		 * memory accesses using the same TLB cache line, we
-		 * still need a second TLB flush after this.
-		 */
-		inv_req = gmc_v9_0_get_invalidate_req(vmid, 2);
-		inv_req2 = gmc_v9_0_get_invalidate_req(vmid, flush_type);
-	} else if (flush_type == 2 &&
-		   amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 3) &&
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
@@ -855,10 +836,6 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
 						   1 << vmid);
-		if (inv_req2)
-			amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack,
-							   inv_req2, 1 << vmid);
-
 		return;
 	}
 
@@ -888,34 +865,29 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
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
-		    (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 4, 2)))
-			RREG32_SOC15_IP_NO_KIQ(GC, req);
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


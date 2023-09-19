Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F922CD5BA5
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 12:08:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 866FB10E1FD;
	Tue, 19 Sep 2023 12:08:26 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com
 [IPv6:2a00:1450:4864:20::535])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FD7C10E1FD
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 12:08:25 +0000 (UTC)
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-530ea522f5eso2939365a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 05:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695125304; x=1695730104; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=iL+ruvnDDy5a4jeyKTDidCtFpCTdEKVq01EzWhj+Yf0=;
 b=FTISrWMEpdw0PXcCmI0T9yKpKU175TxFWa9TeRl5COfsilcluC/atFzUWrSs6rhFiH
 k7/dj8CvRCiw1PrPtRAH51L/p3i19zxWX2bF4rwAMWaGKaa5JUqlRPxxNnCR8CvQcFw+
 Gyk8cRiU0Fg3zvfOnfWxXNbEGxKYmpHvwJ+Jk0IJrofi/lPfKSL1yM7b2sfQGC21xqjG
 RrDYF6Jp1D8UlDfkjH8UtjnhNBLmjJ3LywstFCOUJlkW3Yy9IbA0hDv9RXQvT1lK3gus
 V9mZSUzJmpiB7DdKVzLuqn0Mqf5kMh27xE6G+5DMQmwRBOa3QQa82kvhg5Tt+DqFzsr7
 fG2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695125304; x=1695730104;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iL+ruvnDDy5a4jeyKTDidCtFpCTdEKVq01EzWhj+Yf0=;
 b=PO1nZjCQuJ1i/3ydJsmt6klJMxxoO07zHCnBAljgp0q8bGAddRBF9A6t2dxCgp3Swy
 w7JWaK5rJ75reJiC9WfQcVj87pU1IcwBeJHLAVFc9qpCmIfTmtCDhs8/zui/UeD/zS3H
 kNEHr47fuV/BJ4z3itmFRaUW/sSMuehfRWdVgNCohbN4ZmurEtBUhofhnLixj5s5ncHL
 JcgfMF6OsAIzd8fmksSMhkacndiFIKi65vzK8schilyQ43D0qjNCl6CrU1s6w5afm0iE
 xa6UM1QaUUXKIOmAThj8z8Ju8YRMTuyWuN+9+7uSC/81HnUCAuuSNGjL0bxotC96iNXl
 ZnBg==
X-Gm-Message-State: AOJu0YzXjtsLZhF36wYgRZhadf6/cOsaPCHnn27U7BqPEhpcxdA8Qz8P
 GFs4zRzjKU/j0+eqOOaXjXE=
X-Google-Smtp-Source: AGHT+IExVqmUP9xrhSYdVmFERXtDA40tyaZnwgu4Gx9VGdzQL02epVT35Pi+wzBY7XLbCdAo+e9fnA==
X-Received: by 2002:aa7:db56:0:b0:52b:d169:b373 with SMTP id
 n22-20020aa7db56000000b0052bd169b373mr8934279edt.32.1695125303556; 
 Tue, 19 Sep 2023 05:08:23 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15bc:9900:21a0:f69e:f2eb:dcf5])
 by smtp.gmail.com with ESMTPSA id
 q5-20020aa7cc05000000b0052a1a623267sm7283100edt.62.2023.09.19.05.08.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 05:08:22 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: felix.kuehling@amd.com, alexdeucher@gmail.com, shashank.sharma@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/11] drm/amdgpu: fix and cleanup gmc_v9_0_flush_gpu_tlb
Date: Tue, 19 Sep 2023 14:08:12 +0200
Message-Id: <20230919120822.95241-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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

The KIQ code path was ignoring the second flush. Also avoid long lines and
re-calculating the register offsets over and over again.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 29 +++++++++++++++++----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 2936a0fb7527..0f82ab48887a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -816,13 +816,17 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 					uint32_t vmhub, uint32_t flush_type)
 {
 	bool use_semaphore = gmc_v9_0_use_invalidate_semaphore(adev, vmhub);
+	u32 j, inv_req, inv_req2, tmp, sem, req, ack;
 	const unsigned int eng = 17;
-	u32 j, inv_req, inv_req2, tmp;
 	struct amdgpu_vmhub *hub;
 
 	BUG_ON(vmhub >= AMDGPU_MAX_VMHUBS);
 
 	hub = &adev->vmhub[vmhub];
+	sem = hub->vm_inv_eng0_sem + hub->eng_distance * eng;
+	req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
+	ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
+
 	if (adev->gmc.xgmi.num_physical_nodes &&
 	    amdgpu_ip_version(adev, GC_HWIP, 0) == IP_VERSION(9, 4, 0)) {
 		/* Vega20+XGMI caches PTEs in TC and TLB. Add a
@@ -854,6 +858,10 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
 						   1 << vmid);
+		if (inv_req2)
+			amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack,
+							   inv_req2, 1 << vmid);
+
 		up_read(&adev->reset_domain->sem);
 		return;
 	}
@@ -872,9 +880,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		for (j = 0; j < adev->usec_timeout; j++) {
 			/* a read return value of 1 means semaphore acquire */
 			if (vmhub >= AMDGPU_MMHUB0(0))
-				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_sem + hub->eng_distance * eng);
+				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, sem);
 			else
-				tmp = RREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_sem + hub->eng_distance * eng);
+				tmp = RREG32_SOC15_IP_NO_KIQ(GC, sem);
 			if (tmp & 0x1)
 				break;
 			udelay(1);
@@ -886,9 +894,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	do {
 		if (vmhub >= AMDGPU_MMHUB0(0))
-			WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
+			WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req);
 		else
-			WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
+			WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req);
 
 		/*
 		 * Issue a dummy read to wait for the ACK register to
@@ -897,14 +905,13 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		 */
 		if ((vmhub == AMDGPU_GFXHUB(0)) &&
 		    (amdgpu_ip_version(adev, GC_HWIP, 0) < IP_VERSION(9, 4, 2)))
-			RREG32_NO_KIQ(hub->vm_inv_eng0_req +
-				      hub->eng_distance * eng);
+			RREG32_SOC15_IP_NO_KIQ(GC, req);
 
 		for (j = 0; j < adev->usec_timeout; j++) {
 			if (vmhub >= AMDGPU_MMHUB0(0))
-				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_ack + hub->eng_distance * eng);
+				tmp = RREG32_SOC15_IP_NO_KIQ(MMHUB, ack);
 			else
-				tmp = RREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_ack + hub->eng_distance * eng);
+				tmp = RREG32_SOC15_IP_NO_KIQ(GC, ack);
 			if (tmp & (1 << vmid))
 				break;
 			udelay(1);
@@ -921,9 +928,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		 * write with 0 means semaphore release
 		 */
 		if (vmhub >= AMDGPU_MMHUB0(0))
-			WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_sem + hub->eng_distance * eng, 0);
+			WREG32_SOC15_IP_NO_KIQ(MMHUB, sem, 0);
 		else
-			WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_sem + hub->eng_distance * eng, 0);
+			WREG32_SOC15_IP_NO_KIQ(GC, sem, 0);
 	}
 
 	spin_unlock(&adev->gmc.invalidate_lock);
-- 
2.34.1


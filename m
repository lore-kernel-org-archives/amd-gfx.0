Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9310CC83F33
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 06:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9C9210E426;
	Tue,  5 Sep 2023 06:04:20 +0000 (UTC)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D3C810E423
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 06:04:19 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-52a0856b4fdso2819788a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Sep 2023 23:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693893858; x=1694498658; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/gI3NrdfC/MTuQYW2XrqUI5evDlTxlCfVB1Ez7OJlM8=;
 b=i+2bDXVeHUHdvgHKuiAWLqiCM+rI6+8Z5LBVnA5YOoQrZAkrWr4S9Q+c2ucP722bDb
 hRpdfLpF3EwrnGx2Je8IurwP9o2WGyOLoehuadao8mZWxACYC9oNgsK8Szc/VGmIsY7M
 //obuoIw+EIyu0k8iVpFFq2jsTCOREGcJo8GUJZBWZct1A1DRkdYMf1VFYeuozZLvv1z
 5pKr9NzE/RbyTqRYDpjBuLFAjxdv1oXcLSn7iXsPpRtPn3RdXVbLWRsjRsJjTko8S92X
 1hJkBb+TfP5Oyrj7qpdHf1Qlc8TVMN1RTsxWyTTsqeTf5HAoAE7Prt6cwBDyja4nBKRk
 rj9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693893858; x=1694498658;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/gI3NrdfC/MTuQYW2XrqUI5evDlTxlCfVB1Ez7OJlM8=;
 b=GxrYtBHv06cYNGfeySpqjm7yoUfq4N4JF8pcX8PrtbX9VQj88KvRWUs6qPy+MeUuVL
 Bp8X5qRllGLys4Hs6X7QLCvNIGBX3ih4AP2BZ5CxUYgXHlbUUqEzHHn2s0rw7yFOAEuI
 K8tokrLKYqe7sjoFw7uawjwf+NlMbhN9c2Y94uAK3ZhEy8X4RlgeWbarvA+3KN5YrXQa
 rKXSNGGobkVgY7OjTzMbw0PlU5eOM+f7udpV2T3WvvqqK5VO3efUB1s7YOO45CPWlWwf
 1Zwmo2JrnCk+9MvY+zzpIbCrutV384S+kUGQbRSubjcHdgyahQoil2ga7zYVFOE4+txJ
 4qLA==
X-Gm-Message-State: AOJu0Yw1Rk2Saol/969DlaSSYUtl+ok6TzSYesjfCUJw22Gl/r6NShDZ
 P69bX34T0vHW5ELfzj/mGSM68ovozr0eMQ==
X-Google-Smtp-Source: AGHT+IHcEE3UxoMb5p/3qyxnqQsz5JwId1+kZkEbZ8F+jw8rGXTlUdGpMs9Vg6EI6CYH62tkzE3uTw==
X-Received: by 2002:aa7:dcd6:0:b0:523:3f45:5678 with SMTP id
 w22-20020aa7dcd6000000b005233f455678mr8763746edu.31.1693893858363; 
 Mon, 04 Sep 2023 23:04:18 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d9:7000:2f9d:c07d:1ee2:6439])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b0052a3b212157sm6631582edw.63.2023.09.04.23.04.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 23:04:17 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/11] drm/amdgpu: fix and cleanup gmc_v9_0_flush_gpu_tlb
Date: Tue,  5 Sep 2023 08:04:05 +0200
Message-Id: <20230905060415.1400-2-christian.koenig@amd.com>
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

The KIQ code path was ignoring the second flush. Also avoid long lines and
re-calculating the register offsets over and over again.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 29 +++++++++++++++++----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 0673cda547bb..4f6990ba71cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -814,13 +814,17 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
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
 	    adev->ip_versions[GC_HWIP][0] == IP_VERSION(9, 4, 0)) {
 		/* Vega20+XGMI caches PTEs in TC and TLB. Add a
@@ -852,6 +856,10 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
 						   1 << vmid);
+		if (inv_req2)
+			amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack,
+							   inv_req2, 1 << vmid);
+
 		up_read(&adev->reset_domain->sem);
 		return;
 	}
@@ -870,9 +878,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
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
@@ -884,9 +892,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 
 	do {
 		if (vmhub >= AMDGPU_MMHUB0(0))
-			WREG32_SOC15_IP_NO_KIQ(MMHUB, hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
+			WREG32_SOC15_IP_NO_KIQ(MMHUB, req, inv_req);
 		else
-			WREG32_SOC15_IP_NO_KIQ(GC, hub->vm_inv_eng0_req + hub->eng_distance * eng, inv_req);
+			WREG32_SOC15_IP_NO_KIQ(GC, req, inv_req);
 
 		/*
 		 * Issue a dummy read to wait for the ACK register to
@@ -895,14 +903,13 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		 */
 		if ((vmhub == AMDGPU_GFXHUB(0)) &&
 		    (adev->ip_versions[GC_HWIP][0] < IP_VERSION(9, 4, 2)))
-			RREG32_NO_KIQ(hub->vm_inv_eng0_req +
-				      hub->eng_distance * eng);
+			RREG32_NO_KIQ(req);
 
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
@@ -919,9 +926,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
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


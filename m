Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48EA0CA0FF8
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 06:04:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 66A4E10E434;
	Tue,  5 Sep 2023 06:04:31 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 20FCC10E42F
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 06:04:26 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52c74a2e8edso2986203a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Sep 2023 23:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693893864; x=1694498664; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1mPGSmhyG5tdNmVGJI5o7I6o4JCNvUKsbyP9A1NuuVU=;
 b=GkmduWghsAA3qk8qJ1wJMt3LuL87KG6+Aj8KMuquclC/uZswxWeZoNOweC0QFqn7Ge
 L3slmaP9YB11lL60jcW3g2EpRi9DivTQOCc2T7vmT1+olkkMvgwjcAEFVk5TKCqD7hx1
 s9h803db4x70/eXO3LMraMa0m6/Q/wMXYrJkqf0LtuiPlDuseVhidcP4eg/DZalEvlHs
 PG78LM7/UTokp0xs/Kr8WLvrAf/9biRq6VpWrUfxlULLAFZArtmtQVWXVS+SDM94+/rY
 GRl5Qx3CdzIeGzrAf3fB0ciqgJZPrQIHWNQGENwdT2qs2OqnNSXQdGzvCN/uOCYnE9lB
 4d6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693893864; x=1694498664;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1mPGSmhyG5tdNmVGJI5o7I6o4JCNvUKsbyP9A1NuuVU=;
 b=L5aXrsYFEcGOW0ItDOM5nB7KHYSL/paYUCvfJoCQKE3joC12hgiqlPcK4TZAcA9zS+
 zLI2aqEde/KoY38jSzo0XTrxwr3fBsAWEvNUc8s55CF29osZ12mlfcSyuKF3hSaRhRwU
 C06pBf5L1qsHB43DlZI5NQkowV4961isPNPlGEDhEmDvlAGaVIAPFi8Epvk4oh8IzWuV
 TkGo0yqzNkHdU7FWSC2dnBap80PX9+8j3lEYDUPQEBYcfthqnpSKnuICAw8TSuL817C9
 pwmEiZ090/gvo201K5QDGof3bwmDfElDm1OtxqwsIriaM8p+Qqm46fPWHkruEBj61DPA
 jXXQ==
X-Gm-Message-State: AOJu0YySW96eKWgxqb7KtZmMPSNsCdcsyvUGOT85vaGd1/6aHqouGROu
 MLVQK0gDrEyJTwQilwPESq6zy+51foxiZvP0
X-Google-Smtp-Source: AGHT+IERg1xUSUm5KTgTQPjKKtQTnv0NUjJ7VLGOjD2JZP11+EZ4jliNTge7iTLEFb2DboXjl+oeTA==
X-Received: by 2002:a05:6402:1288:b0:525:7d81:71ee with SMTP id
 w8-20020a056402128800b005257d8171eemr8743333edv.15.1693893864178; 
 Mon, 04 Sep 2023 23:04:24 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d9:7000:2f9d:c07d:1ee2:6439])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b0052a3b212157sm6631582edw.63.2023.09.04.23.04.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 23:04:23 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/11] drm/amdgpu: rework lock handling fro flush_tlb
Date: Tue,  5 Sep 2023 08:04:14 +0200
Message-Id: <20230905060415.1400-11-christian.koenig@amd.com>
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

Instead of each implementation doing this more or less correctly
move taking the reset lock at a higher level.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 6 +-----
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   | 5 -----
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 5 -----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 6 +-----
 5 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 15814cb801e7..c24252304d48 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -589,8 +589,17 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	    !adev->mman.buffer_funcs_enabled ||
 	    !adev->ib_pool_ready || amdgpu_in_reset(adev) ||
 	    !ring->sched.ready) {
+
+		/*
+		 * A GPU reset should flush all TLBs anyway, so no need to do
+		 * this while one is ongoing.
+		 */
+		if(!down_read_trylock(&adev->reset_domain->sem))
+			return;
+
 		adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid, vmhub,
 						   flush_type);
+		up_read(&adev->reset_domain->sem);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 40d432d46469..302279497d67 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -51,8 +51,6 @@
 #include "athub_v2_0.h"
 #include "athub_v2_1.h"
 
-#include "amdgpu_reset.h"
-
 static int gmc_v10_0_ecc_interrupt_state(struct amdgpu_device *adev,
 					 struct amdgpu_irq_src *src,
 					 unsigned int type,
@@ -264,11 +262,9 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 * Directly use kiq to do the vm invalidation instead
 	 */
 	if (adev->gfx.kiq[0].ring.sched.ready && !adev->enable_mes &&
-	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
-	    down_read_trylock(&adev->reset_domain->sem)) {
+	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
 		amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack, inv_req,
 				1 << vmid);
-		up_read(&adev->reset_domain->sem);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index fa3586efacd2..998f6ee60b78 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -33,7 +33,6 @@
 #include "amdgpu_ucode.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_gem.h"
-#include "amdgpu_reset.h"
 
 #include "bif/bif_4_1_d.h"
 #include "bif/bif_4_1_sh_mask.h"
@@ -430,9 +429,6 @@ static void gmc_v7_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	u32 mask = 0x0;
 	int vmid;
 
-	if(!down_read_trylock(&adev->reset_domain->sem))
-		return;
-
 	for (vmid = 1; vmid < 16; vmid++) {
 		u32 tmp = RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
 
@@ -443,7 +439,6 @@ static void gmc_v7_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 
 	WREG32(mmVM_INVALIDATE_REQUEST, mask);
 	RREG32(mmVM_INVALIDATE_RESPONSE);
-	up_read(&adev->reset_domain->sem);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index ffcd79d28b9a..8dcd9b13673c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -31,7 +31,6 @@
 #include "amdgpu_ucode.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_gem.h"
-#include "amdgpu_reset.h"
 
 #include "gmc/gmc_8_1_d.h"
 #include "gmc/gmc_8_1_sh_mask.h"
@@ -620,9 +619,6 @@ static void gmc_v8_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	u32 mask = 0x0;
 	int vmid;
 
-	if(!down_read_trylock(&adev->reset_domain->sem))
-		return;
-
 	for (vmid = 1; vmid < 16; vmid++) {
 		u32 tmp = RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
 
@@ -633,7 +629,6 @@ static void gmc_v8_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 
 	WREG32(mmVM_INVALIDATE_REQUEST, mask);
 	RREG32(mmVM_INVALIDATE_RESPONSE);
-	up_read(&adev->reset_domain->sem);
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 94ba16536fc2..c5df8f052f3f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -64,8 +64,6 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
 
-#include "amdgpu_reset.h"
-
 /* add these here since we already include dce12 headers and these are for DCN */
 #define mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION                                                          0x055d
 #define mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION_BASE_IDX                                                 2
@@ -849,8 +847,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 * as GFXOFF under bare metal
 	 */
 	if (adev->gfx.kiq[0].ring.sched.ready &&
-	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
-	    down_read_trylock(&adev->reset_domain->sem)) {
+	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
 		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
 		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
@@ -860,7 +857,6 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 			amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack,
 							   inv_req2, 1 << vmid);
 
-		up_read(&adev->reset_domain->sem);
 		return;
 	}
 
-- 
2.34.1


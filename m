Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6992CCD5BA4
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 12:08:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBB0110E3A4;
	Tue, 19 Sep 2023 12:08:45 +0000 (UTC)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38E7910E262
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 12:08:32 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5310aec4121so2788166a12.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 05:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695125310; x=1695730110; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=4bDWxBCmy88+Zq/n3zwXwHzJfbeImjpd0zCQOfJ8zL4=;
 b=b2YCHNmEZ9JEvw82yynJch/0+bzeB3hJdBBTu9yYrx3Rgvia3Q1n3PikNXWB2puH1j
 okJO2CznemS2bOO+zdzW3QkvZHwJEp6dWEYuOXETCLgNSe3tSVtiu4tDRONtDXfUfXQ4
 gOCTaJSofwp0835pSHnQavPB0ZJbtsWYTBLKa6BJeUR6icAPewGB1DSy7dsq2Fhe7Akq
 KV2XTsJ6KlDHwPzv891snVoTyORUIIgr4fQsFb5y8m2NiqmRtfcyhXyPtRxMHvaDOE8D
 P82V2hGYl5tY+37ZQyPrl6q1VqVyThP0goNYk3KLEtQVZLRTRuLylYTZ2A79Re+Q+LD8
 YjIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695125310; x=1695730110;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4bDWxBCmy88+Zq/n3zwXwHzJfbeImjpd0zCQOfJ8zL4=;
 b=kla+HdfgSzMymXtuL+c4hVcU/dpHe5w/YTJPUffIiAawPrg0HEhLI7++HdFur9ujAM
 IUNg6yLuWa/DhQDuB5a7Twi4+GxUitWoMa4uD3SSUNpAWoAd3aSbTyuPhQGj516ztIdI
 imvwO70xplFAErQZu1X52tLm6O7BPdThUSd3AfWh3ooADIZ6TeAnN8iV4x6wAsGHhB2m
 r+6QHozyH0s/GToN4FOXJHszPpt/grkUhOg1I5w5Cb2OLRMDidLi0EbOYvaKA1dkurJN
 GwwQA5J7RoDxaHuOtIKKvCGbhl+m3TwTTodxgNqWWkh91DJKY7K/7vNSe7iOZcW2l9zv
 0Aig==
X-Gm-Message-State: AOJu0Yx/zKnTuufLRnqDy968P6F9D+jE8jYSyG3ASfPHZyJ6yU4pw8gD
 9dMy5cmUciKKs03VwLT8noM=
X-Google-Smtp-Source: AGHT+IFqzKz1f6RGjIEGFTsjqruxs3EG7x5JBXHdQvagULH6Uigt88wAOobOm/jixD/drwod0ju1gw==
X-Received: by 2002:a05:6402:2809:b0:531:2e3a:cb88 with SMTP id
 h9-20020a056402280900b005312e3acb88mr5265154ede.13.1695125310577; 
 Tue, 19 Sep 2023 05:08:30 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15bc:9900:21a0:f69e:f2eb:dcf5])
 by smtp.gmail.com with ESMTPSA id
 q5-20020aa7cc05000000b0052a1a623267sm7283100edt.62.2023.09.19.05.08.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 05:08:29 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: felix.kuehling@amd.com, alexdeucher@gmail.com, shashank.sharma@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 10/11] drm/amdgpu: rework lock handling fro flush_tlb v2
Date: Tue, 19 Sep 2023 14:08:21 +0200
Message-Id: <20230919120822.95241-10-christian.koenig@amd.com>
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

Instead of each implementation doing this more or less correctly
move taking the reset lock at a higher level.

v2: fix typo

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 9 +++++++++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 6 +-----
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   | 5 -----
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 5 -----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 6 +-----
 5 files changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index eaba4e9f247e..b074dc75f59f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -593,8 +593,17 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	    !adev->mman.buffer_funcs_enabled ||
 	    !adev->ib_pool_ready || amdgpu_in_reset(adev) ||
 	    !ring->sched.ready) {
+
+		/*
+		 * A GPU reset should flush all TLBs anyway, so no need to do
+		 * this while one is ongoing.
+		 */
+		if (!down_read_trylock(&adev->reset_domain->sem))
+			return;
+
 		adev->gmc.gmc_funcs->flush_gpu_tlb(adev, vmid, vmhub,
 						   flush_type);
+		up_read(&adev->reset_domain->sem);
 		return;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 87c1b945e82d..a467b3ac7f0f 100644
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
@@ -265,11 +263,9 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
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
index 448966069312..adb38698eac7 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -65,8 +65,6 @@
 #include "amdgpu_ras.h"
 #include "amdgpu_xgmi.h"
 
-#include "amdgpu_reset.h"
-
 /* add these here since we already include dce12 headers and these are for DCN */
 #define mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION                                                          0x055d
 #define mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION_BASE_IDX                                                 2
@@ -851,8 +849,7 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 	 * as GFXOFF under bare metal
 	 */
 	if (adev->gfx.kiq[0].ring.sched.ready &&
-	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev)) &&
-	    down_read_trylock(&adev->reset_domain->sem)) {
+	    (amdgpu_sriov_runtime(adev) || !amdgpu_sriov_vf(adev))) {
 		uint32_t req = hub->vm_inv_eng0_req + hub->eng_distance * eng;
 		uint32_t ack = hub->vm_inv_eng0_ack + hub->eng_distance * eng;
 
@@ -862,7 +859,6 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 			amdgpu_virt_kiq_reg_write_reg_wait(adev, req, ack,
 							   inv_req2, 1 << vmid);
 
-		up_read(&adev->reset_domain->sem);
 		return;
 	}
 
-- 
2.34.1


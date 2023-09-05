Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041EDC83F33
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Sep 2023 06:04:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8F1010E42F;
	Tue,  5 Sep 2023 06:04:26 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11F2510E42B
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Sep 2023 06:04:25 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-52a23227567so2806396a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 04 Sep 2023 23:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693893863; x=1694498663; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qT0WjGnXa4Z4X5tCaycUmDVkXj/OPy9Y+s4Ds8SLbHs=;
 b=F7wtukZ33DF4S1BkzyZr7gsknXneuAWHe5+zrquRxSRfL7uHXDIe8p0qzJ9iXidq1v
 V9+LD5TW2FY3ZyqTMtk8ynDU2AB2UzYSIethyUxpCO8Sf2BbM/fVFsuvFqQ0BhowV7TZ
 JC4q1WdCfNZZznTqHvWQfLOUdCiwYRulSBnCyhcaAfC7mchKBTmF1fTzI6rfAppHDK+8
 2OMBUbyUplnzeuXHmIKmV8fw8Uk9jcOPdvYo0jLUWMH52vbm35Agi6JB4HqtjrGrgK9l
 KqBn78eshxhiLXidjwHKEWMAzj4A8ViYP3muqBU6bZlWs2G5oasd/w5FVCQGAWLrH8U2
 FNoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693893863; x=1694498663;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qT0WjGnXa4Z4X5tCaycUmDVkXj/OPy9Y+s4Ds8SLbHs=;
 b=fGtQLujStoTvHNte2Cx+wfK0K0Jp9RDXY34SiIoBTbXbLC3DDMh65xufJvkICxdN6s
 vJpXPhG7FJXs8O7Bn6ycEBgmrhiiJHgcur1tDKN2+CCeLTx2ddTfwEo6+xQEPm0FbBxM
 McPoPl2RFZf4xdo2pCPP+rIc+K5EfjxM8E9/FBMLn/u/1OX1FXwuniTDkdLvMbkbrMjQ
 +Twp1Fppq6K6RYpmCHn9Qs0qdXUoieb3eXQXKmtm7DsSkeypeDngdnlURh7GkM0PJf1Z
 iLghix21AW/0Ta54fHel9fvhCBMc7xGrejmnrq2VllebS46QpcM6WRWiZnn5qjE9rB1z
 oZNg==
X-Gm-Message-State: AOJu0YwNpX05RqudJGMRAX8Q91FvWmpJnoVUmWoYWJCxMxhhMg29V1jw
 s7gG3DxRBHiCrzuZfSX46pJvqU7jnfWJtaW8
X-Google-Smtp-Source: AGHT+IERvFNxbdP+JJTcBEet1jyqVt+ch/XOPskeQOpL1cooWN0cQRRZYU2X4XcZjV2bFMoql1Gy1Q==
X-Received: by 2002:a50:fc12:0:b0:525:6c9f:e1a3 with SMTP id
 i18-20020a50fc12000000b005256c9fe1a3mr8340380edr.20.1693893863445; 
 Mon, 04 Sep 2023 23:04:23 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d9:7000:2f9d:c07d:1ee2:6439])
 by smtp.gmail.com with ESMTPSA id
 f2-20020a056402150200b0052a3b212157sm6631582edw.63.2023.09.04.23.04.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Sep 2023 23:04:23 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/11] drm/amdgpu: drop error return from flush_gpu_tlb_pasid
Date: Tue,  5 Sep 2023 08:04:13 +0200
Message-Id: <20230905060415.1400-10-christian.koenig@amd.com>
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

That function never fails, drop the error return.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c | 7 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 6 +++---
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 7 +++----
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 7 +++----
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c   | 9 ++++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c   | 9 ++++-----
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c   | 8 +++-----
 7 files changed, 24 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index b5f1a1218725..15814cb801e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -638,9 +638,10 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 
 	if (!adev->gmc.flush_pasid_uses_kiq || !ring->sched.ready ||
 	    !down_read_trylock(&adev->reset_domain->sem)) {
-		return adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
-								flush_type,
-								all_hub, inst);
+		adev->gmc.gmc_funcs->flush_gpu_tlb_pasid(adev, pasid,
+							 flush_type, all_hub,
+							 inst);
+		return 0;
 	}
 
 	/* 2 dwords flush + 8 dwords fence */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 7732d4ef845e..dd0ede75e5d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -130,9 +130,9 @@ struct amdgpu_gmc_funcs {
 	void (*flush_gpu_tlb)(struct amdgpu_device *adev, uint32_t vmid,
 				uint32_t vmhub, uint32_t flush_type);
 	/* flush the vm tlb via pasid */
-	int (*flush_gpu_tlb_pasid)(struct amdgpu_device *adev, uint16_t pasid,
-					uint32_t flush_type, bool all_hub,
-					uint32_t inst);
+	void (*flush_gpu_tlb_pasid)(struct amdgpu_device *adev, uint16_t pasid,
+				    uint32_t flush_type, bool all_hub,
+				    uint32_t inst);
 	/* flush the vm tlb via ring */
 	uint64_t (*emit_flush_gpu_tlb)(struct amdgpu_ring *ring, unsigned vmid,
 				       uint64_t pd_addr);
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 407ddb926941..40d432d46469 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -337,9 +337,9 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
  *
  * Flush the TLB for the requested pasid.
  */
-static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
-					uint16_t pasid, uint32_t flush_type,
-					bool all_hub, uint32_t inst)
+static void gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
+					  uint16_t pasid, uint32_t flush_type,
+					  bool all_hub, uint32_t inst)
 {
 	uint16_t queried;
 	int vmid, i;
@@ -362,7 +362,6 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 						flush_type);
 		}
 	}
-	return 0;
 }
 
 static uint64_t gmc_v10_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index aa39c1087e44..50bc5f151038 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -299,9 +299,9 @@ static void gmc_v11_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
  *
  * Flush the TLB for the requested pasid.
  */
-static int gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
-					uint16_t pasid, uint32_t flush_type,
-					bool all_hub, uint32_t inst)
+static void gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
+					  uint16_t pasid, uint32_t flush_type,
+					  bool all_hub, uint32_t inst)
 {
 	uint16_t queried;
 	int vmid, i;
@@ -324,7 +324,6 @@ static int gmc_v11_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 						flush_type);
 		}
 	}
-	return 0;
 }
 
 static uint64_t gmc_v11_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index 9e19a752f94b..fa3586efacd2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -423,15 +423,15 @@ static int gmc_v7_0_mc_init(struct amdgpu_device *adev)
  *
  * Flush the TLB for the requested pasid.
  */
-static int gmc_v7_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
-					uint16_t pasid, uint32_t flush_type,
-					bool all_hub, uint32_t inst)
+static void gmc_v7_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
+					 uint16_t pasid, uint32_t flush_type,
+					 bool all_hub, uint32_t inst)
 {
 	u32 mask = 0x0;
 	int vmid;
 
 	if(!down_read_trylock(&adev->reset_domain->sem))
-		return 0;
+		return;
 
 	for (vmid = 1; vmid < 16; vmid++) {
 		u32 tmp = RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
@@ -444,7 +444,6 @@ static int gmc_v7_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	WREG32(mmVM_INVALIDATE_REQUEST, mask);
 	RREG32(mmVM_INVALIDATE_RESPONSE);
 	up_read(&adev->reset_domain->sem);
-	return 0;
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 2d51531a1f2d..ffcd79d28b9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -613,15 +613,15 @@ static int gmc_v8_0_mc_init(struct amdgpu_device *adev)
  *
  * Flush the TLB for the requested pasid.
  */
-static int gmc_v8_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
-					uint16_t pasid, uint32_t flush_type,
-					bool all_hub, uint32_t inst)
+static void gmc_v8_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
+					 uint16_t pasid, uint32_t flush_type,
+					 bool all_hub, uint32_t inst)
 {
 	u32 mask = 0x0;
 	int vmid;
 
 	if(!down_read_trylock(&adev->reset_domain->sem))
-		return 0;
+		return;
 
 	for (vmid = 1; vmid < 16; vmid++) {
 		u32 tmp = RREG32(mmATC_VMID0_PASID_MAPPING + vmid);
@@ -634,7 +634,6 @@ static int gmc_v8_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 	WREG32(mmVM_INVALIDATE_REQUEST, mask);
 	RREG32(mmVM_INVALIDATE_RESPONSE);
 	up_read(&adev->reset_domain->sem);
-	return 0;
 }
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 39016b6900d3..94ba16536fc2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -950,9 +950,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
  *
  * Flush the TLB for the requested pasid.
  */
-static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
-					uint16_t pasid, uint32_t flush_type,
-					bool all_hub, uint32_t inst)
+static void gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
+					 uint16_t pasid, uint32_t flush_type,
+					 bool all_hub, uint32_t inst)
 {
 	uint16_t queried;
 	int i, vmid;
@@ -976,8 +976,6 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 					       flush_type);
 		}
 	}
-
-	return 0;
 }
 
 static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
-- 
2.34.1


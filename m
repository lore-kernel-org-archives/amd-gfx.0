Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32DA9CD5BA0
	for <amd-gfx@archiver.kernel.org>; Tue, 19 Sep 2023 12:08:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B079210E262;
	Tue, 19 Sep 2023 12:08:32 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A36510E262
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 12:08:31 +0000 (UTC)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-99c93638322so1211627366b.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 Sep 2023 05:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695125309; x=1695730109; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=QG0vtBD2zkKfnwMMMubLROcF9/167tSMO3zfGI2fKd0=;
 b=BWgC10RA3Dz+6KR0nB9sLnuTSksM+Rrcp2+KxejWScbJrRj3zCohQ+JvONhlFMAeEs
 Lod3eEQIp9nATDuXMgUiG3I3ufs7Ah4BdHIBY96L9Rb2a9U5puAUkOXwKyGwUz+ouyXb
 S+AmIrglBW8rwNmUCqazuWIs2LEEJnOaxqTUwN9bcmbsVLHyswfw/DZnJiKwUXagMbHz
 EZpXRjI3ZQJZgsSp36DgBkFV/Tc/2nTkAPI/9XV+IdAeV7blGJs+YtTJUZVHZTDyYKiJ
 dkjA/j8D+LfMfguCGmqiWy+ZHbhtUUl8cj8QXO3/qT49/LHfAPBjrYh+hh66XjTcTiti
 2n2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695125309; x=1695730109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QG0vtBD2zkKfnwMMMubLROcF9/167tSMO3zfGI2fKd0=;
 b=nhPgLwnSfhwEYCmPYJAwZnKHDz1MiaQp5G6GfrrST02WgvgquwGHVW+cifFfbmDu8z
 czpbqM7BlFsML+uzo9RQfUK+ohWyLYjQ/m0cXLUk6yu5PlH/KB7Oqvx0zULMXC8Ao9Fb
 uQLVKwLyf2xRW1GsH4u9ZfZbjpveyaJnslNHwejveiuIkXxQN4J/BdKlYLp6SotsODDR
 eRaegLbcy1dknCHnTqORR59KGzQBamO73VGLcj9rVsgmejMWIqaBHq40MJMK//QBWLTF
 WN02a4Nfo2mSzaxOPqB5JQIcf7LcDy8EI83oYBwZmLnUJwjmu+seKmO1p2vLo3mLz4RI
 F08w==
X-Gm-Message-State: AOJu0YxPEVBXTD8NpCO1kDq1evk4YYiSyasfd5aC4OHgVVviJ8gjw6fV
 GnBQkRk97eHHquWWHI7SyM0=
X-Google-Smtp-Source: AGHT+IHFFXoYD5nI+O5hWeNkJR36iAtQA2wJQYPe7/EqvGDXVrx3rw4ul8cWRi2B0PklORIIQptJSw==
X-Received: by 2002:a17:907:97cb:b0:9aa:f7f:e276 with SMTP id
 js11-20020a17090797cb00b009aa0f7fe276mr3324840ejc.38.1695125309491; 
 Tue, 19 Sep 2023 05:08:29 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15bc:9900:21a0:f69e:f2eb:dcf5])
 by smtp.gmail.com with ESMTPSA id
 q5-20020aa7cc05000000b0052a1a623267sm7283100edt.62.2023.09.19.05.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 05:08:29 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: felix.kuehling@amd.com, alexdeucher@gmail.com, shashank.sharma@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/11] drm/amdgpu: drop error return from flush_gpu_tlb_pasid
Date: Tue, 19 Sep 2023 14:08:20 +0200
Message-Id: <20230919120822.95241-9-christian.koenig@amd.com>
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

That function never fails, drop the error return.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
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
index 07f657e2f3a2..eaba4e9f247e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -642,9 +642,10 @@ int amdgpu_gmc_flush_gpu_tlb_pasid(struct amdgpu_device *adev, uint16_t pasid,
 
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
index 5cc77c207dbf..87c1b945e82d 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -339,9 +339,9 @@ static void gmc_v10_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
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
@@ -364,7 +364,6 @@ static int gmc_v10_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 						flush_type);
 		}
 	}
-	return 0;
 }
 
 static uint64_t gmc_v10_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index a129166a721c..7d61f66625fa 100644
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
index 37b33eb84210..448966069312 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -952,9 +952,9 @@ static void gmc_v9_0_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
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
@@ -978,8 +978,6 @@ static int gmc_v9_0_flush_gpu_tlb_pasid(struct amdgpu_device *adev,
 					       flush_type);
 		}
 	}
-
-	return 0;
 }
 
 static uint64_t gmc_v9_0_emit_flush_gpu_tlb(struct amdgpu_ring *ring,
-- 
2.34.1


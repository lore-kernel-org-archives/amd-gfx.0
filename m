Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C83FFC61DCB
	for <amd-gfx@archiver.kernel.org>; Fri, 28 Aug 2026 11:41:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2265D10E510;
	Fri, 28 Aug 2026 11:41:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k4jAuhnM";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7796F10E510
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 11:41:21 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c207cb16cf5so145074066b.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 28 Aug 2026 04:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787917280; x=1788522080; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wnLQgrq8siJLYCb+U01MyrjUPJOqGoMh3aJZkWun9ss=;
 b=k4jAuhnMFqxd1z6dwyzAxq0IyH9Qcv7t8sd4m3lFBhzTbopJYwYTbsRkU99HHdkWGk
 BG47Tn8W6/bFlKHSnzvBEPVCrCAGbxHbkou2dbo5AOwkbK3lRF7PAIa0L84sp2T1LPI7
 9WYTfgttj5a8Dagr5zT0mGxr4DwVqnQWpp4vj/ws0aBgWP4RZFVqPjxp5wR4cSKEbofZ
 ecxnYJtvab+59aesHiFVacWph8g031kQbYJnTY6N0PrTyYH8ohj6TETccpzkbcoMjmIT
 AhKLpv3LSdIqPDxm9AWd42jtZdtxGfMNn0lbZraRDEoe2Q3DoZdyf1BawKZcnWbhXHW6
 sEmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787917280; x=1788522080;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wnLQgrq8siJLYCb+U01MyrjUPJOqGoMh3aJZkWun9ss=;
 b=oHj6wx259XFpDpgKCm8cYq2Mf+8+lAxpbWEB/9S9zxo4X7Rh1wekLx/pFGu9/C0L4h
 IYsSxtihl121yYfjKTBWeer5/ba9G31wOhEZzL23AoNcR8X/PMlgHUl+zPanLx14cvMd
 aNrAS32QCC/WPvbsf+T4q1tEgAHv3AdRwOsWQzR2Zr64OtaQGGPCP17LUgUiM6GxP4M/
 uHwINuzvlxF/7z7A71KDDrDc440W4xiDcaomvt+EdOHb8s59AH3+1vSIyeHisLzRaGDb
 MrJkweIEcH6Px2su8oozM7/0cOgcNGKctnANmQlG1/wgSJsmoAzOZ9BRvq/QB2b/3FI+
 xJMQ==
X-Gm-Message-State: AFuF++lrbkas/edr2DQ7d14gCoBe3Q4PQ26aUzggNgmJPNffg16eAg7l
 KwyXZUq8sFTa4jCF6QjG+19h6TyxFnPqf8Rd5v1ufMqxJI9Ao3Ki2ugbemU+Rl9l
X-Gm-Gg: AR+sD13NThLC9PhdFJIXSWqwG/5n7UOiKLuAnf9ZShNqbvlRWBzLmD6wkUEHrPhH97T
 L72IfpQZsUGKts2O4MsWh1NapDTrPe0VaFO7VwBVgdeV2d3bU3KdnkRtWjzY64n+euNPN5rLWOe
 wKk0nqWUd50WlaimiVFk2mGR9KnefHP3DIQ/exzBC16I9rGGwJJB8AYDHI9V553pC4Oc9za6Eyq
 SfHI3z5D0nW5GWxGi+EcTC8xiY0RsUq4yje1kBfeJkhrBBuf3F9VNaMaPej77p/MUBc5CdyZov0
 4Ry/lLNRFvE4mbjF2gH3kxR3dhIbBvW9PwT4phFBvQxO+vAQLkTIvayg2tZuDNtxgPzXruxRLht
 ayTDwiig4a2cNe7mUG137nIiuihF3eMXxe5OUydym/A5lRa7QlUgOwXVR4kSdKX6oc6vCG4WNpe
 zEIf9WxCM9WSVGhl78mn03R08OWr1uK2sERtFLJwYJp1JVHIPbrZ7ujdqXHxXGmMfVRIqI0axPO
 osn1FUqQnvscAikqXnYGbyY
X-Received: by 2002:a17:907:805:b0:c25:61f4:b478 with SMTP id
 a640c23a62f3a-c2561f4e7f3mr195420066b.15.1787917279618; 
 Fri, 28 Aug 2026 04:41:19 -0700 (PDT)
Received: from Timur-Hyperion (5E1B9A5E.dsl.pool.telekom.hu. [94.27.154.94])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c255ee288a4sm72549566b.16.2026.08.28.04.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:41:19 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>,
 Siwei He <siwei.he@amd.com>, Philip Yang <philip.yang@amd.com>,
 Mukul Joshi <mukul.joshi@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 02/11] drm/amdgpu/gfxhub: Enable retry fault interrupts in
 L2_PROTECTION_FAULT_CNTL2
Date: Fri, 28 Aug 2026 13:41:04 +0200
Message-ID: <20260828114113.13523-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260828114113.13523-1-timur.kristof@gmail.com>
References: <20260828114113.13523-1-timur.kristof@gmail.com>
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

Enable retry fault interrupts when initializing
the GFXHUB system aperture registers.
Needs to be done for each GFXHUB version, because
none of them actually enabled this interrupt.

This bit gates all retry fault functionality on Navi GPUs.
According to a mailing list conversation with AMD engineers,
this register field should have been initialized to 1
according to hardware documentation. But it has been confirmed
that it is in fact initialized to 0 by default.
I have personally confirmed on both Navi 31 and Navi 48
that the GPU does NOT send any retry fault interrupts
without enabling this bit.

Initially I wanted to program this field according
to the gmc.noretry flag in the previous versions
of this patch, but I was asked to just program it
always to 1 instead.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c | 9 +++++++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c   | 9 +++++++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c    | 9 +++++++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c    | 2 ++
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c    | 9 +++++++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c    | 9 +++++++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c    | 9 +++++++--
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c  | 9 +++++++--
 8 files changed, 51 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
index 652eea6eae4a..8be912d50601 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v11_5_0.c
@@ -155,6 +155,7 @@ static void gfxhub_v11_5_0_init_gart_aperture_regs(struct amdgpu_device *adev)
 static void gfxhub_v11_5_0_init_system_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t value;
+	u32 tmp;
 
 	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
 	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BOT, adev->gmc.agp_start >> 24);
@@ -180,8 +181,12 @@ static void gfxhub_v11_5_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
 		     (u32)((u64)adev->dummy_page_addr >> 44));
 
-	WREG32_FIELD15_PREREG(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
-		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
+				 ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
+				 ENABLE_RETRY_FAULT_INTERRUPT, 1);
+	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 }
 
 static void gfxhub_v11_5_0_init_tlb_regs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
index 6cbf837d50dd..4144c1c2ee13 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
@@ -158,6 +158,7 @@ static void gfxhub_v12_0_init_gart_aperture_regs(struct amdgpu_device *adev)
 static void gfxhub_v12_0_init_system_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t value;
+	u32 tmp;
 
 	/* Program the AGP BAR */
 	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
@@ -184,8 +185,12 @@ static void gfxhub_v12_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
 		     (u32)((u64)adev->dummy_page_addr >> 44));
 
-	WREG32_FIELD15_PREREG(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
-		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
+				 ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
+				 ENABLE_RETRY_FAULT_INTERRUPT, 1);
+	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index bfe247b1a333..c35856180c3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -91,6 +91,7 @@ static void gfxhub_v1_0_init_gart_aperture_regs(struct amdgpu_device *adev)
 static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t value;
+	u32 tmp;
 
 	if (!amdgpu_sriov_vf(adev) || adev->asic_type <= CHIP_VEGA10) {
 		/* Program the AGP BAR */
@@ -134,8 +135,12 @@ static void gfxhub_v1_0_init_system_aperture_regs(struct amdgpu_device *adev)
 		WREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
 			     (u32)((u64)adev->dummy_page_addr >> 44));
 
-		WREG32_FIELD15(GC, 0, VM_L2_PROTECTION_FAULT_CNTL2,
-			       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+		tmp = RREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL2);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
+					 ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+		tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
+					 ENABLE_RETRY_FAULT_INTERRUPT, 1);
+		WREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 	}
 
 	/* In the case squeezing vram into GART aperture, we don't use
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index fbdf46070b38..8397d3d38287 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -176,6 +176,8 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdgpu_device *adev,
 			tmp = RREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL2);
 			tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
 					    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+			tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
+					    ENABLE_RETRY_FAULT_INTERRUPT, 1);
 			WREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 		}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 9ea593e2c719..04778f9f95bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -151,6 +151,7 @@ static void gfxhub_v2_0_init_gart_aperture_regs(struct amdgpu_device *adev)
 static void gfxhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t value;
+	u32 tmp;
 
 	if (!amdgpu_sriov_vf(adev)) {
 		/* Program the AGP BAR */
@@ -178,8 +179,12 @@ static void gfxhub_v2_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
 		     (u32)((u64)adev->dummy_page_addr >> 44));
 
-	WREG32_FIELD15(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
-		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
+				 ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
+				 ENABLE_RETRY_FAULT_INTERRUPT, 1);
+	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 30b90d35abd0..6c77c17878f8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -154,6 +154,7 @@ static void gfxhub_v2_1_init_gart_aperture_regs(struct amdgpu_device *adev)
 static void gfxhub_v2_1_init_system_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t value;
+	u32 tmp;
 
 	if (amdgpu_sriov_vf(adev))
 		return;
@@ -182,8 +183,12 @@ static void gfxhub_v2_1_init_system_aperture_regs(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
 		     (u32)((u64)adev->dummy_page_addr >> 44));
 
-	WREG32_FIELD15(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
-		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+	tmp = RREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
+				 ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
+				 ENABLE_RETRY_FAULT_INTERRUPT, 1);
+	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index 9e6a6e13dec0..e2b9fd0c8af0 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -150,6 +150,7 @@ static void gfxhub_v3_0_init_gart_aperture_regs(struct amdgpu_device *adev)
 static void gfxhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t value;
+	u32 tmp;
 
 	/* Program the AGP BAR */
 	WREG32_SOC15(GC, 0, regGCMC_VM_AGP_BASE, 0);
@@ -176,8 +177,12 @@ static void gfxhub_v3_0_init_system_aperture_regs(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
 		     (u32)((u64)adev->dummy_page_addr >> 44));
 
-	WREG32_FIELD15_PREREG(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
-		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
+				 ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
+				 ENABLE_RETRY_FAULT_INTERRUPT, 1);
+	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
index b3b1085c7cd3..fa8b966b7ea1 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
@@ -153,6 +153,7 @@ static void gfxhub_v3_0_3_init_gart_aperture_regs(struct amdgpu_device *adev)
 static void gfxhub_v3_0_3_init_system_aperture_regs(struct amdgpu_device *adev)
 {
 	uint64_t value;
+	u32 tmp;
 
 	if (amdgpu_sriov_vf(adev))
 		return;
@@ -181,8 +182,12 @@ static void gfxhub_v3_0_3_init_system_aperture_regs(struct amdgpu_device *adev)
 	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_DEFAULT_ADDR_HI32,
 		     (u32)((u64)adev->dummy_page_addr >> 44));
 
-	WREG32_FIELD15_PREREG(GC, 0, GCVM_L2_PROTECTION_FAULT_CNTL2,
-		       ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+	tmp = RREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
+				 ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+	tmp = REG_SET_FIELD(tmp, GCVM_L2_PROTECTION_FAULT_CNTL2,
+				 ENABLE_RETRY_FAULT_INTERRUPT, 1);
+	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 }
 
 
-- 
2.55.0


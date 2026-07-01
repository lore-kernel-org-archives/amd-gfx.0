Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51613C43458
	for <amd-gfx@archiver.kernel.org>; Wed,  1 Jul 2026 16:17:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D946210EFF9;
	Wed,  1 Jul 2026 16:17:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eaQB+pj+";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6836D10EFBB
 for <amd-gfx@lists.freedesktop.org>; Wed,  1 Jul 2026 16:17:35 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-476d8e647e9so804675f8f.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 01 Jul 2026 09:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782922654; x=1783527454; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SfxtZH65cg0i5+vzJglwkLDnyUm3JyyyOF6Kl2dYKv8=;
 b=eaQB+pj+JRgVy3b/8h+xtJbifKsG8d3x2ZuskF7ezPEQyRreTT9QM/cjNuuN7QOWeV
 qctpv2y3Cac9Tjwrb4XTz6jGFsSaY7l/8qTo86MKmjcpeiJHBvCJnoLRZYZ+z4hmqdOd
 0IcTrswmbWZPOtAVkjD35b2GWFjwaIFyNmZ2XixiHVDF9hbwjbbuZs23nJKUKUPkTzXf
 Nko3JzQ2foQoH8lJeQlLA7JwmvIlZgtwQgxTvBvbguSTkNtmzHOT+OoMOnWD8Uea6tLb
 Z3iWq1LHC+IuA66FoNV6Lc55ISfWt49GRJkOwxRjRj8bR7vLTBOCjowVjrQZw/44Vvf5
 hLYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782922654; x=1783527454;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SfxtZH65cg0i5+vzJglwkLDnyUm3JyyyOF6Kl2dYKv8=;
 b=HdtKK8dOnq9wmuNy7If9pQA6wefRgfVpWMYcALx8+bv3A052DaZvoiOddIPSAGsQk3
 UTkaJFcevU7TWmRdnvLUJNLNuX4Hgsn9iD0ZYoUNcB1vP7x4UXcOsGQQ/vxfzb/nMKie
 bFtrf0L8prGHy7fGCtPwqFiWpZrY4xPPAmRWEi0GYX++3hOpVMs0h1vutY0f2MqpSl/X
 rEhUhR+qhq7mJ0RGdbwz2KoXeIFIzDG8VPAET0TgBtuzpy4B7YX9EBxzHp4j3ZQ+yriI
 hIRV+B3kq5nFzkI/Pnjd8iljZFbAdN/SakN8aGPo0FB4llT7eeUMu1T4bppxteFGJzXo
 FhtA==
X-Gm-Message-State: AOJu0YwH3GbXmg678H8l4KZH/w1CpybZH9/I5g7YcEb7ITVxvMRt6UVY
 8NaFjN0GLMOeF7/ughniRIkUg7ZQB3QynSWk4gU5L6DyM8sxET95G6e02qPBRpZF
X-Gm-Gg: AfdE7cksMkMiTlOgzfuDFPPyfPSyvL4yqTakL/V1KzOEJRLWIrLDHst5acX4pXJA5TN
 eGKCY0T/Gfh+7k9CN/az7Thwgo8pKbop6xexpgh0OMEJTSbeB8OH9oJqt7BD1S0hgsev/H16dai
 a5INjoOB/h0AwUClKVrD9wuO/R+98v8qg8lKoUB63L/yRw6FhXga4L3IdjmXcqkUdvBargJ8Eh4
 LsuDY4HVrAZJuwknILqJxRm3dKrv7xIy/7UXqxuKMIc47lDFoUMxhPJGz6Ceo9M0/3bwtHOOx/t
 MW/Ls9sYWG6who3EiX54evYDHYVANoQBfW7IOI3UgvmFfpp2jN6q84NJjD8pe8d7RJNCldDFGkS
 kdo+b+85mcqpPIxP7FG1N0LAp4vnqcFSwglB85UnFTF1wjGFR4P7SylFDfjxfDnuyNZVt85GTCp
 Zmwtdh5kBkx8JUr0sa
X-Received: by 2002:a7b:cb55:0:b0:493:aaa2:f034 with SMTP id
 5b1f17b1804b1-493c2b7a70bmr30589315e9.26.1782922653593; 
 Wed, 01 Jul 2026 09:17:33 -0700 (PDT)
Received: from Timur-Max ([212.108.193.106]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493be81df2asm168812255e9.12.2026.07.01.09.17.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Jul 2026 09:17:33 -0700 (PDT)
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
Subject: [PATCH 02/14] drm/amdgpu/gfxhub: Enable retry fault interrupts when
 needed
Date: Wed,  1 Jul 2026 18:17:09 +0200
Message-ID: <20260701161721.85681-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701161721.85681-1-timur.kristof@gmail.com>
References: <20260701161721.85681-1-timur.kristof@gmail.com>
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

Enable retry fault interrupts when initializing the GFXHUB
system aperture registers according to whether retrying
page faults is enabled in amdgpu (ie. amdgpu.noretry=0).

Needs to be done for each GFXHUB version at once,
because none of them actually enabled this interrupt.

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
index 652eea6eae4a..ef20eafd59ae 100644
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
+				 ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
+	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 }
 
 static void gfxhub_v11_5_0_init_tlb_regs(struct amdgpu_device *adev)
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v12_0.c
index 6cbf837d50dd..ec3ff4dec674 100644
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
+				 ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
+	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index bfe247b1a333..27d7f7cb903f 100644
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
+					 ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
+		WREG32_SOC15(GC, 0, mmVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 	}
 
 	/* In the case squeezing vram into GART aperture, we don't use
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index fbdf46070b38..ed9a64bc5aaa 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -176,6 +176,8 @@ gfxhub_v1_2_xcc_init_system_aperture_regs(struct amdgpu_device *adev,
 			tmp = RREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL2);
 			tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
 					    ACTIVE_PAGE_MIGRATION_PTE_READ_RETRY, 1);
+			tmp = REG_SET_FIELD(tmp, VM_L2_PROTECTION_FAULT_CNTL2,
+					    ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
 			WREG32_SOC15(GC, GET_INST(GC, i), regVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 		}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 9ea593e2c719..152b2735d360 100644
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
+				 ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
+	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 30b90d35abd0..83c2ddbbd292 100644
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
+				 ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
+	WREG32_SOC15(GC, 0, mmGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index 9e6a6e13dec0..90bbb2fe4884 100644
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
+				 ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
+	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 }
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
index b3b1085c7cd3..1b3c067ab48c 100644
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
+				 ENABLE_RETRY_FAULT_INTERRUPT, !adev->gmc.noretry);
+	WREG32_SOC15(GC, 0, regGCVM_L2_PROTECTION_FAULT_CNTL2, tmp);
 }
 
 
-- 
2.54.0


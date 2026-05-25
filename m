Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42066CD5BD2
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 11:45:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90E5010E2BC;
	Mon, 25 May 2026 11:45:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mXaOmrZ5";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C96110E2B3
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 11:45:16 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso65728385e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 04:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779709514; x=1780314314; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SfxtZH65cg0i5+vzJglwkLDnyUm3JyyyOF6Kl2dYKv8=;
 b=mXaOmrZ5vC4ARap68h4YTb7OYxNjday2d6enk1Yt54x8R56o9pzX5db/stMy0z8ZpM
 CtijkpRCquZ/X9Awqu7E2SAaxPHfXhXodG7vrlaU/mUz/3gk8K+c6gFVxv27y2Nsy9c0
 b2TJ764gKMgi8uQ+ithhq6Nt75UjfreHF9H8IVpFxvT9jId+k5SVgKBz6iCGsMsO2ziw
 igLggdvMk9ESfV8VHQXRNuqtvDTmmpTbTPO2pUq5aUxs6Ixkj48mSJE3yYFJwGXz1vno
 6hwaSZaWydhfSmyYfxvohQXR9zfXCxA3kdanmBr1dgvtgH0s5vR3EuCqCaCSoCQUa86c
 q6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779709514; x=1780314314;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SfxtZH65cg0i5+vzJglwkLDnyUm3JyyyOF6Kl2dYKv8=;
 b=FGPo/742WEzTR2d6ZUaLWobvAi4v3+KylwEHAi/MDhfStzL3Wj6biOGG6QXjzmgaNm
 yyojJ3E4N/67lVDxuIhbffXS4tAzeJrD/NW1kaTvLI8Pcvc3QDrWhtc9Ls/3Tb89gfdh
 K7xBWdvjT8CyMxNTPCzftzUmrJHEn75JDyKX0H89W/Cx9NM7ZpLdVxT3BnGJiRwdGOia
 oTYArBHmdfPu/lbI7yYGxenTvGpvtwJ/n5mErjpjS1ZSZa2QVQVkSvJIl0HiwBTV3rBW
 zBK2F4FO6s6H5ZFtR5Vkgm9Siwvcb2B2dJRebqWRjzbeIL7LZm/jh4JAQJUcS1xGMSUE
 I7lw==
X-Gm-Message-State: AOJu0YwF4grUoaKdpkB6ysFNBFxs/W0WM8C3t+/6neztyNWW6vnjOEb6
 mlR/qfH+vZI44AQ0iF5C2IKv0vvjpFx/bH9c2JCR1uPRWT7oQMFjTNRGHlZRyQ==
X-Gm-Gg: Acq92OGABtvxpmBcMIXjRiei+ydiVicT4kus1sEn6GVfePvwkxv98O9DPIRrIc8/Pan
 l5GLO/Sg0jkw2eBL1aWtJjYoFqJsaelbwUkBNl95I4npdjz7lY2iOaOX5xTCziDqH8LYHV9enTu
 sbSYGMd52m2Cq93f55bZ7lXLZxWzcxKThqW4bGKRg+HfFrs9Id4V6GHF6AcbSzqBxqXgJdFHdSo
 8Q+nXTguU8jd+M0doA00zzpo67kVkvKoxX3JwuT7hcSLlxDIhrNfsskvvLZf6N9A1AUs/G+BSIw
 F8jmDeWecmg40+qR+48SDi11V8Ty0DiPULfHhW2WFrXnf66fU8+YvSsWtXEcQPrDDwo0UvlCTvZ
 /jzjWB9ewpuyzaudnOlRLt3H/PSKkG4rk2uUsT+H5U1/T40ViwsYw6SJnCS2xJY0mhqNoDqTlbd
 BEwB/WodJDW9XC2hc7fcT9RVRyuiFrXJxs0s2jHt/yhYbYnogseZZOVGZeIwX7ww9q
X-Received: by 2002:a05:600c:c4a1:b0:490:3fd9:e78b with SMTP id
 5b1f17b1804b1-490426cef8bmr239723575e9.17.1779709514512; 
 Mon, 25 May 2026 04:45:14 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4904527f7f7sm365533885e9.7.2026.05.25.04.45.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 04:45:14 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Amir Shetaia <Amir.Shetaia@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 5/7] drm/amdgpu/gfxhub: Enable retry fault interrupts when
 needed
Date: Mon, 25 May 2026 13:45:05 +0200
Message-ID: <20260525114507.24566-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525114507.24566-1-timur.kristof@gmail.com>
References: <20260525114507.24566-1-timur.kristof@gmail.com>
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


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E400C7EE23
	for <amd-gfx@archiver.kernel.org>; Wed, 24 May 2023 16:00:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E633010E692;
	Wed, 24 May 2023 16:00:50 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com
 [IPv6:2607:f8b0:4864:20::432])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B0D510E690
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 16:00:49 +0000 (UTC)
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-64d2da69fdfso1229479b3a.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 24 May 2023 09:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1684944049; x=1687536049;
 h=cc:to:subject:date:from:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GviRYCsAJgxSrmumt4169PkmX4dPudDea6W8dmD723U=;
 b=lpE8Kx4NUAq8Z9W9TSg2HEpcIs0CNnBBuhj82IUGaSXzOQmD8n80CkywNebvpNMc2X
 Rb14/wmXm8zd56O4v2Vpiylv0VDtEjGKp1h0xy3yZ4YDh1XY03wJ0hRwNdk2bbIHvkVU
 ilVFM9rgJLJUCYR5E2DP2uocNo9+Z06v6QO9GLosZ4VpJdANLy+3IQvuDznyB1I4Q5kC
 MYFy5SF31lAo5bapTh48hpL2Slka9NC+Y5keFv1AxN4YRu8IPlR3bj8eDT1Nz9CqJzl2
 fJdrjkU/QoDg2Y45LflQuzEn+z2W2GpkwKnmDkv6fbzmoIA/zI9YPofRLLgwrG7NZAkv
 v/BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684944049; x=1687536049;
 h=cc:to:subject:date:from:message-id:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GviRYCsAJgxSrmumt4169PkmX4dPudDea6W8dmD723U=;
 b=jSHQBWaViNqThi1+qFwomXYTiU9VTWB+zithV6G95BnfX7FsChLW42T7yq6i4lYonJ
 SwUypPHERghqaxPLGM9WDJVNg4N0luZl8kJpcPnmO2WoNl5OUpvw7qfPX7Cu5aPSzbh7
 XXXhRrDjkHWqF32tHPDvAWMeOcjRaaBaH7irj9HvPzgpWlIt64lhfD3pIJ6LW6E7cu0v
 ujEsNCsOPhT7SaC2kOU+yooQyLt6QOF+ec2T0yNlIQc3Q8pM5Fgi6d2W09x9Bhcx8oai
 h1iZcS19LutbJphylgL4kcnZZI/dZq5FPzYXajmccXzWTULucYLjxAjR4EwtDZp9iTEO
 nl/Q==
X-Gm-Message-State: AC+VfDxyQhUiqD5Vz/6UW25gpaMaagdqogz6JKMb8xee5K7Gnnjb2eQP
 0STxfUkkVmaRLSkAk9wxYpU=
X-Google-Smtp-Source: ACHHUZ4lnR4XYjBOhX7mkfdZdj/PZKimmis7fXlEE+5xO78yRUFwYIOCqistwMyKGJKtcO/B7YuAgA==
X-Received: by 2002:a05:6a00:2da8:b0:64f:5406:d59e with SMTP id
 fb40-20020a056a002da800b0064f5406d59emr3587677pfb.17.1684944049083; 
 Wed, 24 May 2023 09:00:49 -0700 (PDT)
Received: from localhost ([123.56.124.140]) by smtp.gmail.com with ESMTPSA id
 j4-20020aa79284000000b0064d1349dc31sm7531651pfa.199.2023.05.24.09.00.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 09:00:48 -0700 (PDT)
Message-ID: <646e34b0.a70a0220.b7bdd.d5a7@mx.google.com>
From: ghostfly233 <ghostfly23333@gmail.com>
Date: Wed, 24 May 2023 23:02:15 +0800
Subject: [PATCH v2] drm/amdgpu: Enable VM_CONTEXT1_CNTL after page table addr
 is set.
To: alexander.deucher@amd.com, christian.koenig@amd.com, Xinhui.Pan@amd.com
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
Cc: ghostfly23333@gmail.com, daniel@ffwll.ch, airlied@gmail.com,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

In setup_vmid_config functions of all mmhubs, the CONTEXT1_CNTL reg is
enabled before related CONTEXT1_PAGE_TABLE_START_ADDR and
CONTEXT1_PAGE_TABLE_END_ADDR regs are written, which may cause
undefined behavior.

This patch enable CONTEXT1_CNTL after page table addresses are set,
so that it can ensure no undefined behavior will happen.

Signed-off-by: Zibin Liu <ghostfly23333@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c   | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c   | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c   | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c   | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c   | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c    | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c    | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c    | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c    | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c    | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c    | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c  | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c  | 5 ++++-
 drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c    | 7 ++++++-
 15 files changed, 62 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
index ab2325f6c7ac..8ff4f70c97a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_0.c
@@ -261,7 +261,7 @@ static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    num_level);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
@@ -302,6 +302,9 @@ static void gfxhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(GC, 0, mmVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
index c59c6c85fbff..1c501066926b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v1_2.c
@@ -266,7 +266,7 @@ static void gfxhub_v1_2_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(GC, 0, regVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    num_level);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
@@ -311,6 +311,9 @@ static void gfxhub_v1_2_setup_vmid_config(struct amdgpu_device *adev)
 				    regVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(GC, 0, regVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
index 9b3a02527318..ef660f3bca7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_0.c
@@ -288,7 +288,7 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
@@ -324,6 +324,9 @@ static void gfxhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
index 4aacbbec31e2..791afc8e9e85 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v2_1.c
@@ -297,7 +297,7 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
@@ -333,6 +333,9 @@ static void gfxhub_v2_1_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(GC, 0, mmGCVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
index 13712640fa46..75d000884d4a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0.c
@@ -296,7 +296,7 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
@@ -332,6 +332,9 @@ static void gfxhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
index 6e0bd628c889..31d73e0b5fc9 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfxhub_v3_0_3.c
@@ -301,7 +301,7 @@ static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL,
@@ -337,6 +337,9 @@ static void gfxhub_v3_0_3_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, GCVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(GC, 0, regGCVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
index 15e7cbeae75b..8f18d1480104 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_0.c
@@ -243,7 +243,7 @@ static void mmhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    num_level);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
@@ -280,6 +280,9 @@ static void mmhub_v1_0_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(MMHUB, 0, mmVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
index 73afbf2facc9..25ef04683f36 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_7.c
@@ -275,7 +275,7 @@ static void mmhub_v1_7_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    num_level);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
@@ -314,6 +314,9 @@ static void mmhub_v1_7_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
index 342d1702104c..36ed09b60a08 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v1_8.c
@@ -267,7 +267,7 @@ static void mmhub_v1_8_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    num_level);
 		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL,
@@ -306,6 +306,9 @@ static void mmhub_v1_8_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, VM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
index 278e32db878d..272eb35c36e0 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_0.c
@@ -368,7 +368,7 @@ static void mmhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
@@ -405,6 +405,9 @@ static void mmhub_v2_0_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET_RLC(MMHUB, 0, mmMMVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
index fcf2813e70db..e1ec0c8aafed 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v2_3.c
@@ -286,7 +286,7 @@ static void mmhub_v2_3_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
@@ -323,6 +323,9 @@ static void mmhub_v2_3_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(MMHUB, 0, mmMMVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
index 17a792616979..b883b6b8d50d 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0.c
@@ -325,7 +325,7 @@ static void mmhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
@@ -362,6 +362,9 @@ static void mmhub_v3_0_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
index 26509b6b8c24..c34815a14802 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_1.c
@@ -312,7 +312,7 @@ static void mmhub_v3_0_1_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
@@ -349,6 +349,9 @@ static void mmhub_v3_0_1_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
index 26abbc6a47ab..ce3b2f1d9f8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v3_0_2.c
@@ -317,7 +317,7 @@ static void mmhub_v3_0_2_setup_vmid_config(struct amdgpu_device *adev)
 
 	for (i = 0; i <= 14; i++) {
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL, i);
-		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, PAGE_TABLE_DEPTH,
 				    adev->vm_manager.num_level);
 		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL,
@@ -354,6 +354,9 @@ static void mmhub_v3_0_2_setup_vmid_config(struct amdgpu_device *adev)
 		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_PAGE_TABLE_END_ADDR_HI32,
 				    i * hub->ctx_addr_distance,
 				    upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, MMVM_CONTEXT1_CNTL, ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(MMHUB, 0, regMMVM_CONTEXT1_CNTL,
+				    i * hub->ctx_distance, tmp);
 	}
 
 	hub->vm_cntx_cntl = tmp;
diff --git a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
index 72083e96222f..80e29291e6e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/mmhub_v9_4.c
@@ -310,7 +310,7 @@ static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
 		tmp = RREG32_SOC15_OFFSET(MMHUB, 0, mmVML2VC0_VM_CONTEXT1_CNTL,
 				hubid * MMHUB_INSTANCE_REGISTER_OFFSET + i);
 		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
-				    ENABLE_CONTEXT, 1);
+				    ENABLE_CONTEXT, 0);
 		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
 				    PAGE_TABLE_DEPTH,
 				    num_level);
@@ -357,6 +357,11 @@ static void mmhub_v9_4_setup_vmid_config(struct amdgpu_device *adev, int hubid)
 				hubid * MMHUB_INSTANCE_REGISTER_OFFSET +
 				i * hub->ctx_addr_distance,
 				upper_32_bits(adev->vm_manager.max_pfn - 1));
+		tmp = REG_SET_FIELD(tmp, VML2VC0_VM_CONTEXT1_CNTL,
+				    ENABLE_CONTEXT, 1);
+		WREG32_SOC15_OFFSET(MMHUB, 0, mmVML2VC0_VM_CONTEXT1_CNTL,
+				    hubid * MMHUB_INSTANCE_REGISTER_OFFSET +
+				    i * hub->ctx_distance, tmp);
 	}
 }
 
-- 
2.34.1


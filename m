Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C8FFAD3E6
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 01:16:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B5DDA10E2E0;
	Thu, 23 Apr 2026 01:16:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kTOhRTw/";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A32B10E2E0
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 01:16:20 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso60531155e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 18:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776906978; x=1777511778; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8epwCDO2z+jsYear23eiL/wglEyKKU8EMwWwUcRH4YQ=;
 b=kTOhRTw/uA7lYiKbvZAKGU08cjB7ZX8fp0vWbI0i9WXxRHt9xuU9NhW2H5/yam+Wdh
 ENGcEHiK8f3fjGtnWV257Io/jv+nJeER02PWu7LonC7b2t7Nc8yRtwZ//Gttr4XlbtdK
 9PTgNZVVXYgvRXaV4Nc4OnNTLYM/Pwx5XfRDRSyQoFDeadCWUPI7k7ZbbYO1iW7R79MK
 80iLxwGn4bzrabN7P+biWj1rm3wzT7w1LgC4fwtQMB1FDNFcgc0wPII0RkDFeBiR8WbL
 1Qe2zTr+o7TpgZG17U1kmtF5iTpfyJhdHasBMVZWDv7YabSHB3E33wmcncExpEq+AeYa
 JVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776906978; x=1777511778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8epwCDO2z+jsYear23eiL/wglEyKKU8EMwWwUcRH4YQ=;
 b=SJfSKW5tHotfcTX1zhBClxbp8Bp4Us3RNLCaUOgL0Wes/6SOpC9BWeTtMiLewM8iqh
 /3aWaKWlik5PFWY0LCwS1GlWj9vQqMfPdBtdx5dP5QHMbjRwNFLTtLr1wgRxrFnTBZ/j
 xXTR5U0TptdjJ3ZQhr11wrorzO3ucnl6N8xNCoTdyNIOBc7auHhG6oKSSiEMQI0qN8SS
 sEa5l5R1aia9ErChVtuCrjaJN5bTQjFsAbQHDrm3/szkXroPfuI7bNmf1JjOZSvk2sVv
 33s0X+8RKi4787WGa1mhDOIbpb9gPwugG+LIeU0RyAWvjUabnkUJ7sEYQdLuSQTQAgAd
 73wg==
X-Gm-Message-State: AOJu0YwJxsQNneG26+7S6+fKFvOrmw4+DFiM7zLANQuDvRYnrhz364rs
 eZnUH1TlGmBIF6ZF/Bh02LZivggnGFpWkPYEYkYrr2wcxbTKbQTwi8WDRzcSpw==
X-Gm-Gg: AeBDiet1DMZeLDPDr7iTCIb+xiVKJPhD68EcjxQEqSXrQBYI/E4Q4MjB8zncdBbV7c1
 VSkd9c2+M1hycmEvTwI5kKsEbeyLbGnaFPJQH23r5RJRdkHoYs1Ls4lyEStf3K3EevcgbSUKQt9
 9w436lPH9YMDgpZGwSIrf5OXLO1Ns3Zid0d1wlXcUcXUFAMN3YFU1rGoPD8gHQBXkYsGiBkdPny
 tAqyTlA7SeiNSBIJe1XAxgBX6pMDVGNd3rHmHOga0JfngGIP48HfRvj5JZbMqo4q+fcJ2oj/jZb
 4yAUVMelYTMeRqAvI/7uG5fXmU2Rcb2S0lXsTQNuv6AflUbCO4Q75hUvZHj2Dmll6AU+62il+lC
 7Qr3gfkg/bJnSPHCzQY/iuxAzVlcMpzeQ6cmukXRcmsvclAQr8zIEq3C4a9DlblRrefrj8J4yPO
 H9LNcOcbGlgy8CdZtaJ9AifHHU/VH0VLisg+jnENiySjUVJMUQCQQ9BOz5cFZxfAB2Gy7+/BEZu
 5FMwg==
X-Received: by 2002:a05:600c:5295:b0:485:30d4:6b9e with SMTP id
 5b1f17b1804b1-488fb77facemr353615985e9.21.1776906978520; 
 Wed, 22 Apr 2026 18:16:18 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a4b329542sm370664435e9.3.2026.04.22.18.16.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 18:16:18 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, John Olender <john.olender@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 02/11] drm/amdgpu/vce1: Check that the GPU address is < 128 MiB
Date: Thu, 23 Apr 2026 03:16:05 +0200
Message-ID: <20260423011614.309180-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423011614.309180-1-timur.kristof@gmail.com>
References: <20260423011614.309180-1-timur.kristof@gmail.com>
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

When ensuring the low 32-bit address, make sure it is
less than 128 MiB, otherwise the VCE seems to fail to initialize.
This seems to be an undocumented limitation of the firmware
validation mechanism. Note that in case of VCE1 the BAR
address is zero and we can't change it also due to the
firmware validator.

When programming the mmVCE_VCPU_CACHE_OFFSETn registers,
don't AND them with a mask. This is incorrect because
the register mask is actually 0x0fffffff and useless because
we already ensure the addresses are below the limit.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index 5b7b46d242c6d..edabec442cb63 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
@@ -313,17 +313,17 @@ static int vce_v1_0_mc_resume(struct amdgpu_device *adev)
 
 	offset =  adev->vce.gpu_addr + AMDGPU_VCE_FIRMWARE_OFFSET;
 	size = VCE_V1_0_FW_SIZE;
-	WREG32(mmVCE_VCPU_CACHE_OFFSET0, offset & 0x7fffffff);
+	WREG32(mmVCE_VCPU_CACHE_OFFSET0, offset);
 	WREG32(mmVCE_VCPU_CACHE_SIZE0, size);
 
 	offset += size;
 	size = VCE_V1_0_STACK_SIZE;
-	WREG32(mmVCE_VCPU_CACHE_OFFSET1, offset & 0x7fffffff);
+	WREG32(mmVCE_VCPU_CACHE_OFFSET1, offset);
 	WREG32(mmVCE_VCPU_CACHE_SIZE1, size);
 
 	offset += size;
 	size = VCE_V1_0_DATA_SIZE;
-	WREG32(mmVCE_VCPU_CACHE_OFFSET2, offset & 0x7fffffff);
+	WREG32(mmVCE_VCPU_CACHE_OFFSET2, offset);
 	WREG32(mmVCE_VCPU_CACHE_SIZE2, size);
 
 	WREG32_P(mmVCE_LMI_CTRL2, 0x0, ~0x100);
@@ -527,11 +527,15 @@ static int vce_v1_0_early_init(struct amdgpu_ip_block *ip_block)
  * To accomodate that, we put GART to the LOW address range
  * and reserve some GART pages where we map the VCPU BO,
  * so that it gets a 32-bit address.
+ *
+ * The BAR address is zero and we can't change it
+ * due to the firmware validation mechanism.
+ * It seems that it fails to initialize if the address is >= 128 MiB.
  */
 static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
 {
 	u64 bo_size = amdgpu_bo_size(adev->vce.vcpu_bo);
-	u64 max_vcpu_bo_addr = 0xffffffff - bo_size;
+	u64 max_vcpu_bo_addr = 0x07ffffff - bo_size;
 	u64 num_pages = ALIGN(bo_size, AMDGPU_GPU_PAGE_SIZE) / AMDGPU_GPU_PAGE_SIZE;
 	u64 pa = amdgpu_gmc_vram_pa(adev, adev->vce.vcpu_bo);
 	u64 flags = AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE | AMDGPU_PTE_VALID;
-- 
2.53.0


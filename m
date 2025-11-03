Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E234ACCFA04
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 22:24:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 875AE10E4C8;
	Mon,  3 Nov 2025 22:24:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Y9aS/icw";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9FA810E4C8
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 22:24:18 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-640c48b3b90so2087595a12.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 14:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762208657; x=1762813457; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=88UG9YP1qna137jzTbn3n6ZmEaw08eAT8kZD4CpsEH8=;
 b=Y9aS/icwkL0K1r4c9955tvavoYAWuztPNknXIQP951prwB+2WXntvsDbYznrVbJMHr
 ZeS3HHghNgquqjKRWg2jG3jO8/MFZe8+LhtJixdSl5lAJbpcw5+PJdnyTo59B2eBC+lq
 qOHR1eV/gXmsLITrqJfuVW3xXSYOuCmTKPhdA/1+Fhwxba/dyXxF0j0DLX8dmZmtky4z
 OOHj9tdHmcLuZNV8XTxRZT4ANj2nkeSsOq83CjmxTyj3gdQebb/RN2d80Jp+FmfAu7lz
 0n99EzWj0KsacJnQSEF9ELf7ztl6rJEDFQ+SUQKwV8ePZrJfs6xN4WvY0T8Au5d6fgL3
 FCeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762208657; x=1762813457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=88UG9YP1qna137jzTbn3n6ZmEaw08eAT8kZD4CpsEH8=;
 b=AF0NqYM4Ws+TKuw3DN6IaX+mDoXCNs9vXam/enGG3U65fH3wlPmNcHCf9d4r9Ksck1
 kJhF9BVAkW0mz0hp9+oJvQs9ZXn+7+IYNZkWLyrvwbvmb8Jv72UPvYrdQycAMvo51Ppl
 OGu+/NmfVVGyyDYDFfQwfYRGaDbh7F98OP/atvUc2RSepdL1ktXE7wNt8nxUHpcvvLtP
 zN1K/QDc1xSY/rmQHosOv2WS1YleoiJn4e1ymD7soSpn+8loiLWlCUxHd6/xQ0EkhHsI
 v+OjhNnq6l7w6Syh5R8ptQejV1UEMwsDuNM4kA+gAV5wmt8GrMnufg1ABw5fVR07HEl5
 EB6A==
X-Gm-Message-State: AOJu0YyIZHudtIhnz28Cp4YlC4xTzIeo7G/SP7keRJhlWRVnQjbihVES
 5cv3jZ49ZZ5OgzyeUBubK3RwPtCCmFDcdiYGu1KmYPBR3kgy7qZh9XBzGmuy5b0n
X-Gm-Gg: ASbGnctBQmKueRrAtXNi93zfq1WDy6OY6JQLdFXcK2AhOmv5PD1xYU9E/J0qldUjprV
 wPWlHnTuYngp+UixUvXUItcAZx18mn3bjuzMbT7q1wb7MnT8fztG6xVQRK8EKA3zdbhk/Dsx7BZ
 hBLjpFkIjkpcB2p34mB0cOkm2nwcxVkurmp+d2fUUDcuWbxUClXlIyMO6hRbfUjlYMU/eVcO2HX
 bddZK6WPsgAw4AB/8NODKL9X6BPJtAaAmHTM34np7dmfwmolKTDpYamINMY/G2XyaJq0tP7+xrT
 IAsTuLaRQgx3wH8puZ7MouubfdwtdqI0uxz/XYR2t/vUBpY3A7uPsOEVw3OtXW9U5yvnWwZIGaj
 FJL5s96lyEXSL9foD9lIi/SbYshfkuZY4njCt50rTynLtXg+od/yIsoYld8TMQCe5Ut6xiqLl6k
 8J0trAUE2qQgM1uFaKcME=
X-Google-Smtp-Source: AGHT+IHzsogQxs6NgcSqhPhrZeJaZEakSHAs8halNMLc3hdH+FugRY7ywOayioOzBT3FNSPUOO1/dA==
X-Received: by 2002:a05:6402:440d:b0:640:6512:b9f with SMTP id
 4fb4d7f45d1cf-640770209afmr14164156a12.28.1762208657115; 
 Mon, 03 Nov 2025 14:24:17 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6a5cb5dsm486635a12.17.2025.11.03.14.24.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 14:24:16 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 13/16] drm/amdgpu/vce1: Ensure VCPU BO is in lower 32-bit
 address space (v2)
Date: Mon,  3 Nov 2025 23:23:30 +0100
Message-ID: <20251103222333.37817-14-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103222333.37817-1-timur.kristof@gmail.com>
References: <20251103222333.37817-1-timur.kristof@gmail.com>
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

Based on research carried out by Alexandre and Christian.

VCE1 actually executes its code from the VCPU BO.
Due to various hardware limitations, the VCE1 requires
the VCPU BO to be in the low 32 bit address range.
However, VRAM is typically mapped at the high address range,
which means the VCPU can't access VRAM through the FB aperture.

To solve this, we write a few page table entries to
map the VCPU BO in the GART address range. And we make sure
that the GART is located at the low address range.
That way the VCE1 can access the VCPU BO.

v2:
- Adjust to v2 of the GART helper commit.
- Add empty line to multi-line comment.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 51 +++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index bf9f943852cb..feb6eccbc025 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
@@ -34,6 +34,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_vce.h"
+#include "amdgpu_gart.h"
 #include "sid.h"
 #include "vce_v1_0.h"
 #include "vce/vce_1_0_d.h"
@@ -46,6 +47,11 @@
 #define VCE_V1_0_DATA_SIZE	(7808 * (AMDGPU_MAX_VCE_HANDLES + 1))
 #define VCE_STATUS_VCPU_REPORT_FW_LOADED_MASK	0x02
 
+#define VCE_V1_0_GART_PAGE_START \
+	(AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GTT_NUM_TRANSFER_WINDOWS)
+#define VCE_V1_0_GART_ADDR_START \
+	(VCE_V1_0_GART_PAGE_START * AMDGPU_GPU_PAGE_SIZE)
+
 static void vce_v1_0_set_ring_funcs(struct amdgpu_device *adev);
 static void vce_v1_0_set_irq_funcs(struct amdgpu_device *adev);
 
@@ -513,6 +519,45 @@ static int vce_v1_0_early_init(struct amdgpu_ip_block *ip_block)
 	return 0;
 }
 
+/**
+ * vce_v1_0_ensure_vcpu_bo_32bit_addr() - ensure the VCPU BO has a 32-bit address
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Due to various hardware limitations, the VCE1 requires
+ * the VCPU BO to be in the low 32 bit address range.
+ * Ensure that the VCPU BO has a 32-bit GPU address,
+ * or return an error code when that isn't possible.
+ */
+static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
+{
+	u64 gpu_addr = amdgpu_bo_gpu_offset(adev->vce.vcpu_bo);
+	u64 bo_size = amdgpu_bo_size(adev->vce.vcpu_bo);
+	u64 max_vcpu_bo_addr = 0xffffffff - bo_size;
+	u64 num_pages = ALIGN(bo_size, AMDGPU_GPU_PAGE_SIZE) / AMDGPU_GPU_PAGE_SIZE;
+	u64 pa = amdgpu_gmc_vram_pa(adev, adev->vce.vcpu_bo);
+	u64 flags = AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE | AMDGPU_PTE_VALID;
+
+	/*
+	 * Check if the VCPU BO already has a 32-bit address.
+	 * Eg. if MC is configured to put VRAM in the low address range.
+	 */
+	if (gpu_addr <= max_vcpu_bo_addr)
+		return 0;
+
+	/* Check if we can map the VCPU BO in GART to a 32-bit address. */
+	if (adev->gmc.gart_start + VCE_V1_0_GART_ADDR_START > max_vcpu_bo_addr)
+		return -EINVAL;
+
+	amdgpu_gart_map_vram_range(adev, pa, VCE_V1_0_GART_PAGE_START,
+				   num_pages, flags, adev->gart.ptr);
+	adev->vce.gpu_addr = adev->gmc.gart_start + VCE_V1_0_GART_ADDR_START;
+	if (adev->vce.gpu_addr > max_vcpu_bo_addr)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int vce_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -532,6 +577,9 @@ static int vce_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 	r = vce_v1_0_load_fw_signature(adev);
+	if (r)
+		return r;
+	r = vce_v1_0_ensure_vcpu_bo_32bit_addr(adev);
 	if (r)
 		return r;
 
@@ -647,6 +695,9 @@ static int vce_v1_0_resume(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 	r = vce_v1_0_load_fw_signature(adev);
+	if (r)
+		return r;
+	r = vce_v1_0_ensure_vcpu_bo_32bit_addr(adev);
 	if (r)
 		return r;
 
-- 
2.51.0


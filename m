Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3FACCF9F2
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 22:06:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC4CB10E686;
	Tue, 28 Oct 2025 22:06:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Vaq0EKoH";
	dkim-atps=neutral
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D64B10E684
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 22:06:55 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-63e18829aa7so8780701a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 15:06:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761689214; x=1762294014; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=q3fKnTpToZQ5Ve7HmCRlzNmuOx7jkKfHCAGZycoVzs8=;
 b=Vaq0EKoHe6+kRCTXJvDLQX2DJ1B2VXUm+vVoapnYYf2cfTnRulEPeUpm3c0bhQ2DCK
 Iycty/+xxIAJM6ujoxQOziFYQy7Pm7r7oI8Rm4Tvu2R6MCj4XZRx4Azv+MH2HemGY79p
 yO3dhPoSGueUhcZOx/AXieLaNApwnqP4tl0v596InnN0/Tc9pUZmQ1jpd116X+K7kvNk
 CGmigPzkKlZ7ZoiW6iP2aKKEjpKmFpc8miAs9FSZy9mNmKudt0ic1Q0Q87GYS6VnBldh
 MV8U+VvLap82uCUke/UWPLbygu7p5lTOl0ZNb7NOw1LIkh/Lkvi/+tKMlM30IUnJuFpg
 lE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761689214; x=1762294014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q3fKnTpToZQ5Ve7HmCRlzNmuOx7jkKfHCAGZycoVzs8=;
 b=GfrILUP7pT2vyoWLfC8Sg2eMRwEcoomWhdjDD98TydkjL3xnpTVzBE5iAmdzdSKgFu
 1580DQgnyk6tIA6wLEkKaugoNgvbC6xG7pPWbUtNxyL9YWGyNVew0ZKepGOVncZEyVXr
 lpKS249wBQbVD1JAZA7xAfKGDn3tCCJEzxUmEAH6PJ+0sm7NysAxhqSqi9qpUSRmoK17
 NqDriWqUciTm98+dKJZ8hpu4qc3+9tK//6zWDK6dg6QYlbb+ygqVXoYKs6CsA/rlUl91
 oTgBgCFvoWxxvQC39auDdmioF9ciCIHVrv4OA5QnJW7FMClqVu64kCDeqisJbL1kSHvm
 Vtcw==
X-Gm-Message-State: AOJu0Yw+Rij6a78zdGyC8wGyNsmuoz9an06EgpxN48uBd8ae20uQfrO/
 oGsmsmTpllTTmma+JDN9/j5jiKG8UtsTwNWO4j0Baj83vM8Qxs43JH+l/SC4HA==
X-Gm-Gg: ASbGncsKLG2as3wUgn6CSuHcXXM0kUsE8qTIqt6rCGF1WN504Q1MiXtykWlXAznPLDM
 BMBJTneSs6Gd7WcFWyYzwI2sl8I4FYizbGItute6CBBd+1oSqu+2sKPAcasi8ZroKDFFqAbk9UL
 Z3lr2kTz3CeSp52snqPQQkF7tvKusaaqqzCkLPj0bBw/TMfQ9YUulhjtxV+/7grjBso8MDA0H44
 SOb948U7jBO5AXmUkvzZqpfhzKqWQx6S7vNDx59mlBaQvbpKy2DRTNLj9l0xxo6gzfqvfmbVbg/
 OAnkPFM7jRq2n4exTCk0fsgrKSQR5Cb2tz+gJbGDFAvTOOw7BwRDP8SWNdhl5Ynm878+gJHlDCd
 /yX+5N83UtZNCAAudiLQedjc1hUYDFXjGTq+1aOo+YB5QND93aOuB5AIE9A2XD10YWQa73wrunY
 lENkt7Psr2Kmg35/hM9hMhbGTkt6qFfXeJ+d7L7nRLINTeMICQo7f2Ua/dsbJStjHaQGNxKbC0d
 3JL6f5Zhpx8TSgMMRg=
X-Google-Smtp-Source: AGHT+IGJNb2EdG46qHnGSA0mnjgAhxn3GyHDJa97FMtpr5HNhb0R36ZmoJsqoT6R3AhJ2o0D2jFhbw==
X-Received: by 2002:a05:6402:d0b:b0:63b:fb47:95ea with SMTP id
 4fb4d7f45d1cf-640443738a8mr433584a12.33.1761689213579; 
 Tue, 28 Oct 2025 15:06:53 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24CBF70057E8101A3AD09709.dsl.pool.telekom.hu.
 [2001:4c4e:24cb:f700:57e8:101a:3ad0:9709])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640342e5acesm1881182a12.28.2025.10.28.15.06.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 15:06:52 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 11/14] drm/amdgpu/vce1: Ensure VCPU BO is in lower 32-bit
 address space
Date: Tue, 28 Oct 2025 23:06:25 +0100
Message-ID: <20251028220628.8371-12-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028220628.8371-1-timur.kristof@gmail.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
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

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Co-developed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 44 +++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index e62fd8ed1992..27f70146293d 100644
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
 
@@ -535,6 +541,38 @@ static int vce_v1_0_early_init(struct amdgpu_ip_block *ip_block)
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
+	const u64 gpu_addr = amdgpu_bo_gpu_offset(adev->vce.vcpu_bo);
+	const u64 bo_size = amdgpu_bo_size(adev->vce.vcpu_bo);
+	const u64 max_vcpu_bo_addr = 0xffffffff - bo_size;
+
+	/* Check if the VCPU BO already has a 32-bit address.
+	 * Eg. if MC is configured to put VRAM in the low address range.
+	 */
+	if (gpu_addr <= max_vcpu_bo_addr)
+		return 0;
+
+	/* Check if we can map the VCPU BO in GART to a 32-bit address. */
+	if (adev->gmc.gart_start + VCE_V1_0_GART_ADDR_START > max_vcpu_bo_addr)
+		return -EINVAL;
+
+	amdgpu_gart_bind_vram_bo(adev, VCE_V1_0_GART_ADDR_START, adev->vce.vcpu_bo,
+		AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE | AMDGPU_PTE_VALID);
+	adev->vce.gpu_addr = adev->gmc.gart_start + VCE_V1_0_GART_ADDR_START;
+		return 0;
+}
+
 static int vce_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
@@ -554,6 +592,9 @@ static int vce_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 	r = vce_v1_0_load_fw_signature(adev);
+	if (r)
+		return r;
+	r = vce_v1_0_ensure_vcpu_bo_32bit_addr(adev);
 	if (r)
 		return r;
 
@@ -669,6 +710,9 @@ static int vce_v1_0_resume(struct amdgpu_ip_block *ip_block)
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


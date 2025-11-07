Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD546CCFA1F
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 15:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D4B710EB0A;
	Fri,  7 Nov 2025 15:58:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IOZzGUEq";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C6EA10EB05
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 15:58:03 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4710022571cso9221605e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Nov 2025 07:58:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762531082; x=1763135882; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Qwbycg5WbXcilbtCGuIR01PtUrZTZTr4ApJjrIpNI00=;
 b=IOZzGUEqVLbvFX9ogEjPkF7+Z/jmU73546SnZp+1kNmgTgeOUS37MEH8SaWk9oQ0GL
 r1gk+uqmBZ2M4x4ELJxu8JBsMSgULOxv1C/LY5KZoITbddWKIAg+cJ42ohq1lOy1c1vt
 KF1ogaPPyWTdIhN247HEij8NqUiIsDLp3u3sm2koJGln1jTMw1HS21JLeZHdspL4lfOZ
 SkHCy4ixUHOLI/lagWftGlx5G7mtFi+4aidSt9yXRWiOX8pxRxKm1M291NNh95beF8ZZ
 H+lElDdQ1+PV/Wbvpkig6kXTDlRcsbzzJRnssAdJfKgilFCeoUiDmFFCcMuYlLV/PxmC
 R/6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762531082; x=1763135882;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Qwbycg5WbXcilbtCGuIR01PtUrZTZTr4ApJjrIpNI00=;
 b=aAgIjrebIeTtXaJmpZS9LczbqiQAxQaXqqMZuCP0zGv9IctTgwtbX76kynrMqqVLh6
 MBwTR+n+jCTIZ8ZoQqx4d4BCdj1wqCbfl1svZQeLihn4DKfCXRIwrElT37oYxikGOSLB
 YZNTzQDtsx/VTL5399W3wuIojMF/Llo5hNckSB22XVWdqMOKj28lm9JnxfUT1ULAPPrC
 OPmdURuaZWKQJq1K9q3cjUbOg5OnlVVzYbYXadVzXcLAcW1DbZozxSGMSatc0q6aaqS8
 d+5kpW/1xl7cH/W6uF9Z31R+YiptmQYlcqxNPcLFeVwHMoxTFCbBdj+ZuNnXoz0Bcksr
 mX9A==
X-Gm-Message-State: AOJu0Yz0n31DZ7xyik3YBLinc/WFFK090nOrxWAMGx+S5Vz2d+U/RfS+
 u5jZimH4aKwV/jXKygbIg3fOq+JPl3GVHvjivoD7BQc/slrF7e/0Hl0DwmHK2g==
X-Gm-Gg: ASbGnctH5e13HsbzYC/3KnZMGqM132M0rDUG5PD/GxFYZr7XL/HAVXSXiktMQ5nolME
 k3PI6zjRymIEEgSzT6H9draJsVcrnx1K8G6Q87fnKqSbr86sdt/ZCeUrHoiPLB4PlbG742t3EUd
 DKlyJnJ8b9fV7JrtUeK5+peIVXdYubCkRBFYy10JIwLVbKqM+OwoanCnH+j7B3F0RKjYYbU7cB2
 cCpZ2bXDOZe5TvH0Pbq+eR6JABvbltnnWBQOYK5+AUBdPcVV6Wi6rqjdbZYEa9jPBxuwHL4pQ+f
 nAZT4pXK2O5u4TSAI9GrsRQmnDHsyqikznXOTdbiQ6J0o5luSjT7kLeCJIAhr2EMo5hJuEyyybF
 IAzdmXTXR9xTsMEQKqFHKF3E0s2r7zhE/NZNY6xUBW7/AX8qbVZhD+kgNxz20FtuOSXt8Xxm0ev
 rPSjj4jGONfTWo9NvfepQ=
X-Google-Smtp-Source: AGHT+IEB2+VUAEH/z43pv2WgYnKV7m66S6htIVwWyP0QV7QczIJgI5HzU3OQUiWJFuq2PJJUtu/7ng==
X-Received: by 2002:a05:600c:1381:b0:477:fad:acd9 with SMTP id
 5b1f17b1804b1-4776bcc5191mr36925075e9.34.1762531081604; 
 Fri, 07 Nov 2025 07:58:01 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775cdc33c8sm170266365e9.2.2025.11.07.07.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 07:58:01 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 09/12] drm/amdgpu/vce1: Ensure VCPU BO is in lower 32-bit
 address space (v3)
Date: Fri,  7 Nov 2025 16:57:42 +0100
Message-ID: <20251107155745.8334-10-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107155745.8334-1-timur.kristof@gmail.com>
References: <20251107155745.8334-1-timur.kristof@gmail.com>
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

Based on research and ideas by Alexandre and Christian.

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

v3:
- Instead of relying on gmc_v6 to set the GART space before GTT,
  add a new function amdgpu_vce_required_gart_pages() which is
  called from amdgpu_gtt_mgr_init() directly.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c     | 18 +++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c       | 55 +++++++++++++++++++++
 4 files changed, 75 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 0760e70402ec..895c1e4c6747 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -284,6 +284,7 @@ int amdgpu_gtt_mgr_init(struct amdgpu_device *adev, uint64_t gtt_size)
 	ttm_resource_manager_init(man, &adev->mman.bdev, gtt_size);
 
 	start = AMDGPU_GTT_MAX_TRANSFER_SIZE * AMDGPU_GTT_NUM_TRANSFER_WINDOWS;
+	start += amdgpu_vce_required_gart_pages(adev);
 	size = (adev->gmc.gart_size >> PAGE_SHIFT) - start;
 	drm_mm_init(&mgr->mm, start, size);
 	spin_lock_init(&mgr->lock);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 7fead2eebd36..709ca369cb52 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -450,6 +450,24 @@ void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_file *filp)
 	}
 }
 
+/**
+ * amdgpu_vce_required_gart_pages() - gets number of GART pages required by VCE
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Returns how many GART pages we need before GTT for the VCE IP block.
+ * For VCE1, see vce_v1_0_ensure_vcpu_bo_32bit_addr for details.
+ * For VCE2+, this is not needed so return zero.
+ */
+u32 amdgpu_vce_required_gart_pages(struct amdgpu_device *adev)
+{
+	/* VCE IP block not added yet, so can't use amdgpu_ip_version */
+	if (adev->family == AMDGPU_FAMILY_SI)
+		return 512;
+
+	return 0;
+}
+
 /**
  * amdgpu_vce_get_create_msg - generate a VCE create msg
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
index 050783802623..1c3464ce5037 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
@@ -61,6 +61,7 @@ int amdgpu_vce_entity_init(struct amdgpu_device *adev, struct amdgpu_ring *ring)
 int amdgpu_vce_suspend(struct amdgpu_device *adev);
 int amdgpu_vce_resume(struct amdgpu_device *adev);
 void amdgpu_vce_free_handles(struct amdgpu_device *adev, struct drm_file *filp);
+u32 amdgpu_vce_required_gart_pages(struct amdgpu_device *adev);
 int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
 			     struct amdgpu_ib *ib);
 int amdgpu_vce_ring_parse_cs_vm(struct amdgpu_cs_parser *p,
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index bf9f943852cb..9ae424618556 100644
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
 
@@ -513,6 +519,49 @@ static int vce_v1_0_early_init(struct amdgpu_ip_block *ip_block)
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
+ *
+ * To accomodate that, we put GART to the LOW address range
+ * and reserve some GART pages where we map the VCPU BO,
+ * so that it gets a 32-bit address.
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
@@ -532,6 +581,9 @@ static int vce_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 	if (r)
 		return r;
 	r = vce_v1_0_load_fw_signature(adev);
+	if (r)
+		return r;
+	r = vce_v1_0_ensure_vcpu_bo_32bit_addr(adev);
 	if (r)
 		return r;
 
@@ -647,6 +699,9 @@ static int vce_v1_0_resume(struct amdgpu_ip_block *ip_block)
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


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1223F588C8
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 13:02:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADF7310E5C1;
	Mon, 20 Apr 2026 13:02:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="f+1gKOt4";
	dkim-atps=neutral
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com
 [74.125.82.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 661FF10E0FA
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Apr 2026 20:15:54 +0000 (UTC)
Received: by mail-dy1-f174.google.com with SMTP id
 5a478bee46e88-2d868d014a5so1784770eec.1
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Apr 2026 13:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1776543353; x=1777148153; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=HvLOD4MlNO/s15tDwkqNEwkMRzyNaOEKADtfVP29i9s=;
 b=f+1gKOt4N6PkoCfd6S0hqnluJ1NB0h5XAXfR+oduchaRXUV1CzsbZRD4rhb82qrprC
 oCSRCARZiY2Umw5ObnpekaYlacQYDlTcIt9c+WSrdlCmb1CfUI6RbBgVpLz3KFOw3yW4
 q1k3rhFm48YSA0mN/YGSRb35bQB1CXv6nxGXiZJElwy7Uh2PXKJ6FPMQz7gRbfd48fyT
 ASmkyopwFq11tiyuBeuf486j8ruy+CyTQdVML4uLnp9mrUL8o7lVvXpJppKpzL3PmOEX
 q4BbrcbpgX5FBqLxVbv5YbEZU14S6StSzLusWseASPlYxSIOUtTIji+ouHpfIPbD0Emb
 8YEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776543353; x=1777148153;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HvLOD4MlNO/s15tDwkqNEwkMRzyNaOEKADtfVP29i9s=;
 b=lBUsEK8wZFc0BeryF7uzTR1dWf6vTJeHGI25QU8Us+plvqU/xqAlMGbpmeI8dM+rDK
 KZzC7SpfO02k1bncJBbnYSlwhpL68PhfSIrjqLOeR1CaHVBVXYKnUz1KNWvlpotixCw5
 9Jj2NnyY+qjKo3ZmR4EIvPTqucu3I+8w/LZaZYpQ3S1kU4dKONiauemNWhkcS3gdEmNI
 qO9t06kYc7LSYyEjxbOOSCTVzf9ic2jJwH00M626F59PT3W+dKQO3olyXHCumM0W+Evx
 K7m/npM1bZmZnEdqka5IrTJO2O5AIO7VZZBFdKzBFSoPAhIgGVKW5+RKoLvRbIPo84vb
 FMYQ==
X-Gm-Message-State: AOJu0YyGGXkJDNXGFD8PoyNTyTPw358sBruRZuk+8hODuYereUeqXnCN
 mhlKaBkKPjR3x27MJ6hT9//BYN9l+JLF0dv2LpIdt7k9K+X2JnYtx0TBDuKnDiMk3QY=
X-Gm-Gg: AeBDievtGg1+V1XiGGRa5T7ykTI81QkMeR1bxWWXCEzYZdRrEhbuSTpWHKP3d+2I9aq
 CZzwgKCxuL+LnXRRr/Qf3gAviEf9FbYXfKzJt5WFBqLVYTz0Nd/W+NZPMcaj4WxILkaSAtfKA6j
 BcVrR3Y+RQJSGyCzLGHdrY05CoxCeiTYLZAdoC8bMMsGuGim9Ey9SHBmatEi7zTCjey3UN1IFME
 bawoWAcN80dilQmSYkkJgS6NzsB1NEgJF9hatv5g7hy13kIZORns8msWpjYlXpgl21gKAiNHKsY
 wcnkU6jH8Fbvsup8zVKhPj7m2qWsz3sZ737IYYYyOB3PTAsZgX5NoRG7W67Z28nrfT85osMrYZD
 zwJB2l4NilsuaKt25q503wMxLrK1iUDr8/UG0Z2PKWActLfIXDeRal/x2HQpTsYJDI3037nNToP
 /5M3tXkY2HgfOPmZsuVx2KwWGzuxJJLrTFgpG6UFT7mFLGGW2H/bW5fYjRvA==
X-Received: by 2002:a05:7301:4186:b0:2d9:a799:3c4f with SMTP id
 5a478bee46e88-2e478e0c6a5mr4324135eec.24.1776543353194; 
 Sat, 18 Apr 2026 13:15:53 -0700 (PDT)
Received: from DontFreeze.tail1d9320.ts.net ([189.110.124.221])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53d4bdaf7sm7236083eec.25.2026.04.18.13.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Apr 2026 13:15:52 -0700 (PDT)
From: Andre Hirata <andrejhirata@usp.br>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: amd-gfx@lists.freedesktop.org, andrejhirata@usp.br, gabriel.dimant@usp.br,
 guilhermesangabriel@usp.br
Subject: [PATCH] drm/amdgpu: unify gmc v10 and v11 get_vm_pde and get_vm_pte
 into common helpers
Date: Sat, 18 Apr 2026 17:15:40 -0300
Message-ID: <20260418201545.20673-1-andrejhirata@usp.br>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Apr 2026 13:02:49 +0000
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

gmc_v10_0_get_vm_pde, gmc_v10_0_get_vm_pte and their v11 counterparts
are identical. Move the shared implementation to amdgpu_gmc.c as
amdgpu_gmc_get_vm_pde and amdgpu_gmc_get_vm_pte, and update both
gmc_v10_0 and gmc_v11_0 to use the common helpers to eliminate
code duplication.

No functional changes intended. BUG_ON preserved from original
gmc_v10_0 and gmc_v11_0 implementations.

Signed-off-by: Andre Hirata <andrejhirata@usp.br>
Co-developed-by: Gabriel Dimant <gabriel.dimant@usp.br>
Signed-off-by: Gabriel Dimant <gabriel.dimant@usp.br>
Co-developed-by: Guilherme Gabriel <guilhermesangabriel@usp.br>
Signed-off-by: Guilherme Gabriel <guilhermesangabriel@usp.br>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c |  76 +++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h |   7 ++
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c  | 119 +++++-------------------
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c  | 119 +++++-------------------
 4 files changed, 131 insertions(+), 190 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 290b9f904..bd7b0a269 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -36,6 +36,7 @@
 #include "amdgpu_xgmi.h"
 #include "amdgpu_atomfirmware.h"
 
+#include "navi10_enum.h"
 #include <drm/drm_drv.h>
 #include <drm/ttm/ttm_tt.h>
 
@@ -1782,3 +1783,78 @@ int amdgpu_gmc_get_vram_info(struct amdgpu_device *adev,
 	}
 	return 0;
 }
+
+/*
+ * Common get_vm_pde implementation for gmc v10 and v11.
+ */
+void amdgpu_gmc_get_nv_vm_pde(struct amdgpu_device *adev, int level,
+			    uint64_t *addr, uint64_t *flags)
+{
+	if (!(*flags & AMDGPU_PDE_PTE) && !(*flags & AMDGPU_PTE_SYSTEM))
+		*addr = amdgpu_gmc_vram_mc2pa(adev, *addr);
+	BUG_ON(*addr & 0xFFFF00000000003FULL);
+
+	if (!adev->gmc.translate_further)
+		return;
+
+	if (level == AMDGPU_VM_PDB1) {
+		/* Set the block fragment size */
+		if (!(*flags & AMDGPU_PDE_PTE))
+			*flags |= AMDGPU_PDE_BFS(0x9);
+	} else if (level == AMDGPU_VM_PDB0) {
+		if (*flags & AMDGPU_PDE_PTE)
+			*flags &= ~AMDGPU_PDE_PTE;
+		else
+			*flags |= AMDGPU_PTE_TF;
+	}
+}
+
+/*
+ * Common get_vm_pte implementation for gmc v10 and v11.
+ */
+void amdgpu_gmc_get_nv_vm_pte(struct amdgpu_device *adev,
+			    struct amdgpu_vm *vm,
+			    struct amdgpu_bo *bo,
+			    uint32_t vm_flags,
+			    uint64_t *flags)
+{
+	if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
+		*flags |= AMDGPU_PTE_EXECUTABLE;
+	else
+		*flags &= ~AMDGPU_PTE_EXECUTABLE;
+
+	switch (vm_flags & AMDGPU_VM_MTYPE_MASK) {
+	case AMDGPU_VM_MTYPE_DEFAULT:
+	case AMDGPU_VM_MTYPE_NC:
+	default:
+		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_NC);
+		break;
+	case AMDGPU_VM_MTYPE_WC:
+		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_WC);
+		break;
+	case AMDGPU_VM_MTYPE_CC:
+		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_CC);
+		break;
+	case AMDGPU_VM_MTYPE_UC:
+		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
+		break;
+	}
+
+	if (vm_flags & AMDGPU_VM_PAGE_NOALLOC)
+		*flags |= AMDGPU_PTE_NOALLOC;
+	else
+		*flags &= ~AMDGPU_PTE_NOALLOC;
+
+	if (vm_flags & AMDGPU_VM_PAGE_PRT) {
+		*flags |= AMDGPU_PTE_PRT;
+		*flags |= AMDGPU_PTE_SNOOPED;
+		*flags |= AMDGPU_PTE_LOG;
+		*flags |= AMDGPU_PTE_SYSTEM;
+		*flags &= ~AMDGPU_PTE_VALID;
+	}
+
+	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
+			       AMDGPU_GEM_CREATE_EXT_COHERENT |
+			       AMDGPU_GEM_CREATE_UNCACHED))
+		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
index 6ab4c1e29..a852ed8ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -484,4 +484,11 @@ void amdgpu_gmc_init_sw_mem_ranges(struct amdgpu_device *adev,
 				   struct amdgpu_mem_partition_info *mem_ranges);
 int amdgpu_gmc_get_vram_info(struct amdgpu_device *adev,
 		int *vram_width, int *vram_type, int *vram_vendor);
+void amdgpu_gmc_get_nv_vm_pde(struct amdgpu_device *adev, int level,
+			    uint64_t *addr, uint64_t *flags);
+void amdgpu_gmc_get_nv_vm_pte(struct amdgpu_device *adev,
+			    struct amdgpu_vm *vm,
+			    struct amdgpu_bo *bo,
+			    uint32_t vm_flags,
+			    uint64_t *flags);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index e1ace7d44..129c7fc4b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -418,6 +418,28 @@ static void gmc_v10_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int
 	amdgpu_ring_emit_wreg(ring, reg, pasid);
 }
 
+static unsigned int gmc_v10_0_get_vbios_fb_size(struct amdgpu_device *adev)
+{
+	u32 d1vga_control = RREG32_SOC15(DCE, 0, mmD1VGA_CONTROL);
+	unsigned int size;
+
+	if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
+		size = AMDGPU_VBIOS_VGA_ALLOCATION;
+	} else {
+		u32 viewport;
+		u32 pitch;
+
+		viewport = RREG32_SOC15(DCE, 0, mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION);
+		pitch = RREG32_SOC15(DCE, 0, mmHUBPREQ0_DCSURF_SURFACE_PITCH);
+		size = (REG_GET_FIELD(viewport,
+					HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_HEIGHT) *
+				REG_GET_FIELD(pitch, HUBPREQ0_DCSURF_SURFACE_PITCH, PITCH) *
+				4);
+	}
+
+	return size;
+}
+
 /*
  * PTE format on NAVI 10:
  * 63:59 reserved
@@ -450,106 +472,13 @@ static void gmc_v10_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int
  * 1 system
  * 0 valid
  */
-
-static void gmc_v10_0_get_vm_pde(struct amdgpu_device *adev, int level,
-				 uint64_t *addr, uint64_t *flags)
-{
-	if (!(*flags & AMDGPU_PDE_PTE) && !(*flags & AMDGPU_PTE_SYSTEM))
-		*addr = amdgpu_gmc_vram_mc2pa(adev, *addr);
-	BUG_ON(*addr & 0xFFFF00000000003FULL);
-
-	if (!adev->gmc.translate_further)
-		return;
-
-	if (level == AMDGPU_VM_PDB1) {
-		/* Set the block fragment size */
-		if (!(*flags & AMDGPU_PDE_PTE))
-			*flags |= AMDGPU_PDE_BFS(0x9);
-
-	} else if (level == AMDGPU_VM_PDB0) {
-		if (*flags & AMDGPU_PDE_PTE)
-			*flags &= ~AMDGPU_PDE_PTE;
-		else
-			*flags |= AMDGPU_PTE_TF;
-	}
-}
-
-static void gmc_v10_0_get_vm_pte(struct amdgpu_device *adev,
-				 struct amdgpu_vm *vm,
-				 struct amdgpu_bo *bo,
-				 uint32_t vm_flags,
-				 uint64_t *flags)
-{
-	if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
-		*flags |= AMDGPU_PTE_EXECUTABLE;
-	else
-		*flags &= ~AMDGPU_PTE_EXECUTABLE;
-
-	switch (vm_flags & AMDGPU_VM_MTYPE_MASK) {
-	case AMDGPU_VM_MTYPE_DEFAULT:
-	case AMDGPU_VM_MTYPE_NC:
-	default:
-		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_NC);
-		break;
-	case AMDGPU_VM_MTYPE_WC:
-		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_WC);
-		break;
-	case AMDGPU_VM_MTYPE_CC:
-		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_CC);
-		break;
-	case AMDGPU_VM_MTYPE_UC:
-		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
-		break;
-	}
-
-	if (vm_flags & AMDGPU_VM_PAGE_NOALLOC)
-		*flags |= AMDGPU_PTE_NOALLOC;
-	else
-		*flags &= ~AMDGPU_PTE_NOALLOC;
-
-	if (vm_flags & AMDGPU_VM_PAGE_PRT) {
-		*flags |= AMDGPU_PTE_PRT;
-		*flags |= AMDGPU_PTE_SNOOPED;
-		*flags |= AMDGPU_PTE_LOG;
-		*flags |= AMDGPU_PTE_SYSTEM;
-		*flags &= ~AMDGPU_PTE_VALID;
-	}
-
-	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
-			       AMDGPU_GEM_CREATE_EXT_COHERENT |
-			       AMDGPU_GEM_CREATE_UNCACHED))
-		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
-}
-
-static unsigned int gmc_v10_0_get_vbios_fb_size(struct amdgpu_device *adev)
-{
-	u32 d1vga_control = RREG32_SOC15(DCE, 0, mmD1VGA_CONTROL);
-	unsigned int size;
-
-	if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
-		size = AMDGPU_VBIOS_VGA_ALLOCATION;
-	} else {
-		u32 viewport;
-		u32 pitch;
-
-		viewport = RREG32_SOC15(DCE, 0, mmHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION);
-		pitch = RREG32_SOC15(DCE, 0, mmHUBPREQ0_DCSURF_SURFACE_PITCH);
-		size = (REG_GET_FIELD(viewport,
-					HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_HEIGHT) *
-				REG_GET_FIELD(pitch, HUBPREQ0_DCSURF_SURFACE_PITCH, PITCH) *
-				4);
-	}
-
-	return size;
-}
-
 static const struct amdgpu_gmc_funcs gmc_v10_0_gmc_funcs = {
 	.flush_gpu_tlb = gmc_v10_0_flush_gpu_tlb,
 	.flush_gpu_tlb_pasid = gmc_v10_0_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v10_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v10_0_emit_pasid_mapping,
-	.get_vm_pde = gmc_v10_0_get_vm_pde,
-	.get_vm_pte = gmc_v10_0_get_vm_pte,
+	.get_vm_pde = amdgpu_gmc_get_nv_vm_pde,
+	.get_vm_pte = amdgpu_gmc_get_nv_vm_pte,
 	.get_vbios_fb_size = gmc_v10_0_get_vbios_fb_size,
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 94d6631ce..f1ac292b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -410,6 +410,28 @@ static void gmc_v11_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int
 	amdgpu_ring_emit_wreg(ring, reg, pasid);
 }
 
+static unsigned int gmc_v11_0_get_vbios_fb_size(struct amdgpu_device *adev)
+{
+	u32 d1vga_control = RREG32_SOC15(DCE, 0, regD1VGA_CONTROL);
+	unsigned int size;
+
+	if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
+		size = AMDGPU_VBIOS_VGA_ALLOCATION;
+	} else {
+		u32 viewport;
+		u32 pitch;
+
+		viewport = RREG32_SOC15(DCE, 0, regHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION);
+		pitch = RREG32_SOC15(DCE, 0, regHUBPREQ0_DCSURF_SURFACE_PITCH);
+		size = (REG_GET_FIELD(viewport,
+					HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_HEIGHT) *
+				REG_GET_FIELD(pitch, HUBPREQ0_DCSURF_SURFACE_PITCH, PITCH) *
+				4);
+	}
+
+	return size;
+}
+
 /*
  * PTE format:
  * 63:59 reserved
@@ -441,106 +463,13 @@ static void gmc_v11_0_emit_pasid_mapping(struct amdgpu_ring *ring, unsigned int
  * 1 system
  * 0 valid
  */
-
-static void gmc_v11_0_get_vm_pde(struct amdgpu_device *adev, int level,
-				 uint64_t *addr, uint64_t *flags)
-{
-	if (!(*flags & AMDGPU_PDE_PTE) && !(*flags & AMDGPU_PTE_SYSTEM))
-		*addr = amdgpu_gmc_vram_mc2pa(adev, *addr);
-	BUG_ON(*addr & 0xFFFF00000000003FULL);
-
-	if (!adev->gmc.translate_further)
-		return;
-
-	if (level == AMDGPU_VM_PDB1) {
-		/* Set the block fragment size */
-		if (!(*flags & AMDGPU_PDE_PTE))
-			*flags |= AMDGPU_PDE_BFS(0x9);
-
-	} else if (level == AMDGPU_VM_PDB0) {
-		if (*flags & AMDGPU_PDE_PTE)
-			*flags &= ~AMDGPU_PDE_PTE;
-		else
-			*flags |= AMDGPU_PTE_TF;
-	}
-}
-
-static void gmc_v11_0_get_vm_pte(struct amdgpu_device *adev,
-				 struct amdgpu_vm *vm,
-				 struct amdgpu_bo *bo,
-				 uint32_t vm_flags,
-				 uint64_t *flags)
-{
-	if (vm_flags & AMDGPU_VM_PAGE_EXECUTABLE)
-		*flags |= AMDGPU_PTE_EXECUTABLE;
-	else
-		*flags &= ~AMDGPU_PTE_EXECUTABLE;
-
-	switch (vm_flags & AMDGPU_VM_MTYPE_MASK) {
-	case AMDGPU_VM_MTYPE_DEFAULT:
-	case AMDGPU_VM_MTYPE_NC:
-	default:
-		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_NC);
-		break;
-	case AMDGPU_VM_MTYPE_WC:
-		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_WC);
-		break;
-	case AMDGPU_VM_MTYPE_CC:
-		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_CC);
-		break;
-	case AMDGPU_VM_MTYPE_UC:
-		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
-		break;
-	}
-
-	if (vm_flags & AMDGPU_VM_PAGE_NOALLOC)
-		*flags |= AMDGPU_PTE_NOALLOC;
-	else
-		*flags &= ~AMDGPU_PTE_NOALLOC;
-
-	if (vm_flags & AMDGPU_VM_PAGE_PRT) {
-		*flags |= AMDGPU_PTE_PRT;
-		*flags |= AMDGPU_PTE_SNOOPED;
-		*flags |= AMDGPU_PTE_LOG;
-		*flags |= AMDGPU_PTE_SYSTEM;
-		*flags &= ~AMDGPU_PTE_VALID;
-	}
-
-	if (bo && bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
-			       AMDGPU_GEM_CREATE_EXT_COHERENT |
-			       AMDGPU_GEM_CREATE_UNCACHED))
-		*flags = AMDGPU_PTE_MTYPE_NV10(*flags, MTYPE_UC);
-}
-
-static unsigned int gmc_v11_0_get_vbios_fb_size(struct amdgpu_device *adev)
-{
-	u32 d1vga_control = RREG32_SOC15(DCE, 0, regD1VGA_CONTROL);
-	unsigned int size;
-
-	if (REG_GET_FIELD(d1vga_control, D1VGA_CONTROL, D1VGA_MODE_ENABLE)) {
-		size = AMDGPU_VBIOS_VGA_ALLOCATION;
-	} else {
-		u32 viewport;
-		u32 pitch;
-
-		viewport = RREG32_SOC15(DCE, 0, regHUBP0_DCSURF_PRI_VIEWPORT_DIMENSION);
-		pitch = RREG32_SOC15(DCE, 0, regHUBPREQ0_DCSURF_SURFACE_PITCH);
-		size = (REG_GET_FIELD(viewport,
-					HUBP0_DCSURF_PRI_VIEWPORT_DIMENSION, PRI_VIEWPORT_HEIGHT) *
-				REG_GET_FIELD(pitch, HUBPREQ0_DCSURF_SURFACE_PITCH, PITCH) *
-				4);
-	}
-
-	return size;
-}
-
 static const struct amdgpu_gmc_funcs gmc_v11_0_gmc_funcs = {
 	.flush_gpu_tlb = gmc_v11_0_flush_gpu_tlb,
 	.flush_gpu_tlb_pasid = gmc_v11_0_flush_gpu_tlb_pasid,
 	.emit_flush_gpu_tlb = gmc_v11_0_emit_flush_gpu_tlb,
 	.emit_pasid_mapping = gmc_v11_0_emit_pasid_mapping,
-	.get_vm_pde = gmc_v11_0_get_vm_pde,
-	.get_vm_pte = gmc_v11_0_get_vm_pte,
+	.get_vm_pde = amdgpu_gmc_get_nv_vm_pde,
+	.get_vm_pte = amdgpu_gmc_get_nv_vm_pte,
 	.get_vbios_fb_size = gmc_v11_0_get_vbios_fb_size,
 };
 
-- 
2.43.0


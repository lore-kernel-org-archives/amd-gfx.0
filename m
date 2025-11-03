Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55287CCFA03
	for <amd-gfx@archiver.kernel.org>; Mon,  3 Nov 2025 22:24:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F0E2110E4BD;
	Mon,  3 Nov 2025 22:24:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Gi8fxmV9";
	dkim-atps=neutral
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15D2810E4BD
 for <amd-gfx@lists.freedesktop.org>; Mon,  3 Nov 2025 22:24:00 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-640c6577120so2330791a12.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 03 Nov 2025 14:24:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762208638; x=1762813438; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=XmVbMaa/+xRL1VAsk6MyL8UQ7NDvgJprfhukvmfR3bw=;
 b=Gi8fxmV9Df5FkPqT+WW4CXkgqcGR9Hr2VjXaVfHewGnlK12m6aARBHj9Uzr/tA1yv9
 FYgHbLvV9lCONC3GezQiQU89HctyDGdzufEtFxH2cRl5Tzfb/sR4PyjHC0ktxd36OyIr
 puR75Mabu0MWpimyMBXOQW2mFpV8jp0K8tv3SJ2s6t8ap+AFv8K6U7N/4DkoqW5oDi5H
 KTOu3uF2KQKexLIex4ImSml+2WD54locsx02TKkMcsSLq8lJFrLmaEr7hKag0Tx56aDI
 TvgfWDGzbkymDRM+u+eNjZiVBY0XOPUbmur30pcso2VOHaknLcemjRm6iaDP8W+eJwEK
 M4tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762208638; x=1762813438;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XmVbMaa/+xRL1VAsk6MyL8UQ7NDvgJprfhukvmfR3bw=;
 b=h8fZ0D2KLmcgPFqKE2gJ3VxP/754RZd1TI9qQK3zqiqYC9jKPkJ2EUdmcdM/BvUUHd
 9yuSkqbaV7UtK0i2aLj8DBz4yyrokITWaswq+o4rioIf+YtQJyTScaMLU6Z7lBr2YTis
 rHbP5EBfn260dPHvED0okNBS6pxgN+cB5qa022ucZLziKrKIqlcCrSAuBQgk4hMkim9S
 J/1wzXrG2F19soM7e8+hI9rGscAXXgJrZ4aEsntq3OOJl51NtEebpWhwGfuEVqcRSXMk
 rjUr8H6fvy8moKEV2ghYLn1mHPaBt6prJU9kS/4pupk+RrJukaVwRtW3GOFRDrn6kUAn
 dhuA==
X-Gm-Message-State: AOJu0Yw3drmafGFKs1Mr7biZJ9rfSuJwgggK3gj5ZPWWQmAt0IUOA5G7
 DXiAqycxgNsbbIrk4yyFUwPMRo/gbgmxO3DKs/YvptoBKZqA08vBxrquM1Wz48AZ
X-Gm-Gg: ASbGnctzvhxjqe8LYm2Dza5qIauR5EfeWfkjerJzucBH0+tRaKH3ogvgWr62rfLpu0f
 qLpEVSxY5wqad+jqFJSNKBkh7dFFfYTb7D9+j6gHChI7jIUCXu1skkQv7EFMWKIxhHFU2BrpYZZ
 ca13fO/G6RPGTV+ZGsfSgn0D7FxRNLLcFh6KX6InQ0NIUf4whnh5CESw+bb8EbqCV+Ul3i0ghIg
 28CUa3vdliexKJM1+YNrvUx9qaN9daa6v+ILrH8cPhERUj4eOBMaQgFV0Ef5IWFVH+3iGkKPwqo
 0VsATTK5biHgUzYAaZosq30NKM9NBnV18loQiVLbtBW1MprNSml5IRQaAexlUOLIpuz7p3RYq7C
 euIf4hGcB1nfmv9IdcdDYGeZwjP8GHQgQho1AuHTbfgxhd+uf/PnvwCthgx840063ImG7+196/1
 nSFTaNw9q9LJAAK186tJznHLc04wmOhg==
X-Google-Smtp-Source: AGHT+IHnihXQfejIxX7IwUjmvzkxFH89YNJMmXSOXOgwytTw1srOZHAj9HI8AB91ZdXnlrXrBMzcng==
X-Received: by 2002:a05:6402:90e:b0:640:c779:909 with SMTP id
 4fb4d7f45d1cf-640c7790aaamr3915613a12.27.1762208638517; 
 Mon, 03 Nov 2025 14:23:58 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640e6a5cb5dsm486635a12.17.2025.11.03.14.23.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 14:23:57 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 04/16] drm/amdgpu/gart: Add helper to bind VRAM pages (v2)
Date: Mon,  3 Nov 2025 23:23:21 +0100
Message-ID: <20251103222333.37817-5-timur.kristof@gmail.com>
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

Binds pages that located in VRAM to the GART page table.

Useful when a kernel BO is located in VRAM but
needs to be accessed from the GART address space,
for example to give a kernel BO a 32-bit address
when GART is placed in LOW address space.

v2:
- Refactor function to be more reusable

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 36 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h |  3 ++
 2 files changed, 39 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
index 83f3b94ed975..d2237ce9da70 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
@@ -367,6 +367,42 @@ void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
 	drm_dev_exit(idx);
 }
 
+/**
+ * amdgpu_gart_map_vram_range - map VRAM pages into the GART page table
+ *
+ * @adev: amdgpu_device pointer
+ * @pa: physical address of the first page to be mapped
+ * @start_page: first page to map in the GART aperture
+ * @num_pages: number of pages to be mapped
+ * @flags: page table entry flags
+ * @dst: CPU address of the GART table
+ *
+ * Binds a BO that is allocated in VRAM to the GART page table
+ * (all ASICs).
+ *
+ * Useful when a kernel BO is located in VRAM but
+ * needs to be accessed from the GART address space.
+ */
+void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t pa,
+				uint64_t start_page, uint64_t num_pages,
+				uint64_t flags, void *dst)
+{
+	u32 i, idx;
+
+	/* The SYSTEM flag indicates the pages aren't in VRAM. */
+	WARN_ON_ONCE(flags & AMDGPU_PTE_SYSTEM);
+
+	if (!drm_dev_enter(adev_to_drm(adev), &idx))
+		return;
+
+	for (i = 0; i < num_pages; ++i) {
+		amdgpu_gmc_set_pte_pde(adev, adev->gart.ptr,
+			start_page + i, pa + AMDGPU_GPU_PAGE_SIZE * i, flags);
+	}
+
+	drm_dev_exit(idx);
+}
+
 /**
  * amdgpu_gart_bind - bind pages into the gart page table
  *
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
index 7cc980bf4725..d3118275ddae 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.h
@@ -64,5 +64,8 @@ void amdgpu_gart_map(struct amdgpu_device *adev, uint64_t offset,
 		     void *dst);
 void amdgpu_gart_bind(struct amdgpu_device *adev, uint64_t offset,
 		      int pages, dma_addr_t *dma_addr, uint64_t flags);
+void amdgpu_gart_map_vram_range(struct amdgpu_device *adev, uint64_t pa,
+				uint64_t start_page, uint64_t num_pages,
+				uint64_t flags, void *dst);
 void amdgpu_gart_invalidate_tlb(struct amdgpu_device *adev);
 #endif
-- 
2.51.0


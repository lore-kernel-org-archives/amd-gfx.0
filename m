Return-Path: <SRS0=OHPl=37=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51AFFC352A3
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 14:54:39 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 224F120675
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 14:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pw/84oCu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224F120675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3AAE86EE73;
	Tue, 11 Feb 2020 14:54:38 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26DB46EE73
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 14:54:37 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id a5so3917983wmb.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 06:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lTOIB94TJYXdiVFcu0Uo+yB8vqQkpSVLJIJMuvmQaik=;
 b=Pw/84oCuY1yCHK+jhCnK6lCs7KwlwJBGIfv6mTkQfA4DpwkFOtg7fAEFoMyGrpE9wE
 1jgbt0ptexfpmfS9aqXHZSzuQ5q+ukzA279szxPk0K3tpOPKSl4hnoTicYxkxE42UWOb
 /zKJZo0umz5rVat9CTZYDadxMA6MoSzvA5zBVH1BBlB1KGv3l3ZRfdyqMZ09WtWdP1aD
 VPf5lsqHcks+83i1+CWn4XoD8KlzxcOj9k401x8/BTIJIfT6vhnbbtZ+5swLDkZnDJfT
 ugmwftuSi9NRI6Q4ln8tnZ4Yx9wBRBzUnJXynUYhdALKseK778yu9zRT4aXjIWoBnjHU
 xChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lTOIB94TJYXdiVFcu0Uo+yB8vqQkpSVLJIJMuvmQaik=;
 b=ticcRJ/7o7BrrEzVu4UuRPEVhYWw4LwK1PYTy6sH2CDhDB9S/5durg6pYtl4Z3N99E
 SpkXDbKNGcm2jiNT2RkPxOyi/136gK4WXxR8bIbs50xAWX1hz79lXd+XNutgNjoM1+FD
 fk/XfJNRLNCCEgGO7VaEgQQFwHqxsfb2Q2+xeZjvr4YCnfEJMe1CA+ZVVZcy69AGYqgM
 PmqhniIgacs1d/P6iNJuKrwx/bxqgLb+L/mSzecPksc+jJ0PzR3XyUdz7HXl+d8C5YIu
 p5h+pWexHVY1gQ5sRyTowOgvZDVvyxp7EaOx71/roTbDcC4nYacLbD5FMSNAX+nxDUQf
 gqJQ==
X-Gm-Message-State: APjAAAUrwh2Jj3gQZymbOSY1VjFiX0rxohFYabhiyMcy2W69GGXP8TJ/
 C+6/TD2q4u721ioS6YpUWP6kaEe2cL94iA==
X-Google-Smtp-Source: APXvYqy5WppBzafrv9WszJvdd7HQBXh1eXQb/xnCzXMOWqlZkL/rh662rJlTlMf7wE9+tvTFI5mJTw==
X-Received: by 2002:a1c:6189:: with SMTP id v131mr6342217wmb.185.1581432875265; 
 Tue, 11 Feb 2020 06:54:35 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F2B9B0046CB968BE99810CA.dip0.t-ipconnect.de.
 [2003:c5:8f2b:9b00:46cb:968b:e998:10ca])
 by smtp.gmail.com with ESMTPSA id y7sm5815487wmd.1.2020.02.11.06.54.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 06:54:34 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH v3] drm/amdgpu: move ttm bo->offset to amdgpu_bo
Date: Tue, 11 Feb 2020 15:57:05 +0100
Message-Id: <20200211145705.3263-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.25.0
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, ray.huang@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

GPU address should belong to driver not in memory management.
This patch moves ttm bo.offset and gpu_offset calculation to amdgpu driver.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 28 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     | 20 +++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h     |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  4 +--
 5 files changed, 43 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 6f60a581e3ba..4421efcd16d6 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -917,7 +917,7 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 		bo->pin_count++;
 
 		if (max_offset != 0) {
-			u64 domain_start = bo->tbo.bdev->man[mem_type].gpu_offset;
+			u64 domain_start = amdgpu_ttm_domain_start(adev, mem_type);
 			WARN_ON_ONCE(max_offset <
 				     (amdgpu_bo_gpu_offset(bo) - domain_start));
 		}
@@ -1460,6 +1460,9 @@ int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr)
  */
 u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
 {
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	uint64_t offset;
+
 	WARN_ON_ONCE(bo->tbo.mem.mem_type == TTM_PL_SYSTEM);
 	WARN_ON_ONCE(!dma_resv_is_locked(bo->tbo.base.resv) &&
 		     !bo->pin_count && bo->tbo.type != ttm_bo_type_kernel);
@@ -1467,7 +1470,28 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
 	WARN_ON_ONCE(bo->tbo.mem.mem_type == TTM_PL_VRAM &&
 		     !(bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS));
 
-	return amdgpu_gmc_sign_extend(bo->tbo.offset);
+        offset = (bo->tbo.mem.start << PAGE_SHIFT) +
+		 amdgpu_ttm_domain_start(adev, bo->tbo.mem.mem_type);
+
+	return amdgpu_gmc_sign_extend(offset);
+}
+
+/**
+ * amdgpu_bo_gpu_offset_no_check - return GPU offset of bo
+ * @bo:	amdgpu object for which we query the offset
+ *
+ * Returns:
+ * current GPU offset of the object.
+ */
+u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo)
+{
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	uint64_t offset;
+
+        offset = (bo->tbo.mem.start << PAGE_SHIFT) +
+		 amdgpu_ttm_domain_start(adev, bo->tbo.mem.mem_type);
+
+	return amdgpu_gmc_sign_extend(offset);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 96d805889e8d..9075ef20ce02 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -288,6 +288,7 @@ int amdgpu_bo_sync_wait_resv(struct amdgpu_device *adev, struct dma_resv *resv,
 			     bool intr);
 int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
 u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
+u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
 int amdgpu_bo_validate(struct amdgpu_bo *bo);
 int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
 			     struct dma_fence **fence);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2c1d1eb1a7e1..0f224ff23c9a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -103,7 +103,6 @@ static int amdgpu_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
 	case TTM_PL_TT:
 		/* GTT memory  */
 		man->func = &amdgpu_gtt_mgr_func;
-		man->gpu_offset = adev->gmc.gart_start;
 		man->available_caching = TTM_PL_MASK_CACHING;
 		man->default_caching = TTM_PL_FLAG_CACHED;
 		man->flags = TTM_MEMTYPE_FLAG_MAPPABLE | TTM_MEMTYPE_FLAG_CMA;
@@ -111,7 +110,6 @@ static int amdgpu_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
 	case TTM_PL_VRAM:
 		/* "On-card" video ram */
 		man->func = &amdgpu_vram_mgr_func;
-		man->gpu_offset = adev->gmc.vram_start;
 		man->flags = TTM_MEMTYPE_FLAG_FIXED |
 			     TTM_MEMTYPE_FLAG_MAPPABLE;
 		man->available_caching = TTM_PL_FLAG_UNCACHED | TTM_PL_FLAG_WC;
@@ -122,7 +120,6 @@ static int amdgpu_init_mem_type(struct ttm_bo_device *bdev, uint32_t type,
 	case AMDGPU_PL_OA:
 		/* On-chip GDS memory*/
 		man->func = &ttm_bo_manager_func;
-		man->gpu_offset = 0;
 		man->flags = TTM_MEMTYPE_FLAG_FIXED | TTM_MEMTYPE_FLAG_CMA;
 		man->available_caching = TTM_PL_FLAG_UNCACHED;
 		man->default_caching = TTM_PL_FLAG_UNCACHED;
@@ -270,7 +267,7 @@ static uint64_t amdgpu_mm_node_addr(struct ttm_buffer_object *bo,
 
 	if (mm_node->start != AMDGPU_BO_INVALID_OFFSET) {
 		addr = mm_node->start << PAGE_SHIFT;
-		addr += bo->bdev->man[mem->mem_type].gpu_offset;
+		addr += amdgpu_ttm_domain_start(amdgpu_ttm_adev(bo->bdev), mem->mem_type);
 	}
 	return addr;
 }
@@ -757,6 +754,18 @@ static unsigned long amdgpu_ttm_io_mem_pfn(struct ttm_buffer_object *bo,
 		(offset >> PAGE_SHIFT);
 }
 
+uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type)
+{
+	switch(type) {
+	case TTM_PL_TT:
+		return adev->gmc.gart_start;
+	case TTM_PL_VRAM:
+		return adev->gmc.vram_start;
+	}
+
+	return 0;
+}
+
 /*
  * TTM backend functions.
  */
@@ -1136,9 +1145,6 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
 		bo->mem = tmp;
 	}
 
-	bo->offset = (bo->mem.start << PAGE_SHIFT) +
-		bo->bdev->man[bo->mem.mem_type].gpu_offset;
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index f1ebd424510c..aed364d71d58 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -102,6 +102,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 int amdgpu_mmap(struct file *filp, struct vm_area_struct *vma);
 int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
 int amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
+uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
 
 #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
 int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo, struct page **pages);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 4cc7881f438c..3c02647e6848 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -140,7 +140,7 @@ static void amdgpu_vm_sdma_copy_ptes(struct amdgpu_vm_update_params *p,
 
 	src += p->num_dw_left * 4;
 
-	pe += amdgpu_gmc_sign_extend(bo->tbo.offset);
+	pe += amdgpu_bo_gpu_offset_no_check(bo);
 	trace_amdgpu_vm_copy_ptes(pe, src, count, p->direct);
 
 	amdgpu_vm_copy_pte(p->adev, ib, pe, src, count);
@@ -167,7 +167,7 @@ static void amdgpu_vm_sdma_set_ptes(struct amdgpu_vm_update_params *p,
 {
 	struct amdgpu_ib *ib = p->job->ibs;
 
-	pe += amdgpu_gmc_sign_extend(bo->tbo.offset);
+	pe += amdgpu_bo_gpu_offset_no_check(bo);
 	trace_amdgpu_vm_set_ptes(pe, addr, count, incr, flags, p->direct);
 	if (count < 3) {
 		amdgpu_vm_write_pte(p->adev, ib, pe, addr | flags,
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

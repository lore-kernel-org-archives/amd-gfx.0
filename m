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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC61BC352A3
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 14:04:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B97BD20870
	for <amd-gfx@archiver.kernel.org>; Tue, 11 Feb 2020 14:04:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHZa+ZKX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B97BD20870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E4186EA86;
	Tue, 11 Feb 2020 14:04:34 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD1A86EA86
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 14:04:33 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id m10so2354563wmc.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 11 Feb 2020 06:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BphmUHBDQwGTRrXb/oGa9VbARD8fLTbk7jO9owo0Xqg=;
 b=XHZa+ZKXrwJuUQHvJY5NI2dEmOFlA30gFk5JYqqjrepIDBrKmo/EY8eDZI1Ti+MR8M
 PmxmsenAI/EM3CEThIvVgDtPSBEqnnkxYgQqoTP9fOP/JPqU2wmXfm7nUBnZgRkWO5wi
 Kv/1ho/Yl53F7cbInoBXfw0dNWo/j6t47IgmMLOfDl7Hg5v1MhypiAuzqVQLRQZz18ee
 rLBIJxe/7TXOkF6Nc5j98/h+fbMvEcecKrJe5pC8Coh3/RLDsOFKAcRnPXRn1XtB+SwT
 u7rTnRaZ90soqsIPJ1WD+uOErazXgx374WbvDEzVExQ0PypvAz/pb5fLQUU5lFtRIc6n
 n5Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=BphmUHBDQwGTRrXb/oGa9VbARD8fLTbk7jO9owo0Xqg=;
 b=IkNuj8KOARB2DJIKpkUFXwuzHY26+ONQ0cFPc3KIvydreL0CPNG6o3pNN7En5XEMCi
 Sgk4/5NYoys5EclclL23U/scBJasbFtoW9ate1q2UHkTp8X8UBaWOK5ILVL46KCy/W6u
 3fF1/xSX3wSg52FV3ptWIDdvaW4s9IZjYI9r8O9BirpHo6ZkEA33oQKO+k2tD+EUrwSH
 5Yj9HD9LUmsTk6kRPVyczayXF819T/2tvVPLeDKMCWgoAY9aD/Yg4As5j4fCmCAu02sR
 QZ9AiaQ6alBYoZTCtH5bk6AmbndUbdaL+0rqyIIIn17r9TDXFOI13EDPVvGMVTS9FL3C
 FlUA==
X-Gm-Message-State: APjAAAWoKo4op/xFQ7idoYIEMZHWUVRScg3hb06zSfQkW8xb1ips9kw9
 Xr2+O99u58nsLpA5czu+Ucfy7GfU4nGugA==
X-Google-Smtp-Source: APXvYqziff62v18zTvsxwODR3aaKSEZWRgMj9bo8iFg1KjkX2OSyRg/0Xp+ByLBbWA3FP1NghnphkQ==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr6167877wmc.154.1581429867092; 
 Tue, 11 Feb 2020 06:04:27 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F2B9B0046CB968BE99810CA.dip0.t-ipconnect.de.
 [2003:c5:8f2b:9b00:46cb:968b:e998:10ca])
 by smtp.gmail.com with ESMTPSA id l2sm3847756wme.1.2020.02.11.06.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 06:04:26 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH v2] drm/amdgpu: move ttm bo->offset to amdgpu_bo
Date: Tue, 11 Feb 2020 15:06:56 +0100
Message-Id: <20200211140656.3574-1-nirmoy.das@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c  | 22 +++++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  8 +-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c |  4 ++--
 4 files changed, 24 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 6f60a581e3ba..e25924be33ca 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -917,7 +917,7 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 		bo->pin_count++;
 
 		if (max_offset != 0) {
-			u64 domain_start = bo->tbo.bdev->man[mem_type].gpu_offset;
+			u64 domain_start = amdgpu_bo_gpu_start(adev, mem_type);
 			WARN_ON_ONCE(max_offset <
 				     (amdgpu_bo_gpu_offset(bo) - domain_start));
 		}
@@ -1248,6 +1248,18 @@ int amdgpu_bo_get_metadata(struct amdgpu_bo *bo, void *buffer,
 	return 0;
 }
 
+uint64_t amdgpu_bo_gpu_start(struct amdgpu_device *adev, uint32_t type)
+{
+	switch(type) {
+		case TTM_PL_TT:
+			return adev->gmc.gart_start;
+		case TTM_PL_VRAM:
+			return adev->gmc.vram_start;
+	}
+
+	return 0;
+}
+
 /**
  * amdgpu_bo_move_notify - notification about a memory move
  * @bo: pointer to a buffer object
@@ -1460,6 +1472,9 @@ int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr)
  */
 u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
 {
+	uint64_t offset;
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+
 	WARN_ON_ONCE(bo->tbo.mem.mem_type == TTM_PL_SYSTEM);
 	WARN_ON_ONCE(!dma_resv_is_locked(bo->tbo.base.resv) &&
 		     !bo->pin_count && bo->tbo.type != ttm_bo_type_kernel);
@@ -1467,7 +1482,10 @@ u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo)
 	WARN_ON_ONCE(bo->tbo.mem.mem_type == TTM_PL_VRAM &&
 		     !(bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS));
 
-	return amdgpu_gmc_sign_extend(bo->tbo.offset);
+        offset = (bo->tbo.mem.start << PAGE_SHIFT) +
+		 amdgpu_bo_gpu_start(adev, bo->tbo.mem.mem_type);
+
+	return amdgpu_gmc_sign_extend(offset);
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 96d805889e8d..dfa4e75b95e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -294,6 +294,7 @@ int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
 uint32_t amdgpu_bo_get_preferred_pin_domain(struct amdgpu_device *adev,
 					    uint32_t domain);
 
+uint64_t amdgpu_bo_gpu_start(struct amdgpu_device *adev, uint32_t type);
 /*
  * sub allocation
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 2c1d1eb1a7e1..3e65bdfca94f 100644
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
+		addr += amdgpu_bo_gpu_start(amdgpu_ttm_adev(bo->bdev), mem->mem_type);
 	}
 	return addr;
 }
@@ -1136,9 +1133,6 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
 		bo->mem = tmp;
 	}
 
-	bo->offset = (bo->mem.start << PAGE_SHIFT) +
-		bo->bdev->man[bo->mem.mem_type].gpu_offset;
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 4cc7881f438c..e7a383134521 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -140,7 +140,7 @@ static void amdgpu_vm_sdma_copy_ptes(struct amdgpu_vm_update_params *p,
 
 	src += p->num_dw_left * 4;
 
-	pe += amdgpu_gmc_sign_extend(bo->tbo.offset);
+	pe += amdgpu_bo_gpu_offset(bo);
 	trace_amdgpu_vm_copy_ptes(pe, src, count, p->direct);
 
 	amdgpu_vm_copy_pte(p->adev, ib, pe, src, count);
@@ -167,7 +167,7 @@ static void amdgpu_vm_sdma_set_ptes(struct amdgpu_vm_update_params *p,
 {
 	struct amdgpu_ib *ib = p->job->ibs;
 
-	pe += amdgpu_gmc_sign_extend(bo->tbo.offset);
+	pe += amdgpu_bo_gpu_offset(bo);
 	trace_amdgpu_vm_set_ptes(pe, addr, count, incr, flags, p->direct);
 	if (count < 3) {
 		amdgpu_vm_write_pte(p->adev, ib, pe, addr | flags,
-- 
2.25.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

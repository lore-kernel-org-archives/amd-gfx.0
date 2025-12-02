Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B547ACFD2F6
	for <amd-gfx@archiver.kernel.org>; Tue,  2 Dec 2025 15:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47DE310E0A7;
	Tue,  2 Dec 2025 15:12:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jQprfdXz";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A2CF10E0A7
 for <amd-gfx@lists.freedesktop.org>; Tue,  2 Dec 2025 15:12:44 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-64320b9bb4bso4832992a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 02 Dec 2025 07:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764688363; x=1765293163; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=uhuCwg3T40H7fa7U5wx5NUHJaZjtl0l9oIfSrAVuBlk=;
 b=jQprfdXzg0xLBpOgHP0x1HJ3oZwAwJf2XJkJ2vV6yrKPIvR3kiOEVF3yooxKkVsi2u
 3UPM8rPbw6FbA/W0N3/r18OIV6EZkVmzTe0KnLz2eOtpcnA+74kIMJBgG6EnVxI+ArZs
 6mRWk6i07fHuFcynFnYKIvfb1398bpT2tiBYVFFjRTsKEy/VNZJ+LV8C0iWY7/CmqzpY
 Q5TYhsDcECQDa+Egmg8jwGkVFR4hKuY2IB2Xzdpj9DmSyjYrncEKKSq3glXcn2alOk4t
 RpRBJadjbYPBdP5iveJr4w9EpmrVl0Awj6Lro/GTU3Jl2oYDCQJxO6LYcfpKZx1aGbfC
 SdCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764688363; x=1765293163;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uhuCwg3T40H7fa7U5wx5NUHJaZjtl0l9oIfSrAVuBlk=;
 b=A6R0N5K9d75rCnITfnberqAW4VFLKHKOxSKVqoW0l5d7i+V2D63J23sCvQn/RhX2lS
 O/3YqcPo+mhBg2DadzWmUEvf+8uUzhx2bCzteLcNFPH6RTQkvc5xX5zojxmZGLm2BdTB
 wGUulFvtYKeWi2JpxMTr1pHEbfqQA2mTIun7ykWdSEV9OnlNJOxwhYHu7JooZxSJcgnH
 XLfqG6jPcM04Bh5a+5N5VVZSaIe6/7K23tP1UYgpYxQWL3Kw+5q8QRkRtbS/u9tuRlvd
 RSGJvAEQGS1SxjEyFFvbnFLCMkscEZogioVZIgEmiZT6yxdnWz1zQr80h4oC0mJ+BJui
 FD8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXLecOw+wANX1o6ZFEqaPKGaTysknrlD3yquxu4Zbb57aiQA/YB90ska5q9bG/NHtPVbaha3NOi@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2SbNdE9m8MteE/cVkgC5+DVoh6x3MBmkpc0EZpRap+9RLtRsM
 BcZ1iSKWL3lw5OSIav4lkx8a3Y4c8GF17B9855kdk0PD2EchD1QLG11F
X-Gm-Gg: ASbGncu7futIQAH9SsnC0/B7mpnb05X6G4OYC+Gp+1dIiCSgDHSmALRAkuIYahbou0z
 cwqAI1ZZu1KmFgHbTP7F5o0aOdhNTuMi0ajd+m+0U29BW4tOpE+HbjPQYhpI7k/T5CYQn5hkDoW
 9sqrdqb6ok0mZZEE82jZeR8KPZ0L7mMHCWa7IiyB9Qt8yVJJEHYbj7pmihU+Q7aexO9pmGsxVcc
 LRgpkr9aWFUscEN+to41T31PvuMGzVyMgw1ETZn5C/eCW/FEUoDP3npC9mnx5C291lTUchUZMcl
 s4TfNHRJKKMZqZXbj1X0fQxBwjb03jYsib5EfFcnfNylqyL0VIC9Hlec3hPLaZRctIM0eJddLIw
 r4G0pDngpDhp8Js1xIn4/TxmPm7k7WI9d2f9iGs3HMMLr2ibOKxo/DFpOq7nn5xDDV41Xhk3hIc
 Wl90UXa7Z8dEpYYDrZ+IKv1HAk
X-Google-Smtp-Source: AGHT+IEIkhazD7MdAldLmsnFr2hWJuWOAeBwMxrIHnAjthFwkUpntZl1DJP1QVaFmIqFSPxqZmShrw==
X-Received: by 2002:a05:6402:40ce:b0:640:ef03:82de with SMTP id
 4fb4d7f45d1cf-6478926bde8mr2805330a12.4.1764688362729; 
 Tue, 02 Dec 2025 07:12:42 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:1566:ae00:9ed7:ba17:59d5:1db2])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64751035c3bsm15520882a12.19.2025.12.02.07.12.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Dec 2025 07:12:42 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexdeucher@gmail.com, srinivasan.shanmugam@amd.com, Leo.Liu@amd.com,
 Ruijing.Dong@amd.com, amd-gfx@lists.freedesktop.org
Subject: [RFC PATCH 1/3] drm/amdgpu: rework MMIO_REMAP BO creation
Date: Tue,  2 Dec 2025 16:12:39 +0100
Message-ID: <20251202151241.2212-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
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

First of all avoid using AMDGPU_GEM_DOMAIN_MMIO_REMAP in the TTM code.

Then while at it remove some confusing comments, cleanup the comments
who make sense and rename the functions to be a bit more clear what they
do.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 66 ++++++++++++++-----------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e553cf411191..3166469d437a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1892,42 +1892,41 @@ static void amdgpu_ttm_pools_fini(struct amdgpu_device *adev)
 }
 
 /**
- * amdgpu_ttm_mmio_remap_bo_init - Allocate the singleton 4K MMIO_REMAP BO
+ * amdgpu_ttm_mmio_remap_bo_init - Allocate the singleton MMIO_REMAP BO
  * @adev: amdgpu device
  *
- * Allocates a one-page (4K) GEM BO in AMDGPU_GEM_DOMAIN_MMIO_REMAP when the
+ * Allocates a global BO with backing AMDGPU_PL_MMIO_REMAP when the
  * hardware exposes a remap base (adev->rmmio_remap.bus_addr) and the host
  * PAGE_SIZE is <= AMDGPU_GPU_PAGE_SIZE (4K). The BO is created as a regular
  * GEM object (amdgpu_bo_create).
  *
- * The BO is created as a normal GEM object via amdgpu_bo_create(), then
- * reserved and pinned at the TTM level (ttm_bo_pin()) so it can never be
- * migrated or evicted. No CPU mapping is established here.
- *
  * Return:
  *  * 0 on success or intentional skip (feature not present/unsupported)
  *  * negative errno on allocation failure
  */
-static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
+static int amdgpu_ttm_alloc_mmio_remap_bo(struct amdgpu_device *adev)
 {
+	struct ttm_operation_ctx ctx = { false, false };
+	struct ttm_placement placement;
+	struct ttm_buffer_object *tbo;
+	struct ttm_place placements;
 	struct amdgpu_bo_param bp;
+	struct ttm_resource *tmp;
 	int r;
 
 	/* Skip if HW doesn't expose remap, or if PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE (4K). */
 	if (!adev->rmmio_remap.bus_addr || PAGE_SIZE > AMDGPU_GPU_PAGE_SIZE)
 		return 0;
 
+	/* Allocate an empty BO without backing store */
 	memset(&bp, 0, sizeof(bp));
-
-	/* Create exactly one GEM BO in the MMIO_REMAP domain. */
-	bp.type        = ttm_bo_type_device;          /* userspace-mappable GEM */
-	bp.size        = AMDGPU_GPU_PAGE_SIZE;        /* 4K */
+	bp.type        = ttm_bo_type_device;
+	bp.size        = AMDGPU_GPU_PAGE_SIZE;
 	bp.byte_align  = AMDGPU_GPU_PAGE_SIZE;
-	bp.domain      = AMDGPU_GEM_DOMAIN_MMIO_REMAP;
+	bp.domain      = 0;
 	bp.flags       = 0;
 	bp.resv        = NULL;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
-
 	r = amdgpu_bo_create(adev, &bp, &adev->rmmio_remap.bo);
 	if (r)
 		return r;
@@ -1936,37 +1935,48 @@ static int amdgpu_ttm_mmio_remap_bo_init(struct amdgpu_device *adev)
 	if (r)
 		goto err_unref;
 
+	tbo = &adev->rmmio_remap.bo->tbo;
+
 	/*
 	 * MMIO_REMAP is a fixed I/O placement (AMDGPU_PL_MMIO_REMAP).
-	 * Use TTM-level pin so the BO cannot be evicted/migrated,
-	 * independent of GEM domains. This
-	 * enforces the “fixed I/O window”
 	 */
-	ttm_bo_pin(&adev->rmmio_remap.bo->tbo);
+	placement.num_placement = 1;
+	placement.placement = &placements;
+	placements.fpfn = 0;
+	placements.lpfn = 0;
+	placements.mem_type = AMDGPU_PL_MMIO_REMAP;
+	placements.flags = 0;
+	r = ttm_bo_mem_space(tbo, &placement, &tmp, &ctx);
+	if (unlikely(r))
+		goto err_unlock;
+
+	ttm_resource_free(tbo, &tbo->resource);
+	ttm_bo_assign_mem(tbo, tmp);
+	ttm_bo_pin(tbo);
 
 	amdgpu_bo_unreserve(adev->rmmio_remap.bo);
 	return 0;
 
+err_unlock:
+	amdgpu_bo_unreserve(adev->rmmio_remap.bo);
+
 err_unref:
-	if (adev->rmmio_remap.bo)
-		amdgpu_bo_unref(&adev->rmmio_remap.bo);
+	amdgpu_bo_unref(&adev->rmmio_remap.bo);
 	adev->rmmio_remap.bo = NULL;
 	return r;
 }
 
 /**
- * amdgpu_ttm_mmio_remap_bo_fini - Free the singleton MMIO_REMAP BO
+ * amdgpu_ttm_free_mmio_remap_bo - Free the singleton MMIO_REMAP BO
  * @adev: amdgpu device
  *
  * Frees the kernel-owned MMIO_REMAP BO if it was allocated by
  * amdgpu_ttm_mmio_remap_bo_init().
  */
-static void amdgpu_ttm_mmio_remap_bo_fini(struct amdgpu_device *adev)
+static void amdgpu_ttm_free_mmio_remap_bo(struct amdgpu_device *adev)
 {
-	struct amdgpu_bo *bo = adev->rmmio_remap.bo;
-
-	if (!bo)
-		return;   /* <-- safest early exit */
+	if (!adev->rmmio_remap.bo)
+		return;
 
 	if (!amdgpu_bo_reserve(adev->rmmio_remap.bo, true)) {
 		ttm_bo_unpin(&adev->rmmio_remap.bo->tbo);
@@ -2152,8 +2162,8 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		return r;
 	}
 
-	/* Allocate the singleton MMIO_REMAP BO (4K) if supported */
-	r = amdgpu_ttm_mmio_remap_bo_init(adev);
+	/* Allocate the singleton MMIO_REMAP BO if supported */
+	r = amdgpu_ttm_alloc_mmio_remap_bo(adev);
 	if (r)
 		return r;
 
@@ -2220,7 +2230,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	amdgpu_bo_free_kernel(&adev->mman.sdma_access_bo, NULL,
 					&adev->mman.sdma_access_ptr);
 
-	amdgpu_ttm_mmio_remap_bo_fini(adev);
+	amdgpu_ttm_free_mmio_remap_bo(adev);
 	amdgpu_ttm_fw_reserve_vram_fini(adev);
 	amdgpu_ttm_drv_reserve_vram_fini(adev);
 
-- 
2.43.0


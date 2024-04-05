Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5639BC67861
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Apr 2024 07:50:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C91C8113A09;
	Fri,  5 Apr 2024 07:50:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O+wTAwXy";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 27F56113A0A
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Apr 2024 07:50:31 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-343eb6cc46bso123310f8f.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 05 Apr 2024 00:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712303429; x=1712908229; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Db2efFQ1/zA63vHnBfo3eY++P1XmAHRatxNJcNUeq6U=;
 b=O+wTAwXyLIVEqJIQt7Yua4iSJGBtw9tuVzbnRFTgk3Gx/VcJaKa2QqUk5/TGzgNvWH
 v9C37cpVpfFE1Vck0OeowUK7A3vb7BIMTC9II2vHjn/w9FsbqRMoEZPvz0N5NxMW0EZP
 LtCQiRg65CoWQz22HfOEpjt/c4tUIeJ2gUBVlkzp+ikc6U/+kbsS5CeEvtXvXcVkiW6X
 kM3Teu9gJ0Wsk7JRuc+IRvz3OinRQF8gh8Yd0e75UJN+LAthBL0p4Vyuk4WNP96GAijP
 yrwQdd6KQiQZlGNDsk5iaS9lrjR0q8YDNGm44EPdkE/PIDbCCFTmDnv3o9mNFfV9vvA2
 iFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712303429; x=1712908229;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Db2efFQ1/zA63vHnBfo3eY++P1XmAHRatxNJcNUeq6U=;
 b=l06CSRLB+RwNLLiLbJLcWf854LZFFqccXqJ9UstV2bXaHMEocenr8dyF49QcfaPOim
 CxFcUewasBTiIQrFZZ+myHYo/poOZycrjHgACdHD31ZFXlDRnI2jfeULy41g2dM+qr0v
 xHILUwsqFHFoqWohww2YkBvG/zSZ9w+OCiw6ONBIdsIyuo5fMrvaW1NMC2rFE7uyG6IJ
 iacG8K9l5nabDKixnECrKsJwrDeYnAyratbOxk3Vv1rc8UKGGLNhzSumo3u4tYKD9tTy
 qrcArB7BvNx5TLuZHDEOVG/BEuIEP9FOCDwfOe36xumIKY4IYinIuMW928ftzfGJ6YJV
 swUw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwISO6TO3qVR9Y9lMHpqYxhl+7bnob9+nhP528Z03UNZJWAthbwUdM40vjvj6Ns4QHQkofTnOV/ExL23XP2bWQZx4ZCHpqAkVSBxeXpA==
X-Gm-Message-State: AOJu0YxGpJ2J3SGRqsf5vUpa5BnUuRmYGNEXKptvoU/SSgyuYJyats6c
 VGwucEpremNqz/RQ3QvE2N2g4fd0uIEcPAyU2SvlUdW9kh8ktixa
X-Google-Smtp-Source: AGHT+IG80VZHfuOXE8Qt/W5NuK41wgt4V/8q8+Kwv9d3QWZyrqLyfVYw3GGZErkqWbIYEm6cQm1AOg==
X-Received: by 2002:a5d:4045:0:b0:343:471f:fe54 with SMTP id
 w5-20020a5d4045000000b00343471ffe54mr468366wrp.28.1712303429192; 
 Fri, 05 Apr 2024 00:50:29 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:156e:8200:5d3f:824b:b49e:df41])
 by smtp.gmail.com with ESMTPSA id
 y11-20020adff6cb000000b00343d504d7afsm1359337wrp.30.2024.04.05.00.50.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 00:50:28 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Amaranath.Somalapuram@amd.com, xenia.ragiadakou@amd.com,
 pierre-eric.pelloux-prayer@amd.com, amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix visible VRAM handling during faults
Date: Fri,  5 Apr 2024 09:50:27 +0200
Message-Id: <20240405075027.2252-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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

When we removed the hacky start code check we actually didn't took into
account that *all* VRAM pages needs to be CPU accessible.

Clean up the code and unify the handling into a single helper which
checks if the whole resource is CPU accessible.

The only place where a partial check would make sense is during
eviction, but that is neglitible.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: aed01a68047b ("drm/amdgpu: Remove TTM resource->start visible VRAM condition v2")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 22 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 22 --------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 61 ++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  3 ++
 5 files changed, 53 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index bbbd8ad0171f..e9168677ef0a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -819,7 +819,7 @@ static int amdgpu_cs_bo_validate(void *param, struct amdgpu_bo *bo)
 
 	p->bytes_moved += ctx.bytes_moved;
 	if (!amdgpu_gmc_vram_full_visible(&adev->gmc) &&
-	    amdgpu_bo_in_cpu_visible_vram(bo))
+	    amdgpu_res_cpu_visible(adev, bo->tbo.resource))
 		p->bytes_moved_vis += ctx.bytes_moved;
 
 	if (unlikely(r == -ENOMEM) && domain != bo->allowed_domains) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index eb7d824763b9..eff3f9fceada 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -620,8 +620,7 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 		return r;
 
 	if (!amdgpu_gmc_vram_full_visible(&adev->gmc) &&
-	    bo->tbo.resource->mem_type == TTM_PL_VRAM &&
-	    amdgpu_bo_in_cpu_visible_vram(bo))
+	    amdgpu_res_cpu_visible(adev, bo->tbo.resource))
 		amdgpu_cs_report_moved_bytes(adev, ctx.bytes_moved,
 					     ctx.bytes_moved);
 	else
@@ -1276,18 +1275,20 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
 			  struct amdgpu_mem_stats *stats)
 {
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	struct ttm_resource *res = bo->tbo.resource;
 	uint64_t size = amdgpu_bo_size(bo);
 	unsigned int domain;
 
 	/* Abort if the BO doesn't currently have a backing store */
-	if (!bo->tbo.resource)
+	if (!res)
 		return;
 
-	domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
+	domain = amdgpu_mem_type_to_domain(res->mem_type);
 	switch (domain) {
 	case AMDGPU_GEM_DOMAIN_VRAM:
 		stats->vram += size;
-		if (amdgpu_bo_in_cpu_visible_vram(bo))
+		if (amdgpu_res_cpu_visible(adev, bo->tbo.resource))
 			stats->visible_vram += size;
 		break;
 	case AMDGPU_GEM_DOMAIN_GTT:
@@ -1382,10 +1383,7 @@ vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo)
 	/* Remember that this BO was accessed by the CPU */
 	abo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 
-	if (bo->resource->mem_type != TTM_PL_VRAM)
-		return 0;
-
-	if (amdgpu_bo_in_cpu_visible_vram(abo))
+	if (amdgpu_res_cpu_visible(adev, bo->resource))
 		return 0;
 
 	/* Can't move a pinned BO to visible VRAM */
@@ -1409,7 +1407,7 @@ vm_fault_t amdgpu_bo_fault_reserve_notify(struct ttm_buffer_object *bo)
 
 	/* this should never happen */
 	if (bo->resource->mem_type == TTM_PL_VRAM &&
-	    !amdgpu_bo_in_cpu_visible_vram(abo))
+	    !amdgpu_res_cpu_visible(adev, bo->resource))
 		return VM_FAULT_SIGBUS;
 
 	ttm_bo_move_to_lru_tail_unlocked(bo);
@@ -1573,6 +1571,7 @@ uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
  */
 u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 {
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct dma_buf_attachment *attachment;
 	struct dma_buf *dma_buf;
 	const char *placement;
@@ -1581,10 +1580,11 @@ u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m)
 
 	if (dma_resv_trylock(bo->tbo.base.resv)) {
 		unsigned int domain;
+
 		domain = amdgpu_mem_type_to_domain(bo->tbo.resource->mem_type);
 		switch (domain) {
 		case AMDGPU_GEM_DOMAIN_VRAM:
-			if (amdgpu_bo_in_cpu_visible_vram(bo))
+			if (amdgpu_res_cpu_visible(adev, bo->tbo.resource))
 				placement = "VRAM VISIBLE";
 			else
 				placement = "VRAM";
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index d28e21baef16..f8982404da93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -244,28 +244,6 @@ static inline u64 amdgpu_bo_mmap_offset(struct amdgpu_bo *bo)
 	return drm_vma_node_offset_addr(&bo->tbo.base.vma_node);
 }
 
-/**
- * amdgpu_bo_in_cpu_visible_vram - check if BO is (partly) in visible VRAM
- */
-static inline bool amdgpu_bo_in_cpu_visible_vram(struct amdgpu_bo *bo)
-{
-	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
-	struct amdgpu_res_cursor cursor;
-
-	if (!bo->tbo.resource || bo->tbo.resource->mem_type != TTM_PL_VRAM)
-		return false;
-
-	amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &cursor);
-	while (cursor.remaining) {
-		if (cursor.start < adev->gmc.visible_vram_size)
-			return true;
-
-		amdgpu_res_next(&cursor, cursor.size);
-	}
-
-	return false;
-}
-
 /**
  * amdgpu_bo_explicit_sync - return whether the bo is explicitly synced
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 460b23918bfc..6f0cfe66613e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -137,7 +137,7 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
 			amdgpu_bo_placement_from_domain(abo, AMDGPU_GEM_DOMAIN_CPU);
 		} else if (!amdgpu_gmc_vram_full_visible(&adev->gmc) &&
 			   !(abo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED) &&
-			   amdgpu_bo_in_cpu_visible_vram(abo)) {
+			   amdgpu_res_cpu_visible(adev, bo->resource)) {
 
 			/* Try evicting to the CPU inaccessible part of VRAM
 			 * first, but only set GTT as busy placement, so this
@@ -408,40 +408,55 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
 	return r;
 }
 
-/*
- * amdgpu_mem_visible - Check that memory can be accessed by ttm_bo_move_memcpy
+/**
+ * amdgpu_res_cpu_visible - Check that resource can be accessed by CPU
+ * @adev: amdgpu device
+ * @res: the resource to check
  *
- * Called by amdgpu_bo_move()
+ * Returns: true if the full resource is CPU visible, false otherwise.
  */
-static bool amdgpu_mem_visible(struct amdgpu_device *adev,
-			       struct ttm_resource *mem)
+bool amdgpu_res_cpu_visible(struct amdgpu_device *adev,
+			    struct ttm_resource *res)
 {
-	u64 mem_size = (u64)mem->size;
 	struct amdgpu_res_cursor cursor;
-	u64 end;
 
-	if (mem->mem_type == TTM_PL_SYSTEM ||
-	    mem->mem_type == TTM_PL_TT)
+	if (!res)
+		return false;
+
+	if (res->mem_type == TTM_PL_SYSTEM || res->mem_type == TTM_PL_TT ||
+	    res->mem_type == AMDGPU_PL_PREEMPT)
 		return true;
-	if (mem->mem_type != TTM_PL_VRAM)
+
+	if (res->mem_type != TTM_PL_VRAM)
 		return false;
 
-	amdgpu_res_first(mem, 0, mem_size, &cursor);
-	end = cursor.start + cursor.size;
+	amdgpu_res_first(res, 0, res->size, &cursor);
 	while (cursor.remaining) {
+		if ((cursor.start + cursor.size) >= adev->gmc.visible_vram_size)
+			return false;
 		amdgpu_res_next(&cursor, cursor.size);
+	}
 
-		if (!cursor.remaining)
-			break;
+	return true;
+}
 
-		/* ttm_resource_ioremap only supports contiguous memory */
-		if (end != cursor.start)
-			return false;
+/*
+ * amdgpu_res_copyable - Check that memory can be accessed by ttm_bo_move_memcpy
+ *
+ * Called by amdgpu_bo_move()
+ */
+static bool amdgpu_res_copyable(struct amdgpu_device *adev,
+				struct ttm_resource *mem)
+{
+	if (!amdgpu_res_cpu_visible(adev, mem))
+		return false;
 
-		end = cursor.start + cursor.size;
-	}
+	/* ttm_resource_ioremap only supports contiguous memory */
+	if (mem->mem_type == TTM_PL_VRAM &&
+	    !(mem->placement & TTM_PL_FLAG_CONTIGUOUS))
+		return false;
 
-	return end <= adev->gmc.visible_vram_size;
+	return true;
 }
 
 /*
@@ -539,8 +554,8 @@ static int amdgpu_bo_move(struct ttm_buffer_object *bo, bool evict,
 
 	if (r) {
 		/* Check that all memory is CPU accessible */
-		if (!amdgpu_mem_visible(adev, old_mem) ||
-		    !amdgpu_mem_visible(adev, new_mem)) {
+		if (!amdgpu_res_copyable(adev, old_mem) ||
+		    !amdgpu_res_copyable(adev, new_mem)) {
 			pr_err("Move buffer fallback to memcpy unavailable\n");
 			return r;
 		}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 65ec82141a8e..32cf6b6f6efd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -139,6 +139,9 @@ int amdgpu_vram_mgr_reserve_range(struct amdgpu_vram_mgr *mgr,
 int amdgpu_vram_mgr_query_page_status(struct amdgpu_vram_mgr *mgr,
 				      uint64_t start);
 
+bool amdgpu_res_cpu_visible(struct amdgpu_device *adev,
+			    struct ttm_resource *res);
+
 int amdgpu_ttm_init(struct amdgpu_device *adev);
 void amdgpu_ttm_fini(struct amdgpu_device *adev);
 void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev,
-- 
2.34.1


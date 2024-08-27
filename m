Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00488C5472F
	for <amd-gfx@archiver.kernel.org>; Tue, 27 Aug 2024 14:12:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9703110E30F;
	Tue, 27 Aug 2024 14:12:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="F29HUdqL";
	dkim-atps=neutral
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0C8F10E30D
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 14:12:16 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-a83597ce5beso863773166b.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 27 Aug 2024 07:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724767935; x=1725372735; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+JUH7Bd0WcQj9aSQmLZl3m8RBbAG139l3DQOfVNKrJ4=;
 b=F29HUdqL9rezQOL6uyxfmqMLv+yVWS2WpBZHFxVAY3d87SxIexWpjLs+fgQzyt0r5e
 HqUW6uf1rVIF0TDjU3XX0KJzWgpHpLDNmWa2cHMlBioSf6fZ788vOAgeXQ1euNLuE8li
 DAcxQmSVchJN4ig2aVO3ksKSHxmsBHAd2LSMchYsNCwMwArsRTe6aMO+H4m9FADybuCw
 fEtp+HOIEgw1JDIOxRznYOcjA3gcSjXULgsamYQ5fTyvgPZNWQxxElEvAym2nldnFNAE
 mvS+u4UqHhwkJxBjKkITuXbyDwlBn04bOPMWsI5RpLYJhqFPLVCbbVja/UPBk22Qd3ao
 gwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724767935; x=1725372735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+JUH7Bd0WcQj9aSQmLZl3m8RBbAG139l3DQOfVNKrJ4=;
 b=X1WU1mefFc2H3vZJYnuhLwBdKglVSgUcBuOPdfTq3MHoKZwtJZcwr9Z+RE3fJ55IqB
 z1DHoCyPSia1VF2Ana7lSM5URsBVvL5YPWeHunjt/Wb7slzAjusfqoyXuX7djOAvMGJY
 /chum+oGE+jlECDjTVbLgEviBylvseT8aKGd0HkcaHa+txI/qZprEDqd6io6lsr1u5qJ
 8P84taI2fgPvtLm+sliVj0dKG1Q7FEeLlthbO80dUPjmy6UjAiv7ZZm2Wdv8KYaZImNM
 0uXmnVLlvUzNEl5WmH6i8XR5jveUt03U5iA+U4D9tysiEHj5ODUKyKLOHYiSxu69lRMg
 kYtg==
X-Gm-Message-State: AOJu0YxLqgsXo0Y9+Xfamt8cF2SSm9bW3UkqJtxHdCl6qtV3STygvkTa
 +iJlSVd9NZcckvjQiQd5mdaFfHTNfR8/h/r//E5OewEB/9SzvwG6TypxAv69
X-Google-Smtp-Source: AGHT+IH6RqiTvN/hya5H0MYwPD16ErNhyB2je+t/vHIwVWY0jUQxo02DV6ImaomrO+W1Hcn0F67uKA==
X-Received: by 2002:a17:907:97d0:b0:a7c:d284:4f1d with SMTP id
 a640c23a62f3a-a86e29fdd97mr317549666b.28.1724767934342; 
 Tue, 27 Aug 2024 07:12:14 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15b3:7800:8c1b:1972:54d8:6ca6])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e54875e5sm114196866b.5.2024.08.27.07.12.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 07:12:13 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Lijo.Lazar@amd.com,
	Alexander.Deucher@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/3] drm/amdgpu: remove amdgpu_pin_restricted()
Date: Tue, 27 Aug 2024 16:12:10 +0200
Message-Id: <20240827141211.2411-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240827141211.2411-1-christian.koenig@amd.com>
References: <20240827141211.2411-1-christian.koenig@amd.com>
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

We haven't used the functionality to pin BOs in a certain range at all
while the driver existed. Just nuke it.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    | 56 ++-----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  2 -
 3 files changed, 6 insertions(+), 54 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 6d5fd371d5ce..e7bea0d2dc2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1505,7 +1505,7 @@ static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
 		}
 	}
 
-	ret = amdgpu_bo_pin_restricted(bo, domain, 0, 0);
+	ret = amdgpu_bo_pin(bo, domain);
 	if (ret)
 		pr_err("Error in Pinning BO to domain: %d\n", domain);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index 60ab6ae699bf..ff1a69243699 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -870,29 +870,22 @@ void amdgpu_bo_unref(struct amdgpu_bo **bo)
 }
 
 /**
- * amdgpu_bo_pin_restricted - pin an &amdgpu_bo buffer object
+ * amdgpu_bo_pin - pin an &amdgpu_bo buffer object
  * @bo: &amdgpu_bo buffer object to be pinned
  * @domain: domain to be pinned to
- * @min_offset: the start of requested address range
- * @max_offset: the end of requested address range
  *
- * Pins the buffer object according to requested domain and address range. If
- * the memory is unbound gart memory, binds the pages into gart table. Adjusts
- * pin_count and pin_size accordingly.
+ * Pins the buffer object according to requested domain. If the memory is
+ * unbound gart memory, binds the pages into gart table. Adjusts pin_count and
+ * pin_size accordingly.
  *
  * Pinning means to lock pages in memory along with keeping them at a fixed
  * offset. It is required when a buffer can not be moved, for example, when
  * a display buffer is being scanned out.
  *
- * Compared with amdgpu_bo_pin(), this function gives more flexibility on
- * where to pin a buffer if there are specific restrictions on where a buffer
- * must be located.
- *
  * Returns:
  * 0 for success or a negative error code on failure.
  */
-int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
-			     u64 min_offset, u64 max_offset)
+int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct ttm_operation_ctx ctx = { false, false };
@@ -901,9 +894,6 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 	if (amdgpu_ttm_tt_get_usermm(bo->tbo.ttm))
 		return -EPERM;
 
-	if (WARN_ON_ONCE(min_offset > max_offset))
-		return -EINVAL;
-
 	/* Check domain to be pinned to against preferred domains */
 	if (bo->preferred_domains & domain)
 		domain = bo->preferred_domains & domain;
@@ -929,14 +919,6 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 			return -EINVAL;
 
 		ttm_bo_pin(&bo->tbo);
-
-		if (max_offset != 0) {
-			u64 domain_start = amdgpu_ttm_domain_start(adev,
-								   mem_type);
-			WARN_ON_ONCE(max_offset <
-				     (amdgpu_bo_gpu_offset(bo) - domain_start));
-		}
-
 		return 0;
 	}
 
@@ -953,17 +935,6 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 		bo->flags |= AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
 	amdgpu_bo_placement_from_domain(bo, domain);
 	for (i = 0; i < bo->placement.num_placement; i++) {
-		unsigned int fpfn, lpfn;
-
-		fpfn = min_offset >> PAGE_SHIFT;
-		lpfn = max_offset >> PAGE_SHIFT;
-
-		if (fpfn > bo->placements[i].fpfn)
-			bo->placements[i].fpfn = fpfn;
-		if (!bo->placements[i].lpfn ||
-		    (lpfn && lpfn < bo->placements[i].lpfn))
-			bo->placements[i].lpfn = lpfn;
-
 		if (bo->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS &&
 		    bo->placements[i].mem_type == TTM_PL_VRAM)
 			bo->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
@@ -989,23 +960,6 @@ int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
 	return r;
 }
 
-/**
- * amdgpu_bo_pin - pin an &amdgpu_bo buffer object
- * @bo: &amdgpu_bo buffer object to be pinned
- * @domain: domain to be pinned to
- *
- * A simple wrapper to amdgpu_bo_pin_restricted().
- * Provides a simpler API for buffers that do not have any strict restrictions
- * on where a buffer must be located.
- *
- * Returns:
- * 0 for success or a negative error code on failure.
- */
-int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain)
-{
-	return amdgpu_bo_pin_restricted(bo, domain, 0, 0);
-}
-
 /**
  * amdgpu_bo_unpin - unpin an &amdgpu_bo buffer object
  * @bo: &amdgpu_bo buffer object to be unpinned
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index d7e27957013f..44ffd9a03dce 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -322,8 +322,6 @@ void amdgpu_bo_kunmap(struct amdgpu_bo *bo);
 struct amdgpu_bo *amdgpu_bo_ref(struct amdgpu_bo *bo);
 void amdgpu_bo_unref(struct amdgpu_bo **bo);
 int amdgpu_bo_pin(struct amdgpu_bo *bo, u32 domain);
-int amdgpu_bo_pin_restricted(struct amdgpu_bo *bo, u32 domain,
-			     u64 min_offset, u64 max_offset);
 void amdgpu_bo_unpin(struct amdgpu_bo *bo);
 int amdgpu_bo_init(struct amdgpu_device *adev);
 void amdgpu_bo_fini(struct amdgpu_device *adev);
-- 
2.34.1


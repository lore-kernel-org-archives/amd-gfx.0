Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A129DC61CE8
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Jun 2025 12:57:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34DC510EA99;
	Fri,  6 Jun 2025 12:57:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KJ1pQGz2";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EF6B89208
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Jun 2025 12:57:29 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4508287895dso20563795e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 06 Jun 2025 05:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1749214647; x=1749819447; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KhxNjsN0UL7KXKrWJntjpE51GZDwozVOg0sB6jDG+38=;
 b=KJ1pQGz2GAo528JQETNPmxUo6RJbsFpKQudKpbGnk5xgCcCbkBYIHY2i/jMVkLwsjO
 d+QTZ6IfKZdqcRyUpzv0sAmdq5+WuKDNqD0RKlWgs+/3TkpPOxg5TTccdKq57GryxSDe
 ATbYujAnfxiMHEdy1uj/JebzxQAl+QleL5TaObquZERA1l3y+oV8vC0frpWsKVYm9MsH
 nFMp5H5q0rU4G9yLAcPe0keye+JI71EVi/ULlt63ZPiZu/+SxlMeM/KRGi+vzNSANUhu
 qdtZd/O1KFy3cLzsF7KJo+RFf4E+36rnDaftPRm1GifghOSnWk7ywccWnX8nBrkNEIhy
 i5pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749214647; x=1749819447;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KhxNjsN0UL7KXKrWJntjpE51GZDwozVOg0sB6jDG+38=;
 b=wX1fl0/DVQ7Ah7LCqb9jipjdruisUHVTkketZLgabiSXa2o5Cg0yxTwZKF47Ky4Fym
 Lsf2y3IOIvArxzKceNsgmnLJy94/IysudAyagm7Ud/xIA2iEfmpFbVWM/Bue6bNdON+Z
 bYS1o9dd9y8qCI+coeywfgK2zSF9vhG4EauSNFlTG2NvupgnvwqiR2mb13FEJFUcSrx4
 T3wYDF4y0nzACqLVAW9oqANXsVd8pjn022S/J8bi2YDy/mE/Ox0YS2T/cWsS0oMCdSLa
 Q912mPEyrUQz0fFGEWXC9PZ1SYgsRYQw/V9uWXeuYeYqPxqA2az0N2zX06i4mpLmouSj
 iW/Q==
X-Gm-Message-State: AOJu0YwijDTv8soeSduy/0d/OorpMVkOjkO0lq9kZLEymP+ErBbkT0X6
 ivrUjVOGAfQi9uumt3zrajPHxuuGRvc7DhgF28jsHDowweylr3aSaQFgbDfkjrrRB9I=
X-Gm-Gg: ASbGncvQRWIh2TpO5pBnWar+QEfU6O1V5ijFm06J5C1e+KmtXPqB2DL8jgDZpb0TYwV
 5deiKxAtpmPrMN+qGqIpQiHqO11fC/nD2o1+sKE2SFZWNK420NMMeYGGqRatZLlVHKcRYw/8evW
 pckBfyx6y95aBfvqWKRyMpwnSQ4wnMhPIYAVGCseknNd1ifomIQyDSz08zMZSRfZTpNX9QxA7Us
 7mC4BlLv8YrDDfOmNHRlYFPhIna5XldJSjS+yLlJE/JiDpxd+aGxyouTUF7CikRj6q+cdGODtxT
 2kKma6GTaH9smpJNrSX4PZHPerlloSkU1NoEZPJFxDiV3ulGLdN6DoVUZ/MVz0Vd
X-Google-Smtp-Source: AGHT+IHdx8hUKmqdAsT2BQEO96Jn74Lj15axZ/P28X3AI5RvW1THcVOO4bhXtr6h9O+80sARmfPO8Q==
X-Received: by 2002:a05:600c:6085:b0:442:cd12:c68a with SMTP id
 5b1f17b1804b1-452014e9e04mr32730505e9.1.1749214646993; 
 Fri, 06 Jun 2025 05:57:26 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1565:ad00:26a5:e8c7:a8d0:1cac])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45209bc6d6dsm23539075e9.3.2025.06.06.05.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Jun 2025 05:57:26 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, rajneesh.bhardwaj@amd.com,
 felix.kuehling@amd.com, david.francis@amd.com
Subject: [PATCH 3/3] drm/amdgpu: revert "Implement new dummy vram manager"
Date: Fri,  6 Jun 2025 14:57:23 +0200
Message-Id: <20250606125723.7822-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250606125723.7822-1-christian.koenig@amd.com>
References: <20250606125723.7822-1-christian.koenig@amd.com>
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

This is should be unecessary since a VRAM manager isn't mandatory in
the first place.

It could be that we have some missing checks inside AMDGPU or TTM but
those should then be fixed instead of worked around like that.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c      | 15 +++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 61 ++------------------
 2 files changed, 13 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 9c5df35f05b7..db7980105953 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -1875,11 +1875,13 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 	}
 	adev->mman.initialized = true;
 
-	/* Initialize VRAM pool with all of VRAM divided into pages */
-	r = amdgpu_vram_mgr_init(adev);
-	if (r) {
-		DRM_ERROR("Failed initializing VRAM heap.\n");
-		return r;
+	if (!adev->gmc.is_app_apu) {
+		/* Initialize VRAM pool with all of VRAM divided into pages */
+		r = amdgpu_vram_mgr_init(adev);
+		if (r) {
+			DRM_ERROR("Failed initializing VRAM heap.\n");
+			return r;
+		}
 	}
 
 	/* Change the size here instead of the init above so only lpfn is affected */
@@ -2078,7 +2080,8 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 		drm_dev_exit(idx);
 	}
 
-	amdgpu_vram_mgr_fini(adev);
+	if (!adev->gmc.is_app_apu)
+		amdgpu_vram_mgr_fini(adev);
 	amdgpu_gtt_mgr_fini(adev);
 	amdgpu_preempt_mgr_fini(adev);
 	amdgpu_doorbell_fini(adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
index abdc52b0895a..2032310446e7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -396,45 +396,6 @@ int amdgpu_vram_mgr_query_page_status(struct amdgpu_vram_mgr *mgr,
 	return ret;
 }
 
-static void amdgpu_dummy_vram_mgr_debug(struct ttm_resource_manager *man,
-				  struct drm_printer *printer)
-{
-	DRM_DEBUG_DRIVER("Dummy vram mgr debug\n");
-}
-
-static bool amdgpu_dummy_vram_mgr_compatible(struct ttm_resource_manager *man,
-				       struct ttm_resource *res,
-				       const struct ttm_place *place,
-				       size_t size)
-{
-	DRM_DEBUG_DRIVER("Dummy vram mgr compatible\n");
-	return false;
-}
-
-static bool amdgpu_dummy_vram_mgr_intersects(struct ttm_resource_manager *man,
-				       struct ttm_resource *res,
-				       const struct ttm_place *place,
-				       size_t size)
-{
-	DRM_DEBUG_DRIVER("Dummy vram mgr intersects\n");
-	return true;
-}
-
-static void amdgpu_dummy_vram_mgr_del(struct ttm_resource_manager *man,
-				struct ttm_resource *res)
-{
-	DRM_DEBUG_DRIVER("Dummy vram mgr deleted\n");
-}
-
-static int amdgpu_dummy_vram_mgr_new(struct ttm_resource_manager *man,
-			       struct ttm_buffer_object *tbo,
-			       const struct ttm_place *place,
-			       struct ttm_resource **res)
-{
-	DRM_DEBUG_DRIVER("Dummy vram mgr new\n");
-	return -ENOSPC;
-}
-
 /**
  * amdgpu_vram_mgr_new - allocate new ranges
  *
@@ -879,14 +840,6 @@ static void amdgpu_vram_mgr_debug(struct ttm_resource_manager *man,
 	mutex_unlock(&mgr->lock);
 }
 
-static const struct ttm_resource_manager_func amdgpu_dummy_vram_mgr_func = {
-	.alloc	= amdgpu_dummy_vram_mgr_new,
-	.free	= amdgpu_dummy_vram_mgr_del,
-	.intersects = amdgpu_dummy_vram_mgr_intersects,
-	.compatible = amdgpu_dummy_vram_mgr_compatible,
-	.debug	= amdgpu_dummy_vram_mgr_debug
-};
-
 static const struct ttm_resource_manager_func amdgpu_vram_mgr_func = {
 	.alloc	= amdgpu_vram_mgr_new,
 	.free	= amdgpu_vram_mgr_del,
@@ -919,16 +872,10 @@ int amdgpu_vram_mgr_init(struct amdgpu_device *adev)
 	INIT_LIST_HEAD(&mgr->reserved_pages);
 	mgr->default_page_size = PAGE_SIZE;
 
-	if (!adev->gmc.is_app_apu) {
-		man->func = &amdgpu_vram_mgr_func;
-
-		err = drm_buddy_init(&mgr->mm, man->size, PAGE_SIZE);
-		if (err)
-			return err;
-	} else {
-		man->func = &amdgpu_dummy_vram_mgr_func;
-		DRM_INFO("Setup dummy vram mgr\n");
-	}
+	man->func = &amdgpu_vram_mgr_func;
+	err = drm_buddy_init(&mgr->mm, man->size, PAGE_SIZE);
+	if (err)
+		return err;
 
 	ttm_set_driver_manager(&adev->mman.bdev, TTM_PL_VRAM, &mgr->manager);
 	ttm_resource_manager_set_used(man, true);
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C495DC27C5E
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Jun 2024 09:26:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E8AC10E3C2;
	Mon, 10 Jun 2024 09:26:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GZUKepZ+";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE6F10E3C2
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 09:26:15 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-35dc1d8867eso3248138f8f.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 10 Jun 2024 02:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718011573; x=1718616373; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bqohxCPkPP9tZyWeUOR6sGGXW9awOxxjB5Nu81kZgl4=;
 b=GZUKepZ+2+RVJPpyswGe6BJKsbvUknOHoBRwA+1vecupkH53HKl6m0bY9KfLuXUFCc
 ZZBaKHx9iPxH1Da8Le1upNFBsQ7nGhsoYD5PBRf0wg4itegM0dMQGcr2uBiRGOfgo/wl
 tJJ8saP2Zd8hNxaEwoi8wzUnswX9Usy78m66az4qPKOuEaVtLuC68EbZajJkWhTOUlF3
 WIXRHCTBxPpivn2Peix4AObPHEoQVnL4oroCWksksGkAjGzpJOKjHThzrRLaLntHHPxt
 aeNj1VeiseEsBtoPYl9fEXMHV54mt1cz3TtZDz5C04qI9nn46dx8+9/vvUONvh2KW18V
 YJAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718011573; x=1718616373;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bqohxCPkPP9tZyWeUOR6sGGXW9awOxxjB5Nu81kZgl4=;
 b=AunjczIPuPX2TTtrOo/6X0qYDg4mA1ST1POGcNPcCYHLWZJpHiK7qMAfANoAj4qImf
 PUqEgKN9xe6iH2oj7IfkUIF+Elr5BR3QMxNDOgBQFablZ07MG98Dx5/6L2NA5i+e9I9m
 afHUFQ2K8oMnu+q5b+DRSS9n4s8CuDzbWefmsdhGdm26qODr8ZOriYq1EvQ2J5YbW0wN
 +VpfUF1idFV4s9yFbeippMjDjIwYHpQlmcD+wU+44W5j+kcivXPPmqhrxs52UbV7GxsL
 mGis+2IyvOvKgUkFlApwY0H9ReiB4v519lPlax4nIRSG7QWNubf8BqCT3paQ3J2FdVAa
 ebVQ==
X-Gm-Message-State: AOJu0YwqHhknF9EflA2WR1RaN0Ghhw7vBWsCOR+Lw2Mzlrdigjt3TQC3
 HEmBN1mfmlAPoAa+kx+IpJ6lF0vtyhuiEHiuQChoBY5zB/hnnElu
X-Google-Smtp-Source: AGHT+IHrgWG/qc8MkEsGQyPLg1OCekEFRfPcYDSz7X60h8vTwpyRaaxr5AoIgSLxVONZpT6jKLJ5Ow==
X-Received: by 2002:a05:6000:1b09:b0:35f:275c:fb6f with SMTP id
 ffacd0b85a97d-35f275cfc9dmr793367f8f.65.1718011573463; 
 Mon, 10 Jun 2024 02:26:13 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15f9:7000:4916:a8ec:dd12:5894])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35f2169fc45sm3075827f8f.10.2024.06.10.02.26.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jun 2024 02:26:12 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: pierre-eric.pelloux-prayer@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/9] drm/amdgpu: remove amdgpu_pin_restricted()
Date: Mon, 10 Jun 2024 11:26:04 +0200
Message-Id: <20240610092611.2894-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240610092611.2894-1-christian.koenig@amd.com>
References: <20240610092611.2894-1-christian.koenig@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 56 ++--------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h |  2 -
 2 files changed, 5 insertions(+), 53 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index f5a33178651e..9227634b6173 100644
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
index bc42ccbde659..29a86f17fac8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -316,8 +316,6 @@ void amdgpu_bo_kunmap(struct amdgpu_bo *bo);
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


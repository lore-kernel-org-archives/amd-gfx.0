Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5F6C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Dec 2022 16:34:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97B8410E0BD;
	Mon, 12 Dec 2022 16:34:09 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com
 [IPv6:2a00:1450:4864:20::62a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B76810E0BD
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Dec 2022 16:34:03 +0000 (UTC)
Received: by mail-ej1-x62a.google.com with SMTP id gh17so29491175ejb.6
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Dec 2022 08:34:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=1bE1AVv7EHrUCdJHHq0gRBOQM75CLZqYXCPDCbeRyh0=;
 b=OpfNfPOBayDi1YwxD1rhmMmEH+wDHiX3J/J8icxsGx17l97GbmobrGipzFpB7E67O9
 1NMM6zFav/9ki0l43oDMqCF0NKNoSM2uOVklL/UA1HZ57d372MBx5ifyztuWE4RXD6XV
 LFtoDCFG/CMOPdZthVELWb8Awd7RIb4fKBRCdgeS1UwRqJZC4mT0oWHH8wVAmt+6zSFR
 ylx6NDFVyoT7WtBw3DkRMceIPMyNMGKj176h9PUJXpCBvUiUMOK4fi9m1qe2nDpHG1PG
 HL2CR8S12VeBi5b1A5wuHCsIwSo7EGkHvbEayjh5FjuNeueiP82IKt5+9FZQ8fcj/3Un
 ERHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1bE1AVv7EHrUCdJHHq0gRBOQM75CLZqYXCPDCbeRyh0=;
 b=fUGxRQuVadr9nuLPnaW6dYiLjMy4Dl+JDgpUFqivD9eRCiYMCORxOZz7wI6rqShH62
 NBqvY0k/B+o1QqdEGLq3l/utv6GVPLoBlijlTRd6Vy1kasc7qHNubIwvM+YE3cAUjSxw
 pvcPDiSXAZ0GUFHBIROcwChGFTOIlfuBH9dReZsSnvMYUyfHANWQ1P1im9VDpQbA9Ojp
 F/Tv5zhymx/pLzv/v+/V3+LSmV3EXWYJGfVpKE7o8kZlmF7TMG8yiLn8JkCkRxhpccp0
 h7hi4oIOCxlf5iATwzuHkDGjS17LIiDxZgLd79ALSKuEEuz27fuaUi0VLI1uafX2kSwM
 K7tA==
X-Gm-Message-State: ANoB5plO2kNc3/uNgWQJLLvcy3Ejcr8rZ1Lq9mqCx51I2Pxfugf0C1bZ
 t0wHUC/pBWhg570XW3c423LRfiqERyU=
X-Google-Smtp-Source: AA0mqf6Gf1Owd0w2/YCPH8m/0HfNctp/Jm6pup/cYzYD+G6O/MIaZGAzQ62qY8pVaEhZYV09lG2QAw==
X-Received: by 2002:a17:906:1614:b0:7aa:8f6c:334d with SMTP id
 m20-20020a170906161400b007aa8f6c334dmr18705829ejd.50.1670862841805; 
 Mon, 12 Dec 2022 08:34:01 -0800 (PST)
Received: from able.fritz.box (p5b0ea229.dip0.t-ipconnect.de. [91.14.162.41])
 by smtp.gmail.com with ESMTPSA id
 1-20020a170906310100b0078128c89439sm3527419ejx.6.2022.12.12.08.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Dec 2022 08:34:01 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: revert "generally allow over-commit during BO
 allocation"
Date: Mon, 12 Dec 2022 17:33:59 +0100
Message-Id: <20221212163359.3251969-1-christian.koenig@amd.com>
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
Cc: felix.kuehling@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 4ec11490081bcbc4b90d20622cd211c6eba8d6fc.

This causes problem for KFD because when we overcommit we accidentially
bind the BO to GTT for moving it into VRAM. We also need to make sure
that this is done only as fallback after trying to evict first.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c    | 16 +++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c |  6 +++++-
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index 62e98f1ad770..a0780a4e3e61 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -113,7 +113,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
 	bp.resv = resv;
 	bp.preferred_domain = initial_domain;
 	bp.flags = flags;
-	bp.domain = initial_domain | AMDGPU_GEM_DOMAIN_CPU;
+	bp.domain = initial_domain;
 	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
 
 	r = amdgpu_bo_create_user(adev, &bp, &ubo);
@@ -332,10 +332,20 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
 	}
 
 	initial_domain = (u32)(0xffffffff & args->in.domains);
+retry:
 	r = amdgpu_gem_object_create(adev, size, args->in.alignment,
-				     initial_domain, flags, ttm_bo_type_device,
-				     resv, &gobj);
+				     initial_domain,
+				     flags, ttm_bo_type_device, resv, &gobj);
 	if (r && r != -ERESTARTSYS) {
+		if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED) {
+			flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
+			goto retry;
+		}
+
+		if (initial_domain == AMDGPU_GEM_DOMAIN_VRAM) {
+			initial_domain |= AMDGPU_GEM_DOMAIN_GTT;
+			goto retry;
+		}
 		DRM_DEBUG("Failed to allocate GEM object (%llu, %d, %llu, %d)\n",
 				size, initial_domain, args->in.alignment, r);
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index fd3ab4b5e5bb..871f7c136de5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -582,7 +582,11 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
 		bo->flags |= AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE;
 
 	bo->tbo.bdev = &adev->mman.bdev;
-	amdgpu_bo_placement_from_domain(bo, bp->domain);
+	if (bp->domain & (AMDGPU_GEM_DOMAIN_GWS | AMDGPU_GEM_DOMAIN_OA |
+			  AMDGPU_GEM_DOMAIN_GDS))
+		amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
+	else
+		amdgpu_bo_placement_from_domain(bo, bp->domain);
 	if (bp->type == ttm_bo_type_kernel)
 		bo->tbo.priority = 1;
 
-- 
2.34.1


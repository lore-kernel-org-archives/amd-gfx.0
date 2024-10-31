Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDD7E6896B
	for <amd-gfx@archiver.kernel.org>; Thu, 31 Oct 2024 09:49:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E07A10E836;
	Thu, 31 Oct 2024 09:49:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K9gjtwy6";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD41E10E84C
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2024 09:49:32 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-43161c0068bso5966255e9.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 31 Oct 2024 02:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1730368171; x=1730972971; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Do5g4D4zKNl5/POIK/gsq/si2p0Yj5lyPfpHth+kq7E=;
 b=K9gjtwy6KUSdlwqhOe4xgyTtF0kBexI9K/icEKScGniDuarSfTgpExTGHk414dZyJg
 CR14SIJIuo44GzkwopH5VDnH8P7HSUOx4esFnv1bDlrGLURPkblqf7kjLWrGJhW+WItT
 FVnFR36Uz8sA7P2r2O867eHm9jFP57GdmVXaP8DyyriCkQ8s5A9k4oAmFMihrN9qeEn8
 c8XzL02JsrLjhPEhBCMwMcqieBc/HtIwO8QZAVc9DQLLoeJXIWwxIn/XM3RyGYA8QcdQ
 qL8oIqlf1qeLFbYAT73hQ+c9IKlwxpgt+obG4ru8vOgxTNlYiw9J3VLpGuJ3oM5YQnED
 F8MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730368171; x=1730972971;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Do5g4D4zKNl5/POIK/gsq/si2p0Yj5lyPfpHth+kq7E=;
 b=cpzughtp611akaHbzlaYnfFWC5kRYq7KQjXIqF3dLzZM7wPEuhXykf78UsBhtqoUL1
 8q+WjKq5f7YVu9XM5DDoR4hhT2me420/FeDR8jq6j+kIvoy+PDxbjJij1peCsNgV5kYj
 UUCNKhedsWikM+pyt+G5ellIRCQ9ZZU13F8IQoGCJcF5ZBTi5QhzM357xBOouHRUNoGG
 plTNnYN3xEEGQUyvn6tsg/jBm67hmxxq7aTypJZBf6DkMyaTw+dcIFTv2PMwECGz0BqV
 pzNhyFQ2IthZxu9rBtcZJXcotWl7DYdlpiBajFKNU2CIKJ9zjfIrmjNl7bJO9uQDxVpv
 H1nw==
X-Gm-Message-State: AOJu0Yzy0en5vlLdbpzYaYhdLCve+yYpBa345z8wZ8h0PqpdEIYL9/DJ
 yuUhOz7ZRdmi0HAmuJq/CF2s7gcrDA2rMQMQOESKVKbOCo3p6Q9a6mgPvQ==
X-Google-Smtp-Source: AGHT+IEtQb/5c316lghsKUysoaqzEFTBgXu4r2XrH7sfXdo6UI22epWq0tTf7Gl8eYUR6CGq8Mr17w==
X-Received: by 2002:a05:600c:4fc6:b0:431:6083:cd2a with SMTP id
 5b1f17b1804b1-4319acb1d8fmr136133865e9.15.1730368170941; 
 Thu, 31 Oct 2024 02:49:30 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15f7:7300:df63:7ee4:63c0:fe06])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4327d69845csm19202625e9.47.2024.10.31.02.49.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Oct 2024 02:49:30 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org, felix.kuehling@amd.com,
 rajneesh.bhardwaj@amd.com
Cc: Pierre-eric.Pelloux-prayer@amd.com
Subject: [PATCH] drm/amdgpu: fix check in gmc_v9_0_get_vm_pte()
Date: Thu, 31 Oct 2024 10:49:29 +0100
Message-Id: <20241031094929.55323-1-christian.koenig@amd.com>
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

The coherency flags can only be determined when the BO is locked and that
in turn is only guaranteed when the mapping is validated.

Fix the check, move the resource check into the function and add an assert
that the BO is locked.

Signed-off-by: Christian König <christian.koenig@amd.com>
Fixes: d1a372af1c3d ("drm/amdgpu: Set MTYPE in PTE based on BO flags")
---
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index f43ded8a0aab..50c5da3020cb 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1130,8 +1130,10 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 					 uint64_t *flags)
 {
 	struct amdgpu_device *bo_adev = amdgpu_ttm_adev(bo->tbo.bdev);
-	bool is_vram = bo->tbo.resource->mem_type == TTM_PL_VRAM;
-	bool coherent = bo->flags & (AMDGPU_GEM_CREATE_COHERENT | AMDGPU_GEM_CREATE_EXT_COHERENT);
+	bool is_vram = bo->tbo.resource &&
+		bo->tbo.resource->mem_type == TTM_PL_VRAM;
+	bool coherent = bo->flags & (AMDGPU_GEM_CREATE_COHERENT |
+				     AMDGPU_GEM_CREATE_EXT_COHERENT);
 	bool ext_coherent = bo->flags & AMDGPU_GEM_CREATE_EXT_COHERENT;
 	bool uncached = bo->flags & AMDGPU_GEM_CREATE_UNCACHED;
 	struct amdgpu_vm *vm = mapping->bo_va->base.vm;
@@ -1139,6 +1141,8 @@ static void gmc_v9_0_get_coherence_flags(struct amdgpu_device *adev,
 	bool snoop = false;
 	bool is_local;
 
+	dma_resv_assert_held(bo->tbo.base.resv);
+
 	switch (amdgpu_ip_version(adev, GC_HWIP, 0)) {
 	case IP_VERSION(9, 4, 1):
 	case IP_VERSION(9, 4, 2):
@@ -1257,9 +1261,8 @@ static void gmc_v9_0_get_vm_pte(struct amdgpu_device *adev,
 		*flags &= ~AMDGPU_PTE_VALID;
 	}
 
-	if (bo && bo->tbo.resource)
-		gmc_v9_0_get_coherence_flags(adev, mapping->bo_va->base.bo,
-					     mapping, flags);
+	if ((*flags & AMDGPU_PTE_VALID) && bo)
+		gmc_v9_0_get_coherence_flags(adev, bo, mapping, flags);
 }
 
 static void gmc_v9_0_override_vm_pte_flags(struct amdgpu_device *adev,
-- 
2.34.1


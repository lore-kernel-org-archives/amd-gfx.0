Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1556C3DA49
	for <amd-gfx@archiver.kernel.org>; Thu, 25 Jul 2024 08:07:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97C0210E0CF;
	Thu, 25 Jul 2024 08:07:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EWFJtNGv";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4AC3510E0CF
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 08:07:54 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-a7a8a4f21aeso31013866b.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 25 Jul 2024 01:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721894873; x=1722499673; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Cl2hETEHvHJ0ygXNygoUyQbNZcPCcNKRdb2fgsgz4iA=;
 b=EWFJtNGv76F9hUTfG98MRZD3YUqVyyTEOVou8RF92hspTOshlSkjpf2BGGE/s0H9wd
 FZ3Q217lGSirUnKX0u3W9v492rsSIcIxIIdaxQt/iI044WBb7tshXAesbu9XvXOx56wZ
 vasCwSWiR/BAGxUqEW7m8IslcMwL5iINO3SE4gpX3AKWyUe5dAvjqKVaOLHC3TPEvLy+
 CHUIg0a+o/jBy6tG2NY1sw1oRsfeyCHngdPbKIrk7M3kOxs15IL1QRSNBZ246wq1ALb8
 ADE1onWOxCFQlDGtYdVf9L+9dTe5xvQve0gHz5t8fQdxJM1AM3Wq9A+oeDYIUESTmT2i
 0yzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721894873; x=1722499673;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Cl2hETEHvHJ0ygXNygoUyQbNZcPCcNKRdb2fgsgz4iA=;
 b=Jvcm4oRajuzFj+YcT6PejO/oKoTlYM6KUa0iZvYBZj70dXEPUhjN3NigNCG2rAMbVk
 QbL66RkaIaGzDPKkHeXpDpAOKIUwUAgUgEZz1q5Naf7ko71KkEbO2LVfexQ2FkTKLEGn
 mLh+yFtQvQAUjq8Dk9DdRO7k94/OWUt/JF11EcOi2Hjp0bplpF4eQjlwcuVv72DDq/jW
 CJiVwtWKPQHxONM9AnMYwpRYykFnTo8Fg/b84jeLOuLhhUV/B3QulaSg+TN/iQHawz6+
 G0Sl5re1ngKBHfY0dFW3BTH7tawRwdwY2xBhMZdAprnhb2DQ7l/fiRz3BqLnagYufu1y
 DvHg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX03k+t2USnKX7zWnku1MD/hpRlEjjd4QpGD6W48fDU+uyyRSwRj3jsGKnU22fhCQP36flkiBIGSDmq820IoEZj8TFM2xC33fu+WuUuaA==
X-Gm-Message-State: AOJu0YzkcRezdjI1Y8GHZYtHluuhBET1PhnVVUK+4g/pU2okD9LeBJSe
 H4EFysPmoauK2HTgvTAGdL2apk4WR/Vp23Dr0lX2AFZfqWotNTyI
X-Google-Smtp-Source: AGHT+IG4P9y9hWl2tX8Jtozm83dPHJfpRNl1aXrsWqKuVOEJ8cLMaRYR7dRPKJElCUH0i6Y0WO99WA==
X-Received: by 2002:a17:907:940d:b0:a7a:b977:4c9b with SMTP id
 a640c23a62f3a-a7acb4d1951mr72529666b.27.1721894872321; 
 Thu, 25 Jul 2024 01:07:52 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:156b:9000:dd92:4876:4a6a:b954])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad4348bsm44371266b.118.2024.07.25.01.07.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jul 2024 01:07:51 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexdeucher@gmail.com,
	airlied@gmail.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: fix contiguous handling for IB parsing v2
Date: Thu, 25 Jul 2024 10:07:50 +0200
Message-Id: <20240725080750.183176-1-christian.koenig@amd.com>
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

Otherwise we won't get correct access to the IB.

v2: keep setting AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS to avoid problems in
    the VRAM backend.

Signed-off-by: Christian König <christian.koenig@amd.com>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3501
Fixes: e362b7c8f8c7 ("drm/amdgpu: Modify the contiguous flags behaviour")
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index ec888fc6ead8..13eb2bc69e34 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1763,7 +1763,7 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
 	struct ttm_operation_ctx ctx = { false, false };
 	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo_va_mapping *mapping;
-	int r;
+	int i, r;
 
 	addr /= AMDGPU_GPU_PAGE_SIZE;
 
@@ -1778,13 +1778,13 @@ int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
 	if (dma_resv_locking_ctx((*bo)->tbo.base.resv) != &parser->exec.ticket)
 		return -EINVAL;
 
-	if (!((*bo)->flags & AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS)) {
-		(*bo)->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
-		amdgpu_bo_placement_from_domain(*bo, (*bo)->allowed_domains);
-		r = ttm_bo_validate(&(*bo)->tbo, &(*bo)->placement, &ctx);
-		if (r)
-			return r;
-	}
+	(*bo)->flags |= AMDGPU_GEM_CREATE_VRAM_CONTIGUOUS;
+	amdgpu_bo_placement_from_domain(*bo, (*bo)->allowed_domains);
+	for (i = 0; i < (*bo)->placement.num_placement; i++)
+		(*bo)->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
+	r = ttm_bo_validate(&(*bo)->tbo, &(*bo)->placement, &ctx);
+	if (r)
+		return r;
 
 	return amdgpu_ttm_alloc_gart(&(*bo)->tbo);
 }
-- 
2.34.1


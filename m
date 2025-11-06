Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E060CCFA13
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 18:45:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7F6810E9B2;
	Thu,  6 Nov 2025 18:45:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="emQN7zyE";
	dkim-atps=neutral
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
 [209.85.221.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24CDE10E9B1
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 18:45:45 +0000 (UTC)
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-55953d7486cso797071e0c.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Nov 2025 10:45:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762454744; x=1763059544; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=dCrbnWh+EGSj9vJg1Bb1SWr+vMTakV4QgqHGgI8vgj0=;
 b=emQN7zyEuUu8+B98gheUsgTBACWbKSuawEhKMlfEWhdXsByOJXBRmshbaZ0WnV6MRR
 3SVE6aGvv/zrmc8Js/jBNnj573UMPjO7D6ivdbzM+3iWYshuZsFL0Gk0P7/sNr7sQVPk
 zroRt9+omEn1a72Hr0dbFOEqFxb4bpNRLofDYXTc9VeyrBWai71yDb87pK9lpUqbCiEu
 QWn6b6qu5xCPxw0b0pJWHFdVY5fx5FS9+0ckb5pcNf+N+tKWy8zVDZNcYkkbaFXifTmH
 z48Oa8UgjLniL/NQJggBO414OMCHokgVNy8PPnbwjFgyT1THf3zfV338nwftR38cxpiJ
 YXBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762454744; x=1763059544;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=dCrbnWh+EGSj9vJg1Bb1SWr+vMTakV4QgqHGgI8vgj0=;
 b=bQqwRgaal3+xFJTPOHq9myUxaYGoyd8/63UVquVNepqlFpgVGDjuTIzo91zOrjOYzh
 o9sZ4SBMdcR9rrN1W1L0LIlGrBahYfuhiL8umsPmttafQJcRJwoYB+XOfu7Y0wQKcWCi
 ePjoKAwqyb3I1+EWjYjUv2b6VJNDt2EEJmGF97OuUndICzKYU1FI1VW+8GwI5sG30wHo
 elpnFK9ts4dRvj8UVvdclZ/exVi2hwa0DUOlJnWz3TySSKXT0QFUnxVOQ5PJeTbomfSZ
 k9Bgp95gSEQS/jrMjem69n4lDyL/16hgRqcorW6u4gWLjJ4eQIWlhmONwYDsclG8JEOT
 8MPw==
X-Gm-Message-State: AOJu0YyDHTgvUE0rExWrMBz0t7sLyz7hNetAUXSmA9PGmGXAZZ3R9LUR
 PfuZKtUKOqNN8d9++hCLbSBzchzwS4ESYb5BCLG9jFaAbVdPi+G+Px2Nd2XKYrZP
X-Gm-Gg: ASbGnct080lM6njQIa2Gpo/RnsL6C5j/4agMeik9osmCX1el4kmaEr5bfRWbk7KaHVZ
 ZOg+vQtEQYp0gtjdQYyuNCT+jKaSeucg5sNht728GlEuIwsUH4mMGU3arayMnDBZ4/XaWfjN8ML
 4NZVW/aVsCrsm+RxFQ26uSaCPBq8Dt5qQCDtaEyTo+9KEbfDmDv+wAI74yZwh7gGwUDv3r3cf28
 hdmTwmKybkbyU3O4EuJ4nIF6AzNZ94z5g/vrtA8HULiyu9rwxLk1nKMno7f3iBfRn5UFfKgF+0E
 cwAKInq8bXG4mkqH7j+NAMHzf9lFWw8dgQiWIVf/k3MgjI84HViRphsKRlT/T4mSZhxNufbVSa5
 T8Gcny6YERHCL99MiUTv3TQzSxlwAMPe87pyQx9Oec0pFkWysjfOaeuMvtdW3RlspaS7FW7bufU
 KSES0awKQDztkSpWCuM2c=
X-Google-Smtp-Source: AGHT+IFXz0qOkMUdzJtS5EmCwds7OUBFGRjUUxugjZyePlxlsS3ZPLlwoD3+8O9SWjfJzVmwXKHukg==
X-Received: by 2002:a05:6122:180d:b0:54a:992c:815e with SMTP id
 71dfb90a1353d-559a3acb047mr238074e0c.8.1762454744096; 
 Thu, 06 Nov 2025 10:45:44 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-559957fb3c1sm1810004e0c.12.2025.11.06.10.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 10:45:43 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 03/13] drm/amdgpu/ttm: Use GART helper to map VRAM pages (v2)
Date: Thu,  6 Nov 2025 19:44:38 +0100
Message-ID: <20251106184448.8099-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106184448.8099-1-timur.kristof@gmail.com>
References: <20251106184448.8099-1-timur.kristof@gmail.com>
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

Use the GART helper function introduced in the previous commit
to map the VRAM pages of the transfer window to GART.
No functional changes, just code cleanup.

Split this into a separate commit to make it easier to bisect,
in case there are problems in the future.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index e226c3aff7d7..84f9d5a57d03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -188,7 +188,6 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
 	struct amdgpu_job *job;
 	void *cpu_addr;
 	uint64_t flags;
-	unsigned int i;
 	int r;
 
 	BUG_ON(adev->mman.buffer_funcs->copy_max_bytes <
@@ -254,16 +253,9 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
 		dma_addr = &bo->ttm->dma_address[mm_cur->start >> PAGE_SHIFT];
 		amdgpu_gart_map(adev, 0, num_pages, dma_addr, flags, cpu_addr);
 	} else {
-		dma_addr_t dma_address;
-
-		dma_address = mm_cur->start;
-		dma_address += adev->vm_manager.vram_base_offset;
+		u64 pa = mm_cur->start + adev->vm_manager.vram_base_offset;
 
-		for (i = 0; i < num_pages; ++i) {
-			amdgpu_gart_map(adev, i << PAGE_SHIFT, 1, &dma_address,
-					flags, cpu_addr);
-			dma_address += PAGE_SIZE;
-		}
+		amdgpu_gart_map_vram_range(adev, pa, 0, num_pages, flags, cpu_addr);
 	}
 
 	dma_fence_put(amdgpu_job_submit(job));
-- 
2.51.0


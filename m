Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0FC5CD4F52
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 08:22:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F81310EB0D;
	Tue, 19 May 2026 08:22:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lHxH9Dey";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3BFEA10EB0D
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 08:22:18 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4891e5b9c1fso27057415e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 01:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779178937; x=1779783737; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=G1zuXSmDgoMknJfUuOSfTGg6aNkWuvj3DdkfUhXJCw0=;
 b=lHxH9DeyxuS5RwJnHpbj6+1meBX06yJq8EprzCQT1cb4HnYvtY4/bkba6i6Byw3e6g
 ArcNbS+jWe5unQwg9BTxJSQyy5nCTMwjm1RnLcFzsNe+s5dbDQCt+qKkYwvU0PTYyves
 9X41WKDJhR85LwiJDg51u1ZPphGaNJtl5CDiceK7NJ4ugLHV6GkTp/A6Fh1ORNVj04bu
 2Stz9sY1WI5nHdQb58wsOvkhSBCxN4ZvohaI/oCukpnkUE/sVW96BXqnL70zU5Kf2vnd
 N4rv8H7mGun95sTtdyvVUd+UZ8zwZKUwVLaHAUsthE2ynop/epOjRkSRo/55x5pk3cQc
 aK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779178937; x=1779783737;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=G1zuXSmDgoMknJfUuOSfTGg6aNkWuvj3DdkfUhXJCw0=;
 b=iD5G1aVft1hRVOWejZsCA/vtXvShjAbv9VE2cGIrno0xEBZhcGjmCkZJDfY0rnUXSL
 0TOskAMAjpU45/3Ah4yQ5+o9CNJs3gObkt3nqq8rw6u/gvjxX/lfXadtqPy7bILxLNx9
 QAN3Qcn9eHKI6T0E9r8gYPGqhGZW/GktlJ2U+GQbxrvA1V+8gKmf1adgCQXZ/Wqy/XVC
 Ec9A0qjLA0j14LGKrfdrYbUH6cFIkuIcZbQowHMGSFAmgASSCqRO4MqKozDZ6N6QpTOP
 dZfSOE5m33BCXuu248OFnVuvLUCi9fmFCQ4p/qtdYQ1HumWYHjkUTKxFcjrDDz4BaJMU
 POng==
X-Gm-Message-State: AOJu0YwpTLw7gAeSZ0ZnEpNbPkkvWDQSOJCP4mwEeB0RJAcFJcTDRKnE
 qaBZ9knH7aPILtUCAm48cV5NNPTE+sbmwuBF9pniZ0aBhjaJY4Ab40TMBIWZBg==
X-Gm-Gg: Acq92OGbB7YHkg8UpNkr1m3+/f0yM7bT3ZC+Mb5wOLgN5z8mphYE8kdsar3AcaZmsJ6
 WykJXUuFz9bP6a7vaLxFWfEmuJsW+Uiyq0QlLpBqrVqGK2VNw1VH7rGuv1yhefnuZcnai5oqSj7
 jr/Rp5YsQkgr1iGC+kItevWmEYq44RcK8O2P8HnlbwpaUGsPNZ3T2cj9UO91ujYVmvDXiM93V0c
 iQYFwYx+qsC+/oxaDqJU2I4Bpq92MhIie5PaxJJoUDKYCxha9gyVhd/UolhTvYlUrie8ORgdcZM
 bnoFyveQgGpLnoDX/3xohnnuu7aUY6zbtJSu7PQmh73X46gaFd9cWOmwLKS3Sub8aX6r5opn0Bs
 gZqZDcnM0HftwEDnCgPG9DaHkWNjbGQoIS7pQxv/fZeRfarjaHE2dAa+Roz8ED24OAJumb1Ec+G
 PCddLLSMApaxgVBfOSTqU1z5neabbX6XNS43WT7FaGX8+SWmmLb70vInfg3MVfebCC
X-Received: by 2002:a05:600c:8184:b0:488:ffb1:494c with SMTP id
 5b1f17b1804b1-48fe60ed790mr275673235e9.12.1779178931992; 
 Tue, 19 May 2026 01:22:11 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb00e5easm101575685e9.13.2026.05.19.01.22.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 01:22:11 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 John Olender <john.olender@gmail.com>, Liu Leo <Leo.Liu@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 5/5] drm/amdgpu/uvd: Move BOs to GTT when we can't place them
 in VRAM correctly
Date: Tue, 19 May 2026 10:22:04 +0200
Message-ID: <20260519082204.60811-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260519082204.60811-1-timur.kristof@gmail.com>
References: <20260519082204.60811-1-timur.kristof@gmail.com>
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

When VRAM is nearly full, the Buddy allocator makes tradeoffs
and it may place BOs in a way that they cross 256M segments.

Move the BO to GTT when this eventuality is detected.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4800
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c |  3 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 21 +++++++++++++++++++++
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index a106c7e77e26..fb49bd53bd00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -977,6 +977,7 @@ u32 amdgpu_ttm_fill_gart_256M_placements(struct ttm_buffer_object *bo,
 					 u32 max_placements)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
+	const u64 sz = adev->gmc.gart_size;
 	u32 i;
 
 	/* Fill the placements array with 256M segments, starting from highest. */
@@ -984,7 +985,7 @@ u32 amdgpu_ttm_fill_gart_256M_placements(struct ttm_buffer_object *bo,
 		if (i * SZ_256M >= adev->gmc.gart_size)
 			break;
 
-		placements[i].lpfn = (adev->gmc.gart_size - i * SZ_256M) >> PAGE_SHIFT;
+		placements[i].lpfn = MIN(ALIGN(sz, SZ_256M) - i * SZ_256M, sz) >> PAGE_SHIFT;
 		placements[i].fpfn = ALIGN_DOWN(placements[i].lpfn - 1, SZ_256M >> PAGE_SHIFT);
 		placements[i].mem_type = TTM_PL_TT;
 		placements[i].flags = bo->resource->placement;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 993957927782..53f810c2a5fb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -617,6 +617,27 @@ static int amdgpu_uvd_cs_pass1(struct amdgpu_uvd_cs_ctx *ctx)
 			amdgpu_uvd_force_into_uvd_segment(bo);
 
 		r = ttm_bo_validate(&bo->tbo, &bo->placement, &tctx);
+		if (r)
+			return r;
+
+		/* Check if the BO placement crosses a 256M segment. */
+		if ((amdgpu_bo_gpu_offset(bo) >> 28) !=
+		    ((amdgpu_bo_gpu_offset(bo) + amdgpu_bo_size(bo)) >> 28)) {
+			/* There is not enough memory for correct placement of FB/MSG BOs. */
+			if (cmd == 0x0 || cmd == 0x3)
+				return -ENOMEM;
+
+			/* GTT->GTT moves are not implemented yet. */
+			if (bo->tbo.resource->mem_type != TTM_PL_VRAM)
+				return -ENOMEM;
+
+			/* Try to move the BO from VRAM to GART into a 256M segment. */
+			amdgpu_ttm_fill_gart_256M_placements(&bo->tbo,
+							     bo->placements,
+							     ARRAY_SIZE(bo->placements));
+
+			r = ttm_bo_validate(&bo->tbo, &bo->placement, &tctx);
+		}
 	}
 
 	return r;
-- 
2.54.0


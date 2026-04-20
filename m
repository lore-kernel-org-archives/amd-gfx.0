Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE35DF36C58
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 12:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4037910E55E;
	Mon, 20 Apr 2026 12:10:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f9vwpM6W";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 67AA410E560
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 12:10:54 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-488ff90d6c7so20685775e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 05:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776687053; x=1777291853; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7vajUD/OtgMl22weiJMkhCi/ju016gSP3jcsg7ovrE4=;
 b=f9vwpM6WWyrfV7teacjg3fEbZ3GjYltTenEMmXIboZX0+H2S5CbYkPouCshCGUhSs2
 mJHRKVv2ggy343ALdSSCOnCVwvZoe4CzDBYJRNNJHO4JmAQbFZ460twgwQAnNXl8DpAm
 i5gOXBpap8+QvQc4frxY9FtSu017mAT042/eNLNcPC68hufyrSLruSyhxf6SzHQl8z2b
 R7cU7+S+R5+t2hRv8BnA+ZlXnjETHayFkZKlm0xpl1Veb5KSDG/+mfjjMr5XzfLVgKng
 p1DoDvmTD70/DTOy8yV0y7mqrd6XgOcEZzdznoVawRCCf1Z756G6J4CLfNuzDnv+j3sa
 Fycw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776687053; x=1777291853;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7vajUD/OtgMl22weiJMkhCi/ju016gSP3jcsg7ovrE4=;
 b=S9XRiPau4CE40+P6BfcIi6KlJ9Y1FpYwqaPrYYAVdn5Vly2hW5RyI6LgM7rYb95Dhe
 H6iLtrzRNqXHD8fb7aU4l8T9kPrkNqEISfMjfaBSEwDNYEJYP78cMHt+QmZuf1gJ+0tL
 r9oaRDdW44hHfl/kapLNPIG+hRV7ohzgTKxLK+maKENpgV/BZYqMs2Jj9+S1pP2za/VX
 Ygfm7+1rMKU2rSM2K1J+nzETnZgXifckujPPLoXr2lNYP4epEY61eeP+a8RGRidzY7yk
 7tX6YYr6TMCHkzvEcTiry9JOGHV1fypCVjPQPYEc31IDKAQs2lGSAiQ8WpmLiRDg7WmJ
 jY/w==
X-Gm-Message-State: AOJu0YzSpsmI4izEhJeY3ndYQTEtOvwwAf5fy7PxmhnbfOYccU8vHYxZ
 fVJDEu+4ZD+qwIwgQJThf8WabBHj7zABMrAOtCAS2qh8JDTStTx40YgRjQbgwQ==
X-Gm-Gg: AeBDiesM8DZvWqE/cnHLg5sAM7545pXqkxTMRTpTUNHj0lb3gaLpRVaSzwe47xuO+N7
 oh+yK5NDmdi0+8B5L2RqNcebfCs5yo61PYRJ9kdeSWIjcjSgpn8kmUTGnasZAyIRL7+JDG3kZOC
 Q6JtIga8ideC1ntmnXaNd2+Im7xB+uOtieNJ/isbSV2p0CBIbG+jVuFk0ekxFR0OxsmvzYBxMHh
 WmzXYG87XHqbY/RJxhyrbCQOFklrLQP2F2HaYxfbv/wvD/X1OYFJJpgsGY7A9hidWTFdFvrW++8
 2nrFsMfq9qcjtov1gznzCciQkj5bgtVOS6wTGw65ze7r/hROaJ3cphbJIyuJW2m49x7whjL+E7d
 Xl9IeWnijSOo9uqyUU6nCOkBvjtFrU3Rzk/bsqyOpK1JpfCouSCuYRiLsSzUAuMzRMepAgVNxf7
 2AlARlj/qTiLzAPAu/ICbxULXFj/KEmlC3BbLahR0R9+mz6EiiDvFUcNnXy8887wgxBEHiZW2zo
 fDzeQ==
X-Received: by 2002:a05:600c:3f10:b0:485:35d3:ce59 with SMTP id
 5b1f17b1804b1-488fb753c9amr166907445e9.10.1776687052550; 
 Mon, 20 Apr 2026 05:10:52 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb78becdsm129632265e9.5.2026.04.20.05.10.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 05:10:52 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 6/7] drm/amdgpu/vce1: Don't repeat GTT MGR node allocation
Date: Mon, 20 Apr 2026 14:10:43 +0200
Message-ID: <20260420121044.155030-7-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420121044.155030-1-timur.kristof@gmail.com>
References: <20260420121044.155030-1-timur.kristof@gmail.com>
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

Only allocate entries from the GTT manager when the
VCE GTT node is not allocated yet. This prevents the
possibility of allocating them multiple times, which
causes issues during GPU reset and suspend/resume.

Fixes: 66a80158aa2a ("amdgpu/vce: use amdgpu_gtt_mgr_alloc_entries")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index b7b6096c1a1fd..100aa48204c77 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
@@ -541,11 +541,13 @@ static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
 	if (adev->gmc.vram_start < adev->gmc.gart_start)
 		return amdgpu_bo_gpu_offset(adev->vce.vcpu_bo) <= max_vcpu_bo_addr ? 0 : -EINVAL;
 
-	r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr,
-					 &adev->vce.gart_node, num_pages, 0,
-					 DRM_MM_INSERT_LOW);
-	if (r)
-		return r;
+	if (!drm_mm_node_allocated(&adev->vce.gart_node)) {
+		r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr,
+						 &adev->vce.gart_node, num_pages, 0,
+						 DRM_MM_INSERT_LOW);
+		if (r)
+			return r;
+	}
 
 	vce_gart_start_offs = amdgpu_gtt_node_to_byte_offset(&adev->vce.gart_node);
 
-- 
2.53.0


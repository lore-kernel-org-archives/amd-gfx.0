Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08FAFCD4851
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 08:22:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2500F10EB16;
	Tue, 19 May 2026 08:22:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="h36H6j4q";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB85210EB16
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 08:22:10 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-48a563e4ef7so26378415e9.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 01:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779178929; x=1779783729; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BXIwh4tl8ntkh94ZjIB3Bg5GunvMspmvcU/A2FcEew0=;
 b=h36H6j4qYx995AY4NZJZkqaG+A/HbTOoNfneHYXDXmif1nsODYAtrUTe6i/Yo0TPPT
 4idmVDKtCRwvrz5SYchyjRKo1yevrP1g191Tdhx5gq7Giy6Pyi24aTiQdE0N8Ir3xjoW
 sOdlgH0VkAL2jOm0uCXQkMvF+M/qvmQk/mKJPzPhnsL7EbkdXHWm7GQbA0PBl88iiR1R
 WA33JJvKtCTbXtuoIE0CseiKNyUBtbtGH0kzN2yZo2J3fkidRDjZBKQchNSxCSObRQ7z
 zJUu3j73VfByOxPAQSK4HXM/cOYNyzRqBW5pRDYahxpwFH+HIGoK9CLSZFbdqdhF7kds
 Eltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779178929; x=1779783729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BXIwh4tl8ntkh94ZjIB3Bg5GunvMspmvcU/A2FcEew0=;
 b=FFobYuHeqntIH6I5EDzr+tizNpKJOKEgHiihC5ccoYNn4D3zMlzIypVadpDeJcItjM
 N9UxIvjVCcfOD+XQ63LaKktR7RfbfOlKzES8gUSo0A+qvBrboBgXnpStVYtcVKu0KT98
 qQQbNUUDfNRSJlOim5gffdp2miiSLBzVVNUiwnYJkvSh70lVRNCb7ArRn4LRDBDvvWP9
 5McsLc6hZa8x8bragJgXlveKpNWaH6drhWlW4woixrA1bnvN5AHn1yW4eH+wC9Ym6k+m
 RPLsXQGunR+LGWlznsy+3VhlGfdDEmbblFSq/QpVpMLuQlKY25mvj+YKCDADfOpEiNKs
 1LMw==
X-Gm-Message-State: AOJu0YxIdB3dnT9nZ0Sbc5Zc8iBx5HHv9Asmz/px1fPX7jAirZXeCrzu
 iXvPf+QlDH5j29JWT7dCrb2mrnq6CcMCN0wZK0QmJeQ7N8ZKhJR+QWmUeoFefA==
X-Gm-Gg: Acq92OEbeEFd6HyyUNop/9Gn60pYkf7RUisC3R3MhA4u8RXBOMEfzrMAndfW0Ywh2Y6
 oF5ZNA189UML+69zJ/4USR4n/7zkfK8v/GZ7B5mywuGyILyTIbNmwrye8YIM/1kTFmi01YkoRCq
 K5LVrRoAPiFEyVjQuFguMf3O/RrJYC7+hiQl62Bh9YrpveFZnE88RIP9GociguFO8O4egdVrv26
 7YrPtkiUlyWW04bFZKnl5ew3IsD2dj4sIvpPxZhu10dV9x8jVaehjPXg0eaS4C9e29iysuSZ48p
 6RVKYYNfeq5l0DTJWSaCFo7OEDODdIT4XS4eAIhjq1Zqyjx14xlwYezNRXFH75bTFpU4CzBgECT
 kcCnq77WVn6aS9VXDSw4UQS9el4koN3xRgWcYuS1O6LW8fmQeaVRQ/PiFYxiVL/8EX7CnOHVvwQ
 a3xQK94tQXadKIVHi7KGNcgH5XPjOPW0iGvSN9e3KZbSMwulWtNkSwYZ2KvISPsaV9
X-Received: by 2002:a05:600c:630a:b0:48f:e249:4094 with SMTP id
 5b1f17b1804b1-48fe632663emr342179335e9.18.1779178928946; 
 Tue, 19 May 2026 01:22:08 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb00e5easm101575685e9.13.2026.05.19.01.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 01:22:08 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 John Olender <john.olender@gmail.com>, Liu Leo <Leo.Liu@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/5] drm/amdgpu: Use placements of 256M GART segments for
 SI/CIK
Date: Tue, 19 May 2026 10:22:01 +0200
Message-ID: <20260519082204.60811-3-timur.kristof@gmail.com>
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

UVD 4.x and older require that BOs don't cross 256M segments.
We need to respect that in amdgpu_ttm_alloc_gart().
We can't move the BOs later because GTT->GTT moves are
not implemented. We also can't force all BOs to VRAM
because that becomes very problematic in low VRAM scenarios.

This fixes UVD CS BOs crossing 256M segments
when they are placed in the GART.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4799
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 56 ++++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h |  3 ++
 2 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 6c6ab4dd6ea9..a106c7e77e26 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -959,6 +959,40 @@ static int amdgpu_ttm_backend_bind(struct ttm_device *bdev,
 	return 0;
 }
 
+/**
+ * amdgpu_ttm_fill_gart_256M_placements() - Fill placements array with 256M GART segments
+ *
+ * @bo: TTM buffer objects whose placements should be filled
+ * @placements: Pointer to an array of placements
+ * @max_placements: Size of the placements array
+ *
+ * Fill the specified placements array with 256M GART segments,
+ * starting from the highest address in order to reduce the
+ * contention of the lowest segment.
+ *
+ * Returns the number of placements filled.
+ */
+u32 amdgpu_ttm_fill_gart_256M_placements(struct ttm_buffer_object *bo,
+					 struct ttm_place *placements,
+					 u32 max_placements)
+{
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
+	u32 i;
+
+	/* Fill the placements array with 256M segments, starting from highest. */
+	for (i = 0; i < max_placements; ++i) {
+		if (i * SZ_256M >= adev->gmc.gart_size)
+			break;
+
+		placements[i].lpfn = (adev->gmc.gart_size - i * SZ_256M) >> PAGE_SHIFT;
+		placements[i].fpfn = ALIGN_DOWN(placements[i].lpfn - 1, SZ_256M >> PAGE_SHIFT);
+		placements[i].mem_type = TTM_PL_TT;
+		placements[i].flags = bo->resource->placement;
+	}
+
+	return i;
+}
+
 /*
  * amdgpu_ttm_alloc_gart - Make sure buffer object is accessible either
  * through AGP or GART aperture.
@@ -973,7 +1007,7 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
 	struct ttm_operation_ctx ctx = { false, false };
 	struct amdgpu_ttm_tt *gtt = ttm_to_amdgpu_ttm_tt(bo->ttm);
 	struct ttm_placement placement;
-	struct ttm_place placements;
+	struct ttm_place placements[AMDGPU_BO_MAX_PLACEMENTS];
 	struct ttm_resource *tmp;
 	uint64_t addr, flags;
 	int r;
@@ -987,11 +1021,21 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo)
 
 	/* allocate GART space */
 	placement.num_placement = 1;
-	placement.placement = &placements;
-	placements.fpfn = 0;
-	placements.lpfn = adev->gmc.gart_size >> PAGE_SHIFT;
-	placements.mem_type = TTM_PL_TT;
-	placements.flags = bo->resource->placement;
+	placement.placement = &placements[0];
+	placements[0].fpfn = 0;
+	placements[0].lpfn = adev->gmc.gart_size >> PAGE_SHIFT;
+	placements[0].mem_type = TTM_PL_TT;
+	placements[0].flags = bo->resource->placement;
+
+	/*
+	 * UVD 4.x and older require that BOs don't cross 256M segments.
+	 * We need to respect that here. We can't move the BO later
+	 * because GTT->GTT moves are not implemented.
+	 */
+	if (bo->base.size < SZ_256M && adev->family <= AMDGPU_FAMILY_KV)
+		placement.num_placement =
+			amdgpu_ttm_fill_gart_256M_placements(bo, placements,
+							     ARRAY_SIZE(placements));
 
 	r = ttm_bo_mem_space(bo, &placement, &tmp, &ctx);
 	if (unlikely(r))
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index 2d72fa217274..e9de628c8d2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -202,6 +202,9 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
 			    u64 k_job_id);
 struct amdgpu_ttm_buffer_entity *amdgpu_ttm_next_clear_entity(struct amdgpu_device *adev);
 
+u32 amdgpu_ttm_fill_gart_256M_placements(struct ttm_buffer_object *bo,
+					 struct ttm_place *placements,
+					 u32 max_placements);
 int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
 void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
 uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
-- 
2.54.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0F3CCD5BD5
	for <amd-gfx@archiver.kernel.org>; Mon, 25 May 2026 11:33:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6732910E29C;
	Mon, 25 May 2026 11:33:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ANd9uxcG";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8951810E29B
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 11:33:28 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-449de065cb3so9185134f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 May 2026 04:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779708807; x=1780313607; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a5c6gn1CiUzbFcvJsn3o9QnvCvWy4N6NAMg48+TkMlc=;
 b=ANd9uxcGuKalXqwKRvKe31xkCXbfiLBpElK8F2xl39s6t3Dj0cV14YIuHZtfiHSYLx
 AzcP0X+YGkm6rjeby1vK77jmYh9QJqOlI2nrhb8AOzaIjGeJdZxezlxnajrRDWyuf7we
 PTSg0ZMa2k164hKmYY75PPT+FU8ve6y3CpvfJiYJssN/kOHdDqkIfy2xQUmZmzslB0x2
 8loacwKy7JmelZ1qPsmlrzsKJLFvPsnHxntozhB13IQXPwbE0hQ+5c8uhZ/Sg7e5At3t
 nTvvURwMB/5moqmq6MZwVuEvXS/fGa1reAjwGfvjuyFlC0MJXADwdM/xVUf1YMmDTcxo
 cSog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779708807; x=1780313607;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a5c6gn1CiUzbFcvJsn3o9QnvCvWy4N6NAMg48+TkMlc=;
 b=lPX2ORYlu0R8cRbiSSjIwniqjCslgMUUn6nxC5Ucc230jYygzCvSEls0KB6nKvVhj0
 VzGhcJ4w4AnNviMKH9LBQLMqNofkWnj78YVvf+72uyq2KpetW74IvZy6FDWWbQTas1Ff
 IiRo6rSu+zBgP2VKcdpSezP8BhlBh2sod83q06qd8TML6UNvssralAJbmvAPy2mHXaFo
 XKyGlONzzJGL30MQI7wbE22wHja1Hf+911dZnWmK4yOSqz5MWKRfSedSgP4QWO6Qn36/
 sQroYJlQmaPrt+bReHT/jLtpBCVpxqevw9VKKFioFwJFPg308pouqIg5Y6q/S3vp4zfU
 RJsQ==
X-Gm-Message-State: AOJu0Yzw3akIBmk7U7RJhDnX6389uxOOcQEmFyAZNOQpOXCkCF3KoZXv
 rYiv4+UpVlvfw/4o1WbmOlDYBzjDgkUpCip3eRd1PjcgkIMMLBjrXFhhgtjpRA==
X-Gm-Gg: Acq92OGXuXSGgC5cxXUKv+c5VqeD5XOrxc9dJZ72gBnUDKBjggBH6FfBoWUAwzOwwUW
 toeMEoLLMd+yu8wEwHe3o3GkNSEpNI6vFTY6KUSwclB1Q5MTZGI0PgVxTEjgC22Da0w8eugapBY
 qWBu4lmIqCRySaD1qYyt02GlvMHdK2DxDtlxWCB5v34dhGNQZToEaN1c4pV1TAdojEh1D3mXqqX
 8TEvT1DtIEaKXcEvxKKkXzE8FcakAN4wCMYZVP9RY/OwsQakB8Ce6R7DA4dTOmEjNNz2zMUC2Ug
 pS/yhgN6GNAIwfOs5KuQXa55FKoN+jAJD35sBMwVFcD7jRkJWoLt/lB/s62EJ6gMwZPutUQjNiY
 rcp92CLesqioyiXnrQ4hduWKWIlHUSzCx1lBGNqeybo8JVJ7PaXlA9SaVlYEhO+UjHjRYru8Pqj
 +QI239+Iwpk3JxzF7Lk0MWn6iUDKHQGkF53wuKBeTfX2l7Db0pzFtdVZvBkhl1vRqn
X-Received: by 2002:a05:600c:4e4b:b0:485:46fd:7887 with SMTP id
 5b1f17b1804b1-49069da6188mr27642455e9.13.1779708806898; 
 Mon, 25 May 2026 04:33:26 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49045284855sm241047845e9.0.2026.05.25.04.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 04:33:26 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 John Olender <john.olender@gmail.com>, Liu Leo <Leo.Liu@amd.com>,
 Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/4] drm/amdgpu/uvd: Fix forcing MSG,
 FB BOs into VCPU segment when it isn't at 0 (v2)
Date: Mon, 25 May 2026 13:33:20 +0200
Message-ID: <20260525113321.17953-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260525113321.17953-1-timur.kristof@gmail.com>
References: <20260525113321.17953-1-timur.kristof@gmail.com>
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

UVD 4.x and older can only access MSG, FEEDBACK buffers from a
specific 256M VRAM segment that the VCPU BO is also located in.
We already modify all placements of the given BO to ensure
the BO is placed within this segment.

Previously, it always assumed that the VCPU segment is
the first 256M of VRAM, even though under some conditions
the VCPU BO could be allocated outside this segment,
which made UVD non-functional as the BOs were
not inside the same segment as the UVD VCPU BO.

Solve that by using the segment where the VCPU BO actually is.

This fixes an issue with UVD failing to initialize on SI/CIK
when resizable BAR is enabled and the VCPU BO is allocated
in a different segment.

v2:
- For other BOs, keep using the same UVD segment as before.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/3851
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 33 ++++++++++++++++++-------
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 1e59ca924abe..480bf88def46 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -135,7 +135,7 @@ MODULE_FIRMWARE(FIRMWARE_VEGA12);
 MODULE_FIRMWARE(FIRMWARE_VEGA20);
 
 static void amdgpu_uvd_idle_work_handler(struct work_struct *work);
-static void amdgpu_uvd_force_into_uvd_segment(struct amdgpu_bo *abo);
+static void amdgpu_uvd_force_into_vcpu_segment(struct amdgpu_bo *abo);
 
 static int amdgpu_uvd_create_msg_bo_helper(struct amdgpu_device *adev,
 					   uint32_t size,
@@ -158,7 +158,7 @@ static int amdgpu_uvd_create_msg_bo_helper(struct amdgpu_device *adev,
 	amdgpu_bo_kunmap(bo);
 	amdgpu_bo_unpin(bo);
 	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_VRAM);
-	amdgpu_uvd_force_into_uvd_segment(bo);
+	amdgpu_uvd_force_into_vcpu_segment(bo);
 	r = ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 	if (r)
 		goto err;
@@ -550,6 +550,24 @@ void amdgpu_uvd_free_handles(struct amdgpu_device *adev, struct drm_file *filp)
 	}
 }
 
+static void amdgpu_uvd_force_into_vcpu_segment(struct amdgpu_bo *bo)
+{
+	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
+	struct amdgpu_bo *vcpu_bo = adev->uvd.inst[0].vcpu_bo;
+	struct amdgpu_res_cursor vcpu_cur;
+
+	amdgpu_res_first(vcpu_bo->tbo.resource, 0,
+			 amdgpu_bo_size(vcpu_bo), &vcpu_cur);
+
+	bo->placement.num_placement = 1;
+	bo->placement.placement = &bo->placements[0];
+	bo->placements[0].fpfn = ALIGN_DOWN(vcpu_cur.start, SZ_256M) >> PAGE_SHIFT;
+	bo->placements[0].lpfn = bo->placements[0].fpfn + (SZ_256M >> PAGE_SHIFT);
+	bo->placements[0].mem_type = vcpu_bo->tbo.resource->mem_type;
+	if (bo->placements[0].mem_type == TTM_PL_VRAM)
+		bo->placements[0].flags |= TTM_PL_FLAG_CONTIGUOUS;
+}
+
 static void amdgpu_uvd_force_into_uvd_segment(struct amdgpu_bo *abo)
 {
 	int i;
@@ -600,13 +618,10 @@ static int amdgpu_uvd_cs_pass1(struct amdgpu_uvd_cs_ctx *ctx)
 	if (!ctx->parser->adev->uvd.address_64_bit) {
 		/* check if it's a message or feedback command */
 		cmd = amdgpu_ib_get_value(ctx->ib, ctx->idx) >> 1;
-		if (cmd == 0x0 || cmd == 0x3) {
-			/* yes, force it into VRAM */
-			uint32_t domain = AMDGPU_GEM_DOMAIN_VRAM;
-
-			amdgpu_bo_placement_from_domain(bo, domain);
-		}
-		amdgpu_uvd_force_into_uvd_segment(bo);
+		if (cmd == 0x0 || cmd == 0x3)
+			amdgpu_uvd_force_into_vcpu_segment(bo);
+		else
+			amdgpu_uvd_force_into_uvd_segment(bo);
 
 		r = ttm_bo_validate(&bo->tbo, &bo->placement, &tctx);
 	}
-- 
2.54.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B8ECD5BA1
	for <amd-gfx@archiver.kernel.org>; Tue, 19 May 2026 08:22:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6848810EB25;
	Tue, 19 May 2026 08:22:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LoQOyCoh";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 925A310EB17
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 08:22:12 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-490229aa522so260925e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 19 May 2026 01:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779178931; x=1779783731; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k8NDk82IBV/zp2oxuX4l8sUK/1sSeThAs77UQ/H99Es=;
 b=LoQOyCoh2+y9bC0H+GF80ukzcF0kybC6rzwBt4PUNpg9xPOYd0/LCmfMrB07UJywba
 YWFNKWx5N9G/3t14tcSY35qjS4B+D6EwKXgHJCBJ3vPsP6pG6J7xsRSgAJL/eKsPJFTV
 z0AXplyONPG0e+feGzH1pV1omNuwYOIRzAHg9AD+T0ibLi8q3gDsYskCeFIYyfw3kIQU
 HO8Lg7yVfruAojQNfQS+Wjk+8RS40smYyFTdm0Q8ihgrVrfEl6cHl2rdlbuLmpH/5AnI
 AkyGGe0y6hIv5lWdCNMAFUaB5vI6xxGOC9gTwmX58mu+MCX4C8OgxvwrQ5Vh712HYgTI
 tF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779178931; x=1779783731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=k8NDk82IBV/zp2oxuX4l8sUK/1sSeThAs77UQ/H99Es=;
 b=Kke3Hh0dsws0LcIPwelE69IrBQ4O0xLgjHxR3hMAKgK9kc3aZwImAEIjs6eHt0rrJN
 UVgQmh/mO2E3xM5o0yMvAFMs1gtMsvynHL2I82S3ZZcwVHSbqO3Mahspf12cQsnJv3fi
 VKwUWr35K1NzJwd9zOR4Klw+C2wGzuSztl9mkf7VDicUlSYDCChx+RLcsJHCxjtTzBvR
 OcXdZ4oOiqRjrq6mRO+0jVHj5kejfoKwB3JAwVjLfY0rzxueseCYUZnLfeZWCpoGbkYI
 pQaKkF1ww/ptsan6ssjnQm4KPP+YqPkJR6IvXB5Zg+UOmLIH/6jHQrOSqvTZeETxUQiI
 4GFw==
X-Gm-Message-State: AOJu0YypnQXaMtLgOH64XMItYl0ibLih0r5UoVGv8TXThB0pV49QbIbZ
 4RQqKkpBN5TfEEC+T426kvAyf0VQ/NfqTNaB3jrgLAIubV9LFU00NyQcH0kOUQ==
X-Gm-Gg: Acq92OF3XlILrgbK7c6qSa3KAbyqAJMq0dmxh+asvhlYeH8SW/nvyPEHXOBAIifH5JZ
 40trvi/HN9TD6r98W5e5G8UaJdvrn04v8kz01xs6Fc7iAF0DU7bXF/MKcyhHQVp+pXzTUzdPJMU
 ALh7WAd2toxMszi5lJW/aZdaIlV+1HP6lSd3eo5sWW4BuU9GIyL1FhMHi/ZWfam34QGVnc/rw7t
 l6g9BbbYOBwMO4yzdYycTSjQqi/82PXt9QUT/NWIsBqJ4tCENRttqpbsH/+V8IZDZHS/R9nED25
 pcjtlvhRXh9+c7zxztouuuoEzhTkze9FVzKVjVSIgwu3XZ8XrNIgvWnhUJwrkzxIjE1E3HP0LYc
 ECsh0OoGhWc8iBWzgX1SZf52/jJnfQ+uCzzBZ9elMrGLRsQitLKOabMnhzAsXZI4P/8lEF5Q9+R
 YJ6MN0pBxSq85+q+1LdoESTswZJZxUH37smzzIIYqIHkgqQRJUbgUeCySzF9/I5YUN
X-Received: by 2002:a05:600c:a30a:b0:48a:568f:ae8a with SMTP id
 5b1f17b1804b1-48fe5fda35fmr221801225e9.8.1779178931035; 
 Tue, 19 May 2026 01:22:11 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48feb00e5easm101575685e9.13.2026.05.19.01.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 01:22:10 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 John Olender <john.olender@gmail.com>, Liu Leo <Leo.Liu@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/5] drm/amdgpu/uvd: Fix forcing BOs into UVD segment when it
 isn't at 0
Date: Tue, 19 May 2026 10:22:03 +0200
Message-ID: <20260519082204.60811-5-timur.kristof@gmail.com>
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

UVD 4.x and older can only access FB and MSG buffers from a
specific 256M VRAM segment that the VCPU BO is also located in.
We already modify all placements of the given BO to ensure
the BO is placed within this segment.

Previously, amdgpu_uvd_force_into_uvd_segment() always assumed
that the UVD segment is the first 256M of VRAM, even though
under some conditions the VCPU BO could be allocated outside
this segment, which made UVD non-functional as the BOs were
not inside the same segment as the UVD VCPU BO.

Solve that by using the segment where the VCPU BO actually is.

This fixes an issue with UVD failing to initialize on SI/CIK
when resizable BAR is enabled and the VCPU BO is allocated
in a different segment.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/3851
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c | 36 +++++++++++++++----------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 1e59ca924abe..993957927782 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -550,16 +550,29 @@ void amdgpu_uvd_free_handles(struct amdgpu_device *adev, struct drm_file *filp)
 	}
 }
 
+/**
+ * amdgpu_uvd_force_into_uvd_segment() - Forces placement of a BO into the UVD segment
+ *
+ * @abo: buffer object whose placement is forced
+ *
+ * UVD 4.x and older can only access FB and MSG buffers from a specific 256M VRAM segment
+ * that the VCPU BO is also located in. Force the BO into that segment.
+ */
 static void amdgpu_uvd_force_into_uvd_segment(struct amdgpu_bo *abo)
 {
-	int i;
+	struct amdgpu_device *adev = amdgpu_ttm_adev(abo->tbo.bdev);
+	struct amdgpu_bo *vcpu_bo = adev->uvd.inst[0].vcpu_bo;
+	struct amdgpu_res_cursor vcpu_cur;
 
-	for (i = 0; i < abo->placement.num_placement; ++i) {
-		abo->placements[i].fpfn = 0 >> PAGE_SHIFT;
-		abo->placements[i].lpfn = (256 * 1024 * 1024) >> PAGE_SHIFT;
-		if (abo->placements[i].mem_type == TTM_PL_VRAM)
-			abo->placements[i].flags |= TTM_PL_FLAG_CONTIGUOUS;
-	}
+	amdgpu_res_first(vcpu_bo->tbo.resource, 0, amdgpu_bo_size(vcpu_bo), &vcpu_cur);
+
+	abo->placement.num_placement = 1;
+	abo->placements[0].fpfn = ALIGN_DOWN(vcpu_cur.start, SZ_256M) >> PAGE_SHIFT;
+	abo->placements[0].lpfn = abo->placements[0].fpfn + (SZ_256M >> PAGE_SHIFT);
+	abo->placements[0].mem_type = adev->uvd.inst[0].vcpu_bo->tbo.resource->mem_type;
+
+	if (abo->placements[0].mem_type == TTM_PL_VRAM)
+		abo->placements[0].flags |= TTM_PL_FLAG_CONTIGUOUS;
 }
 
 static u64 amdgpu_uvd_get_addr_from_ctx(struct amdgpu_uvd_cs_ctx *ctx)
@@ -600,13 +613,8 @@ static int amdgpu_uvd_cs_pass1(struct amdgpu_uvd_cs_ctx *ctx)
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
+			amdgpu_uvd_force_into_uvd_segment(bo);
 
 		r = ttm_bo_validate(&bo->tbo, &bo->placement, &tctx);
 	}
-- 
2.54.0


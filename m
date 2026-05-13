Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F7EACD4F3C
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 20:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AABB810F045;
	Wed, 13 May 2026 20:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D4sr2gdV";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57AC410F033
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 20:04:23 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-44b052142e1so4074260f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 13:04:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778702662; x=1779307462; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8IkyB/mMaEVvfikzlFXMKk/jtQ7ak4+kz6zZNii8DBM=;
 b=D4sr2gdVrVQl31U2Ry20/pgALa+PJI4hcmRRzGEDG5M2awY+2YyAEDp74ew8/w+VU5
 eRLy/RAJFfsdcGJHoRbi5NRYCzK/O1H33NGrBwJ4jQkLsFFhWq+qHqLfgpYLnRkNK3BF
 sYr1jhegIVBVHFdoFBWIaqWBKIuIn9UnvI2yBWhk0tUGN/YxUJjVR2Zr2mvK4RFx0kUt
 UmVD6Mr+rrgjtyEDTsXKbC38AHQK034PBoqN2LOfswEPk+LuFvcDsQgox+495HRKxfiI
 yvVve5eqt8Vi+W3vQWmDJyg3Y1DrHHA2XM92L2qsUT8Ae6ystvTj4650ya2c8KfpDxsc
 dyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778702662; x=1779307462;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8IkyB/mMaEVvfikzlFXMKk/jtQ7ak4+kz6zZNii8DBM=;
 b=Yv5RrIUBBqHUbdOnpjicJH7SZEdOnOK+/Qb8o8wokeVnWUdJ/oq89fkALMLDU2p9NK
 nSy1H4icvGDLOFvVHnRl28ewD7blz/Gj0CB5QE9UrG+Jgh101Q5AHosxkz9lQFvdzvtc
 5hRWbdi1QLwZ7HUfJiq1qK4kj0/laZMZuSWK2NCYsFVnxanPZQP8uBhqYd/YGCdpTinG
 6k70slqs6FMiud6TgpuGJDuigPgBa+Cy7H+z0ds1EW7AJ7TovOT9l7AltRoGTqucEzDR
 N9yDYyqkaIrziNzLhAAzrR44VIym/c+MzvHV7T5xeoZ4xAF39y56XfBGo1c4ZjXveXsN
 XARg==
X-Gm-Message-State: AOJu0YzWbxdff2jQS0KfWuISpsaWGdzAgNf550UGVzWkUqVU5WlKxc+y
 QXAd22aKin6qrLJQbsJXYWl77Yh5eQIPErfL+1UOB/U7DLiRdqqKNzQiwGe+sQ==
X-Gm-Gg: Acq92OH6Xdeln4XKHekpmqJ05f7ecD4uF8GfiaOQBQGsxFEXEfjSBcBjE1ONjENUKAd
 2Uchrd7+po/BRrmUuvBtsqXIT48YXcXMilkKH8moeMTYtxaU1tZ21Xq/y0kbDKW0qFh/s48/7XT
 4U3tOAsQyuU4FR1GEX6CWi8QoPOrN/mnBfNNX7TBsDCs6djZIzFKbjSuaZ+0Un1BrtNE77/Xihx
 ds0VrYH4h+7i2aF1zuPG4FVKoksfYpmJxLkqJvkiPIcGQFTzVWkkJk5BPbvSqTQVFiQg2QXtsiT
 dAiZAB0ulPZWZxUr1fl3dQXqeCnh683QZXT6RsyzYm28Oo4fVdiuhpfUInQGYryti70UcyHLLQI
 njRGRfniELpKk6eeJi6JpdlI+rY4XZ05hBoibBwLNO/3b3oZZpXEa7plEBJ8LYxw5NQOftNkzWN
 afumfCkOLGVOosQgxxIK9mrGAGTXW4YJqv4BmON5jwK/83/NNgA2XK+TfKQosWgpm5
X-Received: by 2002:a05:6000:228a:b0:43d:242:b9bb with SMTP id
 ffacd0b85a97d-45c57bf9bf3mr7777164f8f.18.1778702661658; 
 Wed, 13 May 2026 13:04:21 -0700 (PDT)
Received: from Timur-Hyperion.home (540017BE.dsl.pool.telekom.hu.
 [84.0.23.190]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768c4fsm1257463f8f.8.2026.05.13.13.04.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 13:04:21 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/9] drm/amdgpu/vce1: Remove superfluous address check
Date: Wed, 13 May 2026 22:04:10 +0200
Message-ID: <20260513200416.35631-4-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260513200416.35631-1-timur.kristof@gmail.com>
References: <20260513200416.35631-1-timur.kristof@gmail.com>
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

The same thing is already checked a few lines above.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index edabec442cb6..884f24be3685 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
@@ -557,8 +557,6 @@ static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
 	amdgpu_gart_map_vram_range(adev, pa, adev->vce.gart_node.start,
 				   num_pages, flags, adev->gart.ptr);
 	adev->vce.gpu_addr = adev->gmc.gart_start + vce_gart_start_offs;
-	if (adev->vce.gpu_addr > max_vcpu_bo_addr)
-		return -EINVAL;
 
 	return 0;
 }
-- 
2.54.0


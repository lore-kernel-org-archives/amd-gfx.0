Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55200F36C5C
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 12:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1DC510E558;
	Mon, 20 Apr 2026 12:10:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jopC17d1";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6642E10E55F
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 12:10:53 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4891f625344so7814685e9.0
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 05:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776687052; x=1777291852; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T/ooPd5R/xhU8SoPLA7e7oCp+4dtrJ+bp2vzetAx2L4=;
 b=jopC17d1J0uWagmceQiOuRw55oAcnBbJBveUI6xyyLCve5wFO6nDZFigqNdX3p4iqC
 wvE1C9oEMX6v3wHMpDr5KkOnnNuFjXxzzXf6LbNg/D2CVIpwZaIDqfi41tp9c/X62Ozj
 94L+acj4traWDI7wT4gRk52u9ZrOj+M8r6+Jtfp6vsDB52gIYaTW1YicW8yCoDdyXDeH
 maKNf2M1PLXTnBGMonWz2zpC3QNRcK09MWckSsCNdsDxO1/v3UtXo6ZnGbz1xe1DpI/S
 4mJv0+zHCwc7N/9kYssuntWdp+ANzOLUMJbjJfuha7qg+yTpMqnqcRYOKPFT7vFwpbyp
 7Nog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776687052; x=1777291852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=T/ooPd5R/xhU8SoPLA7e7oCp+4dtrJ+bp2vzetAx2L4=;
 b=CVHSwoTpH91x7AxplInNaJ5uIWFAXSHiIjaJH57EjLhb6rLk3OGTEPJAeTeGsIbBVe
 XbpTUdJ6Pothfyivlszqd2DAcpYcYTLLovvkqtPIOjjbqU2G/i6MUQ7x1p5LW15u40Qr
 wYfPFPQKm7MwsMaEeX4I6Zm9zbutSVSgnd87nfxgnk7EVCrHzggobbalRa1MwInHiJ9z
 9yZSMcKbuH1kjvPn/A+MEIsruuvH+4E6cXXV8GA7txlhcTLh6ddVCkbPfM+ZR9DaXG/q
 jAwfR6rYIXzRVbJO6W3VQj0laYK31k/BRecERMmT+JbYfvUjg/VaHkoEL3Kn4xFkdboF
 d+Og==
X-Gm-Message-State: AOJu0YxAuuz40i4sZIq3iH+8tsWRGJCdZHd0GgbmglWrrsfFPD+scGbY
 zeozQ9feOG0Nog+vhosiFvSYpxrraQW288qnhbipIBb0gBMr6iM2c0t5AEtPDQ==
X-Gm-Gg: AeBDies5TXUcoz4KAfvUlYF++QnvfljKtNaWpKSDD4lr4A/MNUDmG1yfZEgT3qWAbPo
 SJTy+FO4LAOmjrJtrRRJAGLzPX9UCqGPLVQ1004Fl7z5MlSDmBb4zl1qCY/RP9Jb5GYg6HZI+M2
 zm5l++UfUvi/+K6epjIhuGUUdMqKyDsP5HiGhKjxkMxsCbJu/IoOjxye42/MLPd/+LkXpDrvvAa
 CfKUQZZV//xdBb367CjfbglINIu03PIcbTfzcu1+ExngKxJVXgQS3ACDmpJO7AHZJQIi0+rMoxh
 PWzz5Le+yfDaLI7tuK1C29KcMNwA6GDcBS6kZLhICNBbhfcDb7tnMS5gp3ZDJF5dVKsqMnUkwTf
 JLiRpa3vayTIrn4SIvDSr6t1nVLQRawktYTvCJAGzlJt2C30GRNtS7ZXMXVR8raBOpoA7XYdlbz
 jqdcOK3J1hSh8VyzVDrac4A/vKy3uyAc9a+cJeKSCAPtixof2aaWWZmdo75x5S/R1TVIwYfNWt9
 hIUYw==
X-Received: by 2002:a05:600c:4e0c:b0:489:1d7a:4537 with SMTP id
 5b1f17b1804b1-4891d7a463emr42407285e9.3.1776687051717; 
 Mon, 20 Apr 2026 05:10:51 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb78becdsm129632265e9.5.2026.04.20.05.10.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 05:10:51 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 5/7] drm/amdgpu/vce1: Check if VRAM address is lower than GART.
Date: Mon, 20 Apr 2026 14:10:42 +0200
Message-ID: <20260420121044.155030-6-timur.kristof@gmail.com>
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

Previously, I had assumed this was not possible
so it was OK to not handle it, but now we got a report
from a user who has a board that is configured this way.

When the VCPU BO is already located in a low 32-bit address
in VRAM (eg. when VRAM is mapped to the low address space),
don't do the workaround.

Fixes: 66a80158aa2a ("amdgpu/vce: use amdgpu_gtt_mgr_alloc_entries")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index 35caef5a8102e..b7b6096c1a1fd 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
@@ -538,6 +538,9 @@ static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
 	u64 vce_gart_start_offs;
 	int r;
 
+	if (adev->gmc.vram_start < adev->gmc.gart_start)
+		return amdgpu_bo_gpu_offset(adev->vce.vcpu_bo) <= max_vcpu_bo_addr ? 0 : -EINVAL;
+
 	r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr,
 					 &adev->vce.gart_node, num_pages, 0,
 					 DRM_MM_INSERT_LOW);
-- 
2.53.0


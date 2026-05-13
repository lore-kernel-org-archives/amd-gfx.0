Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9EE5CD4F21
	for <amd-gfx@archiver.kernel.org>; Wed, 13 May 2026 20:04:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD32210F044;
	Wed, 13 May 2026 20:04:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BJckEQ07";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 21C7D10F044
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 20:04:24 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-444826c16ffso6103663f8f.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 May 2026 13:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778702663; x=1779307463; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aqh1NH51+/l9EYXrvtZeKpmFnyEYmwXIln2gyQINJKs=;
 b=BJckEQ07GZhInjMMw+0H68rEi/xAiGWalARAyCxSfl7c9hcGXIAxGQ4G/FpybL6l8i
 pniabB73pcZ7aFiMN3kl7ZXllDcRevF4kBXRsc45BgaGVJxf2IiD3Z7DfdmmpKeJSMr2
 vXFaoRCq+KUymMRoQx3ReTgUVi0MKaftEOyXf+BARdCmBUBK+jgwwr0EiCtNWWEGmIjc
 1YdsrH4etSUDkCl7oFO9qfcAsEfSP9Yr+Wl2ktJSZiqRoDYSUyCVXlLVd3CoUr4cNzTC
 zTVlTy2sfgfEY66evh7uAGKaOYANLlqkEt7oyPeutikhsQBI2/QvkXcr2myFMkbk3ihF
 ciXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778702663; x=1779307463;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aqh1NH51+/l9EYXrvtZeKpmFnyEYmwXIln2gyQINJKs=;
 b=G4+fSo2jAEWUEnK84JgwEe4LmurfQnw1MuqgkJOFP06NSLv/De6kMGzxnMkCFIY8SP
 lWy3eRftAzhM2Q4eBLevD0d/wFTqhQCjDsNjefK2CjIemRBmTRGZ5SkfRIPiCrW/oHIm
 WnXRWAh8hPTpDY6Iw1rzSI3v/iOI4otRxxLVKQYlWiasZM8Hi2nn0qWu5SY9HR+16Jb4
 DMVe50kRACKOtuXT72I7VpwQY9vMEJs2cn8ziigBdV+DMlJpdqU/z9yvb8i3zTdVY6TR
 ml8OdplP2Z/SMKWK9naUKGMxsD2vldPhFqWYntsXxXEqkWB8Nv1/Ec1SEKdkK2QkdQ6G
 o6Ww==
X-Gm-Message-State: AOJu0YyeJNhn8tyHuzPWWlOV28RLcnbEcqG7SVNnDCP7gINXL5+emeDN
 fAvjEK+8w/HGJO/tQ4yYJFSIRF7Ejt9RCnIDIGo6y8XV2pUPrTDOgIsDumQE+A==
X-Gm-Gg: Acq92OEmrgkYmAMiVMLcGuP5gUrzLVM0jKiNrJRNBx+2NPwFv8TZDlUQ35dlS04MrA5
 l4f8vJfRjzsRqTiooTw1mQYEQVryiJFg8Nc9DrZP8/8xnPZAKlXPb75eExUtd00sOx92+amQW8W
 lMbOtHGUVmkUvO/ql5niFm0t4FtlnAKxB3Qv7FZLU/Z4Ro4pk8tSxD1IrwIReprhvM18UY+bQv/
 aCt88jHA7d+2dJ3NVIhrcz3oE8KV45rIHlFdb4DUrWAb9ggNpRCPccUUZLpZX8ATkU52bskPIVH
 amU8u76cX/Pi0OS3vf8JjNoYjzWRyTmnjjPCO5YS/DJLRHFuekFnknCV4P2zzu/ujX+ocC4Z8TQ
 3fJyJZeAb3vOpym7lPaKvYRwJxg4TAvN6gaet2zCagrNwYsTdhD0TMEPA6P6+Log1KXmaKNaUtw
 CZc6vVFCMn9zmh7+BK3bonNXR2WKu7GLvB7CCMOxKF9uZKcevM3IaFkMXscXT8UYpmY/x6cfKy9
 LE=
X-Received: by 2002:a05:6000:1789:b0:44a:47a4:ce91 with SMTP id
 ffacd0b85a97d-45c5a0b17b3mr7450422f8f.25.1778702662603; 
 Wed, 13 May 2026 13:04:22 -0700 (PDT)
Received: from Timur-Hyperion.home (540017BE.dsl.pool.telekom.hu.
 [84.0.23.190]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45d9e768c4fsm1257463f8f.8.2026.05.13.13.04.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 13:04:22 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 4/9] drm/amdgpu/vce1: Check if VRAM address is lower than GART.
Date: Wed, 13 May 2026 22:04:11 +0200
Message-ID: <20260513200416.35631-5-timur.kristof@gmail.com>
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

Previously, I had assumed this was not possible
so it was OK to not handle it, but now we got a report
from a user who has a board that is configured this way.

When the VCPU BO is already located in a low 32-bit address
in VRAM (eg. when VRAM is mapped to the low address space),
don't do the workaround.

Fixes: 66a80158aa2a ("amdgpu/vce: use amdgpu_gtt_mgr_alloc_entries")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index 884f24be3685..a49f11be74b2 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
@@ -542,6 +542,9 @@ static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
 	u64 vce_gart_start_offs;
 	int r;
 
+	if (adev->gmc.vram_start < adev->gmc.gart_start)
+		return amdgpu_bo_gpu_offset(adev->vce.vcpu_bo) <= max_vcpu_bo_addr ? 0 : -EINVAL;
+
 	r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr,
 					 &adev->vce.gart_node, num_pages,
 					 DRM_MM_INSERT_LOW);
-- 
2.54.0


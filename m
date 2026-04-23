Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48972FAD3E6
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Apr 2026 01:16:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D061C10EACE;
	Thu, 23 Apr 2026 01:16:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LpqtTYVv";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AE1F210EAC8
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Apr 2026 01:16:23 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4893940bb5eso24779335e9.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 18:16:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776906982; x=1777511782; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/olT4xy7uDewa/pktHMfAL2GH7aABt3Ir30/K0msN9c=;
 b=LpqtTYVv33KvvbdzjXsKlmjeuHjuM66I7GTKKhUNJ6ZpB+vBK4C7NsiA8RwXa0Y678
 Y8Y9HAUtXe8EAHgZXrK2eOfGuZOvFSPpZ1a8EG1DD+bNPzAv4hLVQcU0lFEAbA6R4OBS
 lZOPMgBkyDSW4a9QfdJI6ClAtXsvvaHujufTpfsLbRQA5/k6ZTIaLc+Wm+rFDb02wypj
 Pvjb+Qjic8ZrP10+DQQi2zJCAt0OhBNxZKBiA7+TeTfEPK3su0hJ5UQ2Xtt+pkHJ2dMx
 0oSG7pw2C9ivTkSUX+DmiymBKhuz4uygO6P+DFqalzMi+VeT8EGyO8o5MjwW6JOUUqzB
 T+eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776906982; x=1777511782;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/olT4xy7uDewa/pktHMfAL2GH7aABt3Ir30/K0msN9c=;
 b=WpCsWxXv8w0FL+0MS1AiTdx8ZM2S35yd4j7YI7K5KLDSCarBwBZwkJvcaHoWFXJIYw
 3kuMIBcU3mHYm3oN7iMGZ6goKfuZ/jq4QiieTO6+nNQUYEn1T3MEj9Jz+3l3QafHxv6H
 yPdolv0Hwm/0f3Fwwt5eXaRYKCX7Pm/A6jqGxFRf8f4qdv3rAlSMccOKIpUA4K+hoM2x
 89cxycCD3KMLFf9l3EszwLIehdzMUr6pPULrMl6/l+a6/1Q3moQAeslk/44G9pkNiCDI
 rmn5Q3lBDdsM7dhwlKG5JTqN7DAwmLxLHdQHcV3+KvlKsh+rxeqBcSZdplKsuagkdsuN
 V/Yw==
X-Gm-Message-State: AOJu0YwSPUNrNOvMT0aNsyseCl0k1PFrNI461UyUy/RUOue/O2umAa6b
 vEzvCwJEOCfIvJ6zwnjwrvofy0gNqPTNx5hrU7BPwtdhmefWcyKSOpqkGJ9blw==
X-Gm-Gg: AeBDiet5JVPFa2RHwRZnAizD2EHuQin+wXb0qs2wXyhOh3C3A9e+taCRxLMOpGCSkKC
 U2SBwsItj92HY6OSoZC+FcxMFknnEXyZNGAjAPPBIBQ5kJa96fUzbFDXc6euu6Hz883idUP6kxh
 hA7+5OzL8n8B3aQWJYDYdzHcX6Hf5CULl1lvrK7fH2Qg6liMblO2kQgkAgtFJniHpgCaRoCYmeE
 8bK8nE0/U/L3zxdFneVSD03i/M9xdYEqt3isxJf8g5H21jVo8yiOPRPh1uehKpZA5Y23iCp/2Lb
 b3RgSzfnlvViev3yY0Qt0/ht5iimEiKreOpT+7non6KicHlcZu4zTrRj+8Toejki92zIamzG+gK
 YftV3T+V+O4I+1BV3WIFwHo8LoLW+WG5/u9xJm1ZCAih4Xg8trg3Qk5Sc/WYbSN9KdqGCTT+9c9
 Z207z7kYlE3iAXVgKH9WE8jFpPFYmEBpSasR/m260d/5dCHWmQqt6/LI8UpCNTDwUznBbhFHRWe
 rdzcA==
X-Received: by 2002:a05:600c:c0d3:b0:488:a916:14a8 with SMTP id
 5b1f17b1804b1-488fb74fe74mr277023635e9.10.1776906981967; 
 Wed, 22 Apr 2026 18:16:21 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a4b329542sm370664435e9.3.2026.04.22.18.16.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 18:16:21 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, John Olender <john.olender@gmail.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 05/11] drm/amdgpu/vce1: Don't repeat GTT MGR node allocation
Date: Thu, 23 Apr 2026 03:16:08 +0200
Message-ID: <20260423011614.309180-6-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423011614.309180-1-timur.kristof@gmail.com>
References: <20260423011614.309180-1-timur.kristof@gmail.com>
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
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index a49f11be74b20..92c3cf3fce4f0 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
@@ -545,11 +545,13 @@ static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
 	if (adev->gmc.vram_start < adev->gmc.gart_start)
 		return amdgpu_bo_gpu_offset(adev->vce.vcpu_bo) <= max_vcpu_bo_addr ? 0 : -EINVAL;
 
-	r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr,
-					 &adev->vce.gart_node, num_pages,
-					 DRM_MM_INSERT_LOW);
-	if (r)
-		return r;
+	if (!drm_mm_node_allocated(&adev->vce.gart_node)) {
+		r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr,
+						 &adev->vce.gart_node, num_pages,
+						 DRM_MM_INSERT_LOW);
+		if (r)
+			return r;
+	}
 
 	vce_gart_start_offs = amdgpu_gtt_node_to_byte_offset(&adev->vce.gart_node);
 
-- 
2.53.0


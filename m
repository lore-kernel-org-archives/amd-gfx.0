Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B46EF3ED74
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 12:10:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 927B710E560;
	Mon, 20 Apr 2026 12:10:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cQKVSs7E";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A18810E55B
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 12:10:55 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4852b81c73aso25311875e9.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 05:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776687054; x=1777291854; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ekZwcH8bMsEo4qoDAc+zlfyttsrIEwY/KZeBTViNpZY=;
 b=cQKVSs7ECXeottk+ZXdnci09rQI9nZLGsU+wg+ZtMknT8vCbbhU4vnde6tIic/A6CW
 YDDv5lVi9IlNSIqC1RAdLZie4zy760g+ZcCwI+zgIcet7h+23GwFIy2bZflkZRq5SYen
 wH2ajGFo+YvCcb0e6hU8dwiHNXvQz0qNzBjjy69JF7ZTUEkc/OYnJTOBeEDKBS7ZUn5u
 vigCa/3qtGWWn51KMnSWowAJKGUETe+Y2paJqbkSOQvhwiLjjvxlQA5EGAIV+AdbfDeH
 eIWHgCaBXY3uJFJFt3HhsPa83pRFWRsAA3o3HXIj4DMRkYCp16yMV2Y4iNwpgRpjHWyj
 8yrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776687054; x=1777291854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ekZwcH8bMsEo4qoDAc+zlfyttsrIEwY/KZeBTViNpZY=;
 b=FI774axfGk2xL/+XNZqvNVNdoo/h8AAEfD2kEVh+McCaEGMEUL6VaWpYZC90okUVNL
 eBct18NdTI4vw2jOW4xrWDsoZFqnJQ1dJLUDnM6pZBV0OsUuGMLDknFu7z6JD9NQvgRB
 UVECWxVdd/gJTAm8bisvwo7yXOdr7FOBMIiz3E9GLJkpqpYWsGaMO60q3GogtgqWnrWv
 TV2106b8r4qRmTuWSot1/qiFusD0xfNthvOCktOolxTmHAbtBbHScPEVqr6zxuG4zGDn
 64q1iioA3ef09uNh4tE9HMx+TPvum2VVzJJOb/aiQCWRZ+tByVu7Txb9lG5kXZVAG1vP
 mp7g==
X-Gm-Message-State: AOJu0YwMylMUQSW+MFGUbBdjGmd+qSZ3vf+iL4MMSmzZgOwrYgyXUipx
 t+7+tfIsG11HQs34wizTQ/tx5oKv2PYyDjajwE5aVy83V+l5bjyEvAQwqJKG6Q==
X-Gm-Gg: AeBDietaPNQKSS9y3toqO1tJzd0vsfvVNXEGTymko7rmLY2FcuTd9E5gpUyckWTeiZ3
 TmJx9hrTH1ZLlyXPG+CyNmA32YS95oNu4ZxlHRZv37soLSl6cnVQ3o9ylPhq+0+PY1Tg9srVz30
 KdzAiJAeDRJWgcKRBX0VJNCkIN+1vlS6l/jLIrv3n7PSKh6LRGi7dV6TPsyMjZ13wJvT6DjwYEC
 xrmiBgNcAlB+J4uqc+rbqRhIPgPbEtGSelVCHANL79l1IVwk4tG0F0awPwJpdB4wBbGHHK5YAnn
 5XqQWpJUrJrBJsGsElQ29q23zaSwwoPC6x4Wr9pK7JZ7ZoBPupl4gN5lowJCNhV8c1J6aZG5Lwl
 hgPUElS/nRIRshoDjNdxIq6IWxSz2rIIPPNjaChC4qqzGaiX8o4dGYWyAWOzt6MmBUU3x1pyg52
 +F2uIHJ3kjHyhcu1NUcVpXRrr6KbgSYVDTp3gCJwhtyZalEty27eh1/1jEt8TyBRiMyyZs8V0yd
 eXwSQ==
X-Received: by 2002:a05:600c:4707:b0:488:bfc3:efc with SMTP id
 5b1f17b1804b1-488fb6e8eb5mr188340095e9.0.1776687053488; 
 Mon, 20 Apr 2026 05:10:53 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb78becdsm129632265e9.5.2026.04.20.05.10.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 05:10:53 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 7/7] drm/amdgpu/vce1: Align VCPU BO GART address to nearest
 power of two
Date: Mon, 20 Apr 2026 14:10:44 +0200
Message-ID: <20260420121044.155030-8-timur.kristof@gmail.com>
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

VCE accesses memory, including its firmware, through a BAR.
It works slightly differently on each generation.
In case of VCE1, the start address of this BAR is zero
and we can't change it due to the firmware validation mechanism.

Align the GART address of the VCPU BO like the VRAM address,
in order to prevent it from crossing the boundaries of its BAR.

This fixes VCE1 initialization failure after suspend/resume.

Fixes: 66a80158aa2a ("amdgpu/vce: use amdgpu_gtt_mgr_alloc_entries")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index 100aa48204c77..9ddd635449873 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
@@ -527,11 +527,17 @@ static int vce_v1_0_early_init(struct amdgpu_ip_block *ip_block)
  * To accomodate that, we put GART to the LOW address range
  * and reserve some GART pages where we map the VCPU BO,
  * so that it gets a 32-bit address.
+ *
+ * VCE accesses memory, including its firmware, through a BAR.
+ * It works slightly differently on each generation.
+ * In case of VCE1, the start address of this BAR is zero
+ * and we can't change it due to the firmware validation mechanism.
  */
 static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
 {
 	u64 bo_size = amdgpu_bo_size(adev->vce.vcpu_bo);
-	u64 max_vcpu_bo_addr = 0x0fffffff - bo_size;
+	u64 aligned_size = roundup_pow_of_two(bo_size);
+	u64 max_vcpu_bo_addr = 0x0fffffff - aligned_size;
 	u64 num_pages = ALIGN(bo_size, AMDGPU_GPU_PAGE_SIZE) / AMDGPU_GPU_PAGE_SIZE;
 	u64 pa = amdgpu_gmc_vram_pa(adev, adev->vce.vcpu_bo);
 	u64 flags = AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE | AMDGPU_PTE_VALID;
@@ -543,7 +549,8 @@ static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
 
 	if (!drm_mm_node_allocated(&adev->vce.gart_node)) {
 		r = amdgpu_gtt_mgr_alloc_entries(&adev->mman.gtt_mgr,
-						 &adev->vce.gart_node, num_pages, 0,
+						 &adev->vce.gart_node, num_pages,
+						 aligned_size >> AMDGPU_GPU_PAGE_SHIFT,
 						 DRM_MM_INSERT_LOW);
 		if (r)
 			return r;
-- 
2.53.0


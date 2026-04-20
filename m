Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F308AF36C58
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Apr 2026 12:10:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8635F10E55C;
	Mon, 20 Apr 2026 12:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cA0K7l/t";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B221B10E558
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 12:10:51 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-483487335c2so29348545e9.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Apr 2026 05:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776687050; x=1777291850; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zADEzF1oi8dkW6oojmPKs0+/KoXQ1h0TZQYTFyFwkLM=;
 b=cA0K7l/tyLTad04gmHIi41Srrg6S7njZKT3GC6G/095/Tw+Z5UmZdPnURVWnzgpiP+
 7TYxoODrjKOBOp2OUIT1wz84gD5A2rVluDnVuzrd/2A5Nqq1yJnXdlGYGayU26H1J0aR
 6lrpAwsxlZrtfQjJ+dBoHNkwwYiXslR+hRLC1VQmr6LltD+A+4GTwe4iZ380JrNlR9Mp
 BP+vto4dTGOUSNhHmqy0ULTS1IJJPjypOr4eHt20BMjfrQTH5lGnDq7XXc/YdNAaXy26
 yvr+/+mBuOAhVryXH/mEQ9mq5Kd6cNRbmM8JDTIPObPUr9SDAatGeC8RKZAP78G0DMUx
 t1qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776687050; x=1777291850;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zADEzF1oi8dkW6oojmPKs0+/KoXQ1h0TZQYTFyFwkLM=;
 b=fgtu7kK+iwqYwb6ja9n7TIb1UGteZtuosTgDbM/elEtBjUDP2LZQibJtCv68o3t3Dv
 6gl47YlpkVCooHC4K11okxsAQjmNX1LsVtQWSD8AFXKDJq//1i14P64w0EEy5TuTrZ8/
 XqZ+yimhTAweYqXPzHHDuYZGOuPKdDMooskUuMlrFSKREEKue6XUF1WvKaJwlbjyaRmI
 bHzcIsMuxtn8x78kbCJc91gHS3rX8QCwmb8W+U1+rr/u5ozNkLNFZXUuy+LOF4j1HXbl
 knKsLpOpmpLk464AP2sIqC78Th/iwpH3WG1zmPb5zfL4l2ZFGcGJiLpzYDenEdk293Xd
 kt+Q==
X-Gm-Message-State: AOJu0YzvuFD7OzO8XieYAyhT3WLNDQkdSJiy0/tpV5rSMDit1DWDIJPX
 AXaRyzDe6EYurdg5TGqiyrplorGOpElNksRMyDW/mhjjm1AReYlvf9nYx6pcjA==
X-Gm-Gg: AeBDietnidvbgFWvg/Rb0jTxSnkm9JWpLQ7aldpU1mjb4HedRnAwiN9pP+oYXbs5aO/
 xIANauS7dh9f1leDQNS1IyPx4GDQtFBPKuAaxpMvDOgPVzt+gI1BQtRVVKvP2515r+xWHa3XaB9
 is2p1GFkb77Km8FArbe1z4QMk63gL2/NtR57OvKPLzrrkP7ZUQmUWCtb5Ba28bdbSWGRQ4qiOyw
 JYzObxklYw4mFndnjnSztLlBI2WGLx2Lx0ZTsYpemX3hSQqFFo+jh16U1IWk3RwC644nx1B8Pee
 RDyWvm9PMv8QdFChZ7mKcIl7fEfRpibwhFKZHbzTR8/ZXymHBs9HBTo81YaOtRWtf6LjmdAgrVJ
 QnPNwCPBZ1crWUci+D9LYPlivypZ4TwhZSyNg5OdtnbYmeJ8QGYi46XO9tPCXVYxmYpdHH5orIi
 N2/ENPJpbMY1pEmzhEkboRmV3sw/vInZkFwUI6RQ4YsbID/wbV7ifBHfVutnpXFimGXgh3+Ie15
 lh3PA==
X-Received: by 2002:a05:600c:8284:b0:489:1f3e:5f69 with SMTP id
 5b1f17b1804b1-4891f3e629bmr34150865e9.18.1776687050142; 
 Mon, 20 Apr 2026 05:10:50 -0700 (PDT)
Received: from Timur-Hyperion.home (5E1B98A2.dsl.pool.telekom.hu.
 [94.27.152.162]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb78becdsm129632265e9.5.2026.04.20.05.10.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 05:10:49 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com,
 christian.koenig@amd.com
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 3/7] drm/amdgpu/vce1: Correct firmware offset mask
Date: Mon, 20 Apr 2026 14:10:40 +0200
Message-ID: <20260420121044.155030-4-timur.kristof@gmail.com>
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

It's 0x0fffffff and not 0x7fffffff.

Fixes: d4a640d4b9f3 ("drm/amdgpu/vce1: Implement VCE1 IP block (v2)")
Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
index 2fe931366985a..ce993b57b0e9f 100644
--- a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
@@ -313,17 +313,17 @@ static int vce_v1_0_mc_resume(struct amdgpu_device *adev)
 
 	offset =  adev->vce.gpu_addr + AMDGPU_VCE_FIRMWARE_OFFSET;
 	size = VCE_V1_0_FW_SIZE;
-	WREG32(mmVCE_VCPU_CACHE_OFFSET0, offset & 0x7fffffff);
+	WREG32(mmVCE_VCPU_CACHE_OFFSET0, offset & 0x0fffffff);
 	WREG32(mmVCE_VCPU_CACHE_SIZE0, size);
 
 	offset += size;
 	size = VCE_V1_0_STACK_SIZE;
-	WREG32(mmVCE_VCPU_CACHE_OFFSET1, offset & 0x7fffffff);
+	WREG32(mmVCE_VCPU_CACHE_OFFSET1, offset & 0x0fffffff);
 	WREG32(mmVCE_VCPU_CACHE_SIZE1, size);
 
 	offset += size;
 	size = VCE_V1_0_DATA_SIZE;
-	WREG32(mmVCE_VCPU_CACHE_OFFSET2, offset & 0x7fffffff);
+	WREG32(mmVCE_VCPU_CACHE_OFFSET2, offset & 0x0fffffff);
 	WREG32(mmVCE_VCPU_CACHE_SIZE2, size);
 
 	WREG32_P(mmVCE_LMI_CTRL2, 0x0, ~0x100);
@@ -531,7 +531,7 @@ static int vce_v1_0_early_init(struct amdgpu_ip_block *ip_block)
 static int vce_v1_0_ensure_vcpu_bo_32bit_addr(struct amdgpu_device *adev)
 {
 	u64 bo_size = amdgpu_bo_size(adev->vce.vcpu_bo);
-	u64 max_vcpu_bo_addr = 0xffffffff - bo_size;
+	u64 max_vcpu_bo_addr = 0x0fffffff - bo_size;
 	u64 num_pages = ALIGN(bo_size, AMDGPU_GPU_PAGE_SIZE) / AMDGPU_GPU_PAGE_SIZE;
 	u64 pa = amdgpu_gmc_vram_pa(adev, adev->vce.vcpu_bo);
 	u64 flags = AMDGPU_PTE_READABLE | AMDGPU_PTE_WRITEABLE | AMDGPU_PTE_VALID;
-- 
2.53.0


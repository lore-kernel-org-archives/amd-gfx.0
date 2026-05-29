Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4C1CD6E51
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 11:40:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B2C710FDC6;
	Fri, 29 May 2026 11:40:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RACB5YmL";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF97510FDC5
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 11:40:38 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-45e6a4d0be0so6278752f8f.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 04:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780054837; x=1780659637; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=qVvZ3XgNdk5/074k26JILwNFGairjcBMdWacAlGeZNI=;
 b=RACB5YmLhfjwl9NHuaY7wePu92R3CTzG1JMywE2G+JvcLz3TKoc+hBHuK5V53VM/J5
 8QT7emvWC9LkD9BXyn2Vqie8N4ducwiiFGor2Oow416tE4J31osq2Cah8qtC/5degVA8
 7j4qc+wyFwO2Abw1RUWc3VhJPzjafLbf2g9lLUrpxl9tvLl7ayu6bfKqu1COHVpMvz0h
 0xtyrPtJqgzufXiE1l+U1bse25928AxuCpj92oc96J9HvlwEpqwXMO297vuVsrwFJuWC
 W/0aZOc+KiauL/3tZ+M/yvf1WGWeQjCdsJeqW46vW6D3DCcXzwpfYkdo4UC9234AAox1
 a/pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780054837; x=1780659637;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qVvZ3XgNdk5/074k26JILwNFGairjcBMdWacAlGeZNI=;
 b=LyopAmn6C3u2ONeZdCTK30jtHTIO4oQwvT0qlIBesr7a2kT9meqigE754bimUnxQjC
 KBr+bqz277o+ECmNnGLj4gh+Z4qDfBu61nApUVzjGPk7O1x+bYb1GtxsDp562dXJE+JI
 IiASRpBsqID4gz/X8Z/FZ+eGqgS9Rtz6Jz9pfnK0Sev0xr9oiqgoDbn5RtYmm5zGaquY
 rLx8fLNMlbq8dXWpEIYKLhh7FFqPl2WvSnYXQHLGRGns7lKnJHsXifsnfYQWUlQ7PJEw
 jv+SjmgNO1GKEj7T9JwRgLlaC/A1qMG7NuXjge3zFdcILgUJtW9CeeAjqVH4un7eubEy
 aysw==
X-Gm-Message-State: AOJu0Yxi/iauzil0tp4UBpDp+7tjQi6HtzY2yqkJ3bJTZpSj0bMuleNm
 8FzGqvmxcBYskl203e/7/5UQleRDJ09fpJ2dzIS8Oc7xMGgc3KotLEEG
X-Gm-Gg: Acq92OE8MZ6OvP7qTauGwxqv3FiUCkS9+3mkKRbgddet86hY5DIHTPs89xowTMZJCNy
 nlERHQR8OIBdbI5yyVnriYmhTNulUUnGJn3Eu78tN4prwfYNBjZOriVdttAdiSAHLmkwO4hBQmS
 k5ZGafcMlXi31+ymyAV1pj7wu0XBxKueFMBzvLbZwbYmEAsihIJp8hsjXWTRZBGdthP83RkjqzB
 3ZJESZDpP89/xBNIp5M7d32htZ27tccO18sbLDREDiEUxrS154Bh2XZbbmLpEGCCCianMx2DAOe
 FtNGtgjO1bPVcE9a2cU6xDm4hCkwgP0rZVE/5TcEA//s5X8O4BN5mBgMu8aWhDrl2JibWteAM1j
 A4/FM4YLlsQn4Jao9qFhOCzuF4nsGOTWGjejDVj9JVLz3D7dDnvYmts6nyLZlSHuEubnW3rRBH8
 Jbw4Niun/WdS6uD0srLZMaAwrQb0d3dnEaoTzf7cf4NcA=
X-Received: by 2002:a05:6000:481e:b0:456:b23d:e57 with SMTP id
 ffacd0b85a97d-45ef139611fmr4851900f8f.0.1780054837273; 
 Fri, 29 May 2026 04:40:37 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1544:8100:da55:fa26:bd:a26])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cf0dsm2993109f8f.17.2026.05.29.04.40.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:40:36 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/13] drm/amdgpu: add gfp_flags to amdgpu_sa_manager
Date: Fri, 29 May 2026 13:24:05 +0200
Message-ID: <20260529114031.3714-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260529114031.3714-1-christian.koenig@amd.com>
References: <20260529114031.3714-1-christian.koenig@amd.com>
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
Reply-To: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Make sure that we use the emmergency reserves for unrecoverable page
faults and GPU resets.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 23 ++++++++++++++++++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c | 18 ++++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h |  3 ++-
 3 files changed, 34 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 334f95f8f339..60e4c3985029 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -356,16 +356,33 @@ int amdgpu_ib_pool_init(struct amdgpu_device *adev)
 		[AMDGPU_IB_POOL_IMMEDIATE] = SZ_128K,
 		[AMDGPU_IB_POOL_DIRECT] = SZ_512K
 	};
+	const gfp_t gfp_flags[AMDGPU_IB_POOL_MAX] = {
+		/*
+		 * For normal page table updates and recoverable page faults,
+		 * further restricted by the VM eviction lock to not wait for
+		 * memory reclaim.
+		 */
+		[AMDGPU_IB_POOL_DELAYED] = GFP_KERNEL,
+		/*
+		 * For redirecting unrecoverable page faults to the dummy page
+		 * or set the PRT bits. dma_fence submissions might depend on
+		 * that so we need the emmergency resewrves.
+		 */
+		[AMDGPU_IB_POOL_IMMEDIATE] = GFP_ATOMIC,
+		/*
+		 * For IB tests during GPU resets. Only very small and temporary
+		 * allocation to make allow dma_fences to signal.
+		 */
+		[AMDGPU_IB_POOL_DIRECT] = GFP_ATOMIC
+	};
 	int r, i;
 
 	if (adev->ib_pool_ready)
 		return 0;
 
-
 	for (i = 0; i < AMDGPU_IB_POOL_MAX; i++) {
 		r = amdgpu_sa_bo_manager_init(adev, &adev->ib_pools[i],
-					      sizes[i], 256,
-					      AMDGPU_GEM_DOMAIN_GTT);
+					      sizes[i], gfp_flags[i]);
 		if (r)
 			goto error;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
index 39070b2a4c04..74124f80601e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.c
@@ -46,11 +46,13 @@
 
 int amdgpu_sa_bo_manager_init(struct amdgpu_device *adev,
 			      struct amdgpu_sa_manager *sa_manager,
-			      unsigned int size, u32 suballoc_align, u32 domain)
+			      unsigned int size, gfp_t gfp_flags)
 {
 	int r;
 
-	r = amdgpu_bo_create_kernel(adev, size, AMDGPU_GPU_PAGE_SIZE, domain,
+	sa_manager->gfp_flags = gfp_flags;
+	r = amdgpu_bo_create_kernel(adev, size, AMDGPU_GPU_PAGE_SIZE,
+				    AMDGPU_GEM_DOMAIN_GTT,
 				    &sa_manager->bo, &sa_manager->gpu_addr,
 				    &sa_manager->cpu_ptr);
 	if (r) {
@@ -59,7 +61,8 @@ int amdgpu_sa_bo_manager_init(struct amdgpu_device *adev,
 	}
 
 	memset(sa_manager->cpu_ptr, 0, size);
-	drm_suballoc_manager_init(&sa_manager->base, size, suballoc_align);
+	drm_suballoc_manager_init(&sa_manager->base, size, 256);
+
 	return r;
 }
 
@@ -73,7 +76,8 @@ void amdgpu_sa_bo_manager_fini(struct amdgpu_device *adev,
 
 	drm_suballoc_manager_fini(&sa_manager->base);
 
-	amdgpu_bo_free_kernel(&sa_manager->bo, &sa_manager->gpu_addr, &sa_manager->cpu_ptr);
+	amdgpu_bo_free_kernel(&sa_manager->bo, &sa_manager->gpu_addr,
+			      &sa_manager->cpu_ptr);
 }
 
 int amdgpu_sa_bo_new(struct amdgpu_sa_manager *sa_manager,
@@ -81,7 +85,8 @@ int amdgpu_sa_bo_new(struct amdgpu_sa_manager *sa_manager,
 		     unsigned int size)
 {
 	struct drm_suballoc *sa = drm_suballoc_new(&sa_manager->base, size,
-						   GFP_KERNEL, false, 0);
+						   sa_manager->gfp_flags,
+						   false, 0);
 
 	if (IS_ERR(sa)) {
 		*sa_bo = NULL;
@@ -110,6 +115,7 @@ void amdgpu_sa_bo_dump_debug_info(struct amdgpu_sa_manager *sa_manager,
 {
 	struct drm_printer p = drm_seq_file_printer(m);
 
-	drm_suballoc_dump_debug_info(&sa_manager->base, &p, sa_manager->gpu_addr);
+	drm_suballoc_dump_debug_info(&sa_manager->base, &p,
+				     sa_manager->gpu_addr);
 }
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h
index 8c85c80fc119..1d1c89348709 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h
@@ -35,6 +35,7 @@ struct amdgpu_sa_manager {
 	struct amdgpu_bo		*bo;
 	uint64_t			gpu_addr;
 	void				*cpu_ptr;
+	gfp_t				gfp_flags;
 };
 
 static inline struct amdgpu_sa_manager *
@@ -57,7 +58,7 @@ static inline void *amdgpu_sa_bo_cpu_addr(struct drm_suballoc *sa_bo)
 
 int amdgpu_sa_bo_manager_init(struct amdgpu_device *adev,
 			      struct amdgpu_sa_manager *sa_manager,
-			      unsigned size, u32 align, u32 domain);
+			      unsigned size, gfp_t gfp_flags);
 void amdgpu_sa_bo_manager_fini(struct amdgpu_device *adev,
 			       struct amdgpu_sa_manager *sa_manager);
 int amdgpu_sa_bo_manager_start(struct amdgpu_device *adev,
-- 
2.43.0


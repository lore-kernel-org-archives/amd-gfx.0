Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D7B2CD6E4A
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 11:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC13B10FDC3;
	Fri, 29 May 2026 11:40:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="chRD/6sI";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E73A410FDC3
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 11:40:36 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-45e6a4d0be0so6278732f8f.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 04:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780054835; x=1780659635; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=PNbTbLC1APRr8qwhvB+s/0WrkRrbGqNL71iSvVySQDE=;
 b=chRD/6sIiX5f+uSCedEE03Lh9nJeN6romcIbpROmFY85TwyQyPPEJ4L51ubv7v7wzU
 6+TPwzNNd4eUgQcpZsqAlaIl0KvmeqEjaEn3YbWAxUNJa61vmIJCVdahLsbK85ENabZC
 5pyD+MSm61Xb2/sRMqop+qJIDc4rAzhRmQEL1UFjbc/SMcsXCmF3HawawyjogyjyRa10
 c9F4m+xb4TkxHEm4dDsG1a2AOcummzerfq2dATYrtkPKxNu4nXB5GziXuVvdg6Ufoayh
 6v0z/lMqGbscRUlsVOLr2/skFrY3xc3c2kyxOXf6mw8Z+f1np7BgdRMAxXe16cc7PuPu
 ivlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780054835; x=1780659635;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PNbTbLC1APRr8qwhvB+s/0WrkRrbGqNL71iSvVySQDE=;
 b=KzXrrHYgjRIbLaKWOES3fYFxhFKvbSvU4x1fDi5MFm4EVnj0cmfFvPMXjrTE22JWqV
 q0FbwcUQ8SJ/3+NJ4szKPNKWiMYooW+ewcjSJseWXyXgmPhyJLFjLLrbpsNDyBQbBKji
 Nay0uVi67TH2VZDol2triJH/mWfOw1PJQn/y1qTupxyEtZ5OaeEMgIFghY2m0pnAeBkn
 C6lt4TADv1A1roC/06DkVko9aiDwqMjMCpAYKY/RsaVG7qpSvLawdvatB9zbfUj4ezF0
 baAduYo2TANK8ji2Z1W9POGEjR44QYePWHbV+n2RO+3Essfdgv6npK22Wkks8QpimykP
 OFig==
X-Gm-Message-State: AOJu0Yz6x/+uA4bk5AAlAeXAlNj3mul66yKzdtXdRvjnKvIjuCgt7gHp
 45IlqjnO1sdcxmG0q9u6oGcJAinKDFbWN3q2LMgRJxjdfccNOcMpgKqr
X-Gm-Gg: Acq92OEwHzTTWqUYhW0dEnjXQLyL7xtc7So2Ye2NJEC/xav5AqqQFVxjJNTgRQTiwzH
 oF4IyaIasO1cPcUBAlH96PD4hxpOu64Z+cdpgmCDb8L+KJzS41VwrsgTTIRCOYXtuo1S1wOovhz
 iMuu+OQziXWgGO46ZYoigp/lXiBBnoGQG4fYYG3G8VQttalWF/nbnIVR315scKt4ORZuHgPGLRq
 Z3L3Hdy+ASzf1MYAlQV1PdwPdnWFiYdAsIRMsHYGhKca+yEC1/OAwizUd2obfoCSx2yCtyHI3kg
 B+wCh3UquC1SPyyCRZrbKTeMIU7bNi8/0ekWAs7xMJyADlHYvnPrqMY5jTYay3d3f1Z845a4+Rx
 i1ZH0Eo0Es+dtphXJWdwk21C4X6sv163OlChbQ/QmOp4rThD4X7/k42IfVfaX0zhrQNCUYSVZAU
 GYSJJp/PI4u2ijPBEcSzi2pkrksK107COt6e7yJs0MfD0=
X-Received: by 2002:a05:6000:400d:b0:45e:f28e:a00d with SMTP id
 ffacd0b85a97d-45ef28ea0e0mr4029467f8f.16.1780054835157; 
 Fri, 29 May 2026 04:40:35 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1544:8100:da55:fa26:bd:a26])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cf0dsm2993109f8f.17.2026.05.29.04.40.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:40:34 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 01/13] drm/amdgpu: move suballoc defines into own header
Date: Fri, 29 May 2026 13:24:03 +0200
Message-ID: <20260529114031.3714-2-christian.koenig@amd.com>
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

Just some code cleanup, while at it remove outdated comment.

No functional change.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 32 +--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 40 -----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h     | 77 ++++++++++++++++++++++
 3 files changed, 78 insertions(+), 71 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5d7bfa59424a..4b6c9d9e6773 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -112,6 +112,7 @@
 #include "amdgpu_userq.h"
 #include "amdgpu_eviction_fence.h"
 #include "amdgpu_ip.h"
+#include "amdgpu_sa.h"
 #if defined(CONFIG_DRM_AMD_ISP)
 #include "amdgpu_isp.h"
 #endif
@@ -386,37 +387,6 @@ struct amdgpu_clock {
 	uint32_t max_pixel_clock;
 };
 
-/* sub-allocation manager, it has to be protected by another lock.
- * By conception this is an helper for other part of the driver
- * like the indirect buffer or semaphore, which both have their
- * locking.
- *
- * Principe is simple, we keep a list of sub allocation in offset
- * order (first entry has offset == 0, last entry has the highest
- * offset).
- *
- * When allocating new object we first check if there is room at
- * the end total_size - (last_object_offset + last_object_size) >=
- * alloc_size. If so we allocate new object there.
- *
- * When there is not enough room at the end, we start waiting for
- * each sub object until we reach object_offset+object_size >=
- * alloc_size, this object then become the sub object we return.
- *
- * Alignment can't be bigger than page size.
- *
- * Hole are not considered for allocation to keep things simple.
- * Assumption is that there won't be hole (all object on same
- * alignment).
- */
-
-struct amdgpu_sa_manager {
-	struct drm_suballoc_manager	base;
-	struct amdgpu_bo		*bo;
-	uint64_t			gpu_addr;
-	void				*cpu_ptr;
-};
-
 /*
  * IRQS.
  */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index 4d68732d6223..ff11a0903499 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -312,46 +312,6 @@ uint32_t amdgpu_bo_mem_stats_placement(struct amdgpu_bo *bo);
 uint32_t amdgpu_bo_get_preferred_domain(struct amdgpu_device *adev,
 					    uint32_t domain);
 
-/*
- * sub allocation
- */
-static inline struct amdgpu_sa_manager *
-to_amdgpu_sa_manager(struct drm_suballoc_manager *manager)
-{
-	return container_of(manager, struct amdgpu_sa_manager, base);
-}
-
-static inline uint64_t amdgpu_sa_bo_gpu_addr(struct drm_suballoc *sa_bo)
-{
-	return to_amdgpu_sa_manager(sa_bo->manager)->gpu_addr +
-		drm_suballoc_soffset(sa_bo);
-}
-
-static inline void *amdgpu_sa_bo_cpu_addr(struct drm_suballoc *sa_bo)
-{
-	return to_amdgpu_sa_manager(sa_bo->manager)->cpu_ptr +
-		drm_suballoc_soffset(sa_bo);
-}
-
-int amdgpu_sa_bo_manager_init(struct amdgpu_device *adev,
-				     struct amdgpu_sa_manager *sa_manager,
-				     unsigned size, u32 align, u32 domain);
-void amdgpu_sa_bo_manager_fini(struct amdgpu_device *adev,
-				      struct amdgpu_sa_manager *sa_manager);
-int amdgpu_sa_bo_manager_start(struct amdgpu_device *adev,
-				      struct amdgpu_sa_manager *sa_manager);
-int amdgpu_sa_bo_new(struct amdgpu_sa_manager *sa_manager,
-		     struct drm_suballoc **sa_bo,
-		     unsigned int size);
-void amdgpu_sa_bo_free(struct drm_suballoc **sa_bo,
-		       struct dma_fence *fence);
-#if defined(CONFIG_DEBUG_FS)
-void amdgpu_sa_bo_dump_debug_info(struct amdgpu_sa_manager *sa_manager,
-					 struct seq_file *m);
-u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m);
-#endif
-void amdgpu_debugfs_sa_init(struct amdgpu_device *adev);
-
 bool amdgpu_bo_support_uswc(u64 bo_flags);
 
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h
new file mode 100644
index 000000000000..8c85c80fc119
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sa.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef AMDGPU_SA_H_
+#define AMDGPU_SA_H_
+
+#include <drm/drm_suballoc.h>
+
+struct amdgpu_device;
+struct amdgpu_bo;
+
+struct amdgpu_sa_manager {
+	struct drm_suballoc_manager	base;
+	struct amdgpu_bo		*bo;
+	uint64_t			gpu_addr;
+	void				*cpu_ptr;
+};
+
+static inline struct amdgpu_sa_manager *
+to_amdgpu_sa_manager(struct drm_suballoc_manager *manager)
+{
+	return container_of(manager, struct amdgpu_sa_manager, base);
+}
+
+static inline uint64_t amdgpu_sa_bo_gpu_addr(struct drm_suballoc *sa_bo)
+{
+	return to_amdgpu_sa_manager(sa_bo->manager)->gpu_addr +
+		drm_suballoc_soffset(sa_bo);
+}
+
+static inline void *amdgpu_sa_bo_cpu_addr(struct drm_suballoc *sa_bo)
+{
+	return to_amdgpu_sa_manager(sa_bo->manager)->cpu_ptr +
+		drm_suballoc_soffset(sa_bo);
+}
+
+int amdgpu_sa_bo_manager_init(struct amdgpu_device *adev,
+			      struct amdgpu_sa_manager *sa_manager,
+			      unsigned size, u32 align, u32 domain);
+void amdgpu_sa_bo_manager_fini(struct amdgpu_device *adev,
+			       struct amdgpu_sa_manager *sa_manager);
+int amdgpu_sa_bo_manager_start(struct amdgpu_device *adev,
+			       struct amdgpu_sa_manager *sa_manager);
+int amdgpu_sa_bo_new(struct amdgpu_sa_manager *sa_manager,
+		     struct drm_suballoc **sa_bo,
+		     unsigned int size);
+void amdgpu_sa_bo_free(struct drm_suballoc **sa_bo,
+		       struct dma_fence *fence);
+#if defined(CONFIG_DEBUG_FS)
+void amdgpu_sa_bo_dump_debug_info(struct amdgpu_sa_manager *sa_manager,
+				  struct seq_file *m);
+u64 amdgpu_bo_print_info(int id, struct amdgpu_bo *bo, struct seq_file *m);
+#endif
+void amdgpu_debugfs_sa_init(struct amdgpu_device *adev);
+
+#endif
-- 
2.43.0


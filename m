Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A07FC433F5
	for <amd-gfx@archiver.kernel.org>; Thu,  3 Mar 2022 08:23:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47FA310EF16;
	Thu,  3 Mar 2022 08:23:15 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AC8810EF12
 for <amd-gfx@lists.freedesktop.org>; Thu,  3 Mar 2022 08:23:14 +0000 (UTC)
Received: by mail-ej1-x62b.google.com with SMTP id d10so8902638eje.10
 for <amd-gfx@lists.freedesktop.org>; Thu, 03 Mar 2022 00:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=W4nE1oFso7ftFXglLp451cIGt7+Fc8apLTweLbhp4nM=;
 b=BgHffmLsQ4sTEUi7dZaydc8wM7/aeDPRvHx4aIWB4LItH97lsjE/k8E6QoGmgb7scz
 W1KPHMowASyq0gJe2ceOECvybqE+BxN5saiDsaeXve/s+VreGVUWqMFAQpV0AQjcdq9k
 ypg4cvrWcHEl8lGkf5soKPLAq5xYzBlwk9qBEF6bkh2GAvipMx6OIDI/m8Pi7IvzmZwa
 I5pvCMomddXjM7ToaNe2hMbJpQ6iDgOL59S+ub2F3W9NvzcU1XG6Eyk2Ql+Mq2pJFEnm
 S4szEGmiVcBO1z7NSIMafkbvVVtmftIdzlSESlOxL4WrQnRVqj1dBIPar6XI/2BorQLG
 zM6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=W4nE1oFso7ftFXglLp451cIGt7+Fc8apLTweLbhp4nM=;
 b=LKNdOXh/gXzyjPxGJp7q6idb3NWsVAWzfY/NiTtKWj0UexXZMjJoAAyTPAcbICbjJw
 3DAxmIEp1pi4P/ZGKtHqZL+PMM+vNA4mRlpOnkiH6io9NFmAtQGIWZaaVlJPtnNvdDv3
 w5vdsT97mFqH/8z6aZcW8R9AaIoD8byf/omDAfJTBOjlYeDHFOz7lBuMyYMpfHp+Nvmz
 ikyzUeFuVOY9VaXqEb71cJ5eIo90CjatevLp94WsGW3dPRyWf6JdoyWzCmm2z101ChrN
 jm+bUzWgr3NnpsnPMW6DNihtIi9xZbxnHLR82IKghQ/jdNVdDfuSkIWb5G0GiLBhuKKB
 VwqA==
X-Gm-Message-State: AOAM530UIVM6tSNbbLaCbD9zG0Wh5ak0ltCxF82slM7k0DHKgz96FTnB
 MBM07spnQZtPvSjqMHNV0bRYf3vBUEUIHw==
X-Google-Smtp-Source: ABdhPJw3pScqE7LwFZgWZ4Ee99FMr+uXoP62U7UcSLrqBBv1dswiDOrVL9fWYNlhwAa4R4xpjp4Uyg==
X-Received: by 2002:a17:906:2ecd:b0:6d3:d7c9:8fa4 with SMTP id
 s13-20020a1709062ecd00b006d3d7c98fa4mr25662325eji.144.1646295792567; 
 Thu, 03 Mar 2022 00:23:12 -0800 (PST)
Received: from able.fritz.box (p5b0eab60.dip0.t-ipconnect.de. [91.14.171.96])
 by smtp.gmail.com with ESMTPSA id
 n4-20020a056402060400b00415a1f9a4dasm548308edv.91.2022.03.03.00.23.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Mar 2022 00:23:12 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Marek.Olsak@amd.com
Subject: [PATCH 02/10] drm/amdgpu: header cleanup
Date: Thu,  3 Mar 2022 09:23:00 +0100
Message-Id: <20220303082308.38217-3-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220303082308.38217-1-christian.koenig@amd.com>
References: <20220303082308.38217-1-christian.koenig@amd.com>
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

No function change, just move a bunch of definitions from amdgpu.h into
separate header files.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 95 -------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c        |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h        | 93 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h       |  3 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h      | 35 ++++++-
 .../gpu/drm/amd/amdgpu/amdgpu_trace_points.c  |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c       |  1 +
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         |  1 +
 drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c         |  1 +
 10 files changed, 132 insertions(+), 100 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index b89406b01694..7f447ed7a67f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -60,7 +60,6 @@
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_gem.h>
 #include <drm/drm_ioctl.h>
-#include <drm/gpu_scheduler.h>
 
 #include <kgd_kfd_interface.h>
 #include "dm_pp_interface.h"
@@ -276,9 +275,6 @@ extern int amdgpu_num_kcq;
 #define AMDGPU_SMARTSHIFT_MIN_BIAS (-100)
 
 struct amdgpu_device;
-struct amdgpu_ib;
-struct amdgpu_cs_parser;
-struct amdgpu_job;
 struct amdgpu_irq_src;
 struct amdgpu_fpriv;
 struct amdgpu_bo_va_mapping;
@@ -465,20 +461,6 @@ struct amdgpu_flip_work {
 };
 
 
-/*
- * CP & rings.
- */
-
-struct amdgpu_ib {
-	struct amdgpu_sa_bo		*sa_bo;
-	uint32_t			length_dw;
-	uint64_t			gpu_addr;
-	uint32_t			*ptr;
-	uint32_t			flags;
-};
-
-extern const struct drm_sched_backend_ops amdgpu_sched_ops;
-
 /*
  * file private structure
  */
@@ -494,79 +476,6 @@ struct amdgpu_fpriv {
 
 int amdgpu_file_to_fpriv(struct file *filp, struct amdgpu_fpriv **fpriv);
 
-int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		  unsigned size,
-		  enum amdgpu_ib_pool_type pool,
-		  struct amdgpu_ib *ib);
-void amdgpu_ib_free(struct amdgpu_device *adev, struct amdgpu_ib *ib,
-		    struct dma_fence *f);
-int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
-		       struct amdgpu_ib *ibs, struct amdgpu_job *job,
-		       struct dma_fence **f);
-int amdgpu_ib_pool_init(struct amdgpu_device *adev);
-void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
-int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
-
-/*
- * CS.
- */
-struct amdgpu_cs_chunk {
-	uint32_t		chunk_id;
-	uint32_t		length_dw;
-	void			*kdata;
-};
-
-struct amdgpu_cs_post_dep {
-	struct drm_syncobj *syncobj;
-	struct dma_fence_chain *chain;
-	u64 point;
-};
-
-struct amdgpu_cs_parser {
-	struct amdgpu_device	*adev;
-	struct drm_file		*filp;
-	struct amdgpu_ctx	*ctx;
-
-	/* chunks */
-	unsigned		nchunks;
-	struct amdgpu_cs_chunk	*chunks;
-
-	/* scheduler job object */
-	struct amdgpu_job	*job;
-	struct drm_sched_entity	*entity;
-
-	/* buffer objects */
-	struct ww_acquire_ctx		ticket;
-	struct amdgpu_bo_list		*bo_list;
-	struct amdgpu_mn		*mn;
-	struct amdgpu_bo_list_entry	vm_pd;
-	struct list_head		validated;
-	struct dma_fence		*fence;
-	uint64_t			bytes_moved_threshold;
-	uint64_t			bytes_moved_vis_threshold;
-	uint64_t			bytes_moved;
-	uint64_t			bytes_moved_vis;
-
-	/* user fence */
-	struct amdgpu_bo_list_entry	uf_entry;
-
-	unsigned			num_post_deps;
-	struct amdgpu_cs_post_dep	*post_deps;
-};
-
-static inline u32 amdgpu_get_ib_value(struct amdgpu_cs_parser *p,
-				      uint32_t ib_idx, int idx)
-{
-	return p->job->ibs[ib_idx].ptr[idx];
-}
-
-static inline void amdgpu_set_ib_value(struct amdgpu_cs_parser *p,
-				       uint32_t ib_idx, int idx,
-				       uint32_t value)
-{
-	p->job->ibs[ib_idx].ptr[idx] = value;
-}
-
 /*
  * Writeback
  */
@@ -1425,10 +1334,6 @@ static inline int amdgpu_acpi_smart_shift_update(struct drm_device *dev,
 						 enum amdgpu_ss ss_state) { return 0; }
 #endif
 
-int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
-			   uint64_t addr, struct amdgpu_bo **bo,
-			   struct amdgpu_bo_va_mapping **mapping);
-
 #if defined(CONFIG_DRM_AMD_DC)
 int amdgpu_dm_display_resume(struct amdgpu_device *adev );
 #else
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index aff77a466f59..6b6a9d925994 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -32,6 +32,7 @@
 
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_syncobj.h>
+#include "amdgpu_cs.h"
 #include "amdgpu.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_gmc.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
new file mode 100644
index 000000000000..92d07816743e
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
@@ -0,0 +1,93 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+#ifndef __AMDGPU_CS_H__
+#define __AMDGPU_CS_H__
+
+#include "amdgpu_job.h"
+#include "amdgpu_bo_list.h"
+#include "amdgpu_ring.h"
+
+struct amdgpu_bo_va_mapping;
+
+struct amdgpu_cs_chunk {
+	uint32_t		chunk_id;
+	uint32_t		length_dw;
+	void			*kdata;
+};
+
+struct amdgpu_cs_post_dep {
+	struct drm_syncobj *syncobj;
+	struct dma_fence_chain *chain;
+	u64 point;
+};
+
+struct amdgpu_cs_parser {
+	struct amdgpu_device	*adev;
+	struct drm_file		*filp;
+	struct amdgpu_ctx	*ctx;
+
+	/* chunks */
+	unsigned		nchunks;
+	struct amdgpu_cs_chunk	*chunks;
+
+	/* scheduler job object */
+	struct amdgpu_job	*job;
+	struct drm_sched_entity	*entity;
+
+	/* buffer objects */
+	struct ww_acquire_ctx		ticket;
+	struct amdgpu_bo_list		*bo_list;
+	struct amdgpu_mn		*mn;
+	struct amdgpu_bo_list_entry	vm_pd;
+	struct list_head		validated;
+	struct dma_fence		*fence;
+	uint64_t			bytes_moved_threshold;
+	uint64_t			bytes_moved_vis_threshold;
+	uint64_t			bytes_moved;
+	uint64_t			bytes_moved_vis;
+
+	/* user fence */
+	struct amdgpu_bo_list_entry	uf_entry;
+
+	unsigned			num_post_deps;
+	struct amdgpu_cs_post_dep	*post_deps;
+};
+
+static inline u32 amdgpu_get_ib_value(struct amdgpu_cs_parser *p,
+				      uint32_t ib_idx, int idx)
+{
+	return p->job->ibs[ib_idx].ptr[idx];
+}
+
+static inline void amdgpu_set_ib_value(struct amdgpu_cs_parser *p,
+				       uint32_t ib_idx, int idx,
+				       uint32_t value)
+{
+	p->job->ibs[ib_idx].ptr[idx] = value;
+}
+
+int amdgpu_cs_find_mapping(struct amdgpu_cs_parser *parser,
+			   uint64_t addr, struct amdgpu_bo **bo,
+			   struct amdgpu_bo_va_mapping **mapping);
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 9e65730193b8..6d704772ff42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -23,6 +23,9 @@
 #ifndef __AMDGPU_JOB_H__
 #define __AMDGPU_JOB_H__
 
+#include <drm/gpu_scheduler.h>
+#include "amdgpu_sync.h"
+
 /* bit set means command submit involves a preamble IB */
 #define AMDGPU_PREAMBLE_IB_PRESENT          (1 << 0)
 /* bit set means preamble IB is first presented in belonging context */
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 48365da213dc..05e789fc7a9e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -28,6 +28,13 @@
 #include <drm/gpu_scheduler.h>
 #include <drm/drm_print.h>
 
+struct amdgpu_device;
+struct amdgpu_ring;
+struct amdgpu_ib;
+struct amdgpu_cs_parser;
+struct amdgpu_job;
+struct amdgpu_vm;
+
 /* max number of rings */
 #define AMDGPU_MAX_RINGS		28
 #define AMDGPU_MAX_HWIP_RINGS		8
@@ -82,11 +89,13 @@ enum amdgpu_ib_pool_type {
 	AMDGPU_IB_POOL_MAX
 };
 
-struct amdgpu_device;
-struct amdgpu_ring;
-struct amdgpu_ib;
-struct amdgpu_cs_parser;
-struct amdgpu_job;
+struct amdgpu_ib {
+	struct amdgpu_sa_bo		*sa_bo;
+	uint32_t			length_dw;
+	uint64_t			gpu_addr;
+	uint32_t			*ptr;
+	uint32_t			flags;
+};
 
 struct amdgpu_sched {
 	u32				num_scheds;
@@ -111,6 +120,8 @@ struct amdgpu_fence_driver {
 	struct dma_fence		**fences;
 };
 
+extern const struct drm_sched_backend_ops amdgpu_sched_ops;
+
 void amdgpu_fence_driver_clear_job_fences(struct amdgpu_ring *ring);
 void amdgpu_fence_driver_force_completion(struct amdgpu_ring *ring);
 
@@ -352,4 +363,18 @@ int amdgpu_ring_test_helper(struct amdgpu_ring *ring);
 
 void amdgpu_debugfs_ring_init(struct amdgpu_device *adev,
 			      struct amdgpu_ring *ring);
+
+int amdgpu_ib_get(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		  unsigned size,
+		  enum amdgpu_ib_pool_type pool,
+		  struct amdgpu_ib *ib);
+void amdgpu_ib_free(struct amdgpu_device *adev, struct amdgpu_ib *ib,
+		    struct dma_fence *f);
+int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned num_ibs,
+		       struct amdgpu_ib *ibs, struct amdgpu_job *job,
+		       struct dma_fence **f);
+int amdgpu_ib_pool_init(struct amdgpu_device *adev);
+void amdgpu_ib_pool_fini(struct amdgpu_device *adev);
+int amdgpu_ib_ring_tests(struct amdgpu_device *adev);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c
index 57c6c39ba064..b96d885f6e33 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c
@@ -23,6 +23,7 @@
  */
 
 #include <drm/amdgpu_drm.h>
+#include "amdgpu_cs.h"
 #include "amdgpu.h"
 
 #define CREATE_TRACE_POINTS
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
index 9e102080dad9..4927c10bdc80 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_uvd.c
@@ -37,6 +37,7 @@
 #include "amdgpu.h"
 #include "amdgpu_pm.h"
 #include "amdgpu_uvd.h"
+#include "amdgpu_cs.h"
 #include "cikd.h"
 #include "uvd/uvd_4_2_d.h"
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index 344f711ad144..6179230b6c6e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -34,6 +34,7 @@
 #include "amdgpu.h"
 #include "amdgpu_pm.h"
 #include "amdgpu_vce.h"
+#include "amdgpu_cs.h"
 #include "cikd.h"
 
 /* 1 second timeout */
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index b483f03b4591..7afa660e341c 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -25,6 +25,7 @@
 
 #include "amdgpu.h"
 #include "amdgpu_uvd.h"
+#include "amdgpu_cs.h"
 #include "soc15.h"
 #include "soc15d.h"
 #include "soc15_common.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
index da11ceba0698..2bb75fdb9571 100644
--- a/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/vcn_v3_0.c
@@ -25,6 +25,7 @@
 #include "amdgpu.h"
 #include "amdgpu_vcn.h"
 #include "amdgpu_pm.h"
+#include "amdgpu_cs.h"
 #include "soc15.h"
 #include "soc15d.h"
 #include "vcn_v2_0.h"
-- 
2.25.1


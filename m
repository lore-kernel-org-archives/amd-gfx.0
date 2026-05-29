Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BA90CD6E52
	for <amd-gfx@archiver.kernel.org>; Fri, 29 May 2026 11:40:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C551A10FDCD;
	Fri, 29 May 2026 11:40:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FT64pAP0";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C2B010FDC9
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 11:40:44 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-490388fd0dbso81570275e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 May 2026 04:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780054843; x=1780659643; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=GnMp1GSTDPXdGTWJVEOChP+RS3BZG3+3IddhjYhK8wk=;
 b=FT64pAP0DO2sRtg4+oxkk9ZfrFQ8Jj86ZWE3T6hyZ5g9o0LqPvXBrvb3FqzKFwnxWo
 S31r/vx+dadeTSuP06HmWV8Qio1gE3uaFXJVIk6E2cB55/XBZKfqadegXCcrPF03XdZ0
 205kgpIjyd6HBM6qHPI5PGv5SVj8gDeXzpjLUmKliixOYfnbWNXWIaW57g88888GOREx
 B8Tq6t0gA2P1zPEmo5wtbIQMj94qV1ixN+Pd3I28uznxEX+pg+eMySGE7H5P706Vv8yd
 yuZkP/tBmkAlMarfYjCBazrs2UBYBhsfc0iMDPS4LHjkDzhmD+NCudjiY9ukigg9Wkf0
 uThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780054843; x=1780659643;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GnMp1GSTDPXdGTWJVEOChP+RS3BZG3+3IddhjYhK8wk=;
 b=Dr/mmhD1qjk4PdvFxZPIFDRNIbdDa6FoGSbhAAxklOieuHGKWJMoY/sF5E3s+6xNiZ
 r7mIwPQAOrmjQnYfLdBKp3vBCofYk/e+0lsZuIC17tsrExNlB7+LNHNETayr8+6Ymdm0
 FprswC9jfOtsUpznCT01V+EOh6IXmF831g+oDQ+Qjnx6HQh1Bdbin1UvIC2CqzCJgEv5
 qwcjMHv7G7M+nsWx2LL/UfhXuDUTF/fXclMhkqjjhK4SA4sL45vVvp49eiextahFvewV
 uxqk6+77MfCgN+LRS88fGdr4kIyxiLvOTJz0eRJkU1Asf476KDzuYbBHexMqIi3jJzcP
 7TJg==
X-Gm-Message-State: AOJu0YzPtpGlXNgWqlZpGtuzhyXVtT5Da1uUGVBKrRUvUp/vR3iU7Y96
 2UTmTXm0l3Xa/AFZ/n1FUyIt8AoG+bfHsPWJRsqliNyJj+6cf5IzwrCc
X-Gm-Gg: Acq92OHqn7zSt/bDztBduMZj2XnD9+YSQMI4p371xliJ0dt+6zXuseX/epc87XxkKs+
 ULDOa6BrjEla9DQLwS9RihQX554BtNHWt184yelwmLBwxuN+vTHd+pL5QAsdrpnV2PNG1D6CcYA
 MNY4j7Vyg0ntQLzq0+5sc8NIbCA7CgXiwAmXAOUW3t8xvg73paTuKRozKsPwiV+TtFcYAlFB3jO
 RoBW0VROzPeHsK4XctkmJs/GCRDR7SWIz+t578oiEbTvgwz8Nggrx1bLruCjlD7Dw+8qtSYTSB8
 86sVx0CfpT+/E9mto+3rZv4LvHn7YxN1XbS0hhCMo8bcV3JMKEtiLTjRLnQlt61as3nMs7nUUCe
 3EvQea+Zd7cR4bJlWKhCiQnws5UYsG5I+YUFgnVIrKA6DWe3XT5sx2xulMReR7jNY0oYUSC1cas
 /JNVDLZfsYac5aTxSIS5esHKaTPV83wysQSDidZgt9avBIaakkPOQP1g==
X-Received: by 2002:a05:600c:a105:b0:490:6e12:542c with SMTP id
 5b1f17b1804b1-4909c0e4476mr36438675e9.23.1780054843014; 
 Fri, 29 May 2026 04:40:43 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1544:8100:da55:fa26:bd:a26])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cf0dsm2993109f8f.17.2026.05.29.04.40.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 May 2026 04:40:42 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: natalie.vock@gmx.de, honghuan@amd.com, Alexander.Deucher@amd.com,
 Felix.Kuehling@amd.com, Philip.Yang@amd.com, timur.kristof@gmail.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/13] drm/amdgpu: start to move VM internals into
 amdgpu_vm_internal.h
Date: Fri, 29 May 2026 13:24:11 +0200
Message-ID: <20260529114031.3714-10-christian.koenig@amd.com>
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

Avoid exposing some defines outside of the VM code.

Co-developed by Claude Sonnet 4.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h     |   2 +
 .../gpu/drm/amd/amdgpu/amdgpu_trace_points.c  |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c        |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h        | 118 -------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c    |   1 +
 .../gpu/drm/amd/amdgpu/amdgpu_vm_internal.h   | 159 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c     |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c   |   1 +
 8 files changed, 166 insertions(+), 118 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index d13e64a69e25..d6def9bec72c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -35,6 +35,8 @@
 #define AMDGPU_JOB_GET_TIMELINE_NAME(job) \
 	 job->base.s_fence->finished.ops->get_timeline_name(&job->base.s_fence->finished)
 
+struct amdgpu_vm_update_params;
+
 TRACE_EVENT(amdgpu_device_rreg,
 	    TP_PROTO(unsigned did, uint32_t reg, uint32_t value),
 	    TP_ARGS(did, reg, value),
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c
index b96d885f6e33..fe61ed5b487e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace_points.c
@@ -25,6 +25,7 @@
 #include <drm/amdgpu_drm.h>
 #include "amdgpu_cs.h"
 #include "amdgpu.h"
+#include "amdgpu_vm_internal.h"
 
 #define CREATE_TRACE_POINTS
 #include "amdgpu_trace.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b5adfcacc55a..f81ddc6873a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -37,6 +37,7 @@
 #include <drm/drm_exec.h>
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
+#include "amdgpu_vm_internal.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_amdkfd.h"
 #include "amdgpu_gmc.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 561f2873d2ec..21c78b18f4df 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -261,80 +261,6 @@ struct amdgpu_task_info {
 	struct kref	refcount;
 };
 
-/**
- * struct amdgpu_vm_update_params
- *
- * Encapsulate some VM table update parameters to reduce
- * the number of function parameters
- *
- */
-struct amdgpu_vm_update_params {
-
-	/**
-	 * @adev: amdgpu device we do this update for
-	 */
-	struct amdgpu_device *adev;
-
-	/**
-	 * @vm: optional amdgpu_vm we do this update for
-	 */
-	struct amdgpu_vm *vm;
-
-	/**
-	 * @immediate: if changes should be made immediately
-	 */
-	bool immediate;
-
-	/**
-	 * @unlocked: true if the root BO is not locked
-	 */
-	bool unlocked;
-
-	/**
-	 * @pages_addr:
-	 *
-	 * DMA addresses to use for mapping
-	 */
-	dma_addr_t *pages_addr;
-
-	/**
-	 * @job: job to used for hw submission
-	 */
-	struct amdgpu_job *job;
-
-	/**
-	 * @num_dw_left: number of dw left for the IB
-	 */
-	unsigned int num_dw_left;
-
-	/**
-	 * @needs_flush: true whenever we need to invalidate the TLB
-	 */
-	bool needs_flush;
-
-	/**
-	 * @override_pte: true for memory that is not uncached and gmc override function is
-	 * implemented to allow MTYPE to be overridden for NUMA local memory.
-	 */
-	bool override_pte;
-
-	/**
-	 * @tlb_flush_waitlist: temporary storage for BOs until tlb_flush
-	 */
-	struct list_head tlb_flush_waitlist;
-};
-
-struct amdgpu_vm_update_funcs {
-	int (*map_table)(struct amdgpu_bo_vm *bo);
-	int (*prepare)(struct amdgpu_vm_update_params *p,
-		       struct amdgpu_sync *sync, u64 k_job_id);
-	int (*update)(struct amdgpu_vm_update_params *p,
-		      struct amdgpu_bo_vm *bo, uint64_t pe, uint64_t addr,
-		      unsigned count, uint32_t incr, uint64_t flags);
-	int (*commit)(struct amdgpu_vm_update_params *p,
-		      struct dma_fence **fence);
-};
-
 struct amdgpu_vm_fault_info {
 	/* fault address */
 	uint64_t	addr;
@@ -604,24 +530,6 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
 			  struct amdgpu_mem_stats stats[__AMDGPU_PL_NUM]);
 
-int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-		       struct amdgpu_bo_vm *vmbo);
-int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
-			int level, struct amdgpu_bo_vm **vmbo, int32_t xcp_id);
-void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm);
-
-int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
-			 struct amdgpu_vm_bo_base *entry);
-int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
-			  uint64_t start, uint64_t end,
-			  uint64_t dst, uint64_t flags);
-void amdgpu_vm_update_leaves(struct amdgpu_vm_update_params *params,
-			     uint64_t start, uint64_t end,
-			     int64_t dst, uint64_t flags);
-void amdgpu_vm_pt_free_work(struct work_struct *work);
-void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
-			    struct amdgpu_vm_update_params *params);
-
 #if defined(CONFIG_DEBUG_FS)
 void amdgpu_debugfs_vm_bo_info(struct amdgpu_vm *vm, struct seq_file *m);
 #endif
@@ -657,32 +565,6 @@ static inline uint64_t amdgpu_vm_tlb_seq(struct amdgpu_vm *vm)
 	return atomic64_read(&vm->tlb_seq);
 }
 
-/*
- * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
- * happens while holding this lock anywhere to prevent deadlocks when
- * an MMU notifier runs in reclaim-FS context.
- */
-static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
-{
-	mutex_lock(&vm->eviction_lock);
-	vm->saved_flags = memalloc_noreclaim_save();
-}
-
-static inline bool amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
-{
-	if (mutex_trylock(&vm->eviction_lock)) {
-		vm->saved_flags = memalloc_noreclaim_save();
-		return true;
-	}
-	return false;
-}
-
-static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
-{
-	memalloc_noreclaim_restore(vm->saved_flags);
-	mutex_unlock(&vm->eviction_lock);
-}
-
 void amdgpu_vm_update_fault_cache(struct amdgpu_device *adev,
 				  unsigned int pasid,
 				  uint64_t addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
index b31ff6f56f0d..d03b9bbe20c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_cpu.c
@@ -21,6 +21,7 @@
  */
 
 #include "amdgpu_vm.h"
+#include "amdgpu_vm_internal.h"
 #include "amdgpu.h"
 #include "amdgpu_reset.h"
 #include "amdgpu_object.h"
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
new file mode 100644
index 000000000000..16710017e8ca
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_internal.h
@@ -0,0 +1,159 @@
+/*
+ * Copyright 2016 Advanced Micro Devices, Inc.
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
+ * Authors: Christian König
+ */
+#ifndef __AMDGPU_VM_INTERNAL_H__
+#define __AMDGPU_VM_INTERNAL_H__
+
+#include <linux/types.h>
+#include <linux/list.h>
+#include "amdgpu_vm.h"
+
+struct amdgpu_device;
+struct amdgpu_vm;
+struct amdgpu_job;
+struct amdgpu_sync;
+struct amdgpu_bo_vm;
+struct amdgpu_vm_bo_base;
+struct dma_fence;
+
+/**
+ * struct amdgpu_vm_update_params
+ *
+ * Encapsulate some VM table update parameters to reduce
+ * the number of function parameters
+ *
+ */
+struct amdgpu_vm_update_params {
+
+	/**
+	 * @adev: amdgpu device we do this update for
+	 */
+	struct amdgpu_device *adev;
+
+	/**
+	 * @vm: optional amdgpu_vm we do this update for
+	 */
+	struct amdgpu_vm *vm;
+
+	/**
+	 * @immediate: if changes should be made immediately
+	 */
+	bool immediate;
+
+	/**
+	 * @unlocked: true if the root BO is not locked
+	 */
+	bool unlocked;
+
+	/**
+	 * @pages_addr:
+	 *
+	 * DMA addresses to use for mapping
+	 */
+	dma_addr_t *pages_addr;
+
+	/**
+	 * @job: job to used for hw submission
+	 */
+	struct amdgpu_job *job;
+
+	/**
+	 * @num_dw_left: number of dw left for the IB
+	 */
+	unsigned int num_dw_left;
+
+	/**
+	 * @needs_flush: true whenever we need to invalidate the TLB
+	 */
+	bool needs_flush;
+
+	/**
+	 * @override_pte: true for memory that is not uncached and gmc override function is
+	 * implemented to allow MTYPE to be overridden for NUMA local memory.
+	 */
+	bool override_pte;
+
+	/**
+	 * @tlb_flush_waitlist: temporary storage for BOs until tlb_flush
+	 */
+	struct list_head tlb_flush_waitlist;
+};
+
+struct amdgpu_vm_update_funcs {
+	int (*map_table)(struct amdgpu_bo_vm *bo);
+	int (*prepare)(struct amdgpu_vm_update_params *p,
+		       struct amdgpu_sync *sync, u64 k_job_id);
+	int (*update)(struct amdgpu_vm_update_params *p,
+		      struct amdgpu_bo_vm *bo, uint64_t pe, uint64_t addr,
+		      unsigned count, uint32_t incr, uint64_t flags);
+	int (*commit)(struct amdgpu_vm_update_params *p,
+		      struct dma_fence **fence);
+};
+
+int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+		       struct amdgpu_bo_vm *vmbo);
+int amdgpu_vm_pt_create(struct amdgpu_device *adev, struct amdgpu_vm *vm,
+			int level, struct amdgpu_bo_vm **vmbo,
+			int32_t xcp_id);
+void amdgpu_vm_pt_free_root(struct amdgpu_device *adev, struct amdgpu_vm *vm);
+
+int amdgpu_vm_pde_update(struct amdgpu_vm_update_params *params,
+			 struct amdgpu_vm_bo_base *entry);
+int amdgpu_vm_ptes_update(struct amdgpu_vm_update_params *params,
+			  uint64_t start, uint64_t end,
+			  uint64_t dst, uint64_t flags);
+void amdgpu_vm_update_leaves(struct amdgpu_vm_update_params *params,
+			     uint64_t start, uint64_t end,
+			     int64_t dst, uint64_t flags);
+void amdgpu_vm_pt_free_list(struct amdgpu_device *adev,
+			    struct amdgpu_vm_update_params *params);
+
+int amdgpu_vm_pt_map_tables(struct amdgpu_device *adev, struct amdgpu_vm *vm);
+
+/*
+ * vm eviction_lock can be taken in MMU notifiers. Make sure no reclaim-FS
+ * happens while holding this lock anywhere to prevent deadlocks when
+ * an MMU notifier runs in reclaim-FS context.
+ */
+static inline void amdgpu_vm_eviction_lock(struct amdgpu_vm *vm)
+{
+	mutex_lock(&vm->eviction_lock);
+	vm->saved_flags = memalloc_noreclaim_save();
+}
+
+static inline bool amdgpu_vm_eviction_trylock(struct amdgpu_vm *vm)
+{
+	if (mutex_trylock(&vm->eviction_lock)) {
+		vm->saved_flags = memalloc_noreclaim_save();
+		return true;
+	}
+	return false;
+}
+
+static inline void amdgpu_vm_eviction_unlock(struct amdgpu_vm *vm)
+{
+	memalloc_noreclaim_restore(vm->saved_flags);
+	mutex_unlock(&vm->eviction_lock);
+}
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
index ac3f3e31e2e2..f9c93a71e153 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_pt.c
@@ -26,6 +26,7 @@
 #include "amdgpu.h"
 #include "amdgpu_trace.h"
 #include "amdgpu_vm.h"
+#include "amdgpu_vm_internal.h"
 #include "amdgpu_job.h"
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
index 50cc0779c340..6acb6f08ddbf 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm_sdma.c
@@ -21,6 +21,7 @@
  */
 
 #include "amdgpu_vm.h"
+#include "amdgpu_vm_internal.h"
 #include "amdgpu_job.h"
 #include "amdgpu_object.h"
 #include "amdgpu_trace.h"
-- 
2.43.0


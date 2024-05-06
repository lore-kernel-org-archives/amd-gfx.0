Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FA2C25B5F
	for <amd-gfx@archiver.kernel.org>; Mon,  6 May 2024 17:00:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 651841122C3;
	Mon,  6 May 2024 17:00:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="aeiU4Ywl";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C71291122C2
 for <amd-gfx@lists.freedesktop.org>; Mon,  6 May 2024 17:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HgmNPOtXMH0EAWLOZlyvN54kPkRgRzR6BeICybVuWWo=; b=aeiU4YwlTooaUh4JDLjgqJ81n4
 SzkDjUOOcoj67x/exlU9ecj6xAp3Jg4FWo+rO3Zmg+ykyNFEisVQAwCZ02Gx1BWa1hlw+U04F8AXN
 w/+MBGYQe/JAwT1FBxTLNTz2omNPkf5tzLICEErM/zoPCwVkfYseCYjKBrGAkF7Tj9XnYCvNUS6IV
 L0syBzZG1Bod58raFQhhiMrUNZLmNccKYUaBhw8NZ+YzbGsCRysRLY+tz6eTYjEYvYTJhiBczeCaI
 zwVdWS4ZqaSKceoVYiwQ5Pj7ReI+dTSMmaY5hzbZ+X/cyFvrRtuEXYy0mKhstJNODxO3O+1kUEvJV
 rGPkhuzA==;
Received: from [84.69.19.168] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1s41h7-001QfS-It; Mon, 06 May 2024 19:00:05 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Rob Clark <robdclark@chromium.org>
Subject: [PATCH 5/5] drm/amdgpu: Use drm_print_memory_stats helper from fdinfo
Date: Mon,  6 May 2024 17:59:59 +0100
Message-ID: <20240506165959.50648-6-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240506165959.50648-1-tursulin@igalia.com>
References: <20240506165959.50648-1-tursulin@igalia.com>
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

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

Convert fdinfo memory stats to use the common drm_print_memory_stats
helper.

This achieves alignment with the common keys as documented in
drm-usage-stats.rst, adding specifically drm-total- key the driver was
missing until now.

Additionally I made the code stop skipping total size for objects which
currently do not have a backing store, and I added resident and active
reporting.

Legacy keys have been preserved, with the outlook of only potentially
removing only the drm-memory- when the time gets right.

The example output now looks like this:

 pos:	0
 flags:	02100002
 mnt_id:	24
 ino:	1204
 drm-driver:	amdgpu
 drm-client-id:	30
 drm-pdev:	0000:04:00.0
 pasid:	32785
 drm-total-cpu:	0
 drm-shared-cpu:	0
 drm-active-cpu:	0
 drm-resident-cpu:	0
 drm-total-gtt:	22 MiB
 drm-shared-gtt:	0
 drm-active-gtt:	10 MiB
 drm-resident-gtt:	22 MiB
 drm-total-vram:	544428 KiB
 drm-shared-vram:	13584 KiB
 drm-active-vram:	260356 KiB
 drm-resident-vram:	544428 KiB
 drm-memory-vram:	544428 KiB
 drm-memory-gtt: 	22528 KiB
 drm-memory-cpu: 	0 KiB
 amd-memory-visible-vram:	544428 KiB
 amd-evicted-vram:	0 KiB
 amd-evicted-visible-vram:	0 KiB
 amd-requested-vram:	544428 KiB
 amd-requested-visible-vram:	90112 KiB
 amd-requested-gtt:	22528 KiB
 drm-engine-gfx:	39456116802 ns

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c | 47 +++++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 94 ++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_object.h | 35 +++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c     | 20 ++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h     |  3 +-
 6 files changed, 116 insertions(+), 84 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index c7df7fa3459f..1422ea642ad0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -59,18 +59,21 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 	struct amdgpu_fpriv *fpriv = file->driver_priv;
 	struct amdgpu_vm *vm = &fpriv->vm;
 
-	struct amdgpu_mem_stats stats;
+	struct amdgpu_mem_stats stats[__AMDGPU_PL_LAST + 1] = { };
 	ktime_t usage[AMDGPU_HW_IP_NUM];
-	unsigned int hw_ip;
+	const char *pl_name[] = {
+		[TTM_PL_VRAM] = "vram",
+		[TTM_PL_TT] = "gtt",
+		[TTM_PL_SYSTEM] = "cpu",
+	};
+	unsigned int hw_ip, i;
 	int ret;
 
-	memset(&stats, 0, sizeof(stats));
-
 	ret = amdgpu_bo_reserve(vm->root.bo, false);
 	if (ret)
 		return;
 
-	amdgpu_vm_get_memory(vm, &stats);
+	amdgpu_vm_get_memory(vm, stats, ARRAY_SIZE(stats));
 	amdgpu_bo_unreserve(vm->root.bo);
 
 	amdgpu_ctx_mgr_usage(&fpriv->ctx_mgr, usage);
@@ -82,24 +85,34 @@ void amdgpu_show_fdinfo(struct drm_printer *p, struct drm_file *file)
 	 */
 
 	drm_printf(p, "pasid:\t%u\n", fpriv->vm.pasid);
-	drm_printf(p, "drm-memory-vram:\t%llu KiB\n", stats.vram/1024UL);
-	drm_printf(p, "drm-memory-gtt: \t%llu KiB\n", stats.gtt/1024UL);
-	drm_printf(p, "drm-memory-cpu: \t%llu KiB\n", stats.cpu/1024UL);
+
+	for (i = 0; i < TTM_PL_PRIV; i++)
+		drm_print_memory_stats(p,
+				       &stats[i].drm,
+				       DRM_GEM_OBJECT_RESIDENT,
+				       pl_name[i]);
+
+	/* Legacy amdgpu keys, alias to drm-total-memory-: */
+	drm_printf(p, "drm-memory-vram:\t%llu KiB\n",
+		   stats[TTM_PL_VRAM].total/1024UL);
+	drm_printf(p, "drm-memory-gtt: \t%llu KiB\n",
+		   stats[TTM_PL_TT].total/1024UL);
+	drm_printf(p, "drm-memory-cpu: \t%llu KiB\n",
+		   stats[TTM_PL_SYSTEM].total/1024UL);
+
+	/* Amdgpu specific memory accounting keys: */
 	drm_printf(p, "amd-memory-visible-vram:\t%llu KiB\n",
-		   stats.visible_vram/1024UL);
+		   stats[TTM_PL_VRAM].visible/1024UL);
 	drm_printf(p, "amd-evicted-vram:\t%llu KiB\n",
-		   stats.evicted_vram/1024UL);
+		   stats[TTM_PL_VRAM].evicted/1024UL);
 	drm_printf(p, "amd-evicted-visible-vram:\t%llu KiB\n",
-		   stats.evicted_visible_vram/1024UL);
+		   stats[TTM_PL_VRAM].evicted_visible/1024UL);
 	drm_printf(p, "amd-requested-vram:\t%llu KiB\n",
-		   stats.requested_vram/1024UL);
+		   stats[TTM_PL_VRAM].requested/1024UL);
 	drm_printf(p, "amd-requested-visible-vram:\t%llu KiB\n",
-		   stats.requested_visible_vram/1024UL);
+		   stats[TTM_PL_VRAM].requested_visible/1024UL);
 	drm_printf(p, "amd-requested-gtt:\t%llu KiB\n",
-		   stats.requested_gtt/1024UL);
-	drm_printf(p, "drm-shared-vram:\t%llu KiB\n", stats.vram_shared/1024UL);
-	drm_printf(p, "drm-shared-gtt:\t%llu KiB\n", stats.gtt_shared/1024UL);
-	drm_printf(p, "drm-shared-cpu:\t%llu KiB\n", stats.cpu_shared/1024UL);
+		   stats[TTM_PL_TT].requested/1024UL);
 
 	for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
 		if (!usage[hw_ip])
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
index fa5227a4aac2..50b7e7c0ce50 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
@@ -1286,54 +1286,84 @@ void amdgpu_bo_move_notify(struct ttm_buffer_object *bo,
 }
 
 void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
-			  struct amdgpu_mem_stats *stats)
+			  struct amdgpu_mem_stats *stats,
+			  unsigned int sz)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct ttm_resource *res = bo->tbo.resource;
+	struct drm_gem_object *obj = &bo->tbo.base;
 	uint64_t size = amdgpu_bo_size(bo);
-	struct drm_gem_object *obj;
-	bool shared;
+	unsigned int type;
 
-	/* Abort if the BO doesn't currently have a backing store */
-	if (!res)
+	if (!res) {
+		const unsigned int domain_to_pl[] = {
+			[ilog2(AMDGPU_GEM_DOMAIN_CPU)]	    = TTM_PL_SYSTEM,
+			[ilog2(AMDGPU_GEM_DOMAIN_GTT)]	    = TTM_PL_TT,
+			[ilog2(AMDGPU_GEM_DOMAIN_VRAM)]	    = TTM_PL_VRAM,
+			[ilog2(AMDGPU_GEM_DOMAIN_GDS)]	    = AMDGPU_PL_GDS,
+			[ilog2(AMDGPU_GEM_DOMAIN_GWS)]	    = AMDGPU_PL_GWS,
+			[ilog2(AMDGPU_GEM_DOMAIN_OA)]	    = AMDGPU_PL_OA,
+			[ilog2(AMDGPU_GEM_DOMAIN_DOORBELL)] = AMDGPU_PL_DOORBELL,
+		};
+		/*
+		 * If no backing store use one of the preferred domain for basic
+		 * stats. We take the MSB since that should give a reasonable
+		 * view.
+		 */
+		BUILD_BUG_ON(TTM_PL_VRAM < TTM_PL_TT ||
+			     TTM_PL_VRAM < TTM_PL_SYSTEM);
+		type = fls(bo->preferred_domains & AMDGPU_GEM_DOMAIN_MASK);
+		if (!type)
+			return;
+		type--;
+		if (type >= ARRAY_SIZE(domain_to_pl))
+			return;
+		type = domain_to_pl[type];
+	} else {
+		switch (res->mem_type) {
+		case TTM_PL_VRAM:
+		case TTM_PL_TT:
+		case TTM_PL_SYSTEM:
+			type = res->mem_type;
+			break;
+		default:
+			/* Squash into 'cpu' to keep the existing userspace view. */
+			type = TTM_PL_SYSTEM;
+			break;
+		}
+	}
+
+	if (drm_WARN_ON(&adev->ddev, type >= sz))
 		return;
 
-	obj = &bo->tbo.base;
-	shared = drm_gem_object_is_shared_for_memory_stats(obj);
+	stats[type].total += size;
+	if (drm_gem_object_is_shared_for_memory_stats(obj))
+		stats[type].drm.shared += size;
+	else
+		stats[type].drm.private += size;
 
-	switch (res->mem_type) {
-	case TTM_PL_VRAM:
-		stats->vram += size;
-		if (amdgpu_res_cpu_visible(adev, res))
-			stats->visible_vram += size;
-		if (shared)
-			stats->vram_shared += size;
-		break;
-	case TTM_PL_TT:
-		stats->gtt += size;
-		if (shared)
-			stats->gtt_shared += size;
-		break;
-	case TTM_PL_SYSTEM:
-	default:
-		stats->cpu += size;
-		if (shared)
-			stats->cpu_shared += size;
-		break;
+	if (res) {
+		stats[type].drm.resident += size;
+
+		if (!dma_resv_test_signaled(obj->resv, DMA_RESV_USAGE_BOOKKEEP))
+			stats[type].drm.active += size;
+
+		if (type == TTM_PL_VRAM && amdgpu_res_cpu_visible(adev, res))
+			stats[type].visible += size;
 	}
 
 	if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_VRAM) {
-		stats->requested_vram += size;
+		stats[TTM_PL_VRAM].requested += size;
 		if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
-			stats->requested_visible_vram += size;
+			stats[TTM_PL_VRAM].requested_visible += size;
 
-		if (res->mem_type != TTM_PL_VRAM) {
-			stats->evicted_vram += size;
+		if (type != TTM_PL_VRAM) {
+			stats[TTM_PL_VRAM].evicted += size;
 			if (bo->flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED)
-				stats->evicted_visible_vram += size;
+				stats[TTM_PL_VRAM].evicted_visible += size;
 		}
 	} else if (bo->preferred_domains & AMDGPU_GEM_DOMAIN_GTT) {
-		stats->requested_gtt += size;
+		stats[TTM_PL_TT].requested += size;
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
index bc42ccbde659..44774584a29f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
@@ -136,30 +136,14 @@ struct amdgpu_bo_vm {
 };
 
 struct amdgpu_mem_stats {
-	/* current VRAM usage, includes visible VRAM */
-	uint64_t vram;
-	/* current shared VRAM usage, includes visible VRAM */
-	uint64_t vram_shared;
-	/* current visible VRAM usage */
-	uint64_t visible_vram;
-	/* current GTT usage */
-	uint64_t gtt;
-	/* current shared GTT usage */
-	uint64_t gtt_shared;
-	/* current system memory usage */
-	uint64_t cpu;
-	/* current shared system memory usage */
-	uint64_t cpu_shared;
-	/* sum of evicted buffers, includes visible VRAM */
-	uint64_t evicted_vram;
-	/* sum of evicted buffers due to CPU access */
-	uint64_t evicted_visible_vram;
-	/* how much userspace asked for, includes vis.VRAM */
-	uint64_t requested_vram;
-	/* how much userspace asked for */
-	uint64_t requested_visible_vram;
-	/* how much userspace asked for */
-	uint64_t requested_gtt;
+	struct drm_memory_stats drm;
+
+	uint64_t total;
+	uint64_t visible;
+	uint64_t evicted;
+	uint64_t evicted_visible;
+	uint64_t requested;
+	uint64_t requested_visible;
 };
 
 static inline struct amdgpu_bo *ttm_to_amdgpu_bo(struct ttm_buffer_object *tbo)
@@ -342,7 +326,8 @@ int amdgpu_bo_sync_wait(struct amdgpu_bo *bo, void *owner, bool intr);
 u64 amdgpu_bo_gpu_offset(struct amdgpu_bo *bo);
 u64 amdgpu_bo_gpu_offset_no_check(struct amdgpu_bo *bo);
 void amdgpu_bo_get_memory(struct amdgpu_bo *bo,
-			  struct amdgpu_mem_stats *stats);
+			  struct amdgpu_mem_stats *stats,
+			  unsigned int size);
 void amdgpu_bo_add_to_shadow_list(struct amdgpu_bo_vm *vmbo);
 int amdgpu_bo_restore_shadow(struct amdgpu_bo *shadow,
 			     struct dma_fence **fence);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
index b6f53129dea3..ab95c43ff596 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
@@ -34,6 +34,7 @@
 #define AMDGPU_PL_OA		(TTM_PL_PRIV + 2)
 #define AMDGPU_PL_PREEMPT	(TTM_PL_PRIV + 3)
 #define AMDGPU_PL_DOORBELL	(TTM_PL_PRIV + 4)
+#define __AMDGPU_PL_LAST	(TTM_PL_PRIV + 4)
 
 #define AMDGPU_GTT_MAX_TRANSFER_SIZE	512
 #define AMDGPU_GTT_NUM_TRANSFER_WINDOWS	2
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 9ccb9814874c..6bddd43604bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1089,7 +1089,8 @@ int amdgpu_vm_update_range(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 }
 
 static void amdgpu_vm_bo_get_memory(struct amdgpu_bo_va *bo_va,
-				    struct amdgpu_mem_stats *stats)
+				    struct amdgpu_mem_stats *stats,
+				    unsigned int size)
 {
 	struct amdgpu_vm *vm = bo_va->base.vm;
 	struct amdgpu_bo *bo = bo_va->base.bo;
@@ -1105,34 +1106,35 @@ static void amdgpu_vm_bo_get_memory(struct amdgpu_bo_va *bo_va,
 	    !dma_resv_trylock(bo->tbo.base.resv))
 		return;
 
-	amdgpu_bo_get_memory(bo, stats);
+	amdgpu_bo_get_memory(bo, stats, size);
 	if (!amdgpu_vm_is_bo_always_valid(vm, bo))
 		dma_resv_unlock(bo->tbo.base.resv);
 }
 
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
-			  struct amdgpu_mem_stats *stats)
+			  struct amdgpu_mem_stats *stats,
+			  unsigned int size)
 {
 	struct amdgpu_bo_va *bo_va, *tmp;
 
 	spin_lock(&vm->status_lock);
 	list_for_each_entry_safe(bo_va, tmp, &vm->idle, base.vm_status)
-		amdgpu_vm_bo_get_memory(bo_va, stats);
+		amdgpu_vm_bo_get_memory(bo_va, stats, size);
 
 	list_for_each_entry_safe(bo_va, tmp, &vm->evicted, base.vm_status)
-		amdgpu_vm_bo_get_memory(bo_va, stats);
+		amdgpu_vm_bo_get_memory(bo_va, stats, size);
 
 	list_for_each_entry_safe(bo_va, tmp, &vm->relocated, base.vm_status)
-		amdgpu_vm_bo_get_memory(bo_va, stats);
+		amdgpu_vm_bo_get_memory(bo_va, stats, size);
 
 	list_for_each_entry_safe(bo_va, tmp, &vm->moved, base.vm_status)
-		amdgpu_vm_bo_get_memory(bo_va, stats);
+		amdgpu_vm_bo_get_memory(bo_va, stats, size);
 
 	list_for_each_entry_safe(bo_va, tmp, &vm->invalidated, base.vm_status)
-		amdgpu_vm_bo_get_memory(bo_va, stats);
+		amdgpu_vm_bo_get_memory(bo_va, stats, size);
 
 	list_for_each_entry_safe(bo_va, tmp, &vm->done, base.vm_status)
-		amdgpu_vm_bo_get_memory(bo_va, stats);
+		amdgpu_vm_bo_get_memory(bo_va, stats, size);
 	spin_unlock(&vm->status_lock);
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index ec688a47dec1..9759d5bdf8e2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -537,7 +537,8 @@ void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
 void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 				struct amdgpu_vm *vm);
 void amdgpu_vm_get_memory(struct amdgpu_vm *vm,
-			  struct amdgpu_mem_stats *stats);
+			  struct amdgpu_mem_stats *stats,
+			  unsigned int size);
 
 int amdgpu_vm_pt_clear(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       struct amdgpu_bo_vm *vmbo, bool immediate);
-- 
2.44.0


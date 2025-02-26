Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE10C021B8
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Feb 2025 10:10:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2C6210E160;
	Wed, 26 Feb 2025 10:10:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="cRFlNNLJ";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E91B810E178
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 10:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LIxQnr84phuNswYXzs2ydATbVM4SsfnYeBVx04isBfI=; b=cRFlNNLJBhkrEU2Jlmlo51CdOV
 H0Nqyq2QwRhaT4HAulJFcN3Cgvg7CU64mIv6H1xVdMjhkxUie+5eEi64/1vg+dvceNuH6IfFh7F93
 aVgdVuUx6BoY/0NMxobtLJTeSAwrNdKqxsl8IelStVN5NPyBbar3szhDAw2wMpE21cMat0mce/bk+
 RQZKz5nV4IDB3pZtZOeN2GH264ri+l91fcVYdgPwtYL+PRUPpDzLwo59iUOwzI3lFWyz5rRr9szoW
 NhB6iK0BmeMUl6tA5TpO7WU4Nwf72oB1Fu3GbppVsm5K2PIE9v+dHj6hCUDTJKC1tqDHakdCB/0J2
 cIfadsag==;
Received: from [90.241.98.187] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1tnEMn-000tOS-B1; Wed, 26 Feb 2025 11:10:19 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH 3/3] drm/amdgpu: Shrink struct amdgpu_job further
Date: Wed, 26 Feb 2025 10:10:15 +0000
Message-ID: <20250226101015.27117-4-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.48.0
In-Reply-To: <20250226101015.27117-1-tvrtko.ursulin@igalia.com>
References: <20250226101015.27117-1-tvrtko.ursulin@igalia.com>
MIME-Version: 1.0
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

By moving the booleans to flags and shrinking some fields we can stop
spilling job allocation into the 1k SLAB even with two appended indirect
buffers.

End result for struct amdgpu_job:

        /* size: 448, cachelines: 7, members: 24 */
        /* forced alignments: 1 */

So appending two IB buffers, which seems to be a typical case when
running a game such as Cyberpunk 2077, makes every submission perfectly
fit into the 512 byte SLAB with no wastage.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c      | 19 ++++++-----
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c      |  7 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c     | 29 +++++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |  6 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h     | 36 +++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c      | 17 +++++-----
 11 files changed, 72 insertions(+), 52 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 5cc5f59e3018..181296ea9df7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -108,13 +108,15 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
 			   struct drm_amdgpu_cs_chunk_ib *chunk_ib,
 			   unsigned int *num_ibs)
 {
+	struct amdgpu_job *job;
 	int r;
 
 	r = amdgpu_cs_job_idx(p, chunk_ib);
 	if (r < 0)
 		return r;
 
-	if (num_ibs[r] >= amdgpu_ring_max_ibs(chunk_ib->ip_type))
+	if (num_ibs[r] >= amdgpu_ring_max_ibs(chunk_ib->ip_type) ||
+	    WARN_ON_ONCE(overflows_type(num_ibs[r], typeof(job->num_ibs))))
 		return -EINVAL;
 
 	++(num_ibs[r]);
@@ -296,7 +298,8 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 				       num_ibs[i], &p->jobs[i]);
 		if (ret)
 			goto free_all_kdata;
-		p->jobs[i]->enforce_isolation = p->adev->enforce_isolation[fpriv->xcp_id];
+		if (p->adev->enforce_isolation[fpriv->xcp_id])
+			p->jobs[i]->flags |= AMDGPU_ENFORCE_ISOLATION;
 	}
 	p->gang_leader = p->jobs[p->gang_leader_idx];
 
@@ -367,7 +370,7 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 	}
 
 	if (chunk_ib->flags & AMDGPU_IB_FLAG_PREAMBLE)
-		job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT;
+		job->flags |= AMDGPU_PREAMBLE_IB_PRESENT;
 
 	r =  amdgpu_ib_get(p->adev, vm, ring->funcs->parse_cs ?
 			   chunk_ib->ib_bytes : 0,
@@ -583,8 +586,8 @@ static int amdgpu_cs_p2_shadow(struct amdgpu_cs_parser *p,
 		p->jobs[i]->shadow_va = shadow->shadow_va;
 		p->jobs[i]->csa_va = shadow->csa_va;
 		p->jobs[i]->gds_va = shadow->gds_va;
-		p->jobs[i]->init_shadow =
-			shadow->flags & AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW;
+		if (shadow->flags & AMDGPU_CS_CHUNK_CP_GFX_SHADOW_FLAGS_INIT_SHADOW)
+			p->jobs[i]->flags |= AMDGPU_INIT_SHADOW;
 	}
 
 	return 0;
@@ -1004,7 +1007,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 
 static void trace_amdgpu_cs_ibs(struct amdgpu_cs_parser *p)
 {
-	int i, j;
+	unsigned int i, j;
 
 	if (!trace_amdgpu_cs_enabled())
 		return;
@@ -1352,9 +1355,9 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 				   p->fence);
 	amdgpu_cs_post_dependencies(p);
 
-	if ((leader->preamble_status & AMDGPU_PREAMBLE_IB_PRESENT) &&
+	if ((leader->flags & AMDGPU_PREAMBLE_IB_PRESENT) &&
 	    !p->ctx->preamble_presented) {
-		leader->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT_FIRST;
+		leader->flags |= AMDGPU_PREAMBLE_IB_PRESENT_FIRST;
 		p->ctx->preamble_presented = true;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 49ca8c814455..447345cb94db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1904,7 +1904,7 @@ static void amdgpu_ib_preempt_mark_partial_job(struct amdgpu_ring *ring)
 		job = to_amdgpu_job(s_job);
 		if (preempted && (&job->hw_fence) == fence)
 			/* mark the job as preempted */
-			job->preemption_status |= AMDGPU_IB_PREEMPTED;
+			job->flags |= AMDGPU_IB_PREEMPTED;
 	}
 	spin_unlock(&sched->job_list_lock);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index 784b03abb3a4..f224547b6863 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1430,7 +1430,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	if (r)
 		goto err;
 
-	job->enforce_isolation = true;
+	job->flags |= AMDGPU_ENFORCE_ISOLATION;
 
 	ib = &job->ibs[0];
 	for (i = 0; i <= ring->funcs->align_mask; ++i)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
index 1c19a65e6553..56058f18e0ab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.c
@@ -658,7 +658,7 @@ void amdgpu_gmc_flush_gpu_tlb(struct amdgpu_device *adev, uint32_t vmid,
 		goto error_alloc;
 
 	job->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gart.bo);
-	job->vm_needs_flush = true;
+	job->flags |= AMDGPU_VM_NEEDS_FLUSH;
 	job->ibs->ptr[job->ibs->length_dw++] = ring->funcs->nop;
 	amdgpu_ring_pad_ib(ring, &job->ibs[0]);
 	fence = amdgpu_job_submit(job);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 2ea98ec60220..c6d11311dcd4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -153,7 +153,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		shadow_va = job->shadow_va;
 		csa_va = job->csa_va;
 		gds_va = job->gds_va;
-		init_shadow = job->init_shadow;
+		init_shadow = job->flags & AMDGPU_INIT_SHADOW;
 	} else {
 		vm = NULL;
 		fence_ctx = 0;
@@ -235,8 +235,9 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		status |= AMDGPU_HAVE_CTX_SWITCH;
 
 	if (job && ring->funcs->emit_cntxcntl) {
-		status |= job->preamble_status;
-		status |= job->preemption_status;
+		status |= job->flags & (AMDGPU_PREAMBLE_IB_PRESENT |
+					AMDGPU_PREAMBLE_IB_PRESENT_FIRST |
+					AMDGPU_IB_PREEMPTED);
 		amdgpu_ring_emit_cntxcntl(ring, status);
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 8e712a11aba5..b9e18a806b5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -276,8 +276,8 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 	struct amdgpu_device *adev = ring->adev;
 	unsigned vmhub = ring->vm_hub;
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
+	uint32_t flags = vm->use_cpu_for_update ? AMDGPU_VM_NEEDS_FLUSH : 0;
 	uint64_t fence_context = adev->fence_context + ring->idx;
-	bool needs_flush = vm->use_cpu_for_update;
 	uint64_t updates = amdgpu_vm_tlb_seq(vm);
 	int r;
 
@@ -320,7 +320,7 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 				return 0;
 			}
 		}
-		needs_flush = true;
+		flags = AMDGPU_VM_NEEDS_FLUSH;
 	}
 
 	/* Good we can use this VMID. Remember this submission as
@@ -330,8 +330,7 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 	if (r)
 		return r;
 
-	job->vm_needs_flush = needs_flush;
-	job->spm_update_needed = true;
+	job->flags = AMDGPU_SPM_UPDATE_NEEDED | flags;
 	return 0;
 }
 
@@ -357,7 +356,8 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
 	uint64_t updates = amdgpu_vm_tlb_seq(vm);
 	int r;
 
-	job->vm_needs_flush = vm->use_cpu_for_update;
+	if (vm->use_cpu_for_update)
+		job->flags |= AMDGPU_VM_NEEDS_FLUSH;
 
 	/* Check if we can use a VMID already assigned to this VM */
 	list_for_each_entry_reverse((*id), &id_mgr->ids_lru, list) {
@@ -389,7 +389,8 @@ static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
 		if (r)
 			return r;
 
-		job->vm_needs_flush |= needs_flush;
+		if (needs_flush)
+			job->flags |= AMDGPU_VM_NEEDS_FLUSH;
 		return 0;
 	}
 
@@ -415,6 +416,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	struct amdgpu_vmid *idle = NULL;
 	struct amdgpu_vmid *id = NULL;
+	unsigned int vmid;
 	int r = 0;
 
 	mutex_lock(&id_mgr->lock);
@@ -441,19 +443,26 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 			if (r)
 				goto error;
 
-			job->vm_needs_flush = true;
+			job->flags |= AMDGPU_VM_NEEDS_FLUSH;
 		}
 
 		list_move_tail(&id->list, &id_mgr->ids_lru);
 	}
 
-	job->gds_switch_needed = amdgpu_vmid_gds_switch_needed(id, job);
-	if (job->vm_needs_flush) {
+	if (amdgpu_vmid_gds_switch_needed(id, job))
+		job->flags |= AMDGPU_GDS_SWITCH_NEEDED;
+	if (job->flags & AMDGPU_VM_NEEDS_FLUSH) {
 		id->flushed_updates = amdgpu_vm_tlb_seq(vm);
 		dma_fence_put(id->last_flush);
 		id->last_flush = NULL;
 	}
-	job->vmid = id - id_mgr->ids;
+
+	vmid = id - id_mgr->ids;
+	if (WARN_ON_ONCE(overflows_type(vmid, typeof(job->vmid)))) {
+		r = -ERANGE;
+		goto error;
+	}
+	job->vmid = vmid;
 	job->pasid = vm->pasid;
 
 	id->gds_base = job->gds_base;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 1899c601c95c..dca54a47dfff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -231,13 +231,17 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev,
 void amdgpu_job_set_resources(struct amdgpu_job *job, struct amdgpu_bo *gds,
 			      struct amdgpu_bo *gws, struct amdgpu_bo *oa)
 {
+	uint32_t size;
+
 	if (gds) {
 		job->gds_base = amdgpu_bo_gpu_offset(gds) >> PAGE_SHIFT;
 		job->gds_size = amdgpu_bo_size(gds) >> PAGE_SHIFT;
 	}
 	if (gws) {
 		job->gws_base = amdgpu_bo_gpu_offset(gws) >> PAGE_SHIFT;
-		job->gws_size = amdgpu_bo_size(gws) >> PAGE_SHIFT;
+		size = amdgpu_bo_size(gws) >> PAGE_SHIFT;
+		WARN_ON_ONCE(overflows_type(size, job->gws_size));
+		job->gws_size = size;
 	}
 	if (oa) {
 		job->oa_base = amdgpu_bo_gpu_offset(oa) >> PAGE_SHIFT;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index 7e5fe3d73a06..edb18df42816 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -28,13 +28,18 @@
 #include "amdgpu_ring.h"
 
 /* bit set means command submit involves a preamble IB */
-#define AMDGPU_PREAMBLE_IB_PRESENT          (1 << 0)
+#define AMDGPU_PREAMBLE_IB_PRESENT		(1 << 0)
 /* bit set means preamble IB is first presented in belonging context */
-#define AMDGPU_PREAMBLE_IB_PRESENT_FIRST    (1 << 1)
+#define AMDGPU_PREAMBLE_IB_PRESENT_FIRST	(1 << 1)
 /* bit set means context switch occured */
-#define AMDGPU_HAVE_CTX_SWITCH              (1 << 2)
+#define AMDGPU_HAVE_CTX_SWITCH			(1 << 2)
 /* bit set means IB is preempted */
-#define AMDGPU_IB_PREEMPTED                 (1 << 3)
+#define AMDGPU_IB_PREEMPTED			(1 << 3)
+#define AMDGPU_VM_NEEDS_FLUSH			(1 << 4)
+#define AMDGPU_GDS_SWITCH_NEEDED		(1 << 5)
+#define AMDGPU_SPM_UPDATE_NEEDED		(1 << 6)
+#define AMDGPU_ENFORCE_ISOLATION		(1 << 7)
+#define AMDGPU_INIT_SHADOW			(1 << 8)
 
 #define to_amdgpu_job(sched_job)		\
 		container_of((sched_job), struct amdgpu_job, base)
@@ -50,21 +55,18 @@ struct amdgpu_job {
 	struct amdgpu_sync	explicit_sync;
 	struct dma_fence	hw_fence;
 	struct dma_fence	*gang_submit;
-	bool                    vm_needs_flush;
-	bool			gds_switch_needed;
-	bool			spm_update_needed;
-	bool			enforce_isolation;
-	bool			init_shadow;
-	unsigned		vmid;
-	unsigned		pasid;
-	uint32_t		num_ibs;
-	uint32_t		preamble_status;
-	uint32_t                preemption_status;
+
+	uint32_t		pasid;
+	uint16_t		flags;
+	uint16_t		job_run_counter; /* >= 1 means a resubmit job */
+	uint8_t			vmid;
+	uint8_t			num_ibs;
+
+	uint16_t		gws_size; /* in pages so enough and prevents holes */
+	uint32_t		gws_base;
+
 	uint32_t		gds_base, gds_size;
-	uint32_t		gws_base, gws_size;
 	uint32_t		oa_base, oa_size;
-	/* job_run_counter >= 1 means a resubmit job */
-	uint32_t		job_run_counter;
 	uint64_t		vm_pd_addr;
 	uint64_t		generation;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 383fce40d4dd..913e142564bd 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -235,7 +235,7 @@ TRACE_EVENT(amdgpu_vm_grab_id,
 			   __entry->vmid = job->vmid;
 			   __entry->vm_hub = ring->vm_hub,
 			   __entry->pd_addr = job->vm_pd_addr;
-			   __entry->needs_flush = job->vm_needs_flush;
+			   __entry->needs_flush = job->flags & AMDGPU_VM_NEEDS_FLUSH;
 			   ),
 	    TP_printk("pasid=%d, ring=%s, id=%u, hub=%u, pd_addr=%010Lx needs_flush=%u",
 		      __entry->pasid, __get_str(ring), __entry->vmid,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 01ae2f88dec8..1f2d252802a7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2163,7 +2163,7 @@ static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
 		(*job)->vm_pd_addr = amdgpu_gmc_pd_addr(adev->gmc.pdb0_bo ?
 							adev->gmc.pdb0_bo :
 							adev->gart.bo);
-		(*job)->vm_needs_flush = true;
+		(*job)->flags |= AMDGPU_VM_NEEDS_FLUSH;
 	}
 	if (!resv)
 		return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 5c07777d3239..04aa1c75cbc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -726,10 +726,11 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
 	if (job->vmid == 0)
 		return false;
 
-	if (job->vm_needs_flush || ring->has_compute_vm_bug)
+	if ((job->flags & AMDGPU_VM_NEEDS_FLUSH) || ring->has_compute_vm_bug)
 		return true;
 
-	if (ring->funcs->emit_gds_switch && job->gds_switch_needed)
+	if (ring->funcs->emit_gds_switch &&
+	    (job->flags & AMDGPU_GDS_SWITCH_NEEDED))
 		return true;
 
 	if (amdgpu_vmid_had_gpu_reset(adev, &id_mgr->ids[job->vmid]))
@@ -756,11 +757,11 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	struct amdgpu_device *adev = ring->adev;
 	unsigned vmhub = ring->vm_hub;
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
-	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
-	bool spm_update_needed = job->spm_update_needed;
 	bool gds_switch_needed = ring->funcs->emit_gds_switch &&
-		job->gds_switch_needed;
-	bool vm_flush_needed = job->vm_needs_flush;
+				 (job->flags & AMDGPU_GDS_SWITCH_NEEDED);
+	bool spm_update_needed = job->flags & AMDGPU_SPM_UPDATE_NEEDED;
+	bool vm_flush_needed = job->flags & AMDGPU_VM_NEEDS_FLUSH;
+	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
 	struct dma_fence *fence = NULL;
 	bool pasid_mapping_needed = false;
 	unsigned int patch;
@@ -786,7 +787,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		ring->funcs->emit_wreg;
 
 	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
-	    !(job->enforce_isolation && !job->vmid))
+	    !((job->flags & AMDGPU_ENFORCE_ISOLATION) && !job->vmid))
 		return 0;
 
 	amdgpu_ring_ib_begin(ring);
@@ -799,7 +800,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 
 	if (adev->gfx.enable_cleaner_shader &&
 	    ring->funcs->emit_cleaner_shader &&
-	    job->enforce_isolation)
+	    (job->flags & AMDGPU_ENFORCE_ISOLATION))
 		ring->funcs->emit_cleaner_shader(ring);
 
 	if (vm_flush_needed) {
-- 
2.48.0


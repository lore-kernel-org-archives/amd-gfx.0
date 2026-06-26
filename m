Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81E61C43458
	for <amd-gfx@archiver.kernel.org>; Fri, 26 Jun 2026 16:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1421710E3C3;
	Fri, 26 Jun 2026 16:10:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="g58uvLvi";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C838010E3C3
 for <amd-gfx@lists.freedesktop.org>; Fri, 26 Jun 2026 16:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=p8IPpt/pyLro+wEocJFrjk2OlKWomIKnv1ZGPLIRg9I=; b=g58uvLviPShdGKofqOJ5U5dGjK
 cG5pJTEQvlPiwuR+JmiVDYNumF1OgSOzeA8C9UZN3U7yRDAAE2sy3hQZ4ya815QfxBxk5Zo5L0C7/
 hCvbaY4MSc6PpxlsRZ8V3O5h25ef2JW6So1nwHebFz+Ysr1c6eSANrr+/7NNMY5PvVu0vaa0pSp9y
 be1hN1tv48nQ07NL38V6TyVnx7tnsetuatcuNaii6RMa02601u3pwwZI1aFHZ2TavFECiotIr0UPD
 Qi4fJFCwHBTbOPpXJOeDh1jdY9KNv1AG/Ay1IqHw31e+cJ6ruXvMEBsLT0hJrBqBs5117ziDYCoPA
 RT3pSavw==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wd980-005Zq8-IU; Fri, 26 Jun 2026 18:10:04 +0200
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Subject: [RFC] drm/amdgpu: Simplify amdgpu_vmid_grab?
Date: Fri, 26 Jun 2026 17:10:02 +0100
Message-ID: <20260626161002.13908-1-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.54.0
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

This is not a proper commit message but a conversation starter:

I found the flow of amdgpu_vmid_grab a bit confusing and decided to
butcher it, heavily, to see what will happen. To my surprise, I was able
to start a dozen of parallel 3d apps and nothing broke.

In no particular order:

 - Amdgpu_vmid_grab_idle cannot return an error despite the code claims it
   can.
 - Also, why it is called before attempting to re-use the previously
   assigned vmid?
 - And why it is called before the reserved vmid path and then not used?
 - What is the point of ring->vmid_wait? It is never cleared and isn't
   the same effect achieved by simply waiting on the last LRU entry?

What am I missing and what have I broke? :) Or if nothing, then:

 3 files changed, 64 insertions(+), 99 deletions(-)

And:

add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-465 (-465)
Function                                     old     new   delta
amdgpu_vmid_grab                            2917    2452    -465

Which is not bad? Not least the clearer flow of amdgpu_vmid_grab(),
one of the hottest functions in the submit worker after all.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Cc: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c  | 159 +++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c |   3 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h |   1 -
 3 files changed, 64 insertions(+), 99 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 124fb38eb465..37405f9ff7e5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -199,48 +199,35 @@ static bool amdgpu_vmid_compatible(struct amdgpu_vmid *id,
  * amdgpu_vmid_grab_idle - grab idle VMID
  *
  * @ring: ring we want to submit job to
- * @idle: resulting idle VMID
  * @fence: fence to wait for if no id could be grabbed
  *
  * Try to find an idle VMID, if none is idle add a fence to wait to the sync
- * object. Returns -ENOMEM when we are out of memory.
+ * object.
  */
-static int amdgpu_vmid_grab_idle(struct amdgpu_ring *ring,
-				 struct amdgpu_vmid **idle,
-				 struct dma_fence **fence)
+static struct amdgpu_vmid *amdgpu_vmid_grab_idle(struct amdgpu_ring *ring,
+						 struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	unsigned vmhub = ring->vm_hub;
-	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
-
-	/* If anybody is waiting for a VMID let everybody wait for fairness */
-	if (!dma_fence_is_signaled(ring->vmid_wait)) {
-		*fence = dma_fence_get(ring->vmid_wait);
-		return 0;
-	}
+	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[ring->vm_hub];
+	struct amdgpu_vmid *idle;
 
 	/* Check if we have an idle VMID */
-	list_for_each_entry_reverse((*idle), &id_mgr->ids_lru, list) {
+	list_for_each_entry_reverse(idle, &id_mgr->ids_lru, list) {
 		/* Don't use per engine and per process VMID at the same time */
 		struct amdgpu_ring *r = adev->vm_manager.concurrent_flush ?
 			NULL : ring;
 
-		*fence = amdgpu_sync_peek_fence(&(*idle)->active, r);
+		*fence = amdgpu_sync_peek_fence(&idle->active, r);
 		if (!(*fence))
-			return 0;
+			return idle;
 	}
 
 	/*
 	 * If we can't find a idle VMID to use, wait on a fence from the least
 	 * recently used in the hope that it will be available soon.
 	 */
-	*idle = NULL;
-	dma_fence_put(ring->vmid_wait);
-	ring->vmid_wait = dma_fence_get(*fence);
-
-	/* This is the reference we return */
 	dma_fence_get(*fence);
-	return 0;
+	return NULL;
 }
 
 /**
@@ -249,34 +236,33 @@ static int amdgpu_vmid_grab_idle(struct amdgpu_ring *ring,
  * @vm: vm to allocate id for
  * @ring: ring we want to submit job to
  * @job: job who wants to use the VMID
- * @id: resulting VMID
  * @fence: fence to wait for if no id could be grabbed
  *
  * Try to assign a reserved VMID.
  */
-static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
-				     struct amdgpu_ring *ring,
-				     struct amdgpu_job *job,
-				     struct amdgpu_vmid **id,
-				     struct dma_fence **fence)
+static struct amdgpu_vmid *
+amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
+			  struct amdgpu_ring *ring,
+			  struct amdgpu_job *job,
+			  struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	unsigned vmhub = ring->vm_hub;
 	uint64_t fence_context = adev->fence_context + ring->idx;
 	bool needs_flush = vm->use_cpu_for_update;
 	uint64_t updates = amdgpu_vm_tlb_seq(vm);
+	struct amdgpu_vmid *id;
 	int r;
 
-	*id = vm->reserved_vmid[vmhub];
-	if ((*id)->owner != vm->immediate.fence_context ||
-	    !amdgpu_vmid_compatible(*id, job) ||
-	    (*id)->flushed_updates < updates ||
-	    !(*id)->last_flush ||
-	    ((*id)->last_flush->context != fence_context &&
-	     !dma_fence_is_signaled((*id)->last_flush)))
+	id = vm->reserved_vmid[ring->vm_hub];
+	if (id->owner != vm->immediate.fence_context ||
+	    !amdgpu_vmid_compatible(id, job) ||
+	    id->flushed_updates < updates ||
+	    !id->last_flush ||
+	    (id->last_flush->context != fence_context &&
+	     !dma_fence_is_signaled(id->last_flush)))
 		needs_flush = true;
 
-	if ((*id)->owner != vm->immediate.fence_context ||
+	if (id->owner != vm->immediate.fence_context ||
 	    (!adev->vm_manager.concurrent_flush && needs_flush)) {
 		struct dma_fence *tmp;
 
@@ -287,26 +273,25 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 			ring = NULL;
 
 		/* to prevent one context starved by another context */
-		(*id)->pd_gpu_addr = 0;
-		tmp = amdgpu_sync_peek_fence(&(*id)->active, ring);
+		id->pd_gpu_addr = 0;
+		tmp = amdgpu_sync_peek_fence(&id->active, ring);
 		if (tmp) {
-			*id = NULL;
 			*fence = dma_fence_get(tmp);
-			return 0;
+			return NULL;
 		}
 	}
 
 	/* Good we can use this VMID. Remember this submission as
 	* user of the VMID.
 	*/
-	r = amdgpu_sync_fence(&(*id)->active, &job->base.s_fence->finished,
+	r = amdgpu_sync_fence(&id->active, &job->base.s_fence->finished,
 			      GFP_ATOMIC);
 	if (r)
-		return r;
+		return ERR_PTR(r);
 
 	job->vm_needs_flush = needs_flush;
 	job->spm_update_needed = true;
-	return 0;
+	return id;
 }
 
 /**
@@ -319,57 +304,46 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
  *
  * Try to reuse a VMID for this submission.
  */
-static int amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
-				 struct amdgpu_ring *ring,
-				 struct amdgpu_job *job,
-				 struct amdgpu_vmid **id)
+static struct amdgpu_vmid *
+amdgpu_vmid_grab_used(struct amdgpu_vm *vm,
+		      struct amdgpu_ring *ring,
+		      struct amdgpu_job *job)
 {
 	struct amdgpu_device *adev = ring->adev;
-	unsigned vmhub = ring->vm_hub;
-	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
+	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[ring->vm_hub];
 	uint64_t fence_context = adev->fence_context + ring->idx;
 	uint64_t updates = amdgpu_vm_tlb_seq(vm);
-	int r;
+	struct amdgpu_vmid *id;
 
 	job->vm_needs_flush = vm->use_cpu_for_update;
 
 	/* Check if we can use a VMID already assigned to this VM */
-	list_for_each_entry_reverse((*id), &id_mgr->ids_lru, list) {
+	list_for_each_entry_reverse(id, &id_mgr->ids_lru, list) {
 		bool needs_flush = vm->use_cpu_for_update;
 
 		/* Check all the prerequisites to using this VMID */
-		if ((*id)->owner != vm->immediate.fence_context)
+		if (id->owner != vm->immediate.fence_context)
 			continue;
 
-		if (!amdgpu_vmid_compatible(*id, job))
+		if (!amdgpu_vmid_compatible(id, job))
 			continue;
 
-		if (!(*id)->last_flush ||
-		    ((*id)->last_flush->context != fence_context &&
-		     !dma_fence_is_signaled((*id)->last_flush)))
+		if (!id->last_flush ||
+		    (id->last_flush->context != fence_context &&
+		     !dma_fence_is_signaled(id->last_flush)))
 			needs_flush = true;
 
-		if ((*id)->flushed_updates < updates)
+		if (id->flushed_updates < updates)
 			needs_flush = true;
 
 		if (needs_flush && !adev->vm_manager.concurrent_flush)
 			continue;
 
-		/* Good, we can use this VMID. Remember this submission as
-		 * user of the VMID.
-		 */
-		r = amdgpu_sync_fence(&(*id)->active,
-				      &job->base.s_fence->finished,
-				      GFP_ATOMIC);
-		if (r)
-			return r;
-
 		job->vm_needs_flush |= needs_flush;
-		return 0;
+		return id;
 	}
 
-	*id = NULL;
-	return 0;
+	return NULL;
 }
 
 /**
@@ -386,39 +360,34 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 		     struct amdgpu_job *job, struct dma_fence **fence)
 {
 	struct amdgpu_device *adev = ring->adev;
-	unsigned vmhub = ring->vm_hub;
+	const unsigned vmhub = ring->vm_hub;
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
-	struct amdgpu_vmid *idle = NULL;
-	struct amdgpu_vmid *id = NULL;
+	struct amdgpu_vmid *id;
 	int r = 0;
 
 	mutex_lock(&id_mgr->lock);
-	r = amdgpu_vmid_grab_idle(ring, &idle, fence);
-	if (r || !idle)
-		goto error;
 
 	if (amdgpu_vmid_uses_reserved(vm, vmhub)) {
-		r = amdgpu_vmid_grab_reserved(vm, ring, job, &id, fence);
-		if (r || !id)
-			goto error;
+		id = amdgpu_vmid_grab_reserved(vm, ring, job, fence);
+		if (IS_ERR_OR_NULL(id)) {
+			r = PTR_ERR(id);
+			goto out;
+		}
 	} else {
-		r = amdgpu_vmid_grab_used(vm, ring, job, &id);
+		id = amdgpu_vmid_grab_used(vm, ring, job);
+		if (!id)
+			id = amdgpu_vmid_grab_idle(ring, fence);
+		if (!id)
+			goto out;
+
+		/* Remember this submission as user of the VMID */
+		r = amdgpu_sync_fence(&id->active,
+				      &job->base.s_fence->finished,
+				      GFP_ATOMIC);
 		if (r)
-			goto error;
+			goto out;
 
-		if (!id) {
-			/* Still no ID to use? Then use the idle one found earlier */
-			id = idle;
-
-			/* Remember this submission as user of the VMID */
-			r = amdgpu_sync_fence(&id->active,
-					      &job->base.s_fence->finished,
-					      GFP_ATOMIC);
-			if (r)
-				goto error;
-
-			job->vm_needs_flush = true;
-		}
+		job->vm_needs_flush = true;
 
 		list_move_tail(&id->list, &id_mgr->ids_lru);
 	}
@@ -443,7 +412,7 @@ int amdgpu_vmid_grab(struct amdgpu_vm *vm, struct amdgpu_ring *ring,
 
 	trace_amdgpu_vm_grab_id(vm, ring, job);
 
-error:
+out:
 	mutex_unlock(&id_mgr->lock);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 09593fcdb2f7..6614682eaa89 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -254,7 +254,6 @@ int amdgpu_ring_init(struct amdgpu_device *adev, struct amdgpu_ring *ring,
 		ring->adev = adev;
 		ring->num_hw_submission = sched_hw_submission;
 		ring->sched_score = sched_score;
-		ring->vmid_wait = dma_fence_get_stub();
 
 		ring->idx = adev->num_rings++;
 		adev->rings[ring->idx] = ring;
@@ -413,8 +412,6 @@ void amdgpu_ring_fini(struct amdgpu_ring *ring)
 	kvfree(ring->ring_backup);
 	ring->ring_backup = NULL;
 
-	dma_fence_put(ring->vmid_wait);
-	ring->vmid_wait = NULL;
 	ring->me = 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 8f28b3bd7010..33dd39dd21cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -414,7 +414,6 @@ struct amdgpu_ring {
 	u64			set_q_mode_token;
 	unsigned		vm_hub;
 	unsigned		vm_inv_eng;
-	struct dma_fence	*vmid_wait;
 	bool			has_compute_vm_bug;
 	bool			no_scheduler;
 	bool			no_user_submission;
-- 
2.54.0


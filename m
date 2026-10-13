Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFAF6CC6B10
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 08:49:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A577B10F63A;
	Tue, 13 Oct 2026 08:49:47 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (unknown [165.204.217.251])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4435910F62C
 for <amd-gfx@lists.freedesktop.org>; Tue, 13 Oct 2026 08:49:45 +0000 (UTC)
Received: from rtg-sunil-navi33.amd.com (localhost [127.0.0.1])
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTP id
 69D8ndqR972572; Tue, 13 Oct 2026 14:19:39 +0530
Received: (from sunil@localhost)
 by rtg-sunil-navi33.amd.com (8.15.2/8.15.2/Submit) id 69D8ndsu972568;
 Tue, 13 Oct 2026 14:19:39 +0530
From: Sunil Khatri <sunil.khatri@amd.com>
To: Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: amd-gfx@lists.freedesktop.org, Sunil Khatri <sunil.khatri@amd.com>
Subject: [PATCH v3 11/14] drm/amdgpu: remove the now-redundant runtime SPM
 VMID update
Date: Tue, 13 Oct 2026 14:19:34 +0530
Message-Id: <20261013084937.972181-11-sunil.khatri@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261013084937.972181-1-sunil.khatri@amd.com>
References: <20261013084937.972181-1-sunil.khatri@amd.com>
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

The SPM reserved VMID is fixed now, so retargeting RLC_SPM_VMID to
job->vmid on every submission is dead code. Remove
job->spm_update_needed and the update_spm_vmid() calls in
amdgpu_vm_flush() and amdgpu_ib_schedule().

Signed-off-by: Sunil Khatri <sunil.khatri@amd.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c  |  7 +------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c  | 15 +--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h  |  3 +--
 5 files changed, 3 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 0f8b097001e3c..f98a7c6797b3c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -126,7 +126,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	struct amdgpu_fence *af;
 	struct amdgpu_fence *vm_af;
 	bool need_ctx_switch;
-	bool emit_spm_needed = false;
 	bool emit_gds_needed = false;
 	uint64_t fence_ctx;
 	uint32_t status = 0, alloc_size;
@@ -195,8 +194,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 
 	/* VM sequence */
 	vm_af->ib_wptr = ring->wptr;
-	amdgpu_vm_flush(ring, job, &need_pipe_sync, &emit_spm_needed,
-			&emit_gds_needed);
+	amdgpu_vm_flush(ring, job, &need_pipe_sync, &emit_gds_needed);
 	vm_af->ib_dw_size =
 		amdgpu_ring_get_dw_distance(ring, vm_af->ib_wptr, ring->wptr);
 
@@ -211,9 +209,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (need_pipe_sync)
 		amdgpu_ring_emit_pipeline_sync(ring);
 
-	if (emit_spm_needed)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
-
 	if (emit_gds_needed)
 		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
 					    job->gds_size, job->gws_base,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 0eac7695f5587..992f7cb3a3102 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -372,7 +372,6 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 		return r;
 
 	job->vm_needs_flush = needs_flush;
-	job->spm_update_needed = true;
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
index ae569b4497f6a..f6577f82e6b93 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -75,7 +75,6 @@ struct amdgpu_job {
 	uint32_t                preemption_status;
 	bool                    vm_needs_flush;
 	bool			gds_switch_needed;
-	bool			spm_update_needed;
 	uint64_t		vm_pd_addr;
 	unsigned		vmid;
 	unsigned		pasid;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 7d3659ef11e53..de992405ed718 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -766,14 +766,12 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
  * @ring: ring to use for flush
  * @job:  related job
  * @need_pipe_sync: is pipe sync needed
- * @emit_spm_needed: does the caller need to emit spm
  * @emit_gds_needed: does the caller need to emit gds
  *
  * Emit a VM flush when it is necessary.
  */
 void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
-		     bool *need_pipe_sync, bool *emit_spm_needed,
-		     bool *emit_gds_needed)
+		     bool *need_pipe_sync, bool *emit_gds_needed)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_isolation *isolation =
@@ -782,8 +780,6 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	unsigned vmhub = ring->vm_hub;
 	struct amdgpu_kq_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
-	bool spm_update_needed = adev->gfx.rlc.funcs->update_spm_vmid &&
-		job->spm_update_needed;
 	bool gds_switch_needed = ring->funcs->emit_gds_switch &&
 		job->gds_switch_needed;
 	bool vm_flush_needed = job->vm_needs_flush;
@@ -797,7 +793,6 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		gds_switch_needed = true;
 		vm_flush_needed = true;
 		pasid_mapping_needed = true;
-		spm_update_needed = true;
 	}
 
 	mutex_lock(&id_mgr->lock);
@@ -807,7 +802,6 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	mutex_unlock(&id_mgr->lock);
 
 	gds_switch_needed &= !!ring->funcs->emit_gds_switch;
-	spm_update_needed &= !!adev->gfx.rlc.funcs->update_spm_vmid;
 	vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
 			job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
 	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
@@ -821,10 +815,6 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	emit_fence = vm_flush_needed || pasid_mapping_needed ||
 		cleaner_shader_needed;
 
-	*emit_spm_needed = spm_update_needed;
-	if (spm_update_needed && emit_fence)
-		*emit_spm_needed = false;
-
 	*emit_gds_needed = gds_switch_needed;
 	if (gds_switch_needed && emit_fence)
 		*emit_gds_needed = false;
@@ -864,9 +854,6 @@ void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (pasid_mapping_needed)
 		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
 
-	if (spm_update_needed)
-		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring->xcc_id, ring, job->vmid);
-
 	if (gds_switch_needed)
 		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
 						    job->gds_size, job->gws_base,
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index ddcdc7256ef07..b8aa45db1d844 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -448,8 +448,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       int (*callback)(void *p, struct amdgpu_bo *bo),
 		       void *param);
 void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
-		     bool *need_pipe_sync, bool *emit_spm_needed,
-		     bool *emit_gds_needed);
+		     bool *need_pipe_sync, bool *emit_gds_needed);
 int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm, bool immediate);
 int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
-- 
2.34.1


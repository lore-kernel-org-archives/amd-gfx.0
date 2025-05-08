Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B63EBC3ABC5
	for <amd-gfx@archiver.kernel.org>; Thu,  8 May 2025 12:05:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A10810E8E7;
	Thu,  8 May 2025 12:05:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LL2xJpEH";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C9FD510E8E7
 for <amd-gfx@lists.freedesktop.org>; Thu,  8 May 2025 12:05:20 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-3a0ebf39427so295773f8f.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 08 May 2025 05:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1746705919; x=1747310719; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kWvJVCdssGXALNN6glF/KoR4qyVoloTwG/pqhl+Gqxo=;
 b=LL2xJpEHy9NJ5rVkJCIq9S81zBp9RihrjguC80hxiLPc14v+hn7MRIKTVQdu8HCUvz
 qLQcmsKX3Y0GL39Coq6/NemQgcJJEFkaDG7ZM+iQPTUXhBdO30DBoZWbSku9tkYW3MZR
 qstf+YKeb4Lng8gtSciGO/vhnZ4PM7gly7jh1j9x+ZNTYNbBMqjbJ2dWPygyNzWr2YPY
 b1ERLvxebRjLv1ZPM+pMSeJsdp3URg/Dij2Ck46Ugnnsy7etAahEjqS0An+5phKIbRsz
 ROGW9Y0NwbUZHaZ2WkGduaGvC09KUN4u6P7Px6/Blph7YhpVEXPVVFwhjfpNg7qma4B2
 kGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746705919; x=1747310719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kWvJVCdssGXALNN6glF/KoR4qyVoloTwG/pqhl+Gqxo=;
 b=msKn7aj6eahpgewHeNcCgvRxPOa7haaQkUMwC9ipJBqnLqZ4wQomut+PqyXYXw9prZ
 mEB/7CdZCilBirfddb1HF7WVAjTMj+QYzF2S9jCvHeL/bJKM6vhLWs7ZwWlrGXagROD7
 mxWqS/UFZSyup9XzYT3d7zb0tD1Q1J1oFB/VVdIxF8eyqcBXY6aQsPepsyH606jYXD1I
 26eqCGN6+enxo72uT7NwiQRzkOy5/wAzcSX7Hsz6jHxYbgJ6WTeO+t/Hh2pbbKWQ4gw5
 cFiCSEQMaEkU7NWr0zXTyUF5Y3SsjTeSo9VHLvbzcqpE2FPaJ/lNa+qV+2efQPcShOgr
 8l2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhVhoCCPBE/OgOYKfscOHEG8Wfjws23/uppC8Pj53FdcU/DBEPeIEzoA6i/3nzZCLXj78UKgRf@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzsSzL1ZJozCotnb4r+MNewQ/HaPO0StcDCqvOL5drXe56+/I+w
 f6HADEz+QuDTjczH8QqBWwe+2k4w/RoaRBfCNU2/a8ScuVL2oTFFn3RDrDvNsS4=
X-Gm-Gg: ASbGncsvUIFWFIrZq6McQ2HJDcbjVqi8GnhjFa4yQTNqzTcxvEgsTqbhtuUckQrRj9P
 ZUVkG6EMJ0RDfn2+z9A4GOyvwb2yUwCQhLV/QuX4NlDLatV56v3XC2bVeEN61MeSXasgb6+fB+c
 MT/I5lNtwFmJ+Tt0ldwX/ghoGf8TVE3waPQj4ljf7f4S7x3Lyv9LODyyMXfIo2a7Gz6YI9q8/Q8
 8ECzBK5W/Ra+3RT3r5Ge3ixtZbAml+DLhkbYiQF6ILzxhVQgUrI5z89hH5h8/zmenQKZMKSJCv9
 BdCA9+m+/ylmfXawvby9569ziiC+xMy5SAjDjG2XshKpFb4BK14=
X-Google-Smtp-Source: AGHT+IEDKdJZa55R/wumyWfITdwZtstfUTmtTDYUu9xqBFwfNTDbfzyeXdT4f5yPTycVcPQ3dEwf7g==
X-Received: by 2002:a05:6000:2207:b0:39e:cbe1:8d68 with SMTP id
 ffacd0b85a97d-3a0ba09554emr2136165f8f.6.1746705904926; 
 Thu, 08 May 2025 05:05:04 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1523:6000:25d8:9e9:d5ee:d76])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a099ae0cafsm20255087f8f.19.2025.05.08.05.05.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 May 2025 05:05:04 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: cleanup amdgpu_vm_flush v7
Date: Thu,  8 May 2025 14:05:02 +0200
Message-Id: <20250508120502.1467-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250508120502.1467-1-christian.koenig@amd.com>
References: <20250508120502.1467-1-christian.koenig@amd.com>
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

Check if the cleaner shader should run directly.

While at it remove amdgpu_vm_need_pipeline_sync(), we also check again
if the VMID has seen a GPU reset since last use and the gds switch
setiing can be handled more simply as well.

Also remove some duplicate checks and re-order and document the code.

v2: restructure the while function
v3: fix logic error pointed out by Srini
v4: fix typo in comment, fix crash caused by incorrect check
v5: once more fix the logic
v6: separate cleaner shader checks as suggested by Srini
v7: re-order incorrect check
v8: separate the revert

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 106 ++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   5 +-
 3 files changed, 46 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 5eab1c1a380c..30b58772598c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -189,10 +189,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	}
 
 	need_ctx_switch = ring->current_ctx != fence_ctx;
-	if (ring->funcs->emit_pipeline_sync && job &&
-	    ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
-	     (amdgpu_sriov_vf(adev) && need_ctx_switch) ||
-	     amdgpu_vm_need_pipeline_sync(ring, job))) {
+	if ((job && (tmp = amdgpu_sync_get_fence(&job->explicit_sync))) ||
+	     (amdgpu_sriov_vf(adev) && need_ctx_switch)) {
 		need_pipe_sync = true;
 
 		if (tmp)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0a80c011e678..31c423663b54 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -707,37 +707,6 @@ void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev)
 	}
 }
 
-/**
- * amdgpu_vm_need_pipeline_sync - Check if pipe sync is needed for job.
- *
- * @ring: ring on which the job will be submitted
- * @job: job to submit
- *
- * Returns:
- * True if sync is needed.
- */
-bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
-				  struct amdgpu_job *job)
-{
-	struct amdgpu_device *adev = ring->adev;
-	unsigned vmhub = ring->vm_hub;
-	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
-
-	if (job->vmid == 0)
-		return false;
-
-	if (job->vm_needs_flush || ring->has_compute_vm_bug)
-		return true;
-
-	if (ring->funcs->emit_gds_switch && job->gds_switch_needed)
-		return true;
-
-	if (amdgpu_vmid_had_gpu_reset(adev, &id_mgr->ids[job->vmid]))
-		return true;
-
-	return false;
-}
-
 /**
  * amdgpu_vm_flush - hardware flush the vm
  *
@@ -758,44 +727,52 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	unsigned vmhub = ring->vm_hub;
 	struct amdgpu_vmid_mgr *id_mgr = &adev->vm_manager.id_mgr[vmhub];
 	struct amdgpu_vmid *id = &id_mgr->ids[job->vmid];
-	bool spm_update_needed = job->spm_update_needed;
-	bool gds_switch_needed = ring->funcs->emit_gds_switch &&
-		job->gds_switch_needed;
-	bool vm_flush_needed = job->vm_needs_flush;
-	bool cleaner_shader_needed = false;
-	bool pasid_mapping_needed = false;
-	struct dma_fence *fence = NULL;
+	bool gds_switch_needed, vm_flush_needed, spm_update_needed,
+	     cleaner_shader_needed, pasid_mapping_needed;
+	struct dma_fence *fence;
 	unsigned int patch;
 	int r;
 
+	/* First of all figure out what needs to be done */
 	if (amdgpu_vmid_had_gpu_reset(adev, id)) {
+		need_pipe_sync = true;
 		gds_switch_needed = true;
 		vm_flush_needed = true;
 		pasid_mapping_needed = true;
 		spm_update_needed = true;
+		cleaner_shader_needed = true;
+	} else {
+		gds_switch_needed = job->gds_switch_needed;
+		vm_flush_needed = job->vm_needs_flush;
+		mutex_lock(&id_mgr->lock);
+		pasid_mapping_needed = id->pasid != job->pasid ||
+			!id->pasid_mapping ||
+			!dma_fence_is_signaled(id->pasid_mapping);
+		mutex_unlock(&id_mgr->lock);
+		spm_update_needed = job->spm_update_needed;
+		cleaner_shader_needed = job->run_cleaner_shader &&
+			job->base.s_fence && &job->base.s_fence->scheduled ==
+			isolation->spearhead;
+		need_pipe_sync |= ring->has_compute_vm_bug || vm_flush_needed ||
+			cleaner_shader_needed || gds_switch_needed;
 	}
 
-	mutex_lock(&id_mgr->lock);
-	if (id->pasid != job->pasid || !id->pasid_mapping ||
-	    !dma_fence_is_signaled(id->pasid_mapping))
-		pasid_mapping_needed = true;
-	mutex_unlock(&id_mgr->lock);
-
+	/* Then check the pre-requisites */
+	need_pipe_sync &= !!ring->funcs->emit_pipeline_sync;
 	gds_switch_needed &= !!ring->funcs->emit_gds_switch;
 	vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
 			job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
 	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
 		ring->funcs->emit_wreg;
-
-	cleaner_shader_needed = job->run_cleaner_shader &&
-		adev->gfx.enable_cleaner_shader &&
-		ring->funcs->emit_cleaner_shader && job->base.s_fence &&
-		&job->base.s_fence->scheduled == isolation->spearhead;
+	spm_update_needed &= !!adev->gfx.rlc.funcs->update_spm_vmid;
+	cleaner_shader_needed &= adev->gfx.enable_cleaner_shader &&
+		ring->funcs->emit_cleaner_shader;
 
 	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
-	    !cleaner_shader_needed)
+	    !cleaner_shader_needed && !spm_update_needed)
 		return 0;
 
+	/* Then actually prepare the submission frame */
 	amdgpu_ring_ib_begin(ring);
 	if (ring->funcs->init_cond_exec)
 		patch = amdgpu_ring_init_cond_exec(ring,
@@ -815,23 +792,34 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (pasid_mapping_needed)
 		amdgpu_gmc_emit_pasid_mapping(ring, job->vmid, job->pasid);
 
-	if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
+	if (spm_update_needed)
 		adev->gfx.rlc.funcs->update_spm_vmid(adev, ring, job->vmid);
 
-	if (ring->funcs->emit_gds_switch &&
-	    gds_switch_needed) {
+	if (gds_switch_needed)
 		amdgpu_ring_emit_gds_switch(ring, job->vmid, job->gds_base,
 					    job->gds_size, job->gws_base,
 					    job->gws_size, job->oa_base,
 					    job->oa_size);
-	}
 
 	if (vm_flush_needed || pasid_mapping_needed || cleaner_shader_needed) {
 		r = amdgpu_fence_emit(ring, &fence, NULL, 0);
 		if (r)
 			return r;
+	} else {
+		fence = NULL;
+	}
+
+	amdgpu_ring_patch_cond_exec(ring, patch);
+
+	/* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
+	if (ring->funcs->emit_switch_buffer) {
+		amdgpu_ring_emit_switch_buffer(ring);
+		amdgpu_ring_emit_switch_buffer(ring);
 	}
 
+	amdgpu_ring_ib_end(ring);
+
+	/* And finally remember what the ring has executed */
 	if (vm_flush_needed) {
 		mutex_lock(&id_mgr->lock);
 		dma_fence_put(id->last_flush);
@@ -861,16 +849,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		mutex_unlock(&adev->enforce_isolation_mutex);
 	}
 	dma_fence_put(fence);
-
-	amdgpu_ring_patch_cond_exec(ring, patch);
-
-	/* the double SWITCH_BUFFER here *cannot* be skipped by COND_EXEC */
-	if (ring->funcs->emit_switch_buffer) {
-		amdgpu_ring_emit_switch_buffer(ring);
-		amdgpu_ring_emit_switch_buffer(ring);
-	}
-
-	amdgpu_ring_ib_end(ring);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index f3ad687125ad..c9578b7f670c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -498,7 +498,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       struct ww_acquire_ctx *ticket,
 		       int (*callback)(void *p, struct amdgpu_bo *bo),
 		       void *param);
-int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
+int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
+		    bool need_pipe_sync);
 int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm, bool immediate);
 int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
@@ -559,8 +560,6 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
 			   uint32_t fragment_size_default, unsigned max_level,
 			   unsigned max_bits);
 int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
-bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
-				  struct amdgpu_job *job);
 void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
 
 struct amdgpu_task_info *
-- 
2.34.1


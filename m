Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01F11C36002
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Apr 2025 10:45:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7885E10E31C;
	Wed,  9 Apr 2025 10:45:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FnUQCSfc";
	dkim-atps=neutral
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 35F5E10E31C
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Apr 2025 10:45:03 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-5e6c18e2c7dso12869563a12.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 09 Apr 2025 03:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744195502; x=1744800302; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=nZC52Pwp9GSXw867CpdDAdB3ldFDY/7fNRmnPNsx+cg=;
 b=FnUQCSfcxDTlSVFYy/m998+Ijpfp8KcsLaydG50IrJt0UkYH0ebHhIVyNvAF7KVr2l
 WBYwqk8ep97LpK/NPvmMnccFbrXn3YEHlQGG1HvKYBu6TdCOYOs+XBfdeWbdRucm2+L9
 So2Azck1el3L9nhORRc30ba6C3Lu1pvdDeaxL4cFzG6CeYOuZ/HRQcR79jKuwXMBWz1x
 kgLilxM0nXkcl6gCHSvlVJ+FUxQOtRwcHMB0FR5IUQEhVdbwrsOO0bZXysdSVaPNosxL
 rj1/lp3iYs724FBD3xhtjyyU/9cJqFiNUlbwxfxGTEz0Qr61MasHgwZyU7qQtj93jL+0
 kWpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744195502; x=1744800302;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nZC52Pwp9GSXw867CpdDAdB3ldFDY/7fNRmnPNsx+cg=;
 b=RZ9tRlWQCJAyvtLeKgWGoluLQc9syjpa2tVJcI2NogS38exM8TgBREi/7z2VRp4v2z
 eniOX/A0yCkQkz3xxXFaMgwKv6XlVd1y7w4iH8CxJAR2Z0OO9hgm8m3rBEWIbIheKOat
 TybY6z7EvP+zMCPcsSCLYDTOiUSe5ywTTb6+MvFfhUiI8w71j5t/r/Qn6K+1Gl1E8hlN
 Tn6Mm0HLBxERQD4nT3Npr3BfhweVNQLm56031gvUGDGRoFyg3GheOrf6RQ8lyWj4XuNg
 bqB5GA0I1bFga6KRFMPcSHDVc8gz953sVTzmodVBo8fnXhNP05seFf2ODVET4wYs2y13
 s5aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCViwP9USCaDSSF6zcibDa7rkAjLezwAccrS5pBMKzJCv2qixVdaDp8tg+fmExSfeDRPwKrZdYhU@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGGk+EeZy+7KUHSWTvvQnRxSMdHeotcApAryRmZpftwXg9kLpG
 knR/nfteiqZltNrzS8OQqUP1n3MI3MgBzdUueFKatTJYa3fvjrkY
X-Gm-Gg: ASbGncvWNMNXPr2G8OYPiUcQhx5yZApEv6gEfkuQiytkgLPjElLZwpYYr+Jv5k7KEne
 mGwJfdGVm43vlC+I5nodjaT552GjciiRjHW0M0Gz9g3uuFBDygpRI7U/ex6bU0f5tV1+QH1P4Il
 4moOy7+mpyFfRpPg2o7FkYU6jwmSv9piUHmND92fFAeNNk7k51najp4JPj2MkSiI6/j6k+/t5qy
 DWXbpoCcFTF1oovmuTajuH/2jVrt1ExoKM9QagQolBtb9jqx7wqjFsgiILoORpWDtg5npcY8v6w
 R7JDuVkkpwz2YnRDfKl5xESFm8Irzjp5tzAQRTcZQMtNKvsdD42wQA==
X-Google-Smtp-Source: AGHT+IFOVdY5/MJNJWaHUc6Xe6Z0ZdfeRFKyewd1QO1GY0vrUjKd+Bgb1lx1VtQDcOTEsQAH9g57+w==
X-Received: by 2002:a05:6402:2355:b0:5eb:1dac:5a20 with SMTP id
 4fb4d7f45d1cf-5f2f7755a63mr1831360a12.31.1744195501330; 
 Wed, 09 Apr 2025 03:45:01 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15d8:b700:7b7c:42c2:85c9:2b01])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5f2fbbac855sm605069a12.16.2025.04.09.03.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Apr 2025 03:45:00 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: cleanup amdgpu_vm_flush v5
Date: Wed,  9 Apr 2025 12:45:00 +0200
Message-Id: <20250409104500.2169-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
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

This reverts commit c2cc3648ba517a6c270500b5447d5a1efdad5936. Turned out
that this has some negative consequences for some workloads. Instead check
if the cleaner shader should run directly.

While at it remove amdgpu_vm_need_pipeline_sync(), we also check again
if the VMID has seen a GPU reset since last use and the gds switch
setiing can be handled more simply as well.

Also remove some duplicate checks and re-order and document the code.

v2: restructure the while function
v3: fix logic error pointed out by Srini
v4: fix typo in comment, fix crash caused by incorrect check
v5: once more fix the logic

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 94 ++++++++++----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  5 +-
 3 files changed, 39 insertions(+), 66 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 802743efa3b3..30b58772598c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -189,10 +189,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	}
 
 	need_ctx_switch = ring->current_ctx != fence_ctx;
-	if (ring->funcs->emit_pipeline_sync && job &&
-	    ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
-	     need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
-
+	if ((job && (tmp = amdgpu_sync_get_fence(&job->explicit_sync))) ||
+	     (amdgpu_sriov_vf(adev) && need_ctx_switch)) {
 		need_pipe_sync = true;
 
 		if (tmp)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b5ddfcbbc9fc..8e99dbd70968 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -596,37 +596,6 @@ void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev)
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
@@ -647,43 +616,49 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
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
+	} else {
+		gds_switch_needed = job->gds_switch_needed;
+		vm_flush_needed = job->vm_needs_flush;
+		mutex_lock(&id_mgr->lock);
+		pasid_mapping_needed = id->pasid != job->pasid ||
+			!id->pasid_mapping ||
+			!dma_fence_is_signaled(id->pasid_mapping);
+		mutex_unlock(&id_mgr->lock);
+		spm_update_needed = job->spm_update_needed;
+		need_pipe_sync |= ring->has_compute_vm_bug || vm_flush_needed ||
+			cleaner_shader_needed || gds_switch_needed;
 	}
 
-	mutex_lock(&id_mgr->lock);
-	if (id->pasid != job->pasid || !id->pasid_mapping ||
-	    !dma_fence_is_signaled(id->pasid_mapping))
-		pasid_mapping_needed = true;
-	mutex_unlock(&id_mgr->lock);
-
+	need_pipe_sync &= !!ring->funcs->emit_pipeline_sync;
 	gds_switch_needed &= !!ring->funcs->emit_gds_switch;
 	vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
 			job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
 	pasid_mapping_needed &= adev->gmc.gmc_funcs->emit_pasid_mapping &&
 		ring->funcs->emit_wreg;
+	spm_update_needed &= !!adev->gfx.rlc.funcs->update_spm_vmid;
 
 	cleaner_shader_needed = adev->gfx.enable_cleaner_shader &&
 		ring->funcs->emit_cleaner_shader && job->base.s_fence &&
 		&job->base.s_fence->scheduled == isolation->spearhead;
 
 	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
-	    !cleaner_shader_needed)
+	    !cleaner_shader_needed && !spm_update_needed)
 		return 0;
 
+	/* Then actually prepare the submission frame */
 	amdgpu_ring_ib_begin(ring);
 	if (ring->funcs->init_cond_exec)
 		patch = amdgpu_ring_init_cond_exec(ring,
@@ -703,23 +678,34 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
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
@@ -749,16 +735,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
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
index daa2f9b33620..e9ecdb96bafa 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -493,7 +493,8 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       struct ww_acquire_ctx *ticket,
 		       int (*callback)(void *p, struct amdgpu_bo *bo),
 		       void *param);
-int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
+int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
+		    bool need_pipe_sync);
 int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm, bool immediate);
 int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
@@ -550,8 +551,6 @@ void amdgpu_vm_adjust_size(struct amdgpu_device *adev, uint32_t min_vm_size,
 			   uint32_t fragment_size_default, unsigned max_level,
 			   unsigned max_bits);
 int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp);
-bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
-				  struct amdgpu_job *job);
 void amdgpu_vm_check_compute_bug(struct amdgpu_device *adev);
 
 struct amdgpu_task_info *
-- 
2.34.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834ADC369AE
	for <amd-gfx@archiver.kernel.org>; Fri, 11 Apr 2025 13:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 132B510EBCA;
	Fri, 11 Apr 2025 13:54:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gj/at2Wp";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85A6710EBCA
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 13:54:54 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-43edb40f357so17153085e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 11 Apr 2025 06:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744379693; x=1744984493; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=/NSg4VyMeZmBXm9USM7lFXHvGp1Q5J0LY5R/qD+8a9o=;
 b=gj/at2Wpjw8VrSEs0/lwDg9pMmqe+pDIewtuB8lUACvnAdadEgSnEDZSpJIdfdy8LI
 07+eAJ6kluk+ZevMtb1TRo7A1GXY4vXUwmbjQAM+Qqw0ySgLYv9uFNA4G9CSz2DXD4iN
 kzPGqLI3HETLtAvpV3sery2FvDryNE9yeuyl2khi2snNYFp7kghZbrrAAZ1dSfouzZ8L
 94B21bD77GMoCPjwJ9+l7voG4ye32BJkuCExYs4cj09+6m8yIUnJZD5bAG4NIrDfNnCF
 vwo/UVSdZyd6xqAjnrrEaRxgmJmy2FqdV4P9vNPSmEa+zLBijZLbpoTkH0T0IQ2V5xhP
 n+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744379693; x=1744984493;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/NSg4VyMeZmBXm9USM7lFXHvGp1Q5J0LY5R/qD+8a9o=;
 b=ezb7/K+3rtHKaPkiM9mRuqbQ4CMlzOurqf18QdHVTMO1GSMqgpLmij6Asq6fWTjTPJ
 HaXh/v/9RgDnbq1GDNjMA6BLgsQldgqoOtTjrmj0GeCCQGsG7//WkT+vY39WCdFCTpFS
 7spTrsnjVkcBbZWOsrpLKAF7nOeXHJiZbss5zWpJwzxrKHFG1HxGK57/6y3GPJv+cRa2
 +/kxESr9RW0bhmAxK5MWz33XTe4CI4PFYgz4PWSEFfZZHc+i4uf8/9LX5Y2PMwMzCpcM
 6Zxj6zCp9BdMCG7weNv8jK8lXuojBBtsnj6soJl+kpbsLefQtIkj0gYbiXRPaOnTc/c6
 WG4Q==
X-Gm-Message-State: AOJu0YxP+d7sMVtuy/bh5X60nVrWKh0jUeEW0S56KKpLXExzdvRCm5Tz
 4MKmMf3oOXgFjuubzuFv0GCYcL+aXh3CmN5Fiybr+J9SCZsEWmMebjit5tah
X-Gm-Gg: ASbGncu/whhik0zaG6S2/v4yoK+5s+q3JtPw2KG8m53MOtn/H4juk+danOiexw4rHw0
 24NtjhS3a1bNPJoaGqjaXQEfEn5Chd0W38xcAWgvR91agIlaGzoNhg0hK52mp2OkdTLji6qqeSx
 oiOleY68Sz93rAgwTw6qKowvlDVowwQNGI/fZ5mg8c4BonRJ+fswleuzWAQipTXpzh8zFigUKpV
 ruqzcOFj9/I7e+GSkDjAUzDJyGrNtUkRHrj2MyQLAmnjFUGS+kgbfz+1AVqxuB5vXPXOpuDWmYp
 ldz4k/MCqcDkkc2xFocF0yBZzsiZDruT1cbLMdmRB+FOlBiG6dsdmVPwb26w1w==
X-Google-Smtp-Source: AGHT+IFZFP0JZ037WIPGcPqZpD+Z1DcsUE8LYJOyJf0B9YKHz13PpcOJy8rePKe+BtUX04fNdXkR6g==
X-Received: by 2002:a05:600c:6a16:b0:43d:79:ae1b with SMTP id
 5b1f17b1804b1-43f415d29a7mr5735955e9.14.1744379692615; 
 Fri, 11 Apr 2025 06:54:52 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15fd:7d00:ea68:bfe3:4527:8d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43f23572cf0sm87274195e9.27.2025.04.11.06.54.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Apr 2025 06:54:51 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	srinivasan.shanmugam@amd.com
Subject: [PATCH] drm/amdgpu: cleanup amdgpu_vm_flush v6
Date: Fri, 11 Apr 2025 15:54:50 +0200
Message-Id: <20250411135450.9264-1-christian.koenig@amd.com>
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
v6: separate cleaner shader checks as suggested by Srini

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |   6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 106 ++++++++++---------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |   5 +-
 3 files changed, 46 insertions(+), 71 deletions(-)

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
index dadf6715b98b..a0e9ab1afe96 100644
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
@@ -647,44 +616,52 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
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
+		need_pipe_sync |= ring->has_compute_vm_bug || vm_flush_needed ||
+			cleaner_shader_needed || gds_switch_needed;
+		cleaner_shader_needed = job->run_cleaner_shader &&
+			job->base.s_fence && &job->base.s_fence->scheduled ==
+			isolation->spearhead;
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
@@ -704,23 +681,34 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
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
@@ -750,16 +738,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
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


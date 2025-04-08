Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C800AC369A5
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Apr 2025 15:30:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 481C610E24B;
	Tue,  8 Apr 2025 15:30:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fZTi0V1a";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E10C10E23F
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Apr 2025 15:30:22 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-43cf628cb14so44994075e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Apr 2025 08:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744126220; x=1744731020; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yJV/AsI72gWLDoKLYzvYv6Z0ng56nPzqsMjDM5zIvlo=;
 b=fZTi0V1akgVFlrpzYOb5jlke9fFZ7Xb+GZ7tLyW6ZBReooakyAfOyxcevGxhZ3neV7
 xR8BE3garycpq4ST2dAVzNzrUgUJZsOulSgJ/qX86dqoqAkJNbPh5NzMBtHnLOUZcrds
 +5F8sdXQcz2FcgIBgmqVpc+HdkO7qWMM1NPXYpBmsbH89ymfXg3Dkk3yGn7E2HqXl+FN
 glZA+PnZlRIa8g6Ycws1Ge/PmtKl6a+qtQ0/OWwAgacXs4BsH6AdjHPOUzrQyX110Bb2
 wbfS2EaKzybY+1wESbi7IBxxLxN180q4URZIMx4msZB0cN/CI2vQ1eIzfCxVlSf8ONPe
 37lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744126220; x=1744731020;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yJV/AsI72gWLDoKLYzvYv6Z0ng56nPzqsMjDM5zIvlo=;
 b=xQ+iaQPhf4ghkmvGbg5v1D4Bvkm5xIYGxxSJ/cQEufh3yRc9Bv3Qh8mTshv10McKuj
 Kf5lI+DEpJ9Tisl7LmopFRsO8Gx0GoX6c4gSEJ+pfuNSPc1GU1v6xGTqYLd2vowkkKQy
 fNzCK5Ipa7QovipEnEtyBCazvCzQ8K7vRUcMjv2Bk7kSRsZ/5FM+l5WGdDUfofSKMkIV
 oQ1UveSywXGP5E09SvT8SG22r9Mc6s6/wdeo+tLf2JZ0uetVGjVGva40bM7ywclqwbQR
 xPKRB2K4yybnn5dk0MlIN7TeUoQL9ggFl1iZkagKWwUPrjsuCryvVo2Y8mRc0fTNpQRy
 HZ3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyfSortXPhDh6EVqiH00RrNE0jQRY8Qj7FlNZX4KhPNdA9NsdlRBdCOfJt5vIsPBJjNxH7b1Re@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzLfcfAWKC6/Biie6VyM2QjmONO+dxX1yiZ2E9exM7hbh7AUyf7
 6KA46egjtGZyqKgfitY9ebCTIXWQKmEDq6uTp02IRO9FyG5inF6cga05b9oi
X-Gm-Gg: ASbGncv2ETd8iYuGZSWusE0PaTUsmlaFmW4vlH1ZUzfoJiE/zbf+4s1JaaVqBg2HaM9
 xebDxeNEp9234heTJHk8Hayx+TzKlkeQwj38sf2M/c4ymg2FsJM4l6o94INEZgISFoU+UtMzYP2
 cl/G3KiIRHKNY+FLjOxE2xH2iLUpoBHxtedYt2xKe3sgRGdZYW05iTXRzLRQUFGpoNaS2lkuJhO
 TZ4a1OWPR8RmBXpeIjL4qgXFB9HtYa6RJ0R828pAOu8exNBCDKuFIqaaDbvXSE0DhM8V7aTP4Hu
 lKYdG/T3xNTievq0bueeNsBmDKkUVQyHDt0H6++Xq8EqjJAp8OgRzhD9NuAWKVuDL0Tm
X-Google-Smtp-Source: AGHT+IGTzst2v1GX+a10V7odhfYWOOuyslZ3C9O7e0fHQbOo7U9TvjqxmUAQ16SwLzN3hPHZmyBPbw==
X-Received: by 2002:a05:6000:250c:b0:39c:2673:4f10 with SMTP id
 ffacd0b85a97d-39d820f7cedmr3460739f8f.23.1744126220270; 
 Tue, 08 Apr 2025 08:30:20 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15c5:ac00:7bc3:87c3:a7e6:fa57])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c301a7045sm15423747f8f.39.2025.04.08.08.30.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Apr 2025 08:30:19 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: cleanup amdgpu_vm_flush v4
Date: Tue,  8 Apr 2025 17:30:18 +0200
Message-Id: <20250408153018.1770-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250408153018.1770-1-christian.koenig@amd.com>
References: <20250408153018.1770-1-christian.koenig@amd.com>
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

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |  6 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 96 ++++++++++----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  5 +-
 3 files changed, 40 insertions(+), 67 deletions(-)

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
index b5ddfcbbc9fc..c7f6eca144ad 100644
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
@@ -647,49 +616,55 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
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
+		need_pipe_sync |= ring->has_compute_vm_bug;
+		gds_switch_needed = job->gds_switch_needed;
+		vm_flush_needed = job->vm_needs_flush;
+		mutex_lock(&id_mgr->lock);
+		pasid_mapping_needed = id->pasid != job->pasid ||
+			!id->pasid_mapping ||
+			!dma_fence_is_signaled(id->pasid_mapping);
+		mutex_unlock(&id_mgr->lock);
+		spm_update_needed = job->spm_update_needed;
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
 						   ring->cond_exe_gpu_addr);
 
-	if (need_pipe_sync)
+	if (need_pipe_sync || vm_flush_needed || cleaner_shader_needed ||
+	    gds_switch_needed)
 		amdgpu_ring_emit_pipeline_sync(ring);
 
 	if (cleaner_shader_needed)
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


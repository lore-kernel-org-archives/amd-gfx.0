Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8221C36017
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 14:02:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F1A710E7BF;
	Wed,  2 Apr 2025 14:02:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VbM8Urwk";
	dkim-atps=neutral
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50ABA10E7BF
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 14:02:17 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-5eb92df4fcbso12275552a12.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 02 Apr 2025 07:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743602536; x=1744207336; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ClSdAvxDLthDXWzviO9JWkQMeYlh402hA+kjPl4W1Mc=;
 b=VbM8Urwkpn4D+2PD9QavHmkqRgx33eZjJTh28yiwzvmpP+p/KEvaq7OVC1RwbDJ9KK
 3jXeoNtF7L+NKCsLH2QfOgx4ICQD23km95jrODWyDH1l9JhwH1a8KMU7hP/BDa27Is9c
 knOTqv+7wcubo8tNncaJ6G5DP81YBH6OtVXmxVdZhpQP5Txvgy80hcLNyRaCl/RWct+q
 BoyhLP8shLYPz3a8Bd8ao6+Bo73hBHnK2xNISxlTeAApLTymsXqYiQAqp2hC3K4IZT5n
 Ezh9yUhFyut2cMZItY8hC4RaTX5gXGDZPaVvUXXpS0v6TlPCEy3EOCWHrv2D/zVQM4Of
 +wNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743602536; x=1744207336;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ClSdAvxDLthDXWzviO9JWkQMeYlh402hA+kjPl4W1Mc=;
 b=u7BTAvMToW0SdyMY7GTATjQjZ/Vmgu9vrXPF/HqJ24eeJvLEbmerT0JzUy3oabxqQD
 y3SSashUoKtOPC8U9u1qrtdoFF2PrWxEHI9xcz/9Cf4GV4jwSKepwq3dXTGJzNhcEXZw
 alif2S1MzaxIqUl0rOCfsNoAmMo59WqjFBXr/pd4XllTllpGc2dDJVjXsKjn2eBaozAA
 iYjg2D3f/1Y9+2tJ8Z4UkR2PlJKRcVPCIZizqQwwjoGYvVbwL7Yn7jIlIC/I34igMKaC
 INr1OGrDuiLWhiCxqysPnFywqKPW5s4phmPd9ncyA0onzME/sKQ5k803T9nkjjEQANlx
 Z1/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVE2UmGQ6+rXv9582Pou8Kts9m1LJs6aEI6gPTG45DqK37cP88o/19QOSa+JGGyIzNvc2QxISWd@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxhJOvUFhzQ3odeyp5IZF0X3ZnhSkWfy7CzMNJGW+K67rNUaViX
 kmFX14DK7D4B5uch0X7lRgYIZvc6hQxOeb/Z4LB9XmGSGyGRPtDVOSPW7g==
X-Gm-Gg: ASbGncvAl7t53PA1ICvMYXZ/o4B860dBV1CyB/0HKgXDmx4i7vQ6IACJujgt5kM+TKY
 emmvPgUCNrvcvfIs1GlC68Vd1Wg3WJ/wr/RgN2JRX5GxAgRWm37BYdmcd+4bAxr6NYrzVcALOTx
 uIlBaWmwrdA/kbGizFSU2BjwAxfJZuuFRsZuM0FDIlT6eyNKvtHooo27NyCfuMQ8M/h7hvN5Ebi
 dQQK1PEape+kzVVqMJBzzR8IC5hhkezV+1+dNAZXD4P734Z+phYvouWUhEH24E2X+zUFSnlqM+w
 88TG1zSiy8NZTYBFcGNFzkPcbhweE/Z71qJnMWJwEgd5LJJhvnQ2jAF9cg==
X-Google-Smtp-Source: AGHT+IEDj38T34wXMDLGQQsnNs3XwgCuHE19VHibsATuGTLSB8CCgIZ3jDhRxdR9WUBmjrAfhjmT3Q==
X-Received: by 2002:a05:6402:3588:b0:5ec:9545:74bd with SMTP id
 4fb4d7f45d1cf-5edfdbfe4ffmr15155405a12.27.1743602535262; 
 Wed, 02 Apr 2025 07:02:15 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:154c:cd00:1f79:1a00:3adf:1a77])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5edc17e05d8sm8366944a12.74.2025.04.02.07.02.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Apr 2025 07:02:14 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: cleanup amdgpu_vm_flush v2
Date: Wed,  2 Apr 2025 16:02:13 +0200
Message-Id: <20250402140213.13455-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250402140213.13455-1-christian.koenig@amd.com>
References: <20250402140213.13455-1-christian.koenig@amd.com>
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

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 89 +++++++++-----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  5 +-
 3 files changed, 34 insertions(+), 63 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 802743efa3b3..ff2ca984279a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -191,8 +191,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	need_ctx_switch = ring->current_ctx != fence_ctx;
 	if (ring->funcs->emit_pipeline_sync && job &&
 	    ((tmp = amdgpu_sync_get_fence(&job->explicit_sync)) ||
-	     need_ctx_switch || amdgpu_vm_need_pipeline_sync(ring, job))) {
-
+	     (amdgpu_sriov_vf(adev) && need_ctx_switch))) {
 		need_pipe_sync = true;
 
 		if (tmp)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b5ddfcbbc9fc..d7a4cb07defc 100644
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
@@ -647,29 +616,31 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
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
+		if (id->pasid != job->pasid || !id->pasid_mapping ||
+		    !dma_fence_is_signaled(id->pasid_mapping))
+			pasid_mapping_needed = true;
+		mutex_unlock(&id_mgr->lock);
+		spm_update_needed = job->spm_update_needed;
+		need_pipe_sync |= vm_flush_needed && ring->has_compute_vm_bug;
 	}
 
-	mutex_lock(&id_mgr->lock);
-	if (id->pasid != job->pasid || !id->pasid_mapping ||
-	    !dma_fence_is_signaled(id->pasid_mapping))
-		pasid_mapping_needed = true;
-	mutex_unlock(&id_mgr->lock);
-
 	gds_switch_needed &= !!ring->funcs->emit_gds_switch;
 	vm_flush_needed &= !!ring->funcs->emit_vm_flush  &&
 			job->vm_pd_addr != AMDGPU_BO_INVALID_OFFSET;
@@ -684,12 +655,13 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	    !cleaner_shader_needed)
 		return 0;
 
+	/* Then aktually prepare the submission frame */
 	amdgpu_ring_ib_begin(ring);
 	if (ring->funcs->init_cond_exec)
 		patch = amdgpu_ring_init_cond_exec(ring,
 						   ring->cond_exe_gpu_addr);
 
-	if (need_pipe_sync)
+	if (need_pipe_sync || cleaner_shader_needed || gds_switch_needed)
 		amdgpu_ring_emit_pipeline_sync(ring);
 
 	if (cleaner_shader_needed)
@@ -706,20 +678,31 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	if (spm_update_needed && adev->gfx.rlc.funcs->update_spm_vmid)
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
@@ -749,16 +732,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
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


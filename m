Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6026DC3601A
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Apr 2025 14:16:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EBB6410EBD2;
	Fri,  4 Apr 2025 14:16:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z+o6qy6g";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B88A110EBD1
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Apr 2025 14:16:13 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-43ce70f9afbso22169735e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Apr 2025 07:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1743776171; x=1744380971; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SmnrvoL1bRalkrB9XQZqK1CD4oZzfia6Il74IPnPdwA=;
 b=Z+o6qy6gnRrVKiDQXWsPbi/sP0XVqrghY5LUUlMSG6K0hsxGM3mw37wiGaLGecJyCx
 RP6r5nPrPtu1qLfUziguSi+Zse45r2k7ZeZbabQ3N/vbwyMusBeQ6pcO/49gUfyq12x5
 Mg5FiyorON6HRzWQr2gL1p6yjtjwKS/WCl+ZrTtLwXHJjadJBtc5MQ6WmDR8RVAKc0Ej
 7giJrFNhiNoWlPZNU1KB6SZJGq6ULY/hWhb5kgh3FUyRCCmlSyAVmLp8KkqBsgnmj9hl
 KoiVIfzjs27PfmngK0P+b8H7FUzP7y0zneW2KJMkFvGJsLxHZechX6hZFjcL5KPzd42y
 p37Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743776171; x=1744380971;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SmnrvoL1bRalkrB9XQZqK1CD4oZzfia6Il74IPnPdwA=;
 b=XFxknBp1KZduZhqKYdIgFjDPbE/+Re6k+3NK3YrNwyKDOu+aMcQeOfDlzoYvynqza0
 Ep11Hjh5l/xyo5oWbmC3DqW0T6pd1bvoD5gMR8D398+qfNYSbfDuIFd6Jyd1QhheiAsH
 lPR9zX/X6v54D2lwlFoTjIEYLMcrD9RiFdx1O7pqAVyn1TEFYIkIiYvQPuiSqN+/EJh7
 GVp/xHYhQkxjAcK8HeAjqgwUFJcGGK62h89FFKjWGmZMBAg2ieC4JVe+xZOdWE3OBEPo
 Aa3L+KXDvuhb8T+b6y0wBqKTAEeQ2uOdT1reCkCeiVmXbPneOX1JugJeoVNui/X7Ku/W
 gRsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeBkU8x7XN6rcBflAd8dxHPJNRTtLMbev0CkCVJO6nwAjlelDzPXv+qrp761bMHk2CxNEuNDAc@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz2uL5biKAf9zX69TnNxGgDQNtcqD4gfhXWoCjZ7n0qcygaSfXq
 tuj+0vifgFRz6I3sKFyzG5U6MnY33l9/TTx6pWbonaY5JrJZ7l/9tpWicnG042U=
X-Gm-Gg: ASbGnctFjhl5cJ2MA8N6xI8blrzrsxgEnRN4MdDIq/PJOkngS4KXdoDLZv3bbLnBXZY
 jatpBhdaBFwyI7IqbUTRcbkKtBY0vUbgZhJPRrjSY/wK/q7/LtQZFp10SWxgUebwQkM9fVY2z1r
 Tzd9GKMmU3KphD0V4YjKFQ61pXhp7WlTaWUNmDsrgdd7nhJdfsJr9Q2QWVj2rbXsCDM+Smogk9T
 wNRWQ+HMV9Y7xOfyjS6JuBshfoN6AEYFsG7uY1FsZOZMXSXrPOKD/Pk1wUb6dsPnQlK6sTY9OJA
 PjcTc41A4sueHf/aekDO9k5AQca5dJAL2VOnbYvJPQVYykIvsd6+OZjNpg==
X-Google-Smtp-Source: AGHT+IG4PNshhfNWT2z3TtyfUyyDMcekzvy5eRYwaX4dLM+QjpdWR50l908MLNyvpFYLuwyArlx2yQ==
X-Received: by 2002:a05:600c:3109:b0:43d:9f2:6274 with SMTP id
 5b1f17b1804b1-43ed0bde89dmr28402265e9.14.1743776170983; 
 Fri, 04 Apr 2025 07:16:10 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:157c:e200:b2b3:568d:2234:72c1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ec364ec90sm47005485e9.27.2025.04.04.07.16.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Apr 2025 07:16:10 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: cleanup amdgpu_vm_flush v3
Date: Fri,  4 Apr 2025 16:16:07 +0200
Message-Id: <20250404141607.1451-2-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250404141607.1451-1-christian.koenig@amd.com>
References: <20250404141607.1451-1-christian.koenig@amd.com>
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

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |  3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 92 +++++++++-----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  5 +-
 3 files changed, 36 insertions(+), 64 deletions(-)

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
index b5ddfcbbc9fc..e6d7db8d40cd 100644
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
+		need_pipe_sync |= ring->has_compute_vm_bug;
+		gds_switch_needed = job->gds_switch_needed;
+		vm_flush_needed = job->vm_needs_flush;
+		mutex_lock(&id_mgr->lock);
+		if (id->pasid != job->pasid || !id->pasid_mapping ||
+		    !dma_fence_is_signaled(id->pasid_mapping))
+			pasid_mapping_needed = true;
+		mutex_unlock(&id_mgr->lock);
+		spm_update_needed = job->spm_update_needed;
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
@@ -681,15 +652,17 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		&job->base.s_fence->scheduled == isolation->spearhead;
 
 	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
-	    !cleaner_shader_needed)
+	    !cleaner_shader_needed && !spm_update_needed)
 		return 0;
 
+	/* Then aktually prepare the submission frame */
 	amdgpu_ring_ib_begin(ring);
 	if (ring->funcs->init_cond_exec)
 		patch = amdgpu_ring_init_cond_exec(ring,
 						   ring->cond_exe_gpu_addr);
 
-	if (need_pipe_sync)
+	if (need_pipe_sync || vm_flush_needed || cleaner_shader_needed ||
+	    gds_switch_needed)
 		amdgpu_ring_emit_pipeline_sync(ring);
 
 	if (cleaner_shader_needed)
@@ -706,20 +679,31 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
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
@@ -749,16 +733,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
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


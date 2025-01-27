Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D72C0218A
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Jan 2025 15:32:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4080C10E56E;
	Mon, 27 Jan 2025 15:32:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jKDjFHEX";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2881C10E569
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jan 2025 15:32:13 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-436a39e4891so30757765e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Jan 2025 07:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1737991931; x=1738596731; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=kZneoDKIo24LxFcJSQMPiOFBLWTj9oIcQPwnr3yK/h4=;
 b=jKDjFHEXRcoolskVIjfikDLC8mydwKgCZYDbF7WOixJsDsAUNRFLhuhP9sXLs/qWUq
 YfZHyZ35REBwfdi1VLfYuuI9uGDBvwKdPrVNqEpSwkcZMxYVdIxfNHT/I8egfqPCYZLA
 WEbRNzxw+4ier2E6ZPPUhOctKws/Ui5qyC47x2XLXFB5oXBdohwsb5tj/ArtR0qRNTeN
 wKfvYFR/QRR97DFCTehTrubu7Q8XxQ+cYVxZnzYR51DvTuQpkt0myVPIefSsG/m/Q3ia
 4OoU0FQysNTUeRIKynHRkCv5EG6qbt5ZOIlLmz/7dO0qZHpx9pVTcyXa+GGTRUYCQd6l
 3Flg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737991931; x=1738596731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kZneoDKIo24LxFcJSQMPiOFBLWTj9oIcQPwnr3yK/h4=;
 b=wqc5KD3NgINgnLylsSkd8ADIbtjReYxEvoC/LPKSkjpUTMIeVx3QTPIvkgcS8pEQRE
 uXZskvg/r5nbc++L2wZRYCMNbpQcTHap6+CUJvRAVmaWCJJ3QOb/imD03WXnhr+9Zkc1
 HkbqIzikct1X+dEg66Ku1cOi2c9JAIzgtkYXB/uH9eBh4oomVcXGa66AiCrVTCcJXxDg
 4or9pusJOSet75TAC0jFj1gqlFLzBD8EKGNZb9kKLb1HerpAuu61h5Hz42CVJgyMcuVn
 l8PSkQHdNbwxVwMqr6qwqnEKGo+PHL614JLhJrpIoypSPltZOt8tKIlmpvyLdkzmGGN4
 4KjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWamPRSreUD/3CORrHaDBMu3/C/8psxj/obMvNWrD4kp0aRkE+qs2BMTCNgBmbPAtR8wJFxz6Hu@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzDpTjNV6BeCneTCme5OpHWZKnq9hXNe14S4pACupz45I9CGs/w
 YjTRtgU3JynI71DubwEIda6AY1HfT6OLdfX+oV2+GrhFddJ0pkwe
X-Gm-Gg: ASbGncv00vj3YZeFJSg2g1OAWFkrSm6sZefAL+OTLTquso66CwLx5/fzse4nGU3lO2t
 3tTrvqlCNBgGy32zejPa60TtLo7nCB4dzNHf/lQYbC9MaOUsMk/3A9MuIHd5WEFIqGcKFbdLv9n
 IC/AzEBlYvcUVDrbD7cJ5qXwhnSJmT/qhVfTW+/SLlVijTedLs0zfyZFFxEIrwOisAuxpYKgD8O
 NoENjX0fsXoS69W4+P7sshsZ7glNHHZrgvIWP+p5mxG4lbCBiO7EWRS+J2yyfddWT2zggMmLnBZ
 uQbbFQATJTX0W87nvg==
X-Google-Smtp-Source: AGHT+IG1fnyjWnqwrSFAQqaYUoaRSw2r8Q12ZztCaTwYGN9Cr1xETXPphUB7G0mAFCGXqGJu7sHkBQ==
X-Received: by 2002:a05:600c:1d28:b0:434:9f81:76d5 with SMTP id
 5b1f17b1804b1-43891434081mr352050385e9.22.1737991931357; 
 Mon, 27 Jan 2025 07:32:11 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:153d:dd00:1202:d6cf:5d6d:56cb])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd575468sm133904325e9.39.2025.01.27.07.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jan 2025 07:32:10 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com, srinivasan.shanmugam@amd.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/6] drm/amdgpu: rework how isolation is enforced
Date: Mon, 27 Jan 2025 16:32:05 +0100
Message-Id: <20250127153207.5717-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250127153207.5717-1-christian.koenig@amd.com>
References: <20250127153207.5717-1-christian.koenig@amd.com>
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

Limiting the number of available VMIDs to enforce isolation causes some
issues with gang submit and applying certain HW workarounds which
require multiple VMIDs to work correctly.

So instead start to track all submissions to the relevant engines in a
per partition data structure and use the dma_fences of the submissions
to enforce isolation similar to what a VMID limit does.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 13 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 94 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    | 43 ++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 16 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c   | 19 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h   |  1 +
 6 files changed, 151 insertions(+), 35 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 5e55a44f9eef..8902fafbcf8d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1204,9 +1204,15 @@ struct amdgpu_device {
 	bool                            debug_enable_ras_aca;
 	bool                            debug_exp_resets;
 
-	bool				enforce_isolation[MAX_XCP];
-	/* Added this mutex for cleaner shader isolation between GFX and compute processes */
+	/* Protection for the following isolation structure */
 	struct mutex                    enforce_isolation_mutex;
+	bool				enforce_isolation[MAX_XCP];
+	struct amdgpu_isolation {
+		void			*owner;
+		struct dma_fence	*spearhead;
+		struct amdgpu_sync	active;
+		struct amdgpu_sync	prev;
+	} isolation[MAX_XCP];
 
 	struct amdgpu_init_level *init_lvl;
 };
@@ -1487,6 +1493,9 @@ void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
 struct dma_fence *amdgpu_device_get_gang(struct amdgpu_device *adev);
 struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 					    struct dma_fence *gang);
+struct dma_fence *amdgpu_device_enforce_isolation(struct amdgpu_device *adev,
+						  struct amdgpu_ring *ring,
+						  struct amdgpu_job *job);
 bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev);
 ssize_t amdgpu_get_soft_full_reset_mask(struct amdgpu_ring *ring);
 ssize_t amdgpu_show_reset_mask(char *buf, uint32_t supported_reset);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index aaa8f9f7b6b2..d8f79fe4617b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4225,6 +4225,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
 	mutex_init(&adev->gfx.reset_sem_mutex);
 	/* Initialize the mutex for cleaner shader isolation between GFX and compute processes */
 	mutex_init(&adev->enforce_isolation_mutex);
+	for (i = 0; i < MAX_XCP; ++i) {
+		adev->isolation[i].spearhead = dma_fence_get_stub();
+		amdgpu_sync_create(&adev->isolation[i].active);
+		amdgpu_sync_create(&adev->isolation[i].prev);
+	}
 	mutex_init(&adev->gfx.kfd_sch_mutex);
 
 	amdgpu_device_init_apu_flags(adev);
@@ -4724,7 +4729,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 {
-	int idx;
+	int i, idx;
 	bool px;
 
 	amdgpu_device_ip_fini(adev);
@@ -4732,6 +4737,11 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	amdgpu_ucode_release(&adev->firmware.gpu_info_fw);
 	adev->accel_working = false;
 	dma_fence_put(rcu_dereference_protected(adev->gang_submit, true));
+	for (i = 0; i < MAX_XCP; ++i) {
+		dma_fence_put(adev->isolation[i].spearhead);
+		amdgpu_sync_free(&adev->isolation[i].active);
+		amdgpu_sync_free(&adev->isolation[i].prev);
+	}
 
 	amdgpu_reset_fini(adev);
 
@@ -6771,6 +6781,88 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
 	return NULL;
 }
 
+/**
+ * amdgpu_device_enforce_isolation - enforce HW isolation
+ * @adev: the amdgpu device pointer
+ * @ring: the HW ring the job is supposed to run on
+ * @job: the job which is about to be pushed to the HW ring
+ *
+ * Makes sure that only one client at a time can use the GFX block.
+ * Returns: The dependency to wait on before the job can be pushed to the HW.
+ * The function is called multiple times until NULL is returned.
+ */
+struct dma_fence *amdgpu_device_enforce_isolation(struct amdgpu_device *adev,
+						  struct amdgpu_ring *ring,
+						  struct amdgpu_job *job)
+{
+	struct amdgpu_isolation *isolation = &adev->isolation[ring->xcp_id];
+	struct drm_sched_fence *f = job->base.s_fence;
+	struct dma_fence *dep;
+	void *owner;
+
+	/*
+	 * For now enforce isolation only for the GFX block since we only need
+	 * the cleaner shader on those rings.
+	 */
+	if (ring->funcs->type != AMDGPU_RING_TYPE_GFX &&
+	    ring->funcs->type != AMDGPU_RING_TYPE_COMPUTE)
+		return NULL;
+
+	/*
+	 * All submissions where enforce isolation is false are handled as if
+	 * they come from a single client.
+	 */
+	owner = job->enforce_isolation ? f->owner : NULL;
+
+	mutex_lock(&adev->enforce_isolation_mutex);
+
+	/*
+	 * The "spearhead" submission is the first one which changes the
+	 * ownership to its client. We always need to wait for it to be
+	 * pushed to the HW before proceeding with anything.
+	 */
+	if (&f->scheduled != isolation->spearhead &&
+	    !dma_fence_is_signaled(isolation->spearhead)) {
+		dep = isolation->spearhead;
+		goto out_grab_ref;
+	}
+
+	if (isolation->owner != owner) {
+
+		/*
+		 * Wait for any gang to be assembled before switching to a
+		 * different owner or otherwise we could deadlock the
+		 * submissions.
+		 */
+		if (!job->gang_submit) {
+			dep = amdgpu_device_get_gang(adev);
+			if (!dma_fence_is_signaled(dep))
+				goto out_return_dep;
+			dma_fence_put(dep);
+		}
+
+		dma_fence_put(isolation->spearhead);
+		isolation->spearhead = dma_fence_get(&f->scheduled);
+		amdgpu_sync_move(&isolation->active, &isolation->prev);
+		isolation->owner = owner;
+	}
+
+	/*
+	 * Specifying the ring here helps to pipeline submissions even when
+	 * isolation is enabled. If that is not desired for testing NULL can be
+	 * used instead of the ring to enforce a CPU round trip while switching
+	 * between clients.
+	 */
+	dep = amdgpu_sync_peek_fence(&isolation->prev, ring);
+	amdgpu_sync_fence(&isolation->active, &f->finished, GFP_NOWAIT);
+
+out_grab_ref:
+	dma_fence_get(dep);
+out_return_dep:
+	mutex_unlock(&adev->enforce_isolation_mutex);
+	return dep;
+}
+
 bool amdgpu_device_has_display_hardware(struct amdgpu_device *adev)
 {
 	switch (adev->asic_type) {
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 56d27cea052e..92ab821afc06 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -287,40 +287,27 @@ static int amdgpu_vmid_grab_reserved(struct amdgpu_vm *vm,
 	    (*id)->flushed_updates < updates ||
 	    !(*id)->last_flush ||
 	    ((*id)->last_flush->context != fence_context &&
-	     !dma_fence_is_signaled((*id)->last_flush))) {
+	     !dma_fence_is_signaled((*id)->last_flush)))
+		needs_flush = true;
+
+	if ((*id)->owner != vm->immediate.fence_context ||
+	    (!adev->vm_manager.concurrent_flush && needs_flush)) {
 		struct dma_fence *tmp;
 
-		/* Wait for the gang to be assembled before using a
-		 * reserved VMID or otherwise the gang could deadlock.
+		/* Don't use per engine and per process VMID at the
+		 * same time
 		 */
-		tmp = amdgpu_device_get_gang(adev);
-		if (!dma_fence_is_signaled(tmp) && tmp != job->gang_submit) {
+		if (adev->vm_manager.concurrent_flush)
+			ring = NULL;
+
+		/* to prevent one context starved by another context */
+		(*id)->pd_gpu_addr = 0;
+		tmp = amdgpu_sync_peek_fence(&(*id)->active, ring);
+		if (tmp) {
 			*id = NULL;
-			*fence = tmp;
+			*fence = dma_fence_get(tmp);
 			return 0;
 		}
-		dma_fence_put(tmp);
-
-		/* Make sure the id is owned by the gang before proceeding */
-		if (!job->gang_submit ||
-		    (*id)->owner != vm->immediate.fence_context) {
-
-			/* Don't use per engine and per process VMID at the
-			 * same time
-			 */
-			if (adev->vm_manager.concurrent_flush)
-				ring = NULL;
-
-			/* to prevent one context starved by another context */
-			(*id)->pd_gpu_addr = 0;
-			tmp = amdgpu_sync_peek_fence(&(*id)->active, ring);
-			if (tmp) {
-				*id = NULL;
-				*fence = dma_fence_get(tmp);
-				return 0;
-			}
-		}
-		needs_flush = true;
 	}
 
 	/* Good we can use this VMID. Remember this submission as
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 100f04475943..685c61a05af8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -342,17 +342,24 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_job,
 {
 	struct amdgpu_ring *ring = to_amdgpu_ring(s_entity->rq->sched);
 	struct amdgpu_job *job = to_amdgpu_job(sched_job);
-	struct dma_fence *fence = NULL;
+	struct dma_fence *fence;
 	int r;
 
 	r = drm_sched_entity_error(s_entity);
 	if (r)
 		goto error;
 
-	if (job->gang_submit)
+	if (job->gang_submit) {
 		fence = amdgpu_device_switch_gang(ring->adev, job->gang_submit);
+		if (fence)
+			return fence;
+	}
+
+	fence = amdgpu_device_enforce_isolation(ring->adev, ring, job);
+	if (fence)
+		return fence;
 
-	if (!fence && job->vm && !job->vmid) {
+	if (job->vm && !job->vmid) {
 		r = amdgpu_vmid_grab(job->vm, ring, job, &fence);
 		if (r) {
 			dev_err(ring->adev->dev, "Error getting VM ID (%d)\n", r);
@@ -365,9 +372,10 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_job,
 		 */
 		if (!fence)
 			job->vm = NULL;
+		return fence;
 	}
 
-	return fence;
+	return NULL;
 
 error:
 	dma_fence_set_error(&job->base.s_fence->finished, r);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
index bfe12164d27d..c5f9db6b32a4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c
@@ -405,6 +405,25 @@ int amdgpu_sync_clone(struct amdgpu_sync *source, struct amdgpu_sync *clone)
 	return 0;
 }
 
+/**
+ * amdgpu_sync_move - move all fences from src to dst
+ *
+ * @src: source of the fences, empty after function
+ * @dst: destination for the fences
+ *
+ * Moves all fences from source to destination. All fences in destination are
+ * freed and source is empty after the function call.
+ */
+void amdgpu_sync_move(struct amdgpu_sync *src, struct amdgpu_sync *dst)
+{
+	unsigned int i;
+
+	amdgpu_sync_free(dst);
+
+	for (i = 0; i < HASH_SIZE(src->fences); ++i)
+		hlist_move_list(&src->fences[i], &dst->fences[i]);
+}
+
 /**
  * amdgpu_sync_push_to_job - push fences into job
  * @sync: sync object to get the fences from
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
index 1504f5e7fc46..51eb4382c91e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h
@@ -57,6 +57,7 @@ struct dma_fence *amdgpu_sync_peek_fence(struct amdgpu_sync *sync,
 				     struct amdgpu_ring *ring);
 struct dma_fence *amdgpu_sync_get_fence(struct amdgpu_sync *sync);
 int amdgpu_sync_clone(struct amdgpu_sync *source, struct amdgpu_sync *clone);
+void amdgpu_sync_move(struct amdgpu_sync *src, struct amdgpu_sync *dst);
 int amdgpu_sync_push_to_job(struct amdgpu_sync *sync, struct amdgpu_job *job);
 int amdgpu_sync_wait(struct amdgpu_sync *sync, bool intr);
 void amdgpu_sync_free(struct amdgpu_sync *sync);
-- 
2.34.1


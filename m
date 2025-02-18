Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D45BC021B0
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Feb 2025 16:14:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03CCE10E468;
	Tue, 18 Feb 2025 16:14:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bVljV09d";
	dkim-atps=neutral
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E447610E468
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 16:14:06 +0000 (UTC)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-5dee07e51aaso8656096a12.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Feb 2025 08:14:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739895245; x=1740500045; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=TkcfvQBTmPEO48BpfhWyhzyPtbidI0dPfPEJo8FTT8o=;
 b=bVljV09dK9jcGTBrE/Q2xBjROu6ZFIGVGk3xrGkhDamMPxokbU5BsHtI65nexDUsId
 X2vJlfFJ6hIjllNA8qmPWJe2OubQpYAbTVyDzdL6bTzG9Y+O0l5a6m5dlwarGuYu5okP
 R4IdzG+TIytP6Zia5vJ8utzyWrSDo2d04G5N6zAEejS0poNv9644LRWxLe/Pddmo+kTw
 cc87OeaYr4l+kd8fpQoPyhlVdKbCjE2l8gMK50NNf/7ybRvbjPkcPfJUigHeQb6uZ9AA
 xhZoOx9lLdggP6lswb94Z3SMScZ3pxw8iIQRL0/PHeRoFCEMUQk3QigCor2p7WFKSqri
 ChMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739895245; x=1740500045;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TkcfvQBTmPEO48BpfhWyhzyPtbidI0dPfPEJo8FTT8o=;
 b=HnTh9iLsGYsrOU7CabgXVBrk9m9PUEXk9Su0CxpwK46mFM3WTzvboo8cwKI1jfWDWf
 tQ09kSZSA4IdZgwrUvgj8LvrsHYJ8S4bajjiqiGJrrOwL1F0zf0785pbO7Y4Dj6wUrE+
 MhwdSEXaWrRajtMPr3N6qFoSvnSko2M0YIM+vUY3d9uDV9tdJS4nToM3AobHvUGETyZ6
 6DABn2T8fWo8PvJpalG9zPVVPq25Nljgvb4Is9IHZyvRzm7eH8cZfkE4ESFh1sYXYmhI
 Q0waPUC881TeOzN9QRPRJNqx5Vt1g874YACzoIANHKhg/6j+fyjEmXwoF/c8G6lNCsGA
 sZqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVIOCBF41yeqh8eTS3S3bD5TQYZutc4naD5rT9eg8hT62XGu1fY32z6OQrD8Ha3WO0edtBV41lm@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywu272VbyNXM+NV6kqic9H4UZ5Zf//NSLXSEhTCbDasQjbjBwTz
 sT4b8iCsbPzIufdzSJW/s7N1DZFHi4Gf1VbSxnIWbMahcFmRLAdg
X-Gm-Gg: ASbGnctxxxQ+BL7ShHYUfxwrODYRWRt2zeE08zDsnYETyGHksM77JzYIKVof9RvalLI
 UOo/egfd4uZCHKine47ovo0Im3w05N/uRYEoR7wMybHKQ+T0F7ZSBJnJsfa+Yxj77LVK5n+S4ba
 uEVVW1LaQKwouKrmoM2V/cDTy3mBW0f7XYYP5QRaHe3YXFaRs5ktG+T3y1uNdv0+1KXoQYImap3
 gzWmUkBJf3nfBv2m9hkW3/W9S9Gknfj0AOnqlmxGck/H1MF6N4Od5ndTafcqjfFAsQ21CJnEFWr
 SbYOlu4IKBVKFJn23GoZ5Vzx+6iz
X-Google-Smtp-Source: AGHT+IFCXp/uiVmLbsTIVuAYs7GpV1NH0HmLz8dEwKJ2cM4aUOsCwrKBBNij7YEs65FG9nhsjp+ikg==
X-Received: by 2002:a17:906:4116:b0:ab7:ea59:2120 with SMTP id
 a640c23a62f3a-abb70a7c980mr1262241766b.10.1739895245095; 
 Tue, 18 Feb 2025 08:14:05 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15cb:ef00:7a4e:6292:55ba:b835])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abba7848676sm306762466b.144.2025.02.18.08.14.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Feb 2025 08:14:04 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 4/8] drm/amdgpu: rework how isolation is enforced v2
Date: Tue, 18 Feb 2025 17:13:57 +0100
Message-Id: <20250218161401.2155-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250218161401.2155-1-christian.koenig@amd.com>
References: <20250218161401.2155-1-christian.koenig@amd.com>
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

v2: use ~0l for jobs without isolation to distinct it from kernel
    submissions which uses NULL for the owner. Add some warning when we
    are OOM.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 13 ++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 98 +++++++++++++++++++++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c    | 43 ++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    | 16 +++-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.c   | 19 +++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_sync.h   |  1 +
 6 files changed, 155 insertions(+), 35 deletions(-)

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
index aaa8f9f7b6b2..f1369c60565c 100644
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
 
@@ -6771,6 +6781,92 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
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
+	int r;
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
+	 * they come from a single client. Use ~0l as the owner to distinct it
+	 * from kernel submissions where the owner is NULL.
+	 */
+	owner = job->enforce_isolation ? f->owner : (void*)~0l;
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
+	r = amdgpu_sync_fence(&isolation->active, &f->finished, GFP_NOWAIT);
+	if (r)
+		DRM_WARN("OOM tracking isolation\n");
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


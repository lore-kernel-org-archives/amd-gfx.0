Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC477C19F32
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Mar 2025 13:48:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CB3DC10EB60;
	Fri,  7 Mar 2025 13:48:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="MDD8OAjN";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0931B10EB60
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Mar 2025 13:48:21 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4394345e4d5so10860565e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Mar 2025 05:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741355299; x=1741960099; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=sHrhExfWPAq9HjigBVarhBOpez7Xf/Z8HyMwkWrQuvs=;
 b=MDD8OAjNIRaH3oslYHc+EF18QgrmvzLJ/jGchCfRXbr3AIVGiQvWkwK3rL/63+xVkC
 WfnY2dyFGT1FF1uBT4aHyZRhTZXIi0bHQeBZsyrhp9j2oxApdNJ1SvgvcMw0kNoNFSvF
 RHioTnR6Mx/UtjL7sLOrKCOyNGOSqK+ShiuKW00G8UJEMzALES4k32G1gL+R6LIDDSuf
 IX5hpbzrSVDRYdUft2qonobed7D/473QtFkogh1SHxZNJVOOn2neIpiDOI0nnZWKqR9M
 ZZ6TIFjD8vLTtwmoIjCA+gz+uf7B+h6gk/3JOakMqZArnrKy+kl8L6O4w5wtVlcSyud7
 E0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741355299; x=1741960099;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sHrhExfWPAq9HjigBVarhBOpez7Xf/Z8HyMwkWrQuvs=;
 b=X2SzHboit1r6E6EORPdGTQWeo3ZSp4w/9CUxI6ILMbS0LjPoz8+Gq++yH49Bb3zq4/
 PfV9RnmFtg8OSsXw8TBUYnww6yviG5gg7ezQL5YXNcGZNNqgSyB7OqY/9HKUGhfX5AdI
 DB3YFZxxBGaW1ZCQRLzasN9mrolwa8KBkoRsn+63bnkRl/IuegPTUHSQulCNT5asOTZp
 ++5SxvXjATVXP9vVaVlV4Ct/Ql53FlrHNPNk3WuyDuYUJ16qH+hskb82t4ApCfeh2p1r
 pj/u6pMIaXnRueIJSbqgzzzhVMNMOAFf68hrbX7cJgRGUwX1Kp54Mw9ule/JKqGhSLSg
 KLHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkGuSl2awvowSh8xWbnymlLzCnCbn1GhnNPMZHdvyG3vJcnkjZKl1IKcYvnm21KtxSRaizradW@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxm+QWYkzy0g27q6GnajiDF2gbIzJt5pFC2zM4Mf4xAlDEz5QeE
 6rDtxqlbAxILmZfn6rx4BnBUV64F9/mjwDQJQJgvaxk7nh3VwpzgTK3rgPfJmYg=
X-Gm-Gg: ASbGncsFq+mf3HpTGukjWqkkbt5SYSpzhAxri9uNdYRtqZTsL5Qn2+/1t1l632KCMQn
 cqyd8Zu2EGmD4zYGE24uhCusAOiHEW4Pts5IkTRottlvW/RjjRnyAZKe2P39m1av9zycmZN/zMw
 Bk8xYDRk9LL6dyAF7AklqkPgHdL/Aw/fCom+SCXr/6gUCCYyil0psYlq+ZkfAAxG9IqMsJZwqNO
 w7aTk6PvYSSIZIvSySpRI8JhhWDOjntvCRi1XQvfHoOIK3BTZyvPE1aQ8BsYE/CRQ3DkvOGvJmG
 Vcb2ARVOSO4ZwlVcla+eN7vBWpPkunP/pnmZ3VdBupRlRya2u8nEDsq74w==
X-Google-Smtp-Source: AGHT+IHhKJ+YBVQRoNgue+AUFQL+4TfEg3/WtayhPp5D8vGPSkqz1ChJi9nn9z2kfDC4MeupM9TSig==
X-Received: by 2002:a05:600c:3108:b0:43b:d203:da18 with SMTP id
 5b1f17b1804b1-43c601e0777mr24341345e9.13.1741355299125; 
 Fri, 07 Mar 2025 05:48:19 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:14d3:5e00:ab55:e6a0:3a3d:9571])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43bd91338cesm70613345e9.7.2025.03.07.05.48.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Mar 2025 05:48:18 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: srinivasan.shanmugam@amd.com, amd-gfx@lists.freedesktop.org,
 alexander.deucher@amd.com
Subject: [PATCH 4/8] drm/amdgpu: rework how isolation is enforced v2
Date: Fri,  7 Mar 2025 14:48:12 +0100
Message-Id: <20250307134816.1422-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250307134816.1422-1-christian.koenig@amd.com>
References: <20250307134816.1422-1-christian.koenig@amd.com>
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
index 87062c1adcdf..f68a348dcec9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1211,9 +1211,15 @@ struct amdgpu_device {
 	bool                            debug_exp_resets;
 	bool                            debug_disable_gpu_ring_reset;
 
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
 
@@ -1499,6 +1505,9 @@ void amdgpu_device_pcie_port_wreg(struct amdgpu_device *adev,
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
index 337543ec615c..3fa7788b4e12 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -4272,6 +4272,11 @@ int amdgpu_device_init(struct amdgpu_device *adev,
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
@@ -4770,7 +4775,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 
 void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 {
-	int idx;
+	int i, idx;
 	bool px;
 
 	amdgpu_device_ip_fini(adev);
@@ -4778,6 +4783,11 @@ void amdgpu_device_fini_sw(struct amdgpu_device *adev)
 	amdgpu_ucode_release(&adev->firmware.gpu_info_fw);
 	adev->accel_working = false;
 	dma_fence_put(rcu_dereference_protected(adev->gang_submit, true));
+	for (i = 0; i < MAX_XCP; ++i) {
+		dma_fence_put(adev->isolation[i].spearhead);
+		amdgpu_sync_free(&adev->isolation[i].active);
+		amdgpu_sync_free(&adev->isolation[i].prev);
+	}
 
 	amdgpu_reset_fini(adev);
 
@@ -6913,6 +6923,92 @@ struct dma_fence *amdgpu_device_switch_gang(struct amdgpu_device *adev,
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
index 5537c8bfd227..1a6cfef4c071 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -360,17 +360,24 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_job,
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
@@ -383,9 +390,10 @@ amdgpu_job_prepare_job(struct drm_sched_job *sched_job,
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


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6AA3ECAAD8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 09:09:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 90D2D10ECFB;
	Fri, 16 Sep 2022 09:09:36 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20::336])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7209210ECFB
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 09:08:59 +0000 (UTC)
Received: by mail-wm1-x336.google.com with SMTP id
 az24-20020a05600c601800b003a842e4983cso15474331wmb.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 02:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=cChAXin4qR1DGl8xysRceaARTM+0RPT0ONJW3J/m/JE=;
 b=bE53ZG+4QNPvrPZdcA8Du04VPE3hJ4L+hits7zUhBsVuJnaYou3P6kOZ+7kaPfaiqQ
 lNkBypqEmnhCYeVjRPZXDEKlqQz7xk8HqV48mwYHwRWooiaPA1Sbhx8E10Kg+WTPMh0M
 Bn1PZU6W9fAOdys/qLTWQ9TB1XusX9S1losHiBCKgeGwbkYS20r2M0B0uJs+qedLWe0N
 /n5zQoRH+lNdpidvVX/auz4WT0uPLsetvye6Sp/ggiP2W8Ha7/JVaWdz4cqC6OfPkTgA
 blYetYKH/BuB52TtfQ8+17dyDYlU7Csy/5nR0kM1LyRwODFyH7WXEKbjjReUZgEb97N/
 xOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=cChAXin4qR1DGl8xysRceaARTM+0RPT0ONJW3J/m/JE=;
 b=c5/hHDFiKQv/tJBKOkniqPO0wQyByydU5QZK5HfOHNt5m/nZV6tmov7TnNsbUTGDac
 dNajH3yeywB6hbLi8hbBJl8PXKWzlLRimxj9jM8k62DT4LOl5lhKk48HJUrbn8oXWx3O
 l+mx4AFaId0POdFOd0AvBIaSN+elaGgUG59hPzj8CwVsWgZGxdhQfcBy268fLfiYmzkk
 dAPb9ik2NWFeYnblbwCMOmR4ND2i/MbvR1lBuYTRVY8pQd3VKYi8YdUEqmiXohrijVbS
 mUnDXhi6OOPPZOeWrVblV74BgAQwG9pJxVicLu7rvVRwWzwhnuONhYhHRS4RpC4DCt8j
 2BMw==
X-Gm-Message-State: ACrzQf3y0M0nmCLnFPpdmdChY2FL6syIchApcA0Grtd4KLDmzYteeVrt
 IUHxAVz5MiYSsigS4iQeTPvWvaZAscwU2w==
X-Google-Smtp-Source: AMsMyM4qdn5vVNTLevKmYk1Pa/Z5oXf9nkQWbdvOR+8eLKu/+wpONC7pxgs5dmQZOLV0IRI7ks8uYA==
X-Received: by 2002:a05:600c:1f06:b0:3b4:86e8:bd21 with SMTP id
 bd6-20020a05600c1f0600b003b486e8bd21mr2673652wmb.7.1663319337825; 
 Fri, 16 Sep 2022 02:08:57 -0700 (PDT)
Received: from able.fritz.box (p4fc20ebf.dip0.t-ipconnect.de. [79.194.14.191])
 by smtp.gmail.com with ESMTPSA id
 b12-20020adff24c000000b00226d1711276sm4604145wrp.1.2022.09.16.02.08.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Sep 2022 02:08:57 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Subject: [PATCH 8/8] drm/amdgpu: add gang submit frontend v5
Date: Fri, 16 Sep 2022 11:08:45 +0200
Message-Id: <20220916090845.3336-9-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220916090845.3336-1-christian.koenig@amd.com>
References: <20220916090845.3336-1-christian.koenig@amd.com>
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
Cc: bas@basnieuwenhuizen.nl,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 timur.kristof@gmail.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Allows submitting jobs as gang which needs to run on multiple engines at the
same time.

All members of the gang get the same implicit, explicit and VM dependencies. So
no gang member will start running until everything else is ready.

The last job is considered the gang leader (usually a submission to the GFX
ring) and used for signaling output dependencies.

Each job is remembered individually as user of a buffer object, so there is no
joining of work at the end.

v2: rebase and fix review comments from Andrey and Yogesh
v3: use READ instead of BOOKKEEP for now because of VM unmaps, set gang
    leader only when necessary
v4: fix order of pushing jobs and adding fences found by Trigger.
v5: fix job index calculation and adding IBs to jobs

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c |   1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     | 269 ++++++++++++++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h     |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c    |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h  |  12 +-
 5 files changed, 195 insertions(+), 99 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index 4f5bd96000ec..c7b1a2dfde13 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -686,6 +686,7 @@ int amdgpu_amdkfd_submit_ib(struct amdgpu_device *adev,
 	ib->length_dw = ib_len;
 	/* This works for NO_HWS. TODO: need to handle without knowing VMID */
 	job->vmid = vmid;
+	job->num_ibs = 1;
 
 	ret = amdgpu_ib_schedule(ring, 1, ib, job, &f);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 58088c663125..964052377991 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -64,11 +64,11 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
 	return 0;
 }
 
-static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
-			   struct drm_amdgpu_cs_chunk_ib *chunk_ib,
-			   unsigned int *num_ibs)
+static int amdgpu_cs_job_idx(struct amdgpu_cs_parser *p,
+			     struct drm_amdgpu_cs_chunk_ib *chunk_ib)
 {
 	struct drm_sched_entity *entity;
+	unsigned int i;
 	int r;
 
 	r = amdgpu_ctx_get_entity(p->ctx, chunk_ib->ip_type,
@@ -77,17 +77,38 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
 	if (r)
 		return r;
 
-	/* Abort if there is no run queue associated with this entity.
-	 * Possibly because of disabled HW IP*/
+	/*
+	 * Abort if there is no run queue associated with this entity.
+	 * Possibly because of disabled HW IP.
+	 */
 	if (entity->rq == NULL)
 		return -EINVAL;
 
-	/* Currently we don't support submitting to multiple entities */
-	if (p->entity && p->entity != entity)
+	/* Check if we can add this IB to some existing job */
+	for (i = 0; i < p->gang_size; ++i)
+		if (p->entities[i] == entity)
+			return i;
+
+	/* If not increase the gang size if possible */
+	if (i == AMDGPU_CS_GANG_SIZE)
 		return -EINVAL;
 
-	p->entity = entity;
-	++(*num_ibs);
+	p->entities[i] = entity;
+	p->gang_size = i + 1;
+	return i;
+}
+
+static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
+			   struct drm_amdgpu_cs_chunk_ib *chunk_ib,
+			   unsigned int *num_ibs)
+{
+	int r;
+
+	r = amdgpu_cs_job_idx(p, chunk_ib);
+	if (r < 0)
+		return r;
+
+	++(num_ibs[r]);
 	return 0;
 }
 
@@ -161,11 +182,12 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 			   union drm_amdgpu_cs *cs)
 {
 	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
+	unsigned int num_ibs[AMDGPU_CS_GANG_SIZE] = { };
 	struct amdgpu_vm *vm = &fpriv->vm;
 	uint64_t *chunk_array_user;
 	uint64_t *chunk_array;
-	unsigned size, num_ibs = 0;
 	uint32_t uf_offset = 0;
+	unsigned int size;
 	int ret;
 	int i;
 
@@ -228,7 +250,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 			if (size < sizeof(struct drm_amdgpu_cs_chunk_ib))
 				goto free_partial_kdata;
 
-			ret = amdgpu_cs_p1_ib(p, p->chunks[i].kdata, &num_ibs);
+			ret = amdgpu_cs_p1_ib(p, p->chunks[i].kdata, num_ibs);
 			if (ret)
 				goto free_partial_kdata;
 			break;
@@ -265,21 +287,28 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 		}
 	}
 
-	ret = amdgpu_job_alloc(p->adev, num_ibs, &p->job, vm);
-	if (ret)
-		goto free_all_kdata;
+	if (!p->gang_size)
+		return -EINVAL;
 
-	ret = drm_sched_job_init(&p->job->base, p->entity, &fpriv->vm);
-	if (ret)
-		goto free_all_kdata;
+	for (i = 0; i < p->gang_size; ++i) {
+		ret = amdgpu_job_alloc(p->adev, num_ibs[i], &p->jobs[i], vm);
+		if (ret)
+			goto free_all_kdata;
 
-	if (p->ctx->vram_lost_counter != p->job->vram_lost_counter) {
+		ret = drm_sched_job_init(&p->jobs[i]->base, p->entities[i],
+					 &fpriv->vm);
+		if (ret)
+			goto free_all_kdata;
+	}
+	p->gang_leader = p->jobs[p->gang_size - 1];
+
+	if (p->ctx->vram_lost_counter != p->gang_leader->vram_lost_counter) {
 		ret = -ECANCELED;
 		goto free_all_kdata;
 	}
 
 	if (p->uf_entry.tv.bo)
-		p->job->uf_addr = uf_offset;
+		p->gang_leader->uf_addr = uf_offset;
 	kvfree(chunk_array);
 
 	/* Use this opportunity to fill in task info for the vm */
@@ -303,17 +332,25 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 
 static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 			   struct amdgpu_cs_chunk *chunk,
-			   unsigned int *num_ibs,
 			   unsigned int *ce_preempt,
 			   unsigned int *de_preempt)
 {
 	struct drm_amdgpu_cs_chunk_ib *chunk_ib = chunk->kdata;
 	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
-	struct amdgpu_ring *ring = amdgpu_job_ring(p->job);
-	struct amdgpu_ib *ib = &p->job->ibs[*num_ibs];
 	struct amdgpu_vm *vm = &fpriv->vm;
+	struct amdgpu_ring *ring;
+	struct amdgpu_job *job;
+	struct amdgpu_ib *ib;
 	int r;
 
+	r = amdgpu_cs_job_idx(p, chunk_ib);
+	if (r < 0)
+		return r;
+
+	job = p->jobs[r];
+	ring = amdgpu_job_ring(job);
+	ib = &job->ibs[job->num_ibs++];
+
 	/* MM engine doesn't support user fences */
 	if (p->uf_entry.tv.bo && ring->funcs->no_user_fence)
 		return -EINVAL;
@@ -332,7 +369,7 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 	}
 
 	if (chunk_ib->flags & AMDGPU_IB_FLAG_PREAMBLE)
-		p->job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT;
+		job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT;
 
 	r =  amdgpu_ib_get(p->adev, vm, ring->funcs->parse_cs ?
 			   chunk_ib->ib_bytes : 0,
@@ -345,8 +382,6 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 	ib->gpu_addr = chunk_ib->va_start;
 	ib->length_dw = chunk_ib->ib_bytes / 4;
 	ib->flags = chunk_ib->flags;
-
-	(*num_ibs)++;
 	return 0;
 }
 
@@ -395,7 +430,7 @@ static int amdgpu_cs_p2_dependencies(struct amdgpu_cs_parser *p,
 			dma_fence_put(old);
 		}
 
-		r = amdgpu_sync_fence(&p->job->sync, fence);
+		r = amdgpu_sync_fence(&p->gang_leader->sync, fence);
 		dma_fence_put(fence);
 		if (r)
 			return r;
@@ -417,7 +452,7 @@ static int amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
 		return r;
 	}
 
-	r = amdgpu_sync_fence(&p->job->sync, fence);
+	r = amdgpu_sync_fence(&p->gang_leader->sync, fence);
 	dma_fence_put(fence);
 
 	return r;
@@ -540,7 +575,7 @@ static int amdgpu_cs_p2_syncobj_timeline_signal(struct amdgpu_cs_parser *p,
 
 static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p)
 {
-	unsigned int num_ibs = 0, ce_preempt = 0, de_preempt = 0;
+	unsigned int ce_preempt = 0, de_preempt = 0;
 	int i, r;
 
 	for (i = 0; i < p->nchunks; ++i) {
@@ -550,8 +585,7 @@ static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p)
 
 		switch (chunk->chunk_id) {
 		case AMDGPU_CHUNK_ID_IB:
-			r = amdgpu_cs_p2_ib(p, chunk, &num_ibs,
-					    &ce_preempt, &de_preempt);
+			r = amdgpu_cs_p2_ib(p, chunk, &ce_preempt, &de_preempt);
 			if (r)
 				return r;
 			break;
@@ -822,6 +856,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo_list_entry *e;
 	struct list_head duplicates;
+	unsigned int i;
 	int r;
 
 	INIT_LIST_HEAD(&p->validated);
@@ -905,16 +940,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		e->bo_va = amdgpu_vm_bo_find(vm, bo);
 	}
 
-	/* Move fence waiting after getting reservation lock of
-	 * PD root. Then there is no need on a ctx mutex lock.
-	 */
-	r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entity);
-	if (unlikely(r != 0)) {
-		if (r != -ERESTARTSYS)
-			DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
-		goto error_validate;
-	}
-
 	amdgpu_cs_get_threshold_for_moves(p->adev, &p->bytes_moved_threshold,
 					  &p->bytes_moved_vis_threshold);
 	p->bytes_moved = 0;
@@ -942,13 +967,16 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		if (r)
 			goto error_validate;
 
-		p->job->uf_addr += amdgpu_bo_gpu_offset(uf);
+		p->gang_leader->uf_addr += amdgpu_bo_gpu_offset(uf);
 	}
 
 	amdgpu_cs_report_moved_bytes(p->adev, p->bytes_moved,
 				     p->bytes_moved_vis);
-	amdgpu_job_set_resources(p->job, p->bo_list->gds_obj,
-				 p->bo_list->gws_obj, p->bo_list->oa_obj);
+
+	for (i = 0; i < p->gang_size; ++i)
+		amdgpu_job_set_resources(p->jobs[i], p->bo_list->gds_obj,
+					 p->bo_list->gws_obj,
+					 p->bo_list->oa_obj);
 	return 0;
 
 error_validate:
@@ -967,20 +995,24 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	return r;
 }
 
-static void trace_amdgpu_cs_ibs(struct amdgpu_cs_parser *parser)
+static void trace_amdgpu_cs_ibs(struct amdgpu_cs_parser *p)
 {
-	int i;
+	int i, j;
 
 	if (!trace_amdgpu_cs_enabled())
 		return;
 
-	for (i = 0; i < parser->job->num_ibs; i++)
-		trace_amdgpu_cs(parser, i);
+	for (i = 0; i < p->gang_size; ++i) {
+		struct amdgpu_job *job = p->jobs[i];
+
+		for (j = 0; j < job->num_ibs; ++j)
+			trace_amdgpu_cs(p, job, &job->ibs[j]);
+	}
 }
 
-static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p)
+static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p,
+			       struct amdgpu_job *job)
 {
-	struct amdgpu_job *job = p->job;
 	struct amdgpu_ring *ring = amdgpu_job_ring(job);
 	unsigned int i;
 	int r;
@@ -1021,12 +1053,12 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p)
 			memcpy(ib->ptr, kptr, ib->length_dw * 4);
 			amdgpu_bo_kunmap(aobj);
 
-			r = amdgpu_ring_parse_cs(ring, p, p->job, ib);
+			r = amdgpu_ring_parse_cs(ring, p, job, ib);
 			if (r)
 				return r;
 		} else {
 			ib->ptr = (uint32_t *)kptr;
-			r = amdgpu_ring_patch_cs_in_place(ring, p, p->job, ib);
+			r = amdgpu_ring_patch_cs_in_place(ring, p, job, ib);
 			amdgpu_bo_kunmap(aobj);
 			if (r)
 				return r;
@@ -1036,19 +1068,31 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p)
 	return 0;
 }
 
+static int amdgpu_cs_patch_jobs(struct amdgpu_cs_parser *p)
+{
+	unsigned int i;
+	int r;
+
+	for (i = 0; i < p->gang_size; ++i) {
+		r = amdgpu_cs_patch_ibs(p, p->jobs[i]);
+		if (r)
+			return r;
+	}
+	return 0;
+}
+
 static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 {
 	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
+	struct amdgpu_job *job = p->gang_leader;
 	struct amdgpu_device *adev = p->adev;
 	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo_list_entry *e;
 	struct amdgpu_bo_va *bo_va;
 	struct amdgpu_bo *bo;
+	unsigned int i;
 	int r;
 
-	if (!p->job->vm)
-		return 0;
-
 	r = amdgpu_vm_clear_freed(adev, vm, NULL);
 	if (r)
 		return r;
@@ -1057,7 +1101,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	r = amdgpu_sync_fence(&p->job->sync, fpriv->prt_va->last_pt_update);
+	r = amdgpu_sync_fence(&job->sync, fpriv->prt_va->last_pt_update);
 	if (r)
 		return r;
 
@@ -1068,7 +1112,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		if (r)
 			return r;
 
-		r = amdgpu_sync_fence(&p->job->sync, bo_va->last_pt_update);
+		r = amdgpu_sync_fence(&job->sync, bo_va->last_pt_update);
 		if (r)
 			return r;
 	}
@@ -1087,7 +1131,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		if (r)
 			return r;
 
-		r = amdgpu_sync_fence(&p->job->sync, bo_va->last_pt_update);
+		r = amdgpu_sync_fence(&job->sync, bo_va->last_pt_update);
 		if (r)
 			return r;
 	}
@@ -1100,11 +1144,18 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	r = amdgpu_sync_fence(&p->job->sync, vm->last_update);
+	r = amdgpu_sync_fence(&job->sync, vm->last_update);
 	if (r)
 		return r;
 
-	p->job->vm_pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
+	for (i = 0; i < p->gang_size; ++i) {
+		job = p->jobs[i];
+
+		if (!job->vm)
+			continue;
+
+		job->vm_pd_addr = amdgpu_gmc_pd_addr(vm->root.bo);
+	}
 
 	if (amdgpu_vm_debug) {
 		/* Invalidate all BOs to test for userspace bugs */
@@ -1125,7 +1176,9 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 {
 	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
+	struct amdgpu_job *leader = p->gang_leader;
 	struct amdgpu_bo_list_entry *e;
+	unsigned int i;
 	int r;
 
 	list_for_each_entry(e, &p->validated, tv.head) {
@@ -1135,12 +1188,23 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 
 		sync_mode = amdgpu_bo_explicit_sync(bo) ?
 			AMDGPU_SYNC_EXPLICIT : AMDGPU_SYNC_NE_OWNER;
-		r = amdgpu_sync_resv(p->adev, &p->job->sync, resv, sync_mode,
+		r = amdgpu_sync_resv(p->adev, &leader->sync, resv, sync_mode,
 				     &fpriv->vm);
 		if (r)
 			return r;
 	}
-	return 0;
+
+	for (i = 0; i < p->gang_size - 1; ++i) {
+		r = amdgpu_sync_clone(&leader->sync, &p->jobs[i]->sync);
+		if (r)
+			return r;
+	}
+
+	r = amdgpu_ctx_wait_prev_fence(p->ctx, p->entities[p->gang_size - 1]);
+	if (r && r != -ERESTARTSYS)
+		DRM_ERROR("amdgpu_ctx_wait_prev_fence failed.\n");
+
+	return r;
 }
 
 static void amdgpu_cs_post_dependencies(struct amdgpu_cs_parser *p)
@@ -1164,16 +1228,28 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 			    union drm_amdgpu_cs *cs)
 {
 	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
-	struct drm_sched_entity *entity = p->entity;
+	struct amdgpu_job *leader = p->gang_leader;
 	struct amdgpu_bo_list_entry *e;
-	struct amdgpu_job *job;
+	unsigned int i;
 	uint64_t seq;
 	int r;
 
-	job = p->job;
-	p->job = NULL;
+	for (i = 0; i < p->gang_size; ++i)
+		drm_sched_job_arm(&p->jobs[i]->base);
 
-	drm_sched_job_arm(&job->base);
+	for (i = 0; i < (p->gang_size - 1); ++i) {
+		struct dma_fence *fence;
+
+		fence = &p->jobs[i]->base.s_fence->scheduled;
+		r = amdgpu_sync_fence(&leader->sync, fence);
+		if (r)
+			goto error_cleanup;
+	}
+
+	if (p->gang_size > 1) {
+		for (i = 0; i < p->gang_size; ++i)
+			amdgpu_job_set_gang_leader(p->jobs[i], leader);
+	}
 
 	/* No memory allocation is allowed while holding the notifier lock.
 	 * The lock is held until amdgpu_cs_submit is finished and fence is
@@ -1191,45 +1267,57 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	}
 	if (r) {
 		r = -EAGAIN;
-		goto error_abort;
+		goto error_unlock;
 	}
 
-	p->fence = dma_fence_get(&job->base.s_fence->finished);
+	p->fence = dma_fence_get(&leader->base.s_fence->finished);
+	list_for_each_entry(e, &p->validated, tv.head) {
+
+		/* Everybody except for the gang leader uses READ */
+		for (i = 0; i < (p->gang_size - 1); ++i) {
+			dma_resv_add_fence(e->tv.bo->base.resv,
+					   &p->jobs[i]->base.s_fence->finished,
+					   DMA_RESV_USAGE_READ);
+		}
+
+		/* The gang leader as remembered as writer */
+		e->tv.num_shared = 0;
+	}
 
-	seq = amdgpu_ctx_add_fence(p->ctx, entity, p->fence);
+	seq = amdgpu_ctx_add_fence(p->ctx, p->entities[p->gang_size - 1],
+				   p->fence);
 	amdgpu_cs_post_dependencies(p);
 
-	if ((job->preamble_status & AMDGPU_PREAMBLE_IB_PRESENT) &&
+	if ((leader->preamble_status & AMDGPU_PREAMBLE_IB_PRESENT) &&
 	    !p->ctx->preamble_presented) {
-		job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT_FIRST;
+		leader->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT_FIRST;
 		p->ctx->preamble_presented = true;
 	}
 
 	cs->out.handle = seq;
-	job->uf_sequence = seq;
+	leader->uf_sequence = seq;
 
-	amdgpu_job_free_resources(job);
-
-	trace_amdgpu_cs_ioctl(job);
 	amdgpu_vm_bo_trace_cs(&fpriv->vm, &p->ticket);
-	drm_sched_entity_push_job(&job->base);
+	for (i = 0; i < p->gang_size; ++i) {
+		amdgpu_job_free_resources(p->jobs[i]);
+		trace_amdgpu_cs_ioctl(p->jobs[i]);
+		drm_sched_entity_push_job(&p->jobs[i]->base);
+		p->jobs[i] = NULL;
+	}
 
 	amdgpu_vm_move_to_lru_tail(p->adev, &fpriv->vm);
-
-	/* Make sure all BOs are remembered as writers */
-	amdgpu_bo_list_for_each_entry(e, p->bo_list)
-		e->tv.num_shared = 0;
-
 	ttm_eu_fence_buffer_objects(&p->ticket, &p->validated, p->fence);
+
 	mutex_unlock(&p->adev->notifier_lock);
 	mutex_unlock(&p->bo_list->bo_list_mutex);
-
 	return 0;
 
-error_abort:
-	drm_sched_job_cleanup(&job->base);
+error_unlock:
 	mutex_unlock(&p->adev->notifier_lock);
-	amdgpu_job_free(job);
+
+error_cleanup:
+	for (i = 0; i < p->gang_size; ++i)
+		drm_sched_job_cleanup(&p->jobs[i]->base);
 	return r;
 }
 
@@ -1246,17 +1334,18 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
 
 	dma_fence_put(parser->fence);
 
-	if (parser->ctx) {
+	if (parser->ctx)
 		amdgpu_ctx_put(parser->ctx);
-	}
 	if (parser->bo_list)
 		amdgpu_bo_list_put(parser->bo_list);
 
 	for (i = 0; i < parser->nchunks; i++)
 		kvfree(parser->chunks[i].kdata);
 	kvfree(parser->chunks);
-	if (parser->job)
-		amdgpu_job_free(parser->job);
+	for (i = 0; i < parser->gang_size; ++i) {
+		if (parser->jobs[i])
+			amdgpu_job_free(parser->jobs[i]);
+	}
 	if (parser->uf_entry.tv.bo) {
 		struct amdgpu_bo *uf = ttm_to_amdgpu_bo(parser->uf_entry.tv.bo);
 
@@ -1300,7 +1389,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		goto error_fini;
 	}
 
-	r = amdgpu_cs_patch_ibs(&parser);
+	r = amdgpu_cs_patch_jobs(&parser);
 	if (r)
 		goto error_backoff;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
index 30ecc4917f81..cbaa19b2b8a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
@@ -27,6 +27,8 @@
 #include "amdgpu_bo_list.h"
 #include "amdgpu_ring.h"
 
+#define AMDGPU_CS_GANG_SIZE	4
+
 struct amdgpu_bo_va_mapping;
 
 struct amdgpu_cs_chunk {
@@ -50,9 +52,11 @@ struct amdgpu_cs_parser {
 	unsigned		nchunks;
 	struct amdgpu_cs_chunk	*chunks;
 
-	/* scheduler job object */
-	struct amdgpu_job	*job;
-	struct drm_sched_entity	*entity;
+	/* scheduler job objects */
+	unsigned int		gang_size;
+	struct drm_sched_entity	*entities[AMDGPU_CS_GANG_SIZE];
+	struct amdgpu_job	*jobs[AMDGPU_CS_GANG_SIZE];
+	struct amdgpu_job	*gang_leader;
 
 	/* buffer objects */
 	struct ww_acquire_ctx		ticket;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index cfbe19cfe9af..46c99331d7f1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -105,7 +105,6 @@ int amdgpu_job_alloc(struct amdgpu_device *adev, unsigned num_ibs,
 	 */
 	(*job)->base.sched = &adev->rings[0]->sched;
 	(*job)->vm = vm;
-	(*job)->num_ibs = num_ibs;
 
 	amdgpu_sync_create(&(*job)->sync);
 	amdgpu_sync_create(&(*job)->sched_sync);
@@ -125,6 +124,7 @@ int amdgpu_job_alloc_with_ib(struct amdgpu_device *adev, unsigned size,
 	if (r)
 		return r;
 
+	(*job)->num_ibs = 1;
 	r = amdgpu_ib_get(adev, NULL, size, pool_type, &(*job)->ibs[0]);
 	if (r)
 		kfree(*job);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
index 06dfcf297a8d..5e6ddc7e101c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h
@@ -140,8 +140,10 @@ TRACE_EVENT(amdgpu_bo_create,
 );
 
 TRACE_EVENT(amdgpu_cs,
-	    TP_PROTO(struct amdgpu_cs_parser *p, int i),
-	    TP_ARGS(p, i),
+	    TP_PROTO(struct amdgpu_cs_parser *p,
+		     struct amdgpu_job *job,
+		     struct amdgpu_ib *ib),
+	    TP_ARGS(p, job, ib),
 	    TP_STRUCT__entry(
 			     __field(struct amdgpu_bo_list *, bo_list)
 			     __field(u32, ring)
@@ -151,10 +153,10 @@ TRACE_EVENT(amdgpu_cs,
 
 	    TP_fast_assign(
 			   __entry->bo_list = p->bo_list;
-			   __entry->ring = to_amdgpu_ring(p->entity->rq->sched)->idx;
-			   __entry->dw = p->job->ibs[i].length_dw;
+			   __entry->ring = to_amdgpu_ring(job->base.sched)->idx;
+			   __entry->dw = ib->length_dw;
 			   __entry->fences = amdgpu_fence_count_emitted(
-				to_amdgpu_ring(p->entity->rq->sched));
+				to_amdgpu_ring(job->base.sched));
 			   ),
 	    TP_printk("bo_list=%p, ring=%u, dw=%u, fences=%u",
 		      __entry->bo_list, __entry->ring, __entry->dw,
-- 
2.25.1


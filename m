Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667BDECAAD3
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Sep 2022 12:33:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B294B10E387;
	Mon,  5 Sep 2022 12:32:59 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DB7A10E358
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Sep 2022 12:32:46 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id se27so16787938ejb.8
 for <amd-gfx@lists.freedesktop.org>; Mon, 05 Sep 2022 05:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=C5ZzQ6IIhfek6gBdw6HelyjIsJZv+nAhHEgZXO+nNX4=;
 b=BIngJVf60+lU6Uo3lXaIlvNS8CgI3aLuwdkvEKSKZBl9D72ayM3AvXwLJcaDaokuHR
 R9hRCCNpqbs1iOpVC+gJPXE4XtS+u0WyepR5Fy0S8TwtR2FX50a4rx/r2iyv3SIgZMA7
 t1VshbE7gbtuQuGODgIg9y0FC251FUk+5W/kaMOC9v2ng5KRsuw+X6Y25wEc4RnSz6ty
 wFH2ZySvvOOQInlU8BCPJ+jOH4n06dzJSfQaz16ur/fPBZLIcmxdiQKfTHMlmL1ongVJ
 tvn4nBZLORg7xxqjOd7xF7SKN2gm0G5/evXaNnZ7I0ctHb86lg4g6pqhDNLOe+OFJKip
 wXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=C5ZzQ6IIhfek6gBdw6HelyjIsJZv+nAhHEgZXO+nNX4=;
 b=agq9TImi8jxlKU5RnAyKpZBLSCmgpM9v/BuQii1q+RGad0A/4GkLq6XgWMgLnPrbZr
 WM2D2SWbrEItS7hx1zsjGNiLsBvGIjbnInkNPz6/+gx3ex2FIUDLKlCnhgQlJYkhmLEf
 iReRr73foG2YZOfsKo/fe0Uft4DTYyXnsNbI5gNfX9VR2kfM8rTbArA0gbgiL5+96Pg1
 ZrqFWaj2BcnVEEMTNLa2pX2cCQzGa+V0yAso+UvFmpyjTCazyvUI24TkfVZwt9ppGcae
 /bLir8lBFtK6FK4VJMbdJu7vTm4kGOaOeqgo9hA+LUtj5F3nLD4XSFAI4eAuCo63aQfQ
 LaVA==
X-Gm-Message-State: ACgBeo3XnWILXl0zcGlhI+wIC9o9/2rs+uA6l3x+k9YB2HGmaWU4t0Tj
 QDceBM+eytwFZ9BnzqD79FajINdp4fQ7Jg==
X-Google-Smtp-Source: AA6agR6UD17DTqtcDKuirBQk8quvAXdPE7uQyIlKDYV20BR1CorfidZO1mV2mw87k65AjxCNrJLVug==
X-Received: by 2002:a17:907:2e0d:b0:741:a3ec:7f92 with SMTP id
 ig13-20020a1709072e0d00b00741a3ec7f92mr23326637ejc.309.1662381164453; 
 Mon, 05 Sep 2022 05:32:44 -0700 (PDT)
Received: from able.fritz.box (p4fc20f4e.dip0.t-ipconnect.de. [79.194.15.78])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a17090632c600b0073c0b87ba34sm4970341ejk.198.2022.09.05.05.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Sep 2022 05:32:43 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	Ruijing.Dong@amd.com
Subject: [PATCH 11/12] drm/amdgpu: add gang submit frontend v4
Date: Mon,  5 Sep 2022 14:32:31 +0200
Message-Id: <20220905123232.2809-11-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220905123232.2809-1-christian.koenig@amd.com>
References: <20220905123232.2809-1-christian.koenig@amd.com>
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
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
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

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c    | 258 ++++++++++++++--------
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h    |  10 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_trace.h |  12 +-
 3 files changed, 184 insertions(+), 96 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 72147032bda9..294dba095aad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -69,6 +69,7 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
 			   unsigned int *num_ibs)
 {
 	struct drm_sched_entity *entity;
+	unsigned int i;
 	int r;
 
 	r = amdgpu_ctx_get_entity(p->ctx, chunk_ib->ip_type,
@@ -77,17 +78,28 @@ static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
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
+	for (i = 0; i < p->gang_size; ++i) {
+		if (p->entities[i] == entity)
+			goto found;
+	}
+
+	/* If not increase the gang size if possible */
+	if (i == AMDGPU_CS_GANG_SIZE)
 		return -EINVAL;
 
-	p->entity = entity;
-	++(*num_ibs);
+	p->entities[i] = entity;
+	p->gang_size = i + 1;
+
+found:
+	++(num_ibs[i]);
 	return 0;
 }
 
@@ -161,11 +173,12 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
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
 
@@ -228,7 +241,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 			if (size < sizeof(struct drm_amdgpu_cs_chunk_ib))
 				goto free_partial_kdata;
 
-			ret = amdgpu_cs_p1_ib(p, p->chunks[i].kdata, &num_ibs);
+			ret = amdgpu_cs_p1_ib(p, p->chunks[i].kdata, num_ibs);
 			if (ret)
 				goto free_partial_kdata;
 			break;
@@ -265,21 +278,28 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
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
+
+		ret = drm_sched_job_init(&p->jobs[i]->base, p->entities[i],
+					 &fpriv->vm);
+		if (ret)
+			goto free_all_kdata;
+	}
+	p->gang_leader = p->jobs[p->gang_size - 1];
 
-	if (p->ctx->vram_lost_counter != p->job->vram_lost_counter) {
+	if (p->ctx->vram_lost_counter != p->gang_leader->vram_lost_counter) {
 		ret = -ECANCELED;
 		goto free_all_kdata;
 	}
 
 	if (p->uf_entry.tv.bo)
-		p->job->uf_addr = uf_offset;
+		p->gang_leader->uf_addr = uf_offset;
 	kvfree(chunk_array);
 
 	/* Use this opportunity to fill in task info for the vm */
@@ -301,21 +321,18 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	return ret;
 }
 
-static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
-			   struct amdgpu_cs_chunk *chunk,
-			   unsigned int *num_ibs,
-			   unsigned int *ce_preempt,
-			   unsigned int *de_preempt)
+static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p, struct amdgpu_job *job,
+			   struct amdgpu_ib *ib, struct amdgpu_cs_chunk *chunk,
+			   unsigned int *ce_preempt, unsigned int *de_preempt)
 {
 	struct drm_amdgpu_cs_chunk_ib *chunk_ib = chunk->kdata;
 	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
-	struct amdgpu_ring *ring = amdgpu_job_ring(p->job);
-	struct amdgpu_ib *ib = &p->job->ibs[*num_ibs];
+	struct amdgpu_ring *ring = amdgpu_job_ring(job);
 	struct amdgpu_vm *vm = &fpriv->vm;
 	int r;
 
 	/* MM engine doesn't support user fences */
-	if (p->job->uf_addr && ring->funcs->no_user_fence)
+	if (job->uf_addr && ring->funcs->no_user_fence)
 		return -EINVAL;
 
 	if (chunk_ib->ip_type == AMDGPU_HW_IP_GFX &&
@@ -332,7 +349,7 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 	}
 
 	if (chunk_ib->flags & AMDGPU_IB_FLAG_PREAMBLE)
-		p->job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT;
+		job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT;
 
 	r =  amdgpu_ib_get(p->adev, vm, ring->funcs->parse_cs ?
 			   chunk_ib->ib_bytes : 0,
@@ -345,8 +362,6 @@ static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
 	ib->gpu_addr = chunk_ib->va_start;
 	ib->length_dw = chunk_ib->ib_bytes / 4;
 	ib->flags = chunk_ib->flags;
-
-	(*num_ibs)++;
 	return 0;
 }
 
@@ -395,7 +410,7 @@ static int amdgpu_cs_p2_dependencies(struct amdgpu_cs_parser *p,
 			dma_fence_put(old);
 		}
 
-		r = amdgpu_sync_fence(&p->job->sync, fence);
+		r = amdgpu_sync_fence(&p->gang_leader->sync, fence);
 		dma_fence_put(fence);
 		if (r)
 			return r;
@@ -417,7 +432,7 @@ static int amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
 		return r;
 	}
 
-	r = amdgpu_sync_fence(&p->job->sync, fence);
+	r = amdgpu_sync_fence(&p->gang_leader->sync, fence);
 	dma_fence_put(fence);
 
 	return r;
@@ -540,20 +555,30 @@ static int amdgpu_cs_p2_syncobj_timeline_signal(struct amdgpu_cs_parser *p,
 
 static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p)
 {
-	unsigned int num_ibs = 0, ce_preempt = 0, de_preempt = 0;
+	unsigned int ce_preempt = 0, de_preempt = 0;
+	unsigned int job_idx = 0, ib_idx = 0;
 	int i, r;
 
 	for (i = 0; i < p->nchunks; ++i) {
 		struct amdgpu_cs_chunk *chunk;
+		struct amdgpu_job *job;
 
 		chunk = &p->chunks[i];
 
 		switch (chunk->chunk_id) {
 		case AMDGPU_CHUNK_ID_IB:
-			r = amdgpu_cs_p2_ib(p, chunk, &num_ibs,
+			job = p->jobs[job_idx];
+			r = amdgpu_cs_p2_ib(p, job, &job->ibs[ib_idx], chunk,
 					    &ce_preempt, &de_preempt);
 			if (r)
 				return r;
+
+			if (++ib_idx == job->num_ibs) {
+				++job_idx;
+				ib_idx = 0;
+				ce_preempt = 0;
+				de_preempt = 0;
+			}
 			break;
 		case AMDGPU_CHUNK_ID_DEPENDENCIES:
 		case AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES:
@@ -824,6 +849,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	struct amdgpu_vm *vm = &fpriv->vm;
 	struct amdgpu_bo_list_entry *e;
 	struct list_head duplicates;
+	unsigned int i;
 	int r;
 
 	INIT_LIST_HEAD(&p->validated);
@@ -907,16 +933,6 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
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
@@ -940,8 +956,10 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 	amdgpu_cs_report_moved_bytes(p->adev, p->bytes_moved,
 				     p->bytes_moved_vis);
 
-	amdgpu_job_set_resources(p->job, p->bo_list->gds_obj,
-				 p->bo_list->gws_obj, p->bo_list->oa_obj);
+	for (i = 0; i < p->gang_size; ++i)
+		amdgpu_job_set_resources(p->jobs[i], p->bo_list->gds_obj,
+					 p->bo_list->gws_obj,
+					 p->bo_list->oa_obj);
 
 	if (p->uf_entry.tv.bo) {
 		struct amdgpu_bo *uf = ttm_to_amdgpu_bo(p->uf_entry.tv.bo);
@@ -950,7 +968,7 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
 		if (r)
 			goto error_validate;
 
-		p->job->uf_addr += amdgpu_bo_gpu_offset(uf);
+		p->gang_leader->uf_addr += amdgpu_bo_gpu_offset(uf);
 	}
 	return 0;
 
@@ -971,20 +989,24 @@ static int amdgpu_cs_parser_bos(struct amdgpu_cs_parser *p,
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
@@ -1025,12 +1047,12 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p)
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
@@ -1040,14 +1062,29 @@ static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p)
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
 
 	r = amdgpu_vm_clear_freed(adev, vm, NULL);
@@ -1058,7 +1095,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 	if (r)
 		return r;
 
-	r = amdgpu_sync_fence(&p->job->sync, fpriv->prt_va->last_pt_update);
+	r = amdgpu_sync_fence(&job->sync, fpriv->prt_va->last_pt_update);
 	if (r)
 		return r;
 
@@ -1068,7 +1105,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		if (r)
 			return r;
 
-		r = amdgpu_sync_fence(&p->job->sync, bo_va->last_pt_update);
+		r = amdgpu_sync_fence(&job->sync, bo_va->last_pt_update);
 		if (r)
 			return r;
 	}
@@ -1087,7 +1124,7 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 		if (r)
 			return r;
 
-		r = amdgpu_sync_fence(&p->job->sync, bo_va->last_pt_update);
+		r = amdgpu_sync_fence(&job->sync, bo_va->last_pt_update);
 		if (r)
 			return r;
 	}
@@ -1100,11 +1137,18 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
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
@@ -1125,7 +1169,9 @@ static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 {
 	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
+	struct amdgpu_job *leader = p->gang_leader;
 	struct amdgpu_bo_list_entry *e;
+	unsigned int i;
 	int r;
 
 	list_for_each_entry(e, &p->validated, tv.head) {
@@ -1135,12 +1181,23 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 
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
@@ -1164,16 +1221,28 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
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
+
+	for (i = 0; i < (p->gang_size - 1); ++i) {
+		struct dma_fence *fence;
+
+		fence = &p->jobs[i]->base.s_fence->scheduled;
+		r = amdgpu_sync_fence(&leader->sync, fence);
+		if (r)
+			goto error_cleanup;
+	}
 
-	drm_sched_job_arm(&job->base);
+	if (p->gang_size > 1) {
+		for (i = 0; i < p->gang_size; ++i)
+			amdgpu_job_set_gang_leader(p->jobs[i], leader);
+	}
 
 	/* No memory allocation is allowed while holding the notifier lock.
 	 * The lock is held until amdgpu_cs_submit is finished and fence is
@@ -1191,45 +1260,57 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	}
 	if (r) {
 		r = -EAGAIN;
-		goto error_abort;
+		goto error_unlock;
 	}
 
-	p->fence = dma_fence_get(&job->base.s_fence->finished);
+	p->fence = dma_fence_get(&leader->base.s_fence->finished);
+	list_for_each_entry(e, &p->validated, tv.head) {
 
-	seq = amdgpu_ctx_add_fence(p->ctx, entity, p->fence);
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
+
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
 
@@ -1246,17 +1327,18 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
 
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
 
@@ -1300,7 +1382,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 		goto error_fini;
 	}
 
-	r = amdgpu_cs_patch_ibs(&parser);
+	r = amdgpu_cs_patch_jobs(&parser);
 	if (r)
 		goto error_backoff;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.h
index 652b5593499f..cbaa19b2b8a3 100644
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
-	struct drm_sched_entity	*entity;
-	struct amdgpu_job	*job;
+	/* scheduler job objects */
+	unsigned int		gang_size;
+	struct drm_sched_entity	*entities[AMDGPU_CS_GANG_SIZE];
+	struct amdgpu_job	*jobs[AMDGPU_CS_GANG_SIZE];
+	struct amdgpu_job	*gang_leader;
 
 	/* buffer objects */
 	struct ww_acquire_ctx		ticket;
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


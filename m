Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2796ECAAD8
	for <amd-gfx@archiver.kernel.org>; Fri, 16 Sep 2022 09:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6334110ECFE;
	Fri, 16 Sep 2022 09:09:06 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C0FF10ECF8
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 09:08:51 +0000 (UTC)
Received: by mail-wr1-x42f.google.com with SMTP id t7so34931983wrm.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 16 Sep 2022 02:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=Hni6seQblpQadpINpW2WyP2O8dbo5XbFPyMKv4nfsKI=;
 b=qorjo6UQXhDQDLjyTDmvnFRXrgEOX9K4+5DIEceNzFjVHriAzE1xnvBGJUv6q8M9Hm
 BMbkRNzyEf1uJ3Pu9awKaXwcmN5ZhbdMXSQAFLZpFLHbbnM3R/ITjSPqr+o6Cm44mKp+
 w7DW/HN9/PCfif1zPIc2kFQRXfuH4hXOzGLUP3QnDlVmny8U+YGeBp7ac2pQSuKD85ma
 r4P/PT8Qwd8XeLN6Lzi9Aj5pnnjhyqzgalnpX+/vBXOF3mNqBrsOMMp7bslHS14QsQau
 NeIGMFAvmtFch1VKon0sBmNHeqGrCt6FajYz/3JH7fSHsWALb9WS74yQ6A7tBuaW1JfI
 OMuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=Hni6seQblpQadpINpW2WyP2O8dbo5XbFPyMKv4nfsKI=;
 b=caxk66mmaMDMrujPlsJbegblRI8pYUiWZAJAoHo0xoTcKC0QqRinXS6BT1zftNaLIh
 1r9u3aLzSQAbF+OgwJExlhvHVKSU8lWHX3mlxgSpSIy8Dl2hSsPpSRi2oPWei51g+Dsx
 jwmjHxHWQMKR5dEdE0IAvHrS7iPhlhRsjR4y88DRLejd4C+Xiglt9nEGRK8AcS0HefCU
 cgVOvQfpis3qi8768dNvXdW3NlbiV3gYR94fMXvKwfO1H6ORTCXWG6kQmA9dTut81Q92
 5a5mwz+Vk/lKo0mr+NoETsmcl0xeDitutuA6tBefC+zhn3QcioDf1ADhqoJe63w5D8fb
 DlLQ==
X-Gm-Message-State: ACrzQf0hNRBCxuQ9MP0DzWU7TM511JCbHkk4LUm1Dc+0v7+mncL2YQOw
 517xIyLNChMVJfjpG3pWfrgTT5jjWAI=
X-Google-Smtp-Source: AMsMyM7A2njTGU0szkhCCQOe868wAwjHXOzzzHvJ8MwOEf+uOL1J1UUQ+2cD9eg43lyVsHB57PW/Wg==
X-Received: by 2002:a5d:4742:0:b0:22a:3a88:d9e6 with SMTP id
 o2-20020a5d4742000000b0022a3a88d9e6mr2269798wrs.438.1663319329938; 
 Fri, 16 Sep 2022 02:08:49 -0700 (PDT)
Received: from able.fritz.box (p4fc20ebf.dip0.t-ipconnect.de. [79.194.14.191])
 by smtp.gmail.com with ESMTPSA id
 b12-20020adff24c000000b00226d1711276sm4604145wrp.1.2022.09.16.02.08.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Sep 2022 02:08:49 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org,
	alexander.deucher@amd.com
Subject: [PATCH 1/8] drm/amdgpu: cleanup CS pass2 v5
Date: Fri, 16 Sep 2022 11:08:38 +0200
Message-Id: <20220916090845.3336-2-christian.koenig@amd.com>
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

Cleanup the coding style and function names to represent the data
they process for pass2 as well.

Go over the chunks only twice now instead of multiple times.

v2: fix job initialisation order and use correct scheduler instance
v3: try to move all functional changes into a separate patch.
v4: separate reordering, pass1 and pass2 change
v5: fix va_start calculation

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 352 ++++++++++++-------------
 1 file changed, 168 insertions(+), 184 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index e104d7ef3c3d..c04073f4ead5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -278,93 +278,84 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 	return ret;
 }
 
-static int amdgpu_cs_ib_fill(struct amdgpu_device *adev,
-			     struct amdgpu_cs_parser *parser)
+static int amdgpu_cs_p2_ib(struct amdgpu_cs_parser *p,
+			   struct amdgpu_cs_chunk *chunk,
+			   unsigned int *num_ibs,
+			   unsigned int *ce_preempt,
+			   unsigned int *de_preempt)
 {
-	struct amdgpu_fpriv *fpriv = parser->filp->driver_priv;
+	struct drm_amdgpu_cs_chunk_ib *chunk_ib = chunk->kdata;
+	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
+	struct amdgpu_ib *ib = &p->job->ibs[*num_ibs];
 	struct amdgpu_vm *vm = &fpriv->vm;
-	int r, ce_preempt = 0, de_preempt = 0;
+	struct drm_sched_entity *entity;
 	struct amdgpu_ring *ring;
-	int i, j;
-
-	for (i = 0, j = 0; i < parser->nchunks && j < parser->job->num_ibs; i++) {
-		struct amdgpu_cs_chunk *chunk;
-		struct amdgpu_ib *ib;
-		struct drm_amdgpu_cs_chunk_ib *chunk_ib;
-		struct drm_sched_entity *entity;
-
-		chunk = &parser->chunks[i];
-		ib = &parser->job->ibs[j];
-		chunk_ib = (struct drm_amdgpu_cs_chunk_ib *)chunk->kdata;
+	int r;
 
-		if (chunk->chunk_id != AMDGPU_CHUNK_ID_IB)
-			continue;
+	r = amdgpu_ctx_get_entity(p->ctx, chunk_ib->ip_type,
+				  chunk_ib->ip_instance,
+				  chunk_ib->ring, &entity);
+	if (r)
+		return r;
 
-		if (chunk_ib->ip_type == AMDGPU_HW_IP_GFX &&
-		    chunk_ib->flags & AMDGPU_IB_FLAG_PREEMPT) {
-			if (chunk_ib->flags & AMDGPU_IB_FLAG_CE)
-				ce_preempt++;
-			else
-				de_preempt++;
+	/*
+	 * Abort if there is no run queue associated with this entity.
+	 * Possibly because of disabled HW IP.
+	 */
+	if (entity->rq == NULL)
+		return -EINVAL;
 
-			/* each GFX command submit allows 0 or 1 IB preemptible for CE & DE */
-			if (ce_preempt > 1 || de_preempt > 1)
-				return -EINVAL;
-		}
+	/* Currently we don't support submitting to multiple entities */
+	if (p->entity && p->entity != entity)
+		return -EINVAL;
 
-		r = amdgpu_ctx_get_entity(parser->ctx, chunk_ib->ip_type,
-					  chunk_ib->ip_instance, chunk_ib->ring,
-					  &entity);
-		if (r)
-			return r;
+	p->entity = entity;
 
-		if (chunk_ib->flags & AMDGPU_IB_FLAG_PREAMBLE)
-			parser->job->preamble_status |=
-				AMDGPU_PREAMBLE_IB_PRESENT;
+	ring = to_amdgpu_ring(entity->rq->sched);
+	/* MM engine doesn't support user fences */
+	if (p->job->uf_addr && ring->funcs->no_user_fence)
+		return -EINVAL;
 
-		if (parser->entity && parser->entity != entity)
-			return -EINVAL;
+	if (chunk_ib->ip_type == AMDGPU_HW_IP_GFX &&
+	    chunk_ib->flags & AMDGPU_IB_FLAG_PREEMPT) {
+		if (chunk_ib->flags & AMDGPU_IB_FLAG_CE)
+			(*ce_preempt)++;
+		else
+			(*de_preempt)++;
 
-		/* Return if there is no run queue associated with this entity.
-		 * Possibly because of disabled HW IP*/
-		if (entity->rq == NULL)
+		/* Each GFX command submit allows only 1 IB max
+		 * preemptible for CE & DE */
+		if (*ce_preempt > 1 || *de_preempt > 1)
 			return -EINVAL;
+	}
 
-		parser->entity = entity;
-
-		ring = to_amdgpu_ring(entity->rq->sched);
-		r =  amdgpu_ib_get(adev, vm, ring->funcs->parse_cs ?
-				   chunk_ib->ib_bytes : 0,
-				   AMDGPU_IB_POOL_DELAYED, ib);
-		if (r) {
-			DRM_ERROR("Failed to get ib !\n");
-			return r;
-		}
-
-		ib->gpu_addr = chunk_ib->va_start;
-		ib->length_dw = chunk_ib->ib_bytes / 4;
-		ib->flags = chunk_ib->flags;
+	if (chunk_ib->flags & AMDGPU_IB_FLAG_PREAMBLE)
+		p->job->preamble_status |= AMDGPU_PREAMBLE_IB_PRESENT;
 
-		j++;
+	r =  amdgpu_ib_get(p->adev, vm, ring->funcs->parse_cs ?
+			   chunk_ib->ib_bytes : 0,
+			   AMDGPU_IB_POOL_DELAYED, ib);
+	if (r) {
+		DRM_ERROR("Failed to get ib !\n");
+		return r;
 	}
 
-	/* MM engine doesn't support user fences */
-	ring = to_amdgpu_ring(parser->entity->rq->sched);
-	if (parser->job->uf_addr && ring->funcs->no_user_fence)
-		return -EINVAL;
+	ib->gpu_addr = chunk_ib->va_start;
+	ib->length_dw = chunk_ib->ib_bytes / 4;
+	ib->flags = chunk_ib->flags;
 
+	(*num_ibs)++;
 	return 0;
 }
 
-static int amdgpu_cs_process_fence_dep(struct amdgpu_cs_parser *p,
-				       struct amdgpu_cs_chunk *chunk)
+static int amdgpu_cs_p2_dependencies(struct amdgpu_cs_parser *p,
+				     struct amdgpu_cs_chunk *chunk)
 {
+	struct drm_amdgpu_cs_chunk_dep *deps = chunk->kdata;
 	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
 	unsigned num_deps;
 	int i, r;
-	struct drm_amdgpu_cs_chunk_dep *deps;
 
-	deps = (struct drm_amdgpu_cs_chunk_dep *)chunk->kdata;
 	num_deps = chunk->length_dw * 4 /
 		sizeof(struct drm_amdgpu_cs_chunk_dep);
 
@@ -410,9 +401,9 @@ static int amdgpu_cs_process_fence_dep(struct amdgpu_cs_parser *p,
 	return 0;
 }
 
-static int amdgpu_syncobj_lookup_and_add_to_sync(struct amdgpu_cs_parser *p,
-						 uint32_t handle, u64 point,
-						 u64 flags)
+static int amdgpu_syncobj_lookup_and_add(struct amdgpu_cs_parser *p,
+					 uint32_t handle, u64 point,
+					 u64 flags)
 {
 	struct dma_fence *fence;
 	int r;
@@ -430,19 +421,17 @@ static int amdgpu_syncobj_lookup_and_add_to_sync(struct amdgpu_cs_parser *p,
 	return r;
 }
 
-static int amdgpu_cs_process_syncobj_in_dep(struct amdgpu_cs_parser *p,
-					    struct amdgpu_cs_chunk *chunk)
+static int amdgpu_cs_p2_syncobj_in(struct amdgpu_cs_parser *p,
+				   struct amdgpu_cs_chunk *chunk)
 {
-	struct drm_amdgpu_cs_chunk_sem *deps;
+	struct drm_amdgpu_cs_chunk_sem *deps = chunk->kdata;
 	unsigned num_deps;
 	int i, r;
 
-	deps = (struct drm_amdgpu_cs_chunk_sem *)chunk->kdata;
 	num_deps = chunk->length_dw * 4 /
 		sizeof(struct drm_amdgpu_cs_chunk_sem);
 	for (i = 0; i < num_deps; ++i) {
-		r = amdgpu_syncobj_lookup_and_add_to_sync(p, deps[i].handle,
-							  0, 0);
+		r = amdgpu_syncobj_lookup_and_add(p, deps[i].handle, 0, 0);
 		if (r)
 			return r;
 	}
@@ -450,21 +439,19 @@ static int amdgpu_cs_process_syncobj_in_dep(struct amdgpu_cs_parser *p,
 	return 0;
 }
 
-static int amdgpu_cs_process_syncobj_timeline_in_dep(struct amdgpu_cs_parser *p,
-						     struct amdgpu_cs_chunk *chunk)
+static int amdgpu_cs_p2_syncobj_timeline_wait(struct amdgpu_cs_parser *p,
+					      struct amdgpu_cs_chunk *chunk)
 {
-	struct drm_amdgpu_cs_chunk_syncobj *syncobj_deps;
+	struct drm_amdgpu_cs_chunk_syncobj *syncobj_deps = chunk->kdata;
 	unsigned num_deps;
 	int i, r;
 
-	syncobj_deps = (struct drm_amdgpu_cs_chunk_syncobj *)chunk->kdata;
 	num_deps = chunk->length_dw * 4 /
 		sizeof(struct drm_amdgpu_cs_chunk_syncobj);
 	for (i = 0; i < num_deps; ++i) {
-		r = amdgpu_syncobj_lookup_and_add_to_sync(p,
-							  syncobj_deps[i].handle,
-							  syncobj_deps[i].point,
-							  syncobj_deps[i].flags);
+		r = amdgpu_syncobj_lookup_and_add(p, syncobj_deps[i].handle,
+						  syncobj_deps[i].point,
+						  syncobj_deps[i].flags);
 		if (r)
 			return r;
 	}
@@ -472,14 +459,13 @@ static int amdgpu_cs_process_syncobj_timeline_in_dep(struct amdgpu_cs_parser *p,
 	return 0;
 }
 
-static int amdgpu_cs_process_syncobj_out_dep(struct amdgpu_cs_parser *p,
-					     struct amdgpu_cs_chunk *chunk)
+static int amdgpu_cs_p2_syncobj_out(struct amdgpu_cs_parser *p,
+				    struct amdgpu_cs_chunk *chunk)
 {
-	struct drm_amdgpu_cs_chunk_sem *deps;
+	struct drm_amdgpu_cs_chunk_sem *deps = chunk->kdata;
 	unsigned num_deps;
 	int i;
 
-	deps = (struct drm_amdgpu_cs_chunk_sem *)chunk->kdata;
 	num_deps = chunk->length_dw * 4 /
 		sizeof(struct drm_amdgpu_cs_chunk_sem);
 
@@ -507,15 +493,13 @@ static int amdgpu_cs_process_syncobj_out_dep(struct amdgpu_cs_parser *p,
 	return 0;
 }
 
-
-static int amdgpu_cs_process_syncobj_timeline_out_dep(struct amdgpu_cs_parser *p,
-						      struct amdgpu_cs_chunk *chunk)
+static int amdgpu_cs_p2_syncobj_timeline_signal(struct amdgpu_cs_parser *p,
+						struct amdgpu_cs_chunk *chunk)
 {
-	struct drm_amdgpu_cs_chunk_syncobj *syncobj_deps;
+	struct drm_amdgpu_cs_chunk_syncobj *syncobj_deps = chunk->kdata;
 	unsigned num_deps;
 	int i;
 
-	syncobj_deps = (struct drm_amdgpu_cs_chunk_syncobj *)chunk->kdata;
 	num_deps = chunk->length_dw * 4 /
 		sizeof(struct drm_amdgpu_cs_chunk_syncobj);
 
@@ -552,9 +536,9 @@ static int amdgpu_cs_process_syncobj_timeline_out_dep(struct amdgpu_cs_parser *p
 	return 0;
 }
 
-static int amdgpu_cs_dependencies(struct amdgpu_device *adev,
-				  struct amdgpu_cs_parser *p)
+static int amdgpu_cs_pass2(struct amdgpu_cs_parser *p)
 {
+	unsigned int num_ibs = 0, ce_preempt = 0, de_preempt = 0;
 	int i, r;
 
 	for (i = 0; i < p->nchunks; ++i) {
@@ -563,29 +547,35 @@ static int amdgpu_cs_dependencies(struct amdgpu_device *adev,
 		chunk = &p->chunks[i];
 
 		switch (chunk->chunk_id) {
+		case AMDGPU_CHUNK_ID_IB:
+			r = amdgpu_cs_p2_ib(p, chunk, &num_ibs,
+					    &ce_preempt, &de_preempt);
+			if (r)
+				return r;
+			break;
 		case AMDGPU_CHUNK_ID_DEPENDENCIES:
 		case AMDGPU_CHUNK_ID_SCHEDULED_DEPENDENCIES:
-			r = amdgpu_cs_process_fence_dep(p, chunk);
+			r = amdgpu_cs_p2_dependencies(p, chunk);
 			if (r)
 				return r;
 			break;
 		case AMDGPU_CHUNK_ID_SYNCOBJ_IN:
-			r = amdgpu_cs_process_syncobj_in_dep(p, chunk);
+			r = amdgpu_cs_p2_syncobj_in(p, chunk);
 			if (r)
 				return r;
 			break;
 		case AMDGPU_CHUNK_ID_SYNCOBJ_OUT:
-			r = amdgpu_cs_process_syncobj_out_dep(p, chunk);
+			r = amdgpu_cs_p2_syncobj_out(p, chunk);
 			if (r)
 				return r;
 			break;
 		case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_WAIT:
-			r = amdgpu_cs_process_syncobj_timeline_in_dep(p, chunk);
+			r = amdgpu_cs_p2_syncobj_timeline_wait(p, chunk);
 			if (r)
 				return r;
 			break;
 		case AMDGPU_CHUNK_ID_SYNCOBJ_TIMELINE_SIGNAL:
-			r = amdgpu_cs_process_syncobj_timeline_out_dep(p, chunk);
+			r = amdgpu_cs_p2_syncobj_timeline_signal(p, chunk);
 			if (r)
 				return r;
 			break;
@@ -987,78 +977,74 @@ static void trace_amdgpu_cs_ibs(struct amdgpu_cs_parser *parser)
 		trace_amdgpu_cs(parser, i);
 }
 
-static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
+static int amdgpu_cs_patch_ibs(struct amdgpu_cs_parser *p)
 {
 	struct amdgpu_ring *ring = to_amdgpu_ring(p->entity->rq->sched);
-	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
-	struct amdgpu_device *adev = p->adev;
-	struct amdgpu_vm *vm = &fpriv->vm;
-	struct amdgpu_bo_list_entry *e;
-	struct amdgpu_bo_va *bo_va;
-	struct amdgpu_bo *bo;
+	struct amdgpu_job *job = p->job;
+	unsigned int i;
 	int r;
 
 	/* Only for UVD/VCE VM emulation */
-	if (ring->funcs->parse_cs || ring->funcs->patch_cs_in_place) {
-		unsigned i, j;
-
-		for (i = 0, j = 0; i < p->nchunks && j < p->job->num_ibs; i++) {
-			struct drm_amdgpu_cs_chunk_ib *chunk_ib;
-			struct amdgpu_bo_va_mapping *m;
-			struct amdgpu_bo *aobj = NULL;
-			struct amdgpu_cs_chunk *chunk;
-			uint64_t offset, va_start;
-			struct amdgpu_ib *ib;
-			uint8_t *kptr;
-
-			chunk = &p->chunks[i];
-			ib = &p->job->ibs[j];
-			chunk_ib = chunk->kdata;
-
-			if (chunk->chunk_id != AMDGPU_CHUNK_ID_IB)
-				continue;
+	if (!ring->funcs->parse_cs && !ring->funcs->patch_cs_in_place)
+		return 0;
 
-			va_start = chunk_ib->va_start & AMDGPU_GMC_HOLE_MASK;
-			r = amdgpu_cs_find_mapping(p, va_start, &aobj, &m);
-			if (r) {
-				DRM_ERROR("IB va_start is invalid\n");
-				return r;
-			}
+	for (i = 0; i < job->num_ibs; ++i) {
+		struct amdgpu_ib *ib = &job->ibs[i];
+		struct amdgpu_bo_va_mapping *m;
+		struct amdgpu_bo *aobj;
+		uint64_t va_start;
+		uint8_t *kptr;
 
-			if ((va_start + chunk_ib->ib_bytes) >
-			    (m->last + 1) * AMDGPU_GPU_PAGE_SIZE) {
-				DRM_ERROR("IB va_start+ib_bytes is invalid\n");
-				return -EINVAL;
-			}
+		va_start = ib->gpu_addr & AMDGPU_GMC_HOLE_MASK;
+		r = amdgpu_cs_find_mapping(p, va_start, &aobj, &m);
+		if (r) {
+			DRM_ERROR("IB va_start is invalid\n");
+			return r;
+		}
 
-			/* the IB should be reserved at this point */
-			r = amdgpu_bo_kmap(aobj, (void **)&kptr);
-			if (r) {
-				return r;
-			}
+		if ((va_start + ib->length_dw * 4) >
+		    (m->last + 1) * AMDGPU_GPU_PAGE_SIZE) {
+			DRM_ERROR("IB va_start+ib_bytes is invalid\n");
+			return -EINVAL;
+		}
 
-			offset = m->start * AMDGPU_GPU_PAGE_SIZE;
-			kptr += va_start - offset;
-
-			if (ring->funcs->parse_cs) {
-				memcpy(ib->ptr, kptr, chunk_ib->ib_bytes);
-				amdgpu_bo_kunmap(aobj);
-
-				r = amdgpu_ring_parse_cs(ring, p, p->job, ib);
-				if (r)
-					return r;
-			} else {
-				ib->ptr = (uint32_t *)kptr;
-				r = amdgpu_ring_patch_cs_in_place(ring, p, p->job, ib);
-				amdgpu_bo_kunmap(aobj);
-				if (r)
-					return r;
-			}
+		/* the IB should be reserved at this point */
+		r = amdgpu_bo_kmap(aobj, (void **)&kptr);
+		if (r) {
+			return r;
+		}
+
+		kptr += va_start - (m->start * AMDGPU_GPU_PAGE_SIZE);
 
-			j++;
+		if (ring->funcs->parse_cs) {
+			memcpy(ib->ptr, kptr, ib->length_dw * 4);
+			amdgpu_bo_kunmap(aobj);
+
+			r = amdgpu_ring_parse_cs(ring, p, p->job, ib);
+			if (r)
+				return r;
+		} else {
+			ib->ptr = (uint32_t *)kptr;
+			r = amdgpu_ring_patch_cs_in_place(ring, p, p->job, ib);
+			amdgpu_bo_kunmap(aobj);
+			if (r)
+				return r;
 		}
 	}
 
+	return 0;
+}
+
+static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
+{
+	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
+	struct amdgpu_device *adev = p->adev;
+	struct amdgpu_vm *vm = &fpriv->vm;
+	struct amdgpu_bo_list_entry *e;
+	struct amdgpu_bo_va *bo_va;
+	struct amdgpu_bo *bo;
+	int r;
+
 	if (!p->job->vm)
 		return 0;
 
@@ -1186,7 +1172,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 	job = p->job;
 	p->job = NULL;
 
-	r = drm_sched_job_init(&job->base, entity, &fpriv->vm);
+	r = drm_sched_job_init(&job->base, p->entity, &fpriv->vm);
 	if (r)
 		goto error_unlock;
 
@@ -1253,17 +1239,10 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 }
 
 /* Cleanup the parser structure */
-static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser, int error,
-				  bool backoff)
+static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser)
 {
 	unsigned i;
 
-	if (error && backoff) {
-		ttm_eu_backoff_reservation(&parser->ticket,
-					   &parser->validated);
-		mutex_unlock(&parser->bo_list->bo_list_mutex);
-	}
-
 	for (i = 0; i < parser->num_post_deps; i++) {
 		drm_syncobj_put(parser->post_deps[i].syncobj);
 		kfree(parser->post_deps[i].chain);
@@ -1272,8 +1251,9 @@ static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser, int error,
 
 	dma_fence_put(parser->fence);
 
-	if (parser->ctx)
+	if (parser->ctx) {
 		amdgpu_ctx_put(parser->ctx);
+	}
 	if (parser->bo_list)
 		amdgpu_bo_list_put(parser->bo_list);
 
@@ -1293,7 +1273,6 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_cs_parser parser;
-	bool reserved_buffers = false;
 	int r;
 
 	if (amdgpu_ras_intr_triggered())
@@ -1306,22 +1285,16 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	if (r) {
 		if (printk_ratelimit())
 			DRM_ERROR("Failed to initialize parser %d!\n", r);
-		goto out;
+		return r;
 	}
 
 	r = amdgpu_cs_pass1(&parser, data);
 	if (r)
-		goto out;
+		goto error_fini;
 
-	r = amdgpu_cs_ib_fill(adev, &parser);
+	r = amdgpu_cs_pass2(&parser);
 	if (r)
-		goto out;
-
-	r = amdgpu_cs_dependencies(adev, &parser);
-	if (r) {
-		DRM_ERROR("Failed in the dependencies handling %d!\n", r);
-		goto out;
-	}
+		goto error_fini;
 
 	r = amdgpu_cs_parser_bos(&parser, data);
 	if (r) {
@@ -1329,25 +1302,36 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 			DRM_ERROR("Not enough memory for command submission!\n");
 		else if (r != -ERESTARTSYS && r != -EAGAIN)
 			DRM_ERROR("Failed to process the buffer list %d!\n", r);
-		goto out;
+		goto error_fini;
 	}
 
-	reserved_buffers = true;
-
-	trace_amdgpu_cs_ibs(&parser);
+	r = amdgpu_cs_patch_ibs(&parser);
+	if (r)
+		goto error_backoff;
 
 	r = amdgpu_cs_vm_handling(&parser);
 	if (r)
-		goto out;
+		goto error_backoff;
 
 	r = amdgpu_cs_sync_rings(&parser);
 	if (r)
-		goto out;
+		goto error_backoff;
+
+	trace_amdgpu_cs_ibs(&parser);
 
 	r = amdgpu_cs_submit(&parser, data);
-out:
-	amdgpu_cs_parser_fini(&parser, r, reserved_buffers);
+	if (r)
+		goto error_backoff;
+
+	amdgpu_cs_parser_fini(&parser);
+	return 0;
+
+error_backoff:
+	ttm_eu_backoff_reservation(&parser.ticket, &parser.validated);
+	mutex_unlock(&parser.bo_list->bo_list_mutex);
 
+error_fini:
+	amdgpu_cs_parser_fini(&parser);
 	return r;
 }
 
-- 
2.25.1


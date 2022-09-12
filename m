Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D45FECAAD5
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Sep 2022 12:37:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E15EC10E445;
	Mon, 12 Sep 2022 12:37:02 +0000 (UTC)
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A04010E466
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 12:36:50 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id u9so19897009ejy.5
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Sep 2022 05:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
 bh=4xczFJ1raQqg38Fhn35lFr0cXgYD2gcfxgxchrkki3g=;
 b=VsRLeoeT5UcisR7xzQDCOh5a4mB+N/6inmAO8xNKBZ56jzFGuFX95t0jEfZZe64Ind
 YuU8TRAUEKsb+JRGJdQasXo2V+hB2P2OhY4t1XtnQdTrkJffIFuVgc+PqD8Y1IhrkHNQ
 XvGNEbSJMwCRT7o0MOBywZ5WHpwRcppbotYz4Z098dUjFL6eN9D5SGJ8VKYvFOdq7+y7
 GBAlgbdrTRqwNhPNHLVO08ZiwoUKTSD9lK5v+N/IPPYtKPrreFp2U6IyrGukUyPkjZdP
 mW1B6IwCgY6lXfcK713L5ulVPj1gULyrnSCS1YatYNycxIxhq/EJTPOoolJZmOgKGEAe
 rMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date;
 bh=4xczFJ1raQqg38Fhn35lFr0cXgYD2gcfxgxchrkki3g=;
 b=Wz2lx723JasYtrmzxUZ/4mqmIsSc6dQsB4JkpwY+LfRvvpJZGV16ck30opjq5oVL/2
 cN2F2n0yLl3UZFGFz4zwu0JQIZSQHXFw2j0Tmp3+4iVu4icK1CJLt+nibueaxe7yCNxD
 fMaLbXl2PLVfx44Uw7lLI7ubZP6hm7i3C0CXm3ptFoc8aLBvKlKUqCtAl7jEYZvJFoPr
 pAGfU+9C1y/r4TPdAn6QmMGfkmCWZ1n+weR6Pw6itTOjQ+u8qtnzrwnWi2nCrtmPJA/m
 TPbTzmd7JxLr1XZP86l6CT2zHjMs/4ZLoWuW1mN4zQwfLT09yUN0Zt1arhqAlU8Pq+YN
 vZUw==
X-Gm-Message-State: ACgBeo302zSnhMhMRzvxISYqUqf99iRi2YQRkTv+WQVVMggjl8hKGQEU
 oG/ucmoLwWxjQTfw/69crw0=
X-Google-Smtp-Source: AA6agR7GBSWzIQ2qfRpuT3dOLOauzazdsyQSpB6eAuESmKKnV7iOMDzgP3W9YQ8QSB4YNCnE6aLY2Q==
X-Received: by 2002:a17:907:86aa:b0:741:a0d5:43bc with SMTP id
 qa42-20020a17090786aa00b00741a0d543bcmr19183188ejc.100.1662986208469; 
 Mon, 12 Sep 2022 05:36:48 -0700 (PDT)
Received: from able.fritz.box (p4fc20f4e.dip0.t-ipconnect.de. [79.194.15.78])
 by smtp.gmail.com with ESMTPSA id
 au6-20020a170907092600b00770c8e157ccsm4335639ejc.136.2022.09.12.05.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Sep 2022 05:36:48 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 6/7] drm/amdgpu: cleanup CS init/fini and pass1
Date: Mon, 12 Sep 2022 14:36:39 +0200
Message-Id: <20220912123640.20058-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912123640.20058-1-christian.koenig@amd.com>
References: <20220912123640.20058-1-christian.koenig@amd.com>
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

Cleanup the coding style and function names to represent the data
they process. Only initialize and cleanup the CS structure in
init/fini.

Check the size of the IB chunk in pass1.

v2: fix job initialisation order and use correct scheduler instance
v3: try to move all functional changes into a separate patch.
v4: move reordering and pass2 out of this patch as well

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 197 +++++++++++++------------
 1 file changed, 104 insertions(+), 93 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 52ba6325944e..ee02fecc27b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -39,9 +39,42 @@
 #include "amdgpu_gem.h"
 #include "amdgpu_ras.h"
 
-static int amdgpu_cs_user_fence_chunk(struct amdgpu_cs_parser *p,
-				      struct drm_amdgpu_cs_chunk_fence *data,
-				      uint32_t *offset)
+static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p,
+				 struct amdgpu_device *adev,
+				 struct drm_file *filp,
+				 union drm_amdgpu_cs *cs)
+{
+	struct amdgpu_fpriv *fpriv = filp->driver_priv;
+
+	if (cs->in.num_chunks == 0)
+		return -EINVAL;
+
+	memset(p, 0, sizeof(*p));
+	p->adev = adev;
+	p->filp = filp;
+
+	p->ctx = amdgpu_ctx_get(fpriv, cs->in.ctx_id);
+	if (!p->ctx)
+		return -EINVAL;
+
+	if (atomic_read(&p->ctx->guilty)) {
+		amdgpu_ctx_put(p->ctx);
+		return -ECANCELED;
+	}
+	return 0;
+}
+
+static int amdgpu_cs_p1_ib(struct amdgpu_cs_parser *p,
+			   struct drm_amdgpu_cs_chunk_ib *chunk_ib,
+			   unsigned int *num_ibs)
+{
+	++(*num_ibs);
+	return 0;
+}
+
+static int amdgpu_cs_p1_user_fence(struct amdgpu_cs_parser *p,
+				   struct drm_amdgpu_cs_chunk_fence *data,
+				   uint32_t *offset)
 {
 	struct drm_gem_object *gobj;
 	struct amdgpu_bo *bo;
@@ -80,11 +113,11 @@ static int amdgpu_cs_user_fence_chunk(struct amdgpu_cs_parser *p,
 	return r;
 }
 
-static int amdgpu_cs_bo_handles_chunk(struct amdgpu_cs_parser *p,
-				      struct drm_amdgpu_bo_list_in *data)
+static int amdgpu_cs_p1_bo_handles(struct amdgpu_cs_parser *p,
+				   struct drm_amdgpu_bo_list_in *data)
 {
+	struct drm_amdgpu_bo_list_entry *info;
 	int r;
-	struct drm_amdgpu_bo_list_entry *info = NULL;
 
 	r = amdgpu_bo_create_list_entry_array(data, &info);
 	if (r)
@@ -104,7 +137,9 @@ static int amdgpu_cs_bo_handles_chunk(struct amdgpu_cs_parser *p,
 	return r;
 }
 
-static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs *cs)
+/* Copy the data from userspace and go over it the first time */
+static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
+			   union drm_amdgpu_cs *cs)
 {
 	struct amdgpu_fpriv *fpriv = p->filp->driver_priv;
 	struct amdgpu_vm *vm = &fpriv->vm;
@@ -112,28 +147,14 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 	uint64_t *chunk_array;
 	unsigned size, num_ibs = 0;
 	uint32_t uf_offset = 0;
-	int i;
 	int ret;
+	int i;
 
-	if (cs->in.num_chunks == 0)
-		return -EINVAL;
-
-	chunk_array = kvmalloc_array(cs->in.num_chunks, sizeof(uint64_t), GFP_KERNEL);
+	chunk_array = kvmalloc_array(cs->in.num_chunks, sizeof(uint64_t),
+				     GFP_KERNEL);
 	if (!chunk_array)
 		return -ENOMEM;
 
-	p->ctx = amdgpu_ctx_get(fpriv, cs->in.ctx_id);
-	if (!p->ctx) {
-		ret = -EINVAL;
-		goto free_chunk;
-	}
-
-	/* skip guilty context job */
-	if (atomic_read(&p->ctx->guilty) == 1) {
-		ret = -ECANCELED;
-		goto free_chunk;
-	}
-
 	/* get chunks */
 	chunk_array_user = u64_to_user_ptr(cs->in.chunks);
 	if (copy_from_user(chunk_array, chunk_array_user,
@@ -168,7 +189,8 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 		size = p->chunks[i].length_dw;
 		cdata = u64_to_user_ptr(user_chunk.chunk_data);
 
-		p->chunks[i].kdata = kvmalloc_array(size, sizeof(uint32_t), GFP_KERNEL);
+		p->chunks[i].kdata = kvmalloc_array(size, sizeof(uint32_t),
+						    GFP_KERNEL);
 		if (p->chunks[i].kdata == NULL) {
 			ret = -ENOMEM;
 			i--;
@@ -180,36 +202,35 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 			goto free_partial_kdata;
 		}
 
+		/* Assume the worst on the following checks */
+		ret = -EINVAL;
 		switch (p->chunks[i].chunk_id) {
 		case AMDGPU_CHUNK_ID_IB:
-			++num_ibs;
+			if (size < sizeof(struct drm_amdgpu_cs_chunk_ib))
+				goto free_partial_kdata;
+
+			ret = amdgpu_cs_p1_ib(p, p->chunks[i].kdata, &num_ibs);
+			if (ret)
+				goto free_partial_kdata;
 			break;
 
 		case AMDGPU_CHUNK_ID_FENCE:
-			size = sizeof(struct drm_amdgpu_cs_chunk_fence);
-			if (p->chunks[i].length_dw * sizeof(uint32_t) < size) {
-				ret = -EINVAL;
+			if (size < sizeof(struct drm_amdgpu_cs_chunk_fence))
 				goto free_partial_kdata;
-			}
 
-			ret = amdgpu_cs_user_fence_chunk(p, p->chunks[i].kdata,
-							 &uf_offset);
+			ret = amdgpu_cs_p1_user_fence(p, p->chunks[i].kdata,
+						      &uf_offset);
 			if (ret)
 				goto free_partial_kdata;
-
 			break;
 
 		case AMDGPU_CHUNK_ID_BO_HANDLES:
-			size = sizeof(struct drm_amdgpu_bo_list_in);
-			if (p->chunks[i].length_dw * sizeof(uint32_t) < size) {
-				ret = -EINVAL;
+			if (size < sizeof(struct drm_amdgpu_bo_list_in))
 				goto free_partial_kdata;
-			}
 
-			ret = amdgpu_cs_bo_handles_chunk(p, p->chunks[i].kdata);
+			ret = amdgpu_cs_p1_bo_handles(p, p->chunks[i].kdata);
 			if (ret)
 				goto free_partial_kdata;
-
 			break;
 
 		case AMDGPU_CHUNK_ID_DEPENDENCIES:
@@ -221,7 +242,6 @@ static int amdgpu_cs_parser_init(struct amdgpu_cs_parser *p, union drm_amdgpu_cs
 			break;
 
 		default:
-			ret = -EINVAL;
 			goto free_partial_kdata;
 		}
 	}
@@ -660,52 +680,6 @@ static int amdgpu_cs_sync_rings(struct amdgpu_cs_parser *p)
 	return 0;
 }
 
-/**
- * amdgpu_cs_parser_fini() - clean parser states
- * @parser:	parser structure holding parsing context.
- * @error:	error number
- * @backoff:	indicator to backoff the reservation
- *
- * If error is set then unvalidate buffer, otherwise just free memory
- * used by parsing context.
- **/
-static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser, int error,
-				  bool backoff)
-{
-	unsigned i;
-
-	if (error && backoff) {
-		ttm_eu_backoff_reservation(&parser->ticket,
-					   &parser->validated);
-		mutex_unlock(&parser->bo_list->bo_list_mutex);
-	}
-
-	for (i = 0; i < parser->num_post_deps; i++) {
-		drm_syncobj_put(parser->post_deps[i].syncobj);
-		kfree(parser->post_deps[i].chain);
-	}
-	kfree(parser->post_deps);
-
-	dma_fence_put(parser->fence);
-
-	if (parser->ctx) {
-		amdgpu_ctx_put(parser->ctx);
-	}
-	if (parser->bo_list)
-		amdgpu_bo_list_put(parser->bo_list);
-
-	for (i = 0; i < parser->nchunks; i++)
-		kvfree(parser->chunks[i].kdata);
-	kvfree(parser->chunks);
-	if (parser->job)
-		amdgpu_job_free(parser->job);
-	if (parser->uf_entry.tv.bo) {
-		struct amdgpu_bo *uf = ttm_to_amdgpu_bo(parser->uf_entry.tv.bo);
-
-		amdgpu_bo_unref(&uf);
-	}
-}
-
 static int amdgpu_cs_vm_handling(struct amdgpu_cs_parser *p)
 {
 	struct amdgpu_ring *ring = to_amdgpu_ring(p->entity->rq->sched);
@@ -1280,11 +1254,47 @@ static void trace_amdgpu_cs_ibs(struct amdgpu_cs_parser *parser)
 		trace_amdgpu_cs(parser, i);
 }
 
+/* Cleanup the parser structure */
+static void amdgpu_cs_parser_fini(struct amdgpu_cs_parser *parser, int error,
+				  bool backoff)
+{
+	unsigned i;
+
+	if (error && backoff) {
+		ttm_eu_backoff_reservation(&parser->ticket,
+					   &parser->validated);
+		mutex_unlock(&parser->bo_list->bo_list_mutex);
+	}
+
+	for (i = 0; i < parser->num_post_deps; i++) {
+		drm_syncobj_put(parser->post_deps[i].syncobj);
+		kfree(parser->post_deps[i].chain);
+	}
+	kfree(parser->post_deps);
+
+	dma_fence_put(parser->fence);
+
+	if (parser->ctx)
+		amdgpu_ctx_put(parser->ctx);
+	if (parser->bo_list)
+		amdgpu_bo_list_put(parser->bo_list);
+
+	for (i = 0; i < parser->nchunks; i++)
+		kvfree(parser->chunks[i].kdata);
+	kvfree(parser->chunks);
+	if (parser->job)
+		amdgpu_job_free(parser->job);
+	if (parser->uf_entry.tv.bo) {
+		struct amdgpu_bo *uf = ttm_to_amdgpu_bo(parser->uf_entry.tv.bo);
+
+		amdgpu_bo_unref(&uf);
+	}
+}
+
 int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 {
 	struct amdgpu_device *adev = drm_to_adev(dev);
-	union drm_amdgpu_cs *cs = data;
-	struct amdgpu_cs_parser parser = {};
+	struct amdgpu_cs_parser parser;
 	bool reserved_buffers = false;
 	int r;
 
@@ -1294,16 +1304,17 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	if (!adev->accel_working)
 		return -EBUSY;
 
-	parser.adev = adev;
-	parser.filp = filp;
-
-	r = amdgpu_cs_parser_init(&parser, data);
+	r = amdgpu_cs_parser_init(&parser, adev, filp, data);
 	if (r) {
 		if (printk_ratelimit())
 			DRM_ERROR("Failed to initialize parser %d!\n", r);
 		goto out;
 	}
 
+	r = amdgpu_cs_pass1(&parser, data);
+	if (r)
+		goto out;
+
 	r = amdgpu_cs_ib_fill(adev, &parser);
 	if (r)
 		goto out;
@@ -1331,7 +1342,7 @@ int amdgpu_cs_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 	if (r)
 		goto out;
 
-	r = amdgpu_cs_submit(&parser, cs);
+	r = amdgpu_cs_submit(&parser, data);
 out:
 	amdgpu_cs_parser_fini(&parser, r, reserved_buffers);
 
-- 
2.25.1


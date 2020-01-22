Return-Path: <SRS0=N3S+=3L=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69816C33CAF
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 09:31:59 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC6224673
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 09:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p3hZtllY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC6224673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 020FA6F444;
	Wed, 22 Jan 2020 09:31:59 +0000 (UTC)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20::441])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F98C6F443
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 09:31:58 +0000 (UTC)
Received: by mail-wr1-x441.google.com with SMTP id t2so6494017wrr.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 01:31:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Xm+UehMb4iEXDlzjJK2Yuq8XOvApRbHkc4tEx0AlgVQ=;
 b=p3hZtllYJj7lG6KFWqJUIoSm7DZLBrRSqnydZd4HTzLJmIswZpI+J9YeLkZOpTQDTa
 U10f+OmHYu4zQ7v4h233ao6v7+GCraqTl5t2haweSv4uQlgO+0IA/O3pn+UYAHgJdudn
 fZHppyTxP31TKnSprj1TOAkLPnfmLzZHau1LIqLcAWXxeMceBxKRoH3pJLWnWa1zhvr0
 RwmoFr4fzHHx2AihOur7lG7U+p4qrgwDJJ19KRn2OOLWsHLbS/t3q1cvaH374j3/3SdP
 TvMEm6qyQN7xqMYoWy8qdvoGgnyJ+DVKehxYtatrIgQprbMXZqpAg28Lz7ALT0FqLxAc
 EC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Xm+UehMb4iEXDlzjJK2Yuq8XOvApRbHkc4tEx0AlgVQ=;
 b=Xgwe3o/V1WllVc29Hn2aYHitkTUQnZB0izhaLYmqPjbmozfLOxkP+89KLWXNnwKEv/
 mY174iXVSCLcWbVrW9Y+s31WQkgnDOwRP/ngYdHitGhyjYur8eUtL4NEhArcrzsQU9S1
 NK2Wz0Bm4d3BvigJ/ey/FPHqQj3ZW9q9rImJxSqupFhQYEehpaHi9nfRVA87p9Equ/K5
 81PMkjU3wbB6SMZ5BksZjTP5Fad+15RB32Sirw8Pl9QMqt7ci6Vf70oCtxLu5VWsURGQ
 5Ctw+JGL648gllvEB8qAG9/yIitTRLlRlNawcXSsjG/qAgZW3ob+7vUS2lI0cov+t24F
 ZTLA==
X-Gm-Message-State: APjAAAVEr/HoFjnUtzA2RDx9vAqJ36k4Afw1ex44mqk/z47lVWfGxQXd
 Y5fb5vmVai5vf8tAWKOyschwzHuofv0Eyg==
X-Google-Smtp-Source: APXvYqwXF5SjbIwdrIa4SG7O6Ztm0o/a8kMNrdhz1eeeeCqSMcGyfUH+47fF1c+qvCciZd24VmcyIw==
X-Received: by 2002:adf:df0e:: with SMTP id y14mr9712367wrl.377.1579685516264; 
 Wed, 22 Jan 2020 01:31:56 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F2957000A0F1FDBBC5B14D8.dip0.t-ipconnect.de.
 [2003:c5:8f29:5700:a0f:1fdb:bc5b:14d8])
 by smtp.gmail.com with ESMTPSA id i5sm3169234wml.31.2020.01.22.01.31.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 01:31:55 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 2/2] drm/amdgpu: allocate entities on demand
Date: Wed, 22 Jan 2020 10:33:06 +0100
Message-Id: <20200122093306.16737-2-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122093306.16737-1-nirmoy.das@amd.com>
References: <20200122093306.16737-1-nirmoy.das@amd.com>
MIME-Version: 1.0
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
Cc: alexander.deucher@amd.com, kenny.ho@amd.com, nirmoy.das@amd.com,
 christian.koenig@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Currently we pre-allocate entities and fences for all the HW IPs on
context creation and some of which are might never be used.

This patch tries to resolve entity/fences wastage by creating entities
for a HW IP only when it is required.

v2: consolidated priority checking at amdgpu_ctx_priority_permit()

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 160 +++++++++++++-----------
 1 file changed, 87 insertions(+), 73 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index eecbd68db986..d704e1bebb1b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -45,6 +45,9 @@ const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM] = {
 static int amdgpu_ctx_priority_permit(struct drm_file *filp,
 				      enum drm_sched_priority priority)
 {
+	if (priority < 0 || priority >= DRM_SCHED_PRIORITY_MAX)
+		return -EINVAL;
+
 	/* NORMAL and below are accessible by everyone */
 	if (priority <= DRM_SCHED_PRIORITY_NORMAL)
 		return 0;
@@ -58,65 +61,37 @@ static int amdgpu_ctx_priority_permit(struct drm_file *filp,
 	return -EACCES;
 }
 
-static int amdgpu_ctx_init(struct amdgpu_device *adev,
-			   enum drm_sched_priority priority,
-			   struct drm_file *filp,
-			   struct amdgpu_ctx *ctx)
+static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, const u32 hw_ip)
 {
-	unsigned i, j;
-	int r;
+	struct amdgpu_device *adev = ctx->adev;
+	struct drm_gpu_scheduler **scheds;
+	struct drm_gpu_scheduler *sched;
+	unsigned num_scheds = 0;
+	enum drm_sched_priority priority;
+	int j, r;
 
-	if (priority < 0 || priority >= DRM_SCHED_PRIORITY_MAX)
-		return -EINVAL;
+	ctx->entities[hw_ip] = kcalloc(amdgpu_ctx_num_entities[hw_ip],
+				       sizeof(struct amdgpu_ctx_entity), GFP_KERNEL);
 
-	r = amdgpu_ctx_priority_permit(filp, priority);
-	if (r)
-		return r;
+	if (!ctx->entities[hw_ip])
+		return  -ENOMEM;
 
-	memset(ctx, 0, sizeof(*ctx));
-	ctx->adev = adev;
+	for (j = 0; j < amdgpu_ctx_num_entities[hw_ip]; ++j) {
 
-	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
-		ctx->entities[i] = kcalloc(amdgpu_ctx_num_entities[i],
-					   sizeof(struct amdgpu_ctx_entity),
-					   GFP_KERNEL);
+		struct amdgpu_ctx_entity *entity = &ctx->entities[hw_ip][j];
 
-		if (!ctx->entities[0]) {
-			r =  -ENOMEM;
-			goto error_cleanup_entity_memory;
+		entity->sequence = 1;
+		entity->fences = kcalloc(amdgpu_sched_jobs,
+					 sizeof(struct dma_fence*), GFP_KERNEL);
+		if (!entity->fences) {
+			r = -ENOMEM;
+			goto error_cleanup_memory;
 		}
 	}
 
-	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
-		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
-			struct amdgpu_ctx_entity *entity = &ctx->entities[i][j];
-
-			entity->sequence = 1;
-			entity->fences = kcalloc(amdgpu_sched_jobs,
-						 sizeof(struct dma_fence*), GFP_KERNEL);
-			if (!entity->fences) {
-				r = -ENOMEM;
-				goto error_cleanup_memory;
-			}
-		}
-	}
-
-	kref_init(&ctx->refcount);
-	spin_lock_init(&ctx->ring_lock);
-	mutex_init(&ctx->lock);
-
-	ctx->reset_counter = atomic_read(&adev->gpu_reset_counter);
-	ctx->reset_counter_query = ctx->reset_counter;
-	ctx->vram_lost_counter = atomic_read(&adev->vram_lost_counter);
-	ctx->init_priority = priority;
-	ctx->override_priority = DRM_SCHED_PRIORITY_UNSET;
-
-	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
-		struct drm_gpu_scheduler **scheds;
-		struct drm_gpu_scheduler *sched;
-		unsigned num_scheds = 0;
-
-		switch (i) {
+	priority = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
+				ctx->init_priority : ctx->override_priority;
+	switch (hw_ip) {
 		case AMDGPU_HW_IP_GFX:
 			sched = &adev->gfx.gfx_ring[0].sched;
 			scheds = &sched;
@@ -157,12 +132,12 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
 			scheds = adev->jpeg.jpeg_sched;
 			num_scheds =  adev->jpeg.num_jpeg_sched;
 			break;
-		}
+	}
 
-		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j)
-			r = drm_sched_entity_init(&ctx->entities[i][j].entity,
-						  priority, scheds,
-						  num_scheds, &ctx->guilty);
+	for (j = 0; j < amdgpu_ctx_num_entities[hw_ip]; ++j) {
+		r = drm_sched_entity_init(&ctx->entities[hw_ip][j].entity,
+					  priority, scheds,
+					  num_scheds, &ctx->guilty);
 		if (r)
 			goto error_cleanup_entities;
 	}
@@ -170,30 +145,51 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
 	return 0;
 
 error_cleanup_entities:
-	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
-		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j)
-			drm_sched_entity_destroy(&ctx->entities[i][j].entity);
-	}
+	for (j = 0; j < amdgpu_ctx_num_entities[hw_ip]; ++j)
+		drm_sched_entity_destroy(&ctx->entities[hw_ip][j].entity);
 
 error_cleanup_memory:
-	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
-		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
-			struct amdgpu_ctx_entity *entity = &ctx->entities[i][j];
+	for (j = 0; j < amdgpu_ctx_num_entities[hw_ip]; ++j) {
+		struct amdgpu_ctx_entity *entity = &ctx->entities[hw_ip][j];
 
-			kfree(entity->fences);
-			entity->fences = NULL;
-		}
+		kfree(entity->fences);
+		entity->fences = NULL;
 	}
 
-error_cleanup_entity_memory:
-	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
-		kfree(ctx->entities[i]);
-		ctx->entities[i] = NULL;
-	}
+	kfree(ctx->entities[hw_ip]);
+	ctx->entities[hw_ip] = NULL;
 
 	return r;
 }
 
+static int amdgpu_ctx_init(struct amdgpu_device *adev,
+			   enum drm_sched_priority priority,
+			   struct drm_file *filp,
+			   struct amdgpu_ctx *ctx)
+{
+	int r;
+
+	r = amdgpu_ctx_priority_permit(filp, priority);
+	if (r)
+		return r;
+
+	memset(ctx, 0, sizeof(*ctx));
+	ctx->adev = adev;
+
+	kref_init(&ctx->refcount);
+	spin_lock_init(&ctx->ring_lock);
+	mutex_init(&ctx->lock);
+
+	ctx->reset_counter = atomic_read(&adev->gpu_reset_counter);
+	ctx->reset_counter_query = ctx->reset_counter;
+	ctx->vram_lost_counter = atomic_read(&adev->vram_lost_counter);
+	ctx->init_priority = priority;
+	ctx->override_priority = DRM_SCHED_PRIORITY_UNSET;
+
+	return 0;
+
+}
+
 static void amdgpu_ctx_fini(struct kref *ref)
 {
 	struct amdgpu_ctx *ctx = container_of(ref, struct amdgpu_ctx, refcount);
@@ -204,7 +200,14 @@ static void amdgpu_ctx_fini(struct kref *ref)
 		return;
 	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
 		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
-			struct amdgpu_ctx_entity *entity = &ctx->entities[i][j];
+			struct amdgpu_ctx_entity *entity;
+
+			if (!ctx->entities[i])
+				continue;
+
+			entity = &ctx->entities[i][j];
+			if (!entity->fences)
+				continue;
 
 			for (k = 0; k < amdgpu_sched_jobs; ++k)
 				dma_fence_put(entity->fences[k]);
@@ -241,6 +244,9 @@ int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
 		return -EINVAL;
 	}
 
+	if (ctx->entities[hw_ip] == NULL)
+		amdgpu_ctx_init_entity(ctx, hw_ip);
+
 	*entity = &ctx->entities[hw_ip][ring].entity;
 	return 0;
 }
@@ -285,8 +291,11 @@ static void amdgpu_ctx_do_release(struct kref *ref)
 
 	ctx = container_of(ref, struct amdgpu_ctx, refcount);
 	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
-		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j)
+		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
+			if (!ctx->entities[i])
+				continue;
 			drm_sched_entity_destroy(&ctx->entities[i][j].entity);
+		}
 	}
 
 	amdgpu_ctx_fini(ref);
@@ -579,6 +588,9 @@ long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
 			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
 				struct drm_sched_entity *entity;
 
+				if (!ctx->entities[i])
+					continue;
+
 				entity = &ctx->entities[i][j].entity;
 				timeout = drm_sched_entity_flush(entity, timeout);
 			}
@@ -601,11 +613,13 @@ void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
 			DRM_ERROR("ctx %p is still alive\n", ctx);
 			continue;
 		}
-
 		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
 			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
 				struct drm_sched_entity *entity;
 
+				if (!ctx->entities[i])
+					continue;
+
 				entity = &ctx->entities[i][j].entity;
 				drm_sched_entity_fini(entity);
 			}
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

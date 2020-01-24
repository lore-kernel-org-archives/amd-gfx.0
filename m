Return-Path: <SRS0=Oth2=3N=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45103C2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 15:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14ECF20709
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 15:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCxhJ8m3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14ECF20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1CF872AE7;
	Fri, 24 Jan 2020 15:13:56 +0000 (UTC)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20::443])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C99C26E3DF
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2020 15:13:55 +0000 (UTC)
Received: by mail-wr1-x443.google.com with SMTP id d16so2376975wre.10
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2020 07:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vPuDbIGBXxyIfcTk2Zum8utgtdb0qSqk7SriL8LXvf0=;
 b=KCxhJ8m3DZXyDivQsGOrF4WQO9hCRf5E8JJiOkWmJJVtIE0xiKTnwBt/HtbpcIkifd
 g/eQoTogXuLOTnp9AXUJw3bxv8ZQG3V/XOaLBNxt9nrumRQo8sNZXr2/uIt1irGCe/PC
 Al0KhaUX67CYBu14KQI9Cu/LF7Hn6T3HR2k8Gsa6fpCNkdEgC6RuMje/bBfD9h/BbAtq
 N/NUwXPN3KG/47bjwsSyOqY/tkDgB9ZEFbQJ8ZMqcfJ52W/ZOwbhSYtWXCnWKVT1FpvS
 W9+ev83jbj2TxRkRpgCKFyotznWuXytMZDa63SJzxj3URxUJEsCExlNPBrKjITqUG//v
 HZKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vPuDbIGBXxyIfcTk2Zum8utgtdb0qSqk7SriL8LXvf0=;
 b=cA24osENo4adu08ZFutV+fU1r01uwpobigGDqzArCPhVdma9jZig1pqLL+7trCGI9/
 fyPc1eLHloBap8kOkTkPDl7bZb3eVE0voOdkYn9vZ3+duvw5UjBoJVH6yjnFsoEBIvQN
 nNeXl8wERa82YmChuD/4fOyZxN1Pxtz8NufFelq6i6F+WI1RSO5jzxS0T30G16m1b3+S
 v8qea1ac6Fr2epHCaHtvv1+p0/sz0sae4i/OlcIa5RkyBxbIW3r/fX4tEFgVBhXYJQca
 TaFWE7ISDuhkdCJqNeje7S2zABLc+9dBbfMdjuoQ2vYeY7HVIT6c2QZl0AGLHoddLX+S
 VPmg==
X-Gm-Message-State: APjAAAX1NQVmwdBlqliM/euYPfPbmx4vEHuaoD6+EXmAuKvnEHbkBTq9
 BQ4MNHh/3xdCZxbRmErpaRBvmorxNQypbw==
X-Google-Smtp-Source: APXvYqzhPVySIca5Fdg2WEAVdjeefps69JRtaYNN4lvDxZKoHdePqMiFQba1MDmaZKKQVKUKMxg7zQ==
X-Received: by 2002:a5d:6a10:: with SMTP id m16mr4756842wru.411.1579878833983; 
 Fri, 24 Jan 2020 07:13:53 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F2A4600F739B6467D2A1C91.dip0.t-ipconnect.de.
 [2003:c5:8f2a:4600:f739:b646:7d2a:1c91])
 by smtp.gmail.com with ESMTPSA id z3sm7628473wrs.94.2020.01.24.07.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 07:13:53 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH V2] drm/amdgpu: allocate entities on demand
Date: Fri, 24 Jan 2020 16:15:41 +0100
Message-Id: <20200124151541.3429-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200124115311.8037-1-nirmoy.das@amd.com>
References: <20200124115311.8037-1-nirmoy.das@amd.com>
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

This patch tries to resolve entity/fences wastage by creating entity
only when needed.

v2: allocate memory for entity and fences together

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 231 ++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |   6 +-
 2 files changed, 122 insertions(+), 115 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 05c2af61e7de..d246ae9fe0eb 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -42,19 +42,12 @@ const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM] = {
 	[AMDGPU_HW_IP_VCN_JPEG]	=	1,
 };

-static int amdgpu_ctx_total_num_entities(void)
-{
-	unsigned i, num_entities = 0;
-
-	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
-		num_entities += amdgpu_ctx_num_entities[i];
-
-	return num_entities;
-}
-
 static int amdgpu_ctx_priority_permit(struct drm_file *filp,
 				      enum drm_sched_priority priority)
 {
+	if (priority < 0 || priority >= DRM_SCHED_PRIORITY_MAX)
+		return -EINVAL;
+
 	/* NORMAL and below are accessible by everyone */
 	if (priority <= DRM_SCHED_PRIORITY_NORMAL)
 		return 0;
@@ -68,64 +61,26 @@ static int amdgpu_ctx_priority_permit(struct drm_file *filp,
 	return -EACCES;
 }

-static int amdgpu_ctx_init(struct amdgpu_device *adev,
-			   enum drm_sched_priority priority,
-			   struct drm_file *filp,
-			   struct amdgpu_ctx *ctx)
+static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, const u32 hw_ip, const u32 ring)
 {
-	unsigned num_entities = amdgpu_ctx_total_num_entities();
-	unsigned i, j;
+	struct amdgpu_device *adev = ctx->adev;
+	struct amdgpu_ctx_entity *entity;
+	struct drm_gpu_scheduler **scheds = NULL, *sched = NULL;
+	unsigned num_scheds = 0;
+	enum drm_sched_priority priority;
 	int r;

-	if (priority < 0 || priority >= DRM_SCHED_PRIORITY_MAX)
-		return -EINVAL;
+	entity = kcalloc(1, offsetof(typeof(*entity), fences[amdgpu_sched_jobs]),
+			 GFP_KERNEL);
+	if (!entity)
+		return  -ENOMEM;

-	r = amdgpu_ctx_priority_permit(filp, priority);
-	if (r)
-		return r;
-
-	memset(ctx, 0, sizeof(*ctx));
-	ctx->adev = adev;
-
-
-	ctx->entities[0] = kcalloc(num_entities,
-				   sizeof(struct amdgpu_ctx_entity),
-				   GFP_KERNEL);
-	if (!ctx->entities[0])
-		return -ENOMEM;
+	entity->sequence = 1;

-
-	for (i = 0; i < num_entities; ++i) {
-		struct amdgpu_ctx_entity *entity = &ctx->entities[0][i];
-
-		entity->sequence = 1;
-		entity->fences = kcalloc(amdgpu_sched_jobs,
-					 sizeof(struct dma_fence*), GFP_KERNEL);
-		if (!entity->fences) {
-			r = -ENOMEM;
-			goto error_cleanup_memory;
-		}
-	}
-	for (i = 1; i < AMDGPU_HW_IP_NUM; ++i)
-		ctx->entities[i] = ctx->entities[i - 1] +
-			amdgpu_ctx_num_entities[i - 1];
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
+	ctx->entities[hw_ip][ring] = entity;
+	priority = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
+				ctx->init_priority : ctx->override_priority;
+	switch (hw_ip) {
 		case AMDGPU_HW_IP_GFX:
 			sched = &adev->gfx.gfx_ring[0].sched;
 			scheds = &sched;
@@ -166,63 +121,87 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
 			scheds = adev->jpeg.jpeg_sched;
 			num_scheds =  adev->jpeg.num_jpeg_sched;
 			break;
-		}
-
-		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j)
-			r = drm_sched_entity_init(&ctx->entities[i][j].entity,
-						  priority, scheds,
-						  num_scheds, &ctx->guilty);
-		if (r)
-			goto error_cleanup_entities;
 	}

+	r = drm_sched_entity_init(&ctx->entities[hw_ip][ring]->entity,
+				  priority, scheds,
+				  num_scheds, &ctx->guilty);
+	if (r)
+		goto error_free_entity;
+
 	return 0;

-error_cleanup_entities:
-	for (i = 0; i < num_entities; ++i)
-		drm_sched_entity_destroy(&ctx->entities[0][i].entity);
+error_free_entity:
+	kfree(ctx->entities[hw_ip][ring]);
+	return r;
+}

-error_cleanup_memory:
-	for (i = 0; i < num_entities; ++i) {
-		struct amdgpu_ctx_entity *entity = &ctx->entities[0][i];
+static int amdgpu_ctx_init(struct amdgpu_device *adev,
+			   enum drm_sched_priority priority,
+			   struct drm_file *filp,
+			   struct amdgpu_ctx *ctx)
+{
+	int r;

-		kfree(entity->fences);
-		entity->fences = NULL;
-	}
+	r = amdgpu_ctx_priority_permit(filp, priority);
+	if (r)
+		return r;
+
+	memset(ctx, 0, sizeof(*ctx));
+
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

-	kfree(ctx->entities[0]);
-	ctx->entities[0] = NULL;
-	return r;
 }

 static void amdgpu_ctx_fini(struct kref *ref)
 {
 	struct amdgpu_ctx *ctx = container_of(ref, struct amdgpu_ctx, refcount);
-	unsigned num_entities = amdgpu_ctx_total_num_entities();
 	struct amdgpu_device *adev = ctx->adev;
-	unsigned i, j;
+	unsigned i, j, k;

 	if (!adev)
 		return;

-	for (i = 0; i < num_entities; ++i) {
-		struct amdgpu_ctx_entity *entity = &ctx->entities[0][i];
+	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
+		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
+			struct amdgpu_ctx_entity *entity;
+
+			if (!ctx->entities[i] || !ctx->entities[i][j])
+				continue;

-		for (j = 0; j < amdgpu_sched_jobs; ++j)
-			dma_fence_put(entity->fences[j]);
+			entity = ctx->entities[i][j];
+			if (!entity->fences)
+				continue;

-		kfree(entity->fences);
+			for (k = 0; k < amdgpu_sched_jobs; ++k)
+				dma_fence_put(entity->fences[k]);
+
+			kfree(entity);
+			ctx->entities[i][j] = NULL;
+		}
 	}

-	kfree(ctx->entities[0]);
 	mutex_destroy(&ctx->lock);
-
 	kfree(ctx);
 }

 int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
 			  u32 ring, struct drm_sched_entity **entity)
 {
+	int r;
+
 	if (hw_ip >= AMDGPU_HW_IP_NUM) {
 		DRM_ERROR("unknown HW IP type: %d\n", hw_ip);
 		return -EINVAL;
@@ -239,7 +218,14 @@ int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
 		return -EINVAL;
 	}

-	*entity = &ctx->entities[hw_ip][ring].entity;
+	if (ctx->entities[hw_ip][ring] == NULL) {
+		r = amdgpu_ctx_init_entity(ctx, hw_ip, ring);
+		if (r)
+			return r;
+	}
+
+
+	*entity = &ctx->entities[hw_ip][ring]->entity;
 	return 0;
 }

@@ -279,14 +265,17 @@ static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
 static void amdgpu_ctx_do_release(struct kref *ref)
 {
 	struct amdgpu_ctx *ctx;
-	unsigned num_entities;
-	u32 i;
+	u32 i, j;

 	ctx = container_of(ref, struct amdgpu_ctx, refcount);
+	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
+		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
+			if (!ctx->entities[i][j])
+				continue;

-	num_entities = amdgpu_ctx_total_num_entities();
-	for (i = 0; i < num_entities; i++)
-		drm_sched_entity_destroy(&ctx->entities[0][i].entity);
+			drm_sched_entity_destroy(&ctx->entities[i][j]->entity);
+		}
+	}

 	amdgpu_ctx_fini(ref);
 }
@@ -516,19 +505,23 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
 void amdgpu_ctx_priority_override(struct amdgpu_ctx *ctx,
 				  enum drm_sched_priority priority)
 {
-	unsigned num_entities = amdgpu_ctx_total_num_entities();
 	enum drm_sched_priority ctx_prio;
-	unsigned i;
+	unsigned i, j;

 	ctx->override_priority = priority;

 	ctx_prio = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
 			ctx->init_priority : ctx->override_priority;
+	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
+		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
+			struct drm_sched_entity *entity;

-	for (i = 0; i < num_entities; i++) {
-		struct drm_sched_entity *entity = &ctx->entities[0][i].entity;
+			if (!ctx->entities[i][j])
+				continue;

-		drm_sched_entity_set_priority(entity, ctx_prio);
+			entity = &ctx->entities[i][j]->entity;
+			drm_sched_entity_set_priority(entity, ctx_prio);
+		}
 	}
 }

@@ -564,20 +557,24 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr)

 long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
 {
-	unsigned num_entities = amdgpu_ctx_total_num_entities();
 	struct amdgpu_ctx *ctx;
 	struct idr *idp;
-	uint32_t id, i;
+	uint32_t id, i, j;

 	idp = &mgr->ctx_handles;

 	mutex_lock(&mgr->lock);
 	idr_for_each_entry(idp, ctx, id) {
-		for (i = 0; i < num_entities; i++) {
-			struct drm_sched_entity *entity;
+		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
+			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
+				struct drm_sched_entity *entity;
+
+				if (!ctx->entities[i][j])
+					continue;

-			entity = &ctx->entities[0][i].entity;
-			timeout = drm_sched_entity_flush(entity, timeout);
+				entity = &ctx->entities[i][j]->entity;
+				timeout = drm_sched_entity_flush(entity, timeout);
+			}
 		}
 	}
 	mutex_unlock(&mgr->lock);
@@ -586,10 +583,9 @@ long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)

 void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
 {
-	unsigned num_entities = amdgpu_ctx_total_num_entities();
 	struct amdgpu_ctx *ctx;
 	struct idr *idp;
-	uint32_t id, i;
+	uint32_t id, i, j;

 	idp = &mgr->ctx_handles;

@@ -599,8 +595,17 @@ void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
 			continue;
 		}

-		for (i = 0; i < num_entities; i++)
-			drm_sched_entity_fini(&ctx->entities[0][i].entity);
+		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
+			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
+				struct drm_sched_entity *entity;
+
+				if (!ctx->entities[i][j])
+					continue;
+
+				entity = &ctx->entities[i][j]->entity;
+				drm_sched_entity_fini(entity);
+			}
+		}
 	}
 }

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index a6cd9d4b078c..de490f183af2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -29,10 +29,12 @@ struct drm_device;
 struct drm_file;
 struct amdgpu_fpriv;

+#define AMDGPU_MAX_ENTITY_NUM 4
+
 struct amdgpu_ctx_entity {
 	uint64_t		sequence;
-	struct dma_fence	**fences;
 	struct drm_sched_entity	entity;
+	struct dma_fence	*fences[];
 };

 struct amdgpu_ctx {
@@ -42,7 +44,7 @@ struct amdgpu_ctx {
 	unsigned			reset_counter_query;
 	uint32_t			vram_lost_counter;
 	spinlock_t			ring_lock;
-	struct amdgpu_ctx_entity	*entities[AMDGPU_HW_IP_NUM];
+	struct amdgpu_ctx_entity	*entities[AMDGPU_HW_IP_NUM][AMDGPU_MAX_ENTITY_NUM];
 	bool				preamble_presented;
 	enum drm_sched_priority		init_priority;
 	enum drm_sched_priority		override_priority;
--
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

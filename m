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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6694BC2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 16:29:53 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3650720704
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Jan 2020 16:29:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DbxKlGjv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3650720704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6B4072B1B;
	Fri, 24 Jan 2020 16:29:52 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC01E72B1B
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2020 16:29:51 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id m10so3859920wmc.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Jan 2020 08:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=3kKtYvwSyH6KnZYniMA/GlK8zB3aA87cJo1mUA7TWs4=;
 b=DbxKlGjvS/8BbDsqCnCgiefXrdlDS0z4pPauQoZtP4y00dp/c9T++i4i88Ga6YTUtY
 QYf9BO9Xcgn4hlENF/R1kkogxPRpJ/2DJ1ATdx/m2Lgal1Vi3Zf/spaUJn+zZIMhqiR6
 DmfhbHJmmk+rVI4eQucLWNcl04fmsJcmC8B9YHXwCLcfgcvHrr43T9WhJOXeqWhu67j4
 wDIQ0XdX6FNikBr5ojuu7DGQdt0QS82CwraC3D2hRLnm+9MHdBLLH8zXklfXBRpcSml0
 537SK0Tq6YTQdvXid6ujPhsBGHcdmck+k/TkOVduUZmJVo3wWiC6Gz0Q2t98VPTxnVBa
 TaFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3kKtYvwSyH6KnZYniMA/GlK8zB3aA87cJo1mUA7TWs4=;
 b=UL1MDFNmLrW6MlPnn7xHAjIlR7+7oFJDMEAoVE7/m9zsUKKz6ZylFXserTIZA/RA1q
 RU1TBBIDsInsEo2bbLs8d4X6+Ff0PERBRWyqXbhUwu90XB84ZTd4iAcOKShAmX6xftH4
 bCThw9IJspowhFMKxLEv/Dy5cJMcU1bwgCXzm6IggS1WFE9Hw9tBjNA8KO/Bd68/y8AL
 efjDp4VieYF8P+T3Vk6eT+EAwVgO+QeUB+ZKcaIjiumRjhcTN51ihYfjWPcxWqCPjLKj
 RZeVzaFQpufiUunRVwBt6NzWEXLRpByOydHga0/Actv8lMgxaZpZhlKGYsiynyKoccQn
 iWjQ==
X-Gm-Message-State: APjAAAVyXiBKSlYPmo2mxjDIvp/ume1OcOe7tkIxadWvCA7o8Ub0REVI
 ruhS74QKxnXDlsdoI76A1o1giCAVtszhjw==
X-Google-Smtp-Source: APXvYqxvjkpo5eteEcplAbJr2Ofdn/+CrP03jQz0eD6ScXbnPBGwSP22lRn85qh+EQRMgtP44p5Itw==
X-Received: by 2002:a1c:1b93:: with SMTP id b141mr65903wmb.114.1579883388564; 
 Fri, 24 Jan 2020 08:29:48 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F2A4600F739B6467D2A1C91.dip0.t-ipconnect.de.
 [2003:c5:8f2a:4600:f739:b646:7d2a:1c91])
 by smtp.gmail.com with ESMTPSA id x132sm14020395wmg.0.2020.01.24.08.29.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2020 08:29:48 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: allocate entities on demand
Date: Fri, 24 Jan 2020 17:31:35 +0100
Message-Id: <20200124163135.4012-1-nirmoy.das@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 235 ++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |   6 +-
 2 files changed, 124 insertions(+), 117 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 05c2af61e7de..94a6c42f29ea 100644
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
@@ -68,64 +61,24 @@ static int amdgpu_ctx_priority_permit(struct drm_file *filp,
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
-
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
-
+	entity = kcalloc(1, offsetof(typeof(*entity), fences[amdgpu_sched_jobs]),
+			 GFP_KERNEL);
+	if (!entity)
+		return  -ENOMEM;
 
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
+	entity->sequence = 1;
+	priority = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
+				ctx->init_priority : ctx->override_priority;
+	switch (hw_ip) {
 		case AMDGPU_HW_IP_GFX:
 			sched = &adev->gfx.gfx_ring[0].sched;
 			scheds = &sched;
@@ -166,63 +119,90 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
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
 
+	r = drm_sched_entity_init(&entity->entity, priority, scheds, num_scheds,
+				  &ctx->guilty);
+	if (r)
+		goto error_free_entity;
+
+	ctx->entities[hw_ip][ring] = entity;
 	return 0;
 
-error_cleanup_entities:
-	for (i = 0; i < num_entities; ++i)
-		drm_sched_entity_destroy(&ctx->entities[0][i].entity);
+error_free_entity:
+	kfree(entity);
 
-error_cleanup_memory:
-	for (i = 0; i < num_entities; ++i) {
-		struct amdgpu_ctx_entity *entity = &ctx->entities[0][i];
+	return r;
+}
 
-		kfree(entity->fences);
-		entity->fences = NULL;
-	}
+static int amdgpu_ctx_init(struct amdgpu_device *adev,
+			   enum drm_sched_priority priority,
+			   struct drm_file *filp,
+			   struct amdgpu_ctx *ctx)
+{
+	int r;
 
-	kfree(ctx->entities[0]);
-	ctx->entities[0] = NULL;
-	return r;
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
+
+}
+
+static void amdgpu_ctx_fini_entity(struct amdgpu_ctx_entity *entity)
+{
+
+	int i;
+
+	if (!entity)
+		return;
+
+	for (i = 0; i < amdgpu_sched_jobs; ++i)
+		dma_fence_put(entity->fences[i]);
+
+	kfree(entity);
 }
 
 static void amdgpu_ctx_fini(struct kref *ref)
 {
 	struct amdgpu_ctx *ctx = container_of(ref, struct amdgpu_ctx, refcount);
-	unsigned num_entities = amdgpu_ctx_total_num_entities();
 	struct amdgpu_device *adev = ctx->adev;
 	unsigned i, j;
 
 	if (!adev)
 		return;
 
-	for (i = 0; i < num_entities; ++i) {
-		struct amdgpu_ctx_entity *entity = &ctx->entities[0][i];
-
-		for (j = 0; j < amdgpu_sched_jobs; ++j)
-			dma_fence_put(entity->fences[j]);
-
-		kfree(entity->fences);
+	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
+		for (j = 0; j < AMDGPU_MAX_ENTITY_NUM; ++j) {
+			amdgpu_ctx_fini_entity(ctx->entities[i][j]);
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
@@ -239,7 +219,13 @@ int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
 		return -EINVAL;
 	}
 
-	*entity = &ctx->entities[hw_ip][ring].entity;
+	if (ctx->entities[hw_ip][ring] == NULL) {
+		r = amdgpu_ctx_init_entity(ctx, hw_ip, ring);
+		if (r)
+			return r;
+	}
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

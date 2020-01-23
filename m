Return-Path: <SRS0=UzQs=3M=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4489EC2D0DB
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 16:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 185C921835
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Jan 2020 16:11:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hFJxyjI4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 185C921835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B07A6E0BC;
	Thu, 23 Jan 2020 16:11:20 +0000 (UTC)
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com
 [IPv6:2a00:1450:4864:20::444])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 130AA6E0BC
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2020 16:11:19 +0000 (UTC)
Received: by mail-wr1-x444.google.com with SMTP id z7so3665505wrl.13
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Jan 2020 08:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=588CInz53ChIDSKgVTjSYpVhzhqrJ2cqdUAgEGVSaqM=;
 b=hFJxyjI4bNzwDRE0/+mS54pXlAWUDD6D3vSqvP55ceos/m8esBrsT4nK9DBz0mS2bt
 f1KDlcRNhCBZgTNT1zn5oVKi67VwCgqZ2mquEYVcto1NySZj9QobTqUaObpsbDzL7p5S
 K2lNE7YoqG4BHrmJ1RNbQ6ye77ezZHbGX/Wkkii3IOnOc7kXQpevtZHSsQzh4RskKZ+G
 auVHeAeSqv8yfsqeMeCmfg9G+QuN5Fm6WbqdvHCfCSOzl3cL9NG7/fqI2FyE2bEbJoQG
 clmN8WQdJgF78M7dIdmyIfDUnGVmR5013djnfWRB6aJN7eF7fK380lmFO5xEaW+Y0af8
 oi+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=588CInz53ChIDSKgVTjSYpVhzhqrJ2cqdUAgEGVSaqM=;
 b=lxYl4ARFolB5MVjul8qc1FfijdQo4cy1MsHZwoO+UbD/qUZVNUP8251nywp+8FBwP9
 6cfhh1/6YUOwTUKRP+bDNKeqLgCPMwR9ZhXVsK50quAHQRhlW3EadwwfFwD6QT4LO5Zj
 gHrCEAwjKss+c4sY9uVpn17MzAjty4CvzuyyQu7VApCnldGHqb3mbWST2++4Ig5NzABX
 xWnVvorQJLMbq+MIhFboHSZFCfs3UCwTiH3QOJrBDL/jj69ZUZ6cERjo2cUYMA9UEO71
 xLCd32olEppAhe/1VQG0lt5E+eEm2POEGeRaW0I3OGhrteJU+R382/KPB0KfcaCLrqnC
 GggA==
X-Gm-Message-State: APjAAAWmplS/Wn4GjsPTCDTfhdFdxd3h0jv4Gd5M3EjdIAXk8Iv56WxM
 MM/fJRrd44ofK0/9stYNDsqe2SrZpn4bhA==
X-Google-Smtp-Source: APXvYqwAEF8OK6/ZUbqFg6IXUo5sGynKwTGTyzKR3dwaPbHDpgk0eqNJe+V5CPFSYX4zVVQVPb/fIQ==
X-Received: by 2002:adf:e58b:: with SMTP id l11mr18204212wrm.402.1579795877247; 
 Thu, 23 Jan 2020 08:11:17 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F2ACE0086E1C567EDDDB320.dip0.t-ipconnect.de.
 [2003:c5:8f2a:ce00:86e1:c567:eddd:b320])
 by smtp.gmail.com with ESMTPSA id 60sm3735117wrn.86.2020.01.23.08.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jan 2020 08:11:16 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amdgpu: allocate entities on demand
Date: Thu, 23 Jan 2020 17:13:00 +0100
Message-Id: <20200123161300.31237-1-nirmoy.das@amd.com>
X-Mailer: git-send-email 2.24.1
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

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 244 +++++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |   2 +-
 2 files changed, 135 insertions(+), 111 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 05c2af61e7de..73f7615df8c1 100644
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
@@ -68,64 +61,44 @@ static int amdgpu_ctx_priority_permit(struct drm_file *filp,
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
+	struct drm_gpu_scheduler **scheds;
+	struct drm_gpu_scheduler *sched;
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
+	if (!ctx->entities[hw_ip]) {
+		ctx->entities[hw_ip] = kcalloc(amdgpu_ctx_num_entities[hw_ip],
+					       sizeof(struct amdgpu_ctx_entity *),
+					       GFP_KERNEL);
+		if (!ctx->entities[hw_ip])
+			return  -ENOMEM;
 	}
-	for (i = 1; i < AMDGPU_HW_IP_NUM; ++i)
-		ctx->entities[i] = ctx->entities[i - 1] +
-			amdgpu_ctx_num_entities[i - 1];
 
-	kref_init(&ctx->refcount);
-	spin_lock_init(&ctx->ring_lock);
-	mutex_init(&ctx->lock);
+	ctx->entities[hw_ip][ring] = kcalloc(1, sizeof(struct amdgpu_ctx_entity),
+					     GFP_KERNEL);
+	if (!ctx->entities[hw_ip][ring]) {
+		r = -ENOMEM;
+		goto error_free_entity;
+	}
 
-	ctx->reset_counter = atomic_read(&adev->gpu_reset_counter);
-	ctx->reset_counter_query = ctx->reset_counter;
-	ctx->vram_lost_counter = atomic_read(&adev->vram_lost_counter);
-	ctx->init_priority = priority;
-	ctx->override_priority = DRM_SCHED_PRIORITY_UNSET;
+	entity = ctx->entities[hw_ip][ring];
 
-	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
-		struct drm_gpu_scheduler **scheds;
-		struct drm_gpu_scheduler *sched;
-		unsigned num_scheds = 0;
+	entity->sequence = 1;
+	entity->fences = kcalloc(amdgpu_sched_jobs,
+				 sizeof(struct dma_fence*), GFP_KERNEL);
+	if (!entity->fences) {
+		r = -ENOMEM;
+		goto error_free_entity;
+	}
 
-		switch (i) {
+	priority = (ctx->override_priority == DRM_SCHED_PRIORITY_UNSET) ?
+				ctx->init_priority : ctx->override_priority;
+	switch (hw_ip) {
 		case AMDGPU_HW_IP_GFX:
 			sched = &adev->gfx.gfx_ring[0].sched;
 			scheds = &sched;
@@ -166,57 +139,85 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
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
+
+			entity = ctx->entities[i][j];
+			if (!entity->fences)
+				continue;
 
-		for (j = 0; j < amdgpu_sched_jobs; ++j)
-			dma_fence_put(entity->fences[j]);
+			for (k = 0; k < amdgpu_sched_jobs; ++k)
+				dma_fence_put(entity->fences[k]);
 
-		kfree(entity->fences);
+			kfree(entity->fences);
+			entity->fences = NULL;
+
+			kfree(entity);
+			ctx->entities[i][j] = NULL;
+		}
+
+		kfree(ctx->entities[i];
+		ctx->entities[i] = NULL;
 	}
 
-	kfree(ctx->entities[0]);
 	mutex_destroy(&ctx->lock);
-
 	kfree(ctx);
 }
 
@@ -239,7 +240,11 @@ int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
 		return -EINVAL;
 	}
 
-	*entity = &ctx->entities[hw_ip][ring].entity;
+	if ((ctx->entities[hw_ip] == NULL) || (ctx->entities[hw_ip][ring] == NULL))
+		amdgpu_ctx_init_entity(ctx, hw_ip, ring);
+
+
+	*entity = &ctx->entities[hw_ip][ring]->entity;
 	return 0;
 }
 
@@ -279,14 +284,17 @@ static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
 static void amdgpu_ctx_do_release(struct kref *ref)
 {
 	struct amdgpu_ctx *ctx;
-	unsigned num_entities;
-	u32 i;
+	u32 i, j;
 
 	ctx = container_of(ref, struct amdgpu_ctx, refcount);
+	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
+		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
+			if (!ctx->entities[i] || !ctx->entities[i][j])
+				continue;
 
-	num_entities = amdgpu_ctx_total_num_entities();
-	for (i = 0; i < num_entities; i++)
-		drm_sched_entity_destroy(&ctx->entities[0][i].entity);
+			drm_sched_entity_destroy(&ctx->entities[i][j]->entity);
+		}
+	}
 
 	amdgpu_ctx_fini(ref);
 }
@@ -516,19 +524,23 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
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
+			if (!ctx->entities[i] || !ctx->entities[i][j])
+				continue;
 
-		drm_sched_entity_set_priority(entity, ctx_prio);
+			entity = &ctx->entities[i][j]->entity;
+			drm_sched_entity_set_priority(entity, ctx_prio);
+		}
 	}
 }
 
@@ -564,20 +576,24 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr)
 
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
+				if (!ctx->entities[i] || !ctx->entities[i][j])
+					continue;
 
-			entity = &ctx->entities[0][i].entity;
-			timeout = drm_sched_entity_flush(entity, timeout);
+				entity = &ctx->entities[i][j]->entity;
+				timeout = drm_sched_entity_flush(entity, timeout);
+			}
 		}
 	}
 	mutex_unlock(&mgr->lock);
@@ -586,10 +602,9 @@ long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
 
 void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
 {
-	unsigned num_entities = amdgpu_ctx_total_num_entities();
 	struct amdgpu_ctx *ctx;
 	struct idr *idp;
-	uint32_t id, i;
+	uint32_t id, i, j;
 
 	idp = &mgr->ctx_handles;
 
@@ -599,8 +614,17 @@ void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
 			continue;
 		}
 
-		for (i = 0; i < num_entities; i++)
-			drm_sched_entity_fini(&ctx->entities[0][i].entity);
+		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
+			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
+				struct drm_sched_entity *entity;
+
+				if (!ctx->entities[i] || !ctx->entities[i][j])
+					continue;
+
+				entity = &ctx->entities[i][j]->entity;
+				drm_sched_entity_fini(entity);
+			}
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index a6cd9d4b078c..ca9363e71df5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -42,7 +42,7 @@ struct amdgpu_ctx {
 	unsigned			reset_counter_query;
 	uint32_t			vram_lost_counter;
 	spinlock_t			ring_lock;
-	struct amdgpu_ctx_entity	*entities[AMDGPU_HW_IP_NUM];
+	struct amdgpu_ctx_entity	**entities[AMDGPU_HW_IP_NUM];
 	bool				preamble_presented;
 	enum drm_sched_priority		init_priority;
 	enum drm_sched_priority		override_priority;
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

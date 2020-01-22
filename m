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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6975C33CB6
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 09:31:50 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990AB24685
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2020 09:31:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="em9Rvf1g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990AB24685
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 520266F441;
	Wed, 22 Jan 2020 09:31:50 +0000 (UTC)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E8846F441
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 09:31:49 +0000 (UTC)
Received: by mail-wm1-x342.google.com with SMTP id d139so3960003wmd.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2020 01:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iEeRlPV1p5cXVTcNZeGj3xjnPrq8cw7t1wqpEH98DBY=;
 b=em9Rvf1gK+LTIxwY4FgU8ZDFXQ6ModC71vHTMqG1ZBXTTrQDySpCSdLGySK0tzWvmL
 NbAMOzJfjyNKfwBc7a8OoVxtPA1PttiHrnKdPdicbE8QtU+F5sxD3rd2vs6gEhRRPcQU
 kbXUcnQ9BAlhIF2/H/nCLNTHl3zJcdE5oemYkB0PENKzUMgY3j21Jr88QKIX1+sRMR/L
 3IdLZqU+0VQuTF9EwZLHTSh03A2jAoCgUPoitIvH0WC9RRiF8eEiI8U0bSdOafg63UfZ
 WT62xfRnve8pAJJ6BoCrIUU460TpL5QLce2Q7lQw7/l/T5hvpaTcyk8OTvik3i3pAEkM
 urqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=iEeRlPV1p5cXVTcNZeGj3xjnPrq8cw7t1wqpEH98DBY=;
 b=OXOqT7EPelsvRTB2DLO8UOUHEF+q2tWZjoU7EBxJF0p+krQgKbEHTdM6kSH8fKDuIV
 PxB959tm0Wc/BGbREtxPrD/8XWagAr/h4dcLGGt59tIs+7xMm2qtQ5qCkCEdPWQ/sEx0
 rfZebsIr+/3YUdjUCGOyTn1Hiv2dgcrfzrRIghY600GJsfIqpojMztmy+KjuSSzefeRy
 8/k0YIq9y39HPzTGKcE2nDz8eF/mMBow88MMQzcp29Ux+wjqXF+LcId/7xBiHaBXhsge
 EH/ZyMTGhHhvPdadkJ9qZm5QBfDsX1PhKcf+ut+CN2b9K7G5OpKgoPpwWt2gwBHUrISw
 bmFQ==
X-Gm-Message-State: APjAAAWHFmyQ8AiYzFxRRuFKWZL6uReYJZs9HYPkWZwcJ/SlY8sZDz7G
 OQ/h+0Eom1ETyYvjmhEJTp/kh60FlOHvqg==
X-Google-Smtp-Source: APXvYqyAKPRFZDhs6yKUifYpy+elB0x+K37MeUjlp6m48i5IWXouH4owGbU0u/iLYNhbnIz/Ar6P1Q==
X-Received: by 2002:a1c:c919:: with SMTP id f25mr1956991wmb.49.1579685507662; 
 Wed, 22 Jan 2020 01:31:47 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F2957000A0F1FDBBC5B14D8.dip0.t-ipconnect.de.
 [2003:c5:8f29:5700:a0f:1fdb:bc5b:14d8])
 by smtp.gmail.com with ESMTPSA id i5sm3169234wml.31.2020.01.22.01.31.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jan 2020 01:31:47 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: individualize amdgpu entity allocation per HW
 IP
Date: Wed, 22 Jan 2020 10:33:05 +0100
Message-Id: <20200122093306.16737-1-nirmoy.das@amd.com>
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

Do not allocate all the entity at once. This is required for
dynamic amdgpu_ctx_entity creation.

Signed-off-by: Nirmoy Das <nirmoy.das@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 143 +++++++++++++-----------
 1 file changed, 76 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 05c2af61e7de..eecbd68db986 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -42,16 +42,6 @@ const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM] = {
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
@@ -73,7 +63,6 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
 			   struct drm_file *filp,
 			   struct amdgpu_ctx *ctx)
 {
-	unsigned num_entities = amdgpu_ctx_total_num_entities();
 	unsigned i, j;
 	int r;
 
@@ -87,28 +76,30 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
 	memset(ctx, 0, sizeof(*ctx));
 	ctx->adev = adev;
 
+	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
+		ctx->entities[i] = kcalloc(amdgpu_ctx_num_entities[i],
+					   sizeof(struct amdgpu_ctx_entity),
+					   GFP_KERNEL);
 
-	ctx->entities[0] = kcalloc(num_entities,
-				   sizeof(struct amdgpu_ctx_entity),
-				   GFP_KERNEL);
-	if (!ctx->entities[0])
-		return -ENOMEM;
-
-
-	for (i = 0; i < num_entities; ++i) {
-		struct amdgpu_ctx_entity *entity = &ctx->entities[0][i];
+		if (!ctx->entities[0]) {
+			r =  -ENOMEM;
+			goto error_cleanup_entity_memory;
+		}
+	}
 
-		entity->sequence = 1;
-		entity->fences = kcalloc(amdgpu_sched_jobs,
-					 sizeof(struct dma_fence*), GFP_KERNEL);
-		if (!entity->fences) {
-			r = -ENOMEM;
-			goto error_cleanup_memory;
+	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
+		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
+			struct amdgpu_ctx_entity *entity = &ctx->entities[i][j];
+
+			entity->sequence = 1;
+			entity->fences = kcalloc(amdgpu_sched_jobs,
+						 sizeof(struct dma_fence*), GFP_KERNEL);
+			if (!entity->fences) {
+				r = -ENOMEM;
+				goto error_cleanup_memory;
+			}
 		}
 	}
-	for (i = 1; i < AMDGPU_HW_IP_NUM; ++i)
-		ctx->entities[i] = ctx->entities[i - 1] +
-			amdgpu_ctx_num_entities[i - 1];
 
 	kref_init(&ctx->refcount);
 	spin_lock_init(&ctx->ring_lock);
@@ -179,44 +170,55 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
 	return 0;
 
 error_cleanup_entities:
-	for (i = 0; i < num_entities; ++i)
-		drm_sched_entity_destroy(&ctx->entities[0][i].entity);
+	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
+		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j)
+			drm_sched_entity_destroy(&ctx->entities[i][j].entity);
+	}
 
 error_cleanup_memory:
-	for (i = 0; i < num_entities; ++i) {
-		struct amdgpu_ctx_entity *entity = &ctx->entities[0][i];
+	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
+		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
+			struct amdgpu_ctx_entity *entity = &ctx->entities[i][j];
 
-		kfree(entity->fences);
-		entity->fences = NULL;
+			kfree(entity->fences);
+			entity->fences = NULL;
+		}
+	}
+
+error_cleanup_entity_memory:
+	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
+		kfree(ctx->entities[i]);
+		ctx->entities[i] = NULL;
 	}
 
-	kfree(ctx->entities[0]);
-	ctx->entities[0] = NULL;
 	return r;
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
+	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
+		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
+			struct amdgpu_ctx_entity *entity = &ctx->entities[i][j];
 
-	for (i = 0; i < num_entities; ++i) {
-		struct amdgpu_ctx_entity *entity = &ctx->entities[0][i];
+			for (k = 0; k < amdgpu_sched_jobs; ++k)
+				dma_fence_put(entity->fences[k]);
 
-		for (j = 0; j < amdgpu_sched_jobs; ++j)
-			dma_fence_put(entity->fences[j]);
+			kfree(entity->fences);
+		}
+	}
 
-		kfree(entity->fences);
+	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
+		kfree(ctx->entities[i]);
+		ctx->entities[i] = NULL;
 	}
 
-	kfree(ctx->entities[0]);
 	mutex_destroy(&ctx->lock);
-
 	kfree(ctx);
 }
 
@@ -279,14 +281,13 @@ static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
 static void amdgpu_ctx_do_release(struct kref *ref)
 {
 	struct amdgpu_ctx *ctx;
-	unsigned num_entities;
-	u32 i;
+	u32 i, j;
 
 	ctx = container_of(ref, struct amdgpu_ctx, refcount);
-
-	num_entities = amdgpu_ctx_total_num_entities();
-	for (i = 0; i < num_entities; i++)
-		drm_sched_entity_destroy(&ctx->entities[0][i].entity);
+	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
+		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j)
+			drm_sched_entity_destroy(&ctx->entities[i][j].entity);
+	}
 
 	amdgpu_ctx_fini(ref);
 }
@@ -516,19 +517,21 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
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
 
-	for (i = 0; i < num_entities; i++) {
-		struct drm_sched_entity *entity = &ctx->entities[0][i].entity;
+			struct drm_sched_entity *entity =
+				&ctx->entities[i][j].entity;
 
-		drm_sched_entity_set_priority(entity, ctx_prio);
+			drm_sched_entity_set_priority(entity, ctx_prio);
+		}
 	}
 }
 
@@ -564,20 +567,21 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr)
 
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
 
-			entity = &ctx->entities[0][i].entity;
-			timeout = drm_sched_entity_flush(entity, timeout);
+				entity = &ctx->entities[i][j].entity;
+				timeout = drm_sched_entity_flush(entity, timeout);
+			}
 		}
 	}
 	mutex_unlock(&mgr->lock);
@@ -586,10 +590,9 @@ long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
 
 void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
 {
-	unsigned num_entities = amdgpu_ctx_total_num_entities();
 	struct amdgpu_ctx *ctx;
 	struct idr *idp;
-	uint32_t id, i;
+	uint32_t id, i, j;
 
 	idp = &mgr->ctx_handles;
 
@@ -599,8 +602,14 @@ void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
 			continue;
 		}
 
-		for (i = 0; i < num_entities; i++)
-			drm_sched_entity_fini(&ctx->entities[0][i].entity);
+		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
+			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
+				struct drm_sched_entity *entity;
+
+				entity = &ctx->entities[i][j].entity;
+				drm_sched_entity_fini(entity);
+			}
+		}
 	}
 }
 
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

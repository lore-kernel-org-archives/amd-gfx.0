Return-Path: <SRS0=lIYJ=3K=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7423C2D0CE
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 16:48:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B9F24653
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Jan 2020 16:48:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jEpFt5og"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B9F24653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D7836EDBA;
	Tue, 21 Jan 2020 16:48:24 +0000 (UTC)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20::341])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7DC046EDBA
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 16:48:23 +0000 (UTC)
Received: by mail-wm1-x341.google.com with SMTP id p17so3900951wma.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Jan 2020 08:48:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lvzmlNofZHwitlY0yE794Cvg0fL4bFwuB5xkz1rqk+g=;
 b=jEpFt5og17N4GqDIoOKe38X9sOppPPgOkpD06SakGxgD36nJ4ZtTXFgSDi4skZIx8A
 hBOT8x89lohmI4ylq1ASQl7F/M3IGfUie7UZuTdmF/lbAn2qzpvmG/desEubsW3CVdeA
 fHcrHXzpcnGjhdNcA9r5pcU3IyfQFMaOV644sbkFZW6Jv4gGAsyzqCglROTHrQ6Tpmqn
 xEH8JlJV0k563K1kDK4/SoWhxyE+8ZCt9Im0zhV6r0Fodi+hwvmmW7hBdXNWFnUagS8Z
 LXxOTzJW5tJU+5TD+YWP6mFVG9QeBrPEVdPHuvhmAaxBvjpt+wdJO5SVCapPYyTDLm7w
 M4hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=lvzmlNofZHwitlY0yE794Cvg0fL4bFwuB5xkz1rqk+g=;
 b=KL4PUu/nG8hvnuYDPEjrx1RVfseEG8nOfrvuR4A9r8vmi4kJuDsh/pDL2flONiFJgy
 5ufgpLjhPo9KOGf9NwDA0a/S5pVnbM5iXthy9RWVb5HJW3EIYqO0RaXWeHrBP6gtt4yU
 lbiJAKwTsHnkd3lDlQ5ujpf/VPSaHZDGtnXfCdBwVRu0fQ7vTKckN190duWd38iX3FrX
 JmoseeVHzJqleSXEHH0fv+qk3IPCmY54N72TRp/cmUpyJCNFmcU+Sgn6trf1Yu2NaxmE
 A3A6af8P+/7Px3gyo1WKSvUTw+XAPi4qrX5IPjGMePbQtu4gPNxdaaWCsGfBf6r6KCfP
 4eAA==
X-Gm-Message-State: APjAAAUaIlzPPDnqS0ZLq0zyF2bi647oq4K80AH0Uw5H4YACC7gFEsI2
 Lp8CX9W2jS/Fa3b6zd60c8s7ZuF436E+3A==
X-Google-Smtp-Source: APXvYqxSuwbSFPhFF4Z/4P9TYMMTIZqtE04vKezb6V5khvm6HfAAVoi/E5h7kLRFIkSOGhiiNZI9Xw==
X-Received: by 2002:a1c:f31a:: with SMTP id q26mr5088709wmq.142.1579625301744; 
 Tue, 21 Jan 2020 08:48:21 -0800 (PST)
Received: from brihaspati.fritz.box
 (p200300C58F2C5700EF9508483D6EB58B.dip0.t-ipconnect.de.
 [2003:c5:8f2c:5700:ef95:848:3d6e:b58b])
 by smtp.gmail.com with ESMTPSA id b17sm52595456wrp.49.2020.01.21.08.48.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jan 2020 08:48:21 -0800 (PST)
From: Nirmoy Das <nirmoy.aiemd@gmail.com>
X-Google-Original-From: Nirmoy Das <nirmoy.das@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: individualize amdgpu entity allocation per HW
 IP
Date: Tue, 21 Jan 2020 17:50:01 +0100
Message-Id: <20200121165002.3709-1-nirmoy.das@amd.com>
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
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 130 ++++++++++++------------
 1 file changed, 65 insertions(+), 65 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 05c2af61e7de..91638a2a5163 100644
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
 
@@ -87,28 +76,29 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
 	memset(ctx, 0, sizeof(*ctx));
 	ctx->adev = adev;
 
-
-	ctx->entities[0] = kcalloc(num_entities,
+	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
+		ctx->entities[i] = kcalloc(amdgpu_ctx_num_entities[i],
 				   sizeof(struct amdgpu_ctx_entity),
 				   GFP_KERNEL);
-	if (!ctx->entities[0])
-		return -ENOMEM;
 
+		if (!ctx->entities[0]) {
+			r =  -ENOMEM;
+			goto error_cleanup_entity_memory;
+		}
+	}
+	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
+		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
 
-	for (i = 0; i < num_entities; ++i) {
-		struct amdgpu_ctx_entity *entity = &ctx->entities[0][i];
+			struct amdgpu_ctx_entity *entity = &ctx->entities[i][j];
 
-		entity->sequence = 1;
-		entity->fences = kcalloc(amdgpu_sched_jobs,
+			entity->sequence = 1;
+			entity->fences = kcalloc(amdgpu_sched_jobs,
 					 sizeof(struct dma_fence*), GFP_KERNEL);
-		if (!entity->fences) {
-			r = -ENOMEM;
-			goto error_cleanup_memory;
+			if (!entity->fences) {
+				r = -ENOMEM;
+				goto error_cleanup_memory;
+			}
 		}
-	}
-	for (i = 1; i < AMDGPU_HW_IP_NUM; ++i)
-		ctx->entities[i] = ctx->entities[i - 1] +
-			amdgpu_ctx_num_entities[i - 1];
 
 	kref_init(&ctx->refcount);
 	spin_lock_init(&ctx->ring_lock);
@@ -179,44 +169,52 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
 	return 0;
 
 error_cleanup_entities:
-	for (i = 0; i < num_entities; ++i)
-		drm_sched_entity_destroy(&ctx->entities[0][i].entity);
+	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
+		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j)
+			drm_sched_entity_destroy(&ctx->entities[i][j].entity);
 
 error_cleanup_memory:
-	for (i = 0; i < num_entities; ++i) {
-		struct amdgpu_ctx_entity *entity = &ctx->entities[0][i];
+	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
+		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
+			struct amdgpu_ctx_entity *entity = &ctx->entities[i][j];
 
-		kfree(entity->fences);
-		entity->fences = NULL;
+			kfree(entity->fences);
+			entity->fences = NULL;
+		}
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
+	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
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
 
@@ -279,14 +277,12 @@ static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
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
+	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
+		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j)
+			drm_sched_entity_destroy(&ctx->entities[i][j].entity);
 
 	amdgpu_ctx_fini(ref);
 }
@@ -516,20 +512,21 @@ struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
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
+	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
+		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
 
-	for (i = 0; i < num_entities; i++) {
-		struct drm_sched_entity *entity = &ctx->entities[0][i].entity;
+			struct drm_sched_entity *entity =
+				&ctx->entities[i][j].entity;
 
-		drm_sched_entity_set_priority(entity, ctx_prio);
-	}
+			drm_sched_entity_set_priority(entity, ctx_prio);
+		}
 }
 
 int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx,
@@ -564,20 +561,20 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr)
 
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
+		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
+			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
+				struct drm_sched_entity *entity;
 
-			entity = &ctx->entities[0][i].entity;
-			timeout = drm_sched_entity_flush(entity, timeout);
+				entity = &ctx->entities[i][j].entity;
+				timeout = drm_sched_entity_flush(entity, timeout);
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
 
@@ -598,9 +594,13 @@ void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
 			DRM_ERROR("ctx %p is still alive\n", ctx);
 			continue;
 		}
+		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
+			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
+				struct drm_sched_entity *entity;
 
-		for (i = 0; i < num_entities; i++)
-			drm_sched_entity_fini(&ctx->entities[0][i].entity);
+				entity = &ctx->entities[i][j].entity;
+				drm_sched_entity_fini(entity);
+			}
 	}
 }
 
-- 
2.24.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

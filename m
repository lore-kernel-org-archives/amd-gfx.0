Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B71FC433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 11 May 2022 12:02:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1A2E10E41A;
	Wed, 11 May 2022 12:02:55 +0000 (UTC)
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com
 [IPv6:2a00:1450:4864:20::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 88D4910E419
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 12:02:54 +0000 (UTC)
Received: by mail-ej1-x62c.google.com with SMTP id bv19so3578197ejb.6
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 May 2022 05:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g0etqpz4M4URxFbgNiLjVqBMW9vYCGuI+YjLShhob6Q=;
 b=N71f+mr9jQfUefr3YoVCaoQOn9vAsgs/szbuOgYOsN2ASWRYPOl8jFtrLqIPiPQawO
 3p7MbBJSkR7kd+nQ1Nl9B6HdhjbeLwFrWS1uL/jleY0pKyLsZ3firfyeqthjtwuzdOHN
 Y4Qr2rQIH0RBI1VDb8zopIllvS/LBiHcKf/q9H9nGhxix+zWsKY1vdAR0mv89VohqvCS
 8QnyAWmIsRLRijMF22P2LXFrQiZ61cLyVZfBSu9XX9j3K+WhxKkurKYFEYaR2+dghWIi
 E/4UkgGEj+9WBjDe157bq5r5mpPq40Xzh6wW30knXkQQstEtgR58GEzwRq5L2fYRtWuS
 OINw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=g0etqpz4M4URxFbgNiLjVqBMW9vYCGuI+YjLShhob6Q=;
 b=pp+Oc78fCMxOZmr7v3ad0CD731p2FlX4+GRdaK6heKX++mtsxF1IXPuOkMb3+0oBNW
 VltOew1ZnxqBxmBGDyK3dP930WkcoPrTCoX53SrYgo5e+1+9ESOksBTmCOq3mBiSOeuo
 e3cCZwb6b00Xxnw9JNSAf2L8l4s4sHe5Essy+KWsY58+ezQzaLqU/U/Vz41qyaq9t+aL
 Jcwtt7efOPK34rTP8Hjx5w2PQrnbMQkQb2nDHHv5vydUCgmsOZ/hDS4+T7Z6R6lA8QlA
 q5PxYrw8tBWvbSv96S5WUGdXUrMjB7hm6qH8+LGHOuimURO/y0jE6H6Y195XBPEq4nHE
 lqkQ==
X-Gm-Message-State: AOAM531opAamcDwa22BaRlkM0ZfyaguKEZiYSglk2aULnQIPa4ppd7y5
 IYd2VU4lxNG0PYHfjVukjT+HRn6gveI=
X-Google-Smtp-Source: ABdhPJwKRI1S5pQMl9Q2kYOa2jNOVwQaKGt6dAwUS2f/irmJ0nulTZzuIFGXD4vs736o1KH9asE+1Q==
X-Received: by 2002:a17:907:1c0f:b0:6f5:fd1:39cd with SMTP id
 nc15-20020a1709071c0f00b006f50fd139cdmr24774422ejc.516.1652270572758; 
 Wed, 11 May 2022 05:02:52 -0700 (PDT)
Received: from able.fritz.box (p57b0be56.dip0.t-ipconnect.de. [87.176.190.86])
 by smtp.gmail.com with ESMTPSA id
 i3-20020aa7c703000000b0042617ba638esm1132424edq.24.2022.05.11.05.02.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 May 2022 05:02:52 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: Convert to common fdinfo format v3
Date: Wed, 11 May 2022 14:02:49 +0200
Message-Id: <20220511120250.3066-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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
Cc: tvrtko.ursulin@linux.intel.com, Shashank.Sharma@amd.com, daniel@ffwll.ch,
 Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David M Nieto <David.Nieto@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Convert fdinfo format to one documented in drm-usage-stats.rst.

It turned out that the existing implementation was actually completely
nonsense. The calculated percentages indeed represented the usage of the
engine, but with varying time slices.

So 10% usage for application A could mean something completely different
than 10% usage for application B.

Completely nuke that and just use the now standardized nanosecond
interface.

v2: drop the documentation change for now, nuke percentage calculation
v3: only account for each hw_ip, move the time_spend to the ctx mgr.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Cc: David M Nieto <David.Nieto@amd.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 234 ++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |  23 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  41 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c    |   2 +-
 5 files changed, 153 insertions(+), 149 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 01853431249d..43b97ad3c6be 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -1239,7 +1239,7 @@ static int amdgpu_cs_submit(struct amdgpu_cs_parser *p,
 
 	p->fence = dma_fence_get(&job->base.s_fence->finished);
 
-	amdgpu_ctx_add_fence(p->ctx, entity, p->fence, &seq);
+	seq = amdgpu_ctx_add_fence(&fpriv->ctx_mgr, p->ctx, entity, p->fence);
 	amdgpu_cs_post_dependencies(p);
 
 	if ((job->preamble_status & AMDGPU_PREAMBLE_IB_PRESENT) &&
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 8f0e6d93bb9c..5a0d67cc3d75 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -135,9 +135,9 @@ static enum amdgpu_ring_priority_level amdgpu_ctx_sched_prio_to_ring_prio(int32_
 
 static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
 {
-	struct amdgpu_device *adev = ctx->adev;
-	int32_t ctx_prio;
+	struct amdgpu_device *adev = ctx->mgr->adev;
 	unsigned int hw_prio;
+	int32_t ctx_prio;
 
 	ctx_prio = (ctx->override_priority == AMDGPU_CTX_PRIORITY_UNSET) ?
 			ctx->init_priority : ctx->override_priority;
@@ -162,17 +162,49 @@ static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
 	return hw_prio;
 }
 
+/* Calculate the time spend on the hw */
+static ktime_t amdgpu_ctx_fence_time(struct dma_fence *fence)
+{
+	struct drm_sched_fence *s_fence;
+
+	if (!fence)
+		return ns_to_ktime(0);
+
+	/* When the fence is not even scheduled it can't have spend time */
+	s_fence = to_drm_sched_fence(fence);
+	if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->scheduled.flags))
+		return ns_to_ktime(0);
+
+	if (!test_bit(DMA_FENCE_FLAG_TIMESTAMP_BIT, &s_fence->finished.flags))
+		return ktime_sub(ktime_get(), s_fence->scheduled.timestamp);
+
+	return ktime_sub(s_fence->finished.timestamp,
+			 s_fence->scheduled.timestamp);
+}
+
+static ktime_t amdgpu_ctx_entity_time(struct amdgpu_ctx *ctx,
+				      struct amdgpu_ctx_entity *centity)
+{
+	ktime_t res = ns_to_ktime(0);
+	uint32_t i;
+
+	spin_lock(&ctx->ring_lock);
+	for (i = 0; i < amdgpu_sched_jobs; i++) {
+		res = ktime_add(res, amdgpu_ctx_fence_time(centity->fences[i]));
+	}
+	spin_unlock(&ctx->ring_lock);
+	return res;
+}
 
 static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 				  const u32 ring)
 {
-	struct amdgpu_device *adev = ctx->adev;
-	struct amdgpu_ctx_entity *entity;
 	struct drm_gpu_scheduler **scheds = NULL, *sched = NULL;
-	unsigned num_scheds = 0;
-	int32_t ctx_prio;
-	unsigned int hw_prio;
+	struct amdgpu_device *adev = ctx->mgr->adev;
+	struct amdgpu_ctx_entity *entity;
 	enum drm_sched_priority drm_prio;
+	unsigned int hw_prio, num_scheds;
+	int32_t ctx_prio;
 	int r;
 
 	entity = kzalloc(struct_size(entity, fences, amdgpu_sched_jobs),
@@ -182,6 +214,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 
 	ctx_prio = (ctx->override_priority == AMDGPU_CTX_PRIORITY_UNSET) ?
 			ctx->init_priority : ctx->override_priority;
+	entity->hw_ip = hw_ip;
 	entity->sequence = 1;
 	hw_prio = amdgpu_ctx_get_hw_prio(ctx, hw_ip);
 	drm_prio = amdgpu_ctx_to_drm_sched_prio(ctx_prio);
@@ -220,11 +253,29 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 	return r;
 }
 
-static int amdgpu_ctx_init(struct amdgpu_device *adev,
+static ktime_t amdgpu_ctx_fini_entity(struct amdgpu_ctx_entity *entity)
+{
+	ktime_t res = ns_to_ktime(0);
+	int i;
+
+	if (!entity)
+		return res;
+
+	for (i = 0; i < amdgpu_sched_jobs; ++i) {
+		res = ktime_add(res, amdgpu_ctx_fence_time(entity->fences[i]));
+		dma_fence_put(entity->fences[i]);
+	}
+
+	kfree(entity);
+	return res;
+}
+
+static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr,
 			   int32_t priority,
 			   struct drm_file *filp,
 			   struct amdgpu_ctx *ctx)
 {
+	struct amdgpu_device *adev = mgr->adev;
 	int r;
 
 	r = amdgpu_ctx_priority_permit(filp, priority);
@@ -233,9 +284,8 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
 
 	memset(ctx, 0, sizeof(*ctx));
 
-	ctx->adev = adev;
-
 	kref_init(&ctx->refcount);
+	ctx->mgr = mgr;
 	spin_lock_init(&ctx->ring_lock);
 	mutex_init(&ctx->lock);
 
@@ -249,24 +299,10 @@ static int amdgpu_ctx_init(struct amdgpu_device *adev,
 	return 0;
 }
 
-static void amdgpu_ctx_fini_entity(struct amdgpu_ctx_entity *entity)
-{
-
-	int i;
-
-	if (!entity)
-		return;
-
-	for (i = 0; i < amdgpu_sched_jobs; ++i)
-		dma_fence_put(entity->fences[i]);
-
-	kfree(entity);
-}
-
 static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
 					u32 *stable_pstate)
 {
-	struct amdgpu_device *adev = ctx->adev;
+	struct amdgpu_device *adev = ctx->mgr->adev;
 	enum amd_dpm_forced_level current_level;
 
 	current_level = amdgpu_dpm_get_performance_level(adev);
@@ -294,7 +330,7 @@ static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
 static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
 					u32 stable_pstate)
 {
-	struct amdgpu_device *adev = ctx->adev;
+	struct amdgpu_device *adev = ctx->mgr->adev;
 	enum amd_dpm_forced_level level;
 	int r;
 
@@ -340,7 +376,8 @@ static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
 static void amdgpu_ctx_fini(struct kref *ref)
 {
 	struct amdgpu_ctx *ctx = container_of(ref, struct amdgpu_ctx, refcount);
-	struct amdgpu_device *adev = ctx->adev;
+	struct amdgpu_ctx_mgr *mgr = ctx->mgr;
+	struct amdgpu_device *adev = mgr->adev;
 	unsigned i, j, idx;
 
 	if (!adev)
@@ -348,8 +385,10 @@ static void amdgpu_ctx_fini(struct kref *ref)
 
 	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
 		for (j = 0; j < AMDGPU_MAX_ENTITY_NUM; ++j) {
-			amdgpu_ctx_fini_entity(ctx->entities[i][j]);
-			ctx->entities[i][j] = NULL;
+			ktime_t spend;
+
+			spend = amdgpu_ctx_fini_entity(ctx->entities[i][j]);
+			atomic64_add(ktime_to_ns(spend), &mgr->time_spend[i]);
 		}
 	}
 
@@ -416,7 +455,7 @@ static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
 	}
 
 	*id = (uint32_t)r;
-	r = amdgpu_ctx_init(adev, priority, filp, ctx);
+	r = amdgpu_ctx_init(mgr, priority, filp, ctx);
 	if (r) {
 		idr_remove(&mgr->ctx_handles, *id);
 		*id = 0;
@@ -666,19 +705,20 @@ int amdgpu_ctx_put(struct amdgpu_ctx *ctx)
 	return 0;
 }
 
-void amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
-			  struct drm_sched_entity *entity,
-			  struct dma_fence *fence, uint64_t *handle)
+uint64_t amdgpu_ctx_add_fence(struct amdgpu_ctx_mgr *mgr,
+			      struct amdgpu_ctx *ctx,
+			      struct drm_sched_entity *entity,
+			      struct dma_fence *fence)
 {
 	struct amdgpu_ctx_entity *centity = to_amdgpu_ctx_entity(entity);
 	uint64_t seq = centity->sequence;
 	struct dma_fence *other = NULL;
 	unsigned idx = 0;
+	ktime_t spend;
 
 	idx = seq & (amdgpu_sched_jobs - 1);
 	other = centity->fences[idx];
-	if (other)
-		BUG_ON(!dma_fence_is_signaled(other));
+	BUG_ON(other && !dma_fence_is_signaled(other));
 
 	dma_fence_get(fence);
 
@@ -687,9 +727,40 @@ void amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
 	centity->sequence++;
 	spin_unlock(&ctx->ring_lock);
 
+	spend = amdgpu_ctx_fence_time(other);
+	atomic64_add(ktime_to_ns(spend), &mgr->time_spend[centity->hw_ip]);
+
 	dma_fence_put(other);
-	if (handle)
-		*handle = seq;
+	return seq;
+}
+
+ktime_t amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hw_ip)
+{
+	struct amdgpu_ctx *ctx;
+	unsigned int i;
+	uint32_t id;
+	ktime_t res;
+
+	/*
+	 * This is a little bit racy because it can be that ctx or fences are
+	 * destroyed just in the moment we try to account them. But that is ok
+	 * since exactly that case is explicitely allowed by the interface.
+	 */
+	mutex_lock(&mgr->lock);
+	res = ns_to_ktime(atomic64_read(&mgr->time_spend[hw_ip]));
+	idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
+		for (i = 0; i < amdgpu_ctx_num_entities[hw_ip]; ++i) {
+			struct amdgpu_ctx_entity *centity;
+
+			centity = ctx->entities[hw_ip][i];
+			if (!centity)
+				continue;
+			res = ktime_add(res, amdgpu_ctx_entity_time(ctx,
+								    centity));
+		}
+	}
+	mutex_unlock(&mgr->lock);
+	return res;
 }
 
 struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
@@ -726,7 +797,7 @@ static void amdgpu_ctx_set_entity_priority(struct amdgpu_ctx *ctx,
 					   int hw_ip,
 					   int32_t priority)
 {
-	struct amdgpu_device *adev = ctx->adev;
+	struct amdgpu_device *adev = ctx->mgr->adev;
 	unsigned int hw_prio;
 	struct drm_gpu_scheduler **scheds = NULL;
 	unsigned num_scheds;
@@ -791,10 +862,17 @@ int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx,
 	return r;
 }
 
-void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr)
+void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr,
+			 struct amdgpu_device *adev)
 {
+	unsigned int i;
+
+	mgr->adev = adev;
 	mutex_init(&mgr->lock);
 	idr_init(&mgr->ctx_handles);
+
+	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
+		atomic64_set(&mgr->time_spend[i], 0);
 }
 
 long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
@@ -869,81 +947,3 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
 	idr_destroy(&mgr->ctx_handles);
 	mutex_destroy(&mgr->lock);
 }
-
-static void amdgpu_ctx_fence_time(struct amdgpu_ctx *ctx,
-		struct amdgpu_ctx_entity *centity, ktime_t *total, ktime_t *max)
-{
-	ktime_t now, t1;
-	uint32_t i;
-
-	*total = *max = 0;
-
-	now = ktime_get();
-	for (i = 0; i < amdgpu_sched_jobs; i++) {
-		struct dma_fence *fence;
-		struct drm_sched_fence *s_fence;
-
-		spin_lock(&ctx->ring_lock);
-		fence = dma_fence_get(centity->fences[i]);
-		spin_unlock(&ctx->ring_lock);
-		if (!fence)
-			continue;
-		s_fence = to_drm_sched_fence(fence);
-		if (!dma_fence_is_signaled(&s_fence->scheduled)) {
-			dma_fence_put(fence);
-			continue;
-		}
-		t1 = s_fence->scheduled.timestamp;
-		if (!ktime_before(t1, now)) {
-			dma_fence_put(fence);
-			continue;
-		}
-		if (dma_fence_is_signaled(&s_fence->finished) &&
-			s_fence->finished.timestamp < now)
-			*total += ktime_sub(s_fence->finished.timestamp, t1);
-		else
-			*total += ktime_sub(now, t1);
-		t1 = ktime_sub(now, t1);
-		dma_fence_put(fence);
-		*max = max(t1, *max);
-	}
-}
-
-ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
-		uint32_t idx, uint64_t *elapsed)
-{
-	struct idr *idp;
-	struct amdgpu_ctx *ctx;
-	uint32_t id;
-	struct amdgpu_ctx_entity *centity;
-	ktime_t total = 0, max = 0;
-
-	if (idx >= AMDGPU_MAX_ENTITY_NUM)
-		return 0;
-	idp = &mgr->ctx_handles;
-	mutex_lock(&mgr->lock);
-	idr_for_each_entry(idp, ctx, id) {
-		ktime_t ttotal, tmax;
-
-		if (!ctx->entities[hwip][idx])
-			continue;
-
-		centity = ctx->entities[hwip][idx];
-		amdgpu_ctx_fence_time(ctx, centity, &ttotal, &tmax);
-
-		/* Harmonic mean approximation diverges for very small
-		 * values. If ratio < 0.01% ignore
-		 */
-		if (AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(tmax, ttotal))
-			continue;
-
-		total = ktime_add(total, ttotal);
-		max = ktime_after(tmax, max) ? tmax : max;
-	}
-
-	mutex_unlock(&mgr->lock);
-	if (elapsed)
-		*elapsed = max;
-
-	return total;
-}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index 142f2f87d44c..a28ebf3be764 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -23,16 +23,20 @@
 #ifndef __AMDGPU_CTX_H__
 #define __AMDGPU_CTX_H__
 
+#include <linux/ktime.h>
+#include <linux/types.h>
+
 #include "amdgpu_ring.h"
 
 struct drm_device;
 struct drm_file;
 struct amdgpu_fpriv;
+struct amdgpu_ctx_mgr;
 
 #define AMDGPU_MAX_ENTITY_NUM 4
-#define AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(max, total) ((max) > 16384ULL*(total))
 
 struct amdgpu_ctx_entity {
+	uint32_t		hw_ip;
 	uint64_t		sequence;
 	struct drm_sched_entity	entity;
 	struct dma_fence	*fences[];
@@ -40,7 +44,7 @@ struct amdgpu_ctx_entity {
 
 struct amdgpu_ctx {
 	struct kref			refcount;
-	struct amdgpu_device		*adev;
+	struct amdgpu_ctx_mgr		*mgr;
 	unsigned			reset_counter;
 	unsigned			reset_counter_query;
 	uint32_t			vram_lost_counter;
@@ -61,6 +65,7 @@ struct amdgpu_ctx_mgr {
 	struct mutex		lock;
 	/* protected by lock */
 	struct idr		ctx_handles;
+	atomic64_t		time_spend[AMDGPU_HW_IP_NUM];
 };
 
 extern const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM];
@@ -70,9 +75,10 @@ int amdgpu_ctx_put(struct amdgpu_ctx *ctx);
 
 int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
 			  u32 ring, struct drm_sched_entity **entity);
-void amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
-			  struct drm_sched_entity *entity,
-			  struct dma_fence *fence, uint64_t *seq);
+uint64_t amdgpu_ctx_add_fence(struct amdgpu_ctx_mgr *mgr,
+			      struct amdgpu_ctx *ctx,
+			      struct drm_sched_entity *entity,
+			      struct dma_fence *fence);
 struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
 				       struct drm_sched_entity *entity,
 				       uint64_t seq);
@@ -85,10 +91,11 @@ int amdgpu_ctx_ioctl(struct drm_device *dev, void *data,
 int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx,
 			       struct drm_sched_entity *entity);
 
-void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr);
+void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr,
+			 struct amdgpu_device *adev);
 void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr);
 long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout);
 void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);
-ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
-		uint32_t idx, uint64_t *elapsed);
+ktime_t amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index 5a6857c44bb6..52c2b90925a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -32,6 +32,7 @@
 
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_debugfs.h>
+#include <drm/drm_drv.h>
 
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
@@ -55,10 +56,10 @@ static const char *amdgpu_ip_name[AMDGPU_HW_IP_NUM] = {
 void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
 {
 	struct amdgpu_fpriv *fpriv;
-	uint32_t bus, dev, fn, i, domain;
 	uint64_t vram_mem = 0, gtt_mem = 0, cpu_mem = 0;
 	struct drm_file *file = f->private_data;
 	struct amdgpu_device *adev = drm_to_adev(file->minor->dev);
+	uint32_t bus, dev, fn, domain, hw_ip;
 	struct amdgpu_bo *root;
 	int ret;
 
@@ -83,29 +84,25 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
 	amdgpu_bo_unreserve(root);
 	amdgpu_bo_unref(&root);
 
-	seq_printf(m, "pdev:\t%04x:%02x:%02x.%d\npasid:\t%u\n", domain, bus,
-			dev, fn, fpriv->vm.pasid);
-	seq_printf(m, "vram mem:\t%llu kB\n", vram_mem/1024UL);
-	seq_printf(m, "gtt mem:\t%llu kB\n", gtt_mem/1024UL);
-	seq_printf(m, "cpu mem:\t%llu kB\n", cpu_mem/1024UL);
-	for (i = 0; i < AMDGPU_HW_IP_NUM; i++) {
-		uint32_t count = amdgpu_ctx_num_entities[i];
-		int idx = 0;
-		uint64_t total = 0, min = 0;
-		uint32_t perc, frac;
+	/*
+	 * ******************************************************************
+	 * For text output format description please see drm-usage-stats.rst!
+	 * ******************************************************************
+	 */
 
-		for (idx = 0; idx < count; idx++) {
-			total = amdgpu_ctx_mgr_fence_usage(&fpriv->ctx_mgr,
-				i, idx, &min);
-			if ((total == 0) || (min == 0))
-				continue;
+	seq_printf(m, "drm-driver:\t%s\n", file->minor->dev->driver->name);
+	seq_printf(m, "drm-pdev:\t%04x:%02x:%02x.%d\npasid:\t%u\n", domain, bus,
+			dev, fn, fpriv->vm.pasid);
+	seq_printf(m, "drm-memory-vram:\t%llu KiB\n", vram_mem/1024UL);
+	seq_printf(m, "drm-memory-gtt:\t%llu KiB\n", gtt_mem/1024UL);
+	seq_printf(m, "drm-memory-cpu:\t%llu KiB\n", cpu_mem/1024UL);
+	for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
+		ktime_t usage = amdgpu_ctx_mgr_usage(&fpriv->ctx_mgr, hw_ip);
 
-			perc = div64_u64(10000 * total, min);
-			frac = perc % 100;
+		if (!usage)
+			continue;
 
-			seq_printf(m, "%s%d:\t%d.%d%%\n",
-					amdgpu_ip_name[i],
-					idx, perc/100, frac);
-		}
+		seq_printf(m, "drm-engine-%s:\t%Ld ns\n",
+			   amdgpu_ip_name[hw_ip], ktime_to_ns(usage));
 	}
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 6b626c293e72..0814e6508a00 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -1144,7 +1144,7 @@ int amdgpu_driver_open_kms(struct drm_device *dev, struct drm_file *file_priv)
 	mutex_init(&fpriv->bo_list_lock);
 	idr_init(&fpriv->bo_list_handles);
 
-	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr);
+	amdgpu_ctx_mgr_init(&fpriv->ctx_mgr, adev);
 
 	file_priv->driver_priv = fpriv;
 	goto out_suspend;
-- 
2.25.1


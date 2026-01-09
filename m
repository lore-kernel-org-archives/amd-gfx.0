Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4128CD1A627
	for <amd-gfx@archiver.kernel.org>; Fri,  9 Jan 2026 13:33:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B3D5410E8D0;
	Fri,  9 Jan 2026 13:33:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="st7joSta";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD2CF10E8C5
 for <amd-gfx@lists.freedesktop.org>; Fri,  9 Jan 2026 13:33:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9cQ7p6s/WlDUcM7+oZ/UK9TRzdktI81OHiAHpQfcFLw=; b=st7joStaOZWGWgiFEs75OL0WVk
 sT1n+w2xjRGu3NgVOoR+mEj1aDfDxKIYS1pMrqoup4QI65QQ47pHcrvIbvavzW2FcI5QnQP8iuQcu
 aCI2MeOuRntlW32GUJbkx6Gxz2xFZFXCTSofuRV9dbt8KvBgbbndGzxTwMQbm1cu/TwEkTOM82u9x
 Z4uRbdmm34jnBCxoDERrSZ4bj1WBSX3uAsjz+CO1nio58cSKqYrOFc7Q3SsTRURwxoJHiS/NPG7k7
 c39oI7UfRTsUp+A5aCWyNH5gdSYFl5OgC9V/VyQ7At8KN/T1F1zemplprZY6E8EGcePK+mNzbKYqE
 bQpch2FQ==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1veCcJ-003Qbm-1L; Fri, 09 Jan 2026 14:33:27 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v3 08/12] drm/amdgpu: Consolidate ctx put
Date: Fri,  9 Jan 2026 13:33:10 +0000
Message-ID: <20260109133314.88548-9-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109133314.88548-1-tvrtko.ursulin@igalia.com>
References: <20260109133314.88548-1-tvrtko.ursulin@igalia.com>
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Currently there are two flavours of the context reference count
destructor:

 - amdgpu_ctx_do_release(), used from kref_put from places where the code
   thinks context may have been used, or is in active use, and;
 - amdgpu_ctx_fini(), used when code is sure context entities have already
   been idled.

Since amdgpu_ctx_do_release() calls amdgpu_ctx_fini() after having idled
and destroyed the scheduler entities, we can consolidate the two into a
single function.

Functional difference is that now drm_sched_entity_destroy() is called on
context manager shutdown (file close), where previously it was
drm_sched_entity_fini(). But the former is a superset of the latter, and
during file close the flush method is also called, which calls
drm_sched_entity_flush(), which is also called by
drm_sched_entity_destroy(). And as it is safe to attempt to flush a never
used entity, or flush it twice, there is actually no functional change.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Suggested-by: Christian König <christian.koenig@amd.com>
---
v2:
 * Use separate variable for drm_dev_enter for readability.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 99 +++++++------------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h |  9 ++-
 2 files changed, 36 insertions(+), 72 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index fb3f1f22a3f5..0e02fc624cd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -274,26 +274,6 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 	return r;
 }
 
-static ktime_t amdgpu_ctx_fini_entity(struct amdgpu_device *adev,
-				  struct amdgpu_ctx_entity *entity)
-{
-	ktime_t res = ns_to_ktime(0);
-	int i;
-
-	if (!entity)
-		return res;
-
-	for (i = 0; i < amdgpu_sched_jobs; ++i) {
-		res = ktime_add(res, amdgpu_ctx_fence_time(entity->fences[i]));
-		dma_fence_put(entity->fences[i]);
-	}
-
-	amdgpu_xcp_release_sched(adev, entity);
-
-	kfree(entity);
-	return res;
-}
-
 static int amdgpu_ctx_get_stable_pstate(struct amdgpu_ctx *ctx,
 					u32 *stable_pstate)
 {
@@ -408,22 +388,41 @@ static int amdgpu_ctx_set_stable_pstate(struct amdgpu_ctx *ctx,
 	return r;
 }
 
-static void amdgpu_ctx_fini(struct kref *ref)
+void amdgpu_ctx_fini(struct kref *ref)
 {
 	struct amdgpu_ctx *ctx = container_of(ref, struct amdgpu_ctx, refcount);
 	struct amdgpu_ctx_mgr *mgr = ctx->mgr;
 	struct amdgpu_device *adev = mgr->adev;
-	unsigned i, j, idx;
+	int i, j, k, idx;
 
 	if (!adev)
 		return;
 
 	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
 		for (j = 0; j < AMDGPU_MAX_ENTITY_NUM; ++j) {
-			ktime_t spend;
+			struct amdgpu_ctx_entity *entity = ctx->entities[i][j];
+			ktime_t t = ns_to_ktime(0);
 
-			spend = amdgpu_ctx_fini_entity(adev, ctx->entities[i][j]);
-			atomic64_add(ktime_to_ns(spend), &mgr->time_spend[i]);
+			if (!entity)
+				continue;
+
+			drm_sched_entity_destroy(&entity->entity);
+
+			for (k = 0; k < amdgpu_sched_jobs; k++) {
+				struct dma_fence *fence = entity->fences[k];
+
+				if (!fence)
+					continue;
+
+				t = ktime_add(t, amdgpu_ctx_fence_time(fence));
+				dma_fence_put(fence);
+			}
+
+			amdgpu_xcp_release_sched(adev, entity);
+
+			kfree(entity);
+
+			atomic64_add(ktime_to_ns(t), &mgr->time_spend[i]);
 		}
 	}
 
@@ -507,24 +506,6 @@ static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
 	return r;
 }
 
-static void amdgpu_ctx_do_release(struct kref *ref)
-{
-	struct amdgpu_ctx *ctx;
-	u32 i, j;
-
-	ctx = container_of(ref, struct amdgpu_ctx, refcount);
-	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
-		for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
-			if (!ctx->entities[i][j])
-				continue;
-
-			drm_sched_entity_destroy(&ctx->entities[i][j]->entity);
-		}
-	}
-
-	amdgpu_ctx_fini(ref);
-}
-
 static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
 {
 	struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
@@ -532,8 +513,7 @@ static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
 
 	mutex_lock(&mgr->lock);
 	ctx = idr_remove(&mgr->ctx_handles, id);
-	if (ctx)
-		kref_put(&ctx->refcount, amdgpu_ctx_do_release);
+	amdgpu_ctx_put(ctx);
 	mutex_unlock(&mgr->lock);
 	return ctx ? 0 : -EINVAL;
 }
@@ -749,15 +729,6 @@ struct amdgpu_ctx *amdgpu_ctx_get(struct amdgpu_fpriv *fpriv, uint32_t id)
 	return ctx;
 }
 
-int amdgpu_ctx_put(struct amdgpu_ctx *ctx)
-{
-	if (ctx == NULL)
-		return -EINVAL;
-
-	kref_put(&ctx->refcount, amdgpu_ctx_do_release);
-	return 0;
-}
-
 uint64_t amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
 			      struct drm_sched_entity *entity,
 			      struct dma_fence *fence)
@@ -926,29 +897,15 @@ long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
 static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
 {
 	struct amdgpu_ctx *ctx;
-	struct idr *idp;
-	uint32_t id, i, j;
+	uint32_t id;
 
-	idp = &mgr->ctx_handles;
-
-	idr_for_each_entry(idp, ctx, id) {
+	idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
 		if (kref_read(&ctx->refcount) != 1) {
 			DRM_ERROR("ctx %p is still alive\n", ctx);
 			continue;
 		}
 
-		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
-			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
-				struct drm_sched_entity *entity;
-
-				if (!ctx->entities[i][j])
-					continue;
-
-				entity = &ctx->entities[i][j]->entity;
-				drm_sched_entity_fini(entity);
-			}
-		}
-		kref_put(&ctx->refcount, amdgpu_ctx_fini);
+		amdgpu_ctx_put(ctx);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index cf8d700a22fe..b1fa7fe74569 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -70,7 +70,14 @@ struct amdgpu_ctx_mgr {
 extern const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM];
 
 struct amdgpu_ctx *amdgpu_ctx_get(struct amdgpu_fpriv *fpriv, uint32_t id);
-int amdgpu_ctx_put(struct amdgpu_ctx *ctx);
+
+void amdgpu_ctx_fini(struct kref *kref);
+
+static inline void amdgpu_ctx_put(struct amdgpu_ctx *ctx)
+{
+	if (ctx)
+		kref_put(&ctx->refcount, amdgpu_ctx_fini);
+}
 
 int amdgpu_ctx_get_entity(struct amdgpu_ctx *ctx, u32 hw_ip, u32 instance,
 			  u32 ring, struct drm_sched_entity **entity);
-- 
2.52.0


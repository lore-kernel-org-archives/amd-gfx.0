Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA550C9EC63
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Jan 2026 10:23:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79A0110E346;
	Mon, 12 Jan 2026 10:23:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="GUhFpDrb";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A196610E347
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Jan 2026 10:22:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ilkE0yeEd+A6ifEpX1qN/7diSijIKszBCt0aCZ+HDEw=; b=GUhFpDrbr/61zTaaHVY4Th82x1
 l5Y4CMiqgJKZUENPeHFJkuKUHQJZ6u6xtpreZ7EWUo5oeIT1h//MCE2MEKwD/OITxjjfWbPmzzpkp
 yrY1WMuQhDxx7Lp4ndg/iWGkc5SdrCkFQTbk3Q77KrnTxPEYUfaXKcGcqWWHaF9VtGOgsrDq5OA6a
 sHDTh/Iq1V7YgvAEB6WI0FQHBWPsG1a+VcVDkEq6ggfvJ57XVWj9HHY2hNJDl98W96R6BpU2It4M3
 KtSa310sSUhN5YWt1/ecjahOBoM8hi+8qlaAJUaEpfR3IaxUdGPIy5y90gOaI6qYEDQxZHEk191H8
 PMgb+HWA==;
Received: from [90.240.106.137] (helo=localhost)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1vfF4Z-004Ldd-UK; Mon, 12 Jan 2026 11:22:56 +0100
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
To: amd-gfx@lists.freedesktop.org
Cc: kernel-dev@igalia.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Subject: [PATCH v4 12/12] drm/amdgpu: Convert context manager to xarray
Date: Mon, 12 Jan 2026 10:22:44 +0000
Message-ID: <20260112102244.63308-13-tvrtko.ursulin@igalia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260112102244.63308-1-tvrtko.ursulin@igalia.com>
References: <20260112102244.63308-1-tvrtko.ursulin@igalia.com>
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

IDR is deprecated so let's convert the context manager to xarray.

In doing so we remove the context manager mutex and switch call sites
which required the guarantee context cannot go away while they walk the
list of context, or otherwise operate on them, to use reference counting.

This allows us to use the built in xarray spinlock for all operations and
just temporarily drop it when we need to call sleeping functions.

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
v2:
 * No need for kref_get_unless_zero when locked.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c   | 119 ++++++++--------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h   |   5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c |   8 +-
 3 files changed, 48 insertions(+), 84 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 93b1fb4d1b8a..9b240ce73d15 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -491,34 +491,26 @@ static int amdgpu_ctx_alloc(struct amdgpu_device *adev,
 	if (!ctx)
 		return -ENOMEM;
 
-	mutex_lock(&mgr->lock);
-	*id = 1;
-	r = idr_alloc_u32(&mgr->ctx_handles, ctx, id, UINT_MAX, GFP_KERNEL);
-	if (r) {
-		mutex_unlock(&mgr->lock);
-		kfree(ctx);
-		return r;
-	}
-
 	r = amdgpu_ctx_init(mgr, priority, filp, ctx);
 	if (r) {
-		idr_remove(&mgr->ctx_handles, *id);
-		*id = 0;
 		kfree(ctx);
+		return r;
 	}
-	mutex_unlock(&mgr->lock);
+
+	r = xa_alloc(&mgr->ctx_handles, id, ctx, xa_limit_32b, GFP_KERNEL);
+	if (r)
+		amdgpu_ctx_put(ctx);
+
 	return r;
 }
 
 static int amdgpu_ctx_free(struct amdgpu_fpriv *fpriv, uint32_t id)
 {
-	struct amdgpu_ctx_mgr *mgr = &fpriv->ctx_mgr;
 	struct amdgpu_ctx *ctx;
 
-	mutex_lock(&mgr->lock);
-	ctx = idr_remove(&mgr->ctx_handles, id);
+	ctx = xa_erase(&fpriv->ctx_mgr.ctx_handles, id);
 	amdgpu_ctx_put(ctx);
-	mutex_unlock(&mgr->lock);
+
 	return ctx ? 0 : -EINVAL;
 }
 
@@ -527,20 +519,12 @@ static int amdgpu_ctx_query(struct amdgpu_device *adev,
 			    union drm_amdgpu_ctx_out *out)
 {
 	struct amdgpu_ctx *ctx;
-	struct amdgpu_ctx_mgr *mgr;
 	unsigned reset_counter;
 
-	if (!fpriv)
+	ctx = amdgpu_ctx_get(fpriv, id);
+	if (!ctx)
 		return -EINVAL;
 
-	mgr = &fpriv->ctx_mgr;
-	mutex_lock(&mgr->lock);
-	ctx = idr_find(&mgr->ctx_handles, id);
-	if (!ctx) {
-		mutex_unlock(&mgr->lock);
-		return -EINVAL;
-	}
-
 	/* TODO: these two are always zero */
 	out->state.flags = 0x0;
 	out->state.hangs = 0x0;
@@ -554,7 +538,8 @@ static int amdgpu_ctx_query(struct amdgpu_device *adev,
 		out->state.reset_status = AMDGPU_CTX_UNKNOWN_RESET;
 	ctx->reset_counter_query = reset_counter;
 
-	mutex_unlock(&mgr->lock);
+	amdgpu_ctx_put(ctx);
+
 	return 0;
 }
 
@@ -566,19 +551,11 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
 {
 	struct amdgpu_ras *con = amdgpu_ras_get_context(adev);
 	struct amdgpu_ctx *ctx;
-	struct amdgpu_ctx_mgr *mgr;
 
-	if (!fpriv)
+	ctx = amdgpu_ctx_get(fpriv, id);
+	if (!ctx)
 		return -EINVAL;
 
-	mgr = &fpriv->ctx_mgr;
-	mutex_lock(&mgr->lock);
-	ctx = idr_find(&mgr->ctx_handles, id);
-	if (!ctx) {
-		mutex_unlock(&mgr->lock);
-		return -EINVAL;
-	}
-
 	out->state.flags = 0x0;
 	out->state.hangs = 0x0;
 
@@ -618,7 +595,8 @@ static int amdgpu_ctx_query2(struct amdgpu_device *adev,
 				      msecs_to_jiffies(AMDGPU_RAS_COUNTE_DELAY_MS));
 	}
 
-	mutex_unlock(&mgr->lock);
+	amdgpu_ctx_put(ctx);
+
 	return 0;
 }
 
@@ -627,26 +605,18 @@ static int amdgpu_ctx_stable_pstate(struct amdgpu_device *adev,
 				    bool set, u32 *stable_pstate)
 {
 	struct amdgpu_ctx *ctx;
-	struct amdgpu_ctx_mgr *mgr;
 	int r;
 
-	if (!fpriv)
+	ctx = amdgpu_ctx_get(fpriv, id);
+	if (!ctx)
 		return -EINVAL;
 
-	mgr = &fpriv->ctx_mgr;
-	mutex_lock(&mgr->lock);
-	ctx = idr_find(&mgr->ctx_handles, id);
-	if (!ctx) {
-		mutex_unlock(&mgr->lock);
-		return -EINVAL;
-	}
-
 	if (set)
 		r = amdgpu_ctx_set_stable_pstate(ctx, *stable_pstate);
 	else
 		r = amdgpu_ctx_get_stable_pstate(ctx, stable_pstate);
 
-	mutex_unlock(&mgr->lock);
+	amdgpu_ctx_put(ctx);
 	return r;
 }
 
@@ -725,11 +695,11 @@ struct amdgpu_ctx *amdgpu_ctx_get(struct amdgpu_fpriv *fpriv, uint32_t id)
 
 	mgr = &fpriv->ctx_mgr;
 
-	mutex_lock(&mgr->lock);
-	ctx = idr_find(&mgr->ctx_handles, id);
+	xa_lock(&mgr->ctx_handles);
+	ctx = xa_load(&mgr->ctx_handles, id);
 	if (ctx)
 		kref_get(&ctx->refcount);
-	mutex_unlock(&mgr->lock);
+	xa_unlock(&mgr->ctx_handles);
 	return ctx;
 }
 
@@ -865,8 +835,7 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr,
 	unsigned int i;
 
 	mgr->adev = adev;
-	mutex_init(&mgr->lock);
-	idr_init_base(&mgr->ctx_handles, 1);
+	xa_init_flags(&mgr->ctx_handles, XA_FLAGS_ALLOC1);
 
 	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
 		atomic64_set(&mgr->time_spend[i], 0);
@@ -875,13 +844,13 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr,
 long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
 {
 	struct amdgpu_ctx *ctx;
-	struct idr *idp;
-	uint32_t id, i, j;
+	unsigned long id;
+	int i, j;
 
-	idp = &mgr->ctx_handles;
-
-	mutex_lock(&mgr->lock);
-	idr_for_each_entry(idp, ctx, id) {
+	xa_lock(&mgr->ctx_handles);
+	xa_for_each(&mgr->ctx_handles, id, ctx) {
+		kref_get(&ctx->refcount);
+		xa_unlock(&mgr->ctx_handles);
 		for (i = 0; i < AMDGPU_HW_IP_NUM; ++i) {
 			for (j = 0; j < amdgpu_ctx_num_entities[i]; ++j) {
 				struct drm_sched_entity *entity;
@@ -893,25 +862,21 @@ long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
 				timeout = drm_sched_entity_flush(entity, timeout);
 			}
 		}
+		amdgpu_ctx_put(ctx);
+		xa_lock(&mgr->ctx_handles);
 	}
-	mutex_unlock(&mgr->lock);
+	xa_unlock(&mgr->ctx_handles);
 	return timeout;
 }
 
-static void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr)
-{
-	struct amdgpu_ctx *ctx;
-	uint32_t id;
-
-	idr_for_each_entry(&mgr->ctx_handles, ctx, id)
-		amdgpu_ctx_put(ctx);
-}
-
 void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
 {
-	amdgpu_ctx_mgr_entity_fini(mgr);
-	idr_destroy(&mgr->ctx_handles);
-	mutex_destroy(&mgr->lock);
+	struct amdgpu_ctx *ctx;
+	unsigned long id;
+
+	xa_for_each(&mgr->ctx_handles, id, ctx)
+		amdgpu_ctx_put(ctx);
+	xa_destroy(&mgr->ctx_handles);
 }
 
 void amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr,
@@ -919,21 +884,21 @@ void amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr,
 {
 	struct amdgpu_ctx *ctx;
 	unsigned int hw_ip, i;
-	uint32_t id;
+	unsigned long id;
 
 	/*
 	 * This is a little bit racy because it can be that a ctx or a fence are
 	 * destroyed just in the moment we try to account them. But that is ok
 	 * since exactly that case is explicitely allowed by the interface.
 	 */
-	mutex_lock(&mgr->lock);
 	for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
 		uint64_t ns = atomic64_read(&mgr->time_spend[hw_ip]);
 
 		usage[hw_ip] = ns_to_ktime(ns);
 	}
 
-	idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
+	xa_lock(&mgr->ctx_handles);
+	xa_for_each(&mgr->ctx_handles, id, ctx) {
 		for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
 			for (i = 0; i < amdgpu_ctx_num_entities[hw_ip]; ++i) {
 				struct amdgpu_ctx_entity *centity;
@@ -947,5 +912,5 @@ void amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr,
 			}
 		}
 	}
-	mutex_unlock(&mgr->lock);
+	xa_unlock(&mgr->ctx_handles);
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index b1fa7fe74569..8427a7d18cf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -25,6 +25,7 @@
 
 #include <linux/ktime.h>
 #include <linux/types.h>
+#include <linux/xarray.h>
 
 #include "amdgpu_ring.h"
 
@@ -61,9 +62,7 @@ struct amdgpu_ctx {
 
 struct amdgpu_ctx_mgr {
 	struct amdgpu_device	*adev;
-	struct mutex		lock;
-	/* protected by lock */
-	struct idr		ctx_handles;
+	struct xarray		ctx_handles;
 	atomic64_t		time_spend[AMDGPU_HW_IP_NUM];
 };
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
index 341beec59537..471d27b2db01 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sched.c
@@ -39,7 +39,7 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
 	struct amdgpu_fpriv *fpriv;
 	struct amdgpu_ctx_mgr *mgr;
 	struct amdgpu_ctx *ctx;
-	uint32_t id;
+	unsigned long id;
 	int r;
 
 	if (fd_empty(f))
@@ -50,10 +50,10 @@ static int amdgpu_sched_process_priority_override(struct amdgpu_device *adev,
 		return r;
 
 	mgr = &fpriv->ctx_mgr;
-	mutex_lock(&mgr->lock);
-	idr_for_each_entry(&mgr->ctx_handles, ctx, id)
+	xa_lock(&mgr->ctx_handles);
+	xa_for_each(&mgr->ctx_handles, id, ctx)
 		amdgpu_ctx_priority_override(ctx, priority);
-	mutex_unlock(&mgr->lock);
+	xa_unlock(&mgr->ctx_handles);
 
 	return 0;
 }
-- 
2.52.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF61C433FE
	for <amd-gfx@archiver.kernel.org>; Tue, 17 May 2022 10:36:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E51D1131D8;
	Tue, 17 May 2022 10:36:51 +0000 (UTC)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A09371131D8
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 10:36:50 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id fd25so9209223edb.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 17 May 2022 03:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=smRPQEAUrmVgZ4pTs4oXScRuKu2acfM2kbBdlMlkYaY=;
 b=PRMkk/H/pbOQx5lYg1D4OBYdQvhG8w/WnQXW9a1IbDkYvkwWXOy76WPdrV3blciMTS
 3rM5HW0/HYJ03vxMArtkZTZi7mp92a6Zdld7tRlNkqs6VZnJqGpbntTut9v9M1K1zJKd
 rFukpjtFGl71vN1RJDSxinT9akACez8BvpwtVsklOtYAe9Otr2X/wYER21SaGbsMOskX
 QC3qlrCLIMvNxHqkkHqBy14q1DTDaj9UMKgfPypxx38NmEJO7ySG6yEOisNxwhBohlQx
 Av50rifRFQrE3wNcffYH1DODu8kB7F9agIvICD311foYe04DihmzW69H7INqI9hHXnis
 5bEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=smRPQEAUrmVgZ4pTs4oXScRuKu2acfM2kbBdlMlkYaY=;
 b=gjjjV7T85carFVtJBifYu5cnnzJpQ748k24zH1+h/XTX4tSLhV81+zM7MUGLKaI3NG
 Sc6IkP+lQeEPRVR6Z9LysW2s61h5ywfKXCeT0I7vIQc5FlolVyz51S/z04f5giCXMuU1
 Qxz8Iw4x31jG5y22zpOqBvrqIBkJ728qLMK5reTUY/NyYajvH2T/GGEIRJGV16aUtD/7
 pdyCk/QXvy+sE/kkariB2qriK5bno2ebFUFKhugUXNIxJXcwUrrHyie78CcJ846H9GjS
 3GKZMsqP0atEDFKwoWL/tvhDgRyJt1WxTfCZ7V8S++CKSePEfpeY8fhduAFoT5RVYvSq
 Sopw==
X-Gm-Message-State: AOAM530dGZlZKf63zp91HEuArHRqCI1rkFHChxDlgn96YpwgY9qK4QjU
 i+qwKks+nH/nXp8EFkHj9CevK7Pvbf0=
X-Google-Smtp-Source: ABdhPJwbwFLSyI7kxgT4vHkBxhZXdeXM8p5IKlCyIpCfDEv7V+As4+zfCE9sVoUgne9rooXuiaqrmQ==
X-Received: by 2002:aa7:da85:0:b0:42a:a5a4:794b with SMTP id
 q5-20020aa7da85000000b0042aa5a4794bmr14061557eds.104.1652783808974; 
 Tue, 17 May 2022 03:36:48 -0700 (PDT)
Received: from baker.fritz.box (p57b0bdaa.dip0.t-ipconnect.de.
 [87.176.189.170]) by smtp.gmail.com with ESMTPSA id
 ht7-20020a170907608700b006f3ef214e66sm870343ejc.204.2022.05.17.03.36.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 May 2022 03:36:48 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com,
	shashank.sharma@amd.com
Subject: [PATCH 1/2] drm/amdgpu: Convert to common fdinfo format v5
Date: Tue, 17 May 2022 12:36:45 +0200
Message-Id: <20220517103646.1553-1-christian.koenig@amd.com>
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
Cc: tvrtko.ursulin@linux.intel.com, amd-gfx@lists.freedesktop.org
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
v4: move general ctx changes into separate patch, rework the fdinfo to
    ctx_mgr interface so that all usages are calculated at once, drop
    some unecessary and dangerous refcount dance.
v5: add one more comment how we calculate the time spend

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 177 +++++++++++----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |  12 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  57 +++----
 3 files changed, 125 insertions(+), 121 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index a5fef5213fc5..a1d5275a2e78 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -162,17 +162,50 @@ static unsigned int amdgpu_ctx_get_hw_prio(struct amdgpu_ctx *ctx, u32 hw_ip)
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
+	/* When it is still running account how much already spend */
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
+	struct drm_gpu_scheduler **scheds = NULL, *sched = NULL;
 	struct amdgpu_device *adev = ctx->mgr->adev;
 	struct amdgpu_ctx_entity *entity;
-	struct drm_gpu_scheduler **scheds = NULL, *sched = NULL;
-	unsigned num_scheds = 0;
-	int32_t ctx_prio;
-	unsigned int hw_prio;
 	enum drm_sched_priority drm_prio;
+	unsigned int hw_prio, num_scheds;
+	int32_t ctx_prio;
 	int r;
 
 	entity = kzalloc(struct_size(entity, fences, amdgpu_sched_jobs),
@@ -182,6 +215,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 
 	ctx_prio = (ctx->override_priority == AMDGPU_CTX_PRIORITY_UNSET) ?
 			ctx->init_priority : ctx->override_priority;
+	entity->hw_ip = hw_ip;
 	entity->sequence = 1;
 	hw_prio = amdgpu_ctx_get_hw_prio(ctx, hw_ip);
 	drm_prio = amdgpu_ctx_to_drm_sched_prio(ctx_prio);
@@ -220,6 +254,23 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 	return r;
 }
 
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
 static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
 			   struct drm_file *filp, struct amdgpu_ctx *ctx)
 {
@@ -245,20 +296,6 @@ static int amdgpu_ctx_init(struct amdgpu_ctx_mgr *mgr, int32_t priority,
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
@@ -350,8 +387,10 @@ static void amdgpu_ctx_fini(struct kref *ref)
 
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
 
@@ -687,6 +726,9 @@ uint64_t amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
 	centity->sequence++;
 	spin_unlock(&ctx->ring_lock);
 
+	atomic64_add(ktime_to_ns(amdgpu_ctx_fence_time(other)),
+		     &ctx->mgr->time_spend[centity->hw_ip]);
+
 	dma_fence_put(other);
 	return seq;
 }
@@ -793,9 +835,14 @@ int amdgpu_ctx_wait_prev_fence(struct amdgpu_ctx *ctx,
 void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr,
 			 struct amdgpu_device *adev)
 {
+	unsigned int i;
+
 	mgr->adev = adev;
 	mutex_init(&mgr->lock);
 	idr_init(&mgr->ctx_handles);
+
+	for (i = 0; i < AMDGPU_HW_IP_NUM; ++i)
+		atomic64_set(&mgr->time_spend[i], 0);
 }
 
 long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout)
@@ -871,80 +918,38 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
 	mutex_destroy(&mgr->lock);
 }
 
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
+void amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr,
+			  ktime_t usage[AMDGPU_HW_IP_NUM])
 {
-	struct idr *idp;
 	struct amdgpu_ctx *ctx;
+	unsigned int hw_ip, i;
 	uint32_t id;
-	struct amdgpu_ctx_entity *centity;
-	ktime_t total = 0, max = 0;
 
-	if (idx >= AMDGPU_MAX_ENTITY_NUM)
-		return 0;
-	idp = &mgr->ctx_handles;
+	/*
+	 * This is a little bit racy because it can be that a ctx or a fence are
+	 * destroyed just in the moment we try to account them. But that is ok
+	 * since exactly that case is explicitely allowed by the interface.
+	 */
 	mutex_lock(&mgr->lock);
-	idr_for_each_entry(idp, ctx, id) {
-		ktime_t ttotal, tmax;
+	for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
+		uint64_t ns = atomic64_read(&mgr->time_spend[hw_ip]);
 
-		if (!ctx->entities[hwip][idx])
-			continue;
+		usage[hw_ip] = ns_to_ktime(ns);
+	}
 
-		centity = ctx->entities[hwip][idx];
-		amdgpu_ctx_fence_time(ctx, centity, &ttotal, &tmax);
+	idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
+		for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
+			for (i = 0; i < amdgpu_ctx_num_entities[hw_ip]; ++i) {
+				struct amdgpu_ctx_entity *centity;
+				ktime_t spend;
 
-		/* Harmonic mean approximation diverges for very small
-		 * values. If ratio < 0.01% ignore
-		 */
-		if (AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(tmax, ttotal))
-			continue;
-
-		total = ktime_add(total, ttotal);
-		max = ktime_after(tmax, max) ? tmax : max;
+				centity = ctx->entities[hw_ip][i];
+				if (!centity)
+					continue;
+				spend = amdgpu_ctx_entity_time(ctx, centity);
+				usage[hw_ip] = ktime_add(usage[hw_ip], spend);
+			}
+		}
 	}
-
 	mutex_unlock(&mgr->lock);
-	if (elapsed)
-		*elapsed = max;
-
-	return total;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
index 3ceebab9c6ea..0fa0e56daf67 100644
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
@@ -60,6 +64,7 @@ struct amdgpu_ctx_mgr {
 	struct mutex		lock;
 	/* protected by lock */
 	struct idr		ctx_handles;
+	atomic64_t		time_spend[AMDGPU_HW_IP_NUM];
 };
 
 extern const unsigned int amdgpu_ctx_num_entities[AMDGPU_HW_IP_NUM];
@@ -89,6 +94,7 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr,
 void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr);
 long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout);
 void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);
-ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
-		uint32_t idx, uint64_t *elapsed);
+void amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr,
+			  ktime_t usage[AMDGPU_HW_IP_NUM]);
+
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index 5a6857c44bb6..4d453845235c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
@@ -32,6 +32,7 @@
 
 #include <drm/amdgpu_drm.h>
 #include <drm/drm_debugfs.h>
+#include <drm/drm_drv.h>
 
 #include "amdgpu.h"
 #include "amdgpu_vm.h"
@@ -54,26 +55,23 @@ static const char *amdgpu_ip_name[AMDGPU_HW_IP_NUM] = {
 
 void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
 {
-	struct amdgpu_fpriv *fpriv;
-	uint32_t bus, dev, fn, i, domain;
-	uint64_t vram_mem = 0, gtt_mem = 0, cpu_mem = 0;
 	struct drm_file *file = f->private_data;
 	struct amdgpu_device *adev = drm_to_adev(file->minor->dev);
+	struct amdgpu_fpriv *fpriv = file->driver_priv;
+
+	uint64_t vram_mem = 0, gtt_mem = 0, cpu_mem = 0;
+	ktime_t usage[AMDGPU_HW_IP_NUM];
+	uint32_t bus, dev, fn, domain;
 	struct amdgpu_bo *root;
+	unsigned int hw_ip;
 	int ret;
 
-	ret = amdgpu_file_to_fpriv(f, &fpriv);
-	if (ret)
-		return;
 	bus = adev->pdev->bus->number;
 	domain = pci_domain_nr(adev->pdev->bus);
 	dev = PCI_SLOT(adev->pdev->devfn);
 	fn = PCI_FUNC(adev->pdev->devfn);
 
-	root = amdgpu_bo_ref(fpriv->vm.root.bo);
-	if (!root)
-		return;
-
+	root = fpriv->vm.root.bo;
 	ret = amdgpu_bo_reserve(root, false);
 	if (ret) {
 		DRM_ERROR("Fail to reserve bo\n");
@@ -81,31 +79,26 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
 	}
 	amdgpu_vm_get_memory(&fpriv->vm, &vram_mem, &gtt_mem, &cpu_mem);
 	amdgpu_bo_unreserve(root);
-	amdgpu_bo_unref(&root);
 
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
+	amdgpu_ctx_mgr_usage(&fpriv->ctx_mgr, usage);
 
-		for (idx = 0; idx < count; idx++) {
-			total = amdgpu_ctx_mgr_fence_usage(&fpriv->ctx_mgr,
-				i, idx, &min);
-			if ((total == 0) || (min == 0))
-				continue;
+	/*
+	 * ******************************************************************
+	 * For text output format description please see drm-usage-stats.rst!
+	 * ******************************************************************
+	 */
 
-			perc = div64_u64(10000 * total, min);
-			frac = perc % 100;
+	seq_printf(m, "pasid:\t%u\n", fpriv->vm.pasid);
+	seq_printf(m, "drm-driver:\t%s\n", file->minor->dev->driver->name);
+	seq_printf(m, "drm-pdev:\t%04x:%02x:%02x.%d\n", domain, bus, dev, fn);
+	seq_printf(m, "drm-memory-vram:\t%llu KiB\n", vram_mem/1024UL);
+	seq_printf(m, "drm-memory-gtt: \t%llu KiB\n", gtt_mem/1024UL);
+	seq_printf(m, "drm-memory-cpu: \t%llu KiB\n", cpu_mem/1024UL);
+	for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
+		if (!usage[hw_ip])
+			continue;
 
-			seq_printf(m, "%s%d:\t%d.%d%%\n",
-					amdgpu_ip_name[i],
-					idx, perc/100, frac);
-		}
+		seq_printf(m, "drm-engine-%s:\t%Ld ns\n", amdgpu_ip_name[hw_ip],
+			   ktime_to_ns(usage[hw_ip]));
 	}
 }
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2008EC433F5
	for <amd-gfx@archiver.kernel.org>; Tue, 10 May 2022 16:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A446310FBF9;
	Tue, 10 May 2022 16:55:55 +0000 (UTC)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5786E10FBF7
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 16:55:54 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 n126-20020a1c2784000000b0038e8af3e788so1818167wmn.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 May 2022 09:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kSmvi6E2csWCz9LtVejSfPnW2B1ljUvhdG79ABeunQQ=;
 b=UYW76nnbUJ/4E63roQHUtKrOCFBya7cn1KZW3+YqhPz74/l0VqItgfxlF2ga1OHbNQ
 ubovwnNj7hJg0trSe+EX6CxckAS01RA7rA12qsD/SuysTUKJdJr+o5MORK7vxwhhRPJ1
 J+v4sqVDGsD6PgFyTio8coi0HZ3n7OfdLT40VGsPfkW+ajKkx3GMXTYOaZYBDKvBD2QO
 egz9MHH8yoH2ctl4gkvt4LiKYw6gOFM8GelhHoeYpqqFn015QRhD2jUXpXgHrinnJISQ
 mglap3GOUTapl686ZxxHNeKAPFcD6y75pfi7bZEqVK15yBXAuy/RyO2sq6XPFyg/PH/5
 uIFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=kSmvi6E2csWCz9LtVejSfPnW2B1ljUvhdG79ABeunQQ=;
 b=1JTkP72szFJGYk4B4gGnEZlLLtMkiYPDa/p5qHQWbZLuXXAt3hC+xNPF1xJq3rtbhX
 oxov7hYzbeOnVWtFymRsGMPFAs4aCGyy9qaJYHm8JTj6UCgVAniV/A+SXZKtuc4QypTn
 5wmIncu0DiXSDwIG5PsQ0GoFEELuNyJAWcSnarejR+QeWXREw6hyvPT+OjglHqMO5orb
 /CHYqdXsauZ1+BeMSsDRk2XIbzotS/fXQU+SegrOM4AhWrtEAwgoITYp4yNVud/tjYLT
 5uiJVaJpSIDonQIOnfPX1Its1kJVsy3uziGH+i1aI08HtW0ZoDUOwYymu3+xw73hjLVh
 EPHA==
X-Gm-Message-State: AOAM532d04IehXt4goh8I4hNSmuvvb7tpIOTiteUM8z4EXuSNfnN0JtF
 wYpov44JtEqzeJnyiqZkYHCOqWY4bkw=
X-Google-Smtp-Source: ABdhPJyVQfxnZzDRXFykkGo4wZSvI/4e0muTw5BK5rG0hdCje7eS/pXTMJ13UZwPl5OrN6wi9EmOqw==
X-Received: by 2002:a05:600c:4f13:b0:394:8978:7707 with SMTP id
 l19-20020a05600c4f1300b0039489787707mr944754wmq.34.1652201752689; 
 Tue, 10 May 2022 09:55:52 -0700 (PDT)
Received: from able.fritz.box (p57b0b3fd.dip0.t-ipconnect.de. [87.176.179.253])
 by smtp.gmail.com with ESMTPSA id
 c1-20020adfef41000000b0020cd54239c8sm2448250wrp.61.2022.05.10.09.55.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 May 2022 09:55:52 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: Alexander.Deucher@amd.com, tvrtko.ursulin@linux.intel.com,
 amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/2] drm/amdgpu: Convert to common fdinfo format v2
Date: Tue, 10 May 2022 18:55:49 +0200
Message-Id: <20220510165550.2048-1-christian.koenig@amd.com>
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
Cc: David M Nieto <David.Nieto@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Vetter <daniel@ffwll.ch>, Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Tvrtko Ursulin <tvrtko.ursulin@intel.com>

Convert fdinfo format to one documented in drm-usage-stats.rst.

It turned out that the existing implementation was actually completely
nonsense. The calculated percentages indeed represented the usage of the
engine, but with varying time slices.

So 10% usage for application A could mean something completely different
than 10% usage for application B.

Completely nuke that and just use the now standardized nanosecond
interface.

v2: drop the documentation change for now, nuke percentage calculation

Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@intel.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
Cc: David M Nieto <David.Nieto@amd.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c    | 136 +++++++++------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h    |   8 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  45 ++++---
 3 files changed, 88 insertions(+), 101 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
index 8f0e6d93bb9c..988c5a76cad2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -183,6 +183,7 @@ static int amdgpu_ctx_init_entity(struct amdgpu_ctx *ctx, u32 hw_ip,
 	ctx_prio = (ctx->override_priority == AMDGPU_CTX_PRIORITY_UNSET) ?
 			ctx->init_priority : ctx->override_priority;
 	entity->sequence = 1;
+	entity->time_spend = 0;
 	hw_prio = amdgpu_ctx_get_hw_prio(ctx, hw_ip);
 	drm_prio = amdgpu_ctx_to_drm_sched_prio(ctx_prio);
 
@@ -666,6 +667,26 @@ int amdgpu_ctx_put(struct amdgpu_ctx *ctx)
 	return 0;
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
 void amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
 			  struct drm_sched_entity *entity,
 			  struct dma_fence *fence, uint64_t *handle)
@@ -685,6 +706,7 @@ void amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
 	spin_lock(&ctx->ring_lock);
 	centity->fences[idx] = fence;
 	centity->sequence++;
+	centity->time_spend += amdgpu_ctx_fence_time(other);
 	spin_unlock(&ctx->ring_lock);
 
 	dma_fence_put(other);
@@ -692,6 +714,42 @@ void amdgpu_ctx_add_fence(struct amdgpu_ctx *ctx,
 		*handle = seq;
 }
 
+static ktime_t amdgpu_ctx_entity_time(struct amdgpu_ctx *ctx,
+				      struct amdgpu_ctx_entity *centity)
+{
+	ktime_t res;
+	uint32_t i;
+
+	spin_lock(&ctx->ring_lock);
+	res = centity->time_spend;
+	for (i = 0; i < amdgpu_sched_jobs; i++) {
+		res = ktime_add(res, amdgpu_ctx_fence_time(centity->fences[i]));
+	}
+	spin_unlock(&ctx->ring_lock);
+	return res;
+}
+
+ktime_t amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
+			     uint32_t idx)
+{
+	struct amdgpu_ctx_entity *centity;
+	ktime_t res = ns_to_ktime(0);
+	struct amdgpu_ctx *ctx;
+	uint32_t id;
+
+	mutex_lock(&mgr->lock);
+	idr_for_each_entry(&mgr->ctx_handles, ctx, id) {
+
+		centity = ctx->entities[hwip][idx];
+		if (!centity)
+			continue;
+
+		res = ktime_add(res, amdgpu_ctx_entity_time(ctx, centity));
+	}
+	mutex_unlock(&mgr->lock);
+	return res;
+}
+
 struct dma_fence *amdgpu_ctx_get_fence(struct amdgpu_ctx *ctx,
 				       struct drm_sched_entity *entity,
 				       uint64_t seq)
@@ -869,81 +927,3 @@ void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr)
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
index 142f2f87d44c..b5bb4425b0ac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.h
@@ -23,6 +23,8 @@
 #ifndef __AMDGPU_CTX_H__
 #define __AMDGPU_CTX_H__
 
+#include <linux/ktime.h>
+
 #include "amdgpu_ring.h"
 
 struct drm_device;
@@ -30,10 +32,10 @@ struct drm_file;
 struct amdgpu_fpriv;
 
 #define AMDGPU_MAX_ENTITY_NUM 4
-#define AMDGPU_CTX_FENCE_USAGE_MIN_RATIO(max, total) ((max) > 16384ULL*(total))
 
 struct amdgpu_ctx_entity {
 	uint64_t		sequence;
+	ktime_t			time_spend;
 	struct drm_sched_entity	entity;
 	struct dma_fence	*fences[];
 };
@@ -89,6 +91,6 @@ void amdgpu_ctx_mgr_init(struct amdgpu_ctx_mgr *mgr);
 void amdgpu_ctx_mgr_entity_fini(struct amdgpu_ctx_mgr *mgr);
 long amdgpu_ctx_mgr_entity_flush(struct amdgpu_ctx_mgr *mgr, long timeout);
 void amdgpu_ctx_mgr_fini(struct amdgpu_ctx_mgr *mgr);
-ktime_t amdgpu_ctx_mgr_fence_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
-		uint32_t idx, uint64_t *elapsed);
+ktime_t amdgpu_ctx_mgr_usage(struct amdgpu_ctx_mgr *mgr, uint32_t hwip,
+			     uint32_t idx);
 #endif
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c
index 5a6857c44bb6..38cb5eb105ad 100644
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
 
@@ -83,29 +84,33 @@ void amdgpu_show_fdinfo(struct seq_file *m, struct file *f)
 	amdgpu_bo_unreserve(root);
 	amdgpu_bo_unref(&root);
 
-	seq_printf(m, "pdev:\t%04x:%02x:%02x.%d\npasid:\t%u\n", domain, bus,
+	/*
+	 * ******************************************************************
+	 * For text output format description please see drm-usage-stats.rst!
+	 * ******************************************************************
+	 */
+
+	seq_printf(m, "drm-driver:\t%s\n", file->minor->dev->driver->name);
+	seq_printf(m, "drm-pdev:\t%04x:%02x:%02x.%d\npasid:\t%u\n", domain, bus,
 			dev, fn, fpriv->vm.pasid);
-	seq_printf(m, "vram mem:\t%llu kB\n", vram_mem/1024UL);
-	seq_printf(m, "gtt mem:\t%llu kB\n", gtt_mem/1024UL);
-	seq_printf(m, "cpu mem:\t%llu kB\n", cpu_mem/1024UL);
-	for (i = 0; i < AMDGPU_HW_IP_NUM; i++) {
-		uint32_t count = amdgpu_ctx_num_entities[i];
-		int idx = 0;
-		uint64_t total = 0, min = 0;
-		uint32_t perc, frac;
+	seq_printf(m, "drm-memory-vram:\t%llu KiB\n", vram_mem/1024UL);
+	seq_printf(m, "drm-memory-gtt:\t%llu KiB\n", gtt_mem/1024UL);
+	seq_printf(m, "drm-memory-cpu:\t%llu KiB\n", cpu_mem/1024UL);
+	for (hw_ip = 0; hw_ip < AMDGPU_HW_IP_NUM; ++hw_ip) {
+		uint32_t count = amdgpu_ctx_num_entities[hw_ip];
+		int idx;
 
-		for (idx = 0; idx < count; idx++) {
-			total = amdgpu_ctx_mgr_fence_usage(&fpriv->ctx_mgr,
-				i, idx, &min);
-			if ((total == 0) || (min == 0))
-				continue;
+		for (idx = 0; idx < count; ++idx) {
+			ktime_t usage;
 
-			perc = div64_u64(10000 * total, min);
-			frac = perc % 100;
+			usage = amdgpu_ctx_mgr_usage(&fpriv->ctx_mgr, hw_ip,
+						     idx);
+			if (!usage)
+				continue;
 
-			seq_printf(m, "%s%d:\t%d.%d%%\n",
-					amdgpu_ip_name[i],
-					idx, perc/100, frac);
+			seq_printf(m, "drm-engine-%s%d:\t%Ld ns\n",
+				   amdgpu_ip_name[hw_ip], idx,
+				   ktime_to_ns(usage));
 		}
 	}
 }
-- 
2.25.1


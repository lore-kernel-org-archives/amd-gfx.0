Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B033CD8C83
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 14:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E39E110E840;
	Thu, 13 Nov 2025 14:53:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OuFbOq2I";
	dkim-atps=neutral
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5493810E842
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 14:53:44 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-640e9f5951aso3345388a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 06:53:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763045623; x=1763650423; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tQnKR6BVkVq/lytryILuoJ7y27PRk2N9J9MO3CCJcto=;
 b=OuFbOq2I3I3Z8WY6ipvjPxeIowGYX/CBDy52CL8mCLHbrz0OI/BD5iY4I0A8dT6w3h
 jrCRG+1opfp9mbdV5wzeovrPODWik+27eH6KjjMqG8nggcGStasv9VlGvD7yUWX0VZMb
 +Tehr7nwAwZGPOSo02borf3RdPBODry8Ar3k6s/etVrNwMVwcl1Yu5+5gbr9lnuJhZNi
 9FZgzqpNglpoqMdoalNnQFqqZM8/xBOVAMZ+YRxP9FJE/VcqnG/OyaTGnKBmQLvXgYS4
 VlXNNXZdZTkZT0rumaYzO3+T0XTcfs2/gBafPejqTKvpcuGw+MPMVBFc+Ar6kbH01keq
 k6vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763045623; x=1763650423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tQnKR6BVkVq/lytryILuoJ7y27PRk2N9J9MO3CCJcto=;
 b=jTnR+vfFHDFsKY+U5Qc5jf5CoT5wEh4rHEROUTvdPBCd07oScB9HwfP6Jt+wFr1V6K
 l8cw+QVEYq0OHCXEmIqk/7RvhcGnrNhdre0J1wv6qUJ87T/dJkTssDLKt+BFtmQm4q7q
 MVYKnwjAQerdQY7Mkh5AxSVsMMgyV80e8hbIaDX1XurbXdxsOL2sWP0cagutl4AUYoT7
 znj4oedSRZ6yamdmBvaoVGr/GX6LdoAGp099q8yjXkSJS5Jx/kxnU3MdgzE+4ecU9rP0
 bZt6ENqjSslb5kpwy5HxDU22AWSVZyOdyU7FX2y2zYCW/c9FjAYgFsQNkh3JnO99nLye
 ZiSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKF7txLeaS8beqQ+2IMjSRMUg09eqiOdXPgdxB3591F595laNXDFXTMWGWIDZ1JfX5bhsHsFp6@lists.freedesktop.org
X-Gm-Message-State: AOJu0YznzjxHsn05SIsjpMIXgy9hhpKByrKRUzCkAYBqutYkV7hP5iJO
 zTQzvwWGWaQLgwPonbjixPgL9W9u9BVnV22J0qp7SCg57vs28yF6k7R/
X-Gm-Gg: ASbGncvRP0BdcMxyr7/zzmj9H1bCxv/YC6HafUEkrtYCmFUCxUbjEYza7Kf2CS/6/ZX
 HHjNyy/fh6IHwrfZ8OFk1QWvyrSWiGhhF7emOnEnidTzBuI4DVl3nYPfoZmbqfVLRPRAla5B3i5
 fuPNeSfkTcAmYTGfyTLS+pjP0uwd1ANsoND0lE8i4avqiB6ogIRav7uIOyg2CMW9lfjqOmvNdIq
 tQQkm18L/Xl2AO3mKS8XcL2sow+rPui43T2ZuvMk6wwqmYrQtKF4zQapSvz+MHWZyryXXR+fBz8
 wt0tv2hxQQzjWkEViSTCzHb0Mg/9hIbrTzQ9v+QpHTI6eqZe6HiUjJWVzJ3J7YKaNoYwSND0xDB
 gRZpDARtqWUmu9Vth1jFhGpRYCSfpaE0zEvPaRpTIbT7JQZ/wjdtfHMsCgpHwOCIVBi2ShDi+lv
 wXDgfLwLj2mpc=
X-Google-Smtp-Source: AGHT+IFYHRIAnIeYEGi7huimmcPbHNOgv11CUklwEqIUYs8aWn9mTAXkB9EfeqZtLICy9hCrUMs0kw==
X-Received: by 2002:a17:907:2d26:b0:b72:6224:7e95 with SMTP id
 a640c23a62f3a-b7348056638mr368571866b.1.1763045622794; 
 Thu, 13 Nov 2025 06:53:42 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15aa:c600:cef:d94:436c:abc5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b73513b400fsm173747166b.1.2025.11.13.06.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 06:53:42 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, matthew.brost@intel.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, sumit.semwal@linaro.org
Subject: [PATCH 10/18] drm/amdgpu: independence for the amdgpu_fence!
Date: Thu, 13 Nov 2025 15:51:47 +0100
Message-ID: <20251113145332.16805-11-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113145332.16805-1-christian.koenig@amd.com>
References: <20251113145332.16805-1-christian.koenig@amd.com>
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

This should allow amdgpu_fences to outlive the amdgpu module.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c | 63 +++++++----------------
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h  |  1 -
 2 files changed, 20 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
index c7843e336310..990fcbbe90a0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
@@ -112,8 +112,7 @@ int amdgpu_fence_emit(struct amdgpu_ring *ring, struct amdgpu_fence *af,
 	af->ring = ring;
 
 	seq = ++ring->fence_drv.sync_seq;
-	dma_fence_init(fence, &amdgpu_fence_ops,
-		       &ring->fence_drv.lock,
+	dma_fence_init(fence, &amdgpu_fence_ops, NULL,
 		       adev->fence_context + ring->idx, seq);
 
 	amdgpu_ring_emit_fence(ring, ring->fence_drv.gpu_addr,
@@ -467,7 +466,6 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring)
 	timer_setup(&ring->fence_drv.fallback_timer, amdgpu_fence_fallback, 0);
 
 	ring->fence_drv.num_fences_mask = ring->num_hw_submission * 2 - 1;
-	spin_lock_init(&ring->fence_drv.lock);
 	ring->fence_drv.fences = kcalloc(ring->num_hw_submission * 2, sizeof(void *),
 					 GFP_KERNEL);
 
@@ -654,16 +652,20 @@ void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error)
 	struct amdgpu_fence_driver *drv = &ring->fence_drv;
 	unsigned long flags;
 
-	spin_lock_irqsave(&drv->lock, flags);
+	rcu_read_lock();
 	for (unsigned int i = 0; i <= drv->num_fences_mask; ++i) {
 		struct dma_fence *fence;
 
-		fence = rcu_dereference_protected(drv->fences[i],
-						  lockdep_is_held(&drv->lock));
-		if (fence && !dma_fence_is_signaled_locked(fence))
+		fence = dma_fence_get_rcu(drv->fences[i]);
+		if (!fence)
+			continue;
+
+		dma_fence_lock_irqsave(fence, flags);
+		if (!dma_fence_is_signaled_locked(fence))
 			dma_fence_set_error(fence, error);
+		dma_fence_unlock_irqrestore(fence, flags);
 	}
-	spin_unlock_irqrestore(&drv->lock, flags);
+	rcu_read_unlock();
 }
 
 /**
@@ -714,16 +716,19 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 	seq = ring->fence_drv.sync_seq & ring->fence_drv.num_fences_mask;
 
 	/* mark all fences from the guilty context with an error */
-	spin_lock_irqsave(&ring->fence_drv.lock, flags);
+	rcu_read_lock();
 	do {
 		last_seq++;
 		last_seq &= ring->fence_drv.num_fences_mask;
 
 		ptr = &ring->fence_drv.fences[last_seq];
-		rcu_read_lock();
-		unprocessed = rcu_dereference(*ptr);
+		unprocessed = dma_fence_get_rcu(*ptr);
+
+		if (!unprocessed)
+			continue;
 
-		if (unprocessed && !dma_fence_is_signaled_locked(unprocessed)) {
+		dma_fence_lock_irqsave(unprocessed, flags);
+		if (dma_fence_is_signaled_locked(unprocessed)) {
 			fence = container_of(unprocessed, struct amdgpu_fence, base);
 
 			if (fence == af)
@@ -731,9 +736,10 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 			else if (fence->context == af->context)
 				dma_fence_set_error(&fence->base, -ECANCELED);
 		}
-		rcu_read_unlock();
+		dma_fence_unlock_irqrestore(unprocessed, flags);
+		dma_fence_put(unprocessed);
 	} while (last_seq != seq);
-	spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
+	rcu_read_unlock();
 	/* signal the guilty fence */
 	amdgpu_fence_write(ring, (u32)af->base.seqno);
 	amdgpu_fence_process(ring);
@@ -823,39 +829,10 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
 	return true;
 }
 
-/**
- * amdgpu_fence_free - free up the fence memory
- *
- * @rcu: RCU callback head
- *
- * Free up the fence memory after the RCU grace period.
- */
-static void amdgpu_fence_free(struct rcu_head *rcu)
-{
-	struct dma_fence *f = container_of(rcu, struct dma_fence, rcu);
-
-	/* free fence_slab if it's separated fence*/
-	kfree(to_amdgpu_fence(f));
-}
-
-/**
- * amdgpu_fence_release - callback that fence can be freed
- *
- * @f: fence
- *
- * This function is called when the reference count becomes zero.
- * It just RCU schedules freeing up the fence.
- */
-static void amdgpu_fence_release(struct dma_fence *f)
-{
-	call_rcu(&f->rcu, amdgpu_fence_free);
-}
-
 static const struct dma_fence_ops amdgpu_fence_ops = {
 	.get_driver_name = amdgpu_fence_get_driver_name,
 	.get_timeline_name = amdgpu_fence_get_timeline_name,
 	.enable_signaling = amdgpu_fence_enable_signaling,
-	.release = amdgpu_fence_release,
 };
 
 /*
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
index 7a27c6c4bb44..9cbf63454004 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -125,7 +125,6 @@ struct amdgpu_fence_driver {
 	unsigned			irq_type;
 	struct timer_list		fallback_timer;
 	unsigned			num_fences_mask;
-	spinlock_t			lock;
 	struct dma_fence		**fences;
 };
 
-- 
2.43.0


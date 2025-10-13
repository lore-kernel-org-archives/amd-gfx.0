Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203BACCD18D
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Oct 2025 14:35:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E6E210E47E;
	Mon, 13 Oct 2025 14:35:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W7bcxmWl";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D39410E47B
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 14:35:14 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-62fa062a1abso8036582a12.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Oct 2025 07:35:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760366113; x=1760970913; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1A715ZOUYAQ/DDFT6NNIb9Py2IFUcYcPpvUQTUpbOVM=;
 b=W7bcxmWlFrgaM8k5gie76wdQ3dj9QmRtlhaE9FC79h9i3pDAwhgGZQ4F35vEBfv5xZ
 YkHXfdwEg9WbvOHP0J2axHXw98ChqWz1B9AR/RYIOnuaoaVYUkQkuZlMqEcoWv856alW
 Jw7W1AS3jxyJ0hVqTH+BHnKsZoU7RQlGrSUGwG5OJH6FLPa2uYFRuUAMYQp/VjG2U+I3
 726hN/vaXCjJOpEJ/OHHCjWS4LrdhL4AGCn9QjuEJOGaU1HXtvsrSAn1+CVLwBe4QQJa
 3VQyPpiJBHUjRxAYEqUjpsWZObPc1PAs5nYrOqqUuM2IZfJegl69WfOdApgv0dRSZ8XH
 829Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760366113; x=1760970913;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1A715ZOUYAQ/DDFT6NNIb9Py2IFUcYcPpvUQTUpbOVM=;
 b=cZ1q1ZLFiuB/mjF0ORhZR9YLlgCiO/3v38R6smkx2ok9y4PDeSZJxfM2bIEYt8kBiY
 SyqmfE1FbE034ahRzymbWqcpzxNxmpKRo/V+XGJ5EaJrxH+/VhgtoRwOpLCzWPBQ7Ad9
 Bs9ukdN13ruP2rGpdY3Jjq1sgX2Zxl37TU61fRh3uhA4rpvm8iq9BpTnGcO96pYEP9eu
 M07Dx+cQcvzrTl4jLFi66b1pevpTGE5cmG0g86ImljZEX8wlN6mdghZSCzempXAFdTi+
 fp7xyak/ZmO5hAGmcm2KykC/KDuF+Ll0iclfv9CbqhaAgi/1zAs1+SIOOm8A7iL3ZQEn
 9EVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPIJNlA2+XASg2Ce/Vgr9yvTPS+9OHSsJy528TbQPufA5MX/9B1bhxih0/NLLw7cAg6IfWQgtj@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx7Kl4NQvYki8ez1cFAaTFvl39AZUtQAZLv3SdkeUz2LuZDpQlv
 Jp2SpyDwhBhe93xO3WPZ9Wo1I4f2R2EmLwKUKLE9rF0ZtmbAV2bMK10b
X-Gm-Gg: ASbGncswkimYryW9XM4+8mxwkA2B7mg+rAKDsKoGgNSyWivIl0WyybZOunf4gPKa4H3
 dac06FeV2ASqbLf1kVqMStXCYAZ9j68VuVJObVCm8IGBmF8jOfcFaZHeOgj6CW2bQ3vfzNYBO4e
 xIlk0nqEjYDrNUIBWKt4PO5dZELK0Z2j4G3SyQ7C4N6exnigiVh3AIfib5z/R+arqqtLNhQYngG
 u3Dklz6bBq/nMhTQC2XEK7w1tfkKBL6By1ahjAB+v4Na7ReyaR5t+0jqJFOjwwNnyw51d7+TEkQ
 NN6J1PqzQOWo4gE3NC6qufqgvKOxXDOHX2oEbe65aHYWF4C3HEBwNXm6AHGzreZIJEnSAScAema
 Q/jdZXpvWOcGrQVS5DKo+ULthzOUGBc/v452j/sHhrvQMyXXahfA5jRT012Ubn/IfkA==
X-Google-Smtp-Source: AGHT+IE4uCbERMwhJzarnOab9zEq3e5VKLhEDL90zcbdlKLp29lonApf1TaELbdbVsH6y50TzBG4Wg==
X-Received: by 2002:a17:906:6a14:b0:b44:2d0:e05f with SMTP id
 a640c23a62f3a-b50ac2cf494mr2343868066b.33.1760366112701; 
 Mon, 13 Oct 2025 07:35:12 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:151b:dc00:15d1:ebc5:76e6:730f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63a5c321453sm8942037a12.39.2025.10.13.07.35.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Oct 2025 07:35:12 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 11/15] drm/amdgpu: independence for the amdgpu_fence!
Date: Mon, 13 Oct 2025 15:48:38 +0200
Message-ID: <20251013143502.1655-12-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251013143502.1655-1-christian.koenig@amd.com>
References: <20251013143502.1655-1-christian.koenig@amd.com>
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
index 1fe31d2f2706..413f65239ebd 100644
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
@@ -468,7 +467,6 @@ int amdgpu_fence_driver_init_ring(struct amdgpu_ring *ring)
 	timer_setup(&ring->fence_drv.fallback_timer, amdgpu_fence_fallback, 0);
 
 	ring->fence_drv.num_fences_mask = ring->num_hw_submission * 2 - 1;
-	spin_lock_init(&ring->fence_drv.lock);
 	ring->fence_drv.fences = kcalloc(ring->num_hw_submission * 2, sizeof(void *),
 					 GFP_KERNEL);
 
@@ -655,16 +653,20 @@ void amdgpu_fence_driver_set_error(struct amdgpu_ring *ring, int error)
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
+		dma_fence_lock(fence, flags);
+		if (!dma_fence_is_signaled_locked(fence))
 			dma_fence_set_error(fence, error);
+		dma_fence_unlock(fence, flags);
 	}
-	spin_unlock_irqrestore(&drv->lock, flags);
+	rcu_read_unlock();
 }
 
 /**
@@ -715,16 +717,19 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
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
+		dma_fence_lock(unprocessed, flags);
+		if (dma_fence_is_signaled_locked(unprocessed)) {
 			fence = container_of(unprocessed, struct amdgpu_fence, base);
 
 			if (fence == af)
@@ -732,9 +737,10 @@ void amdgpu_fence_driver_guilty_force_completion(struct amdgpu_fence *af)
 			else if (fence->context == af->context)
 				dma_fence_set_error(&fence->base, -ECANCELED);
 		}
-		rcu_read_unlock();
+		dma_fence_unlock(unprocessed, flags);
+		dma_fence_put(unprocessed);
 	} while (last_seq != seq);
-	spin_unlock_irqrestore(&ring->fence_drv.lock, flags);
+	rcu_read_unlock();
 	/* signal the guilty fence */
 	amdgpu_fence_write(ring, (u32)af->base.seqno);
 	amdgpu_fence_process(ring);
@@ -824,39 +830,10 @@ static bool amdgpu_fence_enable_signaling(struct dma_fence *f)
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
index 87b962df5460..cab59a29b7c3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.h
@@ -124,7 +124,6 @@ struct amdgpu_fence_driver {
 	unsigned			irq_type;
 	struct timer_list		fallback_timer;
 	unsigned			num_fences_mask;
-	spinlock_t			lock;
 	struct dma_fence		**fences;
 };
 
-- 
2.43.0


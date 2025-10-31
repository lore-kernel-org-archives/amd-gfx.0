Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF74DCCF9FE
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 13:45:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FC0B10EBA8;
	Fri, 31 Oct 2025 13:45:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Nb6TuXOm";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C26710EB7E
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 13:45:09 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-475dbc3c9efso14464435e9.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 06:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761918308; x=1762523108; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1A715ZOUYAQ/DDFT6NNIb9Py2IFUcYcPpvUQTUpbOVM=;
 b=Nb6TuXOmfjvoHJyQWtTTXrBfzHy5hqU2cfFFdLKROC8v0eaaO/ht1PXErVJBuh/3ZA
 ux+q3ADFgX3fwiszp0rOUtQyFike9N0LI43/DBLEdDhTGNhzU2ZSNYuf//x95us8vY4K
 bQxJ/fuZVQAPQ5R4Jko17cLWsVjzDnMw9eor4l3AmdEWnDQXHzDDsv5/qvNczRYzTciy
 oT5EBxCs+8h/6VObAT7pbAPVgq0v2BYvc+1vNqe8ALrMtziY4rjMZSqNtsrzVlSAol5S
 OCoRNiFePETxqrmr5i2Lg4vKimVxi5NFitPtSJHei8br+jlk8oT0WTx5AeLfSzOpDxBp
 tSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761918308; x=1762523108;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1A715ZOUYAQ/DDFT6NNIb9Py2IFUcYcPpvUQTUpbOVM=;
 b=lXe6ZMUESnPnbor44ucW63xs44a7eTqw9Ck6+zMB5iK6q6cV021Z7dm5pqaMD8vTJi
 Dv87GOwHIZDZngZ1E/37AP2Ogx5xb2Ug9l+7yytCEajKc0bMa40jd8WUrY/C9CDy0OZp
 wbGVm6OEUR8Q7G97nv9/Rl+Iu/fG9CLrIFhzc9Baqrp78166LW4kgo3Cgeuzohddl3xa
 ogf/nHPLo3Df+tTy1K0FBjkI56xX59XiOYN/2A8TGunsY5D4bg5Vh18kIlUqXRYVY9wB
 k4vxUaz9ykCDiUO4HGvRxy10e75z6bepMwgJA5BWiQqdOVpNrkK6W1oWFBDlP4Cc3JCp
 Je/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXgtBNGImxTvAI9uM2A+UvAinvxiSQc8W+Hjl8hV8gyVY8hEpznyGYDdKkORFkXdvOwty1bvZ+e@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxOJypQvBDIHcT8jeyKvCBSmxxq1+oXOUB3eMunwtTenTU5ZByQ
 q19eZZqs4q5wg2e7p+e9qwXVtWvKosDkPhGwQsqVfspwtQmgJiRcf8Xe
X-Gm-Gg: ASbGncswAZwmtWhaYqcukm0RO16auPn7LmuuUqEBnGn4tQ2S+GCxJmA8hzegJa5Yq9e
 fbGhdraGm5uiNzDihk7rHBykMXinQJ/dULDvOS/Lq6c8XOUMolRXEMUN6A88edy8IG74OPcjB1A
 xk8YlTSSiZCBcnpS1FzmTwdq3aJ6b3Q6Z5PTApFU7tLyhekNhsLpC52sCwBilv4WBGjc+p8j9qC
 /uHix4kn+GtMGRp5DuhmqBC7TENxb0E0rIqzJQhPMSNvEMdBCrDPQugyZBql2BR1Jzt6RQ4UGe0
 6vQaDdVFe67ESzehiqsN1QRjPq4f7GFkpEFZrt11/NJ9bcyLFLJOX3J7/HzVNtOT14fUj3XuuG7
 DututndbTia6YKQGa9gcMnKeDOlcDoTuVetppKOEGRMjIRukdxhWIy9OXp2owbZXtDI0w3dMA2A
 8g+nt9qtQUySh0Hj0veODnt3u5
X-Google-Smtp-Source: AGHT+IHK8cFgzEn6M6jKPkmlhTUej2JmXXfAKvaLz/6gn8uQ5lu7I1FQ7mmZXdIQBLDBztU0j5dbOw==
X-Received: by 2002:a05:600c:538e:b0:46e:5100:326e with SMTP id
 5b1f17b1804b1-477308a1198mr34712295e9.23.1761918307832; 
 Fri, 31 Oct 2025 06:45:07 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1599:7d00:73cb:d446:bf90:f1c0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47732fe119bsm34502635e9.10.2025.10.31.06.45.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 06:45:07 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, airlied@gmail.com, felix.kuehling@amd.com,
 matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/20] drm/amdgpu: independence for the amdgpu_fence!
Date: Fri, 31 Oct 2025 14:16:46 +0100
Message-ID: <20251031134442.113648-13-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031134442.113648-1-christian.koenig@amd.com>
References: <20251031134442.113648-1-christian.koenig@amd.com>
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


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E00ACD8C82
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 14:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6F04810E843;
	Thu, 13 Nov 2025 14:53:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VSBSU6Tv";
	dkim-atps=neutral
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com
 [209.85.208.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E022D10E83D
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 14:53:42 +0000 (UTC)
Received: by mail-ed1-f50.google.com with SMTP id
 4fb4d7f45d1cf-6417313bddaso1572096a12.3
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 06:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763045621; x=1763650421; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=PyPXU09MHf0sQOMw0xMzptL/19K/nBS/D4vJF5btR6A=;
 b=VSBSU6TvQNMPsCnoEz7/Wsjm1GjLiNINrVQNTs4Vx/gEKcwhxcWr4zv67rBxMQ7tps
 /UjuDw43APDk0TqcTihR3xBZn9KYdCSqXwrutiyLcs7C20duUFEAvudE/oZZJvCtCNDl
 ieDQIeFVOQohpPKBShsStz91v3bW74MVPJoQ3k7qX835PpeuLEKoxwE/Z3oUmNLoX/VC
 qf9lyxgP5/FFPocKc+aOiF7J+fHSSK3NWLqwsYk7vZpjyXQytECKuYfV8qIvod2MJTt7
 FxV4wbISX5oIYGiR6erFTSqsfPHGN25D1ov6g9nwo3Pf24Ja3eKTGNQcv1FS9IxzddD6
 o3tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763045621; x=1763650421;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=PyPXU09MHf0sQOMw0xMzptL/19K/nBS/D4vJF5btR6A=;
 b=o6ZE6PoBMJ47fDL7wcthpvRcQBerMc68gSjTCK9JtWgvEX5yJmYWY3BokWgzNAyaJS
 jOoM+n7i5Fui+i8Uhdkpi22LR5I2hNjm8uy206tYMu5BeAlpiDZJ51G2q/VcdcjZQnd1
 fFAfHE5m/r19G+wes/oD2ZQuUtBkYXpqZAJbbskLkmjmtTlfQLdSniSddHdvyJrBO75p
 60AZmFjzY/UPuC0Otr4B9Z13R52/muDhywNc/CNiv91nauK3qyCYRfPilSSEPXm2cMjw
 D32YNfGCpklX0q+3waLLdjZNTrzw2gb2d1ay4/MLLN9kRAfo5T/r42pfmY3xcuYjuChD
 H8xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXihGhfEshZ2xMx4EYpm8bQ1003JrMNhDNNYBrjq0kCwzQmMw6sTPwUZBk/qYl/y3Ho3g1i6r+9@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxlYFjbyY+OclvfFG+XDmyzcq7WIGvyZzXKqj7TAHHzGDLcLy8d
 g4n/AKH4UBD4fVYfyTMZcYdEhnPpnXL1juoEnEp53y8cGmuXhaasjcd3
X-Gm-Gg: ASbGncuv4QNVTx2W1CzcxmOFpPK2jE7BX3RaFiyie6OhXSyHGd7/UOshgTJxCoiMkz8
 E2wFvTF5wTU7YdtF8FQeYmRKxxGCB71Hu8G1mwOhCLDhpIDrqBqNbAR8Y2IoPkRPEI4m8pkrdcJ
 20LUhGg7/ZnrbNtbaPZQuAM5wadXJs+i0Mc/Rqs4rXHd2iai2hz2TTzIl1rV4F8VcmpShPcWIEn
 4pv5PkysZwhvul53wF8jPoIvMlX7Dgz1Q7uxjL8rIYZzNKROcFHrVET6+thLEWrXQdsqfkzKfap
 pzMI4yjsoQECBqt7YbC0lTdf0u0YNd1P6gsxoTOGLcAYdO5g584IC0jxM8zBES4z0HYkdgKENTt
 1tfdBKw444t8wLUTR6F8qkoVic9aWiEocqaVo4TZ4LCpU0/p8IZtj78fp0/dguXisrp8o57O4KI
 6p3cv8kYAePe2Z8Cf3AfUW0g==
X-Google-Smtp-Source: AGHT+IGwF/OC+hr52+361MK7+mN4u8O29dW+FiL9JjV6JlzX+GGacshi6JqZmr/3Q1cXgUc/t7Hv0w==
X-Received: by 2002:a17:907:94ca:b0:b70:fede:1b58 with SMTP id
 a640c23a62f3a-b733195fe6dmr706242866b.2.1763045621257; 
 Thu, 13 Nov 2025 06:53:41 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15aa:c600:cef:d94:436c:abc5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b73513b400fsm173747166b.1.2025.11.13.06.53.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 06:53:40 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, matthew.brost@intel.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, sumit.semwal@linaro.org
Subject: [PATCH 08/18] drm/sched: use inline locks for the drm-sched-fence
Date: Thu, 13 Nov 2025 15:51:45 +0100
Message-ID: <20251113145332.16805-9-christian.koenig@amd.com>
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

Using the inline lock is now the recommended way for dma_fence implementations.

So use this approach for the scheduler fences as well just in case if
anybody uses this as blueprint for its own implementation.

Also saves about 4 bytes for the external spinlock.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/scheduler/sched_fence.c | 7 +++----
 include/drm/gpu_scheduler.h             | 4 ----
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
index 08ccbde8b2f5..47471b9e43f9 100644
--- a/drivers/gpu/drm/scheduler/sched_fence.c
+++ b/drivers/gpu/drm/scheduler/sched_fence.c
@@ -161,7 +161,7 @@ static void drm_sched_fence_set_deadline_finished(struct dma_fence *f,
 	/* If we already have an earlier deadline, keep it: */
 	if (test_bit(DRM_SCHED_FENCE_FLAG_HAS_DEADLINE_BIT, &f->flags) &&
 	    ktime_before(fence->deadline, deadline)) {
-		spin_unlock_irqrestore(&fence->lock, flags);
+		dma_fence_unlock_irqrestore(f, flags);
 		return;
 	}
 
@@ -217,7 +217,6 @@ struct drm_sched_fence *drm_sched_fence_alloc(struct drm_sched_entity *entity,
 
 	fence->owner = owner;
 	fence->drm_client_id = drm_client_id;
-	spin_lock_init(&fence->lock);
 
 	return fence;
 }
@@ -230,9 +229,9 @@ void drm_sched_fence_init(struct drm_sched_fence *fence,
 	fence->sched = entity->rq->sched;
 	seq = atomic_inc_return(&entity->fence_seq);
 	dma_fence_init(&fence->scheduled, &drm_sched_fence_ops_scheduled,
-		       &fence->lock, entity->fence_context, seq);
+		       NULL, entity->fence_context, seq);
 	dma_fence_init(&fence->finished, &drm_sched_fence_ops_finished,
-		       &fence->lock, entity->fence_context + 1, seq);
+		       NULL, entity->fence_context + 1, seq);
 }
 
 module_init(drm_sched_fence_slab_init);
diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
index fb88301b3c45..b77f24a783e3 100644
--- a/include/drm/gpu_scheduler.h
+++ b/include/drm/gpu_scheduler.h
@@ -297,10 +297,6 @@ struct drm_sched_fence {
          * belongs to.
          */
 	struct drm_gpu_scheduler	*sched;
-        /**
-         * @lock: the lock used by the scheduled and the finished fences.
-         */
-	spinlock_t			lock;
         /**
          * @owner: job owner for debugging
          */
-- 
2.43.0


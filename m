Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 884B4CCFA04
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 13:45:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D99B910EB5E;
	Fri, 31 Oct 2025 13:45:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nEf26lzt";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7393410EB79
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 13:45:04 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-47112a73785so16605795e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 06:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761918303; x=1762523103; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dfWOafKsZ7DPTVt8nlss86nYpnNm5p3DpeP54xVlFhE=;
 b=nEf26lztjyPik1YAeGKhAZS9rRhu44nUxFM0xKFGiWQ3EibHJ+A110Kg2mG6HUx21M
 iTQDd3ysDxiEdTsCkgI55vqe3P+EfACRN8Pd5EXHSyBKrhy4IUPNS6r/0HujIyv9L545
 Nu//Q8dMmOga22hMV7ttFyCnU10b13eKU2LGed5Rgjt27/7X/aKSOTuZhB+760RdTFVU
 8vkZduUAhpDwh1Q7E6aVSMTInrjx9NBRaYjp0VREnmTrYCtKN/SGVuZQqd0J0vPAKnHX
 Fasu0ib6eo0W4pKrt0Y2Byj1wQGJUwgsOjV0oW3Wgz6uLgpxlNvE89BnpoSer58SrWDL
 yKfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761918303; x=1762523103;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dfWOafKsZ7DPTVt8nlss86nYpnNm5p3DpeP54xVlFhE=;
 b=k9/UBr9D+1+GCMNZrcWSIM593GysG1C9alM9YukQe9qaLTRdmwNulDJOqH/bU+9OCG
 Iw2A5Ld8mv0oUiKPuF6RgBL2wmQGzRqxiUcUyRYrqUWVEKY4RUMBgLJ9+RjJrBC7PJ7t
 8vVB+E3vGkK1nKVx1RYLW3QRQtSaM4tNWP54TgFJljn+Pw/Y77pXsHDd8hxt9xj3D91j
 ETjeBbuY5Z38GbG8PrTDIxWkbO6jVyDgc18LhhbGvpw5aOkJvKYkdQLJ33CaDEWjkw9K
 I+XMze6QPnMWzKkyywxYdD2+xs8dg8MnBoDvozkyyRIDPIB6pqZdZFYHcSJBbdm+M3Wc
 oK+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGVIE6hDzl5IVgLH7+N3+I1KWZXFz9XW1lfB/5NvJljwIzJYkCMQnlWBSY5CcU1oyHV4x+YvQD@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyKW58jzjfbyDsTshy+bu+mAF86UsUfmSrUjtfNzSkAJJtFuddm
 h+KRscIt/5osN3rsS7nAYcrBg6t+trsqSF5fyoj1NDYKq6W32JSJjnpg
X-Gm-Gg: ASbGncsNfun5jSPCkjrLOmFEYWfR8h7yYe26mBhMe8EaISBGUHveyr2dxCmaLoPjQmg
 zpsTm13PHp5P4scEI0yd5olRfr5GjsHHS2bk3wrtFFj6xIDkh0B+82FgRFOBLvdfXTl14qDsNtH
 PAVrHIgiaybohytuBEH/m83Zm2ZLN3ZG/1x4iq6agvKe5ioTt1mivoRGecJivUUy0Wtoe6wAkso
 dLOMBFBr48nzmFYPp/l4QLq6+FJ5V+HJNv+mkBHODuyffIag+IpSAX+nYlQ0PenEuazZQgiGi7J
 L4iDaMR5GTIitYDwocwJyMWgyraRJlwfh4JBDxZUV2v15HB10eWQF+z20lqLaaRAYfi6GpGaC0r
 PK9Pl8UoubEsj81tnIyXyp6pkc+GIG3EzQ6Mj2RjR9H+KzVmOkOy/a1fp88w6el43rOGY5toex/
 usdvrLJPvf4hP+oaUiDBeukyBU
X-Google-Smtp-Source: AGHT+IEOxRy5Gh8F+wkvLB8MIcovfZgfTqoZZuZnAcVQvzapzejdLjXmFbLxqN9bk8MCZBm0OWmLmg==
X-Received: by 2002:a05:600c:1912:b0:477:1622:7f78 with SMTP id
 5b1f17b1804b1-477308a5e56mr32771315e9.40.1761918302871; 
 Fri, 31 Oct 2025 06:45:02 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1599:7d00:73cb:d446:bf90:f1c0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47732fe119bsm34502635e9.10.2025.10.31.06.45.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 06:45:01 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, airlied@gmail.com, felix.kuehling@amd.com,
 matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 09/20] drm/sched: use inline locks for the drm-sched-fence
Date: Fri, 31 Oct 2025 14:16:43 +0100
Message-ID: <20251031134442.113648-10-christian.koenig@amd.com>
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

Just as proof of concept and minor cleanup.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/scheduler/sched_fence.c | 11 +++++------
 include/drm/gpu_scheduler.h             |  4 ----
 2 files changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/scheduler/sched_fence.c b/drivers/gpu/drm/scheduler/sched_fence.c
index 9391d6f0dc01..7a94e03341cb 100644
--- a/drivers/gpu/drm/scheduler/sched_fence.c
+++ b/drivers/gpu/drm/scheduler/sched_fence.c
@@ -156,19 +156,19 @@ static void drm_sched_fence_set_deadline_finished(struct dma_fence *f,
 	struct dma_fence *parent;
 	unsigned long flags;
 
-	spin_lock_irqsave(&fence->lock, flags);
+	dma_fence_lock(f, flags);
 
 	/* If we already have an earlier deadline, keep it: */
 	if (test_bit(DRM_SCHED_FENCE_FLAG_HAS_DEADLINE_BIT, &f->flags) &&
 	    ktime_before(fence->deadline, deadline)) {
-		spin_unlock_irqrestore(&fence->lock, flags);
+		dma_fence_unlock(f, flags);
 		return;
 	}
 
 	fence->deadline = deadline;
 	set_bit(DRM_SCHED_FENCE_FLAG_HAS_DEADLINE_BIT, &f->flags);
 
-	spin_unlock_irqrestore(&fence->lock, flags);
+	dma_fence_unlock(f, flags);
 
 	/*
 	 * smp_load_aquire() to ensure that if we are racing another
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


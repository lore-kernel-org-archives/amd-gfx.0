Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD5A9CD8C87
	for <amd-gfx@archiver.kernel.org>; Thu, 13 Nov 2025 14:53:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF49A10E858;
	Thu, 13 Nov 2025 14:53:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hcHyBTFR";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41CCC10E841
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 14:53:48 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6418b55f86dso1509059a12.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 13 Nov 2025 06:53:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1763045627; x=1763650427; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=GCZeJVfvfEkQYdgy793PGjn+BtLipo5yJTYuBq0cOZM=;
 b=hcHyBTFRdUA3v9CY8RhKUPXGJt6fct9MGETSeBxTzIzd3a2x8FJ9oJKT4DIxAisMK1
 hdXLa9ugPeyyGjSwz4sCK/uOf15rRbW+4YkYs8qH615l+WI/H/khDEB4ae0ppJ+HMm5k
 HchNO+vpwNJeARjwf7zMjZF3hMsHiD8VMJC+VpnxPaCvYE9776x/1/S8kcq2+yxgDEh1
 vLzcHBIPvhgnqMSwM5Est3HkM/gv8mxDS4moOT3To2P3DdqfiP/77wRMrD+Zou0WHTVo
 0so/5dYMDtzd6zrGxultFYUPkqviq8Jpkja0vZaX7kgsvRqLAs7hRFGCrOn5h5OXbEtk
 Xyfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763045627; x=1763650427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GCZeJVfvfEkQYdgy793PGjn+BtLipo5yJTYuBq0cOZM=;
 b=ncXyHwwCqutdHCFrgLSahba4pT0PHTf7zaI13N7dty+4h/dEUSlxoRzlavdyFNfAiR
 u6BshoAzpdmRUxbd+SBI13oM0VV0lUUGmxbvP4FPxkbwZGd5cNDGoZBY/JN/JEaLi9d0
 t0UmCAJrMzAGHHSg+uEEn+6xK6baV2+nWLFpi+NznNQl1uWUxuHSxv4FryJ22gJXrhWL
 RsPUZCjf8wOVpY+pmjgghQ+0G7dRRLwBN09CLVNntvFtB/8o2EiCAS4shuPo52y2KUR0
 uY6W+Wz4gu7X48MsfGTD+U5Pn5jE+AEpAZRX9L8vsiv/pUFn7rs+HXo+BJgOpMCC7XYo
 5lQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTcKQpcVT7EObNNeTxEsVA5tp6Dser6pEq9h0mIRpuOd51DCGWe6e/icy4247OIWB4giInMwbK@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2tpWV2ZmZUtSr8VYUgL/je7l2+JX4aAsVN/Aj3nUeY1ty90rN
 rRnQeKLoJV3znpSIb1lDpb9d4AjBc4iSLSpi/SptFAxm+dO65fxZYL5R
X-Gm-Gg: ASbGncuzc54oixzht3foMCBdGRkzHVP8xcBjJQKYWQ7EGbIVpjUQGLEIfqSmaJHO2rY
 WsBR9cUQla7+bX4IzFZl4hyzMyDyz4rXcJ7i5Pxj6FU0EYr0OGHz/LwCt3R/0Y6Qc+Tch6cXPmX
 X6f6fIRAqE4cy4tjE4kJqzbEsNLYxIhFLZTRspt+/eQyo0n4ZRTZj9ogHcs/hKah/1aQNHDmUHD
 65WCS1UI2TjSK6I2/WF+AwCYnGl6K4SZnow6jmcRO419aoUCz+tDz1H2Yku8STTg6dEk+QoI/bv
 HgBQQmXveINMig8EecaDCPRYeF44xG4kCA+cwzuH8mu9O/5lh8h66cRVYMNP+WsujwVBZHkYazz
 AFFmz/3yff7wBEalDa/qE5tDg1dW6TwYO1dv8ogpTrE5izLKEVzB9JSLpME2xutEwLAIAV09lho
 G/7wI8ZNmnJtfo6pSh4i6Yqg==
X-Google-Smtp-Source: AGHT+IFTUpjYEZEKibKPo8txad1YlVZTcvDTCnxM3ibhTL5DA++BidJqqAp7OqK5WH2EjKo5LdtqZg==
X-Received: by 2002:a17:907:962a:b0:b6d:67b0:ca0b with SMTP id
 a640c23a62f3a-b7331c06865mr662805566b.61.1763045626671; 
 Thu, 13 Nov 2025 06:53:46 -0800 (PST)
Received: from able.fritz.box ([2a00:e180:15aa:c600:cef:d94:436c:abc5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b73513b400fsm173747166b.1.2025.11.13.06.53.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Nov 2025 06:53:46 -0800 (PST)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, matthew.brost@intel.com,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, sumit.semwal@linaro.org
Subject: [PATCH 15/18] drm/xe: Disconnect the low hanging fences from Xe module
Date: Thu, 13 Nov 2025 15:51:52 +0100
Message-ID: <20251113145332.16805-16-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113145332.16805-1-christian.koenig@amd.com>
References: <20251113145332.16805-1-christian.koenig@amd.com>
MIME-Version: 1.0
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

From: Matthew Brost <matthew.brost@intel.com>

Preempt, tlb invalidation, and OA fences now use embedded fence lock.

Signed-off-by: Matthew Brost <matthew.brost@intel.com>
---
 drivers/gpu/drm/xe/xe_oa.c                  | 5 +----
 drivers/gpu/drm/xe/xe_preempt_fence.c       | 3 +--
 drivers/gpu/drm/xe/xe_preempt_fence_types.h | 2 --
 drivers/gpu/drm/xe/xe_tlb_inval.c           | 5 +----
 drivers/gpu/drm/xe/xe_tlb_inval_types.h     | 2 --
 5 files changed, 3 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index 7a13a7bd99a6..41d081781060 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -112,8 +112,6 @@ struct xe_oa_config_bo {
 struct xe_oa_fence {
 	/* @base: dma fence base */
 	struct dma_fence base;
-	/* @lock: lock for the fence */
-	spinlock_t lock;
 	/* @work: work to signal @base */
 	struct delayed_work work;
 	/* @cb: callback to schedule @work */
@@ -1017,8 +1015,7 @@ static int xe_oa_emit_oa_config(struct xe_oa_stream *stream, struct xe_oa_config
 	}
 
 	/* Point of no return: initialize and set fence to signal */
-	spin_lock_init(&ofence->lock);
-	dma_fence_init(&ofence->base, &xe_oa_fence_ops, &ofence->lock, 0, 0);
+	dma_fence_init(&ofence->base, &xe_oa_fence_ops, NULL, 0, 0);
 
 	for (i = 0; i < stream->num_syncs; i++) {
 		if (stream->syncs[i].flags & DRM_XE_SYNC_FLAG_SIGNAL)
diff --git a/drivers/gpu/drm/xe/xe_preempt_fence.c b/drivers/gpu/drm/xe/xe_preempt_fence.c
index 7f587ca3947d..75f433aee747 100644
--- a/drivers/gpu/drm/xe/xe_preempt_fence.c
+++ b/drivers/gpu/drm/xe/xe_preempt_fence.c
@@ -145,9 +145,8 @@ xe_preempt_fence_arm(struct xe_preempt_fence *pfence, struct xe_exec_queue *q,
 {
 	list_del_init(&pfence->link);
 	pfence->q = xe_exec_queue_get(q);
-	spin_lock_init(&pfence->lock);
 	dma_fence_init(&pfence->base, &preempt_fence_ops,
-		      &pfence->lock, context, seqno);
+		       NULL, context, seqno);
 
 	return &pfence->base;
 }
diff --git a/drivers/gpu/drm/xe/xe_preempt_fence_types.h b/drivers/gpu/drm/xe/xe_preempt_fence_types.h
index ac125c697a41..a98de8d1c723 100644
--- a/drivers/gpu/drm/xe/xe_preempt_fence_types.h
+++ b/drivers/gpu/drm/xe/xe_preempt_fence_types.h
@@ -25,8 +25,6 @@ struct xe_preempt_fence {
 	struct xe_exec_queue *q;
 	/** @preempt_work: work struct which issues preemption */
 	struct work_struct preempt_work;
-	/** @lock: dma-fence fence lock */
-	spinlock_t lock;
 	/** @error: preempt fence is in error state */
 	int error;
 };
diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_tlb_inval.c
index 918a59e686ea..5c23e76b0241 100644
--- a/drivers/gpu/drm/xe/xe_tlb_inval.c
+++ b/drivers/gpu/drm/xe/xe_tlb_inval.c
@@ -133,7 +133,6 @@ int xe_gt_tlb_inval_init_early(struct xe_gt *gt)
 	tlb_inval->seqno = 1;
 	INIT_LIST_HEAD(&tlb_inval->pending_fences);
 	spin_lock_init(&tlb_inval->pending_lock);
-	spin_lock_init(&tlb_inval->lock);
 	INIT_DELAYED_WORK(&tlb_inval->fence_tdr, xe_tlb_inval_fence_timeout);
 
 	err = drmm_mutex_init(&xe->drm, &tlb_inval->seqno_lock);
@@ -420,10 +419,8 @@ void xe_tlb_inval_fence_init(struct xe_tlb_inval *tlb_inval,
 {
 	xe_pm_runtime_get_noresume(tlb_inval->xe);
 
-	spin_lock_irq(&tlb_inval->lock);
-	dma_fence_init(&fence->base, &inval_fence_ops, &tlb_inval->lock,
+	dma_fence_init(&fence->base, &inval_fence_ops, NULL,
 		       dma_fence_context_alloc(1), 1);
-	spin_unlock_irq(&tlb_inval->lock);
 	INIT_LIST_HEAD(&fence->link);
 	if (stack)
 		set_bit(FENCE_STACK_BIT, &fence->base.flags);
diff --git a/drivers/gpu/drm/xe/xe_tlb_inval_types.h b/drivers/gpu/drm/xe/xe_tlb_inval_types.h
index 8f8b060e9005..80e893950099 100644
--- a/drivers/gpu/drm/xe/xe_tlb_inval_types.h
+++ b/drivers/gpu/drm/xe/xe_tlb_inval_types.h
@@ -104,8 +104,6 @@ struct xe_tlb_inval {
 	struct delayed_work fence_tdr;
 	/** @job_wq: schedules TLB invalidation jobs */
 	struct workqueue_struct *job_wq;
-	/** @tlb_inval.lock: protects TLB invalidation fences */
-	spinlock_t lock;
 };
 
 /**
-- 
2.43.0


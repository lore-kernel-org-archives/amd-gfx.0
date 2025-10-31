Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17E67CCF9FE
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Oct 2025 13:45:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B808710EB95;
	Fri, 31 Oct 2025 13:45:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DYrIX5G9";
	dkim-atps=neutral
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACDE910EB8E
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 13:45:18 +0000 (UTC)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-429be5d31c9so711603f8f.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Oct 2025 06:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761918317; x=1762523117; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FOT+HS7HwjNpa3wVCpddyk0kdx55eNwMPoHyR/qguCA=;
 b=DYrIX5G9Vvz1JMt4f8q3UNqN6XU3v/p1cA3eNw5hmuMK3alukzJ3rEAmwDpz7j6qm+
 dAkNPKgGWwURvZ7evox1wKzXbgFd7zmXBf0QUe4ioYN3UmAkYTH7eneNmEw1tHlWsuQV
 TrrGpwHE55ujnPrWd2RCOl9QCrTLgNO2IoaPgo92QE47UAjZ/2eQqSNBR3uwEUykCxKt
 uiBAPirFJmzGzeSbwswRvhORfe01Smffs0xbuzmJ8cR9B9TjgH+FwNl74nxaNFWwAjcw
 jfGvGvrkxbYuxJFNifOGtb06kuuzIPSaOB4LWsnjTHvS0Xg1sOxm6wCOL/IM2aweeSGc
 DdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761918317; x=1762523117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FOT+HS7HwjNpa3wVCpddyk0kdx55eNwMPoHyR/qguCA=;
 b=RZ/1b9DNjDcyo99CDLgVeHJL+QhyXpl6ZZZ8D+3Jl7elb85hlvgYscFdCC9CKHM7vY
 R11Vbj9CZEgrAvmeOQVSf6LGusYi4A59myO0vsg544zRRxzjvpKhbG+0bY75TZB/aImu
 TnR3wvQYbqXw9i6A4qOnuhf9sVV15rxTmGvskFGOVxCb2Q1D3vs7WVMHXhRSX0OiAADY
 s1NmhgB7V4+XIQxSV80j4jVEUrY5O7KmDq3yzmRECdFFDWiCZdKRTfIDlyVjjV+warHL
 vtkQkhHYv6gIpx32phXbThWo357z98mjBqgqZ+GrywtEeLmsgE1ZV6Ekr+Ja2MkIMwLf
 3Zfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWYnDT6d5L+FHsrrghvJ01z3RtBByIQtGeiSSCQZFaZqC13C2vUuFuBh/6D/rImcfcF7q7K595u@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy7GXKEhcoAxfwLDAw1LT5ZJZsokK+0Qs37YQ/55jkprFEreCXz
 Ug8dT6EhbtF9RbB4VDrefrAk9w77i+XkjcroQm+0vzm/i6XLtOM76HsH
X-Gm-Gg: ASbGncveX8aYJtUt1IduYyXhB/Glm8a/wxjFgpCRzdAufrXrd3IF/GmLmvsMBBrVLdx
 dxo5IC/wMgzGUQqyb1mn2JSWXGiGzHZIbHNfTAc/fhOXv67nVDheYWUGtVbDxxubJLHehpWcD4T
 fMDFgaPrbY6YoYjrP8JAecqu2TEebaW7omIsA5cw0oKgwCCfcZ7BByLi1H0pTnPS904m/4BMdqE
 vdF52hBnQRcjNBfFNS4D3uwy7QMIQrpCGUteOC14tZcwUfFctnx7FRDWFh1Ht7SwObnwbXJCJ7p
 a34kVlLKh6WxiO6U2jGvsaaAxE22UATwlPCJswtTTXVPBUMIb99UO1N65F9L/1H6AYvTCSmGMoW
 ePgOpTZyf7okTE0u7S3sNnx/bGp6mOeA/YVExILnECg4egE3NZoSOhXnDrlnSpQXW/sDLQ85Jom
 z4bd7ESEoACzQjoA==
X-Google-Smtp-Source: AGHT+IG44c44EYxlrDHWSVFLS0w4WQJr858+HNKRu3Z0uUwk7iRytbIezkZcATeQeevGYiOaj0Viyw==
X-Received: by 2002:a05:6000:26c9:b0:429:bc68:6c9c with SMTP id
 ffacd0b85a97d-429bd6e16c9mr3236545f8f.48.1761918317021; 
 Fri, 31 Oct 2025 06:45:17 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:1599:7d00:73cb:d446:bf90:f1c0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47732fe119bsm34502635e9.10.2025.10.31.06.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 06:45:16 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: phasta@mailbox.org, alexdeucher@gmail.com, simona.vetter@ffwll.ch,
 tursulin@ursulin.net, airlied@gmail.com, felix.kuehling@amd.com,
 matthew.brost@intel.com
Cc: dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org
Subject: [PATCH 17/20] drm/xe: Disconnect the low hanging fences from Xe module
Date: Fri, 31 Oct 2025 14:16:51 +0100
Message-ID: <20251031134442.113648-18-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251031134442.113648-1-christian.koenig@amd.com>
References: <20251031134442.113648-1-christian.koenig@amd.com>
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
index f901ba52b403..c8613bafb8db 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -111,8 +111,6 @@ struct xe_oa_config_bo {
 struct xe_oa_fence {
 	/* @base: dma fence base */
 	struct dma_fence base;
-	/* @lock: lock for the fence */
-	spinlock_t lock;
 	/* @work: work to signal @base */
 	struct delayed_work work;
 	/* @cb: callback to schedule @work */
@@ -1016,8 +1014,7 @@ static int xe_oa_emit_oa_config(struct xe_oa_stream *stream, struct xe_oa_config
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


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C02BACA9ED2
	for <amd-gfx@archiver.kernel.org>; Mon, 12 Oct 2026 20:44:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51E7A10E289;
	Mon, 12 Oct 2026 20:44:50 +0000 (UTC)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com
 [209.85.208.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 083D210E695
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 20:44:44 +0000 (UTC)
Received: by mail-ed1-f53.google.com with SMTP id
 4fb4d7f45d1cf-6b1ab02ba4dso2428760a12.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 13:44:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791837882; x=1792442682; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vpAWDPAZPdCXMbk9m4pyv0yPbpK6eL4DWT2QmShQfsM=;
 b=ibbzE8mYqIAxSeAsL/NLrOGtWV/VmcqYew1XAGQiKGzPUzbSyOZ1Ucj4N2t0Apf+Mc
 fgJ4qQuptigTHXW4Axo5VY5LKCKaxZeAb9ZWD39NfqeKczo7LaAc6NJcdkb8avJ+MMzG
 4d6/lBSKypznFoKmnkUqCJb/hkTrW5VWR0ADD9F6K9eI7h+dacb7CLB/daLKcrA4wLr9
 zgqHOtBBWz6cev3L/c5tw7U1jfQOLwdhMDRwVFp7i7Oudhz0vk1dVmDqVaPqkdQgU3bi
 qJ/Lietp0Yta4hwB5pmZ5dBrY7MjXm3B1HUgh/11dHnxs9MpybiPoL4nHM6H75su3YF6
 xVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791837882; x=1792442682;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vpAWDPAZPdCXMbk9m4pyv0yPbpK6eL4DWT2QmShQfsM=;
 b=fJpFwlMoDiQ3V2jfsm0ZjvFYMC1OLSqAqC+/OJbcNJ4CNJWMfNx7v2j6E+Ddnlz7wh
 HEqwg3O98nHP4V3RPYPjvr19Doa9ITXTNdYsbj2NL1izZ0L1LYQCYR7X4cojXJezJrzY
 6hfCU9J0OTINJX4UekH4ZldOw1xQ7Rpg2LeVyqhOk+0+yqwrLg7RRA3ZxiOnophjpO85
 07sVxaJRdW02DNY99Q8Hg/qWLinFUbIeBBAeiTIE9HIz4jaTRhuBbLJKzbK1xCA+Nhmi
 q4bFeCl6UbUhEc6iPxBixzh/ke/W1+MkDs1kKNFaNesE2gwDPORiDdRJ6G7++qlimgd2
 iINw==
X-Gm-Message-State: AFq9FYKEJtkoDMvePBrShMCbrp92f6PVfphJnS1gZ5Ves1gvdzwP12vw
 l2/zvdlk/RS/gO3/4/UHQJFxNvrwpo3PLmCUgfStPIfZh9Am61JLtse1bbcphzIQ
X-Gm-Gg: AYBFou25Vt3WS1BKGPQOHEo+J5Qj4Bc03q0ZIUMbm/8wRAdQzDK/x8qH/lrZFlpn8Mf
 QVgRW9Ervl566kJ4vGnYqAXw5a4cp6YD3PbCgpiZvSa9atdi3p2F6FxovF+HP0zMt8VhCkIwz/w
 jzQMuyOkf3wnD0XSeEUaPJ9KA8Etogbe2bPklAeB16BRVveKWPw/MGZbFdOelyLf0rctn3Qw2D6
 4O94TTVlVCQcfJVlc2el93M2snmRiKjuIWTsf6K/ugT1H0HUILtOYK/qhg9RjqpCl0mUBdGelsq
 VQMNEIJYbj68x1E7RckToKvfsOwQb6tAsI8vDKhERN+GbrQ3MRWv7514Um4UwJrnRzTEmcYG2EP
 qug4zWPtsIhPjoCV4wmEbuhSsZlhQYv+wxN1kHnbC/mD5s8IAd97kOX3RujBSdCN1BpQIv5v86T
 ay4BgcjYfP4LOCRbKRoVaxLoNUyX3hItUzJlFTsuS2Vfp7QR/T7EUfnpMWQUX46Ip4z1qc+EagX
 JdH4859uPmy8tH9+Q==
X-Received: by 2002:a17:906:c14d:b0:c26:1691:b364 with SMTP id
 a640c23a62f3a-c31a9f6b5d1mr1034967966b.29.1791837882190; 
 Mon, 12 Oct 2026 13:44:42 -0700 (PDT)
Received: from localhost.localdomain ([37.214.28.88])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c31a9a3ae6csm495404666b.17.2026.10.12.13.44.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 13:44:41 -0700 (PDT)
From: Bogdan Metla <edistuo.revresbo@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: Bogdan Metla <edistuo.revresbo@gmail.com>
Subject: [PATCH] drm/radeon: fix wake event stealing in fence_is_signaled
 polling
Date: Mon, 12 Oct 2026 23:43:57 +0300
Message-ID: <20261012204357.785030-1-edistuo.revresbo@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Commit 5f08eee9c3fb ("drm/radeon: restore hardware polling in
fence_is_signaled to fix performance regression") restored hardware
polling by calling radeon_fence_activity() inside the dma-fence
.signaled callback.

During the review of that patch, the automated kernel reviewer
flagged a [High] severity issue: radeon_fence_activity() in the
.signaled callback consumes hardware state without waking up wait
queues. Because last_seq is advanced there, a later interrupt-driven
radeon_fence_process() sees no new activity (seq <= last_seq),
returns false and skips wake_up_all(). This steals the wake event
and can leave tasks waiting on fences hanging indefinitely.

Reproduced on Radeon HD 5450 (Cedar), where interrupts can be
missed under heavy 2D redraw load: the screen freezes while the
cursor keeps moving, and recovery requires new GPU work (e.g.
glxgears) or a modeset to trigger a fresh interrupt.

Fix this by scheduling a deferred work item when
radeon_fence_activity() reports new completions inside
radeon_fence_is_signaled(). The worker calls wake_up_all()
unconditionally from process context, which restores the stolen
wake event without re-introducing the self-deadlock on the fence
lock, and without rw_semaphore manipulation in atomic context.
schedule_work() is idempotent, so repeated polling is cheap.

Assisted-by: LLM
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/5955
Fixes: 5f08eee9c3fb ("drm/radeon: restore hardware polling in fence_is_signaled to fix performance regression")
Signed-off-by: Bogdan Metla <edistuo.revresbo@gmail.com>
---
 drivers/gpu/drm/radeon/radeon.h       |  1 +
 drivers/gpu/drm/radeon/radeon_fence.c | 14 +++++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon.h b/drivers/gpu/drm/radeon/radeon.h
index 527b9d19d7..61b01df87f 100644
--- a/drivers/gpu/drm/radeon/radeon.h
+++ b/drivers/gpu/drm/radeon/radeon.h
@@ -370,6 +370,7 @@ struct radeon_fence_driver {
 	atomic64_t			last_seq;
 	bool				initialized, delayed_irq;
 	struct delayed_work		lockup_work;
+	struct work_struct		wake_work;
 };
 
 struct radeon_fence {
diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
index 2998655692..5016dd0cbc 100644
--- a/drivers/gpu/drm/radeon/radeon_fence.c
+++ b/drivers/gpu/drm/radeon/radeon_fence.c
@@ -155,6 +155,15 @@ int radeon_fence_emit(struct radeon_device *rdev,
 	return 0;
 }
 
+static void radeon_fence_wake_work(struct work_struct *work)
+{
+	struct radeon_fence_driver *fence_drv =
+		  container_of(work, struct radeon_fence_driver, wake_work);
+	struct radeon_device *rdev = fence_drv->rdev;
+
+	wake_up_all(&rdev->fence_queue);
+}
+
 /*
  * radeon_fence_check_signaled - callback from fence_queue
  *
@@ -361,7 +370,8 @@ static bool radeon_fence_is_signaled(struct dma_fence *f)
 		return true;
 
 	if (down_read_trylock(&rdev->exclusive_lock)) {
-		radeon_fence_activity(rdev, ring);
+		if (radeon_fence_activity(rdev, ring))
+			schedule_work(&rdev->fence_drv[ring].wake_work);
 		up_read(&rdev->exclusive_lock);
 
 		if (atomic64_read(&rdev->fence_drv[ring].last_seq) >= seq)
@@ -826,6 +836,7 @@ static void radeon_fence_driver_init_ring(struct radeon_device *rdev, int ring)
 	rdev->fence_drv[ring].initialized = false;
 	INIT_DELAYED_WORK(&rdev->fence_drv[ring].lockup_work,
 			  radeon_fence_check_lockup);
+	INIT_WORK(&rdev->fence_drv[ring].wake_work, radeon_fence_wake_work);
 	rdev->fence_drv[ring].rdev = rdev;
 }
 
@@ -873,6 +884,7 @@ void radeon_fence_driver_fini(struct radeon_device *rdev)
 			radeon_fence_driver_force_completion(rdev, ring);
 		}
 		cancel_delayed_work_sync(&rdev->fence_drv[ring].lockup_work);
+		cancel_work_sync(&rdev->fence_drv[ring].wake_work);
 		wake_up_all(&rdev->fence_queue);
 		radeon_scratch_free(rdev, rdev->fence_drv[ring].scratch_reg);
 		rdev->fence_drv[ring].initialized = false;
-- 
2.53.0


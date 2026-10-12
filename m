Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67503CC6B03
	for <amd-gfx@archiver.kernel.org>; Tue, 13 Oct 2026 09:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EEB7410F63F;
	Tue, 13 Oct 2026 09:06:06 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DABA510E632
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 17:30:00 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c2dc8cb0decso220204066b.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 12 Oct 2026 10:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791826199; x=1792430999; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2r8Y9Zr5kK30lINNxOrZNto9YYuY4nrg9F+b7kFoFpg=;
 b=eFfOnEnogFp6FUm37XrQenkhXkbpHTc5cPKr43H9UQgShHokeQiYPyWC3x1skaNH9B
 +VnWHeGY1gxITR5j0DXZzmh0+sijSngizcYCfjpO9d+zsaOaYtLeoj4xrD/GAS4Ufqss
 azAwVUpZTGL2h/1QoVvMGC8MVjjH4hhzrRYP2taEPQqQ54KSHRNK2UkjqKtPPXCjbRKf
 xzNN7uH16F12sz4CRx9dx4GhW2KulEtRYMom4zPyAy7mA+uQTqM67WRmKqtBx15LpwwE
 9HCMCDIPeOBPP9Put+7idjYGwNtPo9Y7qQqbK8onbZ5X7yR6yx9YHs3a2dNo0Hbovb6p
 qS/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791826199; x=1792430999;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2r8Y9Zr5kK30lINNxOrZNto9YYuY4nrg9F+b7kFoFpg=;
 b=hnIZ2PDeUD1wKc8DNcOv4PW/7CBEwXmJaXhGULxFa5g7UWGZzNomwDXYohV/ZHKbdd
 TkLJfo80bBVBQNyW2fuD7CI9KPQzrcwbdVrPOFGzCUQSESeJbDL+1HeTrdp9yZkkmE41
 3CNPkz87WecjgtWPYr2uBqvgSDXPgJ4jDRoBNCIHcGUDCsRGpaT5kMUPuVptuLpGYl39
 HGyOsGx2a97HUzu1GmyrS1T2DbDq/3yO4sD0SuA3yTwJbkExkkt7KmKbwwPTQZq/fIrA
 y8HLy3nGHKJsWQVu6yKc5kK6Iw7NQioIVmdUU1H0auHDbxEcYmPMmVODtB0rkqXucW6X
 g6qA==
X-Gm-Message-State: AFq9FYIORs7M4jVDsvrTlAkE1KOHu5UWH9k0+iM0pYibYagqSzHQhqvP
 m2u1oUViEbmNlemuMRiIWbc9xrZxAKCVvbQty8TxMN5F+rYQwKU8qNhunxBL9B+U4VA=
X-Gm-Gg: AYBFou20PgJKamkrhZt18yhc0VQAM3M8xHQjs4zjgF6P8spkYkZWU/XEdta0/sT9860
 cU3WVvDIrOtABtd91T6/r+U5h3FSVH3LRQA+7s+Zcall/p1AD762N1DbgOBuPjzgBvE7LQw2CIy
 IFGeCT4WfaEzcXL/wA4qEJpeTWgWAejxm3DESkCWqyaUl0AEp6bEx8h+i1reLo/bqpB13GbpexV
 DdNV23T8xneqOBE8roXK/n614uejLEXOFLIY24G6VvgeCMzAEJbwapZ/Ug61oDu/YkTNL1HOW2j
 o2Tow4NGmSyQCCagg5IzykBpF7/P4m3fpa0mJCRHgX9nAoHs8rLNiWeCK1exFxU1ta8KOIqINy9
 MA6ZuqpvONfNeeLw/mnudoNvrXzOy6+pPBqhBqTMeT9EpgZQ/u05vWrUdjzgN/wH+bIDNCR8ZfH
 rzo90ZzBJxpIY3z6xh3lsnPmGh01LJ1PQDVgSxziOsmJSk7nfuGcox8OIv4DbOGGVhTFQGY+r9U
 fDQNq0QpoH+AbKQ6Y/SaETUtAZV
X-Received: by 2002:a17:906:4796:b0:c34:d75b:dde0 with SMTP id
 a640c23a62f3a-c34d75be9famr327151366b.20.1791826199005; 
 Mon, 12 Oct 2026 10:29:59 -0700 (PDT)
Received: from localhost.localdomain ([37.214.28.88])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c34a6b966ccsm160305866b.61.2026.10.12.10.29.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 10:29:58 -0700 (PDT)
From: Bogdan Metla <edistuo.revresbo@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, Bogdan Metla <edistuo.revresbo@gmail.com>,
 Wang Jiang <jiangwang@kylinos.cn>
Subject: [PATCH] drm/radeon: fix wake event stealing in fence_is_signaled
 polling
Date: Mon, 12 Oct 2026 20:22:24 +0300
Message-ID: <20261012172224.606915-1-edistuo.revresbo@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 13 Oct 2026 09:06:04 +0000
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
Cc: Wang Jiang <jiangwang@kylinos.cn>
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


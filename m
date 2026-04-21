Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DA66F8FA72
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 12:55:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B231E10EC93;
	Tue, 21 Apr 2026 12:55:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="EMnUA71J";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E18810EC53
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 12:55:27 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso57274405e9.3
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 05:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776776126; x=1777380926; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZMSwjNkYqNsZbUk8AbWzbhE69CgRYQS0K+Tfjpz1yvw=;
 b=EMnUA71J/MXgWHgXVFcXcREBI7qwffcOBqnk7ZIcR1uQr6Ey/fkrqWQ2MsHGT2MCpC
 ec8a0J/lOwO5MuLuTlVYPHFi+ZbcYhRWgGNIE8HIIPEGzm4e0Bono9/MNB9Gku5HHpPz
 o9K5iTWq/sZLndP4zVal/pGe4vmBBWxPmbnbsfg6xgqt9HAH7bc/thc5CBN8PO+sTj91
 iUwFrYCg4T0v7R9bnaK86acj2CLBTgnHeo6f128cx/OSriQwJGFpcBwzkU/BT8uNDoZy
 eNGfNS/yS/i1hMY09tUybVBZ6ncRzNw7YdbLsSfjRX56YNygrFMt+6iR+MOWvyg1r23A
 EooQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776776126; x=1777380926;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZMSwjNkYqNsZbUk8AbWzbhE69CgRYQS0K+Tfjpz1yvw=;
 b=g55F9u2ny1M4tp8cVZVnjBhwlyDL6w+SRs9z0U6bYb1psMdeh3CtkYb1joI0o0MmSk
 G7Yabt7kWESCtp1wt68GyslagoP9daWPHtAzCm8xzPVQYSnlxu8c/L9CxQNhcDQMoJHe
 +8/bLnePIPhMpXG2vO+cc1i35ocVXmVVFkTZpCt+lDYj6spswS1JCqd15e7Wmhu7vQPx
 wB2tcORm/I4GnVKlYKumn53L4NzVbCZwp8DOsr1UMwXnbzIIo3n1vNhc4kpixT5P/opa
 Sa5ql8URI6NvaNHOmriSNHiYIQvrIqL1fGWxS31lXHFi7aiZCsu9LTIUrNATMafWMSiM
 qLLA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+YHUXdLRBr1xFTP2Zy1EAkMb7wC3EOOIhbEdiStLenvFJDOl4pI0WdLtW5b22ZEiaqiQcrz36J@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEiOww/Tctw7Ud/g06jK6xZx+nJcV2ZY13eudaOOJJA+Rq7s0n
 D++8+i0eD9wjDkx8ie7i9x16v+gwYSERZIANqJpZD/T+NWMqksPoBaZX
X-Gm-Gg: AeBDievx821KKUIrftIXisUQmJGKU7GWTc8w8HGvhalX5oIuQqrAVmD+n85gWkAJW9A
 LtchMop0pF98kDTA8PMsySSUDWTU01h2NjIxHYec0ISH6a2LhEvKPfkiyPqN2sA6EUvaaiDmS7o
 baODvY54uCKuDWVupvzKjKaUeK49H+rCHYO+xIqxIUHuqsAHqoS5zBBHcg2/y2LzX+BB+wJSANZ
 XsCo9yquKu1jZYx5QLu1dLVvq5uNZMRLiffuQITE0ZHH/WUT3sZLos5IbAPYiTG9YTR0+NoHEe2
 qJDE7MNoMNJDBN3Mcz2eiD/Iz/loGay0s7JISDVnAOQk9JFd0LD84S6E8XtHiuIA7ETFnRY96Yf
 0xyW+3x3sayGgRgsnaGM9uEmrSqtznQBBVMZhWc9OtAI3Caef4omEr1vLsAgQcBIr7CyD47Jw4i
 fIj4+1/mLeJCR+AHbegZGtMthejjxw0rEx9BUvHowXC5+mgRg=
X-Received: by 2002:a05:600c:a10e:b0:485:3b9e:caa7 with SMTP id
 5b1f17b1804b1-488fb773f38mr201149535e9.23.1776776125423; 
 Tue, 21 Apr 2026 05:55:25 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15aa:5a00:935c:42ec:dfce:89a2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb79ecb9sm154777915e9.8.2026.04.21.05.55.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 05:55:24 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com, Prike.Liang@amd.com, sukhatri@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
Subject: [PATCH 07/11] drm/amdgpu: fix userq hang detection and reset
Date: Tue, 21 Apr 2026 14:55:09 +0200
Message-ID: <20260421125513.4545-7-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260421125513.4545-1-christian.koenig@amd.com>
References: <20260421125513.4545-1-christian.koenig@amd.com>
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

Fix lock inversions pointed out by Prike and Sunil. The hang detection
timeout *CAN'T* grab locks under which we wait for fences, especially
not the userq_mutex lock.

Then instead of this completely broken handling with the
hang_detect_fence just cancel the work when fences are processed and
re-start if necessary.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 65 ++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  1 -
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 17 +++--
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  2 +-
 4 files changed, 40 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 5ccd53ad8efd..0a4c39d83adc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -106,9 +106,6 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
 	int r = 0;
 	int i;
 
-	/* Warning if current process mutex is not held */
-	WARN_ON(!mutex_is_locked(&uq_mgr->userq_mutex));
-
 	if (unlikely(adev->debug_disable_gpu_ring_reset)) {
 		dev_err(adev->dev, "userq reset disabled by debug mask\n");
 		return 0;
@@ -127,9 +124,11 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
 	 */
 	for (i = 0; i < num_queue_types; i++) {
 		int ring_type = queue_types[i];
-		const struct amdgpu_userq_funcs *funcs = adev->userq_funcs[ring_type];
+		const struct amdgpu_userq_funcs *funcs =
+			adev->userq_funcs[ring_type];
 
-		if (!amdgpu_userq_is_reset_type_supported(adev, ring_type, AMDGPU_RESET_TYPE_PER_QUEUE))
+		if (!amdgpu_userq_is_reset_type_supported(adev, ring_type,
+							  AMDGPU_RESET_TYPE_PER_QUEUE))
 				continue;
 
 		if (atomic_read(&uq_mgr->userq_count[ring_type]) > 0 &&
@@ -150,38 +149,22 @@ amdgpu_userq_detect_and_reset_queues(struct amdgpu_userq_mgr *uq_mgr)
 
 static void amdgpu_userq_hang_detect_work(struct work_struct *work)
 {
-	struct amdgpu_usermode_queue *queue = container_of(work,
-							  struct amdgpu_usermode_queue,
-							  hang_detect_work.work);
-	struct dma_fence *fence;
-	struct amdgpu_userq_mgr *uq_mgr;
-
-	if (!queue->userq_mgr)
-		return;
-
-	uq_mgr = queue->userq_mgr;
-	fence = READ_ONCE(queue->hang_detect_fence);
-	/* Fence already signaled – no action needed */
-	if (!fence || dma_fence_is_signaled(fence))
-		return;
+	struct amdgpu_usermode_queue *queue =
+		container_of(work, struct amdgpu_usermode_queue,
+			     hang_detect_work.work);
 
-	mutex_lock(&uq_mgr->userq_mutex);
-	amdgpu_userq_detect_and_reset_queues(uq_mgr);
-	mutex_unlock(&uq_mgr->userq_mutex);
+	amdgpu_userq_detect_and_reset_queues(queue->userq_mgr);
 }
 
 /*
  * Start hang detection for a user queue fence. A delayed work will be scheduled
- * to check if the fence is still pending after the timeout period.
-*/
+ * to reset the queues when the fence doesn't signal in time.
+ */
 void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue)
 {
 	struct amdgpu_device *adev;
 	unsigned long timeout_ms;
 
-	if (!queue || !queue->userq_mgr || !queue->userq_mgr->adev)
-		return;
-
 	adev = queue->userq_mgr->adev;
 	/* Determine timeout based on queue type */
 	switch (queue->queue_type) {
@@ -199,8 +182,6 @@ void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue)
 		break;
 	}
 
-	/* Store the fence to monitor and schedule hang detection */
-	WRITE_ONCE(queue->hang_detect_fence, queue->last_fence);
 	schedule_delayed_work(&queue->hang_detect_work,
 		     msecs_to_jiffies(timeout_ms));
 }
@@ -210,18 +191,24 @@ void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
 	struct xarray *xa = &adev->userq_doorbell_xa;
 	struct amdgpu_usermode_queue *queue;
 	unsigned long flags;
+	int r;
 
 	xa_lock_irqsave(xa, flags);
 	queue = xa_load(xa, doorbell);
-	if (queue)
-		amdgpu_userq_fence_driver_process(queue->fence_drv);
-	xa_unlock_irqrestore(xa, flags);
-}
+	if (queue) {
+		r = amdgpu_userq_fence_driver_process(queue->fence_drv);
+		/*
+		 * We are in interrupt context here, this *can't* wait for
+		 * reset work to finish.
+		 */
+		if (r >= 0)
+			cancel_delayed_work(&queue->hang_detect_work);
 
-static void amdgpu_userq_init_hang_detect_work(struct amdgpu_usermode_queue *queue)
-{
-	INIT_DELAYED_WORK(&queue->hang_detect_work, amdgpu_userq_hang_detect_work);
-	queue->hang_detect_fence = NULL;
+		/* Restart the timer when there are still fences pending */
+		if (r == 1)
+			amdgpu_userq_start_hang_detect_work(queue);
+	}
+	xa_unlock_irqrestore(xa, flags);
 }
 
 static int amdgpu_userq_buffer_va_list_add(struct amdgpu_usermode_queue *queue,
@@ -640,7 +627,6 @@ amdgpu_userq_destroy(struct amdgpu_userq_mgr *uq_mgr, struct amdgpu_usermode_que
 	amdgpu_bo_unreserve(vm->root.bo);
 
 	mutex_lock(&uq_mgr->userq_mutex);
-	queue->hang_detect_fence = NULL;
 	amdgpu_userq_wait_for_last_fence(queue);
 
 #if defined(CONFIG_DEBUG_FS)
@@ -853,7 +839,8 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	up_read(&adev->reset_domain->sem);
 
 	amdgpu_debugfs_userq_init(filp, queue, qid);
-	amdgpu_userq_init_hang_detect_work(queue);
+	INIT_DELAYED_WORK(&queue->hang_detect_work,
+			  amdgpu_userq_hang_detect_work);
 
 	args->out.queue_id = qid;
 	atomic_inc(&uq_mgr->userq_count[queue->queue_type]);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index 843ea8ecc5d7..85f460e7c31b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -85,7 +85,6 @@ struct amdgpu_usermode_queue {
 	int			priority;
 	struct dentry		*debugfs_queue;
 	struct delayed_work hang_detect_work;
-	struct dma_fence *hang_detect_fence;
 	struct kref		refcount;
 
 	struct list_head	userq_va_list;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
index b0543fa257ed..beb2a1f679b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -141,7 +141,14 @@ amdgpu_userq_fence_put_fence_drv_refs(struct amdgpu_userq_fence *userq_fence)
 	userq_fence->fence_drv = NULL;
 }
 
-void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
+/*
+ * Returns:
+ * -ENOENT when no fences were processes
+ * 1 when more fences are pending
+ * 0 when no fences are pending any more
+ */
+int
+amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv)
 {
 	struct amdgpu_userq_fence *userq_fence, *tmp;
 	LIST_HEAD(to_be_signaled);
@@ -149,9 +156,6 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
 	unsigned long flags;
 	u64 rptr;
 
-	if (!fence_drv)
-		return;
-
 	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
 	rptr = amdgpu_userq_fence_read(fence_drv);
 
@@ -164,6 +168,9 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
 				&userq_fence->link);
 	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
 
+	if (list_empty(&to_be_signaled))
+		return -ENOENT;
+
 	list_for_each_entry_safe(userq_fence, tmp, &to_be_signaled, link) {
 		fence = &userq_fence->base;
 		list_del_init(&userq_fence->link);
@@ -176,6 +183,8 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
 		dma_fence_put(fence);
 	}
 
+	/* That doesn't need to be accurate so no locking */
+	return list_empty(&fence_drv->fences) ? 0 : 1;
 }
 
 void amdgpu_userq_fence_driver_destroy(struct kref *ref)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
index d355a0eecc07..0bd51616cef1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.h
@@ -63,7 +63,7 @@ void amdgpu_userq_fence_driver_put(struct amdgpu_userq_fence_driver *fence_drv);
 int amdgpu_userq_fence_driver_alloc(struct amdgpu_device *adev,
 				    struct amdgpu_userq_fence_driver **fence_drv_req);
 void amdgpu_userq_fence_driver_free(struct amdgpu_usermode_queue *userq);
-void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
+int amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_drv);
 void amdgpu_userq_fence_driver_force_completion(struct amdgpu_usermode_queue *userq);
 void amdgpu_userq_fence_driver_destroy(struct kref *ref);
 int amdgpu_userq_signal_ioctl(struct drm_device *dev, void *data,
-- 
2.43.0


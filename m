Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AD8EFF886D
	for <amd-gfx@archiver.kernel.org>; Mon, 27 Apr 2026 18:27:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3787B10E8C4;
	Mon, 27 Apr 2026 18:27:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="K6tuuert";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66FA710E8BA
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 18:27:29 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-48334ee0aeaso110850505e9.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 27 Apr 2026 11:27:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777314448; x=1777919248; darn=lists.freedesktop.org;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to;
 bh=JA5iYeuGbm2HE1glmsB6nqwIqgWBFwsZS05htCPhNPE=;
 b=K6tuuertpizZz/hGXmtVUlueNTzshNGrBNgGg9GyfNxFDRfVSYBumAkbtlQQZRNELN
 GFnUDcek7BxY+bXkTaFj98vyWQoVtnLZvMOEzEthY/+7D9kzWVcL7KIWq62RVen/CIVw
 aRVSUzflRnd8YvsG9jSfdZ5FcilZhPs9DlzORCCkdBE8wrDp9hKYOsSwsluEmdIOXM70
 c3q4Brlq0NePFrDioCLIgrEoPuBZUgALA6soVe4v5Amfd+sMkKONW3IzAA4cUrvwYEKQ
 M/LxTd/VQrHrSRXIT6pDoPM+M322gRiGSXoTQyIWzJuO5Cs2wAydGOEcRLWiLylY7EiS
 qC9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777314448; x=1777919248;
 h=content-transfer-encoding:reply-to:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JA5iYeuGbm2HE1glmsB6nqwIqgWBFwsZS05htCPhNPE=;
 b=VMle96hPNG0I67/4XcqBF2ZV4+hSk40fOItX8PmPbwtJiuv4OwB3c9iLEvP2ug0F5I
 Jklxf7oFF8HYeUOIkUtgaaGjlLFslnQFNS7dXtcKZTKa/Q6ONrzuC6l/aaQhIF8sGcqJ
 tE6Id4jg0RBOw4plRmaNi8UE7i4EQj0nQs0lsCKvuGSO4T9CFkEtF0BRjn+RFG3sVKdh
 DBOJd3k/38w0QgqC7f0o0mw8Q6E9lK2X6wP8wU4P7kp6WAOeVfRJRLQTnkBnvhT1AtrA
 L971lym10YaE/F+4obJ1OMWSMPcPJ1A4OmfJVFrBm5RFQA5HD2bmFiKeAQ6tAd2rtgGl
 Lo1A==
X-Gm-Message-State: AOJu0Ywytt4h3VT5+3Me8n4RBtNtABOF4Pjmbw/W5nOfHlvGS37hTQQy
 YzwIeIXhHAJt3B8lMqWcfqrJjVpzoENqh8p4e4SFLzd1AZttH4DbTbnM
X-Gm-Gg: AeBDieuG/WRMx9GqJIyxnsDubYPjnJ82mvOKfnCmhZiEir+5y2+CKXVkaSvTQlD7lbD
 +mD30E6sXgfCLY9MHiUaH24FbzKDgAFGCmEKyy8WdIwM0V6p77EoFNAEFN3nGcC4tzsNBNDRMLm
 Wyfy//RVExmXNTjvjJNPe6hctWEiOK30CuNQi0UkKrer1Wb13/rpIo8bwuqmx4RSY+MQIsiUgjH
 Fo7/XrBNhcW229t60NibVSMTyhYqpOaxvtNAxQG70YYHtm8EOY3M965tN1zdyqoNhzwYsOfm1JC
 q1UblHGhGi67dec9rAPwpX7WlPZERtfez5TaXxm7z8KGLa58RfjIZSvuBDcXWA3h19yeL8xER/l
 lRgJkPXM3RGynnlM+VebSUVZv+qoPLWAsyVX6lqYjNm34Tha+V8GQo9tIIlmEdeUiBr3C8ddK6z
 yn2Bs13EAljcVp8udZ44WOP+wBfDSrhhL72TuGHpGFEi9h8A==
X-Received: by 2002:a05:600c:a316:b0:489:1ba8:5bf0 with SMTP id
 5b1f17b1804b1-48a76f85a78mr4650245e9.21.1777314447810; 
 Mon, 27 Apr 2026 11:27:27 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:153b:d200:96aa:46be:4d7:72d2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773af5c5sm6046165e9.5.2026.04.27.11.27.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Apr 2026 11:27:27 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com, Prike.Liang@amd.com, sukhatri@amd.com,
 jesse.zhang@amd.com
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH 5/8] drm/amdgpu: fix userq hang detection and reset
Date: Mon, 27 Apr 2026 20:27:20 +0200
Message-ID: <20260427182723.1715-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260427182723.1715-1-christian.koenig@amd.com>
References: <20260427182723.1715-1-christian.koenig@amd.com>
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
Reply-To: christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Fix lock inversions pointed out by Prike and Sunil. The hang detection
timeout *CAN'T* grab locks under which we wait for fences, especially
not the userq_mutex lock.

Then instead of this completely broken handling with the
hang_detect_fence just cancel the work when fences are processed and
re-start if necessary.

Signed-off-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Sunil Khatri <sunil.khatri@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     | 65 ++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h     |  1 -
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.c   | 17 +++--
 .../gpu/drm/amd/amdgpu/amdgpu_userq_fence.h   |  2 +-
 4 files changed, 40 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index fb3c0425cf22..b2c64a05d03a 100644
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
index a2792f05b670..bf452c5aacbe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq_fence.c
@@ -135,7 +135,14 @@ amdgpu_userq_fence_put_fence_drv_array(struct amdgpu_userq_fence *userq_fence)
 	userq_fence->fence_drv_array_count = 0;
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
@@ -143,9 +150,6 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
 	unsigned long flags;
 	u64 rptr;
 
-	if (!fence_drv)
-		return;
-
 	spin_lock_irqsave(&fence_drv->fence_list_lock, flags);
 	rptr = amdgpu_userq_fence_read(fence_drv);
 
@@ -158,6 +162,9 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
 				&userq_fence->link);
 	spin_unlock_irqrestore(&fence_drv->fence_list_lock, flags);
 
+	if (list_empty(&to_be_signaled))
+		return -ENOENT;
+
 	list_for_each_entry_safe(userq_fence, tmp, &to_be_signaled, link) {
 		fence = &userq_fence->base;
 		list_del_init(&userq_fence->link);
@@ -169,6 +176,8 @@ void amdgpu_userq_fence_driver_process(struct amdgpu_userq_fence_driver *fence_d
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


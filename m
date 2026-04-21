Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B41F8FA71
	for <amd-gfx@archiver.kernel.org>; Tue, 21 Apr 2026 12:55:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5974810EC0B;
	Tue, 21 Apr 2026 12:55:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="T01NiCpq";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6C7710E897
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 12:55:23 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-4891c00e7aeso20420825e9.2
 for <amd-gfx@lists.freedesktop.org>; Tue, 21 Apr 2026 05:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776776122; x=1777380922; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gvRU1YtpM0U/4Uy1akYqEjawVY7lBN9+k1178qpudfg=;
 b=T01NiCpqszoMGsJSLAy0G4mSd5Kxus4rvsUlf7wIfidhzLDOIEYimFxfHS/6OctrdP
 NG6YFDCctIl0mq+dYyn9biCFb25L2mf43zU9o2yCA+3GjEM0oJAOWpHkAQVKs6ACDy2d
 oOc3xRZidapjmswJjijJH+oX02GDoYytU/NRSoZnoB1yxHwO6u2OS2HzYKWx+8ZxK0Hr
 M0KMlHeNhc9RiKd+cTL1sMHhgXj2gVr6aaAEo6/fYldVpt25OXfJKavBCbybquiYCyF4
 TsTdyi5gEBNLeD7fJmucgEmd1Mwy2Ij9NlW8TwGSTjLZBbDjIvxx/XLXshBuCLPkkmfW
 A7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776776122; x=1777380922;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gvRU1YtpM0U/4Uy1akYqEjawVY7lBN9+k1178qpudfg=;
 b=oXa1UW+P8GsCigImoaYg+DzeCxVzCyqb2YE3Fh9WAMET3GUG3ywsNRIFFfnc5hMANZ
 Eq2GMuvqdKCiHU0g06Dkf7tfi6Z+HZLrD71DwoAzAODThhllgaoblwbe+ljXbChGyv2d
 rpbf0OSDnRxKzuHpZYUywBzIw3VDT5V4PCWurAFaaEjEf8xx537lFDFF9aI5WxrXlAZn
 ZjsxX3s/LzqzRrw2m/Mh7L9E3LM6SXP919JgBuOAJC9oRWE8RgeydUlgSnk5CXhmdC5z
 UYhKm6tKXVhJwHTYLKYqzXF/y/Ip7o9z8HSIReEnMPMbgCh9vERvYUJsmQPY60OdK/2a
 3BFg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/VtGW2lWiiJa2s6/wxhSd73QuIcwTiHt4HLh/ZIh67fETO6UsrxuvkBmKJ6shkdhllXo0j9xMj@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzKVg3dnbzGfy7/C9Nj2VmIFbHue7wT1VZNc54ATO9k4H6aowbm
 sXhUyUYF+ZpREJQywHgL8lEXS+GSLqwZcmfq0awUhURhOejeOJaD9bum
X-Gm-Gg: AeBDieuYxoEJLgftbIv1uw34F2BdpmVYFYoWYgWtgT+1/AXkIx+JnY1rv6gqgGgsLoW
 1IiOU/b2aYZks+fsgfBUT53V7hmv76NV7aCn7kezKDO1QM2aNKK0HGnYRrxYGiwiKfU0YvmTEbW
 WfzjH4o7ia8ZHZf58wIbNmtAzwEwTu1jP2z1qJID87uIKL50LL4Fyvb+IHstbPB5d+G4O+NMIhc
 wi0XNXh52v/2Wr0au9SrUvPYjtcBTnR7fRtMdokbZ7AZyY0TBaLfaa6WjL6vskzjTnIUijq3m5i
 xt0lOuw2ASj8+Z0GBIxRrQUUvxucQ4QRSo/TKDZmMsYzecRgHAJya9qw1YmvtJXsmnUHdpUdvzh
 nEe/N76+6I5jm9gpwIG+YimJ4heE2WAfiWgjutPWHIFzxrhAShQPkECWlYdyLGC4t/SORe+ZY9x
 yxnH+2hOVeP63Cg5k4lhamU+3n+OMMvA8JPtvYnla0IqU9k+U=
X-Received: by 2002:a05:600c:3110:b0:487:243f:dc3e with SMTP id
 5b1f17b1804b1-488fb739cf6mr268236225e9.6.1776776121995; 
 Tue, 21 Apr 2026 05:55:21 -0700 (PDT)
Received: from able.fritz.box ([2a00:e180:15aa:5a00:935c:42ec:dfce:89a2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fb79ecb9sm154777915e9.8.2026.04.21.05.55.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 05:55:21 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: alexander.deucher@amd.com, Prike.Liang@amd.com, sukhatri@amd.com,
 amd-gfx@lists.freedesktop.org
Cc: christian.koenig@amd.com
Subject: [PATCH 05/11] drm/amdgpu: rework userq fence signal processing
Date: Tue, 21 Apr 2026 14:55:07 +0200
Message-ID: <20260421125513.4545-5-christian.koenig@amd.com>
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

Move more code into a common userq function.

Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 13 +++++++++++++
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h |  1 +
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c    | 10 +---------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c    | 10 +---------
 drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c    | 11 +----------
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c    | 11 +----------
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c    | 11 +----------
 7 files changed, 19 insertions(+), 48 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 174190a77005..8ce001481d42 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -205,6 +205,19 @@ void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue)
 		     msecs_to_jiffies(timeout_ms));
 }
 
+void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell)
+{
+	struct xarray *xa = &adev->userq_doorbell_xa;
+	struct amdgpu_usermode_queue *queue;
+	unsigned long flags;
+
+	xa_lock_irqsave(xa, flags);
+	queue = xa_load(xa, doorbell);
+	if (queue)
+		amdgpu_userq_fence_driver_process(queue->fence_drv);
+	xa_unlock_irqrestore(xa, flags);
+}
+
 static void amdgpu_userq_init_hang_detect_work(struct amdgpu_usermode_queue *queue)
 {
 	INIT_DELAYED_WORK(&queue->hang_detect_work, amdgpu_userq_hang_detect_work);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
index cb92789c1ed1..843ea8ecc5d7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.h
@@ -168,6 +168,7 @@ void amdgpu_userq_reset_work(struct work_struct *work);
 void amdgpu_userq_pre_reset(struct amdgpu_device *adev);
 int amdgpu_userq_post_reset(struct amdgpu_device *adev, bool vram_lost);
 void amdgpu_userq_start_hang_detect_work(struct amdgpu_usermode_queue *queue);
+void amdgpu_userq_process_fence_irq(struct amdgpu_device *adev, u32 doorbell);
 
 int amdgpu_userq_input_va_validate(struct amdgpu_device *adev,
 				   struct amdgpu_usermode_queue *queue,
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 837d98947958..1ffbb5450f3a 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -6528,15 +6528,7 @@ static int gfx_v11_0_eop_irq(struct amdgpu_device *adev,
 	DRM_DEBUG("IH: CP EOP\n");
 
 	if (adev->enable_mes && doorbell_offset) {
-		struct amdgpu_usermode_queue *queue;
-		struct xarray *xa = &adev->userq_doorbell_xa;
-		unsigned long flags;
-
-		xa_lock_irqsave(xa, flags);
-		queue = xa_load(xa, doorbell_offset);
-		if (queue)
-			amdgpu_userq_fence_driver_process(queue->fence_drv);
-		xa_unlock_irqrestore(xa, flags);
+		amdgpu_userq_process_fence_irq(adev, doorbell_offset);
 	} else {
 		me_id = (entry->ring_id & 0x0c) >> 2;
 		pipe_id = (entry->ring_id & 0x03) >> 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index 60f0c7d6a7a3..6baac533a2e6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -4859,15 +4859,7 @@ static int gfx_v12_0_eop_irq(struct amdgpu_device *adev,
 	DRM_DEBUG("IH: CP EOP\n");
 
 	if (adev->enable_mes && doorbell_offset) {
-		struct xarray *xa = &adev->userq_doorbell_xa;
-		struct amdgpu_usermode_queue *queue;
-		unsigned long flags;
-
-		xa_lock_irqsave(xa, flags);
-		queue = xa_load(xa, doorbell_offset);
-		if (queue)
-			amdgpu_userq_fence_driver_process(queue->fence_drv);
-		xa_unlock_irqrestore(xa, flags);
+		amdgpu_userq_process_fence_irq(adev, doorbell_offset);
 	} else {
 		me_id = (entry->ring_id & 0x0c) >> 2;
 		pipe_id = (entry->ring_id & 0x03) >> 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
index 948758b51b5c..ae65412109c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_1.c
@@ -3654,16 +3654,7 @@ static int gfx_v12_1_eop_irq(struct amdgpu_device *adev,
 	DRM_DEBUG("IH: CP EOP\n");
 
 	if (adev->enable_mes && doorbell_offset) {
-		struct xarray *xa = &adev->userq_doorbell_xa;
-		struct amdgpu_usermode_queue *queue;
-		unsigned long flags;
-
-		xa_lock_irqsave(xa, flags);
-		queue = xa_load(xa, doorbell_offset);
-		if (queue)
-			amdgpu_userq_fence_driver_process(queue->fence_drv);
-
-		xa_unlock_irqrestore(xa, flags);
+		amdgpu_userq_process_fence_irq(adev, doorbell_offset);
 	} else {
 		me_id = (entry->ring_id & 0x0c) >> 2;
 		pipe_id = (entry->ring_id & 0x03) >> 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index de329b76a00c..bf09ac841a68 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -1662,17 +1662,8 @@ static int sdma_v6_0_process_fence_irq(struct amdgpu_device *adev,
 	u32 doorbell_offset = entry->src_data[0];
 
 	if (adev->enable_mes && doorbell_offset) {
-		struct amdgpu_usermode_queue *queue;
-		struct xarray *xa = &adev->userq_doorbell_xa;
-		unsigned long flags;
-
 		doorbell_offset >>= SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
-
-		xa_lock_irqsave(xa, flags);
-		queue = xa_load(xa, doorbell_offset);
-		if (queue)
-			amdgpu_userq_fence_driver_process(queue->fence_drv);
-		xa_unlock_irqrestore(xa, flags);
+		amdgpu_userq_process_fence_irq(adev, doorbell_offset);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index 85d98a0e1bff..f154b68dda70 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -1594,17 +1594,8 @@ static int sdma_v7_0_process_fence_irq(struct amdgpu_device *adev,
 	u32 doorbell_offset = entry->src_data[0];
 
 	if (adev->enable_mes && doorbell_offset) {
-		struct xarray *xa = &adev->userq_doorbell_xa;
-		struct amdgpu_usermode_queue *queue;
-		unsigned long flags;
-
 		doorbell_offset >>= SDMA0_QUEUE0_DOORBELL_OFFSET__OFFSET__SHIFT;
-
-		xa_lock_irqsave(xa, flags);
-		queue = xa_load(xa, doorbell_offset);
-		if (queue)
-			amdgpu_userq_fence_driver_process(queue->fence_drv);
-		xa_unlock_irqrestore(xa, flags);
+		amdgpu_userq_process_fence_irq(adev, doorbell_offset);
 	}
 
 	return 0;
-- 
2.43.0


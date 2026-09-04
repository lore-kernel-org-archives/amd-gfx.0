Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29801C624DE
	for <amd-gfx@archiver.kernel.org>; Fri,  4 Sep 2026 07:29:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A4D110F8D0;
	Fri,  4 Sep 2026 07:29:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="evVBawbi";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C2EC10F8CF
 for <amd-gfx@lists.freedesktop.org>; Fri,  4 Sep 2026 07:29:12 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4998b5a63e2so7313235e9.1
 for <amd-gfx@lists.freedesktop.org>; Fri, 04 Sep 2026 00:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788506950; x=1789111750; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=yCMkALgEIQr+YmXq/AUq2WVdmaE1l9VYvzQpuTEc8W0=;
 b=evVBawbimGYVdiH2fsJj51OC+1ITdrA+W0GhYYDdrDNvHlP1i9yRc91jJcLNNiJTa3
 kq7iSOwFK6Ocm7fjtnqb6Z+NLnyC6S2NN5y+ylKRJHZQjQYIvpfV3iBx6TxkwJDObNfW
 Ia0pRHIH2t0Yfvpsfc2dFEqbkVddyYBI4P9D2f3JmG8cvPcb/m+gD2p0fW3nNgSPUBiN
 bUWme0AtHQvPJc02k9EFhD+/U9qK5dmeH6trWlJj+zVfEfaD9vKvg8os+oUoTFp5bzki
 kyWUB/a+IWPvlXqN7g8zjRSJJDWaGAZUxSwrNTPvCmZ0dJl88ZQmfUOvN7AOGNNJ1MzP
 eJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788506950; x=1789111750;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=yCMkALgEIQr+YmXq/AUq2WVdmaE1l9VYvzQpuTEc8W0=;
 b=S8EmPua741edGaL8V1zf2aFVAZw4pvLg37PIMb+cNHvRDNRzXN7FQORwhNba/LOMJ5
 /OtoHtLK8kunigZqi04tezrk9gkbZjCCh93bHzvbvbk5TZPf2wzvXR+nvzWVFoEJmHAc
 bP5Pkuc+MpAImerbVnxDnzSYUcNFLpzLDMElzOrhnduyOdOVUlJLtsmIeH2qfogK2u4t
 HQCIqSOnOX16THx8jfR+tjfAVGid0OUmjaf/O2rPfcXATEnUdhSkPLJVorheJwAubRsi
 Ub/S5oRRoTDR0xZmRUsdtf0Iq3nz86XBNb3RixKHkkOA3hAg0Nyv0wniR2e706NNgvi+
 aksg==
X-Gm-Message-State: AFuF++lQ5sU9U6o2adydChc9tRwLybY+v5Q7X0Zc0AeVGhqqElWCaWF0
 7f3ksv+hBA4lj2xDj+3kaJhU/l4M1b8fq4jBdNgPd9ghcP8Hvb/vbjpc8TtU80wLZhI=
X-Gm-Gg: AYBFou20R0EwNqKTJTk1v8oLzNQLH71SoLYFC7NAB7IPkW8mgcYBw89p1N3xVYJ3X9S
 tD/hIImFKr///Xrae9F5eJe2EW8G023lqMDRZ+2EMk1+bbTqBjVEKCvYTdoeBZ9NiBURMCjM4sj
 9q4o4QAWIJC/Av3838fYRX9lVKnN+0t64j1NcKZ+5W/ZSgpqReRNBRrEem9rv1WJ3WSyeBTYAPR
 dzNo7hIRc2/SRi814NI74PCsBV7psZlkh7II93j+1wpRdaGIsJc0t3VNmep0hLu0bWlw+LYe/mO
 uxVDIwgGhCcDncTOrgUQFqSqd7jYPDgMj8/WFgXD21L5BcBgD6O6oOrU6TU4P801g5pjFAmAWDE
 dvpQ2M5xJq9jxmepjsf4tT7SG7qNMoFr8UrWnb8rKU3exDq6Gf79coC17Nc+rBfOHdLxgKRP0Of
 VNR4W+djiqwwHKK30wKCKWDJCsOKq81mgvJSe48KmfpVz+Y0Ii6s21rf5L+LPNPgpvAhdsUmnPC
 LGdL+rQqpEqSKBhfBh4
X-Received: by 2002:a05:600c:548c:b0:49c:c96a:d36b with SMTP id
 5b1f17b1804b1-49cf8267dd3mr40452415e9.12.1788506950239; 
 Fri, 04 Sep 2026 00:29:10 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cf75ce49esm86698155e9.1.2026.09.04.00.29.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 00:29:09 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 7/8] drm/amdgpu/sdma: Always handle kernel queues in
 amdgpu_sdma_reset_engine()
Date: Fri,  4 Sep 2026 09:28:49 +0200
Message-ID: <20260904072850.321759-8-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260904072850.321759-1-timur.kristof@gmail.com>
References: <20260904072850.321759-1-timur.kristof@gmail.com>
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

Remove the caller_handles_kernel_queues argument from
the amdgpu_sdma_reset_engine() function and make it
always handle kernel queues.

Now the SDMA recovery sequence is more consistent
between callers for the KFD as follows.
Before recovery: first the KFD is suspended,
then the SDMA queue contents are backed up.
After recovery: first the SDMA queue contents
are restored, then the KFD is resumed.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      | 68 ++++++++++---------
 drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h      |  3 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |  2 +-
 .../drm/amd/amdkfd/kfd_device_queue_manager.c |  2 +-
 4 files changed, 38 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
index 9eebd8380834..07aac5b3ea92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
@@ -542,16 +542,14 @@ static int amdgpu_sdma_soft_reset(struct amdgpu_device *adev, u32 instance_id)
 }
 
 /**
- * amdgpu_sdma_reset_engine - Reset a specific SDMA engine
+ * amdgpu_sdma_reset_engine() - Reset a specific SDMA engine instance.
+ *
  * @adev: Pointer to the AMDGPU device
  * @instance_id: Logical ID of the SDMA engine instance to reset
- * @caller_handles_kernel_queues: Skip kernel queue processing. Caller
- * will handle it.
  *
  * Returns: 0 on success, or a negative error code on failure.
  */
-int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
-			     bool caller_handles_kernel_queues)
+int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id)
 {
 	struct amdgpu_sdma_instance *sdma_instance = &adev->sdma.instance[instance_id];
 	struct amdgpu_ring *gfx_ring = &sdma_instance->ring;
@@ -564,20 +562,23 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 
 	mutex_lock(&sdma_instance->engine_reset_mutex);
 
-	if (!caller_handles_kernel_queues) {
-		/* Stop the scheduler's work queue for the GFX and page rings if they are running.
-		 * This ensures that no new tasks are submitted to the queues while
-		 * the reset is in progress.
-		 */
+	/*
+	 * Stop the scheduler's work queue for the GFX and page rings if they are running.
+	 * This ensures that no new tasks are submitted to the queues while
+	 * the reset is in progress.
+	 */
+	if (amdgpu_ring_sched_ready(gfx_ring) && !drm_sched_is_stopped(&gfx_ring->sched))
 		drm_sched_wqueue_stop(&gfx_ring->sched);
-		gfx_fence = amdgpu_ring_find_guilty_fence(gfx_ring);
-		amdgpu_ring_reset_helper_begin(gfx_ring, gfx_fence);
 
-		if (adev->sdma.has_page_queue) {
+	gfx_fence = amdgpu_ring_find_guilty_fence(gfx_ring);
+	amdgpu_ring_reset_helper_begin(gfx_ring, gfx_fence);
+
+	if (adev->sdma.has_page_queue) {
+		if (amdgpu_ring_sched_ready(page_ring) && !drm_sched_is_stopped(&page_ring->sched))
 			drm_sched_wqueue_stop(&page_ring->sched);
-			page_fence = amdgpu_ring_find_guilty_fence(page_ring);
-			amdgpu_ring_reset_helper_begin(page_ring, page_fence);
-		}
+
+		page_fence = amdgpu_ring_find_guilty_fence(page_ring);
+		amdgpu_ring_reset_helper_begin(page_ring, page_fence);
 	}
 
 	if (sdma_instance->funcs->stop_kernel_queue) {
@@ -612,22 +613,25 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
 	}
 
 exit:
-	if (!caller_handles_kernel_queues) {
-		/* Restart the scheduler's work queue for the GFX and page rings
-		 * if they were stopped by this function. This allows new tasks
-		 * to be submitted to the queues after the reset is complete.
-		 */
-		if (!ret) {
-			ret = amdgpu_ring_reset_helper_end(gfx_ring, gfx_fence);
+	/* Restart the scheduler's work queue for the GFX and page rings
+	 * if they were stopped by this function. This allows new tasks
+	 * to be submitted to the queues after the reset is complete.
+	 */
+	if (!ret) {
+		ret = amdgpu_ring_reset_helper_end(gfx_ring, gfx_fence);
+		if (ret)
+			goto unlock;
+
+		if (amdgpu_ring_sched_ready(gfx_ring))
+			drm_sched_wqueue_start(&gfx_ring->sched);
+
+		if (adev->sdma.has_page_queue) {
+			ret = amdgpu_ring_reset_helper_end(page_ring, page_fence);
 			if (ret)
 				goto unlock;
-			drm_sched_wqueue_start(&gfx_ring->sched);
-			if (adev->sdma.has_page_queue) {
-				ret = amdgpu_ring_reset_helper_end(page_ring, page_fence);
-				if (ret)
-					goto unlock;
+
+			if (amdgpu_ring_sched_ready(page_ring))
 				drm_sched_wqueue_start(&page_ring->sched);
-			}
 		}
 	}
 unlock:
@@ -662,13 +666,11 @@ int amdgpu_sdma_reset_queue_legacy(struct amdgpu_ring *ring,
 		return -EINVAL;
 	}
 
-	amdgpu_ring_reset_helper_begin(ring, timedout_fence);
-
 	amdgpu_amdkfd_suspend(adev, true);
-	r = amdgpu_sdma_reset_engine(adev, ring->me, true);
+	r = amdgpu_sdma_reset_engine(adev, ring->me);
 	amdgpu_amdkfd_resume(adev, true);
 	if (r)
 		return r;
 
-	return amdgpu_ring_reset_helper_end(ring, timedout_fence);
+	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
index cb41453c1a19..5709d438e824 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -153,8 +153,7 @@ struct amdgpu_buffer_funcs {
 				 uint32_t byte_count);
 };
 
-int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
-			     bool caller_handles_kernel_queues);
+int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id);
 
 int amdgpu_sdma_reset_queue_legacy(struct amdgpu_ring *ring,
 				   unsigned int vmid,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 77f385b9ef53..796ea9f74763 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1583,7 +1583,7 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
 	int r;
 
 	amdgpu_amdkfd_suspend(adev, true);
-	r = amdgpu_sdma_reset_engine(adev, id, false);
+	r = amdgpu_sdma_reset_engine(adev, id);
 	amdgpu_amdkfd_resume(adev, true);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index a23384571193..f9fbc5628fb4 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2576,7 +2576,7 @@ static int reset_hung_queues_sdma(struct device_queue_manager *dqm)
 				continue;
 
 			/* Reset engine and check. */
-			if (amdgpu_sdma_reset_engine(dqm->dev->adev, i, false) ||
+			if (amdgpu_sdma_reset_engine(dqm->dev->adev, i) ||
 			    dqm->dev->kfd2kgd->hqd_sdma_get_doorbell(dqm->dev->adev, i, j) ||
 			    !set_sdma_queue_as_reset(dqm, doorbell_off)) {
 				r = -ENOTRECOVERABLE;
-- 
2.55.0


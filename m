Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7160C79FAA
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 18:11:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7384710ED12;
	Tue,  8 Sep 2026 18:11:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UJ0fcF30";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DC64510ED10
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 18:11:19 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49cd6185db7so8423595e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 08 Sep 2026 11:11:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788891078; x=1789495878; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OQ5WZehYPBDE1vtQEndvrO3X3LPAFLAoRwrmCXALfE0=;
 b=UJ0fcF30F5GjUSGFFuGxLoRz/khbAWLkKDv3I4E2i9YOV8alpYm9A8V7i/kJ9H83PK
 dPmtcDkdjjhrquP7UB8m5Oxv/AfYz3iEATy89UuydtzWVjGoskl9LjKM+uMoDOYuIXOo
 dtU2t712ZlqWneanBdKaJTPjK6+1rebJjJXBOP/0zTlWXtws65ITsUsTFfMuDJAyXSNC
 DvsfMy+8KzLpFyxfzAmHAWEyR0tlacNNqKJ7Fy5j0eBBOtool5QiCCBCxTAaHzrs9Tlh
 KzgEBV2M0pL2qdjMSHXttb/aDbIbvU0DiN7TY/uzEkGiervSiZ+yoUiPrbOQtKgCcMLD
 KMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788891078; x=1789495878;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OQ5WZehYPBDE1vtQEndvrO3X3LPAFLAoRwrmCXALfE0=;
 b=mhx5WzymceBCqX5tnAmAS5KFwWgdmK0elLqIY+RUyaihBGFQ81rw0XGXLjtG03dzmm
 Nc+uNtu2bgofGu0sR+PFlJq13UtMFg4QRrcO+b94D1LIWDQXVfLTyN2yj8w/QonEW9jw
 e/pjjmhp9MfegLtqI7e+4ttrL8UlI03qyf8DjYyoswLCK5fDNuiC7UY8mhP7mQf8C5Db
 cUukP7l9wlzTixP9G4zo1R/HKI+FMDL58N18Ez44ngH1YA6UyoqALXRVbfRezKXpluxp
 Wze/XhwE/h540sUNZh42FNuI1PmPT3T3S6A1KW3JS78QUP20MjUMUFrCKD3ro7gFHOXR
 FUpg==
X-Gm-Message-State: AFuF++myoF1yfwj0rnsvUScVDCXhPF7HPIUOlWyylV1HLDDQOUgg6pLI
 xb+tIL+chlDcXBWuk8Scpi3RBU5DlK4EKuBPrpC514aoaYGIVU6fPy2oAL1XIXM/
X-Gm-Gg: AYBFou0TCQah0xrl+5HMC3fR4lN+rY/CYNhNd5NUJGtbAuepJYuT3Ay5Uq3jLmcU7xG
 UGNBBIurI0u/OtNUi2oawoHAvQeEX95GnVQX/m6ns6vVycoFNotU1b+irbO75GwD9eVyCqqyb2e
 f/n6PKEX3+zIzYn2GuJyAQ/RL0/VWzc5MeqAZGXnN0BmPaC2QwB+LH/UKpEu9NIEMT4OIAsFfST
 s1rky7Wv8HHU5/7/LxVv+lnjgN+AwGuyaqFVtDuvqeNO2rDjVmto4BwG+OJ+SMeke4nv8+fExy3
 ceYRrkpVVbRJccKUkOvnY97Tdh1cqwf0mPuekjGgpu2KQw0hqfe0JTsPXO1yobIp/2dvMRnj9UE
 Uw6AdnxQOV5u2v/hWoqkmKH5PQCA8I+pLmsVoqPQ0Wq5vgg/8SK1955d/qDa0V88x24PI9vb6J6
 mz7b6z2HoQ1YNMkiPuYPViNZQlwVmaRUKCn/RxqVaOT/QlIFhqjmhZu6HAMgNjralFenhG1BPIG
 9fbIEmx3qBjx7CKrKay
X-Received: by 2002:a05:600c:6216:b0:49c:799a:177b with SMTP id
 5b1f17b1804b1-49d1754394emr104504335e9.2.1788891078222; 
 Tue, 08 Sep 2026 11:11:18 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d1fb1e4e4sm5190125e9.2.2026.09.08.11.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 11:11:17 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 8/9] drm/amdgpu/sdma: Always handle kernel queues in
 amdgpu_sdma_reset_engine()
Date: Tue,  8 Sep 2026 20:10:51 +0200
Message-ID: <20260908181052.381126-9-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260908181052.381126-1-timur.kristof@gmail.com>
References: <20260908181052.381126-1-timur.kristof@gmail.com>
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
index 71a7a70a80c4..0286e3dd958e 100644
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
@@ -605,22 +606,25 @@ int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
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
@@ -655,13 +659,11 @@ int amdgpu_sdma_reset_queue_legacy(struct amdgpu_ring *ring,
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
index fb0316b28f9d..8d0fcc7f6cac 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.h
@@ -154,8 +154,7 @@ struct amdgpu_buffer_funcs {
 				 uint32_t byte_count);
 };
 
-int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id,
-			     bool caller_handles_kernel_queues);
+int amdgpu_sdma_reset_engine(struct amdgpu_device *adev, uint32_t instance_id);
 
 int amdgpu_sdma_reset_queue_legacy(struct amdgpu_ring *ring,
 				   unsigned int vmid,
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
index 0ca774959401..4a1e941cfe2b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c
@@ -1588,7 +1588,7 @@ static int sdma_v4_4_2_reset_queue(struct amdgpu_ring *ring,
 	int r;
 
 	amdgpu_amdkfd_suspend(adev, true);
-	r = amdgpu_sdma_reset_engine(adev, id, false);
+	r = amdgpu_sdma_reset_engine(adev, id);
 	amdgpu_amdkfd_resume(adev, true);
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
index 3ec6a73af22e..f02fdb1b7899 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
@@ -2661,7 +2661,7 @@ static int reset_hung_queues_sdma(struct device_queue_manager *dqm)
 				continue;
 
 			/* Reset engine and check. */
-			if (amdgpu_sdma_reset_engine(dqm->dev->adev, i, false) ||
+			if (amdgpu_sdma_reset_engine(dqm->dev->adev, i) ||
 			    dqm->dev->kfd2kgd->hqd_sdma_get_doorbell(dqm->dev->adev, i, j) ||
 			    !set_sdma_queue_as_reset(dqm, doorbell_off)) {
 				r = -ENOTRECOVERABLE;
-- 
2.55.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A4CDC61DD6
	for <amd-gfx@archiver.kernel.org>; Tue,  1 Sep 2026 08:41:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A38510E3D2;
	Tue,  1 Sep 2026 08:41:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Ec19a1it";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A9E910E3D2
 for <amd-gfx@lists.freedesktop.org>; Tue,  1 Sep 2026 08:41:38 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-49b8ce9b733so30891545e9.1
 for <amd-gfx@lists.freedesktop.org>; Tue, 01 Sep 2026 01:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788252097; x=1788856897; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=qfOU2pis4Pi4J7FeeYaR/ujABFNIc6LYXS5sOrP2kSA=;
 b=Ec19a1it5KRWxZYAwf5pnTha6ASMPRTmEyWiDHNZ6YhRWxO22BSz8XlfLZ0mlfuQ+G
 L3KTFr4JJkiPhrWyp1v5Tr7jAtyyY4IPYFodBI1cCvw+GFHLbtJoNQM2vp29+MXfF3Wj
 TlVmhukZ9nVx1zD/h8ESHciNhRTIUeE9c4P5sP2wyERDoLPSVYJB6OqjNv5I3X3Te+xH
 s2yi1Q8jh/UIfqmMAN70VxaL4UQe3aU+XfAP9P48A0QmvvI8swkcmEF7g8uRI4X6XfVo
 4dHJMEUo8MMdGzn1fcLmzxvJ+bJaeY5WvnwDf1Bga9Xt8iXFsVga4ybjPaXeZpGMB6Vq
 qSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788252097; x=1788856897;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qfOU2pis4Pi4J7FeeYaR/ujABFNIc6LYXS5sOrP2kSA=;
 b=TJelWAexcDkhWY1OJ4qATjxMJ9n4oui5ppqn6XoELnSRrZCPdQHVXYiPni9zzeoqlu
 8+65JYl5rk8lVZ5yeTb+3gRMTDf4BJK9+Ljf+5GX0RLPvdX8yswvLw00YfVegJFAKHxw
 XK/awMlAVQh0kTfPy3f+gmtw6wx4OpvtAUTb4gjnqndm6uOMM0THOTuI4WNelkTZXU9v
 SM5JRmF3y5j0SXU5zObU2Lm11YxdFCSrTT0hXYseWwpmcg6zSYwtjbkibujSxbflP9yL
 whLbHBsXD1/mNMB68CnC6+YdWCQKHcbv0A+pDWdXgBwrZQkXHlqO6g0xqV2EOD6WUzGT
 Bfyg==
X-Gm-Message-State: AFuF++k/s8HmRkA/zETWRgZ+8YDzC+nVIxZrBmmCvOtLBjEtR875UvJ4
 1gPsZO2nzy7zz0373D1F2FngdkNDhSQkiZ/bfk2TsxYqV3IZEj0czrTsvuJGOadd5xc=
X-Gm-Gg: AR+sD13Eoj+E0e91MV2rtnnEd6LNln5/4hoodrphOwO+8pUV3HRkQXHbuzX3wIQLKyl
 UtFuadZLd0jVLfwyypQmC8kykbcE2tXybbz4Q+IE4yhJbSAQ2yivJ5JOXfsBRbvKTMkckmgL9Ik
 tw/84WVkCrQCvCuaFi8ESW2I8ZiNziKyOoKeAMkw48NFxdAtG/sKGFqDOdGXGKqyiZ47ssG1fYg
 gAeJ2gC4DJYQivUiYixZQqqT2cvs3yrEKT1qGCueo1Mx1N2Zol3kLN0AxQ84SYVU0KUHcPOSUyA
 Ja+S6lQNR1tC8WvgDXBQwZe1W4p4NUtFwBQGr7iFHkEyArvzBr6wUeLa4iVUEaGzb4U6+sJ/1pj
 g0spAjGxYbxJ0xfYBBuErrs/a+IF/Zzxv0lRjmeWTQcF1o+SG7yHVYjZ/JOVR+4RUcJYuwFOPTX
 2fk6SYoDOS4jh2roozjpJjY2I+cZu1Ku/Ltmhyucfa+hCesTKELRGU/5nHR890ONx9SUsNIpG89
 OpUYcHZQmIYFYwR8QTm5rY=
X-Received: by 2002:a05:600c:1d0c:b0:499:484a:81d0 with SMTP id
 5b1f17b1804b1-49b91c3e67fmr461240945e9.9.1788252096905; 
 Tue, 01 Sep 2026 01:41:36 -0700 (PDT)
Received: from Timur-Max (athedsl-4457084.home.otenet.gr. [79.129.242.108])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cdce08b8esm47139235e9.3.2026.09.01.01.41.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 01:41:36 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alexander.Deucher@amd.com,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Natalie Vock <natalie.vock@gmx.de>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Felix Kuehling <Felix.Kuehling@amd.com>, Lijo Lazar <lijo.lazar@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 7/8] drm/amdgpu/sdma: Always handle kernel queues in
 amdgpu_sdma_reset_engine()
Date: Tue,  1 Sep 2026 10:41:14 +0200
Message-ID: <20260901084115.262457-8-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901084115.262457-1-timur.kristof@gmail.com>
References: <20260901084115.262457-1-timur.kristof@gmail.com>
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
index 9eebd8380834..e586df5f97bc 100644
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
+		if (amdgpu_ring_sched_ready(gfx_ring) && !drm_sched_is_stopped(&gfx_ring->sched))
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


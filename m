Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53001C43458
	for <amd-gfx@archiver.kernel.org>; Mon, 13 Jul 2026 12:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E22DF10E601;
	Mon, 13 Jul 2026 12:58:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cDpbQYlX";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CC5110E5FC
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 12:58:47 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-47df43bfb07so641352f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 13 Jul 2026 05:58:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783947525; x=1784552325; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=4hXu2Mw5J6id5mSDe82fAv6xb216F4fxNl2soSNjZOc=;
 b=cDpbQYlXnoOQAT8TnnBKRtH2xAj/LuFKobp83/Bro0TB0/FImEyMxf4II09iKZ8zc9
 zhnrrS8RM2AY5fcjldmpzAZap6mLtKg4CrGOBH6QWcTeDh5Yo66Y8hEccRshxkbQDUoM
 zOGzV4obAzFMAHNJNOZ/AxnKvQjbgLuMKnRkUX2w6omIiIhHIBq8SdvVjbIOOsf5dlb+
 Zv2OhuKbldqA5JiXET62Uumb/EDwjVI9litUe30z7cB6gE6lSG92XGjmy+ZkRt/sphUk
 wOYxhtUtJK7iNfnDrlaoKnp3SgHylyF3o7kE2B9xVBJLdAcuXRWOdqJwlkgN6atMRqIb
 kFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783947525; x=1784552325;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=4hXu2Mw5J6id5mSDe82fAv6xb216F4fxNl2soSNjZOc=;
 b=qgh3mivo+ghUluRZWBET5Kq/TjCFFbrun4CpA3xQbgK4V1Y2zRTFrBgKoe2soAwZQp
 kqhV5BX7NeIUbqo9RQa80OMeFnCMF/u9SxyqPQQTqNX0QHuazEPKqaAIIg7MyyF0xI+F
 xzMDEQeOYmZ6Gko0N+63VKSzciWqXo/YTfz2H7Sa2w7xhGV9WuXZJxUntaTrISurspMC
 EThkUo2BmOkRK0zkXcx74f5Uz98xBTeD4RehuD+um/fXSQffxPGT4b36g48HrGf1TgK6
 X23UvK/y09EXN7fjvSj9UTNZVCdaKJZkILF57JjtPVqM9Xu8BER0PeA0RnJQdRe/xVop
 RJbg==
X-Gm-Message-State: AOJu0YxziEmZ30wygoAu4B+DE59pCbpZ6FKyd6usWnxsXSkTAQWsBNmS
 tyPqqpPgAw4xSxraR0dS96Iq5CMVc8cLPrZhqiohRGfFzpsbyr0vd02sUfDbFQ==
X-Gm-Gg: AfdE7cmUtSg9BHm317Bk50p3PRG3eibWA7ZW96u8bAU1xzShoOtnlot7Y66azdwCF4t
 kILke1UufXXM94ltBz5zcntlrs3B45+Npi4+xRXe+Rgc/LFgUrGIHYfK5EuVfVDc64vc1tu0hdX
 pJkHNGbIMPQnLC8FsHdTfB6kAwbkRgjebH9rheisHokIpl5AAd0bxX9sndgZJzcvwGKuag7sVad
 yzIQ/SjNloOe3eTxAL5rqmgoVXdvK1CzyY5UNInfTQYRBFrr4KwubT7xTlfxslwjt/ZzFMCeBOK
 kaM9OxsfiMwe8GEJrWpyheqSbP5ODV5W+qBbXphW1DhMSpmJTBA6fvsQyj3kDUH5I7SIPCohpeZ
 XpqOmvi3LwNSfgXaBZaFXVF6cQDln0QpjIGi+rn3cZ3PviWuNTwvFNxM/AkkwsVxR02qNS2M1ow
 aIgTZL+bLewMbBDTsvTrnikvdrJTELuwa4hkmlkcVsbYLwOkjp+odf6g==
X-Received: by 2002:a05:6000:2887:b0:47d:edab:1b4e with SMTP id
 ffacd0b85a97d-47f2dcb3a0amr9534582f8f.8.1783947525381; 
 Mon, 13 Jul 2026 05:58:45 -0700 (PDT)
Received: from Timur-Hyperion.home (54001386.dsl.pool.telekom.hu.
 [84.0.19.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d6e4csm80456918f8f.10.2026.07.13.05.58.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:58:44 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Tvrtko Ursulin <tursulin@ursulin.net>,
 pierre-eric.pelloux-prayer@amd.com, Natalie Vock <natalie.vock@gmx.de>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 2/9] drm/amdgpu/gfx7: Refactor MQD initialization and
 finalization
Date: Mon, 13 Jul 2026 14:58:31 +0200
Message-ID: <20260713125838.30607-3-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713125838.30607-1-timur.kristof@gmail.com>
References: <20260713125838.30607-1-timur.kristof@gmail.com>
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

Call amdgpu_gfx_mqd_sw_init()/_fini() on GFX7 to initialize and
finalize the MQD, just like GFX8 and newer; instead of doing
an ad-hoc BO allocation. This introduces the possibility of
doing an MQD backup instead of trying to reinitialize the
MQD every time.

This solves an issue with GFX IP block soft reset where
all compute rings would hang after the reset.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c | 106 +++++++++++++-------------
 1 file changed, 51 insertions(+), 55 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 65b8497ad5f0..9c4b3ac27e1f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2698,25 +2698,6 @@ static int gfx_v7_0_cp_compute_load_microcode(struct amdgpu_device *adev)
 	return 0;
 }
 
-/**
- * gfx_v7_0_cp_compute_fini - stop the compute queues
- *
- * @adev: amdgpu_device pointer
- *
- * Stop the compute queues and tear down the driver queue
- * info.
- */
-static void gfx_v7_0_cp_compute_fini(struct amdgpu_device *adev)
-{
-	int i;
-
-	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
-		struct amdgpu_ring *ring = &adev->gfx.compute_ring[i];
-
-		amdgpu_bo_free_kernel(&ring->mqd_obj, NULL, NULL);
-	}
-}
-
 static void gfx_v7_0_mec_fini(struct amdgpu_device *adev)
 {
 	amdgpu_bo_free_kernel(&adev->gfx.mec.hpd_eop_obj, NULL, NULL);
@@ -2788,28 +2769,29 @@ static void gfx_v7_0_compute_pipe_init(struct amdgpu_device *adev,
 	mutex_unlock(&adev->srbm_mutex);
 }
 
-static int gfx_v7_0_mqd_deactivate(struct amdgpu_device *adev)
+static int gfx_v7_0_mqd_deactivate(struct amdgpu_device *adev, u32 req)
 {
-	int i;
+	int i, r = 0;
 
 	/* disable the queue if it's active */
-	if (RREG32(mmCP_HQD_ACTIVE) & 1) {
-		WREG32(mmCP_HQD_DEQUEUE_REQUEST, 1);
+	if (RREG32(mmCP_HQD_ACTIVE) & CP_HQD_ACTIVE__ACTIVE_MASK) {
+		WREG32_FIELD(CP_HQD_DEQUEUE_REQUEST, DEQUEUE_REQ, req);
 		for (i = 0; i < adev->usec_timeout; i++) {
-			if (!(RREG32(mmCP_HQD_ACTIVE) & 1))
+			if (!(RREG32(mmCP_HQD_ACTIVE) & CP_HQD_ACTIVE__ACTIVE_MASK))
 				break;
 			udelay(1);
 		}
 
 		if (i == adev->usec_timeout)
-			return -ETIMEDOUT;
+			r = -ETIMEDOUT;
 
-		WREG32(mmCP_HQD_DEQUEUE_REQUEST, 0);
-		WREG32(mmCP_HQD_PQ_RPTR, 0);
-		WREG32(mmCP_HQD_PQ_WPTR, 0);
 	}
 
-	return 0;
+	WREG32(mmCP_HQD_DEQUEUE_REQUEST, 0);
+	WREG32(mmCP_HQD_PQ_RPTR, 0);
+	WREG32(mmCP_HQD_PQ_WPTR, 0);
+
+	return r;
 }
 
 static void gfx_v7_0_mqd_init(struct amdgpu_device *adev,
@@ -2964,31 +2946,42 @@ static int gfx_v7_0_mqd_commit(struct amdgpu_device *adev, struct cik_mqd *mqd)
 
 static int gfx_v7_0_compute_queue_init(struct amdgpu_device *adev, int ring_id)
 {
-	int r;
-	u64 mqd_gpu_addr;
-	struct cik_mqd *mqd;
 	struct amdgpu_ring *ring = &adev->gfx.compute_ring[ring_id];
-
-	r = amdgpu_bo_create_reserved(adev, sizeof(struct cik_mqd), PAGE_SIZE,
-				      AMDGPU_GEM_DOMAIN_GTT, &ring->mqd_obj,
-				      &mqd_gpu_addr, (void **)&mqd);
-	if (r) {
-		dev_warn(adev->dev, "(%d) create MQD bo failed\n", r);
-		return r;
+	struct cik_mqd *mqd = ring->mqd_ptr;
+	int mqd_idx = ring - &adev->gfx.compute_ring[0];
+
+	if (!amdgpu_in_reset(adev) && !adev->in_suspend) {
+		memset((void *)mqd, 0, ring->mqd_size);
+		mutex_lock(&adev->srbm_mutex);
+		cik_srbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+		gfx_v7_0_mqd_init(adev, mqd, ring->mqd_gpu_addr, ring);
+		gfx_v7_0_mqd_deactivate(adev, 1);
+		gfx_v7_0_mqd_commit(adev, mqd);
+		cik_srbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+
+		if (adev->gfx.mec.mqd_backup[mqd_idx])
+			memcpy(adev->gfx.mec.mqd_backup[mqd_idx], mqd, ring->mqd_size);
+	} else {
+		/* restore MQD to a clean status */
+		if (adev->gfx.mec.mqd_backup[mqd_idx])
+			memcpy(mqd, adev->gfx.mec.mqd_backup[mqd_idx], ring->mqd_size);
+
+		/* Re-commit the restored backup */
+		mutex_lock(&adev->srbm_mutex);
+		cik_srbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
+		gfx_v7_0_mqd_deactivate(adev, 2);
+		gfx_v7_0_mqd_commit(adev, mqd);
+		cik_srbm_select(adev, 0, 0, 0, 0);
+		mutex_unlock(&adev->srbm_mutex);
+
+		/* reset ring buffer */
+		ring->wptr = 0;
+		atomic64_set((atomic64_t *)ring->wptr_cpu_addr, 0);
+		atomic64_set((atomic64_t *)ring->rptr_cpu_addr, 0);
+		amdgpu_ring_clear_ring(ring);
 	}
 
-	mutex_lock(&adev->srbm_mutex);
-	cik_srbm_select(adev, ring->me, ring->pipe, ring->queue, 0);
-
-	gfx_v7_0_mqd_init(adev, mqd, mqd_gpu_addr, ring);
-	gfx_v7_0_mqd_deactivate(adev);
-	gfx_v7_0_mqd_commit(adev, mqd);
-
-	cik_srbm_select(adev, 0, 0, 0, 0);
-	mutex_unlock(&adev->srbm_mutex);
-
-	amdgpu_bo_kunmap(ring->mqd_obj);
-	amdgpu_bo_unreserve(ring->mqd_obj);
 	return 0;
 }
 
@@ -3020,10 +3013,8 @@ static int gfx_v7_0_cp_compute_resume(struct amdgpu_device *adev)
 	/* init the queues */
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		r = gfx_v7_0_compute_queue_init(adev, i);
-		if (r) {
-			gfx_v7_0_cp_compute_fini(adev);
+		if (r)
 			return r;
-		}
 	}
 
 	gfx_v7_0_cp_compute_enable(adev, true);
@@ -4430,6 +4421,11 @@ static int gfx_v7_0_sw_init(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
+	/* create MQD for all compute queues */
+	r = amdgpu_gfx_mqd_sw_init(adev, sizeof(struct cik_mqd), 0);
+	if (r)
+		return r;
+
 	adev->gfx.ce_ram_size = 0x8000;
 
 	gfx_v7_0_gpu_early_init(adev);
@@ -4452,7 +4448,7 @@ static int gfx_v7_0_sw_fini(struct amdgpu_ip_block *ip_block)
 	for (i = 0; i < adev->gfx.num_compute_rings; i++)
 		amdgpu_ring_fini(&adev->gfx.compute_ring[i]);
 
-	gfx_v7_0_cp_compute_fini(adev);
+	amdgpu_gfx_mqd_sw_fini(adev, 0);
 	amdgpu_gfx_rlc_fini(adev);
 	gfx_v7_0_mec_fini(adev);
 	amdgpu_bo_free_kernel(&adev->gfx.rlc.clear_state_obj,
-- 
2.55.0


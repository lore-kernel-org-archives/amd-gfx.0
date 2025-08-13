Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98CB6CA0EC4
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 00:02:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EA2410E667;
	Wed, 13 Aug 2025 00:02:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X/Z+qq/Y";
	dkim-atps=neutral
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2962010E4A2
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 00:02:06 +0000 (UTC)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-709e74e695aso2720346d6.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 17:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755043325; x=1755648125; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cQ2pAQCIsRR1pdzDbNq7tfZRH75WKE44eYbgN04YS6s=;
 b=X/Z+qq/YEO4VRM0d9/KJ5rwWeo+G1YSoYkWamvGRIZ3agQ3gJTM8+FPwkvL7NuTY/p
 sv532AbiFcgFI5WM8D6e/+oHXGvOZTG2hZaiMHzT5VqlH6EVjGWUGyqK8D9oYPriDsCm
 pAZSd56xQzRyaO3DQPt9LUW+o7JasG+6Ac9ytAycr8n7SHRbJs43E9vJsFIS1rmgjXRt
 0M8gbANDuIadgHXyTwqhljh77igkrLALP2zVZ8mdQkJMdWq0FWbwE/tETvC3UpLA+rOy
 kWPeN1a5fLXW8LO5K8xg8yCOn/SoftLaEn2c1ZyUVRUQTTDzhYoLih1Uq3znblGLPJ03
 4jtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755043325; x=1755648125;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cQ2pAQCIsRR1pdzDbNq7tfZRH75WKE44eYbgN04YS6s=;
 b=wwjArOsnjfg68X8TD/I1yaavuJ5ldnuxHthQFEcp5guFxR5/o5zEnIW76oOq7/v/9s
 SiTpZMQxSKRy0wVQq76FVRnevHGHb3wOql4oHYKqoJIBTyxZ7oeqzavBgyRsmG5U1NRi
 ZaWGW8xLD1/4HQup48Aq9Rwl8Li7Hv5qvhV/IEuHKHDbsxKmNoJl9AHF/YlXsdfqBXa3
 037KhuJNv7hN9BjBpzWpSavhT2IYK7Ag+mIk1VlaYtOoitNCBTmn43vCmmx/tNawOwko
 GJu11LmFLUndJSmCnDdh1JNkqU1QxpbUo0AHuYM5iexaJ8DMCasXJ7FAdboqtHMghbkE
 B5Lw==
X-Gm-Message-State: AOJu0YwWzbNC+eHJYHHaZDq5jdA80I7rjgsU6O2jvXCOPFpBm/zupHMT
 O10WtOhCGp8G9sS+zrzYQjoJpnY9aijGNqGX3oq6H11ej6zweBdz50ZNtt1UV2Vn
X-Gm-Gg: ASbGnculKbYrOr7NaLKFRoT7LvfbaMQw0zRMEc6Ji85FpZHGDiHjr8BKdpVxc1ddTIX
 rDeP4dcoBiqO6da1ogHICgjRcDY+CKb8rqJhEkEK+rjmfqCTYDsvtGFvy/v2IgyH4oaRV9u6LHG
 rewN8f50VSXvZ2SkO0tFdFlBVbsdjX4HrAx/NnCOCVI5uRMQkj768k0THg0/wslgH0m+XuO+Euj
 oAS1VWNzE6DISlvDOwxJhSpzF3LPHK8ZPQbPc6oZtcTxrpWK9hB7fdZiY9syogDmvN8VFSXtyLp
 hRr8hJv9GSP4TYfOQ4wiVkvlO35oHgT6+V7vuIUodgnqOCQIuQpDeCGzq8ty2kSq/c4+SoJOD/5
 vlMdwF8hrT//PeAn0TzgIrLYbNfo=
X-Google-Smtp-Source: AGHT+IGDXHuHOkO/d5Fva5BX617jYwrA4IDdqQOR509RSLK2mqhibUg5ECXrP/ZFDsQoiU7nIZrp0Q==
X-Received: by 2002:ad4:5f8a:0:b0:707:4a94:2203 with SMTP id
 6a1803df08f44-709eb24c737mr7380736d6.25.1755043324514; 
 Tue, 12 Aug 2025 17:02:04 -0700 (PDT)
Received: from Xander ([104.251.39.208]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077ce3a099sm185937416d6.81.2025.08.12.17.02.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 17:02:03 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
Subject: [PATCH 4/4] drm/radeon: switch from ring->idx to ring->name for
 printouts
Date: Tue, 12 Aug 2025 20:01:41 -0400
Message-ID: <20250813000141.105508-5-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250813000141.105508-1-alexandre.f.demers@gmail.com>
References: <20250813000141.105508-1-alexandre.f.demers@gmail.com>
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

Replace rings' index value for rings' name.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/radeon/cik.c          |  6 +++---
 drivers/gpu/drm/radeon/cik_sdma.c     |  6 +++---
 drivers/gpu/drm/radeon/r600.c         |  8 ++++----
 drivers/gpu/drm/radeon/r600_dma.c     |  8 ++++----
 drivers/gpu/drm/radeon/radeon_fence.c |  6 ++++--
 drivers/gpu/drm/radeon/radeon_ring.c  |  4 ++--
 drivers/gpu/drm/radeon/radeon_vce.c   | 13 +++++++------
 drivers/gpu/drm/radeon/uvd_v1_0.c     | 14 +++++++-------
 8 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 6d6a6abd57fb..8065039900a4 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -3473,10 +3473,10 @@ int cik_ring_test(struct radeon_device *rdev, struct radeon_ring *ring)
 		udelay(1);
 	}
 	if (i < rdev->usec_timeout) {
-		DRM_INFO("ring test on %d succeeded in %d usecs\n", ring->idx, i);
+		DRM_INFO("ring test on %s succeeded in %d usecs\n", ring->name, i);
 	} else {
-		DRM_ERROR("radeon: ring %d test failed (scratch(0x%04X)=0x%08X)\n",
-			  ring->idx, scratch, tmp);
+		DRM_ERROR("radeon: ring %s test failed (scratch(0x%04X)=0x%08X)\n",
+			  ring->name, scratch, tmp);
 		r = -EINVAL;
 	}
 	radeon_scratch_free(rdev, scratch);
diff --git a/drivers/gpu/drm/radeon/cik_sdma.c b/drivers/gpu/drm/radeon/cik_sdma.c
index 919b14845c3c..54c67c100fe0 100644
--- a/drivers/gpu/drm/radeon/cik_sdma.c
+++ b/drivers/gpu/drm/radeon/cik_sdma.c
@@ -680,10 +680,10 @@ int cik_sdma_ring_test(struct radeon_device *rdev,
 	}
 
 	if (i < rdev->usec_timeout) {
-		DRM_INFO("ring test on %d succeeded in %d usecs\n", ring->idx, i);
+		DRM_INFO("ring test on %s succeeded in %d usecs\n", ring->name, i);
 	} else {
-		DRM_ERROR("radeon: ring %d test failed (0x%08X)\n",
-			  ring->idx, tmp);
+		DRM_ERROR("radeon: ring %s test failed (0x%08X)\n",
+			  ring->name, tmp);
 		r = -EINVAL;
 	}
 	return r;
diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
index 8b62f7faa5b9..de98e4613114 100644
--- a/drivers/gpu/drm/radeon/r600.c
+++ b/drivers/gpu/drm/radeon/r600.c
@@ -2835,7 +2835,7 @@ int r600_ring_test(struct radeon_device *rdev, struct radeon_ring *ring)
 	WREG32(scratch, 0xCAFEDEAD);
 	r = radeon_ring_lock(rdev, ring, 3);
 	if (r) {
-		DRM_ERROR("radeon: cp failed to lock ring %d (%d).\n", ring->idx, r);
+		DRM_ERROR("radeon: cp failed to lock ring %s (%d).\n", ring->name, r);
 		radeon_scratch_free(rdev, scratch);
 		return r;
 	}
@@ -2850,10 +2850,10 @@ int r600_ring_test(struct radeon_device *rdev, struct radeon_ring *ring)
 		udelay(1);
 	}
 	if (i < rdev->usec_timeout) {
-		DRM_INFO("ring test on %d succeeded in %d usecs\n", ring->idx, i);
+		DRM_INFO("ring test on %s succeeded in %d usecs\n", ring->name, i);
 	} else {
-		DRM_ERROR("radeon: ring %d test failed (scratch(0x%04X)=0x%08X)\n",
-			  ring->idx, scratch, tmp);
+		DRM_ERROR("radeon: ring %s test failed (scratch(0x%04X)=0x%08X)\n",
+			  ring->name, scratch, tmp);
 		r = -EINVAL;
 	}
 	radeon_scratch_free(rdev, scratch);
diff --git a/drivers/gpu/drm/radeon/r600_dma.c b/drivers/gpu/drm/radeon/r600_dma.c
index 89ca2738c5d4..d69a6edce9ac 100644
--- a/drivers/gpu/drm/radeon/r600_dma.c
+++ b/drivers/gpu/drm/radeon/r600_dma.c
@@ -247,7 +247,7 @@ int r600_dma_ring_test(struct radeon_device *rdev,
 
 	r = radeon_ring_lock(rdev, ring, 4);
 	if (r) {
-		DRM_ERROR("radeon: dma failed to lock ring %d (%d).\n", ring->idx, r);
+		DRM_ERROR("radeon: dma failed to lock ring %s (%d).\n", ring->name, r);
 		return r;
 	}
 	radeon_ring_write(ring, DMA_PACKET(DMA_PACKET_WRITE, 0, 0, 1));
@@ -264,10 +264,10 @@ int r600_dma_ring_test(struct radeon_device *rdev,
 	}
 
 	if (i < rdev->usec_timeout) {
-		DRM_INFO("ring test on %d succeeded in %d usecs\n", ring->idx, i);
+		DRM_INFO("ring test on %s succeeded in %d usecs\n", ring->name, i);
 	} else {
-		DRM_ERROR("radeon: ring %d test failed (0x%08X)\n",
-			  ring->idx, tmp);
+		DRM_ERROR("radeon: ring %s test failed (0x%08X)\n",
+			  ring->name, tmp);
 		r = -EINVAL;
 	}
 	return r;
diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon/radeon_fence.c
index 1be8364b2a97..b873b995b0ff 100644
--- a/drivers/gpu/drm/radeon/radeon_fence.c
+++ b/drivers/gpu/drm/radeon/radeon_fence.c
@@ -809,6 +809,8 @@ int radeon_fence_driver_start_ring(struct radeon_device *rdev, int ring_idx)
 {
 	uint64_t index;
 	int r;
+	struct radeon_ring *ring = &rdev->ring[ring_idx];
+
 	radeon_scratch_free(rdev, rdev->fence_drv[ring_idx].scratch_reg);
 	if (rdev->wb.use_event || !radeon_ring_supports_scratch_reg(rdev, ring)) {
 		rdev->fence_drv[ring_idx].scratch_reg = 0;
@@ -840,8 +842,8 @@ int radeon_fence_driver_start_ring(struct radeon_device *rdev, int ring_idx)
 	radeon_fence_write(rdev, atomic64_read(&rdev->fence_drv[ring_idx].last_seq), ring_idx);
 	rdev->fence_drv[ring_idx].initialized = true;
 
-	dev_info(rdev->dev, "fence driver on ring %d uses gpu addr 0x%016llx\n",
-		 ring_idx, rdev->fence_drv[ring_idx].gpu_addr);
+	dev_info(rdev->dev, "fence driver on ring %s uses gpu addr 0x%016llx\n",
+		 ring->name, rdev->fence_drv[ring_idx].gpu_addr);
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/radeon/radeon_ring.c b/drivers/gpu/drm/radeon/radeon_ring.c
index 581ae20c46e4..b5cd28977c54 100644
--- a/drivers/gpu/drm/radeon/radeon_ring.c
+++ b/drivers/gpu/drm/radeon/radeon_ring.c
@@ -265,8 +265,8 @@ bool radeon_ring_test_lockup(struct radeon_device *rdev, struct radeon_ring *rin
 
 	elapsed = jiffies_to_msecs(jiffies_64 - last);
 	if (radeon_lockup_timeout && elapsed >= radeon_lockup_timeout) {
-		dev_err(rdev->dev, "ring %d stalled for more than %llumsec\n",
-			ring->idx, elapsed);
+		dev_err(rdev->dev, "ring %s stalled for more than %llumsec\n",
+			ring->name, elapsed);
 		return true;
 	}
 	/* give a chance to the GPU ... */
diff --git a/drivers/gpu/drm/radeon/radeon_vce.c b/drivers/gpu/drm/radeon/radeon_vce.c
index d1871af967d4..761e8b453e1e 100644
--- a/drivers/gpu/drm/radeon/radeon_vce.c
+++ b/drivers/gpu/drm/radeon/radeon_vce.c
@@ -760,8 +760,9 @@ int radeon_vce_ring_test(struct radeon_device *rdev, struct radeon_ring *ring)
 
 	r = radeon_ring_lock(rdev, ring, 16);
 	if (r) {
-		DRM_ERROR("radeon: vce failed to lock ring %d (%d).\n",
-			  ring->idx, r);
+		DRM_ERROR("radeon: vce failed to lock ring %s (%d).\n",
+			  ring->name, r);
+		DRM_INFO("Out %s", __func__);
 		return r;
 	}
 	radeon_ring_write(ring, cpu_to_le32(VCE_CMD_END));
@@ -774,11 +775,11 @@ int radeon_vce_ring_test(struct radeon_device *rdev, struct radeon_ring *ring)
 	}
 
 	if (i < rdev->usec_timeout) {
-		DRM_INFO("ring test on %d succeeded in %d usecs\n",
-			 ring->idx, i);
+		DRM_INFO("ring test on %s succeeded in %d usecs\n",
+			 ring->name, i);
 	} else {
-		DRM_ERROR("radeon: ring %d test failed\n",
-			 ring->idx);
+		DRM_ERROR("radeon: ring %s test failed\n",
+			 ring->name);
 		r = -ETIMEDOUT;
 	}
 
diff --git a/drivers/gpu/drm/radeon/uvd_v1_0.c b/drivers/gpu/drm/radeon/uvd_v1_0.c
index 5684639d20a6..8d7913b5b6a8 100644
--- a/drivers/gpu/drm/radeon/uvd_v1_0.c
+++ b/drivers/gpu/drm/radeon/uvd_v1_0.c
@@ -427,8 +427,8 @@ int uvd_v1_0_ring_test(struct radeon_device *rdev, struct radeon_ring *ring)
 	WREG32(UVD_CONTEXT_ID, 0xCAFEDEAD);
 	r = radeon_ring_lock(rdev, ring, 3);
 	if (r) {
-		DRM_ERROR("radeon: cp failed to lock ring %d (%d).\n",
-			  ring->idx, r);
+		DRM_ERROR("radeon: cp failed to lock ring %s (%d).\n",
+			  ring->name, r);
 		return r;
 	}
 	radeon_ring_write(ring, PACKET0(UVD_CONTEXT_ID, 0));
@@ -442,11 +442,11 @@ int uvd_v1_0_ring_test(struct radeon_device *rdev, struct radeon_ring *ring)
 	}
 
 	if (i < rdev->usec_timeout) {
-		DRM_INFO("ring test on %d succeeded in %d usecs\n",
-			 ring->idx, i);
+		DRM_INFO("ring test on %s succeeded in %d usecs\n",
+			 ring->name, i);
 	} else {
-		DRM_ERROR("radeon: ring %d test failed (0x%08X)\n",
-			  ring->idx, tmp);
+		DRM_ERROR("radeon: ring %s test failed (0x%08X)\n",
+			  ring->name, tmp);
 		r = -EINVAL;
 	}
 	return r;
@@ -534,7 +534,7 @@ int uvd_v1_0_ib_test(struct radeon_device *rdev, struct radeon_ring *ring)
 		goto error;
 	}
 	r = 0;
-	DRM_INFO("ib test on ring %d succeeded\n",  ring->idx);
+	DRM_INFO("ib test on ring %s succeeded\n",  ring->name);
 error:
 	radeon_fence_unref(&fence);
 	radeon_set_uvd_clocks(rdev, 0, 0);
-- 
2.50.1


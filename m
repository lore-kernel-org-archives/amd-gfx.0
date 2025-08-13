Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E682ACA0EC4
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 00:02:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4E61210E4A2;
	Wed, 13 Aug 2025 00:02:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PFAQESmY";
	dkim-atps=neutral
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com
 [209.85.221.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C3E1010E662
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 00:02:04 +0000 (UTC)
Received: by mail-vk1-f180.google.com with SMTP id
 71dfb90a1353d-5397c00ad9eso1697871e0c.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 17:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755043323; x=1755648123; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b3Tvxnoi2EZbrXl/J46FBDRSgyjsYm8OoOt04QCpYPA=;
 b=PFAQESmY03FnIqimNmpQ3rh2HdNePGzsR0Wy9AttYsxl4UTeYqTe3nPamrjgCKr6na
 0fyOKUZkdcA3LQudS1p+758ZKw7QjC/H/0wDUDr1xBhVvt36nQojWoM6fnYAWJN/JBV+
 CBOOjAP8SJucyBxWeH1+wJlsOyKiBM87xNSSn7l6+awhUlTzZ1Ua0DUFuxPP2AWsIgAZ
 Zzf2A9vVB0r3DiUfMgS4vSRD19qyrMtVMrfOT9HaN9crf2f/5WeRsvYKACA1hge8rJpa
 DU2YMhwFEV+4o+WG8x/WCgcIaInNf0eKI2OyAMIpn+l9HF/k52XhiEBwAWDoG/ghfZgD
 d/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755043323; x=1755648123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b3Tvxnoi2EZbrXl/J46FBDRSgyjsYm8OoOt04QCpYPA=;
 b=L6PKMlKyr8XcuEH9oRC6VF0OXyaPGkQiX3wBhFtAg7dzcg70g9qICVa3CuTpgAa3wT
 vRAghgUdWtlgCmX1CtKpYappsKEIeJwf3QOP8UzxMNdw4zb/8+VZi88oASZ2dGI8dWAI
 bIDQc8lXghJcJPY9AbOxleHr9NCZa9RqZlgTLtK98w0GZ2jPUgHu9E1dg7h/2+wtjr5p
 9aQQsOWfTTh+6aNMu1vSp6LuPuhS0WsqP5D4y4Cy7hbNUeAX2REu2vOFaYr6XwC9Yn27
 /Senaq46PcGo4S8djFJ4f0PF3Mlcg9dbTS2lGvoGXntl3PAkaKVSwUNFqCRYbEfxcVCg
 vUcg==
X-Gm-Message-State: AOJu0YxFhjsr3H59yM9dVDV2Ut2hz8y7ocd2ARSM269WWCvgE4c+ThKp
 as9xnOJrJjRowenBYM0TDCLMQREWcAFwUOKQcMaU5VXDw54IgTFDJWgOG39xxXCT
X-Gm-Gg: ASbGncuKQfmToF+2iJ8wwAZ83KVMaUf7P3M9CHxgnNsd2HDMG334/2bIVC6VMqippfJ
 gWufXavmbSWEBP1qieKe4sOYzSN7hYia9SOz+/7Uc4ZysRzanJoXwXxPVkx6ExVO6iYce88M6a5
 baeiYYaXI83dYI63kBwoN9n51YcH6stSCFcDun8cicAe9+Tww1typ61aWpuI4y94PGzXgI/7azR
 euo1mLWnGZ0/fawlQQiJ04VxA8Plet/EBYA6jteeYK5N/FSdbdoWeQn5rD+WKjTHiTNf9+Udvad
 ktrJhotSdBWm20fJwjEo0+xuN2BtnwC7JZ0xjYJcNcUb+XW+F8QHgirJwDDcB40/7C59pK2cpma
 MDVxnOn3WfRig3paYIcExQBM4PVk=
X-Google-Smtp-Source: AGHT+IGJFNpec2qe3FJi9lSoazSgTwxvWntZAzrpWNGeu02QRD6q6P4aES41jmzj7AQ7CchXiNRTsA==
X-Received: by 2002:a05:6122:3c55:b0:539:1dbf:3148 with SMTP id
 71dfb90a1353d-53b0b486d1amr379953e0c.2.1755043323457; 
 Tue, 12 Aug 2025 17:02:03 -0700 (PDT)
Received: from Xander ([104.251.39.208]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7077ce3a099sm185937416d6.81.2025.08.12.17.02.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Aug 2025 17:02:02 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
Subject: [PATCH 3/4] drm/radeon: name rings
Date: Tue, 12 Aug 2025 20:01:40 -0400
Message-ID: <20250813000141.105508-4-alexandre.f.demers@gmail.com>
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

The names used are the same as the ones under amdgpu.

For coherence with amdgpu, even if SI's DMA rings are not exactly the
same as the "new SDMA" that followed for subsequent GPUs, sdma is kept
as a naming convention.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/radeon/cik.c | 27 +++++++++++++++++++++------
 drivers/gpu/drm/radeon/ni.c  | 10 ++++++++--
 drivers/gpu/drm/radeon/si.c  | 36 +++++++++++++++++++++++++++---------
 3 files changed, 56 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 11a492f21157..6d6a6abd57fb 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -8109,6 +8109,7 @@ int cik_irq_process(struct radeon_device *rdev)
 static void cik_uvd_init(struct radeon_device *rdev)
 {
 	int r;
+	struct radeon_ring *ring = &rdev->ring[R600_RING_TYPE_UVD_INDEX];
 
 	if (!rdev->has_uvd)
 		return;
@@ -8125,8 +8126,10 @@ static void cik_uvd_init(struct radeon_device *rdev)
 		rdev->has_uvd = false;
 		return;
 	}
-	rdev->ring[R600_RING_TYPE_UVD_INDEX].ring_obj = NULL;
-	r600_ring_init(rdev, &rdev->ring[R600_RING_TYPE_UVD_INDEX], 4096);
+
+	ring->ring_obj = NULL;
+	sprintf(ring->name, "uvd");
+	r600_ring_init(rdev, ring, 4096);
 }
 
 static void cik_uvd_start(struct radeon_device *rdev)
@@ -8181,6 +8184,7 @@ static void cik_uvd_resume(struct radeon_device *rdev)
 static void cik_vce_init(struct radeon_device *rdev)
 {
 	int r;
+	struct radeon_ring *ring;
 
 	if (!rdev->has_vce)
 		return;
@@ -8197,10 +8201,16 @@ static void cik_vce_init(struct radeon_device *rdev)
 		rdev->has_vce = false;
 		return;
 	}
-	rdev->ring[TN_RING_TYPE_VCE1_INDEX].ring_obj = NULL;
-	r600_ring_init(rdev, &rdev->ring[TN_RING_TYPE_VCE1_INDEX], 4096);
-	rdev->ring[TN_RING_TYPE_VCE2_INDEX].ring_obj = NULL;
-	r600_ring_init(rdev, &rdev->ring[TN_RING_TYPE_VCE2_INDEX], 4096);
+
+	ring = &rdev->ring[TN_RING_TYPE_VCE1_INDEX];
+	ring->ring_obj = NULL;
+	sprintf(ring->name, "vce0");
+	r600_ring_init(rdev, ring, 4096);
+
+	ring = &rdev->ring[TN_RING_TYPE_VCE2_INDEX];
+	ring->ring_obj = NULL;
+	sprintf(ring->name, "vce1");
+	r600_ring_init(rdev, ring, 4096);
 }
 
 static void cik_vce_start(struct radeon_device *rdev)
@@ -8621,10 +8631,12 @@ int cik_init(struct radeon_device *rdev)
 
 	ring = &rdev->ring[RADEON_RING_TYPE_GFX_INDEX];
 	ring->ring_obj = NULL;
+	sprintf(ring->name, "gfx");
 	r600_ring_init(rdev, ring, 1024 * 1024);
 
 	ring = &rdev->ring[CAYMAN_RING_TYPE_CP1_INDEX];
 	ring->ring_obj = NULL;
+	sprintf(ring->name, "comp_%d.%d.%d", 1, ring->pipe, ring->queue);
 	r600_ring_init(rdev, ring, 1024 * 1024);
 	r = radeon_doorbell_get(rdev, &ring->doorbell_index);
 	if (r)
@@ -8632,6 +8644,7 @@ int cik_init(struct radeon_device *rdev)
 
 	ring = &rdev->ring[CAYMAN_RING_TYPE_CP2_INDEX];
 	ring->ring_obj = NULL;
+	sprintf(ring->name, "comp_%d.%d.%d", 2, ring->pipe, ring->queue);
 	r600_ring_init(rdev, ring, 1024 * 1024);
 	r = radeon_doorbell_get(rdev, &ring->doorbell_index);
 	if (r)
@@ -8639,10 +8652,12 @@ int cik_init(struct radeon_device *rdev)
 
 	ring = &rdev->ring[R600_RING_TYPE_DMA_INDEX];
 	ring->ring_obj = NULL;
+	sprintf(ring->name, "sdma0");
 	r600_ring_init(rdev, ring, 256 * 1024);
 
 	ring = &rdev->ring[CAYMAN_RING_TYPE_DMA1_INDEX];
 	ring->ring_obj = NULL;
+	sprintf(ring->name, "sdma1");
 	r600_ring_init(rdev, ring, 256 * 1024);
 
 	cik_uvd_init(rdev);
diff --git a/drivers/gpu/drm/radeon/ni.c b/drivers/gpu/drm/radeon/ni.c
index 3890911fe693..5069a9a3bfbd 100644
--- a/drivers/gpu/drm/radeon/ni.c
+++ b/drivers/gpu/drm/radeon/ni.c
@@ -1978,6 +1978,7 @@ bool cayman_gfx_is_lockup(struct radeon_device *rdev, struct radeon_ring *ring)
 static void cayman_uvd_init(struct radeon_device *rdev)
 {
 	int r;
+	struct radeon_ring *ring = &rdev->ring[R600_RING_TYPE_UVD_INDEX];
 
 	if (!rdev->has_uvd)
 		return;
@@ -1994,8 +1995,10 @@ static void cayman_uvd_init(struct radeon_device *rdev)
 		rdev->has_uvd = false;
 		return;
 	}
-	rdev->ring[R600_RING_TYPE_UVD_INDEX].ring_obj = NULL;
-	r600_ring_init(rdev, &rdev->ring[R600_RING_TYPE_UVD_INDEX], 4096);
+
+	ring->ring_obj = NULL;
+	sprintf(ring->name, "uvd");
+	r600_ring_init(rdev, ring, 4096);
 }
 
 static void cayman_uvd_start(struct radeon_device *rdev)
@@ -2394,14 +2397,17 @@ int cayman_init(struct radeon_device *rdev)
 	radeon_pm_init(rdev);
 
 	ring->ring_obj = NULL;
+	sprintf(ring->name, "gfx");
 	r600_ring_init(rdev, ring, 1024 * 1024);
 
 	ring = &rdev->ring[R600_RING_TYPE_DMA_INDEX];
 	ring->ring_obj = NULL;
+	sprintf(ring->name, "sdma0");
 	r600_ring_init(rdev, ring, 64 * 1024);
 
 	ring = &rdev->ring[CAYMAN_RING_TYPE_DMA1_INDEX];
 	ring->ring_obj = NULL;
+	sprintf(ring->name, "sdma1");
 	r600_ring_init(rdev, ring, 64 * 1024);
 
 	cayman_uvd_init(rdev);
diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index 789f3b2fdf5c..d6d83b76dc98 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -6439,6 +6439,7 @@ int si_irq_process(struct radeon_device *rdev)
 static void si_uvd_init(struct radeon_device *rdev)
 {
 	int r;
+	struct radeon_ring *ring = &rdev->ring[R600_RING_TYPE_UVD_INDEX];
 
 	if (!rdev->has_uvd)
 		return;
@@ -6455,8 +6456,10 @@ static void si_uvd_init(struct radeon_device *rdev)
 		rdev->has_uvd = false;
 		return;
 	}
-	rdev->ring[R600_RING_TYPE_UVD_INDEX].ring_obj = NULL;
-	r600_ring_init(rdev, &rdev->ring[R600_RING_TYPE_UVD_INDEX], 4096);
+
+	ring->ring_obj = NULL;
+	sprintf(ring->name, "uvd");
+	r600_ring_init(rdev, ring, 4096);
 }
 
 static void si_uvd_start(struct radeon_device *rdev)
@@ -6506,6 +6509,7 @@ static void si_uvd_resume(struct radeon_device *rdev)
 static void si_vce_init(struct radeon_device *rdev)
 {
 	int r;
+	struct radeon_ring *ring;
 
 	if (!rdev->has_vce)
 		return;
@@ -6522,27 +6526,36 @@ static void si_vce_init(struct radeon_device *rdev)
 		rdev->has_vce = false;
 		return;
 	}
-	rdev->ring[TN_RING_TYPE_VCE1_INDEX].ring_obj = NULL;
-	r600_ring_init(rdev, &rdev->ring[TN_RING_TYPE_VCE1_INDEX], 4096);
-	rdev->ring[TN_RING_TYPE_VCE2_INDEX].ring_obj = NULL;
-	r600_ring_init(rdev, &rdev->ring[TN_RING_TYPE_VCE2_INDEX], 4096);
+
+	ring = &rdev->ring[TN_RING_TYPE_VCE1_INDEX];
+	ring->ring_obj = NULL;
+	sprintf(ring->name, "vce0");
+	r600_ring_init(rdev, ring, 4096);
+
+	ring = &rdev->ring[TN_RING_TYPE_VCE2_INDEX];
+	ring->ring_obj = NULL;
+	sprintf(ring->name, "vce1");
+	r600_ring_init(rdev, ring, 4096);
 }
 
 static void si_vce_start(struct radeon_device *rdev)
 {
+	DRM_INFO("In %s, similar to AMDGPU vce_v1_0_resume() + radeon_fence_driver_start_ring()", __func__);
 	int r;
 
-	if (!rdev->has_vce)
+	if (!rdev->has_vce) {
+		DRM_INFO("Out %s", __func__);
 		return;
+	}
 
 	r = radeon_vce_resume(rdev);
 	if (r) {
 		dev_err(rdev->dev, "failed VCE resume (%d).\n", r);
 		goto error;
 	}
-	r = vce_v1_0_resume(rdev);
+	r = vce_v1_0_mc_resume(rdev);
 	if (r) {
-		dev_err(rdev->dev, "failed VCE resume (%d).\n", r);
+		dev_err(rdev->dev, "failed VCE MC resume (%d).\n", r);
 		goto error;
 	}
 	r = radeon_fence_driver_start_ring(rdev, TN_RING_TYPE_VCE1_INDEX);
@@ -6867,22 +6880,27 @@ int si_init(struct radeon_device *rdev)
 
 	ring = &rdev->ring[RADEON_RING_TYPE_GFX_INDEX];
 	ring->ring_obj = NULL;
+	sprintf(ring->name, "gfx");
 	r600_ring_init(rdev, ring, 1024 * 1024);
 
 	ring = &rdev->ring[CAYMAN_RING_TYPE_CP1_INDEX];
 	ring->ring_obj = NULL;
+	sprintf(ring->name, "comp_%d.%d.%d", 1, ring->pipe, ring->queue);
 	r600_ring_init(rdev, ring, 1024 * 1024);
 
 	ring = &rdev->ring[CAYMAN_RING_TYPE_CP2_INDEX];
 	ring->ring_obj = NULL;
+	sprintf(ring->name, "comp_%d.%d.%d", 2, ring->pipe, ring->queue);
 	r600_ring_init(rdev, ring, 1024 * 1024);
 
 	ring = &rdev->ring[R600_RING_TYPE_DMA_INDEX];
 	ring->ring_obj = NULL;
+	sprintf(ring->name, "sdma0");
 	r600_ring_init(rdev, ring, 64 * 1024);
 
 	ring = &rdev->ring[CAYMAN_RING_TYPE_DMA1_INDEX];
 	ring->ring_obj = NULL;
+	sprintf(ring->name, "sdma1");
 	r600_ring_init(rdev, ring, 64 * 1024);
 
 	si_uvd_init(rdev);
-- 
2.50.1


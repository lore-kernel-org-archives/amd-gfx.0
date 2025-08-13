Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4C22CA0EDC
	for <amd-gfx@archiver.kernel.org>; Wed, 13 Aug 2025 00:15:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E52710E676;
	Wed, 13 Aug 2025 00:15:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KBTslZl6";
	dkim-atps=neutral
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com
 [209.85.161.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13B0110E18D
 for <amd-gfx@lists.freedesktop.org>; Wed, 13 Aug 2025 00:15:29 +0000 (UTC)
Received: by mail-oo1-f41.google.com with SMTP id
 006d021491bc7-61bc97d9c28so40211eaf.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Aug 2025 17:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1755044128; x=1755648928; darn=lists.freedesktop.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=s9EdkWujS/DuS+AhvPAHUVp9mBFHwb7yODqzoZLMLX8=;
 b=KBTslZl6tJI4ctqkhpq17ufU78JiM8XX7mRYY12CNC2apFc7+0N0acz8FMj1pE0AGK
 k8dUJ56ewxGzjkF9cnhFh9Kc3KVFvqxaDniKBXHxPJ/MjxcHQ8EN6/kcwgxZmwRGbglN
 O/Jrl2+pFpRfaGyVvu2Wy5/pWesSlAZdWdq4KlCkg6Ytk0/QnaLhc0iZ7yY/popicpMs
 xy0OSk5Xx7ydXq5vmWC/bz4XoIKzxYtjOwQL322Gn7M8a1jDwg+F4Q3c/u6JzoXJ4kD+
 /+M38UTJu3MmTR9OJJjxlfaHOEY180ic5NEcjLNJuPAy0TdXNyT1kXG5XNdsVxpB0nlb
 FeOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755044128; x=1755648928;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s9EdkWujS/DuS+AhvPAHUVp9mBFHwb7yODqzoZLMLX8=;
 b=CLkVQTX98TWg/WY/iTaKMt+ZN0RPBTL0d/Nd11vAkiduVwjr6Y3mkzV6ckuWeXPNiv
 VYa0i//ZHPlOv5cWE4Amvebazk5Yn/eyPGp51yvvcZXt3ip7D7EZVx23XsLHxJgMDsyn
 3/YfQB3sUdd1/LjU4n/WkburnPQXP9JUCvO9AupfHFLhF6qXaH1kXa1Sm3pzXU5zD7Db
 +iLKzL8BdebeELEhaDy9PWicSceKeiJJNvrKN5YRJ12Mb4bdxmEtU7CtKUyW90uuZAry
 XqgLHPsGypxVxf74PQdYxLQqafV5OZGuvGREFAoJclHFIA4BYqPUA5qA0NNY2DxWj1Wn
 +MhA==
X-Gm-Message-State: AOJu0Ywk10ZRv+17jocsPVqWTCa/y3tSx4YbWgi0K3RZl6hHC7lybjht
 zuJxu+xyGzLHo1CnowNi10S29oUHRB32TRBMpCKnzkqOhlac9Ea4JUrM/lrbavUUUPPGCvljUB5
 21niYdzV1ho+m062cNI5VXPz+Y0EACPbm9r/W
X-Gm-Gg: ASbGncsnjTVEoOBVXzwjD44bXT9XLmns+8/GKbJCluSQN04lkiTYJ8L+Wy8oI4B9HRP
 F9rFXBIBbHi0rBdj6gPj3NYgImCZKfVZfVa9vO29XTGddP2zF68gBACyoKJMV/VPFD35eDhbbzn
 u6yiwRIkUOZ584gohtjGs+tWINomHm+Wm3AJyFOGyB7tqYbxwJhGGAUUoG2tzXCtykGvlwTBGTb
 nOHcDai
X-Google-Smtp-Source: AGHT+IGBmBpcFPqJGnYQumQB1T2YSrlT/96BBFUXP8RWOLml1FiPMRnI6ez5p5EOliVWiExrJRkUDVl2zBi8nIsVPrY=
X-Received: by 2002:a05:6870:c45:b0:30b:7a64:d67b with SMTP id
 586e51a60fabf-30cb59e1518mr825266fac.5.1755044127699; Tue, 12 Aug 2025
 17:15:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250813000141.105508-1-alexandre.f.demers@gmail.com>
 <20250813000141.105508-5-alexandre.f.demers@gmail.com>
In-Reply-To: <20250813000141.105508-5-alexandre.f.demers@gmail.com>
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Tue, 12 Aug 2025 20:15:16 -0400
X-Gm-Features: Ac12FXzs8lvzddKnD-lTsYuJhXygiTGuK_NPtdGd3WD0Lie-mDMgyz1Os9wehhM
Message-ID: <CAPEhTTGRfCo=R7aDBT=OV=DD5iePaTNXf4sjGwBzEhop531o0g@mail.gmail.com>
Subject: [PATCH 4/4 - V2] drm/radeon: switch from ring->idx to ring->name for
 printouts
To: Freedesktop - AMD-gfx <amd-gfx@lists.freedesktop.org>
Cc: Alexander Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="UTF-8"
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

From 8b0d6ce75155be6b7c585bd9814e6661a244cc3d Mon Sep 17 00:00:00 2001
From: Alexandre Demers <alexandre.f.demers@gmail.com>
Date: Tue, 12 Aug 2025 18:53:12 -0400
Subject: [PATCH 4/4 - V2] drm/radeon: switch from ring->idx to
ring->name  for printouts

Replace rings' index value for the rings' name value.

V2: add leftover hunk

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/radeon/cik.c          |  8 ++++----
 drivers/gpu/drm/radeon/cik_sdma.c     |  6 +++---
 drivers/gpu/drm/radeon/r600.c         |  8 ++++----
 drivers/gpu/drm/radeon/r600_dma.c     |  8 ++++----
 drivers/gpu/drm/radeon/radeon_fence.c |  6 ++++--
 drivers/gpu/drm/radeon/radeon_ring.c  |  4 ++--
 drivers/gpu/drm/radeon/radeon_vce.c   | 13 +++++++------
 drivers/gpu/drm/radeon/uvd_v1_0.c     | 14 +++++++-------
 8 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index 6d6a6abd57fb..b85809369e81 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -3457,7 +3457,7 @@ int cik_ring_test(struct radeon_device *rdev,
struct radeon_ring *ring)
  WREG32(scratch, 0xCAFEDEAD);
  r = radeon_ring_lock(rdev, ring, 3);
  if (r) {
- DRM_ERROR("radeon: cp failed to lock ring %d (%d).\n", ring->idx, r);
+ DRM_ERROR("radeon: cp failed to lock ring %s (%d).\n", ring->name, r);
  radeon_scratch_free(rdev, scratch);
  return r;
  }
@@ -3473,10 +3473,10 @@ int cik_ring_test(struct radeon_device *rdev,
struct radeon_ring *ring)
  udelay(1);
  }
  if (i < rdev->usec_timeout) {
- DRM_INFO("ring test on %d succeeded in %d usecs\n", ring->idx, i);
+ DRM_INFO("ring test on %s succeeded in %d usecs\n", ring->name, i);
  } else {
- DRM_ERROR("radeon: ring %d test failed (scratch(0x%04X)=0x%08X)\n",
-  ring->idx, scratch, tmp);
+ DRM_ERROR("radeon: ring %s test failed (scratch(0x%04X)=0x%08X)\n",
+  ring->name, scratch, tmp);
  r = -EINVAL;
  }
  radeon_scratch_free(rdev, scratch);
diff --git a/drivers/gpu/drm/radeon/cik_sdma.c
b/drivers/gpu/drm/radeon/cik_sdma.c
index 919b14845c3c..54c67c100fe0 100644
--- a/drivers/gpu/drm/radeon/cik_sdma.c
+++ b/drivers/gpu/drm/radeon/cik_sdma.c
@@ -680,10 +680,10 @@ int cik_sdma_ring_test(struct radeon_device *rdev,
  }

  if (i < rdev->usec_timeout) {
- DRM_INFO("ring test on %d succeeded in %d usecs\n", ring->idx, i);
+ DRM_INFO("ring test on %s succeeded in %d usecs\n", ring->name, i);
  } else {
- DRM_ERROR("radeon: ring %d test failed (0x%08X)\n",
-  ring->idx, tmp);
+ DRM_ERROR("radeon: ring %s test failed (0x%08X)\n",
+  ring->name, tmp);
  r = -EINVAL;
  }
  return r;
diff --git a/drivers/gpu/drm/radeon/r600.c b/drivers/gpu/drm/radeon/r600.c
index 8b62f7faa5b9..de98e4613114 100644
--- a/drivers/gpu/drm/radeon/r600.c
+++ b/drivers/gpu/drm/radeon/r600.c
@@ -2835,7 +2835,7 @@ int r600_ring_test(struct radeon_device *rdev,
struct radeon_ring *ring)
  WREG32(scratch, 0xCAFEDEAD);
  r = radeon_ring_lock(rdev, ring, 3);
  if (r) {
- DRM_ERROR("radeon: cp failed to lock ring %d (%d).\n", ring->idx, r);
+ DRM_ERROR("radeon: cp failed to lock ring %s (%d).\n", ring->name, r);
  radeon_scratch_free(rdev, scratch);
  return r;
  }
@@ -2850,10 +2850,10 @@ int r600_ring_test(struct radeon_device *rdev,
struct radeon_ring *ring)
  udelay(1);
  }
  if (i < rdev->usec_timeout) {
- DRM_INFO("ring test on %d succeeded in %d usecs\n", ring->idx, i);
+ DRM_INFO("ring test on %s succeeded in %d usecs\n", ring->name, i);
  } else {
- DRM_ERROR("radeon: ring %d test failed (scratch(0x%04X)=0x%08X)\n",
-  ring->idx, scratch, tmp);
+ DRM_ERROR("radeon: ring %s test failed (scratch(0x%04X)=0x%08X)\n",
+  ring->name, scratch, tmp);
  r = -EINVAL;
  }
  radeon_scratch_free(rdev, scratch);
diff --git a/drivers/gpu/drm/radeon/r600_dma.c
b/drivers/gpu/drm/radeon/r600_dma.c
index 89ca2738c5d4..d69a6edce9ac 100644
--- a/drivers/gpu/drm/radeon/r600_dma.c
+++ b/drivers/gpu/drm/radeon/r600_dma.c
@@ -247,7 +247,7 @@ int r600_dma_ring_test(struct radeon_device *rdev,

  r = radeon_ring_lock(rdev, ring, 4);
  if (r) {
- DRM_ERROR("radeon: dma failed to lock ring %d (%d).\n", ring->idx, r);
+ DRM_ERROR("radeon: dma failed to lock ring %s (%d).\n", ring->name, r);
  return r;
  }
  radeon_ring_write(ring, DMA_PACKET(DMA_PACKET_WRITE, 0, 0, 1));
@@ -264,10 +264,10 @@ int r600_dma_ring_test(struct radeon_device *rdev,
  }

  if (i < rdev->usec_timeout) {
- DRM_INFO("ring test on %d succeeded in %d usecs\n", ring->idx, i);
+ DRM_INFO("ring test on %s succeeded in %d usecs\n", ring->name, i);
  } else {
- DRM_ERROR("radeon: ring %d test failed (0x%08X)\n",
-  ring->idx, tmp);
+ DRM_ERROR("radeon: ring %s test failed (0x%08X)\n",
+  ring->name, tmp);
  r = -EINVAL;
  }
  return r;
diff --git a/drivers/gpu/drm/radeon/radeon_fence.c
b/drivers/gpu/drm/radeon/radeon_fence.c
index 1be8364b2a97..b873b995b0ff 100644
--- a/drivers/gpu/drm/radeon/radeon_fence.c
+++ b/drivers/gpu/drm/radeon/radeon_fence.c
@@ -809,6 +809,8 @@ int radeon_fence_driver_start_ring(struct
radeon_device *rdev, int ring_idx)
 {
  uint64_t index;
  int r;
+ struct radeon_ring *ring = &rdev->ring[ring_idx];
+
  radeon_scratch_free(rdev, rdev->fence_drv[ring_idx].scratch_reg);
  if (rdev->wb.use_event || !radeon_ring_supports_scratch_reg(rdev, ring)) {
  rdev->fence_drv[ring_idx].scratch_reg = 0;
@@ -840,8 +842,8 @@ int radeon_fence_driver_start_ring(struct
radeon_device *rdev, int ring_idx)
  radeon_fence_write(rdev,
atomic64_read(&rdev->fence_drv[ring_idx].last_seq), ring_idx);
  rdev->fence_drv[ring_idx].initialized = true;

- dev_info(rdev->dev, "fence driver on ring %d uses gpu addr 0x%016llx\n",
- ring_idx, rdev->fence_drv[ring_idx].gpu_addr);
+ dev_info(rdev->dev, "fence driver on ring %s uses gpu addr 0x%016llx\n",
+ ring->name, rdev->fence_drv[ring_idx].gpu_addr);
  return 0;
 }

diff --git a/drivers/gpu/drm/radeon/radeon_ring.c
b/drivers/gpu/drm/radeon/radeon_ring.c
index 581ae20c46e4..b5cd28977c54 100644
--- a/drivers/gpu/drm/radeon/radeon_ring.c
+++ b/drivers/gpu/drm/radeon/radeon_ring.c
@@ -265,8 +265,8 @@ bool radeon_ring_test_lockup(struct radeon_device
*rdev, struct radeon_ring *rin

  elapsed = jiffies_to_msecs(jiffies_64 - last);
  if (radeon_lockup_timeout && elapsed >= radeon_lockup_timeout) {
- dev_err(rdev->dev, "ring %d stalled for more than %llumsec\n",
- ring->idx, elapsed);
+ dev_err(rdev->dev, "ring %s stalled for more than %llumsec\n",
+ ring->name, elapsed);
  return true;
  }
  /* give a chance to the GPU ... */
diff --git a/drivers/gpu/drm/radeon/radeon_vce.c
b/drivers/gpu/drm/radeon/radeon_vce.c
index d1871af967d4..761e8b453e1e 100644
--- a/drivers/gpu/drm/radeon/radeon_vce.c
+++ b/drivers/gpu/drm/radeon/radeon_vce.c
@@ -760,8 +760,9 @@ int radeon_vce_ring_test(struct radeon_device
*rdev, struct radeon_ring *ring)

  r = radeon_ring_lock(rdev, ring, 16);
  if (r) {
- DRM_ERROR("radeon: vce failed to lock ring %d (%d).\n",
-  ring->idx, r);
+ DRM_ERROR("radeon: vce failed to lock ring %s (%d).\n",
+  ring->name, r);
+ DRM_INFO("Out %s", __func__);
  return r;
  }
  radeon_ring_write(ring, cpu_to_le32(VCE_CMD_END));
@@ -774,11 +775,11 @@ int radeon_vce_ring_test(struct radeon_device
*rdev, struct radeon_ring *ring)
  }

  if (i < rdev->usec_timeout) {
- DRM_INFO("ring test on %d succeeded in %d usecs\n",
- ring->idx, i);
+ DRM_INFO("ring test on %s succeeded in %d usecs\n",
+ ring->name, i);
  } else {
- DRM_ERROR("radeon: ring %d test failed\n",
- ring->idx);
+ DRM_ERROR("radeon: ring %s test failed\n",
+ ring->name);
  r = -ETIMEDOUT;
  }

diff --git a/drivers/gpu/drm/radeon/uvd_v1_0.c
b/drivers/gpu/drm/radeon/uvd_v1_0.c
index 5684639d20a6..8d7913b5b6a8 100644
--- a/drivers/gpu/drm/radeon/uvd_v1_0.c
+++ b/drivers/gpu/drm/radeon/uvd_v1_0.c
@@ -427,8 +427,8 @@ int uvd_v1_0_ring_test(struct radeon_device *rdev,
struct radeon_ring *ring)
  WREG32(UVD_CONTEXT_ID, 0xCAFEDEAD);
  r = radeon_ring_lock(rdev, ring, 3);
  if (r) {
- DRM_ERROR("radeon: cp failed to lock ring %d (%d).\n",
-  ring->idx, r);
+ DRM_ERROR("radeon: cp failed to lock ring %s (%d).\n",
+  ring->name, r);
  return r;
  }
  radeon_ring_write(ring, PACKET0(UVD_CONTEXT_ID, 0));
@@ -442,11 +442,11 @@ int uvd_v1_0_ring_test(struct radeon_device
*rdev, struct radeon_ring *ring)
  }

  if (i < rdev->usec_timeout) {
- DRM_INFO("ring test on %d succeeded in %d usecs\n",
- ring->idx, i);
+ DRM_INFO("ring test on %s succeeded in %d usecs\n",
+ ring->name, i);
  } else {
- DRM_ERROR("radeon: ring %d test failed (0x%08X)\n",
-  ring->idx, tmp);
+ DRM_ERROR("radeon: ring %s test failed (0x%08X)\n",
+  ring->name, tmp);
  r = -EINVAL;
  }
  return r;
@@ -534,7 +534,7 @@ int uvd_v1_0_ib_test(struct radeon_device *rdev,
struct radeon_ring *ring)
  goto error;
  }
  r = 0;
- DRM_INFO("ib test on ring %d succeeded\n",  ring->idx);
+ DRM_INFO("ib test on ring %s succeeded\n",  ring->name);
 error:
  radeon_fence_unref(&fence);
  radeon_set_uvd_clocks(rdev, 0, 0);
-- 
2.50.1

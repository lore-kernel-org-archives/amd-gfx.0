Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D79D7D5B16E
	for <amd-gfx@archiver.kernel.org>; Mon, 15 Dec 2025 01:12:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 724A210E0E2;
	Mon, 15 Dec 2025 01:12:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GzjAnaku";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5983110E0D3
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 01:12:38 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id B605C60127
 for <amd-gfx@lists.freedesktop.org>; Mon, 15 Dec 2025 01:12:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E143C4CEFB;
 Mon, 15 Dec 2025 01:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1765761157;
 bh=x/ht53W4S8UffUXDfH8bkR7szDrXe61DpHMvsoIa7OQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=GzjAnakucv/JfWN3T9OvDLahyfHAzpdWnEJc9WH4MwrrrA9VUL+a4D8WNwBHIPvjh
 e21MzbNK3EllEX8+U/HDXwNXqtVLIkbsP/zOg/1sAYNJdj9dOAjIao6w/rWRTXOXdf
 YWz2Ke1riOD2QxElvlDUQQpr9x2H2lEELe+RxRKmM7MkSs8c6M852iAlNNwLToGdBO
 zqw1yjRDDs2mvXE8FKNVo7lduD8eog4tpkYGkKzF6cQrT7HI15743eG+C+0Yc2mSze
 P8XZcne/cqUtQYSNj0zxcFRFg6iDpqhRnPcrI6Lt84eJhNK+wo0Tn8IGdKoXEWkAjP
 6pyGx3nDd2HHQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: amd-gfx@lists.freedesktop.org
Cc: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH 8/9] drm/amd: Drop amdgpu prefix from message prints
Date: Sun, 14 Dec 2025 19:12:26 -0600
Message-ID: <20251215011227.161597-9-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251215011227.161597-1-superm1@kernel.org>
References: <20251215011227.161597-1-superm1@kernel.org>
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

Hardcoding the prefix isn't necessary when using drm_* or dev_*
message prints.

Signed-off-by: Mario Limonciello (AMD) <superm1@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c     |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c        |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c           |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c          |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c           |  6 +++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c           |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c            | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c            |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c            |  6 +++---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c             |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c             |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c            |  2 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c            |  4 ++--
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c            |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c            | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c            |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c            | 10 +++++-----
 drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c             |  8 ++++----
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c             |  4 ++--
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c             |  2 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c             |  2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 ++++--
 31 files changed, 75 insertions(+), 73 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
index a050167e76a4b..1cbba9803d314 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_benchmark.c
@@ -66,7 +66,7 @@ static void amdgpu_benchmark_log_results(struct amdgpu_device *adev,
 
 	throughput = div64_s64(throughput, time_ms);
 
-	dev_info(adev->dev, "amdgpu: %s %u bo moves of %u kB from"
+	dev_info(adev->dev, " %s %u bo moves of %u kB from"
 		 " %d to %d in %lld ms, throughput: %lld Mb/s or %lld MB/s\n",
 		 kind, n, size >> 10, sdomain, ddomain, time_ms,
 		 throughput * 8, throughput);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 7a0213a07023d..d681ba6595039 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -5037,7 +5037,7 @@ static void amdgpu_device_unmap_mmio(struct amdgpu_device *adev)
  */
 void amdgpu_device_fini_hw(struct amdgpu_device *adev)
 {
-	dev_info(adev->dev, "amdgpu: finishing device.\n");
+	dev_info(adev->dev, "finishing device.\n");
 	flush_delayed_work(&adev->delayed_init_work);
 
 	if (adev->mman.initialized)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index b321783f2bccc..fb15f5b1d474e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -130,11 +130,11 @@ void amdgpu_gfx_parse_disable_cu(struct amdgpu_device *adev, unsigned int *mask,
 		}
 
 		if (se < max_se && sh < max_sh && cu < 16) {
-			DRM_INFO("amdgpu: disabling CU %u.%u.%u\n", se, sh, cu);
+			drm_info(adev_to_drm(adev), "Disabling CU %u.%u.%u\n", se, sh, cu);
 			mask[se * max_sh + sh] |= 1u << cu;
 		} else {
-			DRM_ERROR("amdgpu: disable_cu %u.%u.%u is out of range\n",
-				  se, sh, cu);
+			drm_err(adev_to_drm(adev), "disable_cu %u.%u.%u is out of range\n",
+			          se, sh, cu);
 		}
 
 		next = strchr(p, ',');
@@ -152,7 +152,7 @@ static bool amdgpu_gfx_is_graphics_multipipe_capable(struct amdgpu_device *adev)
 static bool amdgpu_gfx_is_compute_multipipe_capable(struct amdgpu_device *adev)
 {
 	if (amdgpu_compute_multipipe != -1) {
-		dev_info(adev->dev, "amdgpu: forcing compute pipe policy %d\n",
+		dev_info(adev->dev, " forcing compute pipe policy %d\n",
 			 amdgpu_compute_multipipe);
 		return amdgpu_compute_multipipe == 1;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
index 8112ffc85995e..5abe5ca0539d1 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_irq.c
@@ -316,7 +316,7 @@ int amdgpu_irq_init(struct amdgpu_device *adev)
 	adev->irq.irq = irq;
 	adev_to_drm(adev)->max_vblank_count = 0x00ffffff;
 
-	dev_dbg(adev->dev, "amdgpu: irq initialized.\n");
+	dev_dbg(adev->dev, "irq initialized.\n");
 	return 0;
 
 free_vectors:
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
index 1aee207b13524..600e6bb98af7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c
@@ -191,7 +191,7 @@ void amdgpu_ring_commit(struct amdgpu_ring *ring)
 	uint32_t count;
 
 	if (ring->count_dw < 0)
-		DRM_ERROR("amdgpu: writing more dwords to the ring than expected!\n");
+		drm_err(adev_to_drm(ring->adev), "writing more dwords to the ring than expected!\n");
 
 	/* We pad to match fetch size */
 	count = ring->funcs->align_mask + 1 -
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 0f83d140b6ae5..8b33966a745f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -2108,7 +2108,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		DRM_DEBUG_DRIVER("Skipped stolen memory reservation\n");
 	}
 
-	dev_info(adev->dev, "amdgpu: %uM of VRAM memory ready\n",
+	dev_info(adev->dev, " %uM of VRAM memory ready\n",
 		 (unsigned int)(adev->gmc.real_vram_size / (1024 * 1024)));
 
 	/* Compute GTT size, either based on TTM limit
@@ -2134,7 +2134,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
 		dev_err(adev->dev, "Failed initializing GTT heap.\n");
 		return r;
 	}
-	dev_info(adev->dev, "amdgpu: %uM of GTT memory ready.\n",
+	dev_info(adev->dev, " %uM of GTT memory ready.\n",
 		 (unsigned int)(gtt_size / (1024 * 1024)));
 
 	if (adev->flags & AMD_IS_APU) {
@@ -2257,7 +2257,7 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
 	ttm_range_man_fini(&adev->mman.bdev, AMDGPU_PL_MMIO_REMAP);
 	ttm_device_fini(&adev->mman.bdev);
 	adev->mman.initialized = false;
-	dev_info(adev->dev, "amdgpu: ttm finalized\n");
+	dev_info(adev->dev, " ttm finalized\n");
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
index aa78c2ee9e21c..fd881388d6125 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vpe.c
@@ -790,7 +790,7 @@ static int vpe_ring_test_ring(struct amdgpu_ring *ring)
 
 	ret = amdgpu_ring_alloc(ring, 4);
 	if (ret) {
-		dev_err(adev->dev, "amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, ret);
+		dev_err(adev->dev, "dma failed to lock ring %d (%d).\n", ring->idx, ret);
 		goto out;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
index 1081354a18929..7501b4a7efb55 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v10_0.c
@@ -4041,8 +4041,8 @@ static int gfx_v10_0_ring_test_ring(struct amdgpu_ring *ring)
 	WREG32(scratch, 0xCAFEDEAD);
 	r = amdgpu_ring_alloc(ring, 3);
 	if (r) {
-		DRM_ERROR("amdgpu: cp failed to lock ring %d (%d).\n",
-			  ring->idx, r);
+		drm_err(adev_to_drm(adev), "cp failed to lock ring %d (%d).\n",
+			ring->idx, r);
 		return r;
 	}
 
@@ -4090,7 +4090,7 @@ static int gfx_v10_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
 	if (r) {
-		DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
+		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
 		goto err1;
 	}
 
@@ -6379,7 +6379,7 @@ static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
 	ring = &adev->gfx.gfx_ring[0];
 	r = amdgpu_ring_alloc(ring, gfx_v10_0_get_csb_size(adev) + 4);
 	if (r) {
-		DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
+		drm_err(adev_to_drm(adev), "cp failed to lock ring (%d).\n", r);
 		return r;
 	}
 
@@ -6429,7 +6429,7 @@ static int gfx_v10_0_cp_gfx_start(struct amdgpu_device *adev)
 		ring = &adev->gfx.gfx_ring[1];
 		r = amdgpu_ring_alloc(ring, 2);
 		if (r) {
-			DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
+			drm_err(adev_to_drm(adev), "cp failed to lock ring (%d).\n", r);
 			return r;
 		}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
index 5ab6122916c81..78096da317531 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v11_0.c
@@ -567,7 +567,7 @@ static int gfx_v11_0_ring_test_ring(struct amdgpu_ring *ring)
 	WREG32(scratch, 0xCAFEDEAD);
 	r = amdgpu_ring_alloc(ring, 5);
 	if (r) {
-		DRM_ERROR("amdgpu: cp failed to lock ring %d (%d).\n",
+		drm_err(adev_to_drm(adev), "cp failed to lock ring %d (%d).\n",
 			  ring->idx, r);
 		return r;
 	}
@@ -624,7 +624,7 @@ static int gfx_v11_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	r = amdgpu_ib_get(adev, NULL, 20, AMDGPU_IB_POOL_DIRECT, &ib);
 	if (r) {
-		DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
+		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
 		goto err1;
 	}
 
@@ -3623,7 +3623,7 @@ static int gfx_v11_0_cp_gfx_start(struct amdgpu_device *adev)
 	ring = &adev->gfx.gfx_ring[0];
 	r = amdgpu_ring_alloc(ring, gfx_v11_0_get_csb_size(adev));
 	if (r) {
-		DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
+		drm_err(&adev->ddev, "cp failed to lock ring (%d).\n", r);
 		return r;
 	}
 
@@ -3668,7 +3668,7 @@ static int gfx_v11_0_cp_gfx_start(struct amdgpu_device *adev)
 		ring = &adev->gfx.gfx_ring[1];
 		r = amdgpu_ring_alloc(ring, 2);
 		if (r) {
-			DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
+			drm_err(adev_to_drm(adev), "cp failed to lock ring (%d).\n", r);
 			return r;
 		}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
index c2e1db200712a..b1441d38f376f 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v12_0.c
@@ -460,8 +460,8 @@ static int gfx_v12_0_ring_test_ring(struct amdgpu_ring *ring)
 	WREG32(scratch, 0xCAFEDEAD);
 	r = amdgpu_ring_alloc(ring, 5);
 	if (r) {
-		dev_err(adev->dev,
-			"amdgpu: cp failed to lock ring %d (%d).\n",
+		drm_err(adev_to_drm(adev),
+			"cp failed to lock ring %d (%d).\n",
 			ring->idx, r);
 		return r;
 	}
@@ -518,7 +518,7 @@ static int gfx_v12_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	r = amdgpu_ib_get(adev, NULL, 16, AMDGPU_IB_POOL_DIRECT, &ib);
 	if (r) {
-		dev_err(adev->dev, "amdgpu: failed to get ib (%ld).\n", r);
+		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
 		goto err1;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 63e6924a1f223..fd89fb5028a50 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -2010,7 +2010,7 @@ static int gfx_v6_0_cp_gfx_start(struct amdgpu_device *adev)
 
 	r = amdgpu_ring_alloc(ring, 7 + 4);
 	if (r) {
-		DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
+		drm_err(adev_to_drm(adev), "cp failed to lock ring (%d).\n", r);
 		return r;
 	}
 	amdgpu_ring_write(ring, PACKET3(PACKET3_ME_INITIALIZE, 5));
@@ -2031,7 +2031,7 @@ static int gfx_v6_0_cp_gfx_start(struct amdgpu_device *adev)
 
 	r = amdgpu_ring_alloc(ring, gfx_v6_0_get_csb_size(adev) + 10);
 	if (r) {
-		DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
+		drm_err(adev_to_drm(adev), "cp failed to lock ring (%d).\n", r);
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
index 2fa3a37a26542..2b691452775bc 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c
@@ -2465,7 +2465,7 @@ static int gfx_v7_0_cp_gfx_start(struct amdgpu_device *adev)
 
 	r = amdgpu_ring_alloc(ring, gfx_v7_0_get_csb_size(adev) + 8);
 	if (r) {
-		DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
+		drm_err(adev_to_drm(adev), "cp failed to lock ring (%d).\n", r);
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 4e285ed5afaca..028ae5fbdb405 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -1509,7 +1509,7 @@ static int gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	r = amdgpu_ib_get(adev, NULL, total_size,
 					AMDGPU_IB_POOL_DIRECT, &ib);
 	if (r) {
-		DRM_ERROR("amdgpu: failed to get ib (%d).\n", r);
+		drm_err(adev_to_drm(adev), "failed to get ib (%d).\n", r);
 		return r;
 	}
 
@@ -1604,14 +1604,14 @@ static int gfx_v8_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	/* shedule the ib on the ring */
 	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
 	if (r) {
-		DRM_ERROR("amdgpu: ib submit failed (%d).\n", r);
+		drm_err(adev_to_drm(adev), "ib submit failed (%d).\n", r);
 		goto fail;
 	}
 
 	/* wait for the GPU to finish processing the IB */
 	r = dma_fence_wait(f, false);
 	if (r) {
-		DRM_ERROR("amdgpu: fence wait failed (%d).\n", r);
+		drm_err(adev_to_drm(adev), "fence wait failed (%d).\n", r);
 		goto fail;
 	}
 
@@ -4143,7 +4143,7 @@ static int gfx_v8_0_cp_gfx_start(struct amdgpu_device *adev)
 
 	r = amdgpu_ring_alloc(ring, gfx_v8_0_get_csb_size(adev) + 4);
 	if (r) {
-		DRM_ERROR("amdgpu: cp failed to lock ring (%d).\n", r);
+		drm_err(adev_to_drm(adev), "cp failed to lock ring (%d).\n", r);
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
index 4eadcf58804a7..e7bc93bb8845e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c
@@ -4582,7 +4582,7 @@ static int gfx_v9_0_do_edc_gds_workarounds(struct amdgpu_device *adev)
 
 	r = amdgpu_ring_alloc(ring, 7);
 	if (r) {
-		DRM_ERROR("amdgpu: GDS workarounds failed to lock ring %s (%d).\n",
+		drm_err(adev_to_drm(adev), "GDS workarounds failed to lock ring %s (%d).\n",
 			ring->name, r);
 		return r;
 	}
@@ -4671,7 +4671,7 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	r = amdgpu_ib_get(adev, NULL, total_size,
 					AMDGPU_IB_POOL_DIRECT, &ib);
 	if (r) {
-		DRM_ERROR("amdgpu: failed to get ib (%d).\n", r);
+		drm_err(adev_to_drm(adev), "failed to get ib (%d).\n", r);
 		return r;
 	}
 
@@ -4772,14 +4772,14 @@ static int gfx_v9_0_do_edc_gpr_workarounds(struct amdgpu_device *adev)
 	/* shedule the ib on the ring */
 	r = amdgpu_ib_schedule(ring, 1, &ib, NULL, &f);
 	if (r) {
-		DRM_ERROR("amdgpu: ib submit failed (%d).\n", r);
+		drm_err(adev_to_drm(adev), "ib schedule failed (%d).\n", r);
 		goto fail;
 	}
 
 	/* wait for the GPU to finish processing the IB */
 	r = dma_fence_wait(f, false);
 	if (r) {
-		DRM_ERROR("amdgpu: fence wait failed (%d).\n", r);
+		drm_err(adev_to_drm(adev), "fence wait failed (%d).\n", r);
 		goto fail;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
index 0b385a15194d9..2bbb2ff7cb0a6 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v10_0.c
@@ -850,7 +850,7 @@ static int gmc_v10_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
 	if (r) {
-		dev_warn(adev->dev, "amdgpu: No suitable DMA available.\n");
+		drm_warn(adev_to_drm(adev), "No suitable DMA available.\n");
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
index 7a1f0742754a6..81e96f88f9712 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v11_0.c
@@ -821,7 +821,7 @@ static int gmc_v11_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
 	if (r) {
-		dev_warn(adev->dev, "amdgpu: No suitable DMA available.\n");
+		drm_warn(adev_to_drm(adev), "No suitable DMA available.\n");
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
index 90c5159a5a85b..ada821f2e65da 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v12_0.c
@@ -869,7 +869,7 @@ static int gmc_v12_0_sw_init(struct amdgpu_ip_block *ip_block)
 
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(44));
 	if (r) {
-		printk(KERN_WARNING "amdgpu: No suitable DMA available.\n");
+		drm_warn(adev_to_drm(adev), "No suitable DMA available.\n");
 		return r;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 97a04e3171f2d..b0421b261e747 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -1975,7 +1975,7 @@ static int gmc_v9_0_sw_init(struct amdgpu_ip_block *ip_block)
 				44;
 	r = dma_set_mask_and_coherent(adev->dev, DMA_BIT_MASK(dma_addr_bits));
 	if (r) {
-		dev_warn(adev->dev, "amdgpu: No suitable DMA available.\n");
+		drm_warn(adev_to_drm(adev), "No suitable DMA available.\n");
 		return r;
 	}
 	adev->need_swiotlb = drm_need_swiotlb(dma_addr_bits);
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
index 27c76bd424cfb..923369ece0d10 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v2_0.c
@@ -271,7 +271,7 @@ static int jpeg_v2_0_enable_power_gating(struct amdgpu_device *adev)
 			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
 
 		if (r) {
-			DRM_ERROR("amdgpu: JPEG enable power gating failed\n");
+			drm_err(adev_to_drm(adev), "failed to enable JPEG power gating\n");
 			return r;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
index d1a011c40ba23..98f5e0622bc58 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -298,7 +298,7 @@ static int jpeg_v3_0_disable_static_power_gating(struct amdgpu_device *adev)
 			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
 
 		if (r) {
-			DRM_ERROR("amdgpu: JPEG disable power gating failed\n");
+			drm_err(adev_to_drm(adev), "failed to disable JPEG power gating\n");
 			return r;
 		}
 	}
@@ -333,7 +333,7 @@ static int jpeg_v3_0_enable_static_power_gating(struct amdgpu_device *adev)
 			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
 
 		if (r) {
-			DRM_ERROR("amdgpu: JPEG enable power gating failed\n");
+			drm_err(adev_to_drm(adev), "failed to enable JPEG power gating\n");
 			return r;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
index 33db2c1ae6cca..0bd83820dd20c 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v4_0.c
@@ -335,7 +335,7 @@ static int jpeg_v4_0_disable_static_power_gating(struct amdgpu_device *adev)
 			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
 
 		if (r) {
-			DRM_DEV_ERROR(adev->dev, "amdgpu: JPEG disable power gating failed\n");
+			drm_err(adev_to_drm(adev), "failed to disable JPEG power gating\n");
 			return r;
 		}
 	}
@@ -370,7 +370,7 @@ static int jpeg_v4_0_enable_static_power_gating(struct amdgpu_device *adev)
 			UVD_PGFSM_STATUS__UVDJ_PWR_STATUS_MASK);
 
 		if (r) {
-			DRM_DEV_ERROR(adev->dev, "amdgpu: JPEG enable power gating failed\n");
+			drm_err(adev_to_drm(adev), "failed to enable JPEG power gating\n");
 			return r;
 		}
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
index 8ddc4df06a1fd..7811cbb1f7ba3 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c
@@ -1031,7 +1031,7 @@ static int sdma_v5_0_ring_test_ring(struct amdgpu_ring *ring)
 
 	r = amdgpu_ring_alloc(ring, 20);
 	if (r) {
-		DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, r);
+		drm_err(adev_to_drm(adev), "dma failed to lock ring %d (%d).\n", ring->idx, r);
 		amdgpu_device_wb_free(adev, index);
 		return r;
 	}
@@ -1096,7 +1096,7 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 	r = amdgpu_ib_get(adev, NULL, 256,
 			  AMDGPU_IB_POOL_DIRECT, &ib);
 	if (r) {
-		DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
+		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
 		goto err0;
 	}
 
@@ -1117,11 +1117,11 @@ static int sdma_v5_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
-		DRM_ERROR("amdgpu: IB test timed out\n");
+		drm_err(adev_to_drm(adev), "IB test timed out\n");
 		r = -ETIMEDOUT;
 		goto err1;
 	} else if (r < 0) {
-		DRM_ERROR("amdgpu: fence wait failed (%ld).\n", r);
+		drm_err(adev_to_drm(adev), "fence wait failed (%ld).\n", r);
 		goto err1;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 51101b0aa2fab..68370a55b7856 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -931,7 +931,7 @@ static int sdma_v5_2_ring_test_ring(struct amdgpu_ring *ring)
 
 	r = amdgpu_ring_alloc(ring, 20);
 	if (r) {
-		DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, r);
+		drm_err(adev_to_drm(adev), "dma failed to lock ring %d (%d).\n", ring->idx, r);
 		amdgpu_device_wb_free(adev, index);
 		return r;
 	}
@@ -995,7 +995,7 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
 	if (r) {
-		DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
+		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
 		goto err0;
 	}
 
@@ -1016,11 +1016,11 @@ static int sdma_v5_2_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
-		DRM_ERROR("amdgpu: IB test timed out\n");
+		drm_err(adev_to_drm(adev), "IB test timed out\n");
 		r = -ETIMEDOUT;
 		goto err1;
 	} else if (r < 0) {
-		DRM_ERROR("amdgpu: fence wait failed (%ld).\n", r);
+		drm_err(adev_to_drm(adev), "fence wait failed (%ld).\n", r);
 		goto err1;
 	}
 
@@ -1325,7 +1325,7 @@ static int sdma_v5_2_sw_init(struct amdgpu_ip_block *ip_block)
 		ring->use_doorbell = true;
 		ring->me = i;
 
-		DRM_INFO("use_doorbell being set to: [%s]\n",
+		drm_info(adev_to_drm(adev), "use_doorbell being set to: [%s]\n",
 				ring->use_doorbell?"true":"false");
 
 		ring->doorbell_index =
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
index f38c2bdd01e3c..38bc87fd90bc5 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c
@@ -937,7 +937,7 @@ static int sdma_v6_0_ring_test_ring(struct amdgpu_ring *ring)
 
 	r = amdgpu_ring_alloc(ring, 5);
 	if (r) {
-		DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, r);
+		drm_err(adev_to_drm(adev), "dma failed to lock ring %d (%d).\n", ring->idx, r);
 		amdgpu_device_wb_free(adev, index);
 		return r;
 	}
@@ -1001,7 +1001,7 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
 	if (r) {
-		DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
+		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
 		goto err0;
 	}
 
@@ -1022,11 +1022,11 @@ static int sdma_v6_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
-		DRM_ERROR("amdgpu: IB test timed out\n");
+		drm_err(adev_to_drm(adev), "IB test timed out\n");
 		r = -ETIMEDOUT;
 		goto err1;
 	} else if (r < 0) {
-		DRM_ERROR("amdgpu: fence wait failed (%ld).\n", r);
+		drm_err(adev_to_drm(adev), "fence wait failed (%ld).\n", r);
 		goto err1;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
index d2a09e7a1bc27..8d16ef257bcb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v7_0.c
@@ -954,7 +954,7 @@ static int sdma_v7_0_ring_test_ring(struct amdgpu_ring *ring)
 
 	r = amdgpu_ring_alloc(ring, 5);
 	if (r) {
-		DRM_ERROR("amdgpu: dma failed to lock ring %d (%d).\n", ring->idx, r);
+		drm_err(adev_to_drm(adev), "dma failed to lock ring %d (%d).\n", ring->idx, r);
 		amdgpu_device_wb_free(adev, index);
 		return r;
 	}
@@ -1018,7 +1018,7 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	r = amdgpu_ib_get(adev, NULL, 256, AMDGPU_IB_POOL_DIRECT, &ib);
 	if (r) {
-		DRM_ERROR("amdgpu: failed to get ib (%ld).\n", r);
+		drm_err(adev_to_drm(adev), "failed to get ib (%ld).\n", r);
 		goto err0;
 	}
 
@@ -1039,11 +1039,11 @@ static int sdma_v7_0_ring_test_ib(struct amdgpu_ring *ring, long timeout)
 
 	r = dma_fence_wait_timeout(f, false, timeout);
 	if (r == 0) {
-		DRM_ERROR("amdgpu: IB test timed out\n");
+		drm_err(adev_to_drm(adev), "IB test timed out\n");
 		r = -ETIMEDOUT;
 		goto err1;
 	} else if (r < 0) {
-		DRM_ERROR("amdgpu: fence wait failed (%ld).\n", r);
+		drm_err(adev_to_drm(adev), "fence wait failed (%ld).\n", r);
 		goto err1;
 	}
 
@@ -1504,7 +1504,7 @@ static int sdma_v7_0_ring_preempt_ib(struct amdgpu_ring *ring)
 	ring->trail_seq += 1;
 	r = amdgpu_ring_alloc(ring, 10);
 	if (r) {
-		DRM_ERROR("ring %d failed to be allocated \n", ring->idx);
+		DRM_ERROR("ring %d failed to be allocated\n", ring->idx);
 		return r;
 	}
 	sdma_v7_0_ring_emit_fence(ring, ring->trail_fence_gpu_addr,
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
index 2e79a3afc7748..fea576a7f397f 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v3_1.c
@@ -660,7 +660,7 @@ static int uvd_v3_1_hw_init(struct amdgpu_ip_block *ip_block)
 
 	r = uvd_v3_1_fw_validate(adev);
 	if (r) {
-		DRM_ERROR("amdgpu: UVD Firmware validate fail (%d).\n", r);
+		drm_err(adev_to_drm(adev), "UVD Firmware validate fail (%d).\n", r);
 		return r;
 	}
 
@@ -668,13 +668,13 @@ static int uvd_v3_1_hw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_ring_test_helper(ring);
 	if (r) {
-		DRM_ERROR("amdgpu: UVD ring test fail (%d).\n", r);
+		drm_err(adev_to_drm(adev), "UVD ring test failed (%d).\n", r);
 		goto done;
 	}
 
 	r = amdgpu_ring_alloc(ring, 10);
 	if (r) {
-		DRM_ERROR("amdgpu: ring failed to lock UVD ring (%d).\n", r);
+		drm_err(adev_to_drm(adev), "ring alloc failed (%d).\n", r);
 		goto done;
 	}
 
@@ -701,7 +701,7 @@ static int uvd_v3_1_hw_init(struct amdgpu_ip_block *ip_block)
 
 done:
 	if (!r)
-		DRM_INFO("UVD initialized successfully.\n");
+		drm_info(adev_to_drm(adev), "UVD initialized successfully.\n");
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
index 4b96fd5837720..73ce3d211ed64 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c
@@ -167,7 +167,7 @@ static int uvd_v4_2_hw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_ring_alloc(ring, 10);
 	if (r) {
-		DRM_ERROR("amdgpu: ring failed to lock UVD ring (%d).\n", r);
+		drm_err(adev_to_drm(adev), "ring alloc failed (%d).\n", r);
 		goto done;
 	}
 
@@ -194,7 +194,7 @@ static int uvd_v4_2_hw_init(struct amdgpu_ip_block *ip_block)
 
 done:
 	if (!r)
-		DRM_INFO("UVD initialized successfully.\n");
+		drm_info(adev_to_drm(adev), "UVD initialized successfully.\n");
 
 	return r;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
index 71409ad8b7ed1..12b1b1c9ed66a 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c
@@ -164,7 +164,7 @@ static int uvd_v5_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_ring_alloc(ring, 10);
 	if (r) {
-		DRM_ERROR("amdgpu: ring failed to lock UVD ring (%d).\n", r);
+		drm_err(adev_to_drm(adev), "ring alloc failed (%d).\n", r);
 		goto done;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
index ceb94bbb03a48..a1d29fae331b4 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v6_0.c
@@ -478,7 +478,7 @@ static int uvd_v6_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 	r = amdgpu_ring_alloc(ring, 10);
 	if (r) {
-		DRM_ERROR("amdgpu: ring failed to lock UVD ring (%d).\n", r);
+		drm_err(adev_to_drm(adev), "ring alloc failed (%d).\n", r);
 		goto done;
 	}
 
diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
index 1f8866f3f63c7..89d9637a2401f 100644
--- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -542,7 +542,7 @@ static int uvd_v7_0_hw_init(struct amdgpu_ip_block *ip_block)
 
 			r = amdgpu_ring_alloc(ring, 10);
 			if (r) {
-				DRM_ERROR("amdgpu: (%d)ring failed to lock UVD ring (%d).\n", j, r);
+				drm_err(adev_to_drm(adev), "ring alloc failed (%d).\n", r);
 				goto done;
 			}
 
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0346052f2e574..f889270044255 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -2098,7 +2098,7 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		drm_err(adev_to_drm(adev),
 		"failed to initialize freesync_module.\n");
 	} else
-		drm_dbg_driver(adev_to_drm(adev), "amdgpu: freesync_module init done %p.\n",
+		drm_dbg_driver(adev_to_drm(adev), "freesync_module init done %p.\n",
 				adev->dm.freesync_module);
 
 	amdgpu_dm_init_color_mod();
@@ -2120,7 +2120,9 @@ static int amdgpu_dm_init(struct amdgpu_device *adev)
 		if (!adev->dm.hdcp_workqueue)
 			drm_err(adev_to_drm(adev), "failed to initialize hdcp_workqueue.\n");
 		else
-			drm_dbg_driver(adev_to_drm(adev), "amdgpu: hdcp_workqueue init done %p.\n", adev->dm.hdcp_workqueue);
+			drm_dbg_driver(adev_to_drm(adev),
+				       "hdcp_workqueue init done %p.\n",
+				       adev->dm.hdcp_workqueue);
 
 		dc_init_callbacks(adev->dm.dc, &init_params);
 	}
-- 
2.43.0


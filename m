Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55547C79F9E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 20:33:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E566410E912;
	Mon,  7 Sep 2026 20:33:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ew7hvkCH";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8914F10E912
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 20:33:53 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-484392e3d33so2741763f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Sep 2026 13:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788813232; x=1789418032; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ECUdLs0aNINiE1wZXRrbCrHk81QZfxhJr+3Qf9oLlY4=;
 b=ew7hvkCHU8fqAUwmjB8Y0P1E3ROyqcYJHwvkTE7srMRxXcutoOkP7VPYtNJLyn5lBM
 /FN6pkcdbgSZGV6jUVdBwcVl8ROzjFzvurIEDWbBAFUzc+PqasVvd2kgp9e0R/l+9C2g
 wmP0L4xXS+TSZ5dEvvT3R3W1y/l8KB+32iuYZKiHeQVpihNMApwYo7yN5xly+uJ3QYm0
 8mpd08p8a4komjrvMLPcngBr5iC8BUTHTeAprHETfWGsTH8c8mqnOThBJBh3gYCOjzWn
 LHoQZ+jss5pxRftJyCfJMyX8819oDtxPvvfEP8NLG+u9eoScp5AQlQ3/w++pAY7KDWXC
 /5uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788813232; x=1789418032;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ECUdLs0aNINiE1wZXRrbCrHk81QZfxhJr+3Qf9oLlY4=;
 b=BBKYYAmaHQ7pMcYf/shU0cQiXiKCHAGSEFgTI2H8TBzFJKQMx94UxZeT9jp6Df8RsT
 H9WWZFkHQrUVxCL9n3GbrbivqargiLDLZBjYelXpGHh2gNmsRcu0Ogoam9Cs2VpcJb7C
 eL4/NouJMHNIGKBrx38Vubel2qRXzj51wDZ/hZ8+fdjwLgQKmuf+113+zObasC/jRrzg
 ofxDJYksicFtO3DZVscCl/JinzCsU2LwzzpHeUC0aj0WluZJ0Gpvt7nVJX6Gr0vxuHgf
 r2enCwquguYMzL9RxVHNbMJa5gOYbCEpGjciMMPsRBwveZAxFTLbYuLY1MAijUd4bvw6
 S2jQ==
X-Gm-Message-State: AFuF++lvGv0Nx7gRBuTZ2SgDnxZFNvB9M7/NGJeyhIMgpGavdww2Z8je
 NGNwomXtJTgYcw8p0MtYyvBls4XATg4Hdw2QyxulWGL+cm+NKS3fVssdkUxlIXmH
X-Gm-Gg: AYBFou2vuwC9MRRyjRI2tqcvlErM4cqMJtzYnfmRG0p//rT88P7YVlsQNOJpA5wzJjL
 zbuPtckOEPnfEiCH5t55c+BiOiWI3wianjf7eIKfengiI2qT3Es1Q2WDn4htERPsiM87feYZLox
 j3uNwqr3KDIOiAp8WWMLQZfu72EYuWUwL1Gm6bz8ZuzV9Ek9jW55DY5EoD5VhUFrdkJr2gvhUDZ
 Ix+XDkobh/euU/KFSMIK317J1jB+UXC5a1GTK1OZVRQa4kjGd6FlTZvVQuNSxRsxH+yrMnsbBS8
 kSzMZCkn7ozeNqO1ehR/VVpQvhV0qKdBxLK4lo8XzRMtudZN6WhUDUZbKiC/ztE/Rl3n7Gzds5R
 zFuzW8YvVEotTrASOsW75LviW1wEX2Cr3106gTh/ChSzJIreMVj2SudRztw05OUzX8HSF0QqNrP
 LruEHvlL7w8r4vK5xzr6c4WEuufC1OWW7a3LkxTGNtucE0T7ScP2pGxj7ZEa2JFZ1V1aRR96igQ
 R2+MzycA39ZScS+ZA/a
X-Received: by 2002:a05:6000:41c7:b0:485:8112:cff1 with SMTP id
 ffacd0b85a97d-485872c24c3mr27315027f8f.27.1788813231828; 
 Mon, 07 Sep 2026 13:33:51 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48594172546sm22191354f8f.15.2026.09.07.13.33.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 13:33:51 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 07/12] drm/amdgpu/sdma: Refactor SDMA v3.0 functions to be per
 instance
Date: Mon,  7 Sep 2026 22:33:11 +0200
Message-ID: <20260907203316.159103-8-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907203316.159103-1-timur.kristof@gmail.com>
References: <20260907203316.159103-1-timur.kristof@gmail.com>
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

This prepares the code for implementing recovery for SDMA 3.0.

Reorganize the SDMA 3.0 code so that the functions that are
responsible for managing the SDMA engines take an instance ID
as an argument.

This makes it possible to manage the SDMA instances
independently of each other, which will enable us to
also use these functions to implement resetting and
recovering them independently.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c | 298 +++++++++++++------------
 1 file changed, 155 insertions(+), 143 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
index e929d62721b3..6213a0c77590 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v3_0.c
@@ -508,36 +508,38 @@ static void sdma_v3_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
  * sdma_v3_0_gfx_stop - stop the gfx async dma engines
  *
  * @adev: amdgpu_device pointer
+ * @instance_id: SDMA engine instance ID
  *
  * Stop the gfx async dma ring buffers (VI).
  */
-static void sdma_v3_0_gfx_stop(struct amdgpu_device *adev)
+static void sdma_v3_0_gfx_stop(struct amdgpu_device *adev, const u32 instance_id)
 {
+	const u32 reg_offset = sdma_offsets[instance_id];
 	u32 rb_cntl, ib_cntl;
-	int i;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		rb_cntl = RREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i]);
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
-		WREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i], rb_cntl);
-		ib_cntl = RREG32(mmSDMA0_GFX_IB_CNTL + sdma_offsets[i]);
-		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 0);
-		WREG32(mmSDMA0_GFX_IB_CNTL + sdma_offsets[i], ib_cntl);
-	}
+	rb_cntl = RREG32(mmSDMA0_GFX_RB_CNTL + reg_offset);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 0);
+	WREG32(mmSDMA0_GFX_RB_CNTL + reg_offset, rb_cntl);
+	ib_cntl = RREG32(mmSDMA0_GFX_IB_CNTL + reg_offset);
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 0);
+	WREG32(mmSDMA0_GFX_IB_CNTL + reg_offset, ib_cntl);
 }
 
 /**
  * sdma_v3_0_ctx_switch_enable - stop the async dma engines context switch
  *
  * @adev: amdgpu_device pointer
+ * @instance_id: SDMA engine instance ID
  * @enable: enable/disable the DMA MEs context switch.
  *
  * Halt or unhalt the async dma engines context switch (VI).
  */
-static void sdma_v3_0_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
+static void sdma_v3_0_ctx_switch_enable(struct amdgpu_device *adev,
+					const u32 instance_id,
+					const bool enable)
 {
+	const u32 reg_offset = sdma_offsets[instance_id];
 	u32 f32_cntl, phase_quantum = 0;
-	int i;
 
 	if (amdgpu_sdma_phase_quantum) {
 		unsigned value = amdgpu_sdma_phase_quantum;
@@ -563,206 +565,212 @@ static void sdma_v3_0_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
 			unit  << SDMA0_PHASE0_QUANTUM__UNIT__SHIFT;
 	}
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		f32_cntl = RREG32(mmSDMA0_CNTL + sdma_offsets[i]);
-		if (enable) {
-			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
-					AUTO_CTXSW_ENABLE, 1);
-			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
-					ATC_L1_ENABLE, 1);
-			if (amdgpu_sdma_phase_quantum) {
-				WREG32(mmSDMA0_PHASE0_QUANTUM + sdma_offsets[i],
-				       phase_quantum);
-				WREG32(mmSDMA0_PHASE1_QUANTUM + sdma_offsets[i],
-				       phase_quantum);
-			}
-		} else {
-			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
-					AUTO_CTXSW_ENABLE, 0);
-			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
-					ATC_L1_ENABLE, 1);
+	f32_cntl = RREG32(mmSDMA0_CNTL + reg_offset);
+	if (enable) {
+		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
+				AUTO_CTXSW_ENABLE, 1);
+		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
+				ATC_L1_ENABLE, 1);
+		if (amdgpu_sdma_phase_quantum) {
+			WREG32(mmSDMA0_PHASE0_QUANTUM + reg_offset,
+				phase_quantum);
+			WREG32(mmSDMA0_PHASE1_QUANTUM + reg_offset,
+				phase_quantum);
 		}
-
-		WREG32(mmSDMA0_CNTL + sdma_offsets[i], f32_cntl);
+	} else {
+		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
+				AUTO_CTXSW_ENABLE, 0);
+		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
+				ATC_L1_ENABLE, 1);
 	}
+
+	WREG32(mmSDMA0_CNTL + reg_offset, f32_cntl);
 }
 
 /**
  * sdma_v3_0_enable - stop the async dma engines
  *
  * @adev: amdgpu_device pointer
+ * @instance_id: SDMA engine instance ID
  * @enable: enable/disable the DMA MEs.
  *
  * Halt or unhalt the async dma engines (VI).
  */
-static void sdma_v3_0_enable(struct amdgpu_device *adev, bool enable)
+static void sdma_v3_0_enable(struct amdgpu_device *adev,
+			     const u32 instance_id,
+			     const bool enable)
 {
+	const u32 reg_offset = sdma_offsets[instance_id];
 	u32 f32_cntl;
-	int i;
 
 	if (!enable) {
-		sdma_v3_0_gfx_stop(adev);
+		sdma_v3_0_gfx_stop(adev, instance_id);
 	}
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		f32_cntl = RREG32(mmSDMA0_F32_CNTL + sdma_offsets[i]);
-		if (enable)
-			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 0);
-		else
-			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
-		WREG32(mmSDMA0_F32_CNTL + sdma_offsets[i], f32_cntl);
-	}
+	f32_cntl = RREG32(mmSDMA0_F32_CNTL + reg_offset);
+	if (enable)
+		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 0);
+	else
+		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
+	WREG32(mmSDMA0_F32_CNTL + reg_offset, f32_cntl);
 }
 
 /**
  * sdma_v3_0_gfx_resume - setup and start the async dma engines
  *
  * @adev: amdgpu_device pointer
+ * @instance_id: SDMA engine instance ID
  *
  * Set up the gfx DMA ring buffers and enable them (VI).
  * Returns 0 for success, error for failure.
  */
-static int sdma_v3_0_gfx_resume(struct amdgpu_device *adev)
+static int sdma_v3_0_gfx_resume(struct amdgpu_device *adev, const u32 instance_id)
 {
-	struct amdgpu_ring *ring;
+	struct amdgpu_ring *const ring = &adev->sdma.instance[instance_id].ring;
+	const u32 reg_offset = sdma_offsets[instance_id];
 	u32 rb_cntl, ib_cntl, wptr_poll_cntl;
 	u32 rb_bufsz;
 	u32 doorbell;
 	u64 wptr_gpu_addr;
-	int i, j, r;
+	int j;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		ring = &adev->sdma.instance[i].ring;
-		amdgpu_ring_clear_ring(ring);
-
-		mutex_lock(&adev->srbm_mutex);
-		for (j = 0; j < 16; j++) {
-			vi_srbm_select(adev, 0, 0, 0, j);
-			/* SDMA GFX */
-			WREG32(mmSDMA0_GFX_VIRTUAL_ADDR + sdma_offsets[i], 0);
-			WREG32(mmSDMA0_GFX_APE1_CNTL + sdma_offsets[i], 0);
-		}
-		vi_srbm_select(adev, 0, 0, 0, 0);
-		mutex_unlock(&adev->srbm_mutex);
+	amdgpu_ring_clear_ring(ring);
 
-		WREG32(mmSDMA0_TILING_CONFIG + sdma_offsets[i],
-		       adev->gfx.config.gb_addr_config & 0x70);
+	mutex_lock(&adev->srbm_mutex);
+	for (j = 0; j < 16; j++) {
+		vi_srbm_select(adev, 0, 0, 0, j);
+		/* SDMA GFX */
+		WREG32(mmSDMA0_GFX_VIRTUAL_ADDR + reg_offset, 0);
+		WREG32(mmSDMA0_GFX_APE1_CNTL + reg_offset, 0);
+	}
+	vi_srbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
+
+	WREG32(mmSDMA0_TILING_CONFIG + reg_offset,
+		adev->gfx.config.gb_addr_config & 0x70);
 
-		WREG32(mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL + sdma_offsets[i], 0);
+	WREG32(mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL + reg_offset, 0);
 
-		/* Set ring buffer size in dwords */
-		rb_bufsz = order_base_2(ring->ring_size / 4);
-		rb_cntl = RREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i]);
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SIZE, rb_bufsz);
+	/* Set ring buffer size in dwords */
+	rb_bufsz = order_base_2(ring->ring_size / 4);
+	rb_cntl = RREG32(mmSDMA0_GFX_RB_CNTL + reg_offset);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SIZE, rb_bufsz);
 #ifdef __BIG_ENDIAN
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SWAP_ENABLE, 1);
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL,
-					RPTR_WRITEBACK_SWAP_ENABLE, 1);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_SWAP_ENABLE, 1);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL,
+				RPTR_WRITEBACK_SWAP_ENABLE, 1);
 #endif
-		WREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i], rb_cntl);
+	WREG32(mmSDMA0_GFX_RB_CNTL + reg_offset, rb_cntl);
 
-		/* Initialize the ring buffer's read and write pointers */
-		ring->wptr = 0;
-		WREG32(mmSDMA0_GFX_RB_RPTR + sdma_offsets[i], 0);
-		sdma_v3_0_ring_set_wptr(ring);
-		WREG32(mmSDMA0_GFX_IB_RPTR + sdma_offsets[i], 0);
-		WREG32(mmSDMA0_GFX_IB_OFFSET + sdma_offsets[i], 0);
+	/* Initialize the ring buffer's read and write pointers */
+	ring->wptr = 0;
+	WREG32(mmSDMA0_GFX_RB_RPTR + reg_offset, 0);
+	sdma_v3_0_ring_set_wptr(ring);
+	WREG32(mmSDMA0_GFX_IB_RPTR + reg_offset, 0);
+	WREG32(mmSDMA0_GFX_IB_OFFSET + reg_offset, 0);
 
-		/* set the wb address whether it's enabled or not */
-		WREG32(mmSDMA0_GFX_RB_RPTR_ADDR_HI + sdma_offsets[i],
-		       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
-		WREG32(mmSDMA0_GFX_RB_RPTR_ADDR_LO + sdma_offsets[i],
-		       lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
+	/* set the wb address whether it's enabled or not */
+	WREG32(mmSDMA0_GFX_RB_RPTR_ADDR_HI + reg_offset,
+		upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
+	WREG32(mmSDMA0_GFX_RB_RPTR_ADDR_LO + reg_offset,
+		lower_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFC);
 
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RPTR_WRITEBACK_ENABLE, 1);
 
-		WREG32(mmSDMA0_GFX_RB_BASE + sdma_offsets[i], ring->gpu_addr >> 8);
-		WREG32(mmSDMA0_GFX_RB_BASE_HI + sdma_offsets[i], ring->gpu_addr >> 40);
+	WREG32(mmSDMA0_GFX_RB_BASE + reg_offset, ring->gpu_addr >> 8);
+	WREG32(mmSDMA0_GFX_RB_BASE_HI + reg_offset, ring->gpu_addr >> 40);
 
-		doorbell = RREG32(mmSDMA0_GFX_DOORBELL + sdma_offsets[i]);
+	doorbell = RREG32(mmSDMA0_GFX_DOORBELL + reg_offset);
 
-		if (ring->use_doorbell) {
-			doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL,
-						 OFFSET, ring->doorbell_index);
-			doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, ENABLE, 1);
-		} else {
-			doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, ENABLE, 0);
-		}
-		WREG32(mmSDMA0_GFX_DOORBELL + sdma_offsets[i], doorbell);
-
-		/* setup the wptr shadow polling */
-		wptr_gpu_addr = ring->wptr_gpu_addr;
-
-		WREG32(mmSDMA0_GFX_RB_WPTR_POLL_ADDR_LO + sdma_offsets[i],
-		       lower_32_bits(wptr_gpu_addr));
-		WREG32(mmSDMA0_GFX_RB_WPTR_POLL_ADDR_HI + sdma_offsets[i],
-		       upper_32_bits(wptr_gpu_addr));
-		wptr_poll_cntl = RREG32(mmSDMA0_GFX_RB_WPTR_POLL_CNTL + sdma_offsets[i]);
-		if (ring->use_pollmem) {
-			/*wptr polling is not enough fast, directly clean the wptr register */
-			WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], 0);
-			wptr_poll_cntl = REG_SET_FIELD(wptr_poll_cntl,
-						       SDMA0_GFX_RB_WPTR_POLL_CNTL,
-						       ENABLE, 1);
-		} else {
-			wptr_poll_cntl = REG_SET_FIELD(wptr_poll_cntl,
-						       SDMA0_GFX_RB_WPTR_POLL_CNTL,
-						       ENABLE, 0);
-		}
-		WREG32(mmSDMA0_GFX_RB_WPTR_POLL_CNTL + sdma_offsets[i], wptr_poll_cntl);
+	if (ring->use_doorbell) {
+		doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL,
+						OFFSET, ring->doorbell_index);
+		doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, ENABLE, 1);
+	} else {
+		doorbell = REG_SET_FIELD(doorbell, SDMA0_GFX_DOORBELL, ENABLE, 0);
+	}
+	WREG32(mmSDMA0_GFX_DOORBELL + reg_offset, doorbell);
+
+	/* setup the wptr shadow polling */
+	wptr_gpu_addr = ring->wptr_gpu_addr;
+
+	WREG32(mmSDMA0_GFX_RB_WPTR_POLL_ADDR_LO + reg_offset,
+		lower_32_bits(wptr_gpu_addr));
+	WREG32(mmSDMA0_GFX_RB_WPTR_POLL_ADDR_HI + reg_offset,
+		upper_32_bits(wptr_gpu_addr));
+	wptr_poll_cntl = RREG32(mmSDMA0_GFX_RB_WPTR_POLL_CNTL + reg_offset);
+	if (ring->use_pollmem) {
+		/*wptr polling is not enough fast, directly clean the wptr register */
+		WREG32(mmSDMA0_GFX_RB_WPTR + reg_offset, 0);
+		wptr_poll_cntl = REG_SET_FIELD(wptr_poll_cntl,
+						SDMA0_GFX_RB_WPTR_POLL_CNTL,
+						ENABLE, 1);
+	} else {
+		wptr_poll_cntl = REG_SET_FIELD(wptr_poll_cntl,
+						SDMA0_GFX_RB_WPTR_POLL_CNTL,
+						ENABLE, 0);
+	}
+	WREG32(mmSDMA0_GFX_RB_WPTR_POLL_CNTL + reg_offset, wptr_poll_cntl);
 
-		/* enable DMA RB */
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 1);
-		WREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i], rb_cntl);
+	/* enable DMA RB */
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, 1);
+	WREG32(mmSDMA0_GFX_RB_CNTL + reg_offset, rb_cntl);
 
-		ib_cntl = RREG32(mmSDMA0_GFX_IB_CNTL + sdma_offsets[i]);
-		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 1);
+	ib_cntl = RREG32(mmSDMA0_GFX_IB_CNTL + reg_offset);
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, 1);
 #ifdef __BIG_ENDIAN
-		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_SWAP_ENABLE, 1);
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_SWAP_ENABLE, 1);
 #endif
-		/* enable DMA IBs */
-		WREG32(mmSDMA0_GFX_IB_CNTL + sdma_offsets[i], ib_cntl);
-	}
+	/* enable DMA IBs */
+	WREG32(mmSDMA0_GFX_IB_CNTL + reg_offset, ib_cntl);
 
 	/* unhalt the MEs */
-	sdma_v3_0_enable(adev, true);
+	sdma_v3_0_enable(adev, instance_id, true);
 	/* enable sdma ring preemption */
-	sdma_v3_0_ctx_switch_enable(adev, true);
+	sdma_v3_0_ctx_switch_enable(adev, instance_id, true);
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		ring = &adev->sdma.instance[i].ring;
-		r = amdgpu_ring_test_helper(ring);
-		if (r)
-			return r;
-	}
-
-	return 0;
+	return amdgpu_ring_test_helper(ring);
 }
 
 /**
  * sdma_v3_0_start - setup and start the async dma engines
  *
  * @adev: amdgpu_device pointer
+ * @instance_id: SDMA engine instance ID
  *
  * Set up the DMA engines and enable them (VI).
  * Returns 0 for success, error for failure.
  */
-static int sdma_v3_0_start(struct amdgpu_device *adev)
+static int sdma_v3_0_start(struct amdgpu_device *adev, const u32 instance_id)
 {
 	int r;
 
 	/* disable sdma engine before programing it */
-	sdma_v3_0_ctx_switch_enable(adev, false);
-	sdma_v3_0_enable(adev, false);
+	sdma_v3_0_ctx_switch_enable(adev, instance_id, false);
+	sdma_v3_0_enable(adev, instance_id, false);
 
 	/* start the gfx rings and rlc compute queues */
-	r = sdma_v3_0_gfx_resume(adev);
+	r = sdma_v3_0_gfx_resume(adev, instance_id);
 	if (r)
 		return r;
 
 	return 0;
 }
 
+/**
+ * sdma_v3_0_stop() - Stop an SDMA engine
+ *
+ * @adev: amdgpu_device pointer
+ * @instance_id: SDMA engine instance ID
+ *
+ * Stop the given SDMA engine instance (VI).
+ */
+static void sdma_v3_0_stop(struct amdgpu_device *adev, const u32 instance_id)
+{
+	sdma_v3_0_ctx_switch_enable(adev, instance_id, false);
+	sdma_v3_0_enable(adev, instance_id, false);
+}
+
 /**
  * sdma_v3_0_ring_test_ring - simple async dma engine test
  *
@@ -1150,14 +1158,17 @@ static int sdma_v3_0_sw_fini(struct amdgpu_ip_block *ip_block)
 
 static int sdma_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 {
-	int r;
+
 	struct amdgpu_device *adev = ip_block->adev;
+	int i, r;
 
 	sdma_v3_0_init_golden_registers(adev);
 
-	r = sdma_v3_0_start(adev);
-	if (r)
-		return r;
+	for (i = 0; i < adev->sdma.num_instances; ++i) {
+		r = sdma_v3_0_start(adev, i);
+		if (r)
+			return r;
+	}
 
 	sdma_v3_0_set_buffer_funcs(adev);
 
@@ -1167,9 +1178,10 @@ static int sdma_v3_0_hw_init(struct amdgpu_ip_block *ip_block)
 static int sdma_v3_0_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
 
-	sdma_v3_0_ctx_switch_enable(adev, false);
-	sdma_v3_0_enable(adev, false);
+	for (i = 0; i < adev->sdma.num_instances; ++i)
+		sdma_v3_0_stop(adev, i);
 
 	return 0;
 }
-- 
2.55.0


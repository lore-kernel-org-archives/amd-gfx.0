Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E84B2C79F99
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 20:33:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D4ED10E90B;
	Mon,  7 Sep 2026 20:33:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="m84HfVtg";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A096D10E90B
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 20:33:42 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-482e067e908so3208921f8f.2
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Sep 2026 13:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788813221; x=1789418021; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WQwCTvE1JkWufVUVxtzGUBlIV/9juu4aMoFihJvmyqA=;
 b=m84HfVtgH/dJ/I0bOAtFPb9RsbC9Vw2ryiwNKQnvK2LPFLOijynQT/PJVAKN9Nwnp8
 BUStU3ugmi6kPd+8oWifEDKPlMiTOvIA3+60o1Cz09p4MyBj4dE1fodFhn2kjRglS/yz
 ju2Ns5cTWc0nBoIWzBw0Bk9lCWmBUhNtPalUEIZtrDti1FwZ2YRek1f0q+kR7BJLd59R
 hvt5KZs/cA99DKhFT1VCWRfsuuYPvrOElwfx6l3rG1W6AtkNY9vZgKYztsJZgE4GfsD2
 E9opxc0K9eNQNBzavMtL7hyuLwARLTg489XDHUy5UfGt6cRc82WQLMBhBjVjp0JgZ90O
 xnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788813221; x=1789418021;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WQwCTvE1JkWufVUVxtzGUBlIV/9juu4aMoFihJvmyqA=;
 b=ZOCkhcTcolFKj5Ptg50acMvkthpxzQsyrYp+EGqnsd9FdIxjn4kRuHVYcGZIifRTqZ
 XaMx647zHpewAofWTx1lNjVa1PNt8YAbKy4hIM5k9iClZD+exQJhKrW5PSyToriVeRa0
 pHACTMcf09aQe6JiD1UXKqKuuprLROia53ZNMdpYds35tmUnywZzHHvXgUrT7tA1th6V
 CUvb/3H/Nc1xt53YVp7172FuEGAy77LnLua/EIfXj9ymVkKN67aLfvucXUaCskQ/VAOS
 tzSI+ESsHTaXSMyQfSPpg+M8Tmmrf2iKxnZ79xIvC9q1mpyXJVi4CH1/gND5bXdP7f3R
 Cy4A==
X-Gm-Message-State: AFuF++nalBKvDjxS1Jmi6IrjvmnjrfkXDKMI7dOLESylsHVTcktJebg+
 Z7HcrYfM/Aysfl+51FRl1XuBSpp2tDjqXwbaK4IkEqVELt3MHbvWuskU8gCdxZaR
X-Gm-Gg: AYBFou042GzSl2QuTIm8oKK4VGqvZ1VkCJjAk327yOZhFedmzQr2dNfDZRbSip9jA9k
 1n45BLTE2Mo6ER+PSKcOk36Gbc/JGFliS0S+eC6a2surZgM8UF5OlJZ7f987lFONJWztgSFDmtm
 FjzimSl1zFxsXSY4lcIo21sqWMJsh0AqwZy2iIIiMMFIoVlOeynJMog5SuSn5VQlOVnOG+vPq6z
 aKNvex4v6lvDqIpnIft1N/wD+SyWRkTVDrEmz6Al2oDHCKXD2GE2cdjDpl9nDYWige1sI0crjc2
 kXq7b8nuk6SwJblvifzn1u0PF0H/BSZuYoUyVrKQdatUDq7sbfHwdPJMYJrgsP3h9bgyIJNu6G5
 /aofcGcZDeS5VHvAPGEvZutvmXkenzsQFtIjMNk4SbVZuAJGyUXnpHLciiR4yvXxwuIpBDny9Jo
 NpgAcRzDJmx3SUrkRNTBwhGkA7vLfwmSwlAy7Wbp/ykQtxv4XekMjepnV9FlC5llOh7hAV8CJsV
 hBjOliN45lhUDhTv0gS
X-Received: by 2002:a05:6000:2408:b0:485:8a46:7067 with SMTP id
 ffacd0b85a97d-4858a467280mr26171954f8f.57.1788813220746; 
 Mon, 07 Sep 2026 13:33:40 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48594172546sm22191354f8f.15.2026.09.07.13.33.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 13:33:40 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 03/12] drm/amdgpu/sdma: Refactor CIK SDMA functions to be per
 instance
Date: Mon,  7 Sep 2026 22:33:07 +0200
Message-ID: <20260907203316.159103-4-timur.kristof@gmail.com>
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

This prepares the code for implementing recovery for CIK SDMA.

Reorganize the CIK SDMA code so that the functions that are
responsible for managing the SDMA engines take an instance ID
as an argument.

This makes it possible to manage the SDMA instances
independently of each other, which will enable us to
also use these functions to implement resetting and
recovering them independently.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/cik_sdma.c | 272 ++++++++++++++------------
 1 file changed, 142 insertions(+), 130 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
index f444207fa550..78fea0621ed9 100644
--- a/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
+++ b/drivers/gpu/drm/amd/amdgpu/cik_sdma.c
@@ -300,34 +300,36 @@ static void cik_sdma_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 seq
  * cik_sdma_gfx_stop - stop the gfx async dma engines
  *
  * @adev: amdgpu_device pointer
+ * @instance_id: SDMA engine instance ID
  *
  * Stop the gfx async dma ring buffers (CIK).
  */
-static void cik_sdma_gfx_stop(struct amdgpu_device *adev)
+static void cik_sdma_gfx_stop(struct amdgpu_device *adev, const u32 instance_id)
 {
+	const u32 reg_offset = sdma_offsets[instance_id];
 	u32 rb_cntl;
-	int i;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		rb_cntl = RREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i]);
-		rb_cntl &= ~SDMA0_GFX_RB_CNTL__RB_ENABLE_MASK;
-		WREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i], rb_cntl);
-		WREG32(mmSDMA0_GFX_IB_CNTL + sdma_offsets[i], 0);
-	}
+	rb_cntl = RREG32(mmSDMA0_GFX_RB_CNTL + reg_offset);
+	rb_cntl &= ~SDMA0_GFX_RB_CNTL__RB_ENABLE_MASK;
+	WREG32(mmSDMA0_GFX_RB_CNTL + reg_offset, rb_cntl);
+	WREG32(mmSDMA0_GFX_IB_CNTL + reg_offset, 0);
 }
 
 /**
  * cik_ctx_switch_enable - stop the async dma engines context switch
  *
  * @adev: amdgpu_device pointer
+ * @instance_id: SDMA engine instance ID
  * @enable: enable/disable the DMA MEs context switch.
  *
  * Halt or unhalt the async dma engines context switch (VI).
  */
-static void cik_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
+static void cik_ctx_switch_enable(struct amdgpu_device *adev,
+				  const u32 instance_id,
+				  const bool enable)
 {
+	const u32 reg_offset = sdma_offsets[instance_id];
 	u32 f32_cntl, phase_quantum = 0;
-	int i;
 
 	if (amdgpu_sdma_phase_quantum) {
 		unsigned value = amdgpu_sdma_phase_quantum;
@@ -353,176 +355,172 @@ static void cik_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
 			unit  << SDMA0_PHASE0_QUANTUM__UNIT__SHIFT;
 	}
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		f32_cntl = RREG32(mmSDMA0_CNTL + sdma_offsets[i]);
-		if (enable) {
-			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
-					AUTO_CTXSW_ENABLE, 1);
-			if (amdgpu_sdma_phase_quantum) {
-				WREG32(mmSDMA0_PHASE0_QUANTUM + sdma_offsets[i],
-				       phase_quantum);
-				WREG32(mmSDMA0_PHASE1_QUANTUM + sdma_offsets[i],
-				       phase_quantum);
-			}
-		} else {
-			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
-					AUTO_CTXSW_ENABLE, 0);
+	f32_cntl = RREG32(mmSDMA0_CNTL + reg_offset);
+	if (enable) {
+		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
+				AUTO_CTXSW_ENABLE, 1);
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
 	}
+
+	WREG32(mmSDMA0_CNTL + reg_offset, f32_cntl);
 }
 
 /**
  * cik_sdma_enable - stop the async dma engines
  *
  * @adev: amdgpu_device pointer
+ * @instance_id: SDMA engine instance ID
  * @enable: enable/disable the DMA MEs.
  *
  * Halt or unhalt the async dma engines (CIK).
  */
-static void cik_sdma_enable(struct amdgpu_device *adev, bool enable)
+static void cik_sdma_enable(struct amdgpu_device *adev,
+			    const u32 instance_id,
+			    const bool enable)
 {
+	const u32 reg_offset = sdma_offsets[instance_id];
 	u32 me_cntl;
-	int i;
 
 	if (!enable) {
-		cik_sdma_gfx_stop(adev);
+		cik_sdma_gfx_stop(adev, instance_id);
 	}
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		me_cntl = RREG32(mmSDMA0_F32_CNTL + sdma_offsets[i]);
-		if (enable)
-			me_cntl &= ~SDMA0_F32_CNTL__HALT_MASK;
-		else
-			me_cntl |= SDMA0_F32_CNTL__HALT_MASK;
-		WREG32(mmSDMA0_F32_CNTL + sdma_offsets[i], me_cntl);
-	}
+	me_cntl = RREG32(mmSDMA0_F32_CNTL + reg_offset);
+	if (enable)
+		me_cntl &= ~SDMA0_F32_CNTL__HALT_MASK;
+	else
+		me_cntl |= SDMA0_F32_CNTL__HALT_MASK;
+	WREG32(mmSDMA0_F32_CNTL + reg_offset, me_cntl);
 }
 
 /**
  * cik_sdma_gfx_resume - setup and start the async dma engines
  *
  * @adev: amdgpu_device pointer
+ * @instance_id: SDMA engine instance ID
  *
  * Set up the gfx DMA ring buffers and enable them (CIK).
  * Returns 0 for success, error for failure.
  */
-static int cik_sdma_gfx_resume(struct amdgpu_device *adev)
+static int cik_sdma_gfx_resume(struct amdgpu_device *adev, const u32 instance_id)
 {
-	struct amdgpu_ring *ring;
+	struct amdgpu_ring *const ring = &adev->sdma.instance[instance_id].ring;
+	const u32 reg_offset = sdma_offsets[instance_id];
 	u32 rb_cntl, ib_cntl;
 	u32 rb_bufsz;
-	int i, j, r;
-
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		ring = &adev->sdma.instance[i].ring;
-
-		mutex_lock(&adev->srbm_mutex);
-		for (j = 0; j < 16; j++) {
-			cik_srbm_select(adev, 0, 0, 0, j);
-			/* SDMA GFX */
-			WREG32(mmSDMA0_GFX_VIRTUAL_ADDR + sdma_offsets[i], 0);
-			WREG32(mmSDMA0_GFX_APE1_CNTL + sdma_offsets[i], 0);
-			/* XXX SDMA RLC - todo */
-		}
-		cik_srbm_select(adev, 0, 0, 0, 0);
-		mutex_unlock(&adev->srbm_mutex);
+	int j;
+
+	mutex_lock(&adev->srbm_mutex);
+	for (j = 0; j < 16; j++) {
+		cik_srbm_select(adev, 0, 0, 0, j);
+		/* SDMA GFX */
+		WREG32(mmSDMA0_GFX_VIRTUAL_ADDR + reg_offset, 0);
+		WREG32(mmSDMA0_GFX_APE1_CNTL + reg_offset, 0);
+		/* XXX SDMA RLC - todo */
+	}
+	cik_srbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
 
-		WREG32(mmSDMA0_TILING_CONFIG + sdma_offsets[i],
-		       adev->gfx.config.gb_addr_config & 0x70);
+	WREG32(mmSDMA0_TILING_CONFIG + reg_offset,
+		adev->gfx.config.gb_addr_config & 0x70);
 
-		WREG32(mmSDMA0_SEM_INCOMPLETE_TIMER_CNTL + sdma_offsets[i], 0);
-		WREG32(mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL + sdma_offsets[i], 0);
+	WREG32(mmSDMA0_SEM_INCOMPLETE_TIMER_CNTL + reg_offset, 0);
+	WREG32(mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL + reg_offset, 0);
 
-		/* Set ring buffer size in dwords */
-		rb_bufsz = order_base_2(ring->ring_size / 4);
-		rb_cntl = rb_bufsz << 1;
+	/* Set ring buffer size in dwords */
+	rb_bufsz = order_base_2(ring->ring_size / 4);
+	rb_cntl = rb_bufsz << 1;
 #ifdef __BIG_ENDIAN
-		rb_cntl |= SDMA0_GFX_RB_CNTL__RB_SWAP_ENABLE_MASK |
-			SDMA0_GFX_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE_MASK;
+	rb_cntl |= SDMA0_GFX_RB_CNTL__RB_SWAP_ENABLE_MASK |
+		SDMA0_GFX_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE_MASK;
 #endif
-		WREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i], rb_cntl);
+	WREG32(mmSDMA0_GFX_RB_CNTL + reg_offset, rb_cntl);
 
-		/* Initialize the ring buffer's read and write pointers */
-		WREG32(mmSDMA0_GFX_RB_RPTR + sdma_offsets[i], 0);
-		WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], 0);
-		WREG32(mmSDMA0_GFX_IB_RPTR + sdma_offsets[i], 0);
-		WREG32(mmSDMA0_GFX_IB_OFFSET + sdma_offsets[i], 0);
+	/* Initialize the ring buffer's read and write pointers */
+	WREG32(mmSDMA0_GFX_RB_RPTR + reg_offset, 0);
+	WREG32(mmSDMA0_GFX_RB_WPTR + reg_offset, 0);
+	WREG32(mmSDMA0_GFX_IB_RPTR + reg_offset, 0);
+	WREG32(mmSDMA0_GFX_IB_OFFSET + reg_offset, 0);
 
-		/* set the wb address whether it's enabled or not */
-		WREG32(mmSDMA0_GFX_RB_RPTR_ADDR_HI + sdma_offsets[i],
-		       upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
-		WREG32(mmSDMA0_GFX_RB_RPTR_ADDR_LO + sdma_offsets[i],
-		       ((ring->rptr_gpu_addr) & 0xFFFFFFFC));
+	/* set the wb address whether it's enabled or not */
+	WREG32(mmSDMA0_GFX_RB_RPTR_ADDR_HI + reg_offset,
+		upper_32_bits(ring->rptr_gpu_addr) & 0xFFFFFFFF);
+	WREG32(mmSDMA0_GFX_RB_RPTR_ADDR_LO + reg_offset,
+		((ring->rptr_gpu_addr) & 0xFFFFFFFC));
 
-		rb_cntl |= SDMA0_GFX_RB_CNTL__RPTR_WRITEBACK_ENABLE_MASK;
+	rb_cntl |= SDMA0_GFX_RB_CNTL__RPTR_WRITEBACK_ENABLE_MASK;
 
-		WREG32(mmSDMA0_GFX_RB_BASE + sdma_offsets[i], ring->gpu_addr >> 8);
-		WREG32(mmSDMA0_GFX_RB_BASE_HI + sdma_offsets[i], ring->gpu_addr >> 40);
+	WREG32(mmSDMA0_GFX_RB_BASE + reg_offset, ring->gpu_addr >> 8);
+	WREG32(mmSDMA0_GFX_RB_BASE_HI + reg_offset, ring->gpu_addr >> 40);
 
-		ring->wptr = 0;
-		WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], ring->wptr << 2);
+	ring->wptr = 0;
+	WREG32(mmSDMA0_GFX_RB_WPTR + reg_offset, ring->wptr << 2);
 
-		/* enable DMA RB */
-		WREG32(mmSDMA0_GFX_RB_CNTL + sdma_offsets[i],
-		       rb_cntl | SDMA0_GFX_RB_CNTL__RB_ENABLE_MASK);
+	/* enable DMA RB */
+	WREG32(mmSDMA0_GFX_RB_CNTL + reg_offset,
+		rb_cntl | SDMA0_GFX_RB_CNTL__RB_ENABLE_MASK);
 
-		ib_cntl = SDMA0_GFX_IB_CNTL__IB_ENABLE_MASK;
+	ib_cntl = SDMA0_GFX_IB_CNTL__IB_ENABLE_MASK;
 #ifdef __BIG_ENDIAN
-		ib_cntl |= SDMA0_GFX_IB_CNTL__IB_SWAP_ENABLE_MASK;
+	ib_cntl |= SDMA0_GFX_IB_CNTL__IB_SWAP_ENABLE_MASK;
 #endif
-		/* enable DMA IBs */
-		WREG32(mmSDMA0_GFX_IB_CNTL + sdma_offsets[i], ib_cntl);
-	}
+	/* enable DMA IBs */
+	WREG32(mmSDMA0_GFX_IB_CNTL + reg_offset, ib_cntl);
 
-	cik_sdma_enable(adev, true);
-
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		ring = &adev->sdma.instance[i].ring;
-		r = amdgpu_ring_test_helper(ring);
-		if (r)
-			return r;
-	}
+	cik_sdma_enable(adev, instance_id, true);
 
-	return 0;
+	return amdgpu_ring_test_helper(ring);
 }
 
 /**
  * cik_sdma_load_microcode - load the sDMA ME ucode
  *
  * @adev: amdgpu_device pointer
+ * @instance_id: SDMA engine instance ID
  *
  * Loads the sDMA0/1 ucode.
  * Returns 0 for success, -EINVAL if the ucode is not available.
  */
-static int cik_sdma_load_microcode(struct amdgpu_device *adev)
+static int cik_sdma_load_microcode(struct amdgpu_device *adev, const u32 instance_id)
 {
+	struct amdgpu_sdma_instance *const instance = &adev->sdma.instance[instance_id];
+	const u32 reg_offset = sdma_offsets[instance_id];
 	const struct sdma_firmware_header_v1_0 *hdr;
 	const __le32 *fw_data;
 	u32 fw_size;
-	int i, j;
+	int j;
 
 	/* halt the MEs */
-	cik_sdma_enable(adev, false);
+	cik_sdma_enable(adev, instance_id, false);
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (!adev->sdma.instance[i].fw)
-			return -EINVAL;
-		hdr = (const struct sdma_firmware_header_v1_0 *)adev->sdma.instance[i].fw->data;
-		amdgpu_ucode_print_sdma_hdr(&hdr->header);
-		fw_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
-		adev->sdma.instance[i].fw_version = le32_to_cpu(hdr->header.ucode_version);
-		adev->sdma.instance[i].feature_version = le32_to_cpu(hdr->ucode_feature_version);
-		if (adev->sdma.instance[i].feature_version >= 20)
-			adev->sdma.instance[i].burst_nop = true;
-		fw_data = (const __le32 *)
-			(adev->sdma.instance[i].fw->data + le32_to_cpu(hdr->header.ucode_array_offset_bytes));
-		WREG32(mmSDMA0_UCODE_ADDR + sdma_offsets[i], 0);
-		for (j = 0; j < fw_size; j++)
-			WREG32(mmSDMA0_UCODE_DATA + sdma_offsets[i], le32_to_cpup(fw_data++));
-		WREG32(mmSDMA0_UCODE_ADDR + sdma_offsets[i], adev->sdma.instance[i].fw_version);
-	}
+	if (!adev->sdma.instance[instance_id].fw)
+		return -EINVAL;
+
+	hdr = (const struct sdma_firmware_header_v1_0 *)instance->fw->data;
+	amdgpu_ucode_print_sdma_hdr(&hdr->header);
+
+	fw_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
+	instance->fw_version = le32_to_cpu(hdr->header.ucode_version);
+	instance->feature_version = le32_to_cpu(hdr->ucode_feature_version);
+
+	if (instance->feature_version >= 20)
+		instance->burst_nop = true;
+
+	fw_data = (const __le32 *)
+		(instance->fw->data + le32_to_cpu(hdr->header.ucode_array_offset_bytes));
+
+	WREG32(mmSDMA0_UCODE_ADDR + reg_offset, 0);
+	for (j = 0; j < fw_size; j++)
+		WREG32(mmSDMA0_UCODE_DATA + reg_offset, le32_to_cpup(fw_data++));
+	WREG32(mmSDMA0_UCODE_ADDR + reg_offset, instance->fw_version);
 
 	return 0;
 }
@@ -531,29 +529,40 @@ static int cik_sdma_load_microcode(struct amdgpu_device *adev)
  * cik_sdma_start - setup and start the async dma engines
  *
  * @adev: amdgpu_device pointer
+ * @instance_id: SDMA engine instance ID
  *
  * Set up the DMA engines and enable them (CIK).
  * Returns 0 for success, error for failure.
  */
-static int cik_sdma_start(struct amdgpu_device *adev)
+static int cik_sdma_start(struct amdgpu_device *adev, const u32 instance_id)
 {
 	int r;
 
-	r = cik_sdma_load_microcode(adev);
+	r = cik_sdma_load_microcode(adev, instance_id);
 	if (r)
 		return r;
 
 	/* halt the engine before programing */
-	cik_sdma_enable(adev, false);
+	cik_sdma_enable(adev, instance_id, false);
 	/* enable sdma ring preemption */
-	cik_ctx_switch_enable(adev, true);
+	cik_ctx_switch_enable(adev, instance_id, true);
 
 	/* start the gfx rings and rlc compute queues */
-	r = cik_sdma_gfx_resume(adev);
-	if (r)
-		return r;
+	return cik_sdma_gfx_resume(adev, instance_id);
+}
 
-	return 0;
+/**
+ * cik_sdma_stop() - Stop an SDMA engine
+ *
+ * @adev: amdgpu_device pointer
+ * @instance_id: SDMA engine instance ID
+ *
+ * Stop the given SDMA engine instance (CIK).
+ */
+static void cik_sdma_stop(struct amdgpu_device *adev, const u32 instance_id)
+{
+	cik_ctx_switch_enable(adev, instance_id, false);
+	cik_sdma_enable(adev, instance_id, false);
 }
 
 /**
@@ -974,11 +983,13 @@ static int cik_sdma_sw_fini(struct amdgpu_ip_block *ip_block)
 static int cik_sdma_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
-	int r;
+	int i, r;
 
-	r = cik_sdma_start(adev);
-	if (r)
-		return r;
+	for (i = 0; i < adev->sdma.num_instances; ++i) {
+		r = cik_sdma_start(adev, i);
+		if (r)
+			return r;
+	}
 
 	cik_sdma_set_buffer_funcs(adev);
 
@@ -988,9 +999,10 @@ static int cik_sdma_hw_init(struct amdgpu_ip_block *ip_block)
 static int cik_sdma_hw_fini(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
 
-	cik_ctx_switch_enable(adev, false);
-	cik_sdma_enable(adev, false);
+	for (i = 0; i < adev->sdma.num_instances; ++i)
+		cik_sdma_stop(adev, i);
 
 	return 0;
 }
-- 
2.55.0


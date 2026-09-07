Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3365C79F9E
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 20:33:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F45310E911;
	Mon,  7 Sep 2026 20:33:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QzxvWd1G";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A396E10E911
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 20:33:47 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-485843aeab8so4373675f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Sep 2026 13:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788813226; x=1789418026; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gcwEoGfKHB0kpNlS0JXPMrysj6JKOl/aBl1tnjtQpBc=;
 b=QzxvWd1GQPLTMN3E+9e0E5KG+6td1jOxYkdlG8K1YUzLzuIvnILLpr4GJgSzdVUNtV
 AGOR4DjxC0DeSL01HAdC1A299WRkCaKFTNZHiUk+c+iLtfymk9jxhtKBQ8nvDVXfZrBf
 EbUvufXxsxk7HqpYmYQjGAjzQcFQsCGHbuh+W3scqpOKjVtuqUz7wyQNIp04f4QurDFi
 8yRr27RTTVWGU96V3VnVb45HpGLPmeDYUKEFNO3DNze+2EULsBOWLa7w+f1150S5FN79
 jCvJAM8/ssiTIQsjtlV8eBOtvZebX7DB3THLLU9ab6B5/iWmZ5vInXutYgq6eGUzOoKA
 81UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788813226; x=1789418026;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=gcwEoGfKHB0kpNlS0JXPMrysj6JKOl/aBl1tnjtQpBc=;
 b=XFKKKkH1oYtSQ/t5zUVJB/TWUCmbLQt7vPdPWWy4d1eDfSGjRohQL2vuYiG5f+s8wH
 vuA5sEFl3r8tK7jXeb/gABoC6y9HDttbWxMpS3sVVfABBNOIQ45TG7QPckNMhpSTXgpT
 gTUIMVi/tdFj/Crxg2zL+rwt1hOH8+egP89cN4FpDZSTLvarZrJUKOHsaGPZmgMKBqbh
 IRY5W/AJgMgvF4/C69NxKHMCmV3odFKpeyBmgjVd0ZYIE/0Tfz0dxrcqXhBicb/jAi3f
 xQOuiYeLSIcK6lhFAbGp+5bm678zV+9m8+zA935W2JhLxY9A9dc0vkTIHhlz6FGwyULz
 9rvg==
X-Gm-Message-State: AFuF++nvCWytDfm9xLa60fhe2s/aOFOOKJb4qAMnA85TgFE6rqqE8GL8
 EutGMs9mD9McQiPi/wZQzUHYT4oVCQNNzhoPFAxiA8VPL3aGR0gxGKvnncVp9OEz
X-Gm-Gg: AYBFou21FSogwFtUmxjiIF3ebrHmg9WRWIz40/+oBZBz1Hz5jA2H8PKRWeFDEwRupEd
 KEqm+695YQxtk4q/DlioSm5jN8brnyLT+EcFvPFbQCMYLRt5yNoxRxRjw9jVvVk/qJAvCqeE0Nv
 TheHSFpucWoWq2ngPN2q0NeMloJv1X+2KFUYlP4xAnshV8nGN38BjYdLQz06ojTho8OPnvRwqL2
 EPGHVv+9h8l0K4E2WuuBf75g21emSjDMjguft45+WgL0hS8T+CnFIT0YJ2VQlPAGirc19Kcv/3e
 SHKGo81KxO53kU2M7iWjEiK4JZ5cjgijWAvfiyHyyg4Qz2p1EjX9OPU6Nvg8SrwIilhkqGBtVQ6
 6etr1La0ogxfbPnpELVauBynSyHQn5ZNPih4z0OGhl2H5m9CJZIByGKFvgyN1qWDEihWtd9yh/b
 gLN87T0zrhiIQfHt9CZ+YXHRsXnnTTRqr5VyhkgJxmIX0u0UXlvWcxuQY0HxnfIUDBAbm9KYGph
 5Cl4a/VFq4w9yZYZ3db
X-Received: by 2002:a05:6000:430b:b0:485:8ad6:3752 with SMTP id
 ffacd0b85a97d-4858ad63a6fmr43153462f8f.5.1788813225904; 
 Mon, 07 Sep 2026 13:33:45 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48594172546sm22191354f8f.15.2026.09.07.13.33.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 13:33:44 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 05/12] drm/amdgpu/sdma: Refactor SDMA v2.4 functions to be per
 instance
Date: Mon,  7 Sep 2026 22:33:09 +0200
Message-ID: <20260907203316.159103-6-timur.kristof@gmail.com>
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

This prepares the code for implementing recovery for SDMA 2.4.

Reorganize the SDMA 2.4 code so that the functions that are
responsible for managing the SDMA engines take an instance ID
as an argument.

This makes it possible to manage the SDMA instances
independently of each other, which will enable us to
also use these functions to implement resetting and
recovering them independently.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c | 189 +++++++++++++------------
 1 file changed, 100 insertions(+), 89 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
index 7c8acdf73d44..0743b782527a 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v2_4.c
@@ -331,163 +331,168 @@ static void sdma_v2_4_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
  * sdma_v2_4_gfx_stop - stop the gfx async dma engines
  *
  * @adev: amdgpu_device pointer
+ * @instance_id: SDMA engine instance ID
  *
  * Stop the gfx async dma ring buffers (VI).
  */
-static void sdma_v2_4_gfx_stop(struct amdgpu_device *adev)
+static void sdma_v2_4_gfx_stop(struct amdgpu_device *adev, const u32 instance_id)
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
  * sdma_v2_4_enable - stop the async dma engines
  *
  * @adev: amdgpu_device pointer
+ * @instance_id: SDMA engine instance ID
  * @enable: enable/disable the DMA MEs.
  *
  * Halt or unhalt the async dma engines (VI).
  */
-static void sdma_v2_4_enable(struct amdgpu_device *adev, bool enable)
+static void sdma_v2_4_enable(struct amdgpu_device *adev,
+			     const u32 instance_id,
+			     const bool enable)
 {
+	const u32 reg_offset = sdma_offsets[instance_id];
 	u32 f32_cntl;
-	int i;
 
 	if (!enable) {
-		sdma_v2_4_gfx_stop(adev);
+		sdma_v2_4_gfx_stop(adev, instance_id);
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
  * sdma_v2_4_gfx_resume - setup and start the async dma engines
  *
  * @adev: amdgpu_device pointer
+ * @instance_id: SDMA engine instance ID
  *
  * Set up the gfx DMA ring buffers and enable them (VI).
  * Returns 0 for success, error for failure.
  */
-static int sdma_v2_4_gfx_resume(struct amdgpu_device *adev)
+static int sdma_v2_4_gfx_resume(struct amdgpu_device *adev, const u32 instance_id)
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
-			vi_srbm_select(adev, 0, 0, 0, j);
-			/* SDMA GFX */
-			WREG32(mmSDMA0_GFX_VIRTUAL_ADDR + sdma_offsets[i], 0);
-			WREG32(mmSDMA0_GFX_APE1_CNTL + sdma_offsets[i], 0);
-		}
-		vi_srbm_select(adev, 0, 0, 0, 0);
-		mutex_unlock(&adev->srbm_mutex);
+	int j;
+
+	mutex_lock(&adev->srbm_mutex);
+	for (j = 0; j < 16; j++) {
+		vi_srbm_select(adev, 0, 0, 0, j);
+		/* SDMA GFX */
+		WREG32(mmSDMA0_GFX_VIRTUAL_ADDR + reg_offset, 0);
+		WREG32(mmSDMA0_GFX_APE1_CNTL + reg_offset, 0);
+	}
+	vi_srbm_select(adev, 0, 0, 0, 0);
+	mutex_unlock(&adev->srbm_mutex);
 
-		WREG32(mmSDMA0_TILING_CONFIG + sdma_offsets[i],
-		       adev->gfx.config.gb_addr_config & 0x70);
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
 
-		ring->wptr = 0;
-		WREG32(mmSDMA0_GFX_RB_WPTR + sdma_offsets[i], ring->wptr << 2);
+	ring->wptr = 0;
+	WREG32(mmSDMA0_GFX_RB_WPTR + reg_offset, ring->wptr << 2);
 
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
 
-	sdma_v2_4_enable(adev, true);
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		ring = &adev->sdma.instance[i].ring;
-		r = amdgpu_ring_test_helper(ring);
-		if (r)
-			return r;
-	}
+	sdma_v2_4_enable(adev, instance_id, true);
 
-	return 0;
+	return amdgpu_ring_test_helper(ring);
 }
 
-
 /**
  * sdma_v2_4_start - setup and start the async dma engines
  *
  * @adev: amdgpu_device pointer
+ * @instance_id: SDMA engine instance ID
  *
  * Set up the DMA engines and enable them (VI).
  * Returns 0 for success, error for failure.
  */
-static int sdma_v2_4_start(struct amdgpu_device *adev)
+static int sdma_v2_4_start(struct amdgpu_device *adev, const u32 instance_id)
 {
 	int r;
 
 	/* halt the engine before programing */
-	sdma_v2_4_enable(adev, false);
+	sdma_v2_4_enable(adev, instance_id, false);
 
 	/* start the gfx rings and rlc compute queues */
-	r = sdma_v2_4_gfx_resume(adev);
+	r = sdma_v2_4_gfx_resume(adev, instance_id);
 	if (r)
 		return r;
 
 	return 0;
 }
 
+/**
+ * sdma_v2_4_stop() - Stop an SDMA engine
+ *
+ * @adev: amdgpu_device pointer
+ * @instance_id: SDMA engine instance ID
+ *
+ * Stop the given SDMA engine instance (VI).
+ */
+static void sdma_v2_4_stop(struct amdgpu_device *adev, const u32 instance_id)
+{
+	sdma_v2_4_enable(adev, instance_id, false);
+}
+
 /**
  * sdma_v2_4_ring_test_ring - simple async dma engine test
  *
@@ -863,14 +868,16 @@ static int sdma_v2_4_sw_fini(struct amdgpu_ip_block *ip_block)
 
 static int sdma_v2_4_hw_init(struct amdgpu_ip_block *ip_block)
 {
-	int r;
 	struct amdgpu_device *adev = ip_block->adev;
+	int i, r;
 
 	sdma_v2_4_init_golden_registers(adev);
 
-	r = sdma_v2_4_start(adev);
-	if (r)
-		return r;
+	for (i = 0; i < adev->sdma.num_instances; ++i) {
+		r = sdma_v2_4_start(adev, i);
+		if (r)
+			return r;
+	}
 
 	sdma_v2_4_set_buffer_funcs(adev);
 
@@ -879,7 +886,11 @@ static int sdma_v2_4_hw_init(struct amdgpu_ip_block *ip_block)
 
 static int sdma_v2_4_hw_fini(struct amdgpu_ip_block *ip_block)
 {
-	sdma_v2_4_enable(ip_block->adev, false);
+	struct amdgpu_device *adev = ip_block->adev;
+	int i;
+
+	for (i = 0; i < adev->sdma.num_instances; ++i)
+		sdma_v2_4_stop(adev, i);
 
 	return 0;
 }
-- 
2.55.0


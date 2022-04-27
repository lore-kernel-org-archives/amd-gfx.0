Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F0D9C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 12:09:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B53410F2E1;
	Wed, 27 Apr 2022 12:09:52 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com
 [IPv6:2607:f8b0:4864:20::102c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C1E610F2DC
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 12:09:51 +0000 (UTC)
Received: by mail-pj1-x102c.google.com with SMTP id bx5so1312853pjb.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 05:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=2P34clHMH7Mb4SlR4DIJBS+b3nmR/EvIV7n/ihgdRsw=;
 b=R4cU9b3jYb9GEScW972XWYfBZUGhs34jrid7atRx30dsxgGIpTNsUUB1/B5/xgGAI6
 sBRqRpfLJHBk47CRJqhHbf4DcMUTO5231HyRFhtoCNLZ1Wuxn1+p9gg1am3mCrwQQFWX
 0i9rngvEpatoFAOq86a1B6yU9LplkU+cAJ3UeUwDszSoEcE2u0H8SjvkyZDhlgPv7Jv2
 3VIv+X9JEDv+MHkcsbZh6tYcEPtVRWiHGsE3PaMPUSglIqrb6+z6DnIYg1qddKsY3rrX
 joJrxMcuNdtCWatnw1ZNAQc5i+ILYhSDKJi0tTQQR5K1jrahqSZPhvzjd6/A6ref8AQP
 XPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=2P34clHMH7Mb4SlR4DIJBS+b3nmR/EvIV7n/ihgdRsw=;
 b=yQfCgcenV2TC4bXQgkagHLm3ivYqqJY6BuxtDyxfxAUch69k+DJEv881ydNGREIYFJ
 eIPTRFzY8kpBP6ijQS841GY5DoTYFCXuUnlL5rKuPqwgRsUyIL60e8746ba9ljkfNYLn
 jrY+quGuXyYVscnymJfd3j2kLES2KXNWjzPEq2cLqBPIl7qIaxZ2DQevcyagUf9szxFr
 FY5yZRZNrIdbhe+vCN2lWEDvzTQtKoZ4k8eiopGNvvnu9mKcu/q8cmaKF6Ub/HNaMjmY
 HvJEbBgsL5PNalKgH9xsHw0tLsOV6pE7/oD6UlRlN2S+1zUDCtwVKeIkGFeStfnIuheZ
 3URw==
X-Gm-Message-State: AOAM530J2AN7dBgDPTqkaw8pbdpGkmAcEdvqlwBgWjWqeCkw/IpzhlSu
 5ovcmHTaqeT7GkDSZGfoH/yD1aUMDXYRj099
X-Google-Smtp-Source: ABdhPJwD/8GmKf/hQ+drDo7i8Inl6A0VHmGp4VhTILcUCl6zM2ck7S/Zc+Vci/NYX28AfvJpux/6qw==
X-Received: by 2002:a17:902:b092:b0:156:a40f:f716 with SMTP id
 p18-20020a170902b09200b00156a40ff716mr28353347plr.72.1651061390641; 
 Wed, 27 Apr 2022 05:09:50 -0700 (PDT)
Received: from chachonne.lan ([2600:1700:8a10:4fd0::e])
 by smtp.gmail.com with ESMTPSA id
 d7-20020a62f807000000b0050d32c878f4sm12646523pfh.114.2022.04.27.05.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Apr 2022 05:09:50 -0700 (PDT)
From: ricetons@gmail.com
To: amd-gfx@lists.freedesktop.org,
	ckoenig.leichtzumerken@gmail.com
Subject: [PATCH] drm/amdgpu: Ensure the DMA engine is deactivated during set
 ups
Date: Wed, 27 Apr 2022 05:09:47 -0700
Message-Id: <20220427120947.29053-1-ricetons@gmail.com>
X-Mailer: git-send-email 2.17.1
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
Cc: Haohui Mai <ricetons@gmail.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Haohui Mai <ricetons@gmail.com>

The patch fully deactivates the DMA engine before setting up the ring
buffer to avoid potential data races and crashes.

Signed-off-by: Haohui Mai <ricetons@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 88 +++++++++++++-------------
 1 file changed, 45 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 013d2dec81d0..61d58e515fe7 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -459,7 +459,6 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 	}
 }
 
-
 /**
  * sdma_v5_2_gfx_stop - stop the gfx async dma engines
  *
@@ -505,17 +504,18 @@ static void sdma_v5_2_rlc_stop(struct amdgpu_device *adev)
 }
 
 /**
- * sdma_v5_2_ctx_switch_enable - stop the async dma engines context switch
+ * sdma_v5_2_ctx_switch_enable_for_instance - start the async dma engines context switch for an instance
  *
  * @adev: amdgpu_device pointer
- * @enable: enable/disable the DMA MEs context switch.
+ * @i: the index of the SDMA instance
  *
- * Halt or unhalt the async dma engines context switch.
+ * Unhalt the async dma engines context switch.
  */
-static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
+static void sdma_v5_2_ctx_switch_enable_for_instance(struct amdgpu_device *adev, int i)
 {
 	u32 f32_cntl, phase_quantum = 0;
-	int i;
+
+	BUG_ON(i >= adev->sdma.num_instances);
 
 	if (amdgpu_sdma_phase_quantum) {
 		unsigned value = amdgpu_sdma_phase_quantum;
@@ -539,26 +539,44 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
 		phase_quantum =
 			value << SDMA0_PHASE0_QUANTUM__VALUE__SHIFT |
 			unit  << SDMA0_PHASE0_QUANTUM__UNIT__SHIFT;
+
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
+		       phase_quantum);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
+		       phase_quantum);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
+		       phase_quantum);
 	}
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (enable && amdgpu_sdma_phase_quantum) {
-			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
-			       phase_quantum);
-			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
-			       phase_quantum);
-			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
-			       phase_quantum);
-		}
+	if (!amdgpu_sriov_vf(adev)) {
+		f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
+		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
+				AUTO_CTXSW_ENABLE, 1);
+		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
+	}
+}
 
-		if (!amdgpu_sriov_vf(adev)) {
-			f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
-			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
-					AUTO_CTXSW_ENABLE, enable ? 1 : 0);
-			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
-		}
+/**
+ * sdma_v5_2_ctx_switch_disable_all - stop the async dma engines context switch
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Halt the async dma engines context switch.
+ */
+static void sdma_v5_2_ctx_switch_disable_all(struct amdgpu_device *adev)
+{
+	u32 f32_cntl;
+	int i;
+	if (amdgpu_sriov_vf(adev)) {
+		return;
 	}
 
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
+		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
+				AUTO_CTXSW_ENABLE, 0);
+		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
+	}
 }
 
 /**
@@ -571,21 +589,10 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
  */
 static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
 {
-	u32 f32_cntl;
-	int i;
-
 	if (!enable) {
 		sdma_v5_2_gfx_stop(adev);
 		sdma_v5_2_rlc_stop(adev);
 	}
-
-	if (!amdgpu_sriov_vf(adev)) {
-		for (i = 0; i < adev->sdma.num_instances; i++) {
-			f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
-			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
-			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
-		}
-	}
 }
 
 /**
@@ -594,6 +601,8 @@ static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
  * @adev: amdgpu_device pointer
  *
  * Set up the gfx DMA ring buffers and enable them.
+ * It assumes that the dma engine is stopped for each instance. The function enables the engine and preemptions sequentially for each instance.
+ *
  * Returns 0 for success, error for failure.
  */
 static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
@@ -737,10 +746,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 
 		ring->sched.ready = true;
 
-		if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
-			sdma_v5_2_ctx_switch_enable(adev, true);
-			sdma_v5_2_enable(adev, true);
-		}
+		sdma_v5_2_ctx_switch_enable_for_instance(adev, i);
 
 		r = amdgpu_ring_test_ring(ring);
 		if (r) {
@@ -856,7 +862,7 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
 	int r = 0;
 
 	if (amdgpu_sriov_vf(adev)) {
-		sdma_v5_2_ctx_switch_enable(adev, false);
+		sdma_v5_2_ctx_switch_disable_all(adev);
 		sdma_v5_2_enable(adev, false);
 
 		/* set RB registers */
@@ -881,12 +887,8 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
 		amdgpu_gfx_off_ctrl(adev, false);
 
 	sdma_v5_2_soft_reset(adev);
-	/* unhalt the MEs */
-	sdma_v5_2_enable(adev, true);
-	/* enable sdma ring preemption */
-	sdma_v5_2_ctx_switch_enable(adev, true);
 
-	/* start the gfx rings and rlc compute queues */
+	/* Soft reset supposes to disable the dma engine and preemption. Now start the gfx rings and rlc compute queues */
 	r = sdma_v5_2_gfx_resume(adev);
 	if (adev->in_s0ix)
 		amdgpu_gfx_off_ctrl(adev, true);
@@ -1340,7 +1342,7 @@ static int sdma_v5_2_hw_fini(void *handle)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	sdma_v5_2_ctx_switch_enable(adev, false);
+	sdma_v5_2_ctx_switch_disable_all(adev);
 	sdma_v5_2_enable(adev, false);
 
 	return 0;
-- 
2.25.1


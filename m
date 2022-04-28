Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D4DCC433F5
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 02:11:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9104D10E155;
	Thu, 28 Apr 2022 02:11:18 +0000 (UTC)
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com
 [IPv6:2607:f8b0:4864:20::630])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06F9910E155
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 02:11:17 +0000 (UTC)
Received: by mail-pl1-x630.google.com with SMTP id q8so3113729plx.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 19:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=uaI6iH2XhVzv1sXeoqurr705kcQujyYxyzqq79vfBSk=;
 b=XxbtV0RqH3h7LGyUk1izheBWUgLyQsbczhkT76teCnJZpkZTQ7yE4SZPCzpHAyY4g5
 TpMSCdt8wYmzfCzG2cK+cBO5qo2p07Z4XpZJ6/msQo4Glkh6jZjzd0eb0kaMo14BH68M
 8z4FeK81dVLo/LPXZunS4OBPHww3c0ohrV9Ku7ZBLsB/9mJCesy/nkmU/sSDO6twg6Hj
 FQWI+cGnFqNDFh1Y3TCZJclSNkyuHD4DB8PGHNXlJqCawrqgY9L64jciblDFU4yM5G7K
 m/v/pwX/zbHTqPwkNDQRxjY+LXEwJS0/ZDJiJktKJMl4Z+EBLyFr9fPockGn7PCiZek+
 Hqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=uaI6iH2XhVzv1sXeoqurr705kcQujyYxyzqq79vfBSk=;
 b=4aJKvdTfP0gDrPw12qk9WI5he5igRrlOsIHA6RAigze+I8m0kUbd7xheKdiNP+cMCf
 HQjP3+Wu9Ru4io7PduEyY0MF20E6lH2JGScAoTQWlJiMgMQiA3gb4cMWONpl/4ulWTcg
 3wXCa3SEfc9rrx3Re7Jvg95KRfcW7M4DCv/2Ld3p5cLgHt2jL/iMF5YLJsExIBQPaEA+
 z97zBf1y9M7n5P98O8YgrKgfCOL6yzRryf0DTe3nWkzqlIYObXqC5kEbQap40S5L8W3A
 N2jGGH+1Tp1eaVwocWUY4/DLtjOAMuzmQm41K7qLNKyNIktHZ1RW1L3pzFx0RorTKdnz
 2huw==
X-Gm-Message-State: AOAM532dhyZMUZX7ULqSuVfEB+Lowrj4TLhL87F/b56ug7oZIhLsiWRe
 x9qQdcj9klFDfOVJDN95DFi2rKV33+CAMjibNmA=
X-Google-Smtp-Source: ABdhPJzNG5yPgsPz7Z4DMg4XRabbaa+1v40nfWt19I4+L8A4CvPmmWemTtlyMJ4sTPkVaL/+nnGkQQ==
X-Received: by 2002:a17:90b:3a8a:b0:1d9:739f:96ba with SMTP id
 om10-20020a17090b3a8a00b001d9739f96bamr21313240pjb.117.1651111876236; 
 Wed, 27 Apr 2022 19:11:16 -0700 (PDT)
Received: from chachonne.lan ([2600:1700:8a10:4fd0::e])
 by smtp.gmail.com with ESMTPSA id
 z24-20020a63d018000000b003c14af50629sm632733pgf.65.2022.04.27.19.11.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Apr 2022 19:11:15 -0700 (PDT)
From: ricetons@gmail.com
To: amd-gfx@lists.freedesktop.org,
	ckoenig.leichtzumerken@gmail.com
Subject: [PATCH v3] drm/amdgpu: Ensure the DMA engine is deactivated during
 set ups
Date: Wed, 27 Apr 2022 19:11:09 -0700
Message-Id: <20220428021109.2571-1-ricetons@gmail.com>
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
Cc: Haohui Mai <haohui@alt-chain.io>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Haohui Mai <haohui@alt-chain.io>

The patch fully deactivates the DMA engine before setting up the ring
buffer to avoid potential data races and crashes.

Signed-off-by: Haohui Mai <haohui@alt-chain.io>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 110 +++++++++++++------------
 1 file changed, 59 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 013d2dec81d0..a22aafd2d7f6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -459,7 +459,6 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 	}
 }
 
-
 /**
  * sdma_v5_2_gfx_stop - stop the gfx async dma engines
  *
@@ -505,17 +504,21 @@ static void sdma_v5_2_rlc_stop(struct amdgpu_device *adev)
 }
 
 /**
- * sdma_v5_2_ctx_switch_enable - stop the async dma engines context switch
+ * sdma_v5_2_ctx_switch_enable_for_instance - start the async dma engines
+ * context switch for an instance
  *
  * @adev: amdgpu_device pointer
- * @enable: enable/disable the DMA MEs context switch.
+ * @instance_idx: the index of the SDMA instance
  *
- * Halt or unhalt the async dma engines context switch.
+ * Unhalt the async dma engines context switch.
  */
-static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
+static void sdma_v5_2_ctx_switch_enable_for_instance(struct amdgpu_device *adev, int instance_idx)
 {
 	u32 f32_cntl, phase_quantum = 0;
-	int i;
+
+	if (WARN_ON(instance_idx >= adev->sdma.num_instances)) {
+		return;
+	}
 
 	if (amdgpu_sdma_phase_quantum) {
 		unsigned value = amdgpu_sdma_phase_quantum;
@@ -539,61 +542,71 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
 		phase_quantum =
 			value << SDMA0_PHASE0_QUANTUM__VALUE__SHIFT |
 			unit  << SDMA0_PHASE0_QUANTUM__UNIT__SHIFT;
-	}
-
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (enable && amdgpu_sdma_phase_quantum) {
-			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
-			       phase_quantum);
-			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
-			       phase_quantum);
-			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
-			       phase_quantum);
-		}
 
-		if (!amdgpu_sriov_vf(adev)) {
-			f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
-			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
-					AUTO_CTXSW_ENABLE, enable ? 1 : 0);
-			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
-		}
+		WREG32_SOC15_IP(GC,
+			sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE0_QUANTUM),
+			phase_quantum);
+		WREG32_SOC15_IP(GC,
+			sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE1_QUANTUM),
+		    phase_quantum);
+		WREG32_SOC15_IP(GC,
+			sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_PHASE2_QUANTUM),
+		    phase_quantum);
 	}
 
+	if (!amdgpu_sriov_vf(adev)) {
+		f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_CNTL));
+		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
+				AUTO_CTXSW_ENABLE, 1);
+		WREG32(sdma_v5_2_get_reg_offset(adev, instance_idx, mmSDMA0_CNTL), f32_cntl);
+	}
 }
 
 /**
- * sdma_v5_2_enable - stop the async dma engines
+ * sdma_v5_2_ctx_switch_disable_all - stop the async dma engines context switch
  *
  * @adev: amdgpu_device pointer
- * @enable: enable/disable the DMA MEs.
  *
- * Halt or unhalt the async dma engines.
+ * Halt the async dma engines context switch.
  */
-static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
+static void sdma_v5_2_ctx_switch_disable_all(struct amdgpu_device *adev)
 {
 	u32 f32_cntl;
 	int i;
 
-	if (!enable) {
-		sdma_v5_2_gfx_stop(adev);
-		sdma_v5_2_rlc_stop(adev);
-	}
+	if (amdgpu_sriov_vf(adev))
+		return;
 
-	if (!amdgpu_sriov_vf(adev)) {
-		for (i = 0; i < adev->sdma.num_instances; i++) {
-			f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
-			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
-			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
-		}
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
+		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
+				AUTO_CTXSW_ENABLE, 0);
+		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
 	}
 }
 
+/**
+ * sdma_v5_2_halt - stop the async dma engines
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Halt the async dma engines.
+ */
+static void sdma_v5_2_halt(struct amdgpu_device *adev)
+{
+	sdma_v5_2_gfx_stop(adev);
+	sdma_v5_2_rlc_stop(adev);
+}
+
 /**
  * sdma_v5_2_gfx_resume - setup and start the async dma engines
  *
  * @adev: amdgpu_device pointer
  *
  * Set up the gfx DMA ring buffers and enable them.
+ * It assumes that the dma engine is stopped for each instance.
+ * The function enables the engine and preemptions sequentially for each instance.
+ *
  * Returns 0 for success, error for failure.
  */
 static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
@@ -737,10 +750,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 
 		ring->sched.ready = true;
 
-		if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
-			sdma_v5_2_ctx_switch_enable(adev, true);
-			sdma_v5_2_enable(adev, true);
-		}
+		sdma_v5_2_ctx_switch_enable_for_instance(adev, i);
 
 		r = amdgpu_ring_test_ring(ring);
 		if (r) {
@@ -784,7 +794,7 @@ static int sdma_v5_2_load_microcode(struct amdgpu_device *adev)
 	int i, j;
 
 	/* halt the MEs */
-	sdma_v5_2_enable(adev, false);
+	sdma_v5_2_halt(adev);
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		if (!adev->sdma.instance[i].fw)
@@ -856,8 +866,8 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
 	int r = 0;
 
 	if (amdgpu_sriov_vf(adev)) {
-		sdma_v5_2_ctx_switch_enable(adev, false);
-		sdma_v5_2_enable(adev, false);
+		sdma_v5_2_ctx_switch_disable_all(adev);
+		sdma_v5_2_halt(adev);
 
 		/* set RB registers */
 		r = sdma_v5_2_gfx_resume(adev);
@@ -881,12 +891,10 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
 		amdgpu_gfx_off_ctrl(adev, false);
 
 	sdma_v5_2_soft_reset(adev);
-	/* unhalt the MEs */
-	sdma_v5_2_enable(adev, true);
-	/* enable sdma ring preemption */
-	sdma_v5_2_ctx_switch_enable(adev, true);
 
-	/* start the gfx rings and rlc compute queues */
+	/* Soft reset supposes to disable the dma engine and preemption.
+	 * Now start the gfx rings and rlc compute queues.
+	 */
 	r = sdma_v5_2_gfx_resume(adev);
 	if (adev->in_s0ix)
 		amdgpu_gfx_off_ctrl(adev, true);
@@ -1340,8 +1348,8 @@ static int sdma_v5_2_hw_fini(void *handle)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	sdma_v5_2_ctx_switch_enable(adev, false);
-	sdma_v5_2_enable(adev, false);
+	sdma_v5_2_ctx_switch_disable_all(adev);
+	sdma_v5_2_halt(adev);
 
 	return 0;
 }
-- 
2.25.1


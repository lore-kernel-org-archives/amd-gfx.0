Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD324C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Apr 2022 09:53:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2387910FA8D;
	Thu, 28 Apr 2022 09:53:40 +0000 (UTC)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com
 [IPv6:2607:f8b0:4864:20::52e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B051910FA81
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 09:53:38 +0000 (UTC)
Received: by mail-pg1-x52e.google.com with SMTP id k14so3606420pga.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 02:53:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=xSiZzYgxcy5xMUbKKebD9NxYfz3rcWtPLbLFz9YOus8=;
 b=bVaoMBuxoyiYe1VuKh5Lq18hfubrfOhjxw9Sm8lqwe7EzELcvNOqiYbpQAoi0iGljI
 5QVcnYvZ3P7YrikgvfbW3TRF2q9CHXOwlAaofzTEcWPOLymJo0K7Zm5ustyTJWOGw8AS
 e/EV5dxfgYIFZBjv4ctfAWCmaJsGbfperL7aw8SG7g+5VLHKGBrbL+X6Idd0kjtllf2c
 bmNWbRuQqFbM9ZEa+pyuRvKODEq3jFj5FxtO5lckYR9jZ8SX6sLxx0Ljvs5+prMVLKXi
 LG82XFOxy/Nqs3/q7CD8lrMY0WitgmtBeFU5hJSeNNq5sFnbTqmhuJRtGATIjJx6ja+Z
 2yBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=xSiZzYgxcy5xMUbKKebD9NxYfz3rcWtPLbLFz9YOus8=;
 b=Q1lLPrHV+D2CHyCRicywJGY8zwSwevvHel7zwSe4F6/fUPpoY1hoTFiQSRvOkKc0es
 vXwUQEKiF7Y5kgC1ICuWYHkNZ7gGYPoiVZpScZHIgNRtWwY3A2SrQ8EV90SUvjUYmwMi
 lTr2GsuZYZPp/iDpVLaOcjx2l/A/2//WIrsk6xBnJj2JLGavt9XZrUHrjyo+6Fxmsf7F
 CNQlP1AknSobUUNyGrTlvGzVk+xXaWE0iOhuSQIdd6omfCRnvPWMOJ3gHG4+iTZ0+DhB
 9nTtmP9c5mDB+LQfTq2IfgQwceuPGpnxwduHtMcbO+CIsNz6gPZSffKgCOAu2cb28j98
 NYmg==
X-Gm-Message-State: AOAM5333rcDVRohmpCS0rtnHtXoTqaE+ykU7kHaHYbQPRoa2NhpWd3P8
 mRESvy3feyjGLrMN0gI+UzBAPZWsYXa97H57T1k=
X-Google-Smtp-Source: ABdhPJyg71B+uw2hbw4xBEtarxX3j243JpK8w8ph6eo0plnmdZwmpwmA6kMRXMbcjtX52+f5mGhmUw==
X-Received: by 2002:a63:80c8:0:b0:3c1:834f:83a9 with SMTP id
 j191-20020a6380c8000000b003c1834f83a9mr1181553pgd.96.1651139618050; 
 Thu, 28 Apr 2022 02:53:38 -0700 (PDT)
Received: from chachonne.lan ([2600:1700:8a10:4fd0::e])
 by smtp.gmail.com with ESMTPSA id
 y198-20020a62cecf000000b0050d436ad942sm13379744pfg.16.2022.04.28.02.53.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 02:53:37 -0700 (PDT)
From: ricetons@gmail.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4] drm/amdgpu: Ensure the DMA engine is deactivated during
 set ups
Date: Thu, 28 Apr 2022 02:53:27 -0700
Message-Id: <20220428095327.10513-1-ricetons@gmail.com>
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
Cc: yifan1.zhang@amd.com, Guchun.Chen@amd.com, ckoenig.leichtzumerken@gmail.com,
 Haohui Mai <ricetons@gmail.com>, lang.yu@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Haohui Mai <ricetons@gmail.com>

The patch fully deactivates the DMA engine before setting up the ring
buffer to avoid potential data races and crashes.

The v4 patch addresses the comments from Lang Yu <Lang.Yu@amd.com>.

Signed-off-by: Haohui Mai <ricetons@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 113 ++++++++++++++-----------
 1 file changed, 62 insertions(+), 51 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 013d2dec81d0..b000117b77d0 100644
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
@@ -865,6 +875,9 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
 	}
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
+		sdma_v5_2_ctx_switch_disable_all(adev);
+		sdma_v5_2_halt(adev);
+
 		r = sdma_v5_2_load_microcode(adev);
 		if (r)
 			return r;
@@ -881,12 +894,10 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
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
@@ -1340,8 +1351,8 @@ static int sdma_v5_2_hw_fini(void *handle)
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


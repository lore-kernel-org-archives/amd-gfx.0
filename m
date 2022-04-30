Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF241C433F5
	for <amd-gfx@archiver.kernel.org>; Sat, 30 Apr 2022 07:34:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ADA210FAEB;
	Sat, 30 Apr 2022 07:34:05 +0000 (UTC)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com
 [IPv6:2607:f8b0:4864:20::529])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2C22C10FAEB
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Apr 2022 07:34:04 +0000 (UTC)
Received: by mail-pg1-x529.google.com with SMTP id 15so8096085pgf.4
 for <amd-gfx@lists.freedesktop.org>; Sat, 30 Apr 2022 00:34:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=P2Mz6XCrQQwdMhlrz8bMpbBduv+hlJWYJqGIoEFgzWo=;
 b=AlpQJB3vDcMbPdKzE5j3c36zOOFJzztfMwfbfuczj5NZ7sd46UQnQVB/wnB1f2O1HL
 nXheWTQZrrlKeUAR90kf2LGjHhp2F7hMm/OaKCOIC/tB4PJQ5mryaIwNeLv2kmqTXEWY
 ODdsVmD3yKdvcacIjWBmtrvwkWlCebwPurPnELm15f77WC4LGJ2rnOh3KAqP7jAlaM5T
 yLaJedtALU6bXM5MWB5NvOfrWmV8oOPPUT6H1smJvAbebDTQGklo83FUnv9eL7i5fI/I
 FNi6iDiUwkslhSSbTnB36QyeUBptqC+jB+rEfaRIbje/We3Oxoqtuh30jPTV3l+uW6jI
 JbLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=P2Mz6XCrQQwdMhlrz8bMpbBduv+hlJWYJqGIoEFgzWo=;
 b=TCcn7hyjerQJ8lQ4WSKMhbV2Y0QuJv2ND/LvTezvBBOV25zYDrAV2QFGaaCdFRWxlF
 A5zEo33kHN8VLYkrip2P2oym8my6BS17/kmh44a78/Rqlq1LV6XsSE/hV0DnaBnu85VX
 zEcDfyXZsrRVIAP04cb4TjAv+xTtrZpUqz43dI/QQ92p9ecmCzNAd4eNPnAJ6Oo9PF9h
 LGsgTtfezpZqkqS8WoOyTtwaWvCXIM6Co/o1iU3wK6/fKnbgE08OlL76FGz/P/DpqF4R
 K4u09K00+KDi7/uyhd8Z7hS45HHpD3xG0MlG9LOrhSWq38dnkRyEe0TjGiE9RX1Ubzh8
 K4kQ==
X-Gm-Message-State: AOAM533hCMdxTxIExyoZRGZBVjeYKKBP+aIU8aXeik8faUltETD+yWiB
 5ymvNf4OC41PuLPSpVNGY01toGmabtlB06t9pYA=
X-Google-Smtp-Source: ABdhPJwaTPHzkfJJZVyhpB8QmR+/N9T6c58LeeEjw3eQzAW32G30Gr1DEcICU9JyNIfNsNjYOYRXmw==
X-Received: by 2002:a65:6a4c:0:b0:39c:f169:b54a with SMTP id
 o12-20020a656a4c000000b0039cf169b54amr2348438pgu.384.1651304043543; 
 Sat, 30 Apr 2022 00:34:03 -0700 (PDT)
Received: from chachonne.lan ([2600:1700:8a10:4fd0::e])
 by smtp.gmail.com with ESMTPSA id
 x18-20020aa793b2000000b0050dc76281fcsm856681pff.214.2022.04.30.00.34.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 Apr 2022 00:34:02 -0700 (PDT)
From: ricetons@gmail.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v6] drm/amdgpu: Ensure the DMA engine is deactivated during
 set ups
Date: Sat, 30 Apr 2022 00:34:00 -0700
Message-Id: <20220430073400.2494-1-ricetons@gmail.com>
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

Signed-off-by: Haohui Mai <ricetons@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 109 +++++++++++++++----------
 1 file changed, 64 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 013d2dec81d0..1fac9d8e99de 100644
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
@@ -539,50 +542,68 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
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
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
+		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
+				AUTO_CTXSW_ENABLE, 0);
+		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
 	}
+}
+
+/**
+ * sdma_v5_2_halt - stop the async dma engines
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Halt the async dma engines.
+ */
+static void sdma_v5_2_halt(struct amdgpu_device *adev)
+{
+	int i;
+	u32 f32_cntl;
+
+	sdma_v5_2_gfx_stop(adev);
+	sdma_v5_2_rlc_stop(adev);
 
 	if (!amdgpu_sriov_vf(adev)) {
 		for (i = 0; i < adev->sdma.num_instances; i++) {
 			f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL));
-			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
+			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, 1);
 			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_F32_CNTL), f32_cntl);
 		}
 	}
@@ -594,6 +615,9 @@ static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
  * @adev: amdgpu_device pointer
  *
  * Set up the gfx DMA ring buffers and enable them.
+ * It assumes that the dma engine is stopped for each instance.
+ * The function enables the engine and preemptions sequentially for each instance.
+ *
  * Returns 0 for success, error for failure.
  */
 static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
@@ -737,10 +761,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 
 		ring->sched.ready = true;
 
-		if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
-			sdma_v5_2_ctx_switch_enable(adev, true);
-			sdma_v5_2_enable(adev, true);
-		}
+		sdma_v5_2_ctx_switch_enable_for_instance(adev, i);
 
 		r = amdgpu_ring_test_ring(ring);
 		if (r) {
@@ -784,7 +805,7 @@ static int sdma_v5_2_load_microcode(struct amdgpu_device *adev)
 	int i, j;
 
 	/* halt the MEs */
-	sdma_v5_2_enable(adev, false);
+	sdma_v5_2_halt(adev);
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		if (!adev->sdma.instance[i].fw)
@@ -856,8 +877,8 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
 	int r = 0;
 
 	if (amdgpu_sriov_vf(adev)) {
-		sdma_v5_2_ctx_switch_enable(adev, false);
-		sdma_v5_2_enable(adev, false);
+		sdma_v5_2_ctx_switch_disable_all(adev);
+		sdma_v5_2_halt(adev);
 
 		/* set RB registers */
 		r = sdma_v5_2_gfx_resume(adev);
@@ -881,12 +902,10 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
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
@@ -1340,8 +1359,8 @@ static int sdma_v5_2_hw_fini(void *handle)
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


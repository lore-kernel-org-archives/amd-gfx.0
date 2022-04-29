Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 894D2C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 29 Apr 2022 04:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D63C510FB54;
	Fri, 29 Apr 2022 04:51:37 +0000 (UTC)
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com
 [IPv6:2607:f8b0:4864:20::436])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09BD110FB51
 for <amd-gfx@lists.freedesktop.org>; Fri, 29 Apr 2022 04:51:37 +0000 (UTC)
Received: by mail-pf1-x436.google.com with SMTP id x52so4422565pfu.11
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Apr 2022 21:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=ZxBloixaKKK98ESgFqFsH+Zz8Z1ePr8ZWznxvTsKBec=;
 b=VYacc6MsJMpdkVMq0eTZvV2vb5XEjy04XXWcoLp3JTcqAOYJflb7IzB3TnR7FFgs1Q
 gNePjzu7bYOyYtG2ufQtzwwnsvE76vuv96AuUyB+cBGLo/+maQGpQHwswM2DmcAO9+nB
 cIQqMxY1KovmmCwVdWaIs5cAgNnl3QGMSq16BpGU0pD7kD/gJbTsjIl1gzvS6kr+olfv
 T9NJkWW/M1oQ02wl2C//UCO1Nv6FNJh//mD2cPxm3K27+qwtO0XJDuVxO6tVrrCfm+rw
 vVKhTQ5jxqZMr++8a858AG4+TId2vxQJXy+/Dhs8cGpuPQhscDroqz63JbDNnrEGwK1y
 XVaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ZxBloixaKKK98ESgFqFsH+Zz8Z1ePr8ZWznxvTsKBec=;
 b=IBE2r3aRozYm0ATP19hhBDRrp9DyUF7olAhfclB+5ftj2x33VjcsMQVximRZE7jcQP
 XmxWGTFSbIzcgUWuuvfXlCAMmZvEycCw3iZYRawWiMjx/4ap1qQZxCmX8Ml8xKK1iwJ7
 +jugKti6V1iLGqWv2XHvXxhovQzNkntz5Z1tk90bfVxFnlCXNzYp6H4jLZd9eGxTYNBg
 hzuY4rDAuy2F1uVf20DDXQkLkiaslzIBxeab4H90HcfJORcAthx2pRp3Ht1QsJJ4zDwx
 Mi7n9bqmLL2J0CLHdiXMeUYPpffAdIOSW8+F/+1zVSYlwwpwFYQOM2v39236hlY7kt9E
 h78Q==
X-Gm-Message-State: AOAM533ZqT3vk+TEbbch5WOFCCzRsNTE0mvIJP0YnCrUHXRokYyvBq13
 7YZ0nzuVTLB68wtHECbUdSJJj4EkPh011RRvJxY=
X-Google-Smtp-Source: ABdhPJxeR0RjiElYf/ABKrMBFDzITFJHDfq4/oHXE8bpIJOUodLz+RPLiesCFPG4hnhjZBiGQI549w==
X-Received: by 2002:a63:eb13:0:b0:382:1cd5:7d06 with SMTP id
 t19-20020a63eb13000000b003821cd57d06mr31172069pgh.280.1651207896342; 
 Thu, 28 Apr 2022 21:51:36 -0700 (PDT)
Received: from chachonne.lan ([2600:1700:8a10:4fd0::e])
 by smtp.gmail.com with ESMTPSA id
 i5-20020a62c105000000b0050d46c15da4sm1391776pfg.89.2022.04.28.21.51.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Apr 2022 21:51:35 -0700 (PDT)
From: ricetons@gmail.com
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v5] drm/amdgpu: Ensure the DMA engine is deactivated during
 set ups
Date: Thu, 28 Apr 2022 21:51:33 -0700
Message-Id: <20220429045133.17740-1-ricetons@gmail.com>
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
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 112 +++++++++++++++----------
 1 file changed, 67 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 013d2dec81d0..e9d204895716 100644
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
@@ -865,6 +886,9 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
 	}
 
 	if (adev->firmware.load_type == AMDGPU_FW_LOAD_DIRECT) {
+		sdma_v5_2_ctx_switch_disable_all(adev);
+		sdma_v5_2_halt(adev);
+
 		r = sdma_v5_2_load_microcode(adev);
 		if (r)
 			return r;
@@ -881,12 +905,10 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
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
@@ -1340,8 +1362,8 @@ static int sdma_v5_2_hw_fini(void *handle)
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


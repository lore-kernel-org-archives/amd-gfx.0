Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5D2C433EF
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 12:31:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 036FC10F3B7;
	Wed, 27 Apr 2022 12:31:46 +0000 (UTC)
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com
 [IPv6:2607:f8b0:4864:20::102e])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 48D3510F3BA
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 12:31:44 +0000 (UTC)
Received: by mail-pj1-x102e.google.com with SMTP id
 z5-20020a17090a468500b001d2bc2743c4so1679125pjf.0
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 05:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id;
 bh=B1mDwRbHtFJmKk2O7s9puMrg0PtMIE5Z4H91QlwpoxU=;
 b=CZuH8eP5IaZT9O7ce2SM3SHdFbOQTeiVvN9o/MEp3weaXpctLlSbzL0ScvLV9VstCk
 jqZnMA+SXut+c5bqHLGk4us1pn/tXFTRdrJKB5gjfoRvelBdnHnEfe136oqkxxG1Dv8U
 jLLkMfgbkUEebTxN8jXUnJh5if7HJyQkdSUIIqKsNB2hw+xl+L/qhbB5UpzrbrZlXUPT
 e+nvsY47m8ko6Ga5qivFTr4HENPsenhYW19abud5hPOsPa7DsI1OVCwWmCOiB5b+OTso
 GUyhwppZuIbBORF8go+Wo1+nmEbezbYBWw4KCuw3Mw7E4LWg5Z2cryQve87u+sLvZAj5
 M0lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=B1mDwRbHtFJmKk2O7s9puMrg0PtMIE5Z4H91QlwpoxU=;
 b=FazzG5f4i1DTt7Kd5kl/kaUqu6XhVlWzx2DunivaqBiWGL60r66IBlmlgewrjTSilU
 drUbwKk+X+CL5J0plD7pECj7AowBbWiWhl8QB84dVmOpTo32Wi26QvU6qGkOx9da32VG
 2YeGUAoRhWODaV0OU3w3yUBzZqcfzVXQTUwTmv+EIlz4s/yHlEprJ5VhAozF5KTeA+8N
 ftke4G+hr5qBwDf9clsCpjCtZrvd4dv12Dc42uzYvAV9CFiR/L+52azh4OPdbaDH7L0L
 g0YhFxkpl7oLgKLkqMfn8UmIYDo2GFdPlLi7Q9N57wPTgvc+2bXRQ44r6vA54UNW9YtB
 3mWg==
X-Gm-Message-State: AOAM530Q2jsnwQn2A0zh7J/sN+hW3aDFL8kyllc4mhziL9M0qRa4Nbi5
 AN3fnGLq7V35mT7lu7rGiANWpgFIi5e8UIAC
X-Google-Smtp-Source: ABdhPJykTlAw0jXc9vs5dDg0amR/M3fjm7NA810j+dBqEQ4nHY/gPRygOa27wzWKSPF2hFyJjxOyoQ==
X-Received: by 2002:a17:903:11c9:b0:154:be2d:eb9 with SMTP id
 q9-20020a17090311c900b00154be2d0eb9mr28351379plh.91.1651062703591; 
 Wed, 27 Apr 2022 05:31:43 -0700 (PDT)
Received: from chachonne.lan ([2600:1700:8a10:4fd0::e])
 by smtp.gmail.com with ESMTPSA id
 g15-20020a63be4f000000b0039934531e95sm15936694pgo.18.2022.04.27.05.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Apr 2022 05:31:43 -0700 (PDT)
From: ricetons@gmail.com
To: amd-gfx@lists.freedesktop.org,
	ckoenig.leichtzumerken@gmail.com
Subject: [PATCH v2] drm/amdgpu: Ensure the DMA engine is deactivated during
 set ups
Date: Wed, 27 Apr 2022 05:31:13 -0700
Message-Id: <20220427123113.29345-1-ricetons@gmail.com>
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
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c | 94 ++++++++++++++------------
 1 file changed, 50 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
index 013d2dec81d0..cb3987dd3bda 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c
@@ -459,7 +459,6 @@ static void sdma_v5_2_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
 	}
 }
 
-
 /**
  * sdma_v5_2_gfx_stop - stop the gfx async dma engines
  *
@@ -505,17 +504,19 @@ static void sdma_v5_2_rlc_stop(struct amdgpu_device *adev)
 }
 
 /**
- * sdma_v5_2_ctx_switch_enable - stop the async dma engines context switch
+ * sdma_v5_2_ctx_switch_enable_for_instance - start the async dma engines
+ * context switch for an instance
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
+	WARN_ON(i >= adev->sdma.num_instances);
 
 	if (amdgpu_sdma_phase_quantum) {
 		unsigned value = amdgpu_sdma_phase_quantum;
@@ -539,26 +540,44 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
 		phase_quantum =
 			value << SDMA0_PHASE0_QUANTUM__VALUE__SHIFT |
 			unit  << SDMA0_PHASE0_QUANTUM__UNIT__SHIFT;
-	}
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (enable && amdgpu_sdma_phase_quantum) {
-			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
-			       phase_quantum);
-			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
-			       phase_quantum);
-			WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
-			       phase_quantum);
-		}
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE0_QUANTUM),
+		       phase_quantum);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE1_QUANTUM),
+		       phase_quantum);
+		WREG32_SOC15_IP(GC, sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_PHASE2_QUANTUM),
+		       phase_quantum);
+	}
 
-		if (!amdgpu_sriov_vf(adev)) {
-			f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
-			f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
-					AUTO_CTXSW_ENABLE, enable ? 1 : 0);
-			WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
-		}
+	if (!amdgpu_sriov_vf(adev)) {
+		f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
+		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
+				AUTO_CTXSW_ENABLE, 1);
+		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
 	}
+}
 
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
+
+	if (amdgpu_sriov_vf(adev))
+		return;
+
+	for (i = 0; i < adev->sdma.num_instances; i++) {
+		f32_cntl = RREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL));
+		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
+				AUTO_CTXSW_ENABLE, 0);
+		WREG32(sdma_v5_2_get_reg_offset(adev, i, mmSDMA0_CNTL), f32_cntl);
+	}
 }
 
 /**
@@ -571,21 +590,10 @@ static void sdma_v5_2_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
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
@@ -594,6 +602,9 @@ static void sdma_v5_2_enable(struct amdgpu_device *adev, bool enable)
  * @adev: amdgpu_device pointer
  *
  * Set up the gfx DMA ring buffers and enable them.
+ * It assumes that the dma engine is stopped for each instance.
+ * The function enables the engine and preemptions sequentially for each instance.
+ *
  * Returns 0 for success, error for failure.
  */
 static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
@@ -737,10 +748,7 @@ static int sdma_v5_2_gfx_resume(struct amdgpu_device *adev)
 
 		ring->sched.ready = true;
 
-		if (amdgpu_sriov_vf(adev)) { /* bare-metal sequence doesn't need below to lines */
-			sdma_v5_2_ctx_switch_enable(adev, true);
-			sdma_v5_2_enable(adev, true);
-		}
+		sdma_v5_2_ctx_switch_enable_for_instance(adev, i);
 
 		r = amdgpu_ring_test_ring(ring);
 		if (r) {
@@ -856,7 +864,7 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
 	int r = 0;
 
 	if (amdgpu_sriov_vf(adev)) {
-		sdma_v5_2_ctx_switch_enable(adev, false);
+		sdma_v5_2_ctx_switch_disable_all(adev);
 		sdma_v5_2_enable(adev, false);
 
 		/* set RB registers */
@@ -881,12 +889,10 @@ static int sdma_v5_2_start(struct amdgpu_device *adev)
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
@@ -1340,7 +1346,7 @@ static int sdma_v5_2_hw_fini(void *handle)
 	if (amdgpu_sriov_vf(adev))
 		return 0;
 
-	sdma_v5_2_ctx_switch_enable(adev, false);
+	sdma_v5_2_ctx_switch_disable_all(adev);
 	sdma_v5_2_enable(adev, false);
 
 	return 0;
-- 
2.25.1


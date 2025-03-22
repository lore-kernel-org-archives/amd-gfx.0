Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94CCCC3600B
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 01:47:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F31310E858;
	Sat, 22 Mar 2025 01:47:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YIOslg6Q";
	dkim-atps=neutral
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E79010E855
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 01:47:23 +0000 (UTC)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-4769aef457bso27481071cf.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 18:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742608042; x=1743212842; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=KQinNdRM6oTXNsSjZMWu46oym/Ld8mQsCtICKSmwEjs=;
 b=YIOslg6QiZQnMPf1A+zQ2RwF5O615oZiABRfdmwE65NyAwgkgSa9MibsmA7wraUBj4
 Zi5k5jTcI5CFZGzXFw+YwtQEzzRm0OdaTcKqNgLJQTfC2W13F++6I+L9LOE3VpIvWgia
 JiEYWeRbjpJRfdNXzLvnfX1rZAV6Z1Jmj2ic7UKBo3ZarDYl46W5hHfEw9pKYanXNZ78
 zCwRzQfHa9r5wjHDrEsgayE80XxhIEEEM4iTxoMd0h6cZBn3DE02H4L43HbHMrd8wiLA
 +QczZWgCFOohrt/wAkEcHXxe5v2CuFiT9cGv3YCyNo6JBg/s4P6rpv5D5uptRIEF3OS5
 K8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742608042; x=1743212842;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KQinNdRM6oTXNsSjZMWu46oym/Ld8mQsCtICKSmwEjs=;
 b=v3ZaOykqM6NJON5WsZAKbANQEB2aSyn1Hdy0vpG6bN1mmtuQPzdOE0t3KTuDNGOVxf
 LuC9w/dEhgaemzJjxMU/XhRZ26+Juq2U8P5Fs8euWzJutuL5a0P3eIFHfi1V7LPxsi8f
 wF0TmHMnp2PlTxpVY7Sw0c/06CdWAWY5YVwlBgNTBOVpEBTys1Tlm5VcYpurDhxJwr9d
 ZDgE2b5FXhQiAaGO789uwRtA5FkqqM3XK/0g9n1VJzi6dYuk3ReBsqTRWgpzM5KYO+LN
 l+S16MPFHNtmDrP06Lpxe+bDLQJPXE2uSEzp4MlN0OZaBIbyGrHarcAgeNZC1q8iVIOG
 Uweg==
X-Gm-Message-State: AOJu0YwXATCE8fizoCajEEwRMHEVUq2NwK+wA8y89KOlKBkscb7816p9
 yBRf/HHaA/z4DN+dlTsBfCRCx/NJ28kXkZ5n2++Jz95yaG/T1rYNlYFAcg==
X-Gm-Gg: ASbGnctKy5GrC1rEEX9hl7LhTB6dpV0iJffdIC+3PbepD/7ebxoY7Um6JsHcyNyUkrQ
 iY49eadibebx6g+e41BnZ15vV0hsxM2+P4OUmQMDJz2XqpPvqCUhlQg7LxYsgXomvVGDybEXMnK
 0pXtly0ORpmiea8FK3vudMlxcZ/C3HTGWr45Gls1SaWx7leavCA3XVh8lpBgHdi87tWy/i0JMq3
 BoCUgIG2mNheI7Pr+vzcYGNNM3OT0hS4/NlvveaGqJrjUYjIkVjhdk7BCO2WuY0LQOT78aSvhI0
 0j+FyVAfixSgDE5Ef6kG0raGNFjKkP/oW3fugK3cN+6aOQT+Yzkg0BasYTIIPP8sr9tkgsQ01xw
 E4Q==
X-Google-Smtp-Source: AGHT+IHyoRc3afHsHm6erkUyxabtEdNMkN6OCPwDPT57a9+RSbEOI/raETXtIKDiAq9aKELZicAYhQ==
X-Received: by 2002:a05:622a:540b:b0:476:8960:d1a3 with SMTP id
 d75a77b69052e-4771dd65f73mr78497221cf.14.1742608042261; 
 Fri, 21 Mar 2025 18:47:22 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d159964sm18688591cf.8.2025.03.21.18.47.21
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 18:47:21 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 14/18] drm/amdgpu: move si_dma.c away from sid.h and si_enums.h
Date: Fri, 21 Mar 2025 21:46:56 -0400
Message-ID: <20250322014700.62356-15-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250322014700.62356-1-alexandre.f.demers@gmail.com>
References: <20250322014700.62356-1-alexandre.f.demers@gmail.com>
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

Replace defines for the ones in oss_1_0_d.h and oss_1_0_sh_mask.h

Taking the opportunity to add some comments taken from cik_sdma.c

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/si_dma.c | 108 ++++++++++++++++------------
 drivers/gpu/drm/amd/amdgpu/sid.h    |  36 ----------
 2 files changed, 61 insertions(+), 83 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 3c9b4fb25855..1b8adeabc7f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -40,17 +40,31 @@ static void si_dma_set_buffer_funcs(struct amdgpu_device *adev);
 static void si_dma_set_vm_pte_funcs(struct amdgpu_device *adev);
 static void si_dma_set_irq_funcs(struct amdgpu_device *adev);
 
+/**
+ * si_dma_ring_get_rptr - get the current read pointer
+ *
+ * @ring: amdgpu ring pointer
+ *
+ * Get the current rptr from the hardware (SI).
+ */
 static uint64_t si_dma_ring_get_rptr(struct amdgpu_ring *ring)
 {
 	return *ring->rptr_cpu_addr;
 }
 
+/**
+ * si_dma_ring_get_wptr - get the current write pointer
+ *
+ * @ring: amdgpu ring pointer
+ *
+ * Get the current wptr from the hardware (SI).
+ */
 static uint64_t si_dma_ring_get_wptr(struct amdgpu_ring *ring)
 {
 	struct amdgpu_device *adev = ring->adev;
 	u32 me = (ring == &adev->sdma.instance[0].ring) ? 0 : 1;
 
-	return (RREG32(DMA_RB_WPTR + sdma_offsets[me]) & 0x3fffc) >> 2;
+	return (RREG32(mmDMA_GFX_RB_WPTR + sdma_offsets[me]) & 0x3fffc) >> 2;
 }
 
 static void si_dma_ring_set_wptr(struct amdgpu_ring *ring)
@@ -58,7 +72,7 @@ static void si_dma_ring_set_wptr(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	u32 me = (ring == &adev->sdma.instance[0].ring) ? 0 : 1;
 
-	WREG32(DMA_RB_WPTR + sdma_offsets[me], (ring->wptr << 2) & 0x3fffc);
+	WREG32(mmDMA_GFX_RB_WPTR + sdma_offsets[me], (ring->wptr << 2) & 0x3fffc);
 }
 
 static void si_dma_ring_emit_ib(struct amdgpu_ring *ring,
@@ -119,9 +133,9 @@ static void si_dma_stop(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->sdma.num_instances; i++) {
 		/* dma0 */
-		rb_cntl = RREG32(DMA_RB_CNTL + sdma_offsets[i]);
-		rb_cntl &= ~DMA_RB_ENABLE;
-		WREG32(DMA_RB_CNTL + sdma_offsets[i], rb_cntl);
+		rb_cntl = RREG32(mmDMA_GFX_RB_CNTL + sdma_offsets[i]);
+		rb_cntl &= ~DMA_GFX_RB_CNTL__RB_ENABLE_MASK;
+		WREG32(mmDMA_GFX_RB_CNTL + sdma_offsets[i], rb_cntl);
 	}
 }
 
@@ -142,37 +156,37 @@ static int si_dma_start(struct amdgpu_device *adev)
 		rb_bufsz = order_base_2(ring->ring_size / 4);
 		rb_cntl = rb_bufsz << 1;
 #ifdef __BIG_ENDIAN
-		rb_cntl |= DMA_RB_SWAP_ENABLE | DMA_RPTR_WRITEBACK_SWAP_ENABLE;
+		rb_cntl |= DMA_GFX_RB_CNTL__RB_SWAP_ENABLE_MASK | DMA_GFX_RB_CNTL__RPTR_WRITEBACK_SWAP_ENABLE_MASK;
 #endif
-		WREG32(DMA_RB_CNTL + sdma_offsets[i], rb_cntl);
+		WREG32(mmDMA_GFX_RB_CNTL + sdma_offsets[i], rb_cntl);
 
 		/* Initialize the ring buffer's read and write pointers */
-		WREG32(DMA_RB_RPTR + sdma_offsets[i], 0);
-		WREG32(DMA_RB_WPTR + sdma_offsets[i], 0);
+		WREG32(mmDMA_GFX_RB_RPTR + sdma_offsets[i], 0);
+		WREG32(mmDMA_GFX_RB_WPTR + sdma_offsets[i], 0);
 
 		rptr_addr = ring->rptr_gpu_addr;
 
-		WREG32(DMA_RB_RPTR_ADDR_LO + sdma_offsets[i], lower_32_bits(rptr_addr));
-		WREG32(DMA_RB_RPTR_ADDR_HI + sdma_offsets[i], upper_32_bits(rptr_addr) & 0xFF);
+		WREG32(mmDMA_GFX_RB_RPTR_ADDR_LO + sdma_offsets[i], lower_32_bits(rptr_addr));
+		WREG32(mmDMA_GFX_RB_RPTR_ADDR_HI + sdma_offsets[i], upper_32_bits(rptr_addr) & 0xFF);
 
-		rb_cntl |= DMA_RPTR_WRITEBACK_ENABLE;
+		rb_cntl |= DMA_GFX_RB_CNTL__RPTR_WRITEBACK_ENABLE_MASK;
 
-		WREG32(DMA_RB_BASE + sdma_offsets[i], ring->gpu_addr >> 8);
+		WREG32(mmDMA_GFX_RB_BASE + sdma_offsets[i], ring->gpu_addr >> 8);
 
 		/* enable DMA IBs */
-		ib_cntl = DMA_IB_ENABLE | CMD_VMID_FORCE;
+		ib_cntl = DMA_GFX_IB_CNTL__IB_ENABLE_MASK | DMA_GFX_IB_CNTL__CMD_VMID_FORCE_MASK;
 #ifdef __BIG_ENDIAN
-		ib_cntl |= DMA_IB_SWAP_ENABLE;
+		ib_cntl |= DMA_GFX_IB_CNTL__IB_SWAP_ENABLE_MASK;
 #endif
-		WREG32(DMA_IB_CNTL + sdma_offsets[i], ib_cntl);
+		WREG32(mmDMA_GFX_IB_CNTL + sdma_offsets[i], ib_cntl);
 
-		dma_cntl = RREG32(DMA_CNTL + sdma_offsets[i]);
-		dma_cntl &= ~CTXEMPTY_INT_ENABLE;
-		WREG32(DMA_CNTL + sdma_offsets[i], dma_cntl);
+		dma_cntl = RREG32(mmDMA_CNTL + sdma_offsets[i]);
+		dma_cntl &= ~DMA_CNTL__CTXEMPTY_INT_ENABLE_MASK;
+		WREG32(mmDMA_CNTL + sdma_offsets[i], dma_cntl);
 
 		ring->wptr = 0;
-		WREG32(DMA_RB_WPTR + sdma_offsets[i], ring->wptr << 2);
-		WREG32(DMA_RB_CNTL + sdma_offsets[i], rb_cntl | DMA_RB_ENABLE);
+		WREG32(mmDMA_GFX_RB_WPTR + sdma_offsets[i], ring->wptr << 2);
+		WREG32(mmDMA_GFX_RB_CNTL + sdma_offsets[i], rb_cntl | DMA_GFX_RB_CNTL__RB_ENABLE_MASK);
 
 		r = amdgpu_ring_test_helper(ring);
 		if (r)
@@ -547,9 +561,9 @@ static bool si_dma_is_idle(void *handle)
 {
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	u32 tmp = RREG32(SRBM_STATUS2);
+	u32 tmp = RREG32(mmSRBM_STATUS2);
 
-	if (tmp & (DMA_BUSY_MASK | DMA1_BUSY_MASK))
+	if (tmp & (SRBM_STATUS2__DMA_BUSY_MASK | SRBM_STATUS2__DMA1_BUSY_MASK))
 	    return false;
 
 	return true;
@@ -585,14 +599,14 @@ static int si_dma_set_trap_irq_state(struct amdgpu_device *adev,
 	case AMDGPU_SDMA_IRQ_INSTANCE0:
 		switch (state) {
 		case AMDGPU_IRQ_STATE_DISABLE:
-			sdma_cntl = RREG32(DMA_CNTL + DMA0_REGISTER_OFFSET);
-			sdma_cntl &= ~TRAP_ENABLE;
-			WREG32(DMA_CNTL + DMA0_REGISTER_OFFSET, sdma_cntl);
+			sdma_cntl = RREG32(mmDMA_CNTL + DMA0_REGISTER_OFFSET);
+			sdma_cntl &= ~DMA_CNTL__TRAP_ENABLE_MASK;
+			WREG32(mmDMA_CNTL + DMA0_REGISTER_OFFSET, sdma_cntl);
 			break;
 		case AMDGPU_IRQ_STATE_ENABLE:
-			sdma_cntl = RREG32(DMA_CNTL + DMA0_REGISTER_OFFSET);
-			sdma_cntl |= TRAP_ENABLE;
-			WREG32(DMA_CNTL + DMA0_REGISTER_OFFSET, sdma_cntl);
+			sdma_cntl = RREG32(mmDMA_CNTL + DMA0_REGISTER_OFFSET);
+			sdma_cntl |= DMA_CNTL__TRAP_ENABLE_MASK;
+			WREG32(mmDMA_CNTL + DMA0_REGISTER_OFFSET, sdma_cntl);
 			break;
 		default:
 			break;
@@ -601,14 +615,14 @@ static int si_dma_set_trap_irq_state(struct amdgpu_device *adev,
 	case AMDGPU_SDMA_IRQ_INSTANCE1:
 		switch (state) {
 		case AMDGPU_IRQ_STATE_DISABLE:
-			sdma_cntl = RREG32(DMA_CNTL + DMA1_REGISTER_OFFSET);
-			sdma_cntl &= ~TRAP_ENABLE;
-			WREG32(DMA_CNTL + DMA1_REGISTER_OFFSET, sdma_cntl);
+			sdma_cntl = RREG32(mmDMA_CNTL + DMA1_REGISTER_OFFSET);
+			sdma_cntl &= ~DMA_CNTL__TRAP_ENABLE_MASK;
+			WREG32(mmDMA_CNTL + DMA1_REGISTER_OFFSET, sdma_cntl);
 			break;
 		case AMDGPU_IRQ_STATE_ENABLE:
-			sdma_cntl = RREG32(DMA_CNTL + DMA1_REGISTER_OFFSET);
-			sdma_cntl |= TRAP_ENABLE;
-			WREG32(DMA_CNTL + DMA1_REGISTER_OFFSET, sdma_cntl);
+			sdma_cntl = RREG32(mmDMA_CNTL + DMA1_REGISTER_OFFSET);
+			sdma_cntl |= DMA_CNTL__TRAP_ENABLE_MASK;
+			WREG32(mmDMA_CNTL + DMA1_REGISTER_OFFSET, sdma_cntl);
 			break;
 		default:
 			break;
@@ -647,11 +661,11 @@ static int si_dma_set_clockgating_state(void *handle,
 				offset = DMA0_REGISTER_OFFSET;
 			else
 				offset = DMA1_REGISTER_OFFSET;
-			orig = data = RREG32(DMA_POWER_CNTL + offset);
-			data &= ~MEM_POWER_OVERRIDE;
+			orig = data = RREG32(mmDMA_POWER_CNTL + offset);
+			data &= ~DMA_POWER_CNTL__MEM_POWER_OVERRIDE_MASK;
 			if (data != orig)
-				WREG32(DMA_POWER_CNTL + offset, data);
-			WREG32(DMA_CLK_CTRL + offset, 0x00000100);
+				WREG32(mmDMA_POWER_CNTL + offset, data);
+			WREG32(mmDMA_CLK_CTRL + offset, 0x00000100);
 		}
 	} else {
 		for (i = 0; i < adev->sdma.num_instances; i++) {
@@ -659,15 +673,15 @@ static int si_dma_set_clockgating_state(void *handle,
 				offset = DMA0_REGISTER_OFFSET;
 			else
 				offset = DMA1_REGISTER_OFFSET;
-			orig = data = RREG32(DMA_POWER_CNTL + offset);
-			data |= MEM_POWER_OVERRIDE;
+			orig = data = RREG32(mmDMA_POWER_CNTL + offset);
+			data |= DMA_POWER_CNTL__MEM_POWER_OVERRIDE_MASK;
 			if (data != orig)
-				WREG32(DMA_POWER_CNTL + offset, data);
+				WREG32(mmDMA_POWER_CNTL + offset, data);
 
-			orig = data = RREG32(DMA_CLK_CTRL + offset);
+			orig = data = RREG32(mmDMA_CLK_CTRL + offset);
 			data = 0xff000000;
 			if (data != orig)
-				WREG32(DMA_CLK_CTRL + offset, data);
+				WREG32(mmDMA_CLK_CTRL + offset, data);
 		}
 	}
 
@@ -681,11 +695,11 @@ static int si_dma_set_powergating_state(void *handle,
 
 	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
 
-	WREG32(DMA_PGFSM_WRITE,  0x00002000);
-	WREG32(DMA_PGFSM_CONFIG, 0x100010ff);
+	WREG32(mmDMA_PGFSM_WRITE,  0x00002000);
+	WREG32(mmDMA_PGFSM_CONFIG, 0x100010ff);
 
 	for (tmp = 0; tmp < 5; tmp++)
-		WREG32(DMA_PGFSM_WRITE, 0);
+		WREG32(mmDMA_PGFSM_WRITE, 0);
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgpu/sid.h
index 8007d4d0d736..4507e2fcd9c8 100644
--- a/drivers/gpu/drm/amd/amdgpu/sid.h
+++ b/drivers/gpu/drm/amd/amdgpu/sid.h
@@ -1559,44 +1559,11 @@
 #define DMA0_REGISTER_OFFSET                              0x0 /* not a register */
 #define DMA1_REGISTER_OFFSET                              0x200 /* not a register */
 
-#define DMA_RB_CNTL                                       0x3400
-#       define DMA_RB_ENABLE                              (1 << 0)
-#       define DMA_RB_SIZE(x)                             ((x) << 1) /* log2 */
-#       define DMA_RB_SWAP_ENABLE                         (1 << 9) /* 8IN32 */
-#       define DMA_RPTR_WRITEBACK_ENABLE                  (1 << 12)
-#       define DMA_RPTR_WRITEBACK_SWAP_ENABLE             (1 << 13)  /* 8IN32 */
-#       define DMA_RPTR_WRITEBACK_TIMER(x)                ((x) << 16) /* log2 */
-#define DMA_RB_BASE                                       0x3401
-#define DMA_RB_RPTR                                       0x3402
-#define DMA_RB_WPTR                                       0x3403
-
-#define DMA_RB_RPTR_ADDR_HI                               0x3407
-#define DMA_RB_RPTR_ADDR_LO                               0x3408
-
-#define DMA_IB_CNTL                                       0x3409
-#       define DMA_IB_ENABLE                              (1 << 0)
-#       define DMA_IB_SWAP_ENABLE                         (1 << 4)
-#       define CMD_VMID_FORCE                             (1 << 31)
 #define DMA_IB_RPTR                                       0x340a
-#define DMA_CNTL                                          0x340b
-#       define TRAP_ENABLE                                (1 << 0)
-#       define SEM_INCOMPLETE_INT_ENABLE                  (1 << 1)
-#       define SEM_WAIT_INT_ENABLE                        (1 << 2)
-#       define DATA_SWAP_ENABLE                           (1 << 3)
-#       define FENCE_SWAP_ENABLE                          (1 << 4)
-#       define CTXEMPTY_INT_ENABLE                        (1 << 28)
-#define DMA_STATUS_REG                                    0x340d
-#       define DMA_IDLE                                   (1 << 0)
 #define DMA_TILING_CONFIG  				  0x342e
 
-#define	DMA_POWER_CNTL					0x342f
-#       define MEM_POWER_OVERRIDE                       (1 << 8)
-#define	DMA_CLK_CTRL					0x3430
-
 #define	DMA_PG						0x3435
 #	define PG_CNTL_ENABLE				(1 << 0)
-#define	DMA_PGFSM_CONFIG				0x3436
-#define	DMA_PGFSM_WRITE					0x3437
 
 #define DMA_PACKET(cmd, b, t, s, n)	((((cmd) & 0xF) << 28) |	\
 					 (((b) & 0x1) << 26) |		\
@@ -2042,10 +2009,7 @@
 #define DMA_SEM_INCOMPLETE_TIMER_CNTL                     0x3411
 #define DMA_SEM_WAIT_FAIL_TIMER_CNTL                      0x3412
 #define DMA_MODE                                          0x342f
-#define DMA_RB_RPTR_ADDR_HI                               0x3407
-#define DMA_RB_RPTR_ADDR_LO                               0x3408
 #define DMA_BUSY_MASK 0x20
-#define DMA1_BUSY_MASK 0X40
 #define SDMA_MAX_INSTANCE 2
 
 #define PCIE_BUS_CLK    10000
-- 
2.48.1


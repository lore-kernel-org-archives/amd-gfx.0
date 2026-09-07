Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E390EC79F99
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Sep 2026 20:34:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C49C10E914;
	Mon,  7 Sep 2026 20:34:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OOkQlvhI";
	dkim-atps=neutral
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DD9610E916
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Sep 2026 20:34:02 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-47ddf7b09e5so4447206f8f.1
 for <amd-gfx@lists.freedesktop.org>; Mon, 07 Sep 2026 13:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788813241; x=1789418041; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Pfag7e+1PsN0WADjw7f+IDhBOVakHOa2I3pdBYiLAzg=;
 b=OOkQlvhIHAp7aNSXHppPIeaDobaMLoSCskQ6t9m4Ctq1PkTKCJZCPitokusR3I5Z3j
 1z1U1uQV6HOID+h7KGzQOilfZgQHS4JtrVy3qBbSj+EaXzPA/PYYe0IeOJWmuGiE92is
 GS+1O5rYLO3BNLJ9i7+wCwmu4xi82r+G2htYj6ZKHhs4wZCo1V3TRyK5gGmX9gHih8eH
 lOhjqajLNliBIef1029oQjM0iO5dlg/kR8yFw06tizylcfkE/RPSj0xOuaCh6QEnRbLI
 eJZUgEPLcysQSGNLJjET/n/9QWcDQp2/zwLGE2TU2ea3YvvYtoSykAZuOlbhqKwNT0CW
 st8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788813241; x=1789418041;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Pfag7e+1PsN0WADjw7f+IDhBOVakHOa2I3pdBYiLAzg=;
 b=QGqkDEJR/T4L87uOyrnTcj7v6IXRxdYtyoVG40d/WrFHgp8T0NHrBPS/skfNnmgOHe
 mheomf6A9qXdb626KFlOztGmlHmKu4/27uD0shmmceL3+D2yYjVQ3tH+xZa/T8fzrc+M
 7TsSfrMeGmICxAIH/G8OTVFeNGv+GgkG2m1ZP0HL1+5tmyBdYx2aP/4w9lqOKCMYGdk7
 TVN4vansz6O62YN8dQvPkq0pbP5Y/a3yhb0SFRlojKd5f/Ji9FPdKESJTtMSmpzVv07p
 Ix8g0UkbM3SKCpU+d4S0+65/cTaWqv1cRf2KzbLDa7orN9JuYhlOXue0sKBmimzH5OgC
 QkBQ==
X-Gm-Message-State: AFuF++m5HFspU0kIvkN8Ddkm1VrJygwDbHhmO2Z0b7GPUhJvVDzQx4tl
 IBDkeKwL/vXbDmlovB9XaQJeoWAiw0ZGyBSY6nDRQu7MYQ9MTZ+8XB5iGzZhCHKK
X-Gm-Gg: AYBFou0fdQXmKRmN5m16lBV9RWmfxGv/WYPTxe1WEWgKManBUueXmimUxndDh1xaGMR
 BinohRFFZsYKurmZdYrlfU42/k0Fm8NQfnoUuV2E7XRST+b4DiClWXN/mKka3Q4aFzK+pD4M3u6
 ai9MklGEylJ5yFrVlluMngoZLtwjhxQC8A8V2O/xzbDIc2CFc0TTLTqtFrYn9mH8h6kP+eAK3xN
 clZUd0Yfvyfu5QPve50szheiyNLvjFyyUQvj2ShUj57Kt771k6k85ucVtJBBGzT8tgcCLQA+qws
 ACeyCYtHsbB6QdNSZIFHhXQjrHptmf3KHrXX9eVp5FftFOiSHlqA+g+fl/GY2GWXRaJTCTvmLiK
 NNO502lnTg4WGro4aaJJJkBRRHKcxej8Mh0FoYTOLvpRXPUYS+hhRhl3XfMserHORymNMG0ix/P
 L3ARN49X3iAyneV9HLMa1He3ta9M7vQMfysniVfGEhHGUclNKvAL/ljSPenR8VMmkK8Cd5mScFA
 ZROOBM9DJ2HgFRGzwMF
X-Received: by 2002:a05:6000:228a:b0:485:8c16:a331 with SMTP id
 ffacd0b85a97d-4858c16a578mr21488569f8f.38.1788813240573; 
 Mon, 07 Sep 2026 13:34:00 -0700 (PDT)
Received: from Timur-Max (athedsl-4460056.home.otenet.gr. [79.129.254.8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48594172546sm22191354f8f.15.2026.09.07.13.33.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 13:34:00 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, pierre-eric.pelloux-prayer@amd.com,
 Natalie Vock <nat@pixelcluster.dev>, Lijo Lazar <lijo.lazar@amd.com>,
 Felix Kuehling <Felix.Kuehling@amd.com>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 10/12] drm/amdgpu/sdma: Refactor SDMA v4.0 functions to be per
 instance
Date: Mon,  7 Sep 2026 22:33:14 +0200
Message-ID: <20260907203316.159103-11-timur.kristof@gmail.com>
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

This prepares the code for implementing recovery for SDMA 4.0.

Reorganize the SDMA 4.0 code so that the functions that are
responsible for managing the SDMA engines take an instance ID
as an argument.

This makes it possible to manage the SDMA instances
independently of each other, which will enable us to
also use these functions to implement resetting and
recovering them independently.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c | 253 +++++++++++++------------
 1 file changed, 131 insertions(+), 122 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
index bdd140887e10..038e1ee8ff4c 100644
--- a/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/sdma_v4_0.c
@@ -915,60 +915,61 @@ static void sdma_v4_0_ring_emit_fence(struct amdgpu_ring *ring, u64 addr, u64 se
  * sdma_v4_0_gfx_enable - enable the gfx async dma engines
  *
  * @adev: amdgpu_device pointer
+ * @instance_id: SDMA engine instance ID
  * @enable: enable SDMA RB/IB
  * control the gfx async dma ring buffers (VEGA10).
  */
-static void sdma_v4_0_gfx_enable(struct amdgpu_device *adev, bool enable)
+static void sdma_v4_0_gfx_enable(struct amdgpu_device *adev,
+				 const u32 instance_id,
+				 const bool enable)
 {
 	u32 rb_cntl, ib_cntl;
-	int i;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		rb_cntl = RREG32_SDMA(i, mmSDMA0_GFX_RB_CNTL);
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, enable ? 1 : 0);
-		WREG32_SDMA(i, mmSDMA0_GFX_RB_CNTL, rb_cntl);
-		ib_cntl = RREG32_SDMA(i, mmSDMA0_GFX_IB_CNTL);
-		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, enable ? 1 : 0);
-		WREG32_SDMA(i, mmSDMA0_GFX_IB_CNTL, ib_cntl);
-	}
+	rb_cntl = RREG32_SDMA(instance_id, mmSDMA0_GFX_RB_CNTL);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_GFX_RB_CNTL, RB_ENABLE, enable ? 1 : 0);
+	WREG32_SDMA(instance_id, mmSDMA0_GFX_RB_CNTL, rb_cntl);
+	ib_cntl = RREG32_SDMA(instance_id, mmSDMA0_GFX_IB_CNTL);
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_GFX_IB_CNTL, IB_ENABLE, enable ? 1 : 0);
+	WREG32_SDMA(instance_id, mmSDMA0_GFX_IB_CNTL, ib_cntl);
 }
 
 /**
  * sdma_v4_0_page_stop - stop the page async dma engines
  *
  * @adev: amdgpu_device pointer
+ * @instance_id: SDMA engine instance ID
  *
  * Stop the page async dma ring buffers (VEGA10).
  */
-static void sdma_v4_0_page_stop(struct amdgpu_device *adev)
+static void sdma_v4_0_page_stop(struct amdgpu_device *adev,
+				const u32 instance_id)
 {
 	u32 rb_cntl, ib_cntl;
-	int i;
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		rb_cntl = RREG32_SDMA(i, mmSDMA0_PAGE_RB_CNTL);
-		rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_PAGE_RB_CNTL,
-					RB_ENABLE, 0);
-		WREG32_SDMA(i, mmSDMA0_PAGE_RB_CNTL, rb_cntl);
-		ib_cntl = RREG32_SDMA(i, mmSDMA0_PAGE_IB_CNTL);
-		ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_PAGE_IB_CNTL,
-					IB_ENABLE, 0);
-		WREG32_SDMA(i, mmSDMA0_PAGE_IB_CNTL, ib_cntl);
-	}
+	rb_cntl = RREG32_SDMA(instance_id, mmSDMA0_PAGE_RB_CNTL);
+	rb_cntl = REG_SET_FIELD(rb_cntl, SDMA0_PAGE_RB_CNTL,
+				RB_ENABLE, 0);
+	WREG32_SDMA(instance_id, mmSDMA0_PAGE_RB_CNTL, rb_cntl);
+	ib_cntl = RREG32_SDMA(instance_id, mmSDMA0_PAGE_IB_CNTL);
+	ib_cntl = REG_SET_FIELD(ib_cntl, SDMA0_PAGE_IB_CNTL,
+				IB_ENABLE, 0);
+	WREG32_SDMA(instance_id, mmSDMA0_PAGE_IB_CNTL, ib_cntl);
 }
 
 /**
  * sdma_v4_0_ctx_switch_enable - stop the async dma engines context switch
  *
  * @adev: amdgpu_device pointer
+ * @instance_id: SDMA engine instance ID
  * @enable: enable/disable the DMA MEs context switch.
  *
  * Halt or unhalt the async dma engines context switch (VEGA10).
  */
-static void sdma_v4_0_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
+static void sdma_v4_0_ctx_switch_enable(struct amdgpu_device *adev,
+					const u32 instance_id,
+					const bool enable)
 {
 	u32 f32_cntl, phase_quantum = 0;
-	int i;
 
 	if (amdgpu_sdma_phase_quantum) {
 		unsigned value = amdgpu_sdma_phase_quantum;
@@ -994,56 +995,52 @@ static void sdma_v4_0_ctx_switch_enable(struct amdgpu_device *adev, bool enable)
 			unit  << SDMA0_PHASE0_QUANTUM__UNIT__SHIFT;
 	}
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		f32_cntl = RREG32_SDMA(i, mmSDMA0_CNTL);
-		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
-				AUTO_CTXSW_ENABLE, enable ? 1 : 0);
-		if (enable && amdgpu_sdma_phase_quantum) {
-			WREG32_SDMA(i, mmSDMA0_PHASE0_QUANTUM, phase_quantum);
-			WREG32_SDMA(i, mmSDMA0_PHASE1_QUANTUM, phase_quantum);
-			WREG32_SDMA(i, mmSDMA0_PHASE2_QUANTUM, phase_quantum);
-		}
-		WREG32_SDMA(i, mmSDMA0_CNTL, f32_cntl);
-
-		/*
-		 * Enable SDMA utilization. Its only supported on
-		 * Arcturus for the moment and firmware version 14
-		 * and above.
-		 */
-		if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) ==
-			    IP_VERSION(4, 2, 2) &&
-		    adev->sdma.instance[i].fw_version >= 14)
-			WREG32_SDMA(i, mmSDMA0_PUB_DUMMY_REG2, enable);
-		/* Extend page fault timeout to avoid interrupt storm */
-		WREG32_SDMA(i, mmSDMA0_UTCL1_TIMEOUT, 0x00800080);
+	f32_cntl = RREG32_SDMA(instance_id, mmSDMA0_CNTL);
+	f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_CNTL,
+			AUTO_CTXSW_ENABLE, enable ? 1 : 0);
+	if (enable && amdgpu_sdma_phase_quantum) {
+		WREG32_SDMA(instance_id, mmSDMA0_PHASE0_QUANTUM, phase_quantum);
+		WREG32_SDMA(instance_id, mmSDMA0_PHASE1_QUANTUM, phase_quantum);
+		WREG32_SDMA(instance_id, mmSDMA0_PHASE2_QUANTUM, phase_quantum);
 	}
+	WREG32_SDMA(instance_id, mmSDMA0_CNTL, f32_cntl);
 
+	/*
+	 * Enable SDMA utilization. Its only supported on
+	 * Arcturus for the moment and firmware version 14
+	 * and above.
+	 */
+	if (amdgpu_ip_version(adev, SDMA0_HWIP, 0) == IP_VERSION(4, 2, 2) &&
+	    adev->sdma.instance[instance_id].fw_version >= 14)
+		WREG32_SDMA(instance_id, mmSDMA0_PUB_DUMMY_REG2, enable);
+	/* Extend page fault timeout to avoid interrupt storm */
+	WREG32_SDMA(instance_id, mmSDMA0_UTCL1_TIMEOUT, 0x00800080);
 }
 
 /**
  * sdma_v4_0_enable - stop the async dma engines
  *
  * @adev: amdgpu_device pointer
+ * @instance_id: SDMA engine instance ID
  * @enable: enable/disable the DMA MEs.
  *
  * Halt or unhalt the async dma engines (VEGA10).
  */
-static void sdma_v4_0_enable(struct amdgpu_device *adev, bool enable)
+static void sdma_v4_0_enable(struct amdgpu_device *adev,
+			     const u32 instance_id,
+			     const bool enable)
 {
 	u32 f32_cntl;
-	int i;
 
 	if (!enable) {
-		sdma_v4_0_gfx_enable(adev, enable);
+		sdma_v4_0_gfx_enable(adev, instance_id, enable);
 		if (adev->sdma.has_page_queue)
-			sdma_v4_0_page_stop(adev);
+			sdma_v4_0_page_stop(adev, instance_id);
 	}
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		f32_cntl = RREG32_SDMA(i, mmSDMA0_F32_CNTL);
-		f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
-		WREG32_SDMA(i, mmSDMA0_F32_CNTL, f32_cntl);
-	}
+	f32_cntl = RREG32_SDMA(instance_id, mmSDMA0_F32_CNTL);
+	f32_cntl = REG_SET_FIELD(f32_cntl, SDMA0_F32_CNTL, HALT, enable ? 0 : 1);
+	WREG32_SDMA(instance_id, mmSDMA0_F32_CNTL, f32_cntl);
 }
 
 /*
@@ -1303,41 +1300,38 @@ static void sdma_v4_0_init_pg(struct amdgpu_device *adev)
  * sdma_v4_0_load_microcode - load the sDMA ME ucode
  *
  * @adev: amdgpu_device pointer
+ * @instance_id: SDMA engine instance ID
  *
  * Loads the sDMA0/1 ucode.
  * Returns 0 for success, -EINVAL if the ucode is not available.
  */
-static int sdma_v4_0_load_microcode(struct amdgpu_device *adev)
+static int sdma_v4_0_load_microcode(struct amdgpu_device *adev, const u32 instance_id)
 {
 	const struct sdma_firmware_header_v1_0 *hdr;
 	const __le32 *fw_data;
 	u32 fw_size;
-	int i, j;
+	int j;
 
 	/* halt the MEs */
-	sdma_v4_0_enable(adev, false);
+	sdma_v4_0_enable(adev, instance_id, false);
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		if (!adev->sdma.instance[i].fw)
-			return -EINVAL;
+	if (!adev->sdma.instance[instance_id].fw)
+		return -EINVAL;
 
-		hdr = (const struct sdma_firmware_header_v1_0 *)adev->sdma.instance[i].fw->data;
-		amdgpu_ucode_print_sdma_hdr(&hdr->header);
-		fw_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
+	hdr = (const struct sdma_firmware_header_v1_0 *)adev->sdma.instance[instance_id].fw->data;
+	amdgpu_ucode_print_sdma_hdr(&hdr->header);
+	fw_size = le32_to_cpu(hdr->header.ucode_size_bytes) / 4;
 
-		fw_data = (const __le32 *)
-			(adev->sdma.instance[i].fw->data +
-				le32_to_cpu(hdr->header.ucode_array_offset_bytes));
+	fw_data =
+		(const __le32 *)(adev->sdma.instance[instance_id].fw->data +
+			le32_to_cpu(hdr->header.ucode_array_offset_bytes));
 
-		WREG32_SDMA(i, mmSDMA0_UCODE_ADDR, 0);
+	WREG32_SDMA(instance_id, mmSDMA0_UCODE_ADDR, 0);
 
-		for (j = 0; j < fw_size; j++)
-			WREG32_SDMA(i, mmSDMA0_UCODE_DATA,
-				    le32_to_cpup(fw_data++));
+	for (j = 0; j < fw_size; j++)
+		WREG32_SDMA(instance_id, mmSDMA0_UCODE_DATA, le32_to_cpup(fw_data++));
 
-		WREG32_SDMA(i, mmSDMA0_UCODE_ADDR,
-			    adev->sdma.instance[i].fw_version);
-	}
+	WREG32_SDMA(instance_id, mmSDMA0_UCODE_ADDR, adev->sdma.instance[instance_id].fw_version);
 
 	return 0;
 }
@@ -1346,80 +1340,86 @@ static int sdma_v4_0_load_microcode(struct amdgpu_device *adev)
  * sdma_v4_0_start - setup and start the async dma engines
  *
  * @adev: amdgpu_device pointer
+ * @instance_id: SDMA engine instance ID
  *
  * Set up the DMA engines and enable them (VEGA10).
  * Returns 0 for success, error for failure.
  */
-static int sdma_v4_0_start(struct amdgpu_device *adev)
+static int sdma_v4_0_start(struct amdgpu_device *adev, const u32 instance_id)
 {
-	struct amdgpu_ring *ring;
-	int i, r = 0;
+	int r = 0;
 
 	if (amdgpu_sriov_vf(adev)) {
-		sdma_v4_0_ctx_switch_enable(adev, false);
-		sdma_v4_0_enable(adev, false);
+		sdma_v4_0_ctx_switch_enable(adev, instance_id, false);
+		sdma_v4_0_enable(adev, instance_id, false);
 	} else {
 
 		if (adev->firmware.load_type != AMDGPU_FW_LOAD_PSP) {
-			r = sdma_v4_0_load_microcode(adev);
+			r = sdma_v4_0_load_microcode(adev, instance_id);
 			if (r)
 				return r;
 		}
 
 		/* unhalt the MEs */
-		sdma_v4_0_enable(adev, true);
+		sdma_v4_0_enable(adev, instance_id, true);
 		/* enable sdma ring preemption */
-		sdma_v4_0_ctx_switch_enable(adev, true);
+		sdma_v4_0_ctx_switch_enable(adev, instance_id, true);
 	}
 
 	/* start the gfx rings and rlc compute queues */
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		uint32_t temp;
-
-		WREG32_SDMA(i, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL, 0);
-		sdma_v4_0_gfx_resume(adev, i);
-		if (adev->sdma.has_page_queue)
-			sdma_v4_0_page_resume(adev, i);
-
-		/* set utc l1 enable flag always to 1 */
-		temp = RREG32_SDMA(i, mmSDMA0_CNTL);
-		temp = REG_SET_FIELD(temp, SDMA0_CNTL, UTC_L1_ENABLE, 1);
-		WREG32_SDMA(i, mmSDMA0_CNTL, temp);
-
-		if (!amdgpu_sriov_vf(adev)) {
-			/* unhalt engine */
-			temp = RREG32_SDMA(i, mmSDMA0_F32_CNTL);
-			temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT, 0);
-			WREG32_SDMA(i, mmSDMA0_F32_CNTL, temp);
-		}
+	uint32_t temp;
+
+	WREG32_SDMA(instance_id, mmSDMA0_SEM_WAIT_FAIL_TIMER_CNTL, 0);
+	sdma_v4_0_gfx_resume(adev, instance_id);
+	if (adev->sdma.has_page_queue)
+		sdma_v4_0_page_resume(adev, instance_id);
+
+	/* set utc l1 enable flag always to 1 */
+	temp = RREG32_SDMA(instance_id, mmSDMA0_CNTL);
+	temp = REG_SET_FIELD(temp, SDMA0_CNTL, UTC_L1_ENABLE, 1);
+	WREG32_SDMA(instance_id, mmSDMA0_CNTL, temp);
+
+	if (!amdgpu_sriov_vf(adev)) {
+		/* unhalt engine */
+		temp = RREG32_SDMA(instance_id, mmSDMA0_F32_CNTL);
+		temp = REG_SET_FIELD(temp, SDMA0_F32_CNTL, HALT, 0);
+		WREG32_SDMA(instance_id, mmSDMA0_F32_CNTL, temp);
 	}
 
 	if (amdgpu_sriov_vf(adev)) {
-		sdma_v4_0_ctx_switch_enable(adev, true);
-		sdma_v4_0_enable(adev, true);
+		sdma_v4_0_ctx_switch_enable(adev, instance_id, true);
+		sdma_v4_0_enable(adev, instance_id, true);
 	} else {
 		sdma_v4_0_init_pg(adev);
 	}
 
-	for (i = 0; i < adev->sdma.num_instances; i++) {
-		ring = &adev->sdma.instance[i].ring;
+	r = amdgpu_ring_test_helper(&adev->sdma.instance[instance_id].ring);
+	if (r)
+		return r;
 
-		r = amdgpu_ring_test_helper(ring);
+	if (adev->sdma.has_page_queue) {
+		r = amdgpu_ring_test_helper(&adev->sdma.instance[instance_id].page);
 		if (r)
 			return r;
-
-		if (adev->sdma.has_page_queue) {
-			struct amdgpu_ring *page = &adev->sdma.instance[i].page;
-
-			r = amdgpu_ring_test_helper(page);
-			if (r)
-				return r;
-		}
 	}
 
 	return r;
 }
 
+/**
+ * sdma_v3_0_stop() - Stop an SDMA engine
+ *
+ * @adev: amdgpu_device pointer
+ * @instance_id: SDMA engine instance ID
+ *
+ * Stop the given SDMA engine instance (VEGA10).
+ */
+static void sdma_v4_0_stop(struct amdgpu_device *adev, const u32 instance_id)
+{
+	sdma_v4_0_ctx_switch_enable(adev, instance_id, false);
+	sdma_v4_0_enable(adev, instance_id, false);
+}
+
 /**
  * sdma_v4_0_ring_test_ring - simple async dma engine test
  *
@@ -1935,6 +1935,7 @@ static int sdma_v4_0_sw_fini(struct amdgpu_ip_block *ip_block)
 static int sdma_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
 	int r;
 
 	if (adev->flags & AMD_IS_APU)
@@ -1943,9 +1944,12 @@ static int sdma_v4_0_hw_init(struct amdgpu_ip_block *ip_block)
 	if (!amdgpu_sriov_vf(adev))
 		sdma_v4_0_init_golden_registers(adev);
 
-	r = sdma_v4_0_start(adev);
-	if (r)
-		return r;
+	for (i = 0; i < adev->sdma.num_instances; ++i) {
+		r = sdma_v4_0_start(adev, i);
+		if (r)
+			return r;
+	}
+
 	sdma_v4_0_set_buffer_funcs(adev);
 
 	return 0;
@@ -1966,8 +1970,8 @@ static int sdma_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 		}
 	}
 
-	sdma_v4_0_ctx_switch_enable(adev, false);
-	sdma_v4_0_enable(adev, false);
+	for (i = 0; i < adev->sdma.num_instances; ++i)
+		sdma_v4_0_stop(adev, i);
 
 	if (adev->flags & AMD_IS_APU)
 		amdgpu_dpm_set_powergating_by_smu(adev, AMD_IP_BLOCK_TYPE_SDMA, true, 0);
@@ -1978,10 +1982,12 @@ static int sdma_v4_0_hw_fini(struct amdgpu_ip_block *ip_block)
 static int sdma_v4_0_suspend(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
 
 	/* SMU saves SDMA state for us */
 	if (adev->in_s0ix) {
-		sdma_v4_0_gfx_enable(adev, false);
+		for (i = 0; i < adev->sdma.num_instances; ++i)
+			sdma_v4_0_gfx_enable(adev, i, false);
 		return 0;
 	}
 
@@ -1991,11 +1997,14 @@ static int sdma_v4_0_suspend(struct amdgpu_ip_block *ip_block)
 static int sdma_v4_0_resume(struct amdgpu_ip_block *ip_block)
 {
 	struct amdgpu_device *adev = ip_block->adev;
+	int i;
 
 	/* SMU restores SDMA state for us */
 	if (adev->in_s0ix) {
-		sdma_v4_0_enable(adev, true);
-		sdma_v4_0_gfx_enable(adev, true);
+		for (i = 0; i < adev->sdma.num_instances; ++i) {
+			sdma_v4_0_enable(adev, i, true);
+			sdma_v4_0_gfx_enable(adev, i, true);
+		}
 		return 0;
 	}
 
-- 
2.55.0


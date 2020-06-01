Return-Path: <SRS0=+jgF=7O=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36BE2C433E1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F5FA20872
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Jun 2020 18:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edYPTwgG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F5FA20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3C3A6E2E1;
	Mon,  1 Jun 2020 18:04:53 +0000 (UTC)
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com
 [IPv6:2607:f8b0:4864:20::f41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6778B6E2E1
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Jun 2020 18:04:52 +0000 (UTC)
Received: by mail-qv1-xf41.google.com with SMTP id f89so465327qva.3
 for <amd-gfx@lists.freedesktop.org>; Mon, 01 Jun 2020 11:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ahLMJdXp0IoOMnl2gEUomEcU+oay7VrJfni2iS04JHA=;
 b=edYPTwgGQSoYnIDTnZl3IFOVy2Vhx4jHEY1DCFHxxYFzD7diKdnAerRDGEBOHM5ZAt
 48g//e8W4GHrpjzF/e+WYPXEjA5OJ3LheiL5RvGYUdQLdkf+NvJbv/KQzsL5Lk9ZSXpn
 HcSitv9vRYUoBPEjCVTGjLhAKh3slTabEQDGFoH+a+gCc+XxgHOEfvKP92JHlkS9sYAD
 47MywEwLi82H54kgmOGJtRFzU/+nxaMf0rswHqe23OJ2pY20UUQXLSGKpna0m+zgSOHd
 V7nf1AdW/r6/7s6nQysm8Rolbbkl8xSDNAidy2BIBpS3iS5GjLnpOmJuFSYbaFDL3AYj
 qZxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ahLMJdXp0IoOMnl2gEUomEcU+oay7VrJfni2iS04JHA=;
 b=I72IToXn8/Z3Hr3tp0lEksdPAi4Y32RKlJcz+rFsLEDlgCsnmGU3lnVH8LtIyyXRQo
 WrpWrCjoMY2KUMZqvKpul68dgLQLoTzMCI95NRm1YDnZC0qKE3sN9LnzUcSVMUbhZWtn
 8MXErvMh5ngolrhuqeGj0R31+A/7QNERtwM3ppK+xE6R7wmPEEv66USeLxK9l5f88jf7
 JqsC8iQvJwq5x8QSQBwBW6Y9Ulb/e0Vlf1ud5CgFvr+cjfIGYFX5TOtjuI374rBR+HdA
 /CyM6y6SVplbmZzW1yZo2sFKmvhCnVZLkkVTEowyAYJO+/iKDD+/zQom24amLzOMqF6f
 zQMg==
X-Gm-Message-State: AOAM533ivXCBKYLASkIMCVO8qc+ci45uuvxrTOU4DvDDKcctefLvCnbR
 ANMe2pTWKljLF4PezS8NH9iOTAw9
X-Google-Smtp-Source: ABdhPJwFOIHl43WsRSlZy9JY3z43rvA5zU/9V4zVWYF+G5eh42qTxEH+vJH/sReIVPZseItrAI2Lzw==
X-Received: by 2002:ad4:510c:: with SMTP id g12mr4592146qvp.231.1591034690978; 
 Mon, 01 Jun 2020 11:04:50 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id h16sm42164qtp.1.2020.06.01.11.04.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2020 11:04:50 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 087/207] drm/amdgpu: add JPEG3.0 support for Sienna_Cichlid
Date: Mon,  1 Jun 2020 14:00:39 -0400
Message-Id: <20200601180239.1267430-84-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200601180239.1267430-1-alexander.deucher@amd.com>
References: <20200601180239.1267430-1-alexander.deucher@amd.com>
MIME-Version: 1.0
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
Cc: Alex Deucher <alexander.deucher@amd.com>, James Zhu <James.Zhu@amd.com>,
 Leo Liu <leo.liu@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Leo Liu <leo.liu@amd.com>

With basic IP block functions and ring functions

Signed-off-by: Leo Liu <leo.liu@amd.com>
Reviewed-by: James Zhu <James.Zhu@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile    |   3 +-
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c | 484 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.h |  29 ++
 3 files changed, 515 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 3cab3fea59d4..179070b12cde 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -159,7 +159,8 @@ amdgpu-y += \
 	amdgpu_jpeg.o \
 	jpeg_v1_0.o \
 	jpeg_v2_0.o \
-	jpeg_v2_5.o
+	jpeg_v2_5.o \
+	jpeg_v3_0.o
 
 # add ATHUB block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
new file mode 100644
index 000000000000..af70aea0205c
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.c
@@ -0,0 +1,484 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#include "amdgpu.h"
+#include "amdgpu_jpeg.h"
+#include "amdgpu_pm.h"
+#include "soc15.h"
+#include "soc15d.h"
+#include "jpeg_v2_0.h"
+
+#include "vcn/vcn_3_0_0_offset.h"
+#include "vcn/vcn_3_0_0_sh_mask.h"
+#include "ivsrcid/vcn/irqsrcs_vcn_2_0.h"
+
+#define mmUVD_JPEG_PITCH_INTERNAL_OFFSET	0x401f
+
+static void jpeg_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev);
+static void jpeg_v3_0_set_irq_funcs(struct amdgpu_device *adev);
+static int jpeg_v3_0_set_powergating_state(void *handle,
+				enum amd_powergating_state state);
+
+/**
+ * jpeg_v3_0_early_init - set function pointers
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * Set ring and irq function pointers
+ */
+static int jpeg_v3_0_early_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	if (adev->asic_type == CHIP_SIENNA_CICHLID) {
+		u32 harvest = RREG32_SOC15(JPEG, 0, mmCC_UVD_HARVESTING);
+
+		if (harvest & CC_UVD_HARVESTING__UVD_DISABLE_MASK)
+			return -ENOENT;
+	}
+	adev->jpeg.num_jpeg_inst = 1;
+
+	jpeg_v3_0_set_dec_ring_funcs(adev);
+	jpeg_v3_0_set_irq_funcs(adev);
+
+	return 0;
+}
+
+/**
+ * jpeg_v3_0_sw_init - sw init for JPEG block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * Load firmware and sw initialization
+ */
+static int jpeg_v3_0_sw_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_ring *ring;
+	int r;
+
+	/* JPEG TRAP */
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
+		VCN_2_0__SRCID__JPEG_DECODE, &adev->jpeg.inst->irq);
+	if (r)
+		return r;
+
+	r = amdgpu_jpeg_sw_init(adev);
+	if (r)
+		return r;
+
+	r = amdgpu_jpeg_resume(adev);
+	if (r)
+		return r;
+
+	ring = &adev->jpeg.inst->ring_dec;
+	ring->use_doorbell = true;
+	ring->doorbell_index = (adev->doorbell_index.vcn.vcn_ring0_1 << 1) + 1;
+	sprintf(ring->name, "jpeg_dec");
+	r = amdgpu_ring_init(adev, ring, 512, &adev->jpeg.inst->irq, 0,
+			     AMDGPU_RING_PRIO_DEFAULT);
+	if (r)
+		return r;
+
+	adev->jpeg.internal.jpeg_pitch = mmUVD_JPEG_PITCH_INTERNAL_OFFSET;
+	adev->jpeg.inst->external.jpeg_pitch = SOC15_REG_OFFSET(JPEG, 0, mmUVD_JPEG_PITCH);
+
+	return 0;
+}
+
+/**
+ * jpeg_v3_0_sw_fini - sw fini for JPEG block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * JPEG suspend and free up sw allocation
+ */
+static int jpeg_v3_0_sw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = amdgpu_jpeg_suspend(adev);
+	if (r)
+		return r;
+
+	r = amdgpu_jpeg_sw_fini(adev);
+
+	return r;
+}
+
+/**
+ * jpeg_v3_0_hw_init - start and test JPEG block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ */
+static int jpeg_v3_0_hw_init(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_ring *ring = &adev->jpeg.inst->ring_dec;
+	int r;
+
+	adev->nbio.funcs->vcn_doorbell_range(adev, ring->use_doorbell,
+		(adev->doorbell_index.vcn.vcn_ring0_1 << 1), 0);
+
+	r = amdgpu_ring_test_helper(ring);
+	if (r)
+		return r;
+
+	DRM_INFO("JPEG decode initialized successfully.\n");
+
+	return 0;
+}
+
+/**
+ * jpeg_v3_0_hw_fini - stop the hardware block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * Stop the JPEG block, mark ring as not ready any more
+ */
+static int jpeg_v3_0_hw_fini(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	struct amdgpu_ring *ring;
+
+	ring = &adev->jpeg.inst->ring_dec;
+	if (adev->jpeg.cur_state != AMD_PG_STATE_GATE &&
+	      RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS))
+		jpeg_v3_0_set_powergating_state(adev, AMD_PG_STATE_GATE);
+
+	ring->sched.ready = false;
+
+	return 0;
+}
+
+/**
+ * jpeg_v3_0_suspend - suspend JPEG block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * HW fini and suspend JPEG block
+ */
+static int jpeg_v3_0_suspend(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = jpeg_v3_0_hw_fini(adev);
+	if (r)
+		return r;
+
+	r = amdgpu_jpeg_suspend(adev);
+
+	return r;
+}
+
+/**
+ * jpeg_v3_0_resume - resume JPEG block
+ *
+ * @handle: amdgpu_device pointer
+ *
+ * Resume firmware and hw init JPEG block
+ */
+static int jpeg_v3_0_resume(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int r;
+
+	r = amdgpu_jpeg_resume(adev);
+	if (r)
+		return r;
+
+	r = jpeg_v3_0_hw_init(adev);
+
+	return r;
+}
+
+/**
+ * jpeg_v3_0_start - start JPEG block
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Setup and start the JPEG block
+ */
+static int jpeg_v3_0_start(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *ring = &adev->jpeg.inst->ring_dec;
+
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_jpeg(adev, true);
+
+	/* MJPEG global tiling registers */
+	WREG32_SOC15(JPEG, 0, mmJPEG_DEC_GFX10_ADDR_CONFIG,
+		adev->gfx.config.gb_addr_config);
+	WREG32_SOC15(JPEG, 0, mmJPEG_ENC_GFX10_ADDR_CONFIG,
+		adev->gfx.config.gb_addr_config);
+
+	/* enable JMI channel */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, mmUVD_JMI_CNTL), 0,
+		~UVD_JMI_CNTL__SOFT_RESET_MASK);
+
+	/* enable System Interrupt for JRBC */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, mmJPEG_SYS_INT_EN),
+		JPEG_SYS_INT_EN__DJRBC_MASK,
+		~JPEG_SYS_INT_EN__DJRBC_MASK);
+
+	WREG32_SOC15(JPEG, 0, mmUVD_LMI_JRBC_RB_VMID, 0);
+	WREG32_SOC15(JPEG, 0, mmUVD_JRBC_RB_CNTL, (0x00000001L | 0x00000002L));
+	WREG32_SOC15(JPEG, 0, mmUVD_LMI_JRBC_RB_64BIT_BAR_LOW,
+		lower_32_bits(ring->gpu_addr));
+	WREG32_SOC15(JPEG, 0, mmUVD_LMI_JRBC_RB_64BIT_BAR_HIGH,
+		upper_32_bits(ring->gpu_addr));
+	WREG32_SOC15(JPEG, 0, mmUVD_JRBC_RB_RPTR, 0);
+	WREG32_SOC15(JPEG, 0, mmUVD_JRBC_RB_WPTR, 0);
+	WREG32_SOC15(JPEG, 0, mmUVD_JRBC_RB_CNTL, 0x00000002L);
+	WREG32_SOC15(JPEG, 0, mmUVD_JRBC_RB_SIZE, ring->ring_size / 4);
+	ring->wptr = RREG32_SOC15(JPEG, 0, mmUVD_JRBC_RB_WPTR);
+
+	return 0;
+}
+
+/**
+ * jpeg_v3_0_stop - stop JPEG block
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * stop the JPEG block
+ */
+static int jpeg_v3_0_stop(struct amdgpu_device *adev)
+{
+	/* reset JMI */
+	WREG32_P(SOC15_REG_OFFSET(JPEG, 0, mmUVD_JMI_CNTL),
+		UVD_JMI_CNTL__SOFT_RESET_MASK,
+		~UVD_JMI_CNTL__SOFT_RESET_MASK);
+
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_jpeg(adev, false);
+
+	return 0;
+}
+
+/**
+ * jpeg_v3_0_dec_ring_get_rptr - get read pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Returns the current hardware read pointer
+ */
+static uint64_t jpeg_v3_0_dec_ring_get_rptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	return RREG32_SOC15(JPEG, 0, mmUVD_JRBC_RB_RPTR);
+}
+
+/**
+ * jpeg_v3_0_dec_ring_get_wptr - get write pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Returns the current hardware write pointer
+ */
+static uint64_t jpeg_v3_0_dec_ring_get_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->use_doorbell)
+		return adev->wb.wb[ring->wptr_offs];
+	else
+		return RREG32_SOC15(JPEG, 0, mmUVD_JRBC_RB_WPTR);
+}
+
+/**
+ * jpeg_v3_0_dec_ring_set_wptr - set write pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Commits the write pointer to the hardware
+ */
+static void jpeg_v3_0_dec_ring_set_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->use_doorbell) {
+		adev->wb.wb[ring->wptr_offs] = lower_32_bits(ring->wptr);
+		WDOORBELL32(ring->doorbell_index, lower_32_bits(ring->wptr));
+	} else {
+		WREG32_SOC15(JPEG, 0, mmUVD_JRBC_RB_WPTR, lower_32_bits(ring->wptr));
+	}
+}
+
+static bool jpeg_v3_0_is_idle(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int ret = 1;
+
+	ret &= (((RREG32_SOC15(JPEG, 0, mmUVD_JRBC_STATUS) &
+		UVD_JRBC_STATUS__RB_JOB_DONE_MASK) ==
+		UVD_JRBC_STATUS__RB_JOB_DONE_MASK));
+
+	return ret;
+}
+
+static int jpeg_v3_0_wait_for_idle(void *handle)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int ret = 0;
+
+	SOC15_WAIT_ON_RREG(JPEG, 0, mmUVD_JRBC_STATUS,
+		UVD_JRBC_STATUS__RB_JOB_DONE_MASK,
+		UVD_JRBC_STATUS__RB_JOB_DONE_MASK, ret);
+	if (ret)
+		return ret;
+
+	return ret;
+}
+
+static int jpeg_v3_0_set_clockgating_state(void *handle,
+					  enum amd_clockgating_state state)
+{
+	return 0;
+}
+
+static int jpeg_v3_0_set_powergating_state(void *handle,
+					  enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = (struct amdgpu_device *)handle;
+	int ret;
+
+	if(state == adev->jpeg.cur_state)
+		return 0;
+
+	if (state == AMD_PG_STATE_GATE)
+		ret = jpeg_v3_0_stop(adev);
+	else
+		ret = jpeg_v3_0_start(adev);
+
+	if(!ret)
+		adev->jpeg.cur_state = state;
+
+	return ret;
+}
+
+static int jpeg_v3_0_set_interrupt_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					unsigned type,
+					enum amdgpu_interrupt_state state)
+{
+	return 0;
+}
+
+static int jpeg_v3_0_process_interrupt(struct amdgpu_device *adev,
+				      struct amdgpu_irq_src *source,
+				      struct amdgpu_iv_entry *entry)
+{
+	DRM_DEBUG("IH: JPEG TRAP\n");
+
+	switch (entry->src_id) {
+	case VCN_2_0__SRCID__JPEG_DECODE:
+		amdgpu_fence_process(&adev->jpeg.inst->ring_dec);
+		break;
+	default:
+		DRM_ERROR("Unhandled interrupt: %d %d\n",
+			  entry->src_id, entry->src_data[0]);
+		break;
+	}
+
+	return 0;
+}
+
+static const struct amd_ip_funcs jpeg_v3_0_ip_funcs = {
+	.name = "jpeg_v3_0",
+	.early_init = jpeg_v3_0_early_init,
+	.late_init = NULL,
+	.sw_init = jpeg_v3_0_sw_init,
+	.sw_fini = jpeg_v3_0_sw_fini,
+	.hw_init = jpeg_v3_0_hw_init,
+	.hw_fini = jpeg_v3_0_hw_fini,
+	.suspend = jpeg_v3_0_suspend,
+	.resume = jpeg_v3_0_resume,
+	.is_idle = jpeg_v3_0_is_idle,
+	.wait_for_idle = jpeg_v3_0_wait_for_idle,
+	.check_soft_reset = NULL,
+	.pre_soft_reset = NULL,
+	.soft_reset = NULL,
+	.post_soft_reset = NULL,
+	.set_clockgating_state = jpeg_v3_0_set_clockgating_state,
+	.set_powergating_state = jpeg_v3_0_set_powergating_state,
+};
+
+static const struct amdgpu_ring_funcs jpeg_v3_0_dec_ring_vm_funcs = {
+	.type = AMDGPU_RING_TYPE_VCN_JPEG,
+	.align_mask = 0xf,
+	.vmhub = AMDGPU_MMHUB_0,
+	.get_rptr = jpeg_v3_0_dec_ring_get_rptr,
+	.get_wptr = jpeg_v3_0_dec_ring_get_wptr,
+	.set_wptr = jpeg_v3_0_dec_ring_set_wptr,
+	.emit_frame_size =
+		SOC15_FLUSH_GPU_TLB_NUM_WREG * 6 +
+		SOC15_FLUSH_GPU_TLB_NUM_REG_WAIT * 8 +
+		8 + /* jpeg_v3_0_dec_ring_emit_vm_flush */
+		18 + 18 + /* jpeg_v3_0_dec_ring_emit_fence x2 vm fence */
+		8 + 16,
+	.emit_ib_size = 22, /* jpeg_v3_0_dec_ring_emit_ib */
+	.emit_ib = jpeg_v2_0_dec_ring_emit_ib,
+	.emit_fence = jpeg_v2_0_dec_ring_emit_fence,
+	.emit_vm_flush = jpeg_v2_0_dec_ring_emit_vm_flush,
+	.test_ring = amdgpu_jpeg_dec_ring_test_ring,
+	.test_ib = amdgpu_jpeg_dec_ring_test_ib,
+	.insert_nop = jpeg_v2_0_dec_ring_nop,
+	.insert_start = jpeg_v2_0_dec_ring_insert_start,
+	.insert_end = jpeg_v2_0_dec_ring_insert_end,
+	.pad_ib = amdgpu_ring_generic_pad_ib,
+	.begin_use = amdgpu_jpeg_ring_begin_use,
+	.end_use = amdgpu_jpeg_ring_end_use,
+	.emit_wreg = jpeg_v2_0_dec_ring_emit_wreg,
+	.emit_reg_wait = jpeg_v2_0_dec_ring_emit_reg_wait,
+	.emit_reg_write_reg_wait = amdgpu_ring_emit_reg_write_reg_wait_helper,
+};
+
+static void jpeg_v3_0_set_dec_ring_funcs(struct amdgpu_device *adev)
+{
+	adev->jpeg.inst->ring_dec.funcs = &jpeg_v3_0_dec_ring_vm_funcs;
+	DRM_INFO("JPEG decode is enabled in VM mode\n");
+}
+
+static const struct amdgpu_irq_src_funcs jpeg_v3_0_irq_funcs = {
+	.set = jpeg_v3_0_set_interrupt_state,
+	.process = jpeg_v3_0_process_interrupt,
+};
+
+static void jpeg_v3_0_set_irq_funcs(struct amdgpu_device *adev)
+{
+	adev->jpeg.inst->irq.num_types = 1;
+	adev->jpeg.inst->irq.funcs = &jpeg_v3_0_irq_funcs;
+}
+
+const struct amdgpu_ip_block_version jpeg_v3_0_ip_block =
+{
+	.type = AMD_IP_BLOCK_TYPE_JPEG,
+	.major = 3,
+	.minor = 0,
+	.rev = 0,
+	.funcs = &jpeg_v3_0_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.h b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.h
new file mode 100644
index 000000000000..ce775a0c742f
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v3_0.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright 2019 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __JPEG_V3_0_H__
+#define __JPEG_V3_0_H__
+
+extern const struct amdgpu_ip_block_version jpeg_v3_0_ip_block;
+
+#endif /* __JPEG_V3_0_H__ */
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

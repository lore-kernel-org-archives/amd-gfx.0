Return-Path: <SRS0=B05q=DC=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D21F9C47420
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7372723A31
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Sep 2020 20:11:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mlrjdqb1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7372723A31
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE8956ED74;
	Fri, 25 Sep 2020 20:11:32 +0000 (UTC)
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D80476ED74
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 20:11:30 +0000 (UTC)
Received: by mail-qk1-x731.google.com with SMTP id q5so4144896qkc.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Sep 2020 13:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=p/6a5ZU/8XRU3Benlq6dzcC2lKBBymCa5xefPzTFQ1k=;
 b=Mlrjdqb1hSKvbdhDmB2rU8o/89mqh5mrTSST+iM3rOKEIeWcdsDt7ZXX5iP48Gu+1e
 zFhZtY0DSdB8CbRbxGXKTeTJVgZVb4xADtKYhTo30X/oj7uCuLUbS5TPJ4GenhmqT1R5
 x8xLZ+DhNn6tHzPNabkGH3cFRQmo6UFliLoC8cNdqXkw9Pq2nkQ5BaGKuGk7PkYUu8jF
 muUw86OmxZnc/dkSscLSmukWJGhtv3NHYPFUPAJPZipuwkK3OqMG0PnOTY9MqA387J6n
 ZV/wzQ/YKtArdjgfm5oCBbJ5NRF4R5UDSEv2KNZ0RBVknJOBfrwxCV2WNj0UYDGQ4PeP
 Jfkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=p/6a5ZU/8XRU3Benlq6dzcC2lKBBymCa5xefPzTFQ1k=;
 b=pjZDBplRvWZzfprackFCyIKBgesg8eT7he79khkuzptX0fe7cyTx1z60Q+ckEfjpCm
 u9y+QzDiuHTRd6S+q/ovdpdHZW2Ce6HFPy6mK0AVj+flYSP6heUGp7V84AKCLJPeTePi
 jGHptu/CGZa5J4hr3B/9lykxHwESn0XnN0aOTp7u091hRiA/hN7V+SxfTFX/m2qXGFRx
 hV4b8uDGoHcyAm8Q3kzOKoFCTqjXAHyEXwdL/7we1Q9fI2/q/Zy/gbiChlolZBXE85Fl
 yb5UliPgp4AcXEgbNYb2hkJZgqFC6VmorlN1aBo99hB6ZPnvNQyE6w67XxM8h+qToAsP
 8BAg==
X-Gm-Message-State: AOAM532ObvvjYazxzFx6TjsZUca/xkoLAouKwVzdZpqMNGuhj7Q05kmZ
 lbYy4+6Q0prweDKzASpRiwxt0lYkZAE=
X-Google-Smtp-Source: ABdhPJxnldGn9jso2YrKZddk4/aj9QnVvV+u+kO+BY2ds+YiM/Tx23VktFHt65hu2CDwbNRPhPTmOQ==
X-Received: by 2002:a37:77c4:: with SMTP id s187mr1783225qkc.327.1601064689563; 
 Fri, 25 Sep 2020 13:11:29 -0700 (PDT)
Received: from tr4.amd.com (atlvpn.amd.com. [165.204.84.11])
 by smtp.gmail.com with ESMTPSA id m67sm2301237qkf.98.2020.09.25.13.11.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 13:11:28 -0700 (PDT)
From: Alex Deucher <alexdeucher@gmail.com>
X-Google-Original-From: Alex Deucher <alexander.deucher@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 25/45] drm/amdgpu: add nbio v7.2 for vangogh (v2)
Date: Fri, 25 Sep 2020 16:10:09 -0400
Message-Id: <20200925201029.1738724-25-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200925201029.1738724-1-alexander.deucher@amd.com>
References: <20200925201029.1738724-1-alexander.deucher@amd.com>
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Huang Rui <ray.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Huang Rui <ray.huang@amd.com>

VanGogh uses nbio v7.2, and a couple of offsets are changed since nbio
v2.3 for navi series, so add new nbio v7.2 block.

v2: squash in fix for sdma and vcn instances

Signed-off-by: Huang Rui <ray.huang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile    |   3 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c | 341 +++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.h |  32 +++
 drivers/gpu/drm/amd/amdgpu/nv.c        |  10 +-
 4 files changed, 383 insertions(+), 3 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v7_2.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 7c7e34824c51..60cff3b08eb3 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -69,7 +69,8 @@ amdgpu-$(CONFIG_DRM_AMDGPU_SI)+= si.o gmc_v6_0.o gfx_v6_0.o si_ih.o si_dma.o dce
 amdgpu-y += \
 	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o navi10_reg_init.o navi14_reg_init.o \
-	arct_reg_init.o navi12_reg_init.o mxgpu_nv.o sienna_cichlid_reg_init.o vangogh_reg_init.o
+	arct_reg_init.o navi12_reg_init.o mxgpu_nv.o sienna_cichlid_reg_init.o vangogh_reg_init.o \
+	nbio_v7_2.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
new file mode 100644
index 000000000000..aa36022670f9
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.c
@@ -0,0 +1,341 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+#include "amdgpu.h"
+#include "amdgpu_atombios.h"
+#include "nbio_v7_2.h"
+
+#include "nbio/nbio_7_2_0_offset.h"
+#include "nbio/nbio_7_2_0_sh_mask.h"
+#include <uapi/linux/kfd_ioctl.h>
+
+static void nbio_v7_2_remap_hdp_registers(struct amdgpu_device *adev)
+{
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
+		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
+		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+}
+
+static u32 nbio_v7_2_get_rev_id(struct amdgpu_device *adev)
+{
+	u32 tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
+
+	tmp &= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
+	tmp >>= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
+
+	return tmp;
+}
+
+static void nbio_v7_2_mc_access_enable(struct amdgpu_device *adev, bool enable)
+{
+	if (enable)
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN,
+			     BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK |
+			     BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK);
+	else
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN, 0);
+}
+
+static void nbio_v7_2_hdp_flush(struct amdgpu_device *adev,
+				struct amdgpu_ring *ring)
+{
+	if (!ring || !ring->funcs->emit_wreg)
+		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+	else
+		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+}
+
+static u32 nbio_v7_2_get_memsize(struct amdgpu_device *adev)
+{
+	return RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_0_RCC_CONFIG_MEMSIZE);
+}
+
+static void nbio_v7_2_sdma_doorbell_range(struct amdgpu_device *adev, int instance,
+					  bool use_doorbell, int doorbell_index,
+					  int doorbell_size)
+{
+	u32 reg = SOC15_REG_OFFSET(NBIO, 0, regGDC0_BIF_SDMA0_DOORBELL_RANGE);
+	u32 doorbell_range = RREG32_PCIE_PORT(reg);
+
+	if (use_doorbell) {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC0_BIF_SDMA0_DOORBELL_RANGE,
+					       OFFSET, doorbell_index);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC0_BIF_SDMA0_DOORBELL_RANGE,
+					       SIZE, doorbell_size);
+	} else {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC0_BIF_SDMA0_DOORBELL_RANGE,
+					       SIZE, 0);
+	}
+
+	WREG32_PCIE_PORT(reg, doorbell_range);
+}
+
+static void nbio_v7_2_vcn_doorbell_range(struct amdgpu_device *adev, bool use_doorbell,
+					 int doorbell_index, int instance)
+{
+	u32 reg = SOC15_REG_OFFSET(NBIO, 0, regGDC0_BIF_VCN0_DOORBELL_RANGE);
+	u32 doorbell_range = RREG32_PCIE_PORT(reg);
+
+	if (use_doorbell) {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC0_BIF_VCN0_DOORBELL_RANGE, OFFSET,
+					       doorbell_index);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC0_BIF_VCN0_DOORBELL_RANGE, SIZE, 8);
+	} else {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC0_BIF_VCN0_DOORBELL_RANGE, SIZE, 0);
+	}
+
+	WREG32_PCIE_PORT(reg, doorbell_range);
+}
+
+static void nbio_v7_2_enable_doorbell_aperture(struct amdgpu_device *adev,
+					       bool enable)
+{
+	u32 reg;
+
+	reg = RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_0_RCC_DOORBELL_APER_EN);
+	reg = REG_SET_FIELD(reg, RCC_DEV0_EPF0_0_RCC_DOORBELL_APER_EN,
+			    BIF_DOORBELL_APER_EN, enable ? 1 : 0);
+
+	WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_0_RCC_DOORBELL_APER_EN, reg);
+}
+
+static void nbio_v7_2_enable_doorbell_selfring_aperture(struct amdgpu_device *adev,
+							bool enable)
+{
+	u32 tmp = 0;
+
+	if (enable) {
+		tmp = REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
+				    DOORBELL_SELFRING_GPA_APER_EN, 1) |
+		      REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
+				    DOORBELL_SELFRING_GPA_APER_MODE, 1) |
+		      REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
+				    DOORBELL_SELFRING_GPA_APER_SIZE, 0);
+
+		WREG32_SOC15(NBIO, 0,
+			     regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
+			     lower_32_bits(adev->doorbell.base));
+		WREG32_SOC15(NBIO, 0,
+			     regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
+			     upper_32_bits(adev->doorbell.base));
+	}
+
+	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
+		     tmp);
+}
+
+
+static void nbio_v7_2_ih_doorbell_range(struct amdgpu_device *adev,
+					bool use_doorbell, int doorbell_index)
+{
+	u32 ih_doorbell_range = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regGDC0_BIF_IH_DOORBELL_RANGE));
+
+	if (use_doorbell) {
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC0_BIF_IH_DOORBELL_RANGE, OFFSET,
+						  doorbell_index);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC0_BIF_IH_DOORBELL_RANGE, SIZE,
+						  2);
+	} else {
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC0_BIF_IH_DOORBELL_RANGE, SIZE,
+						  0);
+	}
+
+	WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regGDC0_BIF_IH_DOORBELL_RANGE),
+			 ih_doorbell_range);
+}
+
+static void nbio_v7_2_ih_control(struct amdgpu_device *adev)
+{
+	u32 interrupt_cntl;
+
+	/* setup interrupt control */
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL2,
+		     adev->dummy_page_addr >> 8);
+
+	interrupt_cntl = RREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL);
+	/*
+	 * INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=0 - dummy read disabled with msi, enabled without msi
+	 * INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=1 - dummy read controlled by IH_DUMMY_RD_EN
+	 */
+	interrupt_cntl = REG_SET_FIELD(interrupt_cntl, BIF_BX0_INTERRUPT_CNTL,
+				       IH_DUMMY_RD_OVERRIDE, 0);
+
+	/* INTERRUPT_CNTL__IH_REQ_NONSNOOP_EN_MASK=1 if ring is in non-cacheable memory, e.g., vram */
+	interrupt_cntl = REG_SET_FIELD(interrupt_cntl, BIF_BX0_INTERRUPT_CNTL,
+				       IH_REQ_NONSNOOP_EN, 0);
+
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL, interrupt_cntl);
+}
+
+static void nbio_v7_2_update_medium_grain_clock_gating(struct amdgpu_device *adev,
+						       bool enable)
+{
+	uint32_t def, data;
+
+	def = data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regCPM_CONTROL));
+	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_BIF_MGCG)) {
+		data |= (CPM_CONTROL__LCLK_DYN_GATE_ENABLE_MASK |
+			 CPM_CONTROL__TXCLK_DYN_GATE_ENABLE_MASK |
+			 CPM_CONTROL__TXCLK_LCNT_GATE_ENABLE_MASK |
+			 CPM_CONTROL__TXCLK_REGS_GATE_ENABLE_MASK |
+			 CPM_CONTROL__TXCLK_PRBS_GATE_ENABLE_MASK |
+			 CPM_CONTROL__REFCLK_REGS_GATE_ENABLE_MASK);
+	} else {
+		data &= ~(CPM_CONTROL__LCLK_DYN_GATE_ENABLE_MASK |
+			  CPM_CONTROL__TXCLK_DYN_GATE_ENABLE_MASK |
+			  CPM_CONTROL__TXCLK_LCNT_GATE_ENABLE_MASK |
+			  CPM_CONTROL__TXCLK_REGS_GATE_ENABLE_MASK |
+			  CPM_CONTROL__TXCLK_PRBS_GATE_ENABLE_MASK |
+			  CPM_CONTROL__REFCLK_REGS_GATE_ENABLE_MASK);
+	}
+
+	if (def != data)
+		WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regCPM_CONTROL), data);
+}
+
+static void nbio_v7_2_update_medium_grain_light_sleep(struct amdgpu_device *adev,
+						      bool enable)
+{
+	uint32_t def, data;
+
+	def = data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CNTL2));
+	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_BIF_LS)) {
+		data |= (PCIE_CNTL2__SLV_MEM_LS_EN_MASK |
+			 PCIE_CNTL2__MST_MEM_LS_EN_MASK |
+			 PCIE_CNTL2__REPLAY_MEM_LS_EN_MASK);
+	} else {
+		data &= ~(PCIE_CNTL2__SLV_MEM_LS_EN_MASK |
+			  PCIE_CNTL2__MST_MEM_LS_EN_MASK |
+			  PCIE_CNTL2__REPLAY_MEM_LS_EN_MASK);
+	}
+
+	if (def != data)
+		WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CNTL2), data);
+}
+
+static void nbio_v7_2_get_clockgating_state(struct amdgpu_device *adev,
+					    u32 *flags)
+{
+	int data;
+
+	/* AMD_CG_SUPPORT_BIF_MGCG */
+	data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regCPM_CONTROL));
+	if (data & CPM_CONTROL__LCLK_DYN_GATE_ENABLE_MASK)
+		*flags |= AMD_CG_SUPPORT_BIF_MGCG;
+
+	/* AMD_CG_SUPPORT_BIF_LS */
+	data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CNTL2));
+	if (data & PCIE_CNTL2__SLV_MEM_LS_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_BIF_LS;
+}
+
+static u32 nbio_v7_2_get_hdp_flush_req_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_REQ);
+}
+
+static u32 nbio_v7_2_get_hdp_flush_done_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_DONE);
+}
+
+static u32 nbio_v7_2_get_pcie_index_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_INDEX2);
+}
+
+static u32 nbio_v7_2_get_pcie_data_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_DATA2);
+}
+
+static u32 nbio_v7_2_get_pcie_port_index_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_INDEX);
+}
+
+static u32 nbio_v7_2_get_pcie_port_data_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_DATA);
+}
+
+const struct nbio_hdp_flush_reg nbio_v7_2_hdp_flush_reg = {
+	.ref_and_mask_cp0 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP0_MASK,
+	.ref_and_mask_cp1 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP1_MASK,
+	.ref_and_mask_cp2 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP2_MASK,
+	.ref_and_mask_cp3 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP3_MASK,
+	.ref_and_mask_cp4 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP4_MASK,
+	.ref_and_mask_cp5 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP5_MASK,
+	.ref_and_mask_cp6 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP6_MASK,
+	.ref_and_mask_cp7 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP7_MASK,
+	.ref_and_mask_cp8 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP8_MASK,
+	.ref_and_mask_cp9 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP9_MASK,
+	.ref_and_mask_sdma0 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__SDMA0_MASK,
+	.ref_and_mask_sdma1 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__SDMA1_MASK,
+};
+
+static void nbio_v7_2_init_registers(struct amdgpu_device *adev)
+{
+	uint32_t def, data;
+
+	def = data = RREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CONFIG_CNTL));
+	data = REG_SET_FIELD(data, PCIE_CONFIG_CNTL, CI_SWUS_MAX_READ_REQUEST_SIZE_MODE, 1);
+	data = REG_SET_FIELD(data, PCIE_CONFIG_CNTL, CI_SWUS_MAX_READ_REQUEST_SIZE_PRIV, 1);
+
+	if (def != data)
+		WREG32_PCIE_PORT(SOC15_REG_OFFSET(NBIO, 0, regPCIE_CONFIG_CNTL),
+				 data);
+}
+
+const struct amdgpu_nbio_funcs nbio_v7_2_funcs = {
+	.get_hdp_flush_req_offset = nbio_v7_2_get_hdp_flush_req_offset,
+	.get_hdp_flush_done_offset = nbio_v7_2_get_hdp_flush_done_offset,
+	.get_pcie_index_offset = nbio_v7_2_get_pcie_index_offset,
+	.get_pcie_data_offset = nbio_v7_2_get_pcie_data_offset,
+	.get_pcie_port_index_offset = nbio_v7_2_get_pcie_port_index_offset,
+	.get_pcie_port_data_offset = nbio_v7_2_get_pcie_port_data_offset,
+	.get_rev_id = nbio_v7_2_get_rev_id,
+	.mc_access_enable = nbio_v7_2_mc_access_enable,
+	.hdp_flush = nbio_v7_2_hdp_flush,
+	.get_memsize = nbio_v7_2_get_memsize,
+	.sdma_doorbell_range = nbio_v7_2_sdma_doorbell_range,
+	.vcn_doorbell_range = nbio_v7_2_vcn_doorbell_range,
+	.enable_doorbell_aperture = nbio_v7_2_enable_doorbell_aperture,
+	.enable_doorbell_selfring_aperture = nbio_v7_2_enable_doorbell_selfring_aperture,
+	.ih_doorbell_range = nbio_v7_2_ih_doorbell_range,
+	.update_medium_grain_clock_gating = nbio_v7_2_update_medium_grain_clock_gating,
+	.update_medium_grain_light_sleep = nbio_v7_2_update_medium_grain_light_sleep,
+	.get_clockgating_state = nbio_v7_2_get_clockgating_state,
+	.ih_control = nbio_v7_2_ih_control,
+	.init_registers = nbio_v7_2_init_registers,
+	.remap_hdp_registers = nbio_v7_2_remap_hdp_registers,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.h b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.h
new file mode 100644
index 000000000000..a8e8e65648a0
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v7_2.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+#ifndef __NBIO_V7_2_H__
+#define __NBIO_V7_2_H__
+
+#include "soc15_common.h"
+
+extern const struct nbio_hdp_flush_reg nbio_v7_2_hdp_flush_reg;
+extern const struct amdgpu_nbio_funcs nbio_v7_2_funcs;
+
+#endif
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.c b/drivers/gpu/drm/amd/amdgpu/nv.c
index 5b3b70a64a79..3ac89109ea3e 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.c
+++ b/drivers/gpu/drm/amd/amdgpu/nv.c
@@ -49,6 +49,7 @@
 #include "gfxhub_v2_0.h"
 #include "mmhub_v2_0.h"
 #include "nbio_v2_3.h"
+#include "nbio_v7_2.h"
 #include "nv.h"
 #include "navi10_ih.h"
 #include "gfx_v10_0.h"
@@ -528,8 +529,13 @@ int nv_set_ip_blocks(struct amdgpu_device *adev)
 {
 	int r;
 
-	adev->nbio.funcs = &nbio_v2_3_funcs;
-	adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
+	if (adev->flags & AMD_IS_APU) {
+		adev->nbio.funcs = &nbio_v7_2_funcs;
+		adev->nbio.hdp_flush_reg = &nbio_v7_2_hdp_flush_reg;
+	} else {
+		adev->nbio.funcs = &nbio_v2_3_funcs;
+		adev->nbio.hdp_flush_reg = &nbio_v2_3_hdp_flush_reg;
+	}
 
 	if (adev->asic_type == CHIP_SIENNA_CICHLID)
 		adev->gmc.xgmi.supported = true;
-- 
2.25.4

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

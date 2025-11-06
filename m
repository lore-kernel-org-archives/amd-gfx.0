Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F78CCFA18
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 18:45:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04A7E10E9B7;
	Thu,  6 Nov 2025 18:45:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="CqgQMAlj";
	dkim-atps=neutral
Received: from mail-vs1-f51.google.com (mail-vs1-f51.google.com
 [209.85.217.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1451B10E9B3
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 18:45:56 +0000 (UTC)
Received: by mail-vs1-f51.google.com with SMTP id
 ada2fe7eead31-5dd6fbe50c0so532069137.2
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Nov 2025 10:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762454755; x=1763059555; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=z1d8Nrrsx+HFviX2qQGDhjQuLy5jC0CNPcE42yiJbjs=;
 b=CqgQMAljalvpSeeyOATdsUZJqs6VzpORgZzeDOVcwJk8S2SbCl7lRp5FDV1zgY0kbX
 FwgWkGkfccwR6KqzENSPIZdK/CiQjRISl9TBpIHpPVMsumRxZ0dqP9jcOkiILUVTnoe8
 CVnOk8KzDV6SwYWBeb0Bda5WAhxe4juariv/rnrAyYgIfKwsmSDFb5ibgnM6dLRxCTaM
 Ftc/S227S4vcH46aTzw1bJX4aLED5N5eBrHUNYeGiArZ8L83zoG+rkfwIPHn5exStmvj
 qtd1rDPF2OVCHZe3FJqd7Ph+J1t/f9xdcbf5399WDl6lf9Ii8TBV2AgJyKEVqXJhKcIk
 B7tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762454755; x=1763059555;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z1d8Nrrsx+HFviX2qQGDhjQuLy5jC0CNPcE42yiJbjs=;
 b=S/uq+2Kb/0bApVyrO+Xnl5vBponFXKROqOjICetrvxzz16paCn+jbyN02iDNSOnaxr
 /yViTqxNn8ozX5pPa1OHoLgIPmDsaDHcCDRCr6z3wJsalrjplhgCt4BaVH1rRpoPMxQZ
 EnQS1uvhBRYWPXY2U/VPU4/NyzS/BSu7FIIKzr3mZfpc1f5p/zakDR+32AuUZJewp/Yt
 +RNSGqHBXZvnLE4KQ3kGJgAmYS+vMiQD5Nuu4rIF+a0o2g+88P5wG6eTQ+T25ZCC6U5E
 mYzJnO6HxJqlwnOluLXoFkt8e1UZHzj8hkLq6yo/kVamGybRuAw7YUdc2t6Eos5FrwdT
 HzHw==
X-Gm-Message-State: AOJu0Yx0ICa9ZlV5t1oNn8+zFgeq410u4b14QPZeqP/muzfDvkUZv17S
 8LnCHn/zW7jggJDb3sQqu3GvGcg4OdWcYWhU+j3U5y76CpWSazOOy6k39KZh/EUQ
X-Gm-Gg: ASbGnctJaj9acsEoASb9W5YBkGvN/n38XI6E9/OMjABdPU3bI0WAEwGFqkX1HgdshuH
 L3SffdWXKNZsA+MGY+bhHCs48omqkD0qAPnzsm5EiHP2u8LLfTXA9BZkkYZCZ9CFgyZ3SZJvjrh
 o5oCeozjjBl79JYzDx625PVDgUrPIMal7ksogUQan1vWGpJ4du4Vcx/KYuLANQH3hmdjEQXbB1x
 fHKXClZsp1+mPcyIqrNqxGL+hdbR+M7j8JzsUNHQfsa159WbMdGyi+Myn1rbZu4ExexYIxBH+uN
 lYQbC8/i5PXr9eBOMiWbJfH6acl3nJoZcfjhFY0DcEN599rNQEKKRTDtJFPZhNGKVR/+24oaduy
 yWwC7qFPhTAf0PjJ+v1HBPQcgKOcYp5ay5bphFmwbiJjqS5I3J416gTXXGLhuR4rGDYUqPkj7Mq
 lGjc0/xMfdH155tcxCST0=
X-Google-Smtp-Source: AGHT+IHxU6rlyFKE+ecSTBXzyTGacoNtr/VdINnAntVOlqlzt8yhuUFcmacsq3r/S+xvjlAFaNnVZQ==
X-Received: by 2002:a05:6102:38ca:b0:5dd:840f:a449 with SMTP id
 ada2fe7eead31-5ddb214d13bmr188219137.14.1762454754907; 
 Thu, 06 Nov 2025 10:45:54 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-559957fb3c1sm1810004e0c.12.2025.11.06.10.45.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 10:45:54 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 09/13] drm/amdgpu/vce1: Implement VCE1 IP block (v2)
Date: Thu,  6 Nov 2025 19:44:44 +0100
Message-ID: <20251106184448.8099-10-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106184448.8099-1-timur.kristof@gmail.com>
References: <20251106184448.8099-1-timur.kristof@gmail.com>
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

Implement the necessary functionality to support the VCE1.
This implementation is based on:

- VCE2 code from amdgpu
- VCE1 code from radeon (the old driver)
- Some trial and error

A subsequent commit will ensure correct mapping for
the VCPU BO, which will make this actually work.

v2:
- Use memset_io more.
- Use memcpy_toio more.
- Remove __func__ from warnings.
- Don't reserve and map the VCPU BO anymore.
- Add empty line to multi-line comments

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Acked-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile     |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h |   1 +
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c   | 784 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/vce_v1_0.h   |  32 +
 4 files changed, 818 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/vce_v1_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index ebe08947c5a3..c88760fb52ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -78,7 +78,7 @@ amdgpu-$(CONFIG_DRM_AMDGPU_CIK)+= cik.o cik_ih.o \
 	dce_v8_0.o gfx_v7_0.o cik_sdma.o uvd_v4_2.o vce_v2_0.o
 
 amdgpu-$(CONFIG_DRM_AMDGPU_SI)+= si.o gmc_v6_0.o gfx_v6_0.o si_ih.o si_dma.o dce_v6_0.o \
-	uvd_v3_1.o
+	uvd_v3_1.o vce_v1_0.o
 
 amdgpu-y += \
 	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
index 22acd7b35945..050783802623 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.h
@@ -51,6 +51,7 @@ struct amdgpu_vce {
 	struct drm_sched_entity	entity;
 	uint32_t                srbm_soft_reset;
 	unsigned		num_rings;
+	uint32_t		keyselect;
 };
 
 int amdgpu_vce_early_init(struct amdgpu_device *adev);
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
new file mode 100644
index 000000000000..bf9f943852cb
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.c
@@ -0,0 +1,784 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2013 Advanced Micro Devices, Inc.
+ * Copyright 2025 Valve Corporation
+ * Copyright 2025 Alexandre Demers
+ * All Rights Reserved.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the
+ * "Software"), to deal in the Software without restriction, including
+ * without limitation the rights to use, copy, modify, merge, publish,
+ * distribute, sub license, and/or sell copies of the Software, and to
+ * permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDERS, AUTHORS AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM,
+ * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
+ * OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE
+ * USE OR OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ * Authors: Christian König <christian.koenig@amd.com>
+ *          Timur Kristóf <timur.kristof@gmail.com>
+ *          Alexandre Demers <alexandre.f.demers@gmail.com>
+ */
+
+#include <linux/firmware.h>
+
+#include "amdgpu.h"
+#include "amdgpu_vce.h"
+#include "sid.h"
+#include "vce_v1_0.h"
+#include "vce/vce_1_0_d.h"
+#include "vce/vce_1_0_sh_mask.h"
+#include "oss/oss_1_0_d.h"
+#include "oss/oss_1_0_sh_mask.h"
+
+#define VCE_V1_0_FW_SIZE	(256 * 1024)
+#define VCE_V1_0_STACK_SIZE	(64 * 1024)
+#define VCE_V1_0_DATA_SIZE	(7808 * (AMDGPU_MAX_VCE_HANDLES + 1))
+#define VCE_STATUS_VCPU_REPORT_FW_LOADED_MASK	0x02
+
+static void vce_v1_0_set_ring_funcs(struct amdgpu_device *adev);
+static void vce_v1_0_set_irq_funcs(struct amdgpu_device *adev);
+
+struct vce_v1_0_fw_signature {
+	int32_t offset;
+	uint32_t length;
+	int32_t number;
+	struct {
+		uint32_t chip_id;
+		uint32_t keyselect;
+		uint32_t nonce[4];
+		uint32_t sigval[4];
+	} val[8];
+};
+
+/**
+ * vce_v1_0_ring_get_rptr - get read pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Returns the current hardware read pointer
+ */
+static uint64_t vce_v1_0_ring_get_rptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->me == 0)
+		return RREG32(mmVCE_RB_RPTR);
+	else
+		return RREG32(mmVCE_RB_RPTR2);
+}
+
+/**
+ * vce_v1_0_ring_get_wptr - get write pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Returns the current hardware write pointer
+ */
+static uint64_t vce_v1_0_ring_get_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->me == 0)
+		return RREG32(mmVCE_RB_WPTR);
+	else
+		return RREG32(mmVCE_RB_WPTR2);
+}
+
+/**
+ * vce_v1_0_ring_set_wptr - set write pointer
+ *
+ * @ring: amdgpu_ring pointer
+ *
+ * Commits the write pointer to the hardware
+ */
+static void vce_v1_0_ring_set_wptr(struct amdgpu_ring *ring)
+{
+	struct amdgpu_device *adev = ring->adev;
+
+	if (ring->me == 0)
+		WREG32(mmVCE_RB_WPTR, lower_32_bits(ring->wptr));
+	else
+		WREG32(mmVCE_RB_WPTR2, lower_32_bits(ring->wptr));
+}
+
+static int vce_v1_0_lmi_clean(struct amdgpu_device *adev)
+{
+	int i, j;
+
+	for (i = 0; i < 10; ++i) {
+		for (j = 0; j < 100; ++j) {
+			if (RREG32(mmVCE_LMI_STATUS) & 0x337f)
+				return 0;
+
+			mdelay(10);
+		}
+	}
+
+	return -ETIMEDOUT;
+}
+
+static int vce_v1_0_firmware_loaded(struct amdgpu_device *adev)
+{
+	int i, j;
+
+	for (i = 0; i < 10; ++i) {
+		for (j = 0; j < 100; ++j) {
+			if (RREG32(mmVCE_STATUS) & VCE_STATUS_VCPU_REPORT_FW_LOADED_MASK)
+				return 0;
+			mdelay(10);
+		}
+
+		dev_err(adev->dev, "VCE not responding, trying to reset the ECPU\n");
+
+		WREG32_P(mmVCE_SOFT_RESET,
+			VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK,
+			~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
+		mdelay(10);
+		WREG32_P(mmVCE_SOFT_RESET, 0,
+			~VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK);
+		mdelay(10);
+	}
+
+	return -ETIMEDOUT;
+}
+
+static void vce_v1_0_init_cg(struct amdgpu_device *adev)
+{
+	u32 tmp;
+
+	tmp = RREG32(mmVCE_CLOCK_GATING_A);
+	tmp |= VCE_CLOCK_GATING_A__CGC_DYN_CLOCK_MODE_MASK;
+	WREG32(mmVCE_CLOCK_GATING_A, tmp);
+
+	tmp = RREG32(mmVCE_CLOCK_GATING_B);
+	tmp |= 0x1e;
+	tmp &= ~0xe100e1;
+	WREG32(mmVCE_CLOCK_GATING_B, tmp);
+
+	tmp = RREG32(mmVCE_UENC_CLOCK_GATING);
+	tmp &= ~0xff9ff000;
+	WREG32(mmVCE_UENC_CLOCK_GATING, tmp);
+
+	tmp = RREG32(mmVCE_UENC_REG_CLOCK_GATING);
+	tmp &= ~0x3ff;
+	WREG32(mmVCE_UENC_REG_CLOCK_GATING, tmp);
+}
+
+/**
+ * vce_v1_0_load_fw_signature - load firmware signature into VCPU BO
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * The VCE1 firmware validation mechanism needs a firmware signature.
+ * This function finds the signature appropriate for the current
+ * ASIC and writes that into the VCPU BO.
+ */
+static int vce_v1_0_load_fw_signature(struct amdgpu_device *adev)
+{
+	const struct common_firmware_header *hdr;
+	struct vce_v1_0_fw_signature *sign;
+	unsigned int ucode_offset;
+	uint32_t chip_id;
+	u32 *cpu_addr;
+	int i;
+
+	hdr = (const struct common_firmware_header *)adev->vce.fw->data;
+	ucode_offset = le32_to_cpu(hdr->ucode_array_offset_bytes);
+	cpu_addr = adev->vce.cpu_addr;
+
+	sign = (void *)adev->vce.fw->data + ucode_offset;
+
+	switch (adev->asic_type) {
+	case CHIP_TAHITI:
+		chip_id = 0x01000014;
+		break;
+	case CHIP_VERDE:
+		chip_id = 0x01000015;
+		break;
+	case CHIP_PITCAIRN:
+		chip_id = 0x01000016;
+		break;
+	default:
+		dev_err(adev->dev, "asic_type %#010x was not found!", adev->asic_type);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < le32_to_cpu(sign->number); ++i) {
+		if (le32_to_cpu(sign->val[i].chip_id) == chip_id)
+			break;
+	}
+
+	if (i == le32_to_cpu(sign->number)) {
+		dev_err(adev->dev, "chip_id 0x%x for %s was not found in VCE firmware",
+			chip_id, amdgpu_asic_name[adev->asic_type]);
+		return -EINVAL;
+	}
+
+	cpu_addr += (256 - 64) / 4;
+	memcpy_toio(&cpu_addr[0], &sign->val[i].nonce[0], 16);
+	cpu_addr[4] = cpu_to_le32(le32_to_cpu(sign->length) + 64);
+
+	memset_io(&cpu_addr[5], 0, 44);
+	memcpy_toio(&cpu_addr[16], &sign[1], hdr->ucode_size_bytes - sizeof(*sign));
+
+	cpu_addr += (le32_to_cpu(sign->length) + 64) / 4;
+	memcpy_toio(&cpu_addr[0], &sign->val[i].sigval[0], 16);
+
+	adev->vce.keyselect = le32_to_cpu(sign->val[i].keyselect);
+
+	return 0;
+}
+
+static int vce_v1_0_wait_for_fw_validation(struct amdgpu_device *adev)
+{
+	int i;
+
+	dev_dbg(adev->dev, "VCE keyselect: %d", adev->vce.keyselect);
+	WREG32(mmVCE_LMI_FW_START_KEYSEL, adev->vce.keyselect);
+
+	for (i = 0; i < 10; ++i) {
+		mdelay(10);
+		if (RREG32(mmVCE_FW_REG_STATUS) & VCE_FW_REG_STATUS__DONE_MASK)
+			break;
+	}
+
+	if (!(RREG32(mmVCE_FW_REG_STATUS) & VCE_FW_REG_STATUS__DONE_MASK)) {
+		dev_err(adev->dev, "VCE FW validation timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	if (!(RREG32(mmVCE_FW_REG_STATUS) & VCE_FW_REG_STATUS__PASS_MASK)) {
+		dev_err(adev->dev, "VCE FW validation failed\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < 10; ++i) {
+		mdelay(10);
+		if (!(RREG32(mmVCE_FW_REG_STATUS) & VCE_FW_REG_STATUS__BUSY_MASK))
+			break;
+	}
+
+	if (RREG32(mmVCE_FW_REG_STATUS) & VCE_FW_REG_STATUS__BUSY_MASK) {
+		dev_err(adev->dev, "VCE FW busy timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+static int vce_v1_0_mc_resume(struct amdgpu_device *adev)
+{
+	uint32_t offset;
+	uint32_t size;
+
+	/*
+	 * When the keyselect is already set, don't perturb VCE FW.
+	 * Validation seems to always fail the second time.
+	 */
+	if (RREG32(mmVCE_LMI_FW_START_KEYSEL)) {
+		dev_dbg(adev->dev, "keyselect already set: 0x%x (on CPU: 0x%x)\n",
+			RREG32(mmVCE_LMI_FW_START_KEYSEL), adev->vce.keyselect);
+
+		WREG32_P(mmVCE_LMI_CTRL2, 0x0, ~0x100);
+		return 0;
+	}
+
+	WREG32_P(mmVCE_CLOCK_GATING_A, 0, ~(1 << 16));
+	WREG32_P(mmVCE_UENC_CLOCK_GATING, 0x1FF000, ~0xFF9FF000);
+	WREG32_P(mmVCE_UENC_REG_CLOCK_GATING, 0x3F, ~0x3F);
+	WREG32(mmVCE_CLOCK_GATING_B, 0);
+
+	WREG32_P(mmVCE_LMI_FW_PERIODIC_CTRL, 0x4, ~0x4);
+
+	WREG32(mmVCE_LMI_CTRL, 0x00398000);
+
+	WREG32_P(mmVCE_LMI_CACHE_CTRL, 0x0, ~0x1);
+	WREG32(mmVCE_LMI_SWAP_CNTL, 0);
+	WREG32(mmVCE_LMI_SWAP_CNTL1, 0);
+	WREG32(mmVCE_LMI_VM_CTRL, 0);
+
+	WREG32(mmVCE_VCPU_SCRATCH7, AMDGPU_MAX_VCE_HANDLES);
+
+	offset =  adev->vce.gpu_addr + AMDGPU_VCE_FIRMWARE_OFFSET;
+	size = VCE_V1_0_FW_SIZE;
+	WREG32(mmVCE_VCPU_CACHE_OFFSET0, offset & 0x7fffffff);
+	WREG32(mmVCE_VCPU_CACHE_SIZE0, size);
+
+	offset += size;
+	size = VCE_V1_0_STACK_SIZE;
+	WREG32(mmVCE_VCPU_CACHE_OFFSET1, offset & 0x7fffffff);
+	WREG32(mmVCE_VCPU_CACHE_SIZE1, size);
+
+	offset += size;
+	size = VCE_V1_0_DATA_SIZE;
+	WREG32(mmVCE_VCPU_CACHE_OFFSET2, offset & 0x7fffffff);
+	WREG32(mmVCE_VCPU_CACHE_SIZE2, size);
+
+	WREG32_P(mmVCE_LMI_CTRL2, 0x0, ~0x100);
+
+	return vce_v1_0_wait_for_fw_validation(adev);
+}
+
+/**
+ * vce_v1_0_is_idle() - Check idle status of VCE1 IP block
+ *
+ * @ip_block: amdgpu_ip_block pointer
+ *
+ * Check whether VCE is busy according to VCE_STATUS.
+ * Also check whether the SRBM thinks VCE is busy, although
+ * SRBM_STATUS.VCE_BUSY seems to be bogus because it
+ * appears to mirror the VCE_STATUS.VCPU_REPORT_FW_LOADED bit.
+ */
+static bool vce_v1_0_is_idle(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	bool busy =
+		(RREG32(mmVCE_STATUS) & (VCE_STATUS__JOB_BUSY_MASK | VCE_STATUS__UENC_BUSY_MASK)) ||
+		(RREG32(mmSRBM_STATUS2) & SRBM_STATUS2__VCE_BUSY_MASK);
+
+	return !busy;
+}
+
+static int vce_v1_0_wait_for_idle(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	unsigned int i;
+
+	for (i = 0; i < adev->usec_timeout; i++) {
+		udelay(1);
+		if (vce_v1_0_is_idle(ip_block))
+			return 0;
+	}
+	return -ETIMEDOUT;
+}
+
+/**
+ * vce_v1_0_start - start VCE block
+ *
+ * @adev: amdgpu_device pointer
+ *
+ * Setup and start the VCE block
+ */
+static int vce_v1_0_start(struct amdgpu_device *adev)
+{
+	struct amdgpu_ring *ring;
+	int r;
+
+	WREG32_P(mmVCE_STATUS, 1, ~1);
+
+	r = vce_v1_0_mc_resume(adev);
+	if (r)
+		return r;
+
+	ring = &adev->vce.ring[0];
+	WREG32(mmVCE_RB_RPTR, lower_32_bits(ring->wptr));
+	WREG32(mmVCE_RB_WPTR, lower_32_bits(ring->wptr));
+	WREG32(mmVCE_RB_BASE_LO, lower_32_bits(ring->gpu_addr));
+	WREG32(mmVCE_RB_BASE_HI, upper_32_bits(ring->gpu_addr));
+	WREG32(mmVCE_RB_SIZE, ring->ring_size / 4);
+
+	ring = &adev->vce.ring[1];
+	WREG32(mmVCE_RB_RPTR2, lower_32_bits(ring->wptr));
+	WREG32(mmVCE_RB_WPTR2, lower_32_bits(ring->wptr));
+	WREG32(mmVCE_RB_BASE_LO2, lower_32_bits(ring->gpu_addr));
+	WREG32(mmVCE_RB_BASE_HI2, upper_32_bits(ring->gpu_addr));
+	WREG32(mmVCE_RB_SIZE2, ring->ring_size / 4);
+
+	WREG32_P(mmVCE_VCPU_CNTL, VCE_VCPU_CNTL__CLK_EN_MASK,
+		 ~VCE_VCPU_CNTL__CLK_EN_MASK);
+
+	WREG32_P(mmVCE_SOFT_RESET,
+		VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK |
+		VCE_SOFT_RESET__FME_SOFT_RESET_MASK,
+		~(VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK |
+		  VCE_SOFT_RESET__FME_SOFT_RESET_MASK));
+
+	mdelay(100);
+
+	WREG32_P(mmVCE_SOFT_RESET, 0,
+		~(VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK |
+		  VCE_SOFT_RESET__FME_SOFT_RESET_MASK));
+
+	r = vce_v1_0_firmware_loaded(adev);
+
+	/* Clear VCE_STATUS, otherwise SRBM thinks VCE1 is busy. */
+	WREG32(mmVCE_STATUS, 0);
+
+	if (r) {
+		dev_err(adev->dev, "VCE not responding, giving up\n");
+		return r;
+	}
+
+	return 0;
+}
+
+static int vce_v1_0_stop(struct amdgpu_device *adev)
+{
+	struct amdgpu_ip_block *ip_block;
+	int status;
+	int i;
+
+	ip_block = amdgpu_device_ip_get_ip_block(adev, AMD_IP_BLOCK_TYPE_VCE);
+	if (!ip_block)
+		return -EINVAL;
+
+	if (vce_v1_0_lmi_clean(adev))
+		dev_warn(adev->dev, "VCE not idle\n");
+
+	if (vce_v1_0_wait_for_idle(ip_block))
+		dev_warn(adev->dev, "VCE busy: VCE_STATUS=0x%x, SRBM_STATUS2=0x%x\n",
+			RREG32(mmVCE_STATUS), RREG32(mmSRBM_STATUS2));
+
+	/* Stall UMC and register bus before resetting VCPU */
+	WREG32_P(mmVCE_LMI_CTRL2, 1 << 8, ~(1 << 8));
+
+	for (i = 0; i < 100; ++i) {
+		status = RREG32(mmVCE_LMI_STATUS);
+		if (status & 0x240)
+			break;
+		mdelay(1);
+	}
+
+	WREG32_P(mmVCE_VCPU_CNTL, 0, ~VCE_VCPU_CNTL__CLK_EN_MASK);
+
+	WREG32_P(mmVCE_SOFT_RESET,
+		VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK |
+		VCE_SOFT_RESET__FME_SOFT_RESET_MASK,
+		~(VCE_SOFT_RESET__ECPU_SOFT_RESET_MASK |
+		  VCE_SOFT_RESET__FME_SOFT_RESET_MASK));
+
+	WREG32(mmVCE_STATUS, 0);
+
+	return 0;
+}
+
+static void vce_v1_0_enable_mgcg(struct amdgpu_device *adev, bool enable)
+{
+	u32 tmp;
+
+	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_VCE_MGCG)) {
+		tmp = RREG32(mmVCE_CLOCK_GATING_A);
+		tmp |= VCE_CLOCK_GATING_A__CGC_DYN_CLOCK_MODE_MASK;
+		WREG32(mmVCE_CLOCK_GATING_A, tmp);
+
+		tmp = RREG32(mmVCE_UENC_CLOCK_GATING);
+		tmp &= ~0x1ff000;
+		tmp |= 0xff800000;
+		WREG32(mmVCE_UENC_CLOCK_GATING, tmp);
+
+		tmp = RREG32(mmVCE_UENC_REG_CLOCK_GATING);
+		tmp &= ~0x3ff;
+		WREG32(mmVCE_UENC_REG_CLOCK_GATING, tmp);
+	} else {
+		tmp = RREG32(mmVCE_CLOCK_GATING_A);
+		tmp &= ~VCE_CLOCK_GATING_A__CGC_DYN_CLOCK_MODE_MASK;
+		WREG32(mmVCE_CLOCK_GATING_A, tmp);
+
+		tmp = RREG32(mmVCE_UENC_CLOCK_GATING);
+		tmp |= 0x1ff000;
+		tmp &= ~0xff800000;
+		WREG32(mmVCE_UENC_CLOCK_GATING, tmp);
+
+		tmp = RREG32(mmVCE_UENC_REG_CLOCK_GATING);
+		tmp |= 0x3ff;
+		WREG32(mmVCE_UENC_REG_CLOCK_GATING, tmp);
+	}
+}
+
+static int vce_v1_0_early_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int r;
+
+	r = amdgpu_vce_early_init(adev);
+	if (r)
+		return r;
+
+	adev->vce.num_rings = 2;
+
+	vce_v1_0_set_ring_funcs(adev);
+	vce_v1_0_set_irq_funcs(adev);
+
+	return 0;
+}
+
+static int vce_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	struct amdgpu_ring *ring;
+	int r, i;
+
+	r = amdgpu_irq_add_id(adev, AMDGPU_IRQ_CLIENTID_LEGACY, 167, &adev->vce.irq);
+	if (r)
+		return r;
+
+	r = amdgpu_vce_sw_init(adev, VCE_V1_0_FW_SIZE +
+		VCE_V1_0_STACK_SIZE + VCE_V1_0_DATA_SIZE);
+	if (r)
+		return r;
+
+	r = amdgpu_vce_resume(adev);
+	if (r)
+		return r;
+	r = vce_v1_0_load_fw_signature(adev);
+	if (r)
+		return r;
+
+	for (i = 0; i < adev->vce.num_rings; i++) {
+		enum amdgpu_ring_priority_level hw_prio = amdgpu_vce_get_ring_prio(i);
+
+		ring = &adev->vce.ring[i];
+		sprintf(ring->name, "vce%d", i);
+		r = amdgpu_ring_init(adev, ring, 512, &adev->vce.irq, 0,
+				     hw_prio, NULL);
+		if (r)
+			return r;
+	}
+
+	return r;
+}
+
+static int vce_v1_0_sw_fini(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int r;
+
+	r = amdgpu_vce_suspend(adev);
+	if (r)
+		return r;
+
+	return amdgpu_vce_sw_fini(adev);
+}
+
+/**
+ * vce_v1_0_hw_init - start and test VCE block
+ *
+ * @ip_block: Pointer to the amdgpu_ip_block for this hw instance.
+ *
+ * Initialize the hardware, boot up the VCPU and do some testing
+ */
+static int vce_v1_0_hw_init(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int i, r;
+
+	if (adev->pm.dpm_enabled)
+		amdgpu_dpm_enable_vce(adev, true);
+	else
+		amdgpu_asic_set_vce_clocks(adev, 10000, 10000);
+
+	for (i = 0; i < adev->vce.num_rings; i++) {
+		r = amdgpu_ring_test_helper(&adev->vce.ring[i]);
+		if (r)
+			return r;
+	}
+
+	dev_info(adev->dev, "VCE initialized successfully.\n");
+
+	return 0;
+}
+
+static int vce_v1_0_hw_fini(struct amdgpu_ip_block *ip_block)
+{
+	int r;
+
+	r = vce_v1_0_stop(ip_block->adev);
+	if (r)
+		return r;
+
+	cancel_delayed_work_sync(&ip_block->adev->vce.idle_work);
+	return 0;
+}
+
+static int vce_v1_0_suspend(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int r;
+
+	/*
+	 * Proper cleanups before halting the HW engine:
+	 *   - cancel the delayed idle work
+	 *   - enable powergating
+	 *   - enable clockgating
+	 *   - disable dpm
+	 *
+	 * TODO: to align with the VCN implementation, move the
+	 * jobs for clockgating/powergating/dpm setting to
+	 * ->set_powergating_state().
+	 */
+	cancel_delayed_work_sync(&adev->vce.idle_work);
+
+	if (adev->pm.dpm_enabled) {
+		amdgpu_dpm_enable_vce(adev, false);
+	} else {
+		amdgpu_asic_set_vce_clocks(adev, 0, 0);
+		amdgpu_device_ip_set_powergating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+						       AMD_PG_STATE_GATE);
+		amdgpu_device_ip_set_clockgating_state(adev, AMD_IP_BLOCK_TYPE_VCE,
+						       AMD_CG_STATE_GATE);
+	}
+
+	r = vce_v1_0_hw_fini(ip_block);
+	if (r) {
+		dev_err(adev->dev, "vce_v1_0_hw_fini() failed with error %i", r);
+		return r;
+	}
+
+	return amdgpu_vce_suspend(adev);
+}
+
+static int vce_v1_0_resume(struct amdgpu_ip_block *ip_block)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+	int r;
+
+	r = amdgpu_vce_resume(adev);
+	if (r)
+		return r;
+	r = vce_v1_0_load_fw_signature(adev);
+	if (r)
+		return r;
+
+	return vce_v1_0_hw_init(ip_block);
+}
+
+static int vce_v1_0_set_interrupt_state(struct amdgpu_device *adev,
+					struct amdgpu_irq_src *source,
+					unsigned int type,
+					enum amdgpu_interrupt_state state)
+{
+	uint32_t val = 0;
+
+	if (state == AMDGPU_IRQ_STATE_ENABLE)
+		val |= VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN_MASK;
+
+	WREG32_P(mmVCE_SYS_INT_EN, val,
+		 ~VCE_SYS_INT_EN__VCE_SYS_INT_TRAP_INTERRUPT_EN_MASK);
+	return 0;
+}
+
+static int vce_v1_0_process_interrupt(struct amdgpu_device *adev,
+				      struct amdgpu_irq_src *source,
+				      struct amdgpu_iv_entry *entry)
+{
+	dev_dbg(adev->dev, "IH: VCE\n");
+	switch (entry->src_data[0]) {
+	case 0:
+	case 1:
+		amdgpu_fence_process(&adev->vce.ring[entry->src_data[0]]);
+		break;
+	default:
+		dev_err(adev->dev, "Unhandled interrupt: %d %d\n",
+			  entry->src_id, entry->src_data[0]);
+		break;
+	}
+
+	return 0;
+}
+
+static int vce_v1_0_set_clockgating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_clockgating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	vce_v1_0_init_cg(adev);
+	vce_v1_0_enable_mgcg(adev, state == AMD_CG_STATE_GATE);
+
+	return 0;
+}
+
+static int vce_v1_0_set_powergating_state(struct amdgpu_ip_block *ip_block,
+					  enum amd_powergating_state state)
+{
+	struct amdgpu_device *adev = ip_block->adev;
+
+	/*
+	 * This doesn't actually powergate the VCE block.
+	 * That's done in the dpm code via the SMC.  This
+	 * just re-inits the block as necessary.  The actual
+	 * gating still happens in the dpm code.  We should
+	 * revisit this when there is a cleaner line between
+	 * the smc and the hw blocks
+	 */
+	if (state == AMD_PG_STATE_GATE)
+		return vce_v1_0_stop(adev);
+	else
+		return vce_v1_0_start(adev);
+}
+
+static const struct amd_ip_funcs vce_v1_0_ip_funcs = {
+	.name = "vce_v1_0",
+	.early_init = vce_v1_0_early_init,
+	.sw_init = vce_v1_0_sw_init,
+	.sw_fini = vce_v1_0_sw_fini,
+	.hw_init = vce_v1_0_hw_init,
+	.hw_fini = vce_v1_0_hw_fini,
+	.suspend = vce_v1_0_suspend,
+	.resume = vce_v1_0_resume,
+	.is_idle = vce_v1_0_is_idle,
+	.wait_for_idle = vce_v1_0_wait_for_idle,
+	.set_clockgating_state = vce_v1_0_set_clockgating_state,
+	.set_powergating_state = vce_v1_0_set_powergating_state,
+};
+
+static const struct amdgpu_ring_funcs vce_v1_0_ring_funcs = {
+	.type = AMDGPU_RING_TYPE_VCE,
+	.align_mask = 0xf,
+	.nop = VCE_CMD_NO_OP,
+	.support_64bit_ptrs = false,
+	.no_user_fence = true,
+	.get_rptr = vce_v1_0_ring_get_rptr,
+	.get_wptr = vce_v1_0_ring_get_wptr,
+	.set_wptr = vce_v1_0_ring_set_wptr,
+	.parse_cs = amdgpu_vce_ring_parse_cs,
+	.emit_frame_size = 6, /* amdgpu_vce_ring_emit_fence  x1 no user fence */
+	.emit_ib_size = 4, /* amdgpu_vce_ring_emit_ib */
+	.emit_ib = amdgpu_vce_ring_emit_ib,
+	.emit_fence = amdgpu_vce_ring_emit_fence,
+	.test_ring = amdgpu_vce_ring_test_ring,
+	.test_ib = amdgpu_vce_ring_test_ib,
+	.insert_nop = amdgpu_ring_insert_nop,
+	.pad_ib = amdgpu_ring_generic_pad_ib,
+	.begin_use = amdgpu_vce_ring_begin_use,
+	.end_use = amdgpu_vce_ring_end_use,
+};
+
+static void vce_v1_0_set_ring_funcs(struct amdgpu_device *adev)
+{
+	int i;
+
+	for (i = 0; i < adev->vce.num_rings; i++) {
+		adev->vce.ring[i].funcs = &vce_v1_0_ring_funcs;
+		adev->vce.ring[i].me = i;
+	}
+};
+
+static const struct amdgpu_irq_src_funcs vce_v1_0_irq_funcs = {
+	.set = vce_v1_0_set_interrupt_state,
+	.process = vce_v1_0_process_interrupt,
+};
+
+static void vce_v1_0_set_irq_funcs(struct amdgpu_device *adev)
+{
+	adev->vce.irq.num_types = 1;
+	adev->vce.irq.funcs = &vce_v1_0_irq_funcs;
+};
+
+const struct amdgpu_ip_block_version vce_v1_0_ip_block = {
+	.type = AMD_IP_BLOCK_TYPE_VCE,
+	.major = 1,
+	.minor = 0,
+	.rev = 0,
+	.funcs = &vce_v1_0_ip_funcs,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/vce_v1_0.h b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.h
new file mode 100644
index 000000000000..206e7bec897f
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/vce_v1_0.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
+ * Copyright 2025 Valve Corporation
+ * Copyright 2025 Alexandre Demers
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
+#ifndef __VCE_V1_0_H__
+#define __VCE_V1_0_H__
+
+extern const struct amdgpu_ip_block_version vce_v1_0_ip_block;
+
+#endif
-- 
2.51.0


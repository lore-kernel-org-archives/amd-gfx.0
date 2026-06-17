Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CB7CD98F3
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Jun 2026 19:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC28F10F0B8;
	Wed, 17 Jun 2026 19:14:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QAX5/HNu";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0CCB10F0CE
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 19:14:38 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-490ae94a89eso465605e9.1
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Jun 2026 12:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781723677; x=1782328477; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9d/zwE2Gw7/q8dgKrxUpMhh761G3iDrJZmKiNNzeo0w=;
 b=QAX5/HNujjXWqndJAEJ1kst/02L2+x8TFTa/4iSgn/i0ZVbSEdk7hv5A5tqCQQPxId
 I+BsCkD+1kdLCbdE0OkMFacDpUSmdOSm6Sea2CI5wJUFiaYNldnrunLxgjyQDoFygqd+
 1G0uW7SLtsZPgIoJaPfJcca1494jJUZL/Lgsn555c4WydBll9mqfCeNHIUgC5qXtTeXV
 bSt2IHmZbq+cNVzUXebcM2V3ASUAUimMAsGBNcCe1jwJ+3itII3kviS3R4HLARg9KkLr
 gV0SwcKYGs5yWMmD8LQZQgPdAcgHfKUZRAE1FrGtZoENaTVgc7Vz1k5kTpwQaAOLvvfy
 sBhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781723677; x=1782328477;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=9d/zwE2Gw7/q8dgKrxUpMhh761G3iDrJZmKiNNzeo0w=;
 b=AV42FRu01SDTVtDZNOW1EnMVvrqCpxPRk4w/kC+VJk8muJvqc0HjomFYHxX+ZiE/Bf
 ivMyvuAyTb5KSsUOvdY+0cl3QR0QYHN2EoJLg2OHmSAy2C+oHzq4nH5/706dT/4jeEwc
 Q7XGBga0KKgAc36xc/rdIyfVPkkZUe6NiaunxoOBog+SMdLz2i8vJ/NC9JfNsrWmwl2Y
 dpPbrFAX53IGrRz5wo2iPkBRDMqf257d/mOvYqkA+3L7wEawSDlDteRHq/1a5w1VCYdN
 vtN4sd2jjrwQoqEKrAP0x5T/0RbOsV6oV7vj990Ig37dcS1GFqT7YRPzt0AzH8i7a9OC
 k/IQ==
X-Gm-Message-State: AOJu0YwlUWUTMPswn/q+djtEAApj/BDqCHBWhBFD7xkNa8eGUouger/v
 U7xQ1J51qfFu5w8opPVCdW0tVrQUdXg/yVNDDd0u9r8IKlv/DkpIDl/BVkrNxg==
X-Gm-Gg: Acq92OEsUXPYbHGBoXC2GSz8Uawb+1oGjUmDAd7YlPHUPIwD9yuPas1FPEJjvy+ZM4X
 xA+D5uAc3Fu+G6naoGMKwZXdF0gxQSmElbeIkTdtEC0gTVMxcc27eiL+jPG1mKzATb85m9iDzka
 OLC5W2T6RiBvulC/zOs2alC9oLiUiydKUyfwDgcJFNuNhW9j7kTqFBIpPUEPR9cN1bZSDsrDQQr
 hXQopaKV/EzVknGUPvLkuzi3zNbgnIooSR8nq1seEf039LJ+465dyK3DPbf6KvmSDgtuAnsQwJv
 DasWl+6FrN6wSkTubYOcshOLpuSr/zElcvAPVcP010Nh8hHZ/iZAaw5VdOfvUSc4Z0VT4sbPnbx
 UkWaQ7GKY614yLmZZQ9flQkxSvhSW+UcntDlGGAA4RVazFuW4+JNpd34DKSUwinkCgAA051KKZK
 2POrEMI7zySLm5+uG9NMlV3ooI+i6fyOkg94qnwwFVTvMTZTip8WrUcg==
X-Received: by 2002:a05:600c:4ec6:b0:490:b724:dbd6 with SMTP id
 5b1f17b1804b1-492381e4ad6mr11179055e9.6.1781723676850; 
 Wed, 17 Jun 2026 12:14:36 -0700 (PDT)
Received: from Timur-Hyperion.home (54001290.dsl.pool.telekom.hu.
 [84.0.18.144]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa96f0esm204686325e9.12.2026.06.17.12.14.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 12:14:36 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com, Natalie Vock <natalie.vock@gmx.de>,
 Mario Limonciello <mario.limonciello@amd.com>,
 =?UTF-8?q?Marek=20Ol=C5=A1=C3=A1k?= <maraeo@gmail.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Lazar Lijo <lijo.lazar@amd.com>, Martin Roukala <martin.roukala@mupuf.org>
Cc: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
Subject: [PATCH 04/17] drm/amdgpu: Delete soft reset code from legacy display
 driver
Date: Wed, 17 Jun 2026 21:14:15 +0200
Message-ID: <20260617191428.1784083-5-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617191428.1784083-1-timur.kristof@gmail.com>
References: <20260617191428.1784083-1-timur.kristof@gmail.com>
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

This was basically dead code, not used or called from anywhere.

Now that DC is the default display driver for all ASICs,
it is unlikely that anyone wants to develop this further.
Display hang related work should be focused on DC.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c | 66 --------------------------
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c  | 57 ----------------------
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c  | 57 ----------------------
 3 files changed, 180 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 055ec8196f90..20071c24edd5 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -410,36 +410,6 @@ static u32 dce_v10_0_hpd_get_gpio_reg(struct amdgpu_device *adev)
 	return mmDC_GPIO_HPD_A;
 }
 
-static bool dce_v10_0_is_display_hung(struct amdgpu_device *adev)
-{
-	u32 crtc_hung = 0;
-	u32 crtc_status[6];
-	u32 i, j, tmp;
-
-	for (i = 0; i < adev->mode_info.num_crtc; i++) {
-		tmp = RREG32(mmCRTC_CONTROL + crtc_offsets[i]);
-		if (REG_GET_FIELD(tmp, CRTC_CONTROL, CRTC_MASTER_EN)) {
-			crtc_status[i] = RREG32(mmCRTC_STATUS_HV_COUNT + crtc_offsets[i]);
-			crtc_hung |= (1 << i);
-		}
-	}
-
-	for (j = 0; j < 10; j++) {
-		for (i = 0; i < adev->mode_info.num_crtc; i++) {
-			if (crtc_hung & (1 << i)) {
-				tmp = RREG32(mmCRTC_STATUS_HV_COUNT + crtc_offsets[i]);
-				if (tmp != crtc_status[i])
-					crtc_hung &= ~(1 << i);
-			}
-		}
-		if (crtc_hung == 0)
-			return false;
-		udelay(100);
-	}
-
-	return true;
-}
-
 static void dce_v10_0_set_vga_render_state(struct amdgpu_device *adev,
 					   bool render)
 {
@@ -2956,40 +2926,6 @@ static bool dce_v10_0_is_idle(struct amdgpu_ip_block *ip_block)
 	return true;
 }
 
-static bool dce_v10_0_check_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	struct amdgpu_device *adev = ip_block->adev;
-
-	return dce_v10_0_is_display_hung(adev);
-}
-
-static int dce_v10_0_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	u32 srbm_soft_reset = 0, tmp;
-	struct amdgpu_device *adev = ip_block->adev;
-
-	if (dce_v10_0_is_display_hung(adev))
-		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_DC_MASK;
-
-	if (srbm_soft_reset) {
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
-		WREG32(mmSRBM_SOFT_RESET, tmp);
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-
-		udelay(50);
-
-		tmp &= ~srbm_soft_reset;
-		WREG32(mmSRBM_SOFT_RESET, tmp);
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-
-		/* Wait a little for things to settle down */
-		udelay(50);
-	}
-	return 0;
-}
-
 static void dce_v10_0_set_crtc_vblank_interrupt_state(struct amdgpu_device *adev,
 						     int crtc,
 						     enum amdgpu_interrupt_state state)
@@ -3332,8 +3268,6 @@ static const struct amd_ip_funcs dce_v10_0_ip_funcs = {
 	.suspend = dce_v10_0_suspend,
 	.resume = dce_v10_0_resume,
 	.is_idle = dce_v10_0_is_idle,
-	.check_soft_reset = dce_v10_0_check_soft_reset,
-	.soft_reset = dce_v10_0_soft_reset,
 	.set_clockgating_state = dce_v10_0_set_clockgating_state,
 	.set_powergating_state = dce_v10_0_set_powergating_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 0f47044bab5d..0eae0cca39ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -378,35 +378,6 @@ static u32 dce_v6_0_hpd_get_gpio_reg(struct amdgpu_device *adev)
 	return mmDC_GPIO_HPD_A;
 }
 
-static bool dce_v6_0_is_display_hung(struct amdgpu_device *adev)
-{
-	u32 crtc_hung = 0;
-	u32 crtc_status[6];
-	u32 i, j, tmp;
-
-	for (i = 0; i < adev->mode_info.num_crtc; i++) {
-		if (RREG32(mmCRTC_CONTROL + crtc_offsets[i]) & CRTC_CONTROL__CRTC_MASTER_EN_MASK) {
-			crtc_status[i] = RREG32(mmCRTC_STATUS_HV_COUNT + crtc_offsets[i]);
-			crtc_hung |= (1 << i);
-		}
-	}
-
-	for (j = 0; j < 10; j++) {
-		for (i = 0; i < adev->mode_info.num_crtc; i++) {
-			if (crtc_hung & (1 << i)) {
-				tmp = RREG32(mmCRTC_STATUS_HV_COUNT + crtc_offsets[i]);
-				if (tmp != crtc_status[i])
-					crtc_hung &= ~(1 << i);
-			}
-		}
-		if (crtc_hung == 0)
-			return false;
-		udelay(100);
-	}
-
-	return true;
-}
-
 static void dce_v6_0_set_vga_render_state(struct amdgpu_device *adev,
 					  bool render)
 {
@@ -2901,33 +2872,6 @@ static bool dce_v6_0_is_idle(struct amdgpu_ip_block *ip_block)
 	return true;
 }
 
-static int dce_v6_0_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	u32 srbm_soft_reset = 0, tmp;
-	struct amdgpu_device *adev = ip_block->adev;
-
-	if (dce_v6_0_is_display_hung(adev))
-		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_DC_MASK;
-
-	if (srbm_soft_reset) {
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
-		WREG32(mmSRBM_SOFT_RESET, tmp);
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-
-		udelay(50);
-
-		tmp &= ~srbm_soft_reset;
-		WREG32(mmSRBM_SOFT_RESET, tmp);
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-
-		/* Wait a little for things to settle down */
-		udelay(50);
-	}
-	return 0;
-}
-
 static void dce_v6_0_set_crtc_vblank_interrupt_state(struct amdgpu_device *adev,
 						     int crtc,
 						     enum amdgpu_interrupt_state state)
@@ -3224,7 +3168,6 @@ static const struct amd_ip_funcs dce_v6_0_ip_funcs = {
 	.suspend = dce_v6_0_suspend,
 	.resume = dce_v6_0_resume,
 	.is_idle = dce_v6_0_is_idle,
-	.soft_reset = dce_v6_0_soft_reset,
 	.set_clockgating_state = dce_v6_0_set_clockgating_state,
 	.set_powergating_state = dce_v6_0_set_powergating_state,
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index a885e8d47f70..c02b1345d9c2 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -362,35 +362,6 @@ static u32 dce_v8_0_hpd_get_gpio_reg(struct amdgpu_device *adev)
 	return mmDC_GPIO_HPD_A;
 }
 
-static bool dce_v8_0_is_display_hung(struct amdgpu_device *adev)
-{
-	u32 crtc_hung = 0;
-	u32 crtc_status[6];
-	u32 i, j, tmp;
-
-	for (i = 0; i < adev->mode_info.num_crtc; i++) {
-		if (RREG32(mmCRTC_CONTROL + crtc_offsets[i]) & CRTC_CONTROL__CRTC_MASTER_EN_MASK) {
-			crtc_status[i] = RREG32(mmCRTC_STATUS_HV_COUNT + crtc_offsets[i]);
-			crtc_hung |= (1 << i);
-		}
-	}
-
-	for (j = 0; j < 10; j++) {
-		for (i = 0; i < adev->mode_info.num_crtc; i++) {
-			if (crtc_hung & (1 << i)) {
-				tmp = RREG32(mmCRTC_STATUS_HV_COUNT + crtc_offsets[i]);
-				if (tmp != crtc_status[i])
-					crtc_hung &= ~(1 << i);
-			}
-		}
-		if (crtc_hung == 0)
-			return false;
-		udelay(100);
-	}
-
-	return true;
-}
-
 static void dce_v8_0_set_vga_render_state(struct amdgpu_device *adev,
 					  bool render)
 {
@@ -2873,33 +2844,6 @@ static bool dce_v8_0_is_idle(struct amdgpu_ip_block *ip_block)
 	return true;
 }
 
-static int dce_v8_0_soft_reset(struct amdgpu_ip_block *ip_block)
-{
-	u32 srbm_soft_reset = 0, tmp;
-	struct amdgpu_device *adev = ip_block->adev;
-
-	if (dce_v8_0_is_display_hung(adev))
-		srbm_soft_reset |= SRBM_SOFT_RESET__SOFT_RESET_DC_MASK;
-
-	if (srbm_soft_reset) {
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-		tmp |= srbm_soft_reset;
-		dev_info(adev->dev, "SRBM_SOFT_RESET=0x%08X\n", tmp);
-		WREG32(mmSRBM_SOFT_RESET, tmp);
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-
-		udelay(50);
-
-		tmp &= ~srbm_soft_reset;
-		WREG32(mmSRBM_SOFT_RESET, tmp);
-		tmp = RREG32(mmSRBM_SOFT_RESET);
-
-		/* Wait a little for things to settle down */
-		udelay(50);
-	}
-	return 0;
-}
-
 static void dce_v8_0_set_crtc_vblank_interrupt_state(struct amdgpu_device *adev,
 						     int crtc,
 						     enum amdgpu_interrupt_state state)
@@ -3241,7 +3185,6 @@ static const struct amd_ip_funcs dce_v8_0_ip_funcs = {
 	.suspend = dce_v8_0_suspend,
 	.resume = dce_v8_0_resume,
 	.is_idle = dce_v8_0_is_idle,
-	.soft_reset = dce_v8_0_soft_reset,
 	.set_clockgating_state = dce_v8_0_set_clockgating_state,
 	.set_powergating_state = dce_v8_0_set_powergating_state,
 };
-- 
2.54.0


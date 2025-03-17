Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3C4AC35FFA
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 06:07:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F3DA310E326;
	Mon, 17 Mar 2025 06:07:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HZbjQrmv";
	dkim-atps=neutral
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6193510E271
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 06:07:28 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-471fe5e0a80so37376321cf.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Mar 2025 23:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742191645; x=1742796445; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=SZgLbniYwLPD2dGg+OGoLkuVrTo7Ei3QwQrY3uo6fDE=;
 b=HZbjQrmvpUtEVR+7F+B7R0BwH14Zj0Jj6diJTkUMQWM9R3IonDhncX1KIWbZZ/7Pdf
 UsDjn0076TE0tvlMZLsyTjOOIWvqpezQNkW7dNHK7RDCFs/h/M/v8ZWL18LbnLyFT3f9
 2F2Ir6loGTWplHGa/16Zla9EVWM9O3vtTvHkZkwbAN+RO1OjwlfdTi8UViPeZBpoZitB
 uqJRDBerhM4cbWm02tD0qFmvAUgY2nXbFXn7GM3aU8zAzbRzGeKNBNOUC7LiAeoKsTcq
 9EltmhwQbYFZIZ4/TTmgmnIqgFOFswe0F9PK2DzJc6PdUarSl6UdmeDEbAgY1Xo131F7
 Rzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742191645; x=1742796445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SZgLbniYwLPD2dGg+OGoLkuVrTo7Ei3QwQrY3uo6fDE=;
 b=rlb6Z+Av2Ri9op0oOXgICHhZNhUXlwy2zx4NtJ3/a0xcP1LVpAX9XCOwMmNQVep3ck
 OyvfavEydtBF71oefXlxT9NaxeayJ8xwuZe2tL6+hDKwNnI7JX1SBaktkanGi0v0z4fd
 q41qmarrXuY4M1wIuXf+evbpUSK0J43McrWs05Yr26PW0I0Bn6aWqUZCjqmMdVMzrh+z
 K0v+Ts1Dt6zbtb1R28WoAivfaFpxp03L0GR1D18ll5cD4o3RSWfnXehRMcKN3BDwKl11
 mHUCMg+PrLZplGsyKnz0RwYv8zSd7DYwFcRdZ4KpcIk88AP6MluS5p8zYLb68hD/PEsQ
 NwuA==
X-Gm-Message-State: AOJu0YxOM+9kwuA5hHTje7E7Uv15dP/cLHcxl/p25g1JsODnAiRQlNpj
 aKdDJwF0BAG1q7keIU/uLnZLyqQqf10ELX8g7oSM3arufpiC0UKZM5d4og==
X-Gm-Gg: ASbGncub8zQmaiXCQt2NZ6+4Jk1WkXuT2YarOIGMjcyh3NtKuk06dzjwg40e+iMpLFg
 2LGHzbrO/bPcS15QXKGHBqdyZQQf0xI48Fy+A5sziM4lfOLnvB4IppGxnDpd7U0mMvOQEUCa4qe
 Xk4n2AxS7ai/F4zPbfAKvH8RN6xmiZkOdZWUTTlX6OGmVSANbAQl4J0Z28A09kwk+Gb5yhNBJNB
 bTlZGDokOA43u3StKC4eLNmNzC1b2TP5V9Ynnt8fCw2nOgPS/tKhE3cDKIG/RABS3ghxCE9uWJI
 53lof0Mw4OzWdRAEp5eWRT4ddETuh6csOgBrstAwGuZgmJBv7w+zAavNOwiaDwKqrcEq+F2H2ZD
 z7A==
X-Google-Smtp-Source: AGHT+IHwbe/WgeD2zl9nc/Ct6CfDha4ofwnavcQjJJ3RmPE4Kbfu4LIfytjujMmVEFQVzw6Z4yzJgw==
X-Received: by 2002:ac8:5908:0:b0:476:89a8:f73f with SMTP id
 d75a77b69052e-476c81461damr170431801cf.21.1742191645458; 
 Sun, 16 Mar 2025 23:07:25 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb7f4f08sm50605931cf.56.2025.03.16.23.07.24
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 23:07:25 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/18] drm/amdgpu: use proper defines,
 shifts and masks in DCE6 code
Date: Mon, 17 Mar 2025 02:06:47 -0400
Message-ID: <20250317060702.5297-4-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250317060702.5297-1-alexandre.f.demers@gmail.com>
References: <20250317060702.5297-1-alexandre.f.demers@gmail.com>
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

By replacing VGA_VSTATUS_CNTL by VGA_RENDER_CONTROL__VGA_VSTATUS_CNTL_MASK,
we also need to fix its usage in GMC6.

Note: VGA_VSTATUS_CNTL's binary value was inverted in dce_6_0_sh_mask.h,
so we need to invert its value where it was used.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         | 18 ++++++++---------
 drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c         |  2 +-
 drivers/gpu/drm/amd/amdgpu/si_enums.h         |  5 -----
 drivers/gpu/drm/amd/amdgpu/sid.h              | 20 -------------------
 .../include/asic_reg/dce/dce_6_0_sh_mask.h    |  4 +++-
 5 files changed, 13 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index e1b0779e835f..a9a087a841ea 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -383,7 +383,7 @@ static void dce_v6_0_set_vga_render_state(struct amdgpu_device *adev,
 {
 	if (!render)
 		WREG32(mmVGA_RENDER_CONTROL,
-			RREG32(mmVGA_RENDER_CONTROL) & VGA_VSTATUS_CNTL);
+			RREG32(mmVGA_RENDER_CONTROL) & ~VGA_RENDER_CONTROL__VGA_VSTATUS_CNTL_MASK);
 
 }
 
@@ -2078,7 +2078,7 @@ static void dce_v6_0_set_interleave(struct drm_crtc *crtc,
 
 	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
 		WREG32(mmDATA_FORMAT + amdgpu_crtc->crtc_offset,
-		       INTERLEAVE_EN);
+			DATA_FORMAT__INTERLEAVE_EN_MASK);
 	else
 		WREG32(mmDATA_FORMAT + amdgpu_crtc->crtc_offset, 0);
 }
@@ -2132,7 +2132,7 @@ static void dce_v6_0_crtc_load_lut(struct drm_crtc *crtc)
 	WREG32(mmDEGAMMA_CONTROL + amdgpu_crtc->crtc_offset,
 	       ((0 << DEGAMMA_CONTROL__GRPH_DEGAMMA_MODE__SHIFT) |
 		(0 << DEGAMMA_CONTROL__OVL_DEGAMMA_MODE__SHIFT) |
-		ICON_DEGAMMA_MODE(0) |
+		(0 << DEGAMMA_CONTROL__ICON_DEGAMMA_MODE__SHIFT) |
 		(0 << DEGAMMA_CONTROL__CURSOR_DEGAMMA_MODE__SHIFT)));
 	WREG32(mmGAMUT_REMAP_CONTROL + amdgpu_crtc->crtc_offset,
 	       ((0 << GAMUT_REMAP_CONTROL__GRPH_GAMUT_REMAP_MODE__SHIFT) |
@@ -2908,12 +2908,12 @@ static void dce_v6_0_set_crtc_vblank_interrupt_state(struct amdgpu_device *adev,
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 		interrupt_mask = RREG32(mmINT_MASK + reg_block);
-		interrupt_mask &= ~VBLANK_INT_MASK;
+		interrupt_mask &= ~INT_MASK__VBLANK_INT_MASK;
 		WREG32(mmINT_MASK + reg_block, interrupt_mask);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
 		interrupt_mask = RREG32(mmINT_MASK + reg_block);
-		interrupt_mask |= VBLANK_INT_MASK;
+		interrupt_mask |= INT_MASK__VBLANK_INT_MASK;
 		WREG32(mmINT_MASK + reg_block, interrupt_mask);
 		break;
 	default:
@@ -2943,12 +2943,12 @@ static int dce_v6_0_set_hpd_interrupt_state(struct amdgpu_device *adev,
 	switch (state) {
 	case AMDGPU_IRQ_STATE_DISABLE:
 		dc_hpd_int_cntl = RREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[type]);
-		dc_hpd_int_cntl &= ~DC_HPDx_INT_EN;
+		dc_hpd_int_cntl &= ~DC_HPD1_INT_CONTROL__DC_HPD1_INT_EN_MASK;
 		WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[type], dc_hpd_int_cntl);
 		break;
 	case AMDGPU_IRQ_STATE_ENABLE:
 		dc_hpd_int_cntl = RREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[type]);
-		dc_hpd_int_cntl |= DC_HPDx_INT_EN;
+		dc_hpd_int_cntl |= DC_HPD1_INT_CONTROL__DC_HPD1_INT_EN_MASK;
 		WREG32(mmDC_HPD1_INT_CONTROL + hpd_offsets[type], dc_hpd_int_cntl);
 		break;
 	default:
@@ -3018,7 +3018,7 @@ static int dce_v6_0_crtc_irq(struct amdgpu_device *adev,
 	switch (entry->src_data[0]) {
 	case 0: /* vblank */
 		if (disp_int & interrupt_status_offsets[crtc].vblank)
-			WREG32(mmVBLANK_STATUS + crtc_offsets[crtc], VBLANK_ACK);
+			WREG32(mmVBLANK_STATUS + crtc_offsets[crtc], VBLANK_STATUS__VBLANK_ACK_MASK);
 		else
 			DRM_DEBUG("IH: IH event w/o asserted irq bit?\n");
 
@@ -3029,7 +3029,7 @@ static int dce_v6_0_crtc_irq(struct amdgpu_device *adev,
 		break;
 	case 1: /* vline */
 		if (disp_int & interrupt_status_offsets[crtc].vline)
-			WREG32(mmVLINE_STATUS + crtc_offsets[crtc], VLINE_ACK);
+			WREG32(mmVLINE_STATUS + crtc_offsets[crtc], VLINE_STATUS__VLINE_ACK_MASK);
 		else
 			DRM_DEBUG("IH: IH event w/o asserted irq bit?\n");
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
index ca000b3d1afc..2942fe8f80ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v6_0.c
@@ -248,7 +248,7 @@ static void gmc_v6_0_mc_program(struct amdgpu_device *adev)
 
 		/* disable VGA render */
 		tmp = RREG32(mmVGA_RENDER_CONTROL);
-		tmp &= ~VGA_VSTATUS_CNTL;
+		tmp &= VGA_RENDER_CONTROL__VGA_VSTATUS_CNTL_MASK;
 		WREG32(mmVGA_RENDER_CONTROL, tmp);
 	}
 	/* Update configuration */
diff --git a/drivers/gpu/drm/amd/amdgpu/si_enums.h b/drivers/gpu/drm/amd/amdgpu/si_enums.h
index b44a32bacd5c..f6804c9b7a27 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_enums.h
+++ b/drivers/gpu/drm/amd/amdgpu/si_enums.h
@@ -23,23 +23,18 @@
 #ifndef SI_ENUMS_H
 #define SI_ENUMS_H
 
-#define VBLANK_INT_MASK                (1 << 0)
-#define DC_HPDx_INT_EN                 (1 << 16)
 #define VBLANK_ACK                     (1 << 4)
 #define VLINE_ACK                      (1 << 4)
 
 #define CURSOR_WIDTH 64
 #define CURSOR_HEIGHT 64
 
-#define VGA_VSTATUS_CNTL               0xFFFCFFFF
 #define PRIORITY_MARK_MASK             0x7fff
 #define PRIORITY_OFF                   (1 << 16)
 #define PRIORITY_ALWAYS_ON             (1 << 20)
-#define INTERLEAVE_EN                  (1 << 0)
 
 #define LATENCY_WATERMARK_MASK(x)      ((x) << 16)
 #define DC_LB_MEMORY_CONFIG(x)         ((x) << 20)
-#define ICON_DEGAMMA_MODE(x)           (((x) & 0x3) << 8)
 
 #define GRPH_ENDIAN_SWAP(x)            (((x) & 0x3) << 0)
 #define GRPH_ENDIAN_NONE               0
diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgpu/sid.h
index cbf232f5235b..00eb40d4c1a2 100644
--- a/drivers/gpu/drm/amd/amdgpu/sid.h
+++ b/drivers/gpu/drm/amd/amdgpu/sid.h
@@ -787,26 +787,6 @@
 #       define LATENCY_LOW_WATERMARK(x)				((x) << 0)
 #       define LATENCY_HIGH_WATERMARK(x)			((x) << 16)
 
-/* 0x6bb8, 0x77b8, 0x103b8, 0x10fb8, 0x11bb8, 0x127b8 */
-#define VLINE_STATUS                                    0x1AEE
-#       define VLINE_OCCURRED                           (1 << 0)
-#       define VLINE_ACK                                (1 << 4)
-#       define VLINE_STAT                               (1 << 12)
-#       define VLINE_INTERRUPT                          (1 << 16)
-#       define VLINE_INTERRUPT_TYPE                     (1 << 17)
-/* 0x6bbc, 0x77bc, 0x103bc, 0x10fbc, 0x11bbc, 0x127bc */
-#define VBLANK_STATUS                                   0x1AEF
-#       define VBLANK_OCCURRED                          (1 << 0)
-#       define VBLANK_ACK                               (1 << 4)
-#       define VBLANK_STAT                              (1 << 12)
-#       define VBLANK_INTERRUPT                         (1 << 16)
-#       define VBLANK_INTERRUPT_TYPE                    (1 << 17)
-
-/* 0x6b40, 0x7740, 0x10340, 0x10f40, 0x11b40, 0x12740 */
-#define INT_MASK                                        0x1AD0
-#       define VBLANK_INT_MASK                          (1 << 0)
-#       define VLINE_INT_MASK                           (1 << 4)
-
 #define DISP_INTERRUPT_STATUS                           0x183D
 #       define LB_D1_VLINE_INTERRUPT                    (1 << 2)
 #       define LB_D1_VBLANK_INTERRUPT                   (1 << 3)
diff --git a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
index bd8085ec54ed..942098af5655 100644
--- a/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
+++ b/drivers/gpu/drm/amd/include/asic_reg/dce/dce_6_0_sh_mask.h
@@ -5242,6 +5242,8 @@
 #define DEGAMMA_CONTROL__CURSOR_DEGAMMA_MODE__SHIFT 0x0000000c
 #define DEGAMMA_CONTROL__GRPH_DEGAMMA_MODE_MASK 0x00000003L
 #define DEGAMMA_CONTROL__GRPH_DEGAMMA_MODE__SHIFT 0x00000000
+#define DEGAMMA_CONTROL__ICON_DEGAMMA_MODE_MASK 0x00000300L	// (((x) & 0x3) << 8)
+#define DEGAMMA_CONTROL__ICON_DEGAMMA_MODE__SHIFT 0x00000008
 #define DEGAMMA_CONTROL__OVL_DEGAMMA_MODE_MASK 0x00000030L
 #define DEGAMMA_CONTROL__OVL_DEGAMMA_MODE__SHIFT 0x00000004
 #define DENORM_CONTROL__DENORM_MODE_MASK 0x00000007L
@@ -9554,7 +9556,7 @@
 #define VGA_RENDER_CONTROL__VGA_LOCK_8DOT__SHIFT 0x00000018
 #define VGA_RENDER_CONTROL__VGAREG_LINECMP_COMPATIBILITY_SEL_MASK 0x02000000L
 #define VGA_RENDER_CONTROL__VGAREG_LINECMP_COMPATIBILITY_SEL__SHIFT 0x00000019
-#define VGA_RENDER_CONTROL__VGA_VSTATUS_CNTL_MASK 0x00030000L
+#define VGA_RENDER_CONTROL__VGA_VSTATUS_CNTL_MASK 0x00030000L	// Interestingly, it was flipped from 0xFFFCFFFF
 #define VGA_RENDER_CONTROL__VGA_VSTATUS_CNTL__SHIFT 0x00000010
 #define VGA_SEQUENCER_RESET_CONTROL__D1_BLANK_DISPLAY_WHEN_SEQUENCER_RESET_MASK 0x00000001L
 #define VGA_SEQUENCER_RESET_CONTROL__D1_BLANK_DISPLAY_WHEN_SEQUENCER_RESET__SHIFT 0x00000000
-- 
2.48.1


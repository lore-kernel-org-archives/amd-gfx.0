Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3790AC3600A
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 01:47:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BFE010E855;
	Sat, 22 Mar 2025 01:47:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="frr0YzKR";
	dkim-atps=neutral
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com
 [209.85.160.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 071E110E853
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 01:47:16 +0000 (UTC)
Received: by mail-qt1-f178.google.com with SMTP id
 d75a77b69052e-4767e969b94so48329911cf.2
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 18:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742608035; x=1743212835; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=tUmm/YF0/TNf0Hk+af3tJVJyJy6FSESnV2RkXzr8/j4=;
 b=frr0YzKR6WkgxVSUifqUhsZ6vW0ozW1nV6t40v5RQBlPsJszXHL66dEabopg1DsHV5
 0sxk2qv4uFwORRxRYV07iEC/TybfHKvyMES17xyzTDqWR3MblvE985vZFwNzZpTZ9tbu
 zTYDOs/MBr3gRdtDji4x4kJamE4LapJ6fNuVSlA7KlaKTDz0AG1WWMhwRCLP1oZZZu3T
 0WzBaaVK8wLD2sExtgNuu8ubPs05tU2hrZB0Ep7hmcsuf95BeywBox6uF1UeEMJpk1NI
 t65dRh0u9vGSrGfhDHPOhuy0Zpz4Uzbim7b5se+9ibrMHoPf6mC2u1eUzzb/8nsSoreu
 2Hww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742608035; x=1743212835;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=tUmm/YF0/TNf0Hk+af3tJVJyJy6FSESnV2RkXzr8/j4=;
 b=W5qqElpgsVzDWxarqokgOV1zFpYih8wl4wqXDt7unpy5TO48IHrvIXdJv83Ltdbl1I
 wPWhXwq8+zSTtmUXQAX0+5DbAMZD61fDl0u5as8BA6Fn39GpeMgR+zNMoYiMvz0UHFbJ
 Kqow9V9b7lB5HCofjSm3wgk5B4fcsACwVUjUiMrw+fnzc0p1VUekU6XTHYec4PwwuLjF
 1iTNksPEpJZhPNpRn7kYFfvcnmShPy0Xt2bzLVt8dWOQCtxXi2NSn54JifdJNxU8OzaS
 YHAvZoULSFEdehEwKo3dyLibd2BYr9gBzkYn61Tra9SbPtP/PnBCmCF9HOPyXs5AaP1X
 Uwyw==
X-Gm-Message-State: AOJu0Yxa7348I3cMKi+QaDyR5qXVeMSysnt0IPzlyWft6vZSmGa0bXd9
 RXOdu5fVlP7h7P4dDqLTBNyqVHExvrupMKY7Qd8E5hatD/J7HtAdMqkMSw==
X-Gm-Gg: ASbGncuaP3IMQT+feK/FVD16sbhi5Su4WUvT6gQTQBrJOhcCwoH9p2wI9kN5qAe9XGM
 fI0XOAM3qKSzzsty79pOdg1m6pRgCJI5Vo0QfdeQZSQFWOTysN2azNI52ZZz37ZoPDC0Jr6kEFH
 L3hPnsYikAJ+fgrBw1yiXH6t46lTewJoUTl5jceFOHh9tzPMNU/mEaLrYinvVuw41eko4y3zJt1
 PNyzROuv9TlxxS5riJ4ru+CPmBHhlul+hAl4I01+LZVov9CkyXc3Y+i+p8BKw+zFZFD5iX6wh27
 MdETahtWJRRCc9HiBVxpybULvGH7JiuUzbIXD5x4dU784fYyJ+Qps0xyJkgKHBXJJ/o=
X-Google-Smtp-Source: AGHT+IGheQM5BCZek7pEO4YXquOkBD7yRpd6anUubwtebI364bDCzunU0NxCBsX9h9vv+JSLaVXHBg==
X-Received: by 2002:a05:622a:1f85:b0:476:9e30:a8aa with SMTP id
 d75a77b69052e-4771de488e0mr95118571cf.38.1742608035037; 
 Fri, 21 Mar 2025 18:47:15 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d159964sm18688591cf.8.2025.03.21.18.47.14
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 18:47:14 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 03/18] drm/amdgpu: use proper defines,
 shifts and masks in DCE6 code
Date: Fri, 21 Mar 2025 21:46:45 -0400
Message-ID: <20250322014700.62356-4-alexandre.f.demers@gmail.com>
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
+#define DEGAMMA_CONTROL__ICON_DEGAMMA_MODE_MASK 0x00000300L
+#define DEGAMMA_CONTROL__ICON_DEGAMMA_MODE__SHIFT 0x00000008
 #define DEGAMMA_CONTROL__OVL_DEGAMMA_MODE_MASK 0x00000030L
 #define DEGAMMA_CONTROL__OVL_DEGAMMA_MODE__SHIFT 0x00000004
 #define DENORM_CONTROL__DENORM_MODE_MASK 0x00000007L
@@ -9554,7 +9556,7 @@
 #define VGA_RENDER_CONTROL__VGA_LOCK_8DOT__SHIFT 0x00000018
 #define VGA_RENDER_CONTROL__VGAREG_LINECMP_COMPATIBILITY_SEL_MASK 0x02000000L
 #define VGA_RENDER_CONTROL__VGAREG_LINECMP_COMPATIBILITY_SEL__SHIFT 0x00000019
-#define VGA_RENDER_CONTROL__VGA_VSTATUS_CNTL_MASK 0x00030000L
+#define VGA_RENDER_CONTROL__VGA_VSTATUS_CNTL_MASK 0x00030000L
 #define VGA_RENDER_CONTROL__VGA_VSTATUS_CNTL__SHIFT 0x00000010
 #define VGA_SEQUENCER_RESET_CONTROL__D1_BLANK_DISPLAY_WHEN_SEQUENCER_RESET_MASK 0x00000001L
 #define VGA_SEQUENCER_RESET_CONTROL__D1_BLANK_DISPLAY_WHEN_SEQUENCER_RESET__SHIFT 0x00000000
-- 
2.48.1


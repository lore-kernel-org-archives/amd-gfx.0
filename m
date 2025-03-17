Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F0A4C35FFF
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 06:07:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E28510E335;
	Mon, 17 Mar 2025 06:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="jZ7/hAjr";
	dkim-atps=neutral
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 075FC10E2DE
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 06:07:30 +0000 (UTC)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-4769aef457bso46741171cf.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Mar 2025 23:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742191649; x=1742796449; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ggqIJErV93iK7HIjnXBwgs4ThKXjSW6jd2J9W4DZKR0=;
 b=jZ7/hAjrvaWVgRr10QIn77bUcZc8BpB+dOjJyT3Nm25ZsHmaGabfYPzFRtrKFC2obB
 dGdZQNmZF8n1iwqhKjAAuO+ryZTZ7Vq6xTz4p1oVw6QrAQ4Kd2/QGoQPcHEfk+5LoYDx
 hWBDyXji9uUhDfJ4ifAQpIlN6qUenR8+VWzEv206xxtNf0fHKltf5CYFT5RpV5EkEv4K
 mZ6GYbwzCSsCql/be6OY+4iC6vKYdZhv22f2BwDkqmEQehvpvhh8LtJlyWD9je2mksDV
 n+OoPaRmc+ahPixTrTQk1GBK0Hs2+eJ+mY26WSExIjensZHhqQrE7pAFZYG6qp8d0DlD
 h5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742191649; x=1742796449;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ggqIJErV93iK7HIjnXBwgs4ThKXjSW6jd2J9W4DZKR0=;
 b=LFjJniev8dU5zrCU/L0pODcD9IVcsfhb96qXzgH01IeojRJR4AfSBjwjvTnFutJ27C
 o1GZAnVB6wN3YX1EIC+4JTxCg0VLKkSz0QrUfOETLD9FtukInk/nR0K4ab+wu4LMFixk
 oQDLJVYXpnyyL1aVYZxo7+0dMT4Aez/QMAajWazxLAH6uK4IO+pJxsu1mV2ac8Vjf8NE
 5OoPviIq2Hmz2BgQMTF1MK1soGYQZwJH8rAzkKpo+bP4h8XLRSJg/s32sXrHw4bNxe1d
 566Foyh2Cey9fB6vdJS3deDVVI+dIXy8Sa0jwZs40jzMwVkiyclTRLYbZYngfqd6NO7t
 z3MQ==
X-Gm-Message-State: AOJu0YwwUnbet+Bm6sjjCz8Mura13diOqBugnFfqYp4EQR0gGo8akBGJ
 Z1N+uC752BcW3auQFMuEIscvBQ3YuQKKY1oO9FZZg+Dt89E+bGR0loYERw==
X-Gm-Gg: ASbGncs/m576m18pppQDxBhB2W68ASIaGGfZRCB1aLvwk0Kdrc96Li2T9C00xNFS9TP
 xHkSG5UpkHm8hd+SikKViKA1dT5u/mZkPPlPdqGADjI6HAZC8UzqzvW/YKDWvKP50rVIlRN6CWs
 VXcgOxa5W/ov4NXuTc6NluH47l/PlnvXncGNaPfkWpLKQtGGRkXHbUWoMzvaBdX1iFY8j/HcVyp
 FrrWMsjFP8gJPs0TzBdMQ2Btb8obqGPV3Et9qOISJ3IsYThd0k3+dTJvb915X1ufKPMC2GLAUyt
 Ld+2bY6kW6S/6wvdaR75egaQBpEbCI3DSvOjxWfhYKIDTup7rPgSpLVS3cEZnZBEELc=
X-Google-Smtp-Source: AGHT+IEcpNFq3soZi0GokWg5Gz1oM4Puk55S2H9+1v3YE+SpKH3AA7/ML8lzYWzrN0la7OZS/k9FfA==
X-Received: by 2002:a05:622a:118d:b0:476:6215:eb08 with SMTP id
 d75a77b69052e-476c813f0b8mr142244201cf.22.1742191648742; 
 Sun, 16 Mar 2025 23:07:28 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb7f4f08sm50605931cf.56.2025.03.16.23.07.27
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 23:07:28 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 07/18] drm/amdgpu: move DCE6 away from sid.h and si_enums.h
 defines
Date: Mon, 17 Mar 2025 02:06:51 -0400
Message-ID: <20250317060702.5297-8-alexandre.f.demers@gmail.com>
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

This cleans up DCE6.

I added some minor tweaks taken from CIK to exit early 

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 154 +++++++--------
 drivers/gpu/drm/amd/amdgpu/si_enums.h |  14 --
 drivers/gpu/drm/amd/amdgpu/sid.h      | 275 ++++++++++----------------
 3 files changed, 182 insertions(+), 261 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 0ac66493ef40..19b267f1540b 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -983,16 +983,16 @@ static void dce_v6_0_program_watermarks(struct amdgpu_device *adev,
 	/* select wm A */
 	arb_control3 = RREG32(mmDPG_PIPE_ARBITRATION_CONTROL3 + amdgpu_crtc->crtc_offset);
 	tmp = arb_control3;
-	tmp &= ~LATENCY_WATERMARK_MASK(3);
-	tmp |= LATENCY_WATERMARK_MASK(1);
+	tmp &= ~(3 << DPG_PIPE_ARBITRATION_CONTROL3__URGENCY_WATERMARK_MASK__SHIFT);
+	tmp |= (1 << DPG_PIPE_ARBITRATION_CONTROL3__URGENCY_WATERMARK_MASK__SHIFT);
 	WREG32(mmDPG_PIPE_ARBITRATION_CONTROL3 + amdgpu_crtc->crtc_offset, tmp);
 	WREG32(mmDPG_PIPE_URGENCY_CONTROL + amdgpu_crtc->crtc_offset,
 	       ((latency_watermark_a << DPG_PIPE_URGENCY_CONTROL__URGENCY_LOW_WATERMARK__SHIFT)  |
 		(line_time << DPG_PIPE_URGENCY_CONTROL__URGENCY_HIGH_WATERMARK__SHIFT)));
 	/* select wm B */
 	tmp = RREG32(mmDPG_PIPE_ARBITRATION_CONTROL3 + amdgpu_crtc->crtc_offset);
-	tmp &= ~LATENCY_WATERMARK_MASK(3);
-	tmp |= LATENCY_WATERMARK_MASK(2);
+	tmp &= ~(3 << DPG_PIPE_ARBITRATION_CONTROL3__URGENCY_WATERMARK_MASK__SHIFT);
+	tmp |= (2 << DPG_PIPE_ARBITRATION_CONTROL3__URGENCY_WATERMARK_MASK__SHIFT);
 	WREG32(mmDPG_PIPE_ARBITRATION_CONTROL3 + amdgpu_crtc->crtc_offset, tmp);
 	WREG32(mmDPG_PIPE_URGENCY_CONTROL + amdgpu_crtc->crtc_offset,
 	       ((latency_watermark_b << DPG_PIPE_URGENCY_CONTROL__URGENCY_LOW_WATERMARK__SHIFT) |
@@ -1059,7 +1059,7 @@ static u32 dce_v6_0_line_buffer_adjust(struct amdgpu_device *adev,
 	}
 
 	WREG32(mmDC_LB_MEMORY_SPLIT + amdgpu_crtc->crtc_offset,
-	       DC_LB_MEMORY_CONFIG(tmp));
+	       (tmp << DC_LB_MEMORY_SPLIT__DC_LB_MEMORY_CONFIG__SHIFT));
 
 	WREG32(mmPIPE0_DMIF_BUFFER_CONTROL + pipe_offset,
 	       (buffer_alloc << PIPE0_DMIF_BUFFER_CONTROL__DMIF_BUFFERS_ALLOCATED__SHIFT));
@@ -1276,6 +1276,7 @@ static void dce_v6_0_audio_write_sad_regs(struct drm_encoder *encoder)
 	struct amdgpu_device *adev = drm_to_adev(dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig = amdgpu_encoder->enc_priv;
+	u32 offset;
 	struct drm_connector *connector;
 	struct drm_connector_list_iter iter;
 	struct amdgpu_connector *amdgpu_connector = NULL;
@@ -1297,6 +1298,11 @@ static void dce_v6_0_audio_write_sad_regs(struct drm_encoder *encoder)
 		{ ixAZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR13, HDMI_AUDIO_CODING_TYPE_WMA_PRO },
 	};
 
+	if (!dig || !dig->afmt || !dig->afmt->pin)
+		return;
+
+	offset = dig->afmt->pin->offset;
+
 	drm_connector_list_iter_begin(dev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
 		if (connector->encoder == encoder) {
@@ -1318,7 +1324,7 @@ static void dce_v6_0_audio_write_sad_regs(struct drm_encoder *encoder)
 		return;
 
 	for (i = 0; i < ARRAY_SIZE(eld_reg_to_type); i++) {
-		u32 tmp = 0;
+		u32 value = 0;
 		u8 stereo_freqs = 0;
 		int max_channels = -1;
 		int j;
@@ -1328,12 +1334,12 @@ static void dce_v6_0_audio_write_sad_regs(struct drm_encoder *encoder)
 
 			if (sad->format == eld_reg_to_type[i][1]) {
 				if (sad->channels > max_channels) {
-					tmp = REG_SET_FIELD(tmp, AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0,
-							MAX_CHANNELS, sad->channels);
-					tmp = REG_SET_FIELD(tmp, AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0,
-							DESCRIPTOR_BYTE_2, sad->byte2);
-					tmp = REG_SET_FIELD(tmp, AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0,
-							SUPPORTED_FREQUENCIES, sad->freq);
+					value = (sad->channels <<
+						AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__MAX_CHANNELS__SHIFT) |
+					       (sad->byte2 <<
+						AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__DESCRIPTOR_BYTE_2__SHIFT) |
+					       (sad->freq <<
+						AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__SUPPORTED_FREQUENCIES__SHIFT);
 					max_channels = sad->channels;
 				}
 
@@ -1344,13 +1350,13 @@ static void dce_v6_0_audio_write_sad_regs(struct drm_encoder *encoder)
 			}
 		}
 
-		tmp = REG_SET_FIELD(tmp, AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0,
-				SUPPORTED_FREQUENCIES_STEREO, stereo_freqs);
-		WREG32_AUDIO_ENDPT(dig->afmt->pin->offset, eld_reg_to_type[i][0], tmp);
+		value |= (stereo_freqs <<
+			AZALIA_F0_CODEC_PIN_CONTROL_AUDIO_DESCRIPTOR0__SUPPORTED_FREQUENCIES_STEREO__SHIFT);
+
+		WREG32_AUDIO_ENDPT(offset, eld_reg_to_type[i][0], value);
 	}
 
 	kfree(sads);
-
 }
 
 static void dce_v6_0_audio_enable(struct amdgpu_device *adev,
@@ -1856,7 +1862,7 @@ static int dce_v6_0_crtc_do_set_base(struct drm_crtc *crtc,
 	struct amdgpu_bo *abo;
 	uint64_t fb_location, tiling_flags;
 	uint32_t fb_format, fb_pitch_pixels, pipe_config;
-	u32 fb_swap = GRPH_ENDIAN_SWAP(GRPH_ENDIAN_NONE);
+	u32 fb_swap = (GRPH_ENDIAN_NONE << GRPH_SWAP_CNTL__GRPH_ENDIAN_SWAP__SHIFT);
 	u32 viewport_w, viewport_h;
 	int r;
 	bool bypass_lut = false;
@@ -1896,76 +1902,76 @@ static int dce_v6_0_crtc_do_set_base(struct drm_crtc *crtc,
 
 	switch (target_fb->format->format) {
 	case DRM_FORMAT_C8:
-		fb_format = (GRPH_DEPTH(GRPH_DEPTH_8BPP) |
-			     GRPH_FORMAT(GRPH_FORMAT_INDEXED));
+		fb_format = ((GRPH_DEPTH_8BPP << GRPH_CONTROL__GRPH_DEPTH__SHIFT) |
+			     (GRPH_FORMAT_INDEXED << GRPH_CONTROL__GRPH_FORMAT__SHIFT));
 		break;
 	case DRM_FORMAT_XRGB4444:
 	case DRM_FORMAT_ARGB4444:
-		fb_format = (GRPH_DEPTH(GRPH_DEPTH_16BPP) |
-			     GRPH_FORMAT(GRPH_FORMAT_ARGB4444));
+		fb_format = ((GRPH_DEPTH_16BPP << GRPH_CONTROL__GRPH_DEPTH__SHIFT) |
+			     (GRPH_FORMAT_ARGB4444 << GRPH_CONTROL__GRPH_FORMAT__SHIFT));
 #ifdef __BIG_ENDIAN
-		fb_swap = GRPH_ENDIAN_SWAP(GRPH_ENDIAN_8IN16);
+		fb_swap = (GRPH_ENDIAN_8IN16 << GRPH_SWAP_CNTL__GRPH_ENDIAN_SWAP__SHIFT);
 #endif
 		break;
 	case DRM_FORMAT_XRGB1555:
 	case DRM_FORMAT_ARGB1555:
-		fb_format = (GRPH_DEPTH(GRPH_DEPTH_16BPP) |
-			     GRPH_FORMAT(GRPH_FORMAT_ARGB1555));
+		fb_format = ((GRPH_DEPTH_16BPP << GRPH_CONTROL__GRPH_DEPTH__SHIFT) |
+			     (GRPH_FORMAT_ARGB1555 << GRPH_CONTROL__GRPH_FORMAT__SHIFT));
 #ifdef __BIG_ENDIAN
-		fb_swap = GRPH_ENDIAN_SWAP(GRPH_ENDIAN_8IN16);
+		fb_swap = (GRPH_ENDIAN_8IN16 << GRPH_SWAP_CNTL__GRPH_ENDIAN_SWAP__SHIFT);
 #endif
 		break;
 	case DRM_FORMAT_BGRX5551:
 	case DRM_FORMAT_BGRA5551:
-		fb_format = (GRPH_DEPTH(GRPH_DEPTH_16BPP) |
-			     GRPH_FORMAT(GRPH_FORMAT_BGRA5551));
+		fb_format = ((GRPH_DEPTH_16BPP << GRPH_CONTROL__GRPH_DEPTH__SHIFT) |
+			     (GRPH_FORMAT_BGRA5551 << GRPH_CONTROL__GRPH_FORMAT__SHIFT));
 #ifdef __BIG_ENDIAN
-		fb_swap = GRPH_ENDIAN_SWAP(GRPH_ENDIAN_8IN16);
+		fb_swap = (GRPH_ENDIAN_8IN16 << GRPH_SWAP_CNTL__GRPH_ENDIAN_SWAP__SHIFT);
 #endif
 		break;
 	case DRM_FORMAT_RGB565:
-		fb_format = (GRPH_DEPTH(GRPH_DEPTH_16BPP) |
-			     GRPH_FORMAT(GRPH_FORMAT_ARGB565));
+		fb_format = ((GRPH_DEPTH_16BPP << GRPH_CONTROL__GRPH_DEPTH__SHIFT) |
+			     (GRPH_FORMAT_ARGB565 << GRPH_CONTROL__GRPH_FORMAT__SHIFT));
 #ifdef __BIG_ENDIAN
-		fb_swap = GRPH_ENDIAN_SWAP(GRPH_ENDIAN_8IN16);
+		fb_swap = (GRPH_ENDIAN_8IN16 << GRPH_SWAP_CNTL__GRPH_ENDIAN_SWAP__SHIFT);
 #endif
 		break;
 	case DRM_FORMAT_XRGB8888:
 	case DRM_FORMAT_ARGB8888:
-		fb_format = (GRPH_DEPTH(GRPH_DEPTH_32BPP) |
-			     GRPH_FORMAT(GRPH_FORMAT_ARGB8888));
+		fb_format = ((GRPH_DEPTH_32BPP << GRPH_CONTROL__GRPH_DEPTH__SHIFT) |
+			     (GRPH_FORMAT_ARGB8888 << GRPH_CONTROL__GRPH_FORMAT__SHIFT));
 #ifdef __BIG_ENDIAN
-		fb_swap = GRPH_ENDIAN_SWAP(GRPH_ENDIAN_8IN32);
+		fb_swap = (GRPH_ENDIAN_8IN32 << GRPH_SWAP_CNTL__GRPH_ENDIAN_SWAP__SHIFT);
 #endif
 		break;
 	case DRM_FORMAT_XRGB2101010:
 	case DRM_FORMAT_ARGB2101010:
-		fb_format = (GRPH_DEPTH(GRPH_DEPTH_32BPP) |
-			     GRPH_FORMAT(GRPH_FORMAT_ARGB2101010));
+		fb_format = ((GRPH_DEPTH_32BPP << GRPH_CONTROL__GRPH_DEPTH__SHIFT) |
+			     (GRPH_FORMAT_ARGB2101010 << GRPH_CONTROL__GRPH_FORMAT__SHIFT));
 #ifdef __BIG_ENDIAN
-		fb_swap = GRPH_ENDIAN_SWAP(GRPH_ENDIAN_8IN32);
+		fb_swap = (GRPH_ENDIAN_8IN32 << GRPH_SWAP_CNTL__GRPH_ENDIAN_SWAP__SHIFT);
 #endif
 		/* Greater 8 bpc fb needs to bypass hw-lut to retain precision */
 		bypass_lut = true;
 		break;
 	case DRM_FORMAT_BGRX1010102:
 	case DRM_FORMAT_BGRA1010102:
-		fb_format = (GRPH_DEPTH(GRPH_DEPTH_32BPP) |
-			     GRPH_FORMAT(GRPH_FORMAT_BGRA1010102));
+		fb_format = ((GRPH_DEPTH_32BPP << GRPH_CONTROL__GRPH_DEPTH__SHIFT) |
+			     (GRPH_FORMAT_BGRA1010102 << GRPH_CONTROL__GRPH_FORMAT__SHIFT));
 #ifdef __BIG_ENDIAN
-		fb_swap = GRPH_ENDIAN_SWAP(GRPH_ENDIAN_8IN32);
+		fb_swap = (GRPH_ENDIAN_8IN32 << GRPH_SWAP_CNTL__GRPH_ENDIAN_SWAP__SHIFT);
 #endif
 		/* Greater 8 bpc fb needs to bypass hw-lut to retain precision */
 		bypass_lut = true;
 		break;
 	case DRM_FORMAT_XBGR8888:
 	case DRM_FORMAT_ABGR8888:
-		fb_format = (GRPH_DEPTH(GRPH_DEPTH_32BPP) |
-			     GRPH_FORMAT(GRPH_FORMAT_ARGB8888));
+		fb_format = ((GRPH_DEPTH_32BPP << GRPH_CONTROL__GRPH_DEPTH__SHIFT) |
+			     (GRPH_FORMAT_ARGB8888 << GRPH_CONTROL__GRPH_FORMAT__SHIFT));
 		fb_swap = (GRPH_RED_CROSSBAR(GRPH_RED_SEL_B) |
 			   GRPH_BLUE_CROSSBAR(GRPH_BLUE_SEL_R));
 #ifdef __BIG_ENDIAN
-		fb_swap |= GRPH_ENDIAN_SWAP(GRPH_ENDIAN_8IN32);
+		fb_swap |= (GRPH_ENDIAN_8IN32 << GRPH_SWAP_CNTL__GRPH_ENDIAN_SWAP__SHIFT);
 #endif
 		break;
 	default:
@@ -1983,18 +1989,18 @@ static int dce_v6_0_crtc_do_set_base(struct drm_crtc *crtc,
 		tile_split = AMDGPU_TILING_GET(tiling_flags, TILE_SPLIT);
 		num_banks = AMDGPU_TILING_GET(tiling_flags, NUM_BANKS);
 
-		fb_format |= GRPH_NUM_BANKS(num_banks);
-		fb_format |= GRPH_ARRAY_MODE(GRPH_ARRAY_2D_TILED_THIN1);
-		fb_format |= GRPH_TILE_SPLIT(tile_split);
-		fb_format |= GRPH_BANK_WIDTH(bankw);
-		fb_format |= GRPH_BANK_HEIGHT(bankh);
-		fb_format |= GRPH_MACRO_TILE_ASPECT(mtaspect);
+		fb_format |= (num_banks << GRPH_CONTROL__GRPH_NUM_BANKS__SHIFT);
+		fb_format |= (GRPH_ARRAY_2D_TILED_THIN1 << GRPH_CONTROL__GRPH_ARRAY_MODE__SHIFT);
+		fb_format |= (tile_split << GRPH_CONTROL__GRPH_TILE_SPLIT__SHIFT);
+		fb_format |= (bankw << GRPH_CONTROL__GRPH_BANK_WIDTH__SHIFT);
+		fb_format |= (bankh << GRPH_CONTROL__GRPH_BANK_HEIGHT__SHIFT);
+		fb_format |= (mtaspect << GRPH_CONTROL__GRPH_MACRO_TILE_ASPECT__SHIFT);
 	} else if (AMDGPU_TILING_GET(tiling_flags, ARRAY_MODE) == ARRAY_1D_TILED_THIN1) {
-		fb_format |= GRPH_ARRAY_MODE(GRPH_ARRAY_1D_TILED_THIN1);
+		fb_format |= (GRPH_ARRAY_1D_TILED_THIN1 << GRPH_CONTROL__GRPH_ARRAY_MODE__SHIFT);
 	}
 
 	pipe_config = AMDGPU_TILING_GET(tiling_flags, PIPE_CONFIG);
-	fb_format |= GRPH_PIPE_CONFIG(pipe_config);
+	fb_format |= (pipe_config << GRPH_CONTROL__GRPH_PIPE_CONFIG__SHIFT);
 
 	dce_v6_0_vga_enable(crtc, false);
 
@@ -2085,7 +2091,6 @@ static void dce_v6_0_set_interleave(struct drm_crtc *crtc,
 
 static void dce_v6_0_crtc_load_lut(struct drm_crtc *crtc)
 {
-
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
 	struct amdgpu_device *adev = drm_to_adev(dev);
@@ -2095,15 +2100,15 @@ static void dce_v6_0_crtc_load_lut(struct drm_crtc *crtc)
 	DRM_DEBUG_KMS("%d\n", amdgpu_crtc->crtc_id);
 
 	WREG32(mmINPUT_CSC_CONTROL + amdgpu_crtc->crtc_offset,
-	       ((0 << INPUT_CSC_CONTROL__INPUT_CSC_GRPH_MODE__SHIFT) |
-		(0 << INPUT_CSC_CONTROL__INPUT_CSC_OVL_MODE__SHIFT)));
+	       ((INPUT_CSC_BYPASS << INPUT_CSC_CONTROL__INPUT_CSC_GRPH_MODE__SHIFT) |
+		(INPUT_CSC_BYPASS << INPUT_CSC_CONTROL__INPUT_CSC_OVL_MODE__SHIFT)));
 	WREG32(mmPRESCALE_GRPH_CONTROL + amdgpu_crtc->crtc_offset,
 	       PRESCALE_GRPH_CONTROL__GRPH_PRESCALE_BYPASS_MASK);
 	WREG32(mmPRESCALE_OVL_CONTROL + amdgpu_crtc->crtc_offset,
 	       PRESCALE_OVL_CONTROL__OVL_PRESCALE_BYPASS_MASK);
 	WREG32(mmINPUT_GAMMA_CONTROL + amdgpu_crtc->crtc_offset,
-	       ((0 << INPUT_GAMMA_CONTROL__GRPH_INPUT_GAMMA_MODE__SHIFT) |
-		(0 << INPUT_GAMMA_CONTROL__OVL_INPUT_GAMMA_MODE__SHIFT)));
+	       ((INPUT_GAMMA_USE_LUT << INPUT_GAMMA_CONTROL__GRPH_INPUT_GAMMA_MODE__SHIFT) |
+		(INPUT_GAMMA_USE_LUT << INPUT_GAMMA_CONTROL__OVL_INPUT_GAMMA_MODE__SHIFT)));
 
 	WREG32(mmDC_LUT_CONTROL + amdgpu_crtc->crtc_offset, 0);
 
@@ -2130,19 +2135,19 @@ static void dce_v6_0_crtc_load_lut(struct drm_crtc *crtc)
 	}
 
 	WREG32(mmDEGAMMA_CONTROL + amdgpu_crtc->crtc_offset,
-	       ((0 << DEGAMMA_CONTROL__GRPH_DEGAMMA_MODE__SHIFT) |
-		(0 << DEGAMMA_CONTROL__OVL_DEGAMMA_MODE__SHIFT) |
-		(0 << DEGAMMA_CONTROL__ICON_DEGAMMA_MODE__SHIFT) |
-		(0 << DEGAMMA_CONTROL__CURSOR_DEGAMMA_MODE__SHIFT)));
+	       ((DEGAMMA_BYPASS << DEGAMMA_CONTROL__GRPH_DEGAMMA_MODE__SHIFT) |
+		(DEGAMMA_BYPASS << DEGAMMA_CONTROL__OVL_DEGAMMA_MODE__SHIFT) |
+		(DEGAMMA_BYPASS << DEGAMMA_CONTROL__ICON_DEGAMMA_MODE__SHIFT) |
+		(DEGAMMA_BYPASS << DEGAMMA_CONTROL__CURSOR_DEGAMMA_MODE__SHIFT)));
 	WREG32(mmGAMUT_REMAP_CONTROL + amdgpu_crtc->crtc_offset,
-	       ((0 << GAMUT_REMAP_CONTROL__GRPH_GAMUT_REMAP_MODE__SHIFT) |
-		(0 << GAMUT_REMAP_CONTROL__OVL_GAMUT_REMAP_MODE__SHIFT)));
+	       ((GAMUT_REMAP_BYPASS << GAMUT_REMAP_CONTROL__GRPH_GAMUT_REMAP_MODE__SHIFT) |
+		(GAMUT_REMAP_BYPASS << GAMUT_REMAP_CONTROL__OVL_GAMUT_REMAP_MODE__SHIFT)));
 	WREG32(mmREGAMMA_CONTROL + amdgpu_crtc->crtc_offset,
-	       ((0 << REGAMMA_CONTROL__GRPH_REGAMMA_MODE__SHIFT) |
-		(0 << REGAMMA_CONTROL__OVL_REGAMMA_MODE__SHIFT)));
+	       ((REGAMMA_BYPASS << REGAMMA_CONTROL__GRPH_REGAMMA_MODE__SHIFT) |
+		(REGAMMA_BYPASS << REGAMMA_CONTROL__OVL_REGAMMA_MODE__SHIFT)));
 	WREG32(mmOUTPUT_CSC_CONTROL + amdgpu_crtc->crtc_offset,
-	       ((0 << OUTPUT_CSC_CONTROL__OUTPUT_CSC_GRPH_MODE__SHIFT) |
-		(0 << OUTPUT_CSC_CONTROL__OUTPUT_CSC_OVL_MODE__SHIFT)));
+	       ((OUTPUT_CSC_BYPASS << OUTPUT_CSC_CONTROL__OUTPUT_CSC_GRPH_MODE__SHIFT) |
+		(OUTPUT_CSC_BYPASS << OUTPUT_CSC_CONTROL__OUTPUT_CSC_OVL_MODE__SHIFT)));
 	/* XXX match this to the depth of the crtc fmt block, move to modeset? */
 	WREG32(0x1a50 + amdgpu_crtc->crtc_offset, 0);
 
@@ -2237,8 +2242,6 @@ static void dce_v6_0_hide_cursor(struct drm_crtc *crtc)
 	WREG32(mmCUR_CONTROL + amdgpu_crtc->crtc_offset,
 	       (CURSOR_24_8_PRE_MULT << CUR_CONTROL__CURSOR_MODE__SHIFT) |
 	       (CURSOR_URGENT_1_2 << CUR_CONTROL__CURSOR_URGENT_CONTROL__SHIFT));
-
-
 }
 
 static void dce_v6_0_show_cursor(struct drm_crtc *crtc)
@@ -2255,7 +2258,6 @@ static void dce_v6_0_show_cursor(struct drm_crtc *crtc)
 	       CUR_CONTROL__CURSOR_EN_MASK |
 	       (CURSOR_24_8_PRE_MULT << CUR_CONTROL__CURSOR_MODE__SHIFT) |
 	       (CURSOR_URGENT_1_2 << CUR_CONTROL__CURSOR_URGENT_CONTROL__SHIFT));
-
 }
 
 static int dce_v6_0_cursor_move_locked(struct drm_crtc *crtc,
@@ -2566,7 +2568,6 @@ static bool dce_v6_0_crtc_mode_fixup(struct drm_crtc *crtc,
 				     const struct drm_display_mode *mode,
 				     struct drm_display_mode *adjusted_mode)
 {
-
 	struct amdgpu_crtc *amdgpu_crtc = to_amdgpu_crtc(crtc);
 	struct drm_device *dev = crtc->dev;
 	struct drm_encoder *encoder;
@@ -2688,7 +2689,6 @@ static int dce_v6_0_early_init(struct amdgpu_ip_block *ip_block)
 static int dce_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 {
 	int r, i;
-	bool ret;
 	struct amdgpu_device *adev = ip_block->adev;
 
 	for (i = 0; i < adev->mode_info.num_crtc; i++) {
@@ -2732,8 +2732,7 @@ static int dce_v6_0_sw_init(struct amdgpu_ip_block *ip_block)
 			return r;
 	}
 
-	ret = amdgpu_atombios_get_connector_info_from_object_table(adev);
-	if (ret)
+	if (amdgpu_atombios_get_connector_info_from_object_table(adev))
 		amdgpu_display_print_display_setup(adev_to_drm(adev));
 	else
 		return -EINVAL;
@@ -3094,7 +3093,7 @@ static int dce_v6_0_pageflip_irq(struct amdgpu_device *adev,
 
 	spin_lock_irqsave(&adev_to_drm(adev)->event_lock, flags);
 	works = amdgpu_crtc->pflip_works;
-	if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED){
+	if (amdgpu_crtc->pflip_status != AMDGPU_FLIP_SUBMITTED) {
 		DRM_DEBUG_DRIVER("amdgpu_crtc->pflip_status = %d != "
 						"AMDGPU_FLIP_SUBMITTED(%d)\n",
 						amdgpu_crtc->pflip_status,
@@ -3171,12 +3170,10 @@ static const struct amd_ip_funcs dce_v6_0_ip_funcs = {
 	.set_powergating_state = dce_v6_0_set_powergating_state,
 };
 
-static void
-dce_v6_0_encoder_mode_set(struct drm_encoder *encoder,
+static void dce_v6_0_encoder_mode_set(struct drm_encoder *encoder,
 			  struct drm_display_mode *mode,
 			  struct drm_display_mode *adjusted_mode)
 {
-
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	int em = amdgpu_atombios_encoder_get_encoder_mode(encoder);
 
@@ -3196,7 +3193,6 @@ dce_v6_0_encoder_mode_set(struct drm_encoder *encoder,
 
 static void dce_v6_0_encoder_prepare(struct drm_encoder *encoder)
 {
-
 	struct amdgpu_device *adev = drm_to_adev(encoder->dev);
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct drm_connector *connector = amdgpu_get_connector_for_encoder(encoder);
@@ -3236,7 +3232,6 @@ static void dce_v6_0_encoder_prepare(struct drm_encoder *encoder)
 
 static void dce_v6_0_encoder_commit(struct drm_encoder *encoder)
 {
-
 	struct drm_device *dev = encoder->dev;
 	struct amdgpu_device *adev = drm_to_adev(dev);
 
@@ -3247,7 +3242,6 @@ static void dce_v6_0_encoder_commit(struct drm_encoder *encoder)
 
 static void dce_v6_0_encoder_disable(struct drm_encoder *encoder)
 {
-
 	struct amdgpu_encoder *amdgpu_encoder = to_amdgpu_encoder(encoder);
 	struct amdgpu_encoder_atom_dig *dig;
 	int em = amdgpu_atombios_encoder_get_encoder_mode(encoder);
diff --git a/drivers/gpu/drm/amd/amdgpu/si_enums.h b/drivers/gpu/drm/amd/amdgpu/si_enums.h
index 7c4dc9c5373e..aee3036be30e 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_enums.h
+++ b/drivers/gpu/drm/amd/amdgpu/si_enums.h
@@ -33,10 +33,6 @@
 #define PRIORITY_OFF                   (1 << 16)
 #define PRIORITY_ALWAYS_ON             (1 << 20)
 
-#define LATENCY_WATERMARK_MASK(x)      ((x) << 16)
-#define DC_LB_MEMORY_CONFIG(x)         ((x) << 20)
-
-#define GRPH_ENDIAN_SWAP(x)            (((x) & 0x3) << 0)
 #define GRPH_ENDIAN_NONE               0
 #define GRPH_ENDIAN_8IN16              1
 #define GRPH_ENDIAN_8IN32              2
@@ -62,12 +58,10 @@
 #define GRPH_ALPHA_SEL_G               2
 #define GRPH_ALPHA_SEL_B               3
 
-#define GRPH_DEPTH(x)                  (((x) & 0x3) << 0)
 #define GRPH_DEPTH_8BPP                0
 #define GRPH_DEPTH_16BPP               1
 #define GRPH_DEPTH_32BPP               2
 
-#define GRPH_FORMAT(x)                 (((x) & 0x7) << 8)
 #define GRPH_FORMAT_INDEXED            0
 #define GRPH_FORMAT_ARGB1555           0
 #define GRPH_FORMAT_ARGB565            1
@@ -84,18 +78,10 @@
 #define GRPH_FORMAT_RGB111110          6
 #define GRPH_FORMAT_BGR101111          7
 
-#define GRPH_NUM_BANKS(x)              (((x) & 0x3) << 2)
-#define GRPH_ARRAY_MODE(x)             (((x) & 0x7) << 20)
 #define GRPH_ARRAY_LINEAR_GENERAL      0
 #define GRPH_ARRAY_LINEAR_ALIGNED      1
 #define GRPH_ARRAY_1D_TILED_THIN1      2
 #define GRPH_ARRAY_2D_TILED_THIN1      4
-#define GRPH_TILE_SPLIT(x)             (((x) & 0x7) << 13)
-#define GRPH_BANK_WIDTH(x)             (((x) & 0x3) << 6)
-#define GRPH_BANK_HEIGHT(x)            (((x) & 0x3) << 11)
-#define GRPH_MACRO_TILE_ASPECT(x)      (((x) & 0x3) << 18)
-#define GRPH_ARRAY_MODE(x)             (((x) & 0x7) << 20)
-#define GRPH_PIPE_CONFIG(x)                   (((x) & 0x1f) << 24)
 
 #define CURSOR_EN                      (1 << 0)
 #define CURSOR_MODE(x)                 (((x) & 0x3) << 8)
diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgpu/sid.h
index 00eb40d4c1a2..8007d4d0d736 100644
--- a/drivers/gpu/drm/amd/amdgpu/sid.h
+++ b/drivers/gpu/drm/amd/amdgpu/sid.h
@@ -772,17 +772,12 @@
 #define		PORT_CONNECTIVITY_MASK				(3 << 30)
 #define		PORT_CONNECTIVITY_SHIFT				30
 
-#define	DC_LB_MEMORY_SPLIT					0x1AC3
-#define		DC_LB_MEMORY_CONFIG(x)				((x) << 20)
-
 #define	PRIORITY_A_CNT						0x1AC6
 #define		PRIORITY_MARK_MASK				0x7fff
 #define		PRIORITY_OFF					(1 << 16)
 #define		PRIORITY_ALWAYS_ON				(1 << 20)
 #define	PRIORITY_B_CNT						0x1AC7
 
-#define	DPG_PIPE_ARBITRATION_CONTROL3				0x1B32
-#       define LATENCY_WATERMARK_MASK(x)			((x) << 16)
 #define	DPG_PIPE_LATENCY_CONTROL				0x1B33
 #       define LATENCY_LOW_WATERMARK(x)				((x) << 0)
 #       define LATENCY_HIGH_WATERMARK(x)			((x) << 16)
@@ -1794,109 +1789,6 @@
 #define FMT_50FRC_SEL(x)              ((x) << 28)
 #define FMT_75FRC_SEL(x)              ((x) << 30)
 
-#define EVERGREEN_DC_LUT_CONTROL                        0x1a80
-#define EVERGREEN_DC_LUT_BLACK_OFFSET_BLUE              0x1a81
-#define EVERGREEN_DC_LUT_BLACK_OFFSET_GREEN             0x1a82
-#define EVERGREEN_DC_LUT_BLACK_OFFSET_RED               0x1a83
-#define EVERGREEN_DC_LUT_WHITE_OFFSET_BLUE              0x1a84
-#define EVERGREEN_DC_LUT_WHITE_OFFSET_GREEN             0x1a85
-#define EVERGREEN_DC_LUT_WHITE_OFFSET_RED               0x1a86
-#define EVERGREEN_DC_LUT_30_COLOR                       0x1a7c
-#define EVERGREEN_DC_LUT_RW_INDEX                       0x1a79
-#define EVERGREEN_DC_LUT_WRITE_EN_MASK                  0x1a7e
-#define EVERGREEN_DC_LUT_RW_MODE                        0x1a78
-
-#define EVERGREEN_GRPH_ENABLE                           0x1a00
-#define EVERGREEN_GRPH_CONTROL                          0x1a01
-#define EVERGREEN_GRPH_DEPTH(x)                  (((x) & 0x3) << 0)
-#define EVERGREEN_GRPH_DEPTH_8BPP                0
-#define EVERGREEN_GRPH_DEPTH_16BPP               1
-#define EVERGREEN_GRPH_DEPTH_32BPP               2
-#define EVERGREEN_GRPH_NUM_BANKS(x)              (((x) & 0x3) << 2)
-#define EVERGREEN_ADDR_SURF_2_BANK               0
-#define EVERGREEN_ADDR_SURF_4_BANK               1
-#define EVERGREEN_ADDR_SURF_8_BANK               2
-#define EVERGREEN_ADDR_SURF_16_BANK              3
-#define EVERGREEN_GRPH_Z(x)                      (((x) & 0x3) << 4)
-#define EVERGREEN_GRPH_BANK_WIDTH(x)             (((x) & 0x3) << 6)
-#define EVERGREEN_ADDR_SURF_BANK_WIDTH_1         0
-#define EVERGREEN_ADDR_SURF_BANK_WIDTH_2         1
-#define EVERGREEN_ADDR_SURF_BANK_WIDTH_4         2
-#define EVERGREEN_ADDR_SURF_BANK_WIDTH_8         3
-#define EVERGREEN_GRPH_FORMAT(x)                 (((x) & 0x7) << 8)
-
-#define EVERGREEN_GRPH_FORMAT_INDEXED            0
-#define EVERGREEN_GRPH_FORMAT_ARGB1555           0
-#define EVERGREEN_GRPH_FORMAT_ARGB565            1
-#define EVERGREEN_GRPH_FORMAT_ARGB4444           2
-#define EVERGREEN_GRPH_FORMAT_AI88               3
-#define EVERGREEN_GRPH_FORMAT_MONO16             4
-#define EVERGREEN_GRPH_FORMAT_BGRA5551           5
-
-/* 32 BPP */
-#define EVERGREEN_GRPH_FORMAT_ARGB8888           0
-#define EVERGREEN_GRPH_FORMAT_ARGB2101010        1
-#define EVERGREEN_GRPH_FORMAT_32BPP_DIG          2
-#define EVERGREEN_GRPH_FORMAT_8B_ARGB2101010     3
-#define EVERGREEN_GRPH_FORMAT_BGRA1010102        4
-#define EVERGREEN_GRPH_FORMAT_8B_BGRA1010102     5
-#define EVERGREEN_GRPH_FORMAT_RGB111110          6
-#define EVERGREEN_GRPH_FORMAT_BGR101111          7
-#define EVERGREEN_GRPH_BANK_HEIGHT(x)            (((x) & 0x3) << 11)
-#define EVERGREEN_ADDR_SURF_BANK_HEIGHT_1        0
-#define EVERGREEN_ADDR_SURF_BANK_HEIGHT_2        1
-#define EVERGREEN_ADDR_SURF_BANK_HEIGHT_4        2
-#define EVERGREEN_ADDR_SURF_BANK_HEIGHT_8        3
-#define EVERGREEN_GRPH_TILE_SPLIT(x)             (((x) & 0x7) << 13)
-#define EVERGREEN_ADDR_SURF_TILE_SPLIT_64B       0
-#define EVERGREEN_ADDR_SURF_TILE_SPLIT_128B      1
-#define EVERGREEN_ADDR_SURF_TILE_SPLIT_256B      2
-#define EVERGREEN_ADDR_SURF_TILE_SPLIT_512B      3
-#define EVERGREEN_ADDR_SURF_TILE_SPLIT_1KB       4
-#define EVERGREEN_ADDR_SURF_TILE_SPLIT_2KB       5
-#define EVERGREEN_ADDR_SURF_TILE_SPLIT_4KB       6
-#define EVERGREEN_GRPH_MACRO_TILE_ASPECT(x)      (((x) & 0x3) << 18)
-#define EVERGREEN_ADDR_SURF_MACRO_TILE_ASPECT_1  0
-#define EVERGREEN_ADDR_SURF_MACRO_TILE_ASPECT_2  1
-#define EVERGREEN_ADDR_SURF_MACRO_TILE_ASPECT_4  2
-#define EVERGREEN_ADDR_SURF_MACRO_TILE_ASPECT_8  3
-#define EVERGREEN_GRPH_ARRAY_MODE(x)             (((x) & 0x7) << 20)
-#define EVERGREEN_GRPH_ARRAY_LINEAR_GENERAL      0
-#define EVERGREEN_GRPH_ARRAY_LINEAR_ALIGNED      1
-#define EVERGREEN_GRPH_ARRAY_1D_TILED_THIN1      2
-#define EVERGREEN_GRPH_ARRAY_2D_TILED_THIN1      4
-#define EVERGREEN_ADDR_SURF_MACRO_TILE_ASPECT_1  0
-#define EVERGREEN_ADDR_SURF_MACRO_TILE_ASPECT_2  1
-#define EVERGREEN_ADDR_SURF_MACRO_TILE_ASPECT_4  2
-#define EVERGREEN_ADDR_SURF_MACRO_TILE_ASPECT_8  3
-
-#define EVERGREEN_GRPH_SWAP_CONTROL                     0x1a03
-#define EVERGREEN_GRPH_ENDIAN_SWAP(x)            (((x) & 0x3) << 0)
-#       define EVERGREEN_GRPH_ENDIAN_NONE               0
-#       define EVERGREEN_GRPH_ENDIAN_8IN16              1
-#       define EVERGREEN_GRPH_ENDIAN_8IN32              2
-#       define EVERGREEN_GRPH_ENDIAN_8IN64              3
-#define EVERGREEN_GRPH_RED_CROSSBAR(x)           (((x) & 0x3) << 4)
-#       define EVERGREEN_GRPH_RED_SEL_R                 0
-#       define EVERGREEN_GRPH_RED_SEL_G                 1
-#       define EVERGREEN_GRPH_RED_SEL_B                 2
-#       define EVERGREEN_GRPH_RED_SEL_A                 3
-#define EVERGREEN_GRPH_GREEN_CROSSBAR(x)         (((x) & 0x3) << 6)
-#       define EVERGREEN_GRPH_GREEN_SEL_G               0
-#       define EVERGREEN_GRPH_GREEN_SEL_B               1
-#       define EVERGREEN_GRPH_GREEN_SEL_A               2
-#       define EVERGREEN_GRPH_GREEN_SEL_R               3
-#define EVERGREEN_GRPH_BLUE_CROSSBAR(x)          (((x) & 0x3) << 8)
-#       define EVERGREEN_GRPH_BLUE_SEL_B                0
-#       define EVERGREEN_GRPH_BLUE_SEL_A                1
-#       define EVERGREEN_GRPH_BLUE_SEL_R                2
-#       define EVERGREEN_GRPH_BLUE_SEL_G                3
-#define EVERGREEN_GRPH_ALPHA_CROSSBAR(x)         (((x) & 0x3) << 10)
-#       define EVERGREEN_GRPH_ALPHA_SEL_A               0
-#       define EVERGREEN_GRPH_ALPHA_SEL_R               1
-#       define EVERGREEN_GRPH_ALPHA_SEL_G               2
-#       define EVERGREEN_GRPH_ALPHA_SEL_B               3
-
 #define EVERGREEN_D3VGA_CONTROL                         0xf8
 #define EVERGREEN_D4VGA_CONTROL                         0xf9
 #define EVERGREEN_D5VGA_CONTROL                         0xfa
@@ -1956,65 +1848,6 @@
 #       define EVERGREEN_CURSOR_UPDATE_LOCK             (1 << 16)
 #       define EVERGREEN_CURSOR_DISABLE_MULTIPLE_UPDATE (1 << 24)
 
-
-#define NI_INPUT_CSC_CONTROL                           0x1a35
-#       define NI_INPUT_CSC_GRPH_MODE(x)               (((x) & 0x3) << 0)
-#       define NI_INPUT_CSC_BYPASS                     0
-#       define NI_INPUT_CSC_PROG_COEFF                 1
-#       define NI_INPUT_CSC_PROG_SHARED_MATRIXA        2
-#       define NI_INPUT_CSC_OVL_MODE(x)                (((x) & 0x3) << 4)
-
-#define NI_OUTPUT_CSC_CONTROL                          0x1a3c
-#       define NI_OUTPUT_CSC_GRPH_MODE(x)              (((x) & 0x7) << 0)
-#       define NI_OUTPUT_CSC_BYPASS                    0
-#       define NI_OUTPUT_CSC_TV_RGB                    1
-#       define NI_OUTPUT_CSC_YCBCR_601                 2
-#       define NI_OUTPUT_CSC_YCBCR_709                 3
-#       define NI_OUTPUT_CSC_PROG_COEFF                4
-#       define NI_OUTPUT_CSC_PROG_SHARED_MATRIXB       5
-#       define NI_OUTPUT_CSC_OVL_MODE(x)               (((x) & 0x7) << 4)
-
-#define NI_DEGAMMA_CONTROL                             0x1a58
-#       define NI_GRPH_DEGAMMA_MODE(x)                 (((x) & 0x3) << 0)
-#       define NI_DEGAMMA_BYPASS                       0
-#       define NI_DEGAMMA_SRGB_24                      1
-#       define NI_DEGAMMA_XVYCC_222                    2
-#       define NI_OVL_DEGAMMA_MODE(x)                  (((x) & 0x3) << 4)
-#       define NI_ICON_DEGAMMA_MODE(x)                 (((x) & 0x3) << 8)
-#       define NI_CURSOR_DEGAMMA_MODE(x)               (((x) & 0x3) << 12)
-
-#define NI_GAMUT_REMAP_CONTROL                         0x1a59
-#       define NI_GRPH_GAMUT_REMAP_MODE(x)             (((x) & 0x3) << 0)
-#       define NI_GAMUT_REMAP_BYPASS                   0
-#       define NI_GAMUT_REMAP_PROG_COEFF               1
-#       define NI_GAMUT_REMAP_PROG_SHARED_MATRIXA      2
-#       define NI_GAMUT_REMAP_PROG_SHARED_MATRIXB      3
-#       define NI_OVL_GAMUT_REMAP_MODE(x)              (((x) & 0x3) << 4)
-
-#define NI_REGAMMA_CONTROL                             0x1aa0
-#       define NI_GRPH_REGAMMA_MODE(x)                 (((x) & 0x7) << 0)
-#       define NI_REGAMMA_BYPASS                       0
-#       define NI_REGAMMA_SRGB_24                      1
-#       define NI_REGAMMA_XVYCC_222                    2
-#       define NI_REGAMMA_PROG_A                       3
-#       define NI_REGAMMA_PROG_B                       4
-#       define NI_OVL_REGAMMA_MODE(x)                  (((x) & 0x7) << 4)
-
-
-#define NI_PRESCALE_GRPH_CONTROL                       0x1a2d
-#       define NI_GRPH_PRESCALE_BYPASS                 (1 << 4)
-
-#define NI_PRESCALE_OVL_CONTROL                        0x1a31
-#       define NI_OVL_PRESCALE_BYPASS                  (1 << 4)
-
-#define NI_INPUT_GAMMA_CONTROL                         0x1a10
-#       define NI_GRPH_INPUT_GAMMA_MODE(x)             (((x) & 0x3) << 0)
-#       define NI_INPUT_GAMMA_USE_LUT                  0
-#       define NI_INPUT_GAMMA_BYPASS                   1
-#       define NI_INPUT_GAMMA_SRGB_24                  2
-#       define NI_INPUT_GAMMA_XVYCC_222                3
-#       define NI_OVL_INPUT_GAMMA_MODE(x)              (((x) & 0x3) << 4)
-
 #define	BLACKOUT_MODE_MASK			0x00000007
 #define	VGA_RENDER_CONTROL			0xC0
 #define R_000300_VGA_RENDER_CONTROL             0xC0
@@ -2076,6 +1909,114 @@
 
 #define mmSRBM_SOFT_RESET__xxSOFT_RESET_VMC_MASK 0x20000
 #define mmSRBM_SOFT_RESET__xxSOFT_RESET_VMC__SHIFT 0x11
+#define GRPH_DEPTH_8BPP                0
+#define GRPH_DEPTH_16BPP               1
+#define GRPH_DEPTH_32BPP               2
+
+/* 8 BPP */
+#define GRPH_FORMAT_INDEXED            0
+
+/* 16 BPP */
+#define GRPH_FORMAT_ARGB1555           0
+#define GRPH_FORMAT_ARGB565            1
+#define GRPH_FORMAT_ARGB4444           2
+#define GRPH_FORMAT_AI88               3
+#define GRPH_FORMAT_MONO16             4
+#define GRPH_FORMAT_BGRA5551           5
+
+// /* 32 BPP */
+#define GRPH_FORMAT_ARGB8888           0
+#define GRPH_FORMAT_ARGB2101010        1
+#define GRPH_FORMAT_32BPP_DIG          2
+#define GRPH_FORMAT_8B_ARGB2101010     3
+#define GRPH_FORMAT_BGRA1010102        4
+#define GRPH_FORMAT_8B_BGRA1010102     5
+#define GRPH_FORMAT_RGB111110          6
+#define GRPH_FORMAT_BGR101111          7
+
+#define ES_AND_GS_AUTO       3
+#define BUF_SWAP_32BIT       (2 << 16)
+
+
+#define GRPH_RED_CROSSBAR(x)           (((x) & 0x3) << 4)
+#define GRPH_RED_SEL_R                 0
+#define GRPH_RED_SEL_G                 1
+#define GRPH_RED_SEL_B                 2
+#define GRPH_RED_SEL_A                 3
+
+#define GRPH_GREEN_CROSSBAR(x)         (((x) & 0x3) << 6)
+#define GRPH_GREEN_SEL_G               0
+#define GRPH_GREEN_SEL_B               1
+#define GRPH_GREEN_SEL_A               2
+#define GRPH_GREEN_SEL_R               3
+
+#define GRPH_BLUE_CROSSBAR(x)          (((x) & 0x3) << 8)
+#define GRPH_BLUE_SEL_B                0
+#define GRPH_BLUE_SEL_A                1
+#define GRPH_BLUE_SEL_R                2
+#define GRPH_BLUE_SEL_G                3
+
+#define GRPH_ALPHA_CROSSBAR(x)         (((x) & 0x3) << 10)
+#define GRPH_ALPHA_SEL_A               0
+#define GRPH_ALPHA_SEL_R               1
+#define GRPH_ALPHA_SEL_G               2
+#define GRPH_ALPHA_SEL_B               3
+
+// #define CUR_CONTROL                           0x1a66
+	// #define CURSOR_EN                      (1 << 0)
+	// #define CURSOR_MODE(x)                 (((x) & 0x3) << 8)
+	#define CURSOR_MONO                    0
+	#define CURSOR_24_1                    1
+	#define CURSOR_24_8_PRE_MULT           2
+	#define CURSOR_24_8_UNPRE_MULT         3
+	#define CURSOR_2X_MAGNIFY              (1 << 16)
+	#define CURSOR_FORCE_MC_ON             (1 << 20)
+	#define CURSOR_URGENT_CONTROL(x)       (((x) & 0x7) << 24)
+	#define CURSOR_URGENT_ALWAYS           0
+	#define CURSOR_URGENT_1_8              1
+	#define CURSOR_URGENT_1_4              2
+	#define CURSOR_URGENT_3_8              3
+	#define CURSOR_URGENT_1_2              4
+
+// #define INPUT_CSC_CONTROL                           0x1a35
+#       define INPUT_CSC_BYPASS                     0
+#       define INPUT_CSC_PROG_COEFF                 1
+#       define INPUT_CSC_PROG_SHARED_MATRIXA        2
+
+// #define OUTPUT_CSC_CONTROL                          0x1a3c
+#       define OUTPUT_CSC_BYPASS                    0
+#       define OUTPUT_CSC_TV_RGB                    1
+#       define OUTPUT_CSC_YCBCR_601                 2
+#       define OUTPUT_CSC_YCBCR_709                 3
+#       define OUTPUT_CSC_PROG_COEFF                4
+#       define OUTPUT_CSC_PROG_SHARED_MATRIXB       5
+
+// #	define ICON_DEGAMMA_MODE(x)           (((x) & 0x3) << 8)
+
+// #define DEGAMMA_CONTROL                             0x1a58
+#       define DEGAMMA_BYPASS                       0
+#       define DEGAMMA_SRGB_24                      1
+#       define DEGAMMA_XVYCC_222                    2
+
+// #define GAMUT_REMAP_CONTROL                         0x1a59
+#       define GAMUT_REMAP_BYPASS                   0
+#       define GAMUT_REMAP_PROG_COEFF               1
+#       define GAMUT_REMAP_PROG_SHARED_MATRIXA      2
+#       define GAMUT_REMAP_PROG_SHARED_MATRIXB      3
+
+// #define REGAMMA_CONTROL                             0x1aa0
+#       define REGAMMA_BYPASS                       0
+#       define REGAMMA_SRGB_24                      1
+#       define REGAMMA_XVYCC_222                    2
+#       define REGAMMA_PROG_A                       3
+#       define REGAMMA_PROG_B                       4
+
+
+// #define INPUT_GAMMA_CONTROL                         0x1a10
+#       define INPUT_GAMMA_USE_LUT                  0
+#       define INPUT_GAMMA_BYPASS                   1
+#       define INPUT_GAMMA_SRGB_24                  2
+#       define INPUT_GAMMA_XVYCC_222                3
 #define mmSRBM_SOFT_RESET__xxSOFT_RESET_MC_MASK 0x800
 #define mmSRBM_SOFT_RESET__xxSOFT_RESET_MC__SHIFT 0xb
 
-- 
2.48.1


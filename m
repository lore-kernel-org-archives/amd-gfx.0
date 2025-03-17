Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E20C35FF8
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 06:07:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C2C810E344;
	Mon, 17 Mar 2025 06:07:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="c8C9lkKD";
	dkim-atps=neutral
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com
 [209.85.160.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 172C110E332
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 06:07:38 +0000 (UTC)
Received: by mail-qt1-f181.google.com with SMTP id
 d75a77b69052e-476775df2f0so48521141cf.1
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Mar 2025 23:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742191657; x=1742796457; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Z4EwwmYXoROmhu+pcVys60/rK6gwOcKv4lidiGWBQz8=;
 b=c8C9lkKDJkyao1jLctTWpDvrndJ0LdUYHcpS4LFSCAl0y0rxrc9SALbZRYmfRXr9UV
 lRfkOUKZTJOWbS9ZRbduR/DB7XbBgou5jtpYkLwX4xTJVHgWgwzBeIfQ5bLnQmFIF/3D
 L8TMF991Br3FD69eeOK/IjopWHJ/zXZsUhfRLI5GpqrvRlsnfvIGKmYXK8NZ2dJ83LLm
 yRoj6N8/T4wpdHKhOp+kR4X/kZTVISYliuxiGTDHJ/8t1iDOe8vzafOnO3qLXRIYaiIM
 007GyBqwB3PY/vBOloU0iIiQeb9Tki9svMsLXJQSNjEQDyKd0rAIl8chv5RohudI6xFu
 CuOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742191657; x=1742796457;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Z4EwwmYXoROmhu+pcVys60/rK6gwOcKv4lidiGWBQz8=;
 b=wNZvMIoP2p5qvXqdPL1/jVMmAmnvH2zpIbG8yMl1G9IcdBh9uZCwnY97vKWOB1EHB8
 2mLOxWt4ONSY4zufvAuSGbA1ikllnBgHrfpcJvcnU9mim/8Z+Hg8G6GTThItamZw0t46
 uClsD3xSjsRl9Qj4vEEBHyVeunIll5CUN97wI02vL92/zGjjy1UCENyuWLYwrHl/je7P
 MVsoCtraYNJeCCFhaaBbCuCWZO4tAWFzqq48vSlDs5KyB54zxdAec2IWFVJaaFT8aspT
 f7wuOfPQaIAEhXmVoGHdbZv4iA903AL8Mu8l58rHHECEg1t+Yr6r+ufIMhqAUwuca97r
 y0Ng==
X-Gm-Message-State: AOJu0YxJJW9dzoqc5WbRCsy0nPAbjjJZhrqw6K8rOCAAuxDiq9fF2oFn
 nCXtRg8LsrRJtDuj629IVIBn0RhSNGHK1CrfktP2Es3LNmc6P4sG3omfCg==
X-Gm-Gg: ASbGncs79j0Nmynmv3SPiqSFUhJjy+ASS/fVYLqIFlnsyjw0P3zLnLvXS0K9mzLlfnc
 doJIflalloQ0cmYSFACKNYYN7oU/1rdo6dhVBf1ZCe1cU4Jydqc+wDceumRG8iYznwzIC9Pm7E+
 x6/Sso+NzxYOsLKmrU4nLKhwlsqJjxlRRwfeLwk20dxCBIMhCEEH3ctTZVUkCexl968mfgwnXVp
 CGJFD54PSY9RErdRTTwrMHxG1cFeIyOCGtbyAFQMF/jV/katVT0YxnVrK+CkmQw2BjdLBzX6moT
 SQHtcFmvL3uvUNWywmn35chsq/JDr6Z3Q+OF+LoWahCUfbtZCWfyg6PGcG5LtFDxcE0=
X-Google-Smtp-Source: AGHT+IEfk+Ur0+6+pf2zKVqUT0/QzaUY/zL0V17j9Hyl3waVSg9WBbK25FcGwWCbMyK/14MDrDf2Gw==
X-Received: by 2002:a05:622a:1116:b0:471:b544:e6fc with SMTP id
 d75a77b69052e-476c9369b5cmr150554831cf.26.1742191657018; 
 Sun, 16 Mar 2025 23:07:37 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb7f4f08sm50605931cf.56.2025.03.16.23.07.36
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 23:07:36 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 18/18] drm/amdgpu: continue cleaning up sid.h and si_enums.h
Date: Mon, 17 Mar 2025 02:07:02 -0400
Message-ID: <20250317060702.5297-19-alexandre.f.demers@gmail.com>
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

Remove more duplicated defines and move some in sid.h for coherence with
CIK.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/si_enums.h | 90 +--------------------------
 drivers/gpu/drm/amd/amdgpu/sid.h      | 16 ++++-
 2 files changed, 14 insertions(+), 92 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_enums.h b/drivers/gpu/drm/amd/amdgpu/si_enums.h
index aee3036be30e..6da65778292b 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_enums.h
+++ b/drivers/gpu/drm/amd/amdgpu/si_enums.h
@@ -23,96 +23,15 @@
 #ifndef SI_ENUMS_H
 #define SI_ENUMS_H
 
-#define VBLANK_ACK                     (1 << 4)
-#define VLINE_ACK                      (1 << 4)
-
-#define CURSOR_WIDTH 64
-#define CURSOR_HEIGHT 64
-
 #define PRIORITY_MARK_MASK             0x7fff
 #define PRIORITY_OFF                   (1 << 16)
 #define PRIORITY_ALWAYS_ON             (1 << 20)
 
-#define GRPH_ENDIAN_NONE               0
-#define GRPH_ENDIAN_8IN16              1
-#define GRPH_ENDIAN_8IN32              2
-#define GRPH_ENDIAN_8IN64              3
-#define GRPH_RED_CROSSBAR(x)           (((x) & 0x3) << 4)
-#define GRPH_RED_SEL_R                 0
-#define GRPH_RED_SEL_G                 1
-#define GRPH_RED_SEL_B                 2
-#define GRPH_RED_SEL_A                 3
-#define GRPH_GREEN_CROSSBAR(x)         (((x) & 0x3) << 6)
-#define GRPH_GREEN_SEL_G               0
-#define GRPH_GREEN_SEL_B               1
-#define GRPH_GREEN_SEL_A               2
-#define GRPH_GREEN_SEL_R               3
-#define GRPH_BLUE_CROSSBAR(x)          (((x) & 0x3) << 8)
-#define GRPH_BLUE_SEL_B                0
-#define GRPH_BLUE_SEL_A                1
-#define GRPH_BLUE_SEL_R                2
-#define GRPH_BLUE_SEL_G                3
-#define GRPH_ALPHA_CROSSBAR(x)         (((x) & 0x3) << 10)
-#define GRPH_ALPHA_SEL_A               0
-#define GRPH_ALPHA_SEL_R               1
-#define GRPH_ALPHA_SEL_G               2
-#define GRPH_ALPHA_SEL_B               3
-
-#define GRPH_DEPTH_8BPP                0
-#define GRPH_DEPTH_16BPP               1
-#define GRPH_DEPTH_32BPP               2
-
-#define GRPH_FORMAT_INDEXED            0
-#define GRPH_FORMAT_ARGB1555           0
-#define GRPH_FORMAT_ARGB565            1
-#define GRPH_FORMAT_ARGB4444           2
-#define GRPH_FORMAT_AI88               3
-#define GRPH_FORMAT_MONO16             4
-#define GRPH_FORMAT_BGRA5551           5
-#define GRPH_FORMAT_ARGB8888           0
-#define GRPH_FORMAT_ARGB2101010        1
-#define GRPH_FORMAT_32BPP_DIG          2
-#define GRPH_FORMAT_8B_ARGB2101010     3
-#define GRPH_FORMAT_BGRA1010102        4
-#define GRPH_FORMAT_8B_BGRA1010102     5
-#define GRPH_FORMAT_RGB111110          6
-#define GRPH_FORMAT_BGR101111          7
-
-#define GRPH_ARRAY_LINEAR_GENERAL      0
-#define GRPH_ARRAY_LINEAR_ALIGNED      1
-#define GRPH_ARRAY_1D_TILED_THIN1      2
-#define GRPH_ARRAY_2D_TILED_THIN1      4
-
-#define CURSOR_EN                      (1 << 0)
-#define CURSOR_MODE(x)                 (((x) & 0x3) << 8)
-#define CURSOR_MONO                    0
-#define CURSOR_24_1                    1
-#define CURSOR_24_8_PRE_MULT           2
-#define CURSOR_24_8_UNPRE_MULT         3
-#define CURSOR_2X_MAGNIFY              (1 << 16)
-#define CURSOR_FORCE_MC_ON             (1 << 20)
-#define CURSOR_URGENT_CONTROL(x)       (((x) & 0x7) << 24)
-#define CURSOR_URGENT_ALWAYS           0
-#define CURSOR_URGENT_1_8              1
-#define CURSOR_URGENT_1_4              2
-#define CURSOR_URGENT_3_8              3
-#define CURSOR_URGENT_1_2              4
-#define CURSOR_UPDATE_PENDING          (1 << 0)
-#define CURSOR_UPDATE_TAKEN            (1 << 1)
-#define CURSOR_UPDATE_LOCK             (1 << 16)
-#define CURSOR_DISABLE_MULTIPLE_UPDATE (1 << 24)
-
-
-#define ES_AND_GS_AUTO       3
-#define RADEON_PACKET_TYPE3  3
-#define CE_PARTITION_BASE    3
-#define BUF_SWAP_32BIT       (2 << 16)
-
 #define GFX_POWER_STATUS                           (1 << 1)
 #define GFX_CLOCK_STATUS                           (1 << 2)
 #define GFX_LS_STATUS                              (1 << 3)
-#define RLC_BUSY_STATUS                            (1 << 0)
 
+#define RLC_BUSY_STATUS                            (1 << 0)
 #define RLC_PUD(x)                               ((x) << 0)
 #define RLC_PUD_MASK                             (0xff << 0)
 #define RLC_PDD(x)                               ((x) << 8)
@@ -121,13 +40,6 @@
 #define RLC_TTPD_MASK                            (0xff << 16)
 #define RLC_MSD(x)                               ((x) << 24)
 #define RLC_MSD_MASK                             (0xff << 24)
-#define WRITE_DATA_ENGINE_SEL(x) ((x) << 30)
-#define WRITE_DATA_DST_SEL(x) ((x) << 8)
-#define EVENT_TYPE(x) ((x) << 0)
-#define EVENT_INDEX(x) ((x) << 8)
-#define WAIT_REG_MEM_MEM_SPACE(x)               ((x) << 4)
-#define WAIT_REG_MEM_FUNCTION(x)                ((x) << 0)
-#define WAIT_REG_MEM_ENGINE(x)                  ((x) << 8)
 
 #define RLC_SAVE_AND_RESTORE_STARTING_OFFSET 0x90
 #define RLC_CLEAR_STATE_DESCRIPTOR_OFFSET    0x3D
diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgpu/sid.h
index 6c6bf2154ce8..494c8ca74e6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/sid.h
+++ b/drivers/gpu/drm/amd/amdgpu/sid.h
@@ -586,6 +586,7 @@
 #define	DMA_PACKET_POLL_REG_MEM				  0xe
 #define	DMA_PACKET_NOP					  0xf
 
+/* VCE */
 #define VCE_STATUS					0x20004
 #define VCE_VCPU_CNTL					0x20014
 #define		VCE_CLK_EN				(1 << 0)
@@ -705,9 +706,10 @@
 #define GRPH_FORMAT_RGB111110          6
 #define GRPH_FORMAT_BGR101111          7
 
-#define ES_AND_GS_AUTO       3
-#define BUF_SWAP_32BIT       (2 << 16)
-
+#define GRPH_ENDIAN_NONE               0
+#define GRPH_ENDIAN_8IN16              1
+#define GRPH_ENDIAN_8IN32              2
+#define GRPH_ENDIAN_8IN64              3
 #define GRPH_RED_SEL_R                 0
 #define GRPH_RED_SEL_G                 1
 #define GRPH_RED_SEL_B                 2
@@ -725,6 +727,14 @@
 #define GRPH_ALPHA_SEL_G               2
 #define GRPH_ALPHA_SEL_B               3
 
+#define GRPH_ARRAY_LINEAR_GENERAL      0
+#define GRPH_ARRAY_LINEAR_ALIGNED      1
+#define GRPH_ARRAY_1D_TILED_THIN1      2
+#define GRPH_ARRAY_2D_TILED_THIN1      4
+
+#define ES_AND_GS_AUTO       3
+#define BUF_SWAP_32BIT       (2 << 16)
+
 /* CUR blocks at 0x6998, 0x7598, 0x10198, 0x10d98, 0x11998, 0x12598 */
 
 // #define CUR_CONTROL                           0x1a66
-- 
2.48.1


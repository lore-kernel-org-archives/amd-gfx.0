Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 291DFC021BE
	for <amd-gfx@archiver.kernel.org>; Thu, 27 Feb 2025 05:23:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2238510EA31;
	Thu, 27 Feb 2025 05:23:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Bhaf62zQ";
	dkim-atps=neutral
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1E1110EA31
 for <amd-gfx@lists.freedesktop.org>; Thu, 27 Feb 2025 05:22:59 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-7be8f28172dso51938085a.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Feb 2025 21:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740633778; x=1741238578; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=30j1wt+iEzxRQHVP4jVLL77cr1U4h/jLENqy/Umazd8=;
 b=Bhaf62zQ+N+nXp/U0PTAo8858PKeGga/+YSHZGmV1CxR1x+d50/R75BTNwipo8VoMN
 YBAGt1Ne8u3ul7y99wcNG1mB3ayEBDW20bFejQsBNfnCqdcFJB1tXw81OzUflJa+DZHW
 hW4mbW196iB1FUFXoDp02ylww4Z2/gZNLCe43MTxP3zzXDj9I5VM6qYRNKPvmVNa16P/
 KC8hESkVWvFB8B6y1g6yeqsKOXBMZB+hexP9ps1btaCmyslLgnHTpnjuW8J4K3qGWP1l
 qr/665nXcMZDCampRb0MwbMRxMJ/Msvh8Ofnzk9j3BS7zpOphBRfT5SmuEW+AHch6eLB
 qzaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740633778; x=1741238578;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=30j1wt+iEzxRQHVP4jVLL77cr1U4h/jLENqy/Umazd8=;
 b=AZryoBRjDxySzfxDzEIVVUoRIn17HnBUEOlsBZEU9ODAl5pV2gKBg7KwXHBa0s11Me
 sgnqRbAm5EVL0OYj2dESM2os0ldpYfbHahOHPfR3VzdwEp9ZIkzpDv2/wrRZ+A8IvPqI
 niqO3DCaQVxTdJ2gmbRH5EzOMN01IfQFezzOii+B/bxCNvqOClO/GX6FZKgyoiNaJIhL
 iuql2o+fCbiKcbV0v4aeNySqttc7qZeH38wtZ8dm/KLh4IffJV8exTW+DbD6f0Cr/rF8
 d1dEBv9J2M/r4g90HbeZXPZ0KawoLKmbbVo0iJTCmMeo8S9beYpZ919OEE4ld53KCuco
 Pnug==
X-Gm-Message-State: AOJu0YzrQhpM1vPWqh6g7p21/arzQduR8MxtwAzEfcHj3OgBdWSpL3m4
 e/t6fDZbSaW/BnWk5mOnzWtLMgPKuFqn+qdQHJAVhHiX9kQLmqPRX8oKvg==
X-Gm-Gg: ASbGncscGXnjAIzWL9daVuej3xJlfOzxvWN7GwtVl6rcvCGcTZ6Y1mYxabUQrsoiSIt
 7gTN7Q/tYE7Ca/2d1rb7sSFhDJBquqD7MZs2BulZdqs4zkUvXWIWX47chMCPleH7Kz3YihGa33g
 gCuO9WclNAHk8qNMh4grANouGtQ5kMFw5D0c6WRMu3+N4cv52GUQHcs0dfQ18GdIQROsLsGV0w8
 hv3+ls24Q+zTfoltq7islQQodLuBf6+BWGe1jzBLl73QUHHhzpVNWYXHTbFzqvlhEJerIT1S5AU
 CIpzh4srWo5YbhPGfH6be/ZaounfEoY4RjZoLuMZRVlnDD/9
X-Google-Smtp-Source: AGHT+IHFFAIejrWSDoEViHMO5kMugk73rCwIHNsi9igIiAe0bPTrkGxnC1u66spNib32a7HnE89u5g==
X-Received: by 2002:a05:620a:2454:b0:7c0:71bc:dbc0 with SMTP id
 af79cd13be357-7c247f261a2mr794536285a.24.1740633778014; 
 Wed, 26 Feb 2025 21:22:58 -0800 (PST)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c378dab64asm65670085a.100.2025.02.26.21.22.57
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 21:22:57 -0800 (PST)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 1/6] drm/amdgpu: add or move defines for DCE6 in sid.h
Date: Thu, 27 Feb 2025 00:22:36 -0500
Message-ID: <20250227052241.171102-2-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227052241.171102-1-alexandre.f.demers@gmail.com>
References: <20250227052241.171102-1-alexandre.f.demers@gmail.com>
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

For coherence with DCE8 et DCE10, add or move some values under sid.h.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 63 ++++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/si_enums.h |  7 ---
 drivers/gpu/drm/amd/amdgpu/sid.h      | 29 +++++++++---
 3 files changed, 55 insertions(+), 44 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index eb7de9122d99..bd763fde1c50 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -32,6 +32,7 @@
 #include "amdgpu.h"
 #include "amdgpu_pm.h"
 #include "amdgpu_i2c.h"
+#include "sid.h"
 #include "atom.h"
 #include "amdgpu_atombios.h"
 #include "atombios_crtc.h"
@@ -59,31 +60,31 @@ static void dce_v6_0_set_irq_funcs(struct amdgpu_device *adev);
 
 static const u32 crtc_offsets[6] =
 {
-	SI_CRTC0_REGISTER_OFFSET,
-	SI_CRTC1_REGISTER_OFFSET,
-	SI_CRTC2_REGISTER_OFFSET,
-	SI_CRTC3_REGISTER_OFFSET,
-	SI_CRTC4_REGISTER_OFFSET,
-	SI_CRTC5_REGISTER_OFFSET
+	CRTC0_REGISTER_OFFSET,
+	CRTC1_REGISTER_OFFSET,
+	CRTC2_REGISTER_OFFSET,
+	CRTC3_REGISTER_OFFSET,
+	CRTC4_REGISTER_OFFSET,
+	CRTC5_REGISTER_OFFSET
 };
 
 static const u32 hpd_offsets[] =
 {
-	mmDC_HPD1_INT_STATUS - mmDC_HPD1_INT_STATUS,
-	mmDC_HPD2_INT_STATUS - mmDC_HPD1_INT_STATUS,
-	mmDC_HPD3_INT_STATUS - mmDC_HPD1_INT_STATUS,
-	mmDC_HPD4_INT_STATUS - mmDC_HPD1_INT_STATUS,
-	mmDC_HPD5_INT_STATUS - mmDC_HPD1_INT_STATUS,
-	mmDC_HPD6_INT_STATUS - mmDC_HPD1_INT_STATUS,
+	HPD0_REGISTER_OFFSET,
+	HPD1_REGISTER_OFFSET,
+	HPD2_REGISTER_OFFSET,
+	HPD3_REGISTER_OFFSET,
+	HPD4_REGISTER_OFFSET,
+	HPD5_REGISTER_OFFSET
 };
 
 static const uint32_t dig_offsets[] = {
-	SI_CRTC0_REGISTER_OFFSET,
-	SI_CRTC1_REGISTER_OFFSET,
-	SI_CRTC2_REGISTER_OFFSET,
-	SI_CRTC3_REGISTER_OFFSET,
-	SI_CRTC4_REGISTER_OFFSET,
-	SI_CRTC5_REGISTER_OFFSET,
+	CRTC0_REGISTER_OFFSET,
+	CRTC1_REGISTER_OFFSET,
+	CRTC2_REGISTER_OFFSET,
+	CRTC3_REGISTER_OFFSET,
+	CRTC4_REGISTER_OFFSET,
+	CRTC5_REGISTER_OFFSET,
 	(0x13830 - 0x7030) >> 2,
 };
 
@@ -1347,13 +1348,13 @@ static void dce_v6_0_audio_enable(struct amdgpu_device *adev,
 
 static const u32 pin_offsets[7] =
 {
-	(0x1780 - 0x1780),
-	(0x1786 - 0x1780),
-	(0x178c - 0x1780),
-	(0x1792 - 0x1780),
-	(0x1798 - 0x1780),
-	(0x179d - 0x1780),
-	(0x17a4 - 0x1780),
+	AUD0_REGISTER_OFFSET,
+	AUD1_REGISTER_OFFSET,
+	AUD2_REGISTER_OFFSET,
+	AUD3_REGISTER_OFFSET,
+	AUD4_REGISTER_OFFSET,
+	AUD5_REGISTER_OFFSET,
+	AUD6_REGISTER_OFFSET,
 };
 
 static int dce_v6_0_audio_init(struct amdgpu_device *adev)
@@ -2862,22 +2863,22 @@ static void dce_v6_0_set_crtc_vblank_interrupt_state(struct amdgpu_device *adev,
 
 	switch (crtc) {
 	case 0:
-		reg_block = SI_CRTC0_REGISTER_OFFSET;
+		reg_block = CRTC0_REGISTER_OFFSET;
 		break;
 	case 1:
-		reg_block = SI_CRTC1_REGISTER_OFFSET;
+		reg_block = CRTC1_REGISTER_OFFSET;
 		break;
 	case 2:
-		reg_block = SI_CRTC2_REGISTER_OFFSET;
+		reg_block = CRTC2_REGISTER_OFFSET;
 		break;
 	case 3:
-		reg_block = SI_CRTC3_REGISTER_OFFSET;
+		reg_block = CRTC3_REGISTER_OFFSET;
 		break;
 	case 4:
-		reg_block = SI_CRTC4_REGISTER_OFFSET;
+		reg_block = CRTC4_REGISTER_OFFSET;
 		break;
 	case 5:
-		reg_block = SI_CRTC5_REGISTER_OFFSET;
+		reg_block = CRTC5_REGISTER_OFFSET;
 		break;
 	default:
 		DRM_DEBUG("invalid crtc %d\n", crtc);
diff --git a/drivers/gpu/drm/amd/amdgpu/si_enums.h b/drivers/gpu/drm/amd/amdgpu/si_enums.h
index 4e935baa7b91..cdf8eebaa392 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_enums.h
+++ b/drivers/gpu/drm/amd/amdgpu/si_enums.h
@@ -121,13 +121,6 @@
 #define CURSOR_UPDATE_LOCK             (1 << 16)
 #define CURSOR_DISABLE_MULTIPLE_UPDATE (1 << 24)
 
-#define SI_CRTC0_REGISTER_OFFSET                0
-#define SI_CRTC1_REGISTER_OFFSET                0x300
-#define SI_CRTC2_REGISTER_OFFSET                0x2600
-#define SI_CRTC3_REGISTER_OFFSET                0x2900
-#define SI_CRTC4_REGISTER_OFFSET                0x2c00
-#define SI_CRTC5_REGISTER_OFFSET                0x2f00
-
 #define DMA0_REGISTER_OFFSET 0x000
 #define DMA1_REGISTER_OFFSET 0x200
 #define ES_AND_GS_AUTO       3
diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgpu/sid.h
index 9a39cbfe6db9..32a4e7d450c6 100644
--- a/drivers/gpu/drm/amd/amdgpu/sid.h
+++ b/drivers/gpu/drm/amd/amdgpu/sid.h
@@ -1991,12 +1991,29 @@
 
 //#dce stupp
 /* display controller offsets used for crtc/cur/lut/grph/viewport/etc. */
-#define SI_CRTC0_REGISTER_OFFSET                0 //(0x6df0 - 0x6df0)/4
-#define SI_CRTC1_REGISTER_OFFSET                0x300 //(0x79f0 - 0x6df0)/4
-#define SI_CRTC2_REGISTER_OFFSET                0x2600 //(0x105f0 - 0x6df0)/4
-#define SI_CRTC3_REGISTER_OFFSET                0x2900 //(0x111f0 - 0x6df0)/4
-#define SI_CRTC4_REGISTER_OFFSET                0x2c00 //(0x11df0 - 0x6df0)/4
-#define SI_CRTC5_REGISTER_OFFSET                0x2f00 //(0x129f0 - 0x6df0)/4
+#define CRTC0_REGISTER_OFFSET                 (0x1b7c - 0x1b7c) //(0x6df0 - 0x6df0)/4
+#define CRTC1_REGISTER_OFFSET                 (0x1e7c - 0x1b7c) //(0x79f0 - 0x6df0)/4
+#define CRTC2_REGISTER_OFFSET                 (0x417c - 0x1b7c) //(0x105f0 - 0x6df0)/4
+#define CRTC3_REGISTER_OFFSET                 (0x447c - 0x1b7c) //(0x111f0 - 0x6df0)/4
+#define CRTC4_REGISTER_OFFSET                 (0x477c - 0x1b7c) //(0x11df0 - 0x6df0)/4
+#define CRTC5_REGISTER_OFFSET                 (0x4a7c - 0x1b7c) //(0x129f0 - 0x6df0)/4
+
+/* hpd instance offsets */
+#define HPD0_REGISTER_OFFSET                 (0x1807 - 0x1807)
+#define HPD1_REGISTER_OFFSET                 (0x180a - 0x1807)
+#define HPD2_REGISTER_OFFSET                 (0x180d - 0x1807)
+#define HPD3_REGISTER_OFFSET                 (0x1810 - 0x1807)
+#define HPD4_REGISTER_OFFSET                 (0x1813 - 0x1807)
+#define HPD5_REGISTER_OFFSET                 (0x1816 - 0x1807)
+
+/* audio endpt instance offsets */
+#define AUD0_REGISTER_OFFSET                 (0x1780 - 0x1780)
+#define AUD1_REGISTER_OFFSET                 (0x1786 - 0x1780)
+#define AUD2_REGISTER_OFFSET                 (0x178c - 0x1780)
+#define AUD3_REGISTER_OFFSET                 (0x1792 - 0x1780)
+#define AUD4_REGISTER_OFFSET                 (0x1798 - 0x1780)
+#define AUD5_REGISTER_OFFSET                 (0x179d - 0x1780)
+#define AUD6_REGISTER_OFFSET                 (0x17a4 - 0x1780)
 
 #define CURSOR_WIDTH 64
 #define CURSOR_HEIGHT 64
-- 
2.48.1


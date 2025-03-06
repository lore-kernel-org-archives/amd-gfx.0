Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB08EC28B22
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Mar 2025 01:50:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C0EA10E8A5;
	Thu,  6 Mar 2025 01:50:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L1BpQdMd";
	dkim-atps=neutral
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09BE210E8A5
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Mar 2025 01:50:23 +0000 (UTC)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-6dd1962a75bso1333376d6.3
 for <amd-gfx@lists.freedesktop.org>; Wed, 05 Mar 2025 17:50:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741225822; x=1741830622; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=ht79AU62ND06NCUSjJ96h9PQ5v06nBsdde20Ff10jyI=;
 b=L1BpQdMd/48gixCHWzv859gz81I28LbvC/ZLevLeDyEcjj/TK/qpfEu32EPHcc/iSz
 MxOM3EJFu7VupJ5Cg7lBvUCv3F7x8Uh/EjjOcYBgPsJAowQLuRfcSaBo+GBSxU7vurgY
 UQSj39H5vF4znDnPo5iG0eDxLJYugZ9TC3gAh3czfPtfO0v1xBpb1lFYfyy7UiZU4t+9
 SE/5XgUCysyoSVE6eVTCMGmkCJVn8/1PeScWqpzWzKPRu7ZHSx0diKn4agSbI6a521mY
 FBOljrsjsXL6ca5sPkxoPUGUgCn/xzZSfZIAFotIGE3jSI+GvfghEiuT+ab7QeMXTaQ1
 k3Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741225822; x=1741830622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ht79AU62ND06NCUSjJ96h9PQ5v06nBsdde20Ff10jyI=;
 b=iJXvuT/vRjsL1/HNTNMA1Y2iLSWwGjSd1vFWotGjsW0H54vMUN4QROOSQUFUokZ9VH
 GgRFoC+jGg2puRwzO/4G9ZjfI613WyHGcRapS7ZjHwGZY4M6JW7s7x0LVW3ULJWehYOP
 /3FgZFVCKENfxAl+SqJa3ZP5y5evQmfCbPhBTxJMYUtVRPlj7PEIzxKOpUXHXnY4xI0p
 NxFxj7vz/2jEazSSWbz9aGX0bG2imd2I/IEJ2ViSwdSkYMsAJLvmexRfJHJEFgnPjDqB
 72hNmb+PbWPXZXz/Lw6/e38/41h5e5A4etWZML2DDq/3djgbx/8s0PFzQBlM7Df641RB
 f3zg==
X-Gm-Message-State: AOJu0Yw4x1RBAL0h8iU1c+ljACJz3Q+2wJMuLz+nOliPafjJwvwIUcZU
 aPFFMdT46u+flOKigzax6jURVtAEVkQyZ+CbqYcw3cdwccJrACyqkITWcA==
X-Gm-Gg: ASbGncuArbOdvkUKmoozmsAypGJG9KvGbk8F8R1nBkIAX0UWlGi3JnkkzGS3N6+gnFi
 JNBnu9BUn25TsRNQZUsJoAbfwlIfyV9Doj9deLaM6BRzBLtO0GFph8i29ChyJ2vghYPszW9qKOq
 gmeC7qOfL0JEKhkcdUUQ/upeBgmJvm6wY0Tn7BwYns2PhT6qWd8t/bhcf1V30TxCGYTbROi2vmi
 T1wpN/T0hIeAli3uVJzjt7JkunkXbx4pXehfWRol0jjuWXRuTfwE7stdD5HGFglfHJHxupNE0iR
 jBqKDVW19IPQWO5Q15omXmspwLPDw53aN24ThY6i8hjZRhfsWkgxORzNGquR6ze5qPw=
X-Google-Smtp-Source: AGHT+IHHkb5a9prQKDiaaxZjlH2ueBfRlds3G5md3tAOnZ7WrSAt7b4/FZ915EME/stBuZqacZVUEQ==
X-Received: by 2002:a05:6214:e66:b0:6e6:617c:abb6 with SMTP id
 6a1803df08f44-6e8e6cffef0mr68373026d6.6.1741225821870; 
 Wed, 05 Mar 2025 17:50:21 -0800 (PST)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6e8f715b65csm1489786d6.76.2025.03.05.17.50.21
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Mar 2025 17:50:21 -0800 (PST)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v3 1/4] drm/amdgpu: add or move defines for DCE6 in sid.h
Date: Wed,  5 Mar 2025 20:49:55 -0500
Message-ID: <20250306014958.785021-2-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250306014958.785021-1-alexandre.f.demers@gmail.com>
References: <20250306014958.785021-1-alexandre.f.demers@gmail.com>
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
index a72fd7220081..185401d66961 100644
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
 
@@ -1359,13 +1360,13 @@ static void dce_v6_0_audio_enable(struct amdgpu_device *adev,
 
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
@@ -2876,22 +2877,22 @@ static void dce_v6_0_set_crtc_vblank_interrupt_state(struct amdgpu_device *adev,
 
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


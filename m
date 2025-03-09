Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8609C28B2F
	for <amd-gfx@archiver.kernel.org>; Sun,  9 Mar 2025 16:49:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6534710E1CD;
	Sun,  9 Mar 2025 16:49:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="O4517fS3";
	dkim-atps=neutral
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com
 [209.85.222.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F4F210E1CD
 for <amd-gfx@lists.freedesktop.org>; Sun,  9 Mar 2025 16:49:15 +0000 (UTC)
Received: by mail-qk1-f178.google.com with SMTP id
 af79cd13be357-7c07cd527e4so328531185a.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 09 Mar 2025 09:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741538952; x=1742143752; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=gMaJ6ChlHnQorEfuqNypCmnZA4OXiWvzZWPlW4f8qsw=;
 b=O4517fS3HSXc3iDXjSXFkxo5aQ9M1T21V/IUjprJ7cMN/MPA9TFRjRynR2fccLcVI2
 7KDioPFuzKG/Vkhra5U6A6XYIbypKqN9QjfnnSrqATmHvSB/8aFsM0LCtMjjJHTKLK0U
 HkW1aJhgllIFnCwtRfRMvFQBlJk56Uth1jgB/fc/TVcZy3Ad0vraon/oh+ZyxBnLjgHO
 G7Sx2l9+2+/x70LFAsRvRBPQGhkJPg3f2MiIf8FuWEtHElHMl5ZxbZHJTsxfD82inYt1
 mlTnm8RaG2Pf+L9WEIPtsuS05qzCWOyoUGvOfhJX1S0egf+cf22rONNq2dyKoZHWm38g
 aDcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741538952; x=1742143752;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=gMaJ6ChlHnQorEfuqNypCmnZA4OXiWvzZWPlW4f8qsw=;
 b=UqqAhXhOUutrXNQ0CdICGW68GovyxDhJkcD8mhqEPd+dE5GDQiCND+acYQ38xui2d4
 d+BPWnyZXgAvxp/Y2bVbstqaA0vgrvtN9mASwTXEFAcc8LUmZ2zDyKGwnWvkscb4okqq
 j+eafD4rtwQSzWa8KOJ8fWQkZIOMIDPpxUNpIWF9628PwvRkoa9vPbHag4WPU3Pb3H2v
 vgP5RHy48nmC1Pw5/1/uHyL+kPfv+gmsWpuIWwMzmnkWWmpMiC9jn4zES+BrSgMbi6K4
 lHN5LhamG7hzp/K0+XfElMLiBK5hZae7jwN+NKkVogEv9FoUPnHAm8ySkfbjzqqku4WE
 jIhw==
X-Gm-Message-State: AOJu0Yzk15cjF7wOejZomBZMOtD2+QJPmczLSTdt9Us4UVS6ohSI3/w1
 /6eav3EQZ4ubRgjXhQKNAcHRuYowBC3JyS5thwxAcJDz+QzMcwDbdfabUA==
X-Gm-Gg: ASbGncvtCcK/9EUd7OWkiqUPs5IvNCBYKQ29IGboYKq0LE3eNgRP4A7owk00v/+5++X
 VbngVBVDHjm6udZVUORms2n3O6RDr/MEnkf3nBDtaTB/0ulH/rsQj/F6BGvi7+XYBE/oKg8YaTt
 odztV/6bFqX6IQqhl84w1XBtYgbiwXOQWfBOKgsmvPpbr/vv6tR54+/akroF9nsaGc+xY9eoZo8
 qPNzqnQjEHvbE9FjuoFiidIPKg3S9yGQp4BCnlAJMw2UEaICUucqGwAxBrIyOoVBxGzrGHW2lSd
 lZeh/3aFSxKOoZafIoypxD9wSmoNkLDl0NyvHFqS/lL9G09jb9ikSF6vMy9zwsD0W0g=
X-Google-Smtp-Source: AGHT+IFvk7tVz8o2Y4mAEcowIpc9iyS5WTgsxKHRwhn0pH+4/y51yDXQdJwd9RZ3boChU1hewdf0vQ==
X-Received: by 2002:a05:620a:2625:b0:7c3:cd78:df38 with SMTP id
 af79cd13be357-7c4e1679bd7mr1340052285a.10.1741538952041; 
 Sun, 09 Mar 2025 09:49:12 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7c53e2ff59bsm236996385a.1.2025.03.09.09.49.11
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 09 Mar 2025 09:49:11 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH v4 3/3] drm/amdgpu: finish wiring up sid.h in DCE6
Date: Sun,  9 Mar 2025 12:48:52 -0400
Message-ID: <20250309164852.3936628-4-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250309164852.3936628-1-alexandre.f.demers@gmail.com>
References: <20250309164852.3936628-1-alexandre.f.demers@gmail.com>
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

For coherence with DCE8 et DCE10, add or move some values under sid.h
and remove duplicated from si_enums.h.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c | 63 ++++++++++++++-------------
 drivers/gpu/drm/amd/amdgpu/si_enums.h |  6 ---
 drivers/gpu/drm/amd/amdgpu/sid.h      | 29 +++++++++---
 3 files changed, 55 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 47b0e4848a56..e1b0779e835f 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -41,6 +41,7 @@
 #include "amdgpu_display.h"
 
 #include "dce_v6_0.h"
+#include "sid.h"
 
 #include "bif/bif_3_0_d.h"
 #include "bif/bif_3_0_sh_mask.h"
@@ -65,31 +66,31 @@ static void dce_v6_0_set_irq_funcs(struct amdgpu_device *adev);
 
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
 
@@ -1365,13 +1366,13 @@ static void dce_v6_0_audio_enable(struct amdgpu_device *adev,
 
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
@@ -2882,22 +2883,22 @@ static void dce_v6_0_set_crtc_vblank_interrupt_state(struct amdgpu_device *adev,
 
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
index cd9b0a654991..d656ef1fa6e1 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_enums.h
+++ b/drivers/gpu/drm/amd/amdgpu/si_enums.h
@@ -121,12 +121,6 @@
 #define CURSOR_UPDATE_LOCK             (1 << 16)
 #define CURSOR_DISABLE_MULTIPLE_UPDATE (1 << 24)
 
-#define SI_CRTC0_REGISTER_OFFSET                0
-#define SI_CRTC1_REGISTER_OFFSET                0x300
-#define SI_CRTC2_REGISTER_OFFSET                0x2600
-#define SI_CRTC3_REGISTER_OFFSET                0x2900
-#define SI_CRTC4_REGISTER_OFFSET                0x2c00
-#define SI_CRTC5_REGISTER_OFFSET                0x2f00
 
 #define ES_AND_GS_AUTO       3
 #define RADEON_PACKET_TYPE3  3
diff --git a/drivers/gpu/drm/amd/amdgpu/sid.h b/drivers/gpu/drm/amd/amdgpu/sid.h
index bf228a1dedff..cbf232f5235b 100644
--- a/drivers/gpu/drm/amd/amdgpu/sid.h
+++ b/drivers/gpu/drm/amd/amdgpu/sid.h
@@ -1700,12 +1700,29 @@
 
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


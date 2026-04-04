Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57388E6401C
	for <amd-gfx@archiver.kernel.org>; Sun,  5 Apr 2026 12:10:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2A9A10E226;
	Sun,  5 Apr 2026 12:09:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=usp.br header.i=@usp.br header.b="Ud3T62Pv";
	dkim-atps=neutral
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com
 [209.85.221.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1AA1910E2C4
 for <amd-gfx@lists.freedesktop.org>; Sat,  4 Apr 2026 06:40:21 +0000 (UTC)
Received: by mail-vk1-f179.google.com with SMTP id
 71dfb90a1353d-56a86f0a23bso2437392e0c.0
 for <amd-gfx@lists.freedesktop.org>; Fri, 03 Apr 2026 23:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=usp.br; s=usp-google; t=1775284820; x=1775889620; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NM+YgMZ3VPSp8HAw6BysCZ3QXJispP0X2NnMfKbHGEw=;
 b=Ud3T62Pvx7Jp92tXbcLRxU1Mr/dmUGN78hMcfUytV6udlU/6bhgbuS9jtiF89mzTDU
 xk7EFyzc/MOnjmvivev1YrC6snpgVRcePuEYfkMs4Pc+MMYIE4rRmVNBTqRzpbbpnNWd
 t7uDnbgbtMixh6A5S4KrO+Ykf6ukRGJ857PbVit/6oNK0fVlmq4dEuqHVWLmL15acaHQ
 el6pDEJTiXzRs72Hwn8Qho0eT1RsFA2W2gxZo7lV4i3Muz2lvbWG0Cy1gZCDhaRCu2oT
 A35Bdf0OinJXnnQTfaommZA50YjuR9F/8sEdzEZg7CYkgbOw+RLSqu0b+k6nTpA1yhhu
 aU+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775284820; x=1775889620;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NM+YgMZ3VPSp8HAw6BysCZ3QXJispP0X2NnMfKbHGEw=;
 b=EPufajIZ0KJAHytwTL8SM1O6zLBxTW3N1ajhA+W6s+U8T7JS24U4imv11IQoMShlo8
 43VtT3mitSBJtF751itGeIMNAnOF2Ds+2FVLEp3FGYxRsg3TfplmV7X/iq/kEt0tDtmU
 mn4LooxIe//xSMc903NAmQc73ckxijulIx2iQsj+U4+dcgNy6Z09pEriZwTGiQ17eEti
 SmJEXkPcGJa0iRhCcGQzHLOMc5RKQBmzC/H/7YcXHDNAWviGoPJW/KwAEUuTD7IYhbVU
 Z7lpzVk/NXWQIpoRsIw1Q1pTtpL0/dFYRFPTbkm1SbYM3DoDymdAHS9beRxWGtyQbrIT
 z2wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXHDMiL6jc2q3UqL7U7A16xTmFRz+YNdpvsJtQzkWmuvP4q4nhw60o/uMu0TzWmjtJX+MYYQh8S@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMauUKhlIJFta2vgi+2AuG8+oWsdz9BWtdLPrUE4twnMDQm/9A
 moxTwEa/kBi2dDbmGxnhW23ogRsHI77sD+E3PKM55UJSfetgCZsz7iQSf07IJr5xWaI=
X-Gm-Gg: AeBDiettXeWugQ4J1crNCcK+RnLbHyvuoPjPpnVktoQgAVogIy1cZuiuhTYQPd4SNf2
 Quo9v3i+gVg2jXh5FnUi5XeJq3JekVhZJMygkp+JQgSs8p2SaZk5D7G9uF3dHvfin5oMaUAD8cz
 W6OWW+U/o0ukHIVcEjcvqsw3AhQAD1S4INz9v5NP7FbWR/CtUpWXHhrZz/nBiA39B95XqOsS4O7
 nt2iWRCntUfw1IQAQ77ivCeHotRdix29Xrb9qRgXSCtgc8z8PV7WGPdMG24dNALCIa8j7egdiD2
 EqN2rxYtXp44Rzmqgf/50iWSmx4zt2nGtGB3gjc7c41O3vFWUk4FIzr6iOzU7MuqvHpUlDA6uEC
 p4vR4dLFS0l3sYIP9MxcDiHJzB4/Hleu6EyANvhXEqDCrIdXkei4BO4aLHLcuWCWh9rOjEuwgAa
 sEVDPvqd/36qJ6QBnknturojhZcSAlP/QKZlvtjYPI05xdx3/5C+iC+zkjjr+GY6aj9dZVL4ITx
 Fj99HzB/jpVtz23YvPBcqORJaym2oN1QQmkSIo5bFkR2PcO8g==
X-Received: by 2002:a05:6122:7c8:b0:567:433b:e903 with SMTP id
 71dfb90a1353d-56dab87fccbmr2066447e0c.6.1775284820640; 
 Fri, 03 Apr 2026 23:40:20 -0700 (PDT)
Received: from gui-host.Dlink ([177.33.104.190])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-56d9bd2106csm8843708e0c.18.2026.04.03.23.40.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2026 23:40:20 -0700 (PDT)
From: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com
Cc: airlied@gmail.com, simona@ffwll.ch, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, guilherme.bozi@usp.br
Subject: [PATCH] drm/amdgpu: use named SRCID for JPEG decode in VCN 1.0
Date: Sat,  4 Apr 2026 03:40:03 -0300
Message-ID: <20260404064003.94877-1-guilherme.bozi@usp.br>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 05 Apr 2026 12:09:57 +0000
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

Replace the hard-coded value 126 with the constant
VCN_1_0__SRCID__JPEG_DECODE in jpeg_v1_0.c.

This improves code readability and maintainability by centralizing
the SRCID definitions in ivsrcid/vcn/irqsrcs_vcn_1_0.h.

Also fixes potential confusion when handling JPEG decode interrupts
in the VCN 1.0 hardware block.

Signed-off-by: Guilherme Ivo Bozi <guilherme.bozi@usp.br>
---
 drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c                    | 6 ++++--
 drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_1_0.h | 1 +
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
index b5bb7f4d607c..52a329773467 100644
--- a/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/jpeg_v1_0.c
@@ -31,6 +31,7 @@
 
 #include "vcn/vcn_1_0_offset.h"
 #include "vcn/vcn_1_0_sh_mask.h"
+#include "ivsrcid/vcn/irqsrcs_vcn_1_0.h"
 
 static void jpeg_v1_0_set_dec_ring_funcs(struct amdgpu_device *adev);
 static void jpeg_v1_0_set_irq_funcs(struct amdgpu_device *adev);
@@ -443,7 +444,7 @@ static int jpeg_v1_0_process_interrupt(struct amdgpu_device *adev,
 	DRM_DEBUG("IH: JPEG decode TRAP\n");
 
 	switch (entry->src_id) {
-	case 126:
+	case VCN_1_0__SRCID__JPEG_DECODE:
 		amdgpu_fence_process(adev->jpeg.inst->ring_dec);
 		break;
 	default:
@@ -488,7 +489,8 @@ int jpeg_v1_0_sw_init(struct amdgpu_ip_block *ip_block)
 	int r;
 
 	/* JPEG TRAP */
-	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN, 126, &adev->jpeg.inst->irq);
+	r = amdgpu_irq_add_id(adev, SOC15_IH_CLIENTID_VCN,
+		VCN_1_0__SRCID__JPEG_DECODE, &adev->jpeg.inst->irq);
 	if (r)
 		return r;
 
diff --git a/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_1_0.h b/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_1_0.h
index e5951709bfc3..d97883a88b0e 100644
--- a/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_1_0.h
+++ b/drivers/gpu/drm/amd/include/ivsrcid/vcn/irqsrcs_vcn_1_0.h
@@ -29,6 +29,7 @@
 #define VCN_1_0__SRCID__UVD_ENC_GENERAL_PURPOSE                 119     /* 0x77 Encoder General Purpose  */
 #define VCN_1_0__SRCID__UVD_ENC_LOW_LATENCY                     120     /* 0x78 Encoder Low Latency  */
 #define VCN_1_0__SRCID__UVD_SYSTEM_MESSAGE_INTERRUPT	        124		/* 0x7c UVD system message interrupt  */
+#define VCN_1_0__SRCID__JPEG_DECODE                             126     /* 0x7e JRBC Decode interrupt */
 
 #endif /* __IRQSRCS_VCN_1_0_H__ */
 
-- 
2.47.3


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE83ECCFA18
	for <amd-gfx@archiver.kernel.org>; Thu,  6 Nov 2025 18:46:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6200710E9B0;
	Thu,  6 Nov 2025 18:46:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RzST7Ace";
	dkim-atps=neutral
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com
 [209.85.221.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2208E10E9BE
 for <amd-gfx@lists.freedesktop.org>; Thu,  6 Nov 2025 18:46:01 +0000 (UTC)
Received: by mail-vk1-f171.google.com with SMTP id
 71dfb90a1353d-55986ed1e50so781826e0c.0
 for <amd-gfx@lists.freedesktop.org>; Thu, 06 Nov 2025 10:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762454760; x=1763059560; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eaUoSvbQ+S0Ze7Vr2DjCAWHpxxEAiii++0noNpXlx4U=;
 b=RzST7AceNyAkKmtZKtruEWFPiXO344abo83GBCeHlu8ju5sKs9SblrFioaCagN41WM
 MUEjKnB6NluAJt3vOFr7OjjW9D5+za3D7UgK8o2Pwp5lXPC9LTgi1oHHMeT/M+d1pHAU
 5IhwGvDP/193vn+VxGMFM8Ij18a2tJNEYeJReLQg11J0KaFDGgU6ITyD65LCGFijY9/A
 dYOpQIEoq9H1+4RQqrYjiR4H7OzrTlLS9hJ3yy3wJzUad9geVsfltskMTW4fbu9Waj46
 fK+t44nCH91i4RnlSGmAgo2Inbio/ZBRaLmR8d3wQVaG8xIgOvo4gbNQo5xODEb69WZx
 sSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762454760; x=1763059560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eaUoSvbQ+S0Ze7Vr2DjCAWHpxxEAiii++0noNpXlx4U=;
 b=PJjQn8IZpLHJxBEm40Sco7PZ5vKn7ziDp8NqgL9X1ApKAqGpIbPsEhhknMwS23qYgD
 pU6M2JT3mltNyhePQvKTK+17+Jxt8/taVcSxF/Qriu4Lw+9ZoKzNwu3YbuTAQzbHGaxJ
 KFo2hKNhk79ELO9TXnGTGq4PVYm4XvFDRAyMliawqcmdnckgb5PtdnemVAyOPcfbSiX+
 IJks/BjN3XJft+3qOI1qXPT61DEgae+M1Gso79Os0RBIJBT65DT/U44UjsTulkDUxoib
 VkDvlNzUzXD7KX/GpviHpWVcZGj836ouZOGP6jn2FfPzAR6xcap+kZQSpRfLdIFDLR1a
 +r8A==
X-Gm-Message-State: AOJu0Yzu+0F6xbiXAxg+A1j0s//jdhRujN+1qZI87kDTuzqT1latIQay
 RUs8xTNGozD4/bvjmPbyRdcxqvtuaJQsiYS0t5TdwaDi8JvtxXqkHvP4/RyeFKVS
X-Gm-Gg: ASbGncvA94qgfydQ419AK+giDqx17deoQ+G+paO9wQIwG6Ip7qy9AfsJX8OXmvVm1Y+
 mlNSGVYkLDnb5tOvZBM2ILFMSFvT+qvT2ejf/nH7nMoMjDmkNOW+aConW5Tm9Y95K6dxx3X1cKa
 th2s75tfkFkDr8FALVLnSDilYWRkgNiTy+lYYfI1dV145hSb4aEg6Y0OaivbvD+d1K7S+8o+jbT
 nvWwPxtWmgFn/cd1g4mUzTaDKGgjSRsP72l8cwiR7d32nUPYrOpM1r8miVQeRSDXr7bDrd8QejB
 uhwPJ+bNgI75FG8+haVlNHNFmGHkO3LDmRTCQ+XDa4Ua0kDdrocAJ1xEZMIneEJ+phqZTXOySse
 3kzJ0PIzFZPMyTGw/EsiPMU5tQ6OSWjd4f5mCs1Zf2n9asVt/vPxTqtdj0rAZOahb/isyXYD797
 Rj7Y5ias9jDqht9A+qJks=
X-Google-Smtp-Source: AGHT+IEkYo121azGGi2rDDoqQYgiPQBXCFDhQWiqFly+pqltqRMoueOQ2RHBWfE2YCEVM5HVoQL3yw==
X-Received: by 2002:a05:6122:6593:b0:559:75a4:e88f with SMTP id
 71dfb90a1353d-559a3ca6508mr265903e0c.14.1762454760116; 
 Thu, 06 Nov 2025 10:46:00 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-559957fb3c1sm1810004e0c.12.2025.11.06.10.45.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Nov 2025 10:45:59 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 12/13] drm/amdgpu/vce1: Enable VCE1 on Tahiti, Pitcairn,
 Cape Verde GPUs
Date: Thu,  6 Nov 2025 19:44:47 +0100
Message-ID: <20251106184448.8099-13-timur.kristof@gmail.com>
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

Add the VCE1 IP block to the SI GPUs that have it.
Advertise the encoder capabilities corresponding to VCE1,
so the userspace applications can detect and use it.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/si.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index e0f139de7991..9d769222784c 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -45,6 +45,7 @@
 #include "dce_v6_0.h"
 #include "si.h"
 #include "uvd_v3_1.h"
+#include "vce_v1_0.h"
 
 #include "uvd/uvd_4_0_d.h"
 
@@ -921,8 +922,6 @@ static const u32 hainan_mgcg_cgcg_init[] =
 	0x3630, 0xfffffff0, 0x00000100,
 };
 
-/* XXX: update when we support VCE */
-#if 0
 /* tahiti, pitcairn, verde */
 static const struct amdgpu_video_codec_info tahiti_video_codecs_encode_array[] =
 {
@@ -940,13 +939,7 @@ static const struct amdgpu_video_codecs tahiti_video_codecs_encode =
 	.codec_count = ARRAY_SIZE(tahiti_video_codecs_encode_array),
 	.codec_array = tahiti_video_codecs_encode_array,
 };
-#else
-static const struct amdgpu_video_codecs tahiti_video_codecs_encode =
-{
-	.codec_count = 0,
-	.codec_array = NULL,
-};
-#endif
+
 /* oland and hainan don't support encode */
 static const struct amdgpu_video_codecs hainan_video_codecs_encode =
 {
@@ -2717,7 +2710,7 @@ int si_set_ip_blocks(struct amdgpu_device *adev)
 		else
 			amdgpu_device_ip_block_add(adev, &dce_v6_0_ip_block);
 		amdgpu_device_ip_block_add(adev, &uvd_v3_1_ip_block);
-		/* amdgpu_device_ip_block_add(adev, &vce_v1_0_ip_block); */
+		amdgpu_device_ip_block_add(adev, &vce_v1_0_ip_block);
 		break;
 	case CHIP_OLAND:
 		amdgpu_device_ip_block_add(adev, &si_common_ip_block);
@@ -2735,7 +2728,6 @@ int si_set_ip_blocks(struct amdgpu_device *adev)
 		else
 			amdgpu_device_ip_block_add(adev, &dce_v6_4_ip_block);
 		amdgpu_device_ip_block_add(adev, &uvd_v3_1_ip_block);
-		/* amdgpu_device_ip_block_add(adev, &vce_v1_0_ip_block); */
 		break;
 	case CHIP_HAINAN:
 		amdgpu_device_ip_block_add(adev, &si_common_ip_block);
-- 
2.51.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FA37CCFA18
	for <amd-gfx@archiver.kernel.org>; Fri,  7 Nov 2025 15:58:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE03F10EB0C;
	Fri,  7 Nov 2025 15:58:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i/JoYYAr";
	dkim-atps=neutral
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2A2D10E0DD
 for <amd-gfx@lists.freedesktop.org>; Fri,  7 Nov 2025 15:58:04 +0000 (UTC)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47112a73785so6086755e9.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 07 Nov 2025 07:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1762531083; x=1763135883; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=eaUoSvbQ+S0Ze7Vr2DjCAWHpxxEAiii++0noNpXlx4U=;
 b=i/JoYYArDB8TazDFTtHltkDd7P2DI2jn8ozibCAtpSG+H+Yo52u64bfpy29jup5RSo
 JZDGb370qM9O0V/BDrPif1fYX/hfiRKQQIXnsXFuWNgdvcmgBIeSqJl/2WFb6XgV979r
 nCGdQ0Cl6gyeT/RD93IDyyZn9J/4rIqirVborU53vaDOwR4vpSXbNLjQ+cOwSRUV4UXa
 WdkdZkkt6vElJxzmLpNWKH9qfqmiuOGmnxW/L34qWQOPbeH/ANS5d7z1zmd4G8Ge5qpM
 aVH3jvagJR2b1S3gjxzyhfk1EAtW29tqGes1KxKaalirHFCSs6ib/1CrDA+xAa9bap75
 jD2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762531083; x=1763135883;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eaUoSvbQ+S0Ze7Vr2DjCAWHpxxEAiii++0noNpXlx4U=;
 b=cOgzpbB7rSnLXzj//f2ZguiiegZl8Q0GRFlD1LXYZ2rd0aV9yFlWKO1dw0qn7a4tC8
 I7KiylSl40h99d2hgZaHE95Whe1YP8IAUeeklGesVWve128cYc8rCOPfMcOB4K7VJFkd
 Gw+oVy14EhnZTt2ej6w9IC2oY7vfE5RChtLCrnfoTh+iYLORJAMpFov31/cSfiV0WQbg
 qb90Q9vx2W1QxwCq7/5pyc31dCULfskK+gDtbakX7UuZest1uAfK/cUmwYqE1lO4XZHA
 BPNgPBQFD2oz+dUTXlkyycePYPnscmaYHMIgwTHqQ3RX1lghaHDSFVDZxLzGTmfIhvJ9
 AFQA==
X-Gm-Message-State: AOJu0YygFs/zUpH1AL+IDkJfn/8YRsU5rgypDGirC5sN0KcT9nA5L1ru
 GXBQxGE0Yerkg0bx43seHuS4436TAwYbUzTuWmz3qUgoZaBixLjnPdHavHbbAQ==
X-Gm-Gg: ASbGncv2ofY3fCSSsp+Y4mYEYc9QJ75rrYGrrkkCWSJfoxpsP3OzgXKwfoMoaJSAal5
 3oK9+T7spZRjbnlunsfRCs/cu9N8NJszBHByeuAfK1LIIE1/gRFF8tcq/dEooPn4H+ttXg78DVM
 JnfmQYrRxHInW9INB/4BTHjo9oTGrAbx4WJCDUX/B6WgXz4c3RzGyrN+aZkYERmAhdBOqCdM6XC
 D11Fw86TPF97S9000cqf/5X8KOZMKVVib6PltzG50kSC6Xjifvj3jUdSxrh0C0/bvMgjX85URfZ
 ODPU2nx+d0zyayGZmPDBcByfvHDYGTXhmZ0GQS4+GJF8YdfYFfO/vARVsXY6VRHxkVDdZfQ5HgV
 KiPlCwxwRqmUgDm+1j1gVYSL8W0DdjK+n783xNRFEP3VzCIot07KwBr/w8obc0r1LEN/c/s53vu
 SE2GmxLIbvUYOD7cyLHdw=
X-Google-Smtp-Source: AGHT+IGulzn6PDyy1Kb4dD53EZz4uqKsRp4Efa3RS8VDtW1W9wJ69FtE3yHKhdOS5ril/yvU5L+snw==
X-Received: by 2002:a05:600c:4595:b0:46e:49fb:4776 with SMTP id
 5b1f17b1804b1-4776bcba9a7mr33351955e9.11.1762531083208; 
 Fri, 07 Nov 2025 07:58:03 -0800 (PST)
Received: from Timur-Hyperion.home ([2001:4c4e:24ca:a400:c3d8:2d5a:cb81:c0d3])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4775cdc33c8sm170266365e9.2.2025.11.07.07.58.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Nov 2025 07:58:02 -0800 (PST)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>, Leo Liu <Leo.Liu@amd.com>
Subject: [PATCH 11/12] drm/amdgpu/vce1: Enable VCE1 on Tahiti, Pitcairn,
 Cape Verde GPUs
Date: Fri,  7 Nov 2025 16:57:44 +0100
Message-ID: <20251107155745.8334-12-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251107155745.8334-1-timur.kristof@gmail.com>
References: <20251107155745.8334-1-timur.kristof@gmail.com>
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


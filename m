Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45AE9CCF9F1
	for <amd-gfx@archiver.kernel.org>; Tue, 28 Oct 2025 22:06:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C83EB10E683;
	Tue, 28 Oct 2025 22:06:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SmiO/jCP";
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2BE010E676
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 22:06:51 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-6399328ff1fso11023711a12.0
 for <amd-gfx@lists.freedesktop.org>; Tue, 28 Oct 2025 15:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1761689210; x=1762294010; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=r0q/pGvvnFD5F135Ci0/A2nad0Ak0eCeP5DRkdtsw9Y=;
 b=SmiO/jCPOKTui1rOwsGiW7dlVwd7KIdRNJnYVZosSZcIUCIe8X+lpQtxzY54tFmRFl
 190gqahIlnP6iSrTeHj3gGuv5h9KAL1uSVMMp6f2ow36HIZOkHZtxuPHGyfhCuKa/3U6
 znukiJxqaLpkItFVpa4vUo2OXA7vr9+xcwPIvntwbJf91fqCYVauYDdm3F5H54/2hzl6
 IPMuvJ7A2knUT+3UK5XJ4bjULv0Hv4Gto/W7aXlx+thAIoipDnSKNjLir6MbyJTd+g57
 YC//Ys0QjruaZf89961Nb6RiSLKgAZlF+0oUua8VrkrEqvE5JWBEXpMrB1LXSO7mVGg+
 lsZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761689210; x=1762294010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r0q/pGvvnFD5F135Ci0/A2nad0Ak0eCeP5DRkdtsw9Y=;
 b=Km2uG0Z8GDU6NTHWnxFvBO32QJmFu9ekujQhGywuvW6Oh3DA7kk/0syrmXegbSja4k
 DNeekwY+o9wH2mMJrpeZhmHgjHDQWjg4XSHakC//JpZY+L4ZAWa6pnyXb208asT5QgQJ
 FTeOl3qlyayrlnZEl8RH84GUIjjZOahzuHf6/VHm5enCRYU3vaJCBNJlGEKpg3d0mZPj
 nX5/Lbmvbr164KRulwxsSWhXIXXRTex9yUcwuzOVxWAECAYPNIDyrVd2wimZ8B8FxyvF
 RxMLcnnQaoqmmsgvIc4l/SQjSEA63fRi43myNQAxwL6CiOBCxgqJHhg4Evzh4xlwYohs
 g5Ow==
X-Gm-Message-State: AOJu0YxmstY3bjp3Kzo+B/Ww4DQFiHb3ctMiqzRbqYYwq9SKYcH5ztWL
 nI6rJ7Gh7BFDmFsCrHSPknQ4HEK1gEJXBgyExdVR/TkwgtQwoqSmmO3Wv6Yg5Q==
X-Gm-Gg: ASbGnctW5nUQodKOEeVSMDYGPzboMTPA2UZk7csXjNG/mTQFVGRkWr4v9Pn3eAgBLOG
 YokuNIB1T1L79AxiHTHYVwM2U6+GooHQria/8q2nKvtHSs8UqSb1ndz4KckpmeX4OX0kAllOlIY
 6y8yq5/nCNGpx9wl2eqYTB/zsMYNht3YTxja5B0R0bq4Auh3nXD4JX/y8Hrxhd9/vb/dLe9IzvW
 /WKxCKpKmR2mcWsGgkOGrR667+LLtzkNyo5CpakhdN/gFxtPRjinMs9wb+jiZ3oRIRbr+s+yXNY
 I+rNpFUAvA71Q0HYJWJssLb0AwHa1l2DyYEEQpgqNntr5YFk2zCnBsKmbXpiWpZpy4OvnOXB08x
 6+ioLzR7agkGR+zODypzQOZWR/ps+mYguzv686BeLr66x3uOC8r1T22Xn6u6qmvAILqEMxFi8MI
 Y0X1gNirLodQEWd/dAaApJZh7GsdJFCC9LbT7eUulUm6NO3tToJNEjGIaeNJ87gSNA3ELiVEUsQ
 Y9kqzIg
X-Google-Smtp-Source: AGHT+IGIO5F/5uUe3+COz6Klupvb4Q8hl9rOgcBpwTZ1e8ILVwlXm6GMqHxq0Hre4Q7oSAvZowH2/Q==
X-Received: by 2002:a05:6402:2347:b0:634:ad98:669e with SMTP id
 4fb4d7f45d1cf-64044188a38mr470756a12.3.1761689210292; 
 Tue, 28 Oct 2025 15:06:50 -0700 (PDT)
Received: from Timur-Hyperion.home
 (20014C4E24CBF70057E8101A3AD09709.dsl.pool.telekom.hu.
 [2001:4c4e:24cb:f700:57e8:101a:3ad0:9709])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-640342e5acesm1881182a12.28.2025.10.28.15.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Oct 2025 15:06:49 -0700 (PDT)
From: =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>
To: amd-gfx@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
 Alexandre Demers <alexandre.f.demers@gmail.com>,
 Rodrigo Siqueira <siqueira@igalia.com>
Subject: [PATCH 09/14] drm/amdgpu/vce1: Load VCE1 firmware
Date: Tue, 28 Oct 2025 23:06:23 +0100
Message-ID: <20251028220628.8371-10-timur.kristof@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251028220628.8371-1-timur.kristof@gmail.com>
References: <20251028220628.8371-1-timur.kristof@gmail.com>
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

Load VCE1 firmware using amdgpu_ucode_request, just like
it is done for other VCE versions.

All SI chips share the same VCE1 firmware file: vce_1_0_0.bin
which will be sent to linux-firmware soon.

Signed-off-by: Timur Kristóf <timur.kristof@gmail.com>
Co-developed-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
Co-developed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Christian König <christian.koenig@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index b23a48a1efc1..7fcc27d4453e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -41,6 +41,9 @@
 #define VCE_IDLE_TIMEOUT	msecs_to_jiffies(1000)
 
 /* Firmware Names */
+#ifdef CONFIG_DRM_AMDGPU_SI
+#define FIRMWARE_VCE_V1_0	"amdgpu/vce_1_0_0.bin"
+#endif
 #ifdef CONFIG_DRM_AMDGPU_CIK
 #define FIRMWARE_BONAIRE	"amdgpu/bonaire_vce.bin"
 #define FIRMWARE_KABINI	"amdgpu/kabini_vce.bin"
@@ -61,6 +64,9 @@
 #define FIRMWARE_VEGA12		"amdgpu/vega12_vce.bin"
 #define FIRMWARE_VEGA20		"amdgpu/vega20_vce.bin"
 
+#ifdef CONFIG_DRM_AMDGPU_SI
+MODULE_FIRMWARE(FIRMWARE_VCE_V1_0);
+#endif
 #ifdef CONFIG_DRM_AMDGPU_CIK
 MODULE_FIRMWARE(FIRMWARE_BONAIRE);
 MODULE_FIRMWARE(FIRMWARE_KABINI);
@@ -99,6 +105,12 @@ static int amdgpu_vce_get_destroy_msg(struct amdgpu_ring *ring, uint32_t handle,
 static const char *amdgpu_vce_firmware_name(struct amdgpu_device *adev)
 {
 	switch (adev->asic_type) {
+#ifdef CONFIG_DRM_AMDGPU_SI
+	case CHIP_PITCAIRN:
+	case CHIP_TAHITI:
+	case CHIP_VERDE:
+		return FIRMWARE_VCE_V1_0;
+#endif
 #ifdef CONFIG_DRM_AMDGPU_CIK
 	case CHIP_BONAIRE:
 		return FIRMWARE_BONAIRE;
-- 
2.51.0


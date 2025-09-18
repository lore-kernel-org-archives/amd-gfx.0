Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D4BCAC5A0
	for <amd-gfx@archiver.kernel.org>; Thu, 18 Sep 2025 12:44:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B1FA10E899;
	Thu, 18 Sep 2025 12:44:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="luGo9XoZ";
	dkim-atps=neutral
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com
 [209.85.210.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E3E110E0E5
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 07:12:33 +0000 (UTC)
Received: by mail-pf1-f172.google.com with SMTP id
 d2e1a72fcca58-76e6cbb991aso648867b3a.1
 for <amd-gfx@lists.freedesktop.org>; Thu, 18 Sep 2025 00:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758179553; x=1758784353; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kkm5768qLYG/7lMt2aDpCtrK/g19VAgQZBHIXA7VzC8=;
 b=luGo9XoZaLbLP/GtB5ZzgXHlqhKsqBAAH3SvZ71E8gSWXOjVH3IkVJQybsum8qDsRr
 5F+R5BNZ3lHKEHPziKFGERcTKcG6BrU666i4q21GZh3L53qy6fmQ8nJcyBJyz1dqwzbR
 whrvtiKLvu8JC0wWQBmHvUvu9lX2MCF93Fu7aror/hhb8UF8J1xAomvIer6BFVEI53np
 x9alCOP9vD4EM8SACKP4HUQo+/RGWQaE/T9AGQ0+X9AvaAcn/m7DFjib45kiR8RWBERI
 z3mAaCwxGyi5ibt9IAYSVae79JKyAl63Y8AQuyXgz7cKr9jqj8l7VS0dgMit3cBQMecW
 KtRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758179553; x=1758784353;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kkm5768qLYG/7lMt2aDpCtrK/g19VAgQZBHIXA7VzC8=;
 b=Yj7y+K81sU89f+mZ3CbdorRfcFfulQUID36KPivoGOxZ8ugyXplCv3PiF2KmmB0iiP
 gQR0k/1OD4ptMIJxOHPkcxih5OexWFjE6QZU/eLaNNLSCWb2WPf79ZNUgn5d8EaYImUI
 hNuZMIbntqXfdwHDHMoGXxx6FOdbaI2Hx1ZEUMpbcRoSmbWRQ3dc6C0gAjwIUxRsApVC
 V4OZjnvQDfHlPdai1wiqKP55oXJ5nwfZhbDypUMCMfZRJywMxhWkyLucOiK0M+Z7bEdn
 ZRUFDluMC+zlkr+wJAgiSa6gQLynl+eEobXOOAnMJTp6ILxx/I/NAQKJTgIJGjXz0mLO
 aXyA==
X-Gm-Message-State: AOJu0Yw3i3rzlRmnhzWyX83OyKVshOmgbzIAoRQvatV1HisqLMC0SKju
 ZNKC2P9he2ZbTSRMw6Z/NzHGqRIw0c/foV9m5KdX5NGBgvoU6QwxSGW6
X-Gm-Gg: ASbGncu2OQvfoRfdYnct2vkTcxceEru9Q/iEHfAxPoUrROznhSlN67317ahtl1q3Fpx
 vKGbm+6dSVRY1S0uCNCM+OIlh7ZRtQzzkembUVYJpaxtzfYr0QinrzdxcVNG5bXQDFW96Qn//xS
 7KQuOLkVnChqnBrwdFeXgsdiXtXmAqRcvyprnKQU66E+JqIvrTD+sWiTpe3wnfWmA1pAFbtq5/g
 A1XWYMdzyzkeliKKumqCq+/QP+Jiu7ihy//jEahqy3Yd5Dx/wdw8u52MeFereFHJlG8LTTxgMoU
 UxoRyW0SnKKcv5BqpK7Y3sArCLUNTQDbBtRiVXevlbcVAZ0vM3PM5nRA6PuSS/AL4jDx0cDq/M2
 flKo2XrBvXTqfEBJ9r1Wp8czRes8JSWoDRGb3BJxYxwdMrA4+NCVO1TQ=
X-Google-Smtp-Source: AGHT+IGdU2UHmJHhU9RR2jUy+RtSKtOMtaGZXLns5gxJCl2FXNsuL8oTowVvbbfw7QvNTE+aUNdCBQ==
X-Received: by 2002:a05:6a20:6a10:b0:23d:ab68:1b7c with SMTP id
 adf61e73a8af0-27aa99bdb9emr7214606637.46.1758179552545; 
 Thu, 18 Sep 2025 00:12:32 -0700 (PDT)
Received: from localhost.localdomain ([165.204.156.251])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b54ff3743bcsm1435597a12.20.2025.09.18.00.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Sep 2025 00:12:32 -0700 (PDT)
From: Rahul Kumar <rk0006818@gmail.com>
To: Felix.Kuehling@amd.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linuxfoundation.org, skhan@linuxfoundation.org,
 rk0006818@gmail.com, Felix Kuehling <felix.kuehling@amd.com>
Subject: [PATCH v2] drm/amdgpu: Use kmalloc_array() instead of kmalloc()
Date: Thu, 18 Sep 2025 12:42:00 +0530
Message-ID: <20250918071201.350162-1-rk0006818@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 18 Sep 2025 12:44:21 +0000
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

Documentation/process/deprecated.rst recommends against the use of
kmalloc with dynamic size calculations due to the risk of overflow and
smaller allocation being made than the caller was expecting.

Replace kmalloc() with kmalloc_array() in amdgpu_amdkfd_gfx_v10.c,
amdgpu_amdkfd_gfx_v10_3.c, amdgpu_amdkfd_gfx_v11.c and
amdgpu_amdkfd_gfx_v12.c to make the intended allocation size clearer
and avoid potential overflow issues.

Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
Signed-off-by: Rahul Kumar <rk0006818@gmail.com>
---
Changes since v1:
- Extend fix to amdgpu_amdkfd_gfx_v10_3.c, amdgpu_amdkfd_gfx_v11.c and
  amdgpu_amdkfd_gfx_v12.c as suggested.
- Added Suggested-by tag.
Link to v1:
https://lore.kernel.org/all/f782159b-ad3f-4d0c-8476-50a701bf29e6@amd.com/
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c   | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c   | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
index 04ef0ca10541..0239114fb6c4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10.c
@@ -352,7 +352,7 @@ static int kgd_hqd_dump(struct amdgpu_device *adev,
 		(*dump)[i++][1] = RREG32_SOC15_IP(GC, addr);		\
 	} while (0)
 
-	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	*dump = kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
 	if (*dump == NULL)
 		return -ENOMEM;
 
@@ -449,7 +449,7 @@ static int kgd_hqd_sdma_dump(struct amdgpu_device *adev,
 #undef HQD_N_REGS
 #define HQD_N_REGS (19+6+7+10)
 
-	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	*dump = kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
 	if (*dump == NULL)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
index 6d08bc2781a3..f2278a0937ff 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v10_3.c
@@ -338,7 +338,7 @@ static int hqd_dump_v10_3(struct amdgpu_device *adev,
 		(*dump)[i++][1] = RREG32_SOC15_IP(GC, addr);		\
 	} while (0)
 
-	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	*dump = kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
 	if (*dump == NULL)
 		return -ENOMEM;
 
@@ -435,7 +435,7 @@ static int hqd_sdma_dump_v10_3(struct amdgpu_device *adev,
 #undef HQD_N_REGS
 #define HQD_N_REGS (19+6+7+12)
 
-	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	*dump = kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
 	if (*dump == NULL)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
index e0e6a6a49d90..aaccf0b9947d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v11.c
@@ -323,7 +323,7 @@ static int hqd_dump_v11(struct amdgpu_device *adev,
 		(*dump)[i++][1] = RREG32(addr);		\
 	} while (0)
 
-	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	*dump = kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
 	if (*dump == NULL)
 		return -ENOMEM;
 
@@ -420,7 +420,7 @@ static int hqd_sdma_dump_v11(struct amdgpu_device *adev,
 #undef HQD_N_REGS
 #define HQD_N_REGS (7+11+1+12+12)
 
-	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	*dump = kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
 	if (*dump == NULL)
 		return -ENOMEM;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
index 6f0dc23c901b..e0ceab400b2d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gfx_v12.c
@@ -115,7 +115,7 @@ static int hqd_dump_v12(struct amdgpu_device *adev,
 		(*dump)[i++][1] = RREG32(addr);		\
 	} while (0)
 
-	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	*dump = kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
 	if (*dump == NULL)
 		return -ENOMEM;
 
@@ -146,7 +146,7 @@ static int hqd_sdma_dump_v12(struct amdgpu_device *adev,
 #undef HQD_N_REGS
 #define HQD_N_REGS (last_reg - first_reg + 1)
 
-	*dump = kmalloc(HQD_N_REGS*2*sizeof(uint32_t), GFP_KERNEL);
+	*dump = kmalloc_array(HQD_N_REGS, sizeof(**dump), GFP_KERNEL);
 	if (*dump == NULL)
 		return -ENOMEM;
 
-- 
2.43.0


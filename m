Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D378FC35FF9
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 06:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1314110E331;
	Mon, 17 Mar 2025 06:07:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dJP2e0Mf";
	dkim-atps=neutral
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 689E310E322
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 06:07:33 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-47690a4ec97so41610011cf.2
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Mar 2025 23:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742191652; x=1742796452; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=VH36aS+BQQD37/SpWss6E55KReEO2ZJm6p1fqXVtW/8=;
 b=dJP2e0Mfgn3KRDzfiQ7Q5d84cpIsj0zNJj+vhO9tcDD2eCqDzYDHY4YF7I4tthJPxS
 FaW3yPhgeMJyflMvDVcZ8Brk2xlF++EzmGOAUURtpSU/h3E0/y4FjV29IYMsxgllOq1r
 oOX5J8IPLFWZxUVXT2RFC8y5yXgLi2/WNJ9bHID3DHB7Lz+gEuWTM+3AyxWVF53hlndZ
 TnsneuhVt3VLyGuQUmAOZD7XYSqONq4Ly5Ey7pCJo+IafxRuUPMGtNuyomsAjtUHVUzi
 3WAtsEAxk2uxWum8e8+iaEe2/bsd15r/42ucAKW4GXXpBROOUYE1G5enpOqh+xlJvmZi
 Bn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742191652; x=1742796452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VH36aS+BQQD37/SpWss6E55KReEO2ZJm6p1fqXVtW/8=;
 b=GsNbFEOmixOrOF2szJ7Kf2Ocx+nGETObwYbSVtusmkBOnc/9Ejn/Asuv9QIy91QT1F
 rT3NiB8K4eCEdbX/9a1ImWBehIg/JhPpNP8FUXTMJZpQ7ms2qyPOxqb0RUlhs7DQlwSJ
 F6hOtkHSabbfYjVAlbcHrCvBrqzVfSy25dQNO+5g+GeDRq3OyFiYCoE3Jn16J/vECFUx
 Hd56TFSuKuPXJy3qYXqFbzUfrdZbFF0+dM+y26kW0AGD6vA2rfdL30qKvRtRAD91Hzt/
 zBdISbu0h4+Yw7YRtGgrS9p4VHDTajVKXMH+gV1pTrPZnRRNg3MyuHtdol9itbc/kfVZ
 zwiA==
X-Gm-Message-State: AOJu0Yz/P1UbqrYCwrGPU/FEutDEPj/vtx2SxpRzNcHvSiNXoZy2/cQJ
 yhMWJIzqprAUcG8ByLpaeD59Vhzcp9cJ0cCEIX4uv8gQpOTUMZL5fZztpQ==
X-Gm-Gg: ASbGnctA5p1+gShmevA1MpsD/NjtFr4AijVu2fRIgxBoaabLD4/6t484ee0vHPm6t+W
 LyeOCuLdHM08tFa1IbFWceMOPPzb/Z2Ur7FAQMb/3e+7vwJkT+teXHJLTK1rKXxmhHZILfkRYLL
 Hribk0Wjm0FodkpBfwh0+az8t5aM7pAj3TiwobCd7Gs6DfMnrSQ7+QCuOe3lvLHx/xlPYqNzgtj
 vxNqF4GkAuWu1VpAcERea9HWcIAPWm6x0xOIzIweRwbDfyKQKJ3AR2tU9lfwBYQUXXIUsMBt2Zu
 mpS3eAStrwy38Zj6SooNgPgTU9tWfGaqk+U+34Wk5HR9FFx9xL5GBTJ1MmsCQY+9xWY=
X-Google-Smtp-Source: AGHT+IGnxk0kZx88VJROLPbqYn0j4bRpTqR1OiWE8Wb7Xe0WEuiFoi0RSoD68hxhzeb5Nfu2Y2BN/A==
X-Received: by 2002:ac8:5d12:0:b0:476:9548:4734 with SMTP id
 d75a77b69052e-476c813103emr143165991cf.6.1742191652394; 
 Sun, 16 Mar 2025 23:07:32 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb7f4f08sm50605931cf.56.2025.03.16.23.07.31
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 23:07:32 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 12/18] drm/amdgpu: fix GFX6 variables for sid.h cleanup
Date: Mon, 17 Mar 2025 02:06:56 -0400
Message-ID: <20250317060702.5297-13-alexandre.f.demers@gmail.com>
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

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
index 5f85c3b63971..f34980c79a7e 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v6_0.c
@@ -1731,10 +1731,14 @@ static void gfx_v6_0_constants_init(struct amdgpu_device *adev)
 	gfx_v6_0_get_cu_info(adev);
 	gfx_v6_0_config_init(adev);
 
-	WREG32(mmCP_QUEUE_THRESHOLDS, ((0x16 << CP_QUEUE_THRESHOLDS__ROQ_IB1_START__SHIFT) |
-				       (0x2b << CP_QUEUE_THRESHOLDS__ROQ_IB2_START__SHIFT)));
-	WREG32(mmCP_MEQ_THRESHOLDS, (0x30 << CP_MEQ_THRESHOLDS__MEQ1_START__SHIFT) |
-				    (0x60 << CP_MEQ_THRESHOLDS__MEQ2_START__SHIFT));
+	WREG32(mmCP_QUEUE_THRESHOLDS,
+		((0x16 << CP_QUEUE_THRESHOLDS__ROQ_IB1_START__SHIFT) |
+		(0x2b << CP_QUEUE_THRESHOLDS__ROQ_IB2_START__SHIFT)));
+
+	/* set HW defaults for 3D engine */
+	WREG32(mmCP_MEQ_THRESHOLDS,
+		(0x30 << CP_MEQ_THRESHOLDS__MEQ1_START__SHIFT) |
+		(0x60 << CP_MEQ_THRESHOLDS__MEQ2_START__SHIFT));
 
 	sx_debug_1 = RREG32(mmSX_DEBUG_1);
 	WREG32(mmSX_DEBUG_1, sx_debug_1);
-- 
2.48.1


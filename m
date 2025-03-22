Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5ED31C36005
	for <amd-gfx@archiver.kernel.org>; Sat, 22 Mar 2025 01:47:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C73AD10E85B;
	Sat, 22 Mar 2025 01:47:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Z82FTr7z";
	dkim-atps=neutral
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com
 [209.85.160.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79F4E10E852
 for <amd-gfx@lists.freedesktop.org>; Sat, 22 Mar 2025 01:47:15 +0000 (UTC)
Received: by mail-qt1-f172.google.com with SMTP id
 d75a77b69052e-47677b77725so23201401cf.3
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Mar 2025 18:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742608034; x=1743212834; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rweXivC1bNW0OiFETjdqomCMb8OhDjjUI2SCC2fg2MM=;
 b=Z82FTr7z3xb+xhVIPbhnDtw4Ht82UKULksQegoAy++aLfDABvutfTQ77lgZKyWoWx/
 N8utlLtpnRZLKFMzmaosE5iJknzS5ccV1w94lomLYALN/QfFPJian8DOIisl2fn/8wOl
 wYVOkyRAU5OTrEoHW0GB8x5o5AkMcvjtEeWNAZhxeXs3czVHoaBbO7F3+IozKHANloK5
 iy6abyUHujCE9eUWqAfHNVS/caCW1nz8UEVLl0CMtt1uaHSYq9iUKZp+0IZckzuDQMLN
 O5CUpWUFYxlWCPBAKmIZiwDueGrI7X9WWPSDX3bHTDGuIAS4kSMiTeDEXY0PbczxlFDF
 xTew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742608034; x=1743212834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rweXivC1bNW0OiFETjdqomCMb8OhDjjUI2SCC2fg2MM=;
 b=c4ZGrFWkl9znhtncJBWobhSkM8lEayh1J1XY4Q45tan4H8W9CBEyaJ6uX0RiZzxgnK
 s/CJQvPX0YGoV3yu+c01XlE4XLlt5NbmZmTurLp3LbnwnBOH16HhOA5mfA8gi6/D98GU
 kYJmj0piNAb6740lmXodxe/ZfJbqCrwZ2w/mMPvY4MyePY1UwfqP7xmkQwrO4QDeBuis
 PZci6CQxicrgHWdeQscLOlP7D9JfRxFNzPjnuZNTRwoA5KjMLnEoIKXoEDNbDhzdHHBS
 hpt0aU78Gj0Jy2JRPlyVxVebrTKT/0Fji9UrT9i2WGCM0wJllg5Oxcp2vootmzIHfOrI
 IMrQ==
X-Gm-Message-State: AOJu0YzO7Pveg9L2PZn+qyY1eHIcZDCCPzN60kRfwJwfZqgmjrmsaOp0
 nFtIG6+6UjhPJN8lF1GFoW4udRStWCxxCgO/3TBxJ6QdfFhCyVhLQhLvRw==
X-Gm-Gg: ASbGnctcrMPwLPZdhEIR2I9rbG3TGKS5RaqZwfvzfVdJEPXNkb4nswXUC5dSmp2YwLA
 /+VKt0lD3m5ULl00rdKjQJQUuCRVqY1Fv9+dRsE1UO8wWlbXHxzFOnmY2Ej7wGIrE2iReKcEEBx
 4V97jetUNXrzNqfbkpeFo1MNOch2u0JJ1VZtKZ8QsychYqjYJW7jJViyBqBcLDf5t+y4q/RkrMC
 8xQCEAxsYlZCYFtC4J+M6BmR6nRLF3ejOqSpaqlQ7JwNQcWKgIN9C/N2QBkWbd4inkLBpMeEjZQ
 9BvVCYyVH6Z9IGpWGOFux6CXlGspAB28n+6pp8PXuEo/W4kIOYGpgthXB1EG9S9raXY=
X-Google-Smtp-Source: AGHT+IE+FlA6yTOjCfNxfI+kmKVMO3QRNj5oyCU2m+1eBL5ST6W2oKxuxQfCi6TXBCBn5Iw5o1gPPQ==
X-Received: by 2002:a05:622a:510e:b0:476:ac97:b970 with SMTP id
 d75a77b69052e-4771de920b8mr96331581cf.52.1742608034248; 
 Fri, 21 Mar 2025 18:47:14 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4771d159964sm18688591cf.8.2025.03.21.18.47.13
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Mar 2025 18:47:13 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/18] drm/amdgpu: wire up defines,
 shifts and masks through SI code
Date: Fri, 21 Mar 2025 21:46:44 -0400
Message-ID: <20250322014700.62356-3-alexandre.f.demers@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250322014700.62356-1-alexandre.f.demers@gmail.com>
References: <20250322014700.62356-1-alexandre.f.demers@gmail.com>
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

To be able to remove as much duplicated defines, the different files
containing definitions, shifts and masks must be properly included.

Once done, the code will be migrated where needed to shifts and masks and
proper defines, before removing useless defines in the end.

Signed-off-by: Alexandre Demers <alexandre.f.demers@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/si.c            | 18 ++++++++++++++++--
 drivers/gpu/drm/amd/amdgpu/si_dma.c        |  2 ++
 drivers/gpu/drm/amd/amdgpu/si_ih.c         |  1 +
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 20 ++++++++++++++++++--
 drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c |  6 ++++++
 5 files changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/si.c b/drivers/gpu/drm/amd/amdgpu/si.c
index a18b3ece635b..75d3b7471c68 100644
--- a/drivers/gpu/drm/amd/amdgpu/si.c
+++ b/drivers/gpu/drm/amd/amdgpu/si.c
@@ -35,6 +35,7 @@
 #include "amdgpu_vce.h"
 #include "atom.h"
 #include "amd_pcie.h"
+
 #include "si_dpm.h"
 #include "sid.h"
 #include "si_ih.h"
@@ -44,17 +45,30 @@
 #include "dce_v6_0.h"
 #include "si.h"
 #include "uvd_v3_1.h"
-#include "amdgpu_vkms.h"
+
+#include "uvd/uvd_4_0_d.h"
+
+#include "smu/smu_6_0_d.h"
+#include "smu/smu_6_0_sh_mask.h"
+
 #include "gca/gfx_6_0_d.h"
+#include "gca/gfx_6_0_sh_mask.h"
+
 #include "oss/oss_1_0_d.h"
 #include "oss/oss_1_0_sh_mask.h"
+
 #include "gmc/gmc_6_0_d.h"
+#include"gmc/gmc_6_0_sh_mask.h"
+
 #include "dce/dce_6_0_d.h"
-#include "uvd/uvd_4_0_d.h"
+#include "dce/dce_6_0_sh_mask.h"
+
 #include "bif/bif_3_0_d.h"
 #include "bif/bif_3_0_sh_mask.h"
+#include "si_enums.h"
 
 #include "amdgpu_dm.h"
+#include "amdgpu_vkms.h"
 
 static const u32 tahiti_golden_registers[] =
 {
diff --git a/drivers/gpu/drm/amd/amdgpu/si_dma.c b/drivers/gpu/drm/amd/amdgpu/si_dma.c
index 47647a6083e8..3c9b4fb25855 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dma.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dma.c
@@ -27,6 +27,8 @@
 #include "si.h"
 #include "sid.h"
 
+#include "oss/oss_1_0_d.h"
+#include "oss/oss_1_0_sh_mask.h"
 const u32 sdma_offsets[SDMA_MAX_INSTANCE] =
 {
 	DMA0_REGISTER_OFFSET,
diff --git a/drivers/gpu/drm/amd/amdgpu/si_ih.c b/drivers/gpu/drm/amd/amdgpu/si_ih.c
index 2ec1ebe4db11..94468c87122a 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_ih.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_ih.c
@@ -27,6 +27,7 @@
 #include "amdgpu_ih.h"
 #include "sid.h"
 #include "si_ih.h"
+
 #include "oss/oss_1_0_d.h"
 #include "oss/oss_1_0_sh_mask.h"
 
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
index ee23a0f897c5..975912f285d7 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
@@ -30,16 +30,32 @@
 #include "amdgpu_atombios.h"
 #include "amdgpu_dpm_internal.h"
 #include "amd_pcie.h"
-#include "sid.h"
+#include "atom.h"
+#include "gfx_v6_0.h"
 #include "r600_dpm.h"
+#include "sid.h"
 #include "si_dpm.h"
-#include "atom.h"
 #include "../include/pptable.h"
 #include <linux/math64.h>
 #include <linux/seq_file.h>
 #include <linux/firmware.h>
 #include <legacy_dpm.h>
 
+#include "bif/bif_3_0_d.h"
+#include "bif/bif_3_0_sh_mask.h"
+
+#include "dce/dce_6_0_d.h"
+#include "dce/dce_6_0_sh_mask.h"
+
+#include "gca/gfx_6_0_d.h"
+#include "gca/gfx_6_0_sh_mask.h"
+
+#include"gmc/gmc_6_0_d.h"
+#include"gmc/gmc_6_0_sh_mask.h"
+
+#include "smu/smu_6_0_d.h"
+#include "smu/smu_6_0_sh_mask.h"
+
 #define MC_CG_ARB_FREQ_F0           0x0a
 #define MC_CG_ARB_FREQ_F1           0x0b
 #define MC_CG_ARB_FREQ_F2           0x0c
diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c b/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
index 8f994ffa9cd1..c712899c44ca 100644
--- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
+++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_smc.c
@@ -30,6 +30,12 @@
 #include "amdgpu_ucode.h"
 #include "sislands_smc.h"
 
+#include "smu/smu_6_0_d.h"
+#include "smu/smu_6_0_sh_mask.h"
+
+#include "gca/gfx_6_0_d.h"
+#include "gca/gfx_6_0_sh_mask.h"
+
 static int si_set_smc_sram_address(struct amdgpu_device *adev,
 				   u32 smc_address, u32 limit)
 {
-- 
2.48.1


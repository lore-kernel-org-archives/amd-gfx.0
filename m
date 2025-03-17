Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10EC4C282EC
	for <amd-gfx@archiver.kernel.org>; Mon, 17 Mar 2025 06:07:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9F7E710E271;
	Mon, 17 Mar 2025 06:07:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fjAOKdf9";
	dkim-atps=neutral
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com
 [209.85.160.182])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2521110E271
 for <amd-gfx@lists.freedesktop.org>; Mon, 17 Mar 2025 06:07:29 +0000 (UTC)
Received: by mail-qt1-f182.google.com with SMTP id
 d75a77b69052e-476f4e9cf92so1530871cf.3
 for <amd-gfx@lists.freedesktop.org>; Sun, 16 Mar 2025 23:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1742191645; x=1742796445; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=rweXivC1bNW0OiFETjdqomCMb8OhDjjUI2SCC2fg2MM=;
 b=fjAOKdf9kGcup8TTPw68YKudNOd3Wwkd6749r7GuNRCdtn/qutzAXLj8WVqW848bUn
 MvMLqN8JGF54+WPkoz3p6/GNO94wYwNbaLl9hd3FSE1ZEJ4ku7PNubEpk8nikqomwzRD
 tKxsvvhDZQ3TQNq5si4oN2KjU3ciV2gI7AvovVyMjnExmQyCDm33/lExrFQ5KPPHUi7P
 q1+/oH99Pi3lqsrjaYKnbMcUxaxx8Kt8vr6Z5q5EgwgZhqSOg7BNHp48fujYIbT7CQvk
 ur8f1FXhFu65nNCRNYnhNa18tYarQTU+YFgFXtX67SfZttom2OkDjlUNmzrGUaFy50m4
 GMFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742191645; x=1742796445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rweXivC1bNW0OiFETjdqomCMb8OhDjjUI2SCC2fg2MM=;
 b=FTtDko0acsc9jYtAtB0Gjxs2pUpw9d8v0Bm6ZFXJzB/EcKa4mHkD5H8alWnJ8VP81C
 yHFZk1EXgQ8G/YLHaefL11rwWFz5UdSKg0tn3uO2HSam5EU1mr0xleAkvS3DpRBP+pNG
 V3gGegYqz7Wq6mdux3b+6IvESMbFr5a2JczWX+ueIf9yk+y34UwiEYshnIdZDAG6xsuE
 1FtVM4ZJLF9EnOBn7/htFahGe2pk0ioJ5A65UZ5DPBo5tuBHqfWdhcK4q70x/jy41JsM
 lTWJahQCIVKkmn9aRBkBmtHlh3YMxf1uQdq5iw9dIVzgcc7yWucvtiVMNCjzWOKa6gnF
 TQbA==
X-Gm-Message-State: AOJu0YztKNoVrxxjW+oHi8IF8O0YMZtYL7Fs8gEPaThzSwI8Vlm2TtqF
 78tbCXweLYu3pMPkmEtHt3uMV8eyuyd3fiWXJFO49MqfjoRm3tVXFwi18A==
X-Gm-Gg: ASbGncu9LV6elVq1SHwDL8FS15CInZoOjB6yASd8olj92M9OqIOEUztH6ZHcbkToU8r
 ZFhrKbZj5TKNCX6m++XMlWlMQecssiNZKgMpf4v0lORguitjX4vBX6t6HmtUWzMRHYi+9bnMkoT
 B3WLe2/cySVQ2Pgf6dHQ28vBpgmPPEvfS7ql2s7sEeABJU0QS4JE/6y8yXCzNmbCzwS5AQSChBA
 9UCCVYSGj6bS4se+wHwBeLQR9xRKnHj70ka1z+9SQEjrMHmIjylT1Fa0mdXZktCRpI0ItkuOyvU
 19CFkdXqsCgueetlKBpsktEpbBiHNue10MpOTfc8ZIiZI4sYOKPveEsA7XEiF+skBu8=
X-Google-Smtp-Source: AGHT+IGIc0KrVYs7TbzhHVLZCrPEAJr/Yg8g4BjLZi+Z7KS/BXa4M72eszdegU5+txPa3tXRu/saeQ==
X-Received: by 2002:ac8:5fcf:0:b0:476:7e6b:d291 with SMTP id
 d75a77b69052e-476c81c3f8bmr175155181cf.37.1742191644658; 
 Sun, 16 Mar 2025 23:07:24 -0700 (PDT)
Received: from localhost.localdomain ([38.74.25.248])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-476bb7f4f08sm50605931cf.56.2025.03.16.23.07.24
 for <amd-gfx@lists.freedesktop.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Mar 2025 23:07:24 -0700 (PDT)
From: Alexandre Demers <alexandre.f.demers@gmail.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 02/18] drm/amdgpu: wire up defines,
 shifts and masks through SI code
Date: Mon, 17 Mar 2025 02:06:46 -0400
Message-ID: <20250317060702.5297-3-alexandre.f.demers@gmail.com>
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


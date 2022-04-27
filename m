Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5A65C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 15:24:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 547B110F5B3;
	Wed, 27 Apr 2022 15:24:28 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2081.outbound.protection.outlook.com [40.107.220.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C12EF10F4DF
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 15:24:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cnY3XrrxXk1sOBJtbc+IiJRqu92aoCkYmFJSVXZm4u1HRvgCkcioi32GTNWW3G7+3pqwneTikhHJGjPrwGCcTonSFmyshVs42yiLH36BHRuhizCDUTqbeTmMZrNzAKwozasBxf7WxTsn4ffXMC/hVTWcO7kKGS6YSO58bRQf0FWSMf0RE+Ywx9ajACZ2mp/1GReJDyiBaqrVzxSJc6OxyTVUA7jhMcDXcd9LWwUt2Sprgy3Z0bmpz1EOD7CAucTNvntWj1WdddbiVY0/5s4sp+c4fCA22h7maCym9VdGa9saoWNUUagEHdBN9TWoQXx5nzc83Tr6gQy+HrisiZsNRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ROoh/w2Szmh7Te41jiMK++NABMoNcTmJ4LgvJvPfgU=;
 b=H7RmAvj3NQp8UZDs0VFGYtzBDvwEYLnCTdeLrKTKoeOMG9C6WNmv95+jHWI9Q7eAgoSLE0dm75bN5/SbMxznj20bmklcrbhAhKESZ5LsajPjsiRbTUYqHEJyrId/DmCyM/Y661sk3y7FiYArR5Hcin2dj2IxgDTejUObOcXHtfyMyMawc729xX6uxFv1LMPwuetJe17gGujA+7Trpx1vQQoHVT14uNvEwkQ2yB89Yj3T+XkccJm9oHAOw9sno5OUBk57GXCeh/kqK8di/BRqdqxpwpFD1ULNOyTOfQdnaLgSTbFe7O7IneaugMLy9cPSyVyNrrFNSPuZcVaaNYME0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ROoh/w2Szmh7Te41jiMK++NABMoNcTmJ4LgvJvPfgU=;
 b=QE9JwolVJzE4MLAM/wcayAYr3Lnz9vAe8BPpbw0zDovfzqoi8lr9OIpHncLYaHZbWafsvgKl99PJlBJskpiraUgeKe37zcCel1FsAf/zhMMOpGpfpDS/oBtRjvA1dOU7TjvJEOTRVwSdGmXLRoRnGluwT8SKTTuzdAjCvmUmZBM=
Received: from BN9PR03CA0730.namprd03.prod.outlook.com (2603:10b6:408:110::15)
 by CH2PR12MB3926.namprd12.prod.outlook.com (2603:10b6:610:27::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.17; Wed, 27 Apr
 2022 15:24:20 +0000
Received: from BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:110:cafe::2f) by BN9PR03CA0730.outlook.office365.com
 (2603:10b6:408:110::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Wed, 27 Apr 2022 15:24:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT052.mail.protection.outlook.com (10.13.177.210) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 15:24:20 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 10:24:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: add hdp version 6 functions
Date: Wed, 27 Apr 2022 11:24:03 -0400
Message-ID: <20220427152404.3107627-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220427152404.3107627-1-alexander.deucher@amd.com>
References: <20220427152404.3107627-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23c0fb4b-6d06-4d94-bf21-08da28620054
X-MS-TrafficTypeDiagnostic: CH2PR12MB3926:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB39265453DE2FFC2D2FF60A63F7FA9@CH2PR12MB3926.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kWwhJgSAHruwj3zhCSjpDZJ9lAiAg0WWwG82T2TmvGAE/tJUYiQAWZ1MzSbA9z/unNEgnGZx2bmawowXgs3qnIwVyq0OAfPRw2gDtCUeIGN64CLh9Ah0BxttdgCaMM7WxPN4nUmOwW6dXNcx3DnFYGzpgHs8zhHsZEpo6v1ddXZK1z8bC5ElH0erHYNz997gYGFTj8fcfWOjtr0+zqhL9g5yMcW8WlxouHaKvrZ9fx0RMb5/PMGlAgrGej9do9tQTgkJmSLemnC4hLe001O48JoUTKmiQJ/3e8DKSmdhM2McX/szQGn5X0Z6AE9QrtjWaxSk9u++ro57IPTECN/2mNc/G4WDej+cPrTNDgraYyMZPNQg5uIdunFI3zEaVrc3nqU2DVnRZA+e/0db6wVdf3mTS5J91QOiBbGAS8/A7PyDAFN6Pmy4LHYJV8Ymj9rCTXfeD8whZ/l1bZIxNCysVhu6XZbyetMtr8kF5N8Q/lFupqQc7HwIrz1Q8LxcUu9u3BzOjqLCgA5D/P4Y2XRKCYfzu5qDeM3Ektl5fbsNuEb0AgPXLDaDMiI0qST5zB7bCFLxr9GJtnsSjZvNyaRRH0Y2w+NaV2WtJupSDWGElF6+PXu4xB6SopPMl3BOUV4XTsq2fEW/6BlhQK5dLNknLfJR8X64OvViQdFlkURYQ7hZi8Cb+waixf1HaQzBk7WZcY/g59R4/isoJU4X1TqEbw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(356005)(5660300002)(36860700001)(508600001)(2616005)(1076003)(8936002)(40460700003)(83380400001)(336012)(47076005)(186003)(426003)(16526019)(2906002)(7696005)(26005)(86362001)(6666004)(70586007)(70206006)(81166007)(54906003)(4326008)(82310400005)(36756003)(8676002)(6916009)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 15:24:20.3181 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23c0fb4b-6d06-4d94-bf21-08da28620054
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3926
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Likun Gao <Likun.Gao@amd.com>

Unify hdp related function into hdp structure for hdp version 6.
V2: Remove hdp invalidate function as hdp v6 doesn't have read cache.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile   |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu.h   |   3 +-
 drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c | 100 ++++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/hdp_v6_0.h |  31 ++++++++
 4 files changed, 134 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v6_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 244f53cc7c46..b10ba2b36ca9 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -75,7 +75,7 @@ amdgpu-y += \
 	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o arct_reg_init.o mxgpu_nv.o \
 	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o \
-	nbio_v4_3.o
+	nbio_v4_3.o hdp_v6_0.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index aa5b944956d8..05358c587783 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -1188,7 +1188,8 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
 #define amdgpu_asic_flush_hdp(adev, r) \
 	((adev)->asic_funcs->flush_hdp ? (adev)->asic_funcs->flush_hdp((adev), (r)) : (adev)->hdp.funcs->flush_hdp((adev), (r)))
 #define amdgpu_asic_invalidate_hdp(adev, r) \
-	((adev)->asic_funcs->invalidate_hdp ? (adev)->asic_funcs->invalidate_hdp((adev), (r)) : (adev)->hdp.funcs->invalidate_hdp((adev), (r)))
+	((adev)->asic_funcs->invalidate_hdp ? (adev)->asic_funcs->invalidate_hdp((adev), (r)) : \
+	 ((adev)->hdp.funcs->invalidate_hdp ? (adev)->hdp.funcs->invalidate_hdp((adev), (r)) : 0))
 #define amdgpu_asic_need_full_reset(adev) (adev)->asic_funcs->need_full_reset((adev))
 #define amdgpu_asic_init_doorbell_index(adev) (adev)->asic_funcs->init_doorbell_index((adev))
 #define amdgpu_asic_get_pcie_usage(adev, cnt0, cnt1) ((adev)->asic_funcs->get_pcie_usage((adev), (cnt0), (cnt1)))
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
new file mode 100644
index 000000000000..1dab8f3fcbad
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.c
@@ -0,0 +1,100 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#include "amdgpu.h"
+#include "amdgpu_atombios.h"
+#include "hdp_v6_0.h"
+
+#include "hdp/hdp_6_0_0_offset.h"
+#include "hdp/hdp_6_0_0_sh_mask.h"
+#include <uapi/linux/kfd_ioctl.h>
+
+static void hdp_v6_0_flush_hdp(struct amdgpu_device *adev,
+				struct amdgpu_ring *ring)
+{
+	if (!ring || !ring->funcs->emit_wreg)
+		WREG32_NO_KIQ((adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+	else
+		amdgpu_ring_emit_wreg(ring, (adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL) >> 2, 0);
+}
+
+static void hdp_v6_0_update_clock_gating(struct amdgpu_device *adev,
+						      bool enable)
+{
+	uint32_t hdp_clk_cntl;
+
+	if (!(adev->cg_flags & AMD_CG_SUPPORT_HDP_MGCG))
+		return;
+
+	hdp_clk_cntl = RREG32_SOC15(HDP, 0, regHDP_CLK_CNTL);
+
+	if (enable) {
+		hdp_clk_cntl &=
+			~(uint32_t)
+			(HDP_CLK_CNTL__ATOMIC_MEM_CLK_SOFT_OVERRIDE_MASK |
+			 HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
+			 HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
+			 HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
+			 HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
+			 HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK);
+	} else {
+		hdp_clk_cntl |= HDP_CLK_CNTL__ATOMIC_MEM_CLK_SOFT_OVERRIDE_MASK |
+			HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
+			HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
+			HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
+			HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
+			HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK;
+	}
+
+	WREG32_SOC15(HDP, 0, regHDP_CLK_CNTL, hdp_clk_cntl);
+}
+
+static void hdp_v6_0_get_clockgating_state(struct amdgpu_device *adev,
+					    u64 *flags)
+{
+	uint32_t tmp;
+
+	/* AMD_CG_SUPPORT_HDP_MGCG */
+	tmp = RREG32_SOC15(HDP, 0, regHDP_CLK_CNTL);
+	if (!(tmp & (HDP_CLK_CNTL__ATOMIC_MEM_CLK_SOFT_OVERRIDE_MASK |
+		     HDP_CLK_CNTL__RC_MEM_CLK_SOFT_OVERRIDE_MASK |
+		     HDP_CLK_CNTL__DBUS_CLK_SOFT_OVERRIDE_MASK |
+		     HDP_CLK_CNTL__DYN_CLK_SOFT_OVERRIDE_MASK |
+		     HDP_CLK_CNTL__XDP_REG_CLK_SOFT_OVERRIDE_MASK |
+		     HDP_CLK_CNTL__HDP_REG_CLK_SOFT_OVERRIDE_MASK)))
+		*flags |= AMD_CG_SUPPORT_HDP_MGCG;
+
+	/* AMD_CG_SUPPORT_HDP_LS/DS/SD */
+	tmp = RREG32_SOC15(HDP, 0, regHDP_MEM_POWER_CTRL);
+	if (tmp & HDP_MEM_POWER_CTRL__ATOMIC_MEM_POWER_LS_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_HDP_LS;
+	else if (tmp & HDP_MEM_POWER_CTRL__ATOMIC_MEM_POWER_DS_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_HDP_DS;
+	else if (tmp & HDP_MEM_POWER_CTRL__ATOMIC_MEM_POWER_SD_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_HDP_SD;
+}
+
+const struct amdgpu_hdp_funcs hdp_v6_0_funcs = {
+	.flush_hdp = hdp_v6_0_flush_hdp,
+	.update_clock_gating = hdp_v6_0_update_clock_gating,
+	.get_clock_gating_state = hdp_v6_0_get_clockgating_state,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.h b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.h
new file mode 100644
index 000000000000..533ecd8c0800
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v6_0.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#ifndef __HDP_V6_0_H__
+#define __HDP_V6_0_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_hdp_funcs hdp_v6_0_funcs;
+
+#endif
-- 
2.35.1


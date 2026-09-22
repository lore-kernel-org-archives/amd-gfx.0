Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B38CC98302
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 13:52:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0570B10E4E5;
	Tue, 22 Sep 2026 13:52:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wX43h0Q9";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012039.outbound.protection.outlook.com
 [40.107.200.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C76DA10E489
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 13:52:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tt6ZtOs0pZJcO/4zcUWDVDqq6hUe747ubluPxt/6Xa5ODRG8ornvQZmUrhDOa3Txq2UqiEsayOU/fhBuan3QSXViHvIace2LSxQqD8HEA/SpTuu3ioVSC36Mz0NZTCzeDZRz62xx9b6AHZnr0g70uq0OJzLUlATWi71xFsNRagZk4fQw7MY6o9XdrkbArV9j/oUvCwxMxVBoAaUhRJLqQhgLEtEpL6OmyLNsnNSJzb+eruQXj46RU5b8EPSaHeclaihA9Ly7UfuxroHKkz0uR2QeKfwONOm6GCeT4Aza08SMr8nHO72qOWBz3x+6BYfMWZYDA4uKd0uQ2nJif0/HGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ihN2bzF7W5OnKfoSHTrSY3sW9qvl3q7+qrq7YIkGV1U=;
 b=o8RcGQr5veJi9A+cZhTbsZ0keqm6GJsAnj/REoF0hoJwxqZVkkPNliUVzW9QiZZ5/eVMAcPzcHyHDJsDbIkDeuo94Npm+cXsR11ZEjiWB5wj6aposlJjM1Qocz91EYTnzaL0BVXGhKOVR2YfDpDLlqsZELtDXUHQ+vBnDTiT/y0p2rWwg2ziiW6jhLs2Kbz068TEjmIGHXdqgJNFBJ1VhP/16HpLfWWb5OEdRSvUCsezjfWk9nCTpXdXbUQnu7/6iYXx/d8lCxpikrQJjczioP9hRARGBMiOz98TKdYjxeiapSCw2jH80m3R3BdbCqdDOxXI//mjBXzkfiFdgXHANA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ihN2bzF7W5OnKfoSHTrSY3sW9qvl3q7+qrq7YIkGV1U=;
 b=wX43h0Q9JqbyPIdRlAhT2+LZFpwyBzn6eEEHTI9zfsP/U6YgJagBswMvPj2dnZ36BmlCJDvlrbfFw6suEmqIoYufVKBiDRI/tE2SXfgOyLbK+C375YLCghkZdsd+yPq/6kybK8HzThA7q4sP4dgQ6zTr7jRtCySZ3o6U+4LrDps=
Received: from MW4PR03CA0137.namprd03.prod.outlook.com (2603:10b6:303:8c::22)
 by DS0PR12MB9322.namprd12.prod.outlook.com (2603:10b6:8:1bd::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Tue, 22 Sep
 2026 13:51:49 +0000
Received: from SJ1PEPF000037AE.namprd03.prod.outlook.com
 (2603:10b6:303:8c:cafe::36) by MW4PR03CA0137.outlook.office365.com
 (2603:10b6:303:8c::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.13 via Frontend Transport; Tue,
 22 Sep 2026 13:51:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037AE.mail.protection.outlook.com (10.167.244.183) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 13:51:48 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 08:51:45 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 22 Sep 2026 08:51:44 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Frank Min <Frank.Min@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add hdp v8 ip block
Date: Tue, 22 Sep 2026 09:51:30 -0400
Message-ID: <20260922135130.2145721-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922135130.2145721-1-alexander.deucher@amd.com>
References: <20260922135130.2145721-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037AE:EE_|DS0PR12MB9322:EE_
X-MS-Office365-Filtering-Correlation-Id: 4306ca91-4463-49d6-3806-08df18b0a5f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|11063799006|56012099006|10067099003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: U+Y3z35XYad/V2kp+N3jsKjt1mdIXurz5jRg72hQlmcTp6YL3cHxJPOMWHqzSlV3I/O5nE2GqgIMiXHptHVfUkJf42nlXnkqUnAWEbR36Q+MtON50Gbbl1U5eZRtbJhL6wFLcYjBxaeQ179aZfcsHzaep1UNIMzod0uHbIKOW6e143T43KCJekJUQOahXQshbrrv/J97t9J8WH/kJASuQ2xOcKklY3RrFD2lkJ/ll9u0zs0dIzA0qN8+OE+XL+7pMKpWqVKhy2F7lRtedcGwRh4RAADsgbpME1A7b+jNgkU0OgpWMyOPfM/yaZ/NrE8u+CA/ILWh9RkNunlzgiS9uXco7XLqwkQZDmwWgIYOlY0BupPiz8Buhy/RikwePEBAgKiKVagACfznNnXVxgjAOAq2etONAbA4Lf+VcA8Z0NSK/ZZ+m2hLbW+WBnN6nFAy4fzbuMBDiLNk2yZgLgKcbBt+pBeMRY+hDaaa/zdzQtNhQQSGO3RW3RKeeXla1ixcgNBN7es6y/1Toq/RleVErfKsnrWHdyAn3U8O83jyQBlUfftpt/yCM/R7R38qqB6pvwRReZBluN1VxkzT3QUQz2AcrzIs9v5vIsFh/fPlIqQ4TrCAng607YVvSwXXxHmt5cynxoHieodWCGBquv0pKcEtYTN7FwYtEqZyJfA1hAt6kV9eMTAHp5WR5G33bHxvsphPJg36sv6B9nPMCEsjkQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(11063799006)(56012099006)(10067099003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: i5rn3MhIoMMFLou0zHSEtgSMqTD1Ilgjvyh28jN9E/jB6CGjVGMGWl3E0CCMA25GEt6BXh0e5KXzzuNyn+Jl+fKygNlkXWCjlahjoK4KDdCRvP3GfmYxCRq3+/d0xoxJG56bf2ekp/95kr+jcpXIpbKEgFzRkvrGsc9NMAH2rIyGfaCKyBmv3kpBiTQ2VijUb9K24nQrLOZi3H9osdVJwUUeq95H1gj0tHVHswiTlt7f4Xx3kPmi8zBKtSpWzUGezNNky22VyqjB/JmdvtU4bO2ps3zUbNHSvnLI0u5EwN2C9osa80bZtV2B7JI8oJZjGsDHbm6zeAZtbQyyZ8dX2/M11S1+EwPDn0onfyGptf7+wMD1J2eWkA1z2bOFaLZ40bailJNacdsqxGzuW7q/6gh1xUoBzuMWsGr3VXX/XRBJ5dEKEbSYFgxkcAUihDit
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 13:51:48.6397 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4306ca91-4463-49d6-3806-08df18b0a5f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037AE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9322
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

From: Frank Min <Frank.Min@amd.com>

add hdp v8 ip block

Signed-off-by: Frank Min <Frank.Min@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +
 drivers/gpu/drm/amd/amdgpu/hdp_v8_0.c         | 132 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/hdp_v8_0.h         |  31 ++++
 4 files changed, 168 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v8_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/hdp_v8_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index a8a1f65b46156..2ea1924571039 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -92,7 +92,7 @@ amdgpu-y += \
 	sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o \
 	nbio_v7_9.o aqua_vanjaram.o nbio_v7_11.o lsdma_v7_0.o hdp_v7_0.o nbif_v6_3_1.o \
 	cyan_skillfish_reg_init.o soc_v1_0.o lsdma_v7_1.o nbio_v6_3_2.o nbio_v7_11_5.o \
-	nbif_v7_10.o
+	nbif_v7_10.o hdp_v8_0.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index a2c1960a8ad84..564f09c308816 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -73,6 +73,7 @@
 #include "hdp_v5_2.h"
 #include "hdp_v6_0.h"
 #include "hdp_v7_0.h"
+#include "hdp_v8_0.h"
 #include "nv.h"
 #include "soc21.h"
 #include "soc24.h"
@@ -3870,6 +3871,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(7, 0, 0):
 		adev->hdp.funcs = &hdp_v7_0_funcs;
 		break;
+	case IP_VERSION(8, 0, 1):
+		adev->hdp.funcs = &hdp_v8_0_funcs;
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v8_0.c b/drivers/gpu/drm/amd/amdgpu/hdp_v8_0.c
new file mode 100644
index 0000000000000..63afdb5de3d4f
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v8_0.c
@@ -0,0 +1,132 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
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
+#include "hdp_v8_0.h"
+
+#include "hdp/hdp_8_0_1_offset.h"
+#include "hdp/hdp_8_0_1_sh_mask.h"
+#include <uapi/linux/kfd_ioctl.h>
+
+static void hdp_v8_0_update_clock_gating(struct amdgpu_device *adev,
+					 bool enable)
+{
+	uint32_t hdp_clk_cntl, hdp_clk_cntl1;
+	uint32_t hdp_mem_pwr_cntl;
+
+	if (!(adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS |
+				AMD_CG_SUPPORT_HDP_DS |
+				AMD_CG_SUPPORT_HDP_SD)))
+		return;
+
+	hdp_clk_cntl = hdp_clk_cntl1 = RREG32_SOC15(HDP, 0,regHDP_CLK_CNTL);
+	hdp_mem_pwr_cntl = RREG32_SOC15(HDP, 0, regHDP_MEM_POWER_CTRL);
+
+	/* Before doing clock/power mode switch,
+	 * forced on IPH & RC clock */
+	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
+				     RC_MEM_CLK_SOFT_OVERRIDE, 1);
+	WREG32_SOC15(HDP, 0, regHDP_CLK_CNTL, hdp_clk_cntl);
+
+	/* disable clock and power gating before any changing */
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 ATOMIC_MEM_POWER_CTRL_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 ATOMIC_MEM_POWER_LS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 ATOMIC_MEM_POWER_DS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 ATOMIC_MEM_POWER_SD_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_CTRL_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_LS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_DS_EN, 0);
+	hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+					 RC_MEM_POWER_SD_EN, 0);
+	WREG32_SOC15(HDP, 0, regHDP_MEM_POWER_CTRL, hdp_mem_pwr_cntl);
+
+	/* Already disabled above. The actions below are for "enabled" only */
+	if (enable) {
+		/* only one clock gating mode (LS/DS/SD) can be enabled */
+		if (adev->cg_flags & AMD_CG_SUPPORT_HDP_SD) {
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 ATOMIC_MEM_POWER_SD_EN, 1);
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 RC_MEM_POWER_SD_EN, 1);
+		} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_LS) {
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 ATOMIC_MEM_POWER_LS_EN, 1);
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 RC_MEM_POWER_LS_EN, 1);
+		} else if (adev->cg_flags & AMD_CG_SUPPORT_HDP_DS) {
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 ATOMIC_MEM_POWER_DS_EN, 1);
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl,
+							 HDP_MEM_POWER_CTRL,
+							 RC_MEM_POWER_DS_EN, 1);
+		}
+
+		/* confirmed that IPH_MEM_POWER_CTRL_EN and RC_MEM_POWER_CTRL_EN have to
+		 * be set for SRAM LS/DS/SD */
+		if (adev->cg_flags & (AMD_CG_SUPPORT_HDP_LS | AMD_CG_SUPPORT_HDP_DS |
+				      AMD_CG_SUPPORT_HDP_SD)) {
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+							 ATOMIC_MEM_POWER_CTRL_EN, 1);
+			hdp_mem_pwr_cntl = REG_SET_FIELD(hdp_mem_pwr_cntl, HDP_MEM_POWER_CTRL,
+							 RC_MEM_POWER_CTRL_EN, 1);
+			WREG32_SOC15(HDP, 0, regHDP_MEM_POWER_CTRL, hdp_mem_pwr_cntl);
+		}
+	}
+
+	/* disable IPH & RC clock override after clock/power mode changing */
+	hdp_clk_cntl = REG_SET_FIELD(hdp_clk_cntl, HDP_CLK_CNTL,
+				     RC_MEM_CLK_SOFT_OVERRIDE, 0);
+	WREG32_SOC15(HDP, 0, regHDP_CLK_CNTL, hdp_clk_cntl);
+}
+
+static void hdp_v8_0_get_clockgating_state(struct amdgpu_device *adev,
+					    u64 *flags)
+{
+	uint32_t tmp;
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
+const struct amdgpu_hdp_funcs hdp_v8_0_funcs = {
+	.flush_hdp = amdgpu_hdp_generic_flush,
+	.update_clock_gating = hdp_v8_0_update_clock_gating,
+	.get_clock_gating_state = hdp_v8_0_get_clockgating_state,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/hdp_v8_0.h b/drivers/gpu/drm/amd/amdgpu/hdp_v8_0.h
new file mode 100644
index 0000000000000..29ff632d84b5c
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/hdp_v8_0.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright 2025 Advanced Micro Devices, Inc.
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
+#ifndef __HDP_V8_0_H__
+#define __HDP_V8_0_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_hdp_funcs hdp_v8_0_funcs;
+
+#endif
-- 
2.55.0


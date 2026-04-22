Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4082FA1FFC
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 21:42:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 69CE810EA9C;
	Wed, 22 Apr 2026 21:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a6TTGscI";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012035.outbound.protection.outlook.com [52.101.53.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6848910EA8E
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 21:42:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DAQLw0AEpY+rZYN04eytcvtQ8Ut+FSjRaD4rA+kyn1YNk+MbXOxWNswhn7iyI+VFKF8IemjnoQVzKt75ShdypJLH5RIppfQ1C0stnzezWyRHOfRL/CedhaprRAtnMrBuawM9fxW0ZjC4xPwopWUVdauMw3yvsj8hFZ34j4aeGTY9fNuv1jFXse9igjLblFx6wrfIVRlLTZQFK1R+6PNQX8HW/+6KY6UyQ1jz9G7g25eTSExSv7XKSaFbAmOLWU8Mnehvg0CxDMqXCuY/qber7Htf7zKCJM6B9IsM27Ea0INLP1g8bMh9HHzO+ZoOfks/8i2X7GimstCC8IuQcVk9/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vwDKcTO0pSJ3vqgQOQ0Fa/EKBtapEESCCoILjgzEU4o=;
 b=Nyjh+uMgOUhgetKKwSUH/cbk35AKS5p8LF8pkG2M0sUOO9pIzkY60HE0nfPGy5EC07TCxCvgiP1T3eicFAOCuGe7PzeFUMKiMa4UsEEqSyUDhFCNciFoRLDKXY/YsSGcTsjIiKPg+AG7lGALL6KXPMyWbbM4w/lDv48YWZY5CLvJAopVZtC4UEP08n0huUI29bMYiEOQF7TBU11ZOiL7lVWQ3/uJBzxWhjmfAIVM/fIzAyTn4qyMaunEynCOjSkcsU3Fr8AQAg6EQZGSP/HhewJO6Io81ddVUpNSoYUVnmgoEW0iGZbSjqok+A30La6dY8oJxn00PYjlUDFF2TZyVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vwDKcTO0pSJ3vqgQOQ0Fa/EKBtapEESCCoILjgzEU4o=;
 b=a6TTGscIH5aph2UATeMir6PW9HRmWrtOGSfQyVQlDadHMK+lXEEXKHHZD3lDiK6zLeg8DyzSwXlS0jw0lAaXrk+wpmX1JeTtM9NnJgd5MQaH4unN8nga/95OPLa8RMhJ3sn5RGffP+nWPBAIwxjVAwwCsZ7QXMp2TsPpEgHtrs4=
Received: from MN2PR15CA0063.namprd15.prod.outlook.com (2603:10b6:208:237::32)
 by PH7PR12MB5904.namprd12.prod.outlook.com (2603:10b6:510:1d8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.14; Wed, 22 Apr
 2026 21:42:23 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:237:cafe::a6) by MN2PR15CA0063.outlook.office365.com
 (2603:10b6:208:237::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.48 via Frontend Transport; Wed,
 22 Apr 2026 21:42:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 21:42:22 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 16:42:22 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 22 Apr
 2026 14:42:21 -0700
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Wed, 22 Apr 2026 16:42:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Le Ma <le.ma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/4] drm/amdgpu: Add nbio v6_3_2 support
Date: Wed, 22 Apr 2026 17:42:05 -0400
Message-ID: <20260422214207.2241171-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260422214207.2241171-1-alexander.deucher@amd.com>
References: <20260422214207.2241171-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|PH7PR12MB5904:EE_
X-MS-Office365-Filtering-Correlation-Id: de0a5993-be46-4a30-a4c1-08dea0b80963
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|56012099003|18096099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bSeRV7lHvUqOHqI9H5tWT2I0Yi+MvEyfFCn5TfhCrYfcde5WcO4OOvFAgDOP+bZdzamf5/z7qPdsoLQvp15d9PBh2OCP0JWvbaRifhtdEdxVKWep9Sg0bJbHZYhpuhsXfDfARd2zwKizXWa1RsEZuEez/gSv4dRzTgNGXgLa8H/3GZhVuhJTa8b0oKdnbVBrPcPtLLC6E4yrwAm5hCYoXmBul1SRH+UzRtk2kkXMOUiVzBJNVDGWo85hunvcEouKHC42/f9/en68aPJrL/ju8uFXl3VGXJmmcruosGhtkW8waKY+wsP96tpjp0oBMqTuuOoZVbvKYvUK8UCYchrnIi27qF7Ic/06KB8TQDSm9WNMGnW0vwRWzfGo8ZGbIB+9Im84D3fcesq6aetzJ/ekgFD2lfC/QpiBAL4eg2eOJUsK0D4YQchGiL5xxei/WbE3UX07rki21yk1EzJ3VE+cJhIiNxzC3/0ZtdmXb7rVbi3Fdt54bheUDnHbaLIis0b3jd491Fi7gO8H0a5R5gVPhwjoLylsZDq3CUf9Npsy2cJwwDBqi7afLdy9QwsV9uDKuI7PCjuAXAXfOSzlRZUXeCwrhi4TR/GLfuFtOrmYy3lUT12JLj0YFAD2VxHxgp+bUEHCzUlYlxocqEjHbE8s/WlrZSsFQ0BHovERZY04zovn0F6ur+7BK/P/6IqtMe6FWiGOogOnSc4BNpeMllA2IFQFio6zg7xmgnNxLU7QBpKTxy6oYC3ZBNgwjHRgITeNfV8jRydJfqYFvM6/vCCl0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(56012099003)(18096099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W+ZbWlzO6LwbVXKaHsHcbaBs36AIUWic4k9YTM/TtsR97Xw/BkDPq9iTAabCo1ALmkl/F4qKzwl5jdpAfr39V0fepwWLH3mTekjHWnoREIW4dvBhoTRQql5yM9w5CCt9TspAyE5YL3HgyjlCjrn7KhPlFUuAPKmJow6ssWmnKI/N+3xwzqml7a8ZI/U7TCnJQaKfYE4eaNs4BfMGri0bJKo2KnXm6q2xURW+a9R6gd4u3zsTo/TMLS3vo7+t72syDdp8t1KEW8fO/LMWW1xeo4Z+HcmL5YbCPp3OJVTvDpNIKtGykkawYaYQ3Qhhrc3EaW7zgqhV0UNBhZRzYT1Sz2tI9AP4lWnaP/LjDDX2/LmpTlvKCGwXs5Jq8B3xB/frctWExWBmpYT42apvbjg+UTrlbmjufDS6mTAxW3uI0zPnMMAw9W0xyL2fpE5JuDVf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 21:42:22.4778 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de0a5993-be46-4a30-a4c1-08dea0b80963
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5904
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

From: Hawking Zhang <Hawking.Zhang@amd.com>

v6_3_2 is a new nbio generation ip

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Le Ma <le.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |   2 +-
 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c | 168 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.h |  31 +++++
 3 files changed, 200 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index db66c63721999..154a60e22c702 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -90,7 +90,7 @@ amdgpu-y += \
 	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o soc24.o \
 	sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o \
 	nbio_v7_9.o aqua_vanjaram.o nbio_v7_11.o lsdma_v7_0.o hdp_v7_0.o nbif_v6_3_1.o \
-	cyan_skillfish_reg_init.o soc_v1_0.o lsdma_v7_1.o
+	cyan_skillfish_reg_init.o soc_v1_0.o lsdma_v7_1.o nbio_v6_3_2.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c b/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
new file mode 100644
index 0000000000000..c21e5d2fe8397
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.c
@@ -0,0 +1,168 @@
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
+#include "nbio/nbio_6_3_2_offset.h"
+#include "nbio/nbio_6_3_2_sh_mask.h"
+
+#include "amdgpu.h"
+#include "nbio_v6_3_2.h"
+
+static u32 nbio_v6_3_2_get_pcie_index_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_INDEX2);
+}
+
+static u32 nbio_v6_3_2_get_pcie_data_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_DATA2);
+}
+
+static u32 nbio_v6_3_2_get_pcie_index_hi_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX0_PCIE_INDEX2_HI);
+}
+
+static u32 nbio_v6_3_2_get_rev_id(struct amdgpu_device *adev)
+{
+	u32 tmp;
+
+	/* TODO: RCC_STRAP0_RCC_DEV0_EPF0_STRAP0 is not accessible from
+	 * guest side. It requires bootloader to update specific fields
+	 * in ip discovery table to identify soc revision id.
+	 * Return 0 when the function is called from guest side until
+	 * bootloader change is available.
+	 */
+	if (amdgpu_sriov_vf(adev))
+		return 0;
+
+	tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
+	tmp = REG_GET_FIELD(tmp, RCC_STRAP0_RCC_DEV0_EPF0_STRAP0,
+			    STRAP_ATI_REV_ID_DEV0_F0);
+
+	return tmp;
+}
+
+static void nbio_v6_3_2_mc_access_enable(struct amdgpu_device *adev,
+					 bool enable)
+{
+	if (enable)
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN,
+			BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK | BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK);
+	else
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN, 0);
+}
+
+static u32 nbio_v6_3_2_get_memsize(struct amdgpu_device *adev)
+{
+	return RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_RCC_CONFIG_MEMSIZE);
+}
+
+static void nbio_v6_3_2_enable_doorbell_aperture(struct amdgpu_device *adev,
+						 bool enable)
+{
+	/* Enable to allow doorbell pass thru on pre-silicon bare-metal */
+	WREG32_SOC15(NBIO, 0, regGDC0_DOORBELL_ACCESS_EN_PF, 0xfffff);
+	WREG32_FIELD15_PREREG(NBIO, 0, RCC_DEV0_EPF0_RCC_DOORBELL_APER_EN,
+			BIF_DOORBELL_APER_EN, enable ? 1 : 0);
+}
+
+static void nbio_v6_3_2_enable_doorbell_selfring_aperture(struct amdgpu_device *adev,
+							  bool enable)
+{
+	u32 tmp = 0;
+
+	if (enable) {
+		tmp = REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
+				    DOORBELL_SELFRING_GPA_APER_EN, 1) |
+		      REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
+				    DOORBELL_SELFRING_GPA_APER_MODE, 1) |
+		      REG_SET_FIELD(tmp, BIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
+				    DOORBELL_SELFRING_GPA_APER_SIZE, 0);
+
+		WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_LOW,
+			     lower_32_bits(adev->doorbell.base));
+		WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_BASE_HIGH,
+			     upper_32_bits(adev->doorbell.base));
+	}
+
+	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL, tmp);
+}
+
+static void nbio_v6_3_2_enable_doorbell_interrupt(struct amdgpu_device *adev,
+						  bool enable)
+{
+	WREG32_FIELD15_PREREG(NBIO, 0, BIF_BX0_BIF_DOORBELL_INT_CNTL,
+			      DOORBELL_INTERRUPT_DISABLE, enable ? 0 : 1);
+}
+
+static int nbio_v6_3_2_get_compute_partition_mode(struct amdgpu_device *adev)
+{
+	u32 tmp, px;
+
+	tmp = RREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_COMPUTE_STATUS);
+	px = REG_GET_FIELD(tmp, BIF_BX_PF0_PARTITION_COMPUTE_STATUS,
+			   PARTITION_MODE);
+
+	return px;
+}
+
+static bool nbio_v6_3_2_is_nps_switch_requested(struct amdgpu_device *adev)
+{
+	u32 tmp;
+
+	tmp = RREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_MEM_STATUS);
+	tmp = REG_GET_FIELD(tmp, BIF_BX_PF0_PARTITION_MEM_STATUS,
+			    CHANGE_STATUS);
+
+	/* 0x8 - NPS switch requested */
+	return (tmp == 0x8);
+}
+static u32 nbio_v6_3_2_get_memory_partition_mode(struct amdgpu_device *adev,
+						 u32 *supp_modes)
+{
+	u32 tmp;
+
+	tmp = RREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_MEM_STATUS);
+	tmp = REG_GET_FIELD(tmp, BIF_BX_PF0_PARTITION_MEM_STATUS, NPS_MODE);
+
+	if (supp_modes) {
+		*supp_modes =
+			RREG32_SOC15(NBIO, 0, regBIF_BX_PF0_PARTITION_MEM_CAP);
+	}
+
+	return ffs(tmp);
+}
+
+const struct amdgpu_nbio_funcs nbio_v6_3_2_funcs = {
+	.get_pcie_index_offset = nbio_v6_3_2_get_pcie_index_offset,
+	.get_pcie_data_offset = nbio_v6_3_2_get_pcie_data_offset,
+	.get_pcie_index_hi_offset = nbio_v6_3_2_get_pcie_index_hi_offset,
+	.get_rev_id = nbio_v6_3_2_get_rev_id,
+	.mc_access_enable = nbio_v6_3_2_mc_access_enable,
+	.get_memsize = nbio_v6_3_2_get_memsize,
+	.enable_doorbell_aperture = nbio_v6_3_2_enable_doorbell_aperture,
+	.enable_doorbell_selfring_aperture = nbio_v6_3_2_enable_doorbell_selfring_aperture,
+	.enable_doorbell_interrupt = nbio_v6_3_2_enable_doorbell_interrupt,
+	.get_compute_partition_mode = nbio_v6_3_2_get_compute_partition_mode,
+	.get_memory_partition_mode = nbio_v6_3_2_get_memory_partition_mode,
+	.is_nps_switch_requested = nbio_v6_3_2_is_nps_switch_requested,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.h b/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.h
new file mode 100644
index 0000000000000..bc7f747c88f47
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v6_3_2.h
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
+#ifndef __NBIO_V6_3_2_H__
+#define __NBIO_V6_3_2_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_nbio_funcs nbio_v6_3_2_funcs;
+
+#endif
-- 
2.53.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 916BBC54E41
	for <amd-gfx@archiver.kernel.org>; Tue,  5 Mar 2024 19:46:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0EEE110EA20;
	Tue,  5 Mar 2024 19:46:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2mUssZAg";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2053.outbound.protection.outlook.com [40.107.93.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FFBC10EA20
 for <amd-gfx@lists.freedesktop.org>; Tue,  5 Mar 2024 19:46:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVluWMdn5IeWCeB1H9+WhAaYTHsSscoZMFP3DedLC3KpL6xYFE/VTbqydkZMEEpsuGWP+0jOkeaSUxR6rkDl2MC11QD++ABpb4TBgrbR0uWY0DWlAo+InAWNA8Le2NUX+wxdHgfbC7FZ6IzHS1q4+vx4b/QRU9sfmBuR0Wrcl6Niu5GBvKYcEW2dAaGcaH3oQOt3zTaTDfLhqCsM6p9i4y368rNAfx6DlKrIzxBTt7wf8TS8HjDnXkVjfMb4xAJrUXdA6nQ4G7CWkormMKBhHUzJYBFnXKIYksGtdNZtTMDndkG5Di20r99vugEfxQMUG4uM80O0hPQXJf37o4S7/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Qu1dojA4hpKwxSMTpYmPKH/nWMnMymWRGPta/HI2yY=;
 b=OCYVU1J4FYy2IvLmfEdRa9x0K7Ve2Az2ocYug7Pzzm3b249rem+pKuWwAVADhTwXHam222iVGWwBng9ZA3kiRoniGkoHBmpMtOnVnEnjM9ZT+l3OoWEVtxXy02PG94+9KEtK9mrHlBqSNPXH8h3XiP7FXTqr69waW+FSLuPJxZSGo7G5oCVQ6yUGHaT6uAfjA5zr8LoS2ldWzBhrZOTiYreOXxTTDo5jfKOyihy4UYUClVW+8ATCgnslGpqs/T08ftSrANeiApxrXvv2283le2VKs9A1aj3huGF85FClnxEBMfDmRD8GN7WQ4rC0ftvp/yLeh3XLpt3jDa1Od/Bnzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Qu1dojA4hpKwxSMTpYmPKH/nWMnMymWRGPta/HI2yY=;
 b=2mUssZAgoyW2J6QyxH5C96jO96ymDz7wrEeRy+/A1DM9AjnGWoiCZRUgDc6W7o5+TEU2GoAYODizAbNlY0WdtmMr+6mAFGr9sfLewSmbVSo2pIo48n+/lI64UVyPbvfktmR9hJXmXnS0vDHJDjnEfEa7sv4c3UqGfqqOXmXHaw4=
Received: from BLAPR03CA0127.namprd03.prod.outlook.com (2603:10b6:208:32e::12)
 by CH3PR12MB8331.namprd12.prod.outlook.com (2603:10b6:610:12f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Tue, 5 Mar
 2024 19:46:44 +0000
Received: from BL6PEPF0001AB4F.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::eb) by BLAPR03CA0127.outlook.office365.com
 (2603:10b6:208:32e::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24 via Frontend
 Transport; Tue, 5 Mar 2024 19:46:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4F.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Tue, 5 Mar 2024 19:46:44 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 5 Mar
 2024 13:46:43 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Likun Gao <Likun.Gao@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Add nbif v6_3_1 ip block support
Date: Tue, 5 Mar 2024 14:46:25 -0500
Message-ID: <20240305194626.1783473-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4F:EE_|CH3PR12MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f2b47e-b875-4a1d-a7ba-08dc3d4cfcc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CG3+JrLKhxwtcMiWdv3EJbfFFoiyPelRI5fcYQGtF/ejAcZzoJ+j+QmGDxs6le9EBRtHvpF8xrtdI5n6kFmmChoj1gayfynfBINDfYAoGLLE3uJJBkGxdxkKlm3Q0GRJ4/JZC1TtNuQyZRFt6fkI9/JfKDM5VZSXrRUoCRvTvQtFl0k4KLasm6s8qle+JLQ3zgoyLyBxGkARGP4RYQJwdg9qCug5+TtTV1LNtiuDSt/J8P+DpG6PiG6B5ZY4U/808l7zq5QxOalC19KIlHAQOe5fb9XLx38i+wdANew2zO2H04YKzIfieQRkxSGCS9OJ2vpUAT3mONNywBbfMSHdXuM1iHiTKkvBQBqwHUFufN3xyOhFYU3MxTTrbgBgOpDaIdVpJguZpvuJnHwbeWd9SKzMSNZLoZJNzofse434ph3n16EQFecsafRzKnnFOLKMgSDBMDHZ2K0f/s4ZYkcXFPhMvwLjS0UPzy1PaWJj1v+fThuMgWv951+ggJ8gtF/ukSS49yMw7GRg4DHBmpa1pZUmaNroMKlf/g+IWCq63lPiZWDHnZyuDH6iqemEvhAdgCOnbBe3TvOuQK2llyPRs1b22Cl35OKGC388zP618Ykv2oXvDpsZLylMscSdJPg5CssY62iYprwYaomIytg9dinzuKtEjKaeulrWcUVxZeRUk6uzt8yJKNX8HMwFS0JfFv5PI0w4Jc3NZJkHZh5We9Us34iJZBHT9RoRKfT1ANEkRm17exaF7Szl4S2ERMxk
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(82310400014); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 19:46:44.6592 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f2b47e-b875-4a1d-a7ba-08dc3d4cfcc0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8331
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

Add nbif v6_3_1 ip block support.

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |   2 +-
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c | 495 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.h |  33 ++
 3 files changed, 529 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index fa26a4e3a99d3..4536c8ad0e117 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -98,7 +98,7 @@ amdgpu-y += \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o arct_reg_init.o mxgpu_nv.o \
 	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o \
 	sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o \
-	nbio_v7_9.o aqua_vanjaram.o nbio_v7_11.o lsdma_v7_0.o hdp_v7_0.o
+	nbio_v7_9.o aqua_vanjaram.o nbio_v7_11.o lsdma_v7_0.o hdp_v7_0.o nbif_v6_3_1.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
new file mode 100644
index 0000000000000..96ed00ac81acf
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.c
@@ -0,0 +1,495 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+#include "nbif_v6_3_1.h"
+
+#include "nbif/nbif_6_3_1_offset.h"
+#include "nbif/nbif_6_3_1_sh_mask.h"
+#include "pcie/pcie_6_1_0_offset.h"
+#include "pcie/pcie_6_1_0_sh_mask.h"
+#include <uapi/linux/kfd_ioctl.h>
+
+static void nbif_v6_3_1_remap_hdp_registers(struct amdgpu_device *adev)
+{
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
+		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
+		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+}
+
+static u32 nbif_v6_3_1_get_rev_id(struct amdgpu_device *adev)
+{
+	u32 tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
+
+	tmp &= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
+	tmp >>= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
+
+	return tmp;
+}
+
+static void nbif_v6_3_1_mc_access_enable(struct amdgpu_device *adev, bool enable)
+{
+	if (enable)
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN,
+			     BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK |
+			     BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK);
+	else
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN, 0);
+}
+
+static u32 nbif_v6_3_1_get_memsize(struct amdgpu_device *adev)
+{
+	return RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_RCC_CONFIG_MEMSIZE);
+}
+
+static void nbif_v6_3_1_sdma_doorbell_range(struct amdgpu_device *adev,
+					    int instance, bool use_doorbell,
+					    int doorbell_index,
+					    int doorbell_size)
+{
+	if (instance == 0) {
+		u32 doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL);
+
+		if (use_doorbell) {
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+						       S2A_DOORBELL_PORT2_ENABLE,
+						       0x1);
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+						       S2A_DOORBELL_PORT2_AWID,
+						       0xe);
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+						       S2A_DOORBELL_PORT2_RANGE_OFFSET,
+						       doorbell_index);
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+						       S2A_DOORBELL_PORT2_RANGE_SIZE,
+						       doorbell_size);
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+						       S2A_DOORBELL_PORT2_AWADDR_31_28_VALUE,
+						       0x3);
+		} else
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL,
+						       S2A_DOORBELL_PORT2_RANGE_SIZE,
+						       0);
+
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_2_CTRL, doorbell_range);
+	}
+}
+
+static void nbif_v6_3_1_vcn_doorbell_range(struct amdgpu_device *adev,
+					   bool use_doorbell, int doorbell_index,
+					   int instance)
+{
+	u32 doorbell_range;
+
+	if (instance)
+		doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL);
+	else
+		doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL);
+
+	if (use_doorbell) {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
+					       S2A_DOORBELL_PORT4_ENABLE,
+					       0x1);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
+					       S2A_DOORBELL_PORT4_AWID,
+					       instance ? 0x7 : 0x4);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
+					       S2A_DOORBELL_PORT4_RANGE_OFFSET,
+					       doorbell_index);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
+					       S2A_DOORBELL_PORT4_RANGE_SIZE,
+					       8);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
+					       S2A_DOORBELL_PORT4_AWADDR_31_28_VALUE,
+					       instance ? 0x7 : 0x4);
+	} else
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
+					       S2A_DOORBELL_PORT4_RANGE_SIZE,
+					       0);
+
+	if (instance)
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_5_CTRL, doorbell_range);
+	else
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL, doorbell_range);
+}
+
+static void nbif_v6_3_1_gc_doorbell_init(struct amdgpu_device *adev)
+{
+	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL, 0x30000007);
+	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL, 0x3000000d);
+}
+
+static void nbif_v6_3_1_enable_doorbell_aperture(struct amdgpu_device *adev,
+						 bool enable)
+{
+	WREG32_FIELD15_PREREG(NBIO, 0, RCC_DEV0_EPF0_RCC_DOORBELL_APER_EN,
+			BIF_DOORBELL_APER_EN, enable ? 1 : 0);
+}
+
+static void
+nbif_v6_3_1_enable_doorbell_selfring_aperture(struct amdgpu_device *adev,
+					      bool enable)
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
+static void nbif_v6_3_1_ih_doorbell_range(struct amdgpu_device *adev,
+					  bool use_doorbell, int doorbell_index)
+{
+	u32 ih_doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL);
+
+	if (use_doorbell) {
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_ENABLE,
+						  0x1);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_AWID,
+						  0x0);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_RANGE_OFFSET,
+						  doorbell_index);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_RANGE_SIZE,
+						  2);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
+						  0x0);
+	} else
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_RANGE_SIZE,
+						  0);
+
+	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL, ih_doorbell_range);
+}
+
+static void nbif_v6_3_1_ih_control(struct amdgpu_device *adev)
+{
+	u32 interrupt_cntl;
+
+	/* setup interrupt control */
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL2, adev->dummy_page_addr >> 8);
+
+	interrupt_cntl = RREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL);
+	/*
+	 * BIF_BX0_INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=0 - dummy read disabled with msi, enabled without msi
+	 * BIF_BX0_INTERRUPT_CNTL__IH_DUMMY_RD_OVERRIDE_MASK=1 - dummy read controlled by IH_DUMMY_RD_EN
+	 */
+	interrupt_cntl = REG_SET_FIELD(interrupt_cntl, BIF_BX0_INTERRUPT_CNTL,
+				       IH_DUMMY_RD_OVERRIDE, 0);
+
+	/* BIF_BX0_INTERRUPT_CNTL__IH_REQ_NONSNOOP_EN_MASK=1 if ring is in non-cacheable memory, e.g., vram */
+	interrupt_cntl = REG_SET_FIELD(interrupt_cntl, BIF_BX0_INTERRUPT_CNTL,
+				       IH_REQ_NONSNOOP_EN, 0);
+
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_INTERRUPT_CNTL, interrupt_cntl);
+}
+
+static void
+nbif_v6_3_1_update_medium_grain_clock_gating(struct amdgpu_device *adev,
+					     bool enable)
+{
+}
+
+static void
+nbif_v6_3_1_update_medium_grain_light_sleep(struct amdgpu_device *adev,
+					    bool enable)
+{
+}
+
+static void
+nbif_v6_3_1_get_clockgating_state(struct amdgpu_device *adev,
+				  u64 *flags)
+{
+}
+
+static u32 nbif_v6_3_1_get_hdp_flush_req_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_REQ);
+}
+
+static u32 nbif_v6_3_1_get_hdp_flush_done_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_DONE);
+}
+
+static u32 nbif_v6_3_1_get_pcie_index_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_INDEX);
+}
+
+static u32 nbif_v6_3_1_get_pcie_data_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_DATA);
+}
+
+const struct nbio_hdp_flush_reg nbif_v6_3_1_hdp_flush_reg = {
+	.ref_and_mask_cp0 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP0_MASK,
+	.ref_and_mask_cp1 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP1_MASK,
+	.ref_and_mask_cp2 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP2_MASK,
+	.ref_and_mask_cp3 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP3_MASK,
+	.ref_and_mask_cp4 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP4_MASK,
+	.ref_and_mask_cp5 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP5_MASK,
+	.ref_and_mask_cp6 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP6_MASK,
+	.ref_and_mask_cp7 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP7_MASK,
+	.ref_and_mask_cp8 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP8_MASK,
+	.ref_and_mask_cp9 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__CP9_MASK,
+	.ref_and_mask_sdma0 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__SDMA0_MASK,
+	.ref_and_mask_sdma1 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__SDMA1_MASK,
+};
+
+static void nbif_v6_3_1_init_registers(struct amdgpu_device *adev)
+{
+	uint32_t data;
+
+	data = RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2);
+	data &= ~RCC_DEV0_EPF2_STRAP2__STRAP_NO_SOFT_RESET_DEV0_F2_MASK;
+	WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2, data);
+}
+
+static u32 nbif_v6_3_1_get_rom_offset(struct amdgpu_device *adev)
+{
+	u32 data, rom_offset;
+
+	data = RREG32_SOC15(NBIO, 0, regREGS_ROM_OFFSET_CTRL);
+	rom_offset = REG_GET_FIELD(data, REGS_ROM_OFFSET_CTRL, ROM_OFFSET);
+
+	return rom_offset;
+}
+
+#ifdef CONFIG_PCIEASPM
+static void nbif_v6_3_1_program_ltr(struct amdgpu_device *adev)
+{
+	uint32_t def, data;
+
+	def = RREG32_SOC15(NBIO, 0, regRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL);
+	data = 0x35EB;
+	data &= ~RCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL__LTR_PRIV_MSG_DIS_IN_PM_NON_D0_MASK;
+	data &= ~RCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL__LTR_PRIV_RST_LTR_IN_DL_DOWN_MASK;
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regRCC_EP_DEV0_0_EP_PCIE_TX_LTR_CNTL, data);
+
+	def = data = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP2);
+	data &= ~RCC_STRAP0_RCC_BIF_STRAP2__STRAP_LTR_IN_ASPML1_DIS_MASK;
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP2, data);
+
+	def = data = RREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_DEVICE_CNTL2);
+	if (adev->pdev->ltr_path)
+		data |= BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
+	else
+		data &= ~BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_DEVICE_CNTL2, data);
+}
+#endif
+
+static void nbif_v6_3_1_program_aspm(struct amdgpu_device *adev)
+{
+#ifdef CONFIG_PCIEASPM
+	uint32_t def, data;
+
+	def = data = RREG32_SOC15(PCIE, 0, regPCIE_LC_CNTL);
+	data &= ~PCIE_LC_CNTL__LC_L1_INACTIVITY_MASK;
+	data &= ~PCIE_LC_CNTL__LC_L0S_INACTIVITY_MASK;
+	data |= PCIE_LC_CNTL__LC_PMI_TO_L1_DIS_MASK;
+	if (def != data)
+		WREG32_SOC15(PCIE, 0, regPCIE_LC_CNTL, data);
+
+	def = data = RREG32_SOC15(PCIE, 0, regPCIE_LC_CNTL7);
+	data |= PCIE_LC_CNTL7__LC_NBIF_ASPM_INPUT_EN_MASK;
+	if (def != data)
+		WREG32_SOC15(PCIE, 0, regPCIE_LC_CNTL7, data);
+
+	def = data = RREG32_SOC15(PCIE, 0, regPCIE_LC_CNTL3);
+	data |= PCIE_LC_CNTL3__LC_DSC_DONT_ENTER_L23_AFTER_PME_ACK_MASK;
+	if (def != data)
+		WREG32_SOC15(PCIE, 0, regPCIE_LC_CNTL3, data);
+
+	def = data = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP3);
+	data &= ~RCC_STRAP0_RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER_MASK;
+	data &= ~RCC_STRAP0_RCC_BIF_STRAP3__STRAP_VLINK_PM_L1_ENTRY_TIMER_MASK;
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP3, data);
+
+	def = data = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP5);
+	data &= ~RCC_STRAP0_RCC_BIF_STRAP5__STRAP_VLINK_LDN_ENTRY_TIMER_MASK;
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP5, data);
+
+	def = data = RREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_DEVICE_CNTL2);
+	data &= ~BIF_CFG_DEV0_EPF0_DEVICE_CNTL2__LTR_EN_MASK;
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_DEVICE_CNTL2, data);
+
+	WREG32_SOC15(NBIO, 0, regBIF_CFG_DEV0_EPF0_PCIE_LTR_CAP, 0x10011001);
+
+#if 0
+	/* regPSWUSP0_PCIE_LC_CNTL2 should be replace by PCIE_LC_CNTL2 or someone else ? */
+	def = data = RREG32_SOC15(NBIO, 0, regPSWUSP0_PCIE_LC_CNTL2);
+	data |= PSWUSP0_PCIE_LC_CNTL2__LC_ALLOW_PDWN_IN_L1_MASK |
+		PSWUSP0_PCIE_LC_CNTL2__LC_ALLOW_PDWN_IN_L23_MASK;
+	data &= ~PSWUSP0_PCIE_LC_CNTL2__LC_RCV_L0_TO_RCV_L0S_DIS_MASK;
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regPSWUSP0_PCIE_LC_CNTL2, data);
+#endif
+	def = data = RREG32_SOC15(PCIE, 0, regPCIE_LC_CNTL4);
+	data |= PCIE_LC_CNTL4__LC_L1_POWERDOWN_MASK;
+	if (def != data)
+		WREG32_SOC15(PCIE, 0, regPCIE_LC_CNTL4, data);
+
+	def = data = RREG32_SOC15(PCIE, 0, regPCIE_LC_RXRECOVER_RXSTANDBY_CNTL);
+	data |= PCIE_LC_RXRECOVER_RXSTANDBY_CNTL__LC_RX_L0S_STANDBY_EN_MASK;
+	if (def != data)
+		WREG32_SOC15(PCIE, 0, regPCIE_LC_RXRECOVER_RXSTANDBY_CNTL, data);
+
+	nbif_v6_3_1_program_ltr(adev);
+
+	def = data = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP3);
+	data |= 0x5DE0 << RCC_STRAP0_RCC_BIF_STRAP3__STRAP_VLINK_ASPM_IDLE_TIMER__SHIFT;
+	data |= 0x0010 << RCC_STRAP0_RCC_BIF_STRAP3__STRAP_VLINK_PM_L1_ENTRY_TIMER__SHIFT;
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP3, data);
+
+	def = data = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP5);
+	data |= 0x0010 << RCC_STRAP0_RCC_BIF_STRAP5__STRAP_VLINK_LDN_ENTRY_TIMER__SHIFT;
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_BIF_STRAP5, data);
+
+	def = data = RREG32_SOC15(PCIE, 0, regPCIE_LC_CNTL);
+	data |= 0x0 << PCIE_LC_CNTL__LC_L0S_INACTIVITY__SHIFT;
+	data |= 0x9 << PCIE_LC_CNTL__LC_L1_INACTIVITY__SHIFT;
+	data &= ~PCIE_LC_CNTL__LC_PMI_TO_L1_DIS_MASK;
+	if (def != data)
+		WREG32_SOC15(PCIE, 0, regPCIE_LC_CNTL, data);
+
+	def = data = RREG32_SOC15(PCIE, 0, regPCIE_LC_CNTL3);
+	data &= ~PCIE_LC_CNTL3__LC_DSC_DONT_ENTER_L23_AFTER_PME_ACK_MASK;
+	if (def != data)
+		WREG32_SOC15(PCIE, 0, regPCIE_LC_CNTL3, data);
+#endif
+}
+
+const struct amdgpu_nbio_funcs nbif_v6_3_1_funcs = {
+	.get_hdp_flush_req_offset = nbif_v6_3_1_get_hdp_flush_req_offset,
+	.get_hdp_flush_done_offset = nbif_v6_3_1_get_hdp_flush_done_offset,
+	.get_pcie_index_offset = nbif_v6_3_1_get_pcie_index_offset,
+	.get_pcie_data_offset = nbif_v6_3_1_get_pcie_data_offset,
+	.get_rev_id = nbif_v6_3_1_get_rev_id,
+	.mc_access_enable = nbif_v6_3_1_mc_access_enable,
+	.get_memsize = nbif_v6_3_1_get_memsize,
+	.sdma_doorbell_range = nbif_v6_3_1_sdma_doorbell_range,
+	.vcn_doorbell_range = nbif_v6_3_1_vcn_doorbell_range,
+	.gc_doorbell_init = nbif_v6_3_1_gc_doorbell_init,
+	.enable_doorbell_aperture = nbif_v6_3_1_enable_doorbell_aperture,
+	.enable_doorbell_selfring_aperture = nbif_v6_3_1_enable_doorbell_selfring_aperture,
+	.ih_doorbell_range = nbif_v6_3_1_ih_doorbell_range,
+	.update_medium_grain_clock_gating = nbif_v6_3_1_update_medium_grain_clock_gating,
+	.update_medium_grain_light_sleep = nbif_v6_3_1_update_medium_grain_light_sleep,
+	.get_clockgating_state = nbif_v6_3_1_get_clockgating_state,
+	.ih_control = nbif_v6_3_1_ih_control,
+	.init_registers = nbif_v6_3_1_init_registers,
+	.remap_hdp_registers = nbif_v6_3_1_remap_hdp_registers,
+	.get_rom_offset = nbif_v6_3_1_get_rom_offset,
+	.program_aspm = nbif_v6_3_1_program_aspm,
+};
+
+
+static void nbif_v6_3_1_sriov_ih_doorbell_range(struct amdgpu_device *adev,
+						bool use_doorbell, int doorbell_index)
+{
+}
+
+static void nbif_v6_3_1_sriov_sdma_doorbell_range(struct amdgpu_device *adev,
+						  int instance, bool use_doorbell,
+						  int doorbell_index,
+						  int doorbell_size)
+{
+}
+
+static void nbif_v6_3_1_sriov_vcn_doorbell_range(struct amdgpu_device *adev,
+						 bool use_doorbell,
+						 int doorbell_index, int instance)
+{
+}
+
+static void nbif_v6_3_1_sriov_gc_doorbell_init(struct amdgpu_device *adev)
+{
+}
+
+const struct amdgpu_nbio_funcs nbif_v6_3_1_sriov_funcs = {
+	.get_hdp_flush_req_offset = nbif_v6_3_1_get_hdp_flush_req_offset,
+	.get_hdp_flush_done_offset = nbif_v6_3_1_get_hdp_flush_done_offset,
+	.get_pcie_index_offset = nbif_v6_3_1_get_pcie_index_offset,
+	.get_pcie_data_offset = nbif_v6_3_1_get_pcie_data_offset,
+	.get_rev_id = nbif_v6_3_1_get_rev_id,
+	.mc_access_enable = nbif_v6_3_1_mc_access_enable,
+	.get_memsize = nbif_v6_3_1_get_memsize,
+	.sdma_doorbell_range = nbif_v6_3_1_sriov_sdma_doorbell_range,
+	.vcn_doorbell_range = nbif_v6_3_1_sriov_vcn_doorbell_range,
+	.gc_doorbell_init = nbif_v6_3_1_sriov_gc_doorbell_init,
+	.enable_doorbell_aperture = nbif_v6_3_1_enable_doorbell_aperture,
+	.enable_doorbell_selfring_aperture = nbif_v6_3_1_enable_doorbell_selfring_aperture,
+	.ih_doorbell_range = nbif_v6_3_1_sriov_ih_doorbell_range,
+	.update_medium_grain_clock_gating = nbif_v6_3_1_update_medium_grain_clock_gating,
+	.update_medium_grain_light_sleep = nbif_v6_3_1_update_medium_grain_light_sleep,
+	.get_clockgating_state = nbif_v6_3_1_get_clockgating_state,
+	.ih_control = nbif_v6_3_1_ih_control,
+	.init_registers = nbif_v6_3_1_init_registers,
+	.remap_hdp_registers = nbif_v6_3_1_remap_hdp_registers,
+	.get_rom_offset = nbif_v6_3_1_get_rom_offset,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.h b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.h
new file mode 100644
index 0000000000000..b7f2e0d88905d
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v6_3_1.h
@@ -0,0 +1,33 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+#ifndef __NBIO_V6_3_1_H__
+#define __NBIO_V6_3_1_H__
+
+#include "soc15_common.h"
+
+extern const struct nbio_hdp_flush_reg nbif_v6_3_1_hdp_flush_reg;
+extern const struct amdgpu_nbio_funcs nbif_v6_3_1_funcs;
+extern const struct amdgpu_nbio_funcs nbif_v6_3_1_sriov_funcs;
+
+#endif
-- 
2.44.0


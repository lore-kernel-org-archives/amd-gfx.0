Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14A71C433F5
	for <amd-gfx@archiver.kernel.org>; Wed, 27 Apr 2022 15:16:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D60C10F532;
	Wed, 27 Apr 2022 15:16:56 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2044.outbound.protection.outlook.com [40.107.94.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A0D610F52E
 for <amd-gfx@lists.freedesktop.org>; Wed, 27 Apr 2022 15:16:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RVt07cJ6jAazYV5ICz3vHWJyaRIAKFKOfjO60PpuAdRdVvlHhhSAMtQhQ+nagZL/i54jIn3AiEZbnn1sV9A2xjHznz6bUCP/iSFv70VrpI34BGnqJqpKrtjbHtozImM+V1cBl9y/+MlGN60xgbciwWNTRpbYHARWuxrRYSl7+43ftAcUohgF5pJuPDxeb5GbJ/TYPT4DmJjkQms8wcaFTonFwz6grkLO0kv84P9CnaZYJd6Or3Plg2d67Yh7unyxS8tz2fHrDl0Nx5WNkRkau8cTaZLwtK+j02bmEgODP7UTFt1ujo+qi084HL9eKqELXGOczSiruVsOW0BMV6byMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z0KATsor3GicVIvE7al3+WTI/uX1L4nxXspwUiTSftg=;
 b=Dh4LyjSDFIe5KTpSbT2SHAfAWaM+bU1TDZ4CkHI+b8zoBlm3Lqj06CNA0qLWXHblvN/pdJuvF4F6mvTtpCmsviWXM7NGHlYSGcQ5x5VXKshZhhok/9U+0WSCqTjij9obdi0gFNzywep7QAJqcs5CssMVNbnNgbyT1JXe3z21nHd8+u66HSIVT6msbbB9HUtQQmerG2RGa+Vh8ARg27fW7/btZ8yUZEpzATBdFVXayohPFkqII8JSeveMcGYl20oFba/wRJiJdyF8vaowpOQMI3lbWa66FyFPlyeNxP3IILzBLPZ3EtDcTEfzZtE3bkcNvffkykLbWxJeur/70MvC9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z0KATsor3GicVIvE7al3+WTI/uX1L4nxXspwUiTSftg=;
 b=A47dMmJSJuXdvvVQeyoUMB28vbT9PR1gIMS9J4nCUOodC7g2fTaYtopzR+0V9/REHSpDh4IbQTOfVsO4uBkl/3rQzHLv9SmrumajMlFuqyIWkEZb1sGwhZAJSZoNszNgf6IDjlqpEK54CqXbPy32rfK6vJYV/Z6HP6SMnuO4BNQ=
Received: from MW4PR04CA0325.namprd04.prod.outlook.com (2603:10b6:303:82::30)
 by SN1PR12MB2431.namprd12.prod.outlook.com (2603:10b6:802:27::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Wed, 27 Apr
 2022 15:16:52 +0000
Received: from CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:82:cafe::82) by MW4PR04CA0325.outlook.office365.com
 (2603:10b6:303:82::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Wed, 27 Apr 2022 15:16:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT022.mail.protection.outlook.com (10.13.175.199) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Wed, 27 Apr 2022 15:16:51 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 10:16:50 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 2/3] drm/amdgpu: add nbio v4_3_0 ip block v2
Date: Wed, 27 Apr 2022 11:16:35 -0400
Message-ID: <20220427151636.3104955-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220427151636.3104955-1-alexander.deucher@amd.com>
References: <20220427151636.3104955-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a7f2a3af-e3c6-4d17-2076-08da2860f529
X-MS-TrafficTypeDiagnostic: SN1PR12MB2431:EE_
X-Microsoft-Antispam-PRVS: <SN1PR12MB24311392EE1EF50C4F6FCDF4F7FA9@SN1PR12MB2431.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HLXW3eSpcHudMWn6oNjShCsBYgd9xminh6bbkkYHBMe/LHR6G3Q80Zedqff/GuxPJpzNDFEJq7ijzsrLyIRZ7sVyoCkBuJ8HZDjrpbQSoWvJ0Jv4pAcLEk4Xy2GzpfMZ/J/z8xKzpTM8WMS6TOG9YZmJISkHbrpKvqtSFsAfoleLEHoSi+j0nbfwCRX1zr8tyJAts9mqx6vrurQWpUiG7e+KthPeS6zToq5BlrNPQFEWILZYwalTlTn1qG/OWcJpiedKhhX9QteQO+vyBiGNQSwwmYt45duOF4xk2WlKUApsddaSyN4iHGjMF6OAMUzihd22mEBKGO8bgMvbpaVw67dCodKDs6u5rl23AqvzvgnsZzfH+uGwpC0tPpXFPLUP5z8nV4NhOJQ+Kep0SI8LNkwL7yS1vjrfPUOTOlQvlG6MvntmAbBxbwbCpDJAyyUPGY8bq5eKv4VeT+3FzwNEYhXAAnPWldLyyy83VFSwO7p4b+viWWZfEuD0zO6IY9nFUB91hFF5I2CbExx0YlikD3ufQnhp9hyXl82YFHnhZxNiwjUackNvVv4UnBGYdn8LXRAy0TETouvZE47ZmS+L0qkTg2Fgd3/wu2ZZynmMG9WxUULGORf2VEnPY8PQBQSxTaogw2Ru3pHnjh8IgLEWxpHqU7s+UTV0hSiWGrb3aSm3JGlKh79+oPv4Gn0XCgS8cdQROQaxdCg1rI0J773lSQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(426003)(508600001)(2616005)(336012)(81166007)(8936002)(16526019)(186003)(86362001)(47076005)(26005)(7696005)(6666004)(30864003)(2906002)(82310400005)(356005)(83380400001)(40460700003)(1076003)(36860700001)(5660300002)(6916009)(316002)(8676002)(4326008)(54906003)(36756003)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2022 15:16:51.9556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f2a3af-e3c6-4d17-2076-08da2860f529
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN1PR12MB2431
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 "Stanley.Yang" <Stanley.Yang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Stanley.Yang" <Stanley.Yang@amd.com>

This adds nbio v4_3_0 ip block support

Changed from v1:
use WREG32_SOC15/RREG32_SOC15 instead of
WREG32_PCIE/RREG32_PCIE
remove the programming of PCIE_CONFIG_CNTL

Signed-off-by: Stanley.Yang <Stanley.Yang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile      |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h |   1 +
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c   | 368 +++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h   |  32 ++
 4 files changed, 403 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 2b454e7d7a76..313af306687b 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -74,7 +74,8 @@ amdgpu-$(CONFIG_DRM_AMDGPU_SI)+= si.o gmc_v6_0.o gfx_v6_0.o si_ih.o si_dma.o dce
 amdgpu-y += \
 	vi.o mxgpu_vi.o nbio_v6_1.o soc15.o emu_soc.o mxgpu_ai.o nbio_v7_0.o vega10_reg_init.o \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o arct_reg_init.o mxgpu_nv.o \
-	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o
+	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o \
+	nbio_v4_3.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
index ccd9fe96fab7..a240336bbc6b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_nbio.h
@@ -70,6 +70,7 @@ struct amdgpu_nbio_funcs {
 			bool use_doorbell, int doorbell_index, int doorbell_size);
 	void (*vcn_doorbell_range)(struct amdgpu_device *adev, bool use_doorbell,
 				   int doorbell_index, int instance);
+	void (*gc_doorbell_init)(struct amdgpu_device *adev);
 	void (*enable_doorbell_aperture)(struct amdgpu_device *adev,
 					 bool enable);
 	void (*enable_doorbell_selfring_aperture)(struct amdgpu_device *adev,
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
new file mode 100644
index 000000000000..ed31d133f07a
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.c
@@ -0,0 +1,368 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
+#include "nbio_v4_3.h"
+
+#include "nbio/nbio_4_3_0_offset.h"
+#include "nbio/nbio_4_3_0_sh_mask.h"
+#include <uapi/linux/kfd_ioctl.h>
+
+static void nbio_v4_3_remap_hdp_registers(struct amdgpu_device *adev)
+{
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
+		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
+		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+}
+
+static u32 nbio_v4_3_get_rev_id(struct amdgpu_device *adev)
+{
+	u32 tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
+
+	tmp &= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
+	tmp >>= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
+
+	return tmp;
+}
+
+static void nbio_v4_3_mc_access_enable(struct amdgpu_device *adev, bool enable)
+{
+	if (enable)
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN,
+			     BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK |
+			     BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK);
+	else
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN, 0);
+}
+
+static u32 nbio_v4_3_get_memsize(struct amdgpu_device *adev)
+{
+	return RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_RCC_CONFIG_MEMSIZE);
+}
+
+static void nbio_v4_3_sdma_doorbell_range(struct amdgpu_device *adev, int instance,
+					  bool use_doorbell, int doorbell_index,
+					  int doorbell_size)
+{
+	if (instance == 0) {
+		u32 doorbell_range = RREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_2_CTRL);
+
+		if (use_doorbell) {
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       S2A_DOORBELL_ENTRY_2_CTRL,
+						       S2A_DOORBELL_PORT2_ENABLE,
+						       0x1);
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       S2A_DOORBELL_ENTRY_2_CTRL,
+						       S2A_DOORBELL_PORT2_AWID,
+						       0xe);
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       S2A_DOORBELL_ENTRY_2_CTRL,
+						       S2A_DOORBELL_PORT2_RANGE_OFFSET,
+						       doorbell_index);
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       S2A_DOORBELL_ENTRY_2_CTRL,
+						       S2A_DOORBELL_PORT2_RANGE_SIZE,
+						       doorbell_size);
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       S2A_DOORBELL_ENTRY_2_CTRL,
+						       S2A_DOORBELL_PORT2_AWADDR_31_28_VALUE,
+						       0x3);
+		} else
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       S2A_DOORBELL_ENTRY_2_CTRL,
+						       S2A_DOORBELL_PORT2_RANGE_SIZE,
+						       0);
+
+		WREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_2_CTRL, doorbell_range);
+	}
+}
+
+static void nbio_v4_3_vcn_doorbell_range(struct amdgpu_device *adev, bool use_doorbell,
+					 int doorbell_index, int instance)
+{
+	u32 doorbell_range;
+
+	if (instance)
+		doorbell_range = RREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_5_CTRL);
+	else
+		doorbell_range = RREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_4_CTRL);
+
+	if (use_doorbell) {
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       S2A_DOORBELL_ENTRY_4_CTRL,
+					       S2A_DOORBELL_PORT4_ENABLE,
+					       0x1);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       S2A_DOORBELL_ENTRY_4_CTRL,
+					       S2A_DOORBELL_PORT4_AWID,
+					       instance ? 0x7 : 0x4);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       S2A_DOORBELL_ENTRY_4_CTRL,
+					       S2A_DOORBELL_PORT4_RANGE_OFFSET,
+					       doorbell_index);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       S2A_DOORBELL_ENTRY_4_CTRL,
+					       S2A_DOORBELL_PORT4_RANGE_SIZE,
+					       8);
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       S2A_DOORBELL_ENTRY_4_CTRL,
+					       S2A_DOORBELL_PORT4_AWADDR_31_28_VALUE,
+					       instance ? 0x7 : 0x4);
+	} else
+		doorbell_range = REG_SET_FIELD(doorbell_range,
+					       S2A_DOORBELL_ENTRY_4_CTRL,
+					       S2A_DOORBELL_PORT4_RANGE_SIZE,
+					       0);
+
+	if (instance)
+		WREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_5_CTRL, doorbell_range);
+	else
+		WREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_4_CTRL, doorbell_range);
+}
+
+static void nbio_v4_3_gc_doorbell_init(struct amdgpu_device *adev)
+{
+	WREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_0_CTRL, 0x30000007);
+	WREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_3_CTRL, 0x3000000d);
+}
+
+static void nbio_v4_3_enable_doorbell_aperture(struct amdgpu_device *adev,
+					       bool enable)
+{
+	WREG32_FIELD15_PREREG(NBIO, 0, RCC_DEV0_EPF0_RCC_DOORBELL_APER_EN,
+			BIF_DOORBELL_APER_EN, enable ? 1 : 0);
+}
+
+static void nbio_v4_3_enable_doorbell_selfring_aperture(struct amdgpu_device *adev,
+							bool enable)
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
+	WREG32_SOC15(NBIO, 0, regBIF_BX_PF0_DOORBELL_SELFRING_GPA_APER_CNTL,
+		     tmp);
+}
+
+static void nbio_v4_3_ih_doorbell_range(struct amdgpu_device *adev,
+					bool use_doorbell, int doorbell_index)
+{
+	u32 ih_doorbell_range = RREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_1_CTRL);
+
+	if (use_doorbell) {
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_ENABLE,
+						  0x1);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_AWID,
+						  0x0);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_RANGE_OFFSET,
+						  doorbell_index);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_RANGE_SIZE,
+						  2);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_AWADDR_31_28_VALUE,
+						  0x0);
+	} else
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  S2A_DOORBELL_ENTRY_1_CTRL,
+						  S2A_DOORBELL_PORT1_RANGE_SIZE,
+						  0);
+
+	WREG32_SOC15(NBIO, 0, regS2A_DOORBELL_ENTRY_1_CTRL, ih_doorbell_range);
+}
+
+static void nbio_v4_3_ih_control(struct amdgpu_device *adev)
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
+static void nbio_v4_3_update_medium_grain_clock_gating(struct amdgpu_device *adev,
+						       bool enable)
+{
+	uint32_t def, data;
+
+	def = data = RREG32_SOC15(NBIO, 0, regCPM_CONTROL);
+	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_BIF_MGCG)) {
+		data |= (CPM_CONTROL__LCLK_DYN_GATE_ENABLE_MASK |
+			 CPM_CONTROL__TXCLK_DYN_GATE_ENABLE_MASK |
+			 CPM_CONTROL__TXCLK_LCNT_GATE_ENABLE_MASK |
+			 CPM_CONTROL__TXCLK_REGS_GATE_ENABLE_MASK |
+			 CPM_CONTROL__TXCLK_PRBS_GATE_ENABLE_MASK |
+			 CPM_CONTROL__REFCLK_REGS_GATE_ENABLE_MASK);
+	} else {
+		data &= ~(CPM_CONTROL__LCLK_DYN_GATE_ENABLE_MASK |
+			  CPM_CONTROL__TXCLK_DYN_GATE_ENABLE_MASK |
+			  CPM_CONTROL__TXCLK_LCNT_GATE_ENABLE_MASK |
+			  CPM_CONTROL__TXCLK_REGS_GATE_ENABLE_MASK |
+			  CPM_CONTROL__TXCLK_PRBS_GATE_ENABLE_MASK |
+			  CPM_CONTROL__REFCLK_REGS_GATE_ENABLE_MASK);
+	}
+
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regCPM_CONTROL, data);
+}
+
+static void nbio_v4_3_update_medium_grain_light_sleep(struct amdgpu_device *adev,
+						      bool enable)
+{
+	uint32_t def, data;
+
+	/* TODO: need update in future */
+	def = data = RREG32_SOC15(NBIO, 0, regPCIE_CNTL2);
+	if (enable && (adev->cg_flags & AMD_CG_SUPPORT_BIF_LS)) {
+		data |= PCIE_CNTL2__SLV_MEM_LS_EN_MASK;
+	} else {
+		data &= ~PCIE_CNTL2__SLV_MEM_LS_EN_MASK;
+	}
+
+	if (def != data)
+		WREG32_SOC15(NBIO, 0, regPCIE_CNTL2, data);
+}
+
+static void nbio_v4_3_get_clockgating_state(struct amdgpu_device *adev,
+					    u64 *flags)
+{
+	int data;
+
+	/* AMD_CG_SUPPORT_BIF_MGCG */
+	data = RREG32_SOC15(NBIO, 0, regCPM_CONTROL);
+	if (data & CPM_CONTROL__LCLK_DYN_GATE_ENABLE_MASK)
+		*flags |= AMD_CG_SUPPORT_BIF_MGCG;
+
+	/* AMD_CG_SUPPORT_BIF_LS */
+	data = RREG32_SOC15(NBIO, 0, regPCIE_CNTL2);
+	if (data & PCIE_CNTL2__SLV_MEM_LS_EN_MASK)
+		*flags |= AMD_CG_SUPPORT_BIF_LS;
+}
+
+static u32 nbio_v4_3_get_hdp_flush_req_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_REQ);
+}
+
+static u32 nbio_v4_3_get_hdp_flush_done_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_DONE);
+}
+
+static u32 nbio_v4_3_get_pcie_index_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_INDEX);
+}
+
+static u32 nbio_v4_3_get_pcie_data_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_DATA);
+}
+
+const struct nbio_hdp_flush_reg nbio_v4_3_hdp_flush_reg = {
+	.ref_and_mask_cp0 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP0_MASK,
+	.ref_and_mask_cp1 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP1_MASK,
+	.ref_and_mask_cp2 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP2_MASK,
+	.ref_and_mask_cp3 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP3_MASK,
+	.ref_and_mask_cp4 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP4_MASK,
+	.ref_and_mask_cp5 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP5_MASK,
+	.ref_and_mask_cp6 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP6_MASK,
+	.ref_and_mask_cp7 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP7_MASK,
+	.ref_and_mask_cp8 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP8_MASK,
+	.ref_and_mask_cp9 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__CP9_MASK,
+	.ref_and_mask_sdma0 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__SDMA0_MASK,
+	.ref_and_mask_sdma1 = BIF_BX_PF_GPU_HDP_FLUSH_DONE__SDMA1_MASK,
+};
+
+static void nbio_v4_3_init_registers(struct amdgpu_device *adev)
+{
+	return;
+}
+
+static u32 nbio_v4_3_get_rom_offset(struct amdgpu_device *adev)
+{
+	u32 data, rom_offset;
+
+	data = RREG32_SOC15(NBIO, 0, regREGS_ROM_OFFSET_CTRL);
+	rom_offset = REG_GET_FIELD(data, REGS_ROM_OFFSET_CTRL, ROM_OFFSET);
+
+	return rom_offset;
+}
+
+const struct amdgpu_nbio_funcs nbio_v4_3_funcs = {
+	.get_hdp_flush_req_offset = nbio_v4_3_get_hdp_flush_req_offset,
+	.get_hdp_flush_done_offset = nbio_v4_3_get_hdp_flush_done_offset,
+	.get_pcie_index_offset = nbio_v4_3_get_pcie_index_offset,
+	.get_pcie_data_offset = nbio_v4_3_get_pcie_data_offset,
+	.get_rev_id = nbio_v4_3_get_rev_id,
+	.mc_access_enable = nbio_v4_3_mc_access_enable,
+	.get_memsize = nbio_v4_3_get_memsize,
+	.sdma_doorbell_range = nbio_v4_3_sdma_doorbell_range,
+	.vcn_doorbell_range = nbio_v4_3_vcn_doorbell_range,
+	.gc_doorbell_init = nbio_v4_3_gc_doorbell_init,
+	.enable_doorbell_aperture = nbio_v4_3_enable_doorbell_aperture,
+	.enable_doorbell_selfring_aperture = nbio_v4_3_enable_doorbell_selfring_aperture,
+	.ih_doorbell_range = nbio_v4_3_ih_doorbell_range,
+	.update_medium_grain_clock_gating = nbio_v4_3_update_medium_grain_clock_gating,
+	.update_medium_grain_light_sleep = nbio_v4_3_update_medium_grain_light_sleep,
+	.get_clockgating_state = nbio_v4_3_get_clockgating_state,
+	.ih_control = nbio_v4_3_ih_control,
+	.init_registers = nbio_v4_3_init_registers,
+	.remap_hdp_registers = nbio_v4_3_remap_hdp_registers,
+	.get_rom_offset = nbio_v4_3_get_rom_offset,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h
new file mode 100644
index 000000000000..ade43661d7a9
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/nbio_v4_3.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
+#ifndef __NBIO_V4_3_H__
+#define __NBIO_V4_3_H__
+
+#include "soc15_common.h"
+
+extern const struct nbio_hdp_flush_reg nbio_v4_3_hdp_flush_reg;
+extern const struct amdgpu_nbio_funcs nbio_v4_3_funcs;
+
+#endif
-- 
2.35.1


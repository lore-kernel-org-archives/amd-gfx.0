Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8355CC48297
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Feb 2024 20:18:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15767112DE2;
	Tue,  6 Feb 2024 20:18:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="CeCAv5E3";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2058.outbound.protection.outlook.com [40.107.101.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E0D60112DDD
 for <amd-gfx@lists.freedesktop.org>; Tue,  6 Feb 2024 20:18:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ev3GOHVvhKJU70kEwdqztnWuC9DoSD/695i9/Wd4RN3bBpd1WtGG9u4COZ1w8h49oErTDJuQtDXt/06Jsv7eJxT+RpMFWd0znMXrIr9CT6SY7fUQQJdLB4ofawNaWgyh6m5aI2IZpeAXi02nU9VHHyJda5q4LbP7rSgZIwPxgYyy/sN5p/0kNvN+QKYvEQGh02aDKt06K0FCNzIG4c7LrtzN5c1EhfKVrEVvzUxQ1FxyL4BG75/vu7XK+sezQ+5sTibnefTLSndkl5dz2Fyg7Zv8+PIKG7QZicq8Vnqs3DAngDvxRSi7Grd1AcxXF1J2UWs/S9ru+hUtEKJIFL9FUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UTBDKPnl/d3kRWAQ8Z2H4UtlL4ay3WoiPyF0CIVy99M=;
 b=RdJgMfghW54H33xSi3nCgtoa46zreB08QYJzNLzbTrjnySazf+O2N2kJ1zwscckWvgBC92cSRcyTDYIxM26TBJxhftHdzcxR1JpL6fOEP6RynPHwomHt1qe8LGVuQLCC0kQ7Ph8NaeW0xLu/d/36nXxZq4pjZ1OYZrlSKRMJgQLq8GRaJEAoaCPUJbVcof7HmCiUS4KyBvCwzuaOWcUBrKhsfpklxoTjJ+E18R7vxe3oxr5SND3zRnKCa/yW7XU9+lYxEQb1CgWsmWDKPjgcW59DP+vjhsfkid/KhfPBYY4EWZqj0HPHOfJB4gtRftptKzM+zb28LvLrr5uuFHVu2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UTBDKPnl/d3kRWAQ8Z2H4UtlL4ay3WoiPyF0CIVy99M=;
 b=CeCAv5E3foMIj6NG5/4p1LnKhHrFsLFUeFGJ82R3X5x3O9qaUhrninEeoq9Xh5P0aML1f43P5YwYWtqFlpNblHd0TdONrBLqBlJwdSIsCJ41AwXpLEBJhMoWMEFNwGNZslJAexeZC1rQQZ/ymw1C4Qv4ZFg8WQjapN1IoM6Ltmo=
Received: from BY5PR20CA0005.namprd20.prod.outlook.com (2603:10b6:a03:1f4::18)
 by DM6PR12MB4338.namprd12.prod.outlook.com (2603:10b6:5:2a2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.16; Tue, 6 Feb
 2024 20:18:13 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::ae) by BY5PR20CA0005.outlook.office365.com
 (2603:10b6:a03:1f4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Tue, 6 Feb 2024 20:18:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7249.19 via Frontend Transport; Tue, 6 Feb 2024 20:18:12 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Tue, 6 Feb
 2024 14:18:11 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>,
 "Alex Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/3] drm/amdgpu: Add lsdma v7_0 ip block support
Date: Tue, 6 Feb 2024 15:17:50 -0500
Message-ID: <20240206201751.1671125-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240206201751.1671125-1-alexander.deucher@amd.com>
References: <20240206201751.1671125-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|DM6PR12MB4338:EE_
X-MS-Office365-Filtering-Correlation-Id: f5654d03-92df-4b3c-e449-08dc2750be8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: a8XV58ToRjOdyfJ4p6eyZ3Kx4UR3qVau2oko98afsrIptFBVD8PdB67NpuMMM38Fg3rWX9YCL3dElALHuNZsGXRfO6Far/WJ0IqRHSYEfuLfdy0Op9PvLsAlX/2phwrIKFvHDfkaNreq6SrndZCxZWQRatF1qoziHe11ZZ39MhImRPB5BxcA/hUMrxEmcN3D9hpjhNTGy+V0Kg6q0XyHSvLEx3tnz3SKjISt1tYCkyDJiXwSVn+Frydeq1lHL0MeZ+EWSLyz7TrYeVJ5bUy7S7+66alVR0ucNeSgFNq8Shbai/cTQ5Ec1nL4q2rihT8zWPXNG/A9ecNKtiA1VEqgleUnOgYc+frq3qm7dYaD7glgCUgm5j32f7dni0KKO8++ee6YTCIZFa4Qu0zFyO2upS5D8Orp104wPisnUrY0EpsTdxhIVbbTy1jrhaMxH+Q4465EeqUWsxR6r61J8aw/wIrTYDW1jrHItboYibGRhUGiftcjoDS1o1b1bsHqSUaS7JHIC3m0Ocg6yLhzsgzSG57VtZ53V44QJ0gGkjaOQa6cHKtsxeIDL3PeJXsD9yqYwncBx7O9oS366yK3OuHe6KC6sddbAJ2jCk8Togr0eAYDiRvr03+UdkUH0Zfw4n8p6tHHX6RCXBz0d8fqVymP+RxQTH9pyaKeb+gYNt6G+pk4H7GIKziArcBcQ8WE9SNegX89tzAjJrvzJIQFebsQN35Kfz8dt9R91IOayb4DLqTBV3uzJUWelPdWdDAfhTWFpR/+BLJ0mRWjC4TQ+0lh1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(82310400011)(64100799003)(1800799012)(186009)(451199024)(46966006)(40470700004)(36840700001)(41300700001)(70586007)(66899024)(2906002)(86362001)(8936002)(5660300002)(4326008)(8676002)(70206006)(6916009)(54906003)(316002)(36756003)(478600001)(36860700001)(47076005)(82740400003)(81166007)(356005)(6666004)(7696005)(83380400001)(2616005)(336012)(1076003)(16526019)(426003)(26005)(40460700003)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 20:18:12.5664 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5654d03-92df-4b3c-e449-08dc2750be8c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4338
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

From: Likun Gao <Likun.Gao@amd.com>

Add lsdma v7_0 ip block support.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile     |   2 +-
 drivers/gpu/drm/amd/amdgpu/lsdma_v7_0.c | 121 ++++++++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/lsdma_v7_0.h |  31 ++++++
 3 files changed, 153 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v7_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v7_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 1b04bae60fbf..3f7de16e0dc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -98,7 +98,7 @@ amdgpu-y += \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o arct_reg_init.o mxgpu_nv.o \
 	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o \
 	sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o \
-	nbio_v7_9.o aqua_vanjaram.o nbio_v7_11.o
+	nbio_v7_9.o aqua_vanjaram.o nbio_v7_11.o lsdma_v7_0.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v7_0.c b/drivers/gpu/drm/amd/amdgpu/lsdma_v7_0.c
new file mode 100644
index 000000000000..396262044ea8
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v7_0.c
@@ -0,0 +1,121 @@
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
+#include <linux/delay.h>
+#include "amdgpu.h"
+#include "lsdma_v7_0.h"
+#include "amdgpu_lsdma.h"
+
+#include "lsdma/lsdma_7_0_0_offset.h"
+#include "lsdma/lsdma_7_0_0_sh_mask.h"
+
+static int lsdma_v7_0_wait_pio_status(struct amdgpu_device *adev)
+{
+	return amdgpu_lsdma_wait_for(adev, SOC15_REG_OFFSET(LSDMA, 0, regLSDMA_PIO_STATUS),
+			LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK,
+			LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK);
+}
+
+static int lsdma_v7_0_copy_mem(struct amdgpu_device *adev,
+			       uint64_t src_addr,
+			       uint64_t dst_addr,
+			       uint64_t size)
+{
+	int ret;
+	uint32_t tmp;
+
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_SRC_ADDR_LO, lower_32_bits(src_addr));
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_SRC_ADDR_HI, upper_32_bits(src_addr));
+
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_DST_ADDR_LO, lower_32_bits(dst_addr));
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_DST_ADDR_HI, upper_32_bits(dst_addr));
+
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CONTROL, 0x0);
+
+	tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, BYTE_COUNT, size);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_LOCATION, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_LOCATION, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_ADDR_INC, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_ADDR_INC, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, OVERLAP_DISABLE, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, CONSTANT_FILL, 0);
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND, tmp);
+
+	ret = lsdma_v7_0_wait_pio_status(adev);
+	if (ret)
+		dev_err(adev->dev, "LSDMA PIO failed to copy memory!\n");
+
+	return ret;
+}
+
+static int lsdma_v7_0_fill_mem(struct amdgpu_device *adev,
+			       uint64_t dst_addr,
+			       uint32_t data,
+			       uint64_t size)
+{
+	int ret;
+	uint32_t tmp;
+
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CONSTFILL_DATA, data);
+
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_DST_ADDR_LO, lower_32_bits(dst_addr));
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_DST_ADDR_HI, upper_32_bits(dst_addr));
+
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CONTROL, 0x0);
+
+	tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, BYTE_COUNT, size);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_LOCATION, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_LOCATION, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_ADDR_INC, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_ADDR_INC, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, OVERLAP_DISABLE, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, CONSTANT_FILL, 1);
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND, tmp);
+
+	ret = lsdma_v7_0_wait_pio_status(adev);
+	if (ret)
+		dev_err(adev->dev, "LSDMA PIO failed to fill memory!\n");
+
+	return ret;
+}
+
+static void lsdma_v7_0_update_memory_power_gating(struct amdgpu_device *adev,
+						 bool enable)
+{
+	uint32_t tmp;
+
+	tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_MEM_POWER_CTRL);
+	tmp = REG_SET_FIELD(tmp, LSDMA_MEM_POWER_CTRL, MEM_POWER_CTRL_EN, 0);
+	WREG32_SOC15(LSDMA, 0, regLSDMA_MEM_POWER_CTRL, tmp);
+
+	tmp = REG_SET_FIELD(tmp, LSDMA_MEM_POWER_CTRL, MEM_POWER_CTRL_EN, enable);
+	WREG32_SOC15(LSDMA, 0, regLSDMA_MEM_POWER_CTRL, tmp);
+}
+
+const struct amdgpu_lsdma_funcs lsdma_v7_0_funcs = {
+	.copy_mem = lsdma_v7_0_copy_mem,
+	.fill_mem = lsdma_v7_0_fill_mem,
+	.update_memory_power_gating = lsdma_v7_0_update_memory_power_gating
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v7_0.h b/drivers/gpu/drm/amd/amdgpu/lsdma_v7_0.h
new file mode 100644
index 000000000000..52b4485cdd98
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v7_0.h
@@ -0,0 +1,31 @@
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
+#ifndef __LSDMA_V7_0_H__
+#define __LSDMA_V7_0_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_lsdma_funcs lsdma_v7_0_funcs;
+
+#endif /* __LSDMA_V7_0_H__ */
-- 
2.42.0


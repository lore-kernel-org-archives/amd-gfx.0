Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFDC9FCB61A
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 15:38:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6169910ED5C;
	Fri,  6 Mar 2026 15:38:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nSJYxmVV";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013052.outbound.protection.outlook.com
 [40.107.201.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9ADD10ED5C
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 15:38:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIpZSsRUhcAgoZdlU6/8HrP2jAnr8luO5ldlK2QbZu0eZLRm2rcKiYJwI78qwdAQ7H5SxUvOLiks7j51LwCvCwiVlXxN//UYzmj3l6ncXhliVht2epGCi3W7rDhnsG8e5z612CaapQ3T4uZ9y/bZXmFZHEKnAM/gxw3KIIaGHORhotovEBa2DlbA58li0fKYYYwNZhUjrCmqfXPPkVzCVD7zxM4Y/eFolSKi5oBnP8/hwfP9jaV1uzmj1OkSi9QlHTpLNYuIaG9Z59UpYvIs+PiuHF/J+a7KvzPly7riOjMJTpMfRVuAS81JayO3ILzTj6xW8uubRaiwKhI2T76HLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y8GDAEJY5KGxGWzi3MupRLhgErP+tRAK0bkgv+m6Vh0=;
 b=YjbQRT5RAJm2InfhlXfWui0VaDhh35DDFEhAAP7v06YAd8KpjNh3TqeBehK2lTAWsYIkUyHO274b0vVCegIP1AE/HY5PmYc0t4RjSstya6BEjT20EwHpa0DQT+/8KGjooownCxlH1qABAbA+J0WGCrk2tqzJx3CGDH/b7UvNnqaD0wYYze1xoW0DS4wH9tx6bDlBBvwWlJVtqOJMMa2DWHHpVne4IbZVGiSnxoRsTS2jDFvGizHTmXf1w+7vdf04ptwtr4/1kWCcp65Abi0tVgKNHeOw8dteCf83g5bHeCs1e14XFf831WQEixBOfVtVwm1iCXJ6kzwdVBocmT9RdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y8GDAEJY5KGxGWzi3MupRLhgErP+tRAK0bkgv+m6Vh0=;
 b=nSJYxmVVr8tYCET/sZvosXKf23wP7lzJwUCwMRXR9+0FJwVaEM/SahKiUrkz9NgpgvQiarDOHskWmHR1Rf78WihiGxorrlwsXxYqmrU5hrNUttL5MEcpbUgS0deEEaMj7NrfY3fdyKpNZtevPEMtMCvWNb38Bj1a1fO35E/4Si8=
Received: from SJ0PR13CA0036.namprd13.prod.outlook.com (2603:10b6:a03:2c2::11)
 by BL1PR12MB5993.namprd12.prod.outlook.com (2603:10b6:208:399::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.5; Fri, 6 Mar
 2026 15:38:04 +0000
Received: from BY1PEPF0001AE1D.namprd04.prod.outlook.com
 (2603:10b6:a03:2c2:cafe::95) by SJ0PR13CA0036.outlook.office365.com
 (2603:10b6:a03:2c2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.18 via Frontend Transport; Fri,
 6 Mar 2026 15:38:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1D.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 15:38:02 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 6 Mar
 2026 09:37:55 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Mar
 2026 09:37:35 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 6 Mar 2026 09:37:34 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add support for lsdma v7_1
Date: Fri, 6 Mar 2026 10:37:27 -0500
Message-ID: <20260306153728.22079-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260306153728.22079-1-alexander.deucher@amd.com>
References: <20260306153728.22079-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1D:EE_|BL1PR12MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: 10c75c5d-c2c0-4f81-6f95-08de7b965ab1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014; 
X-Microsoft-Antispam-Message-Info: B0JQUAUXVlQDHXi9WYrehnU2y8roaZJgRCmaUWRRfqTMT0FfZ2+hPlT9ES/E4Gv4scXhGoIKTbHTsx/5iDH1f6azeWNmnPC2WV2EDMB/Iu+IWf8Cv+LY2IgQeKeiEr0pn5ter2SoLNu7Bpruw0+7rwSIK4p0Glpody6fqro514h6VOiYyV7RYl05biQFCSF3AbsToj9Xmmwjp5HbehcsMm16PPEaIK8U1bkxi9ofEId8qLe8+Rekg6Vgtswy7r4SxKmwOOHy9h/LNrt7QTqKN19RiMFXtzIZ10cxgc05Ymq7IBC+tAEAVEFgW/errm7qlGX67sjPhHDod6rzSOn2NGUT1RwS4mims+pN3j9WwQ3T0+SP02od/jQQVMKkTeByBXvk5UnNXiconGJbzJPB1gFjUGcIGtc4MruV+EWvuez+7qGFCoT5zIUmJCU2/PlqNk5ZhFAcHyRE5tDz1BKFCfwMsj6GA1K1xURK4nvME63kZCUPwVOzCKIZQzHVx8daFwcN3fZobWzgg9zHico1NC9x+WlnpgKAvdgBNtp9YYJzlme5w2mZP+6hlabtgH4/DutVQKsxffALBNpSzUiYHIC6dkG5grABYk/JB67OP2kCQethLuBXxc9h2gwn3zyQ1xVjyPGHaZhlzqcfDHHwfQOPscakGX9weGpaBlicAaw7iRi9eYiUmrpysSmZZDZBRp1Z94I8CZob/iNyM0P1nPgz77WKjEAOF0DN5KXy/DqFSE6Rzn3v89hVUlo61R+fBmpyDZirX3/2QofYedeRUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BFWGSXqWRZHeXrGqNSRYSuxhdQwUpQC8+CymLbiaE/99HQ6us9I/IIFxXQ3o9UbSsMyT/m7frIRLUiPocoWxIScjNCq8gHfb7BVmbGVsctaGZCyS5UdomkKCWFtff4Tuj2Go7U9SXyHDK5y+N0SFBhG050QYRXLMbs+d1UCePCvEzBf+AH13p3Jy23+pTaRzwvs8t1jB/gKxPkOH2ULBjeRhg0IYnqLklhK9DWnI9ZCOGQ7uhAzosKPsotgt16MfLTMQkD7VBZBhlU+rHgg0kQgLr2V6jqqipRlUe/d5lOYB6H7vwII25X8qcZ44SCwD3reytB+9exBis8ekeHM3fq2IELTvADucV6XiKTgp0Sy02f8r8VYup+30aocHc1Dp/HNBSjwqGJqyoNamCArQfOpOEbycKRPWef84W1H4L3U+0VfiNzQUcqCwvzKQqXb3
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 15:38:02.9245 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10c75c5d-c2c0-4f81-6f95-08de7b965ab1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1D.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5993
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

Add support for LSDMA v7_1_0.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |  4 +
 drivers/gpu/drm/amd/amdgpu/lsdma_v7_1.c       | 99 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/lsdma_v7_1.h       | 31 ++++++
 4 files changed, 135 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v7_1.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v7_1.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 006d49d6b4af3..9c9c73b73ac8e 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -86,7 +86,7 @@ amdgpu-y += \
 	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o soc24.o \
 	sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o \
 	nbio_v7_9.o aqua_vanjaram.o nbio_v7_11.o lsdma_v7_0.o hdp_v7_0.o nbif_v6_3_1.o \
-	cyan_skillfish_reg_init.o soc_v1_0.o
+	cyan_skillfish_reg_init.o soc_v1_0.o lsdma_v7_1.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index daa2a27718edb..79fc224687039 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -87,6 +87,7 @@
 #include "sdma_v7_1.h"
 #include "lsdma_v6_0.h"
 #include "lsdma_v7_0.h"
+#include "lsdma_v7_1.h"
 #include "vcn_v2_0.h"
 #include "jpeg_v2_0.h"
 #include "vcn_v3_0.h"
@@ -3269,6 +3270,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(7, 0, 1):
 		adev->lsdma.funcs = &lsdma_v7_0_funcs;
 		break;
+	case IP_VERSION(7, 1, 0):
+		adev->lsdma.funcs = &lsdma_v7_1_funcs;
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v7_1.c b/drivers/gpu/drm/amd/amdgpu/lsdma_v7_1.c
new file mode 100644
index 0000000000000..d93a0e65ce7de
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v7_1.c
@@ -0,0 +1,99 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+#include "lsdma_v7_1.h"
+#include "amdgpu_lsdma.h"
+
+#include "lsdma/lsdma_7_1_0_offset.h"
+#include "lsdma/lsdma_7_1_0_sh_mask.h"
+
+static int lsdma_v7_1_wait_pio_status(struct amdgpu_device *adev)
+{
+	return amdgpu_lsdma_wait_for(adev, SOC15_REG_OFFSET(LSDMA, 0, regLSDMA_PIO_STATUS),
+			LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK,
+			LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK);
+}
+
+static int lsdma_v7_1_copy_mem(struct amdgpu_device *adev,
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
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, COUNT, size);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, RAW_WAIT, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, CONSTANT_FILL, 0);
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND, tmp);
+
+	ret = lsdma_v7_1_wait_pio_status(adev);
+	if (ret)
+		dev_err(adev->dev, "LSDMA PIO failed to copy memory!\n");
+
+	return ret;
+}
+
+static int lsdma_v7_1_fill_mem(struct amdgpu_device *adev,
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
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, COUNT, size);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, RAW_WAIT, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, CONSTANT_FILL, 1);
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND, tmp);
+
+	ret = lsdma_v7_1_wait_pio_status(adev);
+	if (ret)
+		dev_err(adev->dev, "LSDMA PIO failed to fill memory!\n");
+
+	return ret;
+}
+
+const struct amdgpu_lsdma_funcs lsdma_v7_1_funcs = {
+	.copy_mem = lsdma_v7_1_copy_mem,
+	.fill_mem = lsdma_v7_1_fill_mem,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v7_1.h b/drivers/gpu/drm/amd/amdgpu/lsdma_v7_1.h
new file mode 100644
index 0000000000000..3d1ab605849a0
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v7_1.h
@@ -0,0 +1,31 @@
+/*
+ * Copyright 2026 Advanced Micro Devices, Inc.
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
+#ifndef __LSDMA_V7_1_H__
+#define __LSDMA_V7_1_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_lsdma_funcs lsdma_v7_1_funcs;
+
+#endif /* __LSDMA_V7_1_H__ */
-- 
2.53.0


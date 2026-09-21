Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43A3CC982EE
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Sep 2026 20:32:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B282010E7A5;
	Mon, 21 Sep 2026 20:32:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="aTbKi46N";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011038.outbound.protection.outlook.com
 [40.93.194.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABBD010E777
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Sep 2026 20:32:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=p6wUh+ETQoOmx6VV72pb6YEM8PBFbuPabPrXTeOnCiPBJBBwymWhFoL4dYwgVjHDdWiucRLYiBPtNSiF4Gpx/NBJQXgrd8TP1P2zA8mOsbbAEnzL9n4LqmbaNK8wtPKaFlGHaTGGVoWKqnLWOqmh0ODAr3pMLNamFApXUvpt1+dhUoCW8wFn9OhUNBdblV16L33JSZGpdHAfXBVLg6GNUJA9Y2DfYjPSXW8zr9z02wRGVsUsrg02N8XPbFk5so6bMJiHOq90H6DJ90N9O3kg60SRo/KlZxToKVHdzwprmddKNwCnJbYgdZwpAmNjzB/ZqL++/SVnfRX5FtWoXO1xpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6vod+5s8ziOT5U4FwBeLfBS1QTj5V5iuy210VXGQx7c=;
 b=N3gnev25YlfkbgZaD+eQieSUj0JHuGuKKX/vfZxF2blVR26h5Qmuh/EOXvCtwpD7jg9XU0kgUbCB52MPI2KpCbNXfpGFr26vGBkaLX+iZzGdaIycu7fiw/N0uE7zaKmG60q7wGzyEWQAAaA+1KwKti9BZwrdFbD+Gvth4ol2F8wTs5WKXFpjvRggEg7G3gxtgo/W1Ug1FEi1NghfP0oDrqgULP1ZCQEKBqu7fs9t6HafFGNfCM1ykPaF1tCJU0DPSVz0NxzfjRbGGDBXyasBTAJko9tzM/EzkTiLx1kAPUF+YdNA2j3ts1L73eNMpme5zp17UegC8aUmZwiyVS8uUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6vod+5s8ziOT5U4FwBeLfBS1QTj5V5iuy210VXGQx7c=;
 b=aTbKi46Niyw5eZOL8LGb7WPyYg1RJraD3z7gdKnGkLzY0z5csKNDZX54vvkPGtPUoZYxYDnQ7crX494s7Yg7CDr2vLfeBErQ4N+yfDqqfRc0gJNd96XepDgYMQxxHSVhC0GNMlNxNJJUQ7tAhprLGXxZKe4fjTjCWJBlai19neY=
Received: from CP9P284CA0003.BRAP284.PROD.OUTLOOK.COM (2603:10d6:103:371::10)
 by CHAPR12MB999249.namprd12.prod.outlook.com (2603:10b6:610:300::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 20:32:22 +0000
Received: from SJ1PEPF000026C5.namprd04.prod.outlook.com
 (2603:10d6:103:371:cafe::97) by CP9P284CA0003.outlook.office365.com
 (2603:10d6:103:371::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 20:32:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000026C5.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 20:32:20 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:32:19 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 15:32:18 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Mon, 21 Sep 2026 15:32:18 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Hawking Zhang <Hawking.Zhang@amd.com>, Frank Min <Frank.Min@amd.com>, Alex
 Deucher <alexander.deucher@amd.com>
Subject: [PATCH 3/4] drm/amdgpu: Add nbif v7_10 support
Date: Mon, 21 Sep 2026 16:32:05 -0400
Message-ID: <20260921203206.2038708-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260921203206.2038708-1-alexander.deucher@amd.com>
References: <20260921203206.2038708-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C5:EE_|CHAPR12MB999249:EE_
X-MS-Office365-Filtering-Correlation-Id: bdda5e7f-8b62-4787-4a5a-08df181f6fd4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|82310400026|36860700016|11063799006|3023799007|10067099003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: iuyYAT4Zr6gn43PbVvPdrTYCiwJ/pBHOZWW7LOhXuS0CeVPXAhkRd4aPKI7/uxgZHunDerFwc2IxvuqgaLOirhumkrEaTuqvKQtUbE/dqAIG7Qp4iTgqqaKgvQkm6kVVwNl1+YR2sJMqyxo52S+SCZT49l0ppEYGVztTlvSAWXT68vzc5oWRDbcwqg/tUrZIzfFMKjMljhOs6b1esse0RMf9rJQKL2cEdxDgxZ2Z/Ca/pwpO9hhUwJlX2vxIOfDI5GQ3CvUpABi+8V+FELfJJdZhQRcYNeFO1xmgOFDD28lBzRKzxpuH1PnIVwmGL9q1avkorr3cXwLmNqnjh+hOwQDQ711tgDp+pjiRi7rBuZFOMTx+A10a42oRx5f2Tr3px6Yv4ihctUzyt0cSnZbRA+PSt5Gl+Y62sXPGNNn3m45YKC0GBhcp8yvemusDnKMht1YzH0Kx17v+dv98TBdKi3BRFqHunEgoQe+xS9lPca3eauFzrlSGDT/qIlLHkd6erc6C/H0VP5zKRfqLnrN0hUDq9vyySkxVBvUzc1vGGiHjNXM35B+FbjAf5+nJcdwH9rN5H9chCflltfkTtmSR2XMC1+cp38Pk4NcjH9rOpvSbF42v+2+Y47GymwvJTu9Nt8jt1x1VcbYTGZaiyAF989JhQ4sIzNh7r9dEBEoguxRfBuusj0DDkT5DXdXrYb8e5R2CaHMyaE541Dn6YCBoaQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(82310400026)(36860700016)(11063799006)(3023799007)(10067099003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w92UpGzI7+zJxPE8Uh2hBoTzzwRljaYV2mOhWERDfbOwk3JwcN1WV+YH2eI9RFgpxuQzvQ+YbuWw0srH7mO39qlPuCsxX2+3SMkboDhHtUdGahB/9+U5EmsOCfAvhMMgapfdVHrjvsPrOOI+8ibVSEwdHV0a4ISI7hEb3axzxzbtr2KumLdNCwQVaUoiJlbRa4yrnMOfkjsgY9h+Lw/oDVLlYeZF1I/oWIm81TZBpTNMWiwqw1hBxQT3YNDf5UvueYTLZH2fK6lfrjf68rgouAVfjOpp5QkSvi1FGBKJiDxfrdkq1tyhO0HoQyl0YRH+EXLRoKxv5j/x20hzhvmbDWcsLVV79OEdiGwVxl4RNxL9CAkbymuAwPg2GYywi77EH/Uk8WySqI0yVGi8K9KxllU6cr926z9zqemTSw1XbWW8kFzs9EXLiJA/WlpV3f95
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 20:32:20.8115 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bdda5e7f-8b62-4787-4a5a-08df181f6fd4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C5.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHAPR12MB999249
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

Add initial implementation for the new generation of nbif

v2: squash in HDP, VPE, RLC/IH, SDMA fixes

Signed-off-by: Hawking Zhang <Hawking.Zhang@amd.com>
Reviewed-by: Frank Min <Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   3 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   5 +
 drivers/gpu/drm/amd/amdgpu/nbif_v7_10.c       | 344 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nbif_v7_10.h       |  32 ++
 4 files changed, 383 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbif_v7_10.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/nbif_v7_10.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index ce557cf36c9d4..27ab027271fa1 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -91,7 +91,8 @@ amdgpu-y += \
 	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o soc24.o \
 	sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o \
 	nbio_v7_9.o aqua_vanjaram.o nbio_v7_11.o lsdma_v7_0.o hdp_v7_0.o nbif_v6_3_1.o \
-	cyan_skillfish_reg_init.o soc_v1_0.o lsdma_v7_1.o nbio_v6_3_2.o nbio_v7_11_5.o
+	cyan_skillfish_reg_init.o soc_v1_0.o lsdma_v7_1.o nbio_v6_3_2.o nbio_v7_11_5.o \
+	nbif_v7_10.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 4eb852f2a3824..2034754d6af74 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -68,6 +68,7 @@
 #include "nbio_v7_7.h"
 #include "nbif_v6_3_1.h"
 #include "nbio_v6_3_2.h"
+#include "nbif_v7_10.h"
 #include "hdp_v5_0.h"
 #include "hdp_v5_2.h"
 #include "hdp_v6_0.h"
@@ -3814,6 +3815,10 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(6, 3, 2):
 		adev->nbio.funcs = &nbio_v6_3_2_funcs;
 		break;
+	case IP_VERSION(7, 10, 0):
+		adev->nbio.funcs = &nbif_v7_10_funcs;
+		adev->nbio.hdp_flush_reg = &nbif_v7_10_hdp_flush_reg;
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v7_10.c b/drivers/gpu/drm/amd/amdgpu/nbif_v7_10.c
new file mode 100644
index 0000000000000..9022454aa74ec
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v7_10.c
@@ -0,0 +1,344 @@
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
+#include "nbif_v7_10.h"
+
+#include "nbif/nbif_7_10_0_offset.h"
+#include "nbif/nbif_7_10_0_sh_mask.h"
+#include "pcie/pcie_6_1_3_offset.h"
+#include "pcie/pcie_6_1_3_sh_mask.h"
+#include "ivsrcid/nbio/irqsrcs_nbif_7_4.h"
+#include <uapi/linux/kfd_ioctl.h>
+
+static void nbif_v7_10_remap_hdp_registers(struct amdgpu_device *adev)
+{
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_MEM_FLUSH_CNTL,
+		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_MEM_FLUSH_CNTL);
+	WREG32_SOC15(NBIO, 0, regBIF_BX0_REMAP_HDP_REG_FLUSH_CNTL,
+		adev->rmmio_remap.reg_offset + KFD_MMIO_REMAP_HDP_REG_FLUSH_CNTL);
+}
+
+static u32 nbif_v7_10_get_rev_id(struct amdgpu_device *adev)
+{
+	u32 tmp = RREG32_SOC15(NBIO, 0, regRCC_STRAP0_RCC_DEV0_EPF0_STRAP0);
+
+	tmp &= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0_MASK;
+	tmp >>= RCC_STRAP0_RCC_DEV0_EPF0_STRAP0__STRAP_ATI_REV_ID_DEV0_F0__SHIFT;
+
+	return tmp;
+}
+
+static void nbif_v7_10_mc_access_enable(struct amdgpu_device *adev, bool enable)
+{
+	if (enable)
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN,
+			     BIF_BX0_BIF_FB_EN__FB_READ_EN_MASK |
+			     BIF_BX0_BIF_FB_EN__FB_WRITE_EN_MASK);
+	else
+		WREG32_SOC15(NBIO, 0, regBIF_BX0_BIF_FB_EN, 0);
+}
+
+static u32 nbif_v7_10_get_memsize(struct amdgpu_device *adev)
+{
+	return RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF0_RCC_CONFIG_MEMSIZE);
+}
+
+static void nbif_v7_10_sdma_doorbell_range(struct amdgpu_device *adev,
+					   int instance, bool use_doorbell,
+					   int doorbell_index, int doorbell_size)
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
+						       0xe);
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
+static void nbif_v7_10_vpe_doorbell_range(struct amdgpu_device *adev,
+					   int instance, bool use_doorbell,
+					   int doorbell_index, int doorbell_size)
+{
+	if (instance == 0) {
+		u32 doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL);
+
+		if (use_doorbell) {
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
+						       S2A_DOORBELL_PORT4_ENABLE,
+						       0x1);
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
+						       S2A_DOORBELL_PORT4_AWID,
+						       0xf);
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
+						       S2A_DOORBELL_PORT4_RANGE_OFFSET,
+						       doorbell_index);
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
+						       S2A_DOORBELL_PORT4_RANGE_SIZE,
+						       doorbell_size);
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
+						       S2A_DOORBELL_PORT4_AWADDR_31_28_VALUE,
+						       0xf);
+		} else
+			doorbell_range = REG_SET_FIELD(doorbell_range,
+						       GDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL,
+						       S2A_DOORBELL_PORT4_RANGE_SIZE,
+						       0);
+
+		WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_4_CTRL, doorbell_range);
+	}
+}
+
+static void nbif_v7_10_gc_doorbell_init(struct amdgpu_device *adev)
+{
+	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_0_CTRL, 0x30000007);
+	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_1_CTRL, 0x3000000d);
+}
+
+static void nbif_v7_10_enable_doorbell_aperture(struct amdgpu_device *adev,
+						 bool enable)
+{
+	WREG32_FIELD15_PREREG(NBIO, 0, RCC_DEV0_EPF0_RCC_DOORBELL_APER_EN,
+			      BIF_DOORBELL_APER_EN, enable ? 1 : 0);
+}
+
+static void nbif_v7_10_enable_doorbell_selfring_aperture(struct amdgpu_device *adev,
+							 bool enable)
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
+static void nbif_v7_10_ih_doorbell_range(struct amdgpu_device *adev,
+					 bool use_doorbell, int doorbell_index)
+{
+	u32 ih_doorbell_range = RREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL);
+
+	if (use_doorbell) {
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL,
+						  S2A_DOORBELL_PORT3_ENABLE,
+						  0x1);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL,
+						  S2A_DOORBELL_PORT3_AWID,
+						  0x0);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL,
+						  S2A_DOORBELL_PORT3_RANGE_OFFSET,
+						  doorbell_index);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL,
+						  S2A_DOORBELL_PORT3_RANGE_SIZE,
+						  2);
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL,
+						  S2A_DOORBELL_PORT3_AWADDR_31_28_VALUE,
+						  0x0);
+	} else
+		ih_doorbell_range = REG_SET_FIELD(ih_doorbell_range,
+						  GDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL,
+						  S2A_DOORBELL_PORT3_RANGE_SIZE,
+						  0);
+
+	WREG32_SOC15(NBIO, 0, regGDC_S2A0_S2A_DOORBELL_ENTRY_3_CTRL, ih_doorbell_range);
+}
+
+static void nbif_v7_10_ih_control(struct amdgpu_device *adev)
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
+nbif_v7_10_update_medium_grain_clock_gating(struct amdgpu_device *adev,
+					     bool enable)
+{
+}
+
+static void
+nbif_v7_10_update_medium_grain_light_sleep(struct amdgpu_device *adev,
+					    bool enable)
+{
+}
+
+static void
+nbif_v7_10_get_clockgating_state(struct amdgpu_device *adev,
+				  u64 *flags)
+{
+}
+
+static u32 nbif_v7_10_get_hdp_flush_req_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_REQ);
+}
+
+static u32 nbif_v7_10_get_hdp_flush_done_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_GPU_HDP_FLUSH_DONE);
+}
+
+static u32 nbif_v7_10_get_pcie_index_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_INDEX);
+}
+
+static u32 nbif_v7_10_get_pcie_data_offset(struct amdgpu_device *adev)
+{
+	return SOC15_REG_OFFSET(NBIO, 0, regBIF_BX_PF0_RSMU_DATA);
+}
+
+const struct nbio_hdp_flush_reg nbif_v7_10_hdp_flush_reg = {
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
+	.ref_and_mask_sdma2 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__SDMA2_MASK,
+	.ref_and_mask_sdma3 = BIF_BX_PF0_GPU_HDP_FLUSH_DONE__SDMA3_MASK,
+};
+
+static void nbif_v7_10_init_registers(struct amdgpu_device *adev)
+{
+	uint32_t data;
+
+	data = RREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2);
+	data &= ~RCC_DEV0_EPF2_STRAP2__STRAP_NO_SOFT_RESET_DEV0_F2_MASK;
+	WREG32_SOC15(NBIO, 0, regRCC_DEV0_EPF2_STRAP2, data);
+}
+
+static u32 nbif_v7_10_get_rom_offset(struct amdgpu_device *adev)
+{
+	u32 data, rom_offset;
+
+	data = RREG32_SOC15(NBIO, 0, regREGS_ROM_OFFSET_CTRL);
+	rom_offset = REG_GET_FIELD(data, REGS_ROM_OFFSET_CTRL, ROM_OFFSET);
+
+	return rom_offset;
+}
+
+#define MMIO_REG_HOLE_OFFSET (0x80000 - PAGE_SIZE)
+
+static void nbif_v7_10_set_reg_remap(struct amdgpu_device *adev)
+{
+	if (!amdgpu_sriov_vf(adev) && (PAGE_SIZE <= 4096)) {
+		adev->rmmio_remap.reg_offset = MMIO_REG_HOLE_OFFSET;
+		adev->rmmio_remap.bus_addr = adev->rmmio_base + MMIO_REG_HOLE_OFFSET;
+	} else {
+		adev->rmmio_remap.reg_offset = SOC15_REG_OFFSET(NBIO, 0,
+			regBIF_BX_PF0_HDP_MEM_COHERENCY_FLUSH_CNTL) << 2;
+		adev->rmmio_remap.bus_addr = 0;
+	}
+}
+
+const struct amdgpu_nbio_funcs nbif_v7_10_funcs = {
+	.get_hdp_flush_req_offset = nbif_v7_10_get_hdp_flush_req_offset,
+	.get_hdp_flush_done_offset = nbif_v7_10_get_hdp_flush_done_offset,
+	.get_pcie_index_offset = nbif_v7_10_get_pcie_index_offset,
+	.get_pcie_data_offset = nbif_v7_10_get_pcie_data_offset,
+	.get_rev_id = nbif_v7_10_get_rev_id,
+	.mc_access_enable = nbif_v7_10_mc_access_enable,
+	.get_memsize = nbif_v7_10_get_memsize,
+	.sdma_doorbell_range = nbif_v7_10_sdma_doorbell_range,
+	.vpe_doorbell_range = nbif_v7_10_vpe_doorbell_range,
+	.gc_doorbell_init = nbif_v7_10_gc_doorbell_init,
+	.enable_doorbell_aperture = nbif_v7_10_enable_doorbell_aperture,
+	.enable_doorbell_selfring_aperture = nbif_v7_10_enable_doorbell_selfring_aperture,
+	.ih_doorbell_range = nbif_v7_10_ih_doorbell_range,
+	.update_medium_grain_clock_gating = nbif_v7_10_update_medium_grain_clock_gating,
+	.update_medium_grain_light_sleep = nbif_v7_10_update_medium_grain_light_sleep,
+	.get_clockgating_state = nbif_v7_10_get_clockgating_state,
+	.ih_control = nbif_v7_10_ih_control,
+	.init_registers = nbif_v7_10_init_registers,
+	.remap_hdp_registers = nbif_v7_10_remap_hdp_registers,
+	.get_rom_offset = nbif_v7_10_get_rom_offset,
+	.set_reg_remap = nbif_v7_10_set_reg_remap,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/nbif_v7_10.h b/drivers/gpu/drm/amd/amdgpu/nbif_v7_10.h
new file mode 100644
index 0000000000000..4759d6fb16a77
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/nbif_v7_10.h
@@ -0,0 +1,32 @@
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
+#ifndef __NBIO_V7_10_H__
+#define __NBIO_V7_10_H__
+
+#include "soc15_common.h"
+
+extern const struct nbio_hdp_flush_reg nbif_v7_10_hdp_flush_reg;
+extern const struct amdgpu_nbio_funcs nbif_v7_10_funcs;
+
+#endif
-- 
2.55.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCE5C98302
	for <amd-gfx@archiver.kernel.org>; Tue, 22 Sep 2026 13:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D41210E49C;
	Tue, 22 Sep 2026 13:54:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="urw5+g91";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011039.outbound.protection.outlook.com [52.101.52.39])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B989510ECF0
 for <amd-gfx@lists.freedesktop.org>; Tue, 22 Sep 2026 13:54:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLfm/ioYHwH+Er9/ZqHOu1QZICEd6S6y5DsOJ0C+MSdIcBbZ8puHbZZSH6Vn3/s90zxNRBx1Amq6nwbR7hcsAo3+zh38owBPamxN73T+REnmQsbOfoLqzhK/plRbPSdhoZ/HHedm2eqR87gK4YwfrwIJHkAFFqmKN2u10gIfGRGRe8YyoqPQYR+Peq+KSioSTWRQeco6HqesbzTSEs+BymjM80p2VOJ7c7Mx95iuPu3Kub9njf4txUrT4itm+qdvlk2/hWbrSTjBXCX6JvplRI8//eYbUV9vRSlUsyqSypW1a5kCm9UxzPhjoJ5OgyDdm2pZprz1IFib25uyJu4mPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3Lt8MqIgfR87Dygo6Mj3Lw2WYtjLAkatl+7LJTZfBI=;
 b=a/ltXuQ9XXNYqYToDorHiid2OWi7oIx7ZHf8fJ8Qmx6ya8pL4mKHgPRjWOkA56sDzo4NFOBIZHYLgKY4pu6KbjKu056f+p4pWG+WgPA1VdrgiewFZaPN8mUNVxUvVZATkIEt0aeiYmbzWGG4TPFtk0dSU0MCcapMC8k+iN7yZ31UEPvxsv4QW2odOSJyHCUBpudeSUp8QKtGJuBVvloOtMpPJ9T7ENPgG4nKbZJ8otvvk9QmeP0tuH7CQ3acrQ9fK3taZiGIGQpUkwIfJ4gsjEctgLEMaG4s3XUUsB1GO+YWJf5HRnM8W2J4boWZGWFHdeMrhn/ZMtXllvWYZtOYsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3Lt8MqIgfR87Dygo6Mj3Lw2WYtjLAkatl+7LJTZfBI=;
 b=urw5+g91ArIMcQwG6uScDsGLSkxF0CWhTixMZB9ZXFoLFKJqE1myWX4hAArNoIec78Gux++MFFOieUAoQGva8LiwntIxTFy5pLAtMJQFXbG0g5BtlF3x9LZcR4q2G85tJkMFSpOyxgV058FRDriun2waAetL4AVrLwPiNFOK5kE=
Received: from SJ0PR13CA0024.namprd13.prod.outlook.com (2603:10b6:a03:2c0::29)
 by DSWPR12MB999151.namprd12.prod.outlook.com (2603:10b6:8:36b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.14; Tue, 22 Sep
 2026 13:54:51 +0000
Received: from SJ5PEPF000001D6.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::94) by SJ0PR13CA0024.outlook.office365.com
 (2603:10b6:a03:2c0::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Tue,
 22 Sep 2026 13:54:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D6.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Tue, 22 Sep 2026 13:54:50 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 08:54:47 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 22 Sep
 2026 08:54:48 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Tue, 22 Sep 2026 08:54:47 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Frank Min <Frank.Min@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add support for lsdma v8
Date: Tue, 22 Sep 2026 09:54:19 -0400
Message-ID: <20260922135419.2145987-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260922135419.2145987-1-alexander.deucher@amd.com>
References: <20260922135419.2145987-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D6:EE_|DSWPR12MB999151:EE_
X-MS-Office365-Filtering-Correlation-Id: e1334ce3-0af7-4a83-8592-08df18b1124b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|23010399003|36860700016|1800799024|10067099003|56012099006|3023799007|18002099003|22082099003|11063799006;
X-Microsoft-Antispam-Message-Info: 8/Hcs6ES5KI4xWFz0Dbkg55u9544W4DlHpUDMDQBn1oHBWMEyQnMk+6KaR7evQZqGwwJ0YqmyjrhCHMRkrrGJiFKv+wi6nimJLB1dmfkOYbC8XhxtfddG7gcJTaBiqKIvGSj6hxPr3LNrwx4MLzbWtxh7cr7LoqxEFYbzdp+pAbGh2F4ybV/2ynTQbEJ+6ParBBrp5L+EB10wJFvKxSgt2aucuMlYkEfWeoXl1bLynP/qLP9rKEOp/0Qw9F1bGsBIOCPNLc1V7em0cBSDwdEB3y0CzikpfR6TDMkch3pRKMfmthhifabivmeIJkUcdqDvi7kBzKmYXNuzwi9eVO8Ac8PwHy+mUmCrLr59ut23Z/D+cXRNTBYGQzimGcu5H5mw+O1S+nCViIpxo+zn9Txrx57+5fj6Ee1JThXuCrJ6FQzL90aE1nXy7F59Qs2boF5d2/j9dgJTUko/u4p6D+lulPczov4jKwIx4UQSgnfFNw08OyfUWtW6UTI9iUAFed57CbB7wi8RZ0yNlHZKjtKa+ciHhuI6U5p/f6wI2I7JMogAJNGbGYllUXN39Z/+nIAXoW9mZHFhbxIJcOWpwpvdoPkWnFJsQtkB9wAw+5WUzknqes1nenXj4DTR5kD2Nlz9PYIKXqHaO1M8evjT1PyuVScwI2gz2dDDtOqyycWyByUl/9wCddi0g8D6uuXdb1Gi5I6pZ1mVKcddrRJryFLfA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(23010399003)(36860700016)(1800799024)(10067099003)(56012099006)(3023799007)(18002099003)(22082099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tQnQJpaVS+gZAhQM38I6wyhs9woC+MId4rbbMguWrh82ca7ouchwle6f6/hVrPxV2YwlxzufjTfoX2WIxcBCeklbkoXT7zWLlwl7KaOndMnr9wCBSGRh3gJchEVsNbFBqTQPYIejeNDY8L4xxcGkcYVhwT0mHlPjqZwT/ZQTHXes0gRT+gR5EQ7f700r2C0SaVWopxnQufx4aomn/Ue1C1HhW9q8aqn7gut9TpCYXcd2eVWEuLNhepj0NeQF0yhJb5slKrAE1uHm+O028xsafGo9jYYQywwFkK4dMaXUfYSQ6V/XfAxNWpBAcg0aPBqduuuJayqg2WKIfRy+TYnfOIOwzkHxtzMkPTcYJCRHzMIhvSSTvKwfg4u3jF4lqsNcVmR1yomt9UYJsgL697bJIO3FR+N/KXPIJb4km1rbuGejws0m01wfi8IH4w2HMKju
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2026 13:54:50.3855 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1334ce3-0af7-4a83-8592-08df18b1124b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999151
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

Add support for LSDMA v8

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Frank Min<Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +
 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c       | 113 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h       |  31 +++++
 4 files changed, 149 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c
 create mode 100644 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 2ea1924571039..83e40f26ddf5f 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -92,7 +92,7 @@ amdgpu-y += \
 	sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o \
 	nbio_v7_9.o aqua_vanjaram.o nbio_v7_11.o lsdma_v7_0.o hdp_v7_0.o nbif_v6_3_1.o \
 	cyan_skillfish_reg_init.o soc_v1_0.o lsdma_v7_1.o nbio_v6_3_2.o nbio_v7_11_5.o \
-	nbif_v7_10.o hdp_v8_0.o
+	nbif_v7_10.o hdp_v8_0.o lsdma_v8_0.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
index 564f09c308816..202e0b80e5225 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c
@@ -95,6 +95,7 @@
 #include "lsdma_v6_0.h"
 #include "lsdma_v7_0.h"
 #include "lsdma_v7_1.h"
+#include "lsdma_v8_0.h"
 #include "vcn_v2_0.h"
 #include "jpeg_v2_0.h"
 #include "vcn_v3_0.h"
@@ -3979,6 +3980,9 @@ int amdgpu_discovery_set_ip_blocks(struct amdgpu_device *adev)
 	case IP_VERSION(7, 1, 0):
 		adev->lsdma.funcs = &lsdma_v7_1_funcs;
 		break;
+	case IP_VERSION(8, 0, 0):
+		adev->lsdma.funcs = &lsdma_v8_0_funcs;
+		break;
 	default:
 		break;
 	}
diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c b/drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c
new file mode 100644
index 0000000000000..f1dd02a56810b
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c
@@ -0,0 +1,113 @@
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
+#include "lsdma_v8_0.h"
+#include "amdgpu_lsdma.h"
+
+#include "lsdma/lsdma_8_0_1_offset.h"
+#include "lsdma/lsdma_8_0_1_sh_mask.h"
+
+static int lsdma_v8_0_wait_pio_status(struct amdgpu_device *adev)
+{
+	return amdgpu_lsdma_wait_for(adev, SOC15_REG_OFFSET(LSDMA, 0, regLSDMA_PIO_STATUS),
+			LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK,
+			LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK);
+}
+
+static int lsdma_v8_0_copy_mem(struct amdgpu_device *adev,
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
+	tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CMDPARAM);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_CMDPARAM, CMD_TYPE, 0);
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CMDPARAM, tmp);
+
+	tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, BYTE_COUNT, size);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_LOCATION, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_LOCATION, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_ADDR_INC, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_ADDR_INC, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, OVERLAP_DISABLE, 0);
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND, tmp);
+
+	ret = lsdma_v8_0_wait_pio_status(adev);
+	if (ret)
+		dev_err(adev->dev, "LSDMA PIO failed to copy memory!\n");
+
+	return ret;
+}
+
+static int lsdma_v8_0_fill_mem(struct amdgpu_device *adev,
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
+	tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CMDPARAM);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_CMDPARAM, CMD_TYPE, 1);
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_CMDPARAM, tmp);
+
+	tmp = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, BYTE_COUNT, size);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_LOCATION, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_LOCATION, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, SRC_ADDR_INC, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, DST_ADDR_INC, 0);
+	tmp = REG_SET_FIELD(tmp, LSDMA_PIO_COMMAND, OVERLAP_DISABLE, 0);
+	WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_COMMAND, tmp);
+
+	ret = lsdma_v8_0_wait_pio_status(adev);
+	if (ret)
+		dev_err(adev->dev, "LSDMA PIO failed to fill memory!\n");
+
+	return ret;
+}
+
+const struct amdgpu_lsdma_funcs lsdma_v8_0_funcs = {
+	.copy_mem = lsdma_v8_0_copy_mem,
+	.fill_mem = lsdma_v8_0_fill_mem,
+};
diff --git a/drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h b/drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h
new file mode 100644
index 0000000000000..648d5cc85c48e
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h
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
+#ifndef __LSDMA_V8_0_H__
+#define __LSDMA_V8_0_H__
+
+#include "soc15_common.h"
+
+extern const struct amdgpu_lsdma_funcs lsdma_v8_0_funcs;
+
+#endif /* __LSDMA_V8_0_H__ */
-- 
2.55.0


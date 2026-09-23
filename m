Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEC8CC9830B
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Sep 2026 15:33:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E1EC10E239;
	Wed, 23 Sep 2026 15:33:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="1fkvhMbJ";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013035.outbound.protection.outlook.com
 [40.107.201.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4814810E944
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Sep 2026 15:33:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UwmH7r16FQ3/aQTpFCRmvU4GDs7N9V+e1fGDcUk9imMbNkLMrC46CgcbcowzeBWYwDYzat24REB0XMfRqXThPUwXNvtu7FcgfxqPP2+3GwNyBJOmkLnbb7Dqb97+h6/5NrANxj0Da3rnL696ZB0D3H9kCvnI1Tf4pFFoZjQec6aKuVYxyAvZuM7K37A67RzBuNVfXuHswMg/ZeiSDCNYCZfS12R/a7YNfvCsg4V2gdUvGsyFyhV3SVZXTVtEL2KYi3RN0OVrcbrDc0DEEs0wNMQfI6ih5z5x04WHFuQD8M+lyuZo3ioVAQdQgNJhxfJdf7F6mDTtIktF/4idyXxQfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5f1kcSIKdbqjt2OtKW6iOO1kKtTAIAtEJ8NKGKjeFYs=;
 b=jjDLxDcLNVgJmB0s6LR+DSPsddoOORDNg5nMZQs7FP13+7IMkoy20MwDmHZXFwyfYtliVZ/r05BcKNLZgs6krjo7DTVDEr4EPvxeQ79/P81yCOILzLCNg1/TBV7Jej2yuvXGBrtAEGmnn+eF+0lq4vW424frMWG+idAhijItUkjtQH7gbZlmKqXLtgnJ+1R5TuE9LArY+UMQbUlrRORtFpIhV2Abl1gF8ThkFYiWzqw5wKQIKnncoL00GWBvhgAc9KFw1Vsvpao+tdcRoOEdk6QoCZzEP2tmrJtfS6lcXT5MEW5m0eU190TnY81f6kWkfT5+lZeTfk7Yp+ExBvXf5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5f1kcSIKdbqjt2OtKW6iOO1kKtTAIAtEJ8NKGKjeFYs=;
 b=1fkvhMbJpCLfWAPw8tvTlb0tQuY32tXeM1CuMnk/Z2N9ZoIzBlzSroIC9cnDRZ1ERBQwvbcsO0i4jm+44++LML9i7OF0BvGDwU4Bsp4GEGYgwdBbvKcf4fNwGKS5Sj3a8epgirJsmzl86s86n3Vi9JAlxW/dBUwHW6JG58W6Dcw=
Received: from SJ0PR03CA0038.namprd03.prod.outlook.com (2603:10b6:a03:33e::13)
 by IA0PR12MB7505.namprd12.prod.outlook.com (2603:10b6:208:443::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.15; Wed, 23 Sep
 2026 15:33:18 +0000
Received: from SJ1PEPF0000231B.namprd03.prod.outlook.com
 (2603:10b6:a03:33e:cafe::74) by SJ0PR03CA0038.outlook.office365.com
 (2603:10b6:a03:33e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.13 via Frontend Transport; Wed,
 23 Sep 2026 15:33:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF0000231B.mail.protection.outlook.com (10.167.242.232) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Wed, 23 Sep 2026 15:33:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:33:14 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 23 Sep
 2026 10:33:14 -0500
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 23 Sep 2026 10:33:13 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Likun Gao <Likun.Gao@amd.com>, Frank Min <Frank.Min@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amdgpu: add support for lsdma v8
Date: Wed, 23 Sep 2026 11:33:03 -0400
Message-ID: <20260923153303.2807340-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260923153303.2807340-1-alexander.deucher@amd.com>
References: <20260923153303.2807340-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231B:EE_|IA0PR12MB7505:EE_
X-MS-Office365-Filtering-Correlation-Id: f7536c2c-0138-42a3-2284-08df1987fda7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|56012099006|11063799006|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: VAW9GmE6CyDD1IXozV0LGzGetTkL1s5PjCsPzy9HYAw3DgZkJn/3V6FOq2ZCz1jiz4wMYW2gt2UaiJSXj6AuZBL3ff4NKbLVIMSU/WYOQ4WsOjkD9emQ6u62YB8IMrC60Ab2a24Uqk1n23QlbeMVBlozv5rFWgFLiRSd6viqznk6AqC1hR2g8xOPr6LMzdvxn/nIdND3g+LIN8CRNqudV8L7zz5Yo/wwsaVVC0/K7y4b6S9gvNmJ+lgU0X3uC2K0MB2lk7u+WTlOUIJYYteaczzMrE4OASust0J++TP7cHH7DFoTAAul38I1PmpGgrHZzAJKFasFZ63Bf4qLwhMqZal4CZigNcGpCOpecFNBNbEjgrTirCG0gqZ5BMYDL/qKX+nX4Nbgu4qQYXzux5vkopgniMVJp4O67xvDVw7Mv5aiA0xftP7aghvXp2209vKrCyDmNfAFUi4aCDWC4+J8DQQZfJ9dplq/THma2Bxn7WuRzRdCqHMi87VIzN0CtfsPGV5TDOjlqO0ER+yCNzeXKECWiIvie8UtVwLTFinJCM9jxIvkDNKPnJ1qSdaQ6eWwrJiQmqc0D2rADhmZv3USXKx1ohlNPzdu31pM/02iyr9O2gezwDYPQDBPgNYz6T8gTk01ywe/fCQeztNngZBdsQO8IVJjPvR2oejflUXkyQQx4tV2LgEjCEC+MsKzdSpyZ8toPb3zP7cRu1GzbJN+RA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 67pGnLE3l0bADW/UgDj+6xLi6NT2fiEhRysXimUkrghHdVLV//NUkrA3OU7iCjkn4z7kAiFyYnILDUBu4w9Uvdqv5eN5YZFEVigSPAaesWoCakrrzJSahINVOfrvaSEoJpfZtz5tTyRJC3PBkPTHXPaPyJGpm2GbnyAikIE/Eua0FQcFpzY7+hqciL7QWsOvAJRuObY/PwoCbhezLrDMrLQjuzsJfIZ0koTRIugi9HXvMdWPYGEAjCICkwiiqW/qj74WGdqfmj3a7DdenQGs+FgVyefeyU06iWgAr2ZArFfB/ttjpSt/YU/CH6bZjfmWaof+AiHeA0MFqFQwaKpI11q0DQ0u/PHJqOD3PL2rm6/QOgsISka6kSMw6q3JtKe4CZcn8/z8/M21jZ1RbM+Yij8mv0QyjSp/oB7JTjYjXx3LDegcYuts0nLK6224QwDC
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2026 15:33:17.5494 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f7536c2c-0138-42a3-2284-08df1987fda7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231B.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7505
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

v2: fix wait_pio_status() per Philip's comments.

Signed-off-by: Likun Gao <Likun.Gao@amd.com>
Reviewed-by: Frank Min<Frank.Min@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_discovery.c |   4 +
 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c       | 138 ++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.h       |  31 ++++
 4 files changed, 174 insertions(+), 1 deletion(-)
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
index 0000000000000..d19d7f8add50e
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/lsdma_v8_0.c
@@ -0,0 +1,138 @@
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
+	u32 error_mask;
+	u32 reg;
+	int r;
+
+	r = amdgpu_lsdma_wait_for(adev, SOC15_REG_OFFSET(LSDMA, 0, regLSDMA_PIO_STATUS),
+			LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK,
+			LSDMA_PIO_STATUS__PIO_IDLE_MASK | LSDMA_PIO_STATUS__PIO_FIFO_EMPTY_MASK);
+	if (r)
+		return r;
+
+	error_mask = LSDMA_PIO_STATUS__ERROR_WRRET_NACK_GEN_ERR_MASK |
+		     LSDMA_PIO_STATUS__ERROR_RDRET_NACK_GEN_ERR_MASK |
+		     LSDMA_PIO_STATUS__ERROR_INVALID_ADDR_MASK |
+		     LSDMA_PIO_STATUS__ERROR_ZERO_COUNT_MASK |
+		     LSDMA_PIO_STATUS__ERROR_DRAM_ECC_MASK;
+
+	reg = RREG32_SOC15(LSDMA, 0, regLSDMA_PIO_STATUS);
+	if (reg & error_mask) {
+		dev_warn(adev->dev, "LSDMA PIO error status bits 0x%x\n", reg & error_mask);
+
+		/*
+		 * write 1 to clear only the set lsdma error status bits
+		 */
+		WREG32_SOC15(LSDMA, 0, regLSDMA_PIO_STATUS, reg & error_mask);
+		return -EIO;
+	}
+
+	return 0;
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


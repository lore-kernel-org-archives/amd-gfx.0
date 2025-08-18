Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9524CCA0EE4
	for <amd-gfx@archiver.kernel.org>; Mon, 18 Aug 2025 20:05:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DE7110E4C1;
	Mon, 18 Aug 2025 20:05:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="a6RAFQam";
	dkim-atps=neutral
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DDD1C10E4C0
 for <amd-gfx@lists.freedesktop.org>; Mon, 18 Aug 2025 20:05:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fhgInDoeflbxgvNbT2AABR+QLgMvA3Y3XKWkga8zg2TgXggs12RET7EkNn0ZSqHWjBTLhpOaOdDi0gvF0k3zHZp9/TOM4thzEXflfqjxpSQOn7g80AlVrUKztBipTZY2vLxwNG9xKSpbOpTWTpecUv4Wj0NHGg549I/AkVI/YSZIpKUDKEsac5HFSgXXZHxZE3UyIr/ugJUZV7XtKZ7sUAD75wasX+WMK/CZvv/J4ZwqPSP6dw99rhtK5pqrDOTUt6jRM1FPlSufttwtpnBteFD/AZGsOhv1Dpsv2ba7W7WT6VfjnQwwPPCHe1NFGQa4wO6ZsKHDsYK1HKD0DewrtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6SPMLaeclyIOuy4b9EmLakEyGJieDIjY2TTqSiAMus=;
 b=VWQVYTC2o8E2hsctO766htOSj3/dVwiOPy/eQpxn/fsRNarRY0HtVgClgtRBce4MEzjhzzMGYl6lhn0Lk070++1tQsuWxPHIFGQ9Q0krhKTC0Xf9BeXvtfjjEoVr1LMeoMP2jaa/Az8Lly7DouWm+KQQJJTGBFYpH2km0rY+QnHA8/UCevtd7r8oDM97Tsg1p1qFKobZr5N53PA7pCKtcP+DFbiIFAzgog0ouN6680fJfXg4E6esHnhvb6h3JqjjdVGfirhdBFWZcXSGkPdnkeff7pihjs9YXz3K4VMaPzvUEXDzdw/TNrPwHFElZ5+Ut/CEPp8R+1d3x+8Ouu/kSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6SPMLaeclyIOuy4b9EmLakEyGJieDIjY2TTqSiAMus=;
 b=a6RAFQamoCDW6LexqS5Y8XxkUOlrV/ofmJqfQ6vqIWsU5cHnU8l1bfZCTbj5Y1vi19uZXx2gzSkAZYOr9aKLHxOfRGtU8K7P15nqXVo0GxJEngKZDh2p9aEcfyaltv46DIO2L01oHSPj6h0DB4jrMYfuagOplNH/Zj1CJoHblsI=
Received: from BYAPR06CA0068.namprd06.prod.outlook.com (2603:10b6:a03:14b::45)
 by PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Mon, 18 Aug
 2025 20:05:04 +0000
Received: from SJ5PEPF00000205.namprd05.prod.outlook.com
 (2603:10b6:a03:14b:cafe::2c) by BYAPR06CA0068.outlook.office365.com
 (2603:10b6:a03:14b::45) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.21 via Frontend Transport; Mon,
 18 Aug 2025 20:05:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF00000205.mail.protection.outlook.com (10.167.244.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9052.8 via Frontend Transport; Mon, 18 Aug 2025 20:05:04 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Aug
 2025 15:05:01 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 2/5] drm/amdgpu: add ip offset support for cyan skillfish
Date: Mon, 18 Aug 2025 16:04:42 -0400
Message-ID: <20250818200445.437007-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818200445.437007-1-alexander.deucher@amd.com>
References: <20250818200445.437007-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF00000205:EE_|PH7PR12MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: 75882415-feba-449f-4575-08ddde92857a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Jfi7vXpbpq2kyfyq3m5tQDjd8orBKRh0IzdlxxYGJjTt91WFtQ/RnzWwxztn?=
 =?us-ascii?Q?iNBT4PaF2myS2WJoTMNFtNc9r1IuGUvGKZw4oIIA+zKy7yWslmT0YnBmXOBG?=
 =?us-ascii?Q?9ZiIkjfr6JSZQ06QI1G+lQlCwGnsEv0s/+zOYNhpTY4v5B3s3XtyXseAgz2q?=
 =?us-ascii?Q?SDsmUlVQnC7RT0/vltp5Gmw93TZDwTs2crpkCCSFUuatlw0T8v2Y5fIVqNrl?=
 =?us-ascii?Q?fgXXc5RGZXao8HVD12Xacu5sJJah1bwJqQSCY+UT1ZfLTbRfzyTGaOPCyjjL?=
 =?us-ascii?Q?igDfNvpiWd6Px/0jNRbWqSAVG0SMg78mFCIn1G386oDu1nHwHiDolbzh3Tmc?=
 =?us-ascii?Q?yY+zadNOiPAAkTAjqymxNz2aRcc04lOHDAyoXmosWqPPk4dMXqMoiF0R8W9f?=
 =?us-ascii?Q?zBhunpzqAb0kybydugisOO3OIbnJvYOUo8dKY9oeoCo6fJCTq/qPkk43NVI+?=
 =?us-ascii?Q?SUcmt94e63SuS5gKbL3Nf8dKjYbraSiD3dm9QWj+yHlKDimbHrbyO7VUYblf?=
 =?us-ascii?Q?sqpzC8NrHTZI/4DJPrU0nQL4xdPaf96TFC5Jv1PWHHQYJAJIcTKB+G1dQ3Zd?=
 =?us-ascii?Q?lgCqGhew2gd4Zi8CHVKrKpoxhoVzMe32uBWp3M+zPBVfOtcfhNwE1JvKsryV?=
 =?us-ascii?Q?/fuR6de42kI+M7L2YAaeeCwFLkcR2BrdZxghZzv05W3r17RDBwDfMTQUdZ9C?=
 =?us-ascii?Q?JEyjM7kBk+Nr0a89QGDDPedFwZnFaFGvuCXXnJw24ykdJM6vIZQt/R9bqTJi?=
 =?us-ascii?Q?DrPJ4Pbx/xVh4JjpLxMQ/a/2NvgTMCmhofIPjwTqySLwpjyJvPCvG9Vu0DN/?=
 =?us-ascii?Q?gQI7dyPwNZh6zQFC2VnC3ONh5Khurr9dnLawDgvRpHPt785Hp6W59u6+NAKJ?=
 =?us-ascii?Q?b4caf7x+i32q6M5ZqSo6cnFepLeVhqYvG33jqikDmeck2Zk4WG1XnF78lQ1r?=
 =?us-ascii?Q?21j0OpC63T6ueL7kc8gvrMA75DANmW4e3O0pqUvYHslFH9HCcmCupXsIbMRD?=
 =?us-ascii?Q?P6oTAgHPyF3a3Ch2T0D+VJA6jLoBMKwXl1Hik/P07unSghOUAiy6WnNHZktr?=
 =?us-ascii?Q?gOsh6PE7qVzY7lSB+dobIZTI2eyHH6GTmU1v1Btj6b2b8plO+52MF6zjCZ8a?=
 =?us-ascii?Q?IuLmpYwlON0Ia3HH553HbiYRBLpoxcc/ovnyVYNM9kPqXUOGtFR7ZaDe37yD?=
 =?us-ascii?Q?2pMc5XyouNhzMra61rGtsxyncOpOAUoHiZaV3B1eNSwS2Fqn3YGTUg5ScuqV?=
 =?us-ascii?Q?OxwkoMOA3k8zqJ0aGN36IQh9pXqEILa5jZGpqlRm85dGiGwScGZN5Pkj2NrE?=
 =?us-ascii?Q?7lAVaP218lSvi9UVkhFEWPrHOhQgGy3Zql81UiLfPIQOtLlqF0/kNOaHRl8u?=
 =?us-ascii?Q?Y+FHuMkPlNLrRBJvFQixHnmweV3QLRtlzdLUowEnJaUs0lGWJw+KiYCQXyrr?=
 =?us-ascii?Q?TEAX/vplihqvaPZQMdqJfS1psTMtM7MGA5CIyw8VrGQTloJt0m4Uxc/ReMLH?=
 =?us-ascii?Q?9/lyuDTCzgxLa/OkjarO968AMRmftEA0JXvS?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2025 20:05:04.1118 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75882415-feba-449f-4575-08ddde92857a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF00000205.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6000
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

For chips that don't have IP discovery tables.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/Makefile           |  3 +-
 .../drm/amd/amdgpu/cyan_skillfish_reg_init.c  | 56 +++++++++++++++++++
 drivers/gpu/drm/amd/amdgpu/nv.h               |  1 +
 3 files changed, 59 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c

diff --git a/drivers/gpu/drm/amd/amdgpu/Makefile b/drivers/gpu/drm/amd/amdgpu/Makefile
index 930de203d533c..2d0fea87af79f 100644
--- a/drivers/gpu/drm/amd/amdgpu/Makefile
+++ b/drivers/gpu/drm/amd/amdgpu/Makefile
@@ -84,7 +84,8 @@ amdgpu-y += \
 	vega20_reg_init.o nbio_v7_4.o nbio_v2_3.o nv.o arct_reg_init.o mxgpu_nv.o \
 	nbio_v7_2.o hdp_v4_0.o hdp_v5_0.o aldebaran_reg_init.o aldebaran.o soc21.o soc24.o \
 	sienna_cichlid.o smu_v13_0_10.o nbio_v4_3.o hdp_v6_0.o nbio_v7_7.o hdp_v5_2.o lsdma_v6_0.o \
-	nbio_v7_9.o aqua_vanjaram.o nbio_v7_11.o lsdma_v7_0.o hdp_v7_0.o nbif_v6_3_1.o
+	nbio_v7_9.o aqua_vanjaram.o nbio_v7_11.o lsdma_v7_0.o hdp_v7_0.o nbif_v6_3_1.o \
+	cyan_skillfish_reg_init.o
 
 # add DF block
 amdgpu-y += \
diff --git a/drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c b/drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c
new file mode 100644
index 0000000000000..96616a865aac7
--- /dev/null
+++ b/drivers/gpu/drm/amd/amdgpu/cyan_skillfish_reg_init.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018 Advanced Micro Devices, Inc.
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
+#include "nv.h"
+
+#include "soc15_common.h"
+#include "soc15_hw_ip.h"
+#include "cyan_skillfish_ip_offset.h"
+
+int cyan_skillfish_reg_base_init(struct amdgpu_device *adev)
+{
+	/* HW has more IP blocks,  only initialized the blocke needed by driver */
+	uint32_t i;
+
+	adev->gfx.xcc_mask = 1;
+	for (i = 0 ; i < MAX_INSTANCE ; ++i) {
+		adev->reg_offset[GC_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
+		adev->reg_offset[HDP_HWIP][i] = (uint32_t *)(&(HDP_BASE.instance[i]));
+		adev->reg_offset[MMHUB_HWIP][i] = (uint32_t *)(&(MMHUB_BASE.instance[i]));
+		adev->reg_offset[ATHUB_HWIP][i] = (uint32_t *)(&(ATHUB_BASE.instance[i]));
+		adev->reg_offset[NBIO_HWIP][i] = (uint32_t *)(&(NBIO_BASE.instance[i]));
+		adev->reg_offset[MP0_HWIP][i] = (uint32_t *)(&(MP0_BASE.instance[i]));
+		adev->reg_offset[MP1_HWIP][i] = (uint32_t *)(&(MP1_BASE.instance[i]));
+		adev->reg_offset[VCN_HWIP][i] = (uint32_t *)(&(UVD0_BASE.instance[i]));
+		adev->reg_offset[DF_HWIP][i] = (uint32_t *)(&(DF_BASE.instance[i]));
+		adev->reg_offset[DCE_HWIP][i] = (uint32_t *)(&(DMU_BASE.instance[i]));
+		adev->reg_offset[OSSSYS_HWIP][i] = (uint32_t *)(&(OSSSYS_BASE.instance[i]));
+		adev->reg_offset[SDMA0_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
+		adev->reg_offset[SDMA1_HWIP][i] = (uint32_t *)(&(GC_BASE.instance[i]));
+		adev->reg_offset[SMUIO_HWIP][i] = (uint32_t *)(&(SMUIO_BASE.instance[i]));
+		adev->reg_offset[THM_HWIP][i] = (uint32_t *)(&(THM_BASE.instance[i]));
+		adev->reg_offset[CLK_HWIP][i] = (uint32_t *)(&(CLK_BASE.instance[i]));
+	}
+	return 0;
+}
diff --git a/drivers/gpu/drm/amd/amdgpu/nv.h b/drivers/gpu/drm/amd/amdgpu/nv.h
index 83e9782aef39d..8f4817404f10d 100644
--- a/drivers/gpu/drm/amd/amdgpu/nv.h
+++ b/drivers/gpu/drm/amd/amdgpu/nv.h
@@ -31,5 +31,6 @@ extern const struct amdgpu_ip_block_version nv_common_ip_block;
 void nv_grbm_select(struct amdgpu_device *adev,
 		    u32 me, u32 pipe, u32 queue, u32 vmid);
 void nv_set_virt_ops(struct amdgpu_device *adev);
+int cyan_skillfish_reg_base_init(struct amdgpu_device *adev);
 
 #endif
-- 
2.50.1


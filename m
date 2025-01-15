Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 668AFC02180
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jan 2025 16:29:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E049410E065;
	Wed, 15 Jan 2025 16:29:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dTchvpQu";
	dkim-atps=neutral
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDE5F10E065
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jan 2025 16:29:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ProqSVvNWUkAXNQP/DHOWgb4e4uEuPTaKQtML47pPd8xwMYPGa1TOIClxw914ND8VxN7LA3pNI9YjNOcPeaFqX3nAGCSpFjTjmRKGwWFqqvE0n4ts6IeH7JEa1R5xCAzoh/qo+XCV8jMFTt+yTDoHUDWXZkYhp3Wvcn7m/7+Gp4E6sLDwkyLikGPpwlt1jlL0QUfBSas4ODvD7iwwJecDyaIZ8NS6mjJ306M9iONJ8W0EtJvbH3p1fx0RhS4FphwYTq9EwneKP6L443w4fMH8Rz3KpgVqsGqS6qA1uG8/ybbN2tKa+4YLR6nnfayJxDTH9z2cXfko6INGAWwCM5Aqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5rFBrFIkRw4e1BSDmlY3AKMa3NlbQuqzVtBra6CJsiU=;
 b=EiHuY8LfAdTouL096pJ371SD00CzM8/eixz4vgW5yKEZ/HA2HYBa5Sc1waBrkFxi0JK1lx75gwEQat8sxQBMjjrxih/LHcmPJRBd2TBgVAEZTMc2x3CVRnwIA84sC4mZHg8ZsvTRIsSZLYrBF8OLDfklg5aNNwQMAkIDUglI8lv8jcix8v4sGpVJ77uY3U06W0z2knwqYJpj0O90CwqqmykU08BF7y2uz7YmoopAZ5k0Cc1m/ulUsSdNAE35pnieC9VIssYSXSSMTeSWaNwkt9LYe6t9qu2HAIE9N20zmTdJ34i9+paPlwv7xoHeKXV97R6GDA65EDVh6QuuFnnwfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5rFBrFIkRw4e1BSDmlY3AKMa3NlbQuqzVtBra6CJsiU=;
 b=dTchvpQuLiN524X6ukqPfD8PqPRdCA13ysnGbfMwJ631MeEL27NNXiIbcxTwAm7HzDtuaRVD4cbFtNkXtIXDHwth5ZCcKDAcOkZQDhlwtqvu2oUws09s7vXvf60+ac1VuLuWgekxOmN4zqvz9P/NvmBzdBiObR61UAB1L4I5EVw=
Received: from BY3PR05CA0059.namprd05.prod.outlook.com (2603:10b6:a03:39b::34)
 by SJ0PR12MB6877.namprd12.prod.outlook.com (2603:10b6:a03:47f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.12; Wed, 15 Jan
 2025 16:29:13 +0000
Received: from SJ1PEPF00002324.namprd03.prod.outlook.com
 (2603:10b6:a03:39b:cafe::e6) by BY3PR05CA0059.outlook.office365.com
 (2603:10b6:a03:39b::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Wed,
 15 Jan 2025 16:29:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00002324.mail.protection.outlook.com (10.167.242.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 16:29:13 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 15 Jan
 2025 10:29:11 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Asad Kamal <asad.kamal@amd.com>, Lijo Lazar <lijo.lazar@amd.com>, "Alex
 Deucher" <alexander.deucher@amd.com>
Subject: [PATCH 2/2] drm/amd/pm: Add SMUv13.0.12 PPT interface
Date: Wed, 15 Jan 2025 11:28:20 -0500
Message-ID: <20250115162820.637642-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250115162820.637642-1-alexander.deucher@amd.com>
References: <20250115162820.637642-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002324:EE_|SJ0PR12MB6877:EE_
X-MS-Office365-Filtering-Correlation-Id: d64a96fc-0c2f-4ac6-3bb8-08dd3581bf93
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Spzu6CdNYYUR6/17x3wGzVwhx6jdbizyAJys9GmwSxI6HqQUr9wBF1Jo+o7g?=
 =?us-ascii?Q?reQjHFRKkvbs0J33J8pLHsODkeWNwVaTj20Fu/B6NfgQSK3IToGKttOWILdf?=
 =?us-ascii?Q?CHnXt3SkEPMZypeMW5TcXFxi93DeRcz21fkhEP1fFdoi2P55Tf+hcS/bMVPH?=
 =?us-ascii?Q?DSq0McReGTf3234QBAR3OHWkMPNB4pQcxMuUjKxEcCIlqaq9wAekXh0z/dBL?=
 =?us-ascii?Q?qGuPACXzZxbKgycTU2KTIHjXhC7x1BzzlHoFpCKA9Jf32Xk4lOyr87H4/IT3?=
 =?us-ascii?Q?5tiBZTPVUGxDWKpIMvKyU+qaClOAr/+/6L+a3CAUb9x63YMpTnE8RsKEcobf?=
 =?us-ascii?Q?r4wMi9+I/z/1SoTQKvvukxDY5u6rvRwJZcqrVXBRL+1bcgJRJdPDaYWcjl8Y?=
 =?us-ascii?Q?NsFvWTMq9dNZvIdMxl6RY+zFlKcCL8Ntqlsqhr+YScs3x/ZQ5Kke9YgAtVMp?=
 =?us-ascii?Q?k24wGsZEbO5QY2Z6BiKV+wB1kmT3cmGrUqxudN/b6N1WrIusdi3XPi1Du4X0?=
 =?us-ascii?Q?0MGJqAJclzTH1Z3hwN/h3DupSusld9tW2ovVUlfZKU5wtmWGMH5Z8I58Mir6?=
 =?us-ascii?Q?hVrtMTjZKSKQcXXp/xwxawpVLgxg9Z9nTEP9HlLhM5gCLZODIYNmKbUTz6hA?=
 =?us-ascii?Q?xCVveOZpmBXJBMrXLVnbGpc9k5xBIah3IOSbmpMLJzy0c8LmCL8A/e5DM1MB?=
 =?us-ascii?Q?K9bqD4xxuL3Wy/DxErI9kUSVwrVwTbcubVQTJcgOHiysWx6DXuF5yB2skEyI?=
 =?us-ascii?Q?AmDXuZt46ao+jN7VnvbbAvccfj+/PtkmKJ8Vk+R7v9l5qJv/jWDpxqaTc39d?=
 =?us-ascii?Q?CoyXlZToJGaIPK+4hLw/mpNZBFhi8mCHs1OL2TGb/ZR4IH5OWr4L5QtpW0/4?=
 =?us-ascii?Q?Vv4fEqC1VdG0yqAXDvmmp8zAm4Q6p151fhVuNfbIaYt+9QgmVL6qVPA7UpoJ?=
 =?us-ascii?Q?joQ0k0h9niteyd2lX4M3LAb5nJTr8RJJx7DxDij4gUNNaszx1m2D4MUakGzV?=
 =?us-ascii?Q?J7cRekB/0AnskhAqiGsxlDQLtk+UXTKNx0VtoYVnqLb9UmMNtDxX2Jsjfflh?=
 =?us-ascii?Q?ErVAnx+UvJJ7E/E3Edj87NcggViyYt8Pc6Y8o2HuNojwmAdBOzMmtVopvFL2?=
 =?us-ascii?Q?fY3LlKek15ydvN/T1p4dGphtct+A/KRvyN6xLZkrMa0DQziu0CQDoxB51uHC?=
 =?us-ascii?Q?g21ardvUD7ejBdElq2Fw/WZuUanAmtTESwptZNnWfw2LYZACfN0QkhGv/BNb?=
 =?us-ascii?Q?i5qTESSurMbRnvjzT7MugppcRFWBAKXlTvoWWvhrbP5sds+JA4lp7ViJhmkh?=
 =?us-ascii?Q?9WE+XsF8coWdfHgTcvLLY38OLeDC9rVNt+UJXr0OGwaY6qvKnl2h3SXC44cf?=
 =?us-ascii?Q?AD1K8PPPM3vXJCklyEnWoBhSS/4mYOEXu/BX+keEagYw+eZal7gtVYCC8wNf?=
 =?us-ascii?Q?paeAGCYhOJPlqonfzHfQRaOYG4m3cMSs52DPUdTE5i5Yq5jB7K0tAw=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 16:29:13.5910 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d64a96fc-0c2f-4ac6-3bb8-08dd3581bf93
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002324.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6877
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

From: Asad Kamal <asad.kamal@amd.com>

Add SMUv13.0.12 PPT interface to fetch metrics data

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../drm/amd/pm/swsmu/inc/smu_v13_0_12_ppt.h   |  35 ++
 drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile   |   2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 468 ++++++++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  23 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h  |   2 +
 5 files changed, 526 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_12_ppt.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_12_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_12_ppt.h
new file mode 100644
index 0000000000000..2855adde40f5e
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_12_ppt.h
@@ -0,0 +1,35 @@
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
+#ifndef __SMU_V13_0_12_PPT_H__
+#define __SMU_V13_0_12_PPT_H__
+
+int smu_v13_0_12_tables_init(struct smu_context *smu);
+int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu);
+int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
+				      MetricsMember_t member,
+				      uint32_t *value);
+bool smu_v13_0_12_is_dpm_running(struct smu_context *smu);
+ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table);
+extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
+
+#endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile b/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
index 7f3493b6c53c3..e8d9b284869aa 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
@@ -24,7 +24,7 @@
 # It provides the smu management services for the driver.
 
 SMU13_MGR = smu_v13_0.o aldebaran_ppt.o yellow_carp_ppt.o smu_v13_0_0_ppt.o smu_v13_0_4_ppt.o \
-	    smu_v13_0_5_ppt.o smu_v13_0_7_ppt.o smu_v13_0_6_ppt.o
+	    smu_v13_0_5_ppt.o smu_v13_0_7_ppt.o smu_v13_0_12_ppt.o smu_v13_0_6_ppt.o
 
 AMD_SWSMU_SMU13MGR = $(addprefix $(AMD_SWSMU_PATH)/smu13/,$(SMU13_MGR))
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
new file mode 100644
index 0000000000000..b8a2cdaf09169
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -0,0 +1,468 @@
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
+#define SWSMU_CODE_LAYER_L2
+
+#include <linux/firmware.h>
+#include "amdgpu.h"
+#include "amdgpu_smu.h"
+#include "smu_v13_0_12_pmfw.h"
+#include "smu_v13_0_6_ppt.h"
+#include "smu13_driver_if_v13_0_6.h"
+#include "smu_v13_0.h"
+#include "smu_v13_0_12_ppt.h"
+#include "amdgpu_xgmi.h"
+#include <linux/pci.h>
+#include "smu_cmn.h"
+
+#undef MP1_Public
+#undef smnMP1_FIRMWARE_FLAGS
+
+/*
+ * DO NOT use these for err/warn/info/debug messages.
+ * Use dev_err, dev_warn, dev_info and dev_dbg instead.
+ * They are more MGPU friendly.
+ */
+#undef pr_err
+#undef pr_warn
+#undef pr_info
+#undef pr_debug
+
+#define to_amdgpu_device(x) (container_of(x, struct amdgpu_device, pm.smu_i2c))
+
+#define SMU_13_0_12_FEA_MAP(smu_feature, smu_13_0_12_feature)                    \
+	[smu_feature] = { 1, (smu_13_0_12_feature) }
+
+#define FEATURE_MASK(feature) (1ULL << feature)
+#define SMC_DPM_FEATURE                                                        \
+	(FEATURE_MASK(FEATURE_DATA_CALCULATION) |                              \
+	 FEATURE_MASK(FEATURE_DPM_GFXCLK) | FEATURE_MASK(FEATURE_DPM_UCLK) |   \
+	 FEATURE_MASK(FEATURE_DPM_SOCCLK) | FEATURE_MASK(FEATURE_DPM_FCLK) |   \
+	 FEATURE_MASK(FEATURE_DPM_LCLK) | FEATURE_MASK(FEATURE_DPM_XGMI) |     \
+	 FEATURE_MASK(FEATURE_DPM_VCN))
+
+const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[SMU_FEATURE_COUNT] = {
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DATA_CALCULATIONS_BIT, 		FEATURE_DATA_CALCULATION),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DPM_GFXCLK_BIT, 			FEATURE_DPM_GFXCLK),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DPM_UCLK_BIT, 			FEATURE_DPM_UCLK),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DPM_SOCCLK_BIT, 			FEATURE_DPM_SOCCLK),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DPM_FCLK_BIT, 			FEATURE_DPM_FCLK),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DPM_LCLK_BIT, 			FEATURE_DPM_LCLK),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DPM_VCLK_BIT,			FEATURE_DPM_VCN),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DPM_DCLK_BIT,			FEATURE_DPM_VCN),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DPM_XGMI_BIT, 			FEATURE_DPM_XGMI),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DS_GFXCLK_BIT, 			FEATURE_DS_GFXCLK),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DS_SOCCLK_BIT, 			FEATURE_DS_SOCCLK),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DS_LCLK_BIT, 			FEATURE_DS_LCLK),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DS_FCLK_BIT, 			FEATURE_DS_FCLK),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_VCN_DPM_BIT, 			FEATURE_DPM_VCN),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_PPT_BIT, 			FEATURE_PPT),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_TDC_BIT, 			FEATURE_TDC),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_APCC_DFLL_BIT, 			FEATURE_APCC_DFLL),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_MP1_CG_BIT, 			FEATURE_SMU_CG),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_FW_CTF_BIT, 			FEATURE_FW_CTF),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_THERMAL_BIT, 			FEATURE_THERMAL),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_SOC_PCC_BIT, 			FEATURE_SOC_PCC),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_XGMI_PER_LINK_PWR_DWN_BIT,	FEATURE_XGMI_PER_LINK_PWR_DOWN),
+};
+
+struct PPTable_t {
+	uint32_t MaxSocketPowerLimit;
+	uint32_t MaxGfxclkFrequency;
+	uint32_t MinGfxclkFrequency;
+	uint32_t FclkFrequencyTable[4];
+	uint32_t UclkFrequencyTable[4];
+	uint32_t SocclkFrequencyTable[4];
+	uint32_t VclkFrequencyTable[4];
+	uint32_t DclkFrequencyTable[4];
+	uint32_t LclkFrequencyTable[4];
+	uint32_t MaxLclkDpmRange;
+	uint32_t MinLclkDpmRange;
+	uint64_t PublicSerialNumber_AID;
+	bool Init;
+};
+
+#define SMUQ10_TO_UINT(x) ((x) >> 10)
+#define SMUQ10_FRAC(x) ((x) & 0x3ff)
+#define SMUQ10_ROUND(x) ((SMUQ10_TO_UINT(x)) + ((SMUQ10_FRAC(x)) >= 0x200))
+
+int smu_v13_0_12_tables_init(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct smu_table *tables = smu_table->tables;
+	struct amdgpu_device *adev = smu->adev;
+
+	if (!(adev->flags & AMD_IS_APU))
+		SMU_TABLE_INIT(tables, SMU_TABLE_PMSTATUSLOG, SMU13_TOOL_SIZE,
+			       PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
+
+	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS,
+		       sizeof(MetricsTable_t),
+		       PAGE_SIZE,
+		       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT);
+
+	SMU_TABLE_INIT(tables, SMU_TABLE_I2C_COMMANDS, sizeof(SwI2cRequest_t),
+		       PAGE_SIZE,
+		       AMDGPU_GEM_DOMAIN_VRAM | AMDGPU_GEM_DOMAIN_GTT);
+
+	smu_table->metrics_table = kzalloc(sizeof(MetricsTable_t), GFP_KERNEL);
+	if (!smu_table->metrics_table)
+		return -ENOMEM;
+	smu_table->metrics_time = 0;
+
+	smu_table->gpu_metrics_table_size = sizeof(struct gpu_metrics_v1_6);
+	smu_table->gpu_metrics_table =
+		kzalloc(smu_table->gpu_metrics_table_size, GFP_KERNEL);
+	if (!smu_table->gpu_metrics_table) {
+		kfree(smu_table->metrics_table);
+		return -ENOMEM;
+	}
+
+	smu_table->driver_pptable =
+		kzalloc(sizeof(struct PPTable_t), GFP_KERNEL);
+	if (!smu_table->driver_pptable) {
+		kfree(smu_table->metrics_table);
+		kfree(smu_table->gpu_metrics_table);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+int smu_v13_0_12_setup_driver_pptable(struct smu_context *smu)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	MetricsTable_t *metrics = (MetricsTable_t *)smu_table->metrics_table;
+	struct PPTable_t *pptable =
+		(struct PPTable_t *)smu_table->driver_pptable;
+	int ret, i, retry = 100;
+	uint32_t table_version;
+
+	/* Store one-time values in driver PPTable */
+	if (!pptable->Init) {
+		while (--retry) {
+			ret = smu_v13_0_6_get_metrics_table(smu, NULL, true);
+			if (ret)
+				return ret;
+
+			/* Ensure that metrics have been updated */
+			if (metrics->AccumulationCounter)
+				break;
+
+			usleep_range(1000, 1100);
+		}
+
+		if (!retry)
+			return -ETIME;
+
+		ret = smu_cmn_send_smc_msg(smu, SMU_MSG_GetMetricsVersion,
+					   &table_version);
+		if (ret)
+			return ret;
+		smu_table->tables[SMU_TABLE_SMU_METRICS].version =
+			table_version;
+
+		pptable->MaxSocketPowerLimit =
+			SMUQ10_ROUND(metrics->MaxSocketPowerLimit);
+		pptable->MaxGfxclkFrequency =
+			SMUQ10_ROUND(metrics->MaxGfxclkFrequency);
+		pptable->MinGfxclkFrequency =
+			SMUQ10_ROUND(metrics->MinGfxclkFrequency);
+
+		for (i = 0; i < 4; ++i) {
+			pptable->FclkFrequencyTable[i] =
+				SMUQ10_ROUND(metrics->FclkFrequencyTable[i]);
+			pptable->UclkFrequencyTable[i] =
+				SMUQ10_ROUND(metrics->UclkFrequencyTable[i]);
+			pptable->SocclkFrequencyTable[i] =
+				SMUQ10_ROUND(metrics->SocclkFrequencyTable[i]);
+			pptable->VclkFrequencyTable[i] =
+				SMUQ10_ROUND(metrics->VclkFrequencyTable[i]);
+			pptable->DclkFrequencyTable[i] =
+				SMUQ10_ROUND(metrics->DclkFrequencyTable[i]);
+			pptable->LclkFrequencyTable[i] =
+				SMUQ10_ROUND(metrics->LclkFrequencyTable[i]);
+		}
+
+		/* use AID0 serial number by default */
+		pptable->PublicSerialNumber_AID = metrics->PublicSerialNumber_AID[0];
+
+		pptable->Init = true;
+	}
+
+	return 0;
+}
+
+int smu_v13_0_12_get_smu_metrics_data(struct smu_context *smu,
+				      MetricsMember_t member,
+				      uint32_t *value)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	MetricsTable_t *metrics = (MetricsTable_t *)smu_table->metrics_table;
+	struct amdgpu_device *adev = smu->adev;
+	int ret = 0;
+	int xcc_id;
+
+	ret = smu_v13_0_6_get_metrics_table(smu, NULL, false);
+	if (ret)
+		return ret;
+
+	/* For clocks with multiple instances, only report the first one */
+	switch (member) {
+	case METRICS_CURR_GFXCLK:
+	case METRICS_AVERAGE_GFXCLK:
+		xcc_id = GET_INST(GC, 0);
+		*value = SMUQ10_ROUND(metrics->GfxclkFrequency[xcc_id]);
+		break;
+	case METRICS_CURR_SOCCLK:
+	case METRICS_AVERAGE_SOCCLK:
+		*value = SMUQ10_ROUND(metrics->SocclkFrequency[0]);
+		break;
+	case METRICS_CURR_UCLK:
+	case METRICS_AVERAGE_UCLK:
+		*value = SMUQ10_ROUND(metrics->UclkFrequency);
+		break;
+	case METRICS_CURR_VCLK:
+		*value = SMUQ10_ROUND(metrics->VclkFrequency[0]);
+		break;
+	case METRICS_CURR_DCLK:
+		*value = SMUQ10_ROUND(metrics->DclkFrequency[0]);
+		break;
+	case METRICS_CURR_FCLK:
+		*value = SMUQ10_ROUND(metrics->FclkFrequency);
+		break;
+	case METRICS_AVERAGE_GFXACTIVITY:
+		*value = SMUQ10_ROUND(metrics->SocketGfxBusy);
+		break;
+	case METRICS_AVERAGE_MEMACTIVITY:
+		*value = SMUQ10_ROUND(metrics->DramBandwidthUtilization);
+		break;
+	case METRICS_CURR_SOCKETPOWER:
+		*value = SMUQ10_ROUND(metrics->SocketPower) << 8;
+		break;
+	case METRICS_TEMPERATURE_HOTSPOT:
+		*value = SMUQ10_ROUND(metrics->MaxSocketTemperature) *
+			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	case METRICS_TEMPERATURE_MEM:
+		*value = SMUQ10_ROUND(metrics->MaxHbmTemperature) *
+			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	/* This is the max of all VRs and not just SOC VR.
+	 * No need to define another data type for the same.
+	 */
+	case METRICS_TEMPERATURE_VRSOC:
+		*value = SMUQ10_ROUND(metrics->MaxVrTemperature) *
+			 SMU_TEMPERATURE_UNITS_PER_CENTIGRADES;
+		break;
+	default:
+		*value = UINT_MAX;
+		break;
+	}
+
+	return ret;
+}
+
+static int smu_v13_0_12_get_enabled_mask(struct smu_context *smu,
+					 uint64_t *feature_mask)
+{
+	int ret;
+
+	ret = smu_cmn_get_enabled_mask(smu, feature_mask);
+
+	if (ret == -EIO) {
+		*feature_mask = 0;
+		ret = 0;
+	}
+
+	return ret;
+}
+
+bool smu_v13_0_12_is_dpm_running(struct smu_context *smu)
+{
+	int ret;
+	uint64_t feature_enabled;
+
+	ret = smu_v13_0_12_get_enabled_mask(smu, &feature_enabled);
+
+	if (ret)
+		return false;
+
+	return !!(feature_enabled & SMC_DPM_FEATURE);
+}
+
+ssize_t smu_v13_0_12_get_gpu_metrics(struct smu_context *smu, void **table)
+{
+	struct smu_table_context *smu_table = &smu->smu_table;
+	struct gpu_metrics_v1_6 *gpu_metrics =
+		(struct gpu_metrics_v1_6 *)smu_table->gpu_metrics_table;
+	int ret = 0, xcc_id, inst, i, j, k, idx;
+	struct amdgpu_device *adev = smu->adev;
+	MetricsTable_t *metrics;
+	struct amdgpu_xcp *xcp;
+	u32 inst_mask;
+
+	metrics = kzalloc(sizeof(MetricsTable_t), GFP_KERNEL);
+	ret = smu_v13_0_6_get_metrics_table(smu, metrics, true);
+	if (ret) {
+		kfree(metrics);
+		return ret;
+	}
+
+	smu_cmn_init_soft_gpu_metrics(gpu_metrics, 1, 6);
+
+	gpu_metrics->temperature_hotspot =
+		SMUQ10_ROUND(metrics->MaxSocketTemperature);
+	/* Individual HBM stack temperature is not reported */
+	gpu_metrics->temperature_mem =
+		SMUQ10_ROUND(metrics->MaxHbmTemperature);
+	/* Reports max temperature of all voltage rails */
+	gpu_metrics->temperature_vrsoc =
+		SMUQ10_ROUND(metrics->MaxVrTemperature);
+
+	gpu_metrics->average_gfx_activity =
+		SMUQ10_ROUND(metrics->SocketGfxBusy);
+	gpu_metrics->average_umc_activity =
+		SMUQ10_ROUND(metrics->DramBandwidthUtilization);
+
+	gpu_metrics->curr_socket_power =
+		SMUQ10_ROUND(metrics->SocketPower);
+	/* Energy counter reported in 15.259uJ (2^-16) units */
+	gpu_metrics->energy_accumulator = metrics->SocketEnergyAcc;
+
+	for (i = 0; i < MAX_GFX_CLKS; i++) {
+		xcc_id = GET_INST(GC, i);
+		if (xcc_id >= 0)
+			gpu_metrics->current_gfxclk[i] =
+				SMUQ10_ROUND(metrics->GfxclkFrequency[xcc_id]);
+
+		if (i < MAX_CLKS) {
+			gpu_metrics->current_socclk[i] =
+				SMUQ10_ROUND(metrics->SocclkFrequency[i]);
+			inst = GET_INST(VCN, i);
+			if (inst >= 0) {
+				gpu_metrics->current_vclk0[i] =
+					SMUQ10_ROUND(metrics->VclkFrequency[inst]);
+				gpu_metrics->current_dclk0[i] =
+					SMUQ10_ROUND(metrics->DclkFrequency[inst]);
+			}
+		}
+	}
+
+	gpu_metrics->current_uclk = SMUQ10_ROUND(metrics->UclkFrequency);
+
+	/* Total accumulated cycle counter */
+	gpu_metrics->accumulation_counter = metrics->AccumulationCounter;
+
+	/* Accumulated throttler residencies */
+	gpu_metrics->prochot_residency_acc = metrics->ProchotResidencyAcc;
+	gpu_metrics->ppt_residency_acc = metrics->PptResidencyAcc;
+	gpu_metrics->socket_thm_residency_acc = metrics->SocketThmResidencyAcc;
+	gpu_metrics->vr_thm_residency_acc = metrics->VrThmResidencyAcc;
+	gpu_metrics->hbm_thm_residency_acc = metrics->HbmThmResidencyAcc;
+
+	/* Clock Lock Status. Each bit corresponds to each GFXCLK instance */
+	gpu_metrics->gfxclk_lock_status = metrics->GfxLockXCDMak >> GET_INST(GC, 0);
+
+	if (!(adev->flags & AMD_IS_APU)) {
+		gpu_metrics->pcie_link_width = metrics->PCIeLinkWidth;
+		gpu_metrics->pcie_link_speed =
+				pcie_gen_to_speed(metrics->PCIeLinkSpeed);
+
+		gpu_metrics->pcie_bandwidth_acc =
+				SMUQ10_ROUND(metrics->PcieBandwidthAcc[0]);
+		gpu_metrics->pcie_bandwidth_inst =
+				SMUQ10_ROUND(metrics->PcieBandwidth[0]);
+		gpu_metrics->pcie_l0_to_recov_count_acc =
+				metrics->PCIeL0ToRecoveryCountAcc;
+		gpu_metrics->pcie_replay_count_acc =
+				metrics->PCIenReplayAAcc;
+		gpu_metrics->pcie_replay_rover_count_acc =
+				metrics->PCIenReplayARolloverCountAcc;
+		gpu_metrics->pcie_nak_sent_count_acc =
+				metrics->PCIeNAKSentCountAcc;
+		gpu_metrics->pcie_nak_rcvd_count_acc =
+				metrics->PCIeNAKReceivedCountAcc;
+		gpu_metrics->pcie_lc_perf_other_end_recovery =
+				metrics->PCIeOtherEndRecoveryAcc;
+
+	}
+
+	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
+
+	gpu_metrics->gfx_activity_acc =
+		SMUQ10_ROUND(metrics->SocketGfxBusyAcc);
+	gpu_metrics->mem_activity_acc =
+		SMUQ10_ROUND(metrics->DramBandwidthUtilizationAcc);
+
+	for (i = 0; i < NUM_XGMI_LINKS; i++) {
+		gpu_metrics->xgmi_read_data_acc[i] =
+			SMUQ10_ROUND(metrics->XgmiReadDataSizeAcc[i]);
+		gpu_metrics->xgmi_write_data_acc[i] =
+			SMUQ10_ROUND(metrics->XgmiWriteDataSizeAcc[i]);
+	}
+
+	gpu_metrics->num_partition = adev->xcp_mgr->num_xcps;
+
+	for_each_xcp(adev->xcp_mgr, xcp, i) {
+		amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_VCN, &inst_mask);
+		idx = 0;
+		for_each_inst(k, inst_mask) {
+			/* Both JPEG and VCN has same instances */
+			inst = GET_INST(VCN, k);
+
+			for (j = 0; j < adev->jpeg.num_jpeg_rings; ++j) {
+				gpu_metrics->xcp_stats[i].jpeg_busy
+					[(idx * adev->jpeg.num_jpeg_rings) + j] =
+					SMUQ10_ROUND(metrics->JpegBusy
+							[(inst * adev->jpeg.num_jpeg_rings) + j]);
+			}
+			gpu_metrics->xcp_stats[i].vcn_busy[idx] =
+			       SMUQ10_ROUND(metrics->VcnBusy[inst]);
+			idx++;
+
+		}
+
+		amdgpu_xcp_get_inst_details(xcp, AMDGPU_XCP_GFX, &inst_mask);
+		idx = 0;
+		for_each_inst(k, inst_mask) {
+			inst = GET_INST(GC, k);
+			gpu_metrics->xcp_stats[i].gfx_busy_inst[idx] =
+				SMUQ10_ROUND(metrics->GfxBusy[inst]);
+			gpu_metrics->xcp_stats[i].gfx_busy_acc[idx] =
+				SMUQ10_ROUND(metrics->GfxBusyAcc[inst]);
+			idx++;
+		}
+	}
+
+	gpu_metrics->xgmi_link_width = SMUQ10_ROUND(metrics->XgmiWidth);
+	gpu_metrics->xgmi_link_speed = SMUQ10_ROUND(metrics->XgmiBitrate);
+
+	gpu_metrics->firmware_timestamp = metrics->Timestamp;
+
+	*table = (void *)gpu_metrics;
+	kfree(metrics);
+
+	return sizeof(*gpu_metrics);
+}
+
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index f358a8abe91e5..6f25e657f1a29 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -36,6 +36,7 @@
 #include "atom.h"
 #include "power_state.h"
 #include "smu_v13_0.h"
+#include "smu_v13_0_12_ppt.h"
 #include "smu_v13_0_6_ppt.h"
 #include "nbio/nbio_7_4_offset.h"
 #include "nbio/nbio_7_4_sh_mask.h"
@@ -522,7 +523,10 @@ static int smu_v13_0_6_init_smc_tables(struct smu_context *smu)
 {
 	int ret = 0;
 
-	ret = smu_v13_0_6_tables_init(smu);
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12))
+		ret = smu_v13_0_12_tables_init(smu);
+	else
+		ret = smu_v13_0_6_tables_init(smu);
 	if (ret)
 		return ret;
 
@@ -544,7 +548,7 @@ static int smu_v13_0_6_get_allowed_feature_mask(struct smu_context *smu,
 	return 0;
 }
 
-static int smu_v13_0_6_get_metrics_table(struct smu_context *smu,
+int smu_v13_0_6_get_metrics_table(struct smu_context *smu,
 					 void *metrics_table, bool bypass_cache)
 {
 	struct smu_table_context *smu_table = &smu->smu_table;
@@ -620,6 +624,9 @@ static int smu_v13_0_6_setup_driver_pptable(struct smu_context *smu)
 	int ret, i, retry = 100;
 	uint32_t table_version;
 
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12))
+		return smu_v13_0_12_setup_driver_pptable(smu);
+
 	/* Store one-time values in driver PPTable */
 	if (!pptable->Init) {
 		while (--retry) {
@@ -995,6 +1002,9 @@ static int smu_v13_0_6_get_smu_metrics_data(struct smu_context *smu,
 	int ret = 0;
 	int xcc_id;
 
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12))
+		return smu_v13_0_12_get_smu_metrics_data(smu, member, value);
+
 	ret = smu_v13_0_6_get_metrics_table(smu, NULL, false);
 	if (ret)
 		return ret;
@@ -2054,6 +2064,9 @@ static bool smu_v13_0_6_is_dpm_running(struct smu_context *smu)
 	int ret;
 	uint64_t feature_enabled;
 
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12))
+		return smu_v13_0_12_is_dpm_running(smu);
+
 	ret = smu_v13_0_6_get_enabled_mask(smu, &feature_enabled);
 
 	if (ret)
@@ -2347,6 +2360,9 @@ static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table
 	u16 link_width_level;
 	u32 inst_mask;
 
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12))
+		return smu_v13_0_12_get_gpu_metrics(smu, table);
+
 	metrics_x = kzalloc(max(sizeof(MetricsTableX_t), sizeof(MetricsTableA_t)), GFP_KERNEL);
 	ret = smu_v13_0_6_get_metrics_table(smu, metrics_x, true);
 	if (ret) {
@@ -3452,7 +3468,8 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
 	smu->ppt_funcs = &smu_v13_0_6_ppt_funcs;
 	smu->message_map = smu_v13_0_6_message_map;
 	smu->clock_map = smu_v13_0_6_clk_map;
-	smu->feature_map = smu_v13_0_6_feature_mask_map;
+	smu->feature_map = (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12)) ?
+		smu_v13_0_12_feature_mask_map : smu_v13_0_6_feature_mask_map;
 	smu->table_map = smu_v13_0_6_table_map;
 	smu->smc_driver_if_version = SMU13_0_6_DRIVER_IF_VERSION;
 	smu->smc_fw_caps |= SMU_FW_CAP_RAS_PRI;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
index f0fa42a645c05..21a7e066c629c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.h
@@ -28,5 +28,7 @@
 #define SMU_13_0_6_UMD_PSTATE_MCLK_LEVEL 0x2
 
 extern void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu);
+extern int smu_v13_0_6_get_metrics_table(struct smu_context *smu,
+					 void *metrics_table, bool bypass_cache);
 
 #endif
-- 
2.47.1


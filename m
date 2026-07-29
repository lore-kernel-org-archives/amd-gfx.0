Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CBA2C54F51
	for <amd-gfx@archiver.kernel.org>; Wed, 29 Jul 2026 09:40:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D3FAC10E66E;
	Wed, 29 Jul 2026 09:40:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MhY/5Bhv";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E22E10E66E
 for <amd-gfx@lists.freedesktop.org>; Wed, 29 Jul 2026 09:40:19 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsXjZ0XUYg+CnCRvubEcCRIb8NxlK1pD9tHwRvblVAWbyHW3W11YCLuFK2kDPftfnNwP8drSGvZzh+ORMgSB0SSKZ2PlkcsWQYS27la+wFuz7YHG9R9cRyc2yMKPWa2WUA4BeY8+RFj9mthLFjjImlWvBmvDWx9mQ4jyLnkk3+pRhIviq+Kk+wv+mkPvRWQy+/37PjbnHPKFc5omcQP59pE22t/EtCoZ+skGvYF2UrGM9hsPwXfc5CcuS7gslUPtIGcUiBBDcjZLL/ZoVR5q8F4XkDr42L6IO3k//Ew/BWtUVTSHC6kEqaaN0lzb7pjPQzR+BWSSSm6rBHnRvjtHxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6ZhPysIrSqU/AsuhddG5pu+D9ub3Q8J69vltqoU6QLI=;
 b=jJ8MutmvL3aoNVVj6Zrauj3qubsyA+//HOdd1sxfiZwK8J3OLHuFFaWwlr7Wy+XwoyQvpadMdLQol9Uh/wws3y7vxrcCq1oeebvG4Y7DG2dYhwzONAzUBbr0PKnxkraxT2tb5e9F/JeynKppTTyeZtcY72WFU/tTyGwT3t8TQduTuMdBKTgbzCMU9u9pgYwrfwxLsUh6g7OWVYcT4eA6Qzupssr9+m3IT8vdOr4uE+9/adZaWzEy4oT1uDuRwl6nrlbWI8LmbrK14g5y/kSc4RRP5lo5cO3cl4sMkez7HD10aCA/PNHDoxele2EZiYdILuJ5BxhmJhx7bFdFzTXZPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6ZhPysIrSqU/AsuhddG5pu+D9ub3Q8J69vltqoU6QLI=;
 b=MhY/5BhviNofnjaccYgNgLmAgtTG4ujt80iaooA07YBKQY0tFU2GNUS29wnXSVRD9ttJx1jpDcHU6BgdcLMEKOVn7mI0R9bUJpYcIYmTK0cSeyiOFjSheJo9bliTkf82xY3hEhgLRZqGuXMqexhTe1Aa7STAYay2Y5cCnNcgtwo=
Received: from SJ0PR05CA0005.namprd05.prod.outlook.com (2603:10b6:a03:33b::10)
 by CH2PR12MB4166.namprd12.prod.outlook.com (2603:10b6:610:78::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 09:40:11 +0000
Received: from SJ1PEPF00002319.namprd03.prod.outlook.com
 (2603:10b6:a03:33b:cafe::5) by SJ0PR05CA0005.outlook.office365.com
 (2603:10b6:a03:33b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.7 via Frontend Transport; Wed, 29
 Jul 2026 09:40:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002319.mail.protection.outlook.com (10.167.242.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 09:40:10 +0000
Received: from shubhankar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Wed, 29 Jul 2026 04:40:07 -0500
From: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
To: <Alexander.Deucher@amd.com>, <Pratik.Vishwakarma@amd.com>,
 <Christian.Koenig@amd.com>, <Lijo.Lazar@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: <Shubhankar.MilindSardeshpande@amd.com>,
 <Veerabadhran.Gopalakrishnan@amd.com>, <Suresh.Guttula@amd.com>,
 <Kanala.RamalingeswaraReddy@amd.com>
Subject: [PATCH V6 1/2] drm/amd/pm/smu15: add metrics table header for SMU
 v15.0.0
Date: Wed, 29 Jul 2026 15:02:46 +0530
Message-ID: <20260729093928.2958771-1-Shubhankar.MilindSardeshpande@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002319:EE_|CH2PR12MB4166:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a2b83f7-0b31-4073-db41-08deed55624a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|5023799004|11063799006|56012099006|10067099003|3023799007|18002099003;
X-Microsoft-Antispam-Message-Info: uHI3Qn8pbaJxeAu/1lH2WnhrDF5fNzIW/douKCgMW3fH+I6QOjdSbWi1lV8JEplL0ucqsmciBG73fSEVkXQp6sa3qkEMMxz61kz4oGcxkcRDZw5gXU8JpMuzcBADLkU/pCxSLcneIs7QWLdvtOnV0V2PO5/RzuD0LtjCgdboFuNAYRxrMXoIexnSysrXMab8uS9mZcEfJFcAEesEu6sep820HXtPiV1IhqJT/RJ3kTECbgYuU/+yX3xvqQ0USiEmQ8VhYnZxFEpKuQIbLwQmsU1BxybPCJDxq8D0yr+Mer0m5V6LrZu9xKNYKuXJU2mN1S0Ox6+G/Lh1/t+wUu1F0NgvWT9antOiWWS3U2xH3BVNHTo8jcDZO3sgvUe3V1AoNyzDa4RLFm3dliN8ieNymg79Nqd/ayRlWXmd+opyxibkpvRLmaUX4dQ84Zv2NMox7uGxHHVYuy7EOzpJba3heRy6rkrF4Y+QgZcWDY9eOBKxniH65aTuWkHcW/N37TeCo7QijLYa0cip4L2DOTkeUtbQVNOyP5C/iGrkfJbRp8uY2rANwsSm/NeW81zUjrqGOJyLSJgS9l6Jn7+22PPd84TMlg5zLafqfhrX1aS/Puc+d/qgOlgKJvEk0YO0Xk8gccdaVdIgRzNWkRYUKPgJ9CIA5YcTlW12Hgn69+XKbtSJI88rrrpm1jeouovuPOPb4ug+gaZaUkTB4FCP8opN/w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(5023799004)(11063799006)(56012099006)(10067099003)(3023799007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BacwzHwwMRLl8LY9Nt1ZNnBhRhdK6yEQ7Q7mHslUg0siFbqyHhZQT1dvL14UCipnRnaYSvATkcvpB6woI2IaYOuudJ3OBXUdvEX7/IQgPKp1A78xxK3/EW3zRIHDUHkilMdjNvgFYsRZphG4io2ieUO/7DGgbtvYZIGXe/ZKHh2jSyn8GBNunMoCFbeLSa2XEIdZJ4oXmwCE0Gu6ftMEt9+YTPHwbfkioeLWr6ixlXP3RibhnwwMhuVNgCjCqqzLsah4RuOxTTqJ/4RJVrIOx5tRnx7rH6owJJ5TfnhL3tQYoFe6qxJzAypqqU8I7gu9fO6x29gLHOMOHfoG88KJAZh09gqcAgbFsEk0gH9sZlLsNaPMROofeogbn2cI0OLV09FeQlVmJbGuBIAfxhsN90fpzWIQMkbPeqqdvyWh7myF7ubVxZsTYJcJ20w/HwqF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 09:40:10.9008 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a2b83f7-0b31-4073-db41-08deed55624a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002319.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4166
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

V6 fixes: Change the commenting style to /*

Add smu_v15_0_0_metrics.h defining the v0x04 metrics table structures
(MetricsTable_IOD_t, MetricsTable_CCX_t, MetricsTable_t) exported by
SMU firmware. These structures describe voltage, power, thermal,
frequency, bandwidth, activity, and overclock telemetry fields used
for PM reporting on SMU v15.0.0 APUs.

Signed-off-by: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
---
 .../swsmu/inc/pmfw_if/smu_v15_0_0_metrics.h   | 230 ++++++++++++++++++
 1 file changed, 230 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_metrics.h

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_metrics.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_metrics.h
new file mode 100644
index 000000000000..698c08875760
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_metrics.h
@@ -0,0 +1,230 @@
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
+#ifndef __SMU_V15_0_0_METRICS_H__
+#define __SMU_V15_0_0_METRICS_H__
+
+#define METRICS_TABLE_VERSION 0x04
+#define NUM_MAX_CORES         12
+#define NUM_CLK_DPM_LEVELS    8
+#define METRIC_CORE_TYPE_MAX  4
+#define METRIC_CCX_MAX        4
+
+/* Variable Type | Description */
+#pragma pack(push, 4)
+typedef struct {
+uint32_t AccumulationCounter;
+
+/*SET_VOLTAGES */
+uint64_t VDDCR_SetVoltage;                                              /* Acc Float (V) */
+uint64_t VDDCR_SOC_SetVoltage;                                          /* Acc Float (V) */
+uint64_t VDDCR_NPU_SetVoltage;                                          /* Acc Float (V) */
+uint64_t VDDCR_LP_SetVoltage;                                           /* Acc Float (V) */
+uint64_t VDDCR_GFX_SetVoltage;                                          /* Acc Float (V) */
+uint64_t VDD_MISC_SetVoltage;                                           /* Acc Float (V) */
+
+/*TELEMETRY_VOLTAGES */
+uint64_t VDDCR_TelemetryVoltage;                                        /* Acc Float (V) */
+uint64_t VDDCR_SOC_TelemetryVoltage;                                    /* Acc Float (V) */
+uint64_t VDDCR_NPU_TelemetryVoltage;                                    /* Acc Float (V) */
+uint64_t VDDCR_LP_TelemetryVoltage;                                     /* Acc Float (V) */
+uint64_t VDDCR_GFX_TelemetryVoltage;                                    /* Acc Float (V) */
+uint64_t VDD_MISC_TelemetryVoltage;                                     /* Acc Float (V) */
+
+/*TELEMETRY_POWERS */
+uint64_t VDDCR_TelemetryPower;                                          /* Acc Float (W) */
+uint64_t VDDCR_SOC_TelemetryPower;                                      /* Acc Float (W) */
+uint64_t VDDCR_NPU_TelemetryPower;                                      /* Acc Float (W) */
+uint64_t VDDCR_LP_TelemetryPower;                                       /* Acc Float (W) */
+uint64_t VDDCR_GFX_TelemetryPower;                                      /* Acc Float (W) */
+uint64_t VDD_MISC_TelemetryPower;                                       /* Acc Float (W) */
+
+/*THROTTLERS */
+uint32_t fPPT_FusedLimit;                                               /* Inst Float (W) */
+uint32_t fPPT_MaxIrmLimit;                                              /* Inst Float (W) */
+uint32_t fPPT_MaxPboLimit;                                              /* Inst Float (W) */
+uint32_t fPPT_Limit;                                                    /* Inst Float (W) */
+uint64_t fPPT_ValueAcc;                                                 /* Acc Int (W) */
+uint32_t fPPT_ResidencyAcc;                                             /* Acc Float */
+
+uint32_t sPPT_FusedLimit;                                               /* Inst Float (W) */
+uint32_t sPPT_MaxIrmLimit;                                              /* Inst Float (W) */
+uint32_t sPPT_MaxPboLimit;                                              /* Inst Float (W) */
+uint32_t sPPT_Limit;                                                    /* Inst Float (W) */
+uint64_t sPPT_ValueAcc;                                                 /* Acc Int (W) */
+uint32_t sPPT_ResidencyAcc;                                             /* Acc Float */
+
+uint32_t SPL_FusedLimit;                                                /* Inst Float (W) */
+uint32_t SPL_MaxIrmLimit;                                               /* Inst Float (W) */
+uint32_t SPL_MaxPboLimit;                                               /* Inst Float (W) */
+uint32_t SPL_Limit;                                                     /* Inst Float (W) */
+uint64_t SPL_ValueAcc;                                                  /* Acc Int (W) */
+uint32_t SPL_ResidencyAcc;                                              /* Acc Float */
+
+uint32_t TDC_VDDCR_FusedLimit;                                          /* Inst Float (A) */
+uint32_t TDC_VDDCR_MaxIrmLimit;                                         /* Inst Float (A) */
+uint32_t TDC_VDDCR_MaxPboLimit;                                         /* Inst Float (A) */
+uint32_t TDC_VDDCR_Limit;                                               /* Inst Float (A) */
+uint64_t TDC_VDDCR_ValueAcc;                                            /* Acc Int    (A) */
+uint32_t TDC_VDDCR_ResidencyAcc;                                        /* Acc Float */
+
+uint32_t TDC_VDDCR_SOC_FusedLimit;                                      /* Inst Float (A) */
+uint32_t TDC_VDDCR_SOC_MaxIrmLimit;                                     /* Inst Float (A) */
+uint32_t TDC_VDDCR_SOC_MaxPboLimit;                                     /* Inst Float (A) */
+uint32_t TDC_VDDCR_SOC_Limit;                                           /* Inst Float (A) */
+uint64_t TDC_VDDCR_SOC_ValueAcc;                                        /* Acc Int    (A) */
+uint32_t TDC_VDDCR_SOC_ResidencyAcc;                                    /* Acc Float */
+
+uint32_t TDC_VDDCR_NPU_FusedLimit;                                      /* Inst Float (A) */
+uint32_t TDC_VDDCR_NPU_MaxIrmLimit;                                     /* Inst Float (A) */
+uint32_t TDC_VDDCR_NPU_MaxPboLimit;                                     /* Inst Float (A) */
+uint32_t TDC_VDDCR_NPU_Limit;                                           /* Inst Float (A) */
+uint64_t TDC_VDDCR_NPU_ValueAcc;                                        /* Acc Int    (A) */
+uint32_t TDC_VDDCR_NPU_ResidencyAcc;                                    /* Acc Float */
+
+uint32_t TDC_VDDCR_LP_FusedLimit;                                       /* Inst Float (A) */
+uint32_t TDC_VDDCR_LP_MaxIrmLimit;                                      /* Inst Float (A) */
+uint32_t TDC_VDDCR_LP_MaxPboLimit;                                      /* Inst Float (A) */
+uint32_t TDC_VDDCR_LP_Limit;                                            /* Inst Float (A) */
+uint64_t TDC_VDDCR_LP_ValueAcc;                                         /* Acc Int    (A) */
+uint32_t TDC_VDDCR_LP_ResidencyAcc;                                     /* Acc Float */
+
+uint32_t TDC_VDDCR_GFX_FusedLimit;                                      /* Inst Float (A) */
+uint32_t TDC_VDDCR_GFX_MaxIrmLimit;                                     /* Inst Float (A) */
+uint32_t TDC_VDDCR_GFX_MaxPboLimit;                                     /* Inst Float (A) */
+uint32_t TDC_VDDCR_GFX_Limit;                                           /* Inst Float (A) */
+uint64_t TDC_VDDCR_GFX_ValueAcc;                                        /* Acc Int    (A) */
+uint32_t TDC_VDDCR_GFX_ResidencyAcc;                                    /* Acc Float */
+
+uint32_t EDC_VDDCR_FusedLimit;                                          /* Inst Float (A) */
+uint32_t EDC_VDDCR_MaxIrmLimit;                                         /* Inst Float (A) */
+uint32_t EDC_VDDCR_MaxPboLimit;                                         /* Inst Float (A) */
+uint32_t EDC_VDDCR_Limit;                                               /* Inst Float (A) */
+
+uint32_t THM_FusedLimit;                                                /* Inst Float (C) */
+uint32_t THM_Limit;                                                     /* Inst Float (C) */
+uint64_t THM_ValueAcc;                                                  /* Acc Float  (C) */
+uint32_t THM_ResidencyAcc;                                              /* Acc Float */
+uint32_t PROCHOT_ResidencyAcc;                                          /* Acc Float */
+uint64_t GFX_TempAcc;                                                   /* Acc Float  (C) */
+uint64_t SOC_TempAcc;                                                   /* Acc Float  (C) */
+uint32_t P3T_FusedLimit;                                                /* Inst Float (W) */
+uint64_t P3T_ValueAcc;                                                  /* Acc Float  (W) */
+
+/*POWER */
+uint64_t SystemPowerAcc;                                                /* Acc Float (W) */
+uint64_t ApuPowerAcc;                                                   /* Acc Float (W) */
+uint64_t dGpuPowerAcc;                                                  /* Acc Float (W) */
+uint64_t NpuPowerAcc;                                                   /* Acc Float (W) */
+
+/*FREQUENCIES */
+uint64_t FclkFreqEffAcc;                                                /* Acc Float (MHz) */
+uint64_t MemclkFreqEffAcc;                                              /* Acc Float (MHz) */
+uint64_t LclkFreqEffAcc;                                                /* Acc Float (MHz) */
+uint64_t GfxclkFreqEffAcc;                                              /* Acc Float (MHz) */
+uint64_t SocclkFreqEffAcc;                                              /* Acc Float (MHz) */
+uint64_t VclkFreqEffAcc;                                                /* Acc Float (MHz) */
+uint64_t VpeclkFreqEffAcc;                                              /* Acc Float (MHz) */
+uint64_t AieclkFreqEffAcc;                                              /* Acc Float (MHz) */
+uint64_t NpuhclkFreqEffAcc;                                             /* Acc Float (MHz) */
+/*BANDWIDTH */
+uint64_t DramReadBandwidth;                                             /* Acc Float (GB/sec) */
+uint64_t DramWriteBandwidth;                                            /* Acc Float (GB/sec) */
+
+/*ACTIVITY MONITORS */
+uint64_t GfxBusyAcc;                                                    /* Acc Float (%) */
+uint64_t VcnBusyAcc;                                                    /* Acc Float (%) */
+uint64_t NpuBusyAcc[3];                                                 /* Acc Float (%) */
+
+/*STT */
+uint32_t STT_MinLimit;                                                  /* Inst Float (W) */
+uint64_t STT_APU_HotSpotTempAcc;                                        /* Acc Float (C) */
+uint64_t STT_HS2_HotSpotTempAcc;                                        /* Acc Float (C) */
+uint32_t STT_APU_Temp_Limit;                                            /* Inst Float (C) */
+uint64_t STT_APU_SkinTempAcc;                                           /* Acc Float (C) */
+
+/*RESIDENCIES */
+uint64_t CpuOffResidency_CCX0;                                          /* Acc Float (%) */
+uint64_t CpuOffResidency_CCX1;                                          /* Acc Float (%) */
+uint64_t CpuOffResidency_CCX2;                                          /* Acc Float (%) */
+uint64_t CpuOffResidency_CCX3;                                          /* Acc Float (%) */
+
+/*DFPSTATES */
+uint32_t FclkFreqTable[NUM_CLK_DPM_LEVELS];                             /* Inst Int (MHz) */
+uint32_t UclkFreqTable[NUM_CLK_DPM_LEVELS];                             /* Inst Int (MHz) */
+uint32_t DdrRateTable[NUM_CLK_DPM_LEVELS];                              /* Inst Int (MT/s) */
+uint8_t  DfPstate_Source[NUM_CLK_DPM_LEVELS];                           /* Inst Int */
+
+/*SYSTEM */
+uint8_t  GfxDisabled;                                                   /* Inst Int */
+uint8_t  spare2[3];
+uint32_t GfxClk_Fmax;                                                   /* Inst Float (GHz) */
+uint8_t  CClk_CoreFuseEnable[METRIC_CORE_TYPE_MAX][NUM_MAX_CORES];      /* Inst Int */
+uint8_t  CClk_CoreEnabled[METRIC_CORE_TYPE_MAX][NUM_MAX_CORES];         /* Inst Int */
+uint32_t CClk_Fmax[METRIC_CORE_TYPE_MAX][NUM_MAX_CORES];                /* Inst Float (GHz) */
+
+/*OVERCLOCK CAPABLE */
+uint8_t CpuPreciseAndDirectOverClockingCapable;                         /* Inst Int */
+uint8_t GfxPreciseAndDirectOverClockingCapable;                         /* Inst Int */
+uint8_t PboBasicOverClockingCapable;                                    /* Inst Int */
+uint8_t PboAdvancedOverClockingCapable;                                 /* Inst Int */
+uint8_t PboNitroOverClockingCapable;                                    /* Inst Int */
+uint8_t MemoryAndFabricOverClockingCapable;                             /* Inst Int */
+uint8_t MiscOverClockingCapable;                                        /* Inst Int */
+uint8_t ExtremeColdOverclockingCapable;                                 /* Inst Int */
+uint8_t DownConfigControlCapable;                                       /* Inst Int */
+uint8_t spare0[3];
+
+/*OVERCLOCK STATUS */
+uint32_t FIT_LimitScalar;                                               /* Inst Float */
+uint8_t  LN2Enabled;                                                    /* Inst Int */
+uint8_t  CpuPreciseAndDirectOcEnabled;                                  /* Inst Int */
+uint8_t  GfxPreciseAndDirectOcEnabled;                                  /* Inst Int */
+uint8_t  spare1[2];
+int8_t   PsmGuardband[5][5][3];                                         /* Inst Int */
+int32_t  CorePowerLimitOffset;                                          /* Inst Float (W) */
+uint32_t MaxFreqOffset[5];                                              /* Inst Float (GHz) */
+
+uint64_t NpuTempAcc;                                                    /* Acc Float (C) */
+uint64_t DfPStateResidencyAcc[NUM_CLK_DPM_LEVELS];                      /* Acc Int (%) */
+uint32_t CClk_Fboost;                                                   /* Inst Float (GHz) */
+uint32_t spare3[5];
+} MetricsTable_IOD_t;
+
+typedef struct {
+uint64_t Core_C0[NUM_MAX_CORES];                                        /* Acc Float (%) */
+uint64_t Core_CC6[NUM_MAX_CORES];                                       /* Acc Float (%) */
+uint64_t Core_FREQ[NUM_MAX_CORES];                                      /* Acc Float (GHz) */
+uint64_t Core_FREQEFF[NUM_MAX_CORES];                                   /* Acc Float (GHz) */
+uint64_t Core_TEMP[NUM_MAX_CORES];                                      /* Acc Float (C) */
+uint64_t Core_POWER[NUM_MAX_CORES];                                     /* Acc Float (W) */
+} MetricsTable_CCX_t;
+
+typedef struct {
+MetricsTable_IOD_t IOD;
+MetricsTable_CCX_t CCX[METRIC_CCX_MAX];
+} MetricsTable_t;
+
+#pragma pack(pop)
+
+#endif
-- 
2.43.0


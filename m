Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B6BFC4452A
	for <amd-gfx@archiver.kernel.org>; Mon, 20 Jul 2026 14:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A2D410E1AD;
	Mon, 20 Jul 2026 14:36:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ndVfzh8G";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012003.outbound.protection.outlook.com [40.107.209.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E18110E1AD
 for <amd-gfx@lists.freedesktop.org>; Mon, 20 Jul 2026 14:36:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ghFGRUPBoTrtwz8jTrEJNpvF+EzcvTjSG4sVRQlWqmWN/n2Y5LnhjuwRDb16dJxR/OgvMsaLwDfjaZf3f6mYNMPxzbjZp3Usle/MVas7QbiiA5B86rCzH0YyRnkgfFuMU1zUL6UGXrfMsvIyV9DIo5zTRW1S00QVegkmkFYXz9Mdzu0M5Z/yGSJBoS7uPSBFr1NbvObLaJmPbOOaiWLT/NwBv+tqE7/m8sDjQ7/g12j7Tie0YQEwxRyxBqTuTqDfgFKlHiS81lcgF3qt/C1BJuHEd2PBrFLD1A6S9HaV7DRu1j/dNOBG861weJ9Q+TXTeBBYkNhMIqPXtfXuGMqrhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoNowkhm3hEe7sD7afStsL3VsNmaK2qU1Vn5wc3j2b8=;
 b=O2xYzVQaJWYNbQRgG3yCPgoa1st3l/2d0itnsbg7z3MogWP3kNjjSU33qXtYwVhuapOyokCAPu7X5GSntXC7FGw7Cbza4rThODge7Dc7ceKJ/q3WCjSlnZzfo0op0bK5lwRMV/KZPj+7sLPriJvBe482WO3EnFzBznFh5ZnoqzUqKOdPqqwaXgSWHiMRiSQHhGrO/jFdKke9bdRwfB2tNoXnXBAmgBoA3HpGL/Ixi05MbsigKPGS73sucjAY72t1J7qhF06f0yHLVnIAiTdjVWU+j/HsqOBnIJM6TqBgezSCvdlEWDTjhnL5l42Dh582xQbUi8sPaokFU+SKNE86HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoNowkhm3hEe7sD7afStsL3VsNmaK2qU1Vn5wc3j2b8=;
 b=ndVfzh8GTag0v9iEXroIzbCsVtmPB5j73ZIJVCuJZcbikvm8pE9saLMtnQPKZbT4G3zlnofEh8HbbPnTJwPu/3k3ohLDiR9IlITEwPjpIBJfCBKbxjbKPSsBqnUafVRzZ/3S/pv09vYyxd2D7i+Ik0X7I7RVZKiz8qJWoftl3Gs=
Received: from MW4PR03CA0321.namprd03.prod.outlook.com (2603:10b6:303:dd::26)
 by MW4PR12MB7466.namprd12.prod.outlook.com (2603:10b6:303:212::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 14:36:30 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:303:dd:cafe::9f) by MW4PR03CA0321.outlook.office365.com
 (2603:10b6:303:dd::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Mon,
 20 Jul 2026 14:36:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Mon, 20 Jul 2026 14:36:30 +0000
Received: from shubhankar-X570-AORUS-ELITE.amd.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.41; Mon, 20 Jul 2026 09:36:27 -0500
From: Shubhankar Milind Sardeshpande <Shubhankar.MilindSardeshpande@amd.com>
To: <Alexander.Deucher@amd.com>, <Pratik.Vishwakarma@amd.com>,
 <Christian.Koenig@amd.com>, <Lijo.Lazar@amd.com>,
 <amd-gfx@lists.freedesktop.org>
CC: <Shubhankar.MilindsSardeshpande@amd.com>,
 <Veerabadhran.Gopalakrishnan@amd.com>, Shubhankar Milind Sardeshpande
 <Shubhankar.MilindSardeshpande@amd.com>
Subject: [PATCH 1/2] drm/amd/pm/smu15: add metrics table header for SMU v15.0.0
Date: Mon, 20 Jul 2026 20:03:32 +0530
Message-ID: <20260720143545.805691-1-Shubhankar.MilindSardeshpande@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|MW4PR12MB7466:EE_
X-MS-Office365-Filtering-Correlation-Id: 53aee0d6-bda9-4266-1011-08dee66c49bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|36860700016|376014|1800799024|3023799007|10067099003|5023799004|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: 7Xgjuxf581TKzHSQOnZHxHk67zvLGNFw17DJbIvDFPKryt1ltai23NuPgQx2oNbYMWoWwSkXuWk2NyI9Zk25m62jmN682N/1TfdGyxv0v91SvnpY7U4P7q5hmjLzoszLrfIRXRYhWiVa6MpZ36YYHe+gCgmd7+2IWDJgM+uuKpAs5xtQ+qSwcVETKt0h4RxOVdliEkOG0XCjWonCWF/JJf6Q21FdrHJhNNA7XheZ6WzU7V+yYiBt/St9nf5GkYZRPHoG/kdwzyuz4NV7yjTOd0/L/IoMxuvppRE7o9I2lPWuRv4PbcKBzv2YxpmUuULjgmWqJHfRxaZUb8qYv3B82hKpHAuBLYLKj/KpjntbRF65OyW/UVay1f1Iu+dsa8hFQVm5nLnA1xGF9r8kdCJar9uOg7b7UlaVPP0QM2i0RmIFHoPSz8I6VwMxTxv5jfXV3QrzI/jD32oMKjPHlT0Emm2d5cC2GXL0I8+C6sbKT5Q3TL7tBgEdHdkAyjUeH4kLW24PMr+2NVtupNqdZBqZhRToKIk+gfl6aZTLUciLNxT1X5W9TpThXakqZor6n8jlihUmLF4QUM/VWdapqCPbZ+7NbZk8ngWWyoDU1kSwZ7N0PSDuO84bb9oLBxLLlUuF31xEzZHK9NTye3QL1j24pHbwgwoaXiBHVNtiJYKROXocO/Cl6rdlRMFLGmHLwtDgqVxLtwwI9DDVRgfghGNjVw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(36860700016)(376014)(1800799024)(3023799007)(10067099003)(5023799004)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OVtbbV/J8+9UeK7zX5HFGJL+ZrQMJfemxaW+HOHfA04Xk2ev9sIumy5p7YItRzskucEoPyXJcgfOZzQ5Vagm2r5beQJbAFOzoIqd/DkpPZfV24VWMKw8OEy5n/9qWQ5nN85/x9RDZH2zjoGC3BAFsjZRLAAGx9ymJMRMnCmfCHvRsEe8HfI1Ef43C8nmE+AU5c0RozV97xYz/tG4Yn0toVYS77E6W8m42ueRVKXDKg2EP1L6pJMv7v7oz1Cfr4amkgYJo8v0dqrWoYsxXzDcgK+6J7NY0YMzZRI4VYiJnUkfZ+M9CX/yMJBf7TCgr1ZWbO8wECi4G1ll2jxiAzdhjYYHhayvdBUsEOIaQyDJGP7DWsGdCpW5sbOowZTqdJB9Tedz/QwvSOR7jmPKpcJTsIo3lcywRFdvTnFfuUh92HSN6CKpps8HikTkOFJWE0kA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 14:36:30.0207 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53aee0d6-bda9-4266-1011-08dee66c49bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7466
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
index 000000000000..19b4d84410a4
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_metrics.h
@@ -0,0 +1,230 @@
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
+#ifndef __SMU_V15_0_0_METRICS_H__
+#define __SMU_V15_0_0_METRICS_H__
+
+#define METRICS_TABLE_VERSION 0x04
+#define NUM_MAX_CORES         12
+#define NUM_CLK_DPM_LEVELS    8
+#define METRIC_CORE_TYPE_MAX  4
+#define METRIC_CCX_MAX        4
+
+// Variable Type | Description
+#pragma pack(push, 4)
+typedef struct {
+  uint32_t AccumulationCounter;
+
+  //SET_VOLTAGES
+  uint64_t VDDCR_SetVoltage;                                              // Acc Float (V)
+  uint64_t VDDCR_SOC_SetVoltage;                                          // Acc Float (V)
+  uint64_t VDDCR_NPU_SetVoltage;                                          // Acc Float (V)
+  uint64_t VDDCR_LP_SetVoltage;                                           // Acc Float (V)
+  uint64_t VDDCR_GFX_SetVoltage;                                          // Acc Float (V)
+  uint64_t VDD_MISC_SetVoltage;                                           // Acc Float (V)
+
+  //TELEMETRY_VOLTAGES
+  uint64_t VDDCR_TelemetryVoltage;                                        // Acc Float (V)
+  uint64_t VDDCR_SOC_TelemetryVoltage;                                    // Acc Float (V)
+  uint64_t VDDCR_NPU_TelemetryVoltage;                                    // Acc Float (V)
+  uint64_t VDDCR_LP_TelemetryVoltage;                                     // Acc Float (V)
+  uint64_t VDDCR_GFX_TelemetryVoltage;                                    // Acc Float (V)
+  uint64_t VDD_MISC_TelemetryVoltage;                                     // Acc Float (V)
+
+  //TELEMETRY_POWERS
+  uint64_t VDDCR_TelemetryPower;                                          // Acc Float (W)
+  uint64_t VDDCR_SOC_TelemetryPower;                                      // Acc Float (W)
+  uint64_t VDDCR_NPU_TelemetryPower;                                      // Acc Float (W)
+  uint64_t VDDCR_LP_TelemetryPower;                                       // Acc Float (W)
+  uint64_t VDDCR_GFX_TelemetryPower;                                      // Acc Float (W)
+  uint64_t VDD_MISC_TelemetryPower;                                       // Acc Float (W)
+
+  //THROTTLERS
+  uint32_t fPPT_FusedLimit;                                               // Inst Float (W)
+  uint32_t fPPT_MaxIrmLimit;                                              // Inst Float (W)
+  uint32_t fPPT_MaxPboLimit;                                              // Inst Float (W)
+  uint32_t fPPT_Limit;                                                    // Inst Float (W)
+  uint64_t fPPT_ValueAcc;                                                 // Acc Int (W)
+  uint32_t fPPT_ResidencyAcc;                                             // Acc Float
+
+  uint32_t sPPT_FusedLimit;                                               // Inst Float (W)
+  uint32_t sPPT_MaxIrmLimit;                                              // Inst Float (W)
+  uint32_t sPPT_MaxPboLimit;                                              // Inst Float (W)
+  uint32_t sPPT_Limit;                                                    // Inst Float (W)
+  uint64_t sPPT_ValueAcc;                                                 // Acc Int (W)
+  uint32_t sPPT_ResidencyAcc;                                             // Acc Float
+
+  uint32_t SPL_FusedLimit;                                                // Inst Float (W)
+  uint32_t SPL_MaxIrmLimit;                                               // Inst Float (W)
+  uint32_t SPL_MaxPboLimit;                                               // Inst Float (W)
+  uint32_t SPL_Limit;                                                     // Inst Float (W)
+  uint64_t SPL_ValueAcc;                                                  // Acc Int (W)
+  uint32_t SPL_ResidencyAcc;                                              // Acc Float
+
+  uint32_t TDC_VDDCR_FusedLimit;                                          // Inst Float (A)
+  uint32_t TDC_VDDCR_MaxIrmLimit;                                         // Inst Float (A)
+  uint32_t TDC_VDDCR_MaxPboLimit;                                         // Inst Float (A)
+  uint32_t TDC_VDDCR_Limit;                                               // Inst Float (A)
+  uint64_t TDC_VDDCR_ValueAcc;                                            // Acc Int    (A)
+  uint32_t TDC_VDDCR_ResidencyAcc;                                        // Acc Float
+
+  uint32_t TDC_VDDCR_SOC_FusedLimit;                                      // Inst Float (A)
+  uint32_t TDC_VDDCR_SOC_MaxIrmLimit;                                     // Inst Float (A)
+  uint32_t TDC_VDDCR_SOC_MaxPboLimit;                                     // Inst Float (A)
+  uint32_t TDC_VDDCR_SOC_Limit;                                           // Inst Float (A)
+  uint64_t TDC_VDDCR_SOC_ValueAcc;                                        // Acc Int    (A)
+  uint32_t TDC_VDDCR_SOC_ResidencyAcc;                                    // Acc Float
+
+  uint32_t TDC_VDDCR_NPU_FusedLimit;                                      // Inst Float (A)
+  uint32_t TDC_VDDCR_NPU_MaxIrmLimit;                                     // Inst Float (A)
+  uint32_t TDC_VDDCR_NPU_MaxPboLimit;                                     // Inst Float (A)
+  uint32_t TDC_VDDCR_NPU_Limit;                                           // Inst Float (A)
+  uint64_t TDC_VDDCR_NPU_ValueAcc;                                        // Acc Int    (A)
+  uint32_t TDC_VDDCR_NPU_ResidencyAcc;                                    // Acc Float
+
+  uint32_t TDC_VDDCR_LP_FusedLimit;                                       // Inst Float (A)
+  uint32_t TDC_VDDCR_LP_MaxIrmLimit;                                      // Inst Float (A)
+  uint32_t TDC_VDDCR_LP_MaxPboLimit;                                      // Inst Float (A)
+  uint32_t TDC_VDDCR_LP_Limit;                                            // Inst Float (A)
+  uint64_t TDC_VDDCR_LP_ValueAcc;                                         // Acc Int    (A)
+  uint32_t TDC_VDDCR_LP_ResidencyAcc;                                     // Acc Float
+
+  uint32_t TDC_VDDCR_GFX_FusedLimit;                                      // Inst Float (A)
+  uint32_t TDC_VDDCR_GFX_MaxIrmLimit;                                     // Inst Float (A)
+  uint32_t TDC_VDDCR_GFX_MaxPboLimit;                                     // Inst Float (A)
+  uint32_t TDC_VDDCR_GFX_Limit;                                           // Inst Float (A)
+  uint64_t TDC_VDDCR_GFX_ValueAcc;                                        // Acc Int    (A)
+  uint32_t TDC_VDDCR_GFX_ResidencyAcc;                                    // Acc Float
+
+  uint32_t EDC_VDDCR_FusedLimit;                                          // Inst Float (A)
+  uint32_t EDC_VDDCR_MaxIrmLimit;                                         // Inst Float (A)
+  uint32_t EDC_VDDCR_MaxPboLimit;                                         // Inst Float (A)
+  uint32_t EDC_VDDCR_Limit;                                               // Inst Float (A)
+
+  uint32_t THM_FusedLimit;                                                // Inst Float (C)
+  uint32_t THM_Limit;                                                     // Inst Float (C)
+  uint64_t THM_ValueAcc;                                                  // Acc Float  (C)
+  uint32_t THM_ResidencyAcc;                                              // Acc Float
+  uint32_t PROCHOT_ResidencyAcc;                                          // Acc Float
+  uint64_t GFX_TempAcc;                                                   // Acc Float  (C)
+  uint64_t SOC_TempAcc;                                                   // Acc Float  (C)
+  uint32_t P3T_FusedLimit;                                                // Inst Float (W)
+  uint64_t P3T_ValueAcc;                                                  // Acc Float  (W)
+
+  //POWER
+  uint64_t SystemPowerAcc;                                                // Acc Float (W)
+  uint64_t ApuPowerAcc;                                                   // Acc Float (W)
+  uint64_t dGpuPowerAcc;                                                  // Acc Float (W)
+  uint64_t NpuPowerAcc;                                                   // Acc Float (W)
+
+  //FREQUENCIES
+  uint64_t FclkFreqEffAcc;                                                // Acc Float (MHz)
+  uint64_t MemclkFreqEffAcc;                                              // Acc Float (MHz)
+  uint64_t LclkFreqEffAcc;                                                // Acc Float (MHz)
+  uint64_t GfxclkFreqEffAcc;                                              // Acc Float (MHz)
+  uint64_t SocclkFreqEffAcc;                                              // Acc Float (MHz)
+  uint64_t VclkFreqEffAcc;                                                // Acc Float (MHz)
+  uint64_t VpeclkFreqEffAcc;                                              // Acc Float (MHz)
+  uint64_t AieclkFreqEffAcc;                                              // Acc Float (MHz)
+  uint64_t NpuhclkFreqEffAcc;                                             // Acc Float (MHz)
+  //BANDWIDTH
+  uint64_t DramReadBandwidth;                                             // Acc Float (GB/sec)
+  uint64_t DramWriteBandwidth;                                            // Acc Float (GB/sec)
+
+  //ACTIVITY MONITORS
+  uint64_t GfxBusyAcc;                                                    // Acc Float (%)
+  uint64_t VcnBusyAcc;                                                    // Acc Float (%)
+  uint64_t NpuBusyAcc[3];                                                 // Acc Float (%)
+
+  //STT
+  uint32_t STT_MinLimit;                                                  // Inst Float (W)
+  uint64_t STT_APU_HotSpotTempAcc;                                        // Acc Float (C)
+  uint64_t STT_HS2_HotSpotTempAcc;                                        // Acc Float (C)
+  uint32_t STT_APU_Temp_Limit;                                            // Inst Float (C)
+  uint64_t STT_APU_SkinTempAcc;                                           // Acc Float (C)
+
+  //RESIDENCIES
+  uint64_t CpuOffResidency_CCX0;                                          // Acc Float (%)
+  uint64_t CpuOffResidency_CCX1;                                          // Acc Float (%)
+  uint64_t CpuOffResidency_CCX2;                                          // Acc Float (%)
+  uint64_t CpuOffResidency_CCX3;                                          // Acc Float (%)
+
+  //DFPSTATES
+  uint32_t FclkFreqTable[NUM_CLK_DPM_LEVELS];                             // Inst Int (MHz)
+  uint32_t UclkFreqTable[NUM_CLK_DPM_LEVELS];                             // Inst Int (MHz)
+  uint32_t DdrRateTable[NUM_CLK_DPM_LEVELS];                              // Inst Int (MT/s)
+  uint8_t  DfPstate_Source[NUM_CLK_DPM_LEVELS];                           // Inst Int
+
+  //SYSTEM
+  uint8_t  GfxDisabled;                                                   // Inst Int
+  uint8_t  spare2[3];
+  uint32_t GfxClk_Fmax;                                                   // Inst Float (GHz)
+  uint8_t  CClk_CoreFuseEnable[METRIC_CORE_TYPE_MAX][NUM_MAX_CORES];      // Inst Int
+  uint8_t  CClk_CoreEnabled[METRIC_CORE_TYPE_MAX][NUM_MAX_CORES];         // Inst Int
+  uint32_t CClk_Fmax[METRIC_CORE_TYPE_MAX][NUM_MAX_CORES];                // Inst Float (GHz)
+
+  //OVERCLOCK CAPABLE
+  uint8_t CpuPreciseAndDirectOverClockingCapable;                         // Inst Int
+  uint8_t GfxPreciseAndDirectOverClockingCapable;                         // Inst Int
+  uint8_t PboBasicOverClockingCapable;                                    // Inst Int
+  uint8_t PboAdvancedOverClockingCapable;                                 // Inst Int
+  uint8_t PboNitroOverClockingCapable;                                    // Inst Int
+  uint8_t MemoryAndFabricOverClockingCapable;                             // Inst Int
+  uint8_t MiscOverClockingCapable;                                        // Inst Int
+  uint8_t ExtremeColdOverclockingCapable;                                 // Inst Int
+  uint8_t DownConfigControlCapable;                                       // Inst Int
+  uint8_t spare0[3];
+
+  //OVERCLOCK STATUS
+  uint32_t FIT_LimitScalar;                                               // Inst Float
+  uint8_t  LN2Enabled;                                                    // Inst Int
+  uint8_t  CpuPreciseAndDirectOcEnabled;                                  // Inst Int
+  uint8_t  GfxPreciseAndDirectOcEnabled;                                  // Inst Int
+  uint8_t  spare1[2];
+  int8_t   PsmGuardband[5][5][3];                                         // Inst Int
+  int32_t  CorePowerLimitOffset;                                          // Inst Float (W)
+  uint32_t MaxFreqOffset[5];                                              // Inst Float (GHz)
+
+  uint64_t NpuTempAcc;                                                    // Acc Float (C)
+  uint64_t DfPStateResidencyAcc[NUM_CLK_DPM_LEVELS];                      // Acc Int (%)
+  uint32_t CClk_Fboost;                                                   // Inst Float (GHz)
+  uint32_t spare3[5];
+} MetricsTable_IOD_t;
+
+typedef struct {
+  uint64_t Core_C0[NUM_MAX_CORES];                                        // Acc Float (%)
+  uint64_t Core_CC6[NUM_MAX_CORES];                                       // Acc Float (%)
+  uint64_t Core_FREQ[NUM_MAX_CORES];                                      // Acc Float (GHz)
+  uint64_t Core_FREQEFF[NUM_MAX_CORES];                                   // Acc Float (GHz)
+  uint64_t Core_TEMP[NUM_MAX_CORES];                                      // Acc Float (C)
+  uint64_t Core_POWER[NUM_MAX_CORES];                                     // Acc Float (W)
+} MetricsTable_CCX_t;
+
+typedef struct {
+  MetricsTable_IOD_t IOD;
+  MetricsTable_CCX_t CCX[METRIC_CCX_MAX];
+} MetricsTable_t;
+
+#pragma pack(pop)
+
+#endif
-- 
2.43.0


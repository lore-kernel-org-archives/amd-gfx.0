Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36583C433FE
	for <amd-gfx@archiver.kernel.org>; Thu, 17 Feb 2022 20:19:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2C3810E78B;
	Thu, 17 Feb 2022 20:19:46 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2082.outbound.protection.outlook.com [40.107.236.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4398110E78B
 for <amd-gfx@lists.freedesktop.org>; Thu, 17 Feb 2022 20:19:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IQT848bnvedcxzA97YIp5AdEUqyGpLSbQxQocX5tXU3qRNOC8HNgzddd/9SKWejatRCJGM3IU9/1y3c/xJwBl9naf/OQLaDj4PL0aq760gzBgZ7sMyMb4lR1gOSm9uQ1Lm0EP2PR5TfKZzxC1+GeTjSTP8a/0cDat3/Aa5EYKVH9bL9kW5Ij71U7AcLeiVBa5mhIOhSX/23QcsiyKcf9eHKT0iKkyOMd9i4DpovSyPFrstFuCEaAh7WkWvG3BQezsCvHGrHMRDuWim1KSvtg+41v7EXvBOw1aWdnT/mh8WOmYQBwEc7GNgnnbnllxmMwLAh4xY+KAFcCaGeHxr2DCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jA2dVxJnTbR5ZjuFhv8EVIbOKHUSi1EkL6x+1ueXsow=;
 b=D6rPA33jCFJqHJlLasUjWIGPGf+LlsFlt4xD0igx2MiIyahaaaxmZY8LycgGQ0Xxl6Fin1C9KGln8pxFlAj4u2HH6d9Dq05sxFhnHSGfG5nIVePGfpiysB31xn1xi4vuOxUhnaLLE1rHtTdgpgHERaij8d2y5BDfZEDi9y3mEpdUWacKG8dxqTz6eUpWcdGYdBb3j55pZ1qTJrzD5LzVdjFtCRq5joAiWEYthOdTHlEJOk5HnvtAPP1euT82b84AsJVT9iZmorXVwavQx7sZI4bmSMTNYR/8IM9MEzm0gVHwUACJNRg2HU09KmW3xWRXUxXTECiN74/o4qsFWPlMFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jA2dVxJnTbR5ZjuFhv8EVIbOKHUSi1EkL6x+1ueXsow=;
 b=ADJAYoyvlk/PDs7+xrpQZMXwUYfWb4XmLUunr2jGYmFCmAHpUkC4rJJHd4b0NQxSVwnXYe9Aq/Fv3v3yhptmn3nlsl5TlshKdwsd5wGsmbsJAyNXEOu3tMnp4sYEcRSeAdksWITUM/c/xlce/Ek15IT/iiVDggmQi6GMTsXuBLk=
Received: from BN6PR18CA0021.namprd18.prod.outlook.com (2603:10b6:404:121::31)
 by CH2PR12MB3688.namprd12.prod.outlook.com (2603:10b6:610:28::33)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Thu, 17 Feb
 2022 20:19:40 +0000
Received: from BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
 (2603:10b6:404:121:cafe::2d) by BN6PR18CA0021.outlook.office365.com
 (2603:10b6:404:121::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.20 via Frontend
 Transport; Thu, 17 Feb 2022 20:19:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT034.mail.protection.outlook.com (10.13.176.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4995.15 via Frontend Transport; Thu, 17 Feb 2022 20:19:39 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 17 Feb
 2022 14:19:38 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/admgpu/pm: add smu 13.0.5 driver interface headers
Date: Thu, 17 Feb 2022 15:19:24 -0500
Message-ID: <20220217201926.302025-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220217201926.302025-1-alexander.deucher@amd.com>
References: <20220217201926.302025-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6d8e8f07-22aa-42fa-f880-08d9f252d391
X-MS-TrafficTypeDiagnostic: CH2PR12MB3688:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB3688C472F0818E6C58D95537F7369@CH2PR12MB3688.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0KnLLHpPnhqjM5n9Qu7JPZFQ/7FybfZKVmFAMKVMoxJR22yZPdeOIgx6smf9UnNISY++Bg9tkDo0W559ps7YUMKoQ6lLX+FT7EcpGgsDkCnQPCy3R5q64sp6i6EaJZwPR/l1OCCRO+ZfBONEhMsb4eDPcGq0UVwunhAUGZkEU8qhvyVkbs9pTyFgS3/2MiYFfIXhhHvNe23h/yyfrP8KpysWV2Hlymt/5ZEtVcBEplNyhKUqi5xGif5uv9gp7mGdJjjnS9J15Bn7i1WlPe3VOmdvX6o9oiQ6rBHm7fdt9M2gEyp/5bN4+zus1Vf+HJ8s7xAs1oTHhC7+l8DQshwKI1zUWN0VySB24pSkfPr7bsSqIO84G0AqS+h4bofYbnpsA7ZGWKHmQ+tw/twwi/A352n5CAeoJ7pKTzFirccDYAon4L7NR/8kWZq8cytLyfEdLkCqfJ7pE07vrRYG9NPnEMg3h47jgXWjk4+SZzU6sj3oApxeDTAuAag2WNJoDwupZFSdLnkbXOS8XTV/4l/3locVTSqJ4lPv7vMex0V4d9RbempLdcwD/g8mETeODhNQIlcmeDGZFrzjueUivI/CGeWZH4BCfPQIDB0nMr+qz2ilJDyDLAmgSp5GxkACRURgBOWNLKLzr5qQIU55SE8yf4p5HtMlKuTg8no5C1u9nEIAcnBa37W2LZzPRuAmXGC5hmbiOAwumBul2ZKDN3mghg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2906002)(82310400004)(86362001)(5660300002)(81166007)(8936002)(30864003)(356005)(2616005)(1076003)(336012)(426003)(26005)(40460700003)(6666004)(508600001)(7696005)(186003)(16526019)(36860700001)(4326008)(70206006)(70586007)(19627235002)(316002)(6916009)(83380400001)(47076005)(54906003)(8676002)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 20:19:39.9497 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6d8e8f07-22aa-42fa-f880-08d9f252d391
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT034.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3688
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
 Yifan Zhang <yifan1.zhang@amd.com>, Huang Rui <ray.huang@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Yifan Zhang <yifan1.zhang@amd.com>

This patch is to add smu 13.0.5 driver interface headers.

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../inc/pmfw_if/smu13_driver_if_v13_0_5.h     | 140 ++++++++++++++++++
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_5_pmfw.h   | 126 ++++++++++++++++
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_5_ppsmc.h  |  74 +++++++++
 3 files changed, 340 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_5.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_5_pmfw.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_5_ppsmc.h

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_5.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_5.h
new file mode 100644
index 000000000000..aa971412b434
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_5.h
@@ -0,0 +1,140 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+#ifndef __SMU13_DRIVER_IF_V13_0_5_H__
+#define __SMU13_DRIVER_IF_V13_0_5_H__
+
+#define PMFW_DRIVER_IF_VERSION 4
+
+// Throttler Status Bitmask
+#define THROTTLER_STATUS_BIT_SPL            0
+#define THROTTLER_STATUS_BIT_FPPT           1
+#define THROTTLER_STATUS_BIT_SPPT           2
+#define THROTTLER_STATUS_BIT_SPPT_APU       3
+#define THROTTLER_STATUS_BIT_THM_CORE       4
+#define THROTTLER_STATUS_BIT_THM_GFX        5
+#define THROTTLER_STATUS_BIT_THM_SOC        6
+#define THROTTLER_STATUS_BIT_TDC_VDD        7
+#define THROTTLER_STATUS_BIT_TDC_SOC        8
+#define THROTTLER_STATUS_BIT_PROCHOT_CPU    9
+#define THROTTLER_STATUS_BIT_PROCHOT_GFX   10
+#define THROTTLER_STATUS_BIT_EDC_CPU       11
+#define THROTTLER_STATUS_BIT_EDC_GFX       12
+
+#define NUM_DCFCLK_DPM_LEVELS   4
+#define NUM_DISPCLK_DPM_LEVELS  4
+#define NUM_DPPCLK_DPM_LEVELS   4
+#define NUM_SOCCLK_DPM_LEVELS   4
+#define NUM_VCN_DPM_LEVELS      4
+#define NUM_SOC_VOLTAGE_LEVELS  4
+#define NUM_DF_PSTATE_LEVELS    4
+
+typedef struct {
+  uint16_t MinClock; // This is either DCFCLK or SOCCLK (in MHz)
+  uint16_t MaxClock; // This is either DCFCLK or SOCCLK (in MHz)
+  uint16_t MinMclk;
+  uint16_t MaxMclk;
+  uint8_t  WmSetting;
+  uint8_t  WmType;  // Used for normal pstate change or memory retraining
+  uint8_t  Padding[2];
+} WatermarkRowGeneric_t;
+
+#define NUM_WM_RANGES 4
+#define WM_PSTATE_CHG 0
+#define WM_RETRAINING 1
+
+typedef enum {
+  WM_SOCCLK = 0,
+  WM_DCFCLK,
+  WM_COUNT,
+} WM_CLOCK_e;
+
+typedef struct {
+  // Watermarks
+  WatermarkRowGeneric_t WatermarkRow[WM_COUNT][NUM_WM_RANGES];
+  uint32_t MmHubPadding[7]; // SMU internal use
+} Watermarks_t;
+
+typedef struct {
+  uint32_t FClk;
+  uint32_t MemClk;
+  uint32_t Voltage;
+} DfPstateTable_t;
+
+typedef struct {
+  uint16_t GfxclkFrequency;             //[MHz]
+  uint16_t SocclkFrequency;             //[MHz]
+
+  uint16_t VclkFrequency;               //[MHz]
+  uint16_t DclkFrequency;               //[MHz]
+
+  uint16_t MemclkFrequency;             //[MHz]
+  uint16_t spare;
+
+  uint16_t GfxActivity;                 //[centi]
+  uint16_t UvdActivity;                 //[centi]
+
+  uint16_t Voltage[2];                  //[mV] indices: VDDCR_VDD, VDDCR_SOC
+  uint16_t Current[2];                  //[mA] indices: VDDCR_VDD, VDDCR_SOC
+
+  uint16_t Power[2];                    //[mW] indices: VDDCR_VDD, VDDCR_SOC
+  uint16_t GfxTemperature;              //[centi-Celsius]
+
+  uint16_t SocTemperature;              //[centi-Celsius]
+  uint16_t ThrottlerStatus;
+
+  uint16_t CurrentSocketPower;          //[mW]
+  uint16_t spare1;
+} SmuMetrics_t;
+
+//Freq in MHz
+//Voltage in milli volts with 2 fractional bits
+typedef struct {
+  uint32_t DcfClocks[NUM_DCFCLK_DPM_LEVELS];
+  uint32_t DispClocks[NUM_DISPCLK_DPM_LEVELS];
+  uint32_t DppClocks[NUM_DPPCLK_DPM_LEVELS];
+  uint32_t SocClocks[NUM_SOCCLK_DPM_LEVELS];
+  uint32_t VClocks[NUM_VCN_DPM_LEVELS];
+  uint32_t DClocks[NUM_VCN_DPM_LEVELS];
+  uint32_t SocVoltage[NUM_SOC_VOLTAGE_LEVELS];
+  DfPstateTable_t DfPstateTable[NUM_DF_PSTATE_LEVELS];
+  uint8_t  NumDcfClkLevelsEnabled;
+  uint8_t  NumDispClkLevelsEnabled; //Applies to both Dispclk and Dppclk
+  uint8_t  NumSocClkLevelsEnabled;
+  uint8_t  VcnClkLevelsEnabled;     //Applies to both Vclk and Dclk
+  uint8_t  NumDfPstatesEnabled;
+  uint8_t  spare[3];
+  uint32_t MinGfxClk;
+  uint32_t MaxGfxClk;
+} DpmClocks_t;
+
+#define TABLE_BIOS_IF            0 // Called by BIOS
+#define TABLE_WATERMARKS         1 // Called by DAL through VBIOS
+#define TABLE_CUSTOM_DPM         2 // Called by Driver
+#define TABLE_SPARE1             3
+#define TABLE_DPMCLOCKS          4 // Called by Driver and VBIOS
+#define TABLE_MOMENTARY_PM       5 // Called by Tools
+#define TABLE_MODERN_STDBY       6 // Called by Tools for Modern Standby Log
+#define TABLE_SMU_METRICS        7 // Called by Driver
+#define TABLE_COUNT              8
+
+#endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_5_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_5_pmfw.h
new file mode 100644
index 000000000000..1e4999d22a7c
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_5_pmfw.h
@@ -0,0 +1,126 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+#ifndef __SMU_V13_0_5_PMFW_H__
+#define __SMU_V13_0_5_PMFW_H__
+
+#include "smu13_driver_if_v13_0_5.h"
+
+#pragma pack(push, 1)
+
+#define ENABLE_DEBUG_FEATURES
+
+// Firmware features
+// Feature Control Defines
+#define FEATURE_DATA_CALCULATION_BIT        0
+#define FEATURE_PPT_BIT                     1
+#define FEATURE_TDC_BIT                     2
+#define FEATURE_THERMAL_BIT                 3
+#define FEATURE_FIT_BIT                     4
+#define FEATURE_EDC_BIT                     5
+#define FEATURE_CSTATE_BOOST_BIT            6
+#define FEATURE_PROCHOT_BIT                 7
+#define FEATURE_CCLK_DPM_BIT                8
+#define FEATURE_FCLK_DPM_BIT                9
+#define FEATURE_LCLK_DPM_BIT                10
+#define FEATURE_PSI7_BIT                    11
+#define FEATURE_DLDO_BIT                    12
+#define FEATURE_SOCCLK_DEEP_SLEEP_BIT       13
+#define FEATURE_LCLK_DEEP_SLEEP_BIT         14
+#define FEATURE_SHUBCLK_DEEP_SLEEP_BIT      15
+#define FEATURE_DVO_BIT                     16
+#define FEATURE_CC6_BIT                     17
+#define FEATURE_PC6_BIT                     18
+#define FEATURE_DF_CSTATES_BIT              19
+#define FEATURE_CLOCK_GATING_BIT            20
+#define FEATURE_FAN_CONTROLLER_BIT          21
+#define FEATURE_CPPC_BIT                    22
+#define FEATURE_DLDO_DROPOUT_LIMITER_BIT    23
+#define FEATURE_CPPC_PREFERRED_CORES_BIT    24
+#define FEATURE_GMI_FOLDING_BIT             25
+#define FEATURE_GMI_DLWM_BIT                26
+#define FEATURE_XGMI_DLWM_BIT               27
+#define FEATURE_DF_LIGHT_CSTATE_BIT         28
+#define FEATURE_SMNCLK_DEEP_SLEEP_BIT       29
+#define FEATURE_PCIE_SPEED_CONTROLLER_BIT   30
+#define FEATURE_GFX_DPM_BIT             31
+#define FEATURE_DS_GFXCLK_BIT           32
+#define FEATURE_PCC_BIT                    33
+#define FEATURE_spare0_BIT                  34
+#define FEATURE_S0I3_BIT                35
+#define FEATURE_VCN_DPM_BIT             36
+#define FEATURE_DS_VCN_BIT              37
+#define FEATURE_MPDMA_TF_CLK_DEEP_SLEEP_BIT 38
+#define FEATURE_MPDMA_PM_CLK_DEEP_SLEEP_BIT 39
+#define FEATURE_VDDOFF_BIT              40
+#define FEATURE_DCFCLK_DPM_BIT          41
+#define FEATURE_DCFCLK_DEEP_SLEEP_BIT       42
+#define FEATURE_ATHUB_PG_BIT            43
+#define FEATURE_SOCCLK_DPM_BIT          44
+#define FEATURE_SHUBCLK_DPM_BIT         45
+#define FEATURE_MP0CLK_DPM_BIT          46
+#define FEATURE_MP0CLK_DEEP_SLEEP_BIT       47
+#define FEATURE_PERCCXPC6_BIT               48
+#define FEATURE_GFXOFF_BIT                  49
+#define NUM_FEATURES                    50
+
+typedef struct {
+  // MP1_EXT_SCRATCH0
+  uint32_t CurrLevel_ACP     : 4;
+  uint32_t CurrLevel_ISP     : 4;
+  uint32_t CurrLevel_VCN     : 4;
+  uint32_t CurrLevel_LCLK    : 4;
+  uint32_t CurrLevel_MP0CLK  : 4;
+  uint32_t CurrLevel_FCLK    : 4;
+  uint32_t CurrLevel_SOCCLK  : 4;
+  uint32_t CurrLevel_DCFCLK : 4;
+  // MP1_EXT_SCRATCH1
+  uint32_t TargLevel_ACP     : 4;
+  uint32_t TargLevel_ISP     : 4;
+  uint32_t TargLevel_VCN     : 4;
+  uint32_t TargLevel_LCLK    : 4;
+  uint32_t TargLevel_MP0CLK  : 4;
+  uint32_t TargLevel_FCLK    : 4;
+  uint32_t TargLevel_SOCCLK  : 4;
+  uint32_t TargLevel_DCFCLK : 4;
+  // MP1_EXT_SCRATCH2
+  uint32_t CurrLevel_SHUBCLK  : 4;
+  uint32_t TargLevel_SHUBCLK  : 4;
+  uint32_t InUlv              : 1;
+  uint32_t InS0i2             : 1;
+  uint32_t InWhisperMode      : 1;
+  uint32_t GfxOn              : 1;
+  uint32_t RsmuCalBusyDpmIndex: 8;
+  uint32_t DpmHandlerId       : 8;
+  uint32_t DpmTimerId         : 4;
+  // MP1_EXT_SCRATCH3
+  uint32_t ReadWriteSmnRegAddr: 32;
+  // MP1_EXT_SCRATCH4
+  uint32_t Reserved1;
+  // MP1_EXT_SCRATCH5
+  uint32_t FeatureStatus[NUM_FEATURES / 32];
+} FwStatus_t;
+
+#pragma pack(pop)
+
+#endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_5_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_5_ppsmc.h
new file mode 100644
index 000000000000..c6238c74923a
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_5_ppsmc.h
@@ -0,0 +1,74 @@
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
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
+#ifndef __SMU_V13_0_5_PPSMC_H__
+#define __SMU_V13_0_5_PPSMC_H__
+
+// SMU Response Codes:
+#define PPSMC_Result_OK                    0x1
+#define PPSMC_Result_Failed                0xFF
+#define PPSMC_Result_UnknownCmd            0xFE
+#define PPSMC_Result_CmdRejectedPrereq     0xFD
+#define PPSMC_Result_CmdRejectedBusy       0xFC
+
+
+// Message Definitions:
+#define PPSMC_MSG_TestMessage               1
+#define PPSMC_MSG_GetSmuVersion             2
+#define PPSMC_MSG_EnableGfxOff              3  ///< Enable GFXOFF
+#define PPSMC_MSG_DisableGfxOff             4  ///< Disable GFXOFF
+#define PPSMC_MSG_PowerDownVcn              5  ///< Power down VCN
+#define PPSMC_MSG_PowerUpVcn                6  ///< Power up VCN; VCN is power gated by default
+#define PPSMC_MSG_SetHardMinVcn             7  ///< For wireless display
+#define PPSMC_MSG_SetSoftMinGfxclk          8  ///< Set SoftMin for GFXCLK, argument is frequency in MHz
+#define PPSMC_MSG_Spare0                    9  ///< Spare
+#define PPSMC_MSG_GfxDeviceDriverReset      10 ///< Request GFX mode 2 reset
+#define PPSMC_MSG_SetDriverDramAddrHigh     11 ///< Set high 32 bits of DRAM address for Driver table transfer
+#define PPSMC_MSG_SetDriverDramAddrLow      12 ///< Set low 32 bits of DRAM address for Driver table transfer
+#define PPSMC_MSG_TransferTableSmu2Dram     13 ///< Transfer driver interface table from PMFW SRAM to DRAM
+#define PPSMC_MSG_TransferTableDram2Smu     14 ///< Transfer driver interface table from DRAM to PMFW SRAM
+#define PPSMC_MSG_GetGfxclkFrequency        15 ///< Get GFX clock frequency
+#define PPSMC_MSG_GetEnabledSmuFeatures     16 ///< Get enabled features in PMFW
+#define PPSMC_MSG_SetSoftMaxVcn             17 ///< Set soft max for VCN clocks (VCLK and DCLK)
+#define PPSMC_MSG_PowerDownJpeg             18 ///< Power down Jpeg
+#define PPSMC_MSG_PowerUpJpeg               19 ///< Power up Jpeg; VCN is power gated by default
+#define PPSMC_MSG_SetSoftMaxGfxClk          20
+#define PPSMC_MSG_SetHardMinGfxClk          21 ///< Set hard min for GFX CLK
+#define PPSMC_MSG_AllowGfxOff               22 ///< Inform PMFW of allowing GFXOFF entry
+#define PPSMC_MSG_DisallowGfxOff            23 ///< Inform PMFW of disallowing GFXOFF entry
+#define PPSMC_MSG_SetSoftMinVcn             24 ///< Set soft min for VCN clocks (VCLK and DCLK)
+#define PPSMC_MSG_GetDriverIfVersion        25 ///< Get PMFW_DRIVER_IF version
+#define PPSMC_MSG_PrepareMp1ForUnload        26 ///< Prepare PMFW for GFX driver unload
+#define PPSMC_Message_Count                 27
+
+/** @enum Mode_Reset_e
+* Mode reset type, argument for PPSMC_MSG_GfxDeviceDriverReset
+*/
+typedef enum {
+  MODE1_RESET = 1,  ///< Mode reset type 1
+  MODE2_RESET = 2   ///< Mode reset type 2
+} Mode_Reset_e;
+/** @}*/
+
+#endif
+
-- 
2.35.1


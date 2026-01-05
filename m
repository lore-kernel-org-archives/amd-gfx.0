Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55614CCF2C2
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jan 2026 20:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 56DCB10E285;
	Mon,  5 Jan 2026 20:13:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uXOGM9Bf";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010057.outbound.protection.outlook.com
 [52.101.193.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A42E110E26A
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jan 2026 20:13:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TIPPpIfvh31amGNl/PKyT2hajhcPz4z0cZRqXgKocGEXFFJLm3WiufoSCxhPp+h7psGzfazswtYwNlbv6SIHtnZRdzCSQ/XPCBdNW58kaHjIjSa1/nwbMxz2OPp4nxthS9cuOQ4B56xXVfwtIZiyO2K1bCSItOAX4OxurKktnRTAKHu7r+C9VuxW5GJY+eIR5BnXwmm2XF9sqDsIDHb9UF6zGA8tsd4qWI70Avuj3tt+DpFfCbvGyIqDWQJug7WYydJUPqS1Zskmil9qgzlRs6+Pbv/IHsDYGBP+96s2djeV+r+Qy4/MMFqGXiudwvSQFUZ2wicx7TIytWw9sHKosQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sAPP/62nWj6Rzj1btBfeyAGTg1uJKPgPXNwclkGW82Q=;
 b=lPO6TY7iM4cvFCmPOvfuEzp6UaFeXH65NtRn82n1Lx/9A06B2CQ/3A0tz9ZtCgOrer7CqgRBOgd1u5N8S8FIMpPT99OQ+4KesZPwpuXoWqQsZAxTo7CjJJoxC341n/3cHVADJLqhxU8q22VXAgjT9T0sLseML2k3zD37n9k/V8RY+ygqlDkfY7AeUyNkQQuA7UWBDBGGaMzo3xSsTH2WtnY7Eppe+ydRqqpcApeaFST1nqspv8Wig1QgP23SBGhq9vZrv6Rpj4aLIFXKGcQtlrVInQWT2XIW1OmWlG6ouNjm5UsZ2MAHTUhvRr3Ua9XpCGlAD0+9VWGMuN7DOS9xOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sAPP/62nWj6Rzj1btBfeyAGTg1uJKPgPXNwclkGW82Q=;
 b=uXOGM9Bfv06Qj9WP42bs/AQEYIAlVlK8o2O5JV30I1KIjTzLD1KVwI+ORmgZ0ayydG25MQvv5BsQilnGM3xjpz+UuPNwmxfHWMGSLLcADKKCMZpIEMPVYCni4l5tXp7insenA9Lc9TI08rmlO9jaU0On103RfQFK+qGTihtKfj8=
Received: from MN0PR04CA0007.namprd04.prod.outlook.com (2603:10b6:208:52d::12)
 by IA0PR12MB8375.namprd12.prod.outlook.com (2603:10b6:208:3dd::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 20:13:35 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:208:52d:cafe::cf) by MN0PR04CA0007.outlook.office365.com
 (2603:10b6:208:52d::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Mon, 5
 Jan 2026 20:13:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.0 via Frontend Transport; Mon, 5 Jan 2026 20:13:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 5 Jan
 2026 14:13:32 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 5 Jan
 2026 14:13:32 -0600
Received: from p8.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 5 Jan 2026 14:13:32 -0600
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>, Alex Deucher
 <alexander.deucher@amd.com>
Subject: [PATCH 4/5] drm/amd: Enable SMU 15_0_0 firmware headers
Date: Mon, 5 Jan 2026 15:13:17 -0500
Message-ID: <20260105201318.64865-4-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260105201318.64865-1-alexander.deucher@amd.com>
References: <20260105201318.64865-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alexander.deucher@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|IA0PR12MB8375:EE_
X-MS-Office365-Filtering-Correlation-Id: fdfbfd1b-9861-4a7b-1425-08de4c96e71a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UvALi7r2kHXn972jZVNz1v6CyZOglIPkusH5VBuDoitKu0uKOMxQAjMM9Vab?=
 =?us-ascii?Q?v6G9N72N/9HQrs1Y94WR4QBOOYg7UyybONaLzDSxKq2CzVXVQk3sStt9DLNQ?=
 =?us-ascii?Q?wpIUlhMCtWm/AKti0Uh+jmSgNwenSGOv48ZPrXUsIw10EU56JikSRShHwaSY?=
 =?us-ascii?Q?Iwhov6sXF1/eevAFlGMtJ90BzXIwERFSXlTA6aSu4MN5uWVHaV8Enb9HBxDc?=
 =?us-ascii?Q?aGISLRORz1Wj0Hhd6jCVvJ4JzANuiLYX0DMd8LC5F7aP3pPg8UXRUAgZq+jX?=
 =?us-ascii?Q?bK1boE4RuswCQu66w0Gie6SAlMtDVxbZlZE1SlzsGrJ7/N6YS1RDqk9hHG8d?=
 =?us-ascii?Q?6+HIY3rxfFbwnmLL97HwwVZuc4hgcTeM7SaeIG4j3gYBZTtC+CtvrBTcYDd7?=
 =?us-ascii?Q?p/ti+10pLdRIumU198LBfXUBqdS9BUd4l8CZgDIcavxUPOIMxEUzcAWtzB7P?=
 =?us-ascii?Q?YozqMwgX1ULgPh4c/37OGN50tAutR/+bnQelkY3BZwaUVZEaSjbu4fxPPEZO?=
 =?us-ascii?Q?RvdsYmwwKgZYiNrgazAkyYs23OKTGSAyf//MS7FSIIDqWqrtqMKJYg2uLe1p?=
 =?us-ascii?Q?6+1Hfyn4xbudfC6pVQrwhwnA5U3qLWymd2JyB8DdrJR93OeovQV/kKUnT28Q?=
 =?us-ascii?Q?rbNw56TF4CZvtpgRjeceMglm8AKLtvDcOxYIWAwxNetrmL+SXLh85DEYrvTB?=
 =?us-ascii?Q?+mjJ3Xaca/1LuSPdv2Rv95M2bGIIaRn7PUWFfzIp2Eaq5SINfSVvKUoINR1v?=
 =?us-ascii?Q?O5aLmsDThcgjEnydjoZrI8OWYmr6vKMdiUQrcpga2HX6MK+BDM5pAlUGOqAh?=
 =?us-ascii?Q?CkC1qlnjqIiptavE1kNUOnUSP3Ah1vZUTiEqXz6XjI0vU9s4bXoSV3WKgYhR?=
 =?us-ascii?Q?3umjhZGZV3m2RbhNZTcEq8vVu7BGrAEMW1zv3tZ1Sp054IXuyRhuovjUEp6L?=
 =?us-ascii?Q?aWXLdDSsJ2000KWB6OInSY6EikNRUyCFzJvFdoz95CpB9LhOdexj+tPAAMQS?=
 =?us-ascii?Q?TvelmJRJd623phhZmM+00cOwO+zsfa2IjqAQKI6Y5pgjx7kYaDzUALVyxOPL?=
 =?us-ascii?Q?x/QRDUZD2QEcnK41wzDDsoVgGxKX+Xzg6ZRaHbfqpGFHb0y+tzb6610cR8wQ?=
 =?us-ascii?Q?V9l7+ExU+zV1BExPmmDn3RgUV43GuTG+XIt0U5uKhpa1Vbxc3rqNvyMgFWgP?=
 =?us-ascii?Q?h3k6srLMo0DhHv5jz4VnF5mIImSNt6EBM8cCMGc61jMn1HgygtIPpIY4ZRl0?=
 =?us-ascii?Q?Naafj4wY6IeuOiUhm1+1pJ7V/GQT5w8/xYJ2qPygkWsPq2AW2YggoORGZZOW?=
 =?us-ascii?Q?c8X4xfs6uD/rzz2xOwEWkDPDC6hqDgaIyXrp2z5zKEbVMjP9OhGuoNQfiZkY?=
 =?us-ascii?Q?XvK9HGzmeWnJcjuDsfDEUdnylT+ivLvDoVAz4di74iETweTYUZaxZOnXwn/J?=
 =?us-ascii?Q?4qmuOZFj2HtiKCiv+k3O88WNR+ukDUz6kUNG2/gwE4jE86NjE4CFESAk+AAj?=
 =?us-ascii?Q?zCH+RD8g4v2DTX60Gc0dqvXwlSyOVdG+3dGPFcA6sltvHq0Dt2kvT0QHmEsG?=
 =?us-ascii?Q?huARAvLYyFaJ2o+ir3g=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 20:13:33.8811 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdfbfd1b-9861-4a7b-1425-08de4c96e71a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8375
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

From: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>

Add SMU 15_0_0 firmware headers

v2: squash in updates (Alex)

Signed-off-by: Pratik Vishwakarma <Pratik.Vishwakarma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../inc/pmfw_if/smu15_driver_if_v15_0_0.h     | 231 ++++++++++++++++++
 .../pm/swsmu/inc/pmfw_if/smu_v15_0_0_pmfw.h   | 160 ++++++++++++
 .../pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h  | 133 ++++++++++
 3 files changed, 524 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_0.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_pmfw.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_0.h
new file mode 100644
index 0000000000000..47ddf533b08f3
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu15_driver_if_v15_0_0.h
@@ -0,0 +1,231 @@
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
+#ifndef SMU15_DRIVER_IF_V15_0_0_H
+#define SMU15_DRIVER_IF_V15_0_0_H
+
+typedef struct {
+  int32_t value;
+  uint32_t numFractionalBits;
+} FloatInIntFormat_t;
+
+typedef enum {
+  DSPCLK_DCFCLK = 0,
+  DSPCLK_DISPCLK,
+  DSPCLK_PIXCLK,
+  DSPCLK_PHYCLK,
+  DSPCLK_COUNT,
+} DSPCLK_e;
+
+typedef struct {
+  uint16_t Freq; // in MHz
+  uint16_t Vid;  // min voltage in SVI3 VID
+} DisplayClockTable_t;
+
+typedef struct {
+  uint16_t MinClock; // This is either DCFCLK or SOCCLK (in MHz)
+  uint16_t MaxClock; // This is either DCFCLK or SOCCLK (in MHz)
+  uint16_t MinMclk;
+  uint16_t MaxMclk;
+
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
+
+  uint32_t MmHubPadding[7]; // SMU internal use
+} Watermarks_t;
+
+typedef enum {
+  CUSTOM_DPM_SETTING_GFXCLK,
+  CUSTOM_DPM_SETTING_CCLK,
+  CUSTOM_DPM_SETTING_FCLK_CCX,
+  CUSTOM_DPM_SETTING_FCLK_GFX,
+  CUSTOM_DPM_SETTING_FCLK_STALLS,
+  CUSTOM_DPM_SETTING_LCLK,
+  CUSTOM_DPM_SETTING_COUNT,
+} CUSTOM_DPM_SETTING_e;
+
+typedef struct {
+  uint8_t             ActiveHystLimit;
+  uint8_t             IdleHystLimit;
+  uint8_t             FPS;
+  uint8_t             MinActiveFreqType;
+  FloatInIntFormat_t  MinActiveFreq;
+  FloatInIntFormat_t  PD_Data_limit;
+  FloatInIntFormat_t  PD_Data_time_constant;
+  FloatInIntFormat_t  PD_Data_error_coeff;
+  FloatInIntFormat_t  PD_Data_error_rate_coeff;
+} DpmActivityMonitorCoeffExt_t;
+
+typedef struct {
+  DpmActivityMonitorCoeffExt_t DpmActivityMonitorCoeff[CUSTOM_DPM_SETTING_COUNT];
+} CustomDpmSettings_t;
+
+#define NUM_DCFCLK_DPM_LEVELS     8
+#define NUM_DISPCLK_DPM_LEVELS    8
+#define NUM_DPPCLK_DPM_LEVELS     8
+#define NUM_SOCCLK_DPM_LEVELS     8
+#define NUM_VCN_DPM_LEVELS        8
+#define NUM_SOC_VOLTAGE_LEVELS    8
+#define NUM_VPE_DPM_LEVELS        8
+#define NUM_FCLK_DPM_LEVELS       8
+#define NUM_MEM_PSTATE_LEVELS     4
+
+
+typedef struct {
+  uint32_t UClk;
+  uint32_t MemClk;
+  uint32_t Voltage;
+  uint8_t  WckRatio;
+  uint8_t  Spare[3];
+} MemPstateTable_t;
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
+  uint32_t VPEClocks[NUM_VPE_DPM_LEVELS];
+  uint32_t FclkClocks_Freq[NUM_FCLK_DPM_LEVELS];
+  uint32_t FclkClocks_Voltage[NUM_FCLK_DPM_LEVELS];
+  uint32_t SocVoltage[NUM_SOC_VOLTAGE_LEVELS];
+  MemPstateTable_t MemPstateTable[NUM_MEM_PSTATE_LEVELS];
+
+  uint8_t  NumDcfClkLevelsEnabled;
+  uint8_t  NumDispClkLevelsEnabled; //Applies to both Dispclk and Dppclk
+  uint8_t  NumSocClkLevelsEnabled;
+  uint8_t  VcnClkLevelsEnabled;     //Applies to both Vclk and Dclk
+
+  uint8_t  VpeClkLevelsEnabled;
+  uint8_t  NumMemPstatesEnabled;
+  uint8_t  NumFclkLevelsEnabled;
+  uint8_t  spare;
+
+  uint32_t MinGfxClk;
+  uint32_t MaxGfxClk;
+} DpmClocks_t;
+
+typedef struct {
+  uint16_t CoreFrequency[16];          //Target core frequency [MHz]
+  uint16_t CorePower[16];              //CAC calculated core power [mW]
+  uint16_t CoreTemperature[16];        //TSEN measured core temperature [centi-C]
+  uint16_t GfxTemperature;             //TSEN measured GFX temperature [centi-C]
+  uint16_t SocTemperature;             //TSEN measured SOC temperature [centi-C]
+  uint16_t StapmOpnLimit;              //Maximum IRM defined STAPM power limit [mW]
+  uint16_t StapmCurrentLimit;          //Time filtered STAPM power limit [mW]
+  uint16_t InfrastructureCpuMaxFreq;   //CCLK frequency limit enforced on classic cores [MHz]
+  uint16_t InfrastructureGfxMaxFreq;   //GFXCLK frequency limit enforced on GFX [MHz]
+  uint16_t SkinTemp;                   //Maximum skin temperature reported by APU and HS2 chassis sensors [centi-C]
+  uint16_t GfxclkFrequency;            //Time filtered target GFXCLK frequency [MHz]
+  uint16_t FclkFrequency;              //Time filtered target FCLK frequency [MHz]
+  uint16_t GfxActivity;                //Time filtered GFX busy % [0-100]
+  uint16_t SocclkFrequency;            //Time filtered target SOCCLK frequency [MHz]
+  uint16_t VclkFrequency;              //Time filtered target VCLK frequency [MHz]
+  uint16_t VcnActivity;                //Time filtered VCN busy % [0-100]
+  uint16_t VpeclkFrequency;            //Time filtered target VPECLK frequency [MHz]
+  uint16_t NpuclkFrequency;            //Time filtered target NPUCLK frequency [MHz]
+  uint16_t NpuBusy[8];                 //Time filtered NPU per-column busy % [0-100]
+  uint16_t DRAMReads;                  //Time filtered DRAM read bandwidth [MB/sec]
+  uint16_t DRAMWrites;                 //Time filtered DRAM write bandwidth [MB/sec]
+  uint16_t CoreC0Residency[16];        //Time filtered per-core C0 residency % [0-100]
+  uint16_t NpuPower;                   //Time filtered NPU power [mW]
+  uint32_t ApuPower;                   //Time filtered APU power [mW]
+  uint32_t GfxPower;                   //Time filtered GFX power [mW]
+  uint32_t dGpuPower;                  //Time filtered dGPU power [mW]
+  uint32_t SocketPower;                //Time filtered power used for PPT/STAPM [APU+dGPU] [mW]
+  uint32_t AllCorePower;               //Time filtered sum of core power across all cores in the socket [mW]
+  uint32_t FilterAlphaValue;           //Metrics table alpha filter time constant [us]
+  uint32_t MetricsCounter;             //Counter that is incremented on every metrics table update [PM_TIMER cycles]
+  uint16_t MemclkFrequency;            //Time filtered target MEMCLK frequency [MHz]
+  uint16_t AieclkFrequency;            //Time filtered target AIECLK frequency [MHz]
+  uint16_t NpuReads;                   //Time filtered NPU read bandwidth [MB/sec]
+  uint16_t NpuWrites;                  //Time filtered NPU write bandwidth [MB/sec]
+  uint32_t ThrottleResidency_PROCHOT;  //Counter that is incremented on every metrics table update when PROCHOT was engaged [PM_TIMER cycles]
+  uint32_t ThrottleResidency_SPL;      //Counter that is incremented on every metrics table update when SPL was engaged [PM_TIMER cycles]
+  uint32_t ThrottleResidency_FPPT;     //Counter that is incremented on every metrics table update when fast PPT was engaged [PM_TIMER cycles]
+  uint32_t ThrottleResidency_SPPT;     //Counter that is incremented on every metrics table update when slow PPT was engaged [PM_TIMER cycles]
+  uint32_t ThrottleResidency_THM_VDD;  //Counter that is incremented on every metrics table update when VDD thermal throttling was engaged [PM_TIMER cycles]
+  uint32_t ThrottleResidency_THM_SOC;  //Counter that is incremented on every metrics table update when SOC thermal throttling was engaged [PM_TIMER cycles]
+  uint16_t Psys;                       //Time filtered Psys power [mW]
+  uint16_t spare1;
+  uint32_t spare[6];
+} SmuMetrics_t;
+
+//ISP tile definitions
+typedef enum {
+  TILE_XTILE = 0,         //ONO0
+  TILE_MTILE,             //ONO1
+  TILE_PDP,               //ONO2
+  TILE_CSTAT,             //ONO2
+  TILE_LME,               //ONO3
+  TILE_BYRP,              //ONO4
+  TILE_GRBP,              //ONO4
+  TILE_MCFP,              //ONO4
+  TILE_YUVP,              //ONO4
+  TILE_MCSC,              //ONO4
+  TILE_GDC,               //ONO5
+  TILE_MAX
+} TILE_NUM_e;
+
+// Tile Selection (Based on arguments)
+#define ISP_TILE_SEL(tile)   (1<<tile)
+#define ISP_TILE_SEL_ALL     0x7FF
+
+// Workload bits
+#define WORKLOAD_PPLIB_FULL_SCREEN_3D_BIT 0
+#define WORKLOAD_PPLIB_VIDEO_BIT          2
+#define WORKLOAD_PPLIB_VR_BIT             3
+#define WORKLOAD_PPLIB_COMPUTE_BIT        4
+#define WORKLOAD_PPLIB_CUSTOM_BIT         5
+#define WORKLOAD_PPLIB_COUNT              6
+
+#define TABLE_BIOS_IF               0 // Called by BIOS
+#define TABLE_WATERMARKS            1 // Called by DAL through VBIOS, for Medusa generation this should no longer be used
+#define TABLE_CUSTOM_DPM            2 // Called by Driver
+#define TABLE_BIOS_GPIO_CONFIG      3 // Called by BIOS
+#define TABLE_DPMCLOCKS             4 // Called by Driver and VBIOS
+#define TABLE_SPARE0                5 // Unused
+#define TABLE_SPARE1                6 // Unused
+#define TABLE_SMU_METRICS           7 // Called by Driver and SMF/PMF
+#define TABLE_COUNT                 8
+
+#endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_pmfw.h
new file mode 100644
index 0000000000000..c3b67ffa1bfa5
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_pmfw.h
@@ -0,0 +1,160 @@
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
+#ifndef SMU15_DRIVER_IF_V15_0_H
+#define SMU15_DRIVER_IF_V15_0_H
+
+#include "smu15_driver_if_v15_0_0.h"
+
+#pragma pack(push, 1)
+
+#define ENABLE_DEBUG_FEATURES
+
+// Firmware features
+// Feature Control Defines
+#define FEATURE_CCLK_DPM_BIT                 0
+#define FEATURE_FAN_CONTROLLER_BIT           1
+#define FEATURE_DATA_CALCULATION_BIT         2
+#define FEATURE_PPT_BIT                      3
+#define FEATURE_TDC_BIT                      4
+#define FEATURE_THERMAL_BIT                  5
+#define FEATURE_FIT_BIT                      6
+#define FEATURE_EDC_BIT                      7
+#define FEATURE_PLL_POWER_DOWN_BIT           8
+#define FEATURE_VDDOFF_BIT                   9
+#define FEATURE_VCN_DPM_BIT                 10
+#define FEATURE_DS_MPM_BIT                  11
+#define FEATURE_FCLK_DPM_BIT                12
+#define FEATURE_SOCCLK_DPM_BIT              13
+#define FEATURE_DS_MPIO_BIT                 14
+#define FEATURE_LCLK_DPM_BIT                15
+#define FEATURE_SHUBCLK_DPM_BIT             16
+#define FEATURE_DCFCLK_DPM_BIT              17
+#define FEATURE_ISP_DPM_BIT                 18
+#define FEATURE_NPU_DPM_BIT                 19
+#define FEATURE_GFX_DPM_BIT                 20
+#define FEATURE_DS_GFXCLK_BIT               21
+#define FEATURE_DS_SOCCLK_BIT               22
+#define FEATURE_DS_LCLK_BIT                 23
+#define FEATURE_LOW_POWER_DCNCLKS_BIT       24  // for all DISP clks
+#define FEATURE_DS_SHUBCLK_BIT              25
+#define FEATURE_VRHOT_BIT                   26
+#define FEATURE_Z8_BIT                      27
+#define FEATURE_PCC_BIT                     28
+#define FEATURE_DS_FCLK_BIT                 29
+#define FEATURE_DS_SMNCLK_BIT               30
+#define FEATURE_DS_MP1CLK_BIT               31
+#define FEATURE_SPM_BIT                     32
+#define FEATURE_SMU_LOW_POWER_BIT           33
+#define FEATURE_SMART_L3_RINSER_BIT         34  // Amit: it is spare
+#define FEATURE_DS_DACCCLK_BIT              35
+#define FEATURE_PSI_BIT                     36
+#define FEATURE_PROCHOT_BIT                 37
+#define FEATURE_CPUOFF_BIT                  38
+#define FEATURE_STAPM_BIT                   39
+#define FEATURE_S0I3_BIT                    40
+#define FEATURE_DF_LIGHT_CSTATE             41
+#define FEATURE_PERF_LIMIT_BIT              42
+#define FEATURE_CORE_DLDO_BIT               43
+#define FEATURE_DVO_BIT                     44
+#define FEATURE_DS_VCN_BIT                  45
+#define FEATURE_CPPC_BIT                    46
+#define FEATURE_CPPC_PREFERRED_CORES        47
+#define FEATURE_DF_CSTATES_BIT              48
+#define FEATURE_CSTATE_BOOST_BIT            49
+#define FEATURE_ATHUB_PG_BIT                50
+#define FEATURE_VDDOFF_ECO_BIT              51
+#define FEATURE_SC_DIDT_BIT                 52  //SC_DIDT
+#define FEATURE_CC6_BIT                     53
+#define FEATURE_DS_UMCCLK_BIT               54
+#define FEATURE_DS_ISPCLK_BIT               55
+#define FEATURE_DS_HSPCLK_BIT               56
+#define FEATURE_P3T_BIT                     57
+#define FEATURE_DS_NPUCLK_BIT               58
+#define FEATURE_DS_VPECLK_BIT               59
+#define FEATURE_VPE_DPM_BIT                 60
+#define FEATURE_DACCCLK_DPM_BIT             61
+#define FEATURE_FP_DIDT                     62
+#define FEATURE_MMHUB_PG_BIT                63
+#define NUM_FEATURES                        64
+
+// Firmware Header/Footer
+struct SMU_Firmware_Footer {
+  uint32_t Signature;
+};
+typedef struct SMU_Firmware_Footer SMU_Firmware_Footer;
+
+// PSP3.0 Header Definition
+typedef struct {
+  uint32_t ImageVersion;
+  uint32_t ImageVersion2; // This is repeated because DW0 cannot be written in SRAM due to HW bug.
+  uint32_t Padding0[3];
+  uint32_t SizeFWSigned;
+  uint32_t Padding1[25];
+  uint32_t FirmwareType;
+  uint32_t Filler[32];
+} SMU_Firmware_Header;
+
+typedef struct {
+  // MP1_EXT_SCRATCH0
+  uint32_t DpmHandlerID         : 8;
+  uint32_t ActivityMonitorID    : 8;
+  uint32_t DpmTimerID           : 8;
+  uint32_t DpmHubID             : 4;
+  uint32_t DpmHubTask           : 4;
+  // MP1_EXT_SCRATCH1
+  uint32_t CclkSyncStatus       : 8;
+  uint32_t Ccx0CpuOff           : 2;
+  uint32_t Ccx1CpuOff           : 2;
+  uint32_t Ccx2CpuOff           : 2;
+  uint32_t GfxOffStatus         : 2;
+  uint32_t VddOff               : 1;
+  uint32_t InWhisperMode        : 1;
+  uint32_t ZstateStatus         : 4;
+  uint32_t DcnIps2Status        : 2;
+  uint32_t DstateFun            : 4;
+  uint32_t DstateDev            : 4;
+  // MP1_EXT_SCRATCH2
+  uint32_t P2JobHandler         :24;
+  uint32_t RsmuPmiP2PendingCnt  : 8;
+  // MP1_EXT_SCRATCH3
+  uint32_t PostCode             :32;
+  // MP1_EXT_SCRATCH4
+  uint32_t MsgPortBusy          :24;
+  uint32_t RsmuPmiP1Pending     : 1;
+  uint32_t DfCstateExitPending  : 1;
+  uint32_t Ccx0Pc6ExitPending   : 1;
+  uint32_t Ccx1Pc6ExitPending   : 1;
+  uint32_t Ccx2Pc6ExitPending   : 1;
+  uint32_t WarmResetPending     : 1;
+  uint32_t spare1               : 2;
+  // MP1_EXT_SCRATCH5
+  uint32_t IdleMask             :32;
+  // MP1_EXT_SCRATCH6 = RTOS threads' status
+  // MP1_EXT_SCRATCH7 = RTOS Current Job
+} FwStatus_t;
+
+
+#pragma pack(pop)
+
+#endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h
new file mode 100644
index 0000000000000..bf216f83e6891
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v15_0_0_ppsmc.h
@@ -0,0 +1,133 @@
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
+#ifndef __SMU_V15_0_0_PPSMC_H__
+#define __SMU_V15_0_0_PPSMC_H__
+
+
+/**
+* @file ppsmc.h
+*
+* @brief pplib (driver/host) to PMFW Interface
+*
+* Clients:  Driver/Host via pplib.
+* Protocols:
+*
+* @date 2016 - 2024
+*/
+
+/*! @mainpage PMFW-PPS (PPLib) Message Interface
+  This documentation contains the subsections:\n\n
+  @ref ResponseCodes\n
+  @ref definitions\n
+  @ref enums\n
+*/
+
+/** @def PPS_PMFW_IF_VER
+* PPS (PPLib) to PMFW IF version 1.0
+*/
+#define PPS_PMFW_IF_VER "1.0" ///< Major.Minor
+
+/** @defgroup ResponseCodes PMFW Response Codes
+*  @{
+*/
+// SMU Response Codes:
+#define PPSMC_Result_OK                    0x1  ///< Message Response OK
+#define PPSMC_Result_Failed                0xFF ///< Message Response Failed
+#define PPSMC_Result_UnknownCmd            0xFE ///< Message Response Unknown Command
+#define PPSMC_Result_CmdRejectedPrereq     0xFD ///< Message Response Command Failed Prerequisite
+#define PPSMC_Result_CmdRejectedBusy       0xFC ///< Message Response Command Rejected due to PMFW is busy. Sender should retry sending this message
+/** @}*/
+
+/** @defgroup definitions Message definitions
+*  @{
+*/
+// Message Definitions:
+#define PPSMC_MSG_TestMessage                   0x01 ///< To check if PMFW is alive and responding. Requirement specified by PMFW team
+#define PPSMC_MSG_GetPmfwVersion                0x02 ///< Get PMFW version
+#define PPSMC_MSG_GetDriverIfVersion            0x03 ///< Get PMFW_DRIVER_IF version
+#define PPSMC_MSG_PowerDownVcn                  0x04 ///< Power down VCN
+#define PPSMC_MSG_PowerUpVcn                    0x05 ///< Power up VCN; VCN is power gated by default
+#define PPSMC_MSG_SetSoftMinGfxclk              0x06 ///< Set SoftMin for GFXCLK, argument is frequency in MHz
+#define PPSMC_MSG_PrepareMp1ForUnload           0x07 ///< Prepare PMFW for GFX driver unload
+#define PPSMC_MSG_TransferTableSmu2Dram         0x08 ///< Transfer driver interface table from PMFW SRAM to DRAM
+#define PPSMC_MSG_TransferTableDram2Smu         0x09 ///< Transfer driver interface table from DRAM to PMFW SRAM
+#define PPSMC_MSG_GfxDeviceDriverReset          0x0A ///< Request GFX mode 2 reset
+#define PPSMC_MSG_GetEnabledSmuFeatures         0x0B ///< Get enabled features in PMFW
+#define PPSMC_MSG_SetSoftMinFclk                0x0C ///< Set hard min for FCLK
+#define PPSMC_MSG_SetSoftMinVcn                 0x0D ///< Set soft min for VCN clocks (VCLK and DCLK)
+
+#define PPSMC_MSG_EnableGfxImu                  0x0E ///< Enable GFX IMU
+
+#define PPSMC_MSG_AllowGfxOff                   0x0F ///< Inform PMFW of allowing GFXOFF entry
+#define PPSMC_MSG_DisallowGfxOff                0x10 ///< Inform PMFW of disallowing GFXOFF entry
+#define PPSMC_MSG_SetSoftMaxGfxClk              0x11 ///< Set soft max for GFX CLK
+
+#define PPSMC_MSG_SetSoftMaxSocclkByFreq        0x12 ///< Set soft max for SOC CLK
+#define PPSMC_MSG_SetSoftMaxFclkByFreq          0x13 ///< Set soft max for FCLK
+#define PPSMC_MSG_SetSoftMaxVcn                 0x14 ///< Set soft max for VCN clocks (VCLK and DCLK)
+#define PPSMC_MSG_PowerDownJpeg                 0x15 ///< Power down Jpeg
+#define PPSMC_MSG_PowerUpJpeg                   0x16 ///< Power up Jpeg; VCN is power gated by default
+
+#define PPSMC_MSG_SetSoftMinSocclkByFreq        0x17 ///< Set soft min for SOC CLK
+#define PPSMC_MSG_AllowZstates                  0x18 ///< Inform PMFM of allowing Zstate entry, i.e. no Miracast activity
+#define PPSMC_MSG_GetSmartShiftStatus           0x19 ///< Returns SmartShift enable vs disable
+#define PPSMC_MSG_PowerDownUmsch                0x1A ///< Power down VCN.UMSCH (aka VSCH) scheduler
+#define PPSMC_MSG_PowerUpUmsch                  0x1B ///< Power up VCN.UMSCH (aka VSCH) scheduler
+#define PPSMC_MSG_PowerUpVpe                    0x1C ///< Power up VPE
+#define PPSMC_MSG_PowerDownVpe                  0x1D ///< Power down VPE
+#define PPSMC_MSG_EnableLSdma                   0x1E ///< Enable LSDMA
+#define PPSMC_MSG_DisableLSdma                  0x1F ///< Disable LSDMA
+#define PPSMC_MSG_SetSoftMaxVpe                 0x20 ///<
+#define PPSMC_MSG_SetSoftMinVpe                 0x21 ///<
+#define PPSMC_Message_Count                     0x22 ///< Total number of PPSMC messages
+/** @}*/
+
+/**
+* @defgroup enums Enum Definitions
+*  @{
+*/
+
+/** @enum Mode_Reset_e
+* Mode reset type, argument for PPSMC_MSG_GfxDeviceDriverReset
+*/
+//argument for PPSMC_MSG_GfxDeviceDriverReset
+typedef enum {
+  MODE1_RESET = 1,  ///< Mode reset type 1
+  MODE2_RESET = 2   ///< Mode reset type 2
+} Mode_Reset_e;
+
+/** @}*/
+
+/** @enum ZStates_e
+* Zstate types, argument for PPSMC_MSG_AllowZstates
+*/
+//Argument for PPSMC_MSG_AllowZstates
+typedef enum  {
+  DISALLOW_ZSTATES = 0, ///< Disallow Zstates
+  ALLOW_ZSTATES_Z8 = 8, ///< Allows Z8 only
+  ALLOW_ZSTATES_Z9 = 9, ///< Allows Z9 and Z8
+} ZStates_e;
+
+/** @}*/
+#endif
-- 
2.52.0


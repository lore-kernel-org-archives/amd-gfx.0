Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C17CCD611E
	for <amd-gfx@archiver.kernel.org>; Mon,  9 Oct 2023 18:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E606410E29B;
	Mon,  9 Oct 2023 18:33:12 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2059.outbound.protection.outlook.com [40.107.92.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 54A6410E124
 for <amd-gfx@lists.freedesktop.org>; Mon,  9 Oct 2023 18:33:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lNQNNgWm+vCOGJyl/RTTyJJMIxGoQHThLA4GSwn7eWTUVjIBlar8YhksMmMlRfaTGPn6y4mEZY5MTUCJ1Z+t8F4zZ/gBOMlVNhMzaVIvu2ba8H4vP0kxzyZ4kqHlFWB8F8EnXXKSU8He+kVZBz6wZcCwibPqsXj4yc35ToZM+Uzkg+ox3SUlKB+VMCT5sQmpiJG7g1z24opnkTg0a9ceUlITLw6ynnpyyiUH/S90jJaEM5kOaa5VJbOUS9UqqbEepjVuAGeX40tqWmIAO934arTUKdcR2M/SAAPNATH2PRxOL3Reh849Sv0ltBdC+RaH1WAqkSTD8mP8e/gybeak9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tq2hscVnbT/n6ir/GImUuZnpGn8e2f8Y0aFCbBjCOTY=;
 b=iTXAuXKAj5AMqDhsoDp2wCJuDKM0sSgTQszuNR+WBXeULJ05YpAiD43DJPTkq3RrlVizCKh5VvRHt9RzuM0KUjVHEIVtOORO3Zad0Orwf4COwJGTp3a+0ozFz4SZomf9DzF4Xj7C/hsUMPIGaTQpBYKagDso/Fc1ZECxQSnl49D70KXQug9vF7g6CqYW7MUSPnM4kRlwQsY9owGRUTOZuEDInINcUxx3dRI9kMRq5II/AiPDLaOF5R85JURzE4LmTrCHQkRDoNZnn0KSmVz/bjf194amoV8d95mSWE+NV4WcGOQ+1TI3TqCUFAvZ/kMRsaKnw3SKo4UUrkT7nJky/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tq2hscVnbT/n6ir/GImUuZnpGn8e2f8Y0aFCbBjCOTY=;
 b=MtWSULcfwPunSrHztVpDvl7OF4x2lk0Dhf4uk6GsWaJhpNjI0ET89mjVRyfLMXER9N+qtzuyx6W6AnCLnJKhHDlxFkcskIOA0ZVYlqACF5b81qP+6njSQKYq869Vdm59AZs/1lQqw+FVmw5KtKdqvp/Tv3l8Me5KHKcDZIPOL/Q=
Received: from BL1PR13CA0359.namprd13.prod.outlook.com (2603:10b6:208:2c6::34)
 by IA1PR12MB7518.namprd12.prod.outlook.com (2603:10b6:208:419::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.36; Mon, 9 Oct
 2023 18:33:07 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2c6:cafe::ed) by BL1PR13CA0359.outlook.office365.com
 (2603:10b6:208:2c6::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.21 via Frontend
 Transport; Mon, 9 Oct 2023 18:33:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Mon, 9 Oct 2023 18:33:07 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 9 Oct
 2023 13:33:06 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/5] drm/amdgpu/swsmu: add smu v14_0_0 driver if file
Date: Mon, 9 Oct 2023 14:32:30 -0400
Message-ID: <20231009183234.518379-2-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231009183234.518379-1-alexander.deucher@amd.com>
References: <20231009183234.518379-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|IA1PR12MB7518:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f4dd84c-029b-4bf9-9f96-08dbc8f62ec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D7ANp0cFvx/8XZiP2q2ezMjgZn77Mx4yLa2uhu0K78V61MWd7XrSFwMxZBkIIj5mJFOF+4qMioH8tADVf8pf5BCqmx8XqpknYoFCbj7QQjbsRekONDs7ogR5aOmheuhnZA9xb7WfpU+1OAD7DD3pEUwEx0GZrFc7BZGaO02uFGC0hKjP8SZ0ZgqFLZggFrRjNCyR7IYy3y9YIPq6OKa43MsB4u92m5Aq3+QuzmVuZ238TrJWhz0nQYnkMv+0DnN5lqBLTJrcOvx1iUohUVqdxkQAxW5qoekciR0MkZEaWgj5jU9tO2mIe0lC3PrQ7V/JSgqjSt/7cMWxyE1LeuUT4AmTnnmtwqeS/gi5juUtlSQBOnxUZDIZNdqunQj7uKlIVjgV6X7zbAQCs8fnK6VxR1JzXfv0gCc6VKXZmvmTKvUKyzljOvs1Ezr++1tjemTf8TSp9NNqdyrnmLBBNFMKR/VL8vvA9Ths59k1Qtkqn6Ac0ACkZ/eptNjgIUdWjTTJ4tTeT0l3TOBmaNZ/UtV0C/wNoShgd+VFOTfI0O1pz+GEAtEUaCxTxKQ5BH1K8CgM0Ke+K0yOZarUnk5xGfibyP6+ODDucmQwJqstXCOyh+AnK+LC/n41zKt6kN9JuoUXi2DsIeooe90XFxEH9+j+rBYjR/WpfiIbil8HaOWfg933SsK4DkTqDEwvEBeWx7BLawlqVoj/bzsVs5M+ZB8t+lmOMtQW/hrqVHH0UwCnjywT9c62mCrXgplrj1CACgGop1BsABfThaeC66Kpaekg8w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(39860400002)(376002)(136003)(396003)(346002)(230922051799003)(1800799009)(82310400011)(451199024)(64100799003)(186009)(40470700004)(36840700001)(46966006)(356005)(86362001)(81166007)(36756003)(40460700003)(66899024)(40480700001)(82740400003)(478600001)(2906002)(41300700001)(8676002)(7696005)(5660300002)(6666004)(4326008)(8936002)(426003)(2616005)(336012)(54906003)(1076003)(83380400001)(16526019)(36860700001)(316002)(70586007)(70206006)(6916009)(47076005)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 18:33:07.4998 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f4dd84c-029b-4bf9-9f96-08dbc8f62ec8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7518
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
Cc: Alex Deucher <alexander.deucher@amd.com>, Li Ma <li.ma@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Li Ma <li.ma@amd.com>

Add initial smu v14_0_0 driver if file

v2: squash in updates (Alex)
v3: update interface (Alex)

Signed-off-by: Li Ma <li.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../inc/pmfw_if/smu14_driver_if_v14_0_0.h     | 281 ++++++++++++++++++
 1 file changed, 281 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
new file mode 100644
index 000000000000..cb6948a0b262
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
@@ -0,0 +1,281 @@
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+#ifndef SMU14_DRIVER_IF_V14_0_0_H
+#define SMU14_DRIVER_IF_V14_0_0_H
+
+// *** IMPORTANT ***
+// SMU TEAM: Always increment the interface version if
+// any structure is changed in this file
+#define PMFW_DRIVER_IF_VERSION 6
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
+  uint8_t  VpeClkLevelsEnabled;
+
+  uint8_t  NumMemPstatesEnabled;
+  uint8_t  NumFclkLevelsEnabled;
+  uint8_t  spare[2];
+
+  uint32_t MinGfxClk;
+  uint32_t MaxGfxClk;
+} DpmClocks_t;
+
+
+// Throttler Status Bitmask
+#define THROTTLER_STATUS_BIT_SPL              0
+#define THROTTLER_STATUS_BIT_FPPT             1
+#define THROTTLER_STATUS_BIT_SPPT             2
+#define THROTTLER_STATUS_BIT_SPPT_APU         3
+#define THROTTLER_STATUS_BIT_THM_CORE         4
+#define THROTTLER_STATUS_BIT_THM_GFX          5
+#define THROTTLER_STATUS_BIT_THM_SOC          6
+#define THROTTLER_STATUS_BIT_TDC_VDD          7
+#define THROTTLER_STATUS_BIT_TDC_VDDCCX       8
+#define THROTTLER_STATUS_BIT_TDC_SOC          9
+#define THROTTLER_STATUS_BIT_PROCHOT_CPU      10
+#define THROTTLER_STATUS_BIT_PROCHOT_GFX      11
+#define THROTTLER_STATUS_BIT_EDC_CPU_CLASSIC  12
+#define THROTTLER_STATUS_BIT_EDC_CPU_DENSE    13
+#define THROTTLER_STATUS_BIT_EDC_GFX          14
+
+typedef struct {
+  uint16_t GfxclkFrequency;             //[MHz]
+  uint16_t SocclkFrequency;             //[MHz]
+  uint16_t VclkFrequency;               //[MHz]
+  uint16_t DclkFrequency;               //[MHz]
+  uint16_t MemclkFrequency;             //[MHz]
+  uint16_t spare;
+  uint16_t UvdActivity;                 //[centi]
+  uint16_t GfxActivity;                 //[centi]
+
+  uint16_t Voltage[2];                  //[mV] indices: VDDCR_VDD, VDDCR_SOC
+  uint16_t Current[2];                  //[mA] indices: VDDCR_VDD, VDDCR_SOC
+  uint16_t Power[2];                    //[mW] indices: VDDCR_VDD, VDDCR_SOC
+
+  uint16_t CoreFrequency[8];            //[MHz]
+  uint16_t CorePower[8];                //[mW]
+  uint16_t CoreTemperature[8];          //[centi-Celsius]
+  uint16_t L3Frequency[2];              //[MHz]
+  uint16_t L3Temperature[2];            //[centi-Celsius]
+
+  uint16_t spare2[24];
+
+  uint16_t GfxTemperature;              //[centi-Celsius]
+  uint16_t SocTemperature;              //[centi-Celsius]
+  uint16_t ThrottlerStatus;
+
+  uint16_t CurrentSocketPower;          //[mW]
+  uint16_t StapmOpnLimit;               //[W]
+  uint16_t StapmCurrentLimit;           //[W]
+  uint32_t ApuPower;                    //[mW]
+  uint32_t dGpuPower;                   //[mW]
+
+  uint16_t VddTdcValue;                 //[mA]
+  uint16_t SocTdcValue;                 //[mA]
+  uint16_t VddEdcValue;                 //[mA]
+  uint16_t SocEdcValue;                 //[mA]
+
+  uint16_t InfrastructureCpuMaxFreq;    //[MHz]
+  uint16_t InfrastructureGfxMaxFreq;    //[MHz]
+
+  uint16_t SkinTemp;
+  uint16_t DeviceState;
+  uint16_t CurTemp;                     //[centi-Celsius]
+  uint16_t FilterAlphaValue;            //[m]
+
+  //PMFW-8735
+  uint16_t AverageGfxclkFrequency;
+  uint16_t AverageFclkFrequency;
+  uint16_t AverageGfxActivity;
+  uint16_t AverageSocclkFrequency;
+  uint16_t AverageVclkFrequency;
+  uint16_t AverageVcnActivity;
+  uint16_t AverageDRAMReads;          //Filtered DF Bandwidth::DRAM Reads
+  uint16_t AverageDRAMWrites;         //Filtered DF Bandwidth::DRAM Writes
+  uint16_t AverageSocketPower;        //Filtered value of CurrentSocketPower
+  uint16_t AverageCorePower[2];       //Filtered of [sum of CorePower[8] per ccx])
+  uint16_t AverageCoreC0Residency[16]; //Filtered of [average C0 residency % per core]
+  uint16_t spare3;
+  uint32_t MetricsCounter;            //Counts the # of metrics table parameter reads per update to the metrics table, i.e. if the metrics table update happens every 1 second, this value could be up to 1000 if the smu collected metrics data every cycle, or as low as 0 if the smu was asleep the whole time. Reset to 0 after writing.
+} SmuMetrics_t;
+
+typedef struct {
+  uint16_t StapmMaxPlatformLimit;            //[W]
+  uint16_t StapmMinPlatformLimit;            //[W]
+  uint16_t FastPptMaxPlatformLimit;          //[W]
+  uint16_t FastPptMinPlatformLimit;          //[W]
+  uint16_t SlowPptMaxPlatformLimit;          //[W]
+  uint16_t SlowPptMinPlatformLimit;          //[W]
+  uint16_t SlowPptApuMaxPlatformLimit;       //[W]
+  uint16_t SlowPptApuMinPlatformLimit;       //[W]
+} PmfInfo_t;
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
+#define TABLE_WATERMARKS            1 // Called by DAL through VBIOS
+#define TABLE_CUSTOM_DPM            2 // Called by Driver
+#define TABLE_BIOS_GPIO_CONFIG      3 // Called by BIOS
+#define TABLE_DPMCLOCKS             4 // Called by Driver and VBIOS
+#define TABLE_MOMENTARY_PM          5 // Called by Tools
+#define TABLE_MODERN_STDBY          6 // Called by Tools for Modern Standby Log
+#define TABLE_SMU_METRICS           7 // Called by Driver and SMF/PMF
+#define TABLE_INFRASTRUCTURE_LIMITS 8 // Called by SMF/PMF
+#define TABLE_COUNT                 9
+
+#endif
-- 
2.41.0


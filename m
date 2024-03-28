Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B59C54E67
	for <amd-gfx@archiver.kernel.org>; Thu, 28 Mar 2024 04:21:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9838F1120D8;
	Thu, 28 Mar 2024 04:21:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WdKAufA4";
	dkim-atps=neutral
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2068.outbound.protection.outlook.com [40.107.220.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5247811202A
 for <amd-gfx@lists.freedesktop.org>; Thu, 28 Mar 2024 04:21:18 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UiOvJ4F8QSqMrhUnsJaySYAmkL4bIeRo5qqWIE6z2/phOnxHtxUxkfRtiETGIuR5HNT1HqAcqA3VBhsOD02+jr6OCW6LEG4w6UD4JnRy7AtNosx5dOvt/O81Yc2qSVKdJ88oZMZMCzqI5jQ2RHGJRjxfrjof8LtVkZ2jsJs+xlHOcirW0xw/SyedqD4sUp/J1/LRCYQfFg7IjsXHJzzQogIruLuhN/iXCn0ti6XaLtRohrLV8r1wY7HeWgrdfk9HM+yGeuoHZVvXFV1RyaeGXW3XeJix5OokHURrIbETGGvmXsQFAjQ2X7TrmXasiNcMyML3vc0iMFe2+vl80a3+HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YQNTHv5SPQIKo3krFMicK7sFIhTpjaoDc3uu7TDfPX8=;
 b=LmjVhcSu9Bwjg6LFn8xs62U5WI6xVnexBcGndU+pvfRsY1Otd7TPY+qQWMcPwvad2X+Fpuoozf1ThUcnHtSXjSifIMOI6O9INZG3bagDIv3yZ5ySn3uzo9McJjj6O8ah7xKdLzghZa3lk1JCpVGNm6EL60xtrjdfMl+K6dS5LRSr58QxNiigX7cbTI1uB81fWC+VUij/ARg7nrWbcTnDRLEuRnzui4UeHN4I12OUIzzBBt7YPdTNMTJBIK405+VrdiX1MAQhHQbxW0XWsRbVzU/CJn4NdnNiFSOjlkEFXIzw+TxYeVbHDVzZZew8+CzneJevd2g5yS6DKBoiIdE4hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YQNTHv5SPQIKo3krFMicK7sFIhTpjaoDc3uu7TDfPX8=;
 b=WdKAufA4TfeR9cn0VcZRo2YyfNaUze2WQansX+kFgRH1gvcOa9Wwf85qnx5SrO1GaGqqIQM4twABY8pahVo3ZQQQ1selyA4cu7E9tXRllnK9sWVdc0y5K5eqke++fC9UEf5ezs1vhlGRN7L7s94zftq8BHi0Lu2Tf6MasARKNLM=
Received: from SJ0PR03CA0366.namprd03.prod.outlook.com (2603:10b6:a03:3a1::11)
 by BL3PR12MB6450.namprd12.prod.outlook.com (2603:10b6:208:3b9::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 04:21:12 +0000
Received: from CO1PEPF000066E6.namprd05.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::6d) by SJ0PR03CA0366.outlook.office365.com
 (2603:10b6:a03:3a1::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.13 via Frontend
 Transport; Thu, 28 Mar 2024 04:21:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000066E6.mail.protection.outlook.com (10.167.249.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7409.10 via Frontend Transport; Thu, 28 Mar 2024 04:21:11 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 27 Mar
 2024 23:21:10 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: lima1002 <li.ma@amd.com>, Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 1/2] drm/amd/swsmu: Update smu v14.0.0 headers to be 14.0.1
 compatible
Date: Thu, 28 Mar 2024 00:20:52 -0400
Message-ID: <20240328042053.414131-1-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066E6:EE_|BL3PR12MB6450:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f58ac25-f2cf-44f3-ba78-08dc4ede802c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jqo7tAgv7PxtOfCtaDPxABhXipQrTrL2gj4qIQ1Oiza8HhqhcL/X/Ngi9lQ4N+NHfzsh+28y3qaayPwMzSSjaQ8+Lmkrt7XUqHD4ZJlTJ4W+/0srLMbBY0w6vBJ0Bl1AuRk+qfgzzG/Pg55QcTMq6QQeSQRNPGisLZiDz0ZbTxd5tS+ESEtpKwUnxL67dl97e1JD6DWh5Yqjh/iDkDnMPLvCexftLecgITBseYzlY57BqznB2NaA+6hG9bh95BusBIH6BDF47Q7T7faMjx2VaAyyKc5opwVO/TMDAjd03YVMRHT+WoK7WVMjndhMCN1WwtqonVGIKr5I4cJEaiaye6koHsBCrNVRpawSD2D+n3CzEGnkVwUKLaNOb15KT4IOrAfT1Ug8gnF78Hz9Eh/XXvIAK+r1XBrILdKq9uXW6cMcyLNGnpvPKq9bers3FcaVs+5DtpgD3yYkRyCQ09MSpUi73HjpoZk2iGRXUIEBlnoCUXGknHQFvdmsrrmCoiJExq9SdjOB9deMweqFoTMnAGjOKYSicpcgjvYDRg78EskhmmjP8gzkqoozCSCNcMWJZzuv3qe9wXOROGzKPonwiiRLBIkjihZgjpj4bVWbI9Bbwb0D4WSpyMe7YuXKQ4o1XyAXpLw9G6Qrtcxzsv2ykFbythfQdGzTMHd5HRe5Y0h0RgyutV50xpvXQEYi2Ydg7CggzxWx6RK9ul9bBsVslvMy0rdeNB93Xgql81eQ/MZXaMS7ZYKtokaIEBw8K75n
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 04:21:11.8482 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f58ac25-f2cf-44f3-ba78-08dc4ede802c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000066E6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6450
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

From: lima1002 <li.ma@amd.com>

update ppsmc.h pmfw.h and driver_if.h for smu v14_0_1

Signed-off-by: lima1002 <li.ma@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../inc/pmfw_if/smu14_driver_if_v14_0_0.h     |  33 +-
 .../pm/swsmu/inc/pmfw_if/smu_v14_0_0_pmfw.h   |  55 ++-
 .../pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h  |  18 +-
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |   1 +
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |   2 +-
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 347 ++++++++++++++++--
 6 files changed, 413 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
index 5bb7a63c0602..97522c085258 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0_0.h
@@ -144,6 +144,37 @@ typedef struct {
   uint32_t MaxGfxClk;
 } DpmClocks_t;
 
+//Freq in MHz
+//Voltage in milli volts with 2 fractional bits
+typedef struct {
+  uint32_t DcfClocks[NUM_DCFCLK_DPM_LEVELS];
+  uint32_t DispClocks[NUM_DISPCLK_DPM_LEVELS];
+  uint32_t DppClocks[NUM_DPPCLK_DPM_LEVELS];
+  uint32_t SocClocks[NUM_SOCCLK_DPM_LEVELS];
+  uint32_t VClocks0[NUM_VCN_DPM_LEVELS];
+  uint32_t VClocks1[NUM_VCN_DPM_LEVELS];
+  uint32_t DClocks0[NUM_VCN_DPM_LEVELS];
+  uint32_t DClocks1[NUM_VCN_DPM_LEVELS];
+  uint32_t VPEClocks[NUM_VPE_DPM_LEVELS];
+  uint32_t FclkClocks_Freq[NUM_FCLK_DPM_LEVELS];
+  uint32_t FclkClocks_Voltage[NUM_FCLK_DPM_LEVELS];
+  uint32_t SocVoltage[NUM_SOC_VOLTAGE_LEVELS];
+  MemPstateTable_t MemPstateTable[NUM_MEM_PSTATE_LEVELS];
+
+  uint8_t  NumDcfClkLevelsEnabled;
+  uint8_t  NumDispClkLevelsEnabled; //Applies to both Dispclk and Dppclk
+  uint8_t  NumSocClkLevelsEnabled;
+  uint8_t  Vcn0ClkLevelsEnabled;     //Applies to both Vclk0 and Dclk0
+  uint8_t  Vcn1ClkLevelsEnabled;     //Applies to both Vclk1 and Dclk1
+  uint8_t  VpeClkLevelsEnabled;
+  uint8_t  NumMemPstatesEnabled;
+  uint8_t  NumFclkLevelsEnabled;
+  uint8_t  spare;
+
+  uint32_t MinGfxClk;
+  uint32_t MaxGfxClk;
+} DpmClocks_t_v14_0_1;
+
 typedef struct {
   uint16_t CoreFrequency[16];          //Target core frequency [MHz]
   uint16_t CorePower[16];              //CAC calculated core power [mW]
@@ -224,7 +255,7 @@ typedef enum {
 #define TABLE_CUSTOM_DPM            2 // Called by Driver
 #define TABLE_BIOS_GPIO_CONFIG      3 // Called by BIOS
 #define TABLE_DPMCLOCKS             4 // Called by Driver and VBIOS
-#define TABLE_SPARE0                5 // Unused
+#define TABLE_MOMENTARY_PM          5 // Called by Tools
 #define TABLE_MODERN_STDBY          6 // Called by Tools for Modern Standby Log
 #define TABLE_SMU_METRICS           7 // Called by Driver and SMF/PMF
 #define TABLE_COUNT                 8
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_pmfw.h
index 356e0f57a426..ddb625860083 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_pmfw.h
@@ -42,7 +42,7 @@
 #define FEATURE_EDC_BIT                      7
 #define FEATURE_PLL_POWER_DOWN_BIT           8
 #define FEATURE_VDDOFF_BIT                   9
-#define FEATURE_VCN_DPM_BIT                 10
+#define FEATURE_VCN_DPM_BIT                 10   /* this is for both VCN0 and VCN1 */
 #define FEATURE_DS_MPM_BIT                  11
 #define FEATURE_FCLK_DPM_BIT                12
 #define FEATURE_SOCCLK_DPM_BIT              13
@@ -56,9 +56,9 @@
 #define FEATURE_DS_GFXCLK_BIT               21
 #define FEATURE_DS_SOCCLK_BIT               22
 #define FEATURE_DS_LCLK_BIT                 23
-#define FEATURE_LOW_POWER_DCNCLKS_BIT       24  // for all DISP clks
+#define FEATURE_LOW_POWER_DCNCLKS_BIT       24
 #define FEATURE_DS_SHUBCLK_BIT              25
-#define FEATURE_SPARE0_BIT                  26  //SPARE
+#define FEATURE_RESERVED0_BIT               26
 #define FEATURE_ZSTATES_BIT                 27
 #define FEATURE_IOMMUL2_PG_BIT              28
 #define FEATURE_DS_FCLK_BIT                 29
@@ -66,8 +66,8 @@
 #define FEATURE_DS_MP1CLK_BIT               31
 #define FEATURE_WHISPER_MODE_BIT            32
 #define FEATURE_SMU_LOW_POWER_BIT           33
-#define FEATURE_SMART_L3_RINSER_BIT         34
-#define FEATURE_SPARE1_BIT                  35  //SPARE
+#define FEATURE_RESERVED1_BIT               34  /* v14_0_0 SMART_L3_RINSER; v14_0_1 RESERVED1 */
+#define FEATURE_GFX_DEM_BIT                 35  /* v14_0_0 SPARE; v14_0_1 GFX_DEM */
 #define FEATURE_PSI_BIT                     36
 #define FEATURE_PROCHOT_BIT                 37
 #define FEATURE_CPUOFF_BIT                  38
@@ -77,11 +77,11 @@
 #define FEATURE_PERF_LIMIT_BIT              42
 #define FEATURE_CORE_DLDO_BIT               43
 #define FEATURE_DVO_BIT                     44
-#define FEATURE_DS_VCN_BIT                  45
+#define FEATURE_DS_VCN_BIT                  45  /* v14_0_1 this is for both VCN0 and VCN1 */
 #define FEATURE_CPPC_BIT                    46
 #define FEATURE_CPPC_PREFERRED_CORES        47
 #define FEATURE_DF_CSTATES_BIT              48
-#define FEATURE_SPARE2_BIT                  49  //SPARE
+#define FEATURE_FAST_PSTATE_CLDO_BIT        49  /* v14_0_0 SPARE */
 #define FEATURE_ATHUB_PG_BIT                50
 #define FEATURE_VDDOFF_ECO_BIT              51
 #define FEATURE_ZSTATES_ECO_BIT             52
@@ -93,8 +93,8 @@
 #define FEATURE_DS_IPUCLK_BIT               58
 #define FEATURE_DS_VPECLK_BIT               59
 #define FEATURE_VPE_DPM_BIT                 60
-#define FEATURE_SPARE_61                    61
-#define FEATURE_FP_DIDT                     62
+#define FEATURE_SMART_L3_RINSER_BIT         61  /* v14_0_0 SPARE*/
+#define FEATURE_PCC_BIT                     62  /* v14_0_0 FP_DIDT v14_0_1 PCC_BIT */
 #define NUM_FEATURES                        63
 
 // Firmware Header/Footer
@@ -151,6 +151,43 @@ typedef struct {
   // MP1_EXT_SCRATCH7 = RTOS Current Job
 } FwStatus_t;
 
+typedef struct {
+  // MP1_EXT_SCRATCH0
+  uint32_t DpmHandlerID         : 8;
+  uint32_t ActivityMonitorID    : 8;
+  uint32_t DpmTimerID           : 8;
+  uint32_t DpmHubID             : 4;
+  uint32_t DpmHubTask           : 4;
+  // MP1_EXT_SCRATCH1
+  uint32_t CclkSyncStatus       : 8;
+  uint32_t ZstateStatus         : 4;
+  uint32_t Cpu1VddOff           : 4;
+  uint32_t DstateFun            : 4;
+  uint32_t DstateDev            : 4;
+  uint32_t GfxOffStatus         : 2;
+  uint32_t Cpu0Off              : 2;
+  uint32_t Cpu1Off              : 2;
+  uint32_t Cpu0VddOff           : 2;
+  // MP1_EXT_SCRATCH2
+  uint32_t P2JobHandler         :32;
+  // MP1_EXT_SCRATCH3
+  uint32_t PostCode             :32;
+  // MP1_EXT_SCRATCH4
+  uint32_t MsgPortBusy          :15;
+  uint32_t RsmuPmiP1Pending     : 1;
+  uint32_t RsmuPmiP2PendingCnt  : 8;
+  uint32_t DfCstateExitPending  : 1;
+  uint32_t Pc6EntryPending      : 1;
+  uint32_t Pc6ExitPending       : 1;
+  uint32_t WarmResetPending     : 1;
+  uint32_t Mp0ClkPending        : 1;
+  uint32_t InWhisperMode        : 1;
+  uint32_t spare2               : 2;
+  // MP1_EXT_SCRATCH5
+  uint32_t IdleMask             :32;
+  // MP1_EXT_SCRATCH6 = RTOS threads' status
+  // MP1_EXT_SCRATCH7 = RTOS Current Job
+} FwStatus_t_v14_0_1;
 
 #pragma pack(pop)
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h
index ca7ce4251482..c4dc5881d8df 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v14_0_0_ppsmc.h
@@ -72,23 +72,19 @@
 #define PPSMC_MSG_SetHardMinSocclkByFreq        0x13 ///< Set hard min for SOC CLK
 #define PPSMC_MSG_SetSoftMinFclk                0x14 ///< Set hard min for FCLK
 #define PPSMC_MSG_SetSoftMinVcn0                0x15 ///< Set soft min for VCN0 clocks (VCLK0 and DCLK0)
-
 #define PPSMC_MSG_EnableGfxImu                  0x16 ///< Enable GFX IMU
-
-#define PPSMC_MSG_spare_0x17                    0x17
-#define PPSMC_MSG_spare_0x18                    0x18
+#define PPSMC_MSG_spare_0x17                    0x17 ///< Get GFX clock frequency
+#define PPSMC_MSG_spare_0x18                    0x18 ///< Get FCLK frequency
 #define PPSMC_MSG_AllowGfxOff                   0x19 ///< Inform PMFW of allowing GFXOFF entry
 #define PPSMC_MSG_DisallowGfxOff                0x1A ///< Inform PMFW of disallowing GFXOFF entry
 #define PPSMC_MSG_SetSoftMaxGfxClk              0x1B ///< Set soft max for GFX CLK
 #define PPSMC_MSG_SetHardMinGfxClk              0x1C ///< Set hard min for GFX CLK
-
 #define PPSMC_MSG_SetSoftMaxSocclkByFreq        0x1D ///< Set soft max for SOC CLK
 #define PPSMC_MSG_SetSoftMaxFclkByFreq          0x1E ///< Set soft max for FCLK
 #define PPSMC_MSG_SetSoftMaxVcn0                0x1F ///< Set soft max for VCN0 clocks (VCLK0 and DCLK0)
-#define PPSMC_MSG_spare_0x20                    0x20
+#define PPSMC_MSG_spare_0x20                    0x20 ///< Set power limit percentage
 #define PPSMC_MSG_PowerDownJpeg0                0x21 ///< Power down Jpeg of VCN0
 #define PPSMC_MSG_PowerUpJpeg0                  0x22 ///< Power up Jpeg of VCN0; VCN0 is power gated by default
-
 #define PPSMC_MSG_SetHardMinFclkByFreq          0x23 ///< Set hard min for FCLK
 #define PPSMC_MSG_SetSoftMinSocclkByFreq        0x24 ///< Set soft min for SOC CLK
 #define PPSMC_MSG_AllowZstates                  0x25 ///< Inform PMFM of allowing Zstate entry, i.e. no Miracast activity
@@ -99,8 +95,8 @@
 #define PPSMC_MSG_PowerUpIspByTile              0x2A ///< This message is used to power up ISP tiles and enable the ISP DPM
 #define PPSMC_MSG_SetHardMinIspiclkByFreq       0x2B ///< Set HardMin by frequency for ISPICLK
 #define PPSMC_MSG_SetHardMinIspxclkByFreq       0x2C ///< Set HardMin by frequency for ISPXCLK
-#define PPSMC_MSG_PowerDownUmsch                0x2D ///< Power down VCN.UMSCH (aka VSCH) scheduler
-#define PPSMC_MSG_PowerUpUmsch                  0x2E ///< Power up VCN.UMSCH (aka VSCH) scheduler
+#define PPSMC_MSG_PowerDownUmsch                0x2D ///< Power down VCN0.UMSCH (aka VSCH) scheduler
+#define PPSMC_MSG_PowerUpUmsch                  0x2E ///< Power up VCN0.UMSCH (aka VSCH) scheduler
 #define PPSMC_Message_IspStutterOn_MmhubPgDis   0x2F ///< ISP StutterOn mmHub PgDis
 #define PPSMC_Message_IspStutterOff_MmhubPgEn   0x30 ///< ISP StufferOff mmHub PgEn
 #define PPSMC_MSG_PowerUpVpe                    0x31 ///< Power up VPE
@@ -110,7 +106,9 @@
 #define PPSMC_MSG_DisableLSdma                  0x35 ///< Disable LSDMA
 #define PPSMC_MSG_SetSoftMaxVpe                 0x36 ///<
 #define PPSMC_MSG_SetSoftMinVpe                 0x37 ///<
-#define PPSMC_Message_Count                     0x38 ///< Total number of PPSMC messages
+#define PPSMC_MSG_AllocMALLCache                0x38 ///< Allocating MALL Cache
+#define PPSMC_MSG_ReleaseMALLCache              0x39 ///< Releasing MALL Cache
+#define PPSMC_Message_Count                     0x3A ///< Total number of PPSMC messages
 /** @}*/
 
 /**
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
index 3f7463c1c1a9..4af1985ae446 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -27,6 +27,7 @@
 
 #define SMU14_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU14_DRIVER_IF_VERSION_SMU_V14_0_0 0x7
+#define SMU14_DRIVER_IF_VERSION_SMU_V14_0_1 0x6
 #define SMU14_DRIVER_IF_VERSION_SMU_V14_0_2 0x1
 
 #define FEATURE_MASK(feature) (1ULL << feature)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
index 9e39f99154f9..07a65e005785 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c
@@ -234,7 +234,7 @@ int smu_v14_0_check_fw_version(struct smu_context *smu)
 		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_0;
 		break;
 	case IP_VERSION(14, 0, 1):
-		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_0;
+		smu->smc_driver_if_version = SMU14_DRIVER_IF_VERSION_SMU_V14_0_1;
 		break;
 
 	default:
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index ff6e464e40a6..e4419e1561ef 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -161,7 +161,7 @@ static int smu_v14_0_0_init_smc_tables(struct smu_context *smu)
 
 	SMU_TABLE_INIT(tables, SMU_TABLE_WATERMARKS, sizeof(Watermarks_t),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
-	SMU_TABLE_INIT(tables, SMU_TABLE_DPMCLOCKS, sizeof(DpmClocks_t),
+	SMU_TABLE_INIT(tables, SMU_TABLE_DPMCLOCKS, max(sizeof(DpmClocks_t), sizeof(DpmClocks_t_v14_0_1)),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
 	SMU_TABLE_INIT(tables, SMU_TABLE_SMU_METRICS, sizeof(SmuMetrics_t),
 		PAGE_SIZE, AMDGPU_GEM_DOMAIN_VRAM);
@@ -171,7 +171,7 @@ static int smu_v14_0_0_init_smc_tables(struct smu_context *smu)
 		goto err0_out;
 	smu_table->metrics_time = 0;
 
-	smu_table->clocks_table = kzalloc(sizeof(DpmClocks_t), GFP_KERNEL);
+	smu_table->clocks_table = kzalloc(max(sizeof(DpmClocks_t), sizeof(DpmClocks_t_v14_0_1)), GFP_KERNEL);
 	if (!smu_table->clocks_table)
 		goto err1_out;
 
@@ -599,6 +599,60 @@ static int smu_v14_0_0_mode2_reset(struct smu_context *smu)
 	return ret;
 }
 
+static int smu_v14_0_1_get_dpm_freq_by_index(struct smu_context *smu,
+						enum smu_clk_type clk_type,
+						uint32_t dpm_level,
+						uint32_t *freq)
+{
+	DpmClocks_t_v14_0_1 *clk_table = smu->smu_table.clocks_table;
+
+	if (!clk_table || clk_type >= SMU_CLK_COUNT)
+		return -EINVAL;
+
+	switch (clk_type) {
+	case SMU_SOCCLK:
+		if (dpm_level >= clk_table->NumSocClkLevelsEnabled)
+			return -EINVAL;
+		*freq = clk_table->SocClocks[dpm_level];
+		break;
+	case SMU_VCLK:
+		if (dpm_level >= clk_table->Vcn0ClkLevelsEnabled)
+			return -EINVAL;
+		*freq = clk_table->VClocks0[dpm_level];
+		break;
+	case SMU_DCLK:
+		if (dpm_level >= clk_table->Vcn0ClkLevelsEnabled)
+			return -EINVAL;
+		*freq = clk_table->DClocks0[dpm_level];
+		break;
+	case SMU_VCLK1:
+		if (dpm_level >= clk_table->Vcn1ClkLevelsEnabled)
+			return -EINVAL;
+		*freq = clk_table->VClocks1[dpm_level];
+		break;
+	case SMU_DCLK1:
+		if (dpm_level >= clk_table->Vcn1ClkLevelsEnabled)
+			return -EINVAL;
+		*freq = clk_table->DClocks1[dpm_level];
+		break;
+	case SMU_UCLK:
+	case SMU_MCLK:
+		if (dpm_level >= clk_table->NumMemPstatesEnabled)
+			return -EINVAL;
+		*freq = clk_table->MemPstateTable[dpm_level].MemClk;
+		break;
+	case SMU_FCLK:
+		if (dpm_level >= clk_table->NumFclkLevelsEnabled)
+			return -EINVAL;
+		*freq = clk_table->FclkClocks_Freq[dpm_level];
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int smu_v14_0_0_get_dpm_freq_by_index(struct smu_context *smu,
 						enum smu_clk_type clk_type,
 						uint32_t dpm_level,
@@ -643,6 +697,19 @@ static int smu_v14_0_0_get_dpm_freq_by_index(struct smu_context *smu,
 	return 0;
 }
 
+static int smu_v14_0_common_get_dpm_freq_by_index(struct smu_context *smu,
+						enum smu_clk_type clk_type,
+						uint32_t dpm_level,
+						uint32_t *freq)
+{
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0))
+		smu_v14_0_0_get_dpm_freq_by_index(smu, clk_type, dpm_level, freq);
+	else if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
+		smu_v14_0_1_get_dpm_freq_by_index(smu, clk_type, dpm_level, freq);
+
+	return 0;
+}
+
 static bool smu_v14_0_0_clk_dpm_is_enabled(struct smu_context *smu,
 						enum smu_clk_type clk_type)
 {
@@ -663,6 +730,8 @@ static bool smu_v14_0_0_clk_dpm_is_enabled(struct smu_context *smu,
 		break;
 	case SMU_VCLK:
 	case SMU_DCLK:
+	case SMU_VCLK1:
+	case SMU_DCLK1:
 		feature_id = SMU_FEATURE_VCN_DPM_BIT;
 		break;
 	default:
@@ -672,6 +741,126 @@ static bool smu_v14_0_0_clk_dpm_is_enabled(struct smu_context *smu,
 	return smu_cmn_feature_is_enabled(smu, feature_id);
 }
 
+static int smu_v14_0_1_get_dpm_ultimate_freq(struct smu_context *smu,
+							enum smu_clk_type clk_type,
+							uint32_t *min,
+							uint32_t *max)
+{
+	DpmClocks_t_v14_0_1 *clk_table = smu->smu_table.clocks_table;
+	uint32_t clock_limit;
+	uint32_t max_dpm_level, min_dpm_level;
+	int ret = 0;
+
+	if (!smu_v14_0_0_clk_dpm_is_enabled(smu, clk_type)) {
+		switch (clk_type) {
+		case SMU_MCLK:
+		case SMU_UCLK:
+			clock_limit = smu->smu_table.boot_values.uclk;
+			break;
+		case SMU_FCLK:
+			clock_limit = smu->smu_table.boot_values.fclk;
+			break;
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			clock_limit = smu->smu_table.boot_values.gfxclk;
+			break;
+		case SMU_SOCCLK:
+			clock_limit = smu->smu_table.boot_values.socclk;
+			break;
+		case SMU_VCLK:
+		case SMU_VCLK1:
+			clock_limit = smu->smu_table.boot_values.vclk;
+			break;
+		case SMU_DCLK:
+		case SMU_DCLK1:
+			clock_limit = smu->smu_table.boot_values.dclk;
+			break;
+		default:
+			clock_limit = 0;
+			break;
+		}
+
+		/* clock in Mhz unit */
+		if (min)
+			*min = clock_limit / 100;
+		if (max)
+			*max = clock_limit / 100;
+
+		return 0;
+	}
+
+	if (max) {
+		switch (clk_type) {
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			*max = clk_table->MaxGfxClk;
+			break;
+		case SMU_MCLK:
+		case SMU_UCLK:
+		case SMU_FCLK:
+			max_dpm_level = 0;
+			break;
+		case SMU_SOCCLK:
+			max_dpm_level = clk_table->NumSocClkLevelsEnabled - 1;
+			break;
+		case SMU_VCLK:
+		case SMU_DCLK:
+			max_dpm_level = clk_table->Vcn0ClkLevelsEnabled - 1;
+			break;
+		case SMU_VCLK1:
+		case SMU_DCLK1:
+			max_dpm_level = clk_table->Vcn1ClkLevelsEnabled - 1;
+			break;
+		default:
+			ret = -EINVAL;
+			goto failed;
+		}
+
+		if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK) {
+			ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, max_dpm_level, max);
+			if (ret)
+				goto failed;
+		}
+	}
+
+	if (min) {
+		switch (clk_type) {
+		case SMU_GFXCLK:
+		case SMU_SCLK:
+			*min = clk_table->MinGfxClk;
+			break;
+		case SMU_MCLK:
+		case SMU_UCLK:
+			min_dpm_level = clk_table->NumMemPstatesEnabled - 1;
+			break;
+		case SMU_FCLK:
+			min_dpm_level = clk_table->NumFclkLevelsEnabled - 1;
+			break;
+		case SMU_SOCCLK:
+			min_dpm_level = 0;
+			break;
+		case SMU_VCLK:
+		case SMU_DCLK:
+		case SMU_VCLK1:
+		case SMU_DCLK1:
+			min_dpm_level = 0;
+			break;
+		default:
+			ret = -EINVAL;
+			goto failed;
+		}
+
+		if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK) {
+			ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, min_dpm_level, min);
+			if (ret)
+				goto failed;
+		}
+	}
+
+failed:
+	return ret;
+}
+
 static int smu_v14_0_0_get_dpm_ultimate_freq(struct smu_context *smu,
 							enum smu_clk_type clk_type,
 							uint32_t *min,
@@ -742,7 +931,7 @@ static int smu_v14_0_0_get_dpm_ultimate_freq(struct smu_context *smu,
 		}
 
 		if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK) {
-			ret = smu_v14_0_0_get_dpm_freq_by_index(smu, clk_type, max_dpm_level, max);
+			ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, max_dpm_level, max);
 			if (ret)
 				goto failed;
 		}
@@ -774,7 +963,7 @@ static int smu_v14_0_0_get_dpm_ultimate_freq(struct smu_context *smu,
 		}
 
 		if (clk_type != SMU_GFXCLK && clk_type != SMU_SCLK) {
-			ret = smu_v14_0_0_get_dpm_freq_by_index(smu, clk_type, min_dpm_level, min);
+			ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, min_dpm_level, min);
 			if (ret)
 				goto failed;
 		}
@@ -784,6 +973,19 @@ static int smu_v14_0_0_get_dpm_ultimate_freq(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v14_0_common_get_dpm_ultimate_freq(struct smu_context *smu,
+							enum smu_clk_type clk_type,
+							uint32_t *min,
+							uint32_t *max)
+{
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0))
+		smu_v14_0_0_get_dpm_ultimate_freq(smu, clk_type, min, max);
+	else if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
+		smu_v14_0_1_get_dpm_ultimate_freq(smu, clk_type, min, max);
+
+	return 0;
+}
+
 static int smu_v14_0_0_get_current_clk_freq(struct smu_context *smu,
 					    enum smu_clk_type clk_type,
 					    uint32_t *value)
@@ -817,6 +1019,37 @@ static int smu_v14_0_0_get_current_clk_freq(struct smu_context *smu,
 	return smu_v14_0_0_get_smu_metrics_data(smu, member_type, value);
 }
 
+static int smu_v14_0_1_get_dpm_level_count(struct smu_context *smu,
+					   enum smu_clk_type clk_type,
+					   uint32_t *count)
+{
+	DpmClocks_t_v14_0_1 *clk_table = smu->smu_table.clocks_table;
+
+	switch (clk_type) {
+	case SMU_SOCCLK:
+		*count = clk_table->NumSocClkLevelsEnabled;
+		break;
+	case SMU_VCLK:
+	case SMU_DCLK:
+		*count = clk_table->Vcn0ClkLevelsEnabled;
+		break;
+	case SMU_VCLK1:
+	case SMU_DCLK1:
+		*count = clk_table->Vcn1ClkLevelsEnabled;
+		break;
+	case SMU_MCLK:
+		*count = clk_table->NumMemPstatesEnabled;
+		break;
+	case SMU_FCLK:
+		*count = clk_table->NumFclkLevelsEnabled;
+		break;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
 static int smu_v14_0_0_get_dpm_level_count(struct smu_context *smu,
 					   enum smu_clk_type clk_type,
 					   uint32_t *count)
@@ -846,6 +1079,18 @@ static int smu_v14_0_0_get_dpm_level_count(struct smu_context *smu,
 	return 0;
 }
 
+static int smu_v14_0_common_get_dpm_level_count(struct smu_context *smu,
+					   enum smu_clk_type clk_type,
+					   uint32_t *count)
+{
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0))
+		smu_v14_0_0_get_dpm_level_count(smu, clk_type, count);
+	else if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
+		smu_v14_0_1_get_dpm_level_count(smu, clk_type, count);
+
+	return 0;
+}
+
 static int smu_v14_0_0_print_clk_levels(struct smu_context *smu,
 					enum smu_clk_type clk_type, char *buf)
 {
@@ -872,18 +1117,20 @@ static int smu_v14_0_0_print_clk_levels(struct smu_context *smu,
 	case SMU_SOCCLK:
 	case SMU_VCLK:
 	case SMU_DCLK:
+	case SMU_VCLK1:
+	case SMU_DCLK1:
 	case SMU_MCLK:
 	case SMU_FCLK:
 		ret = smu_v14_0_0_get_current_clk_freq(smu, clk_type, &cur_value);
 		if (ret)
 			break;
 
-		ret = smu_v14_0_0_get_dpm_level_count(smu, clk_type, &count);
+		ret = smu_v14_0_common_get_dpm_level_count(smu, clk_type, &count);
 		if (ret)
 			break;
 
 		for (i = 0; i < count; i++) {
-			ret = smu_v14_0_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
+			ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, i, &value);
 			if (ret)
 				break;
 
@@ -946,8 +1193,13 @@ static int smu_v14_0_0_set_soft_freq_limited_range(struct smu_context *smu,
 		break;
 	case SMU_VCLK:
 	case SMU_DCLK:
-		msg_set_min = SMU_MSG_SetHardMinVcn;
-		msg_set_max = SMU_MSG_SetSoftMaxVcn;
+		msg_set_min = SMU_MSG_SetHardMinVcn0;
+		msg_set_max = SMU_MSG_SetSoftMaxVcn0;
+		break;
+	case SMU_VCLK1:
+	case SMU_DCLK1:
+		msg_set_min = SMU_MSG_SetHardMinVcn1;
+		msg_set_max = SMU_MSG_SetSoftMaxVcn1;
 		break;
 	default:
 		return -EINVAL;
@@ -977,11 +1229,11 @@ static int smu_v14_0_0_force_clk_levels(struct smu_context *smu,
 	case SMU_FCLK:
 	case SMU_VCLK:
 	case SMU_DCLK:
-		ret = smu_v14_0_0_get_dpm_freq_by_index(smu, clk_type, soft_min_level, &min_freq);
+		ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, soft_min_level, &min_freq);
 		if (ret)
 			break;
 
-		ret = smu_v14_0_0_get_dpm_freq_by_index(smu, clk_type, soft_max_level, &max_freq);
+		ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, soft_max_level, &max_freq);
 		if (ret)
 			break;
 
@@ -1006,25 +1258,25 @@ static int smu_v14_0_0_set_performance_level(struct smu_context *smu,
 
 	switch (level) {
 	case AMD_DPM_FORCED_LEVEL_HIGH:
-		smu_v14_0_0_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &sclk_max);
-		smu_v14_0_0_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &fclk_max);
-		smu_v14_0_0_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &socclk_max);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK, NULL, &sclk_max);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK, NULL, &fclk_max);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK, NULL, &socclk_max);
 		sclk_min = sclk_max;
 		fclk_min = fclk_max;
 		socclk_min = socclk_max;
 		break;
 	case AMD_DPM_FORCED_LEVEL_LOW:
-		smu_v14_0_0_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, NULL);
-		smu_v14_0_0_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min, NULL);
-		smu_v14_0_0_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, NULL);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, NULL);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min, NULL);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, NULL);
 		sclk_max = sclk_min;
 		fclk_max = fclk_min;
 		socclk_max = socclk_min;
 		break;
 	case AMD_DPM_FORCED_LEVEL_AUTO:
-		smu_v14_0_0_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, &sclk_max);
-		smu_v14_0_0_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min, &fclk_max);
-		smu_v14_0_0_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, &socclk_max);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SCLK, &sclk_min, &sclk_max);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_FCLK, &fclk_min, &fclk_max);
+		smu_v14_0_common_get_dpm_ultimate_freq(smu, SMU_SOCCLK, &socclk_min, &socclk_max);
 		break;
 	case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
 	case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
@@ -1073,6 +1325,18 @@ static int smu_v14_0_0_set_performance_level(struct smu_context *smu,
 	return ret;
 }
 
+static int smu_v14_0_1_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
+{
+	DpmClocks_t_v14_0_1 *clk_table = smu->smu_table.clocks_table;
+
+	smu->gfx_default_hard_min_freq = clk_table->MinGfxClk;
+	smu->gfx_default_soft_max_freq = clk_table->MaxGfxClk;
+	smu->gfx_actual_hard_min_freq = 0;
+	smu->gfx_actual_soft_max_freq = 0;
+
+	return 0;
+}
+
 static int smu_v14_0_0_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
 {
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
@@ -1085,6 +1349,16 @@ static int smu_v14_0_0_set_fine_grain_gfx_freq_parameters(struct smu_context *sm
 	return 0;
 }
 
+static int smu_v14_0_common_set_fine_grain_gfx_freq_parameters(struct smu_context *smu)
+{
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0))
+		smu_v14_0_0_set_fine_grain_gfx_freq_parameters(smu);
+	else if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
+		smu_v14_0_1_set_fine_grain_gfx_freq_parameters(smu);
+
+	return 0;
+}
+
 static int smu_v14_0_0_set_vpe_enable(struct smu_context *smu,
 				      bool enable)
 {
@@ -1101,6 +1375,25 @@ static int smu_v14_0_0_set_umsch_mm_enable(struct smu_context *smu,
 					       0, NULL);
 }
 
+static int smu_14_0_1_get_dpm_table(struct smu_context *smu, struct dpm_clocks *clock_table)
+{
+	DpmClocks_t_v14_0_1 *clk_table = smu->smu_table.clocks_table;
+	uint8_t idx;
+
+	/* Only the Clock information of SOC and VPE is copied to provide VPE DPM settings for use. */
+	for (idx = 0; idx < NUM_SOCCLK_DPM_LEVELS; idx++) {
+		clock_table->SocClocks[idx].Freq = (idx < clk_table->NumSocClkLevelsEnabled) ? clk_table->SocClocks[idx]:0;
+		clock_table->SocClocks[idx].Vol = 0;
+	}
+
+	for (idx = 0; idx < NUM_VPE_DPM_LEVELS; idx++) {
+		clock_table->VPEClocks[idx].Freq = (idx < clk_table->VpeClkLevelsEnabled) ? clk_table->VPEClocks[idx]:0;
+		clock_table->VPEClocks[idx].Vol = 0;
+	}
+
+	return 0;
+}
+
 static int smu_14_0_0_get_dpm_table(struct smu_context *smu, struct dpm_clocks *clock_table)
 {
 	DpmClocks_t *clk_table = smu->smu_table.clocks_table;
@@ -1120,6 +1413,16 @@ static int smu_14_0_0_get_dpm_table(struct smu_context *smu, struct dpm_clocks *
 	return 0;
 }
 
+static int smu_v14_0_common_get_dpm_table(struct smu_context *smu, struct dpm_clocks *clock_table)
+{
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 0))
+		smu_14_0_0_get_dpm_table(smu, clock_table);
+	else if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(14, 0, 1))
+		smu_14_0_1_get_dpm_table(smu, clock_table);
+
+	return 0;
+}
+
 static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.check_fw_status = smu_v14_0_check_fw_status,
 	.check_fw_version = smu_v14_0_check_fw_version,
@@ -1141,16 +1444,16 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.set_driver_table_location = smu_v14_0_set_driver_table_location,
 	.gfx_off_control = smu_v14_0_gfx_off_control,
 	.mode2_reset = smu_v14_0_0_mode2_reset,
-	.get_dpm_ultimate_freq = smu_v14_0_0_get_dpm_ultimate_freq,
+	.get_dpm_ultimate_freq = smu_v14_0_common_get_dpm_ultimate_freq,
 	.od_edit_dpm_table = smu_v14_0_od_edit_dpm_table,
 	.print_clk_levels = smu_v14_0_0_print_clk_levels,
 	.force_clk_levels = smu_v14_0_0_force_clk_levels,
 	.set_performance_level = smu_v14_0_0_set_performance_level,
-	.set_fine_grain_gfx_freq_parameters = smu_v14_0_0_set_fine_grain_gfx_freq_parameters,
+	.set_fine_grain_gfx_freq_parameters = smu_v14_0_common_set_fine_grain_gfx_freq_parameters,
 	.set_gfx_power_up_by_imu = smu_v14_0_set_gfx_power_up_by_imu,
 	.dpm_set_vpe_enable = smu_v14_0_0_set_vpe_enable,
 	.dpm_set_umsch_mm_enable = smu_v14_0_0_set_umsch_mm_enable,
-	.get_dpm_clock_table = smu_14_0_0_get_dpm_table,
+	.get_dpm_clock_table = smu_v14_0_common_get_dpm_table,
 };
 
 static void smu_v14_0_0_set_smu_mailbox_registers(struct smu_context *smu)
-- 
2.44.0


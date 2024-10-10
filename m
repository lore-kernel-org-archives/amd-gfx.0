Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23EA0CEDDBE
	for <amd-gfx@archiver.kernel.org>; Thu, 10 Oct 2024 09:37:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A08C10E8AD;
	Thu, 10 Oct 2024 09:37:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nswsd5mf";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA9C410E8AD
 for <amd-gfx@lists.freedesktop.org>; Thu, 10 Oct 2024 09:37:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LwiKcM28656UMyfA+gUyE7HMHJD19BdZcNjnSR02XBBvwy0f9iob2etdo73v6YDILQ7NN1ihga/UmYkBnLm+suvf6VtXuli5c+3agE/CoGrkU6oXDl/hkGqIDfmOIByUY8nqa/DmxGSx1m4rZRF66f5ET3DMhrWz+Us2Err8Mr0Q5vtz4L4GBfLpP5G/v00sO050qZfirw6vU1GAYbESC3MljHonH/gN+PZouSfN5sIH0PxfcFaDQowtDooEsqBML18n2+PKzgj0fVx/uDSPKEEQP3LXSX2yeNcGXM4CrVyztQHthdS/8+BHP9ZDZ45Aayw7gPKv84N/DgAf4/iAXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jg3M2IJIrB0jUG7nt5mBqLC0RooAjmGFt8d6iAO7sl8=;
 b=wT/TTGLaEj1UI2hj02qbUzsWyJUJO7z27cevcDxbwYLzhA7KgrWVWE01YlcTHIOgnTdaPCChWoxkmt70oNAImehe9Tw8OXsHqCQBBijbpyobkbrvqhbIh5GJDiljY0peWQmmznf24FQ7ZRMEKPTUYzx8BP1AaJ6LVq5OkNgrzpywpJ2LLL4dnvVfEEkSKYnAk/0/W74G9WdgIqbOOL0r10LSizjuHGEIm7c67XobzTKoy+dxi/kruSgcE2XvyeJZyBLW9yPfxyZXTmWuaxLZMECRhKodhy0UYhND8qNQLu6lk160P5tAWQ+y/z46F1lDH9ZE07fl2IpbVPVVz2b8rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jg3M2IJIrB0jUG7nt5mBqLC0RooAjmGFt8d6iAO7sl8=;
 b=nswsd5mfqUzlnqC1eAB0BwLv2K0yGS9BJZVYMdFHiJhBpG/qTZZBaJH/8KhVNy024xklFk2cnz9DE139RI3noFj31ttyu6dqNrmbGO96kVLVQBjwqFvCEP6zEyhDojjlJMqBvbygJsrwaaxVYql37ldocATcUkGdPEIf374C4IU=
Received: from BYAPR03CA0023.namprd03.prod.outlook.com (2603:10b6:a02:a8::36)
 by DS7PR12MB6071.namprd12.prod.outlook.com (2603:10b6:8:9d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Thu, 10 Oct
 2024 09:36:57 +0000
Received: from CO1PEPF000044F5.namprd05.prod.outlook.com
 (2603:10b6:a02:a8:cafe::24) by BYAPR03CA0023.outlook.office365.com
 (2603:10b6:a02:a8::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.19 via Frontend
 Transport; Thu, 10 Oct 2024 09:36:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F5.mail.protection.outlook.com (10.167.241.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8048.13 via Frontend Transport; Thu, 10 Oct 2024 09:36:56 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 10 Oct
 2024 04:36:55 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Thu, 10 Oct 2024 04:36:54 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: update the driver-fw interface file for smu
 v14.0.2/3
Date: Thu, 10 Oct 2024 17:36:51 +0800
Message-ID: <20241010093651.2112363-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F5:EE_|DS7PR12MB6071:EE_
X-MS-Office365-Filtering-Correlation-Id: 0c25a058-d491-48ae-c331-08dce90f150c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0CXhhzxK8I77pQZmf3Zpi9TYMWSzpU2ScHZuyZXpK8QOQQkf4gIYi3wGfORI?=
 =?us-ascii?Q?xdDUHWBF4vH6065L5HN80x6g4ezovwe6kwH218PEZkJ1Yoc2S8Gjg2YPwxhR?=
 =?us-ascii?Q?z4BxDlifq2TqYbtl25e9hpGZHCOLFbjekSHkMQGBIlF3v8R+X4Xaxjd3whwG?=
 =?us-ascii?Q?RsU1TFxP+3iesvyZ9egiaZ/NTmV2M7ELkl7NYWL+3uhBG8S4qOk1QG/9fXub?=
 =?us-ascii?Q?WeVJMTrxGTPjYfidfSWf8/H0NkLffh89Gscsjvo/mPr9rEsCKDG3nZiKNLDh?=
 =?us-ascii?Q?5vR7ly2LvChCcGEx6TL/Epj5+IKW7Nlqfh1nIeS1bIq2q1UcN9ngKZYNs0f4?=
 =?us-ascii?Q?gF8F0IuXJSkaqf9qFmS0p5KnkXDLUbCwDCTO83jtjYoqtXXTkeSYsurgM/i+?=
 =?us-ascii?Q?UvuKB0WggiBdWqTj6I/c6sg+TNBmlo4oQUizIurLx81HEzkeBVQ3Il3XbAFM?=
 =?us-ascii?Q?Ju4Q1XZvq8pa0xAXdfVHgg1yET69HU3+SovTy/F0lrhxLGfc8Mvk3qT3r0TY?=
 =?us-ascii?Q?CTBcdTZAXenpdXJG925P2Kw5hr2akdSn9MvO9oTGr9tl56M9k4Y0ysjOJhd9?=
 =?us-ascii?Q?q2cXvOq/XnuI7ysIKJpPZbBInvmOBSCWvL0+sKMYB5+E7KaxJhmcw4u5pXLu?=
 =?us-ascii?Q?N5tnRmbJM5Bw1UGZw+jtpUMm3GD3gfJMm772yKbEOLUtf/l9n8aSHR/zre5v?=
 =?us-ascii?Q?zjyaBt7VNJTObPyh2j5D+Nlkqz6mGgWhOwTafKp1O6qtO4CYIyQrEUsSDjHI?=
 =?us-ascii?Q?MwAoV2GJ10E6cPBXxZ63J81Q6D0HGEhq1fOglBVbYXL04gplpYG09RzclWJR?=
 =?us-ascii?Q?Mlr3GlsyL/UnVsO0RenHVGs1OMaQeoVAcjKZpyBOM0E5DSHKyjRlr7d+/6oY?=
 =?us-ascii?Q?+howDEtqV3eqGv+yK+W+05fmDnhmFpu73CB4fakSBYgDiOHD3z56XcefZFJ/?=
 =?us-ascii?Q?30vUrTc/eoZkMO+IYXgFTBpL8wdaX1ZXocYOwAR/7m4rLCC85EOtFNeAKGJb?=
 =?us-ascii?Q?Wc6X10KJw9a56WKir2YMafiZ3ZuHPv6NwzTDMnflGSsaMHiQRaikEV/rpIfi?=
 =?us-ascii?Q?KcB7dVa44a482QFXNTqa4CykgXNyBGEyY4wdvWviKmFKSd6IVluYhRb29K1E?=
 =?us-ascii?Q?BSZtgkSiEovxW6HsEUIheWGhL6RtAC2CT1bXdJUMgtUAuG26bhIzmsXkN+y8?=
 =?us-ascii?Q?ds8Xg70CIGf5op38EVMeFwL0LERCnXWXMoasAiEzAOhZqDo+D/umzcBlFM2I?=
 =?us-ascii?Q?drWRf5ZxIHZdhW9wvGCXugqSuliezWmj623E9WccMtV+A1znPmCn81mnoll6?=
 =?us-ascii?Q?EzqXZ+uLjc80teNzfoa2t5twEgzdvbBWKMFoeo422/uAB/5UBc3qsess3Gof?=
 =?us-ascii?Q?sUGZGloGJadG2XNVEdKKOQhuf7f9?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 09:36:56.5144 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0c25a058-d491-48ae-c331-08dce90f150c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6071
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

update the driver-fw interface file for smu v14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h | 132 +++++++++++-------
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |   2 +-
 2 files changed, 85 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
index ee457a6f0813..c2fd0a4a13e5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu14_driver_if_v14_0.h
@@ -25,7 +25,7 @@
 #define SMU14_DRIVER_IF_V14_0_H
 
 //Increment this version if SkuTable_t or BoardTable_t change
-#define PPTABLE_VERSION 0x18
+#define PPTABLE_VERSION 0x1B
 
 #define NUM_GFXCLK_DPM_LEVELS    16
 #define NUM_SOCCLK_DPM_LEVELS    8
@@ -145,7 +145,7 @@ typedef enum {
 } FEATURE_BTC_e;
 
 // Debug Overrides Bitmask
-#define DEBUG_OVERRIDE_DISABLE_VOLT_LINK_VCN_FCLK      0x00000001
+#define DEBUG_OVERRIDE_NOT_USE      				   0x00000001
 #define DEBUG_OVERRIDE_DISABLE_VOLT_LINK_DCN_FCLK      0x00000002
 #define DEBUG_OVERRIDE_DISABLE_VOLT_LINK_MP0_FCLK      0x00000004
 #define DEBUG_OVERRIDE_DISABLE_VOLT_LINK_VCN_DCFCLK    0x00000008
@@ -161,6 +161,7 @@ typedef enum {
 #define DEBUG_OVERRIDE_ENABLE_SOC_VF_BRINGUP_MODE      0x00002000
 #define DEBUG_OVERRIDE_ENABLE_PER_WGP_RESIENCY         0x00004000
 #define DEBUG_OVERRIDE_DISABLE_MEMORY_VOLTAGE_SCALING  0x00008000
+#define DEBUG_OVERRIDE_DFLL_BTC_FCW_LOG                0x00010000
 
 // VR Mapping Bit Defines
 #define VR_MAPPING_VR_SELECT_MASK  0x01
@@ -391,6 +392,21 @@ typedef struct {
   EccInfo_t  EccInfo[24];
 } EccInfoTable_t;
 
+#define EPCS_HIGH_POWER                  600
+#define EPCS_NORMAL_POWER                450
+#define EPCS_LOW_POWER                   300
+#define EPCS_SHORTED_POWER               150
+#define EPCS_NO_BOOTUP                   0
+
+typedef enum{
+  EPCS_SHORTED_LIMIT,
+  EPCS_LOW_POWER_LIMIT,
+  EPCS_NORMAL_POWER_LIMIT,
+  EPCS_HIGH_POWER_LIMIT,
+  EPCS_NOT_CONFIGURED,
+  EPCS_STATUS_COUNT,
+} EPCS_STATUS_e;
+
 //D3HOT sequences
 typedef enum {
   BACO_SEQUENCE,
@@ -662,7 +678,7 @@ typedef enum {
 } PP_GRTAVFS_FW_SEP_FUSE_e;
 
 #define PP_NUM_RTAVFS_PWL_ZONES 5
-
+#define PP_NUM_PSM_DIDT_PWL_ZONES 3
 
 // VBIOS or PPLIB configures telemetry slope and offset. Only slope expected to be set for SVI3
 // Slope Q1.7, Offset Q1.2
@@ -746,10 +762,10 @@ typedef struct {
   uint16_t               Padding;
 
   //Frequency changes
-  int16_t                GfxclkFmin;           // MHz
-  int16_t                GfxclkFmax;           // MHz
-  uint16_t               UclkFmin;             // MHz
-  uint16_t               UclkFmax;             // MHz
+  int16_t                GfxclkFoffset;
+  uint16_t               Padding1;
+  uint16_t               UclkFmin;
+  uint16_t               UclkFmax;
   uint16_t               FclkFmin;
   uint16_t               FclkFmax;
 
@@ -770,19 +786,23 @@ typedef struct {
   uint8_t                MaxOpTemp;
 
   uint8_t                AdvancedOdModeEnabled;
-  uint8_t                Padding1[3];
+  uint8_t                Padding2[3];
 
   uint16_t               GfxVoltageFullCtrlMode;
   uint16_t               SocVoltageFullCtrlMode;
   uint16_t               GfxclkFullCtrlMode;
   uint16_t               UclkFullCtrlMode;
   uint16_t               FclkFullCtrlMode;
-  uint16_t               Padding2;
+  uint16_t               Padding3;
 
   int16_t                GfxEdc;
   int16_t                GfxPccLimitControl;
 
-  uint32_t               Spare[10];
+  uint16_t               GfxclkFmaxVmax;
+  uint8_t                GfxclkFmaxVmaxTemperature;
+  uint8_t                Padding4[1];
+
+  uint32_t               Spare[9];
   uint32_t               MmHubPadding[8]; // SMU internal use. Adding here instead of external as a workaround
 } OverDriveTable_t;
 
@@ -802,8 +822,8 @@ typedef struct {
   uint16_t               VddSocVmax;
 
   //gfxclk
-  int16_t                GfxclkFmin;           // MHz
-  int16_t                GfxclkFmax;           // MHz
+  int16_t                GfxclkFoffset;
+  uint16_t               Padding;
   //uclk
   uint16_t               UclkFmin;             // MHz
   uint16_t               UclkFmax;             // MHz
@@ -828,7 +848,7 @@ typedef struct {
   uint8_t                FanZeroRpmEnable;
   //temperature
   uint8_t                MaxOpTemp;
-  uint8_t                Padding[2];
+  uint8_t                Padding1[2];
 
   //Full Ctrl
   uint16_t               GfxVoltageFullCtrlMode;
@@ -839,7 +859,7 @@ typedef struct {
   //EDC
   int16_t                GfxEdc;
   int16_t                GfxPccLimitControl;
-  int16_t                Padding1;
+  int16_t                Padding2;
 
   uint32_t               Spare[5];
 } OverDriveLimits_t;
@@ -987,8 +1007,9 @@ typedef struct {
   uint16_t BaseClockDc;
   uint16_t GameClockDc;
   uint16_t BoostClockDc;
-
-  uint32_t Reserved[4];
+  uint16_t MaxReportedClock;
+  uint16_t Padding;
+  uint32_t Reserved[3];
 } DriverReportedClocks_t;
 
 typedef struct {
@@ -1132,7 +1153,7 @@ typedef struct {
   uint32_t      DcModeMaxFreq     [PPCLK_COUNT            ];     // In MHz
 
   uint16_t      GfxclkAibFmax;
-  uint16_t      GfxclkFreqCap;
+  uint16_t      GfxDpmPadding;
 
   //GFX Idle Power Settings
   uint16_t      GfxclkFgfxoffEntry;   // Entry in RLC stage (PLL), in Mhz
@@ -1172,8 +1193,7 @@ typedef struct {
   uint32_t        DvoFmaxLowScaler; //Unitless float
 
   // GFX DCS
-  uint16_t      DcsGfxOffVoltage;     //Voltage in mV(Q2) applied to VDDGFX when entering DCS GFXOFF phase
-  uint16_t      PaddingDcs;
+  uint32_t      PaddingDcs;
 
   uint16_t      DcsMinGfxOffTime;     //Minimum amount of time PMFW shuts GFX OFF as part of GFX DCS phase
   uint16_t      DcsMaxGfxOffTime;      //Maximum amount of time PMFW can shut GFX OFF as part of GFX DCS phase at a stretch.
@@ -1205,8 +1225,7 @@ typedef struct {
   uint16_t      DalDcModeMaxUclkFreq;
   uint8_t       PaddingsMem[2];
   //FCLK Section
-  uint16_t      FclkDpmDisallowPstateFreq;  //Frequency which FW will target when indicated that display config cannot support P-state. Set to 0 use FW calculated value
-  uint16_t      PaddingFclk;
+  uint32_t      PaddingFclk;
 
   // Link DPM Settings
   uint8_t       PcieGenSpeed[NUM_LINK_LEVELS];           ///< 0:PciE-gen1 1:PciE-gen2 2:PciE-gen3 3:PciE-gen4 4:PciE-gen5
@@ -1215,12 +1234,19 @@ typedef struct {
 
   // SECTION: VDD_GFX AVFS
   uint8_t       OverrideGfxAvfsFuses;
-  uint8_t       GfxAvfsPadding[3];
+  uint8_t       GfxAvfsPadding[1];
+  uint16_t      DroopGBStDev;
 
   uint32_t      SocHwRtAvfsFuses[PP_GRTAVFS_HW_FUSE_COUNT];   //new added for Soc domain
   uint32_t      GfxL2HwRtAvfsFuses[PP_GRTAVFS_HW_FUSE_COUNT]; //see fusedoc for encoding
   //uint32_t      GfxSeHwRtAvfsFuses[PP_GRTAVFS_HW_FUSE_COUNT];
-  uint32_t      spare_HwRtAvfsFuses[PP_GRTAVFS_HW_FUSE_COUNT];
+
+  uint16_t      PsmDidt_Vcross[PP_NUM_PSM_DIDT_PWL_ZONES-1];
+  uint32_t      PsmDidt_StaticDroop_A[PP_NUM_PSM_DIDT_PWL_ZONES];
+  uint32_t      PsmDidt_StaticDroop_B[PP_NUM_PSM_DIDT_PWL_ZONES];
+  uint32_t      PsmDidt_DynDroop_A[PP_NUM_PSM_DIDT_PWL_ZONES];
+  uint32_t      PsmDidt_DynDroop_B[PP_NUM_PSM_DIDT_PWL_ZONES];
+  uint32_t      spare_HwRtAvfsFuses[19];
 
   uint32_t      SocCommonRtAvfs[PP_GRTAVFS_FW_COMMON_FUSE_COUNT];
   uint32_t      GfxCommonRtAvfs[PP_GRTAVFS_FW_COMMON_FUSE_COUNT];
@@ -1246,11 +1272,7 @@ typedef struct {
   uint32_t      dGbV_dT_vmin;
   uint32_t      dGbV_dT_vmax;
 
-  //Unused: PMFW-9370
-  uint32_t      V2F_vmin_range_low;
-  uint32_t      V2F_vmin_range_high;
-  uint32_t      V2F_vmax_range_low;
-  uint32_t      V2F_vmax_range_high;
+  uint32_t      PaddingV2F[4];
 
   AvfsDcBtcParams_t DcBtcGfxParams;
   QuadraticInt_t    SSCurve_GFX;
@@ -1327,18 +1349,18 @@ typedef struct {
   uint16_t        PsmDidtReleaseTimer;
   uint32_t        PsmDidtStallPattern; //Will be written to both pattern 1 and didt_static_level_prog
   // CAC EDC
-  uint32_t        Leakage_C0; // in IEEE float
-  uint32_t        Leakage_C1; // in IEEE float
-  uint32_t        Leakage_C2; // in IEEE float
-  uint32_t        Leakage_C3; // in IEEE float
-  uint32_t        Leakage_C4; // in IEEE float
-  uint32_t        Leakage_C5; // in IEEE float
-  uint32_t        GFX_CLK_SCALAR; // in IEEE float
-  uint32_t        GFX_CLK_INTERCEPT; // in IEEE float
-  uint32_t        GFX_CAC_M; // in IEEE float
-  uint32_t        GFX_CAC_B; // in IEEE float
-  uint32_t        VDD_GFX_CurrentLimitGuardband; // in IEEE float
-  uint32_t        DynToTotalCacScalar; // in IEEE
+  uint32_t        CacEdcCacLeakageC0;
+  uint32_t        CacEdcCacLeakageC1;
+  uint32_t        CacEdcCacLeakageC2;
+  uint32_t        CacEdcCacLeakageC3;
+  uint32_t        CacEdcCacLeakageC4;
+  uint32_t        CacEdcCacLeakageC5;
+  uint32_t        CacEdcGfxClkScalar;
+  uint32_t        CacEdcGfxClkIntercept;
+  uint32_t        CacEdcCac_m;
+  uint32_t        CacEdcCac_b;
+  uint32_t        CacEdcCurrLimitGuardband;
+  uint32_t        CacEdcDynToTotalCacRatio;
   // GFX EDC XVMIN
   uint32_t        XVmin_Gfx_EdcThreshScalar;
   uint32_t        XVmin_Gfx_EdcEnableFreq;
@@ -1467,7 +1489,7 @@ typedef struct {
   uint8_t      VddqOffEnabled;
   uint8_t      PaddingUmcFlags[2];
 
-  uint32_t    PostVoltageSetBacoDelay; // in microseconds. Amount of time FW will wait after power good is established or PSI0 command is issued
+  uint32_t    Paddign1;
   uint32_t    BacoEntryDelay; // in milliseconds. Amount of time FW will wait to trigger BACO entry after receiving entry notification from OS
 
   uint8_t     FuseWritePowerMuxPresent;
@@ -1530,7 +1552,7 @@ typedef struct {
   int16_t     FuzzyFan_ErrorSetDelta;
   int16_t     FuzzyFan_ErrorRateSetDelta;
   int16_t     FuzzyFan_PwmSetDelta;
-  uint16_t    FuzzyFan_Reserved;
+  uint16_t    FanPadding2;
 
   uint16_t    FwCtfLimit[TEMP_COUNT];
 
@@ -1547,9 +1569,10 @@ typedef struct {
   uint16_t    FanSpare[1];
   uint8_t     FanIntakeSensorSupport;
   uint8_t     FanIntakePadding;
-  uint32_t    FanAmbientPerfBoostThreshold;
   uint32_t    FanSpare2[12];
 
+  uint32_t ODFeatureCtrlMask;
+
   uint16_t TemperatureLimit_Hynix; // In degrees Celsius. Memory temperature limit associated with Hynix
   uint16_t TemperatureLimit_Micron; // In degrees Celsius. Memory temperature limit associated with Micron
   uint16_t TemperatureFwCtfLimit_Hynix;
@@ -1637,7 +1660,7 @@ typedef struct {
   uint16_t AverageDclk0Frequency  ;
   uint16_t AverageVclk1Frequency  ;
   uint16_t AverageDclk1Frequency  ;
-  uint16_t PCIeBusy               ;
+  uint16_t AveragePCIeBusy        ;
   uint16_t dGPU_W_MAX             ;
   uint16_t padding                ;
 
@@ -1665,12 +1688,12 @@ typedef struct {
 
   uint16_t AverageGfxActivity    ;
   uint16_t AverageUclkActivity   ;
-  uint16_t Vcn0ActivityPercentage  ;
+  uint16_t AverageVcn0ActivityPercentage;
   uint16_t Vcn1ActivityPercentage  ;
 
   uint32_t EnergyAccumulator;
   uint16_t AverageSocketPower;
-  uint16_t MovingAverageTotalBoardPower;
+  uint16_t AverageTotalBoardPower;
 
   uint16_t AvgTemperature[TEMP_COUNT];
   uint16_t AvgTemperatureFanIntake;
@@ -1684,7 +1707,8 @@ typedef struct {
 
 
   uint8_t  ThrottlingPercentage[THROTTLER_COUNT];
-  uint8_t  padding1[3];
+  uint8_t  VmaxThrottlingPercentage;
+  uint8_t  padding1[2];
 
   //metrics for D3hot entry/exit and driver ARM msgs
   uint32_t D3HotEntryCountPerMode[D3HOT_SEQUENCE_COUNT];
@@ -1693,7 +1717,7 @@ typedef struct {
 
   uint16_t ApuSTAPMSmartShiftLimit;
   uint16_t ApuSTAPMLimit;
-  uint16_t MovingAvgApuSocketPower;
+  uint16_t AvgApuSocketPower;
 
   uint16_t AverageUclkActivity_MAX;
 
@@ -1823,6 +1847,17 @@ typedef struct {
 #define TABLE_TRANSFER_FAILED     0xFF
 #define TABLE_TRANSFER_PENDING    0xAB
 
+#define TABLE_PPT_FAILED                          0x100
+#define TABLE_TDC_FAILED                          0x200
+#define TABLE_TEMP_FAILED                         0x400
+#define TABLE_FAN_TARGET_TEMP_FAILED              0x800
+#define TABLE_FAN_STOP_TEMP_FAILED               0x1000
+#define TABLE_FAN_START_TEMP_FAILED              0x2000
+#define TABLE_FAN_PWM_MIN_FAILED                 0x4000
+#define TABLE_ACOUSTIC_TARGET_RPM_FAILED         0x8000
+#define TABLE_ACOUSTIC_LIMIT_RPM_FAILED         0x10000
+#define TABLE_MGPU_ACOUSTIC_TARGET_RPM_FAILED   0x20000
+
 // Table types
 #define TABLE_PPTABLE            0
 #define TABLE_COMBO_PPTABLE           1
@@ -1849,5 +1884,6 @@ typedef struct {
 #define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
 #define IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
 #define IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
+#define IH_INTERRUPT_CONTEXT_ID_DYNAMIC_TABLE       0xA
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
index 46b456590a08..727d5b405435 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -28,7 +28,7 @@
 #define SMU14_DRIVER_IF_VERSION_INV 0xFFFFFFFF
 #define SMU14_DRIVER_IF_VERSION_SMU_V14_0_0 0x7
 #define SMU14_DRIVER_IF_VERSION_SMU_V14_0_1 0x6
-#define SMU14_DRIVER_IF_VERSION_SMU_V14_0_2 0x26
+#define SMU14_DRIVER_IF_VERSION_SMU_V14_0_2 0x2E
 
 #define FEATURE_MASK(feature) (1ULL << feature)
 
-- 
2.34.1


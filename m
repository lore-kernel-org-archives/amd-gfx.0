Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF074C4332F
	for <amd-gfx@archiver.kernel.org>; Mon, 21 Nov 2022 01:43:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DE5E10E0D9;
	Mon, 21 Nov 2022 01:43:40 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 139CA10E0D0
 for <amd-gfx@lists.freedesktop.org>; Mon, 21 Nov 2022 01:43:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XSsOhimuBf2gHv+rAjpvCyIrJSIv8lBpPfIEcO156aqazvSDnKpJk84iy+5NnPvTuQU3CZRj9jQ02WA+zVR2qPUW+eOcMHa8Oupk7A/GNEiRiOH9OGnpzuAe7Thsd6D49JPg++YD0l+LUkXBzY/nfM0u2Ddq+njjbh9knK5oYx7cRxaxGfjCmUbXE3ktryyePcL/uIceE/KrU6IsFARE6KFHQ28KtVEBiyuGm/EbE/ymmrHH5ujObSC7uRrqnzrHX80A5ns9rymSx492FN6MQKSXuD63ucnP3ijkASdxou6uodUwCSGVyMud3Y3hj8jr1DZzOI9wfHKm7AFVFm+qXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uIyS1MwA9fTlhLvaDe6r1L6inwvzPmmutHn4hVMJMI=;
 b=cO0aHKDEh3KuCRSMCw1nIQZ+pj8dZwGTAAOq+vvro8DMm8LecThPatZNiGcp8meJTJ98FXe/B6GpJ4TQjsTLZubYarlg4CwfsTTYoP19PnYLJgGehKISBY6sfGk1e1+H14bMg5B/NMSC4J8rYyYxVzbqQudIJqZWkaltGCkg4gIYHgM9NBxcgSKy3apbVbJXhsYKdGLDLxvTc/he6nt6dLCX51xI1cnurXgR6fI+MSegPtk9VeOcc64zRtg10KK5xlsnCuIThZkrk4XkZdztwDr46CqDZ5wjToJCUnspuZBlui/4LlrosWsBrhNdgzLIrQOx0Tgb/GXa6mTaI3kUOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uIyS1MwA9fTlhLvaDe6r1L6inwvzPmmutHn4hVMJMI=;
 b=xPr/I4updoFcgj1ueOZyilPYNPwIl3lw55xh5neVp25a3l04ZDwSediiqJYbgo871+2xgIEb2M4lCqnxCdlYsoumOZs/7YHz4uKTkk+9xhKXwUYzCRNe+2TXovq+EqhDWph1xyv+Cm06cou6vOyDICMauxjpNwAGS42whzg1vFE=
Received: from DM6PR03CA0043.namprd03.prod.outlook.com (2603:10b6:5:100::20)
 by DM6PR12MB4497.namprd12.prod.outlook.com (2603:10b6:5:2a5::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15; Mon, 21 Nov
 2022 01:43:32 +0000
Received: from DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:100:cafe::4e) by DM6PR03CA0043.outlook.office365.com
 (2603:10b6:5:100::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.15 via Frontend
 Transport; Mon, 21 Nov 2022 01:43:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT090.mail.protection.outlook.com (10.13.172.184) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5834.8 via Frontend Transport; Mon, 21 Nov 2022 01:43:32 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 20 Nov
 2022 19:43:31 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 20 Nov
 2022 19:43:00 -0600
Received: from lyndon-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Sun, 20 Nov 2022 19:42:59 -0600
From: lyndonli <Lyndon.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: update driver if header for smu_13_0_7
Date: Mon, 21 Nov 2022 09:42:53 +0800
Message-ID: <20221121014253.2101022-1-Lyndon.Li@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT090:EE_|DM6PR12MB4497:EE_
X-MS-Office365-Filtering-Correlation-Id: 19be67ee-7e87-4bcc-fcb2-08dacb61cc1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dM13kTitVvalSIblFfiZKVCCvLd75LqMPBlV7J+jc7zZpFkb3VYHl/mQ62j/Q7aRygkDxX4BW7hi1HEyngO9PyvmT3Z0L5rLxo4CqIqFV7M9rQ7e99hDQkuRyTeGlyrQyNJ0A4mdCMY+czEd2Qzhmwfpydg1HT/DUwjhknkprV2FoU+JdMIze2V1CtTBAS8rAPj5B2dVv6vnUUe/h2vIyUcCsHjTwIu+vLOQAO+JeVBfdHYos4EiqHrlsin06//N3PPomRkf540MuOyCfOWtviDItybMx5y81ZiM31eKmpxBOqqCkJQ5MKcilnwlo8TKAV4EzPq9eEwRPmSf38lWb+XZDTPIbPzB0MVXlzKHf2gvzv1ibmIrRo+U4cRJxy3dR4jrS2ibs3SKQ85z0NA1GKWbIlg3eBAzuypn5bQMKZIPz2lG2/XAxv8NKpA6FiZ+jtUfxaNX45fv+0cPshis1NdBoxbh8yLACZccN8cZZWKLTIoYwoUWweOHvJBD/Yrf1UHcAebBueMHKoRuxqyFHttkWUU4M33BVuLYvrF8UIqgu7xB5hDJQmWk0N+m7goVRkRVNUfKrpler5ovGBiQUNVqAG9f6Zd5luaq5d2vQtjdGlM/GH3KGT7h4rIUrba+1yfK2ZEKaLE1F0KYMPH0aWUjfUOFThex9heFEvkj4rZUM15hJCobJLVn1ztlGDINmsl732OqeJoys22mqv0i8oBqNwNtb8Ebi913TqGhkhRWfInqxwIcaJeQinhX5XaPW1liTRH2SN92b3FVUt1pTA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(396003)(136003)(39860400002)(346002)(376002)(451199015)(40470700004)(36840700001)(46966006)(36756003)(86362001)(36860700001)(40460700003)(40480700001)(5660300002)(2906002)(15650500001)(1076003)(2616005)(186003)(426003)(47076005)(26005)(7696005)(81166007)(336012)(82740400003)(356005)(83380400001)(54906003)(6916009)(82310400005)(70586007)(41300700001)(478600001)(70206006)(19627235002)(316002)(8936002)(8676002)(6666004)(4326008)(43062005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2022 01:43:32.2217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 19be67ee-7e87-4bcc-fcb2-08dacb61cc1b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT090.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4497
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
Cc: feifei.xu@amd.com, enneth.feng@amd.com, evan.quan@amd.com,
 lyndonli <Lyndon.Li@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

update driver if header for smu_13_0_7

Signed-off-by: lyndonli <Lyndon.Li@amd.com>
---
 .../inc/pmfw_if/smu13_driver_if_v13_0_7.h     | 117 ++++++++++++------
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |   2 +-
 2 files changed, 81 insertions(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
index 25c08f963f49..efb270cee1e0 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
@@ -25,10 +25,10 @@
 
 // *** IMPORTANT ***
 // PMFW TEAM: Always increment the interface version on any change to this file
-#define SMU13_DRIVER_IF_VERSION  0x2C
+#define SMU13_DRIVER_IF_VERSION  0x35
 
 //Increment this version if SkuTable_t or BoardTable_t change
-#define PPTABLE_VERSION 0x20
+#define PPTABLE_VERSION 0x27
 
 #define NUM_GFXCLK_DPM_LEVELS    16
 #define NUM_SOCCLK_DPM_LEVELS    8
@@ -96,7 +96,7 @@
 #define FEATURE_MEM_TEMP_READ_BIT             47
 #define FEATURE_ATHUB_MMHUB_PG_BIT            48
 #define FEATURE_SOC_PCC_BIT                   49
-#define FEATURE_SPARE_50_BIT                  50
+#define FEATURE_EDC_PWRBRK_BIT                50
 #define FEATURE_SPARE_51_BIT                  51
 #define FEATURE_SPARE_52_BIT                  52
 #define FEATURE_SPARE_53_BIT                  53
@@ -282,15 +282,15 @@ typedef enum {
 } I2cControllerPort_e;
 
 typedef enum {
-  I2C_CONTROLLER_NAME_VR_GFX = 0,
-  I2C_CONTROLLER_NAME_VR_SOC,
-  I2C_CONTROLLER_NAME_VR_VMEMP,
-  I2C_CONTROLLER_NAME_VR_VDDIO,
-  I2C_CONTROLLER_NAME_LIQUID0,
-  I2C_CONTROLLER_NAME_LIQUID1,
-  I2C_CONTROLLER_NAME_PLX,
-  I2C_CONTROLLER_NAME_OTHER,
-  I2C_CONTROLLER_NAME_COUNT,
+	I2C_CONTROLLER_NAME_VR_GFX = 0,
+	I2C_CONTROLLER_NAME_VR_SOC,
+	I2C_CONTROLLER_NAME_VR_VMEMP,
+	I2C_CONTROLLER_NAME_VR_VDDIO,
+	I2C_CONTROLLER_NAME_LIQUID0,
+	I2C_CONTROLLER_NAME_LIQUID1,
+	I2C_CONTROLLER_NAME_PLX,
+	I2C_CONTROLLER_NAME_FAN_INTAKE,
+	I2C_CONTROLLER_NAME_COUNT,
 } I2cControllerName_e;
 
 typedef enum {
@@ -302,6 +302,7 @@ typedef enum {
   I2C_CONTROLLER_THROTTLER_LIQUID0,
   I2C_CONTROLLER_THROTTLER_LIQUID1,
   I2C_CONTROLLER_THROTTLER_PLX,
+  I2C_CONTROLLER_THROTTLER_FAN_INTAKE,
   I2C_CONTROLLER_THROTTLER_INA3221,
   I2C_CONTROLLER_THROTTLER_COUNT,
 } I2cControllerThrottler_e;
@@ -309,8 +310,9 @@ typedef enum {
 typedef enum {
   I2C_CONTROLLER_PROTOCOL_VR_XPDE132G5,
   I2C_CONTROLLER_PROTOCOL_VR_IR35217,
-  I2C_CONTROLLER_PROTOCOL_TMP_TMP102A,
+  I2C_CONTROLLER_PROTOCOL_TMP_MAX31875,
   I2C_CONTROLLER_PROTOCOL_INA3221,
+  I2C_CONTROLLER_PROTOCOL_TMP_MAX6604,
   I2C_CONTROLLER_PROTOCOL_COUNT,
 } I2cControllerProtocol_e;
 
@@ -690,6 +692,9 @@ typedef struct {
 #define PP_OD_FEATURE_UCLK_BIT      8
 #define PP_OD_FEATURE_ZERO_FAN_BIT      9
 #define PP_OD_FEATURE_TEMPERATURE_BIT 10
+#define PP_OD_FEATURE_POWER_FEATURE_CTRL_BIT 11
+#define PP_OD_FEATURE_ASIC_TDC_BIT 12
+#define PP_OD_FEATURE_COUNT 13
 
 typedef enum {
   PP_OD_POWER_FEATURE_ALWAYS_ENABLED,
@@ -697,6 +702,11 @@ typedef enum {
   PP_OD_POWER_FEATURE_ALWAYS_DISABLED,
 } PP_OD_POWER_FEATURE_e;
 
+typedef enum {
+  FAN_MODE_AUTO = 0,
+  FAN_MODE_MANUAL_LINEAR,
+} FanMode_e;
+
 typedef struct {
   uint32_t FeatureCtrlMask;
 
@@ -708,8 +718,8 @@ typedef struct {
   uint8_t                RuntimePwrSavingFeaturesCtrl;
 
   //Frequency changes
-  int16_t               GfxclkFmin;           // MHz
-  int16_t               GfxclkFmax;           // MHz
+  int16_t                GfxclkFmin;           // MHz
+  int16_t                GfxclkFmax;           // MHz
   uint16_t               UclkFmin;             // MHz
   uint16_t               UclkFmax;             // MHz
 
@@ -730,7 +740,12 @@ typedef struct {
   uint8_t                MaxOpTemp;
   uint8_t                Padding[4];
 
-  uint32_t               Spare[12];
+  uint16_t               GfxVoltageFullCtrlMode;
+  uint16_t               GfxclkFullCtrlMode;
+  uint16_t               UclkFullCtrlMode;
+  int16_t                AsicTdc;
+
+  uint32_t               Spare[10];
   uint32_t               MmHubPadding[8]; // SMU internal use. Adding here instead of external as a workaround
 } OverDriveTable_t;
 
@@ -748,8 +763,8 @@ typedef struct {
   uint8_t                IdlePwrSavingFeaturesCtrl;
   uint8_t                RuntimePwrSavingFeaturesCtrl;
 
-  uint16_t               GfxclkFmin;           // MHz
-  uint16_t               GfxclkFmax;           // MHz
+  int16_t                GfxclkFmin;           // MHz
+  int16_t                GfxclkFmax;           // MHz
   uint16_t               UclkFmin;             // MHz
   uint16_t               UclkFmax;             // MHz
 
@@ -769,7 +784,12 @@ typedef struct {
   uint8_t                MaxOpTemp;
   uint8_t                Padding[4];
 
-  uint32_t               Spare[12];
+  uint16_t               GfxVoltageFullCtrlMode;
+  uint16_t               GfxclkFullCtrlMode;
+  uint16_t               UclkFullCtrlMode;
+  int16_t                AsicTdc;
+
+  uint32_t               Spare[10];
 
 } OverDriveLimits_t;
 
@@ -903,7 +923,8 @@ typedef struct {
   uint16_t  FanStartTempMin;
   uint16_t  FanStartTempMax;
 
-  uint32_t Spare[12];
+  uint16_t  PowerMinPpt0[POWER_SOURCE_COUNT];
+  uint32_t  Spare[11];
 
 } MsgLimits_t;
 
@@ -1086,11 +1107,13 @@ typedef struct {
   uint32_t        GfxoffSpare[15];
 
   // GFX GPO
-  float           DfllBtcMasterScalerM;
+  uint32_t        DfllBtcMasterScalerM;
   int32_t         DfllBtcMasterScalerB;
-  float           DfllBtcSlaveScalerM;
+  uint32_t        DfllBtcSlaveScalerM;
   int32_t         DfllBtcSlaveScalerB;
-  uint32_t        GfxGpoSpare[12];
+  uint32_t        DfllPccAsWaitCtrl; //GDFLL_AS_WAIT_CTRL_PCC register value to be passed to RLC msg
+  uint32_t        DfllPccAsStepCtrl; //GDFLL_AS_STEP_CTRL_PCC register value to be passed to RLC msg
+  uint32_t        GfxGpoSpare[10];
 
   // GFX DCS
 
@@ -1106,7 +1129,10 @@ typedef struct {
   uint16_t        DcsTimeout;           //This is the amount of time SMU FW waits for RLC to put GFX into GFXOFF before reverting to the fallback mechanism of throttling GFXCLK to Fmin.
 
 
-  uint32_t        DcsSpare[16];
+  uint32_t        DcsSpare[14];
+
+  // UCLK section
+  uint16_t     ShadowFreqTableUclk[NUM_UCLK_DPM_LEVELS];     // In MHz
 
   // UCLK section
   uint8_t      UseStrobeModeOptimizations; //Set to indicate that FW should use strobe mode optimizations
@@ -1163,13 +1189,14 @@ typedef struct {
   uint16_t IntakeTempHighIntakeAcousticLimit;
   uint16_t IntakeTempAcouticLimitReleaseRate;
 
-  uint16_t FanStalledTempLimitOffset;
+  int16_t FanAbnormalTempLimitOffset;
   uint16_t FanStalledTriggerRpm;
-  uint16_t FanAbnormalTriggerRpm;
-  uint16_t FanPadding;
-
-  uint32_t     FanSpare[14];
+  uint16_t FanAbnormalTriggerRpmCoeff;
+  uint16_t FanAbnormalDetectionEnable;
 
+  uint8_t      FanIntakeSensorSupport;
+  uint8_t      FanIntakePadding[3];
+  uint32_t     FanSpare[13];
   // SECTION: VDD_GFX AVFS
 
   uint8_t      OverrideGfxAvfsFuses;
@@ -1238,8 +1265,22 @@ typedef struct {
   // SECTION: Advanced Options
   uint32_t          DebugOverrides;
 
+  // Section: Total Board Power idle vs active coefficients
+  uint8_t     TotalBoardPowerSupport;
+  uint8_t     TotalBoardPowerPadding[3];
+
+  int16_t     TotalIdleBoardPowerM;
+  int16_t     TotalIdleBoardPowerB;
+  int16_t     TotalBoardPowerM;
+  int16_t     TotalBoardPowerB;
+
+  //PMFW-11158
+  QuadraticInt_t qFeffCoeffGameClock[POWER_SOURCE_COUNT];
+  QuadraticInt_t qFeffCoeffBaseClock[POWER_SOURCE_COUNT];
+  QuadraticInt_t qFeffCoeffBoostClock[POWER_SOURCE_COUNT];
+
   // SECTION: Sku Reserved
-  uint32_t         Spare[64];
+  uint32_t         Spare[43];
 
   // Padding for MMHUB - do not modify this
   uint32_t     MmHubPadding[8];
@@ -1304,7 +1345,8 @@ typedef struct {
   // SECTION: Clock Spread Spectrum
 
   // UCLK Spread Spectrum
-  uint16_t     UclkSpreadPadding;
+  uint8_t      UclkTrainingModeSpreadPercent; // Q4.4
+  uint8_t      UclkSpreadPadding;
   uint16_t     UclkSpreadFreq;      // kHz
 
   // UCLK Spread Spectrum
@@ -1317,11 +1359,7 @@ typedef struct {
 
   // Section: Memory Config
   uint8_t      DramWidth; // Width of interface to the channel for each DRAM module. See DRAM_BIT_WIDTH_TYPE_e
-  uint8_t      PaddingMem1[3];
-
-  // Section: Total Board Power
-  uint16_t     TotalBoardPower;     //Only needed for TCP Estimated case, where TCP = TGP+Total Board Power
-  uint16_t     BoardPowerPadding;
+  uint8_t      PaddingMem1[7];
 
   // SECTION: UMC feature flags
   uint8_t      HsrEnabled;
@@ -1423,8 +1461,11 @@ typedef struct {
   uint16_t Vcn1ActivityPercentage  ;
 
   uint32_t EnergyAccumulator;
-  uint16_t AverageSocketPower    ;
+  uint16_t AverageSocketPower;
+  uint16_t AverageTotalBoardPower;
+
   uint16_t AvgTemperature[TEMP_COUNT];
+  uint16_t AvgTemperatureFanIntake;
 
   uint8_t  PcieRate               ;
   uint8_t  PcieWidth              ;
@@ -1592,5 +1633,7 @@ typedef struct {
 #define IH_INTERRUPT_CONTEXT_ID_AUDIO_D0            0x5
 #define IH_INTERRUPT_CONTEXT_ID_AUDIO_D3            0x6
 #define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
+#define IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
+#define IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index b7f4569aff2a..865d6358918d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -31,7 +31,7 @@
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x07
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_10 0x32
-#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x2C
+#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x35
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_10 0x1D
 
 #define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
-- 
2.25.1


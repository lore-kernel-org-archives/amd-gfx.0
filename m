Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2068BC433FE
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Oct 2022 07:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A63B810E9FC;
	Fri, 14 Oct 2022 07:28:30 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2042.outbound.protection.outlook.com [40.107.94.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9F0310EA92
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Oct 2022 07:28:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C9GxFcpxYR0LA0Oaoy/Howgr1KWb4lfKQ9cleKtLjYZ5kFt/NoGe1vylJecJMRgUmRNbrAwgI+TShcE2vpN9ujtHN+HcHrp/vgeCFxf1Wej1D5E0qpj5xDnjcv+BXD7CATb2l9QIZYYTiIdnSmAOp/jAk5iZs5y3fQo7brAXdwyfeJX2DDjl+rvXVlxfptBM8YlhNciNHh4JDxTOa6DPZfz4M4gbJA80HsHCy0RAgWeUMci8Bl15VBvGaiH7ijhK7Wq148/LbQjuQTWNwZkX+JWoIaxV9btOAqEq7OF/VuKiLX6NUfJAwdx/VOYscwQ8zpH5acrwMPiyErMYsKB0WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KagaMgYw2wwqbfIhjuACij6xYuA/bAfz8woJFlyVMlg=;
 b=DCac/7H7xM2mtj5WMP5aJcnwBQoPDK0hBBBHvCotKfNBFzIhL+H1BU0hELJ/fkYwH7N/yXNHm2v7rVwXkB4qCqxjBB82JJc0dDnURl7nlu8CZdTHDrz3Qi7DK41pRKrnrKeCERjBlw//V61zuJwOOQ6LjBamvB22CsTCB19TRJUZhO6eKMGDZJVv8QgnibC2NnxqC1j5ARubGl+ywWv9yUQ+THz2OCWZR6d8ezh6wToG2YroZ9eOhItfmfz0XjqsqMKZSOniE0Isk+PCf6eF0zbt2KZoI9+nWX3j4XyYtTbsdpD5tX7p9KOGR0nW1VUEuN4c/EUZn+lwv1gZFdq8JA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KagaMgYw2wwqbfIhjuACij6xYuA/bAfz8woJFlyVMlg=;
 b=rachXz0h5WIiELrfihXxCcJWL6q2xZX7En3kfJhOGcnIQxuGRHWMQgR3FjeaAYqnIecpwMBtX1c03xKjqtQ/rQ9J3ZIxnw1ZzU9GkYtg105/K2NIDvJK0EZ6TygNgJ8orN/jm+FHnxa5gfRi1ZE+MZqlCo/jBEgb9ec8m6yTrp8=
Received: from MW4PR03CA0267.namprd03.prod.outlook.com (2603:10b6:303:b4::32)
 by PH7PR12MB6954.namprd12.prod.outlook.com (2603:10b6:510:1b7::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Fri, 14 Oct
 2022 07:28:24 +0000
Received: from CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b4:cafe::5b) by MW4PR03CA0267.outlook.office365.com
 (2603:10b6:303:b4::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.26 via Frontend
 Transport; Fri, 14 Oct 2022 07:28:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT088.mail.protection.outlook.com (10.13.175.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5723.20 via Frontend Transport; Fri, 14 Oct 2022 07:28:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 14 Oct
 2022 02:28:19 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 14 Oct
 2022 02:28:11 -0500
Received: from kenneth-u2004-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 14 Oct 2022 02:28:10 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: update driver-if header for smu_v13_0_10
Date: Fri, 14 Oct 2022 15:28:07 +0800
Message-ID: <20221014072808.3712546-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT088:EE_|PH7PR12MB6954:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ecdefe0-7759-4da8-7bfb-08daadb5ad8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ImIcEch7E9pCJ6+BnbPcm5UZqD/is/oRDXtMcy3zs7ghKcunXceOJttkEADg9JQN3zO2wjQmID6cgvRPNFy4sgYACouDRCwdKVFoPX7fAV4XI8TZ7LO42xXiPmK1y0b8BWA5cCJ5Xk5fhtLT2XK8ombAw+EkYAc69+0SwHfkcPnY6ThOaw9PAtzE4H8JtpautYxIJiphfBN87qzjQ1NrtBfWkfXrlilUOAiT8A3dafS8Foc0RthkQ0ue89FRfhiv1G0/VLfTNPsaUJsLtbF0rkLdbZc2/bw88c8oexEihLVc8vnauDQTXZIb6eXFToFOIInDcwEqbSwKeQnGPi9Ft7S8jogAz0bbUqNvS4XTwgAA+RBPe+JlQ1OvlVWDTxIUO4DaeMKEmLMqIRIMy5byZPxPFCbIYBN+Z4vmC5gBfsPMt5RySARYzulCLjpmXSb+F2t3Ev4Dr4pjAJWGxznu8sO6mfBeah8Td9XAamlk7AVnXGZz/JsEcCx/457ipeKldn0Mwd25o1gI8kEc35rk6jkN0TGydHNWIt3/AMy7ohQPi09yclV1FQF17pdnPHGzCfyoQkYfsiM31J8+1EWbGHN02T+IDUWHfRo/1xDdHQWQKaqXn3gOwNvdVSKOSoEuP0L8vDjfSrp6jveWREb/wjPc+NdgtYgTN94k6/sRCjQVOrMe+K0/gVi9KkEjji3cUzfaqk0zgdJx71uJKfI7SbVVpvNplAQvDsGtOTQMYKsG7LBPrPFscEgMdluNNacwGGaW/VQdKkJJJP6tIEljif3Ah3240s1V9Wqr0tMrY0UJTT/MEH+cB+ryDQhutbl
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(376002)(396003)(136003)(39860400002)(346002)(451199015)(36840700001)(46966006)(40470700004)(1076003)(186003)(15650500001)(478600001)(2906002)(2616005)(36860700001)(7696005)(41300700001)(8676002)(26005)(316002)(70206006)(6666004)(40480700001)(86362001)(40460700003)(81166007)(70586007)(82310400005)(356005)(44832011)(4326008)(82740400003)(6916009)(8936002)(36756003)(5660300002)(47076005)(426003)(83380400001)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2022 07:28:23.7109 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ecdefe0-7759-4da8-7bfb-08daadb5ad8e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT088.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6954
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
Cc: Kenneth Feng <kenneth.feng@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

update driver-if header for smu_v13_0_10 and merge with smu_v13_0_0

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../inc/pmfw_if/smu13_driver_if_v13_0_0.h     | 87 +++++++++++++++----
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  3 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  6 +-
 3 files changed, 72 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
index 063f4a737605..9a0d899fd73f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
@@ -25,7 +25,7 @@
 #define SMU13_DRIVER_IF_V13_0_0_H
 
 //Increment this version if SkuTable_t or BoardTable_t change
-#define PPTABLE_VERSION 0x24
+#define PPTABLE_VERSION 0x26
 
 #define NUM_GFXCLK_DPM_LEVELS    16
 #define NUM_SOCCLK_DPM_LEVELS    8
@@ -109,6 +109,22 @@
 #define FEATURE_SPARE_63_BIT                  63
 #define NUM_FEATURES                          64
 
+#define ALLOWED_FEATURE_CTRL_DEFAULT 0xFFFFFFFFFFFFFFFFULL
+#define ALLOWED_FEATURE_CTRL_SCPM        (1 << FEATURE_DPM_GFXCLK_BIT) | \
+                                         (1 << FEATURE_DPM_GFX_POWER_OPTIMIZER_BIT) | \
+                                         (1 << FEATURE_DPM_UCLK_BIT) | \
+                                         (1 << FEATURE_DPM_FCLK_BIT) | \
+                                         (1 << FEATURE_DPM_SOCCLK_BIT) | \
+                                         (1 << FEATURE_DPM_MP0CLK_BIT) | \
+                                         (1 << FEATURE_DPM_LINK_BIT) | \
+                                         (1 << FEATURE_DPM_DCN_BIT) | \
+                                         (1 << FEATURE_DS_GFXCLK_BIT) | \
+                                         (1 << FEATURE_DS_SOCCLK_BIT) | \
+                                         (1 << FEATURE_DS_FCLK_BIT) | \
+                                         (1 << FEATURE_DS_LCLK_BIT) | \
+                                         (1 << FEATURE_DS_DCFCLK_BIT) | \
+                                         (1 << FEATURE_DS_UCLK_BIT)
+
 //For use with feature control messages
 typedef enum {
   FEATURE_PWR_ALL,
@@ -133,6 +149,7 @@ typedef enum {
 #define DEBUG_OVERRIDE_DISABLE_DFLL                    0x00000200
 #define DEBUG_OVERRIDE_ENABLE_RLC_VF_BRINGUP_MODE      0x00000400
 #define DEBUG_OVERRIDE_DFLL_MASTER_MODE                0x00000800
+#define DEBUG_OVERRIDE_ENABLE_PROFILING_MODE           0x00001000
 
 // VR Mapping Bit Defines
 #define VR_MAPPING_VR_SELECT_MASK  0x01
@@ -269,7 +286,7 @@ typedef enum {
   I2C_CONTROLLER_NAME_LIQUID0,
   I2C_CONTROLLER_NAME_LIQUID1,
   I2C_CONTROLLER_NAME_PLX,
-  I2C_CONTROLLER_NAME_OTHER,
+  I2C_CONTROLLER_NAME_FAN_INTAKE,
   I2C_CONTROLLER_NAME_COUNT,
 } I2cControllerName_e;
 
@@ -282,6 +299,7 @@ typedef enum {
   I2C_CONTROLLER_THROTTLER_LIQUID0,
   I2C_CONTROLLER_THROTTLER_LIQUID1,
   I2C_CONTROLLER_THROTTLER_PLX,
+  I2C_CONTROLLER_THROTTLER_FAN_INTAKE,
   I2C_CONTROLLER_THROTTLER_INA3221,
   I2C_CONTROLLER_THROTTLER_COUNT,
 } I2cControllerThrottler_e;
@@ -289,7 +307,7 @@ typedef enum {
 typedef enum {
   I2C_CONTROLLER_PROTOCOL_VR_XPDE132G5,
   I2C_CONTROLLER_PROTOCOL_VR_IR35217,
-  I2C_CONTROLLER_PROTOCOL_TMP_TMP102A,
+  I2C_CONTROLLER_PROTOCOL_TMP_MAX31875,
   I2C_CONTROLLER_PROTOCOL_INA3221,
   I2C_CONTROLLER_PROTOCOL_COUNT,
 } I2cControllerProtocol_e;
@@ -658,13 +676,20 @@ typedef struct {
 
 #define PP_NUM_OD_VF_CURVE_POINTS PP_NUM_RTAVFS_PWL_ZONES + 1
 
+typedef enum {
+  FAN_MODE_AUTO = 0,
+  FAN_MODE_MANUAL_LINEAR,
+} FanMode_e;
 
 typedef struct {
   uint32_t FeatureCtrlMask;
 
   //Voltage control
   int16_t                VoltageOffsetPerZoneBoundary[PP_NUM_OD_VF_CURVE_POINTS];
-  uint16_t               reserved[2];
+  uint16_t               VddGfxVmax;         // in mV
+
+  uint8_t                IdlePwrSavingFeaturesCtrl;
+  uint8_t                RuntimePwrSavingFeaturesCtrl;
 
   //Frequency changes
   int16_t                GfxclkFmin;           // MHz
@@ -674,7 +699,7 @@ typedef struct {
 
   //PPT
   int16_t                Ppt;         // %
-  int16_t                reserved1;
+  int16_t                Tdc;
 
   //Fan control
   uint8_t                FanLinearPwmPoints[NUM_OD_FAN_MAX_POINTS];
@@ -701,16 +726,19 @@ typedef struct {
   uint32_t FeatureCtrlMask;
 
   int16_t VoltageOffsetPerZoneBoundary;
-  uint16_t               reserved[2];
+  uint16_t               VddGfxVmax;         // in mV
+
+  uint8_t                IdlePwrSavingFeaturesCtrl;
+  uint8_t                RuntimePwrSavingFeaturesCtrl;
 
-  uint16_t               GfxclkFmin;           // MHz
-  uint16_t               GfxclkFmax;           // MHz
+  int16_t               GfxclkFmin;           // MHz
+  int16_t               GfxclkFmax;           // MHz
   uint16_t               UclkFmin;             // MHz
   uint16_t               UclkFmax;             // MHz
 
   //PPT
   int16_t                Ppt;         // %
-  int16_t                reserved1;
+  int16_t                Tdc;
 
   uint8_t                FanLinearPwmPoints;
   uint8_t                FanLinearTempPoints;
@@ -857,7 +885,8 @@ typedef struct {
   uint16_t  FanStartTempMin;
   uint16_t  FanStartTempMax;
 
-  uint32_t Spare[12];
+  uint16_t  PowerMinPpt0[POWER_SOURCE_COUNT];
+  uint32_t Spare[11];
 
 } MsgLimits_t;
 
@@ -1041,7 +1070,17 @@ typedef struct {
   uint32_t        GfxoffSpare[15];
 
   // GFX GPO
-  uint32_t        GfxGpoSpare[16];
+  uint32_t        DfllBtcMasterScalerM;
+  int32_t         DfllBtcMasterScalerB;
+  uint32_t        DfllBtcSlaveScalerM;
+  int32_t         DfllBtcSlaveScalerB;
+
+  uint32_t        DfllPccAsWaitCtrl; //GDFLL_AS_WAIT_CTRL_PCC register value to be passed to RLC msg
+  uint32_t        DfllPccAsStepCtrl; //GDFLL_AS_STEP_CTRL_PCC register value to be passed to RLC msg
+
+  uint32_t        DfllL2FrequencyBoostM; //Unitless (float)
+  uint32_t        DfllL2FrequencyBoostB; //In MHz (integer)
+  uint32_t        GfxGpoSpare[8];
 
   // GFX DCS
 
@@ -1114,12 +1153,14 @@ typedef struct {
   uint16_t IntakeTempHighIntakeAcousticLimit;
   uint16_t IntakeTempAcouticLimitReleaseRate;
 
-  uint16_t FanStalledTempLimitOffset;
+  int16_t FanAbnormalTempLimitOffset;
   uint16_t FanStalledTriggerRpm;
-  uint16_t FanAbnormalTriggerRpm;
-  uint16_t FanPadding;
+  uint16_t FanAbnormalTriggerRpmCoeff;
+  uint16_t FanAbnormalDetectionEnable;
 
-  uint32_t     FanSpare[14];
+  uint8_t      FanIntakeSensorSupport;
+  uint8_t      FanIntakePadding[3];
+  uint32_t     FanSpare[13];
 
   // SECTION: VDD_GFX AVFS
 
@@ -1198,8 +1239,13 @@ typedef struct {
   int16_t     TotalBoardPowerM;
   int16_t     TotalBoardPowerB;
 
+  //PMFW-11158
+  QuadraticInt_t qFeffCoeffGameClock[POWER_SOURCE_COUNT];
+  QuadraticInt_t qFeffCoeffBaseClock[POWER_SOURCE_COUNT];
+  QuadraticInt_t qFeffCoeffBoostClock[POWER_SOURCE_COUNT];
+
   // SECTION: Sku Reserved
-  uint32_t         Spare[61];
+  uint32_t         Spare[43];
 
   // Padding for MMHUB - do not modify this
   uint32_t     MmHubPadding[8];
@@ -1288,8 +1334,11 @@ typedef struct {
   uint32_t    PostVoltageSetBacoDelay; // in microseconds. Amount of time FW will wait after power good is established or PSI0 command is issued
   uint32_t    BacoEntryDelay; // in milliseconds. Amount of time FW will wait to trigger BACO entry after receiving entry notification from OS
 
+  uint8_t     FuseWritePowerMuxPresent;
+  uint8_t     FuseWritePadding[3];
+
   // SECTION: Board Reserved
-  uint32_t     BoardSpare[64];
+  uint32_t     BoardSpare[63];
 
   // SECTION: Structure Padding
 
@@ -1381,7 +1430,7 @@ typedef struct {
   uint16_t AverageTotalBoardPower;
 
   uint16_t AvgTemperature[TEMP_COUNT];
-  uint16_t TempPadding;
+  uint16_t AvgTemperatureFanIntake;
 
   uint8_t  PcieRate               ;
   uint8_t  PcieWidth              ;
@@ -1550,5 +1599,7 @@ typedef struct {
 #define IH_INTERRUPT_CONTEXT_ID_AUDIO_D0            0x5
 #define IH_INTERRUPT_CONTEXT_ID_AUDIO_D3            0x6
 #define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
+#define IH_INTERRUPT_CONTEXT_ID_FAN_ABNORMAL        0x8
+#define IH_INTERRUPT_CONTEXT_ID_FAN_RECOVERY        0x9
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 9d62ea2af132..b9fa5db97504 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -30,9 +30,8 @@
 #define SMU13_DRIVER_IF_VERSION_ALDE 0x08
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x05
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
-#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x30
+#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_10 0x32
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x2C
-#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_10 0x1D
 
 #define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index b8a825ba30ac..b7b59e04a44f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -289,7 +289,8 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_ALDE;
 		break;
 	case IP_VERSION(13, 0, 0):
-		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_SMU_V13_0_0;
+	case IP_VERSION(13, 0, 10):
+		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_SMU_V13_0_0_10;
 		break;
 	case IP_VERSION(13, 0, 7):
 		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_SMU_V13_0_7;
@@ -305,9 +306,6 @@ int smu_v13_0_check_fw_version(struct smu_context *smu)
 	case IP_VERSION(13, 0, 5):
 		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_SMU_V13_0_5;
 		break;
-	case IP_VERSION(13, 0, 10):
-		smu->smc_driver_if_version = SMU13_DRIVER_IF_VERSION_SMU_V13_0_10;
-		break;
 	default:
 		dev_err(adev->dev, "smu unsupported IP version: 0x%x.\n",
 			adev->ip_versions[MP1_HWIP][0]);
-- 
2.25.1


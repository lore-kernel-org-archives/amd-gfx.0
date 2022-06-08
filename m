Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C56C43334
	for <amd-gfx@archiver.kernel.org>; Wed,  8 Jun 2022 09:05:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32E5110E19C;
	Wed,  8 Jun 2022 09:05:59 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34AB910E10A
 for <amd-gfx@lists.freedesktop.org>; Wed,  8 Jun 2022 09:05:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lxXxD4pt8wlkkSajRYvESAW7XM5BkwycU+uAcwvJhOO3xHqBGCXtopARnaHPsYQJ3cNIAx0m5AMK8ymrJGbVUmdtJmYJqC5dLA6iHxk6H5GU9hMDGs2yFQdMlD/gSwzqzkWurXB+i3U+KCaoA1t/vB/aZqZHmVEMMayjWDOmpco3MOme1UF2Zyg8zOhlg+zEcoTfevljhplw3c8ivILr/jqa7DXSytOswJxu9wO0qJDgNZCZgg0U3fhnc/24t25lhzfBofPiCU88pxCBFGWnyGUKPttS4PXDTQXfWiIp4t2t/CAwdMgmwYp522kQI9cwqaHE3aGKz2Xw+BQhgjW9lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IHEp/w4w/IXeGgoau/KiNlURAdWajAUMnic5P5cDm6I=;
 b=fpiUslh+SEIIHhi1YRyksHHmVbFCPm0t0qeocboGEHV/kmyqK4IKL/Bht9HTUlWQbSd76jIWckLIeCMpbtY4kOSjtfIFYYuRITZ2GvAe9Tqw5VLC7wsuOVSJwtmKcXSbW/gOEhk/G7jChLqTFHIvxBW0UqK2JK5Ng7ILUofOPaNMB++RfpdjVgeLWKky/4mz08IzMNwQI66X2FVCxL1wpwxSqIUuvCLsOd+8TP7lJ/3oiyJazh35xC6d6ijmGt8nfCz3jG0Uq3WgEPzJNEnNYvEJRMHzWJWvxtnnWgASiprepicq+OETVkC1LyNmWyKnk8/gwkS+V+8sFU2GPLRHxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IHEp/w4w/IXeGgoau/KiNlURAdWajAUMnic5P5cDm6I=;
 b=FD+dC3Ai5buSf3WsxiZIcDjjJwmHBe3yjsHjI7JoaZgrcXTc3NZ7XR4JDtJz701P/iKstcVhhH8WGZY75t+t/KaFsAzroCxB2EJu87yJZHYT4nrIxgClCmgvFLhehr7agUGKN7TxmM3dMX1yVpvdG0yBcYSvM/oG6XFESRHeS+I=
Received: from DM6PR07CA0090.namprd07.prod.outlook.com (2603:10b6:5:337::23)
 by BL1PR12MB5361.namprd12.prod.outlook.com (2603:10b6:208:31f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 09:05:56 +0000
Received: from DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::f1) by DM6PR07CA0090.outlook.office365.com
 (2603:10b6:5:337::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.17 via Frontend
 Transport; Wed, 8 Jun 2022 09:05:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT031.mail.protection.outlook.com (10.13.172.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Wed, 8 Jun 2022 09:05:55 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 8 Jun
 2022 04:05:53 -0500
Received: from kenneth-u2004-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Wed, 8 Jun 2022 04:05:52 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 3/5] drm/amd/pm: update the driver if header for smu_v13_0_7
Date: Wed, 8 Jun 2022 17:05:34 +0800
Message-ID: <20220608090536.1969621-3-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220608090536.1969621-1-kenneth.feng@amd.com>
References: <20220608090536.1969621-1-kenneth.feng@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 670acbc1-bb69-4915-a8b6-08da492e18b7
X-MS-TrafficTypeDiagnostic: BL1PR12MB5361:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB536137CCAFB2CADEDB892B1E8EA49@BL1PR12MB5361.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Yng/zDUgahuMtBKr9+fEd/wsq7h0HUc+sq+C5UQOOYOCCx6WZB+IM9BI0wb5P2/smFebrMiHbeq4BMwceHMPzYckB+O6kFtFGpDVuPJ8TrqolpiQKa9lls7uUIX68icS/hW+R2SMgJkUdwlCuD9XNkAFWY5N5bqNa1sxv79a4rywcScpFZC6CcRFGUzS+cOVPUr2W3NHN5agZLnb6DSNadfvC0clUGFMfY1IFChxNxCjklVKz58Hm5zvhhZaMHk5UMKYZzN4CscIqAX0pRexBfi8oeYgIozY9ddYLNbapZy8MDT/Lu1DF2ZnCKV/usuhkgatezY5pvmkVu6TV/GELioY57MRHEr6g17P+6zDGNlGwBcFQQu56w45N0mByixhilUWKxZaMyUwcfUbJeVjj2ePnSHUN98ipTi9EXrEfdRDAkyRhF2XY0Nb7dXtJTg1ZLWi/iji9N64cNmYgmf9zgQT8kNc2Cq3Ilu49nb3ShuJMatPatmcWP7jAHiHfX81iGrWGktL8rwO+3ANujUiF4TBmAFK9lBOcHjswLfjw5BJBu4Wr0zKUj3za00HTk91c5oVmvCJZUKGHvPsvFyw+uBduQryMSX1dIr1L/xnn701pmbS44YHzs9vI31Y9X57XKkCMXSdzFD25FURZDgVVQnREkrcdF/wNhiFE54Yi+QG4bPN92sLhEzPfHh/9EGbXG37vQVq+loynZ/sd0AMmA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(47076005)(36756003)(82310400005)(508600001)(15650500001)(81166007)(7696005)(6666004)(2906002)(83380400001)(19627235002)(40460700003)(316002)(8676002)(426003)(26005)(336012)(36860700001)(356005)(8936002)(6916009)(44832011)(5660300002)(70586007)(4326008)(70206006)(2616005)(86362001)(186003)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 09:05:55.7265 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 670acbc1-bb69-4915-a8b6-08da492e18b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5361
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

update the driver if header for smu_v13_0_7

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../inc/pmfw_if/smu13_driver_if_v13_0_7.h     | 62 +++++++++++++------
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  2 +-
 2 files changed, 45 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
index d99b4b47d49d..132da684e379 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
@@ -25,10 +25,10 @@
 
 // *** IMPORTANT ***
 // PMFW TEAM: Always increment the interface version on any change to this file
-#define SMU13_DRIVER_IF_VERSION  0x28
+#define SMU13_DRIVER_IF_VERSION  0x2A
 
 //Increment this version if SkuTable_t or BoardTable_t change
-#define PPTABLE_VERSION 0x1D
+#define PPTABLE_VERSION 0x1E
 
 #define NUM_GFXCLK_DPM_LEVELS    16
 #define NUM_SOCCLK_DPM_LEVELS    8
@@ -112,6 +112,22 @@
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
@@ -662,7 +678,7 @@ typedef struct {
 #define PP_NUM_OD_VF_CURVE_POINTS PP_NUM_RTAVFS_PWL_ZONES + 1
 
 
-#define PP_OD_FEATURE_VF_CURVE_BIT  0
+#define PP_OD_FEATURE_GFX_VF_CURVE_BIT  0
 #define PP_OD_FEATURE_VMAX_BIT      1
 #define PP_OD_FEATURE_PPT_BIT       2
 #define PP_OD_FEATURE_FAN_CURVE_BIT 3
@@ -671,6 +687,8 @@ typedef struct {
 #define PP_OD_FEATURE_TDC_BIT      6
 #define PP_OD_FEATURE_GFXCLK_BIT      7
 #define PP_OD_FEATURE_UCLK_BIT      8
+#define PP_OD_FEATURE_ZERO_FAN_BIT      9
+#define PP_OD_FEATURE_TEMPERATURE_BIT 10
 
 typedef enum {
   PP_OD_POWER_FEATURE_ALWAYS_ENABLED,
@@ -689,8 +707,8 @@ typedef struct {
   uint8_t                RuntimePwrSavingFeaturesCtrl;
 
   //Frequency changes
-  uint16_t               GfxclkFmin;           // MHz
-  uint16_t               GfxclkFmax;           // MHz
+  int16_t               GfxclkFmin;           // MHz
+  int16_t               GfxclkFmax;           // MHz
   uint16_t               UclkFmin;             // MHz
   uint16_t               UclkFmax;             // MHz
 
@@ -701,17 +719,17 @@ typedef struct {
   //Fan control
   uint8_t                FanLinearPwmPoints[NUM_OD_FAN_MAX_POINTS];
   uint8_t                FanLinearTempPoints[NUM_OD_FAN_MAX_POINTS];
-  uint16_t               FanMaximumRpm;
   uint16_t               FanMinimumPwm;
-  uint16_t               FanAcousticLimitRpm;
+  uint16_t               AcousticTargetRpmThreshold;
+  uint16_t               AcousticLimitRpmThreshold;
   uint16_t               FanTargetTemperature; // Degree Celcius
   uint8_t                FanZeroRpmEnable;
   uint8_t                FanZeroRpmStopTemp;
   uint8_t                FanMode;
-  uint8_t                Padding[1];
-
+  uint8_t                MaxOpTemp;
+  uint8_t                Padding[4];
 
-  uint32_t               Spare[13];
+  uint32_t               Spare[12];
   uint32_t               MmHubPadding[8]; // SMU internal use. Adding here instead of external as a workaround
 } OverDriveTable_t;
 
@@ -740,17 +758,17 @@ typedef struct {
 
   uint8_t                FanLinearPwmPoints;
   uint8_t                FanLinearTempPoints;
-  uint16_t               FanMaximumRpm;
   uint16_t               FanMinimumPwm;
-  uint16_t               FanAcousticLimitRpm;
+  uint16_t               AcousticTargetRpmThreshold;
+  uint16_t               AcousticLimitRpmThreshold;
   uint16_t               FanTargetTemperature; // Degree Celcius
   uint8_t                FanZeroRpmEnable;
   uint8_t                FanZeroRpmStopTemp;
   uint8_t                FanMode;
-  uint8_t                Padding[1];
+  uint8_t                MaxOpTemp;
+  uint8_t                Padding[4];
 
-
-  uint32_t               Spare[13];
+  uint32_t               Spare[12];
 
 } OverDriveLimits_t;
 
@@ -1018,7 +1036,8 @@ typedef struct {
   uint16_t SocketPowerLimitAcTau[PPT_THROTTLER_COUNT]; // Time constant of LPF in ms
   uint16_t SocketPowerLimitDcTau[PPT_THROTTLER_COUNT]; // Time constant of LPF in ms
 
-  uint32_t       SpareVmin[12];
+  QuadraticInt_t Vmin_droop;
+  uint32_t       SpareVmin[9];
 
 
   //SECTION: DPM Configuration 1
@@ -1307,7 +1326,6 @@ typedef struct {
   uint32_t    PostVoltageSetBacoDelay; // in microseconds. Amount of time FW will wait after power good is established or PSI0 command is issued
   uint32_t    BacoEntryDelay; // in milliseconds. Amount of time FW will wait to trigger BACO entry after receiving entry notification from OS
 
-
   // SECTION: Board Reserved
   uint32_t     BoardSpare[64];
 
@@ -1382,8 +1400,14 @@ typedef struct {
   uint16_t AverageDclk0Frequency  ;
   uint16_t AverageVclk1Frequency  ;
   uint16_t AverageDclk1Frequency  ;
+  uint16_t PCIeBusy               ;
+  uint16_t dGPU_W_MAX             ;
+  uint16_t padding                ;
+
+  uint32_t MetricsCounter         ;
 
   uint16_t AvgVoltage[SVI_PLANE_COUNT];
+  uint16_t AvgCurrent[SVI_PLANE_COUNT];
 
   uint16_t AverageGfxActivity    ;
   uint16_t AverageUclkActivity   ;
@@ -1415,11 +1439,13 @@ typedef struct {
 
   uint16_t AverageUclkActivity_MAX;
 
+  uint32_t PublicSerialNumberLower;
+  uint32_t PublicSerialNumberUpper;
 } SmuMetrics_t;
 
 typedef struct {
   SmuMetrics_t SmuMetrics;
-  uint32_t Spare[32];
+  uint32_t Spare[30];
 
   // Padding - ignore
   uint32_t     MmHubPadding[8]; // SMU internal use
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index a11d36db1b8a..e3454a876cac 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -31,7 +31,7 @@
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x04
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x29
-#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x28
+#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x2A
 
 #define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
 
-- 
2.25.1


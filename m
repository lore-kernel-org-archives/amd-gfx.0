Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3A9C7EE24
	for <amd-gfx@archiver.kernel.org>; Mon,  5 Jun 2023 03:18:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0DA610E11A;
	Mon,  5 Jun 2023 03:18:56 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D41AA10E11A
 for <amd-gfx@lists.freedesktop.org>; Mon,  5 Jun 2023 03:18:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hhK04y/vDPkaOVwNWsCvNMCaXCuP6PqCt6vW58Mb0rJxjiZHx+m2A0kvj8r6ZMDTt9AxCQxun3RHs0BzLAGvpvrZxVvr8bITSEtDu5rHcmZlZvJ+ddToqocb+ViCCkyviDgW+yxTZ0hTUVcF2J9UGKTM9h0LHxQB0n++WbzgQg6w99oc1svgxLW2EXTdkByGb211kEYWZ6b5U+zQImbGXlxgn/wUa8F7S7EaVc8+BNP8a4KtBJK6PVP6RvYkB8cSWtp1x6r1cscqeP6vc3LFKaHAZWwc/zkzHGVcc5/NfGjN8r8ajUTR7Cq+Rqv0Slwr3MA5/YfhXKufGXWInp5DLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JbzxgjMgxM50uA3JHX94RUJHkGCaku0HlWpX8mxGt54=;
 b=YN6+2aDHUb1xMKyCUxKmwRO2p7HwS/a9/bOv0t7xhH57MtYz4VNlOKOdTjX3pky2BgewFc5lEEPp0Z9HDDUcAM4rtLR0cfX7CWcuInhK91iOv06wrJbBpxW/QwM+WVAAF061GiSzHO06b984dHr4bCUTQn7BvGQznkwiNHsHxK7wWZv6AybpWm6UNbLlIUsUPiM6i+83SXsGCndgKRbXZ1O044Xyz1yiSxumqhviZ27VmcWkjuWpXdhnMYURFKgjxT0ixitei3+Q89AK5P/4+ilRr2lJLEDfi8KpE8DH1EDTmXeDEZPxihZp+yXlCezVfeMa5wH2qQ+SORQpi5b1Mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JbzxgjMgxM50uA3JHX94RUJHkGCaku0HlWpX8mxGt54=;
 b=A5SUYmywfZzyiqQ5OJk5XKSdBft/gmZ2EI0qCDKgt/vfsO+aw5+Sp2M81H5A9dO5XuhCz8Ia1rt/VjZ68n8ufQu79whxBMyLlHquJ0A7EIcIwv6FbxkwruCuAUTu/aEcs9jGG+ZIeF0cVPE4S+4a7F+88IvTcJfo5hsQv8sboXw=
Received: from DS7PR05CA0068.namprd05.prod.outlook.com (2603:10b6:8:57::20) by
 CH2PR12MB4890.namprd12.prod.outlook.com (2603:10b6:610:63::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.27; Mon, 5 Jun 2023 03:18:51 +0000
Received: from DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
 (2603:10b6:8:57:cafe::a6) by DS7PR05CA0068.outlook.office365.com
 (2603:10b6:8:57::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.18 via Frontend
 Transport; Mon, 5 Jun 2023 03:18:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT098.mail.protection.outlook.com (10.13.173.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.32 via Frontend Transport; Mon, 5 Jun 2023 03:18:51 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Sun, 4 Jun
 2023 22:18:50 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via
 Frontend Transport; Sun, 4 Jun 2023 22:18:50 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: update smu-driver if header for smu 13.0.0 and
 smu 13.0.10
Date: Mon, 5 Jun 2023 11:18:42 +0800
Message-ID: <20230605031842.3441796-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT098:EE_|CH2PR12MB4890:EE_
X-MS-Office365-Filtering-Correlation-Id: c004a778-e4cd-49dd-b932-08db657395d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1SkiOpoKsrKrYFPLf/iTPrs5O9zqBXKcHH3c/2nhi/A2oKJ4UayG1qdFcsjIWWteEhtkKpWnC9bsUiD1+nScinUz5u9EVRzg60L9op6Uk+shokDqP3fhXF7EXYz72ZyRaymT4hubgDrXYNCgD4Kk7hWwEcVLfPBpJ3mBAB99PmH2HnWpb0LpzX4HA2KfjWOeK1Ug8rrUx4LdF7E0PDcjL1PX4B4+AMuLKj6FucTVltr1sdyHkM2QfIbtguI1qr6tha4eLnXi/yW54wexD451R3R/Zq533uRCk5wkcOLyzC4hkmqpv9CzF05130whEVYigyqxiOnICsynVeosdW+RN/j3mTAeOkCclODWtIGBbSy/uatAZqbOxBfcLVOLNnDBk4++ZkOgA2yD0gewWVZELVSGkJREN1z4HRtlk4m7Msp8UDvyrL27LaSsjI+vjh+fCTVS2B0wqxUdVB0yE4biEoZkQ9W6HmaL08RP7TZxdD0Z8rSGMhAN2yj09robxc6QXubcpZ5IVd0wV30cqTrZMIpZEOPANpCUzHXTdn4A4GoQY8CRTxLw5bzIdcIFc6C2d1JvdCvWbIwCworK1vCpmR73jWgiypLnoKHS2dYdl8sfEQuF3XSunXw4poLnKSrKYqgLJWqtFgc3KqwNQqMVZqqJQZA838hBWEQBx/uIN1hGj03KArLB5C+zBXewBzEJLUsHon4DJ4GyLIEFPo9jxQqWGymezapgCeQUplL/ISn3QPUOSgZptPZoSvwgcEnN5UC3PMx8KttQwhAkS4YYXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(396003)(376002)(39860400002)(136003)(346002)(451199021)(36840700001)(46966006)(40470700004)(2906002)(70206006)(70586007)(5660300002)(8676002)(8936002)(4326008)(44832011)(316002)(41300700001)(6916009)(15650500001)(7696005)(40480700001)(186003)(2616005)(426003)(336012)(83380400001)(26005)(1076003)(47076005)(36860700001)(86362001)(40460700003)(356005)(82740400003)(6666004)(478600001)(36756003)(82310400005)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2023 03:18:51.1313 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c004a778-e4cd-49dd-b932-08db657395d1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT098.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4890
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

update smu-driver if header for smu 13.0.0 and smu 13.0.10

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
Change-Id: I540aaa99fac2216f2d1a28fd79c68dd77a495f8b
---
 .../inc/pmfw_if/smu13_driver_if_v13_0_0.h     | 33 ++++++++++++++-----
 1 file changed, 25 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
index fe995651c6f5..ba56bc676310 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
@@ -24,10 +24,10 @@
 #ifndef SMU13_DRIVER_IF_V13_0_0_H
 #define SMU13_DRIVER_IF_V13_0_0_H
 
-#define SMU13_0_0_DRIVER_IF_VERSION 0x32
+#define SMU13_0_0_DRIVER_IF_VERSION 0x3D
 
 //Increment this version if SkuTable_t or BoardTable_t change
-#define PPTABLE_VERSION 0x26
+#define PPTABLE_VERSION 0x2B
 
 #define NUM_GFXCLK_DPM_LEVELS    16
 #define NUM_SOCCLK_DPM_LEVELS    8
@@ -96,7 +96,7 @@
 #define FEATURE_ATHUB_MMHUB_PG_BIT            48
 #define FEATURE_SOC_PCC_BIT                   49
 #define FEATURE_EDC_PWRBRK_BIT                50
-#define FEATURE_SPARE_51_BIT                  51
+#define FEATURE_BOMXCO_SVI3_PROG_BIT          51
 #define FEATURE_SPARE_52_BIT                  52
 #define FEATURE_SPARE_53_BIT                  53
 #define FEATURE_SPARE_54_BIT                  54
@@ -312,6 +312,7 @@ typedef enum {
 	I2C_CONTROLLER_PROTOCOL_VR_IR35217,
 	I2C_CONTROLLER_PROTOCOL_TMP_MAX31875,
 	I2C_CONTROLLER_PROTOCOL_INA3221,
+	I2C_CONTROLLER_PROTOCOL_TMP_MAX6604,
 	I2C_CONTROLLER_PROTOCOL_COUNT,
 } I2cControllerProtocol_e;
 
@@ -570,6 +571,7 @@ typedef enum {
 } POWER_SOURCE_e;
 
 typedef enum {
+  MEM_VENDOR_PLACEHOLDER0,
   MEM_VENDOR_SAMSUNG,
   MEM_VENDOR_INFINEON,
   MEM_VENDOR_ELPIDA,
@@ -579,7 +581,6 @@ typedef enum {
   MEM_VENDOR_MOSEL,
   MEM_VENDOR_WINBOND,
   MEM_VENDOR_ESMT,
-  MEM_VENDOR_PLACEHOLDER0,
   MEM_VENDOR_PLACEHOLDER1,
   MEM_VENDOR_PLACEHOLDER2,
   MEM_VENDOR_PLACEHOLDER3,
@@ -808,6 +809,9 @@ typedef enum {
 
 #define INVALID_BOARD_GPIO 0xFF
 
+#define MARKETING_BASE_CLOCKS         0
+#define MARKETING_GAME_CLOCKS         1
+#define MARKETING_BOOST_CLOCKS        2
 
 typedef struct {
   //PLL 0
@@ -1098,10 +1102,15 @@ typedef struct {
   uint16_t        DcsExitHysteresis;    //The min amount of time power credit accumulator should have a value > 0 before SMU exits the DCS throttling phase.
   uint16_t        DcsTimeout;           //This is the amount of time SMU FW waits for RLC to put GFX into GFXOFF before reverting to the fallback mechanism of throttling GFXCLK to Fmin.
 
+  uint8_t         FoptEnabled;
+  uint8_t         DcsSpare2[3];
+  uint32_t        DcsFoptM;             //Tuning paramters to shift Fopt calculation, used in T19 and Navi32
+  uint32_t        DcsFoptB;             //Tuning paramters to shift Fopt calculation, used in T19 and Navi32
 
-  uint32_t        DcsSpare[16];
+  uint32_t        DcsSpare[11];
 
   // UCLK section
+  uint16_t     ShadowFreqTableUclk     [NUM_UCLK_DPM_LEVELS];     // In MHz
   uint8_t      UseStrobeModeOptimizations; //Set to indicate that FW should use strobe mode optimizations
   uint8_t      PaddingMem[3];
 
@@ -1247,8 +1256,13 @@ typedef struct {
   QuadraticInt_t qFeffCoeffBaseClock[POWER_SOURCE_COUNT];
   QuadraticInt_t qFeffCoeffBoostClock[POWER_SOURCE_COUNT];
 
+  uint16_t TemperatureLimit_Hynix; // In degrees Celsius. Memory temperature limit associated with Hynix
+  uint16_t TemperatureLimit_Micron; // In degrees Celsius. Memory temperature limit associated with Micron
+  uint16_t TemperatureFwCtfLimit_Hynix;
+  uint16_t TemperatureFwCtfLimit_Micron;
+
   // SECTION: Sku Reserved
-  uint32_t         Spare[43];
+  uint32_t         Spare[41];
 
   // Padding for MMHUB - do not modify this
   uint32_t     MmHubPadding[8];
@@ -1320,8 +1334,9 @@ typedef struct {
   // UCLK Spread Spectrum
   uint8_t      UclkSpreadPercent[MEM_VENDOR_COUNT];
 
+  uint8_t      GfxclkSpreadEnable;
+
   // FCLK Spread Spectrum
-  uint8_t      FclkSpreadPadding;
   uint8_t      FclkSpreadPercent;   // Q4.4
   uint16_t     FclkSpreadFreq;      // kHz
 
@@ -1446,6 +1461,8 @@ typedef struct {
 
 
   uint8_t ThrottlingPercentage[THROTTLER_COUNT];
+  uint8_t VmaxThrottlingPercentage;
+  uint8_t Padding1[3];
 
   //metrics for D3hot entry/exit and driver ARM msgs
   uint32_t D3HotEntryCountPerMode[D3HOT_SEQUENCE_COUNT];
@@ -1465,7 +1482,7 @@ typedef struct {
 
 typedef struct {
   SmuMetrics_t SmuMetrics;
-  uint32_t Spare[30];
+  uint32_t Spare[29];
 
   // Padding - ignore
   uint32_t     MmHubPadding[8]; // SMU internal use
-- 
2.34.1


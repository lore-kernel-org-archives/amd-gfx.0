Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D48CAC77B73
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 01:59:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A596710E204;
	Thu,  1 Jun 2023 01:59:38 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on20613.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe59::613])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00E5410E1FE
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 01:59:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GDy+skGtDby+QAEtWdNzzOJzOYHt7peGlb0a2Xo5JK9fkjqtgYyVv/d2hZtWvDBRb6FEjRd/V94CYBpgNTs6/iMS2rkDW611ujGXtX+duJsFWDL/nLN7nAqJ4cloawRLEPJSWOD3I7qqvSKwBQNX0rxWmnnGdnnWPSEj8nxSM53/bqlthyauBDK87xvdgpZrY/BVdk9kJ/8i1OpCWmSI2cx3E2mAQlc7ozrSj0aU2RBQrBT8U5kiNj0KVncHJPt2yP3sFN6znVymsIfc8FDZIE15hyKxBc2+svBOLwdtWIP7jpxQOpD0N4FjLoQP0uFhsfrid5lc3BNIfYsLDMilkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bCGvJy98mpGfEOQPeQFqqcDYtYWEkm71jc6WcTaWXL8=;
 b=TA1Cfygo42bfjlf9fngAFuDTxpPeXc00NI0zXQ3XDJAP+v7UPznADI0lIy/gWvux2fdPwy4m1CF70tI7Uf2TMrnoiEgcbu1TR04svyft7tKUPFMPA3iDzt3KGQSdkclGmLzala5z8WTpx9gCliJhSqoLgARgFIWIkPUQQLJ8yyvDI7da/buIrLXEMqxqBe0687h/xHGxJb41pHwa1eC4PviCw4Rd2Qj1M6muTKE884DWfbWDU+5kV5UWBE9flOLyd7LE+lNaz7nINSFA1chJgvULCW1wCMKM9f7IpFGee115FAoWMXNsvYM5S03khtMUhifTU23r1G4yHK++fOjWbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bCGvJy98mpGfEOQPeQFqqcDYtYWEkm71jc6WcTaWXL8=;
 b=bpyXh4pbTUIDQxWpcbiq02EpMeI/jRIxl07ijyxZicTVOrEwCtEq5cbI9ctYZPUIK7d3k5DY8h5z99wfGJe88qhsT1eZYdx0HnrB2GGOkczrVW94ShwdTrHy7k+P/s6aoDe0u+SJiPxHaxYohUsdqXWcy5bvZlEym/St1yb6zuU=
Received: from BN0PR04CA0119.namprd04.prod.outlook.com (2603:10b6:408:ec::34)
 by SJ1PR12MB6076.namprd12.prod.outlook.com (2603:10b6:a03:45d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 01:59:34 +0000
Received: from BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::81) by BN0PR04CA0119.outlook.office365.com
 (2603:10b6:408:ec::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Thu, 1 Jun 2023 01:59:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT080.mail.protection.outlook.com (10.13.176.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Thu, 1 Jun 2023 01:59:33 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 31 May
 2023 20:59:32 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/4] drm/amd/pm: update SMU13 header files for coming OD
 support
Date: Thu, 1 Jun 2023 09:59:02 +0800
Message-ID: <20230601015905.49427-2-evan.quan@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230601015905.49427-1-evan.quan@amd.com>
References: <20230601015905.49427-1-evan.quan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT080:EE_|SJ1PR12MB6076:EE_
X-MS-Office365-Filtering-Correlation-Id: a61da3fe-8fbd-4ef4-079f-08db6243d88d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 40u5wIPW3dhgSPzEtwNd1ONWjZMCCWwsVF0QcWqXV6ULWR1Z+SsWo+ODTykgLvbbY8wrnLCVn/ora3iXotKW4eYQAHUTsuy+yGB1tqyDXdGGljx2nXqs2sb2YoeXV+PIlDVtXwdiYQitF0JdPRiNQOTJBosb0k8JuzY3gd892QkPufs1HxEep9sK9H7N1lKhDYG1rvF8Feb21fiFPL+MI285yw9MNCAuoQmiXwvLe7lJ6TwSZ8ZPE70Xs9f/CCydC58oJNfKC5Uxu6IADrOEpU4xapUEIc7+x31iI9n17A6WOBfinZS60LWFuPKxK373oxpDuwpq8qElijW0Gm+g0WZrObknMNIc0dMs/uDVaiAQn3QnKADTyG6asE9xFznhmKrtPFfFprFOseVN5I8ZO+3hoRjCGv9ZcRHxPzSADWQJuD+CAsrTo2Jwy9LiGhkiOOiQsJCv71Q3M3D/7iuzBiBXJWv2nJh30UzCYq6NEW0fzT78ipAhtNVhckN3b6yuEv7tPWqwzQLIFmnRaFy+nVHZHBXQ76WIErO/JZ5ZWlTRC3LtGenWbhxPfBSxykCPZsmYYoHT9rbzeNjSZOQq4XmRDLqx1/IHtNfx8CKyJj7TpmcslamS78bqBX6+3/5DVwPI112tn2/4Z5KlPfLR6BXoW+UUpq8wYb59LXJY6I3YB9eXt5+upPlo8OLFZj8mNpLYG45Obpi71Q0UnI+N2dxTnC8N0Pt4c3iobzmcvYmh97tHGe8q6oU00NrsoCpMqnmxRYN3tdx3sQhK+d78mQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(376002)(346002)(396003)(451199021)(36840700001)(46966006)(40470700004)(82740400003)(6666004)(81166007)(356005)(478600001)(82310400005)(40480700001)(186003)(26005)(83380400001)(47076005)(2616005)(426003)(36860700001)(336012)(1076003)(16526019)(36756003)(7696005)(40460700003)(70586007)(316002)(41300700001)(70206006)(4326008)(6916009)(44832011)(86362001)(8936002)(2906002)(8676002)(30864003)(5660300002)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 01:59:33.8040 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a61da3fe-8fbd-4ef4-079f-08db6243d88d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6076
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
Cc: Alexander.Deucher@amd.com, Evan Quan <evan.quan@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Correct the data structures for OD feature support.

Signed-off-by: Evan Quan <evan.quan@amd.com>
---
 .../gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h  | 16 +++++-----
 .../inc/pmfw_if/smu13_driver_if_v13_0_0.h     | 18 +++++++-----
 .../inc/pmfw_if/smu13_driver_if_v13_0_7.h     | 29 ++++---------------
 .../amd/pm/swsmu/inc/smu_v13_0_7_pptable.h    | 16 +++++-----
 4 files changed, 34 insertions(+), 45 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h
index 566a0da59e53..1dc7a065a6d4 100644
--- a/drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h
+++ b/drivers/gpu/drm/amd/pm/inc/smu_v13_0_0_pptable.h
@@ -38,13 +38,12 @@
 #define SMU_13_0_0_PP_THERMALCONTROLLER_NONE 0
 #define SMU_13_0_0_PP_THERMALCONTROLLER_NAVI21 28
 
-#define SMU_13_0_0_PP_OVERDRIVE_VERSION 0x81        // OverDrive 8 Table Version 0.2
+#define SMU_13_0_0_PP_OVERDRIVE_VERSION 0x83        // OverDrive 8 Table Version 0.2
 #define SMU_13_0_0_PP_POWERSAVINGCLOCK_VERSION 0x01 // Power Saving Clock Table Version 1.00
 
 enum SMU_13_0_0_ODFEATURE_CAP
 {
     SMU_13_0_0_ODCAP_GFXCLK_LIMITS = 0,
-    SMU_13_0_0_ODCAP_GFXCLK_CURVE,
     SMU_13_0_0_ODCAP_UCLK_LIMITS,
     SMU_13_0_0_ODCAP_POWER_LIMIT,
     SMU_13_0_0_ODCAP_FAN_ACOUSTIC_LIMIT,
@@ -59,13 +58,13 @@ enum SMU_13_0_0_ODFEATURE_CAP
     SMU_13_0_0_ODCAP_FAN_CURVE,
     SMU_13_0_0_ODCAP_AUTO_FAN_ACOUSTIC_LIMIT,
     SMU_13_0_0_ODCAP_POWER_MODE,
+    SMU_13_0_0_ODCAP_PER_ZONE_GFX_VOLTAGE_OFFSET,
     SMU_13_0_0_ODCAP_COUNT,
 };
 
 enum SMU_13_0_0_ODFEATURE_ID
 {
     SMU_13_0_0_ODFEATURE_GFXCLK_LIMITS           = 1 << SMU_13_0_0_ODCAP_GFXCLK_LIMITS,           //GFXCLK Limit feature
-    SMU_13_0_0_ODFEATURE_GFXCLK_CURVE            = 1 << SMU_13_0_0_ODCAP_GFXCLK_CURVE,            //GFXCLK Curve feature
     SMU_13_0_0_ODFEATURE_UCLK_LIMITS             = 1 << SMU_13_0_0_ODCAP_UCLK_LIMITS,             //UCLK Limit feature
     SMU_13_0_0_ODFEATURE_POWER_LIMIT             = 1 << SMU_13_0_0_ODCAP_POWER_LIMIT,             //Power Limit feature
     SMU_13_0_0_ODFEATURE_FAN_ACOUSTIC_LIMIT      = 1 << SMU_13_0_0_ODCAP_FAN_ACOUSTIC_LIMIT,      //Fan Acoustic RPM feature
@@ -80,6 +79,7 @@ enum SMU_13_0_0_ODFEATURE_ID
     SMU_13_0_0_ODFEATURE_FAN_CURVE               = 1 << SMU_13_0_0_ODCAP_FAN_CURVE,               //Fan Curve feature
     SMU_13_0_0_ODFEATURE_AUTO_FAN_ACOUSTIC_LIMIT = 1 << SMU_13_0_0_ODCAP_AUTO_FAN_ACOUSTIC_LIMIT, //Auto Fan Acoustic RPM feature
     SMU_13_0_0_ODFEATURE_POWER_MODE              = 1 << SMU_13_0_0_ODCAP_POWER_MODE,              //Optimized GPU Power Mode feature
+    SMU_13_0_0_ODFEATURE_PER_ZONE_GFX_VOLTAGE_OFFSET  = 1 << SMU_13_0_0_ODCAP_PER_ZONE_GFX_VOLTAGE_OFFSET,  //Perzone voltage offset feature
     SMU_13_0_0_ODFEATURE_COUNT                   = 16,
 };
 
@@ -89,10 +89,6 @@ enum SMU_13_0_0_ODSETTING_ID
 {
     SMU_13_0_0_ODSETTING_GFXCLKFMAX = 0,
     SMU_13_0_0_ODSETTING_GFXCLKFMIN,
-    SMU_13_0_0_ODSETTING_CUSTOM_GFX_VF_CURVE_A,
-    SMU_13_0_0_ODSETTING_CUSTOM_GFX_VF_CURVE_B,
-    SMU_13_0_0_ODSETTING_CUSTOM_GFX_VF_CURVE_C,
-    SMU_13_0_0_ODSETTING_CUSTOM_CURVE_VFT_FMIN,
     SMU_13_0_0_ODSETTING_UCLKFMIN,
     SMU_13_0_0_ODSETTING_UCLKFMAX,
     SMU_13_0_0_ODSETTING_POWERPERCENTAGE,
@@ -117,6 +113,12 @@ enum SMU_13_0_0_ODSETTING_ID
     SMU_13_0_0_ODSETTING_FAN_CURVE_SPEED_5,
     SMU_13_0_0_ODSETTING_AUTO_FAN_ACOUSTIC_LIMIT,
     SMU_13_0_0_ODSETTING_POWER_MODE,
+    SMU_13_0_0_ODSETTING_PER_ZONE_GFX_VOLTAGE_OFFSET_POINT_1,
+    SMU_13_0_0_ODSETTING_PER_ZONE_GFX_VOLTAGE_OFFSET_POINT_2,
+    SMU_13_0_0_ODSETTING_PER_ZONE_GFX_VOLTAGE_OFFSET_POINT_3,
+    SMU_13_0_0_ODSETTING_PER_ZONE_GFX_VOLTAGE_OFFSET_POINT_4,
+    SMU_13_0_0_ODSETTING_PER_ZONE_GFX_VOLTAGE_OFFSET_POINT_5,
+    SMU_13_0_0_ODSETTING_PER_ZONE_GFX_VOLTAGE_OFFSET_POINT_6,
     SMU_13_0_0_ODSETTING_COUNT,
 };
 #define SMU_13_0_0_MAX_ODSETTING 64 //Maximum Number of ODSettings
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
index fdcc99ebd050..91e0f3f7c80a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
@@ -678,7 +678,14 @@ typedef enum {
 
 #define PP_NUM_RTAVFS_PWL_ZONES 5
 
-
+#define PP_OD_FEATURE_GFX_VF_CURVE_BIT  0
+#define PP_OD_FEATURE_PPT_BIT       2
+#define PP_OD_FEATURE_FAN_CURVE_BIT 3
+#define PP_OD_FEATURE_GFXCLK_BIT      7
+#define PP_OD_FEATURE_UCLK_BIT      8
+#define PP_OD_FEATURE_ZERO_FAN_BIT      9
+#define PP_OD_FEATURE_TEMPERATURE_BIT 10
+#define PP_OD_FEATURE_COUNT 13
 
 // VBIOS or PPLIB configures telemetry slope and offset. Only slope expected to be set for SVI3
 // Slope Q1.7, Offset Q1.2
@@ -700,10 +707,8 @@ typedef struct {
 
   //Voltage control
   int16_t                VoltageOffsetPerZoneBoundary[PP_NUM_OD_VF_CURVE_POINTS];
-  uint16_t               VddGfxVmax;         // in mV
 
-  uint8_t                IdlePwrSavingFeaturesCtrl;
-  uint8_t                RuntimePwrSavingFeaturesCtrl;
+  uint32_t               Reserved;
 
   //Frequency changes
   int16_t                GfxclkFmin;           // MHz
@@ -740,10 +745,9 @@ typedef struct {
   uint32_t FeatureCtrlMask;
 
   int16_t VoltageOffsetPerZoneBoundary;
-  uint16_t               VddGfxVmax;         // in mV
+  uint16_t               Reserved1;
 
-  uint8_t                IdlePwrSavingFeaturesCtrl;
-  uint8_t                RuntimePwrSavingFeaturesCtrl;
+  uint16_t               Reserved2;
 
   int16_t               GfxclkFmin;           // MHz
   int16_t               GfxclkFmax;           // MHz
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
index 0c5e365c31ae..1530ca002c6c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_7.h
@@ -694,18 +694,12 @@ typedef struct {
 
 
 #define PP_OD_FEATURE_GFX_VF_CURVE_BIT  0
-#define PP_OD_FEATURE_VMAX_BIT      1
 #define PP_OD_FEATURE_PPT_BIT       2
 #define PP_OD_FEATURE_FAN_CURVE_BIT 3
-#define PP_OD_FEATURE_FREQ_DETER_BIT 4
-#define PP_OD_FEATURE_FULL_CTRL_BIT 5
-#define PP_OD_FEATURE_TDC_BIT      6
 #define PP_OD_FEATURE_GFXCLK_BIT      7
 #define PP_OD_FEATURE_UCLK_BIT      8
 #define PP_OD_FEATURE_ZERO_FAN_BIT      9
 #define PP_OD_FEATURE_TEMPERATURE_BIT 10
-#define PP_OD_FEATURE_POWER_FEATURE_CTRL_BIT 11
-#define PP_OD_FEATURE_ASIC_TDC_BIT 12
 #define PP_OD_FEATURE_COUNT 13
 
 typedef enum {
@@ -724,10 +718,8 @@ typedef struct {
 
   //Voltage control
   int16_t                VoltageOffsetPerZoneBoundary[PP_NUM_OD_VF_CURVE_POINTS];
-  uint16_t               VddGfxVmax;         // in mV
 
-  uint8_t                IdlePwrSavingFeaturesCtrl;
-  uint8_t                RuntimePwrSavingFeaturesCtrl;
+  uint32_t               Reserved;
 
   //Frequency changes
   int16_t                GfxclkFmin;           // MHz
@@ -752,12 +744,7 @@ typedef struct {
   uint8_t                MaxOpTemp;
   uint8_t                Padding[4];
 
-  uint16_t               GfxVoltageFullCtrlMode;
-  uint16_t               GfxclkFullCtrlMode;
-  uint16_t               UclkFullCtrlMode;
-  int16_t                AsicTdc;
-
-  uint32_t               Spare[10];
+  uint32_t               Spare[12];
   uint32_t               MmHubPadding[8]; // SMU internal use. Adding here instead of external as a workaround
 } OverDriveTable_t;
 
@@ -770,10 +757,9 @@ typedef struct {
   uint32_t FeatureCtrlMask;
 
   int16_t VoltageOffsetPerZoneBoundary;
-  uint16_t               VddGfxVmax;         // in mV
+  uint16_t               Reserved1;
 
-  uint8_t                IdlePwrSavingFeaturesCtrl;
-  uint8_t                RuntimePwrSavingFeaturesCtrl;
+  uint16_t               Reserved2;
 
   int16_t                GfxclkFmin;           // MHz
   int16_t                GfxclkFmax;           // MHz
@@ -796,12 +782,7 @@ typedef struct {
   uint8_t                MaxOpTemp;
   uint8_t                Padding[4];
 
-  uint16_t               GfxVoltageFullCtrlMode;
-  uint16_t               GfxclkFullCtrlMode;
-  uint16_t               UclkFullCtrlMode;
-  int16_t                AsicTdc;
-
-  uint32_t               Spare[10];
+  uint32_t               Spare[12];
 
 } OverDriveLimits_t;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_7_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_7_pptable.h
index 478862ded0bd..eadbe0149cae 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_7_pptable.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0_7_pptable.h
@@ -38,13 +38,12 @@
 #define SMU_13_0_7_PP_THERMALCONTROLLER_NONE 0
 #define SMU_13_0_7_PP_THERMALCONTROLLER_NAVI21 28
 
-#define SMU_13_0_7_PP_OVERDRIVE_VERSION 0x81        // OverDrive 8 Table Version 0.2
+#define SMU_13_0_7_PP_OVERDRIVE_VERSION 0x83        // OverDrive 8 Table Version 0.2
 #define SMU_13_0_7_PP_POWERSAVINGCLOCK_VERSION 0x01 // Power Saving Clock Table Version 1.00
 
 enum SMU_13_0_7_ODFEATURE_CAP
 {
     SMU_13_0_7_ODCAP_GFXCLK_LIMITS = 0,
-    SMU_13_0_7_ODCAP_GFXCLK_CURVE,
     SMU_13_0_7_ODCAP_UCLK_LIMITS,
     SMU_13_0_7_ODCAP_POWER_LIMIT,
     SMU_13_0_7_ODCAP_FAN_ACOUSTIC_LIMIT,
@@ -59,13 +58,13 @@ enum SMU_13_0_7_ODFEATURE_CAP
     SMU_13_0_7_ODCAP_FAN_CURVE,
     SMU_13_0_7_ODCAP_AUTO_FAN_ACOUSTIC_LIMIT,
     SMU_13_0_7_ODCAP_POWER_MODE,
+    SMU_13_0_7_ODCAP_PER_ZONE_GFX_VOLTAGE_OFFSET,
     SMU_13_0_7_ODCAP_COUNT,
 };
 
 enum SMU_13_0_7_ODFEATURE_ID
 {
     SMU_13_0_7_ODFEATURE_GFXCLK_LIMITS           = 1 << SMU_13_0_7_ODCAP_GFXCLK_LIMITS,           //GFXCLK Limit feature
-    SMU_13_0_7_ODFEATURE_GFXCLK_CURVE            = 1 << SMU_13_0_7_ODCAP_GFXCLK_CURVE,            //GFXCLK Curve feature
     SMU_13_0_7_ODFEATURE_UCLK_LIMITS             = 1 << SMU_13_0_7_ODCAP_UCLK_LIMITS,             //UCLK Limit feature
     SMU_13_0_7_ODFEATURE_POWER_LIMIT             = 1 << SMU_13_0_7_ODCAP_POWER_LIMIT,             //Power Limit feature
     SMU_13_0_7_ODFEATURE_FAN_ACOUSTIC_LIMIT      = 1 << SMU_13_0_7_ODCAP_FAN_ACOUSTIC_LIMIT,      //Fan Acoustic RPM feature
@@ -80,6 +79,7 @@ enum SMU_13_0_7_ODFEATURE_ID
     SMU_13_0_7_ODFEATURE_FAN_CURVE               = 1 << SMU_13_0_7_ODCAP_FAN_CURVE,               //Fan Curve feature
     SMU_13_0_7_ODFEATURE_AUTO_FAN_ACOUSTIC_LIMIT = 1 << SMU_13_0_7_ODCAP_AUTO_FAN_ACOUSTIC_LIMIT, //Auto Fan Acoustic RPM feature
     SMU_13_0_7_ODFEATURE_POWER_MODE              = 1 << SMU_13_0_7_ODCAP_POWER_MODE,              //Optimized GPU Power Mode feature
+    SMU_13_0_7_ODFEATURE_PER_ZONE_GFX_VOLTAGE_OFFSET  = 1 << SMU_13_0_7_ODCAP_PER_ZONE_GFX_VOLTAGE_OFFSET,  //Perzone voltage offset feature
     SMU_13_0_7_ODFEATURE_COUNT                   = 16,
 };
 
@@ -89,10 +89,6 @@ enum SMU_13_0_7_ODSETTING_ID
 {
     SMU_13_0_7_ODSETTING_GFXCLKFMAX = 0,
     SMU_13_0_7_ODSETTING_GFXCLKFMIN,
-    SMU_13_0_7_ODSETTING_CUSTOM_GFX_VF_CURVE_A,
-    SMU_13_0_7_ODSETTING_CUSTOM_GFX_VF_CURVE_B,
-    SMU_13_0_7_ODSETTING_CUSTOM_GFX_VF_CURVE_C,
-    SMU_13_0_7_ODSETTING_CUSTOM_CURVE_VFT_FMIN,
     SMU_13_0_7_ODSETTING_UCLKFMIN,
     SMU_13_0_7_ODSETTING_UCLKFMAX,
     SMU_13_0_7_ODSETTING_POWERPERCENTAGE,
@@ -117,6 +113,12 @@ enum SMU_13_0_7_ODSETTING_ID
     SMU_13_0_7_ODSETTING_FAN_CURVE_SPEED_5,
     SMU_13_0_7_ODSETTING_AUTO_FAN_ACOUSTIC_LIMIT,
     SMU_13_0_7_ODSETTING_POWER_MODE,
+    SMU_13_0_7_ODSETTING_PER_ZONE_GFX_VOLTAGE_OFFSET_POINT_1,
+    SMU_13_0_7_ODSETTING_PER_ZONE_GFX_VOLTAGE_OFFSET_POINT_2,
+    SMU_13_0_7_ODSETTING_PER_ZONE_GFX_VOLTAGE_OFFSET_POINT_3,
+    SMU_13_0_7_ODSETTING_PER_ZONE_GFX_VOLTAGE_OFFSET_POINT_4,
+    SMU_13_0_7_ODSETTING_PER_ZONE_GFX_VOLTAGE_OFFSET_POINT_5,
+    SMU_13_0_7_ODSETTING_PER_ZONE_GFX_VOLTAGE_OFFSET_POINT_6,
     SMU_13_0_7_ODSETTING_COUNT,
 };
 #define SMU_13_0_7_MAX_ODSETTING 64 //Maximum Number of ODSettings
-- 
2.34.1


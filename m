Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96B29C7EE23
	for <amd-gfx@archiver.kernel.org>; Wed, 31 May 2023 13:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F24510E4C0;
	Wed, 31 May 2023 13:10:09 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2055.outbound.protection.outlook.com [40.107.244.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7D6310E4C0
 for <amd-gfx@lists.freedesktop.org>; Wed, 31 May 2023 13:10:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WqmUbY06ZZIo0A3cE2SenFFlhIIqrpENPES66KGkiqqofacRfWeQwlwclLdQ9BgpEBIajzBbAiwm9rOOHVErdR/adW9GpHS6q/kKL/c+XSE2YoGNlIxesjNg6ZhIihBPtJ50l5Ert1p3DUhha6JOcXmH7fFWBy6lyepGbJf1rYV9kAn7dLcJ+90F6tA+CcwUJg4PgF+HmEYosTX7QTsseJKlJ2RZjJYPrjPXPN/GKDQsDVgOT6b8ltjYYZyi4q6sBYpURksYTT8qsiaed7QSoW2DD8RpMIxz2JRiwOXTNOLlMOvJFCFJuT/q+t1RF4bPCB69d2LdKhl1x8iPrrVMiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wsAnYUlXG6YSglDd6ONWZypTrAT8r3EGgaRVrhqeRAI=;
 b=HKtgYBMM6FjobI61V6XHmj77joc52bn5G6aaIurEAoq8sn8S6VmmH3eOvoY69qAICz9k7jRjRo6Bd4+vAa3G6vuJpr+4ve7KYQSxebCM16KoonrbcOOhdsFYPYi1eGMYZ0oRSdJXduxiGns9hFwTSTaJkUaVK7xmHzeGENJ5brENpXO1+xn1HCL0IYarlRsrfREfvPBcGtIE1k10iguGn/J6x89wnMiNKGmGPlNppWyeh2XjT1YHrwsmIG24pwNUkeAxxHhPwTMvgFLEnA0b6nriwyUBmkCazKMfV1U/YuO4kbwvgPBRswVTU+V1PCkBtSMlSWRUlljCES3lfIlSfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wsAnYUlXG6YSglDd6ONWZypTrAT8r3EGgaRVrhqeRAI=;
 b=mJzk7Xm3Cr5D/9uE1hbZIm//VGUI98FZcb9OWNJhz7ah0NJJcDrcw64+8sOFlFg+ne2+whAk7j2fQTnYI7TTum1PJn3KZW0fv6K0DcTh/wNg3/ajQHnMsJ/aTgxR2ojsFIWDH56m/0d7Tv1BrDHKUXuFyOxuAN4ErdSJRTTHxYw=
Received: from BN0PR10CA0026.namprd10.prod.outlook.com (2603:10b6:408:143::21)
 by MN2PR12MB4422.namprd12.prod.outlook.com (2603:10b6:208:265::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.23; Wed, 31 May
 2023 13:10:04 +0000
Received: from BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:143:cafe::82) by BN0PR10CA0026.outlook.office365.com
 (2603:10b6:408:143::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.22 via Frontend
 Transport; Wed, 31 May 2023 13:10:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT068.mail.protection.outlook.com (10.13.177.69) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Wed, 31 May 2023 13:10:04 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 31 May
 2023 08:09:59 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amd/pm: Update SMUv13.0.6 PMFW headers
Date: Wed, 31 May 2023 21:09:43 +0800
Message-ID: <20230531130945.720648-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT068:EE_|MN2PR12MB4422:EE_
X-MS-Office365-Filtering-Correlation-Id: 8faccf70-1eef-4ae1-049a-08db61d8595a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bgLxf3AH90urFrONA/NedaiUJmpZEYVmqrH0Z3xvBBpsd8hwGqxnfwffrGO46WTSX+J8p3sbpgZXUrVeOgj9aQC1fZU+h95SV8NUILCKmJ+7YyGThHpYoKZvhDSsNKaB6stzeG0wGblXt60zdoj/wLYykrvagbmHXN0qA6GQZiyiRnkX7y49feqWdFDSM+Y0+B2ka186maboHDRPeQptmqO7uXmjCiLXhsDX3JTsgpqc7Tc+AUgvUWT3iBqv5rqBwnFoMcu91xyeKaQNkpzV/oJqlZA/7lfwod2ei7n/CcGPDnQMJpczLov7jfmcRPfh42upldwbxyS7a76CbGjf737CoxoGmn77llhTpAPXvlO+f4rZJiT9FQQXnB+6m/QFZIEBc+kCGRwQCEmEhAnnvAGc2UrTTrsOxTa7SUGZ5utmIzOk5BP4o8FqGuTVp1qmJtuya5LqVx736vyZdmtyEqWKJ8wT8yHwtLCNcXNl6IlZlPQCip6XwoGmh702gMZHk/+lIcCpGNUDufOwdj/byhUekPI29amLV9xZ7E4RD/kFjE+I8YCJe4vKo3l6z8yNYnzcLYV0RXL7B9R0vry30n4K8JM5v16ToE0pBFuXPit7wZShDAMO/Ev4xOfixeoik/RXzoSGQwLN7BDBWSQEZ7+be4rNUBd68/M5Khpu2qJD6UrYVXKZ5kjo6b6NjuJdciSo0u/cWMh/zd5J6Wj53Adkpl9/tdgLbOMUcroK8B1wAUO0PKdWSBlacpGVvYOzhpVjsRYuS5O9rRWekni+1Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(39860400002)(136003)(396003)(346002)(451199021)(36840700001)(40470700004)(46966006)(186003)(2616005)(16526019)(41300700001)(426003)(336012)(83380400001)(36860700001)(26005)(1076003)(6666004)(7696005)(47076005)(478600001)(40460700003)(54906003)(19627235002)(82740400003)(70206006)(70586007)(4326008)(356005)(40480700001)(316002)(6916009)(82310400005)(5660300002)(44832011)(8936002)(8676002)(2906002)(86362001)(15650500001)(81166007)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 May 2023 13:10:04.2490 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8faccf70-1eef-4ae1-049a-08db61d8595a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT068.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4422
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
Cc: Le.Ma@amd.com, lijo.lazar@amd.com, shiwzhan@amd.com, Hawking.Zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lijo Lazar <lijo.lazar@amd.com>

Update PMFW interface headers to for new metrics table format and
throttling information.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../inc/pmfw_if/smu13_driver_if_v13_0_6.h     | 31 ++++++++++++++-----
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h   | 13 +++++---
 2 files changed, 33 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
index de84fff39799..ca4a5e99ccd1 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_6.h
@@ -26,7 +26,7 @@
 // *** IMPORTANT ***
 // PMFW TEAM: Always increment the interface version if
 // anything is changed in this file
-#define SMU13_0_6_DRIVER_IF_VERSION 0x08042023
+#define SMU13_0_6_DRIVER_IF_VERSION 0x08042024
 
 //I2C Interface
 #define NUM_I2C_CONTROLLERS                8
@@ -125,11 +125,28 @@ typedef struct {
 #define IH_INTERRUPT_ID_TO_DRIVER                   0xFE
 #define IH_INTERRUPT_CONTEXT_ID_THERMAL_THROTTLING  0x7
 
-//thermal over-temp mask defines
-#define THROTTLER_TEMP_CCD_BIT     5
-#define THROTTLER_TEMP_XCD_BIT     6
-#define THROTTLER_TEMP_HBM_BIT     7
-#define THROTTLER_TEMP_AID_BIT     8
-#define THROTTLER_VRHOT_BIT        9
+//thermal over-temp mask defines for IH interrupt to host
+#define THROTTLER_PROCHOT_BIT           0
+#define THROTTLER_PPT_BIT               1
+#define THROTTLER_THERMAL_SOCKET_BIT    2//AID, XCD, CCD throttling
+#define THROTTLER_THERMAL_VR_BIT        3//VRHOT
+#define THROTTLER_THERMAL_HBM_BIT       4
+
+// These defines are used with the following messages:
+// SMC_MSG_TransferTableDram2Smu
+// SMC_MSG_TransferTableSmu2Dram
+// #define TABLE_PPTABLE                 0
+// #define TABLE_AVFS_PSM_DEBUG          1
+// #define TABLE_AVFS_FUSE_OVERRIDE      2
+// #define TABLE_PMSTATUSLOG             3
+// #define TABLE_SMU_METRICS             4
+// #define TABLE_DRIVER_SMU_CONFIG       5
+// #define TABLE_I2C_COMMANDS            6
+// #define TABLE_COUNT                   7
+
+// // Table transfer status
+// #define TABLE_TRANSFER_OK         0x0
+// #define TABLE_TRANSFER_FAILED     0xFF
+// #define TABLE_TRANSFER_PENDING    0xAB
 
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
index 3fe403615d86..252aef190c5c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
@@ -123,9 +123,9 @@ typedef enum {
   VOLTAGE_GUARDBAND_COUNT
 } GFX_GUARDBAND_e;
 
-#define SMU_METRICS_TABLE_VERSION 0x3
+#define SMU_METRICS_TABLE_VERSION 0x5
 
-typedef struct {
+typedef struct __attribute__((packed, aligned(4))) {
   uint32_t AccumulationCounter;
 
   //TEMPERATURE
@@ -202,11 +202,16 @@ typedef struct {
 
   // New Items at end to maintain driver compatibility
   uint32_t GfxclkFrequency[8];
+
+  //PSNs
+  uint64_t PublicSerialNumber_AID[4];
+  uint64_t PublicSerialNumber_XCD[8];
+  uint64_t PublicSerialNumber_CCD[12];
 } MetricsTable_t;
 
-#define SMU_VF_METRICS_TABLE_VERSION 0x1
+#define SMU_VF_METRICS_TABLE_VERSION 0x3
 
-typedef struct {
+typedef struct __attribute__((packed, aligned(4))) {
   uint32_t AccumulationCounter;
   uint32_t InstGfxclk_TargFreq;
   uint64_t AccGfxclk_TargFreq;
-- 
2.34.1


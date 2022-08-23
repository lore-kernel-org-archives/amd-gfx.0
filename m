Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 462B9C28D13
	for <amd-gfx@archiver.kernel.org>; Tue, 23 Aug 2022 01:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D12CBA90DA;
	Tue, 23 Aug 2022 01:23:24 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2085.outbound.protection.outlook.com [40.107.94.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E9F7A90AE
 for <amd-gfx@lists.freedesktop.org>; Tue, 23 Aug 2022 01:22:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hQ3kl8GyvMOgHaXceuHUymrX9iG/hl/qGJB18tAosFOQHJH4U11HfrE8DsqpW8fp+92Z5ZJD4iuG2nCuyRYbZZioAryKB0ZT1qxFWdcJ4ek2e7JVte7yX/TxC6b8NYsroY26HjMtNoyQsri2zIMmFNWR3HGRYFh+/dDrD2a27LUHXd2vBrji09+JSDjjg1tFsUYqiqD+bK804rVQ+6y/881D3PJMDETv7wPmA0sZeeRzw3Jpp5BKkwKUO7YfCbBO4uChJqPeI1JBZbDVP2rk/sehgA1MivHHvkzXDxpNwXJ+gluYNBuSl/nZOsYfSRec1BLGOBn2iEMbDxVfiLDgMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWN6qoivxNHrz5IxBsrTJJVFJYEzWEGMlgBLjLGnADY=;
 b=oQ+YamKEJwCg5LQb/hM633O2IGlr4FV8mjwX4lKcFgD6co+dyRd0Bh9eC1IytNAGY4akU3BccL2I7YFZI8f0jMhiY5pkv9mEk1nN5pdT7J4MjqpQICBxU8/j7QeV1Aj2SWyl9lbSyAgbTOE8q2iW+9mtnfBW118G72uK5syw69F2VzZ0d2HbVQ7dNcCTzDkznmwNQFXcyFKU7nzPaCptWm1kYLT9jop/2ZcnQFrmBh29iAn0iqAGHnczTyVULFQ04mjWcMLcycpVmM0wr7gq1vHEyal4h5YadaXNPIU67MCn/SHgySDnnxxqQEVY9sVB032ipTq7yNifQpwFi9eipA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZWN6qoivxNHrz5IxBsrTJJVFJYEzWEGMlgBLjLGnADY=;
 b=SYeqqQa6BT6wq6VoWrS4F4TYOPwC20XxQ4c6dnjiGFMF7bMxOu0szYy8D6MZ3SRJSPpXwWSrQsf5HiRliVPwurjMEFVaIIuwbY1tTgl8zYz9tST0Pj77t7tdyRKYjE/Ak0iHul5EaV0mcYioSQPnBXKXYuTUgfiF9AaoBZvXmMg=
Received: from BN8PR04CA0020.namprd04.prod.outlook.com (2603:10b6:408:70::33)
 by BL1PR12MB5222.namprd12.prod.outlook.com (2603:10b6:208:31e::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Tue, 23 Aug
 2022 01:22:51 +0000
Received: from BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::f1) by BN8PR04CA0020.outlook.office365.com
 (2603:10b6:408:70::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.20 via Frontend
 Transport; Tue, 23 Aug 2022 01:22:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT079.mail.protection.outlook.com (10.13.177.61) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5546.7 via Frontend Transport; Tue, 23 Aug 2022 01:22:51 +0000
Received: from equan-buildpc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Mon, 22 Aug
 2022 20:22:50 -0500
From: Evan Quan <evan.quan@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] drm/amd/pm: update SMU 13.0.0 driver_if header
Date: Tue, 23 Aug 2022 09:22:31 +0800
Message-ID: <20220823012231.1923038-1-evan.quan@amd.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cb1f8450-6187-4d5d-4653-08da84a5ff84
X-MS-TrafficTypeDiagnostic: BL1PR12MB5222:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XLJ46u0Eil6t+wkw3uxDjZcHDcE2mi7/Y9eDi7AiFfL2qy4o1Qr+fONrQfvGNehVqH9vYh3GKEfDUCVQSBvz+NFlkriZ5gNoiaj18a/zQVf2CG2uJz+NAJnBbYb9wfdm6GatViUyf/U88/RrOd8GD6CUTkk1jaqoTRYBgNvIr5G3cpaEZyhRV9IhDA3JmTTKAUVYRBIvMUs8QF20inZR34xPjuKEj3GZKWZSAXabcuYxJwVY4R+3BU+6qKZujFSazy/zkr6tXANETri5cezgTMruW8dRru5SDupiA/ECRAqBvpMFCnFxgoL4RGmJhF+kms7c6g1y0vD1RldjZtucChKHFGGrmMX3F/j0QubGFuxI4vyICibAKU1dkrv59Y2X8xUIVPiIVlJyUvnuUJsj36oMhyTouXCzus0WcwOOX61eIHLtC5BVK6tq4ZeAXan3kpXWEnnLfa03jruWy2h2giVCB+3dx4C6zhC6qi9Hxk57dLo6iBOKM5BfjDc8sHg9RhYW0rzHE+0wLtX0D8MK9spDesaJKT4wBLD/HBizSLluMl6mrnXbhKuD2AxmNz6IaoRMe/jgaZg0/1DbFSCG4ejER5qOYyxd2wLye6sqlAkIbXewBQJ0yBcHSTfzafCMjEUFWZkxn4sWYj816kbEttfsLrwRrjYcSWxZyGCkSMi7u8HZjdi7lTC2HSkQEd7JCiutck6E6lzpdu4R6mM7Rg8l0t0Hk+83jfiea7WtAozczeuWTPUYFspGyPkTjzMnmeNnr/mjJ8i6pjUp9atYiCmGDhp17y57qsib62y/G4E=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(396003)(136003)(39860400002)(376002)(36840700001)(46966006)(40470700004)(2906002)(36756003)(82310400005)(40480700001)(8676002)(4326008)(70586007)(70206006)(6916009)(54906003)(19627235002)(316002)(26005)(5660300002)(478600001)(6666004)(41300700001)(7696005)(82740400003)(81166007)(356005)(86362001)(2616005)(16526019)(336012)(47076005)(426003)(1076003)(186003)(36860700001)(8936002)(44832011)(83380400001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 01:22:51.7050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb1f8450-6187-4d5d-4653-08da84a5ff84
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT079.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5222
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
Cc: alexander.deucher@amd.com, Evan Quan <evan.quan@amd.com>,
 hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

To fit the latest 78.53 PMFW.

Signed-off-by: Evan Quan <evan.quan@amd.com>
Change-Id: I16b36a3c209c82fc2d48325f7e6ef5a702678782
---
 .../inc/pmfw_if/smu13_driver_if_v13_0_0.h     | 31 +++++++++++--------
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  2 +-
 2 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
index 78620b0bd279..f745cd8f1ab7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_0.h
@@ -24,12 +24,8 @@
 #ifndef SMU13_DRIVER_IF_V13_0_0_H
 #define SMU13_DRIVER_IF_V13_0_0_H
 
-// *** IMPORTANT ***
-// PMFW TEAM: Always increment the interface version on any change to this file
-#define SMU13_DRIVER_IF_VERSION  0x23
-
 //Increment this version if SkuTable_t or BoardTable_t change
-#define PPTABLE_VERSION 0x1D
+#define PPTABLE_VERSION 0x22
 
 #define NUM_GFXCLK_DPM_LEVELS    16
 #define NUM_SOCCLK_DPM_LEVELS    8
@@ -1193,8 +1189,17 @@ typedef struct {
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
   // SECTION: Sku Reserved
-  uint32_t         Spare[64];
+  uint32_t         Spare[61];
 
   // Padding for MMHUB - do not modify this
   uint32_t     MmHubPadding[8];
@@ -1259,7 +1264,8 @@ typedef struct {
   // SECTION: Clock Spread Spectrum
 
   // UCLK Spread Spectrum
-  uint16_t     UclkSpreadPadding;
+  uint8_t      UclkTrainingModeSpreadPercent;
+  uint8_t      UclkSpreadPadding;
   uint16_t     UclkSpreadFreq;      // kHz
 
   // UCLK Spread Spectrum
@@ -1272,11 +1278,7 @@ typedef struct {
 
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
@@ -1375,8 +1377,11 @@ typedef struct {
   uint16_t Vcn1ActivityPercentage  ;
 
   uint32_t EnergyAccumulator;
-  uint16_t AverageSocketPower    ;
+  uint16_t AverageSocketPower;
+  uint16_t AverageTotalBoardPower;
+
   uint16_t AvgTemperature[TEMP_COUNT];
+  uint16_t TempPadding;
 
   uint8_t  PcieRate               ;
   uint8_t  PcieWidth              ;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 6fe2fe92ebd7..ac308e72241a 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -30,7 +30,7 @@
 #define SMU13_DRIVER_IF_VERSION_ALDE 0x08
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_4 0x05
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_5 0x04
-#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x2C
+#define SMU13_DRIVER_IF_VERSION_SMU_V13_0_0 0x2E
 #define SMU13_DRIVER_IF_VERSION_SMU_V13_0_7 0x2C
 
 #define SMU13_MODE1_RESET_WAIT_TIME_IN_MS 500  //500ms
-- 
2.29.0


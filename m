Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D869FC04A6A
	for <amd-gfx@archiver.kernel.org>; Wed, 16 Aug 2023 12:32:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 292A110E364;
	Wed, 16 Aug 2023 12:32:28 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2080.outbound.protection.outlook.com [40.107.93.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40B1010E364
 for <amd-gfx@lists.freedesktop.org>; Wed, 16 Aug 2023 12:32:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LGy9+16maz2SndFmwsBAmkePR5LSWfc5kT3JLBMYAnxqsi5YkVTpWmGEEgFNCmcLIv2zCoFQaIz8dgNFV+VtfwesI6/cnqnVwdjzQntQw4ZWbFXuguv1NZtDbCXnd/CgGq5DbtJr1v6zP3To+B8kvZBEpIKTyMpY306/n7h/4f0t+TdhiXTqW9N5kLpd34qkwSvz+alrL2Hsc1l2/vGKHRWdJhj2XOPNJCiEguU1w++MGB6MLvwZioe7fSdX8LdT53+3j4a2pYZwX1WKlcjCpqJkAqixSwg5fomyh2LIKePi2f/VFPCj/nVraYNLsa2bkaEfTvBNO4mH3fo/GMJIgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=78B45OTYZgCKoR1ReP1lu9zTOL1uyy5ifgbLyzIgEgY=;
 b=oa27EREX3fFhX6bgo/Akmf/mJr5huaavuXKuqG1kyYZZO7bw1iHwYqXXFlUvy0BrQRmkJnWLRoVyFbqRKXCUj68VL/4bM/P+zDSJatOVYVT+9TZZfHXi6cxt694VpwuJoJ5ZCM2tSEuWDTlXnUGHKEW6hv1R08e4rKz7aDGDuGB12gKFL22c5QgEkeTg/+EgqnZ/xgiN/vNt8H5uhfagL98iHjfhrL7XzhiQxMvM8dUAeYY5mLNw17ph/jxZ1L0SYbkdMD3SQ5MIQldvCtAwGOBTkOryaApvKyRTmqSGAjfpD0DBMgY+cF0HMrK+Y9rH64gyxuNQM8IvWBTRgnftWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=78B45OTYZgCKoR1ReP1lu9zTOL1uyy5ifgbLyzIgEgY=;
 b=CZ+WU/kApaCRNJoggNBuU0Phkf05S3SVOmITTxcuF++g/mlDn1wD8mX1dYUVQrfdOhRxJY3kFwbM67u84YSfsPNyoQ2t+57S6h7rOt3qDnhHs+5pHcqMF7gaajn5iY9hNisUIXMK5FYAiKcUb8YmM/fESTY0nIErsPAf7y+8eO4=
Received: from MW4PR03CA0045.namprd03.prod.outlook.com (2603:10b6:303:8e::20)
 by SJ0PR12MB6759.namprd12.prod.outlook.com (2603:10b6:a03:44b::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Wed, 16 Aug
 2023 12:32:24 +0000
Received: from CO1PEPF000044F6.namprd21.prod.outlook.com
 (2603:10b6:303:8e:cafe::e0) by MW4PR03CA0045.outlook.office365.com
 (2603:10b6:303:8e::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Wed, 16 Aug 2023 12:32:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000044F6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6723.5 via Frontend Transport; Wed, 16 Aug 2023 12:32:22 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 16 Aug
 2023 07:32:20 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 1/2] drm/amd/pm: Update SMUv13.0.6 PMFW headers
Date: Wed, 16 Aug 2023 20:32:00 +0800
Message-ID: <20230816123201.1195066-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F6:EE_|SJ0PR12MB6759:EE_
X-MS-Office365-Filtering-Correlation-Id: aa477110-8e9e-47fe-5af0-08db9e54d757
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: l3PJe8HLYC9UCfwmsAUXEnsXyUyw9qHUXYdFp5p9j4sc4onglBunf4DTXR2OD5VEl2pM4PpYIJievx25Klandkp7uIdUTUhNunwL/+XW7UDp57tMnSvGd2HGKBPANf/ZcpteBxZJl/nxeS5hLoxeHJPCUO8O3NMgwAv2S1cLatGj7smg7MDKfIf4DIK7wyHiWE/nimyCHe30zMngDZetcmXJJjW8rvh8STy58PZ3JlSLYa6ihRB7qvoWoUcHhAgZi4iWLQdeUYsdszWdk7aZ2zQEVLWG7vHosJDtSo74iv6mXcuHBex1pVd9kFIN6+hsw1IU/I3KS3DohtmjPYhX/JUHkM42Q+pBO6VrwspcII4MqtE/jcqct6tkTExyVHz7H1fNvHPBfv77W7T4c/Z6j2/g4RfE0+Z9HSGtlrdLgzyw0HRqWW4wrjhS7hJ8Bh7vMWG6HimguJ/DxYm4FxnKaSLVQ/CmsU8/uPYA7PnRVxFhOYJIp2OyGIkGQArLBc5S+QsKMawWfD2sghZFGbUOc07HvR7Cp/kPeP5giIQOWumUVpwE93vvRc9voqD00TgccpO8kOrURGVo/GYKp+oyJZ6TsKgBl7EaP74/0l3NXo4vHWs6BSfZTEKmCj38Q3j7snC7suftILQUS7DcHMdnXoE8MHD3YZfYkQCePptE/LCfAaG8qsCuJ14rUscBmYUcZHt5UdZIe82Nmrsxup7wjkbCh9+avY+0IvFhPSCSSuOB7QvM4B0ibZbrOsDKJkFoWEpR2rSwzQFzMiCOfA1YUw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(376002)(346002)(39860400002)(396003)(451199024)(1800799009)(82310400011)(186009)(46966006)(36840700001)(40470700004)(15650500001)(2906002)(40460700003)(83380400001)(86362001)(40480700001)(478600001)(426003)(336012)(7696005)(36756003)(2616005)(6666004)(1076003)(26005)(16526019)(5660300002)(44832011)(41300700001)(36860700001)(356005)(82740400003)(54906003)(316002)(81166007)(70206006)(70586007)(6916009)(8676002)(8936002)(4326008)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 12:32:22.8918 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aa477110-8e9e-47fe-5af0-08db9e54d757
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F6.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6759
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
Cc: le.ma@amd.com, Lijo Lazar <lijo.lazar@amd.com>, asad.kamal@amd.com,
 shiwu.zhang@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update PMFW interface headers for updated metrics table and
critical temperature message

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h  |  4 ++--
 .../amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h | 16 +++++++++++++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
index 252aef190c5c..9be4051c0865 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
@@ -123,7 +123,7 @@ typedef enum {
   VOLTAGE_GUARDBAND_COUNT
 } GFX_GUARDBAND_e;
 
-#define SMU_METRICS_TABLE_VERSION 0x5
+#define SMU_METRICS_TABLE_VERSION 0x7
 
 typedef struct __attribute__((packed, aligned(4))) {
   uint32_t AccumulationCounter;
@@ -198,7 +198,7 @@ typedef struct __attribute__((packed, aligned(4))) {
   uint32_t SocketThmResidencyAcc;
   uint32_t VrThmResidencyAcc;
   uint32_t HbmThmResidencyAcc;
-  uint32_t spare;
+  uint32_t GfxLockXCDMak;
 
   // New Items at end to maintain driver compatibility
   uint32_t GfxclkFrequency[8];
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
index ae4f44c4b877..70a4a717fd3f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_ppsmc.h
@@ -83,13 +83,27 @@
 #define PPSMC_MSG_GetMinGfxDpmFreq                  0x32
 #define PPSMC_MSG_GetMaxGfxDpmFreq                  0x33
 #define PPSMC_MSG_PrepareForDriverUnload            0x34
-#define PPSMC_Message_Count                         0x35
+#define PPSMC_MSG_ReadThrottlerLimit                0x35
+#define PPSMC_MSG_QueryValidMcaCount                0x36
+#define PPSMC_MSG_McaBankDumpDW                     0x37
+#define PPSMC_MSG_GetCTFLimit                       0x38
+#define PPSMC_Message_Count                         0x39
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
 #define PPSMC_RESET_TYPE_DRIVER_MODE_2_RESET	      0x2
 #define PPSMC_RESET_TYPE_DRIVER_MODE_3_RESET        0x3
 
+//PPSMC Reset Types for driver msg argument
+#define PPSMC_THROTTLING_LIMIT_TYPE_SOCKET          0x1
+#define PPSMC_THROTTLING_LIMIT_TYPE_HBM             0x2
+
+//CTF/Throttle Limit types
+#define PPSMC_AID_THM_TYPE                          0x1
+#define PPSMC_CCD_THM_TYPE                          0x2
+#define PPSMC_XCD_THM_TYPE                          0x3
+#define PPSMC_HBM_THM_TYPE                          0x4
+
 typedef uint32_t PPSMC_Result;
 typedef uint32_t PPSMC_MSG;
 
-- 
2.34.1


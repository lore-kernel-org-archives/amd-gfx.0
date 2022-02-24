Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6072CC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Feb 2022 11:30:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE16F10FB0B;
	Thu, 24 Feb 2022 11:30:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2045.outbound.protection.outlook.com [40.107.236.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 718F810FB0B
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Feb 2022 11:30:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HqfmoSZC+pvThvqyvPlDJkFCbleQ3IkalB/H/4HueCQOXEihzs1Br1EYEct9Q/gCN75vGM1ByO5beagSdYO/LMAzmgPjAsdCjAZAn4kqh6Ky2rnaLIl1euILKC4OdWR03FzOBDonbmw7i1WZKm+H5k09ZxHBxH2yDYbUMSW3WNVxh2OuEhK8ugxel5cv0pEV54Jb1fmpo7LR6mzfrnOJ2zbGwyYX3bs4cYFvXNTd9h3IvvtfDBK0b0nV27Z4+5CAYhPUkh9tOo2oML0KTSUMiHK3OkbY5GE2uvCJRmRaXVOMXJoCj3Mma9ixy2dknRSW3ujhjudFAWGoJSvxOPG3Gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A3wLLAmZeqV4w2EfT59JiEGVIAZtNRd/SzjUsablN7o=;
 b=HPF1Z4/8hx4qa+PZCYfTnW4P4Y7e4vaF76ze+QxulF0Maqaq9lW45Sj0RWV4dJR0AX75e9vgdid3suL937xbBaGqld7BKcjAurLKNFEfeUg/5dsWjUFccR9VhNCEuDBMYKEyOaxGT2jbsJkgx7pWMs5fDp6sZsXu6YMEW8TevwqIz85kc87DcIXWAxVDE9JoY9RdkQd4LBs71vAg17VIP32o4ilAS0sTWgk1rpZN6D96c5DCzZBc0lYkqU8CbyGxMiUQoKK+FQXlQpsx1mPbROG1PBFltUZHNR1Z17XwZ4ZeV/1+uRcIbI29BT+rWU9cmdKqOi+YyWnQ3CAesDss/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A3wLLAmZeqV4w2EfT59JiEGVIAZtNRd/SzjUsablN7o=;
 b=KY1e50ngQrzqrqNxDmkUvfiprOxy9fhMqdUPSB4aNE4Ci1g/TgBZfpPHO1sygusoQH05TMitRMrzS3f1GYi0e+XaoNm1ESVfmRNo1KImwUAzSJlW+xHTt4+MEKfE7SHPXMIo/+LvLcdkW93B7w1fI3rcXxuKcGJRgz+2PkM+ciw=
Received: from DM6PR13CA0028.namprd13.prod.outlook.com (2603:10b6:5:bc::41) by
 DM5PR12MB2534.namprd12.prod.outlook.com (2603:10b6:4:b4::31) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5017.24; Thu, 24 Feb 2022 11:30:51 +0000
Received: from DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::9e) by DM6PR13CA0028.outlook.office365.com
 (2603:10b6:5:bc::41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.9 via Frontend
 Transport; Thu, 24 Feb 2022 11:30:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT060.mail.protection.outlook.com (10.13.173.63) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5017.22 via Frontend Transport; Thu, 24 Feb 2022 11:30:51 +0000
Received: from yifan.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Thu, 24 Feb
 2022 05:30:48 -0600
From: Yifan Zhang <yifan1.zhang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/2] drm/amd/pm: update message definition for smu 13.0.5
Date: Thu, 24 Feb 2022 19:30:18 +0800
Message-ID: <20220224113019.1917098-1-yifan1.zhang@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7016b2d1-99ff-4e1a-0159-08d9f7891c98
X-MS-TrafficTypeDiagnostic: DM5PR12MB2534:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB2534065D86065C6D2B894282C13D9@DM5PR12MB2534.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ORvJ9pXKWJ1cuXgsiZkHp5nP1RBeyYhNexQVa6nVrAkb651EnbS49mtmQU1uD8g9/WS/6oV5JZNYbQpwfg9cCqk04GArI2Vapggbdpse5E6lvKXi3HcuPNkbM8O2R2+if4ILxXJlBsOHN12qZxsu/OhdDz4Fz4Pp/iIMktVSr/ACmEZG2dqAJMuu66A23z5V1ub4j5mChGJNvvlGCs9AcHj7Ty98id2ahBw/TTDpegTNQ+n92zE1rtQPWyqR31YCL1zIr4ttjCniFcSoqYhlNAZv6ZjikJHOmRMB53G0sB8FojYrbafMv3H/pX+7o+4bGWkq2fRKKntx11WZfwqjSH111K8foxIeM0yOfphcbbsDS4bQQiTmgJPPkOz4cm1SGwnjm38acADTBxUunkOxLM6RNTl1eWJktP3BT33/jP/enqpxSaOr5EmrHrEfQ7RxTL1g6JDj2udSY3Q7zUv/RZGynwRboLDp8MxvwtyZQlS51Nim/GkRS8Nd5ezLUx13bNn3Kf2xguxwKMEzznpvcNxo6tBM2F4EK/IDpjYJSrMfy6XVlGa+dlJsmIblSELuu3VPwBN59t3YxE9kmwk7cXfKdzeGafdtXsc5F4wfrOk5Zsz7tklOPOQb1sBu/mqTHfys7oDdTmSC4n30a+S8WyZ//N8J/9BY0J/CEwvUgVAUN8JCcZawkK4DqWRJBZ2mQxfVlkWlxmNcXSwdJnMNSA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(2616005)(1076003)(426003)(336012)(186003)(26005)(7696005)(83380400001)(6666004)(508600001)(356005)(81166007)(4326008)(316002)(47076005)(36860700001)(36756003)(16526019)(19627235002)(15650500001)(40460700003)(54906003)(8936002)(5660300002)(8676002)(70206006)(70586007)(6916009)(86362001)(2906002)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 11:30:51.1002 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7016b2d1-99ff-4e1a-0159-08d9f7891c98
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB2534
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
Cc: Alexander.Deucher@amd.com, Yifan Zhang <yifan1.zhang@amd.com>,
 Ray.Huang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

this patch updates message definition for smu 13.0.5

Signed-off-by: Yifan Zhang <yifan1.zhang@amd.com>
---
 .../inc/pmfw_if/smu13_driver_if_v13_0_5.h     |  1 -
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_5_ppsmc.h  | 56 +++++++++----------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  |  4 +-
 3 files changed, 29 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_5.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_5.h
index aa971412b434..f3a22642c88b 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_5.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu13_driver_if_v13_0_5.h
@@ -103,7 +103,6 @@ typedef struct {
   uint16_t ThrottlerStatus;
 
   uint16_t CurrentSocketPower;          //[mW]
-  uint16_t spare1;
 } SmuMetrics_t;
 
 //Freq in MHz
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_5_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_5_ppsmc.h
index c6238c74923a..fb483bd9e147 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_5_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_5_ppsmc.h
@@ -32,34 +32,34 @@
 #define PPSMC_Result_CmdRejectedBusy       0xFC
 
 
-// Message Definitions:
-#define PPSMC_MSG_TestMessage               1
-#define PPSMC_MSG_GetSmuVersion             2
-#define PPSMC_MSG_EnableGfxOff              3  ///< Enable GFXOFF
-#define PPSMC_MSG_DisableGfxOff             4  ///< Disable GFXOFF
-#define PPSMC_MSG_PowerDownVcn              5  ///< Power down VCN
-#define PPSMC_MSG_PowerUpVcn                6  ///< Power up VCN; VCN is power gated by default
-#define PPSMC_MSG_SetHardMinVcn             7  ///< For wireless display
-#define PPSMC_MSG_SetSoftMinGfxclk          8  ///< Set SoftMin for GFXCLK, argument is frequency in MHz
-#define PPSMC_MSG_Spare0                    9  ///< Spare
-#define PPSMC_MSG_GfxDeviceDriverReset      10 ///< Request GFX mode 2 reset
-#define PPSMC_MSG_SetDriverDramAddrHigh     11 ///< Set high 32 bits of DRAM address for Driver table transfer
-#define PPSMC_MSG_SetDriverDramAddrLow      12 ///< Set low 32 bits of DRAM address for Driver table transfer
-#define PPSMC_MSG_TransferTableSmu2Dram     13 ///< Transfer driver interface table from PMFW SRAM to DRAM
-#define PPSMC_MSG_TransferTableDram2Smu     14 ///< Transfer driver interface table from DRAM to PMFW SRAM
-#define PPSMC_MSG_GetGfxclkFrequency        15 ///< Get GFX clock frequency
-#define PPSMC_MSG_GetEnabledSmuFeatures     16 ///< Get enabled features in PMFW
-#define PPSMC_MSG_SetSoftMaxVcn             17 ///< Set soft max for VCN clocks (VCLK and DCLK)
-#define PPSMC_MSG_PowerDownJpeg             18 ///< Power down Jpeg
-#define PPSMC_MSG_PowerUpJpeg               19 ///< Power up Jpeg; VCN is power gated by default
-#define PPSMC_MSG_SetSoftMaxGfxClk          20
-#define PPSMC_MSG_SetHardMinGfxClk          21 ///< Set hard min for GFX CLK
-#define PPSMC_MSG_AllowGfxOff               22 ///< Inform PMFW of allowing GFXOFF entry
-#define PPSMC_MSG_DisallowGfxOff            23 ///< Inform PMFW of disallowing GFXOFF entry
-#define PPSMC_MSG_SetSoftMinVcn             24 ///< Set soft min for VCN clocks (VCLK and DCLK)
-#define PPSMC_MSG_GetDriverIfVersion        25 ///< Get PMFW_DRIVER_IF version
-#define PPSMC_MSG_PrepareMp1ForUnload        26 ///< Prepare PMFW for GFX driver unload
-#define PPSMC_Message_Count                 27
+#define PPSMC_MSG_TestMessage               0x01 ///< To check if PMFW is alive and responding. Requirement specified by PMFW team
+#define PPSMC_MSG_GetSmuVersion             0x02 ///< Get PMFW version
+#define PPSMC_MSG_SPARE0                    0x03 ///< SPARE
+#define PPSMC_MSG_SPARE1                    0x04 ///< SPARE
+#define PPSMC_MSG_PowerDownVcn              0x05 ///< Power down VCN
+#define PPSMC_MSG_PowerUpVcn                0x06 ///< Power up VCN; VCN is power gated by default
+#define PPSMC_MSG_SetHardMinVcn             0x07 ///< For wireless display
+#define PPSMC_MSG_SetSoftMinGfxclk          0x08 ///< Set SoftMin for GFXCLK, argument is frequency in MHz
+#define PPSMC_MSG_SPARE2                    0x09 ///< SPARE
+#define PPSMC_MSG_GfxDeviceDriverReset      0x0A ///< Request GFX mode 2 reset
+#define PPSMC_MSG_SetDriverDramAddrHigh     0x0B ///< Set high 32 bits of DRAM address for Driver table transfer
+#define PPSMC_MSG_SetDriverDramAddrLow      0x0C ///< Set low 32 bits of DRAM address for Driver table transfer
+#define PPSMC_MSG_TransferTableSmu2Dram     0x0D ///< Transfer driver interface table from PMFW SRAM to DRAM
+#define PPSMC_MSG_TransferTableDram2Smu     0x0E ///< Transfer driver interface table from DRAM to PMFW SRAM
+#define PPSMC_MSG_GetGfxclkFrequency        0x0F ///< Get GFX clock frequency
+#define PPSMC_MSG_GetEnabledSmuFeatures     0x10 ///< Get enabled features in PMFW
+#define PPSMC_MSG_SetSoftMaxVcn             0x11 ///< Set soft max for VCN clocks (VCLK and DCLK)
+#define PPSMC_MSG_PowerDownJpeg             0x12 ///< Power down Jpeg
+#define PPSMC_MSG_PowerUpJpeg               0x13 ///< Power up Jpeg; VCN is power gated by default
+#define PPSMC_MSG_SetSoftMaxGfxClk          0x14 ///< Set soft min for GFX CLK
+#define PPSMC_MSG_SetHardMinGfxClk          0x15 ///< Set hard min for GFX CLK
+#define PPSMC_MSG_AllowGfxOff               0x16 ///< Inform PMFW of allowing GFXOFF entry
+#define PPSMC_MSG_DisallowGfxOff            0x17 ///< Inform PMFW of disallowing GFXOFF entry
+#define PPSMC_MSG_SetSoftMinVcn             0x18 ///< Set soft min for VCN clocks (VCLK and DCLK)
+#define PPSMC_MSG_GetDriverIfVersion        0x19 ///< Get PMFW_DRIVER_IF version
+#define PPSMC_MSG_PrepareMp1ForUnload       0x1A ///< Prepare PMFW for GFX driver unload
+#define PPSMC_MSG_GetThermalControllerLimit 0x1B ///< Provide thermal limit
+#define PPSMC_Message_Count                 0x1C ///< Total number of PPSMC messages
 
 /** @enum Mode_Reset_e
 * Mode reset type, argument for PPSMC_MSG_GfxDeviceDriverReset
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 8ee5bcb60370..0bc15ff822a5 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -57,13 +57,11 @@
 static struct cmn2asic_msg_mapping smu_v13_0_5_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,                    PPSMC_MSG_TestMessage,			1),
 	MSG_MAP(GetSmuVersion,                  PPSMC_MSG_GetSmuVersion,		1),
-	MSG_MAP(EnableGfxOff,             PPSMC_MSG_EnableGfxOff,		1),
-	MSG_MAP(DisableGfxOff,                   PPSMC_MSG_DisableGfxOff,			1),
 	MSG_MAP(PowerDownVcn,                    PPSMC_MSG_PowerDownVcn,			1),
 	MSG_MAP(PowerUpVcn,                 PPSMC_MSG_PowerUpVcn,		1),
 	MSG_MAP(SetHardMinVcn,                   PPSMC_MSG_SetHardMinVcn,			1),
 	MSG_MAP(SetSoftMinGfxclk,                     PPSMC_MSG_SetSoftMinGfxclk,			1),
-	MSG_MAP(Spare0,                  PPSMC_MSG_Spare0,		1),
+	MSG_MAP(Spare0,                  PPSMC_MSG_SPARE0,		1),
 	MSG_MAP(GfxDeviceDriverReset,            PPSMC_MSG_GfxDeviceDriverReset,		1),
 	MSG_MAP(SetDriverDramAddrHigh,            PPSMC_MSG_SetDriverDramAddrHigh,      1),
 	MSG_MAP(SetDriverDramAddrLow,          PPSMC_MSG_SetDriverDramAddrLow,	1),
-- 
2.25.1


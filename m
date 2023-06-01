Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B8ABC77B7E
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Jun 2023 07:28:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0708310E1E3;
	Thu,  1 Jun 2023 07:28:27 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2041.outbound.protection.outlook.com [40.107.95.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D81AE10E138
 for <amd-gfx@lists.freedesktop.org>; Thu,  1 Jun 2023 07:28:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mb5jeVkmhR5osLAaFcSAfNtiD1tWKqs12Nj4bq8StC/AqhYQyHDDvdSwJBfQBaKMBa+eZ/Oc4OrJbhNLUOk1hd+We34z70j7MvElZces6b20dAsjphsXPMKj45YI67uFx6RKg9Exv/h5+LU1/vZbxr/sVvH7PYqj0OGVXO+Y62BgbPWeuYbhSx5NzZnl4SUxpLveEFgcK6XYI9IxBWU/JMVYqTUCo/O2aMjBLnSGiA5jpM3pFCgS/+qSN526hNb4mPPKI8h38uKkvtBtbfMpNjsu3LRXoekxSX6NHT/OVAnWfU5sd12z+DbKMrOiCMwG12r8jfBpeCEd9h/tWavpLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3duRcjhNlCfzbx+NWxp7IPUjeZ0NxYNDgedl5S7G/i8=;
 b=NPVkyvThOwz5MpsySa1a4d/lR2eIcA3qsiTlPjPWseelmQi56nntJU6gueqPmDUamwWfwVYu+Q9j4BrZPEMiiUf2AZckmatMHBm+5qJ5vplaHBbXH29bnIRmPZFSdJbloy6SpCOsmhQ070zR+i3MMRMXLpfflBO6uNmWdCoavYbJE4mGzm3bcYjW/DeUgUkTb7mHfBJti/uFO6orhH6TFQj+/6fZmnO/U35hxOZM48CIMQRjwYzdPAv28dAgrHObtlrY1Vkgg794LvqiwPzNl2TUpUwWPXvpx4iWCFTOFma8oSwAm6H6tyC6OvYGy81OEurn2Vw+bEXweFhVj9okUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3duRcjhNlCfzbx+NWxp7IPUjeZ0NxYNDgedl5S7G/i8=;
 b=5ZyaaMYmE9NG3/BCGraLz3iiaJhfmjVfqIfilPd1o16O+wLv2Av53pqIlu0xhzp5eNYZ6w50Hr4g6CLf1oMnwwu8XNVMibzH+9osbvMcKwcLIwuSbq1iHnKeFMM+lcfFYj62/LdZ9C7bUzncnH7+eGcO0kvL53JaN5pVKYOXF/A=
Received: from SJ0PR03CA0084.namprd03.prod.outlook.com (2603:10b6:a03:331::29)
 by PH7PR12MB8121.namprd12.prod.outlook.com (2603:10b6:510:2b5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.24; Thu, 1 Jun
 2023 07:28:21 +0000
Received: from DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
 (2603:10b6:a03:331:cafe::42) by SJ0PR03CA0084.outlook.office365.com
 (2603:10b6:a03:331::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.23 via Frontend
 Transport; Thu, 1 Jun 2023 07:28:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT052.mail.protection.outlook.com (10.13.172.111) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6455.23 via Frontend Transport; Thu, 1 Jun 2023 07:28:21 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 1 Jun
 2023 02:28:18 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 1/3] drm/amd/pm: Update SMUv13.0.6 PMFW headers
Date: Thu, 1 Jun 2023 15:28:01 +0800
Message-ID: <20230601072803.1321429-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT052:EE_|PH7PR12MB8121:EE_
X-MS-Office365-Filtering-Correlation-Id: f6e90f8d-1d7f-46f4-0441-08db6271c711
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z49WAqXEgxodNODBJ6brXvU3spiq2MVARbjeIqoqRuUIet3IOKqRhj9M2OmsUd7eaU19bhNIST3AzVAE0FOPBPW/0YMnggZVKetgl1Z8KK7KY3yG2ZaBGW+sg6o098yz9lw812cwsdtmysvKvBUyXwZ58DvwM+ZOLpqgevOrIHA82CQNt0xBOEr7oBrovIWEbJ09GlVQbqoO/Hi9nGTc+aN68+rKWyBP5siH0vAuyf9WPNh3YX0laD/o2C6W2qK4EE/V94FqLd3ud5ZW3kyuAfxVK7KwKsR7NE+xkO7COs+9wWEVNB3Ct7VEyCi5+coRNqOhL6OGk0331MOzlXAzDyMQPORuCPCrK7CrBOoIa8oEUI+zhl+qQUDRuDaN54t+Kcv8T2g+KcCGuwe24MN/4lLnwPcCfqFhLjU1kruhfTt5nlnehEGChlv8F8IZZUGFIeKzObcX42i6IhRIC06y2fEYRCpukhd2OSawLohiR1Jn0c9mvXOyt39u5B3dCfcxeIY1ja6XxdpyTVWPAGSfW99xXbGT75D0hnMKbWUbBmyCXvRGP/EQxCu724IT5gZqCh62+1hI0iys+o7SvFwdL1dW/JYstg+4dyVIJYZ/YUnft4ANyVhf6vsRpS8LPuzoW61GImCx0wPLNuSkh7Bdb11up8RcdB0thbyFdHBhqQVjM5GE2Ost8ZVhAm/x4xNPwtPJM3tfQW/RvdWg1keK/RFmkjvsc7o3yd0/72Bd8M282k66dECEtq8nER8T9/+Znlt+/EQPPxK1naUH5gsr6A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(376002)(396003)(346002)(451199021)(40470700004)(36840700001)(46966006)(82740400003)(36756003)(81166007)(356005)(86362001)(82310400005)(40480700001)(8936002)(40460700003)(8676002)(41300700001)(44832011)(1076003)(26005)(5660300002)(2906002)(16526019)(15650500001)(47076005)(186003)(6666004)(336012)(426003)(83380400001)(2616005)(70586007)(54906003)(70206006)(7696005)(316002)(19627235002)(478600001)(36860700001)(4326008)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2023 07:28:21.2883 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f6e90f8d-1d7f-46f4-0441-08db6271c711
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT052.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8121
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

v2: Added dummy definition for compilation error

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
---
 .../inc/pmfw_if/smu13_driver_if_v13_0_6.h     | 31 ++++++++++++++-----
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h   | 13 +++++---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  2 ++
 3 files changed, 35 insertions(+), 11 deletions(-)

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
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 41b49cc827cd..27fd71afc73f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -82,6 +82,8 @@
 
 #define smnPCIE_ESM_CTRL 0x111003D0
 
+#define THROTTLER_TEMP_HBM_BIT 2
+
 static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
 	MSG_MAP(GetSmuVersion,			     PPSMC_MSG_GetSmuVersion,			1),
-- 
2.34.1


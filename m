Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 789BAC001B0
	for <amd-gfx@archiver.kernel.org>; Sat, 12 Aug 2023 10:34:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C709410E051;
	Sat, 12 Aug 2023 10:34:08 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2058.outbound.protection.outlook.com [40.107.212.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D642310E051
 for <amd-gfx@lists.freedesktop.org>; Sat, 12 Aug 2023 10:34:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TgRL6SScefGVKbGQ0mehdgEkAT2ZfAFf1lL5X4ns7GqXp5E4Sw55ouaew6zfhtzfQWhvyyr4LbwOJhL85SYzi/T/WUEpqLoRxpSeKEv5kS/I/FwZRYbIIhiiF1x9Su/uA8YmX0B2TCDsNPp7Bul+GV1BWuAEYUkhW2f6KQpldutO3ROdTN0YoXBRavoq6wQwQ+PZTV2W6whJIgxSPd5FOBVfEyznJr5yd1WG/tmf4aPfzo+O3erCR6QILwUtoZp7hcUQyeODTFe9l3zyorcqeBqGMMbKhT4i0JzSl6eI32Yme+tfB1m84WBaiKAvNCSlBozhK+UEdr746TwTIGGM4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EWqbAnwByZjdif3Oy4yQVUPf9YXhbiHb2kt0X7MXVjM=;
 b=MRXKc6V4Huasku95pnzarlblZFaa9iLQCrSGYiGIGNLHs722QS3ZMSMisg3cDXEc+l1HGyM7v5V1RuEO/ashG54gEW28CNSJ6+tK9qs08vq/zI55bJttkk+7bnMpzao8kmboFQUs4bOlIze++tyHvZBs3MuS1+Of+XX7xyTH8+jxUrAG9u6ZSSP3cumCm6fUp0mn+DbjdyebKunEOeTrCoFcm8MkIpktmr2C1WbVLLGP5RFe87p+Pc35bpUV964IceTZKmoYonGbzdZEOjrt0GayFkAqQKDGmre1ZG1HhmVTpvaeehFNin3USp4LxUdI/3yRGXqA4n3f34V2sOxbvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EWqbAnwByZjdif3Oy4yQVUPf9YXhbiHb2kt0X7MXVjM=;
 b=Ew3208tOsfxaqitXZ+b0ZX+CFOPwnz1gx4/9q7vHNSDTpOJs6HDm+6wH2HvGFyV7c1iUe9SaVtV7nIX+BkaRDEZ8N0JDjtUeLjit3upMhVT2LLQWIZf647hn/0dVBNe00X5yG3g108o1BOhf/qJ8/sux0ftye99nSARJDUKarvE=
Received: from MW2PR16CA0068.namprd16.prod.outlook.com (2603:10b6:907:1::45)
 by IA0PR12MB7775.namprd12.prod.outlook.com (2603:10b6:208:431::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Sat, 12 Aug
 2023 10:34:02 +0000
Received: from CO1PEPF000042A9.namprd03.prod.outlook.com
 (2603:10b6:907:1:cafe::69) by MW2PR16CA0068.outlook.office365.com
 (2603:10b6:907:1::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.33 via Frontend
 Transport; Sat, 12 Aug 2023 10:34:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1PEPF000042A9.mail.protection.outlook.com (10.167.243.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6652.20 via Frontend Transport; Sat, 12 Aug 2023 10:34:02 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 12 Aug
 2023 05:33:59 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2 2/2] drm/amd/pm: Update pci link speed and speed format
Date: Sat, 12 Aug 2023 18:33:42 +0800
Message-ID: <20230812103342.1091608-2-asad.kamal@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230812103342.1091608-1-asad.kamal@amd.com>
References: <20230812103342.1091608-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A9:EE_|IA0PR12MB7775:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bcdfe6d-423b-4c41-8d85-08db9b1fa564
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4d/7phRfGSXFwTaFAcEeOVQklVIVbFGxLMvMXz99/ZPWokWsyESI5ZcN1o6qjNXp+vamUx4U2Rz+sEVGJlD/pfzvmOLweya+ob0IqShGi4WM6oBcZYJCNUmsk1EY/ai7anS0dnr3ClGkU1lbfkCmXMs+HmXz5Br8syTPsJ1mNoWVebSTzQyajzE7SMngXNmLwzM1DnQf1sbrDFrBqXrZH6d2kh0j6EmWW2N+qtAQjzKRVoYVFs7cvvsidjHSNG04ujdlwcwuyI1an7KaZsycmIBS314zbAq7uDK1982RYk0B0+J/+3ll3IVDEdEpoC+17UTKeTMWt150hUZdYvOqe6FkKez776zOnz5Z6is75naJ9eIJnKkPsanq5jJ57vbD4JKDcvTPjPIWi4VCCDc5LzfmXir/GE9hLx3gmT3nB5ryur1sYdnYHHporhAiy6d4yW7TeMEGyRVy/AzKkQSeIlfcZpVlmQu/w8IQxrqRTE5cLAzXesKXu8b3lcKVs43uUOLJkNDfIsVrwieBVoXE408qqTe0c/brvg7a6I63ZVlfa54yViFZBdF0t81MkBTQ992WWDHx/1E/ZOf6R2pNFc//qe26zILb7FuzrPP57EKY9YIC+MZUaLgcL8OCXVOyDTfMmUJifFs8fCSq0POd9TwXsnOJeHnPxjn16Hl4FSqW7L2fHJd+CpAB8LMnkvmI5bD6DPb+x/ki2RPJp3B98aXn+zjOmbCBt4Q7RDrINuVtYiwBsE0NAlpNDDwZKgBlxFrSCVSi2AUVfsUs0bBNDw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(396003)(346002)(39860400002)(82310400008)(451199021)(1800799006)(186006)(40470700004)(46966006)(36840700001)(26005)(5660300002)(356005)(1076003)(8936002)(8676002)(41300700001)(40460700003)(36756003)(47076005)(426003)(15650500001)(2616005)(83380400001)(2906002)(36860700001)(81166007)(16526019)(86362001)(336012)(44832011)(82740400003)(70206006)(40480700001)(54906003)(70586007)(4326008)(6916009)(6666004)(478600001)(7696005)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2023 10:34:02.2772 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bcdfe6d-423b-4c41-8d85-08db9b1fa564
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7775
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
Cc: Lijo.Lazar@amd.com, asad.kamal@amd.com, le.ma@amd.com, shiwu.zhang@amd.com,
 maisam.arif@amd.com, hawking.zhang@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

1) Update pcie link speed for smu v13_0_6 from correct register

2) Populate gpu metric table with pcie link speed rather than
   gen for smu v13_0_0, smu v13_0_6 & smu v13_0_7

v2:
Update ESM register address
Used macro to convert pcie gen to speed

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h     |  2 ++
 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c   |  1 -
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c |  7 ++++++-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c | 16 ++++++++++++++--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c |  7 ++++++-
 drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c           |  2 ++
 6 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 355c156d871a..3a03f84d3288 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -52,7 +52,9 @@
 #define CTF_OFFSET_MEM			5
 
 #define SMU_13_VCLK_SHIFT		16
+#define pci_gen_to_speed(gen)		((gen <= 0) ? link_speed[0] : link_speed[gen - 1])
 
+extern const int link_speed[];
 extern const int pmfw_decoded_link_speed[5];
 extern const int pmfw_decoded_link_width[7];
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 895cda8e6934..6863186937f7 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -83,7 +83,6 @@ MODULE_FIRMWARE("amdgpu/smu_13_0_10.bin");
 #define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0xE
 
 static const int link_width[] = {0, 1, 2, 4, 8, 12, 16};
-static const int link_speed[] = {25, 50, 80, 160};
 
 const int pmfw_decoded_link_speed[5] = {1, 2, 3, 4, 5};
 const int pmfw_decoded_link_width[7] = {0, 1, 2, 4, 8, 12, 16};
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index fddcd834bcec..164fbfbc70fb 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -96,6 +96,8 @@
  */
 #define SUPPORT_ECCTABLE_SMU_13_0_10_VERSION 0x00502200
 
+#define LINK_SPEED_MAX                          3
+
 static struct cmn2asic_msg_mapping smu_v13_0_0_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
 	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,               1),
@@ -1761,7 +1763,10 @@ static ssize_t smu_v13_0_0_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_fan_speed = metrics->AvgFanRpm;
 
 	gpu_metrics->pcie_link_width = metrics->PcieWidth;
-	gpu_metrics->pcie_link_speed = metrics->PcieRate;
+	if ((metrics->PcieRate - 1) > LINK_SPEED_MAX)
+		gpu_metrics->pcie_link_speed = pci_gen_to_speed(1);
+	else
+		gpu_metrics->pcie_link_speed = pci_gen_to_speed(metrics->PcieRate);
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index 2572dc210739..a8e90a1e6ed9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -80,12 +80,17 @@
 /* possible frequency drift (1Mhz) */
 #define EPSILON 1
 
-#define smnPCIE_ESM_CTRL 0x193D0
+#define smnPCIE_ESM_CTRL 0x93D0
 #define smnPCIE_LC_LINK_WIDTH_CNTL 0x1a340288
 #define PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD_MASK 0x00000070L
 #define PCIE_LC_LINK_WIDTH_CNTL__LC_LINK_WIDTH_RD__SHIFT 0x4
 #define MAX_LINK_WIDTH 6
 
+#define smnPCIE_LC_SPEED_CNTL                   0x1a340290
+#define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK 0xE0
+#define PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT 0x5
+#define LINK_SPEED_MAX				4
+
 static const struct cmn2asic_msg_mapping smu_v13_0_6_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			     PPSMC_MSG_TestMessage,			0),
 	MSG_MAP(GetSmuVersion,			     PPSMC_MSG_GetSmuVersion,			1),
@@ -1923,6 +1928,7 @@ smu_v13_0_6_get_current_pcie_link_width_level(struct smu_context *smu)
 static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
 {
 	struct amdgpu_device *adev = smu->adev;
+	uint32_t speed_level;
 	uint32_t esm_ctrl;
 
 	/* TODO: confirm this on real target */
@@ -1930,7 +1936,13 @@ static int smu_v13_0_6_get_current_pcie_link_speed(struct smu_context *smu)
 	if ((esm_ctrl >> 15) & 0x1FFFF)
 		return (((esm_ctrl >> 8) & 0x3F) + 128);
 
-	return smu_v13_0_get_current_pcie_link_speed(smu);
+	speed_level = (RREG32_PCIE(smnPCIE_LC_SPEED_CNTL) &
+		PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE_MASK)
+		>> PCIE_LC_SPEED_CNTL__LC_CURRENT_DATA_RATE__SHIFT;
+	if (speed_level > LINK_SPEED_MAX)
+		speed_level = 0;
+
+	return pci_gen_to_speed(speed_level + 1);
 }
 
 static ssize_t smu_v13_0_6_get_gpu_metrics(struct smu_context *smu, void **table)
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index b43c5d13f8d9..915e57d3afa3 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -72,6 +72,8 @@
 
 #define MP0_MP1_DATA_REGION_SIZE_COMBOPPTABLE	0x4000
 
+#define LINK_SPEED_MAX                          3
+
 static struct cmn2asic_msg_mapping smu_v13_0_7_message_map[SMU_MSG_MAX_COUNT] = {
 	MSG_MAP(TestMessage,			PPSMC_MSG_TestMessage,                 1),
 	MSG_MAP(GetSmuVersion,			PPSMC_MSG_GetSmuVersion,               1),
@@ -1741,7 +1743,10 @@ static ssize_t smu_v13_0_7_get_gpu_metrics(struct smu_context *smu,
 	gpu_metrics->current_fan_speed = metrics->AvgFanRpm;
 
 	gpu_metrics->pcie_link_width = metrics->PcieWidth;
-	gpu_metrics->pcie_link_speed = metrics->PcieRate;
+	if ((metrics->PcieRate - 1) > LINK_SPEED_MAX)
+		gpu_metrics->pcie_link_speed = pci_gen_to_speed(1);
+	else
+		gpu_metrics->pcie_link_speed = pci_gen_to_speed(metrics->PcieRate);
 
 	gpu_metrics->system_clock_counter = ktime_get_boottime_ns();
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
index 442d267088bc..c1d377e58b3e 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu_cmn.c
@@ -39,6 +39,8 @@
 
 #define MP1_C2PMSG_90__CONTENT_MASK                                                                    0xFFFFFFFFL
 
+const int link_speed[] = {25, 50, 80, 160, 320};
+
 #undef __SMU_DUMMY_MAP
 #define __SMU_DUMMY_MAP(type)	#type
 static const char * const __smu_message_names[] = {
-- 
2.34.1


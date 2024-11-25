Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0D4D58D54
	for <amd-gfx@archiver.kernel.org>; Mon, 25 Nov 2024 14:38:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DCBA10E66E;
	Mon, 25 Nov 2024 14:38:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Zv7JXflS";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2058.outbound.protection.outlook.com [40.107.237.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C92B110E66F
 for <amd-gfx@lists.freedesktop.org>; Mon, 25 Nov 2024 14:38:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mKJwlZB1umgkijlfRJE08GxH4b/0KQbcLXtmy5+g9qjaMgHhdj4YcNC3yiQU7cE3Ou0VmkoOlX5Mag6/wba8Kht0QfiiTQVY0fTVVDn0hNnmVXI58mIMjelM5V5hDeE0453Vs10PkZiMHGEB4hlxZKKY+UWrWWd8jCoQTfj9Hp2GPjRcQNempsOg+DBfvVJfcZ+EVnZHYrhH8prd35a0fpqcwIAHsPZMXYWNaFgfxvvji/E1gw3a5hvCfdVsVxhHo10T+uRd3JT0fKG760dqXO1fxIP3szeriLafscnxIGc/gqPbgTqsFEuuTZTzTTIEtohth3SuoYpm/5S99jBzaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gCOxAw7i9G28u8vv8gU+LHap6/vTtL6dGAARUiMMWUA=;
 b=fNC+rTpNCvS/PVK0h1g0hGmOuvgNcf3mOqyeaj2wDeWGEzUod6rdFgJuGwCK2bTGlJCgo9gK/3Pb/PRZbd4tUeEXeY8X30vmVlKcqzFJ5KFDSX1RYlX8eyoMPH3H0WH9O8xK985qDTD7R+cDGBVDj4hero11OZl5x9gBEyqrKjemshpC73c6rXAGTli65fCUa8y5eiHdZR3WVxVym+YnGZfe+mPZNfHu5HMa03mwg7j3D7p+p44DO/vExR+IoZH3DHcBd15TZRajOI1kDqPpSvk+4Tj/wQbM3MZCesf3aLeQZrGkhlxWlxvQaXGKLPIYaLgoSIbbpZrW4iwgAZOY3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gCOxAw7i9G28u8vv8gU+LHap6/vTtL6dGAARUiMMWUA=;
 b=Zv7JXflSfcmyCZzN81sKB2+miOndP4GakaFXFQj13x9MBtdZ+DGDdCIeMuCMxxbbSkKDj+5cOw0YgOCNVhNMQSLv83vz2FBi0PPubNaJxpwSjbJRC7QwNgUiGDNCeSmX1dE4ulmQl5Uajbtqkmq2A5pEQRBzsf3BmATUMqYB9mI=
Received: from CY5PR15CA0059.namprd15.prod.outlook.com (2603:10b6:930:1b::28)
 by MN2PR12MB4374.namprd12.prod.outlook.com (2603:10b6:208:266::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.21; Mon, 25 Nov
 2024 14:38:43 +0000
Received: from MWH0EPF000971E9.namprd02.prod.outlook.com
 (2603:10b6:930:1b:cafe::83) by CY5PR15CA0059.outlook.office365.com
 (2603:10b6:930:1b::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.19 via Frontend
 Transport; Mon, 25 Nov 2024 14:38:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MWH0EPF000971E9.mail.protection.outlook.com (10.167.243.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8182.16 via Frontend Transport; Mon, 25 Nov 2024 14:38:42 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 25 Nov
 2024 08:38:39 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <charis.poag@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>
Subject: [PATCH 1/2] drm/amd/pm: Update SMUv13.0.6 PMFW headers
Date: Mon, 25 Nov 2024 22:38:25 +0800
Message-ID: <20241125143826.2022148-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E9:EE_|MN2PR12MB4374:EE_
X-MS-Office365-Filtering-Correlation-Id: ac65125a-2581-4f5c-37a7-08dd0d5edc49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pogNhAJR2Bg5s/3XfrawLLbVv2Qgs05wr1UZ3rZjoabCw4t59xhnGWA3K7sM?=
 =?us-ascii?Q?k2c8hVA36IrqvEiN++QJikx5Iwig4kX6RlTZsqc/7gWO1fzSpLJjltOP4bbv?=
 =?us-ascii?Q?xdP2K26nye0Xqk5Si6ssmtMxlskQFbS4Mg6xX07BsUXA7sMFk5G4PMS3q3BB?=
 =?us-ascii?Q?JQlG93JgnlAMVs1uQyCUV9GqFxymrHzFBFdBoZIVutq8cZZcnbPAe9x1WcZ3?=
 =?us-ascii?Q?y4EE9/MYvyD84qMwxPHQ8cPHuukIRBwMfP7yVZv0iXzRmD4+NBt/TnbCCbft?=
 =?us-ascii?Q?AeFnwpVS7DiM7ZcpYhyBhPO8YSoGVIFykHsz6gA2DFppZiUjLN9WFIYy/xYU?=
 =?us-ascii?Q?MGSuHPwn5/AGxzY9w7u1w4WI78XiMlGRo2ocjc8zWGmHi89l+8wWyogFXm+a?=
 =?us-ascii?Q?N1exSP5aZF3psPCXifuqGp0jJDs9Nt/KOV4sf5/GmtBaVQ6KVoFJXSQ1+QwU?=
 =?us-ascii?Q?b968mRT4BJnGgpnBTwROCowdDZ6/VtniWGZ/mbNvhLdf5L8Zs0WGig5brARn?=
 =?us-ascii?Q?oiRCahkli/X91PAt0Ap7Iv7ADKfL1qWACsTX53CDYfDwbqTsy2ETvxw3SyO4?=
 =?us-ascii?Q?mHOQQfxkFzDrqsEgsPiZLGfjlLL2cPEEN1F5Sne7IOtm7mpSc73oS4J/Ju1x?=
 =?us-ascii?Q?OcfczQmQ76CgRIQ14Cp194LO/lUpK+Y+ZvxghVIfhN+dIg+e0of/CXNqR1xp?=
 =?us-ascii?Q?oViOmNC33Gn09D4zCVFjZtJiMI+y2xBoZHw3BdF7R0oqatREizo8wviml9gL?=
 =?us-ascii?Q?BB5dslx4XO8zqKsGV0Jk5QO6LPVnJKR81n8sDM9tA8ogpHmHKiIu3TGP43mg?=
 =?us-ascii?Q?LUEn5tuVBDfh+wnbSup4RFJ3wKPQ1X7gDqyYAcA2NQm8mEb9KSajG7iMlUy8?=
 =?us-ascii?Q?EJTN1PuU1VxYFC/g/IeNLwjAknO9cHHS0AIJnJQuG3EntY1pIaMcteI432yn?=
 =?us-ascii?Q?SsHpklx7J9J/C1UWdKUEu2iywCq1Rzg8yzjtukedh+DRnVr9WrHQ8l/7lHhx?=
 =?us-ascii?Q?mhD/bpdgFZr23chfOP6ZoY++gtCXM4VHxCZR/VuZRVwG7GTZTz4fgsyulXkW?=
 =?us-ascii?Q?6jSlH0U4WfliyjBONG2HjBPtms8Km9W8GRg92L9VMvwyfAgPXc/pd+OBA+gL?=
 =?us-ascii?Q?ti+S5XLEDs0+FmMy9OyuJSyCGcJ35IuK2fOCn3b/9YWnXLSdccva88FSuKYe?=
 =?us-ascii?Q?frBcF4LMNmeqG/xE9FHB+pCsyNLDKYaojZ7rh/MDibZHwGL7WVrWw1MncN1v?=
 =?us-ascii?Q?5psz+NVz1z06TiICWsFhj+UvYqk+GzZwrLuZzF0HybKVc1tvmNwoyu1IW8Zu?=
 =?us-ascii?Q?mmuyufprSGuxjRlCfotSYVUAH8uLym5u3zKgBEnVONuydmjyU24cViOv7q8+?=
 =?us-ascii?Q?iiCZQV7MWqBP8g/EwBpqqRBg1cnWVh6Pg9XPtPanOK3fuTiwcAp3rOjh7HW6?=
 =?us-ascii?Q?ObDravF7YzFeMcyIpUTeQxVGUdUdQug7?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2024 14:38:42.8632 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac65125a-2581-4f5c-37a7-08dd0d5edc49
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E9.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4374
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

Update pmfw headers for smuv13.0.6 to pmfw version 85.121

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h    | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
index 0f96b8c59a0e..8af827402e74 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
@@ -34,6 +34,8 @@
 #define NUM_PCIE_BITRATES     4
 #define NUM_XGMI_BITRATES     4
 #define NUM_XGMI_WIDTHS       3
+#define NUM_SOC_P2S_TABLES    3
+#define NUM_TDP_GROUPS        4
 
 typedef enum {
 /*0*/   FEATURE_DATA_CALCULATION            = 0,
@@ -80,8 +82,10 @@ typedef enum {
 /*41*/  FEATURE_CXL_QOS                     = 41,
 /*42*/  FEATURE_SOC_DC_RTC                  = 42,
 /*43*/  FEATURE_GFX_DC_RTC                  = 43,
+/*44*/  FEATURE_DVM_MIN_PSM                 = 44,
+/*45*/  FEATURE_PRC                         = 45,
 
-/*44*/  NUM_FEATURES                        = 44
+/*46*/  NUM_FEATURES                        = 46
 } FEATURE_LIST_e;
 
 //enum for MPIO PCIe gen speed msgs
@@ -123,7 +127,7 @@ typedef enum {
   VOLTAGE_GUARDBAND_COUNT
 } GFX_GUARDBAND_e;
 
-#define SMU_METRICS_TABLE_VERSION 0xE
+#define SMU_METRICS_TABLE_VERSION 0xF
 
 typedef struct __attribute__((packed, aligned(4))) {
   uint32_t AccumulationCounter;
@@ -234,6 +238,9 @@ typedef struct __attribute__((packed, aligned(4))) {
 
   //PCIE BW Data and error count
   uint32_t PCIeOtherEndRecoveryAcc;       // The Pcie counter itself is accumulated
+
+  //NVML-Parity: Total App Clock Counter
+  uint64_t GfxclkBelowHostLimitAcc[8];
 } MetricsTableX_t;
 
 typedef struct __attribute__((packed, aligned(4))) {
@@ -328,13 +335,14 @@ typedef struct __attribute__((packed, aligned(4))) {
   uint32_t JpegBusy[32];
 } MetricsTableA_t;
 
-#define SMU_VF_METRICS_TABLE_VERSION 0x3
+#define SMU_VF_METRICS_TABLE_VERSION 0x5
 
 typedef struct __attribute__((packed, aligned(4))) {
   uint32_t AccumulationCounter;
   uint32_t InstGfxclk_TargFreq;
   uint64_t AccGfxclk_TargFreq;
   uint64_t AccGfxRsmuDpm_Busy;
+  uint64_t AccGfxclkBelowHostLimit;
 } VfMetricsTable_t;
 
 #endif
-- 
2.46.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72ACAC02181
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Jan 2025 09:56:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E40010E38B;
	Wed, 22 Jan 2025 09:56:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="kwVgVRpK";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE50810E38B
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Jan 2025 09:56:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DQNmJrv9RiWlo5NroNWNrUq5WSdnCpBskLFd25YqgiTLSyIksn8+2jOT26o8kauDUYnEXe2PstbNoV1SjCtYG8JjLBZqjLUGahmVZpTlkV7RAOGo9aD3o2lvM3TskVm/YoAzGeAjTg3Yzn4iRwMX5xZzusMjNwjf2+acfx5AtAM+opgxDdVLtUSD8ANnkcqvxrpE4ZG+DzUmPKpfa0xF5i8ergb3rmpJ7Pn5Be16LZavZQ+17oxetaFKJgqSfv7699JSrHBm/PRWuBXyFn43knjTvEX0UDoFDJLgYg10hIyVh9LIU7hmsz5qTbm4DV0sVwuVf1fc2O1g9P4HhcO2lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2g1zadqiXqHHgin+AZk1HOBMRiyyfVIZb4tZiiG57IY=;
 b=C05OrtPYC98+5VsPY5/gA8sZmscbx3qB8CZHqWrmnruYCyn5h0vOjVfTF8OObFQEcv0kDP/Xg8X2epdSZCXXJxSYJoKkJhcR1OtHWURKfwOYbQnu5sVvVkSZ7oaMwsok5PQLJzm/777fUPuvU1LMUHF8q+GHuR6kXnse/FALyR/Zr1/UX5/zsGQ1/ZAz2HNL3hBZb7N5pDFl1RJFSTD4oDyS/1CjshL8VzDBwhmuQexXKL4vgIvFbZ+eO9wCx7hTthRiGGeKaQM4xNuLa4NTZqd+/dwQH79ovvxvfvKqyz8w0OI9spqqsFN88mT320gfG1O8y4h//efVRjLKHW4efA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2g1zadqiXqHHgin+AZk1HOBMRiyyfVIZb4tZiiG57IY=;
 b=kwVgVRpKZlRNas8XlIfO1eWRu06pPWA6jfnVUUdyH+9NgqLIU+yLiCCiFRdOProakdPId0zSodjcNCbj07KuY5r+Gpn/pFuMZeBdujMqiUUVqyXUlX0hd51aWD0CYmdzhg03bgAHa8q+bQa2rwsXhANIQYvfHItEoCcrKqTjLI4=
Received: from DM6PR06CA0093.namprd06.prod.outlook.com (2603:10b6:5:336::26)
 by PH7PR12MB6979.namprd12.prod.outlook.com (2603:10b6:510:1b9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Wed, 22 Jan
 2025 09:56:19 +0000
Received: from DS1PEPF0001709C.namprd05.prod.outlook.com
 (2603:10b6:5:336:cafe::30) by DM6PR06CA0093.outlook.office365.com
 (2603:10b6:5:336::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8377.14 via Frontend Transport; Wed,
 22 Jan 2025 09:56:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001709C.mail.protection.outlook.com (10.167.18.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8377.8 via Frontend Transport; Wed, 22 Jan 2025 09:56:19 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 22 Jan
 2025 03:56:16 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH v2 3/6] drm/amd/pm: Add SMUv13.0.12 PPT interface
Date: Wed, 22 Jan 2025 17:55:40 +0800
Message-ID: <20250122095543.148993-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250122095543.148993-1-asad.kamal@amd.com>
References: <20250122095543.148993-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709C:EE_|PH7PR12MB6979:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f271dce-56d1-477a-3439-08dd3acb0519
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WQiysw05jJiCy89WOVqrd9VWcBr01UwyD2G98N7dMn2uxd8oR8i2aU6AgTxy?=
 =?us-ascii?Q?OR9v2UUFaOlLkE9nRJrJveYeeUfYPpkd0AwBoymcCkTloC0/Qoerh//FnDce?=
 =?us-ascii?Q?x7qIc3traMXa/SD6/cC8Dd3sZ/6ieqfqsT3S2JB3i0algsngwJjS6xnWPZRq?=
 =?us-ascii?Q?aSB8R2WFeEI8/xbaqeScELSdryODc7l/w54rZ0YcMbQ31/Z8ej9mlJt7wDfR?=
 =?us-ascii?Q?erU2c+NSESGtI4yOu1mnwcWZFxZD6HnD1flnfvFRnd9FDgKvifMtsWlqtod8?=
 =?us-ascii?Q?mVpCGOAHMvkFwi1sFNMSNBFU0IwRfaHsPv1tbSCA3OaC6/QLgVltk1Fej3AL?=
 =?us-ascii?Q?fvEB+Q93uavTOkNq6ogM28S/oXdEm48r1nZxj+IxjLvPvD/k7sz2DnWuqn5W?=
 =?us-ascii?Q?5obsOj5dOV8EKGMEBoIP6kHsauR3bWDp4AlqdnSCF1LQpVTuLum+NVrlQ4Oz?=
 =?us-ascii?Q?QprrXbgXuz0Ao68v1eiYRkSPqtbf2Co8FyTOVTNVCPFJVbS3d9Q6o1wSwHZf?=
 =?us-ascii?Q?nr/1avNkKd9lSMaF/sJc/+BSVpKmt9brIJZbjWKAH74vG22XNwoxH6eOec+e?=
 =?us-ascii?Q?K0EgM7YNodzr0Tdp49VhCI/7gWQ5azWN86/xce08qLgP9qEl9SOyQm43Pk7h?=
 =?us-ascii?Q?LBG3eY3e+vOuKbuCe8AuoU3t3J41UvJUHVPYRioeyy3ihhZ8NL1Ram58ZQ+W?=
 =?us-ascii?Q?XsbCK0dSJAczKqLrduTKmf9HxqfEU0gnrE7yBTu0b3ONP0bP229/MqrmK+RJ?=
 =?us-ascii?Q?kWXpj0XAnBAQfWBd1gf5uD5/eN9EqYWVa1X0BI0YlQRaeJuhAoJGHVoVSmEl?=
 =?us-ascii?Q?yF0sW1/vwdnSNuMsWgMvTXd7lizckLbOdFrejoNhBaiAerXMThSRm9sGj1N+?=
 =?us-ascii?Q?LHewpoHrewJdzWUQU/6DGlnmHGfAtEbwSH9s5OzAbthmiFUit3+FNZ6syRFx?=
 =?us-ascii?Q?BLYkvpXFE82M5wOHu3bhvm/HNzOMcQMqiIo2sRB+DiaSuFo6M/aFGMLpdBLo?=
 =?us-ascii?Q?dcPK0uS+huNMbvnCD7PrfMjIfbL7y7wmoDpa9yzOSQSakD0au0zCkWsghLCe?=
 =?us-ascii?Q?ZdLdBda3oDoL9uznZN4HUcUPgf8dASV1IMXeBwubqtO/ZBzMqDDTVs8VHCFL?=
 =?us-ascii?Q?ogYknk8k5Jfq50nohkcPOJW/0TV4TzZyJqrQBgekqPRe/iNUJFtvE6B+5g2Q?=
 =?us-ascii?Q?vVSNXGUM4TbE7oCIgGajCPZreok5/WEoWV1eGlgjBPtS9pIRjnqPR5jedg+N?=
 =?us-ascii?Q?eerNybo+Z7t0qF5UYXVNjefqtJgMErzMqEakTbqGyN32xxzwlaWuk3gu66vc?=
 =?us-ascii?Q?bH9lTVNuf8rhafqikgt9ygaZTNka8qZSPFrwudzC3K5ml+fc6uXgsBTULtwU?=
 =?us-ascii?Q?A3Aky9nqB0s2SXxWstoU7q7QxAdsvZ8rGINq3dzMTKA5iGJpsm0g44EuM2es?=
 =?us-ascii?Q?71zXCPegJTZtEgdy80dMJSPHz+zKn4qI9eu/RGp4nObetNwiIbL+zQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2025 09:56:19.3694 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f271dce-56d1-477a-3439-08dd3acb0519
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001709C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6979
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

Add SMUv13.0.12 PPT interface to fetch dpm features

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h  | 138 ++++++++++++++++++
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |   2 +
 drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile   |   2 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c | 101 +++++++++++++
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |   6 +-
 5 files changed, 247 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
new file mode 100644
index 000000000000..4a1256d29d62
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
@@ -0,0 +1,138 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+#ifndef SMU_13_0_12_PMFW_H
+#define SMU_13_0_12_PMFW_H
+
+#define NUM_VCLK_DPM_LEVELS   4
+#define NUM_DCLK_DPM_LEVELS   4
+#define NUM_SOCCLK_DPM_LEVELS 4
+#define NUM_LCLK_DPM_LEVELS   4
+#define NUM_UCLK_DPM_LEVELS   4
+#define NUM_FCLK_DPM_LEVELS   4
+#define NUM_XGMI_DPM_LEVELS   2
+#define NUM_CXL_BITRATES      4
+#define NUM_PCIE_BITRATES     4
+#define NUM_XGMI_BITRATES     4
+#define NUM_XGMI_WIDTHS       3
+#define NUM_TDP_GROUPS        4
+#define NUM_SOC_P2S_TABLES    6
+#define NUM_GFX_P2S_TABLES    8
+#define NUM_PSM_DIDT_THRESHOLDS 3
+
+typedef enum {
+/*0*/   FEATURE_DATA_CALCULATION            = 0,
+/*1*/   FEATURE_DPM_FCLK                    = 1,
+/*2*/   FEATURE_DPM_GFXCLK                  = 2,
+/*3*/   FEATURE_DPM_LCLK                    = 3,
+/*4*/   FEATURE_DPM_SOCCLK                  = 4,
+/*5*/   FEATURE_DPM_UCLK                    = 5,
+/*6*/   FEATURE_DPM_VCN                     = 6,
+/*7*/   FEATURE_DPM_XGMI                    = 7,
+/*8*/   FEATURE_DS_FCLK                     = 8,
+/*9*/   FEATURE_DS_GFXCLK                   = 9,
+/*10*/  FEATURE_DS_LCLK                     = 10,
+/*11*/  FEATURE_DS_MP0CLK                   = 11,
+/*12*/  FEATURE_DS_MP1CLK                   = 12,
+/*13*/  FEATURE_DS_MPIOCLK                  = 13,
+/*14*/  FEATURE_DS_SOCCLK                   = 14,
+/*15*/  FEATURE_DS_VCN                      = 15,
+/*16*/  FEATURE_APCC_DFLL                   = 16,
+/*17*/  FEATURE_APCC_PLUS                   = 17,
+/*18*/  FEATURE_PPT                         = 18,
+/*19*/  FEATURE_TDC                         = 19,
+/*20*/  FEATURE_THERMAL                     = 20,
+/*21*/  FEATURE_SOC_PCC                     = 21,
+/*22*/  FEATURE_PROCHOT                     = 22,
+/*23*/  FEATURE_FDD_AID_HBM                 = 23,
+/*24*/  FEATURE_FDD_AID_SOC                 = 24,
+/*25*/  FEATURE_FDD_XCD_EDC                 = 25,
+/*26*/  FEATURE_FDD_XCD_XVMIN               = 26,
+/*27*/  FEATURE_FW_CTF                      = 27,
+/*28*/  FEATURE_SMU_CG                      = 28,
+/*29*/  FEATURE_PSI7                        = 29,
+/*30*/  FEATURE_XGMI_PER_LINK_PWR_DOWN      = 30,
+/*31*/  FEATURE_SOC_DC_RTC                  = 31,
+/*32*/  FEATURE_GFX_DC_RTC                  = 32,
+/*33*/  FEATURE_DVM_MIN_PSM                 = 33,
+/*34*/  FEATURE_PRC                         = 34,
+/*35*/  FEATURE_PSM_SQ_THROTTLER            = 35,
+/*36*/  FEATURE_PIT                         = 36,
+/*37*/  FEATURE_DVO                         = 37,
+/*38*/  FEATURE_XVMINORPSM_CLKSTOP_DS       = 38,
+
+/*39*/  NUM_FEATURES                        = 39
+} FEATURE_LIST_e;
+
+//enum for MPIO PCIe gen speed msgs
+typedef enum {
+  PCIE_LINK_SPEED_INDEX_TABLE_GEN1,
+  PCIE_LINK_SPEED_INDEX_TABLE_GEN2,
+  PCIE_LINK_SPEED_INDEX_TABLE_GEN3,
+  PCIE_LINK_SPEED_INDEX_TABLE_GEN4,
+  PCIE_LINK_SPEED_INDEX_TABLE_GEN4_ESM,
+  PCIE_LINK_SPEED_INDEX_TABLE_GEN5,
+  PCIE_LINK_SPEED_INDEX_TABLE_COUNT
+} PCIE_LINK_SPEED_INDEX_TABLE_e;
+
+typedef enum {
+  GFX_GUARDBAND_OFFSET_0,
+  GFX_GUARDBAND_OFFSET_1,
+  GFX_GUARDBAND_OFFSET_2,
+  GFX_GUARDBAND_OFFSET_3,
+  GFX_GUARDBAND_OFFSET_4,
+  GFX_GUARDBAND_OFFSET_5,
+  GFX_GUARDBAND_OFFSET_6,
+  GFX_GUARDBAND_OFFSET_7,
+  GFX_GUARDBAND_OFFSET_COUNT
+} GFX_GUARDBAND_OFFSET_e;
+
+typedef enum {
+  GFX_DVM_MARGINHI_0,
+  GFX_DVM_MARGINHI_1,
+  GFX_DVM_MARGINHI_2,
+  GFX_DVM_MARGINHI_3,
+  GFX_DVM_MARGINHI_4,
+  GFX_DVM_MARGINHI_5,
+  GFX_DVM_MARGINHI_6,
+  GFX_DVM_MARGINHI_7,
+  GFX_DVM_MARGINLO_0,
+  GFX_DVM_MARGINLO_1,
+  GFX_DVM_MARGINLO_2,
+  GFX_DVM_MARGINLO_3,
+  GFX_DVM_MARGINLO_4,
+  GFX_DVM_MARGINLO_5,
+  GFX_DVM_MARGINLO_6,
+  GFX_DVM_MARGINLO_7,
+  GFX_DVM_MARGIN_COUNT
+} GFX_DVM_MARGIN_e;
+
+#define SMU_VF_METRICS_TABLE_VERSION 0x3
+
+typedef struct __attribute__((packed, aligned(4))) {
+  uint32_t AccumulationCounter;
+  uint32_t InstGfxclk_TargFreq;
+  uint64_t AccGfxclk_TargFreq;
+  uint64_t AccGfxRsmuDpm_Busy;
+} VfMetricsTable_t;
+
+#endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 8d4a96e23326..31166974746f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -306,5 +306,7 @@ int smu_v13_0_get_boot_freq_by_index(struct smu_context *smu,
 				     uint32_t *value);
 
 void smu_v13_0_interrupt_work(struct smu_context *smu);
+bool smu_v13_0_12_is_dpm_running(struct smu_context *smu);
+extern const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[];
 #endif
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile b/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
index 7f3493b6c53c..51f1fa9789ab 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/Makefile
@@ -24,7 +24,7 @@
 # It provides the smu management services for the driver.
 
 SMU13_MGR = smu_v13_0.o aldebaran_ppt.o yellow_carp_ppt.o smu_v13_0_0_ppt.o smu_v13_0_4_ppt.o \
-	    smu_v13_0_5_ppt.o smu_v13_0_7_ppt.o smu_v13_0_6_ppt.o
+	    smu_v13_0_5_ppt.o smu_v13_0_7_ppt.o smu_v13_0_6_ppt.o smu_v13_0_12_ppt.o
 
 AMD_SWSMU_SMU13MGR = $(addprefix $(AMD_SWSMU_PATH)/smu13/,$(SMU13_MGR))
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
new file mode 100644
index 000000000000..86852e738837
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_12_ppt.c
@@ -0,0 +1,101 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ */
+
+#define SWSMU_CODE_LAYER_L2
+
+#include <linux/firmware.h>
+#include "amdgpu.h"
+#include "amdgpu_smu.h"
+#include "smu_v13_0_12_pmfw.h"
+#include "smu_v13_0_6_ppt.h"
+#include "smu_v13_0.h"
+#include "amdgpu_xgmi.h"
+#include <linux/pci.h>
+#include "smu_cmn.h"
+
+#undef MP1_Public
+#undef smnMP1_FIRMWARE_FLAGS
+
+/*
+ * DO NOT use these for err/warn/info/debug messages.
+ * Use dev_err, dev_warn, dev_info and dev_dbg instead.
+ * They are more MGPU friendly.
+ */
+#undef pr_err
+#undef pr_warn
+#undef pr_info
+#undef pr_debug
+
+#define SMU_13_0_12_FEA_MAP(smu_feature, smu_13_0_12_feature)                    \
+	[smu_feature] = { 1, (smu_13_0_12_feature) }
+
+#define FEATURE_MASK(feature) (1ULL << feature)
+#define SMC_DPM_FEATURE                                                        \
+	(FEATURE_MASK(FEATURE_DATA_CALCULATION) |                              \
+	 FEATURE_MASK(FEATURE_DPM_GFXCLK) | FEATURE_MASK(FEATURE_DPM_FCLK))
+
+const struct cmn2asic_mapping smu_v13_0_12_feature_mask_map[SMU_FEATURE_COUNT] = {
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DATA_CALCULATIONS_BIT, 		FEATURE_DATA_CALCULATION),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DPM_GFXCLK_BIT, 		FEATURE_DPM_GFXCLK),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DPM_FCLK_BIT, 			FEATURE_DPM_FCLK),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DS_GFXCLK_BIT, 			FEATURE_DS_GFXCLK),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DS_SOCCLK_BIT, 			FEATURE_DS_SOCCLK),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DS_LCLK_BIT, 			FEATURE_DS_LCLK),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_DS_FCLK_BIT, 			FEATURE_DS_FCLK),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_PPT_BIT, 			FEATURE_PPT),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_TDC_BIT, 			FEATURE_TDC),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_APCC_DFLL_BIT, 			FEATURE_APCC_DFLL),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_MP1_CG_BIT, 			FEATURE_SMU_CG),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_FW_CTF_BIT, 			FEATURE_FW_CTF),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_THERMAL_BIT, 			FEATURE_THERMAL),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_SOC_PCC_BIT, 			FEATURE_SOC_PCC),
+	SMU_13_0_12_FEA_MAP(SMU_FEATURE_XGMI_PER_LINK_PWR_DWN_BIT,	FEATURE_XGMI_PER_LINK_PWR_DOWN),
+};
+
+static int smu_v13_0_12_get_enabled_mask(struct smu_context *smu,
+					 uint64_t *feature_mask)
+{
+	int ret;
+
+	ret = smu_cmn_get_enabled_mask(smu, feature_mask);
+
+	if (ret == -EIO) {
+		*feature_mask = 0;
+		ret = 0;
+	}
+
+	return ret;
+}
+
+bool smu_v13_0_12_is_dpm_running(struct smu_context *smu)
+{
+	int ret;
+	uint64_t feature_enabled;
+
+	ret = smu_v13_0_12_get_enabled_mask(smu, &feature_enabled);
+
+	if (ret)
+		return false;
+
+	return !!(feature_enabled & SMC_DPM_FEATURE);
+}
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
index dbfab5d503b5..d4a159bb5a65 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c
@@ -2193,6 +2193,9 @@ static bool smu_v13_0_6_is_dpm_running(struct smu_context *smu)
 	int ret;
 	uint64_t feature_enabled;
 
+	if (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12))
+		return smu_v13_0_12_is_dpm_running(smu);
+
 	ret = smu_v13_0_6_get_enabled_mask(smu, &feature_enabled);
 
 	if (ret)
@@ -3564,7 +3567,8 @@ void smu_v13_0_6_set_ppt_funcs(struct smu_context *smu)
 	smu->ppt_funcs = &smu_v13_0_6_ppt_funcs;
 	smu->message_map = smu_v13_0_6_message_map;
 	smu->clock_map = smu_v13_0_6_clk_map;
-	smu->feature_map = smu_v13_0_6_feature_mask_map;
+	smu->feature_map = (amdgpu_ip_version(smu->adev, MP1_HWIP, 0) == IP_VERSION(13, 0, 12)) ?
+		smu_v13_0_12_feature_mask_map : smu_v13_0_6_feature_mask_map;
 	smu->table_map = smu_v13_0_6_table_map;
 	smu->smc_driver_if_version = SMU13_0_6_DRIVER_IF_VERSION;
 	smu->smc_fw_caps |= SMU_FW_CAP_RAS_PRI;
-- 
2.46.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2092DE77188
	for <amd-gfx@archiver.kernel.org>; Thu, 26 Dec 2024 08:33:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 48E0210E7CD;
	Thu, 26 Dec 2024 08:33:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wZPhPMEn";
	dkim-atps=neutral
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A9A8A10E7CD
 for <amd-gfx@lists.freedesktop.org>; Thu, 26 Dec 2024 08:33:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IQlIjm0QP/lc5+3wc39IMT+n/UxcAVAXyemGb3/rZ/ayLTwGXq5MR7s/nHP0q4jAUdcNSEeBoJ7etezOyvb//1GdUBesjDDNN7HZFFdDirTh3Bs12noKJgdRG5tT+ArsVd79Y5TFb7INyBX/G4KQJ0aHiGlSZtKf0q/Fglx6DmxUlX/qkJX+QN4vjcr5MhHVKhH8ujkljrxL1NFpvmGJvPALTU0/ahF1fzUnjuAud757wbWrZQHo8Axd5f2lwhmfbue9HWOVPIqhamdchUtR7b+NtTdOoH2PHcjHazBgM2JtDRvCzFogE4od2k8bBqOmh/0g2baousSTLmsSKVQLYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QUErobHl0+US96cJWuQbs44Hv6mGf+Zx6PhBESB331Y=;
 b=YL7fSlnrusOKQwIi/YDq2sbf98pHpdKM1I+aglPtCyYGSJlfS51n/O3hHUJmlVBdbqhvXM0t+daw/iAb4He92p2B295robaGMz9PPiepM1AGgMys23uGgpkjOwsZwcZ9/OinoHCwUw124ym8YjPyipGiHRKRhsji/CBx2iofyioLi2Zw7zjIDYLxFDfCN3bxmNgSVP3c9NlJxl+uU0H0/AgI5KXHJXNhGBPfcF6L1CqbNi/TUtLTLJ7UuBv3mmif0C8+fAMwWta2xzc7JnlfO2+bZjH7O12lGVu0XK4BdX0MBB4+EL8JAg2oKphtPsBC7Rq08vHkWibP2tAvHAZOUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QUErobHl0+US96cJWuQbs44Hv6mGf+Zx6PhBESB331Y=;
 b=wZPhPMEnJ1o7O40JQGoHeWv3HJY9htQAYMGDaLKtSxU0SAENBZEmdQu6UW57z1YOg7En5a5yKITILDkIHfjnX8E39NGeFMkPh6buOItqbXdLV9ayODodN16RzthUhhbUxNal9Magv+nzG9LtR02Elb+AnQ4AjnrIGLuLgU9I8X4=
Received: from SJ0PR03CA0225.namprd03.prod.outlook.com (2603:10b6:a03:39f::20)
 by CH0PR12MB8579.namprd12.prod.outlook.com (2603:10b6:610:182::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.15; Thu, 26 Dec
 2024 08:33:16 +0000
Received: from SJ5PEPF000001D7.namprd05.prod.outlook.com
 (2603:10b6:a03:39f:cafe::d0) by SJ0PR03CA0225.outlook.office365.com
 (2603:10b6:a03:39f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8293.14 via Frontend Transport; Thu,
 26 Dec 2024 08:33:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001D7.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8293.12 via Frontend Transport; Thu, 26 Dec 2024 08:33:15 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 26 Dec
 2024 02:33:12 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <le.ma@amd.com>, <hawking.zhang@amd.com>, <shiwu.zhang@amd.com>,
 <Asad.Kamal@amd.com>, <charis.poag@amd.com>, <donald.cheung@amd.com>,
 <sepehr.khatir@amd.com>, <daniel.oliveira@amd.com>
Subject: [PATCH v3 1/2] drm/amd/pm: Update SMUv13.0.6 PMFW headers
Date: Thu, 26 Dec 2024 16:32:58 +0800
Message-ID: <20241226083259.2670687-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D7:EE_|CH0PR12MB8579:EE_
X-MS-Office365-Filtering-Correlation-Id: 22983b6a-7f7c-4d73-2bc3-08dd2587f171
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3JEdbTlKjfQ+AYJTNulW6rGlFcahIZWqlUm2KUVQbgz7m8OjShLhPZZRsJHt?=
 =?us-ascii?Q?uKe/MwrDpOZAf0+0/bgfg7szbp88glznFkMq/MbGjGA+vAS6T5vipQfRCB/V?=
 =?us-ascii?Q?PMIUbJ8nvSY0PEj0Ux79lf5tYIP3KRDgPoYYUOUW7c58eTXmeqVnfuxrj272?=
 =?us-ascii?Q?awCmdq0CFGN/CmrU4D1aXD7ToPBNgRSJ8oN3AyqDvJ58LV/xYfD6PkRYCv6q?=
 =?us-ascii?Q?/frkpiFAEuXK2AmmZjBhUUF7LZyojUHTcyw7bz3F9dSNeYZFfKNMVP4LJ4Sv?=
 =?us-ascii?Q?MJdRWC4K+uXZ/sheBYMO5swxWAy8doD7iXZ9L1JNIRPkGZx5Mz2N1LndLsYv?=
 =?us-ascii?Q?BPQ0sCv1+STEhbIBgBWmxs/e1a//s2NXCl3+Rg0lcDm7/vIzaU8bkgL97tj7?=
 =?us-ascii?Q?KuKf2eTJjAkyHScVOCiv9U6UYrbStoUFeo8oYWIDVfZI5EO6llQQGQHCbmmd?=
 =?us-ascii?Q?TYfoJO7DjUTGn1L+Pjuyloizg7FbZ4KviGGpHZ7Ibe6kK2J3j3pKv/js4eQU?=
 =?us-ascii?Q?OlDW5J0CbKNPDIF4M2E/COTb7/HpXc+8v0YXS8+eyUxhD7uFM7vz7BQ7sbKB?=
 =?us-ascii?Q?BegYXtnwfXOfuVJM4CYmQQdyEoWpCvjbb8SAQSxHAm8dkLq5NfU27FsIKTHc?=
 =?us-ascii?Q?byFN0ghfqpPnULQ6pycRXk3C10nyVCX0TkKIARvR9n97z2295S8S9TsSof0m?=
 =?us-ascii?Q?t+c2KYePJ3BWB/HnDmsawok3Sb2WH79IikRvHvrarLqvFDrMM9UioJItJKmf?=
 =?us-ascii?Q?oU2IJY7xmw4b/gQ/X/NNcWP5BEs/HW27weEL023hWGj85poDhBJu2gPDiY0e?=
 =?us-ascii?Q?LtEZWXf1dbe+JUdtX7G1uE3sI+djCOSXoLOsj+wIfTwkEbdLjvuvgi1yZj+0?=
 =?us-ascii?Q?BNku4cKfo3NYBKHBUXU2xLWv7vEai/aZtrA4QmiYI/TdUZQ96LI9rDHgG0Cg?=
 =?us-ascii?Q?XoTzs08ZkqhNC8jvFAIEAzHbHZwhMOuGMhgdWwAn8R6j5sr5n/TK9RTaWEIP?=
 =?us-ascii?Q?8Xm/5zij4YGPQTghxcp54wDCWOSRqEjWaYwmgX1K1lCkUxGmwu0AloomS/qr?=
 =?us-ascii?Q?ZosyAlMmUUbJi/AGJRrbLMRryWYO3Q1ZKrZZMTkbzJH2Rz+8jzSmoGd8FaTs?=
 =?us-ascii?Q?om8vLIESHBIF0twjrNrVuumapCJqraZiVirfi26ThXUjPmy2gbS/lZSpf0qx?=
 =?us-ascii?Q?oU7v0Sc7TrjVddCIGKPEtMjjzq3ZqotFzi++9yhsQMslz8VjL+Ou06+jAX82?=
 =?us-ascii?Q?ecGtdG1QdFxmAxZzilwr5y+TYwsdu5GUl7vcHZfc2M0RM09QJ8ch3FGjQxLv?=
 =?us-ascii?Q?Un8lJDSuP/oj97H2xwjZj/UL933ETQK2B5jgNAHN7gs/CRKqb+730rAS2XZs?=
 =?us-ascii?Q?rYpbLy0Abgp5HBdzVzWws2hIry1tOFt1bI0Zrwmx5WS5OkWewdmhprCfw9Sa?=
 =?us-ascii?Q?QqudM7hKYbixrNDpHXechhs1Y+BJ0twSzPbs4e/s7MdRDhI/fCDifzX1hL9i?=
 =?us-ascii?Q?EUtCyewOO5kJd+o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Dec 2024 08:33:15.6454 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 22983b6a-7f7c-4d73-2bc3-08dd2587f171
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8579
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
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h    | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_6_pmfw.h
index 0f96b8c59a0e..274b3e1cc4fb 100644
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
+  //Total App Clock Counter
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


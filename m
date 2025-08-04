Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A98FC87FCB
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 14:18:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1A4610E529;
	Mon,  4 Aug 2025 14:18:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Aa4+EBqh";
	dkim-atps=neutral
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2081.outbound.protection.outlook.com [40.107.101.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2999C10E524
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 14:18:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fCdYzoQegnRqwpG9Qq7R5KBwFK4W2lcXCR9czeyODeNzdnP0FDPBAcD4iDBbZ5ccUCM0czGlfIYXGV5Fx+m/7r1EtbN3F83OwDwKUnpY8i58ueB6yH7IUGQiFwgN1OodHYLQ71ccZPiSACzc4s0mWNpfFWzXGfNDD7LJgm2U0TwkWF3PxD75LRKyus+GSse3cNN//Usd4HyofWj5VAnGglX9/4QnkufNYzn8ROD35YsOFk+Tyr1SmG2RUQxxwMHpS5SaCCPd8t9Qncv7XMfrWmWRx1e7GyZNgCeMDV5KxHIUsf7rRP/5fku8sfe8N8ZnWFw8susJvJ7OeOBju3MqcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXOgdodvwrFRVIX9AOKmSpvzZPsil5peWLOXiNIre38=;
 b=kU6hcAuWGR0JI42dSTk/3VoGcqnmXA+0VA54DyyjiM5oZrpqYLgk37jQ+/+dzOdo8sA8GsV6k0X+Op1s/2ZXzdXhZCVumeEmZzzxbxNki/CDWX0Ve57KVE8dzNl7osPoDFA9JykazMeFao1D/0EReJPlbh24IN1lXaJCDepsLAu3834jnQ/uOZ0otVjWcWpqo9aSMgUSUTIE2/hZIBYfF0LNh365FPUhBsw+dmay0QQhmZ9F/OtEs+JJA0gBK6kfh2RphN3/PQljt13eJUq9NeQrNkshOU5jCwkv3LjKr6D1R4sHR3OV3Kiw4k3vtJjZ4AegZeZ+bJAJuyIpwGZhmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXOgdodvwrFRVIX9AOKmSpvzZPsil5peWLOXiNIre38=;
 b=Aa4+EBqh9SO7RmhS66xsAewXLq87A9BDHS936Y8NtDreNrvQpR+c5Van0Dmj3ZjtiQJDmIWmLnsUs5dlGMA5LrkNPy65tS/VVEqxUbKxNxTLpxmzlU4H8DMHQkv8+A9pGuuAZrpQvaFhDf3ZwTIg1HSLTiwAKT5qquJfQeQEeE8=
Received: from BN8PR03CA0033.namprd03.prod.outlook.com (2603:10b6:408:94::46)
 by PH7PR12MB8826.namprd12.prod.outlook.com (2603:10b6:510:26a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.20; Mon, 4 Aug
 2025 14:18:17 +0000
Received: from BL6PEPF0001AB73.namprd02.prod.outlook.com
 (2603:10b6:408:94:cafe::30) by BN8PR03CA0033.outlook.office365.com
 (2603:10b6:408:94::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.21 via Frontend Transport; Mon,
 4 Aug 2025 14:18:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB73.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 14:18:15 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 09:18:13 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <alexander.deucher@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH v3 3/6] drm/amd/pm: Update pmfw header for smu_v13_0_12
Date: Mon, 4 Aug 2025 22:17:54 +0800
Message-ID: <20250804141757.643501-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250804141757.643501-1-asad.kamal@amd.com>
References: <20250804141757.643501-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB73:EE_|PH7PR12MB8826:EE_
X-MS-Office365-Filtering-Correlation-Id: 4762cf4c-4349-47ca-cfb6-08ddd361c101
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gt8s/Z0o7dE7siP1NnH593EId8gF84d4AFZKKlf5rctBLuN20zwsWZTX7c4e?=
 =?us-ascii?Q?alHquGiEXNJI0zCuFiOKJVaNhCfckc3VYrDyxm829V0sl1RJGDCzPpJArNuz?=
 =?us-ascii?Q?7KYiWkxKtLGkKJ9NQoWMxe5gOdZDgaJ5GpCR+VSSS3mKlyXWDbifhTfL/JSf?=
 =?us-ascii?Q?/PHehtPtsGr/kOD23eUBYMkA6PE/6r+NZYjDqxUFZWWFnZOHa0DuH94pN5AQ?=
 =?us-ascii?Q?ebei/eLnfiGhY2DxPgFJoK51ECrvFxyuWo/Wl4rZKs16Le69qEejB84QHHxI?=
 =?us-ascii?Q?FW2zEI0XjVu4CKK7IN3DbEwujugX4xjJJ0P4NjEYApCkXLNKQYsC8s29jaQq?=
 =?us-ascii?Q?llm+RN7N8AKsjfoSJ3lkgAT3tjXYVDuN6Sf53LsbnBVVC6cyb2xtGo6+ek9C?=
 =?us-ascii?Q?fptMSUvsOGjIWEgIIlMXFdYoF3QTj6cfx7a77y2zzxJPnSnNX+UarTV04mw9?=
 =?us-ascii?Q?/VvCyeaNxCnabA+3vR9PqMbVdB7TuiR/9GwUzuNEAheAmG17v+LPNH8QRspz?=
 =?us-ascii?Q?0FsSA28Xn+E98VVDnqLwXT2bIO0WGFjjmSzEGLh3E8+KE6WuBv8WKffDeefq?=
 =?us-ascii?Q?s1nGkI6fvKHlonP/LDoDr/wEMng318rMZrHJfURFFjQDl6DEiv4r0fEq+PjM?=
 =?us-ascii?Q?rzALo1huIQQKNAJ3ua/QTgHbOjJdLSITzQZyCjNoLhWZY6BybaASjjPHi9Xw?=
 =?us-ascii?Q?aApix4JDI8MCJAsIhZ+QEUqaxkEhOeo6VWBC1c2D1HMyub6WUjbcxn8Z0Ddk?=
 =?us-ascii?Q?kb0EIPaywceJYRqWM/++fiZepauqkrEPnPGIMHUgleYxPGoP7joIJvxxkjDB?=
 =?us-ascii?Q?WIWP3ShAijNVedWwIrcXx8Cfge3wLhiGrTUHYy61J6TLnlNWVPfFLI6f1Q8U?=
 =?us-ascii?Q?RXnHBsUzWGQl01sltp+z3M38gQLRJbfJ7gidyRnEMyUNd6BjUT8oEEGtoJja?=
 =?us-ascii?Q?5LoRPvBQ2hdnKf+VjO6EGUQeqFFXIf6AGqDPWglon7jD9RB+netYwdP2pnaN?=
 =?us-ascii?Q?04nJvh419s6nbxcyNOdY3s0bl+wNcWy2TbU0n2IDF0JV4IBUIrrYo44nKGZB?=
 =?us-ascii?Q?Ilh1HzMc9X8/2bWGdp09mrWv+aWubZ9SljzVRuyT1tqZFchAk61rvm2v9vZy?=
 =?us-ascii?Q?A7LojsIcT6Pr+cXslEjSNR0yn/CXlJ5d6rXUiJVUXtLFfz9H/0aMYxnSwBv9?=
 =?us-ascii?Q?9pE93QkL5dnGrrj/K169IFxO2JLw+AQic0KvaV7jufBKwV4uDfTLrA189RPW?=
 =?us-ascii?Q?HTwPdUfzQNjgrKa57QwnZ0L0BGWJ0/q7W8lnwDpFUt74FE21iagXrYSxEGSy?=
 =?us-ascii?Q?ttFDanL4tnePVWDhUzyI6z+nQNOFrEOI9D060erptZe6WvoJDqDBSgg7qSLO?=
 =?us-ascii?Q?EWnhGYz/THwlU2fvrLl7/hyOjg6PXGgpCkyfvGFgl1v40r+UNAY8ZEvpv6+0?=
 =?us-ascii?Q?7C/yQ1mTByZTpWFAPcWscVxDb/zqOpLSqWNYAeIpKLfiGnnMN3AsVzxkgO8Q?=
 =?us-ascii?Q?+IqQq4kJyF+E6sd7tq3RvRLi95mMICADCrfr?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 14:18:15.9449 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4762cf4c-4349-47ca-cfb6-08ddd361c101
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB73.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8826
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

Update pmfw header for smu_v13_0_12 with system temperature metrics
table

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h  | 74 ++++++++++++++++++-
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h |  6 +-
 2 files changed, 78 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
index 0a2ca544f4e3..1c407a8e96ee 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
@@ -135,7 +135,63 @@ typedef enum {
   GFX_DVM_MARGIN_COUNT
 } GFX_DVM_MARGIN_e;
 
-#define SMU_METRICS_TABLE_VERSION 0x13
+typedef enum{
+  SYSTEM_TEMP_UBB_FPGA,
+  SYSTEM_TEMP_UBB_FRONT,
+  SYSTEM_TEMP_UBB_BACK,
+  SYSTEM_TEMP_UBB_OAM7,
+  SYSTEM_TEMP_UBB_IBC,
+  SYSTEM_TEMP_UBB_UFPGA,
+  SYSTEM_TEMP_UBB_OAM1,
+  SYSTEM_TEMP_OAM_0_1_HSC,
+  SYSTEM_TEMP_OAM_2_3_HSC,
+  SYSTEM_TEMP_OAM_4_5_HSC,
+  SYSTEM_TEMP_OAM_6_7_HSC,
+  SYSTEM_TEMP_UBB_FPGA_0V72_VR,
+  SYSTEM_TEMP_UBB_FPGA_3V3_VR,
+  SYSTEM_TEMP_RETIMER_0_1_2_3_1V2_VR,
+  SYSTEM_TEMP_RETIMER_4_5_6_7_1V2_VR,
+  SYSTEM_TEMP_RETIMER_0_1_0V9_VR,
+  SYSTEM_TEMP_RETIMER_4_5_0V9_VR,
+  SYSTEM_TEMP_RETIMER_2_3_0V9_VR,
+  SYSTEM_TEMP_RETIMER_6_7_0V9_VR,
+  SYSTEM_TEMP_OAM_0_1_2_3_3V3_VR,
+  SYSTEM_TEMP_OAM_4_5_6_7_3V3_VR,
+  SYSTEM_TEMP_IBC_HSC,
+  SYSTEM_TEMP_IBC,
+  SYSTEM_TEMP_MAX_ENTRIES   = 32
+} SYSTEM_TEMP_e;
+
+typedef enum{
+  NODE_TEMP_RETIMER,
+  NODE_TEMP_IBC_TEMP,
+  NODE_TEMP_IBC_2_TEMP,
+  NODE_TEMP_VDD18_VR_TEMP,
+  NODE_TEMP_04_HBM_B_VR_TEMP,
+  NODE_TEMP_04_HBM_D_VR_TEMP,
+  NODE_TEMP_MAX_TEMP_ENTRIES    = 12
+} NODE_TEMP_e;
+
+typedef enum {
+  SVI_VDDCR_VDD0_TEMP,
+  SVI_VDDCR_VDD1_TEMP,
+  SVI_VDDCR_VDD2_TEMP,
+  SVI_VDDCR_VDD3_TEMP,
+  SVI_VDDCR_SOC_A_TEMP,
+  SVI_VDDCR_SOC_C_TEMP,
+  SVI_VDDCR_SOCIO_A_TEMP,
+  SVI_VDDCR_SOCIO_C_TEMP,
+  SVI_VDD_085_HBM_TEMP,
+  SVI_VDDCR_11_HBM_B_TEMP,
+  SVI_VDDCR_11_HBM_D_TEMP,
+  SVI_VDD_USR_TEMP,
+  SVI_VDDIO_11_E32_TEMP,
+  SVI_MAX_TEMP_ENTRIES,   // 13
+} SVI_TEMP_e;
+
+#define SMU_METRICS_TABLE_VERSION 0x14
+
+#define SMU_SYSTEM_METRICS_TABLE_VERSION 0x0
 
 typedef struct __attribute__((packed, aligned(4))) {
   uint64_t AccumulationCounter;
@@ -231,11 +287,27 @@ typedef struct __attribute__((packed, aligned(4))) {
   uint64_t GfxclkBelowHostLimitThmAcc[8];
   uint64_t GfxclkBelowHostLimitTotalAcc[8];
   uint64_t GfxclkLowUtilizationAcc[8];
+
+  uint32_t AidTemperature[4];
+  uint32_t XcdTemperature[8];
+  uint32_t HbmTemperature[8];
 } MetricsTable_t;
 
 #define SMU_VF_METRICS_TABLE_MASK (1 << 31)
 #define SMU_VF_METRICS_TABLE_VERSION (0x6 | SMU_VF_METRICS_TABLE_MASK)
 
+#pragma pack(push, 4)
+typedef struct {
+  uint64_t AccumulationCounter;                             // Last update timestamp
+  uint16_t LabelVersion;                                    // Defaults to 0.
+  uint16_t NodeIdentifier;                                  // Unique identifier to each node on system.
+  int16_t  SystemTemperatures[SYSTEM_TEMP_MAX_ENTRIES];     // Signed integer temperature value in Celsius, unused fields are set to 0xFFFF
+  int16_t  NodeTemperatures[NODE_TEMP_MAX_TEMP_ENTRIES];    // Signed integer temperature value in Celsius, unused fields are set to 0xFFFF
+  int16_t  VrTemperatures[SVI_MAX_TEMP_ENTRIES];            // Signed integer temperature value in Celsius
+  int16_t  spare[3];
+} SystemMetricsTable_t;
+#pragma pack(pop)
+
 typedef struct __attribute__((packed, aligned(4))) {
   uint32_t AccumulationCounter;
   uint32_t InstGfxclk_TargFreq;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
index e1f490b6ce64..aff2776a8b6f 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
@@ -116,7 +116,11 @@
 #define PPSMC_MSG_DumpErrorRecord                   0x57
 #define PPSMC_MSG_EraseRasTable                     0x58
 #define PPSMC_MSG_GetStaticMetricsTable             0x59
-#define PPSMC_Message_Count                         0x5A
+#define PPSMC_MSG_ResetVfArbitersByIndex            0x5A
+#define PPSMC_MSG_GetBadPageSeverity                0x5B
+#define PPSMC_MSG_GetSystemMetricsTable             0x5C
+#define PPSMC_MSG_GetSystemMetricsVersion           0x5D
+#define PPSMC_Message_Count                         0x5E
 
 //PPSMC Reset Types for driver msg argument
 #define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
-- 
2.46.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4689CC87FD1
	for <amd-gfx@archiver.kernel.org>; Mon,  4 Aug 2025 11:06:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5A4B10E1AE;
	Mon,  4 Aug 2025 11:06:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gjWEuOsV";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2067.outbound.protection.outlook.com [40.107.93.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BCB510E1AE
 for <amd-gfx@lists.freedesktop.org>; Mon,  4 Aug 2025 11:06:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5SZsk5XAeQZKZtwxi9Qj388vEgqIxuxkczrrT1s4dywtXeEdJLBJqbs1Bk4OY62u1cyGWFoYuWIbpZcL7DegzyZTnydi/T9GJuYGXeeSSkErNdEpZ9Dc+GAIXa8VsNkU3N5Rie4sKATebsmAA3aOk+JiIRAPsD0U0eRSrOvU0eYNxRKCyV8UppVGinW2InSQskmEYNQQeZ0EQtg2oMC0kSTiTKCqzyIAq+6DyuNThlk/bXr/LVC6XA6J6cDU1dKLJvLJmRuUVDLRRILizpYjBkGXvO2QDsEm/kAWwv4KQM0mYJXYpr+E8HDPPDiAnF9VyX9wvz9Pa6298hFwoSTTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TXOgdodvwrFRVIX9AOKmSpvzZPsil5peWLOXiNIre38=;
 b=VkNtz/UhxcYWmXJku8QrrHtVyfkLIkVX7hc+ttariSB1gWVbqOV28mr/tEBDJGPxD6b4/VNflr84BWLIK6ROKFe7UbpY1lI1KViGjFM6C+tvb/jnwF5OnYi1yJSeOLL2VTOeCNYbPfWevYTzg8k2HvgoBfNyOtKGN92efrwfgM7iZvKI4qhm+gbDJk/RxpTpVoqJZitDY6/wQYFQSFD5FQnfa9rlOqr2gPWCm8Va03+tkA30iGUB2f1bgavkQOIueka6AqssfyWKXoo0UBriMjCltclKNcBHMk/iIwer4QFd7d5N7wMXjPLK+KU1GVHneLqe9DYHglrQD9jKNzvFng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TXOgdodvwrFRVIX9AOKmSpvzZPsil5peWLOXiNIre38=;
 b=gjWEuOsVXBBr98nh+inGzewruXYKhceorjlnPjfi/hD638DJN6vVi/sIMs3c0Imp9qsLU1NVNFdj/f44J99HWIfsZkOX6YEyaq8Bdm+eudYjC11IH2DbTmDba7OJFrUQwgFanijOis69wLaqNyEkcp/S8nShX8dUNARRasF8ADM=
Received: from BL1PR13CA0320.namprd13.prod.outlook.com (2603:10b6:208:2c1::25)
 by CH3PR12MB8972.namprd12.prod.outlook.com (2603:10b6:610:169::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.21; Mon, 4 Aug
 2025 11:06:00 +0000
Received: from MN1PEPF0000ECDA.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::bc) by BL1PR13CA0320.outlook.office365.com
 (2603:10b6:208:2c1::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9009.10 via Frontend Transport; Mon,
 4 Aug 2025 11:06:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECDA.mail.protection.outlook.com (10.167.242.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Mon, 4 Aug 2025 11:05:59 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 4 Aug
 2025 06:05:57 -0500
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <alexander.deucher@amd.com>, <asad.kamal@amd.com>
Subject: [PATCH v2 3/6] drm/amd/pm: Update pmfw header for smu_v13_0_12
Date: Mon, 4 Aug 2025 19:05:36 +0800
Message-ID: <20250804110539.637463-3-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250804110539.637463-1-asad.kamal@amd.com>
References: <20250804110539.637463-1-asad.kamal@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECDA:EE_|CH3PR12MB8972:EE_
X-MS-Office365-Filtering-Correlation-Id: dd528e0e-e01f-4c02-1e80-08ddd346e4e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5aERG7FqZNjw6DI1i+vfPUN8CZa/pTltXRcrhgco8ZjxxsYEufXPxRKgpbUp?=
 =?us-ascii?Q?RNJZho4Mlb8Jh/FC6OJLAnSr245DN3kZwlyLqB3Ev8d0qmtKeddIPv6sWeC7?=
 =?us-ascii?Q?1/dlfE+ZPB/WQ26m1mC/RbLt0icLssiGTGNAcTOcd396MuLSImvpxX9MXjao?=
 =?us-ascii?Q?HAhlAIVa1uFExY+bDZoZBdJaI+4VLs+T05BOjw06EHmpUyBRjI3aKhJHxlnS?=
 =?us-ascii?Q?A88njT1lmPLIgHr5hEXENBXld2u1ajanW96cyWreUMJ9S3OrSo84/CUK6+xd?=
 =?us-ascii?Q?e0Ap5UyfVr62Rfa02t8HR0/WLHN1A4dZ+3DE7eKmXoUShAgl3KBxd/LdsNYm?=
 =?us-ascii?Q?8dRTcKO8AiyLzPxanOYuqp7jcTBvHPYERIRO95vPMo+FcH81HYyA2YMH+HAi?=
 =?us-ascii?Q?c/VQBegn/e/Rmvz37an3I2XWKKNXbiZiWTYWOCWj8UOgq7U9OQixXlvY4df0?=
 =?us-ascii?Q?Bsa8goqXnIvJt1PCRTDgNj/0wwQml/faCDvSLbtW+92wyAtuCspfcHZMagGE?=
 =?us-ascii?Q?bzY0NqH2fFq8Os80AZgpNOHFUQnjwnoJNROb7xgF1qIO9D9YUwqDeh8jyUtl?=
 =?us-ascii?Q?/MNhr8of+VcjpjWgmaEPGoHkYV7svCKNPL0FHeex/lUjZiGbzL/PtKxOjQ8z?=
 =?us-ascii?Q?wjZwbIm6tV0xuw6eKkFLjgdmNwOt7YeC50jZxHS2+xXG2O0AX6+3Amn49db1?=
 =?us-ascii?Q?1M1kI7cI1WvHL3sXcILWx3LbAivTRMDx1D4ouCXmbDBUSSwCVehcfdu6TRez?=
 =?us-ascii?Q?r/EQXyb3yBCO+hmRnismGLByMX8llQerCMq832R62desQyQX2jUGLKuxw2jC?=
 =?us-ascii?Q?qtR+MgvzEmjuRqEh4llkDnavdCPBBM1NbNlqXj4Zp+hdggBrUb7XuZ9lfiQI?=
 =?us-ascii?Q?t0Um3ZUi5i2tuincd1aIPsxJFZjniS6agx5Pdjju+5i+52YVDYE/FGzWDZfB?=
 =?us-ascii?Q?jVe0ODEFJPiwch4Cgvowfp5UFwsuFGjL8ui7zEkroddxiBn8UbvsmCez4ZOv?=
 =?us-ascii?Q?NYwldLd+m1MnGEph5s5jFuvkehif34J3UmEZQedqYvHDKlujzvTrb01IQ26H?=
 =?us-ascii?Q?7+mBgUmcWpMlos1dqfG1ZwfnasQ0Vr1jMyz/r8ItAVzY0/6Ezvz7p3hXpzMf?=
 =?us-ascii?Q?3zxnWpqWGVyS7T+tl+tvxGtoDOHTozDRrhs8u9YM1guT8br4SBouqazz0tYx?=
 =?us-ascii?Q?WFpPWaK93cJBDZLkdWb4vNvC8AQ+bvtboudnPzBn5tNNuNBQC62k7XRXpjXS?=
 =?us-ascii?Q?zMzaBJVf/4q8Dwvujhd2RvV//1d+yobw9UcskZicr8CATUj2XlPK7Pfyq+sF?=
 =?us-ascii?Q?9PlT6zXZI+8546jAfRMt1y41BBzcszHGJRITWFQMILodw4DjcZbJ9HnqhLLS?=
 =?us-ascii?Q?Ywi/0Bo3fVPHchHSsxM9vIgBEqIG8bN193zWcJYSlSMVgiIhdeMHldxlIu5m?=
 =?us-ascii?Q?hR5wDdDeMGdM5oqvm3Tu/RTnSTN9FhfE4Q3z41nh8Kg1ap9Mpag3imKkTBHb?=
 =?us-ascii?Q?wUFbKNgdHIEIKbREGvhyrqpzOQ459CjH9kyK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2025 11:05:59.7626 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd528e0e-e01f-4c02-1e80-08ddd346e4e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECDA.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8972
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


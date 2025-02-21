Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C71C7C021B6
	for <amd-gfx@archiver.kernel.org>; Fri, 21 Feb 2025 12:19:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C0F010E2E4;
	Fri, 21 Feb 2025 12:19:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="KIksktjQ";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9B08610E2C0
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 Feb 2025 12:19:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xN08Hww5eXHDsy/vPm8bB6wKZ9fcbOQsdF0YFWBZbetP17ao79sfIMgr6FZwtQgCZ9YdZvT8ouQb5+MLVn9KXAq5e7Zj7UZtXJ73XPkCI0rWJCm/AVgrMP118RqRz80PSKkvbR9MjvcCCfYRE00WnODNBGHbWIbJl78+OC2KbQNc4NFciZSHazSrvgTqPWSCz+20GalWLOtIUGfDCzVSKByJ5MPfCsiEN1y9u2+t68B3RUIj51p8OxLFDYk9MJe3XL7gG3y5bcMpzoTJWXoXhZv39nu2y5b48bu9QmWo82vMmrVeLpQ1Kiio/ER00q2YniaHLEZ7cS1L/YlWjOIyHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ElEs78aDTSz6VJ6sW3z0rNPt006GTiJy0pkyAnxr7XU=;
 b=kPQVzBFbS4N7QHxvVztjPxL41Wcb2kSv24Kl0arJaPY4Tzh9N2SxtQFauSq1OCnItSA7/4G5Pe5k2Ekqin27fHXTx2J0lmJCMAs39oWqrJauPb/JvBroaQkJjAzH9gZIr0srjFgj8A5IAGL/tdERsO5s02mixsXcYDwb5EKmbvD6wZMF0NLvEXLejyKOh7HyZhwvCwqEfkbevfKZKds3wY671gXy4IgFaYrsVQR266GuT+XYzrwX8bD/CVqkrqcej3BXbSqzfzvFTFbWaMoYPw70OMmnGeDpNzEEbd7RM5+wS+HozyhQEbCkmZPHfeHBWkhO2ZfVRWQG9H0fJjFe+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ElEs78aDTSz6VJ6sW3z0rNPt006GTiJy0pkyAnxr7XU=;
 b=KIksktjQGP8oXl6fiDyLTsaSVn1iCqHMP+yLe9CRQP9VBWuVxiW6ICfbdIJz9lONAO9hw4CjGP18zl/DcRKHFpXHdVTijpGNilzRZI6S+8e1ygrDtdUa8Ncvm6iA0yjUEI9XrF2t1WcAgg1lHr4Iew8aMcypmykMk0BPyJA3eGs=
Received: from BL1P222CA0003.NAMP222.PROD.OUTLOOK.COM (2603:10b6:208:2c7::8)
 by PH7PR12MB8014.namprd12.prod.outlook.com (2603:10b6:510:27c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Fri, 21 Feb
 2025 12:19:36 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:208:2c7:cafe::41) by BL1P222CA0003.outlook.office365.com
 (2603:10b6:208:2c7::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Fri,
 21 Feb 2025 12:19:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8466.11 via Frontend Transport; Fri, 21 Feb 2025 12:19:35 +0000
Received: from asad-mlse-vm.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Feb
 2025 06:19:33 -0600
From: Asad Kamal <asad.kamal@amd.com>
To: <amd-gfx@lists.freedesktop.org>, <lijo.lazar@amd.com>
CC: <hawking.zhang@amd.com>, <le.ma@amd.com>, <shiwu.zhang@amd.com>,
 <asad.kamal@amd.com>, <alexander.deucher@amd.com>
Subject: [PATCH 1/5] drm/amd/pm: Update pmfw headers for smu_v13_0_12
Date: Fri, 21 Feb 2025 20:19:15 +0800
Message-ID: <20250221121920.779576-1-asad.kamal@amd.com>
X-Mailer: git-send-email 2.46.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|PH7PR12MB8014:EE_
X-MS-Office365-Filtering-Correlation-Id: 43d279a1-8762-4d7e-4e4a-08dd52720154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dTGWbzCTvAOQ5sSXhARylOqs8UDOEN31XKEW8Zr6N2REW0srMZmy8SUUQP16?=
 =?us-ascii?Q?byKcKj+z27H/SVL3iojKhmjjK0dmgPGcGWqDXbDlaHx21fH73Gr9sPjHIshI?=
 =?us-ascii?Q?MnKvRgTObWfkRMhMLJzBvCo+0jtI5RGkQUpaCHZYLjaAk2RcaTz7ox71EXey?=
 =?us-ascii?Q?fWs/zlaOqwI9YBAwt3YbSPNbBeKDXxR57MAlSI1vmrZ7yUBe0btJpA9cgHwB?=
 =?us-ascii?Q?M3dvUTuvZRHMHCEBgff92izfEIqKCUVulhc3nOmVR2OfW9aZpakn1FGS+oFg?=
 =?us-ascii?Q?/8MPtmU37XLNIalesTP/Zw++VotHsClYAFuojQw3DEynEj5ilFAqhsDxAlxJ?=
 =?us-ascii?Q?XU/BVJrDe5EpmJTeiYtYDH/p0RffVuwe/rqC0XEWSYgi9PaE/FYpbQkJn42R?=
 =?us-ascii?Q?7Y0sJXc/R705HVT1S+Y4m69sbo0Q4v0d8FMN4O19SjmMAEfzOkDtR5ghc7ci?=
 =?us-ascii?Q?jVuSW+MdMbWytjKAOq0zO8SU3hzhxwPZkEIqKauV0WnGGpXTqAgp1SRLUXXE?=
 =?us-ascii?Q?xLgxx+KguCZZBS/BI+EvYcjRbjW0eJOL57GChmOeZnwU//dzcqfNmLd+mtJh?=
 =?us-ascii?Q?uI4Vz82u3aMIuL2ftYfTG4ZFPETY0sQ3NH9Ij9o24tGCCdXciu3sxu85K1ko?=
 =?us-ascii?Q?7FaDHLs4JP+fOYtPNQmwIFdFmYH10+cbm8OqPYmgND7L6T7uwe+V/YyszHjw?=
 =?us-ascii?Q?B8ARcwdEwrZxg2KiSUuUzvDnawmYDi7vRTd6ZQwmcuz0XS4kqOcwQQnBoGa7?=
 =?us-ascii?Q?UBTkvyspJpS9je5UmLxnMHwvBGqaKK4IqAaDAdXa2ypa0JVMzPqh4swMmI+p?=
 =?us-ascii?Q?TLhkdvJVoffRYvEKG4jqEbYfeEly7Z2uRjt9KDutBy1g/UUP8+VifXntD9zE?=
 =?us-ascii?Q?yev8D9JunjmVQJETxXD79aCH1BOhFy/6UsSPa2IGvAQi/dGRR+h7FW40fssq?=
 =?us-ascii?Q?7gCWRZ3EexBiaIPEyUu+Oy3st8xzlfR9VneuaNwZXf3uctRtP9G6sK8pf2IT?=
 =?us-ascii?Q?crB5YXanJwTnRHbFOC05gI1CCDgLFuULnmQ8i+BAQYQlRCZrY+sU8lVdyts4?=
 =?us-ascii?Q?b6Noy0UbErGmbcl4dxiPCsGYBcNZM0e+5XaibABtck6+9khY5qarkq6GG1Ez?=
 =?us-ascii?Q?qKkPSyyv7GvWPwy3Vq15vqZSaaJhr42dG4sJiRG+S97JEfRMQRB4OGhB5HsJ?=
 =?us-ascii?Q?S3Mx2oRkl8UBeQLQbx2uLxacJRx+elHfBZKJ3xGJzIGegm4mpADW4tlOib1A?=
 =?us-ascii?Q?rFnXLVQeJOoDiu6MMXnNOMqsCbHcCo8aDMnZvf3GBDv1kYN9I2x73sF4/p+O?=
 =?us-ascii?Q?iTnywuO9HD6JtlyqyZSZzSrcoD0vfBAV/5/OgFb4GxEAV2geYXr4AtOBDaXV?=
 =?us-ascii?Q?iBBWpjD5k0dT1UsZC7UF53yiktdszAnyX4Ig4kisxYzlGyrudpO1kZs0Nmbm?=
 =?us-ascii?Q?8rKV5ehOoKuxBI7HzrHxnWeyyYNLbacIzQO+PYIFMzx5XT8a3RgBmDhnWxzf?=
 =?us-ascii?Q?/hmZHIpvRVa8sjs=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2025 12:19:35.7905 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 43d279a1-8762-4d7e-4e4a-08dd52720154
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8014
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

Update pmfw headers for smu_v13_0_12 new messages & metrics table.
Static metrics table for frequency added, Separate metrics table
for smu_v13_0_12 added.

Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h  | 146 +++++++++++++++++-
 .../pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h | 143 +++++++++++++++++
 2 files changed, 287 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
index 4a1256d29d62..dd0e5259d7a2 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_pmfw.h
@@ -38,6 +38,13 @@
 #define NUM_SOC_P2S_TABLES    6
 #define NUM_GFX_P2S_TABLES    8
 #define NUM_PSM_DIDT_THRESHOLDS 3
+#define NUM_XVMIN_VMIN_THRESHOLDS 3
+
+#define PRODUCT_MODEL_NUMBER_LEN      20
+#define PRODUCT_NAME_LEN              64
+#define PRODUCT_SERIAL_LEN            20
+#define PRODUCT_MANUFACTURER_NAME_LEN 32
+#define PRODUCT_FRU_ID_LEN            32
 
 typedef enum {
 /*0*/   FEATURE_DATA_CALCULATION            = 0,
@@ -85,11 +92,11 @@ typedef enum {
 
 //enum for MPIO PCIe gen speed msgs
 typedef enum {
+  PCIE_LINK_SPEED_INDEX_TABLE_RESERVED,
   PCIE_LINK_SPEED_INDEX_TABLE_GEN1,
   PCIE_LINK_SPEED_INDEX_TABLE_GEN2,
   PCIE_LINK_SPEED_INDEX_TABLE_GEN3,
   PCIE_LINK_SPEED_INDEX_TABLE_GEN4,
-  PCIE_LINK_SPEED_INDEX_TABLE_GEN4_ESM,
   PCIE_LINK_SPEED_INDEX_TABLE_GEN5,
   PCIE_LINK_SPEED_INDEX_TABLE_COUNT
 } PCIE_LINK_SPEED_INDEX_TABLE_e;
@@ -126,13 +133,148 @@ typedef enum {
   GFX_DVM_MARGIN_COUNT
 } GFX_DVM_MARGIN_e;
 
-#define SMU_VF_METRICS_TABLE_VERSION 0x3
+#define SMU_METRICS_TABLE_VERSION 0x12
+
+typedef struct __attribute__((packed, aligned(4))) {
+  uint64_t AccumulationCounter;
+
+  //TEMPERATURE
+  uint32_t MaxSocketTemperature;
+  uint32_t MaxVrTemperature;
+  uint32_t MaxHbmTemperature;
+  uint64_t MaxSocketTemperatureAcc;
+  uint64_t MaxVrTemperatureAcc;
+  uint64_t MaxHbmTemperatureAcc;
+
+  //POWER
+  uint32_t SocketPowerLimit;
+  uint32_t SocketPower;
+
+  //ENERGY
+  uint64_t Timestamp;
+  uint64_t SocketEnergyAcc;
+  uint64_t XcdEnergyAcc;
+  uint64_t AidEnergyAcc;
+  uint64_t HbmEnergyAcc;
+
+  //FREQUENCY
+  uint32_t GfxclkFrequencyLimit;
+  uint32_t FclkFrequency;
+  uint32_t UclkFrequency;
+  uint32_t SocclkFrequency[4];
+  uint32_t VclkFrequency[4];
+  uint32_t DclkFrequency[4];
+  uint32_t LclkFrequency[4];
+  uint64_t GfxclkFrequencyAcc[8];
+
+  //FREQUENCY RANGE
+  uint32_t MaxLclkDpmRange;
+  uint32_t MinLclkDpmRange;
+
+  //XGMI
+  uint32_t XgmiWidth;
+  uint32_t XgmiBitrate;
+  uint64_t XgmiReadBandwidthAcc[8];
+  uint64_t XgmiWriteBandwidthAcc[8];
+
+  //ACTIVITY
+  uint32_t SocketGfxBusy;
+  uint32_t DramBandwidthUtilization;
+  uint64_t SocketGfxBusyAcc;
+  uint64_t DramBandwidthAcc;
+  uint32_t MaxDramBandwidth;
+  uint64_t DramBandwidthUtilizationAcc;
+  uint64_t PcieBandwidthAcc[4];
+
+  //THROTTLERS
+  uint32_t ProchotResidencyAcc;
+  uint32_t PptResidencyAcc;
+  uint32_t SocketThmResidencyAcc;
+  uint32_t VrThmResidencyAcc;
+  uint32_t HbmThmResidencyAcc;
+  uint32_t GfxLockXCDMak;
+
+  // New Items at end to maintain driver compatibility
+  uint32_t GfxclkFrequency[8];
+
+  //XGMI Data tranfser size
+  uint64_t XgmiReadDataSizeAcc[8];//in KByte
+  uint64_t XgmiWriteDataSizeAcc[8];//in KByte
+
+  //PCIE BW Data and error count
+  uint32_t PcieBandwidth[4];
+  uint32_t PCIeL0ToRecoveryCountAcc;      // The Pcie counter itself is accumulated
+  uint32_t PCIenReplayAAcc;               // The Pcie counter itself is accumulated
+  uint32_t PCIenReplayARolloverCountAcc;  // The Pcie counter itself is accumulated
+  uint32_t PCIeNAKSentCountAcc;           // The Pcie counter itself is accumulated
+  uint32_t PCIeNAKReceivedCountAcc;       // The Pcie counter itself is accumulated
+
+  // VCN/JPEG ACTIVITY
+  uint32_t VcnBusy[4];
+  uint32_t JpegBusy[40];
+
+  // PCIE LINK Speed and width
+  uint32_t PCIeLinkSpeed;
+  uint32_t PCIeLinkWidth;
+
+  // PER XCD ACTIVITY
+  uint32_t GfxBusy[8];
+  uint64_t GfxBusyAcc[8];
+
+  //PCIE BW Data and error count
+  uint32_t PCIeOtherEndRecoveryAcc;       // The Pcie counter itself is accumulated
+
+  //Total App Clock Counter
+  uint64_t GfxclkBelowHostLimitPptAcc[8];
+  uint64_t GfxclkBelowHostLimitThmAcc[8];
+  uint64_t GfxclkBelowHostLimitTotalAcc[8];
+  uint64_t GfxclkLowUtilizationAcc[8];
+} MetricsTable_t;
+
+#define SMU_VF_METRICS_TABLE_MASK (1 << 31)
+#define SMU_VF_METRICS_TABLE_VERSION (0x6 | SMU_VF_METRICS_TABLE_MASK)
 
 typedef struct __attribute__((packed, aligned(4))) {
   uint32_t AccumulationCounter;
   uint32_t InstGfxclk_TargFreq;
   uint64_t AccGfxclk_TargFreq;
   uint64_t AccGfxRsmuDpm_Busy;
+  uint64_t AccGfxclkBelowHostLimitPpt;
+  uint64_t AccGfxclkBelowHostLimitThm;
+  uint64_t AccGfxclkBelowHostLimitTotal;
+  uint64_t AccGfxclkLowUtilization;
 } VfMetricsTable_t;
 
+/* FRU product information */
+typedef struct __attribute__((packed, aligned(4))) {
+  uint8_t  ModelNumber[PRODUCT_MODEL_NUMBER_LEN];
+  uint8_t  Name[PRODUCT_NAME_LEN];
+  uint8_t  Serial[PRODUCT_SERIAL_LEN];
+  uint8_t  ManufacturerName[PRODUCT_MANUFACTURER_NAME_LEN];
+  uint8_t  FruId[PRODUCT_FRU_ID_LEN];
+} FRUProductInfo_t;
+
+#pragma pack(push, 4)
+typedef struct {
+  //FRU PRODUCT INFO
+  FRUProductInfo_t  ProductInfo;
+
+  //POWER
+  uint32_t MaxSocketPowerLimit;
+
+  //FREQUENCY RANGE
+  uint32_t MaxGfxclkFrequency;
+  uint32_t MinGfxclkFrequency;
+  uint32_t FclkFrequencyTable[4];
+  uint32_t UclkFrequencyTable[4];
+  uint32_t SocclkFrequencyTable[4];
+  uint32_t VclkFrequencyTable[4];
+  uint32_t DclkFrequencyTable[4];
+  uint32_t LclkFrequencyTable[4];
+
+  //PSNs
+  uint64_t PublicSerialNumber_AID[4];
+  uint64_t PublicSerialNumber_XCD[8];
+} StaticMetricsTable_t;
+
 #endif
diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
new file mode 100644
index 000000000000..e1f490b6ce64
--- /dev/null
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/pmfw_if/smu_v13_0_12_ppsmc.h
@@ -0,0 +1,143 @@
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
+#ifndef SMU_13_0_12_PPSMC_H
+#define SMU_13_0_12_PPSMC_H
+
+// SMU Response Codes:
+#define PPSMC_Result_OK                             0x1
+#define PPSMC_Result_Failed                         0xFF
+#define PPSMC_Result_UnknownCmd                     0xFE
+#define PPSMC_Result_CmdRejectedPrereq              0xFD
+#define PPSMC_Result_CmdRejectedBusy                0xFC
+
+// Message Definitions:
+#define PPSMC_MSG_TestMessage                       0x1
+#define PPSMC_MSG_GetSmuVersion                     0x2
+#define PPSMC_MSG_GfxDriverReset                    0x3
+#define PPSMC_MSG_GetDriverIfVersion                0x4
+#define PPSMC_MSG_EnableAllSmuFeatures              0x5
+#define PPSMC_MSG_DisableAllSmuFeatures             0x6
+#define PPSMC_MSG_RequestI2cTransaction             0x7
+#define PPSMC_MSG_GetMetricsVersion                 0x8
+#define PPSMC_MSG_GetMetricsTable                   0x9
+#define PPSMC_MSG_GetEccInfoTable                   0xA
+#define PPSMC_MSG_GetEnabledSmuFeaturesLow          0xB
+#define PPSMC_MSG_GetEnabledSmuFeaturesHigh         0xC
+#define PPSMC_MSG_SetDriverDramAddrHigh             0xD
+#define PPSMC_MSG_SetDriverDramAddrLow              0xE
+#define PPSMC_MSG_SetToolsDramAddrHigh              0xF
+#define PPSMC_MSG_SetToolsDramAddrLow               0x10
+#define PPSMC_MSG_SetSystemVirtualDramAddrHigh      0x11
+#define PPSMC_MSG_SetSystemVirtualDramAddrLow       0x12
+#define PPSMC_MSG_SetSoftMinByFreq                  0x13
+#define PPSMC_MSG_SetSoftMaxByFreq                  0x14
+#define PPSMC_MSG_GetMinDpmFreq                     0x15
+#define PPSMC_MSG_GetMaxDpmFreq                     0x16
+#define PPSMC_MSG_GetDpmFreqByIndex                 0x17
+#define PPSMC_MSG_SetPptLimit                       0x18
+#define PPSMC_MSG_GetPptLimit                       0x19
+#define PPSMC_MSG_DramLogSetDramAddrHigh            0x1A
+#define PPSMC_MSG_DramLogSetDramAddrLow             0x1B
+#define PPSMC_MSG_DramLogSetDramSize                0x1C
+#define PPSMC_MSG_GetDebugData                      0x1D
+#define PPSMC_MSG_HeavySBR                          0x1E
+#define PPSMC_MSG_SetNumBadHbmPagesRetired          0x1F
+#define PPSMC_MSG_DFCstateControl                   0x20
+#define PPSMC_MSG_GetGmiPwrDnHyst                   0x21
+#define PPSMC_MSG_SetGmiPwrDnHyst                   0x22
+#define PPSMC_MSG_GmiPwrDnControl                   0x23
+#define PPSMC_MSG_EnterGfxoff                       0x24
+#define PPSMC_MSG_ExitGfxoff                        0x25
+#define PPSMC_MSG_EnableDeterminism                 0x26
+#define PPSMC_MSG_DisableDeterminism                0x27
+#define PPSMC_MSG_DumpSTBtoDram                     0x28
+#define PPSMC_MSG_STBtoDramLogSetDramAddrHigh       0x29
+#define PPSMC_MSG_STBtoDramLogSetDramAddrLow        0x2A
+#define PPSMC_MSG_STBtoDramLogSetDramSize           0x2B
+#define PPSMC_MSG_SetSystemVirtualSTBtoDramAddrHigh 0x2C
+#define PPSMC_MSG_SetSystemVirtualSTBtoDramAddrLow  0x2D
+#define PPSMC_MSG_GfxDriverResetRecovery            0x2E
+#define PPSMC_MSG_TriggerVFFLR                      0x2F
+#define PPSMC_MSG_SetSoftMinGfxClk                  0x30
+#define PPSMC_MSG_SetSoftMaxGfxClk                  0x31
+#define PPSMC_MSG_GetMinGfxDpmFreq                  0x32
+#define PPSMC_MSG_GetMaxGfxDpmFreq                  0x33
+#define PPSMC_MSG_PrepareForDriverUnload            0x34
+#define PPSMC_MSG_ReadThrottlerLimit                0x35
+#define PPSMC_MSG_QueryValidMcaCount                0x36
+#define PPSMC_MSG_McaBankDumpDW                     0x37
+#define PPSMC_MSG_GetCTFLimit                       0x38
+#define PPSMC_MSG_ClearMcaOnRead                    0x39
+#define PPSMC_MSG_QueryValidMcaCeCount              0x3A
+#define PPSMC_MSG_McaBankCeDumpDW                   0x3B
+#define PPSMC_MSG_SelectPLPDMode                    0x40
+#define PPSMC_MSG_PmLogReadSample                   0x41
+#define PPSMC_MSG_PmLogGetTableVersion              0x42
+#define PPSMC_MSG_RmaDueToBadPageThreshold          0x43
+#define PPSMC_MSG_SetThrottlingPolicy               0x44
+#define PPSMC_MSG_SetPhaseDetectCSBWThreshold       0x45
+#define PPSMC_MSG_SetPhaseDetectFreqHigh            0x46
+#define PPSMC_MSG_SetPhaseDetectFreqLow             0x47
+#define PPSMC_MSG_SetPhaseDetectDownHysterisis      0x48
+#define PPSMC_MSG_SetPhaseDetectAlphaX1e6           0x49
+#define PPSMC_MSG_SetPhaseDetectOnOff               0x4A
+#define PPSMC_MSG_GetPhaseDetectResidency           0x4B
+#define PPSMC_MSG_UpdatePccWaitDecMaxStr            0x4C
+#define PPSMC_MSG_ResetSDMA                         0x4D
+#define PPSMC_MSG_GetRasTableVersion                0x4E
+#define PPSMC_MSG_GetRmaStatus                      0x4F
+#define PPSMC_MSG_GetErrorCount                     0x50
+#define PPSMC_MSG_GetBadPageCount                   0x51
+#define PPSMC_MSG_GetBadPageInfo                    0x52
+#define PPSMC_MSG_GetBadPagePaAddrLoHi              0x53
+#define PPSMC_MSG_SetTimestampLoHi                  0x54
+#define PPSMC_MSG_GetTimestampLoHi                  0x55
+#define PPSMC_MSG_GetRasPolicy                      0x56
+#define PPSMC_MSG_DumpErrorRecord                   0x57
+#define PPSMC_MSG_EraseRasTable                     0x58
+#define PPSMC_MSG_GetStaticMetricsTable             0x59
+#define PPSMC_Message_Count                         0x5A
+
+//PPSMC Reset Types for driver msg argument
+#define PPSMC_RESET_TYPE_DRIVER_MODE_1_RESET        0x1
+#define PPSMC_RESET_TYPE_DRIVER_MODE_2_RESET	      0x2
+#define PPSMC_RESET_TYPE_DRIVER_MODE_3_RESET        0x3
+
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
+//PLPD modes
+#define PPSMC_PLPD_MODE_DEFAULT                     0x1
+#define PPSMC_PLPD_MODE_OPTIMIZED                   0x2
+
+typedef uint32_t PPSMC_Result;
+typedef uint32_t PPSMC_MSG;
+
+#endif
-- 
2.46.0


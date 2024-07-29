Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2607C3DA49
	for <amd-gfx@archiver.kernel.org>; Mon, 29 Jul 2024 01:26:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4294110E0A9;
	Mon, 29 Jul 2024 01:26:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pshLKpkC";
	dkim-atps=neutral
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EACB910E0A9
 for <amd-gfx@lists.freedesktop.org>; Mon, 29 Jul 2024 01:26:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VkLxVZs3BadwaZlPGcNneEnSwtZ9jF9Yli/zifKuxAyBOGifZ6WuBPV/UTnXbqMCIQnGtvx8WHo0ax0zzM5av1G0a8y8JLjcYuajs2U56UNO1cQIicepdkZYLm5kKafIgIgK50UtgDenAQ7Bb/aVAbzyvHIZCTnWzScpBFKLOosf1W6wBkcgQX/mD5k+gaOQqGhLNjX2xSu66wBU2zaT39ozt2HiKqgy111WyUrIp0FZCGeqjtZZwmbK7KIZHbL/7t+VgrdMWjEj6ZBUo/AIXWrsflX72YUiLxOfbb/xK9KwAt5YqXnsDCNlcz2TPgv1yHKCLTD5qNXQ0Q8nfIXwHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZKdVjHkf5KSqWU+hW7dU2oZ2Y5l/PkWsHf/GM9R/d3g=;
 b=aGI2Zt4NTaV2RWhcnAmLPKmKWr+6gPxo9oWZrPb/Iv0N5p3EDCLhBISUTDrNBbqqcvJJ85+FeaT0FdFnIFmHsDJYao9zvXcuejmnEO9q3U5xnFDq4oYEEegYv0nOT9vU6Sc/CFAN3kDThMWnXtt089a8LD8hyIdoeLQoxrywUT3qPLvwP3FXkiUvBGpdrbd12EPLwhuy40EpioPNHfGzfRhk+DgWMA0JkgAsGP5Pnbhes7K5QPnLzhwwqqqgHf0VMEj/1xpjNoV9bHNKFalWF57xnb+7fSnUyHWFTk4YBTuReEI58avTs3lXqBss/xQMfg/qDXKG6+JGM4hfFYUSmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZKdVjHkf5KSqWU+hW7dU2oZ2Y5l/PkWsHf/GM9R/d3g=;
 b=pshLKpkC5OCTAq3oWbDpQOGxa04e9MMgJPBAFJJs/wXCO36mjeilP3XEFB+hyVyZ1wk0LBYgQ98WABcq7110jfMzuQVzh1xO6fT9nkH8bdm0dF/ZDP1+htea3KoY5Ry0Cdu+9Vfy1a+HXopXyk7mScTTx49swE4YWLc9JyHCIls=
Received: from BLAP220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::22)
 by LV8PR12MB9153.namprd12.prod.outlook.com (2603:10b6:408:185::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.26; Mon, 29 Jul
 2024 01:25:55 +0000
Received: from BN3PEPF0000B370.namprd21.prod.outlook.com
 (2603:10b6:208:32c:cafe::a9) by BLAP220CA0017.outlook.office365.com
 (2603:10b6:208:32c::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Mon, 29 Jul 2024 01:25:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN3PEPF0000B370.mail.protection.outlook.com (10.167.243.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.11 via Frontend Transport; Mon, 29 Jul 2024 01:25:54 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 28 Jul
 2024 20:25:54 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 28 Jul
 2024 20:25:53 -0500
Received: from kenneth-mlse-vm.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via
 Frontend Transport; Sun, 28 Jul 2024 20:25:52 -0500
From: Kenneth Feng <kenneth.feng@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <kevinyang.wang@amd.com>, Kenneth Feng <kenneth.feng@amd.com>
Subject: [PATCH] drm/amd/pm: update powerplay structure on smu v14.0.2/3
Date: Mon, 29 Jul 2024 09:25:50 +0800
Message-ID: <20240729012550.186285-1-kenneth.feng@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: kenneth.feng@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B370:EE_|LV8PR12MB9153:EE_
X-MS-Office365-Filtering-Correlation-Id: b5fb3450-af95-437c-0fce-08dcaf6d643d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Re701SKFmFH+iORXmmaQ7GAGB5Q475gZw1KSLC+j79AVpUBAojMc3Gsd0apc?=
 =?us-ascii?Q?RU5k/Ih98lX4iyDVQzYzZnFRyA3nzj+FsXNJrtsV7hgdzp6v7Bdd9sxPHzGM?=
 =?us-ascii?Q?FenR4pE2U7z+8KZQZDYL3FtywDi/uFsuarCm+dcw0pd1H2hlbadq5qklQAoF?=
 =?us-ascii?Q?TqPEgow4I/+cXBks0dRvF4W+H51jE7dQXKB7h7VVIcWEwO1JuUjtA4FwzHJO?=
 =?us-ascii?Q?6Fk+GS0Ymg4v5J4ctH4FmOnlhFd/Wr15Zcde+fwoAKe4HZaQMCMRIRmvaQBo?=
 =?us-ascii?Q?gIlneW1HuVINiLNh4gPyeu2GTQSiCZI3RQSg5PR87f7b18JtYU2kGEi3Gms1?=
 =?us-ascii?Q?H9GJKvTaivphlgdtxvG7bnqrD6qHrt5m4eaw0fRf36slLsp2OSuIFPFCv61x?=
 =?us-ascii?Q?xAZ8W5L27LJ/rP1d/qEYcyMuXpL66TV5wbTuMp2fe4ORmggYnJR07nrQG4Cg?=
 =?us-ascii?Q?IpJf6BUi6a4T6deVI6AcWgXjRIJw7gRCqaMX4DqiV5tvg6NvEzNzAObWOiVi?=
 =?us-ascii?Q?vBwlNuR5Wp1Qq2DFDWr/v32MHObbqwh1MY/KeGMgBKx5dR2ZjSeLYkuIfhcK?=
 =?us-ascii?Q?CDFxaKazQJqFeA33vj/+9J5JQ3wAWxwFPeuxeMkvCyFDpd1Rm5QhHrNnK9+r?=
 =?us-ascii?Q?tHb/R1lHkJ2ENhZUM4XMF4xIQI40R+bZ9jgDDgAYyFJpzZoHdNwf7qsqbcxY?=
 =?us-ascii?Q?f+FchrjwrBgq7eqatCfLiNRkWPccl2ESL2bmwgGG92tFT0OV6BLG8+A8A/71?=
 =?us-ascii?Q?QR5KYkm5sDk2eU9VboZMTthvMg1V1rI7kG0ziiLJ72BEjgTY+3XF/JmGkSAa?=
 =?us-ascii?Q?YErU09TPlC79KjB2L/WIhZRtFY57+YQlmBD820RZu2ff1cKdhVWpKPbJIqU1?=
 =?us-ascii?Q?t0ZAdUDRYklwNp95C5ZIT0I+xHC/kUAMsQ1Uf2D0Emp//VoEPOZiHoQOO5pI?=
 =?us-ascii?Q?yCKyTtYxXqAzE/r3QiHr6KRqwOJ2m3dSyyM/1TaF4I6IFOqCB4rKG7remD9d?=
 =?us-ascii?Q?NCsKnMWtsRQUTiws68Et04bO5g+Gv8zk/iJaAsXm6zzKdwH/n/vfgtGU705l?=
 =?us-ascii?Q?ECnO6Qtaf/IoBRXk4jjQ1ZO6seXj4Y00pYdwfi94cH9nbwuR66hEGKc/b+Jl?=
 =?us-ascii?Q?8nqnPeoSOWTNFf3/OL+GqHqViYd2PBinky836K9kH7r4sK8Ag2Hl1FyeFxZr?=
 =?us-ascii?Q?iib75KyOVD8VJN2IEbjg4NBvjj8YpUbNYnZU8ya+JsXuxSiaDzFxYymxNS1e?=
 =?us-ascii?Q?37lh/eNOMoRlTf/17xKSw6wQmq2NzH8pCPO6Hc4QOzqc39f9aUKtekA/Okah?=
 =?us-ascii?Q?T1LEl26qmriqsZ3WZyE+Xx3SFop2+3Wsac9FhKP6PFqQ74H4DJVWecANuQdT?=
 =?us-ascii?Q?3SDzyd4etgGPhMxm777oFEPtrKxR4Clf7FDD3gs6Qm2UH4V2Jlj+4ErMQuSw?=
 =?us-ascii?Q?FT7xuIX+TdVnl+1FOAfGGiqcgA7unL7D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2024 01:25:54.7005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b5fb3450-af95-437c-0fce-08dcaf6d643d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B370.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9153
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

update powerplay structure on smu v14.0.2/3

Signed-off-by: Kenneth Feng <kenneth.feng@amd.com>
---
 .../amd/pm/swsmu/inc/smu_v14_0_2_pptable.h    | 53 +++++++++++++++++--
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0_2_pptable.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0_2_pptable.h
index 4a3fde89aed7..523de8a24ec9 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0_2_pptable.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0_2_pptable.h
@@ -27,7 +27,8 @@
 
 #pragma pack(push, 1)
 
-#define SMU_14_0_2_TABLE_FORMAT_REVISION 3
+#define SMU_14_0_2_TABLE_FORMAT_REVISION 23
+#define SMU_14_0_2_CUSTOM_TABLE_FORMAT_REVISION 1
 
 // POWERPLAYTABLE::ulPlatformCaps
 #define SMU_14_0_2_PP_PLATFORM_CAP_POWERPLAY        0x1     // This cap indicates whether CCC need to show Powerplay page.
@@ -43,6 +44,7 @@
 #define SMU_14_0_2_PP_THERMALCONTROLLER_NONE        0
 
 #define SMU_14_0_2_PP_OVERDRIVE_VERSION             0x1     // TODO: FIX OverDrive Version TBD
+#define SMU_14_0_2_PP_CUSTOM_OVERDRIVE_VERSION 0x1
 #define SMU_14_0_2_PP_POWERSAVINGCLOCK_VERSION      0x01    // Power Saving Clock Table Version 1.00
 
 enum SMU_14_0_2_OD_SW_FEATURE_CAP
@@ -107,6 +109,7 @@ enum SMU_14_0_2_PWRMODE_SETTING
     SMU_14_0_2_PMSETTING_ACOUSTIC_LIMIT_RPM_BALANCE,
     SMU_14_0_2_PMSETTING_ACOUSTIC_LIMIT_RPM_TURBO,
     SMU_14_0_2_PMSETTING_ACOUSTIC_LIMIT_RPM_RAGE,
+    SMU_14_0_2_PMSETTING_COUNT
 };
 #define SMU_14_0_2_MAX_PMSETTING 32 // Maximum Number of PowerMode Settings
 
@@ -127,15 +130,23 @@ struct smu_14_0_2_overdrive_table
     int16_t pm_setting[SMU_14_0_2_MAX_PMSETTING];                               // Optimized power mode feature settings
 };
 
+enum smu_14_0_3_pptable_source
+{
+    PPTABLE_SOURCE_IFWI             = 0,
+    PPTABLE_SOURCE_DRIVER_HARDCODED = 1,
+    PPTABLE_SOURCE_PPGEN_REGISTRY   = 2,
+    PPTABLE_SOURCE_MAX              = PPTABLE_SOURCE_PPGEN_REGISTRY,
+};
+
 struct smu_14_0_2_powerplay_table
 {
     struct atom_common_table_header header;                 // header.format_revision = 3 (HAS TO MATCH SMU_14_0_2_TABLE_FORMAT_REVISION), header.content_revision = ? structuresize is calculated by PPGen.
     uint8_t table_revision;                                 // PPGen use only: table_revision = 3
-    uint8_t padding;                                        // Padding 1 byte to align table_size offset to 6 bytes (pmfw_start_offset, for PMFW to know the starting offset of PPTable_t).
+    uint8_t pptable_source;                      			// PPGen UI dropdown box based on smu_14_0_3_pptable_source enum.
     uint16_t pmfw_pptable_start_offset;                     // The start offset of the pmfw portion. i.e. start of PPTable_t (start of SkuTable_t)
     uint16_t pmfw_pptable_size;                             // The total size of pmfw_pptable, i.e PPTable_t.
-    uint16_t pmfw_pfe_table_start_offset;                   // The start offset of the PFE_Settings_t within pmfw_pptable.
-    uint16_t pmfw_pfe_table_size;                           // The size of PFE_Settings_t.
+    uint16_t pmfw_sku_table_start_offset;        			// DO NOT CHANGE ORDER; The absolute start offset of the SkuTable_t (within smu_14_0_3_powerplay_table).
+    uint16_t pmfw_sku_table_size;                			// DO NOT CHANGE ORDER; The size of SkuTable_t.
     uint16_t pmfw_board_table_start_offset;                 // The start offset of the BoardTable_t within pmfw_pptable.
     uint16_t pmfw_board_table_size;                         // The size of BoardTable_t.
     uint16_t pmfw_custom_sku_table_start_offset;            // The start offset of the CustomSkuTable_t within pmfw_pptable.
@@ -159,6 +170,40 @@ struct smu_14_0_2_powerplay_table
     PPTable_t smc_pptable;                          // PPTable_t in driver_if.h -- as requested by PMFW, this offset should start at a 32-byte boundary, and the table_size above should remain at offset=6 bytes
 };
 
+enum SMU_14_0_2_CUSTOM_OD_SW_FEATURE_CAP
+{
+    SMU_14_0_2_CUSTOM_ODCAP_POWER_MODE = 0,
+    SMU_14_0_2_CUSTOM_ODCAP_COUNT
+};
+
+enum SMU_14_0_2_CUSTOM_OD_FEATURE_SETTING_ID
+{
+    SMU_14_0_2_CUSTOM_ODSETTING_POWER_MODE = 0,
+    SMU_14_0_2_CUSTOM_ODSETTING_COUNT,
+};
+
+struct smu_14_0_2_custom_overdrive_table
+{
+    uint8_t revision;
+    uint8_t reserve[3];
+    uint8_t cap[SMU_14_0_2_CUSTOM_ODCAP_COUNT];
+    int32_t max[SMU_14_0_2_CUSTOM_ODSETTING_COUNT];
+    int32_t min[SMU_14_0_2_CUSTOM_ODSETTING_COUNT];
+    int16_t pm_setting[SMU_14_0_2_PMSETTING_COUNT];
+};
+
+struct smu_14_0_3_custom_powerplay_table
+{
+    uint8_t custom_table_revision;
+    uint16_t custom_table_size;
+    uint16_t custom_sku_table_offset;
+    uint32_t custom_platform_caps;
+    uint16_t software_shutdown_temp;
+    struct smu_14_0_2_custom_overdrive_table custom_overdrive_table;
+    uint32_t reserve[8];
+    CustomSkuTable_t custom_sku_table_pmfw;
+};
+
 #pragma pack(pop)
 
 #endif
-- 
2.34.1


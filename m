Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B67CFD116FC
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 10:14:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45F8C10E364;
	Mon,  1 Dec 2025 10:14:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4KkZ4j1x";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011016.outbound.protection.outlook.com [40.107.208.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4725110E36F
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 10:14:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JBfJiEoxuyTjFeLgW/F5ReQzcpaX7zYYGyO3eoSDPExExEnhfdtrG93h3RqzwAd9wx7MJbXbBK1o9PK4KSCOVLE5r90qU6rnLHgaKeMXZlmhNkWaO/RtoCrUaBvoqvdywAAoJrUd15GRPfNO2sagD0AWVpCwh0yImmf7B707dy0G1WBpxBno/7DjQHf784FYWRI5DNJbtnhUGQwo0NzJ9ayqH3q7CbyRpAR7CWEVFhBF0gmQg1Pj9TP60hRIUyAQn69zfaTIawge/GtYk4GWBCm1YndPZrDJrTMUoQBvpyjBTJetCWDMTN4p0rYgZaYfpbjHiaiqyeGBH+F/7kF3yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5nuAdfHLZuuaAmPs5ZtBL5nvqZ08pgWEiHussv+I+RQ=;
 b=pMGouallF1vV8W0zZHe6zN1q9JeSpv5eyGi+ypnDYihol16psSMzZorEwHvF9IhS8aA7Wo/nPk7hYKlYwts7GhjO4yijwDpbKBtzhPjoPsJg0D1n/eC6UQ/J/6Sg+wY8QXjECQ9eZhb4ZhUDCNTcS7W0XypGQipkC6HjODl3/qYcn7vdkTNPLdGylqM3NfGEzuMzVAbte7zE79elzPzAf+ZA9xCHddzxEvxH61HxrGAZdOsv7nK9Dc6Kp6B3hgxXt2jEP/hqCoSs41v62bYjlsPfb5S+/yXSy4ujMGy9RPq4MDJWd6qLPiCgmN2wy21d91YLgwdbch6qrOdKswSiWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5nuAdfHLZuuaAmPs5ZtBL5nvqZ08pgWEiHussv+I+RQ=;
 b=4KkZ4j1xRc8aRAkrqRz+fe67a+Pn/dcIjzV+cc7X2kDtwTC3ae9+K20rc3OxIl81r5uMPX8Jq0APQebh1efgWHsGXWBWJEpk4Dr0oBqMHtEmDUIYY9XVCvt/WJRQ3q0Py2qS1mNCdc4ZWAp9ap2UFru3auTW6gmoDUcPYenFjjQ=
Received: from CH0P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::19)
 by BY5PR12MB4258.namprd12.prod.outlook.com (2603:10b6:a03:20d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 10:14:27 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::c) by CH0P223CA0008.outlook.office365.com
 (2603:10b6:610:116::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 10:14:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 10:14:27 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 04:14:25 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 08/17] drm/amd/pm: Use generic pcie dpm table for SMUv14
Date: Mon, 1 Dec 2025 15:33:21 +0530
Message-ID: <20251201101331.101584-9-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251201101331.101584-1-lijo.lazar@amd.com>
References: <20251201101331.101584-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|BY5PR12MB4258:EE_
X-MS-Office365-Filtering-Correlation-Id: adb89e97-6ce7-4b13-f34e-08de30c268e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hI6VDvvY9O0dYT2xS8NRYcxl3lL2M0fMmko1qWwqGi/DmnKi9/9t+PGHzTuM?=
 =?us-ascii?Q?jGMeBlSH1sNQP2Qg0r6HtHYvi0Y+glVw3c5O+K7P2NOmBptgQ/fDyv0yzs86?=
 =?us-ascii?Q?teLe7O/0SDokdpSczRgl4nkocEVxutadKD7G+E8+j6FJL5xNxYKOSo9qww5X?=
 =?us-ascii?Q?yd5BXPSg6wvPZtFH5pnkSNGHMZWSiRIbf9UfwE2knQrRMa62m54RoY0zCfmv?=
 =?us-ascii?Q?p4J5AsIS++TWuPZQ4AfVIDRyHWRA8Q8buT178cRADssqZbFGPB0vrMdL/GJz?=
 =?us-ascii?Q?ncxtsHU41WBC33TAAdbVYM7XYvauRc2uZvSgG0HMi2m/cl/5fuVp/jhXpA4S?=
 =?us-ascii?Q?Ia/2l5ejgR7i4FXpdiYNMIviKbJ8LlKc3WNKvxbU02165ctiJ8GfW/qV3mIN?=
 =?us-ascii?Q?JjHbTqC7Z/U4NQtxm0mDh6JG3FzhNdAsbvhEAkNssKZvHSlxGntRcGoKRED1?=
 =?us-ascii?Q?oWwLRzfX0hbRDPK5ZLLgLNAZGvzuOXt4YLiCHbCG0j7BsTfsHCZ52Rs90J1L?=
 =?us-ascii?Q?X0zEd3FBHdb5GtUdz3ZWcti0exhShxdIdSs2Vp6pBg63cf0+dT8B8wHC7DgT?=
 =?us-ascii?Q?HVIoNYOH6NbotkWog+RFd3ag28/JnafxMmvtvBpcYXng+nxqDAJzMtK+c6pf?=
 =?us-ascii?Q?HkngrtjhmD36AjYc7fytptZfMYtA1Rw9TBNLWvpwT/+ALi05IBv2VymjSkjl?=
 =?us-ascii?Q?QPB+qE+YbS2AD9KnBcX4mJXxdhejCz+DYj8FsinANae3Xb7eenWY3SN1SADC?=
 =?us-ascii?Q?NEWsr6AA9iqbjX2ReelQKrk8MldqxC932/3Xxw8z/IMw7UFCoq5V5xSkFY77?=
 =?us-ascii?Q?o4TiNzgSID4k/4Iudb1Pk5EZK0cYNoT7tUGRzQEx9K0h6xJFhPU+3SqDAhTV?=
 =?us-ascii?Q?1y0yNDLI+w/gf4DFrVDZLM4YkXcK24u5LTNgSig3idRPclavJq6DWI7T1Npw?=
 =?us-ascii?Q?181Tiw84JeF8GiIwiasa1CQmOtUuk3BN9CohPCj0hnE2e1nk17asvl1gdgd7?=
 =?us-ascii?Q?9Sv0Qw9Xb5gwE0zMaXL1cNhAUrwfTDYtpNqjm7gglJvgeFyonn28pfllnXRU?=
 =?us-ascii?Q?MW8B3enAMCakFhPz+X+t0gikNTDTAtyVhINfaN3wglb/2iBTx1GTLon4lScn?=
 =?us-ascii?Q?sh0jIfj0AQy5D2SJhSedvkEEzlEaXijXTrMow3Jwn7V+j2cXlO3hdVFIBEbo?=
 =?us-ascii?Q?9nBf+olqO/vG6mx19OSRHUGBFzE+okW1zWWL8mhMmxltFPLheSzGvx7WAw4t?=
 =?us-ascii?Q?Uj3SQOY2o2pWydozKvCvSsy8MKBg6eoFeqth5OlBrzzw4ImUQS5EqJST84In?=
 =?us-ascii?Q?/+ttPaP+I40gmlh3leH0DaYWgXleVwxMQdf2xbnWvZo/QgRE2w7x2KajmPiU?=
 =?us-ascii?Q?qkFujQqqLFhVhVzmKJX+UEQ3tzD+NgoxcwjTAdnMrdLAr1nX9JL/uGImQdZd?=
 =?us-ascii?Q?kjm8XzAA3HjCJWgxX52sEUVdk3LpQfS3j33BV0bi390+PQYDI3o3DamFNwdI?=
 =?us-ascii?Q?B4YxbIBWKuPi+9sslHtnqzB0kYuPtpjcr3Vl9/ZIVXIeeubSvqVaQ1gKpMYf?=
 =?us-ascii?Q?sgOgi10FyKxGBTZ9bIQ=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 10:14:27.4536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adb89e97-6ce7-4b13-f34e-08de30c268e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4258
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

Use smu_pcie_table for SMUv14 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h  |  9 +----
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  | 36 +++++++++----------
 2 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
index 5b6fa8fdce2d..4ecec85b8404 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v14_0.h
@@ -66,13 +66,6 @@ struct smu_14_0_max_sustainable_clocks {
 	uint32_t soc_clock;
 };
 
-struct smu_14_0_pcie_table {
-	uint8_t  pcie_gen[MAX_PCIE_CONF];
-	uint8_t  pcie_lane[MAX_PCIE_CONF];
-	uint16_t clk_freq[MAX_PCIE_CONF];
-	uint32_t num_of_link_levels;
-};
-
 struct smu_14_0_dpm_tables {
 	struct smu_dpm_table        soc_table;
 	struct smu_dpm_table        gfx_table;
@@ -85,7 +78,7 @@ struct smu_14_0_dpm_tables {
 	struct smu_dpm_table        display_table;
 	struct smu_dpm_table        phy_table;
 	struct smu_dpm_table        fclk_table;
-	struct smu_14_0_pcie_table       pcie_table;
+	struct smu_pcie_table       pcie_table;
 };
 
 struct smu_14_0_dpm_context {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
index daa51364cb24..596cdba0a8b4 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c
@@ -1046,7 +1046,7 @@ static int smu_v14_0_2_emit_clk_levels(struct smu_context *smu,
 	OverDriveTableExternal_t *od_table =
 		(OverDriveTableExternal_t *)smu->smu_table.overdrive_table;
 	struct smu_dpm_table *single_dpm_table;
-	struct smu_14_0_pcie_table *pcie_table;
+	struct smu_pcie_table *pcie_table;
 	uint32_t gen_speed, lane_width;
 	int i, curr_freq, size = *offset, start_offset = *offset;
 	int32_t min_value, max_value;
@@ -1150,7 +1150,7 @@ static int smu_v14_0_2_emit_clk_levels(struct smu_context *smu,
 			return ret;
 
 		pcie_table = &(dpm_context->dpm_tables.pcie_table);
-		for (i = 0; i < pcie_table->num_of_link_levels; i++)
+		for (i = 0; i < pcie_table->lclk_levels; i++)
 			size += sysfs_emit_at(buf, size, "%d: %s %s %dMhz %s\n", i,
 					(pcie_table->pcie_gen[i] == 0) ? "2.5GT/s," :
 					(pcie_table->pcie_gen[i] == 1) ? "5.0GT/s," :
@@ -1164,7 +1164,7 @@ static int smu_v14_0_2_emit_clk_levels(struct smu_context *smu,
 					(pcie_table->pcie_lane[i] == 5) ? "x12" :
 					(pcie_table->pcie_lane[i] == 6) ? "x16" :
 					(pcie_table->pcie_lane[i] == 7) ? "x32" : "",
-					pcie_table->clk_freq[i],
+					pcie_table->lclk_freq[i],
 					(gen_speed == DECODE_GEN_SPEED(pcie_table->pcie_gen[i])) &&
 					(lane_width == DECODE_LANE_WIDTH(pcie_table->pcie_lane[i])) ?
 					"*" : "");
@@ -1454,9 +1454,9 @@ static int smu_v14_0_2_update_pcie_parameters(struct smu_context *smu,
 					      uint8_t pcie_width_cap)
 {
 	struct smu_14_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-	struct smu_14_0_pcie_table *pcie_table =
+	struct smu_pcie_table *pcie_table =
 				&dpm_context->dpm_tables.pcie_table;
-	int num_of_levels;
+	int lclk_levels;
 	uint32_t smu_pcie_arg;
 	uint32_t link_level;
 	struct smu_table_context *table_context = &smu->smu_table;
@@ -1465,34 +1465,34 @@ static int smu_v14_0_2_update_pcie_parameters(struct smu_context *smu,
 	int ret = 0;
 	int i;
 
-	pcie_table->num_of_link_levels = 0;
+	pcie_table->lclk_levels = 0;
 	for (link_level = 0; link_level < NUM_LINK_LEVELS; link_level++) {
 		if (!skutable->PcieGenSpeed[link_level] &&
 		    !skutable->PcieLaneCount[link_level] &&
 		    !skutable->LclkFreq[link_level])
 			continue;
 
-		pcie_table->pcie_gen[pcie_table->num_of_link_levels] =
+		pcie_table->pcie_gen[pcie_table->lclk_levels] =
 					skutable->PcieGenSpeed[link_level];
-		pcie_table->pcie_lane[pcie_table->num_of_link_levels] =
+		pcie_table->pcie_lane[pcie_table->lclk_levels] =
 					skutable->PcieLaneCount[link_level];
-		pcie_table->clk_freq[pcie_table->num_of_link_levels] =
+		pcie_table->lclk_freq[pcie_table->lclk_levels] =
 					skutable->LclkFreq[link_level];
-		pcie_table->num_of_link_levels++;
+		pcie_table->lclk_levels++;
 	}
-	num_of_levels = pcie_table->num_of_link_levels;
-	if (!num_of_levels)
+	lclk_levels = pcie_table->lclk_levels;
+	if (!lclk_levels)
 		return 0;
 
 	if (!(smu->adev->pm.pp_feature & PP_PCIE_DPM_MASK)) {
-		if (pcie_table->pcie_gen[num_of_levels - 1] < pcie_gen_cap)
-			pcie_gen_cap = pcie_table->pcie_gen[num_of_levels - 1];
+		if (pcie_table->pcie_gen[lclk_levels - 1] < pcie_gen_cap)
+			pcie_gen_cap = pcie_table->pcie_gen[lclk_levels - 1];
 
-		if (pcie_table->pcie_lane[num_of_levels - 1] < pcie_width_cap)
-			pcie_width_cap = pcie_table->pcie_lane[num_of_levels - 1];
+		if (pcie_table->pcie_lane[lclk_levels - 1] < pcie_width_cap)
+			pcie_width_cap = pcie_table->pcie_lane[lclk_levels - 1];
 
 		/* Force all levels to use the same settings */
-		for (i = 0; i < num_of_levels; i++) {
+		for (i = 0; i < lclk_levels; i++) {
 			pcie_table->pcie_gen[i] = pcie_gen_cap;
 			pcie_table->pcie_lane[i] = pcie_width_cap;
 			smu_pcie_arg = i << 16;
@@ -1507,7 +1507,7 @@ static int smu_v14_0_2_update_pcie_parameters(struct smu_context *smu,
 				break;
 		}
 	} else {
-		for (i = 0; i < num_of_levels; i++) {
+		for (i = 0; i < lclk_levels; i++) {
 			if (pcie_table->pcie_gen[i] > pcie_gen_cap ||
 				pcie_table->pcie_lane[i] > pcie_width_cap) {
 				pcie_table->pcie_gen[i] = pcie_table->pcie_gen[i] > pcie_gen_cap ?
-- 
2.49.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72434D116FA
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 10:14:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAF6C10E36E;
	Mon,  1 Dec 2025 10:14:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="U3muLMTx";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010027.outbound.protection.outlook.com
 [52.101.193.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE10C10E359
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 10:14:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBF3NKK9aJIZ9tFc4sq928I+VbGMigWe5r+GZAp5jiS3T1WHAAHfuI2CjLA/Xg8Qs5nDS1gb+cWoGOB9DCNesWuyKcYCrMNalXPpGQvFKdr0UoVmS2BMI4Xv8Pmgt8Vm0RoWoVAMQ3qNH7R6OaEJi/2KN4Dkm6hkWuQGsaWPeZpwufl3zcQcW1qVY/KMGuSee0BFQjlSjZEonGZq5xg2Vz4b98JhGwmOv8nudBtLTNPxKGhBVbAT3ehS64bCTguq5+GUpn7401JsohOge32JbqxWb4VUmBAQuA492MGWx5+qSVEpV3hJgONFGV1Bs+FUCrPYi4Ope0+6garJkrtpbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyJEEKApu+J0hgcouFfObVG164+GVNtVQs9a3QWOzyU=;
 b=MIJKSe1ax70N61/wLGvc35vaeA+SCS2BSG828ZRIUuTTsp5TJLHaRh3I5vRRxX/KeyptIGGXlJrHLhorHvTqTm6bn0g6Miphr9zamx9xqAg4ZtvwHwk2D/Hj6h0lcN5bNXxURLj5MUltQS40zrjToMC7FwZq+SkATUx5XNNL8/+Lus+ZcF1zx8482TS0IXjjOCn/mlZOiFauMMZK2ENmGpFYzExCTgr//sN+8oiGSZnOqs0tXRWqGtCqmhus5L8dBhE+zBensi+IE3f8HPbBexIuixy7I/q00LwGuixOsDFW1PATlrUxxvCGtQ1f3aIns/QZPlfgafA3NuryhUqK+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyJEEKApu+J0hgcouFfObVG164+GVNtVQs9a3QWOzyU=;
 b=U3muLMTxPb5VeU8FnoLAEpqNIdHNoenJAUGHEuhrq708OuOl1Riuepn29BH+/0D1q46sdorBsUwc6ZyPlH6hUNP3NiD8mVsmf0FHfZBOEzFi/Tect6euymA3hKpF5DpeZQGT4PFElJrBkO4zpHf4DQ4+hRM7eR11zVXr3dH3lP0=
Received: from CH5P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:1f3::10)
 by CY1PR12MB9559.namprd12.prod.outlook.com (2603:10b6:930:fd::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 10:14:25 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:1f3:cafe::aa) by CH5P223CA0002.outlook.office365.com
 (2603:10b6:610:1f3::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 10:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 10:14:25 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 04:14:23 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 07/17] drm/amd/pm: Use generic pcie dpm table for SMUv13
Date: Mon, 1 Dec 2025 15:33:20 +0530
Message-ID: <20251201101331.101584-8-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|CY1PR12MB9559:EE_
X-MS-Office365-Filtering-Correlation-Id: 99440931-ca9f-4cb9-294d-08de30c267e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CZkFWqAOUmw5whafxor+b8NvaRfhmX35pluPF4QCez1JjRQqk6cct/BpUYOp?=
 =?us-ascii?Q?6EKRIGFg1OCLHgvZjeHYxjM30PoIa71L98sEI2Jq96I4gD3rpDghDlH/fDjB?=
 =?us-ascii?Q?f80iNx74McddY4R4Z6QZExz7HIvhezYDcCAY8VI/2Qoid66TXWijuVsQADZr?=
 =?us-ascii?Q?u3DyYyH9azBKwMWmahNYLEhCbx00oJbZqTJnvillZ7QEABRl6EPyqZkKH49K?=
 =?us-ascii?Q?MCM5VtAe2UqeGy7RN+zcKbyJp9hdYmNDdfyNtJ2sIVRFqyYAM3pnNCmwSQJA?=
 =?us-ascii?Q?s2cVXVVodUCJCWew6/69duKg2NUtaxY9HFaVwmD/Dtsud2xSXLTFiLxpyCP4?=
 =?us-ascii?Q?LN0jK4OiTGSkJx4NcvY/ksF8PzUwTOYJO61+TpDh5Pn37IE0LKuEI2j026/g?=
 =?us-ascii?Q?UDfGpGOOYwhGDTKrE6wbI1kC1O5xjaTziZKwLoKwdqTqkEAridmMGRc2rbft?=
 =?us-ascii?Q?AZ5hd37man3oHW0wQ5XgRBQNdAorTbOYn9NVZEJJbSkFLZ0kv4XtfD+RkhLx?=
 =?us-ascii?Q?qOqTKG2R9JHHpn027GDHU3YPr0iTGUj3KJC5cK94/fgi9QmKNLg5gr4zBZ1N?=
 =?us-ascii?Q?sMkE/q7l1IYu21cr/ZHAHPw5u2hk8N3y30f1hO3DA/SpA8fG9A36B61A1gb+?=
 =?us-ascii?Q?FIk8NHavvB7S51D2tSVsbNdVWfWjQ+dyHZtep9oSuqOR5FOfX8C+Bjrm3y2g?=
 =?us-ascii?Q?VzN8QOP745tta+GKMelHZPae2/FlA8foxuyXQYXz9hrhbwLszRJoOSFTCBLB?=
 =?us-ascii?Q?LYqooFAXwGUMgoMMbuFfisZHfKS8hv7cjNEsNeew77NDTrAUEKRHCOzHxvpV?=
 =?us-ascii?Q?xE3ovRH7mSS9hfAkTj5egTnrgNx0RYvB8XKewaVpPiSER/dJictk3MOXO7Kx?=
 =?us-ascii?Q?FdR7Z6GohJXpKjOY6L3yjnKrC5wxGOq9CcdyTspbcFUt1slVOmRVVw7lJC1E?=
 =?us-ascii?Q?Ttqdvt9O2vz4gqFwtJyQHx97N8VHPHmmOIZnwjM7eR9gZzffK8u//EekGubM?=
 =?us-ascii?Q?wesll3CvuPGlrJA3AkWTpqdhM1YIVGb5K9IOmUP6hs1ghen1Mz3NRGru16p5?=
 =?us-ascii?Q?URw6w4rAvIlVXSlf91BCAe51RhYWgDU6XmXtwBAIv2rYyueAnPoQfcAmzLbv?=
 =?us-ascii?Q?F799ZYPy/pYgNvG/tMUm7R9sL48ZEc0PEemSmfLduNUUSA7Pxq8mZTFXtYJ9?=
 =?us-ascii?Q?pFCiV80nJuK9Vs8WEfq2Yoj4/YnI16qfWGQKZpI0StbJohHoce5Ij4BBRilU?=
 =?us-ascii?Q?fxUGphEcLjoWFKNp/9HKxNf4V+AX5iBeVfoimwBQjQxeuNjoFCIFrt3Kcp+u?=
 =?us-ascii?Q?IoXLox+EREIh5aNfmM/NOQchMF+jXuiiGbUAPqzKB2j3N3ljQCNek956YXYO?=
 =?us-ascii?Q?HdtmFktNxlcqwCA+ukvc/oI2n88lf1PDMibWN8urvJW3ArFEPtCWuT5RCxCy?=
 =?us-ascii?Q?9ajrLlRMS4uwZCRWoj8Oq6znF2wxirh7ReieU1qRR7/fmeK0GAv6vqMLSiv5?=
 =?us-ascii?Q?BtR5FOl8C2v1I+VrmGRAvenR0Z64jznO4RLsZ7azzrgVE2GMbBsrFgHTQbPq?=
 =?us-ascii?Q?zCK50aVYvupT5zldAjU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 10:14:25.7256 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99440931-ca9f-4cb9-294d-08de30c267e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9559
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

Use smu_pcie_table for SMUv13 SOCs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h  |  9 +--
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  5 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 64 +++++++++++--------
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  | 64 +++++++++++--------
 4 files changed, 75 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
index 4d1180030c8a..c35cbb2aee93 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
+++ b/drivers/gpu/drm/amd/pm/swsmu/inc/smu_v13_0.h
@@ -71,13 +71,6 @@ struct smu_13_0_max_sustainable_clocks {
 	uint32_t soc_clock;
 };
 
-struct smu_13_0_pcie_table {
-	uint8_t  pcie_gen[MAX_PCIE_CONF];
-	uint8_t  pcie_lane[MAX_PCIE_CONF];
-	uint16_t clk_freq[MAX_PCIE_CONF];
-	uint32_t num_of_link_levels;
-};
-
 struct smu_13_0_dpm_tables {
 	struct smu_dpm_table        soc_table;
 	struct smu_dpm_table        gfx_table;
@@ -90,7 +83,7 @@ struct smu_13_0_dpm_tables {
 	struct smu_dpm_table        display_table;
 	struct smu_dpm_table        phy_table;
 	struct smu_dpm_table        fclk_table;
-	struct smu_13_0_pcie_table       pcie_table;
+	struct smu_pcie_table        pcie_table;
 };
 
 struct smu_13_0_dpm_context {
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
index 417c6f42c4fa..7340237b3c35 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c
@@ -2374,9 +2374,8 @@ int smu_v13_0_update_pcie_parameters(struct smu_context *smu,
 				     uint8_t pcie_width_cap)
 {
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-	struct smu_13_0_pcie_table *pcie_table =
-				&dpm_context->dpm_tables.pcie_table;
-	int num_of_levels = pcie_table->num_of_link_levels;
+	struct smu_pcie_table *pcie_table = &dpm_context->dpm_tables.pcie_table;
+	int num_of_levels = pcie_table->lclk_levels;
 	uint32_t smu_pcie_arg;
 	int ret = 0;
 	int i;
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index bc8293f45a13..adebf93c1557 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1186,7 +1186,8 @@ static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 		(OverDriveTableExternal_t *)smu->smu_table.overdrive_table;
 	int i, curr_freq, size = *offset, start_offset = *offset;
 	struct smu_dpm_table *single_dpm_table;
-	struct smu_13_0_pcie_table *pcie_table;
+	struct smu_pcie_table *pcie_table;
+	uint32_t pcie_speed, pcie_width;
 	uint32_t gen_speed, lane_width;
 	int32_t min_value, max_value;
 	int ret = 0;
@@ -1289,22 +1290,30 @@ static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 			return ret;
 
 		pcie_table = &(dpm_context->dpm_tables.pcie_table);
-		for (i = 0; i < pcie_table->num_of_link_levels; i++)
-			size += sysfs_emit_at(buf, size, "%d: %s %s %dMhz %s\n", i,
-					(pcie_table->pcie_gen[i] == 0) ? "2.5GT/s," :
-					(pcie_table->pcie_gen[i] == 1) ? "5.0GT/s," :
-					(pcie_table->pcie_gen[i] == 2) ? "8.0GT/s," :
-					(pcie_table->pcie_gen[i] == 3) ? "16.0GT/s," : "",
-					(pcie_table->pcie_lane[i] == 1) ? "x1" :
-					(pcie_table->pcie_lane[i] == 2) ? "x2" :
-					(pcie_table->pcie_lane[i] == 3) ? "x4" :
-					(pcie_table->pcie_lane[i] == 4) ? "x8" :
-					(pcie_table->pcie_lane[i] == 5) ? "x12" :
-					(pcie_table->pcie_lane[i] == 6) ? "x16" : "",
-					pcie_table->clk_freq[i],
-					(gen_speed == DECODE_GEN_SPEED(pcie_table->pcie_gen[i])) &&
-					(lane_width == DECODE_LANE_WIDTH(pcie_table->pcie_lane[i])) ?
-					"*" : "");
+		for (i = 0; i < pcie_table->lclk_levels; i++) {
+			pcie_speed = DECODE_GEN_SPEED(pcie_table->pcie_gen[i]);
+			pcie_width =
+				DECODE_LANE_WIDTH(pcie_table->pcie_lane[i]);
+			size += sysfs_emit_at(
+				buf, size, "%d: %s %s %dMhz %s\n", i,
+				(pcie_table->pcie_gen[i] == 0) ? "2.5GT/s," :
+				(pcie_table->pcie_gen[i] == 1) ? "5.0GT/s," :
+				(pcie_table->pcie_gen[i] == 2) ? "8.0GT/s," :
+				(pcie_table->pcie_gen[i] == 3) ? "16.0GT/s," :
+								 "",
+				(pcie_table->pcie_lane[i] == 1) ? "x1" :
+				(pcie_table->pcie_lane[i] == 2) ? "x2" :
+				(pcie_table->pcie_lane[i] == 3) ? "x4" :
+				(pcie_table->pcie_lane[i] == 4) ? "x8" :
+				(pcie_table->pcie_lane[i] == 5) ? "x12" :
+				(pcie_table->pcie_lane[i] == 6) ? "x16" :
+								  "",
+				pcie_table->lclk_freq[i],
+				(gen_speed == pcie_speed &&
+				 lane_width == pcie_width) ?
+					"*" :
+					"");
+		}
 		break;
 
 	case SMU_OD_SCLK:
@@ -3107,8 +3116,7 @@ static int smu_v13_0_0_update_pcie_parameters(struct smu_context *smu,
 				     uint8_t pcie_width_cap)
 {
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-	struct smu_13_0_pcie_table *pcie_table =
-				&dpm_context->dpm_tables.pcie_table;
+	struct smu_pcie_table *pcie_table = &dpm_context->dpm_tables.pcie_table;
 	int num_of_levels;
 	uint32_t smu_pcie_arg;
 	uint32_t link_level;
@@ -3118,7 +3126,7 @@ static int smu_v13_0_0_update_pcie_parameters(struct smu_context *smu,
 	int ret = 0;
 	int i;
 
-	pcie_table->num_of_link_levels = 0;
+	pcie_table->lclk_levels = 0;
 
 	for (link_level = 0; link_level < NUM_LINK_LEVELS; link_level++) {
 		if (!skutable->PcieGenSpeed[link_level] &&
@@ -3126,16 +3134,16 @@ static int smu_v13_0_0_update_pcie_parameters(struct smu_context *smu,
 		    !skutable->LclkFreq[link_level])
 			continue;
 
-		pcie_table->pcie_gen[pcie_table->num_of_link_levels] =
-					skutable->PcieGenSpeed[link_level];
-		pcie_table->pcie_lane[pcie_table->num_of_link_levels] =
-					skutable->PcieLaneCount[link_level];
-		pcie_table->clk_freq[pcie_table->num_of_link_levels] =
-					skutable->LclkFreq[link_level];
-		pcie_table->num_of_link_levels++;
+		pcie_table->pcie_gen[pcie_table->lclk_levels] =
+			skutable->PcieGenSpeed[link_level];
+		pcie_table->pcie_lane[pcie_table->lclk_levels] =
+			skutable->PcieLaneCount[link_level];
+		pcie_table->lclk_freq[pcie_table->lclk_levels] =
+			skutable->LclkFreq[link_level];
+		pcie_table->lclk_levels++;
 	}
 
-	num_of_levels = pcie_table->num_of_link_levels;
+	num_of_levels = pcie_table->lclk_levels;
 	if (!num_of_levels)
 		return 0;
 
diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
index 8f664ef32570..ff9ad5bdf138 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c
@@ -1175,7 +1175,8 @@ static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
 		(OverDriveTableExternal_t *)smu->smu_table.overdrive_table;
 	int i, curr_freq, size = *offset, start_offset = *offset;
 	struct smu_dpm_table *single_dpm_table;
-	struct smu_13_0_pcie_table *pcie_table;
+	struct smu_pcie_table *pcie_table;
+	uint32_t pcie_speed, pcie_width;
 	uint32_t gen_speed, lane_width;
 	int32_t min_value, max_value;
 	int ret = 0;
@@ -1278,22 +1279,30 @@ static int smu_v13_0_7_emit_clk_levels(struct smu_context *smu,
 			return ret;
 
 		pcie_table = &(dpm_context->dpm_tables.pcie_table);
-		for (i = 0; i < pcie_table->num_of_link_levels; i++)
-			size += sysfs_emit_at(buf, size, "%d: %s %s %dMhz %s\n", i,
-					(pcie_table->pcie_gen[i] == 0) ? "2.5GT/s," :
-					(pcie_table->pcie_gen[i] == 1) ? "5.0GT/s," :
-					(pcie_table->pcie_gen[i] == 2) ? "8.0GT/s," :
-					(pcie_table->pcie_gen[i] == 3) ? "16.0GT/s," : "",
-					(pcie_table->pcie_lane[i] == 1) ? "x1" :
-					(pcie_table->pcie_lane[i] == 2) ? "x2" :
-					(pcie_table->pcie_lane[i] == 3) ? "x4" :
-					(pcie_table->pcie_lane[i] == 4) ? "x8" :
-					(pcie_table->pcie_lane[i] == 5) ? "x12" :
-					(pcie_table->pcie_lane[i] == 6) ? "x16" : "",
-					pcie_table->clk_freq[i],
-					(gen_speed == DECODE_GEN_SPEED(pcie_table->pcie_gen[i])) &&
-					(lane_width == DECODE_LANE_WIDTH(pcie_table->pcie_lane[i])) ?
-					"*" : "");
+		for (i = 0; i < pcie_table->lclk_levels; i++) {
+			pcie_speed = DECODE_GEN_SPEED(pcie_table->pcie_gen[i]);
+			pcie_width =
+				DECODE_LANE_WIDTH(pcie_table->pcie_lane[i]);
+			size += sysfs_emit_at(
+				buf, size, "%d: %s %s %dMhz %s\n", i,
+				(pcie_table->pcie_gen[i] == 0) ? "2.5GT/s," :
+				(pcie_table->pcie_gen[i] == 1) ? "5.0GT/s," :
+				(pcie_table->pcie_gen[i] == 2) ? "8.0GT/s," :
+				(pcie_table->pcie_gen[i] == 3) ? "16.0GT/s," :
+								 "",
+				(pcie_table->pcie_lane[i] == 1) ? "x1" :
+				(pcie_table->pcie_lane[i] == 2) ? "x2" :
+				(pcie_table->pcie_lane[i] == 3) ? "x4" :
+				(pcie_table->pcie_lane[i] == 4) ? "x8" :
+				(pcie_table->pcie_lane[i] == 5) ? "x12" :
+				(pcie_table->pcie_lane[i] == 6) ? "x16" :
+								  "",
+				pcie_table->lclk_freq[i],
+				(gen_speed == pcie_speed &&
+				 lane_width == pcie_width) ?
+					"*" :
+					"");
+		}
 		break;
 
 	case SMU_OD_SCLK:
@@ -2711,8 +2720,7 @@ static int smu_v13_0_7_update_pcie_parameters(struct smu_context *smu,
 				     uint8_t pcie_width_cap)
 {
 	struct smu_13_0_dpm_context *dpm_context = smu->smu_dpm.dpm_context;
-	struct smu_13_0_pcie_table *pcie_table =
-				&dpm_context->dpm_tables.pcie_table;
+	struct smu_pcie_table *pcie_table = &dpm_context->dpm_tables.pcie_table;
 	int num_of_levels;
 	int link_level;
 	uint32_t smu_pcie_arg;
@@ -2722,23 +2730,23 @@ static int smu_v13_0_7_update_pcie_parameters(struct smu_context *smu,
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
-					skutable->PcieGenSpeed[link_level];
-		pcie_table->pcie_lane[pcie_table->num_of_link_levels] =
-					skutable->PcieLaneCount[link_level];
-		pcie_table->clk_freq[pcie_table->num_of_link_levels] =
-					skutable->LclkFreq[link_level];
-		pcie_table->num_of_link_levels++;
+		pcie_table->pcie_gen[pcie_table->lclk_levels] =
+			skutable->PcieGenSpeed[link_level];
+		pcie_table->pcie_lane[pcie_table->lclk_levels] =
+			skutable->PcieLaneCount[link_level];
+		pcie_table->lclk_freq[pcie_table->lclk_levels] =
+			skutable->LclkFreq[link_level];
+		pcie_table->lclk_levels++;
 	}
 
-	num_of_levels = pcie_table->num_of_link_levels;
+	num_of_levels = pcie_table->lclk_levels;
 	if (!num_of_levels)
 		return 0;
 
-- 
2.49.0


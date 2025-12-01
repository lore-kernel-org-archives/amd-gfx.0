Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 336D6D116F8
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 10:14:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBC6510E362;
	Mon,  1 Dec 2025 10:14:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5aRPUZCu";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91EA410E362
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 10:14:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UGDhzYlLvCJhsBkpl2radrvLryK5b/MeDPKrZdrn7BEmNMu9w1V82KDsGouDJPhCfKcfYuC7xguOXIfIT6Nll0xlBZSkm1MctjuCDYcqQ+w3iimJkQ/xCT6qrWI1u5qCQtWlyXpYhBDg6vevkZ0VEZC/DwFTsJWUXj//FiZVQdo+cKG1CRWcTx1B0Vt0YivVbtNoVM7h3vqmqvnIhnAZQtCvdq4xLKzDNLvimOlQbRtf/nagBjOyCVe4X1ng98v+xHsNmaj7CEF4iMslaljuZ3yWJULeQJuWySvhZtRJ7qztr1Zi7y7hRSCRBunTVGXuJD4tRGsEJ3YnH8It/I0jcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wd/D508MQxsiV9huSEmwtfvcOZhlSckvAt265iMVO0Q=;
 b=VbvOdoPdl1aFQMPnz/iRId/wS1VqeI+GwAunfEizk6nqSa5eoQpg1yX9e58F1BeRYHmRIvNkK2KTY1CXWyaNUmDk97BZSMemdb77UE0IR+ncRc4TlQsoyOwTwudlPqj6WDnheqYK+cnGXFbylSd65b6tA6dlnJm6HDHbsFN1Qna6bWUGd8JDhfh1P8UYUFU/xHZsro5rKuu3Pl9ovbOSFUAn8CZont4q6rm8WvumSVwJUp6FYgHemgq9WiwrqlsfaRkI81ETuYtwgwhvQWF54tekA1LuqyGLcjsTuMKubeniW85IQAhR66pmv2QZHQu181jomhbvPtESK6uYp7PDNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wd/D508MQxsiV9huSEmwtfvcOZhlSckvAt265iMVO0Q=;
 b=5aRPUZCu6VchyPFYXDtskTHBW6wpEIaPJsoM3rMb1vmKazP/GTeb9vOhnKCWn/G2XTQ3b++D7d4VWPcVLpufH3EXXVmaGBWh0BRjAwRb0gc9mWUErtV5jvKh4BN7rO7t10SicSnQyIFxu9ft+zv6EDQxrWePNPdzYEk9dwCtoDU=
Received: from CH5PR05CA0008.namprd05.prod.outlook.com (2603:10b6:610:1f0::17)
 by DS0PR12MB7769.namprd12.prod.outlook.com (2603:10b6:8:138::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 10:14:34 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::2d) by CH5PR05CA0008.outlook.office365.com
 (2603:10b6:610:1f0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Mon, 1
 Dec 2025 10:14:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 10:14:32 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 04:14:30 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 11/17] drm/amd/pm: Use common helper for navi10 dpm table
Date: Mon, 1 Dec 2025 15:33:24 +0530
Message-ID: <20251201101331.101584-12-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|DS0PR12MB7769:EE_
X-MS-Office365-Filtering-Correlation-Id: d4720737-0626-4aea-8886-08de30c26bf7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LWYlMVwt1q65/tpPEyTcQeVNmk4jcoWOr75b8Y/b5zuCQnjcuufDdcmfWtze?=
 =?us-ascii?Q?cZH/JtHvQUGqV0NVqdhDlTaqQ3YqnPSCFmXJDZZtcavNOWMn4ozS8i16c1Jt?=
 =?us-ascii?Q?WaSC3VdR89crLcCpRjB68ZRwsDcyRp+ZL9nleAPPtVNEY+NW0nZ1dSdoI8pb?=
 =?us-ascii?Q?jT51wVKxZNKtHaEAvxcZ3eYESEpBGd5gIFV7jyBXdn34bJ/MxteeE5E/y6Jn?=
 =?us-ascii?Q?nWxl19Ve+7A9dx2zeRNaLG9giz02T/ApHWvg4uBP+4I8T97aVHDAU4UupajH?=
 =?us-ascii?Q?rcieZ4rPFoz2c6Vxo3eXbn2+rv2eM2Al0vaQk6KDbkzvtEh8WhxIQrCGGKzU?=
 =?us-ascii?Q?G31uR0Q5zKWxXh7XeS4W/Kc5loGc5Aj6iVuBbs8cffbrEc4kEnIgd+pBz53+?=
 =?us-ascii?Q?JLdtycWjmDxL9caeeEPv+KsNDOUSmYKVM9sl9YdlA7bfZY/miC3pmRYeY8A3?=
 =?us-ascii?Q?/JCMUiwP1j/Fh00K2JtYHIzmySlNLbAFD3komMEwJk2EvwMCusaaw3artCuo?=
 =?us-ascii?Q?Yb334uqHmMP7/KvYSFegcdb60+t9INYtFvnm1cnK6LBiIyAzf24x7aF+oMof?=
 =?us-ascii?Q?iniqjxKaNHTADujaWV0jeQFk9JzqSWvnK71pr4YEQX8F+GHqtiZRNFuOviXz?=
 =?us-ascii?Q?2gNArl4f5nG59fmDZPoqU6BgVRMLEDCvIWFuuA1cqzE0XtjEh8ORhnRKRIdJ?=
 =?us-ascii?Q?4XA2gSYdyY/F2YyHqZtS1zPhoBMdYIsmqMWWm0s3rtuDL9YgaUJL32yv0YCT?=
 =?us-ascii?Q?kv8d2YzfW29F3On+2TnX7hkCex+UilW7iEpL1XZmf8RODtIxtZFbseuehwoQ?=
 =?us-ascii?Q?nJoVcFT1Gk7Sfmw/S4Z1teNuZ3KRG/zWvS4vFXxo7aL5q9SkJJvkVeEPh/4c?=
 =?us-ascii?Q?UBHzR5MIoGYizkkzKLIG6OjfT3GS5aAVqhA3Qe+2ZZop0xTfdoIcE9oEF37R?=
 =?us-ascii?Q?dhMWzijjZfxAONiq8vrwVOLMdyBFN1cdT4W9RumapqZmQcsrKGtLVjYUS9Jo?=
 =?us-ascii?Q?/Epm4zLsh5SlVgLdr6nl8MZP10eDY5xuIl0LJRI14Vcn9CWdWSfVg0e/pVsS?=
 =?us-ascii?Q?G/q/d0H50ljuz1dExCdwyguNFo0dWCmwvISU5/TjgqwEEJW9Ufvl3nD349ev?=
 =?us-ascii?Q?LVeSN6PnAwnECl1mPuoM7HBPrFi2OKltybXxraRPq1oiZqaQJGSBJsM4UVgf?=
 =?us-ascii?Q?1It5FiLYYPaQ5cMEKznpFNo3B5xN/efZ0ieq2quVPm/kMLnJ7CBh8HGNgQPC?=
 =?us-ascii?Q?krq68Fgi72ro7K9qE9p/7/DG/JEPz4f/vIBLlto/17IOaBy15eipuL8DiOJC?=
 =?us-ascii?Q?781rc523vx2GA8zZRwiNrYZl0wiRRqxwA7Ja93I5ls/RILWLS5XLQEpf36q4?=
 =?us-ascii?Q?3RWRFhgiWXppVTJYlHsms4bJItj3B2nqibXf84D17iWNfn5b30h3SWw6aTmP?=
 =?us-ascii?Q?wMuEWIA+ohbxcyyvHLUluGwhBZbFuacb6mu+UuHVsV9xnWXNhMS7EBxIrsh8?=
 =?us-ascii?Q?JM9TvKHNKDUAxEfMPwNLqxTT+0StF/OsYSXMCl07D1IK0kfLtQbrAJk2FQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 10:14:32.5823 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d4720737-0626-4aea-8886-08de30c26bf7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7769
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

Use helper function to print navi10 dpm tables to sysfs. Also, remove
FCLK table as it is not supported in navi10.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   | 107 +++++-------------
 1 file changed, 27 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
index 71ea20bcaf4f..882830770b79 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c
@@ -1252,9 +1252,8 @@ static int navi10_emit_clk_levels(struct smu_context *smu,
 {
 	uint16_t *curve_settings;
 	int ret = 0;
-	uint32_t cur_value = 0, value = 0;
-	uint32_t freq_values[3] = {0};
-	uint32_t i, levels, mark_index = 0, count = 0;
+	uint32_t cur_value = 0;
+	uint32_t i;
 	struct smu_table_context *table_context = &smu->smu_table;
 	uint32_t gen_speed, lane_width;
 	struct smu_dpm_context *smu_dpm = &smu->smu_dpm;
@@ -1262,100 +1261,39 @@ static int navi10_emit_clk_levels(struct smu_context *smu,
 	OverDriveTable_t *od_table =
 		(OverDriveTable_t *)table_context->overdrive_table;
 	struct smu_11_0_overdrive_table *od_settings = smu->od_settings;
+	struct smu_dpm_table *single_dpm_table = NULL;
 	struct smu_pcie_table *pcie_table;
 	uint32_t min_value, max_value;
 
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
+		single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
+		break;
+	/* FCLK and SOC CLK mapped to SOCCLK in clock map table */
 	case SMU_SOCCLK:
+	case SMU_FCLK:
+		single_dpm_table = &(dpm_context->dpm_tables.soc_table);
+		break;
 	case SMU_MCLK:
 	case SMU_UCLK:
-	case SMU_FCLK:
+		single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
+		break;
 	case SMU_VCLK:
+		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
+		break;
 	case SMU_DCLK:
+		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
+		break;
 	case SMU_DCEFCLK:
-		ret = navi10_get_current_clk_freq_by_table(smu, clk_type, &cur_value);
-		if (ret)
-			return ret;
-
-		ret = smu_v11_0_get_dpm_level_count(smu, clk_type, &count);
-		if (ret)
-			return ret;
-
-		ret = navi10_is_support_fine_grained_dpm(smu, clk_type);
-		if (ret < 0)
-			return ret;
-
-		if (!ret) {
-			for (i = 0; i < count; i++) {
-				ret = smu_v11_0_get_dpm_freq_by_index(smu,
-								      clk_type, i, &value);
-				if (ret)
-					return ret;
-
-				*offset += sysfs_emit_at(buf, *offset,
-						"%d: %uMhz %s\n",
-						i, value,
-						cur_value == value ? "*" : "");
-			}
-		} else {
-			ret = smu_v11_0_get_dpm_freq_by_index(smu,
-							      clk_type, 0, &freq_values[0]);
-			if (ret)
-				return ret;
-			ret = smu_v11_0_get_dpm_freq_by_index(smu,
-							      clk_type,
-							      count - 1,
-							      &freq_values[2]);
-			if (ret)
-				return ret;
-
-			freq_values[1] = cur_value;
-			mark_index = cur_value == freq_values[0] ? 0 :
-				     cur_value == freq_values[2] ? 2 : 1;
-
-			levels = 3;
-			if (mark_index != 1) {
-				levels = 2;
-				freq_values[1] = freq_values[2];
-			}
-
-			for (i = 0; i < levels; i++) {
-				*offset += sysfs_emit_at(buf, *offset,
-						"%d: %uMhz %s\n",
-						i, freq_values[i],
-						i == mark_index ? "*" : "");
-			}
-		}
+		single_dpm_table = &(dpm_context->dpm_tables.dcef_table);
 		break;
 	case SMU_PCIE:
 		gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
 		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
 		pcie_table = &dpm_context->dpm_tables.pcie_table;
-		for (i = 0; i < pcie_table->lclk_levels; i++) {
-			*offset += sysfs_emit_at(
-				buf, *offset, "%d: %s %s %dMhz %s\n", i,
-				(pcie_table->pcie_gen[i] == 0) ? "2.5GT/s," :
-				(pcie_table->pcie_gen[i] == 1) ? "5.0GT/s," :
-				(pcie_table->pcie_gen[i] == 2) ? "8.0GT/s," :
-				(pcie_table->pcie_gen[i] == 3) ? "16.0GT/s," :
-								 "",
-				(pcie_table->pcie_lane[i] == 1) ? "x1" :
-				(pcie_table->pcie_lane[i] == 2) ? "x2" :
-				(pcie_table->pcie_lane[i] == 3) ? "x4" :
-				(pcie_table->pcie_lane[i] == 4) ? "x8" :
-				(pcie_table->pcie_lane[i] == 5) ? "x12" :
-				(pcie_table->pcie_lane[i] == 6) ? "x16" :
-								  "",
-				pcie_table->lclk_freq[i],
-				(gen_speed == pcie_table->pcie_gen[i]) &&
-						(lane_width ==
-						 pcie_table->pcie_lane[i]) ?
-					"*" :
-					"");
-		}
-		break;
+		return smu_cmn_print_pcie_levels(smu, pcie_table, gen_speed,
+						 lane_width, buf, offset);
 	case SMU_OD_SCLK:
 		if (!smu->od_enabled || !od_table || !od_settings)
 			return -EOPNOTSUPP;
@@ -1459,6 +1397,15 @@ static int navi10_emit_clk_levels(struct smu_context *smu,
 		break;
 	}
 
+	if (single_dpm_table) {
+		ret = navi10_get_current_clk_freq_by_table(smu, clk_type,
+							   &cur_value);
+		if (ret)
+			return ret;
+		return smu_cmn_print_dpm_clk_levels(smu, single_dpm_table,
+						    cur_value, buf, offset);
+	}
+
 	return 0;
 }
 
-- 
2.49.0


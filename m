Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72479D116FA
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 10:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CD2810E374;
	Mon,  1 Dec 2025 10:14:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="NhsZbAR2";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012015.outbound.protection.outlook.com
 [40.93.195.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5330310E372
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 10:14:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcdELDAAvoYYYNwQcbdznJgsNCVpSlYsWMPKtTP+O764Ab/IXPXUBhj7lj/MFOHjw+/FnDocork9PdsIv1NmVk33SxFpm7Pr1aUpSkvYaFOdl1qc+tfzFDBFpZ1qqZEqtemH1V7oQbUAXSt1v9sTF4izAKiSqa1A9bf6e0Gkp3k4RK139lQGX5jS6X/xlJEYMOKPhOTBzbcu1eTiPcMPaWbHKlER+VaxmLmmiCjITGgYVaZa+XPudKp/2pO1Svic3Hm9tmo4mEMLJUQtN7n1ttPxkn16gw7Xr2E9UWb9Yz7yG1XxwXk1bZJC3MKmmwMRKYyO32XcuiaPoOYXCoaAeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f3rqNdQhov5ks1VlSPr1pVZogCr0cLyJqs29qkcTJ9w=;
 b=FjgaOUESaIZwjBKiSpyqmQgWeXBsTCSg8J+gQiRuXhCWPuEbe1Vfw9TXycURZtmgG9dnWplWv2EnBviqu2NfcCyEMSaKc77LNiljr3dYMDbhl7+gukoYtEtARJ/QoCmIKCQZgzca2SAmHWOgi+La4WKyFTmq3NBy1x+f9rFQdRfeK9yLitlhm5AfpblClc+TLCneEWXfbK8AOY8I6dUilP6v0t2rdI1KG7EfYeGhiSi2NASaAFEv2w7NMaHhCpNRV9YMjD3tnyGpxgCN2VEPhw5JzlC2UYFLC58Cl8tb7JAZZNgAsLjneAc64OjCzEwI/OLK5A1IHfiaZgjdW8L5Fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f3rqNdQhov5ks1VlSPr1pVZogCr0cLyJqs29qkcTJ9w=;
 b=NhsZbAR2J5DvJqSeE7ee6n5oiYH0SUfJu6FF74ydzeFfCyq/YPnfMMaUEbpaAiwJi0pj9irDR96C8bH0RNzvxmcu3e35ZqarUuAZmize82bq6G7/B9Saoc5NyIrIzUbrWxy+82q+SBV6pBS4LRENO5MMTF1BlWXRPH5+M3SnNU0=
Received: from CH0P223CA0002.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::21)
 by LV2PR12MB5799.namprd12.prod.outlook.com (2603:10b6:408:179::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 10:14:38 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:116:cafe::b4) by CH0P223CA0002.outlook.office365.com
 (2603:10b6:610:116::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Mon,
 1 Dec 2025 10:14:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 10:14:37 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 04:14:35 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 14/17] drm/amd/pm: Use common helper for smuv13.0.0 dpm
Date: Mon, 1 Dec 2025 15:33:27 +0530
Message-ID: <20251201101331.101584-15-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|LV2PR12MB5799:EE_
X-MS-Office365-Filtering-Correlation-Id: d1674323-3b90-4c37-f0d6-08de30c26f08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?0Axe7rbyZ3toUhLGWDp8aR6BmaL/nPDB4eK/rual0kPt6EQXJ30jdz09qewK?=
 =?us-ascii?Q?n3leCiyD9ndgzyOHzIbRpKoCrqZ8DS9gkEVcetWgz/Gy8hXUJdwJJiuboNk/?=
 =?us-ascii?Q?6ptHgF4OSA7U9AvQx+HA6Y37Gpjf5Ca3wJd0PJdQXydf8wcTj0Ix2bkyDCiq?=
 =?us-ascii?Q?ujX7brQPgKXna/pObeT9L0pfgvzPVwFVCnNrgWgF8kS8pfq/M03mjtJ3PIKQ?=
 =?us-ascii?Q?gdsScIKK0Euc/88zYCAP3isXvUMS9meYJbsdJJZoPRnhQKYF0lZQwA5J8RUO?=
 =?us-ascii?Q?C/HwkAAHUTPVpOskzI/d6xyVb2qwfnnJbIie3sjKoYYzV2QtvicBLq8wZPtC?=
 =?us-ascii?Q?LCIjxMhjrRcsyO3sSqznDMoFrZHpL1RYmohPovE6JcTg9a/cg2piH1NU70Ui?=
 =?us-ascii?Q?kEgh3B2MstazvqD6HbMrlbd1VG0XzOvlwdon9W0uyk4nWvXSG8tvohkmYRn8?=
 =?us-ascii?Q?cyyl1R3kwNUB2/kh91WIUaE38nyEpqABfjv4C/If0FRO/rjbFFmbtH/1PKiG?=
 =?us-ascii?Q?n8hp2hyaDDu9H3JSb7cd4yGn5/FlDKMe4HabVouT9YUVMHKmqf42SucFvb75?=
 =?us-ascii?Q?B8+FcLm4BgM6WeiigtPd08aeleQlPnAprCXJvDsKR8iTrQ+9UUrQpLZm/kCt?=
 =?us-ascii?Q?NRDVEZIII6tDc8AdH/KtXa2OSwa0mDQUI3ZJEtwVvqOy8vOF7XaoRQknTDWL?=
 =?us-ascii?Q?5iCtRpew5gk+oKHP3eJKjAmKOouNIcSt6XwEltcueVjLs1ZdP3GpOHrGo0bY?=
 =?us-ascii?Q?s4ZW6alOytebdouqiDL1hkYq+Z9v3dmmNh9k9weFqZkuBFDde+LowV6WhJXz?=
 =?us-ascii?Q?gfkdz32ITh2bUNQvGFsswEbeizkUYuTpLxWk8iM5qxjX1WvVWyXcFpfVRz8f?=
 =?us-ascii?Q?Ojeh3K7VRLN1ntRn3/HBpCobF/cHbxF0PZNvVbzmI/Zn9SL3XdTczkUmLLQI?=
 =?us-ascii?Q?752KNRkCSs0wDqRbJpBS9Y5+765BpoZBXxIYZjwwvc2GMGOn544pWfZlNe1y?=
 =?us-ascii?Q?8mDRcalRINft69Dof8coaJALydAd6byNv0lgwyzqgKy4yC3yGjuXshewnFrd?=
 =?us-ascii?Q?NIubXekN+P68Xl6ZzZ0fRssIGSTc6JXo3/IpstR9M3AlLOyGK7XSG9tkouWu?=
 =?us-ascii?Q?GdVeqEUl1o+6l4hrtXVcyoRIIKkPbdhubbmi6piFyY5F9hfd7k529Gb2Ttqz?=
 =?us-ascii?Q?KtvCcvVtsETTlQHQs2VuYZKIMrTOUQUSVZpRGTst23g+gdQkFy0SVbKkV0+v?=
 =?us-ascii?Q?3f+AUakJQZFC/qC98OfbEjCqshKYoCBxeWmCIcfeMNz1xOScPQGmo+T7linY?=
 =?us-ascii?Q?1xU2SJRs8kLfauDKNLZuYGJnGfa6nZaLUpSOK2UEkks4oUjs5OZ//z7tbRGp?=
 =?us-ascii?Q?m3bjaAtNfE3wJnKljkzq4yszFkIO8VkuOtScM00eoT7KUdIuDUtJLmbLNEwJ?=
 =?us-ascii?Q?N3SKpIdyM5oKKwCW+OK0GK7BEA7i0h2qohSd7iHKDuqS4wcVCPJ99xIhUJaF?=
 =?us-ascii?Q?knq90iNXkIupAfiaJ22UfyaqmAiuekvi6jjRc6dypPcQknic5ueHyxCp2/0f?=
 =?us-ascii?Q?1Gd1mo7itPOV6Z82T4c=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 10:14:37.7311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1674323-3b90-4c37-f0d6-08de30c26f08
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5799
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

Use helper function to print smuv13.0.0 dpm tables to sysfs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  | 98 +++----------------
 1 file changed, 15 insertions(+), 83 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
index adebf93c1557..aa26107b0e8c 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c
@@ -1185,9 +1185,8 @@ static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 	OverDriveTableExternal_t *od_table =
 		(OverDriveTableExternal_t *)smu->smu_table.overdrive_table;
 	int i, curr_freq, size = *offset, start_offset = *offset;
-	struct smu_dpm_table *single_dpm_table;
+	struct smu_dpm_table *single_dpm_table = NULL;
 	struct smu_pcie_table *pcie_table;
-	uint32_t pcie_speed, pcie_width;
 	uint32_t gen_speed, lane_width;
 	int32_t min_value, max_value;
 	int ret = 0;
@@ -1221,61 +1220,6 @@ static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 	case SMU_DCEFCLK:
 		single_dpm_table = &(dpm_context->dpm_tables.dcef_table);
 		break;
-	default:
-		break;
-	}
-
-	switch (clk_type) {
-	case SMU_SCLK:
-	case SMU_MCLK:
-	case SMU_SOCCLK:
-	case SMU_FCLK:
-	case SMU_VCLK:
-	case SMU_VCLK1:
-	case SMU_DCLK:
-	case SMU_DCLK1:
-	case SMU_DCEFCLK:
-		ret = smu_v13_0_0_get_current_clk_freq_by_table(smu, clk_type, &curr_freq);
-		if (ret) {
-			dev_err(smu->adev->dev, "Failed to get current clock freq!");
-			return ret;
-		}
-
-		if (single_dpm_table->flags & SMU_DPM_TABLE_FINE_GRAINED) {
-			/*
-			 * For fine grained dpms, there are only two dpm levels:
-			 *   - level 0 -> min clock freq
-			 *   - level 1 -> max clock freq
-			 * And the current clock frequency can be any value between them.
-			 * So, if the current clock frequency is not at level 0 or level 1,
-			 * we will fake it as three dpm levels:
-			 *   - level 0 -> min clock freq
-			 *   - level 1 -> current actual clock freq
-			 *   - level 2 -> max clock freq
-			 */
-			if ((single_dpm_table->dpm_levels[0].value != curr_freq) &&
-			     (single_dpm_table->dpm_levels[1].value != curr_freq)) {
-				size += sysfs_emit_at(buf, size, "0: %uMhz\n",
-						single_dpm_table->dpm_levels[0].value);
-				size += sysfs_emit_at(buf, size, "1: %uMhz *\n",
-						curr_freq);
-				size += sysfs_emit_at(buf, size, "2: %uMhz\n",
-						single_dpm_table->dpm_levels[1].value);
-			} else {
-				size += sysfs_emit_at(buf, size, "0: %uMhz %s\n",
-						single_dpm_table->dpm_levels[0].value,
-						single_dpm_table->dpm_levels[0].value == curr_freq ? "*" : "");
-				size += sysfs_emit_at(buf, size, "1: %uMhz %s\n",
-						single_dpm_table->dpm_levels[1].value,
-						single_dpm_table->dpm_levels[1].value == curr_freq ? "*" : "");
-			}
-		} else {
-			for (i = 0; i < single_dpm_table->count; i++)
-				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n",
-						i, single_dpm_table->dpm_levels[i].value,
-						single_dpm_table->dpm_levels[i].value == curr_freq ? "*" : "");
-		}
-		break;
 	case SMU_PCIE:
 		ret = smu_v13_0_0_get_smu_metrics_data(smu,
 						       METRICS_PCIE_RATE,
@@ -1290,32 +1234,8 @@ static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 			return ret;
 
 		pcie_table = &(dpm_context->dpm_tables.pcie_table);
-		for (i = 0; i < pcie_table->lclk_levels; i++) {
-			pcie_speed = DECODE_GEN_SPEED(pcie_table->pcie_gen[i]);
-			pcie_width =
-				DECODE_LANE_WIDTH(pcie_table->pcie_lane[i]);
-			size += sysfs_emit_at(
-				buf, size, "%d: %s %s %dMhz %s\n", i,
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
-				(gen_speed == pcie_speed &&
-				 lane_width == pcie_width) ?
-					"*" :
-					"");
-		}
-		break;
-
+		return smu_cmn_print_pcie_levels(smu, pcie_table, gen_speed,
+						 lane_width, buf, offset);
 	case SMU_OD_SCLK:
 		if (!smu_v13_0_0_is_od_feature_supported(smu,
 							 PP_OD_FEATURE_GFXCLK_BIT))
@@ -1533,6 +1453,18 @@ static int smu_v13_0_0_emit_clk_levels(struct smu_context *smu,
 		break;
 	}
 
+	if (single_dpm_table) {
+		ret = smu_v13_0_0_get_current_clk_freq_by_table(smu, clk_type,
+								&curr_freq);
+		if (ret) {
+			dev_err(smu->adev->dev,
+				"Failed to get current clock freq!");
+			return ret;
+		}
+		return smu_cmn_print_dpm_clk_levels(smu, single_dpm_table,
+						    curr_freq, buf, offset);
+	}
+
 	*offset += size - start_offset;
 
 	return 0;
-- 
2.49.0


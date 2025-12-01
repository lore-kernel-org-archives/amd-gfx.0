Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26FFDD116F1
	for <amd-gfx@archiver.kernel.org>; Mon,  1 Dec 2025 10:14:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE3F510E370;
	Mon,  1 Dec 2025 10:14:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="wbllhwsn";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011047.outbound.protection.outlook.com [52.101.52.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB1ED10E370
 for <amd-gfx@lists.freedesktop.org>; Mon,  1 Dec 2025 10:14:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tNLZStbnr9MwYn5zzIXpuC1AWYaHz5KruG1xxAnpXt+rMz6VlnGCDka7+f37IToLAGn6WOLFI6kd1OYzALgmMnfK8Bz9fZzYPXg8HGqw2lOXCrm9rJjtSFe3mKNqVtZw76ehpdAdyi6n5p/9THhYL8vfR/hYeGM4qE/Us+N016R/1CT0+oli/4vmBX5dEvEyQ0Mtid6kEeqWyciORYQezOFifUljmhTUfsgiVPQa982fYFcg9/QBd12GS+SuT7F99L4BK/2h1TSjNMiVzTtae3DsuzstU/KSeJoMQeQz94uQUNIuX31yTIGQUfD/CB/O+Bnmhj6FYqsyzVv2B9+/kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KoxcuW23LqsuxX3kIPkhlT9GkH2N8/gy4BrsDfOnM44=;
 b=k3+rPhsbwTcY6pw11Usmrz392OJtdaLADeIqOeTRYZFqkzYHtfppuHkh5uaj9ibYHkPB+9zjpd2mGC6awchS3H3solSdZlQikIM1nLIYajWZgA1k+lWsNbC9//7blXLNRHDQYJESB0EoWqjz5+Jz4X+2P63lItST4XYtChA0XptZZACDTRLYCw1giLpnU99cHjKuhux+TmHF2MBrTPmieta1uuQ9i58m4TkPs+2FEE0/d0u6QZ8XeKHhmXISZXbvAHqT888W0UAMsyNNROGywyE3/r63kmLLE6C7RxxpCevIjSIqxQ8do92p5YJfgGc5fdMLpGu63rr4lXBtYCJMNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KoxcuW23LqsuxX3kIPkhlT9GkH2N8/gy4BrsDfOnM44=;
 b=wbllhwsnTld9VAudOFesUVhqRhYh1JUx94+F8+RJjphBZqG1WX8MMqRx4A/L+O/zgbbedJlMDZdSyb4A1GDu3kUECHATICoERcyJWhMyBlDj0eeKDzlnAXIPMppbbLH2rkpnBSA+R+hQupwR8WEuIQJasKDBijq2XL7wXjt4FU8=
Received: from CH5PR05CA0008.namprd05.prod.outlook.com (2603:10b6:610:1f0::17)
 by DM4PR12MB7766.namprd12.prod.outlook.com (2603:10b6:8:101::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Mon, 1 Dec
 2025 10:14:34 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:1f0:cafe::a6) by CH5PR05CA0008.outlook.office365.com
 (2603:10b6:610:1f0::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.9 via Frontend Transport; Mon, 1
 Dec 2025 10:14:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Mon, 1 Dec 2025 10:14:34 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 1 Dec
 2025 04:14:32 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Asad.Kamal@amd.com>
Subject: [PATCH 12/17] drm/amd/pm: Use common helper for sienna dpm table
Date: Mon, 1 Dec 2025 15:33:25 +0530
Message-ID: <20251201101331.101584-13-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|DM4PR12MB7766:EE_
X-MS-Office365-Filtering-Correlation-Id: b4eec2ab-229b-4fbb-59b7-08de30c26d0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NaI6ETdzbM+cH5jrIKu8lOvFEp4TaVUwnNWy/Jw5ll72/TCtz6C6P/QqKpWj?=
 =?us-ascii?Q?no8qwXjRKpDbA1tOmZ94004+omeYBjduprdQIb7ABpf5jZp+pPssCaycXUb0?=
 =?us-ascii?Q?/0uj6+mLSLfiUQQu7uAHeHeXtIJAjxrXd2iNPbP/qsmXiW3Av3jVzLUvtwtx?=
 =?us-ascii?Q?U6x6tKQiRf7opqQYh2y4NM9hejTVx3/z9RwnXv8gzRcD6tACyiDVN5sbUdXk?=
 =?us-ascii?Q?9ruBHNZjGHZCkTH+KUaxdqCZZob5CJMwcUKeIIkNjpWbgF2n4SQW8OVUFSro?=
 =?us-ascii?Q?YIq3DO5zO+RkAgfMaSWDQuBQy86T7ElEXTJ3EbC/cf1wJa7gZ4P33NozSDLy?=
 =?us-ascii?Q?HoMkQHXa2Ef6opV8+Tmfl8ylF2Ztv5nhH/eSKJEWsPwEcggdGryn9C1ynh0e?=
 =?us-ascii?Q?WoFVrX/j3BUoX4iwgBD/Ug348qDcvBAKVYRl+C7BcQ5GNmydyzGRhgFVYX0A?=
 =?us-ascii?Q?Iq1cgVFhb0JzYiOQE0o8egoK8aXrHxUdNVIOT0/bHuSiTbydD8ReO7s4/wXh?=
 =?us-ascii?Q?TK7CkXO2x7jN906WCabTBPr2wNln/MMFfurLa3o4SQhvy41X75XJ8qJs01+u?=
 =?us-ascii?Q?BnvGkZK+k+BZFPr3afrmXkivr28n/0X0kbZ9a7ZXyTEzy+cVpQtJya2qPRvM?=
 =?us-ascii?Q?0YIpDO1ydXnr6X0jAMz3n7VuKBSHiyBbjy7LV5cQxUDofkty1d8sXi6AH0Dv?=
 =?us-ascii?Q?VypYKnP68pCxEMlVO96e1JTvtY/OirYOEItmOzJ6HwTsZagiqL41TvgE8eMe?=
 =?us-ascii?Q?lhXRYgvRlcTFwRiGQ7bEs78Sbx9xx0VQeqssbtuIV8+Dp/qVmgRvIjNjw+fd?=
 =?us-ascii?Q?fkjj50A8B54t0dj5bOwaUR2ydh6Z86J/GC8RRe3UwHVrXvhi0JbNrKKXz8Mu?=
 =?us-ascii?Q?HPOGWKEkXzRh/1C6LwjyDKhnbED3NlerNFfz7tmmhxaO5VO7VPBPAKedaQct?=
 =?us-ascii?Q?0aUMvpPnlDPuUHIdNwF+QQ6aeUXlu9y5l0XaDsuXJmTwuPTeaua3yCpm/kyS?=
 =?us-ascii?Q?hvjZL94Ir8l2s5PdDL/3+qO7ItCcQ7jxv8h97tMJ9AcMFnqrQ88KfbtRigKJ?=
 =?us-ascii?Q?WJAwrbhCm0MkBRUO+Nb5ggrC2l/7oxqvmZVDi7zRWxIAJFXc16ulifdCT0vt?=
 =?us-ascii?Q?K8y14D9Xh+WcGiszXpW6uVbRPGMr0k8s87pTTiuUX/BGinyjfkPeQsboXozN?=
 =?us-ascii?Q?AEd7+EqQt2TCtzMNjVY5CSSTrlUSJ7mWpVkOYxRXX4n2gXZXPcd6M9f1+eue?=
 =?us-ascii?Q?G2zL2QuGORgHCaRhNO6zVpr1WuCL3zP+O4fhanwk64murDWJjUyD6OKvGyg5?=
 =?us-ascii?Q?jTVTZW+teIl/AuhzVzem/8U/bZyTrK6ViPSE9KOyasDiddh8prlPP0j6Y9P3?=
 =?us-ascii?Q?XXQtnWQpUVD60GDaFbJy84SIG78D6TQqnzt9VGxYsnbJpupArUcwiy6uOPfG?=
 =?us-ascii?Q?zCc3nFzjUDx1CjlMHbJ24B6E5IXKxWmF/htj8hLnzjQ1cD1Aanto6ErcxsSN?=
 =?us-ascii?Q?MzStRO2++uK4QQtm7jMC7O6ObdsoQ0bJh+jilUzAjR1vSaNczIjIQB5xpA?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Dec 2025 10:14:34.4176 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4eec2ab-229b-4fbb-59b7-08de30c26d0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7766
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

Use helper function to print sienna cichlid dpm tables to sysfs.

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../amd/pm/swsmu/smu11/sienna_cichlid_ppt.c   | 94 ++++++-------------
 1 file changed, 27 insertions(+), 67 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
index 6bac81408614..108e8b3027ea 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu11/sienna_cichlid_ppt.c
@@ -1278,94 +1278,45 @@ static int sienna_cichlid_emit_clk_levels(struct smu_context *smu,
 	struct smu_11_0_7_overdrive_table *od_settings = smu->od_settings;
 	OverDriveTable_t *od_table =
 		(OverDriveTable_t *)table_context->overdrive_table;
-	int i, size = *offset, ret = 0, start_offset = *offset;
-	uint32_t cur_value = 0, value = 0, count = 0;
+	int size = *offset, ret = 0, start_offset = *offset;
+	uint32_t cur_value = 0;
+	struct smu_dpm_table *single_dpm_table = NULL;
 	struct smu_pcie_table *pcie_table;
-	uint32_t freq_values[3] = {0};
-	uint32_t mark_index = 0;
 	uint32_t gen_speed, lane_width;
 	uint32_t min_value, max_value;
 
 	switch (clk_type) {
 	case SMU_GFXCLK:
 	case SMU_SCLK:
+		single_dpm_table = &(dpm_context->dpm_tables.gfx_table);
+		break;
 	case SMU_SOCCLK:
+		single_dpm_table = &(dpm_context->dpm_tables.soc_table);
+		break;
 	case SMU_MCLK:
 	case SMU_UCLK:
+		single_dpm_table = &(dpm_context->dpm_tables.uclk_table);
+		break;
 	case SMU_FCLK:
+		single_dpm_table = &(dpm_context->dpm_tables.fclk_table);
+		break;
 	case SMU_VCLK:
 	case SMU_VCLK1:
+		single_dpm_table = &(dpm_context->dpm_tables.vclk_table);
+		break;
 	case SMU_DCLK:
 	case SMU_DCLK1:
+		single_dpm_table = &(dpm_context->dpm_tables.dclk_table);
+		break;
 	case SMU_DCEFCLK:
-		ret = sienna_cichlid_get_current_clk_freq_by_table(smu, clk_type, &cur_value);
-		if (ret)
-			return ret;
-
-		ret = smu_v11_0_get_dpm_level_count(smu, clk_type, &count);
-		if (ret)
-			return ret;
-
-		if (!sienna_cichlid_is_support_fine_grained_dpm(smu, clk_type)) {
-			for (i = 0; i < count; i++) {
-				ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, i, &value);
-				if (ret)
-					return ret;
-
-				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
-						cur_value == value ? "*" : "");
-			}
-		} else {
-			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, 0, &freq_values[0]);
-			if (ret)
-				return ret;
-			ret = smu_v11_0_get_dpm_freq_by_index(smu, clk_type, count - 1, &freq_values[2]);
-			if (ret)
-				return ret;
-
-			freq_values[1] = cur_value;
-			mark_index = cur_value == freq_values[0] ? 0 :
-				     cur_value == freq_values[2] ? 2 : 1;
-
-			count = 3;
-			if (mark_index != 1) {
-				count = 2;
-				freq_values[1] = freq_values[2];
-			}
-
-			for (i = 0; i < count; i++) {
-				size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, freq_values[i],
-						cur_value  == freq_values[i] ? "*" : "");
-			}
-
-		}
+		single_dpm_table = &(dpm_context->dpm_tables.dcef_table);
 		break;
 	case SMU_PCIE:
 		gen_speed = smu_v11_0_get_current_pcie_link_speed_level(smu);
 		lane_width = smu_v11_0_get_current_pcie_link_width_level(smu);
 		pcie_table = &dpm_context->dpm_tables.pcie_table;
-		for (i = 0; i < pcie_table->lclk_levels; i++)
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
-				(gen_speed == pcie_table->pcie_gen[i]) &&
-						(lane_width ==
-						 pcie_table->pcie_lane[i]) ?
-					"*" :
-					"");
-		break;
+		return smu_cmn_print_pcie_levels(smu, pcie_table, gen_speed,
+						 lane_width, buf, offset);
 	case SMU_OD_SCLK:
 		if (!smu->od_enabled || !od_table || !od_settings)
 			break;
@@ -1434,6 +1385,15 @@ static int sienna_cichlid_emit_clk_levels(struct smu_context *smu,
 		break;
 	}
 
+	if (single_dpm_table) {
+		ret = sienna_cichlid_get_current_clk_freq_by_table(
+			smu, clk_type, &cur_value);
+		if (ret)
+			return ret;
+		return smu_cmn_print_dpm_clk_levels(smu, single_dpm_table,
+						    cur_value, buf, offset);
+	}
+
 	*offset += size - start_offset;
 
 	return 0;
-- 
2.49.0


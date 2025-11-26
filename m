Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CED3D10F4D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D149A10E5FB;
	Wed, 26 Nov 2025 13:29:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="3AqOW6j1";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011043.outbound.protection.outlook.com [52.101.62.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EC8CA10E5FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:29:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fWbBDjyLYuxmFC103kbooK2CY6UPNWF0J3lUNgfKrs2FHwv1+eBF6cInpyG49WSBoQeiqcpy6GeeKrazvX20S9nuFqQIcVVn6fhWN3aKtiTlzkOU8yOwr8BDBJXf+xNkV1TOqLlrutO40WKj8FDeLebFZ6nNfui1zUrZgaV8A0rdObeKX6T6jM68Uxk6krWwPECaMzB3mS82Kf+3IdD8Vus4IM0IMmosQE0gHpAmMUjuynkjZN4BKjlcpppCaRveaGGlE6FkLRj00/Cd9N/fbYL76s1GM9Q7RC3Ld2Tea3h8qB1SpeNKE82lysc3roqoyFMMbQHP6rv/tfOuvy3AXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+51IQ957KFc91NTfa1mKDak4thuwnqFANG7kgKasLvs=;
 b=q9SfFX/O4ci0YIt5gsh0e+Vw5sPaWoClk7rYqzpzTlbMtlbMZ17HBC7qA9f6qx3fNRMWD4A34Q8X6bywfGT6C61CQVApGngJ5wEJdc3l4wzT78NcAmShAD6DUz9T1tRXtIKOXCt5bT2f2/D1Ac4W+wSjQBVx8nnKWPp7eykeyqIsPbybZv93UTjN8qPLKyTWGTUJBOnrSHF5cYMeAd1VtsU9YY8wG2NmiwGs0lx2Nuc6VNu9X3UH9pU/jrtGAOOYm2oxJxv4mwv2hW0Ngri4GN3Oqjmf3RO7yrq5Ij0SKSZw76+2q5aQ356sWBHf+b9Y+5TH4tgs/wDCF5arqIRYdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+51IQ957KFc91NTfa1mKDak4thuwnqFANG7kgKasLvs=;
 b=3AqOW6j1LOAydxCsStiDtqVKlyq2fkhpOmA0EgIg4JgwxtbVpV6lkCvh6CI4CdG48pPmDK1cBj6ma38SHanqNOPGu+sq98F2/RXSwx0fhTLTaOovUIFQSqTowpL8fIFaVRyM33eYrzOHXmcQjWnD1aqToPhlUvEQHlf67RBTig4=
Received: from BYAPR04CA0009.namprd04.prod.outlook.com (2603:10b6:a03:40::22)
 by SA3PR12MB9090.namprd12.prod.outlook.com (2603:10b6:806:397::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 13:29:03 +0000
Received: from SJ1PEPF00002317.namprd03.prod.outlook.com
 (2603:10b6:a03:40:cafe::12) by BYAPR04CA0009.outlook.office365.com
 (2603:10b6:a03:40::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 13:29:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002317.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 13:29:02 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 07:29:00 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH 12/20] drm/amd/pm: Use emit_clk_levels in SMUv14.0.0
Date: Wed, 26 Nov 2025 18:53:59 +0530
Message-ID: <20251126132822.3266730-13-lijo.lazar@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251126132822.3266730-1-lijo.lazar@amd.com>
References: <20251126132822.3266730-1-lijo.lazar@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002317:EE_|SA3PR12MB9090:EE_
X-MS-Office365-Filtering-Correlation-Id: a3ce2fcd-d5e5-4470-5ac2-08de2cefc3b7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ynj2bdwrd81zNhu/UPCEZ/0DD6yR2oiCe3j+jVJEEFisf83NWjfm+8qSsztS?=
 =?us-ascii?Q?QI9ulO0Pz7rY8XxZYEMu4lmCttoW0uSgINcFAenf+DkCZaOB9k0pZQ8AzIxX?=
 =?us-ascii?Q?gXqQDAlH/UllipPrtm8iL84MusFbJO+zIPOmUpKTNJ07bhYNh9TTpQC0hnZu?=
 =?us-ascii?Q?tb8wCwuoqjvMdfQ/xxfJLrPiaRFAonBbt909H/cGayb0/Nsu/azofcB11UEl?=
 =?us-ascii?Q?KODQANp4V0Defpp6HhOwgknQG4xS9RXbvJ+4cMTVAqstR6YWIR3FwnkUeqiQ?=
 =?us-ascii?Q?o2AIqFSXbCrCTSDgxZrKIw/R7wyV6CfTK1fwQ3Zx/+RkM2lVnsrZfFwKnUbS?=
 =?us-ascii?Q?OGZr5QYGJyT0odoPP6FZZbawBdDi6SaLcYCd9C92jvoMuHZHRyb3bxDRLS2U?=
 =?us-ascii?Q?DMMOQtD8DWKnLwzrdOE0E3xD3Z899yhWMkIVnqhufvot2zJS5n1NKOljhSpy?=
 =?us-ascii?Q?XPm0JGT/L3Ui9PZg0QkxXa1unSQNWm/lFGs0FFUe0lsuAE6jKtkxpKsRl8aj?=
 =?us-ascii?Q?T0gNdMFazvNIL4P4ZJBiY6MZMK7Dc+F6qGwwjEHL0B4U2/mS1A6PbdsQFvHg?=
 =?us-ascii?Q?dpoMIXrZCbjlherN1SyN3hwFiHawAW41ExvnmXWuZ+fnkVZkYi689n0wzQ1q?=
 =?us-ascii?Q?mHvesTRj56aqwzmFsOqg7RaG88RH1CIqvqp/rFKB17nl8XK2RZlHRhdcLq9u?=
 =?us-ascii?Q?zVw8Rpi3n/cC80UsYZpQVlNqE7mQIJPYTlMrsZFF7nk/UzCu6jCO1ibPQghc?=
 =?us-ascii?Q?w22r0xskHOiBbEypx7Ic1X/UM4cXAId92xcjRKXwy1gQzpzGYGyAjkZaBEjI?=
 =?us-ascii?Q?smpzwQQgLRgK+kNXG6xJmJShxVNo+DLn8gQOgj4DmHMvU9oOJYiNcvCdc4Ki?=
 =?us-ascii?Q?67VOsBMQlEbpzF85X7TqIjrIuH+rGuZ5LEvisKagMETAra6wvwKOdzdctAEA?=
 =?us-ascii?Q?iUGHMF5E6HwQjpuqwfvMCzhUidDT3gIhoGR3gp3cVyTaRzUKDblN1FI87xIU?=
 =?us-ascii?Q?hSApW7K5YsHBss7/LZOgVcOox1a4gfytmtSmX6PmeFtQt4HtNyXokgWkh9v3?=
 =?us-ascii?Q?x00K/9IH8+CqWl+VjyLdSH/i/tCTIlYbfVisfvEjJLDzX1G0+zPcp/IgmFiz?=
 =?us-ascii?Q?vvdY2KyhI14c+IKEevhWZhXs3JrupCy+6CsGkB+CaT0bo8t8XP+hBbITzrwW?=
 =?us-ascii?Q?ETDYDTMXuQd0MiLxFbXY4M1v0ygL5SRDDZDfBg94cbiQLhWYyCYSfkv8o/o9?=
 =?us-ascii?Q?tcdznxiPUQmtObDY971xrM8iNZxPD6KlyXOb6UHt9BglWbdJgc21ayno8ZSq?=
 =?us-ascii?Q?yak2Vbgr5shKe5rGtw7ybQ0xouh+PvkrE3DsICgvmiE+C+4ebVTdpdCsDoXw?=
 =?us-ascii?Q?P3CjfURjiwIx1PWfl1YquLpFPTxTdY/f0Peh08pQhIcVSJ/hXrWwZWWmsAzW?=
 =?us-ascii?Q?kDQrD13Eeh2cuc+feJwEP4gIwP4FyispLjPp6L5p1AC18gHvJxqEMKVEpuEI?=
 =?us-ascii?Q?/zvIWwr1k+kfvtqDfCnDmf1ASV+GZVEINxtwNSJ6YEqoy2RcT4bf+q4pgORh?=
 =?us-ascii?Q?Npd/QVH5yYi5wGMCJtw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:29:02.4203 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ce2fcd-d5e5-4470-5ac2-08de2cefc3b7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002317.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9090
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

Move to emit_clk_levels from print_clk_levels

Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
---
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c  | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
index b1bd946d8e30..a98348a5d803 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu14/smu_v14_0_0_ppt.c
@@ -1129,16 +1129,14 @@ static int smu_v14_0_common_get_dpm_level_count(struct smu_context *smu,
 	return 0;
 }
 
-static int smu_v14_0_0_print_clk_levels(struct smu_context *smu,
-					enum smu_clk_type clk_type, char *buf)
+static int smu_v14_0_0_emit_clk_levels(struct smu_context *smu,
+				       enum smu_clk_type clk_type, char *buf,
+				       int *offset)
 {
-	int i, idx, ret = 0, size = 0, start_offset = 0;
+	int i, idx, ret = 0, size = *offset, start_offset = *offset;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t min, max;
 
-	smu_cmn_get_sysfs_buf(&buf, &size);
-	start_offset = size;
-
 	switch (clk_type) {
 	case SMU_OD_SCLK:
 		size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
@@ -1162,17 +1160,17 @@ static int smu_v14_0_0_print_clk_levels(struct smu_context *smu,
 	case SMU_FCLK:
 		ret = smu_v14_0_0_get_current_clk_freq(smu, clk_type, &cur_value);
 		if (ret)
-			break;
+			return ret;
 
 		ret = smu_v14_0_common_get_dpm_level_count(smu, clk_type, &count);
 		if (ret)
-			break;
+			return ret;
 
 		for (i = 0; i < count; i++) {
 			idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
 			ret = smu_v14_0_common_get_dpm_freq_by_index(smu, clk_type, idx, &value);
 			if (ret)
-				break;
+				return ret;
 
 			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
 					      cur_value == value ? "*" : "");
@@ -1182,7 +1180,7 @@ static int smu_v14_0_0_print_clk_levels(struct smu_context *smu,
 	case SMU_SCLK:
 		ret = smu_v14_0_0_get_current_clk_freq(smu, clk_type, &cur_value);
 		if (ret)
-			break;
+			return ret;
 		min = (smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq;
 		max = (smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq;
 		if (cur_value  == max)
@@ -1203,7 +1201,9 @@ static int smu_v14_0_0_print_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-	return size - start_offset;
+	*offset += size - start_offset;
+
+	return 0;
 }
 
 static int smu_v14_0_0_set_soft_freq_limited_range(struct smu_context *smu,
@@ -1689,7 +1689,7 @@ static const struct pptable_funcs smu_v14_0_0_ppt_funcs = {
 	.get_dpm_ultimate_freq = smu_v14_0_common_get_dpm_ultimate_freq,
 	.set_soft_freq_limited_range = smu_v14_0_0_set_soft_freq_limited_range,
 	.od_edit_dpm_table = smu_v14_0_od_edit_dpm_table,
-	.print_clk_levels = smu_v14_0_0_print_clk_levels,
+	.emit_clk_levels = smu_v14_0_0_emit_clk_levels,
 	.force_clk_levels = smu_v14_0_0_force_clk_levels,
 	.set_performance_level = smu_v14_0_common_set_performance_level,
 	.set_fine_grain_gfx_freq_parameters = smu_v14_0_common_set_fine_grain_gfx_freq_parameters,
-- 
2.49.0


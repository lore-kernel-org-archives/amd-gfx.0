Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9578DD10F4F
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:29:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35FAC10E5FD;
	Wed, 26 Nov 2025 13:29:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="uwcjMf43";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010032.outbound.protection.outlook.com
 [52.101.193.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96D3910E5FA
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:29:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Fx+RX4OfAliyMoZxjYRCoUyC+RKktU2UgzK65e2jOL7p5vgvpZWkIgNteO1OoDSeXBWLY8KtSkJ40osjHqEiTqqKkQExm8PIvpSb713wFUOSsbO23fbFuQAAbXVdiYQyd0k+7u5Z8GgtUMVptJXS2L8fD6jOhRFIp7KVFRAtWS49ApmKi1TJsIcIBJj8z9sUSkxGeJ+A0DkWok98H1XSIRzLiaIZ0c7to+zitzAS7Hm4Dg6jkqiuFC1SvuldOujwEA0DdMFppEGaxZntkflmGA+4SjaUF+4LHwpivUbz8kNdDO7YVs7pi2PRZZvD8wF3fT2x46Y6kwcMv2qWRC63vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vLvy05rc0M6ed8vTAXTwjyTTUcaR5g2/kgbv7ztHOV4=;
 b=ZnpU7gi9kiyk0y9hGBWEbytlB3IS9UdtjGJhUr2pr9LHJ6vrkvJsEYhACPfzLWlkG89nEQT+64HpjxfF4oJBAHNrcGu3IShci+5UUtQpmZNdEk8Ozm5eRDXopl7JT4by20wequbE2DJ440tbFPW2AyaeSSdg505hS1PGydaTNUL3CZ9BAiaDNYqqbDvdtNBPCIfEqh4/1H9oMbAAetBn2IdAfJL1B84Hy564FiHbT9avoE9/L5AIXoQvHfiQu4C+ll2L7kRnX+FO7MwBE1BzfLHVqpnCue8ucscdiGL33dNXTMri+yHnquXvsLjLh3YnVKBAMBAsMyGF+Bpjgh/Bzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vLvy05rc0M6ed8vTAXTwjyTTUcaR5g2/kgbv7ztHOV4=;
 b=uwcjMf438fcUmtIlPpmVT9i6h1P0cKiwQ94jbbQ/EO3yZrVnSHZHcrtvFFPMYR2ODfAnvzenxN6Qn//5GVvwY9I+HHk6nwMov3ZfNvkD2a94H6Gu/sGTb0v9qztPmVeJ1Nk/cLT8VaJ2uEvTPmizzif/hZe9+S2CdSniqMf9s0Y=
Received: from SJ0PR03CA0274.namprd03.prod.outlook.com (2603:10b6:a03:39e::9)
 by SN7PR12MB7131.namprd12.prod.outlook.com (2603:10b6:806:2a3::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 13:28:57 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::5f) by SJ0PR03CA0274.outlook.office365.com
 (2603:10b6:a03:39e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.11 via Frontend Transport; Wed,
 26 Nov 2025 13:28:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 13:28:56 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 07:28:53 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH 08/20] drm/amd/pm: Use emit_clk_levels in SMUv13.0.5
Date: Wed, 26 Nov 2025 18:53:55 +0530
Message-ID: <20251126132822.3266730-9-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|SN7PR12MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b2f8e73-7bb6-400f-5bd7-08de2cefc04f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pVS9pEuEMlppOmcODWnN6dvarISMl4Rzc1rSiz55Ho4vpmaNx49y3FlAGKdg?=
 =?us-ascii?Q?3XqQgQZ1FFK39H0vJ/eE9HjXOE6evEFiDGe78YBaTWSF65A5Z/hLF76ETFeh?=
 =?us-ascii?Q?Q/iweYaLMYIeIPnCi0g4fK4Zg3aVZh+dblDaxzgwABPF0JiHfFi9O3RyY7lf?=
 =?us-ascii?Q?lQCWOq79Inpc7O/JluxPpJakEB0JMkHIPyjm5NM5AgXcpcE09eBwESuxp26b?=
 =?us-ascii?Q?go+1M1Sd1wKiphJERaUeZLEqHN0E2Lb9MULS5YyeId8o2HjDWdeNxKdBmdgM?=
 =?us-ascii?Q?wRaR2DYPj+/PGcO6Wt1qMs487wtMLl9XM5P6RUVs+S8KfbeJxpQRm+Een+Yi?=
 =?us-ascii?Q?hFndI1FzrwHegSD9EXvKnwQITmxnIIc6F4gXXaIUPcIuq62fTidwaHb9yiD0?=
 =?us-ascii?Q?qJ/n6YZ/7dHNfgpp5Rq4/yZKh/h/gaQLzXvfFTeMreC4JXt1kzk/cfl8ZFH/?=
 =?us-ascii?Q?WLsIvOKccy3zaV0PvhoYBrKfZmdKfCCviwfLtnNQgJKpqS2XRuj6D0QjI9W2?=
 =?us-ascii?Q?Xc5n7dEudyTsRavu941ntoO/Vj8L5AGrLaykebz2O1GzrtdCCAJsh7ngMPJw?=
 =?us-ascii?Q?nffoVBe7UriXjlDdwDg9tcx3Ho8tHMJzWQxQUAUJDEum3RzViRsSYKqffC1k?=
 =?us-ascii?Q?CvRA62Cjsf32ueDbuBdm6gpWl5Eg0DRCVfk9ZqsuNfLoDY21Uyxg67HQ49ZJ?=
 =?us-ascii?Q?rgUCJv8AylOh44Ul1n8Ru3Zvlq/1wFGfe5WUPFIEe2bZUT7ityc2wYX74n3e?=
 =?us-ascii?Q?nlYXQo4PKsw9qId4U6w3lWeQgxbAqRmzycXGs43QejmDiSZByJBeLVR2QO6y?=
 =?us-ascii?Q?V/xPhfnqwQG2A59w2DUnGHOG8FZYHXCXulFI3UBwNzYdfHfbyRO+IuXGmNwE?=
 =?us-ascii?Q?s1FO2qc/VjKsq0In1iFT3iapfdsrjpz4XE+LNR6KlMMTGJ4tuQHRkTORon9P?=
 =?us-ascii?Q?LRwySn1GJr2TsG98ndp5eIzLlcwRPCNC2RllDISN/o5G2wh80iETqvSPxpZ5?=
 =?us-ascii?Q?5qgXMiI27zdqxaWV9jR6W0s3qJrC4AziMl4AZKhc7ArPe1loYNbW70Xj6zNL?=
 =?us-ascii?Q?JEUPLVHhSMJjj/yvw/3jPCKJpU4jSpvd3ZawT+dOzUN8W576Ky/xwN8LyjrP?=
 =?us-ascii?Q?pbxLOw7G6papo9lUwEWm4gJc8FIaFg0sV8vU9gVwMScqVp/yt7121k7akjbz?=
 =?us-ascii?Q?b+DMUiIhNXVicNdf1LSlfgvzY6dxMD1vlpp2ft7AoJOdtJ9A+n/EmLq3JbmG?=
 =?us-ascii?Q?4px04QtS2Z06DZnMGcUCHBcoNA9xOv84dLbgLK70Jz+swpAdR4cOMZrjHHcq?=
 =?us-ascii?Q?072KbWvrq7zUHlYRoHRU1LfnzZRbbn8mPED/mxV9vS7Wd6hfCr/1NsOvU+wq?=
 =?us-ascii?Q?aFRTiA2ipYSJFbAy4d1giu+bd49ntH4dnlFF+JHIBlda1o602IzGmUp6C8JV?=
 =?us-ascii?Q?7344C/UtGLwFiAx3Wz8iWyBUPsDxR7/Cg+Q2fO+WAnQ0zlCjZgs15JnVc3zL?=
 =?us-ascii?Q?n98xbue0yTd6ubGpdNd2BXx1aEVsnwg7Jrx/XV30J/evXAfNHErHDIxPuViV?=
 =?us-ascii?Q?4aeMc1LpTge1vnCDbUM=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:28:56.7053 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2f8e73-7bb6-400f-5bd7-08de2cefc04f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7131
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
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c  | 25 +++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
index 4576bf008b22..796b2eb23174 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_5_ppt.c
@@ -858,16 +858,14 @@ static int smu_v13_0_5_set_soft_freq_limited_range(struct smu_context *smu,
 	return ret;
 }
 
-static int smu_v13_0_5_print_clk_levels(struct smu_context *smu,
-				enum smu_clk_type clk_type, char *buf)
+static int smu_v13_0_5_emit_clk_levels(struct smu_context *smu,
+				       enum smu_clk_type clk_type, char *buf,
+				       int *offset)
 {
-	int i, idx, size = 0, ret = 0, start_offset = 0;
+	int i, idx, size = *offset, ret = 0, start_offset = *offset;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t min = 0, max = 0;
 
-	smu_cmn_get_sysfs_buf(&buf, &size);
-	start_offset = size;
-
 	switch (clk_type) {
 	case SMU_OD_SCLK:
 		size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
@@ -887,17 +885,17 @@ static int smu_v13_0_5_print_clk_levels(struct smu_context *smu,
 	case SMU_MCLK:
 		ret = smu_v13_0_5_get_current_clk_freq(smu, clk_type, &cur_value);
 		if (ret)
-			goto print_clk_out;
+			return ret;
 
 		ret = smu_v13_0_5_get_dpm_level_count(smu, clk_type, &count);
 		if (ret)
-			goto print_clk_out;
+			return ret;
 
 		for (i = 0; i < count; i++) {
 			idx = (clk_type == SMU_MCLK) ? (count - i - 1) : i;
 			ret = smu_v13_0_5_get_dpm_freq_by_index(smu, clk_type, idx, &value);
 			if (ret)
-				goto print_clk_out;
+				return ret;
 
 			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
 					cur_value == value ? "*" : "");
@@ -907,7 +905,7 @@ static int smu_v13_0_5_print_clk_levels(struct smu_context *smu,
 	case SMU_SCLK:
 		ret = smu_v13_0_5_get_current_clk_freq(smu, clk_type, &cur_value);
 		if (ret)
-			goto print_clk_out;
+			return ret;
 		min = (smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq;
 		max = (smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq;
 		if (cur_value  == max)
@@ -928,8 +926,9 @@ static int smu_v13_0_5_print_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-print_clk_out:
-	return size - start_offset;
+	*offset += size - start_offset;
+
+	return 0;
 }
 
 
@@ -1118,7 +1117,7 @@ static const struct pptable_funcs smu_v13_0_5_ppt_funcs = {
 	.mode2_reset = smu_v13_0_5_mode2_reset,
 	.get_dpm_ultimate_freq = smu_v13_0_5_get_dpm_ultimate_freq,
 	.od_edit_dpm_table = smu_v13_0_5_od_edit_dpm_table,
-	.print_clk_levels = smu_v13_0_5_print_clk_levels,
+	.emit_clk_levels = smu_v13_0_5_emit_clk_levels,
 	.force_clk_levels = smu_v13_0_5_force_clk_levels,
 	.set_performance_level = smu_v13_0_5_set_performance_level,
 	.set_fine_grain_gfx_freq_parameters = smu_v13_0_5_set_fine_grain_gfx_freq_parameters,
-- 
2.49.0


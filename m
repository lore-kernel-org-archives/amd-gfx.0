Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18459D10F51
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:29:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E44710E5FC;
	Wed, 26 Nov 2025 13:29:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="d5PpXFOO";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013065.outbound.protection.outlook.com
 [40.107.201.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E6EB10E5FB
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:29:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hK9NT7S09ACgGY2nLIf7atJHbnUOrXLb6Fci08rxx6N/dwwB12Ks2nqE4fG5Bcn3lhxofTQt86lZEbwzn/9RrjCt2+accMBGSld2t5gdf5fINuLh133UW26LUzyqSd/oH+LRL/qu7VN1tFy+TzTmnnPfvzU+JLUvKcJPJI71eKcp/XYuCAPJZgrgiGiLvvAJoqLRSAMyyYzicHn2dGQxJzUhAl66Srg6Tb/xl3iIr43DSWNS9z1zFxO2f1QeFWg3Br0Y7UoVNIJzbFVKMIcMrx7iBB7/uzdpYu5k9Rkp5xF4gu39zjJcqR2YqIb6cCp2O36aG6AW9Y01NHw5m6mHCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+MGvN6wt2wM/8JYUPAL3xa7G50v1vzbpd5e9SedZhhk=;
 b=o8rCUCccYW20SEgxt5xyhrWsaJVncIwqv3fFJyP6hXctiQ77IXP2neIsYTWCxrB6iGqi2V001mFtFV9IvU+hy4mujVcKPhImTOTo7pR54dlEHk0HSR75gjxVc2XsjacFJXRwJgeUDSCaet/cRSREhMq9Rxc/dV34PWBPj+sUnY9coFOK1EoRhGErmQyEOIB62cUhZaWTF229oGrOS98p43CWVBa1G3HJ+vSX8ZZOmAU0v4gCWeBfeZkF9snE8oCLLDbNDKdlfLHubXXEV0hDuURoJKCIG4OzeEyVhZJnQV3RSD2opSBIKrj/WjSXh3an+/P1R5MyDV642loaYhfKNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+MGvN6wt2wM/8JYUPAL3xa7G50v1vzbpd5e9SedZhhk=;
 b=d5PpXFOOzw0nD4O6zsMo22yYFCBjuk+6YeJsee1NO5U7UfRYluMA9mDl9YNu2b6V+97mMjzQNIyz+0a7G+U5Vie/FdGLfYQrDZtzlVGyOfJ6ifG1Si0UYia/ZXmCNlj2Q40n89CrvhQ0lnxL2Tio62m7Z9HddLgcUjsX4YgycBQ=
Received: from BY5PR13CA0008.namprd13.prod.outlook.com (2603:10b6:a03:180::21)
 by IA1PR12MB6043.namprd12.prod.outlook.com (2603:10b6:208:3d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 13:29:01 +0000
Received: from SJ1PEPF00002312.namprd03.prod.outlook.com
 (2603:10b6:a03:180:cafe::8f) by BY5PR13CA0008.outlook.office365.com
 (2603:10b6:a03:180::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9388.3 via Frontend Transport; Wed,
 26 Nov 2025 13:29:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002312.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 13:29:00 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 07:28:58 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH 11/20] drm/amd/pm: Use emit_clk_levels in yellow carp
Date: Wed, 26 Nov 2025 18:53:58 +0530
Message-ID: <20251126132822.3266730-12-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002312:EE_|IA1PR12MB6043:EE_
X-MS-Office365-Filtering-Correlation-Id: aaad9892-f522-4358-db89-08de2cefc2ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4t0P9Cefh8zjHS79d51isny/pC3vUr/B0nX4i+Y3hNsJxnx1rHBbMULPKhtn?=
 =?us-ascii?Q?fIbb3Fq9EFmt1Usj+M+OY4j9uvKG+PRcIeNt7MJv3lwNmrndjwMdhOgLgS+S?=
 =?us-ascii?Q?z/ADHSEgQ9cAdCJuiv+6XKcjVv2jk3hsAZpSiy0EKnLdVkifbqUd1MyqFtQu?=
 =?us-ascii?Q?LebUTLplbR+pk5S7udK1A2qB2Q4G/wM2+6Tw9ak1z3qjGg09LzQ0KkYru2nD?=
 =?us-ascii?Q?egYlBMfIgrEiEXD2Z5MvwZSggTzr+l8NISlGRP7EtK3cyNgnbh6xV2Nf9e15?=
 =?us-ascii?Q?MG5qPX1IfeXMOrWGcVZpSVjVvrwfSjpLLSS9XX6VMlu+QYJjM4pFn/Fu5NsR?=
 =?us-ascii?Q?pPr5dpULvQA7s3WPOf+it9ED3273fTzoDcr4SP/LAf0BGRZMaSjbLDtOa5X2?=
 =?us-ascii?Q?Z/GhUMLeisREcv4hR7yBq8QYHDRF9OAA43bTeGo9On8q3xfHyIESWJds8YH/?=
 =?us-ascii?Q?xU1zkxku/zTUKe2Hu+cucREkyzTYYKSjlqPcXl0aNFGYha0o25nER7kRVqRy?=
 =?us-ascii?Q?Yv0TsgDRMz9JZQSluO1Jm+x8by9OzjV00OPCPwMo95JI8mAi4fpt1wRUkcDJ?=
 =?us-ascii?Q?g1zvXb5Ln7eS+nsOQkJMHXmeUvG9TpshsijJJu7OpPyur6GM8zuSo7o2+gaW?=
 =?us-ascii?Q?5UZJ1Vm4u4VpiVdTA8fskwkvfWtyXhJLbUeql6xKaA10RltJnzBQ147EY9E0?=
 =?us-ascii?Q?w9koi5Z6jLMFppiJ+zWmpHME3DGd0zr+XN5KF6Z3H55rkwJN9Ubk0D/H+Bq5?=
 =?us-ascii?Q?nLyAr+6YIj0xJjWdlt8vKDD5nbc0cAhn89Cxs/pZ4KRyga9CfnJqfqqtXni1?=
 =?us-ascii?Q?cxVArloYTMQFvZAftxhHuPLNntFTIMOBqGHfhUZvk1sqV4LamXLnq/lbJSrs?=
 =?us-ascii?Q?7w8gJx4xqDFExo0LaoyJQAb7TIHNoBM6nMC9xa/Csa8FceLXQ8M59c1ASN4C?=
 =?us-ascii?Q?SfoakL7K+oDHXZFD+7SKSM0WOgxGtdce5D/ZaEDzXBbfyWbtHQ+t3ThHhp61?=
 =?us-ascii?Q?Dpu/qQvF/nl79EPcdgC657zQifRmR7+LAO1juyKeMTAZZFBWbOHNv5Ixupfh?=
 =?us-ascii?Q?RCmpdq5m0luL+FTjr4tUj3od/Yhn9X/97Ei4bZx0UchzhRBgOdXSFaiPxv/u?=
 =?us-ascii?Q?7d8c2Rsu+nHaJDN8zbcKKHsvv82yXyBrX26Y+HfyAO5xpb3CuZi2b8cCKmB1?=
 =?us-ascii?Q?4lF/rbwm3gsod1PVNXiyOm+u+38MDxkUverFyh26EF8OsMepkvH+6/FqBHHT?=
 =?us-ascii?Q?psH8uRe9s5XClH72naGQ6bkVZXawFt+gIFjKhfY+cEBGsKNJ0OUs58XXvMpx?=
 =?us-ascii?Q?3WjDU7t/WDNppBGuxJPuZdCfI+4+xmPLBqFb5EdvyTANhVQPhi7rINgM3tRv?=
 =?us-ascii?Q?Jb7ukr4m+N4WYe/5zkksAkyDiQN+lcrpCFs2voSwolG1p8YNXXj/1fVQDnLS?=
 =?us-ascii?Q?ymLInKxEjZRHqRR/FMhg51LBuIPwKtJiVCzPVnTGRf8lh75R68b7CyqveNb/?=
 =?us-ascii?Q?ft7nJxoXY6YkYgtf48xENa3otvUd/OVCoTJegesizZjwgkZiKrqrJD4gXO8L?=
 =?us-ascii?Q?WaMGPfsY5oBBzaiyq8E=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:29:00.6795 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aaad9892-f522-4358-db89-08de2cefc2ad
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002312.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6043
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
 .../drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c  | 25 +++++++++----------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
index 5d7e671fa3c3..e261edbf7852 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/yellow_carp_ppt.c
@@ -1038,17 +1038,15 @@ static uint32_t yellow_carp_get_umd_pstate_clk_default(struct smu_context *smu,
 	return clk_limit;
 }
 
-static int yellow_carp_print_clk_levels(struct smu_context *smu,
-				enum smu_clk_type clk_type, char *buf)
+static int yellow_carp_emit_clk_levels(struct smu_context *smu,
+				       enum smu_clk_type clk_type, char *buf,
+				       int *offset)
 {
-	int i, idx, size = 0, ret = 0, start_offset = 0;
+	int i, idx, size = *offset, ret = 0, start_offset = *offset;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t min, max;
 	uint32_t clk_limit = 0;
 
-	smu_cmn_get_sysfs_buf(&buf, &size);
-	start_offset = size;
-
 	switch (clk_type) {
 	case SMU_OD_SCLK:
 		size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
@@ -1069,17 +1067,17 @@ static int yellow_carp_print_clk_levels(struct smu_context *smu,
 	case SMU_FCLK:
 		ret = yellow_carp_get_current_clk_freq(smu, clk_type, &cur_value);
 		if (ret)
-			goto print_clk_out;
+			return ret;
 
 		ret = yellow_carp_get_dpm_level_count(smu, clk_type, &count);
 		if (ret)
-			goto print_clk_out;
+			return ret;
 
 		for (i = 0; i < count; i++) {
 			idx = (clk_type == SMU_FCLK || clk_type == SMU_MCLK) ? (count - i - 1) : i;
 			ret = yellow_carp_get_dpm_freq_by_index(smu, clk_type, idx, &value);
 			if (ret)
-				goto print_clk_out;
+				return ret;
 
 			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
 					cur_value == value ? "*" : "");
@@ -1090,7 +1088,7 @@ static int yellow_carp_print_clk_levels(struct smu_context *smu,
 		clk_limit = yellow_carp_get_umd_pstate_clk_default(smu, clk_type);
 		ret = yellow_carp_get_current_clk_freq(smu, clk_type, &cur_value);
 		if (ret)
-			goto print_clk_out;
+			return ret;
 		min = (smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq;
 		max = (smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq;
 		if (cur_value  == max)
@@ -1111,8 +1109,9 @@ static int yellow_carp_print_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-print_clk_out:
-	return size - start_offset;
+	*offset += size - start_offset;
+
+	return 0;
 }
 
 static int yellow_carp_force_clk_levels(struct smu_context *smu,
@@ -1349,7 +1348,7 @@ static const struct pptable_funcs yellow_carp_ppt_funcs = {
 	.mode2_reset = yellow_carp_mode2_reset,
 	.get_dpm_ultimate_freq = yellow_carp_get_dpm_ultimate_freq,
 	.od_edit_dpm_table = yellow_carp_od_edit_dpm_table,
-	.print_clk_levels = yellow_carp_print_clk_levels,
+	.emit_clk_levels = yellow_carp_emit_clk_levels,
 	.force_clk_levels = yellow_carp_force_clk_levels,
 	.set_performance_level = yellow_carp_set_performance_level,
 	.set_fine_grain_gfx_freq_parameters = yellow_carp_set_fine_grain_gfx_freq_parameters,
-- 
2.49.0


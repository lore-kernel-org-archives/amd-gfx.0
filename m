Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0E377D10F4D
	for <amd-gfx@archiver.kernel.org>; Wed, 26 Nov 2025 13:29:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A523210E2B7;
	Wed, 26 Nov 2025 13:29:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VzGxybhw";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010019.outbound.protection.outlook.com [52.101.85.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1823D10E2B7
 for <amd-gfx@lists.freedesktop.org>; Wed, 26 Nov 2025 13:28:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jAxcaes4UB+kmPmm8NnUaSRfUc+2ZDv93F82syTtzZsbhSgE6fQXS+UHhaY1iT5vM/px+xEaksk5ax9WwzfNkd4av82EKW9FAdVqgW+4i2bMn/gtAPKTPSa9Ae1CWPp2Ya2a8Wk7G/uVJfi38WWE5IMlwmPCLZuoXpO+K5luqD04LAcgAmmTWGFeKHWfTn2vTwB0nGhxbHB+tYZ/JpI6Sxe5goU920vYq38a5nmMJCFld+ApvPm8Ce0IgVjfpk9MBMA8D1EeDPAnmSY9UOlwODZQLq++jl4KLh0ixD6Bs1yCXSKTjnW1Eu57Dt1dzqVyUbUSdzVELd5rEZZHF7tqwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S/qah93p39sNJKnOOGipfHdahzOfLg5LB3PfakBJVFg=;
 b=RXkLK4B46e9bNheXFz5XlRceGYdhtgA1YEeCKgQjCqE7YrGCurFSbG2nYl7dDb6sNS2u2HW+5p1WuAHTeOz6lJl3gddCz4FQPU3PWnd4kYdPuGLOt2M4UpQvjkPlCsjEfKO01AQaNQDPqBVGvHeiDpYpFSmEONk0tdp50+Ny7jL0dJkQlUVd87xRQs8br+uZwMLmcso1+NjuKQztMSzlrkmUOf9goKmMPa72oesM4DhA1eKxdQSXNyZEG0COX2BUBk0cqpsuWXO691zVJsAK/4UGse2t8E2K+/9WQhLMMG1GH6EAOnK3hOZjJ5s7TBLBgaxBo8fKqwhMuIW73KuAFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S/qah93p39sNJKnOOGipfHdahzOfLg5LB3PfakBJVFg=;
 b=VzGxybhwlrC8rIjVK+06beQrMd+HJ5SvFNM+VcwGKL2fPos4k2r5XNRMsSg1pkGfW0OSH5V+miQXUXUVViZphjU61JfdthKpFubFXRXckzurP2PANRn2mIGfmVNc3oYfX0XYeGdOofp24ABRkAdgP1hIMrGJ8h0rn+A8uRLzKn8=
Received: from SJ0PR03CA0288.namprd03.prod.outlook.com (2603:10b6:a03:39e::23)
 by PH0PR12MB8797.namprd12.prod.outlook.com (2603:10b6:510:28d::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.11; Wed, 26 Nov
 2025 13:28:54 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:39e:cafe::d) by SJ0PR03CA0288.outlook.office365.com
 (2603:10b6:a03:39e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Wed,
 26 Nov 2025 13:28:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Wed, 26 Nov 2025 13:28:54 +0000
Received: from mlse-blrlinux-ll.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 26 Nov
 2025 07:28:52 -0600
From: Lijo Lazar <lijo.lazar@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Hawking.Zhang@amd.com>, <Alexander.Deucher@amd.com>, <Jesse.Zhang@amd.com>
Subject: [PATCH 07/20] drm/amd/pm: Use emit_clk_levels in SMUv13.0.4
Date: Wed, 26 Nov 2025 18:53:54 +0530
Message-ID: <20251126132822.3266730-8-lijo.lazar@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|PH0PR12MB8797:EE_
X-MS-Office365-Filtering-Correlation-Id: 83cec3ef-840e-4ca6-b74f-08de2cefbf04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?s3uOLbja5JyMwlw/iI+Ych5d+kXrAuQ8oDk3T/q7PjNA5TS7yUGIrR16IlXB?=
 =?us-ascii?Q?dtHb8b2Tcu5luOMVlSkEwWOOJKNrTMOodz53csg0fNR4pRUjvjieYVn7vS5j?=
 =?us-ascii?Q?DDySov932nTLIu8DZ3TCwQAV6CNYcPtrYkKMOd54aa0qNZLXxAqgglChSWt4?=
 =?us-ascii?Q?5noMxz2vOEvUfLb1DLPZHbPBQfMjPuREUFuteIAL7ooEMqXtLjD2xWubQg8q?=
 =?us-ascii?Q?vDzuWI8R/niFNv5zfy6mro+0TqiC5fXCjY7qtJzTpOPqS/Z/LAt2N6ZxJm/r?=
 =?us-ascii?Q?bpZShHkEpDFMZNhsXENM13n8cnXeWKprs41SXHDOnq4NIuWzwVbHA3i00cz5?=
 =?us-ascii?Q?hZ4Tx+UXxeDHYxbZHgPTFHgHja8ZzVH4ttkmH1znQdLJfv9nWYAx8V4jwNwa?=
 =?us-ascii?Q?AutiTPKH1Pzv+IYPknl3F1nNVAhqqdQUJrIat0ZZBWCjVN33W0/Qam1H/vrS?=
 =?us-ascii?Q?sEKFGXb5yDFifqTQDd1PmrxR0TgkWrzEz8dJebmLIZJYQxGrUSSzJ0IreC4h?=
 =?us-ascii?Q?9A4xOJxkBTgsgHH4Ol7y4CiLCz+b8tbACBV+hPD7IZEa36sVXGmDs7ZrOfyc?=
 =?us-ascii?Q?j+a9oKCDH36ivE2d1FvAt2LzgewySGtbOzhE4yhDDNTv9vHNEJVUmU6qyIOk?=
 =?us-ascii?Q?R1whDtTpqQQSYjghDN5tqR7GjCz7teGeA6US1lIZh4PpyNi3eQ2X0qzyB1mU?=
 =?us-ascii?Q?mIlQGKzGHjhaCfN+cesqg4Utwv8ejn+QOtSjoOaZhvNZXb6BsL/0Pz+TnMCW?=
 =?us-ascii?Q?zJQE7/f5nDYl7XPEVztuKvks/+N2AUClW6ua+iV25KddCd6GHjuxJKCDd1X1?=
 =?us-ascii?Q?FQvqXev3v7QB2x9T1XLHwo2QSFVXN4n33BjY2lr+qJbrNw0Mn5sM4uzqR8B4?=
 =?us-ascii?Q?0KZmoFL6nx0NojqbwlIOOcD7dm1rfYlgqtReprQ/Ws1L3KM7AaVuedEqEdZr?=
 =?us-ascii?Q?9uQImWIuxNWD25ZJA33UhP912nVNxoyytM5onJ9iSVathgpDBsYJM9vK0lP4?=
 =?us-ascii?Q?KO7gOvbIKItYPG/Xy0eSq04d9ifQ3viG6uH2XCfG21OJ2/7NhFRZuXw2rjp3?=
 =?us-ascii?Q?WepKIP7E9YguEm1EZ2oV9Gcfk0YbxQMTz1ygFCoDsMhuimhWwzyx7sZ/0zox?=
 =?us-ascii?Q?ffVXEQY1gULAngccdrD5tTuw2yO52iSzEEFiN4uy1kdh06PCuSjek2ngNGVH?=
 =?us-ascii?Q?+PXfgbg+YwiDq8j2ISZANJcqGmIEFrIcHMR5m5fOEZA3LVOC1/vsHll9ASWM?=
 =?us-ascii?Q?xWp8Mmh2xuCGvvHz31uOkJPpA45lELKBPemtsBww5D2JCp42xljKI/+yYqpo?=
 =?us-ascii?Q?egJzplwIZjlvhPziNarARA7VzLEUWBWSWcgW1jF9u9Jo3l+eLmhYOOcGtXcQ?=
 =?us-ascii?Q?/Bs7y+MdkMiPoxJt6sOaxo8lojDV9sIqoH7plfp/E7rmsOi5DNv+MtjvXhJ7?=
 =?us-ascii?Q?/3OLIGq5szLCGh8S5glNo2cghmeR/3gp+9em87/ZJYxNifi41oPVllIaxLYU?=
 =?us-ascii?Q?qAUMHJCEBsvkHbJkkYHddJSitn3EDH3tmDGRHkQ+65rO0+oaHNEqJ97UaeqQ?=
 =?us-ascii?Q?rq/j9rv48RlqdvlR6R8=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2025 13:28:54.5384 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83cec3ef-840e-4ca6-b74f-08de2cefbf04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8797
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
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c  | 24 +++++++++----------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
index 6908f9930f16..b0fa726ea25d 100644
--- a/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
+++ b/drivers/gpu/drm/amd/pm/swsmu/smu13/smu_v13_0_4_ppt.c
@@ -494,16 +494,14 @@ static int smu_v13_0_4_get_dpm_level_count(struct smu_context *smu,
 	return 0;
 }
 
-static int smu_v13_0_4_print_clk_levels(struct smu_context *smu,
-					enum smu_clk_type clk_type, char *buf)
+static int smu_v13_0_4_emit_clk_levels(struct smu_context *smu,
+				       enum smu_clk_type clk_type, char *buf,
+				       int *offset)
 {
-	int i, idx, size = 0, ret = 0, start_offset = 0;
+	int i, idx, size = *offset, ret = 0, start_offset = *offset;
 	uint32_t cur_value = 0, value = 0, count = 0;
 	uint32_t min, max;
 
-	smu_cmn_get_sysfs_buf(&buf, &size);
-	start_offset = size;
-
 	switch (clk_type) {
 	case SMU_OD_SCLK:
 		size += sysfs_emit_at(buf, size, "%s:\n", "OD_SCLK");
@@ -525,17 +523,17 @@ static int smu_v13_0_4_print_clk_levels(struct smu_context *smu,
 	case SMU_FCLK:
 		ret = smu_v13_0_4_get_current_clk_freq(smu, clk_type, &cur_value);
 		if (ret)
-			break;
+			return ret;
 
 		ret = smu_v13_0_4_get_dpm_level_count(smu, clk_type, &count);
 		if (ret)
-			break;
+			return ret;
 
 		for (i = 0; i < count; i++) {
 			idx = (clk_type == SMU_FCLK || clk_type == SMU_MCLK) ? (count - i - 1) : i;
 			ret = smu_v13_0_4_get_dpm_freq_by_index(smu, clk_type, idx, &value);
 			if (ret)
-				break;
+				return ret;
 
 			size += sysfs_emit_at(buf, size, "%d: %uMhz %s\n", i, value,
 					      cur_value == value ? "*" : "");
@@ -545,7 +543,7 @@ static int smu_v13_0_4_print_clk_levels(struct smu_context *smu,
 	case SMU_SCLK:
 		ret = smu_v13_0_4_get_current_clk_freq(smu, clk_type, &cur_value);
 		if (ret)
-			break;
+			return ret;
 		min = (smu->gfx_actual_hard_min_freq > 0) ? smu->gfx_actual_hard_min_freq : smu->gfx_default_hard_min_freq;
 		max = (smu->gfx_actual_soft_max_freq > 0) ? smu->gfx_actual_soft_max_freq : smu->gfx_default_soft_max_freq;
 		if (cur_value  == max)
@@ -566,7 +564,9 @@ static int smu_v13_0_4_print_clk_levels(struct smu_context *smu,
 		break;
 	}
 
-	return size - start_offset;
+	*offset += size - start_offset;
+
+	return 0;
 }
 
 static int smu_v13_0_4_read_sensor(struct smu_context *smu,
@@ -1114,7 +1114,7 @@ static const struct pptable_funcs smu_v13_0_4_ppt_funcs = {
 	.mode2_reset = smu_v13_0_4_mode2_reset,
 	.get_dpm_ultimate_freq = smu_v13_0_4_get_dpm_ultimate_freq,
 	.od_edit_dpm_table = smu_v13_0_od_edit_dpm_table,
-	.print_clk_levels = smu_v13_0_4_print_clk_levels,
+	.emit_clk_levels = smu_v13_0_4_emit_clk_levels,
 	.force_clk_levels = smu_v13_0_4_force_clk_levels,
 	.set_performance_level = smu_v13_0_4_set_performance_level,
 	.set_fine_grain_gfx_freq_parameters = smu_v13_0_4_set_fine_grain_gfx_freq_parameters,
-- 
2.49.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D88C5DF9C
	for <amd-gfx@archiver.kernel.org>; Tue, 18 Aug 2026 20:23:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9AE9510ECE1;
	Tue, 18 Aug 2026 20:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EyY7WgsL";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013018.outbound.protection.outlook.com
 [40.93.196.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4520510ECC5
 for <amd-gfx@lists.freedesktop.org>; Tue, 18 Aug 2026 20:22:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqbnEkd6iiH9JoZx7FG7oWN6TPUxg3NvUt5pP4yl5AO8Ho1n1M0iLWgyIUTE3v1ppAoeYCi5iKAk4Mh/JW7A3femBkbGzDnUxH015sWVazxntZJGhmXzaQG3eu/uSoZmWH5EhaUrNe48/m7icsXIOu2PZzPFqtNtdx40JVH5h/WwdPOx/FuBvMYoZVISE+lK9IQFEHCK5nM7BRDJqd9E1aWYfDZhuyZVNAJT12pfdl45O8H56lH+6rdgSfYTcP/cdkCwppMciOWLi0MSLGfhQWNXNEXoUqOjNyqShQNCTJqcYJexNKLZyadIVytclwTVyWlhrRAYetokqm+1JhHgwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kZrM8F8FTUY9dE7Zgl5CVeub9JtGL9xfHHgsb2PNIWo=;
 b=pRWNdXs5pkhuxf6klbQGSDE9Kk0Lc6cc8GzvmMp2SdwxTM3K5z/ukpgu+79sydDlFvdnbANAD1mdQRLpSxvDd91sawnUJeeawuPioytFJm5KKu+nrdQqU9T2jfAluMRe6nysfm8/A2iFYBzVDzOXD9fsZAgkmDw4xx1LgPEzjXQDlzmaJVcLAdcQhi1Ks3rNkQ6s33Fl/dpMiHabVnXBYNED3uAYA5u1HvBULKkHFRw7b4I3RShOwFuFXJVy95PW/sHMRxSYHpe3aVofV94PlB8hmr+VE+OEvJ5ohn6czb8WUARXMIg/lgo8I+qKaC2jE+uLboo+845mQQY33+W1jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kZrM8F8FTUY9dE7Zgl5CVeub9JtGL9xfHHgsb2PNIWo=;
 b=EyY7WgsLqSldzHjDhR1n9X6KYa3T90GPsCCeHDySgWZZgVqZcFxiMThqvrsHdQU7whjuaj/NGW651Ac7AG7+e4vBu2skTVegZiCSYUCY6qGVsGFsDRpOl0DvImsdWbeHc4s2uVyRslfc4/wZu99mSaSopzVFZvEpmBYYZYcltKo=
Received: from BL1P221CA0016.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:2c5::29)
 by DSWPR12MB999175.namprd12.prod.outlook.com (2603:10b6:8:36f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 20:22:49 +0000
Received: from BN3PEPF0000B36F.namprd21.prod.outlook.com
 (2603:10b6:208:2c5:cafe::1b) by BL1P221CA0016.outlook.office365.com
 (2603:10b6:208:2c5::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.8 via Frontend Transport; Tue, 18
 Aug 2026 20:22:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B36F.mail.protection.outlook.com (10.167.243.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.0 via Frontend Transport; Tue, 18 Aug 2026 20:22:48 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:46 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Tue, 18 Aug
 2026 15:22:46 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Tue, 18 Aug 2026 15:22:45 -0500
From: <IVAN.LIPSKI@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Austin Zheng
 <austin.zheng@amd.com>
Subject: [PATCH 70/82] drm/amd/display: Fix mismatch number of OPP/DPP
 accounting
Date: Tue, 18 Aug 2026 16:16:02 -0400
Message-ID: <20260818202139.4172592-71-IVAN.LIPSKI@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
References: <20260818202139.4172592-1-IVAN.LIPSKI@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B36F:EE_|DSWPR12MB999175:EE_
X-MS-Office365-Filtering-Correlation-Id: 85b515d9-7e87-4014-871b-08defd6678bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|30052699003|82310400026|1800799024|376014|56012099006|10067099003|3023799007|6133799003|18002099003|22082099003|20052099010|11063799006|5023799004;
X-Microsoft-Antispam-Message-Info: rkRwCw9bKEv5pY/absiGB3DAlhtgiTXTOegmz4zFqa3ZR52CPCTZObr/kEUKEqn62ejeeMWeSjE62HAMbmTCwyuHML/9FuTop93isI9CfA0auCfB2oRXoXAaKAn8UttkU+Fhi9iLhD5kxqatLqK4gTYSLBMxgWG+p9DqN5PL7ZxG3Gv8qOuIt5uyqZHnLHTbhbR9Y/N64ZIj1uMuT7cKTCwdc5sZknBm83fepxtDfRg20MteLnzK0JeOZmS1osadRnpF3ndE1K9SbrdgzXEC25ByfA81C2d8TwcebYuiSp/D24YzMGnxgmYxiFkQ1MNcIT2oTYxhDz9DXPHv280tP39kE69EVVwaLN0mzRRDpOpsaaHe4U8kGz2AVxeN6p11dWW8OKtyTm7bF+UHTrDS/GDXmZCcX2ms+PeJh6xjIoNEBu6Q1PVHm5jAbcBwrgzhTIgcEIYFvgv1EY7hTbsqoNvtVdR4AKCjfm87bmmuBBycTfnSIKV+4W4YN8oA5eN+VgyGEeNDDpW+RI529a2BO8UQWA6TuaEM6NHN4BN5wgUrabAuC/zefb6/9WCoCjawUUz+3n/gsp/DVrooAC7l1f96DY2mu34EPxmkCj4bhNH8q6euk5IRcKdAdIDv0S0ZhFfkIkV3/b/oYqAT3BAMRr2vyOO3zAP5TNN/zM8VEHE=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(30052699003)(82310400026)(1800799024)(376014)(56012099006)(10067099003)(3023799007)(6133799003)(18002099003)(22082099003)(20052099010)(11063799006)(5023799004);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xKiahjTcILFv+Jdas3jt0ifZidr/JYUBC+PGsDj6fe/ry1Aid/+mn0UPRD6zAuV8obQ7PEJ+Yl/m/ESGJDnZLTbYYq/vy4T9XVWe4tKUxA73BEzYh8OSySrJluTJbAr0ljVkoEIeBQe7JQMpyuDy7e0o9HTCBp4NnDvL2dgyWemK1xZnVKiEaM7ccMue/slTyZ4435Jaxt6CelLgZhl9oReBu4fpLJ6pXX5CpPRaMvVcCDtSQWqLopKusqmvo0T7r5va8VmTO+CzploZOnQJ7sCVKd5tAWBY65Ims0DDut31QCm1eQRA258io53A+uNICLF2kcUOfGRe+A1LjE6Oivu+uc+ERUqSLXI87xgiUAQwVa6IDwE9slC4ZKofXRYr3oE9RYQUfhO6+4vn/hz0YPy3e2NiaA4TGchs3h3yDiQw585mw3yHv0KR6xEWRBlX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 20:22:48.7078 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85b515d9-7e87-4014-871b-08defd6678bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B36F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSWPR12MB999175
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
For cases where number of OPP/DPP mismatch, like 4 planes, 1 stream on
a 3 OPP ASIC, mode support would previously fail citing lack of OPP's.
This is incorrect, as the configuration only needs 1 OPP but 4 DPP's.

Reviewed-by: Austin Zheng <austin.zheng@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../dml21/inc/bounding_boxes/dcn42b_soc_bb.h  | 10 +++----
 .../src/dml2_core/dml2_core_dcn4_calcs.c      | 30 ++++++++++---------
 .../dml2_core_dcn5_funcs_initialize.c         |  2 +-
 .../dml2_core_dcn5_funcs_mode_support.c       | 23 ++++++++++++--
 .../dml2_core_dcn6_funcs_initialize.c         |  2 ++
 .../dml2_core_dcn6_funcs_mode_support.c       | 24 +++++++++++++--
 6 files changed, 67 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h
index 33eb583e3365e..0f8666788bbb8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/inc/bounding_boxes/dcn42b_soc_bb.h
@@ -57,7 +57,6 @@ static const struct dml2_soc_qos_parameters dml_dcn42b_variant_a_soc_qos_params
 	},
 	.qos_params = {
 		.dcn32x = {
-			.loaded_round_trip_latency_fclk_cycles = 106,
 			.urgent_latency_us = {
 				.base_latency_us = 4,
 				.base_latency_pixel_vm_us = 4,
@@ -65,8 +64,9 @@ static const struct dml2_soc_qos_parameters dml_dcn42b_variant_a_soc_qos_params
 				.scaling_factor_fclk_us = 0,
 				.scaling_factor_mhz = 0,
 			},
-			.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
+			.loaded_round_trip_latency_fclk_cycles = 106,
 			.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
+			.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
 			.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
 		},
 	},
@@ -167,7 +167,6 @@ static const struct dml2_soc_bb dml2_socbb_dcn42b = {
 		},
 		.qos_params = {
 			.dcn32x = {
-				.loaded_round_trip_latency_fclk_cycles = 106,
 				.urgent_latency_us = {
 					.base_latency_us = 4,
 					.base_latency_pixel_vm_us = 4,
@@ -175,8 +174,9 @@ static const struct dml2_soc_bb dml2_socbb_dcn42b = {
 					.scaling_factor_fclk_us = 0,
 					.scaling_factor_mhz = 0,
 				},
-				.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
+				.loaded_round_trip_latency_fclk_cycles = 106,
 				.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
+				.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
 				.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
 			},
 		},
@@ -208,8 +208,8 @@ static const struct dml2_soc_bb dml2_socbb_dcn42b = {
 	.return_bus_width_bytes = 64,
 	.hostvm_min_page_size_kbytes = 4,
 	.gpuvm_min_page_size_kbytes = 4,
-	.gpuvm_max_page_table_levels = 1,
 	.hostvm_max_non_cached_page_table_levels = 2,
+	.gpuvm_max_page_table_levels = 1,
 	.phy_downspread_percent = 0.38,
 	.dcn_downspread_percent = 0.38,
 	.dispclk_dppclk_vco_speed_mhz = 3000,
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
index 9a205b0e15989..608bbb7287cb0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn4_calcs.c
@@ -4116,9 +4116,7 @@ static bool ValidateODMMode(enum dml2_odm_mode ODMMode,
 	bool UseDSC,
 	unsigned int NumberOfDSCSlices,
 	unsigned int TotalNumberOfActiveDPP,
-	unsigned int TotalNumberOfActiveOPP,
 	unsigned int MaxNumDPP,
-	unsigned int MaxNumOPP,
 	double DISPCLKRequired,
 	unsigned int NumberOfDPPRequired,
 	unsigned int MaxHActiveForDSC,
@@ -4134,7 +4132,7 @@ static bool ValidateODMMode(enum dml2_odm_mode ODMMode,
 
 	if (DISPCLKRequired > MaxDispclk)
 		return false;
-	if ((TotalNumberOfActiveDPP + NumberOfDPPRequired) > MaxNumDPP || (TotalNumberOfActiveOPP + NumberOfDPPRequired) > MaxNumOPP)
+	if ((TotalNumberOfActiveDPP + NumberOfDPPRequired) > MaxNumDPP)
 		return false;
 	if (are_odm_segments_symmetrical) {
 		if (HActive % (NumberOfDPPRequired * pixels_per_clock_cycle))
@@ -4180,9 +4178,7 @@ static noinline_for_stack void CalculateODMMode(
 	double MaxDispclk,
 	bool DSCEnable,
 	unsigned int TotalNumberOfActiveDPP,
-	unsigned int TotalNumberOfActiveOPP,
 	unsigned int MaxNumDPP,
-	unsigned int MaxNumOPP,
 	double PixelClock,
 	unsigned int NumberOfDSCSlices,
 
@@ -4252,9 +4248,7 @@ static noinline_for_stack void CalculateODMMode(
 			UseDSC,
 			NumberOfDSCSlices,
 			TotalNumberOfActiveDPP,
-			TotalNumberOfActiveOPP,
 			MaxNumDPP,
-			MaxNumOPP,
 			DISPCLKRequired,
 			NumberOfDPPRequired,
 			MaxHActiveForDSC,
@@ -8453,7 +8447,6 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 	CalculateSwathAndDETConfiguration(&mode_lib->scratch, CalculateSwathAndDETConfiguration_params);
 
 	mode_lib->ms.TotalNumberOfActiveDPP = 0;
-	mode_lib->ms.TotalNumberOfActiveOPP = 0;
 	mode_lib->ms.support.TotalAvailablePipesSupport = true;
 
 	for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
@@ -8489,9 +8482,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 			mode_lib->ms.max_dispclk_freq_mhz,
 			false, // DSCEnable
 			mode_lib->ms.TotalNumberOfActiveDPP,
-			mode_lib->ms.TotalNumberOfActiveOPP,
 			mode_lib->ip.max_num_dpp,
-			mode_lib->ip.max_num_opp,
 			((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.pixel_clock_khz / 1000),
 			mode_lib->ms.support.NumberOfDSCSlices[k],
 
@@ -8510,9 +8501,7 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 			mode_lib->ms.max_dispclk_freq_mhz,
 			true, // DSCEnable
 			mode_lib->ms.TotalNumberOfActiveDPP,
-			mode_lib->ms.TotalNumberOfActiveOPP,
 			mode_lib->ip.max_num_dpp,
-			mode_lib->ip.max_num_opp,
 			((double)display_cfg->stream_descriptors[display_cfg->plane_descriptors[k].stream_index].timing.pixel_clock_khz / 1000),
 			mode_lib->ms.support.NumberOfDSCSlices[k],
 
@@ -8650,12 +8639,25 @@ static bool dml_core_mode_support(struct dml2_core_calcs_mode_support_ex *in_out
 #endif
 	}
 
+	// TotalNumberOfActiveDPP is the sum of all planes
 	mode_lib->ms.TotalNumberOfActiveDPP = 0;
-	mode_lib->ms.TotalNumberOfActiveOPP = 0;
 	for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
 		mode_lib->ms.TotalNumberOfActiveDPP += mode_lib->ms.NoOfDPP[k];
-		mode_lib->ms.TotalNumberOfActiveOPP += mode_lib->ms.NoOfOPP[k];
 	}
+
+	// TotalNumberOfActiveOPP is the sum of the per stream max of all planes
+	mode_lib->ms.TotalNumberOfActiveOPP = 0;
+	for (k = 0; k < display_cfg->num_streams; ++k) {
+		unsigned int NoOfOppPerStream = 0;
+		for (m = 0; m < display_cfg->num_planes; ++m) {
+			if (display_cfg->plane_descriptors[m].stream_index == k) {
+				NoOfOppPerStream = NoOfOppPerStream < mode_lib->ms.NoOfOPP[m] ? mode_lib->ms.NoOfOPP[m] : NoOfOppPerStream;
+			}
+		}
+
+		mode_lib->ms.TotalNumberOfActiveOPP += NoOfOppPerStream;
+	}
+
 	if (mode_lib->ms.TotalNumberOfActiveDPP > (unsigned int)mode_lib->ip.max_num_dpp)
 		mode_lib->ms.support.TotalAvailablePipesSupport = false;
 	if (mode_lib->ms.TotalNumberOfActiveOPP > (unsigned int)mode_lib->ip.max_num_opp)
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_initialize.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_initialize.c
index 31681c7f655e9..5907cc155505a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_initialize.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_initialize.c
@@ -33,7 +33,7 @@ static void patch_ip_caps_with_explicit_ip_params(struct dml2_ip_capabilities *i
 static void patch_ip_params_with_ip_caps(struct dml2_core_ip_params *ip_params, const struct dml2_ip_capabilities *ip_caps)
 {
 	ip_params->max_num_dpp = ip_caps->pipe_count;
-	ip_params->max_num_opp = ip_caps->pipe_count;
+	ip_params->max_num_opp = ip_caps->otg_count;
 	ip_params->max_num_otg = ip_caps->otg_count;
 	ip_params->num_dsc = ip_caps->num_dsc;
 	ip_params->max_num_dp2p0_streams = ip_caps->max_num_dp2p0_streams;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.c
index 9d68c9dd0a1de..2e86a134e074e 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn5_funcs_mode_support.c
@@ -795,22 +795,26 @@ static void dcn5_ms_calculate_num_of_dpp_required(
 		const struct dml2_display_cfg *display_cfg,
 		struct dml2_core_internal_display_mode_lib *mode_lib)
 {
-	unsigned int k;
+	unsigned int k, m;
 	const struct dml2_plane_parameters *plane;
 
 	for (k = 0; k < mode_lib->ms.num_active_planes; ++k) {
 		plane = &display_cfg->plane_descriptors[k];
 		mode_lib->ms.MPCCombine[k] = false;
 		mode_lib->ms.NoOfDPP[k] = 1;
+		mode_lib->ms.NoOfOPP[k] = 1;
 		if (mode_lib->ms.ODMMode[k] == dml2_odm_mode_combine_4to1) {
 			mode_lib->ms.MPCCombine[k] = false;
 			mode_lib->ms.NoOfDPP[k] = 4;
+			mode_lib->ms.NoOfOPP[k] = 4;
 		} else if (mode_lib->ms.ODMMode[k] == dml2_odm_mode_combine_3to1) {
 			mode_lib->ms.MPCCombine[k] = false;
 			mode_lib->ms.NoOfDPP[k] = 3;
+			mode_lib->ms.NoOfOPP[k] = 3;
 		} else if (mode_lib->ms.ODMMode[k] == dml2_odm_mode_combine_2to1) {
 			mode_lib->ms.MPCCombine[k] = false;
 			mode_lib->ms.NoOfDPP[k] = 2;
+			mode_lib->ms.NoOfOPP[k] = 2;
 		} else if (plane->overrides.mpcc_combine_factor == 2) {
 			mode_lib->ms.MPCCombine[k] = true;
 			mode_lib->ms.NoOfDPP[k] = 2;
@@ -832,12 +836,27 @@ static void dcn5_ms_calculate_num_of_dpp_required(
 		DML_LOG_VERBOSE("DML::%s: k=%d, NoOfDPP = %d\n", __func__, k,
 				mode_lib->ms.NoOfDPP[k]);
 	}
+
+
+	// TotalNumberOfActiveOPP is the sum of the per stream max NoOfOPP of all planes driving that stream
+	mode_lib->ms.TotalNumberOfActiveOPP = 0;
+	for (k = 0; k < display_cfg->num_streams; ++k) {
+		unsigned int NoOfOppPerStream = 0;
+
+		for (m = 0; m < mode_lib->ms.num_active_planes; ++m) {
+			if (display_cfg->plane_descriptors[m].stream_index == k)
+				NoOfOppPerStream = NoOfOppPerStream < mode_lib->ms.NoOfOPP[m] ? mode_lib->ms.NoOfOPP[m] : NoOfOppPerStream;
+		}
+
+		mode_lib->ms.TotalNumberOfActiveOPP += NoOfOppPerStream;
+	}
 }
 
 static bool dcn5_ms_check_total_available_pipes_support(
 		struct dml2_core_internal_display_mode_lib *mode_lib)
 {
-	return mode_lib->ms.TotalNumberOfActiveDPP <= (unsigned int) mode_lib->ip.max_num_dpp;
+	return mode_lib->ms.TotalNumberOfActiveDPP <= (unsigned int) mode_lib->ip.max_num_dpp
+			&& mode_lib->ms.TotalNumberOfActiveOPP <= (unsigned int) mode_lib->ip.max_num_opp;
 }
 
 static void dcn5_ms_calculate_total_num_of_single_dpp_surfaces(
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_initialize.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_initialize.c
index 23fd6edeb0cf2..5abce647da0a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_initialize.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_initialize.c
@@ -24,6 +24,7 @@ struct dml2_core_ip_params core_dcn6_ip_caps_base = {
 	.writeback_interface_buffer_size_kbytes = 90,
 	//Number of pipes after DCN Pipe harvesting
 	.max_num_dpp = 4,
+	.max_num_opp = 4,
 	.max_num_otg = 4,
 	.max_num_wb = 1,
 	.zero_size_buffer_entries = 512,
@@ -111,6 +112,7 @@ static void patch_ip_caps_with_explicit_ip_params(struct dml2_ip_capabilities *i
 static void patch_ip_params_with_ip_caps(struct dml2_core_ip_params *ip_params, const struct dml2_ip_capabilities *ip_caps)
 {
 	ip_params->max_num_dpp = ip_caps->pipe_count;
+	ip_params->max_num_opp = ip_caps->otg_count;
 	ip_params->max_num_otg = ip_caps->otg_count;
 	ip_params->TDLUT_33cube_count = ip_caps->TDLUT_33cube_count;
 	ip_params->num_dsc = ip_caps->num_dsc;
diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
index 01bbf4aacbe3c..ca3b8b82ec04a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/src/dml2_core/dml2_core_dcn6_funcs_mode_support.c
@@ -988,12 +988,16 @@ static void dcn6_ms_calculate_num_of_dpp_required(
 	for (k = 0; k < display_cfg->num_planes; k++) {
 		plane = &display_cfg->plane_descriptors[k];
 		outputs->NoOfDPP[k] = 1;
+		outputs->NoOfOPP[k] = 1;
 		if (inputs->ODMMode[k] == dml2_odm_mode_combine_4to1) {
 			outputs->NoOfDPP[k] = 4;
+			outputs->NoOfOPP[k] = 4;
 		} else if (inputs->ODMMode[k] == dml2_odm_mode_combine_3to1) {
 			outputs->NoOfDPP[k] = 3;
+			outputs->NoOfOPP[k] = 3;
 		} else if (inputs->ODMMode[k] == dml2_odm_mode_combine_2to1) {
 			outputs->NoOfDPP[k] = 2;
+			outputs->NoOfOPP[k] = 2;
 		} else if (plane->overrides.mpcc_combine_factor == 2) {
 			outputs->MPCCombine[k] = true;
 			outputs->NoOfDPP[k] = 2;
@@ -1027,12 +1031,28 @@ static bool dcn6_ms_check_total_available_pipes_support(
 	struct dml2_core_internal_mode_support *inputs = states;
 	struct dml2_core_internal_mode_support *outputs = states;
 	unsigned int totalNumOfActiveDPP = 0;
-	unsigned int k;
+	unsigned int k, m;
 
 	DML_LOG_FUNC_ENTER();
 	for (k = 0; k < display_cfg->num_planes; k++)
 		totalNumOfActiveDPP += inputs->NoOfDPP[k];
-	outputs->support.TotalAvailablePipesSupport = totalNumOfActiveDPP <= (unsigned int)ip->max_num_dpp;
+
+
+	// TotalNumberOfActiveOPP is the sum of the per stream max NoOfOPP of all planes driving that stream
+	outputs->TotalNumberOfActiveOPP = 0;
+	for (k = 0; k < display_cfg->num_streams; k++) {
+		unsigned int NoOfOppPerStream = 0;
+
+		for (m = 0; m < display_cfg->num_planes; m++) {
+			if (display_cfg->plane_descriptors[m].stream_index == k)
+				NoOfOppPerStream = NoOfOppPerStream < inputs->NoOfOPP[m] ? inputs->NoOfOPP[m] : NoOfOppPerStream;
+		}
+
+		outputs->TotalNumberOfActiveOPP += NoOfOppPerStream;
+	}
+
+	outputs->support.TotalAvailablePipesSupport = totalNumOfActiveDPP <= (unsigned int)ip->max_num_dpp
+			&& outputs->TotalNumberOfActiveOPP <= (unsigned int)ip->max_num_opp;
 
 	DML_LOG_DEBUG_BOOL(outputs->support.TotalAvailablePipesSupport);
 	DML_LOG_FUNC_EXIT();
-- 
2.43.0


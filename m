Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6374F94CC3
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Apr 2026 03:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5A60210E23F;
	Wed, 22 Apr 2026 03:57:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="VwhgDjUR";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012065.outbound.protection.outlook.com
 [40.107.200.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9B1510E210
 for <amd-gfx@lists.freedesktop.org>; Wed, 22 Apr 2026 03:57:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCSn34TnR7RerhD04271kjm5qLRSfYXMO+fIzhzconn9XZB/XV72cR8DYZCuUihKRfzniu1hqfYyvpaw5Nd4nsXYfkn7h+BkAEY7+NbslEw6uJiD8ayjIrSf3zrLV3p+BuygOEZgJHcUCJhDb00ItN1GDw9DJZjhNPT8vnWKGE8n1YHvxFHWjrsJaXRocdMWum03/o9HvwNUDsLEpPVcJWywshUl0xSHdSNcus26iPEzgV1ieHfvjtM2DYL1DqbtQyytJ6Lbd+F/WTc+obc1xNKHzLXvacI9RW5UNbgrRx2XzqavB13+Ccgbf/Fa45MX5NI/GXss3vsKqQyl8yIDdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HjNNFAGMA2m/PQgoUCvqr1FsPu1AW7ZO5G6Wdxa66iA=;
 b=iJx6gVm7isgQXyW3+yWYEgeg8YyutMwlj6cFUlW4saav+DUKOIrJ0JrmFMazEAG31/vPFn0Dr5T/oMhy56sS72bmM8Yh7hcHNmxt+YT1ScofnaJ0wyUZiDKXDSjD9MMTHdP+cFHR2Fc/7+hFi1pHoJeFsRt1XUBE+CklLAwh+FSRpN2wbNpy2v9y8E2os7ORLLjzlP7utwlTBxezwA87oeVsJPBlYTVlMxG/5rnv+Lb9RJ1vIJGFkdT2olwDji3y+ELcyNUkxnqpN3SvTm7KXm2rjFgHED0C81EIKCTGV3RGfKSI9yzjxdPEemKDC9G/swPI75NziMHWLz01dZWlMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HjNNFAGMA2m/PQgoUCvqr1FsPu1AW7ZO5G6Wdxa66iA=;
 b=VwhgDjURzM6RVXYGZq01g7L2A68V1CA2wVUvyEfaGa75i2UUbd8RmhqkT2PkY876j1w6esrt/fQbDW0i+onEeQsKyza4sOoNwbGnK9MJUoBuejuQDLLrYEEIZx7JXSNS7xDLUZvRh6PQZXbAV4jmTXBkIFoyNmnJR9B9Ef/Vk80=
Received: from DM6PR21CA0006.namprd21.prod.outlook.com (2603:10b6:5:174::16)
 by DS0PR12MB8525.namprd12.prod.outlook.com (2603:10b6:8:159::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.15; Wed, 22 Apr
 2026 03:56:59 +0000
Received: from CY4PEPF0000EDD2.namprd03.prod.outlook.com
 (2603:10b6:5:174:cafe::ae) by DM6PR21CA0006.outlook.office365.com
 (2603:10b6:5:174::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.7 via Frontend Transport; Wed,
 22 Apr 2026 03:56:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EDD2.mail.protection.outlook.com (10.167.241.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 22 Apr 2026 03:56:59 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 22:56:59 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 21 Apr
 2026 22:56:58 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Apr 2026 22:56:55 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Dmytro Laktyushkin
 <dmytro.laktyushkin@amd.com>
Subject: [PATCH 09/14] drm/amd/display: Remove Mall, SubVP and MCLK from DCN42
Date: Wed, 22 Apr 2026 11:52:47 +0800
Message-ID: <20260422035611.1870316-10-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
References: <20260422035611.1870316-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD2:EE_|DS0PR12MB8525:EE_
X-MS-Office365-Filtering-Correlation-Id: 1560fe8a-d69e-40ee-112e-08dea023343d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: oKVbnXlDDRIJp51ItssUb1jhFPjb7DAVXzGAZB4oTltFVrxoNpLE1UYpi5Hfvulxz7JlOaUthvYu0m7gAMXfWDPhl4lAM9UuzRdQ5/By+kh3mEdnfJ+43H1QKQZgtg3A6fifGL5q03zKdItfpqYGeRLX7OrUdeE33ZK2oXgDR9JcizkujFkcYp/0vLoh+HeXuQ8qXahVLA9UOCiXNVN/CbhBtpxJezvA5v3Tbb7MjpOULJOD6ljEiax8Wj2IFJMUrsoS5EJSEjuBS8d7xzzmSG4NjxhyiN+EAUovAgFr9je20puDhXfEF1aSOssQo2jxPNuG+RgTiQUBF3emEmDAddtMdZ+z32bU7XQ+Dq1ix4Cawcndvd3v3j0T+XxeodoaCHT2tUsQo08JaonXaV+y84vD9fItGSDhIRdKpFd5xkIWeD5zn3cw8ehIjEJ29UCmjcettLmd/iqpiyc6vPubxUI/qqPKFdfhRpTD55rP0kNOsXa9SjTo4DTbAmSuBXZKYkmz7zNmRUD1c1vv3hs/2ixN5WXvjLoq1Xmo8dhvOpL3fhk7Cw5mjBHo7COaw+lXKIMMV9dD+OFnOHeIAGdnALIcJEePcklh2hiOQkTHFZIArry0P4mdC0oA/Ewj/1fwAXSgL+ZDmy3e0Jj869EZmG4fllXC0Skht8blFf3CVFI+jva5+ALZ6GzICN7m4JX9dubLpTShIuJNZJfw3o9GKPm8/1k1hbgF5KyF/S/WJGG/fXb4DsscQN08moOQy/kIdEqCxrx668vHuzFGIlpjmg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mavDGlQsv+45L7KCWzx/LkA2TrTR9/1302N7lAA/Iecuc7q23gfJN84ZAsAYx+ESTcUjYJJdfb+ZClfZY5qZmdZxY2K16scmRx3+2voUfNI3ohnvehtFzSxkPNOro3L6nzsUiu/9vmm0JJC4IS4dwlF2Cv1AaQQ1PR1mnj7wuGtdHEHgZVOagDrB2yFpPtZ1n5z7wprQ2HIRnr1xOePQD9knB9qqcrwPrbWD/SgX26Sm2uibKR0RPhmV3bva7nGJPn/9gqbeEMGUMEEgar+lQk+lM5NfZ+YuyYynlR9stvho7DbvluUz0BwUo0e0Mw3emIVo4U5IOntGxVMSEJF54T7zaQ2IwoOUJWlFMLR+tdO7FBEb7NPPEAv/4cNK/xyX7zvPeRZBsizqFSVHYYqcvHv8ymbCpaQo+CzIDa4CCnPPiUePCW38KIM/HRgQonDy
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2026 03:56:59.3081 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1560fe8a-d69e-40ee-112e-08dea023343d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8525
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

From: Ivan Lipski <ivan.lipski@amd.com>

[Why&How]
Remove MALL, SubVP and MCLK features from DCN42 resource file since it is
an APU and does not support them.

Assisted-by: Claude:opus-4.6
Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../dc/resource/dcn42/dcn42_resource.c        | 42 -------------------
 1 file changed, 42 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
index 227eb1317663..acd76269abb4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42/dcn42_resource.c
@@ -1807,8 +1807,6 @@ static struct resource_funcs dcn42_res_pool_funcs = {
 	.get_panel_config_defaults = dcn42_get_panel_config_defaults,
 	.get_preferred_eng_id_dpia = dcn42_get_preferred_eng_id_dpia,
 	.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
-	.add_phantom_pipes = dcn32_add_phantom_pipes,
-	.calculate_mall_ways_from_bytes = dcn32_calculate_mall_ways_from_bytes,
 	.prepare_mcache_programming = dcn42_prepare_mcache_programming,
 	.build_pipe_pix_clk_params = dcn42_build_pipe_pix_clk_params,
 	.get_power_profile = dcn401_get_power_profile,
@@ -1898,27 +1896,7 @@ static bool dcn42_resource_construct(
 	dc->caps.cursor_not_scaled = true;
 	dc->caps.min_horizontal_blanking_period = 80;
 	dc->caps.dmdata_alloc_size = 2048;
-	dc->caps.mall_size_per_mem_channel = 4;
-	/* total size = mall per channel * num channels * 1024 * 1024 */
-	dc->caps.mall_size_total = dc->caps.mall_size_per_mem_channel *
-		dc->ctx->dc_bios->vram_info.num_chans * 1048576;
 	dc->caps.cursor_cache_size = dc->caps.max_cursor_size * dc->caps.max_cursor_size * 8;
-	dc->caps.cache_line_size = 64;
-	dc->caps.cache_num_ways = 16;
-
-	/* Calculate the available MALL space */
-	dc->caps.max_cab_allocation_bytes =
-		dcn32_calc_num_avail_chans_for_mall(dc, dc->ctx->dc_bios->vram_info.num_chans) *
-				dc->caps.mall_size_per_mem_channel * 1024 * 1024;
-	dc->caps.mall_size_total = dc->caps.max_cab_allocation_bytes;
-
-	dc->caps.subvp_fw_processing_delay_us = 15;
-	dc->caps.subvp_drr_max_vblank_margin_us = 40;
-	dc->caps.subvp_prefetch_end_to_mall_start_us = 15;
-	dc->caps.subvp_swath_height_margin_lines = 16;
-	dc->caps.subvp_pstate_allow_width_us = 20;
-	dc->caps.subvp_vertical_int_margin_us = 30;
-	dc->caps.subvp_drr_vblank_start_margin_us = 100; // 100us margin
 
 	dc->caps.max_slave_planes = 2;
 	dc->caps.max_slave_yuv_planes = 2;
@@ -2304,26 +2282,6 @@ static bool dcn42_resource_construct(
 	resource_init_common_dml2_callbacks(dc, &dc->dml2_options);
 	dc->dml2_options.callbacks.can_support_mclk_switch_using_fw_based_vblank_stretch =
 			&dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch;
-	dc->dml2_options.svp_pstate.callbacks.release_dsc = &dcn20_release_dsc;
-	dc->dml2_options.svp_pstate.callbacks.calculate_mall_ways_from_bytes =
-		pool->base.funcs->calculate_mall_ways_from_bytes;
-
-	dc->dml2_options.svp_pstate.subvp_fw_processing_delay_us = dc->caps.subvp_fw_processing_delay_us;
-	dc->dml2_options.svp_pstate.subvp_prefetch_end_to_mall_start_us = dc->caps.subvp_prefetch_end_to_mall_start_us;
-	dc->dml2_options.svp_pstate.subvp_pstate_allow_width_us = dc->caps.subvp_pstate_allow_width_us;
-	dc->dml2_options.svp_pstate.subvp_swath_height_margin_lines = dc->caps.subvp_swath_height_margin_lines;
-
-	dc->dml2_options.svp_pstate.force_disable_subvp = dc->debug.force_disable_subvp;
-	dc->dml2_options.svp_pstate.force_enable_subvp = dc->debug.force_subvp_mclk_switch;
-
-	dc->dml2_options.mall_cfg.cache_line_size_bytes = dc->caps.cache_line_size;
-	dc->dml2_options.mall_cfg.cache_num_ways = dc->caps.cache_num_ways;
-	dc->dml2_options.mall_cfg.max_cab_allocation_bytes =
-				dc->caps.max_cab_allocation_bytes;
-	dc->dml2_options.mall_cfg.mblk_height_4bpe_pixels = DCN3_2_MBLK_HEIGHT_4BPE;
-	dc->dml2_options.mall_cfg.mblk_height_8bpe_pixels = DCN3_2_MBLK_HEIGHT_8BPE;
-	dc->dml2_options.mall_cfg.mblk_size_bytes = DCN3_2_MALL_MBLK_SIZE_BYTES;
-	dc->dml2_options.mall_cfg.mblk_width_pixels = DCN3_2_MBLK_WIDTH;
 
 	dc->dml2_options.max_segments_per_hubp = 24;
 	dc->dml2_options.det_segment_size = DCN42_CRB_SEGMENT_SIZE_KB;
-- 
2.43.0


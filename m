Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EFA6C79FA1
	for <amd-gfx@archiver.kernel.org>; Tue,  8 Sep 2026 11:43:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ADA7810EB72;
	Tue,  8 Sep 2026 11:43:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2MJLoLYy";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010014.outbound.protection.outlook.com
 [52.101.193.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98F0310EB70
 for <amd-gfx@lists.freedesktop.org>; Tue,  8 Sep 2026 11:42:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=juWO5ehvQytoDzamEfH8tsjKKRsGzwU2AXgvuXX5eFNx/jTpqwQVhQ++eStczkIfu5G1A8wcz4KJW+miwdiQUGphEYyLx+KfsnRD228m/fnRALOsThwf6gRgSteEE+S1M4+DbPshCTuyY8Ty0TYqOHTC4A6sMSZjSwt/Vz4HWExcgNce8tAP1vAEiFHcPaN086ocDzaiqyFTQvC82XfClUSZRS6jCe9JCzQxpTtPf82eH72yocuy+a+ZsIeHyXYQOwrodTP6DnmJ7PHqdMoH1JK+Xj6PZMj3QIvAeGFrFez3mBnNToeAtufRByqOhv3KF0GO6agu13oJx9QRbeDa3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vxUWL+m6PXqjXFFsgnSKVJtKUWGZwVrf23HsL6c/QWs=;
 b=Vj0VrkdsIB++1K2dQXpihPK3DBPOGD0ylIzhMXuV0aXzQYeIdGP+g3jyBGDNSCxdDfc0CgNFiv2xMqzC8S/2jY3lUvpS9L6t61U9QE4wUViOuxzPdBoRU02auCDK2ffZ/vYKK9LFVY0NuiYN3KZAIj0mYzegumdCKjCzOZD2U2V9Ft9mK0pZZ3PKqOijhpHfmKX9pvOre7tXWtZvWYxYrztCFRqs498XLO0S99H37CaMYHTh8t/ZxpooXKa+CioFdA9lg6szKvQeVeHCLcl+/Nods7a7/xIR5u5ND+xWNdw+cNn1MwI5QRfdO3gnUPzk0Z8QOhVfppWu07KC5Jcvyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vxUWL+m6PXqjXFFsgnSKVJtKUWGZwVrf23HsL6c/QWs=;
 b=2MJLoLYye+EFB2uVU385FqeP5oAg+kW3cURX3zrEvnKw0lJ9Plx+3sXB1eMHV/gwxuMtsVsWk7ifkp0Q+MLT1o4TUlOdnvVf2quSuRMV/35aV4zyNujC/hemJjEvhDTkW11U3/7j+yTNR86z6i9kWpX9mBbSo3SzbZuAUUyq/RY=
Received: from BL1PR13CA0441.namprd13.prod.outlook.com (2603:10b6:208:2c3::26)
 by CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.7; Tue, 8 Sep 2026
 11:42:53 +0000
Received: from BN7PEPF0000009C.namprd04.prod.outlook.com
 (2603:10b6:208:2c3:cafe::82) by BL1PR13CA0441.outlook.office365.com
 (2603:10b6:208:2c3::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.406.7 via Frontend Transport; Tue, 8
 Sep 2026 11:42:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN7PEPF0000009C.mail.protection.outlook.com (10.167.248.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Tue, 8 Sep 2026 11:42:53 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 06:42:37 -0500
Received: from chenyu-station.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.46 via Frontend
 Transport; Tue, 8 Sep 2026 06:42:29 -0500
From: Chenyu Chen <chen-yu.chen@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Gabe Teeger <gabe.teeger@amd.com>, Matthew Stewart
 <matthew.stewart2@amd.com>, Chenyu Chen <chen-yu.chen@amd.com>
Subject: [PATCH 56/66] drm/amd/display: Remove MALL capabilities from DCN42B
Date: Tue, 8 Sep 2026 19:31:49 +0800
Message-ID: <20260908113338.2433445-57-chen-yu.chen@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908113338.2433445-1-chen-yu.chen@amd.com>
References: <20260908113338.2433445-1-chen-yu.chen@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN7PEPF0000009C:EE_|CH3PR12MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: cae5526a-db60-4888-342a-08df0d9e51c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PY4U9FAyyDGbL7++R+dyLUrCafincrcdgCEWuBAT21v4WQWltkJ39L7B78FCtUFhiNjIp18zg1NM2wMVWTlGaN0AU9oc3S3W/b6UDpX2xvjAUicXCgrypqKgFm9AY2OWZMJL4CUO9A6AF8b0Xz3KRm/FfzXOjniZRuqgQIuM4qBXkth2yY3uE8yxZkn+lkX1oQ+t/ZeLYnrf6pZ63LhQTRsfzQu2Wz9QldsnYUE6RJM3SWId+jl09tM4ncfmvOPEjhq7pm/9ASyaJ2cmIbfisu85Oen+PP2cQMt8lCWBZq7L6OxiJ4zusMQpoFqtxLO9wKw4yOBfR8ep8oKWhnTeQfo/dimbCTGJNYQCt9x+T/e+jPm51lrhs9lc4X4qaJbNKAebCkDK5fiLW2s9HJfLI1pc4u6g1iFM6NdhAL7vlwl50qtFNsRDzjZy50wKxbJ1IgCvEeZdWoQfrI0SVqGT44qFAv+viGJpyTTBO4O+p4/pocmyvq6JrO4SEw1p6h5N4Gaa1x4+hV0USqNlp3trW51sIFHVIAQbwl6JFEWTYlsbz+Xl6ifu7oFd2gx1QqZRxHuil5hV1SC/xsXzeMbUwVZgg7hxxhkvhHofSbXSNv0NXrGNK0hpc0yu6SrRVVTud/G4obvESN8jgQVssHytH1mr1YwmdWUKCISNuWEGXTlVC6bg8w9PbL6XG3w+WpDj
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: CZcsr63UEDp3hJ++rJ4gm+JBvyq5KzK2DH7TWL7S+/UnS8Sge8H17P5Kk8uJ3lZaixP3hzykMRjpuFPZFic15ZgX0gu76JAqRbNTYrQ+BlA3lx6EhRStqMAjC6nc1c332+SJ7K9z3GiQI2a5F1qZGOmTtps4qWD4+IJaTAjC9Sc9ZQ8ENr4nXpkQ1O6qEIYKL0eCZmLPP3X3nWpcDjOjGOBEPqLse8N8ny/AuXKuUKUQpAOPkfyRqDG6bwQ9RZF8xgUYZ55Mm5BPSpmq4VIMllDvhN3D3U0BFzQzUobXNm+abl/55IvPCC5yfIovzR/Rh03FJJ8DYwb7b0pK9ND6ykKvA4qZjv9iv7IIifs0uQqK6R3jL9gqd905ILop4Hm7Dd+pfKV7zgwWnZ3qH/ahpsCp7Aq65ohswazUgxFtzMpQa9qr3Gf4DY0jew/6nGUh
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 11:42:53.7338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cae5526a-db60-4888-342a-08df0d9e51c5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN7PEPF0000009C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658
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

From: Gabe Teeger <gabe.teeger@amd.com>

[Why]
DCN42B has no MALL, but the resource file advertised MALL and CAB
sizes. SubVP was also enabled even though its phantom surfaces
are allocated in MALL.

[How]
Drop the MALL and SubVP caps, the dml2_options svp_pstate and
mall_cfg setup, and the add_phantom_pipes and
calculate_mall_ways_from_bytes callbacks. Disable SubVP.

Reviewed-by: Matthew Stewart <matthew.stewart2@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
---
 .../dc/resource/dcn42b/dcn42b_resource.c      | 45 +------------------
 1 file changed, 2 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
index 092b61b3fafc..b31f8cbd5f4c 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn42b/dcn42b_resource.c
@@ -851,7 +851,8 @@ static const struct dc_debug_options debug_defaults_drv = {
 	.minimum_z8_residency_time = 1, /* Always allow when other conditions are met */
 	.support_eDP1_5 = true,
 	.use_max_lb = true,
-	.force_disable_subvp = false,
+	/* SubVP phantom surfaces require MALL, which DCN42B does not have */
+	.force_disable_subvp = true,
 	.exit_idle_opt_for_cursor_updates = true,
 	.using_dml2 = true,
 	.using_dml21 = true,
@@ -1974,8 +1975,6 @@ static struct resource_funcs dcn42b_res_pool_funcs = {
 	.get_panel_config_defaults = dcn42b_get_panel_config_defaults,
 	//.get_preferred_eng_id_dpia = dcn42b_get_preferred_eng_id_dpia,
 	.update_soc_for_wm_a = dcn30_update_soc_for_wm_a,
-	.add_phantom_pipes = dcn32_add_phantom_pipes,
-	.calculate_mall_ways_from_bytes = dcn32_calculate_mall_ways_from_bytes,
 	.prepare_mcache_programming = dcn42b_prepare_mcache_programming,
 	.build_pipe_pix_clk_params = dcn42b_build_pipe_pix_clk_params,
 	.get_power_profile = dcn401_get_power_profile,
@@ -2041,27 +2040,7 @@ static bool dcn42b_resource_construct(
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
@@ -2449,26 +2428,6 @@ static bool dcn42b_resource_construct(
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


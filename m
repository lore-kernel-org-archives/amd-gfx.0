Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C809DC43334
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:38:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5CFF410F5A8;
	Sat, 16 Jul 2022 14:35:44 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A36310E1EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:17:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fLfVt/3LgzLrLJu1vgMuoDYxtJ1jnSb5gQuyX7cKfVUjXaYCQhKKA8z2FLkuMkDYeVdsV1bNYhFLYaU9aFjNWxJDMpEsURjBgbcUq6ZOFvnLABVxot77gTE290+mI07QrWl0L+fOyGKLus4PzHFYKyh3M85Q/6I2BkYWhAa7KZeKkcVo9GUwW8Pf514LyswmmycwpPFb3TNZ401mD20YrSlGlzrJkranCB80bAUD9W+K3Jg8cBA4oZUzWqbZ6UdbiWlZz1TW35QqStoUJiWX1He6olXDijTZcO8GVH47M6i1rk8U2YJp8HUo1Xg/lJAZPX+9Cusbo9KdRceA/oUPVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Br9w7nexEINInDdDV8CPquNtFFALLquMBTMbPS5y9HA=;
 b=Yoipt3eNck0IHf5v3UcQEazaJVfT+0u7ePjdwZfaPhhE53X/XbhFkb/OSLk5pmZBiUyIqhjwPyEE696O1brzSE8+kOTjXgd9bIuP3jkhJ8tj2TKF+50TiIqLUCWlavHPd5O376ttAsu2Am3/IbIIoVXmpGJlt0sBmndQUh9oKZI7QjjGoehH19DDl1inkcNMcbez/dkasjaoVHpNC4adaurDBGZmMmn8MT1IO6x/liSiH9UPR1heZlsO6dGLdVpsANT444lFS8bxlVVSrQQGg/lCfssCZIrf+5QTOuSFgCzmR44DjeBbpkH/Lxh36fdKZuUVNnGBlGYiQYAMJi/hmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Br9w7nexEINInDdDV8CPquNtFFALLquMBTMbPS5y9HA=;
 b=FUaLXsE89FtscGRra/wprI43FFZFfttDNEDHTyLxR1aIy45uP0E0U3CGvvoI4dPCZ5C/j8VK68yWw+dtIY553EBkdMQcoDllqB836t5REmonHpw+fBZlrFp620Xl6911ddSkq/LDV43Ux846BA3yq7BOWDe64D5VbOnmKbj11s8=
Received: from MW4P221CA0019.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::24)
 by DM5PR12MB1756.namprd12.prod.outlook.com (2603:10b6:3:108::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.17; Fri, 15 Jul
 2022 18:17:51 +0000
Received: from CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::f3) by MW4P221CA0019.outlook.office365.com
 (2603:10b6:303:8b::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT018.mail.protection.outlook.com (10.13.175.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:51 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:50 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:50 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:49 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/31] drm/amd/display: Move insert entry table to the FPU code
Date: Fri, 15 Jul 2022 14:16:55 -0400
Message-ID: <20220715181705.1030401-22-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57473e06-1837-4f4e-2796-08da668e5477
X-MS-TrafficTypeDiagnostic: DM5PR12MB1756:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E/pe19fSeD20DDPrJVNaklPVF9wq8ZSr/Yw/RrL+cxFugLqCjkYmGGG6hiLkuy0I7a5jHOzoPSeqgaFHs8Pga8nCtbbs/gSCB5Ro4JcO5AuxjXe4MR04t7yPoSBPr/tH6lBtSxSEqLZwmzWbTFuqV7eOIjFBRCXIuavuaxVEoxgGYgxL4kgBcbDPHUJ+1GrlIj04JoSY72hdNVO1b3pPNCeCRT7ecSUatYnafTCN+jSzMrZcVPKN8uMp565twsvyzi4glLfToQyWbkQ0yW9vyNJj8FvbMn3Uf4ha61v9hjfR+9CV0Dnl+nIJViJP9gTO3Mm8OVUJrSDMhJyvA5mVEtJby3Yvufvu0xaBrOmfAq/7glrWDhdTQVcJ+nAqu6cOcChTDv3Xzq4OaHs4A3CV/VTbhdSc72Ru0aWM7KLI+32rqCr/mc+XT/3GLo8kbkGKFWSCVozhs85uDdQ92x9p/RNVs8pYCemLIQaSXemGFDgSFCcQAs9bZzubKNnDFoLAcVewt/LupCFrNyXAakILn5hUwUIi4oXFwbBm8rhasM/WvcNcXFc7zNPJL5+W6yomJzsgmR+OsWgKw5QWr/MfGG0EoQOav+NMC9iOJMaoQ2E7oyxoY98Ei4d2lvTZm8bhc8ssuycA7cxGNDa+WtL5lgGmqQHhVVLSArhB/sg9u/dCRq8jmldQkQgvUcsfEKCXbNZmYXDKM16rXHPTivrACKEOAPfxJAqtqaTd1iyEDjTBPeWIuk5+S0tmcOfoqDLHnYIzdOJEbqPl5VW5QpgdVoLEyYDaXvpC80QS0AF1bCAKkv/ttGMTAneagQO5xrK04PKvvoPCsV0mp8+yM8jdTw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(39860400002)(136003)(396003)(36840700001)(40470700004)(46966006)(30864003)(6916009)(36860700001)(40460700003)(81166007)(26005)(36756003)(6666004)(316002)(54906003)(41300700001)(478600001)(82310400005)(2616005)(70586007)(70206006)(8676002)(336012)(426003)(356005)(47076005)(4326008)(83380400001)(40480700001)(5660300002)(1076003)(8936002)(2906002)(82740400003)(186003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:51.2955 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57473e06-1837-4f4e-2796-08da668e5477
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT018.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1756
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

The insert_entry_into_table_sorted function uses FPU operation and calls
other static functions support. This commit moves the insert entry
function with all the required struct and static functions to the FPU
file.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 188 +-----------------
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   3 +
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 186 +++++++++++++++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |   9 +
 4 files changed, 208 insertions(+), 178 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index a56d87140eba..1c124231b00a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -115,137 +115,6 @@ static const struct IP_BASE DCN_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C
 
 #define DC_LOGGER_INIT(logger)
 
-#define DCN3_2_DEFAULT_DET_SIZE 256
-#define DCN3_2_MAX_DET_SIZE 1152
-#define DCN3_2_MIN_DET_SIZE 128
-#define DCN3_2_MIN_COMPBUF_SIZE_KB 128
-
-struct _vcs_dpi_ip_params_st dcn3_2_ip = {
-	.gpuvm_enable = 0,
-	.gpuvm_max_page_table_levels = 4,
-	.hostvm_enable = 0,
-	.rob_buffer_size_kbytes = 128,
-	.det_buffer_size_kbytes = DCN3_2_DEFAULT_DET_SIZE,
-	.config_return_buffer_size_in_kbytes = 1280,
-	.compressed_buffer_segment_size_in_kbytes = 64,
-	.meta_fifo_size_in_kentries = 22,
-	.zero_size_buffer_entries = 512,
-	.compbuf_reserved_space_64b = 256,
-	.compbuf_reserved_space_zs = 64,
-	.dpp_output_buffer_pixels = 2560,
-	.opp_output_buffer_lines = 1,
-	.pixel_chunk_size_kbytes = 8,
-	.alpha_pixel_chunk_size_kbytes = 4, // not appearing in spreadsheet, match c code from hw team
-	.min_pixel_chunk_size_bytes = 1024,
-	.dcc_meta_buffer_size_bytes = 6272,
-	.meta_chunk_size_kbytes = 2,
-	.min_meta_chunk_size_bytes = 256,
-	.writeback_chunk_size_kbytes = 8,
-	.ptoi_supported = false,
-	.num_dsc = 4,
-	.maximum_dsc_bits_per_component = 12,
-	.maximum_pixels_per_line_per_dsc_unit = 6016,
-	.dsc422_native_support = true,
-	.is_line_buffer_bpp_fixed = true,
-	.line_buffer_fixed_bpp = 57,
-	.line_buffer_size_bits = 1171920, //DPP doc, DCN3_2_DisplayMode_73.xlsm still shows as 986880 bits with 48 bpp
-	.max_line_buffer_lines = 32,
-	.writeback_interface_buffer_size_kbytes = 90,
-	.max_num_dpp = 4,
-	.max_num_otg = 4,
-	.max_num_hdmi_frl_outputs = 1,
-	.max_num_wb = 1,
-	.max_dchub_pscl_bw_pix_per_clk = 4,
-	.max_pscl_lb_bw_pix_per_clk = 2,
-	.max_lb_vscl_bw_pix_per_clk = 4,
-	.max_vscl_hscl_bw_pix_per_clk = 4,
-	.max_hscl_ratio = 6,
-	.max_vscl_ratio = 6,
-	.max_hscl_taps = 8,
-	.max_vscl_taps = 8,
-	.dpte_buffer_size_in_pte_reqs_luma = 64,
-	.dpte_buffer_size_in_pte_reqs_chroma = 34,
-	.dispclk_ramp_margin_percent = 1,
-	.max_inter_dcn_tile_repeaters = 8,
-	.cursor_buffer_size = 16,
-	.cursor_chunk_size = 2,
-	.writeback_line_buffer_buffer_size = 0,
-	.writeback_min_hscl_ratio = 1,
-	.writeback_min_vscl_ratio = 1,
-	.writeback_max_hscl_ratio = 1,
-	.writeback_max_vscl_ratio = 1,
-	.writeback_max_hscl_taps = 1,
-	.writeback_max_vscl_taps = 1,
-	.dppclk_delay_subtotal = 47,
-	.dppclk_delay_scl = 50,
-	.dppclk_delay_scl_lb_only = 16,
-	.dppclk_delay_cnvc_formatter = 28,
-	.dppclk_delay_cnvc_cursor = 6,
-	.dispclk_delay_subtotal = 125,
-	.dynamic_metadata_vm_enabled = false,
-	.odm_combine_4to1_supported = false,
-	.dcc_supported = true,
-	.max_num_dp2p0_outputs = 2,
-	.max_num_dp2p0_streams = 4,
-};
-
-struct _vcs_dpi_soc_bounding_box_st dcn3_2_soc = {
-	.clock_limits = {
-		{
-			.state = 0,
-			.dcfclk_mhz = 1564.0,
-			.fabricclk_mhz = 400.0,
-			.dispclk_mhz = 2150.0,
-			.dppclk_mhz = 2150.0,
-			.phyclk_mhz = 810.0,
-			.phyclk_d18_mhz = 667.0,
-			.phyclk_d32_mhz = 625.0,
-			.socclk_mhz = 1200.0,
-			.dscclk_mhz = 716.667,
-			.dram_speed_mts = 1600.0,
-			.dtbclk_mhz = 1564.0,
-		},
-	},
-	.num_states = 1,
-	.sr_exit_time_us = 5.20,
-	.sr_enter_plus_exit_time_us = 9.60,
-	.sr_exit_z8_time_us = 285.0,
-	.sr_enter_plus_exit_z8_time_us = 320,
-	.writeback_latency_us = 12.0,
-	.round_trip_ping_latency_dcfclk_cycles = 263,
-	.urgent_latency_pixel_data_only_us = 4.0,
-	.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
-	.urgent_latency_vm_data_only_us = 4.0,
-	.fclk_change_latency_us = 20,
-	.usr_retraining_latency_us = 2,
-	.smn_latency_us = 2,
-	.mall_allocated_for_dcn_mbytes = 64,
-	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
-	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
-	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
-	.pct_ideal_sdp_bw_after_urgent = 100.0,
-	.pct_ideal_fabric_bw_after_urgent = 67.0,
-	.pct_ideal_dram_sdp_bw_after_urgent_pixel_only = 20.0,
-	.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm = 60.0, // N/A, for now keep as is until DML implemented
-	.pct_ideal_dram_sdp_bw_after_urgent_vm_only = 30.0, // N/A, for now keep as is until DML implemented
-	.pct_ideal_dram_bw_after_urgent_strobe = 67.0,
-	.max_avg_sdp_bw_use_normal_percent = 80.0,
-	.max_avg_fabric_bw_use_normal_percent = 60.0,
-	.max_avg_dram_bw_use_normal_strobe_percent = 50.0,
-	.max_avg_dram_bw_use_normal_percent = 15.0,
-	.num_chans = 8,
-	.dram_channel_width_bytes = 2,
-	.fabric_datapath_to_dcn_data_return_bytes = 64,
-	.return_bus_width_bytes = 64,
-	.downspread_percent = 0.38,
-	.dcn_downspread_percent = 0.5,
-	.dram_clock_change_latency_us = 400,
-	.dispclk_dppclk_vco_speed_mhz = 4300.0,
-	.do_urgent_latency_adjustment = true,
-	.urgent_latency_adjustment_fabric_clock_component_us = 1.0,
-	.urgent_latency_adjustment_fabric_clock_reference_mhz = 1000,
-};
-
 enum dcn32_clk_src_array_id {
 	DCN32_CLK_SRC_PLL0,
 	DCN32_CLK_SRC_PLL1,
@@ -3455,53 +3324,6 @@ static void get_optimal_ntuple(struct _vcs_dpi_voltage_scaling_st *entry)
 	}
 }
 
-static float calculate_net_bw_in_kbytes_sec(struct _vcs_dpi_voltage_scaling_st *entry)
-{
-	float memory_bw_kbytes_sec = entry->dram_speed_mts * dcn3_2_soc.num_chans *
-			dcn3_2_soc.dram_channel_width_bytes * ((float)dcn3_2_soc.pct_ideal_dram_sdp_bw_after_urgent_pixel_only / 100);
-
-	float fabric_bw_kbytes_sec = entry->fabricclk_mhz * dcn3_2_soc.return_bus_width_bytes * ((float)dcn3_2_soc.pct_ideal_fabric_bw_after_urgent / 100);
-
-	float sdp_bw_kbytes_sec = entry->dcfclk_mhz * dcn3_2_soc.return_bus_width_bytes * ((float)dcn3_2_soc.pct_ideal_sdp_bw_after_urgent / 100);
-
-	float limiting_bw_kbytes_sec = memory_bw_kbytes_sec;
-
-	if (fabric_bw_kbytes_sec < limiting_bw_kbytes_sec)
-		limiting_bw_kbytes_sec = fabric_bw_kbytes_sec;
-
-	if (sdp_bw_kbytes_sec < limiting_bw_kbytes_sec)
-		limiting_bw_kbytes_sec = sdp_bw_kbytes_sec;
-
-	return limiting_bw_kbytes_sec;
-}
-
-static void insert_entry_into_table_sorted(struct _vcs_dpi_voltage_scaling_st *table, unsigned int *num_entries,
-		struct _vcs_dpi_voltage_scaling_st *entry)
-{
-	int index = 0;
-	int i = 0;
-	float net_bw_of_new_state = 0;
-
-	if (*num_entries == 0) {
-		table[0] = *entry;
-		(*num_entries)++;
-	} else {
-		net_bw_of_new_state = calculate_net_bw_in_kbytes_sec(entry);
-		while (net_bw_of_new_state > calculate_net_bw_in_kbytes_sec(&table[index])) {
-			index++;
-			if (index >= *num_entries)
-				break;
-		}
-
-		for (i = *num_entries; i > index; i--) {
-			table[i] = table[i - 1];
-		}
-
-		table[index] = *entry;
-		(*num_entries)++;
-	}
-}
-
 static void remove_entry_from_table_at_index(struct _vcs_dpi_voltage_scaling_st *table, unsigned int *num_entries,
 		unsigned int index)
 {
@@ -3586,7 +3408,9 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 		entry.dram_speed_mts = 0;
 
 		get_optimal_ntuple(&entry);
+		DC_FP_START();
 		insert_entry_into_table_sorted(table, num_entries, &entry);
+		DC_FP_END();
 	}
 
 	// Insert the max DCFCLK
@@ -3595,7 +3419,9 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 	entry.dram_speed_mts = 0;
 
 	get_optimal_ntuple(&entry);
+	DC_FP_START();
 	insert_entry_into_table_sorted(table, num_entries, &entry);
+	DC_FP_END();
 
 	// Insert the UCLK DPMS
 	for (i = 0; i < num_uclk_dpms; i++) {
@@ -3604,7 +3430,9 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 		entry.dram_speed_mts = bw_params->clk_table.entries[i].memclk_mhz * 16;
 
 		get_optimal_ntuple(&entry);
+		DC_FP_START();
 		insert_entry_into_table_sorted(table, num_entries, &entry);
+		DC_FP_END();
 	}
 
 	// If FCLK is coarse grained, insert individual DPMs.
@@ -3615,7 +3443,9 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 			entry.dram_speed_mts = 0;
 
 			get_optimal_ntuple(&entry);
+			DC_FP_START();
 			insert_entry_into_table_sorted(table, num_entries, &entry);
+			DC_FP_END();
 		}
 	}
 	// If FCLK fine grained, only insert max
@@ -3625,7 +3455,9 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 		entry.dram_speed_mts = 0;
 
 		get_optimal_ntuple(&entry);
+		DC_FP_START();
 		insert_entry_into_table_sorted(table, num_entries, &entry);
+		DC_FP_END();
 	}
 
 	// At this point, the table contains all "points of interest" based on
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 901aa7e13bd2..7ccad84b1f16 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -33,6 +33,9 @@
 #define TO_DCN32_RES_POOL(pool)\
 	container_of(pool, struct dcn32_resource_pool, base)
 
+extern struct _vcs_dpi_ip_params_st dcn3_2_ip;
+extern struct _vcs_dpi_soc_bounding_box_st dcn3_2_soc;
+
 struct dcn32_resource_pool {
 	struct resource_pool base;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 1b9e34f1232a..4223a9a9dd45 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -28,6 +28,132 @@
 // We need this includes for WATERMARKS_* defines
 #include "clk_mgr/dcn32/dcn32_smu13_driver_if.h"
 
+struct _vcs_dpi_ip_params_st dcn3_2_ip = {
+	.gpuvm_enable = 0,
+	.gpuvm_max_page_table_levels = 4,
+	.hostvm_enable = 0,
+	.rob_buffer_size_kbytes = 128,
+	.det_buffer_size_kbytes = DCN3_2_DEFAULT_DET_SIZE,
+	.config_return_buffer_size_in_kbytes = 1280,
+	.compressed_buffer_segment_size_in_kbytes = 64,
+	.meta_fifo_size_in_kentries = 22,
+	.zero_size_buffer_entries = 512,
+	.compbuf_reserved_space_64b = 256,
+	.compbuf_reserved_space_zs = 64,
+	.dpp_output_buffer_pixels = 2560,
+	.opp_output_buffer_lines = 1,
+	.pixel_chunk_size_kbytes = 8,
+	.alpha_pixel_chunk_size_kbytes = 4,
+	.min_pixel_chunk_size_bytes = 1024,
+	.dcc_meta_buffer_size_bytes = 6272,
+	.meta_chunk_size_kbytes = 2,
+	.min_meta_chunk_size_bytes = 256,
+	.writeback_chunk_size_kbytes = 8,
+	.ptoi_supported = false,
+	.num_dsc = 4,
+	.maximum_dsc_bits_per_component = 12,
+	.maximum_pixels_per_line_per_dsc_unit = 6016,
+	.dsc422_native_support = true,
+	.is_line_buffer_bpp_fixed = true,
+	.line_buffer_fixed_bpp = 57,
+	.line_buffer_size_bits = 1171920,
+	.max_line_buffer_lines = 32,
+	.writeback_interface_buffer_size_kbytes = 90,
+	.max_num_dpp = 4,
+	.max_num_otg = 4,
+	.max_num_hdmi_frl_outputs = 1,
+	.max_num_wb = 1,
+	.max_dchub_pscl_bw_pix_per_clk = 4,
+	.max_pscl_lb_bw_pix_per_clk = 2,
+	.max_lb_vscl_bw_pix_per_clk = 4,
+	.max_vscl_hscl_bw_pix_per_clk = 4,
+	.max_hscl_ratio = 6,
+	.max_vscl_ratio = 6,
+	.max_hscl_taps = 8,
+	.max_vscl_taps = 8,
+	.dpte_buffer_size_in_pte_reqs_luma = 64,
+	.dpte_buffer_size_in_pte_reqs_chroma = 34,
+	.dispclk_ramp_margin_percent = 1,
+	.max_inter_dcn_tile_repeaters = 8,
+	.cursor_buffer_size = 16,
+	.cursor_chunk_size = 2,
+	.writeback_line_buffer_buffer_size = 0,
+	.writeback_min_hscl_ratio = 1,
+	.writeback_min_vscl_ratio = 1,
+	.writeback_max_hscl_ratio = 1,
+	.writeback_max_vscl_ratio = 1,
+	.writeback_max_hscl_taps = 1,
+	.writeback_max_vscl_taps = 1,
+	.dppclk_delay_subtotal = 47,
+	.dppclk_delay_scl = 50,
+	.dppclk_delay_scl_lb_only = 16,
+	.dppclk_delay_cnvc_formatter = 28,
+	.dppclk_delay_cnvc_cursor = 6,
+	.dispclk_delay_subtotal = 125,
+	.dynamic_metadata_vm_enabled = false,
+	.odm_combine_4to1_supported = false,
+	.dcc_supported = true,
+	.max_num_dp2p0_outputs = 2,
+	.max_num_dp2p0_streams = 4,
+};
+
+struct _vcs_dpi_soc_bounding_box_st dcn3_2_soc = {
+	.clock_limits = {
+		{
+			.state = 0,
+			.dcfclk_mhz = 1564.0,
+			.fabricclk_mhz = 400.0,
+			.dispclk_mhz = 2150.0,
+			.dppclk_mhz = 2150.0,
+			.phyclk_mhz = 810.0,
+			.phyclk_d18_mhz = 667.0,
+			.phyclk_d32_mhz = 625.0,
+			.socclk_mhz = 1200.0,
+			.dscclk_mhz = 716.667,
+			.dram_speed_mts = 16000.0,
+			.dtbclk_mhz = 1564.0,
+		},
+	},
+	.num_states = 1,
+	.sr_exit_time_us = 5.20,
+	.sr_enter_plus_exit_time_us = 9.60,
+	.sr_exit_z8_time_us = 285.0,
+	.sr_enter_plus_exit_z8_time_us = 320,
+	.writeback_latency_us = 12.0,
+	.round_trip_ping_latency_dcfclk_cycles = 263,
+	.urgent_latency_pixel_data_only_us = 4.0,
+	.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
+	.urgent_latency_vm_data_only_us = 4.0,
+	.fclk_change_latency_us = 20,
+	.usr_retraining_latency_us = 2,
+	.smn_latency_us = 2,
+	.mall_allocated_for_dcn_mbytes = 64,
+	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
+	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
+	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
+	.pct_ideal_sdp_bw_after_urgent = 100.0,
+	.pct_ideal_fabric_bw_after_urgent = 67.0,
+	.pct_ideal_dram_sdp_bw_after_urgent_pixel_only = 20.0,
+	.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm = 60.0, // N/A, for now keep as is until DML implemented
+	.pct_ideal_dram_sdp_bw_after_urgent_vm_only = 30.0, // N/A, for now keep as is until DML implemented
+	.pct_ideal_dram_bw_after_urgent_strobe = 67.0,
+	.max_avg_sdp_bw_use_normal_percent = 80.0,
+	.max_avg_fabric_bw_use_normal_percent = 60.0,
+	.max_avg_dram_bw_use_normal_strobe_percent = 50.0,
+	.max_avg_dram_bw_use_normal_percent = 15.0,
+	.num_chans = 8,
+	.dram_channel_width_bytes = 2,
+	.fabric_datapath_to_dcn_data_return_bytes = 64,
+	.return_bus_width_bytes = 64,
+	.downspread_percent = 0.38,
+	.dcn_downspread_percent = 0.5,
+	.dram_clock_change_latency_us = 400,
+	.dispclk_dppclk_vco_speed_mhz = 4300.0,
+	.do_urgent_latency_adjustment = true,
+	.urgent_latency_adjustment_fabric_clock_component_us = 1.0,
+	.urgent_latency_adjustment_fabric_clock_reference_mhz = 1000,
+};
+
 void dcn32_build_wm_range_table_fpu(struct clk_mgr_internal *clk_mgr)
 {
 	/* defaults */
@@ -191,3 +317,63 @@ bool dcn32_predict_pipe_split(struct dc_state *context, display_pipe_params_st p
 		return false;
 }
 
+static float calculate_net_bw_in_kbytes_sec(struct _vcs_dpi_voltage_scaling_st *entry)
+{
+	float memory_bw_kbytes_sec;
+	float fabric_bw_kbytes_sec;
+	float sdp_bw_kbytes_sec;
+	float limiting_bw_kbytes_sec;
+
+	memory_bw_kbytes_sec = entry->dram_speed_mts *
+				dcn3_2_soc.num_chans *
+				dcn3_2_soc.dram_channel_width_bytes *
+				((float)dcn3_2_soc.pct_ideal_dram_sdp_bw_after_urgent_pixel_only / 100);
+
+	fabric_bw_kbytes_sec = entry->fabricclk_mhz *
+				dcn3_2_soc.return_bus_width_bytes *
+				((float)dcn3_2_soc.pct_ideal_fabric_bw_after_urgent / 100);
+
+	sdp_bw_kbytes_sec = entry->dcfclk_mhz *
+				dcn3_2_soc.return_bus_width_bytes *
+				((float)dcn3_2_soc.pct_ideal_sdp_bw_after_urgent / 100);
+
+	limiting_bw_kbytes_sec = memory_bw_kbytes_sec;
+
+	if (fabric_bw_kbytes_sec < limiting_bw_kbytes_sec)
+		limiting_bw_kbytes_sec = fabric_bw_kbytes_sec;
+
+	if (sdp_bw_kbytes_sec < limiting_bw_kbytes_sec)
+		limiting_bw_kbytes_sec = sdp_bw_kbytes_sec;
+
+	return limiting_bw_kbytes_sec;
+}
+
+void insert_entry_into_table_sorted(struct _vcs_dpi_voltage_scaling_st *table,
+				    unsigned int *num_entries,
+				    struct _vcs_dpi_voltage_scaling_st *entry)
+{
+	int i = 0;
+	int index = 0;
+	float net_bw_of_new_state = 0;
+
+	dc_assert_fp_enabled();
+
+	if (*num_entries == 0) {
+		table[0] = *entry;
+		(*num_entries)++;
+	} else {
+		net_bw_of_new_state = calculate_net_bw_in_kbytes_sec(entry);
+		while (net_bw_of_new_state > calculate_net_bw_in_kbytes_sec(&table[index])) {
+			index++;
+			if (index >= *num_entries)
+				break;
+		}
+
+		for (i = *num_entries; i > index; i--)
+			table[i] = table[i - 1];
+
+		table[index] = *entry;
+		(*num_entries)++;
+	}
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
index d5f157cdd0b4..62cb0c1d462c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
@@ -29,6 +29,11 @@
 
 #include "clk_mgr_internal.h"
 
+#define DCN3_2_DEFAULT_DET_SIZE 256
+#define DCN3_2_MAX_DET_SIZE 1152
+#define DCN3_2_MIN_DET_SIZE 128
+#define DCN3_2_MIN_COMPBUF_SIZE_KB 128
+
 void dcn32_build_wm_range_table_fpu(struct clk_mgr_internal *clk_mgr);
 
 void dcn32_helper_populate_phantom_dlg_params(struct dc *dc,
@@ -40,4 +45,8 @@ bool dcn32_predict_pipe_split(struct dc_state *context,
 			      display_pipe_params_st pipe,
 			      int index);
 
+void insert_entry_into_table_sorted(struct _vcs_dpi_voltage_scaling_st *table,
+				    unsigned int *num_entries,
+				    struct _vcs_dpi_voltage_scaling_st *entry);
+
 #endif
-- 
2.37.0


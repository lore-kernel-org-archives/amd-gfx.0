Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21277C43334
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:39:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D15E210FA8B;
	Sat, 16 Jul 2022 14:36:01 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2072.outbound.protection.outlook.com [40.107.101.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E95610E275
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:18:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XVb9nZ4hGaR1Wbxe+o4GXqADtfHC92t65oGSjrO/o8xnSpk+Yf/MfykfGqTO2ddaXcwclQ3c9/bq8Ci6ox/y8LjxT1sy7yarAqv4zRSmGGtTOkpOFIhGfk0f6TzEw2uRCIJFOLLUCbNRWHlR7zdA5dPkEOo0z+MEg9Y15/xS89OJ4GLpo2/WKECTqY5WxabCs/VwtZdf32Jtus6mJTZZ+EbcmZ3NsNpvnDkpobEx19NvxfDvG3R1vcez2dWcK7yuZEFfEU86/JlbjPcahELYgLlvoDDXahNG3DP4uKezkmD79earK2FUkGzgOl9HfJSxf7j0zpR/W3mlqWr6OfOARQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=upWxohdSKZdLcLikeeP/euFiS3e6nU0jd6OaVazhKts=;
 b=IKeWPjd6ADBF9Z/9FcV6MPQvAX0rei8xiGOF9scsJCsRBRjTYLEFbAqvx68SXCfv/QDtB44d8Bv9fX+WHoOJTftpUCsIEyGsursRovcwCFuwnsLNIesQMymk3PRy7H62dxvd62/YFl0TdzNq1f9J6JktnhwE3rvOPYTVNnl+bWwDuJlrCmV5vMJwzNNC+kWxaRuGMJ7/ksy3FtrQd3k+PyKN8UYaDUOximvPn9Rvn038IXNstBLGu4nDZRi44GBF+YsEqoLigOc85/Xc/VgqVzFhXceptaEW4LPP5DZHvJ2Ihr/6QWEinSAjgR2qyrJ9yuJiCVaMM+VlBYUqUA5VFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=upWxohdSKZdLcLikeeP/euFiS3e6nU0jd6OaVazhKts=;
 b=PMyDVcIGL9CtqQ5+O9gU92hcdbuwdtrfVfEQCJ2BnsVC4rnsKj30HYnOPl/KVQ+f7ctlyJyDS1smeKH5Vx44PtxsgEIu9itk+Gl0u1jCHh9Ikpm7IMPTenZbSmDuGRib3OqbQKwzrKtnZRNof1khsHadVV17qPRKMjQqA2BbaXg=
Received: from DM6PR06CA0067.namprd06.prod.outlook.com (2603:10b6:5:54::44) by
 LV2PR12MB5989.namprd12.prod.outlook.com (2603:10b6:408:171::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Fri, 15 Jul
 2022 18:17:59 +0000
Received: from DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::21) by DM6PR06CA0067.outlook.office365.com
 (2603:10b6:5:54::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT017.mail.protection.outlook.com (10.13.172.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:58 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:57 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:57 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/31] drm/amd/display: Create dcn321_fpu file
Date: Fri, 15 Jul 2022 14:17:03 -0400
Message-ID: <20220715181705.1030401-30-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 853deaf0-3d46-4a42-3388-08da668e58dd
X-MS-TrafficTypeDiagnostic: LV2PR12MB5989:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e5O+fnxxHZAO+joNwBo+K4TbgUwJUcOxhz7/siohi+dvLah+JHBIdMozvpuMz8vIj3IirEhKKTdI8SfJBTai+l9yF7/bRStdK9Xsxbw3/gSJHhEgBVTuhN49IQ6/i8bChibhESMOOTJl8+u5FydoA7c6iEN/+WJGCP6F6uOhlwbNRncAaZsZvKY8woms9b72PFN6jAvvKowjxq786Cl7TzMJggX6nzfwdpa36njIim95N7FmRmcils+0LieCY0yXpHOhXSBEtjjaq+6wm6whViIFxp9jutS1n96+euxw7pOSMb0slhPtgXUjuU06xmuNoIC5vOHIFlI7uRc3TflbnXykpIoSUi0VlSoSrCNh/fAWGoQhr++C+tNb7FdcYj5A/92DDgC+eZMUzPQBA7tB1cpi+suEoavtTu6xLdO8CTo+GBa45NZWADY6xkmEeC84NrXSpbnbzJeh52me+SvmD+a35C53EYhsDMGCtyXndiro+k5P3lCaB8DkD4HoVybmIjbI1zYJDJ8KIt+9mQNspe3YY7kUMX5en3wuhJkWbZrjbGCy0dHcEP6kxQ6570rmnZfy5zAqHuWzWwhQh8tji902t+i45s47FCLgA4+suMgQHVqa9b8OSj2wwx0amkahWSKyrAZFdQjXI6lQKsimz44ytaFhQSCjhGu0tk37Fm3ZQlrmBdTUlG46KQ1hANZykLpc4LPDjU7dmBjmEAfuADC5+FPWEWoz4+nOTWgrzCiHnKn2uR4kcO24mEq7XQ+apiHBC3LXrV6pif65Ixb6UAOU9a22fPGj591AKOPvxTfw0H4ACBji651fGU/dDiw4ErofwPH1RnjPdwMQFoBhMA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(39860400002)(40470700004)(46966006)(36840700001)(82310400005)(478600001)(70586007)(8676002)(4326008)(30864003)(36756003)(316002)(70206006)(54906003)(6916009)(36860700001)(40460700003)(5660300002)(2906002)(8936002)(41300700001)(40480700001)(26005)(81166007)(82740400003)(47076005)(186003)(83380400001)(336012)(6666004)(426003)(356005)(2616005)(1076003)(86362001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:58.7533 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 853deaf0-3d46-4a42-3388-08da668e58dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT017.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5989
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

The file dcn321_resource has a lot of FPU operations that should be
inside the dml folder. This commit introduces the dcn321_fpu file and
moves some of the FPU operation functions to this new file.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/dcn321/dcn321_resource.c   | 225 ++---------------
 .../amd/display/dc/dcn321/dcn321_resource.h   |   3 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   2 +
 .../amd/display/dc/dml/dcn321/dcn321_fpu.c    | 238 ++++++++++++++++++
 .../amd/display/dc/dml/dcn321/dcn321_fpu.h    |  36 +++
 5 files changed, 296 insertions(+), 208 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index d218c6dd71aa..6619bcb30de7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -37,6 +37,8 @@
 #include "dcn20/dcn20_resource.h"
 #include "dcn30/dcn30_resource.h"
 
+#include "dml/dcn321/dcn321_fpu.h"
+
 #include "dcn10/dcn10_ipp.h"
 #include "dcn30/dcn30_hubbub.h"
 #include "dcn31/dcn31_hubbub.h"
@@ -120,134 +122,6 @@ static const struct IP_BASE DCN_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C
 #define fixed16_to_double(x) (((double)x) / ((double) (1 << 16)))
 #define fixed16_to_double_to_cpu(x) fixed16_to_double(le32_to_cpu(x))
 
-#define DCN3_2_DEFAULT_DET_SIZE 256
-
-struct _vcs_dpi_ip_params_st dcn3_21_ip = {
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
-struct _vcs_dpi_soc_bounding_box_st dcn3_21_soc = {
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
 enum dcn321_clk_src_array_id {
 	DCN321_CLK_SRC_PLL0,
 	DCN321_CLK_SRC_PLL1,
@@ -1719,76 +1593,6 @@ static void dcn321_get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
 		(dcn3_21_soc.return_bus_width_bytes * (dcn3_21_soc.max_avg_sdp_bw_use_normal_percent / 100));
 }
 
-static void get_optimal_ntuple(struct _vcs_dpi_voltage_scaling_st *entry)
-{
-	if (entry->dcfclk_mhz > 0) {
-		float bw_on_sdp = entry->dcfclk_mhz * dcn3_21_soc.return_bus_width_bytes * ((float)dcn3_21_soc.pct_ideal_sdp_bw_after_urgent / 100);
-
-		entry->fabricclk_mhz = bw_on_sdp / (dcn3_21_soc.return_bus_width_bytes * ((float)dcn3_21_soc.pct_ideal_fabric_bw_after_urgent / 100));
-		entry->dram_speed_mts = bw_on_sdp / (dcn3_21_soc.num_chans *
-				dcn3_21_soc.dram_channel_width_bytes * ((float)dcn3_21_soc.pct_ideal_dram_sdp_bw_after_urgent_pixel_only / 100));
-	} else if (entry->fabricclk_mhz > 0) {
-		float bw_on_fabric = entry->fabricclk_mhz * dcn3_21_soc.return_bus_width_bytes * ((float)dcn3_21_soc.pct_ideal_fabric_bw_after_urgent / 100);
-
-		entry->dcfclk_mhz = bw_on_fabric / (dcn3_21_soc.return_bus_width_bytes * ((float)dcn3_21_soc.pct_ideal_sdp_bw_after_urgent / 100));
-		entry->dram_speed_mts = bw_on_fabric / (dcn3_21_soc.num_chans *
-				dcn3_21_soc.dram_channel_width_bytes * ((float)dcn3_21_soc.pct_ideal_dram_sdp_bw_after_urgent_pixel_only / 100));
-	} else if (entry->dram_speed_mts > 0) {
-		float bw_on_dram = entry->dram_speed_mts * dcn3_21_soc.num_chans *
-				dcn3_21_soc.dram_channel_width_bytes * ((float)dcn3_21_soc.pct_ideal_dram_sdp_bw_after_urgent_pixel_only / 100);
-
-		entry->fabricclk_mhz = bw_on_dram / (dcn3_21_soc.return_bus_width_bytes * ((float)dcn3_21_soc.pct_ideal_fabric_bw_after_urgent / 100));
-		entry->dcfclk_mhz = bw_on_dram / (dcn3_21_soc.return_bus_width_bytes * ((float)dcn3_21_soc.pct_ideal_sdp_bw_after_urgent / 100));
-	}
-}
-
-static float calculate_net_bw_in_kbytes_sec(struct _vcs_dpi_voltage_scaling_st *entry)
-{
-	float memory_bw_kbytes_sec = entry->dram_speed_mts * dcn3_21_soc.num_chans *
-			dcn3_21_soc.dram_channel_width_bytes * ((float)dcn3_21_soc.pct_ideal_dram_sdp_bw_after_urgent_pixel_only / 100);
-
-	float fabric_bw_kbytes_sec = entry->fabricclk_mhz * dcn3_21_soc.return_bus_width_bytes * ((float)dcn3_21_soc.pct_ideal_fabric_bw_after_urgent / 100);
-
-	float sdp_bw_kbytes_sec = entry->dcfclk_mhz * dcn3_21_soc.return_bus_width_bytes * ((float)dcn3_21_soc.pct_ideal_sdp_bw_after_urgent / 100);
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
@@ -1872,8 +1676,9 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 		entry.fabricclk_mhz = 0;
 		entry.dram_speed_mts = 0;
 
-		get_optimal_ntuple(&entry);
-		insert_entry_into_table_sorted(table, num_entries, &entry);
+		DC_FP_START();
+		dcn321_insert_entry_into_table_sorted(table, num_entries, &entry);
+		DC_FP_END();
 	}
 
 	// Insert the max DCFCLK
@@ -1881,8 +1686,9 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 	entry.fabricclk_mhz = 0;
 	entry.dram_speed_mts = 0;
 
-	get_optimal_ntuple(&entry);
-	insert_entry_into_table_sorted(table, num_entries, &entry);
+	DC_FP_START();
+	dcn321_insert_entry_into_table_sorted(table, num_entries, &entry);
+	DC_FP_END();
 
 	// Insert the UCLK DPMS
 	for (i = 0; i < num_uclk_dpms; i++) {
@@ -1890,8 +1696,9 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 		entry.fabricclk_mhz = 0;
 		entry.dram_speed_mts = bw_params->clk_table.entries[i].memclk_mhz * 16;
 
-		get_optimal_ntuple(&entry);
-		insert_entry_into_table_sorted(table, num_entries, &entry);
+		DC_FP_START();
+		dcn321_insert_entry_into_table_sorted(table, num_entries, &entry);
+		DC_FP_END();
 	}
 
 	// If FCLK is coarse grained, insert individual DPMs.
@@ -1901,8 +1708,9 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 			entry.fabricclk_mhz = bw_params->clk_table.entries[i].fclk_mhz;
 			entry.dram_speed_mts = 0;
 
-			get_optimal_ntuple(&entry);
-			insert_entry_into_table_sorted(table, num_entries, &entry);
+			DC_FP_START();
+			dcn321_insert_entry_into_table_sorted(table, num_entries, &entry);
+			DC_FP_END();
 		}
 	}
 	// If FCLK fine grained, only insert max
@@ -1911,8 +1719,9 @@ static int build_synthetic_soc_states(struct clk_bw_params *bw_params,
 		entry.fabricclk_mhz = max_fclk_mhz;
 		entry.dram_speed_mts = 0;
 
-		get_optimal_ntuple(&entry);
-		insert_entry_into_table_sorted(table, num_entries, &entry);
+		DC_FP_START();
+		dcn321_insert_entry_into_table_sorted(table, num_entries, &entry);
+		DC_FP_END();
 	}
 
 	// At this point, the table contains all "points of interest" based on
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.h b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.h
index 2732085a0e88..82cbf009f2d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.h
@@ -31,6 +31,9 @@
 #define TO_DCN321_RES_POOL(pool)\
 	container_of(pool, struct dcn321_resource_pool, base)
 
+extern struct _vcs_dpi_ip_params_st dcn3_21_ip;
+extern struct _vcs_dpi_soc_bounding_box_st dcn3_21_soc;
+
 struct dcn321_resource_pool {
 	struct resource_pool base;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 01cb0ef3a2b0..359f6e9a1da0 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -76,6 +76,7 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn32/dcn32_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn32/display_mode_vba_32.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn32/display_rq_dlg_calc_32.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn32/display_mode_vba_util_32.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn321/dcn321_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/dcn31_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn302/dcn302_fpu.o := $(dml_ccflags)
@@ -126,6 +127,7 @@ DML += dcn31/display_mode_vba_31.o dcn31/display_rq_dlg_calc_31.o
 DML += dcn32/display_mode_vba_32.o dcn32/display_rq_dlg_calc_32.o dcn32/display_mode_vba_util_32.o
 DML += dcn31/dcn31_fpu.o
 DML += dcn32/dcn32_fpu.o
+DML += dcn321/dcn321_fpu.o
 DML += dcn301/dcn301_fpu.o
 DML += dcn302/dcn302_fpu.o
 DML += dcn303/dcn303_fpu.o
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
new file mode 100644
index 000000000000..78408698985b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.c
@@ -0,0 +1,238 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#include "resource.h"
+#include "dcn321_fpu.h"
+#include "dcn32/dcn32_resource.h"
+#include "dcn321/dcn321_resource.h"
+
+#define DCN3_2_DEFAULT_DET_SIZE 256
+
+struct _vcs_dpi_ip_params_st dcn3_21_ip = {
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
+struct _vcs_dpi_soc_bounding_box_st dcn3_21_soc = {
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
+			.dram_speed_mts = 1600.0,
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
+static void get_optimal_ntuple(struct _vcs_dpi_voltage_scaling_st *entry)
+{
+	if (entry->dcfclk_mhz > 0) {
+		float bw_on_sdp = entry->dcfclk_mhz * dcn3_21_soc.return_bus_width_bytes * ((float)dcn3_21_soc.pct_ideal_sdp_bw_after_urgent / 100);
+
+		entry->fabricclk_mhz = bw_on_sdp / (dcn3_21_soc.return_bus_width_bytes * ((float)dcn3_21_soc.pct_ideal_fabric_bw_after_urgent / 100));
+		entry->dram_speed_mts = bw_on_sdp / (dcn3_21_soc.num_chans *
+				dcn3_21_soc.dram_channel_width_bytes * ((float)dcn3_21_soc.pct_ideal_dram_sdp_bw_after_urgent_pixel_only / 100));
+	} else if (entry->fabricclk_mhz > 0) {
+		float bw_on_fabric = entry->fabricclk_mhz * dcn3_21_soc.return_bus_width_bytes * ((float)dcn3_21_soc.pct_ideal_fabric_bw_after_urgent / 100);
+
+		entry->dcfclk_mhz = bw_on_fabric / (dcn3_21_soc.return_bus_width_bytes * ((float)dcn3_21_soc.pct_ideal_sdp_bw_after_urgent / 100));
+		entry->dram_speed_mts = bw_on_fabric / (dcn3_21_soc.num_chans *
+				dcn3_21_soc.dram_channel_width_bytes * ((float)dcn3_21_soc.pct_ideal_dram_sdp_bw_after_urgent_pixel_only / 100));
+	} else if (entry->dram_speed_mts > 0) {
+		float bw_on_dram = entry->dram_speed_mts * dcn3_21_soc.num_chans *
+				dcn3_21_soc.dram_channel_width_bytes * ((float)dcn3_21_soc.pct_ideal_dram_sdp_bw_after_urgent_pixel_only / 100);
+
+		entry->fabricclk_mhz = bw_on_dram / (dcn3_21_soc.return_bus_width_bytes * ((float)dcn3_21_soc.pct_ideal_fabric_bw_after_urgent / 100));
+		entry->dcfclk_mhz = bw_on_dram / (dcn3_21_soc.return_bus_width_bytes * ((float)dcn3_21_soc.pct_ideal_sdp_bw_after_urgent / 100));
+	}
+}
+
+static float calculate_net_bw_in_kbytes_sec(struct _vcs_dpi_voltage_scaling_st *entry)
+{
+	float memory_bw_kbytes_sec;
+	float fabric_bw_kbytes_sec;
+	float sdp_bw_kbytes_sec;
+	float limiting_bw_kbytes_sec;
+
+	memory_bw_kbytes_sec = entry->dram_speed_mts * dcn3_21_soc.num_chans *
+			dcn3_21_soc.dram_channel_width_bytes * ((float)dcn3_21_soc.pct_ideal_dram_sdp_bw_after_urgent_pixel_only / 100);
+
+	fabric_bw_kbytes_sec = entry->fabricclk_mhz * dcn3_21_soc.return_bus_width_bytes * ((float)dcn3_21_soc.pct_ideal_fabric_bw_after_urgent / 100);
+
+	sdp_bw_kbytes_sec = entry->dcfclk_mhz * dcn3_21_soc.return_bus_width_bytes * ((float)dcn3_21_soc.pct_ideal_sdp_bw_after_urgent / 100);
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
+void dcn321_insert_entry_into_table_sorted(struct _vcs_dpi_voltage_scaling_st *table,
+					   unsigned int *num_entries,
+					   struct _vcs_dpi_voltage_scaling_st *entry)
+{
+	int i = 0;
+	int index = 0;
+	float net_bw_of_new_state = 0;
+
+	dc_assert_fp_enabled();
+
+	get_optimal_ntuple(entry);
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
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.h
new file mode 100644
index 000000000000..5b6b28526e18
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn321/dcn321_fpu.h
@@ -0,0 +1,36 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2022 Advanced Micro Devices, Inc.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sublicense,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
+ * THE COPYRIGHT HOLDER(S) OR AUTHOR(S) BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ * OTHER DEALINGS IN THE SOFTWARE.
+ *
+ * Authors: AMD
+ *
+ */
+
+#ifndef __DCN32_FPU_H__
+#define __DCN32_FPU_H__
+
+#include "dml/display_mode_vba.h"
+
+void dcn321_insert_entry_into_table_sorted(struct _vcs_dpi_voltage_scaling_st *table,
+					   unsigned int *num_entries,
+					   struct _vcs_dpi_voltage_scaling_st *entry);
+
+#endif
-- 
2.37.0


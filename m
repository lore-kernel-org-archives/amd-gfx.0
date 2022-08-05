Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15CA2C00140
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 17:59:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 729BB10E83F;
	Fri,  5 Aug 2022 17:59:10 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam07on2051.outbound.protection.outlook.com [40.107.212.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C297E18B0B7
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 17:58:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n//Aql4PZNcQkD2yZkMy9JqR5Qjt0hij8UWsBsaEWPcOpWejjvEhP48S77G9Orrgv1Y+k2dQD4xHD7FHrlqz+DDZxzG7koni4TDvJtIlAO1200TKucT0VfKDv9xzI3tuzLwAiwy9kED2R9GhBXIbsCmnVkB8VWN5bCti/jCsoXGZSPxohDvdcjqtYjaKq4stVq+r0y5y2dX1rTBdg2++CWpdnh2LO2N6RS4TCKsS0AZckaHTAa5HhEAfpTWZp5KZsjsJLOL10macV4PkoHt4Q5qyXI+WQu4uq+eDFnEUZANt7KO1X1KkHyTN6srw4y7Rpw+oIEq6yJOEuJqiYh+wKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5+OSmvCIYjLeJRDK9Yvg8WyenOg0YiSpRdZNHkdpVYA=;
 b=DXPA+1km8+5YEW1QwdFvC3UhjX+G3n3u3JpImJSrxn3djlUUE8BLWK/lhjKRykC9LpucgxClewnK+HPNPSR6Mo1ZMX+t647nlYR8vLRQI/f60U6fqNP7qbBxbjXAZ+8AbJR28JK2wytwUDiniDnGYYpuQQ69W6jp43coSsf3DA4WrYKstS6xOurhEZw9apdMp4N11xzhHSuIgCP7wqnBwrNUHw1AjLtj0c1UmRX+mu8LXIglEnbUSEfrHwpmRJzn/5CwC1Is8/r4AbDzu9gFF77QSqjfFJKmriTOtsHhJiR3lUY9s2J5Hp2UZiugQ+DVJ3hoa/WhnhkBPhOjAnZgAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5+OSmvCIYjLeJRDK9Yvg8WyenOg0YiSpRdZNHkdpVYA=;
 b=qmyYMfNXTzB5vnEMruP4hhTkO9WxDlOWJHDLNn9xrbMsgAsItqJ+GPZ5vOoR1ZNty7hvL34ZBb6itHWe08mvGxMG/wCUCcueWpC7NA8NICrH0tuuos1/dko/QpjhAMmGfJkLw1UA+J0RzO476wWxRC7yUrTxUhEZuG2yp+XcTuw=
Received: from MW4PR03CA0132.namprd03.prod.outlook.com (2603:10b6:303:8c::17)
 by BY5PR12MB4818.namprd12.prod.outlook.com (2603:10b6:a03:1b4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14; Fri, 5 Aug
 2022 17:58:51 +0000
Received: from CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::f4) by MW4PR03CA0132.outlook.office365.com
 (2603:10b6:303:8c::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.14 via Frontend
 Transport; Fri, 5 Aug 2022 17:58:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT063.mail.protection.outlook.com (10.13.175.37) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 17:58:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 12:58:49 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 12:58:43 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 02/32] drm/amd/display: Create FPU files for DCN314
Date: Sat, 6 Aug 2022 01:57:56 +0800
Message-ID: <20220805175826.2992171-3-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 56cd3833-6b3d-4d1d-986f-08da770c2731
X-MS-TrafficTypeDiagnostic: BY5PR12MB4818:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LR0IE+kXB2G52jQHOz8ZWAt3kJpekV4UKdXSjqI6GL60Uw7KrcR7Lbw2sGcSNeSOjXrgMD9DYyu37IDa4VycbrI+kDmrcAdaX4Kj5Vt21tN2jFZDI6AWyfEn798K2brm9ugrl+qCoTjt+IGHlqxY6KlbGEWyUMKRefQp68/UV0UVCqgILejx7EuM2OKBf/O/QNY3jk4AbxjshelDm7FOcqXn3xWgugmYwNf7Mdbi2jVXldgH+v3vhRbdmE75n+ES2nCIYy0/TRZcieZ9UBd+BYJiM0hY+EArVFur4r2xLDPfnZMA5qi6SvZSoQFIYVqVvccsRUJHkptP09OWJpYwJyERajCk4SClX/Wqsv7En4PrPudjcEXuo10BD5In/jceRXVrp9f6nEIQwWjxiXOR79ZOXY0Tu3mAP36LPZEMzJOQ32nXej5iDo0WZ5jfIeDeHQnQ3sKSJEhLDHPD+fvYJou/Vkn6EBBG4SnRjCG8T5RV1csdLKlWqk7ZRGe+2Vm9AmqbW0EstqXaHSxhY/t8Ie0UM9ZP3K+5WN+HubCursr+DCPBLgMgPigfxnribbM2Dyx8klc6i5y2gh4hB7msxUgI6FkXbG94kHfiIojZPU346MM17wx/vA1YQzWajN6bHDIjLsv4gb5mS5f51Y3f4ZCMkVV06qgyZTTxbozk2hlqjGadfllvguIeNdOF5WKS97iCYzRS5bJXhOS1+dz1du9JnEPN1er84wCq8lt9vx6D9StJDef8gRNS+ev+SWRaxAKAn31WK2HKDBRKPbbdP7zVnf/+4iuAg9ntk38K09uNidxBp/kcJVgpFCobZoBKah9mQh/v3UIHlyUkEPBA1w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(396003)(39860400002)(376002)(40470700004)(36840700001)(46966006)(7696005)(2906002)(40460700003)(36860700001)(8676002)(70206006)(70586007)(82740400003)(4326008)(41300700001)(86362001)(8936002)(81166007)(40480700001)(478600001)(30864003)(356005)(5660300002)(36756003)(82310400005)(54906003)(6666004)(316002)(2616005)(186003)(47076005)(26005)(426003)(6916009)(336012)(1076003)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 17:58:50.5345 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 56cd3833-6b3d-4d1d-986f-08da770c2731
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT063.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4818
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

DCN314 has multiple references to FPU operations inside the resource
files, and we need to move those codes to the DML folder. This commit
creates the dcn314_fpu files and moves the bounding box operation to
this file.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/dcn314/dcn314_resource.c   | 235 +---------------
 .../amd/display/dc/dcn314/dcn314_resource.h   |   3 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   2 +
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    | 266 ++++++++++++++++++
 .../amd/display/dc/dml/dcn314/dcn314_fpu.h    |  37 +++
 5 files changed, 312 insertions(+), 231 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 63861cdfb09f..376488198363 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -70,6 +70,7 @@
 #include "dce110/dce110_resource.h"
 #include "dml/display_mode_vba.h"
 #include "dml/dcn31/dcn31_fpu.h"
+#include "dml/dcn314/dcn314_fpu.h"
 #include "dcn314/dcn314_dccg.h"
 #include "dcn10/dcn10_resource.h"
 #include "dcn31/dcn31_panel_cntl.h"
@@ -132,155 +133,6 @@ static const struct IP_BASE DCN_BASE = { { { { 0x00000012, 0x000000C0, 0x000034C
 
 #define DC_LOGGER_INIT(logger)
 
-#define DCN3_14_DEFAULT_DET_SIZE 384
-#define DCN3_14_MAX_DET_SIZE 384
-#define DCN3_14_MIN_COMPBUF_SIZE_KB 128
-#define DCN3_14_CRB_SEGMENT_SIZE_KB 64
-struct _vcs_dpi_ip_params_st dcn3_14_ip = {
-	.VBlankNomDefaultUS = 668,
-	.gpuvm_enable = 1,
-	.gpuvm_max_page_table_levels = 1,
-	.hostvm_enable = 1,
-	.hostvm_max_page_table_levels = 2,
-	.rob_buffer_size_kbytes = 64,
-	.det_buffer_size_kbytes = DCN3_14_DEFAULT_DET_SIZE,
-	.config_return_buffer_size_in_kbytes = 1792,
-	.compressed_buffer_segment_size_in_kbytes = 64,
-	.meta_fifo_size_in_kentries = 32,
-	.zero_size_buffer_entries = 512,
-	.compbuf_reserved_space_64b = 256,
-	.compbuf_reserved_space_zs = 64,
-	.dpp_output_buffer_pixels = 2560,
-	.opp_output_buffer_lines = 1,
-	.pixel_chunk_size_kbytes = 8,
-	.meta_chunk_size_kbytes = 2,
-	.min_meta_chunk_size_bytes = 256,
-	.writeback_chunk_size_kbytes = 8,
-	.ptoi_supported = false,
-	.num_dsc = 4,
-	.maximum_dsc_bits_per_component = 10,
-	.dsc422_native_support = false,
-	.is_line_buffer_bpp_fixed = true,
-	.line_buffer_fixed_bpp = 48,
-	.line_buffer_size_bits = 789504,
-	.max_line_buffer_lines = 12,
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
-	.dppclk_delay_subtotal = 46,
-	.dppclk_delay_scl = 50,
-	.dppclk_delay_scl_lb_only = 16,
-	.dppclk_delay_cnvc_formatter = 27,
-	.dppclk_delay_cnvc_cursor = 6,
-	.dispclk_delay_subtotal = 119,
-	.dynamic_metadata_vm_enabled = false,
-	.odm_combine_4to1_supported = false,
-	.dcc_supported = true,
-};
-
-struct _vcs_dpi_soc_bounding_box_st dcn3_14_soc = {
-		/*TODO: correct dispclk/dppclk voltage level determination*/
-	.clock_limits = {
-		{
-			.state = 0,
-			.dispclk_mhz = 1200.0,
-			.dppclk_mhz = 1200.0,
-			.phyclk_mhz = 600.0,
-			.phyclk_d18_mhz = 667.0,
-			.dscclk_mhz = 186.0,
-			.dtbclk_mhz = 625.0,
-		},
-		{
-			.state = 1,
-			.dispclk_mhz = 1200.0,
-			.dppclk_mhz = 1200.0,
-			.phyclk_mhz = 810.0,
-			.phyclk_d18_mhz = 667.0,
-			.dscclk_mhz = 209.0,
-			.dtbclk_mhz = 625.0,
-		},
-		{
-			.state = 2,
-			.dispclk_mhz = 1200.0,
-			.dppclk_mhz = 1200.0,
-			.phyclk_mhz = 810.0,
-			.phyclk_d18_mhz = 667.0,
-			.dscclk_mhz = 209.0,
-			.dtbclk_mhz = 625.0,
-		},
-		{
-			.state = 3,
-			.dispclk_mhz = 1200.0,
-			.dppclk_mhz = 1200.0,
-			.phyclk_mhz = 810.0,
-			.phyclk_d18_mhz = 667.0,
-			.dscclk_mhz = 371.0,
-			.dtbclk_mhz = 625.0,
-		},
-		{
-			.state = 4,
-			.dispclk_mhz = 1200.0,
-			.dppclk_mhz = 1200.0,
-			.phyclk_mhz = 810.0,
-			.phyclk_d18_mhz = 667.0,
-			.dscclk_mhz = 417.0,
-			.dtbclk_mhz = 625.0,
-		},
-	},
-	.num_states = 5,
-	.sr_exit_time_us = 9.0,
-	.sr_enter_plus_exit_time_us = 11.0,
-	.sr_exit_z8_time_us = 442.0,
-	.sr_enter_plus_exit_z8_time_us = 560.0,
-	.writeback_latency_us = 12.0,
-	.dram_channel_width_bytes = 4,
-	.round_trip_ping_latency_dcfclk_cycles = 106,
-	.urgent_latency_pixel_data_only_us = 4.0,
-	.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
-	.urgent_latency_vm_data_only_us = 4.0,
-	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
-	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
-	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
-	.pct_ideal_sdp_bw_after_urgent = 80.0,
-	.pct_ideal_dram_sdp_bw_after_urgent_pixel_only = 65.0,
-	.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm = 60.0,
-	.pct_ideal_dram_sdp_bw_after_urgent_vm_only = 30.0,
-	.max_avg_sdp_bw_use_normal_percent = 60.0,
-	.max_avg_dram_bw_use_normal_percent = 60.0,
-	.fabric_datapath_to_dcn_data_return_bytes = 32,
-	.return_bus_width_bytes = 64,
-	.downspread_percent = 0.38,
-	.dcn_downspread_percent = 0.5,
-	.gpuvm_min_page_size_bytes = 4096,
-	.hostvm_min_page_size_bytes = 4096,
-	.do_urgent_latency_adjustment = false,
-	.urgent_latency_adjustment_fabric_clock_component_us = 0,
-	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
-};
-
 enum dcn31_clk_src_array_id {
 	DCN31_CLK_SRC_PLL0,
 	DCN31_CLK_SRC_PLL1,
@@ -1906,88 +1758,9 @@ static struct dc_cap_funcs cap_funcs = {
 
 static void dcn314_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
-	struct clk_limit_table *clk_table = &bw_params->clk_table;
-	struct _vcs_dpi_voltage_scaling_st *clock_tmp = dcn3_14_soc._clock_tmp;
-	unsigned int i, closest_clk_lvl;
-	int max_dispclk_mhz = 0, max_dppclk_mhz = 0;
-	int j;
-
-	// Default clock levels are used for diags, which may lead to overclocking.
-	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
-
-		dcn3_14_ip.max_num_otg = dc->res_pool->res_cap->num_timing_generator;
-		dcn3_14_ip.max_num_dpp = dc->res_pool->pipe_count;
-
-		if (bw_params->num_channels > 0)
-			dcn3_14_soc.num_chans = bw_params->num_channels;
-
-		ASSERT(dcn3_14_soc.num_chans);
-		ASSERT(clk_table->num_entries);
-
-		/* Prepass to find max clocks independent of voltage level. */
-		for (i = 0; i < clk_table->num_entries; ++i) {
-			if (clk_table->entries[i].dispclk_mhz > max_dispclk_mhz)
-				max_dispclk_mhz = clk_table->entries[i].dispclk_mhz;
-			if (clk_table->entries[i].dppclk_mhz > max_dppclk_mhz)
-				max_dppclk_mhz = clk_table->entries[i].dppclk_mhz;
-		}
-
-		for (i = 0; i < clk_table->num_entries; i++) {
-			/* loop backwards*/
-			for (closest_clk_lvl = 0, j = dcn3_14_soc.num_states - 1; j >= 0; j--) {
-				if ((unsigned int) dcn3_14_soc.clock_limits[j].dcfclk_mhz <= clk_table->entries[i].dcfclk_mhz) {
-					closest_clk_lvl = j;
-					break;
-				}
-			}
-			if (clk_table->num_entries == 1) {
-				/*smu gives one DPM level, let's take the highest one*/
-				closest_clk_lvl = dcn3_14_soc.num_states - 1;
-			}
-
-			clock_tmp[i].state = i;
-
-			/* Clocks dependent on voltage level. */
-			clock_tmp[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
-			if (clk_table->num_entries == 1 &&
-				clock_tmp[i].dcfclk_mhz < dcn3_14_soc.clock_limits[closest_clk_lvl].dcfclk_mhz) {
-				/*SMU fix not released yet*/
-				clock_tmp[i].dcfclk_mhz = dcn3_14_soc.clock_limits[closest_clk_lvl].dcfclk_mhz;
-			}
-			clock_tmp[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
-			clock_tmp[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
-
-			if (clk_table->entries[i].memclk_mhz && clk_table->entries[i].wck_ratio)
-				clock_tmp[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
-
-			/* Clocks independent of voltage level. */
-			clock_tmp[i].dispclk_mhz = max_dispclk_mhz ? max_dispclk_mhz :
-				dcn3_14_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
-
-			clock_tmp[i].dppclk_mhz = max_dppclk_mhz ? max_dppclk_mhz :
-				dcn3_14_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
-
-			clock_tmp[i].dram_bw_per_chan_gbps = dcn3_14_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
-			clock_tmp[i].dscclk_mhz = dcn3_14_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
-			clock_tmp[i].dtbclk_mhz = dcn3_14_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
-			clock_tmp[i].phyclk_d18_mhz = dcn3_14_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
-			clock_tmp[i].phyclk_mhz = dcn3_14_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
-		}
-		for (i = 0; i < clk_table->num_entries; i++)
-			dcn3_14_soc.clock_limits[i] = clock_tmp[i];
-		if (clk_table->num_entries)
-			dcn3_14_soc.num_states = clk_table->num_entries;
-	}
-
-	if (max_dispclk_mhz) {
-		dcn3_14_soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
-		dc->dml.soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
-	}
-
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
-		dml_init_instance(&dc->dml, &dcn3_14_soc, &dcn3_14_ip, DML_PROJECT_DCN31);
-	else
-		dml_init_instance(&dc->dml, &dcn3_14_soc, &dcn3_14_ip, DML_PROJECT_DCN31_FPGA);
+	DC_FP_START();
+	dcn314_update_bw_bounding_box_fpu(dc, bw_params);
+	DC_FP_END();
 }
 
 static struct resource_funcs dcn314_res_pool_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.h b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.h
index c41108847ce0..0dd3153aa5c1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.h
@@ -29,6 +29,9 @@
 
 #include "core_types.h"
 
+extern struct _vcs_dpi_ip_params_st dcn3_14_ip;
+extern struct _vcs_dpi_soc_bounding_box_st dcn3_14_soc;
+
 #define TO_DCN314_RES_POOL(pool)\
 	container_of(pool, struct dcn314_resource_pool, base)
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 359f6e9a1da0..3b813f011569 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -71,6 +71,7 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_ccflags) $(fram
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn314/dcn314_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/dcn30_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn32/dcn32_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn32/display_mode_vba_32.o := $(dml_ccflags) $(frame_warn_flag)
@@ -131,6 +132,7 @@ DML += dcn321/dcn321_fpu.o
 DML += dcn301/dcn301_fpu.o
 DML += dcn302/dcn302_fpu.o
 DML += dcn303/dcn303_fpu.o
+DML += dcn314/dcn314_fpu.o
 DML += dsc/rc_calc_fpu.o
 DML += calcs/dcn_calcs.o calcs/dcn_calc_math.o calcs/dcn_calc_auto.o
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
new file mode 100644
index 000000000000..340c3ca22345
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -0,0 +1,266 @@
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
+#include "clk_mgr.h"
+#include "resource.h"
+#include "dcn314_fpu.h"
+#include "dml/display_mode_vba.h"
+
+struct _vcs_dpi_ip_params_st dcn3_14_ip = {
+	.VBlankNomDefaultUS = 668,
+	.gpuvm_enable = 1,
+	.gpuvm_max_page_table_levels = 1,
+	.hostvm_enable = 1,
+	.hostvm_max_page_table_levels = 2,
+	.rob_buffer_size_kbytes = 64,
+	.det_buffer_size_kbytes = DCN3_14_DEFAULT_DET_SIZE,
+	.config_return_buffer_size_in_kbytes = 1792,
+	.compressed_buffer_segment_size_in_kbytes = 64,
+	.meta_fifo_size_in_kentries = 32,
+	.zero_size_buffer_entries = 512,
+	.compbuf_reserved_space_64b = 256,
+	.compbuf_reserved_space_zs = 64,
+	.dpp_output_buffer_pixels = 2560,
+	.opp_output_buffer_lines = 1,
+	.pixel_chunk_size_kbytes = 8,
+	.meta_chunk_size_kbytes = 2,
+	.min_meta_chunk_size_bytes = 256,
+	.writeback_chunk_size_kbytes = 8,
+	.ptoi_supported = false,
+	.num_dsc = 4,
+	.maximum_dsc_bits_per_component = 10,
+	.dsc422_native_support = false,
+	.is_line_buffer_bpp_fixed = true,
+	.line_buffer_fixed_bpp = 48,
+	.line_buffer_size_bits = 789504,
+	.max_line_buffer_lines = 12,
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
+	.dppclk_delay_subtotal = 46,
+	.dppclk_delay_scl = 50,
+	.dppclk_delay_scl_lb_only = 16,
+	.dppclk_delay_cnvc_formatter = 27,
+	.dppclk_delay_cnvc_cursor = 6,
+	.dispclk_delay_subtotal = 119,
+	.dynamic_metadata_vm_enabled = false,
+	.odm_combine_4to1_supported = false,
+	.dcc_supported = true,
+};
+
+struct _vcs_dpi_soc_bounding_box_st dcn3_14_soc = {
+		/*TODO: correct dispclk/dppclk voltage level determination*/
+	.clock_limits = {
+		{
+			.state = 0,
+			.dispclk_mhz = 1200.0,
+			.dppclk_mhz = 1200.0,
+			.phyclk_mhz = 600.0,
+			.phyclk_d18_mhz = 667.0,
+			.dscclk_mhz = 186.0,
+			.dtbclk_mhz = 625.0,
+		},
+		{
+			.state = 1,
+			.dispclk_mhz = 1200.0,
+			.dppclk_mhz = 1200.0,
+			.phyclk_mhz = 810.0,
+			.phyclk_d18_mhz = 667.0,
+			.dscclk_mhz = 209.0,
+			.dtbclk_mhz = 625.0,
+		},
+		{
+			.state = 2,
+			.dispclk_mhz = 1200.0,
+			.dppclk_mhz = 1200.0,
+			.phyclk_mhz = 810.0,
+			.phyclk_d18_mhz = 667.0,
+			.dscclk_mhz = 209.0,
+			.dtbclk_mhz = 625.0,
+		},
+		{
+			.state = 3,
+			.dispclk_mhz = 1200.0,
+			.dppclk_mhz = 1200.0,
+			.phyclk_mhz = 810.0,
+			.phyclk_d18_mhz = 667.0,
+			.dscclk_mhz = 371.0,
+			.dtbclk_mhz = 625.0,
+		},
+		{
+			.state = 4,
+			.dispclk_mhz = 1200.0,
+			.dppclk_mhz = 1200.0,
+			.phyclk_mhz = 810.0,
+			.phyclk_d18_mhz = 667.0,
+			.dscclk_mhz = 417.0,
+			.dtbclk_mhz = 625.0,
+		},
+	},
+	.num_states = 5,
+	.sr_exit_time_us = 9.0,
+	.sr_enter_plus_exit_time_us = 11.0,
+	.sr_exit_z8_time_us = 442.0,
+	.sr_enter_plus_exit_z8_time_us = 560.0,
+	.writeback_latency_us = 12.0,
+	.dram_channel_width_bytes = 4,
+	.round_trip_ping_latency_dcfclk_cycles = 106,
+	.urgent_latency_pixel_data_only_us = 4.0,
+	.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
+	.urgent_latency_vm_data_only_us = 4.0,
+	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
+	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
+	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
+	.pct_ideal_sdp_bw_after_urgent = 80.0,
+	.pct_ideal_dram_sdp_bw_after_urgent_pixel_only = 65.0,
+	.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm = 60.0,
+	.pct_ideal_dram_sdp_bw_after_urgent_vm_only = 30.0,
+	.max_avg_sdp_bw_use_normal_percent = 60.0,
+	.max_avg_dram_bw_use_normal_percent = 60.0,
+	.fabric_datapath_to_dcn_data_return_bytes = 32,
+	.return_bus_width_bytes = 64,
+	.downspread_percent = 0.38,
+	.dcn_downspread_percent = 0.5,
+	.gpuvm_min_page_size_bytes = 4096,
+	.hostvm_min_page_size_bytes = 4096,
+	.do_urgent_latency_adjustment = false,
+	.urgent_latency_adjustment_fabric_clock_component_us = 0,
+	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
+};
+
+
+void dcn314_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_params)
+{
+	struct clk_limit_table *clk_table = &bw_params->clk_table;
+	struct _vcs_dpi_voltage_scaling_st *clock_limits =
+		dcn3_14_soc.clock_limits;
+	unsigned int i, closest_clk_lvl;
+	int max_dispclk_mhz = 0, max_dppclk_mhz = 0;
+	int j;
+
+	dc_assert_fp_enabled();
+
+	// Default clock levels are used for diags, which may lead to overclocking.
+	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
+
+		dcn3_14_ip.max_num_otg = dc->res_pool->res_cap->num_timing_generator;
+		dcn3_14_ip.max_num_dpp = dc->res_pool->pipe_count;
+
+		if (bw_params->num_channels > 0)
+			dcn3_14_soc.num_chans = bw_params->num_channels;
+
+		ASSERT(dcn3_14_soc.num_chans);
+		ASSERT(clk_table->num_entries);
+
+		/* Prepass to find max clocks independent of voltage level. */
+		for (i = 0; i < clk_table->num_entries; ++i) {
+			if (clk_table->entries[i].dispclk_mhz > max_dispclk_mhz)
+				max_dispclk_mhz = clk_table->entries[i].dispclk_mhz;
+			if (clk_table->entries[i].dppclk_mhz > max_dppclk_mhz)
+				max_dppclk_mhz = clk_table->entries[i].dppclk_mhz;
+		}
+
+		for (i = 0; i < clk_table->num_entries; i++) {
+			/* loop backwards*/
+			for (closest_clk_lvl = 0, j = dcn3_14_soc.num_states - 1; j >= 0; j--) {
+				if ((unsigned int) dcn3_14_soc.clock_limits[j].dcfclk_mhz <= clk_table->entries[i].dcfclk_mhz) {
+					closest_clk_lvl = j;
+					break;
+				}
+			}
+			if (clk_table->num_entries == 1) {
+				/*smu gives one DPM level, let's take the highest one*/
+				closest_clk_lvl = dcn3_14_soc.num_states - 1;
+			}
+
+			clock_limits[i].state = i;
+
+			/* Clocks dependent on voltage level. */
+			clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
+			if (clk_table->num_entries == 1 &&
+				clock_limits[i].dcfclk_mhz < dcn3_14_soc.clock_limits[closest_clk_lvl].dcfclk_mhz) {
+				/*SMU fix not released yet*/
+				clock_limits[i].dcfclk_mhz = dcn3_14_soc.clock_limits[closest_clk_lvl].dcfclk_mhz;
+			}
+			clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
+			clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
+
+			if (clk_table->entries[i].memclk_mhz && clk_table->entries[i].wck_ratio)
+				clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
+
+			/* Clocks independent of voltage level. */
+			clock_limits[i].dispclk_mhz = max_dispclk_mhz ? max_dispclk_mhz :
+				dcn3_14_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
+
+			clock_limits[i].dppclk_mhz = max_dppclk_mhz ? max_dppclk_mhz :
+				dcn3_14_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
+
+			clock_limits[i].dram_bw_per_chan_gbps = dcn3_14_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
+			clock_limits[i].dscclk_mhz = dcn3_14_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
+			clock_limits[i].dtbclk_mhz = dcn3_14_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
+			clock_limits[i].phyclk_d18_mhz = dcn3_14_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
+			clock_limits[i].phyclk_mhz = dcn3_14_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
+		}
+		for (i = 0; i < clk_table->num_entries; i++)
+			dcn3_14_soc.clock_limits[i] = clock_limits[i];
+		if (clk_table->num_entries) {
+			dcn3_14_soc.num_states = clk_table->num_entries;
+		}
+	}
+
+	if (max_dispclk_mhz) {
+		dcn3_14_soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
+		dc->dml.soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
+	}
+
+	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
+		dml_init_instance(&dc->dml, &dcn3_14_soc, &dcn3_14_ip, DML_PROJECT_DCN31);
+	else
+		dml_init_instance(&dc->dml, &dcn3_14_soc, &dcn3_14_ip, DML_PROJECT_DCN31_FPGA);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.h
new file mode 100644
index 000000000000..79466d4f4185
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.h
@@ -0,0 +1,37 @@
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
+#ifndef __DCN314_FPU_H__
+#define __DCN314_FPU_H__
+
+#define DCN3_14_DEFAULT_DET_SIZE 384
+#define DCN3_14_MAX_DET_SIZE 384
+#define DCN3_14_MIN_COMPBUF_SIZE_KB 128
+#define DCN3_14_CRB_SEGMENT_SIZE_KB 64
+
+void dcn314_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_params);
+
+#endif
-- 
2.25.1


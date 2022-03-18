Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12CD9C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 21:51:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 955EE10E25E;
	Fri, 18 Mar 2022 21:51:17 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2061.outbound.protection.outlook.com [40.107.244.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B91110E297
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 21:51:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WG5KQ6iYw7bYB7jR/Q6RVppDEtSkz/XyFeZZLz3ekfQ8PLQw4aO8a7Mm3X+p7CP4TIIVePjfyxNglDpg9XpTyZahIsvz1RiXJn5xlG60UuSUrL9jCsN99Ii6dE+rfYJOKSTXRkOacR1/Hg4ZV5jO6ARea+Ho8H6KD1k3gSSIkpuncC1wEZcbSf93wVTAV6KZfM36O3rMiaGZJUtuOKLViYjN0dtt5+iKBmOgFvH2Mvu38SETdrfS/3geEuzJbPygG6mKXg2KJgghelOzh6yfsoqkYFT2RsYKB84ijIlalaSWBlpzjpk5VtX2lqjJ+0aZtddQIpTV/ee6iduv+qg79Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3c1J6Bc9UtBIfz79YiRbeZ7N3obSiPCBYIX4kYFE8I=;
 b=PUGg5nMFi2Y4cXPiA6KxvctOIuXFsNI+Ac10aCwMWaNOyYS6R60GblRhOFIAFMeu9se6+o2ETpNLVs+uvl5AxIRMKCqEFthO1D8NIhyPjPpkDhh53kYdkm+pecXZHnkdEt+mj7IDcfpJTN/7liIGgW3Dpb2Dcl7hlphrEhNuDKM7mBS+Udi+ZO24uWjFig0drJdvoGL9KUdhdqTmzak3njxYnEeI1JExCO14U1BHNgLObp6hej+BvOXSJks1c227v10rwTpIhMWr+95IFIRRAi0wE0hVM7a2+j6EVAtQLdlM/TkaD3hqcQp47+DVIn9EXfqtevfHI+HFLFE3SncHlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3c1J6Bc9UtBIfz79YiRbeZ7N3obSiPCBYIX4kYFE8I=;
 b=sM17fk+4tflQCA4oTFG6mY51tdusfcHBdXjB4DLXiI04YN7zchg0aOL81SRurcd8ibcVsyaZXS6fepSfac4Xsv2vo7Ty+b4XLaxRCRX750xd8Vk7BtEUQDnQC6b6JzBOImWJxsXZoDI2Q6L7bLrOVZQNB742OEo9x4PRdz7Go/k=
Received: from BN9PR03CA0935.namprd03.prod.outlook.com (2603:10b6:408:108::10)
 by CH2PR12MB3717.namprd12.prod.outlook.com (2603:10b6:610:24::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Fri, 18 Mar
 2022 21:51:11 +0000
Received: from BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:108:cafe::95) by BN9PR03CA0935.outlook.office365.com
 (2603:10b6:408:108::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18 via Frontend
 Transport; Fri, 18 Mar 2022 21:51:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT004.mail.protection.outlook.com (10.13.176.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Fri, 18 Mar 2022 21:51:10 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 18 Mar
 2022 16:51:08 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/13] drm/amd/display: move FPU related code from dcn316 to
 dml/dcn31 folder
Date: Fri, 18 Mar 2022 15:48:00 -0600
Message-ID: <20220318214800.3565679-14-alex.hung@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220318214800.3565679-1-alex.hung@amd.com>
References: <20220318214800.3565679-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8c61d025-6e86-421e-b675-08da09296a5c
X-MS-TrafficTypeDiagnostic: CH2PR12MB3717:EE_
X-Microsoft-Antispam-PRVS: <CH2PR12MB37179D4B6BB8FA8B44E7228AF7139@CH2PR12MB3717.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g/XJzlD3okNDjYDbEceXoSN0prTojLqFEODOAN5+mGvd0OxzBAXy2mULU9d+Ji1HCuWkWPAxmq1iBLTv6ogpt/bqq5MVrklCv502e2JziN75UoDCuT9Cepg0T542fRFfa1y/440MHL9tFiZjXgsbecsUWSoQPUYyb4mp1mk994oRZYg+NAtbEhLS/qos7iH/jmn74AwMfwn5wIESDwRkkP+1fBbX2bNOZxLa6PJi3in6sxdwTXcIbhKv2GWXInUOdPozWMvtYEe/ns+QuT/zlzIScPM46SRDKFP1EcjVIYNsX3D7VHnFzcubUWKQQbp3hcKrV4gHNdecsRQjF8W7dUaNrosP268ctxMOwwjmkIYV2nwU7OFwWTdIGNwCNFu5+g0xyiE+eDe267Tm1SaTbF2Y9WYO0M8vSC4XOCXAJ4vucd4qP8hnHd9s0lig+OotSAHOXbvIcYEATA8PHoSqsfZOKsjI+VnC4VlzaM3NcuO4vQj+V9aoW0tfb2BEjHKgVidvznZdvkQby5IH/2KkhpAfCJHfsYoGTYwrcD1Fg0UjdDq6ibd6+W4K4s4ViC3HZV7EBih0uBP2FA4fFuXfuzO34QF/aUWFds8gc+PQPO1dJPFIHBJ2xMzZ96JWMqqKbw2EhavQY940IXzOhqZ9G5UoaTv5jBUbwM1N+wbI7RCho7Q/usvu3vFTIW1TOVzwsU83mScV249HFJsH66pEXA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(40460700003)(4326008)(8936002)(5660300002)(30864003)(356005)(44832011)(36756003)(86362001)(2906002)(316002)(6916009)(54906003)(81166007)(8676002)(70206006)(70586007)(36860700001)(83380400001)(47076005)(336012)(16526019)(186003)(26005)(82310400004)(6666004)(7696005)(2616005)(426003)(508600001)(1076003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 21:51:10.8335 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c61d025-6e86-421e-b675-08da09296a5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB3717
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
 Melissa Wen <mwen@igalia.com>, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Melissa Wen <mwen@igalia.com>

Moves FPU-related structs and dcn316_update_bw_bounding_box from dcn316
driver to dml/dcn31 that centralize FPU operations for DCN 3.1x

Signed-off-by: Melissa Wen <mwen@igalia.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn316/Makefile    |  26 --
 .../amd/display/dc/dcn316/dcn316_resource.c   | 231 +-----------------
 .../amd/display/dc/dcn316/dcn316_resource.h   |   3 +
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  | 229 +++++++++++++++++
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.h  |   2 +
 5 files changed, 235 insertions(+), 256 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/Makefile b/drivers/gpu/drm/amd/display/dc/dcn316/Makefile
index cd87b687c5e2..819d44a9439b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/Makefile
@@ -25,32 +25,6 @@
 
 DCN316 = dcn316_resource.o
 
-ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn316/dcn316_resource.o := -msse
-endif
-
-ifdef CONFIG_PPC64
-CFLAGS_$(AMDDALPATH)/dc/dcn316/dcn316_resource.o := -mhard-float -maltivec
-endif
-
-ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
-IS_OLD_GCC = 1
-endif
-CFLAGS_$(AMDDALPATH)/dc/dcn316/dcn316_resource.o += -mhard-float
-endif
-
-ifdef CONFIG_X86
-ifdef IS_OLD_GCC
-# Stack alignment mismatch, proceed with caution.
-# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
-# (8B stack alignment).
-CFLAGS_$(AMDDALPATH)/dc/dcn316/dcn316_resource.o += -mpreferred-stack-boundary=4
-else
-CFLAGS_$(AMDDALPATH)/dc/dcn316/dcn316_resource.o += -msse2
-endif
-endif
-
 AMD_DAL_DCN316 = $(addprefix $(AMDDALPATH)/dc/dcn316/,$(DCN316))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DCN316)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
index 8decc3ccf8ca..d73145dab173 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.c
@@ -66,6 +66,7 @@
 #include "virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
 #include "dml/display_mode_vba.h"
+#include "dml/dcn31/dcn31_fpu.h"
 #include "dcn31/dcn31_dccg.h"
 #include "dcn10/dcn10_resource.h"
 #include "dcn31/dcn31_panel_cntl.h"
@@ -123,157 +124,10 @@
 
 #include "link_enc_cfg.h"
 
-#define DC_LOGGER_INIT(logger)
-
-#define DCN3_16_DEFAULT_DET_SIZE 192
 #define DCN3_16_MAX_DET_SIZE 384
 #define DCN3_16_MIN_COMPBUF_SIZE_KB 128
 #define DCN3_16_CRB_SEGMENT_SIZE_KB 64
 
-struct _vcs_dpi_ip_params_st dcn3_16_ip = {
-	.gpuvm_enable = 1,
-	.gpuvm_max_page_table_levels = 1,
-	.hostvm_enable = 1,
-	.hostvm_max_page_table_levels = 2,
-	.rob_buffer_size_kbytes = 64,
-	.det_buffer_size_kbytes = DCN3_16_DEFAULT_DET_SIZE,
-	.config_return_buffer_size_in_kbytes = 1024,
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
-	.num_dsc = 3,
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
-struct _vcs_dpi_soc_bounding_box_st dcn3_16_soc = {
-		/*TODO: correct dispclk/dppclk voltage level determination*/
-	.clock_limits = {
-		{
-			.state = 0,
-			.dispclk_mhz = 556.0,
-			.dppclk_mhz = 556.0,
-			.phyclk_mhz = 600.0,
-			.phyclk_d18_mhz = 445.0,
-			.dscclk_mhz = 186.0,
-			.dtbclk_mhz = 625.0,
-		},
-		{
-			.state = 1,
-			.dispclk_mhz = 625.0,
-			.dppclk_mhz = 625.0,
-			.phyclk_mhz = 810.0,
-			.phyclk_d18_mhz = 667.0,
-			.dscclk_mhz = 209.0,
-			.dtbclk_mhz = 625.0,
-		},
-		{
-			.state = 2,
-			.dispclk_mhz = 625.0,
-			.dppclk_mhz = 625.0,
-			.phyclk_mhz = 810.0,
-			.phyclk_d18_mhz = 667.0,
-			.dscclk_mhz = 209.0,
-			.dtbclk_mhz = 625.0,
-		},
-		{
-			.state = 3,
-			.dispclk_mhz = 1112.0,
-			.dppclk_mhz = 1112.0,
-			.phyclk_mhz = 810.0,
-			.phyclk_d18_mhz = 667.0,
-			.dscclk_mhz = 371.0,
-			.dtbclk_mhz = 625.0,
-		},
-		{
-			.state = 4,
-			.dispclk_mhz = 1250.0,
-			.dppclk_mhz = 1250.0,
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
@@ -1859,89 +1713,6 @@ static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
 };
 
-static void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
-{
-	struct clk_limit_table *clk_table = &bw_params->clk_table;
-	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
-	unsigned int i, closest_clk_lvl;
-	int max_dispclk_mhz = 0, max_dppclk_mhz = 0;
-	int j;
-
-	// Default clock levels are used for diags, which may lead to overclocking.
-	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
-
-		dcn3_16_ip.max_num_otg = dc->res_pool->res_cap->num_timing_generator;
-		dcn3_16_ip.max_num_dpp = dc->res_pool->pipe_count;
-		dcn3_16_soc.num_chans = bw_params->num_channels;
-
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
-			for (closest_clk_lvl = 0, j = dcn3_16_soc.num_states - 1; j >= 0; j--) {
-				if ((unsigned int) dcn3_16_soc.clock_limits[j].dcfclk_mhz <= clk_table->entries[i].dcfclk_mhz) {
-					closest_clk_lvl = j;
-					break;
-				}
-			}
-			// Ported from DCN315
-			if (clk_table->num_entries == 1) {
-				/*smu gives one DPM level, let's take the highest one*/
-				closest_clk_lvl = dcn3_16_soc.num_states - 1;
-			}
-
-			clock_limits[i].state = i;
-
-			/* Clocks dependent on voltage level. */
-			clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
-			if (clk_table->num_entries == 1 &&
-				clock_limits[i].dcfclk_mhz < dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz) {
-				/*SMU fix not released yet*/
-				clock_limits[i].dcfclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz;
-			}
-			clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
-			clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
-			clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
-
-			/* Clocks independent of voltage level. */
-			clock_limits[i].dispclk_mhz = max_dispclk_mhz ? max_dispclk_mhz :
-				dcn3_16_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
-
-			clock_limits[i].dppclk_mhz = max_dppclk_mhz ? max_dppclk_mhz :
-				dcn3_16_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
-
-			clock_limits[i].dram_bw_per_chan_gbps = dcn3_16_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
-			clock_limits[i].dscclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
-			clock_limits[i].dtbclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
-			clock_limits[i].phyclk_d18_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
-			clock_limits[i].phyclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
-		}
-		for (i = 0; i < clk_table->num_entries; i++)
-			dcn3_16_soc.clock_limits[i] = clock_limits[i];
-		if (clk_table->num_entries) {
-			dcn3_16_soc.num_states = clk_table->num_entries;
-		}
-	}
-
-	if (max_dispclk_mhz) {
-		dcn3_16_soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
-		dc->dml.soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
-	}
-
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
-		dml_init_instance(&dc->dml, &dcn3_16_soc, &dcn3_16_ip, DML_PROJECT_DCN31);
-	else
-		dml_init_instance(&dc->dml, &dcn3_16_soc, &dcn3_16_ip, DML_PROJECT_DCN31_FPGA);
-}
-
 static struct resource_funcs dcn316_res_pool_funcs = {
 	.destroy = dcn316_destroy_resource_pool,
 	.link_enc_create = dcn31_link_encoder_create,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
index 9d0d60cb9482..0dc5a6c13ae7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn316/dcn316_resource.h
@@ -31,6 +31,9 @@
 #define TO_DCN316_RES_POOL(pool)\
 	container_of(pool, struct dcn316_resource_pool, base)
 
+extern struct _vcs_dpi_ip_params_st dcn3_16_ip;
+extern struct _vcs_dpi_ip_params_st dcn3_16_soc;
+
 struct dcn316_resource_pool {
 	struct resource_pool base;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index f70b47ef850c..a0a2e125c9c8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -339,6 +339,150 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_15_soc = {
 	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
 };
 
+struct _vcs_dpi_ip_params_st dcn3_16_ip = {
+	.gpuvm_enable = 1,
+	.gpuvm_max_page_table_levels = 1,
+	.hostvm_enable = 1,
+	.hostvm_max_page_table_levels = 2,
+	.rob_buffer_size_kbytes = 64,
+	.det_buffer_size_kbytes = DCN3_16_DEFAULT_DET_SIZE,
+	.config_return_buffer_size_in_kbytes = 1024,
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
+	.num_dsc = 3,
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
+struct _vcs_dpi_soc_bounding_box_st dcn3_16_soc = {
+		/*TODO: correct dispclk/dppclk voltage level determination*/
+	.clock_limits = {
+		{
+			.state = 0,
+			.dispclk_mhz = 556.0,
+			.dppclk_mhz = 556.0,
+			.phyclk_mhz = 600.0,
+			.phyclk_d18_mhz = 445.0,
+			.dscclk_mhz = 186.0,
+			.dtbclk_mhz = 625.0,
+		},
+		{
+			.state = 1,
+			.dispclk_mhz = 625.0,
+			.dppclk_mhz = 625.0,
+			.phyclk_mhz = 810.0,
+			.phyclk_d18_mhz = 667.0,
+			.dscclk_mhz = 209.0,
+			.dtbclk_mhz = 625.0,
+		},
+		{
+			.state = 2,
+			.dispclk_mhz = 625.0,
+			.dppclk_mhz = 625.0,
+			.phyclk_mhz = 810.0,
+			.phyclk_d18_mhz = 667.0,
+			.dscclk_mhz = 209.0,
+			.dtbclk_mhz = 625.0,
+		},
+		{
+			.state = 3,
+			.dispclk_mhz = 1112.0,
+			.dppclk_mhz = 1112.0,
+			.phyclk_mhz = 810.0,
+			.phyclk_d18_mhz = 667.0,
+			.dscclk_mhz = 371.0,
+			.dtbclk_mhz = 625.0,
+		},
+		{
+			.state = 4,
+			.dispclk_mhz = 1250.0,
+			.dppclk_mhz = 1250.0,
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
 void dcn31_calculate_wm_and_dlg_fp(
 		struct dc *dc, struct dc_state *context,
 		display_e2e_pipe_params_st *pipes,
@@ -632,3 +776,88 @@ void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_param
 	else
 		dml_init_instance(&dc->dml, &dcn3_15_soc, &dcn3_15_ip, DML_PROJECT_DCN31_FPGA);
 }
+
+void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
+{
+	struct clk_limit_table *clk_table = &bw_params->clk_table;
+	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
+	unsigned int i, closest_clk_lvl;
+	int max_dispclk_mhz = 0, max_dppclk_mhz = 0;
+	int j;
+
+	dc_assert_fp_enabled();
+
+	// Default clock levels are used for diags, which may lead to overclocking.
+	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
+
+		dcn3_16_ip.max_num_otg = dc->res_pool->res_cap->num_timing_generator;
+		dcn3_16_ip.max_num_dpp = dc->res_pool->pipe_count;
+		dcn3_16_soc.num_chans = bw_params->num_channels;
+
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
+			for (closest_clk_lvl = 0, j = dcn3_16_soc.num_states - 1; j >= 0; j--) {
+				if ((unsigned int) dcn3_16_soc.clock_limits[j].dcfclk_mhz <= clk_table->entries[i].dcfclk_mhz) {
+					closest_clk_lvl = j;
+					break;
+				}
+			}
+			// Ported from DCN315
+			if (clk_table->num_entries == 1) {
+				/*smu gives one DPM level, let's take the highest one*/
+				closest_clk_lvl = dcn3_16_soc.num_states - 1;
+			}
+
+			clock_limits[i].state = i;
+
+			/* Clocks dependent on voltage level. */
+			clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
+			if (clk_table->num_entries == 1 &&
+				clock_limits[i].dcfclk_mhz < dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz) {
+				/*SMU fix not released yet*/
+				clock_limits[i].dcfclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dcfclk_mhz;
+			}
+			clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
+			clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
+			clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
+
+			/* Clocks independent of voltage level. */
+			clock_limits[i].dispclk_mhz = max_dispclk_mhz ? max_dispclk_mhz :
+				dcn3_16_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
+
+			clock_limits[i].dppclk_mhz = max_dppclk_mhz ? max_dppclk_mhz :
+				dcn3_16_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
+
+			clock_limits[i].dram_bw_per_chan_gbps = dcn3_16_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
+			clock_limits[i].dscclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
+			clock_limits[i].dtbclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
+			clock_limits[i].phyclk_d18_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
+			clock_limits[i].phyclk_mhz = dcn3_16_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
+		}
+		for (i = 0; i < clk_table->num_entries; i++)
+			dcn3_16_soc.clock_limits[i] = clock_limits[i];
+		if (clk_table->num_entries) {
+			dcn3_16_soc.num_states = clk_table->num_entries;
+		}
+	}
+
+	if (max_dispclk_mhz) {
+		dcn3_16_soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
+		dc->dml.soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
+	}
+
+	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
+		dml_init_instance(&dc->dml, &dcn3_16_soc, &dcn3_16_ip, DML_PROJECT_DCN31);
+	else
+		dml_init_instance(&dc->dml, &dcn3_16_soc, &dcn3_16_ip, DML_PROJECT_DCN31_FPGA);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
index b15b587cf8c4..24ac19c83687 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
@@ -29,6 +29,7 @@
 #define DCN3_1_DEFAULT_DET_SIZE 384
 #define DCN3_15_DEFAULT_DET_SIZE 192
 #define DCN3_15_MIN_COMPBUF_SIZE_KB 128
+#define DCN3_16_DEFAULT_DET_SIZE 192
 
 void dcn31_calculate_wm_and_dlg_fp(
 		struct dc *dc, struct dc_state *context,
@@ -38,5 +39,6 @@ void dcn31_calculate_wm_and_dlg_fp(
 
 void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
 void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
+void dcn316_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
 
 #endif /* __DCN31_FPU_H__*/
-- 
2.35.1


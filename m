Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7787CC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 05:50:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7BFD10ED14;
	Mon,  7 Mar 2022 05:50:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2045.outbound.protection.outlook.com [40.107.93.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E126410EA68
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 05:50:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=keqFbkIZDUNQC7qk4M2wq63atqIBFUhFVYyFgr85V5r6mLa5goaXPXpgOfwuTBqag3zBhn7CKFKoPpBJvXUpuC+MCqRKNxdKthG0pDX8i43aEZrXxv2znNqhJxt0r+HsLdJUm2RmUrCDKUzlbZGTPIc50K8Xo9RSq7kFcdyyskkU48i3n2x5zryAEBGsOwiAk1KCjWvC0fTZB47ffn6hBhRgtGG5fBBBm5AJ2Y1lSBciqjBxesMR43jNEnmuFoVsndR72UYHq2QD40ItgxylO358BT2A2d/vAASPJs/YiAh3cyygl+t/UrAvhs6PIrfNLY3LxyYVLO6uwbl/K49Itg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m7w1KEjD0BxJQPCqYe88a79RECvuMhXjhSCdygsy91I=;
 b=ePSqnqg50E21XfEpL104F3R3VCitKFChcm5DMuHJBK/4DyOJ5ZoUrXDbjMgnzdvc7yzEPd3d0tw8sZ8t0hIw7rDJddKe3OrguxRosxDGMIPEV9CW/ng7YxCsYmoG6oWRAz6ryMOwlvjehrOOy4zaKiftKZrn5+bAtXsnHqKruDyYEQlC6t1obbsOpujH0ZD4l3bIlM2+3vwKmqlgyAlqbDVhY7TlHmG/esVnqULrwHgUCH1TrNYof7qTT5s5SSCPwbNOi1gkKcOgSQ1TqxHUR3jPQdotxl1VH8OsbtjfKWEf3tk+HdHda3iYEjKlUNqDm+CyXMSB3itsAP9nwRbzFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m7w1KEjD0BxJQPCqYe88a79RECvuMhXjhSCdygsy91I=;
 b=wAEl7x61BUDlrKYTPEmofu6CEwRDaHNKSZCun7aNTcyS3+r4ASJjIyC4UR9mL+aH2QBVw+kmY9G7g/9jSL3yn7B7I7cfiqyHTT2/puICh/AdzGTPGOX/uRq8bP2IScSI7ZLTNH6Kd7ri1DLOkbSJ8edEUAxbWMoxcRvt6bAqG2M=
Received: from DM5PR12CA0004.namprd12.prod.outlook.com (2603:10b6:4:1::14) by
 SA0PR12MB4445.namprd12.prod.outlook.com (2603:10b6:806:95::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5038.14; Mon, 7 Mar 2022 05:50:18 +0000
Received: from DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:1:cafe::9f) by DM5PR12CA0004.outlook.office365.com
 (2603:10b6:4:1::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 05:50:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT062.mail.protection.outlook.com (10.13.173.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 05:50:18 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 23:50:17 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 23:50:17 -0600
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sun, 6 Mar 2022 23:50:08 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/21] drm/amd/display: move FPU associated DCN303 code to DML
 folder
Date: Tue, 8 Mar 2022 05:09:30 +0800
Message-ID: <20220307210942.444808-8-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307210942.444808-4-HaoPing.Liu@amd.com>
References: <20220307210942.444808-4-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d753198d-6140-4c32-d1a6-08d9fffe5c35
X-MS-TrafficTypeDiagnostic: SA0PR12MB4445:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB44455FFC4D7B817B939BBF07F5089@SA0PR12MB4445.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: juWrEv9GBjAm46nsPP6MMg0APABBU3XwQxMy4HP7P1LYa65VdgRKTerYjx+Ho3FSTqFSvl28hlio6wSee6RVYYGhXnysnsmdnRB3NTVfCwgTaz3ezSWtbkO8rsQZaiwh+7UZsB7aOVYLKsDzRK69+B8O3oLVvfjO37Nw2OBhOz4HJ4gA/DL8JP0x5WIWMUlGoU9IqO1H1sQ2g1dHHoT35QCt3EuGRFCh4pqIH2/YaQTfshcT5P08gqngwg5g53/NhN/CXbz2+Q7bqtQzQ6avzspZMssTSros8cMuh7jZuXAiImm03zkRU1x9H8OslYeHdE3HAJYe/ZMYdov7e0wY9USrLlZ/LqFs2BQreKYGXwoauzaBNQCZyLQTQPVTPuVhEQDHLvyO0RPobYY332/O/jI9OriMCkaBzRT2cj2RATb+rcbHkDUDnaQjDMwyBZZfXlGOTXtPrrL04Q10ghrph2z0aYgm35DU04/pUjtZk5FcaTtdxA7m0JF6PKZFuDF3B3E3n4OK8JfhGvaPwhSbnlv60pph0GDV0FgZrnypFTQ155dWhMwYW8YsDTow4rFPCEecq/ovENy2W6tkpa6pAsp/rsVN9LYxKNXXY3d8qJNYNp5H6/FOJx4LR1mMCEKZrHzHh9cjb6umK13QzBDrccHteBv0wwttnQQJX8n1ujyiY+nFyUwEHDkB9hI71M5UfJKRT674eNYrom8TV2wCDA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(46966006)(40470700004)(36840700001)(2616005)(82310400004)(81166007)(7696005)(36860700001)(86362001)(2906002)(356005)(966005)(316002)(47076005)(40140700001)(70206006)(70586007)(508600001)(8676002)(6666004)(4326008)(336012)(26005)(8936002)(426003)(5660300002)(186003)(83380400001)(30864003)(36756003)(40460700003)(54906003)(1076003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 05:50:18.2505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d753198d-6140-4c32-d1a6-08d9fffe5c35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT062.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4445
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
Cc: stylon.wang@amd.com, Alan
 Liu <HaoPing.Liu@amd.com>, Jasdeep Dhillon <jasdeep.dhillon@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Dhillon, Jasdeep" <Jasdeep.Dhillon@amd.com>

[Why & How]
As part of the FPU isolation work documented in
https://patchwork.freedesktop.org/series/93042/, isolate
code that uses FPU in DCN303 to DML, where all FPU code
should locate.

Co-authored-by: Jasdeep Dhillon <jasdeep.dhillon@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Jasdeep Dhillon <jasdeep.dhillon@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn303/Makefile    |  26 --
 .../amd/display/dc/dcn303/dcn303_resource.c   | 327 +---------------
 .../amd/display/dc/dcn303/dcn303_resource.h   |   3 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   2 +
 .../amd/display/dc/dml/dcn303/dcn303_fpu.c    | 362 ++++++++++++++++++
 .../amd/display/dc/dml/dcn303/dcn303_fpu.h    |  32 ++
 6 files changed, 409 insertions(+), 343 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/Makefile b/drivers/gpu/drm/amd/display/dc/dcn303/Makefile
index 6f7a1f2b49f0..8702e0b7fda3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/Makefile
@@ -8,32 +8,6 @@
 
 DCN3_03 = dcn303_init.o dcn303_hwseq.o dcn303_resource.o
 
-ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn303/dcn303_resource.o := -msse
-endif
-
-ifdef CONFIG_PPC64
-CFLAGS_$(AMDDALPATH)/dc/dcn303/dcn303_resource.o := -mhard-float -maltivec
-endif
-
-ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
-IS_OLD_GCC = 1
-endif
-CFLAGS_$(AMDDALPATH)/dc/dcn303/dcn303_resource.o += -mhard-float
-endif
-
-ifdef CONFIG_X86
-ifdef IS_OLD_GCC
-# Stack alignment mismatch, proceed with caution.
-# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
-# (8B stack alignment).
-CFLAGS_$(AMDDALPATH)/dc/dcn303/dcn303_resource.o += -mpreferred-stack-boundary=4
-else
-CFLAGS_$(AMDDALPATH)/dc/dcn303/dcn303_resource.o += -msse2
-endif
-endif
-
 AMD_DAL_DCN3_03 = $(addprefix $(AMDDALPATH)/dc/dcn303/,$(DCN3_03))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DCN3_03)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
index 36649716e991..4fcbc0502808 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.c
@@ -52,140 +52,10 @@
 #include "dpcs/dpcs_3_0_3_sh_mask.h"
 #include "nbio/nbio_2_3_offset.h"
 
-#define DC_LOGGER_INIT(logger)
+#include "dml/dcn303/dcn303_fpu.h"
 
-struct _vcs_dpi_ip_params_st dcn3_03_ip = {
-		.use_min_dcfclk = 0,
-		.clamp_min_dcfclk = 0,
-		.odm_capable = 1,
-		.gpuvm_enable = 1,
-		.hostvm_enable = 0,
-		.gpuvm_max_page_table_levels = 4,
-		.hostvm_max_page_table_levels = 4,
-		.hostvm_cached_page_table_levels = 0,
-		.pte_group_size_bytes = 2048,
-		.num_dsc = 2,
-		.rob_buffer_size_kbytes = 184,
-		.det_buffer_size_kbytes = 184,
-		.dpte_buffer_size_in_pte_reqs_luma = 64,
-		.dpte_buffer_size_in_pte_reqs_chroma = 34,
-		.pde_proc_buffer_size_64k_reqs = 48,
-		.dpp_output_buffer_pixels = 2560,
-		.opp_output_buffer_lines = 1,
-		.pixel_chunk_size_kbytes = 8,
-		.pte_enable = 1,
-		.max_page_table_levels = 2,
-		.pte_chunk_size_kbytes = 2,  // ?
-		.meta_chunk_size_kbytes = 2,
-		.writeback_chunk_size_kbytes = 8,
-		.line_buffer_size_bits = 789504,
-		.is_line_buffer_bpp_fixed = 0,  // ?
-		.line_buffer_fixed_bpp = 0,     // ?
-		.dcc_supported = true,
-		.writeback_interface_buffer_size_kbytes = 90,
-		.writeback_line_buffer_buffer_size = 0,
-		.max_line_buffer_lines = 12,
-		.writeback_luma_buffer_size_kbytes = 12,  // writeback_line_buffer_buffer_size = 656640
-		.writeback_chroma_buffer_size_kbytes = 8,
-		.writeback_chroma_line_buffer_width_pixels = 4,
-		.writeback_max_hscl_ratio = 1,
-		.writeback_max_vscl_ratio = 1,
-		.writeback_min_hscl_ratio = 1,
-		.writeback_min_vscl_ratio = 1,
-		.writeback_max_hscl_taps = 1,
-		.writeback_max_vscl_taps = 1,
-		.writeback_line_buffer_luma_buffer_size = 0,
-		.writeback_line_buffer_chroma_buffer_size = 14643,
-		.cursor_buffer_size = 8,
-		.cursor_chunk_size = 2,
-		.max_num_otg = 2,
-		.max_num_dpp = 2,
-		.max_num_wb = 1,
-		.max_dchub_pscl_bw_pix_per_clk = 4,
-		.max_pscl_lb_bw_pix_per_clk = 2,
-		.max_lb_vscl_bw_pix_per_clk = 4,
-		.max_vscl_hscl_bw_pix_per_clk = 4,
-		.max_hscl_ratio = 6,
-		.max_vscl_ratio = 6,
-		.hscl_mults = 4,
-		.vscl_mults = 4,
-		.max_hscl_taps = 8,
-		.max_vscl_taps = 8,
-		.dispclk_ramp_margin_percent = 1,
-		.underscan_factor = 1.11,
-		.min_vblank_lines = 32,
-		.dppclk_delay_subtotal = 46,
-		.dynamic_metadata_vm_enabled = true,
-		.dppclk_delay_scl_lb_only = 16,
-		.dppclk_delay_scl = 50,
-		.dppclk_delay_cnvc_formatter = 27,
-		.dppclk_delay_cnvc_cursor = 6,
-		.dispclk_delay_subtotal = 119,
-		.dcfclk_cstate_latency = 5.2, // SRExitTime
-		.max_inter_dcn_tile_repeaters = 8,
-		.max_num_hdmi_frl_outputs = 1,
-		.odm_combine_4to1_supported = false,
-		.xfc_supported = false,
-		.xfc_fill_bw_overhead_percent = 10.0,
-		.xfc_fill_constant_bytes = 0,
-		.gfx7_compat_tiling_supported = 0,
-		.number_of_cursors = 1,
-};
-
-struct _vcs_dpi_soc_bounding_box_st dcn3_03_soc = {
-		.clock_limits = {
-				{
-						.state = 0,
-						.dispclk_mhz = 1217.0,
-						.dppclk_mhz = 1217.0,
-						.phyclk_mhz = 810.0,
-						.phyclk_d18_mhz = 667.0,
-						.dscclk_mhz = 405.6,
-				},
-		},
+#define DC_LOGGER_INIT(logger)
 
-		.min_dcfclk = 500.0, /* TODO: set this to actual min DCFCLK */
-		.num_states = 1,
-		.sr_exit_time_us = 35.5,
-		.sr_enter_plus_exit_time_us = 40,
-		.urgent_latency_us = 4.0,
-		.urgent_latency_pixel_data_only_us = 4.0,
-		.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
-		.urgent_latency_vm_data_only_us = 4.0,
-		.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
-		.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
-		.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
-		.pct_ideal_dram_sdp_bw_after_urgent_pixel_only = 80.0,
-		.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm = 60.0,
-		.pct_ideal_dram_sdp_bw_after_urgent_vm_only = 40.0,
-		.max_avg_sdp_bw_use_normal_percent = 60.0,
-		.max_avg_dram_bw_use_normal_percent = 40.0,
-		.writeback_latency_us = 12.0,
-		.max_request_size_bytes = 256,
-		.fabric_datapath_to_dcn_data_return_bytes = 64,
-		.dcn_downspread_percent = 0.5,
-		.downspread_percent = 0.38,
-		.dram_page_open_time_ns = 50.0,
-		.dram_rw_turnaround_time_ns = 17.5,
-		.dram_return_buffer_per_channel_bytes = 8192,
-		.round_trip_ping_latency_dcfclk_cycles = 156,
-		.urgent_out_of_order_return_per_channel_bytes = 4096,
-		.channel_interleave_bytes = 256,
-		.num_banks = 8,
-		.gpuvm_min_page_size_bytes = 4096,
-		.hostvm_min_page_size_bytes = 4096,
-		.dram_clock_change_latency_us = 404,
-		.dummy_pstate_latency_us = 5,
-		.writeback_dram_clock_change_latency_us = 23.0,
-		.return_bus_width_bytes = 64,
-		.dispclk_dppclk_vco_speed_mhz = 3650,
-		.xfc_bus_transport_time_us = 20,      // ?
-		.xfc_xbuf_latency_tolerance_us = 4,  // ?
-		.use_urgent_burst_bw = 1,            // ?
-		.do_urgent_latency_adjustment = true,
-		.urgent_latency_adjustment_fabric_clock_component_us = 1.0,
-		.urgent_latency_adjustment_fabric_clock_reference_mhz = 1000,
-};
 
 static const struct dc_debug_options debug_defaults_drv = {
 		.disable_dmcu = true,
@@ -1031,24 +901,18 @@ static bool init_soc_bounding_box(struct dc *dc,  struct resource_pool *pool)
 	loaded_ip->max_num_otg = pool->pipe_count;
 	loaded_ip->max_num_dpp = pool->pipe_count;
 	loaded_ip->clamp_min_dcfclk = dc->config.clamp_min_dcfclk;
+	DC_FP_START();
 	dcn20_patch_bounding_box(dc, loaded_bb);
+	DC_FP_END();
 
 	if (dc->ctx->dc_bios->funcs->get_soc_bb_info) {
 		struct bp_soc_bb_info bb_info = { 0 };
 
 		if (dc->ctx->dc_bios->funcs->get_soc_bb_info(
 			    dc->ctx->dc_bios, &bb_info) == BP_RESULT_OK) {
-			if (bb_info.dram_clock_change_latency_100ns > 0)
-				dcn3_03_soc.dram_clock_change_latency_us =
-					bb_info.dram_clock_change_latency_100ns * 10;
-
-			if (bb_info.dram_sr_enter_exit_latency_100ns > 0)
-				dcn3_03_soc.sr_enter_plus_exit_time_us =
-					bb_info.dram_sr_enter_exit_latency_100ns * 10;
-
-			if (bb_info.dram_sr_exit_latency_100ns > 0)
-				dcn3_03_soc.sr_exit_time_us =
-					bb_info.dram_sr_exit_latency_100ns * 10;
+					DC_FP_START();
+					dcn303_fpu_init_soc_bounding_box(bb_info);
+					DC_FP_END();
 		}
 	}
 
@@ -1186,183 +1050,12 @@ static void dcn303_destroy_resource_pool(struct resource_pool **pool)
 	*pool = NULL;
 }
 
-static void dcn303_get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
-		unsigned int *optimal_dcfclk,
-		unsigned int *optimal_fclk)
-{
-	double bw_from_dram, bw_from_dram1, bw_from_dram2;
-
-	bw_from_dram1 = uclk_mts * dcn3_03_soc.num_chans *
-		dcn3_03_soc.dram_channel_width_bytes * (dcn3_03_soc.max_avg_dram_bw_use_normal_percent / 100);
-	bw_from_dram2 = uclk_mts * dcn3_03_soc.num_chans *
-		dcn3_03_soc.dram_channel_width_bytes * (dcn3_03_soc.max_avg_sdp_bw_use_normal_percent / 100);
-
-	bw_from_dram = (bw_from_dram1 < bw_from_dram2) ? bw_from_dram1 : bw_from_dram2;
-
-	if (optimal_fclk)
-		*optimal_fclk = bw_from_dram /
-		(dcn3_03_soc.fabric_datapath_to_dcn_data_return_bytes *
-				(dcn3_03_soc.max_avg_sdp_bw_use_normal_percent / 100));
-
-	if (optimal_dcfclk)
-		*optimal_dcfclk =  bw_from_dram /
-		(dcn3_03_soc.return_bus_width_bytes * (dcn3_03_soc.max_avg_sdp_bw_use_normal_percent / 100));
-}
 
 void dcn303_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
 {
-	unsigned int i, j;
-	unsigned int num_states = 0;
-
-	unsigned int dcfclk_mhz[DC__VOLTAGE_STATES] = {0};
-	unsigned int dram_speed_mts[DC__VOLTAGE_STATES] = {0};
-	unsigned int optimal_uclk_for_dcfclk_sta_targets[DC__VOLTAGE_STATES] = {0};
-	unsigned int optimal_dcfclk_for_uclk[DC__VOLTAGE_STATES] = {0};
-
-	unsigned int dcfclk_sta_targets[DC__VOLTAGE_STATES] = {694, 875, 1000, 1200};
-	unsigned int num_dcfclk_sta_targets = 4;
-	unsigned int num_uclk_states;
-
-
-	if (dc->ctx->dc_bios->vram_info.num_chans)
-		dcn3_03_soc.num_chans = dc->ctx->dc_bios->vram_info.num_chans;
-
-	if (dc->ctx->dc_bios->vram_info.dram_channel_width_bytes)
-		dcn3_03_soc.dram_channel_width_bytes = dc->ctx->dc_bios->vram_info.dram_channel_width_bytes;
-
-	dcn3_03_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
-	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
-
-	if (bw_params->clk_table.entries[0].memclk_mhz) {
-		int max_dcfclk_mhz = 0, max_dispclk_mhz = 0, max_dppclk_mhz = 0, max_phyclk_mhz = 0;
-
-		for (i = 0; i < MAX_NUM_DPM_LVL; i++) {
-			if (bw_params->clk_table.entries[i].dcfclk_mhz > max_dcfclk_mhz)
-				max_dcfclk_mhz = bw_params->clk_table.entries[i].dcfclk_mhz;
-			if (bw_params->clk_table.entries[i].dispclk_mhz > max_dispclk_mhz)
-				max_dispclk_mhz = bw_params->clk_table.entries[i].dispclk_mhz;
-			if (bw_params->clk_table.entries[i].dppclk_mhz > max_dppclk_mhz)
-				max_dppclk_mhz = bw_params->clk_table.entries[i].dppclk_mhz;
-			if (bw_params->clk_table.entries[i].phyclk_mhz > max_phyclk_mhz)
-				max_phyclk_mhz = bw_params->clk_table.entries[i].phyclk_mhz;
-		}
-		if (!max_dcfclk_mhz)
-			max_dcfclk_mhz = dcn3_03_soc.clock_limits[0].dcfclk_mhz;
-		if (!max_dispclk_mhz)
-			max_dispclk_mhz = dcn3_03_soc.clock_limits[0].dispclk_mhz;
-		if (!max_dppclk_mhz)
-			max_dppclk_mhz = dcn3_03_soc.clock_limits[0].dppclk_mhz;
-		if (!max_phyclk_mhz)
-			max_phyclk_mhz = dcn3_03_soc.clock_limits[0].phyclk_mhz;
-
-		if (max_dcfclk_mhz > dcfclk_sta_targets[num_dcfclk_sta_targets-1]) {
-			dcfclk_sta_targets[num_dcfclk_sta_targets] = max_dcfclk_mhz;
-			num_dcfclk_sta_targets++;
-		} else if (max_dcfclk_mhz < dcfclk_sta_targets[num_dcfclk_sta_targets-1]) {
-			for (i = 0; i < num_dcfclk_sta_targets; i++) {
-				if (dcfclk_sta_targets[i] > max_dcfclk_mhz) {
-					dcfclk_sta_targets[i] = max_dcfclk_mhz;
-					break;
-				}
-			}
-			/* Update size of array since we "removed" duplicates */
-			num_dcfclk_sta_targets = i + 1;
-		}
-
-		num_uclk_states = bw_params->clk_table.num_entries;
-
-		/* Calculate optimal dcfclk for each uclk */
-		for (i = 0; i < num_uclk_states; i++) {
-			dcn303_get_optimal_dcfclk_fclk_for_uclk(bw_params->clk_table.entries[i].memclk_mhz * 16,
-					&optimal_dcfclk_for_uclk[i], NULL);
-			if (optimal_dcfclk_for_uclk[i] < bw_params->clk_table.entries[0].dcfclk_mhz)
-				optimal_dcfclk_for_uclk[i] = bw_params->clk_table.entries[0].dcfclk_mhz;
-		}
-
-		/* Calculate optimal uclk for each dcfclk sta target */
-		for (i = 0; i < num_dcfclk_sta_targets; i++) {
-			for (j = 0; j < num_uclk_states; j++) {
-				if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j]) {
-					optimal_uclk_for_dcfclk_sta_targets[i] =
-							bw_params->clk_table.entries[j].memclk_mhz * 16;
-					break;
-				}
-			}
-		}
-
-		i = 0;
-		j = 0;
-		/* create the final dcfclk and uclk table */
-		while (i < num_dcfclk_sta_targets && j < num_uclk_states && num_states < DC__VOLTAGE_STATES) {
-			if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j] && i < num_dcfclk_sta_targets) {
-				dcfclk_mhz[num_states] = dcfclk_sta_targets[i];
-				dram_speed_mts[num_states++] = optimal_uclk_for_dcfclk_sta_targets[i++];
-			} else {
-				if (j < num_uclk_states && optimal_dcfclk_for_uclk[j] <= max_dcfclk_mhz) {
-					dcfclk_mhz[num_states] = optimal_dcfclk_for_uclk[j];
-					dram_speed_mts[num_states++] =
-							bw_params->clk_table.entries[j++].memclk_mhz * 16;
-				} else {
-					j = num_uclk_states;
-				}
-			}
-		}
-
-		while (i < num_dcfclk_sta_targets && num_states < DC__VOLTAGE_STATES) {
-			dcfclk_mhz[num_states] = dcfclk_sta_targets[i];
-			dram_speed_mts[num_states++] = optimal_uclk_for_dcfclk_sta_targets[i++];
-		}
-
-		while (j < num_uclk_states && num_states < DC__VOLTAGE_STATES &&
-				optimal_dcfclk_for_uclk[j] <= max_dcfclk_mhz) {
-			dcfclk_mhz[num_states] = optimal_dcfclk_for_uclk[j];
-			dram_speed_mts[num_states++] = bw_params->clk_table.entries[j++].memclk_mhz * 16;
-		}
-
-		dcn3_03_soc.num_states = num_states;
-		for (i = 0; i < dcn3_03_soc.num_states; i++) {
-			dcn3_03_soc.clock_limits[i].state = i;
-			dcn3_03_soc.clock_limits[i].dcfclk_mhz = dcfclk_mhz[i];
-			dcn3_03_soc.clock_limits[i].fabricclk_mhz = dcfclk_mhz[i];
-			dcn3_03_soc.clock_limits[i].dram_speed_mts = dram_speed_mts[i];
-
-			/* Fill all states with max values of all other clocks */
-			dcn3_03_soc.clock_limits[i].dispclk_mhz = max_dispclk_mhz;
-			dcn3_03_soc.clock_limits[i].dppclk_mhz  = max_dppclk_mhz;
-			dcn3_03_soc.clock_limits[i].phyclk_mhz  = max_phyclk_mhz;
-			/* Populate from bw_params for DTBCLK, SOCCLK */
-			if (!bw_params->clk_table.entries[i].dtbclk_mhz && i > 0)
-				dcn3_03_soc.clock_limits[i].dtbclk_mhz = dcn3_03_soc.clock_limits[i-1].dtbclk_mhz;
-			else
-				dcn3_03_soc.clock_limits[i].dtbclk_mhz = bw_params->clk_table.entries[i].dtbclk_mhz;
-			if (!bw_params->clk_table.entries[i].socclk_mhz && i > 0)
-				dcn3_03_soc.clock_limits[i].socclk_mhz = dcn3_03_soc.clock_limits[i-1].socclk_mhz;
-			else
-				dcn3_03_soc.clock_limits[i].socclk_mhz = bw_params->clk_table.entries[i].socclk_mhz;
-			/* These clocks cannot come from bw_params, always fill from dcn3_03_soc[1] */
-			/* FCLK, PHYCLK_D18, DSCCLK */
-			dcn3_03_soc.clock_limits[i].phyclk_d18_mhz = dcn3_03_soc.clock_limits[0].phyclk_d18_mhz;
-			dcn3_03_soc.clock_limits[i].dscclk_mhz = dcn3_03_soc.clock_limits[0].dscclk_mhz;
-		}
-
-		// WA: patch strobe modes to compensate for DCN303 BW issue
-		if (dcn3_03_soc.num_chans <= 4) {
-			for (i = 0; i < dcn3_03_soc.num_states; i++) {
-				if (dcn3_03_soc.clock_limits[i].dram_speed_mts > 1700)
-					break;
-
-				if (dcn3_03_soc.clock_limits[i].dram_speed_mts >= 1500) {
-					dcn3_03_soc.clock_limits[i].dcfclk_mhz = 100;
-					dcn3_03_soc.clock_limits[i].fabricclk_mhz = 100;
-				}
-			}
-		}
-
-		/* re-init DML with updated bb */
-		dml_init_instance(&dc->dml, &dcn3_03_soc, &dcn3_03_ip, DML_PROJECT_DCN30);
-		if (dc->current_state)
-			dml_init_instance(&dc->current_state->bw_ctx.dml, &dcn3_03_soc, &dcn3_03_ip, DML_PROJECT_DCN30);
-	}
+	DC_FP_START();
+	dcn303_fpu_update_bw_bounding_box(dc, bw_params);
+	DC_FP_END();
 }
 
 static struct resource_funcs dcn303_res_pool_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.h b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.h
index 5b590c169763..9c7d79540900 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn303/dcn303_resource.h
@@ -10,6 +10,9 @@
 
 #include "core_types.h"
 
+extern struct _vcs_dpi_ip_params_st dcn3_03_ip;
+extern struct _vcs_dpi_soc_bounding_box_st dcn3_03_soc;
+
 struct resource_pool *dcn303_create_resource_pool(const struct dc_init_data *init_data, struct dc *dc);
 
 void dcn303_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index b16c492593e2..6ab83c3e9c5c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -72,6 +72,7 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_ccflags) $(fram
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn302/dcn302_fpu.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn303/dcn303_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/calcs/dcn_calcs.o := $(dml_ccflags)
@@ -113,6 +114,7 @@ DML += dcn30/display_mode_vba_30.o dcn30/display_rq_dlg_calc_30.o
 DML += dcn31/display_mode_vba_31.o dcn31/display_rq_dlg_calc_31.o
 DML += dcn301/dcn301_fpu.o
 DML += dcn302/dcn302_fpu.o
+DML += dcn303/dcn303_fpu.o
 DML += dsc/rc_calc_fpu.o
 DML += calcs/dcn_calcs.o calcs/dcn_calc_math.o calcs/dcn_calc_auto.o
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c
new file mode 100644
index 000000000000..8fb14baed208
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.c
@@ -0,0 +1,362 @@
+/*
+ * Copyright 2019-2021 Advanced Micro Devices, Inc.
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
+#include "resource.h"
+#include "clk_mgr.h"
+#include "dcn20/dcn20_resource.h"
+#include "dcn303/dcn303_resource.h"
+
+#include "dml/dcn20/dcn20_fpu.h"
+#include "dcn303_fpu.h"
+
+struct _vcs_dpi_ip_params_st dcn3_03_ip = {
+		.use_min_dcfclk = 0,
+		.clamp_min_dcfclk = 0,
+		.odm_capable = 1,
+		.gpuvm_enable = 1,
+		.hostvm_enable = 0,
+		.gpuvm_max_page_table_levels = 4,
+		.hostvm_max_page_table_levels = 4,
+		.hostvm_cached_page_table_levels = 0,
+		.pte_group_size_bytes = 2048,
+		.num_dsc = 2,
+		.rob_buffer_size_kbytes = 184,
+		.det_buffer_size_kbytes = 184,
+		.dpte_buffer_size_in_pte_reqs_luma = 64,
+		.dpte_buffer_size_in_pte_reqs_chroma = 34,
+		.pde_proc_buffer_size_64k_reqs = 48,
+		.dpp_output_buffer_pixels = 2560,
+		.opp_output_buffer_lines = 1,
+		.pixel_chunk_size_kbytes = 8,
+		.pte_enable = 1,
+		.max_page_table_levels = 2,
+		.pte_chunk_size_kbytes = 2,  // ?
+		.meta_chunk_size_kbytes = 2,
+		.writeback_chunk_size_kbytes = 8,
+		.line_buffer_size_bits = 789504,
+		.is_line_buffer_bpp_fixed = 0,  // ?
+		.line_buffer_fixed_bpp = 0,     // ?
+		.dcc_supported = true,
+		.writeback_interface_buffer_size_kbytes = 90,
+		.writeback_line_buffer_buffer_size = 0,
+		.max_line_buffer_lines = 12,
+		.writeback_luma_buffer_size_kbytes = 12,  // writeback_line_buffer_buffer_size = 656640
+		.writeback_chroma_buffer_size_kbytes = 8,
+		.writeback_chroma_line_buffer_width_pixels = 4,
+		.writeback_max_hscl_ratio = 1,
+		.writeback_max_vscl_ratio = 1,
+		.writeback_min_hscl_ratio = 1,
+		.writeback_min_vscl_ratio = 1,
+		.writeback_max_hscl_taps = 1,
+		.writeback_max_vscl_taps = 1,
+		.writeback_line_buffer_luma_buffer_size = 0,
+		.writeback_line_buffer_chroma_buffer_size = 14643,
+		.cursor_buffer_size = 8,
+		.cursor_chunk_size = 2,
+		.max_num_otg = 2,
+		.max_num_dpp = 2,
+		.max_num_wb = 1,
+		.max_dchub_pscl_bw_pix_per_clk = 4,
+		.max_pscl_lb_bw_pix_per_clk = 2,
+		.max_lb_vscl_bw_pix_per_clk = 4,
+		.max_vscl_hscl_bw_pix_per_clk = 4,
+		.max_hscl_ratio = 6,
+		.max_vscl_ratio = 6,
+		.hscl_mults = 4,
+		.vscl_mults = 4,
+		.max_hscl_taps = 8,
+		.max_vscl_taps = 8,
+		.dispclk_ramp_margin_percent = 1,
+		.underscan_factor = 1.11,
+		.min_vblank_lines = 32,
+		.dppclk_delay_subtotal = 46,
+		.dynamic_metadata_vm_enabled = true,
+		.dppclk_delay_scl_lb_only = 16,
+		.dppclk_delay_scl = 50,
+		.dppclk_delay_cnvc_formatter = 27,
+		.dppclk_delay_cnvc_cursor = 6,
+		.dispclk_delay_subtotal = 119,
+		.dcfclk_cstate_latency = 5.2, // SRExitTime
+		.max_inter_dcn_tile_repeaters = 8,
+		.max_num_hdmi_frl_outputs = 1,
+		.odm_combine_4to1_supported = false,
+
+		.xfc_supported = false,
+		.xfc_fill_bw_overhead_percent = 10.0,
+		.xfc_fill_constant_bytes = 0,
+		.gfx7_compat_tiling_supported = 0,
+		.number_of_cursors = 1,
+};
+
+struct _vcs_dpi_soc_bounding_box_st dcn3_03_soc = {
+		.clock_limits = {
+				{
+						.state = 0,
+						.dispclk_mhz = 562.0,
+						.dppclk_mhz = 300.0,
+						.phyclk_mhz = 300.0,
+						.phyclk_d18_mhz = 667.0,
+						.dscclk_mhz = 405.6,
+				},
+		},
+
+		.min_dcfclk = 500.0, /* TODO: set this to actual min DCFCLK */
+		.num_states = 1,
+		.sr_exit_time_us = 35.5,
+		.sr_enter_plus_exit_time_us = 40,
+		.urgent_latency_us = 4.0,
+		.urgent_latency_pixel_data_only_us = 4.0,
+		.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
+		.urgent_latency_vm_data_only_us = 4.0,
+		.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
+		.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
+		.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
+		.pct_ideal_dram_sdp_bw_after_urgent_pixel_only = 80.0,
+		.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm = 60.0,
+		.pct_ideal_dram_sdp_bw_after_urgent_vm_only = 40.0,
+		.max_avg_sdp_bw_use_normal_percent = 60.0,
+		.max_avg_dram_bw_use_normal_percent = 40.0,
+		.writeback_latency_us = 12.0,
+		.max_request_size_bytes = 256,
+		.fabric_datapath_to_dcn_data_return_bytes = 64,
+		.dcn_downspread_percent = 0.5,
+		.downspread_percent = 0.38,
+		.dram_page_open_time_ns = 50.0,
+		.dram_rw_turnaround_time_ns = 17.5,
+		.dram_return_buffer_per_channel_bytes = 8192,
+		.round_trip_ping_latency_dcfclk_cycles = 156,
+		.urgent_out_of_order_return_per_channel_bytes = 4096,
+		.channel_interleave_bytes = 256,
+		.num_banks = 8,
+		.gpuvm_min_page_size_bytes = 4096,
+		.hostvm_min_page_size_bytes = 4096,
+		.dram_clock_change_latency_us = 404,
+		.dummy_pstate_latency_us = 5,
+		.writeback_dram_clock_change_latency_us = 23.0,
+		.return_bus_width_bytes = 64,
+		.dispclk_dppclk_vco_speed_mhz = 3650,
+		.xfc_bus_transport_time_us = 20,      // ?
+		.xfc_xbuf_latency_tolerance_us = 4,  // ?
+		.use_urgent_burst_bw = 1,            // ?
+		.do_urgent_latency_adjustment = true,
+		.urgent_latency_adjustment_fabric_clock_component_us = 1.0,
+		.urgent_latency_adjustment_fabric_clock_reference_mhz = 1000,
+};
+
+static void dcn303_get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
+		unsigned int *optimal_dcfclk,
+		unsigned int *optimal_fclk)
+{
+	double bw_from_dram, bw_from_dram1, bw_from_dram2;
+
+	bw_from_dram1 = uclk_mts * dcn3_03_soc.num_chans *
+		dcn3_03_soc.dram_channel_width_bytes * (dcn3_03_soc.max_avg_dram_bw_use_normal_percent / 100);
+	bw_from_dram2 = uclk_mts * dcn3_03_soc.num_chans *
+		dcn3_03_soc.dram_channel_width_bytes * (dcn3_03_soc.max_avg_sdp_bw_use_normal_percent / 100);
+
+	bw_from_dram = (bw_from_dram1 < bw_from_dram2) ? bw_from_dram1 : bw_from_dram2;
+
+	if (optimal_fclk)
+		*optimal_fclk = bw_from_dram /
+		(dcn3_03_soc.fabric_datapath_to_dcn_data_return_bytes *
+				(dcn3_03_soc.max_avg_sdp_bw_use_normal_percent / 100));
+
+	if (optimal_dcfclk)
+		*optimal_dcfclk =  bw_from_dram /
+		(dcn3_03_soc.return_bus_width_bytes * (dcn3_03_soc.max_avg_sdp_bw_use_normal_percent / 100));
+}
+
+
+void dcn303_fpu_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
+{
+	unsigned int i, j;
+	unsigned int num_states = 0;
+
+	unsigned int dcfclk_mhz[DC__VOLTAGE_STATES] = {0};
+	unsigned int dram_speed_mts[DC__VOLTAGE_STATES] = {0};
+	unsigned int optimal_uclk_for_dcfclk_sta_targets[DC__VOLTAGE_STATES] = {0};
+	unsigned int optimal_dcfclk_for_uclk[DC__VOLTAGE_STATES] = {0};
+
+	unsigned int dcfclk_sta_targets[DC__VOLTAGE_STATES] = {694, 875, 1000, 1200};
+	unsigned int num_dcfclk_sta_targets = 4;
+	unsigned int num_uclk_states;
+
+    dc_assert_fp_enabled();
+
+	if (dc->ctx->dc_bios->vram_info.num_chans)
+		dcn3_03_soc.num_chans = dc->ctx->dc_bios->vram_info.num_chans;
+
+	if (dc->ctx->dc_bios->vram_info.dram_channel_width_bytes)
+		dcn3_03_soc.dram_channel_width_bytes = dc->ctx->dc_bios->vram_info.dram_channel_width_bytes;
+
+	dcn3_03_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
+	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
+
+	if (bw_params->clk_table.entries[0].memclk_mhz) {
+		int max_dcfclk_mhz = 0, max_dispclk_mhz = 0, max_dppclk_mhz = 0, max_phyclk_mhz = 0;
+
+		for (i = 0; i < MAX_NUM_DPM_LVL; i++) {
+			if (bw_params->clk_table.entries[i].dcfclk_mhz > max_dcfclk_mhz)
+				max_dcfclk_mhz = bw_params->clk_table.entries[i].dcfclk_mhz;
+			if (bw_params->clk_table.entries[i].dispclk_mhz > max_dispclk_mhz)
+				max_dispclk_mhz = bw_params->clk_table.entries[i].dispclk_mhz;
+			if (bw_params->clk_table.entries[i].dppclk_mhz > max_dppclk_mhz)
+				max_dppclk_mhz = bw_params->clk_table.entries[i].dppclk_mhz;
+			if (bw_params->clk_table.entries[i].phyclk_mhz > max_phyclk_mhz)
+				max_phyclk_mhz = bw_params->clk_table.entries[i].phyclk_mhz;
+		}
+		if (!max_dcfclk_mhz)
+			max_dcfclk_mhz = dcn3_03_soc.clock_limits[0].dcfclk_mhz;
+		if (!max_dispclk_mhz)
+			max_dispclk_mhz = dcn3_03_soc.clock_limits[0].dispclk_mhz;
+		if (!max_dppclk_mhz)
+			max_dppclk_mhz = dcn3_03_soc.clock_limits[0].dppclk_mhz;
+		if (!max_phyclk_mhz)
+			max_phyclk_mhz = dcn3_03_soc.clock_limits[0].phyclk_mhz;
+
+		if (max_dcfclk_mhz > dcfclk_sta_targets[num_dcfclk_sta_targets-1]) {
+			dcfclk_sta_targets[num_dcfclk_sta_targets] = max_dcfclk_mhz;
+			num_dcfclk_sta_targets++;
+		} else if (max_dcfclk_mhz < dcfclk_sta_targets[num_dcfclk_sta_targets-1]) {
+			for (i = 0; i < num_dcfclk_sta_targets; i++) {
+				if (dcfclk_sta_targets[i] > max_dcfclk_mhz) {
+					dcfclk_sta_targets[i] = max_dcfclk_mhz;
+					break;
+				}
+			}
+			/* Update size of array since we "removed" duplicates */
+			num_dcfclk_sta_targets = i + 1;
+		}
+
+		num_uclk_states = bw_params->clk_table.num_entries;
+
+		/* Calculate optimal dcfclk for each uclk */
+		for (i = 0; i < num_uclk_states; i++) {
+			dcn303_get_optimal_dcfclk_fclk_for_uclk(bw_params->clk_table.entries[i].memclk_mhz * 16,
+					&optimal_dcfclk_for_uclk[i], NULL);
+			if (optimal_dcfclk_for_uclk[i] < bw_params->clk_table.entries[0].dcfclk_mhz)
+				optimal_dcfclk_for_uclk[i] = bw_params->clk_table.entries[0].dcfclk_mhz;
+		}
+
+		/* Calculate optimal uclk for each dcfclk sta target */
+		for (i = 0; i < num_dcfclk_sta_targets; i++) {
+			for (j = 0; j < num_uclk_states; j++) {
+				if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j]) {
+					optimal_uclk_for_dcfclk_sta_targets[i] =
+							bw_params->clk_table.entries[j].memclk_mhz * 16;
+					break;
+				}
+			}
+		}
+
+		i = 0;
+		j = 0;
+		/* create the final dcfclk and uclk table */
+		while (i < num_dcfclk_sta_targets && j < num_uclk_states && num_states < DC__VOLTAGE_STATES) {
+			if (dcfclk_sta_targets[i] < optimal_dcfclk_for_uclk[j] && i < num_dcfclk_sta_targets) {
+				dcfclk_mhz[num_states] = dcfclk_sta_targets[i];
+				dram_speed_mts[num_states++] = optimal_uclk_for_dcfclk_sta_targets[i++];
+			} else {
+				if (j < num_uclk_states && optimal_dcfclk_for_uclk[j] <= max_dcfclk_mhz) {
+					dcfclk_mhz[num_states] = optimal_dcfclk_for_uclk[j];
+					dram_speed_mts[num_states++] =
+							bw_params->clk_table.entries[j++].memclk_mhz * 16;
+				} else {
+					j = num_uclk_states;
+				}
+			}
+		}
+
+		while (i < num_dcfclk_sta_targets && num_states < DC__VOLTAGE_STATES) {
+			dcfclk_mhz[num_states] = dcfclk_sta_targets[i];
+			dram_speed_mts[num_states++] = optimal_uclk_for_dcfclk_sta_targets[i++];
+		}
+
+		while (j < num_uclk_states && num_states < DC__VOLTAGE_STATES &&
+				optimal_dcfclk_for_uclk[j] <= max_dcfclk_mhz) {
+			dcfclk_mhz[num_states] = optimal_dcfclk_for_uclk[j];
+			dram_speed_mts[num_states++] = bw_params->clk_table.entries[j++].memclk_mhz * 16;
+		}
+
+		dcn3_03_soc.num_states = num_states;
+		for (i = 0; i < dcn3_03_soc.num_states; i++) {
+			dcn3_03_soc.clock_limits[i].state = i;
+			dcn3_03_soc.clock_limits[i].dcfclk_mhz = dcfclk_mhz[i];
+			dcn3_03_soc.clock_limits[i].fabricclk_mhz = dcfclk_mhz[i];
+			dcn3_03_soc.clock_limits[i].dram_speed_mts = dram_speed_mts[i];
+
+			/* Fill all states with max values of all other clocks */
+			dcn3_03_soc.clock_limits[i].dispclk_mhz = max_dispclk_mhz;
+			dcn3_03_soc.clock_limits[i].dppclk_mhz  = max_dppclk_mhz;
+			dcn3_03_soc.clock_limits[i].phyclk_mhz  = max_phyclk_mhz;
+			/* Populate from bw_params for DTBCLK, SOCCLK */
+			if (!bw_params->clk_table.entries[i].dtbclk_mhz && i > 0)
+				dcn3_03_soc.clock_limits[i].dtbclk_mhz = dcn3_03_soc.clock_limits[i-1].dtbclk_mhz;
+			else
+				dcn3_03_soc.clock_limits[i].dtbclk_mhz = bw_params->clk_table.entries[i].dtbclk_mhz;
+			if (!bw_params->clk_table.entries[i].socclk_mhz && i > 0)
+				dcn3_03_soc.clock_limits[i].socclk_mhz = dcn3_03_soc.clock_limits[i-1].socclk_mhz;
+			else
+				dcn3_03_soc.clock_limits[i].socclk_mhz = bw_params->clk_table.entries[i].socclk_mhz;
+			/* These clocks cannot come from bw_params, always fill from dcn3_03_soc[1] */
+			/* FCLK, PHYCLK_D18, DSCCLK */
+			dcn3_03_soc.clock_limits[i].phyclk_d18_mhz = dcn3_03_soc.clock_limits[0].phyclk_d18_mhz;
+			dcn3_03_soc.clock_limits[i].dscclk_mhz = dcn3_03_soc.clock_limits[0].dscclk_mhz;
+		}
+
+		if (dcn3_03_soc.num_chans <= 4) {
+			for (i = 0; i < dcn3_03_soc.num_states; i++) {
+				if (dcn3_03_soc.clock_limits[i].dram_speed_mts > 1700)
+					break;
+
+				if (dcn3_03_soc.clock_limits[i].dram_speed_mts >= 1500) {
+					dcn3_03_soc.clock_limits[i].dcfclk_mhz = 100;
+					dcn3_03_soc.clock_limits[i].fabricclk_mhz = 100;
+				}
+			}
+		}
+
+		/* re-init DML with updated bb */
+		dml_init_instance(&dc->dml, &dcn3_03_soc, &dcn3_03_ip, DML_PROJECT_DCN30);
+		if (dc->current_state)
+			dml_init_instance(&dc->current_state->bw_ctx.dml, &dcn3_03_soc, &dcn3_03_ip, DML_PROJECT_DCN30);
+	}
+}
+
+void dcn303_fpu_init_soc_bounding_box(struct bp_soc_bb_info bb_info)
+{
+	dc_assert_fp_enabled();
+
+	if (bb_info.dram_clock_change_latency_100ns > 0)
+				dcn3_03_soc.dram_clock_change_latency_us =
+					bb_info.dram_clock_change_latency_100ns * 10;
+
+			if (bb_info.dram_sr_enter_exit_latency_100ns > 0)
+				dcn3_03_soc.sr_enter_plus_exit_time_us =
+					bb_info.dram_sr_enter_exit_latency_100ns * 10;
+
+			if (bb_info.dram_sr_exit_latency_100ns > 0)
+				dcn3_03_soc.sr_exit_time_us =
+					bb_info.dram_sr_exit_latency_100ns * 10;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.h
new file mode 100644
index 000000000000..92ec833fa528
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn303/dcn303_fpu.h
@@ -0,0 +1,32 @@
+/*
+ * Copyright 2019-2021 Advanced Micro Devices, Inc.
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
+#ifndef __DCN303_FPU_H__
+#define __DCN303_FPU_H__
+
+void dcn303_fpu_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
+void dcn303_fpu_init_soc_bounding_box(struct bp_soc_bb_info bb_info);
+
+#endif /* __DCN303_FPU_H__*/
-- 
2.25.1


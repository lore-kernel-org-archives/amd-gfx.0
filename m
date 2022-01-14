Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7921C433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Jan 2022 01:37:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5D20510EAF2;
	Fri, 14 Jan 2022 01:37:47 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 773DC10EAF2
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Jan 2022 01:37:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H5MqjyVXqU7rLZy1kQR3MrxGhsnp5blnD/SXKOLhjauS8ywMps0LB6miXCgGCHQst+1xt422jIGPOKLs4azC1SfBScDJNOpfCI14UHjVQcf5pQCizLcYJ37OzqW3jPBRTsB7DI7WdzBuUQL84IqgrOeiUIhorrrXwp5zVH6DxFtgZOqF9WKub8DU7WZgJPPJNv43b5fckR2FfA6QjAOq8QRL3hTDwfbDvHxbJdDiHSNDcN+Zf8fO//0pNvRXGJR7xdNQ27BrO8Q1MU0d5yMwNuK1znB6XghtVjWFHAiw79xkNi5NCYPxWsH1hR+f7IAyNLzsO1+fsEy5igwut6I8Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FL9GI5T6PTcVXF8f01JwoPs9aaxvyaEw+jcxS1KtxCw=;
 b=Q5g/wiw7u1jOVAdELT5MJYV7TKbI00SMpiRlxkrRMMXPHMtUTREtEQZz09bseV5SxN04ona558wydyzOkpOq4exGOfzDs/jnCpIKrAXZlwfd8YNafXOZP7icouWt1dn4FrleU82m3jSWF7DWfdujhHXHwXU3c2qQFeRIRvZjauekyLMZBw4GLiUl0UKGyO8acyc6/YtXw1g5xuFQXVUJJxe7o/9jUBNRPhDi7yLk7glgtwZeeCNkW8jqsmjuiatndCxQgctGaueJbfoypCTmsjSvHneOPFVUX53EZfkNt8OG+m3k+JUud1B3RvJ+JrG8NySYUFe/seSmHmhoTaJIcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FL9GI5T6PTcVXF8f01JwoPs9aaxvyaEw+jcxS1KtxCw=;
 b=ayq6hLRwdmFPvC2uP/rkkv9M9x3+d/BOOp5T+OOKqHIOrN9me6iimERuZpYMlDET945xGDfFovXpaFqxTckJHKTSBIqGFgThZIwEYHbjusEuA7+DSVlkbV71VLKWmHyLgm6pHGoxCjrQCgc2BXJadpFrJKsPWSTVzHQVHMzMkxU=
Received: from BN8PR04CA0045.namprd04.prod.outlook.com (2603:10b6:408:d4::19)
 by DM6PR12MB3947.namprd12.prod.outlook.com (2603:10b6:5:148::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.11; Fri, 14 Jan
 2022 01:37:43 +0000
Received: from BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:d4:cafe::49) by BN8PR04CA0045.outlook.office365.com
 (2603:10b6:408:d4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.11 via Frontend
 Transport; Fri, 14 Jan 2022 01:37:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT022.mail.protection.outlook.com (10.13.176.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4888.9 via Frontend Transport; Fri, 14 Jan 2022 01:37:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17; Thu, 13 Jan
 2022 19:37:42 -0600
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.17
 via Frontend Transport; Thu, 13 Jan 2022 19:37:38 -0600
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/13] drm/amd/display: move FPU associated DCN302 code to DML
 folder
Date: Fri, 14 Jan 2022 09:36:50 +0800
Message-ID: <20220114013657.3119627-7-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114013657.3119627-1-Wayne.Lin@amd.com>
References: <20220114013657.3119627-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7057194e-55a5-4f42-4bcf-08d9d6fe7587
X-MS-TrafficTypeDiagnostic: DM6PR12MB3947:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB3947B3ABADEA74CA6D8EAEFCFC549@DM6PR12MB3947.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qzcV0caDB0DBf8PlTX1J6U5k4CCiOvkio2qpNxT3B8C+YA590ptNgWnaokpCiTV9KHWkVcpJF20I8qA0fIEqfZYGWZL7Ln7QdROPQKoR00dKEfNKkgiMFzUX1wbkNlTyYT3K6k1kBReG7KmLXrJml9ZcgWKAX3gnNHuloVQtTH33+CLz8HMEl8llhZhTT6zypHxb+DF27LfRkKMPGcQU/DPrSLaYNCuN4ZUjiw8enea1WH4vsTc7PFbz1OLVlNB2lMfBClANN3b0Wq1A+HhghNAb6saysqnZUosYs+lUPGBAAfwxz8wxjqlxdBjvSU+oJIWOiwEmZVpsa1R4T3T3bySrahNX8do4wJW1WLm+wmP7QT8yf9QUq03/cei64K7XIyfBgp43SptUa5MP9od9zclcxU1O6oCGYQJp+/TXknNO54ioqoGXN++TuU9w4GR0aUIuSrc/Bi8/v4QIvFrHleNmt3lBEPX/kTqjdxicL8KUKeZlBuOIAKC7cQTMpbjchGvLVYcRzdhnUmKuUQ6rQimxQPU17L3WazsNENNR7o29vKe+bx9VSIZo1XXFE0VwDZcKIRUxEr7/zXFN4nW2OdMVNPslA3W2toCK2lsQIgeW0xSiKesuDFgrvCs6f/Ubg5rb+Husgh/i8Imwnk8m1I+ujnd6SlAi8Wqy2+fhZi6RlKaLvLLHkx35PJVkD+nlNK7+LWP2I8BW1p0NnBJThLUgw4eBb7P+jVA105q+J2QOVm55TiRn2/4gkLlJw0SVZ0FpeMF71d/Z1gvs9wvWe+RN5m427k4KzScDFkIUMQ0=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(40460700001)(36756003)(4326008)(70206006)(30864003)(316002)(336012)(426003)(1076003)(356005)(70586007)(54906003)(2616005)(83380400001)(26005)(36860700001)(186003)(6916009)(8676002)(81166007)(6666004)(508600001)(86362001)(2906002)(40140700001)(47076005)(7696005)(8936002)(966005)(5660300002)(82310400004)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2022 01:37:43.1005 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7057194e-55a5-4f42-4bcf-08d9d6fe7587
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT022.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3947
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
Cc: stylon.wang@amd.com, "Dhillon, Jasdeep" <Jasdeep.Dhillon@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Dhillon, Jasdeep" <Jasdeep.Dhillon@amd.com>

[Why & How]
As part of the FPU isolation work documented in
https://patchwork.freedesktop.org/series/93042/, isolate
code that uses FPU in DCN302 to DML, where all FPU code
should locate.

Co-authored-by: Jasdeep Dhillon <jdhillon@amd.com>
Reviewed-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Jasdeep Dhillon <jdhillon@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn302/Makefile    |  12 -
 .../amd/display/dc/dcn302/dcn302_resource.c   | 316 +---------------
 .../amd/display/dc/dcn302/dcn302_resource.h   |   3 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   2 +
 .../amd/display/dc/dml/dcn302/dcn302_fpu.c    | 357 ++++++++++++++++++
 .../amd/display/dc/dml/dcn302/dcn302_fpu.h    |  32 ++
 6 files changed, 404 insertions(+), 318 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
index 101620a8867a..f9561d7f97a1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/Makefile
@@ -1,11 +1,6 @@
 #
 # (c) Copyright 2020 Advanced Micro Devices, Inc. All the rights reserved
 #
-#  All rights reserved.  This notice is intended as a precaution against
-#  inadvertent publication and does not imply publication or any waiver
-#  of confidentiality.  The year included in the foregoing notice is the
-#  year of creation of the work.
-#
 #  Authors: AMD
 #
 # Makefile for dcn302.
@@ -20,13 +15,6 @@ ifdef CONFIG_PPC64
 CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mhard-float -maltivec
 endif
 
-ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
-IS_OLD_GCC = 1
-endif
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o += -mhard-float
-endif
-
 ifdef CONFIG_X86
 ifdef IS_OLD_GCC
 # Stack alignment mismatch, proceed with caution.
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
index 2e9cbfa7663b..e512ae6d00d4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.c
@@ -61,6 +61,8 @@
 #include "resource.h"
 #include "vm_helper.h"
 
+#include "dml/dcn302/dcn302_fpu.h"
+
 #include "dimgrey_cavefish_ip_offset.h"
 #include "dcn/dcn_3_0_2_offset.h"
 #include "dcn/dcn_3_0_2_sh_mask.h"
@@ -71,140 +73,6 @@
 
 #define DC_LOGGER_INIT(logger)
 
-struct _vcs_dpi_ip_params_st dcn3_02_ip = {
-		.use_min_dcfclk = 0,
-		.clamp_min_dcfclk = 0,
-		.odm_capable = 1,
-		.gpuvm_enable = 1,
-		.hostvm_enable = 0,
-		.gpuvm_max_page_table_levels = 4,
-		.hostvm_max_page_table_levels = 4,
-		.hostvm_cached_page_table_levels = 0,
-		.pte_group_size_bytes = 2048,
-		.num_dsc = 5,
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
-		.max_num_otg = 5,
-		.max_num_dpp = 5,
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
-		.odm_combine_4to1_supported = true,
-
-		.xfc_supported = false,
-		.xfc_fill_bw_overhead_percent = 10.0,
-		.xfc_fill_constant_bytes = 0,
-		.gfx7_compat_tiling_supported = 0,
-		.number_of_cursors = 1,
-};
-
-struct _vcs_dpi_soc_bounding_box_st dcn3_02_soc = {
-		.clock_limits = {
-				{
-						.state = 0,
-						.dispclk_mhz = 562.0,
-						.dppclk_mhz = 300.0,
-						.phyclk_mhz = 300.0,
-						.phyclk_d18_mhz = 667.0,
-						.dscclk_mhz = 405.6,
-				},
-		},
-
-		.min_dcfclk = 500.0, /* TODO: set this to actual min DCFCLK */
-		.num_states = 1,
-		.sr_exit_time_us = 26.5,
-		.sr_enter_plus_exit_time_us = 31,
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
-
 static const struct dc_debug_options debug_defaults_drv = {
 		.disable_dmcu = true,
 		.force_abm_enable = false,
@@ -1105,24 +973,19 @@ static bool init_soc_bounding_box(struct dc *dc,  struct resource_pool *pool)
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
-				dcn3_02_soc.dram_clock_change_latency_us =
-					bb_info.dram_clock_change_latency_100ns * 10;
 
-			if (bb_info.dram_sr_enter_exit_latency_100ns > 0)
-				dcn3_02_soc.sr_enter_plus_exit_time_us =
-					bb_info.dram_sr_enter_exit_latency_100ns * 10;
-
-			if (bb_info.dram_sr_exit_latency_100ns > 0)
-				dcn3_02_soc.sr_exit_time_us =
-					bb_info.dram_sr_exit_latency_100ns * 10;
+				DC_FP_START();
+				dcn302_fpu_init_soc_bounding_box(bb_info);
+				DC_FP_END();
 		}
 	}
 
@@ -1257,170 +1120,11 @@ static void dcn302_destroy_resource_pool(struct resource_pool **pool)
 	*pool = NULL;
 }
 
-static void dcn302_get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
-		unsigned int *optimal_dcfclk,
-		unsigned int *optimal_fclk)
-{
-	double bw_from_dram, bw_from_dram1, bw_from_dram2;
-
-	bw_from_dram1 = uclk_mts * dcn3_02_soc.num_chans *
-		dcn3_02_soc.dram_channel_width_bytes * (dcn3_02_soc.max_avg_dram_bw_use_normal_percent / 100);
-	bw_from_dram2 = uclk_mts * dcn3_02_soc.num_chans *
-		dcn3_02_soc.dram_channel_width_bytes * (dcn3_02_soc.max_avg_sdp_bw_use_normal_percent / 100);
-
-	bw_from_dram = (bw_from_dram1 < bw_from_dram2) ? bw_from_dram1 : bw_from_dram2;
-
-	if (optimal_fclk)
-		*optimal_fclk = bw_from_dram /
-		(dcn3_02_soc.fabric_datapath_to_dcn_data_return_bytes * (dcn3_02_soc.max_avg_sdp_bw_use_normal_percent / 100));
-
-	if (optimal_dcfclk)
-		*optimal_dcfclk =  bw_from_dram /
-		(dcn3_02_soc.return_bus_width_bytes * (dcn3_02_soc.max_avg_sdp_bw_use_normal_percent / 100));
-}
-
 void dcn302_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
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
-		dcn3_02_soc.num_chans = dc->ctx->dc_bios->vram_info.num_chans;
-
-	if (dc->ctx->dc_bios->vram_info.dram_channel_width_bytes)
-		dcn3_02_soc.dram_channel_width_bytes = dc->ctx->dc_bios->vram_info.dram_channel_width_bytes;
-
-	dcn3_02_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
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
-			max_dcfclk_mhz = dcn3_02_soc.clock_limits[0].dcfclk_mhz;
-		if (!max_dispclk_mhz)
-			max_dispclk_mhz = dcn3_02_soc.clock_limits[0].dispclk_mhz;
-		if (!max_dppclk_mhz)
-			max_dppclk_mhz = dcn3_02_soc.clock_limits[0].dppclk_mhz;
-		if (!max_phyclk_mhz)
-			max_phyclk_mhz = dcn3_02_soc.clock_limits[0].phyclk_mhz;
-
-		if (max_dcfclk_mhz > dcfclk_sta_targets[num_dcfclk_sta_targets-1]) {
-			/* If max DCFCLK is greater than the max DCFCLK STA target, insert into the DCFCLK STA target array */
-			dcfclk_sta_targets[num_dcfclk_sta_targets] = max_dcfclk_mhz;
-			num_dcfclk_sta_targets++;
-		} else if (max_dcfclk_mhz < dcfclk_sta_targets[num_dcfclk_sta_targets-1]) {
-			/* If max DCFCLK is less than the max DCFCLK STA target, cap values and remove duplicates */
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
-			dcn302_get_optimal_dcfclk_fclk_for_uclk(bw_params->clk_table.entries[i].memclk_mhz * 16,
-					&optimal_dcfclk_for_uclk[i], NULL);
-			if (optimal_dcfclk_for_uclk[i] < bw_params->clk_table.entries[0].dcfclk_mhz) {
-				optimal_dcfclk_for_uclk[i] = bw_params->clk_table.entries[0].dcfclk_mhz;
-			}
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
-					dram_speed_mts[num_states++] = bw_params->clk_table.entries[j++].memclk_mhz * 16;
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
-		dcn3_02_soc.num_states = num_states;
-		for (i = 0; i < dcn3_02_soc.num_states; i++) {
-			dcn3_02_soc.clock_limits[i].state = i;
-			dcn3_02_soc.clock_limits[i].dcfclk_mhz = dcfclk_mhz[i];
-			dcn3_02_soc.clock_limits[i].fabricclk_mhz = dcfclk_mhz[i];
-			dcn3_02_soc.clock_limits[i].dram_speed_mts = dram_speed_mts[i];
-
-			/* Fill all states with max values of all other clocks */
-			dcn3_02_soc.clock_limits[i].dispclk_mhz = max_dispclk_mhz;
-			dcn3_02_soc.clock_limits[i].dppclk_mhz  = max_dppclk_mhz;
-			dcn3_02_soc.clock_limits[i].phyclk_mhz  = max_phyclk_mhz;
-			/* Populate from bw_params for DTBCLK, SOCCLK */
-			if (!bw_params->clk_table.entries[i].dtbclk_mhz && i > 0)
-				dcn3_02_soc.clock_limits[i].dtbclk_mhz  = dcn3_02_soc.clock_limits[i-1].dtbclk_mhz;
-			else
-				dcn3_02_soc.clock_limits[i].dtbclk_mhz  = bw_params->clk_table.entries[i].dtbclk_mhz;
-			if (!bw_params->clk_table.entries[i].socclk_mhz && i > 0)
-				dcn3_02_soc.clock_limits[i].socclk_mhz = dcn3_02_soc.clock_limits[i-1].socclk_mhz;
-			else
-				dcn3_02_soc.clock_limits[i].socclk_mhz = bw_params->clk_table.entries[i].socclk_mhz;
-			/* These clocks cannot come from bw_params, always fill from dcn3_02_soc[1] */
-			/* FCLK, PHYCLK_D18, DSCCLK */
-			dcn3_02_soc.clock_limits[i].phyclk_d18_mhz = dcn3_02_soc.clock_limits[0].phyclk_d18_mhz;
-			dcn3_02_soc.clock_limits[i].dscclk_mhz = dcn3_02_soc.clock_limits[0].dscclk_mhz;
-		}
-		/* re-init DML with updated bb */
-		dml_init_instance(&dc->dml, &dcn3_02_soc, &dcn3_02_ip, DML_PROJECT_DCN30);
-		if (dc->current_state)
-			dml_init_instance(&dc->current_state->bw_ctx.dml, &dcn3_02_soc, &dcn3_02_ip, DML_PROJECT_DCN30);
-	}
+	DC_FP_START();
+	dcn302_fpu_update_bw_bounding_box(dc, bw_params);
+	DC_FP_END();
 }
 
 static struct resource_funcs dcn302_res_pool_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.h b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.h
index 42d2c73e30bc..9f24e73b92b3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn302/dcn302_resource.h
@@ -28,6 +28,9 @@
 
 #include "core_types.h"
 
+extern struct _vcs_dpi_ip_params_st dcn3_02_ip;
+extern struct _vcs_dpi_soc_bounding_box_st dcn3_02_soc;
+
 struct resource_pool *dcn302_create_resource_pool(const struct dc_init_data *init_data, struct dc *dc);
 
 void dcn302_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index eee6672bd32d..06910b1f5965 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -71,6 +71,7 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn302/dcn302_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dsc/rc_calc_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
@@ -104,6 +105,7 @@ DML += dcn21/display_rq_dlg_calc_21.o dcn21/display_mode_vba_21.o
 DML += dcn30/display_mode_vba_30.o dcn30/display_rq_dlg_calc_30.o
 DML += dcn31/display_mode_vba_31.o dcn31/display_rq_dlg_calc_31.o
 DML += dcn301/dcn301_fpu.o
+DML += dcn302/dcn302_fpu.o
 DML += dsc/rc_calc_fpu.o
 endif
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c
new file mode 100644
index 000000000000..e2bcd205aa93
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.c
@@ -0,0 +1,357 @@
+/*
+ * Copyright 2021 Advanced Micro Devices, Inc.
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
+#include "clk_mgr.h"
+#include "dcn20/dcn20_resource.h"
+#include "dcn302/dcn302_resource.h"
+
+#include "dml/dcn20/dcn20_fpu.h"
+#include "dcn302_fpu.h"
+
+struct _vcs_dpi_ip_params_st dcn3_02_ip = {
+		.use_min_dcfclk = 0,
+		.clamp_min_dcfclk = 0,
+		.odm_capable = 1,
+		.gpuvm_enable = 1,
+		.hostvm_enable = 0,
+		.gpuvm_max_page_table_levels = 4,
+		.hostvm_max_page_table_levels = 4,
+		.hostvm_cached_page_table_levels = 0,
+		.pte_group_size_bytes = 2048,
+		.num_dsc = 5,
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
+		.max_num_otg = 5,
+		.max_num_dpp = 5,
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
+		.odm_combine_4to1_supported = true,
+
+		.xfc_supported = false,
+		.xfc_fill_bw_overhead_percent = 10.0,
+		.xfc_fill_constant_bytes = 0,
+		.gfx7_compat_tiling_supported = 0,
+		.number_of_cursors = 1,
+};
+
+struct _vcs_dpi_soc_bounding_box_st dcn3_02_soc = {
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
+		.sr_exit_time_us = 26.5,
+		.sr_enter_plus_exit_time_us = 31,
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
+static void dcn302_get_optimal_dcfclk_fclk_for_uclk(unsigned int uclk_mts,
+	unsigned int *optimal_dcfclk,
+	unsigned int *optimal_fclk)
+{
+
+			double bw_from_dram, bw_from_dram1, bw_from_dram2;
+
+			bw_from_dram1 = uclk_mts * dcn3_02_soc.num_chans *
+				dcn3_02_soc.dram_channel_width_bytes *
+				(dcn3_02_soc.max_avg_dram_bw_use_normal_percent / 100);
+			bw_from_dram2 = uclk_mts * dcn3_02_soc.num_chans *
+				dcn3_02_soc.dram_channel_width_bytes *
+				(dcn3_02_soc.max_avg_sdp_bw_use_normal_percent / 100);
+
+			bw_from_dram = (bw_from_dram1 < bw_from_dram2) ? bw_from_dram1 : bw_from_dram2;
+
+			if (optimal_fclk)
+				*optimal_fclk = bw_from_dram /
+				(dcn3_02_soc.fabric_datapath_to_dcn_data_return_bytes *
+				 (dcn3_02_soc.max_avg_sdp_bw_use_normal_percent / 100));
+
+			if (optimal_dcfclk)
+				*optimal_dcfclk =  bw_from_dram /
+				(dcn3_02_soc.return_bus_width_bytes *
+				 (dcn3_02_soc.max_avg_sdp_bw_use_normal_percent / 100));
+}
+
+void dcn302_fpu_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
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
+	dc_assert_fp_enabled();
+
+	if (dc->ctx->dc_bios->vram_info.num_chans)
+		dcn3_02_soc.num_chans = dc->ctx->dc_bios->vram_info.num_chans;
+
+	if (dc->ctx->dc_bios->vram_info.dram_channel_width_bytes)
+		dcn3_02_soc.dram_channel_width_bytes = dc->ctx->dc_bios->vram_info.dram_channel_width_bytes;
+
+	dcn3_02_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
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
+			max_dcfclk_mhz = dcn3_02_soc.clock_limits[0].dcfclk_mhz;
+		if (!max_dispclk_mhz)
+			max_dispclk_mhz = dcn3_02_soc.clock_limits[0].dispclk_mhz;
+		if (!max_dppclk_mhz)
+			max_dppclk_mhz = dcn3_02_soc.clock_limits[0].dppclk_mhz;
+		if (!max_phyclk_mhz)
+			max_phyclk_mhz = dcn3_02_soc.clock_limits[0].phyclk_mhz;
+
+		if (max_dcfclk_mhz > dcfclk_sta_targets[num_dcfclk_sta_targets-1]) {
+			/* If max DCFCLK is greater than the max DCFCLK STA target, insert into the DCFCLK STA target array */
+			dcfclk_sta_targets[num_dcfclk_sta_targets] = max_dcfclk_mhz;
+			num_dcfclk_sta_targets++;
+		} else if (max_dcfclk_mhz < dcfclk_sta_targets[num_dcfclk_sta_targets-1]) {
+			/* If max DCFCLK is less than the max DCFCLK STA target, cap values and remove duplicates */
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
+			dcn302_get_optimal_dcfclk_fclk_for_uclk(bw_params->clk_table.entries[i].memclk_mhz * 16,
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
+					dram_speed_mts[num_states++] = bw_params->clk_table.entries[j++].memclk_mhz * 16;
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
+		dcn3_02_soc.num_states = num_states;
+		for (i = 0; i < dcn3_02_soc.num_states; i++) {
+			dcn3_02_soc.clock_limits[i].state = i;
+			dcn3_02_soc.clock_limits[i].dcfclk_mhz = dcfclk_mhz[i];
+			dcn3_02_soc.clock_limits[i].fabricclk_mhz = dcfclk_mhz[i];
+			dcn3_02_soc.clock_limits[i].dram_speed_mts = dram_speed_mts[i];
+
+			/* Fill all states with max values of all other clocks */
+			dcn3_02_soc.clock_limits[i].dispclk_mhz = max_dispclk_mhz;
+			dcn3_02_soc.clock_limits[i].dppclk_mhz  = max_dppclk_mhz;
+			dcn3_02_soc.clock_limits[i].phyclk_mhz  = max_phyclk_mhz;
+			/* Populate from bw_params for DTBCLK, SOCCLK */
+			if (!bw_params->clk_table.entries[i].dtbclk_mhz && i > 0)
+				dcn3_02_soc.clock_limits[i].dtbclk_mhz  = dcn3_02_soc.clock_limits[i-1].dtbclk_mhz;
+			else
+				dcn3_02_soc.clock_limits[i].dtbclk_mhz  = bw_params->clk_table.entries[i].dtbclk_mhz;
+			if (!bw_params->clk_table.entries[i].socclk_mhz && i > 0)
+				dcn3_02_soc.clock_limits[i].socclk_mhz = dcn3_02_soc.clock_limits[i-1].socclk_mhz;
+			else
+				dcn3_02_soc.clock_limits[i].socclk_mhz = bw_params->clk_table.entries[i].socclk_mhz;
+			/* These clocks cannot come from bw_params, always fill from dcn3_02_soc[1] */
+			/* FCLK, PHYCLK_D18, DSCCLK */
+			dcn3_02_soc.clock_limits[i].phyclk_d18_mhz = dcn3_02_soc.clock_limits[0].phyclk_d18_mhz;
+			dcn3_02_soc.clock_limits[i].dscclk_mhz = dcn3_02_soc.clock_limits[0].dscclk_mhz;
+		}
+		/* re-init DML with updated bb */
+		dml_init_instance(&dc->dml, &dcn3_02_soc, &dcn3_02_ip, DML_PROJECT_DCN30);
+		if (dc->current_state)
+			dml_init_instance(&dc->current_state->bw_ctx.dml, &dcn3_02_soc, &dcn3_02_ip, DML_PROJECT_DCN30);
+	}
+}
+
+void dcn302_fpu_init_soc_bounding_box(struct bp_soc_bb_info bb_info)
+{
+
+			dc_assert_fp_enabled();
+
+			if (bb_info.dram_clock_change_latency_100ns > 0)
+				dcn3_02_soc.dram_clock_change_latency_us =
+					bb_info.dram_clock_change_latency_100ns * 10;
+
+			if (bb_info.dram_sr_enter_exit_latency_100ns > 0)
+				dcn3_02_soc.sr_enter_plus_exit_time_us =
+					bb_info.dram_sr_enter_exit_latency_100ns * 10;
+
+			if (bb_info.dram_sr_exit_latency_100ns > 0)
+				dcn3_02_soc.sr_exit_time_us =
+					bb_info.dram_sr_exit_latency_100ns * 10;
+}
+
+
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.h
new file mode 100644
index 000000000000..548305d96cee
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn302/dcn302_fpu.h
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
+#ifndef __DCN302_FPU_H__
+#define __DCN302_FPU_H__
+
+void dcn302_fpu_init_soc_bounding_box(struct bp_soc_bb_info bb_info);
+void dcn302_fpu_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
+
+#endif /* __DCN302_FPU_H__*/
-- 
2.25.1


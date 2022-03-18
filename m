Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D40B8C433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 21:51:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6B6A810E24E;
	Fri, 18 Mar 2022 21:51:05 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2052.outbound.protection.outlook.com [40.107.244.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D38410E24C
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 21:51:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vfcb613fbS2lREKgwS56JKlDKtuFgBPEZTF/twumubkNIf6mMu7g9BALl7KWMg5YJAjypxvpQ23a/oqju16I9u2k64k8VDSdywjYGRALMCztgWkGO/PP+FJ34ia30Os2/N4/3QwEPShInPEA/dMlLN0PxG+YT58dXsvRvndp5Q1eZoJP3qTLhNDPewofOOPAP22umgRCJnN/Q0t/vZ0JEVag7+0rOu5Rwpcfp8EccLXALGago+661JTIuRqWSTDUvcLLwpd4997UVJTf6Y3l6kdAELFlRTpeTkcsRTDySjnB2r3e5G6x9oFqbjnqfOYxDphV43IUI/IT30k7pu7RbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=luNpmXx6uzEGAxR9yHAZyzwq1B6oAr1SzUMF4fskAe4=;
 b=ZFGrzyLoSe+nBN5E+nNNA+UZda2EpgwUFg+DQfw7gwZi0yg4Nplx4bMARD7FxtfMkenKUmQAjtLK6lXrL25wRa8OTuLY1FwyDFhJ8WwsoDPnPAOj2jdSKOo8UWfm3kQEr6+Y3iF71RJXofbNIp0VxtC/GdE18OCfkQjWtBLEue+ipIn2HAbjwMMUJa3P/LaMUhEUdtDml04HihCgnkSKHKcFaDbU48cN7J6j93pBs6grZDL6nIbTIdlvOI2nfK+DH7rk5xLdyLysBdpK3acTRIqq6kPM/P6vSQlla+QI46aGK9iQfLsm6VnbnxZ1L1jkQCtBewVacvloAoanc5Oq/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=luNpmXx6uzEGAxR9yHAZyzwq1B6oAr1SzUMF4fskAe4=;
 b=SudD8a33PPX2jiRMJjwlRqGV/5dnHOMHs9hiOaYM4dfcCIBCWwv9a/+a7F5JY5eMNd/bO+x+9ekXBJv4HSX90GMdKXAneE6xWz3HDazjmg/Q2hlnLYcdl4Zdx+G9sDFlsCwyw9CHsHBCIfdEF7Z6myLJ//3FZtm47PhJs33tqz4=
Received: from BN9P223CA0026.NAMP223.PROD.OUTLOOK.COM (2603:10b6:408:10b::31)
 by MN2PR12MB3038.namprd12.prod.outlook.com (2603:10b6:208:cb::28)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.14; Fri, 18 Mar
 2022 21:50:57 +0000
Received: from BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:10b:cafe::17) by BN9P223CA0026.outlook.office365.com
 (2603:10b6:408:10b::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18 via Frontend
 Transport; Fri, 18 Mar 2022 21:50:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT036.mail.protection.outlook.com (10.13.177.168) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Fri, 18 Mar 2022 21:50:57 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 18 Mar
 2022 16:50:54 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/13] drm/amd/display: move FPU related code from dcn315 to
 dml/dcn31 folder
Date: Fri, 18 Mar 2022 15:47:59 -0600
Message-ID: <20220318214800.3565679-13-alex.hung@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c261491d-a24b-4fa7-2c20-08da0929622d
X-MS-TrafficTypeDiagnostic: MN2PR12MB3038:EE_
X-Microsoft-Antispam-PRVS: <MN2PR12MB303875F31E592F1AE4F8F0C7F7139@MN2PR12MB3038.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e7CfqjnLc0XMioPUgQcTVZTQbEUPMNWuFXuEtLZl9Kpxwjl1YNlmfC1Ab1TdzDjUCuDU4P1ZbDyDKpq8U5Zkl3nf1OSQU7jOypycuSdth9rXuEJ/338PByBB6pfhJPE5MGXL3YsQBNPfAce35FtakA7U+JcZfkQdCm34u13O3mMIngXNzksnDESmc1r0xtWZb5c+3fT/TEHJlEwZHYaaMwnAnCS3Rr6s3bb2jfI5d3qjAa8jJ6Y4YaDpWDI13sO4m2sG4Uf88dd9AgRVmPyABfVN2jkqqZGSn971n/ny3N2JmPcGpAdRJlFwDNsdePaWqLTJekue7VZZe0Ge/1xje49tvPQeiJl8VIx2OI605r7dOnQa2wSzBvGMypn7h5dr6O7ANNfeFWRA0OxsXdUzXcarG6htsfUy7ixPig7sDJuA/4Ir/rhhAGN8CR6JtThwuTTl5zVVEC9rmDIim7FoT6YDqplGd0l+Nm/YlByOgP3/opgpYhM7HieUaKVFeRqQm+rHOS4Bm2OUN1l30lMAY/cIPhcHUE+nFh+66dE8Y2q3P61uCryPwYJabWwvncXPl7SDeJRWDIp3KERZZQ9mBs7X6LcfqdhEnat6wdg1Vjo/Tc+WqUIOnNfZueymjQIVmYIg6kUytB9uwGCcreQdAH7A9/gwofWC6s48sKUBWRRUtC/noTA9EM7JMTe7uc5I8852MNf6LKKM3OEZuyu3Tw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(70586007)(5660300002)(70206006)(2906002)(8676002)(4326008)(30864003)(7696005)(44832011)(8936002)(508600001)(40460700003)(2616005)(16526019)(82310400004)(186003)(1076003)(26005)(86362001)(316002)(47076005)(54906003)(6916009)(356005)(81166007)(36860700001)(426003)(83380400001)(36756003)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 21:50:57.1001 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c261491d-a24b-4fa7-2c20-08da0929622d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3038
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

Moves related structs and dcn315_update_bw_bounding_box from dcn315
driver code to dml/dcn31_fpu that centralizes FPU code for DCN 3.1x.

Signed-off-by: Melissa Wen <mwen@igalia.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn315/Makefile    |  26 --
 .../amd/display/dc/dcn315/dcn315_resource.c   | 232 +-----------------
 .../amd/display/dc/dcn315/dcn315_resource.h   |   3 +
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.c  | 228 +++++++++++++++++
 .../drm/amd/display/dc/dml/dcn31/dcn31_fpu.h  |   3 +
 5 files changed, 235 insertions(+), 257 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/Makefile b/drivers/gpu/drm/amd/display/dc/dcn315/Makefile
index c831ad46e81c..59381d24800b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/Makefile
@@ -25,32 +25,6 @@
 
 DCN315 = dcn315_resource.o
 
-ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn315/dcn315_resource.o := -msse
-endif
-
-ifdef CONFIG_PPC64
-CFLAGS_$(AMDDALPATH)/dc/dcn315/dcn315_resource.o := -mhard-float -maltivec
-endif
-
-ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
-IS_OLD_GCC = 1
-endif
-CFLAGS_$(AMDDALPATH)/dc/dcn315/dcn315_resource.o += -mhard-float
-endif
-
-ifdef CONFIG_X86
-ifdef IS_OLD_GCC
-# Stack alignment mismatch, proceed with caution.
-# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
-# (8B stack alignment).
-CFLAGS_$(AMDDALPATH)/dc/dcn315/dcn315_resource.o += -mpreferred-stack-boundary=4
-else
-CFLAGS_$(AMDDALPATH)/dc/dcn315/dcn315_resource.o += -msse2
-endif
-endif
-
 AMD_DAL_DCN315 = $(addprefix $(AMDDALPATH)/dc/dcn315/,$(DCN315))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DCN315)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
index 06adb77c206b..fadb89326999 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.c
@@ -66,6 +66,7 @@
 #include "virtual/virtual_stream_encoder.h"
 #include "dce110/dce110_resource.h"
 #include "dml/display_mode_vba.h"
+#include "dml/dcn31/dcn31_fpu.h"
 #include "dcn31/dcn31_dccg.h"
 #include "dcn10/dcn10_resource.h"
 #include "dcn31/dcn31_panel_cntl.h"
@@ -133,158 +134,9 @@
 
 #include "link_enc_cfg.h"
 
-#define DC_LOGGER_INIT(logger)
-
-#define DCN3_15_DEFAULT_DET_SIZE 192
 #define DCN3_15_MAX_DET_SIZE 384
-#define DCN3_15_MIN_COMPBUF_SIZE_KB 128
 #define DCN3_15_CRB_SEGMENT_SIZE_KB 64
 
-struct _vcs_dpi_ip_params_st dcn3_15_ip = {
-	.gpuvm_enable = 1,
-	.gpuvm_max_page_table_levels = 1,
-	.hostvm_enable = 1,
-	.hostvm_max_page_table_levels = 2,
-	.rob_buffer_size_kbytes = 64,
-	.det_buffer_size_kbytes = DCN3_15_DEFAULT_DET_SIZE,
-	.min_comp_buffer_size_kbytes = DCN3_15_MIN_COMPBUF_SIZE_KB,
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
-	.line_buffer_fixed_bpp = 49,
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
-	.max_inter_dcn_tile_repeaters = 9,
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
-struct _vcs_dpi_soc_bounding_box_st dcn3_15_soc = {
-		/*TODO: correct dispclk/dppclk voltage level determination*/
-	.clock_limits = {
-		{
-			.state = 0,
-			.dispclk_mhz = 1372.0,
-			.dppclk_mhz = 1372.0,
-			.phyclk_mhz = 810.0,
-			.phyclk_d18_mhz = 667.0,
-			.dscclk_mhz = 417.0,
-			.dtbclk_mhz = 600.0,
-		},
-		{
-			.state = 1,
-			.dispclk_mhz = 1372.0,
-			.dppclk_mhz = 1372.0,
-			.phyclk_mhz = 810.0,
-			.phyclk_d18_mhz = 667.0,
-			.dscclk_mhz = 417.0,
-			.dtbclk_mhz = 600.0,
-		},
-		{
-			.state = 2,
-			.dispclk_mhz = 1372.0,
-			.dppclk_mhz = 1372.0,
-			.phyclk_mhz = 810.0,
-			.phyclk_d18_mhz = 667.0,
-			.dscclk_mhz = 417.0,
-			.dtbclk_mhz = 600.0,
-		},
-		{
-			.state = 3,
-			.dispclk_mhz = 1372.0,
-			.dppclk_mhz = 1372.0,
-			.phyclk_mhz = 810.0,
-			.phyclk_d18_mhz = 667.0,
-			.dscclk_mhz = 417.0,
-			.dtbclk_mhz = 600.0,
-		},
-		{
-			.state = 4,
-			.dispclk_mhz = 1372.0,
-			.dppclk_mhz = 1372.0,
-			.phyclk_mhz = 810.0,
-			.phyclk_d18_mhz = 667.0,
-			.dscclk_mhz = 417.0,
-			.dtbclk_mhz = 600.0,
-		},
-	},
-	.num_states = 5,
-	.sr_exit_time_us = 9.0,
-	.sr_enter_plus_exit_time_us = 11.0,
-	.sr_exit_z8_time_us = 50.0,
-	.sr_enter_plus_exit_z8_time_us = 50.0,
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
-	.dcn_downspread_percent = 0.38,
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
@@ -1859,88 +1711,6 @@ static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
 };
 
-static void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
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
-		dcn3_15_ip.max_num_otg = dc->res_pool->res_cap->num_timing_generator;
-		dcn3_15_ip.max_num_dpp = dc->res_pool->pipe_count;
-		dcn3_15_soc.num_chans = bw_params->num_channels;
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
-			for (closest_clk_lvl = 0, j = dcn3_15_soc.num_states - 1; j >= 0; j--) {
-				if ((unsigned int) dcn3_15_soc.clock_limits[j].dcfclk_mhz <= clk_table->entries[i].dcfclk_mhz) {
-					closest_clk_lvl = j;
-					break;
-				}
-			}
-			if (clk_table->num_entries == 1) {
-				/*smu gives one DPM level, let's take the highest one*/
-				closest_clk_lvl = dcn3_15_soc.num_states - 1;
-			}
-
-			clock_limits[i].state = i;
-
-			/* Clocks dependent on voltage level. */
-			clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
-			if (clk_table->num_entries == 1 &&
-				clock_limits[i].dcfclk_mhz < dcn3_15_soc.clock_limits[closest_clk_lvl].dcfclk_mhz) {
-				/*SMU fix not released yet*/
-				clock_limits[i].dcfclk_mhz = dcn3_15_soc.clock_limits[closest_clk_lvl].dcfclk_mhz;
-			}
-			clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
-			clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
-			clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
-
-			/* Clocks independent of voltage level. */
-			clock_limits[i].dispclk_mhz = max_dispclk_mhz ? max_dispclk_mhz :
-				dcn3_15_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
-
-			clock_limits[i].dppclk_mhz = max_dppclk_mhz ? max_dppclk_mhz :
-				dcn3_15_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
-
-			clock_limits[i].dram_bw_per_chan_gbps = dcn3_15_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
-			clock_limits[i].dscclk_mhz = dcn3_15_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
-			clock_limits[i].dtbclk_mhz = dcn3_15_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
-			clock_limits[i].phyclk_d18_mhz = dcn3_15_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
-			clock_limits[i].phyclk_mhz = dcn3_15_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
-		}
-		for (i = 0; i < clk_table->num_entries; i++)
-			dcn3_15_soc.clock_limits[i] = clock_limits[i];
-		if (clk_table->num_entries) {
-			dcn3_15_soc.num_states = clk_table->num_entries;
-		}
-	}
-
-	if (max_dispclk_mhz) {
-		dcn3_15_soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
-		dc->dml.soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
-	}
-
-	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
-		dml_init_instance(&dc->dml, &dcn3_15_soc, &dcn3_15_ip, DML_PROJECT_DCN31);
-	else
-		dml_init_instance(&dc->dml, &dcn3_15_soc, &dcn3_15_ip, DML_PROJECT_DCN31_FPGA);
-}
-
 static struct resource_funcs dcn315_res_pool_funcs = {
 	.destroy = dcn315_destroy_resource_pool,
 	.link_enc_create = dcn31_link_encoder_create,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
index f3a36820a31f..39929fa67a51 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn315/dcn315_resource.h
@@ -31,6 +31,9 @@
 #define TO_DCN315_RES_POOL(pool)\
 	container_of(pool, struct dcn315_resource_pool, base)
 
+extern struct _vcs_dpi_ip_params_st dcn3_15_ip;
+extern struct _vcs_dpi_ip_params_st dcn3_15_soc;
+
 struct dcn315_resource_pool {
 	struct resource_pool base;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
index 7ff8fe9e8712..f70b47ef850c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.c
@@ -194,6 +194,150 @@ struct _vcs_dpi_soc_bounding_box_st dcn3_1_soc = {
 	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
 };
 
+struct _vcs_dpi_ip_params_st dcn3_15_ip = {
+	.gpuvm_enable = 1,
+	.gpuvm_max_page_table_levels = 1,
+	.hostvm_enable = 1,
+	.hostvm_max_page_table_levels = 2,
+	.rob_buffer_size_kbytes = 64,
+	.det_buffer_size_kbytes = DCN3_15_DEFAULT_DET_SIZE,
+	.min_comp_buffer_size_kbytes = DCN3_15_MIN_COMPBUF_SIZE_KB,
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
+	.line_buffer_fixed_bpp = 49,
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
+	.max_inter_dcn_tile_repeaters = 9,
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
+struct _vcs_dpi_soc_bounding_box_st dcn3_15_soc = {
+		/*TODO: correct dispclk/dppclk voltage level determination*/
+	.clock_limits = {
+		{
+			.state = 0,
+			.dispclk_mhz = 1372.0,
+			.dppclk_mhz = 1372.0,
+			.phyclk_mhz = 810.0,
+			.phyclk_d18_mhz = 667.0,
+			.dscclk_mhz = 417.0,
+			.dtbclk_mhz = 600.0,
+		},
+		{
+			.state = 1,
+			.dispclk_mhz = 1372.0,
+			.dppclk_mhz = 1372.0,
+			.phyclk_mhz = 810.0,
+			.phyclk_d18_mhz = 667.0,
+			.dscclk_mhz = 417.0,
+			.dtbclk_mhz = 600.0,
+		},
+		{
+			.state = 2,
+			.dispclk_mhz = 1372.0,
+			.dppclk_mhz = 1372.0,
+			.phyclk_mhz = 810.0,
+			.phyclk_d18_mhz = 667.0,
+			.dscclk_mhz = 417.0,
+			.dtbclk_mhz = 600.0,
+		},
+		{
+			.state = 3,
+			.dispclk_mhz = 1372.0,
+			.dppclk_mhz = 1372.0,
+			.phyclk_mhz = 810.0,
+			.phyclk_d18_mhz = 667.0,
+			.dscclk_mhz = 417.0,
+			.dtbclk_mhz = 600.0,
+		},
+		{
+			.state = 4,
+			.dispclk_mhz = 1372.0,
+			.dppclk_mhz = 1372.0,
+			.phyclk_mhz = 810.0,
+			.phyclk_d18_mhz = 667.0,
+			.dscclk_mhz = 417.0,
+			.dtbclk_mhz = 600.0,
+		},
+	},
+	.num_states = 5,
+	.sr_exit_time_us = 9.0,
+	.sr_enter_plus_exit_time_us = 11.0,
+	.sr_exit_z8_time_us = 50.0,
+	.sr_enter_plus_exit_z8_time_us = 50.0,
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
+	.dcn_downspread_percent = 0.38,
+	.gpuvm_min_page_size_bytes = 4096,
+	.hostvm_min_page_size_bytes = 4096,
+	.do_urgent_latency_adjustment = false,
+	.urgent_latency_adjustment_fabric_clock_component_us = 0,
+	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
+};
 
 void dcn31_calculate_wm_and_dlg_fp(
 		struct dc *dc, struct dc_state *context,
@@ -404,3 +548,87 @@ void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 	else
 		dml_init_instance(&dc->dml, &dcn3_1_soc, &dcn3_1_ip, DML_PROJECT_DCN31_FPGA);
 }
+
+void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
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
+		dcn3_15_ip.max_num_otg = dc->res_pool->res_cap->num_timing_generator;
+		dcn3_15_ip.max_num_dpp = dc->res_pool->pipe_count;
+		dcn3_15_soc.num_chans = bw_params->num_channels;
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
+			for (closest_clk_lvl = 0, j = dcn3_15_soc.num_states - 1; j >= 0; j--) {
+				if ((unsigned int) dcn3_15_soc.clock_limits[j].dcfclk_mhz <= clk_table->entries[i].dcfclk_mhz) {
+					closest_clk_lvl = j;
+					break;
+				}
+			}
+			if (clk_table->num_entries == 1) {
+				/*smu gives one DPM level, let's take the highest one*/
+				closest_clk_lvl = dcn3_15_soc.num_states - 1;
+			}
+
+			clock_limits[i].state = i;
+
+			/* Clocks dependent on voltage level. */
+			clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
+			if (clk_table->num_entries == 1 &&
+				clock_limits[i].dcfclk_mhz < dcn3_15_soc.clock_limits[closest_clk_lvl].dcfclk_mhz) {
+				/*SMU fix not released yet*/
+				clock_limits[i].dcfclk_mhz = dcn3_15_soc.clock_limits[closest_clk_lvl].dcfclk_mhz;
+			}
+			clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
+			clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
+			clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2 * clk_table->entries[i].wck_ratio;
+
+			/* Clocks independent of voltage level. */
+			clock_limits[i].dispclk_mhz = max_dispclk_mhz ? max_dispclk_mhz :
+				dcn3_15_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
+
+			clock_limits[i].dppclk_mhz = max_dppclk_mhz ? max_dppclk_mhz :
+				dcn3_15_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
+
+			clock_limits[i].dram_bw_per_chan_gbps = dcn3_15_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
+			clock_limits[i].dscclk_mhz = dcn3_15_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
+			clock_limits[i].dtbclk_mhz = dcn3_15_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
+			clock_limits[i].phyclk_d18_mhz = dcn3_15_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
+			clock_limits[i].phyclk_mhz = dcn3_15_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
+		}
+		for (i = 0; i < clk_table->num_entries; i++)
+			dcn3_15_soc.clock_limits[i] = clock_limits[i];
+		if (clk_table->num_entries) {
+			dcn3_15_soc.num_states = clk_table->num_entries;
+		}
+	}
+
+	if (max_dispclk_mhz) {
+		dcn3_15_soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
+		dc->dml.soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
+	}
+
+	if (!IS_FPGA_MAXIMUS_DC(dc->ctx->dce_environment))
+		dml_init_instance(&dc->dml, &dcn3_15_soc, &dcn3_15_ip, DML_PROJECT_DCN31);
+	else
+		dml_init_instance(&dc->dml, &dcn3_15_soc, &dcn3_15_ip, DML_PROJECT_DCN31_FPGA);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
index baadb5150e7d..b15b587cf8c4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/dcn31_fpu.h
@@ -27,6 +27,8 @@
 #define __DCN31_FPU_H__
 
 #define DCN3_1_DEFAULT_DET_SIZE 384
+#define DCN3_15_DEFAULT_DET_SIZE 192
+#define DCN3_15_MIN_COMPBUF_SIZE_KB 128
 
 void dcn31_calculate_wm_and_dlg_fp(
 		struct dc *dc, struct dc_state *context,
@@ -35,5 +37,6 @@ void dcn31_calculate_wm_and_dlg_fp(
 		int vlevel);
 
 void dcn31_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
+void dcn315_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
 
 #endif /* __DCN31_FPU_H__*/
-- 
2.35.1


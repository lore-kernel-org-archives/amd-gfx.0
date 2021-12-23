Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4317DC433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 23 Dec 2021 18:36:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B362C10E3D7;
	Thu, 23 Dec 2021 18:36:41 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2049.outbound.protection.outlook.com [40.107.93.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AE6610E3D7
 for <amd-gfx@lists.freedesktop.org>; Thu, 23 Dec 2021 18:36:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fpF42GfUPjbYsDMXRRJmVbGt3TLymvqUfV/b5RZ8Vj2PV0gFsuBF15+6iOwzo9bdCgO2u7VYD+gKcIQPlOGe793Bbfa16zu5qnXsT9bF3bvz+SrdKbMSxvb7BIoOrCauTTsmhujuWH0NOTxtLp2Rd+KJDBv9rdM3qCqgiF8o9plcamC7tE/x9pxC27YBu1fgyRQIxCc6CDxY4mwnk5t6Si/3jrKxjV44uCKx1RKbORmxlRpXP/gK12H2rA5Jzt66zJHIwOhxx6VAHLa2PyOMP+oLeO+UzI3r/2i0gVc1Iio5fbOEHt3BWL3aFhdQASdncYh5Wg5DT3kfJWg9dmvtuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1lLc0TsgQCrppm0b+X6vG4XDIlQPGWFY1TT9fTbpj0s=;
 b=INF9LTQVTnj/kv+W41RnCLf0/OHXhB+tgoxBL14HR6ReNaofN+b5f0m9ndpensSijGdgMMxCKu85bZ+vKgFSQKRSaP+LYAADCBhXGG4a8xE1UoetIk08bGXoayPeJfXNkDDvMvVOVw/Dit9UoeY3rOJRRxGQG4KvwlI4ys4XNpt+Rs/pphZhYufisVtwHJFTI+sR/DJfbSIIIQIBbN/xzfQ+mK/3IIIqeHfqi5dcP68PwQatLtKwI7OHjvc3Ymday92ePmk7FXHXIYEMVGQ2mRm1VyU3fAKdyW3D91Xo8MyoBCnUv9TJX2DLi0ZXW5InLvKGrwePMammfgiSFQEf4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1lLc0TsgQCrppm0b+X6vG4XDIlQPGWFY1TT9fTbpj0s=;
 b=SDvuNONhhVymJ31/v28a79TKWDHf6eOKXKOJuwjMBow0cTP2YvD4ZBi0da6GzlWtHzQa5zs7WNtprt5jYTtHTOdpS6WuYIIodqZzRb7qh0yInyRdak2DklWF2Iuel0aZsN8aTN5lzs3+WtN1ld5NqGVARDqjUkHwAhXDR1wMStQ=
Received: from CO2PR04CA0166.namprd04.prod.outlook.com (2603:10b6:104:4::20)
 by BN8PR12MB3089.namprd12.prod.outlook.com (2603:10b6:408:40::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.19; Thu, 23 Dec
 2021 18:36:36 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::5d) by CO2PR04CA0166.outlook.office365.com
 (2603:10b6:104:4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4823.16 via Frontend
 Transport; Thu, 23 Dec 2021 18:36:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4823.18 via Frontend Transport; Thu, 23 Dec 2021 18:36:35 +0000
Received: from jasdeep-System-Product-Name.hitronhub.home (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 23 Dec 2021 12:36:33 -0600
From: Jasdeep Dhillon <jdhillon@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH] SWDEV-311259 - dc: move FPU associated DCN302 code to DML
Date: Thu, 23 Dec 2021 13:36:22 -0500
Message-ID: <20211223183622.76705-1-jdhillon@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8ffa27d5-87f1-4b59-37f3-08d9c6432678
X-MS-TrafficTypeDiagnostic: BN8PR12MB3089:EE_
X-Microsoft-Antispam-PRVS: <BN8PR12MB3089E13EE22C672D6A0B56FDFB7E9@BN8PR12MB3089.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: duhhk2MXXafHfxOciIpZBDQmLFWvZtO/SGfWvKmRGD+JIPz2NqERAn6u0aMh1MmdP2hQuPHHexJNKAhJ3cXyzNiQ7grZxIWL7lT52KYXOqUYy1+qBOijvt+hmDUKfZjZdLQW98EnL5gGyTmWyOv+Q2hdAOTUL4U3RicdLB6M8838MFEF0ZR/9ZsuV58UDsJ0anfsxagt+9iGdmYWDTPa/blw2d7tidWrpO9Vx/eLwkQMbVjmQprcck0f8BogZXftYe7B8UAP2c/75jyfVkbrslrY8Gxgg5zirxnZCs4kzVXiLgJwzr5DnITzNMJl1Gah37XHK0cWGF51Hlsgh6t8iEq/6eKPL6F/v2UPdzQQgx61RRP9QDm6h9sfBbTD4PIES0hh9MUiKJN5EuwQRlhztB/DPcqaUC0PLA1dqUpGAI9GYFO968IsZBkkJ95woaR8fzB/5IKkFwcZYxUBrlKGIRi0Z1ektwL/Dw5O3og5KzavVyHUaaaRJdSlMEIkPbaFUdWCZPGpuIP8CUatyLHJTGHysFz5/0io6fE22y0hvLk6wrF/VhkJPAAkeRAdCiXUHMimGWoj/9DtyhBXYW1MA4HKu/LNhmnvXzSSKUUvr/2+vWBEa2kGLIorZCF/9G4lkzhcSnChdCrvAT9eUEJhO2ior2PLjXiU46aRGIsXjxhRzd6j9GjQsQxf8zeAJpgvNDa2PfQaaWt/2mkgBSOBzFc5MpHnYKtPvQCf1G8xQp5ECGypzYzW4blqSC5aqNQ6g7fjaQ4ELX45YffqHqCHHKyCzREwdUCVnpJPny38jdQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(40470700002)(46966006)(36840700001)(83380400001)(4326008)(186003)(26005)(16526019)(40140700001)(47076005)(5660300002)(40460700001)(36860700001)(70586007)(70206006)(36756003)(336012)(2616005)(426003)(54906003)(1076003)(6916009)(8936002)(8676002)(6666004)(2906002)(30864003)(356005)(81166007)(82310400004)(966005)(508600001)(316002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Dec 2021 18:36:35.8594 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ffa27d5-87f1-4b59-37f3-08d9c6432678
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3089
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
Cc: stylon.wang@amd.com, solomon.chiu@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 mikita.lipski@amd.com, Bhawanpreet.Lakha@amd.com, christian.koenig@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why & How]
As part of the FPU isolation work documented in
https://patchwork.freedesktop.org/series/93042/, isolate
code that uses FPU in DCN302 to DML, where all FPU code
should locate.

Signed-off-by: Jasdeep Dhillon <jdhillon@amd.com>
---
 CMakeLists.txt              |   1 +
 dc/dcn302/Makefile          |  43 ++--
 dc/dcn302/dcn302_resource.c | 340 +-------------------------------
 dc/dcn302/dcn302_resource.h |   3 +
 dc/dml/Makefile             |   2 +
 dc/dml/dcn302/dcn302_fpu.c  | 381 ++++++++++++++++++++++++++++++++++++
 dc/dml/dcn302/dcn302_fpu.h  |  32 +++
 7 files changed, 448 insertions(+), 354 deletions(-)
 create mode 100644 dc/dml/dcn302/dcn302_fpu.c
 create mode 100644 dc/dml/dcn302/dcn302_fpu.h

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 01c6724df..dfee2cd38 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -243,6 +243,7 @@ list (APPEND srcs "dc/dcn301/dcn301_hubbub.c")
 list (APPEND srcs "dc/dcn302/dcn302_init.c")
 list (APPEND srcs "dc/dcn302/dcn302_hwseq.c")
 list (APPEND srcs "dc/dcn302/dcn302_resource.c")
+list (APPEND srcs "dc/dml/dcn302/dcn302_fpu.c")
 list (APPEND srcs "dc/dcn303/dcn303_init.c")
 list (APPEND srcs "dc/dcn303/dcn303_hwseq.c")
 list (APPEND srcs "dc/dcn303/dcn303_resource.c")
diff --git a/dc/dcn302/Makefile b/dc/dcn302/Makefile
index 101620a88..35a6ffbdd 100644
--- a/dc/dcn302/Makefile
+++ b/dc/dcn302/Makefile
@@ -1,42 +1,37 @@
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
 
 DCN3_02 = dcn302_init.o dcn302_hwseq.o dcn302_resource.o
 
-ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -msse
-endif
+#ifdef CONFIG_X86
+#CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -msse
+#endif
 
-ifdef CONFIG_PPC64
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mhard-float -maltivec
-endif
+#ifdef CONFIG_PPC64
+#CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o := -mhard-float -maltivec
+#endif
 
-ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
-IS_OLD_GCC = 1
-endif
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o += -mhard-float
-endif
+#ifdef CONFIG_CC_IS_GCC
+#ifeq ($(call cc-ifversion, -lt, 0701, y), y)
+#IS_OLD_GCC = 1
+#endif
+#CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o += -mhard-float
+#endif
 
-ifdef CONFIG_X86
-ifdef IS_OLD_GCC
+#ifdef CONFIG_X86
+#ifdef IS_OLD_GCC
 # Stack alignment mismatch, proceed with caution.
 # GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
 # (8B stack alignment).
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o += -mpreferred-stack-boundary=4
-else
-CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o += -msse2
-endif
-endif
+#CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o += -mpreferred-stack-boundary=4
+#else
+#CFLAGS_$(AMDDALPATH)/dc/dcn302/dcn302_resource.o += -msse2
+#endif
+#endif
 
 AMD_DAL_DCN3_02 = $(addprefix $(AMDDALPATH)/dc/dcn302/,$(DCN3_02))
 
diff --git a/dc/dcn302/dcn302_resource.c b/dc/dcn302/dcn302_resource.c
index a0f02aa9c..8fa290164 100644
--- a/dc/dcn302/dcn302_resource.c
+++ b/dc/dcn302/dcn302_resource.c
@@ -65,6 +65,8 @@
 #include "resource.h"
 #include "vm_helper.h"
 
+#include "dml/dcn302/dcn302_fpu.h"
+
 #include "include_legacy/dcn3/sienna_cichlid_ip_offset.h"
 #include "include_legacy/dcn302/dcn_3_0_2_offset.h"
 #include "include_legacy/dcn302/dcn_3_0_2_sh_mask.h"
@@ -81,164 +83,6 @@
 #define DC_LOGGER_INIT(logger)
 #endif
 
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
-#ifdef CONFIG_DRM_AMD_DC_DCN3AG
-		.writeback_interleave_and_whole_buf = false,
-#endif
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
-#ifdef CONFIG_DAL_PRODUCTION
-						.dcfclk_mhz = 1200.0,
-						.fabricclk_mhz = 1400.0,
-						.dispclk_mhz = 1217.0,
-						.dppclk_mhz = 1217.0,
-						.phyclk_mhz = 810.0,
-						.dram_speed_mts = 16000.0,
-#else
-						.dispclk_mhz = 562.0,
-						.dppclk_mhz = 300.0,
-						.phyclk_mhz = 300.0,
-#endif
-						.phyclk_d18_mhz = 667.0,
-#ifndef LINUX_DM
-						.socclk_mhz = 1200.0,
-#endif
-						.dscclk_mhz = 405.6,
-#if defined(CONFIG_DRM_AMD_DC_HDMI2_1)
-						.dtbclk_mhz = 1217.0,
-#endif
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
-#ifndef LINUX_DM
-		.dram_channel_width_bytes = 2,
-#endif
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
-#ifndef LINUX_DM
-		.num_chans = 8,
-#endif
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
@@ -1271,7 +1115,9 @@ static bool init_soc_bounding_box(struct dc *dc,  struct resource_pool *pool)
 	loaded_ip->max_num_otg = pool->pipe_count;
 	loaded_ip->max_num_dpp = pool->pipe_count;
 	loaded_ip->clamp_min_dcfclk = dc->config.clamp_min_dcfclk;
+	DC_FP_START();
 	dcn20_patch_bounding_box(dc, loaded_bb);
+	DC_FP_END();
 #ifdef CONFIG_DRM_AMD_DC_DCN3AG
 	if (dc->config.host_vm_min_page_size != 0)
 		loaded_bb->hostvm_min_page_size_bytes = dc->config.host_vm_min_page_size;
@@ -1285,17 +1131,10 @@ static bool init_soc_bounding_box(struct dc *dc,  struct resource_pool *pool)
 
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
 
@@ -1450,170 +1289,11 @@ static void dcn302_destroy_resource_pool(struct resource_pool **pool)
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
diff --git a/dc/dcn302/dcn302_resource.h b/dc/dcn302/dcn302_resource.h
index 42d2c73e3..9f24e73b9 100644
--- a/dc/dcn302/dcn302_resource.h
+++ b/dc/dcn302/dcn302_resource.h
@@ -28,6 +28,9 @@
 
 #include "core_types.h"
 
+extern struct _vcs_dpi_ip_params_st dcn3_02_ip;
+extern struct _vcs_dpi_soc_bounding_box_st dcn3_02_soc;
+
 struct resource_pool *dcn302_create_resource_pool(const struct dc_init_data *init_data, struct dc *dc);
 
 void dcn302_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
diff --git a/dc/dml/Makefile b/dc/dml/Makefile
index d8e03ca15..f55f28fe3 100644
--- a/dc/dml/Makefile
+++ b/dc/dml/Makefile
@@ -73,6 +73,7 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/frl_cap_chk_30.o := $(dml_ccflags)
 #endif
 endif
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn302/dcn302_fpu.o := $(dml_ccflags)
 ifdef CONFIG_DRM_AMD_DC_DCN3_1
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_ccflags) -Wframe-larger-than=2048
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_ccflags)
@@ -103,6 +104,7 @@ DML += dcn30/frl_cap_chk_30.o
 #endif
 endif
 DML += dcn301/dcn301_fpu.o
+DML += dcn302/dcn302_fpu.o
 ifdef CONFIG_DRM_AMD_DC_DCN3_1
 DML += dcn31/display_mode_vba_31.o dcn31/display_rq_dlg_calc_31.o
 endif
diff --git a/dc/dml/dcn302/dcn302_fpu.c b/dc/dml/dcn302/dcn302_fpu.c
new file mode 100644
index 000000000..97d9dc80b
--- /dev/null
+++ b/dc/dml/dcn302/dcn302_fpu.c
@@ -0,0 +1,381 @@
+/*
+ * Copyright 2020 Advanced Micro Devices, Inc.
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
+#ifdef CONFIG_DRM_AMD_DC_DCN3AG
+		.writeback_interleave_and_whole_buf = false,
+#endif
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
+#ifdef CONFIG_DAL_PRODUCTION
+						.dcfclk_mhz = 1200.0,
+						.fabricclk_mhz = 1400.0,
+						.dispclk_mhz = 1217.0,
+						.dppclk_mhz = 1217.0,
+						.phyclk_mhz = 810.0,
+						.dram_speed_mts = 16000.0,
+#else
+						.dispclk_mhz = 562.0,
+						.dppclk_mhz = 300.0,
+						.phyclk_mhz = 300.0,
+#endif
+						.phyclk_d18_mhz = 667.0,
+#ifndef LINUX_DM
+						.socclk_mhz = 1200.0,
+#endif
+						.dscclk_mhz = 405.6,
+#if defined(CONFIG_DRM_AMD_DC_HDMI2_1)
+						.dtbclk_mhz = 1217.0,
+#endif
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
+#ifndef LINUX_DM
+		.dram_channel_width_bytes = 2,
+#endif
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
+#ifndef LINUX_DM
+		.num_chans = 8,
+#endif
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
diff --git a/dc/dml/dcn302/dcn302_fpu.h b/dc/dml/dcn302/dcn302_fpu.h
new file mode 100644
index 000000000..548305d96
--- /dev/null
+++ b/dc/dml/dcn302/dcn302_fpu.h
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


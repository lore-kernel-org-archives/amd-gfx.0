Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D3EC433F5
	for <amd-gfx@archiver.kernel.org>; Mon,  7 Mar 2022 05:54:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6397910E70E;
	Mon,  7 Mar 2022 05:54:26 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1anam02on2043.outbound.protection.outlook.com [40.107.96.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2495C10E1A3
 for <amd-gfx@lists.freedesktop.org>; Mon,  7 Mar 2022 05:54:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b2ceR1DBEJTtBzEx/+2n7uPlrXZVrOrTooCleURTVGx4sLsmCxoI2zgBMIRgmK439sjpZdoY3y3u7NtkhyZkAjlxLcqSxe4PjiUTRgzkycO2vWiLyDHhQFh0/D47ZsXmEs8peqQmHS11tLoaD6T/HrfH4o6L8OtQDkAC5Giv+GFH855KGhb73+7c40Nx0KKWzVY4eA8ySx0McgFSvF4lgFnfNhRe1WC59d5EehSyX0LtZlgi0acBcG1hwCB+BGLIX3XXSz347tI4K3mO1Ib6ZxXYxEiEcNKAXp1J8/4NeE+t8s6qVkqTBxqZZxIgbIerC6p0Fg6srtGPPW9mjiyV5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vHffKKr0aBpfO02ZQMju8ZQ/+mR3SxYjIzRUFE5D8Q=;
 b=i4I2y6HB1cDmuO/+KNGN95vlXIwKGA4IETGIEgG7ufIHTmjG3BB6gAezEw9jvZ0bx6VgrKaKssnEgNDgFazkRyADq8DH3d7++DLh/yXTSMMICNCEAFZtQ7SS/l8/0xrHvqQn6BSSuIKzKJvS9cQD3+yy+jYZGIk1B26O48XbuVOM70qwwiGwgmOE860b5tHq9i7uWCf48lxEuTHAFNkN+aTmOYpamo67iBafK4BPY5RRLlFG/ph2tdY3AAxa386asTMlUZ8SlcAmp2q/DQ+91MFwwSbzsGcA7wIKcIBgfMJIzy0WRg4XtGiGTwgvuxplR+Qrq5b2xxfc3vdENPCNtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vHffKKr0aBpfO02ZQMju8ZQ/+mR3SxYjIzRUFE5D8Q=;
 b=RoWteTEX5cshzuLRBrTjui8QbsaGvIuPx5zFGQU2JMbx4osVDlNHLb1QKdlULNkzPRNqwRfOdS0aGrJprDrBZ7cG2mcaR+SLl78Y16zct2B/hKL5vC5Alzx8TMEIfA7VlW0KkKwRok8Jw2vOB45VaXQuriRuy5bzdjIUZErUqnQ=
Received: from MW4P221CA0014.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::19)
 by BYAPR12MB4710.namprd12.prod.outlook.com (2603:10b6:a03:9f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Mon, 7 Mar
 2022 05:54:20 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8b:cafe::e6) by MW4P221CA0014.outlook.office365.com
 (2603:10b6:303:8b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14 via Frontend
 Transport; Mon, 7 Mar 2022 05:54:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5038.14 via Frontend Transport; Mon, 7 Mar 2022 05:54:19 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.18; Sun, 6 Mar
 2022 23:54:18 -0600
Received: from alan-new-dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.18 via Frontend
 Transport; Sun, 6 Mar 2022 23:54:14 -0600
From: Alan Liu <HaoPing.Liu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 21/21] drm/amd/display: move FPU code from dcn10 to dml/dcn10
 folder
Date: Tue, 8 Mar 2022 05:09:45 +0800
Message-ID: <20220307210942.444808-22-HaoPing.Liu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307210942.444808-4-HaoPing.Liu@amd.com>
References: <20220307210942.444808-4-HaoPing.Liu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: af71635e-24ab-4de0-7109-08d9fffeebfb
X-MS-TrafficTypeDiagnostic: BYAPR12MB4710:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB47104B2F40B0C74985C0C5DFF5089@BYAPR12MB4710.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sibgWXCJTOu6Gj+ki3+sHPDmEgKx/0hGu1BR53KuxMtXfa0lWv1d8l6gc53/d6oEqHxDoQj2PrSMjMtsdIwUqvvm2ZSLRHaHbQOFtYbijJE/9o/RPM8MZ4oNKniyO5sZfSiTT6Vd0ztVSI1xlxPR4d45ia9f5rJL99furcfy1O4cYo0cdYzpdA//iGCWP3lhFs0fXnV53BOoGqAyboyx/tuQwX04AnSYzCdy0rk3tsZMU8nu81LqpmEYgzoriLLeJ5gYUCPGc3QOVssMZfbBGJ9s5wYQKs3BMjzdSI4NnBkFCL4GTtdbgSUIT9SaiNxRQmmYDqvkh6XpvPNSHSfI13k4gVIBbPLvalomQUyGRjGuiTUoU+uvR82CDluQ0iolHtVQalk/a3h1J/bXyqY0e1szUil/BuYOaLjtiNBaqs6Z1q5yxNLP3y3mzTlw5s0I1oWl54AnePz4T1NzNGxkXa7AQvrasuuO07JudBAULMTASzOJLYKX3KPsWl/m7lcjMssa09Cjrev4OIc7esDjGiK2NiWgVru5veDX6G9n7Wm8izqH8W7f3wD92EMKESw0+r9BUDWP8uqiQX5dIb0HqcRBIqN4N4vpsDo2UvB9Kw95eL9ByVdwcXoNshH8yZO6Mpn64i4+PCIX0geilheqR5NFBjIjjoyMX1vWtbxonMqkU66Qw41bxzFTZFmhjKJSdTYK0+B1oznUuDbkmsAo0Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(40470700004)(46966006)(36840700001)(81166007)(40460700003)(356005)(508600001)(6666004)(83380400001)(82310400004)(36860700001)(47076005)(7696005)(426003)(336012)(26005)(186003)(2616005)(2906002)(70206006)(70586007)(86362001)(36756003)(1076003)(5660300002)(30864003)(8936002)(4326008)(8676002)(54906003)(316002)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 05:54:19.3661 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af71635e-24ab-4de0-7109-08d9fffeebfb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB4710
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
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Melissa Wen <mwen@igalia.com>

FPU operations in dcn10 was already moved to dml folder via calcs code.
However, dcn1_0_ip and dcn_1_0_soc with FPU componentd remains on dcn10.
Following previous changes to isolate FPU, this patch creates dcn10_fpu
files to isolate FPU-specific code and moves those structs to it.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../drm/amd/display/dc/dcn10/dcn10_resource.c |  62 ---------
 .../drm/amd/display/dc/dcn10/dcn10_resource.h |   4 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   2 +
 .../drm/amd/display/dc/dml/dcn10/dcn10_fpu.c  | 123 ++++++++++++++++++
 .../drm/amd/display/dc/dml/dcn10/dcn10_fpu.h  |  30 +++++
 5 files changed, 159 insertions(+), 62 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
index 858b72149897..ac96242cc474 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.c
@@ -70,68 +70,6 @@
 #include "dce/dce_aux.h"
 #include "dce/dce_i2c.h"
 
-const struct _vcs_dpi_ip_params_st dcn1_0_ip = {
-	.rob_buffer_size_kbytes = 64,
-	.det_buffer_size_kbytes = 164,
-	.dpte_buffer_size_in_pte_reqs_luma = 42,
-	.dpp_output_buffer_pixels = 2560,
-	.opp_output_buffer_lines = 1,
-	.pixel_chunk_size_kbytes = 8,
-	.pte_enable = 1,
-	.pte_chunk_size_kbytes = 2,
-	.meta_chunk_size_kbytes = 2,
-	.writeback_chunk_size_kbytes = 2,
-	.line_buffer_size_bits = 589824,
-	.max_line_buffer_lines = 12,
-	.IsLineBufferBppFixed = 0,
-	.LineBufferFixedBpp = -1,
-	.writeback_luma_buffer_size_kbytes = 12,
-	.writeback_chroma_buffer_size_kbytes = 8,
-	.max_num_dpp = 4,
-	.max_num_wb = 2,
-	.max_dchub_pscl_bw_pix_per_clk = 4,
-	.max_pscl_lb_bw_pix_per_clk = 2,
-	.max_lb_vscl_bw_pix_per_clk = 4,
-	.max_vscl_hscl_bw_pix_per_clk = 4,
-	.max_hscl_ratio = 4,
-	.max_vscl_ratio = 4,
-	.hscl_mults = 4,
-	.vscl_mults = 4,
-	.max_hscl_taps = 8,
-	.max_vscl_taps = 8,
-	.dispclk_ramp_margin_percent = 1,
-	.underscan_factor = 1.10,
-	.min_vblank_lines = 14,
-	.dppclk_delay_subtotal = 90,
-	.dispclk_delay_subtotal = 42,
-	.dcfclk_cstate_latency = 10,
-	.max_inter_dcn_tile_repeaters = 8,
-	.can_vstartup_lines_exceed_vsync_plus_back_porch_lines_minus_one = 0,
-	.bug_forcing_LC_req_same_size_fixed = 0,
-};
-
-const struct _vcs_dpi_soc_bounding_box_st dcn1_0_soc = {
-	.sr_exit_time_us = 9.0,
-	.sr_enter_plus_exit_time_us = 11.0,
-	.urgent_latency_us = 4.0,
-	.writeback_latency_us = 12.0,
-	.ideal_dram_bw_after_urgent_percent = 80.0,
-	.max_request_size_bytes = 256,
-	.downspread_percent = 0.5,
-	.dram_page_open_time_ns = 50.0,
-	.dram_rw_turnaround_time_ns = 17.5,
-	.dram_return_buffer_per_channel_bytes = 8192,
-	.round_trip_ping_latency_dcfclk_cycles = 128,
-	.urgent_out_of_order_return_per_channel_bytes = 256,
-	.channel_interleave_bytes = 256,
-	.num_banks = 8,
-	.num_chans = 2,
-	.vmm_page_size_bytes = 4096,
-	.dram_clock_change_latency_us = 17.0,
-	.writeback_dram_clock_change_latency_us = 23.0,
-	.return_bus_width_bytes = 64,
-};
-
 #ifndef mmDP0_DP_DPHY_INTERNAL_CTRL
 	#define mmDP0_DP_DPHY_INTERNAL_CTRL		0x210f
 	#define mmDP0_DP_DPHY_INTERNAL_CTRL_BASE_IDX	2
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.h
index 633025ccb870..bf8e33cd8147 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_resource.h
@@ -27,6 +27,7 @@
 #define __DC_RESOURCE_DCN10_H__
 
 #include "core_types.h"
+#include "dml/dcn10/dcn10_fpu.h"
 
 #define TO_DCN10_RES_POOL(pool)\
 	container_of(pool, struct dcn10_resource_pool, base)
@@ -35,6 +36,9 @@ struct dc;
 struct resource_pool;
 struct _vcs_dpi_display_pipe_params_st;
 
+extern struct _vcs_dpi_ip_params_st dcn1_0_ip;
+extern struct _vcs_dpi_soc_bounding_box_st dcn1_0_soc;
+
 struct dcn10_resource_pool {
 	struct resource_pool base;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 6ab83c3e9c5c..28978ce62f87 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -58,6 +58,7 @@ CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
 
 ifdef CONFIG_DRM_AMD_DC_DCN
 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn10/dcn10_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/dcn20_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn20/display_mode_vba_20.o := $(dml_ccflags)
@@ -106,6 +107,7 @@ DML = calcs/dce_calcs.o calcs/custom_float.o calcs/bw_fixed.o
 
 ifdef CONFIG_DRM_AMD_DC_DCN
 DML += display_mode_lib.o display_rq_dlg_helpers.o dml1_display_rq_dlg_calc.o
+DML += dcn10/dcn10_fpu.o
 DML += dcn20/dcn20_fpu.o
 DML += display_mode_vba.o dcn20/display_rq_dlg_calc_20.o dcn20/display_mode_vba_20.o
 DML += dcn20/display_rq_dlg_calc_20v2.o dcn20/display_mode_vba_20v2.o
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
new file mode 100644
index 000000000000..99644d896222
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.c
@@ -0,0 +1,123 @@
+// SPDX-License-Identifier: MIT
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
+#include "dcn10/dcn10_resource.h"
+
+#include "dcn10_fpu.h"
+
+/**
+ * DOC: DCN10 FPU manipulation Overview
+ *
+ * The DCN architecture relies on FPU operations, which require special
+ * compilation flags and the use of kernel_fpu_begin/end functions; ideally, we
+ * want to avoid spreading FPU access across multiple files. With this idea in
+ * mind, this file aims to centralize DCN10 functions that require FPU access
+ * in a single place. Code in this file follows the following code pattern:
+ *
+ * 1. Functions that use FPU operations should be isolated in static functions.
+ * 2. The FPU functions should have the noinline attribute to ensure anything
+ *    that deals with FP register is contained within this call.
+ * 3. All function that needs to be accessed outside this file requires a
+ *    public interface that not uses any FPU reference.
+ * 4. Developers **must not** use DC_FP_START/END in this file, but they need
+ *    to ensure that the caller invokes it before access any function available
+ *    in this file. For this reason, public functions in this file must invoke
+ *    dc_assert_fp_enabled();
+ *
+ * Let's expand a little bit more the idea in the code pattern. To fully
+ * isolate FPU operations in a single place, we must avoid situations where
+ * compilers spill FP values to registers due to FP enable in a specific C
+ * file. Note that even if we isolate all FPU functions in a single file and
+ * call its interface from other files, the compiler might enable the use of
+ * FPU before we call DC_FP_START. Nevertheless, it is the programmer's
+ * responsibility to invoke DC_FP_START/END in the correct place. To highlight
+ * situations where developers forgot to use the FP protection before calling
+ * the DC FPU interface functions, we introduce a helper that checks if the
+ * function is invoked under FP protection. If not, it will trigger a kernel
+ * warning.
+ */
+
+struct _vcs_dpi_ip_params_st dcn1_0_ip = {
+	.rob_buffer_size_kbytes = 64,
+	.det_buffer_size_kbytes = 164,
+	.dpte_buffer_size_in_pte_reqs_luma = 42,
+	.dpp_output_buffer_pixels = 2560,
+	.opp_output_buffer_lines = 1,
+	.pixel_chunk_size_kbytes = 8,
+	.pte_enable = 1,
+	.pte_chunk_size_kbytes = 2,
+	.meta_chunk_size_kbytes = 2,
+	.writeback_chunk_size_kbytes = 2,
+	.line_buffer_size_bits = 589824,
+	.max_line_buffer_lines = 12,
+	.IsLineBufferBppFixed = 0,
+	.LineBufferFixedBpp = -1,
+	.writeback_luma_buffer_size_kbytes = 12,
+	.writeback_chroma_buffer_size_kbytes = 8,
+	.max_num_dpp = 4,
+	.max_num_wb = 2,
+	.max_dchub_pscl_bw_pix_per_clk = 4,
+	.max_pscl_lb_bw_pix_per_clk = 2,
+	.max_lb_vscl_bw_pix_per_clk = 4,
+	.max_vscl_hscl_bw_pix_per_clk = 4,
+	.max_hscl_ratio = 4,
+	.max_vscl_ratio = 4,
+	.hscl_mults = 4,
+	.vscl_mults = 4,
+	.max_hscl_taps = 8,
+	.max_vscl_taps = 8,
+	.dispclk_ramp_margin_percent = 1,
+	.underscan_factor = 1.10,
+	.min_vblank_lines = 14,
+	.dppclk_delay_subtotal = 90,
+	.dispclk_delay_subtotal = 42,
+	.dcfclk_cstate_latency = 10,
+	.max_inter_dcn_tile_repeaters = 8,
+	.can_vstartup_lines_exceed_vsync_plus_back_porch_lines_minus_one = 0,
+	.bug_forcing_LC_req_same_size_fixed = 0,
+};
+
+struct _vcs_dpi_soc_bounding_box_st dcn1_0_soc = {
+	.sr_exit_time_us = 9.0,
+	.sr_enter_plus_exit_time_us = 11.0,
+	.urgent_latency_us = 4.0,
+	.writeback_latency_us = 12.0,
+	.ideal_dram_bw_after_urgent_percent = 80.0,
+	.max_request_size_bytes = 256,
+	.downspread_percent = 0.5,
+	.dram_page_open_time_ns = 50.0,
+	.dram_rw_turnaround_time_ns = 17.5,
+	.dram_return_buffer_per_channel_bytes = 8192,
+	.round_trip_ping_latency_dcfclk_cycles = 128,
+	.urgent_out_of_order_return_per_channel_bytes = 256,
+	.channel_interleave_bytes = 256,
+	.num_banks = 8,
+	.num_chans = 2,
+	.vmm_page_size_bytes = 4096,
+	.dram_clock_change_latency_us = 17.0,
+	.writeback_dram_clock_change_latency_us = 23.0,
+	.return_bus_width_bytes = 64,
+};
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h
new file mode 100644
index 000000000000..e74ed4b4ce5b
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn10/dcn10_fpu.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: MIT */
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
+#ifndef __DCN10_FPU_H__
+#define __DCN10_FPU_H__
+
+#endif /* __DCN20_FPU_H__ */
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BEC0EE49B2
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:52:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2DA110E457;
	Wed, 23 Aug 2023 15:52:00 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2062.outbound.protection.outlook.com [40.107.243.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A44710E43B
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYhDAsLJPOyqrZJmkeidwQso6bNNp0arQ5219X6OSFtVItkmYzm0rqbpaizpTrUXMVlNgCKlKOlUiUTbua05hdYcmFk9ipXvGqTrPSzriHAeDmf5grzSPNsikpKGpkLm/DU3ldbiqNOQjifcIjIeeAAC5iXiImnkx5iU7ofTKTue78L4h3kfgoSHVaHH4TPLAdD2WvXvA8GcipIcq59w0B1EWNOsN5Blt8fxTK7ZbiG0is7GJIV9W5xx+QcOjJDeEH8tWXYdctrJ5ZkvDCzPd0Q1Wqx9yw49tkbOMxFrKZIPZoM5rEa7Sv3PsgPmLNsHQHoRNMj0xSIEzSO1wPyk7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2puZYysRSzgZZy1O8gt2/Lvp+6g7ZoR3vMrTKMEzBwA=;
 b=nXavqLEg4a7UXUo4GkauWRtbpb94iWO0SlWYLLRX52zBypu5H/Cu/MmTztZ0/DS/JSKC8ivPIN15dbd2n7MA67R9WoiInMQ9aAMK4wStfqikHrpE6MakkRCkbFNE71jaI51Nsp0BIuk1K5j8jxdKlPdVIueUtQ9Kad7N9gGQS79q1y9bxSpd/ItPjkgBkVQpNFISUSZfgN2q55r61tmyw9kSAa4un5knANx4z8j9nUHvuvHFZ7gDLkvh9nJnPu6u1Jlzn9sV9522ibxES4MeKev2VqV/DfZC7FhaNKCTopYk/BhipBW4+Jcex2fMXqqHsmsV9hZ4JgSVu8GvB2bawQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2puZYysRSzgZZy1O8gt2/Lvp+6g7ZoR3vMrTKMEzBwA=;
 b=SSG8t14ncYNY4rjoqd8EGeAVqsBNywz0xdt3P4NQD9MgWC3rD+RHounHc/pbl4wDC+ds/Hh/j7NvOcWgryQb7mHgz5W++s12Tm8QaaI4g2fhQFjbM1lRxuEiIfgo/PEw3Lm9PY9A44Ifs6O2KxKHBqmNUW0YYb4dZVBepnwQooY=
Received: from DM6PR11CA0042.namprd11.prod.outlook.com (2603:10b6:5:14c::19)
 by CH2PR12MB4087.namprd12.prod.outlook.com (2603:10b6:610:7f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Wed, 23 Aug
 2023 15:51:28 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:5:14c:cafe::40) by DM6PR11CA0042.outlook.office365.com
 (2603:10b6:5:14c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:27 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:22 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 31/35] drm/amd/display: Add DCN35 DML
Date: Wed, 23 Aug 2023 11:50:44 -0400
Message-ID: <20230823155048.2526343-31-alexander.deucher@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823155048.2526343-1-alexander.deucher@amd.com>
References: <20230823155048.2526343-1-alexander.deucher@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|CH2PR12MB4087:EE_
X-MS-Office365-Filtering-Correlation-Id: de1afd91-a78a-4da2-2b98-08dba3f0cfd1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9JD4A1nTd6fnYp1K/ZLHLduARh8EWSugLhz2BeRENJolcn4h+0KFMf/8Al8uCnwoBTQMKQ4GrF392D565f9/3QfTfyOUFnvjVMFORYRRAd5rWNJclLKJxc89z2EpILglckccGY+JGW5WLagcnIw+2gzUac2tjmXtIjYTHcbX8Pumio7RKgYZC203n8tD2oKd/RMpvBmwowyXn4vA4BNT+Bw2s4EQ2D4odqTcqOe6Nw5kqlvvP8HwaRgwPByd8pW/1Y6H1nKXhdC0o32xl/iyYTykjyNgHrFwO4M6zqcDumDhIxbd/fptz9jIX+qrMsIYNe90qxf46nsRXGuOnnP4k69HKaWHYKCY+iKw/kyEmY/e06q1Uy1yjcQig45FLDBMcEoK5pTHWHn1nhagBeZhFGwQnL0jYywTgdvfIBXF7HoyZq4ZTFYeR4p8ijQypfGUhT1XTUK4+fgimnXamkErRZ7F5OkQrGlsOaMFFP1SZhiHGB6kw4OzwZ9A6GIlB6K7GM7FSNrNacP3UyxNeHTD139AUy+Alk3KDc9NxuNCcfjbjSkgtUuRO42WtpQF83feaWhiVGLB/4QscuBS/Gn8a+kY4p5JlnhvSR31XrJS2s7h9P6NdOfLZ5M5DicV/I7i6zYdbg/zY3bBtHJUwoK/IoDa1xOOILLAGpuLX4+A6ESFM3pO87fZtCnx6uZrgCKm6UwFh+N/NQe6CeJ2HvHdpnE7qz5TSbvLr3Q+GckjWuwJ8U+nVVb5dXEAc1GlHhjl2p/EqzftA2Ao+zAooL8sBA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(136003)(346002)(39860400002)(186009)(1800799009)(451199024)(82310400011)(40470700004)(46966006)(36840700001)(54906003)(6916009)(316002)(70586007)(70206006)(66899024)(8676002)(8936002)(2616005)(4326008)(36756003)(40460700003)(41300700001)(1076003)(356005)(82740400003)(81166007)(478600001)(6666004)(40480700001)(83380400001)(30864003)(2906002)(47076005)(7696005)(36860700001)(86362001)(426003)(336012)(5660300002)(26005)(16526019)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:27.6190 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de1afd91-a78a-4da2-2b98-08dba3f0cfd1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4087
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
Cc: Alex Deucher <alexander.deucher@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>, Harry Wentland <Harry.Wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>

[Why & How]
Add DML handling for DCN35.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   3 +
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.c  | 484 ++++++++++++++++++
 .../drm/amd/display/dc/dml/dcn35/dcn35_fpu.h  |  44 ++
 3 files changed, 531 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.h

diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 77cf5545c94c..b06c3983af36 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -87,6 +87,7 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn32/display_mode_vba_32.o := $(dml_ccflags) $(fram
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn32/display_rq_dlg_calc_32.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn32/display_mode_vba_util_32.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn321/dcn321_fpu.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn35/dcn35_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/dcn31_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn302/dcn302_fpu.o := $(dml_ccflags)
@@ -120,6 +121,7 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn314/dcn314_fpu.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/dcn30_fpu.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn32/dcn32_fpu.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn321/dcn321_fpu.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn35/dcn35_fpu.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/dcn31_fpu.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn302/dcn302_fpu.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn303/dcn303_fpu.o := $(dml_rcflags)
@@ -152,6 +154,7 @@ DML += dcn301/dcn301_fpu.o
 DML += dcn302/dcn302_fpu.o
 DML += dcn303/dcn303_fpu.o
 DML += dcn314/dcn314_fpu.o
+DML += dcn35/dcn35_fpu.o
 DML += dsc/rc_calc_fpu.o
 DML += calcs/dcn_calcs.o calcs/dcn_calc_math.o calcs/dcn_calc_auto.o
 endif
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
new file mode 100644
index 000000000000..525ca0ed9ea9
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.c
@@ -0,0 +1,484 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+#include "dcn35_fpu.h"
+#include "dcn31/dcn31_resource.h"
+#include "dcn32/dcn32_resource.h"
+#include "dcn35/dcn35_resource.h"
+#include "dml/dcn31/dcn31_fpu.h"
+
+#include "link.h"
+
+#define DC_LOGGER_INIT(logger)
+
+struct _vcs_dpi_ip_params_st dcn3_5_ip = {
+	.VBlankNomDefaultUS = 668,
+	.gpuvm_enable = 1,
+	.gpuvm_max_page_table_levels = 1,
+	.hostvm_enable = 1,
+	.hostvm_max_page_table_levels = 2,
+	.rob_buffer_size_kbytes = 64,
+	.det_buffer_size_kbytes = 1536,
+	.config_return_buffer_size_in_kbytes = 1792,
+	.compressed_buffer_segment_size_in_kbytes = 64,
+	.meta_fifo_size_in_kentries = 32,
+	.zero_size_buffer_entries = 512,
+	.compbuf_reserved_space_64b = 256,
+	.compbuf_reserved_space_zs = 64,
+	.dpp_output_buffer_pixels = 2560,/*not used*/
+	.opp_output_buffer_lines = 1,/*not used*/
+	.pixel_chunk_size_kbytes = 8,
+	//.alpha_pixel_chunk_size_kbytes = 4;/*new*/
+	//.min_pixel_chunk_size_bytes = 1024;/*new*/
+	.meta_chunk_size_kbytes = 2,
+	.min_meta_chunk_size_bytes = 256,
+	.writeback_chunk_size_kbytes = 8,
+	.ptoi_supported = false,
+	.num_dsc = 4,
+	.maximum_dsc_bits_per_component = 12,/*delta from 10*/
+	.dsc422_native_support = true,/*delta from false*/
+	.is_line_buffer_bpp_fixed = true,/*new*/
+	.line_buffer_fixed_bpp = 32,/*delta from 48*/
+	.line_buffer_size_bits = 986880,/*delta from 789504*/
+	.max_line_buffer_lines = 32,/*delta from 12*/
+	.writeback_interface_buffer_size_kbytes = 90,
+	.max_num_dpp = 4,
+	.max_num_otg = 4,
+	.max_num_hdmi_frl_outputs = 1,
+	.max_num_wb = 1,
+	/*.max_num_hdmi_frl_outputs = 1; new in dml2*/
+	/*.max_num_dp2p0_outputs = 2; new in dml2*/
+	/*.max_num_dp2p0_streams = 4; new in dml2*/
+	.max_dchub_pscl_bw_pix_per_clk = 4,
+	.max_pscl_lb_bw_pix_per_clk = 2,
+	.max_lb_vscl_bw_pix_per_clk = 4,
+	.max_vscl_hscl_bw_pix_per_clk = 4,
+	.max_hscl_ratio = 6,
+	.max_vscl_ratio = 6,
+	.max_hscl_taps = 8,
+	.max_vscl_taps = 8,
+	.dpte_buffer_size_in_pte_reqs_luma = 68,/*changed from 64,*/
+	.dpte_buffer_size_in_pte_reqs_chroma = 36,/*changed from 34*/
+	/*.dcc_meta_buffer_size_bytes = 6272; new to dml2*/
+	.dispclk_ramp_margin_percent = 1.11,/*delta from 1*/
+	/*.dppclk_delay_subtotal = 47;
+	.dppclk_delay_scl = 50;
+	.dppclk_delay_scl_lb_only = 16;
+	.dppclk_delay_cnvc_formatter = 28;
+	.dppclk_delay_cnvc_cursor = 6;
+	.dispclk_delay_subtotal = 125;*/ /*new to dml2*/
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
+	.dppclk_delay_subtotal = 47, /* changed from 46,*/
+	.dppclk_delay_scl = 50,
+	.dppclk_delay_scl_lb_only = 16,
+	.dppclk_delay_cnvc_formatter = 28,/*changed from 27,*/
+	.dppclk_delay_cnvc_cursor = 6,
+	.dispclk_delay_subtotal = 125, /*changed from 119,*/
+	.dynamic_metadata_vm_enabled = false,
+	.odm_combine_4to1_supported = false,
+	.dcc_supported = true,
+//	.config_return_buffer_segment_size_in_kbytes = 64;/*required, hard coded in dml2_translate_ip_params*/
+
+};
+
+struct _vcs_dpi_soc_bounding_box_st dcn3_5_soc = {
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
+	.sr_exit_z8_time_us = 50.0, /*changed from 442.0*/
+	.sr_enter_plus_exit_z8_time_us = 50.0,/*changed from 560.0*/
+	.fclk_change_latency_us = 20.0,
+	.usr_retraining_latency_us = 2,
+	.writeback_latency_us = 12.0,
+
+	.dram_channel_width_bytes = 4,/*not exist in dml2*/
+	.round_trip_ping_latency_dcfclk_cycles = 106,/*not exist in dml2*/
+	.urgent_latency_pixel_data_only_us = 4.0,
+	.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
+	.urgent_latency_vm_data_only_us = 4.0,
+	.dram_clock_change_latency_us = 11.72,
+	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
+	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
+	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
+
+	.pct_ideal_sdp_bw_after_urgent = 80.0,
+	.pct_ideal_fabric_bw_after_urgent = 80.0, /*new to dml2*/
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
+	.do_urgent_latency_adjustment = 0,
+	.urgent_latency_adjustment_fabric_clock_component_us = 0,
+	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
+};
+
+void dcn35_build_wm_range_table_fpu(struct clk_mgr *clk_mgr)
+{
+	//TODO
+}
+
+void dcn35_patch_dpm_table(struct clk_bw_params *bw_params)
+{
+	int i;
+	unsigned int max_dcfclk_mhz = 0, max_dispclk_mhz = 0, max_dppclk_mhz = 0,
+			max_phyclk_mhz = 0, max_dtbclk_mhz = 0, max_fclk_mhz = 0, max_uclk_mhz = 0;
+
+	for (i = 0; i < MAX_NUM_DPM_LVL; i++) {
+		if (bw_params->clk_table.entries[i].dcfclk_mhz > max_dcfclk_mhz)
+			max_dcfclk_mhz = bw_params->clk_table.entries[i].dcfclk_mhz;
+		if (bw_params->clk_table.entries[i].fclk_mhz > max_fclk_mhz)
+			max_fclk_mhz = bw_params->clk_table.entries[i].fclk_mhz;
+		if (bw_params->clk_table.entries[i].memclk_mhz > max_uclk_mhz)
+			max_uclk_mhz = bw_params->clk_table.entries[i].memclk_mhz;
+		if (bw_params->clk_table.entries[i].dispclk_mhz > max_dispclk_mhz)
+			max_dispclk_mhz = bw_params->clk_table.entries[i].dispclk_mhz;
+		if (bw_params->clk_table.entries[i].dppclk_mhz > max_dppclk_mhz)
+			max_dppclk_mhz = bw_params->clk_table.entries[i].dppclk_mhz;
+		if (bw_params->clk_table.entries[i].phyclk_mhz > max_phyclk_mhz)
+			max_phyclk_mhz = bw_params->clk_table.entries[i].phyclk_mhz;
+		if (bw_params->clk_table.entries[i].dtbclk_mhz > max_dtbclk_mhz)
+			max_dtbclk_mhz = bw_params->clk_table.entries[i].dtbclk_mhz;
+	}
+}
+/*
+ * dcn35_update_bw_bounding_box
+ *
+ * This would override some dcn3_5 ip_or_soc initial parameters hardcoded from
+ * spreadsheet with actual values as per dGPU SKU:
+ * - with passed few options from dc->config
+ * - with dentist_vco_frequency from Clk Mgr (currently hardcoded, but might
+ *   need to get it from PM FW)
+ * - with passed latency values (passed in ns units) in dc-> bb override for
+ *   debugging purposes
+ * - with passed latencies from VBIOS (in 100_ns units) if available for
+ *   certain dGPU SKU
+ * - with number of DRAM channels from VBIOS (which differ for certain dGPU SKU
+ *   of the same ASIC)
+ * - clocks levels with passed clk_table entries from Clk Mgr as reported by PM
+ *   FW for different clocks (which might differ for certain dGPU SKU of the
+ *   same ASIC)
+ */
+void dcn35_update_bw_bounding_box_fpu(struct dc *dc,
+				      struct clk_bw_params *bw_params)
+{
+	unsigned int i, closest_clk_lvl;
+	int j;
+	struct clk_limit_table *clk_table = &bw_params->clk_table;
+	struct _vcs_dpi_voltage_scaling_st *clock_limits =
+		dc->scratch.update_bw_bounding_box.clock_limits;
+	int max_dispclk_mhz = 0, max_dppclk_mhz = 0;
+
+	dc_assert_fp_enabled();
+
+		dcn3_5_ip.max_num_otg =
+			dc->res_pool->res_cap->num_timing_generator;
+		dcn3_5_ip.max_num_dpp = dc->res_pool->pipe_count;
+		dcn3_5_soc.num_chans = bw_params->num_channels;
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
+			for (closest_clk_lvl = 0, j = dcn3_5_soc.num_states - 1;
+			     j >= 0; j--) {
+				if (dcn3_5_soc.clock_limits[j].dcfclk_mhz <=
+				    clk_table->entries[i].dcfclk_mhz) {
+					closest_clk_lvl = j;
+					break;
+				}
+			}
+			if (clk_table->num_entries == 1) {
+				/*smu gives one DPM level, let's take the highest one*/
+				closest_clk_lvl = dcn3_5_soc.num_states - 1;
+			}
+
+			clock_limits[i].state = i;
+
+			/* Clocks dependent on voltage level. */
+			clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
+			if (clk_table->num_entries == 1 &&
+			    clock_limits[i].dcfclk_mhz <
+			    dcn3_5_soc.clock_limits[closest_clk_lvl].dcfclk_mhz) {
+				/*SMU fix not released yet*/
+				clock_limits[i].dcfclk_mhz =
+					dcn3_5_soc.clock_limits[closest_clk_lvl].dcfclk_mhz;
+			}
+
+			clock_limits[i].fabricclk_mhz =
+				clk_table->entries[i].fclk_mhz;
+			clock_limits[i].socclk_mhz =
+				clk_table->entries[i].socclk_mhz;
+
+			if (clk_table->entries[i].memclk_mhz &&
+			    clk_table->entries[i].wck_ratio)
+				clock_limits[i].dram_speed_mts =
+					clk_table->entries[i].memclk_mhz * 2 *
+					clk_table->entries[i].wck_ratio;
+
+			/* Clocks independent of voltage level. */
+			clock_limits[i].dispclk_mhz = max_dispclk_mhz ?
+				max_dispclk_mhz :
+				dcn3_5_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
+
+			clock_limits[i].dppclk_mhz = max_dppclk_mhz ?
+				max_dppclk_mhz :
+				dcn3_5_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
+
+			clock_limits[i].dram_bw_per_chan_gbps =
+				dcn3_5_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
+			clock_limits[i].dscclk_mhz =
+				dcn3_5_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
+			clock_limits[i].dtbclk_mhz =
+				dcn3_5_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
+			clock_limits[i].phyclk_d18_mhz =
+				dcn3_5_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
+			clock_limits[i].phyclk_mhz =
+				dcn3_5_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
+		}
+
+		memcpy(dcn3_5_soc.clock_limits, clock_limits,
+		       sizeof(dcn3_5_soc.clock_limits));
+
+		if (clk_table->num_entries)
+			dcn3_5_soc.num_states = clk_table->num_entries;
+
+	if (max_dispclk_mhz) {
+		dcn3_5_soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
+		dc->dml.soc.dispclk_dppclk_vco_speed_mhz = max_dispclk_mhz * 2;
+	}
+	if ((int)(dcn3_5_soc.dram_clock_change_latency_us * 1000)
+				!= dc->debug.dram_clock_change_latency_ns
+			&& dc->debug.dram_clock_change_latency_ns) {
+		dcn3_5_soc.dram_clock_change_latency_us =
+			dc->debug.dram_clock_change_latency_ns / 1000.0;
+	}
+	/*temp till dml2 fully work without dml1*/
+		dml_init_instance(&dc->dml, &dcn3_5_soc, &dcn3_5_ip,
+				  DML_PROJECT_DCN31);
+}
+
+static bool is_dual_plane(enum surface_pixel_format format)
+{
+	return format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN ||
+		format == SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA;
+}
+
+int dcn35_populate_dml_pipes_from_context_fpu(struct dc *dc,
+					      struct dc_state *context,
+					      display_e2e_pipe_params_st *pipes,
+					      bool fast_validate)
+{
+	int i, pipe_cnt;
+	struct resource_context *res_ctx = &context->res_ctx;
+	struct pipe_ctx *pipe;
+	bool upscaled = false;
+
+	dcn31_populate_dml_pipes_from_context(dc, context, pipes,
+					      fast_validate);
+
+	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
+		struct dc_crtc_timing *timing;
+
+		if (!res_ctx->pipe_ctx[i].stream)
+			continue;
+
+		pipe = &res_ctx->pipe_ctx[i];
+		timing = &pipe->stream->timing;
+
+		if (pipe->stream->adjust.v_total_max ==
+		    pipe->stream->adjust.v_total_min &&
+		    pipe->stream->adjust.v_total_min > timing->v_total) {
+			pipes[pipe_cnt].pipe.dest.vtotal =
+				pipe->stream->adjust.v_total_min;
+			pipes[pipe_cnt].pipe.dest.vblank_nom = timing->v_total -
+				pipes[pipe_cnt].pipe.dest.vactive;
+		}
+
+		if (pipe->plane_state &&
+		    (pipe->plane_state->src_rect.height <
+		     pipe->plane_state->dst_rect.height ||
+		     pipe->plane_state->src_rect.width <
+		     pipe->plane_state->dst_rect.width))
+			upscaled = true;
+
+		/*
+		 * Immediate flip can be set dynamically after enabling the
+		 * plane. We need to require support for immediate flip or
+		 * underflow can be intermittently experienced depending on peak
+		 * b/w requirements.
+		 */
+		pipes[pipe_cnt].pipe.src.immediate_flip = true;
+
+		pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
+
+		DC_FP_START();
+		dcn31_zero_pipe_dcc_fraction(pipes, pipe_cnt);
+		DC_FP_END();
+
+		pipes[pipe_cnt].pipe.dest.vfront_porch = timing->v_front_porch;
+		pipes[pipe_cnt].pipe.src.dcc_rate = 3;
+		pipes[pipe_cnt].dout.dsc_input_bpc = 0;
+		pipes[pipe_cnt].pipe.src.gpuvm_min_page_size_kbytes = 256;
+
+		if (pipes[pipe_cnt].dout.dsc_enable) {
+			switch (timing->display_color_depth) {
+			case COLOR_DEPTH_888:
+				pipes[pipe_cnt].dout.dsc_input_bpc = 8;
+				break;
+			case COLOR_DEPTH_101010:
+				pipes[pipe_cnt].dout.dsc_input_bpc = 10;
+				break;
+			case COLOR_DEPTH_121212:
+				pipes[pipe_cnt].dout.dsc_input_bpc = 12;
+				break;
+			default:
+				ASSERT(0);
+				break;
+			}
+		}
+
+		pipe_cnt++;
+	}
+
+	context->bw_ctx.dml.ip.det_buffer_size_kbytes = 384;/*per guide*/
+	dc->config.enable_4to1MPC = false;
+
+	if (pipe_cnt == 1 && pipe->plane_state && !dc->debug.disable_z9_mpc) {
+		if (is_dual_plane(pipe->plane_state->format)
+				&& pipe->plane_state->src_rect.width <= 1920 &&
+				pipe->plane_state->src_rect.height <= 1080) {
+			dc->config.enable_4to1MPC = true;
+		} else if (!is_dual_plane(pipe->plane_state->format) &&
+			   pipe->plane_state->src_rect.width <= 5120) {
+			/*
+			 * Limit to 5k max to avoid forced pipe split when there
+			 * is not enough detile for swath
+			 */
+			context->bw_ctx.dml.ip.det_buffer_size_kbytes = 192;
+			pipes[0].pipe.src.unbounded_req_mode = true;
+		}
+	} else if (context->stream_count >=
+		   dc->debug.crb_alloc_policy_min_disp_count &&
+		   dc->debug.crb_alloc_policy > DET_SIZE_DEFAULT) {
+		context->bw_ctx.dml.ip.det_buffer_size_kbytes =
+			dc->debug.crb_alloc_policy * 64;
+	} else if (context->stream_count >= 3 && upscaled) {
+		context->bw_ctx.dml.ip.det_buffer_size_kbytes = 192;
+	}
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe->stream)
+			continue;
+
+		if (pipe->stream->signal == SIGNAL_TYPE_EDP &&
+		    dc->debug.seamless_boot_odm_combine &&
+		    pipe->stream->apply_seamless_boot_optimization) {
+
+			if (pipe->stream->apply_boot_odm_mode ==
+			    dm_odm_combine_policy_2to1) {
+				context->bw_ctx.dml.vba.ODMCombinePolicy =
+					dm_odm_combine_policy_2to1;
+				break;
+			}
+		}
+	}
+
+	return pipe_cnt;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.h
new file mode 100644
index 000000000000..b122ffdcc30a
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn35/dcn35_fpu.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: MIT */
+/*
+ * Copyright 2023 Advanced Micro Devices, Inc.
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
+#ifndef __DCN35_FPU_H__
+#define __DCN35_FPU_H__
+
+#include "clk_mgr.h"
+
+void dcn35_build_wm_range_table_fpu(struct clk_mgr *clk_mgr);
+
+void dcn35_update_bw_bounding_box_fpu(struct dc *dc,
+				      struct clk_bw_params *bw_params);
+
+void dcn35_patch_dpm_table(struct clk_bw_params *bw_params);
+
+int dcn35_populate_dml_pipes_from_context_fpu(struct dc *dc,
+					      struct dc_state *context,
+					      display_e2e_pipe_params_st *pipes,
+					      bool fast_validate);
+
+#endif
-- 
2.41.0


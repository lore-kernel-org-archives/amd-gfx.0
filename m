Return-Path: <SRS0=XefO=O2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C00C433F5
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 09:57:11 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6852F610A2
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Oct 2021 09:57:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6852F610A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE8CB6ED8F;
	Wed,  6 Oct 2021 09:57:10 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2049.outbound.protection.outlook.com [40.107.92.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0848F6ED8F
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Oct 2021 09:57:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BzF8TzbFzof6SjzjDhNqZqT28dmwX8ZOfyoTrUzT0Qvt5dKzlDfbkFmQhlbN2iZ1OIqIy6gKJ2VLtws8TQwbolslyxFuagwg7tKHiDHTgsT5j2uzeL6/mfmbli7LYh+SjNnuDA3twiazq0ZcnAMPtpY/KToeCH5HsNPoLy7PccKFbqluJPv84Klhy42Wqgpikm9bFfrw2PYyJfw7eyiooxTVXZNTisAJwzrIsEYq85H533PeXW1AXQx86UIegpvqB1zc6YiV+CER4puZPXxSD42QMzV8oaUgK3qW3cKWa6GqJb+Btey0xXiwlp8+QU1MqV9/lM4SmsC9XNfr8eUCCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FnGgyFTG5O8BMafdks6y2ZaVhKCLVuGwB5clDO8gAdU=;
 b=XqLp6noHWdc/sHab+SndC/EH0vL6XwU9lIuWUKENkc/0c7KijW6sUVuMf86LLm+X3lr49NUayN6WnTu+bGlexSa2AJGES4i6xQqK+7/GGwKh5pMAWzfwJDasgaL6+90NQXf7+z2OCBLfFq13l/umlYpM/vSTlx5pL3zWfFKkys433mbPIamRQoz5D3VfT/NwaDJPi19DBw8y5VupCap52j8C5lwZQLj9kood19igL+5St1Ijbaiyk70Oyp2yRaqjJxkh7RHrBGJzvFneGOmahsodGbqonxHoTRpRpy8YBGRf7PftDyhpp3Vf57Vx2CJcrQJllnnFF1SZWpkb8oFxkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FnGgyFTG5O8BMafdks6y2ZaVhKCLVuGwB5clDO8gAdU=;
 b=cAPppcXRdLxnZ/t9hHatnKMUbuKO+d7xJXXZSeJNh47J8o6JJxLvlnm3VB3EgOQC/l4JED4CVBp7qEs7iVivvYcoVc7X5+qXr8SCs64fKUEip2M3UarMJQEqRix2hc9SIROKI6ZDskIXOtyT+BcRh073NxBYJWDhADRCMTA8Hf4=
Received: from BN8PR04CA0030.namprd04.prod.outlook.com (2603:10b6:408:70::43)
 by DM6PR12MB4233.namprd12.prod.outlook.com (2603:10b6:5:210::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.21; Wed, 6 Oct
 2021 09:57:05 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:70:cafe::11) by BN8PR04CA0030.outlook.office365.com
 (2603:10b6:408:70::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.17 via Frontend
 Transport; Wed, 6 Oct 2021 09:57:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4587.18 via Frontend Transport; Wed, 6 Oct 2021 09:57:04 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 6 Oct 2021
 04:57:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Wed, 6 Oct 2021
 02:57:03 -0700
Received: from linux-ci-node.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2308.8 via Frontend
 Transport; Wed, 6 Oct 2021 04:57:01 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Qingqing Zhuo <Qingqing.Zhuo@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 "Rodrigo Siqueira" <Rodrigo.Siqueira@amd.com>, Zhan Liu <Zhan.Liu@amd.com>
Subject: [PATCH] drm/amd/display: move FPU associated DCN301 code to DML folder
Date: Wed, 6 Oct 2021 17:56:55 +0800
Message-ID: <20211006095655.343983-1-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 860d4c76-d3e8-4652-0bb3-08d988afa696
X-MS-TrafficTypeDiagnostic: DM6PR12MB4233:
X-Microsoft-Antispam-PRVS: <DM6PR12MB42332BA2C593655294AE6B5CFBB09@DM6PR12MB4233.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fjjBg4AZGOzbaNL2eXYNLqWFEvkkAQAp2Md03P58d6w3qYYW9pPzbwigudQ6zdcp/GPnLs8jXnkrMYWcOrC44QcagHfx3Yc+0cbI5dMidZLasC8DYiM3IvIaiBZNlAoYxVyJhUVQP8B0Aqttsht4aiyRtR8zN2wIIwwtfWUbAahZ7ecXyq1qYt2BlgUFV8auy5x3M9IZGv2hEM0n+j6rAIrwRzWDSlRWJNjdDOqw1kavs7pkG4Retpv+u9ytH47FdwESBOED1XfwtPJeJyWVEoDiWbXL2tcixDN3gODdwLXavzSeFolk3ST3Y4xD4iTWNiTTU+H45db6zVu7H+2qPH7CY25pLsGkKHpsUwTMTh8+Dahe41fUYNBNzJrpZoTddnZtFQGUwFhcrT6fng9mGF+UFzw6Dmoiq417GwGdCAFZmRFLo815Vxr5RqHzh5u8o9qDqHDKD2u1oLZo3x0+CcDXwwyyd8509MUbh9nC/xXf0p10G4IQ3C51EStQttnv03I3kdL5kHzug5ZBp+S2TFgMn2LecOzUBqPb7KJUFOk7UxbSaDgAFKnj0GaVDOMW+N2T9ezi285lh0UhyPdwG/ZeV75fPX/OAERHJt50RxFiZN8CBKQGOoOtAdTOCU8yHrGQTw8Oet6vHZTm8iCzQ9IRr6Qb6xzIN3OUElW3+z00JeMhYMXbvSDpAvyv8nit7m3QCXyzaXAI+OAFNuZpQ6Z2K3CUghQ/NgkBQa9LIZg=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(46966006)(36840700001)(70206006)(336012)(30864003)(8936002)(7696005)(26005)(186003)(2906002)(8676002)(6916009)(70586007)(36756003)(83380400001)(4326008)(2616005)(81166007)(426003)(66574015)(356005)(6666004)(508600001)(966005)(86362001)(47076005)(316002)(82310400003)(36860700001)(54906003)(1076003)(5660300002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2021 09:57:04.4711 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 860d4c76-d3e8-4652-0bb3-08d988afa696
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4233
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

[Why & How]
As part of the FPU isolation work documented in
https://patchwork.freedesktop.org/series/93042/, isolate
code that uses FPU in DCN301 to DML, where all FPU code
should locate.

Cc: Christian König <christian.koenig@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Tested-by: Zhan Liu <Zhan.Liu@amd.com>
Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
---
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |   2 +
 .../gpu/drm/amd/display/dc/dcn301/Makefile    |  26 --
 .../amd/display/dc/dcn301/dcn301_resource.c   | 349 +---------------
 .../amd/display/dc/dcn301/dcn301_resource.h   |   3 +
 drivers/gpu/drm/amd/display/dc/dml/Makefile   |   3 +
 .../amd/display/dc/dml/dcn301/dcn301_fpu.c    | 390 ++++++++++++++++++
 .../amd/display/dc/dml/dcn301/dcn301_fpu.h    |  42 ++
 7 files changed, 450 insertions(+), 365 deletions(-)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 3a8a3214f770..dc9fa31f8d6c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2323,7 +2323,9 @@ bool dcn30_validate_bandwidth(struct dc *dc,
 		goto validate_out;
 	}
 
+	DC_FP_START();
 	dc->res_pool->funcs->calculate_wm_and_dlg(dc, context, pipes, pipe_cnt, vlevel);
+	DC_FP_END();
 
 	BW_VAL_TRACE_END_WATERMARKS();
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
index 09264716d1dc..7aa628c21973 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/Makefile
@@ -13,32 +13,6 @@
 DCN301 = dcn301_init.o dcn301_resource.o dcn301_dccg.o \
 		dcn301_dio_link_encoder.o dcn301_hwseq.o dcn301_panel_cntl.o dcn301_hubbub.o
 
-ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn301/dcn301_resource.o := -msse
-endif
-
-ifdef CONFIG_PPC64
-CFLAGS_$(AMDDALPATH)/dc/dcn301/dcn301_resource.o := -mhard-float -maltivec
-endif
-
-ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
-IS_OLD_GCC = 1
-endif
-CFLAGS_$(AMDDALPATH)/dc/dcn301/dcn301_resource.o += -mhard-float
-endif
-
-ifdef CONFIG_X86
-ifdef IS_OLD_GCC
-# Stack alignment mismatch, proceed with caution.
-# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
-# (8B stack alignment).
-CFLAGS_$(AMDDALPATH)/dc/dcn301/dcn301_resource.o += -mpreferred-stack-boundary=4
-else
-CFLAGS_$(AMDDALPATH)/dc/dcn301/dcn301_resource.o += -msse2
-endif
-endif
-
 AMD_DAL_DCN301 = $(addprefix $(AMDDALPATH)/dc/dcn301/,$(DCN301))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DCN301)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
index 5350c93d7772..fbaa03f26d8b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.c
@@ -82,6 +82,7 @@
 #include "dce/dce_i2c.h"
 
 #include "dml/dcn30/display_mode_vba_30.h"
+#include "dml/dcn301/dcn301_fpu.h"
 #include "vm_helper.h"
 #include "dcn20/dcn20_vmid.h"
 #include "amdgpu_socbb.h"
@@ -91,184 +92,6 @@
 
 #define DC_LOGGER_INIT(logger)
 
-struct _vcs_dpi_ip_params_st dcn3_01_ip = {
-	.odm_capable = 1,
-	.gpuvm_enable = 1,
-	.hostvm_enable = 1,
-	.gpuvm_max_page_table_levels = 1,
-	.hostvm_max_page_table_levels = 2,
-	.hostvm_cached_page_table_levels = 0,
-	.pte_group_size_bytes = 2048,
-	.num_dsc = 3,
-	.rob_buffer_size_kbytes = 184,
-	.det_buffer_size_kbytes = 184,
-	.dpte_buffer_size_in_pte_reqs_luma = 64,
-	.dpte_buffer_size_in_pte_reqs_chroma = 32,
-	.pde_proc_buffer_size_64k_reqs = 48,
-	.dpp_output_buffer_pixels = 2560,
-	.opp_output_buffer_lines = 1,
-	.pixel_chunk_size_kbytes = 8,
-	.meta_chunk_size_kbytes = 2,
-	.writeback_chunk_size_kbytes = 8,
-	.line_buffer_size_bits = 789504,
-	.is_line_buffer_bpp_fixed = 0,  // ?
-	.line_buffer_fixed_bpp = 48,     // ?
-	.dcc_supported = true,
-	.writeback_interface_buffer_size_kbytes = 90,
-	.writeback_line_buffer_buffer_size = 656640,
-	.max_line_buffer_lines = 12,
-	.writeback_luma_buffer_size_kbytes = 12,  // writeback_line_buffer_buffer_size = 656640
-	.writeback_chroma_buffer_size_kbytes = 8,
-	.writeback_chroma_line_buffer_width_pixels = 4,
-	.writeback_max_hscl_ratio = 1,
-	.writeback_max_vscl_ratio = 1,
-	.writeback_min_hscl_ratio = 1,
-	.writeback_min_vscl_ratio = 1,
-	.writeback_max_hscl_taps = 1,
-	.writeback_max_vscl_taps = 1,
-	.writeback_line_buffer_luma_buffer_size = 0,
-	.writeback_line_buffer_chroma_buffer_size = 14643,
-	.cursor_buffer_size = 8,
-	.cursor_chunk_size = 2,
-	.max_num_otg = 4,
-	.max_num_dpp = 4,
-	.max_num_wb = 1,
-	.max_dchub_pscl_bw_pix_per_clk = 4,
-	.max_pscl_lb_bw_pix_per_clk = 2,
-	.max_lb_vscl_bw_pix_per_clk = 4,
-	.max_vscl_hscl_bw_pix_per_clk = 4,
-	.max_hscl_ratio = 6,
-	.max_vscl_ratio = 6,
-	.hscl_mults = 4,
-	.vscl_mults = 4,
-	.max_hscl_taps = 8,
-	.max_vscl_taps = 8,
-	.dispclk_ramp_margin_percent = 1,
-	.underscan_factor = 1.11,
-	.min_vblank_lines = 32,
-	.dppclk_delay_subtotal = 46,
-	.dynamic_metadata_vm_enabled = true,
-	.dppclk_delay_scl_lb_only = 16,
-	.dppclk_delay_scl = 50,
-	.dppclk_delay_cnvc_formatter = 27,
-	.dppclk_delay_cnvc_cursor = 6,
-	.dispclk_delay_subtotal = 119,
-	.dcfclk_cstate_latency = 5.2, // SRExitTime
-	.max_inter_dcn_tile_repeaters = 8,
-	.max_num_hdmi_frl_outputs = 0,
-	.odm_combine_4to1_supported = true,
-
-	.xfc_supported = false,
-	.xfc_fill_bw_overhead_percent = 10.0,
-	.xfc_fill_constant_bytes = 0,
-	.gfx7_compat_tiling_supported = 0,
-	.number_of_cursors = 1,
-};
-
-struct _vcs_dpi_soc_bounding_box_st dcn3_01_soc = {
-	.clock_limits = {
-			{
-				.state = 0,
-				.dram_speed_mts = 2400.0,
-				.fabricclk_mhz = 600,
-				.socclk_mhz = 278.0,
-				.dcfclk_mhz = 400.0,
-				.dscclk_mhz = 206.0,
-				.dppclk_mhz = 1015.0,
-				.dispclk_mhz = 1015.0,
-				.phyclk_mhz = 600.0,
-			},
-			{
-				.state = 1,
-				.dram_speed_mts = 2400.0,
-				.fabricclk_mhz = 688,
-				.socclk_mhz = 278.0,
-				.dcfclk_mhz = 400.0,
-				.dscclk_mhz = 206.0,
-				.dppclk_mhz = 1015.0,
-				.dispclk_mhz = 1015.0,
-				.phyclk_mhz = 600.0,
-			},
-			{
-				.state = 2,
-				.dram_speed_mts = 4267.0,
-				.fabricclk_mhz = 1067,
-				.socclk_mhz = 278.0,
-				.dcfclk_mhz = 608.0,
-				.dscclk_mhz = 296.0,
-				.dppclk_mhz = 1015.0,
-				.dispclk_mhz = 1015.0,
-				.phyclk_mhz = 810.0,
-			},
-
-			{
-				.state = 3,
-				.dram_speed_mts = 4267.0,
-				.fabricclk_mhz = 1067,
-				.socclk_mhz = 715.0,
-				.dcfclk_mhz = 676.0,
-				.dscclk_mhz = 338.0,
-				.dppclk_mhz = 1015.0,
-				.dispclk_mhz = 1015.0,
-				.phyclk_mhz = 810.0,
-			},
-
-			{
-				.state = 4,
-				.dram_speed_mts = 4267.0,
-				.fabricclk_mhz = 1067,
-				.socclk_mhz = 953.0,
-				.dcfclk_mhz = 810.0,
-				.dscclk_mhz = 338.0,
-				.dppclk_mhz = 1015.0,
-				.dispclk_mhz = 1015.0,
-				.phyclk_mhz = 810.0,
-			},
-		},
-
-	.sr_exit_time_us = 9.0,
-	.sr_enter_plus_exit_time_us = 11.0,
-	.urgent_latency_us = 4.0,
-	.urgent_latency_pixel_data_only_us = 4.0,
-	.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
-	.urgent_latency_vm_data_only_us = 4.0,
-	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
-	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
-	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
-	.pct_ideal_dram_sdp_bw_after_urgent_pixel_only = 80.0,
-	.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm = 75.0,
-	.pct_ideal_dram_sdp_bw_after_urgent_vm_only = 40.0,
-	.max_avg_sdp_bw_use_normal_percent = 60.0,
-	.max_avg_dram_bw_use_normal_percent = 60.0,
-	.writeback_latency_us = 12.0,
-	.max_request_size_bytes = 256,
-	.dram_channel_width_bytes = 4,
-	.fabric_datapath_to_dcn_data_return_bytes = 32,
-	.dcn_downspread_percent = 0.5,
-	.downspread_percent = 0.38,
-	.dram_page_open_time_ns = 50.0,
-	.dram_rw_turnaround_time_ns = 17.5,
-	.dram_return_buffer_per_channel_bytes = 8192,
-	.round_trip_ping_latency_dcfclk_cycles = 191,
-	.urgent_out_of_order_return_per_channel_bytes = 4096,
-	.channel_interleave_bytes = 256,
-	.num_banks = 8,
-	.num_chans = 4,
-	.gpuvm_min_page_size_bytes = 4096,
-	.hostvm_min_page_size_bytes = 4096,
-	.dram_clock_change_latency_us = 23.84,
-	.writeback_dram_clock_change_latency_us = 23.0,
-	.return_bus_width_bytes = 64,
-	.dispclk_dppclk_vco_speed_mhz = 3550,
-	.xfc_bus_transport_time_us = 20,      // ?
-	.xfc_xbuf_latency_tolerance_us = 4,  // ?
-	.use_urgent_burst_bw = 1,            // ?
-	.num_states = 5,
-	.do_urgent_latency_adjustment = false,
-	.urgent_latency_adjustment_fabric_clock_component_us = 0,
-	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
-};
-
 enum dcn301_clk_src_array_id {
 	DCN301_CLK_SRC_PLL0,
 	DCN301_CLK_SRC_PLL1,
@@ -1480,8 +1303,6 @@ static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap
 };
 
-#define fixed16_to_double(x) (((double) x) / ((double) (1 << 16)))
-#define fixed16_to_double_to_cpu(x) fixed16_to_double(le32_to_cpu(x))
 
 static bool is_soc_bounding_box_valid(struct dc *dc)
 {
@@ -1508,26 +1329,24 @@ static bool init_soc_bounding_box(struct dc *dc,
 
 	loaded_ip->max_num_otg = pool->base.res_cap->num_timing_generator;
 	loaded_ip->max_num_dpp = pool->base.pipe_count;
+	DC_FP_START();
 	dcn20_patch_bounding_box(dc, loaded_bb);
+	DC_FP_END();
 
 	if (dc->ctx->dc_bios->funcs->get_soc_bb_info) {
 		struct bp_soc_bb_info bb_info = {0};
 
 		if (dc->ctx->dc_bios->funcs->get_soc_bb_info(dc->ctx->dc_bios, &bb_info) == BP_RESULT_OK) {
-			if (bb_info.dram_clock_change_latency_100ns > 0)
-				dcn3_01_soc.dram_clock_change_latency_us = bb_info.dram_clock_change_latency_100ns * 10;
-
-			if (bb_info.dram_sr_enter_exit_latency_100ns > 0)
-				dcn3_01_soc.sr_enter_plus_exit_time_us = bb_info.dram_sr_enter_exit_latency_100ns * 10;
-
-			if (bb_info.dram_sr_exit_latency_100ns > 0)
-				dcn3_01_soc.sr_exit_time_us = bb_info.dram_sr_exit_latency_100ns * 10;
+			DC_FP_START();
+			dcn301_fpu_init_soc_bounding_box(bb_info);
+			DC_FP_END();
 		}
 	}
 
 	return true;
 }
 
+
 static void set_wm_ranges(
 		struct pp_smu_funcs *pp_smu,
 		struct _vcs_dpi_soc_bounding_box_st *loaded_bb)
@@ -1550,9 +1369,9 @@ static void set_wm_ranges(
 			ranges.reader_wm_sets[i].wm_inst = i;
 			ranges.reader_wm_sets[i].min_drain_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MIN;
 			ranges.reader_wm_sets[i].max_drain_clk_mhz = PP_SMU_WM_SET_RANGE_CLK_UNCONSTRAINED_MAX;
-			ranges.reader_wm_sets[i].min_fill_clk_mhz = (i > 0) ? (loaded_bb->clock_limits[i - 1].dram_speed_mts / 16) + 1 : 0;
-			ranges.reader_wm_sets[i].max_fill_clk_mhz = loaded_bb->clock_limits[i].dram_speed_mts / 16;
-
+			DC_FP_START();
+			dcn301_fpu_set_wm_ranges(i, &ranges, loaded_bb);
+			DC_FP_END();
 			ranges.num_reader_wm_sets = i + 1;
 		}
 
@@ -1572,154 +1391,6 @@ static void set_wm_ranges(
 	pp_smu->nv_funcs.set_wm_ranges(&pp_smu->nv_funcs.pp_smu, &ranges);
 }
 
-static void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
-{
-	struct dcn301_resource_pool *pool = TO_DCN301_RES_POOL(dc->res_pool);
-	struct clk_limit_table *clk_table = &bw_params->clk_table;
-	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
-	unsigned int i, closest_clk_lvl;
-	int j;
-
-	// Default clock levels are used for diags, which may lead to overclocking.
-	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
-		dcn3_01_ip.max_num_otg = pool->base.res_cap->num_timing_generator;
-		dcn3_01_ip.max_num_dpp = pool->base.pipe_count;
-		dcn3_01_soc.num_chans = bw_params->num_channels;
-
-		ASSERT(clk_table->num_entries);
-		for (i = 0; i < clk_table->num_entries; i++) {
-			/* loop backwards*/
-			for (closest_clk_lvl = 0, j = dcn3_01_soc.num_states - 1; j >= 0; j--) {
-				if ((unsigned int) dcn3_01_soc.clock_limits[j].dcfclk_mhz <= clk_table->entries[i].dcfclk_mhz) {
-					closest_clk_lvl = j;
-					break;
-				}
-			}
-
-			clock_limits[i].state = i;
-			clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
-			clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
-			clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
-			clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
-
-			clock_limits[i].dispclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
-			clock_limits[i].dppclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
-			clock_limits[i].dram_bw_per_chan_gbps = dcn3_01_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
-			clock_limits[i].dscclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
-			clock_limits[i].dtbclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
-			clock_limits[i].phyclk_d18_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
-			clock_limits[i].phyclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
-		}
-		for (i = 0; i < clk_table->num_entries; i++)
-			dcn3_01_soc.clock_limits[i] = clock_limits[i];
-		if (clk_table->num_entries) {
-			dcn3_01_soc.num_states = clk_table->num_entries;
-			/* duplicate last level */
-			dcn3_01_soc.clock_limits[dcn3_01_soc.num_states] = dcn3_01_soc.clock_limits[dcn3_01_soc.num_states - 1];
-			dcn3_01_soc.clock_limits[dcn3_01_soc.num_states].state = dcn3_01_soc.num_states;
-		}
-	}
-
-	dcn3_01_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
-	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
-
-	dml_init_instance(&dc->dml, &dcn3_01_soc, &dcn3_01_ip, DML_PROJECT_DCN30);
-}
-
-static void calculate_wm_set_for_vlevel(
-		int vlevel,
-		struct wm_range_table_entry *table_entry,
-		struct dcn_watermarks *wm_set,
-		struct display_mode_lib *dml,
-		display_e2e_pipe_params_st *pipes,
-		int pipe_cnt)
-{
-	double dram_clock_change_latency_cached = dml->soc.dram_clock_change_latency_us;
-
-	ASSERT(vlevel < dml->soc.num_states);
-	/* only pipe 0 is read for voltage and dcf/soc clocks */
-	pipes[0].clks_cfg.voltage = vlevel;
-	pipes[0].clks_cfg.dcfclk_mhz = dml->soc.clock_limits[vlevel].dcfclk_mhz;
-	pipes[0].clks_cfg.socclk_mhz = dml->soc.clock_limits[vlevel].socclk_mhz;
-
-	dml->soc.dram_clock_change_latency_us = table_entry->pstate_latency_us;
-	dml->soc.sr_exit_time_us = table_entry->sr_exit_time_us;
-	dml->soc.sr_enter_plus_exit_time_us = table_entry->sr_enter_plus_exit_time_us;
-
-	wm_set->urgent_ns = get_wm_urgent(dml, pipes, pipe_cnt) * 1000;
-	wm_set->cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(dml, pipes, pipe_cnt) * 1000;
-	wm_set->cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(dml, pipes, pipe_cnt) * 1000;
-	wm_set->cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(dml, pipes, pipe_cnt) * 1000;
-	wm_set->pte_meta_urgent_ns = get_wm_memory_trip(dml, pipes, pipe_cnt) * 1000;
-	wm_set->frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(dml, pipes, pipe_cnt) * 1000;
-	wm_set->frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(dml, pipes, pipe_cnt) * 1000;
-	wm_set->urgent_latency_ns = get_urgent_latency(dml, pipes, pipe_cnt) * 1000;
-	dml->soc.dram_clock_change_latency_us = dram_clock_change_latency_cached;
-
-}
-
-static void dcn301_calculate_wm_and_dlg(
-		struct dc *dc, struct dc_state *context,
-		display_e2e_pipe_params_st *pipes,
-		int pipe_cnt,
-		int vlevel_req)
-{
-	int i, pipe_idx;
-	int vlevel, vlevel_max;
-	struct wm_range_table_entry *table_entry;
-	struct clk_bw_params *bw_params = dc->clk_mgr->bw_params;
-
-	ASSERT(bw_params);
-
-	vlevel_max = bw_params->clk_table.num_entries - 1;
-
-	/* WM Set D */
-	table_entry = &bw_params->wm_table.entries[WM_D];
-	if (table_entry->wm_type == WM_TYPE_RETRAINING)
-		vlevel = 0;
-	else
-		vlevel = vlevel_max;
-	calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.d,
-						&context->bw_ctx.dml, pipes, pipe_cnt);
-	/* WM Set C */
-	table_entry = &bw_params->wm_table.entries[WM_C];
-	vlevel = min(max(vlevel_req, 2), vlevel_max);
-	calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.c,
-						&context->bw_ctx.dml, pipes, pipe_cnt);
-	/* WM Set B */
-	table_entry = &bw_params->wm_table.entries[WM_B];
-	vlevel = min(max(vlevel_req, 1), vlevel_max);
-	calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.b,
-						&context->bw_ctx.dml, pipes, pipe_cnt);
-
-	/* WM Set A */
-	table_entry = &bw_params->wm_table.entries[WM_A];
-	vlevel = min(vlevel_req, vlevel_max);
-	calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.a,
-						&context->bw_ctx.dml, pipes, pipe_cnt);
-
-	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
-		if (!context->res_ctx.pipe_ctx[i].stream)
-			continue;
-
-		pipes[pipe_idx].clks_cfg.dispclk_mhz = get_dispclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt);
-		pipes[pipe_idx].clks_cfg.dppclk_mhz = get_dppclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
-
-		if (dc->config.forced_clocks) {
-			pipes[pipe_idx].clks_cfg.dispclk_mhz = context->bw_ctx.dml.soc.clock_limits[0].dispclk_mhz;
-			pipes[pipe_idx].clks_cfg.dppclk_mhz = context->bw_ctx.dml.soc.clock_limits[0].dppclk_mhz;
-		}
-		if (dc->debug.min_disp_clk_khz > pipes[pipe_idx].clks_cfg.dispclk_mhz * 1000)
-			pipes[pipe_idx].clks_cfg.dispclk_mhz = dc->debug.min_disp_clk_khz / 1000.0;
-		if (dc->debug.min_dpp_clk_khz > pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000)
-			pipes[pipe_idx].clks_cfg.dppclk_mhz = dc->debug.min_dpp_clk_khz / 1000.0;
-
-		pipe_idx++;
-	}
-
-	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
-}
-
 static struct resource_funcs dcn301_res_pool_funcs = {
 	.destroy = dcn301_destroy_resource_pool,
 	.link_enc_create = dcn301_link_encoder_create,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.h b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.h
index 17e4e91ff4b8..ae8672680cdd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_resource.h
@@ -32,6 +32,9 @@ struct dc;
 struct resource_pool;
 struct _vcs_dpi_display_pipe_params_st;
 
+extern struct _vcs_dpi_ip_params_st dcn3_01_ip;
+extern struct _vcs_dpi_soc_bounding_box_st dcn3_01_soc;
+
 struct dcn301_resource_pool {
 	struct resource_pool base;
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dml/Makefile b/drivers/gpu/drm/amd/display/dc/dml/Makefile
index 169a4e68f86e..e5d358e44272 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dml/Makefile
@@ -70,6 +70,7 @@ CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_ccflags) $(fram
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_ccflags) $(frame_warn_flag)
 CFLAGS_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_ccflags)
+CFLAGS_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o := $(dml_ccflags)
 CFLAGS_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_ccflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_vba.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn2x/dcn2x.o := $(dml_rcflags)
@@ -83,6 +84,7 @@ CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/display_mode_vba_30.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn30/display_rq_dlg_calc_30.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/display_mode_vba_31.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn31/display_rq_dlg_calc_31.o := $(dml_rcflags)
+CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/dcn301/dcn301_fpu.o := $(dml_rcflags)
 CFLAGS_REMOVE_$(AMDDALPATH)/dc/dml/display_mode_lib.o := $(dml_rcflags)
 endif
 CFLAGS_$(AMDDALPATH)/dc/dml/dml1_display_rq_dlg_calc.o := $(dml_ccflags)
@@ -99,6 +101,7 @@ DML += dcn20/display_rq_dlg_calc_20v2.o dcn20/display_mode_vba_20v2.o
 DML += dcn21/display_rq_dlg_calc_21.o dcn21/display_mode_vba_21.o
 DML += dcn30/display_mode_vba_30.o dcn30/display_rq_dlg_calc_30.o
 DML += dcn31/display_mode_vba_31.o dcn31/display_rq_dlg_calc_31.o
+DML += dcn301/dcn301_fpu.o
 endif
 
 AMD_DAL_DML = $(addprefix $(AMDDALPATH)/dc/dml/,$(DML))
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
new file mode 100644
index 000000000000..94c32832a0e7
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.c
@@ -0,0 +1,390 @@
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
+#include "dcn301/dcn301_resource.h"
+
+#include "dml/dcn20/dcn20_fpu.h"
+#include "dcn301_fpu.h"
+
+#define TO_DCN301_RES_POOL(pool)\
+	container_of(pool, struct dcn301_resource_pool, base)
+
+/* Based on: //vidip/dc/dcn3/doc/architecture/DCN3x_Display_Mode.xlsm#83 */
+struct _vcs_dpi_ip_params_st dcn3_01_ip = {
+	.odm_capable = 1,
+	.gpuvm_enable = 1,
+	.hostvm_enable = 1,
+	.gpuvm_max_page_table_levels = 1,
+	.hostvm_max_page_table_levels = 2,
+	.hostvm_cached_page_table_levels = 0,
+	.pte_group_size_bytes = 2048,
+	.num_dsc = 3,
+	.rob_buffer_size_kbytes = 184,
+	.det_buffer_size_kbytes = 184,
+	.dpte_buffer_size_in_pte_reqs_luma = 64,
+	.dpte_buffer_size_in_pte_reqs_chroma = 32,
+	.pde_proc_buffer_size_64k_reqs = 48,
+	.dpp_output_buffer_pixels = 2560,
+	.opp_output_buffer_lines = 1,
+	.pixel_chunk_size_kbytes = 8,
+	.meta_chunk_size_kbytes = 2,
+	.writeback_chunk_size_kbytes = 8,
+	.line_buffer_size_bits = 789504,
+	.is_line_buffer_bpp_fixed = 0,  // ?
+	.line_buffer_fixed_bpp = 48,     // ?
+	.dcc_supported = true,
+	.writeback_interface_buffer_size_kbytes = 90,
+	.writeback_line_buffer_buffer_size = 656640,
+	.max_line_buffer_lines = 12,
+	.writeback_luma_buffer_size_kbytes = 12,  // writeback_line_buffer_buffer_size = 656640
+	.writeback_chroma_buffer_size_kbytes = 8,
+	.writeback_chroma_line_buffer_width_pixels = 4,
+	.writeback_max_hscl_ratio = 1,
+	.writeback_max_vscl_ratio = 1,
+	.writeback_min_hscl_ratio = 1,
+	.writeback_min_vscl_ratio = 1,
+	.writeback_max_hscl_taps = 1,
+	.writeback_max_vscl_taps = 1,
+	.writeback_line_buffer_luma_buffer_size = 0,
+	.writeback_line_buffer_chroma_buffer_size = 14643,
+	.cursor_buffer_size = 8,
+	.cursor_chunk_size = 2,
+	.max_num_otg = 4,
+	.max_num_dpp = 4,
+	.max_num_wb = 1,
+	.max_dchub_pscl_bw_pix_per_clk = 4,
+	.max_pscl_lb_bw_pix_per_clk = 2,
+	.max_lb_vscl_bw_pix_per_clk = 4,
+	.max_vscl_hscl_bw_pix_per_clk = 4,
+	.max_hscl_ratio = 6,
+	.max_vscl_ratio = 6,
+	.hscl_mults = 4,
+	.vscl_mults = 4,
+	.max_hscl_taps = 8,
+	.max_vscl_taps = 8,
+	.dispclk_ramp_margin_percent = 1,
+	.underscan_factor = 1.11,
+	.min_vblank_lines = 32,
+	.dppclk_delay_subtotal = 46,
+	.dynamic_metadata_vm_enabled = true,
+	.dppclk_delay_scl_lb_only = 16,
+	.dppclk_delay_scl = 50,
+	.dppclk_delay_cnvc_formatter = 27,
+	.dppclk_delay_cnvc_cursor = 6,
+	.dispclk_delay_subtotal = 119,
+	.dcfclk_cstate_latency = 5.2, // SRExitTime
+	.max_inter_dcn_tile_repeaters = 8,
+	.max_num_hdmi_frl_outputs = 0,
+	.odm_combine_4to1_supported = true,
+
+	.xfc_supported = false,
+	.xfc_fill_bw_overhead_percent = 10.0,
+	.xfc_fill_constant_bytes = 0,
+	.gfx7_compat_tiling_supported = 0,
+	.number_of_cursors = 1,
+};
+
+struct _vcs_dpi_soc_bounding_box_st dcn3_01_soc = {
+	.clock_limits = {
+		{
+			.state = 0,
+			.dram_speed_mts = 2400.0,
+			.fabricclk_mhz = 600,
+			.socclk_mhz = 278.0,
+			.dcfclk_mhz = 400.0,
+			.dscclk_mhz = 206.0,
+			.dppclk_mhz = 1015.0,
+			.dispclk_mhz = 1015.0,
+			.phyclk_mhz = 600.0,
+		},
+
+		{
+			.state = 1,
+			.dram_speed_mts = 2400.0,
+			.fabricclk_mhz = 688,
+			.socclk_mhz = 278.0,
+			.dcfclk_mhz = 400.0,
+			.dscclk_mhz = 206.0,
+			.dppclk_mhz = 1015.0,
+			.dispclk_mhz = 1015.0,
+			.phyclk_mhz = 600.0,
+		},
+
+		{
+			.state = 2,
+			.dram_speed_mts = 4267.0,
+			.fabricclk_mhz = 1067,
+			.socclk_mhz = 278.0,
+			.dcfclk_mhz = 608.0,
+			.dscclk_mhz = 296.0,
+			.dppclk_mhz = 1015.0,
+			.dispclk_mhz = 1015.0,
+			.phyclk_mhz = 810.0,
+		},
+
+		{
+			.state = 3,
+			.dram_speed_mts = 4267.0,
+			.fabricclk_mhz = 1067,
+			.socclk_mhz = 715.0,
+			.dcfclk_mhz = 676.0,
+			.dscclk_mhz = 338.0,
+			.dppclk_mhz = 1015.0,
+			.dispclk_mhz = 1015.0,
+			.phyclk_mhz = 810.0,
+		},
+
+		{
+			.state = 4,
+			.dram_speed_mts = 4267.0,
+			.fabricclk_mhz = 1067,
+			.socclk_mhz = 953.0,
+			.dcfclk_mhz = 810.0,
+			.dscclk_mhz = 338.0,
+			.dppclk_mhz = 1015.0,
+			.dispclk_mhz = 1015.0,
+			.phyclk_mhz = 810.0,
+		},
+	},
+
+	.sr_exit_time_us = 9.0,
+	.sr_enter_plus_exit_time_us = 11.0,
+	.urgent_latency_us = 4.0,
+	.urgent_latency_pixel_data_only_us = 4.0,
+	.urgent_latency_pixel_mixed_with_vm_data_us = 4.0,
+	.urgent_latency_vm_data_only_us = 4.0,
+	.urgent_out_of_order_return_per_channel_pixel_only_bytes = 4096,
+	.urgent_out_of_order_return_per_channel_pixel_and_vm_bytes = 4096,
+	.urgent_out_of_order_return_per_channel_vm_only_bytes = 4096,
+	.pct_ideal_dram_sdp_bw_after_urgent_pixel_only = 80.0,
+	.pct_ideal_dram_sdp_bw_after_urgent_pixel_and_vm = 75.0,
+	.pct_ideal_dram_sdp_bw_after_urgent_vm_only = 40.0,
+	.max_avg_sdp_bw_use_normal_percent = 60.0,
+	.max_avg_dram_bw_use_normal_percent = 60.0,
+	.writeback_latency_us = 12.0,
+	.max_request_size_bytes = 256,
+	.dram_channel_width_bytes = 4,
+	.fabric_datapath_to_dcn_data_return_bytes = 32,
+	.dcn_downspread_percent = 0.5,
+	.downspread_percent = 0.38,
+	.dram_page_open_time_ns = 50.0,
+	.dram_rw_turnaround_time_ns = 17.5,
+	.dram_return_buffer_per_channel_bytes = 8192,
+	.round_trip_ping_latency_dcfclk_cycles = 191,
+	.urgent_out_of_order_return_per_channel_bytes = 4096,
+	.channel_interleave_bytes = 256,
+	.num_banks = 8,
+	.num_chans = 4,
+	.gpuvm_min_page_size_bytes = 4096,
+	.hostvm_min_page_size_bytes = 4096,
+	.dram_clock_change_latency_us = 23.84,
+	.writeback_dram_clock_change_latency_us = 23.0,
+	.return_bus_width_bytes = 64,
+	.dispclk_dppclk_vco_speed_mhz = 3550,
+	.xfc_bus_transport_time_us = 20,      // ?
+	.xfc_xbuf_latency_tolerance_us = 4,  // ?
+	.use_urgent_burst_bw = 1,            // ?
+	.num_states = 5,
+	.do_urgent_latency_adjustment = false,
+	.urgent_latency_adjustment_fabric_clock_component_us = 0,
+	.urgent_latency_adjustment_fabric_clock_reference_mhz = 0,
+};
+
+static void calculate_wm_set_for_vlevel(int vlevel,
+		struct wm_range_table_entry *table_entry,
+		struct dcn_watermarks *wm_set,
+		struct display_mode_lib *dml,
+		display_e2e_pipe_params_st *pipes,
+		int pipe_cnt)
+{
+	double dram_clock_change_latency_cached = dml->soc.dram_clock_change_latency_us;
+
+	ASSERT(vlevel < dml->soc.num_states);
+	/* only pipe 0 is read for voltage and dcf/soc clocks */
+	pipes[0].clks_cfg.voltage = vlevel;
+	pipes[0].clks_cfg.dcfclk_mhz = dml->soc.clock_limits[vlevel].dcfclk_mhz;
+	pipes[0].clks_cfg.socclk_mhz = dml->soc.clock_limits[vlevel].socclk_mhz;
+
+	dml->soc.dram_clock_change_latency_us = table_entry->pstate_latency_us;
+	dml->soc.sr_exit_time_us = table_entry->sr_exit_time_us;
+	dml->soc.sr_enter_plus_exit_time_us = table_entry->sr_enter_plus_exit_time_us;
+
+	wm_set->urgent_ns = get_wm_urgent(dml, pipes, pipe_cnt) * 1000;
+	wm_set->cstate_pstate.cstate_enter_plus_exit_ns = get_wm_stutter_enter_exit(dml, pipes, pipe_cnt) * 1000;
+	wm_set->cstate_pstate.cstate_exit_ns = get_wm_stutter_exit(dml, pipes, pipe_cnt) * 1000;
+	wm_set->cstate_pstate.pstate_change_ns = get_wm_dram_clock_change(dml, pipes, pipe_cnt) * 1000;
+	wm_set->pte_meta_urgent_ns = get_wm_memory_trip(dml, pipes, pipe_cnt) * 1000;
+	wm_set->frac_urg_bw_nom = get_fraction_of_urgent_bandwidth(dml, pipes, pipe_cnt) * 1000;
+	wm_set->frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(dml, pipes, pipe_cnt) * 1000;
+	wm_set->urgent_latency_ns = get_urgent_latency(dml, pipes, pipe_cnt) * 1000;
+	dml->soc.dram_clock_change_latency_us = dram_clock_change_latency_cached;
+
+}
+
+void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
+{
+	struct dcn301_resource_pool *pool = TO_DCN301_RES_POOL(dc->res_pool);
+	struct clk_limit_table *clk_table = &bw_params->clk_table;
+	struct _vcs_dpi_voltage_scaling_st clock_limits[DC__VOLTAGE_STATES];
+	unsigned int i, closest_clk_lvl;
+	int j;
+
+	dc_assert_fp_enabled();
+
+	/* Default clock levels are used for diags, which may lead to overclocking. */
+	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
+		dcn3_01_ip.max_num_otg = pool->base.res_cap->num_timing_generator;
+		dcn3_01_ip.max_num_dpp = pool->base.pipe_count;
+		dcn3_01_soc.num_chans = bw_params->num_channels;
+
+		ASSERT(clk_table->num_entries);
+		for (i = 0; i < clk_table->num_entries; i++) {
+			/* loop backwards*/
+			for (closest_clk_lvl = 0, j = dcn3_01_soc.num_states - 1; j >= 0; j--) {
+				if ((unsigned int) dcn3_01_soc.clock_limits[j].dcfclk_mhz <= clk_table->entries[i].dcfclk_mhz) {
+					closest_clk_lvl = j;
+					break;
+				}
+			}
+
+			clock_limits[i].state = i;
+			clock_limits[i].dcfclk_mhz = clk_table->entries[i].dcfclk_mhz;
+			clock_limits[i].fabricclk_mhz = clk_table->entries[i].fclk_mhz;
+			clock_limits[i].socclk_mhz = clk_table->entries[i].socclk_mhz;
+			clock_limits[i].dram_speed_mts = clk_table->entries[i].memclk_mhz * 2;
+
+			clock_limits[i].dispclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dispclk_mhz;
+			clock_limits[i].dppclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dppclk_mhz;
+			clock_limits[i].dram_bw_per_chan_gbps = dcn3_01_soc.clock_limits[closest_clk_lvl].dram_bw_per_chan_gbps;
+			clock_limits[i].dscclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dscclk_mhz;
+			clock_limits[i].dtbclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].dtbclk_mhz;
+			clock_limits[i].phyclk_d18_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_d18_mhz;
+			clock_limits[i].phyclk_mhz = dcn3_01_soc.clock_limits[closest_clk_lvl].phyclk_mhz;
+		}
+
+		for (i = 0; i < clk_table->num_entries; i++)
+			dcn3_01_soc.clock_limits[i] = clock_limits[i];
+
+		if (clk_table->num_entries) {
+			dcn3_01_soc.num_states = clk_table->num_entries;
+			/* duplicate last level */
+			dcn3_01_soc.clock_limits[dcn3_01_soc.num_states] = dcn3_01_soc.clock_limits[dcn3_01_soc.num_states - 1];
+			dcn3_01_soc.clock_limits[dcn3_01_soc.num_states].state = dcn3_01_soc.num_states;
+		}
+	}
+
+	dcn3_01_soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
+	dc->dml.soc.dispclk_dppclk_vco_speed_mhz = dc->clk_mgr->dentist_vco_freq_khz / 1000.0;
+
+	dml_init_instance(&dc->dml, &dcn3_01_soc, &dcn3_01_ip, DML_PROJECT_DCN30);
+}
+
+void dcn301_fpu_set_wm_ranges(int i,
+	struct pp_smu_wm_range_sets *ranges,
+	struct _vcs_dpi_soc_bounding_box_st *loaded_bb)
+{
+	dc_assert_fp_enabled();
+
+	ranges->reader_wm_sets[i].min_fill_clk_mhz = (i > 0) ? (loaded_bb->clock_limits[i - 1].dram_speed_mts / 16) + 1 : 0;
+	ranges->reader_wm_sets[i].max_fill_clk_mhz = loaded_bb->clock_limits[i].dram_speed_mts / 16;
+}
+
+void dcn301_fpu_init_soc_bounding_box(struct bp_soc_bb_info bb_info)
+{
+	dc_assert_fp_enabled();
+
+	if (bb_info.dram_clock_change_latency_100ns > 0)
+		dcn3_01_soc.dram_clock_change_latency_us = bb_info.dram_clock_change_latency_100ns * 10;
+
+	if (bb_info.dram_sr_enter_exit_latency_100ns > 0)
+		dcn3_01_soc.sr_enter_plus_exit_time_us = bb_info.dram_sr_enter_exit_latency_100ns * 10;
+
+	if (bb_info.dram_sr_exit_latency_100ns > 0)
+		dcn3_01_soc.sr_exit_time_us = bb_info.dram_sr_exit_latency_100ns * 10;
+}
+
+void dcn301_calculate_wm_and_dlg(struct dc *dc,
+		struct dc_state *context,
+		display_e2e_pipe_params_st *pipes,
+		int pipe_cnt,
+		int vlevel_req)
+{
+	int i, pipe_idx;
+	int vlevel, vlevel_max;
+	struct wm_range_table_entry *table_entry;
+	struct clk_bw_params *bw_params = dc->clk_mgr->bw_params;
+
+	ASSERT(bw_params);
+	dc_assert_fp_enabled();
+
+	vlevel_max = bw_params->clk_table.num_entries - 1;
+
+	/* WM Set D */
+	table_entry = &bw_params->wm_table.entries[WM_D];
+	if (table_entry->wm_type == WM_TYPE_RETRAINING)
+		vlevel = 0;
+	else
+		vlevel = vlevel_max;
+	calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.d,
+						&context->bw_ctx.dml, pipes, pipe_cnt);
+	/* WM Set C */
+	table_entry = &bw_params->wm_table.entries[WM_C];
+	vlevel = min(max(vlevel_req, 2), vlevel_max);
+	calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.c,
+						&context->bw_ctx.dml, pipes, pipe_cnt);
+	/* WM Set B */
+	table_entry = &bw_params->wm_table.entries[WM_B];
+	vlevel = min(max(vlevel_req, 1), vlevel_max);
+	calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.b,
+						&context->bw_ctx.dml, pipes, pipe_cnt);
+
+	/* WM Set A */
+	table_entry = &bw_params->wm_table.entries[WM_A];
+	vlevel = min(vlevel_req, vlevel_max);
+	calculate_wm_set_for_vlevel(vlevel, table_entry, &context->bw_ctx.bw.dcn.watermarks.a,
+						&context->bw_ctx.dml, pipes, pipe_cnt);
+
+	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
+		if (!context->res_ctx.pipe_ctx[i].stream)
+			continue;
+
+		pipes[pipe_idx].clks_cfg.dispclk_mhz = get_dispclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt);
+		pipes[pipe_idx].clks_cfg.dppclk_mhz = get_dppclk_calculated(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
+
+		if (dc->config.forced_clocks) {
+			pipes[pipe_idx].clks_cfg.dispclk_mhz = context->bw_ctx.dml.soc.clock_limits[0].dispclk_mhz;
+			pipes[pipe_idx].clks_cfg.dppclk_mhz = context->bw_ctx.dml.soc.clock_limits[0].dppclk_mhz;
+		}
+		if (dc->debug.min_disp_clk_khz > pipes[pipe_idx].clks_cfg.dispclk_mhz * 1000)
+			pipes[pipe_idx].clks_cfg.dispclk_mhz = dc->debug.min_disp_clk_khz / 1000.0;
+		if (dc->debug.min_dpp_clk_khz > pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000)
+			pipes[pipe_idx].clks_cfg.dppclk_mhz = dc->debug.min_dpp_clk_khz / 1000.0;
+		pipe_idx++;
+	}
+
+	dcn20_calculate_dlg_params(dc, context, pipes, pipe_cnt, vlevel);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.h
new file mode 100644
index 000000000000..fc7065d17842
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn301/dcn301_fpu.h
@@ -0,0 +1,42 @@
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
+#ifndef __DCN301_FPU_H__
+#define __DCN301_FPU_H__
+
+void dcn301_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params);
+
+void dcn301_fpu_set_wm_ranges(int i,
+	struct pp_smu_wm_range_sets *ranges,
+	struct _vcs_dpi_soc_bounding_box_st *loaded_bb);
+
+void dcn301_fpu_init_soc_bounding_box(struct bp_soc_bb_info bb_info);
+
+void dcn301_calculate_wm_and_dlg(struct dc *dc,
+		struct dc_state *context,
+		display_e2e_pipe_params_st *pipes,
+		int pipe_cnt,
+		int vlevel_req);
+#endif /* __DCN301_FPU_H__*/
-- 
2.25.1


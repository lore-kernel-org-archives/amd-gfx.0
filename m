Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADA58EE49B0
	for <amd-gfx@archiver.kernel.org>; Wed, 23 Aug 2023 15:51:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1FF210E445;
	Wed, 23 Aug 2023 15:51:31 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A695010E443
 for <amd-gfx@lists.freedesktop.org>; Wed, 23 Aug 2023 15:51:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Th/6umOaZpPFSFd/IfaDg4Gsig5GYv7lS8x2bgIkcd15wOhMwGLwZw0ceCp3QmcVyWQGXPl8YE/C+GokIq7AJSlZhUAPrxS59tLm2ZB3diw537p3sXV5hEDNdD2RYP+jrt2IACR/XfrxLKatqwlAjgRXnePLX23qf2SwILoH0hJYRXFHS8XCT1QVrJ0VDczvd0Hzi62QzujmXHiJ8IUwp4mT86LTlUmWYACGKvFzzO7HdTFhki8s5Eoxhr0KZesEHP53zWJoZT2MAwO9HSoa85X/ttqsmpoIiLV1yvJrVe9mz2bidZ6JlFs8vPhG+G9Zqe2TxRJzl7DAhmsO5hbJyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RAzn3N/AUSIgHYVm5b8IHhwMS+6twkYURs7+nI21/4M=;
 b=XCmvzNBH4/4GonqrBkmM7YgKELefY2hPDN4qEN71cRcyPtepLaMqkbuwcQn9Q/2RMaow6UCQw1b84EfN8AYQAl6Lq1NjTQQgLprMWE3TEczfvu4jEFDV9ZBw64Z4JWxV1fnvcrL3wmZ9C4ScXpMoqZXbx66UlgfQmqiag0cOBnLU+irrXxOku1tSdmfpfuHXQ+q67rD7djsnIP6bUmvpjhdfRkRRz35T5OLpos61XY0Dwky1cjfrxBUU+CjeB8mlFvc59SRj99rCvJ1VHsLbFql/Dt3CZ0zaQMhSBHnYN+WWrL9fFXIFTFSeAp2Oeg3qpyOM3rIfEvIc4nZHp4BU1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAzn3N/AUSIgHYVm5b8IHhwMS+6twkYURs7+nI21/4M=;
 b=ZWLVp1dWbQ2RSJ6qjknGb7s4ofb5MNNRyhzPH2Mq5cBWyoAJXt1gSV7IrLugCtWK1p4jB/zErIOfH2cFPJs/2uQ/hgKJfdd+QxiX//XUyyjdhTTg+32vlz8/YYAtSEOsEIUpMHEAN4R/SGmklQYzhtRCv0gTZJ6zLoIsRsEW268=
Received: from CY5PR18CA0054.namprd18.prod.outlook.com (2603:10b6:930:13::30)
 by SN7PR12MB8103.namprd12.prod.outlook.com (2603:10b6:806:355::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Wed, 23 Aug
 2023 15:51:26 +0000
Received: from CY4PEPF0000EE32.namprd05.prod.outlook.com
 (2603:10b6:930:13:cafe::f7) by CY5PR18CA0054.outlook.office365.com
 (2603:10b6:930:13::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.26 via Frontend
 Transport; Wed, 23 Aug 2023 15:51:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE32.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6699.15 via Frontend Transport; Wed, 23 Aug 2023 15:51:26 +0000
Received: from tr4.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 23 Aug
 2023 10:51:21 -0500
From: Alex Deucher <alexander.deucher@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 29/35] drm/amd/display: Add DCN35 init
Date: Wed, 23 Aug 2023 11:50:42 -0400
Message-ID: <20230823155048.2526343-29-alexander.deucher@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE32:EE_|SN7PR12MB8103:EE_
X-MS-Office365-Filtering-Correlation-Id: 76bcf186-0e0c-4948-6f7e-08dba3f0cef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j1gtUHvntcRGBCSkZwlqaVnDEGHGhIKqWqL0WjSon1V+3oqrJJFPx5Ld6eXzJ8L4bzURQhHXCRtDcv+/BDO2ZkEBdoHkwpzz1quEo2Jc7vU2mQf8NYCeU+D6Bh2VDDOqqA2ugvFoo6BYjmi8LT7KZ4SKfU1X4CmW7I28pC3i05RwMnJCAISGx5eIrviP5muw5eRV2lYQGK9id6GMlsq2jvgaRvSJVONZlIXCEFcPWXi2sY62qqBjqE7LPrj5bERW8CaOaMFYHjt9vU76ws5Aslsyx3rQusK4GGjRTlNy0LAYSzwAVijlnmKQX20Bd4S1tc5sSTfaUjp+po7U+vs9cdGj4AQGFkvHR/cvTtK8wQO1in+2rgHo36PE7gOYIYnQ33iA0PabYQEJ+I0A1bFZ+L5BphhRij/jKpSRBOJK87Dx9HTurKlOpJW+DKqkH7BgwmDjLGoUm/W+m75plUZati+MjODz1tuibCJtFE7g3Exd8FdUr4s6TEeX+HvJpc6ZDToOqSglYgSqrH5nQ+CJxIWtNURNzp4RiqiloAbpSAP7v9PQQ2ZEug9LsC+oISVozhpEN4F2aU1XIInBk6hRm1oejUmvrUzRbPYTr7aVSoKx9A7Q8UsyWOAPPMqDRQ6PsYDFm6KDBGj/K+TWqcLpyBMkY3MrL0NsdP+Vrs0M9gLAMHVyXy1ANpcmv9Z0U12le4DefbiZLLqW2xtjNGXxxaV8aXJo4o4MBthCsaJcho4XObOz734iwuFFEg1gZ6OgSjSd50rDmWzqV5ZyF6JjtbzE1YwTHX3Dt9IjDvv+3fpWK3An1lwsGMr8Q2ZTeHJR
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(396003)(346002)(136003)(39860400002)(451199024)(82310400011)(186009)(1800799009)(40470700004)(36840700001)(46966006)(41300700001)(70586007)(5660300002)(86362001)(54906003)(2616005)(70206006)(30864003)(6916009)(316002)(2906002)(478600001)(8676002)(4326008)(26005)(8936002)(40460700003)(6666004)(7696005)(36756003)(82740400003)(356005)(81166007)(47076005)(426003)(36860700001)(66899024)(336012)(1076003)(83380400001)(16526019)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 15:51:26.1633 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bcf186-0e0c-4948-6f7e-08dba3f0cef5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE32.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8103
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
Add init files for DCN35.

Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Acked-by: Harry Wentland <Harry.Wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn35/dcn35_init.c | 167 ++++++++++++++++++
 .../gpu/drm/amd/display/dc/dcn35/dcn35_init.h |  32 ++++
 2 files changed, 199 insertions(+)
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
 create mode 100644 drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.h

diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
new file mode 100644
index 000000000000..fdbc3a7854c2
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.c
@@ -0,0 +1,167 @@
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
+ */
+
+#include "dce110/dce110_hw_sequencer.h"
+#include "dcn10/dcn10_hw_sequencer.h"
+#include "dcn20/dcn20_hwseq.h"
+#include "dcn21/dcn21_hwseq.h"
+#include "dcn30/dcn30_hwseq.h"
+#include "dcn301/dcn301_hwseq.h"
+#include "dcn31/dcn31_hwseq.h"
+#include "dcn32/dcn32_hwseq.h"
+#include "dcn35/dcn35_hwseq.h"
+
+#include "dcn35_init.h"
+
+static const struct hw_sequencer_funcs dcn35_funcs = {
+	.program_gamut_remap = dcn10_program_gamut_remap,
+	.init_hw = dcn35_init_hw,
+	.power_down_on_boot = dcn35_power_down_on_boot,
+	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
+	.apply_ctx_for_surface = NULL,
+	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
+	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
+	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
+	.update_plane_addr = dcn20_update_plane_addr,
+	.update_dchub = dcn10_update_dchub,
+	.update_pending_status = dcn10_update_pending_status,
+	.program_output_csc = dcn20_program_output_csc,
+	.enable_accelerated_mode = dce110_enable_accelerated_mode,
+	.enable_timing_synchronization = dcn10_enable_timing_synchronization,
+	.enable_per_frame_crtc_position_reset = dcn10_enable_per_frame_crtc_position_reset,
+	.update_info_frame = dcn31_update_info_frame,
+	.send_immediate_sdp_message = dcn10_send_immediate_sdp_message,
+	.enable_stream = dcn20_enable_stream,
+	.disable_stream = dce110_disable_stream,
+	.unblank_stream = dcn32_unblank_stream,
+	.blank_stream = dce110_blank_stream,
+	.enable_audio_stream = dce110_enable_audio_stream,
+	.disable_audio_stream = dce110_disable_audio_stream,
+	.disable_plane = dcn35_disable_plane,
+	.disable_pixel_data = dcn20_disable_pixel_data,
+	.pipe_control_lock = dcn20_pipe_control_lock,
+	.interdependent_update_lock = dcn10_lock_all_pipes,
+	.cursor_lock = dcn10_cursor_lock,
+	.prepare_bandwidth = dcn35_prepare_bandwidth,
+	.optimize_bandwidth = dcn35_optimize_bandwidth,
+	.update_bandwidth = dcn20_update_bandwidth,
+	.set_drr = dcn10_set_drr,
+	.get_position = dcn10_get_position,
+	.set_static_screen_control = dcn10_set_static_screen_control,
+	.setup_stereo = dcn10_setup_stereo,
+	.set_avmute = dcn30_set_avmute,
+	.log_hw_state = dcn10_log_hw_state,
+	.get_hw_state = dcn10_get_hw_state,
+	.clear_status_bits = dcn10_clear_status_bits,
+	.wait_for_mpcc_disconnect = dcn10_wait_for_mpcc_disconnect,
+	.edp_backlight_control = dce110_edp_backlight_control,
+	.edp_power_control = dce110_edp_power_control,
+	.edp_wait_for_T12 = dce110_edp_wait_for_T12,
+	.edp_wait_for_hpd_ready = dce110_edp_wait_for_hpd_ready,
+	.set_cursor_position = dcn10_set_cursor_position,
+	.set_cursor_attribute = dcn10_set_cursor_attribute,
+	.set_cursor_sdr_white_level = dcn10_set_cursor_sdr_white_level,
+	.setup_periodic_interrupt = dcn10_setup_periodic_interrupt,
+	.set_clock = dcn10_set_clock,
+	.get_clock = dcn10_get_clock,
+	.program_triplebuffer = dcn20_program_triple_buffer,
+	.enable_writeback = dcn30_enable_writeback,
+	.disable_writeback = dcn30_disable_writeback,
+	.update_writeback = dcn30_update_writeback,
+	.mmhubbub_warmup = dcn30_mmhubbub_warmup,
+	.dmdata_status_done = dcn20_dmdata_status_done,
+	.program_dmdata_engine = dcn30_program_dmdata_engine,
+	.set_dmdata_attributes = dcn20_set_dmdata_attributes,
+	.init_sys_ctx = dcn31_init_sys_ctx,
+	.init_vm_ctx = dcn20_init_vm_ctx,
+	.set_flip_control_gsl = dcn20_set_flip_control_gsl,
+	.get_vupdate_offset_from_vsync = dcn10_get_vupdate_offset_from_vsync,
+	.calc_vupdate_position = dcn10_calc_vupdate_position,
+	.power_down = dce110_power_down,
+	.set_backlight_level = dcn21_set_backlight_level,
+	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
+	.set_pipe = dcn21_set_pipe,
+	.enable_lvds_link_output = dce110_enable_lvds_link_output,
+	.enable_tmds_link_output = dce110_enable_tmds_link_output,
+	.enable_dp_link_output = dce110_enable_dp_link_output,
+	.disable_link_output = dcn32_disable_link_output,
+	.z10_restore = dcn35_z10_restore,
+	.z10_save_init = dcn31_z10_save_init,
+	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
+	.optimize_pwr_state = dcn21_optimize_pwr_state,
+	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
+	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
+	.apply_idle_power_optimizations = dcn35_apply_idle_power_optimizations,
+	.update_dsc_pg = dcn32_update_dsc_pg,
+	.calc_blocks_to_gate = dcn35_calc_blocks_to_gate,
+	.calc_blocks_to_ungate = dcn35_calc_blocks_to_ungate,
+	.block_power_control = dcn35_block_power_control,
+	.root_clock_control = dcn35_root_clock_control
+};
+
+static const struct hwseq_private_funcs dcn35_private_funcs = {
+	.init_pipes = dcn35_init_pipes,
+	.update_plane_addr = dcn20_update_plane_addr,
+	.plane_atomic_disconnect = dcn10_plane_atomic_disconnect,
+	.update_mpcc = dcn20_update_mpcc,
+	.set_input_transfer_func = dcn32_set_input_transfer_func,
+	.set_output_transfer_func = dcn32_set_output_transfer_func,
+	.power_down = dce110_power_down,
+	.enable_display_power_gating = dcn10_dummy_display_power_gating,
+	.blank_pixel_data = dcn20_blank_pixel_data,
+	.reset_hw_ctx_wrap = dcn31_reset_hw_ctx_wrap,
+	.enable_stream_timing = dcn20_enable_stream_timing,
+	.edp_backlight_control = dce110_edp_backlight_control,
+	.setup_vupdate_interrupt = dcn20_setup_vupdate_interrupt,
+	.did_underflow_occur = dcn10_did_underflow_occur,
+	.init_blank = dcn20_init_blank,
+	.disable_vga = NULL,
+	.bios_golden_init = dcn10_bios_golden_init,
+	.plane_atomic_disable = dcn35_plane_atomic_disable,
+	//.plane_atomic_disable = dcn20_plane_atomic_disable,/*todo*/
+	//.hubp_pg_control = dcn35_hubp_pg_control,
+	.enable_power_gating_plane = dcn35_enable_power_gating_plane,
+	.dpp_root_clock_control = dcn35_dpp_root_clock_control,
+	.program_all_writeback_pipes_in_tree = dcn30_program_all_writeback_pipes_in_tree,
+	.update_odm = dcn35_update_odm,
+	.set_hdr_multiplier = dcn10_set_hdr_multiplier,
+	.verify_allow_pstate_change_high = dcn10_verify_allow_pstate_change_high,
+	.wait_for_blank_complete = dcn20_wait_for_blank_complete,
+	.dccg_init = dcn20_dccg_init,
+	.set_mcm_luts = dcn32_set_mcm_luts,
+	.setup_hpo_hw_control = dcn35_setup_hpo_hw_control,
+	.calculate_dccg_k1_k2_values = dcn32_calculate_dccg_k1_k2_values,
+	.set_pixels_per_cycle = dcn32_set_pixels_per_cycle,
+	.is_dp_dig_pixel_rate_div_policy = dcn32_is_dp_dig_pixel_rate_div_policy,
+	.dsc_pg_control = dcn35_dsc_pg_control,
+	.dsc_pg_status = dcn32_dsc_pg_status,
+	.enable_plane = dcn35_enable_plane,
+};
+
+void dcn35_hw_sequencer_construct(struct dc *dc)
+{
+	dc->hwss = dcn35_funcs;
+	dc->hwseq->funcs = dcn35_private_funcs;
+
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.h b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.h
new file mode 100644
index 000000000000..ccfc28225cff
--- /dev/null
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_init.h
@@ -0,0 +1,32 @@
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
+ */
+
+#ifndef __DC_DCN35_INIT_H__
+#define __DC_DCN35_INIT_H__
+
+struct dc;
+
+void dcn35_hw_sequencer_construct(struct dc *dc);
+
+#endif /* __DC_DCN35_INIT_H__ */
-- 
2.41.0


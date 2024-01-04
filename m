Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBAF9C4707C
	for <amd-gfx@archiver.kernel.org>; Thu,  4 Jan 2024 15:53:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C4CC10E4D5;
	Thu,  4 Jan 2024 15:53:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9F22B10E4CD
 for <amd-gfx@lists.freedesktop.org>; Thu,  4 Jan 2024 15:53:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HC3nBGdKoKoxf/o9gcLs5oW/oKqHLid+JzIHDgC0j4tCZd5HuNRjEUn5WbqGlx6Mi1z1It53GV63mxE18w6HYK8wUNzPBbrU3BI3toxoIIoNteBO6hBh7moMqRW5AkHJzcWPxP5MBH5d28VvnlWszQMxZV4hLHCv/QieYgoVXPt+zdgj/MuJqonoxTRecPUu7CIS1UGocJsO8p+sCkxXjxmPF72hIIAIu1TUDu0kNbdAkIJ2uNVGLYtiQ126Df1GTryu9cFEp6lPN4dpqjRft793dQ19X7AanggKCWMSrzFfNvpr5ZHFW42EnkCAtPxUf9OcBRi/6ebDMEv+ESgx6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6XE8W8uZqKYv9EktZwC0DQDR2eF8xkyF54ojktx9ay4=;
 b=cguFQ5XtdER+d4jVivNknTiz3iLnSu3OacDjRQ0sekUucHmKFm0ajFdsYcSoJngDfFntX4ajyyeKCJShtziuSdeWI4+XNPVtlbWiciDiUocXVqSVlxzLsRjSXBgsWII2fyilJHqVC7y5KGe3+e5RYFEuyG8xNRnt5Mj+7/yHqEovP4rqpLuFCZkfUZZjnc5JmaFF+RIdnLdQreTQLY8I/36illpMpA5iQKH5ccSEN9/vlOEGf+OyP8tTL3TQ1YFMGNODQ5LlnEkvOnr23jF8YEADIM81NTNEwFOl05yb3y1yD8YJn59hqdQI2wJ5DvpS4vIDf0Tlv1SwdsPh/8Idpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6XE8W8uZqKYv9EktZwC0DQDR2eF8xkyF54ojktx9ay4=;
 b=LC0IRYafhP1p0gWorJ8C4VcmROo16Lhqo4FMkmui8V8kzFhl86uhqTYqMpCrMU575cjMHp3O+a4IJsjB1HDfjYqGVVEVarrjJYKkWHfmyxc95puzxqBK8kzckWvlrV+2oB6yD2PE2Um4aE7FdHOrkUxLe8kN2rdaRDRrJdmtq4U=
Received: from PH0P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::19)
 by SJ0PR12MB6879.namprd12.prod.outlook.com (2603:10b6:a03:484::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.13; Thu, 4 Jan
 2024 15:53:23 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::9) by PH0P220CA0016.outlook.office365.com
 (2603:10b6:510:d3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.15 via Frontend
 Transport; Thu, 4 Jan 2024 15:53:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7159.9 via Frontend Transport; Thu, 4 Jan 2024 15:53:23 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 4 Jan
 2024 09:53:17 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/10] drm/amd/display: revert "for FPO & SubVP/DRR config
 program vmin/max"
Date: Thu, 4 Jan 2024 08:51:00 -0700
Message-ID: <20240104155238.454117-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104155238.454117-1-Rodrigo.Siqueira@amd.com>
References: <20240104155238.454117-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|SJ0PR12MB6879:EE_
X-MS-Office365-Filtering-Correlation-Id: a0e15224-7669-4740-5b1a-08dc0d3d481a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JFcdk77K+7+vZpida3NRJ31110rPiqhGe09FnvVee5Kp3EcAs1Fcms04RvMKCU7FnZ8Bp/5GxMj2Thsy1KOSM+tn2ASCZHIo8UVG3Nj1oDVdbe/yeWNnD7v3aSOjvQkOHLSgRnWe1gGgazODwI3OijDX1acC9tnitXiWbkhkgi/C8jQRlj6edlLhKL1chMWQ3tokW917vG1PllkM4Bk9y0v9BIkgpeBYbs12M22egFcFouahr+WJzB/DX0Ajh4fU1CgwHaDyKR4Bif77gCIcdPV1f0xggFr4qHRP2HxjNQvJ/0pQqgtV1LytL0BcrCP/+09BY23EAmG/3XvY25dsWuD8CAytTG2qyHclG9J+uGM1yDEZnO6O61PgyincWosVOSVPdv6b56skeIvmmb0L8KBx9gryXO1NJKB+NiZgoozVU9RAWiA07n4lVhPcorIogiiIBSYD9iimaF4mUsujX5DHmBdTObKrKpulX8CsQrLOL6w1EfvQgo4vqHgqfjNFyBEPZL3Jd+WYGB5l3oeK+lHaT3/Zhr1WhPfAhDshae1L4YwArdehX8eyhiy5TRlNvLtrHxsF57YsZfGqAIpyd0TVhLPP9xo99WiL7GGJ+HRWgKsMoYJDGcj34pKEgMAKm7qXOglru3J3xm0u4IEZBYkGqY/UNqX2ukg8bgLvb/D8ah/EETj7OoqvUSTi11VrzWr/ZdxeyKbWmtmjyNjSqV0INwz5NF6n/93Ag0N4CJmPtJQgUL7KOUyuHsh0QYrxKzzLMeBiQCDd1Vad2RzAxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(346002)(136003)(376002)(396003)(39860400002)(230922051799003)(82310400011)(451199024)(1800799012)(64100799003)(186009)(40470700004)(46966006)(36840700001)(1076003)(2616005)(47076005)(83380400001)(30864003)(2906002)(26005)(16526019)(81166007)(356005)(82740400003)(8936002)(6666004)(8676002)(316002)(41300700001)(54906003)(36860700001)(4326008)(478600001)(5660300002)(6916009)(70206006)(70586007)(426003)(336012)(86362001)(40480700001)(36756003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2024 15:53:23.1901 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0e15224-7669-4740-5b1a-08dc0d3d481a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6879
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
Cc: stylon.wang@amd.com, jerry.zuo@amd.com, Sunpeng.Li@amd.com,
 Martin Leung <martin.leung@amd.com>, Rodrigo
 Siqueira <rodrigo.siqueira@amd.com>, roman.li@amd.com, solomon.chiu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <martin.leung@amd.com>

This reverts commit 4b70dc8c46fc6e89dd1ce90d5ab7b620b25374f0.

The original commit causes issues with certain features when DRR is
disabled, need to revisit this change later after resolving issues with
new DRR policy.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Martin Leung <martin.leung@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 14 -------
 .../display/dc/dcn32/dcn32_resource_helpers.c | 14 +++++++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 11 +++---
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 37 -------------------
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  3 --
 .../dc/resource/dcn32/dcn32_resource.c        |  2 +-
 .../dc/resource/dcn32/dcn32_resource.h        |  3 ++
 .../dc/resource/dcn321/dcn321_resource.c      |  2 +-
 8 files changed, 24 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 57f0ddd15923..f2abc1096ffb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4986,20 +4986,6 @@ enum dc_status update_dp_encoder_resources_for_test_harness(const struct dc *dc,
 	return DC_OK;
 }
 
-bool resource_subvp_in_use(struct dc *dc,
-		struct dc_state *context)
-{
-	uint32_t i;
-
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-
-		if (dc_state_get_pipe_subvp_type(context, pipe) != SUBVP_NONE)
-			return true;
-	}
-	return false;
-}
-
 bool check_subvp_sw_cursor_fallback_req(const struct dc *dc, struct dc_stream_state *stream)
 {
 	if (!dc->debug.disable_subvp_high_refresh && is_subvp_high_refresh_candidate(stream))
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index e4a328b45c8a..87760600e154 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -183,6 +183,20 @@ bool dcn32_all_pipes_have_stream_and_plane(struct dc *dc,
 	return true;
 }
 
+bool dcn32_subvp_in_use(struct dc *dc,
+		struct dc_state *context)
+{
+	uint32_t i;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (dc_state_get_pipe_subvp_type(context, pipe) != SUBVP_NONE)
+			return true;
+	}
+	return false;
+}
+
 bool dcn32_mpo_in_use(struct dc_state *context)
 {
 	uint32_t i;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index aa68d010cbfd..9f37f717a1f8 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -33,7 +33,6 @@
 #include "dcn30/dcn30_resource.h"
 #include "link.h"
 #include "dc_state_priv.h"
-#include "resource.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -292,7 +291,7 @@ int dcn32_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,
 
 		/* for subvp + DRR case, if subvp pipes are still present we support pstate */
 		if (vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported &&
-				resource_subvp_in_use(dc, context))
+				dcn32_subvp_in_use(dc, context))
 			vba->DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] = temp_clock_change_support;
 
 		if (vlevel < context->bw_ctx.dml.vba.soc.num_states &&
@@ -2273,7 +2272,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	unsigned int dummy_latency_index = 0;
 	int maxMpcComb = context->bw_ctx.dml.vba.maxMpcComb;
 	unsigned int min_dram_speed_mts = context->bw_ctx.dml.vba.DRAMSpeed;
-	bool subvp_active = resource_subvp_in_use(dc, context);
+	bool subvp_in_use = dcn32_subvp_in_use(dc, context);
 	unsigned int min_dram_speed_mts_margin;
 	bool need_fclk_lat_as_dummy = false;
 	bool is_subvp_p_drr = false;
@@ -2282,7 +2281,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	dc_assert_fp_enabled();
 
 	/* need to find dummy latency index for subvp */
-	if (subvp_active) {
+	if (subvp_in_use) {
 		/* Override DRAMClockChangeSupport for SubVP + DRR case where the DRR cannot switch without stretching it's VBLANK */
 		if (!pstate_en) {
 			context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] = dm_dram_clock_change_vblank_w_mall_sub_vp;
@@ -2468,7 +2467,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 				dc->clk_mgr->bw_params->clk_table.entries[min_dram_speed_mts_offset].memclk_mhz * 16;
 		}
 
-		if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching && !subvp_active) {
+		if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching && !subvp_in_use) {
 			/* find largest table entry that is lower than dram speed,
 			 * but lower than DPM0 still uses DPM0
 			 */
@@ -3528,7 +3527,7 @@ void dcn32_set_clock_limits(const struct _vcs_dpi_soc_bounding_box_st *soc_bb)
 void dcn32_override_min_req_memclk(struct dc *dc, struct dc_state *context)
 {
 	// WA: restrict FPO and SubVP to use first non-strobe mode (DCN32 BW issue)
-	if ((context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || resource_subvp_in_use(dc, context)) &&
+	if ((context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || dcn32_subvp_in_use(dc, context)) &&
 			dc->dml.soc.num_chans <= 8) {
 		int num_mclk_levels = dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_memclk_levels;
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index bc71a9b058fe..0dfcb3cdcd20 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1882,42 +1882,6 @@ static void dcn20_program_pipe(
 	}
 }
 
-static void update_vmin_vmax_fams(struct dc *dc,
-		struct dc_state *context)
-{
-	uint32_t i;
-	struct drr_params params = {0};
-	bool subvp_in_use = resource_subvp_in_use(dc, context);
-
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-
-		if (resource_is_pipe_type(pipe, OTG_MASTER) &&
-				((subvp_in_use && dc_state_get_pipe_subvp_type(context, pipe) != SUBVP_PHANTOM &&
-				pipe->stream->allow_freesync) || (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching && pipe->stream->fpo_in_use))) {
-			if (!pipe->stream->vrr_active_variable && !pipe->stream->vrr_active_fixed) {
-				struct timing_generator *tg = context->res_ctx.pipe_ctx[i].stream_res.tg;
-
-				/* DRR should be configured already if we're in active variable
-				 * or active fixed, so only program if we're not in this state
-				 */
-				params.vertical_total_min = pipe->stream->timing.v_total;
-				params.vertical_total_max = pipe->stream->timing.v_total;
-				tg->funcs->set_drr(tg, &params);
-			}
-		} else {
-			if (resource_is_pipe_type(pipe, OTG_MASTER) &&
-					!pipe->stream->vrr_active_variable &&
-					!pipe->stream->vrr_active_fixed) {
-				struct timing_generator *tg = context->res_ctx.pipe_ctx[i].stream_res.tg;
-				params.vertical_total_min = 0;
-				params.vertical_total_max = 0;
-				tg->funcs->set_drr(tg, &params);
-			}
-		}
-	}
-}
-
 void dcn20_program_front_end_for_ctx(
 		struct dc *dc,
 		struct dc_state *context)
@@ -1994,7 +1958,6 @@ void dcn20_program_front_end_for_ctx(
 				&& context->res_ctx.pipe_ctx[i].stream)
 			hws->funcs.blank_pixel_data(dc, &context->res_ctx.pipe_ctx[i], true);
 
-	update_vmin_vmax_fams(dc, context);
 
 	/* Disconnect mpcc */
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 1d51fed12e20..c958ef37b78a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -609,9 +609,6 @@ bool dc_resource_acquire_secondary_pipe_for_mpc_odm_legacy(
 		struct pipe_ctx *sec_pipe,
 		bool odm);
 
-bool resource_subvp_in_use(struct dc *dc,
-		struct dc_state *context);
-
 /* A test harness interface that modifies dp encoder resources in the given dc
  * state and bypasses the need to revalidate. The interface assumes that the
  * test harness interface is called with pre-validated link config stored in the
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index ac04a9c9a3d8..c4d71e7f18af 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1899,7 +1899,7 @@ int dcn32_populate_dml_pipes_from_context(
 
 static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap,
-	.get_subvp_en = resource_subvp_in_use,
+	.get_subvp_en = dcn32_subvp_in_use,
 };
 
 void dcn32_calculate_wm_and_dlg(struct dc *dc, struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
index 62611acd4bcb..0c87b0fabba7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
@@ -131,6 +131,9 @@ void dcn32_merge_pipes_for_subvp(struct dc *dc,
 bool dcn32_all_pipes_have_stream_and_plane(struct dc *dc,
 		struct dc_state *context);
 
+bool dcn32_subvp_in_use(struct dc *dc,
+		struct dc_state *context);
+
 bool dcn32_mpo_in_use(struct dc_state *context);
 
 bool dcn32_any_surfaces_rotated(struct dc *dc, struct dc_state *context);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index e1ab207c46f1..74412e5f03fe 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1574,7 +1574,7 @@ static void dcn321_destroy_resource_pool(struct resource_pool **pool)
 
 static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap,
-	.get_subvp_en = resource_subvp_in_use,
+	.get_subvp_en = dcn32_subvp_in_use,
 };
 
 static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
-- 
2.43.0


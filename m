Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7EBC433F5
	for <amd-gfx@archiver.kernel.org>; Fri, 18 Mar 2022 21:50:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0930410E23B;
	Fri, 18 Mar 2022 21:50:22 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2080.outbound.protection.outlook.com [40.107.236.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F4CD10E23B
 for <amd-gfx@lists.freedesktop.org>; Fri, 18 Mar 2022 21:50:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e6AjGrMSM0WhR2uurHt2ltmzKzCuqWbsA5egAQhf2LlsZ4fiLesZZDQmRI2KEV6SPO3gcl85jfzh3eex9+ZjcWiPu4ykhnli1o0JtqRG1oqt2JK1fQo4JTnr13/9ZYPIm//vscRBknysLfQlaDAFGWsNVgVL/h/Ts+trKRS0OJ3EaDhoIXRkzDixUrsvr99v5k2i9MXyW4Ty0hjuVovm/YF+SOKiZn4pzGVJFj4K2Rn5rPrwYmaVOLxsogQkrRpjTOQVqCxeubfDQC8wrw0AVrlrXHDTlkABAASdRPFBQ3ZAEcK1YdIjb5bhMJvuFtbrmbSm8FqHehzYw2TQWmqsug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EwbktTKhxls+t1xmG0uqCDnir9c4v8n7kLl2yZrbvKg=;
 b=iO2Fhis6e0LrLa5iPJ9Stl+13MbvpPMkiM+P39YYu3CEW6sTQJ6vstmYIKaNAHPrD/T0GGlYoN65qVKCk8N2hFtW8LJAqIJ0Rl80W2uqhksQeVYHiIvo9nZQsQ8h+tVqrGCNxMWAnXcFoWQEJvGCar1PHrGuABgjOiBaN/TUuqWL9B91HsGActLfCOiURDD2/pIK429KXgFoUJhHqU7SZJFBFf8L7zK9yLUjoQwIlKyNvDrtwZul50JuG++cgSJ3qeEBOfnq/HnupjXEsmMrpQw2GuUmq6qyFRkhL2Z0I/nBW6hMR/l/FC7mRhHpLG4FWLm+ExH+ZLb4AHhO2cYW3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EwbktTKhxls+t1xmG0uqCDnir9c4v8n7kLl2yZrbvKg=;
 b=fHamnlHLZLBTrmK5TfpAjNRQhWC9lw+XP3K63K0mInonfnjEuhxgBTaHRStiq35C2LOQ6TqUM5KHMu0bkCLZVsUVLwpdLAzEHjTqjnhVJWJ7lSyi5rlBAlFMAIV5FcNISIQxSnVYGmeWWBwXEOx4OeReEuzJebt7fRuAkWW7tHQ=
Received: from MWHPR15CA0046.namprd15.prod.outlook.com (2603:10b6:300:ad::32)
 by CY4PR12MB1829.namprd12.prod.outlook.com (2603:10b6:903:11d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.15; Fri, 18 Mar
 2022 21:50:18 +0000
Received: from CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:ad:cafe::d4) by MWHPR15CA0046.outlook.office365.com
 (2603:10b6:300:ad::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.18 via Frontend
 Transport; Fri, 18 Mar 2022 21:50:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com;
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT051.mail.protection.outlook.com (10.13.174.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5081.14 via Frontend Transport; Fri, 18 Mar 2022 21:50:17 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 18 Mar
 2022 16:50:13 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 09/13] drm/amd/display: Add support for zstate during extended
 vblank
Date: Fri, 18 Mar 2022 15:47:56 -0600
Message-ID: <20220318214800.3565679-10-alex.hung@amd.com>
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
X-MS-Office365-Filtering-Correlation-Id: c97d3502-6872-44d5-2723-08da09294a7e
X-MS-TrafficTypeDiagnostic: CY4PR12MB1829:EE_
X-Microsoft-Antispam-PRVS: <CY4PR12MB18290EEA744F19596C70257BF7139@CY4PR12MB1829.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +VV2FGhXKnWS6XyOxFBQ1gbKp5oEuM1iJNjlm0Ue7XH5UkpVrd+RP4fepOouOhzh8AEEq4HlTC1KZuvVmRzAxskiZe9bTW3FSHMqJ1LDocEqKeqNx2rQlzzw+NmjYkQBfbCSHZ/xtsbeaXTprrNz9YuyXYXcdxgP41sj3JeXyy+eOKyEMxAnzUDWfjhVMc+QtvAWW6V+CvOYcMqVgwYn6ll89vchu9ipBoo/IgRZjtDxr1nb9685GGQw05rUV0J88Xa9lSQc5TOU3dJ13lOEHcQvUnttWLYTs/AIUqoW9Mb8tvw0U94xXXBC8IHS/uL4ZvbyhvXXxcI5vcX/7roxdd+BprtR872C8qv5JiuJQYUg0lM3fK7pVcPi6gLTyold4+ClNC+iHzOCSF9eAOBAsvD5mm9Sloil4mT2W9Y6NG8vmbH719eIT3bz9NV2uUTsYtqrnCJTKJX2fiyWaXcLx2MZqLXxJU+CQu9CPliLbxrVbZdykXphmppF5xvL3N7SwQYhjBxTfDVT/UMXjMmJwWANQP6SPgBpPnq+/XHR2l/WpFfbJWw7iXNDi6EJeaUPaBjIxAQTk0211M6WTHK63IcmHAn65Z5BOKknYy9x8C53fBqOx4/WekZTHesY9dnf+enUFVtbKaPS4gvxd81DSoLObfFBypSdWnzdK3A5LClPyYTuZiZr2tqkEoRGbJp1bGo2rx7LazbkuKz+aK771A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(356005)(7696005)(2906002)(82310400004)(81166007)(83380400001)(8936002)(508600001)(5660300002)(40460700003)(70206006)(86362001)(70586007)(4326008)(8676002)(6666004)(186003)(30864003)(44832011)(16526019)(426003)(2616005)(47076005)(336012)(26005)(316002)(36756003)(6916009)(1076003)(36860700001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2022 21:50:17.2718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c97d3502-6872-44d5-2723-08da09294a7e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT051.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR12MB1829
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
 Gabe Teeger <gabe.teeger@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Gabe Teeger <gabe.teeger@amd.com>

[why]
When we enter FREESYNC_STATE_VIDEO, we want to use the extra vblank
portion to enter zstate if possible.

[how]
When we enter freesync, a full update is triggered and the new vtotal
with extra lines is passed to dml in a stream update. The time gained
from extra vblank lines is calculated in microseconds. We allow zstate
entry if the time gained is greater than 5 ms, which is the current
policy. Furthermore, an optimized value for min_dst_y_next_start is
calculated and written to its register. When exiting freesync, another
full update is triggered and default values are restored.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 19 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/dc.h           |  6 +++++-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  2 ++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 12 ++++++++++++
 .../gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c |  8 ++++++++
 .../drm/amd/display/dc/dcn31/dcn31_resource.c |  1 +
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 18 +++++++++++++++---
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     | 13 +++++++++++++
 .../amd/display/dc/dml/display_mode_structs.h |  2 ++
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  3 +++
 10 files changed, 80 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 75f9c97bebb0..f2ad8f58e69c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2393,6 +2393,8 @@ static enum surface_update_type check_update_surfaces_for_stream(
 
 		if (stream_update->mst_bw_update)
 			su_flags->bits.mst_bw = 1;
+		if (stream_update->crtc_timing_adjust && dc_extended_blank_supported(dc))
+			su_flags->bits.crtc_timing_adjust = 1;
 
 		if (su_flags->raw != 0)
 			overall_type = UPDATE_TYPE_FULL;
@@ -2654,6 +2656,9 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	if (update->vrr_infopacket)
 		stream->vrr_infopacket = *update->vrr_infopacket;
 
+	if (update->crtc_timing_adjust)
+		stream->adjust = *update->crtc_timing_adjust;
+
 	if (update->dpms_off)
 		stream->dpms_off = *update->dpms_off;
 
@@ -4055,3 +4060,17 @@ void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bo
 	if (pipe->stream_res.abm && pipe->stream_res.abm->funcs->set_abm_pause)
 		pipe->stream_res.abm->funcs->set_abm_pause(pipe->stream_res.abm, !enable, i, pipe->stream_res.tg->inst);
 }
+/*
+ * dc_extended_blank_supported: Decide whether extended blank is supported
+ *
+ * Extended blank is a freesync optimization feature to be enabled in the future.
+ * During the extra vblank period gained from freesync, we have the ability to enter z9/z10.
+ *
+ * @param [in] dc: Current DC state
+ * @return: Indicate whether extended blank is supported (true or false)
+ */
+bool dc_extended_blank_supported(struct dc *dc)
+{
+	return dc->debug.extended_blank_optimization && !dc->debug.disable_z10
+		&& dc->caps.zstate_support && dc->caps.is_apu;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 116967b96b01..ced40fe218ac 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -188,6 +188,7 @@ struct dc_caps {
 	bool psp_setup_panel_mode;
 	bool extended_aux_timeout_support;
 	bool dmcub_support;
+	bool zstate_support;
 	uint32_t num_of_internal_disp;
 	enum dp_protocol_version max_dp_protocol_version;
 	unsigned int mall_size_per_mem_channel;
@@ -703,13 +704,14 @@ struct dc_debug_options {
 	bool enable_driver_sequence_debug;
 	enum det_size crb_alloc_policy;
 	int crb_alloc_policy_min_disp_count;
-#if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool disable_z10;
+#if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool enable_z9_disable_interface;
 	bool enable_sw_cntl_psr;
 	union dpia_debug_options dpia_debug;
 #endif
 	bool apply_vendor_specific_lttpr_wa;
+	bool extended_blank_optimization;
 	bool ignore_dpref_ss;
 	uint8_t psr_power_use_phy_fsm;
 };
@@ -1369,6 +1371,8 @@ struct dc_sink_init_data {
 	bool converter_disable_audio;
 };
 
+bool dc_extended_blank_supported(struct dc *dc);
+
 struct dc_sink *dc_sink_create(const struct dc_sink_init_data *init_params);
 
 /* Newer interfaces  */
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 99a750f561f8..c4168c11257c 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -131,6 +131,7 @@ union stream_update_flags {
 		uint32_t wb_update:1;
 		uint32_t dsc_changed : 1;
 		uint32_t mst_bw : 1;
+		uint32_t crtc_timing_adjust : 1;
 	} bits;
 
 	uint32_t raw;
@@ -289,6 +290,7 @@ struct dc_stream_update {
 	struct dc_3dlut *lut3d_func;
 
 	struct test_pattern *pending_test_pattern;
+	struct dc_crtc_timing_adjust *crtc_timing_adjust;
 };
 
 bool dc_is_stream_unchanged(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index ab910deed481..4290eaf11a04 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1857,6 +1857,7 @@ void dcn20_optimize_bandwidth(
 		struct dc_state *context)
 {
 	struct hubbub *hubbub = dc->res_pool->hubbub;
+	int i;
 
 	/* program dchubbub watermarks */
 	hubbub->funcs->program_watermarks(hubbub,
@@ -1873,6 +1874,17 @@ void dcn20_optimize_bandwidth(
 			dc->clk_mgr,
 			context,
 			true);
+	if (dc_extended_blank_supported(dc) && context->bw_ctx.bw.dcn.clk.zstate_support == DCN_ZSTATE_SUPPORT_ALLOW) {
+		for (i = 0; i < dc->res_pool->pipe_count; ++i) {
+			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+			if (pipe_ctx->stream && pipe_ctx->plane_res.hubp->funcs->program_extended_blank
+				&& pipe_ctx->stream->adjust.v_total_min == pipe_ctx->stream->adjust.v_total_max
+				&& pipe_ctx->stream->adjust.v_total_max > pipe_ctx->stream->timing.v_total)
+					pipe_ctx->plane_res.hubp->funcs->program_extended_blank(pipe_ctx->plane_res.hubp,
+						pipe_ctx->dlg_regs.optimized_min_dst_y_next_start);
+		}
+	}
 	/* increase compbuf size */
 	if (hubbub->funcs->program_compbuf_size)
 		hubbub->funcs->program_compbuf_size(hubbub, context->bw_ctx.bw.dcn.compbuf_size_kb, true);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
index 53b792b997b7..8ae6117953ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hubp.c
@@ -54,6 +54,13 @@ void hubp31_soft_reset(struct hubp *hubp, bool reset)
 	REG_UPDATE(DCHUBP_CNTL, HUBP_SOFT_RESET, reset);
 }
 
+void hubp31_program_extended_blank(struct hubp *hubp, unsigned int min_dst_y_next_start_optimized)
+{
+	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+
+	REG_SET(BLANK_OFFSET_1, 0, MIN_DST_Y_NEXT_START, min_dst_y_next_start_optimized);
+}
+
 static struct hubp_funcs dcn31_hubp_funcs = {
 	.hubp_enable_tripleBuffer = hubp2_enable_triplebuffer,
 	.hubp_is_triplebuffer_enabled = hubp2_is_triplebuffer_enabled,
@@ -80,6 +87,7 @@ static struct hubp_funcs dcn31_hubp_funcs = {
 	.set_unbounded_requesting = hubp31_set_unbounded_requesting,
 	.hubp_soft_reset = hubp31_soft_reset,
 	.hubp_in_blank = hubp1_in_blank,
+	.program_extended_blank = hubp31_program_extended_blank,
 };
 
 bool hubp31_construct(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
index 89b7b6b7254a..338235bcef4a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_resource.c
@@ -2232,6 +2232,7 @@ static bool dcn31_resource_construct(
 	dc->caps.extended_aux_timeout_support = true;
 	dc->caps.dmcub_support = true;
 	dc->caps.is_apu = true;
+	dc->caps.zstate_support = true;
 
 	/* Color pipeline capabilities */
 	dc->caps.color.dpp.dcn_arch = 1;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 2f6122153bdb..f93af45aeab4 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -722,8 +722,10 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 {
 	int plane_count;
 	int i;
+	unsigned int optimized_min_dst_y_next_start_us;
 
 	plane_count = 0;
+	optimized_min_dst_y_next_start_us = 0;
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (context->res_ctx.pipe_ctx[i].plane_state)
 			plane_count++;
@@ -744,11 +746,22 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 		struct dc_link *link = context->streams[0]->sink->link;
 		struct dc_stream_status *stream_status = &context->stream_status[0];
 
+		if (dc_extended_blank_supported(dc)) {
+			for (i = 0; i < dc->res_pool->pipe_count; i++) {
+				if (context->res_ctx.pipe_ctx[i].stream == context->streams[0]
+					&& context->res_ctx.pipe_ctx[i].stream->adjust.v_total_min == context->res_ctx.pipe_ctx[i].stream->adjust.v_total_max
+					&& context->res_ctx.pipe_ctx[i].stream->adjust.v_total_min > context->res_ctx.pipe_ctx[i].stream->timing.v_total) {
+						optimized_min_dst_y_next_start_us =
+							context->res_ctx.pipe_ctx[i].dlg_regs.optimized_min_dst_y_next_start_us;
+						break;
+				}
+			}
+		}
 		/* zstate only supported on PWRSEQ0  and when there's <2 planes*/
 		if (link->link_index != 0 || stream_status->plane_count > 1)
 			return DCN_ZSTATE_SUPPORT_DISALLOW;
 
-		if (context->bw_ctx.dml.vba.StutterPeriod > 5000.0)
+		if (context->bw_ctx.dml.vba.StutterPeriod > 5000.0 || optimized_min_dst_y_next_start_us > 5000)
 			return DCN_ZSTATE_SUPPORT_ALLOW;
 		else if (link->psr_settings.psr_version == DC_PSR_VERSION_1 && !dc->debug.disable_psr)
 			return DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY;
@@ -786,8 +799,6 @@ void dcn20_calculate_dlg_params(
 							!= dm_dram_clock_change_unsupported;
 	context->bw_ctx.bw.dcn.clk.dppclk_khz = 0;
 
-	context->bw_ctx.bw.dcn.clk.zstate_support = decide_zstate_support(dc, context);
-
 	context->bw_ctx.bw.dcn.clk.dtbclk_en = is_dtbclk_required(dc, context);
 
 	if (context->bw_ctx.bw.dcn.clk.dispclk_khz < dc->debug.min_disp_clk_khz)
@@ -843,6 +854,7 @@ void dcn20_calculate_dlg_params(
 				&pipes[pipe_idx].pipe);
 		pipe_idx++;
 	}
+	context->bw_ctx.bw.dcn.clk.zstate_support = decide_zstate_support(dc, context);
 }
 
 static void swizzle_to_dml_params(
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
index e0fecf127bd5..53d760e169e6 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
@@ -1055,6 +1055,7 @@ static void dml_rq_dlg_get_dlg_params(
 
 	float vba__refcyc_per_req_delivery_pre_l = get_refcyc_per_req_delivery_pre_l_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;  // From VBA
 	float vba__refcyc_per_req_delivery_l = get_refcyc_per_req_delivery_l_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;  // From VBA
+	int blank_lines;
 
 	memset(disp_dlg_regs, 0, sizeof(*disp_dlg_regs));
 	memset(disp_ttu_regs, 0, sizeof(*disp_ttu_regs));
@@ -1080,6 +1081,18 @@ static void dml_rq_dlg_get_dlg_params(
 	dlg_vblank_start = interlaced ? (vblank_start / 2) : vblank_start;
 
 	disp_dlg_regs->min_dst_y_next_start = (unsigned int) (((double) dlg_vblank_start) * dml_pow(2, 2));
+	blank_lines = (dst->vblank_end + dst->vtotal_min - dst->vblank_start - dst->vstartup_start - 1);
+	if (blank_lines < 0)
+		blank_lines = 0;
+	if (blank_lines != 0) {
+		disp_dlg_regs->optimized_min_dst_y_next_start_us =
+			((unsigned int) blank_lines * dst->hactive) / (unsigned int) dst->pixel_rate_mhz;
+		disp_dlg_regs->optimized_min_dst_y_next_start =
+			(unsigned int)(((double) (dlg_vblank_start + blank_lines)) * dml_pow(2, 2));
+	} else {
+		// use unoptimized value
+		disp_dlg_regs->optimized_min_dst_y_next_start = disp_dlg_regs->min_dst_y_next_start;
+	}
 	ASSERT(disp_dlg_regs->min_dst_y_next_start < (unsigned int)dml_pow(2, 18));
 
 	dml_print("DML_DLG: %s: min_ttu_vblank (us)         = %3.2f\n", __func__, min_ttu_vblank);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 59f0a61c33cf..2df660cd8801 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -446,6 +446,8 @@ struct _vcs_dpi_display_dlg_regs_st {
 	unsigned int refcyc_h_blank_end;
 	unsigned int dlg_vblank_end;
 	unsigned int min_dst_y_next_start;
+	unsigned int optimized_min_dst_y_next_start;
+	unsigned int optimized_min_dst_y_next_start_us;
 	unsigned int refcyc_per_htotal;
 	unsigned int refcyc_x_after_scaler;
 	unsigned int dst_y_after_scaler;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index e45b7993c5c5..ad69d78c4ac3 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -195,6 +195,9 @@ struct hubp_funcs {
 
 	void (*hubp_set_flip_int)(struct hubp *hubp);
 
+	void (*program_extended_blank)(struct hubp *hubp,
+			unsigned int min_dst_y_next_start_optimized);
+
 	void (*hubp_wait_pipe_read_start)(struct hubp *hubp);
 };
 
-- 
2.35.1


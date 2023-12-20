Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27572C46CD3
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Dec 2023 16:37:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 94B8F10E5F1;
	Wed, 20 Dec 2023 16:37:14 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9355410E5F1
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Dec 2023 16:37:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dd1VoytO88MN8koEPgfIORpL+9d+8hxJAVmnUlwUZb5YVsWNHH1s3QR+biJvL5487NMnDE9DSSUPpCOTKqCh7MAdsgwMp1dGx8qQbJvW9IAN2DANOP96nOicUjFnVYstfUslol7RKjLe4du4GGwZuJ2j+m+95U5kamdGarOgFf+W/9VprqseJ9MU3eW6eflTAU0Ee41/sNxKxwDVsuS/18gdi+OGogUKrVgRQJGdyf8MD/Bmyv6RP24TNeW21EAbl/sM/mlTpSYwJLe0DyKoHrEe5kIf8ppKUHnrkKJ2fXhJjvhXKdSSDGI9ZHYjtBp9k8J3QyI2SIhUkDTPNtBmIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OooKU7H1Q1dNRBig2pW12X7Jc1s5+btEwB40meP9jv4=;
 b=bCCoc7F3GM0B5iK3ttzaGJA3HbJOHxZSKXOLJI3vjLJFhH4R7E/MHwaS/P8ttOVAAd+x2vx3PqVfvug31wCmTbyYWKbVVdvk8mK9mWJGuItIsX79RPVUDWg/jMAlwr+S7bEipf/hv+/dtekA2qc0UJHYdmfdQXcHmWne98OSq/OTFXu1vyQRrkcRfl+WnmK0taS95nK93I/qRlPQjsChtGIaSJO3doZkvsrDdM5ZJA9LMsZko5I/2+0IG69OrPo05vv9YYliHc/NQYlw2fnFehsF/cvmD/bYBGmi5dMY66UczMpNS0C7oe3Nb/AqxMESfSqSUF3ehKaNp0CGCEWpYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OooKU7H1Q1dNRBig2pW12X7Jc1s5+btEwB40meP9jv4=;
 b=hbUSuZharEIiQx1wkZ9VnpgYTIfgC2BU4mfWxizFxmJfGdUtOHW2fT/cej6k9rfzSYe/i9kEiHXFcQI5ci1nUM5TvO3dP/qHmxZHDBnoAZgD78EIEUzVeG4I2wBfaHY1ic2JiYSJoX/U98AvPjUlA4OCMDr9FnuH6lHxg6rObfA=
Received: from MN2PR16CA0058.namprd16.prod.outlook.com (2603:10b6:208:234::27)
 by DM6PR12MB4057.namprd12.prod.outlook.com (2603:10b6:5:213::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 16:37:11 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:234:cafe::f1) by MN2PR16CA0058.outlook.office365.com
 (2603:10b6:208:234::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.38 via Frontend
 Transport; Wed, 20 Dec 2023 16:37:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Wed, 20 Dec 2023 16:37:10 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 20 Dec
 2023 10:37:06 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/20] drm/amd/display: For FPO and SubVP/DRR configs program
 vmin/max sel
Date: Wed, 20 Dec 2023 09:33:47 -0700
Message-ID: <20231220163538.1742834-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
References: <20231220163538.1742834-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|DM6PR12MB4057:EE_
X-MS-Office365-Filtering-Correlation-Id: e3400329-5aef-4661-467a-08dc0179ea0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Eu1IyBj4IJjel+Bbi4KylaeICUoUw+Jyoz84xf+EjzyKcdR3tVCc6FMAE45g303wPIxia5O0SQLJyzXPHWE7Di/YI1bd4u3n4jUlYZfbdfjwhsOotkmz+Ag7TsYWRpBd+C1pUrU+onXGiFH2hurkDkhGfoJFGN4EPjbgx/GKOH+J7YoNNWjbhHR6wmMqZzO/qVl19JiQu00QjQkWGRNPYQTD7xVSvF+FmyMADNBWIzHb6jrlqQ+wMpwlCCkhgXLmNK80PXqPWY7BRaIs/TaKVtA2KwjBvHgQU/hSCWQC1qWLlEOxk4glrGUdaeye02tOAF9iAXMFgQV2inI7EklC764fwbo4XCbWtI/LrtihYpqLiaPJIGrbC4iTOIdY82/AK1qE23Qaqw6rDRKIie6fb03wnCwjMPEorJNwgbOHWOFBpGesJG0UKkOEDeBwrwBwoDVSCnt5jaxYDHz8oy7nMl49PuYecLrALDad/LcokI1/ToK4xlTNl6zsvLoQtNarbCkUd32oDweNgtrgfED/Kg7MY8W7qO7kWMpcRbZVn/j7RirwkzeDh9W4YPY1cT23BCCuUyNuwGBVI+88JcofL1jSUz7jyHbqlUHV7v4vv4xSAHRSeOzaMijRzr3pPT2HH7PiotxripEvzCyU3cv8yqCl/gJmGeqDj//30o65M4VqVXsluILGbEE0g78nP/iwlROvTf7c2aeEV08GF5sqe0YPP/mZNHQy/Jjjz4qI+B6ZSZzmhTNlXvJmIgafyrdez9GYm0/lRB3zjtCR7FGz2g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(39860400002)(346002)(136003)(396003)(230922051799003)(451199024)(1800799012)(186009)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(36860700001)(2906002)(41300700001)(86362001)(81166007)(36756003)(47076005)(82740400003)(356005)(6666004)(54906003)(6916009)(8936002)(8676002)(70586007)(70206006)(336012)(426003)(16526019)(1076003)(4326008)(5660300002)(30864003)(26005)(83380400001)(2616005)(316002)(478600001)(40480700001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 16:37:10.8708 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e3400329-5aef-4661-467a-08dc0179ea0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4057
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
Cc: stylon.wang@amd.com, Aric Cyr <aric.cyr@amd.com>, chiahsuan.chung@amd.com,
 Sunpeng.Li@amd.com, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 roman.li@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hersenxs.wu@amd.com, Alvin
 Lee <alvin.lee2@amd.com>, wayne.lin@amd.com, Harry.Wentland@amd.com,
 agustin.gutierrez@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

For FPO and SubVP/DRR cases we need to ensure to program
OTG_V_TOTAL_MIN/MAX_SEL, otherwise stretching the vblank in FPO / SubVP
/ DRR cases will not have any effect and we could hit underflow /
corruption.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 14 +++++++
 .../display/dc/dcn32/dcn32_resource_helpers.c | 14 -------
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 11 +++---
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 37 +++++++++++++++++++
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  3 ++
 .../dc/resource/dcn32/dcn32_resource.c        |  2 +-
 .../dc/resource/dcn32/dcn32_resource.h        |  3 --
 .../dc/resource/dcn321/dcn321_resource.c      |  2 +-
 8 files changed, 62 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index f2abc1096ffb..57f0ddd15923 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -4986,6 +4986,20 @@ enum dc_status update_dp_encoder_resources_for_test_harness(const struct dc *dc,
 	return DC_OK;
 }
 
+bool resource_subvp_in_use(struct dc *dc,
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
 bool check_subvp_sw_cursor_fallback_req(const struct dc *dc, struct dc_stream_state *stream)
 {
 	if (!dc->debug.disable_subvp_high_refresh && is_subvp_high_refresh_candidate(stream))
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index f698a7e63291..44ba1edb7f53 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -183,20 +183,6 @@ bool dcn32_all_pipes_have_stream_and_plane(struct dc *dc,
 	return true;
 }
 
-bool dcn32_subvp_in_use(struct dc *dc,
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
 bool dcn32_mpo_in_use(struct dc_state *context)
 {
 	uint32_t i;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 9f37f717a1f8..aa68d010cbfd 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -33,6 +33,7 @@
 #include "dcn30/dcn30_resource.h"
 #include "link.h"
 #include "dc_state_priv.h"
+#include "resource.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -291,7 +292,7 @@ int dcn32_find_dummy_latency_index_for_fw_based_mclk_switch(struct dc *dc,
 
 		/* for subvp + DRR case, if subvp pipes are still present we support pstate */
 		if (vba->DRAMClockChangeSupport[vlevel][vba->maxMpcComb] == dm_dram_clock_change_unsupported &&
-				dcn32_subvp_in_use(dc, context))
+				resource_subvp_in_use(dc, context))
 			vba->DRAMClockChangeSupport[vlevel][context->bw_ctx.dml.vba.maxMpcComb] = temp_clock_change_support;
 
 		if (vlevel < context->bw_ctx.dml.vba.soc.num_states &&
@@ -2272,7 +2273,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	unsigned int dummy_latency_index = 0;
 	int maxMpcComb = context->bw_ctx.dml.vba.maxMpcComb;
 	unsigned int min_dram_speed_mts = context->bw_ctx.dml.vba.DRAMSpeed;
-	bool subvp_in_use = dcn32_subvp_in_use(dc, context);
+	bool subvp_active = resource_subvp_in_use(dc, context);
 	unsigned int min_dram_speed_mts_margin;
 	bool need_fclk_lat_as_dummy = false;
 	bool is_subvp_p_drr = false;
@@ -2281,7 +2282,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	dc_assert_fp_enabled();
 
 	/* need to find dummy latency index for subvp */
-	if (subvp_in_use) {
+	if (subvp_active) {
 		/* Override DRAMClockChangeSupport for SubVP + DRR case where the DRR cannot switch without stretching it's VBLANK */
 		if (!pstate_en) {
 			context->bw_ctx.dml.vba.DRAMClockChangeSupport[vlevel][maxMpcComb] = dm_dram_clock_change_vblank_w_mall_sub_vp;
@@ -2467,7 +2468,7 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 				dc->clk_mgr->bw_params->clk_table.entries[min_dram_speed_mts_offset].memclk_mhz * 16;
 		}
 
-		if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching && !subvp_in_use) {
+		if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching && !subvp_active) {
 			/* find largest table entry that is lower than dram speed,
 			 * but lower than DPM0 still uses DPM0
 			 */
@@ -3527,7 +3528,7 @@ void dcn32_set_clock_limits(const struct _vcs_dpi_soc_bounding_box_st *soc_bb)
 void dcn32_override_min_req_memclk(struct dc *dc, struct dc_state *context)
 {
 	// WA: restrict FPO and SubVP to use first non-strobe mode (DCN32 BW issue)
-	if ((context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || dcn32_subvp_in_use(dc, context)) &&
+	if ((context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || resource_subvp_in_use(dc, context)) &&
 			dc->dml.soc.num_chans <= 8) {
 		int num_mclk_levels = dc->clk_mgr->bw_params->clk_table.num_entries_per_clk.num_memclk_levels;
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 0dfcb3cdcd20..bc71a9b058fe 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -1882,6 +1882,42 @@ static void dcn20_program_pipe(
 	}
 }
 
+static void update_vmin_vmax_fams(struct dc *dc,
+		struct dc_state *context)
+{
+	uint32_t i;
+	struct drr_params params = {0};
+	bool subvp_in_use = resource_subvp_in_use(dc, context);
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (resource_is_pipe_type(pipe, OTG_MASTER) &&
+				((subvp_in_use && dc_state_get_pipe_subvp_type(context, pipe) != SUBVP_PHANTOM &&
+				pipe->stream->allow_freesync) || (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching && pipe->stream->fpo_in_use))) {
+			if (!pipe->stream->vrr_active_variable && !pipe->stream->vrr_active_fixed) {
+				struct timing_generator *tg = context->res_ctx.pipe_ctx[i].stream_res.tg;
+
+				/* DRR should be configured already if we're in active variable
+				 * or active fixed, so only program if we're not in this state
+				 */
+				params.vertical_total_min = pipe->stream->timing.v_total;
+				params.vertical_total_max = pipe->stream->timing.v_total;
+				tg->funcs->set_drr(tg, &params);
+			}
+		} else {
+			if (resource_is_pipe_type(pipe, OTG_MASTER) &&
+					!pipe->stream->vrr_active_variable &&
+					!pipe->stream->vrr_active_fixed) {
+				struct timing_generator *tg = context->res_ctx.pipe_ctx[i].stream_res.tg;
+				params.vertical_total_min = 0;
+				params.vertical_total_max = 0;
+				tg->funcs->set_drr(tg, &params);
+			}
+		}
+	}
+}
+
 void dcn20_program_front_end_for_ctx(
 		struct dc *dc,
 		struct dc_state *context)
@@ -1958,6 +1994,7 @@ void dcn20_program_front_end_for_ctx(
 				&& context->res_ctx.pipe_ctx[i].stream)
 			hws->funcs.blank_pixel_data(dc, &context->res_ctx.pipe_ctx[i], true);
 
+	update_vmin_vmax_fams(dc, context);
 
 	/* Disconnect mpcc */
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index c958ef37b78a..1d51fed12e20 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -609,6 +609,9 @@ bool dc_resource_acquire_secondary_pipe_for_mpc_odm_legacy(
 		struct pipe_ctx *sec_pipe,
 		bool odm);
 
+bool resource_subvp_in_use(struct dc *dc,
+		struct dc_state *context);
+
 /* A test harness interface that modifies dp encoder resources in the given dc
  * state and bypasses the need to revalidate. The interface assumes that the
  * test harness interface is called with pre-validated link config stored in the
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
index c4d71e7f18af..ac04a9c9a3d8 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.c
@@ -1899,7 +1899,7 @@ int dcn32_populate_dml_pipes_from_context(
 
 static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap,
-	.get_subvp_en = dcn32_subvp_in_use,
+	.get_subvp_en = resource_subvp_in_use,
 };
 
 void dcn32_calculate_wm_and_dlg(struct dc *dc, struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
index 0c87b0fabba7..62611acd4bcb 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn32/dcn32_resource.h
@@ -131,9 +131,6 @@ void dcn32_merge_pipes_for_subvp(struct dc *dc,
 bool dcn32_all_pipes_have_stream_and_plane(struct dc *dc,
 		struct dc_state *context);
 
-bool dcn32_subvp_in_use(struct dc *dc,
-		struct dc_state *context);
-
 bool dcn32_mpo_in_use(struct dc_state *context);
 
 bool dcn32_any_surfaces_rotated(struct dc *dc, struct dc_state *context);
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
index 74412e5f03fe..e1ab207c46f1 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn321/dcn321_resource.c
@@ -1574,7 +1574,7 @@ static void dcn321_destroy_resource_pool(struct resource_pool **pool)
 
 static struct dc_cap_funcs cap_funcs = {
 	.get_dcc_compression_cap = dcn20_get_dcc_compression_cap,
-	.get_subvp_en = dcn32_subvp_in_use,
+	.get_subvp_en = resource_subvp_in_use,
 };
 
 static void dcn321_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params)
-- 
2.42.0


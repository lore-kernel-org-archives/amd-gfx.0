Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE58F513E9
	for <amd-gfx@archiver.kernel.org>; Fri,  6 Mar 2026 03:27:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A968310E30A;
	Fri,  6 Mar 2026 03:27:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DrQUb9WJ";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013044.outbound.protection.outlook.com
 [40.107.201.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 05C0810E30A
 for <amd-gfx@lists.freedesktop.org>; Fri,  6 Mar 2026 03:27:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dgKxUPM8SAiE7roFwbECcr1XaMH7bofZEVQz2h4wpRJPkK53rPywrIIzWA6HUmi6Mf7Pc2G1aUnzB1c38j1KPSfrHvIas/EUZ+8cs2lZ1P4OcGIPFbGpkJQkFWKt1KusebvdRySOvjbn3PjHKCPeUKkjVOsPfl70XUvj0dPFwK7GxbTPMf3pZbB5oSbEE/m5Qr7zlQjFa5nFwstbsMjc4yWN4gDumCsO9Gjg/KgC/zraYfWiomMTWaGHPEiCrhps7NXpVoos4+tDfip+r7zWmo41gJ3qVdRlmkuUv9yeFqSNLeCPA/2gP9xeabBO8gpvrb4WckIWyn0UbEuiGkkDTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3blPCGASG/Gyybcqb/5ZtYYrL8jv+2GViaaWLe868rY=;
 b=wkdt3To5OhOLbkfq1+CJeN7n3ch5uSL/qqD6EX+yHOWW0vOXv5CBRmsy/3TEo1W5+toQ9ffoKfdchRdibXKictRE8vGhJItsuHgczYtDvcquDnD9MSxNZ/M1y7e5MCYrIyvx/Bo3sw71vUwPAZXCH+i68gOrAZUwz8A5aja7SeRV/Ayu41Odiz+YF4SyYvcTmYXNYsz3s65VVNXkUuQwTDh1neC0lPtwDyRwV/XzdPdYw0cJIXD5wMzE9OQZHS4RL//1UD8pu6AgImU/i1uxHioARKhP8YYwCnTgoEoqGNwm8kOdioA1F3GSjWKCejtnYPHMVqX5lMBSgk8CKklh7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3blPCGASG/Gyybcqb/5ZtYYrL8jv+2GViaaWLe868rY=;
 b=DrQUb9WJCsgZ432qRX2WI2glsyKn67nAutkTGUGU3Al60qk7jbfTc+hJLAWcL+1TNz9KXX7p9/kkKs9UxS71kp5CtyUJmVYLUIBmQyQRUkrvzdCae5g/x8cTswlQP2lll5sN2ViIULKfjwnoUBOp3FmFVogVdECELmEMsrt1TSg=
Received: from BLAPR03CA0046.namprd03.prod.outlook.com (2603:10b6:208:32d::21)
 by DS0PR12MB9397.namprd12.prod.outlook.com (2603:10b6:8:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.17; Fri, 6 Mar
 2026 03:27:22 +0000
Received: from BL6PEPF0001AB4B.namprd04.prod.outlook.com
 (2603:10b6:208:32d:cafe::fb) by BLAPR03CA0046.outlook.office365.com
 (2603:10b6:208:32d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.23 via Frontend Transport; Fri,
 6 Mar 2026 03:27:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB4B.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Fri, 6 Mar 2026 03:27:22 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 5 Mar
 2026 21:27:20 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, Clay King <clayking@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 16/21] drm/amd/display: Clean up unused code
Date: Thu, 5 Mar 2026 20:13:42 -0700
Message-ID: <20260306031932.136179-17-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260306031932.136179-1-alex.hung@amd.com>
References: <20260306031932.136179-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4B:EE_|DS0PR12MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c440f9e-d728-4ac5-dc96-08de7b304795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014; 
X-Microsoft-Antispam-Message-Info: qQlFNQkQCvc9cCDoN1KxkHDy5odzkQ+61Eaz5IBfI3sWlcYq30f4zViZYrms/HOs3kknF5BN1Dr2IDcEEiWSVGJEXWjMb6fCq/ZS8bpJOSoS9uFQHoERxovVRpQ5xD6g/TP0iEEfVDCKp9uFQF2KId6HLYgOaUuQfHvl5AEcvw1h5/cOEd7AJ+SKFcg9D4Xqhj1mOXzCi8BB082Gy7i2pUpGd39jxdKQyTOU0utx2tlRg9K85xwthsPoHLqPMHM6ooK39Qo8RBfWJ0q+Rdg+32oWcjjQkfQVQTGhjD0x+gkBwIX3Zleo3h0EYdA+PjyxT1TX8FkG/1wnvPONTAS/Kdn/GhD/azGFBEeithQ3kHrO8iGLMVYs1nvJ2m1kNX2YBXaqZ0pZEkUV2n/WLd006t7m7KSA03zA37BJv3+lADiaknLDxxBt/tDa27QiCKVGNF4gEFhzsg0PSxn+2lDaXFWUgKmE/ykJhQF3himCEp/FjJsm6FLDgTDdzpf9IjrV+YWnypBMrGVt3GZhTZHaEQ+y1kXP6o3hn5XNnHmWeg5xVQUFNswjE7kZxZspFUq89411/dMTYMzm9yuNdkb7NHZI/yBJSS7R0/D40N2OTRIK7e7wrifwGcFccnr0SYEz5Be03fmM2al5ppMEKB/DsDQk37Euop/bpH5L8tbnALCwnRIwYifU2gJAYTLReolYcwnCmUsoIghjbTwvq7N532G2OXUfoAz/9ith7hVX9HGt9RxumsUsMEL9jQyWvP180XupTRsK61OXYF9G2Hq4CA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: BKt5ExKy/Zi8iMTUWsLmxkjA+dJgwqAuUKqqhCzZ+erQoo1K7eq7P/ry7BotqBEJ1ZW5ovrjJBbDWl6SsbfQZOwtfU0vkbZZqvLRHDwV883GOm5JiPX4c/u1zBSk9ccqeJehfhZSbY0FGGWMAbigorpgXXqn+CYJOrbE8Lw2pqtSsN1rF0PV0de1wHvbk1F2SAUt6bttiiCIhO6LWCSz5f8vFuoxTFXM14O+T3RK4+EzlPlg3nHk/2bnfXv1eC+Oju21w5oInVi21Or1lkeHMRedLbDyqHV7RI+rnuKgeRamjixbV51tW+rAt9z200u/kg8RXfjxBleirGghxZSxfkjVkq1fTJuZBUWYWq1s9RE6W5d6CLW/KKU68y7Mnp2MexHdEa+AcyCB3TKX7TQbvVj6vV73+4Ahov8OzlUeg9JWytDcFsGbpWjq9XW+v41Y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2026 03:27:22.2404 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c440f9e-d728-4ac5-dc96-08de7b304795
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9397
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

From: Clay King <clayking@amd.com>

[WHAT]
Silence warning by cleaning up unused code.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Clay King <clayking@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 .../display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c  |  1 +
 .../gpu/drm/amd/display/dc/core/dc_resource.c |  1 -
 drivers/gpu/drm/amd/display/dc/dc_trace.h     |  4 +--
 .../display/dc/hubbub/dcn401/dcn401_hubbub.c  |  4 ---
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 24 +++++++-------
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 32 +++++++------------
 .../amd/display/dc/hwss/dcn31/dcn31_hwseq.c   |  1 -
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   | 12 +++----
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  9 ------
 .../drm/amd/display/dc/link/link_detection.c  | 12 +------
 .../link/protocols/link_edp_panel_control.c   |  2 --
 .../drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c  |  4 +--
 .../dc/resource/dcn20/dcn20_resource.c        |  2 --
 13 files changed, 35 insertions(+), 73 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
index ef77fcd164ed..f2a716e1e732 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn30/dcn30_clk_mgr.c
@@ -547,6 +547,7 @@ void dcn3_clk_mgr_construct(
 	/* in case we don't get a value from the register, use default */
 	if (clk_mgr->base.dentist_vco_freq_khz == 0)
 		clk_mgr->base.dentist_vco_freq_khz = 3650000;
+
 	/* Convert dprefclk units from MHz to KHz */
 	/* Value already divided by 10, some resolution lost */
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index c9fbb64d706a..8271b12c1a66 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -2431,7 +2431,6 @@ static void resource_log_pipe_for_stream(struct dc *dc, struct dc_state *state,
 
 	int slice_idx, dpp_idx, plane_idx, slice_count, dpp_count;
 	bool is_primary;
-	DC_LOGGER_INIT(dc->ctx->logger);
 
 	slice_count = resource_get_opp_heads_for_otg_master(otg_master,
 			&state->res_ctx, opp_heads);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_trace.h b/drivers/gpu/drm/amd/display/dc/dc_trace.h
index bbec308a3a5e..b7a011646d53 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_trace.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_trace.h
@@ -23,8 +23,8 @@
 
 #include "amdgpu_dm_trace.h"
 
-#define TRACE_DC_PIPE_STATE(pipe_ctx, index, max_pipes) \
-	for (index = 0; index < max_pipes; ++index) { \
+#define TRACE_DC_PIPE_STATE(pipe_ctx, max_pipes) \
+	for (int index = 0; index < max_pipes; ++index) { \
 		struct pipe_ctx *pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[index]; \
 		if (pipe_ctx->plane_state) \
 			trace_amdgpu_dm_dc_pipe_state(pipe_ctx->pipe_idx, pipe_ctx->plane_state, \
diff --git a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
index 941dce439e97..b0a4b68cf359 100644
--- a/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
+++ b/drivers/gpu/drm/amd/display/dc/hubbub/dcn401/dcn401_hubbub.c
@@ -1151,8 +1151,6 @@ void dcn401_program_compbuf_segments(struct hubbub *hubbub, unsigned compbuf_siz
 {
 	struct dcn20_hubbub *hubbub2 = TO_DCN20_HUBBUB(hubbub);
 
-	unsigned int cur_compbuf_size_seg = 0;
-
 	if (safe_to_increase || compbuf_size_seg <= hubbub2->compbuf_size_segments) {
 		if (compbuf_size_seg > hubbub2->compbuf_size_segments) {
 			REG_WAIT(DCHUBBUB_DET0_CTRL, DET0_SIZE_CURRENT, hubbub2->det0_size, 1, 100);
@@ -1165,8 +1163,6 @@ void dcn401_program_compbuf_segments(struct hubbub *hubbub, unsigned compbuf_siz
 				+ hubbub2->det3_size + compbuf_size_seg <= hubbub2->crb_size_segs);
 		REG_UPDATE(DCHUBBUB_COMPBUF_CTRL, COMPBUF_SIZE, compbuf_size_seg);
 		hubbub2->compbuf_size_segments = compbuf_size_seg;
-
-		ASSERT(REG_GET(DCHUBBUB_COMPBUF_CTRL, CONFIG_ERROR, &cur_compbuf_size_seg) && !cur_compbuf_size_seg);
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 8aafd460c36f..38a5f312ddb4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -86,9 +86,9 @@
 	hws->ctx
 
 #define DC_LOGGER \
-	ctx->logger
-#define DC_LOGGER_INIT() \
-	struct dc_context *ctx = dc->ctx
+	dc_ctx->logger
+#define DC_LOGGER_INIT(ctx) \
+	struct dc_context *dc_ctx = ctx
 
 #define REG(reg)\
 	hws->regs->reg
@@ -687,7 +687,7 @@ dce110_external_encoder_control(enum bp_external_encoder_control_action action,
 		.pixel_clock = timing ? timing->pix_clk_100hz / 10 : 300000,
 		.color_depth = timing ? timing->display_color_depth : COLOR_DEPTH_888,
 	};
-	DC_LOGGER_INIT();
+	DC_LOGGER_INIT(dc->ctx);
 
 	bp_result = bios->funcs->external_encoder_control(bios, &ext_cntl);
 
@@ -767,13 +767,14 @@ void dce110_edp_wait_for_hpd_ready(
 		struct dc_link *link,
 		bool power_up)
 {
-	struct dc_context *ctx = link->ctx;
 	struct graphics_object_id connector = link->link_enc->connector;
 	bool edp_hpd_high = false;
 	uint32_t time_elapsed = 0;
 	uint32_t timeout = power_up ?
 		PANEL_POWER_UP_TIMEOUT : PANEL_POWER_DOWN_TIMEOUT;
 
+	DC_LOGGER_INIT(link->ctx);
+
 	if (dal_graphics_object_id_get_connector_id(connector)
 			!= CONNECTOR_ID_EDP) {
 		BREAK_TO_DEBUGGER();
@@ -825,6 +826,7 @@ void dce110_edp_power_control(
 	enum bp_result bp_result;
 	uint8_t pwrseq_instance;
 
+	DC_LOGGER_INIT(ctx);
 
 	if (dal_graphics_object_id_get_connector_id(link->link_enc->connector)
 			!= CONNECTOR_ID_EDP) {
@@ -993,6 +995,8 @@ void dce110_edp_backlight_control(
 	unsigned int pre_T11_delay = (link->dpcd_sink_ext_caps.bits.oled ? OLED_PRE_T11_DELAY : 0);
 	unsigned int post_T7_delay = (link->dpcd_sink_ext_caps.bits.oled ? OLED_POST_T7_DELAY : 0);
 
+	DC_LOGGER_INIT(ctx);
+
 	if (dal_graphics_object_id_get_connector_id(link->link_enc->connector)
 		!= CONNECTOR_ID_EDP) {
 		BREAK_TO_DEBUGGER();
@@ -1969,8 +1973,7 @@ void dce110_enable_accelerated_mode(struct dc *dc, struct dc_state *context)
 	bool keep_edp_vdd_on = false;
 	bool should_clean_dsc_block = true;
 	struct dc_bios *dcb = dc->ctx->dc_bios;
-	DC_LOGGER_INIT();
-
+	DC_LOGGER_INIT(dc->ctx);
 
 	get_edp_links_with_sink(dc, edp_links_with_sink, &edp_with_sink_num);
 	dc_get_edp_links(dc, edp_links, &edp_num);
@@ -2736,7 +2739,6 @@ static bool wait_for_reset_trigger_to_occur(
 	struct dc_context *dc_ctx,
 	struct timing_generator *tg)
 {
-	struct dc_context *ctx = dc_ctx;
 	bool rc = false;
 
 	/* To avoid endless loop we wait at most
@@ -2778,10 +2780,9 @@ static void dce110_enable_timing_synchronization(
 		int group_size,
 		struct pipe_ctx *grouped_pipes[])
 {
-	struct dc_context *dc_ctx = dc->ctx;
 	struct dcp_gsl_params gsl_params = { 0 };
 	int i;
-	DC_LOGGER_INIT();
+	DC_LOGGER_INIT(dc->ctx);
 
 	DC_SYNC_INFO("GSL: Setting-up...\n");
 
@@ -2824,10 +2825,9 @@ static void dce110_enable_per_frame_crtc_position_reset(
 		int group_size,
 		struct pipe_ctx *grouped_pipes[])
 {
-	struct dc_context *dc_ctx = dc->ctx;
 	struct dcp_gsl_params gsl_params = { 0 };
 	int i;
-	DC_LOGGER_INIT();
+	DC_LOGGER_INIT(dc->ctx);
 
 	gsl_params.gsl_group = 0;
 	gsl_params.gsl_master = 0;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index 5243177c1faa..ffeec61824f5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -60,9 +60,9 @@
 #include "dc_state_priv.h"
 
 #define DC_LOGGER \
-	dc_logger
-#define DC_LOGGER_INIT(logger) \
-	struct dal_logger *dc_logger = logger
+	dc_ctx->logger
+#define DC_LOGGER_INIT(ctx) \
+	struct dc_context *dc_ctx = ctx
 
 #define CTX \
 	hws->ctx
@@ -1009,7 +1009,7 @@ static void power_on_plane_resources(
 	struct dce_hwseq *hws,
 	int plane_id)
 {
-	DC_LOGGER_INIT(hws->ctx->logger);
+	DC_LOGGER_INIT(hws->ctx);
 
 	if (hws->funcs.dpp_root_clock_control)
 		hws->funcs.dpp_root_clock_control(hws, plane_id, true);
@@ -1286,7 +1286,7 @@ static void dcn10_reset_back_end_for_pipe(
 {
 	int i;
 	struct dc_link *link;
-	DC_LOGGER_INIT(dc->ctx->logger);
+	DC_LOGGER_INIT(dc->ctx);
 	if (pipe_ctx->stream_res.stream_enc == NULL) {
 		pipe_ctx->stream = NULL;
 		return;
@@ -1422,12 +1422,10 @@ void dcn10_verify_allow_pstate_change_high(struct dc *dc)
 		return;
 
 	if (!hubbub->funcs->verify_allow_pstate_change_high(hubbub)) {
-		int i = 0;
-
 		if (should_log_hw_state)
 			dcn10_log_hw_state(dc, NULL);
 
-		TRACE_DC_PIPE_STATE(pipe_ctx, i, MAX_PIPES);
+		TRACE_DC_PIPE_STATE(pipe_ctx, MAX_PIPES);
 		BREAK_TO_DEBUGGER();
 		if (dcn10_hw_wa_force_recovery(dc)) {
 			/*check again*/
@@ -1490,7 +1488,7 @@ void dcn10_plane_atomic_power_down(struct dc *dc,
 		struct hubp *hubp)
 {
 	struct dce_hwseq *hws = dc->hwseq;
-	DC_LOGGER_INIT(dc->ctx->logger);
+	DC_LOGGER_INIT(dc->ctx);
 
 	if (REG(DC_IP_REQUEST_CNTL)) {
 		REG_SET(DC_IP_REQUEST_CNTL, 0,
@@ -1554,7 +1552,7 @@ void dcn10_plane_atomic_disable(struct dc *dc, struct pipe_ctx *pipe_ctx)
 void dcn10_disable_plane(struct dc *dc, struct dc_state *state, struct pipe_ctx *pipe_ctx)
 {
 	struct dce_hwseq *hws = dc->hwseq;
-	DC_LOGGER_INIT(dc->ctx->logger);
+	DC_LOGGER_INIT(dc->ctx);
 
 	if (!pipe_ctx->plane_res.hubp || pipe_ctx->plane_res.hubp->power_gated)
 		return;
@@ -2268,8 +2266,6 @@ static bool wait_for_reset_trigger_to_occur(
 {
 	bool rc = false;
 
-	DC_LOGGER_INIT(dc_ctx->logger);
-
 	/* To avoid endless loop we wait at most
 	 * frames_to_wait_on_triggered_reset frames for the reset to occur. */
 	const uint32_t frames_to_wait_on_triggered_reset = 10;
@@ -2384,7 +2380,6 @@ static uint8_t get_clock_divider(struct pipe_ctx *pipe,
 static int dcn10_align_pixel_clocks(struct dc *dc, int group_size,
 				    struct pipe_ctx *grouped_pipes[])
 {
-	struct dc_context *dc_ctx = dc->ctx;
 	int i, master = -1, embedded = -1;
 	struct dc_crtc_timing *hw_crtc_timing;
 	uint64_t phase[MAX_PIPES];
@@ -2397,7 +2392,7 @@ static int dcn10_align_pixel_clocks(struct dc *dc, int group_size,
 	uint32_t dp_ref_clk_100hz =
 		dc->res_pool->dp_clock_source->ctx->dc->clk_mgr->dprefclk_khz*10;
 
-	DC_LOGGER_INIT(dc_ctx->logger);
+	DC_LOGGER_INIT(dc->ctx);
 
 	hw_crtc_timing = kcalloc(MAX_PIPES, sizeof(*hw_crtc_timing), GFP_KERNEL);
 	if (!hw_crtc_timing)
@@ -2477,12 +2472,11 @@ void dcn10_enable_vblanks_synchronization(
 	int group_size,
 	struct pipe_ctx *grouped_pipes[])
 {
-	struct dc_context *dc_ctx = dc->ctx;
 	struct output_pixel_processor *opp;
 	struct timing_generator *tg;
 	int i, width = 0, height = 0, master;
 
-	DC_LOGGER_INIT(dc_ctx->logger);
+	DC_LOGGER_INIT(dc->ctx);
 
 	for (i = 1; i < group_size; i++) {
 		opp = grouped_pipes[i]->stream_res.opp;
@@ -2543,12 +2537,11 @@ void dcn10_enable_timing_synchronization(
 	int group_size,
 	struct pipe_ctx *grouped_pipes[])
 {
-	struct dc_context *dc_ctx = dc->ctx;
 	struct output_pixel_processor *opp;
 	struct timing_generator *tg;
 	int i, width = 0, height = 0;
 
-	DC_LOGGER_INIT(dc_ctx->logger);
+	DC_LOGGER_INIT(dc->ctx);
 
 	DC_SYNC_INFO("Setting up OTG reset trigger\n");
 
@@ -2624,10 +2617,9 @@ void dcn10_enable_per_frame_crtc_position_reset(
 	int group_size,
 	struct pipe_ctx *grouped_pipes[])
 {
-	struct dc_context *dc_ctx = dc->ctx;
 	int i;
 
-	DC_LOGGER_INIT(dc_ctx->logger);
+	DC_LOGGER_INIT(dc->ctx);
 
 	DC_SYNC_INFO("Setting up\n");
 	for (i = 0; i < group_size; i++)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
index db2f7cbb12ff..94f63fd54e3e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn31/dcn31_hwseq.c
@@ -513,7 +513,6 @@ static void dcn31_reset_back_end_for_pipe(
 {
 	struct dc_link *link;
 
-	DC_LOGGER_INIT(dc->ctx->logger);
 	if (pipe_ctx->stream_res.stream_enc == NULL) {
 		pipe_ctx->stream = NULL;
 		return;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index b5a4cefbd35f..b5f60f59382e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -60,15 +60,15 @@
 #include "dcn20/dcn20_hwseq.h"
 #include "dc_state_priv.h"
 
-#define DC_LOGGER_INIT(logger) \
-	struct dal_logger *dc_logger = logger
+#define DC_LOGGER \
+	dc_ctx->logger
+#define DC_LOGGER_INIT(ctx) \
+	struct dc_context *dc_ctx = ctx
 
 #define CTX \
 	hws->ctx
 #define REG(reg)\
 	hws->regs->reg
-#define DC_LOGGER \
-	dc_logger
 
 
 #undef FN
@@ -331,7 +331,7 @@ static void update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 	struct pipe_ctx *odm_pipe;
 	int opp_cnt = 1;
 
-	DC_LOGGER_INIT(stream->ctx->logger);
+	DC_LOGGER_INIT(stream->ctx);
 
 	ASSERT(dsc);
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
@@ -897,7 +897,7 @@ void dcn35_disable_plane(struct dc *dc, struct dc_state *state, struct pipe_ctx
 	bool is_phantom = dc_state_get_pipe_subvp_type(state, pipe_ctx) == SUBVP_PHANTOM;
 	struct timing_generator *tg = is_phantom ? pipe_ctx->stream_res.tg : NULL;
 
-	DC_LOGGER_INIT(dc->ctx->logger);
+	DC_LOGGER_INIT(dc->ctx);
 
 	if (!pipe_ctx->plane_res.hubp || pipe_ctx->plane_res.hubp->power_gated)
 		return;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 69cc70106bf0..55c48c4bc6ce 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1982,7 +1982,6 @@ void dcn401_reset_back_end_for_pipe(
 	struct dc_link *link = pipe_ctx->stream->link;
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
 
-	DC_LOGGER_INIT(dc->ctx->logger);
 	if (pipe_ctx->stream_res.stream_enc == NULL) {
 		pipe_ctx->stream = NULL;
 		return;
@@ -2422,8 +2421,6 @@ void dcn401_program_front_end_for_ctx(
 	struct dce_hwseq *hws = dc->hwseq;
 	struct pipe_ctx *pipe = NULL;
 
-	DC_LOGGER_INIT(dc->ctx->logger);
-
 	if (resource_is_pipe_topology_changed(dc->current_state, context))
 		resource_log_pipe_topology_update(dc, context);
 
@@ -2587,8 +2584,6 @@ void dcn401_post_unlock_program_front_end(
 	struct dce_hwseq *hwseq = dc->hwseq;
 	int i;
 
-	DC_LOGGER_INIT(dc->ctx->logger);
-
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
 		if (resource_is_pipe_type(&dc->current_state->res_ctx.pipe_ctx[i], OPP_HEAD) &&
 			!resource_is_pipe_type(&context->res_ctx.pipe_ctx[i], OPP_HEAD))
@@ -2968,8 +2963,6 @@ void dcn401_plane_atomic_power_down(struct dc *dc,
 	struct dce_hwseq *hws = dc->hwseq;
 	uint32_t org_ip_request_cntl = 0;
 
-	DC_LOGGER_INIT(dc->ctx->logger);
-
 	if (REG(DC_IP_REQUEST_CNTL)) {
 		REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
 		if (org_ip_request_cntl == 0)
@@ -3061,8 +3054,6 @@ void dcn401_plane_atomic_power_down_sequence(struct dc *dc,
 	struct dce_hwseq *hws = dc->hwseq;
 	uint32_t org_ip_request_cntl = 0;
 
-	DC_LOGGER_INIT(dc->ctx->logger);
-
 	/* Check and set DC_IP_REQUEST_CNTL if needed */
 	if (REG(DC_IP_REQUEST_CNTL)) {
 		REG_GET(DC_IP_REQUEST_CNTL, IP_REQUEST_EN, &org_ip_request_cntl);
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_detection.c b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
index d0bb26888f4b..f992c2d16748 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -352,7 +352,7 @@ static void query_dp_dual_mode_adaptor(
 			*dongle = DISPLAY_DONGLE_DP_DVI_DONGLE;
 			sink_cap->max_hdmi_pixel_clock = DP_ADAPTOR_DVI_MAX_TMDS_CLK;
 
-			CONN_DATA_DETECT(ddc->link, type2_dongle_buf, sizeof(type2_dongle_buf),
+			CONN_DATA_DETECT(link, type2_dongle_buf, sizeof(type2_dongle_buf),
 					"DP-DVI passive dongle %dMhz: ",
 					DP_ADAPTOR_DVI_MAX_TMDS_CLK / 1000);
 			return;
@@ -657,8 +657,6 @@ static bool wait_for_entering_dp_alt_mode(struct dc_link *link)
 	unsigned long long time_taken_in_ns;
 	int tries_taken;
 
-	DC_LOGGER_INIT(link->ctx->logger);
-
 	/**
 	 * this function will only exist if we are on dcn21 (is_in_alt_mode is a
 	 *  function pointer, so checking to see if it is equal to 0 is the same
@@ -729,8 +727,6 @@ static void revert_dpia_mst_dsc_always_on_wa(struct dc_link *link)
 
 static bool discover_dp_mst_topology(struct dc_link *link, enum dc_detect_reason reason)
 {
-	DC_LOGGER_INIT(link->ctx->logger);
-
 	LINK_INFO("link=%d, mst branch is now Connected\n",
 		  link->link_index);
 
@@ -750,8 +746,6 @@ static bool discover_dp_mst_topology(struct dc_link *link, enum dc_detect_reason
 
 bool link_reset_cur_dp_mst_topology(struct dc_link *link)
 {
-	DC_LOGGER_INIT(link->ctx->logger);
-
 	LINK_INFO("link=%d, mst branch is now Disconnected\n",
 		  link->link_index);
 
@@ -977,8 +971,6 @@ static bool detect_link_and_local_sink(struct dc_link *link,
 	enum dc_connection_type new_connection_type = dc_connection_none;
 	const uint32_t post_oui_delay = 30; // 30ms
 
-	DC_LOGGER_INIT(link->ctx->logger);
-
 	if (dc_is_virtual_signal(link->connector_signal))
 		return false;
 
@@ -1459,8 +1451,6 @@ bool link_detect(struct dc_link *link, enum dc_detect_reason reason)
 	bool is_delegated_to_mst_top_mgr = false;
 	enum dc_connection_type pre_link_type = link->type;
 
-	DC_LOGGER_INIT(link->ctx->logger);
-
 	is_local_sink_detect_success = detect_link_and_local_sink(link, reason);
 
 	if (is_local_sink_detect_success && link->local_sink)
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
index 5b2c1a4911cf..ba311a8f3f65 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_edp_panel_control.c
@@ -1094,8 +1094,6 @@ bool edp_send_replay_cmd(struct dc_link *link,
 	if (!replay)
 		return false;
 
-	DC_LOGGER_INIT(link->ctx->logger);
-
 	if (dp_pr_get_panel_inst(dc, link, &panel_inst))
 		cmd_data->panel_inst = panel_inst;
 	else {
diff --git a/drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c b/drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c
index b23c64004dd5..27e653234850 100644
--- a/drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/mpc/dcn10/dcn10_mpc.c
@@ -118,9 +118,7 @@ void mpc1_assert_idle_mpcc(struct mpc *mpc, int id)
 
 struct mpcc *mpc1_get_mpcc(struct mpc *mpc, int mpcc_id)
 {
-	struct dcn10_mpc *mpc10 = TO_DCN10_MPC(mpc);
-
-	ASSERT(mpcc_id < mpc10->num_mpcc);
+	ASSERT(mpcc_id < TO_DCN10_MPC(mpc)->num_mpcc);
 	return &(mpc->mpcc_array[mpcc_id]);
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
index 6731544f0981..90a4b42bc7e7 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn20/dcn20_resource.c
@@ -2342,8 +2342,6 @@ static bool init_soc_bounding_box(struct dc *dc,
 	struct _vcs_dpi_ip_params_st *loaded_ip =
 			get_asic_rev_ip_params(dc->ctx->asic_id.hw_internal_rev);
 
-	DC_LOGGER_INIT(dc->ctx->logger);
-
 	if (pool->base.pp_smu) {
 		struct pp_smu_nv_clock_table max_clocks = {0};
 		unsigned int uclk_states[8] = {0};
-- 
2.43.0


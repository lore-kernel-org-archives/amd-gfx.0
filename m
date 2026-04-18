Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89906F99C6D
	for <amd-gfx@archiver.kernel.org>; Sat, 18 Apr 2026 00:36:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F177710E0C3;
	Sat, 18 Apr 2026 00:36:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pqBqIJ2c";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010036.outbound.protection.outlook.com [52.101.56.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB7F210E0C3
 for <amd-gfx@lists.freedesktop.org>; Sat, 18 Apr 2026 00:36:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Aq2PY8uBhFibaBHak0iRCaDzhQ2JgSoa6ne7Tw5xELMaPJdXPl9wWfLTr1hWvt5YOf8E/q+G9wu04OiDni2O1SZY0JPxlL8mybeUQ6ia09l4Q0qj5633SrTCTs6aMiasx0htJSDQC+d1/a4s/KXhtyXqyptvm6zuFspx//27cmFLByNgYCU5js475YpKkmyz7KSS+odVNTTMn8xn6+KYYtpb9+jKxVFi17lRVxJ1MX/u47UxtlebQpEYwvMK9LzfxQuXGOTmzn0VV/ycAYpj3Q/oAQXLA0SbTrM1teOHzKpCJFNBHxiOXuHnxvSFDZne3/Vevo2DKe0R1SPil8qluQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PyrfUgac5N24ruiMgPwEVq6j5tAIUtOSqlfgF3DSPqs=;
 b=uSOUY3K6RgO5siKvB6Bbdc6MayWlz3Yduur2u9fLfO8+cg1iRH+HE6anIhkRiJKld2jD/pva+v79soKkhp7QE9mk8yB/0m6c109mDpAADs4lGrTgyfgvpmnTVeG0RlpVf2snemn5zpIKhj7mlDduxoyHmvlEf3czFQ/8lEyf4NcAIxBUQ4rqF2jrQFAyLDSDHbWg7flyI/pEo6u/1Biq75DriepDsbQjpgx86cDE7iC0U1hokgifJUM3Y1i78sWYuNg0skcUNNumGxN94THPWhtfIJFGipwLALI7mRDhAqLUAkuTHS86KRGIiRg/0E1vew4mDmXdbvE3cxfLioVxWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PyrfUgac5N24ruiMgPwEVq6j5tAIUtOSqlfgF3DSPqs=;
 b=pqBqIJ2clqcOL1v2F26TkRJ0Hzi8cmKiYhNZgX65/8D2sdBn3bhnJivl2hIHrcdXpSfq9zSzV93pmJqd6YR7k6mbzS+SaHSFKuC7XE6j9oGHKgDg2SvKTqyVrq+RMtm5ihXBS/uFC/C7+8TNvIUSCyUIfUprecPladM2PT8CEJA=
Received: from SJ0PR05CA0193.namprd05.prod.outlook.com (2603:10b6:a03:330::18)
 by IA0PR12MB7700.namprd12.prod.outlook.com (2603:10b6:208:430::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.25; Sat, 18 Apr
 2026 00:36:33 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:330:cafe::1f) by SJ0PR05CA0193.outlook.office365.com
 (2603:10b6:a03:330::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.52 via Frontend Transport; Sat,
 18 Apr 2026 00:36:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Sat, 18 Apr 2026 00:36:32 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Apr
 2026 19:36:32 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 17 Apr
 2026 17:36:32 -0700
Received: from roman-vdev.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 17 Apr 2026 19:36:32 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, <Harry.Wentland@amd.com>,
 <Sunpeng.Li@amd.com>, <Aurabindo.Pillai@amd.com>, <alex.hung@amd.com>, "Roman
 Li" <Roman.Li@amd.com>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
 <timur.kristof@gmail.com>
Subject: [PATCH v3] drm/amd/display: Restore analog connector support
Date: Fri, 17 Apr 2026 20:35:39 -0400
Message-ID: <20260418003539.1862136-1-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|IA0PR12MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: c8b21bcc-eb38-4c2a-cd38-08de9ce28a42
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: etUuUV0Y9v7B9XoWRPvU/GanjmlF5DHyfEL55gEScUc4JoQPSPXW/VcQdY4+hcgTBZIVixWXRR/aJhqRtMCiVDzj1PmlCIvt0l2PhuFVaaJXY3x79xGNxIh3CoXr1fbRoJ5KslmZkNw8syIi3dvz6FFCcTd5aW4ewjNKkZJ2WpkMRdHr9iqt5/i91P3nHmDH1ZqliK9Lbi5uHPB4PQAl9yN6qQHGt+cRLIxKej6VO6CLTBbKNZQr9rsVph/6uvFTDYlZ+96b39L42j3KP4mzDhLw2Zwj443ITZx0tLnjB2FjeFyb626aB6ZzEHW2lndt415p7hpO8vUNALn93qJUnoIUekdi1Q9+XDbNG382loOe4WcMRZIev6eiGYHHTSSkuTGAKrx2Kb/+CqnCkDCSFL/9I88IQuHkFqcisBJyveoKpo+PfljKMfn5NoJdrO8LfTATNXN3EEAr0RogTfu7Dlr5OzNQxQfiiXFsGfEw78qKN2e0TlrSlsAtTU8NhlwJI5GO0r4KvF7ehk9tDRHWzg17pl08xadx1D66z/GZO7mJLbxzyoaccWBW+rcCCtQI1HqX4OwlnVlNdu25IwyHjx2J/oHMXggnMYFNqJVlky5k709O5YJwds2/73rism803mDIIRmenEnc3AjHKdFt7cyGEFdvyKseKRMy4vzSPAUGHz65HoFVcMrkmOJ3+fVAj79f9LOfwf1xJhs8pM5lqXUMA5ntXhe7aZX2arehOn22I2XQ4Y7OufiKymma2KNQehO5LKcu+jj9f0E/o05o5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4FfUuRDnpCsNjvNNblooi/59j64Xh7mP2F/jDZHjHsvGRFWWtzgnfMBMGDb+ZEy77L5eccWBIVmV0ac4iGevnV3gBVgmCcq6yBjyOZkXS3QcN2m5V5vN0OHHTGy6wGliZWM4AV402erH2kvxpVun5hDs4uKnJf/6ZdalMAQbVdwuDJmf03xkxElU9sSefzFCenZiHG8/6bHEksTLSWQANGf5qmwe9a+1YiZ+qdAXyybC8fMJBJs2gsTay1hUeHXy/k19b7dONmnigr6aHaPLqczmz4qD1VKhMisvySZSSy5z5TfaMuyDBeeU4UpYPZ/cNB79HvErFhCrqDs3nQHsWtgOigKnqwBz6i6XT8jXzKyuNGHbErwyvsGJSn7ICBiqz3exLHo409CAsoBXdwQqB8zfh73AghWa3SasoUN/qzqRA/QEY7oiprT9Ttx+PoLZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2026 00:36:32.8627 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c8b21bcc-eb38-4c2a-cd38-08de9ce28a42
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7700
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

From: Roman Li <Roman.Li@amd.com>

[Why]
The analog connector support was accidentally removed,
causing a crash when connecting an analog monitor.

[How]
This patch restores the functions and pointers required for proper analog
and DP bridge encoder support on legacy GPUs.

V2: Restore the external encoder control functions.

V3:
 - Restore BIOS parser external encoder DAC load detection
 - Restore stream initialization and source selection changes

Fixes: 66715fc0ecfd ("drm/amd/display: Sync dcn42 with DC 3.2.373")

Cc: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
 .../gpu/drm/amd/display/dc/bios/bios_parser.c | 11 ++-
 .../gpu/drm/amd/display/dc/dc_bios_types.h    |  3 +-
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 94 ++++++++++++-------
 3 files changed, 71 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
index 25c94962e141..ec75882ac477 100644
--- a/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
+++ b/drivers/gpu/drm/amd/display/dc/bios/bios_parser.c
@@ -794,11 +794,13 @@ static enum bp_result bios_parser_external_encoder_control(
 
 static enum bp_result bios_parser_dac_load_detection(
 	struct dc_bios *dcb,
-	enum engine_id engine_id)
+	enum engine_id engine_id,
+	struct graphics_object_id ext_enc_id)
 {
 	struct bios_parser *bp = BP_FROM_DCB(dcb);
 	struct dc_context *ctx = dcb->ctx;
 	struct bp_load_detection_parameters bp_params = {0};
+	struct bp_external_encoder_control ext_cntl = {0};
 	enum bp_result bp_result = BP_RESULT_UNSUPPORTED;
 	uint32_t bios_0_scratch;
 	uint32_t device_id_mask = 0;
@@ -824,6 +826,13 @@ static enum bp_result bios_parser_dac_load_detection(
 
 		bp_params.engine_id = engine_id;
 		bp_result = bp->cmd_tbl.dac_load_detection(bp, &bp_params);
+	} else if (ext_enc_id.id) {
+		if (!bp->cmd_tbl.external_encoder_control)
+			return BP_RESULT_UNSUPPORTED;
+
+		ext_cntl.action = EXTERNAL_ENCODER_CONTROL_DAC_LOAD_DETECT;
+		ext_cntl.encoder_id = ext_enc_id;
+		bp_result = bp->cmd_tbl.external_encoder_control(bp, &ext_cntl);
 	}
 
 	if (bp_result != BP_RESULT_OK)
diff --git a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
index 6f96c5cf39fe..526f71616f94 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_bios_types.h
@@ -102,7 +102,8 @@ struct dc_vbios_funcs {
 		struct bp_external_encoder_control *cntl);
 	enum bp_result (*dac_load_detection)(
 		struct dc_bios *bios,
-		enum engine_id engine_id);
+		enum engine_id engine_id,
+		struct graphics_object_id ext_enc_id);
 	enum bp_result (*transmitter_control)(
 		struct dc_bios *bios,
 		struct bp_transmitter_control *cntl);
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 7af239524d71..e6712cffeb04 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -665,16 +665,45 @@ void dce110_update_info_frame(struct pipe_ctx *pipe_ctx)
 }
 
 static void
-dce110_dac_encoder_control(struct pipe_ctx *pipe_ctx, bool enable)
+dce110_external_encoder_control(enum bp_external_encoder_control_action action,
+				struct dc_link *link,
+				struct dc_crtc_timing *timing)
 {
-	struct dc_link *link = pipe_ctx->stream->link;
+	struct dc *dc = link->ctx->dc;
 	struct dc_bios *bios = link->ctx->dc_bios;
-	struct bp_encoder_control encoder_control = {0};
+	const struct dc_link_settings *link_settings = &link->cur_link_settings;
+	enum bp_result bp_result = BP_RESULT_OK;
+	struct bp_external_encoder_control ext_cntl = {
+		.action = action,
+		.connector_obj_id = link->link_enc->connector,
+		.encoder_id = link->ext_enc_id,
+		.lanes_number = link_settings->lane_count,
+		.link_rate = link_settings->link_rate,
+
+		/* Use signal type of the real link encoder, ie. DP */
+		.signal = link->connector_signal,
+
+		/* We don't know the timing yet when executing the SETUP action,
+		 * so use a reasonably high default value. It seems that ENABLE
+		 * can change the actual pixel clock but doesn't work with higher
+		 * pixel clocks than what SETUP was called with.
+		 */
+		.pixel_clock = timing ? timing->pix_clk_100hz / 10 : 300000,
+		.color_depth = timing ? timing->display_color_depth : COLOR_DEPTH_888,
+	};
+	DC_LOGGER_INIT(dc->ctx);
 
-	encoder_control.action = enable ? ENCODER_CONTROL_ENABLE : ENCODER_CONTROL_DISABLE;
-	encoder_control.engine_id = link->link_enc->analog_engine;
-	encoder_control.pixel_clock = pipe_ctx->stream->timing.pix_clk_100hz / 10;
-	bios->funcs->encoder_control(bios, &encoder_control);
+	bp_result = bios->funcs->external_encoder_control(bios, &ext_cntl);
+
+	if (bp_result != BP_RESULT_OK)
+		DC_LOG_ERROR("Failed to execute external encoder action: 0x%x\n", action);
+}
+
+static void
+dce110_prepare_ddc(struct dc_link *link)
+{
+	if (link->ext_enc_id.id)
+		dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_DDC_SETUP, link, NULL);
 }
 
 static bool
@@ -684,7 +713,8 @@ dce110_dac_load_detect(struct dc_link *link)
 	struct link_encoder *link_enc = link->link_enc;
 	enum bp_result bp_result;
 
-	bp_result = bios->funcs->dac_load_detection(bios, link_enc->analog_engine);
+	bp_result = bios->funcs->dac_load_detection(
+			bios, link_enc->analog_engine, link->ext_enc_id);
 	return bp_result == BP_RESULT_OK;
 }
 
@@ -700,7 +730,6 @@ void dce110_enable_stream(struct pipe_ctx *pipe_ctx)
 	uint32_t early_control = 0;
 	struct timing_generator *tg = pipe_ctx->stream_res.tg;
 
-	link_hwss->setup_stream_attribute(pipe_ctx);
 	link_hwss->setup_stream_encoder(pipe_ctx);
 
 	dc->hwss.update_info_frame(pipe_ctx);
@@ -719,8 +748,8 @@ void dce110_enable_stream(struct pipe_ctx *pipe_ctx)
 
 	tg->funcs->set_early_control(tg, early_control);
 
-	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
-		dce110_dac_encoder_control(pipe_ctx, true);
+	if (link->ext_enc_id.id)
+		dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_ENABLE, link, timing);
 }
 
 static enum bp_result link_transmitter_control(
@@ -1220,8 +1249,8 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 					       link_enc->transmitter - TRANSMITTER_UNIPHY_A);
 	}
 
-	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
-		dce110_dac_encoder_control(pipe_ctx, false);
+	if (link->ext_enc_id.id)
+		dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_DISABLE, link, NULL);
 }
 
 void dce110_unblank_stream(struct pipe_ctx *pipe_ctx,
@@ -1604,22 +1633,6 @@ static enum dc_status dce110_enable_stream_timing(
 
 	return DC_OK;
 }
-static void
-dce110_select_crtc_source(struct pipe_ctx *pipe_ctx)
-{
-	struct dc_link *link = pipe_ctx->stream->link;
-	struct dc_bios *bios = link->ctx->dc_bios;
-	struct bp_crtc_source_select crtc_source_select = {0};
-	enum engine_id engine_id = link->link_enc->preferred_engine;
-
-	if (dc_is_rgb_signal(pipe_ctx->stream->signal))
-		engine_id = link->link_enc->analog_engine;
-	crtc_source_select.controller_id = CONTROLLER_ID_D0 + pipe_ctx->stream_res.tg->inst;
-	crtc_source_select.color_depth = pipe_ctx->stream->timing.display_color_depth;
-	crtc_source_select.engine_id = engine_id;
-	crtc_source_select.sink_signal = pipe_ctx->stream->signal;
-	bios->funcs->select_crtc_source(bios, &crtc_source_select);
-}
 
 enum dc_status dce110_apply_single_controller_ctx_to_hw(
 		struct pipe_ctx *pipe_ctx,
@@ -1640,10 +1653,6 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 		hws->funcs.disable_stream_gating(dc, pipe_ctx);
 	}
 
-	if (pipe_ctx->stream->signal == SIGNAL_TYPE_RGB) {
-		dce110_select_crtc_source(pipe_ctx);
-	}
-
 	if (pipe_ctx->stream_res.audio != NULL) {
 		struct audio_output audio_output = {0};
 
@@ -1723,8 +1732,7 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 		pipe_ctx->stream_res.tg->funcs->set_static_screen_control(
 				pipe_ctx->stream_res.tg, event_triggers, 2);
 
-	if (!dc_is_virtual_signal(pipe_ctx->stream->signal) &&
-		!dc_is_rgb_signal(pipe_ctx->stream->signal))
+	if (!dc_is_virtual_signal(pipe_ctx->stream->signal))
 		pipe_ctx->stream_res.stream_enc->funcs->dig_connect_to_otg(
 			pipe_ctx->stream_res.stream_enc,
 			pipe_ctx->stream_res.tg->inst);
@@ -3379,6 +3387,15 @@ void dce110_enable_tmds_link_output(struct dc_link *link,
 	link->phy_state.symclk_state = SYMCLK_ON_TX_ON;
 }
 
+static void dce110_enable_analog_link_output(
+		struct dc_link *link,
+		uint32_t pix_clk_100hz)
+{
+	link->link_enc->funcs->enable_analog_output(
+			link->link_enc,
+			pix_clk_100hz);
+}
+
 void dce110_enable_dp_link_output(
 		struct dc_link *link,
 		const struct link_resource *link_res,
@@ -3426,6 +3443,11 @@ void dce110_enable_dp_link_output(
 		}
 	}
 
+	if (link->ext_enc_id.id) {
+		dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_INIT, link, NULL);
+		dce110_external_encoder_control(EXTERNAL_ENCODER_CONTROL_SETUP, link, NULL);
+	}
+
 	if (dc->link_srv->dp_get_encoding_format(link_settings) == DP_8b_10b_ENCODING) {
 		if (dc->clk_mgr->funcs->notify_link_rate_change)
 			dc->clk_mgr->funcs->notify_link_rate_change(dc->clk_mgr, link);
@@ -3516,8 +3538,10 @@ static const struct hw_sequencer_funcs dce110_funcs = {
 	.enable_lvds_link_output = dce110_enable_lvds_link_output,
 	.enable_tmds_link_output = dce110_enable_tmds_link_output,
 	.enable_dp_link_output = dce110_enable_dp_link_output,
+	.enable_analog_link_output = dce110_enable_analog_link_output,
 	.disable_link_output = dce110_disable_link_output,
 	.dac_load_detect = dce110_dac_load_detect,
+	.prepare_ddc = dce110_prepare_ddc,
 };
 
 static const struct hwseq_private_funcs dce110_private_funcs = {
-- 
2.34.1


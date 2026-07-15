Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 678EBC44508
	for <amd-gfx@archiver.kernel.org>; Wed, 15 Jul 2026 13:44:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EDEC910F04D;
	Wed, 15 Jul 2026 13:44:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="dqtBBY/E";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010016.outbound.protection.outlook.com
 [40.93.198.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E7E410F04D
 for <amd-gfx@lists.freedesktop.org>; Wed, 15 Jul 2026 13:44:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fTy9FjAU8jMDxd61SbkuixyfNJjp44FFyeP7FG74XH7QO/okujIbpxB/UaoYr7cAxyQ6GhVhmtHr7Cs6f0MNyWNbdw5HvPEvc/P9S/6vub7yt0lLYGj06/qDMTPidRsgm0r+oksZwcYlG6EO0T27VdO7KAm5nIZaxjClFx1kR/0fcU+acUCncVxs7IptDkre8+VKF2yEIMjImWj2t4K/WJq3g9yzVtPjJyyuoya7Ywr/GP949xoOs9DweHCSt6CeRqIYMxbsFR4635UT+W0ApiL9J8P4w2IcvuSghjlM+BjcGoDnO88pkpcvHisvYc4k3JGgsXU/9kGL9M1TwT+XdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7qrXzdq7/cfZCxtwb7JN1KJ+Xo56ULZCsUBRx42q0N8=;
 b=EV+CHC6B3KXNN99z8eJJ5dKpKEuH7M1WroMfGdsP2EybLqgHYAs1jSnZLDDi9tIXKBXod9kEWn826g9GrMBSx7dvDznpKcBEReY81XcDBk5u9D29AcptflKGxHUNeEvxEIwdkvudu8BPd5ljEnscazPBjqdUX+xNrHLJS/wPCVI7P3Wf396eUK7X3sxRSRWs+2eCZPReJuPconWTsHMbUNcXqD2hWXoZqGd+omSl2MxdfLlqrUkmZHWo0a4w+PCVuIySGeZ4NBSMakQOdBiyDmvkEkwOrrrOWZ7/K+9TZfmqAPY7NVaBitvj3104HsX4Zjp9jJMj64grHj0SJH672A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7qrXzdq7/cfZCxtwb7JN1KJ+Xo56ULZCsUBRx42q0N8=;
 b=dqtBBY/Ezy32ipbyorhbSkXQt4PMmT4rrQI4aSFFmVHlnJ5GxXW0eMALsG+mlN2W644rPO3WDtDmXo1Un3LiABqySBJ1N+bo+0m8IOOLsvceRjhcAff83c4NF25Yy8YFk3BBIjeFjn+sEC+JCeHhJ053FB3oQ5w/fj6KlFbJH+4=
Received: from PH0P220CA0029.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:d3::27)
 by PH0PR12MB7792.namprd12.prod.outlook.com (2603:10b6:510:281::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.10; Wed, 15 Jul
 2026 13:44:45 +0000
Received: from CY4PEPF0000FCBF.namprd03.prod.outlook.com
 (2603:10b6:510:d3:cafe::93) by PH0P220CA0029.outlook.office365.com
 (2603:10b6:510:d3::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.12 via Frontend Transport; Wed,
 15 Jul 2026 13:44:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CY4PEPF0000FCBF.mail.protection.outlook.com (10.167.242.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Wed, 15 Jul 2026 13:44:43 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 15 Jul
 2026 08:44:41 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 15 Jul 2026 08:44:33 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Dillon Varone <Dillon.Varone@amd.com>, Wayne Lin
 <Wayne.Lin@amd.com>
Subject: [PATCH 01/70] drm/amd/display: Correct pipe usage for populating
 stream config
Date: Wed, 15 Jul 2026 21:37:11 +0800
Message-ID: <20260715134432.1975118-2-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260715134432.1975118-1-Wayne.Lin@amd.com>
References: <20260715134432.1975118-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCBF:EE_|PH0PR12MB7792:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e1ce15d-7893-4753-6247-08dee2773a22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|82310400026|36860700016|376014|56012099006|11063799006|10067099003|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: F8eSm02Aba+TcMtw4oTNUa+4Lr5GxI6GQD/xyI0mZP9ipkHFrZuNe9hgPQ6iBmFo/yX072O/acJ+BIKxtmusJG70OFvS0I1N+aFqhtqxAKhSAaHtGJFboJKPpmPjLTHvUAHJ7jSWyqXe8TXIgZDK9OMU+PU8PnFh3M1qrtrQ+yJdIIQEbf6ijbk7FAizK/Fw45Wg0eNyIGZ5d4j3AEQbyy/W7ow7rZhf5jRRkIiOLkcm/rgcCKL28N5HoyS1a1E+8elIxyBCHmI/VvTSUikegqFiP4NoT7fkUBQm5udfV0SmrFolgi6Dr1KOtI5yPdliYOUgb8QqBLlaILsHP8tM5318QaWGuVxZ6XnGT8/4B5E9vb2iOodyeD7xYoQOQBvDAWyoRkmAJ/T4Iefshh5JwYZdGrTJP+zndtmvoLHvIgN5EYxhSF1H8eQdbwMaIe1WpsznvpnGp33RtsxCPZOGeLlC2Smq4sXBkVskKSUmTNKWtTBCNiKXglTF09yiTwr7RHtJaPtOqmFMbouifpgKzWDnVgblo/EhLRLKXpvGKVGiCQ95yJN9dfLzodTAagVnbt9AK9WGvR46R6ypqQRQwv3fAL8xZVfYc4CPGlfMwC//ljJ1skW73RR1NnoCvThn9sBXvEuBonpG3SKECgK6ZmiWMml6mNPLXoLLN5oN4FmHy7eskiqmBy1hB6yLuAFyqNUKo0xajOe5N8m9uLyW/Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(82310400026)(36860700016)(376014)(56012099006)(11063799006)(10067099003)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jDhz3eLs3pHR9DepU67lifXOK3LRrvh/p9SNDo7Es8+1OYMJFeyBv8uiACQhWqLUru1cr+9XaKBbPyrzFdNrMHx/VlABr/LWsINpbFJRe0oiqbBzOPujfNhkreNOuF8TPF6xHSAIIf1uqu0aSnrVe4IHZbDE///uP9O/SL/7vGBNlx3iYeP5K3IUYirS1/pTCMgLd2ofzWcZUTP3ragKat7IIf5x+EWgxRy5A3XcwRWVhwE9HPZfMnoPTChYCCSjfHK0XZF4XTjRxRqEx1aLJWe2W3a78wue6Mc2rOe9iEvlDrdM0A/tjc3mZByc+Y8VWtfPFbO9H7yZJvkbTCYSeEIlBVa7oRRHXL41AsdOWEKVF7PY2VNv/X7IhMKHTF4Ve2bgXGQI2CXRgkH+YKAMkTTvz8Ii5/aaeSmc+MWCkdWeMMYeHuMxdfO7YqKRzwjK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2026 13:44:43.6612 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e1ce15d-7893-4753-6247-08dee2773a22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCBF.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7792
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

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY&HOW]
Was incorrectly using stream index to index pipes, when should have
been using callback to get otg master pipe for stream.

Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
Signed-off-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../dml2_0/dml21/dml21_translation_helper.c   | 28 +++++++++++--------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
index c1a3e2496983..51260369cd8a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2_0/dml21/dml21_translation_helper.c
@@ -90,7 +90,7 @@ static unsigned int calc_max_hardware_v_total(const struct dc_stream_state *stre
 
 static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cfg *timing,
 		struct dc_stream_state *stream,
-		struct pipe_ctx *pipe_ctx,
+		struct pipe_ctx *otg_master_pipe,
 		struct dml2_context *dml_ctx)
 {
 	const unsigned int min_v_front_porch = (stream->timing.flags.INTERLACE != 0) ? 2 : 1;
@@ -99,24 +99,24 @@ static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cf
 	uint64_t min_hardware_refresh_in_uhz;
 	uint32_t pix_clk_100hz;
 
-	timing->h_active = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right + pipe_ctx->dsc_padding_params.dsc_hactive_padding;
+	timing->h_active = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right + otg_master_pipe->dsc_padding_params.dsc_hactive_padding;
 	timing->v_active = stream->timing.v_addressable + stream->timing.v_border_bottom + stream->timing.v_border_top;
 	timing->h_front_porch = stream->timing.h_front_porch;
 	timing->v_front_porch = stream->timing.v_front_porch > min_v_front_porch ?
 			stream->timing.v_front_porch : min_v_front_porch;
 	timing->pixel_clock_khz = stream->timing.pix_clk_100hz / 10;
-	if (pipe_ctx->dsc_padding_params.dsc_hactive_padding != 0)
-		timing->pixel_clock_khz = pipe_ctx->dsc_padding_params.dsc_pix_clk_100hz / 10;
+	if (otg_master_pipe->dsc_padding_params.dsc_hactive_padding != 0)
+		timing->pixel_clock_khz = otg_master_pipe->dsc_padding_params.dsc_pix_clk_100hz / 10;
 	if (stream->timing.timing_3d_format == TIMING_3D_FORMAT_HW_FRAME_PACKING)
 		timing->pixel_clock_khz *= 2;
-	timing->h_total = stream->timing.h_total + pipe_ctx->dsc_padding_params.dsc_htotal_padding;
+	timing->h_total = stream->timing.h_total + otg_master_pipe->dsc_padding_params.dsc_htotal_padding;
 	timing->v_total = stream->timing.v_total;
 	timing->h_sync_width = stream->timing.h_sync_width;
 	timing->interlaced = (stream->timing.flags.INTERLACE != 0);
 
 	hblank_start = stream->timing.h_total - stream->timing.h_front_porch;
 
-	timing->h_blank_end = hblank_start - stream->timing.h_addressable - pipe_ctx->dsc_padding_params.dsc_hactive_padding
+	timing->h_blank_end = hblank_start - stream->timing.h_addressable - otg_master_pipe->dsc_padding_params.dsc_hactive_padding
 		- stream->timing.h_border_left - stream->timing.h_border_right;
 
 	if (hblank_start < stream->timing.h_addressable)
@@ -135,8 +135,8 @@ static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cf
 	/* limit min refresh rate to DC cap */
 	min_hardware_refresh_in_uhz = stream->timing.min_refresh_in_uhz;
 	if (stream->ctx->dc->caps.max_v_total != 0) {
-		if (pipe_ctx->dsc_padding_params.dsc_hactive_padding != 0) {
-			pix_clk_100hz = pipe_ctx->dsc_padding_params.dsc_pix_clk_100hz;
+		if (otg_master_pipe->dsc_padding_params.dsc_hactive_padding != 0) {
+			pix_clk_100hz = otg_master_pipe->dsc_padding_params.dsc_pix_clk_100hz;
 		} else {
 			pix_clk_100hz = stream->timing.pix_clk_100hz;
 		}
@@ -197,7 +197,7 @@ static void populate_dml21_timing_config_from_stream_state(struct dml2_timing_cf
 }
 
 static void populate_dml21_output_config_from_stream_state(struct dml2_link_output_cfg *output,
-		struct dc_stream_state *stream, const struct pipe_ctx *pipe)
+		struct dc_stream_state *stream, const struct pipe_ctx *otg_master_pipe)
 {
 	output->output_dp_lane_count = 4;
 
@@ -205,7 +205,7 @@ static void populate_dml21_output_config_from_stream_state(struct dml2_link_outp
 	case SIGNAL_TYPE_DISPLAY_PORT_MST:
 	case SIGNAL_TYPE_DISPLAY_PORT:
 		output->output_encoder = dml2_dp;
-		if (check_dp2p0_output_encoder(pipe))
+		if (check_dp2p0_output_encoder(otg_master_pipe))
 			output->output_encoder = dml2_dp2p0;
 		break;
 	case SIGNAL_TYPE_EDP:
@@ -795,6 +795,7 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 	int disp_cfg_stream_location, disp_cfg_plane_location;
 	struct dml2_display_cfg *dml_dispcfg = &dml_ctx->v21.display_config;
 	unsigned int plane_count = 0;
+	struct pipe_ctx *otg_master_pipe;
 
 	memset(&dml_ctx->v21.dml_to_dc_pipe_mapping, 0, sizeof(struct dml2_dml_to_dc_pipe_mapping));
 
@@ -819,9 +820,12 @@ bool dml21_map_dc_state_into_dml_display_cfg(const struct dc *in_dc, struct dc_s
 		if (disp_cfg_stream_location < 0)
 			disp_cfg_stream_location = dml_dispcfg->num_streams++;
 
+		otg_master_pipe = dml_ctx->config.callbacks.get_otg_master_for_stream(&context->res_ctx, context->streams[stream_index]);
+		ASSERT(otg_master_pipe);
+
 		ASSERT(disp_cfg_stream_location >= 0 && disp_cfg_stream_location < __DML2_WRAPPER_MAX_STREAMS_PLANES__);
-		populate_dml21_timing_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].timing, context->streams[stream_index], &context->res_ctx.pipe_ctx[stream_index], dml_ctx);
-		populate_dml21_output_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].output, context->streams[stream_index], &context->res_ctx.pipe_ctx[stream_index]);
+		populate_dml21_timing_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].timing, context->streams[stream_index], otg_master_pipe, dml_ctx);
+		populate_dml21_output_config_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location].output, context->streams[stream_index], otg_master_pipe);
 		populate_dml21_stream_overrides_from_stream_state(&dml_dispcfg->stream_descriptors[disp_cfg_stream_location], context->streams[stream_index], &context->stream_status[stream_index]);
 
 		dml_dispcfg->stream_descriptors[disp_cfg_stream_location].overrides.hw.twait_budgeting.fclk_pstate = dml2_twait_budgeting_setting_if_needed;
-- 
2.43.0


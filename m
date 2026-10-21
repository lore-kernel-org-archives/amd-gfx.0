Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9AD8606A319
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2026 06:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=iu8ZTlAD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5709710F95E;
	Wed, 21 Oct 2026 06:27:35 +0000 (UTC)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011056.outbound.protection.outlook.com [52.101.57.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1685D10F95B
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2026 06:27:29 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bw/cr2ezs0Sgv1v5muydottbv4dr+DN4lHcSNaTgmetew3auXwE6MhAg7DssYAGInPMgkMWluQm1xw8wrzqnUx3MS89IbT1qTy3xEYWRbrDF+gGbzj+V7SpyZFUDi6cQo8Gt+rWAad32KT0xDrEyjAPHzdjm7nEAcubTu46s15zB91zhO8LKhd4avmXO8ToDbKaiUGSZ/OkbOI5R8xinVDWhzapdzHbv5jBlBmhAR0MAVkcWWrHBua4criyvrmWUH6M6nkFfj9awdEaDweXcfoaRg6U86B1eo5VW8Hhb+JqXyG5+EO9hMeuy51uqqLI7AY2FkQNt3djTHNsLHdiMGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nZlPdMskllngSeQLr80Yg24MUu/RnVzug9TyiU01voQ=;
 b=RFQfRQ9abu0qeP75VbaH9dBVO07Dyruxeo6rEoinU9kn9+8F8EKEMu0lESHDuIeDtOUfzdDeRRS7Zm3/y0nQbBf3UgrPriNKkHPgnEOny6JwOvVmpBlBbxQRUruT5wgjh6P6qn9WU6oDCtWSRhLc4bwvrFcx/OKL1aahi573B+aOkMCcVdpSjbg0Tv7cckFN9vEE0xMGATFLrYiKc5GyKfWc5kppVK3/wKMD84EcQ3BTRYAZ/MgnP2r11Evml+kdMBI8GoJLZehQs1RIXWBJVL4erasVfso9YMTpiCW0mFz+Wc3JFVEnVImgJnBuzLGFlloUNOrN3vlTZftU0Ta/ng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nZlPdMskllngSeQLr80Yg24MUu/RnVzug9TyiU01voQ=;
 b=iu8ZTlADjNbdPMxnJzcmvruttIJ7yjCgXIZ9M9xsKgEFoHuY5hN8YRH/Q2zPSBZbZAw8FatljoBp4dhoqlzaUpEK8GAHHFxHyM4fEsJsAhdTpfaoWH5GwnhTY4pVg/wYU60wAY6Ujzw/8NEjrEWtSx2PZgVh9/doG+pCHs3EfWc=
Received: from SJ0PR03CA0351.namprd03.prod.outlook.com (2603:10b6:a03:39c::26)
 by SA1PR12MB8859.namprd12.prod.outlook.com (2603:10b6:806:37c::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Wed, 21 Oct
 2026 06:27:23 +0000
Received: from SJ1PEPF000037A9.namprd03.prod.outlook.com
 (2603:10b6:a03:39c:cafe::a) by SJ0PR03CA0351.outlook.office365.com
 (2603:10b6:a03:39c::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.20 via Frontend Transport; Wed,
 21 Oct 2026 06:27:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF000037A9.mail.protection.outlook.com (10.167.244.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 06:27:23 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 21 Oct
 2026 01:27:22 -0500
Received: from tom-r5.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Wed, 21 Oct 2026 01:27:18 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Samson Tam <Samson.Tam@amd.com>, George Shen
 <george.shen@amd.com>
Subject: [PATCH 32/49] drm/amd/display: Revert "Split link_set_dsc_on_stream
 into encoder and DSC components"
Date: Wed, 21 Oct 2026 14:22:38 +0800
Message-ID: <20261021062519.674697-33-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261021062519.674697-1-chiahsuan.chung@amd.com>
References: <20261021062519.674697-1-chiahsuan.chung@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000037A9:EE_|SA1PR12MB8859:EE_
X-MS-Office365-Filtering-Correlation-Id: 20bf46ed-9b89-4beb-a95a-08df2f3c5dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|1800799024|376014|82310400026|56012099006|11063799006|261009221227099003|261009223027099003|10067099003|18002099003|6133799003|22082099003;
X-Microsoft-Antispam-Message-Info: kDvb2WPAzbquaam3RkPfrUyHO/RiXFxSBRCR498lONGxhpLCPt1ei1BsfTEAJVdSn7m2gd9n4rzldwLi3JjuFzgmv5a/TSIM59YXdSDPfPTiJ3EsKRNj3iZb4I+C6/yLs1TuxM2M3TnLfTrrzyZ3PKMOIm9jNO+FjFbCrOp46rzrjwkgHGoVs4AnzeR6CArQRkWXR4hw+Y1ZP/OHYxqva9MXuaM1MmEbiqGENJkxAXunNqVc93bu+ZbBfkXKhk8vEfF1S/MoOy5F+UWQo1zE8sU45yhZJ+r2QVTwl7cGuGdCAxmvX4KaBq9INLVsNQZfeerEQgdvbibts7ztDHxkx41VDRq3xO6Ak7lmUp36zVkD3QsGyk/Ej6fg7zUMccTVfftuo31RQaPbdoW1kaI+QLf3uBXgs4SFaOvtlJHoXLKAv6N+tQ/NvVZgXLtqvNwVAzPjxwqfyT1tsmo/JjtVPnLPMUeE15hqiMEdQBuLwFx2OeVnMLHqTKwO0zCGLDZ/sjmE1dt/9Uu8ZrhQX4Lf1nAezt3N0l5pYwZE8OlaM3PbFwGQahvh9w/qGZD4fDobGETy7d71UUgZdgB5oQexKM2THqtHnB64r9uoP161bN2l5Ba+edyE+yEc9iMf+AVgwF+40R4jxR2c4LZlM0LggQKUXttOZFVZM6ovi1LXkTpVslKW0bAib7xJn6CvTy2mg6IguwgGokmuKR3r5EW9lQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(1800799024)(376014)(82310400026)(56012099006)(11063799006)(261009221227099003)(261009223027099003)(10067099003)(18002099003)(6133799003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9cHqnzWugpnHlxc8VischLDlcQJ1xPAGLAWWa60aEQH+qjTp7/bq/XoO8S8mDzYFeey3G0YWI1F6p05joqnQJcdY6OL7dwqdfP+2/tg2TwYdqV+KfsvScIGkhschLwzgsWzSRL1blTPbE6FO4UKnzZ9QDlMIDxMxxFlIrr/rl9r9Z2gwboQwslQIPclMn+oMod9y2W8WnyupH6MgXTJ3WqX3hL/iNZMKCiq6Tl0quZ6wDUGR+3SgcvvxckjDhxLgERp1aCd3e6Jlu8TexQksQLKB/Ak+WOSxDH+RHBBc94mvSvQvzHBt5nrfrktQP5Su7nBiC1m4kh3/6GTaQjyzpb3rg4BwmMNIZbGxctPg0/ygkmTSKFKcjzyoWzlnSssrOOf7HMODF0tknUUuQsnAtZRVWOu49W5K9rsyZxjv6QKd+UDueiLU4hr8X2ko9A3i
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 06:27:23.0264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20bf46ed-9b89-4beb-a95a-08df2f3c5dfc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000037A9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8859
X-BeenThere: amd-gfx@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx@lists.freedesktop.org>
List-Help: <mailto:amd-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Samson Tam <Samson.Tam@amd.com>

This reverts commit fe6fdc89d793 ("drm/amd/display: Split
link_set_dsc_on_stream into encoder and DSC components").
Fixed 2 checkpatch errors.

Reviewed-by: George Shen <george.shen@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 273 ++++++++----------
 1 file changed, 114 insertions(+), 159 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 78ad92fe4ea2..bd806240ba2d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -717,94 +717,21 @@ static bool dp_set_hblank_reduction_on_rx(struct pipe_ctx *pipe_ctx)
 	return result;
 }
 
-/* TODO - There is overlapping functionality between link_set_dsc_pps_packet,
- * and set_encoder_dsc_config, the two functions should be refactored to avoid code duplication.
- */
-static void set_encoder_dsc_config(struct pipe_ctx *pipe_ctx,
-		struct dsc_config *dsc_cfg,
-		struct dsc_optc_config *dsc_optc_cfg,
-		bool enable)
-{
-	struct dc *dc = pipe_ctx->stream->ctx->dc;
-	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
-	struct dc_stream_state *stream = pipe_ctx->stream;
-	enum optc_dsc_mode optc_dsc_mode;
-	int odm_count = 1;
-	struct pipe_ctx *odm_pipe;
-	DC_LOGGER_INIT(dsc->ctx->logger);
-
-	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
-		odm_count++;
-
-	if (enable) {
-		optc_dsc_mode = dsc_optc_cfg->is_pixel_format_444 ?
-				OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
-
-		if (dc_is_dp_signal(stream->signal) && !dp_is_128b_132b_signal(pipe_ctx)) {
-			DC_LOG_DSC("Setting stream encoder DSC config for engine %d:", (int)pipe_ctx->stream_res.stream_enc->id);
-			dsc_optc_config_log(dsc, dsc_optc_cfg);
-			if (pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config)
-				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config(pipe_ctx->stream_res.stream_enc,
-										optc_dsc_mode,
-										dsc_optc_cfg->bytes_per_pixel,
-										dsc_optc_cfg->slice_width);
-
-			/* PPS SDP is set elsewhere because it has to be done after DIG FE is connected to DIG BE */
-		} else if (dc_is_hdmi_frl_signal(stream->signal)) {
-			uint8_t dsc_packed_pps[128];
-			struct dc_crtc_timing patched_crtc_timing = stream->timing;
-
-			DC_LOG_DSC("Setting stream encoder DSC config for engine %d:", (int)pipe_ctx->stream_res.hpo_frl_stream_enc->id);
-			dsc_optc_config_log(dsc, dsc_optc_cfg);
-			dsc_cfg->dc_dsc_cfg.num_slices_h *= odm_count;
-			dsc_cfg->pic_width *= odm_count;
-			dsc_cfg->dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
-			if (dc->debug.enable_hblank_borrow)
-				dsc_cfg->pic_width = stream->timing.h_addressable;
-			dsc->funcs->dsc_get_packed_pps(dsc, dsc_cfg, &dsc_packed_pps[0]);
-			pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_set_dsc_config(
-					pipe_ctx->stream_res.hpo_frl_stream_enc, &patched_crtc_timing, &dsc_packed_pps[0]);
-		}
-
-		return;
-	}
 
-	if (dc_is_dp_signal(stream->signal)) {
-		if (dp_is_128b_132b_signal(pipe_ctx))
-			pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_set_dsc_pps_info_packet(
-										pipe_ctx->stream_res.hpo_dp_stream_enc,
-										false,
-										NULL,
-										true);
-		else {
-			if (pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config)
-				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config(
-							pipe_ctx->stream_res.stream_enc,
-							OPTC_DSC_DISABLED, 0, 0);
-			pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
-							pipe_ctx->stream_res.stream_enc, false, NULL, true);
-		}
-	} else if (dc_is_hdmi_frl_signal(stream->signal)) {
-		pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_set_dsc_config(
-				pipe_ctx->stream_res.hpo_frl_stream_enc, &stream->timing, NULL);
-	}
-}
-
-/* Legacy implementation of DSC configuration sequence. DSC HW block programming
- * is independent of stream encoder and link configuration operations, and should
- * be configured separately during front-end programming, not within link DPMS sequences.
+/* The stream with these settings can be sent (unblanked) only after DSC was enabled on RX first,
+ * i.e. after dp_enable_dsc_on_rx() had been called
  */
-static bool configure_dsc_hw_block(struct pipe_ctx *pipe_ctx, bool enable,
-		struct dsc_config *dsc_cfg, struct dsc_optc_config *dsc_optc_cfg)
+void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 {
+	/* TODO: Move this to HWSS as this is hardware programming sequence not a
+	 * link layer sequence
+	 */
 	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
 	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct pipe_ctx *odm_pipe;
-	struct dccg *dccg = dc->res_pool->dccg;
 	int opp_cnt = 1;
-	DC_LOGGER_INIT(dsc->ctx->logger);
-
+	struct dccg *dccg = dc->res_pool->dccg;
 	/* It has been found that when DSCCLK is lower than 16Mhz, we will get DCN
 	 * register access hung. When DSCCLk is based on refclk, DSCCLk is always a
 	 * fixed value higher than 16Mhz so the issue doesn't occur. When DSCCLK is
@@ -814,34 +741,35 @@ static bool configure_dsc_hw_block(struct pipe_ctx *pipe_ctx, bool enable,
 	 * based on fixed value refclk when timing is smaller than 3x16Mhz (i.e
 	 * 48Mhz) pixel clock to avoid hitting this problem.
 	 */
-	bool should_use_dto_dscclk = dccg->funcs->set_dto_dscclk &&
+	bool should_use_dto_dscclk = (dccg->funcs->set_dto_dscclk != NULL) &&
 			stream->timing.pix_clk_100hz > 480000;
+	DC_LOGGER_INIT(dsc->ctx->logger);
 
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
 		opp_cnt++;
 
 	if (enable) {
+		struct dsc_config dsc_cfg;
+		struct dsc_optc_config dsc_optc_cfg = {0};
 		enum optc_dsc_mode optc_dsc_mode;
-		memset(dsc_cfg, 0, sizeof(*dsc_cfg));
-		memset(dsc_optc_cfg, 0, sizeof(*dsc_optc_cfg));
 
 		/* Enable DSC hw block */
-		dsc_cfg->pic_width = (stream->timing.h_addressable + pipe_ctx->dsc_padding_params.dsc_hactive_padding +
+		dsc_cfg.pic_width = (stream->timing.h_addressable + pipe_ctx->dsc_padding_params.dsc_hactive_padding +
 				stream->timing.h_border_left + stream->timing.h_border_right) / opp_cnt;
-		dsc_cfg->pic_height = stream->timing.v_addressable + stream->timing.v_border_top + stream->timing.v_border_bottom;
-		dsc_cfg->pixel_encoding = stream->timing.pixel_encoding;
-		dsc_cfg->color_depth = stream->timing.display_color_depth;
-		dsc_cfg->is_odm = pipe_ctx->next_odm_pipe != NULL;
-		dsc_cfg->dc_dsc_cfg = stream->timing.dsc_cfg;
-		ASSERT(dsc_cfg->dc_dsc_cfg.num_slices_h % opp_cnt == 0);
-		dsc_cfg->dc_dsc_cfg.num_slices_h /= opp_cnt;
-		dsc_cfg->dsc_padding = 0;
+		dsc_cfg.pic_height = stream->timing.v_addressable + stream->timing.v_border_top + stream->timing.v_border_bottom;
+		dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
+		dsc_cfg.color_depth = stream->timing.display_color_depth;
+		dsc_cfg.is_odm = pipe_ctx->next_odm_pipe ? true : false;
+		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
+		ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
+		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
+		dsc_cfg.dsc_padding = 0;
 
 		if (should_use_dto_dscclk)
-			dccg->funcs->set_dto_dscclk(dccg, dsc->inst, dsc_cfg->dc_dsc_cfg.num_slices_h);
-		if (!dsc->funcs->dsc_prepare_config(dsc, dsc_cfg, dsc_optc_cfg)) {
+			dccg->funcs->set_dto_dscclk(dccg, dsc->inst, dsc_cfg.dc_dsc_cfg.num_slices_h);
+		if (!dsc->funcs->dsc_prepare_config(dsc, &dsc_cfg, &dsc_optc_cfg)) {
 			ASSERT(false);
-			return false;
+			return;
 		}
 		dsc->funcs->dsc_set_config(dsc);
 		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
@@ -850,84 +778,111 @@ static bool configure_dsc_hw_block(struct pipe_ctx *pipe_ctx, bool enable,
 
 			ASSERT(odm_dsc);
 			if (!odm_dsc)
-				return false;
+				return;
 			if (should_use_dto_dscclk)
-				dccg->funcs->set_dto_dscclk(dccg, odm_dsc->inst,
-						dsc_cfg->dc_dsc_cfg.num_slices_h);
-			if (!odm_dsc->funcs->dsc_prepare_config(odm_dsc, dsc_cfg, dsc_optc_cfg)) {
+				dccg->funcs->set_dto_dscclk(dccg, odm_dsc->inst, dsc_cfg.dc_dsc_cfg.num_slices_h);
+			if (!odm_dsc->funcs->dsc_prepare_config(odm_dsc, &dsc_cfg, &dsc_optc_cfg)) {
 				ASSERT(false);
-				return false;
+				return;
 			}
 			odm_dsc->funcs->dsc_set_config(odm_dsc);
 			odm_dsc->funcs->dsc_enable(odm_dsc, odm_pipe->stream_res.opp->inst);
 		}
-		optc_dsc_mode = dsc_optc_cfg->is_pixel_format_444 ? OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
+		dsc_cfg.dc_dsc_cfg.num_slices_h *= opp_cnt;
+		dsc_cfg.pic_width *= opp_cnt;
+		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
 
-		/* Enable DSC in OPTC */
-		DC_LOG_DSC("Setting optc DSC config for tg instance %d:", pipe_ctx->stream_res.tg->inst);
-		dsc_optc_config_log(dsc, dsc_optc_cfg);
-		pipe_ctx->stream_res.tg->funcs->set_dsc_config(pipe_ctx->stream_res.tg,
-							optc_dsc_mode,
-							dsc_optc_cfg->bytes_per_pixel,
-							dsc_optc_cfg->slice_width);
-		return true;
-	}
+		optc_dsc_mode = dsc_optc_cfg.is_pixel_format_444 ? OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
 
-	/* disable DSC in OPTC */
-	pipe_ctx->stream_res.tg->funcs->set_dsc_config(
-			pipe_ctx->stream_res.tg,
-			OPTC_DSC_DISABLED, 0, 0);
+		/* Enable DSC in encoder */
+		if (dc_is_dp_signal(stream->signal) && !dp_is_128b_132b_signal(pipe_ctx)) {
+			DC_LOG_DSC("Setting stream encoder DSC config for engine %d:", (int)pipe_ctx->stream_res.stream_enc->id);
+			dsc_optc_config_log(dsc, &dsc_optc_cfg);
+			if (pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config)
+				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config(pipe_ctx->stream_res.stream_enc,
+										optc_dsc_mode,
+										dsc_optc_cfg.bytes_per_pixel,
+										dsc_optc_cfg.slice_width);
 
-	for (odm_pipe = pipe_ctx; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
-		odm_pipe->stream_res.dsc->funcs->dsc_disconnect(odm_pipe->stream_res.dsc);
+			/* PPS SDP is set elsewhere because it has to be done after DIG FE is connected to DIG BE */
+		} else if (dc_is_hdmi_frl_signal(stream->signal)) {
+			uint8_t dsc_packed_pps[128];
+			struct dc_crtc_timing patched_crtc_timing = stream->timing;
 
-		/*
-		 * dsc_disconnect is a double buffered register.
-		 * by the time we call dsc_disable, dsc may still remain
-		 * connected to OPP. In this case OPTC will no longer
-		 * get correct pixel data because DSCC is off. However
-		 * we also can't wait for the  disconnect pending
-		 * complete, because this function can be called
-		 * with/without OTG master lock acquired. When the lock
-		 * is acquired we will never get pending complete until
-		 * we release the lock later. So there is no easy way to
-		 * solve this problem especially when the lock is
-		 * acquired. DSC is a front end hw block it should be
-		 * programmed as part of front end sequence, where the
-		 * commit sequence without lock and update sequence
-		 * with lock are completely separated. However because
-		 * we are programming dsc as part of back end link
-		 * programming sequence, we don't know if front end OPTC
-		 * master lock is acquired. The back end should be
-		 * agnostic to front end lock. DSC programming shouldn't
-		 * belong to this sequence.
-		 */
-		odm_pipe->stream_res.dsc->funcs->dsc_disable(odm_pipe->stream_res.dsc);
-		if (dccg->funcs->set_ref_dscclk)
-			dccg->funcs->set_ref_dscclk(dccg, odm_pipe->stream_res.dsc->inst);
-	}
-	return true;
-}
+			DC_LOG_DSC("Setting stream encoder DSC config for engine %d:", (int)pipe_ctx->stream_res.hpo_frl_stream_enc->id);
+			dsc_optc_config_log(dsc, &dsc_optc_cfg);
 
-/* The stream with these settings can be sent (unblanked) only after DSC was enabled on RX first,
- * i.e. after dp_enable_dsc_on_rx() had been called
- */
-void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
-{
-	struct dsc_config dsc_cfg = {0};
-	struct dsc_optc_config dsc_optc_cfg = {0};
+			/* if we are borrowing from hblank, h_addressable and  pic_width need to be adjusted */
+			if (dc->debug.enable_hblank_borrow) {
+				dsc_cfg.pic_width = stream->timing.h_addressable;
+			}
 
-	if (!pipe_ctx->stream_res.dsc) {
-		ASSERT(false);
-		return;
-	}
+			dsc->funcs->dsc_get_packed_pps(dsc, &dsc_cfg, &dsc_packed_pps[0]);
+			pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_set_dsc_config(
+					pipe_ctx->stream_res.hpo_frl_stream_enc, &patched_crtc_timing, &dsc_packed_pps[0]);
+		}
 
-	if (enable) {
-		if (configure_dsc_hw_block(pipe_ctx, true, &dsc_cfg, &dsc_optc_cfg))
-			set_encoder_dsc_config(pipe_ctx, &dsc_cfg, &dsc_optc_cfg, true);
+		/* Enable DSC in OPTC */
+		DC_LOG_DSC("Setting optc DSC config for tg instance %d:", pipe_ctx->stream_res.tg->inst);
+		dsc_optc_config_log(dsc, &dsc_optc_cfg);
+		pipe_ctx->stream_res.tg->funcs->set_dsc_config(pipe_ctx->stream_res.tg,
+							optc_dsc_mode,
+							dsc_optc_cfg.bytes_per_pixel,
+							dsc_optc_cfg.slice_width);
 	} else {
-		set_encoder_dsc_config(pipe_ctx, &dsc_cfg, &dsc_optc_cfg, false);
-		configure_dsc_hw_block(pipe_ctx, false, &dsc_cfg, &dsc_optc_cfg);
+		/* disable DSC in OPTC */
+		pipe_ctx->stream_res.tg->funcs->set_dsc_config(
+				pipe_ctx->stream_res.tg,
+				OPTC_DSC_DISABLED, 0, 0);
+
+		/* disable DSC in stream encoder */
+		if (dc_is_dp_signal(stream->signal)) {
+			if (dp_is_128b_132b_signal(pipe_ctx))
+				pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_set_dsc_pps_info_packet(
+										pipe_ctx->stream_res.hpo_dp_stream_enc,
+										false,
+										NULL,
+										true);
+			else {
+				if (pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config)
+					pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config(
+							pipe_ctx->stream_res.stream_enc,
+							OPTC_DSC_DISABLED, 0, 0);
+				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
+							pipe_ctx->stream_res.stream_enc, false, NULL, true);
+			}
+		} else if (dc_is_hdmi_frl_signal(stream->signal))
+			pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_set_dsc_config(
+					pipe_ctx->stream_res.hpo_frl_stream_enc, &stream->timing, NULL);
+
+		/* disable DSC block */
+		for (odm_pipe = pipe_ctx; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
+			odm_pipe->stream_res.dsc->funcs->dsc_disconnect(odm_pipe->stream_res.dsc);
+			/*
+			 * TODO - dsc_disconnect is a double buffered register.
+			 * by the time we call dsc_disable, dsc may still remain
+			 * connected to OPP. In this case OPTC will no longer
+			 * get correct pixel data because DSCC is off. However
+			 * we also can't wait for the  disconnect pending
+			 * complete, because this function can be called
+			 * with/without OTG master lock acquired. When the lock
+			 * is acquired we will never get pending complete until
+			 * we release the lock later. So there is no easy way to
+			 * solve this problem especially when the lock is
+			 * acquired. DSC is a front end hw block it should be
+			 * programmed as part of front end sequence, where the
+			 * commit sequence without lock and update sequence
+			 * with lock are completely separated. However because
+			 * we are programming dsc as part of back end link
+			 * programming sequence, we don't know if front end OPTC
+			 * master lock is acquired. The back end should be
+			 * agnostic to front end lock. DSC programming shouldn't
+			 * belong to this sequence.
+			 */
+			odm_pipe->stream_res.dsc->funcs->dsc_disable(odm_pipe->stream_res.dsc);
+			if (dccg->funcs->set_ref_dscclk)
+				dccg->funcs->set_ref_dscclk(dccg, odm_pipe->stream_res.dsc->inst);
+		}
 	}
 }
 
-- 
2.43.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FCA5CA5FFC
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Oct 2026 17:04:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9356010F6F3;
	Wed,  7 Oct 2026 17:04:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lcKIXrvy";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011057.outbound.protection.outlook.com [52.101.57.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3350510F6D6
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Oct 2026 17:04:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhUvs6n5eY53k5osg357Gho6jkw7YPkRGtgkLBPfrFCORSO6EmVR5aR633TNcHFw++W3xKLoRd8Rzh++ezwy3pFhiKh69gYEDlHHIA50qFbvN7CIyBtkVqu7Dn8CURWtORr3xxxPyVJPhgfCDXOs2yfIsWs1GnMtcvfSzupqtU83KstFs1C8hB6JHswIOTEqa43UlwiLJbzSAyfsBZBYy1e0eUDqCwYVHbxSdz1ZcIQ3n9OpYQe31yKpzE8+u/z2FKFtHqb2qNzQ0FcO7HLXp2fM5guVCjFzPh85HiXthZv9wCSqyc5rZzbzmWAlih+NYMYY5Gv5VoO9SSsRkqL5nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YBAroCUeYIkXOMX4i3wy1/jIwHc008RVxynMjUFniQ=;
 b=KRUnAhthKI2sjDJDQ08E/9CB8jQvAnDmUId7Sn7aC0dGcKKXJ6+GXYvqAdsr3mkvc8cs/7ehHMP6Wsk2gnrZUSfEtj5i6r8hUbTbDFDTU6h7s4PGlYbridBVu9fdsIUrBe/C9lSyuShG5NTF5Ro3oUcW7YF/W6SzQXT5H9F3hCU4cR+5itH7Llts5SXl2d6m9vL2Wq/xNLXfAfiwsmZKWR0s8dgRJSa8XmJc990hbxev8ifRDhlTAiZV/HfCxGTmj69hCx0voEv6cZceWMb2/sI4WH/rdACtHIJCa7+oKTVplsLmHPPJ67SDKWEifkiZlwDJl5kLIyeTX7NDsLTfuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YBAroCUeYIkXOMX4i3wy1/jIwHc008RVxynMjUFniQ=;
 b=lcKIXrvywAQAAZxgapKi1GZU8FCmleQ1iZiGVv9hTIQal1/EQIWi0V1NizF48Tszdc2LDU/XVq2vkXCjEgzOTIMczB0InoK0t4VAm7B21ECB/wklhrUeT62gP6OCAvA5ZH/HwcFq+DVe1pXvF83u5fvgC5s0NyQvGyZEJ8B2cgk=
Received: from YT4PR01CA0046.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:fe::14)
 by DS0PR12MB8444.namprd12.prod.outlook.com (2603:10b6:8:128::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.15; Wed, 7 Oct
 2026 17:04:36 +0000
Received: from BN1PEPF00005FFC.namprd05.prod.outlook.com
 (2603:10b6:b01:fe:cafe::88) by YT4PR01CA0046.outlook.office365.com
 (2603:10b6:b01:fe::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 17:04:35 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN1PEPF00005FFC.mail.protection.outlook.com (10.167.243.228) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 17:04:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:31 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 7 Oct
 2026 12:04:31 -0500
Received: from box-0.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Wed, 7 Oct 2026 12:04:30 -0500
From: <ivan.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, George Shen <george.shen@amd.com>, Dillon Varone
 <dillon.varone@amd.com>
Subject: [PATCH 13/19] drm/amd/display: Split link_set_dsc_on_stream into
 encoder and DSC components
Date: Wed, 7 Oct 2026 12:59:46 -0400
Message-ID: <20261007170412.1898315-14-ivan.lipski@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261007170412.1898315-1-ivan.lipski@amd.com>
References: <20261007170412.1898315-1-ivan.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFC:EE_|DS0PR12MB8444:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f7da3da-d0ac-4709-3bb5-08df24951063
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|11063799006|6133799003|10067099003|18002099003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: Zyrh75+CscYQPJ4g8O5CRqhiKuwO1yjvQBMz6ilb8UZoc0eXuQUw348cpFREtU/DKAZTbnGk0T5o8CltVixE/ZWk/OEjfeMe40pcDbU4sf8EOANw28plPlnw3QxYtPKt2O2io3YBXJ2ObSSbRzCoxKnyYiTTwvBz3Ub+/VdJ2pT0KuN5EV5IYd3TLHoqY/DWSVTzmeFlcRzb4IHNAyiu7pEoKUao/K4dL8dCkVWycwDeJzX5Uw/E8pSQ9C2M7Y1simZNl6DNfkmj7AFg2vDVHub/3K97vxrSPJutFcqIIDRljin7MOoiBsq9SVNUUFuFpOSHrFu55hiv71I+ecXicY1/o5COiYeZ2LZHSMbV38TbjLOP4OV8pkWCyn2Db14CiOdQZmmRNdW2ARQ5qKhaimVT+tWWRoyaCOPgupJClYCT8MJKjgxgM23ttk2GLluR5tDELa7iNYUoPmsrfTDDZt77hGilRecBiXE16HvwZppqrvK9+UVmz9xNbU3t9XKUauhFD/sUwAJLwrgiCO453YEt7QnV1PaIjJJmxq0lUdDh/fbOEyyAdzJyb/sMloDXTOPriw0sRF/p4k82ThAAOtXvTxS79kf4RKSO9GE1J1T3LTWotJaBF9H8m9h76o8TsuiagIqQ6B2VTIh/XkC09RBlna2uPfp3nut7GRaqmAdKl7IBNUnAu1Ysu+wSz0WAcES4604VrPnO2wTfevZduA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(11063799006)(6133799003)(10067099003)(18002099003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: hl/odzd3gG4tIQZX095NFMrMYtWb4JUMwPRj9epiPvWSN4+N/p9JaWf06tZCS8yt2M2E2VFx5+Id3SXKBuKURv1mbVQNis6S2dOU9t1oIyufxaPogpycoU+d49PGXnb3Qk3p6DSMwpBoYxMYuEq377TrvKjx54V+DeqoFy6EnT6GpcNBnMgV2ywmI7ss+cEwrbMKlZW/oGJo+rKYSU+0IFC/hEVzZSOCq2Ognu7twEb7o+RmAGFe51WA0lRvH6LWHOJDCLgApAAtTRu6WG/V6yu4fbMk9jc7bWgMai6O248Q0qcJJnXCGh6gl/SWprPGTou2J6VoTt29vYVqY7QH7p0ZTUXAaNhEd7mrNJTpjHHMuUr6vX0c3vPuNdSN16CrrAO7WO82AvXPkukmyzOPO11k02xHF9u3A+lN/ZNH1QkfMAVdab1yNocmhEbRwAWK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 17:04:35.3133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f7da3da-d0ac-4709-3bb5-08df24951063
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFC.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8444
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

From: George Shen <george.shen@amd.com>

[Why]
DSC block programming should be independent from link programming. This
should be refactored such that DSC block programming is in HWSS.

[How]
The first step to the refactor is to split the existing logic into the
encoder portion and the DSC block portion.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: George Shen <george.shen@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
---
 .../gpu/drm/amd/display/dc/link/link_dpms.c   | 275 ++++++++++--------
 1 file changed, 159 insertions(+), 116 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
index 0d3b65d40807..ef577e0e5215 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_dpms.c
@@ -717,21 +717,94 @@ static bool dp_set_hblank_reduction_on_rx(struct pipe_ctx *pipe_ctx)
 	return result;
 }
 
+/* TODO - There is overlapping functionality between link_set_dsc_pps_packet,
+ * and set_encoder_dsc_config, the two functions should be refactored to avoid code duplication.
+ */
+static void set_encoder_dsc_config(struct pipe_ctx *pipe_ctx,
+		struct dsc_config *dsc_cfg,
+		struct dsc_optc_config *dsc_optc_cfg,
+		bool enable)
+{
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
+	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	enum optc_dsc_mode optc_dsc_mode;
+	int odm_count = 1;
+	struct pipe_ctx *odm_pipe;
+	DC_LOGGER_INIT(dsc->ctx->logger);
 
-/* The stream with these settings can be sent (unblanked) only after DSC was enabled on RX first,
- * i.e. after dp_enable_dsc_on_rx() had been called
+	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
+		odm_count++;
+
+	if (enable) {
+		optc_dsc_mode = dsc_optc_cfg->is_pixel_format_444 ?
+				OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
+
+		if (dc_is_dp_signal(stream->signal) && !dp_is_128b_132b_signal(pipe_ctx)) {
+			DC_LOG_DSC("Setting stream encoder DSC config for engine %d:", (int)pipe_ctx->stream_res.stream_enc->id);
+			dsc_optc_config_log(dsc, dsc_optc_cfg);
+			if (pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config)
+				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config(pipe_ctx->stream_res.stream_enc,
+										optc_dsc_mode,
+										dsc_optc_cfg->bytes_per_pixel,
+										dsc_optc_cfg->slice_width);
+
+			/* PPS SDP is set elsewhere because it has to be done after DIG FE is connected to DIG BE */
+		} else if (dc_is_hdmi_frl_signal(stream->signal)) {
+			uint8_t dsc_packed_pps[128];
+			struct dc_crtc_timing patched_crtc_timing = stream->timing;
+
+			DC_LOG_DSC("Setting stream encoder DSC config for engine %d:", (int)pipe_ctx->stream_res.hpo_frl_stream_enc->id);
+			dsc_optc_config_log(dsc, dsc_optc_cfg);
+			dsc_cfg->dc_dsc_cfg.num_slices_h *= odm_count;
+			dsc_cfg->pic_width *= odm_count;
+			dsc_cfg->dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
+			if (dc->debug.enable_hblank_borrow)
+				dsc_cfg->pic_width = stream->timing.h_addressable;
+			dsc->funcs->dsc_get_packed_pps(dsc, dsc_cfg, &dsc_packed_pps[0]);
+			pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_set_dsc_config(
+					pipe_ctx->stream_res.hpo_frl_stream_enc, &patched_crtc_timing, &dsc_packed_pps[0]);
+		}
+
+		return;
+	}
+
+	if (dc_is_dp_signal(stream->signal)) {
+		if (dp_is_128b_132b_signal(pipe_ctx))
+			pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_set_dsc_pps_info_packet(
+										pipe_ctx->stream_res.hpo_dp_stream_enc,
+										false,
+										NULL,
+										true);
+		else {
+			if (pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config)
+				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config(
+							pipe_ctx->stream_res.stream_enc,
+							OPTC_DSC_DISABLED, 0, 0);
+			pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
+							pipe_ctx->stream_res.stream_enc, false, NULL, true);
+		}
+	} else if (dc_is_hdmi_frl_signal(stream->signal)) {
+		pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_set_dsc_config(
+				pipe_ctx->stream_res.hpo_frl_stream_enc, &stream->timing, NULL);
+	}
+}
+
+/* Legacy implementation of DSC configuration sequence. DSC HW block programming
+ * is independent of stream encoder and link configuration operations, and should
+ * be configured separately during front-end programming, not within link DPMS sequences.
  */
-void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
+static bool configure_dsc_hw_block(struct pipe_ctx *pipe_ctx, bool enable,
+		struct dsc_config *dsc_cfg, struct dsc_optc_config *dsc_optc_cfg)
 {
-	/* TODO: Move this to HWSS as this is hardware programming sequence not a
-	 * link layer sequence
-	 */
 	struct display_stream_compressor *dsc = pipe_ctx->stream_res.dsc;
 	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct pipe_ctx *odm_pipe;
-	int opp_cnt = 1;
 	struct dccg *dccg = dc->res_pool->dccg;
+	int opp_cnt = 1;
+	DC_LOGGER_INIT(dsc->ctx->logger);
+
 	/* It has been found that when DSCCLK is lower than 16Mhz, we will get DCN
 	 * register access hung. When DSCCLk is based on refclk, DSCCLk is always a
 	 * fixed value higher than 16Mhz so the issue doesn't occur. When DSCCLK is
@@ -741,35 +814,34 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 	 * based on fixed value refclk when timing is smaller than 3x16Mhz (i.e
 	 * 48Mhz) pixel clock to avoid hitting this problem.
 	 */
-	bool should_use_dto_dscclk = (dccg->funcs->set_dto_dscclk != NULL) &&
+	bool should_use_dto_dscclk = dccg->funcs->set_dto_dscclk &&
 			stream->timing.pix_clk_100hz > 480000;
-	DC_LOGGER_INIT(dsc->ctx->logger);
 
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
 		opp_cnt++;
 
 	if (enable) {
-		struct dsc_config dsc_cfg;
-		struct dsc_optc_config dsc_optc_cfg = {0};
 		enum optc_dsc_mode optc_dsc_mode;
+		memset(dsc_cfg, 0, sizeof(*dsc_cfg));
+		memset(dsc_optc_cfg, 0, sizeof(*dsc_optc_cfg));
 
 		/* Enable DSC hw block */
-		dsc_cfg.pic_width = (stream->timing.h_addressable + pipe_ctx->dsc_padding_params.dsc_hactive_padding +
+		dsc_cfg->pic_width = (stream->timing.h_addressable + pipe_ctx->dsc_padding_params.dsc_hactive_padding +
 				stream->timing.h_border_left + stream->timing.h_border_right) / opp_cnt;
-		dsc_cfg.pic_height = stream->timing.v_addressable + stream->timing.v_border_top + stream->timing.v_border_bottom;
-		dsc_cfg.pixel_encoding = stream->timing.pixel_encoding;
-		dsc_cfg.color_depth = stream->timing.display_color_depth;
-		dsc_cfg.is_odm = pipe_ctx->next_odm_pipe ? true : false;
-		dsc_cfg.dc_dsc_cfg = stream->timing.dsc_cfg;
-		ASSERT(dsc_cfg.dc_dsc_cfg.num_slices_h % opp_cnt == 0);
-		dsc_cfg.dc_dsc_cfg.num_slices_h /= opp_cnt;
-		dsc_cfg.dsc_padding = 0;
+		dsc_cfg->pic_height = stream->timing.v_addressable + stream->timing.v_border_top + stream->timing.v_border_bottom;
+		dsc_cfg->pixel_encoding = stream->timing.pixel_encoding;
+		dsc_cfg->color_depth = stream->timing.display_color_depth;
+		dsc_cfg->is_odm = pipe_ctx->next_odm_pipe != NULL;
+		dsc_cfg->dc_dsc_cfg = stream->timing.dsc_cfg;
+		ASSERT(dsc_cfg->dc_dsc_cfg.num_slices_h % opp_cnt == 0);
+		dsc_cfg->dc_dsc_cfg.num_slices_h /= opp_cnt;
+		dsc_cfg->dsc_padding = 0;
 
 		if (should_use_dto_dscclk)
-			dccg->funcs->set_dto_dscclk(dccg, dsc->inst, dsc_cfg.dc_dsc_cfg.num_slices_h);
-		if (!dsc->funcs->dsc_prepare_config(dsc, &dsc_cfg, &dsc_optc_cfg)) {
+			dccg->funcs->set_dto_dscclk(dccg, dsc->inst, dsc_cfg->dc_dsc_cfg.num_slices_h);
+		if (!dsc->funcs->dsc_prepare_config(dsc, dsc_cfg, dsc_optc_cfg)) {
 			ASSERT(false);
-			return;
+			return false;
 		}
 		dsc->funcs->dsc_set_config(dsc);
 		dsc->funcs->dsc_enable(dsc, pipe_ctx->stream_res.opp->inst);
@@ -778,113 +850,84 @@ void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
 
 			ASSERT(odm_dsc);
 			if (!odm_dsc)
-				return;
+				return false;
 			if (should_use_dto_dscclk)
-				dccg->funcs->set_dto_dscclk(dccg, odm_dsc->inst, dsc_cfg.dc_dsc_cfg.num_slices_h);
-			if (!odm_dsc->funcs->dsc_prepare_config(odm_dsc, &dsc_cfg, &dsc_optc_cfg)) {
+				dccg->funcs->set_dto_dscclk(dccg, odm_dsc->inst,
+						dsc_cfg->dc_dsc_cfg.num_slices_h);
+			if (!odm_dsc->funcs->dsc_prepare_config(odm_dsc, dsc_cfg, dsc_optc_cfg)) {
 				ASSERT(false);
-				return;
+				return false;
 			}
 			odm_dsc->funcs->dsc_set_config(odm_dsc);
 			odm_dsc->funcs->dsc_enable(odm_dsc, odm_pipe->stream_res.opp->inst);
 		}
-		dsc_cfg.dc_dsc_cfg.num_slices_h *= opp_cnt;
-		dsc_cfg.pic_width *= opp_cnt;
-		dsc_cfg.dsc_padding = pipe_ctx->dsc_padding_params.dsc_hactive_padding;
+		optc_dsc_mode = dsc_optc_cfg->is_pixel_format_444 ? OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
 
-		optc_dsc_mode = dsc_optc_cfg.is_pixel_format_444 ? OPTC_DSC_ENABLED_444 : OPTC_DSC_ENABLED_NATIVE_SUBSAMPLED;
+		/* Enable DSC in OPTC */
+		DC_LOG_DSC("Setting optc DSC config for tg instance %d:", pipe_ctx->stream_res.tg->inst);
+		dsc_optc_config_log(dsc, dsc_optc_cfg);
+		pipe_ctx->stream_res.tg->funcs->set_dsc_config(pipe_ctx->stream_res.tg,
+							optc_dsc_mode,
+							dsc_optc_cfg->bytes_per_pixel,
+							dsc_optc_cfg->slice_width);
+		return true;
+	}
 
-		/* Enable DSC in encoder */
-		if (dc_is_dp_signal(stream->signal) && !dp_is_128b_132b_signal(pipe_ctx)) {
-			DC_LOG_DSC("Setting stream encoder DSC config for engine %d:", (int)pipe_ctx->stream_res.stream_enc->id);
-			dsc_optc_config_log(dsc, &dsc_optc_cfg);
-			if (pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config)
-				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config(pipe_ctx->stream_res.stream_enc,
-										optc_dsc_mode,
-										dsc_optc_cfg.bytes_per_pixel,
-										dsc_optc_cfg.slice_width);
+	/* disable DSC in OPTC */
+	pipe_ctx->stream_res.tg->funcs->set_dsc_config(
+			pipe_ctx->stream_res.tg,
+			OPTC_DSC_DISABLED, 0, 0);
 
-			/* PPS SDP is set elsewhere because it has to be done after DIG FE is connected to DIG BE */
-		}
-		else if (dc_is_hdmi_frl_signal(stream->signal)) {
-			uint8_t dsc_packed_pps[128];
-			struct dc_crtc_timing patched_crtc_timing = stream->timing;
+	for (odm_pipe = pipe_ctx; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
+		odm_pipe->stream_res.dsc->funcs->dsc_disconnect(odm_pipe->stream_res.dsc);
 
-			DC_LOG_DSC("Setting stream encoder DSC config for engine %d:", (int)pipe_ctx->stream_res.hpo_frl_stream_enc->id);
-			dsc_optc_config_log(dsc, &dsc_optc_cfg);
+		/*
+		 * dsc_disconnect is a double buffered register.
+		 * by the time we call dsc_disable, dsc may still remain
+		 * connected to OPP. In this case OPTC will no longer
+		 * get correct pixel data because DSCC is off. However
+		 * we also can't wait for the  disconnect pending
+		 * complete, because this function can be called
+		 * with/without OTG master lock acquired. When the lock
+		 * is acquired we will never get pending complete until
+		 * we release the lock later. So there is no easy way to
+		 * solve this problem especially when the lock is
+		 * acquired. DSC is a front end hw block it should be
+		 * programmed as part of front end sequence, where the
+		 * commit sequence without lock and update sequence
+		 * with lock are completely separated. However because
+		 * we are programming dsc as part of back end link
+		 * programming sequence, we don't know if front end OPTC
+		 * master lock is acquired. The back end should be
+		 * agnostic to front end lock. DSC programming shouldn't
+		 * belong to this sequence.
+		 */
+		odm_pipe->stream_res.dsc->funcs->dsc_disable(odm_pipe->stream_res.dsc);
+		if (dccg->funcs->set_ref_dscclk)
+			dccg->funcs->set_ref_dscclk(dccg, odm_pipe->stream_res.dsc->inst);
+	}
+	return true;
+}
 
-			/* if we are borrowing from hblank, h_addressable and  pic_width need to be adjusted */
-			if (dc->debug.enable_hblank_borrow) {
-				dsc_cfg.pic_width = stream->timing.h_addressable;
-			}
+/* The stream with these settings can be sent (unblanked) only after DSC was enabled on RX first,
+ * i.e. after dp_enable_dsc_on_rx() had been called
+ */
+void link_set_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable)
+{
+	struct dsc_config dsc_cfg = {0};
+	struct dsc_optc_config dsc_optc_cfg = {0};
 
-			dsc->funcs->dsc_get_packed_pps(dsc, &dsc_cfg, &dsc_packed_pps[0]);
-			pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_set_dsc_config(
-					pipe_ctx->stream_res.hpo_frl_stream_enc, &patched_crtc_timing, &dsc_packed_pps[0]);
-		}
+	if (!pipe_ctx->stream_res.dsc) {
+		ASSERT(false);
+		return;
+	}
 
-		/* Enable DSC in OPTC */
-		DC_LOG_DSC("Setting optc DSC config for tg instance %d:", pipe_ctx->stream_res.tg->inst);
-		dsc_optc_config_log(dsc, &dsc_optc_cfg);
-		pipe_ctx->stream_res.tg->funcs->set_dsc_config(pipe_ctx->stream_res.tg,
-							optc_dsc_mode,
-							dsc_optc_cfg.bytes_per_pixel,
-							dsc_optc_cfg.slice_width);
+	if (enable) {
+		if (configure_dsc_hw_block(pipe_ctx, true, &dsc_cfg, &dsc_optc_cfg))
+			set_encoder_dsc_config(pipe_ctx, &dsc_cfg, &dsc_optc_cfg, true);
 	} else {
-		/* disable DSC in OPTC */
-		pipe_ctx->stream_res.tg->funcs->set_dsc_config(
-				pipe_ctx->stream_res.tg,
-				OPTC_DSC_DISABLED, 0, 0);
-
-		/* disable DSC in stream encoder */
-		if (dc_is_dp_signal(stream->signal)) {
-			if (dp_is_128b_132b_signal(pipe_ctx))
-				pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_set_dsc_pps_info_packet(
-										pipe_ctx->stream_res.hpo_dp_stream_enc,
-										false,
-										NULL,
-										true);
-			else {
-				if (pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config)
-					pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_config(
-							pipe_ctx->stream_res.stream_enc,
-							OPTC_DSC_DISABLED, 0, 0);
-				pipe_ctx->stream_res.stream_enc->funcs->dp_set_dsc_pps_info_packet(
-							pipe_ctx->stream_res.stream_enc, false, NULL, true);
-			}
-		}
-		else if (dc_is_hdmi_frl_signal(stream->signal))
-			pipe_ctx->stream_res.hpo_frl_stream_enc->funcs->hdmi_frl_set_dsc_config(
-					pipe_ctx->stream_res.hpo_frl_stream_enc, &stream->timing, NULL);
-
-		/* disable DSC block */
-		for (odm_pipe = pipe_ctx; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
-			odm_pipe->stream_res.dsc->funcs->dsc_disconnect(odm_pipe->stream_res.dsc);
-			/*
-			 * TODO - dsc_disconnect is a double buffered register.
-			 * by the time we call dsc_disable, dsc may still remain
-			 * connected to OPP. In this case OPTC will no longer
-			 * get correct pixel data because DSCC is off. However
-			 * we also can't wait for the  disconnect pending
-			 * complete, because this function can be called
-			 * with/without OTG master lock acquired. When the lock
-			 * is acquired we will never get pending complete until
-			 * we release the lock later. So there is no easy way to
-			 * solve this problem especially when the lock is
-			 * acquired. DSC is a front end hw block it should be
-			 * programmed as part of front end sequence, where the
-			 * commit sequence without lock and update sequence
-			 * with lock are completely separated. However because
-			 * we are programming dsc as part of back end link
-			 * programming sequence, we don't know if front end OPTC
-			 * master lock is acquired. The back end should be
-			 * agnostic to front end lock. DSC programming shouldn't
-			 * belong to this sequence.
-			 */
-			odm_pipe->stream_res.dsc->funcs->dsc_disable(odm_pipe->stream_res.dsc);
-			if (dccg->funcs->set_ref_dscclk)
-				dccg->funcs->set_ref_dscclk(dccg, odm_pipe->stream_res.dsc->inst);
-		}
+		set_encoder_dsc_config(pipe_ctx, &dsc_cfg, &dsc_optc_cfg, false);
+		configure_dsc_hw_block(pipe_ctx, false, &dsc_cfg, &dsc_optc_cfg);
 	}
 }
 
-- 
2.43.0


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D324C43334
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E7651120DD;
	Thu, 30 Jun 2022 19:13:59 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2066.outbound.protection.outlook.com [40.107.243.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E49211A1ED
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:13:57 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1F8n8R6XQKS/9viQHQdPVY2ct5bUBjQJpFx6ZBhg6YrNsktJD3pe9aJMNfgp+gn0K6lbSMsueTXNKUE6gTr8e7xQSUgV18zza0cZSvrf8puZUcyEZlFR5mOsQrmwPScbXfmFkk7nL0DA69fnBCtKG5IGKOnv1BCmr/B1r/zJpS0JcKl8x7mGoDBNRb2kSPJQ381GaeyVvkQFEQvS9q8lbVhz+Mff+tHlVpZgCQ3femhW0HvYX8O2eXH8e0PGd/IRnJtcndq8PwB8ExpiB26Yvs8osxtbg5xMEAS7QlFRwgWx/EP8kyBwMcvnN961vOrpzccabqztNqZ4urBIA9d1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4UWJL50fa4h3F7ue3wa/cwbKHnKeo3O+YQjc6zUT1f8=;
 b=ZEEr4ekwWzE73hkp3v0zzye+lJ25Umo5ae1odYcKJx5Dvmj+E+rSzbbSHtI/rrNKF9eL7ffqmSgW5MfQ9QGq8n5L536y0S/n+olParq2m4Y6QciX8TdS9WpTJpjKAkm0AmcfPHIXWVVJw9AB3EbCKxaAQSzduuko+0eJciBLmUGqQwIXt5NclTmmr1iZX7VyCaZy1d8Ea4GxxYCKBxtsGkPpIDoTU0wVpLysTAe7jlEGnKcMf4CAtPBNwSgLngKpbBr5i5lZnhOeJlPrQpAP1rXvL6iLEDNSJ3Ybk9/VfPE1A9sJcPfQHdnQ1gVky66comBejy1eidn1kGRC4ijMQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4UWJL50fa4h3F7ue3wa/cwbKHnKeo3O+YQjc6zUT1f8=;
 b=t5llHgBpqjhu7NXe4Qz6Wkw3OzjenrAoOQCZtFVNW9cCn5+uKLJ5XnOHrbMPct5ET11UL14R5l/kIN05Z+o54lpbqAkcZ4WpDlNAShe26ThJeJiegNj1Dc2cJEaE2b/1Bd3Fw2xp2ZLEVtSbTYpYc1xkmASYcysklodgCtjzGY8=
Received: from BN6PR17CA0054.namprd17.prod.outlook.com (2603:10b6:405:75::43)
 by MW5PR12MB5621.namprd12.prod.outlook.com (2603:10b6:303:193::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 19:13:54 +0000
Received: from BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:75:cafe::3c) by BN6PR17CA0054.outlook.office365.com
 (2603:10b6:405:75::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15 via Frontend
 Transport; Thu, 30 Jun 2022 19:13:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT021.mail.protection.outlook.com (10.13.177.114) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:13:54 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:13:53 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/40] drm/amd/display: Apply ODM 2:1 policy for single
 display configuration
Date: Thu, 30 Jun 2022 15:12:47 -0400
Message-ID: <20220630191322.909650-6-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 87b92aec-08cd-48fd-50ad-08da5accacd3
X-MS-TrafficTypeDiagnostic: MW5PR12MB5621:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fk0cS2v8suOvN2fEZtWbOjJPm/6FiMScEPO7xGVnA8wSWR2S+MRjEfEKTMV2+cH40owVJAz9yfagC7dvYKrTMETAri9tl5qhhCx6UjFHo3wN7x/gepvW8nmn5LNjx4UsLrNNXgvgD9ln9Rt3bsmHgO4efKekpplBVZ92bx0u90mGgDuUe1dYZtdxetAfo4+dx1pyExIsDn0mRf8rkTndWVNXWmhWFCI9mH/R+REgGlzEmhZhYYi/5CrjKhN879pzYGMriiQqcn0jTrHafIXCw2ZeCCJ+jheDhPBMPc8bvM+zvMUSwqOe6+fvC+T34NMb1YM45Q0Dc5A5p7Fe/z+eAL2LiS5Y2PUF3V6SqCXteLjiKRhwh8qQGwUxh889GAfIdLJ+U662x0hLS5CiwHurdBbetvVtm64RQoieVKXaj/Bzg964dtwtAUyR7LNKKABlNwAUaEzSv+bIzpdaOdGFBHgRPllrbkeNDKKFAIa3XIQLDJ9x5/lm8GqH/Qi1v3bjJFZsITd80re0+Pc7HR14MV40wnzXEpMAauyjECv8AHwqT24S4IRj8FOZS8Bosa3i0UQJQK5XoXt27QDDacLTN5CmQhzruNkAv7PU9MJitsU7JN7RNR3OZ52fIiAYE0lsVQlKc5BVWIgB/UXhP9zuHCCER51G/RlvCdFxohX2c05PEosGgDH21/zM5SJ6GaGwdsXpuxvSx4bdLXEpBS0GmnHKDRgjiHd4KUYGPMvIkIJt9vW4zrc0ekk2gBxsI/UgKuQyRrEVb1XMi0ekP53Xu2uFu+kh8pPx3wp4/HeOAX7jjn7Zk0/vP03S7j77yJzBX1C3k3M/60pUAhOWiyGYRNHHtKQuRmtzqnE8bSlDCac=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(39860400002)(46966006)(40470700004)(36840700001)(81166007)(478600001)(30864003)(40460700003)(26005)(1076003)(7696005)(8936002)(2616005)(82740400003)(86362001)(6666004)(83380400001)(47076005)(336012)(186003)(16526019)(426003)(2906002)(41300700001)(356005)(82310400005)(40480700001)(36756003)(8676002)(4326008)(5660300002)(6916009)(54906003)(316002)(36860700001)(70586007)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:13:54.5079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 87b92aec-08cd-48fd-50ad-08da5accacd3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT021.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5621
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
 Samson Tam <Samson.Tam@amd.com>, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Samson Tam <Samson.Tam@amd.com>

[Why]
Most of the time, a single display uses the ODM combine. When using
multi-display, we use ODM combine only if it is necessary. These cases
are not flexible enough for us, and we can improve them to take
advantage of our hardware. We want to have more control over the ODM
policy.

[How]
This commit add a new debug flag named
enable_single_display_2to1_odm_policy to control the ODM policy and
another flag named enable_dp_dig_pixel_rate_div_policy to fine control
the ODM combine. This is possible by adding a new "pipe.dest" parameter
that can be set to ODM 2:1 combined if we use a single display. For
dynamic ODM combine, when using DP-DIG, DCN applies K2=2 settings for
ODM combine. Note that this feature affects the following registers:

- timing.pix_clk_100khz -> DP_VID_M, DP_VID_N
- requested_pix_clk_100hz -> DP_DTOn_PHASE
- OTGn_PIXEL_RATE_DIVK2
- DP_PIXEL_PER_CYCLE_PROCESSING_MODE
- DIG_FIFO_OUTPUT_PIXEL_MODE
- DP_VID_N_MUL

Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Samson Tam <Samson.Tam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +
 .../drm/amd/display/dc/dcn20/dcn20_resource.c |  7 +++
 .../dc/dcn32/dcn32_dio_stream_encoder.c       |  4 +-
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 58 +++++++++++++++++--
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |  5 ++
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  3 +-
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  6 ++
 .../amd/display/dc/dml/display_mode_structs.h |  1 +
 .../drm/amd/display/dc/dml/display_mode_vba.c |  3 +-
 .../amd/display/dc/inc/hw_sequencer_private.h |  1 +
 10 files changed, 83 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 447647ac3d80..7fa46e35bac6 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -748,6 +748,8 @@ struct dc_debug_options {
 	enum dml_hostvm_override_opts dml_hostvm_override;
 	bool use_legacy_soc_bb_mechanism;
 	bool exit_idle_opt_for_cursor_updates;
+	bool enable_single_display_2to1_odm_policy;
+	bool enable_dp_dig_pixel_rate_div_policy;
 };
 
 struct gpu_info_soc_bounding_box_v1_0;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
index 7802d603f796..0b1ef76e3268 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_resource.c
@@ -1237,6 +1237,8 @@ static void get_pixel_clock_parameters(
 	int opp_cnt = 1;
 	struct dc_link *link = stream->link;
 	struct link_encoder *link_enc = NULL;
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
+	struct dce_hwseq *hws = dc->hwseq;
 
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
 		opp_cnt++;
@@ -1268,6 +1270,11 @@ static void get_pixel_clock_parameters(
 	else if (optc2_is_two_pixels_per_containter(&stream->timing) || opp_cnt == 2)
 		pixel_clk_params->requested_pix_clk_100hz /= 2;
 
+	else if (hws->funcs.is_dp_dig_pixel_rate_div_policy) {
+		if (hws->funcs.is_dp_dig_pixel_rate_div_policy(pipe_ctx))
+			pixel_clk_params->requested_pix_clk_100hz /= 2;
+	}
+
 	if (stream->timing.timing_3d_format == TIMING_3D_FORMAT_HW_FRAME_PACKING)
 		pixel_clk_params->requested_pix_clk_100hz *= 2;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
index f16c4fcdf9e9..da7d2243664f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dio_stream_encoder.c
@@ -249,6 +249,7 @@ static void enc32_stream_encoder_dp_unblank(
 		const struct encoder_unblank_param *param)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
+	struct dc *dc = enc->ctx->dc;
 
 	if (param->link_settings.link_rate != LINK_RATE_UNKNOWN) {
 		uint32_t n_vid = 0x8000;
@@ -257,7 +258,8 @@ static void enc32_stream_encoder_dp_unblank(
 		uint64_t m_vid_l = n_vid;
 
 		/* YCbCr 4:2:0 : Computed VID_M will be 2X the input rate */
-		if (is_two_pixels_per_containter(&param->timing) || param->opp_cnt > 1) {
+		if (is_two_pixels_per_containter(&param->timing) || param->opp_cnt > 1
+			|| dc->debug.enable_dp_dig_pixel_rate_div_policy) {
 			/*this logic should be the same in get_pixel_clock_parameters() */
 			n_multiply = 1;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 01a95de80138..7da994d8cde3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1081,6 +1081,7 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	unsigned int odm_combine_factor = 0;
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
 
 	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
 
@@ -1100,9 +1101,7 @@ unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsign
 			*k1_div = PIXEL_RATE_DIV_BY_2;
 			*k2_div = PIXEL_RATE_DIV_BY_2;
 		} else {
-			if (odm_combine_factor == 1)
-				*k2_div = PIXEL_RATE_DIV_BY_4;
-			else if (odm_combine_factor == 2)
+			if ((odm_combine_factor == 2) || dc->debug.enable_dp_dig_pixel_rate_div_policy)
 				*k2_div = PIXEL_RATE_DIV_BY_2;
 		}
 	}
@@ -1122,10 +1121,61 @@ void dcn32_set_pixels_per_cycle(struct pipe_ctx *pipe_ctx)
 		return;
 
 	odm_combine_factor = get_odm_config(pipe_ctx, NULL);
-	if (optc2_is_two_pixels_per_containter(&pipe_ctx->stream->timing) || odm_combine_factor > 1)
+	if (optc2_is_two_pixels_per_containter(&pipe_ctx->stream->timing) || odm_combine_factor > 1
+		|| dcn32_is_dp_dig_pixel_rate_div_policy(pipe_ctx))
 		pix_per_cycle = 2;
 
 	if (pipe_ctx->stream_res.stream_enc->funcs->set_input_mode)
 		pipe_ctx->stream_res.stream_enc->funcs->set_input_mode(pipe_ctx->stream_res.stream_enc,
 				pix_per_cycle);
 }
+
+void dcn32_unblank_stream(struct pipe_ctx *pipe_ctx,
+		struct dc_link_settings *link_settings)
+{
+	struct encoder_unblank_param params = {0};
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	struct dc_link *link = stream->link;
+	struct dce_hwseq *hws = link->dc->hwseq;
+	struct pipe_ctx *odm_pipe;
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
+	uint32_t pix_per_cycle = 1;
+
+	params.opp_cnt = 1;
+	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
+		params.opp_cnt++;
+
+	/* only 3 items below are used by unblank */
+	params.timing = pipe_ctx->stream->timing;
+
+	params.link_settings.link_rate = link_settings->link_rate;
+
+	if (is_dp_128b_132b_signal(pipe_ctx)) {
+		/* TODO - DP2.0 HW: Set ODM mode in dp hpo encoder here */
+		pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_unblank(
+				pipe_ctx->stream_res.hpo_dp_stream_enc,
+				pipe_ctx->stream_res.tg->inst);
+	} else if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
+		if (optc2_is_two_pixels_per_containter(&stream->timing) || params.opp_cnt > 1
+			|| dc->debug.enable_dp_dig_pixel_rate_div_policy) {
+			params.timing.pix_clk_100hz /= 2;
+			pix_per_cycle = 2;
+		}
+		pipe_ctx->stream_res.stream_enc->funcs->dp_set_odm_combine(
+				pipe_ctx->stream_res.stream_enc, pix_per_cycle > 1);
+		pipe_ctx->stream_res.stream_enc->funcs->dp_unblank(link, pipe_ctx->stream_res.stream_enc, &params);
+	}
+
+	if (link->local_sink && link->local_sink->sink_signal == SIGNAL_TYPE_EDP)
+		hws->funcs.edp_backlight_control(link, true);
+}
+
+bool dcn32_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx)
+{
+	struct dc *dc = pipe_ctx->stream->ctx->dc;
+
+	if (dc_is_dp_signal(pipe_ctx->stream->signal) && !is_dp_128b_132b_signal(pipe_ctx) &&
+		dc->debug.enable_dp_dig_pixel_rate_div_policy)
+		return true;
+	return false;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
index 18227d58c51d..083f3aeb54f0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
@@ -79,4 +79,9 @@ void dcn32_subvp_pipe_control_lock(struct dc *dc,
 		struct pipe_ctx *top_pipe_to_program,
 		bool subvp_prev_use);
 
+void dcn32_unblank_stream(struct pipe_ctx *pipe_ctx,
+		struct dc_link_settings *link_settings);
+
+bool dcn32_is_dp_dig_pixel_rate_div_policy(struct pipe_ctx *pipe_ctx);
+
 #endif /* __DC_HWSS_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index 19d8a30b3358..30361ebe7d22 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -50,7 +50,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.send_immediate_sdp_message = dcn10_send_immediate_sdp_message,
 	.enable_stream = dcn20_enable_stream,
 	.disable_stream = dce110_disable_stream,
-	.unblank_stream = dcn20_unblank_stream,
+	.unblank_stream = dcn32_unblank_stream,
 	.blank_stream = dce110_blank_stream,
 	.enable_audio_stream = dce110_enable_audio_stream,
 	.disable_audio_stream = dce110_disable_audio_stream,
@@ -143,6 +143,7 @@ static const struct hwseq_private_funcs dcn32_private_funcs = {
 	.update_mall_sel = dcn32_update_mall_sel,
 	.calculate_dccg_k1_k2_values = dcn32_calculate_dccg_k1_k2_values,
 	.set_pixels_per_cycle = dcn32_set_pixels_per_cycle,
+	.is_dp_dig_pixel_rate_div_policy = dcn32_is_dp_dig_pixel_rate_div_policy,
 };
 
 void dcn32_hw_sequencer_init_functions(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 9434eedde1bf..468c18acfcdc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -3036,6 +3036,12 @@ int dcn32_populate_dml_pipes_from_context(
 				break;
 			}
 		}
+
+		pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
+		if (context->stream_count == 1) {
+			if (dc->debug.enable_single_display_2to1_odm_policy)
+				pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
+		}
 		pipe_cnt++;
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 00acf2079b06..b5d7e251ed81 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -497,6 +497,7 @@ struct _vcs_dpi_display_pipe_dest_params_st {
 	unsigned int vtotal_min;
 	unsigned int refresh_rate;
 	bool synchronize_timings;
+	unsigned int odm_combine_policy;
 };
 
 struct _vcs_dpi_display_pipe_params_st {
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 2676710a5f2b..74e17f5da8dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -561,7 +561,8 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 		mode_lib->vba.GPUVMMinPageSizeKBytes[mode_lib->vba.NumberOfActivePlanes] = src->gpuvm_min_page_size_kbytes;
 		mode_lib->vba.RefreshRate[mode_lib->vba.NumberOfActivePlanes] = dst->refresh_rate; //todo remove this
 		mode_lib->vba.OutputLinkDPRate[mode_lib->vba.NumberOfActivePlanes] = dout->dp_rate;
-		mode_lib->vba.ODMUse[mode_lib->vba.NumberOfActivePlanes] = dst->odm_combine;
+
+		mode_lib->vba.ODMUse[mode_lib->vba.NumberOfActivePlanes] = dst->odm_combine_policy;
 		//TODO: Need to assign correct values to dp_multistream vars
 		mode_lib->vba.OutputMultistreamEn[mode_lib->vba.NumberOfActiveSurfaces] = dout->dp_multistream_en;
 		mode_lib->vba.OutputMultistreamId[mode_lib->vba.NumberOfActiveSurfaces] = dout->dp_multistream_id;
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
index 2b2e5b808962..1cdea0efe5c1 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
@@ -154,6 +154,7 @@ struct hwseq_private_funcs {
 			unsigned int *k1_div,
 			unsigned int *k2_div);
 	void (*set_pixels_per_cycle)(struct pipe_ctx *pipe_ctx);
+	bool (*is_dp_dig_pixel_rate_div_policy)(struct pipe_ctx *pipe_ctx);
 #endif
 };
 
-- 
2.25.1


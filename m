Return-Path: <SRS0=EvCx=NS=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1090C432BE
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:44:37 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C28F460EE9
	for <amd-gfx@archiver.kernel.org>; Fri, 27 Aug 2021 20:44:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C28F460EE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FBFE6E9CE;
	Fri, 27 Aug 2021 20:44:37 +0000 (UTC)
X-Greylist: delayed 907 seconds by postgrey-1.36 at gabe;
 Fri, 27 Aug 2021 20:44:37 UTC
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (unknown
 [40.107.244.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C3056E9CE
 for <amd-gfx@lists.freedesktop.org>; Fri, 27 Aug 2021 20:44:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHksONZjNw1790oQSz3DQ2l3EORbCZrDApumkULn81RVavheiPBLzDDvM4QkwLkpEFRe4jAYhspi50Aof50ournVAEARECSiJeg5PILaSytgpYE34W32g1UdPed4XMCfxqsL7Fv5kE5wpKGvHrp+Gsso5BdjOPLue+FRQ32PQW0RzuvLl+aT/rRYv67aGWvFKLAVVEC++yOGayE6sfeR2FFPw0jj4AnYF7/PuxFHUF+Rpuh+UOhP7ZiuUDccr3151N72GxSzR9/oRjnQa4Q6FMHGFGaShRVIZnCTcQbA7MOdRpSjHb+Hwj3i/buHIKl7v3+0qIaps7xtGZw2PChSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EM8O++eEH3F7CaS7UvJnrNDoR9CD1BLwR6El52K52tY=;
 b=einiS0upXjuFm4bnQg9DpqCQ2fbtaJcUcoMznd6Fph0U7J9U9m9hcytvy0V0QeCA1+h886ZxKkJVwNA5ai5fcne6bosYO8yM/Lz7xbGWOfrFtRgSNrarT0Sr/ag2B76sALeriROANl7HJoc3xTRqyt0vb9/H0nfvW3bxuGzRKiLBFf1cWmg1um9r68/35VKGy/WsRtOZmz4K8s9kwHLhDC/uPvkTZPisp22G+HNVWs6a2Ct9XAMxk80RaCsrjccad2gGerH54ACdzddbbzEX+WU7OrI+W+A5G3K4FoTtOcMl93s6WoyIzS07kIJSFKkEozLDxYMJmnZgPr4sFUR4Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EM8O++eEH3F7CaS7UvJnrNDoR9CD1BLwR6El52K52tY=;
 b=XBe+pVZHUr4m8x9ifMaMQBVwHe4IQKTSO7Pa+yPgXDjVRU1dN+7XUoaEda/R3T9l6JP6LNhbnRHd8SaiyEY29OUBNdrkxmd+dC/T8rJt1EpgwmYryJ5Cjq07GdkIL+lLJ1IKYRnTK2an6Z4v1Ab5ogpskkV5SWo09NgfiUAqP4M=
Received: from MWHPR11CA0002.namprd11.prod.outlook.com (2603:10b6:301:1::12)
 by DM5PR1201MB0123.namprd12.prod.outlook.com (2603:10b6:4:50::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4436.22; Fri, 27 Aug
 2021 20:29:27 +0000
Received: from CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
 (2603:10b6:301:1:cafe::a6) by MWHPR11CA0002.outlook.office365.com
 (2603:10b6:301:1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend
 Transport; Fri, 27 Aug 2021 20:29:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT043.mail.protection.outlook.com (10.13.174.193) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4457.17 via Frontend Transport; Fri, 27 Aug 2021 20:29:26 +0000
Received: from DESKTOP-9DR2N9S.localdomain (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2242.12; Fri, 27 Aug 2021 15:29:24 -0500
From: Mikita Lipski <mikita.lipski@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Bhawanpreet.Lakha@amd.com>, <Rodrigo.Siqueira@amd.com>,
 <Aurabindo.Pillai@amd.com>, <Qingqing.Zhuo@amd.com>, <mikita.lipski@amd.com>, 
 <Anson.Jacob@amd.com>, "Leo (Hanghong) Ma" <hanghong.ma@amd.com>, Aric Cyr
 <aric.cyr@amd.com>
Subject: [PATCH 03/19] drm/amd/display: Add DPCD writes at key points
Date: Fri, 27 Aug 2021 16:28:54 -0400
Message-ID: <20210827202910.20864-4-mikita.lipski@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210827202910.20864-1-mikita.lipski@amd.com>
References: <20210827202910.20864-1-mikita.lipski@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f399d7e8-93ab-4c3b-87b0-08d969995d9c
X-MS-TrafficTypeDiagnostic: DM5PR1201MB0123:
X-Microsoft-Antispam-PRVS: <DM5PR1201MB01232F7DA1CA67D7CA7AB7AAE4C89@DM5PR1201MB0123.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z04s7ptBQ6mgKb0e1EaYVoJLVUV/eDBp/JvJpvx8MXeIOCuN/UCt2s8QNdfTT3HC89zlo3ZQ1fLVYPe4OD6h41Tx4rMTAFbC9qOmsUMpeb+pTvQz+83wPrXiHOsaryYKEqBNYLS/z9qAt/pcNBR8J7WbqKSeLbEPRFz289hvQlcqBKpqAb0zwMJS2N/PyKmbVsphiI7CVRP4c3EDXFtFIdwMzCywqTMRqeJWOBiLrKSh9D+2K/I2qcBUEueYeE/uGdHRdcKCzOQ7mPQ1jT4zKh+cCqeOI/tZLPrzIEx7ZIwvhqRgiRGX8JF1m0hnWz2XkRFTGleTVzs/lqDQBM9UFTZHHhc3BltAOYu7JE4ZmHmaQCCY9AnzwXgxaGhH6Ig/yehDovmAU3+Cc5NtHLqjfp4uhCmxpSczvCOwpk7C5g/WiOmG4nGiY0ogrEK1dShI/qUmkYekUKdNf8d+UG8QwHHB7lRTMFnhkVXA2cLgvlTssExOY0LbvgYpZWloWimA/htfHRuMFoU/GvVuTv6X2Cw1AzWmpLia/GBKPD5dUiZ8R3kcJq5NYtlo0w0FWQtuP3T3fae4fVBhq9tA7KXxYq1s1PFPcWb09dIUjXvsEfeA6o3WYUEkTN+8WaW1Y0lwlLh4ALuh+LVa7Z7i77tktd7speCwUx/4ViaEUoWXINwERhdzK2SUSEB9kEe1ZdZCPbteqadI06rOW9zXEPvET5pkgHxqQwmJZ8Pm1J9+6js=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(46966006)(36840700001)(70586007)(8936002)(82740400003)(336012)(83380400001)(6916009)(30864003)(186003)(426003)(356005)(70206006)(5660300002)(54906003)(2616005)(8676002)(82310400003)(36860700001)(478600001)(6666004)(44832011)(81166007)(86362001)(1076003)(47076005)(36756003)(2906002)(4326008)(316002)(16526019)(26005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2021 20:29:26.9508 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f399d7e8-93ab-4c3b-87b0-08d969995d9c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT043.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1201MB0123
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

From: "Leo (Hanghong) Ma" <hanghong.ma@amd.com>

This reverts "drm/amd/display: Revert "Add DPCD writes at key points"."
The following patch will fix the system hang issue.

Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Acked-by: Mikita Lipski <mikita.lipski@amd.com>
Signed-off-by: Leo (Hanghong) Ma <hanghong.ma@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  7 +++++++
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  |  3 ++-
 .../drm/amd/display/dc/core/dc_link_hwss.c    | 13 +++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  1 +
 .../amd/display/dc/dce/dce_stream_encoder.c   |  2 ++
 .../display/dc/dce110/dce110_hw_sequencer.c   | 21 ++++++++++++++++---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  4 ++--
 .../display/dc/dcn10/dcn10_stream_encoder.c   | 10 +++++++++
 .../display/dc/dcn10/dcn10_stream_encoder.h   |  2 ++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 10 ++++++++-
 .../display/dc/dcn20/dcn20_stream_encoder.c   |  5 +++++
 .../display/dc/dcn20/dcn20_stream_encoder.h   |  1 +
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    |  2 +-
 .../drm/amd/display/dc/dcn31/dcn31_hwseq.c    |  2 +-
 .../amd/display/dc/inc/hw/stream_encoder.h    |  2 ++
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |  1 +
 .../dc/virtual/virtual_stream_encoder.c       |  2 ++
 .../gpu/drm/amd/display/include/dpcd_defs.h   |  1 +
 .../amd/display/include/link_service_types.h  | 16 ++++++++++++++
 19 files changed, 95 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index f68a0d9543f4..3c3637fcc2b8 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3220,6 +3220,7 @@ void core_link_enable_stream(
 {
 	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	struct dc_stream_state *stream = pipe_ctx->stream;
+	struct dc_link *link = stream->sink->link;
 	enum dc_status status;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	enum otg_out_mux_dest otg_out_dest = OUT_MUX_DIO;
@@ -3248,6 +3249,9 @@ void core_link_enable_stream(
 			stream->use_vsc_sdp_for_colorimetry,
 			stream->link->dpcd_caps.dprx_feature.bits.SST_SPLIT_SDP_CAP);
 
+	if (dc_is_dp_signal(pipe_ctx->stream->signal))
+		dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_DP_STREAM_ATTR);
+
 	if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal))
 		pipe_ctx->stream_res.stream_enc->funcs->hdmi_set_stream_attribute(
 			pipe_ctx->stream_res.stream_enc,
@@ -3283,6 +3287,9 @@ void core_link_enable_stream(
 		resource_build_info_frame(pipe_ctx);
 		dc->hwss.update_info_frame(pipe_ctx);
 
+		if (dc_is_dp_signal(pipe_ctx->stream->signal))
+			dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_UPDATE_INFO_FRAME);
+
 		/* Do not touch link on seamless boot optimization. */
 		if (pipe_ctx->stream->apply_seamless_boot_optimization) {
 			pipe_ctx->stream->dpms_off = false;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 20bbde8524b8..44d7826e7654 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1814,6 +1814,7 @@ bool perform_link_training_with_retries(
 	 */
 	link_enc->funcs->connect_dig_be_to_fe(link_enc,
 							pipe_ctx->stream_res.stream_enc->id, true);
+	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_BE);
 
 	for (j = 0; j < attempts; ++j) {
 
@@ -4387,7 +4388,7 @@ bool dc_link_dp_set_test_pattern(
 			 * MuteAudioEndpoint(pPathMode->pDisplayPath, true);
 			 */
 			/* Blank stream */
-			pipes->stream_res.stream_enc->funcs->dp_blank(pipe_ctx->stream_res.stream_enc);
+			pipes->stream_res.stream_enc->funcs->dp_blank(link, pipe_ctx->stream_res.stream_enc);
 		}
 
 		dp_set_hw_test_pattern(link, test_pattern,
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
index 9c51cd09dcf1..2a064f7b669e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_hwss.c
@@ -61,6 +61,13 @@ void dp_receiver_power_ctrl(struct dc_link *link, bool on)
 			sizeof(state));
 }
 
+void dp_source_sequence_trace(struct dc_link *link, uint8_t dp_test_mode)
+{
+	if (link->dc->debug.enable_driver_sequence_debug)
+		core_link_write_dpcd(link, DP_SOURCE_SEQUENCE,
+					&dp_test_mode, sizeof(dp_test_mode));
+}
+
 void dp_enable_link_phy(
 	struct dc_link *link,
 	enum signal_type signal,
@@ -132,6 +139,7 @@ void dp_enable_link_phy(
 	if (dmcu != NULL && dmcu->funcs->unlock_phy)
 		dmcu->funcs->unlock_phy(dmcu);
 
+	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_ENABLE_LINK_PHY);
 	dp_receiver_power_ctrl(link, true);
 }
 
@@ -233,6 +241,8 @@ void dp_disable_link_phy(struct dc_link *link, enum signal_type signal)
 			dmcu->funcs->unlock_phy(dmcu);
 	}
 
+	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY);
+
 	/* Clear current link setting.*/
 	memset(&link->cur_link_settings, 0,
 			sizeof(link->cur_link_settings));
@@ -320,6 +330,7 @@ void dp_set_hw_test_pattern(
 	pattern_param.dp_panel_mode = dp_get_panel_mode(link);
 
 	encoder->funcs->dp_set_phy_pattern(encoder, &pattern_param);
+	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_SET_SOURCE_PATTERN);
 }
 
 void dp_retrain_link_dp_test(struct dc_link *link,
@@ -338,7 +349,7 @@ void dp_retrain_link_dp_test(struct dc_link *link,
 			pipes[i].stream->link == link) {
 			udelay(100);
 
-			pipes[i].stream_res.stream_enc->funcs->dp_blank(
+			pipes[i].stream_res.stream_enc->funcs->dp_blank(link,
 					pipes[i].stream_res.stream_enc);
 
 			/* disable any test pattern that might be active */
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 3f2a0f1807d2..c6c0fb17462e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -566,6 +566,7 @@ struct dc_debug_options {
 	bool force_enable_edp_fec;
 	/* FEC/PSR1 sequence enable delay in 100us */
 	uint8_t fec_enable_delay_in100us;
+	bool enable_driver_sequence_debug;
 #if defined(CONFIG_DRM_AMD_DC_DCN)
 	bool disable_z10;
 	bool enable_sw_cntl_psr;
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
index 8d4263da59f2..779bc92a2968 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
@@ -919,6 +919,7 @@ static void dce110_stream_encoder_stop_dp_info_packets(
 }
 
 static void dce110_stream_encoder_dp_blank(
+	struct dc_link *link,
 	struct stream_encoder *enc)
 {
 	struct dce110_stream_encoder *enc110 = DCE110STRENC_FROM_STRENC(enc);
@@ -967,6 +968,7 @@ static void dce110_stream_encoder_dp_blank(
 
 /* output video stream to link encoder */
 static void dce110_stream_encoder_dp_unblank(
+	struct dc_link *link,
 	struct stream_encoder *enc,
 	const struct encoder_unblank_param *param)
 {
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 62d595ded866..98549e397db9 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -67,6 +67,9 @@
 
 #include "dcn10/dcn10_hw_sequencer.h"
 
+#include "inc/link_dpcd.h"
+#include "dpcd_defs.h"
+
 #define GAMMA_HW_POINTS_NUM 256
 
 /*
@@ -1113,6 +1116,9 @@ void dce110_enable_audio_stream(struct pipe_ctx *pipe_ctx)
 		if (pipe_ctx->stream_res.audio)
 			pipe_ctx->stream_res.audio->enabled = true;
 	}
+
+	if (dc_is_dp_signal(pipe_ctx->stream->signal))
+		dp_source_sequence_trace(pipe_ctx->stream->link, DPCD_SOURCE_SEQ_AFTER_ENABLE_AUDIO_STREAM);
 }
 
 void dce110_disable_audio_stream(struct pipe_ctx *pipe_ctx)
@@ -1151,6 +1157,9 @@ void dce110_disable_audio_stream(struct pipe_ctx *pipe_ctx)
 		 * stream->stream_engine_id);
 		 */
 	}
+
+	if (dc_is_dp_signal(pipe_ctx->stream->signal))
+		dp_source_sequence_trace(pipe_ctx->stream->link, DPCD_SOURCE_SEQ_AFTER_DISABLE_AUDIO_STREAM);
 }
 
 void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
@@ -1177,6 +1186,8 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 			pipe_ctx->stream_res.stream_enc->id,
 			false);
 
+	if (dc_is_dp_signal(pipe_ctx->stream->signal))
+		dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_DISCONNECT_DIG_FE_BE);
 }
 
 void dce110_unblank_stream(struct pipe_ctx *pipe_ctx,
@@ -1192,7 +1203,7 @@ void dce110_unblank_stream(struct pipe_ctx *pipe_ctx,
 	params.link_settings.link_rate = link_settings->link_rate;
 
 	if (dc_is_dp_signal(pipe_ctx->stream->signal))
-		pipe_ctx->stream_res.stream_enc->funcs->dp_unblank(pipe_ctx->stream_res.stream_enc, &params);
+		pipe_ctx->stream_res.stream_enc->funcs->dp_unblank(link, pipe_ctx->stream_res.stream_enc, &params);
 
 	if (link->local_sink && link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
 		hws->funcs.edp_backlight_control(link, true);
@@ -1211,7 +1222,7 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
 	}
 
 	if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
-		pipe_ctx->stream_res.stream_enc->funcs->dp_blank(pipe_ctx->stream_res.stream_enc);
+		pipe_ctx->stream_res.stream_enc->funcs->dp_blank(link, pipe_ctx->stream_res.stream_enc);
 
 		if (!dc_is_embedded_signal(pipe_ctx->stream->signal)) {
 			/*
@@ -1436,6 +1447,7 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 		struct dc *dc)
 {
 	struct dc_stream_state *stream = pipe_ctx->stream;
+	struct dc_link *link = stream->link;
 	struct drr_params params = {0};
 	unsigned int event_triggers = 0;
 	struct pipe_ctx *odm_pipe = pipe_ctx->next_odm_pipe;
@@ -1499,6 +1511,9 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 			pipe_ctx->stream_res.stream_enc,
 			pipe_ctx->stream_res.tg->inst);
 
+	if (dc_is_dp_signal(pipe_ctx->stream->signal))
+		dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_OTG);
+
 	pipe_ctx->stream_res.opp->funcs->opp_set_dyn_expansion(
 			pipe_ctx->stream_res.opp,
 			COLOR_SPACE_YCBCR601,
@@ -1543,7 +1558,7 @@ static void power_down_encoders(struct dc *dc)
 	 * hurt for non-DP
 	 */
 	for (i = 0; i < dc->res_pool->stream_enc_count; i++) {
-		dc->res_pool->stream_enc[i]->funcs->dp_blank(
+		dc->res_pool->stream_enc[i]->funcs->dp_blank(dc->links[i],
 					dc->res_pool->stream_enc[i]);
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 35af0401f256..b7d9ccd0be6a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1424,7 +1424,7 @@ void dcn10_init_hw(struct dc *dc)
 
 					for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
 						if (fe == dc->res_pool->stream_enc[j]->id) {
-							dc->res_pool->stream_enc[j]->funcs->dp_blank(
+							dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
 										dc->res_pool->stream_enc[j]);
 							break;
 						}
@@ -3613,7 +3613,7 @@ void dcn10_unblank_stream(struct pipe_ctx *pipe_ctx,
 	if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
 		if (params.timing.pixel_encoding == PIXEL_ENCODING_YCBCR420)
 			params.timing.pix_clk_100hz /= 2;
-		pipe_ctx->stream_res.stream_enc->funcs->dp_unblank(pipe_ctx->stream_res.stream_enc, &params);
+		pipe_ctx->stream_res.stream_enc->funcs->dp_unblank(link, pipe_ctx->stream_res.stream_enc, &params);
 	}
 
 	if (link->local_sink && link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
index f1a08a7736ac..2a2e0e74d2db 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.c
@@ -29,6 +29,8 @@
 #include "dcn10_stream_encoder.h"
 #include "reg_helper.h"
 #include "hw_shared.h"
+#include "inc/link_dpcd.h"
+#include "dpcd_defs.h"
 
 #define DC_LOGGER \
 		enc1->base.ctx->logger
@@ -873,6 +875,7 @@ void enc1_stream_encoder_stop_dp_info_packets(
 }
 
 void enc1_stream_encoder_dp_blank(
+	struct dc_link *link,
 	struct stream_encoder *enc)
 {
 	struct dcn10_stream_encoder *enc1 = DCN10STRENC_FROM_STRENC(enc);
@@ -903,6 +906,8 @@ void enc1_stream_encoder_dp_blank(
 	/* disable DP stream */
 	REG_UPDATE(DP_VID_STREAM_CNTL, DP_VID_STREAM_ENABLE, 0);
 
+	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_DISABLE_DP_VID_STREAM);
+
 	/* the encoder stops sending the video stream
 	 * at the start of the vertical blanking.
 	 * Poll for DP_VID_STREAM_STATUS == 0
@@ -919,10 +924,13 @@ void enc1_stream_encoder_dp_blank(
 	 */
 
 	REG_UPDATE(DP_STEER_FIFO, DP_STEER_FIFO_RESET, true);
+
+	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_FIFO_STEER_RESET);
 }
 
 /* output video stream to link encoder */
 void enc1_stream_encoder_dp_unblank(
+	struct dc_link *link,
 	struct stream_encoder *enc,
 	const struct encoder_unblank_param *param)
 {
@@ -989,6 +997,8 @@ void enc1_stream_encoder_dp_unblank(
 	 */
 
 	REG_UPDATE(DP_VID_STREAM_CNTL, DP_VID_STREAM_ENABLE, true);
+
+	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_ENABLE_DP_VID_STREAM);
 }
 
 void enc1_stream_encoder_set_avmute(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
index 0d86df97878c..687d7e4bf7ca 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_stream_encoder.h
@@ -627,9 +627,11 @@ void enc1_stream_encoder_stop_dp_info_packets(
 	struct stream_encoder *enc);
 
 void enc1_stream_encoder_dp_blank(
+	struct dc_link *link,
 	struct stream_encoder *enc);
 
 void enc1_stream_encoder_dp_unblank(
+	struct dc_link *link,
 	struct stream_encoder *enc,
 	const struct encoder_unblank_param *param);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index ef185b93b31d..654733a44b7b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -52,6 +52,8 @@
 #include "dc_dmub_srv.h"
 #include "dce/dmub_hw_lock_mgr.h"
 #include "hw_sequencer.h"
+#include "inc/link_dpcd.h"
+#include "dpcd_defs.h"
 
 #define DC_LOGGER_INIT(logger)
 
@@ -2144,7 +2146,7 @@ void dcn20_unblank_stream(struct pipe_ctx *pipe_ctx,
 			params.timing.pix_clk_100hz /= 2;
 		pipe_ctx->stream_res.stream_enc->funcs->dp_set_odm_combine(
 				pipe_ctx->stream_res.stream_enc, params.opp_cnt > 1);
-		pipe_ctx->stream_res.stream_enc->funcs->dp_unblank(pipe_ctx->stream_res.stream_enc, &params);
+		pipe_ctx->stream_res.stream_enc->funcs->dp_unblank(link, pipe_ctx->stream_res.stream_enc, &params);
 	}
 
 	if (link->local_sink && link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
@@ -2387,6 +2389,9 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 	link->link_enc->funcs->connect_dig_be_to_fe(link->link_enc,
 						    pipe_ctx->stream_res.stream_enc->id, true);
 
+	if (dc_is_dp_signal(pipe_ctx->stream->signal))
+		dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_BE);
+
 	if (pipe_ctx->plane_state && pipe_ctx->plane_state->flip_immediate != 1) {
 		if (link->dc->hwss.program_dmdata_engine)
 			link->dc->hwss.program_dmdata_engine(pipe_ctx);
@@ -2394,6 +2399,9 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 
 	link->dc->hwss.update_info_frame(pipe_ctx);
 
+	if (dc_is_dp_signal(pipe_ctx->stream->signal))
+		dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_UPDATE_INFO_FRAME);
+
 	/* enable early control to avoid corruption on DP monitor*/
 	active_total_with_borders =
 			timing->h_addressable
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
index e6307397e0d2..44f31b7b9ac9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.c
@@ -29,6 +29,8 @@
 #include "dcn20_stream_encoder.h"
 #include "reg_helper.h"
 #include "hw_shared.h"
+#include "inc/link_dpcd.h"
+#include "dpcd_defs.h"
 
 #define DC_LOGGER \
 		enc1->base.ctx->logger
@@ -444,6 +446,7 @@ static bool is_two_pixels_per_containter(const struct dc_crtc_timing *timing)
 }
 
 void enc2_stream_encoder_dp_unblank(
+		struct dc_link *link,
 		struct stream_encoder *enc,
 		const struct encoder_unblank_param *param)
 {
@@ -522,6 +525,8 @@ void enc2_stream_encoder_dp_unblank(
 	 */
 
 	REG_UPDATE(DP_VID_STREAM_CNTL, DP_VID_STREAM_ENABLE, true);
+
+	dp_source_sequence_trace(link, DPCD_SOURCE_SEQ_AFTER_ENABLE_DP_VID_STREAM);
 }
 
 static void enc2_dp_set_odm_combine(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.h
index f3d1a0237bda..baa1e539f341 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_stream_encoder.h
@@ -104,6 +104,7 @@ void enc2_stream_encoder_dp_set_stream_attribute(
 	uint32_t enable_sdp_splitting);
 
 void enc2_stream_encoder_dp_unblank(
+	struct dc_link *link,
 	struct stream_encoder *enc,
 	const struct encoder_unblank_param *param);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 2e8ab9775fa3..61752f93daa6 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -549,7 +549,7 @@ void dcn30_init_hw(struct dc *dc)
 
 					for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
 						if (fe == dc->res_pool->stream_enc[j]->id) {
-							dc->res_pool->stream_enc[j]->funcs->dp_blank(
+							dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
 										dc->res_pool->stream_enc[j]);
 							break;
 						}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
index 83f7904630e6..07a9e0feda99 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_hwseq.c
@@ -194,7 +194,7 @@ void dcn31_init_hw(struct dc *dc)
 
 					for (j = 0; j < dc->res_pool->stream_enc_count; j++) {
 						if (fe == dc->res_pool->stream_enc[j]->id) {
-							dc->res_pool->stream_enc[j]->funcs->dp_blank(
+							dc->res_pool->stream_enc[j]->funcs->dp_blank(dc->links[i],
 										dc->res_pool->stream_enc[j]);
 							break;
 						}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
index 564ea6a727b0..bdfdb9323909 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/stream_encoder.h
@@ -165,9 +165,11 @@ struct stream_encoder_funcs {
 		struct stream_encoder *enc);
 
 	void (*dp_blank)(
+		struct dc_link *link,
 		struct stream_encoder *enc);
 
 	void (*dp_unblank)(
+		struct dc_link *link,
 		struct stream_encoder *enc,
 		const struct encoder_unblank_param *param);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
index fc1d289bb9fe..ba664bc49595 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
@@ -37,6 +37,7 @@ void dp_enable_link_phy(
 	const struct dc_link_settings *link_settings);
 
 void dp_receiver_power_ctrl(struct dc_link *link, bool on);
+void dp_source_sequence_trace(struct dc_link *link, uint8_t dp_test_mode);
 void edp_add_delay_for_T9(struct dc_link *link);
 bool edp_receiver_ready_T9(struct dc_link *link);
 bool edp_receiver_ready_T7(struct dc_link *link);
diff --git a/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
index 1053b165c139..42a29b712e0e 100644
--- a/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/virtual/virtual_stream_encoder.c
@@ -69,9 +69,11 @@ static void virtual_stream_encoder_stop_dp_info_packets(
 	struct stream_encoder *enc) {}
 
 static void virtual_stream_encoder_dp_blank(
+	struct dc_link *link,
 	struct stream_encoder *enc) {}
 
 static void virtual_stream_encoder_dp_unblank(
+	struct dc_link *link,
 	struct stream_encoder *enc,
 	const struct encoder_unblank_param *param) {}
 
diff --git a/drivers/gpu/drm/amd/display/include/dpcd_defs.h b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
index aec7389aff37..cd276f564c53 100644
--- a/drivers/gpu/drm/amd/display/include/dpcd_defs.h
+++ b/drivers/gpu/drm/amd/display/include/dpcd_defs.h
@@ -149,6 +149,7 @@ enum dpcd_psr_sink_states {
 	PSR_SINK_STATE_SINK_INTERNAL_ERROR = 7,
 };
 
+#define DP_SOURCE_SEQUENCE    		    0x30c
 #define DP_SOURCE_TABLE_REVISION	    0x310
 #define DP_SOURCE_PAYLOAD_SIZE		    0x311
 #define DP_SOURCE_SINK_CAP		    0x317
diff --git a/drivers/gpu/drm/amd/display/include/link_service_types.h b/drivers/gpu/drm/amd/display/include/link_service_types.h
index 32f5274ed34e..cbf2f0b55f0c 100644
--- a/drivers/gpu/drm/amd/display/include/link_service_types.h
+++ b/drivers/gpu/drm/amd/display/include/link_service_types.h
@@ -152,6 +152,22 @@ enum dp_panel_mode {
 	DP_PANEL_MODE_SPECIAL
 };
 
+enum dpcd_source_sequence {
+	DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_OTG = 1, /*done in apply_single_controller_ctx_to_hw */
+	DPCD_SOURCE_SEQ_AFTER_DP_STREAM_ATTR,         /*done in core_link_enable_stream */
+	DPCD_SOURCE_SEQ_AFTER_UPDATE_INFO_FRAME,      /*done in core_link_enable_stream/dcn20_enable_stream */
+	DPCD_SOURCE_SEQ_AFTER_CONNECT_DIG_FE_BE,      /*done in perform_link_training_with_retries/dcn20_enable_stream */
+	DPCD_SOURCE_SEQ_AFTER_ENABLE_LINK_PHY,        /*done in dp_enable_link_phy */
+	DPCD_SOURCE_SEQ_AFTER_SET_SOURCE_PATTERN,     /*done in dp_set_hw_test_pattern */
+	DPCD_SOURCE_SEQ_AFTER_ENABLE_AUDIO_STREAM,    /*done in dce110_enable_audio_stream */
+	DPCD_SOURCE_SEQ_AFTER_ENABLE_DP_VID_STREAM,   /*done in enc1_stream_encoder_dp_unblank */
+	DPCD_SOURCE_SEQ_AFTER_DISABLE_DP_VID_STREAM,  /*done in enc1_stream_encoder_dp_blank */
+	DPCD_SOURCE_SEQ_AFTER_FIFO_STEER_RESET,       /*done in enc1_stream_encoder_dp_blank */
+	DPCD_SOURCE_SEQ_AFTER_DISABLE_AUDIO_STREAM,   /*done in dce110_disable_audio_stream */
+	DPCD_SOURCE_SEQ_AFTER_DISABLE_LINK_PHY,       /*done in dp_disable_link_phy */
+	DPCD_SOURCE_SEQ_AFTER_DISCONNECT_DIG_FE_BE,   /*done in dce110_disable_stream */
+};
+
 /* DPCD_ADDR_TRAINING_LANEx_SET registers value */
 union dpcd_training_lane_set {
 	struct {
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F20DC4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:48:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C688510E4B0;
	Thu, 20 Oct 2022 15:48:00 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2042.outbound.protection.outlook.com [40.107.93.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 33B3B10E0BB
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:47:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VjNa9tp99ZbJQp+7iZ/gJXnesFP3cqT37aTYqMb5RmZr5WAwN5QxHDTk7Swjs7iKDO/7iZkpJoSwKdgPRV98si+5lm1nrWZ5JZxcwwsU16Ck7hjdtuVX/Ioi/9iegmNcPhNbwYivBBlWc3geEe4QN4pfWo+yn/eLQFD6OPfzg0KWGCmdLs+SoWhusbH6QDWLFk1nBxUUzbEfg9ypCH7VvTxmjdeBu1ukLSceVjhxnQaDocMxudNjdL2iQPOQp6dlLlQD8AwcjrdyB2wIALCpgQx3PR7FwxTNfzRuTz/gSfqTBUXo3w/K6Lhej0lXAMxkDl9FzD8oULVPnZzFkVnDFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nf2i95w4px1HSAwxiOK4X39slpZZCVvlXVgAobcRNUA=;
 b=YrKV5yDMRVlR6iUtaCtRuqY8ooVy0r9fQq5ITZtmsO9U32gi1TwgckNM5wxcXH1SlZVeAriBz+k52k788ZQSv/pY7rulyfuOkekg0I33OAh5i4TP+XyteqVOq4QRYzuiE6GxxeyilhMCxcWdQ4zMfkEElQTJIZfSiP0ZV+iJmVh21cz9bAoQit7cGgdZ80Xv2aEhKIlZkA+NOW9lVMBNStCS2iFpbYsl5JRd8XGmzfh8hYPp0VC01+ahbMxRyhtcWvS1lhEeRtzSOwolQS8K/jPnyo+mnEZHcsmFpCMSPJIU6CZa6R+ReBpeEcbhZvEhupT2Yt0Nr4brVxT1qN/DDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nf2i95w4px1HSAwxiOK4X39slpZZCVvlXVgAobcRNUA=;
 b=aZ0zmAcJpHILufdvK7wDKjB+rn9+WyRzNY7+RMHxFLE3ZUVLvvFt6+UOWNeWwH/6K8Kx+XRFH/IS8knAcXqX3e6G9ylZUbnMI3edi2lD8MjjlC2icdCjfN6ARSkAFBGePB6kAmbY9U+OTk/PUSaZtDes+QGtQPDWdXV+lS26emc=
Received: from DM6PR21CA0001.namprd21.prod.outlook.com (2603:10b6:5:174::11)
 by IA1PR12MB6116.namprd12.prod.outlook.com (2603:10b6:208:3e8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5723.29; Thu, 20 Oct
 2022 15:47:38 +0000
Received: from DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:174:cafe::8f) by DM6PR21CA0001.outlook.office365.com
 (2603:10b6:5:174::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.17 via Frontend
 Transport; Thu, 20 Oct 2022 15:47:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT036.mail.protection.outlook.com (10.13.172.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:47:38 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:47:35 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 04/33] drm/amd/display: move stream encoder audio setup to
 link_hwss
Date: Thu, 20 Oct 2022 11:46:33 -0400
Message-ID: <20221020154702.503934-5-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
References: <20221020154702.503934-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT036:EE_|IA1PR12MB6116:EE_
X-MS-Office365-Filtering-Correlation-Id: 778cd6c6-2eab-45ad-c6c3-08dab2b26a41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NB6Va4iRP1crqmkybiAHRO9yHMxmzShg8Y8gLCJozA8S2a364t6g10FdUkRvwE3SK9o3opiQgeTdRtSaKNuU3StsWe0sMIok6AE4g+/Rwp5ozHlbCxcKCbaZkIk3WCTWywUpARQC7uTtM1eVsgYcremEkII4eN+N1qXShMUjd8At3/gGOHspXBrH/xeXLJj6sUnsFlg17CEPXcY32F74cbA2ozaL5zCwLryC815yzx86IvRWap92A8wSh41rb2oab/pHx6x8Us2KOCanHriRUTjCRpPhlnS8+q3cy2cAS2/8TyohddkIXJN5QjBfEY56uL7mkIZXgOJ7OZEIUYnDUyGtk4Ft4k9EY+CU1xHUrKe235u2MzDSop02KeQ1OmEwPgYQP2sDpBaIc1kkc7IeUTPMl7xH098le2/i8oD7lmzvmqpUAv+vhNnFRaSIDMY28Raq4nEHYO/4nyBRbTKsSNNp0L7pO7dmy/r9plGunhDf8610sHniWELG9HIthZfb4DpqJA9BRXYxOPwTe84T8DA04L3yd3HiNvP6jSTd5UQ7K6ROv9SZH1ucaXMPSHKeZS4PK9FV7L2guPbMaxfFzuri+6KRFfenggGPMmZZyJiHeC4MyUJihesbwAT2j1YVZPzgBehPknBCB2pTSYjHEIJmVaiLiNiLeo3FmlEG0FLVeWYL97I7V6l3QETDtV/mT9NiuqZho/8eBNQaydNTJLfTRd1L0hCS/bKCVfdDoUflits0S6ApbYMg0qSRn1duJEZwwIEUfEoKiZu0AIqN/COpNKP8/5BQxhUciAoKv4fpNrHwGBVIH1Dbchz4UfS4
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(1076003)(2906002)(82310400005)(5660300002)(86362001)(8936002)(4326008)(41300700001)(26005)(36756003)(336012)(478600001)(16526019)(2616005)(186003)(40460700003)(8676002)(82740400003)(83380400001)(47076005)(426003)(356005)(70586007)(70206006)(7696005)(54906003)(316002)(40480700001)(36860700001)(6916009)(81166007)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:47:38.2183 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 778cd6c6-2eab-45ad-c6c3-08dab2b26a41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT036.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6116
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
Cc: stylon.wang@amd.com, Charlene Liu <Charlene.Liu@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

Unify stream encoder audio setup interface.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../display/dc/dce110/dce110_hw_sequencer.c   | 22 +++++--------------
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |  3 +++
 .../drm/amd/display/dc/link/link_hwss_dio.c   | 17 ++++++++++++++
 .../drm/amd/display/dc/link/link_hwss_dio.h   |  2 ++
 .../drm/amd/display/dc/link/link_hwss_dpia.c  |  1 +
 .../amd/display/dc/link/link_hwss_hpo_dp.c    | 10 +++++++++
 6 files changed, 38 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index a34bc631be00..c5380ce70653 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1455,6 +1455,9 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 	unsigned int event_triggers = 0;
 	struct pipe_ctx *odm_pipe = pipe_ctx->next_odm_pipe;
 	struct dce_hwseq *hws = dc->hwseq;
+	const struct link_hwss *link_hwss = get_link_hwss(
+			link, &pipe_ctx->link_res);
+
 
 	if (hws->funcs.disable_stream_gating) {
 		hws->funcs.disable_stream_gating(dc, pipe_ctx);
@@ -1465,23 +1468,8 @@ static enum dc_status apply_single_controller_ctx_to_hw(
 
 		build_audio_output(context, pipe_ctx, &audio_output);
 
-		if (dc_is_dp_signal(pipe_ctx->stream->signal))
-			if (is_dp_128b_132b_signal(pipe_ctx))
-				pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_audio_setup(
-						pipe_ctx->stream_res.hpo_dp_stream_enc,
-						pipe_ctx->stream_res.audio->inst,
-						&pipe_ctx->stream->audio_info);
-			else
-				pipe_ctx->stream_res.stream_enc->funcs->dp_audio_setup(
-						pipe_ctx->stream_res.stream_enc,
-						pipe_ctx->stream_res.audio->inst,
-						&pipe_ctx->stream->audio_info);
-		else
-			pipe_ctx->stream_res.stream_enc->funcs->hdmi_audio_setup(
-					pipe_ctx->stream_res.stream_enc,
-					pipe_ctx->stream_res.audio->inst,
-					&pipe_ctx->stream->audio_info,
-					&audio_output.crtc_info);
+		link_hwss->setup_audio_output(pipe_ctx, &audio_output,
+				pipe_ctx->stream_res.audio->inst);
 
 		pipe_ctx->stream_res.audio->funcs->az_configure(
 				pipe_ctx->stream_res.audio,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
index 7a2c8bc280d5..0f69946cce9f 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
@@ -38,6 +38,7 @@ struct link_resource;
 struct pipe_ctx;
 struct encoder_set_dp_phy_pattern_param;
 struct link_mst_stream_allocation_table;
+struct audio_output;
 
 struct link_hwss_ext {
 	/* function pointers below may require to check for NULL if caller
@@ -79,6 +80,8 @@ struct link_hwss {
 	void (*disable_link_output)(struct dc_link *link,
 			const struct link_resource *link_res,
 			enum signal_type signal);
+	void (*setup_audio_output)(struct pipe_ctx *pipe_ctx,
+			struct audio_output *audio_output, uint32_t audio_inst);
 	void (*enable_audio_packet)(struct pipe_ctx *pipe_ctx);
 	void (*disable_audio_packet)(struct pipe_ctx *pipe_ctx);
 };
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.c b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.c
index fcc3ce2b8fbf..33148b753c03 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.c
@@ -170,6 +170,22 @@ static void update_dio_stream_allocation_table(struct dc_link *link,
 	link_enc->funcs->update_mst_stream_allocation_table(link_enc, table);
 }
 
+void setup_dio_audio_output(struct pipe_ctx *pipe_ctx,
+		struct audio_output *audio_output, uint32_t audio_inst)
+{
+	if (dc_is_dp_signal(pipe_ctx->stream->signal))
+		pipe_ctx->stream_res.stream_enc->funcs->dp_audio_setup(
+				pipe_ctx->stream_res.stream_enc,
+				audio_inst,
+				&pipe_ctx->stream->audio_info);
+	else
+		pipe_ctx->stream_res.stream_enc->funcs->hdmi_audio_setup(
+				pipe_ctx->stream_res.stream_enc,
+				audio_inst,
+				&pipe_ctx->stream->audio_info,
+				&audio_output->crtc_info);
+}
+
 void enable_dio_audio_packet(struct pipe_ctx *pipe_ctx)
 {
 	if (dc_is_dp_signal(pipe_ctx->stream->signal))
@@ -208,6 +224,7 @@ static const struct link_hwss dio_link_hwss = {
 	.reset_stream_encoder = reset_dio_stream_encoder,
 	.setup_stream_attribute = setup_dio_stream_attribute,
 	.disable_link_output = disable_dio_link_output,
+	.setup_audio_output = setup_dio_audio_output,
 	.enable_audio_packet = enable_dio_audio_packet,
 	.disable_audio_packet = disable_dio_audio_packet,
 	.ext = {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.h b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.h
index 006830376e7d..9a108c3d7831 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.h
@@ -50,6 +50,8 @@ void set_dio_dp_lane_settings(struct dc_link *link,
 		const struct link_resource *link_res,
 		const struct dc_link_settings *link_settings,
 		const struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]);
+void setup_dio_audio_output(struct pipe_ctx *pipe_ctx,
+		struct audio_output *audio_output, uint32_t audio_inst);
 void enable_dio_audio_packet(struct pipe_ctx *pipe_ctx);
 void disable_dio_audio_packet(struct pipe_ctx *pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_dpia.c b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dpia.c
index f81949221e0d..861f3cd5b356 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_hwss_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dpia.c
@@ -57,6 +57,7 @@ static const struct link_hwss dpia_link_hwss = {
 	.reset_stream_encoder = reset_dio_stream_encoder,
 	.setup_stream_attribute = setup_dio_stream_attribute,
 	.disable_link_output = disable_dio_link_output,
+	.setup_audio_output = setup_dio_audio_output,
 	.enable_audio_packet = enable_dio_audio_packet,
 	.disable_audio_packet = disable_dio_audio_packet,
 	.ext = {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
index 668a66832579..2f46e1ac4ce0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
@@ -262,6 +262,15 @@ static void update_hpo_dp_stream_allocation_table(struct dc_link *link,
 			table);
 }
 
+static void setup_hpo_dp_audio_output(struct pipe_ctx *pipe_ctx,
+		struct audio_output *audio_output, uint32_t audio_inst)
+{
+	pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_audio_setup(
+			pipe_ctx->stream_res.hpo_dp_stream_enc,
+			audio_inst,
+			&pipe_ctx->stream->audio_info);
+}
+
 static void enable_hpo_dp_audio_packet(struct pipe_ctx *pipe_ctx)
 {
 	pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_audio_enable(
@@ -280,6 +289,7 @@ static const struct link_hwss hpo_dp_link_hwss = {
 	.reset_stream_encoder = reset_hpo_dp_stream_encoder,
 	.setup_stream_attribute = setup_hpo_dp_stream_attribute,
 	.disable_link_output = disable_hpo_dp_link_output,
+	.setup_audio_output = setup_hpo_dp_audio_output,
 	.enable_audio_packet = enable_hpo_dp_audio_packet,
 	.disable_audio_packet = disable_hpo_dp_audio_packet,
 	.ext = {
-- 
2.35.1


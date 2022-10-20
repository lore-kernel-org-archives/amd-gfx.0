Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266A3C4332F
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Oct 2022 15:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1403289854;
	Thu, 20 Oct 2022 15:48:29 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2071.outbound.protection.outlook.com [40.107.101.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C98B210E093
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Oct 2022 15:47:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P3SmQbFCxMNMSS4vaPGooMVWmEA+0HY1i5hWM0T7EPNLOZsdEqgPEcXerddO8WjKSeayeDYIF4fchbeGsmSf6OSdN5Wc4am+s930mlGjcJvI6yE7DVbP+IcF2RDyMSa2K8ZwlgcNzfhr7/3oHsFAjDf/7n6/57jKiUi9p9tN+8eCLvEy0W8FTkgsmtI/vevwvbw4AZzBnEYA448X8FbjlhSnQDL3Q1N2e+M6qOhX6kW7+a3WGc1auwLeklcw9J/jpQRoDWi1GF/PyELMy+UX7Uc61NbLPa7EpRBrbsregn+vn6aPqWgkDaZcafE27NBwwXoD5/kcHPdeMS99GJPgfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YxhAFq6y3gH99iUb2UlWL+Auch4eCll4j7xzTFcs978=;
 b=Mfpx8cVjZ6CGcvrEtJQumw7kwM+8DmU2/V6RgGF7mNfEGy3YcoTLRnlRqqPtfL9MYKSk6imbEqrK8lvqfYFJ9rN3VYkONEVl4bD/bF4sS/+XXP2NY3L6e0n5MZ/VbvaUEWG+lIFeqdQPobfAbjIwsB7WGJYrv+aSNTifDrlGI/7sEmjSVq25COD+OWPhPteLe/0ETY9ODQ+sws7NYr0H6Gu0BJxnlznr7qf/q/ZYpJ6tSwCcerwlGlp2tdaPd4N3XUNmFJUYcxq6McoeBtSO5/AF7kidGoAyYo3Yt5r2BD/KjCEqBnaskXgNdI7YTdPxa9OBfurS6y5JAP/P0Cxkpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YxhAFq6y3gH99iUb2UlWL+Auch4eCll4j7xzTFcs978=;
 b=msP7aXc45QxT2QsetDjGhe+52m3qPwyS5rSoWU7be5rBAMKxI5Qwkp6MDgltwDXXNB1CIiV++hobQ1uOxg5d2ihhHdcC76N1KGWLD58BD+s8q1bYUqUg8RhTsOOP/n0LUbrbYqSKWQ5N9tk8iJdaALUsiK/219WckH7TRbyoC6Q=
Received: from DM5PR07CA0079.namprd07.prod.outlook.com (2603:10b6:4:ad::44) by
 DM6PR12MB4201.namprd12.prod.outlook.com (2603:10b6:5:216::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5723.34; Thu, 20 Oct 2022 15:47:36 +0000
Received: from DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
 (2603:10b6:4:ad:cafe::9) by DM5PR07CA0079.outlook.office365.com
 (2603:10b6:4:ad::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5709.15 via Frontend
 Transport; Thu, 20 Oct 2022 15:47:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT019.mail.protection.outlook.com (10.13.172.172) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5746.16 via Frontend Transport; Thu, 20 Oct 2022 15:47:35 +0000
Received: from atma3.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 10:47:33 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/33] drm/amd/display: refactor enable/disable audio stream
 hw sequence
Date: Thu, 20 Oct 2022 11:46:32 -0400
Message-ID: <20221020154702.503934-4-Rodrigo.Siqueira@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM6NAM11FT019:EE_|DM6PR12MB4201:EE_
X-MS-Office365-Filtering-Correlation-Id: 4293059a-527f-4513-22e2-08dab2b268d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zGjEdEYLOFi2luWtiFtJis788HchsKPnqyledfX/smf8mJHMYqPI1G4BuKEdwY9zvjv+U5VMc975Xy2ySQIfndxWspSlfc+W0o55EuIGXW8xUV8/tuDmd0BbKOJLqu6eNrjvJZIKpRv61IY9DFii/ikTAb+wzmtYMGC8aQNofR4enN/eT9wUOh3ggrNeXtphxdxjmYZqN7WnjXq44HE9yuwSJj2IkZuGYKQ5i+e1n2TPm60ui7sHMUZ1ZPN2BpBENrb5VB3OTKkSVs6ynKzIBIYcXS7ivMTL5f/5LG2BdQA+ezN9kCr3zN+uv0sz/uiO0RlarFMCrh9Fh3GzTkBWKkNubdc3aPDacgm5Hy+PeY+NHV3s2n0qA3wjjtiiFymAfl5jLiEbFwKFHtVq560UsfxSHJEeOVES224zTiqpTJUIkdN1+7kYlEL9GWyiIqzORb+jeUgPEOd3RXgnFyqUOfEuQgbc36MpSFe/4fJuQFmoR0chrizauCKRhZ1vuApJXX/Gu0edZ97t1e/reu3hi/M5tMPy2CiH015ifkiXembrX+uhGVUkn9uoKBHBgrxwp/r4TF059QZYjlYU8YWVBXBorzOiu0hbBnDY+pgn0NdnOY2HpMYk3auqGXAI5I2Gi2lC8VFqSQKRNlElUNyrZ3cnF2vXBI0m3RmP/lmuqT+hJz0+Pz09YAAUP2GXetI0tLikdRew9PyH8dLkfCURv7D96QaMjocgJ6d6EsbXc1m1pFVTJTwg7GtyPrSw5Kx4RzBeUTfuhhtPxyExBRGzweTreVuA0B9uXpAgxkWqiod7c8lu6UIwpQSNTwV/If14
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(396003)(346002)(136003)(376002)(451199015)(40470700004)(46966006)(36840700001)(36756003)(2906002)(40460700003)(26005)(30864003)(82740400003)(356005)(86362001)(81166007)(4326008)(8936002)(5660300002)(7696005)(8676002)(426003)(40480700001)(70206006)(70586007)(83380400001)(47076005)(316002)(54906003)(36860700001)(336012)(41300700001)(82310400005)(6916009)(16526019)(1076003)(2616005)(186003)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2022 15:47:35.8573 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4293059a-527f-4513-22e2-08dab2b268d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT019.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4201
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

[why]
1. As recommended by hardware team, don't enable APG when stream is not
   enabled.
2. Move audio stream encoder programming into link_hwss.

[how]
1. Merge dp_audio_enable into enable audio stream hw sequence.
2. Move stream encoder programming into link hwss level to unify stream
   encoder programming interface.

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  6 +--
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 14 +-----
 .../display/dc/dce110/dce110_hw_sequencer.c   | 50 ++++---------------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  8 ---
 .../gpu/drm/amd/display/dc/dcn31/dcn31_apg.c  |  2 -
 .../gpu/drm/amd/display/dc/inc/link_hwss.h    |  2 +
 .../drm/amd/display/dc/link/link_hwss_dio.c   | 35 +++++++++++++
 .../drm/amd/display/dc/link/link_hwss_dio.h   |  2 +
 .../drm/amd/display/dc/link/link_hwss_dpia.c  |  2 +
 .../amd/display/dc/link/link_hwss_hpo_dp.c    | 15 ++++++
 10 files changed, 68 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index e346545b83b1..6990b64c0211 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -4229,6 +4229,7 @@ static void fpga_dp_hpo_enable_link_and_stream(struct dc_state *state, struct pi
 		link_hwss->ext.set_throttled_vcp_size(pipe_ctx, avg_time_slots_per_mtp);
 
 	dc->hwss.unblank_stream(pipe_ctx, &stream->link->cur_link_settings);
+	dc->hwss.enable_audio_stream(pipe_ctx);
 }
 
 void core_link_enable_stream(
@@ -4308,10 +4309,7 @@ void core_link_enable_stream(
 			/* Still enable stream features & audio on seamless boot for DP external displays */
 			if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT) {
 				enable_stream_features(pipe_ctx);
-				if (pipe_ctx->stream_res.audio != NULL) {
-					pipe_ctx->stream_res.stream_enc->funcs->dp_audio_enable(pipe_ctx->stream_res.stream_enc);
-					dc->hwss.enable_audio_stream(pipe_ctx);
-				}
+				dc->hwss.enable_audio_stream(pipe_ctx);
 			}
 
 #if defined(CONFIG_DRM_AMD_DC_HDCP)
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index c4acadba78d6..697c4925e1e9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -7339,19 +7339,7 @@ void dp_retrain_link_dp_test(struct dc_link *link,
 			link->dc->hwss.unblank_stream(&pipes[i],
 					link_setting);
 
-			if (pipes[i].stream_res.audio) {
-				/* notify audio driver for
-				 * audio modes of monitor */
-				pipes[i].stream_res.audio->funcs->az_enable(
-						pipes[i].stream_res.audio);
-
-				/* un-mute audio */
-				/* TODO: audio should be per stream rather than
-				 * per link */
-				pipes[i].stream_res.stream_enc->funcs->
-				audio_mute_control(
-					pipes[i].stream_res.stream_enc, false);
-			}
+			link->dc->hwss.enable_audio_stream(&pipes[i]);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index d260eaa1509e..a34bc631be00 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -688,16 +688,6 @@ void dce110_enable_stream(struct pipe_ctx *pipe_ctx)
 		early_control = lane_count;
 
 	tg->funcs->set_early_control(tg, early_control);
-
-	/* enable audio only within mode set */
-	if (pipe_ctx->stream_res.audio != NULL) {
-		if (dc_is_dp_signal(pipe_ctx->stream->signal))
-			pipe_ctx->stream_res.stream_enc->funcs->dp_audio_enable(pipe_ctx->stream_res.stream_enc);
-	}
-
-
-
-
 }
 
 static enum bp_result link_transmitter_control(
@@ -1081,12 +1071,14 @@ void dce110_enable_audio_stream(struct pipe_ctx *pipe_ctx)
 	struct dc *dc;
 	struct clk_mgr *clk_mgr;
 	unsigned int i, num_audio = 1;
+	const struct link_hwss *link_hwss;
 
 	if (!pipe_ctx->stream)
 		return;
 
 	dc = pipe_ctx->stream->ctx->dc;
 	clk_mgr = dc->clk_mgr;
+	link_hwss = get_link_hwss(pipe_ctx->stream->link, &pipe_ctx->link_res);
 
 	if (pipe_ctx->stream_res.audio && pipe_ctx->stream_res.audio->enabled == true)
 		return;
@@ -1103,56 +1095,35 @@ void dce110_enable_audio_stream(struct pipe_ctx *pipe_ctx)
 		if (num_audio >= 1 && clk_mgr->funcs->enable_pme_wa)
 			/*this is the first audio. apply the PME w/a in order to wake AZ from D3*/
 			clk_mgr->funcs->enable_pme_wa(clk_mgr);
-		/* un-mute audio */
-		/* TODO: audio should be per stream rather than per link */
-		if (is_dp_128b_132b_signal(pipe_ctx))
-			pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->audio_mute_control(
-					pipe_ctx->stream_res.hpo_dp_stream_enc, false);
-		else
-			pipe_ctx->stream_res.stream_enc->funcs->audio_mute_control(
-					pipe_ctx->stream_res.stream_enc, false);
+
+		link_hwss->enable_audio_packet(pipe_ctx);
+
 		if (pipe_ctx->stream_res.audio)
 			pipe_ctx->stream_res.audio->enabled = true;
 	}
-
-	if (dc_is_dp_signal(pipe_ctx->stream->signal))
-		dp_source_sequence_trace(pipe_ctx->stream->link, DPCD_SOURCE_SEQ_AFTER_ENABLE_AUDIO_STREAM);
 }
 
 void dce110_disable_audio_stream(struct pipe_ctx *pipe_ctx)
 {
 	struct dc *dc;
 	struct clk_mgr *clk_mgr;
+	const struct link_hwss *link_hwss;
 
 	if (!pipe_ctx || !pipe_ctx->stream)
 		return;
 
 	dc = pipe_ctx->stream->ctx->dc;
 	clk_mgr = dc->clk_mgr;
+	link_hwss = get_link_hwss(pipe_ctx->stream->link, &pipe_ctx->link_res);
 
 	if (pipe_ctx->stream_res.audio && pipe_ctx->stream_res.audio->enabled == false)
 		return;
 
-	if (is_dp_128b_132b_signal(pipe_ctx))
-		pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->audio_mute_control(
-				pipe_ctx->stream_res.hpo_dp_stream_enc, true);
-	else
-		pipe_ctx->stream_res.stream_enc->funcs->audio_mute_control(
-				pipe_ctx->stream_res.stream_enc, true);
+	link_hwss->disable_audio_packet(pipe_ctx);
+
 	if (pipe_ctx->stream_res.audio) {
 		pipe_ctx->stream_res.audio->enabled = false;
 
-		if (dc_is_dp_signal(pipe_ctx->stream->signal))
-			if (is_dp_128b_132b_signal(pipe_ctx))
-				pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_audio_disable(
-						pipe_ctx->stream_res.hpo_dp_stream_enc);
-			else
-				pipe_ctx->stream_res.stream_enc->funcs->dp_audio_disable(
-						pipe_ctx->stream_res.stream_enc);
-		else
-			pipe_ctx->stream_res.stream_enc->funcs->hdmi_audio_disable(
-					pipe_ctx->stream_res.stream_enc);
-
 		if (clk_mgr->funcs->enable_pme_wa)
 			/*this is the first audio. apply the PME w/a in order to wake AZ from D3*/
 			clk_mgr->funcs->enable_pme_wa(clk_mgr);
@@ -1163,9 +1134,6 @@ void dce110_disable_audio_stream(struct pipe_ctx *pipe_ctx)
 		 * stream->stream_engine_id);
 		 */
 	}
-
-	if (dc_is_dp_signal(pipe_ctx->stream->signal))
-		dp_source_sequence_trace(pipe_ctx->stream->link, DPCD_SOURCE_SEQ_AFTER_DISABLE_AUDIO_STREAM);
 }
 
 void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index a7e0001a8f46..1ac0ed5be605 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2601,14 +2601,6 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 
 	if (dc->hwseq->funcs.set_pixels_per_cycle)
 		dc->hwseq->funcs.set_pixels_per_cycle(pipe_ctx);
-
-	/* enable audio only within mode set */
-	if (pipe_ctx->stream_res.audio != NULL) {
-		if (is_dp_128b_132b_signal(pipe_ctx))
-			pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_audio_enable(pipe_ctx->stream_res.hpo_dp_stream_enc);
-		else if (dc_is_dp_signal(pipe_ctx->stream->signal))
-			pipe_ctx->stream_res.stream_enc->funcs->dp_audio_enable(pipe_ctx->stream_res.stream_enc);
-	}
 }
 
 void dcn20_program_dmdata_engine(struct pipe_ctx *pipe_ctx)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
index de5e18c2a3ac..2cec7131a96f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn31/dcn31_apg.c
@@ -134,8 +134,6 @@ static void apg31_se_audio_setup(
 
 	/* Disable forced mem power off */
 	REG_UPDATE(APG_MEM_PWR, APG_MEM_PWR_FORCE, 0);
-
-	apg31_enable(apg);
 }
 
 static void apg31_audio_mute_control(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
index 89964c980b87..7a2c8bc280d5 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/link_hwss.h
@@ -79,6 +79,8 @@ struct link_hwss {
 	void (*disable_link_output)(struct dc_link *link,
 			const struct link_resource *link_res,
 			enum signal_type signal);
+	void (*enable_audio_packet)(struct pipe_ctx *pipe_ctx);
+	void (*disable_audio_packet)(struct pipe_ctx *pipe_ctx);
 };
 #endif /* __DC_LINK_HWSS_H__ */
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.c b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.c
index 4227adbc646a..fcc3ce2b8fbf 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.c
@@ -170,11 +170,46 @@ static void update_dio_stream_allocation_table(struct dc_link *link,
 	link_enc->funcs->update_mst_stream_allocation_table(link_enc, table);
 }
 
+void enable_dio_audio_packet(struct pipe_ctx *pipe_ctx)
+{
+	if (dc_is_dp_signal(pipe_ctx->stream->signal))
+		pipe_ctx->stream_res.stream_enc->funcs->dp_audio_enable(
+				pipe_ctx->stream_res.stream_enc);
+
+	pipe_ctx->stream_res.stream_enc->funcs->audio_mute_control(
+			pipe_ctx->stream_res.stream_enc, false);
+
+	if (dc_is_dp_signal(pipe_ctx->stream->signal))
+		dp_source_sequence_trace(pipe_ctx->stream->link,
+				DPCD_SOURCE_SEQ_AFTER_ENABLE_AUDIO_STREAM);
+}
+
+void disable_dio_audio_packet(struct pipe_ctx *pipe_ctx)
+{
+	pipe_ctx->stream_res.stream_enc->funcs->audio_mute_control(
+			pipe_ctx->stream_res.stream_enc, true);
+
+	if (pipe_ctx->stream_res.audio) {
+		if (dc_is_dp_signal(pipe_ctx->stream->signal))
+			pipe_ctx->stream_res.stream_enc->funcs->dp_audio_disable(
+					pipe_ctx->stream_res.stream_enc);
+		else
+			pipe_ctx->stream_res.stream_enc->funcs->hdmi_audio_disable(
+					pipe_ctx->stream_res.stream_enc);
+	}
+
+	if (dc_is_dp_signal(pipe_ctx->stream->signal))
+		dp_source_sequence_trace(pipe_ctx->stream->link,
+				DPCD_SOURCE_SEQ_AFTER_DISABLE_AUDIO_STREAM);
+}
+
 static const struct link_hwss dio_link_hwss = {
 	.setup_stream_encoder = setup_dio_stream_encoder,
 	.reset_stream_encoder = reset_dio_stream_encoder,
 	.setup_stream_attribute = setup_dio_stream_attribute,
 	.disable_link_output = disable_dio_link_output,
+	.enable_audio_packet = enable_dio_audio_packet,
+	.disable_audio_packet = disable_dio_audio_packet,
 	.ext = {
 		.set_throttled_vcp_size = set_dio_throttled_vcp_size,
 		.enable_dp_link_output = enable_dio_dp_link_output,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.h b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.h
index 126d37f847a1..006830376e7d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.h
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dio.h
@@ -50,5 +50,7 @@ void set_dio_dp_lane_settings(struct dc_link *link,
 		const struct link_resource *link_res,
 		const struct dc_link_settings *link_settings,
 		const struct dc_lane_settings lane_settings[LANE_COUNT_DP_MAX]);
+void enable_dio_audio_packet(struct pipe_ctx *pipe_ctx);
+void disable_dio_audio_packet(struct pipe_ctx *pipe_ctx);
 
 #endif /* __LINK_HWSS_DIO_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_dpia.c b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dpia.c
index 64f7ea6a9aa3..f81949221e0d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_hwss_dpia.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_dpia.c
@@ -57,6 +57,8 @@ static const struct link_hwss dpia_link_hwss = {
 	.reset_stream_encoder = reset_dio_stream_encoder,
 	.setup_stream_attribute = setup_dio_stream_attribute,
 	.disable_link_output = disable_dio_link_output,
+	.enable_audio_packet = enable_dio_audio_packet,
+	.disable_audio_packet = disable_dio_audio_packet,
 	.ext = {
 		.set_throttled_vcp_size = set_dio_throttled_vcp_size,
 		.enable_dp_link_output = enable_dio_dp_link_output,
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
index 153a88381f2c..668a66832579 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
@@ -262,11 +262,26 @@ static void update_hpo_dp_stream_allocation_table(struct dc_link *link,
 			table);
 }
 
+static void enable_hpo_dp_audio_packet(struct pipe_ctx *pipe_ctx)
+{
+	pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_audio_enable(
+			pipe_ctx->stream_res.hpo_dp_stream_enc);
+}
+
+static void disable_hpo_dp_audio_packet(struct pipe_ctx *pipe_ctx)
+{
+	if (pipe_ctx->stream_res.audio)
+		pipe_ctx->stream_res.hpo_dp_stream_enc->funcs->dp_audio_disable(
+				pipe_ctx->stream_res.hpo_dp_stream_enc);
+}
+
 static const struct link_hwss hpo_dp_link_hwss = {
 	.setup_stream_encoder = setup_hpo_dp_stream_encoder,
 	.reset_stream_encoder = reset_hpo_dp_stream_encoder,
 	.setup_stream_attribute = setup_hpo_dp_stream_attribute,
 	.disable_link_output = disable_hpo_dp_link_output,
+	.enable_audio_packet = enable_hpo_dp_audio_packet,
+	.disable_audio_packet = disable_hpo_dp_audio_packet,
 	.ext = {
 		.set_throttled_vcp_size = set_hpo_dp_throttled_vcp_size,
 		.set_hblank_min_symbol_width = set_hpo_dp_hblank_min_symbol_width,
-- 
2.35.1


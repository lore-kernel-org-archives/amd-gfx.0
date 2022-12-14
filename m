Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9AA1C4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 20:22:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D089E10E47A;
	Wed, 14 Dec 2022 20:22:25 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2089.outbound.protection.outlook.com [40.107.94.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DFD7C10E472
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 20:22:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bV4yghEsf2LVXtuqhNA/zN9ie1oC73Zu9yOqyKX4C0xtaKJFBSVSjQLTtVjI9gOn3b0lR9A6aP+BVw4OfoYdleqxVKAeYhxlfll9qhmKZURYAlNtvplYSnL+BO/ox/CJ5776fPmU400c8ZOizKEXmAIAwcExYwk6kiuVYpwMYlx0I1h7QMd2SPB91G7j2O9oi0XVZTRwvi+Mudgifnfwzw3+QPr8BWhkjIqOFu1I/k7VlEsYV6s2pw4wwMynRokTYOTj1aczs9YTDiGDZ0192x1pJCZDPxb9W/Lpgki/3NAuwVGIJ+osKEWukjNX8sMMtqg86tVh+Phtw2kxoNfMHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XhkttXp3yekujJmcMDtjeZdz0woaSS1uxaxC+4xuvoQ=;
 b=CQWr3YR02iHoRnOeNtdZYSxHFoXZMCCIeGCgm04IsizGw3ESTH197jX1dqdOuBYI2BOE1NBK5+VUPDiw50fS3C9eMxG25/ZClZtWmHh6bKe5UXlPjeQVsKtSkLxdCQfJznyTAhklMoIADWDEBgtPjA3o6TiqAhPSZDGvmXResOVKFp/U1NB6ICn2foqBsT1xziHcnO9tdhDyyT6ApcYh4eXZRLmNL3dzIhO+tE3mIpajLusZbniQnhC5fTcwDsqZnex3bRrRt5rNf2Tc+Fd5m1ZstE9woJ+qT+1Wt73twfkkuz+617F9x5sdOCz9FcZ9jEMapi62SSQY7o5h6RVJkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XhkttXp3yekujJmcMDtjeZdz0woaSS1uxaxC+4xuvoQ=;
 b=NjwK+ouUU8tOf6hf14TvxVv1uq1daXdTVR4eXwiFeOHvgRpEICp3LGKjt79vf+NfythqFb0nENv7db2RkNQkMQHrmqc1fgMjxk6rcbHJPqoTns+os1yPXiTCYJGF5XuErD7mMqarmtlGU5ic7oG2XvBYMWoL9v4+aZvoEov1IKA=
Received: from MW2PR2101CA0004.namprd21.prod.outlook.com (2603:10b6:302:1::17)
 by DM4PR12MB5197.namprd12.prod.outlook.com (2603:10b6:5:394::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 20:22:01 +0000
Received: from CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:302:1:cafe::6) by MW2PR2101CA0004.outlook.office365.com
 (2603:10b6:302:1::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.2 via Frontend
 Transport; Wed, 14 Dec 2022 20:22:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT032.mail.protection.outlook.com (10.13.174.218) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 20:22:01 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:22:01 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 12:22:00 -0800
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 14 Dec 2022 14:22:00 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/18] drm/amd/display: move dccg programming from link hwss
 hpo dp to hwss
Date: Wed, 14 Dec 2022 15:21:34 -0500
Message-ID: <20221214202141.1721178-12-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT032:EE_|DM4PR12MB5197:EE_
X-MS-Office365-Filtering-Correlation-Id: 71e2d328-585a-4b45-58c6-08dade10dbdf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lsDcarifaAFmBVLm6jeWnTJ4IM9ltYUyBjU2yZdEQVaPn7/YIDwQVlcBNKAxYenQLIBD4Dj9h35cielhQ6iu0AaITr+NpJCrAlNlSxkx7PW77dD8nSTc/+n9oQURPkrdLSWK6siFltTtXBau00XCYzJXMwW5CsnV6naZ46GCt6vpmIIVeI6URC/sPyAI0+LFpqxHvedTvgdS2cVmaFBuWEX7LqpPRS7wdF7HEptJV32nVcAnzhJcsDNHe5XDOf8Zji1j4DOonMcpw4oXHu59/StVYX8GQF+dY6e+tQyRfoJ6WiQdEaQjHgFb6QqbsKtdlzrg2yjkA2yrzNQmEY3sNXnD9RPbp7ymj17HWOBA7I2eDnvu2AGmz0a5OaDSBZ7zL+AympVByoFOyW/kBqyx8JSRZgJT5tXs2nQPK87iMw6YXvDSUL/LPAJ1yp0wjmGlaaOH/abpBt4h9TQBXtGd0u6DBmoEuKvIIR5CnXoBqVSxqKumZA2YRJYgl8aRWBQHN10ddoblirTfb70EGQYZjrl3a3dqYHonv2O7lrQFAMnrTKSLqdhrfLHbL5l/gNkoHvYQMFUfGefvyrepf8EbeIWAOIY66Iy6Ysfi25b6A+v9pz41Ec5e8oAEj0OHfPI/zUFkooYwjtewPcEjhPy21G4Uxf3pfI7uAYPBGb3GJZOf9oohD7/FQFn14iLbda8+LN6LBu5IyUmrM8AqNKFANQHTyyihNdaKWIer2yLNHUQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(346002)(396003)(136003)(451199015)(46966006)(36840700001)(40470700004)(356005)(82740400003)(2906002)(81166007)(36860700001)(5660300002)(86362001)(44832011)(478600001)(41300700001)(40460700003)(40480700001)(6666004)(70586007)(4326008)(7696005)(8676002)(26005)(83380400001)(426003)(82310400005)(186003)(8936002)(47076005)(316002)(1076003)(2616005)(70206006)(54906003)(336012)(6916009)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 20:22:01.4318 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 71e2d328-585a-4b45-58c6-08dade10dbdf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5197
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
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why] dccg clock programming shouldn't be part of link hwss programming
sequence. The scope of link hwss is limited to encoder and phy
programming.

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
---
 .../display/dc/dce110/dce110_hw_sequencer.c   | 13 +++++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 50 +++++++++++++++++++
 .../amd/display/dc/link/link_hwss_hpo_dp.c    | 37 --------------
 3 files changed, 63 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index e6251ccadb70..2d9302959f25 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1142,6 +1142,10 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 	struct dc_link *link = stream->link;
 	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
+	struct dccg *dccg = dc->res_pool->dccg;
+	struct timing_generator *tg = pipe_ctx->stream_res.tg;
+	struct dtbclk_dto_params dto_params = {0};
+	int dp_hpo_inst;
 
 	if (dc_is_hdmi_tmds_signal(pipe_ctx->stream->signal)) {
 		pipe_ctx->stream_res.stream_enc->funcs->stop_hdmi_info_packets(
@@ -1161,6 +1165,15 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 
 	link_hwss->reset_stream_encoder(pipe_ctx);
 
+	if (is_dp_128b_132b_signal(pipe_ctx)) {
+		dto_params.otg_inst = tg->inst;
+		dto_params.timing = &pipe_ctx->stream->timing;
+		dp_hpo_inst = pipe_ctx->stream_res.hpo_dp_stream_enc->inst;
+		dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
+		dccg->funcs->disable_symclk32_se(dccg, dp_hpo_inst);
+		dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst, dp_hpo_inst);
+	}
+
 	if (is_dp_128b_132b_signal(pipe_ctx)) {
 		/* TODO: This looks like a bug to me as we are disabling HPO IO when
 		 * we are just disabling a single HPO stream. Shouldn't we disable HPO
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 366ba05cf8ef..c81b70c7f3f9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2639,6 +2639,37 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	hubp->mpcc_id = mpcc_id;
 }
 
+static enum phyd32clk_clock_source get_phyd32clk_src(struct dc_link *link)
+{
+	switch (link->link_enc->transmitter) {
+	case TRANSMITTER_UNIPHY_A:
+		return PHYD32CLKA;
+	case TRANSMITTER_UNIPHY_B:
+		return PHYD32CLKB;
+	case TRANSMITTER_UNIPHY_C:
+		return PHYD32CLKC;
+	case TRANSMITTER_UNIPHY_D:
+		return PHYD32CLKD;
+	case TRANSMITTER_UNIPHY_E:
+		return PHYD32CLKE;
+	default:
+		return PHYD32CLKA;
+	}
+}
+
+static int get_odm_segment_count(struct pipe_ctx *pipe_ctx)
+{
+	struct pipe_ctx *odm_pipe = pipe_ctx->next_odm_pipe;
+	int count = 1;
+
+	while (odm_pipe != NULL) {
+		count++;
+		odm_pipe = odm_pipe->next_odm_pipe;
+	}
+
+	return count;
+}
+
 void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 {
 	enum dc_lane_count lane_count =
@@ -2652,12 +2683,31 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 	struct timing_generator *tg = pipe_ctx->stream_res.tg;
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
 	struct dc *dc = pipe_ctx->stream->ctx->dc;
+	struct dtbclk_dto_params dto_params = {0};
+	struct dccg *dccg = dc->res_pool->dccg;
+	enum phyd32clk_clock_source phyd32clk;
+	int dp_hpo_inst;
 
 	if (is_dp_128b_132b_signal(pipe_ctx)) {
 		if (dc->hwseq->funcs.setup_hpo_hw_control)
 			dc->hwseq->funcs.setup_hpo_hw_control(dc->hwseq, true);
 	}
 
+	if (is_dp_128b_132b_signal(pipe_ctx)) {
+		dp_hpo_inst = pipe_ctx->stream_res.hpo_dp_stream_enc->inst;
+		dccg->funcs->set_dpstreamclk(dccg, DTBCLK0, tg->inst, dp_hpo_inst);
+
+		phyd32clk = get_phyd32clk_src(link);
+		dccg->funcs->enable_symclk32_se(dccg, dp_hpo_inst, phyd32clk);
+
+		dto_params.otg_inst = tg->inst;
+		dto_params.pixclk_khz = pipe_ctx->stream->timing.pix_clk_100hz / 10;
+		dto_params.num_odm_segments = get_odm_segment_count(pipe_ctx);
+		dto_params.timing = &pipe_ctx->stream->timing;
+		dto_params.ref_dtbclk_khz = dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(dc->clk_mgr);
+		dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
+	}
+
 	link_hwss->setup_stream_encoder(pipe_ctx);
 
 	if (pipe_ctx->plane_state && pipe_ctx->plane_state->flip_immediate != 1) {
diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
index 2f46e1ac4ce0..164d631e8809 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
@@ -87,57 +87,20 @@ static void set_hpo_dp_hblank_min_symbol_width(struct pipe_ctx *pipe_ctx,
 			hblank_min_symbol_width);
 }
 
-static int get_odm_segment_count(struct pipe_ctx *pipe_ctx)
-{
-	struct pipe_ctx *odm_pipe = pipe_ctx->next_odm_pipe;
-	int count = 1;
-
-	while (odm_pipe != NULL) {
-		count++;
-		odm_pipe = odm_pipe->next_odm_pipe;
-	}
-
-	return count;
-}
-
 static void setup_hpo_dp_stream_encoder(struct pipe_ctx *pipe_ctx)
 {
-	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	struct hpo_dp_stream_encoder *stream_enc = pipe_ctx->stream_res.hpo_dp_stream_enc;
 	struct hpo_dp_link_encoder *link_enc = pipe_ctx->link_res.hpo_dp_link_enc;
-	struct dccg *dccg = dc->res_pool->dccg;
-	struct timing_generator *tg = pipe_ctx->stream_res.tg;
-	struct dtbclk_dto_params dto_params = {0};
-	enum phyd32clk_clock_source phyd32clk = get_phyd32clk_src(pipe_ctx->stream->link);
 
-	dto_params.otg_inst = tg->inst;
-	dto_params.pixclk_khz = pipe_ctx->stream->timing.pix_clk_100hz / 10;
-	dto_params.num_odm_segments = get_odm_segment_count(pipe_ctx);
-	dto_params.timing = &pipe_ctx->stream->timing;
-	dto_params.ref_dtbclk_khz = dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(dc->clk_mgr);
-
-	dccg->funcs->set_dpstreamclk(dccg, DTBCLK0, tg->inst, stream_enc->inst);
-	dccg->funcs->enable_symclk32_se(dccg, stream_enc->inst, phyd32clk);
-	dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
 	stream_enc->funcs->enable_stream(stream_enc);
 	stream_enc->funcs->map_stream_to_link(stream_enc, stream_enc->inst, link_enc->inst);
 }
 
 static void reset_hpo_dp_stream_encoder(struct pipe_ctx *pipe_ctx)
 {
-	struct dc *dc = pipe_ctx->stream->ctx->dc;
 	struct hpo_dp_stream_encoder *stream_enc = pipe_ctx->stream_res.hpo_dp_stream_enc;
-	struct dccg *dccg = dc->res_pool->dccg;
-	struct timing_generator *tg = pipe_ctx->stream_res.tg;
-	struct dtbclk_dto_params dto_params = {0};
-
-	dto_params.otg_inst = tg->inst;
-	dto_params.timing = &pipe_ctx->stream->timing;
 
 	stream_enc->funcs->disable(stream_enc);
-	dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
-	dccg->funcs->disable_symclk32_se(dccg, stream_enc->inst);
-	dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst, stream_enc->inst);
 }
 
 static void setup_hpo_dp_stream_attribute(struct pipe_ctx *pipe_ctx)
-- 
2.39.0


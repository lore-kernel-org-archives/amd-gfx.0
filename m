Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4622CCE79A9
	for <amd-gfx@archiver.kernel.org>; Wed, 20 Sep 2023 03:19:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A575110E428;
	Wed, 20 Sep 2023 03:19:41 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01F2410E428
 for <amd-gfx@lists.freedesktop.org>; Wed, 20 Sep 2023 03:19:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cQD021U8oyjeUni1eLMt9RDPwZYgkUXVqGH3H3LjK0C6tms21us+OQyepyJ9GiRpxxcHqwjPNvwlXHM/0FbqllQ+xeM0E9UMu12/MsRGnaE1KfbbjdnniZ4ZnETrlyyjXuFgJjwhXUQ5P72x9Xclj6PymH7T6+GV4dF05zWGEMsr5eW/2IbrHOkjUWZDsLvYg9CpXuhc7GMg4XNgSQ448mB3h8l0idSG9ZgeLglfK2LksQzoJhaeZmGc6Gl2x33P2T2hQMPfRCzfNUa0e6LPbpiiNYkR4mVLuhnDvLdHk7ytlmRs3NQaWADXuLReMv5WMBq4grCvxbsvdsrmXaEHJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TVJMm4HPbbu0PqHfX5qBPv7G15la9Lk1sAEcgFxzcjo=;
 b=P1oGllHQN46vGHMXDs8rqI0xmHX7r8BzQAvMDcgr53PyDTdluJmyG3CgtteG2kxCIqinQx8x9M6xwEUgAz8uYfrbBXP8fQZxlgLGi0DQrtNRLa9eNvhhvZGbJEFbN6EQwMSiXq7yHrnipOK0PeZDbyHpztzbMTSw1YOZXLflMEXOOq1eX5/E+nNlknAR2U/hzRIMCUsJu7WgvN0T/286aMK/qcKGBLzbO0jVVIVkqH3MrHu6dZs4/OJxHBeUR4VdRc9SMYRrti6me0333a0rntJipOXjMKvdEmxLHlO4CLSzh1YFnhIpPBCpGd2Vo7HMelqV0kloWBIIINaHHnDrfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TVJMm4HPbbu0PqHfX5qBPv7G15la9Lk1sAEcgFxzcjo=;
 b=0wA/gqD7gjmGTObP7dhzUAWTEwDPbBZ+Gyy49jaPnzbya0Zp2KFsyk+UfucAYemXUc3UZf9i8QfU/buxwwCjbuTt63xbg76w0NLuK7W6yORZDaGUs52tozpvoYxl0rssgEyNYEArjhTN/yMiUIJs2GJWe57HrjtHSGy5xzxpHjM=
Received: from DS7PR03CA0154.namprd03.prod.outlook.com (2603:10b6:5:3b2::9) by
 SA1PR12MB8886.namprd12.prod.outlook.com (2603:10b6:806:375::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.27; Wed, 20 Sep 2023 03:19:33 +0000
Received: from DS1PEPF0001708E.namprd03.prod.outlook.com
 (2603:10b6:5:3b2:cafe::48) by DS7PR03CA0154.outlook.office365.com
 (2603:10b6:5:3b2::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28 via Frontend
 Transport; Wed, 20 Sep 2023 03:19:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0001708E.mail.protection.outlook.com (10.167.17.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Wed, 20 Sep 2023 03:19:33 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 19 Sep
 2023 22:19:32 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Tue, 19 Sep 2023 22:19:27 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/19] drm/amd/display: Fix DP2.0 timing sync
Date: Wed, 20 Sep 2023 11:16:12 +0800
Message-ID: <20230920031624.3129206-8-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230920031624.3129206-1-Wayne.Lin@amd.com>
References: <20230920031624.3129206-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0001708E:EE_|SA1PR12MB8886:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e9e56e-2556-49ad-fedd-08dbb988692a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lpKelpt8vBmNxDX5t9StW34VcDCy5Xjls3/m5fYW//B61T9a7ck7Kty0K9nwhW9SI/gXIFcDKVdTK/DLB2Qiro2qiu/f7OKJeqgL6MQdF3mfZmQaKK/sF73fbrlAxeuNjnwAk9OCUcicvSlfXCTtZww9ZYn3pxDQ4DRYHoOgDztXEXCZqMCbQbRtXnGzzZG/AiaeUygQnzsgOdlBj3UqqqiV+y6pOCFYMmZEyJhz4h52xzn3DXLGg6d+omxmNcH10TWi1zt2QQ1BSYJzYNyvoIaEJ+2xreP2iC+YYgA3mUjrrf09fByeXhflYiLMneRI1kki3FI91XBiyESmbSje97ywTlZdYIl4qvvS3qEuX/LqWebGkoZGH3v0bzjGzk0Wzb0wEWL2H9RtH3OQfmobCCG21IQ2nQ8jGsl0gIHGPSmKd0JuE5ohsC+Um/h0krclTI029EDJlFPCDQfhKfryMo1BesRXqSSPUR9+bRhOmEa/+5BDYJprYDdWbTC3u9uxpq5fXl0mr3SEMeu5N7O6Zx+DFaL21vXa8/kbgYaigLrMk9atlb/BhK2THR29ir1WltUcY4oZHmDXkHucNhGD4s9rrP9s1WJbd/yBxl+8ADld3x2EEmcjOyzLhl9SnDKVOrUFOZM2EcbYb6OoLuhgbZoJ2RLtqiZmSzGtMB6BQbeMstRZsWmpD/B8qMbJSJzGkPlmxVT7q1d3CqRdHfEgdsg2/x4ZnXeSTWBbKkBbKRDINr2GEjz75VHOYojUy8NqhvcgwxeWctdp10LpWRCi7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(186009)(82310400011)(451199024)(1800799009)(40470700004)(36840700001)(46966006)(40460700003)(2906002)(83380400001)(86362001)(6666004)(1076003)(36756003)(7696005)(2616005)(478600001)(336012)(26005)(40480700001)(426003)(8676002)(36860700001)(8936002)(4326008)(47076005)(70586007)(5660300002)(41300700001)(316002)(81166007)(356005)(82740400003)(54906003)(6916009)(70206006)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2023 03:19:33.3392 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e9e56e-2556-49ad-fedd-08dbb988692a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF0001708E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8886
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
Cc: stylon.wang@amd.com, Ilya Bakoulin <ilya.bakoulin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Ariel Bernstein <eric.bernstein@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Ilya Bakoulin <ilya.bakoulin@amd.com>

[Why]
Triggering OTG sync before all OTG/HPO clock programming is complete
causes timing sync to fail and a subsequent P-state hang.

[How]
Move DTB clock programming earlier in the sequence to
enable_stream_timing.

Reviewed-by: Ariel Bernstein <eric.bernstein@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Ilya Bakoulin <ilya.bakoulin@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 81 +++++++++++--------
 .../drm/amd/display/dc/dcn314/dcn314_dccg.c   |  1 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c |  1 +
 .../gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c |  1 +
 drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h  |  4 +
 5 files changed, 56 insertions(+), 32 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 19ab08f5122e..f2b20319f0bb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -670,6 +670,37 @@ static int calc_mpc_flow_ctrl_cnt(const struct dc_stream_state *stream,
 	return flow_ctrl_cnt;
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
 enum dc_status dcn20_enable_stream_timing(
 		struct pipe_ctx *pipe_ctx,
 		struct dc_state *context,
@@ -817,6 +848,23 @@ enum dc_status dcn20_enable_stream_timing(
 		if (pipe_ctx->stream_res.tg && pipe_ctx->stream_res.tg->funcs->phantom_crtc_post_enable)
 			pipe_ctx->stream_res.tg->funcs->phantom_crtc_post_enable(pipe_ctx->stream_res.tg);
 	}
+
+	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
+		struct dccg *dccg = dc->res_pool->dccg;
+		struct timing_generator *tg = pipe_ctx->stream_res.tg;
+		struct dtbclk_dto_params dto_params = {0};
+
+		if (dccg->funcs->set_dtbclk_p_src)
+			dccg->funcs->set_dtbclk_p_src(dccg, DTBCLK0, tg->inst);
+
+		dto_params.otg_inst = tg->inst;
+		dto_params.pixclk_khz = pipe_ctx->stream->timing.pix_clk_100hz / 10;
+		dto_params.num_odm_segments = get_odm_segment_count(pipe_ctx);
+		dto_params.timing = &pipe_ctx->stream->timing;
+		dto_params.ref_dtbclk_khz = dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(dc->clk_mgr);
+		dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
+	}
+
 	return DC_OK;
 }
 
@@ -2659,37 +2707,6 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	hubp->mpcc_id = mpcc_id;
 }
 
-static enum phyd32clk_clock_source get_phyd32clk_src(struct dc_link *link)
-{
-	switch (link->link_enc->transmitter) {
-	case TRANSMITTER_UNIPHY_A:
-		return PHYD32CLKA;
-	case TRANSMITTER_UNIPHY_B:
-		return PHYD32CLKB;
-	case TRANSMITTER_UNIPHY_C:
-		return PHYD32CLKC;
-	case TRANSMITTER_UNIPHY_D:
-		return PHYD32CLKD;
-	case TRANSMITTER_UNIPHY_E:
-		return PHYD32CLKE;
-	default:
-		return PHYD32CLKA;
-	}
-}
-
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
 void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 {
 	enum dc_lane_count lane_count =
@@ -2730,7 +2747,7 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 		dto_params.ref_dtbclk_khz = dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(dc->clk_mgr);
 		dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
 	} else {
-		}
+	}
 	if (hws->funcs.calculate_dccg_k1_k2_values && dc->res_pool->dccg->funcs->set_pixel_rate_div) {
 		hws->funcs.calculate_dccg_k1_k2_values(pipe_ctx, &k1_div, &k2_div);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
index 173837bbc941..17a1174b8d80 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_dccg.c
@@ -375,6 +375,7 @@ static const struct dccg_funcs dccg314_funcs = {
 	.set_pixel_rate_div = dccg314_set_pixel_rate_div,
 	.trigger_dio_fifo_resync = dccg314_trigger_dio_fifo_resync,
 	.set_valid_pixel_rate = dccg314_set_valid_pixel_rate,
+	.set_dtbclk_p_src = dccg314_set_dtbclk_p_src
 };
 
 struct dccg *dccg314_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
index 921f58c0c729..036d05468d76 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_dccg.c
@@ -345,6 +345,7 @@ static const struct dccg_funcs dccg32_funcs = {
 	.otg_drop_pixel = dccg32_otg_drop_pixel,
 	.set_pixel_rate_div = dccg32_set_pixel_rate_div,
 	.trigger_dio_fifo_resync = dccg32_trigger_dio_fifo_resync,
+	.set_dtbclk_p_src = dccg32_set_dtbclk_p_src,
 };
 
 struct dccg *dccg32_create(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
index 22137fde62bd..addedcfd1238 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn35/dcn35_dccg.c
@@ -767,6 +767,7 @@ static const struct dccg_funcs dccg35_funcs = {
 	.set_valid_pixel_rate = dccg35_set_valid_pixel_rate,
 	.enable_symclk_se = dccg35_enable_symclk_se,
 	.disable_symclk_se = dccg35_disable_symclk_se,
+	.set_dtbclk_p_src = dccg35_set_dtbclk_p_src,
 };
 
 struct dccg *dccg35_create(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
index 65bb7cd05385..13f12f2a3f81 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/dccg.h
@@ -192,6 +192,10 @@ struct dccg_funcs {
 	void (*set_dp_dto)(
 			struct dccg *dccg,
 			const struct dp_dto_params *params);
+	void (*set_dtbclk_p_src)(
+			struct dccg *dccg,
+			enum streamclk_source src,
+			uint32_t otg_inst);
 };
 
 #endif //__DAL_DCCG_H__
-- 
2.37.3


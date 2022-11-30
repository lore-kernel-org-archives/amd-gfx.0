Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B85DC4321E
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Nov 2022 06:39:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC5EE10E28E;
	Wed, 30 Nov 2022 06:39:18 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2062c.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:fe5a::62c])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1488410E28A
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Nov 2022 06:39:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mURNj1Qe6lorPtQKWS3mVvTDF+yOWsxVj/3vZFjdsLxVBcytCKWnpfkVhMCxyJBstiU1AQOT5raq6G+MDUnT9QaF3S3iTXeKQLRkGzSRZxL6WrgvPSg3v7erI+8pSYVXBodzNR+grLBrPtFkQ4oWZzxV6Bsu4XwN3Qacg0GIkm2WTiJ5R3llGqhCicF4JLLyIbiI2oWnMqxSkvYkyzuuHvzKOzBj6yWEDmFo7iryYZ3Lw8jnb5eeqgDKRJ4/kllKGq1yJO27F8ce3ydfHCzP6AsgU7i9rDNgqev4/d7ukRrSnIymkoJKrknXV61djbwWu2WHbmldbm/QNCcs4DhDHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WNIufdipmY8Yarrfby5nzO1lwA4OaA4K0p3IyR2Blwc=;
 b=Yj3CaTbzJAxlO75l1g2CRL2f3hqttbJKu91owFFG7nlUSzL29J0N8FUixLWbYaNzGpLpv6v9GI7q5t9V+jfrr/K47QeVJekOWrGP46ebSCdE2CxWkgqglMUTiVXazFRGKoXltRCzNMW24J4ilETZtqyPZF1h6LFHfOic7kp81/2JgzDqKwGddqVXt96pdQawkJqDkEFRJeQnmH+n5BcqVUhnI1eCCdUI+/Vac/W0ajbE8XLEZw5AZAeVCTtJ3y0pQtSJuE9s61pwtv8Fim8adXxkzYtuvt07K0IEV9xAE3RGqcX98DBcPeOACeOAVIFGWAFEFPxtpYff/rHuNcY/QA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WNIufdipmY8Yarrfby5nzO1lwA4OaA4K0p3IyR2Blwc=;
 b=iZsuXTn5MemNGbM8uAw4BLjF1CpCwTiEqZbl5LMLgeOj/bU9YiekEe0IHfWSLPRKHE1nytbFyjnyFy3m7FYz5vHeZ17+jYHU3PrOabneG8fqxNGBsrJIMZ5+Ej6Q5EXdKTD2eeGWuWeX9N9FIztgajNq1Qcew5hs4Wg6HbrkljA=
Received: from MW4PR04CA0108.namprd04.prod.outlook.com (2603:10b6:303:83::23)
 by MW3PR12MB4395.namprd12.prod.outlook.com (2603:10b6:303:5c::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23; Wed, 30 Nov
 2022 06:39:10 +0000
Received: from CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:83:cafe::26) by MW4PR04CA0108.outlook.office365.com
 (2603:10b6:303:83::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.23 via Frontend
 Transport; Wed, 30 Nov 2022 06:39:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT027.mail.protection.outlook.com (10.13.174.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5880.8 via Frontend Transport; Wed, 30 Nov 2022 06:39:10 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 30 Nov
 2022 00:39:06 -0600
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/14] drm/amd/display: Remove DTB DTO on CLK update
Date: Wed, 30 Nov 2022 14:36:14 +0800
Message-ID: <20221130063627.2398341-2-stylon.wang@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221130063627.2398341-1-stylon.wang@amd.com>
References: <20221130063627.2398341-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT027:EE_|MW3PR12MB4395:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7ad22d-d6bc-4135-0471-08dad29d96c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tNkRp5mUdBuQ2zP6Y+IraZK7ijQ+M8yFkM/tWmLLssoMx8mGB9Plfldun2mRjEf7R3YBmbCnv+OPvBJMv2yEc27zyiciAAUvFg8rxxsXzakd3zG+tnCmUvLA8+26jQpBlE2IosQxbPeiwJTaPGNpR1K7YCgjix16RYL19I7K7qTTnHc8mqWzvTjcbqo83Bk6BpbLo6HzJbeWfNgkQuOa8nBwFAaLqxK5lCLvu+tOyms2IpyS8aYpOEVIg6VldcyalUBkkYWJ6VzftOcdKceC0O95003RNpCl0EY+sZZMV4nfm+KJMeVdIBcfn++H9l7eCupvYwyf6AZ3SAnfCGaTImJHdVBweaqs91rNIrwxjmz68V0q5TMjdkijNSkcQd3RQc3NMsL/p3z1YOjIu0JR3qHdLXhaKDqSxPIy6FrN/oco18lXFAkDq9oWs2h/JTLbbQDgmvHduI9f0n26p8vl4T0E1JafCu2G35CtQBrpU+Y7L5gaDk4gFks+UqgjPB89kdK95XBCJ17a0RkGHYLIKwo09/CER+TO4V3nq5eLE4OhrZrSy0i6/DmobX5lWzPVHn46f4GPAaF1m6TvfFEIZ6RPCP15zXmbP/PR3BabObBL+EiC0UNrHAWSNCbkiYosWTe1+WKjJKFjuWWY8rUDVjEWVKbfzt0OcJHFYHLFq8wmNaOov72UcMmARXLD/wGvHcjb3/Of10Kd5Jcl5EzzpY0TsFTVe3MM72ojkO7J74g=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(396003)(376002)(136003)(39860400002)(451199015)(46966006)(40470700004)(36840700001)(8936002)(5660300002)(70586007)(36756003)(54906003)(186003)(6916009)(16526019)(36860700001)(41300700001)(70206006)(4326008)(316002)(81166007)(8676002)(40460700003)(356005)(426003)(40480700001)(47076005)(82740400003)(83380400001)(2616005)(82310400005)(26005)(86362001)(478600001)(7696005)(336012)(1076003)(6666004)(2906002)(15650500001)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2022 06:39:10.6017 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7ad22d-d6bc-4135-0471-08dad29d96c8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4395
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
Cc: stylon.wang@amd.com, Chris Park <Chris.Park@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Jasdeep Dhillon <jdhillon@amd.com>, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Chris Park <Chris.Park@amd.com>

[Why]
DTB DTO is programmed more correctly during
link enable.  Programming them on CLK update
which may arrive frequently and sporadically
per flip throws off DTB DTO.

[How]
Remove DTB DTO programming on clock update.

Reviewed-by: Alvin Lee <Alvin.Lee2@amd.com>
Acked-by: Jasdeep Dhillon <jdhillon@amd.com>
Signed-off-by: Chris Park <Chris.Park@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 37 -------------------
 .../amd/display/dc/dcn321/dcn321_resource.c   |  2 +-
 2 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 9eb9fe5b8d2c..200fcec19186 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -233,41 +233,6 @@ void dcn32_init_clocks(struct clk_mgr *clk_mgr_base)
 	DC_FP_END();
 }
 
-static void dcn32_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr,
-			struct dc_state *context,
-			int ref_dtbclk_khz)
-{
-	struct dccg *dccg = clk_mgr->dccg;
-	uint32_t tg_mask = 0;
-	int i;
-
-	for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-		struct dtbclk_dto_params dto_params = {0};
-
-		/* use mask to program DTO once per tg */
-		if (pipe_ctx->stream_res.tg &&
-				!(tg_mask & (1 << pipe_ctx->stream_res.tg->inst))) {
-			tg_mask |= (1 << pipe_ctx->stream_res.tg->inst);
-
-			dto_params.otg_inst = pipe_ctx->stream_res.tg->inst;
-			dto_params.ref_dtbclk_khz = ref_dtbclk_khz;
-
-			if (is_dp_128b_132b_signal(pipe_ctx)) {
-				dto_params.pixclk_khz = pipe_ctx->stream->phy_pix_clk;
-
-				if (pipe_ctx->stream_res.audio != NULL)
-					dto_params.req_audio_dtbclk_khz = 24000;
-			}
-			if (dc_is_hdmi_signal(pipe_ctx->stream->signal))
-				dto_params.is_hdmi = true;
-
-			dccg->funcs->set_dtbclk_dto(clk_mgr->dccg, &dto_params);
-			//dccg->funcs->set_audio_dtbclk_dto(clk_mgr->dccg, &dto_params);
-		}
-	}
-}
-
 /* Since DPPCLK request to PMFW needs to be exact (due to DPP DTO programming),
  * update DPPCLK to be the exact frequency that will be set after the DPPCLK
  * divider is updated. This will prevent rounding issues that could cause DPP
@@ -447,8 +412,6 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 		/* DCCG requires KHz precision for DTBCLK */
 		clk_mgr_base->clks.ref_dtbclk_khz =
 				dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DTBCLK, khz_to_mhz_ceil(new_clocks->ref_dtbclk_khz));
-
-		dcn32_update_clocks_update_dtb_dto(clk_mgr, context, clk_mgr_base->clks.ref_dtbclk_khz);
 	}
 
 	if (dc->config.forced_clocks == false || (force_reset && safe_to_lower)) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
index 3406e7735357..d1f36df03c2e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn321/dcn321_resource.c
@@ -743,7 +743,7 @@ static const struct dc_debug_options debug_defaults_diags = {
 	.dmub_command_table = true,
 	.enable_tri_buf = true,
 	.use_max_lb = true,
-	.force_disable_subvp = true
+	.force_disable_subvp = true,
 };
 
 
-- 
2.25.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A53F8C54EBC
	for <amd-gfx@archiver.kernel.org>; Tue, 10 Jan 2023 16:58:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BD6C10E61F;
	Tue, 10 Jan 2023 16:58:56 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DFB510E61D
 for <amd-gfx@lists.freedesktop.org>; Tue, 10 Jan 2023 16:58:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ltrtfpniYo5teri1z+nOxfoBjhVNAokvbTX2LnNvQQoqcpSKEhDSqu+KCF66jvhuJhWQXJ3zFgHEue87JPDpzC8+6HJTrEmhYSaXyuv8Re4lItp2D1Z+3ahAjSRESsPSTFDyr7RHS17JkYM+4tqfLBZAu/VpYGFS+dIO2E9HEneL8uVQ4Hh5uN3P2iqp3FVlC1C3AuM9RuAQD2vw4nB8/SqAMdJrtFIkyfA21j7pQaJpF9g/I01HV3Qs8QCTGCEz4dBASwqMHoFrf/e7XlMPKx3ZBqCkAr2m2hw3r2Rf6tAyVRYZmHUzCSAwk61NrbNpekRPCQFgaM9P9i1PUIKPQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vN9++vOy95c/w9qFDiB3PGjsSkAcBHJELRSHo7E4srI=;
 b=TB4ayQ9oGYSGDmgG1uSZoDqdidJt6k5CZb10l30sPyRb5JqPhiTlSjLcA0FF+XmC5TCt4qC26UrXzd3b1dYSpcBNRvPeJRd9HhPVjJr1RI4P+aznYKiXEXWB5A0fBEwTSF5zZ7Bur/UCUEmxOhcm5AQ5jHZHr9BukQPZ5Pn6oOjQXVsA1lH4TqHfUh4gPpFdzZKU95qIX8wqum/W6GSW8ZN0gV+RkHBHvGf21p6UeQiOAI39JPsqev8K/DBsiI9yPydkT2XvKe38epCq7qEyfnypxP/r2nyq9Aq0Yerj7NLTgFkBrQMNae9goDyp4qVwuY7x8Avqnz5iZlegbLdiGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vN9++vOy95c/w9qFDiB3PGjsSkAcBHJELRSHo7E4srI=;
 b=ZWLKEH1qGsn73pr+fOUpCrp1rhx9zaxITAEj1l4LsoxKgTr8P3bIXwh1j/z0nKKOauo3HEF3J0wMxrHX79T8TOXV+TtlzsW4d3ZLUnPR2NhS8EXlh/GSRTixAgHOqWgzw6xjLbRt+R4mE1Lh8q272RD03AIceZhQucpS9PydO9A=
Received: from MW4PR03CA0029.namprd03.prod.outlook.com (2603:10b6:303:8f::34)
 by PH7PR12MB7986.namprd12.prod.outlook.com (2603:10b6:510:27d::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Tue, 10 Jan
 2023 16:58:51 +0000
Received: from CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8f:cafe::8) by MW4PR03CA0029.outlook.office365.com
 (2603:10b6:303:8f::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12 via Frontend
 Transport; Tue, 10 Jan 2023 16:58:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT091.mail.protection.outlook.com (10.13.175.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6002.12 via Frontend Transport; Tue, 10 Jan 2023 16:58:51 +0000
Received: from atma-again.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 10:58:29 -0600
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 28/37] drm/amd/display: Remove DISPCLK dentist programming for
 dcn32
Date: Tue, 10 Jan 2023 11:55:26 -0500
Message-ID: <20230110165535.3358492-29-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
References: <20230110165535.3358492-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT091:EE_|PH7PR12MB7986:EE_
X-MS-Office365-Filtering-Correlation-Id: 66c3e9be-22be-4831-93fe-08daf32bf32b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uct6bQ2QmXkFyEEiljNXr7fYXt85A6rYA1jqSIFT+Pt+LE7t495Cr78F5e6TMhWYqBnmUTr0VPF6LaPnlMzaprppws0uYPzPzboguevmCONeeRSANmto87QcUgDUO+bBfZmtWFQUksExdQCRLcjP3Eh5Ai7rzxv9PFCKX+T9HpOWlTuKmgV7w5zGbQX1wF9JXRTHDJEh8Yya8ZAvj8HqmU6oYfTx81xZFXC5mI0s4TwjAfwm9z4EM3+sg8BLaBKV2xhPEvwu3jLMhm17uukOBdEzvzcWTd9OaqiRZ6uyQByEF3kgXRofo6Tz+36t8zpkpPgEPDpW8nsxQHkvUh9VlS1uo/PEiO+UN2LrFQGu1KZp8Mtba6FjjH1SXElt28cRbXsMjXAn5zZ6jasBX/KKMkCUedU49BOZBCoIk+124aRrvhODWDencsUl/lOLw1o70j3moQTVWuiDi47jhwOkYG0ba0AhMSAVbzpsIaE8qcFuAQ1teSeVIUxX6fDyMjO9LwkJ8T0TrV+ln0R8kQwyqoiC/RNMXVIsoB9duVAXcUnNKxJrRQZO9LfYhqPUTlx6vXtcJhaetwm2O3VvML/Rn104FzIS6Vyd7WDj5Sbr9eumd/xoaizH5gxrr66iAZrJo599g2No/MQUijA7IW8MNl9GbSy1BGWBT0w3cfHQpmdT4CPgCgq6QEKz3aAnwuK80lnEHzWxG5lZEMZjHNIjpUU9M3ErBGojDvNKP5tcqFU=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(39860400002)(451199015)(46966006)(36840700001)(40470700004)(16526019)(54906003)(186003)(40480700001)(2616005)(82310400005)(1076003)(336012)(6666004)(40460700003)(82740400003)(8676002)(86362001)(4326008)(47076005)(70206006)(70586007)(5660300002)(426003)(478600001)(36756003)(6916009)(2906002)(26005)(316002)(356005)(81166007)(8936002)(41300700001)(36860700001)(7696005)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2023 16:58:51.3646 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 66c3e9be-22be-4831-93fe-08daf32bf32b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT091.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7986
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
Cc: stylon.wang@amd.com, Aric Cyr <Aric.Cyr@amd.com>,
 Dillon Varone <Dillon.Varone@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Dillon Varone <Dillon.Varone@amd.com>

[WHY?]
For dcn32, SMU handles DISPCLK dentist programming.

[HOW?]
Only use calls to SMU to set DISPCLK.

Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Dillon Varone <Dillon.Varone@amd.com>
---
 .../display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c  | 96 ++++++++++++++++++-
 1 file changed, 91 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
index 791a788c52f2..352c977d1495 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn32/dcn32_clk_mgr.c
@@ -256,6 +256,94 @@ static void dcn32_update_dppclk_dispclk_freq(struct clk_mgr_internal *clk_mgr, s
 	}
 }
 
+static void dcn32_update_clocks_update_dentist(
+		struct clk_mgr_internal *clk_mgr,
+		struct dc_state *context,
+		uint32_t old_dispclk_khz)
+{
+	uint32_t new_disp_divider = 0;
+	uint32_t old_disp_divider = 0;
+	uint32_t new_dispclk_wdivider = 0;
+	uint32_t old_dispclk_wdivider = 0;
+	uint32_t i;
+
+	if (old_dispclk_khz == 0 || clk_mgr->base.clks.dispclk_khz == 0)
+		return;
+
+	new_disp_divider = DENTIST_DIVIDER_RANGE_SCALE_FACTOR
+			* clk_mgr->base.dentist_vco_freq_khz / clk_mgr->base.clks.dispclk_khz;
+	old_disp_divider = DENTIST_DIVIDER_RANGE_SCALE_FACTOR
+			* clk_mgr->base.dentist_vco_freq_khz / old_dispclk_khz;
+
+	new_dispclk_wdivider = dentist_get_did_from_divider(new_disp_divider);
+	old_dispclk_wdivider = dentist_get_did_from_divider(old_disp_divider);
+
+	/* When changing divider to or from 127, some extra programming is required to prevent corruption */
+	if (old_dispclk_wdivider == 127 && new_dispclk_wdivider != 127) {
+		for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+			uint32_t fifo_level;
+			struct dccg *dccg = clk_mgr->base.ctx->dc->res_pool->dccg;
+			struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
+			int32_t N;
+			int32_t j;
+
+			if (!pipe_ctx->stream)
+				continue;
+			/* Virtual encoders don't have this function */
+			if (!stream_enc->funcs->get_fifo_cal_average_level)
+				continue;
+			fifo_level = stream_enc->funcs->get_fifo_cal_average_level(
+					stream_enc);
+			N = fifo_level / 4;
+			dccg->funcs->set_fifo_errdet_ovr_en(
+					dccg,
+					true);
+			for (j = 0; j < N - 4; j++)
+				dccg->funcs->otg_drop_pixel(
+						dccg,
+						pipe_ctx->stream_res.tg->inst);
+			dccg->funcs->set_fifo_errdet_ovr_en(
+					dccg,
+					false);
+		}
+	} else if (new_dispclk_wdivider == 127 && old_dispclk_wdivider != 127) {
+		/* request clock with 126 divider first */
+		uint32_t temp_disp_divider = dentist_get_divider_from_did(126);
+		uint32_t temp_dispclk_khz = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR * clk_mgr->base.dentist_vco_freq_khz) / temp_disp_divider;
+
+		if (clk_mgr->smu_present)
+			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DISPCLK, khz_to_mhz_ceil(temp_dispclk_khz));
+
+		for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+			struct dccg *dccg = clk_mgr->base.ctx->dc->res_pool->dccg;
+			struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
+			uint32_t fifo_level;
+			int32_t N;
+			int32_t j;
+
+			if (!pipe_ctx->stream)
+				continue;
+			/* Virtual encoders don't have this function */
+			if (!stream_enc->funcs->get_fifo_cal_average_level)
+				continue;
+			fifo_level = stream_enc->funcs->get_fifo_cal_average_level(
+					stream_enc);
+			N = fifo_level / 4;
+			dccg->funcs->set_fifo_errdet_ovr_en(dccg, true);
+			for (j = 0; j < 12 - N; j++)
+				dccg->funcs->otg_add_pixel(dccg,
+						pipe_ctx->stream_res.tg->inst);
+			dccg->funcs->set_fifo_errdet_ovr_en(dccg, false);
+		}
+	}
+
+	/* do requested DISPCLK updates*/
+	if (clk_mgr->smu_present)
+		dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DISPCLK, khz_to_mhz_ceil(clk_mgr->base.clks.dispclk_khz));
+}
+
 static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 			struct dc_state *context,
 			bool safe_to_lower)
@@ -274,6 +362,7 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 	bool p_state_change_support;
 	bool fclk_p_state_change_support;
 	int total_plane_count;
+	int old_dispclk_khz = clk_mgr_base->clks.dispclk_khz;
 
 	if (dc->work_arounds.skip_clock_update)
 		return;
@@ -397,9 +486,6 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
 
-		if (clk_mgr->smu_present)
-			dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DISPCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dispclk_khz));
-
 		update_dispclk = true;
 	}
 
@@ -419,13 +505,13 @@ static void dcn32_update_clocks(struct clk_mgr *clk_mgr_base,
 		if (dpp_clock_lowered) {
 			/* if clock is being lowered, increase DTO before lowering refclk */
 			dcn20_update_clocks_update_dpp_dto(clk_mgr, context, safe_to_lower);
-			dcn20_update_clocks_update_dentist(clk_mgr, context);
+			dcn32_update_clocks_update_dentist(clk_mgr, context, old_dispclk_khz);
 			if (clk_mgr->smu_present)
 				dcn32_smu_set_hard_min_by_freq(clk_mgr, PPCLK_DPPCLK, khz_to_mhz_ceil(clk_mgr_base->clks.dppclk_khz));
 		} else {
 			/* if clock is being raised, increase refclk before lowering DTO */
 			if (update_dppclk || update_dispclk)
-				dcn20_update_clocks_update_dentist(clk_mgr, context);
+				dcn32_update_clocks_update_dentist(clk_mgr, context, old_dispclk_khz);
 			/* There is a check inside dcn20_update_clocks_update_dpp_dto which ensures
 			 * that we do not lower dto when it is not safe to lower. We do not need to
 			 * compare the current and new dppclk before calling this function.
-- 
2.39.0


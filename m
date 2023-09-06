Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31194EB8FCD
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:51:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C213910E644;
	Wed,  6 Sep 2023 12:51:56 +0000 (UTC)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B17CE10E643
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:51:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQiYc4Lt0T6sYdWUfCoQT8wC8TzlfLA3m/xg59pyDAAoXySG3/oHyQu0FUy35XV+bOmkcqyCLlCqAghyG9W7SnVGUFp3P80oIVSG6vLbAga2BnikJv0tgD6CU4KSbmPBsJf1/QAGTiytQskuoUdrQvydVnuRVy9o0la8mwBtpG/75NcR+7Cnv4Y89lKHo6/nwF83UBNmCjTnWyHrnMotW6qeXUkI2olgdlHwRfxxUZjbR6EqelCgCWIXQnKsvl5juFClO3NEvciZ6ZVKtyRyeV9Di0diMCjG5rhb6kp6ffOGHF/VcyJZP7KIBID4qRpeO11WM4piqbKcgMm+tp4Vqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZMIID4+90z9sIvcvIRUaHrZvHqkKRL/yI0I0JKrB8+w=;
 b=YPRj6Ix7R3k7atdwlwKUbLwFjqQ6NQyJ6jrmtthjVDDYLRhluc5tJ5N4zfBZ0UUDAlZXyYbZSgJV/L9voN5sz1U98WqoxBH6ZKrW1vsZF3HmKa+3HRFnrhq9bZNniGhsyiPXMY/7teAE+pY+fpwzHpdZB4y6usTe0XxKeAtCluq2u/h/PqbGdfItqxPVky4fU8NGeMJXPBeGW4fc08G5vZa9P93kOhp2b5lBF2oMKpl30l+u5HImiU76IJU/IcSmVBxYs7OunXmdwglL7xqZoy7K3DSkeuBguETwOFq5JruEoIgLcP1YCCztjrOURN9upKRZnTrpWEmw7Y38bvysEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZMIID4+90z9sIvcvIRUaHrZvHqkKRL/yI0I0JKrB8+w=;
 b=u0i4LZA3ymGmxpa+olHeqsjDsbACwpNm5gbfSDOl+56Xk4RG85SJesqSn4LO2Yn60m6hc0rhBIP2jX7c/heUiwhNRLwNawfvXaV9ctefObGQGJAQawAa2MTd+IVtKtw6wh+gdpvAUJK2hkCRcjBoJuYV0A7jrKVIWSaPPYIWmXA=
Received: from BLAPR03CA0043.namprd03.prod.outlook.com (2603:10b6:208:32d::18)
 by DM6PR12MB4976.namprd12.prod.outlook.com (2603:10b6:5:1ba::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 12:51:52 +0000
Received: from BL02EPF0001A101.namprd05.prod.outlook.com
 (2603:10b6:208:32d:cafe::9) by BLAPR03CA0043.outlook.office365.com
 (2603:10b6:208:32d::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34 via Frontend
 Transport; Wed, 6 Sep 2023 12:51:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A101.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:51:52 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:51:47 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/28] drm/amd/display: Fix MST recognizes connected displays
 as one
Date: Wed, 6 Sep 2023 20:28:27 +0800
Message-ID: <20230906124915.586250-23-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906124915.586250-1-stylon.wang@amd.com>
References: <20230906124915.586250-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A101:EE_|DM6PR12MB4976:EE_
X-MS-Office365-Filtering-Correlation-Id: d6326a44-0894-4504-f6e3-08dbaed80b0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F8ey3BlKC6GoUQokx6DssddjeTwbIS2r/Vc9lDKMoWQfzhBYqsuLc5Ro7s93Jmy/E1fJsBU798fsuHXxw4eSaUwffwHao5P7xExFuDwKZv2NnEZZH/21dVilZ0w87ZG/5TW+0Qhn7o1PtTf+FqG5CxZuPUu88b17ywpyVhp6sJR6UbdMfmUz7yx1mwc+W/hqwy7BvWf7Tvf7YebVFK8RcayTGoDwNCyI2XliiHOKS+OpXW6OMFIDh5oRAydUkFCW369iuPXqNUTqTI926pji4hrFWWgd3iLIS022mI7+3n/WpEgw3GL4wWzhDLqapXuQm9QHGl9SD8YW2NRmUsrKfFNCMB9V29POdOrsRPAkOZnDQyykx5AmUzJfq37w7Ixw82D8v/0/5RfY2YU0FrWcfCLQSjVnPeb5QKwFMEEDMn4Y2HXpReIOEgVuI1NG18wV53AgmMO54FHqkhhD7r6stse1SSfD0xdGn9UW/vSReEWHQAOZwEJ1iqk2r+sZvP+hiPhn1l96HjjFYocvwRbkoj8yRrgnAB6APH/Z6GjpDW0O2rAy5WNe/5nLAh4/SYCMXTaUbALNySFdirr8xZ+p126JVsn9Bh2eVvo3tZsgT4GqGD4Ku5ERjaUjmlVR0+fA0fA9bNwYcoodZS82tvcB8i91fjICsDn+ft87+oTvCnGYDZQkS2Exf/CPmLas9EUfcYfZeLVJdlSuDgDjFb+TnZ5ekrJXDC7D719f2OpiqzbLs2X9PR0fpFKhM3SaN5EvmW4Nz1g6hPB6KEjidUisIQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(451199024)(1800799009)(186009)(82310400011)(46966006)(40470700004)(36840700001)(356005)(81166007)(82740400003)(6666004)(7696005)(36756003)(40460700003)(86362001)(36860700001)(40480700001)(47076005)(2616005)(2906002)(1076003)(316002)(336012)(426003)(26005)(16526019)(83380400001)(478600001)(70206006)(70586007)(8936002)(4326008)(8676002)(5660300002)(6916009)(44832011)(41300700001)(54906003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:51:52.4221 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d6326a44-0894-4504-f6e3-08dbaed80b0d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A101.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4976
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
Cc: stylon.wang@amd.com, Charlene Liu <charlene.liu@amd.com>,
 Muhammad Ahmed <ahmed.ahmed@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, Aurabindo.Pillai@amd.com,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Muhammad Ahmed <ahmed.ahmed@amd.com>

[What]
MST now recognizes both connected displays

Reviewed-by: Charlene Liu <charlene.liu@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Muhammad Ahmed <ahmed.ahmed@amd.com>
---
 .../display/dc/dce110/dce110_hw_sequencer.c   | 30 +++++++++++--------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  8 ++---
 .../gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c  |  2 +-
 3 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 31454db00ed5..2701620350af 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1178,12 +1178,15 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 		dto_params.otg_inst = tg->inst;
 		dto_params.timing = &pipe_ctx->stream->timing;
 		dp_hpo_inst = pipe_ctx->stream_res.hpo_dp_stream_enc->inst;
-		dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
-		dccg->funcs->disable_symclk32_se(dccg, dp_hpo_inst);
-		dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst, dp_hpo_inst);
-	} else if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST && dccg->funcs->disable_symclk_se)
+		if (dccg) {
+			dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
+			dccg->funcs->disable_symclk32_se(dccg, dp_hpo_inst);
+			dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst, dp_hpo_inst);
+		}
+	} else if (dccg && dccg->funcs->disable_symclk_se) {
 		dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_enc_inst,
 				link_enc->transmitter - TRANSMITTER_UNIPHY_A);
+	}
 
 	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
 		/* TODO: This looks like a bug to me as we are disabling HPO IO when
@@ -2655,11 +2658,11 @@ void dce110_prepare_bandwidth(
 	struct clk_mgr *dccg = dc->clk_mgr;
 
 	dce110_set_safe_displaymarks(&context->res_ctx, dc->res_pool);
-
-	dccg->funcs->update_clocks(
-			dccg,
-			context,
-			false);
+	if (dccg)
+		dccg->funcs->update_clocks(
+				dccg,
+				context,
+				false);
 }
 
 void dce110_optimize_bandwidth(
@@ -2670,10 +2673,11 @@ void dce110_optimize_bandwidth(
 
 	dce110_set_displaymarks(dc, context);
 
-	dccg->funcs->update_clocks(
-			dccg,
-			context,
-			true);
+	if (dccg)
+		dccg->funcs->update_clocks(
+				dccg,
+				context,
+				true);
 }
 
 static void dce110_program_front_end_for_pipe(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 37cab11d1b31..19ab08f5122e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2710,8 +2710,6 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 	struct dce_hwseq *hws = dc->hwseq;
 	unsigned int k1_div = PIXEL_RATE_DIV_NA;
 	unsigned int k2_div = PIXEL_RATE_DIV_NA;
-	struct link_encoder *link_enc = link_enc_cfg_get_link_enc(pipe_ctx->stream->link);
-	struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
 
 	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
 		if (dc->hwseq->funcs.setup_hpo_hw_control)
@@ -2731,10 +2729,8 @@ void dcn20_enable_stream(struct pipe_ctx *pipe_ctx)
 		dto_params.timing = &pipe_ctx->stream->timing;
 		dto_params.ref_dtbclk_khz = dc->clk_mgr->funcs->get_dtb_ref_clk_frequency(dc->clk_mgr);
 		dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
-	} else if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST && dccg->funcs->enable_symclk_se)
-		dccg->funcs->enable_symclk_se(dccg,
-			stream_enc->stream_enc_inst, link_enc->transmitter - TRANSMITTER_UNIPHY_A);
-
+	} else {
+		}
 	if (hws->funcs.calculate_dccg_k1_k2_values && dc->res_pool->dccg->funcs->set_pixel_rate_div) {
 		hws->funcs.calculate_dccg_k1_k2_values(pipe_ctx, &k1_div, &k2_div);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
index 3082da04a63d..1d052f08aff5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_mpc.c
@@ -75,7 +75,7 @@ void mpc32_power_on_blnd_lut(
 		if (power_on) {
 			REG_UPDATE(MPCC_MCM_MEM_PWR_CTRL[mpcc_id], MPCC_MCM_1DLUT_MEM_PWR_FORCE, 0);
 			REG_WAIT(MPCC_MCM_MEM_PWR_CTRL[mpcc_id], MPCC_MCM_1DLUT_MEM_PWR_STATE, 0, 1, 5);
-		} else {
+		} else if (!mpc->ctx->dc->debug.disable_mem_low_power) {
 			ASSERT(false);
 			/* TODO: change to mpc
 			 *  dpp_base->ctx->dc->optimized_required = true;
-- 
2.42.0


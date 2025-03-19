Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E5CFC35FFA
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Mar 2025 17:57:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3890610E336;
	Wed, 19 Mar 2025 17:57:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PE8oRETx";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2068.outbound.protection.outlook.com [40.107.223.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6EC0510E278
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Mar 2025 17:57:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TD5byqJ+AcpJyTtNJ5hkWFXeOHBRXU1Q60YTYPbJoypKnvqz2t1WBbBQDYIjQOp2A2ppE0bVCfgphu25r5+8keRYfODPJBwmuXE3eXIsMSlKKOD2QG2l+voOPGtc49XYwRqGtbQn61NqnKWn8AODk0hCpbQJN0bUz1Re6e2BsEth7Gw4V2dJ3vYuEJD9krjebTxbKN4+/3hmZOpqcnuNC5sUovoRdNWOwG9aBiEWqVvauK0uc5/NEIVVPbcMVrWJwyuQbJNEF3D5RtLNZr9ONnYYZtmFdERNUn8ADzS7RxWs9IUo88wD42G1Fbt+pexoRVFxiQDxpMFME8XSz8wVEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K/heDzAs+EWNkb8s8qY1fWbdsKybDMrOR3i7Kkndib0=;
 b=X74jg6L8znSvs1XXvCTU2WK7ZBlsKb2WNihcZ+Wg8U10Tm3Gq6urmbY3ldoOeRMYyvS6fXAPjrXw3pk5suaO384MEmyrpN3H/0jbDWAEkVDaB3XNbgM1IFtmOVhIUTIp/r/z7opmA9gFV+66gLcCk3zcO/3EsdI3HjRcxklARktDBP91YMB/s2w8S9FZvQ8+jKIfDvb7kVYFrhvM3H6dMxt1pmxm1Km/C5CMjfvWusG6uCPTSAFdBR+NueLzD+PXQL+dgQ4R7cUi0yxZLiKpzeOuatf4WX0ulTzeHBG/Pw5Ulr552aI9ekKHUJb9BAYVaGVj4ytl0Hh0MypUnuveSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/heDzAs+EWNkb8s8qY1fWbdsKybDMrOR3i7Kkndib0=;
 b=PE8oRETx8bBdAbTBZmkq0+1yY9/y/rPS9dLp/4AdfqWt+HROuLYmk6+tpcsTjGAmYID9GC6S0gdjUFi1Nn2+cyl3tukbRTGo18E/D9YPzPPjR/HhK3OkqdYbfZHVUYg5G1vUjhf4gJed7K/zhIUrEuB2Uoqpix67QhBqI6Sj5Dw=
Received: from BY5PR16CA0028.namprd16.prod.outlook.com (2603:10b6:a03:1a0::41)
 by DS5PPFEC0C6BDA1.namprd12.prod.outlook.com (2603:10b6:f:fc00::668)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Wed, 19 Mar
 2025 17:57:28 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:a03:1a0:cafe::d2) by BY5PR16CA0028.outlook.office365.com
 (2603:10b6:a03:1a0::41) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.33 via Frontend Transport; Wed,
 19 Mar 2025 17:57:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8583.3 via Frontend Transport; Wed, 19 Mar 2025 17:57:27 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:26 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Mar
 2025 12:57:25 -0500
Received: from aaurabin-z5-cachy.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39
 via Frontend Transport; Wed, 19 Mar 2025 12:57:25 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, Solomon Chiu
 <solomon.chiu@amd.com>, Daniel Wheeler <daniel.wheeler@amd.com>, Alex Hung
 <alex.hung@amd.com>, Ausef Yousof <Ausef.Yousof@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 10/16] drm/amd/display: Enable pipe update pending wait
Date: Wed, 19 Mar 2025 13:55:15 -0400
Message-ID: <20250319175718.2578234-11-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
References: <20250319175718.2578234-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|DS5PPFEC0C6BDA1:EE_
X-MS-Office365-Filtering-Correlation-Id: 597201ac-f48d-4f95-44c6-08dd670f82d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dHiFeXLTO97WQ+WJDVTWpYw+eFN9q7OE4AayHw2/vliet2YzX9x/hFPWQi+n?=
 =?us-ascii?Q?sBBZUGIbbAwa+ck+vDxbkR1m40eJr3m+V1VxmP/2WOU7hi+P2BhhxJcXLsvr?=
 =?us-ascii?Q?j8GnHkSuuphwLqhiOIMm6tt2FnOnViE2W8cXYVUjYOVOU1WTF7j3JKP94GwF?=
 =?us-ascii?Q?IvnqC54PC809oT2B7bCPfdhN26am8D8j+HcKULg+XnVcaRR65z4Hj3mVbJEG?=
 =?us-ascii?Q?LTxoWIzcsi/Rh0KygUVyCH7RJAXU9ponm+QV6kg3sWIPdMzBoN0ZxIo9kw5Q?=
 =?us-ascii?Q?wdjmZ15diYFXFSt9KN30tO16dPEW5+tHvFWKcaVeDHrGpkrkhX1q0tmh1MeE?=
 =?us-ascii?Q?fS5v3x8oenvI5S+kABBEShfoJXuWKOvDt1/eViKL9ZU06dwn1ZrOqQTYpsvd?=
 =?us-ascii?Q?AOL3GGEhvCy3uHjFJU9wAFY4+YgRPcFXOIWRxCdq2ZCgBA7mIATi4CrFCmKU?=
 =?us-ascii?Q?PwkNOY2AEvwZHCgA/yeWJOfCTZMQ0rV3j3uX+QGz24sis0gKM3wRKZvc+G4t?=
 =?us-ascii?Q?5X/q6ktcgSP4UeMJjjF3lmm8xbYYLYDF7LHdpdpu0NXkjsVq606iUjHAMHY7?=
 =?us-ascii?Q?yUvfzCXX/XXTyKpy3X5kUbGv7VmhA/uH7Gwsf1+tMCshxCbe8oIXWGUYxbFJ?=
 =?us-ascii?Q?TCmvsgKRBzRy6JSIlZN98+jBdQFE8xNA31xDtCUwhxpcGPKieHqwPVCSCK4+?=
 =?us-ascii?Q?kdX6WMtOEU6FxDh4LEZXsZuk5h5IlQDVVAIgrPGFwL8OkohiLzhHS6ZmjMZy?=
 =?us-ascii?Q?f5hiIh4L892W5A3elUZl5VZpY8FILne2Q26CUVTYZ1VcFMnekL1tUHSiVmtA?=
 =?us-ascii?Q?k1JXCcRTvmaWGbSaQ3T2jvbKsMrjR62ija4e9r/fHYGD2Bo+81hZWWCj0wsR?=
 =?us-ascii?Q?uFx8G8MCkjwFTpdc1ERLOeiyQGUNKo6Cw7BDbU8py1yamxZ/cS0haqIfd5cy?=
 =?us-ascii?Q?KQ7QJ/dtDV2kkNLfxvMRrgrXznS1Bms6FhkZ/j7679OyOSLZDJwH5A0FwEny?=
 =?us-ascii?Q?GFHLg2vfmftvbKBaq8jZjNO5QnOtPmK88FghnOIXsuWfyJV71Kp2bsxS9Hv0?=
 =?us-ascii?Q?phfpVLGt0TWv5OI9t4shoqFIePNO2riKSZR9wl6RMNd8BxJ8U7lZv3wO+Uxg?=
 =?us-ascii?Q?M4CmfmxoI71Yu4kugl/hJzrzhBEexUuqTMeRXanjmIEgi13jVCscSwAGRL0e?=
 =?us-ascii?Q?urmp9CsfDScHEBKsePhIeD6u3+GrO+TC1bTvUt2dHqrlcskFWIU5brFyFZJK?=
 =?us-ascii?Q?dzz0K1Slphztvv0pN+C4xZBIQOiI6XciMM0VHk0TGQKuC6wGKNFaY/Up+56J?=
 =?us-ascii?Q?4imcIujqtbNoqbEhQeAvb0B4EVtv+onUuN2V7rBtgxexnAoWTLa9zFpoq0kV?=
 =?us-ascii?Q?9c7djppe0g/Sbm9OKyUmj9cHaj3UwMApVbiHyKRnvuHYcKHMq51NaWgkkH8Q?=
 =?us-ascii?Q?KqM6Eois2ompAt2cG2rO53oxLc7NycAC96myfRZrvphCa8MjNwZh2eEoy3zf?=
 =?us-ascii?Q?yEiMqEDGgw8CHAw=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Mar 2025 17:57:27.2101 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 597201ac-f48d-4f95-44c6-08dd670f82d5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFEC0C6BDA1
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

From: Ausef Yousof <Ausef.Yousof@amd.com>

[Why&How]
During consecutive full updates its possible for us to do otg pipe
locking/programming before previous pipe updates have latched (resulting
in single frame corruption/black screen).wait_for_outstanding_updates does
a poll for some bits to clear in HW that tell us that pipe is currently
busy with some update.

Its possible for us to do this poll during dpms off, which means our
dtb clk is disabled as dto source, but the dto pipe src sel bit may
still be 0x2, i.e specifying dtbclk as our dto source. If we do some
commit_planes_for_stream -> (full update) -> wait for outstanding
updates, we will poll the entire duration because the clk source driving
the tg that we are performing the poll with is not configured correctly
(we havent ran program_pix_clk yet to correct that bit, that is ran during
dpms on).

The solution is to not disable dtb as dto source during dpms off, as we
cannot update pipe src sel for the otg in dccg_set_dtbclk_dto as the tg
may still be on at that point.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Ausef Yousof <Ausef.Yousof@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c | 5 -----
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 8 ++++++++
 drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c    | 1 +
 drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c    | 3 +++
 4 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 5656d10368ad..778b68ec489e 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1152,7 +1152,6 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
 	struct dccg *dccg = dc->res_pool->dccg;
 	struct timing_generator *tg = pipe_ctx->stream_res.tg;
-	struct dtbclk_dto_params dto_params = {0};
 	int dp_hpo_inst;
 	struct link_encoder *link_enc = pipe_ctx->link_res.dio_link_enc;
 	struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
@@ -1179,14 +1178,10 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 	link_hwss->reset_stream_encoder(pipe_ctx);
 
 	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx) && dccg) {
-		dto_params.otg_inst = tg->inst;
-		dto_params.timing = &pipe_ctx->stream->timing;
 		dp_hpo_inst = pipe_ctx->stream_res.hpo_dp_stream_enc->inst;
 		if (dccg) {
 			dccg->funcs->disable_symclk32_se(dccg, dp_hpo_inst);
 			dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst, dp_hpo_inst);
-			if (dccg && dccg->funcs->set_dtbclk_dto)
-				dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
 		}
 	} else if (dccg && dccg->funcs->disable_symclk_se) {
 		dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_enc_inst,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 926c08e790c1..b2d915924a78 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -2806,6 +2806,8 @@ void dcn20_reset_back_end_for_pipe(
 {
 	struct dc_link *link = pipe_ctx->stream->link;
 	const struct link_hwss *link_hwss = get_link_hwss(link, &pipe_ctx->link_res);
+	struct dccg *dccg = dc->res_pool->dccg;
+	struct dtbclk_dto_params dto_params = {0};
 
 	DC_LOGGER_INIT(dc->ctx->logger);
 	if (pipe_ctx->stream_res.stream_enc == NULL) {
@@ -2866,6 +2868,12 @@ void dcn20_reset_back_end_for_pipe(
 					&pipe_ctx->link_res, pipe_ctx->stream->signal);
 			link->phy_state.symclk_state = SYMCLK_OFF_TX_OFF;
 		}
+		if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx) && dccg) {
+			dto_params.otg_inst = pipe_ctx->stream_res.tg->inst;
+			dto_params.timing = &pipe_ctx->stream->timing;
+			if (dccg && dccg->funcs->set_dtbclk_dto)
+				dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
+		}
 	}
 
 /*
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index 6a82a865209c..19ecd764e768 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -128,6 +128,7 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.enable_plane = dcn20_enable_plane,
 	.update_dchubp_dpp = dcn20_update_dchubp_dpp,
 	.post_unlock_reset_opp = dcn20_post_unlock_reset_opp,
+	.wait_for_all_pending_updates = dcn30_wait_for_all_pending_updates,
 };
 
 static const struct hwseq_private_funcs dcn35_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index b86fe2b094f8..eb29e852dedb 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -493,6 +493,9 @@ static struct timing_generator_funcs dcn35_tg_funcs = {
 		.set_long_vtotal = optc35_set_long_vtotal,
 		.is_two_pixels_per_container = optc1_is_two_pixels_per_container,
 		.read_otg_state = optc31_read_otg_state,
+		.get_optc_double_buffer_pending = optc3_get_optc_double_buffer_pending,
+		.get_pipe_update_pending = optc3_get_pipe_update_pending,
+		.get_otg_double_buffer_pending = optc3_get_otg_update_pending,
 };
 
 void dcn35_timing_generator_init(struct optc *optc1)
-- 
2.49.0


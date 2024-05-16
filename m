Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9FB9C25B7B
	for <amd-gfx@archiver.kernel.org>; Thu, 16 May 2024 19:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BA0B210EDC2;
	Thu, 16 May 2024 19:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="o1wC+xel";
	dkim-atps=neutral
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4906810EDBD
 for <amd-gfx@lists.freedesktop.org>; Thu, 16 May 2024 19:27:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxTVn5EAuDgPZZknLbQ7Og8J62I2MYGJVlaSf8n1x7DEJpWFbX7nrWukwzuooAzJJxsNC1KNUyRD2pPDHDLqdXOnG/5WVeMZH7Dqu0EkwaPs5pisymojSHRlJCUDFNLHL0mDecjjyi7C7od6p2oHz8v8cxUD0qzYbHirW0jv2suYZv8xFpWGAU4ltbwD7BaphjvfaCFvYkxRbUVlNj+gQmnkah+HVvEbuTbvDPDi87E71IIl3bXhc6mwEQX1CTLtMmwZVFGhYdslfsqmnoq+F/uE8HtDyHCJR137wTJUdHM9fOOhYuoMxRLg+eBe7YS0N+FzpGMIRAyoeYIBaQtVDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mlU6uCI4F6EzWfu9/iggL8B1Y39VMhs5DrPN8S06Fpk=;
 b=Dd3eEcc1WQAT8yqMbbqvnQIBdFpnQJHtxV1idtaLhD5IKpuQnEEnoWwiXMuQ1qNHbwEFzLzdFdmPvn88gJqPKCbkt9GM40iicFoQpoA8bO3CAw87KPw6yrIvKI72fOL3ngnZd82X7MiLTgG0qqKHoqRTHqcjX7tfTlq9mPd6YAQ6D7mXTOPc9fVfVt5sgFmL0CCcCmuXqCVVgkGhV8TyBP1A5f3zoPucU77/BpZtdqiZrozV1K+MtkHYIooAZlaEOT63mSOZnzYq4NSMA3vi/fs8xcttLeiFMANjWm9uyZFesJmsjPG8U/IpNA5YwsGrlqYuv5drTukKbrdX+9MVYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mlU6uCI4F6EzWfu9/iggL8B1Y39VMhs5DrPN8S06Fpk=;
 b=o1wC+xeldhxaZza0wmD5MLbZ5i1JTzxQifVWxWEb+OTSQLRRNZKY/d4BNtXJgVA5JaXbDr7hEpx5uy7suIRZq2AZLSKocafvc84O2ppB5xGaWiqXIP59GgGi86z5sQza7dpZOZKRo91ElAdVhBfYhIANlGMfad5AwjcKb3blC/w=
Received: from BN9PR03CA0069.namprd03.prod.outlook.com (2603:10b6:408:fc::14)
 by SA0PR12MB4464.namprd12.prod.outlook.com (2603:10b6:806:9f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.28; Thu, 16 May
 2024 19:27:09 +0000
Received: from BN2PEPF0000449D.namprd02.prod.outlook.com
 (2603:10b6:408:fc:cafe::14) by BN9PR03CA0069.outlook.office365.com
 (2603:10b6:408:fc::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55 via Frontend
 Transport; Thu, 16 May 2024 19:27:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF0000449D.mail.protection.outlook.com (10.167.243.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7587.21 via Frontend Transport; Thu, 16 May 2024 19:27:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Thu, 16 May
 2024 14:27:08 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Thu, 16 May 2024 14:27:08 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Dillon Varone <dillon.varone@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 21/24] drm/amd/display: Correct display clocks update block
 sequence
Date: Thu, 16 May 2024 15:26:44 -0400
Message-ID: <20240516192647.1522729-22-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240516192647.1522729-1-Roman.Li@amd.com>
References: <20240516192647.1522729-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449D:EE_|SA0PR12MB4464:EE_
X-MS-Office365-Filtering-Correlation-Id: 63568765-115f-4403-c132-08dc75de2e2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230031|36860700004|376005|1800799015|82310400017; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NRpw/Po+V2WLebUPpX/7aJklfL/qcCAKt4H7lGIwQRRNhz6BN9NBfveVFeGG?=
 =?us-ascii?Q?yKLfDz7SxkvG7HJIvqNfLd9W88MKvoPNtyzvj7g82hCE6/GN/f7Pit6aFdMM?=
 =?us-ascii?Q?loNJV0va1HGRB5CZEhw6YdBP5jZ1xqypr52eGnuXmjay7hESKKAzBADeRFx+?=
 =?us-ascii?Q?lpeeL3ekPEejilhAt4Oc3x13LWp6PD63hu0EIQ57GI6qMhSo3Na7ZAEePEqp?=
 =?us-ascii?Q?6dPGBwarXrwoiA7DpyLZqNX2H3UwZwnwRqZNR6hWC+nY04mlxzJwf+3PHf7a?=
 =?us-ascii?Q?SSUfbfLBTha5nDwMx9aFyIFGVubLnhq+gD8jua9Ybm3I6/iJA3JjBQySMtQS?=
 =?us-ascii?Q?0fsBKpM88C+FIMFWcLJHIpz8X/XrLldkm+20R0NjcfBHJGNM+jLnMGvByRMS?=
 =?us-ascii?Q?2UoQnbEbNdnvSc29pNx9HrHD2LpR2zbK5vXW6ufQGb4AnD6MDrLqdZUajQ2G?=
 =?us-ascii?Q?+7raLHXlXOlFicXN8lrCDGdP5frgH7xepQL2xjM2nMJ7/BAPdzfrUWI+ms7N?=
 =?us-ascii?Q?Q3YbXM3mpvcr/3iB0QLaY61gYDRWrOqMlP4zajbrqdAfc5hAvp+zwrmsT9ED?=
 =?us-ascii?Q?s7HS77dbIJE0Rxw0TIpQRMPi3Lp1yx+dr1Io9a8835yNIayiFIND3Rwiq4Wk?=
 =?us-ascii?Q?xtwy3Ef77ypQttenauO6KMISxtUbnE5aeGa1ghxmrW01BsS2ZEwnLybBqZOF?=
 =?us-ascii?Q?r8u6ndRXKasix0dy4GZDbOm1HWa4CYHCP6ukJuEm2CYSINOC42uYvKi5FnIX?=
 =?us-ascii?Q?Px6emHzrNUO0PEs2ZQ+zwgXMC+2wTwaPLqB9AzkMJCQoaMljwHNPpiBnQa5s?=
 =?us-ascii?Q?+ul34SJ1q+KaD5Bes/Ks2M6J4fENd+61/eexmVcM8saWxYdBP/bpbA83rnps?=
 =?us-ascii?Q?DKSPaZs+c56WpTmVqyD8ZLAq3NOZjuN3JPyg1lXdfuEGRW+pmJkQ3bgtJLZW?=
 =?us-ascii?Q?dMEHQ89LM6hVmJ0o2bsry/jV6lh+YCjoDxADEm1OJNZSPhKZshXsN+ANEVa1?=
 =?us-ascii?Q?3DbKKTix65xs24iXRulXM8NFji0q9rjTAsu1p8f68QlZydK/Chx5UJoP5uUq?=
 =?us-ascii?Q?D6GvWGZn71q/WGvMVHU6DcBRCHR6JAy5FPJDpcw+t821KIBqblfX50fRPNXg?=
 =?us-ascii?Q?H0ViM34vBS1SIuZJ7qqMvfiaE1mPORoSl8mMZtPTMRuBHT5a6dryuXgRz6iC?=
 =?us-ascii?Q?UP9OhVyTOJPtAzG9EEWK6mxkJxoH5uufyeTyrZ31yFu8fphH2Tz9aHimZdxF?=
 =?us-ascii?Q?T7gwp/rlU0r5PGVCQCHrGsoNmI7vU8zuV0LiUkMNWZlEyWGClg5WFUhD91Hb?=
 =?us-ascii?Q?Iq/AS5p4MW0NkxT1nuPf5ChaptUnzEvwNNKenWmGlAJOrekA3puamuUvxy2Z?=
 =?us-ascii?Q?F9XQ8y23/afsEd5FGXqyZg79Z9yK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(36860700004)(376005)(1800799015)(82310400017); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 May 2024 19:27:09.7264 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 63568765-115f-4403-c132-08dc75de2e2b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4464
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

From: Dillon Varone <dillon.varone@amd.com>

[WHY&HOW]
At the time of block sequence construction, the exact reference DPP/DISP clock is
not yet known, so the clock should be passed by reference to the DTO programming
function.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Acked-by: Roman Li <roman.li@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
---
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.c        | 577 ++++++++----------
 .../dc/clk_mgr/dcn401/dcn401_clk_mgr.h        |   8 +-
 2 files changed, 272 insertions(+), 313 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
index 0b2a3863b1f8..e3a3893a9cab 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.c
@@ -328,12 +328,12 @@ static void dcn401_update_clocks_update_dtb_dto(struct clk_mgr_internal *clk_mgr
 	}
 }
 
-void dcn401_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
-		struct dc_state *context, bool safe_to_lower, int dppclk_khz)
+static void dcn401_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
+		struct dc_state *context, bool safe_to_lower, int ref_dppclk_khz)
 {
 	int i;
 
-	clk_mgr->dccg->ref_dppclk = dppclk_khz;
+	clk_mgr->dccg->ref_dppclk = ref_dppclk_khz;
 	for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
 		int dpp_inst = 0, dppclk_khz, prev_dppclk_khz;
 
@@ -391,8 +391,6 @@ static void dcn401_update_clocks_update_dentist(
 {
 	uint32_t new_disp_divider = 0;
 	uint32_t new_dispclk_wdivider = 0;
-	uint32_t old_dispclk_wdivider = 0;
-	uint32_t i;
 	uint32_t dentist_dispclk_wdivider_readback = 0;
 	struct dc *dc = clk_mgr->base.ctx->dc;
 
@@ -403,86 +401,6 @@ static void dcn401_update_clocks_update_dentist(
 			* clk_mgr->base.dentist_vco_freq_khz / clk_mgr->base.clks.dispclk_khz;
 
 	new_dispclk_wdivider = dentist_get_did_from_divider(new_disp_divider);
-	REG_GET(DENTIST_DISPCLK_CNTL,
-			DENTIST_DISPCLK_WDIVIDER, &old_dispclk_wdivider);
-
-	/* When changing divider to or from 127, some extra programming is required to prevent corruption */
-	if (old_dispclk_wdivider == 127 && new_dispclk_wdivider != 127) {
-		for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
-			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-			uint32_t fifo_level;
-			struct dccg *dccg = clk_mgr->base.ctx->dc->res_pool->dccg;
-			struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
-			int32_t N;
-			int32_t j;
-
-			if (!resource_is_pipe_type(pipe_ctx, OTG_MASTER))
-				continue;
-			/* Virtual encoders don't have this function */
-			if (!stream_enc->funcs->get_fifo_cal_average_level)
-				continue;
-			fifo_level = stream_enc->funcs->get_fifo_cal_average_level(
-					stream_enc);
-			N = fifo_level / 4;
-			dccg->funcs->set_fifo_errdet_ovr_en(
-					dccg,
-					true);
-			for (j = 0; j < N - 4; j++)
-				dccg->funcs->otg_drop_pixel(
-						dccg,
-						pipe_ctx->stream_res.tg->inst);
-			dccg->funcs->set_fifo_errdet_ovr_en(
-					dccg,
-					false);
-		}
-	} else if (new_dispclk_wdivider == 127 && old_dispclk_wdivider != 127) {
-		/* request clock with 126 divider first */
-		uint32_t temp_disp_divider = dentist_get_divider_from_did(126);
-		uint32_t temp_dispclk_khz = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR * clk_mgr->base.dentist_vco_freq_khz) / temp_disp_divider;
-
-		if (clk_mgr->smu_present && dcn401_is_ppclk_dpm_enabled(clk_mgr, PPCLK_DISPCLK))
-			dcn401_set_hard_min_by_freq_optimized(clk_mgr, PPCLK_DISPCLK,
-					temp_dispclk_khz);
-
-		if (dc->debug.override_dispclk_programming) {
-			REG_GET(DENTIST_DISPCLK_CNTL,
-					DENTIST_DISPCLK_WDIVIDER, &dentist_dispclk_wdivider_readback);
-
-			if (dentist_dispclk_wdivider_readback != 126) {
-				REG_UPDATE(DENTIST_DISPCLK_CNTL,
-						DENTIST_DISPCLK_WDIVIDER, 126);
-				REG_WAIT(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_CHG_DONE, 1, 50, 2000);
-			}
-		}
-
-		for (i = 0; i < clk_mgr->base.ctx->dc->res_pool->pipe_count; i++) {
-			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-			struct dccg *dccg = clk_mgr->base.ctx->dc->res_pool->dccg;
-			struct stream_encoder *stream_enc = pipe_ctx->stream_res.stream_enc;
-			uint32_t fifo_level;
-			int32_t N;
-			int32_t j;
-
-			if (!resource_is_pipe_type(pipe_ctx, OTG_MASTER))
-				continue;
-			/* Virtual encoders don't have this function */
-			if (!stream_enc->funcs->get_fifo_cal_average_level)
-				continue;
-			fifo_level = stream_enc->funcs->get_fifo_cal_average_level(
-					stream_enc);
-			N = fifo_level / 4;
-			dccg->funcs->set_fifo_errdet_ovr_en(dccg, true);
-			for (j = 0; j < 12 - N; j++)
-				dccg->funcs->otg_add_pixel(dccg,
-						pipe_ctx->stream_res.tg->inst);
-			dccg->funcs->set_fifo_errdet_ovr_en(dccg, false);
-		}
-	}
-
-	/* do requested DISPCLK updates*/
-	if (clk_mgr->smu_present && dcn401_is_ppclk_dpm_enabled(clk_mgr, PPCLK_DISPCLK))
-		dcn401_set_hard_min_by_freq_optimized(clk_mgr, PPCLK_DISPCLK,
-				clk_mgr->base.clks.dispclk_khz);
 
 	if (dc->debug.override_dispclk_programming) {
 		REG_GET(DENTIST_DISPCLK_CNTL,
@@ -645,6 +563,9 @@ static void dcn401_update_clocks_legacy(struct clk_mgr *clk_mgr_base,
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
 
+		if (clk_mgr->smu_present && dcn401_is_ppclk_dpm_enabled(clk_mgr, PPCLK_DISPCLK))
+			clk_mgr_base->clks.actual_dispclk_khz = dcn401_set_hard_min_by_freq_optimized(clk_mgr, PPCLK_DISPCLK, clk_mgr_base->clks.dispclk_khz);
+
 		update_dispclk = true;
 	}
 
@@ -695,27 +616,131 @@ static void dcn401_update_clocks_legacy(struct clk_mgr *clk_mgr_base,
 				clk_mgr_base->clks.dispclk_khz / 1000 / 7);
 }
 
-static void dcn401_build_update_clocks_sequence(
+static void dcn401_execute_block_sequence(struct clk_mgr *clk_mgr_base, unsigned int num_steps)
+{
+	struct clk_mgr_internal *clk_mgr_internal = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	struct dcn401_clk_mgr *clk_mgr401 = TO_DCN401_CLK_MGR(clk_mgr_internal);
+
+	unsigned int i;
+	union dcn401_clk_mgr_block_sequence_params *params;
+
+	/* execute sequence */
+	for (i = 0; i < num_steps; i++) {
+		params = &clk_mgr401->block_sequence[i].params;
+
+		switch (clk_mgr401->block_sequence[i].func) {
+		case CLK_MGR401_READ_CLOCKS_FROM_DENTIST:
+			dcn2_read_clocks_from_hw_dentist(clk_mgr_base);
+			break;
+		case CLK_MGR401_UPDATE_NUM_DISPLAYS:
+			dcn401_smu_set_num_of_displays(clk_mgr_internal,
+					params->update_num_displays_params.num_displays);
+			break;
+		case CLK_MGR401_UPDATE_HARDMIN_PPCLK:
+			if (params->update_hardmin_params.response)
+				*params->update_hardmin_params.response = dcn401_smu_set_hard_min_by_freq(
+						clk_mgr_internal,
+						params->update_hardmin_params.ppclk,
+						params->update_hardmin_params.freq_mhz);
+			else
+				dcn401_smu_set_hard_min_by_freq(clk_mgr_internal,
+						params->update_hardmin_params.ppclk,
+						params->update_hardmin_params.freq_mhz);
+			break;
+		case CLK_MGR401_UPDATE_HARDMIN_PPCLK_OPTIMIZED:
+			if (params->update_hardmin_optimized_params.response)
+				*params->update_hardmin_optimized_params.response = dcn401_set_hard_min_by_freq_optimized(
+						clk_mgr_internal,
+						params->update_hardmin_optimized_params.ppclk,
+						params->update_hardmin_optimized_params.freq_khz);
+			else
+				dcn401_set_hard_min_by_freq_optimized(clk_mgr_internal,
+						params->update_hardmin_optimized_params.ppclk,
+						params->update_hardmin_optimized_params.freq_khz);
+			break;
+		case CLK_MGR401_UPDATE_ACTIVE_HARDMINS:
+			dcn401_smu_set_active_uclk_fclk_hardmin(
+					clk_mgr_internal,
+					params->update_idle_hardmin_params.uclk_mhz,
+					params->update_idle_hardmin_params.fclk_mhz);
+			break;
+		case CLK_MGR401_UPDATE_IDLE_HARDMINS:
+			dcn401_smu_set_idle_uclk_fclk_hardmin(
+					clk_mgr_internal,
+					params->update_idle_hardmin_params.uclk_mhz,
+					params->update_idle_hardmin_params.fclk_mhz);
+			break;
+		case CLK_MGR401_UPDATE_DEEP_SLEEP_DCFCLK:
+			dcn401_smu_set_min_deep_sleep_dcef_clk(
+					clk_mgr_internal,
+					params->update_deep_sleep_dcfclk_params.freq_mhz);
+			break;
+		case CLK_MGR401_UPDATE_FCLK_PSTATE_SUPPORT:
+			dcn401_smu_send_fclk_pstate_message(
+					clk_mgr_internal,
+					params->update_fclk_pstate_support_params.support);
+			break;
+		case CLK_MGR401_UPDATE_CAB_FOR_UCLK:
+			dcn401_smu_send_cab_for_uclk_message(
+				clk_mgr_internal,
+				params->update_cab_for_uclk_params.num_ways);
+			break;
+		case CLK_MGR401_UPDATE_WAIT_FOR_DMUB_ACK:
+			dcn401_smu_wait_for_dmub_ack_mclk(
+					clk_mgr_internal,
+					params->update_wait_for_dmub_ack_params.enable);
+			break;
+		case CLK_MGR401_INDICATE_DRR_STATUS:
+			dcn401_smu_indicate_drr_status(
+					clk_mgr_internal,
+					params->indicate_drr_status_params.mod_drr_for_pstate);
+			break;
+		case CLK_MGR401_UPDATE_DPPCLK_DTO:
+			dcn401_update_clocks_update_dpp_dto(
+					clk_mgr_internal,
+					params->update_dppclk_dto_params.context,
+					params->update_dppclk_dto_params.safe_to_lower,
+					*params->update_dppclk_dto_params.ref_dppclk_khz);
+			break;
+		case CLK_MGR401_UPDATE_DTBCLK_DTO:
+			dcn401_update_clocks_update_dtb_dto(
+					clk_mgr_internal,
+					params->update_dtbclk_dto_params.context,
+					*params->update_dtbclk_dto_params.ref_dtbclk_khz);
+			break;
+		case CLK_MGR401_UPDATE_DENTIST:
+			dcn401_update_clocks_update_dentist(
+					clk_mgr_internal,
+					params->update_dentist_params.context);
+			break;
+		case CLK_MGR401_UPDATE_PSR_WAIT_LOOP:
+			params->update_psr_wait_loop_params.dmcu->funcs->set_psr_wait_loop(
+					params->update_psr_wait_loop_params.dmcu,
+					params->update_psr_wait_loop_params.wait);
+			break;
+		default:
+			/* this should never happen */
+			BREAK_TO_DEBUGGER();
+			break;
+		}
+	}
+}
+
+static unsigned int dcn401_build_update_bandwidth_clocks_sequence(
 		struct clk_mgr *clk_mgr_base,
 		struct dc_state *context,
-		bool safe_to_lower,
-		unsigned int *num_steps)
+		bool safe_to_lower)
 {
 	struct clk_mgr_internal *clk_mgr_internal = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dcn401_clk_mgr *clk_mgr401 = TO_DCN401_CLK_MGR(clk_mgr_internal);
 	struct dc *dc = clk_mgr_base->ctx->dc;
-	struct dmcu *dmcu = clk_mgr_base->ctx->dc->res_pool->dmcu;
 	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
 	struct dcn401_clk_mgr_block_sequence *block_sequence = clk_mgr401->block_sequence;
-	bool force_reset = false;
 	bool enter_display_off = false;
 	bool update_active_fclk = false;
 	bool update_active_uclk = false;
 	bool update_idle_fclk = false;
 	bool update_idle_uclk = false;
-	bool update_dispclk = false;
-	bool update_dppclk = false;
-	bool dppclk_lowered = false;
 	bool is_idle_dpm_enabled = dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_UCLK) &&
 			dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_FCLK) &&
 			dcn401_is_ppclk_idle_dpm_enabled(clk_mgr_internal, PPCLK_UCLK) &&
@@ -726,25 +751,11 @@ static void dcn401_build_update_clocks_sequence(
 	int idle_uclk_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.idle_dramclk_khz);
 	int idle_fclk_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.idle_fclk_khz);
 
+	unsigned int num_steps = 0;
+
 	int display_count;
 	bool fclk_p_state_change_support, uclk_p_state_change_support;
 
-	*num_steps = 0;
-
-	/* CLK_MGR401_READ_CLOCKS_FROM_DENTIST */
-	if (clk_mgr_base->clks.dispclk_khz == 0 ||
-			(dc->debug.force_clock_mode & 0x1)) {
-		/* This is from resume or boot up, if forced_clock cfg option used,
-		 * we bypass program dispclk and DPPCLK, but need set them for S3.
-		 * Force_clock_mode 0x1:  force reset the clock even it is the same clock
-		 * as long as it is in Passive level.
-		 */
-		force_reset = true;
-
-		block_sequence[*num_steps].func = CLK_MGR401_READ_CLOCKS_FROM_DENTIST;
-		(*num_steps)++;
-	}
-
 	/* CLK_MGR401_UPDATE_NUM_DISPLAYS */
 	if (clk_mgr_internal->smu_present) {
 		display_count = clk_mgr_helper_get_active_display_cnt(dc, context);
@@ -753,9 +764,9 @@ static void dcn401_build_update_clocks_sequence(
 			enter_display_off = true;
 
 		if (enter_display_off == safe_to_lower) {
-			block_sequence[*num_steps].params.update_num_displays_params.num_displays = display_count;
-			block_sequence[*num_steps].func = CLK_MGR401_UPDATE_NUM_DISPLAYS;
-			(*num_steps)++;
+			block_sequence[num_steps].params.update_num_displays_params.num_displays = display_count;
+			block_sequence[num_steps].func = CLK_MGR401_UPDATE_NUM_DISPLAYS;
+			num_steps++;
 		}
 	}
 
@@ -771,9 +782,9 @@ static void dcn401_build_update_clocks_sequence(
 		if (clk_mgr_base->clks.fclk_p_state_change_support) {
 			/* Handle the code for sending a message to PMFW that FCLK P-state change is supported */
 			if (dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_FCLK)) {
-				block_sequence[*num_steps].params.update_fclk_pstate_support_params.support = FCLK_PSTATE_SUPPORTED;
-				block_sequence[*num_steps].func = CLK_MGR401_UPDATE_FCLK_PSTATE_SUPPORT;
-				(*num_steps)++;
+				block_sequence[num_steps].params.update_fclk_pstate_support_params.support = FCLK_PSTATE_SUPPORTED;
+				block_sequence[num_steps].func = CLK_MGR401_UPDATE_FCLK_PSTATE_SUPPORT;
+				num_steps++;
 			}
 		} else {
 			/* P-State is not supported so force max clocks */
@@ -791,11 +802,11 @@ static void dcn401_build_update_clocks_sequence(
 	if (should_set_clock(safe_to_lower, new_clocks->dcfclk_khz, clk_mgr_base->clks.dcfclk_khz)) {
 		clk_mgr_base->clks.dcfclk_khz = new_clocks->dcfclk_khz;
 		if (dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_DCFCLK)) {
-			block_sequence[*num_steps].params.update_hardmin_params.ppclk = PPCLK_DCFCLK;
-			block_sequence[*num_steps].params.update_hardmin_params.freq_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_khz);
-			block_sequence[*num_steps].params.update_hardmin_params.response = NULL;
-			block_sequence[*num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK;
-			(*num_steps)++;
+			block_sequence[num_steps].params.update_hardmin_params.ppclk = PPCLK_DCFCLK;
+			block_sequence[num_steps].params.update_hardmin_params.freq_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_khz);
+			block_sequence[num_steps].params.update_hardmin_params.response = NULL;
+			block_sequence[num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK;
+			num_steps++;
 		}
 	}
 
@@ -803,9 +814,9 @@ static void dcn401_build_update_clocks_sequence(
 	if (should_set_clock(safe_to_lower, new_clocks->dcfclk_deep_sleep_khz, clk_mgr_base->clks.dcfclk_deep_sleep_khz)) {
 		clk_mgr_base->clks.dcfclk_deep_sleep_khz = new_clocks->dcfclk_deep_sleep_khz;
 		if (dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_DCFCLK)) {
-			block_sequence[*num_steps].params.update_deep_sleep_dcfclk_params.freq_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_deep_sleep_khz);
-			block_sequence[*num_steps].func = CLK_MGR401_UPDATE_DEEP_SLEEP_DCFCLK;
-			(*num_steps)++;
+			block_sequence[num_steps].params.update_deep_sleep_dcfclk_params.freq_mhz = khz_to_mhz_ceil(clk_mgr_base->clks.dcfclk_deep_sleep_khz);
+			block_sequence[num_steps].func = CLK_MGR401_UPDATE_DEEP_SLEEP_DCFCLK;
+			num_steps++;
 		}
 	}
 
@@ -822,9 +833,9 @@ static void dcn401_build_update_clocks_sequence(
 			clk_mgr_base->clks.num_ways < new_clocks->num_ways) {
 		clk_mgr_base->clks.num_ways = new_clocks->num_ways;
 		if (dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_UCLK)) {
-			block_sequence[*num_steps].params.update_cab_for_uclk_params.num_ways = clk_mgr_base->clks.num_ways;
-			block_sequence[*num_steps].func = CLK_MGR401_UPDATE_CAB_FOR_UCLK;
-			(*num_steps)++;
+			block_sequence[num_steps].params.update_cab_for_uclk_params.num_ways = clk_mgr_base->clks.num_ways;
+			block_sequence[num_steps].func = CLK_MGR401_UPDATE_CAB_FOR_UCLK;
+			num_steps++;
 		}
 	}
 
@@ -839,9 +850,9 @@ static void dcn401_build_update_clocks_sequence(
 		if (!clk_mgr_base->clks.p_state_change_support) {
 			if (dc->clk_mgr->dc_mode_softmax_enabled) {
 				/* will never have the functional UCLK min above the softmax
-				 * since we calculate mode support based on softmax being the max UCLK
-				 * frequency.
-				 */
+				* since we calculate mode support based on softmax being the max UCLK
+				* frequency.
+				*/
 				active_uclk_mhz = clk_mgr_base->bw_params->dc_mode_softmax_memclk;
 			} else {
 				active_uclk_mhz = clk_mgr_base->bw_params->max_memclk_mhz;
@@ -872,11 +883,11 @@ static void dcn401_build_update_clocks_sequence(
 	if ((update_active_uclk || update_idle_uclk) &&
 			dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_UCLK) &&
 			!is_idle_dpm_enabled) {
-		block_sequence[*num_steps].params.update_hardmin_params.ppclk = PPCLK_UCLK;
-		block_sequence[*num_steps].params.update_hardmin_params.freq_mhz = active_uclk_mhz;
-		block_sequence[*num_steps].params.update_hardmin_params.response = NULL;
-		block_sequence[*num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK;
-		(*num_steps)++;
+		block_sequence[num_steps].params.update_hardmin_params.ppclk = PPCLK_UCLK;
+		block_sequence[num_steps].params.update_hardmin_params.freq_mhz = active_uclk_mhz;
+		block_sequence[num_steps].params.update_hardmin_params.response = NULL;
+		block_sequence[num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK;
+		num_steps++;
 	}
 
 	/* FCLK */
@@ -902,31 +913,31 @@ static void dcn401_build_update_clocks_sequence(
 	/* When idle DPM is enabled, need to send active and idle hardmins separately */
 	/* CLK_MGR401_UPDATE_ACTIVE_HARDMINS */
 	if ((update_active_uclk || update_active_fclk) && is_idle_dpm_enabled) {
-		block_sequence[*num_steps].params.update_idle_hardmin_params.uclk_mhz = active_uclk_mhz;
-		block_sequence[*num_steps].params.update_idle_hardmin_params.fclk_mhz = active_fclk_mhz;
-		block_sequence[*num_steps].func = CLK_MGR401_UPDATE_ACTIVE_HARDMINS;
-		(*num_steps)++;
+		block_sequence[num_steps].params.update_idle_hardmin_params.uclk_mhz = active_uclk_mhz;
+		block_sequence[num_steps].params.update_idle_hardmin_params.fclk_mhz = active_fclk_mhz;
+		block_sequence[num_steps].func = CLK_MGR401_UPDATE_ACTIVE_HARDMINS;
+		num_steps++;
 	}
 
 	/* CLK_MGR401_UPDATE_IDLE_HARDMINS */
 	if ((update_idle_uclk || update_idle_uclk) && is_idle_dpm_enabled) {
-		block_sequence[*num_steps].params.update_idle_hardmin_params.uclk_mhz = idle_uclk_mhz;
-		block_sequence[*num_steps].params.update_idle_hardmin_params.fclk_mhz = idle_fclk_mhz;
-		block_sequence[*num_steps].func = CLK_MGR401_UPDATE_IDLE_HARDMINS;
-		(*num_steps)++;
+		block_sequence[num_steps].params.update_idle_hardmin_params.uclk_mhz = idle_uclk_mhz;
+		block_sequence[num_steps].params.update_idle_hardmin_params.fclk_mhz = idle_fclk_mhz;
+		block_sequence[num_steps].func = CLK_MGR401_UPDATE_IDLE_HARDMINS;
+		num_steps++;
 	}
 
 	/* CLK_MGR401_UPDATE_WAIT_FOR_DMUB_ACK, CLK_MGR401_INDICATE_DRR_STATUS*/
 	if (clk_mgr_base->clks.fw_based_mclk_switching != new_clocks->fw_based_mclk_switching) {
 		clk_mgr_base->clks.fw_based_mclk_switching = new_clocks->fw_based_mclk_switching;
 
-		block_sequence[*num_steps].params.update_wait_for_dmub_ack_params.enable = clk_mgr_base->clks.fw_based_mclk_switching;
-		block_sequence[*num_steps].func = CLK_MGR401_UPDATE_WAIT_FOR_DMUB_ACK;
-		(*num_steps)++;
+		block_sequence[num_steps].params.update_wait_for_dmub_ack_params.enable = clk_mgr_base->clks.fw_based_mclk_switching;
+		block_sequence[num_steps].func = CLK_MGR401_UPDATE_WAIT_FOR_DMUB_ACK;
+		num_steps++;
 
-		block_sequence[*num_steps].params.indicate_drr_status_params.mod_drr_for_pstate = clk_mgr_base->clks.fw_based_mclk_switching;
-		block_sequence[*num_steps].func = CLK_MGR401_INDICATE_DRR_STATUS;
-		(*num_steps)++;
+		block_sequence[num_steps].params.indicate_drr_status_params.mod_drr_for_pstate = clk_mgr_base->clks.fw_based_mclk_switching;
+		block_sequence[num_steps].func = CLK_MGR401_INDICATE_DRR_STATUS;
+		num_steps++;
 	}
 
 	/* set FCLK to requested value if P-State switching is supported, or to re-enable P-State switching */
@@ -934,9 +945,9 @@ static void dcn401_build_update_clocks_sequence(
 		/* disable FCLK P-State support if needed */
 		if (clk_mgr_base->clks.fclk_p_state_change_support != clk_mgr_base->clks.fclk_prev_p_state_change_support &&
 				dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_FCLK)) {
-			block_sequence[*num_steps].params.update_fclk_pstate_support_params.support = FCLK_PSTATE_NOTSUPPORTED;
-			block_sequence[*num_steps].func = CLK_MGR401_UPDATE_FCLK_PSTATE_SUPPORT;
-			(*num_steps)++;
+			block_sequence[num_steps].params.update_fclk_pstate_support_params.support = FCLK_PSTATE_NOTSUPPORTED;
+			block_sequence[num_steps].func = CLK_MGR401_UPDATE_FCLK_PSTATE_SUPPORT;
+			num_steps++;
 		}
 
 		/* No need to send active FCLK hardmin, automatically set based on DCFCLK */
@@ -953,32 +964,71 @@ static void dcn401_build_update_clocks_sequence(
 			clk_mgr_base->clks.num_ways > new_clocks->num_ways) {
 		clk_mgr_base->clks.num_ways = new_clocks->num_ways;
 		if (dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_UCLK)) {
-			block_sequence[*num_steps].params.update_cab_for_uclk_params.num_ways = clk_mgr_base->clks.num_ways;
-			block_sequence[*num_steps].func = CLK_MGR401_UPDATE_CAB_FOR_UCLK;
-			(*num_steps)++;
+			block_sequence[num_steps].params.update_cab_for_uclk_params.num_ways = clk_mgr_base->clks.num_ways;
+			block_sequence[num_steps].func = CLK_MGR401_UPDATE_CAB_FOR_UCLK;
+			num_steps++;
 		}
 	}
 
+	return num_steps;
+}
+
+static unsigned int dcn401_build_update_display_clocks_sequence(
+		struct clk_mgr *clk_mgr_base,
+		struct dc_state *context,
+		bool safe_to_lower)
+{
+	struct clk_mgr_internal *clk_mgr_internal = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	struct dcn401_clk_mgr *clk_mgr401 = TO_DCN401_CLK_MGR(clk_mgr_internal);
+	struct dc *dc = clk_mgr_base->ctx->dc;
+	struct dmcu *dmcu = clk_mgr_base->ctx->dc->res_pool->dmcu;
+	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
+	struct dcn401_clk_mgr_block_sequence *block_sequence = clk_mgr401->block_sequence;
+	bool force_reset = false;
+	bool update_dispclk = false;
+	bool update_dppclk = false;
+	bool dppclk_lowered = false;
+
+	unsigned int num_steps = 0;
+
+	/* CLK_MGR401_READ_CLOCKS_FROM_DENTIST */
+	if (clk_mgr_base->clks.dispclk_khz == 0 ||
+			(dc->debug.force_clock_mode & 0x1)) {
+		/* This is from resume or boot up, if forced_clock cfg option used,
+		 * we bypass program dispclk and DPPCLK, but need set them for S3.
+		 * Force_clock_mode 0x1:  force reset the clock even it is the same clock
+		 * as long as it is in Passive level.
+		 */
+		force_reset = true;
+
+		clk_mgr_base->clks.dispclk_khz = clk_mgr_base->boot_snapshot.dispclk;
+		clk_mgr_base->clks.actual_dispclk_khz = clk_mgr_base->clks.dispclk_khz;
+
+		clk_mgr_base->clks.dppclk_khz = clk_mgr_base->boot_snapshot.dppclk;
+		clk_mgr_base->clks.actual_dppclk_khz = clk_mgr_base->clks.dppclk_khz;
+	}
+
 	/* DTBCLK */
-	if (!new_clocks->dtbclk_en && dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_DTBCLK))
+	if (!new_clocks->dtbclk_en && dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_DTBCLK)) {
 		new_clocks->ref_dtbclk_khz = clk_mgr_base->bw_params->clk_table.entries[0].dtbclk_mhz * 1000;
+	}
 
 	/* clock limits are received with MHz precision, divide by 1000 to prevent setting clocks at every call */
 	if (!dc->debug.disable_dtb_ref_clk_switch &&
 			should_set_clock(safe_to_lower, new_clocks->ref_dtbclk_khz / 1000, clk_mgr_base->clks.ref_dtbclk_khz / 1000) && //TODO these should be ceiled
 			dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_DTBCLK)) {
 		/* DCCG requires KHz precision for DTBCLK */
-		block_sequence[*num_steps].params.update_hardmin_params.ppclk = PPCLK_DTBCLK;
-		block_sequence[*num_steps].params.update_hardmin_params.freq_mhz = khz_to_mhz_ceil(new_clocks->ref_dtbclk_khz);
-		block_sequence[*num_steps].params.update_hardmin_params.response = &clk_mgr_base->clks.ref_dtbclk_khz;
-		block_sequence[*num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK;
-		(*num_steps)++;
+		block_sequence[num_steps].params.update_hardmin_params.ppclk = PPCLK_DTBCLK;
+		block_sequence[num_steps].params.update_hardmin_params.freq_mhz = khz_to_mhz_ceil(new_clocks->ref_dtbclk_khz);
+		block_sequence[num_steps].params.update_hardmin_params.response = &clk_mgr_base->clks.ref_dtbclk_khz;
+		block_sequence[num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK;
+		num_steps++;
 
 		/* Update DTO in DCCG */
-		block_sequence[*num_steps].params.update_dtbclk_dto_params.context = context;
-		block_sequence[*num_steps].params.update_dtbclk_dto_params.ref_dtbclk_khz = clk_mgr_base->clks.ref_dtbclk_khz;
-		block_sequence[*num_steps].func = CLK_MGR401_UPDATE_DTBCLK_DTO;
-		(*num_steps)++;
+		block_sequence[num_steps].params.update_dtbclk_dto_params.context = context;
+		block_sequence[num_steps].params.update_dtbclk_dto_params.ref_dtbclk_khz = &clk_mgr_base->clks.ref_dtbclk_khz;
+		block_sequence[num_steps].func = CLK_MGR401_UPDATE_DTBCLK_DTO;
+		num_steps++;
 	}
 
 	if (should_set_clock(safe_to_lower, new_clocks->dppclk_khz, clk_mgr_base->clks.dppclk_khz)) {
@@ -994,81 +1044,84 @@ static void dcn401_build_update_clocks_sequence(
 	if (should_set_clock(safe_to_lower, new_clocks->dispclk_khz, clk_mgr_base->clks.dispclk_khz)) {
 		clk_mgr_base->clks.dispclk_khz = new_clocks->dispclk_khz;
 
+		block_sequence[num_steps].params.update_hardmin_optimized_params.ppclk = PPCLK_DISPCLK;
+		block_sequence[num_steps].params.update_hardmin_optimized_params.freq_khz = clk_mgr_base->clks.dispclk_khz;
+		block_sequence[num_steps].params.update_hardmin_optimized_params.response = &clk_mgr_base->clks.actual_dispclk_khz;
+		block_sequence[num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK_OPTIMIZED;
+		num_steps++;
+
 		update_dispclk = true;
 	}
 
 	if (dc->config.forced_clocks == false || (force_reset && safe_to_lower)) {
 		if (dppclk_lowered) {
 			/* if clock is being lowered, increase DTO before lowering refclk */
-			block_sequence[*num_steps].params.update_dppclk_dto_params.context = context;
-			block_sequence[*num_steps].params.update_dppclk_dto_params.dppclk_khz = clk_mgr_base->clks.dppclk_khz;
-			block_sequence[*num_steps].params.update_dppclk_dto_params.safe_to_lower = safe_to_lower;
-			block_sequence[*num_steps].func = CLK_MGR401_UPDATE_DPPCLK_DTO;
-			(*num_steps)++;
+			block_sequence[num_steps].params.update_dppclk_dto_params.context = context;
+			block_sequence[num_steps].params.update_dppclk_dto_params.ref_dppclk_khz = &clk_mgr_base->clks.dppclk_khz;
+			block_sequence[num_steps].params.update_dppclk_dto_params.safe_to_lower = safe_to_lower;
+			block_sequence[num_steps].func = CLK_MGR401_UPDATE_DPPCLK_DTO;
+			num_steps++;
 
-			block_sequence[*num_steps].params.update_dentist_params.context = context;
-			block_sequence[*num_steps].func = CLK_MGR401_UPDATE_DENTIST;
-			(*num_steps)++;
+			block_sequence[num_steps].params.update_dentist_params.context = context;
+			block_sequence[num_steps].func = CLK_MGR401_UPDATE_DENTIST;
+			num_steps++;
 
 			if (dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_DPPCLK)) {
-				block_sequence[*num_steps].params.update_hardmin_optimized_params.ppclk = PPCLK_DPPCLK;
-				block_sequence[*num_steps].params.update_hardmin_optimized_params.freq_khz = clk_mgr_base->clks.dppclk_khz;
-				block_sequence[*num_steps].params.update_hardmin_optimized_params.response = &clk_mgr_base->clks.actual_dppclk_khz;
-				block_sequence[*num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK_OPTIMIZED;
-				(*num_steps)++;
-
-				block_sequence[*num_steps].params.update_dppclk_dto_params.context = context;
-				block_sequence[*num_steps].params.update_dppclk_dto_params.dppclk_khz = clk_mgr_base->clks.actual_dppclk_khz;
-				block_sequence[*num_steps].params.update_dppclk_dto_params.safe_to_lower = safe_to_lower;
-				block_sequence[*num_steps].func = CLK_MGR401_UPDATE_DPPCLK_DTO;
-				(*num_steps)++;
+				block_sequence[num_steps].params.update_hardmin_optimized_params.ppclk = PPCLK_DPPCLK;
+				block_sequence[num_steps].params.update_hardmin_optimized_params.freq_khz = clk_mgr_base->clks.dppclk_khz;
+				block_sequence[num_steps].params.update_hardmin_optimized_params.response = &clk_mgr_base->clks.actual_dppclk_khz;
+				block_sequence[num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK_OPTIMIZED;
+				num_steps++;
+
+				block_sequence[num_steps].params.update_dppclk_dto_params.context = context;
+				block_sequence[num_steps].params.update_dppclk_dto_params.ref_dppclk_khz = &clk_mgr_base->clks.actual_dppclk_khz;
+				block_sequence[num_steps].params.update_dppclk_dto_params.safe_to_lower = safe_to_lower;
+				block_sequence[num_steps].func = CLK_MGR401_UPDATE_DPPCLK_DTO;
+				num_steps++;
 			}
 		} else {
 			/* if clock is being raised, increase refclk before lowering DTO */
 			if (update_dppclk && dcn401_is_ppclk_dpm_enabled(clk_mgr_internal, PPCLK_DPPCLK)) {
-				block_sequence[*num_steps].params.update_hardmin_optimized_params.ppclk = PPCLK_DPPCLK;
-				block_sequence[*num_steps].params.update_hardmin_optimized_params.freq_khz = clk_mgr_base->clks.dppclk_khz;
-				block_sequence[*num_steps].params.update_hardmin_optimized_params.response = &clk_mgr_base->clks.actual_dppclk_khz;
-				block_sequence[*num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK_OPTIMIZED;
-				(*num_steps)++;
+				block_sequence[num_steps].params.update_hardmin_optimized_params.ppclk = PPCLK_DPPCLK;
+				block_sequence[num_steps].params.update_hardmin_optimized_params.freq_khz = clk_mgr_base->clks.dppclk_khz;
+				block_sequence[num_steps].params.update_hardmin_optimized_params.response = &clk_mgr_base->clks.actual_dppclk_khz;
+				block_sequence[num_steps].func = CLK_MGR401_UPDATE_HARDMIN_PPCLK_OPTIMIZED;
+				num_steps++;
 			}
 
 			if (update_dppclk || update_dispclk) {
-				block_sequence[*num_steps].params.update_dentist_params.context = context;
-				block_sequence[*num_steps].func = CLK_MGR401_UPDATE_DENTIST;
-				(*num_steps)++;
+				block_sequence[num_steps].params.update_dentist_params.context = context;
+				block_sequence[num_steps].func = CLK_MGR401_UPDATE_DENTIST;
+				num_steps++;
 			}
 
-			block_sequence[*num_steps].params.update_dppclk_dto_params.context = context;
-			block_sequence[*num_steps].params.update_dppclk_dto_params.dppclk_khz = clk_mgr_base->clks.actual_dppclk_khz;
-			block_sequence[*num_steps].params.update_dppclk_dto_params.safe_to_lower = safe_to_lower;
-			block_sequence[*num_steps].func = CLK_MGR401_UPDATE_DPPCLK_DTO;
-			(*num_steps)++;
+			block_sequence[num_steps].params.update_dppclk_dto_params.context = context;
+			block_sequence[num_steps].params.update_dppclk_dto_params.ref_dppclk_khz = &clk_mgr_base->clks.actual_dppclk_khz;
+			block_sequence[num_steps].params.update_dppclk_dto_params.safe_to_lower = safe_to_lower;
+			block_sequence[num_steps].func = CLK_MGR401_UPDATE_DPPCLK_DTO;
+			num_steps++;
 		}
 	}
 
 	if (update_dispclk && dmcu && dmcu->funcs->is_dmcu_initialized(dmcu)) {
 		/*update dmcu for wait_loop count*/
-		block_sequence[*num_steps].params.update_psr_wait_loop_params.dmcu = dmcu;
-		block_sequence[*num_steps].params.update_psr_wait_loop_params.wait = clk_mgr_base->clks.dispclk_khz / 1000 / 7;
-		block_sequence[*num_steps].func = CLK_MGR401_UPDATE_PSR_WAIT_LOOP;
-		(*num_steps)++;
+		block_sequence[num_steps].params.update_psr_wait_loop_params.dmcu = dmcu;
+		block_sequence[num_steps].params.update_psr_wait_loop_params.wait = clk_mgr_base->clks.dispclk_khz / 1000 / 7;
+		block_sequence[num_steps].func = CLK_MGR401_UPDATE_PSR_WAIT_LOOP;
+		num_steps++;
 	}
+
+	return num_steps;
 }
 
 static void dcn401_update_clocks(struct clk_mgr *clk_mgr_base,
 		struct dc_state *context,
 		bool safe_to_lower)
 {
-	struct clk_mgr_internal *clk_mgr_internal = TO_CLK_MGR_INTERNAL(clk_mgr_base);
-	struct dcn401_clk_mgr *clk_mgr401 = TO_DCN401_CLK_MGR(clk_mgr_internal);
 	struct dc *dc = clk_mgr_base->ctx->dc;
 
 	unsigned int num_steps = 0;
 
-	unsigned int i;
-	union dcn401_clk_mgr_block_sequence_params *params;
-
 	if (dc->work_arounds.skip_clock_update)
 		return;
 
@@ -1077,114 +1130,24 @@ static void dcn401_update_clocks(struct clk_mgr *clk_mgr_base,
 		return;
 	}
 
-	/* build clock update sequence */
-	dcn401_build_update_clocks_sequence(clk_mgr_base,
+	/* build bandwidth related clocks update sequence */
+	num_steps = dcn401_build_update_bandwidth_clocks_sequence(clk_mgr_base,
 			context,
-			safe_to_lower,
-			&num_steps);
+			safe_to_lower);
 
 	/* execute sequence */
-	for (i = 0; i < num_steps; i++) {
-		params = &clk_mgr401->block_sequence[i].params;
+	dcn401_execute_block_sequence(clk_mgr_base,	num_steps);
 
-		switch (clk_mgr401->block_sequence[i].func) {
-		case CLK_MGR401_READ_CLOCKS_FROM_DENTIST:
-			dcn2_read_clocks_from_hw_dentist(clk_mgr_base);
-			break;
-		case CLK_MGR401_UPDATE_NUM_DISPLAYS:
-			dcn401_smu_set_num_of_displays(clk_mgr_internal,
-					params->update_num_displays_params.num_displays);
-			break;
-		case CLK_MGR401_UPDATE_HARDMIN_PPCLK:
-			if (params->update_hardmin_params.response)
-				*params->update_hardmin_params.response = dcn401_smu_set_hard_min_by_freq(
-						clk_mgr_internal,
-						params->update_hardmin_params.ppclk,
-						params->update_hardmin_params.freq_mhz);
-			else
-				dcn401_smu_set_hard_min_by_freq(clk_mgr_internal,
-						params->update_hardmin_params.ppclk,
-						params->update_hardmin_params.freq_mhz);
-			break;
-		case CLK_MGR401_UPDATE_HARDMIN_PPCLK_OPTIMIZED:
-			if (params->update_hardmin_optimized_params.response)
-				*params->update_hardmin_optimized_params.response = dcn401_set_hard_min_by_freq_optimized(
-						clk_mgr_internal,
-						params->update_hardmin_optimized_params.ppclk,
-						params->update_hardmin_optimized_params.freq_khz);
-			else
-				dcn401_set_hard_min_by_freq_optimized(clk_mgr_internal,
-						params->update_hardmin_optimized_params.ppclk,
-						params->update_hardmin_optimized_params.freq_khz);
-			break;
-		case CLK_MGR401_UPDATE_ACTIVE_HARDMINS:
-			dcn401_smu_set_active_uclk_fclk_hardmin(
-					clk_mgr_internal,
-					params->update_idle_hardmin_params.uclk_mhz,
-					params->update_idle_hardmin_params.fclk_mhz);
-			break;
-		case CLK_MGR401_UPDATE_IDLE_HARDMINS:
-			dcn401_smu_set_idle_uclk_fclk_hardmin(
-					clk_mgr_internal,
-					params->update_idle_hardmin_params.uclk_mhz,
-					params->update_idle_hardmin_params.fclk_mhz);
-			break;
-		case CLK_MGR401_UPDATE_DEEP_SLEEP_DCFCLK:
-			dcn401_smu_set_min_deep_sleep_dcef_clk(
-					clk_mgr_internal,
-					params->update_deep_sleep_dcfclk_params.freq_mhz);
-			break;
-		case CLK_MGR401_UPDATE_FCLK_PSTATE_SUPPORT:
-			dcn401_smu_send_fclk_pstate_message(
-					clk_mgr_internal,
-					params->update_fclk_pstate_support_params.support);
-			break;
-		case CLK_MGR401_UPDATE_CAB_FOR_UCLK:
-			dcn401_smu_send_cab_for_uclk_message(
-				clk_mgr_internal,
-				params->update_cab_for_uclk_params.num_ways);
-			break;
-		case CLK_MGR401_UPDATE_WAIT_FOR_DMUB_ACK:
-			dcn401_smu_wait_for_dmub_ack_mclk(
-					clk_mgr_internal,
-					params->update_wait_for_dmub_ack_params.enable);
-			break;
-		case CLK_MGR401_INDICATE_DRR_STATUS:
-			dcn401_smu_indicate_drr_status(
-					clk_mgr_internal,
-					params->indicate_drr_status_params.mod_drr_for_pstate);
-			break;
-		case CLK_MGR401_UPDATE_DPPCLK_DTO:
-			dcn401_update_clocks_update_dpp_dto(
-					clk_mgr_internal,
-					params->update_dppclk_dto_params.context,
-					params->update_dppclk_dto_params.safe_to_lower,
-					params->update_dppclk_dto_params.dppclk_khz);
-			break;
-		case CLK_MGR401_UPDATE_DTBCLK_DTO:
-			dcn401_update_clocks_update_dtb_dto(
-					clk_mgr_internal,
-					params->update_dtbclk_dto_params.context,
-					params->update_dtbclk_dto_params.ref_dtbclk_khz);
-			break;
-		case CLK_MGR401_UPDATE_DENTIST:
-			dcn401_update_clocks_update_dentist(
-					clk_mgr_internal,
-					params->update_dentist_params.context);
-			break;
-		case CLK_MGR401_UPDATE_PSR_WAIT_LOOP:
-			params->update_psr_wait_loop_params.dmcu->funcs->set_psr_wait_loop(
-					params->update_psr_wait_loop_params.dmcu,
-					params->update_psr_wait_loop_params.wait);
-			break;
-		default:
-			/* this should never happen */
-			BREAK_TO_DEBUGGER();
-			break;
-		}
-	}
+	/* build display related clocks update sequence */
+	num_steps = dcn401_build_update_display_clocks_sequence(clk_mgr_base,
+			context,
+			safe_to_lower);
+
+	/* execute sequence */
+	dcn401_execute_block_sequence(clk_mgr_base,	num_steps);
 }
 
+
 static uint32_t dcn401_get_vco_frequency_from_reg(struct clk_mgr_internal *clk_mgr)
 {
 		struct fixed31_32 pll_req;
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
index e2a3fbb6c3c3..8860b35279d3 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn401/dcn401_clk_mgr.h
@@ -54,18 +54,17 @@ union dcn401_clk_mgr_block_sequence_params {
 	struct {
 		/* inputs */
 		struct dc_state *context;
-		int dppclk_khz;
+		int *ref_dppclk_khz;
 		bool safe_to_lower;
 	} update_dppclk_dto_params;
 	struct {
 		/* inputs */
 		struct dc_state *context;
-		int ref_dtbclk_khz;
+		int *ref_dtbclk_khz;
 	} update_dtbclk_dto_params;
 	struct {
 		/* inputs */
 		struct dc_state *context;
-		int ref_dtbclk_khz;
 	} update_dentist_params;
 	struct {
 		/* inputs */
@@ -108,9 +107,6 @@ void dcn401_init_clocks(struct clk_mgr *clk_mgr_base);
 struct clk_mgr_internal *dcn401_clk_mgr_construct(struct dc_context *ctx,
 		struct dccg *dccg);
 
-void dcn401_update_clocks_update_dpp_dto(struct clk_mgr_internal *clk_mgr,
-		struct dc_state *context, bool safe_to_lower, int dppclk_khz);
-
 void dcn401_clk_mgr_destroy(struct clk_mgr_internal *clk_mgr);
 
 #endif /* __DCN401_CLK_MGR_H_ */
-- 
2.34.1


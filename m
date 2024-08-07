Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1D74C52D7B
	for <amd-gfx@archiver.kernel.org>; Wed,  7 Aug 2024 07:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 848A610E446;
	Wed,  7 Aug 2024 07:57:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="pMbTSvPR";
	dkim-atps=neutral
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4A1510E446
 for <amd-gfx@lists.freedesktop.org>; Wed,  7 Aug 2024 07:57:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKwRxcnfzv1kXRcyJmbkMMyUSnoMtHVUfhoS6/l53EKSDLuj0/zaDm0OGwLe2GdR/MKYwQBWdSSaKTpY/jHCtJiLtU3UsdJfJv+TzZ7qsTllmDYuAzVrl+iVYJ5XHO7uD40lbBOtMdnjv7HmXR6o7AzY4PveBOckxYtOir41Bi8hsIE9V6y1Lqo3x3AzSJlSSj15Od+jkOmSdRu11t+opry/4jn2je/c6IfFBlmPyRR3abo2HCx3vkB5apYDNzfv5m1DvtTHIh0IMy5X68+1xweh1W8MXlRVls4N5LR7hud9HWJ96SPEtz/qQRi0FzaVkx3TpWYXJdHU/RXzpPJI8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kM6HDdpNJeeOpojNRaS5KGgAw5uFrSyYiJ1GXSczKXM=;
 b=YIiJPFDpdKXl3agKcWup7oUcqOqin3g6euCf/C8Lus+VxZi/LxzHI6il8E7dkbtTOSjTucOHqEu4GYy9iMxMcqPOz8LU5QjUG6LqqGfpxD2R/mAgUNiBDbwnHJWdCkpaDIewssZiF7ibxsK/SDItmfObbBzNadsw4ngiRgpVdwow6NbZ+nd5uG/H2CBrXfZNbxhxzfIj/DHnRV1sylqqupOOAPPkLYN7YCor99rkugtD8sF4BwpZt6YDQjr//RMbg4gtdROngxauXZaQWUNVTG0+0bqh1onGVH0npkxvt/2USq22Fhe2rZ3sVfFfPsjlmGqTMAm4a26nm91YDmZS0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kM6HDdpNJeeOpojNRaS5KGgAw5uFrSyYiJ1GXSczKXM=;
 b=pMbTSvPRRxAvJWDuVv7um2OLt9g8YY39FhSPh6s5Gp4meWaSri9bqt32XD0aTVzlNqnnla8+fl4Gx7Z+M2a0jFMrSne2akjB5ZxEYx9YHXjE2Yoh+k9SLrggBsRZuQ59six11b9Hm8nVjjrOZCWnwDDlktIvP7ypy3uWyNGAhX8=
Received: from BL1PR13CA0064.namprd13.prod.outlook.com (2603:10b6:208:2b8::9)
 by PH7PR12MB6000.namprd12.prod.outlook.com (2603:10b6:510:1dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Wed, 7 Aug
 2024 07:57:09 +0000
Received: from BL02EPF00021F6D.namprd02.prod.outlook.com
 (2603:10b6:208:2b8:cafe::2f) by BL1PR13CA0064.outlook.office365.com
 (2603:10b6:208:2b8::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.11 via Frontend
 Transport; Wed, 7 Aug 2024 07:57:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF00021F6D.mail.protection.outlook.com (10.167.249.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7849.8 via Frontend Transport; Wed, 7 Aug 2024 07:57:09 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:57:07 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 7 Aug
 2024 02:57:07 -0500
Received: from tom-r5.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 7 Aug 2024 02:57:04 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, <zaeem.mohamed@amd.com>, Dillon Varone
 <dillon.varone@amd.com>, Alvin Lee <alvin.lee2@amd.com>
Subject: [PATCH 15/24] drm/amd/display: Perform outstanding programming on
 full updates
Date: Wed, 7 Aug 2024 15:55:37 +0800
Message-ID: <20240807075546.831208-16-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807075546.831208-1-chiahsuan.chung@amd.com>
References: <20240807075546.831208-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF00021F6D:EE_|PH7PR12MB6000:EE_
X-MS-Office365-Filtering-Correlation-Id: 6eff6e04-3551-4c1e-8999-08dcb6b689b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JCsfBssd/mpsaPZe9+WBg76y6wxYOagQKXCmrP1vZ/zQHKdrl6nN1RfS2vPn?=
 =?us-ascii?Q?iYroucaAfXmJQOy8dWBJyIqf9PFKrsU1KaYOpuABdqETwfAmMvT653kgcJ9u?=
 =?us-ascii?Q?lxT0uq1i2UxsWq7poexw0ZLKiPueQ2yaDhj9Zc0trdH1oIFMPZLws9N7OTyC?=
 =?us-ascii?Q?BPOiwaLzrGIxGDa0kFDl+/rXOrT3sAAkTQOjfLqOkKwbe6zJXA2EnKODU6J8?=
 =?us-ascii?Q?WanoVD8ywE1RkOCSDQd0vidzEzB3osCGzsdQHji2I+mpvy4VLe0Jut919Pw6?=
 =?us-ascii?Q?chIfy2QGHk9/OizcWVJI1DeK7JlVZyt0POlMDiVogloWj5YCRiGZDj020FET?=
 =?us-ascii?Q?8ZWp/CtHQP0UzLCVFHEs26vdnjJ6KG7Q04L0uWkNwCpsKF3YkzGVLTrEqZZJ?=
 =?us-ascii?Q?EtToPXsIuUFu18ssbpccDOQR/KJBU2fpCVzhYAv4HSdbNNTFs3DJXfvCScCD?=
 =?us-ascii?Q?Jso6abEW533eNsvrMdKUvVjIGJn/Tdzckz7HGwp8/a/YAtD3soY56AgUiZ7P?=
 =?us-ascii?Q?Ga5WJ+o9SlaXX5/W+0b7jHblpuyqwweyrovnp5WXZjIdoDmcaS6Ss/xE5xHW?=
 =?us-ascii?Q?sEXlhjt6lbr2auiSyz+4hhJl7TBmlb5XNSJWG/qZOa126w2INh70bYF0fblv?=
 =?us-ascii?Q?eskIyEpc/MlcC6c6G5n1a9FEbkhXX0jEDuX2jM2DdRWooGJ0jEPS5zaiS89S?=
 =?us-ascii?Q?va/Nd9oY5n7JAjpvw+0WWLF5BMMUBGj5mNQbN6E8KHOL1eodusTM4HfWkZ3s?=
 =?us-ascii?Q?XIZMye1UoNK0V/9Hs5+v3d+90l2pkx8rQWGd6QynYEL8BvotZp89kIa30vbB?=
 =?us-ascii?Q?76bVAIUFN5tNiGy7B9dYO39BbQO/3yKDr6W/UQY30xX3tNrrS1YI0Zz1cPQJ?=
 =?us-ascii?Q?QoEBC/OsiOt6d0rxI+Nq5Q7Hv5OcKF/HApOZdgLB+scvTWrwbyiqF/PC5fKJ?=
 =?us-ascii?Q?4yzKp+ciQo+/oHD71DUuwCgVdjtZakf7LKYMqzM7x64zgOuK4M7w4Vu8A/8g?=
 =?us-ascii?Q?1tFedzGd1TbFT5HLSSF1hOT6rR5ifRqfRDkooIPiZxZABpJjaMHWFUjqAInD?=
 =?us-ascii?Q?qt+AyehU5FyqtsfdH/opmMPDFk5ofaoJmv0HzLayCRmx0W5uDyXw6vMZLkoO?=
 =?us-ascii?Q?FZjGaajrjVvL6kllyYLMTPRSR17dOaL+PVQPtmkaZFHtKprBAqyP70261g5J?=
 =?us-ascii?Q?j8il8eRS6YGijHLKgdJ96uDkfdkf+t8bQbBFa7kxQqg32mTZZVSPMikG0DB0?=
 =?us-ascii?Q?yUz9vwTCdt4pBKtzJeCWrT65II+E3YF/viln7u5QfPNSCwM8NbeCvg0jhXGo?=
 =?us-ascii?Q?Kq4bC7Cs5KWIm24xJ98D3uLlRaMNswU54S0Lu9nrHlICE7GSuHMxIily21Z3?=
 =?us-ascii?Q?6QxVjGw3A9RDp17+5ToV3gLHvsVIdN3mOr9NNqw2DoURO5cD3ZJkNZiIXkz8?=
 =?us-ascii?Q?1YUo1gjVW6SWIx5ho4yf5mzeq1coMJd+?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 07:57:09.0018 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6eff6e04-3551-4c1e-8999-08dcb6b689b8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF00021F6D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6000
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

[WHY]
In certain scenarios DC can internally trigger back to back full updates
which will miss some required programming that is normally deferred
until post update via optimize_bandwidth.

[HOW]
In back to back update scenarios, wait for pending updates to complete
and perform any strictly required outstanding programming.

Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Dillon Varone <dillon.varone@amd.com>
Signed-off-by: Tom Chung <chiahsuan.chung@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 121 +----------------
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 123 ++++++++++++++++++
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  10 ++
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |   4 +
 .../amd/display/dc/hwss/dcn32/dcn32_init.c    |   1 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   1 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   1 +
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  18 ++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.h |   1 +
 .../amd/display/dc/hwss/dcn401/dcn401_init.c  |   1 +
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  17 +++
 11 files changed, 176 insertions(+), 122 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 3ba2acfdae2a..c8dabb081b3d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -1352,80 +1352,6 @@ static void disable_vbios_mode_if_required(
 	}
 }
 
-/**
- * wait_for_blank_complete - wait for all active OPPs to finish pending blank
- * pattern updates
- *
- * @dc: [in] dc reference
- * @context: [in] hardware context in use
- */
-static void wait_for_blank_complete(struct dc *dc,
-		struct dc_state *context)
-{
-	struct pipe_ctx *opp_head;
-	struct dce_hwseq *hws = dc->hwseq;
-	int i;
-
-	if (!hws->funcs.wait_for_blank_complete)
-		return;
-
-	for (i = 0; i < MAX_PIPES; i++) {
-		opp_head = &context->res_ctx.pipe_ctx[i];
-
-		if (!resource_is_pipe_type(opp_head, OPP_HEAD) ||
-				dc_state_get_pipe_subvp_type(context, opp_head) == SUBVP_PHANTOM)
-			continue;
-
-		hws->funcs.wait_for_blank_complete(opp_head->stream_res.opp);
-	}
-}
-
-static void wait_for_odm_update_pending_complete(struct dc *dc, struct dc_state *context)
-{
-	struct pipe_ctx *otg_master;
-	struct timing_generator *tg;
-	int i;
-
-	for (i = 0; i < MAX_PIPES; i++) {
-		otg_master = &context->res_ctx.pipe_ctx[i];
-		if (!resource_is_pipe_type(otg_master, OTG_MASTER) ||
-				dc_state_get_pipe_subvp_type(context, otg_master) == SUBVP_PHANTOM)
-			continue;
-		tg = otg_master->stream_res.tg;
-		if (tg->funcs->wait_odm_doublebuffer_pending_clear)
-			tg->funcs->wait_odm_doublebuffer_pending_clear(tg);
-	}
-
-	/* ODM update may require to reprogram blank pattern for each OPP */
-	wait_for_blank_complete(dc, context);
-}
-
-static void wait_for_no_pipes_pending(struct dc *dc, struct dc_state *context)
-{
-	int i;
-	PERF_TRACE();
-	for (i = 0; i < MAX_PIPES; i++) {
-		int count = 0;
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-
-		if (!pipe->plane_state || dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_PHANTOM)
-			continue;
-
-		/* Timeout 100 ms */
-		while (count < 100000) {
-			/* Must set to false to start with, due to OR in update function */
-			pipe->plane_state->status.is_flip_pending = false;
-			dc->hwss.update_pending_status(pipe);
-			if (!pipe->plane_state->status.is_flip_pending)
-				break;
-			udelay(1);
-			count++;
-		}
-		ASSERT(!pipe->plane_state->status.is_flip_pending);
-	}
-	PERF_TRACE();
-}
-
 /* Public functions */
 
 struct dc *dc_create(const struct dc_init_data *init_params)
@@ -2109,12 +2035,12 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	if (context->stream_count > get_seamless_boot_stream_count(context) ||
 		context->stream_count == 0) {
 		/* Must wait for no flips to be pending before doing optimize bw */
-		wait_for_no_pipes_pending(dc, context);
+		hwss_wait_for_no_pipes_pending(dc, context);
 		/*
 		 * optimized dispclk depends on ODM setup. Need to wait for ODM
 		 * update pending complete before optimizing bandwidth.
 		 */
-		wait_for_odm_update_pending_complete(dc, context);
+		hwss_wait_for_odm_update_pending_complete(dc, context);
 		/* pplib is notified if disp_num changed */
 		dc->hwss.optimize_bandwidth(dc, context);
 		/* Need to do otg sync again as otg could be out of sync due to otg
@@ -3786,47 +3712,6 @@ static void commit_planes_for_stream_fast(struct dc *dc,
 		top_pipe_to_program->stream->update_flags.raw = 0;
 }
 
-static void wait_for_outstanding_hw_updates(struct dc *dc, struct dc_state *dc_context)
-{
-/*
- * This function calls HWSS to wait for any potentially double buffered
- * operations to complete. It should be invoked as a pre-amble prior
- * to full update programming before asserting any HW locks.
- */
-	int pipe_idx;
-	int opp_inst;
-	int opp_count = dc->res_pool->res_cap->num_opp;
-	struct hubp *hubp;
-	int mpcc_inst;
-	const struct pipe_ctx *pipe_ctx;
-
-	for (pipe_idx = 0; pipe_idx < dc->res_pool->pipe_count; pipe_idx++) {
-		pipe_ctx = &dc_context->res_ctx.pipe_ctx[pipe_idx];
-
-		if (!pipe_ctx->stream)
-			continue;
-
-		if (pipe_ctx->stream_res.tg->funcs->wait_drr_doublebuffer_pending_clear)
-			pipe_ctx->stream_res.tg->funcs->wait_drr_doublebuffer_pending_clear(pipe_ctx->stream_res.tg);
-
-		hubp = pipe_ctx->plane_res.hubp;
-		if (!hubp)
-			continue;
-
-		mpcc_inst = hubp->inst;
-		// MPCC inst is equal to pipe index in practice
-		for (opp_inst = 0; opp_inst < opp_count; opp_inst++) {
-			if ((dc->res_pool->opps[opp_inst] != NULL) &&
-				(dc->res_pool->opps[opp_inst]->mpcc_disconnect_pending[mpcc_inst])) {
-				dc->res_pool->mpc->funcs->wait_for_idle(dc->res_pool->mpc, mpcc_inst);
-				dc->res_pool->opps[opp_inst]->mpcc_disconnect_pending[mpcc_inst] = false;
-				break;
-			}
-		}
-	}
-	wait_for_odm_update_pending_complete(dc, dc_context);
-}
-
 static void commit_planes_for_stream(struct dc *dc,
 		struct dc_surface_update *srf_updates,
 		int surface_count,
@@ -3850,7 +3735,7 @@ static void commit_planes_for_stream(struct dc *dc,
 
 	dc_z10_restore(dc);
 	if (update_type == UPDATE_TYPE_FULL)
-		wait_for_outstanding_hw_updates(dc, context);
+		hwss_process_outstanding_hw_updates(dc, dc->current_state);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 5f9b6e8ef428..9a569aac3c00 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -978,3 +978,126 @@ void get_surface_tile_visual_confirm_color(
 		break;
 	}
 }
+
+/**
+ * hwss_wait_for_blank_complete - wait for all active OPPs to finish pending blank
+ * pattern updates
+ *
+ * @dc: [in] dc reference
+ * @context: [in] hardware context in use
+ */
+void hwss_wait_for_all_blank_complete(struct dc *dc,
+		struct dc_state *context)
+{
+	struct pipe_ctx *opp_head;
+	struct dce_hwseq *hws = dc->hwseq;
+	int i;
+
+	if (!hws->funcs.wait_for_blank_complete)
+		return;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		opp_head = &context->res_ctx.pipe_ctx[i];
+
+		if (!resource_is_pipe_type(opp_head, OPP_HEAD) ||
+				dc_state_get_pipe_subvp_type(context, opp_head) == SUBVP_PHANTOM)
+			continue;
+
+		hws->funcs.wait_for_blank_complete(opp_head->stream_res.opp);
+	}
+}
+
+void hwss_wait_for_odm_update_pending_complete(struct dc *dc, struct dc_state *context)
+{
+	struct pipe_ctx *otg_master;
+	struct timing_generator *tg;
+	int i;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		otg_master = &context->res_ctx.pipe_ctx[i];
+		if (!resource_is_pipe_type(otg_master, OTG_MASTER) ||
+				dc_state_get_pipe_subvp_type(context, otg_master) == SUBVP_PHANTOM)
+			continue;
+		tg = otg_master->stream_res.tg;
+		if (tg->funcs->wait_odm_doublebuffer_pending_clear)
+			tg->funcs->wait_odm_doublebuffer_pending_clear(tg);
+	}
+
+	/* ODM update may require to reprogram blank pattern for each OPP */
+	hwss_wait_for_all_blank_complete(dc, context);
+}
+
+void hwss_wait_for_no_pipes_pending(struct dc *dc, struct dc_state *context)
+{
+	int i;
+	for (i = 0; i < MAX_PIPES; i++) {
+		int count = 0;
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe->plane_state || dc_state_get_pipe_subvp_type(context, pipe) == SUBVP_PHANTOM)
+			continue;
+
+		/* Timeout 100 ms */
+		while (count < 100000) {
+			/* Must set to false to start with, due to OR in update function */
+			pipe->plane_state->status.is_flip_pending = false;
+			dc->hwss.update_pending_status(pipe);
+			if (!pipe->plane_state->status.is_flip_pending)
+				break;
+			udelay(1);
+			count++;
+		}
+		ASSERT(!pipe->plane_state->status.is_flip_pending);
+	}
+}
+
+void hwss_wait_for_outstanding_hw_updates(struct dc *dc, struct dc_state *dc_context)
+{
+/*
+ * This function calls HWSS to wait for any potentially double buffered
+ * operations to complete. It should be invoked as a pre-amble prior
+ * to full update programming before asserting any HW locks.
+ */
+	int pipe_idx;
+	int opp_inst;
+	int opp_count = dc->res_pool->res_cap->num_opp;
+	struct hubp *hubp;
+	int mpcc_inst;
+	const struct pipe_ctx *pipe_ctx;
+
+	for (pipe_idx = 0; pipe_idx < dc->res_pool->pipe_count; pipe_idx++) {
+		pipe_ctx = &dc_context->res_ctx.pipe_ctx[pipe_idx];
+
+		if (!pipe_ctx->stream)
+			continue;
+
+		if (pipe_ctx->stream_res.tg->funcs->wait_drr_doublebuffer_pending_clear)
+			pipe_ctx->stream_res.tg->funcs->wait_drr_doublebuffer_pending_clear(pipe_ctx->stream_res.tg);
+
+		hubp = pipe_ctx->plane_res.hubp;
+		if (!hubp)
+			continue;
+
+		mpcc_inst = hubp->inst;
+		// MPCC inst is equal to pipe index in practice
+		for (opp_inst = 0; opp_inst < opp_count; opp_inst++) {
+			if ((dc->res_pool->opps[opp_inst] != NULL) &&
+				(dc->res_pool->opps[opp_inst]->mpcc_disconnect_pending[mpcc_inst])) {
+				dc->res_pool->mpc->funcs->wait_for_idle(dc->res_pool->mpc, mpcc_inst);
+				dc->res_pool->opps[opp_inst]->mpcc_disconnect_pending[mpcc_inst] = false;
+				break;
+			}
+		}
+	}
+	hwss_wait_for_odm_update_pending_complete(dc, dc_context);
+}
+
+void hwss_process_outstanding_hw_updates(struct dc *dc, struct dc_state *dc_context)
+{
+	/* wait for outstanding updates */
+	hwss_wait_for_outstanding_hw_updates(dc, dc_context);
+
+	/* perform outstanding post update programming */
+	if (dc->hwss.program_outstanding_updates)
+		dc->hwss.program_outstanding_updates(dc, dc_context);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index d75a811c90d9..6a40b2e2beb5 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1846,3 +1846,13 @@ void dcn32_interdependent_update_lock(struct dc *dc,
 			dc->hwss.pipe_control_lock(dc, pipe, false);
 	}
 }
+
+void dcn32_program_outstanding_updates(struct dc *dc,
+		struct dc_state *context)
+{
+	struct hubbub *hubbub = dc->res_pool->hubbub;
+
+	/* update compbuf if required */
+	if (hubbub->funcs->program_compbuf_size)
+		hubbub->funcs->program_compbuf_size(hubbub, context->bw_ctx.bw.dcn.compbuf_size_kb, true);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
index b1563e2c0491..cac4a08b92a4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
@@ -133,4 +133,8 @@ void dcn32_prepare_bandwidth(struct dc *dc,
 
 void dcn32_interdependent_update_lock(struct dc *dc,
 		struct dc_state *context, bool lock);
+
+void dcn32_program_outstanding_updates(struct dc *dc,
+		struct dc_state *context);
+
 #endif /* __DC_HWSS_DCN32_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
index 58bed01fc20e..3422b564ae98 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_init.c
@@ -120,6 +120,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.blank_phantom = dcn32_blank_phantom,
 	.is_pipe_topology_transition_seamless = dcn32_is_pipe_topology_transition_seamless,
 	.calculate_pix_rate_divider = dcn32_calculate_pix_rate_divider,
+	.program_outstanding_updates = dcn32_program_outstanding_updates,
 };
 
 static const struct hwseq_private_funcs dcn32_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index 55dc5799e725..2bbf1fef94fd 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -123,6 +123,7 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.root_clock_control = dcn35_root_clock_control,
 	.set_long_vtotal = dcn35_set_long_vblank,
 	.calculate_pix_rate_divider = dcn32_calculate_pix_rate_divider,
+	.program_outstanding_updates = dcn32_program_outstanding_updates,
 };
 
 static const struct hwseq_private_funcs dcn35_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index b1b2a58684e7..5da3069fc1ab 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -122,6 +122,7 @@ static const struct hw_sequencer_funcs dcn351_funcs = {
 	.root_clock_control = dcn35_root_clock_control,
 	.set_long_vtotal = dcn35_set_long_vblank,
 	.calculate_pix_rate_divider = dcn32_calculate_pix_rate_divider,
+	.program_outstanding_updates = dcn32_program_outstanding_updates,
 };
 
 static const struct hwseq_private_funcs dcn351_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index ac0a21ac318f..0b743669f23b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -1399,7 +1399,7 @@ void dcn401_prepare_bandwidth(struct dc *dc,
 {
 	struct hubbub *hubbub = dc->res_pool->hubbub;
 	bool p_state_change_support = context->bw_ctx.bw.dcn.clk.p_state_change_support;
-	unsigned int compbuf_size_kb = 0;
+	unsigned int compbuf_size = 0;
 
 	/* Any transition into P-State support should disable MCLK switching first to avoid hangs */
 	if (p_state_change_support) {
@@ -1429,10 +1429,10 @@ void dcn401_prepare_bandwidth(struct dc *dc,
 
 	/* decrease compbuf size */
 	if (hubbub->funcs->program_compbuf_segments) {
-		compbuf_size_kb = context->bw_ctx.bw.dcn.arb_regs.compbuf_size;
-		dc->wm_optimized_required |= (compbuf_size_kb != dc->current_state->bw_ctx.bw.dcn.arb_regs.compbuf_size);
+		compbuf_size = context->bw_ctx.bw.dcn.arb_regs.compbuf_size;
+		dc->wm_optimized_required |= (compbuf_size != dc->current_state->bw_ctx.bw.dcn.arb_regs.compbuf_size);
 
-		hubbub->funcs->program_compbuf_segments(hubbub, compbuf_size_kb, false);
+		hubbub->funcs->program_compbuf_segments(hubbub, compbuf_size, false);
 	}
 
 	if (dc->debug.fams2_config.bits.enable) {
@@ -1760,3 +1760,13 @@ void dcn401_interdependent_update_lock(struct dc *dc,
 		}
 	}
 }
+
+void dcn401_program_outstanding_updates(struct dc *dc,
+		struct dc_state *context)
+{
+	struct hubbub *hubbub = dc->res_pool->hubbub;
+
+	/* update compbuf if required */
+	if (hubbub->funcs->program_compbuf_segments)
+		hubbub->funcs->program_compbuf_segments(hubbub, context->bw_ctx.bw.dcn.arb_regs.compbuf_size, true);
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
index 3ecb1ebffcee..a27e62081685 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.h
@@ -83,4 +83,5 @@ void dcn401_update_odm(struct dc *dc, struct dc_state *context,
 void adjust_hotspot_between_slices_for_2x_magnify(uint32_t cursor_width, struct dc_cursor_position *pos_cpy);
 void dcn401_wait_for_det_buffer_update(struct dc *dc, struct dc_state *context, struct pipe_ctx *otg_master);
 void dcn401_interdependent_update_lock(struct dc *dc, struct dc_state *context, bool lock);
+void dcn401_program_outstanding_updates(struct dc *dc, struct dc_state *context);
 #endif /* __DC_HWSS_DCN401_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
index b5f63675afcb..a2ca07235c83 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_init.c
@@ -99,6 +99,7 @@ static const struct hw_sequencer_funcs dcn401_funcs = {
 	.fams2_global_control_lock = dcn401_fams2_global_control_lock,
 	.fams2_update_config = dcn401_fams2_update_config,
 	.fams2_global_control_lock_fast = dcn401_fams2_global_control_lock_fast,
+	.program_outstanding_updates = dcn401_program_outstanding_updates,
 };
 
 static const struct hwseq_private_funcs dcn401_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index f50b2955ce8c..326854489802 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -459,6 +459,8 @@ struct hw_sequencer_funcs {
 			bool enable);
 	void (*fams2_global_control_lock_fast)(union block_sequence_params *params);
 	void (*set_long_vtotal)(struct pipe_ctx **pipe_ctx, int num_pipes, uint32_t v_total_min, uint32_t v_total_max);
+	void (*program_outstanding_updates)(struct dc *dc,
+			struct dc_state *context);
 };
 
 void color_space_to_black_color(
@@ -519,6 +521,21 @@ void hwss_build_fast_sequence(struct dc *dc,
 		struct dc_stream_status *stream_status,
 		struct dc_state *context);
 
+void hwss_wait_for_all_blank_complete(struct dc *dc,
+		struct dc_state *context);
+
+void hwss_wait_for_odm_update_pending_complete(struct dc *dc,
+		struct dc_state *context);
+
+void hwss_wait_for_no_pipes_pending(struct dc *dc,
+		struct dc_state *context);
+
+void hwss_wait_for_outstanding_hw_updates(struct dc *dc,
+		struct dc_state *dc_context);
+
+void hwss_process_outstanding_hw_updates(struct dc *dc,
+		struct dc_state *dc_context);
+
 void hwss_send_dmcub_cmd(union block_sequence_params *params);
 
 void hwss_program_manual_trigger(union block_sequence_params *params);
-- 
2.34.1


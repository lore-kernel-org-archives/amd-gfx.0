Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05D37C3DA42
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Jul 2024 19:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA59710E8A3;
	Wed, 10 Jul 2024 19:38:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Nx8OFxsc";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2058.outbound.protection.outlook.com [40.107.95.58])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5720410E8A3
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Jul 2024 19:38:16 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlWomn372FWbJNsNsrsCBxULIcCIWG21t4932CF6Wn8uzYxI3vsxto2nvySI86rOvRI1m0w0gCI0Mx1s9vMLExfhmmqKOECjdd9xKDT/QLjDc7+TmUzGK44Nu9n45//E4aGmggniv7CeM+ZtlwVQmRi9GyTI31OtWQyYya3JI5m1Z1/ahw+Z77RRg3+az3/ZAbSeno4XOZZ94TPmJSRJyktmkxbEBcUSkOu8KVbeApRmIGUggJqe4SYAL/KJniXTqtZm3ITuP55iOZRfa5MSjbqlAqarZTd6qph/JXiUXdyXJHXy1csOxDJeImz1sRaXQ3TXw4wcRphmd2kcwLgR1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mrKUbBXday0PpA4LLoZ8wqENf3n39OomFcz7YYn2c6k=;
 b=Sq+UNdo4HnV9MU3rCduvkcRmH7vFxfBjQV5UeaazTmjMPdXi2DxTtvldkPQs7NB3W91qdN4joCCdhB6Is3twy/NCWhZSw83dwdMPgXIcpi2bIZOdFFOmCRHaOoEB3grQLfkHRDj0+kaTDvhtMGTr1fIo2CowvE+3dGdxkS51w8JJnI8lDzEvdfb39ckxUxxmEgDtPrz8Zn9FGD8BdiFSAYxNZwa+AIk0CY0voULqa6EFGXk/MqSJp8w+NfaY6XQ5EaODyu1GcUlhRgStddLIKw+XmC9RA0T4sKfoNGpaTS+0y+AWsQSjNCEvt0v2INQkPEzT8oknlViAkuS9OXdsRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mrKUbBXday0PpA4LLoZ8wqENf3n39OomFcz7YYn2c6k=;
 b=Nx8OFxscBiyEurCDVpr+TjwHM1uCYyudIHEMaK78kcfTwGM99/F89/OGnXWTSQ8EkCN7ExRMTb4OyhabKg5R94ZOGh6ItArIcgUyNMf4UvhEYOOmVSgEw+vXpggVj2F0V1fuFSdb76EhUHRlzxTFs7C7pq8yzFycCjQF65zHvKw=
Received: from BY3PR03CA0030.namprd03.prod.outlook.com (2603:10b6:a03:39a::35)
 by PH7PR12MB5973.namprd12.prod.outlook.com (2603:10b6:510:1d8::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Wed, 10 Jul
 2024 19:38:12 +0000
Received: from CO1PEPF000042AA.namprd03.prod.outlook.com
 (2603:10b6:a03:39a:cafe::f2) by BY3PR03CA0030.outlook.office365.com
 (2603:10b6:a03:39a::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Wed, 10 Jul 2024 19:38:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000042AA.mail.protection.outlook.com (10.167.243.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Wed, 10 Jul 2024 19:38:11 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 10 Jul
 2024 14:38:10 -0500
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 10 Jul 2024 14:38:09 -0500
From: Fangzhi Zuo <Jerry.Zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <jerry.zuo@amd.com>, Alvin Lee <alvin.lee2@amd.com>, Nicholas Kazlauskas
 <nicholas.kazlauskas@amd.com>
Subject: [PATCH 13/50] drm/amd/display: When resync fifo ensure to use correct
 pipe ctx
Date: Wed, 10 Jul 2024 15:36:30 -0400
Message-ID: <20240710193707.43754-14-Jerry.Zuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240710193707.43754-1-Jerry.Zuo@amd.com>
References: <20240710193707.43754-1-Jerry.Zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: Jerry.Zuo@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042AA:EE_|PH7PR12MB5973:EE_
X-MS-Office365-Filtering-Correlation-Id: 5289c03c-cffa-406f-6b0e-08dca117d5bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kc0u5q+kaiNvna8ZSVwL56D2wcMcIR9GeHK+Qpm2snqP/QZhoqMAmiY3Tl62?=
 =?us-ascii?Q?uJctpASUAcAAERvivpxqa3r1nDjugCLCX41P4VRGdqe7Il41wTBOZfkOWAcX?=
 =?us-ascii?Q?rDjqzI0CD4/yALT+6HADbO7ralD6H0f03ruicVAB0jGTB2XF4nxllNcV8QwF?=
 =?us-ascii?Q?3rsYK6zCIyB6BaeMZN5Qs6hRv9/G8Pdb1UCerKnjoBzG7e6DbX/BJojx81BW?=
 =?us-ascii?Q?kx6tq5UJ57nlplaDfWPC4tdFK5BfmTvL+id+X+eDL4fXK5JxSS2JdaxB0YX9?=
 =?us-ascii?Q?5KWOE+vyKkaTYchr5Pm9JK6m00ocKgUZ9HWe4onNVgFLUbHcE1QdaAQ4xsdG?=
 =?us-ascii?Q?2Oc3LckMUPt0+vtp3Vu/g3CYShtog+Len9HH3ltd62JkqHRu2nqHNg05TXFX?=
 =?us-ascii?Q?EYkxmyuEPOpbDZsG/lq+bdkbYnhCNr7i12LiwZArWqyU0XAoifanj8e2hQ/J?=
 =?us-ascii?Q?KglVtK8CmsExbitu9ddxXMHC2vC5dGZMlBAFdsodczm18YthJW++z2rbUUPO?=
 =?us-ascii?Q?kRMDUi+w4XyHMr6t0V87nNxIExl39fmX0fc5qSIB1zVnbE43lEi0LLIFXXus?=
 =?us-ascii?Q?kcMZGR1kyw4hxBN/7PHa958vMAmpnBFpvpQb9uth1H3yEHyzT4rHekHzZDCr?=
 =?us-ascii?Q?byobC8nHMFssfYiAmJ/qwrbAP2dFcrJpUECYhh3Va2x1EUFCrqgGpzD43YK+?=
 =?us-ascii?Q?Jc8f1Ckc+D0GXCmFnUIpIYx7BVo59wMKIeiWGKXbVyEe0bJw6xZJ6LN1WSTZ?=
 =?us-ascii?Q?j0P2Saigm1miHKzY/XmPbKYkfmK2CTj0uHhG2502GdUdXQ9gDThQxtC3DBrK?=
 =?us-ascii?Q?BrbeU4HEvooYVAsarVndN8SMi9tTqdvDsdDk1OYvlUpBicItFPGsnYyCWukS?=
 =?us-ascii?Q?BxiyxjWxEJ9vBahma5u+kxg8KZl+vpmkqRV+faV9M/H9RygpqZfyqSk5BMXr?=
 =?us-ascii?Q?bv10LO3T8UjD7f1MfoNJU+eqogKVAas391739R4octJopESyJciEUozAODR1?=
 =?us-ascii?Q?0Tune4NY5L92zHdnpC0unsV59rs/R5Aof59UTddmcyJsMrlw7s7Eq9WT//LI?=
 =?us-ascii?Q?sZWC9DkRl5fQEZ/X7/K4AoqiCM9wFF3YUYVrWmKV6HgP1BOudrGQbjaCPVuf?=
 =?us-ascii?Q?BfNnFglqFXmHlXsdC17oNEAIRsVwDAlKYzrlxoQF2yuklsGWveiJAG1STuZu?=
 =?us-ascii?Q?WZVQ/1swctdYCjfjk23GTDPDamvLVAS31j+JHYwa40F9i99wrpGFPZ46NQKu?=
 =?us-ascii?Q?SV/1dPmURJGIW/sAnxTYeUsOUwiDUE23YulCdDq2T6afK4XjRyYmPkBvanhi?=
 =?us-ascii?Q?VCje2qfB+2TOXTeD9BG08s/fJJdC4tCdzHCymQjUkdYHYhcF7Tkovea5TkL/?=
 =?us-ascii?Q?ctQSZ12vtVn5YU3bylRPOuU2JXnPsGONMP05452SfTVabF1tJ3kn0nDqfe/X?=
 =?us-ascii?Q?nGa8fTLcY187lZw9ZPZjK+6aU5wOp3zi?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2024 19:38:11.9210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5289c03c-cffa-406f-6b0e-08dca117d5bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042AA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5973
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

From: Alvin Lee <alvin.lee2@amd.com>

We resync the FIFO after each pipe update in apply_ctx_to_hw.
However, this means that some pipes (in hardware) are based on the
new context and some are based on the current_state (since the pipes
are updated on at a time). In this case we must ensure to use the
pipe_ctx that's currently still configured in hardware when turning
off / on OTG's and reconfiguring ODM during the resync.

Reviewed-by: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c |  2 +-
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.c | 13 +++++++++---
 .../amd/display/dc/hwss/dcn314/dcn314_hwseq.h |  2 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   | 20 ++++++++++++++-----
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.h   |  2 +-
 .../display/dc/hwss/hw_sequencer_private.h    |  3 ++-
 6 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 51c5195f8325..982b2d5bfb5f 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -2443,7 +2443,7 @@ enum dc_status dce110_apply_ctx_to_hw(
 
 #ifdef CONFIG_DRM_AMD_DC_FP
 		if (hws->funcs.resync_fifo_dccg_dio)
-			hws->funcs.resync_fifo_dccg_dio(hws, dc, context);
+			hws->funcs.resync_fifo_dccg_dio(hws, dc, context, i);
 #endif
 	}
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
index 388404cdeeaa..4e93eeedfc1b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.c
@@ -355,14 +355,18 @@ void dcn314_calculate_pix_rate_divider(
 	}
 }
 
-void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context)
+void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context, unsigned int current_pipe_idx)
 {
 	unsigned int i;
 	struct pipe_ctx *pipe = NULL;
 	bool otg_disabled[MAX_PIPES] = {false};
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+		if (i <= current_pipe_idx) {
+			pipe = &context->res_ctx.pipe_ctx[i];
+		} else {
+			pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+		}
 
 		if (pipe->top_pipe || pipe->prev_odm_pipe)
 			continue;
@@ -377,7 +381,10 @@ void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc
 	hws->ctx->dc->res_pool->dccg->funcs->trigger_dio_fifo_resync(hws->ctx->dc->res_pool->dccg);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+		if (i <= current_pipe_idx)
+			pipe = &context->res_ctx.pipe_ctx[i];
+		else
+			pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 
 		if (otg_disabled[i]) {
 			int opp_inst[MAX_PIPES] = { pipe->stream_res.opp->inst };
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
index fb4f90f61b22..2305ad282f21 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn314/dcn314_hwseq.h
@@ -41,7 +41,7 @@ unsigned int dcn314_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsig
 
 void dcn314_calculate_pix_rate_divider(struct dc *dc, struct dc_state *context, const struct dc_stream_state *stream);
 
-void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context);
+void dcn314_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context, unsigned int current_pipe_idx);
 
 void dcn314_dpp_root_clock_control(struct dce_hwseq *hws, unsigned int dpp_inst, bool clock_on);
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 4534843ba66a..7f41eccefe02 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1201,20 +1201,27 @@ void dcn32_calculate_pix_rate_divider(
 	}
 }
 
-void dcn32_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context)
+void dcn32_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context, unsigned int current_pipe_idx)
 {
 	unsigned int i;
 	struct pipe_ctx *pipe = NULL;
 	bool otg_disabled[MAX_PIPES] = {false};
+	struct dc_state *dc_state = NULL;
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+		if (i <= current_pipe_idx) {
+			pipe = &context->res_ctx.pipe_ctx[i];
+			dc_state = context;
+		} else {
+			pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+			dc_state = dc->current_state;
+		}
 
 		if (!resource_is_pipe_type(pipe, OTG_MASTER))
 			continue;
 
 		if ((pipe->stream->dpms_off || dc_is_virtual_signal(pipe->stream->signal))
-			&& dc_state_get_pipe_subvp_type(dc->current_state, pipe) != SUBVP_PHANTOM) {
+			&& dc_state_get_pipe_subvp_type(dc_state, pipe) != SUBVP_PHANTOM) {
 			pipe->stream_res.tg->funcs->disable_crtc(pipe->stream_res.tg);
 			reset_sync_context_for_pipe(dc, context, i);
 			otg_disabled[i] = true;
@@ -1224,7 +1231,10 @@ void dcn32_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_
 	hws->ctx->dc->res_pool->dccg->funcs->trigger_dio_fifo_resync(hws->ctx->dc->res_pool->dccg);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+		if (i <= current_pipe_idx)
+			pipe = &context->res_ctx.pipe_ctx[i];
+		else
+			pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 
 		if (otg_disabled[i]) {
 			int opp_inst[MAX_PIPES] = { pipe->stream_res.opp->inst };
@@ -1572,7 +1582,7 @@ void dcn32_enable_phantom_streams(struct dc *dc, struct dc_state *context)
 
 #ifdef CONFIG_DRM_AMD_DC_FP
 		if (hws->funcs.resync_fifo_dccg_dio)
-			hws->funcs.resync_fifo_dccg_dio(hws, dc, context);
+			hws->funcs.resync_fifo_dccg_dio(hws, dc, context, i);
 #endif
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
index db562e45d6ff..b1563e2c0491 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.h
@@ -75,7 +75,7 @@ void dcn32_update_dsc_on_stream(struct pipe_ctx *pipe_ctx, bool enable);
 
 unsigned int dcn32_calculate_dccg_k1_k2_values(struct pipe_ctx *pipe_ctx, unsigned int *k1_div, unsigned int *k2_div);
 
-void dcn32_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context);
+void dcn32_resync_fifo_dccg_dio(struct dce_hwseq *hws, struct dc *dc, struct dc_state *context, unsigned int current_pipe_idx);
 
 void dcn32_subvp_pipe_control_lock(struct dc *dc,
 		struct dc_state *context,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index 7ac3f2a09487..7a75ff320511 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -170,7 +170,8 @@ struct hwseq_private_funcs {
 			unsigned int *k1_div,
 			unsigned int *k2_div);
 	void (*resync_fifo_dccg_dio)(struct dce_hwseq *hws, struct dc *dc,
-			struct dc_state *context);
+			struct dc_state *context,
+			unsigned int current_pipe_idx);
 	enum dc_status (*apply_single_controller_ctx_to_hw)(
 			struct pipe_ctx *pipe_ctx,
 			struct dc_state *context,
-- 
2.34.1


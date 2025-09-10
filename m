Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75CC0CAC58C
	for <amd-gfx@archiver.kernel.org>; Wed, 10 Sep 2025 05:33:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 110FD10E85E;
	Wed, 10 Sep 2025 05:33:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="eLo5V3oO";
	dkim-atps=neutral
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7586710E856
 for <amd-gfx@lists.freedesktop.org>; Wed, 10 Sep 2025 05:33:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GdNVCA+GB3Fz+DwCzldcC5tFGFBxm572xSrAY7x4S6Ftfobjgf7TFpkbAC3LLI8TLMSWTrlS+34V/TGVacJxsqNzwsYzb+pgEYF/8sW1ceYCpI2LPNt9K9pSMdlA3UmZJ+aXsABUlL9HkDHUeYxBdsC3zP8P7D+cU8zB9WcqciGXXrgC12fzwRGCRcomAbzHUTcc8fLhHeEf3I3Qyif7YXPN4WrLf5pjLW3yAJ9Zz3c4dLl6DDOUO1WkwE0TmuG7YYgograXdMt8IhXjSmwzc14C38Td+6b9AqVoofkqZ72Pn1TRSYMS1QzbSkqbiV7Rd6MVSjCDeTsJXtpGaPdPYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmmTeyUfF0mROHOg0C4Kr2OnUA4nZc+7esm7fq/pJ9Q=;
 b=JqryhffHhfg6s72fZvItQWGgtagzuBg5ONDKaSXunJH3SubP/WtSphicGpNbnNUl93xS6y3CI3C4QF6LCG5MGZtf6LpRKbowc/zkBLxlP1dnYTa6Ju+6HhlOd3X+AGmlsRHgxSfe3TJd8I2HEpYHBT+V4DoHK0YS5ToXblMDQkHjD93XleWk3uJ1PKHdzb1FTObVkZZkLCp84BSRbh/qnlqwa6S2Bx1kIaM05WX3GoYkiNCTC7HEnBy+53b3qMtQIAHv+bx/TerMu5l15Z5rJ8sjxjpojzAxN/JCQ44hXX3Wj4/bfEb/JqoyJFniJM8ZyU8Hvw3TX+nhy7fNbSSwdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmmTeyUfF0mROHOg0C4Kr2OnUA4nZc+7esm7fq/pJ9Q=;
 b=eLo5V3oONASk8OGIIWqhR1NA6ytybpvmB8Gu53igXBHVE5rCgCuWmuERf/K8QkdtFbJglYco5PAANJn+r58hDi3wdF0n/8Y3xlIN4/4WUhdWmMSFp2P7q8kQiMkiYfjpO1L2HmWGLKooMNKv5XEO3gA9/KSm/IGQyo2U6T4bJBA=
Received: from CH0PR04CA0063.namprd04.prod.outlook.com (2603:10b6:610:74::8)
 by CH3PR12MB8329.namprd12.prod.outlook.com (2603:10b6:610:12e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Wed, 10 Sep
 2025 05:33:41 +0000
Received: from DS3PEPF0000C37F.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::3) by CH0PR04CA0063.outlook.office365.com
 (2603:10b6:610:74::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9115.15 via Frontend Transport; Wed,
 10 Sep 2025 05:33:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 DS3PEPF0000C37F.mail.protection.outlook.com (10.167.23.9) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9115.13 via Frontend Transport; Wed, 10 Sep 2025 05:33:40 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 9 Sep
 2025 22:33:40 -0700
Received: from ray-Ubuntu.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 9 Sep 2025 22:33:32 -0700
From: Ray Wu <ray.wu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Alex Hung <alex.hung@amd.com>, Martin
 Leung <Martin.Leung@amd.com>, Wayne Lin <Wayne.Lin@amd.com>, Ray Wu
 <ray.wu@amd.com>
Subject: [PATCH 14/15] Revert "drm/amd/display: Reduce Stack Usage by moving
 'audio_output' into 'stream_res' v4"
Date: Wed, 10 Sep 2025 13:30:37 +0800
Message-ID: <20250910053222.2884632-15-ray.wu@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250910053222.2884632-1-ray.wu@amd.com>
References: <20250910053222.2884632-1-ray.wu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37F:EE_|CH3PR12MB8329:EE_
X-MS-Office365-Filtering-Correlation-Id: 131820c0-73fe-41ff-906c-08ddf02b99ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8f8Ra35QR2BEYiiJcH/s1kPdk2TluShLfijZRB7ZGeeH/vYKsLESKBi0daPS?=
 =?us-ascii?Q?IjWJJpdFdG/JS4TbMdvB2BMW1aRoFlr709kn8FVI9wYz0BmOc+bl9ybpcZyW?=
 =?us-ascii?Q?iB5NIJ6TB5iox5NrYcCJZKO9KfsLFdTjI8GSwqoChRaOagkimftdo5uMGxkg?=
 =?us-ascii?Q?7lbkyWq5ENWs2esfxpNxgZ+zGtZ9gMVb6etCSx0buuNM/fhlSL0HlC06hOBp?=
 =?us-ascii?Q?og5zHgdiBHAc8WiPmz8uNvsUkCJPLToTsI0LgfT57f4FJjdbR3WfphOgzpTW?=
 =?us-ascii?Q?IYPKW67mVzuJuz/4kfYwZXEtjZC/+9uvp2my725qOiWCxmzFWMF1KJjRGGls?=
 =?us-ascii?Q?OV2uzu6lOcJobs5qav4JVx3kf+dTFbV8XRLq23oNX8e84CjDAsHfXq98Zw4O?=
 =?us-ascii?Q?Ttd13PfVyp5rycU0yhN3c2tPHzv6/ii9y1OovWnLfcsfw0pfxwZUZjX//Yik?=
 =?us-ascii?Q?oHgFXmIWLzKzpVkWnWu4Qpp6gdbI4JRZnA0Xtv0ul+eE0cWRyJfaIzM8V50q?=
 =?us-ascii?Q?GLRSpoGKs1rSC3jqh1qpXZlrP/HwbmlF+u0o4DDNGShqKs18cQi89RXtswcb?=
 =?us-ascii?Q?6ZJyrk0/U/oN698QSXPFxoCU3WLu/DkIqdoLy3+1mI2kF6AeIqKzAALlI2T9?=
 =?us-ascii?Q?jxP32vdIxL2N78sUriukP2Buw9uA4n9ADT6RYRVMCyNFZHHh6joSD2b5Ymrx?=
 =?us-ascii?Q?GQfWv/wQzQFIBEcffS3pa7hxzD2mvv2BGAI0ZJCDOhDk/Po+FkLMmB79kV93?=
 =?us-ascii?Q?v7KptNzgqBavdHQEMH+pu0xwTNqEKLrsQtsl5GRyLomQeguCD6qqyyriboS4?=
 =?us-ascii?Q?OeY3kN9Jy5hMtPHkfU+GZe1TQK0iI3R8iE+xiEHZW6xP2bcPOf8M7Pe8aVOe?=
 =?us-ascii?Q?QDPpvqZM+kzF+kwlRRhSAXj+zBp/3qzIjBLSdektXitcLPUWEYlvyhilikLu?=
 =?us-ascii?Q?zzrPhg1vbd/0sQEJydCxAqXEb2uHegTv+UKTbIm7ou6anG2/tq9f5Mq+5+X2?=
 =?us-ascii?Q?zwjgzPUMU9hb7rqNpHc5BkvVD/f0B4xSd+71pad2i+zW/RZ6VXMTgwyLuc+M?=
 =?us-ascii?Q?QGHIZ2gYJZd2emlVPTcLrp47ds4BsaHsmSrAAlR/wW28x5eP2s53tul8UUzd?=
 =?us-ascii?Q?GvYLoMr0aoyx8aK9lY50RPvlNQyROIaQm81m/IhxMhXefrK7ia8tJBWhH2OV?=
 =?us-ascii?Q?T29/mLVuorOWeTWvAlSdxN0DT7EF4ctqrX0Xq6bLLmSH/m+YDDX47tEXPpeR?=
 =?us-ascii?Q?m/kP9LS8HYU/YxgQqWMzVZenS+9cvsIlhbMYVec9mjPtJF3KArURZ14VHofF?=
 =?us-ascii?Q?aBpGYmN+U9rxatlaumTH4kGZCoR2GAGazqGLAWDjGJwpjxAyYGfGOS36UK3C?=
 =?us-ascii?Q?rEtQ6DPLNBDbfFUJ/m1lmNPO3Z/3AcH7UToSo2KXBr9krBAEzifWo5wSmIhN?=
 =?us-ascii?Q?At/hmTq0HEKM0c8F52gW8473q7qJbbJn7OJ23VxxCVEAlPbZ0/+Kvehka2Tw?=
 =?us-ascii?Q?YgpPXtIHvveMJI5c21EN5emu8Mf5T3Uc1/6e?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2025 05:33:40.8138 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 131820c0-73fe-41ff-906c-08ddf02b99ac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8329
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

From: Martin Leung <Martin.Leung@amd.com>

This reverts commit 571662266db3 ("drm/amd/display: Reduce Stack Usage by moving 'audio_output' into 'stream_res' v4")

Reason for revert: Causes DP compliance errors

Acked-by: Wayne Lin <Wayne.Lin@amd.com>
Signed-off-by: Martin Leung <Martin.Leung@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
---
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 32 +++++++++++--------
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  5 ++-
 .../display/dc/link/accessories/link_dp_cts.c | 13 ++++----
 .../dc/resource/dcn31/dcn31_resource.c        |  5 +--
 .../dc/resource/dcn31/dcn31_resource.h        |  3 +-
 5 files changed, 31 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index ea904d52af20..7b4a04704312 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1601,17 +1601,19 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 	}
 
 	if (pipe_ctx->stream_res.audio != NULL) {
-		build_audio_output(context, pipe_ctx, &pipe_ctx->stream_res.audio_output);
+		struct audio_output audio_output = {0};
 
-		link_hwss->setup_audio_output(pipe_ctx, &pipe_ctx->stream_res.audio_output,
+		build_audio_output(context, pipe_ctx, &audio_output);
+
+		link_hwss->setup_audio_output(pipe_ctx, &audio_output,
 				pipe_ctx->stream_res.audio->inst);
 
 		pipe_ctx->stream_res.audio->funcs->az_configure(
 				pipe_ctx->stream_res.audio,
 				pipe_ctx->stream->signal,
-				&pipe_ctx->stream_res.audio_output.crtc_info,
+				&audio_output.crtc_info,
 				&pipe_ctx->stream->audio_info,
-				&pipe_ctx->stream_res.audio_output.dp_link_info);
+				&audio_output.dp_link_info);
 
 		if (dc->config.disable_hbr_audio_dp2)
 			if (pipe_ctx->stream_res.audio->funcs->az_disable_hbr_audio &&
@@ -2385,7 +2387,9 @@ static void dce110_setup_audio_dto(
 		if (pipe_ctx->stream->signal != SIGNAL_TYPE_HDMI_TYPE_A)
 			continue;
 		if (pipe_ctx->stream_res.audio != NULL) {
-			build_audio_output(context, pipe_ctx, &pipe_ctx->stream_res.audio_output);
+			struct audio_output audio_output;
+
+			build_audio_output(context, pipe_ctx, &audio_output);
 
 			if (dc->res_pool->dccg && dc->res_pool->dccg->funcs->set_audio_dtbclk_dto) {
 				struct dtbclk_dto_params dto_params = {0};
@@ -2396,14 +2400,14 @@ static void dce110_setup_audio_dto(
 				pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
 						pipe_ctx->stream_res.audio,
 						pipe_ctx->stream->signal,
-						&pipe_ctx->stream_res.audio_output.crtc_info,
-						&pipe_ctx->stream_res.audio_output.pll_info);
+						&audio_output.crtc_info,
+						&audio_output.pll_info);
 			} else
 				pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
 					pipe_ctx->stream_res.audio,
 					pipe_ctx->stream->signal,
-					&pipe_ctx->stream_res.audio_output.crtc_info,
-					&pipe_ctx->stream_res.audio_output.pll_info);
+					&audio_output.crtc_info,
+					&audio_output.pll_info);
 			break;
 		}
 	}
@@ -2423,15 +2427,15 @@ static void dce110_setup_audio_dto(
 				continue;
 
 			if (pipe_ctx->stream_res.audio != NULL) {
-				build_audio_output(context,
-						   pipe_ctx,
-						   &pipe_ctx->stream_res.audio_output);
+				struct audio_output audio_output = {0};
+
+				build_audio_output(context, pipe_ctx, &audio_output);
 
 				pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
 					pipe_ctx->stream_res.audio,
 					pipe_ctx->stream->signal,
-					&pipe_ctx->stream_res.audio_output.crtc_info,
-					&pipe_ctx->stream_res.audio_output.pll_info);
+					&audio_output.crtc_info,
+					&audio_output.pll_info);
 				break;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index f49549147d99..d11893f8c916 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -228,7 +228,8 @@ struct resource_funcs {
 	enum dc_status (*update_dc_state_for_encoder_switch)(struct dc_link *link,
 		struct dc_link_settings *link_setting,
 		uint8_t pipe_count,
-		struct pipe_ctx *pipes);
+		struct pipe_ctx *pipes,
+		struct audio_output *audio_output);
 };
 
 struct audio_support{
@@ -360,8 +361,6 @@ struct stream_resource {
 	uint8_t gsl_group;
 
 	struct test_pattern_params test_pattern_params;
-
-	struct audio_output audio_output;
 };
 
 struct plane_resource {
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 23f41c99fa38..9e33bf937a69 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -75,7 +75,7 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 	bool is_hpo_acquired;
 	uint8_t count;
 	int i;
-
+	struct audio_output audio_output[MAX_PIPES];
 	struct dc_stream_state *streams_on_link[MAX_PIPES];
 	int num_streams_on_link = 0;
 
@@ -101,7 +101,7 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 	if (needs_divider_update && link->dc->res_pool->funcs->update_dc_state_for_encoder_switch) {
 		link->dc->res_pool->funcs->update_dc_state_for_encoder_switch(link,
 				link_setting, count,
-				*pipes);
+				*pipes, &audio_output[0]);
 		for (i = 0; i < count; i++) {
 			pipes[i]->clock_source->funcs->program_pix_clk(
 					pipes[i]->clock_source,
@@ -113,16 +113,15 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 				const struct link_hwss *link_hwss = get_link_hwss(
 					link, &pipes[i]->link_res);
 
-				link_hwss->setup_audio_output(pipes[i],
-							      &pipes[i]->stream_res.audio_output,
-							      pipes[i]->stream_res.audio->inst);
+				link_hwss->setup_audio_output(pipes[i], &audio_output[i],
+						pipes[i]->stream_res.audio->inst);
 
 				pipes[i]->stream_res.audio->funcs->az_configure(
 						pipes[i]->stream_res.audio,
 						pipes[i]->stream->signal,
-						&pipes[i]->stream_res.audio_output.crtc_info,
+						&audio_output[i].crtc_info,
 						&pipes[i]->stream->audio_info,
-						&pipes[i]->stream_res.audio_output.dp_link_info);
+						&audio_output[i].dp_link_info);
 
 				if (link->dc->config.disable_hbr_audio_dp2 &&
 						pipes[i]->stream_res.audio->funcs->az_disable_hbr_audio &&
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index ca17e5d8fdc2..3ed7f50554e2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -2239,7 +2239,8 @@ struct resource_pool *dcn31_create_resource_pool(
 enum dc_status dcn31_update_dc_state_for_encoder_switch(struct dc_link *link,
 	struct dc_link_settings *link_setting,
 	uint8_t pipe_count,
-	struct pipe_ctx *pipes)
+	struct pipe_ctx *pipes,
+	struct audio_output *audio_output)
 {
 	struct dc_state *state = link->dc->current_state;
 	int i;
@@ -2254,7 +2255,7 @@ enum dc_status dcn31_update_dc_state_for_encoder_switch(struct dc_link *link,
 
 		// Setup audio
 		if (pipes[i].stream_res.audio != NULL)
-			build_audio_output(state, &pipes[i], &pipes[i].stream_res.audio_output);
+			build_audio_output(state, &pipes[i], &audio_output[i]);
 	}
 #else
 	/* This DCN requires rate divider updates and audio reprogramming to allow DP1<-->DP2 link rate switching,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
index 7e8fde65528f..c32c85ef0ba4 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
@@ -69,7 +69,8 @@ unsigned int dcn31_get_det_buffer_size(
 enum dc_status dcn31_update_dc_state_for_encoder_switch(struct dc_link *link,
 	struct dc_link_settings *link_setting,
 	uint8_t pipe_count,
-	struct pipe_ctx *pipes);
+	struct pipe_ctx *pipes,
+	struct audio_output *audio_output);
 
 /*temp: B0 specific before switch to dcn313 headers*/
 #ifndef regPHYPLLF_PIXCLK_RESYNC_CNTL
-- 
2.43.0


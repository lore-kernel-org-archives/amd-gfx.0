Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 582DAC83F26
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Jul 2025 09:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F067310E0A5;
	Thu, 24 Jul 2025 09:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="S2kw8v0A";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45EA310E0A5
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Jul 2025 09:34:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h78TfWudZVog2QjhC7zzjWihe4UcwG5SbOKW+5ES1B+HNBtb04vKXS0p/fwqwAD8+59D+2cj4jGyMyHjOtbiNO6MGiDfV4L5slInynF6DreynEzZFnEcByfa/vW9nL60E/C+IjmAXV1U7KEgsjcd/c3mVFBzRhIx4Ya3pQuOeaFyCvzhm5jivBdkCk+xIm7QogJ2x/PK6imU7PbBmZDfkgVdNyvXsMMTvZyhfwTQEVg1GLpgP2b7/v5Iw874RulxvxQjbWU8ZcAG07/bxC7KYV00PzVp258dqxmNz4FNwAFSbyfHKFfCmKT2HX9Wd7AkY80iibQU9SxCd2KFmqHKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdpOdPZN5j1MefjOAUA+kQYYQRP1Cx7ivHIu0J8SNZY=;
 b=fCqWDMKEqBPswxyU1Po2xEuDF6GeypdY/65V4gJkZuwh9vXsyhDuIgokYH8zzzlyP5FlQQO3a1ugELF7q1OAOmsGv/RWMKtNQfdVMzyPh8hxNNWBQVLtlVGhYMHksB93xQ7wfuAKDhOrlXLkEiUUVuz0iMxDjElFDQnzlCy5STbGgatKCCJL75GTkn4HVGIiJnIw0w/iBVIaMHGwx9Y9idHL9YB9FPaPK+6l6WGLKEw+kpgmP6OR4O6/NU+XZK2VgbUszuRCvt4kkrV7Lbt2w4bPB4NMcj4JsvWvxeUbJECLyUNLUt+XagTp1o+GNofy6Ar17KHowGq208NCsEmy8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdpOdPZN5j1MefjOAUA+kQYYQRP1Cx7ivHIu0J8SNZY=;
 b=S2kw8v0ArCIMcYJFXiEMZ95FDwb1AWbxJuVJOUVoJ56lU2mM90xkYbP/7Ce5CcRVzpBvHKThloGQpW2Z5xaYoc2WmHikH4EdiUgHNesncEazWUGQmkS8x2NecPsUFULy8g+MlYTSdZ1tBRjEj1yWHAc05DfYUkNWTOnvsWowYJw=
Received: from SA9PR13CA0128.namprd13.prod.outlook.com (2603:10b6:806:27::13)
 by CH3PR12MB8533.namprd12.prod.outlook.com (2603:10b6:610:159::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 24 Jul
 2025 09:34:41 +0000
Received: from SN1PEPF000397B1.namprd05.prod.outlook.com
 (2603:10b6:806:27:cafe::80) by SA9PR13CA0128.outlook.office365.com
 (2603:10b6:806:27::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8989.5 via Frontend Transport; Thu,
 24 Jul 2025 09:34:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF000397B1.mail.protection.outlook.com (10.167.248.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Thu, 24 Jul 2025 09:34:41 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Jul 2025 04:32:34 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Michael Strauss <michael.strauss@amd.com>, Alex Hung
 <alex.hung@amd.com>, George Shen <george.shen@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Wayne Lin <wayne.lin@amd.com>, Alvin Lee
 <Alvin.Lee2@amd.com>, Ray Wu <ray.wu@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>
Subject: [PATCH v3] drm/amd/display: Reduce Stack Usage by moving
 'audio_output' into 'stream_res' v3
Date: Thu, 24 Jul 2025 15:01:51 +0530
Message-ID: <20250724093151.1400303-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250724074833.1385215-1-srinivasan.shanmugam@amd.com>
References: <20250724074833.1385215-1-srinivasan.shanmugam@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B1:EE_|CH3PR12MB8533:EE_
X-MS-Office365-Filtering-Correlation-Id: 922da382-6b51-41d1-a7fc-08ddca9550e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FcJGdNVE2rGZdN/TsuJoTlkQP4Y/Ktx6IiGOJsypuIn6HtPuCdB+nDm7kkXH?=
 =?us-ascii?Q?sFVJRrE4k8ki2lTWCOBv2k3AnLpMz/v5YYp3aqiPm1vkliwkCktKAiB3M9YE?=
 =?us-ascii?Q?v90kldkTKXJWi6lRGmQTlNZ7A2OAeVyo9LbRHWwNuRFWrU9KycC1Gwqcw4JF?=
 =?us-ascii?Q?98hpgdAIHu6hgpd1wnaNh/Gcafuh9PHb4rLCdeqeWhEy1YUf4KSFRCJEMc1K?=
 =?us-ascii?Q?viADrMx8HrZO7wjAGhi71xcuhY/G5acFIvNMFEhA4hJlyT8ioSq72KlzIW3l?=
 =?us-ascii?Q?Uh01VMiEYwTQ6gq8Vy/hVXnOiq0EdmipLfJIJpidB25BIPhQ/tbsX1mhIA59?=
 =?us-ascii?Q?CH7gD0lsnLvf4ONzilxS7UwKveZLgjjKttN/K6CZH0QrvXJ9862H30/P0Bx1?=
 =?us-ascii?Q?myLsOkvTRF7GJUlgBfD48+SV7CBUq/X83Y+B6IXtlcUmUsT9DVRenqkWMdNX?=
 =?us-ascii?Q?gvkgnl0H2CiF2H94jv/xyUbU2PCmCadPkIcn9nOE2N7XED4Bgk5cdtEO8za1?=
 =?us-ascii?Q?c0yyIkYow5Ow/aM2A4YagOBuiGJRz8yacaWRDGWfI5WiHqq/TtgwhrXvqqi8?=
 =?us-ascii?Q?jFjtAQDIcdou0++G+bKMcsvZvNoFBMJcyPQ6mu+p++bn0S/Li+uj4C94+WpF?=
 =?us-ascii?Q?wuk8Kht09KPfhOqGCS6S6uiE1SThBJCXPG/sbZjgv2xhtWtuHV9tA9HVKBt7?=
 =?us-ascii?Q?T8rLelLe+JS0kljbgaUOj6W6tBAdCaQMFeGaNexgRx167K2tXUJYy7Yizo2V?=
 =?us-ascii?Q?mJ4LTMrrWcLtyAmPzgiogfwMQVQepMQ0JgVYUP0N894WK1uJ9Mk/lQXYojkn?=
 =?us-ascii?Q?Xp+Oy02Hw37XXCccN7uxWcE27YRUFRK9AE1aMVVofGGHsnmivTxa1HyxZPHf?=
 =?us-ascii?Q?HycNW5WKVva1uzdWeZgPwLnokcsbPLfJwigZC0ArQYXGCXAtS4eSZyxHMBh8?=
 =?us-ascii?Q?tJst6nQZLQkahxtw2bfQkFWPkOVK+eEO0GZ+lNv+V1WWWeSFPD/gNe4ZQ9Qb?=
 =?us-ascii?Q?3xe/3EIpwNMuk99gOBd977hr+B/pn7r/ITmy2BMt1i7xJJDG8SBnk+mZmm7X?=
 =?us-ascii?Q?GgY9n+GBX4SDPuQnJYje7PuamiJT59Oh7vY6A0XqXJes5+3N1fdcHzVOogE4?=
 =?us-ascii?Q?4QRocTWSrREnImIA91p5HUismrb4bT5CQehXN4bKRy3wZjREwU1H7VkbJjKe?=
 =?us-ascii?Q?sTV3cuUmtTCq2lmzbVgo2lFN4GI58UKUCNRbM10QpZS7ixEqP5LNJNuRqyPi?=
 =?us-ascii?Q?5l2Rv5q+jhH4XX+hUZ0DLelZ9x3BI5UwcFT9Mc87jLgkFgQJHOO8OyLgJdkf?=
 =?us-ascii?Q?zZBxTN6LSa2+UP/AAXmIYDwnLnrO4H9C7pcdSCo8d2HyXSQ5nrcDE1y0yvG3?=
 =?us-ascii?Q?eF5b8V5jvcyYJlWcWGrF0FMOLxNUmNHkY2atQaBMXdLnFKQLNtxZb8ADWNx9?=
 =?us-ascii?Q?xbso19Hoxxj5U1TFBFjtrzoSASZTzCWVLTZRyongDMji++xaF2VDssMWDf+/?=
 =?us-ascii?Q?NEkgr0wOXrCkbGkxTH91S6vc/06Ma+wTEgnb?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2025 09:34:41.2133 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 922da382-6b51-41d1-a7fc-08ddca9550e7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000397B1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8533
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

The function `dp_retrain_link_dp_test` currently allocates a large
audio_output array on the stack, causing the stack frame size to exceed
the compiler limit (1080 bytes > 1024 bytes).

This change prevents stack overflow issues:
amdgpu/../display/dc/link/accessories/link_dp_cts.c:65:13: warning: stack frame size (1080) exceeds limit (1024) in 'dp_retrain_link_dp_test' [-Wframe-larger-than]
static void dp_retrain_link_dp_test(struct dc_link *link,

v2: Move audio-related data like `audio_output` is kept "per pipe" to
    manage the audio for that specific display pipeline/display output path
    (stream). (Wenjing)

v3: Update in all the places where `build_audio_output` is currently
    called with a separate audio_output variable on the stack & wherever
    `audio_output` is passed to other functions
    `dce110_apply_single_controller_ctx_to_hw()` &
    `dce110_setup_audio_dto()` (like `az_configure`, `wall_dto_setup`)
    replace with usage of `pipe_ctx->stream_res.audio_output`
    to centralize audio data per pipe.

'Fixes: 9437059b4bfb ("drm/amd/display: Fix Link Override Sequencing When
Switching Between DIO/HPO")'
Cc: Wayne Lin <wayne.lin@amd.com>
Cc: George Shen <george.shen@amd.com>
Cc: Michael Strauss <michael.strauss@amd.com>
Cc: Alvin Lee <Alvin.Lee2@amd.com>
Cc: Ray Wu <ray.wu@amd.com>
Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 29 +++++++++----------
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  5 ++--
 .../display/dc/link/accessories/link_dp_cts.c | 12 ++++----
 .../dc/resource/dcn31/dcn31_resource.c        |  5 ++--
 .../dc/resource/dcn31/dcn31_resource.h        |  3 +-
 5 files changed, 26 insertions(+), 28 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 4ea13d0bf815..0846338a4b4a 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1600,19 +1600,18 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 	}
 
 	if (pipe_ctx->stream_res.audio != NULL) {
-		struct audio_output audio_output = {0};
 
-		build_audio_output(context, pipe_ctx, &audio_output);
+		build_audio_output(context, pipe_ctx, &pipe_ctx->stream_res.audio_output);
 
-		link_hwss->setup_audio_output(pipe_ctx, &audio_output,
+		link_hwss->setup_audio_output(pipe_ctx, &pipe_ctx->stream_res.audio_output,
 				pipe_ctx->stream_res.audio->inst);
 
 		pipe_ctx->stream_res.audio->funcs->az_configure(
 				pipe_ctx->stream_res.audio,
 				pipe_ctx->stream->signal,
-				&audio_output.crtc_info,
+				&pipe_ctx->stream_res.audio_output.crtc_info,
 				&pipe_ctx->stream->audio_info,
-				&audio_output.dp_link_info);
+				&pipe_ctx->stream_res.audio_output.dp_link_info);
 
 		if (dc->config.disable_hbr_audio_dp2)
 			if (pipe_ctx->stream_res.audio->funcs->az_disable_hbr_audio &&
@@ -2386,9 +2385,8 @@ static void dce110_setup_audio_dto(
 		if (pipe_ctx->stream->signal != SIGNAL_TYPE_HDMI_TYPE_A)
 			continue;
 		if (pipe_ctx->stream_res.audio != NULL) {
-			struct audio_output audio_output;
 
-			build_audio_output(context, pipe_ctx, &audio_output);
+			build_audio_output(context, pipe_ctx, &pipe_ctx->stream_res.audio_output);
 
 			if (dc->res_pool->dccg && dc->res_pool->dccg->funcs->set_audio_dtbclk_dto) {
 				struct dtbclk_dto_params dto_params = {0};
@@ -2399,14 +2397,14 @@ static void dce110_setup_audio_dto(
 				pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
 						pipe_ctx->stream_res.audio,
 						pipe_ctx->stream->signal,
-						&audio_output.crtc_info,
-						&audio_output.pll_info);
+						&pipe_ctx->stream_res.audio_output.crtc_info,
+						&pipe_ctx->stream_res.audio_output.pll_info);
 			} else
 				pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
 					pipe_ctx->stream_res.audio,
 					pipe_ctx->stream->signal,
-					&audio_output.crtc_info,
-					&audio_output.pll_info);
+					&pipe_ctx->stream_res.audio_output.crtc_info,
+					&pipe_ctx->stream_res.audio_output.pll_info);
 			break;
 		}
 	}
@@ -2426,15 +2424,16 @@ static void dce110_setup_audio_dto(
 				continue;
 
 			if (pipe_ctx->stream_res.audio != NULL) {
-				struct audio_output audio_output = {0};
 
-				build_audio_output(context, pipe_ctx, &audio_output);
+				build_audio_output(context,
+						   pipe_ctx,
+						   &pipe_ctx->stream_res.audio_output);
 
 				pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
 					pipe_ctx->stream_res.audio,
 					pipe_ctx->stream->signal,
-					&audio_output.crtc_info,
-					&audio_output.pll_info);
+					&pipe_ctx->stream_res.audio_output.crtc_info,
+					&pipe_ctx->stream_res.audio_output.pll_info);
 				break;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index f0d7185153b2..f896cce87b8d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -228,8 +228,7 @@ struct resource_funcs {
 	enum dc_status (*update_dc_state_for_encoder_switch)(struct dc_link *link,
 		struct dc_link_settings *link_setting,
 		uint8_t pipe_count,
-		struct pipe_ctx *pipes,
-		struct audio_output *audio_output);
+		struct pipe_ctx *pipes);
 };
 
 struct audio_support{
@@ -361,6 +360,8 @@ struct stream_resource {
 	uint8_t gsl_group;
 
 	struct test_pattern_params test_pattern_params;
+
+	struct audio_output audio_output;
 };
 
 struct plane_resource {
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index 2956c2b3ad1a..b12d61701d4d 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -75,7 +75,6 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 	bool is_hpo_acquired;
 	uint8_t count;
 	int i;
-	struct audio_output audio_output[MAX_PIPES];
 
 	needs_divider_update = (link->dc->link_srv->dp_get_encoding_format(link_setting) !=
 	link->dc->link_srv->dp_get_encoding_format((const struct dc_link_settings *) &link->cur_link_settings));
@@ -99,7 +98,7 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 	if (needs_divider_update && link->dc->res_pool->funcs->update_dc_state_for_encoder_switch) {
 		link->dc->res_pool->funcs->update_dc_state_for_encoder_switch(link,
 				link_setting, count,
-				*pipes, &audio_output[0]);
+				*pipes);
 		for (i = 0; i < count; i++) {
 			pipes[i]->clock_source->funcs->program_pix_clk(
 					pipes[i]->clock_source,
@@ -111,15 +110,16 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 				const struct link_hwss *link_hwss = get_link_hwss(
 					link, &pipes[i]->link_res);
 
-				link_hwss->setup_audio_output(pipes[i], &audio_output[i],
-						pipes[i]->stream_res.audio->inst);
+				link_hwss->setup_audio_output(pipes[i],
+							      &pipes[i]->stream_res.audio_output,
+							      pipes[i]->stream_res.audio->inst);
 
 				pipes[i]->stream_res.audio->funcs->az_configure(
 						pipes[i]->stream_res.audio,
 						pipes[i]->stream->signal,
-						&audio_output[i].crtc_info,
+						&pipes[i]->stream_res.audio_output.crtc_info,
 						&pipes[i]->stream->audio_info,
-						&audio_output[i].dp_link_info);
+						&pipes[i]->stream_res.audio_output.dp_link_info);
 
 				if (link->dc->config.disable_hbr_audio_dp2 &&
 						pipes[i]->stream_res.audio->funcs->az_disable_hbr_audio &&
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
index 3ed7f50554e2..ca17e5d8fdc2 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.c
@@ -2239,8 +2239,7 @@ struct resource_pool *dcn31_create_resource_pool(
 enum dc_status dcn31_update_dc_state_for_encoder_switch(struct dc_link *link,
 	struct dc_link_settings *link_setting,
 	uint8_t pipe_count,
-	struct pipe_ctx *pipes,
-	struct audio_output *audio_output)
+	struct pipe_ctx *pipes)
 {
 	struct dc_state *state = link->dc->current_state;
 	int i;
@@ -2255,7 +2254,7 @@ enum dc_status dcn31_update_dc_state_for_encoder_switch(struct dc_link *link,
 
 		// Setup audio
 		if (pipes[i].stream_res.audio != NULL)
-			build_audio_output(state, &pipes[i], &audio_output[i]);
+			build_audio_output(state, &pipes[i], &pipes[i].stream_res.audio_output);
 	}
 #else
 	/* This DCN requires rate divider updates and audio reprogramming to allow DP1<-->DP2 link rate switching,
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
index c32c85ef0ba4..7e8fde65528f 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn31/dcn31_resource.h
@@ -69,8 +69,7 @@ unsigned int dcn31_get_det_buffer_size(
 enum dc_status dcn31_update_dc_state_for_encoder_switch(struct dc_link *link,
 	struct dc_link_settings *link_setting,
 	uint8_t pipe_count,
-	struct pipe_ctx *pipes,
-	struct audio_output *audio_output);
+	struct pipe_ctx *pipes);
 
 /*temp: B0 specific before switch to dcn313 headers*/
 #ifndef regPHYPLLF_PIXCLK_RESYNC_CNTL
-- 
2.34.1


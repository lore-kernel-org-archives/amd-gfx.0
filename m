Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24DE1C87FCA
	for <amd-gfx@archiver.kernel.org>; Fri,  1 Aug 2025 12:13:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8BAE10E79A;
	Fri,  1 Aug 2025 12:13:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="J79R2YKP";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE26510E79A
 for <amd-gfx@lists.freedesktop.org>; Fri,  1 Aug 2025 12:13:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LuDolUQiLc0Vv0kE8VUXPAZ+CTkvb/UrhjLEhJDeIYzWZoQ7pSkbM8p3EdPaJN8Cc919arInvBD5A5y9+BJ5NvkF7jP3oxjI79n9IsTi1fT8BQtWtqYuLCGVNQYt/YuRhyJHIB4UpCEaQoiBDko+2UOtY+F2OPqwUHO9gcHoyrCu8jzPdzKXs3HcysEaBpLLtaWBu/yIYT/POvr9kJlyQUB3ZQordLpclyXlzJAZmjWqiAvAm/vhaoOQzR083idt6ZVHtENRJoKebNsPHCASJEDpG4bFAT9WaS5p4/YfdIInAlQrEpDxguwKvI2hFnUzMCz5Zm5Uvgwj/PYyBvUa3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oqXqagdHaQr6lxoLB0sNcW6olLwJSaojY1NHpPyAPqI=;
 b=cp+NgOpjfUXRw1vfTkUi544AW2RjhwwuQuiiFLFMOpD6jz4mj6Oa8Y0dYchkjydbvahXXccF85g4l0UHzGDLYpe1WJzX+TsKw+W1rerbzgdCPq2gnwZJTYxkDUv+DHihw5u4oCEJy0quqpRkAoMGdr4JiA7F9Y010PiB++r8nisCvyCKBVocW86aesUUO9to5TgcMw9u1OT0zzTnE44EhjUMz8yK8QEcpYqvndMBJcW37EPQ4nS0kdyKoi2Ffm3j/1crswC2v7xb/ugXN6BHd6NQwVFpo8Flic/lY7XRWfydJ31ZcsrjdAmpUbkbEjl5IAZ1UFDBh/xaHDZMm0FL3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oqXqagdHaQr6lxoLB0sNcW6olLwJSaojY1NHpPyAPqI=;
 b=J79R2YKPx4YDUwYsuCtjY6bPdbiwM9tWvzj0f1iRcAhAqGmPxmmjcfj0rAEiNoL0J2HpEYKFf+aVd/eK1ZyHLTcqRzXMUUMlfxOnGFaiMkFxLOazAKb/WCYAxQ9qrD0CHyYYrQMHc0jJcZirtNDKtdqNuwqofW7RyOm5TJgj4A4=
Received: from SJ0PR03CA0111.namprd03.prod.outlook.com (2603:10b6:a03:333::26)
 by LV9PR12MB9805.namprd12.prod.outlook.com (2603:10b6:408:2ee::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8989.17; Fri, 1 Aug
 2025 12:13:09 +0000
Received: from SJ5PEPF000001F2.namprd05.prod.outlook.com
 (2603:10b6:a03:333:cafe::56) by SJ0PR03CA0111.outlook.office365.com
 (2603:10b6:a03:333::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.25 via Frontend Transport; Fri,
 1 Aug 2025 12:13:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ5PEPF000001F2.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9009.8 via Frontend Transport; Fri, 1 Aug 2025 12:13:09 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 1 Aug 2025 07:13:05 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Alex Hung <alex.hung@amd.com>, Aurabindo Pillai
 <aurabindo.pillai@amd.com>, Jun Lei <Jun.Lei@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Michael Strauss <michael.strauss@amd.com>,
 Alvin Lee <Alvin.Lee2@amd.com>, Ivan Lipski <ivan.lipski@amd.com>
Subject: [PATCH] drm/amd/display: Move 'audio descriptor' storage from 'stream
 resource' to 'dc scratch'
Date: Fri, 1 Aug 2025 17:42:47 +0530
Message-ID: <20250801121247.3469007-1-srinivasan.shanmugam@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F2:EE_|LV9PR12MB9805:EE_
X-MS-Office365-Filtering-Correlation-Id: 53cd861d-d9b1-493c-d79f-08ddd0f4c76a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SF44efk30EljIzNlaYhFiAsJ/1TaRBR37+q/AMt26rvXpeZuD8PytjDNnX7m?=
 =?us-ascii?Q?XIZKWdEU1viXicfMUOA1lXIu8Lan2UPud0C/3bXFjKii0NEic74DHUvfLrEQ?=
 =?us-ascii?Q?Gox4r4vPB79oMqeWAPVsEuDi0Oj0ntKU07GLn9pIxOP4NWmgaanPwKaCJjOz?=
 =?us-ascii?Q?gUI/NGBE1+LFiI9tz8nUzvxjpgzSzbsL6R+Wt7D7zM2z9gJVUqai0NK39gMO?=
 =?us-ascii?Q?ah9oMmFnAPBSsi7YmWddDxYE1qAncWgK4NRqzZ/yZ5GGfT/FD4SrbQ04Tj+W?=
 =?us-ascii?Q?2VjOVFmR1XR9heFj+ks9TLFDwP+826wwahXqbstBTyKKAXNIPLgowR23WL9Z?=
 =?us-ascii?Q?Bg0UvBpkdAtEGAEt8epjD89edwOnXkCU53sywI3dH8SsN+SAwAPEa/YCOnoi?=
 =?us-ascii?Q?GLuRSnAhH+rw8dK0md3ouNQ7r9Ml/kgVYvQ28AOWSPEbcZJMhcpd/B0gNKBq?=
 =?us-ascii?Q?VvlI7tY/griYWpZjCc5A1XGpGkEjb6XigmhCH//jkHob3DNUn636tr53wfTk?=
 =?us-ascii?Q?6O+9FZvDGZ35rgriGCmDmitNA5MJcxqbn8K7VoyRRCeomDH/5TRDVy2skpzH?=
 =?us-ascii?Q?ay4jnKkVhKEdZAHO3k6wrzSflYhlxFuML9cR7EQXkTh1phRMyhGXq3I0pRHy?=
 =?us-ascii?Q?lQSmVbc47aa97v0Af0paqPZnRV02Iy21gb4zXniwUEFB8Rk8/nsH+cjnzdJp?=
 =?us-ascii?Q?RAaxSU8BFvQANt/GfSWPyldbNshSZknL/r39w5N/FARxZCJlVmSJmcVjvAV5?=
 =?us-ascii?Q?l/Uh0c8Eidq/cYY8bXo8ndImRMmi0xVPGgLJO3p4TF691dMpBE/GAGEA98E4?=
 =?us-ascii?Q?CBUY4HmFHquzTS+WVpb2uDJ/IGM6/RFjJ6drUmrDKdSL2xJj+k1cl+nyhRfA?=
 =?us-ascii?Q?59RTBkokpvDg3FwC2FCSotC1Fz2cC9jmV+0bADi07DIV+JD/tahmOQhhpYik?=
 =?us-ascii?Q?AkwJj3ca2j51nNg4igvxwATnkHa4rPZNSCiA6gwpBpSnqWY2C5KzG+06cT9v?=
 =?us-ascii?Q?Pa8zaWi2Rl7FnuB3AfnJluSbVOekgeJ8K5Ns8V98m3sWfMZx5khYwCWPxBA5?=
 =?us-ascii?Q?30M0XNeAhqD/a+j+PW0inpogQZQDIuyOkgzzDRw816uyn6F3qQSQbAcTbY4H?=
 =?us-ascii?Q?4JWeMVOmkxrvnOeUU+y52MsR6QuVBU+z1vzCgutIFKJK2Qk7ZXZwg52mTvhY?=
 =?us-ascii?Q?PxPpU0IfCWiADVp/alqnpyirvbeyRrNXab1cH/RZTGNFshtXq+gOsDRHNkrs?=
 =?us-ascii?Q?q4kNVrWuTh3KKthxEUR4ah6akCWwQ5IONyCg0F+x1AWAX8WlVd7R7flg0RmH?=
 =?us-ascii?Q?6iccTQxgW9hvIyCnfxKBl47oaYmT8Epow8p/1pRM0GwbP1d122yHtEPvRSbs?=
 =?us-ascii?Q?3FciOK96n2W8bOYFJbF1HC9blfdRETgVzUSUy3qAci4s/oBmDeVvwfQrHwIZ?=
 =?us-ascii?Q?Z7c1yIMy+i/bhvCRCU7MHrzhoz9MVPkcd0EO9LrVAqQfvgH8roFjyF/Ex0qf?=
 =?us-ascii?Q?M3l6mLXzn0ZMMA/pwIPOoLMDDpO+KHZwjsaL?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2025 12:13:09.1391 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 53cd861d-d9b1-493c-d79f-08ddd0f4c76a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9805
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

The `stream_resource` structure holds hardware parts and resources that
stay active as long as the display stream or pipe is running. It
represents the hardware state.

The `audio_output` structure is temporary. It is built and used only
during operations like dc validation and link retraining. It does not
represent permanent hardware resources.

This patch moves the audio_output descriptor from stream_res to
dc_scratch_space. This keeps temporary data separate from permanent
hardware state

'Fixes: 571662266db3 ("drm/amd/display: Reduce Stack Usage by moving
'audio_output' into 'stream_res' v4")'
Cc: Michael Strauss <michael.strauss@amd.com>
Cc: Alvin Lee <Alvin.Lee2@amd.com>
Cc: Jun Lei <Jun.Lei@amd.com>
Cc: Wenjing Liu <wenjing.liu@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Ivan Lipski <ivan.lipski@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Suggested-by: Jun Lei <Jun.Lei@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc.h           |  3 ++
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 30 +++++++++++--------
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  5 ++--
 .../display/dc/link/accessories/link_dp_cts.c | 13 +++++---
 .../dc/resource/dcn31/dcn31_resource.c        |  5 ++--
 .../dc/resource/dcn31/dcn31_resource.h        |  3 +-
 6 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 5653c1673aec..c6bfde9d3e98 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -47,6 +47,7 @@
 #include "dmub/inc/dmub_cmd.h"
 
 #include "sspl/dc_spl_types.h"
+#include "audio_types.h"
 
 struct abm_save_restore;
 
@@ -1734,6 +1735,8 @@ struct dc {
 		struct dc_stream_state temp_stream; // Used so we don't need to allocate stream on the stack
 		struct dc_link temp_link;
 		bool pipes_to_unlock_first[MAX_PIPES]; /* Any of the pipes indicated here should be unlocked first */
+		/* Pre-allocated buffer for audio_output used in dp_retrain_link_dp_test() */
+		struct audio_output audio_output[MAX_PIPES];
 	} scratch;
 
 	struct dml2_configuration_options dml2_options;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 153d68375fa3..49ad34734cef 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1586,6 +1586,7 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 		struct dc_state *context,
 		struct dc *dc)
 {
+	struct audio_output *audio_output;
 	struct dc_stream_state *stream = pipe_ctx->stream;
 	struct dc_link *link = stream->link;
 	struct drr_params params = {0};
@@ -1595,23 +1596,23 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 	const struct link_hwss *link_hwss = get_link_hwss(
 			link, &pipe_ctx->link_res);
 
-
 	if (hws->funcs.disable_stream_gating) {
 		hws->funcs.disable_stream_gating(dc, pipe_ctx);
 	}
 
 	if (pipe_ctx->stream_res.audio != NULL) {
-		build_audio_output(context, pipe_ctx, &pipe_ctx->stream_res.audio_output);
+		audio_output = &dc->scratch.audio_output[pipe_ctx->pipe_idx];
+		build_audio_output(context, pipe_ctx, audio_output);
 
-		link_hwss->setup_audio_output(pipe_ctx, &pipe_ctx->stream_res.audio_output,
+		link_hwss->setup_audio_output(pipe_ctx, audio_output,
 				pipe_ctx->stream_res.audio->inst);
 
 		pipe_ctx->stream_res.audio->funcs->az_configure(
 				pipe_ctx->stream_res.audio,
 				pipe_ctx->stream->signal,
-				&pipe_ctx->stream_res.audio_output.crtc_info,
+				&audio_output->crtc_info,
 				&pipe_ctx->stream->audio_info,
-				&pipe_ctx->stream_res.audio_output.dp_link_info);
+				&audio_output->dp_link_info);
 
 		if (dc->config.disable_hbr_audio_dp2)
 			if (pipe_ctx->stream_res.audio->funcs->az_disable_hbr_audio &&
@@ -2354,6 +2355,7 @@ static void dce110_setup_audio_dto(
 		struct dc_state *context)
 {
 	unsigned int i;
+	struct audio_output *audio_output;
 
 	/* program audio wall clock. use HDMI as clock source if HDMI
 	 * audio active. Otherwise, use DP as clock source
@@ -2385,7 +2387,8 @@ static void dce110_setup_audio_dto(
 		if (pipe_ctx->stream->signal != SIGNAL_TYPE_HDMI_TYPE_A)
 			continue;
 		if (pipe_ctx->stream_res.audio != NULL) {
-			build_audio_output(context, pipe_ctx, &pipe_ctx->stream_res.audio_output);
+			audio_output = &dc->scratch.audio_output[i];
+			build_audio_output(context, pipe_ctx, audio_output);
 
 			if (dc->res_pool->dccg && dc->res_pool->dccg->funcs->set_audio_dtbclk_dto) {
 				struct dtbclk_dto_params dto_params = {0};
@@ -2396,14 +2399,14 @@ static void dce110_setup_audio_dto(
 				pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
 						pipe_ctx->stream_res.audio,
 						pipe_ctx->stream->signal,
-						&pipe_ctx->stream_res.audio_output.crtc_info,
-						&pipe_ctx->stream_res.audio_output.pll_info);
+						&audio_output->crtc_info,
+						&audio_output->pll_info);
 			} else
 				pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
 					pipe_ctx->stream_res.audio,
 					pipe_ctx->stream->signal,
-					&pipe_ctx->stream_res.audio_output.crtc_info,
-					&pipe_ctx->stream_res.audio_output.pll_info);
+					&audio_output->crtc_info,
+					&audio_output->pll_info);
 			break;
 		}
 	}
@@ -2423,15 +2426,16 @@ static void dce110_setup_audio_dto(
 				continue;
 
 			if (pipe_ctx->stream_res.audio != NULL) {
+				audio_output = &dc->scratch.audio_output[i];
 				build_audio_output(context,
 						   pipe_ctx,
-						   &pipe_ctx->stream_res.audio_output);
+						   audio_output);
 
 				pipe_ctx->stream_res.audio->funcs->wall_dto_setup(
 					pipe_ctx->stream_res.audio,
 					pipe_ctx->stream->signal,
-					&pipe_ctx->stream_res.audio_output.crtc_info,
-					&pipe_ctx->stream_res.audio_output.pll_info);
+					&audio_output->crtc_info,
+					&audio_output->pll_info);
 				break;
 			}
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 4387de044469..df0d72b2c1b0 100644
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
index 23f41c99fa38..4af5fde2e392 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -35,6 +35,7 @@
 #include "dc_dmub_srv.h"
 #include "dce/dmub_hw_lock_mgr.h"
 #include "clk_mgr.h"
+#include "dc.h"
 
 #define DC_LOGGER \
 	link->ctx->logger
@@ -66,6 +67,7 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 			struct dc_link_settings *link_setting,
 			bool skip_video_pattern)
 {
+	struct dc *dc = (struct dc *)(unsigned long)link->dc;
 	struct pipe_ctx *pipes[MAX_PIPES];
 	struct dc_state *state = link->dc->current_state;
 	struct dc_stream_update stream_update = { 0 };
@@ -79,6 +81,9 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 	struct dc_stream_state *streams_on_link[MAX_PIPES];
 	int num_streams_on_link = 0;
 
+	/* Zero out the scratch audio output array */
+	memset((void *)dc->scratch.audio_output, 0, sizeof(dc->scratch.audio_output));
+
 	needs_divider_update = (link->dc->link_srv->dp_get_encoding_format(link_setting) !=
 	link->dc->link_srv->dp_get_encoding_format((const struct dc_link_settings *) &link->cur_link_settings));
 
@@ -101,7 +106,7 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 	if (needs_divider_update && link->dc->res_pool->funcs->update_dc_state_for_encoder_switch) {
 		link->dc->res_pool->funcs->update_dc_state_for_encoder_switch(link,
 				link_setting, count,
-				*pipes);
+				*pipes, dc->scratch.audio_output);
 		for (i = 0; i < count; i++) {
 			pipes[i]->clock_source->funcs->program_pix_clk(
 					pipes[i]->clock_source,
@@ -114,15 +119,15 @@ static void dp_retrain_link_dp_test(struct dc_link *link,
 					link, &pipes[i]->link_res);
 
 				link_hwss->setup_audio_output(pipes[i],
-							      &pipes[i]->stream_res.audio_output,
+							      &dc->scratch.audio_output[i],
 							      pipes[i]->stream_res.audio->inst);
 
 				pipes[i]->stream_res.audio->funcs->az_configure(
 						pipes[i]->stream_res.audio,
 						pipes[i]->stream->signal,
-						&pipes[i]->stream_res.audio_output.crtc_info,
+						&dc->scratch.audio_output[i].crtc_info,
 						&pipes[i]->stream->audio_info,
-						&pipes[i]->stream_res.audio_output.dp_link_info);
+						&dc->scratch.audio_output[i].dp_link_info);
 
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
2.34.1


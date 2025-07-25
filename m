Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57DD9C83F26
	for <amd-gfx@archiver.kernel.org>; Fri, 25 Jul 2025 03:46:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD09D10E0D7;
	Fri, 25 Jul 2025 03:46:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gWqIyw+2";
	dkim-atps=neutral
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0186810E0D7
 for <amd-gfx@lists.freedesktop.org>; Fri, 25 Jul 2025 03:46:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RJlj5ZjLaRvJ1+L+hTFq/tUEC+PL4ZpCUfq39J1pmJRCsBPg7cp7frb6lyqixZsbpqoucKUlqwIG2HUuXMmOL4KscJNOgEeXX+0ITvtTFtDMIBi3DWuV7mlD81cCIdiFZdo9/KEyuermEGiCIlC/8s4RRtBgvTNxdmbGRY7KVTRvCvjZ+vjWfQEOOo5fAEXkhzmdLZsizYl9xfxNuyuHlXnQ2IIjVah8trCYZDEAKAqa9tj7LriavJxyexY5qrN/eGW2KM4/fGLvxpfTFDCosA8+BRtP2s8qM0hhHw1kBiR6vJF64Mu17dlQSAqvULOMhpFLga2UkExeQERizYkx3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TK5bRTTJyB4yp4CTc9OL03BQjkmrP+xfaU/md1RfDk=;
 b=oOjC5aC7seKHam9cwjCDNrhPTeQT3XPQ5yCTl/e2aNey+bMykyGKNRN9pds7CLY8diZTqA7jACIKVZbH3iuLUAfmCDG4E8QRhCCVxAG+QLi5hcXU88yMZLbLqrB+qhlYWKpLj4SOapQGrly0DQ+hngbNdEyCUJnsogJ/v7MclZw2MtUgYViZfK4ucYLkCOc31dt4yf4OpU73hu/bv81qJ+sA6xfXyDqotPRH3T7D2ohKWdHRsiocEYfGpgdQQ7d+CmrqDeHERqmodJybvPddyE8cTmJS5TwM8GU5kCNstuDrm8QjKa2AMUQ3HhxRqbuzTV2euNnIXJGB4hwIJrzmNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TK5bRTTJyB4yp4CTc9OL03BQjkmrP+xfaU/md1RfDk=;
 b=gWqIyw+2GwCRgKJuCwD1LdEzg+VTSosoB35ae0MlCkCJ5lmKwvXVn8ZXigbdSa4q5KkFpo2Tl1CK92ISjc/36apRfNxyTZr/FyyvLb2+1U3HR1B/jhzenR7AqZDnI6sVC2csIMC/+ACC1hJzqniWXQTLJTvwiK+kXKWriyvplzc=
Received: from BN9PR03CA0152.namprd03.prod.outlook.com (2603:10b6:408:f4::7)
 by PH7PR12MB6418.namprd12.prod.outlook.com (2603:10b6:510:1fe::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Fri, 25 Jul
 2025 03:46:00 +0000
Received: from BL6PEPF0001AB77.namprd02.prod.outlook.com
 (2603:10b6:408:f4:cafe::5b) by BN9PR03CA0152.outlook.office365.com
 (2603:10b6:408:f4::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.22 via Frontend Transport; Fri,
 25 Jul 2025 03:46:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB77.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Fri, 25 Jul 2025 03:45:59 +0000
Received: from srishanm-Cloudripper.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 24 Jul 2025 22:45:55 -0500
From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
To: Aurabindo Pillai <aurabindo.pillai@amd.com>, Wenjing Liu
 <wenjing.liu@amd.com>, Michael Strauss <michael.strauss@amd.com>, Alex Hung
 <alex.hung@amd.com>, George Shen <george.shen@amd.com>
CC: <amd-gfx@lists.freedesktop.org>, Srinivasan Shanmugam
 <srinivasan.shanmugam@amd.com>, Wayne Lin <wayne.lin@amd.com>, Alvin Lee
 <Alvin.Lee2@amd.com>, Ray Wu <ray.wu@amd.com>, Harry Wentland
 <harry.wentland@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, Roman Li
 <roman.li@amd.com>
Subject: [PATCH v4] drm/amd/display: Reduce Stack Usage by moving
 'audio_output' into 'stream_res' v4
Date: Fri, 25 Jul 2025 09:15:34 +0530
Message-ID: <20250725034534.1403158-1-srinivasan.shanmugam@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB77:EE_|PH7PR12MB6418:EE_
X-MS-Office365-Filtering-Correlation-Id: e28ae176-8ba2-4d0b-ff63-08ddcb2dc4df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cs8b8T0JWRkoayM4MAnB9fn+RGvd92Rs5HDd0NdHm0oPQGfsr6sJ6lWhjv5Q?=
 =?us-ascii?Q?ELsSPMN4O8fBjY4iTTW4cmV/Kh+pCoz1JcOXLajM6jLznPf+VE3HxGPgcM7B?=
 =?us-ascii?Q?chgt/NeJGwH/j3/B1+qW02E+AxHkC+YZ28xLV0aFE12+a1JwVWmKDHVs75is?=
 =?us-ascii?Q?xSpEql94G27+x8UbtKGMBPUQ5ugt4CRXx0elfUTlXBNj+FbLE322NI/Hqikr?=
 =?us-ascii?Q?LDh8xReaIm/dQmkxi9NMNWNAcpHbNMjQAIn4DaNGumzWv9GhhwgFAEtf5zc1?=
 =?us-ascii?Q?4BurHJNsiauHBytT4f2ba2c6UzvaXjWDfrgbHQi5arWBF1wQNtTVKirOt5HD?=
 =?us-ascii?Q?S8vDfwuHp2wGHLJtc16FSZGJw5tw15W/bcJZ7WRynGy0VljXNF2+f2tFr5Fg?=
 =?us-ascii?Q?DwGvoXIRnG7jzfNVxscp7B3Xlp917jj36WPuik6vvSh6Qp3yiXaSIQvZgArP?=
 =?us-ascii?Q?iSA3RPpmUgutGFSQV6SVLiCBaVKiScAwD8mscBiqna80LBV7J7RoXu7/KZAD?=
 =?us-ascii?Q?/2HQt5hJ2HIyZUZUkSnO3zuvr3LQHNuhglHEmH5Hn/CWMWzxkaL1HpAGz0vR?=
 =?us-ascii?Q?y04vyGYYSEmctHp5wu2Bav4i9UuC+dX+IFMNHtM72RdzvFPQtRdAqzBCofb8?=
 =?us-ascii?Q?N3Cy2ITACxddjxoC1twi+Np5l+w10zqjw1SkLzuQbpTws52mxMH6TAzkPDbF?=
 =?us-ascii?Q?4EceO2wv0UEJLtZJIKuT7UFcjC0rWjTEf9sK9iDyKQQROfLJjm+qeq8LmMHI?=
 =?us-ascii?Q?t9U5iTht7T/XYsQI/KEFOF2y9MHOv/UQtJn42NeF1RAw6X9xneWRWLU/pQiE?=
 =?us-ascii?Q?InTYOq878EF5ChPCFgYYv3umlciIs95NhgqJpry5K5q6RhTgDAx20dOmOrCJ?=
 =?us-ascii?Q?3YQ3WGrw5VIYrvCKI+KPwm7EgWls733IfTn21GKqwnhW9RyOKTA6x4JafdmB?=
 =?us-ascii?Q?gEN06GBeM/hcCsYCW6kqbzimtf1Gviu1akLxqq8g4tQrobagsmsIKrLtBu/p?=
 =?us-ascii?Q?V5cbHs1cLU3QIDwrTGNeFfX0iQ3TWNG6ozXQYovkvFeFZS8AQHG59aT/obiB?=
 =?us-ascii?Q?JV2xb79GCBrUZwLkaVFZfZPrT3TVsFG1h/eFmJh28Fg1WouzvGSBMfJoFXlO?=
 =?us-ascii?Q?kiJK4BpWKxA7gDWo3z47sjSHP+0RjkPj5FT31RJWFnw8BTB3mP+F0OySXyxQ?=
 =?us-ascii?Q?/QreCjiQBpqHu2rQhp9dlUgS8bwoDFuz+FzveWfcDDBxYYuCTu5Jog41Lxzk?=
 =?us-ascii?Q?2TpVnoiUtv3I2EBWenYniURv1xjvfM/AnX5NqKQn/SaR4zCQREIOE9gkRXnw?=
 =?us-ascii?Q?Uc/3r/6N/wVKSUyPe1ovcA2uH71YYFBbRER921yu6HIi0PsL1wIv85Hmaym3?=
 =?us-ascii?Q?nXjx4n7J6iEiN8elbpTuiHuHLnol0353co/KSPOV0yjlI7ls7XaP9rK49cz6?=
 =?us-ascii?Q?ZC+dEoZfw8QpUJxCIxTxIhJb5T3wfPbbqR5VRmTjtQmjypTa+lS63NrrXRGp?=
 =?us-ascii?Q?/ZRfuKsEe3qU4I9jaqyp2FOF9xSEufUf9ByK?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2025 03:45:59.3019 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e28ae176-8ba2-4d0b-ff63-08ddcb2dc4df
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB77.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6418
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

v4: Remove empty lines before `build_audio_output`. (Alex)

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
 .../amd/display/dc/hwss/dce110/dce110_hwseq.c | 32 ++++++++-----------
 .../gpu/drm/amd/display/dc/inc/core_types.h   |  5 +--
 .../display/dc/link/accessories/link_dp_cts.c | 12 +++----
 .../dc/resource/dcn31/dcn31_resource.c        |  5 ++-
 .../dc/resource/dcn31/dcn31_resource.h        |  3 +-
 5 files changed, 26 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
index 4ea13d0bf815..c69194e04ff9 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1600,19 +1600,17 @@ enum dc_status dce110_apply_single_controller_ctx_to_hw(
 	}
 
 	if (pipe_ctx->stream_res.audio != NULL) {
-		struct audio_output audio_output = {0};
+		build_audio_output(context, pipe_ctx, &pipe_ctx->stream_res.audio_output);
 
-		build_audio_output(context, pipe_ctx, &audio_output);
-
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
@@ -2386,9 +2384,7 @@ static void dce110_setup_audio_dto(
 		if (pipe_ctx->stream->signal != SIGNAL_TYPE_HDMI_TYPE_A)
 			continue;
 		if (pipe_ctx->stream_res.audio != NULL) {
-			struct audio_output audio_output;
-
-			build_audio_output(context, pipe_ctx, &audio_output);
+			build_audio_output(context, pipe_ctx, &pipe_ctx->stream_res.audio_output);
 
 			if (dc->res_pool->dccg && dc->res_pool->dccg->funcs->set_audio_dtbclk_dto) {
 				struct dtbclk_dto_params dto_params = {0};
@@ -2399,14 +2395,14 @@ static void dce110_setup_audio_dto(
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
@@ -2426,15 +2422,15 @@ static void dce110_setup_audio_dto(
 				continue;
 
 			if (pipe_ctx->stream_res.audio != NULL) {
-				struct audio_output audio_output = {0};
-
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


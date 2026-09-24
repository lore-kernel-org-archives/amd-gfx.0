Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42CF0C98325
	for <amd-gfx@archiver.kernel.org>; Thu, 24 Sep 2026 18:46:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 41E4E10F738;
	Thu, 24 Sep 2026 18:46:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="rsR3Qq3x";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012024.outbound.protection.outlook.com
 [40.93.195.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DD4910F728
 for <amd-gfx@lists.freedesktop.org>; Thu, 24 Sep 2026 18:46:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y9gSSjOwfq15xBRNS7jPQU+CfXjV65ovsGyobvWp29kx9wbMwlLR60B5Q0b327AaXjRBciFs1JrIkEHCLrYBJ14SVwZLQCVZUMquPq2JCx2SxDt0pJE9un035TYyjdK5o8IrvBFnhdZk49rGe+GWapheQTOHmRLOtfzErC82JUKVU6X+RHhfCdLyom/8CeO2UsWfZpND/SZPCkTN+6Co+MUpbuRgNwXNzXRSFoGEFQbCfH0ONVRvHbze1fAMwenssqrkgS/5lfSTiFP0BgItSHp9C7ybFEidEybMNzyWYWEivJrXOE8T+Ctfgsk3npkHfFhvO+r6hBrrSxObZSI3qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k0u6jhs8W9PA0kve5FzyY1i4sjlI5g8hSod9r4j0grQ=;
 b=dwsJFfrTIHGfWx9sE1cn+/yYdPf4AKZdchi4BaK6UDa3+Ztj+RZqenaf5XG0qBiY3DU1rTnZhIZHOeEH9rxDPvfR6DM7KdnrHXA5+jy2eciM4dqVYJqka9SW/iNlx8l6Jkl018AsQphtAlPE0vFFvq0arIbq9xJ+mlxzXrSsNki5Kf6V+EfXEZIGBG+HxFb10vKrrvFqXVp12Hvu/7Movq9ryVHGEESZw3bu9480Xo6IPh3z7Yxa42oAUUJCpNu2cLAndyKhi2AYvFpTDFVHImVlFqouizK6B43d7/D9VpnM4+NzQC28aev+vlYXXGBgJXRXmFwh2wLpNDAkHVENKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k0u6jhs8W9PA0kve5FzyY1i4sjlI5g8hSod9r4j0grQ=;
 b=rsR3Qq3xaICBXb1uYZ4n/jgsyQOuCQBgeTQPpcVSo8xXUeQP4izrHLByUBSVhr8KAF5G2jrtomehsNS2sYngiyh8cqyWQdlwPY/LbTNHmUwTmfcwrVn1bbMKJ/jBnixODvVi8vfi2vxBAsPgI0G2TIiYTxG4oStH+wWrEOSP8Wc=
Received: from PH8P221CA0021.NAMP221.PROD.OUTLOOK.COM (2603:10b6:510:2d8::22)
 by DM4PR12MB5914.namprd12.prod.outlook.com (2603:10b6:8:67::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 24 Sep
 2026 18:46:29 +0000
Received: from SJ1PEPF00002316.namprd03.prod.outlook.com
 (2603:10b6:510:2d8:cafe::5c) by PH8P221CA0021.outlook.office365.com
 (2603:10b6:510:2d8::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.18 via Frontend Transport; Thu,
 24 Sep 2026 18:46:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00002316.mail.protection.outlook.com (10.167.242.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Thu, 24 Sep 2026 18:46:28 +0000
Received: from jzuo.laptop (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 24 Sep
 2026 13:46:13 -0500
From: Fangzhi Zuo <jerry.zuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Dan Wheeler <daniel.wheeler@amd.com>, Ray Wu
 <Ray.Wu@amd.com>, Ivan Lipski <ivan.lipski@amd.com>, Alex Hung
 <alex.hung@amd.com>, James Lin <PingLei.Lin@amd.com>, Chenyu Chen
 <Chen-Yu.Chen@amd.com>, Piotr Maziarz <piotr.maziarz@amd.com>, Alvin Lee
 <alvin.lee2@amd.com>
Subject: [PATCH 17/34] drm/amd/display: Flatten OPP_SET_DISP_PATTERN_GENERATOR
 parameters
Date: Thu, 24 Sep 2026 14:45:30 -0400
Message-ID: <20260924184824.596894-18-jerry.zuo@amd.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924184824.596894-1-jerry.zuo@amd.com>
References: <20260924184824.596894-1-jerry.zuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002316:EE_|DM4PR12MB5914:EE_
X-MS-Office365-Filtering-Correlation-Id: f89134ed-617f-49c4-33ab-08df1a6c250d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|6133799003|18002099003|22082099003|10067099003|11063799006|56012099006|3023799007;
X-Microsoft-Antispam-Message-Info: ov7NksJITLTlZij/5AaYpC1uCQ5CdvIwXARx2Dct5O1qls1yaqJR7w1KOdnLHx5yeOkcBi8CCy2t0KzPHcpZ2i2UZQpcwdE43p9eb0SXw5S7bGrfDlyRKruLEIyED2d2CtrEY3FfHhYkjSMA5E2almAl80IgdaIdPpDgHQ1bxP8U7x6Cc1ghKSwlcRhlcC4IilEq4m2r8W9DXOuzgtGd1Q1rulpPgQnbkc0esjFnKKwkM9jkbTRb+IczlHfJ062T1te+VvVPye3NA9jnvjzEhi+gZYbgh8kDDaiElBCQZJQfzxJxJQVeG99J8NeJMdauHsCjvxFmrBgrTKIjCgqoFL5dEeksxxQlr/PpjYprxQ7jOG8ZE4M9F1/IRTS8HMeciMZLFQAU5XiV4N51NSqyn5JhmBHGRZroI7z3qggLIWHmxC5kDTdkGev58s1uuDhfrBhv5F4G9sHKwgiL/CFG79PpG24HsDPKHG5alkMh0u6TY1pI/s3gh6PFomrbEPc6vbrY381rusOKf3b3TMQkQBneEUgdCVW465huih7wWK8XjKVPzqm5MTXjD8t2R2NFAIm76VEJpV5e9z5jORm9t4LIl4Efygozpf3LRNDtqx01kFpekLjPK6Ky385alOmphQCYdxYlh/A4aaBhAw/y2uv0fEOji3T9O2CVyhEDvOmTk1aPes+SAnLDdkcDmcbDr9jVHAZJ6ENQkqoDfkHknA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 5zS28asynBlrAQ7g5ckFdJOpzAzGcTpU1SIfb2ScvIBAluSE2359Zi7aFtGkVbRYk0KAhmZZHc8zxtZphCiat1UEGRyV0jS9ytFXOTb3t4hAsVqd3NRxiV4Y/JR08EBIFMdiRHRxCmv76FUFhEB66K3cgI/k1vjw7EhpUqWwoY9d/ZZJcxKg7FByf/glJWyQKUU5Z9Kmow5YasbQu182vFZIBEDfR2J3cKGqDXy3rWHbVFgQVoQKzQ/vOeXP7rchgQ3ZEgpAOmcsxeklPUOShe3f8wP0otb96MpPXJsS+iTAbkccwqn/jG2w1lqHTb/I/TuqzJIs+XtSbpS4ETTjyHS86PKeWIgURGT2zbSEbjXtbkBNLxya4x7MNhi4byn+vXQu00SE+R2w7S0yZEwRTz2aOlEahov7FFL9w+STzUZJUoMp3JRFgXH0Tyf0atPl
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2026 18:46:28.9050 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f89134ed-617f-49c4-33ab-08df1a6c250d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002316.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5914
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

From: Piotr Maziarz <piotr.maziarz@amd.com>

[WHY]
opp2_set_disp_pattern_generator read
debug.disable_dynamic_expansion_for_test_pattern through opp->ctx->dc while
the sequence was executing. A block sequence operation must take its inputs
from a flat parameter list resolved during the build phase, so this hid an
input from the recorded sequence and left the FMT_DYNAMIC_EXP_CNTL branch
unreachable from the OPP unit tests.

[HOW]
Added disable_dyn_exp_for_test_pattern to
opp_funcs::opp_set_disp_pattern_generator and to
opp_set_disp_pattern_generator_params, and updated every caller to pass
dc->debug.disable_dynamic_expansion_for_test_pattern explicitly. Updated
the unit test mocks and the core_gtest dumper, and extended opp_gtest to
cover both values of the new flag.

Signed-off-by: Piotr Maziarz <piotr.maziarz@amd.com>
Signed-off-by: Fangzhi Zuo <jerry.zuo@amd.com>
Reviewed-by: Alvin Lee <alvin.lee2@amd.com>
---
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 38 ++++++++++++-------
 .../amd/display/dc/hwss/dcn20/dcn20_hwseq.c   | 10 +++--
 .../amd/display/dc/hwss/dcn201/dcn201_hwseq.c |  3 +-
 .../amd/display/dc/hwss/dcn30/dcn30_hwseq.c   |  4 +-
 .../amd/display/dc/hwss/dcn32/dcn32_hwseq.c   |  6 ++-
 .../amd/display/dc/hwss/dcn401/dcn401_hwseq.c |  9 +++--
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  4 +-
 drivers/gpu/drm/amd/display/dc/inc/hw/opp.h   |  3 +-
 .../drm/amd/display/dc/opp/dcn20/dcn20_opp.c  |  5 ++-
 .../drm/amd/display/dc/opp/dcn20/dcn20_opp.h  |  3 +-
 10 files changed, 54 insertions(+), 31 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index 28897addb553..e1d6e31af657 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -3537,10 +3537,12 @@ void hwss_opp_set_disp_pattern_generator(union block_sequence_params *params)
 	int width = params->opp_set_disp_pattern_generator_params.width;
 	int height = params->opp_set_disp_pattern_generator_params.height;
 	int offset = params->opp_set_disp_pattern_generator_params.offset;
+	bool disable_dyn_exp =
+		params->opp_set_disp_pattern_generator_params.disable_dyn_exp_for_test_pattern;
 
 	if (opp && opp->funcs->opp_set_disp_pattern_generator) {
 		opp->funcs->opp_set_disp_pattern_generator(opp, test_pattern, color_space,
-			color_depth, solid_color, width, height, offset);
+			color_depth, solid_color, width, height, offset, disable_dyn_exp);
 	}
 }
 
@@ -4862,19 +4864,27 @@ void hwss_add_opp_set_disp_pattern_generator(struct block_sequence_state *seq_st
 		bool use_solid_color,
 		int width,
 		int height,
-		int offset)
-{
-	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
-		seq_state->steps[*seq_state->num_steps].func = OPP_SET_DISP_PATTERN_GENERATOR;
-		seq_state->steps[*seq_state->num_steps].params.opp_set_disp_pattern_generator_params.opp = opp;
-		seq_state->steps[*seq_state->num_steps].params.opp_set_disp_pattern_generator_params.test_pattern = test_pattern;
-		seq_state->steps[*seq_state->num_steps].params.opp_set_disp_pattern_generator_params.color_space = color_space;
-		seq_state->steps[*seq_state->num_steps].params.opp_set_disp_pattern_generator_params.color_depth = color_depth;
-		seq_state->steps[*seq_state->num_steps].params.opp_set_disp_pattern_generator_params.solid_color = solid_color;
-		seq_state->steps[*seq_state->num_steps].params.opp_set_disp_pattern_generator_params.use_solid_color = use_solid_color;
-		seq_state->steps[*seq_state->num_steps].params.opp_set_disp_pattern_generator_params.width = width;
-		seq_state->steps[*seq_state->num_steps].params.opp_set_disp_pattern_generator_params.height = height;
-		seq_state->steps[*seq_state->num_steps].params.opp_set_disp_pattern_generator_params.offset = offset;
+		int offset,
+		bool disable_dyn_exp_for_test_pattern)
+{
+	if (*seq_state->num_steps < MAX_HWSS_BLOCK_SEQUENCE_SIZE) {
+		struct block_sequence *step = &seq_state->steps[*seq_state->num_steps];
+		union block_sequence_params *step_params = &step->params;
+		struct opp_set_disp_pattern_generator_params *pattern_params =
+			&step_params->opp_set_disp_pattern_generator_params;
+
+		step->func = OPP_SET_DISP_PATTERN_GENERATOR;
+		pattern_params->opp = opp;
+		pattern_params->test_pattern = test_pattern;
+		pattern_params->color_space = color_space;
+		pattern_params->color_depth = color_depth;
+		pattern_params->solid_color = solid_color;
+		pattern_params->use_solid_color = use_solid_color;
+		pattern_params->width = width;
+		pattern_params->height = height;
+		pattern_params->offset = offset;
+		pattern_params->disable_dyn_exp_for_test_pattern =
+				disable_dyn_exp_for_test_pattern;
 		(*seq_state->num_steps)++;
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
index 45a4a7707507..f408589072d7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -458,7 +458,8 @@ void dcn20_init_blank(
 			&black_color,
 			otg_active_width,
 			otg_active_height,
-			0);
+			0,
+			dc->debug.disable_dynamic_expansion_for_test_pattern);
 
 	if (num_opps == 2) {
 		bottom_opp->funcs->opp_set_disp_pattern_generator(
@@ -469,7 +470,8 @@ void dcn20_init_blank(
 				&black_color,
 				otg_active_width,
 				otg_active_height,
-				0);
+				0,
+				dc->debug.disable_dynamic_expansion_for_test_pattern);
 	}
 
 	hws->funcs.wait_for_blank_complete(opp);
@@ -3339,7 +3341,7 @@ void dcn20_set_disp_pattern_generator(const struct dc *dc,
 		const struct tg_color *solid_color,
 		int width, int height, int offset)
 {
-	(void)dc;
 	pipe_ctx->stream_res.opp->funcs->opp_set_disp_pattern_generator(pipe_ctx->stream_res.opp, test_pattern,
-			color_space, color_depth, solid_color, width, height, offset);
+			color_space, color_depth, solid_color, width, height, offset,
+			dc->debug.disable_dynamic_expansion_for_test_pattern);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
index c22587188c98..d34f63432c6b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn201/dcn201_hwseq.c
@@ -214,7 +214,8 @@ void dcn201_init_blank(
 			&black_color,
 			otg_active_width,
 			otg_active_height,
-			0);
+			0,
+			dc->debug.disable_dynamic_expansion_for_test_pattern);
 
 	hws->funcs.wait_for_blank_complete(opp);
 }
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
index 79f40b483caf..35d5cce0a791 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn30/dcn30_hwseq.c
@@ -1245,9 +1245,9 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
 		const struct tg_color *solid_color,
 		int width, int height, int offset)
 {
-	(void)dc;
 	pipe_ctx->stream_res.opp->funcs->opp_set_disp_pattern_generator(pipe_ctx->stream_res.opp, test_pattern,
-			color_space, color_depth, solid_color, width, height, offset);
+			color_space, color_depth, solid_color, width, height, offset,
+			dc->debug.disable_dynamic_expansion_for_test_pattern);
 }
 
 void dcn30_prepare_bandwidth(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
index 5de38b86cb54..8e45ad4191c7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn32/dcn32_hwseq.c
@@ -1754,7 +1754,8 @@ void dcn32_init_blank(
 				&black_color,
 				otg_active_width,
 				otg_active_height,
-				0);
+				0,
+				dc->debug.disable_dynamic_expansion_for_test_pattern);
 
 	if (num_opps == 2) {
 		if (bottom_opp && bottom_opp->funcs->opp_set_disp_pattern_generator) {
@@ -1766,7 +1767,8 @@ void dcn32_init_blank(
 					&black_color,
 					otg_active_width,
 					otg_active_height,
-					0);
+					0,
+					dc->debug.disable_dynamic_expansion_for_test_pattern);
 			hws->funcs.wait_for_blank_complete(bottom_opp);
 		}
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
index 1d53240cd736..c82f941f42ec 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn401/dcn401_hwseq.c
@@ -2575,7 +2575,8 @@ void dcn401_program_pipe_sequence(
 			false,
 			pipe_ctx->stream_res.test_pattern_params.width,
 			pipe_ctx->stream_res.test_pattern_params.height,
-			pipe_ctx->stream_res.test_pattern_params.offset);
+			pipe_ctx->stream_res.test_pattern_params.offset,
+			dc->debug.disable_dynamic_expansion_for_test_pattern);
 	}
 
 	if (pipe_ctx->plane_state
@@ -3364,7 +3365,8 @@ void dcn401_blank_pixel_data_sequence(
 			true,
 			odm_slice_src.width,
 			odm_slice_src.height,
-			odm_slice_src.x);
+			odm_slice_src.x,
+			dc->debug.disable_dynamic_expansion_for_test_pattern);
 
 		odm_pipe = odm_pipe->next_odm_pipe;
 	}
@@ -3381,7 +3383,8 @@ void dcn401_blank_pixel_data_sequence(
 		true,
 		odm_slice_src.width,
 		odm_slice_src.height,
-		odm_slice_src.x);
+		odm_slice_src.x,
+		dc->debug.disable_dynamic_expansion_for_test_pattern);
 
 	/* Handle ABM level setting when not blanking */
 	if (!blank) {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 7c5f88bf44c7..d7ab21c5a1e4 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -429,6 +429,7 @@ struct opp_set_disp_pattern_generator_params {
 	int width;
 	int height;
 	int offset;
+	bool disable_dyn_exp_for_test_pattern;
 };
 
 struct set_abm_pipe_params {
@@ -2349,7 +2350,8 @@ void hwss_add_opp_set_disp_pattern_generator(struct block_sequence_state *seq_st
 		bool use_solid_color,
 		int width,
 		int height,
-		int offset);
+		int offset,
+		bool disable_dyn_exp_for_test_pattern);
 
 void hwss_add_opp_program_bit_depth_reduction(struct block_sequence_state *seq_state,
 		struct output_pixel_processor *opp,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
index f2d16d88b0bc..73aaa2629315 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/opp.h
@@ -340,7 +340,8 @@ struct opp_funcs {
 			const struct tg_color *solid_color,
 			int width,
 			int height,
-			int offset);
+			int offset,
+			bool disable_dyn_exp_for_test_pattern);
 
 	void (*opp_program_dpg_dimensions)(
 				struct output_pixel_processor *opp,
diff --git a/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c b/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c
index 8486175a3b56..544ff2bf7100 100644
--- a/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c
+++ b/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.c
@@ -47,7 +47,8 @@ void opp2_set_disp_pattern_generator(
 		const struct tg_color *solid_color,
 		int width,
 		int height,
-		int offset)
+		int offset,
+		bool disable_dyn_exp_for_test_pattern)
 {
 	struct dcn20_opp *oppn20 = TO_DCN20_OPP(opp);
 	enum test_pattern_color_format bit_depth;
@@ -89,7 +90,7 @@ void opp2_set_disp_pattern_generator(
 	break;
 	}
 
-	if (opp->ctx->dc->debug.disable_dynamic_expansion_for_test_pattern) {
+	if (disable_dyn_exp_for_test_pattern) {
 		switch (test_pattern) {
 		case CONTROLLER_DP_TEST_PATTERN_COLORSQUARES:
 		case CONTROLLER_DP_TEST_PATTERN_COLORSQUARES_CEA:
diff --git a/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.h b/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.h
index 8944fa6c8f79..62e8d5078ffb 100644
--- a/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.h
+++ b/drivers/gpu/drm/amd/display/dc/opp/dcn20/dcn20_opp.h
@@ -152,7 +152,8 @@ void opp2_set_disp_pattern_generator(
 	const struct tg_color *solid_color,
 	int width,
 	int height,
-	int offset);
+	int offset,
+	bool disable_dyn_exp_for_test_pattern);
 
 void opp2_program_dpg_dimensions(
 		struct output_pixel_processor *opp,
-- 
2.53.0


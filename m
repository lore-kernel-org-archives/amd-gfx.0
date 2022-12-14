Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1505BC4332F
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Dec 2022 20:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E67C810E480;
	Wed, 14 Dec 2022 20:22:43 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2073.outbound.protection.outlook.com [40.107.212.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 838B010E477
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Dec 2022 20:22:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HBEYUpX9AThXHGR+99PC6LMqoRU37xTaGWLJF+X7dOmmk6ZFRMPmbCDofin+zyRcmRpI4t60/N70tb9T0V+NA7Fc7DbmAwCUgN4YAkqGDPqORCU94N0y9qpMbmZ8d9TRWpx3HPcO/ALsF4kqe8svK+rA6eE2rcVNjEbGZz3Hy7W4NaK5r6t4Rhmzg7CyQ3MsJ2Qc73HiwIoV2kXfDxdqne5GgRjgFn/NxjK2OU3gzCX+PWxsPABJ2hahzmqPFL/L+MxaqMRkOXEKbTh5MiUXtLNUhAEqfUZJ7QwCDjqfCxmGWTBmAp5YAFcmmwbEoxsXgOpPb2frOAP2y0vH69/1iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzmUaamKwmYLcge/qe7WZOhP47d/6d61qZb0spMRuEo=;
 b=JbBz9Kf5n9B/lYqQMZ57gMDSZls32lKirnlbJOTNcGpCqKB6QH72bccjZ5a2Kb8agq4kbJNw9/QIJ4nlFrEzAinl+PsZuOEI+meMfL+LeKfgeMuvdrOkGoSStTsBJLmx02dINYs0D6eSoKlszogosS8Q08yjj52RWWuH6BXbJmKFAeRnKImEnQgm59Z18HZGShqlOSJWE+eJdmfj81OZRB8/ExX8yw9+UIX3ewimgEivt8WQMzZxMEYLBaO62zW2/dOXS9uL1eOP0LFDRWCrpTUkMHDiUMAsvs5m1trThgYMDM6DiCNImQcnaA6s/OEJD740yaOeIrNgMBr0KWZrCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzmUaamKwmYLcge/qe7WZOhP47d/6d61qZb0spMRuEo=;
 b=yEvjPSVdzn28LyLTaA4r/q85V3i0O0Ain4daINgZNbdVH3Cy/U7c5nMWn1nUf6fPtsP1WlW394rD2cIH/z60lq5cjbEOPaq68zG/EzXE/L+G1/C/vuyCT7MdKeXvXL+rW2AucvGCnrWA+A0BkN5scaNdSXLJN2e+CaCEqBQcum4=
Received: from MW4PR03CA0093.namprd03.prod.outlook.com (2603:10b6:303:b7::8)
 by BY5PR12MB4965.namprd12.prod.outlook.com (2603:10b6:a03:1c4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.19; Wed, 14 Dec
 2022 20:22:06 +0000
Received: from CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:b7:cafe::f3) by MW4PR03CA0093.outlook.office365.com
 (2603:10b6:303:b7::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.11 via Frontend
 Transport; Wed, 14 Dec 2022 20:22:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT060.mail.protection.outlook.com (10.13.175.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5924.11 via Frontend Transport; Wed, 14 Dec 2022 20:22:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Wed, 14 Dec
 2022 14:22:03 -0600
Received: from aaurabin-elitedesk-arch.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34
 via Frontend Transport; Wed, 14 Dec 2022 14:22:02 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/18] drm/amd/display: allow hpo and dio encoder switching
 during dp retrain test
Date: Wed, 14 Dec 2022 15:21:36 -0500
Message-ID: <20221214202141.1721178-14-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
References: <20221214202141.1721178-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT060:EE_|BY5PR12MB4965:EE_
X-MS-Office365-Filtering-Correlation-Id: 64f4350b-deba-4d58-f939-08dade10deb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TXL3EUpbviSrDsxPwofqBaMhcaxxOdFrYLKUzNfToglaUjPKc1W8lwaR11wZsUP2a/rDVXxI8UqB1Q54MpyQNuST9cmx9e9hM3+TggROWl6BttvnWd854/40O7M7/Lp1PSmjSX0dXNdZK2VvFHTmguYJF+EULxcHH3oT8buViRWK0KAJ677/nFiIZt6s33DvhveZE/MixNmkm2KZTv+VHGMi546bL3sAsi8j58zOXtWm8OATpWWhLS6KGlS7hAhlDF4zmrWDN+xgjAILLEPVr/KfomkW59i6sDBhDythx6j9ASkFJeQNe8h0dnqqYNQ1/eUiMy00+YvAem56j/tl4aAIvK5nWwJUm4es1PlOQH75Sa9TAkW/nUlt7xphw3sasxjNO/+XGbjZ50THYsDOv51vs9qaunnNNLGChz4Nre+gs5ASyJYdjAqWDJ9fvJjmOPk6+nULSSQaMQIP5zGXGz6B0OWMZK1NgIZjAxk+Kaxp/YQa3E9R9BFrhKSI2ZPZXT5LMJpehG27miQoC1hXAD9GtM7boHESc+qh22nNgrrTGSYMpvTF5FKkizx7tqEJ5j7huFLIGVeCvoSXJWvK/HC+5r8o1XROOwfilrxxAvkr+VwFLswpigBTLuJB+E7En+NPd65puvpxeX/IMiVCrcUWA4ssLvA4TUmgvGUXDj38Tghgg953+k+X5fwB3xz83DGiHFNt981Fq+A33LhxOa6MPGJob7jvAlk/yNv+ofo=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:CA; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(136003)(396003)(346002)(376002)(39860400002)(451199015)(36840700001)(40470700004)(46966006)(82740400003)(81166007)(2906002)(40480700001)(44832011)(36860700001)(8676002)(426003)(6666004)(86362001)(7696005)(82310400005)(70586007)(8936002)(54906003)(5660300002)(4326008)(316002)(478600001)(26005)(70206006)(6916009)(41300700001)(36756003)(356005)(186003)(336012)(1076003)(47076005)(2616005)(83380400001)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2022 20:22:06.2225 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 64f4350b-deba-4d58-f939-08dade10deb7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT060.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4965
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
Cc: stylon.wang@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
During DP2.1 LL CTS if test equipment requests to change between
DP2.1 and DP1.4 link rates, we need to swap between HPO and DIO
encoders by remapping encoder resource.

[how]
Add a function dc resource to update encoder resources and toggle
dpms state for all enabled stream associated witht the link under test.

Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c |  3 -
 .../gpu/drm/amd/display/dc/core/dc_link_dp.c  | 64 +++++++------------
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 39 +++++++++++
 drivers/gpu/drm/amd/display/dc/inc/resource.h |  9 +++
 4 files changed, 72 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 1ca3328b492c..ee20b4d3afd4 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -4649,9 +4649,6 @@ void dc_link_set_preferred_training_settings(struct dc *dc,
 
 	if (link_setting != NULL) {
 		link->preferred_link_setting = *link_setting;
-		if (dp_get_link_encoding_format(link_setting) == DP_128b_132b_ENCODING)
-			/* TODO: add dc update for acquiring link res  */
-			skip_immediate_retrain = true;
 	} else {
 		link->preferred_link_setting.lane_count = LANE_COUNT_UNKNOWN;
 		link->preferred_link_setting.link_rate = LINK_RATE_UNKNOWN;
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index af9411ee3c74..e8a3d72a4c74 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -7276,51 +7276,35 @@ void dp_retrain_link_dp_test(struct dc_link *link,
 			struct dc_link_settings *link_setting,
 			bool skip_video_pattern)
 {
-	struct pipe_ctx *pipes =
-			&link->dc->current_state->res_ctx.pipe_ctx[0];
+	struct pipe_ctx *pipe;
 	unsigned int i;
-	bool do_fallback = false;
 
+	udelay(100);
 
 	for (i = 0; i < MAX_PIPES; i++) {
-		if (pipes[i].stream != NULL &&
-			!pipes[i].top_pipe && !pipes[i].prev_odm_pipe &&
-			pipes[i].stream->link != NULL &&
-			pipes[i].stream_res.stream_enc != NULL &&
-			pipes[i].stream->link == link) {
-			udelay(100);
-
-			link->dc->hwss.blank_stream(&pipes[i]);
-
-			/* disable any test pattern that might be active */
-			dp_set_hw_test_pattern(link, &pipes[i].link_res,
-					DP_TEST_PATTERN_VIDEO_MODE, NULL, 0);
-
-			dp_receiver_power_ctrl(link, false);
-
-			link->dc->hwss.disable_stream(&pipes[i]);
-			if (pipes[i].stream_res.audio && !link->dc->debug.az_endpoint_mute_only)
-				pipes[i].stream_res.audio->funcs->az_disable(pipes[i].stream_res.audio);
-
-			link->dc->hwss.disable_link_output(link, &pipes[i].link_res, SIGNAL_TYPE_DISPLAY_PORT);
-
-			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
-				do_fallback = true;
-
-			perform_link_training_with_retries(
-					link_setting,
-					skip_video_pattern,
-					LINK_TRAINING_ATTEMPTS,
-					&pipes[i],
-					SIGNAL_TYPE_DISPLAY_PORT,
-					do_fallback);
-
-			link->dc->hwss.enable_stream(&pipes[i]);
-
-			link->dc->hwss.unblank_stream(&pipes[i],
-					link_setting);
+		pipe = &link->dc->current_state->res_ctx.pipe_ctx[i];
+		if (pipe->stream != NULL &&
+				pipe->stream->link == link &&
+				!pipe->stream->dpms_off &&
+				!pipe->top_pipe && !pipe->prev_odm_pipe) {
+			core_link_disable_stream(pipe);
+			pipe->link_config.dp_link_settings = *link_setting;
+			update_dp_encoder_resources_for_test_harness(
+					link->dc,
+					pipe->stream->ctx->dc->current_state,
+					pipe);
+		}
+	}
 
-			link->dc->hwss.enable_audio_stream(&pipes[i]);
+	for (i = 0; i < MAX_PIPES; i++) {
+		pipe = &link->dc->current_state->res_ctx.pipe_ctx[i];
+		if (pipe->stream != NULL &&
+				pipe->stream->link == link &&
+				!pipe->stream->dpms_off &&
+				!pipe->top_pipe && !pipe->prev_odm_pipe) {
+			core_link_enable_stream(
+					pipe->stream->ctx->dc->current_state,
+					pipe);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 002b7b512b09..06b5f49e0954 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -3990,3 +3990,42 @@ bool dc_resource_acquire_secondary_pipe_for_mpc_odm(
 
 	return true;
 }
+
+enum dc_status update_dp_encoder_resources_for_test_harness(const struct dc *dc,
+		struct dc_state *context,
+		struct pipe_ctx *pipe_ctx)
+{
+	if (dp_get_link_encoding_format(&pipe_ctx->link_config.dp_link_settings) == DP_128b_132b_ENCODING) {
+		if (pipe_ctx->stream_res.hpo_dp_stream_enc == NULL) {
+			pipe_ctx->stream_res.hpo_dp_stream_enc =
+					find_first_free_match_hpo_dp_stream_enc_for_link(
+							&context->res_ctx, dc->res_pool, pipe_ctx->stream);
+
+			if (!pipe_ctx->stream_res.hpo_dp_stream_enc)
+				return DC_NO_STREAM_ENC_RESOURCE;
+
+			update_hpo_dp_stream_engine_usage(
+					&context->res_ctx, dc->res_pool,
+					pipe_ctx->stream_res.hpo_dp_stream_enc,
+					true);
+		}
+
+		if (pipe_ctx->link_res.hpo_dp_link_enc == NULL) {
+			if (!add_hpo_dp_link_enc_to_ctx(&context->res_ctx, dc->res_pool, pipe_ctx, pipe_ctx->stream))
+				return DC_NO_LINK_ENC_RESOURCE;
+		}
+	} else {
+		if (pipe_ctx->stream_res.hpo_dp_stream_enc) {
+			update_hpo_dp_stream_engine_usage(
+					&context->res_ctx, dc->res_pool,
+					pipe_ctx->stream_res.hpo_dp_stream_enc,
+					false);
+			pipe_ctx->stream_res.hpo_dp_stream_enc = NULL;
+		}
+		if (pipe_ctx->link_res.hpo_dp_link_enc)
+			remove_hpo_dp_link_enc_from_ctx(&context->res_ctx, pipe_ctx, pipe_ctx->stream);
+	}
+
+	return DC_OK;
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/inc/resource.h b/drivers/gpu/drm/amd/display/dc/inc/resource.h
index 5040836f404d..4ab029e3326d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/resource.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/resource.h
@@ -236,4 +236,13 @@ bool dc_resource_acquire_secondary_pipe_for_mpc_odm(
 		struct pipe_ctx *pri_pipe,
 		struct pipe_ctx *sec_pipe,
 		bool odm);
+
+/* A test harness interface that modifies dp encoder resources in the given dc
+ * state and bypasses the need to revalidate. The interface assumes that the
+ * test harness interface is called with pre-validated link config stored in the
+ * pipe_ctx and updates dp encoder resources according to the link config.
+ */
+enum dc_status update_dp_encoder_resources_for_test_harness(const struct dc *dc,
+		struct dc_state *context,
+		struct pipe_ctx *pipe_ctx);
 #endif /* DRIVERS_GPU_DRM_AMD_DC_DEV_DC_INC_RESOURCE_H_ */
-- 
2.39.0


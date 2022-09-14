Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C656FECAAD8
	for <amd-gfx@archiver.kernel.org>; Wed, 14 Sep 2022 05:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0944610E3E3;
	Wed, 14 Sep 2022 05:12:45 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0057810E3E3
 for <amd-gfx@lists.freedesktop.org>; Wed, 14 Sep 2022 05:12:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FxW//7lg4mqn7VdAFA2EQgNg7Nyvq1QE03RNsWXeDjWXU737Re0HEwX6D8XfFWklojYFdOD5KPhi1KFPy6rQDW1CJRTEEPxHlqwbBV191wDuJDyYceKK6sPAKvg5jBBldJ5wxhXQReetfZUGF7Ef2rXi7KWretGBMrsCERW1vJ80FyBt5gobeWEZafB+I2w6EanZvtNFzgPjj+8MqXY5GVZgtQ/2NTG8y53bdyCMgXI8M+A8DRqhsiVgLcIYhWgQ/h/GxrspM9DQyHa87upBxrrrOmp6m5S3fAGUyHJhog13bThiysgzuwbISmUXgwi/ZEzuzD/QVINto2Ld8/MMyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t406djKHEvWsAVmXnsXC4FH2yaN9pZkgZidaO+tBetU=;
 b=cZzYyS2BwkKstAzFG+sm4ao62i/l/D3sVSl3Slr/CSztohQpMRLlP/Gj+BTiEL6SOdtXKMIKnWqSmkDLp/hE6b6B41rugrWOx2vNtOX144FJWn1Us3K7RC6S/bpztEiEQNDN83S0eDEg5w9F4nUL1x9kWOLLd+sTai0K2+C2fCA2xeWr7e+7hI/Brgk+fwHMfHax298jJ4Ppz2JZvSRu3hguHgR5/DzBdBK9rpTelNsZcbZ3CXmfNDn6IRKtN8/21Pmbe8FuQixxcb7LPm5JD4AFh0K2APvS7+mOhT2arWeQvhi5Vba02D/epT811adIlNpO0i8bQxdpUZ7A44Xz3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t406djKHEvWsAVmXnsXC4FH2yaN9pZkgZidaO+tBetU=;
 b=vQTwvL/rjPshLjLnSxy+1OQDGVoK6SdFiPR7tVeCRMTNv6wwNf8JviEAdQxguS4E8vFVEfPlzeGDiBu7BqFTJ1lyIzqby0nwo+TUthHPNQKxMjI4tDidIuR/6SdwRUIHb/gdcgeBvo4xOGUi18/gcDjvcFH2hDAinx6T0+zegeU=
Received: from DM6PR01CA0027.prod.exchangelabs.com (2603:10b6:5:296::32) by
 DM4PR12MB6493.namprd12.prod.outlook.com (2603:10b6:8:b6::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5612.22; Wed, 14 Sep 2022 05:12:36 +0000
Received: from DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:296:cafe::aa) by DM6PR01CA0027.outlook.office365.com
 (2603:10b6:5:296::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5612.14 via Frontend
 Transport; Wed, 14 Sep 2022 05:12:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT108.mail.protection.outlook.com (10.13.172.95) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5632.12 via Frontend Transport; Wed, 14 Sep 2022 05:12:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:12:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 14 Sep
 2022 00:12:03 -0500
Received: from wayne-dev-lnx.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 14 Sep 2022 00:11:58 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH V3 03/47] drm/amd/display: Fix pipe split prediction
Date: Wed, 14 Sep 2022 13:10:02 +0800
Message-ID: <20220914051046.1131186-4-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914051046.1131186-1-Wayne.Lin@amd.com>
References: <20220914051046.1131186-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT108:EE_|DM4PR12MB6493:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e47c9d6-1a16-4ced-72a6-08da960fbcc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2WpX8hLYkwsrHFsSMzBKzQY50OTMEM4N7RUm8bS8mdGky0++X+tNLAamxnvza2esOyt9nKq4kghsi4RFz02IluM8f9jQk4xaK6Ct2qcNATWgxSQM65b2jo9koS4z/jq7nhC2kQIJRWy/4/4BCwWsoes9rOMVXjo8rgBZMhaz0VL4to/f+2h4gzhepJDPUvAMEOEhDR0VplShYrbYHySW9xAYE9u9kX0B0wHCp9vcPGwDYYRrH2KMIteTBtktDk9gYFx/SoC5csJYxSsLxkGIwlXVDL5TdCz3eeOQSODn2RBiZydIY18Vgkba8nkeemRykAepRBxpVRodDDp6R3P7ClFwQCazrvofwJZU6U5VVA3E48m+JCpNLNf0xUUaVm3HW6OjUb8cZ/U05XoiHmRahIj+ixMV8Uk71VO4wShExL/0+v+hnGvKnojFc2jnMnCpYfD2NpxC9sNkK+B2cy9tD2RNkhHc8wPILD48LRygM+8hYVeiK/dpMigKYXiYQnzChAgjV703bnF4hnzFWQLPev2AOrNfjxkF9DeWnxXtioNTQin5Vg5KvpdsTM6pSJVuhuNQsIlBeOl1Url9JN/wlalBhf71KxGs6hwHhuMamWRoMN21ZqHDaUSYl6hU9oZeLLxzRloEBtOQ70hFbEtr/BTc87vjjGPs9ZOmsHZG32Pohk8g1AYOUZ5gKom7Kp7mHoF/zpmcBMUUmPC/oD1Qnq3yarQWe+SooK/p0wErhv/V431qo239yxLs2SFbNqNzrYds1tv2zQ69XlMDPEtJ6B3M8iqmwMCom/IRsJ+P5T6mvi7UeEq/V+UPhmDttek
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(346002)(396003)(136003)(376002)(451199015)(46966006)(40470700004)(36840700001)(426003)(8676002)(186003)(40480700001)(7696005)(5660300002)(1076003)(478600001)(81166007)(54906003)(70206006)(82310400005)(356005)(86362001)(40460700003)(41300700001)(8936002)(336012)(36860700001)(70586007)(26005)(6916009)(6666004)(2616005)(30864003)(2906002)(316002)(4326008)(82740400003)(47076005)(83380400001)(36756003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2022 05:12:36.1141 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e47c9d6-1a16-4ced-72a6-08da960fbcc5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT108.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6493
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>,
 wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Why & How]
- Pipe split prediction previously only took into
account MPC split. We must also consider when
ODM combine is required, and when we apply ODM
combine by policy.

- Also re-work DET allocation function as it wasn't
properly splitting the DET per stream, per plane.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  50 ++++----
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   6 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c | 108 +++++++++++++++---
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  93 +++++++++++----
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.h  |   5 +-
 5 files changed, 194 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index e0038d576aeb..6bc0fe922599 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1850,12 +1850,36 @@ int dcn32_populate_dml_pipes_from_context(
 	int i, pipe_cnt;
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe;
-	bool subvp_in_use = false, is_pipe_split_expected[MAX_PIPES];
+	bool subvp_in_use = false;
+	uint8_t is_pipe_split_expected[MAX_PIPES] = {0};
 	int plane_count = 0;
 	struct dc_crtc_timing *timing;
 
 	dcn20_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
 
+	/* Determine whether we will apply ODM 2to1 policy:
+	 * Applies to single display and where the number of planes is less than 3.
+	 * For 3 plane case ( 2 MPO planes ), we will not set the policy for the MPO pipes.
+	 *
+	 * Apply pipe split policy first so we can predict the pipe split correctly
+	 * (dcn32_predict_pipe_split).
+	 */
+	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
+		if (!res_ctx->pipe_ctx[i].stream)
+			continue;
+		pipe = &res_ctx->pipe_ctx[i];
+		timing = &pipe->stream->timing;
+
+		pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
+		if (context->stream_count == 1 && !dc_is_hdmi_signal(res_ctx->pipe_ctx[i].stream->signal)) {
+			if (dc->debug.enable_single_display_2to1_odm_policy) {
+				if (!((plane_count > 2) && pipe->top_pipe))
+					pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
+			}
+		}
+		pipe_cnt++;
+	}
+
 	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
 
 		if (!res_ctx->pipe_ctx[i].stream)
@@ -1916,32 +1940,12 @@ int dcn32_populate_dml_pipes_from_context(
 			++plane_count;
 
 		DC_FP_START();
-		is_pipe_split_expected[i] = dcn32_predict_pipe_split(context, pipes[i].pipe, i);
+		is_pipe_split_expected[i] = dcn32_predict_pipe_split(context, &pipes[pipe_cnt]);
 		DC_FP_END();
 
 		pipe_cnt++;
 	}
 
-	/* Determine whether we will apply ODM 2to1 policy
-	 * Applies to single display and where the number of planes is less than 3
-	 * For 3 plane case ( 2 MPO planes ), we will not set the policy for the MPO pipes
-	 */
-	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
-		if (!res_ctx->pipe_ctx[i].stream)
-			continue;
-		pipe = &res_ctx->pipe_ctx[i];
-		timing = &pipe->stream->timing;
-
-		pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
-		if (context->stream_count == 1 && !dc_is_hdmi_signal(res_ctx->pipe_ctx[i].stream->signal)) {
-			if (dc->debug.enable_single_display_2to1_odm_policy) {
-				if (!((plane_count > 2) && pipe->top_pipe))
-					pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
-			}
-		}
-		pipe_cnt++;
-	}
-
 	/* For DET allocation, we don't want to use DML policy (not optimal for utilizing all
 	 * the DET available for each pipe). Use the DET override input to maintain our driver
 	 * policy.
@@ -1958,7 +1962,7 @@ int dcn32_populate_dml_pipes_from_context(
 			}
 		}
 	} else
-		dcn32_determine_det_override(context, pipes, is_pipe_split_expected, dc->res_pool->pipe_count);
+		dcn32_determine_det_override(dc, context, pipes, is_pipe_split_expected);
 
 	// In general cases we want to keep the dram clock change requirement
 	// (prefer configs that support MCLK switch). Only override to false
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index 95f3517724d1..1039df3f9565 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -109,8 +109,10 @@ struct pipe_ctx *dcn32_acquire_idle_pipe_for_head_pipe_in_layer(
 		struct dc_stream_state *stream,
 		struct pipe_ctx *head_pipe);
 
-void dcn32_determine_det_override(struct dc_state *context, display_e2e_pipe_params_st *pipes,
-		bool *is_pipe_split_expected, int pipe_cnt);
+void dcn32_determine_det_override(struct dc *dc,
+		struct dc_state *context,
+		display_e2e_pipe_params_st *pipes,
+		uint8_t *is_pipe_split_expected);
 
 /* definitions for run time init of reg offsets */
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index 417dfdcf9596..237f71d9304e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -225,36 +225,106 @@ bool dcn32_mpo_in_use(struct dc_state *context)
 	return false;
 }
 
-void dcn32_determine_det_override(struct dc_state *context, display_e2e_pipe_params_st *pipes,
-		bool *is_pipe_split_expected, int pipe_cnt)
+/**
+ * *******************************************************************************************
+ * dcn32_determine_det_override: Determine DET allocation for each pipe
+ *
+ * This function determines how much DET to allocate for each pipe. The total number of
+ * DET segments will be split equally among each of the streams, and after that the DET
+ * segments per stream will be split equally among the planes for the given stream.
+ *
+ * If there is a plane that's driven by more than 1 pipe (i.e. pipe split), then the
+ * number of DET for that given plane will be split among the pipes driving that plane.
+ *
+ * The pipe split prediction (is_pipe_split_expected) has to work 100% of the time in
+ * order for this function to work properly.
+ *
+ * High level algorithm:
+ * 1. Split total DET among number of streams
+ * 2. For each stream, split DET among the planes
+ * 3. For each plane, check if pipe split is expected. If yes, split the DET for that plane
+ *    among the number of splits we expect (i.e. 2 [2:1] or 4 [4:1])
+ *    - NOTE: Make sure not to double count the pipe splits (i.e. the pipes could
+ *            already be split in the context).
+ * 4. Assign the DET override to the DML pipes.
+ *
+ * @param [in]: dc: Current DC state
+ * @param [in]: context: New DC state to be programmed
+ * @param [in]: pipes: Array of DML pipes
+ * @param [in]: is_pipe_split_expected: Array indicating pipe split prediction for each pipe
+ *
+ * @return: void
+ *
+ * *******************************************************************************************
+ */
+void dcn32_determine_det_override(struct dc *dc,
+		struct dc_state *context,
+		display_e2e_pipe_params_st *pipes,
+		uint8_t *is_pipe_split_expected)
 {
-	int i, j, count, stream_segments, pipe_segments[MAX_PIPES];
+	uint8_t i, j, pipe_plane_count, stream_segments, plane_segments, pipe_segments[MAX_PIPES] = {0};
+	uint8_t pipe_counted[MAX_PIPES] = {0};
+	uint8_t pipe_cnt = 0;
+	struct dc_plane_state *current_plane = NULL;
+	struct pipe_ctx *next_odm_pipe = NULL;
+	struct pipe_ctx *bottom_pipe = NULL;
 
 	if (context->stream_count > 0) {
 		stream_segments = 18 / context->stream_count;
 		for (i = 0; i < context->stream_count; i++) {
-			count = 0;
-			for (j = 0; j < pipe_cnt; j++) {
-				if (context->res_ctx.pipe_ctx[j].stream == context->streams[i]) {
-					count++;
-					if (is_pipe_split_expected[j])
-						count++;
+			if (context->stream_status[i].plane_count > 0)
+				plane_segments = stream_segments / context->stream_status[i].plane_count;
+			else
+				plane_segments = stream_segments;
+			for (j = 0; j < dc->res_pool->pipe_count; j++) {
+				pipe_plane_count = 0;
+				if (context->res_ctx.pipe_ctx[j].stream == context->streams[i] &&
+						pipe_counted[j] != 1) {
+					/* Note: pipe_plane_count indicates the number of pipes to be used for a
+					 * given plane. e.g. pipe_plane_count = 1 means single pipe (i.e. not split),
+					 * pipe_plane_count = 2 means 2:1 split, etc.
+					 */
+					pipe_plane_count++;
+					pipe_counted[j] = 1;
+					current_plane = context->res_ctx.pipe_ctx[j].plane_state;
+					if (is_pipe_split_expected[j] != 0) {
+						pipe_plane_count += is_pipe_split_expected[j];
+
+						next_odm_pipe = context->res_ctx.pipe_ctx[j].next_odm_pipe;
+						bottom_pipe = context->res_ctx.pipe_ctx[j].bottom_pipe;
+
+						/* If pipe already happens to be split in context, mark as already
+						 * counted so we don't double count the pipe split.
+						 */
+						while (next_odm_pipe) {
+							if (next_odm_pipe->plane_state == current_plane) {
+								pipe_counted[next_odm_pipe->pipe_idx] = 1;
+								pipe_segments[next_odm_pipe->pipe_idx] = plane_segments / pipe_plane_count;
+							}
+							next_odm_pipe = next_odm_pipe->next_odm_pipe;
+						}
+
+						while (bottom_pipe) {
+							if (bottom_pipe->plane_state == current_plane) {
+								pipe_counted[bottom_pipe->pipe_idx] = 1;
+								pipe_segments[bottom_pipe->pipe_idx] = plane_segments / pipe_plane_count;
+							}
+							bottom_pipe = bottom_pipe->bottom_pipe;
+						}
+					}
+					pipe_segments[j] = plane_segments / pipe_plane_count;
 				}
 			}
-			pipe_segments[i] = stream_segments / count;
 		}
 
-		for (i = 0; i < pipe_cnt; i++) {
-			pipes[i].pipe.src.det_size_override = 0;
-			for (j = 0; j < context->stream_count; j++) {
-				if (context->res_ctx.pipe_ctx[i].stream == context->streams[j]) {
-					pipes[i].pipe.src.det_size_override = pipe_segments[j] * DCN3_2_DET_SEG_SIZE;
-					break;
-				}
-			}
+		for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
+			if (!context->res_ctx.pipe_ctx[i].stream)
+				continue;
+			pipes[pipe_cnt].pipe.src.det_size_override = pipe_segments[i] * DCN3_2_DET_SEG_SIZE;
+			pipe_cnt++;
 		}
 	} else {
-		for (i = 0; i < pipe_cnt; i++)
+		for (i = 0; i < dc->res_pool->pipe_count; i++)
 			pipes[i].pipe.src.det_size_override = 4 * DCN3_2_DET_SEG_SIZE; //DCN3_2_DEFAULT_DET_SIZE
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 7f6c977c4981..2b3ffa300f25 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -286,41 +286,92 @@ void dcn32_helper_populate_phantom_dlg_params(struct dc *dc,
 	}
 }
 
-bool dcn32_predict_pipe_split(struct dc_state *context, display_pipe_params_st pipe, int index)
+/**
+ * *******************************************************************************************
+ * dcn32_predict_pipe_split: Predict if pipe split will occur for a given DML pipe
+ *
+ * This function takes in a DML pipe (pipe_e2e) and predicts if pipe split is required (both
+ * ODM and MPC). For pipe split, ODM combine is determined by the ODM mode, and MPC combine is
+ * determined by DPPClk requirements
+ *
+ * This function follows the same policy as DML:
+ * - Check for ODM combine requirements / policy first
+ * - MPC combine is only chosen if there is no ODM combine requirements / policy in place, and
+ *   MPC is required
+ *
+ * @param [in]: context: New DC state to be programmed
+ * @param [in]: pipe_e2e: DML pipe end to end context
+ *
+ * @return: Number of splits expected (1 for 2:1 split, 3 for 4:1 split, 0 for no splits).
+ *
+ * *******************************************************************************************
+ */
+uint8_t dcn32_predict_pipe_split(struct dc_state *context,
+				  display_e2e_pipe_params_st *pipe_e2e)
 {
 	double pscl_throughput;
 	double pscl_throughput_chroma;
 	double dpp_clk_single_dpp, clock;
 	double clk_frequency = 0.0;
 	double vco_speed = context->bw_ctx.dml.soc.dispclk_dppclk_vco_speed_mhz;
+	bool total_available_pipes_support = false;
+	uint32_t number_of_dpp = 0;
+	enum odm_combine_mode odm_mode = dm_odm_combine_mode_disabled;
+	double req_dispclk_per_surface = 0;
+	uint8_t num_splits = 0;
 
 	dc_assert_fp_enabled();
 
-	dml32_CalculateSinglePipeDPPCLKAndSCLThroughput(pipe.scale_ratio_depth.hscl_ratio,
-							pipe.scale_ratio_depth.hscl_ratio_c,
-							pipe.scale_ratio_depth.vscl_ratio,
-							pipe.scale_ratio_depth.vscl_ratio_c,
-							context->bw_ctx.dml.ip.max_dchub_pscl_bw_pix_per_clk,
-							context->bw_ctx.dml.ip.max_pscl_lb_bw_pix_per_clk,
-							pipe.dest.pixel_rate_mhz,
-							pipe.src.source_format,
-							pipe.scale_taps.htaps,
-							pipe.scale_taps.htaps_c,
-							pipe.scale_taps.vtaps,
-							pipe.scale_taps.vtaps_c,
-							/* Output */
-							&pscl_throughput, &pscl_throughput_chroma,
-							&dpp_clk_single_dpp);
+	dml32_CalculateODMMode(context->bw_ctx.dml.ip.maximum_pixels_per_line_per_dsc_unit,
+			pipe_e2e->pipe.dest.hactive,
+			pipe_e2e->dout.output_format,
+			pipe_e2e->dout.output_type,
+			pipe_e2e->pipe.dest.odm_combine_policy,
+			context->bw_ctx.dml.soc.clock_limits[context->bw_ctx.dml.soc.num_states - 1].dispclk_mhz,
+			context->bw_ctx.dml.soc.clock_limits[context->bw_ctx.dml.soc.num_states - 1].dispclk_mhz,
+			pipe_e2e->dout.dsc_enable != 0,
+			0, /* TotalNumberOfActiveDPP can be 0 since we're predicting pipe split requirement */
+			context->bw_ctx.dml.ip.max_num_dpp,
+			pipe_e2e->pipe.dest.pixel_rate_mhz,
+			context->bw_ctx.dml.soc.dcn_downspread_percent,
+			context->bw_ctx.dml.ip.dispclk_ramp_margin_percent,
+			context->bw_ctx.dml.soc.dispclk_dppclk_vco_speed_mhz,
+			pipe_e2e->dout.dsc_slices,
+			/* Output */
+			&total_available_pipes_support,
+			&number_of_dpp,
+			&odm_mode,
+			&req_dispclk_per_surface);
+
+	dml32_CalculateSinglePipeDPPCLKAndSCLThroughput(pipe_e2e->pipe.scale_ratio_depth.hscl_ratio,
+			pipe_e2e->pipe.scale_ratio_depth.hscl_ratio_c,
+			pipe_e2e->pipe.scale_ratio_depth.vscl_ratio,
+			pipe_e2e->pipe.scale_ratio_depth.vscl_ratio_c,
+			context->bw_ctx.dml.ip.max_dchub_pscl_bw_pix_per_clk,
+			context->bw_ctx.dml.ip.max_pscl_lb_bw_pix_per_clk,
+			pipe_e2e->pipe.dest.pixel_rate_mhz,
+			pipe_e2e->pipe.src.source_format,
+			pipe_e2e->pipe.scale_taps.htaps,
+			pipe_e2e->pipe.scale_taps.htaps_c,
+			pipe_e2e->pipe.scale_taps.vtaps,
+			pipe_e2e->pipe.scale_taps.vtaps_c,
+			/* Output */
+			&pscl_throughput, &pscl_throughput_chroma,
+			&dpp_clk_single_dpp);
 
 	clock = dpp_clk_single_dpp * (1 + context->bw_ctx.dml.soc.dcn_downspread_percent / 100);
 
 	if (clock > 0)
-		clk_frequency = vco_speed * 4.0 / ((int)(vco_speed * 4.0));
+		clk_frequency = vco_speed * 4.0 / ((int)(vco_speed * 4.0) / clock);
 
-	if (clk_frequency > context->bw_ctx.dml.soc.clock_limits[index].dppclk_mhz)
-		return true;
-	else
-		return false;
+	if (odm_mode == dm_odm_combine_mode_2to1)
+		num_splits = 1;
+	else if (odm_mode == dm_odm_combine_mode_4to1)
+		num_splits = 3;
+	else if (clk_frequency > context->bw_ctx.dml.soc.clock_limits[context->bw_ctx.dml.soc.num_states - 1].dppclk_mhz)
+		num_splits = 1;
+
+	return num_splits;
 }
 
 static float calculate_net_bw_in_kbytes_sec(struct _vcs_dpi_voltage_scaling_st *entry)
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
index 3ed06ab855be..ce4c33e64186 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.h
@@ -41,9 +41,8 @@ void dcn32_helper_populate_phantom_dlg_params(struct dc *dc,
 					      display_e2e_pipe_params_st *pipes,
 					      int pipe_cnt);
 
-bool dcn32_predict_pipe_split(struct dc_state *context,
-			      display_pipe_params_st pipe,
-			      int index);
+uint8_t dcn32_predict_pipe_split(struct dc_state *context,
+				  display_e2e_pipe_params_st *pipe_e2e);
 
 void insert_entry_into_table_sorted(struct _vcs_dpi_voltage_scaling_st *table,
 				    unsigned int *num_entries,
-- 
2.37.3


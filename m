Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48BEBEB8FC0
	for <amd-gfx@archiver.kernel.org>; Wed,  6 Sep 2023 12:50:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 91D1710E63C;
	Wed,  6 Sep 2023 12:50:38 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2053.outbound.protection.outlook.com [40.107.220.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FC4E10E637
 for <amd-gfx@lists.freedesktop.org>; Wed,  6 Sep 2023 12:50:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C3xKxcxK3xj8ZQPJMw1bQ07ESrDe5QfFowylrOQCiyDZObO2N78YwAfYaNQ3+9iT3Va9Eh2nE198FP0hj5pTlF2XX6HMjzF/UmSn7+IP7gcVBw9RQBDzIpNe+20ZBg98+U28mxBHqbda5WAVxSRX5Hn2IAPBOdCqB3gShWkmHTS4/4arK4+WgyWAbPc24Z5OHoOYDKAjgofe8U0zPowsWun8qSUP8h+9tO1m32FhxDoeLNEb7NbJ43HoG9UIvvrXl0qAUGJo6RR0zktpusAxkHVBc3f5kA/69DQmMzHXkWLigp8NnOwd58J2W1tzyevertiVpNOuBcd7SI3sGOicfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yg+ys8mMO15WEqnzQI7uW69/RFU2c4JF1NoAZzmCigM=;
 b=OkhDHJey7H2QpTjIohGNvFahs/aT8Aaodx3Jp5TE7fqusOgdI2YItorGJGDxjJv3t+CvgG4QrR+v608/28vGAz5DV7gvONF1RlOqqJE7a2vaIjrDuOn/523Q9MGueSzogzos+3zUIo8bYs83YGPnPzXxJ18qtk3Ou0ehiU9p1EAfJxptQRu7Lk+gG9ehL+b+lY6ImxRHZ9E7WGd1JZtECtIWomNryc8O1DkzCmex1gSarVGyG47gJGe2GovqWiFTZiPtHQQAD9oorc9R4y55dt9D1+6cTzjV+JB3tGCj7ajUyp+KLntS4d147Aoyd/B/rbQUjOS3uG8aQspJU+peeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yg+ys8mMO15WEqnzQI7uW69/RFU2c4JF1NoAZzmCigM=;
 b=aEXie/hCwfDhFzBud55ZfewlMg254tY8IMhbd5nqEQp6TvNHxnTE74rYpEt7fa5EbYwnCioaxf1NeWwE1kPQVmQJJIvipYYl5I2qYMaGoEb/+G1dYowxjxI2S8sq3Q46CAoSjwhuOW4fOcYg4WwU5Xeg+93gGVtFG+CnaXDfOwo=
Received: from CYZPR10CA0004.namprd10.prod.outlook.com (2603:10b6:930:8a::9)
 by DS0PR12MB8766.namprd12.prod.outlook.com (2603:10b6:8:14e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 12:50:33 +0000
Received: from CY4PEPF0000EDD1.namprd03.prod.outlook.com
 (2603:10b6:930:8a:cafe::c2) by CYZPR10CA0004.outlook.office365.com
 (2603:10b6:930:8a::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.36 via Frontend
 Transport; Wed, 6 Sep 2023 12:50:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD1.mail.protection.outlook.com (10.167.241.205) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6768.25 via Frontend Transport; Wed, 6 Sep 2023 12:50:33 +0000
Received: from stylon-EliteDesk.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 6 Sep
 2023 07:49:58 -0500
From: Stylon Wang <stylon.wang@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/28] drm/amd/display: do not attempt ODM power optimization
 if minimal transition doesn't exist
Date: Wed, 6 Sep 2023 20:28:20 +0800
Message-ID: <20230906124915.586250-16-stylon.wang@amd.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230906124915.586250-1-stylon.wang@amd.com>
References: <20230906124915.586250-1-stylon.wang@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD1:EE_|DS0PR12MB8766:EE_
X-MS-Office365-Filtering-Correlation-Id: ccb4ebdf-74cc-43b5-c4f8-08dbaed7dc0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dzTkMIrYhZ+FvHGaV0sTo+nIP3NlaSIRJF2KMIu5cxS7e5an8GYh17KOv74dKg57wvnXtqHj+i0+usaEbXysfDZDorO1hqi3Z87BcjhC5sJDvnw/cxVgBI3oM7YgCyGVjJOinhTbqsOAfjUR9ffut8NNsXf7CYjl0FGLoZQjWU3vGZe2vDcwQdKOeLlL6vTWwxv1RpnHz8HvyiXByZz7GerrfP9fw3NRy5WScihcAXqilWKdYeLWi/b0ahhQjmgXvDC0+5eeRxzvEA8OMAOTBMMTBynhGWqqyRts3TjRl8gAjofcWVvuNplW2lDTfBMscIL/5vnBWijE4Oxk/Jtefasos3hhkyoqdfO18Nk7m3WZf9NUH30/X4xX1VpbaWcR4n/Na735VY4nsArjTT0F8LwmOHVBgDw1GXK+a2QEUQIZVUVlGM748lV1qlJ6kEqpfVI4HceYfmFsCmzzcYbUiXN3gEmWmJZyyJ4matyX3Fi3/uVOlToRmV3e5CnEItgVszyOMlVegWzCutOyargfdyHPpAkRiS1d4kkF0VItvmwXrXHD7J4VkIqtL/zqkT4JPV4csfa9sv6y53aL3xXUKHOX8SP7hEXNkECs3vMjdJhKz71jhqYPx29+wmeXFedaxR2u8+IDtsxtpMVqybHEIkZkfFMFxtHKGIRPWISBFsysKGmxamoU2KIyLNA1lShgkYdjILzI7mgipnE/aLtSV/rYB/zKTzo712sdcyYY9/v2yJWFC4foJOv8viUbp/INsLyIzkqMCnozwTsKaMEtFw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(376002)(136003)(346002)(39860400002)(396003)(451199024)(186009)(1800799009)(82310400011)(36840700001)(40470700004)(46966006)(30864003)(41300700001)(36860700001)(44832011)(5660300002)(86362001)(6666004)(478600001)(2906002)(4326008)(8936002)(8676002)(70586007)(70206006)(54906003)(6916009)(316002)(26005)(16526019)(1076003)(7696005)(2616005)(40460700003)(356005)(81166007)(426003)(336012)(82740400003)(36756003)(47076005)(83380400001)(40480700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 12:50:33.5120 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ccb4ebdf-74cc-43b5-c4f8-08dbaed7dc0e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8766
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
Cc: stylon.wang@amd.com, Dillon Varone <dillon.varone@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>,
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[why]
In some cases such as 8k desktop surface with 144Hz timing, we decide to
enable ODM power optimization but this surface doesn't have a minimum
transition state. Therefore we cannot switch off ODM power optimization seamlessly
This creates path depedency on ODM power optimization decision. i.e
whether or not we should switch off ODM power optimization is dependent
on if the transition to switch off ODM power optimization from current state
is seamless. We don't desire a path dependent power optimization policy
as it is too dynamic and difficult to maintain.

[how]
Attempt ODM power optimization only after we can validate new state without
using pipe combine.

Reviewed-by: Dillon Varone <dillon.varone@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  76 +--
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  | 487 +++++++++++-------
 2 files changed, 306 insertions(+), 257 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 8cb6b94e83d2..a74d4cab5a7d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -1885,67 +1885,6 @@ bool dcn32_validate_bandwidth(struct dc *dc,
 	return out;
 }
 
-static bool should_allow_odm_power_optimization(struct dc *dc,
-		struct dc_state *context)
-{
-	struct dc_stream_state *stream = context->streams[0];
-
-	/*
-	 * this debug flag allows us to disable ODM power optimization feature
-	 * unconditionally. we force the feature off if this is set to false.
-	 */
-	if (!dc->debug.enable_single_display_2to1_odm_policy)
-		return false;
-
-	/* current design and test coverage is only limited to allow ODM power
-	 * optimization for single stream. Supporting it for multiple streams
-	 * use case would require additional algorithm to decide how to
-	 * optimize power consumption when there are not enough free pipes to
-	 * allocate for all the streams. This level of optimization would
-	 * require multiple attempts of revalidation to make an optimized
-	 * decision. Unfortunately We do not support revalidation flow in
-	 * current version of DML.
-	 */
-	if (context->stream_count != 1)
-		return false;
-
-	/*
-	 * Our hardware doesn't support ODM for HDMI TMDS
-	 */
-	if (dc_is_hdmi_signal(stream->signal))
-		return false;
-
-	/*
-	 * ODM Combine 2:1 requires horizontal timing divisible by 2 so each
-	 * ODM segment has the same size.
-	 */
-	if (!is_h_timing_divisible_by_2(stream))
-		return false;
-
-	/*
-	 * No power benefits if the timing's pixel clock is not high enough to
-	 * raise display clock from minimum power state.
-	 */
-	if (stream->timing.pix_clk_100hz * 100 <= DCN3_2_VMIN_DISPCLK_HZ)
-		return false;
-
-	/* the new ODM power optimization feature reduces software design
-	 * limitation and allows ODM power optimization to be supported even
-	 * with presence of overlay planes. The new feature is enabled based on
-	 * enable_windowed_mpo_odm flag. If the flag is not set, we limit our
-	 * feature scope due to previous software design limitation */
-	if (!dc->config.enable_windowed_mpo_odm) {
-		if (context->stream_status[0].plane_count != 1)
-			return false;
-
-		if (stream->src.width >= 5120 &&
-				stream->src.width > stream->dst.width)
-			return false;
-	}
-
-	return true;
-}
-
 int dcn32_populate_dml_pipes_from_context(
 	struct dc *dc, struct dc_state *context,
 	display_e2e_pipe_params_st *pipes,
@@ -1959,20 +1898,6 @@ int dcn32_populate_dml_pipes_from_context(
 
 	dcn20_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
 
-	/*
-	 * Apply pipe split policy first so we can predict the pipe split correctly
-	 * (dcn32_predict_pipe_split).
-	 */
-	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
-		if (!res_ctx->pipe_ctx[i].stream)
-			continue;
-		if (should_allow_odm_power_optimization(dc, context))
-			pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
-		else
-			pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
-		pipe_cnt++;
-	}
-
 	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
 
 		if (!res_ctx->pipe_ctx[i].stream)
@@ -1985,6 +1910,7 @@ int dcn32_populate_dml_pipes_from_context(
 		dcn32_zero_pipe_dcc_fraction(pipes, pipe_cnt);
 		DC_FP_END();
 		pipes[pipe_cnt].pipe.dest.vfront_porch = timing->v_front_porch;
+		pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_dal;
 		pipes[pipe_cnt].pipe.src.gpuvm_min_page_size_kbytes = 256; // according to spreadsheet
 		pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
 		pipes[pipe_cnt].pipe.scale_ratio_depth.lb_depth = dm_lb_19;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 496f0f58fa7d..883e90be2257 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1078,6 +1078,307 @@ static void assign_subvp_index(struct dc *dc, struct dc_state *context)
 	}
 }
 
+struct pipe_slice_table {
+	struct {
+		struct dc_stream_state *stream;
+		int slice_count;
+	} odm_combines[MAX_STREAMS];
+	int odm_combine_count;
+
+	struct {
+		struct dc_plane_state *plane;
+		int slice_count;
+	} mpc_combines[MAX_SURFACES];
+	int mpc_combine_count;
+};
+
+
+static void update_slice_table_for_stream(struct pipe_slice_table *table,
+		struct dc_stream_state *stream, int diff)
+{
+	int i;
+
+	for (i = 0; i < table->odm_combine_count; i++) {
+		if (table->odm_combines[i].stream == stream) {
+			table->odm_combines[i].slice_count += diff;
+			break;
+		}
+	}
+
+	if (i == table->odm_combine_count) {
+		table->odm_combine_count++;
+		table->odm_combines[i].stream = stream;
+		table->odm_combines[i].slice_count = diff;
+	}
+}
+
+static void update_slice_table_for_plane(struct pipe_slice_table *table,
+		struct dc_plane_state *plane, int diff)
+{
+	int i;
+
+	for (i = 0; i < table->mpc_combine_count; i++) {
+		if (table->mpc_combines[i].plane == plane) {
+			table->mpc_combines[i].slice_count += diff;
+			break;
+		}
+	}
+
+	if (i == table->mpc_combine_count) {
+		table->mpc_combine_count++;
+		table->mpc_combines[i].plane = plane;
+		table->mpc_combines[i].slice_count = diff;
+	}
+}
+
+static void init_pipe_slice_table_from_context(
+		struct pipe_slice_table *table,
+		struct dc_state *context)
+{
+	int i, j;
+	struct pipe_ctx *otg_master;
+	struct pipe_ctx *dpp_pipes[MAX_PIPES];
+	struct dc_stream_state *stream;
+	int count;
+
+	memset(table, 0, sizeof(*table));
+
+	for (i = 0; i < context->stream_count; i++) {
+		stream = context->streams[i];
+		otg_master = resource_get_otg_master_for_stream(
+				&context->res_ctx, stream);
+		count = resource_get_odm_slice_count(otg_master);
+		update_slice_table_for_stream(table, stream, count);
+
+		count = resource_get_dpp_pipes_for_opp_head(otg_master,
+				&context->res_ctx, dpp_pipes);
+		for (j = 0; j < count; j++)
+			if (dpp_pipes[j]->plane_state)
+				update_slice_table_for_plane(table,
+						dpp_pipes[j]->plane_state, 1);
+	}
+}
+
+static bool update_pipe_slice_table_with_split_flags(
+		struct pipe_slice_table *table,
+		struct dc *dc,
+		struct dc_state *context,
+		struct vba_vars_st *vba,
+		int split[MAX_PIPES],
+		bool merge[MAX_PIPES])
+{
+	/* NOTE: we are deprecating the support for the concept of pipe splitting
+	 * or pipe merging. Instead we append slices to the end and remove
+	 * slices from the end. The following code converts a pipe split or
+	 * merge to an append or remove operation.
+	 *
+	 * For example:
+	 * When split flags describe the following pipe connection transition
+	 *
+	 * from:
+	 *  pipe 0 (split=2) -> pipe 1 (split=2)
+	 * to: (old behavior)
+	 *  pipe 0 -> pipe 2 -> pipe 1 -> pipe 3
+	 *
+	 * the code below actually does:
+	 *  pipe 0 -> pipe 1 -> pipe 2 -> pipe 3
+	 *
+	 * This is the new intended behavior and for future DCNs we will retire
+	 * the old concept completely.
+	 */
+	struct pipe_ctx *pipe;
+	bool odm;
+	int i;
+	bool updated = false;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (merge[i]) {
+			if (resource_is_pipe_type(pipe, OPP_HEAD))
+				/* merging OPP head means reducing ODM slice
+				 * count by 1
+				 */
+				update_slice_table_for_stream(table, pipe->stream, -1);
+			else if (resource_is_pipe_type(pipe, DPP_PIPE) &&
+					resource_get_odm_slice_index(resource_get_opp_head(pipe)) == 0)
+				/* merging DPP pipe of the first ODM slice means
+				 * reducing MPC slice count by 1
+				 */
+				update_slice_table_for_plane(table, pipe->plane_state, -1);
+			updated = true;
+		}
+
+		if (split[i]) {
+			odm = vba->ODMCombineEnabled[vba->pipe_plane[i]] !=
+					dm_odm_combine_mode_disabled;
+			if (odm && resource_is_pipe_type(pipe, OPP_HEAD))
+				update_slice_table_for_stream(
+						table, pipe->stream, split[i] - 1);
+			else if (!odm && resource_is_pipe_type(pipe, DPP_PIPE))
+				update_slice_table_for_plane(
+						table, pipe->plane_state, split[i] - 1);
+			updated = true;
+		}
+	}
+	return updated;
+}
+
+static void update_pipes_with_slice_table(struct dc *dc, struct dc_state *context,
+		struct pipe_slice_table *table)
+{
+	int i;
+
+	for (i = 0; i < table->odm_combine_count; i++) {
+		resource_update_pipes_for_stream_with_slice_count(context,
+				dc->current_state, dc->res_pool,
+				table->odm_combines[i].stream,
+				table->odm_combines[i].slice_count);
+		/* TODO: move this into the function above */
+		dcn20_build_mapped_resource(dc, context,
+				table->odm_combines[i].stream);
+	}
+
+	for (i = 0; i < table->mpc_combine_count; i++)
+		resource_update_pipes_for_plane_with_slice_count(context,
+				dc->current_state, dc->res_pool,
+				table->mpc_combines[i].plane,
+				table->mpc_combines[i].slice_count);
+}
+
+static bool update_pipes_with_split_flags(struct dc *dc, struct dc_state *context,
+		struct vba_vars_st *vba, int split[MAX_PIPES],
+		bool merge[MAX_PIPES])
+{
+	struct pipe_slice_table slice_table;
+	bool updated;
+
+	init_pipe_slice_table_from_context(&slice_table, context);
+	updated = update_pipe_slice_table_with_split_flags(
+			&slice_table, dc, context, vba,
+			split, merge);
+	update_pipes_with_slice_table(dc, context, &slice_table);
+	return updated;
+}
+
+static bool should_allow_odm_power_optimization(struct dc *dc,
+		struct dc_state *context, struct vba_vars_st *v, int *split,
+		bool *merge)
+{
+	struct dc_stream_state *stream = context->streams[0];
+	struct pipe_slice_table slice_table;
+	int i;
+
+	/*
+	 * this debug flag allows us to disable ODM power optimization feature
+	 * unconditionally. we force the feature off if this is set to false.
+	 */
+	if (!dc->debug.enable_single_display_2to1_odm_policy)
+		return false;
+
+	/* current design and test coverage is only limited to allow ODM power
+	 * optimization for single stream. Supporting it for multiple streams
+	 * use case would require additional algorithm to decide how to
+	 * optimize power consumption when there are not enough free pipes to
+	 * allocate for all the streams. This level of optimization would
+	 * require multiple attempts of revalidation to make an optimized
+	 * decision. Unfortunately We do not support revalidation flow in
+	 * current version of DML.
+	 */
+	if (context->stream_count != 1)
+		return false;
+
+	/*
+	 * Our hardware doesn't support ODM for HDMI TMDS
+	 */
+	if (dc_is_hdmi_signal(stream->signal))
+		return false;
+
+	/*
+	 * ODM Combine 2:1 requires horizontal timing divisible by 2 so each
+	 * ODM segment has the same size.
+	 */
+	if (!is_h_timing_divisible_by_2(stream))
+		return false;
+
+	/*
+	 * No power benefits if the timing's pixel clock is not high enough to
+	 * raise display clock from minimum power state.
+	 */
+	if (stream->timing.pix_clk_100hz * 100 <= DCN3_2_VMIN_DISPCLK_HZ)
+		return false;
+
+	if (dc->config.enable_windowed_mpo_odm) {
+		/*
+		 * ODM power optimization should only be allowed if the feature
+		 * can be seamlessly toggled off within an update. This would
+		 * require that the feature is applied on top of a minimal
+		 * state. A minimal state is defined as a state validated
+		 * without the need of pipe split. Therefore, when transition to
+		 * toggle the feature off, the same stream and plane
+		 * configuration can be supported by the pipe resource in the
+		 * first ODM slice alone without the need to acquire extra
+		 * resources.
+		 */
+		init_pipe_slice_table_from_context(&slice_table, context);
+		update_pipe_slice_table_with_split_flags(
+				&slice_table, dc, context, v,
+				split, merge);
+		for (i = 0; i < slice_table.mpc_combine_count; i++)
+			if (slice_table.mpc_combines[i].slice_count > 1)
+				return false;
+
+		for (i = 0; i < slice_table.odm_combine_count; i++)
+			if (slice_table.odm_combines[i].slice_count > 1)
+				return false;
+	} else {
+		/*
+		 * the new ODM power optimization feature reduces software
+		 * design limitation and allows ODM power optimization to be
+		 * supported even with presence of overlay planes. The new
+		 * feature is enabled based on enable_windowed_mpo_odm flag. If
+		 * the flag is not set, we limit our feature scope due to
+		 * previous software design limitation
+		 */
+		if (context->stream_status[0].plane_count != 1)
+			return false;
+
+		if (memcmp(&context->stream_status[0].plane_states[0]->clip_rect,
+				&stream->src, sizeof(struct rect)) != 0)
+			return false;
+
+		if (stream->src.width >= 5120 &&
+				stream->src.width > stream->dst.width)
+			return false;
+	}
+	return true;
+}
+
+static void try_odm_power_optimization_and_revalidate(
+		struct dc *dc,
+		struct dc_state *context,
+		display_e2e_pipe_params_st *pipes,
+		int *split,
+		bool *merge,
+		unsigned int *vlevel,
+		int pipe_cnt)
+{
+	int i;
+	unsigned int new_vlevel;
+
+	for (i = 0; i < pipe_cnt; i++)
+		pipes[i].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
+
+	new_vlevel = dml_get_voltage_level(&context->bw_ctx.dml, pipes, pipe_cnt);
+
+	if (new_vlevel < context->bw_ctx.dml.soc.num_states) {
+		memset(split, 0, MAX_PIPES * sizeof(int));
+		memset(merge, 0, MAX_PIPES * sizeof(bool));
+		*vlevel = dcn20_validate_apply_pipe_split_flags(dc, context, new_vlevel, split, merge);
+		context->bw_ctx.dml.vba.VoltageLevel = *vlevel;
+	}
+}
+
 static void dcn32_full_validate_bw_helper(struct dc *dc,
 				   struct dc_state *context,
 				   display_e2e_pipe_params_st *pipes,
@@ -1113,6 +1414,10 @@ static void dcn32_full_validate_bw_helper(struct dc *dc,
 		vba->VoltageLevel = *vlevel;
 	}
 
+	if (should_allow_odm_power_optimization(dc, context, vba, split, merge))
+		try_odm_power_optimization_and_revalidate(
+				dc, context, pipes, split, merge, vlevel, *pipe_cnt);
+
 	/* Conditions for setting up phantom pipes for SubVP:
 	 * 1. Not force disable SubVP
 	 * 2. Full update (i.e. !fast_validate)
@@ -1570,188 +1875,6 @@ static bool dcn32_split_stream_for_mpc_or_odm(
 	return true;
 }
 
-struct pipe_slice_table {
-	struct {
-		struct dc_stream_state *stream;
-		int slice_count;
-	} odm_combines[MAX_STREAMS];
-	int odm_combine_count;
-
-	struct {
-		struct dc_plane_state *plane;
-		int slice_count;
-	} mpc_combines[MAX_SURFACES];
-	int mpc_combine_count;
-};
-
-static void update_slice_table_for_stream(struct pipe_slice_table *table,
-		struct dc_stream_state *stream, int diff)
-{
-	int i;
-
-	for (i = 0; i < table->odm_combine_count; i++) {
-		if (table->odm_combines[i].stream == stream) {
-			table->odm_combines[i].slice_count += diff;
-			break;
-		}
-	}
-
-	if (i == table->odm_combine_count) {
-		table->odm_combine_count++;
-		table->odm_combines[i].stream = stream;
-		table->odm_combines[i].slice_count = diff;
-	}
-}
-
-static void update_slice_table_for_plane(struct pipe_slice_table *table,
-		struct dc_plane_state *plane, int diff)
-{
-	int i;
-
-	for (i = 0; i < table->mpc_combine_count; i++) {
-		if (table->mpc_combines[i].plane == plane) {
-			table->mpc_combines[i].slice_count += diff;
-			break;
-		}
-	}
-
-	if (i == table->mpc_combine_count) {
-		table->mpc_combine_count++;
-		table->mpc_combines[i].plane = plane;
-		table->mpc_combines[i].slice_count = diff;
-	}
-}
-
-static void init_pipe_slice_table_from_context(
-		struct pipe_slice_table *table,
-		struct dc_state *context)
-{
-	int i, j;
-	struct pipe_ctx *otg_master;
-	struct pipe_ctx *dpp_pipes[MAX_PIPES];
-	struct dc_stream_state *stream;
-	int count;
-
-	memset(table, 0, sizeof(*table));
-
-	for (i = 0; i < context->stream_count; i++) {
-		stream = context->streams[i];
-		otg_master = resource_get_otg_master_for_stream(
-				&context->res_ctx, stream);
-		count = resource_get_odm_slice_count(otg_master);
-		update_slice_table_for_stream(table, stream, count);
-
-		count = resource_get_dpp_pipes_for_opp_head(otg_master,
-				&context->res_ctx, dpp_pipes);
-		for (j = 0; j < count; j++)
-			if (dpp_pipes[j]->plane_state)
-				update_slice_table_for_plane(table,
-						dpp_pipes[j]->plane_state, 1);
-	}
-}
-
-static bool update_pipe_slice_table_with_split_flags(
-		struct pipe_slice_table *table,
-		struct dc *dc,
-		struct dc_state *context,
-		struct vba_vars_st *vba,
-		int split[MAX_PIPES],
-		bool merge[MAX_PIPES])
-{
-	/* NOTE: we are deprecating the support for the concept of pipe splitting
-	 * or pipe merging. Instead we append slices to the end and remove
-	 * slices from the end. The following code converts a pipe split or
-	 * merge to an append or remove operation.
-	 *
-	 * For example:
-	 * When split flags describe the following pipe connection transition
-	 *
-	 * from:
-	 *  pipe 0 (split=2) -> pipe 1 (split=2)
-	 * to: (old behavior)
-	 *  pipe 0 -> pipe 2 -> pipe 1 -> pipe 3
-	 *
-	 * the code below actually does:
-	 *  pipe 0 -> pipe 1 -> pipe 2 -> pipe 3
-	 *
-	 * This is the new intended behavior and for future DCNs we will retire
-	 * the old concept completely.
-	 */
-	struct pipe_ctx *pipe;
-	bool odm;
-	int i;
-	bool updated = false;
-
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		pipe = &context->res_ctx.pipe_ctx[i];
-
-		if (merge[i]) {
-			if (resource_is_pipe_type(pipe, OPP_HEAD))
-				/* merging OPP head means reducing ODM slice
-				 * count by 1
-				 */
-				update_slice_table_for_stream(table, pipe->stream, -1);
-			else if (resource_is_pipe_type(pipe, DPP_PIPE) &&
-					resource_get_odm_slice_index(resource_get_opp_head(pipe)) == 0)
-				/* merging DPP pipe of the first ODM slice means
-				 * reducing MPC slice count by 1
-				 */
-				update_slice_table_for_plane(table, pipe->plane_state, -1);
-			updated = true;
-		}
-
-		if (split[i]) {
-			odm = vba->ODMCombineEnabled[vba->pipe_plane[i]] !=
-					dm_odm_combine_mode_disabled;
-			if (odm && resource_is_pipe_type(pipe, OPP_HEAD))
-				update_slice_table_for_stream(
-						table, pipe->stream, split[i] - 1);
-			else if (!odm && resource_is_pipe_type(pipe, DPP_PIPE))
-				update_slice_table_for_plane(
-						table, pipe->plane_state, split[i] - 1);
-			updated = true;
-		}
-	}
-	return updated;
-}
-
-static void update_pipes_with_slice_table(struct dc *dc, struct dc_state *context,
-		struct pipe_slice_table *table)
-{
-	int i;
-
-	for (i = 0; i < table->odm_combine_count; i++) {
-		resource_update_pipes_for_stream_with_slice_count(context,
-				dc->current_state, dc->res_pool,
-				table->odm_combines[i].stream,
-				table->odm_combines[i].slice_count);
-		/* TODO: move this into the function above */
-		dcn20_build_mapped_resource(dc, context,
-				table->odm_combines[i].stream);
-	}
-
-	for (i = 0; i < table->mpc_combine_count; i++)
-		resource_update_pipes_for_plane_with_slice_count(context,
-				dc->current_state, dc->res_pool,
-				table->mpc_combines[i].plane,
-				table->mpc_combines[i].slice_count);
-}
-
-static bool update_pipes_with_split_flags(struct dc *dc, struct dc_state *context,
-		struct vba_vars_st *vba, int split[MAX_PIPES],
-		bool merge[MAX_PIPES])
-{
-	struct pipe_slice_table slice_table;
-	bool updated;
-
-	init_pipe_slice_table_from_context(&slice_table, context);
-	updated = update_pipe_slice_table_with_split_flags(
-			&slice_table, dc, context, vba,
-			split, merge);
-	update_pipes_with_slice_table(dc, context, &slice_table);
-	return updated;
-}
-
 bool dcn32_internal_validate_bw(struct dc *dc,
 				struct dc_state *context,
 				display_e2e_pipe_params_st *pipes,
-- 
2.42.0


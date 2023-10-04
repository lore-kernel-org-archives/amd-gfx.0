Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B44AE936E7
	for <amd-gfx@archiver.kernel.org>; Wed,  4 Oct 2023 21:22:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B7EE89EAC;
	Wed,  4 Oct 2023 21:22:17 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2074.outbound.protection.outlook.com [40.107.93.74])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8868910E1B4
 for <amd-gfx@lists.freedesktop.org>; Wed,  4 Oct 2023 21:22:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8nk+3g6bTWVm7OE2AGqIQxZb+s1Ng0dXH4ShtmhwoklF4ShXbpmQElwOZ2u3f35gW6FdqOswh31sC0mJk1Sxyz6cApLcBtzVnO6pzC2pedlOOb0J+OTSrp8ugphGHwve2rhq3FiGbFJGHOrKh+IQMUWaN1NjCI377yag5f2dXniIvOIn3SG2AMnBk43GxTs+W/QvZi6Qw3KPR4j0A4NlbDzOgiVWuwnIJS20mCkhqrPUpgQ6i2zGnrz0nghT8/16jflugxGKr/C8YZ+7VCiZQjPBfuH6bwB9BXJy/bj45LzBIyj+xj9ldo8DpxUGjXktsFfVbrpavc2yAIBntYqwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Po81YahRseNtE3aivenftl3xTZuUshhoiABM+23TUS4=;
 b=aJ7aeU0s8+ePhBuPlB7BMMTtabN67RAW/kBHZJIKoPjIQCut8WX9VNYwmqj828G2AKmGC/vh9rbaUTzYYzhQcdSS0HAUbxYHxKmg+MCgrk+cagbFlx3FUT4Xr/Pm3IeNeUnb+yaNTWOJb9wGfA6hDxSMpE5bR4Ww7Z9pAP/0VC492qOQNLa2tWTKMKqdLjJ4YJ/R+VrEhASYnL21WoaPwUegZPKXwXdoiSqmCTHh6LlVkP7FzF6Lc9OTsZtTTc+EAZkO6kBCSTqrEnW/+RaiiYAQ8w/kR1Jholihop6wIPAoZB+PtxG3RYxIEGvqr26DX74BZukqDF8u4ginqI8UnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Po81YahRseNtE3aivenftl3xTZuUshhoiABM+23TUS4=;
 b=sAyLkacT5ZuLTjxf0LY7KTfPOkSSC2apIXvysqv8E7RwAX27Aav13ZxY7LUfGKwVL6+dr1Ye7Ri1VdhGLHITzvXosK8f9xUXT3Tr5yHgx1B6Nx/+6I+bReISZnuy/PttMTkSaviTtTJ+sQwVMntR6i1/dgnX+OW+DlvFytDgSp4=
Received: from BL1PR13CA0242.namprd13.prod.outlook.com (2603:10b6:208:2ba::7)
 by SJ2PR12MB8159.namprd12.prod.outlook.com (2603:10b6:a03:4f9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.25; Wed, 4 Oct
 2023 21:22:09 +0000
Received: from BL02EPF0001A104.namprd05.prod.outlook.com
 (2603:10b6:208:2ba:cafe::f4) by BL1PR13CA0242.outlook.office365.com
 (2603:10b6:208:2ba::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.25 via Frontend
 Transport; Wed, 4 Oct 2023 21:22:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL02EPF0001A104.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.14 via Frontend Transport; Wed, 4 Oct 2023 21:22:09 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 4 Oct
 2023 16:22:01 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v3 14/16] drm/amd/display: Modify Pipe Selection for Policy
 for ODM
Date: Wed, 4 Oct 2023 15:21:08 -0600
Message-ID: <20231004212110.3753955-15-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
References: <20231004212110.3753955-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A104:EE_|SJ2PR12MB8159:EE_
X-MS-Office365-Filtering-Correlation-Id: 6619cb33-e2f5-4519-31c7-08dbc51ff7f3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9cXb8DTAtwIi9OCQ1u8RzGFj799fHDyQCpkQTDESq8Mg09qdcRKTK2kFmIzN2yFqiw000A5vf228b5sNV6+SKTPPw8+ng8Rztx9wd2v9IicnOImrx5s758TI+6qSLX3JJ3SlBUuc+lEwCdgbpcVQ37T9YBAU4+HZHpjwqT7E11vg+wHyLiweypKWO/UxyFOqS33k9GtqRXsXHweWJo5REjNilebGDWjpZsZRvzJ1ws+KWmv2RO6/BeKvNZu+jhz/1wyDVcGu9zPlkq3UAcgf6eSlbDeyXaWut35Xa0mQLsVphuXTdrqVZUURrx+V5i3Yr5wh0jxrdK87OL/Ik82SmdsPyGGTZpkGXAGtzN4Hz0xGEXTpFIE7x5LBXbeKOFA5a9hk98WEXwC7Ri1hbV/2A6YidZl7QsHjzXneaMRPq6tPQrRaEsyAz5YjZ5oOhMrC29pNeBQYqrRqj80dTi8AQTz5tPlguwELmS9cHvl54vBe6fLQHExAwsBl2zFCou8YFQUD6HKWmGVAYPhkP96nLlbTQPdF+jAYSQMxd62fYrHtOSS5W0d6lDb+Uk5NFgSeoL6DIJnZ0xxtl3bsywCz5BrJqfhYxUooRCBzjjeNiKEKNqHpOyMxTeJS5K9lzH5ZFs7HnRtsrz8sP0n5fWPknk3Mk9pPu4TPO6UkyMW24laaSqOYKugl+D7UPjOvAPiwoYOmWSN61eoaXyFtDLDRK7CT4hwOcwWjMEIDRIxaZ9E2Kr92htj8g2HGBVfi/bUIUJEyMhERa2YN/uqi4Nnvyg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(4636009)(136003)(396003)(39860400002)(376002)(346002)(230922051799003)(1800799009)(186009)(451199024)(82310400011)(64100799003)(40470700004)(46966006)(36840700001)(356005)(82740400003)(81166007)(40480700001)(1076003)(2616005)(26005)(16526019)(336012)(426003)(316002)(2906002)(41300700001)(4326008)(70586007)(8936002)(86362001)(5660300002)(6916009)(70206006)(54906003)(36756003)(8676002)(478600001)(47076005)(40460700003)(36860700001)(83380400001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 21:22:09.7156 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6619cb33-e2f5-4519-31c7-08dbc51ff7f3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A104.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8159
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
Cc: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>, Sunpeng.Li@amd.com,
 richard.gong@amd.com, Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Saaem
 Rizvi <syedsaaem.rizvi@amd.com>, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, Harry.Wentland@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Saaem Rizvi <syedsaaem.rizvi@amd.com>

[Why]
There are certain cases during a transition to ODM that might cause
corruption on the display. This occurs when we choose certain pipes in a
particular state.

[How]
We now will store the pipe indexes of the any pipes that might be
problematic to switch to during an ODM transition, and only use them as
a last resort.

Reviewed-by: Dmytro Laktyushkin <dmytro.laktyushkin@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
Signed-off-by: Saaem Rizvi <syedsaaem.rizvi@amd.com>
---
 .../display/dc/dml2/dml2_dc_resource_mgmt.c   | 140 ++++++++++++++++--
 1 file changed, 126 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
index e22b5106df8f..36baf35bb170 100644
--- a/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
+++ b/drivers/gpu/drm/amd/display/dc/dml2/dml2_dc_resource_mgmt.c
@@ -213,6 +213,82 @@ static bool is_pipe_free(const struct pipe_ctx *pipe)
 	return false;
 }
 
+static unsigned int find_preferred_pipe_candidates(const struct dc_state *existing_state,
+	const int pipe_count,
+	const unsigned int stream_id,
+	unsigned int *preferred_pipe_candidates)
+{
+	unsigned int num_preferred_candidates = 0;
+	int i;
+
+	/* There is only one case which we consider for adding a pipe to the preferred
+	 * pipe candidate array:
+	 *
+	 * 1. If the existing stream id of the pipe is equivalent to the stream id
+	 * of the stream we are trying to achieve MPC/ODM combine for. This allows
+	 * us to minimize the changes in pipe topology during the transition.
+	 *
+	 * However this condition comes with a caveat. We need to ignore pipes that will
+	 * require a change in OPP but still have the same stream id. For example during
+	 * an MPC to ODM transiton.
+	 */
+	if (existing_state) {
+		for (i = 0; i < pipe_count; i++) {
+			if (existing_state->res_ctx.pipe_ctx[i].stream && existing_state->res_ctx.pipe_ctx[i].stream->stream_id == stream_id) {
+				if (existing_state->res_ctx.pipe_ctx[i].plane_res.hubp &&
+					existing_state->res_ctx.pipe_ctx[i].plane_res.hubp->opp_id != i)
+					continue;
+
+				preferred_pipe_candidates[num_preferred_candidates++] = i;
+			}
+		}
+	}
+
+	return num_preferred_candidates;
+}
+
+static unsigned int find_last_resort_pipe_candidates(const struct dc_state *existing_state,
+	const int pipe_count,
+	const unsigned int stream_id,
+	unsigned int *last_resort_pipe_candidates)
+{
+	unsigned int num_last_resort_candidates = 0;
+	int i;
+
+	/* There are two cases where we would like to add a given pipe into the last
+	 * candidate array:
+	 *
+	 * 1. If the pipe requires a change in OPP, for example during an MPC
+	 * to ODM transiton.
+	 *
+	 * 2. If the pipe already has an enabled OTG.
+	 */
+	if (existing_state) {
+		for (i  = 0; i < pipe_count; i++) {
+			if ((existing_state->res_ctx.pipe_ctx[i].plane_res.hubp &&
+				existing_state->res_ctx.pipe_ctx[i].plane_res.hubp->opp_id != i) ||
+				existing_state->res_ctx.pipe_ctx[i].stream_res.tg)
+				last_resort_pipe_candidates[num_last_resort_candidates++] = i;
+		}
+	}
+
+	return num_last_resort_candidates;
+}
+
+static bool is_pipe_in_candidate_array(const unsigned int pipe_idx,
+	const unsigned int *candidate_array,
+	const unsigned int candidate_array_size)
+{
+	int i;
+
+	for (i = 0; i < candidate_array_size; i++) {
+		if (candidate_array[i] == pipe_idx)
+			return true;
+	}
+
+	return false;
+}
+
 static bool find_more_pipes_for_stream(struct dml2_context *ctx,
 	struct dc_state *state, // The state we want to find a free mapping in
 	unsigned int stream_id, // The stream we want this pipe to drive
@@ -222,16 +298,18 @@ static bool find_more_pipes_for_stream(struct dml2_context *ctx,
 	const struct dc_state *existing_state) // The state (optional) that we want to minimize remapping relative to
 {
 	struct pipe_ctx *pipe = NULL;
-	unsigned int preferred_pipe_candidates[MAX_PIPES];
+	unsigned int preferred_pipe_candidates[MAX_PIPES] = {0};
+	unsigned int last_resort_pipe_candidates[MAX_PIPES] = {0};
 	unsigned int num_preferred_candidates = 0;
+	unsigned int num_last_resort_candidates = 0;
 	int i;
 
 	if (existing_state) {
-		// To minimize prioritize candidates from existing stream
-		for (i = 0; i < ctx->config.dcn_pipe_count; i++) {
-			if (existing_state->res_ctx.pipe_ctx[i].stream && existing_state->res_ctx.pipe_ctx[i].stream->stream_id == stream_id)
-				preferred_pipe_candidates[num_preferred_candidates++] = existing_state->res_ctx.pipe_ctx[i].pipe_idx;
-		}
+		num_preferred_candidates =
+			find_preferred_pipe_candidates(existing_state, ctx->config.dcn_pipe_count, stream_id, preferred_pipe_candidates);
+
+		num_last_resort_candidates =
+			find_last_resort_pipe_candidates(existing_state, ctx->config.dcn_pipe_count, stream_id, last_resort_pipe_candidates);
 	}
 
 	// First see if any of the preferred are unmapped, and choose those instead
@@ -247,6 +325,11 @@ static bool find_more_pipes_for_stream(struct dml2_context *ctx,
 
 	// We like to pair pipes starting from the higher order indicies for combining
 	for (i = ctx->config.dcn_pipe_count - 1; pipes_needed > 0 && i >= 0; i--) {
+		// Ignore any pipes that are the preferred or last resort candidate
+		if (is_pipe_in_candidate_array(i, preferred_pipe_candidates, num_preferred_candidates) ||
+			is_pipe_in_candidate_array(i, last_resort_pipe_candidates, num_last_resort_candidates))
+			continue;
+
 		pipe = &state->res_ctx.pipe_ctx[i];
 		if (!is_plane_using_pipe(pipe)) {
 			pipes_needed--;
@@ -256,6 +339,17 @@ static bool find_more_pipes_for_stream(struct dml2_context *ctx,
 		}
 	}
 
+	// Only use the last resort pipe candidates as a last resort
+	for (i = 0; pipes_needed > 0 && i < num_last_resort_candidates; i++) {
+		pipe = &state->res_ctx.pipe_ctx[last_resort_pipe_candidates[i]];
+		if (!is_plane_using_pipe(pipe)) {
+			pipes_needed--;
+			// TODO: This doens't make sense really, pipe_idx should always be valid
+			pipe->pipe_idx = last_resort_pipe_candidates[i];
+			assigned_pipes[(*assigned_pipe_count)++] = pipe->pipe_idx;
+		}
+	}
+
 	ASSERT(pipes_needed <= 0); // Validation should prevent us from building a pipe context that exceeds the number of HW resoruces available
 
 	return pipes_needed <= 0;
@@ -270,16 +364,18 @@ static bool find_more_free_pipes(struct dml2_context *ctx,
 	const struct dc_state *existing_state) // The state (optional) that we want to minimize remapping relative to
 {
 	struct pipe_ctx *pipe = NULL;
-	unsigned int preferred_pipe_candidates[MAX_PIPES];
+	unsigned int preferred_pipe_candidates[MAX_PIPES] = {0};
+	unsigned int last_resort_pipe_candidates[MAX_PIPES] = {0};
 	unsigned int num_preferred_candidates = 0;
+	unsigned int num_last_resort_candidates = 0;
 	int i;
 
 	if (existing_state) {
-		// To minimize prioritize candidates from existing stream
-		for (i = 0; i < ctx->config.dcn_pipe_count; i++) {
-			if (existing_state->res_ctx.pipe_ctx[i].stream && existing_state->res_ctx.pipe_ctx[i].stream->stream_id == stream_id)
-				preferred_pipe_candidates[num_preferred_candidates++] = existing_state->res_ctx.pipe_ctx[i].pipe_idx;
-		}
+		num_preferred_candidates =
+			find_preferred_pipe_candidates(existing_state, ctx->config.dcn_pipe_count, stream_id, preferred_pipe_candidates);
+
+		num_last_resort_candidates =
+			find_last_resort_pipe_candidates(existing_state, ctx->config.dcn_pipe_count, stream_id, last_resort_pipe_candidates);
 	}
 
 	// First see if any of the preferred are unmapped, and choose those instead
@@ -295,6 +391,11 @@ static bool find_more_free_pipes(struct dml2_context *ctx,
 
 	// We like to pair pipes starting from the higher order indicies for combining
 	for (i = ctx->config.dcn_pipe_count - 1; pipes_needed > 0 && i >= 0; i--) {
+		// Ignore any pipes that are the preferred or last resort candidate
+		if (is_pipe_in_candidate_array(i, preferred_pipe_candidates, num_preferred_candidates) ||
+			is_pipe_in_candidate_array(i, last_resort_pipe_candidates, num_last_resort_candidates))
+			continue;
+
 		pipe = &state->res_ctx.pipe_ctx[i];
 		if (is_pipe_free(pipe)) {
 			pipes_needed--;
@@ -304,6 +405,17 @@ static bool find_more_free_pipes(struct dml2_context *ctx,
 		}
 	}
 
+	// Only use the last resort pipe candidates as a last resort
+	for (i = 0; pipes_needed > 0 && i < num_last_resort_candidates; i++) {
+		pipe = &state->res_ctx.pipe_ctx[last_resort_pipe_candidates[i]];
+		if (is_pipe_free(pipe)) {
+			pipes_needed--;
+			// TODO: This doens't make sense really, pipe_idx should always be valid
+			pipe->pipe_idx = last_resort_pipe_candidates[i];
+			assigned_pipes[(*assigned_pipe_count)++] = pipe->pipe_idx;
+		}
+	}
+
 	ASSERT(pipes_needed == 0); // Validation should prevent us from building a pipe context that exceeds the number of HW resoruces available
 
 	return pipes_needed == 0;
@@ -465,7 +577,7 @@ static struct pipe_ctx *assign_pipes_to_stream(struct dml2_context *ctx, struct
 	struct pipe_ctx *master_pipe;
 	unsigned int pipes_needed;
 	unsigned int pipes_assigned;
-	unsigned int pipes[MAX_PIPES];
+	unsigned int pipes[MAX_PIPES] = {0};
 	unsigned int next_pipe_to_assign;
 	int odm_slice;
 
@@ -502,7 +614,7 @@ static struct pipe_ctx *assign_pipes_to_plane(struct dml2_context *ctx, struct d
 	unsigned int plane_id;
 	unsigned int pipes_needed;
 	unsigned int pipes_assigned;
-	unsigned int pipes[MAX_PIPES];
+	unsigned int pipes[MAX_PIPES] = {0};
 	unsigned int next_pipe_to_assign;
 	int odm_slice, mpc_slice;
 
-- 
2.40.1


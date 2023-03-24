Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3441C6FD1C
	for <amd-gfx@archiver.kernel.org>; Fri, 24 Mar 2023 06:53:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6BF810E4F4;
	Fri, 24 Mar 2023 06:52:56 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24E5410E4F0
 for <amd-gfx@lists.freedesktop.org>; Fri, 24 Mar 2023 06:52:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fer2cHIP5luGN3UGo6UQHvC2GZHoPmsXZh0Y5v1y8kOZyGFI76l3YzPzXhITYEQF1S3tTK9WQpk51R/LBWtkoiUw1jlQRjmt44M1qAje3o1Gd0LfYefdVe3Ah+TQZg+a/yTS5eG+CqMz/8Z4zI8dPAW65kcpWJFOQveh/E1SLL7FH9lUUNyGKodeMWO4l0ncFdDIa8ezRolx0ANdFMlbb19UUrYfT3FMHIeeyd5b9Qthc8tqb747OvJvs8kMGkj5yDoX/fMB7tmFNbTiYvlU5wsKcBVjbq9ErUdswQlpciDYdTl1t1aYtGhyZ0/bKRx5FzQLw6WGHLvvOuWWXN8iLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LauJd2KYP7Ij3XlJat88XY835QB+eG7vtgQXY+u4hks=;
 b=Tm71K5jkbfPjio2xZknQ+hRTGz5LhaPyJGzun2weXk7fhXoAkmBaHEubi63md5MC7phiz7nBemmxvjJKC2NpCL6Sxqd+kxS6cTBB5KK5fksFrY1EmdlI/7nbvpnE39wittWZfOZUSrB6N1QRMn07mlKB22WgqSGb+INNgBjW1qFzXJBcQXPlmWLakrmp5yA0NN6qNCGYs9FhQGA89K9caVxs5TjbZ7OCWddOb4D9fGrkckKAFI5iiRVAVI0Wp6DN9KjDnbaT8ulQYX+E7caCZtbJLCbHGiCtqy4d1tBz80gsrw+BLRPXl5/mUFOrECWM/5HXHMa1tvXz7xPVApdppQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LauJd2KYP7Ij3XlJat88XY835QB+eG7vtgQXY+u4hks=;
 b=5fcqPBMdASuj8CximhRggXVXAQ17X7BILgpZQ/Ec02Tzyhednk/2XRK03rUv0E69KK+RhjX4EwIdGqSU6NuH4x4J8vDgjuifOam0Ox+vSv76UJ5X6V7w3aexWTHTMSy42XEimKyGVz+zSBi/GBHjgVCNYtY5uTHMYv5LWgX09Tg=
Received: from MW4PR03CA0044.namprd03.prod.outlook.com (2603:10b6:303:8e::19)
 by DS7PR12MB6141.namprd12.prod.outlook.com (2603:10b6:8:9b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38; Fri, 24 Mar
 2023 06:52:45 +0000
Received: from CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::63) by MW4PR03CA0044.outlook.office365.com
 (2603:10b6:303:8e::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6178.38 via Frontend
 Transport; Fri, 24 Mar 2023 06:52:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT014.mail.protection.outlook.com (10.13.175.99) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6222.22 via Frontend Transport; Fri, 24 Mar 2023 06:52:44 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 24 Mar
 2023 01:52:38 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/19] drm/amd/display: Use per pipe P-State force for FPO
Date: Fri, 24 Mar 2023 02:51:02 -0400
Message-ID: <20230324065111.2782-11-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230324065111.2782-1-qingqing.zhuo@amd.com>
References: <20230324065111.2782-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1NAM11FT014:EE_|DS7PR12MB6141:EE_
X-MS-Office365-Filtering-Correlation-Id: 67ad68e9-9eae-4ec9-8f8a-08db2c345f0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Szj1JrJK1/wAPNwTupA00utnqUJv1Ac6amK+1Oz5l+i5Oa7pXGH6HeHtUwTkREfxaE/+7jd61V3ojPg+nIhA9m/G0tZSdb/Dilti5jTKU/T+slIUvahGL9FRNEyUA+Asp/RarnKZJWz0e9XgLcgPoth4M5pdNBLxk6uqAbCgyCZf02fgOStvOiazm3CPoTHtjyCCEnCP9uWWIGNbAx5aQcpgh/sPRY7G4T4NkgmAP3DVxA6O9FAvYWUG5z1i3QgFtKfA1FrNxO96yB/chU31A8p1UUTsFC6D8bbg8aF5WscGJHr61tPEJ21EB8jvMOE9Ck0zdsfXj3+VFnEsNd8Eb8hOXZBF01rWHWcPJhe9VtvROBgJBlxpHHM0w58fo6YBEfF3Q9l4daUtSaFBaZbnUv2LsFYYGFqxxviATGAWrx+JVjNIUPEynCCIKERf8XL6H4DCRnN56QzfYKWkwjyc/EODGJCsy6oIy9yP8ctmvNE5n6lUnOPsC45zdPIee84JkHrkaEkXp71P2xCJ7BrXpZ5dfyF778ktEYxjrqqXkaiR8Km6V+D1VeP+ZLODRmAa5JC2qJjl3pC96c5HVuT4/AEQYEM2ovA2gHB2Wtb0M5kK3SLWJ9FMWSAqoM0KiDbClgoTEqp9vioXlv04TDe5GTqPvS3ByKg7Yf5ydN18n+vBiXQgC/akKw/hXTVj+YGWVJhgFDwnHW8oPF7qGghBbYA/g4GMND6Hyry71rbToPQ=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230025)(4636009)(136003)(376002)(396003)(346002)(39860400002)(451199018)(36840700001)(40470700004)(46966006)(40480700001)(356005)(2906002)(40460700003)(36756003)(2616005)(336012)(83380400001)(186003)(16526019)(478600001)(86362001)(82310400005)(30864003)(70586007)(36860700001)(6916009)(8676002)(4326008)(70206006)(54906003)(426003)(47076005)(316002)(6666004)(1076003)(8936002)(41300700001)(26005)(81166007)(5660300002)(44832011)(82740400003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2023 06:52:44.5943 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 67ad68e9-9eae-4ec9-8f8a-08db2c345f0a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT014.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6141
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

[Description]
*  Pass in pipe index for FPO cmd to DMCUB
- This change will pass in the pipe index for each stream
  that is using FPO
- This change is in preparation to enable FPO + VActive

*  Use per pipe P-State force for FPO
- For FPO, instead of using max watermarks value for P-State disallow,
  use per pipe p-state force instead
- This is in preparation to enable FPO + VActive

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  | 46 +++++++++++--------
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 10 ++++
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  2 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c | 10 ++++
 .../gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h |  2 +
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 41 ++++++++++-------
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |  2 +-
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  2 +-
 .../drm/amd/display/dc/dml/dcn30/dcn30_fpu.c  |  4 ++
 .../drm/amd/display/dc/dml/dcn32/dcn32_fpu.c  |  8 ++--
 drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h  |  1 +
 .../amd/display/dc/inc/hw_sequencer_private.h |  2 +-
 13 files changed, 88 insertions(+), 43 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index b5c6501c28fc..8f26f7245104 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -302,27 +302,31 @@ static uint8_t dc_dmub_srv_get_pipes_for_stream(struct dc *dc, struct dc_stream_
 	return pipes;
 }
 
-static int dc_dmub_srv_get_timing_generator_offset(struct dc *dc, struct dc_stream_state *stream)
+static void dc_dmub_srv_populate_fams_pipe_info(struct dc *dc, struct dc_state *context,
+		struct pipe_ctx *head_pipe,
+		struct dmub_cmd_fw_assisted_mclk_switch_pipe_data *fams_pipe_data)
 {
-	int  tg_inst = 0;
-	int i = 0;
+	int j;
 
-	for (i = 0; i < MAX_PIPES; i++) {
-		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+	// TODO: Uncomment once FW headers are updated in driver
+	//fams_pipe_data->pipe_index[pipe_idx++] = head_pipe->plane_res.hubp->inst;
+	for (j = 0; j < dc->res_pool->pipe_count; j++) {
+		struct pipe_ctx *split_pipe = &context->res_ctx.pipe_ctx[j];
 
-		if (pipe->stream == stream && pipe->stream_res.tg) {
-			tg_inst = pipe->stream_res.tg->inst;
-			break;
+		if (split_pipe->stream == head_pipe->stream && (split_pipe->top_pipe || split_pipe->prev_odm_pipe)) {
+			// TODO: Uncomment once FW headers are updated in driver
+			//fams_pipe_data->pipe_index[pipe_idx++] = split_pipe->plane_res.hubp->inst;
 		}
 	}
-	return tg_inst;
+	// TODO: Uncomment once FW headers are updated in driver
+	//fams_pipe_data->pipe_count = pipe_idx;
 }
 
 bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, struct dc_state *context)
 {
 	union dmub_rb_cmd cmd = { 0 };
 	struct dmub_cmd_fw_assisted_mclk_switch_config *config_data = &cmd.fw_assisted_mclk_switch.config_data;
-	int i = 0;
+	int i = 0, k = 0;
 	int ramp_up_num_steps = 1; // TODO: Ramp is currently disabled. Reenable it.
 	uint8_t visual_confirm_enabled;
 
@@ -337,17 +341,21 @@ bool dc_dmub_srv_p_state_delegate(struct dc *dc, bool should_manage_pstate, stru
 	cmd.fw_assisted_mclk_switch.config_data.fams_enabled = should_manage_pstate;
 	cmd.fw_assisted_mclk_switch.config_data.visual_confirm_enabled = visual_confirm_enabled;
 
-	for (i = 0; context && i < context->stream_count; i++) {
-		struct dc_stream_state *stream = context->streams[i];
-		uint8_t min_refresh_in_hz = (stream->timing.min_refresh_in_uhz + 999999) / 1000000;
-		int  tg_inst = dc_dmub_srv_get_timing_generator_offset(dc, stream);
+	for (i = 0, k = 0; context && i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
-		config_data->pipe_data[tg_inst].pix_clk_100hz = stream->timing.pix_clk_100hz;
-		config_data->pipe_data[tg_inst].min_refresh_in_hz = min_refresh_in_hz;
-		config_data->pipe_data[tg_inst].max_ramp_step = ramp_up_num_steps;
-		config_data->pipe_data[tg_inst].pipes = dc_dmub_srv_get_pipes_for_stream(dc, stream);
+		if (!pipe->top_pipe && !pipe->prev_odm_pipe && pipe->stream && pipe->stream->fpo_in_use) {
+			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+			uint8_t min_refresh_in_hz = (pipe->stream->timing.min_refresh_in_uhz + 999999) / 1000000;
+
+			config_data->pipe_data[k].pix_clk_100hz = pipe->stream->timing.pix_clk_100hz;
+			config_data->pipe_data[k].min_refresh_in_hz = min_refresh_in_hz;
+			config_data->pipe_data[k].max_ramp_step = ramp_up_num_steps;
+			config_data->pipe_data[k].pipes = dc_dmub_srv_get_pipes_for_stream(dc, pipe->stream);
+			dc_dmub_srv_populate_fams_pipe_info(dc, context, pipe, &config_data->pipe_data[k]);
+			k++;
+		}
 	}
-
 	cmd.fw_assisted_mclk_switch.header.payload_bytes =
 		sizeof(cmd.fw_assisted_mclk_switch) - sizeof(cmd.fw_assisted_mclk_switch.header);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index 567452599659..181a3408cc61 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -293,6 +293,7 @@ struct dc_stream_state {
 
 	bool has_non_synchronizable_pclk;
 	bool vblank_synchronized;
+	bool fpo_in_use;
 	struct mall_stream_config mall_stream_config;
 };
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 9ca162ea0d07..5403e9399a46 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1993,6 +1993,16 @@ void dcn20_post_unlock_program_front_end(
 		}
 	}
 
+	/* P-State support transitions:
+	 * Natural -> FPO: 		P-State disabled in prepare, force disallow anytime is safe
+	 * FPO -> Natural: 		Unforce anytime after FW disable is safe (P-State will assert naturally)
+	 * Unsupported -> FPO:	P-State enabled in optimize, force disallow anytime is safe
+	 * FPO -> Unsupported:	P-State disabled in prepare, unforce disallow anytime is safe
+	 * FPO <-> SubVP:		Force disallow is maintained on the FPO / SubVP pipes
+	 */
+	if (hwseq && hwseq->funcs.update_force_pstate)
+		dc->hwseq->funcs.update_force_pstate(dc, context);
+
 	/* Only program the MALL registers after all the main and phantom pipes
 	 * are done programming.
 	 */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index c9e45da6ccd1..965f5ceb33f7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -2016,6 +2016,8 @@ bool dcn30_can_support_mclk_switch_using_fw_based_vblank_stretch(struct dc *dc,
 	if (context->streams[0]->vrr_active_variable)
 		return false;
 
+	context->streams[0]->fpo_in_use = true;
+
 	return true;
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
index fe0cd177744c..2d604f7ee782 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.c
@@ -47,6 +47,15 @@ void hubp32_update_force_pstate_disallow(struct hubp *hubp, bool pstate_disallow
 			DATA_UCLK_PSTATE_FORCE_VALUE, 0);
 }
 
+void hubp32_update_force_cursor_pstate_disallow(struct hubp *hubp, bool pstate_disallow)
+{
+	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
+
+	REG_UPDATE_2(UCLK_PSTATE_FORCE,
+			CURSOR_UCLK_PSTATE_FORCE_EN, pstate_disallow,
+			CURSOR_UCLK_PSTATE_FORCE_VALUE, 0);
+}
+
 void hubp32_update_mall_sel(struct hubp *hubp, uint32_t mall_sel, bool c_cursor)
 {
 	struct dcn20_hubp *hubp2 = TO_DCN20_HUBP(hubp);
@@ -188,6 +197,7 @@ static struct hubp_funcs dcn32_hubp_funcs = {
 	.hubp_set_flip_int = hubp1_set_flip_int,
 	.hubp_in_blank = hubp1_in_blank,
 	.hubp_update_force_pstate_disallow = hubp32_update_force_pstate_disallow,
+	.hubp_update_force_cursor_pstate_disallow = hubp32_update_force_cursor_pstate_disallow,
 	.phantom_hubp_post_enable = hubp32_phantom_hubp_post_enable,
 	.hubp_update_mall_sel = hubp32_update_mall_sel,
 	.hubp_prepare_subvp_buffering = hubp32_prepare_subvp_buffering
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h
index d5e5ed8ab869..d2acbc129609 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hubp.h
@@ -46,6 +46,8 @@
 
 void hubp32_update_force_pstate_disallow(struct hubp *hubp, bool pstate_disallow);
 
+void hubp32_update_force_cursor_pstate_disallow(struct hubp *hubp, bool pstate_disallow);
+
 void hubp32_update_mall_sel(struct hubp *hubp, uint32_t mall_sel, bool c_cursor);
 
 void hubp32_prepare_subvp_buffering(struct hubp *hubp, bool enable);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 42255c22605d..5ee9c5a74ecb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -571,39 +571,50 @@ bool dcn32_set_output_transfer_func(struct dc *dc,
 	return ret;
 }
 
-/* Program P-State force value according to if pipe is using SubVP or not:
+/* Program P-State force value according to if pipe is using SubVP / FPO or not:
  * 1. Reset P-State force on all pipes first
  * 2. For each main pipe, force P-State disallow (P-State allow moderated by DMUB)
  */
-void dcn32_subvp_update_force_pstate(struct dc *dc, struct dc_state *context)
+void dcn32_update_force_pstate(struct dc *dc, struct dc_state *context)
 {
 	int i;
-	int num_subvp = 0;
-	/* Unforce p-state for each pipe
+
+	/* Unforce p-state for each pipe if it is not FPO or SubVP.
+	 * For FPO and SubVP, if it's already forced disallow, leave
+	 * it as disallow.
 	 */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 		struct hubp *hubp = pipe->plane_res.hubp;
 
-		if (hubp && hubp->funcs->hubp_update_force_pstate_disallow)
-			hubp->funcs->hubp_update_force_pstate_disallow(hubp, false);
-		if (pipe->stream && pipe->stream->mall_stream_config.type == SUBVP_MAIN)
-			num_subvp++;
+		if (!pipe->stream || (pipe->stream && !(pipe->stream->mall_stream_config.type == SUBVP_MAIN ||
+						pipe->stream->fpo_in_use))) {
+			if (hubp && hubp->funcs->hubp_update_force_pstate_disallow)
+				hubp->funcs->hubp_update_force_pstate_disallow(hubp, false);
+			if (hubp && hubp->funcs->hubp_update_force_cursor_pstate_disallow)
+				hubp->funcs->hubp_update_force_cursor_pstate_disallow(hubp, false);
+		}
 	}
 
-	if (num_subvp == 0)
-		return;
-
 	/* Loop through each pipe -- for each subvp main pipe force p-state allow equal to false.
 	 */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		struct hubp *hubp = pipe->plane_res.hubp;
 
-		if (pipe->stream && pipe->plane_state && (pipe->stream->mall_stream_config.type == SUBVP_MAIN)) {
-			struct hubp *hubp = pipe->plane_res.hubp;
+		if (pipe->stream && pipe->plane_state && pipe->stream->mall_stream_config.type == SUBVP_MAIN) {
+			if (hubp && hubp->funcs->hubp_update_force_pstate_disallow)
+				hubp->funcs->hubp_update_force_pstate_disallow(hubp, true);
+		}
 
+		if (pipe->stream && pipe->stream->fpo_in_use) {
 			if (hubp && hubp->funcs->hubp_update_force_pstate_disallow)
 				hubp->funcs->hubp_update_force_pstate_disallow(hubp, true);
+			/* For now only force cursor p-state disallow for FPO
+			 * Needs to be added for subvp once FW side gets updated
+			 */
+			if (hubp && hubp->funcs->hubp_update_force_cursor_pstate_disallow)
+				hubp->funcs->hubp_update_force_cursor_pstate_disallow(hubp, true);
 		}
 	}
 }
@@ -677,10 +688,6 @@ void dcn32_program_mall_pipe_config(struct dc *dc, struct dc_state *context)
 	if (hws && hws->funcs.update_mall_sel)
 		hws->funcs.update_mall_sel(dc, context);
 
-	//update subvp force pstate
-	if (hws && hws->funcs.subvp_update_force_pstate)
-		dc->hwseq->funcs.subvp_update_force_pstate(dc, context);
-
 	// Program FORCE_ONE_ROW_FOR_FRAME and CURSOR_REQ_MODE for main subvp pipes
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
index 2a5376eb9d66..6694c1d14aa3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
@@ -67,7 +67,7 @@ void dcn32_program_mall_pipe_config(struct dc *dc, struct dc_state *context);
 
 void dcn32_update_mall_sel(struct dc *dc, struct dc_state *context);
 
-void dcn32_subvp_update_force_pstate(struct dc *dc, struct dc_state *context);
+void dcn32_update_force_pstate(struct dc *dc, struct dc_state *context);
 
 void dcn32_update_odm(struct dc *dc, struct dc_state *context, struct pipe_ctx *pipe_ctx);
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index dcb81662884f..8085f2acb1a9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -149,7 +149,7 @@ static const struct hwseq_private_funcs dcn32_private_funcs = {
 	.dccg_init = dcn20_dccg_init,
 	.set_mcm_luts = dcn32_set_mcm_luts,
 	.program_mall_pipe_config = dcn32_program_mall_pipe_config,
-	.subvp_update_force_pstate = dcn32_subvp_update_force_pstate,
+	.update_force_pstate = dcn32_update_force_pstate,
 	.update_mall_sel = dcn32_update_mall_sel,
 	.calculate_dccg_k1_k2_values = dcn32_calculate_dccg_k1_k2_values,
 	.set_pixels_per_cycle = dcn32_set_pixels_per_cycle,
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
index ecfa395f5fa8..80972ee5e55b 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn30/dcn30_fpu.c
@@ -389,6 +389,10 @@ void dcn30_fpu_calculate_wm_and_dlg(
 	dc_assert_fp_enabled();
 
 	context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = false;
+    for (i = 0; i < context->stream_count; i++) {
+		if (context->streams[i])
+			context->streams[i]->fpo_in_use = false;
+	}
 
 	if (!pstate_en) {
 		/* only when the mclk switch can not be natural, is the fw based vblank stretch attempted */
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
index 6ab60facc091..1e26adf987cc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1960,6 +1960,10 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 	}
 
 	context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching = false;
+	for (i = 0; i < context->stream_count; i++) {
+		if (context->streams[i])
+			context->streams[i]->fpo_in_use = false;
+	}
 
 	if (!pstate_en || (!dc->debug.disable_fpo_optimizations &&
 			pstate_en && vlevel != 0)) {
@@ -2199,10 +2203,6 @@ void dcn32_calculate_wm_and_dlg_fpu(struct dc *dc, struct dc_state *context,
 		context->bw_ctx.dml.soc.dram_clock_change_latency_us =
 				dc->clk_mgr->bw_params->wm_table.nv_entries[WM_A].dml_input.pstate_latency_us;
 
-	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
-		dcn30_setup_mclk_switch_using_fw_based_vblank_stretch(dc, context);
-	}
-
 	/* revert fclk lat changes if required */
 	if (need_fclk_lat_as_dummy)
 		context->bw_ctx.dml.soc.fclk_change_latency_us =
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
index b5d353c41aa9..ccf8861483a0 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/hubp.h
@@ -203,6 +203,7 @@ struct hubp_funcs {
 	void (*hubp_soft_reset)(struct hubp *hubp, bool reset);
 
 	void (*hubp_update_force_pstate_disallow)(struct hubp *hubp, bool allow);
+	void (*hubp_update_force_cursor_pstate_disallow)(struct hubp *hubp, bool allow);	
 	void (*hubp_update_mall_sel)(struct hubp *hubp, uint32_t mall_sel, bool c_cursor);
 	void (*hubp_prepare_subvp_buffering)(struct hubp *hubp, bool enable);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
index 5f63b67975cf..4513544559be 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
@@ -154,7 +154,7 @@ struct hwseq_private_funcs {
 	void (*setup_hpo_hw_control)(const struct dce_hwseq *hws, bool enable);
 #ifdef CONFIG_DRM_AMD_DC_FP
 	void (*program_mall_pipe_config)(struct dc *dc, struct dc_state *context);
-	void (*subvp_update_force_pstate)(struct dc *dc, struct dc_state *context);
+	void (*update_force_pstate)(struct dc *dc, struct dc_state *context);
 	void (*update_mall_sel)(struct dc *dc, struct dc_state *context);
 	unsigned int (*calculate_dccg_k1_k2_values)(struct pipe_ctx *pipe_ctx,
 			unsigned int *k1_div,
-- 
2.34.1


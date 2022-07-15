Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30351CCA479
	for <amd-gfx@archiver.kernel.org>; Sat, 16 Jul 2022 14:40:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 50C1B10FF41;
	Sat, 16 Jul 2022 14:36:22 +0000 (UTC)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2059.outbound.protection.outlook.com [40.107.95.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 733C510E1EA
 for <amd-gfx@lists.freedesktop.org>; Fri, 15 Jul 2022 18:17:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DpKRleG+tggMdluA7seaqZ2GjtRit+7kg4bCFSda2t0owoJDfsnGFqX1C5k5uqtvE6CZ1VyiQ7OkzmcjTjrGMx7i8Gern6eHgOxmJdyhxxoxqRHGnR+LW1ryBu5Yy/515PpGOW3+LMv6pb9tuE1bs+pEHp4DeRs4NuRTyW1m7EUcqAOyfxQU4wJ5GPULJEJ7UqISC1tseHa3p9gulv/4eiMB8sW4Tp3CncXxZOpjJvBiJxqtCvLg75h9/5150R0ZbIUgu+iaZnyR7H1VvLA58ni27UKTjwe/SVaxYL6ZZlFF/RXrzF1e2Zks8kxXmPfA24OvdU2Z0oXJ6Uorch4A2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQME0GAWIbB3rZ9ukXsN46m8HADFYdHOyzpkMWNeiaQ=;
 b=FPaAxNGn9MhBG1o0OijhGiySkjittwKjYUf4eDgffwO34lbt4K/n7yEjG7SVCuxqBw7DeBgx1HDDk4bkiCMImalvxKG+FaVfyGfXHGLSIABnhWA55G/3LUXYLOD6LpeLJB+5OgoJFNJCSCgrblUfmunue8ZmJh1Dpc28pt47k0FfRwNiw7C3eit7yrJ/ybPqAQVM7EhNswTgyRzs2rxsq90nDB8WY9ITRyZ3TQUpeOmjt8PypQtZrIxbsUhO51bC1Zxggy61TbQodKYspJFBpXk9U1qpwGKSQNlJQ5M6eVvVZbBhRHTpjtnFRhaLYcMc7sqL4I3ZhLHYb33EhPHIKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FQME0GAWIbB3rZ9ukXsN46m8HADFYdHOyzpkMWNeiaQ=;
 b=GmLj7ui9TVZvd++gTkK3581uIezQ7wlARP2jR72VHZpQGewljxcC4mQwbGO2qsDIe3DsKDmKxC3yjSwAihPyU+dlTrQHBo+MysZCrcZb9ZYciz1Oesg0vzVlikMjb89bDGX2WZWKk85h+S61e4QGagyqAz2EydYzhdmKB84Uv9w=
Received: from MW4PR03CA0134.namprd03.prod.outlook.com (2603:10b6:303:8c::19)
 by SJ1PR12MB6145.namprd12.prod.outlook.com (2603:10b6:a03:45c::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 18:17:43 +0000
Received: from CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8c:cafe::56) by MW4PR03CA0134.outlook.office365.com
 (2603:10b6:303:8c::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.22 via Frontend
 Transport; Fri, 15 Jul 2022 18:17:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1NAM11FT059.mail.protection.outlook.com (10.13.174.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5438.12 via Frontend Transport; Fri, 15 Jul 2022 18:17:42 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:41 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 15 Jul
 2022 13:17:41 -0500
Received: from arch-sec.hitronhub.home (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via
 Frontend Transport; Fri, 15 Jul 2022 13:17:40 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 13/31] drm/amd/display: Update de-tile override to anticipate
 pipe splitting
Date: Fri, 15 Jul 2022 14:16:47 -0400
Message-ID: <20220715181705.1030401-14-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
References: <20220715181705.1030401-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9b471412-89f7-4d27-858b-08da668e4f61
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6145:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eAhAYVtlkUMRi9ccm8kAxwiI9ctAhlUpHlIu6cUmhP93YQHrpxDcX2IGXyzgvMi7Kz8T+m+b+JnU5x59F337EG5B7/QzrTkIf1dGtxJMrHwvKcwYWvAczS/BXoSpxlfPSct/Wk4mmJA4BHvwVHN5yVatkZwKpppvpesy+cNvnncFMEE7o64WantFInVlBr3u0hMc8CcWc2TJxxC52lWgCztWwMCAyYImLWmeBhGPDh07yAkeIzH4Hsqw9SHAvBIf2kdBmGEcyCNZ/2GFxJo9mKX3e+xXDZVclvdRYHRLYZpfA3xnrzxPxtr8zZS5Cy8m0wfy6B7vu0K/Fl4aBEObznCJLkXSq+mGpc6nbmaYE8BNAsrLMh/ZA48tballJjTZEnE1zVcgRyLoxIosdgkrJLLxMIk2JOVfRimKHDP2GrYeUtGgsTmGGNC5vevxKhp7nY5kH0aLuppqOPMVh1+yLERn25T2140wNn4sqUzdcPIR6JeyIedmNZIDO+1dZufH0YIBO8UdWkpnM9ZMELHQX0mw1fX50IwUXJPmJwGmAKWAkOf3ZL7wTsvok8dB7q6U8KdpAvrTx2TEjxN72eGGB/IIMKdD5nwTfkbqhsm+H4GYJ6t4E6b7ls2j0zt81/CJNzJbZVgNBWPQXNBA2qFFkroh5hXkBL/6xYc1himSiS66ypRbyZ62zJouwD/Li4wKO5A4NO4CKK4cnIEwVPcRycAGJhm+nDULSorjeY3kIb35C0QKTvYa+lMVDahzS7wI3kClMWrAEoBvm7VpJjrwauEaDlw5IHYlytB0cRcLiasguGbkjlsZGY4vekjHDZqWKoy3r5AfSYEgGqC8k1L0kY3drVoKJJSrigecnudfC0Y=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(39860400002)(396003)(346002)(376002)(136003)(46966006)(36840700001)(40470700004)(478600001)(2616005)(82310400005)(26005)(54906003)(316002)(82740400003)(6916009)(41300700001)(86362001)(40480700001)(40460700003)(356005)(81166007)(336012)(83380400001)(36860700001)(426003)(47076005)(5660300002)(2906002)(15650500001)(36756003)(70206006)(1076003)(70586007)(8936002)(4326008)(8676002)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 18:17:42.7652 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b471412-89f7-4d27-858b-08da668e4f61
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6145
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
Cc: stylon.wang@amd.com, Alan
 Liu <HaoPing.Liu@amd.com>, Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Taimur Hassan <Syed.Hassan@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Taimur Hassan <Syed.Hassan@amd.com>

[Why]
For certain MPO configurations, DML will split a pipe after DET buffer has
already been allocated by driver, resulting in allocation of more DET
segments than the configurable return buffer has, causing underflow.

[How]
Determine during DET override calculation whether or not a pipe will be
split later on by DML, and distribute DET segments based on expected
number of pipes.

Reviewed-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Taimur Hassan <Syed.Hassan@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  22 ++--
 .../drm/amd/display/dc/dcn32/dcn32_resource.h |   6 +-
 .../display/dc/dcn32/dcn32_resource_helpers.c | 112 +++++++++---------
 3 files changed, 69 insertions(+), 71 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 92d87745d933..631876832dfa 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2984,7 +2984,7 @@ int dcn32_populate_dml_pipes_from_context(
 	int i, pipe_cnt;
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe;
-	bool subvp_in_use = false;
+	bool subvp_in_use = false, is_pipe_split_expected[MAX_PIPES];
 
 	dcn20_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
 
@@ -3046,6 +3046,9 @@ int dcn32_populate_dml_pipes_from_context(
 			if (dc->debug.enable_single_display_2to1_odm_policy)
 				pipes[pipe_cnt].pipe.dest.odm_combine_policy = dm_odm_combine_policy_2to1;
 		}
+
+		is_pipe_split_expected[i] = dcn32_predict_pipe_split(context, pipes[i].pipe, i);
+
 		pipe_cnt++;
 	}
 
@@ -3053,8 +3056,7 @@ int dcn32_populate_dml_pipes_from_context(
 	 * the DET available for each pipe). Use the DET override input to maintain our driver
 	 * policy.
 	 */
-	switch (pipe_cnt) {
-	case 1:
+	if (pipe_cnt == 1 && !is_pipe_split_expected[0]) {
 		pipes[0].pipe.src.det_size_override = DCN3_2_MAX_DET_SIZE;
 		if (pipe->plane_state && !dc->debug.disable_z9_mpc) {
 			if (!is_dual_plane(pipe->plane_state->format)) {
@@ -3065,18 +3067,8 @@ int dcn32_populate_dml_pipes_from_context(
 					pipes[0].pipe.src.det_size_override = 320; // 5K or higher
 			}
 		}
-		break;
-	case 2:
-	case 3:
-	case 4:
-		// For 2 and 3 pipes, use (MAX_DET_SIZE / pipe_cnt), for 4 pipes use default size for each pipe
-		for (i = 0; i < pipe_cnt; i++) {
-			pipes[i].pipe.src.det_size_override = (pipe_cnt < 4) ? (DCN3_2_MAX_DET_SIZE / pipe_cnt) : DCN3_2_DEFAULT_DET_SIZE;
-		}
-		break;
-	}
-
-	dcn32_update_det_override_for_mpo(dc, context, pipes);
+	} else
+		dcn32_determine_det_override(context, pipes, is_pipe_split_expected, pipe_cnt);
 
 	// In general cases we want to keep the dram clock change requirement
 	// (prefer configs that support MCLK switch). Only override to false
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
index db4546317cb5..10254ab7e9d9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.h
@@ -100,7 +100,9 @@ bool dcn32_all_pipes_have_stream_and_plane(struct dc *dc,
 bool dcn32_subvp_in_use(struct dc *dc,
 		struct dc_state *context);
 
-void dcn32_update_det_override_for_mpo(struct dc *dc, struct dc_state *context,
-	display_e2e_pipe_params_st *pipes);
+bool dcn32_predict_pipe_split(struct dc_state *context, display_pipe_params_st pipe, int index);
+
+void dcn32_determine_det_override(struct dc_state *context, display_e2e_pipe_params_st *pipes,
+		bool *is_pipe_split_expected, int pipe_cnt);
 
 #endif /* _DCN32_RESOURCE_H_ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
index e001f6d1f6c3..a6ef1dba01fe 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource_helpers.c
@@ -26,6 +26,8 @@
 // header file of functions being implemented
 #include "dcn32_resource.h"
 #include "dcn20/dcn20_resource.h"
+#include "dml/dcn32/display_mode_vba_util_32.h"
+
 /**
  * ********************************************************************************************
  * dcn32_helper_populate_phantom_dlg_params: Get DLG params for phantom pipes and populate pipe_ctx
@@ -195,66 +197,68 @@ bool dcn32_subvp_in_use(struct dc *dc,
 	return false;
 }
 
-/* For MPO we adjust the DET allocation to ensure we have enough DET buffer when an MPO pipe
- * is removed. For example for 1 MPO + 1 non-MPO normally we would allocate 6 DET segments
- * for each pipe [6, 6, 6]. But when transitioning out of MPO it would change from
- * [6, 6, 6] -> [9, 9]. However, if VUPDATE for the non-MPO pipe comes first we would be
- * trying to allocate more DET than what's currently available which would result in underflow.
- *
- * In this case we must ensure there is enough buffer when transitioning in and out of MPO:
- *
- * 1 MPO (2 plane) + 1 non-MPO case:
- * [4, 4, 9]<->[9, 9]: Allocate 4 each for MPO pipes, and maintain 9 for non-MPO pipe
- *
- * 1 MPO (2 plane) + 2 non-MPO case:
- * [3, 3, 5, 5]<->[6, 6, 6]
- *
- * 1 MPO (3 plane) + 1 non-MPO case:
- * [3, 3, 3, 9]<->[4, 4, 9] or [3, 3, 3, 6]<->[9, 9]
- *
- * For multi-display MPO case all pipes will have 4 segments:
- * Removing MPO on one of the displays will result in 3 pipes
- * (1 MPO and 1 non-MPO which is covered by single MPO stream case).
- */
-void dcn32_update_det_override_for_mpo(struct dc *dc, struct dc_state *context,
-	display_e2e_pipe_params_st *pipes)
+bool dcn32_predict_pipe_split(struct dc_state *context, display_pipe_params_st pipe, int index)
 {
-	uint8_t i, mpo_stream_index, pipe_cnt;
-	uint8_t mpo_stream_count = 0;
-	uint8_t mpo_planes = 0; // Only used in single display MPO case
-	unsigned int j;
-	struct resource_context *res_ctx = &context->res_ctx;
+	double pscl_throughput, pscl_throughput_chroma, dpp_clk_single_dpp, clock,
+		clk_frequency = 0.0, vco_speed = context->bw_ctx.dml.soc.dispclk_dppclk_vco_speed_mhz;
 
-	for (i = 0; i < context->stream_count; i++) {
-		if (context->stream_status[i].plane_count > 1) {
-			mpo_stream_index = i;
-			mpo_stream_count++;
-			mpo_planes = context->stream_status[i].plane_count;
-		}
-	}
+	dml32_CalculateSinglePipeDPPCLKAndSCLThroughput(pipe.scale_ratio_depth.hscl_ratio,
+			pipe.scale_ratio_depth.hscl_ratio_c,
+			pipe.scale_ratio_depth.vscl_ratio,
+			pipe.scale_ratio_depth.vscl_ratio_c,
+			context->bw_ctx.dml.ip.max_dchub_pscl_bw_pix_per_clk,
+			context->bw_ctx.dml.ip.max_pscl_lb_bw_pix_per_clk,
+			pipe.dest.pixel_rate_mhz,
+			pipe.src.source_format,
+			pipe.scale_taps.htaps,
+			pipe.scale_taps.htaps_c,
+			pipe.scale_taps.vtaps,
+			pipe.scale_taps.vtaps_c,
 
-	if (mpo_stream_count == 1) {
-		for (j = 0, pipe_cnt = 0; j < dc->res_pool->pipe_count; j++) {
-			if (!res_ctx->pipe_ctx[j].stream)
-				continue;
+			/* Output */
+			&pscl_throughput, &pscl_throughput_chroma,
+			&dpp_clk_single_dpp);
 
-			if (context->res_ctx.pipe_ctx[j].stream == context->streams[mpo_stream_index]) {
-				// For 3 plane MPO + 1 non-MPO, do [3, 3, 3, 9]
-				// For 2 plane MPO + 1 non-MPO, do [4, 4, 9]
-				if (context->stream_count - mpo_stream_count == 1)
-					pipes[pipe_cnt].pipe.src.det_size_override = DCN3_2_DET_SEG_SIZE * (mpo_planes == 2 ? 4 : 3);
-				else if (context->stream_count - mpo_stream_count == 2)
-					pipes[pipe_cnt].pipe.src.det_size_override = DCN3_2_DET_SEG_SIZE * 3;
+	clock = dpp_clk_single_dpp * (1 + context->bw_ctx.dml.soc.dcn_downspread_percent / 100);
+
+	if (clock > 0)
+		clk_frequency = vco_speed * 4.0 / ((int) (vco_speed * 4.0));
+
+	if (clk_frequency > context->bw_ctx.dml.soc.clock_limits[index].dppclk_mhz)
+		return true;
+	else
+		return false;
+}
+
+void dcn32_determine_det_override(struct dc_state *context, display_e2e_pipe_params_st *pipes,
+		bool *is_pipe_split_expected, int pipe_cnt)
+{
+	int i, j, count, stream_segments, pipe_segments[MAX_PIPES];
+
+	if (context->stream_count > 0) {
+		stream_segments = 18 / context->stream_count;
+		for (i = 0, count = 0; i < context->stream_count; i++) {
+			for (j = 0; j < pipe_cnt; j++) {
+				if (context->res_ctx.pipe_ctx[j].stream == context->streams[i]) {
+					count++;
+					if (is_pipe_split_expected[j])
+						count++;
+				}
+			}
+			pipe_segments[i] = stream_segments / count;
+		}
 
-			} else if (context->res_ctx.pipe_ctx[j].stream &&
-					context->res_ctx.pipe_ctx[j].stream != context->streams[mpo_stream_index]) {
-				// Update for non-MPO pipes
-				if (context->stream_count - mpo_stream_count == 1)
-					pipes[pipe_cnt].pipe.src.det_size_override = DCN3_2_DET_SEG_SIZE * 9;
-				else if (context->stream_count - mpo_stream_count == 2)
-					pipes[pipe_cnt].pipe.src.det_size_override = DCN3_2_DET_SEG_SIZE * 5;
+		for (i = 0; i < pipe_cnt; i++) {
+			pipes[i].pipe.src.det_size_override = 0;
+			for (j = 0; j < context->stream_count; j++) {
+				if (context->res_ctx.pipe_ctx[i].stream == context->streams[j]) {
+					pipes[i].pipe.src.det_size_override = pipe_segments[j] * DCN3_2_DET_SEG_SIZE;
+					break;
+				}
 			}
-			pipe_cnt++;
 		}
+	} else {
+		for (i = 0; i < pipe_cnt; i++)
+			pipes[i].pipe.src.det_size_override = 4 * DCN3_2_DET_SEG_SIZE; //DCN3_2_DEFAULT_DET_SIZE
 	}
 }
-- 
2.37.0


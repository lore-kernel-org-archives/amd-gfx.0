Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1571C001B0
	for <amd-gfx@archiver.kernel.org>; Wed, 19 Jul 2023 18:35:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 640B710E4E5;
	Wed, 19 Jul 2023 18:35:15 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2050.outbound.protection.outlook.com [40.107.237.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16B4610E4E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 19 Jul 2023 18:35:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6BDERa7o/EOVvXYwBHq9ec/f616fOVfO8GRh39G2+/HcwlOihPtbci6JzmMPHqJ7oipWSNdKsdV24cCOsCQ3aiTpNQdGwznB5UJbvFl3wkVGVROo1hNYLltc12pNT8u1PYYiJmdOW12WCMZfe558sxVzZOGSDP1BZNKWwI/2+dqMi/jG+6rHG+SNLxFWw6/zgSDIsPGc3ISV5Ii7hNN+zx5ykBDnZKPILqYbmMNzCowU3G5Cge0JHtaqdUgnX7LCCinQigamyYwf7bRlYF1HZ1OAvzBn14uNiRzf7csXQg/8JSGX2F9PF0s9MGi9KeTxmd6b9MoDThLIm4GU2tLNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYzRei1dE/1qK+Oh3hi57QVJvlI2gWGTaRZCj9FE0So=;
 b=BQl8467+y55jjUg97mE2pKQ9zwpUutmr3ez4BmU7oM4wxjQOnxPFJAMAersK2vftLghqrFN0qEbTkc/rVQt43hbPNfZPYBb2bLNTgRBWBNDtUGit5MQMcehBk6MWPgsdgY1Zq+wypinNGBpPLeYwgh8sBmdkBBUX4HJMcWWVi588f84PEgrsfm9OVEXnht9MzWHMIqK4unShPh41q8tZvAEidwhIzQtiwyWadXUhnYbsHSF6Y+9JC8RlmyU993mOMWCA1QgYFFA1VJhBWdZcxx1C+7o6LvLxCPJ57dbvs5rIrVZCVzEPThOSTZjFMho/qrtEbGDM7uN07AKdLNI+xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYzRei1dE/1qK+Oh3hi57QVJvlI2gWGTaRZCj9FE0So=;
 b=Qrj8ahGp+aJuemWOAHOEI/kiL0fvi9enjHBm+BjzNb1qWbYQXv7zBUE0DFhydAfwNf+ZPT353U38QIM7wL1d07XxTyM4kFsrrcdIVZhJgKIoM0/5A9IxmV90GD0N2YhwhKOMhxgTBvpOk9BuyhpMdZ8RLWAWTBHsk6vMdml1tbU=
Received: from BN0PR04CA0118.namprd04.prod.outlook.com (2603:10b6:408:ec::33)
 by CH3PR12MB8260.namprd12.prod.outlook.com (2603:10b6:610:12a::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Wed, 19 Jul
 2023 18:35:10 +0000
Received: from BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:ec:cafe::46) by BN0PR04CA0118.outlook.office365.com
 (2603:10b6:408:ec::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24 via Frontend
 Transport; Wed, 19 Jul 2023 18:35:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT027.mail.protection.outlook.com (10.13.177.96) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6588.34 via Frontend Transport; Wed, 19 Jul 2023 18:35:09 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Wed, 19 Jul
 2023 13:35:07 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 10/16] drm/amd/display: Update DPG test pattern programming
Date: Wed, 19 Jul 2023 12:28:00 -0600
Message-ID: <20230719183211.153690-11-alex.hung@amd.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719183211.153690-1-alex.hung@amd.com>
References: <20230719183211.153690-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT027:EE_|CH3PR12MB8260:EE_
X-MS-Office365-Filtering-Correlation-Id: 44cd5048-64bb-4de0-3ef4-08db8886e1e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yo9ZgRBPm+6t5fEQYibVmmd/8TWpNMpds7mqy9uX7hL/N93uMo/rYN6t2Wwz0gI4gw7neWKGD0IuRfrbsncBGYIgC3jJjlYFw5xRf1zMAzqjsIctWIngoirS81nZHShWXzkUFjzYhZ6rYvFjA9sqIBosddt0hWeaKn286CT/BiXTC+ZxsbiUxIRij7vEENDYVWbopy4FpOkQXhExPP60IW0UssuiOA1vuu8gycgl7MMQ+7+VnJzTO5TjMs48pBnHKeVlSAhvtuxbrHD1/y6IfmdIDdHWd2SNWCDXgEaqYnTMGt+EwVUu/L05btsN8JnFpgyqbqkX7euv9blaU/9BFt+WJXu9+H884TIShwwVFbxFnXmEW4AtVxW+2D/TBbBdDU6rB2PkbK763T+lyrAP3fHkz4PrbtzZQR5LzoKggRmtnKLVZ/17WhUVbZkFeP6OAQCjvzMct6d/fgNcIurDm2dq90L0Dfy35KBegazfxvE6TFqbvCEOxAQoOrCZW1S0OjPQRNwyFHvGaEPnrRJkBdl3j+6+fVe3WuHA8B76pEa3Qbq/rH967sjvfztEF4RlYlxNsBjqbqCAWVHb5EtjYoAW8bpkDuONlhm18oMUiCsZu5j8dBRND2wYQd075jfqr2I/RjP3TH1ovokZu3cYbIaHzv/1n2gH/HXqnO/oARyUmhJU044gA7L3kJnHRpbWLK0PoUE4qhNkMXg0vk093CX0LodlSbJyEDHWOeQ5jAeqHAQQyIfgG+/emLnf7pWmtqpGRy7aUPqIK8mtw+hgGQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(396003)(376002)(346002)(39860400002)(82310400008)(451199021)(36840700001)(40470700004)(46966006)(7696005)(41300700001)(8676002)(8936002)(70206006)(70586007)(6916009)(15650500001)(2906002)(6666004)(54906003)(356005)(86362001)(4326008)(316002)(36860700001)(44832011)(81166007)(47076005)(36756003)(5660300002)(2616005)(426003)(40460700003)(1076003)(186003)(336012)(26005)(83380400001)(40480700001)(82740400003)(16526019)(478600001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2023 18:35:09.9677 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44cd5048-64bb-4de0-3ef4-08db8886e1e8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT027.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8260
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
Cc: stylon.wang@amd.com, Chris Park <chris.park@amd.com>, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, Wenjing Liu <wenjing.liu@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Wenjing Liu <wenjing.liu@amd.com>

[Why]
Last ODM slice could be slightly larger than other slice because it can be
including the residual.

[How]
Update DPG pattern programming sequence to use a different width for
last odm slice.

Reviewed-by: Chris Park <chris.park@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  45 ++++----
 .../display/dc/link/accessories/link_dp_cts.c | 107 +++++++++---------
 2 files changed, 78 insertions(+), 74 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 5cfa37804d7c..e32d3246e82a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1054,9 +1054,9 @@ void dcn20_blank_pixel_data(
 	enum controller_dp_color_space test_pattern_color_space = CONTROLLER_DP_COLOR_SPACE_UDEFINED;
 	struct pipe_ctx *odm_pipe;
 	int odm_cnt = 1;
-
-	int width = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right;
-	int height = stream->timing.v_addressable + stream->timing.v_border_bottom + stream->timing.v_border_top;
+	int h_active = stream->timing.h_addressable + stream->timing.h_border_left + stream->timing.h_border_right;
+	int v_active = stream->timing.v_addressable + stream->timing.v_border_bottom + stream->timing.v_border_top;
+	int odm_slice_width, last_odm_slice_width, offset = 0;
 
 	if (stream->link->test_pattern_enabled)
 		return;
@@ -1066,8 +1066,8 @@ void dcn20_blank_pixel_data(
 
 	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
 		odm_cnt++;
-
-	width = width / odm_cnt;
+	odm_slice_width = h_active / odm_cnt;
+	last_odm_slice_width = h_active - odm_slice_width * (odm_cnt - 1);
 
 	if (blank) {
 		dc->hwss.set_abm_immediate_disable(pipe_ctx);
@@ -1080,29 +1080,32 @@ void dcn20_blank_pixel_data(
 		test_pattern = CONTROLLER_DP_TEST_PATTERN_VIDEOMODE;
 	}
 
-	dc->hwss.set_disp_pattern_generator(dc,
-			pipe_ctx,
-			test_pattern,
-			test_pattern_color_space,
-			stream->timing.display_color_depth,
-			&black_color,
-			width,
-			height,
-			0);
+	odm_pipe = pipe_ctx;
 
-	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
+	while (odm_pipe->next_odm_pipe) {
 		dc->hwss.set_disp_pattern_generator(dc,
-				odm_pipe,
-				dc->debug.visual_confirm != VISUAL_CONFIRM_DISABLE && blank ?
-						CONTROLLER_DP_TEST_PATTERN_COLORRAMP : test_pattern,
+				pipe_ctx,
+				test_pattern,
 				test_pattern_color_space,
 				stream->timing.display_color_depth,
 				&black_color,
-				width,
-				height,
-				0);
+				odm_slice_width,
+				v_active,
+				offset);
+		offset += odm_slice_width;
+		odm_pipe = odm_pipe->next_odm_pipe;
 	}
 
+	dc->hwss.set_disp_pattern_generator(dc,
+			odm_pipe,
+			test_pattern,
+			test_pattern_color_space,
+			stream->timing.display_color_depth,
+			&black_color,
+			last_odm_slice_width,
+			v_active,
+			offset);
+
 	if (!blank && dc->debug.enable_single_display_2to1_odm_policy) {
 		/* when exiting dynamic ODM need to reinit DPG state for unused pipes */
 		struct pipe_ctx *old_odm_pipe = dc->current_state->res_ctx.pipe_ctx[pipe_ctx->pipe_idx].next_odm_pipe;
diff --git a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
index db9f1baa27e5..bce0428ad612 100644
--- a/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
+++ b/drivers/gpu/drm/amd/display/dc/link/accessories/link_dp_cts.c
@@ -428,15 +428,24 @@ static void set_crtc_test_pattern(struct dc_link *link,
 		stream->timing.display_color_depth;
 	struct bit_depth_reduction_params params;
 	struct output_pixel_processor *opp = pipe_ctx->stream_res.opp;
-	int width = pipe_ctx->stream->timing.h_addressable +
+	struct pipe_ctx *odm_pipe;
+	int odm_cnt = 1;
+	int h_active = pipe_ctx->stream->timing.h_addressable +
 		pipe_ctx->stream->timing.h_border_left +
 		pipe_ctx->stream->timing.h_border_right;
-	int height = pipe_ctx->stream->timing.v_addressable +
+	int v_active = pipe_ctx->stream->timing.v_addressable +
 		pipe_ctx->stream->timing.v_border_bottom +
 		pipe_ctx->stream->timing.v_border_top;
+	int odm_slice_width, last_odm_slice_width, offset = 0;
 
 	memset(&params, 0, sizeof(params));
 
+	for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
+		odm_cnt++;
+
+	odm_slice_width = h_active / odm_cnt;
+	last_odm_slice_width = h_active - odm_slice_width * (odm_cnt - 1);
+
 	switch (test_pattern) {
 	case DP_TEST_PATTERN_COLOR_SQUARES:
 		controller_test_pattern =
@@ -473,16 +482,13 @@ static void set_crtc_test_pattern(struct dc_link *link,
 	{
 		/* disable bit depth reduction */
 		pipe_ctx->stream->bit_depth_params = params;
-		opp->funcs->opp_program_bit_depth_reduction(opp, &params);
-		if (pipe_ctx->stream_res.tg->funcs->set_test_pattern)
+		if (pipe_ctx->stream_res.tg->funcs->set_test_pattern) {
+			opp->funcs->opp_program_bit_depth_reduction(opp, &params);
 			pipe_ctx->stream_res.tg->funcs->set_test_pattern(pipe_ctx->stream_res.tg,
 				controller_test_pattern, color_depth);
-		else if (link->dc->hwss.set_disp_pattern_generator) {
-			struct pipe_ctx *odm_pipe;
+		} else if (link->dc->hwss.set_disp_pattern_generator) {
 			enum controller_dp_color_space controller_color_space;
-			int opp_cnt = 1;
-			int offset = 0;
-			int dpg_width = width;
+			struct output_pixel_processor *odm_opp;
 
 			switch (test_pattern_color_space) {
 			case DP_TEST_PATTERN_COLOR_SPACE_RGB:
@@ -502,36 +508,33 @@ static void set_crtc_test_pattern(struct dc_link *link,
 				break;
 			}
 
-			for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
-				opp_cnt++;
-			dpg_width = width / opp_cnt;
-			offset = dpg_width;
-
-			link->dc->hwss.set_disp_pattern_generator(link->dc,
-					pipe_ctx,
-					controller_test_pattern,
-					controller_color_space,
-					color_depth,
-					NULL,
-					dpg_width,
-					height,
-					0);
-
-			for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
-				struct output_pixel_processor *odm_opp = odm_pipe->stream_res.opp;
-
+			odm_pipe = pipe_ctx;
+			while (odm_pipe->next_odm_pipe) {
+				odm_opp = odm_pipe->stream_res.opp;
 				odm_opp->funcs->opp_program_bit_depth_reduction(odm_opp, &params);
 				link->dc->hwss.set_disp_pattern_generator(link->dc,
-						odm_pipe,
+						pipe_ctx,
 						controller_test_pattern,
 						controller_color_space,
 						color_depth,
 						NULL,
-						dpg_width,
-						height,
+						odm_slice_width,
+						v_active,
 						offset);
-				offset += offset;
+				offset += odm_slice_width;
+				odm_pipe = odm_pipe->next_odm_pipe;
 			}
+			odm_opp = odm_pipe->stream_res.opp;
+			odm_opp->funcs->opp_program_bit_depth_reduction(odm_opp, &params);
+			link->dc->hwss.set_disp_pattern_generator(link->dc,
+					odm_pipe,
+					controller_test_pattern,
+					controller_color_space,
+					color_depth,
+					NULL,
+					last_odm_slice_width,
+					v_active,
+					offset);
 		}
 	}
 	break;
@@ -540,23 +543,17 @@ static void set_crtc_test_pattern(struct dc_link *link,
 		/* restore bitdepth reduction */
 		resource_build_bit_depth_reduction_params(pipe_ctx->stream, &params);
 		pipe_ctx->stream->bit_depth_params = params;
-		opp->funcs->opp_program_bit_depth_reduction(opp, &params);
-		if (pipe_ctx->stream_res.tg->funcs->set_test_pattern)
+		if (pipe_ctx->stream_res.tg->funcs->set_test_pattern) {
+			opp->funcs->opp_program_bit_depth_reduction(opp, &params);
 			pipe_ctx->stream_res.tg->funcs->set_test_pattern(pipe_ctx->stream_res.tg,
-				CONTROLLER_DP_TEST_PATTERN_VIDEOMODE,
-				color_depth);
-		else if (link->dc->hwss.set_disp_pattern_generator) {
-			struct pipe_ctx *odm_pipe;
-			int opp_cnt = 1;
-			int dpg_width;
-
-			for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
-				opp_cnt++;
-
-			dpg_width = width / opp_cnt;
-			for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
-				struct output_pixel_processor *odm_opp = odm_pipe->stream_res.opp;
+					CONTROLLER_DP_TEST_PATTERN_VIDEOMODE,
+					color_depth);
+		} else if (link->dc->hwss.set_disp_pattern_generator) {
+			struct output_pixel_processor *odm_opp;
 
+			odm_pipe = pipe_ctx;
+			while (odm_pipe->next_odm_pipe) {
+				odm_opp = odm_pipe->stream_res.opp;
 				odm_opp->funcs->opp_program_bit_depth_reduction(odm_opp, &params);
 				link->dc->hwss.set_disp_pattern_generator(link->dc,
 						odm_pipe,
@@ -564,19 +561,23 @@ static void set_crtc_test_pattern(struct dc_link *link,
 						CONTROLLER_DP_COLOR_SPACE_UDEFINED,
 						color_depth,
 						NULL,
-						dpg_width,
-						height,
-						0);
+						odm_slice_width,
+						v_active,
+						offset);
+				offset += odm_slice_width;
+				odm_pipe = odm_pipe->next_odm_pipe;
 			}
+			odm_opp = odm_pipe->stream_res.opp;
+			odm_opp->funcs->opp_program_bit_depth_reduction(odm_opp, &params);
 			link->dc->hwss.set_disp_pattern_generator(link->dc,
-					pipe_ctx,
+					odm_pipe,
 					CONTROLLER_DP_TEST_PATTERN_VIDEOMODE,
 					CONTROLLER_DP_COLOR_SPACE_UDEFINED,
 					color_depth,
 					NULL,
-					dpg_width,
-					height,
-					0);
+					last_odm_slice_width,
+					v_active,
+					offset);
 		}
 	}
 	break;
-- 
2.41.0


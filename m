Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BFC7C433EF
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jun 2022 19:14:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BF0C11A21C;
	Thu, 30 Jun 2022 19:14:04 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9D2810EC70
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jun 2022 19:13:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oJndupGMFjGw/9xhrUMVsOFlCCvmFsVWCQ32JTM/vJKEZdaiY0zeRvQUB+Q7LiJ0MT/6cyzIYzz3Y+dDZ51WUpbxjC9toY1orc2S5GFtcUQz6IkvoEOhoDOe8wk1omALETX0CAl6lqSIcsqhOWac23AgbACHiYdimYGXAHu4s0agvNA/LVCXwOR+7+s0TX77EC9m3QRBxO9eFZmYm9iGzXOS56UoDDzoGGRE9w0SULkPzTnjEk0+ATzECEfr4YqhgxKgXUolBBIhEV5IbpOYl6X6rOpjUoknwKmIBHN7aNf9FqHJy/UUFLO4OZbxU80ML+Au/M3qVGotsDoFS8fFpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sX9aMZhzT6TUWBM2h5hBZ5W3r4vYvEe8YA1cTw9w4Go=;
 b=fvc7IED8lyEOubIcZhVEc/TOvTDLXlk1MQZhqKxLJj94roam9sr+8WMeZ7/2+611KdMxzmwV1xTWsqpkYnKH8M3UixT8GOq49U92QqwnBIKJ6OWdQmWO1r/4mnXTOZfdsWiBcyjg+drzWBcYhlev0TfXSUvnpCcjDTEmgfjl2XJ/qOmQUO6Usk8Sb7lU4iTDYViHIHNRcDCBaIF/facnJCltVc+qUcLAztZKv34Q/fXwopOOMAzjRROYsZUmjXO6VCS972OwyFcmn3E1MOqCM2mO9BQw/Mr/caw3Q/hIUYK6ntbePqdRDh7jFihRFpwxhUz/lZwl+vYR5LmeCggzwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sX9aMZhzT6TUWBM2h5hBZ5W3r4vYvEe8YA1cTw9w4Go=;
 b=sySoIcRjwN7Ecg69D7eflhh7bFVzHdBRBuhNGwMQx5ooNWm1Dw7rk/5vSrpS2zgUxPaZFuFodjrmXJgPwv4fTEdFK0zap/vrIDcBHBdR8D4CVdNhHJfCAVgsKKQRlJ3JXNv2bkQDs2FI1OULBc6WmnFK36BGKLX3bAYuUVE4DqY=
Received: from BN0PR04CA0060.namprd04.prod.outlook.com (2603:10b6:408:e8::35)
 by BL0PR12MB2465.namprd12.prod.outlook.com (2603:10b6:207:45::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 19:13:56 +0000
Received: from BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e8:cafe::a3) by BN0PR04CA0060.outlook.office365.com
 (2603:10b6:408:e8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14 via Frontend
 Transport; Thu, 30 Jun 2022 19:13:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT045.mail.protection.outlook.com (10.13.177.47) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5395.14 via Frontend Transport; Thu, 30 Jun 2022 19:13:56 +0000
Received: from atma2.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Thu, 30 Jun
 2022 14:13:55 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 07/40] drm/amd/display: Change DET policy for MPO cases
Date: Thu, 30 Jun 2022 15:12:49 -0400
Message-ID: <20220630191322.909650-8-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
References: <20220630191322.909650-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 817d4996-9d7c-4532-bf8b-08da5accae13
X-MS-TrafficTypeDiagnostic: BL0PR12MB2465:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: acYcR53AbWWVS1PqUxwnF405Cw+wY4jhMUvs5a+vKqE60JfxKgG5OLZOh8equ2BTeReGfbWZkq2Kg9CN2bKa/DSKAG0Tr9sVGnXNHToY2SV9RkZBS2NP2Znh3TCRxzTaaCzSbeIFVMnqW9T5B6t1oS9VWypUhZxRe32sP7mkrfP6h8t7d4C45vhVE/WJPho0b6gFw4ssA5l3O89ts/PFvrH94xa3RK3RJZuG+C36NQHop2ogJerL4xjFjDnzBQhONTbPmIFNCUHrzwBnX0pa04m3uDHYOWFKOc3ct2bYo20XILXk8/ggnSm4GgnposvXied8dEwA/hOQe0tB59o6B2s1gbjljQn12IXovrpu+ZsWLzC9xkHcppXA2Rw7UM08cbtQ0L4Mx2jxpXXOW9L/YRyi2kBck6M/Nu1rSOID+CIXvmYSCAuyQbG+8lCBEGonrO1V/KaSQWo7kYkGrKtLbt2q4znaouZBVXLuASr9Tiuu05eedAtvSjn3Y/ZrSbjXLSEhYPa9kDpXyZheU474H2URzayn++hoSlMzFW8kIQaXGzbD8q6dq2WracZjFBoZjGlBV97ME5UYSde3EmuQQuad0kOH0/UgEMfHFIWvje/RrxuHs61QE0HBuhWduLeSwyqGP7QGOz0hkOro6OG1evN2GCs8l20LtC6+vSZlbM9TLKvQJBK9R35Zzhp9cOuWEmhJNvdxUskzwkiaW89u76dQuFTOC2dX/skc2ziBZgUZbCRxwr7UJ1juF8Wq4bzgfBETShfiyK5j540uSykGwOzHflgnRo2ugoJjCYnbXu5yHMZ3PXJX6d9ZZhDAt8MpCrfaXVW11euT0aDVj9mbLGVu443kwK4fcuNH0OBPCTk=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(346002)(136003)(376002)(396003)(39860400002)(46966006)(40470700004)(36840700001)(70206006)(4326008)(70586007)(8676002)(1076003)(36860700001)(26005)(86362001)(478600001)(40480700001)(40460700003)(7696005)(82740400003)(6666004)(41300700001)(83380400001)(8936002)(36756003)(2906002)(356005)(82310400005)(47076005)(426003)(54906003)(2616005)(336012)(316002)(16526019)(81166007)(5660300002)(186003)(6916009)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 19:13:56.6079 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 817d4996-9d7c-4532-bf8b-08da5accae13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2465
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
 Alvin Lee <Alvin.Lee2@amd.com>, solomon.chiu@amd.com, jerry.zuo@amd.com,
 Aurabindo.Pillai@amd.com, hamza.mahfooz@amd.com, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

For MPO we want to allocate less than maximum DET for MPO pipes because
we need enogh buffer to move DET back to toher pipes when removing an
MPO plane. Also update regular DET allocation to use DET override (DCN32
has an internal policy which driver does not want to use)

Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c | 34 ++++++++++++-------
 .../drm/amd/display/dc/dml/display_mode_vba.c |  2 +-
 2 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 468c18acfcdc..63227c55a2f0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -3045,31 +3045,35 @@ int dcn32_populate_dml_pipes_from_context(
 		pipe_cnt++;
 	}
 
+	/* For DET allocation, we don't want to use DML policy (not optimal for utilizing all
+	 * the DET available for each pipe). Use the DET override input to maintain our driver
+	 * policy.
+	 */
 	switch (pipe_cnt) {
 	case 1:
-		context->bw_ctx.dml.ip.det_buffer_size_kbytes = DCN3_2_MAX_DET_SIZE;
+		pipes[0].pipe.src.det_size_override = DCN3_2_MAX_DET_SIZE;
 		if (pipe->plane_state && !dc->debug.disable_z9_mpc) {
 			if (!is_dual_plane(pipe->plane_state->format)) {
-				context->bw_ctx.dml.ip.det_buffer_size_kbytes = DCN3_2_DEFAULT_DET_SIZE;
+				pipes[0].pipe.src.det_size_override = DCN3_2_DEFAULT_DET_SIZE;
 				pipes[0].pipe.src.unbounded_req_mode = true;
 				if (pipe->plane_state->src_rect.width >= 5120 &&
 					pipe->plane_state->src_rect.height >= 2880)
-					context->bw_ctx.dml.ip.det_buffer_size_kbytes = 320; // 5K or higher
+					pipes[0].pipe.src.det_size_override = 320; // 5K or higher
 			}
 		}
 		break;
 	case 2:
-		context->bw_ctx.dml.ip.det_buffer_size_kbytes = DCN3_2_MAX_DET_SIZE / 2; // 576 KB (9 segments)
-		break;
 	case 3:
-		context->bw_ctx.dml.ip.det_buffer_size_kbytes = DCN3_2_MAX_DET_SIZE / 3; // 384 KB (6 segments)
-		break;
 	case 4:
-	default:
-		context->bw_ctx.dml.ip.det_buffer_size_kbytes = DCN3_2_DEFAULT_DET_SIZE; // 256 KB (4 segments)
+		// For 2 and 3 pipes, use (MAX_DET_SIZE / pipe_cnt), for 4 pipes use default size for each pipe
+		for (i = 0; i < pipe_cnt; i++) {
+			pipes[i].pipe.src.det_size_override = (pipe_cnt < 4) ? (DCN3_2_MAX_DET_SIZE / pipe_cnt) : DCN3_2_DEFAULT_DET_SIZE;
+		}
 		break;
 	}
 
+	dcn32_update_det_override_for_mpo(dc, context, pipes);
+
 	return pipe_cnt;
 }
 
@@ -3365,8 +3369,8 @@ void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context, display
 			context->res_ctx.pipe_ctx[i].det_buffer_size_kb = 0;
 			context->res_ctx.pipe_ctx[i].unbounded_req = false;
 		} else {
-			context->res_ctx.pipe_ctx[i].det_buffer_size_kb =
-					context->bw_ctx.dml.ip.det_buffer_size_kbytes;
+			context->res_ctx.pipe_ctx[i].det_buffer_size_kb = get_det_buffer_size_kbytes(&context->bw_ctx.dml, pipes, pipe_cnt,
+							pipe_idx);
 			context->res_ctx.pipe_ctx[i].unbounded_req = pipes[pipe_idx].pipe.src.unbounded_req_mode;
 		}
 		if (context->bw_ctx.bw.dcn.clk.dppclk_khz < pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000)
@@ -3383,8 +3387,12 @@ void dcn32_calculate_dlg_params(struct dc *dc, struct dc_state *context, display
 	context->bw_ctx.bw.dcn.clk.max_supported_dispclk_khz = context->bw_ctx.dml.soc.clock_limits[vlevel].dispclk_mhz
 			* 1000;
 
-	context->bw_ctx.bw.dcn.compbuf_size_kb = context->bw_ctx.dml.ip.config_return_buffer_size_in_kbytes
-			- context->bw_ctx.dml.ip.det_buffer_size_kbytes * pipe_idx;
+	context->bw_ctx.bw.dcn.compbuf_size_kb = context->bw_ctx.dml.ip.config_return_buffer_size_in_kbytes;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		if (context->res_ctx.pipe_ctx[i].stream)
+			context->bw_ctx.bw.dcn.compbuf_size_kb -= context->res_ctx.pipe_ctx[i].det_buffer_size_kb;
+	}
 
 	for (i = 0, pipe_idx = 0; i < dc->res_pool->pipe_count; i++) {
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
index 74e17f5da8dc..5185c2ccdfd5 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_vba.c
@@ -561,8 +561,8 @@ static void fetch_pipe_params(struct display_mode_lib *mode_lib)
 		mode_lib->vba.GPUVMMinPageSizeKBytes[mode_lib->vba.NumberOfActivePlanes] = src->gpuvm_min_page_size_kbytes;
 		mode_lib->vba.RefreshRate[mode_lib->vba.NumberOfActivePlanes] = dst->refresh_rate; //todo remove this
 		mode_lib->vba.OutputLinkDPRate[mode_lib->vba.NumberOfActivePlanes] = dout->dp_rate;
-
 		mode_lib->vba.ODMUse[mode_lib->vba.NumberOfActivePlanes] = dst->odm_combine_policy;
+		mode_lib->vba.DETSizeOverride[mode_lib->vba.NumberOfActivePlanes] = src->det_size_override;
 		//TODO: Need to assign correct values to dp_multistream vars
 		mode_lib->vba.OutputMultistreamEn[mode_lib->vba.NumberOfActiveSurfaces] = dout->dp_multistream_en;
 		mode_lib->vba.OutputMultistreamId[mode_lib->vba.NumberOfActiveSurfaces] = dout->dp_multistream_id;
-- 
2.25.1


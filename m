Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF154C25B07
	for <amd-gfx@archiver.kernel.org>; Fri,  5 Aug 2022 17:59:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C58E18A7D8;
	Fri,  5 Aug 2022 17:59:11 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 407C4A6A55
 for <amd-gfx@lists.freedesktop.org>; Fri,  5 Aug 2022 17:59:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VgjiyJi1mQFk6Pt0iKb48+q5XDwizVgcmSq4VuozsR+fsgr2TA9RVbqackSYuzfDn8ALTcn6Qf5OVYENnMbuc643h4F67PTYiFi1Jgi5vpRRt6fTf9Tumi/ygO/qMsEsc5X2isPXBnUx+NFIFY3LefjtsDmEnIQZXlPM+YD1D5tsEv4wZa7ig3gdhamUZtZ3XrUlASCiS6aUyAJLZj2WS/uMhT0hxTFSpVvCQ8ZXywGvCuu5Kvjly3Rh7XpK2Gq/jbZMhBLvVNPn5C4mygrB41GDRnd1tAAeIBWLmtay00utMQ0jKU3Y2sGgXOF1kA7NaZM6WP+dqLrj/K/BOEq3ZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rgDjyDn73QmXGOLXu5AJcnr0S0c5YbAe03M5bBMDNRc=;
 b=a+CX7ZAL5e83TsHsbd/W6ZgpxM0YrPEf1IGTCiXxxbjpxcL1KLBwI7+ogPnyuemuFaUauBImNIiquzIsuZt1MtD7T5jxey6OTnvo+JHuvrtD6FFMOSKgZRxKjKplG8RJ5n8ZKy/AJlCdpXv4D7FcMP5VdfmSgzc7lW1YV4IFFN7xeiz/z+Zt/Xnx5+GNwZIQcdxrkGuf5zEmXfGTrey8HncIcjLKatjENc8Rc3w82uxTdcU1oKKgABMRoUhdh93+ZXfaCzbpARsHS5312XhFqaF7In5PVVi84be6erZRHuAAnUoNSNlnWaUpRZj8MUk2o1kPZqEnhjA7f1cVRZtr8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rgDjyDn73QmXGOLXu5AJcnr0S0c5YbAe03M5bBMDNRc=;
 b=JUy7nZLWLvIf0Dm+nIErwxztv9MuKRPqa/SquspkJSvAICrv/RDHICuoxDtCfFZhRWmI57dOBbb8BSAxKVUCa632V8DyN9U1VT0ydDmNZcn30AZvvx9yreywLOkxGb2YVe/xWYO3tngPQRIC55Oui1BB8FjPUlwvOtKiSYvRPzs=
Received: from MW4PR03CA0057.namprd03.prod.outlook.com (2603:10b6:303:8e::32)
 by BL0PR12MB4708.namprd12.prod.outlook.com (2603:10b6:208:8d::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Fri, 5 Aug
 2022 17:58:56 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8e:cafe::9b) by MW4PR03CA0057.outlook.office365.com
 (2603:10b6:303:8e::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.12 via Frontend
 Transport; Fri, 5 Aug 2022 17:58:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5504.14 via Frontend Transport; Fri, 5 Aug 2022 17:58:56 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 5 Aug
 2022 12:58:55 -0500
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Fri, 5 Aug 2022 12:58:49 -0500
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/32] drm/amd/display: Move populate dml pipes from DCN314 to
 dml
Date: Sat, 6 Aug 2022 01:57:57 +0800
Message-ID: <20220805175826.2992171-4-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
References: <20220805175826.2992171-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5cb56ec-8c97-4180-9c71-08da770c2a9b
X-MS-TrafficTypeDiagnostic: BL0PR12MB4708:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bjD9rwetbjWuSxf4w6G586I+y+9lP3D6hXBfZgFwYtWay1F+q8Qk/Y0ob5U4TKFEESyOqn/XbAjRQhOrwHbEoHNR2OVzN1eFUNfI4YIY+V1d4RpG7OltkBcFxe3XafDmJDtos+HJSON6uE5yB5dL3RLttEFG5Tkeov/RJnMPtVsu1sZ/mOHzGF5BUgKZQ+Ur9O+mehUllhx9ptnA1PO14SGF+0QvNRsD1ka5BP3QpU2HJW3VBYrTcv9HAYcWdbRrCWi/2DmGqyp3OJTThxKjjK4g+D9PzqbfMZ7IaesnM+QcMKbvlkpIF2fwRMeVRJm6dn6im9qSnM5maPV7Nn5yRBLkv1b8lmNQU5SbTPsMZi3rOh8IB/cjwMs8Q1UHZOP53ghXNiwzW3YuKe5dhgjue1+uI1eFeVh8f0BPPXcc+AFakPuCDY/E0u2wp8aUK6GDAnNHz3yt7/DJ3eCJrFBh3L+z2v2/dBWMg/cIJYj2cDeUzrKqDD2H24/FoBkjXt6/8BWDeRhU7sWgrF3LVvDPfdBjjHTeddF88DgpTPS5hKstCAjnuYxVsCUcSdSqcPjKH6D5l/nhfP4R/cdy3aZpZC+SJvR+t4KGRpNvNY4YfPa1zRrOjkXrCtZOsIwNrNvrq2gdUzrASe03TbbZSEZbREWtLJ8/QaKWxnRX5W6Kb7y55BPlHtfQ3apwOmh0bhsyWuPmVo4WAON0crrfvqw+TPeSV1Z/gp+SGb6fT/hnhaD7ELtjdJOhetzy8RLExlW40V6+rFe4EdU/OJ2J5ayjnLmNyv3MQgmRiW6I8x3styefbNJbbArUL0dlWh9PV9cCO3/OIOF66xM1x47SiGUW3Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(346002)(39860400002)(376002)(46966006)(40470700004)(36840700001)(54906003)(7696005)(8936002)(30864003)(2616005)(4326008)(6916009)(8676002)(316002)(5660300002)(70586007)(36860700001)(47076005)(81166007)(426003)(336012)(70206006)(1076003)(82740400003)(356005)(86362001)(83380400001)(186003)(40460700003)(41300700001)(40480700001)(6666004)(26005)(82310400005)(478600001)(36756003)(2906002)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 17:58:56.2625 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5cb56ec-8c97-4180-9c71-08da770c2a9b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4708
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

The function responsible for populating DML pipes has some FPU
operations, and for this reason, it must be moved to the dml folder.
This commit moves such function from resource to the fpu file under the
dml folder.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../amd/display/dc/dcn314/dcn314_resource.c   | 101 +---------------
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    | 110 ++++++++++++++++++
 .../amd/display/dc/dml/dcn314/dcn314_fpu.h    |   3 +
 3 files changed, 117 insertions(+), 97 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
index 376488198363..1f095f05d986 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn314/dcn314_resource.c
@@ -1645,109 +1645,16 @@ static struct clock_source *dcn31_clock_source_create(
 	return NULL;
 }
 
-static bool is_dual_plane(enum surface_pixel_format format)
-{
-	return format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN || format == SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA;
-}
-
 static int dcn314_populate_dml_pipes_from_context(
 	struct dc *dc, struct dc_state *context,
 	display_e2e_pipe_params_st *pipes,
 	bool fast_validate)
 {
-	int i, pipe_cnt;
-	struct resource_context *res_ctx = &context->res_ctx;
-	struct pipe_ctx *pipe;
-	bool upscaled = false;
-
-	dcn20_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
-
-	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
-		struct dc_crtc_timing *timing;
-
-		if (!res_ctx->pipe_ctx[i].stream)
-			continue;
-		pipe = &res_ctx->pipe_ctx[i];
-		timing = &pipe->stream->timing;
-
-		if (dc_extended_blank_supported(dc) && pipe->stream->adjust.v_total_max == pipe->stream->adjust.v_total_min
-			&& pipe->stream->adjust.v_total_min > timing->v_total)
-			pipes[pipe_cnt].pipe.dest.vtotal = pipe->stream->adjust.v_total_min;
-
-		if (pipe->plane_state &&
-				(pipe->plane_state->src_rect.height < pipe->plane_state->dst_rect.height ||
-				pipe->plane_state->src_rect.width < pipe->plane_state->dst_rect.width))
-			upscaled = true;
-
-		/*
-		 * Immediate flip can be set dynamically after enabling the plane.
-		 * We need to require support for immediate flip or underflow can be
-		 * intermittently experienced depending on peak b/w requirements.
-		 */
-		pipes[pipe_cnt].pipe.src.immediate_flip = true;
-
-		pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
-		pipes[pipe_cnt].pipe.src.hostvm = dc->res_pool->hubbub->riommu_active;
-		pipes[pipe_cnt].pipe.src.gpuvm = true;
-		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
-		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
-		pipes[pipe_cnt].pipe.dest.vfront_porch = timing->v_front_porch;
-		pipes[pipe_cnt].pipe.src.dcc_rate = 3;
-		pipes[pipe_cnt].dout.dsc_input_bpc = 0;
-
-		if (pipes[pipe_cnt].dout.dsc_enable) {
-			switch (timing->display_color_depth) {
-			case COLOR_DEPTH_888:
-				pipes[pipe_cnt].dout.dsc_input_bpc = 8;
-				break;
-			case COLOR_DEPTH_101010:
-				pipes[pipe_cnt].dout.dsc_input_bpc = 10;
-				break;
-			case COLOR_DEPTH_121212:
-				pipes[pipe_cnt].dout.dsc_input_bpc = 12;
-				break;
-			default:
-				ASSERT(0);
-				break;
-			}
-		}
-
-		pipe_cnt++;
-	}
-	context->bw_ctx.dml.ip.det_buffer_size_kbytes = DCN3_14_DEFAULT_DET_SIZE;
-
-	dc->config.enable_4to1MPC = false;
-	if (pipe_cnt == 1 && pipe->plane_state && !dc->debug.disable_z9_mpc) {
-		if (is_dual_plane(pipe->plane_state->format)
-				&& pipe->plane_state->src_rect.width <= 1920 && pipe->plane_state->src_rect.height <= 1080) {
-			dc->config.enable_4to1MPC = true;
-		} else if (!is_dual_plane(pipe->plane_state->format) && pipe->plane_state->src_rect.width <= 5120) {
-			/* Limit to 5k max to avoid forced pipe split when there is not enough detile for swath */
-			context->bw_ctx.dml.ip.det_buffer_size_kbytes = 192;
-			pipes[0].pipe.src.unbounded_req_mode = true;
-		}
-	} else if (context->stream_count >= dc->debug.crb_alloc_policy_min_disp_count
-			&& dc->debug.crb_alloc_policy > DET_SIZE_DEFAULT) {
-		context->bw_ctx.dml.ip.det_buffer_size_kbytes = dc->debug.crb_alloc_policy * 64;
-	} else if (context->stream_count >= 3 && upscaled) {
-		context->bw_ctx.dml.ip.det_buffer_size_kbytes = 192;
-	}
-
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-
-		if (!pipe->stream)
-			continue;
+	int pipe_cnt;
 
-		if (pipe->stream->signal == SIGNAL_TYPE_EDP && dc->debug.seamless_boot_odm_combine &&
-				pipe->stream->apply_seamless_boot_optimization) {
-
-			if (pipe->stream->apply_boot_odm_mode == dm_odm_combine_policy_2to1) {
-				context->bw_ctx.dml.vba.ODMCombinePolicy = dm_odm_combine_policy_2to1;
-				break;
-			}
-		}
-	}
+	DC_FP_START();
+	pipe_cnt = dcn314_populate_dml_pipes_from_context_fpu(dc, context, pipes, fast_validate);
+	DC_FP_END();
 
 	return pipe_cnt;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 340c3ca22345..d52a16d280e9 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -26,7 +26,9 @@
 
 #include "clk_mgr.h"
 #include "resource.h"
+#include "dcn31/dcn31_hubbub.h"
 #include "dcn314_fpu.h"
+#include "dml/dcn20/dcn20_fpu.h"
 #include "dml/display_mode_vba.h"
 
 struct _vcs_dpi_ip_params_st dcn3_14_ip = {
@@ -264,3 +266,111 @@ void dcn314_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_p
 	else
 		dml_init_instance(&dc->dml, &dcn3_14_soc, &dcn3_14_ip, DML_PROJECT_DCN31_FPGA);
 }
+
+static bool is_dual_plane(enum surface_pixel_format format)
+{
+	return format >= SURFACE_PIXEL_FORMAT_VIDEO_BEGIN || format == SURFACE_PIXEL_FORMAT_GRPH_RGBE_ALPHA;
+}
+
+int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *context,
+					       display_e2e_pipe_params_st *pipes,
+					       bool fast_validate)
+{
+	int i, pipe_cnt;
+	struct resource_context *res_ctx = &context->res_ctx;
+	struct pipe_ctx *pipe;
+	bool upscaled = false;
+
+	dc_assert_fp_enabled();
+
+	dcn20_populate_dml_pipes_from_context(dc, context, pipes, fast_validate);
+
+	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
+		struct dc_crtc_timing *timing;
+
+		if (!res_ctx->pipe_ctx[i].stream)
+			continue;
+		pipe = &res_ctx->pipe_ctx[i];
+		timing = &pipe->stream->timing;
+
+		if (dc_extended_blank_supported(dc) && pipe->stream->adjust.v_total_max == pipe->stream->adjust.v_total_min
+			&& pipe->stream->adjust.v_total_min > timing->v_total)
+			pipes[pipe_cnt].pipe.dest.vtotal = pipe->stream->adjust.v_total_min;
+
+		if (pipe->plane_state &&
+				(pipe->plane_state->src_rect.height < pipe->plane_state->dst_rect.height ||
+				pipe->plane_state->src_rect.width < pipe->plane_state->dst_rect.width))
+			upscaled = true;
+
+		/*
+		 * Immediate flip can be set dynamically after enabling the plane.
+		 * We need to require support for immediate flip or underflow can be
+		 * intermittently experienced depending on peak b/w requirements.
+		 */
+		pipes[pipe_cnt].pipe.src.immediate_flip = true;
+
+		pipes[pipe_cnt].pipe.src.unbounded_req_mode = false;
+		pipes[pipe_cnt].pipe.src.hostvm = dc->res_pool->hubbub->riommu_active;
+		pipes[pipe_cnt].pipe.src.gpuvm = true;
+		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
+		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
+		pipes[pipe_cnt].pipe.dest.vfront_porch = timing->v_front_porch;
+		pipes[pipe_cnt].pipe.src.dcc_rate = 3;
+		pipes[pipe_cnt].dout.dsc_input_bpc = 0;
+
+		if (pipes[pipe_cnt].dout.dsc_enable) {
+			switch (timing->display_color_depth) {
+			case COLOR_DEPTH_888:
+				pipes[pipe_cnt].dout.dsc_input_bpc = 8;
+				break;
+			case COLOR_DEPTH_101010:
+				pipes[pipe_cnt].dout.dsc_input_bpc = 10;
+				break;
+			case COLOR_DEPTH_121212:
+				pipes[pipe_cnt].dout.dsc_input_bpc = 12;
+				break;
+			default:
+				ASSERT(0);
+				break;
+			}
+		}
+
+		pipe_cnt++;
+	}
+	context->bw_ctx.dml.ip.det_buffer_size_kbytes = DCN3_14_DEFAULT_DET_SIZE;
+
+	dc->config.enable_4to1MPC = false;
+	if (pipe_cnt == 1 && pipe->plane_state && !dc->debug.disable_z9_mpc) {
+		if (is_dual_plane(pipe->plane_state->format)
+				&& pipe->plane_state->src_rect.width <= 1920 && pipe->plane_state->src_rect.height <= 1080) {
+			dc->config.enable_4to1MPC = true;
+		} else if (!is_dual_plane(pipe->plane_state->format) && pipe->plane_state->src_rect.width <= 5120) {
+			/* Limit to 5k max to avoid forced pipe split when there is not enough detile for swath */
+			context->bw_ctx.dml.ip.det_buffer_size_kbytes = 192;
+			pipes[0].pipe.src.unbounded_req_mode = true;
+		}
+	} else if (context->stream_count >= dc->debug.crb_alloc_policy_min_disp_count
+			&& dc->debug.crb_alloc_policy > DET_SIZE_DEFAULT) {
+		context->bw_ctx.dml.ip.det_buffer_size_kbytes = dc->debug.crb_alloc_policy * 64;
+	} else if (context->stream_count >= 3 && upscaled) {
+		context->bw_ctx.dml.ip.det_buffer_size_kbytes = 192;
+	}
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe->stream)
+			continue;
+
+		if (pipe->stream->signal == SIGNAL_TYPE_EDP && dc->debug.seamless_boot_odm_combine &&
+				pipe->stream->apply_seamless_boot_optimization) {
+
+			if (pipe->stream->apply_boot_odm_mode == dm_odm_combine_policy_2to1) {
+				context->bw_ctx.dml.vba.ODMCombinePolicy = dm_odm_combine_policy_2to1;
+				break;
+			}
+		}
+	}
+
+	return pipe_cnt;
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.h
index 79466d4f4185..d32c5bb99f4c 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.h
@@ -33,5 +33,8 @@
 #define DCN3_14_CRB_SEGMENT_SIZE_KB 64
 
 void dcn314_update_bw_bounding_box_fpu(struct dc *dc, struct clk_bw_params *bw_params);
+int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *context,
+					       display_e2e_pipe_params_st *pipes,
+					       bool fast_validate);
 
 #endif
-- 
2.25.1


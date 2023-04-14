Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49266C77B72
	for <amd-gfx@archiver.kernel.org>; Fri, 14 Apr 2023 15:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE28110EDA9;
	Fri, 14 Apr 2023 15:53:56 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2065.outbound.protection.outlook.com [40.107.237.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1B9810EDA9
 for <amd-gfx@lists.freedesktop.org>; Fri, 14 Apr 2023 15:53:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mq4Yuyez2L0Kb9PtsOhKxsFX0rZyRMoj2VweKGYxmgTlnljqsMw1d4sE7kqbKmYo8Hn5IlyFJDi55BRhmqFey1QrT3LDiOxun8UWRAQ0wP+tcrkLFvuxEAqGvziADFnwG6C237VFTExoTrCQLp4HLmHE9p15b0hsatXd/IiSTHsVBayxZkbp9wMiGFBOEbXmA4sBfJeihtupRFt+00sBLb/Lz+Laf1Vvux88GfrOKJmip4RjJe44A/mpYGFnLV2Cmzor5vGggS/MYwtHpsanZlnxP01YbeUbxQ6qdci5gpFf4snWZdFLHO6IU++KD4VD09cTBrfIam7TBfMVr1B2AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6r8BPsUYmZyswnClc2WD2rUsQ1HD4Hxs1ZHHF8iTR6c=;
 b=UtQpecoKbZksi/cSPgQGYOjQawYWT4y3XADBDuu30wTCjC8JpWs92jA9NyZvqwOFpUtXeoVR/nTUMXW/rOT93KC8loVRkorP8gRDwq8Bh2swtF82fm4nuZuaURtEcsoLSGPzX2HIzln9ATgPH5rId+fN/Smz0uAlHy0apC6Jrck7LpAyKZC2SGTJN164BqSSxy5X/nHB+//JDsKWJCkcuCkNjz16Ibi6uElbS80c+GozQqOjPZB6/kr7/7PZ3z5erVL4QJuQSI42x5D7MqZ+JA8pDhb5XlLcus4MuLp0NEp0DE6DtwIFU8U9wIYvig4A8PDGebGrutOv/L48slGaMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6r8BPsUYmZyswnClc2WD2rUsQ1HD4Hxs1ZHHF8iTR6c=;
 b=NKIxlT2Uqr6pRL3pmK0TgozQ1+dEz+XZDEzIKMmzFyGJDr6IUVXtrRm/ibGxhaSQsCuPTD4qDtXqyrcDBHH3EPksRdupIfuOUHdKXszG4YYGWQqBJfthEWiBJ/s/OviJqPYXZMsR5ZY1fqNp+REvLlyIgwgEdel5vwzBTKhGcjY=
Received: from DM6PR13CA0030.namprd13.prod.outlook.com (2603:10b6:5:bc::43) by
 SA1PR12MB8988.namprd12.prod.outlook.com (2603:10b6:806:38e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6298.30; Fri, 14 Apr
 2023 15:53:52 +0000
Received: from DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::ed) by DM6PR13CA0030.outlook.office365.com
 (2603:10b6:5:bc::43) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.7 via Frontend
 Transport; Fri, 14 Apr 2023 15:53:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT004.mail.protection.outlook.com (10.13.172.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6298.37 via Frontend Transport; Fri, 14 Apr 2023 15:53:51 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 14 Apr
 2023 10:53:49 -0500
From: Qingqing Zhuo <Qingqing.Zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/66] drm/amd/display: Adjust code identation and other minor
 details
Date: Fri, 14 Apr 2023 11:52:27 -0400
Message-ID: <20230414155330.5215-4-Qingqing.Zhuo@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
References: <20230414155330.5215-1-Qingqing.Zhuo@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT004:EE_|SA1PR12MB8988:EE_
X-MS-Office365-Filtering-Correlation-Id: ba55dea2-3061-44d2-254d-08db3d007181
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VNuX8hWvyOSenNExAW08TsaDpQ6aSjdz1iSciZcCLjfjk2TH9P7PchbX027yLcHrg2ORyDwJ+LoXuuluWGqmJY7zdeWYCXFfYtj7h8vIrKp1X0guqanwzU4qCScrC15N11QvwHwDO9thd2Vv8Zd3rQAHpa0FknHdDFsr2Xsg6E0rC5TnhbJAQ7v5FJRk9Ys8JZJTTS//k4OQvOuXmV8QBj/d8hWh1gSjCLn9PM09ZuUyWDwgeALc/Mqy+zNQd1Y+NOfNyPDEGqxxphezjis1jSScDjhfOhdqlxPnHUKoh+sJYBfoQrwOrd2OKoXjdD+33W4ZVqxih9Is00NZ7ZVy8iOdy0LYytbskgfiRzsEjw2kfkwDScSQjCJNMWkHqJtmijGL7GPCARlGPy16vWGFFk8Wd4M1N2FoHqAINjB63+FD7GKR0pc0VsSQgpSCPR31kGo3D3VExsjCixtkckK8gwLxd1jSwnU73uOinB+5wA6QDdldQwzYCdiCwPXnAk77wh3xAM8zqNrd8BaBPMVqz9FcxTz4YpbwDJZ2WzqdIkdeJry0DvONlt8e0WVNuKMr1H2IJTRXNLVWv3mJl5mv+O3H/LiEVwTkeK7ppop+7rWWdaw5D1DrmoyRG98FxiiWvY8WviWOucSy5CuxkaoG+dzU5TVK2QHSDeJj+R4jvBc3HQYYih8qofesjcTG++qzyfdk3SGQiuH5ievJ80CcYbT+Yoz1U+eFGxHS9FIS3rs=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(376002)(39860400002)(346002)(396003)(451199021)(46966006)(36840700001)(40470700004)(316002)(478600001)(426003)(336012)(82740400003)(36860700001)(81166007)(47076005)(4326008)(6916009)(86362001)(1076003)(26005)(6666004)(54906003)(70586007)(70206006)(186003)(16526019)(8936002)(41300700001)(2616005)(8676002)(36756003)(5660300002)(40480700001)(82310400005)(2906002)(356005)(83380400001)(30864003)(40460700003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2023 15:53:51.5859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba55dea2-3061-44d2-254d-08db3d007181
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT004.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8988
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
 solomon.chiu@amd.com, Aurabindo Pillai <aurabindo.pillai@amd.com>,
 wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

This commit replaces spaces with tabs in multiple functions and adjusts
the indentation in some other parts of the code to improve readability.

Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../drm/amd/display/dc/dcn32/dcn32_resource.c |  44 ++---
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 170 +++++++++---------
 2 files changed, 109 insertions(+), 105 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index e30d1f60695d..0beb11d95eb7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -324,7 +324,6 @@ static const struct dcn10_link_enc_shift le_shift = {
 
 static const struct dcn10_link_enc_mask le_mask = {
 	LINK_ENCODER_MASK_SH_LIST_DCN31(_MASK), \
-
 	//DPCS_DCN31_MASK_SH_LIST(_MASK)
 };
 
@@ -2093,27 +2092,28 @@ static bool dcn32_resource_construct(
 	uint32_t pipe_fuses = 0;
 	uint32_t num_pipes  = 4;
 
-	#undef REG_STRUCT
-	#define REG_STRUCT bios_regs
-		bios_regs_init();
-
-	#undef REG_STRUCT
-	#define REG_STRUCT clk_src_regs
-		clk_src_regs_init(0, A),
-		clk_src_regs_init(1, B),
-		clk_src_regs_init(2, C),
-		clk_src_regs_init(3, D),
-		clk_src_regs_init(4, E);
-	#undef REG_STRUCT
-	#define REG_STRUCT abm_regs
-		abm_regs_init(0),
-		abm_regs_init(1),
-		abm_regs_init(2),
-		abm_regs_init(3);
-
-	#undef REG_STRUCT
-	#define REG_STRUCT dccg_regs
-		dccg_regs_init();
+#undef REG_STRUCT
+#define REG_STRUCT bios_regs
+	bios_regs_init();
+
+#undef REG_STRUCT
+#define REG_STRUCT clk_src_regs
+	clk_src_regs_init(0, A),
+	clk_src_regs_init(1, B),
+	clk_src_regs_init(2, C),
+	clk_src_regs_init(3, D),
+	clk_src_regs_init(4, E);
+
+#undef REG_STRUCT
+#define REG_STRUCT abm_regs
+	abm_regs_init(0),
+	abm_regs_init(1),
+	abm_regs_init(2),
+	abm_regs_init(3);
+
+#undef REG_STRUCT
+#define REG_STRUCT dccg_regs
+	dccg_regs_init();
 
 	DC_FP_START();
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index 38d1f2be8cf3..6e32dc68f7bc 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -917,19 +917,19 @@ void dcn20_populate_dml_writeback_from_context(struct dc *dc,
 }
 
 void dcn20_fpu_set_wb_arb_params(struct mcif_arb_params *wb_arb_params,
-                                struct dc_state *context,
-                                display_e2e_pipe_params_st *pipes,
-                                int pipe_cnt, int i)
+				 struct dc_state *context,
+				 display_e2e_pipe_params_st *pipes,
+				 int pipe_cnt, int i)
 {
-       int k;
+	int k;
 
-       dc_assert_fp_enabled();
+	dc_assert_fp_enabled();
 
-       for (k = 0; k < sizeof(wb_arb_params->cli_watermark)/sizeof(wb_arb_params->cli_watermark[0]); k++) {
-               wb_arb_params->cli_watermark[k] = get_wm_writeback_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-               wb_arb_params->pstate_watermark[k] = get_wm_writeback_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
-       }
-       wb_arb_params->time_per_pixel = 16.0 * 1000 / (context->res_ctx.pipe_ctx[i].stream->phy_pix_clk / 1000); /* 4 bit fraction, ms */
+	for (k = 0; k < sizeof(wb_arb_params->cli_watermark)/sizeof(wb_arb_params->cli_watermark[0]); k++) {
+		wb_arb_params->cli_watermark[k] = get_wm_writeback_urgent(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+		wb_arb_params->pstate_watermark[k] = get_wm_writeback_dram_clock_change(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
+	}
+	wb_arb_params->time_per_pixel = 16.0 * 1000 / (context->res_ctx.pipe_ctx[i].stream->phy_pix_clk / 1000); /* 4 bit fraction, ms */
 }
 
 static bool is_dtbclk_required(struct dc *dc, struct dc_state *context)
@@ -1037,11 +1037,11 @@ static void dcn20_adjust_freesync_v_startup(
 	*vstartup_start = ((newVstartup > *vstartup_start) ? newVstartup : *vstartup_start);
 }
 
-void dcn20_calculate_dlg_params(
-		struct dc *dc, struct dc_state *context,
-		display_e2e_pipe_params_st *pipes,
-		int pipe_cnt,
-		int vlevel)
+void dcn20_calculate_dlg_params(struct dc *dc,
+				struct dc_state *context,
+				display_e2e_pipe_params_st *pipes,
+				int pipe_cnt,
+				int vlevel)
 {
 	int i, pipe_idx;
 
@@ -1083,6 +1083,7 @@ void dcn20_calculate_dlg_params(
 		pipes[pipe_idx].pipe.dest.vupdate_offset = get_vupdate_offset(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
 		pipes[pipe_idx].pipe.dest.vupdate_width = get_vupdate_width(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
 		pipes[pipe_idx].pipe.dest.vready_offset = get_vready_offset(&context->bw_ctx.dml, pipes, pipe_cnt, pipe_idx);
+
 		if (context->res_ctx.pipe_ctx[i].stream->mall_stream_config.type == SUBVP_PHANTOM) {
 			// Phantom pipe requires that DET_SIZE = 0 and no unbounded requests
 			context->res_ctx.pipe_ctx[i].det_buffer_size_kb = 0;
@@ -1091,6 +1092,7 @@ void dcn20_calculate_dlg_params(
 			context->res_ctx.pipe_ctx[i].det_buffer_size_kb = context->bw_ctx.dml.ip.det_buffer_size_kbytes;
 			context->res_ctx.pipe_ctx[i].unbounded_req = pipes[pipe_idx].pipe.src.unbounded_req_mode;
 		}
+
 		if (context->bw_ctx.bw.dcn.clk.dppclk_khz < pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000)
 			context->bw_ctx.bw.dcn.clk.dppclk_khz = pipes[pipe_idx].clks_cfg.dppclk_mhz * 1000;
 		context->res_ctx.pipe_ctx[i].plane_res.bw.dppclk_khz =
@@ -1118,6 +1120,7 @@ void dcn20_calculate_dlg_params(
 		if (!context->res_ctx.pipe_ctx[i].stream)
 			continue;
 
+		/* cstate disabled on 201 */
 		if (dc->ctx->dce_version == DCN_VERSION_2_01)
 			cstate_en = false;
 
@@ -1201,11 +1204,10 @@ static void swizzle_to_dml_params(
 	}
 }
 
-int dcn20_populate_dml_pipes_from_context(
-		struct dc *dc,
-		struct dc_state *context,
-		display_e2e_pipe_params_st *pipes,
-		bool fast_validate)
+int dcn20_populate_dml_pipes_from_context(struct dc *dc,
+					  struct dc_state *context,
+					  display_e2e_pipe_params_st *pipes,
+					  bool fast_validate)
 {
 	int pipe_cnt, i;
 	bool synchronized_vblank = true;
@@ -1507,6 +1509,7 @@ int dcn20_populate_dml_pipes_from_context(
 			default:
 				break;
 			}
+
 			pipes[pipe_cnt].pipe.src.viewport_y_y = scl->viewport.y;
 			pipes[pipe_cnt].pipe.src.viewport_y_c = scl->viewport_c.y;
 			pipes[pipe_cnt].pipe.src.viewport_x_y = scl->viewport.x;
@@ -1615,13 +1618,12 @@ int dcn20_populate_dml_pipes_from_context(
 	return pipe_cnt;
 }
 
-void dcn20_calculate_wm(
-		struct dc *dc, struct dc_state *context,
-		display_e2e_pipe_params_st *pipes,
-		int *out_pipe_cnt,
-		int *pipe_split_from,
-		int vlevel,
-		bool fast_validate)
+void dcn20_calculate_wm(struct dc *dc, struct dc_state *context,
+			display_e2e_pipe_params_st *pipes,
+			int *out_pipe_cnt,
+			int *pipe_split_from,
+			int vlevel,
+			bool fast_validate)
 {
 	int pipe_cnt, i, pipe_idx;
 
@@ -1733,8 +1735,11 @@ void dcn20_calculate_wm(
 	context->bw_ctx.bw.dcn.watermarks.a.frac_urg_bw_flip = get_fraction_of_urgent_bandwidth_imm_flip(&context->bw_ctx.dml, pipes, pipe_cnt) * 1000;
 }
 
-void dcn20_update_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_st *bb,
-		struct pp_smu_nv_clock_table *max_clocks, unsigned int *uclk_states, unsigned int num_states)
+void dcn20_update_bounding_box(struct dc *dc,
+			       struct _vcs_dpi_soc_bounding_box_st *bb,
+			       struct pp_smu_nv_clock_table *max_clocks,
+			       unsigned int *uclk_states,
+			       unsigned int num_states)
 {
 	int num_calculated_states = 0;
 	int min_dcfclk = 0;
@@ -1796,9 +1801,8 @@ void dcn20_update_bounding_box(struct dc *dc, struct _vcs_dpi_soc_bounding_box_s
 	bb->clock_limits[num_calculated_states].state = bb->num_states;
 }
 
-void dcn20_cap_soc_clocks(
-		struct _vcs_dpi_soc_bounding_box_st *bb,
-		struct pp_smu_nv_clock_table max_clocks)
+void dcn20_cap_soc_clocks(struct _vcs_dpi_soc_bounding_box_st *bb,
+			  struct pp_smu_nv_clock_table max_clocks)
 {
 	int i;
 
@@ -1954,80 +1958,80 @@ static bool dcn20_validate_bandwidth_internal(struct dc *dc, struct dc_state *co
 }
 
 bool dcn20_validate_bandwidth_fp(struct dc *dc,
-                                struct dc_state *context,
-                                bool fast_validate)
+				 struct dc_state *context,
+				 bool fast_validate)
 {
-       bool voltage_supported = false;
-       bool full_pstate_supported = false;
-       bool dummy_pstate_supported = false;
-       double p_state_latency_us;
+	bool voltage_supported = false;
+	bool full_pstate_supported = false;
+	bool dummy_pstate_supported = false;
+	double p_state_latency_us;
 
-       dc_assert_fp_enabled();
+	dc_assert_fp_enabled();
 
-       p_state_latency_us = context->bw_ctx.dml.soc.dram_clock_change_latency_us;
-       context->bw_ctx.dml.soc.disable_dram_clock_change_vactive_support =
-               dc->debug.disable_dram_clock_change_vactive_support;
-       context->bw_ctx.dml.soc.allow_dram_clock_one_display_vactive =
-               dc->debug.enable_dram_clock_change_one_display_vactive;
+	p_state_latency_us = context->bw_ctx.dml.soc.dram_clock_change_latency_us;
+	context->bw_ctx.dml.soc.disable_dram_clock_change_vactive_support =
+		dc->debug.disable_dram_clock_change_vactive_support;
+	context->bw_ctx.dml.soc.allow_dram_clock_one_display_vactive =
+		dc->debug.enable_dram_clock_change_one_display_vactive;
 
-       /*Unsafe due to current pipe merge and split logic*/
-       ASSERT(context != dc->current_state);
+	/*Unsafe due to current pipe merge and split logic*/
+	ASSERT(context != dc->current_state);
 
-       if (fast_validate) {
-               return dcn20_validate_bandwidth_internal(dc, context, true);
-       }
+	if (fast_validate) {
+		return dcn20_validate_bandwidth_internal(dc, context, true);
+	}
 
-       // Best case, we support full UCLK switch latency
-       voltage_supported = dcn20_validate_bandwidth_internal(dc, context, false);
-       full_pstate_supported = context->bw_ctx.bw.dcn.clk.p_state_change_support;
+	// Best case, we support full UCLK switch latency
+	voltage_supported = dcn20_validate_bandwidth_internal(dc, context, false);
+	full_pstate_supported = context->bw_ctx.bw.dcn.clk.p_state_change_support;
 
-       if (context->bw_ctx.dml.soc.dummy_pstate_latency_us == 0 ||
-               (voltage_supported && full_pstate_supported)) {
-               context->bw_ctx.bw.dcn.clk.p_state_change_support = full_pstate_supported;
-               goto restore_dml_state;
-       }
+	if (context->bw_ctx.dml.soc.dummy_pstate_latency_us == 0 ||
+		(voltage_supported && full_pstate_supported)) {
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = full_pstate_supported;
+		goto restore_dml_state;
+	}
 
-       // Fallback: Try to only support G6 temperature read latency
-       context->bw_ctx.dml.soc.dram_clock_change_latency_us = context->bw_ctx.dml.soc.dummy_pstate_latency_us;
+	// Fallback: Try to only support G6 temperature read latency
+	context->bw_ctx.dml.soc.dram_clock_change_latency_us = context->bw_ctx.dml.soc.dummy_pstate_latency_us;
 
-       voltage_supported = dcn20_validate_bandwidth_internal(dc, context, false);
-       dummy_pstate_supported = context->bw_ctx.bw.dcn.clk.p_state_change_support;
+	voltage_supported = dcn20_validate_bandwidth_internal(dc, context, false);
+	dummy_pstate_supported = context->bw_ctx.bw.dcn.clk.p_state_change_support;
 
-       if (voltage_supported && (dummy_pstate_supported || !(context->stream_count))) {
-               context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
-               goto restore_dml_state;
-       }
+	if (voltage_supported && (dummy_pstate_supported || !(context->stream_count))) {
+		context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
+		goto restore_dml_state;
+	}
 
-       // ERROR: fallback is supposed to always work.
-       ASSERT(false);
+	// ERROR: fallback is supposed to always work.
+	ASSERT(false);
 
 restore_dml_state:
-       context->bw_ctx.dml.soc.dram_clock_change_latency_us = p_state_latency_us;
-       return voltage_supported;
+	context->bw_ctx.dml.soc.dram_clock_change_latency_us = p_state_latency_us;
+	return voltage_supported;
 }
 
 void dcn20_fpu_set_wm_ranges(int i,
-                            struct pp_smu_wm_range_sets *ranges,
-                            struct _vcs_dpi_soc_bounding_box_st *loaded_bb)
+			     struct pp_smu_wm_range_sets *ranges,
+			     struct _vcs_dpi_soc_bounding_box_st *loaded_bb)
 {
-       dc_assert_fp_enabled();
+	dc_assert_fp_enabled();
 
-       ranges->reader_wm_sets[i].min_fill_clk_mhz = (i > 0) ? (loaded_bb->clock_limits[i - 1].dram_speed_mts / 16) + 1 : 0;
-       ranges->reader_wm_sets[i].max_fill_clk_mhz = loaded_bb->clock_limits[i].dram_speed_mts / 16;
+	ranges->reader_wm_sets[i].min_fill_clk_mhz = (i > 0) ? (loaded_bb->clock_limits[i - 1].dram_speed_mts / 16) + 1 : 0;
+	ranges->reader_wm_sets[i].max_fill_clk_mhz = loaded_bb->clock_limits[i].dram_speed_mts / 16;
 }
 
 void dcn20_fpu_adjust_dppclk(struct vba_vars_st *v,
-                            int vlevel,
-                            int max_mpc_comb,
-                            int pipe_idx,
-                            bool is_validating_bw)
+			     int vlevel,
+			     int max_mpc_comb,
+			     int pipe_idx,
+			     bool is_validating_bw)
 {
-       dc_assert_fp_enabled();
+	dc_assert_fp_enabled();
 
-       if (is_validating_bw)
-               v->RequiredDPPCLK[vlevel][max_mpc_comb][pipe_idx] *= 2;
-       else
-               v->RequiredDPPCLK[vlevel][max_mpc_comb][pipe_idx] /= 2;
+	if (is_validating_bw)
+		v->RequiredDPPCLK[vlevel][max_mpc_comb][pipe_idx] *= 2;
+	else
+		v->RequiredDPPCLK[vlevel][max_mpc_comb][pipe_idx] /= 2;
 }
 
 int dcn21_populate_dml_pipes_from_context(struct dc *dc,
-- 
2.34.1


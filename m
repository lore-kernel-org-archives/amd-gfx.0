Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 695CFC433EF
	for <amd-gfx@archiver.kernel.org>; Fri, 22 Jul 2022 20:40:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D945393C9D;
	Fri, 22 Jul 2022 20:40:15 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2089.outbound.protection.outlook.com [40.107.243.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9004493C85
 for <amd-gfx@lists.freedesktop.org>; Fri, 22 Jul 2022 20:40:14 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhPU3Dxbq+qxY0S7Z0gzUK2nYg8aycTVFoSkfaJYdr8tuq4Wd1VnismEaNp5d1bTQcSlxHBU7QHEj/eMAkE0u8GS0emrVV/GOybuOCaydtEx2l4KLEZAkt75PyNpwrNmeq1S3TZLUqxMESjORsOlGJr8Mrn1pyj/XiMm+LmcGpoLBOI8CM4Jyw1CoyhoO58iamTx6yc0ggjoMlqALGkN2k5AhbPA6u1vu3dvxd1PoGHgVk49eVCJXcg1ukwFHIFRtLmwXZPnB5VrDHLlOUg/4Ss3IRGf2BHzNjnMgSMrCXsHgKFQpaZ95UG9nwQTZhZUoXKQ5VXMJdcjCf9wCWWRug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iVsKMuaj2YSXsc3vXEC+eWRbXgO9aArqx1/araTHGY=;
 b=Zi6LCaX6V2+l6O/8AeNJC3b28mrndIjxOeTgLDJs7pyG+6+xcnZuz839awV+EGwSCpAcLQhw/lOUkp157WcWnHjTY70uRGS4Xxt6OaD/5koc8iSO38aq4+gLfDrMHUN59/9dbrYJUMMHhbUIArtyzaO06ZRPUNwObmSKvoc3kZwm3BfBMIILJd/NfGYCIUR0TLQywYYPrJuz2h73qDznXhOr2bCZLIJIaWKqGC033QS6UyYa7YqdNnLsp60EXxF7BL6yzbTz56g/T0NkX2eBAJv4+mrbq5Nf+CuaXGRjqGTNWkkm4wdAc3varz6JtqOPV/r3cbx5HK9Dp4bcrzoM1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iVsKMuaj2YSXsc3vXEC+eWRbXgO9aArqx1/araTHGY=;
 b=hKnsKcLXUuZxSXfM8HDzsZ7U4/Hg0NRNy7miss5ZrByl6zYwBWyCgDFvgQemrodUSI33/Y2JxGLnzbQbeas76SS9cDozCSqNx4NEbUxi3TgmQW6EVkt10tZE9qVGHndQZfghD+XuPAIfjyR19khZAI+RvtCAuy8tBGb6ZuxJqf0=
Received: from MW4PR03CA0324.namprd03.prod.outlook.com (2603:10b6:303:dd::29)
 by BY5PR12MB4162.namprd12.prod.outlook.com (2603:10b6:a03:201::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Fri, 22 Jul
 2022 20:40:12 +0000
Received: from CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:dd:cafe::4c) by MW4PR03CA0324.outlook.office365.com
 (2603:10b6:303:dd::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.19 via Frontend
 Transport; Fri, 22 Jul 2022 20:40:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT055.mail.protection.outlook.com (10.13.175.129) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5458.17 via Frontend Transport; Fri, 22 Jul 2022 20:40:11 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 22 Jul
 2022 15:40:05 -0500
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 12/31] drm/amd/display: Remove FPU operations from dcn201
 resources
Date: Fri, 22 Jul 2022 14:31:18 -0600
Message-ID: <20220722203137.4043516-13-alex.hung@amd.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722203137.4043516-1-alex.hung@amd.com>
References: <20220722203137.4043516-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b8923784-a3e6-4a0f-b02f-08da6c225fc3
X-MS-TrafficTypeDiagnostic: BY5PR12MB4162:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CaHLOXhMZvTXsA7o9fzPCByOW7yLMF9Bi+2OHSmZEFI09vBWdr2NFzeDII61vFWWf6n26I/Yclo2XuOHPZOyOq/tgmD2AUMnYujIo717kwQeiB32satYre8G7uT+NGv5dmjC4RdbKQXhZygVcHvznCH+eW+dfW5ZIXJRd66L5NTf3nB5A//dvHiTKAqw6/RXYChLOUmK6KBJmNSeCMJHhNdBzEKzlOENvY/Z17A86kc6l/X3imYdFECeGHtpBPwNhIFMVNZwf9+3IkMnqk1hNI2yChWviftrCrZLlbfOqx8A44Uy5+/WOJsyn7/e8eIV06Ps92PQyqDTrXWR+Wsa5bHy7UiB2saiqy9EJndtPgFeVDaUUt/WyDn78SkqHBgfU3/1VAHyyS3dry8jKF6X4xx0RUjvK7683Xbt6+ryqKzYZLDLsaFaML5OGZRSG4WGsyYFi/gmI74ZpKS5rohzjePBsRksIiMlb+zsCP6e++M3LX5x6n255jQBe7j3cgdOuorzMCmTdWzcSpw9cQoWyfR1tfQaE6zBgGeYEdbyz/1yF+ySUQIFt6YEXmNZHQdm5NFMgK8PPpw4ox5t6qz7l8WJbGZI5n5NfN0Rn2T+n98R9d92g/Q5nssbhtDq9ahD1qMr/H44tXIX1f5f2LEuKbOgv7yI/M4j1xugX4Z1uxZyKFdtuQnOb4j4zzG9/myO4ayQcrHTeKQ5xaenmUEiJVWf3viKZQw1LmcgXLfDr/2zUglEog7P4ISP3Y/hdK8Iodq2xjPv8Ny7LmUXOYhlBssYuK8edQ+NWN8NUw+0jYw4kpQfSq9UbRHB1LbHEleHnC+wK/Z5ZSaVsYxgOfWx5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(40470700004)(46966006)(36840700001)(7696005)(6666004)(16526019)(82310400005)(1076003)(2906002)(41300700001)(2616005)(426003)(81166007)(356005)(47076005)(336012)(26005)(82740400003)(186003)(70586007)(4326008)(36860700001)(54906003)(8676002)(83380400001)(40480700001)(36756003)(70206006)(6916009)(316002)(478600001)(40460700003)(8936002)(5660300002)(86362001)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2022 20:40:11.5819 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b8923784-a3e6-4a0f-b02f-08da6c225fc3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4162
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
Cc: stylon.wang@amd.com, mark.broadworth@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 roman.li@amd.com, solomon.chiu@amd.com, daniel.wheeler@amd.com,
 Aurabindo.Pillai@amd.com, Alex Hung <alex.hung@amd.com>, wayne.lin@amd.com,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>

We have some FPU operations on the resource part of the DCN201. This
commit drops FPU flags and moves any required FPU code to the DML
folder.

Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../gpu/drm/amd/display/dc/dcn201/Makefile    | 24 -----
 .../amd/display/dc/dcn201/dcn201_resource.c   | 10 ++-
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 87 +++++++++++++++++++
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.h  |  4 +
 4 files changed, 100 insertions(+), 25 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
index 96cbd4ccd344..5c9ce2cebb0f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/Makefile
@@ -6,30 +6,6 @@ DCN201 = dcn201_init.o dcn201_resource.o dcn201_hwseq.o \
 	dcn201_mpc.o dcn201_hubp.o dcn201_opp.o dcn201_optc.o dcn201_dpp.o \
 	dcn201_dccg.o dcn201_link_encoder.o
 
-ifdef CONFIG_X86
-CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o := -mhard-float -msse
-endif
-
-ifdef CONFIG_PPC64
-CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o := -mhard-float -maltivec
-endif
-
-ifdef CONFIG_CC_IS_GCC
-ifeq ($(call cc-ifversion, -lt, 0701, y), y)
-IS_OLD_GCC = 1
-endif
-endif
-
-ifdef CONFIG_X86
-ifdef IS_OLD_GCC
-# Stack alignment mismatch, proceed with caution.
-# GCC < 7.1 cannot compile code using `double` and -mpreferred-stack-boundary=3
-# (8B stack alignment).
-CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o += -mpreferred-stack-boundary=4
-else
-CFLAGS_$(AMDDALPATH)/dc/dcn201/dcn201_resource.o += -msse2
-endif
-endif
 AMD_DAL_DCN201 = $(addprefix $(AMDDALPATH)/dc/dcn201/,$(DCN201))
 
 AMD_DISPLAY_FILES += $(AMD_DAL_DCN201)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
index 0bb7d3dd53fa..e549a79f3fe1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn201/dcn201_resource.c
@@ -1036,6 +1036,14 @@ static bool dcn201_get_dcc_compression_cap(const struct dc *dc,
 			output);
 }
 
+static void dcn201_populate_dml_writeback_from_context(struct dc *dc,
+						       struct resource_context *res_ctx,
+						       display_e2e_pipe_params_st *pipes)
+{
+	DC_FP_START();
+	dcn201_populate_dml_writeback_from_context_fpu(dc, res_ctx, pipes);
+	DC_FP_END();
+}
 
 static void dcn201_destroy_resource_pool(struct resource_pool **pool)
 {
@@ -1067,8 +1075,8 @@ static struct resource_funcs dcn201_res_pool_funcs = {
 	.add_dsc_to_stream_resource = NULL,
 	.remove_stream_from_ctx = dcn20_remove_stream_from_ctx,
 	.acquire_idle_pipe_for_layer = dcn201_acquire_idle_pipe_for_layer,
+	.populate_dml_writeback_from_context = dcn201_populate_dml_writeback_from_context,
 	.patch_unknown_plane_state = dcn20_patch_unknown_plane_state,
-	.populate_dml_writeback_from_context = dcn20_populate_dml_writeback_from_context,
 	.set_mcif_arb_params = dcn20_set_mcif_arb_params,
 	.find_first_free_match_stream_enc_for_link = dcn10_find_first_free_match_stream_enc_for_link
 };
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index eeeae52fe6fc..39428488a052 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -2303,3 +2303,90 @@ void dcn21_clk_mgr_set_bw_params_wm_table(struct clk_bw_params *bw_params)
 	bw_params->wm_table.entries[WM_D].wm_type = WM_TYPE_RETRAINING;
 	bw_params->wm_table.entries[WM_D].valid = true;
 }
+
+void dcn201_populate_dml_writeback_from_context_fpu(struct dc *dc,
+						    struct resource_context *res_ctx,
+						    display_e2e_pipe_params_st *pipes)
+{
+	int pipe_cnt, i, j;
+	double max_calc_writeback_dispclk;
+	double writeback_dispclk;
+	struct writeback_st dout_wb;
+
+	dc_assert_fp_enabled();
+
+	for (i = 0, pipe_cnt = 0; i < dc->res_pool->pipe_count; i++) {
+		struct dc_stream_state *stream = res_ctx->pipe_ctx[i].stream;
+
+		if (!stream)
+			continue;
+		max_calc_writeback_dispclk = 0;
+
+		/* Set writeback information */
+		pipes[pipe_cnt].dout.wb_enable = 0;
+		pipes[pipe_cnt].dout.num_active_wb = 0;
+		for (j = 0; j < stream->num_wb_info; j++) {
+			struct dc_writeback_info *wb_info = &stream->writeback_info[j];
+
+			if (wb_info->wb_enabled && wb_info->writeback_source_plane &&
+					(wb_info->writeback_source_plane == res_ctx->pipe_ctx[i].plane_state)) {
+				pipes[pipe_cnt].dout.wb_enable = 1;
+				pipes[pipe_cnt].dout.num_active_wb++;
+				dout_wb.wb_src_height = wb_info->dwb_params.cnv_params.crop_en ?
+					wb_info->dwb_params.cnv_params.crop_height :
+					wb_info->dwb_params.cnv_params.src_height;
+				dout_wb.wb_src_width = wb_info->dwb_params.cnv_params.crop_en ?
+					wb_info->dwb_params.cnv_params.crop_width :
+					wb_info->dwb_params.cnv_params.src_width;
+				dout_wb.wb_dst_width = wb_info->dwb_params.dest_width;
+				dout_wb.wb_dst_height = wb_info->dwb_params.dest_height;
+				dout_wb.wb_htaps_luma = wb_info->dwb_params.scaler_taps.h_taps;
+				dout_wb.wb_vtaps_luma = wb_info->dwb_params.scaler_taps.v_taps;;
+				dout_wb.wb_htaps_chroma = wb_info->dwb_params.scaler_taps.h_taps_c;
+				dout_wb.wb_vtaps_chroma = wb_info->dwb_params.scaler_taps.v_taps_c;
+				dout_wb.wb_hratio = wb_info->dwb_params.cnv_params.crop_en ?
+					(double)wb_info->dwb_params.cnv_params.crop_width /
+						(double)wb_info->dwb_params.dest_width :
+					(double)wb_info->dwb_params.cnv_params.src_width /
+						(double)wb_info->dwb_params.dest_width;
+				dout_wb.wb_vratio = wb_info->dwb_params.cnv_params.crop_en ?
+					(double)wb_info->dwb_params.cnv_params.crop_height /
+						(double)wb_info->dwb_params.dest_height :
+					(double)wb_info->dwb_params.cnv_params.src_height /
+						(double)wb_info->dwb_params.dest_height;
+				if (wb_info->dwb_params.out_format == dwb_scaler_mode_yuv420) {
+					if (wb_info->dwb_params.output_depth == DWB_OUTPUT_PIXEL_DEPTH_8BPC)
+						dout_wb.wb_pixel_format = dm_420_8;
+					else
+						dout_wb.wb_pixel_format = dm_420_10;
+				} else
+					dout_wb.wb_pixel_format = dm_444_32;
+
+				/* Workaround for cases where multiple writebacks are connected to same plane
+				 * In which case, need to compute worst case and set the associated writeback parameters
+				 * This workaround is necessary due to DML computation assuming only 1 set of writeback
+				 * parameters per pipe */
+				writeback_dispclk = CalculateWriteBackDISPCLK(
+						dout_wb.wb_pixel_format,
+						pipes[pipe_cnt].pipe.dest.pixel_rate_mhz,
+						dout_wb.wb_hratio,
+						dout_wb.wb_vratio,
+						dout_wb.wb_htaps_luma,
+						dout_wb.wb_vtaps_luma,
+						dout_wb.wb_htaps_chroma,
+						dout_wb.wb_vtaps_chroma,
+						dout_wb.wb_dst_width,
+						pipes[pipe_cnt].pipe.dest.htotal,
+						2);
+
+				if (writeback_dispclk > max_calc_writeback_dispclk) {
+					max_calc_writeback_dispclk = writeback_dispclk;
+					pipes[pipe_cnt].dout.wb = dout_wb;
+				}
+			}
+		}
+
+		pipe_cnt++;
+	}
+
+}
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h
index a6e1ad0f38e9..c51badf7b68a 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.h
@@ -84,4 +84,8 @@ void dcn21_update_bw_bounding_box(struct dc *dc, struct clk_bw_params *bw_params
 
 void dcn21_clk_mgr_set_bw_params_wm_table(struct clk_bw_params *bw_params);
 
+void dcn201_populate_dml_writeback_from_context_fpu(struct dc *dc,
+						struct resource_context *res_ctx,
+						display_e2e_pipe_params_st *pipes);
+
 #endif /* __DCN20_FPU_H__ */
-- 
2.37.1


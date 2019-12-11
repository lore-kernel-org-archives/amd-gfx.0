Return-Path: <SRS0=BheJ=2B=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F16C43603
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:34 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EB9C2077B
	for <amd-gfx@archiver.kernel.org>; Wed, 11 Dec 2019 15:33:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="BVo/Sjg/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EB9C2077B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6221F6EB7E;
	Wed, 11 Dec 2019 15:33:33 +0000 (UTC)
Received: from NAM02-CY1-obe.outbound.protection.outlook.com
 (mail-eopbgr760085.outbound.protection.outlook.com [40.107.76.85])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7F9766EB87
 for <amd-gfx@lists.freedesktop.org>; Wed, 11 Dec 2019 15:33:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n7sLx9G0+RdC7fit7HC5gT3HD3ZRmYwl09rOc8XOSN2Q2EbJydBb07UlOTEtrTdRkH4RcoRfMtXCqUwuP0k1YjQi3rbPewviXOa1sJseU9SCAKsHrFh7h20KXA9lU62NdBvidc9rcHrK3tzGMCclHCYq7E7VdeNMwmUliAHlQ9B1SJbCVEKvMc/Of1w5pWS78ayCmW/Yf3wm/7RlflGffiqRVWzYXamYciOnx6w2nzGPPJ7fEVNzqoIhIWNLTGYHK4Vb5AlcOVlOTa8Xts1i5Vbl50MLWE4lLDim/ssEc4Hb3S4P4EwNuc1J5MTT8FQsIhIYYoKyx5mVWqEHW6VdyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFnTiWHe6ro9wVCuFu7TTFEZREAWLPAAu2jvVdYpIvo=;
 b=oDA2ETPasYKoUY+VGDR+dg5fVbxq7x0lo6seBS5XlBx/cAxkswLOonhR4pO1N0LJNeHPSe8CO1S5bA9X7hXgYDeGIE10Uzb0n+c7mS353woMJeT55EelW9Sqxp/PV2lrldHSf+FOzSupM8XF6G8BLvxiENlmRhd+Z5SvqiVzFLX/wtRqdLBk9rPrCIB50SGSmgxu30hp3Rb4fH2hjDyQTRFsg0AOkYqfjZ6J/JwYyYpGLj3Y4Vn8pHuAS+LVzkrjgcwtn6/KwwABIlg6fQOTmZsAd1UKzPA082rjqOM61WnMDXVQt/UVpDi496Bp2FRdBKYtvJ0z7wdCiZIFtasNBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFnTiWHe6ro9wVCuFu7TTFEZREAWLPAAu2jvVdYpIvo=;
 b=BVo/Sjg/jhAKNHD2vhV5NUh2nvVf0egaA7F1LYp6i6e/LoGRzsioUKpGFu1wfy0ZH8dsBd1o3ziQyoerpvOZUrlKkdAe3S7s7YDTJyNSHbG7bnkSy6sSUaG7ZpqEH//1AmGSJP0iOLfGO09C6WfDMeEqZTnmpPjLH7A70jXA/CQ=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Rodrigo.Siqueira@amd.com; 
Received: from MW2PR12MB2524.namprd12.prod.outlook.com (52.132.180.155) by
 MW2PR12MB2491.namprd12.prod.outlook.com (52.132.183.158) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2538.15; Wed, 11 Dec 2019 15:33:30 +0000
Received: from MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69]) by MW2PR12MB2524.namprd12.prod.outlook.com
 ([fe80::3d1f:4c20:e980:6e69%5]) with mapi id 15.20.2516.018; Wed, 11 Dec 2019
 15:33:30 +0000
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: amd-gfx@lists.freedesktop.org
Subject: [PATCH 15/39] drm/amd/display: Enable Seamless Boot Transition for
 Multiple Streams
Date: Wed, 11 Dec 2019 10:32:29 -0500
Message-Id: <20191211153253.2291112-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
References: <20191211153253.2291112-1-Rodrigo.Siqueira@amd.com>
X-ClientProxiedBy: YT1PR01CA0007.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01::20)
 To MW2PR12MB2524.namprd12.prod.outlook.com
 (2603:10b6:907:9::27)
MIME-Version: 1.0
X-Mailer: git-send-email 2.24.0
X-Originating-IP: [165.204.55.250]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: fcec75fd-46b8-4204-dd86-08d77e4f7934
X-MS-TrafficTypeDiagnostic: MW2PR12MB2491:|MW2PR12MB2491:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MW2PR12MB24915787370A15710BFB1335985A0@MW2PR12MB2491.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:203;
X-Forefront-PRVS: 024847EE92
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10009020)(4636009)(396003)(346002)(376002)(39860400002)(366004)(136003)(189003)(199004)(6486002)(6512007)(6916009)(8936002)(5660300002)(2906002)(86362001)(52116002)(2616005)(478600001)(66476007)(316002)(186003)(8676002)(81156014)(81166006)(54906003)(36756003)(4326008)(1076003)(26005)(66946007)(66556008)(6506007);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MW2PR12MB2491;
 H:MW2PR12MB2524.namprd12.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; MX:1; A:1; 
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pL3EGOOjbveEmNeIMukDHQHIuKcMkdNJP5CEKwB2MmjgNUW1Zu2yt6oM9pegqVMn2xHTBH16VdU+QtMNkt9BMhgBvZt6IE0oIhU9SDI+LKB1pLCfgOIi7sZCDXE6R2FlhRny687nGzVTVh3tvMcnJVfSAdgiqg4qUfSwTYI8J3dCcFIR+VQekgfEmjrsMdoXSGHa4ApxSvDnUl9pfgk0gnJEQsYzK8nDSa6EUj4UZGSpus6J/SBQ9VLqeDFBQ8b0wUdoSbU7Q/hlTVGdEn7zP4UScj8R534nKmsqRYgMTLDCtu66/UVcSLfWjzWfxr5qc2gHwX1VLfKdE6rpnAoAc2oxQuCXq038hj/UehVv9ZelJICHTUzv4VAersjarpolcDjHuO8C9FY7sGl3BEN2W+zG9xiOmP8ezpBnHJliscGzR6FXDCgWw5rcjUqeg7vL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fcec75fd-46b8-4204-dd86-08d77e4f7934
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2019 15:33:30.0636 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l2ZK8v+sM/6wyGNsPzhy4PddH3yd4mjAm6JvI6KHJ0/Z8ynR3W14YbkVWXlpYIEkR/svTe0PqlUSmB0K80HtGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR12MB2491
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
Cc: Sunpeng.Li@amd.com, Bhawanpreet.Lakha@amd.com, Harry.Wentland@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>, Martin Leung <martin.leung@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Martin Leung <martin.leung@amd.com>

[why]
dc previously had bugs that interfered with the ability to inherit a
timing from a device with multiple streams (without flash/blanking).
After this fix there is still a dependency on UEFI support.

[how]
fixed 3 bugs: loaded MPC state, changed bw_optimize flag to a counter
instead of a boolean, and reading dpp/disp clk from HW to ensure we
don't raise the clock's when we're not supposed to.

Signed-off-by: Martin Leung <martin.leung@amd.com>
Reviewed-by: Anthony Koo <Anthony.Koo@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
---
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c  | 30 +++++++++++++++++++
 .../display/dc/clk_mgr/dcn20/dcn20_clk_mgr.h  |  4 +++
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 21 +++++++------
 .../gpu/drm/amd/display/dc/core/dc_resource.c | 20 ++++++++++++-
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +-
 5 files changed, 66 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
index 25d7b7c6681c..3ae1d23f7342 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.c
@@ -27,6 +27,7 @@
 #include "clk_mgr_internal.h"
 
 #include "dce100/dce_clk_mgr.h"
+#include "dcn20_clk_mgr.h"
 #include "reg_helper.h"
 #include "core_types.h"
 #include "dm_helpers.h"
@@ -161,6 +162,9 @@ void dcn2_update_clocks(struct clk_mgr *clk_mgr_base,
 		dc->debug.force_clock_mode & 0x1) {
 		//this is from resume or boot up, if forced_clock cfg option used, we bypass program dispclk and DPPCLK, but need set them for S3.
 		force_reset = true;
+
+		dcn2_read_clocks_from_hw_dentist(clk_mgr_base);
+
 		//force_clock_mode 0x1:  force reset the clock even it is the same clock as long as it is in Passive level.
 	}
 	display_count = clk_mgr_helper_get_active_display_cnt(dc, context);
@@ -339,6 +343,32 @@ void dcn2_enable_pme_wa(struct clk_mgr *clk_mgr_base)
 	}
 }
 
+
+void dcn2_read_clocks_from_hw_dentist(struct clk_mgr *clk_mgr_base)
+{
+	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
+	uint32_t dispclk_wdivider;
+	uint32_t dppclk_wdivider;
+	int disp_divider;
+	int dpp_divider;
+
+	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DISPCLK_WDIVIDER, &dispclk_wdivider);
+	REG_GET(DENTIST_DISPCLK_CNTL, DENTIST_DPPCLK_WDIVIDER, &dppclk_wdivider);
+
+	disp_divider = dentist_get_divider_from_did(dispclk_wdivider);
+	dpp_divider = dentist_get_divider_from_did(dispclk_wdivider);
+
+	if (disp_divider && dpp_divider) {
+		/* Calculate the current DFS clock, in kHz.*/
+		clk_mgr_base->clks.dispclk_khz = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
+			* clk_mgr->base.dentist_vco_freq_khz) / disp_divider;
+
+		clk_mgr_base->clks.dppclk_khz = (DENTIST_DIVIDER_RANGE_SCALE_FACTOR
+				* clk_mgr->base.dentist_vco_freq_khz) / dpp_divider;
+	}
+
+}
+
 void dcn2_get_clock(struct clk_mgr *clk_mgr,
 		struct dc_state *context,
 			enum dc_clock_type clock_type,
diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.h b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.h
index c9fd824f3c23..b64a4e9d71d7 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.h
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn20/dcn20_clk_mgr.h
@@ -51,4 +51,8 @@ void dcn2_get_clock(struct clk_mgr *clk_mgr,
 			struct dc_clock_config *clock_cfg);
 
 void dcn20_update_clocks_update_dentist(struct clk_mgr_internal *clk_mgr);
+
+void dcn2_read_clocks_from_hw_dentist(struct clk_mgr *clk_mgr_base);
+
+
 #endif //__DCN20_CLK_MGR_H__
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 879cedd79d9e..2cb31f403b74 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -835,6 +835,7 @@ struct dc *dc_create(const struct dc_init_data *init_params)
 			full_pipe_count,
 			dc->res_pool->stream_enc_count);
 
+	dc->optimize_seamless_boot_streams = 0;
 	dc->caps.max_links = dc->link_count;
 	dc->caps.max_audios = dc->res_pool->audio_count;
 	dc->caps.linear_pitch_alignment = 64;
@@ -1178,10 +1179,10 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 
 	for (i = 0; i < context->stream_count; i++) {
 		if (context->streams[i]->apply_seamless_boot_optimization)
-			dc->optimize_seamless_boot = true;
+			dc->optimize_seamless_boot_streams++;
 	}
 
-	if (!dc->optimize_seamless_boot)
+	if (dc->optimize_seamless_boot_streams == 0)
 		dc->hwss.prepare_bandwidth(dc, context);
 
 	/* re-program planes for existing stream, in case we need to
@@ -1254,7 +1255,7 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 
 	dc_enable_stereo(dc, context, dc_streams, context->stream_count);
 
-	if (!dc->optimize_seamless_boot) {
+	if (dc->optimize_seamless_boot_streams == 0) {
 		/* Must wait for no flips to be pending before doing optimize bw */
 		wait_for_no_pipes_pending(dc, context);
 		/* pplib is notified if disp_num changed */
@@ -1300,7 +1301,7 @@ bool dc_post_update_surfaces_to_stream(struct dc *dc)
 	int i;
 	struct dc_state *context = dc->current_state;
 
-	if (!dc->optimized_required || dc->optimize_seamless_boot)
+	if (!dc->optimized_required || dc->optimize_seamless_boot_streams > 0)
 		return true;
 
 	post_surface_trace(dc);
@@ -2084,7 +2085,7 @@ static void commit_planes_do_stream_update(struct dc *dc,
 
 					dc->hwss.optimize_bandwidth(dc, dc->current_state);
 				} else {
-					if (!dc->optimize_seamless_boot)
+					if (dc->optimize_seamless_boot_streams == 0)
 						dc->hwss.prepare_bandwidth(dc, dc->current_state);
 
 					core_link_enable_stream(dc->current_state, pipe_ctx);
@@ -2125,7 +2126,7 @@ static void commit_planes_for_stream(struct dc *dc,
 	int i, j;
 	struct pipe_ctx *top_pipe_to_program = NULL;
 
-	if (dc->optimize_seamless_boot && surface_count > 0) {
+	if (dc->optimize_seamless_boot_streams > 0 && surface_count > 0) {
 		/* Optimize seamless boot flag keeps clocks and watermarks high until
 		 * first flip. After first flip, optimization is required to lower
 		 * bandwidth. Important to note that it is expected UEFI will
@@ -2134,12 +2135,14 @@ static void commit_planes_for_stream(struct dc *dc,
 		 */
 		if (stream->apply_seamless_boot_optimization) {
 			stream->apply_seamless_boot_optimization = false;
-			dc->optimize_seamless_boot = false;
-			dc->optimized_required = true;
+			dc->optimize_seamless_boot_streams--;
+
+			if (dc->optimize_seamless_boot_streams == 0)
+				dc->optimized_required = true;
 		}
 	}
 
-	if (update_type == UPDATE_TYPE_FULL && !dc->optimize_seamless_boot) {
+	if (update_type == UPDATE_TYPE_FULL && dc->optimize_seamless_boot_streams == 0) {
 		dc->hwss.prepare_bandwidth(dc, context);
 		context_clock_trace(dc, context);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 4700c785566b..594731182641 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1910,8 +1910,26 @@ static int acquire_resource_from_hw_enabled_state(
 		pipe_ctx->plane_res.dpp = pool->dpps[tg_inst];
 		pipe_ctx->stream_res.opp = pool->opps[tg_inst];
 
-		if (pool->dpps[tg_inst])
+		if (pool->dpps[tg_inst]) {
 			pipe_ctx->plane_res.mpcc_inst = pool->dpps[tg_inst]->inst;
+
+			// Read DPP->MPCC->OPP Pipe from HW State
+			if (pool->mpc->funcs->read_mpcc_state) {
+				struct mpcc_state s = {0};
+
+				pool->mpc->funcs->read_mpcc_state(pool->mpc, pipe_ctx->plane_res.mpcc_inst, &s);
+
+				if (s.dpp_id < MAX_MPCC)
+					pool->mpc->mpcc_array[pipe_ctx->plane_res.mpcc_inst].dpp_id = s.dpp_id;
+
+				if (s.bot_mpcc_id < MAX_MPCC)
+					pool->mpc->mpcc_array[pipe_ctx->plane_res.mpcc_inst].mpcc_bot =
+							&pool->mpc->mpcc_array[s.bot_mpcc_id];
+
+				if (s.opp_id < MAX_OPP)
+					pipe_ctx->stream_res.opp->mpc_tree_params.opp_id = s.opp_id;
+			}
+		}
 		pipe_ctx->pipe_idx = tg_inst;
 
 		pipe_ctx->stream = stream;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index c24639080371..91b60a549d35 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -513,7 +513,7 @@ struct dc {
 	bool optimized_required;
 
 	/* Require to maintain clocks and bandwidth for UEFI enabled HW */
-	bool optimize_seamless_boot;
+	int optimize_seamless_boot_streams;
 
 	/* FBC compressor */
 	struct compressor *fbc_compressor;
-- 
2.24.0

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

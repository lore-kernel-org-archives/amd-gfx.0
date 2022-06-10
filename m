Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8020EC43334
	for <amd-gfx@archiver.kernel.org>; Fri, 10 Jun 2022 20:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF502112A70;
	Fri, 10 Jun 2022 20:53:38 +0000 (UTC)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2049.outbound.protection.outlook.com [40.107.244.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D99CE10FF82
 for <amd-gfx@lists.freedesktop.org>; Fri, 10 Jun 2022 20:53:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSn0Aie5XW8i8CJYiRR5rLTANNYDxQbHj4ppE7r+mRVBN/cLWQV0tjR8P4sU97VE2y87s2arpykPt0lw5b2btTQjI7/PVb35jUc1hkinHxeRyet/nq9xHsNm70o1yAz/zXEo6/uI3kSkrguPxEQoHTKeyR1tqd4rzSg8oTPfr7wWAfpS+yEqLYm/VXKCA7kpUUc+7HW2ACv/g0Tiewt4ibsB4R+uAZoKvAppT8FNGV783YvN20ToTBrxxUFE32u93SUHhUwBfrp9RBOtXGzlOG1qTbKHHV+xq8+RgFB0z7D43wyrrY0/yoKxCbPjtkQ5RWKWlg6OmE449DzAEUU/mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aYEzYTuah765tsS62jbZz9YWmEjo5izcVpu2ToDRWRU=;
 b=RkhRUP9J4ErCEA4lYL8ZpiZYmxwj+LH3/1ZFwRiniloA0sPo0hSD75GMwCtr/VaUUc+KM1JD3V+TPuQNbJ3Nw65bKPQqfQyAviur13YqVbN+2Ad3ZIrz6OwRa7gxlh1n6lPQEOgN88VbUueladJH6eeKOQGEHH61SSAI2c7Gn8oDUIEz2sk+hzwstwu37e8qu/Q7gooMFEGCGlO80s3PSOojaEpMeNgMdHUKxXLIna53s/ID42nEPuLBAftgAUcRda8dufaaXr/A0s78M9n27GpAhSp5T+qEt5fP2cTkAajWLG1ql82rO7oyIgH5LmBO4xRCvyaTvkxB9R6Ty757Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aYEzYTuah765tsS62jbZz9YWmEjo5izcVpu2ToDRWRU=;
 b=JSa6AvEzMWDJL4iD0lp4Mheq4Ysj8C78p4ZRmHLEDNRBJuzozH4qs35nsHJvoNCZXe+f48TgqnBkdoXjtHgRhRfMTT364zaZMdhK49agjNTye9k2bHZB7HjjmssXTX/LBzE9xpr0DxCS1e7ZvEZhSrJGZfX1DAqGHTgbIZ5etfw=
Received: from MW4PR03CA0160.namprd03.prod.outlook.com (2603:10b6:303:8d::15)
 by DM5PR12MB1436.namprd12.prod.outlook.com (2603:10b6:3:78::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.15; Fri, 10 Jun 2022 20:53:34 +0000
Received: from CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:8d:cafe::16) by MW4PR03CA0160.outlook.office365.com
 (2603:10b6:303:8d::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13 via Frontend
 Transport; Fri, 10 Jun 2022 20:53:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT045.mail.protection.outlook.com (10.13.175.181) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5332.12 via Frontend Transport; Fri, 10 Jun 2022 20:53:33 +0000
Received: from hamza-pc.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 10 Jun
 2022 15:53:27 -0500
From: Hamza Mahfooz <hamza.mahfooz@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/23] drm/amd/display: Firmware assisted MCLK switch and FS
Date: Fri, 10 Jun 2022 16:52:37 -0400
Message-ID: <20220610205245.174802-16-hamza.mahfooz@amd.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610205245.174802-1-hamza.mahfooz@amd.com>
References: <20220610205245.174802-1-hamza.mahfooz@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e33d8993-c299-41ec-8b51-08da4b234896
X-MS-TrafficTypeDiagnostic: DM5PR12MB1436:EE_
X-Microsoft-Antispam-PRVS: <DM5PR12MB143697AD85618C6593D782FFF4A69@DM5PR12MB1436.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WD0iBQs5vLBOWgv7tey4PTD9RWxHwAe+X9a3+HsuhqxpwjCg/xOZd720ixWTGDLgjv2ngpoeIQIH3jM7wSu5fg74JI6Z8lcxldtegex0QlYJVwxs7cF0psG18TLX48w+jWGc2lMMx4MCugZUNs08rzCvO9jh4LGXQD9Ri03B4uvGACp08d44gz0Ol6Ov59PXAZ8TCJ6WrZjU3H0iyw9x9pYwKSyyx2pBn/QcOCOhWKk6Azzs2pgJgIWDVopzTMAPStPofXaJmRf+ivex3qs2uTMFu7EZlUEQQC8S48Njxnl/u9fqVK+rkxighU+YNPsE/+7uo+sCvJf49WGXxRP/V8EDX5Ie3YPuXEOaCKFcq4Qx3qOHQnFBEzl3fhf8MzKbgi4zs5bOhX8GutcI3FaFCSqT+09u3x2bDkXHJoGuTIBE2kLv18wXYJtrirUYaRLEDHoN5dwvY9V9UCttM83h8B/GwGDdCVETNce2RYJCdTY1x4ptGegfFgBhh6DzLPjHI3CvhWxl9JtNgpvBvBp+Y/7unTljtXPBuEj1Tv8S2XgLcGxJJvT2lEI4mNhVQPs3YDVJZsQXtHfL8DPBHYZKw1Wk2akvAqXjfGHTIw78kwbCJLP31uVGPQzGRCH1a8+1ps0G2y7tg44+R2lh4MiXbcJvXvdW1Rj59dTliTj79Nds/vExVfqrfGDcsZkd9OsBhJ107iLcitMZb4DN5ZZITxwf+eFr/Ds6u5G4kccKqLawCjw5M5UZDWH5LpDOmAJh
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(46966006)(40470700004)(36840700001)(16526019)(2616005)(186003)(5660300002)(6666004)(83380400001)(316002)(8936002)(7696005)(86362001)(508600001)(2906002)(4326008)(36756003)(26005)(30864003)(47076005)(36860700001)(336012)(426003)(70586007)(70206006)(8676002)(82310400005)(1076003)(81166007)(356005)(54906003)(40460700003)(6916009)(44832011)(36900700001)(16060500005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2022 20:53:33.8235 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e33d8993-c299-41ec-8b51-08da4b234896
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT045.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1436
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
Cc: stylon.wang@amd.com, Felipe Clark <felipe.clark@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, Alan Liu <HaoPing.Liu@amd.com>,
 solomon.chiu@amd.com, jerry.zuo@amd.com, Aurabindo.Pillai@amd.com,
 hamza.mahfooz@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Felipe <Felipe.Clark@amd.com>

[WHY]
Memory clock switching has great potential for power savings.

[HOW]
The driver code was modified to notify the DMCUB firmware that it should
stretch the vertical blank of frames when a memory clock switch is about
to start so that no blackouts happen on the screen due to unavailability
of the frame buffer.
The driver logic to determine when such firmware assisted strategy can
be initiated is also implemented and consists on checking prerequisites
of the feature.

Acked-by: Alan Liu <HaoPing.Liu@amd.com>
Signed-off-by: Felipe Clark <felipe.clark@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  8 ++++--
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c  |  2 ++
 drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h  |  5 +++-
 drivers/gpu/drm/amd/display/dc/dc_stream.h    |  3 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  1 -
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  1 -
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 28 +++++++++++--------
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    | 11 ++++++--
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  2 +-
 .../gpu/drm/amd/display/dc/dcn30/dcn30_optc.c |  1 +
 .../drm/amd/display/dc/dcn30/dcn30_resource.c |  1 +
 .../amd/display/dc/inc/hw_sequencer_private.h |  1 +
 .../amd/display/modules/freesync/freesync.c   |  5 ++++
 .../amd/display/modules/inc/mod_freesync.h    |  4 +++
 14 files changed, 51 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 645ec5bc3a7d..cfa6c2d1fc69 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -397,7 +397,6 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 		struct dc_crtc_timing_adjust *adjust)
 {
 	int i;
-	bool ret = false;
 
 	stream->adjust.v_total_max = adjust->v_total_max;
 	stream->adjust.v_total_mid = adjust->v_total_mid;
@@ -412,10 +411,10 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 					1,
 					*adjust);
 
-			ret = true;
+			return true;
 		}
 	}
-	return ret;
+	return false;
 }
 
 /**
@@ -2650,6 +2649,9 @@ static void copy_stream_update_to_stream(struct dc *dc,
 	if (update->vrr_infopacket)
 		stream->vrr_infopacket = *update->vrr_infopacket;
 
+	if (update->allow_freesync)
+		stream->allow_freesync = *update->allow_freesync;
+
 	if (update->crtc_timing_adjust)
 		stream->adjust = *update->crtc_timing_adjust;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
index 11597bca966a..548c91ad1b82 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.c
@@ -27,6 +27,8 @@
 #include "dc_dmub_srv.h"
 #include "../dmub/dmub_srv.h"
 #include "dm_helpers.h"
+#include "dc_hw_types.h"
+#include "core_types.h"
 
 #define CTX dc_dmub_srv->ctx
 #define DC_LOGGER CTX->logger
diff --git a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
index 50e44b53f14c..52758ff1e405 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_dmub_srv.h
@@ -31,6 +31,10 @@
 
 struct dmub_srv;
 struct dc;
+struct pipe_ctx;
+struct dc_crtc_timing_adjust;
+struct dc_crtc_timing;
+struct dc_state;
 
 struct dc_reg_helper_state {
 	bool gather_in_progress;
@@ -69,7 +73,6 @@ bool dc_dmub_srv_get_dmub_outbox0_msg(const struct dc *dc, struct dmcub_trace_bu
 void dc_dmub_trace_event_control(struct dc *dc, bool enable);
 
 void dc_dmub_srv_query_caps_cmd(struct dmub_srv *dmub);
-
 void dc_dmub_srv_clear_inbox0_ack(struct dc_dmub_srv *dmub_srv);
 void dc_dmub_srv_wait_for_inbox0_ack(struct dc_dmub_srv *dmub_srv);
 void dc_dmub_srv_send_inbox0_cmd(struct dc_dmub_srv *dmub_srv, union dmub_inbox0_data_register data);
diff --git a/drivers/gpu/drm/amd/display/dc/dc_stream.h b/drivers/gpu/drm/amd/display/dc/dc_stream.h
index f8f66790d09b..68cf06a5a3e3 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_stream.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_stream.h
@@ -205,6 +205,7 @@ struct dc_stream_state {
 	bool use_vsc_sdp_for_colorimetry;
 	bool ignore_msa_timing_param;
 
+	bool allow_freesync;
 	bool freesync_on_desktop;
 
 	bool converter_disable_audio;
@@ -295,9 +296,9 @@ struct dc_stream_update {
 	struct dc_info_packet *vrr_infopacket;
 	struct dc_info_packet *vsc_infopacket;
 	struct dc_info_packet *vsp_infopacket;
-
 	bool *dpms_off;
 	bool integer_scaling_update;
+	bool *allow_freesync;
 
 	struct colorspace_transform *gamut_remap;
 	enum dc_color_space *output_color_space;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 573d5be9e302..fff724e94eed 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2613,7 +2613,6 @@ void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	dc->hwss.update_visual_confirm_color(dc, pipe_ctx, &blnd_cfg.black_color, mpcc_id);
 
 	ASSERT(new_mpcc != NULL);
-
 	hubp->opp_id = pipe_ctx->stream_res.opp->inst;
 	hubp->mpcc_id = mpcc_id;
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index facd4e01b7ac..76f8b40b2165 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2446,7 +2446,6 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 			NULL,
 			hubp->inst,
 			mpcc_id);
-
 	dc->hwss.update_visual_confirm_color(dc, pipe_ctx, &blnd_cfg.black_color, mpcc_id);
 
 	ASSERT(new_mpcc != NULL);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index ecdc7c781217..08b8893ff145 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -48,6 +48,8 @@
 #include "dc_dmub_srv.h"
 #include "link_hwss.h"
 #include "dpcd_defs.h"
+#include "../dcn20/dcn20_hwseq.h"
+#include "dcn30_resource.h"
 #include "inc/dc_link_dp.h"
 #include "inc/link_dpcd.h"
 
@@ -344,17 +346,6 @@ void dcn30_enable_writeback(
 	dwb->funcs->enable(dwb, &wb_info->dwb_params);
 }
 
-void dcn30_prepare_bandwidth(struct dc *dc,
- 	struct dc_state *context)
-{
-	if (dc->clk_mgr->dc_mode_softmax_enabled)
-		if (dc->clk_mgr->clks.dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000 &&
-				context->bw_ctx.bw.dcn.clk.dramclk_khz > dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000)
-			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
-
- 	dcn20_prepare_bandwidth(dc, context);
-}
-
 void dcn30_disable_writeback(
 		struct dc *dc,
 		unsigned int dwb_pipe_inst)
@@ -647,6 +638,9 @@ void dcn30_init_hw(struct dc *dc)
 	if (dc->res_pool->hubbub->funcs->init_crb)
 		dc->res_pool->hubbub->funcs->init_crb(dc->res_pool->hubbub);
 
+	// Get DMCUB capabilities
+	dc_dmub_srv_query_caps_cmd(dc->ctx->dmub_srv->dmub);
+	dc->caps.dmub_caps.psr = dc->ctx->dmub_srv->dmub->feature_caps.psr;
 }
 
 void dcn30_set_avmute(struct pipe_ctx *pipe_ctx, bool enable)
@@ -962,3 +956,15 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
 	pipe_ctx->stream_res.opp->funcs->opp_set_disp_pattern_generator(pipe_ctx->stream_res.opp, test_pattern,
 			color_space, color_depth, solid_color, width, height, offset);
 }
+
+void dcn30_prepare_bandwidth(struct dc *dc,
+ 	struct dc_state *context)
+{
+	if (dc->clk_mgr->dc_mode_softmax_enabled)
+		if (dc->clk_mgr->clks.dramclk_khz <= dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000 &&
+				context->bw_ctx.bw.dcn.clk.dramclk_khz > dc->clk_mgr->bw_params->dc_mode_softmax_memclk * 1000)
+			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
+
+ 	dcn20_prepare_bandwidth(dc, context);
+}
+
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
index 73e7b690e82c..a24a8e33a3d2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
@@ -47,9 +47,6 @@ void dcn30_disable_writeback(
 		struct dc *dc,
 		unsigned int dwb_pipe_inst);
 
-void dcn30_prepare_bandwidth(struct dc *dc,
- 	struct dc_state *context);
-
 bool dcn30_mmhubbub_warmup(
 	struct dc *dc,
 	unsigned int num_dwb,
@@ -83,4 +80,12 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
 		const struct tg_color *solid_color,
 		int width, int height, int offset);
 
+void dcn30_set_hubp_blank(const struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		bool blank_enable);
+
+void dcn30_prepare_bandwidth(struct dc *dc,
+	struct dc_state *context);
+
+
 #endif /* __DC_HWSS_DCN30_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index bb347319de83..4c06e6e1ba4a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -59,7 +59,7 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.pipe_control_lock = dcn20_pipe_control_lock,
 	.interdependent_update_lock = dcn10_lock_all_pipes,
 	.cursor_lock = dcn10_cursor_lock,
-	.prepare_bandwidth = dcn20_prepare_bandwidth,
+	.prepare_bandwidth = dcn30_prepare_bandwidth,
 	.optimize_bandwidth = dcn20_optimize_bandwidth,
 	.update_bandwidth = dcn20_update_bandwidth,
 	.set_drr = dcn10_set_drr,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
index b604fb26f288..9a440ae8f865 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_optc.c
@@ -27,6 +27,7 @@
 #include "dcn30_optc.h"
 #include "dc.h"
 #include "dcn_calc_math.h"
+#include "dc_dmub_srv.h"
 
 #include "dml/dcn30/dcn30_fpu.h"
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
index 1c1a67c4cec1..4cf9a6cff46e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_resource.c
@@ -89,6 +89,7 @@
 #include "vm_helper.h"
 #include "dcn20/dcn20_vmid.h"
 #include "amdgpu_socbb.h"
+#include "dc_dmub_srv.h"
 
 #define DC_LOGGER_INIT(logger)
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
index 62a62e4fc4a8..ded45f8f4b82 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer_private.h
@@ -68,6 +68,7 @@ struct dce_hwseq;
 struct timing_generator;
 struct tg_color;
 struct output_pixel_processor;
+struct mpcc_blnd_cfg;
 
 struct hwseq_private_funcs {
 
diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 03fa63d56fa6..aa121d45d9b8 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -1374,6 +1374,11 @@ unsigned long long mod_freesync_calc_field_rate_from_timing(
 	return field_rate_in_uhz;
 }
 
+bool mod_freesync_get_freesync_enabled(struct mod_vrr_params *pVrr, struct dc_stream_state *const pStream)
+{
+	return (pVrr->state != VRR_STATE_UNSUPPORTED) && (pVrr->state != VRR_STATE_DISABLED);
+}
+
 bool mod_freesync_is_valid_range(uint32_t min_refresh_cap_in_uhz,
 		uint32_t max_refresh_cap_in_uhz,
 		uint32_t nominal_field_rate_in_uhz)
diff --git a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
index cf6bc9446244..62e326dd29a8 100644
--- a/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
+++ b/drivers/gpu/drm/amd/display/modules/inc/mod_freesync.h
@@ -194,4 +194,8 @@ unsigned int mod_freesync_calc_v_total_from_refresh(
 		const struct dc_stream_state *stream,
 		unsigned int refresh_in_uhz);
 
+// Returns true when FreeSync is supported and enabled (even if it is inactive)
+bool mod_freesync_get_freesync_enabled(struct mod_vrr_params *pVrr,
+		struct dc_stream_state *const pStream);
+
 #endif
-- 
2.36.1


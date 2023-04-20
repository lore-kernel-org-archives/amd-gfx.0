Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78756C77B78
	for <amd-gfx@archiver.kernel.org>; Thu, 20 Apr 2023 23:50:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E39D10ED5B;
	Thu, 20 Apr 2023 23:50:42 +0000 (UTC)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on20619.outbound.protection.outlook.com
 [IPv6:2a01:111:f400:7eb2::619])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B19310ED65
 for <amd-gfx@lists.freedesktop.org>; Thu, 20 Apr 2023 23:50:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WdaIzMK0kAxaaOTF+l/ykrBFSqHO9OA3cAo5HPvZcbUPCRQyBOGcY0ncHVuarMSot/65wir4Ebta8ROpYzovMAU/R9AeWxT+4VT6uAksPKcvIrqj2ROdBSF7EyVWPBG433i9+3OyGToa3C8g2qX6RtxGeazzNsL22UDTQIvpOcp9YmxHKa00aUu119rdkP/kgmHGAHrW2zX0ArDv1bypNxcbet34HTr44AJYGd89I5F2NZYr+gghOH5NYD5H9uti8dEjaKRn/h/uesSzm+JPJI3ijFl2syH10Pt4WRy4bYmibaH7fnWZyqS+waCcger/lJqHOMhY80y5NEK8W60Qvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+706ztP9mWXD01vB7Eoh7JcobhDjYRVZKXOOF+E/Bg=;
 b=MDQyctngDYKbHsKVtdGlaLsEO7bvb2tdBW9blPdvU7BgJYyI1OwLeCyYofn3uMkslnNqbOab4bT1VxrisjdyL1554ZrKFFDj4CoknRvh4Rszdxnbe4+oolhvSPXYlTnJZTYNQaVJf324M0luzqasRPpQMQCwWoBNOE+6JLNCDd7PJOg84zbgP99NP0ir93EJni1phaHM+FjGpysZ5tGzB57AwaY5RE+tyaxq3PIElg7oiPC8yMFindjOZ8HRg5+ohUxH2qbpBOXTc4Dv/FHxxTfZwqtTlPNwMS7CPImmcuW97AX5auHlBQ54nn0rt58/jG7wCZc/EVs1TRp6OjOKzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o+706ztP9mWXD01vB7Eoh7JcobhDjYRVZKXOOF+E/Bg=;
 b=r8GzRIwniu2lGcIk14KCLkWsgWmwpjPpZ6OyANaOi4xMnviEG+XG2PhMHOEdYMPhyxYg2gAXw4Px/MCzgxkAVWFBjvt0HtiRy3ffL18LAg0UfYZ3E4ABGmXOA+TWDBHExo6e8uFcSEzMo74ojJWnJ4OkYHaq/8JLE+mQYF33OZs=
Received: from DM6PR03CA0029.namprd03.prod.outlook.com (2603:10b6:5:40::42) by
 SA1PR12MB6893.namprd12.prod.outlook.com (2603:10b6:806:24c::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.22; Thu, 20 Apr
 2023 23:50:35 +0000
Received: from DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:40:cafe::f1) by DM6PR03CA0029.outlook.office365.com
 (2603:10b6:5:40::42) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.25 via Frontend
 Transport; Thu, 20 Apr 2023 23:50:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DM6NAM11FT080.mail.protection.outlook.com (10.13.173.105) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6319.27 via Frontend Transport; Thu, 20 Apr 2023 23:50:35 +0000
Received: from smtp.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 20 Apr
 2023 18:50:33 -0500
From: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/21] drm/amd/display: update extended blank for dcn314
 onwards
Date: Thu, 20 Apr 2023 17:49:45 -0600
Message-ID: <20230420234951.1772270-16-Rodrigo.Siqueira@amd.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
References: <20230420234951.1772270-1-Rodrigo.Siqueira@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6NAM11FT080:EE_|SA1PR12MB6893:EE_
X-MS-Office365-Filtering-Correlation-Id: df227150-b318-4476-4a7d-08db41fa0926
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: byD2oa3xNNoFz2ZJS/Ym66jEgyDe0dH0lg7a2+uivKcXbSFOc94jpWaQQhCsJhnvU/PZGacfVESeZtjqouEewrYRuei77YBOb/yuQnmKB3pv/Qk72D+zP9QSgaSXX3v1o6tkna6bgPa/tRU60Q14E+GTCRP6qsqsvsUoVecFmxPDPODozlZuWWECzhOgbG3ZDl4lSiDZZliuxl2rcasatjHxp+zpO4zuCKSx2mc1Z0fO9SwTEfIeoYLEzvwvXnWW3wNpm+tHnByfPRRn5/0Kf6Nd87rYdM6BKqb9B9yhzLtvnQmSGeNrSUFEGOXnof9uNaF8MPL1fOEN5vmoe5JG3uvISVLJcdYxZpKdghYBzllmrUUybngs7TOK4Z+aSVj+t1B6RMmTm7hE+AatK9YXsK/Vd/sIjxK+NBnSUfJq1WdXSEODuuiKRuW27aeWwLLJ4yKEy86uD6VYfSK4R2uwo7EGlFWKwQ/Z9A/2ZnrtsLlwCmrQQfSWHq2+5kfWevoxlnmPsxs4YDAlGKt9A0SSesuP35qZhMJsf13DC4Rl1OTPGA0hxHH3+RWWgiOoocMNnV+6OgdkiyjRtiZQ0+OusSTdAw1I+G/PhfXpMVYx7eDPOr3GRnib9lVSuH8zuxkAszN4Hui++x4mVgjMjK7tqT5LpA8Hnd1U6twuC9J7ldmBatdS521hPVz9gnEY6pg9qoOlFJuoKtnHy5ToZpUYGAq9lxvlXNGJi15HK+/aQXI=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230028)(4636009)(376002)(346002)(396003)(136003)(39860400002)(451199021)(40470700004)(36840700001)(46966006)(82740400003)(30864003)(2906002)(356005)(15650500001)(81166007)(40460700003)(86362001)(82310400005)(40480700001)(19627235002)(478600001)(54906003)(316002)(41300700001)(70586007)(70206006)(6916009)(4326008)(26005)(16526019)(1076003)(36860700001)(6666004)(186003)(36756003)(47076005)(426003)(8936002)(8676002)(336012)(83380400001)(5660300002)(2616005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Apr 2023 23:50:35.3409 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df227150-b318-4476-4a7d-08db41fa0926
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT080.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6893
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
 Gabe Teeger <gabe.teeger@amd.com>, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, wayne.lin@amd.com, Bhawanpreet.Lakha@amd.com,
 Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>, agustin.gutierrez@amd.com,
 pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Gabe Teeger <gabe.teeger@amd.com>

[Why]
Flickering and underflow was observed when testing extended
blank on dcn314.

[What]
Vstartup is contrainted by vblank_nom, so adjusting it to include
non-adjusted vtotal in its calculation during freesync video
means that Vstartup is not changed when vtotal changes.
This fixed the flickering + underflow.

dc_extended_blank_supported function was removed
because extended blank is only relevant to when
zstate is supported. The increased vtotal during
freesync can be passed to dml regardless of whether
extended blank is supported or not, so this function is
not needed.

Updates were made recently in dml to the calculation of
min_dst_y_next_start. Dml input for dcn314 will now
always use the newer calculation for min_dst_y_next_start.
Dml input for older dcn versions remains untouched.

The variable optimized_min_dst_y_next_start
is replaced everywhere with min_dst_y_next_start,
and the updated dml allows min_dst_y_next_start to
increase to an optimized value during freesync video,
then return to default when freesync is disengaged.

Also removed registry key for controlling
extended blank feature.

Reviewed-by: Nicholas Kazlauskas <Nicholas.Kazlauskas@amd.com>
Acked-by: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Signed-off-by: Gabe Teeger <gabe.teeger@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 21 -----------------
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 --
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  4 ++--
 .../drm/amd/display/dc/dml/dcn20/dcn20_fpu.c  | 23 +++++++++----------
 .../dc/dml/dcn31/display_rq_dlg_calc_31.c     |  3 +--
 .../amd/display/dc/dml/dcn314/dcn314_fpu.c    | 14 +++++++----
 .../dc/dml/dcn314/display_rq_dlg_calc_314.c   | 16 ++++---------
 .../amd/display/dc/dml/display_mode_structs.h |  3 +--
 8 files changed, 29 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index e65ba87ee2c5..1fe040544051 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2607,9 +2607,6 @@ static enum surface_update_type check_update_surfaces_for_stream(
 				stream_update->vrr_active_variable))
 			su_flags->bits.fams_changed = 1;
 
-		if (stream_update->crtc_timing_adjust && dc_extended_blank_supported(dc))
-			su_flags->bits.crtc_timing_adjust = 1;
-
 		if (su_flags->raw != 0)
 			overall_type = UPDATE_TYPE_FULL;
 
@@ -4870,21 +4867,3 @@ void dc_notify_vsync_int_state(struct dc *dc, struct dc_stream_state *stream, bo
 	if (pipe->stream_res.abm && pipe->stream_res.abm->funcs->set_abm_pause)
 		pipe->stream_res.abm->funcs->set_abm_pause(pipe->stream_res.abm, !enable, i, pipe->stream_res.tg->inst);
 }
-
-/**
- * dc_extended_blank_supported - Decide whether extended blank is supported
- *
- * @dc: [in] Current DC state
- *
- * Extended blank is a freesync optimization feature to be enabled in the
- * future.  During the extra vblank period gained from freesync, we have the
- * ability to enter z9/z10.
- *
- * Return:
- * Indicate whether extended blank is supported (%true or %false)
- */
-bool dc_extended_blank_supported(struct dc *dc)
-{
-	return dc->debug.extended_blank_optimization && !dc->debug.disable_z10
-		&& dc->caps.zstate_support && dc->caps.is_apu;
-}
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index dc0a61ca99d0..5268d98b96dc 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -2128,8 +2128,6 @@ struct dc_sink_init_data {
 	bool converter_disable_audio;
 };
 
-bool dc_extended_blank_supported(struct dc *dc);
-
 struct dc_sink *dc_sink_create(const struct dc_sink_init_data *init_params);
 
 /* Newer interfaces  */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 5800acf6aae1..f49c1c0d6274 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2130,7 +2130,7 @@ void dcn20_optimize_bandwidth(
 			dc->clk_mgr,
 			context,
 			true);
-	if (dc_extended_blank_supported(dc) && context->bw_ctx.bw.dcn.clk.zstate_support == DCN_ZSTATE_SUPPORT_ALLOW) {
+	if (context->bw_ctx.bw.dcn.clk.zstate_support == DCN_ZSTATE_SUPPORT_ALLOW) {
 		for (i = 0; i < dc->res_pool->pipe_count; ++i) {
 			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
 
@@ -2138,7 +2138,7 @@ void dcn20_optimize_bandwidth(
 				&& pipe_ctx->stream->adjust.v_total_min == pipe_ctx->stream->adjust.v_total_max
 				&& pipe_ctx->stream->adjust.v_total_max > pipe_ctx->stream->timing.v_total)
 					pipe_ctx->plane_res.hubp->funcs->program_extended_blank(pipe_ctx->plane_res.hubp,
-						pipe_ctx->dlg_regs.optimized_min_dst_y_next_start);
+						pipe_ctx->dlg_regs.min_dst_y_next_start);
 		}
 	}
 }
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
index f1c1a4b5fcac..7661f8946aa3 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn20/dcn20_fpu.c
@@ -948,10 +948,10 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 {
 	int plane_count;
 	int i;
-	unsigned int optimized_min_dst_y_next_start_us;
+	unsigned int min_dst_y_next_start_us;
 
 	plane_count = 0;
-	optimized_min_dst_y_next_start_us = 0;
+	min_dst_y_next_start_us = 0;
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		if (context->res_ctx.pipe_ctx[i].plane_state)
 			plane_count++;
@@ -973,19 +973,18 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 	else if (context->stream_count == 1 &&  context->streams[0]->signal == SIGNAL_TYPE_EDP) {
 		struct dc_link *link = context->streams[0]->sink->link;
 		struct dc_stream_status *stream_status = &context->stream_status[0];
+		struct dc_stream_state *current_stream = context->streams[0];
 		int minmum_z8_residency = dc->debug.minimum_z8_residency_time > 0 ? dc->debug.minimum_z8_residency_time : 1000;
 		bool allow_z8 = context->bw_ctx.dml.vba.StutterPeriod > (double)minmum_z8_residency;
 		bool is_pwrseq0 = link->link_index == 0;
+		bool isFreesyncVideo;
 
-		if (dc_extended_blank_supported(dc)) {
-			for (i = 0; i < dc->res_pool->pipe_count; i++) {
-				if (context->res_ctx.pipe_ctx[i].stream == context->streams[0]
-					&& context->res_ctx.pipe_ctx[i].stream->adjust.v_total_min == context->res_ctx.pipe_ctx[i].stream->adjust.v_total_max
-					&& context->res_ctx.pipe_ctx[i].stream->adjust.v_total_min > context->res_ctx.pipe_ctx[i].stream->timing.v_total) {
-						optimized_min_dst_y_next_start_us =
-							context->res_ctx.pipe_ctx[i].dlg_regs.optimized_min_dst_y_next_start_us;
-						break;
-				}
+		isFreesyncVideo = current_stream->adjust.v_total_min == current_stream->adjust.v_total_max;
+		isFreesyncVideo = isFreesyncVideo && current_stream->timing.v_total < current_stream->adjust.v_total_min;
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			if (context->res_ctx.pipe_ctx[i].stream == current_stream && isFreesyncVideo) {
+				min_dst_y_next_start_us = context->res_ctx.pipe_ctx[i].dlg_regs.min_dst_y_next_start_us;
+				break;
 			}
 		}
 
@@ -993,7 +992,7 @@ static enum dcn_zstate_support_state  decide_zstate_support(struct dc *dc, struc
 		if (stream_status->plane_count > 1)
 			return DCN_ZSTATE_SUPPORT_DISALLOW;
 
-		if (is_pwrseq0 && (context->bw_ctx.dml.vba.StutterPeriod > 5000.0 || optimized_min_dst_y_next_start_us > 5000))
+		if (is_pwrseq0 && (context->bw_ctx.dml.vba.StutterPeriod > 5000.0 || min_dst_y_next_start_us > 5000))
 			return DCN_ZSTATE_SUPPORT_ALLOW;
 		else if (is_pwrseq0 && link->psr_settings.psr_version == DC_PSR_VERSION_1 && !link->panel_config.psr.disable_psr)
 			return allow_z8 ? DCN_ZSTATE_SUPPORT_ALLOW_Z8_Z10_ONLY : DCN_ZSTATE_SUPPORT_ALLOW_Z10_ONLY;
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
index 2244e4fb8c96..fcde8f21b8be 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn31/display_rq_dlg_calc_31.c
@@ -987,8 +987,7 @@ static void dml_rq_dlg_get_dlg_params(
 
 	dlg_vblank_start = interlaced ? (vblank_start / 2) : vblank_start;
 	disp_dlg_regs->min_dst_y_next_start = (unsigned int) (((double) dlg_vblank_start) * dml_pow(2, 2));
-	disp_dlg_regs->optimized_min_dst_y_next_start_us = 0;
-	disp_dlg_regs->optimized_min_dst_y_next_start = disp_dlg_regs->min_dst_y_next_start;
+	disp_dlg_regs->min_dst_y_next_start_us = 0;
 	ASSERT(disp_dlg_regs->min_dst_y_next_start < (unsigned int)dml_pow(2, 18));
 
 	dml_print("DML_DLG: %s: min_ttu_vblank (us)         = %3.2f\n", __func__, min_ttu_vblank);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
index 44082f65de1f..19370b872a91 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/dcn314_fpu.c
@@ -286,6 +286,7 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 	struct resource_context *res_ctx = &context->res_ctx;
 	struct pipe_ctx *pipe;
 	bool upscaled = false;
+	bool isFreesyncVideo = false;
 
 	dc_assert_fp_enabled();
 
@@ -299,9 +300,16 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 		pipe = &res_ctx->pipe_ctx[i];
 		timing = &pipe->stream->timing;
 
-		if (dc_extended_blank_supported(dc) && pipe->stream->adjust.v_total_max == pipe->stream->adjust.v_total_min
-			&& pipe->stream->adjust.v_total_min > timing->v_total)
+		isFreesyncVideo = pipe->stream->adjust.v_total_max == pipe->stream->adjust.v_total_min;
+		isFreesyncVideo = isFreesyncVideo && pipe->stream->adjust.v_total_min > timing->v_total;
+
+		if (!isFreesyncVideo) {
+			pipes[pipe_cnt].pipe.dest.vblank_nom =
+				dcn3_14_ip.VBlankNomDefaultUS / (timing->h_total / (timing->pix_clk_100hz / 10000.0));
+		} else {
 			pipes[pipe_cnt].pipe.dest.vtotal = pipe->stream->adjust.v_total_min;
+			pipes[pipe_cnt].pipe.dest.vblank_nom = timing->v_total - pipes[pipe_cnt].pipe.dest.vactive;
+		}
 
 		if (pipe->plane_state &&
 				(pipe->plane_state->src_rect.height < pipe->plane_state->dst_rect.height ||
@@ -323,8 +331,6 @@ int dcn314_populate_dml_pipes_from_context_fpu(struct dc *dc, struct dc_state *c
 		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_luma = 0;
 		pipes[pipe_cnt].pipe.src.dcc_fraction_of_zs_req_chroma = 0;
 		pipes[pipe_cnt].pipe.dest.vfront_porch = timing->v_front_porch;
-		pipes[pipe_cnt].pipe.dest.vblank_nom =
-				dcn3_14_ip.VBlankNomDefaultUS / (timing->h_total / (timing->pix_clk_100hz / 10000.0));
 		pipes[pipe_cnt].pipe.src.dcc_rate = 3;
 		pipes[pipe_cnt].dout.dsc_input_bpc = 0;
 
diff --git a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
index ea4eb66066c4..4f945458b2b7 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn314/display_rq_dlg_calc_314.c
@@ -1051,7 +1051,6 @@ static void dml_rq_dlg_get_dlg_params(
 
 	float vba__refcyc_per_req_delivery_pre_l = get_refcyc_per_req_delivery_pre_l_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;  // From VBA
 	float vba__refcyc_per_req_delivery_l = get_refcyc_per_req_delivery_l_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx) * refclk_freq_in_mhz;  // From VBA
-	int blank_lines = 0;
 
 	memset(disp_dlg_regs, 0, sizeof(*disp_dlg_regs));
 	memset(disp_ttu_regs, 0, sizeof(*disp_ttu_regs));
@@ -1075,17 +1074,10 @@ static void dml_rq_dlg_get_dlg_params(
 	min_ttu_vblank = get_min_ttu_vblank_in_us(mode_lib, e2e_pipe_param, num_pipes, pipe_idx);	// From VBA
 
 	dlg_vblank_start = interlaced ? (vblank_start / 2) : vblank_start;
-	disp_dlg_regs->optimized_min_dst_y_next_start = disp_dlg_regs->min_dst_y_next_start;
-	disp_dlg_regs->optimized_min_dst_y_next_start_us = 0;
-	disp_dlg_regs->min_dst_y_next_start = (unsigned int) (((double) dlg_vblank_start) * dml_pow(2, 2));
-	blank_lines = (dst->vblank_end + dst->vtotal_min - dst->vblank_start - dst->vstartup_start - 1);
-	if (blank_lines < 0)
-		blank_lines = 0;
-	if (blank_lines != 0) {
-		disp_dlg_regs->optimized_min_dst_y_next_start = vba__min_dst_y_next_start;
-		disp_dlg_regs->optimized_min_dst_y_next_start_us = (disp_dlg_regs->optimized_min_dst_y_next_start * dst->hactive) / (unsigned int) dst->pixel_rate_mhz;
-		disp_dlg_regs->min_dst_y_next_start = disp_dlg_regs->optimized_min_dst_y_next_start;
-	}
+	disp_dlg_regs->min_dst_y_next_start_us =
+		(vba__min_dst_y_next_start * dst->hactive) / (unsigned int) dst->pixel_rate_mhz;
+	disp_dlg_regs->min_dst_y_next_start = vba__min_dst_y_next_start * dml_pow(2, 2);
+
 	ASSERT(disp_dlg_regs->min_dst_y_next_start < (unsigned int)dml_pow(2, 18));
 
 	dml_print("DML_DLG: %s: min_ttu_vblank (us)         = %3.2f\n", __func__, min_ttu_vblank);
diff --git a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
index 3c077164f362..ff0246a9458f 100644
--- a/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
+++ b/drivers/gpu/drm/amd/display/dc/dml/display_mode_structs.h
@@ -619,8 +619,7 @@ struct _vcs_dpi_display_dlg_regs_st {
 	unsigned int refcyc_h_blank_end;
 	unsigned int dlg_vblank_end;
 	unsigned int min_dst_y_next_start;
-	unsigned int optimized_min_dst_y_next_start;
-	unsigned int optimized_min_dst_y_next_start_us;
+	unsigned int min_dst_y_next_start_us;
 	unsigned int refcyc_per_htotal;
 	unsigned int refcyc_x_after_scaler;
 	unsigned int dst_y_after_scaler;
-- 
2.39.2


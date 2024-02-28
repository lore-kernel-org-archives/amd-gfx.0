Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C8FC54E41
	for <amd-gfx@archiver.kernel.org>; Wed, 28 Feb 2024 18:44:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92A7D10E4B5;
	Wed, 28 Feb 2024 18:44:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="oVp7pkaZ";
	dkim-atps=neutral
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B017110E4D8
 for <amd-gfx@lists.freedesktop.org>; Wed, 28 Feb 2024 18:44:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U/Iow0c7bSS8MHA8IV5QwTgEEVllUFDUTJz0rRRiI0ZdROooKnSdDFcdeKYHHwr/J8gHrFUM6/xo46VRHuIwBkpzFHldlnnTXqYuBusYHGa0OTLIyRoq1vqglWYBhMH1MgfAtkqvlZfJTaiq/h9jXkns3fJGnH5adLx2CAAcvvBKJoAhNZDaIQqeHkzSc8ntn+CjBZ/QNEOL6ekr66tLqNs0MWsSIFw3fnCha9zA0+hRC8gehwyG+7gyK94peoF+3jw94AW285vxU3oD3rKKnXtRXXxaK3LQsMWjatyMTgM8sNL0sSGrrmewAXSCHPCVWBO/iaOA8SuIHyibgEHfuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5yLT8R8npkILgThrjaLhQbBmB5gzddd6yU4hGtNq48A=;
 b=i45/HGysrPHednZEqB+YKxtpXgg6KdmcPmRgI1DFISzTuU9HMM+7mNvKURj2k9J2l5yVTZ2skH3iOsfsP+qo7Y4U/d6GJw92GuzBKofEitfD8aGFVZ1TYe8vI18IuNGE9YagYWYE75opez8douRQWkPZbQ7tGM1I7g1wIRXP+lBfW+EQJb3Le0KBpGi7uDJonUyohNCX/Sb24aA+V3a9fRi+IbWpS/UoNBbIHLxbn2stT1WvPssDEEZUjmgMNX23pcjAHmenZ4naiLEP0watu3uXN87DHibZvURyk1JkQEIS7dhcEl2TAPRqKj3amXboVBtou3073ehMZsMmcwFrPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5yLT8R8npkILgThrjaLhQbBmB5gzddd6yU4hGtNq48A=;
 b=oVp7pkaZJNpZ5R60mvewp58oLpZQp8j74MrqzRAgU/r+/X9x6jdwc5IEl1zWChUtqD5Ld5zryVxTV5/ph5rZS0K6tCAsrIBCF+vlp3cqcVzDzLEqUKPcwN/k9AxVW1u35pSA44mD+yfLkU4G5xzj78W4Q/ZpThq+NR7w+3y9D50=
Received: from CYXPR02CA0061.namprd02.prod.outlook.com (2603:10b6:930:cd::21)
 by SA1PR12MB7038.namprd12.prod.outlook.com (2603:10b6:806:24d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 18:43:57 +0000
Received: from CY4PEPF0000E9D8.namprd05.prod.outlook.com
 (2603:10b6:930:cd:cafe::e1) by CYXPR02CA0061.outlook.office365.com
 (2603:10b6:930:cd::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.28 via Frontend
 Transport; Wed, 28 Feb 2024 18:43:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000E9D8.mail.protection.outlook.com (10.167.241.83) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7292.25 via Frontend Transport; Wed, 28 Feb 2024 18:43:56 +0000
Received: from dev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 28 Feb
 2024 12:43:53 -0600
From: Alex Hung <alex.hung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: <Harry.Wentland@amd.com>, <Sunpeng.Li@amd.com>,
 <Rodrigo.Siqueira@amd.com>, <Aurabindo.Pillai@amd.com>, <roman.li@amd.com>,
 <wayne.lin@amd.com>, <agustin.gutierrez@amd.com>, <chiahsuan.chung@amd.com>,
 <hersenxs.wu@amd.com>, <jerry.zuo@amd.com>, Robin Chen <robin.chen@amd.com>,
 Jun Lei <jun.lei@amd.com>, Alex Hung <alex.hung@amd.com>, ChunTao Tso
 <chuntao.tso@amd.com>
Subject: [PATCH 14/34] drm/amd/display: Support long vblank feature
Date: Wed, 28 Feb 2024 11:39:20 -0700
Message-ID: <20240228183940.1883742-15-alex.hung@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228183940.1883742-1-alex.hung@amd.com>
References: <20240228183940.1883742-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D8:EE_|SA1PR12MB7038:EE_
X-MS-Office365-Filtering-Correlation-Id: 381ec0f8-5557-4942-58f0-08dc388d3896
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VVanN1t3ai1FbWdCy1L8of+C8OgCsY+9kuE28rqguDOJkb1mVdWAHgxD0SU/zNTBifgesRdCffZbeBvGjBaX5HVdEKLo9qoP6stuJoU40D+gjSKdx9iFsmfkxVdAgryKHaUlJTiGafndcrAZi4jtfO6KlenwqxSKcwNAvRiMIU6aBe+3XKuZ1JHnK5qKAkbzighyvsZF66tjPmM0gVKM5Yc4MqwRB/5nQFRVQX94ptk/8iNN7SfwzQuuVT+nrR8kNgF+S0V4HpW2B4JALAx9vUCsn9Tlu58OhBIjuOU2CBUYc+kvSkK4VUbXapdvc+fAmwyDMi3tyQf/JOkfalbTrRsIPEJaRMdOROXTcueaDMTKSF8MZAfDe/rCa0e56gm07lOBTw9H6p/olKTHim5x5qSIh0oxsZT88t4wHOHaMWPZAKPTENJWFCO+Ddn4tlJDbknNgyJJw9gtT5fRt8MIqBmjG1UebL9sv4Eles5GGRXc685AGbyhOqd8aX0WRN4/DxCLDDEUTeyEBzy6b5th2dGvXVR6IQ92HNDyDDAobfvxOcLsYLDtQy7WVQsYIpO40Gl4i54p1YPFR/6ftSFOTofBjN2SbJWgLdWpPSk3UdrazvNXO+z54YiM0uD/iQiH5fir+RteVHH2a3mOhd0lU0ydhR2SSJLtgQZ5LkEFL9gpUw8IZ3nInfykr81dhFO2zHcoUkMrJL+9vzJxqQm1wAr9oEoAht/V1EAjmX/48iBJHXY4Znp9Q0LOLJFsFWs/
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230031)(82310400014)(36860700004); DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 18:43:56.9595 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 381ec0f8-5557-4942-58f0-08dc388d3896
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7038
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Robin Chen <robin.chen@amd.com>

[WHY]
We want to support low hz case, but the original
vtotal/vtotal_min/vtotal_max can't support more
than 0x7FFF.

[HOW]
We use the 2 HW reg to contorl long vblank case.
1. OTG_V_COUNT_STOP_CONTROL -> vcount_stop
2. OTG_V_COUNT_STOP_CONTROL2 -> vcount_stop_timer

vcount_stop define from which line we stop using vcount
and start using vcount2.
vcount_stop_timer define how long we use vcount2.

Ex:
Vtotal = 7
OTG_V_COUNT_STOP_CONTROL = 4
OTG_V_COUNT_STOP_CONTROL2 = 5

time    : 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11
vcount  : 0, 1, 2, 3, -  -  -  -  -  4,  5,  6
vcount2 :             0, 1, 2, 3, 4,

Reviewed-by: Jun Lei <jun.lei@amd.com>
Acked-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: ChunTao Tso <chuntao.tso@amd.com>
Signed-off-by: Robin Chen<robin.chen@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  33 ++++
 drivers/gpu/drm/amd/display/dc/dc_hw_types.h  |   1 +
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.c   |  28 +++
 .../amd/display/dc/hwss/dcn35/dcn35_hwseq.h   |   3 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   3 +-
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |   1 +
 .../amd/display/dc/inc/hw/timing_generator.h  |   7 +
 .../amd/display/dc/optc/dcn10/dcn10_optc.h    |   6 +-
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    | 165 +++++++++++++++++-
 .../amd/display/dc/optc/dcn35/dcn35_optc.h    |   6 +-
 .../dc/resource/dcn35/dcn35_resource.h        |   2 +
 .../amd/display/modules/freesync/freesync.c   |   2 +
 12 files changed, 253 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 501e0298623a..daf6c7fe0906 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -386,6 +386,30 @@ static void dc_perf_trace_destroy(struct dc_perf_trace **perf_trace)
 	*perf_trace = NULL;
 }
 
+static bool set_long_vtotal(struct dc *dc, struct dc_stream_state *stream, struct dc_crtc_timing_adjust *adjust)
+{
+	if (!dc || !stream || !adjust)
+		return false;
+
+	if (!dc->current_state)
+		return false;
+
+	int i;
+
+	for (i = 0; i < MAX_PIPES; i++) {
+		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+
+		if (pipe->stream == stream && pipe->stream_res.tg) {
+			if (dc->hwss.set_long_vtotal)
+				dc->hwss.set_long_vtotal(&pipe, 1, adjust->v_total_min, adjust->v_total_max);
+
+			return true;
+		}
+	}
+
+	return false;
+}
+
 /**
  *  dc_stream_adjust_vmin_vmax - look up pipe context & update parts of DRR
  *  @dc:     dc reference
@@ -420,6 +444,15 @@ bool dc_stream_adjust_vmin_vmax(struct dc *dc,
 	stream->adjust.v_total_mid = adjust->v_total_mid;
 	stream->adjust.v_total_mid_frame_num = adjust->v_total_mid_frame_num;
 	stream->adjust.v_total_min = adjust->v_total_min;
+	stream->adjust.allow_otg_v_count_halt = adjust->allow_otg_v_count_halt;
+
+	if (dc->caps.max_v_total != 0 &&
+		(adjust->v_total_max > dc->caps.max_v_total || adjust->v_total_min > dc->caps.max_v_total)) {
+		if (adjust->allow_otg_v_count_halt)
+			return set_long_vtotal(dc, stream, adjust);
+		else
+			return false;
+	}
 
 	for (i = 0; i < MAX_PIPES; i++) {
 		struct pipe_ctx *pipe = &dc->current_state->res_ctx.pipe_ctx[i];
diff --git a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
index aae2f3a2660d..465e15f57f93 100644
--- a/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
+++ b/drivers/gpu/drm/amd/display/dc/dc_hw_types.h
@@ -974,6 +974,7 @@ struct dc_crtc_timing_adjust {
 	uint32_t v_total_max;
 	uint32_t v_total_mid;
 	uint32_t v_total_mid_frame_num;
+	uint32_t allow_otg_v_count_halt;
 };
 
 
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
index 4b92df23ff0d..2e8ec58a16eb 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.c
@@ -1394,3 +1394,31 @@ void dcn35_set_static_screen_control(struct pipe_ctx **pipe_ctx,
 			set_static_screen_control(pipe_ctx[i]->stream_res.tg,
 					triggers, params->num_frames);
 }
+
+void dcn35_set_long_vblank(struct pipe_ctx **pipe_ctx,
+		int num_pipes, uint32_t v_total_min, uint32_t v_total_max)
+{
+	int i = 0;
+	struct long_vtotal_params params = {0};
+
+	params.vertical_total_max = v_total_max;
+	params.vertical_total_min = v_total_min;
+
+	for (i = 0; i < num_pipes; i++) {
+		if (!pipe_ctx[i])
+			continue;
+
+		if (pipe_ctx[i]->stream) {
+			struct dc_crtc_timing *timing = &pipe_ctx[i]->stream->timing;
+
+			if (timing)
+				params.vertical_blank_start = timing->v_total - timing->v_front_porch;
+			else
+				params.vertical_blank_start = 0;
+
+			if ((pipe_ctx[i]->stream_res.tg != NULL) && pipe_ctx[i]->stream_res.tg->funcs &&
+				pipe_ctx[i]->stream_res.tg->funcs->set_long_vtotal)
+				pipe_ctx[i]->stream_res.tg->funcs->set_long_vtotal(pipe_ctx[i]->stream_res.tg, &params);
+		}
+	}
+}
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
index c354efa6c1b2..7c33bea3f4e7 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_hwseq.h
@@ -93,4 +93,7 @@ void dcn35_set_drr(struct pipe_ctx **pipe_ctx,
 void dcn35_set_static_screen_control(struct pipe_ctx **pipe_ctx,
 		int num_pipes, const struct dc_static_screen_params *params);
 
+void dcn35_set_long_vblank(struct pipe_ctx **pipe_ctx,
+		int num_pipes, uint32_t v_total_min, uint32_t v_total_max);
+
 #endif /* __DC_HWSS_DCN35_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index a93073055e7b..dce620d359a6 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -122,7 +122,8 @@ static const struct hw_sequencer_funcs dcn35_funcs = {
 	.hw_block_power_down = dcn35_hw_block_power_down,
 	.root_clock_control = dcn35_root_clock_control,
 	.set_idle_state = dcn35_set_idle_state,
-	.get_idle_state = dcn35_get_idle_state
+	.get_idle_state = dcn35_get_idle_state,
+	.set_long_vtotal = dcn35_set_long_vblank,
 };
 
 static const struct hwseq_private_funcs dcn35_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index f89f205e42a1..26ea86316e50 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -429,6 +429,7 @@ struct hw_sequencer_funcs {
 	bool (*is_pipe_topology_transition_seamless)(struct dc *dc,
 			const struct dc_state *cur_ctx,
 			const struct dc_state *new_ctx);
+	void (*set_long_vtotal)(struct pipe_ctx **pipe_ctx, int num_pipes, uint32_t v_total_min, uint32_t v_total_max);
 };
 
 void color_space_to_black_color(
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
index d98d72f35be5..c5527f68f076 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/timing_generator.h
@@ -64,6 +64,12 @@ struct drr_params {
 	bool immediate_flip;
 };
 
+struct long_vtotal_params {
+	uint32_t vertical_total_min;
+	uint32_t vertical_total_max;
+	uint32_t vertical_blank_start;
+};
+
 #define LEFT_EYE_3D_PRIMARY_SURFACE 1
 #define RIGHT_EYE_3D_PRIMARY_SURFACE 0
 
@@ -331,6 +337,7 @@ struct timing_generator_funcs {
 
 	void (*init_odm)(struct timing_generator *tg);
 	void (*wait_drr_doublebuffer_pending_clear)(struct timing_generator *tg);
+	void (*set_long_vtotal)(struct timing_generator *optc, const struct long_vtotal_params *params);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
index ab81594a7fad..4cfd1ed06777 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn10/dcn10_optc.h
@@ -129,6 +129,8 @@ struct dcn_optc_registers {
 	uint32_t OTG_V_TOTAL_MID;
 	uint32_t OTG_V_TOTAL_MIN;
 	uint32_t OTG_V_TOTAL_CONTROL;
+	uint32_t OTG_V_COUNT_STOP_CONTROL;
+	uint32_t OTG_V_COUNT_STOP_CONTROL2;
 	uint32_t OTG_TRIGA_CNTL;
 	uint32_t OTG_TRIGA_MANUAL_TRIG;
 	uint32_t OTG_MANUAL_FLOW_CONTROL;
@@ -580,7 +582,9 @@ struct dcn_optc_registers {
 	type OTG_CRC1_WINDOWB_X_END_READBACK;\
 	type OTG_CRC1_WINDOWB_Y_START_READBACK;\
 	type OTG_CRC1_WINDOWB_Y_END_READBACK;\
-	type OPTC_FGCG_REP_DIS;
+	type OPTC_FGCG_REP_DIS;\
+	type OTG_V_COUNT_STOP;\
+	type OTG_V_COUNT_STOP_TIMER;
 
 struct dcn_optc_shift {
 	TG_REG_FIELD_LIST(uint8_t)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index 5b1547508850..d393be30dff8 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -32,6 +32,7 @@
 #include "reg_helper.h"
 #include "dc.h"
 #include "dcn_calc_math.h"
+#include "dc_dmub_srv.h"
 
 #define REG(reg)\
 	optc1->tg_regs->reg
@@ -213,6 +214,167 @@ static bool optc35_configure_crc(struct timing_generator *optc,
 	return true;
 }
 
+static void optc35_setup_manual_trigger(struct timing_generator *optc)
+{
+	if (!optc || !optc->ctx)
+		return;
+
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+	struct dc *dc = optc->ctx->dc;
+
+	if (dc->caps.dmub_caps.mclk_sw && !dc->debug.disable_fams)
+		dc_dmub_srv_set_drr_manual_trigger_cmd(dc, optc->inst);
+	else {
+		/*
+		 * MIN_MASK_EN is gone and MASK is now always enabled.
+		 *
+		 * To get it to it work with manual trigger we need to make sure
+		 * we program the correct bit.
+		 */
+		REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
+				OTG_V_TOTAL_MIN_SEL, 1,
+				OTG_V_TOTAL_MAX_SEL, 1,
+				OTG_FORCE_LOCK_ON_EVENT, 0,
+				OTG_SET_V_TOTAL_MIN_MASK, (1 << 1)); /* TRIGA */
+
+		// Setup manual flow control for EOF via TRIG_A
+		if (optc->funcs && optc->funcs->setup_manual_trigger)
+			optc->funcs->setup_manual_trigger(optc);
+	}
+}
+
+void optc35_set_drr(
+	struct timing_generator *optc,
+	const struct drr_params *params)
+{
+	if (!optc || !params)
+		return;
+
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+	uint32_t max_otg_v_total = optc1->max_v_total - 1;
+
+	if (params != NULL &&
+		params->vertical_total_max > 0 &&
+		params->vertical_total_min > 0) {
+
+		if (params->vertical_total_mid != 0) {
+
+			REG_SET(OTG_V_TOTAL_MID, 0,
+				OTG_V_TOTAL_MID, params->vertical_total_mid - 1);
+
+			REG_UPDATE_2(OTG_V_TOTAL_CONTROL,
+					OTG_VTOTAL_MID_REPLACING_MAX_EN, 1,
+					OTG_VTOTAL_MID_FRAME_NUM,
+					(uint8_t)params->vertical_total_mid_frame_num);
+
+		}
+
+		if (optc->funcs && optc->funcs->set_vtotal_min_max)
+			optc->funcs->set_vtotal_min_max(optc,
+				params->vertical_total_min - 1, params->vertical_total_max - 1);
+		optc35_setup_manual_trigger(optc);
+	} else {
+		REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
+				OTG_SET_V_TOTAL_MIN_MASK, 0,
+				OTG_V_TOTAL_MIN_SEL, 0,
+				OTG_V_TOTAL_MAX_SEL, 0,
+				OTG_FORCE_LOCK_ON_EVENT, 0);
+
+		if (optc->funcs && optc->funcs->set_vtotal_min_max)
+			optc->funcs->set_vtotal_min_max(optc, 0, 0);
+	}
+
+	REG_WRITE(OTG_V_COUNT_STOP_CONTROL, max_otg_v_total);
+	REG_WRITE(OTG_V_COUNT_STOP_CONTROL2, 0);
+}
+
+static void optc35_set_long_vtotal(
+	struct timing_generator *optc,
+	const struct long_vtotal_params *params)
+{
+	if (!optc || !params)
+		return;
+
+	struct optc *optc1 = DCN10TG_FROM_TG(optc);
+	uint32_t vcount_stop_timer = 0, vcount_stop = 0;
+	uint32_t max_otg_v_total = optc1->max_v_total - 1;
+
+	if (params->vertical_total_min <= max_otg_v_total && params->vertical_total_max <= max_otg_v_total)
+		return;
+
+	if (params->vertical_total_max == 0 || params->vertical_total_min == 0) {
+		REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
+						OTG_SET_V_TOTAL_MIN_MASK, 0,
+						OTG_V_TOTAL_MIN_SEL, 0,
+						OTG_V_TOTAL_MAX_SEL, 0,
+						OTG_FORCE_LOCK_ON_EVENT, 0);
+
+		if (optc->funcs && optc->funcs->set_vtotal_min_max)
+			optc->funcs->set_vtotal_min_max(optc, 0, 0);
+	} else if (params->vertical_total_max == params->vertical_total_min) {
+		vcount_stop = params->vertical_blank_start;
+		vcount_stop_timer = params->vertical_total_max - max_otg_v_total;
+
+		REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
+				OTG_V_TOTAL_MIN_SEL, 1,
+				OTG_V_TOTAL_MAX_SEL, 1,
+				OTG_FORCE_LOCK_ON_EVENT, 0,
+				OTG_SET_V_TOTAL_MIN_MASK, 0);
+
+		if (optc->funcs && optc->funcs->set_vtotal_min_max)
+			optc->funcs->set_vtotal_min_max(optc, max_otg_v_total, max_otg_v_total);
+
+		REG_WRITE(OTG_V_COUNT_STOP_CONTROL, vcount_stop);
+		REG_WRITE(OTG_V_COUNT_STOP_CONTROL2, vcount_stop_timer);
+	} else {
+		// Variable rate, keep DRR trigger mask
+		if (params->vertical_total_min > max_otg_v_total) {
+			// cannot be supported
+			// If MAX_OTG_V_COUNT < DRR trigger < v_total_min < v_total_max,
+			// DRR trigger will drop the vtotal counting directly to a new frame.
+			// But it should trigger between v_total_min and v_total_max.
+			ASSERT(0);
+
+			REG_UPDATE_4(OTG_V_TOTAL_CONTROL,
+				OTG_SET_V_TOTAL_MIN_MASK, 0,
+				OTG_V_TOTAL_MIN_SEL, 0,
+				OTG_V_TOTAL_MAX_SEL, 0,
+				OTG_FORCE_LOCK_ON_EVENT, 0);
+
+			if (optc->funcs && optc->funcs->set_vtotal_min_max)
+				optc->funcs->set_vtotal_min_max(optc, 0, 0);
+
+			REG_WRITE(OTG_V_COUNT_STOP_CONTROL, max_otg_v_total);
+			REG_WRITE(OTG_V_COUNT_STOP_CONTROL2, 0);
+		} else {
+			// For total_min <= MAX_OTG_V_COUNT and total_max > MAX_OTG_V_COUNT
+			vcount_stop = params->vertical_total_min;
+			vcount_stop_timer = params->vertical_total_max - max_otg_v_total;
+
+			// Example:
+			// params->vertical_total_min 1000
+			// params->vertical_total_max 2000
+			// MAX_OTG_V_COUNT_STOP = 1500
+			//
+			// If DRR event not happened,
+			//     time     0,1,2,3,4,...1000,1001,........,1500,1501,1502,     ...1999
+			//     vcount   0,1,2,3,4....1000...................,1001,1002,1003,...1399
+			//     vcount2                       0,1,2,3,4,..499,
+			// else (DRR event happened, ex : at line 1004)
+			//     time    0,1,2,3,4,...1000,1001.....1004, 0
+			//     vcount  0,1,2,3,4....1000,.............. 0 (new frame)
+			//     vcount2                      0,1,2,   3, -
+			if (optc->funcs && optc->funcs->set_vtotal_min_max)
+				optc->funcs->set_vtotal_min_max(optc,
+					params->vertical_total_min - 1, max_otg_v_total);
+			optc35_setup_manual_trigger(optc);
+
+			REG_WRITE(OTG_V_COUNT_STOP_CONTROL, vcount_stop);
+			REG_WRITE(OTG_V_COUNT_STOP_CONTROL2, vcount_stop_timer);
+		}
+	}
+}
+
 static struct timing_generator_funcs dcn35_tg_funcs = {
 		.validate_timing = optc1_validate_timing,
 		.program_timing = optc1_program_timing,
@@ -245,7 +407,7 @@ static struct timing_generator_funcs dcn35_tg_funcs = {
 		.lock_doublebuffer_enable = optc3_lock_doublebuffer_enable,
 		.lock_doublebuffer_disable = optc3_lock_doublebuffer_disable,
 		.enable_optc_clock = optc1_enable_optc_clock,
-		.set_drr = optc31_set_drr,
+		.set_drr = optc35_set_drr,
 		.get_last_used_drr_vtotal = optc2_get_last_used_drr_vtotal,
 		.set_vtotal_min_max = optc1_set_vtotal_min_max,
 		.set_static_screen_control = optc1_set_static_screen_control,
@@ -275,6 +437,7 @@ static struct timing_generator_funcs dcn35_tg_funcs = {
 		.setup_manual_trigger = optc2_setup_manual_trigger,
 		.get_hw_timing = optc1_get_hw_timing,
 		.init_odm = optc3_init_odm,
+		.set_long_vtotal = optc35_set_long_vtotal,
 };
 
 void dcn35_timing_generator_init(struct optc *optc1)
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
index 1f422e4c468f..d077e2392379 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.h
@@ -65,10 +65,14 @@
 	SF(OTG0_OTG_CRC1_WINDOWB_X_CONTROL_READBACK, OTG_CRC1_WINDOWB_X_END_READBACK, mask_sh),\
 	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL_READBACK, OTG_CRC1_WINDOWB_Y_START_READBACK, mask_sh),\
 	SF(OTG0_OTG_CRC1_WINDOWB_Y_CONTROL_READBACK, OTG_CRC1_WINDOWB_Y_END_READBACK, mask_sh),\
-	SF(OPTC_CLOCK_CONTROL, OPTC_FGCG_REP_DIS, mask_sh)
+	SF(OPTC_CLOCK_CONTROL, OPTC_FGCG_REP_DIS, mask_sh),\
+	SF(OTG0_OTG_V_COUNT_STOP_CONTROL, OTG_V_COUNT_STOP, mask_sh),\
+	SF(OTG0_OTG_V_COUNT_STOP_CONTROL2, OTG_V_COUNT_STOP_TIMER, mask_sh)
 
 void dcn35_timing_generator_init(struct optc *optc1);
 
 void dcn35_timing_generator_set_fgcg(struct optc *optc1, bool enable);
 
+void optc35_set_drr(struct timing_generator *optc, const struct drr_params *params);
+
 #endif /* __DC_OPTC_DCN35_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.h b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.h
index a51c4a9eaafe..f97bb4cb3761 100644
--- a/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.h
+++ b/drivers/gpu/drm/amd/display/dc/resource/dcn35/dcn35_resource.h
@@ -240,6 +240,8 @@ struct resource_pool *dcn35_create_resource_pool(
 	SRI_ARR(OTG_V_TOTAL_MAX, OTG, inst),\
 	SRI_ARR(OTG_V_TOTAL_MIN, OTG, inst),\
 	SRI_ARR(OTG_V_TOTAL_CONTROL, OTG, inst),\
+	SRI_ARR(OTG_V_COUNT_STOP_CONTROL, OTG, inst),\
+	SRI_ARR(OTG_V_COUNT_STOP_CONTROL2, OTG, inst),\
 	SRI_ARR(OTG_TRIGA_CNTL, OTG, inst),\
 	SRI_ARR(OTG_FORCE_COUNT_NOW_CNTL, OTG, inst),\
 	SRI_ARR(OTG_STATIC_SCREEN_CONTROL, OTG, inst),\
diff --git a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
index 3955b7e4b2e2..fbaa6effd0e3 100644
--- a/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
+++ b/drivers/gpu/drm/amd/display/modules/freesync/freesync.c
@@ -1126,6 +1126,8 @@ void mod_freesync_build_vrr_params(struct mod_freesync *mod_freesync,
 		in_out_vrr->adjust.v_total_min = stream->timing.v_total;
 		in_out_vrr->adjust.v_total_max = stream->timing.v_total;
 	}
+
+	in_out_vrr->adjust.allow_otg_v_count_halt = (in_config->state == VRR_STATE_ACTIVE_FIXED) ? true : false;
 }
 
 void mod_freesync_handle_preflip(struct mod_freesync *mod_freesync,
-- 
2.34.1


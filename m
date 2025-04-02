Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FDECC28B20
	for <amd-gfx@archiver.kernel.org>; Wed,  2 Apr 2025 16:13:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76F0E10E835;
	Wed,  2 Apr 2025 16:13:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="5Fo0tdf1";
	dkim-atps=neutral
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2084.outbound.protection.outlook.com [40.107.95.84])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2359E10E82B
 for <amd-gfx@lists.freedesktop.org>; Wed,  2 Apr 2025 16:13:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M4CtblOpUxX2VYjePXpmIBEiES0DvFnkWjm4sfJhq415RPD76x4jnEht0zQFclBQ01pb56p3DlDkBKgUEaaHRa61nnFIWNV8oRy//Wm13qjxxVACYt6HYFM8FXNc0AyIVVwgty1uz23jUpikGmpnl9Tb6WQnvNdIyuvbngcYrMbScvZ7ccFyTOx0CIF//0eVHKLs7GKMJJb1blTYDbtUI3XNVZTx4JO30w8SnIpcM5XbTHj3BhsJ1MUHGQLGWxc9QkO69ajpSYz/ERPrd8zwCJ2raYhg+DllRq/T/tyU5wOHeoj/HAsULOcwvPF8YLvWL47ICFfEJqm/a3PTpQQE/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=llh3d+5QbRKYJOvbFWJ1vG1wzyXN+e87h9ollHk130o=;
 b=eit8Wv3GSaksl/v2XCe6LdDH4kI5TglfSPNzfQjqxnE7N9YkLt5jFnVyAYKb55j6Pm0CLGaZW/1LuvlesTpHpSPN2mbkq18QVvyJiRZZCFojMtpF0N+0v6D6jwtxy5YL3JZEN0xTu5wO8JPVx8rz+E/lVrlCMTkkem6MZzrocseU95IcaNr7Q2mhlnjsuM9/lp3zmvHu77b0okRQawkDqyc4Nc+CSRvaa5aNgT0CcXiV7eu+OM4SGJdLVc68lcIN1zSFWXgnkns2Cb7x+/rPcGeKzCtoa7M/oZi8xKTkpxjKAa721WJZqGC9nEfPjHHHKAvUXhL9wBH0mJZiGWxmvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=llh3d+5QbRKYJOvbFWJ1vG1wzyXN+e87h9ollHk130o=;
 b=5Fo0tdf1SLSnwh9NWhmaBIRBpVpL9JLi968kQl4Yn0nR7MdLMjffruC3i5X+DgrqEz4jO5IYk73Sfy/FAYvmhgXOnPSfHwxGQw2tuJPMYMJnwJAH7aLFv+xkwAwS6ngoBzkBhimBxE5RdAsvRygYpdz0RwcMdt1WLziUXKO0Gbw=
Received: from CH0PR03CA0401.namprd03.prod.outlook.com (2603:10b6:610:11b::35)
 by CH3PR12MB7545.namprd12.prod.outlook.com (2603:10b6:610:146::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.46; Wed, 2 Apr
 2025 16:13:44 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:11b:cafe::d6) by CH0PR03CA0401.outlook.office365.com
 (2603:10b6:610:11b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8606.24 via Frontend Transport; Wed,
 2 Apr 2025 16:13:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 16:13:44 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:43 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 2 Apr
 2025 11:13:43 -0500
Received: from roman-vdev.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 2 Apr 2025 11:13:42 -0500
From: <Roman.Li@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Aurabindo Pillai <aurabindo.pillai@amd.com>, Roman Li <roman.li@amd.com>,
 Wayne Lin <wayne.lin@amd.com>, Tom Chung <chiahsuan.chung@amd.com>, "Fangzhi
 Zuo" <jerry.zuo@amd.com>, Zaeem Mohamed <zaeem.mohamed@amd.com>, "Daniel
 Wheeler" <daniel.wheeler@amd.com>, Ausef Yousof <Ausef.Yousof@amd.com>, "Leo
 Chen" <leo.chen@amd.com>
Subject: [PATCH 09/16] drm/amd/display: wait for updates to latch before
 locking
Date: Wed, 2 Apr 2025 12:13:13 -0400
Message-ID: <20250402161320.983072-10-Roman.Li@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250402161320.983072-1-Roman.Li@amd.com>
References: <20250402161320.983072-1-Roman.Li@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: Roman.Li@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|CH3PR12MB7545:EE_
X-MS-Office365-Filtering-Correlation-Id: b1da0f5d-0025-4d01-1d1b-08dd72015741
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ahG+EVux3V2hdyI79+sE1fYRyHca9LAeRG79BixnYILi/rPsmxCrTCTJMr09?=
 =?us-ascii?Q?HgXXnE4CZfIfHQMqHC2XzBUE/YOg2sz3mm8/VEdeOSu/G+FKwJgx4OriPdZz?=
 =?us-ascii?Q?qlykrjhKWkGzXrRbQ33pd6BAmgBrTfsbjmT6Xa4zH5PqkV+1c4cjv2I108tf?=
 =?us-ascii?Q?sKG8hpEW8X7rw66AquS/wse/wsMMP84qLTDBYLWlthIajt5XXwnNfBAVoAqz?=
 =?us-ascii?Q?Sqy9F63/8Ik1y+bdQiCydmcMrSSmCSCFgAM2z0d3JYuWkqrnp7P1LClwgE2O?=
 =?us-ascii?Q?EYMNmAhWnjADR5KRnFKmvJUi3yM3wQXqTBINqG8+LMxWpHlgiFXBH6+nD48f?=
 =?us-ascii?Q?MyHzuX0W0YLWlUHxjchACLsx25TyRkEuOjo4bYP9FNAfLTHJpAwERpacwHyY?=
 =?us-ascii?Q?Kwq9PJVBvOyM3kfOcyYjiYqafjbGwYxyIGMy45YPkCF3s1Fm61iY9wLBr982?=
 =?us-ascii?Q?eYw7jned0CIZ7Ni15XLc/0DdxxoXz65PrXNnPMg+zhWd2YMoDKmXGvvcICvq?=
 =?us-ascii?Q?FNFXXK0u2g1TAYTh4Zq/XChmhWnt7Z3eTK+zjgJ+IjJgsL15o0Om2470ffVG?=
 =?us-ascii?Q?Cov5/zrrEZwEIa5H+Ao45Cv/sKu/Cwc/RRAKIeSrOVgFlQxDLyggh4VfWWDA?=
 =?us-ascii?Q?FKo2vGrVjjlE8sCC4OiF1rJzKO1E/MgqUP049QYPtAgrhDQQnn3/ZnnX4y3e?=
 =?us-ascii?Q?WXPVO6SZQT1uuU5d3RTl5No76pG0uDzCwDLOiGhip/0oKd9NIQnaoMFmyA3j?=
 =?us-ascii?Q?klijJosNn6id461h/BttZLTcyToOY3RhCoVukmf9b2t/nuzUchBlRF8UC6qH?=
 =?us-ascii?Q?mrU3F+C9Xo4ibVoXDaTdfBav76y5GytwQ+ayILVh7idIAa9xerq4O0BvsV2M?=
 =?us-ascii?Q?JwDpGh5r+Dh2c1IyUNsFpbeBgGjjXIE+GeGpp7m9wETSucSuIezP/2fog+bq?=
 =?us-ascii?Q?3NTOYWfE9R3nNatzr5DMQDnjpWuRjDOpAVbQ1+9vio7lDs3yS4Z3xrK+WcHT?=
 =?us-ascii?Q?PaUn7K6qURhclroUDdZB2/x9ZljUSXIZuyGimhXIm1m+LBRhf00BM2B19J6h?=
 =?us-ascii?Q?tTANJot62uJtHpd2w7f5ro9QpaZeLQEpmxR08fO4lT+rvqNhFCzusUuwt3Mp?=
 =?us-ascii?Q?rJtho2Jb+BwfcfL7MhtTx3By7v2+iGzX/MYZiCQzGyoJnqP535NoTBm9r0fg?=
 =?us-ascii?Q?vjwZPFNcxSneBiJgz+tvJlLmFx+s/3kR0nqqoJD8txX/166RQBlLFaAUOXP6?=
 =?us-ascii?Q?Badhd+b5sD1BQ6bETIk75j1FgdjXpDMFZqL54vb4VDgaNBVtxhvDkgrn7KaI?=
 =?us-ascii?Q?9h9CTUPQ3EDIZby+lMrh2VZ2ly0npYGNXbXsdOlHtqGEMBaYoExicBA0Xlyq?=
 =?us-ascii?Q?vnW2NcjlUJXYrp5wdtAGL8yUyxfPv67b5lOI0O+bnrKbsa8xn0J9h9zTWgjv?=
 =?us-ascii?Q?hEynX6+YPmLLRKTfxRQ6djn1FI/DfubjZ3Uiy14VjMjjGBNbRqPY3NbBU+dT?=
 =?us-ascii?Q?/q+XyO+8R90AvQo=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 16:13:44.0272 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1da0f5d-0025-4d01-1d1b-08dd72015741
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7545
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

From: Ausef Yousof <Ausef.Yousof@amd.com>

[why&how]
It is possible for an update to acquire otg lock and begin programming
while the previous update has not completed and its values have not
latched. The correct way to go about this is to wait until the vupdate
pulses so we can be sure that previous updates have latched and we can
continue with the current update pipe programming, otherwise during
consecutive full updates we will have corruption flash on the screen.

The corruption flash occurs specifically on configs that require odm
combine, and its local to a specific pipe (will not flash across whole
screen). This ticket is across the otg slave, but it may also appear
across master.

Reviewed-by: Leo Chen <leo.chen@amd.com>
Signed-off-by: Ausef Yousof <Ausef.Yousof@amd.com>
Signed-off-by: Roman Li <roman.li@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  34 +++++
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.c   | 122 ++++++++++++++++++
 .../amd/display/dc/hwss/dcn10/dcn10_hwseq.h   |   7 +
 .../amd/display/dc/hwss/dcn35/dcn35_init.c    |   2 +
 .../amd/display/dc/hwss/dcn351/dcn351_init.c  |   2 +
 .../display/dc/hwss/hw_sequencer_private.h    |   2 +
 .../gpu/drm/amd/display/dc/inc/core_types.h   |   4 +
 drivers/gpu/drm/amd/display/dc/inc/hw/optc.h  |   1 +
 .../amd/display/dc/optc/dcn35/dcn35_optc.c    |   1 +
 9 files changed, 175 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index be63cc4aca1f..636999fcaebb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2104,6 +2104,18 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		dc->hwss.enable_accelerated_mode(dc, context);
 	}
 
+	if (dc->hwseq->funcs.wait_for_pipe_update_if_needed) {
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			pipe = &context->res_ctx.pipe_ctx[i];
+			//Only delay otg master for a given config
+			if (resource_is_pipe_type(pipe, OTG_MASTER)) {
+				//dc_commit_state_no_check is always a full update
+				dc->hwseq->funcs.wait_for_pipe_update_if_needed(dc, pipe, false);
+				break;
+			}
+		}
+	}
+
 	if (context->stream_count > get_seamless_boot_stream_count(context) ||
 		context->stream_count == 0)
 		dc->hwss.prepare_bandwidth(dc, context);
@@ -2168,6 +2180,14 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	if (dc->hwss.program_front_end_for_ctx) {
 		dc->hwss.interdependent_update_lock(dc, context, true);
 		dc->hwss.program_front_end_for_ctx(dc, context);
+
+		if (dc->hwseq->funcs.set_wait_for_update_needed_for_pipe) {
+			for (i = 0; i < dc->res_pool->pipe_count; i++) {
+				pipe = &context->res_ctx.pipe_ctx[i];
+				dc->hwseq->funcs.set_wait_for_update_needed_for_pipe(dc, pipe);
+			}
+		}
+
 		dc->hwss.interdependent_update_lock(dc, context, false);
 		dc->hwss.post_unlock_program_front_end(dc, context);
 	}
@@ -4049,6 +4069,7 @@ static void commit_planes_for_stream(struct dc *dc,
 				&context->res_ctx,
 				stream);
 	ASSERT(top_pipe_to_program != NULL);
+
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
 
@@ -4099,6 +4120,9 @@ static void commit_planes_for_stream(struct dc *dc,
 		dc->hwss.wait_for_dcc_meta_propagation(dc, top_pipe_to_program);
 	}
 
+	if (dc->hwseq->funcs.wait_for_pipe_update_if_needed)
+		dc->hwseq->funcs.wait_for_pipe_update_if_needed(dc, top_pipe_to_program, update_type == UPDATE_TYPE_FAST);
+
 	if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
 		if (dc->hwss.subvp_pipe_control_lock)
 			dc->hwss.subvp_pipe_control_lock(dc, context, true, should_lock_all_pipes, NULL, subvp_prev_use);
@@ -4235,6 +4259,16 @@ static void commit_planes_for_stream(struct dc *dc,
 	}
 	if (dc->hwss.program_front_end_for_ctx && update_type != UPDATE_TYPE_FAST) {
 		dc->hwss.program_front_end_for_ctx(dc, context);
+
+		//Pipe busy until some frame and line #
+		if (dc->hwseq->funcs.set_wait_for_update_needed_for_pipe && update_type == UPDATE_TYPE_FULL) {
+			for (j = 0; j < dc->res_pool->pipe_count; j++) {
+				struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
+
+				dc->hwseq->funcs.set_wait_for_update_needed_for_pipe(dc, pipe_ctx);
+			}
+		}
+
 		if (dc->debug.validate_dml_output) {
 			for (i = 0; i < dc->res_pool->pipe_count; i++) {
 				struct pipe_ctx *cur_pipe = &context->res_ctx.pipe_ctx[i];
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
index e34a93b703a7..f9ee55998b6b 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.c
@@ -94,6 +94,128 @@ static void print_microsec(struct dc_context *dc_ctx,
 			us_x10 % frac);
 }
 
+/*
+ * Delay until we passed busy-until-point to which we can
+ * do necessary locking/programming on consecutive full updates
+ */
+void dcn10_wait_for_pipe_update_if_needed(struct dc *dc, struct pipe_ctx *pipe_ctx, bool is_surface_update_only)
+{
+	struct crtc_position position;
+	struct dc_stream_state *stream = pipe_ctx->stream;
+	unsigned int vpos, frame_count;
+	uint32_t vupdate_start, vupdate_end, vblank_start;
+	unsigned int lines_to_vupdate, us_to_vupdate;
+	unsigned int us_per_line, us_vupdate;
+
+	if (!pipe_ctx->stream ||
+		!pipe_ctx->stream_res.tg ||
+		!pipe_ctx->stream_res.stream_enc)
+		return;
+
+	if (pipe_ctx->prev_odm_pipe &&
+				pipe_ctx->stream)
+		return;
+
+	if (!pipe_ctx->wait_is_required)
+		return;
+
+	struct timing_generator *tg = pipe_ctx->stream_res.tg;
+
+	if (tg->funcs->is_tg_enabled && !tg->funcs->is_tg_enabled(tg))
+		return;
+
+	dc->hwss.calc_vupdate_position(dc, pipe_ctx, &vupdate_start,
+						&vupdate_end);
+
+	dc->hwss.get_position(&pipe_ctx, 1, &position);
+	vpos = position.vertical_count;
+
+	frame_count = tg->funcs->get_frame_count(tg);
+
+	if (frame_count - pipe_ctx->wait_frame_count > 2)
+		return;
+
+	vblank_start = pipe_ctx->pipe_dlg_param.vblank_start;
+
+	if (vpos >= vupdate_start && vupdate_start >= vblank_start)
+		lines_to_vupdate = stream->timing.v_total - vpos + vupdate_start;
+	else
+		lines_to_vupdate = vupdate_start - vpos;
+
+	us_per_line =
+		stream->timing.h_total * 10000u / stream->timing.pix_clk_100hz;
+	us_to_vupdate = lines_to_vupdate * us_per_line;
+
+	if (vupdate_end < vupdate_start)
+		vupdate_end += stream->timing.v_total;
+
+	if (lines_to_vupdate > stream->timing.v_total - vupdate_end + vupdate_start)
+		us_to_vupdate = 0;
+
+	us_vupdate = (vupdate_end - vupdate_start + 1) * us_per_line;
+
+	if (is_surface_update_only && us_to_vupdate + us_vupdate > 200) {
+		//surface updates come in at high irql
+		pipe_ctx->wait_is_required = true;
+		return;
+	}
+
+	fsleep(us_to_vupdate + us_vupdate);
+
+	//clear
+	pipe_ctx->next_vupdate = 0;
+	pipe_ctx->wait_frame_count = 0;
+	pipe_ctx->wait_is_required = false;
+}
+
+/*
+ * On pipe unlock and programming, indicate pipe will be busy
+ * until some frame and line (vupdate), this is required for consecutive
+ * full updates, need to wait for updates
+ * to latch to try and program the next update
+ */
+void dcn10_set_wait_for_update_needed_for_pipe(struct dc *dc, struct pipe_ctx *pipe_ctx)
+{
+	uint32_t vupdate_start, vupdate_end;
+	struct crtc_position position;
+	unsigned int vpos, cur_frame;
+
+	if (!pipe_ctx->stream ||
+		!pipe_ctx->stream_res.tg ||
+		!pipe_ctx->stream_res.stream_enc)
+		return;
+
+	dc->hwss.get_position(&pipe_ctx, 1, &position);
+	vpos = position.vertical_count;
+
+	dc->hwss.calc_vupdate_position(dc, pipe_ctx, &vupdate_start,
+						&vupdate_end);
+
+	struct timing_generator *tg = pipe_ctx->stream_res.tg;
+
+	struct optc *optc1 = DCN10TG_FROM_TG(tg);
+
+	ASSERT(optc1->max_frame_count != 0);
+
+	if (tg->funcs->is_tg_enabled && !tg->funcs->is_tg_enabled(tg))
+		return;
+
+	pipe_ctx->next_vupdate = vupdate_start;
+
+	cur_frame = tg->funcs->get_frame_count(tg);
+
+	if (vpos < vupdate_start) {
+		pipe_ctx->wait_frame_count = cur_frame;
+	} else {
+		if (cur_frame + 1 > optc1->max_frame_count)
+			pipe_ctx->wait_frame_count = cur_frame + 1 - optc1->max_frame_count;
+		else
+			pipe_ctx->wait_frame_count = cur_frame + 1;
+	}
+
+	pipe_ctx->wait_is_required = true;
+}
+
 void dcn10_lock_all_pipes(struct dc *dc,
 	struct dc_state *context,
 	bool lock)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
index 42ffd1e1299c..57d30ea225f2 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn10/dcn10_hwseq.h
@@ -50,6 +50,13 @@ void dcn10_optimize_bandwidth(
 void dcn10_prepare_bandwidth(
 		struct dc *dc,
 		struct dc_state *context);
+void dcn10_wait_for_pipe_update_if_needed(
+		struct dc *dc,
+		struct pipe_ctx *pipe_ctx,
+		bool is_surface_update_only);
+void dcn10_set_wait_for_update_needed_for_pipe(
+	struct dc *dc,
+	struct pipe_ctx *pipe_ctx);
 void dcn10_pipe_control_lock(
 	struct dc *dc,
 	struct pipe_ctx *pipe,
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
index 6a82a865209c..a3ccf805bd16 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn35/dcn35_init.c
@@ -168,6 +168,8 @@ static const struct hwseq_private_funcs dcn35_private_funcs = {
 	.dsc_pg_control = dcn35_dsc_pg_control,
 	.dsc_pg_status = dcn32_dsc_pg_status,
 	.enable_plane = dcn35_enable_plane,
+	.wait_for_pipe_update_if_needed = dcn10_wait_for_pipe_update_if_needed,
+	.set_wait_for_update_needed_for_pipe = dcn10_set_wait_for_update_needed_for_pipe,
 };
 
 void dcn35_hw_sequencer_construct(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
index 902a96940a01..a4e6b6479983 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn351/dcn351_init.c
@@ -162,6 +162,8 @@ static const struct hwseq_private_funcs dcn351_private_funcs = {
 	.dsc_pg_control = dcn35_dsc_pg_control,
 	.dsc_pg_status = dcn32_dsc_pg_status,
 	.enable_plane = dcn35_enable_plane,
+	.wait_for_pipe_update_if_needed = dcn10_wait_for_pipe_update_if_needed,
+	.set_wait_for_update_needed_for_pipe = dcn10_set_wait_for_update_needed_for_pipe,
 };
 
 void dcn351_hw_sequencer_construct(struct dc *dc)
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
index 22a5d4a03c98..09bc65c2fa23 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer_private.h
@@ -183,6 +183,8 @@ struct hwseq_private_funcs {
 			struct dc_cm2_func_luts mcm_luts,
 			bool lut_bank_a);
 	void (*perform_3dlut_wa_unlock)(struct pipe_ctx *pipe_ctx);
+	void (*wait_for_pipe_update_if_needed)(struct dc *dc, struct pipe_ctx *pipe_ctx, bool is_surface_update_only);
+	void (*set_wait_for_update_needed_for_pipe)(struct dc *dc, struct pipe_ctx *pipe_ctx);
 };
 
 struct dce_hwseq {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/core_types.h b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
index 338bc240e803..1ed3461440aa 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/core_types.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/core_types.h
@@ -480,6 +480,10 @@ struct pipe_ctx {
 	struct pixel_rate_divider pixel_rate_divider;
 	/* pixels borrowed from hblank to hactive */
 	uint8_t hblank_borrow;
+	/* next vupdate */
+	uint32_t next_vupdate;
+	uint32_t wait_frame_count;
+	bool wait_is_required;
 };
 
 /* Data used for dynamic link encoder assignment.
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h
index 7f371cbb35cd..0d5a8358a778 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/optc.h
@@ -68,6 +68,7 @@ struct optc {
 	int pstate_keepout;
 	struct dc_crtc_timing orginal_patched_timing;
 	enum signal_type signal;
+	uint32_t max_frame_count;
 };
 
 void optc1_read_otg_state(struct timing_generator *optc, struct dcn_otg_state *s);
diff --git a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
index b86fe2b094f8..4cfc6c0fa147 100644
--- a/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
+++ b/drivers/gpu/drm/amd/display/dc/optc/dcn35/dcn35_optc.c
@@ -507,6 +507,7 @@ void dcn35_timing_generator_init(struct optc *optc1)
 	optc1->min_v_blank_interlace = 5;
 	optc1->min_h_sync_width = 4;
 	optc1->min_v_sync_width = 1;
+	optc1->max_frame_count = 0xFFFFFF;
 
 	dcn35_timing_generator_set_fgcg(
 		optc1, CTX->dc->debug.enable_fine_grain_clock_gating.bits.optc);
-- 
2.34.1


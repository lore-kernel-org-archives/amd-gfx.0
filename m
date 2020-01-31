Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63F0EC2D0DB
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:17 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 337ED2082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="KWxLcymZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 337ED2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F6516FC3B;
	Fri, 31 Jan 2020 22:17:15 +0000 (UTC)
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
 (mail-eopbgr680059.outbound.protection.outlook.com [40.107.68.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 427736FC38
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBu9fFVoGiqiMa4V0LP7HDAc2rRVd2aH5ciJZQPf3UuQZO/Cm66ebCZqZn4C6vOuKrP7m+z+1Y09/Dccnlp2Dq5NGgTQqNt3Axi2iC7XqjxN9RW+m1xj+UEZ5noamF7beNOl672bOV6tI+SrSE+Bd64TPOPAyVNLwiSpmS7/xbc5xh8lXe93CTfyQa1I9F5R7kuC/lq9b4+6mvBka3oRBmNs1F/5tEAUPSw4fnaIUIg3dgkZlei19jmP4t5GSjYXOZfrMnUOKf1zmKYFBNLFqJYarmoLRH6uvGsLNNunbErUoNs25wHxH/SDQGNqS2szPxSOusKAXMYny3mByg4Xww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXHjn6rty6YLTVDqXFF0GKX0YmRKEGq2ZY7N0aj3hEM=;
 b=G/KDa5ZD8Gkp04X85xKFCrFeqVJZ6eBSDbTJmsGMpwzWAz+IPZdqvOIPArEFQHw6gVZJjiNnKn42CsxdgUMqEXQgNTR023kFTpWSJ4R6LVIHPT+WjHPv/ZuQ4RikuwWumJ0IEOVqLPuWj1WOssPW0d/Ttxur4GNq5/KRWxeUmRsjKqvDlJHJYN1qQaZ2/HNazxRZddNE06GggfwAJERZyFr1+dC4oayaebTP/NjkCgWNeUZCauOa9CP5sOT9z6kh0jnSe5isAE7uuR3mzPL5ccMiX3//FxSlwPI0RIJ1lXBNBw90oTQR0YMns9TpQwyg3EovhMAffZkb6GvdGL9qmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXHjn6rty6YLTVDqXFF0GKX0YmRKEGq2ZY7N0aj3hEM=;
 b=KWxLcymZ7ensmXLs3VdEab2kY2EmxZB0eKQMRMz8WfCY+r5wjQxOUVitcavpKBKquy3PdfLqi1SCP/Z5oTDxn9+BhbFDPm0Yk4AcmhoLOIPXvjT/QQnEHEIP9UkuNiSvWAoQu8U272ZKBk2OQGPMXvfqoE4tOtQjGOsMYobV+b4=
Received: from SN1PR12CA0098.namprd12.prod.outlook.com (2603:10b6:802:21::33)
 by MWHPR12MB1727.namprd12.prod.outlook.com (2603:10b6:300:107::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2665.20; Fri, 31 Jan
 2020 22:17:08 +0000
Received: from CO1NAM11FT067.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::204) by SN1PR12CA0098.outlook.office365.com
 (2603:10b6:802:21::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2644.23 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:08 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT067.mail.protection.outlook.com (10.13.174.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:07 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:03 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:02 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:02 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 06/33] drm/amd/display: Split program front end part that
 occur outside lock
Date: Fri, 31 Jan 2020 17:16:16 -0500
Message-ID: <20200131221643.10035-7-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(376002)(396003)(346002)(39860400002)(136003)(428003)(189003)(199004)(7696005)(2616005)(30864003)(2906002)(5660300002)(426003)(6916009)(1076003)(54906003)(478600001)(316002)(186003)(70206006)(70586007)(86362001)(36756003)(8676002)(26005)(336012)(6666004)(356004)(8936002)(81156014)(4326008)(81166006);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MWHPR12MB1727; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7d16d2aa-8ee7-47ff-457d-08d7a69b4f5a
X-MS-TrafficTypeDiagnostic: MWHPR12MB1727:
X-Microsoft-Antispam-PRVS: <MWHPR12MB172736A02CF4597AC537012AF9070@MWHPR12MB1727.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:669;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5wmSxA9PqnTjo9abfQcvSvwUytWRdLLZRjfFky8Q3WKMQtx0px1ftCh3shm5P05KHgB3ekWuv4IxK2GtIDPwf4WDVROmvoB2WSQMPiuHWpu/3dkqEfp/KGyjm4bjuxBKeCZR82ntRXrz386GryNHSBS7ABMftCxOMjvNMAMC+IcWeku2G5nRqXABxvyx1KJU6ZzbTf5gLY9cE6W10GaoLE7WNbw53VOBCgq/cK7Gm7XW8+C9GUrEoHeKuGKM+IHmy2Vs7xVmzo6iZdU2M7Xdcyi1sTY3yh8YTyYg8PtF/pxqxafbWNjhMGjwuLHsJDevCXq70YmHfelq+q7WIWkjWmBphuUdGF+t7d/QzNCwZMiItvmMguEIgl9oVhlpGWsHjNB8CZdTqB6PjIY1teknYO5uRfhQnEdxHgKo3Tc11LxdvnF3OjRR1914DPlKpmUE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:07.6051 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d16d2aa-8ee7-47ff-457d-08d7a69b4f5a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1727
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
Cc: sunpeng.li@amd.com, rodrigo.siqueira@amd.com, harry.wentland@amd.com,
 Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Why]
Eventually want to lock at a higher level in stack.
To do this, we need to be able to isolate the parts that need to be done
after pipe unlock.

[How]
Split out programming that is done post unlock.

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 24 +++++++++---
 .../display/dc/dce110/dce110_hw_sequencer.c   |  6 +++
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 39 ++++++++++++++++---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |  3 ++
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |  1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 11 +++++-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |  3 ++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  1 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  2 +
 10 files changed, 79 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 073172e53b5b..738ba91220df 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -786,11 +786,15 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 		if (should_disable && old_stream) {
 			dc_rem_all_planes_for_stream(dc, old_stream, dangling_context);
 			disable_all_writeback_pipes_for_stream(dc, old_stream, dangling_context);
-			if (dc->hwss.apply_ctx_for_surface)
+			if (dc->hwss.apply_ctx_for_surface) {
 				dc->hwss.apply_ctx_for_surface(dc, old_stream, 0, dangling_context);
+				dc->hwss.post_unlock_program_front_end(dc, dangling_context);
+			}
+			if (dc->hwss.program_front_end_for_ctx) {
+				dc->hwss.program_front_end_for_ctx(dc, dangling_context);
+				dc->hwss.post_unlock_program_front_end(dc, dangling_context);
+			}
 		}
-		if (dc->hwss.program_front_end_for_ctx)
-			dc->hwss.program_front_end_for_ctx(dc, dangling_context);
 	}
 
 	current_ctx = dc->current_state;
@@ -1219,6 +1223,7 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 				dc, context->streams[i],
 				context->stream_status[i].plane_count,
 				context); /* use new pipe config in new context */
+			dc->hwss.post_unlock_program_front_end(dc, context);
 		}
 
 	/* Program hardware */
@@ -1238,19 +1243,24 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	}
 
 	/* Program all planes within new context*/
-	if (dc->hwss.program_front_end_for_ctx)
+	if (dc->hwss.program_front_end_for_ctx) {
 		dc->hwss.program_front_end_for_ctx(dc, context);
+		dc->hwss.post_unlock_program_front_end(dc, context);
+	}
+
 	for (i = 0; i < context->stream_count; i++) {
 		const struct dc_link *link = context->streams[i]->link;
 
 		if (!context->streams[i]->mode_changed)
 			continue;
 
-		if (dc->hwss.apply_ctx_for_surface)
+		if (dc->hwss.apply_ctx_for_surface) {
 			dc->hwss.apply_ctx_for_surface(
 					dc, context->streams[i],
 					context->stream_status[i].plane_count,
 					context);
+			dc->hwss.post_unlock_program_front_end(dc, context);
+		}
 
 		/*
 		 * enable stereo
@@ -2183,6 +2193,7 @@ static void commit_planes_for_stream(struct dc *dc,
 		if (dc->hwss.program_front_end_for_ctx)
 			dc->hwss.program_front_end_for_ctx(dc, context);
 
+		dc->hwss.post_unlock_program_front_end(dc, context);
 		return;
 	}
 
@@ -2315,6 +2326,9 @@ static void commit_planes_for_stream(struct dc *dc,
 		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
 	}
 
+	if (update_type != UPDATE_TYPE_FAST)
+		dc->hwss.post_unlock_program_front_end(dc, context);
+
 	// Fire manual trigger only when bottom plane is flipped
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 5b689273ff44..a961b94aefd9 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -2621,6 +2621,11 @@ static void dce110_apply_ctx_for_surface(
 		enable_fbc(dc, context);
 }
 
+static void dce110_post_unlock_program_front_end(
+		struct dc *dc,
+		struct dc_state *context)
+{
+}
 static void dce110_power_down_fe(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
 	struct dce_hwseq *hws = dc->hwseq;
@@ -2722,6 +2727,7 @@ static const struct hw_sequencer_funcs dce110_funcs = {
 	.init_hw = init_hw,
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = dce110_apply_ctx_for_surface,
+	.post_unlock_program_front_end = dce110_post_unlock_program_front_end,
 	.update_plane_addr = update_plane_addr,
 	.update_pending_status = dce110_update_pending_status,
 	.enable_accelerated_mode = dce110_enable_accelerated_mode,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 1008ac8a0f2a..a9a5a13d5edf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2512,7 +2512,6 @@ void dcn10_apply_ctx_for_surface(
 	int i;
 	struct timing_generator *tg;
 	uint32_t underflow_check_delay_us;
-	bool removed_pipe[4] = { false };
 	bool interdependent_update = false;
 	struct pipe_ctx *top_pipe_to_program =
 			dcn10_find_top_pipe_for_stream(dc, context, stream);
@@ -2552,6 +2551,9 @@ void dcn10_apply_ctx_for_surface(
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
 		struct pipe_ctx *old_pipe_ctx =
 				&dc->current_state->res_ctx.pipe_ctx[i];
+
+		pipe_ctx->update_flags.raw = 0;
+
 		/*
 		 * Powergate reused pipes that are not powergated
 		 * fairly hacky right now, using opp_id as indicator
@@ -2571,7 +2573,7 @@ void dcn10_apply_ctx_for_surface(
 		    old_pipe_ctx->stream_res.tg == tg) {
 
 			hws->funcs.plane_atomic_disconnect(dc, old_pipe_ctx);
-			removed_pipe[i] = true;
+			pipe_ctx->update_flags.bits.disable = 1;
 
 			DC_LOG_DC("Reset mpcc for pipe %d\n",
 					old_pipe_ctx->pipe_idx);
@@ -2602,16 +2604,41 @@ void dcn10_apply_ctx_for_surface(
 		dcn10_lock_all_pipes(dc, context, false);
 	else
 		dcn10_pipe_control_lock(dc, top_pipe_to_program, false);
+}
+
+void dcn10_post_unlock_program_front_end(
+		struct dc *dc,
+		struct dc_state *context)
+{
+	int i, j;
+
+	DC_LOGGER_INIT(dc->ctx->logger);
 
-	if (num_planes == 0)
-		false_optc_underflow_wa(dc, stream, tg);
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe_ctx->top_pipe &&
+			!pipe_ctx->prev_odm_pipe &&
+			pipe_ctx->stream) {
+			struct dc_stream_status *stream_status = NULL;
+			struct timing_generator *tg = pipe_ctx->stream_res.tg;
+
+			for (j = 0; j < context->stream_count; j++) {
+				if (pipe_ctx->stream == context->streams[j])
+					stream_status = &context->stream_status[j];
+			}
+
+			if (context->stream_status[i].plane_count == 0)
+				false_optc_underflow_wa(dc, pipe_ctx->stream, tg);
+		}
+	}
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
-		if (removed_pipe[i])
+		if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable)
 			dc->hwss.disable_plane(dc, &dc->current_state->res_ctx.pipe_ctx[i]);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
-		if (removed_pipe[i]) {
+		if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable) {
 			dc->hwss.optimize_bandwidth(dc, context);
 			break;
 		}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
index 4d20f6586bb5..b523f0b8dc23 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
@@ -75,6 +75,9 @@ void dcn10_apply_ctx_for_surface(
 		const struct dc_stream_state *stream,
 		int num_planes,
 		struct dc_state *context);
+void dcn10_post_unlock_program_front_end(
+		struct dc *dc,
+		struct dc_state *context);
 void dcn10_hubp_pg_control(
 		struct dce_hwseq *hws,
 		unsigned int hubp_inst,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
index e7e5352ec424..681db997a532 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
@@ -32,6 +32,7 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.init_hw = dcn10_init_hw,
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = dcn10_apply_ctx_for_surface,
+	.post_unlock_program_front_end = dcn10_post_unlock_program_front_end,
 	.update_plane_addr = dcn10_update_plane_addr,
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index a444fed94184..f36c4d1b7c30 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1551,7 +1551,6 @@ void dcn20_program_front_end_for_ctx(
 		struct dc *dc,
 		struct dc_state *context)
 {
-	const unsigned int TIMEOUT_FOR_PIPE_ENABLE_MS = 100;
 	int i;
 	struct dce_hwseq *hws = dc->hwseq;
 	bool pipe_locked[MAX_PIPES] = {false};
@@ -1626,6 +1625,16 @@ void dcn20_program_front_end_for_ctx(
 			if (!pipe_ctx->update_flags.bits.enable)
 				dc->hwss.pipe_control_lock(dc, &dc->current_state->res_ctx.pipe_ctx[i], false);
 		}
+}
+
+void dcn20_post_unlock_program_front_end(
+		struct dc *dc,
+		struct dc_state *context)
+{
+	int i;
+	const unsigned int TIMEOUT_FOR_PIPE_ENABLE_MS = 100;
+
+	DC_LOGGER_INIT(dc->ctx->logger);
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
 		if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
index 02c9be5ebd47..80f192b8b3a2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
@@ -35,6 +35,9 @@ bool dcn20_set_shaper_3dlut(
 void dcn20_program_front_end_for_ctx(
 		struct dc *dc,
 		struct dc_state *context);
+void dcn20_post_unlock_program_front_end(
+		struct dc *dc,
+		struct dc_state *context);
 void dcn20_update_plane_addr(const struct dc *dc, struct pipe_ctx *pipe_ctx);
 void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx);
 bool dcn20_set_input_transfer_func(struct dc *dc, struct pipe_ctx *pipe_ctx,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index d51e02fdab4d..cb0cb999251e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -33,6 +33,7 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
+	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index 4861aa5c59ae..4963a540948d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -34,6 +34,7 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
+	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
 	.update_dchub = dcn10_update_dchub,
 	.update_pending_status = dcn10_update_pending_status,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 209118f9f193..63919866ba38 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -66,6 +66,8 @@ struct hw_sequencer_funcs {
 			int num_planes, struct dc_state *context);
 	void (*program_front_end_for_ctx)(struct dc *dc,
 			struct dc_state *context);
+	void (*post_unlock_program_front_end)(struct dc *dc,
+			struct dc_state *context);
 	void (*update_plane_addr)(const struct dc *dc,
 			struct pipe_ctx *pipe_ctx);
 	void (*update_dchub)(struct dce_hwseq *hws,
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <SRS0=EB5G=BJ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEDBFC433E0
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:45 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95B28206F5
	for <amd-gfx@archiver.kernel.org>; Thu, 30 Jul 2020 19:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="ZHVxoNXb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95B28206F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47F1C6E960;
	Thu, 30 Jul 2020 19:12:45 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770089.outbound.protection.outlook.com [40.107.77.89])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F3AFD6E95D
 for <amd-gfx@lists.freedesktop.org>; Thu, 30 Jul 2020 19:12:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NYBRUcZaejRGNj0s+H8nCB3RwTWdmbfrDa5HmbSgCPb4sD3HGaZa3dTgaa9irgDiYLLS6CQ+/nqFq4MKAocNO27+ojAKWva/R8oDXQBI7gkzmISMCojNbZyP2jrowHyo9UeaQ+lSvE2E9hM+KgDk1zngmF0QCzTmpGy+VR6Wc8zXrpJLmcnGDk3JrEO2Z/1KZFi6GuJQWLHG04qebD/QBwco8PODRbZYLFSLnMADRS2ZxMbopBnfSsgPvnWFIWWm05OtdC7SbUWc0kexQo3WdlgNZfYgb5NJ9no57quydBlfPW5DRDktT+TIsXXcBx1N2vUYoAEkXnydNZEsR+DrZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAt1W8RBP5/MIWOtAATVZsvHqflgqIDq4KnQ0oW7iY0=;
 b=EByFbx9axcejzFckCmwxNZgB1b/pP4CpUUN5kbwPXPjnoyjLENm2Xvz3tkCRgwai7eYPd/LVroLQX/NAnCWfyW7+Php8GNgbjkDl/oJ1q/nd6hrVKKe5SJNL4NZViyOBgtm4Q1FxE0xV/IKv3B+nJd/ZIAeO/cWTyLGDkYva6zfXV9bFL6EsmIpEvIsBuxnZ3952VE7hNbv04ix2xL6BXv8xeLkzCcy3viGrFLL22vAYaQudSqo0LLYkdGtixhZomDuQqlTVUBd7d8STfKZy9ZHGQN34oI0Dm0sEmWfQ+GOSv7LyP1pYyPdvTv4HZDVEtnYqegn7hck1JjHlEjPo7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AAt1W8RBP5/MIWOtAATVZsvHqflgqIDq4KnQ0oW7iY0=;
 b=ZHVxoNXbw1qZ8H65mYoBX0Zlq94s4yzZfyP5TaOR7xHVPOofmhYNifeWafUJoQR8M+zPUREfJaU1Tg7oPEEwkvIDqUGayzsaSUPbg9Z6XJxXbBavsonD5llyhwstaLIh3l7oD1drKnkLg1RLdf4yqSfkAr6MhDxBGSulBy7KbKk=
Received: from DM6PR17CA0026.namprd17.prod.outlook.com (2603:10b6:5:1b3::39)
 by BN8PR12MB3347.namprd12.prod.outlook.com (2603:10b6:408:43::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.16; Thu, 30 Jul
 2020 19:12:37 +0000
Received: from DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:1b3:cafe::67) by DM6PR17CA0026.outlook.office365.com
 (2603:10b6:5:1b3::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.17 via Frontend
 Transport; Thu, 30 Jul 2020 19:12:37 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT032.mail.protection.outlook.com (10.13.173.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3239.20 via Frontend Transport; Thu, 30 Jul 2020 19:12:36 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:35 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Thu, 30 Jul
 2020 14:12:35 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Thu, 30 Jul 2020 14:12:34 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 14/16] drm/amd/display: Separate pipe disconnect from rest of
 progrmaming
Date: Thu, 30 Jul 2020 15:11:44 -0400
Message-ID: <20200730191146.33112-15-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200730191146.33112-1-aurabindo.pillai@amd.com>
References: <20200730191146.33112-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dbf3f43f-b4bf-4fc7-048c-08d834bc8533
X-MS-TrafficTypeDiagnostic: BN8PR12MB3347:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN8PR12MB3347F37150B1DB1A283F0BCD8B710@BN8PR12MB3347.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:962;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: v1wH5Ayl9yO65pQMzZkO+LOvyDMvQdEEUlGtwY6QmQfwTigwFS515M00d7pH3MLsEpjJyetsQ4xD15c0B3SCfgrXsL8PshULGFPqM6P1GF/I9avNjbapjfa424b41bFrG2qczEc/W+QQu4C8G2i33/dQCrVGf6hcOLedQs+pIACYxQVZwQROVfdt3Hez45Qgc9ZlwQJyIevbblIK+INd6OFXYsw+UmxUiJ+RN9Pp56w65WVO5IWj3yrvuqWGwKsihd9rhRvsXSJxnqwaMVVXj1/CXHqACI/7O9SL099pTZYMaA7acvzEjiT5MzU+awV2VdEamlNw+oYZ5E5wc6NB5KFvGh33DqUT5WPicR9cZ73n+LiDra8mkDJ4SeRaAVLcEHYSCdyxLGfu8UNH9ADcdg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(346002)(39860400002)(136003)(46966005)(82310400002)(356005)(82740400003)(81166007)(44832011)(36756003)(86362001)(8676002)(426003)(47076004)(6916009)(8936002)(70586007)(2906002)(336012)(70206006)(2616005)(83380400001)(30864003)(1076003)(7696005)(186003)(6666004)(4326008)(5660300002)(54906003)(316002)(478600001)(26005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2020 19:12:36.5294 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dbf3f43f-b4bf-4fc7-048c-08d834bc8533
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT032.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3347
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
Cc: Eryk.Brol@amd.com, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Alvin Lee <alvin.lee2@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <alvin.lee2@amd.com>

[Why]
When changing pixel formats for HDR (e.g. ARGB -> FP16)
there are configurations that change from 2 pipes to 1 pipe.
In these cases, it seems that disconnecting MPCC and doing
a surface update at the same time(after unlocking) causes
some registers to be updated slightly faster than others
after unlocking (e.g. if the pixel format is updated to FP16
before the new surface address is programmed, we get
corruption on the screen because the pixel formats aren't
matching). We separate disconnecting MPCC from the rest
of  the  pipe programming sequence to prevent this.

[How]
Move MPCC disconnect into separate operation than the
rest of the pipe programming.

Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  10 ++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 114 ++++++++++++++++++
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |   7 ++
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   2 +
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   2 +
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |   2 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   4 +
 7 files changed, 141 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 5aa3b89471c3..ebbb8182228d 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2300,6 +2300,7 @@ static void commit_planes_for_stream(struct dc *dc,
 		enum surface_update_type update_type,
 		struct dc_state *context)
 {
+	bool mpcc_disconnected = false;
 	int i, j;
 	struct pipe_ctx *top_pipe_to_program = NULL;
 
@@ -2330,6 +2331,15 @@ static void commit_planes_for_stream(struct dc *dc,
 		context_clock_trace(dc, context);
 	}
 
+	if (update_type != UPDATE_TYPE_FAST && dc->hwss.interdependent_update_lock &&
+		dc->hwss.disconnect_pipes && dc->hwss.wait_for_pending_cleared){
+		dc->hwss.interdependent_update_lock(dc, context, true);
+		mpcc_disconnected = dc->hwss.disconnect_pipes(dc, context);
+		dc->hwss.interdependent_update_lock(dc, context, false);
+		if (mpcc_disconnected)
+			dc->hwss.wait_for_pending_cleared(dc, context);
+	}
+
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 66180b4332f1..73eb4e76a0b1 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1624,6 +1624,120 @@ static void dcn20_program_pipe(
 	}
 }
 
+bool dcn20_disconnect_pipes(
+		struct dc *dc,
+		struct dc_state *context)
+{
+		int i;
+		struct dce_hwseq *hws = dc->hwseq;
+		bool mpcc_disconnected = false;
+		DC_LOGGER_INIT(dc->ctx->logger);
+
+		/* Set pipe update flags and lock pipes */
+		for (i = 0; i < dc->res_pool->pipe_count; i++)
+			dcn20_detect_pipe_changes(&dc->current_state->res_ctx.pipe_ctx[i],
+					&context->res_ctx.pipe_ctx[i]);
+
+		if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
+			/* OTG blank before disabling all front ends */
+			for (i = 0; i < dc->res_pool->pipe_count; i++) {
+				if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable
+					&& !context->res_ctx.pipe_ctx[i].top_pipe
+					&& !context->res_ctx.pipe_ctx[i].prev_odm_pipe
+					&& context->res_ctx.pipe_ctx[i].stream) {
+					hws->funcs.blank_pixel_data(dc, &context->res_ctx.pipe_ctx[i], true);
+				}
+			}
+
+			/* Disconnect mpcc */
+			for (i = 0; i < dc->res_pool->pipe_count; i++) {
+				if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable) {
+					hws->funcs.plane_atomic_disconnect(dc, &dc->current_state->res_ctx.pipe_ctx[i]);
+					DC_LOG_DC("Reset mpcc for pipe %d\n", dc->current_state->res_ctx.pipe_ctx[i].pipe_idx);
+					mpcc_disconnected = true;
+				}
+			}
+		}
+
+		if (mpcc_disconnected) {
+			for (i = 0; i < dc->res_pool->pipe_count; i++) {
+				struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+				struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+				struct dc_plane_state *plane_state = pipe_ctx->plane_state;
+				struct hubp *hubp = pipe_ctx->plane_res.hubp;
+
+				if (!pipe_ctx || !plane_state || !pipe_ctx->stream)
+					continue;
+
+			// Only update scaler and viewport here if we lose a pipe split.
+			// This is to prevent half the screen from being black when we
+			// unlock after disconnecting MPCC.
+			if (!(old_pipe && !pipe_ctx->top_pipe &&
+				!pipe_ctx->bottom_pipe && old_pipe->bottom_pipe))
+				continue;
+
+			if (pipe_ctx->update_flags.raw || pipe_ctx->plane_state->update_flags.raw || pipe_ctx->stream->update_flags.raw) {
+				if (pipe_ctx->update_flags.bits.scaler ||
+					plane_state->update_flags.bits.scaling_change ||
+					plane_state->update_flags.bits.position_change ||
+					plane_state->update_flags.bits.per_pixel_alpha_change ||
+					pipe_ctx->stream->update_flags.bits.scaling) {
+
+					pipe_ctx->plane_res.scl_data.lb_params.alpha_en = pipe_ctx->plane_state->per_pixel_alpha;
+					ASSERT(pipe_ctx->plane_res.scl_data.lb_params.depth == LB_PIXEL_DEPTH_30BPP);
+					/* scaler configuration */
+					pipe_ctx->plane_res.dpp->funcs->dpp_set_scaler(
+					pipe_ctx->plane_res.dpp, &pipe_ctx->plane_res.scl_data);
+				}
+
+				if (pipe_ctx->update_flags.bits.viewport ||
+					(context == dc->current_state && plane_state->update_flags.bits.position_change) ||
+					(context == dc->current_state && plane_state->update_flags.bits.scaling_change) ||
+					(context == dc->current_state && pipe_ctx->stream->update_flags.bits.scaling)) {
+
+					hubp->funcs->mem_program_viewport(
+						hubp,
+						&pipe_ctx->plane_res.scl_data.viewport,
+						&pipe_ctx->plane_res.scl_data.viewport_c);
+				}
+			}
+		}
+	}
+	return mpcc_disconnected;
+}
+
+void dcn20_wait_for_pending_cleared(struct dc *dc,
+		struct dc_state *context)
+{
+		struct pipe_ctx *pipe_ctx;
+		struct timing_generator *tg;
+		int i;
+
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			pipe_ctx = &context->res_ctx.pipe_ctx[i];
+			tg = pipe_ctx->stream_res.tg;
+
+			/*
+			 * Only wait for top pipe's tg penindg bit
+			 * Also skip if pipe is disabled.
+			 */
+			if (pipe_ctx->top_pipe ||
+			    !pipe_ctx->stream || !pipe_ctx->plane_state ||
+			    !tg->funcs->is_tg_enabled(tg))
+				continue;
+
+			/*
+			 * Wait for VBLANK then VACTIVE to ensure we get VUPDATE.
+			 * For some reason waiting for OTG_UPDATE_PENDING cleared
+			 * seems to not trigger the update right away, and if we
+			 * lock again before VUPDATE then we don't get a separated
+			 * operation.
+			 */
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VBLANK);
+			pipe_ctx->stream_res.tg->funcs->wait_for_state(pipe_ctx->stream_res.tg, CRTC_STATE_VACTIVE);
+		}
+}
+
 void dcn20_program_front_end_for_ctx(
 		struct dc *dc,
 		struct dc_state *context)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
index 83220e34c1a9..7befd35a2359 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
@@ -131,6 +131,13 @@ void dcn20_dccg_init(struct dce_hwseq *hws);
 int dcn20_init_sys_ctx(struct dce_hwseq *hws,
 		struct dc *dc,
 		struct dc_phy_addr_space_config *pa_config);
+bool dcn20_disconnect_pipes(
+		struct dc *dc,
+		struct dc_state *context);
+
+void dcn20_wait_for_pending_cleared(struct dc *dc,
+		struct dc_state *context);
+                
 
 #ifndef TRIM_FSFT
 bool dcn20_optimize_timing_for_fsft(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index 3dde6f26de47..55afb70d33e5 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -34,6 +34,8 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
+	.disconnect_pipes = dcn20_disconnect_pipes,
+	.wait_for_pending_cleared = dcn20_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
 	.update_dchub = dcn10_update_dchub,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index b187f71afa65..264302b27d4f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -35,6 +35,8 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
+	.disconnect_pipes = dcn20_disconnect_pipes,
+	.wait_for_pending_cleared = dcn20_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
 	.update_dchub = dcn10_update_dchub,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index 9afee7160490..845aaf1c816c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -35,6 +35,8 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
 	.apply_ctx_for_surface = NULL,
 	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
+	.disconnect_pipes = dcn20_disconnect_pipes,
+	.wait_for_pending_cleared = dcn20_wait_for_pending_cleared,
 	.post_unlock_program_front_end = dcn20_post_unlock_program_front_end,
 	.update_plane_addr = dcn20_update_plane_addr,
 	.update_dchub = dcn10_update_dchub,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 3c986717dcd5..64c1be818b0e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -67,6 +67,10 @@ struct hw_sequencer_funcs {
 			int num_planes, struct dc_state *context);
 	void (*program_front_end_for_ctx)(struct dc *dc,
 			struct dc_state *context);
+	bool (*disconnect_pipes)(struct dc *dc,
+			struct dc_state *context);
+	void (*wait_for_pending_cleared)(struct dc *dc,
+			struct dc_state *context);
 	void (*post_unlock_program_front_end)(struct dc *dc,
 			struct dc_state *context);
 	void (*update_plane_addr)(const struct dc *dc,
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

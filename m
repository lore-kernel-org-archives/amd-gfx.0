Return-Path: <SRS0=AA3p=DL=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD407C4363D
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:19:10 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58662206B6
	for <amd-gfx@archiver.kernel.org>; Sun,  4 Oct 2020 17:19:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="T+3gRntv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58662206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB4F189E26;
	Sun,  4 Oct 2020 17:19:09 +0000 (UTC)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770057.outbound.protection.outlook.com [40.107.77.57])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CA4889E26
 for <amd-gfx@lists.freedesktop.org>; Sun,  4 Oct 2020 17:19:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M8yfT1iSBD0hQubzkrCdZkOmwmSlAa1jtYibPWorLGq/Rh/bOSBSN6AJ4NU9UgNb8BFB3AgSZuv1rOj3PG6nCyzhlSuzDRvUg6YXDJrAZrGS2JkUlffa2mXu9LlwvLPO7wsNC6flkYBIqBS4wuGXehXXZgQsqSw7uyalvkhaiom9P4vVOVcLGL8BzJfERf1nKFou8kS5u6bx9OJPKCG2fnd8vzbSXJxkjYsQFXZFAJysGY4oWZ1sCPD3EeEbir0isfpsArVukhp9hT4jXRQf7TuJiO8JzMfLO3MpkLXnJb4ewZ5UGxmxS8o7/gU5wUMA4BZCtv/kme9A12ponwovgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+2uZGluTxshvAD8yub1BtQWi2+7WgoGa0aSePI+GGM=;
 b=F49DMdMHjZ0YH4jbi3Xm5T1tudu1NTSUgx0Ya0TzhAz1XY6yx4Nu4Op+P53nR5ijVhtdi71GJB0xIzV8ZJ72fpq2Lon55d59TBD2Lo10yziFbQRJlmCn8D/F/YujCaZZo2yNhQS8aWcIKrpr6iPQrpjZhcOVntK3MdPMrL4sqDQABlQbVK8HbILqgWKhPdfmPCw8GF4fxMCEl205HqtGma03YwWpueU/2LG5x+xL5ThRJikttQFBeubRJZdFddHST55VlZVzyIF6GhmojQSytUGjOMjQYQ4qWYEKL+yTD9tE58/rDIwdCEK+AWDKk/rtYGGE1vtTcIAig5CFfSFR4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E+2uZGluTxshvAD8yub1BtQWi2+7WgoGa0aSePI+GGM=;
 b=T+3gRntveTyonZQY5dCCoJ5XDaOptI07puY+DmsPirryUU0WHk0XW//K6ZXYSwR+GWcZcCTQjxcZFjuqu9RzXYng/6JGldGLumz317Sj85Z3sM0j1BhgsUt5Rp1/uCAQ9d1uDXMIZ9ZB/H3U0kQwCFUfCwYiDc5Nuiwz1/ObLl0=
Received: from DM5PR19CA0051.namprd19.prod.outlook.com (2603:10b6:3:116::13)
 by CH2PR12MB4053.namprd12.prod.outlook.com (2603:10b6:610:7c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37; Sun, 4 Oct
 2020 17:19:06 +0000
Received: from DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:116:cafe::3f) by DM5PR19CA0051.outlook.office365.com
 (2603:10b6:3:116::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.37 via Frontend
 Transport; Sun, 4 Oct 2020 17:19:06 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT055.mail.protection.outlook.com (10.13.173.103) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3433.35 via Frontend Transport; Sun, 4 Oct 2020 17:19:06 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:19:05 -0500
Received: from SATLEXMB01.amd.com (10.181.40.142) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Sun, 4 Oct 2020
 12:19:05 -0500
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Sun, 4 Oct 2020 12:18:54 -0500
From: Eryk Brol <eryk.brol@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 03/18] drm/amd/display: Check for flip pending before locking
 pipes
Date: Sun, 4 Oct 2020 13:17:58 -0400
Message-ID: <20201004171813.7819-4-eryk.brol@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201004171813.7819-1-eryk.brol@amd.com>
References: <20201004171813.7819-1-eryk.brol@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f9d17e84-2d3b-4cf0-e9c7-08d86889994d
X-MS-TrafficTypeDiagnostic: CH2PR12MB4053:
X-Microsoft-Antispam-PRVS: <CH2PR12MB4053F810F9991DC226CB4EA0E50F0@CH2PR12MB4053.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1169;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0NwwTGdIrWxhLhpBin8ea3/9eBt0wbysvuebbakni7OqO4BZqoNR51MUtG59wXX3qVi741VTTh5kjIlYy7XFAH8LGD+eKV2BRbzx248HN2flLetsqWeUDbaKb26NFghkYH8SzmtHmbd1ylM28r+5/lvd2oJ3lMbVyjDY4JL9ftXbpxmg0yBte2DVef8Og07XISe/gA+G38Ugw7BUr17qce33/ovsAGaEaLf/5AtTIAdV8DNKHnTjccItBWmE8vIJoma6dvAqSv+7mee06pvkyQqf6cV9B9ktU9Qie2/T4scW1AWmmGdav74ERhSiFLvKinoIj58qlJwjQUP8UFSzex7fBuFb6p4K+0lRFld5SzBbQtUvJXNhbRqX7JnZU/dXx+NwQRlOuDSqJODoKIXY5Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(376002)(396003)(39850400004)(346002)(136003)(46966005)(82310400003)(186003)(6916009)(1076003)(82740400003)(36756003)(86362001)(47076004)(54906003)(4326008)(26005)(5660300002)(336012)(30864003)(44832011)(426003)(8676002)(316002)(2906002)(8936002)(83380400001)(356005)(70586007)(478600001)(70206006)(81166007)(2616005);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2020 17:19:06.3834 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9d17e84-2d3b-4cf0-e9c7-08d86889994d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT055.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4053
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
Cc: Isabel Zhang <isabel.zhang@amd.com>, Aric Cyr <Aric.Cyr@amd.com>,
 Eryk Brol <eryk.brol@amd.com>, Sunpeng.Li@amd.com, Harry.Wentland@amd.com,
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Aurabindo.Pillai@amd.com,
 Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[Why]
When running games or benchmarking with v-sync disabled, disabling
a plane (which is v-sync) can cause underflow. This is caused by
flips pending before pipe locking being applied after locks are
released and pipes could have been re-arranged or disconnected. This
could potentially apply a flip on incorrect pipe. Also, previous logic
of always locking pipes was unnecessary.

[How]
Only lock the pipes when there is a pipe being disabled to increase
efficiency. Before the pipes are locked, check that any pending flips
are cleared to ensure the flips are applied to the correct pipe.

Signed-off-by: Isabel Zhang <isabel.zhang@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Eryk Brol <eryk.brol@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  11 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 156 ++++++++++--------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   2 +-
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   2 +-
 4 files changed, 88 insertions(+), 83 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 2a725a5fba40..014d7571474e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2383,7 +2383,6 @@ static void commit_planes_for_stream(struct dc *dc,
 		enum surface_update_type update_type,
 		struct dc_state *context)
 {
-	bool mpcc_disconnected = false;
 	int i, j;
 	struct pipe_ctx *top_pipe_to_program = NULL;
 
@@ -2414,14 +2413,8 @@ static void commit_planes_for_stream(struct dc *dc,
 		context_clock_trace(dc, context);
 	}
 
-	if (update_type != UPDATE_TYPE_FAST && dc->hwss.interdependent_update_lock &&
-		dc->hwss.disconnect_pipes && dc->hwss.wait_for_pending_cleared){
-		dc->hwss.interdependent_update_lock(dc, context, true);
-		mpcc_disconnected = dc->hwss.disconnect_pipes(dc, context);
-		dc->hwss.interdependent_update_lock(dc, context, false);
-		if (mpcc_disconnected)
-			dc->hwss.wait_for_pending_cleared(dc, context);
-	}
+	if (update_type != UPDATE_TYPE_FAST && dc->hwss.interdependent_update_lock && dc->hwss.wait_for_pending_cleared)
+		dc->hwss.disconnect_pipes(dc, context);
 
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index d0f3bf953d02..256185a22800 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2761,120 +2761,132 @@ static struct pipe_ctx *dcn10_find_top_pipe_for_stream(
 	return NULL;
 }
 
-bool dcn10_disconnect_pipes(
+void dcn10_disconnect_pipes(
 		struct dc *dc,
 		struct dc_state *context)
 {
-		bool found_pipe = false;
-		int i, j;
-		struct dce_hwseq *hws = dc->hwseq;
-		struct dc_state *old_ctx = dc->current_state;
-		bool mpcc_disconnected = false;
-		struct pipe_ctx *old_pipe;
-		struct pipe_ctx *new_pipe;
-		DC_LOGGER_INIT(dc->ctx->logger);
+	bool disconnect_pipes[MAX_PIPES] = {0};
+	bool found_pipe = false;
+	int i, j;
+	struct dce_hwseq *hws = dc->hwseq;
+	struct dc_state *old_ctx = dc->current_state;
+	bool plane_disabled = false;
+	struct pipe_ctx *old_pipe;
+	struct pipe_ctx *new_pipe;
 
-		/* Set pipe update flags and lock pipes */
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
-			new_pipe = &context->res_ctx.pipe_ctx[i];
-			new_pipe->update_flags.raw = 0;
+	DC_LOGGER_INIT(dc->ctx->logger);
 
-			if (!old_pipe->plane_state && !new_pipe->plane_state)
-				continue;
+	/* Set pipe update flags and lock pipes */
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+		new_pipe = &context->res_ctx.pipe_ctx[i];
+		new_pipe->update_flags.raw = 0;
+
+		if (!old_pipe->plane_state && !new_pipe->plane_state)
+			continue;
 
-			if (old_pipe->plane_state && !new_pipe->plane_state)
-				new_pipe->update_flags.bits.disable = 1;
+		if (old_pipe->plane_state && !new_pipe->plane_state)
+			new_pipe->update_flags.bits.disable = 1;
 
-			/* Check for scl update */
-			if (memcmp(&old_pipe->plane_res.scl_data, &new_pipe->plane_res.scl_data, sizeof(struct scaler_data)))
-					new_pipe->update_flags.bits.scaler = 1;
+		/* Check for scl update */
+		if (memcmp(&old_pipe->plane_res.scl_data, &new_pipe->plane_res.scl_data, sizeof(struct scaler_data)))
+			new_pipe->update_flags.bits.scaler = 1;
 
-			/* Check for vp update */
-			if (memcmp(&old_pipe->plane_res.scl_data.viewport, &new_pipe->plane_res.scl_data.viewport, sizeof(struct rect))
-					|| memcmp(&old_pipe->plane_res.scl_data.viewport_c,
+		/* Check for vp update */
+		if (memcmp(&old_pipe->plane_res.scl_data.viewport, &new_pipe->plane_res.scl_data.viewport, sizeof(struct rect))
+				|| memcmp(&old_pipe->plane_res.scl_data.viewport_c,
 						&new_pipe->plane_res.scl_data.viewport_c, sizeof(struct rect)))
-				new_pipe->update_flags.bits.viewport = 1;
+			new_pipe->update_flags.bits.viewport = 1;
 
-		}
+	}
 
-		if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
-			/* Disconnect mpcc here only if losing pipe split*/
-			for (i = 0; i < dc->res_pool->pipe_count; i++) {
-				if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable &&
+	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
+		/* Disconnect mpcc here only if losing pipe split*/
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable &&
 					old_ctx->res_ctx.pipe_ctx[i].top_pipe) {
 
-					/* Find the top pipe in the new ctx for the bottom pipe that we
-					 * want to remove by comparing the streams and planes. If both
-					 * pipes are being disabled then do it in the regular pipe
-					 * programming sequence
-					 */
-					for (j = 0; j < dc->res_pool->pipe_count; j++) {
-						if (old_ctx->res_ctx.pipe_ctx[i].top_pipe->stream == context->res_ctx.pipe_ctx[j].stream &&
+				/* Find the top pipe in the new ctx for the bottom pipe that we
+				 * want to remove by comparing the streams and planes. If both
+				 * pipes are being disabled then do it in the regular pipe
+				 * programming sequence
+				 */
+				for (j = 0; j < dc->res_pool->pipe_count; j++) {
+					if (old_ctx->res_ctx.pipe_ctx[i].top_pipe->stream == context->res_ctx.pipe_ctx[j].stream &&
 							old_ctx->res_ctx.pipe_ctx[i].top_pipe->plane_state == context->res_ctx.pipe_ctx[j].plane_state &&
 							!context->res_ctx.pipe_ctx[j].top_pipe &&
 							!context->res_ctx.pipe_ctx[j].update_flags.bits.disable) {
-							found_pipe = true;
-							break;
-						}
+						found_pipe = true;
+						break;
 					}
+				}
 
-					// Disconnect if the top pipe lost it's pipe split
-					if (found_pipe && !context->res_ctx.pipe_ctx[j].bottom_pipe) {
-						hws->funcs.plane_atomic_disconnect(dc, &dc->current_state->res_ctx.pipe_ctx[i]);
-						DC_LOG_DC("Reset mpcc for pipe %d\n", dc->current_state->res_ctx.pipe_ctx[i].pipe_idx);
-						mpcc_disconnected = true;
-					}
+				plane_disabled = true;
+
+				// Disconnect if the top pipe lost it's pipe split
+				if (found_pipe && !context->res_ctx.pipe_ctx[j].bottom_pipe) {
+					disconnect_pipes[i] = true;
 				}
-				found_pipe = false;
 			}
+			found_pipe = false;
 		}
+	}
 
-		if (mpcc_disconnected) {
-			for (i = 0; i < dc->res_pool->pipe_count; i++) {
-				struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-				struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
-				struct dc_plane_state *plane_state = pipe_ctx->plane_state;
-				struct hubp *hubp = pipe_ctx->plane_res.hubp;
+	if (plane_disabled) {
+		dc->hwss.wait_for_pending_cleared(dc, context);
+		dc->hwss.interdependent_update_lock(dc, context, true);
+
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+			struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+			struct dc_plane_state *plane_state = pipe_ctx->plane_state;
+			struct hubp *hubp = pipe_ctx->plane_res.hubp;
+
+			if (!pipe_ctx || !plane_state || !pipe_ctx->stream)
+				continue;
 
-				if (!pipe_ctx || !plane_state || !pipe_ctx->stream)
-					continue;
+			if (disconnect_pipes[i]) {
+				hws->funcs.plane_atomic_disconnect(dc, &dc->current_state->res_ctx.pipe_ctx[i]);
+				DC_LOG_DC("Reset mpcc for pipe %d\n", dc->current_state->res_ctx.pipe_ctx[i].pipe_idx);
+			}
 
-				// Only update scaler and viewport here if we lose a pipe split.
-				// This is to prevent half the screen from being black when we
-				// unlock after disconnecting MPCC.
-				if (!(old_pipe && !pipe_ctx->top_pipe &&
+			// Only update scaler and viewport here if we lose a pipe split.
+			// This is to prevent half the screen from being black when we
+			// unlock after disconnecting MPCC.
+			if (!(old_pipe && !pipe_ctx->top_pipe &&
 					!pipe_ctx->bottom_pipe && old_pipe->bottom_pipe))
-					continue;
+				continue;
 
-				if (pipe_ctx->update_flags.raw || pipe_ctx->plane_state->update_flags.raw || pipe_ctx->stream->update_flags.raw) {
-					if (pipe_ctx->update_flags.bits.scaler ||
+			if (pipe_ctx->update_flags.raw || pipe_ctx->plane_state->update_flags.raw || pipe_ctx->stream->update_flags.raw) {
+				if (pipe_ctx->update_flags.bits.scaler ||
 						plane_state->update_flags.bits.scaling_change ||
 						plane_state->update_flags.bits.position_change ||
 						plane_state->update_flags.bits.per_pixel_alpha_change ||
 						pipe_ctx->stream->update_flags.bits.scaling) {
 
-						pipe_ctx->plane_res.scl_data.lb_params.alpha_en = pipe_ctx->plane_state->per_pixel_alpha;
-						ASSERT(pipe_ctx->plane_res.scl_data.lb_params.depth == LB_PIXEL_DEPTH_30BPP);
-						/* scaler configuration */
-						pipe_ctx->plane_res.dpp->funcs->dpp_set_scaler(
-						pipe_ctx->plane_res.dpp, &pipe_ctx->plane_res.scl_data);
-					}
+					pipe_ctx->plane_res.scl_data.lb_params.alpha_en = pipe_ctx->plane_state->per_pixel_alpha;
+					ASSERT(pipe_ctx->plane_res.scl_data.lb_params.depth == LB_PIXEL_DEPTH_30BPP);
+					/* scaler configuration */
+					pipe_ctx->plane_res.dpp->funcs->dpp_set_scaler(
+							pipe_ctx->plane_res.dpp, &pipe_ctx->plane_res.scl_data);
+				}
 
-					if (pipe_ctx->update_flags.bits.viewport ||
+				if (pipe_ctx->update_flags.bits.viewport ||
 						(context == dc->current_state && plane_state->update_flags.bits.position_change) ||
 						(context == dc->current_state && plane_state->update_flags.bits.scaling_change) ||
 						(context == dc->current_state && pipe_ctx->stream->update_flags.bits.scaling)) {
 
-						hubp->funcs->mem_program_viewport(
+					hubp->funcs->mem_program_viewport(
 							hubp,
 							&pipe_ctx->plane_res.scl_data.viewport,
 							&pipe_ctx->plane_res.scl_data.viewport_c);
-					}
 				}
 			}
 		}
-	return mpcc_disconnected;
+
+		dc->hwss.interdependent_update_lock(dc, context, false);
+		dc->hwss.wait_for_pending_cleared(dc, context);
+	}
 }
 
 void dcn10_wait_for_pending_cleared(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
index e5691e499023..9a0f7a8a85cd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
@@ -194,7 +194,7 @@ void dcn10_get_surface_visual_confirm_color(
 void dcn10_get_hdr_visual_confirm_color(
 		struct pipe_ctx *pipe_ctx,
 		struct tg_color *color);
-bool dcn10_disconnect_pipes(
+void dcn10_disconnect_pipes(
 		struct dc *dc,
 		struct dc_state *context);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 64c1be818b0e..f48ee24d42f9 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -67,7 +67,7 @@ struct hw_sequencer_funcs {
 			int num_planes, struct dc_state *context);
 	void (*program_front_end_for_ctx)(struct dc *dc,
 			struct dc_state *context);
-	bool (*disconnect_pipes)(struct dc *dc,
+	void (*disconnect_pipes)(struct dc *dc,
 			struct dc_state *context);
 	void (*wait_for_pending_cleared)(struct dc *dc,
 			struct dc_state *context);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

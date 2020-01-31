Return-Path: <SRS0=jwYW=3U=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3A4BC35240
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:16 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7319A2082E
	for <amd-gfx@archiver.kernel.org>; Fri, 31 Jan 2020 22:17:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="OhwW7yh1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7319A2082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11B3F6FC39;
	Fri, 31 Jan 2020 22:17:15 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2076.outbound.protection.outlook.com [40.107.92.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 214786FC36
 for <amd-gfx@lists.freedesktop.org>; Fri, 31 Jan 2020 22:17:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gO2cl9+WJ6BCJuLv9s3HNLWan+uY7w7sTflVD+gxN8GahQCBFRWBL6BXxseJYr/ARXEl0qvpOKt8ofbX+WbnRlYwR8o6H4RUfviAKMybR8GNzktWJ3XePh0nxkMTOMd8t8IkzLMd4SEma0uK134Y0V119zsTlBv8nRftbnKBbiVE0ZJSaOJJn+auhOYA2jIckK5tXKoAuw1S9mjMhOvKdnO2MhWLbmumO+YwRmV09LOhXuKxfg9HdnU372Kq2z7xZqhHlzpBCbbM/wK0LlOIHu3yHy5a1vPW2OufYn42wSFYEdo3Tm9rdtqLZ4UhBPtNuXGpTNLp2L4Y7aYwCn8hhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqrboKxZin2Axzlhwj27tvif/sywi62fP6Am65CU9eE=;
 b=d6Bd4ZsTXhvNsmTxCH9bgY1IYhfLpD+nWqb47EH0ENZLXVtP+S8tO4KfI6YHdMghFn5pC+uVYNBUxKO50CuOPVvy4LSVjvS6SPKFF7S+0qz/LUFQyb8qS/Wxk017gHjQXCB5/OA98OSuq+39KhqJHZHrQsNKgtqdr3VMTdB4ViHgDBmrj8HQwVvRrwzqrPc/hJPcxzFsQ0be9ODR00Jx+jOy459/e7X3Ku/gBScdQeUWtJrBgmIGzra8dKZ2rBVsx1x3LiJa+FrL/95qmr0z84rgo8YSdnrhPeW/L7e3yDgDZ4to32bCLO0VtcDDkslOJKeMS7EpNaIfu+4gu5WIRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=permerror action=none header.from=amd.com; dkim=none (message not
 signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hqrboKxZin2Axzlhwj27tvif/sywi62fP6Am65CU9eE=;
 b=OhwW7yh1uZd7VJtPFiRO7UAzqBWkGvUcTE3Vx8ijvW4/RI29kmL2WnHwdgqG18mnOPD8IJFC54iYL0yWmfcd/VtdUe2LcOkGUnErYlY1QIZBGol1VmDIjGNZZuQcfeahv0dmO5H2SXtGl+qNzs3kZ085LprOkmXc6aM/5ScxmfQ=
Received: from DM3PR12CA0083.namprd12.prod.outlook.com (2603:10b6:0:57::27) by
 MN2PR12MB3887.namprd12.prod.outlook.com (2603:10b6:208:168::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.29; Fri, 31 Jan
 2020 22:17:10 +0000
Received: from CO1NAM11FT007.eop-nam11.prod.protection.outlook.com
 (2a01:111:f400:7eab::209) by DM3PR12CA0083.outlook.office365.com
 (2603:10b6:0:57::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2686.28 via Frontend
 Transport; Fri, 31 Jan 2020 22:17:10 +0000
Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=permerror action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 CO1NAM11FT007.mail.protection.outlook.com (10.13.174.131) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.2686.25 via Frontend Transport; Fri, 31 Jan 2020 22:17:09 +0000
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5; Fri, 31 Jan
 2020 16:17:05 -0600
Received: from blakha.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1713.5 via Frontend
 Transport; Fri, 31 Jan 2020 16:17:04 -0600
From: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 11/33] drm/amd/display: Added locking for atomic update stream
 and update planes
Date: Fri, 31 Jan 2020 17:16:21 -0500
Message-ID: <20200131221643.10035-12-Bhawanpreet.Lakha@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
References: <20200131221643.10035-1-Bhawanpreet.Lakha@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-Forefront-Antispam-Report: CIP:165.204.84.17; IPV:; CTRY:US; EFV:NLI;
 SFV:NSPM;
 SFS:(10009020)(4636009)(39860400002)(376002)(346002)(396003)(136003)(428003)(199004)(189003)(356004)(81166006)(54906003)(86362001)(26005)(186003)(316002)(7696005)(36756003)(426003)(15650500001)(5660300002)(2616005)(478600001)(81156014)(8676002)(70206006)(6666004)(8936002)(336012)(4326008)(70586007)(2906002)(6916009)(30864003)(1076003);
 DIR:OUT; SFP:1101; SCL:1; SRVR:MN2PR12MB3887; H:SATLEXMB01.amd.com; FPR:;
 SPF:None; LANG:en; PTR:InfoDomainNonexistent; A:1; MX:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65efbdba-64b1-4eb3-6c27-08d7a69b5099
X-MS-TrafficTypeDiagnostic: MN2PR12MB3887:
X-Microsoft-Antispam-PRVS: <MN2PR12MB3887ADCE6A49BD9C4FA7A6FEF9070@MN2PR12MB3887.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-Forefront-PRVS: 029976C540
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: icAMZF3FGhBA92QPHJctHCdMAzPTs+eQ9X3w/FJmC+JwvURpPBcbVOIechEDQ8bHQ13VicjnEuxrH1f53xBojY9cceKV59d3UEagHim1Ic71w8gzJPDIv/NPj9Y+F8jgr6iF0YDPKI9yDpPNj66P1YQ49kxlM5ekX6xmA+gdcBJLX9RMuRq6p3ReyD7bpBIVqQVnig5IK8J44u/xJtO+GYX0Rr5nbO3YaRLnPGLHsHASkEJ3uEhoM4f9zZ/LxuK5zMLRqN4DW860fWusTlnSAOFb3NxktylEsn6fYw8Fezo5MTqo5zWZEz4hqIyr/h/zi/3M1WEAhJ0a2ZMEf/kf1Y7zJ7Iq+Q9wl2hPL2rcVz2fxZ8He0J8y9rmevJGlvd+b8Wowu3SwlIBRPnK3XEZAjsHAYKSpGG7pcWHqZCtvIPfktVYqlgSWaInM7zYZCdP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2020 22:17:09.6957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65efbdba-64b1-4eb3-6c27-08d7a69b5099
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB3887
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
 Lucy Li <lucy.li@amd.com>, Anthony Koo <Anthony.Koo@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Anthony Koo <Anthony.Koo@amd.com>

[Why]
Screen flickering when HDR switches between FP16 and ARGB2101010

[How]
Moved pipe_control_lock so stream update and plane update occur atomically

Signed-off-by: Anthony Koo <Anthony.Koo@amd.com>
Signed-off-by: Lucy Li <lucy.li@amd.com>
Reviewed-by: Aric Cyr <Aric.Cyr@amd.com>
Acked-by: Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  87 +++++++++++----
 .../display/dc/dce110/dce110_hw_sequencer.c   |  23 +---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  32 +-----
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   4 +
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   1 +
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 101 ++++++++----------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |   4 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |   2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |   2 +-
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   4 +-
 10 files changed, 125 insertions(+), 135 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index c9c7cf00976f..2208282ea6cb 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -761,6 +761,29 @@ static bool disable_all_writeback_pipes_for_stream(
 	return true;
 }
 
+void apply_ctx_interdependent_lock(struct dc *dc, struct dc_state *context, struct dc_stream_state *stream, bool lock)
+{
+	int i = 0;
+
+	/* Checks if interdependent update function pointer is NULL or not, takes care of DCE110 case */
+	if (dc->hwss.interdependent_update_lock)
+		dc->hwss.interdependent_update_lock(dc, context, lock);
+	else {
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+			struct pipe_ctx *old_pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
+
+			// Copied conditions that were previously in dce110_apply_ctx_for_surface
+			if (stream == pipe_ctx->stream) {
+				if (!pipe_ctx->top_pipe &&
+					(pipe_ctx->plane_state || old_pipe_ctx->plane_state))
+					dc->hwss.pipe_control_lock(dc, pipe_ctx, lock);
+				break;
+			}
+		}
+	}
+}
+
 static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 {
 	int i, j;
@@ -786,12 +809,17 @@ static void disable_dangling_plane(struct dc *dc, struct dc_state *context)
 		if (should_disable && old_stream) {
 			dc_rem_all_planes_for_stream(dc, old_stream, dangling_context);
 			disable_all_writeback_pipes_for_stream(dc, old_stream, dangling_context);
+
 			if (dc->hwss.apply_ctx_for_surface) {
+				apply_ctx_interdependent_lock(dc, dc->current_state, old_stream, true);
 				dc->hwss.apply_ctx_for_surface(dc, old_stream, 0, dangling_context);
+				apply_ctx_interdependent_lock(dc, dc->current_state, old_stream, false);
 				dc->hwss.post_unlock_program_front_end(dc, dangling_context);
 			}
 			if (dc->hwss.program_front_end_for_ctx) {
+				dc->hwss.interdependent_update_lock(dc, dc->current_state, true);
 				dc->hwss.program_front_end_for_ctx(dc, dangling_context);
+				dc->hwss.interdependent_update_lock(dc, dc->current_state, false);
 				dc->hwss.post_unlock_program_front_end(dc, dangling_context);
 			}
 		}
@@ -1214,17 +1242,19 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 	/* re-program planes for existing stream, in case we need to
 	 * free up plane resource for later use
 	 */
-	if (dc->hwss.apply_ctx_for_surface)
+	if (dc->hwss.apply_ctx_for_surface) {
 		for (i = 0; i < context->stream_count; i++) {
 			if (context->streams[i]->mode_changed)
 				continue;
-
+			apply_ctx_interdependent_lock(dc, context, context->streams[i], true);
 			dc->hwss.apply_ctx_for_surface(
 				dc, context->streams[i],
 				context->stream_status[i].plane_count,
 				context); /* use new pipe config in new context */
+			apply_ctx_interdependent_lock(dc, context, context->streams[i], false);
 			dc->hwss.post_unlock_program_front_end(dc, context);
 		}
+	}
 
 	/* Program hardware */
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
@@ -1244,10 +1274,11 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 
 	/* Program all planes within new context*/
 	if (dc->hwss.program_front_end_for_ctx) {
+		dc->hwss.interdependent_update_lock(dc, context, true);
 		dc->hwss.program_front_end_for_ctx(dc, context);
+		dc->hwss.interdependent_update_lock(dc, context, false);
 		dc->hwss.post_unlock_program_front_end(dc, context);
 	}
-
 	for (i = 0; i < context->stream_count; i++) {
 		const struct dc_link *link = context->streams[i]->link;
 
@@ -1255,10 +1286,12 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 			continue;
 
 		if (dc->hwss.apply_ctx_for_surface) {
+			apply_ctx_interdependent_lock(dc, context, context->streams[i], true);
 			dc->hwss.apply_ctx_for_surface(
 					dc, context->streams[i],
 					context->stream_status[i].plane_count,
 					context);
+			apply_ctx_interdependent_lock(dc, context, context->streams[i], false);
 			dc->hwss.post_unlock_program_front_end(dc, context);
 		}
 
@@ -2105,15 +2138,10 @@ static void commit_planes_do_stream_update(struct dc *dc,
 			if (update_type == UPDATE_TYPE_FAST)
 				continue;
 
-			if (stream_update->dsc_config && dc->hwss.pipe_control_lock_global) {
-				dc->hwss.pipe_control_lock_global(dc, pipe_ctx, true);
+			if (stream_update->dsc_config)
 				dp_update_dsc_config(pipe_ctx);
-				dc->hwss.pipe_control_lock_global(dc, pipe_ctx, false);
-			}
 
 			if (stream_update->dpms_off) {
-				dc->hwss.pipe_control_lock(dc, pipe_ctx, true);
-
 				if (*stream_update->dpms_off) {
 					core_link_disable_stream(pipe_ctx);
 					/* for dpms, keep acquired resources*/
@@ -2127,8 +2155,6 @@ static void commit_planes_do_stream_update(struct dc *dc,
 
 					core_link_enable_stream(dc->current_state, pipe_ctx);
 				}
-
-				dc->hwss.pipe_control_lock(dc, pipe_ctx, false);
 			}
 
 			if (stream_update->abm_level && pipe_ctx->stream_res.abm) {
@@ -2184,6 +2210,27 @@ static void commit_planes_for_stream(struct dc *dc,
 		context_clock_trace(dc, context);
 	}
 
+	for (j = 0; j < dc->res_pool->pipe_count; j++) {
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
+
+		if (!pipe_ctx->top_pipe &&
+			!pipe_ctx->prev_odm_pipe &&
+			pipe_ctx->stream &&
+			pipe_ctx->stream == stream) {
+			top_pipe_to_program = pipe_ctx;
+		}
+	}
+
+	if ((update_type != UPDATE_TYPE_FAST) && dc->hwss.interdependent_update_lock)
+		dc->hwss.interdependent_update_lock(dc, context, true);
+	else
+		/* Lock the top pipe while updating plane addrs, since freesync requires
+		 *  plane addr update event triggers to be synchronized.
+		 *  top_pipe_to_program is expected to never be NULL
+		 */
+		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, true);
+
+
 	// Stream updates
 	if (stream_update)
 		commit_planes_do_stream_update(dc, stream, stream_update, update_type, context);
@@ -2198,6 +2245,11 @@ static void commit_planes_for_stream(struct dc *dc,
 		if (dc->hwss.program_front_end_for_ctx)
 			dc->hwss.program_front_end_for_ctx(dc, context);
 
+		if ((update_type != UPDATE_TYPE_FAST) && dc->hwss.interdependent_update_lock)
+			dc->hwss.interdependent_update_lock(dc, context, false);
+		else
+			dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
+
 		dc->hwss.post_unlock_program_front_end(dc, context);
 		return;
 	}
@@ -2234,8 +2286,6 @@ static void commit_planes_for_stream(struct dc *dc,
 			pipe_ctx->stream == stream) {
 			struct dc_stream_status *stream_status = NULL;
 
-			top_pipe_to_program = pipe_ctx;
-
 			if (!pipe_ctx->plane_state)
 				continue;
 
@@ -2280,12 +2330,6 @@ static void commit_planes_for_stream(struct dc *dc,
 
 	// Update Type FAST, Surface updates
 	if (update_type == UPDATE_TYPE_FAST) {
-		/* Lock the top pipe while updating plane addrs, since freesync requires
-		 *  plane addr update event triggers to be synchronized.
-		 *  top_pipe_to_program is expected to never be NULL
-		 */
-		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, true);
-
 		if (dc->hwss.set_flip_control_gsl)
 			for (i = 0; i < surface_count; i++) {
 				struct dc_plane_state *plane_state = srf_updates[i].surface;
@@ -2327,9 +2371,12 @@ static void commit_planes_for_stream(struct dc *dc,
 					dc->hwss.update_plane_addr(dc, pipe_ctx);
 			}
 		}
+	}
 
+	if ((update_type != UPDATE_TYPE_FAST) && dc->hwss.interdependent_update_lock)
+		dc->hwss.interdependent_update_lock(dc, context, false);
+	else
 		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
-	}
 
 	if (update_type != UPDATE_TYPE_FAST)
 		dc->hwss.post_unlock_program_front_end(dc, context);
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index a961b94aefd9..56d4ec7bdad7 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -2574,17 +2574,6 @@ static void dce110_apply_ctx_for_surface(
 	if (dc->fbc_compressor)
 		dc->fbc_compressor->funcs->disable_fbc(dc->fbc_compressor);
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-		struct pipe_ctx *old_pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
-
-		if (stream == pipe_ctx->stream) {
-			if (!pipe_ctx->top_pipe &&
-				(pipe_ctx->plane_state || old_pipe_ctx->plane_state))
-				dc->hwss.pipe_control_lock(dc, pipe_ctx, true);
-		}
-	}
-
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
 
@@ -2607,16 +2596,6 @@ static void dce110_apply_ctx_for_surface(
 
 	}
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-		struct pipe_ctx *old_pipe_ctx = &dc->current_state->res_ctx.pipe_ctx[i];
-
-		if ((stream == pipe_ctx->stream) &&
-			(!pipe_ctx->top_pipe) &&
-			(pipe_ctx->plane_state || old_pipe_ctx->plane_state))
-			dc->hwss.pipe_control_lock(dc, pipe_ctx, false);
-	}
-
 	if (dc->fbc_compressor)
 		enable_fbc(dc, context);
 }
@@ -2626,6 +2605,7 @@ static void dce110_post_unlock_program_front_end(
 		struct dc_state *context)
 {
 }
+
 static void dce110_power_down_fe(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
 	struct dce_hwseq *hws = dc->hwseq;
@@ -2742,6 +2722,7 @@ static const struct hw_sequencer_funcs dce110_funcs = {
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dce110_power_down_fe,
 	.pipe_control_lock = dce_pipe_control_lock,
+	.interdependent_update_lock = NULL,
 	.prepare_bandwidth = dce110_prepare_bandwidth,
 	.optimize_bandwidth = dce110_optimize_bandwidth,
 	.set_drr = set_drr,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index a9a5a13d5edf..7fc559acffcd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -82,7 +82,7 @@ void print_microsec(struct dc_context *dc_ctx,
 			us_x10 % frac);
 }
 
-static void dcn10_lock_all_pipes(struct dc *dc,
+void dcn10_lock_all_pipes(struct dc *dc,
 	struct dc_state *context,
 	bool lock)
 {
@@ -93,6 +93,7 @@ static void dcn10_lock_all_pipes(struct dc *dc,
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		pipe_ctx = &context->res_ctx.pipe_ctx[i];
 		tg = pipe_ctx->stream_res.tg;
+
 		/*
 		 * Only lock the top pipe's tg to prevent redundant
 		 * (un)locking. Also skip if pipe is disabled.
@@ -103,9 +104,9 @@ static void dcn10_lock_all_pipes(struct dc *dc,
 			continue;
 
 		if (lock)
-			tg->funcs->lock(tg);
+			dc->hwss.pipe_control_lock(dc, pipe_ctx, true);
 		else
-			tg->funcs->unlock(tg);
+			dc->hwss.pipe_control_lock(dc, pipe_ctx, false);
 	}
 }
 
@@ -1576,7 +1577,7 @@ void dcn10_pipe_control_lock(
 	/* use TG master update lock to lock everything on the TG
 	 * therefore only top pipe need to lock
 	 */
-	if (pipe->top_pipe)
+	if (!pipe || pipe->top_pipe)
 		return;
 
 	if (dc->debug.sanity_checks)
@@ -2530,11 +2531,6 @@ void dcn10_apply_ctx_for_surface(
 	if (underflow_check_delay_us != 0xFFFFFFFF && hws->funcs.did_underflow_occur)
 		ASSERT(hws->funcs.did_underflow_occur(dc, top_pipe_to_program));
 
-	if (interdependent_update)
-		dcn10_lock_all_pipes(dc, context, true);
-	else
-		dcn10_pipe_control_lock(dc, top_pipe_to_program, true);
-
 	if (underflow_check_delay_us != 0xFFFFFFFF)
 		udelay(underflow_check_delay_us);
 
@@ -2554,19 +2550,6 @@ void dcn10_apply_ctx_for_surface(
 
 		pipe_ctx->update_flags.raw = 0;
 
-		/*
-		 * Powergate reused pipes that are not powergated
-		 * fairly hacky right now, using opp_id as indicator
-		 * TODO: After move dc_post to dc_update, this will
-		 * be removed.
-		 */
-		if (pipe_ctx->plane_state && !old_pipe_ctx->plane_state) {
-			if (old_pipe_ctx->stream_res.tg == tg &&
-			    old_pipe_ctx->plane_res.hubp &&
-			    old_pipe_ctx->plane_res.hubp->opp_id != OPP_ID_INVALID)
-				dc->hwss.disable_plane(dc, old_pipe_ctx);
-		}
-
 		if ((!pipe_ctx->plane_state ||
 		     pipe_ctx->stream_res.tg != old_pipe_ctx->stream_res.tg) &&
 		    old_pipe_ctx->plane_state &&
@@ -2599,11 +2582,6 @@ void dcn10_apply_ctx_for_surface(
 				&pipe_ctx->dlg_regs,
 				&pipe_ctx->ttu_regs);
 		}
-
-	if (interdependent_update)
-		dcn10_lock_all_pipes(dc, context, false);
-	else
-		dcn10_pipe_control_lock(dc, top_pipe_to_program, false);
 }
 
 void dcn10_post_unlock_program_front_end(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
index b523f0b8dc23..16a50e05ffbf 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
@@ -70,6 +70,10 @@ void dcn10_reset_hw_ctx_wrap(
 		struct dc *dc,
 		struct dc_state *context);
 void dcn10_disable_plane(struct dc *dc, struct pipe_ctx *pipe_ctx);
+void dcn10_lock_all_pipes(
+		struct dc *dc,
+		struct dc_state *context,
+		bool lock);
 void dcn10_apply_ctx_for_surface(
 		struct dc *dc,
 		const struct dc_stream_state *stream,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
index 681db997a532..b88ef9703b2b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
@@ -50,6 +50,7 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dcn10_disable_plane,
 	.pipe_control_lock = dcn10_pipe_control_lock,
+	.interdependent_update_lock = dcn10_lock_all_pipes,
 	.prepare_bandwidth = dcn10_prepare_bandwidth,
 	.optimize_bandwidth = dcn10_optimize_bandwidth,
 	.set_drr = dcn10_set_drr,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index f36c4d1b7c30..129a91e8f250 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1088,40 +1088,18 @@ void dcn20_enable_plane(
 //	}
 }
 
-
-void dcn20_pipe_control_lock_global(
-		struct dc *dc,
-		struct pipe_ctx *pipe,
-		bool lock)
-{
-	if (lock) {
-		pipe->stream_res.tg->funcs->lock_doublebuffer_enable(
-				pipe->stream_res.tg);
-		pipe->stream_res.tg->funcs->lock(pipe->stream_res.tg);
-	} else {
-		pipe->stream_res.tg->funcs->unlock(pipe->stream_res.tg);
-		pipe->stream_res.tg->funcs->wait_for_state(pipe->stream_res.tg,
-				CRTC_STATE_VACTIVE);
-		pipe->stream_res.tg->funcs->wait_for_state(pipe->stream_res.tg,
-				CRTC_STATE_VBLANK);
-		pipe->stream_res.tg->funcs->wait_for_state(pipe->stream_res.tg,
-				CRTC_STATE_VACTIVE);
-		pipe->stream_res.tg->funcs->lock_doublebuffer_disable(
-				pipe->stream_res.tg);
-	}
-}
-
 void dcn20_pipe_control_lock(
 	struct dc *dc,
 	struct pipe_ctx *pipe,
 	bool lock)
 {
 	bool flip_immediate = false;
+	bool dig_update_required = false;
 
 	/* use TG master update lock to lock everything on the TG
 	 * therefore only top pipe need to lock
 	 */
-	if (pipe->top_pipe)
+	if (!pipe || pipe->top_pipe)
 		return;
 
 	if (pipe->plane_state != NULL)
@@ -1154,6 +1132,19 @@ void dcn20_pipe_control_lock(
 		    (!flip_immediate && pipe->stream_res.gsl_group > 0))
 			dcn20_setup_gsl_group_as_lock(dc, pipe, flip_immediate);
 
+	if (pipe->stream && pipe->stream->update_flags.bits.dsc_changed)
+		dig_update_required = true;
+
+	/* Need double buffer lock mode in order to synchronize front end pipe
+	 * updates with dig updates.
+	 */
+	if (dig_update_required) {
+		if (lock) {
+			pipe->stream_res.tg->funcs->lock_doublebuffer_enable(
+					pipe->stream_res.tg);
+		}
+	}
+
 	if (pipe->plane_state != NULL && pipe->plane_state->triplebuffer_flips) {
 		if (lock)
 			pipe->stream_res.tg->funcs->triplebuffer_lock(pipe->stream_res.tg);
@@ -1165,6 +1156,19 @@ void dcn20_pipe_control_lock(
 		else
 			pipe->stream_res.tg->funcs->unlock(pipe->stream_res.tg);
 	}
+
+	if (dig_update_required) {
+		if (!lock) {
+			pipe->stream_res.tg->funcs->wait_for_state(pipe->stream_res.tg,
+					CRTC_STATE_VACTIVE);
+			pipe->stream_res.tg->funcs->wait_for_state(pipe->stream_res.tg,
+					CRTC_STATE_VBLANK);
+			pipe->stream_res.tg->funcs->wait_for_state(pipe->stream_res.tg,
+					CRTC_STATE_VACTIVE);
+			pipe->stream_res.tg->funcs->lock_doublebuffer_disable(
+					pipe->stream_res.tg);
+		}
+	}
 }
 
 static void dcn20_detect_pipe_changes(struct pipe_ctx *old_pipe, struct pipe_ctx *new_pipe)
@@ -1536,26 +1540,28 @@ static void dcn20_program_pipe(
 	}
 }
 
-static bool does_pipe_need_lock(struct pipe_ctx *pipe)
-{
-	if ((pipe->plane_state && pipe->plane_state->update_flags.raw)
-			|| pipe->update_flags.raw)
-		return true;
-	if (pipe->bottom_pipe)
-		return does_pipe_need_lock(pipe->bottom_pipe);
-
-	return false;
-}
-
 void dcn20_program_front_end_for_ctx(
 		struct dc *dc,
 		struct dc_state *context)
 {
 	int i;
 	struct dce_hwseq *hws = dc->hwseq;
-	bool pipe_locked[MAX_PIPES] = {false};
 	DC_LOGGER_INIT(dc->ctx->logger);
 
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+
+		if (!pipe_ctx->top_pipe && !pipe_ctx->prev_odm_pipe && pipe_ctx->plane_state) {
+			ASSERT(!pipe_ctx->plane_state->triplebuffer_flips);
+			if (dc->hwss.program_triplebuffer != NULL &&
+				!dc->debug.disable_tri_buf) {
+				/*turn off triple buffer for full update*/
+				dc->hwss.program_triplebuffer(
+					dc, pipe_ctx, pipe_ctx->plane_state->triplebuffer_flips);
+			}
+		}
+	}
+
 	/* Carry over GSL groups in case the context is changing. */
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
 		if (context->res_ctx.pipe_ctx[i].stream == dc->current_state->res_ctx.pipe_ctx[i].stream)
@@ -1566,17 +1572,6 @@ void dcn20_program_front_end_for_ctx(
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
 		dcn20_detect_pipe_changes(&dc->current_state->res_ctx.pipe_ctx[i],
 				&context->res_ctx.pipe_ctx[i]);
-	for (i = 0; i < dc->res_pool->pipe_count; i++)
-		if (!context->res_ctx.pipe_ctx[i].top_pipe &&
-				does_pipe_need_lock(&context->res_ctx.pipe_ctx[i])) {
-			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-
-			if (pipe_ctx->update_flags.bits.tg_changed || pipe_ctx->update_flags.bits.enable)
-				dc->hwss.pipe_control_lock(dc, pipe_ctx, true);
-			if (!pipe_ctx->update_flags.bits.enable)
-				dc->hwss.pipe_control_lock(dc, &dc->current_state->res_ctx.pipe_ctx[i], true);
-			pipe_locked[i] = true;
-		}
 
 	/* OTG blank before disabling all front ends */
 	for (i = 0; i < dc->res_pool->pipe_count; i++)
@@ -1614,17 +1609,6 @@ void dcn20_program_front_end_for_ctx(
 				hws->funcs.program_all_writeback_pipes_in_tree(dc, pipe->stream, context);
 		}
 	}
-
-	/* Unlock all locked pipes */
-	for (i = 0; i < dc->res_pool->pipe_count; i++)
-		if (pipe_locked[i]) {
-			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-
-			if (pipe_ctx->update_flags.bits.tg_changed || pipe_ctx->update_flags.bits.enable)
-				dc->hwss.pipe_control_lock(dc, pipe_ctx, false);
-			if (!pipe_ctx->update_flags.bits.enable)
-				dc->hwss.pipe_control_lock(dc, &dc->current_state->res_ctx.pipe_ctx[i], false);
-		}
 }
 
 void dcn20_post_unlock_program_front_end(
@@ -1664,7 +1648,6 @@ void dcn20_post_unlock_program_front_end(
 		dc->res_pool->hubbub->funcs->apply_DEDCN21_147_wa(dc->res_pool->hubbub);
 }
 
-
 void dcn20_prepare_bandwidth(
 		struct dc *dc,
 		struct dc_state *context)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
index 80f192b8b3a2..63ce763f148e 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
@@ -61,10 +61,6 @@ void dcn20_pipe_control_lock(
 	struct dc *dc,
 	struct pipe_ctx *pipe,
 	bool lock);
-void dcn20_pipe_control_lock_global(
-		struct dc *dc,
-		struct pipe_ctx *pipe,
-		bool lock);
 void dcn20_prepare_bandwidth(
 		struct dc *dc,
 		struct dc_state *context);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index cb0cb999251e..44ec5f5f9fd2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -51,7 +51,7 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dcn20_disable_plane,
 	.pipe_control_lock = dcn20_pipe_control_lock,
-	.pipe_control_lock_global = dcn20_pipe_control_lock_global,
+	.interdependent_update_lock = dcn10_lock_all_pipes,
 	.prepare_bandwidth = dcn20_prepare_bandwidth,
 	.optimize_bandwidth = dcn20_optimize_bandwidth,
 	.update_bandwidth = dcn20_update_bandwidth,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index 4963a540948d..53006f3b9eb9 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -52,7 +52,7 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.disable_audio_stream = dce110_disable_audio_stream,
 	.disable_plane = dcn20_disable_plane,
 	.pipe_control_lock = dcn20_pipe_control_lock,
-	.pipe_control_lock_global = dcn20_pipe_control_lock_global,
+	.interdependent_update_lock = dcn10_lock_all_pipes,
 	.prepare_bandwidth = dcn20_prepare_bandwidth,
 	.optimize_bandwidth = dcn20_optimize_bandwidth,
 	.update_bandwidth = dcn20_update_bandwidth,
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 63919866ba38..d4c1fb242c63 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -80,10 +80,10 @@ struct hw_sequencer_funcs {
 	void (*update_pending_status)(struct pipe_ctx *pipe_ctx);
 
 	/* Pipe Lock Related */
-	void (*pipe_control_lock_global)(struct dc *dc,
-			struct pipe_ctx *pipe, bool lock);
 	void (*pipe_control_lock)(struct dc *dc,
 			struct pipe_ctx *pipe, bool lock);
+	void (*interdependent_update_lock)(struct dc *dc,
+			struct dc_state *context, bool lock);
 	void (*set_flip_control_gsl)(struct pipe_ctx *pipe_ctx,
 			bool flip_immediate);
 
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

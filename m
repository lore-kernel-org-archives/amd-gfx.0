Return-Path: <SRS0=buuZ=D4=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15096C5DF9D
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F8092224E
	for <amd-gfx@archiver.kernel.org>; Wed, 21 Oct 2020 14:23:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=amdcloud.onmicrosoft.com header.i=@amdcloud.onmicrosoft.com header.b="HLfQ+oKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F8092224E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23C8C6EDCF;
	Wed, 21 Oct 2020 14:23:24 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C1E2B6EDC5
 for <amd-gfx@lists.freedesktop.org>; Wed, 21 Oct 2020 14:23:21 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z1oEAehy3dZYk/MT0n61Q0+VmYEGDBLMPQ5VnbKh7BzmvSIf6F2sWKkoHdHX3sru7lP++2tQbxRDzyjvU0yjSTRk2+WuQP2AlM0x4b2eBqVv3ciG11rnuKv89Cb+fg0ATqp5gEvcINorBSJxZv8dTNR/O7dIGvAwQ25RnhH9sCQtlhbWcB96bvcvG9N9CAvz/c/wxuPKW1ZogvcZmfnvsW0v9ES25lsArGGN06T5LL7A4aQhJgQLUrGv5WR1SY1Z2IzHWOq5uVFSuv7Ykyki+nj5yFWGHFyd1+4+DiZX1o46v7sZWuPiyN/vfI5kkOlZ6FQ1sXPnkmcTGRz6PfJVqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCj35HGVixNo4c7GFseBvk6G5On4AhF/mk9mesdB4e0=;
 b=RWjXIyLKSADCyoyvlIiK7yepaZsU+xI8YffBqZAJxogvD37CFFckK6cOSCvjOarbq7oWz3l0nTPkt/Ya7MWudTnXb0mhBEepf+hCJUWLlcvzzRArvu18Y0EbP3UwSn0vDPoUlzE4FQJx6SmpV17FpEOT7RUtQ3b/UFYCaYe5L7oslXZfYQhTtwFvgA980iQte2Z1CL2FtrG6IlqWta19CDuFkkZ0hTiFmWmPwCkei6KQConCh/IivuN0EE9qA0NH7P/1r7bM5wYOROkkFDM1JGMP5dBYfj+iQihsK6PqNmbGGczLW8FBmurTmK2USVnOyA7vUiLBaj4Kf1upQNGgCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=none action=none header.from=amd.com; dkim=none (message not signed);
 arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amdcloud.onmicrosoft.com; s=selector2-amdcloud-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kCj35HGVixNo4c7GFseBvk6G5On4AhF/mk9mesdB4e0=;
 b=HLfQ+oKGGppL+n61NhzAz5vL9YdwLkbuW2MX3apviI2XVTAF/gFSzv4mPAXb9K7lTEYFqdzMhJWGLZTnwpPro9MPIenQyaw4OH8LFx8Pq1dLy2QgrLuf98mPOcgOWNw/0ERSxSknbm6yb5cV6Ru7JUtdndDWdh0ohpwHQUaoWck=
Received: from DM5PR11CA0005.namprd11.prod.outlook.com (2603:10b6:3:115::15)
 by BL0PR12MB4739.namprd12.prod.outlook.com (2603:10b6:208:81::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.21; Wed, 21 Oct
 2020 14:23:18 +0000
Received: from DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
 (2603:10b6:3:115:cafe::54) by DM5PR11CA0005.outlook.office365.com
 (2603:10b6:3:115::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Wed, 21 Oct 2020 14:23:18 +0000
X-MS-Exchange-Authentication-Results: spf=none (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=amd.com;
Received-SPF: None (protection.outlook.com: amd.com does not designate
 permitted sender hosts)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 DM6NAM11FT029.mail.protection.outlook.com (10.13.173.23) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:23:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:17 -0500
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 21 Oct
 2020 09:23:17 -0500
Received: from aj-EliteDesk.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 21 Oct 2020 09:23:16 -0500
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 16/33] drm/amd/display: Revert check for flip pending before
 locking pipes
Date: Wed, 21 Oct 2020 10:22:40 -0400
Message-ID: <20201021142257.190969-17-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201021142257.190969-1-aurabindo.pillai@amd.com>
References: <20201021142257.190969-1-aurabindo.pillai@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b4182870-f070-45da-0b38-08d875ccdaf4
X-MS-TrafficTypeDiagnostic: BL0PR12MB4739:
X-Microsoft-Antispam-PRVS: <BL0PR12MB47392CD2BECC575D3592DB278B1C0@BL0PR12MB4739.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:364;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: n0CqmOhK/8C2iqDkSTJInaFzF9qrYWAeHscFGnEgrxu0EZu9p/Guglq5uHZToahcZGNBUbVwcCpzo92XQP4KJHu1fRhymyu5GraG8djtfRJRidUY250kRhaMBTP0d+0meKaW6kgJTtuSpc7se/Ty5xht7JcaFom+4aLYXOVTtARUsuH+DZAuWNODM0VNI2qg+KTVkuENl1nfyQOyf/wcV0nfZ38BoxHlKpMD/m5B8trbseTKLAfV+QaWRtXZVnT/RqMFc4KaYG0tO8VTwuXs2KKjDgN+45eptIZeErYV9rAiuQXFIiSbL01Py6Zobop1na0bpsQ9NBwW3PtHdqMMPQeASV7UPsDP7RJlPwGsKK5TC4N53qvH63yvaMKUURkKxrD7ba7w2GKoC9vtBEIdBg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(136003)(376002)(39860400002)(396003)(346002)(46966005)(1076003)(336012)(426003)(6666004)(54906003)(316002)(6916009)(8676002)(2906002)(2616005)(8936002)(186003)(4326008)(36756003)(7696005)(26005)(86362001)(44832011)(30864003)(478600001)(81166007)(70206006)(82310400003)(83380400001)(70586007)(356005)(47076004)(82740400003)(5660300002);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:23:17.9200 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4182870-f070-45da-0b38-08d875ccdaf4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT029.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4739
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
Cc: Isabel Zhang <isabel.zhang@amd.com>, Eryk.Brol@amd.com, Sunpeng.Li@amd.com,
 Harry.Wentland@amd.com, Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com,
 Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Isabel Zhang <isabel.zhang@amd.com>

[Why]
Causes underflow regression

[How]
This reverts commit f61b3a065f129a90ca83bb214a507b29b9c15ba7

Signed-off-by: Isabel Zhang <isabel.zhang@amd.com>
Acked-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  11 +-
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 156 ++++++++----------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   2 +-
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |   2 +-
 4 files changed, 83 insertions(+), 88 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 72819cf19b5b..8f4738b09922 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2376,6 +2376,7 @@ static void commit_planes_for_stream(struct dc *dc,
 		enum surface_update_type update_type,
 		struct dc_state *context)
 {
+	bool mpcc_disconnected = false;
 	int i, j;
 	struct pipe_ctx *top_pipe_to_program = NULL;
 
@@ -2406,8 +2407,14 @@ static void commit_planes_for_stream(struct dc *dc,
 		context_clock_trace(dc, context);
 	}
 
-	if (update_type != UPDATE_TYPE_FAST && dc->hwss.interdependent_update_lock && dc->hwss.wait_for_pending_cleared)
-		dc->hwss.disconnect_pipes(dc, context);
+	if (update_type != UPDATE_TYPE_FAST && dc->hwss.interdependent_update_lock &&
+		dc->hwss.disconnect_pipes && dc->hwss.wait_for_pending_cleared){
+		dc->hwss.interdependent_update_lock(dc, context, true);
+		mpcc_disconnected = dc->hwss.disconnect_pipes(dc, context);
+		dc->hwss.interdependent_update_lock(dc, context, false);
+		if (mpcc_disconnected)
+			dc->hwss.wait_for_pending_cleared(dc, context);
+	}
 
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 6b141c9f521f..b7046d8eb114 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2775,132 +2775,120 @@ static struct pipe_ctx *dcn10_find_top_pipe_for_stream(
 	return NULL;
 }
 
-void dcn10_disconnect_pipes(
+bool dcn10_disconnect_pipes(
 		struct dc *dc,
 		struct dc_state *context)
 {
-	bool disconnect_pipes[MAX_PIPES] = {0};
-	bool found_pipe = false;
-	int i, j;
-	struct dce_hwseq *hws = dc->hwseq;
-	struct dc_state *old_ctx = dc->current_state;
-	bool plane_disabled = false;
-	struct pipe_ctx *old_pipe;
-	struct pipe_ctx *new_pipe;
-
-	DC_LOGGER_INIT(dc->ctx->logger);
+		bool found_pipe = false;
+		int i, j;
+		struct dce_hwseq *hws = dc->hwseq;
+		struct dc_state *old_ctx = dc->current_state;
+		bool mpcc_disconnected = false;
+		struct pipe_ctx *old_pipe;
+		struct pipe_ctx *new_pipe;
+		DC_LOGGER_INIT(dc->ctx->logger);
 
-	/* Set pipe update flags and lock pipes */
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
-		new_pipe = &context->res_ctx.pipe_ctx[i];
-		new_pipe->update_flags.raw = 0;
+		/* Set pipe update flags and lock pipes */
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+			new_pipe = &context->res_ctx.pipe_ctx[i];
+			new_pipe->update_flags.raw = 0;
 
-		if (!old_pipe->plane_state && !new_pipe->plane_state)
-			continue;
+			if (!old_pipe->plane_state && !new_pipe->plane_state)
+				continue;
 
-		if (old_pipe->plane_state && !new_pipe->plane_state)
-			new_pipe->update_flags.bits.disable = 1;
+			if (old_pipe->plane_state && !new_pipe->plane_state)
+				new_pipe->update_flags.bits.disable = 1;
 
-		/* Check for scl update */
-		if (memcmp(&old_pipe->plane_res.scl_data, &new_pipe->plane_res.scl_data, sizeof(struct scaler_data)))
-			new_pipe->update_flags.bits.scaler = 1;
+			/* Check for scl update */
+			if (memcmp(&old_pipe->plane_res.scl_data, &new_pipe->plane_res.scl_data, sizeof(struct scaler_data)))
+					new_pipe->update_flags.bits.scaler = 1;
 
-		/* Check for vp update */
-		if (memcmp(&old_pipe->plane_res.scl_data.viewport, &new_pipe->plane_res.scl_data.viewport, sizeof(struct rect))
-				|| memcmp(&old_pipe->plane_res.scl_data.viewport_c,
+			/* Check for vp update */
+			if (memcmp(&old_pipe->plane_res.scl_data.viewport, &new_pipe->plane_res.scl_data.viewport, sizeof(struct rect))
+					|| memcmp(&old_pipe->plane_res.scl_data.viewport_c,
 						&new_pipe->plane_res.scl_data.viewport_c, sizeof(struct rect)))
-			new_pipe->update_flags.bits.viewport = 1;
+				new_pipe->update_flags.bits.viewport = 1;
 
-	}
+		}
 
-	if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
-		/* Disconnect mpcc here only if losing pipe split*/
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable &&
+		if (!IS_DIAG_DC(dc->ctx->dce_environment)) {
+			/* Disconnect mpcc here only if losing pipe split*/
+			for (i = 0; i < dc->res_pool->pipe_count; i++) {
+				if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable &&
 					old_ctx->res_ctx.pipe_ctx[i].top_pipe) {
 
-				/* Find the top pipe in the new ctx for the bottom pipe that we
-				 * want to remove by comparing the streams and planes. If both
-				 * pipes are being disabled then do it in the regular pipe
-				 * programming sequence
-				 */
-				for (j = 0; j < dc->res_pool->pipe_count; j++) {
-					if (old_ctx->res_ctx.pipe_ctx[i].top_pipe->stream == context->res_ctx.pipe_ctx[j].stream &&
+					/* Find the top pipe in the new ctx for the bottom pipe that we
+					 * want to remove by comparing the streams and planes. If both
+					 * pipes are being disabled then do it in the regular pipe
+					 * programming sequence
+					 */
+					for (j = 0; j < dc->res_pool->pipe_count; j++) {
+						if (old_ctx->res_ctx.pipe_ctx[i].top_pipe->stream == context->res_ctx.pipe_ctx[j].stream &&
 							old_ctx->res_ctx.pipe_ctx[i].top_pipe->plane_state == context->res_ctx.pipe_ctx[j].plane_state &&
 							!context->res_ctx.pipe_ctx[j].top_pipe &&
 							!context->res_ctx.pipe_ctx[j].update_flags.bits.disable) {
-						found_pipe = true;
-						break;
+							found_pipe = true;
+							break;
+						}
 					}
-				}
-
-				plane_disabled = true;
 
-				// Disconnect if the top pipe lost it's pipe split
-				if (found_pipe && !context->res_ctx.pipe_ctx[j].bottom_pipe) {
-					disconnect_pipes[i] = true;
+					// Disconnect if the top pipe lost it's pipe split
+					if (found_pipe && !context->res_ctx.pipe_ctx[j].bottom_pipe) {
+						hws->funcs.plane_atomic_disconnect(dc, &dc->current_state->res_ctx.pipe_ctx[i]);
+						DC_LOG_DC("Reset mpcc for pipe %d\n", dc->current_state->res_ctx.pipe_ctx[i].pipe_idx);
+						mpcc_disconnected = true;
+					}
 				}
+				found_pipe = false;
 			}
-			found_pipe = false;
 		}
-	}
 
-	if (plane_disabled) {
-		dc->hwss.wait_for_pending_cleared(dc, context);
-		dc->hwss.interdependent_update_lock(dc, context, true);
-
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-			struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
-			struct dc_plane_state *plane_state = pipe_ctx->plane_state;
-			struct hubp *hubp = pipe_ctx->plane_res.hubp;
-
-			if (!pipe_ctx || !plane_state || !pipe_ctx->stream)
-				continue;
+		if (mpcc_disconnected) {
+			for (i = 0; i < dc->res_pool->pipe_count; i++) {
+				struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
+				struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+				struct dc_plane_state *plane_state = pipe_ctx->plane_state;
+				struct hubp *hubp = pipe_ctx->plane_res.hubp;
 
-			if (disconnect_pipes[i]) {
-				hws->funcs.plane_atomic_disconnect(dc, &dc->current_state->res_ctx.pipe_ctx[i]);
-				DC_LOG_DC("Reset mpcc for pipe %d\n", dc->current_state->res_ctx.pipe_ctx[i].pipe_idx);
-			}
+				if (!pipe_ctx || !plane_state || !pipe_ctx->stream)
+					continue;
 
-			// Only update scaler and viewport here if we lose a pipe split.
-			// This is to prevent half the screen from being black when we
-			// unlock after disconnecting MPCC.
-			if (!(old_pipe && !pipe_ctx->top_pipe &&
+				// Only update scaler and viewport here if we lose a pipe split.
+				// This is to prevent half the screen from being black when we
+				// unlock after disconnecting MPCC.
+				if (!(old_pipe && !pipe_ctx->top_pipe &&
 					!pipe_ctx->bottom_pipe && old_pipe->bottom_pipe))
-				continue;
+					continue;
 
-			if (pipe_ctx->update_flags.raw || pipe_ctx->plane_state->update_flags.raw || pipe_ctx->stream->update_flags.raw) {
-				if (pipe_ctx->update_flags.bits.scaler ||
+				if (pipe_ctx->update_flags.raw || pipe_ctx->plane_state->update_flags.raw || pipe_ctx->stream->update_flags.raw) {
+					if (pipe_ctx->update_flags.bits.scaler ||
 						plane_state->update_flags.bits.scaling_change ||
 						plane_state->update_flags.bits.position_change ||
 						plane_state->update_flags.bits.per_pixel_alpha_change ||
 						pipe_ctx->stream->update_flags.bits.scaling) {
 
-					pipe_ctx->plane_res.scl_data.lb_params.alpha_en = pipe_ctx->plane_state->per_pixel_alpha;
-					ASSERT(pipe_ctx->plane_res.scl_data.lb_params.depth == LB_PIXEL_DEPTH_30BPP);
-					/* scaler configuration */
-					pipe_ctx->plane_res.dpp->funcs->dpp_set_scaler(
-							pipe_ctx->plane_res.dpp, &pipe_ctx->plane_res.scl_data);
-				}
+						pipe_ctx->plane_res.scl_data.lb_params.alpha_en = pipe_ctx->plane_state->per_pixel_alpha;
+						ASSERT(pipe_ctx->plane_res.scl_data.lb_params.depth == LB_PIXEL_DEPTH_30BPP);
+						/* scaler configuration */
+						pipe_ctx->plane_res.dpp->funcs->dpp_set_scaler(
+						pipe_ctx->plane_res.dpp, &pipe_ctx->plane_res.scl_data);
+					}
 
-				if (pipe_ctx->update_flags.bits.viewport ||
+					if (pipe_ctx->update_flags.bits.viewport ||
 						(context == dc->current_state && plane_state->update_flags.bits.position_change) ||
 						(context == dc->current_state && plane_state->update_flags.bits.scaling_change) ||
 						(context == dc->current_state && pipe_ctx->stream->update_flags.bits.scaling)) {
 
-					hubp->funcs->mem_program_viewport(
+						hubp->funcs->mem_program_viewport(
 							hubp,
 							&pipe_ctx->plane_res.scl_data.viewport,
 							&pipe_ctx->plane_res.scl_data.viewport_c);
+					}
 				}
 			}
 		}
-
-		dc->hwss.interdependent_update_lock(dc, context, false);
-		dc->hwss.wait_for_pending_cleared(dc, context);
-	}
+	return mpcc_disconnected;
 }
 
 void dcn10_wait_for_pending_cleared(struct dc *dc,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
index 9a0f7a8a85cd..e5691e499023 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
@@ -194,7 +194,7 @@ void dcn10_get_surface_visual_confirm_color(
 void dcn10_get_hdr_visual_confirm_color(
 		struct pipe_ctx *pipe_ctx,
 		struct tg_color *color);
-void dcn10_disconnect_pipes(
+bool dcn10_disconnect_pipes(
 		struct dc *dc,
 		struct dc_state *context);
 
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index e9ef782e63a8..fa3005c2e37e 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -70,7 +70,7 @@ struct hw_sequencer_funcs {
 			int num_planes, struct dc_state *context);
 	void (*program_front_end_for_ctx)(struct dc *dc,
 			struct dc_state *context);
-	void (*disconnect_pipes)(struct dc *dc,
+	bool (*disconnect_pipes)(struct dc *dc,
 			struct dc_state *context);
 	void (*wait_for_pending_cleared)(struct dc *dc,
 			struct dc_state *context);
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

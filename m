Return-Path: <SRS0=oJVB=J2=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05EEC433B4
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:30 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E3F86145B
	for <amd-gfx@archiver.kernel.org>; Thu, 29 Apr 2021 07:54:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E3F86145B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9E6776ED74;
	Thu, 29 Apr 2021 07:54:29 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2083.outbound.protection.outlook.com [40.107.102.83])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCE756ED74
 for <amd-gfx@lists.freedesktop.org>; Thu, 29 Apr 2021 07:54:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fRhhIF1pEKhOlf3kJr3xytk0kVerYz0/Q6oYkl9X8qgRYg7e5IHcrJyplj1KhOOZNS2dXl1i7YV+dp26yOpxiIctSDNVv4NHcTGKyb5kLrThylwPqLyU/EKXX9U8MQaIwEomfKV/IqO7ZOS/jDEEJ/1DxkkEivwT++4SAFBpBsrfWe/T/MN8cWHSwBSBVrGyftLqZx+JDv/zxgNY7WeRs7T/No+UG3Fwa318igmZpVFZy38XMEpvWuboEf48ODX8gPZhBR/RSxN4ZX4LGVUTHK21IN7WWw+ts8a3MEoKMbpYEEMTEnKftrWej4aFAjzboBY5uAIT/deouxkDhCVu/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pmFkdpqJYSewiY3xzx7QDHRYpIFuPmQNuz9q1mlCHQ=;
 b=hi3GmMfM3EV6oZoOv9NZhRF+qAqh4gKbKlT7C3ce7lfUwgdD9/MPbWyCoMZDbGq4IkrgeYDK+5mNlnyjPDRKK0u9pDej0mZRslpfYmXF0Mix9TGBvcYBSikkLLMggY+uK0Ssj67Fu6RaJwe6kD6QFhCEU+hrGtXl+r8gTcUM3iYYZOwM9Ys47fOz5rGiRzFeEhFRL2Byi/3eK8sY9Lz/kg6ltWEwdbltzU3YJZAylrGV/3zwRURP6UCgEI810rWlFIkwExirAi+k9QbleyYk2FFKoXSA5hAzc5xFcwbzEPB3UihCwOniiD3hRGE4c7S4ZhJHFtc1DMBjpWurK6Qkiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8pmFkdpqJYSewiY3xzx7QDHRYpIFuPmQNuz9q1mlCHQ=;
 b=0MiNj8T7D8pU6lASVqYB1GA4wUx+Q1aOGpSp0OKcWx20+I32nyDA1B0wtp+WPA6jt2b/s+Kp9o9L+Shco0vtx5XmhPc0yAGQ7K0lS1AI6QuDlUOFuJPFOUph8YP/OCFSUtRYsm0EDL2pf+LeBwoQkzcZn71LPMczHEj9laQRuEA=
Received: from BN9PR03CA0240.namprd03.prod.outlook.com (2603:10b6:408:f8::35)
 by BN8PR12MB3618.namprd12.prod.outlook.com (2603:10b6:408:4a::27)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Thu, 29 Apr
 2021 07:54:25 +0000
Received: from BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:f8:cafe::db) by BN9PR03CA0240.outlook.office365.com
 (2603:10b6:408:f8::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend
 Transport; Thu, 29 Apr 2021 07:54:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT040.mail.protection.outlook.com (10.13.177.166) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4087.27 via Frontend Transport; Thu, 29 Apr 2021 07:54:25 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:25 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Thu, 29 Apr
 2021 02:54:24 -0500
Received: from wayne-System-Product-Name.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2242.4
 via Frontend Transport; Thu, 29 Apr 2021 02:54:22 -0500
From: Wayne Lin <Wayne.Lin@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 05/14] drm/amd/display: update DCN to use new surface
 programming
Date: Thu, 29 Apr 2021 15:51:57 +0800
Message-ID: <20210429075206.15974-6-Wayne.Lin@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210429075206.15974-1-Wayne.Lin@amd.com>
References: <20210429075206.15974-1-Wayne.Lin@amd.com>
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65a169a2-24d0-48e8-f770-08d90ae4022a
X-MS-TrafficTypeDiagnostic: BN8PR12MB3618:
X-Microsoft-Antispam-PRVS: <BN8PR12MB36184ED86A05B54E258E95FFFC5F9@BN8PR12MB3618.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0LS79cnG1+y5QhnbTDwEMx/1yRs521o6d6fr1OsyVEOJFvcn/1OeXz59qpNWV/sewvQujJEDiASnhL2nOpnWOBhL4G4cOVeyoiomzraUFqAtjXDqKqpq3bAgNKUKtV6e/+ot3u17493+kenSek4WhOo+QYEbsqDmZLCFESHBBRlcKc27AGyKQ2WStXZblwne97iw0zJp+9CuRpv+6BhjDAipYEV8b3GdLeGRMsf0v+rkHuK6XjA4B7uLdOVEoygqsxq6zAP48e0cFM27AEG/EGBeV9wmLoaVyaqJpoF5RIOffPMrvzz40pi15iTc8/Lm6KkznZjcH/cM1t1/u5YWUTUy4c/yzX7TrDSnYjQE4hOCwe2zK8+wD/jbfcDcw5mLPrb6EzwzLSgF0QG3ttM2aoMztARj87NGXHc57cxSsQG8zYvDnKs2fhGso6M12tGP6ILFVKKDlTfY+6flQg+rjqC27NBRyRDmL2TGD+LTWKNVr3lCeaOuzikcKMkt2MwsmKd6Euld0uhjRjo9eDyX4fdJfQcSo+u2HCAlAYU6E5XfAAeO6hwDGHrpMBzF5XtBZTNq251U5KWv0XUscdorDpejmi6dA6Zi7w5xO9VX1TDaS0vdAAB/ZKq2zqbbFKD8hiCYPkg7ZsKbEzH1Y3t6XxSU8xtW2VlDgkuIKTONFZs/JReSGQxiEjhn9xu4MHpC
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(36840700001)(46966006)(426003)(478600001)(82310400003)(4326008)(356005)(6916009)(86362001)(82740400003)(7696005)(26005)(36756003)(83380400001)(36860700001)(1076003)(5660300002)(186003)(336012)(8676002)(70586007)(70206006)(316002)(2906002)(15650500001)(81166007)(6666004)(2616005)(8936002)(54906003)(47076005)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 07:54:25.4387 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 65a169a2-24d0-48e8-f770-08d90ae4022a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT040.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3618
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
 Qingqing.Zhuo@amd.com, Rodrigo.Siqueira@amd.com, Anson.Jacob@amd.com,
 Aurabindo.Pillai@amd.com, Paul Hsieh <paul.hsieh@amd.com>,
 Bhawanpreet.Lakha@amd.com, bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Paul Hsieh <paul.hsieh@amd.com>

[Why]
The split pipe config is updated due to antoher stream bandwidth
validataion. Driver doesn't reprogram the split pipe config
to signle pipe cause SW use signel pipe but HW still use pipe split.

[How]
track global updates and update any hw that isn't
related to current stream being updated.

Signed-off-by: Paul Hsieh <paul.hsieh@amd.com>
Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Dmytro Laktyushkin <Dmytro.Laktyushkin@amd.com>
Acked-by: Wayne Lin <Wayne.Lin@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 155 ++----------------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |   5 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |   4 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |   6 +-
 4 files changed, 24 insertions(+), 146 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 7c939c0a977b..8c2d3d42d9da 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2956,35 +2956,6 @@ void dcn10_program_pipe(
 {
 	struct dce_hwseq *hws = dc->hwseq;
 
-	if (pipe_ctx->plane_state->update_flags.bits.full_update)
-		dcn10_enable_plane(dc, pipe_ctx, context);
-
-	dcn10_update_dchubp_dpp(dc, pipe_ctx, context);
-
-	hws->funcs.set_hdr_multiplier(pipe_ctx);
-
-	if (pipe_ctx->plane_state->update_flags.bits.full_update ||
-			pipe_ctx->plane_state->update_flags.bits.in_transfer_func_change ||
-			pipe_ctx->plane_state->update_flags.bits.gamma_change)
-		hws->funcs.set_input_transfer_func(dc, pipe_ctx, pipe_ctx->plane_state);
-
-	/* dcn10_translate_regamma_to_hw_format takes 750us to finish
-	 * only do gamma programming for full update.
-	 * TODO: This can be further optimized/cleaned up
-	 * Always call this for now since it does memcmp inside before
-	 * doing heavy calculation and programming
-	 */
-	if (pipe_ctx->plane_state->update_flags.bits.full_update)
-		hws->funcs.set_output_transfer_func(dc, pipe_ctx, pipe_ctx->stream);
-}
-
-static void dcn10_program_all_pipe_in_tree(
-		struct dc *dc,
-		struct pipe_ctx *pipe_ctx,
-		struct dc_state *context)
-{
-	struct dce_hwseq *hws = dc->hwseq;
-
 	if (pipe_ctx->top_pipe == NULL) {
 		bool blank = !is_pipe_tree_visible(pipe_ctx);
 
@@ -3004,35 +2975,26 @@ static void dcn10_program_all_pipe_in_tree(
 		hws->funcs.blank_pixel_data(dc, pipe_ctx, blank);
 	}
 
-	if (pipe_ctx->plane_state != NULL)
-		hws->funcs.program_pipe(dc, pipe_ctx, context);
-
-	if (pipe_ctx->bottom_pipe != NULL && pipe_ctx->bottom_pipe != pipe_ctx)
-		dcn10_program_all_pipe_in_tree(dc, pipe_ctx->bottom_pipe, context);
-}
-
-static struct pipe_ctx *dcn10_find_top_pipe_for_stream(
-		struct dc *dc,
-		struct dc_state *context,
-		const struct dc_stream_state *stream)
-{
-	int i;
+	if (pipe_ctx->plane_state->update_flags.bits.full_update)
+		dcn10_enable_plane(dc, pipe_ctx, context);
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-		struct pipe_ctx *old_pipe_ctx =
-				&dc->current_state->res_ctx.pipe_ctx[i];
+	dcn10_update_dchubp_dpp(dc, pipe_ctx, context);
 
-		if (!pipe_ctx->plane_state && !old_pipe_ctx->plane_state)
-			continue;
+	hws->funcs.set_hdr_multiplier(pipe_ctx);
 
-		if (pipe_ctx->stream != stream)
-			continue;
+	if (pipe_ctx->plane_state->update_flags.bits.full_update ||
+			pipe_ctx->plane_state->update_flags.bits.in_transfer_func_change ||
+			pipe_ctx->plane_state->update_flags.bits.gamma_change)
+		hws->funcs.set_input_transfer_func(dc, pipe_ctx, pipe_ctx->plane_state);
 
-		if (!pipe_ctx->top_pipe && !pipe_ctx->prev_odm_pipe)
-			return pipe_ctx;
-	}
-	return NULL;
+	/* dcn10_translate_regamma_to_hw_format takes 750us to finish
+	 * only do gamma programming for full update.
+	 * TODO: This can be further optimized/cleaned up
+	 * Always call this for now since it does memcmp inside before
+	 * doing heavy calculation and programming
+	 */
+	if (pipe_ctx->plane_state->update_flags.bits.full_update)
+		hws->funcs.set_output_transfer_func(dc, pipe_ctx, pipe_ctx->stream);
 }
 
 void dcn10_wait_for_pending_cleared(struct dc *dc,
@@ -3067,91 +3029,6 @@ void dcn10_wait_for_pending_cleared(struct dc *dc,
 		}
 }
 
-void dcn10_apply_ctx_for_surface(
-		struct dc *dc,
-		const struct dc_stream_state *stream,
-		int num_planes,
-		struct dc_state *context)
-{
-	struct dce_hwseq *hws = dc->hwseq;
-	int i;
-	struct timing_generator *tg;
-	uint32_t underflow_check_delay_us;
-	bool interdependent_update = false;
-	struct pipe_ctx *top_pipe_to_program =
-			dcn10_find_top_pipe_for_stream(dc, context, stream);
-	DC_LOGGER_INIT(dc->ctx->logger);
-
-	// Clear pipe_ctx flag
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-		pipe_ctx->update_flags.raw = 0;
-	}
-
-	if (!top_pipe_to_program)
-		return;
-
-	tg = top_pipe_to_program->stream_res.tg;
-
-	interdependent_update = top_pipe_to_program->plane_state &&
-		top_pipe_to_program->plane_state->update_flags.bits.full_update;
-
-	underflow_check_delay_us = dc->debug.underflow_assert_delay_us;
-
-	if (underflow_check_delay_us != 0xFFFFFFFF && hws->funcs.did_underflow_occur)
-		ASSERT(hws->funcs.did_underflow_occur(dc, top_pipe_to_program));
-
-	if (underflow_check_delay_us != 0xFFFFFFFF)
-		udelay(underflow_check_delay_us);
-
-	if (underflow_check_delay_us != 0xFFFFFFFF && hws->funcs.did_underflow_occur)
-		ASSERT(hws->funcs.did_underflow_occur(dc, top_pipe_to_program));
-
-	if (num_planes == 0) {
-		/* OTG blank before remove all front end */
-		hws->funcs.blank_pixel_data(dc, top_pipe_to_program, true);
-	}
-
-	/* Disconnect unused mpcc */
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-		struct pipe_ctx *old_pipe_ctx =
-				&dc->current_state->res_ctx.pipe_ctx[i];
-
-		if ((!pipe_ctx->plane_state ||
-		     pipe_ctx->stream_res.tg != old_pipe_ctx->stream_res.tg) &&
-		    old_pipe_ctx->plane_state &&
-		    old_pipe_ctx->stream_res.tg == tg) {
-
-			hws->funcs.plane_atomic_disconnect(dc, old_pipe_ctx);
-			pipe_ctx->update_flags.bits.disable = 1;
-
-			DC_LOG_DC("Reset mpcc for pipe %d\n",
-					old_pipe_ctx->pipe_idx);
-		}
-	}
-
-	if (num_planes > 0)
-		dcn10_program_all_pipe_in_tree(dc, top_pipe_to_program, context);
-
-	/* Program secondary blending tree and writeback pipes */
-	if ((stream->num_wb_info > 0) && (hws->funcs.program_all_writeback_pipes_in_tree))
-		hws->funcs.program_all_writeback_pipes_in_tree(dc, stream, context);
-	if (interdependent_update)
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[i];
-			/* Skip inactive pipes and ones already updated */
-			if (!pipe_ctx->stream || pipe_ctx->stream == stream ||
-			    !pipe_ctx->plane_state || !tg->funcs->is_tg_enabled(tg))
-				continue;
-
-			pipe_ctx->plane_res.hubp->funcs->hubp_setup_interdependent(
-				pipe_ctx->plane_res.hubp,
-				&pipe_ctx->dlg_regs,
-				&pipe_ctx->ttu_regs);
-		}
-}
-
 void dcn10_post_unlock_program_front_end(
 		struct dc *dc,
 		struct dc_state *context)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
index 37bec421fde8..c9bdffe5989b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
@@ -80,11 +80,6 @@ void dcn10_lock_all_pipes(
 		struct dc *dc,
 		struct dc_state *context,
 		bool lock);
-void dcn10_apply_ctx_for_surface(
-		struct dc *dc,
-		const struct dc_stream_state *stream,
-		int num_planes,
-		struct dc_state *context);
 void dcn10_post_unlock_program_front_end(
 		struct dc *dc,
 		struct dc_state *context);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
index d532c78ee764..680ca53455a2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
@@ -26,13 +26,15 @@
 #include "hw_sequencer_private.h"
 #include "dce110/dce110_hw_sequencer.h"
 #include "dcn10_hw_sequencer.h"
+#include "dcn20/dcn20_hwseq.h"
 
 static const struct hw_sequencer_funcs dcn10_funcs = {
 	.program_gamut_remap = dcn10_program_gamut_remap,
 	.init_hw = dcn10_init_hw,
 	.power_down_on_boot = dcn10_power_down_on_boot,
 	.apply_ctx_to_hw = dce110_apply_ctx_to_hw,
-	.apply_ctx_for_surface = dcn10_apply_ctx_for_surface,
+	.apply_ctx_for_surface = NULL,
+	.program_front_end_for_ctx = dcn20_program_front_end_for_ctx,
 	.post_unlock_program_front_end = dcn10_post_unlock_program_front_end,
 	.wait_for_pending_cleared = dcn10_wait_for_pending_cleared,
 	.update_plane_addr = dcn10_update_plane_addr,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 6a10daec15cc..484a30592987 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1700,7 +1700,11 @@ void dcn20_program_front_end_for_ctx(
 
 		if (pipe->plane_state && !pipe->top_pipe) {
 			while (pipe) {
-				dcn20_program_pipe(dc, pipe, context);
+				if (hws->funcs.program_pipe)
+					hws->funcs.program_pipe(dc, pipe, context);
+				else
+					dcn20_program_pipe(dc, pipe, context);
+
 				pipe = pipe->bottom_pipe;
 			}
 			/* Program secondary blending tree and writeback pipes */
-- 
2.17.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4513C43219
	for <amd-gfx@archiver.kernel.org>; Wed,  9 Nov 2022 06:17:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6575310E585;
	Wed,  9 Nov 2022 06:17:46 +0000 (UTC)
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam04on2054.outbound.protection.outlook.com [40.107.102.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E48410E58A
 for <amd-gfx@lists.freedesktop.org>; Wed,  9 Nov 2022 06:17:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CDTREupWcY/5lcMQY01+o+MIxTLqUcwO6OhMps1TEOOg2h18hv5Pn3OysoevYUarGf57+LyF2BwpntDO22hDV9wrDV8bWh+UdnQTMRGZlaGQguxdMM0AsVqe2By4ZibmZv2KLMafYt9bIZtWEO+scTjXJDP5FYh65M3QWCAvlxg7lBk7ndX+YfxZCdJW5LGsaV+5N7tGJp/F0zZfy020fCBXE1oKYGOa9CMCZuqQTjyBU/gklTT1MIF6+crD7X/+n5agCv187nQihqWDjh0Jn8acoooPaOJiktJSlMynq8KVPn0tXMSfjkZrrvsKPsZiXa4cA10i0LaaClSjFXDATA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xr9wAvsIbiFBftKgD7AROKi7z6XAAUPtQOyoMbnvZek=;
 b=hxuXwCRBsd7RII/uTVdh7FHAjNZqGEiPKcEQro33KnM6ujSbjBVj/Zwqo4XWU4wGT+OzQHxZzBZeIbig99JjzjFsl+BVuL4e6wJU+rxq10GvHJ0jPruG2oBqmlFI4k31015A6nDKlgPYwgG+HRb3prEHrO0omgFxpcU3dMRKtWU4QZe5JAh4DEgtkSykIZKKZdsBwMRa+LCA/c/qAkUF8yzrCbt9x4lhFW+D58HlykHjDckPLRkOxvaPiMT73tlhlumZmkRZ5FaCHZ/pjzgebSaIjJgJQJO1/bb0ePmpKTlDkeQNh+jFVA9QydcMVxq8hc1pv+P7rNU1BiI6R/t2Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xr9wAvsIbiFBftKgD7AROKi7z6XAAUPtQOyoMbnvZek=;
 b=ylwz+B4ahJYeGesug87FB4gCg5LYohHKvm0s+ijk3DYJskbh6+frtC9FnhQdDtGhZDdyJ9/7rAGR6QsO6xSyfPdarg2jy0DEarK+AEzrCZwfh/A70b6PrXMLTqFpykJpqyH4NvYUPALPpP5ys+45ZyvcXgglllbxNs62Mfw1H9k=
Received: from BN9PR03CA0632.namprd03.prod.outlook.com (2603:10b6:408:13b::7)
 by MN0PR12MB6319.namprd12.prod.outlook.com (2603:10b6:208:3c0::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.26; Wed, 9 Nov
 2022 06:17:36 +0000
Received: from BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:13b:cafe::7e) by BN9PR03CA0632.outlook.office365.com
 (2603:10b6:408:13b::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.27 via Frontend
 Transport; Wed, 9 Nov 2022 06:17:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN8NAM11FT099.mail.protection.outlook.com (10.13.177.197) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5813.12 via Frontend Transport; Wed, 9 Nov 2022 06:17:36 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 9 Nov
 2022 00:17:36 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Tue, 8 Nov
 2022 22:17:35 -0800
Received: from tom-HP.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.31 via Frontend
 Transport; Wed, 9 Nov 2022 00:17:31 -0600
From: Tom Chung <chiahsuan.chung@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 22/29] drm/amd/display: Fix Subvp phantom pipe transition
Date: Wed, 9 Nov 2022 14:13:12 +0800
Message-ID: <20221109061319.2870943-23-chiahsuan.chung@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
References: <20221109061319.2870943-1-chiahsuan.chung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8NAM11FT099:EE_|MN0PR12MB6319:EE_
X-MS-Office365-Filtering-Correlation-Id: 77311539-6388-409f-2252-08dac21a18c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VFMHsQfndbaiWZBxv8K+lSKqkB8VUAu4btH6Ei00N/hP2eu1ig3e89CqbsRZJrGqtdEhfzqVFkeuGWm/VhHij8Siq9EAKceH/s6zazKwRfBqWSgmwmi6LYSZ3j5fj/riPGMc1cb2seOJ/NsekOwtyKzik8Wj2FxhDNisKA27cmWQZp7W9am1JwiqFNX4b7noY8y7UGGV2tryHsYXKyLC4w4D8NnZnWEiQ4ZbpnFqgpI44U9TN3BDF8KyPZGZ//MrqCx6NDhDEfn2L2ZQ2NPM1E3ZYg2zwrFEwqpokw6TIQRM8k+CeLC7RTk3HqBpoT0cwYihfKUSIZuJfgoNQE33F0AezNK4mTzoXDPFnyKFQ0S3SM9npBCiqAvsTXDNqibqi8DdnCmhz9Ox1Y+XfXKz6Mhbz0e2KVe8yAdlu1VcIFgKYuIV1NYLvAkTU6bKGQji8AB9EGoX0VgV1rSMjiLupxpKUN3D3Lb0pVfACpiHDSnNSQ8zqTY7WcQK5uYCk3DdBplA2NUc6dwOsBBM1+lDxr86KAgBitpkd38KmrMSQUUnDy+cvMQfRfMI1BLfFUJ3VubIZUQTaK0x7Rl78PIpCRcU748lIArz3p/0Wt/kD1cDTSx9G/0ia7ifWSz98ii2RLERRk/wWq9u4HYeUIs+zLRUO4c50Fp2Cv/T51MHShphTIxbK++8Cl9FKRDJr4n6bfXB5gFJeVgK8iiyZ4OZumUzIJbMUsrKZNI5UC6aoHKUaduDMptGdtDEE8+0vmKXK/rX2bCIvE++5F3KRtBM1yWCQCBZQqmTP+bkTb/j576RR5lnb8bfmf46S77lYcXf
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230022)(4636009)(39860400002)(376002)(396003)(346002)(136003)(451199015)(36840700001)(40470700004)(46966006)(81166007)(36756003)(82740400003)(86362001)(356005)(6666004)(40460700003)(40480700001)(2906002)(7696005)(26005)(426003)(2616005)(1076003)(336012)(186003)(47076005)(83380400001)(36860700001)(8676002)(70206006)(6916009)(54906003)(82310400005)(478600001)(4326008)(316002)(8936002)(70586007)(5660300002)(41300700001)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2022 06:17:36.6413 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77311539-6388-409f-2252-08dac21a18c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT099.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6319
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
Cc: stylon.wang@amd.com, Tom Chung <chiahsuan.chung@amd.com>,
 Sunpeng.Li@amd.com, Harry.Wentland@amd.com, qingqing.zhuo@amd.com,
 Rodrigo.Siqueira@amd.com, roman.li@amd.com, solomon.chiu@amd.com,
 Aurabindo.Pillai@amd.com, Alvin Lee <Alvin.Lee2@amd.com>, wayne.lin@amd.com,
 Jun Lei <Jun.Lei@amd.com>, Bhawanpreet.Lakha@amd.com,
 agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alvin Lee <Alvin.Lee2@amd.com>

[Description]
- When transitioning a pipe in use (non-phantom) to become
  a phantom pipe, we must fully disable the pipe first before
  doing any phantom pipe programming
- Move phantom OTG enablement to after "regular" front-end
  programming sequence (including wait for vupdate)
- If a pipe is being transitioned into a phantom pipe,
  fully disable it first

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 54 +++++++++++++------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 38 +++++++------
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.c    | 27 ++++++++++
 .../drm/amd/display/dc/dcn32/dcn32_hwseq.h    |  2 +
 .../gpu/drm/amd/display/dc/dcn32/dcn32_init.c |  1 +
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  1 +
 6 files changed, 87 insertions(+), 36 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 0a252a65a678..1c3de3a1671e 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3408,22 +3408,6 @@ static void commit_planes_for_stream(struct dc *dc,
 		dc->hwss.pipe_control_lock(dc, top_pipe_to_program, true);
 	}
 
-	if (update_type != UPDATE_TYPE_FAST) {
-		for (i = 0; i < dc->res_pool->pipe_count; i++) {
-			struct pipe_ctx *new_pipe = &context->res_ctx.pipe_ctx[i];
-
-			if ((new_pipe->stream && new_pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) ||
-					subvp_prev_use) {
-				// If old context or new context has phantom pipes, apply
-				// the phantom timings now. We can't change the phantom
-				// pipe configuration safely without driver acquiring
-				// the DMCUB lock first.
-				dc->hwss.apply_ctx_to_hw(dc, context);
-				break;
-			}
-		}
-	}
-
 	dc_dmub_update_dirty_rect(dc, surface_count, stream, srf_updates, context);
 
 	if (update_type != UPDATE_TYPE_FAST) {
@@ -3652,6 +3636,44 @@ static void commit_planes_for_stream(struct dc *dc,
 					top_pipe_to_program->stream_res.tg);
 		}
 
+	/* For phantom pipe OTG enable, it has to be done after any previous pipe
+	 * that was in use has already been programmed at gotten its double buffer
+	 * update for "disable".
+	 */
+	if (update_type != UPDATE_TYPE_FAST) {
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+			struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+
+			/* If an active, non-phantom pipe is being transitioned into a phantom
+			 * pipe, wait for the double buffer update to complete first before we do
+			 * ANY phantom pipe programming.
+			 */
+			if (pipe->stream && pipe->stream->mall_stream_config.type == SUBVP_PHANTOM &&
+					old_pipe->stream && old_pipe->stream->mall_stream_config.type != SUBVP_PHANTOM) {
+				old_pipe->stream_res.tg->funcs->wait_for_state(
+						old_pipe->stream_res.tg,
+						CRTC_STATE_VBLANK);
+				old_pipe->stream_res.tg->funcs->wait_for_state(
+						old_pipe->stream_res.tg,
+						CRTC_STATE_VACTIVE);
+			}
+		}
+		for (i = 0; i < dc->res_pool->pipe_count; i++) {
+			struct pipe_ctx *new_pipe = &context->res_ctx.pipe_ctx[i];
+
+			if ((new_pipe->stream && new_pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) ||
+					subvp_prev_use) {
+				// If old context or new context has phantom pipes, apply
+				// the phantom timings now. We can't change the phantom
+				// pipe configuration safely without driver acquiring
+				// the DMCUB lock first.
+				dc->hwss.apply_ctx_to_hw(dc, context);
+				break;
+			}
+		}
+	}
+
 	if (update_type != UPDATE_TYPE_FAST)
 		dc->hwss.post_unlock_program_front_end(dc, context);
 	if (update_type != UPDATE_TYPE_FAST)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 64fcb378594f..3f3d4daa6294 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1310,6 +1310,19 @@ static void dcn20_detect_pipe_changes(struct pipe_ctx *old_pipe, struct pipe_ctx
 {
 	new_pipe->update_flags.raw = 0;
 
+	/* If non-phantom pipe is being transitioned to a phantom pipe,
+	 * set disable and return immediately. This is because the pipe
+	 * that was previously in use must be fully disabled before we
+	 * can "enable" it as a phantom pipe (since the OTG will certainly
+	 * be different). The post_unlock sequence will set the correct
+	 * update flags to enable the phantom pipe.
+	 */
+	if (old_pipe->plane_state && !old_pipe->plane_state->is_phantom &&
+			new_pipe->plane_state && new_pipe->plane_state->is_phantom) {
+		new_pipe->update_flags.bits.disable = 1;
+		return;
+	}
+
 	/* Exit on unchanged, unused pipe */
 	if (!old_pipe->plane_state && !new_pipe->plane_state)
 		return;
@@ -1882,26 +1895,6 @@ void dcn20_post_unlock_program_front_end(
 		}
 	}
 
-	for (i = 0; i < dc->res_pool->pipe_count; i++) {
-		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
-		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
-
-		/* If an active, non-phantom pipe is being transitioned into a phantom
-		 * pipe, wait for the double buffer update to complete first before we do
-		 * phantom pipe programming (HUBP_VTG_SEL updates right away so that can
-		 * cause issues).
-		 */
-		if (pipe->stream && pipe->stream->mall_stream_config.type == SUBVP_PHANTOM &&
-				old_pipe->stream && old_pipe->stream->mall_stream_config.type != SUBVP_PHANTOM) {
-			old_pipe->stream_res.tg->funcs->wait_for_state(
-					old_pipe->stream_res.tg,
-					CRTC_STATE_VBLANK);
-			old_pipe->stream_res.tg->funcs->wait_for_state(
-					old_pipe->stream_res.tg,
-					CRTC_STATE_VACTIVE);
-		}
-	}
-
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
 
@@ -1913,6 +1906,11 @@ void dcn20_post_unlock_program_front_end(
 			 */
 			while (pipe) {
 				if (pipe->stream && pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
+					/* When turning on the phantom pipe we want to run through the
+					 * entire enable sequence, so apply all the "enable" flags.
+					 */
+					if (dc->hwss.apply_update_flags_for_phantom)
+						dc->hwss.apply_update_flags_for_phantom(pipe);
 					if (dc->hwss.update_phantom_vp_position)
 						dc->hwss.update_phantom_vp_position(dc, context, pipe);
 					dcn20_program_pipe(dc, pipe, context);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
index 7eb47ea9d4bb..763311ffb967 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.c
@@ -1366,6 +1366,33 @@ void dcn32_update_phantom_vp_position(struct dc *dc,
 	}
 }
 
+/* Treat the phantom pipe as if it needs to be fully enabled.
+ * If the pipe was previously in use but not phantom, it would
+ * have been disabled earlier in the sequence so we need to run
+ * the full enable sequence.
+ */
+void dcn32_apply_update_flags_for_phantom(struct pipe_ctx *phantom_pipe)
+{
+	phantom_pipe->update_flags.raw = 0;
+	if (phantom_pipe->stream && phantom_pipe->stream->mall_stream_config.type == SUBVP_PHANTOM) {
+		if (phantom_pipe->stream && phantom_pipe->plane_state) {
+			phantom_pipe->update_flags.bits.enable = 1;
+			phantom_pipe->update_flags.bits.mpcc = 1;
+			phantom_pipe->update_flags.bits.dppclk = 1;
+			phantom_pipe->update_flags.bits.hubp_interdependent = 1;
+			phantom_pipe->update_flags.bits.hubp_rq_dlg_ttu = 1;
+			phantom_pipe->update_flags.bits.gamut_remap = 1;
+			phantom_pipe->update_flags.bits.scaler = 1;
+			phantom_pipe->update_flags.bits.viewport = 1;
+			phantom_pipe->update_flags.bits.det_size = 1;
+			if (!phantom_pipe->top_pipe && !phantom_pipe->prev_odm_pipe) {
+				phantom_pipe->update_flags.bits.odm = 1;
+				phantom_pipe->update_flags.bits.global_sync = 1;
+			}
+		}
+	}
+}
+
 bool dcn32_dsc_pg_status(
 		struct dce_hwseq *hws,
 		unsigned int dsc_inst)
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
index ac3657a5b9ea..7de36529cf99 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_hwseq.h
@@ -92,6 +92,8 @@ void dcn32_update_phantom_vp_position(struct dc *dc,
 		struct dc_state *context,
 		struct pipe_ctx *phantom_pipe);
 
+void dcn32_apply_update_flags_for_phantom(struct pipe_ctx *phantom_pipe);
+
 bool dcn32_dsc_pg_status(
 		struct dce_hwseq *hws,
 		unsigned int dsc_inst);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
index 45a949ba6f3f..dc4649458567 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_init.c
@@ -110,6 +110,7 @@ static const struct hw_sequencer_funcs dcn32_funcs = {
 	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
 	.update_phantom_vp_position = dcn32_update_phantom_vp_position,
 	.update_dsc_pg = dcn32_update_dsc_pg,
+	.apply_update_flags_for_phantom = dcn32_apply_update_flags_for_phantom,
 };
 
 static const struct hwseq_private_funcs dcn32_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index d04b68dad413..c43523f9ff6d 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -263,6 +263,7 @@ struct hw_sequencer_funcs {
 	void (*update_phantom_vp_position)(struct dc *dc,
 			struct dc_state *context,
 			struct pipe_ctx *phantom_pipe);
+	void (*apply_update_flags_for_phantom)(struct pipe_ctx *phantom_pipe);
 
 	void (*commit_subvp_config)(struct dc *dc, struct dc_state *context);
 	void (*subvp_pipe_control_lock)(struct dc *dc,
-- 
2.25.1


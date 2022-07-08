Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 867CBC43334
	for <amd-gfx@archiver.kernel.org>; Fri,  8 Jul 2022 16:36:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1054110E1E4;
	Fri,  8 Jul 2022 16:36:14 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2048.outbound.protection.outlook.com [40.107.101.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47C6510E1E4
 for <amd-gfx@lists.freedesktop.org>; Fri,  8 Jul 2022 16:36:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WghBN9Z/9espZm68wGDM2SFtRBCGb9emBFESFEK9jmf+f86yRTYRcT+iWMfFTyl2CTJR+waZV5TDuPf6BW20zAdrxWQYU1bXvs5CyHE13tb+dd3GT8guIQffZuJipWa1NiNI5bzk0n41A64+SL9vyCYOzyYuysBtO0MZVG1zzk7Kgi339P1B2FgEXC/SOAfylTMJtaKJRAqA72v8hxhLSZQ2dOFDc0uTnTLAmroN6qwXlyZcBUJRtJgP13ro+CgkTbv0KJVU34sDpVvtupPvpLy1iTUKw8VlwDwXJwH5k78q8BM8B11uyokGGMbfg9OvmZFjcqrp6LwzWgpVNJQ0Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KzhwMgQZdciXq1vOdYF5Fz+rXni54uHFJ1VyFCtmizg=;
 b=PJ7hRTXibVNZFKNAfljEkGbIcs8A3XGs7Hht1TM2zXUilPp+AaR0U5WNwezXwMk3dsyRpDIQ01GIdzx5w2SNPUw3W13xO+K22XUc34c33/aYYW1+SsoaGt5ccrOYP6uGmh0rJcHU5+33pj1nGjho5qoDewcQtPcGVJLODfDZT56R85lzY+kWwgiDtap6hdNQcVbiVaklvQ/EvyuNIBCUDWlMWe04bhLgYBb4ZUNHply2OdDcN7tOduqQ1W5NVYFwAJ9Pl0udp0U0R6LInLLqlc/6FHocXHWQ2Bx1Ij2TI8Y5JFpSzQxGdvs++GjsLnhxDFD+v6rbrJwZvAcmu/UCeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KzhwMgQZdciXq1vOdYF5Fz+rXni54uHFJ1VyFCtmizg=;
 b=uxCqOjLmBw4OKgwFkeMft9oCsMRaSooJ6zYfDsA/qdOmxg1w+tBpM4XuktShcEBboPGMIDgSWhgCrMqLK0hfPcmj2s9vLArhGWCZqXyYBpwJS3vZkz6jQfotSL7Sh/c1QZQcMDe2lal2mZE3EhS3RBvbEbHwFTcO3V9qoIAS6GU=
Received: from MW4PR04CA0167.namprd04.prod.outlook.com (2603:10b6:303:85::22)
 by MN2PR12MB4046.namprd12.prod.outlook.com (2603:10b6:208:1da::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20; Fri, 8 Jul
 2022 16:36:10 +0000
Received: from CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
 (2603:10b6:303:85:cafe::f9) by MW4PR04CA0167.outlook.office365.com
 (2603:10b6:303:85::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.20 via Frontend
 Transport; Fri, 8 Jul 2022 16:36:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CO1NAM11FT003.mail.protection.outlook.com (10.13.175.93) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5417.15 via Frontend Transport; Fri, 8 Jul 2022 16:36:10 +0000
Received: from ryzen32.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Fri, 8 Jul
 2022 11:36:04 -0500
From: Solomon Chiu <solomon.chiu@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 01/21] drm/amd/display: Exit SubVP if MPO in use
Date: Sat, 9 Jul 2022 00:35:09 +0800
Message-ID: <20220708163529.3534276-2-solomon.chiu@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220708163529.3534276-1-solomon.chiu@amd.com>
References: <20220708163529.3534276-1-solomon.chiu@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc9fe45d-ffee-49b3-9647-08da60fff6f2
X-MS-TrafficTypeDiagnostic: MN2PR12MB4046:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: N4LjthHkpqUkCEmfz2T7dIcEMJa2lV2Hyy89ukeLidYifrELqVGywt2o4pjeybz7YwFOAEzeDE35uKR7kdrFPM6nYluwHxDaKzS/0s+qsvBZm3pj9FdZIJCFaD4PrxVRLJhrtegGRTpbcgajlwlhHQ3TehIpei5+2DQYl7BwGhvVNC+bui35LkuKPLizToDDLc/RnBN33v1VvGGWPWv3Gs4Fb7jH5zB4GKGE0fbWQysKpDjhqYLR+aQvTchCy0GJv7tmHFr1TiuprxgPf4c53O8tO7dlFCNo+NfS8HXsppSnlyg7bWXnzuMGT88SIirUfW4zPkq1mYGoDUKs4k+O2zOE3M9XSzLIelDwFC7MDdzUR9qgsYquJZIbLULnOttSaL97AN5f8fC1tNz1JlC+jD0Nt6iLXUVPeT9dBHlBlx+T8dVWG1hoxQO5sMR67ykwo3BDMx8I+CA9sOD4X7FHGJt9s4vtSvhMzbmGvjsj1JAa659Kzb8MLgwoVj283fTzJg6agqpUFzTvJPYy6sLnVFl6GWm6FlUf/wIvgGonmiHAtjuiMLInC5a5V9DyJX4t8sqlhQ7W51qr5OlZ5ZMfJ2CtgzQKYEmv7DLsugOmn5jrN+0MHvredlU29jvQTXggewDKe+rhQU3c1W89rGWxvBc/m+H9r9+CfiC7C/EjYL+GxIK9ZsnkHDKLM9JziIuXguYsRKTt0J7xF3CI8s+Pil6jlZSuFQSpC45BaX5KgZNYU1WurekCcm139DY8wI8Cazs8yGnT0zoA1hmeMlvtCETPbg3buniFfzAnEEKrIngwEOT0jAu4bQPKLNz30icXfINMv9Caq30oG9XOhA9c0PF1iRdmKo/js71SrAKx9vitOuz8vslSTmwrjOWMndMk
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230016)(4636009)(376002)(346002)(396003)(136003)(39860400002)(40470700004)(46966006)(36840700001)(1076003)(426003)(81166007)(82740400003)(4326008)(47076005)(8676002)(2616005)(26005)(5660300002)(336012)(356005)(186003)(70586007)(7696005)(478600001)(41300700001)(70206006)(16526019)(82310400005)(86362001)(6916009)(54906003)(2906002)(40460700003)(36860700001)(36756003)(34020700004)(316002)(83380400001)(8936002)(30864003)(40480700001)(44832011)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2022 16:36:10.0491 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc9fe45d-ffee-49b3-9647-08da60fff6f2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT003.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4046
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
 solomon.chiu@amd.com, Aurabindo.Pillai@amd.com, "Lee,
 Alvin" <Alvin.Lee2@amd.com>, wayne.lin@amd.com, Jun Lei <Jun.Lei@amd.com>,
 Bhawanpreet.Lakha@amd.com, agustin.gutierrez@amd.com, pavle.kotarac@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: "Lee, Alvin" <Alvin.Lee2@amd.com>

[Description]
Exit SubVP if MPO is in use since SubVP + MPO together is not supported.
- Don't add SubVP at validation time if we see MPO is in use

Issues fixed in the SubVP / MPO transition:
1. Enable phantom pipes in post unlock function to prevent underflow
when an active pipe is being transitioned to be a phantom pipe (VTG
updates take place right away). Also must wait for VUPDATE of the main
pipe to complete first

2. Don't wait for MPCC idle when transitioning a phantom pipe to an
actual pipe. MPCC_STATUS is never asserted due to OTG being off for
phantom pipes

3. When transitioning an active pipe to phantom, program DET right away
(same as disabling the pipe) or the DET update will only take when
the phantom pipe is enabled which can cause DET allocation errors.

4. For K1/K2 programming of phantom pipes, use same settings as the
main pipe. Also don't program K1 / K2 = 0xF ever since the field is only
1 / 2 bits wide.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Solomon Chiu <solomon.chiu@amd.com>
Signed-off-by: Alvin Lee <Alvin.Lee2@amd.com>
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      | 27 +++++--
 drivers/gpu/drm/amd/display/dc/dc.h           |  2 +
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c |  4 +-
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 72 +++++++++++++++++--
 4 files changed, 92 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 89a2f6749239..e13bf66f70e0 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3208,15 +3208,21 @@ static void commit_planes_for_stream(struct dc *dc,
 
 		if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
 			dc->hwss.interdependent_update_lock(dc, context, false);
+		} else {
+			dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
+		}
+		dc->hwss.post_unlock_program_front_end(dc, context);
+
+		/* Since phantom pipe programming is moved to post_unlock_program_front_end,
+		 * move the SubVP lock to after the phantom pipes have been setup
+		 */
+		if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
 			if (dc->hwss.subvp_pipe_control_lock)
 				dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, NULL, subvp_prev_use);
 		} else {
-			dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
 			if (dc->hwss.subvp_pipe_control_lock)
 				dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, NULL, subvp_prev_use);
 		}
-
-		dc->hwss.post_unlock_program_front_end(dc, context);
 		return;
 	}
 
@@ -3346,12 +3352,8 @@ static void commit_planes_for_stream(struct dc *dc,
 
 		if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
 			dc->hwss.interdependent_update_lock(dc, context, false);
-			if (dc->hwss.subvp_pipe_control_lock)
-				dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, NULL, subvp_prev_use);
 		} else {
 			dc->hwss.pipe_control_lock(dc, top_pipe_to_program, false);
-			if (dc->hwss.subvp_pipe_control_lock)
-				dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, top_pipe_to_program, subvp_prev_use);
 		}
 
 	if ((update_type != UPDATE_TYPE_FAST) && stream->update_flags.bits.dsc_changed)
@@ -3385,6 +3387,17 @@ static void commit_planes_for_stream(struct dc *dc,
 	if (update_type != UPDATE_TYPE_FAST)
 		dc->hwss.post_unlock_program_front_end(dc, context);
 
+		/* Since phantom pipe programming is moved to post_unlock_program_front_end,
+		 * move the SubVP lock to after the phantom pipes have been setup
+		 */
+		if (should_lock_all_pipes && dc->hwss.interdependent_update_lock) {
+			if (dc->hwss.subvp_pipe_control_lock)
+				dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, NULL, subvp_prev_use);
+		} else {
+			if (dc->hwss.subvp_pipe_control_lock)
+				dc->hwss.subvp_pipe_control_lock(dc, context, false, should_lock_all_pipes, top_pipe_to_program, subvp_prev_use);
+		}
+
 	// Fire manual trigger only when bottom plane is flipped
 	for (j = 0; j < dc->res_pool->pipe_count; j++) {
 		struct pipe_ctx *pipe_ctx = &context->res_ctx.pipe_ctx[j];
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 02bbc90a2c80..a0812849794e 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -1065,6 +1065,8 @@ struct dc_plane_state {
 	/* HACK: Workaround for forcing full reprogramming under some conditions */
 	bool force_full_update;
 
+	bool is_phantom; // TODO: Change mall_stream_config into mall_plane_config instead
+
 	/* private to dc_surface.c */
 	enum dc_irq_source irq_source;
 	struct kref refcount;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 029deb81fcfa..7a3812604e4b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -1155,7 +1155,9 @@ void dcn10_plane_atomic_disconnect(struct dc *dc, struct pipe_ctx *pipe_ctx)
 		return;
 
 	mpc->funcs->remove_mpcc(mpc, mpc_tree_params, mpcc_to_remove);
-	if (opp != NULL)
+	// Phantom pipes have OTG disabled by default, so MPCC_STATUS will never assert idle,
+	// so don't wait for MPCC_IDLE in the programming sequence
+	if (opp != NULL && !pipe_ctx->plane_state->is_phantom)
 		opp->mpcc_disconnect_pending[pipe_ctx->plane_res.mpcc_inst] = true;
 
 	dc->optimized_required = true;
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 2286cc34e9cc..3b26962637d0 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1317,6 +1317,13 @@ static void dcn20_detect_pipe_changes(struct pipe_ctx *old_pipe, struct pipe_ctx
 	if (new_pipe->stream && new_pipe->stream->mall_stream_config.type == SUBVP_PHANTOM)
 		new_pipe->update_flags.bits.enable = 1;
 
+	/* Phantom pipes are effectively disabled, if the pipe was previously phantom
+	 * we have to enable
+	 */
+	if (old_pipe->plane_state && old_pipe->plane_state->is_phantom &&
+			new_pipe->plane_state && !new_pipe->plane_state->is_phantom)
+		new_pipe->update_flags.bits.enable = 1;
+
 	if (old_pipe->plane_state && !new_pipe->plane_state) {
 		new_pipe->update_flags.bits.disable = 1;
 		return;
@@ -1751,7 +1758,14 @@ void dcn20_program_front_end_for_ctx(
 				|| context->res_ctx.pipe_ctx[i].update_flags.bits.opp_changed) {
 			struct hubbub *hubbub = dc->res_pool->hubbub;
 
-			if (hubbub->funcs->program_det_size && context->res_ctx.pipe_ctx[i].update_flags.bits.disable)
+			/* Phantom pipe DET should be 0, but if a pipe in use is being transitioned to phantom
+			 * then we want to do the programming here (effectively it's being disabled). If we do
+			 * the programming later the DET won't be updated until the OTG for the phantom pipe is
+			 * turned on (i.e. in an MCLK switch) which can come in too late and cause issues with
+			 * DET allocation.
+			 */
+			if (hubbub->funcs->program_det_size && (context->res_ctx.pipe_ctx[i].update_flags.bits.disable ||
+					(context->res_ctx.pipe_ctx[i].plane_state && context->res_ctx.pipe_ctx[i].plane_state->is_phantom)))
 				hubbub->funcs->program_det_size(hubbub, dc->current_state->res_ctx.pipe_ctx[i].plane_res.hubp->inst, 0);
 			hws->funcs.plane_atomic_disconnect(dc, &dc->current_state->res_ctx.pipe_ctx[i]);
 			DC_LOG_DC("Reset mpcc for pipe %d\n", dc->current_state->res_ctx.pipe_ctx[i].pipe_idx);
@@ -1768,8 +1782,17 @@ void dcn20_program_front_end_for_ctx(
 			while (pipe) {
 				if (hws->funcs.program_pipe)
 					hws->funcs.program_pipe(dc, pipe, context);
-				else
-					dcn20_program_pipe(dc, pipe, context);
+				else {
+					/* Don't program phantom pipes in the regular front end programming sequence.
+					 * There is an MPO transition case where a pipe being used by a video plane is
+					 * transitioned directly to be a phantom pipe when closing the MPO video. However
+					 * the phantom pipe will program a new HUBP_VTG_SEL (update takes place right away),
+					 * but the MPO still exists until the double buffered update of the main pipe so we
+					 * will get a frame of underflow if the phantom pipe is programmed here.
+					 */
+					if (pipe->stream && pipe->stream->mall_stream_config.type != SUBVP_PHANTOM)
+						dcn20_program_pipe(dc, pipe, context);
+				}
 
 				pipe = pipe->bottom_pipe;
 			}
@@ -1793,8 +1816,6 @@ void dcn20_program_front_end_for_ctx(
 			pipe->plane_res.hubp->funcs->hubp_wait_pipe_read_start(pipe->plane_res.hubp);
 		}
 	}
-	if (hws->funcs.program_mall_pipe_config)
-		hws->funcs.program_mall_pipe_config(dc, context);
 }
 
 void dcn20_post_unlock_program_front_end(
@@ -1848,6 +1869,47 @@ void dcn20_post_unlock_program_front_end(
 					dc->hwss.disable_plane(dc, &dc->current_state->res_ctx.pipe_ctx[i]);
 		}
 	}
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *old_pipe = &dc->current_state->res_ctx.pipe_ctx[i];
+
+		/* If an active, non-phantom pipe is being transitioned into a phantom
+		 * pipe, wait for the double buffer update to complete first before we do
+		 * phantom pipe programming (HUBP_VTG_SEL updates right away so that can
+		 * cause issues).
+		 */
+		if (pipe->stream && pipe->stream->mall_stream_config.type == SUBVP_PHANTOM &&
+				old_pipe->stream && old_pipe->stream->mall_stream_config.type != SUBVP_PHANTOM) {
+			old_pipe->stream_res.tg->funcs->wait_for_state(
+					old_pipe->stream_res.tg,
+					CRTC_STATE_VBLANK);
+			old_pipe->stream_res.tg->funcs->wait_for_state(
+					old_pipe->stream_res.tg,
+					CRTC_STATE_VACTIVE);
+		}
+	}
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+
+		if (pipe->plane_state && !pipe->top_pipe) {
+			/* Program phantom pipe here to prevent a frame of underflow in the MPO transition
+			 * case (if a pipe being used for a video plane transitions to a phantom pipe, it
+			 * can underflow due to HUBP_VTG_SEL programming if done in the regular front end
+			 * programming sequence).
+			 */
+			if (pipe->stream && pipe->stream->mall_stream_config.type == SUBVP_PHANTOM)
+					dcn20_program_pipe(dc, pipe, context);
+		}
+	}
+
+	/* Only program the MALL registers after all the main and phantom pipes
+	 * are done programming.
+	 */
+	if (hwseq->funcs.program_mall_pipe_config)
+		hwseq->funcs.program_mall_pipe_config(dc, context);
+
 	/* WA to apply WM setting*/
 	if (hwseq->wa.DEGVIDCN21)
 		dc->res_pool->hubbub->funcs->apply_DEDCN21_147_wa(dc->res_pool->hubbub);
-- 
2.25.1


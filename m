Return-Path: <SRS0=kbWR=KQ=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D78C47076
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:24 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CA9B611AB
	for <amd-gfx@archiver.kernel.org>; Fri, 21 May 2021 17:37:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CA9B611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C413B6E5BE;
	Fri, 21 May 2021 17:37:23 +0000 (UTC)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2076.outbound.protection.outlook.com [40.107.93.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8B776E52D
 for <amd-gfx@lists.freedesktop.org>; Fri, 21 May 2021 17:37:12 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gORkal9aC6z+Aq6ohalugUpAV9/xB6a0Kd3KYmT9TmJ774upxZmjYOAjRuav3XIJY+eNBxFP6reFVLQZel0Kb0s2Cj0FY9xGSzJQclMlZJ7J2u//ApIBffENf5npzYOqcAyILp8kaoJ4l+IpxH+3hGWhTRFZqY2f5sKcPA08Cg7Sjv61oH9T5vQ5FA7GEbLhnBiqW2f3t3NpJwva8q/dwN9HXpUXxJHR4qvshs/Az7eyjCMFKaMUsmJmIyyKcTxdVEIbtfay45Dae2wdPOWj9LSoQlTIFuHoUErsxv9EOe93pDZnMNfCkt6+CvJ2G33rXqmwHbhG1vJpgRKKph1GVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGm/cYy/LCg+aCRqWc5VzX2jw9GkTnbRXhMQLWjz7zg=;
 b=aroq/HQDsYMQQRFnldq2W4rJ57v135mVYQMJ9LVnjj5aRNthsTCmbR5fLxusLB0t8eeSzacrSsxALODcsb+1kNCLtgR+fcVDg0jc55ghY3Q+i9T0Gh+hq7UVWJ131zU8UeFdFoPlB01RI+t0vIpkK8TQjsj2BWfIl73uwC0Rlcpy00fRvCHSr+g/0DfQTwMm//yXrlXbWCdF/GX0GKJZukIQe8R22izUpFeZjTbMf16mYi8c20GEGSK3c5V4Zdtgo59NkJ+0g0lR2iWBVKXHsfKhXsT7uGg5v33N0MhUgGPteKz+2nJJURWHO9f2FkEIn+9pMVAkafVSp6k0B5UOCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com; 
 dmarc=pass (p=none sp=none pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TGm/cYy/LCg+aCRqWc5VzX2jw9GkTnbRXhMQLWjz7zg=;
 b=hQ+890GjSMxFyVpkEvDBhN5KY5ENa6dcS/QrNCN6Wu+aq5z14pF7tY5U5/Z4JEqxFTqheTIsyauZXUmQpOMm+LpQAtPMMy7Ay44pACA6qMU0YRr1qHnoUm5XIiPwNDOhuveaJY4FPv90/b4VC7IprEUXVs87Z0NXshBZLpkIit8=
Received: from BN6PR1101CA0006.namprd11.prod.outlook.com
 (2603:10b6:405:4a::16) by BN8PR12MB3603.namprd12.prod.outlook.com
 (2603:10b6:408:4a::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.26; Fri, 21 May
 2021 17:37:10 +0000
Received: from BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
 (2603:10b6:405:4a:cafe::ad) by BN6PR1101CA0006.outlook.office365.com
 (2603:10b6:405:4a::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4150.23 via Frontend
 Transport; Fri, 21 May 2021 17:37:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=pass action=none
 header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com;
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN8NAM11FT059.mail.protection.outlook.com (10.13.177.120) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.4129.25 via Frontend Transport; Fri, 21 May 2021 17:37:10 +0000
Received: from localhost.localdomain (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2242.4; Fri, 21 May
 2021 12:37:09 -0500
From: Qingqing Zhuo <qingqing.zhuo@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH 15/15] Revert "drm/amd/display: Refactor and add visual
 confirm for HW Flip Queue"
Date: Fri, 21 May 2021 13:36:46 -0400
Message-ID: <20210521173646.1140586-16-qingqing.zhuo@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
References: <20210521173646.1140586-1-qingqing.zhuo@amd.com>
MIME-Version: 1.0
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 832e31c6-8e7a-4503-8f63-08d91c7f1037
X-MS-TrafficTypeDiagnostic: BN8PR12MB3603:
X-Microsoft-Antispam-PRVS: <BN8PR12MB36039E995D5F026C334C92F2FB299@BN8PR12MB3603.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1227;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VHESjuqSORSlwxZPF1aCaVRzUXA/pxhy2xHN65twpmzDfYpc3VQnt9lYShwvwZWfE4WstMwpatsraVrabGcl2elCaSp7dhhy9jSaW/Vsn5EyFI2tSPA6hf2DoaaWiymRm6+N6fTbBxP40bxZy/oA3znBaEfZ3xVRyhU357yTLuKVHutXwwVq48lvfQRGPmeLw2LpqsPhTXdk5A5TVMWSou2YjWO96f4O9aFQWVpW81BCNVshsv34NP0UInk+fxFmDIYg/NzGYe0vexXNaHSZFEYo5rXbls0fDXSY2FNr6KsIt+ilLjSES4yak68ddNeMC+lKntrghh7PaeDddsC3on5/n2xhYmCoRJqJ7xzLSKZEK1642DYpkTOyoRSwu65UnIqEqivryiG+Yj3HHAcN+pNGTojC26bddExdPdgWzM9OeM1n66tG8Y3yUZFFKg+9xg6H4EQf3hRguwjtYNXSS99p8NF1pFS4EOcoglAtRDli89VyHTS1f4zOA3UAo+lHF8pgf+D9LzaZrjUq9B8PnVkhFgY1Yvin9npauJRhn3htwsqNfXoYrgE8JifknJ/8pwSGEGr90rekYyEZ1NeVbUF+o27vUbyYOYCzmcJrCc6PDhtl35UIdWGtUE9w7aKVVOsJRwFEvo7qMbMvBK2VaH2SXAPXEbvnjsb1V2zIIFfp9Tf8j31cdSzSwTevjD3k
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB04.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(4636009)(346002)(39850400004)(396003)(376002)(136003)(36840700001)(46966006)(316002)(4326008)(6916009)(2906002)(86362001)(2616005)(81166007)(70206006)(356005)(26005)(5660300002)(8676002)(70586007)(478600001)(36756003)(1076003)(336012)(8936002)(82740400003)(83380400001)(36860700001)(54906003)(30864003)(426003)(47076005)(82310400003)(6666004)(16526019)(44832011)(186003)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2021 17:37:10.7707 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 832e31c6-8e7a-4503-8f63-08d91c7f1037
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT059.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR12MB3603
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
 qingqing.zhuo@amd.com, Rodrigo.Siqueira@amd.com, roman.li@amd.com,
 Anson.Jacob@amd.com, Aurabindo.Pillai@amd.com, Bhawanpreet.Lakha@amd.com,
 bindu.r@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit 5791d219561cb661c991332a4f0bca6a8c8db080.

Recent visual confirm changes are regressing the driver, causing a
black screen on boot in some green sardine configs, or visual confirm
is not updated at all.

Signed-off-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 31 +++++++------------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |  6 ----
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |  1 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c  |  5 ---
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 28 ++++++-----------
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.h    |  5 ---
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  1 -
 .../gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c  |  2 +-
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  1 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  1 -
 .../gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c  |  2 +-
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |  1 -
 drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h   |  3 --
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  4 ---
 14 files changed, 23 insertions(+), 68 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 85a947015945..8f11e2b58cd7 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2502,23 +2502,6 @@ static void dcn10_update_dpp(struct dpp *dpp, struct dc_plane_state *plane_state
 		dpp->funcs->dpp_program_bias_and_scale(dpp, &bns_params);
 }
 
-void dcn10_update_visual_confirm_color(struct dc *dc, struct pipe_ctx *pipe_ctx, struct tg_color *color, int mpcc_id)
-{
-	struct dce_hwseq *hws = dc->hwseq;
-	struct mpc *mpc = dc->res_pool->mpc;
-
-	if (dc->debug.visual_confirm == VISUAL_CONFIRM_HDR)
-		hws->funcs.get_hdr_visual_confirm_color(pipe_ctx, color);
-	else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SURFACE)
-		hws->funcs.get_surface_visual_confirm_color(pipe_ctx, color);
-	else
-		color_space_to_black_color(
-				dc, pipe_ctx->stream->output_color_space, color);
-
-	if (mpc->funcs->set_bg_color)
-		mpc->funcs->set_bg_color(mpc, color, mpcc_id);
-}
-
 void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
 	struct dce_hwseq *hws = dc->hwseq;
@@ -2530,6 +2513,18 @@ void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	struct mpc *mpc = dc->res_pool->mpc;
 	struct mpc_tree *mpc_tree_params = &(pipe_ctx->stream_res.opp->mpc_tree_params);
 
+	if (dc->debug.visual_confirm == VISUAL_CONFIRM_HDR) {
+		hws->funcs.get_hdr_visual_confirm_color(
+				pipe_ctx, &blnd_cfg.black_color);
+	} else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SURFACE) {
+		hws->funcs.get_surface_visual_confirm_color(
+				pipe_ctx, &blnd_cfg.black_color);
+	} else {
+		color_space_to_black_color(
+				dc, pipe_ctx->stream->output_color_space,
+				&blnd_cfg.black_color);
+	}
+
 	if (per_pixel_alpha)
 		blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA;
 	else
@@ -2561,8 +2556,6 @@ void dcn10_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	 */
 	mpcc_id = hubp->inst;
 
-	dc->hwss.update_visual_confirm_color(dc, pipe_ctx, &blnd_cfg.black_color, mpcc_id);
-
 	/* If there is no full update, don't need to touch MPC tree*/
 	if (!pipe_ctx->plane_state->update_flags.bits.full_update) {
 		mpc->funcs->update_blending(mpc, &blnd_cfg, mpcc_id);
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
index 478180b96d8d..c9bdffe5989b 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
@@ -206,10 +206,4 @@ void dcn10_verify_allow_pstate_change_high(struct dc *dc);
 
 void dcn10_get_dcc_en_bits(struct dc *dc, int *dcc_en_bits);
 
-void dcn10_update_visual_confirm_color(
-		struct dc *dc,
-		struct pipe_ctx *pipe_ctx,
-		struct tg_color *color,
-		int mpcc_id);
-
 #endif /* __DC_HWSS_DCN10_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
index 4ff3ebc25438..680ca53455a2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
@@ -82,7 +82,6 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
 	.set_pipe = dce110_set_pipe,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
-	.update_visual_confirm_color = dcn10_update_visual_confirm_color,
 };
 
 static const struct hwseq_private_funcs dcn10_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
index da74269feb75..b096011acb49 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_mpc.c
@@ -64,8 +64,6 @@ void mpc1_set_bg_color(struct mpc *mpc,
 			MPCC_BG_G_Y, bg_g_y);
 	REG_SET(MPCC_BG_B_CB[bottommost_mpcc->mpcc_id], 0,
 			MPCC_BG_B_CB, bg_b_cb);
-
-	bottommost_mpcc->blnd_cfg.black_color = *bg_color;
 }
 
 static void mpc1_update_blending(
@@ -248,8 +246,6 @@ struct mpcc *mpc1_insert_plane(
 		}
 	}
 
-	mpc->funcs->set_bg_color(mpc, &blnd_cfg->black_color, mpcc_id);
-
 	/* update the blending configuration */
 	mpc->funcs->update_blending(mpc, blnd_cfg, mpcc_id);
 
@@ -499,7 +495,6 @@ static const struct mpc_funcs dcn10_mpc_funcs = {
 	.set_output_csc = NULL,
 	.set_output_gamma = NULL,
 	.get_mpc_out_mux = mpc1_get_mpc_out_mux,
-	.set_bg_color = mpc1_set_bg_color,
 };
 
 void dcn10_mpc_construct(struct dcn10_mpc *mpc10,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 558821e5ed2f..484a30592987 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2267,23 +2267,6 @@ void dcn20_get_mpctree_visual_confirm_color(
 	*color = pipe_colors[top_pipe->pipe_idx];
 }
 
-void dcn20_update_visual_confirm_color(struct dc *dc, struct pipe_ctx *pipe_ctx, struct tg_color *color, int mpcc_id)
-{
-	struct dce_hwseq *hws = dc->hwseq;
-	struct mpc *mpc = dc->res_pool->mpc;
-
-	/* input to MPCC is always RGB, by default leave black_color at 0 */
-	if (dc->debug.visual_confirm == VISUAL_CONFIRM_HDR)
-		hws->funcs.get_hdr_visual_confirm_color(pipe_ctx, color);
-	else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SURFACE)
-		hws->funcs.get_surface_visual_confirm_color(pipe_ctx, color);
-	else if (dc->debug.visual_confirm == VISUAL_CONFIRM_MPCTREE)
-		dcn20_get_mpctree_visual_confirm_color(pipe_ctx, color);
-
-	if (mpc->funcs->set_bg_color)
-		mpc->funcs->set_bg_color(mpc, color, mpcc_id);
-}
-
 void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 {
 	struct dce_hwseq *hws = dc->hwseq;
@@ -2295,6 +2278,15 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	struct mpc *mpc = dc->res_pool->mpc;
 	struct mpc_tree *mpc_tree_params = &(pipe_ctx->stream_res.opp->mpc_tree_params);
 
+	// input to MPCC is always RGB, by default leave black_color at 0
+	if (dc->debug.visual_confirm == VISUAL_CONFIRM_HDR) {
+		hws->funcs.get_hdr_visual_confirm_color(pipe_ctx, &blnd_cfg.black_color);
+	} else if (dc->debug.visual_confirm == VISUAL_CONFIRM_SURFACE) {
+		hws->funcs.get_surface_visual_confirm_color(pipe_ctx, &blnd_cfg.black_color);
+	} else if (dc->debug.visual_confirm == VISUAL_CONFIRM_MPCTREE) {
+		dcn20_get_mpctree_visual_confirm_color(pipe_ctx, &blnd_cfg.black_color);
+	}
+
 	if (per_pixel_alpha)
 		blnd_cfg.alpha_mode = MPCC_ALPHA_BLEND_MODE_PER_PIXEL_ALPHA;
 	else
@@ -2328,8 +2320,6 @@ void dcn20_update_mpcc(struct dc *dc, struct pipe_ctx *pipe_ctx)
 	 */
 	mpcc_id = hubp->inst;
 
-	dc->hwss.update_visual_confirm_color(dc, pipe_ctx, &blnd_cfg.black_color, mpcc_id);
-
 	/* If there is no full update, don't need to touch MPC tree*/
 	if (!pipe_ctx->plane_state->update_flags.bits.full_update &&
 		!pipe_ctx->update_flags.bits.mpcc) {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
index 6bba191cd33e..c69f766a40ce 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.h
@@ -146,10 +146,5 @@ void dcn20_set_disp_pattern_generator(const struct dc *dc,
 		const struct tg_color *solid_color,
 		int width, int height, int offset);
 
-void dcn20_update_visual_confirm_color(struct dc *dc,
-		struct pipe_ctx *pipe_ctx,
-		struct tg_color *color,
-		int mpcc_id);
-
 #endif /* __DC_HWSS_DCN20_H__ */
 
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index 2f59f10e5f09..b5bb613eed4d 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -96,7 +96,6 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 #endif
 	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
-	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
 };
 
 static const struct hwseq_private_funcs dcn20_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
index 947eb0df3f12..6a99fdd55e8c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_mpc.c
@@ -67,6 +67,7 @@ void mpc2_update_blending(
 	REG_SET(MPCC_BOT_GAIN_INSIDE[mpcc_id], 0, MPCC_BOT_GAIN_INSIDE, blnd_cfg->bottom_inside_gain);
 	REG_SET(MPCC_BOT_GAIN_OUTSIDE[mpcc_id], 0, MPCC_BOT_GAIN_OUTSIDE, blnd_cfg->bottom_outside_gain);
 
+	mpc1_set_bg_color(mpc, &blnd_cfg->black_color, mpcc_id);
 	mpcc->blnd_cfg = *blnd_cfg;
 }
 
@@ -556,7 +557,6 @@ const struct mpc_funcs dcn20_mpc_funcs = {
 	.set_output_gamma = mpc2_set_output_gamma,
 	.power_on_mpc_mem_pwr = mpc20_power_on_ogam_lut,
 	.get_mpc_out_mux = mpc1_get_mpc_out_mux,
-	.set_bg_color = mpc1_set_bg_color,
 };
 
 void dcn20_mpc_construct(struct dcn20_mpc *mpc20,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index 523e25f7e410..4f20a85ff396 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -100,7 +100,6 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 	.is_abm_supported = dcn21_is_abm_supported,
 	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
-	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
 };
 
 static const struct hwseq_private_funcs dcn21_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index a978d848d370..bf7fa98b39eb 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -99,7 +99,6 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.set_pipe = dcn21_set_pipe,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
-	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
 };
 
 static const struct hwseq_private_funcs dcn30_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
index a82319f4d081..950c9bfd53de 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_mpc.c
@@ -1431,7 +1431,7 @@ const struct mpc_funcs dcn30_mpc_funcs = {
 	.release_rmu = mpcc3_release_rmu,
 	.power_on_mpc_mem_pwr = mpc3_power_on_ogam_lut,
 	.get_mpc_out_mux = mpc1_get_mpc_out_mux,
-	.set_bg_color = mpc1_set_bg_color,
+
 };
 
 void dcn30_mpc_construct(struct dcn30_mpc *mpc30,
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
index 181f2175ac95..70b053d9ba40 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
@@ -101,7 +101,6 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 	.get_dcc_en_bits = dcn10_get_dcc_en_bits,
 	.optimize_pwr_state = dcn21_optimize_pwr_state,
 	.exit_optimized_pwr_state = dcn21_exit_optimized_pwr_state,
-	.update_visual_confirm_color = dcn20_update_visual_confirm_color,
 };
 
 static const struct hwseq_private_funcs dcn301_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
index 640bb432bd6a..75c77ad9cbfe 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h
@@ -363,9 +363,6 @@ struct mpc_funcs {
 			struct mpc *mpc,
 			int opp_id);
 
-	void (*set_bg_color)(struct mpc *mpc,
-			struct tg_color *bg_color,
-			int mpcc_id);
 };
 
 #endif
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 43284d410687..1d5853c95448 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -235,10 +235,6 @@ struct hw_sequencer_funcs {
 			enum dc_color_depth color_depth,
 			const struct tg_color *solid_color,
 			int width, int height, int offset);
-	void (*update_visual_confirm_color)(struct dc *dc,
-			struct pipe_ctx *pipe_ctx,
-			struct tg_color *color,
-			int mpcc_id);
 };
 
 void color_space_to_black_color(
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

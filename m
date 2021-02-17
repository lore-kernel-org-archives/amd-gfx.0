Return-Path: <SRS0=lywG=HT=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA26C433E0
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 14:30:28 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 389F564DE9
	for <amd-gfx@archiver.kernel.org>; Wed, 17 Feb 2021 14:30:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 389F564DE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amd.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A8C86E15E;
	Wed, 17 Feb 2021 14:30:27 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2061.outbound.protection.outlook.com [40.107.243.61])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A6946E0E7
 for <amd-gfx@lists.freedesktop.org>; Wed, 17 Feb 2021 14:30:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lQ3fePCVB80IUZdiPsl/3+IqA6xHgmI87aoBoa8oy4/aVqfY0pWoqKtpSNbi7qU01BV9pBJfsOAIZ5Mi+b9F2mYDBPBzCHULYCH6L2EGlbBYBB9NEralnFgaheWxYsWD7p0MRZdoz9ztJ4IXM3wKGOZaPmgMrsreWdl50qPE3wgrulW1GX23KsicEs9QAvGMJLUG/Pd4KvU8C5HaZbYYTZokM5XxyydgguSB6Zd2HoV966pb79OGJeQB2bi7i7obz51kDu191HiWAzWshuROFvihO7FRFLPGj5/rvFoCoE437nzGlI2JEboYJwQVe6CEIChu/hUtnGwGpmlBzwVtfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybHZnYUB/Zv/ypLi8GNjE4TDU9VK8GBB8lCZwnrTTsI=;
 b=dC+sgccRgpWvKw4T3rH52/pOX8SIoVYEOLeen0XrEQle94ggkWZ4cDPcvXkBiN1AQ1UPcWFsYGFw3BfTdGC5GtQKYbuDTBpdDQOomHaAhJi/0oNFmxETUZRvoDtMsXT/SZs05eAtn2RyUivdSKPaCBu1MExvHdQeMqnmsGiGBIOgGlI06ikEJBEqIaVr8pmoaGdqI4/xlxObLfRqlxrG0Kpexm6+B/nk6wKNEv5v+YvsOlmpjQpSx8cRW94y2HKryBVJOtoNZdoKqns3qwhO7GnYYcChLBzi/eYkcasJfHszEuSgxMdOOyKnnq/cuiGLNP/r1WENDsFb9gmwcD9zhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org
 smtp.mailfrom=amd.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybHZnYUB/Zv/ypLi8GNjE4TDU9VK8GBB8lCZwnrTTsI=;
 b=uYb8Mw7fbJMkkVlGIq++7RsKxvVE/lyWAWeDrcL4sGw1G7rjf++ULvCWMPDi7VMuATuLxd+u9QNzVPn9AtO64bZEq6EoxyOUg+TShylZ/F6Zrc72RniRllYZFsplN3fOCOe4IFFlnUctEd6oze+pSaa/PX6IkF9A/3AndjZkJaA=
Received: from BN0PR03CA0024.namprd03.prod.outlook.com (2603:10b6:408:e6::29)
 by DM5PR12MB1258.namprd12.prod.outlook.com (2603:10b6:3:79::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.31; Wed, 17 Feb
 2021 14:30:23 +0000
Received: from BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
 (2603:10b6:408:e6:cafe::e8) by BN0PR03CA0024.outlook.office365.com
 (2603:10b6:408:e6::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend
 Transport; Wed, 17 Feb 2021 14:30:23 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 165.204.84.17) smtp.mailfrom=amd.com; lists.freedesktop.org; dkim=none
 (message not signed) header.d=none;lists.freedesktop.org; dmarc=fail
 action=none header.from=amd.com;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 amd.com discourages use of 165.204.84.17 as permitted sender)
Received: from SATLEXMB01.amd.com (165.204.84.17) by
 BN8NAM11FT053.mail.protection.outlook.com (10.13.177.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.3868.27 via Frontend Transport; Wed, 17 Feb 2021 14:30:21 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB01.amd.com
 (10.181.40.142) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 17 Feb
 2021 08:30:14 -0600
Received: from SATLEXMB02.amd.com (10.181.40.143) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Wed, 17 Feb
 2021 08:30:13 -0600
Received: from elite-desk-aura.amd.com (10.180.168.240) by SATLEXMB02.amd.com
 (10.181.40.143) with Microsoft SMTP Server id 15.1.1979.3 via
 Frontend Transport; Wed, 17 Feb 2021 08:30:13 -0600
From: Aurabindo Pillai <aurabindo.pillai@amd.com>
To: <amd-gfx@lists.freedesktop.org>
Subject: [PATCH v2] Revert "drm/amd/display: New sequence for HUBP blank"
Date: Wed, 17 Feb 2021 09:30:13 -0500
Message-ID: <20210217143013.36870-1-aurabindo.pillai@amd.com>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-Office365-Filtering-HT: Tenant
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e20c777a-5935-408b-6aa8-08d8d3508e5c
X-MS-TrafficTypeDiagnostic: DM5PR12MB1258:
X-Microsoft-Antispam-PRVS: <DM5PR12MB1258C0266A38A18B3D5641B48B869@DM5PR12MB1258.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:765;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g/Kru/GF5qtGYrB7RNgZS6F9hXsaUkmHLQ9PHL6ik5rVOEHOJgFeIM+socOrCgqxz4g6ooK+nQ6DzFxzM5pzZ+YNmEVJM2+pyLzKh+5dxXpt2y2oyQdoTR1FWBEE88qEZ0E+FxTFvuLJd04TZ47uPADMQuZc6VnUJzipRg12B0actFyITDEm4XUiEE/k0QjCHpi/BGRiSMxmM1JGdx1iTFFo9UeZvhP4nCkTp0XNQzgOS4UzDKNG8/c8NOJVkIsvMAcW82o2ou4Xg+YrfdH16gUrdTXfyTAl/ssjDM3BtjVd/2YiU4Pi3Yiq1cXn4FYsFn9hYfhuBULqH6QNLiHaf3hiJXyRy8IWoFj/DyL4LZ6qx0ha1yJeCpvsNfYdJwlyDy1Hq+kafMEQDsidETUUzsgWp+YBlNkAcUHPzpvh83U17lGzHry4TH590hTOnORy3Cx1UO8yxQoYm3n7KjJbIubgCpsadVZS18PqtWe2maElU+QeYez51TLsK5XdL8pvuh14p/3ISlVGNo3PL9eEqvVBHR5Z4Dqjw+nf3h1LiqUSpLQsLTfB68lG+CLQCpaQK/spZQT3zIHab63P7dtICi7YSeb0lGI6BadeGpfS8DbWYBQc99r9n5WcN5BDXJkgBGuYENPum9XpI7H5Iz319hGDvc24GtklZsjwFXw4Pmbr/OVFLBtvuIWyQEtVuu0o
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SATLEXMB01.amd.com; PTR:ErrorRetry; CAT:NONE;
 SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(36840700001)(46966006)(4326008)(86362001)(478600001)(82740400003)(7696005)(83380400001)(36756003)(2906002)(8936002)(5660300002)(8676002)(81166007)(26005)(54906003)(36860700001)(6916009)(82310400003)(30864003)(186003)(1076003)(70586007)(70206006)(44832011)(47076005)(356005)(426003)(316002)(2616005)(336012)(36900700001);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2021 14:30:21.1761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e20c777a-5935-408b-6aa8-08d8d3508e5c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB01.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM11FT053.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR12MB1258
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
Cc: bhawanpreet.lakha@amd.com, aurabindo.pillai@amd.com,
 rodrigo.siqueira@amd.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

This reverts commit be7af780ef3cbb8fe1004db48dc66caf2da595cd because the
new proposed sequence for HUBP blanking causes regressions. This change
brings back the old sequence.

Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
---
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.c | 36 +++--------
 .../amd/display/dc/dcn10/dcn10_hw_sequencer.h |  3 -
 .../gpu/drm/amd/display/dc/dcn10/dcn10_init.c |  1 -
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    | 13 +++-
 .../gpu/drm/amd/display/dc/dcn20/dcn20_init.c |  1 -
 .../gpu/drm/amd/display/dc/dcn21/dcn21_init.c |  1 -
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 62 ++++---------------
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.h    |  4 --
 .../gpu/drm/amd/display/dc/dcn30/dcn30_init.c |  1 -
 .../drm/amd/display/dc/dcn301/dcn301_init.c   |  1 -
 .../gpu/drm/amd/display/dc/inc/hw_sequencer.h |  4 --
 11 files changed, 30 insertions(+), 97 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
index 89912bb5014f..361a97edc8ee 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.c
@@ -2635,7 +2635,7 @@ static void dcn10_update_dchubp_dpp(
 	hws->funcs.update_plane_addr(dc, pipe_ctx);
 
 	if (is_pipe_tree_visible(pipe_ctx))
-		dc->hwss.set_hubp_blank(dc, pipe_ctx, false);
+		hubp->funcs->set_blank(hubp, false);
 }
 
 void dcn10_blank_pixel_data(
@@ -3146,16 +3146,13 @@ void dcn10_setup_stereo(struct pipe_ctx *pipe_ctx, struct dc *dc)
 	return;
 }
 
-static struct pipe_ctx *get_pipe_ctx_by_hubp_inst(struct dc_state *context, int mpcc_inst)
+static struct hubp *get_hubp_by_inst(struct resource_pool *res_pool, int mpcc_inst)
 {
 	int i;
 
-	for (i = 0; i < MAX_PIPES; i++) {
-		if (context->res_ctx.pipe_ctx[i].plane_res.hubp
-				&& context->res_ctx.pipe_ctx[i].plane_res.hubp->inst == mpcc_inst) {
-			return &context->res_ctx.pipe_ctx[i];
-		}
-
+	for (i = 0; i < res_pool->pipe_count; i++) {
+		if (res_pool->hubps[i]->inst == mpcc_inst)
+			return res_pool->hubps[i];
 	}
 	ASSERT(false);
 	return NULL;
@@ -3178,23 +3175,11 @@ void dcn10_wait_for_mpcc_disconnect(
 
 	for (mpcc_inst = 0; mpcc_inst < MAX_PIPES; mpcc_inst++) {
 		if (pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst]) {
-			struct pipe_ctx *restore_bottom_pipe;
-			struct pipe_ctx *restore_top_pipe;
-			struct pipe_ctx *inst_pipe_ctx = get_pipe_ctx_by_hubp_inst(dc->current_state, mpcc_inst);
+			struct hubp *hubp = get_hubp_by_inst(res_pool, mpcc_inst);
 
-			ASSERT(inst_pipe_ctx);
 			res_pool->mpc->funcs->wait_for_idle(res_pool->mpc, mpcc_inst);
 			pipe_ctx->stream_res.opp->mpcc_disconnect_pending[mpcc_inst] = false;
-			/*
-			 * Set top and bottom pipes NULL, as we don't want
-			 * to blank those pipes when disconnecting from MPCC
-			 */
-			restore_bottom_pipe = inst_pipe_ctx->bottom_pipe;
-			restore_top_pipe = inst_pipe_ctx->top_pipe;
-			inst_pipe_ctx->top_pipe = inst_pipe_ctx->bottom_pipe = NULL;
-			dc->hwss.set_hubp_blank(dc, inst_pipe_ctx, true);
-			inst_pipe_ctx->top_pipe = restore_top_pipe;
-			inst_pipe_ctx->bottom_pipe = restore_bottom_pipe;
+			hubp->funcs->set_blank(hubp, true);
 		}
 	}
 
@@ -3747,10 +3732,3 @@ void dcn10_get_clock(struct dc *dc,
 				dc->clk_mgr->funcs->get_clock(dc->clk_mgr, context, clock_type, clock_cfg);
 
 }
-
-void dcn10_set_hubp_blank(const struct dc *dc,
-				struct pipe_ctx *pipe_ctx,
-				bool blank_enable)
-{
-	pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, blank_enable);
-}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
index 89e6dfb63da0..dee8ad1ebaa4 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_hw_sequencer.h
@@ -204,8 +204,5 @@ void dcn10_wait_for_pending_cleared(struct dc *dc,
 		struct dc_state *context);
 void dcn10_set_hdr_multiplier(struct pipe_ctx *pipe_ctx);
 void dcn10_verify_allow_pstate_change_high(struct dc *dc);
-void dcn10_set_hubp_blank(const struct dc *dc,
-				struct pipe_ctx *pipe_ctx,
-				bool blank_enable);
 
 #endif /* __DC_HWSS_DCN10_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
index 2f1b802e66a1..254300b06b43 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn10/dcn10_init.c
@@ -79,7 +79,6 @@ static const struct hw_sequencer_funcs dcn10_funcs = {
 	.set_backlight_level = dce110_set_backlight_level,
 	.set_abm_immediate_disable = dce110_set_abm_immediate_disable,
 	.set_pipe = dce110_set_pipe,
-	.set_hubp_blank = dcn10_set_hubp_blank,
 };
 
 static const struct hwseq_private_funcs dcn10_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index b79a17f6a9cc..48d1e0e2cf75 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -1576,7 +1576,7 @@ static void dcn20_update_dchubp_dpp(
 
 
 	if (pipe_ctx->update_flags.bits.enable)
-		dc->hwss.set_hubp_blank(dc, pipe_ctx, false);
+		hubp->funcs->set_blank(hubp, false);
 }
 
 
@@ -1772,10 +1772,19 @@ void dcn20_post_unlock_program_front_end(
 
 	for (i = 0; i < dc->res_pool->pipe_count; i++) {
 		struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[i];
+		struct pipe_ctx *mpcc_pipe;
 
 		if (pipe->vtp_locked) {
-			dc->hwss.set_hubp_blank(dc, pipe, true);
+			dc->hwseq->funcs.wait_for_blank_complete(pipe->stream_res.opp);
+			pipe->plane_res.hubp->funcs->set_blank(pipe->plane_res.hubp, true);
 			pipe->vtp_locked = false;
+
+			for (mpcc_pipe = pipe->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
+				mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, true);
+
+			for (i = 0; i < dc->res_pool->pipe_count; i++)
+				if (context->res_ctx.pipe_ctx[i].update_flags.bits.disable)
+					dc->hwss.disable_plane(dc, &dc->current_state->res_ctx.pipe_ctx[i]);
 		}
 	}
 	/* WA to apply WM setting*/
diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
index 51a4166e9750..de9dcbeea150 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_init.c
@@ -94,7 +94,6 @@ static const struct hw_sequencer_funcs dcn20_funcs = {
 	.optimize_timing_for_fsft = dcn20_optimize_timing_for_fsft,
 #endif
 	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
-	.set_hubp_blank = dcn10_set_hubp_blank,
 };
 
 static const struct hwseq_private_funcs dcn20_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
index 0597391b2171..074e2713257f 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn21/dcn21_init.c
@@ -99,7 +99,6 @@ static const struct hw_sequencer_funcs dcn21_funcs = {
 #endif
 	.is_abm_supported = dcn21_is_abm_supported,
 	.set_disp_pattern_generator = dcn20_set_disp_pattern_generator,
-	.set_hubp_blank = dcn10_set_hubp_blank,
 };
 
 static const struct hwseq_private_funcs dcn21_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index ab93da667d51..d84164f0000c 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -938,53 +938,6 @@ void dcn30_hardware_release(struct dc *dc)
 				dc->res_pool->hubbub, true, true);
 }
 
-void dcn30_set_hubp_blank(const struct dc *dc,
-		struct pipe_ctx *pipe_ctx,
-		bool blank_enable)
-{
-	struct pipe_ctx *mpcc_pipe;
-	struct pipe_ctx *odm_pipe;
-
-	if (blank_enable) {
-		struct plane_resource *plane_res = &pipe_ctx->plane_res;
-		struct stream_resource *stream_res = &pipe_ctx->stream_res;
-
-		/* Wait for enter vblank */
-		stream_res->tg->funcs->wait_for_state(stream_res->tg, CRTC_STATE_VBLANK);
-
-		/* Blank HUBP to allow p-state during blank on all timings */
-		pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, true);
-		/* Confirm hubp in blank */
-		ASSERT(plane_res->hubp->funcs->hubp_in_blank(plane_res->hubp));
-		/* Toggle HUBP_DISABLE */
-		plane_res->hubp->funcs->hubp_soft_reset(plane_res->hubp, true);
-		plane_res->hubp->funcs->hubp_soft_reset(plane_res->hubp, false);
-		for (mpcc_pipe = pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe) {
-			mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, true);
-			/* Confirm hubp in blank */
-			ASSERT(mpcc_pipe->plane_res.hubp->funcs->hubp_in_blank(mpcc_pipe->plane_res.hubp));
-			/* Toggle HUBP_DISABLE */
-			mpcc_pipe->plane_res.hubp->funcs->hubp_soft_reset(mpcc_pipe->plane_res.hubp, true);
-			mpcc_pipe->plane_res.hubp->funcs->hubp_soft_reset(mpcc_pipe->plane_res.hubp, false);
-
-		}
-		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe) {
-			odm_pipe->plane_res.hubp->funcs->set_blank(odm_pipe->plane_res.hubp, true);
-			/* Confirm hubp in blank */
-			ASSERT(odm_pipe->plane_res.hubp->funcs->hubp_in_blank(odm_pipe->plane_res.hubp));
-			/* Toggle HUBP_DISABLE */
-			odm_pipe->plane_res.hubp->funcs->hubp_soft_reset(odm_pipe->plane_res.hubp, true);
-			odm_pipe->plane_res.hubp->funcs->hubp_soft_reset(odm_pipe->plane_res.hubp, false);
-		}
-	} else {
-		pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, false);
-		for (mpcc_pipe = pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
-			mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, false);
-		for (odm_pipe = pipe_ctx->next_odm_pipe; odm_pipe; odm_pipe = odm_pipe->next_odm_pipe)
-			odm_pipe->plane_res.hubp->funcs->set_blank(odm_pipe->plane_res.hubp, false);
-	}
-}
-
 void dcn30_set_disp_pattern_generator(const struct dc *dc,
 		struct pipe_ctx *pipe_ctx,
 		enum controller_dp_test_pattern test_pattern,
@@ -994,6 +947,7 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
 		int width, int height, int offset)
 {
 	struct stream_resource *stream_res = &pipe_ctx->stream_res;
+	struct pipe_ctx *mpcc_pipe;
 
 	if (test_pattern != CONTROLLER_DP_TEST_PATTERN_VIDEOMODE) {
 		pipe_ctx->vtp_locked = false;
@@ -1005,12 +959,20 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
 		if (stream_res->tg->funcs->is_tg_enabled(stream_res->tg)) {
 			if (stream_res->tg->funcs->is_locked(stream_res->tg))
 				pipe_ctx->vtp_locked = true;
-			else
-				dc->hwss.set_hubp_blank(dc, pipe_ctx, true);
+			else {
+				/* Blank HUBP to allow p-state during blank on all timings */
+				pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, true);
+
+				for (mpcc_pipe = pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
+					mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, true);
+			}
 		}
 	} else {
-		dc->hwss.set_hubp_blank(dc, pipe_ctx, false);
 		/* turning off DPG */
+		pipe_ctx->plane_res.hubp->funcs->set_blank(pipe_ctx->plane_res.hubp, false);
+		for (mpcc_pipe = pipe_ctx->bottom_pipe; mpcc_pipe; mpcc_pipe = mpcc_pipe->bottom_pipe)
+			mpcc_pipe->plane_res.hubp->funcs->set_blank(mpcc_pipe->plane_res.hubp, false);
+
 		stream_res->opp->funcs->opp_set_disp_pattern_generator(stream_res->opp, test_pattern, color_space,
 				color_depth, solid_color, width, height, offset);
 	}
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
index 3b7d4812e311..e9a0005288d3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.h
@@ -80,8 +80,4 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
 		const struct tg_color *solid_color,
 		int width, int height, int offset);
 
-void dcn30_set_hubp_blank(const struct dc *dc,
-		struct pipe_ctx *pipe_ctx,
-		bool blank_enable);
-
 #endif /* __DC_HWSS_DCN30_H__ */
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
index 204444fead97..c4c14e9c1309 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_init.c
@@ -98,7 +98,6 @@ static const struct hw_sequencer_funcs dcn30_funcs = {
 	.hardware_release = dcn30_hardware_release,
 	.set_pipe = dcn21_set_pipe,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
-	.set_hubp_blank = dcn30_set_hubp_blank,
 };
 
 static const struct hwseq_private_funcs dcn30_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
index b8bf6d61005b..bdad72140cbc 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn301/dcn301_init.c
@@ -98,7 +98,6 @@ static const struct hw_sequencer_funcs dcn301_funcs = {
 	.set_abm_immediate_disable = dcn21_set_abm_immediate_disable,
 	.set_pipe = dcn21_set_pipe,
 	.set_disp_pattern_generator = dcn30_set_disp_pattern_generator,
-	.set_hubp_blank = dcn30_set_hubp_blank,
 };
 
 static const struct hwseq_private_funcs dcn301_private_funcs = {
diff --git a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
index 0586ab2ffd6a..613b3e3cb46a 100644
--- a/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/inc/hw_sequencer.h
@@ -231,10 +231,6 @@ struct hw_sequencer_funcs {
 			enum dc_color_depth color_depth,
 			const struct tg_color *solid_color,
 			int width, int height, int offset);
-
-	void (*set_hubp_blank)(const struct dc *dc,
-			struct pipe_ctx *pipe_ctx,
-			bool blank_enable);
 };
 
 void color_space_to_black_color(
-- 
2.30.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

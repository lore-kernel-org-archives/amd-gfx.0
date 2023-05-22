Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162DCC7EE29
	for <amd-gfx@archiver.kernel.org>; Mon, 22 May 2023 13:08:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9284289048;
	Mon, 22 May 2023 13:08:31 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B888110E322
 for <amd-gfx@lists.freedesktop.org>; Mon, 22 May 2023 13:08:29 +0000 (UTC)
Received: from kaveri ([213.144.156.170])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202305221508248275; Mon, 22 May 2023 15:08:24 +0200
Received: from daenzer by kaveri with local (Exim 4.96)
 (envelope-from <michel@daenzer.net>) id 1q15Gx-003E7F-0O;
 Mon, 22 May 2023 15:08:23 +0200
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: Alex Deucher <alexander.deucher@amd.com>,
 Aurabindo Pillai <Aurabindo.Pillai@amd.com>
Subject: [PATCH 1/2] Revert "drm/amd/display: Block optimize on consecutive
 FAMS enables"
Date: Mon, 22 May 2023 15:08:22 +0200
Message-Id: <20230522130823.769236-1-michel@daenzer.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F15.646B6948.0028,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
 Spam="Unknown"; VOD="Unknown"
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
Cc: Wesley Chalmers <Wesley.Chalmers@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Qingqing Zhuo <Qingqing.Zhuo@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>, amd-gfx@lists.freedesktop.org,
 Harry Wentland <harry.wentland@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michel Dänzer <mdaenzer@redhat.com>

This reverts commit ce560ac40272a5c8b5b68a9d63a75edd9e66aed2.

It depends on its parent commit, which we want to revert.

Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
---
 .../drm/amd/display/dc/dcn20/dcn20_hwseq.c    |  3 ---
 .../drm/amd/display/dc/dcn30/dcn30_hwseq.c    | 22 +++----------------
 2 files changed, 3 insertions(+), 22 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index 422fbf79da64..6ce10fd4bb1a 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -2117,9 +2117,6 @@ void dcn20_optimize_bandwidth(
 		dc_dmub_srv_p_state_delegate(dc,
 			true, context);
 		context->bw_ctx.bw.dcn.clk.p_state_change_support = true;
-		dc->clk_mgr->clks.fw_based_mclk_switching = true;
-	} else {
-		dc->clk_mgr->clks.fw_based_mclk_switching = false;
 	}
 
 	dc->clk_mgr->funcs->update_clocks(
diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
index 8263a07f265f..0411867654dd 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_hwseq.c
@@ -983,13 +983,9 @@ void dcn30_set_disp_pattern_generator(const struct dc *dc,
 }
 
 void dcn30_prepare_bandwidth(struct dc *dc,
-	struct dc_state *context)
+ 	struct dc_state *context)
 {
-	bool p_state_change_support = context->bw_ctx.bw.dcn.clk.p_state_change_support;
-	/* Any transition into an FPO config should disable MCLK switching first to avoid
-	 * driver and FW P-State synchronization issues.
-	 */
-	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || dc->clk_mgr->clks.fw_based_mclk_switching) {
+	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching) {
 		dc->optimized_required = true;
 		context->bw_ctx.bw.dcn.clk.p_state_change_support = false;
 	}
@@ -1000,19 +996,7 @@ void dcn30_prepare_bandwidth(struct dc *dc,
 			dc->clk_mgr->funcs->set_max_memclk(dc->clk_mgr, dc->clk_mgr->bw_params->clk_table.entries[dc->clk_mgr->bw_params->clk_table.num_entries - 1].memclk_mhz);
 
 	dcn20_prepare_bandwidth(dc, context);
-	/*
-	 * enabled -> enabled: do not disable
-	 * enabled -> disabled: disable
-	 * disabled -> enabled: don't care
-	 * disabled -> disabled: don't care
-	 */
-	if (!context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching)
-		dc_dmub_srv_p_state_delegate(dc, false, context);
 
-	if (context->bw_ctx.bw.dcn.clk.fw_based_mclk_switching || dc->clk_mgr->clks.fw_based_mclk_switching) {
-		/* After disabling P-State, restore the original value to ensure we get the correct P-State
-		 * on the next optimize. */
-		context->bw_ctx.bw.dcn.clk.p_state_change_support = p_state_change_support;
-	}
+	dc_dmub_srv_p_state_delegate(dc, false, context);
 }
 
-- 
2.40.1


Return-Path: <SRS0=iwxs=L6=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DABFC07E96
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:14:27 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 127E361C1F
	for <amd-gfx@archiver.kernel.org>; Tue,  6 Jul 2021 11:14:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 127E361C1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6FDD489F49;
	Tue,  6 Jul 2021 11:14:19 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDEC089F47;
 Tue,  6 Jul 2021 11:14:18 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id C00D561C23;
 Tue,  6 Jul 2021 11:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625570058;
 bh=VuLeOQHb+jdBnhIxuyI7y13YX5R0cN86+8AiJcasJPs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=pBj9mozpuwPmIGtdvpqeOYlfqaZhCiuZZfVxlHEOcPIAgujRf09GkAGDwzP0Wk6ot
 8P7U9VfiS/C5mVc6rFN0t+MvqCXVgqjT1zuTPWGgDSxT8Hv8bNl9ILxToKeadA2Tez
 gE2YVqtJ+XWiXz4vgEl3K/KHXNIUjTA2jflzxsTmAudoRVRLbT5AGWP869vsgLAroy
 srYsU2TEpeHiLv4rhSqTVJ/vIyIQlVEGoaYPiiSMZNx8MZ2rAmoBFxkKX1izq25onI
 qw4eIT3xf9qA4499aVJjHqEoMnW4kdBiVSSCd1xo2xBRT9foROU9MtjhQbIZLmbUj6
 /nO7vE+nzOx/A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 006/189] drm/amd/display: Revert wait vblank on
 update dpp clock
Date: Tue,  6 Jul 2021 07:11:06 -0400
Message-Id: <20210706111409.2058071-6-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210706111409.2058071-1-sashal@kernel.org>
References: <20210706111409.2058071-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
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
Cc: Sasha Levin <sashal@kernel.org>, Lewis Huang <Lewis.Huang@amd.com>,
 Eric Yang <eric.yang2@amd.com>, amd-gfx@lists.freedesktop.org,
 Daniel Wheeler <daniel.wheeler@amd.com>, Wayne Lin <waynelin@amd.com>,
 dri-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Lewis Huang <Lewis.Huang@amd.com>

[ Upstream commit d5433a9f692f57c814286f8af2746c567ef79fc8 ]

[Why]
This change only fix dpp clock switch to lower case.
New solution later can fix both case, which is "dc: skip
program clock when allow seamless boot"

[How]
This reverts commit "dc: wait vblank when stream enabled
and update dpp clock"

Signed-off-by: Lewis Huang <Lewis.Huang@amd.com>
Reviewed-by: Eric Yang <eric.yang2@amd.com>
Acked-by: Wayne Lin <waynelin@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c   | 10 +---------
 drivers/gpu/drm/amd/display/dc/core/dc.c            | 13 -------------
 drivers/gpu/drm/amd/display/dc/dc.h                 |  1 -
 3 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
index a06e86853bb9..49d19fdd750b 100644
--- a/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
+++ b/drivers/gpu/drm/amd/display/dc/clk_mgr/dcn21/rn_clk_mgr.c
@@ -128,7 +128,7 @@ void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 	struct clk_mgr_internal *clk_mgr = TO_CLK_MGR_INTERNAL(clk_mgr_base);
 	struct dc_clocks *new_clocks = &context->bw_ctx.bw.dcn.clk;
 	struct dc *dc = clk_mgr_base->ctx->dc;
-	int display_count, i;
+	int display_count;
 	bool update_dppclk = false;
 	bool update_dispclk = false;
 	bool dpp_clock_lowered = false;
@@ -210,14 +210,6 @@ void rn_update_clocks(struct clk_mgr *clk_mgr_base,
 				clk_mgr_base->clks.dppclk_khz,
 				safe_to_lower);
 
-		for (i = 0; i < context->stream_count; i++) {
-			if (context->streams[i]->signal == SIGNAL_TYPE_EDP &&
-				context->streams[i]->apply_seamless_boot_optimization) {
-				dc_wait_for_vblank(dc, context->streams[i]);
-				break;
-			}
-		}
-
 		clk_mgr_base->clks.actual_dppclk_khz =
 				rn_vbios_smu_set_dppclk(clk_mgr, clk_mgr_base->clks.dppclk_khz);
 
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 4713f09bcbf1..e57df2f6f824 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -3219,19 +3219,6 @@ void dc_link_remove_remote_sink(struct dc_link *link, struct dc_sink *sink)
 	}
 }
 
-void dc_wait_for_vblank(struct dc *dc, struct dc_stream_state *stream)
-{
-	int i;
-
-	for (i = 0; i < dc->res_pool->pipe_count; i++)
-		if (dc->current_state->res_ctx.pipe_ctx[i].stream == stream) {
-			struct timing_generator *tg =
-				dc->current_state->res_ctx.pipe_ctx[i].stream_res.tg;
-			tg->funcs->wait_for_state(tg, CRTC_STATE_VBLANK);
-			break;
-		}
-}
-
 void get_clock_requirements_for_state(struct dc_state *state, struct AsicStateEx *info)
 {
 	info->displayClock				= (unsigned int)state->bw_ctx.bw.dcn.clk.dispclk_khz;
diff --git a/drivers/gpu/drm/amd/display/dc/dc.h b/drivers/gpu/drm/amd/display/dc/dc.h
index 100d434f7a03..65f801b50686 100644
--- a/drivers/gpu/drm/amd/display/dc/dc.h
+++ b/drivers/gpu/drm/amd/display/dc/dc.h
@@ -719,7 +719,6 @@ void dc_init_callbacks(struct dc *dc,
 void dc_deinit_callbacks(struct dc *dc);
 void dc_destroy(struct dc **dc);
 
-void dc_wait_for_vblank(struct dc *dc, struct dc_stream_state *stream);
 /*******************************************************************************
  * Surface Interfaces
  ******************************************************************************/
-- 
2.30.2

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

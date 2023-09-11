Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7576FEE57DF
	for <amd-gfx@archiver.kernel.org>; Mon, 11 Sep 2023 14:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9BC810E301;
	Mon, 11 Sep 2023 14:36:48 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68D0810E30B
 for <amd-gfx@lists.freedesktop.org>; Mon, 11 Sep 2023 14:36:45 +0000 (UTC)
Received: from kaveri ([213.144.156.170])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202309111636415717; Mon, 11 Sep 2023 16:36:41 +0200
Received: from daenzer by kaveri with local (Exim 4.96)
 (envelope-from <michel@daenzer.net>) id 1qfi1n-0000oL-2V;
 Mon, 11 Sep 2023 16:36:39 +0200
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH] drm/amd/display: Handle NULL dccg in dce110_disable_stream
Date: Mon, 11 Sep 2023 16:36:39 +0200
Message-Id: <20230911143639.3110-1-michel@daenzer.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F15.64FF25FA.0016,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
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
Cc: Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
 Harry Wentland <harry.wentland@amd.com>, amd-gfx@lists.freedesktop.org
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Michel Dänzer <mdaenzer@redhat.com>

It can be NULL e.g. with Raven.

Fixes: 927e784c180c ("drm/amd/display: Add symclk enable/disable during stream enable/disable")
Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index ad967b58d7be..a9dca69ee8f6 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1179,9 +1179,11 @@ void dce110_disable_stream(struct pipe_ctx *pipe_ctx)
 		dccg->funcs->set_dtbclk_dto(dccg, &dto_params);
 		dccg->funcs->disable_symclk32_se(dccg, dp_hpo_inst);
 		dccg->funcs->set_dpstreamclk(dccg, REFCLK, tg->inst, dp_hpo_inst);
-	} else if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST && dccg->funcs->disable_symclk_se)
+	} else if (pipe_ctx->stream->signal == SIGNAL_TYPE_DISPLAY_PORT_MST &&
+		   dccg && dccg->funcs->disable_symclk_se) {
 		dccg->funcs->disable_symclk_se(dccg, stream_enc->stream_enc_inst,
-				link_enc->transmitter - TRANSMITTER_UNIPHY_A);
+					       link_enc->transmitter - TRANSMITTER_UNIPHY_A);
+	}
 
 	if (dc->link_srv->dp_is_128b_132b_signal(pipe_ctx)) {
 		/* TODO: This looks like a bug to me as we are disabling HPO IO when
-- 
2.40.1


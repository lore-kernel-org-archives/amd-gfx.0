Return-Path: <SRS0=gp3V=BU=lists.freedesktop.org=amd-gfx-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AFAC433E1
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 19:11:15 +0000 (UTC)
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B0F322B47
	for <amd-gfx@archiver.kernel.org>; Mon, 10 Aug 2020 19:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fh6AGZ3V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0F322B47
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=amd-gfx-bounces@lists.freedesktop.org
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 25E7E6E190;
	Mon, 10 Aug 2020 19:11:14 +0000 (UTC)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5AC66E0A1;
 Mon, 10 Aug 2020 19:11:12 +0000 (UTC)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 788AB22CBE;
 Mon, 10 Aug 2020 19:11:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1597086672;
 bh=4WTP4Ogj32dlekRkN0sF2w84Av0Agk7t6IC5sMNZfM8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=Fh6AGZ3VDVMQtxADFGVv7JbZUN8arSTF+BP6V2GFWLtN/EdFWbg3zVyHTzv1fjLP0
 OvnCbn38N8jgvI1k0nB6WkgqHV4n6IbK1LuOmh1ZktbNGVNuIcYB4rx5V02YB2+vFl
 9js4lChX9+XqeEbVp2Y80QvUqq8Hdh9i4F0Wv/yM=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.7 32/60] drm/amd/display: Improve DisplayPort
 monitor interop
Date: Mon, 10 Aug 2020 15:10:00 -0400
Message-Id: <20200810191028.3793884-32-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200810191028.3793884-1-sashal@kernel.org>
References: <20200810191028.3793884-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Aric Cyr <aric.cyr@amd.com>,
 Qingqing Zhuo <qingqing.zhuo@amd.com>, Wenjing Liu <Wenjing.Liu@amd.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Alex Deucher <alexander.deucher@amd.com>, Tony Cheng <Tony.Cheng@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Aric Cyr <aric.cyr@amd.com>

[ Upstream commit eec3303de3378cdfaa0bb86f43546dbbd88f94e2 ]

[Why]
DC is very fast at link training and stream enablement
which causes issues such as blackscreens for non-compliant
monitors.

[How]
After debugging with scaler vendors we implement the
minimum delays at the necessary locations to ensure
the monitor does not hang.  Delays are generic due to
lack of IEEE OUI information on the failing displays.

Signed-off-by: Aric Cyr <aric.cyr@amd.com>
Reviewed-by: Wenjing Liu <Wenjing.Liu@amd.com>
Acked-by: Qingqing Zhuo <qingqing.zhuo@amd.com>
Acked-by: Tony Cheng <Tony.Cheng@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link.c    |  4 +++-
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 16 ++++++++++------
 .../amd/display/dc/dce110/dce110_hw_sequencer.c  | 11 ++++++++++-
 3 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link.c b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
index 67cfff1586e9f..3f157bcc174b9 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link.c
@@ -3146,9 +3146,11 @@ void core_link_disable_stream(struct pipe_ctx *pipe_ctx)
 			write_i2c_redriver_setting(pipe_ctx, false);
 		}
 	}
-	dc->hwss.disable_stream(pipe_ctx);
 
 	disable_link(pipe_ctx->stream->link, pipe_ctx->stream->signal);
+
+	dc->hwss.disable_stream(pipe_ctx);
+
 	if (pipe_ctx->stream->timing.flags.DSC) {
 		if (dc_is_dp_signal(pipe_ctx->stream->signal))
 			dp_set_dsc_enable(pipe_ctx, false);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index caa090d0b6acc..1ada01322cd2c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -1103,6 +1103,10 @@ static inline enum link_training_result perform_link_training_int(
 	dpcd_pattern.v1_4.TRAINING_PATTERN_SET = DPCD_TRAINING_PATTERN_VIDEOIDLE;
 	dpcd_set_training_pattern(link, dpcd_pattern);
 
+	/* delay 5ms after notifying sink of idle pattern before switching output */
+	if (link->connector_signal != SIGNAL_TYPE_EDP)
+		msleep(5);
+
 	/* 4. mainlink output idle pattern*/
 	dp_set_hw_test_pattern(link, DP_TEST_PATTERN_VIDEO_MODE, NULL, 0);
 
@@ -1552,6 +1556,12 @@ bool perform_link_training_with_retries(
 	struct dc_link *link = stream->link;
 	enum dp_panel_mode panel_mode = dp_get_panel_mode(link);
 
+	/* We need to do this before the link training to ensure the idle pattern in SST
+	 * mode will be sent right after the link training
+	 */
+	link->link_enc->funcs->connect_dig_be_to_fe(link->link_enc,
+							pipe_ctx->stream_res.stream_enc->id, true);
+
 	for (j = 0; j < attempts; ++j) {
 
 		dp_enable_link_phy(
@@ -1568,12 +1578,6 @@ bool perform_link_training_with_retries(
 
 		dp_set_panel_mode(link, panel_mode);
 
-		/* We need to do this before the link training to ensure the idle pattern in SST
-		 * mode will be sent right after the link training
-		 */
-		link->link_enc->funcs->connect_dig_be_to_fe(link->link_enc,
-								pipe_ctx->stream_res.stream_enc->id, true);
-
 		if (link->aux_access_disabled) {
 			dc_link_dp_perform_link_training_skip_aux(link, link_setting);
 			return true;
diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index 10527593868cc..24ca592c90df5 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -1090,8 +1090,17 @@ void dce110_blank_stream(struct pipe_ctx *pipe_ctx)
 		dc_link_set_abm_disable(link);
 	}
 
-	if (dc_is_dp_signal(pipe_ctx->stream->signal))
+	if (dc_is_dp_signal(pipe_ctx->stream->signal)) {
 		pipe_ctx->stream_res.stream_enc->funcs->dp_blank(pipe_ctx->stream_res.stream_enc);
+
+		/*
+		 * After output is idle pattern some sinks need time to recognize the stream
+		 * has changed or they enter protection state and hang.
+		 */
+		if (!dc_is_embedded_signal(pipe_ctx->stream->signal))
+			msleep(60);
+	}
+
 }
 
 
-- 
2.25.1

_______________________________________________
amd-gfx mailing list
amd-gfx@lists.freedesktop.org
https://lists.freedesktop.org/mailman/listinfo/amd-gfx

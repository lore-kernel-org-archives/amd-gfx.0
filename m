Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFFFBC433FE
	for <amd-gfx@archiver.kernel.org>; Sun,  2 Oct 2022 22:50:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E77010E149;
	Sun,  2 Oct 2022 22:50:47 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDF3C10E141;
 Sun,  2 Oct 2022 22:50:41 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id E049BB80DA6;
 Sun,  2 Oct 2022 22:50:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D4C6C43147;
 Sun,  2 Oct 2022 22:50:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1664751039;
 bh=PEfUhnk/dHAbvQv9QPPgDLQ1toWlVdc8O27KDrIILKs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=b86nDuhfFEF7uRQ7l0z8Dq+GHvhjZ8e1W7429jyJuKxYxiCIBqFwQorO7wAF5v8XY
 FXhjS/e4zNIpX40cVw5gEee7UCuUdTfJ1XFXhZWKPGrNxsHSgpZAZl91Pl2D1AmZo1
 RTiz2wD/X5DNoxFFyhzWynz48ZSDgP2+96Dk905mRFLy4EsFKvm2Xi6wnse+S9b21t
 kCoeeJgRU/FZr6d5IlIngoWgmR6l9gC7MkPsRBfg1eZqw2lZ2R89EURtEPOdW2LH4D
 /qxQL5U+EMbLZlyWb2Dw37Z7veQ7tGkmyThuUPu9xjGbpe2w4xkKYbF+KfFFMnHbv8
 qZn9NQk82+Ugw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.19 26/29] drm/amd/display: skip audio setup when
 audio stream is enabled
Date: Sun,  2 Oct 2022 18:49:19 -0400
Message-Id: <20221002224922.238837-26-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221002224922.238837-1-sashal@kernel.org>
References: <20221002224922.238837-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
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
Cc: wenjing.liu@amd.com, dri-devel@lists.freedesktop.org,
 meenakshikumar.somasundaram@amd.com, mario.limonciello@amd.com,
 airlied@gmail.com, Sasha Levin <sashal@kernel.org>,
 Charlene Liu <Charlene.Liu@amd.com>, Rodrigo.Siqueira@amd.com,
 amd-gfx@lists.freedesktop.org, jdhillon@amd.com, harry.wentland@amd.com,
 zhikzhai <zhikai.zhai@amd.com>, sunpeng.li@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, Brandon.Syu@amd.com,
 Martin.Leung@amd.com, hanghong.ma@amd.com, agustin.gutierrez@amd.com,
 Wesley.Chalmers@amd.com, Xinhui.Pan@amd.com, Zhan.Liu@amd.com, daniel@ffwll.ch,
 Wayne Lin <wayne.lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: zhikzhai <zhikai.zhai@amd.com>

[ Upstream commit 65fbfb02c2734cacffec5e3f492e1b4f1dabcf98 ]

[why]
We have minimal pipe split transition method to avoid pipe
allocation outage.However, this method will invoke audio setup
which cause audio output stuck once pipe reallocate.

[how]
skip audio setup for pipelines which audio stream has been enabled

Reviewed-by: Charlene Liu <Charlene.Liu@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: zhikzhai <zhikai.zhai@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
index aee31c785aa9..4f0ea50eaa83 100644
--- a/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/dce110/dce110_hw_sequencer.c
@@ -2165,7 +2165,8 @@ static void dce110_setup_audio_dto(
 			continue;
 		if (pipe_ctx->stream->signal != SIGNAL_TYPE_HDMI_TYPE_A)
 			continue;
-		if (pipe_ctx->stream_res.audio != NULL) {
+		if (pipe_ctx->stream_res.audio != NULL &&
+			pipe_ctx->stream_res.audio->enabled == false) {
 			struct audio_output audio_output;
 
 			build_audio_output(context, pipe_ctx, &audio_output);
@@ -2207,7 +2208,8 @@ static void dce110_setup_audio_dto(
 			if (!dc_is_dp_signal(pipe_ctx->stream->signal))
 				continue;
 
-			if (pipe_ctx->stream_res.audio != NULL) {
+			if (pipe_ctx->stream_res.audio != NULL &&
+				pipe_ctx->stream_res.audio->enabled == false) {
 				struct audio_output audio_output;
 
 				build_audio_output(context, pipe_ctx, &audio_output);
-- 
2.35.1


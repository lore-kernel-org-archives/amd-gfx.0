Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65952C4332F
	for <amd-gfx@archiver.kernel.org>; Sun,  2 Oct 2022 22:50:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D12B710E14B;
	Sun,  2 Oct 2022 22:50:49 +0000 (UTC)
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 583D310E141;
 Sun,  2 Oct 2022 22:50:45 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CFC7C60EEA;
 Sun,  2 Oct 2022 22:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31251C433D6;
 Sun,  2 Oct 2022 22:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1664751044;
 bh=qBwQs3ScO9mSEiaUzW1hR+6DZafv70x1M0qGHdT/LRw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=j+pXqSHwZsZCVCS+0zIYtUYg5YCsmhuT7hUmof8hC+/QwaJbGnD4/bBu+VosM99F+
 5i76S9ldgJOD8EkOfKkE9wwS5DKarPJ90t98CPrOyl2UCnNFT1paWTTd1J2DVfnEsX
 /6bJnimKTGLFDX2VT/uiYk9y+rFCNVKHR9aKv4aelkG3Gm3Hh3FguEzidgFIm78pTU
 Rtegip1/08eI6Mwjhqep2XPHkMwNow0brXOKclm4Pij/i5DtJTgttougIAzpBKYVaV
 TnKmUC9xSQUKqt0w31Yu7r41JPhqEYK5PvqvSivx8f99y3K9E6PwJDHDPwz5lZJXwU
 DEJFZMX0+nzGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.19 27/29] drm/amd/display: Fix DP MST timeslot issue
 when fallback happened
Date: Sun,  2 Oct 2022 18:49:20 -0400
Message-Id: <20221002224922.238837-27-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, mikita.lipski@amd.com, george.shen@amd.com,
 sunpeng.li@amd.com, airlied@gmail.com, Xinhui.Pan@amd.com,
 Rodrigo.Siqueira@amd.com, amd-gfx@lists.freedesktop.org,
 christian.koenig@amd.com, wenjing.liu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, michael.strauss@amd.com,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch,
 Wayne Lin <wayne.lin@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
 Jun Lei <Jun.Lei@amd.com>, harry.wentland@amd.com,
 Cruise Hung <Cruise.Hung@amd.com>, Jimmy.Kizito@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Cruise Hung <Cruise.Hung@amd.com>

[ Upstream commit 20c6168b3c8aadef7d2853c925d99eb546bd5e1c ]

[Why]
When USB4 DP link training failed and fell back to lower link rate,
the time slot calculation uses the verified_link_cap.
And the verified_link_cap was not updated to the new one.
It caused the wrong VC payload time-slot was allocated.

[How]
Updated verified_link_cap with the new one from cur_link_settings
after the LT completes successfully.

Reviewed-by: Jun Lei <Jun.Lei@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Cruise Hung <Cruise.Hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
index 0c52506b367d..b4203a812c4b 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_link_dp.c
@@ -2857,8 +2857,14 @@ bool perform_link_training_with_retries(
 						skip_video_pattern);
 
 				/* Transmit idle pattern once training successful. */
-				if (status == LINK_TRAINING_SUCCESS && !is_link_bw_low)
+				if (status == LINK_TRAINING_SUCCESS && !is_link_bw_low) {
 					dp_set_hw_test_pattern(link, &pipe_ctx->link_res, DP_TEST_PATTERN_VIDEO_MODE, NULL, 0);
+					/* Update verified link settings to current one
+					 * Because DPIA LT might fallback to lower link setting.
+					 */
+					link->verified_link_cap.link_rate = link->cur_link_settings.link_rate;
+					link->verified_link_cap.lane_count = link->cur_link_settings.lane_count;
+				}
 			} else {
 				status = dc_link_dp_perform_link_training(link,
 						&pipe_ctx->link_res,
-- 
2.35.1


Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E749BC61D9C
	for <amd-gfx@archiver.kernel.org>; Wed, 22 Nov 2023 22:14:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8EDD10E1A7;
	Wed, 22 Nov 2023 22:14:38 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3E11510E13D;
 Wed, 22 Nov 2023 22:14:36 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 45894B829EE;
 Wed, 22 Nov 2023 22:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88974C433C8;
 Wed, 22 Nov 2023 22:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700691273;
 bh=aWQ1WosCXNx8YLqqiiqVPjOn2S3ApOJNQuk6aGU9t4Y=;
 h=From:To:Cc:Subject:Date:From;
 b=MS2uMxCEmTjhyh75y+8ySB5WevsdWntNucFuJnOEJ+NnniCPeACPNSOIdvGtr1WNj
 jfEhx3ALW0Miyv3gKlhT2Ujqv6J88KtAn4CNXVHDOYWuBM9kmZGvpNn/rR2F8kUaab
 Ik0b9/1OQUVOAY4UMJYlaDNkQBQ2IOSen3Waf/VSwt6Xy8UaE24b+tQDmvF24jlxzA
 ++5ClYBjdhHerpcrnITcvbg9HYn1gMqFhEiqI2IaAunt4uTYxvCmT4V8ldYUzMPCpN
 QDTX31Uj7tBS47Pt004uhTDbRwIrhktLEO6Ezldy+bDN0spqkTAof9lypS4DNL46t7
 edonuXg/zGADA==
From: Arnd Bergmann <arnd@kernel.org>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Subject: [PATCH] drm/amd/display: avoid stringop-overflow warnings for
 dp_decide_lane_settings()
Date: Wed, 22 Nov 2023 23:13:36 +0100
Message-Id: <20231122221421.2944301-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
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
Cc: Alan Liu <haoping.liu@amd.com>,
 Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
 Arnd Bergmann <arnd@arndb.de>, Qingqing Zhuo <qingqing.zhuo@amd.com>, "Pan,
 Xinhui" <Xinhui.Pan@amd.com>, Wenjing Liu <wenjing.liu@amd.com>,
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 Michael Mityushkin <michael.mityushkin@amd.com>,
 Michael Strauss <michael.strauss@amd.com>, dri-devel@lists.freedesktop.org,
 Daniel Vetter <daniel@ffwll.ch>, George Shen <george.shen@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Jun Lei <Jun.Lei@amd.com>,
 David Airlie <airlied@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Arnd Bergmann <arnd@arndb.de>

gcc prints a warning about a possible array overflow for a couple of
callers of dp_decide_lane_settings() after commit 1b56c90018f0 ("Makefile:
Enable -Wstringop-overflow globally"):

drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c: In function 'dp_perform_fixed_vs_pe_training_sequence_legacy':
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c:426:25: error: 'dp_decide_lane_settings' accessing 4 bytes in a region of size 1 [-Werror=stringop-overflow=]
  426 |                         dp_decide_lane_settings(lt_settings, dpcd_lane_adjust,
      |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  427 |                                         lt_settings->hw_lane_settings, lt_settings->dpcd_lane_settings);
      |                                         ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/gpu/drm/amd/amdgpu/../display/dc/link/protocols/link_dp_training_fixed_vs_pe_retimer.c:426:25: note: referencing argument 4 of type 'union dpcd_training_lane[4]'

I'm not entirely sure what caused this, but changing the prototype to expect
a pointer instead of an array avoids the warnings.

Fixes: 7727e7b60f82 ("drm/amd/display: Improve robustness of FIXED_VS link training at DP1 rates")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_training.c    | 2 +-
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_training.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 90339c2dfd84..5a0b04518956 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -807,7 +807,7 @@ void dp_decide_lane_settings(
 		const struct link_training_settings *lt_settings,
 		const union lane_adjust ln_adjust[LANE_COUNT_DP_MAX],
 		struct dc_lane_settings hw_lane_settings[LANE_COUNT_DP_MAX],
-		union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX])
+		union dpcd_training_lane *dpcd_lane_settings)
 {
 	uint32_t lane;
 
diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h
index 7d027bac8255..851bd17317a0 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.h
@@ -111,7 +111,7 @@ void dp_decide_lane_settings(
 	const struct link_training_settings *lt_settings,
 	const union lane_adjust ln_adjust[LANE_COUNT_DP_MAX],
 	struct dc_lane_settings hw_lane_settings[LANE_COUNT_DP_MAX],
-	union dpcd_training_lane dpcd_lane_settings[LANE_COUNT_DP_MAX]);
+	union dpcd_training_lane *dpcd_lane_settings);
 
 enum dc_dp_training_pattern decide_cr_training_pattern(
 		const struct dc_link_settings *link_settings);
-- 
2.39.2


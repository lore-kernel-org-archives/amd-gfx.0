Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C88E3C3DA7F
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 00:22:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7228D10E792;
	Thu,  1 Aug 2024 00:22:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZInq6htM";
	dkim-atps=neutral
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BDABF10E78F;
 Thu,  1 Aug 2024 00:21:59 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 4487B6173C;
 Thu,  1 Aug 2024 00:21:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A0AC4AF0C;
 Thu,  1 Aug 2024 00:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722471719;
 bh=cwPs0m+gOE625z9U+MG2gyHPE54rMUGLpyR1T9LRCtY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZInq6htMt1Sg9vDmkZ4x5ZgoC7Ps6pbX2ThlyEuyLSPfYz5hWkmy5PlY+az9BgcjQ
 ztO+Gtu9RAE7W0MxWsxfs6p2+6C7Bf8KvuDuIrZRcuPgZi871IMzYh2TBV+8fyaPB8
 iKPsCoBr5fTRoqBJpo5r4g/k7c7MCqq4Q5T+UcNIATwZeTnsLwuZAIePzbmvVJtoAv
 W4nya80THcHnjObOj9aJDA0vdbzpYI3yiaKqedKAQ3Z/96f1p2rlXQvn0C8F+3qs2b
 KRBHR13ELDtXPQT0y81IPfc1ggZyGO8pbnFAK0UZK5wEWNKxjwiQIDzKy8jtEXLFn9
 X4rFsokcmY2NA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>, Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 harry.wentland@amd.com, sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com,
 christian.koenig@amd.com, Xinhui.Pan@amd.com, airlied@gmail.com,
 daniel@ffwll.ch, wenjing.liu@amd.com, aurabindo.pillai@amd.com,
 zhikai.zhai@amd.com, ivlipski@amd.com, michael.strauss@amd.com,
 sungjoon.kim@amd.com, cruise.hung@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 10/83] drm/amd/display: Check index for
 aux_rd_interval before using
Date: Wed, 31 Jul 2024 20:17:25 -0400
Message-ID: <20240801002107.3934037-10-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801002107.3934037-1-sashal@kernel.org>
References: <20240801002107.3934037-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.43
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
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 9ba2ea6337b4f159aecb177555a6a81da92d302e ]

aux_rd_interval has size of 7 and should be checked.

This fixes 3 OVERRUN and 1 INTEGER_OVERFLOW issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/amd/display/dc/link/protocols/link_dp_training.c  | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
index 16a62e0187122..9d1adfc09fb2a 100644
--- a/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
+++ b/drivers/gpu/drm/amd/display/dc/link/protocols/link_dp_training.c
@@ -914,10 +914,10 @@ static enum dc_status configure_lttpr_mode_non_transparent(
 			/* Driver does not need to train the first hop. Skip DPCD read and clear
 			 * AUX_RD_INTERVAL for DPTX-to-DPIA hop.
 			 */
-			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA)
+			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA && repeater_cnt > 0 && repeater_cnt < MAX_REPEATER_CNT)
 				link->dpcd_caps.lttpr_caps.aux_rd_interval[--repeater_cnt] = 0;
 
-			for (repeater_id = repeater_cnt; repeater_id > 0; repeater_id--) {
+			for (repeater_id = repeater_cnt; repeater_id > 0 && repeater_id < MAX_REPEATER_CNT; repeater_id--) {
 				aux_interval_address = DP_TRAINING_AUX_RD_INTERVAL_PHY_REPEATER1 +
 						((DP_REPEATER_CONFIGURATION_AND_STATUS_SIZE) * (repeater_id - 1));
 				core_link_read_dpcd(
-- 
2.43.0


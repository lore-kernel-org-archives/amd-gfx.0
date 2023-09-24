Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CF7CE7A8A
	for <amd-gfx@archiver.kernel.org>; Sun, 24 Sep 2023 13:17:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC18D10E14E;
	Sun, 24 Sep 2023 13:17:23 +0000 (UTC)
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BA5F10E10F;
 Sun, 24 Sep 2023 13:17:06 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 11D3DB8076A;
 Sun, 24 Sep 2023 13:17:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E57D2C433C7;
 Sun, 24 Sep 2023 13:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1695561424;
 bh=f7svWX4LhN0qqlnBQMmb8TmUmLfmAjr0QCKdIyqSPkQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=O48YInccd7ylnoSvfOOXoAQtMf0PSyelOyy/IUBAFePvcD8aBotcFPjfF1rI0j01c
 TaE7HYd3KriFec/gz4Jf1PJIBAj7SSt9IMUcpLuXD5UfcxN8byGZyzB2civCZybBz1
 n8jc6jCxN+XDF9dFtT8mm/tjaPlQVaMKcTeWYuAcxQjJCzp/gTAzrUiAAApqNNTmqj
 P/c+Ck1IGMWJtqM8jJGxQWK4bdet6eozUeLSLkoM0zP0PIFOS9m1nub/LzOA1drvnh
 dwhFOlsOSeE53whvKAX//KocJykRTum8B+rfa7TaHE5JJULVJsG0zZLdBTbZ2ksGKt
 d00e5+kajodgg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 6.5 27/41] drm/amd/display: Add dirty rect support for
 Replay
Date: Sun, 24 Sep 2023 09:15:15 -0400
Message-Id: <20230924131529.1275335-27-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131529.1275335-1-sashal@kernel.org>
References: <20230924131529.1275335-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.5
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
Cc: Stylon Wang <stylon.wang@amd.com>, Sasha Levin <sashal@kernel.org>,
 srinivasan.shanmugam@amd.com, dri-devel@lists.freedesktop.org,
 Sun peng Li <sunpeng.li@amd.com>, harry.wentland@amd.com,
 qingqing.zhuo@amd.com, Xinhui.Pan@amd.com, Rodrigo.Siqueira@amd.com,
 amd-gfx@lists.freedesktop.org, haoping.liu@amd.com,
 Daniel Wheeler <daniel.wheeler@amd.com>, aurabindo.pillai@amd.com,
 hersenxs.wu@amd.com, hamza.mahfooz@amd.com, daniel@ffwll.ch, wayne.lin@amd.com,
 Alex Deucher <alexander.deucher@amd.com>, airlied@gmail.com,
 Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>, christian.koenig@amd.com
Errors-To: amd-gfx-bounces@lists.freedesktop.org
Sender: "amd-gfx" <amd-gfx-bounces@lists.freedesktop.org>

From: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>

[ Upstream commit 679fc891bf11845730b572fc44f8a0eb846aba29 ]

Dirty rect can be used with replay, so enable them to allow for more
powersaving.

Reviewed-by: Sun peng Li <sunpeng.li@amd.com>
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Bhawanpreet Lakha <bhawanpreet.lakha@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 3123ea2f4f30a..5c63a13f25193 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8038,7 +8038,8 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 		bundle->surface_updates[planes_count].plane_info =
 			&bundle->plane_infos[planes_count];
 
-		if (acrtc_state->stream->link->psr_settings.psr_feature_enabled) {
+		if (acrtc_state->stream->link->psr_settings.psr_feature_enabled ||
+		    acrtc_state->stream->link->replay_settings.replay_feature_enabled) {
 			fill_dc_dirty_rects(plane, old_plane_state,
 					    new_plane_state, new_crtc_state,
 					    &bundle->flip_addrs[planes_count],
-- 
2.40.1


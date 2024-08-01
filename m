Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9902CC3DA7F
	for <amd-gfx@archiver.kernel.org>; Thu,  1 Aug 2024 00:22:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4BFDB10E791;
	Thu,  1 Aug 2024 00:22:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="N0Z4dzgk";
	dkim-atps=neutral
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9444B10E791;
 Thu,  1 Aug 2024 00:22:41 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 93E9BCE1846;
 Thu,  1 Aug 2024 00:22:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9ACC116B1;
 Thu,  1 Aug 2024 00:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1722471758;
 bh=9v87Nkhkou1vZR02QPLdNbvBnfk+Aty21qDFMFLr0yw=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=N0Z4dzgkCXSAV69gtZbgVnq9chbpG0M6QUwkjOqZj2mfZLl4XN6+nh5AKwT7cmZBU
 zDNonzTfw7OP3bLfoxA7fphcWq+1cqciGRDfCycwhvJAku1CIUiOKvQdH0eNZJFyA0
 agSR8R5TDd999VBIDHrUZxOjRO2fOdnMPhgnYfWxQbsTobRoorBwWY0tPfgsa0Bf7x
 irzE1tLFITO+8VhB9ib/EudCP0JfGNZjfRiyb6mHOZfEvQqY0WJnvRjNz2ulinpSrA
 h2gnxMvJFbch8ZEa6odR7kNj0H430/ikvvoiMe2StZuIDfLDnJ0L+Tg+H2aD1TH17v
 jpgTnpdnHUKZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>, Harry Wentland <harry.wentland@amd.com>,
 Tom Chung <chiahsuan.chung@amd.com>,
 Daniel Wheeler <daniel.wheeler@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, Sasha Levin <sashal@kernel.org>,
 sunpeng.li@amd.com, Rodrigo.Siqueira@amd.com, christian.koenig@amd.com,
 Xinhui.Pan@amd.com, airlied@gmail.com, daniel@ffwll.ch,
 hamza.mahfooz@amd.com, roman.li@amd.com, mario.limonciello@amd.com,
 Wayne.Lin@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.6 17/83] drm/amd/display: Spinlock before reading
 event
Date: Wed, 31 Jul 2024 20:17:32 -0400
Message-ID: <20240801002107.3934037-17-sashal@kernel.org>
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

[ Upstream commit ae13c8a5cff92015b9a3eb7cee65ebc75859487f ]

[WHY & HOW]
A read of acrtc_attach->base.state->event was not locked so moving it
inside the spinlock.

This fixes a LOCK_EVASION issue reported by Coverity.

Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 5eef17f092ceb..875661737f496 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -8370,15 +8370,13 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_state *state,
 				bundle->stream_update.vrr_infopacket =
 					&acrtc_state->stream->vrr_infopacket;
 		}
-	} else if (cursor_update && acrtc_state->active_planes > 0 &&
-		   acrtc_attach->base.state->event) {
-		drm_crtc_vblank_get(pcrtc);
-
+	} else if (cursor_update && acrtc_state->active_planes > 0) {
 		spin_lock_irqsave(&pcrtc->dev->event_lock, flags);
-
-		acrtc_attach->event = acrtc_attach->base.state->event;
-		acrtc_attach->base.state->event = NULL;
-
+		if (acrtc_attach->base.state->event) {
+			drm_crtc_vblank_get(pcrtc);
+			acrtc_attach->event = acrtc_attach->base.state->event;
+			acrtc_attach->base.state->event = NULL;
+		}
 		spin_unlock_irqrestore(&pcrtc->dev->event_lock, flags);
 	}
 
-- 
2.43.0


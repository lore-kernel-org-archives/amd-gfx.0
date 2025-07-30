Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3707FC87FC9
	for <amd-gfx@archiver.kernel.org>; Wed, 30 Jul 2025 08:09:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B183810E420;
	Wed, 30 Jul 2025 08:09:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=daenzer.net header.i=@daenzer.net header.b="EoqXSGMH";
	dkim-atps=neutral
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7635C10E420
 for <amd-gfx@lists.freedesktop.org>; Wed, 30 Jul 2025 08:09:08 +0000 (UTC)
DKIM-Signature: a=rsa-sha256; t=1753862944; x=1754467744; s=webland;
 d=daenzer.net; c=relaxed/relaxed; v=1;
 bh=dpwITeteiCS22pIResg8Kq4WvIoDIB6IlV8qrSJxR4M=;
 h=From:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
 b=EoqXSGMHe/Mg+/MGr8Ykm6qq8sGCvQDtSxTnag5OxHtoz6KRF9ioqXN61aua+pPLNDuI8huF0JStN20JbiEqbe8H8sir+vJOhz+cG9EvjjF21Fn7YaBWcb1ALTCM6dvRFPLPmXiwyUaf3ZeP2HVwvnyjFNFnhA0ZAqxgeydRtnJMrDuO1oM+V4sZXdPSTYja80RC81Ex+rZKn9hra6qsGXpOYfICm8wGkKBLsv7UNLhP0ZRejX0CwLMbFd9ZQn6GINnnYiPSj4zELJz1Mb6Jfhdf30AVbxNt4hDYAPl3gjJJ/vxWMgQMyjoo8RizuNaq70hnPHTo/MCzWDXZI6+C6A==
Received: from kaveri ([213.144.156.170])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202507301009032192; Wed, 30 Jul 2025 10:09:03 +0200
Received: from daenzer by kaveri with local (Exim 4.98.2)
 (envelope-from <michel@daenzer.net>) id 1uh1ry-000000001me-2CWc;
 Wed, 30 Jul 2025 10:09:02 +0200
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Alex Hung <alex.hung@amd.com>, Xaver Hugl <xaver.hugl@kde.org>
Cc: amd-gfx@lists.freedesktop.org
Subject: [PATCH] drm/amd/display: Add primary plane to commits for correct VRR
 handling
Date: Wed, 30 Jul 2025 10:09:02 +0200
Message-ID: <20250730080902.6849-1-michel@daenzer.net>
X-Mailer: git-send-email 2.50.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Michel Dänzer <mdaenzer@redhat.com>

amdgpu_dm_commit_planes calls update_freesync_state_on_stream only for
the primary plane. If a commit affects a CRTC but not its primary plane,
it would previously not trigger a refresh cycle or affect LFC, violating
current UAPI semantics.

Fixes e.g. atomic commits affecting only the cursor plane being limited
to the minimum refresh rate.

Don't do this for the legacy cursor ioctls though, it would break the
UAPI semantics for those.

Suggested-by: Xaver Hugl <xaver.hugl@kde.org>
Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3034
Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
index 2551823382f8..010172f930ae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
@@ -661,6 +661,15 @@ static int amdgpu_dm_crtc_helper_atomic_check(struct drm_crtc *crtc,
 		return -EINVAL;
 	}
 
+	if (!state->legacy_cursor_update && amdgpu_dm_crtc_vrr_active(dm_crtc_state)) {
+		struct drm_plane_state *primary_state;
+
+		/* Pull in primary plane for correct VRR handling */
+		primary_state = drm_atomic_get_plane_state(state, crtc->primary);
+		if (IS_ERR(primary_state))
+			return PTR_ERR(primary_state);
+	}
+
 	/* In some use cases, like reset, no stream is attached */
 	if (!dm_crtc_state->stream)
 		return 0;
-- 
2.50.0


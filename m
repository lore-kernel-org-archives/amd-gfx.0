Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9683E784B3
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 14:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00D3110E2BE;
	Mon,  2 Oct 2023 14:17:00 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C468A10E2BE
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 14:16:54 +0000 (UTC)
Received: from kaveri ([213.144.156.170])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202310021616516319; Mon, 02 Oct 2023 16:16:51 +0200
Received: from daenzer by kaveri with local (Exim 4.97-RC0)
 (envelope-from <michel@daenzer.net>) id 1qnJj7-000000004ff-36ql;
 Mon, 02 Oct 2023 16:16:49 +0200
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: Alex Deucher <alexander.deucher@amd.com>, Simon Ser <contact@emersion.fr>
Subject: [PATCH 2/2] drm/amd/display: Bail from dm_check_crtc_cursor if no
 relevant change
Date: Mon,  2 Oct 2023 16:16:49 +0200
Message-ID: <20231002141649.17943-2-michel@daenzer.net>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231002141649.17943-1-michel@daenzer.net>
References: <20231002141649.17943-1-michel@daenzer.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F1F.651AD0D3.000E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
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

If no plane was newly enabled or changed scaling, there can be no new
scaling mismatch with the cursor plane.

By not pulling non-cursor plane states into all atomic commits while
the cursor plane is enabled, this avoids synchronizing all cursor plane
changes to vertical blank, which caused the following IGT tests to fail:

kms_cursor_legacy@cursor-vs-flip.*
kms_cursor_legacy@flip-vs-cursor.*

Fixes: 45e1ade04b4d ("drm/amd/display: Check all enabled planes in dm_check_crtc_cursor")
Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 33 ++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0173828e1f61..7480527805cc 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9907,10 +9907,12 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 				struct drm_crtc *crtc,
 				struct drm_crtc_state *new_crtc_state)
 {
-	struct drm_plane *cursor = crtc->cursor, *underlying;
+	struct drm_plane *cursor = crtc->cursor, *plane, *underlying;
+	struct drm_plane_state *old_plane_state, *new_plane_state;
 	struct drm_plane_state *new_cursor_state, *new_underlying_state;
 	int i;
 	int cursor_scale_w, cursor_scale_h, underlying_scale_w, underlying_scale_h;
+	bool any_relevant_change = false;
 
 	/* On DCE and DCN there is no dedicated hardware cursor plane. We get a
 	 * cursor per pipe but it's going to inherit the scaling and
@@ -9918,6 +9920,35 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 	 * blending properties match the underlying planes'.
 	 */
 
+	/* If no plane was enabled or changed scaling, no need to check again */
+	for_each_oldnew_plane_in_state(state, plane, old_plane_state, new_plane_state, i) {
+		int new_scale_w, new_scale_h, old_scale_w, old_scale_h;
+
+		if (!new_plane_state || !new_plane_state->fb || new_plane_state->crtc != crtc)
+			continue;
+
+		if (!old_plane_state || !old_plane_state->fb || old_plane_state->crtc != crtc) {
+			any_relevant_change = true;
+			break;
+		}
+
+		if (new_plane_state->fb == old_plane_state->fb &&
+		    new_plane_state->crtc_w == old_plane_state->crtc_w &&
+		    new_plane_state->crtc_h == old_plane_state->crtc_h)
+			continue;
+
+		dm_get_plane_scale(new_plane_state, &new_scale_w, &new_scale_h);
+		dm_get_plane_scale(old_plane_state, &old_scale_w, &old_scale_h);
+
+		if (new_scale_w != old_scale_w || new_scale_h != old_scale_h) {
+			any_relevant_change = true;
+			break;
+		}
+	}
+
+	if (!any_relevant_change)
+		return 0;
+
 	new_cursor_state = drm_atomic_get_plane_state(state, cursor);
 	if (IS_ERR(new_cursor_state))
 		return PTR_ERR(new_cursor_state);
-- 
2.42.0


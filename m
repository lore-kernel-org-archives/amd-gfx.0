Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46486CA0EC3
	for <amd-gfx@archiver.kernel.org>; Tue, 12 Sep 2023 10:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A91EE10E06A;
	Tue, 12 Sep 2023 10:22:53 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE8BA10E06A
 for <amd-gfx@lists.freedesktop.org>; Tue, 12 Sep 2023 10:22:51 +0000 (UTC)
Received: from kaveri ([213.144.156.170])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202309121222450131; Tue, 12 Sep 2023 12:22:45 +0200
Received: from daenzer by kaveri with local (Exim 4.96)
 (envelope-from <michel@daenzer.net>) id 1qg0XI-0001G1-0n;
 Tue, 12 Sep 2023 12:22:24 +0200
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: Alex Deucher <alexander.deucher@amd.com>, Simon Ser <contact@emersion.fr>
Subject: [PATCH] drm/amd/display: Check all enabled planes in
 dm_check_crtc_cursor
Date: Tue, 12 Sep 2023 12:22:24 +0200
Message-Id: <20230912102224.4826-1-michel@daenzer.net>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F18.65003BF5.0061,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
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

It was only checking planes which had any state changes in the same
commit. However, it also needs to check other enabled planes.

Not doing this meant that a commit might spuriously "succeed", resulting
in the cursor plane displaying with incorrect scaling. See
https://gitlab.gnome.org/GNOME/mutter/-/merge_requests/3177#note_1824263
for an example.

Fixes: d1bfbe8a3202 ("amd/display: check cursor plane matches underlying plane")
Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 88ba8b66de1f..81c9d39567db 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9836,14 +9836,24 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 	 * blending properties match the underlying planes'.
 	 */
 
-	new_cursor_state = drm_atomic_get_new_plane_state(state, cursor);
-	if (!new_cursor_state || !new_cursor_state->fb)
+	new_cursor_state = drm_atomic_get_plane_state(state, cursor);
+	if (IS_ERR(new_cursor_state))
+		return PTR_ERR(new_cursor_state);
+
+	if (!new_cursor_state->fb)
 		return 0;
 
 	dm_get_oriented_plane_size(new_cursor_state, &cursor_src_w, &cursor_src_h);
 	cursor_scale_w = new_cursor_state->crtc_w * 1000 / cursor_src_w;
 	cursor_scale_h = new_cursor_state->crtc_h * 1000 / cursor_src_h;
 
+	/* Need to check all enabled planes, even if this commit doesn't change
+	 * their state
+	 */
+	i = drm_atomic_add_affected_planes(state, crtc);
+	if (i)
+		return i;
+
 	for_each_new_plane_in_state_reverse(state, underlying, new_underlying_state, i) {
 		/* Narrow down to non-cursor planes on the same CRTC as the cursor */
 		if (new_underlying_state->crtc != crtc || underlying == crtc->cursor)
-- 
2.40.1


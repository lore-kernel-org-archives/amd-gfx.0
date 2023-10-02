Return-Path: <amd-gfx-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89B1E784AD
	for <amd-gfx@archiver.kernel.org>; Mon,  2 Oct 2023 14:17:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA7A310E2C4;
	Mon,  2 Oct 2023 14:17:04 +0000 (UTC)
Received: from ms7.webland.ch (ms7.webland.ch [92.43.217.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 570E189A94
 for <amd-gfx@lists.freedesktop.org>; Mon,  2 Oct 2023 14:16:55 +0000 (UTC)
Received: from kaveri ([213.144.156.170])
 by ms7.webland.ch (12.3.0 build 2 x64) with ASMTP (SSL) id
 01202310021616516320; Mon, 02 Oct 2023 16:16:51 +0200
Received: from daenzer by kaveri with local (Exim 4.97-RC0)
 (envelope-from <michel@daenzer.net>) id 1qnJj7-000000004fc-2nqs;
 Mon, 02 Oct 2023 16:16:49 +0200
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: Alex Deucher <alexander.deucher@amd.com>, Simon Ser <contact@emersion.fr>
Subject: [PATCH 1/2] drm/amd/display: Refactor dm_get_plane_scale helper
Date: Mon,  2 Oct 2023 16:16:48 +0200
Message-ID: <20231002141649.17943-1-michel@daenzer.net>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CTCH: RefID="str=0001.0A782F1F.651AD0D3.0016,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0";
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

Cleanup, no functional change intended.

Signed-off-by: Michel Dänzer <mdaenzer@redhat.com>
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 23 +++++++++++--------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 19aeb1aa1276..0173828e1f61 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9892,6 +9892,17 @@ static void dm_get_oriented_plane_size(struct drm_plane_state *plane_state,
 	}
 }
 
+static void
+dm_get_plane_scale(struct drm_plane_state *plane_state,
+		   int *out_plane_scale_w, int *out_plane_scale_h)
+{
+	int plane_src_w, plane_src_h;
+
+	dm_get_oriented_plane_size(plane_state, &plane_src_w, &plane_src_h);
+	*out_plane_scale_w = plane_state->crtc_w * 1000 / plane_src_w;
+	*out_plane_scale_h = plane_state->crtc_h * 1000 / plane_src_h;
+}
+
 static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 				struct drm_crtc *crtc,
 				struct drm_crtc_state *new_crtc_state)
@@ -9900,8 +9911,6 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 	struct drm_plane_state *new_cursor_state, *new_underlying_state;
 	int i;
 	int cursor_scale_w, cursor_scale_h, underlying_scale_w, underlying_scale_h;
-	int cursor_src_w, cursor_src_h;
-	int underlying_src_w, underlying_src_h;
 
 	/* On DCE and DCN there is no dedicated hardware cursor plane. We get a
 	 * cursor per pipe but it's going to inherit the scaling and
@@ -9916,9 +9925,7 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 	if (!new_cursor_state->fb)
 		return 0;
 
-	dm_get_oriented_plane_size(new_cursor_state, &cursor_src_w, &cursor_src_h);
-	cursor_scale_w = new_cursor_state->crtc_w * 1000 / cursor_src_w;
-	cursor_scale_h = new_cursor_state->crtc_h * 1000 / cursor_src_h;
+	dm_get_plane_scale(new_cursor_state, &cursor_scale_w, &cursor_scale_h);
 
 	/* Need to check all enabled planes, even if this commit doesn't change
 	 * their state
@@ -9936,10 +9943,8 @@ static int dm_check_crtc_cursor(struct drm_atomic_state *state,
 		if (!new_underlying_state->fb)
 			continue;
 
-		dm_get_oriented_plane_size(new_underlying_state,
-					   &underlying_src_w, &underlying_src_h);
-		underlying_scale_w = new_underlying_state->crtc_w * 1000 / underlying_src_w;
-		underlying_scale_h = new_underlying_state->crtc_h * 1000 / underlying_src_h;
+		dm_get_plane_scale(new_underlying_state,
+				   &underlying_scale_w, &underlying_scale_h);
 
 		if (cursor_scale_w != underlying_scale_w ||
 		    cursor_scale_h != underlying_scale_h) {
-- 
2.42.0


From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] drm/amd/display: Fix potential NULL pointer dereferences in
 amdgpu_dm_atomic_commit_tail
Date: Mon, 27 Nov 2017 08:57:00 -0600
Message-ID: <20171127145700.GA18395@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: amd-gfx.lists.freedesktop.org

dm_new_crtc_state->stream and disconnected_acrtc are being dereferenced
before they are null checked, hence there is a potential null pointer
dereference.

Fix this by null checking such pointers before they are dereferenced.

Addresses-Coverity-ID: 1423745 ("Dereference before null check")
Addresses-Coverity-ID: 1423833 ("Dereference before null check")
Fixes: e7b07ceef2a6 ("drm/amd/display: Merge amdgpu_dm_types and amdgpu_dm")
Fixes: 54d765752467 ("drm/amd/display: Unify amdgpu_dm state variable namings.")
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 889ed24..3bdd137 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4190,6 +4190,9 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 
 		dm_new_crtc_state = to_dm_crtc_state(new_crtc_state);
 
+		if (!dm_new_crtc_state->stream)
+			continue;
+
 		update_stream_scaling_settings(&dm_new_con_state->base.crtc->mode,
 				dm_new_con_state, (struct dc_stream_state *)dm_new_crtc_state->stream);
 
@@ -4197,9 +4200,6 @@ static void amdgpu_dm_atomic_commit_tail(struct drm_atomic_state *state)
 		WARN_ON(!status);
 		WARN_ON(!status->plane_count);
 
-		if (!dm_new_crtc_state->stream)
-			continue;
-
 		/*TODO How it works with MPO ?*/
 		if (!dc_commit_planes_to_stream(
 				dm->dc,
@@ -4332,9 +4332,11 @@ void dm_restore_drm_connector_state(struct drm_device *dev,
 		return;
 
 	disconnected_acrtc = to_amdgpu_crtc(connector->encoder->crtc);
-	acrtc_state = to_dm_crtc_state(disconnected_acrtc->base.state);
+	if (!disconnected_acrtc)
+		return;
 
-	if (!disconnected_acrtc || !acrtc_state->stream)
+	acrtc_state = to_dm_crtc_state(disconnected_acrtc->base.state);
+	if (!acrtc_state->stream)
 		return;
 
 	/*
-- 
2.7.4

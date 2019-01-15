From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/amdgpu: Replace kzalloc with kcalloc
Date: Mon, 14 Jan 2019 23:22:02 -0600
Message-ID: <20190115052202.GA8537@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: amd-gfx.lists.freedesktop.org

Replace kzalloc() function with its 2-factor argument form, kcalloc().

This patch replaces cases of:

	kzalloc(a * b, gfp)

with:
	kcalloc(a, b, gfp)

Also, improve the coding style and the use of sizeof during
allocation by changing sizeof(struct dc_surface_update) and
sizeof(struct dc_plane_state) to sizeof(*updates) and
sizeof(*surfaces), correspondingly.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a3e65e457348..4c201de38329 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5782,11 +5782,14 @@ dm_determine_update_type_for_commit(struct dc *dc,
 	struct dm_crtc_state *new_dm_crtc_state, *old_dm_crtc_state;
 	struct dc_stream_status *status = NULL;
 
-	struct dc_surface_update *updates = kzalloc(MAX_SURFACES * sizeof(struct dc_surface_update), GFP_KERNEL);
-	struct dc_plane_state *surface = kzalloc(MAX_SURFACES * sizeof(struct dc_plane_state), GFP_KERNEL);
+	struct dc_surface_update *updates;
+	struct dc_plane_state *surface;
 	struct dc_stream_update stream_update;
 	enum surface_update_type update_type = UPDATE_TYPE_FAST;
 
+	updates = kcalloc(MAX_SURFACES, sizeof(*updates), GFP_KERNEL);
+	surface = kcalloc(MAX_SURFACES, sizeof(*surface), GFP_KERNEL);
+
 	if (!updates || !surface) {
 		DRM_ERROR("Plane or surface update failed to allocate");
 		/* Set type to FULL to avoid crashing in DC*/
-- 
2.20.1

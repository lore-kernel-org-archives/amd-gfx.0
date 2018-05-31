From: Harry Wentland <harry.wentland@amd.com>
Subject: [PATCH 08/18] drm/amd/display: Update color props when modeset is required
Date: Thu, 31 May 2018 10:23:37 -0400
Message-ID: <20180531142347.4086-9-harry.wentland@amd.com>
References: <20180531142347.4086-1-harry.wentland@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180531142347.4086-1-harry.wentland@amd.com>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: "Leo (Sunpeng) Li" <sunpeng.li@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: "Leo (Sunpeng) Li" <sunpeng.li@amd.com>

This fixes issues where color management properties don't persist
over DPMS on/off, or when the CRTC is moved across connectors.

Signed-off-by: Leo (Sunpeng) Li <sunpeng.li@amd.com>
Reviewed-by: Harry Wentland <Harry.Wentland@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index b6020a83cdb0..29176d2c5d6e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4848,8 +4848,12 @@ static int dm_update_crtcs_state(struct amdgpu_display_manager *dm,
 			update_stream_scaling_settings(
 				&new_crtc_state->mode, dm_new_conn_state, dm_new_crtc_state->stream);
 
-		/* Color managment settings */
-		if (dm_new_crtc_state->base.color_mgmt_changed) {
+		/*
+		 * Color management settings. We also update color properties
+		 * when a modeset is needed, to ensure it gets reprogrammed.
+		 */
+		if (dm_new_crtc_state->base.color_mgmt_changed ||
+		    drm_atomic_crtc_needs_modeset(new_crtc_state)) {
 			ret = amdgpu_dm_set_regamma_lut(dm_new_crtc_state);
 			if (ret)
 				goto fail;
-- 
2.17.0

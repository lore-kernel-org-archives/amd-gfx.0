From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] drm/radeon: change vblank_time's calculation method to reduce computational error.
Date: Wed, 12 Oct 2016 15:29:43 -0400
Message-ID: <1476300583-28928-1-git-send-email-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Ported from Rex's amdgpu change.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/radeon/r600_dpm.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/radeon/r600_dpm.c b/drivers/gpu/drm/radeon/r600_dpm.c
index 6a4b020..5a26eb4 100644
--- a/drivers/gpu/drm/radeon/r600_dpm.c
+++ b/drivers/gpu/drm/radeon/r600_dpm.c
@@ -156,19 +156,20 @@ u32 r600_dpm_get_vblank_time(struct radeon_device *rdev)
 	struct drm_device *dev = rdev->ddev;
 	struct drm_crtc *crtc;
 	struct radeon_crtc *radeon_crtc;
-	u32 line_time_us, vblank_lines;
+	u32 vblank_in_pixels;
 	u32 vblank_time_us = 0xffffffff; /* if the displays are off, vblank time is max */
 
 	if (rdev->num_crtc && rdev->mode_info.mode_config_initialized) {
 		list_for_each_entry(crtc, &dev->mode_config.crtc_list, head) {
 			radeon_crtc = to_radeon_crtc(crtc);
 			if (crtc->enabled && radeon_crtc->enabled && radeon_crtc->hw_mode.clock) {
-				line_time_us = (radeon_crtc->hw_mode.crtc_htotal * 1000) /
-					radeon_crtc->hw_mode.clock;
-				vblank_lines = radeon_crtc->hw_mode.crtc_vblank_end -
-					radeon_crtc->hw_mode.crtc_vdisplay +
-					(radeon_crtc->v_border * 2);
-				vblank_time_us = vblank_lines * line_time_us;
+				vblank_in_pixels =
+					radeon_crtc->hw_mode.crtc_htotal *
+					(radeon_crtc->hw_mode.crtc_vblank_end -
+					 radeon_crtc->hw_mode.crtc_vdisplay +
+					 (radeon_crtc->v_border * 2));
+
+				vblank_time_us = vblank_in_pixels * 1000 / radeon_crtc->hw_mode.clock;
 				break;
 			}
 		}
-- 
2.5.5

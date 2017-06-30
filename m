From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] drm/amdgpu/cgs: always set reference clock in mode_info
Date: Fri, 30 Jun 2017 10:05:19 -0400
Message-ID: <1498831519-15771-1-git-send-email-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

It's relevent regardless of whether there are displays
enabled.  Fixes garbage values for ref clock in powerplay
leading to incorrect fan speed reporting when displays
are disabled.

bug: https://bugs.freedesktop.org/show_bug.cgi?id=101653
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index 8b8eda7..c0a8062 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -838,9 +838,12 @@ static int amdgpu_cgs_get_active_displays_info(struct cgs_device *cgs_device,
 		return -EINVAL;
 
 	mode_info = info->mode_info;
-	if (mode_info)
+	if (mode_info) {
 		/* if the displays are off, vblank time is max */
 		mode_info->vblank_time_us = 0xffffffff;
+		/* always set the reference clock */
+		mode_info->ref_clock = adev->clock.spll.reference_freq;
+	}
 
 	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
 		list_for_each_entry(crtc,
-- 
2.5.5

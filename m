From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] drm/amdgpu: fix vblank_time when displays are off
Date: Thu, 29 Jun 2017 16:16:38 -0400
Message-ID: <1498767398-28231-1-git-send-email-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

If the displays are off, set the vblank time to max to make
sure mclk switching is enabled.  Avoid mclk getting set
to high when no displays are attached.

bug: https://bugs.freedesktop.org/show_bug.cgi?id=101528
fixes: 09be4a5219 (drm/amd/powerplay/smu7: add vblank check for mclk switching (v2))
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index c6dba1e..8b8eda7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -838,6 +838,9 @@ static int amdgpu_cgs_get_active_displays_info(struct cgs_device *cgs_device,
 		return -EINVAL;
 
 	mode_info = info->mode_info;
+	if (mode_info)
+		/* if the displays are off, vblank time is max */
+		mode_info->vblank_time_us = 0xffffffff;
 
 	if (adev->mode_info.num_crtc && adev->mode_info.mode_config_initialized) {
 		list_for_each_entry(crtc,
-- 
2.5.5

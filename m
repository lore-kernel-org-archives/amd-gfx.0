From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] Revert "drm/radeon: dont switch vt on suspend"
Date: Tue, 14 Nov 2017 17:33:00 -0500
Message-ID: <20171114223300.28026-1-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Fixes distorted colors on some cards on resume from suspend.

This reverts commit b9729b17a414f99c61f4db9ac9f9ed987fa0cbfe.

Bug: https://bugs.freedesktop.org/show_bug.cgi?id=98832
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/radeon/radeon_fb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_fb.c b/drivers/gpu/drm/radeon/radeon_fb.c
index 2fcf805d3a16..33b821d6d018 100644
--- a/drivers/gpu/drm/radeon/radeon_fb.c
+++ b/drivers/gpu/drm/radeon/radeon_fb.c
@@ -245,7 +245,6 @@ static int radeonfb_create(struct drm_fb_helper *helper,
 	}
 
 	info->par = rfbdev;
-	info->skip_vt_switch = true;
 
 	ret = radeon_framebuffer_init(rdev->ddev, &rfbdev->rfb, &mode_cmd, gobj);
 	if (ret) {
-- 
2.13.6

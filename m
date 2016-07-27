From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH 1/2] drm/radeon: fix firmware info version checks
Date: Wed, 27 Jul 2016 16:09:30 -0400
Message-ID: <1469650171-7218-1-git-send-email-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Some of the checks didn't handle frev 2 tables properly.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/radeon/radeon_atombios.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
index f8097a0..5df3ec7 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.c
+++ b/drivers/gpu/drm/radeon/radeon_atombios.c
@@ -1155,7 +1155,7 @@ bool radeon_atom_get_clock_info(struct drm_device *dev)
 		    le16_to_cpu(firmware_info->info.usReferenceClock);
 		p1pll->reference_div = 0;
 
-		if (crev < 2)
+		if ((frev < 2) && (crev < 2))
 			p1pll->pll_out_min =
 				le16_to_cpu(firmware_info->info.usMinPixelClockPLL_Output);
 		else
@@ -1164,7 +1164,7 @@ bool radeon_atom_get_clock_info(struct drm_device *dev)
 		p1pll->pll_out_max =
 		    le32_to_cpu(firmware_info->info.ulMaxPixelClockPLL_Output);
 
-		if (crev >= 4) {
+		if (((frev < 2) && (crev >= 4)) || (frev >= 2)) {
 			p1pll->lcd_pll_out_min =
 				le16_to_cpu(firmware_info->info_14.usLcdMinPixelClockPLL_Output) * 100;
 			if (p1pll->lcd_pll_out_min == 0)
-- 
2.5.5

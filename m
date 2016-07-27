From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH 2/2] drm/amdgpu: fix firmware info version checks
Date: Wed, 27 Jul 2016 16:09:31 -0400
Message-ID: <1469650171-7218-2-git-send-email-alexander.deucher@amd.com>
References: <1469650171-7218-1-git-send-email-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1469650171-7218-1-git-send-email-alexander.deucher@amd.com>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Some of the checks didn't handle frev 2 tables properly.
amdgpu doesn't support any tables pre-frev 2, so drop
the checks.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 9df1bcb..9831753 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -551,28 +551,19 @@ int amdgpu_atombios_get_clock_info(struct amdgpu_device *adev)
 		    le16_to_cpu(firmware_info->info.usReferenceClock);
 		ppll->reference_div = 0;
 
-		if (crev < 2)
-			ppll->pll_out_min =
-				le16_to_cpu(firmware_info->info.usMinPixelClockPLL_Output);
-		else
-			ppll->pll_out_min =
-				le32_to_cpu(firmware_info->info_12.ulMinPixelClockPLL_Output);
+		ppll->pll_out_min =
+			le32_to_cpu(firmware_info->info_12.ulMinPixelClockPLL_Output);
 		ppll->pll_out_max =
 		    le32_to_cpu(firmware_info->info.ulMaxPixelClockPLL_Output);
 
-		if (crev >= 4) {
-			ppll->lcd_pll_out_min =
-				le16_to_cpu(firmware_info->info_14.usLcdMinPixelClockPLL_Output) * 100;
-			if (ppll->lcd_pll_out_min == 0)
-				ppll->lcd_pll_out_min = ppll->pll_out_min;
-			ppll->lcd_pll_out_max =
-				le16_to_cpu(firmware_info->info_14.usLcdMaxPixelClockPLL_Output) * 100;
-			if (ppll->lcd_pll_out_max == 0)
-				ppll->lcd_pll_out_max = ppll->pll_out_max;
-		} else {
+		ppll->lcd_pll_out_min =
+			le16_to_cpu(firmware_info->info_14.usLcdMinPixelClockPLL_Output) * 100;
+		if (ppll->lcd_pll_out_min == 0)
 			ppll->lcd_pll_out_min = ppll->pll_out_min;
+		ppll->lcd_pll_out_max =
+			le16_to_cpu(firmware_info->info_14.usLcdMaxPixelClockPLL_Output) * 100;
+		if (ppll->lcd_pll_out_max == 0)
 			ppll->lcd_pll_out_max = ppll->pll_out_max;
-		}
 
 		if (ppll->pll_out_min == 0)
 			ppll->pll_out_min = 64800;
-- 
2.5.5

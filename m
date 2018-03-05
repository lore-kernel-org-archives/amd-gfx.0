From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH 1/2] drm/radeon: fix KV harvesting
Date: Mon,  5 Mar 2018 13:30:13 -0500
Message-ID: <20180305183014.4861-1-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Always set the graphics values to the max for the
asic type.  E.g., some 1 RB chips are actually 1 RB chips,
others are actually harvested 2 RB chips.

Fixes: https://bugs.freedesktop.org/show_bug.cgi?id=99353
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/radeon/cik.c | 31 ++-----------------------------
 1 file changed, 2 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/radeon/cik.c b/drivers/gpu/drm/radeon/cik.c
index d3045a371a55..7c73bc7e2f85 100644
--- a/drivers/gpu/drm/radeon/cik.c
+++ b/drivers/gpu/drm/radeon/cik.c
@@ -3221,35 +3221,8 @@ static void cik_gpu_init(struct radeon_device *rdev)
 	case CHIP_KAVERI:
 		rdev->config.cik.max_shader_engines = 1;
 		rdev->config.cik.max_tile_pipes = 4;
-		if ((rdev->pdev->device == 0x1304) ||
-		    (rdev->pdev->device == 0x1305) ||
-		    (rdev->pdev->device == 0x130C) ||
-		    (rdev->pdev->device == 0x130F) ||
-		    (rdev->pdev->device == 0x1310) ||
-		    (rdev->pdev->device == 0x1311) ||
-		    (rdev->pdev->device == 0x131C)) {
-			rdev->config.cik.max_cu_per_sh = 8;
-			rdev->config.cik.max_backends_per_se = 2;
-		} else if ((rdev->pdev->device == 0x1309) ||
-			   (rdev->pdev->device == 0x130A) ||
-			   (rdev->pdev->device == 0x130D) ||
-			   (rdev->pdev->device == 0x1313) ||
-			   (rdev->pdev->device == 0x131D)) {
-			rdev->config.cik.max_cu_per_sh = 6;
-			rdev->config.cik.max_backends_per_se = 2;
-		} else if ((rdev->pdev->device == 0x1306) ||
-			   (rdev->pdev->device == 0x1307) ||
-			   (rdev->pdev->device == 0x130B) ||
-			   (rdev->pdev->device == 0x130E) ||
-			   (rdev->pdev->device == 0x1315) ||
-			   (rdev->pdev->device == 0x1318) ||
-			   (rdev->pdev->device == 0x131B)) {
-			rdev->config.cik.max_cu_per_sh = 4;
-			rdev->config.cik.max_backends_per_se = 1;
-		} else {
-			rdev->config.cik.max_cu_per_sh = 3;
-			rdev->config.cik.max_backends_per_se = 1;
-		}
+		rdev->config.cik.max_cu_per_sh = 8;
+		rdev->config.cik.max_backends_per_se = 2;
 		rdev->config.cik.max_sh_per_se = 1;
 		rdev->config.cik.max_texture_channel_caches = 4;
 		rdev->config.cik.max_gprs = 256;
-- 
2.13.6

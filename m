From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH 1/2] drm/radeon: add additional pci revision to dpm workaround
Date: Fri,  2 Dec 2016 00:25:42 -0500
Message-ID: <1480656343-330-1-git-send-email-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

New variant.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/radeon/si_dpm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/radeon/si_dpm.c b/drivers/gpu/drm/radeon/si_dpm.c
index c4993452..8b5e697 100644
--- a/drivers/gpu/drm/radeon/si_dpm.c
+++ b/drivers/gpu/drm/radeon/si_dpm.c
@@ -3026,6 +3026,7 @@ static void si_apply_state_adjust_rules(struct radeon_device *rdev,
 		    (rdev->pdev->revision == 0x80) ||
 		    (rdev->pdev->revision == 0x81) ||
 		    (rdev->pdev->revision == 0x83) ||
+		    (rdev->pdev->revision == 0x87) ||
 		    (rdev->pdev->device == 0x6604) ||
 		    (rdev->pdev->device == 0x6605)) {
 			max_sclk = 75000;
-- 
2.5.5

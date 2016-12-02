From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH 2/2] drm/radeon/si: load the proper firmware on 0x87 oland boards
Date: Fri,  2 Dec 2016 00:25:43 -0500
Message-ID: <1480656343-330-2-git-send-email-alexander.deucher@amd.com>
References: <1480656343-330-1-git-send-email-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1480656343-330-1-git-send-email-alexander.deucher@amd.com>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

New variant.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/radeon/si.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/radeon/si.c b/drivers/gpu/drm/radeon/si.c
index 143280d..ad4d7b8 100644
--- a/drivers/gpu/drm/radeon/si.c
+++ b/drivers/gpu/drm/radeon/si.c
@@ -1714,6 +1714,7 @@ static int si_init_microcode(struct radeon_device *rdev)
 		    (rdev->pdev->revision == 0x80) ||
 		    (rdev->pdev->revision == 0x81) ||
 		    (rdev->pdev->revision == 0x83) ||
+		    (rdev->pdev->revision == 0x87) ||
 		    (rdev->pdev->device == 0x6604) ||
 		    (rdev->pdev->device == 0x6605))
 			new_smc = true;
-- 
2.5.5

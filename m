From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH 2/2] drm/amdgpu/si: load the proper firmware on 0x87 oland boards
Date: Mon,  5 Dec 2016 13:06:32 -0500
Message-ID: <1480961192-23310-2-git-send-email-alexander.deucher@amd.com>
References: <1480961192-23310-1-git-send-email-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1480961192-23310-1-git-send-email-alexander.deucher@amd.com>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

New variant.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/si_dpm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/si_dpm.c b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
index 95c4e25..6c65a1a 100644
--- a/drivers/gpu/drm/amd/amdgpu/si_dpm.c
+++ b/drivers/gpu/drm/amd/amdgpu/si_dpm.c
@@ -7716,6 +7716,7 @@ static int si_dpm_init_microcode(struct amdgpu_device *adev)
 		    (adev->pdev->revision == 0x80) ||
 		    (adev->pdev->revision == 0x81) ||
 		    (adev->pdev->revision == 0x83) ||
+		    (adev->pdev->revision == 0x87) ||
 		    (adev->pdev->device == 0x6604) ||
 		    (adev->pdev->device == 0x6605))
 			chip_name = "oland_k";
-- 
2.5.5

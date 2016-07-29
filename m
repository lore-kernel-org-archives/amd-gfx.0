From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] drm/amdgpu/gmc7: add missing mullins case
Date: Fri, 29 Jul 2016 18:06:10 -0400
Message-ID: <1469829970-15466-1-git-send-email-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Looks like this got missed when we ported the code from radeon.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
index d24a82b..0b0f086 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v7_0.c
@@ -144,6 +144,7 @@ static int gmc_v7_0_init_microcode(struct amdgpu_device *adev)
 		break;
 	case CHIP_KAVERI:
 	case CHIP_KABINI:
+	case CHIP_MULLINS:
 		return 0;
 	default: BUG();
 	}
-- 
2.5.5

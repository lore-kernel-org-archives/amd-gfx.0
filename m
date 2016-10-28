From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] drm/amdgpu: add support for new smc firmware on iceland
Date: Fri, 28 Oct 2016 17:05:09 -0400
Message-ID: <1477688709-26603-1-git-send-email-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Newer iceland parts require new smc firmware.

Reviewed-by: Huang Rui <ray.huang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c | 7 ++++++-
 drivers/gpu/drm/amd/amdgpu/vi.c         | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index 2e238a4..7ded61e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -809,7 +809,12 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 		if (!adev->pm.fw) {
 			switch (adev->asic_type) {
 			case CHIP_TOPAZ:
-				strcpy(fw_name, "amdgpu/topaz_smc.bin");
+				if (((adev->pdev->device == 0x6900) && (adev->pdev->revision == 0x81)) ||
+				    ((adev->pdev->device == 0x6900) && (adev->pdev->revision == 0x83)) ||
+				    ((adev->pdev->device == 0x6907) && (adev->pdev->revision == 0x87)))
+					strcpy(fw_name, "amdgpu/topaz_k_smc.bin");
+				else
+					strcpy(fw_name, "amdgpu/topaz_smc.bin");
 				break;
 			case CHIP_TONGA:
 				if (((adev->pdev->device == 0x6939) && (adev->pdev->revision == 0xf1)) ||
diff --git a/drivers/gpu/drm/amd/amdgpu/vi.c b/drivers/gpu/drm/amd/amdgpu/vi.c
index ab030c5..0b21e7b 100644
--- a/drivers/gpu/drm/amd/amdgpu/vi.c
+++ b/drivers/gpu/drm/amd/amdgpu/vi.c
@@ -80,6 +80,7 @@
 #include "dce_virtual.h"
 
 MODULE_FIRMWARE("amdgpu/topaz_smc.bin");
+MODULE_FIRMWARE("amdgpu/topaz_k_smc.bin");
 MODULE_FIRMWARE("amdgpu/tonga_smc.bin");
 MODULE_FIRMWARE("amdgpu/tonga_k_smc.bin");
 MODULE_FIRMWARE("amdgpu/fiji_smc.bin");
-- 
2.5.5

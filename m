From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] drm/amdgpu: add new polaris pci id
Date: Wed, 19 Sep 2018 22:05:04 -0500
Message-ID: <20180920030504.15362-1-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Add new pci id.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c | 14 ++++++++------
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  1 +
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
index 693ec5ea4950..8816c697b205 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cgs.c
@@ -367,12 +367,14 @@ static int amdgpu_cgs_get_firmware_info(struct cgs_device *cgs_device,
 				break;
 			case CHIP_POLARIS10:
 				if (type == CGS_UCODE_ID_SMU) {
-					if ((adev->pdev->device == 0x67df) &&
-					    ((adev->pdev->revision == 0xe0) ||
-					     (adev->pdev->revision == 0xe3) ||
-					     (adev->pdev->revision == 0xe4) ||
-					     (adev->pdev->revision == 0xe5) ||
-					     (adev->pdev->revision == 0xe7) ||
+					if (((adev->pdev->device == 0x67df) &&
+					     ((adev->pdev->revision == 0xe0) ||
+					      (adev->pdev->revision == 0xe3) ||
+					      (adev->pdev->revision == 0xe4) ||
+					      (adev->pdev->revision == 0xe5) ||
+					      (adev->pdev->revision == 0xe7) ||
+					      (adev->pdev->revision == 0xef))) ||
+					    ((adev->pdev->device == 0x6fdf) &&
 					     (adev->pdev->revision == 0xef))) {
 						info->is_kicker = true;
 						strcpy(fw_name, "amdgpu/polaris10_k_smc.bin");
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index ff10df4f50d3..b536808f62ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -837,6 +837,7 @@ static const struct pci_device_id pciidlist[] = {
 	{0x1002, 0x67CA, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS10},
 	{0x1002, 0x67CC, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS10},
 	{0x1002, 0x67CF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS10},
+	{0x1002, 0x6FDF, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS10},
 	/* Polaris12 */
 	{0x1002, 0x6980, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS12},
 	{0x1002, 0x6981, PCI_ANY_ID, PCI_ANY_ID, 0, 0, CHIP_POLARIS12},
-- 
2.13.6

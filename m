From: Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] drm/amdgpu: Use dev_get_drvdata where possible
Date: Tue, 23 Jul 2019 17:04:50 +0800
Message-ID: <20190723090449.27589-1-hslester96@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Chuhong Yuan <hslester96@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

Instead of using to_pci_dev + pci_get_drvdata,
use dev_get_drvdata to make code simpler.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 27 +++++++++----------------
 1 file changed, 10 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index f2e8b4238efd..df82091a29d3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -1097,16 +1097,14 @@ amdgpu_pci_shutdown(struct pci_dev *pdev)
 
 static int amdgpu_pmops_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
 	return amdgpu_device_suspend(drm_dev, true, true);
 }
 
 static int amdgpu_pmops_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
 	/* GPU comes up enabled by the bios on resume */
 	if (amdgpu_device_is_px(drm_dev)) {
@@ -1120,33 +1118,29 @@ static int amdgpu_pmops_resume(struct device *dev)
 
 static int amdgpu_pmops_freeze(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+
 	return amdgpu_device_suspend(drm_dev, false, true);
 }
 
 static int amdgpu_pmops_thaw(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+
 	return amdgpu_device_resume(drm_dev, false, true);
 }
 
 static int amdgpu_pmops_poweroff(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
+
 	return amdgpu_device_suspend(drm_dev, true, true);
 }
 
 static int amdgpu_pmops_restore(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
 	return amdgpu_device_resume(drm_dev, false, true);
 }
 
@@ -1205,8 +1199,7 @@ static int amdgpu_pmops_runtime_resume(struct device *dev)
 
 static int amdgpu_pmops_runtime_idle(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct drm_crtc *crtc;
 
 	if (!amdgpu_device_is_px(drm_dev)) {
-- 
2.20.1

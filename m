From: Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] drm/radeon: Use dev_get_drvdata where possible
Date: Tue, 23 Jul 2019 19:10:08 +0800
Message-ID: <20190723111008.10955-1-hslester96@gmail.com>
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
 drivers/gpu/drm/radeon/radeon_drv.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index a6cbe11f79c6..b2bb74d5bffb 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -358,15 +358,13 @@ radeon_pci_shutdown(struct pci_dev *pdev)
 
 static int radeon_pmops_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	return radeon_suspend_kms(drm_dev, true, true, false);
 }
 
 static int radeon_pmops_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 
 	/* GPU comes up enabled by the bios on resume */
 	if (radeon_is_px(drm_dev)) {
@@ -380,15 +378,13 @@ static int radeon_pmops_resume(struct device *dev)
 
 static int radeon_pmops_freeze(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	return radeon_suspend_kms(drm_dev, false, true, true);
 }
 
 static int radeon_pmops_thaw(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	return radeon_resume_kms(drm_dev, false, true);
 }
 
@@ -447,8 +443,7 @@ static int radeon_pmops_runtime_resume(struct device *dev)
 
 static int radeon_pmops_runtime_idle(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct drm_device *drm_dev = pci_get_drvdata(pdev);
+	struct drm_device *drm_dev = dev_get_drvdata(dev);
 	struct drm_crtc *crtc;
 
 	if (!radeon_is_px(drm_dev)) {
-- 
2.20.1

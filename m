From: KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>
Subject: [PATCH] drm/radeon: Fix EEH during kexec
Date: Tue, 16 Jul 2019 13:10:02 -0500
Message-ID: <1563300606-28434-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>
List-Id: amd-gfx.lists.freedesktop.org

During kexec some adapters hit an EEH since they are not properly
shut down in the radeon_pci_shutdown() function. Adding
radeon_suspend_kms() fixes this issue.

Since radeon.h is now included in radeon_drv.c radeon_init() needs
a new name. I chose radeon_initl(). This can be changed if there is
another suggestion for a name.

Signed-off-by: Kyle Mahlkuch <Kyle.Mahlkuch at ibm.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 2e96c88..550f9b0 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -32,6 +32,7 @@
 #include <drm/drmP.h>
 #include <drm/radeon_drm.h>
 #include "radeon_drv.h"
+#include "radeon.h"
 
 #include <drm/drm_pciids.h>
 #include <linux/console.h>
@@ -344,11 +345,21 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 static void
 radeon_pci_shutdown(struct pci_dev *pdev)
 {
+	struct drm_device *ddev = pci_get_drvdata(pdev);
+	struct radeon_device *rdev = ddev->dev_private;
+
 	/* if we are running in a VM, make sure the device
 	 * torn down properly on reboot/shutdown
 	 */
 	if (radeon_device_is_virtual())
 		radeon_pci_remove(pdev);
+
+	/* Some adapters need to be suspended before a
+	* shutdown occurs in order to prevent an error
+	* during kexec.
+	*/
+	if (rdev->family == CHIP_CAICOS)
+		radeon_suspend_kms(ddev, true, true, false);
 }
 
 static int radeon_pmops_suspend(struct device *dev)
@@ -589,7 +600,7 @@ static long radeon_kms_compat_ioctl(struct file *filp, unsigned int cmd, unsigne
 	.driver.pm = &radeon_pm_ops,
 };
 
-static int __init radeon_init(void)
+static int __init radeon_initl(void)
 {
 	if (vgacon_text_force() && radeon_modeset == -1) {
 		DRM_INFO("VGACON disable radeon kernel modesetting.\n");
@@ -621,7 +632,7 @@ static void __exit radeon_exit(void)
 	radeon_unregister_atpx_handler();
 }
 
-module_init(radeon_init);
+module_init(radeon_initl);
 module_exit(radeon_exit);
 
 MODULE_AUTHOR(DRIVER_AUTHOR);
-- 
1.8.3.1

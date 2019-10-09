From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] Revert "drm/radeon: Fix EEH during kexec"
Date: Wed,  9 Oct 2019 13:15:03 -0500
Message-ID: <20191009181503.20381-1-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org, kmahlkuc@linux.vnet.ibm.com
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

This reverts commit 6f7fe9a93e6c09bf988c5059403f5f88e17e21e6.

This breaks some boards.  Maybe just enable this on PPC for
now?

Bug: https://bugzilla.kernel.org/show_bug.cgi?id=205147
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/radeon/radeon_drv.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 4267cb55bc33..2bc56f829bf7 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -378,19 +378,11 @@ radeon_pci_remove(struct pci_dev *pdev)
 static void
 radeon_pci_shutdown(struct pci_dev *pdev)
 {
-	struct drm_device *ddev = pci_get_drvdata(pdev);
-
 	/* if we are running in a VM, make sure the device
 	 * torn down properly on reboot/shutdown
 	 */
 	if (radeon_device_is_virtual())
 		radeon_pci_remove(pdev);
-
-	/* Some adapters need to be suspended before a
-	* shutdown occurs in order to prevent an error
-	* during kexec.
-	*/
-	radeon_suspend_kms(ddev, true, true, false);
 }
 
 static int radeon_pmops_suspend(struct device *dev)
-- 
2.20.1

From: Kyle Mahlkuch <kmahlkuc@linux.vnet.ibm.com>
Subject: [PATCH] drm/radeon: Clean up code in radeon_pci_shutdown()
Date: Mon, 11 Nov 2019 14:27:58 -0600
Message-ID: <1573504078-7691-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>
List-Id: amd-gfx.lists.freedesktop.org

From: KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>

This fixes the formatting on one comment and consolidates the
pci_get_drvdata() into the radeon_suspend_kms().

Signed-off-by: Kyle Mahlkuch <kmahlkuc@linux.vnet.ibm.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 4528f4d..357d29a 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -379,10 +379,6 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 static void
 radeon_pci_shutdown(struct pci_dev *pdev)
 {
-#ifdef CONFIG_PPC64
-	struct drm_device *ddev = pci_get_drvdata(pdev);
-#endif
-
 	/* if we are running in a VM, make sure the device
 	 * torn down properly on reboot/shutdown
 	 */
@@ -390,13 +386,14 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 		radeon_pci_remove(pdev);
 
 #ifdef CONFIG_PPC64
-	/* Some adapters need to be suspended before a
+	/*
+	 * Some adapters need to be suspended before a
 	 * shutdown occurs in order to prevent an error
 	 * during kexec.
 	 * Make this power specific becauase it breaks
 	 * some non-power boards.
 	 */
-	radeon_suspend_kms(ddev, true, true, false);
+	radeon_suspend_kms(pci_get_drvdata(pdev), true, true, false);
 #endif
 }
 
-- 
1.8.3.1

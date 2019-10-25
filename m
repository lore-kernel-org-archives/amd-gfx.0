From: KyleMahlkuch <kmahlkuc@linux.vnet.ibm.com>
Subject: [PATCH v3] drm/radeon: Fix EEH during kexec
Date: Fri, 25 Oct 2019 15:40:50 -0500
Message-ID: <1572036050-18945-1-git-send-email-kmahlkuc@linux.vnet.ibm.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: alexander.deucher@amd.com
Cc: stable@vger.kernel.org, amd-gfx@lists.freedesktop.org, Kyle Mahlkuch <kmahlkuc@linux.vnet.ibm.com>
List-Id: amd-gfx.lists.freedesktop.org

From: Kyle Mahlkuch <kmahlkuc@linux.vnet.ibm.com>

During kexec some adapters hit an EEH since they are not properly
shut down in the radeon_pci_shutdown() function. Adding
radeon_suspend_kms() fixes this issue.
Enabled only on PPC because this patch causes issues on some other
boards.

Signed-off-by: Kyle Mahlkuch <kmahlkuc@linux.vnet.ibm.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index 9e55076..4528f4d 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -379,11 +379,25 @@ static int radeon_pci_probe(struct pci_dev *pdev,
 static void
 radeon_pci_shutdown(struct pci_dev *pdev)
 {
+#ifdef CONFIG_PPC64
+	struct drm_device *ddev = pci_get_drvdata(pdev);
+#endif
+
 	/* if we are running in a VM, make sure the device
 	 * torn down properly on reboot/shutdown
 	 */
 	if (radeon_device_is_virtual())
 		radeon_pci_remove(pdev);
+
+#ifdef CONFIG_PPC64
+	/* Some adapters need to be suspended before a
+	 * shutdown occurs in order to prevent an error
+	 * during kexec.
+	 * Make this power specific becauase it breaks
+	 * some non-power boards.
+	 */
+	radeon_suspend_kms(ddev, true, true, false);
+#endif
 }
 
 static int radeon_pmops_suspend(struct device *dev)
-- 
1.8.3.1

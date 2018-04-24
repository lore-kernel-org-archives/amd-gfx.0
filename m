From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] drm/radeon: fix radeon_atpx_get_client_id()'s return type
Date: Tue, 24 Apr 2018 15:15:41 +0200
Message-ID: <20180424131541.2711-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

The method struct vga_switcheroo_handler::get_client_id() is defined
as returning an 'enum vga_switcheroo_client_id' but the implementation
in this driver, radeon_atpx_get_client_id(), returns an 'int'.

Fix this by returning 'enum vga_switcheroo_client_id' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_atpx_handler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_atpx_handler.c b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
index 40be4068c..fa5fadaa9 100644
--- a/drivers/gpu/drm/radeon/radeon_atpx_handler.c
+++ b/drivers/gpu/drm/radeon/radeon_atpx_handler.c
@@ -526,7 +526,7 @@ static int radeon_atpx_init(void)
  * look up whether we are the integrated or discrete GPU (all asics).
  * Returns the client id.
  */
-static int radeon_atpx_get_client_id(struct pci_dev *pdev)
+static enum vga_switcheroo_client_id radeon_atpx_get_client_id(struct pci_dev *pdev)
 {
 	if (radeon_atpx_priv.dhandle == ACPI_HANDLE(&pdev->dev))
 		return VGA_SWITCHEROO_IGD;
-- 
2.17.0

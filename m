From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] drm/amdgpu: fix amdgpu_atpx_get_client_id()'s return type
Date: Tue, 24 Apr 2018 15:15:34 +0200
Message-ID: <20180424131536.2611-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Kai-Heng Feng <kai.heng.feng@canonical.com>, Huang Rui <ray.huang@amd.com>, Junwei Zhang <Jerry.Zhang@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

The method struct vga_switcheroo_handler::get_client_id() is defined
as returning an 'enum vga_switcheroo_client_id' but the implementation
in this driver, amdgpu_atpx_get_client_id(), returns an 'int'.

Fix this by returning 'enum vga_switcheroo_client_id' in this driver too.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
index 1ae5ae8c4..1bcb2b247 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atpx_handler.c
@@ -550,7 +550,7 @@ static int amdgpu_atpx_init(void)
  * look up whether we are the integrated or discrete GPU (all asics).
  * Returns the client id.
  */
-static int amdgpu_atpx_get_client_id(struct pci_dev *pdev)
+static enum vga_switcheroo_client_id amdgpu_atpx_get_client_id(struct pci_dev *pdev)
 {
 	if (amdgpu_atpx_priv.dhandle == ACPI_HANDLE(&pdev->dev))
 		return VGA_SWITCHEROO_IGD;
-- 
2.17.0

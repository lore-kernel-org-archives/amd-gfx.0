From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: [PATCH 1/5] drm: radeon: constify pci_device_id.
Date: Sat, 15 Jul 2017 12:42:18 +0530
Message-ID: <1500102738-23274-2-git-send-email-arvind.yadav.cs@gmail.com>
References: <1500102738-23274-1-git-send-email-arvind.yadav.cs@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1500102738-23274-1-git-send-email-arvind.yadav.cs@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: airlied@linux.ie, amd-gfx@lists.freedesktop.org, alexander.deucher@amd.com, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

pci_device_id are not supposed to change at runtime. All functions
working with pci_device_id provided by <linux/pci.h> work with
const pci_device_id. So mark the non-const structs as const.

File size before:
   text	   data	    bss	    dec	    hex	filename
   6560	  23212	     72	  29844	   7494	gpu/drm/radeon/radeon_drv.o

File size After adding 'const':
   text	   data	    bss	    dec	    hex	filename
  28960	    812	     72	  29844	   7494	gpu/drm/radeon/radeon_drv.o

Signed-off-by: Arvind Yadav <arvind.yadav.cs@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_drv.c b/drivers/gpu/drm/radeon/radeon_drv.c
index e25cb51..b079937 100644
--- a/drivers/gpu/drm/radeon/radeon_drv.c
+++ b/drivers/gpu/drm/radeon/radeon_drv.c
@@ -298,7 +298,7 @@ module_param_named(uvd, radeon_uvd, int, 0444);
 MODULE_PARM_DESC(vce, "vce enable/disable vce support (1 = enable, 0 = disable)");
 module_param_named(vce, radeon_vce, int, 0444);
 
-static struct pci_device_id pciidlist[] = {
+static const struct pci_device_id pciidlist[] = {
 	radeon_PCI_IDS
 };
 
-- 
2.7.4

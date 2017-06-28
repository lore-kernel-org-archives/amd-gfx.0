From: Kent Russell <kent.russell-5C7GfCeVMHo@public.gmane.org>
Subject: drm/amdgpu: Fix vram_page_split parameter description
Date: Wed, 28 Jun 2017 15:26:18 -0400
Message-ID: <87d2a1a1-58ce-bc93-353a-2711ca8d93f4@amd.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------CAA9F6043EAA2E81B111FFAA"
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Language: en-US
List-Id: Discussion list for AMD gfx <amd-gfx.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org

This is a multi-part message in MIME format.
--------------CAA9F6043EAA2E81B111FFAA
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

The default was changed to 512 from 1024, but the default in the
description wasn't updated.

  Kent


--------------CAA9F6043EAA2E81B111FFAA
Content-Type: text/x-patch;
 name="vramdesc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="vramdesc.patch"

>From 756f38576c08dc4aa36a958cc6f3d2784b20a377 Mon Sep 17 00:00:00 2001
From: Kent Russell <kent.russell-5C7GfCeVMHo@public.gmane.org>
Date: Wed, 28 Jun 2017 15:16:41 -0400
Subject: [PATCH] drm/amdgpu: Update default vram_page_split description

This was updated to 512 and the description update got missed

Signed-off-by: Kent Russell <kent.russell-5C7GfCeVMHo@public.gmane.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index 347097b..b332e2a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -184,7 +184,7 @@ module_param_named(vm_debug, amdgpu_vm_debug, int, 0644);
 MODULE_PARM_DESC(vm_update_mode, "VM update using CPU (0 = never (default except for large BAR(LB)), 1 = Graphics only, 2 = Compute only (default for LB), 3 = Both");
 module_param_named(vm_update_mode, amdgpu_vm_update_mode, int, 0444);
 
-MODULE_PARM_DESC(vram_page_split, "Number of pages after we split VRAM allocations (default 1024, -1 = disable)");
+MODULE_PARM_DESC(vram_page_split, "Number of pages after we split VRAM allocations (default 512, -1 = disable)");
 module_param_named(vram_page_split, amdgpu_vram_page_split, int, 0444);
 
 MODULE_PARM_DESC(exp_hw_support, "experimental hw support (1 = enable, 0 = disable (default))");
-- 
2.7.4


--------------CAA9F6043EAA2E81B111FFAA
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Content-Disposition: inline

X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBt
YWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5m
cmVlZGVza3RvcC5vcmcvbWFpbG1hbi9saXN0aW5mby9hbWQtZ2Z4Cg==

--------------CAA9F6043EAA2E81B111FFAA--

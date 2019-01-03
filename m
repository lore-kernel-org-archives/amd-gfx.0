From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/amdgpu_vm: fix boolean expressions
Date: Thu, 3 Jan 2019 11:34:18 -0600
Message-ID: <20190103173418.GA18739@embeddedor>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: amd-gfx.lists.freedesktop.org

Fix boolean expressions by using logical AND operator '&&'
instead of bitwise operator '&'.

This issue was detected with the help of Coccinelle.

Fixes: c8c5e569c5b0 ("drm/amdgpu: Consolidate visible vs. real vram check v2.")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index e73d152659a2..4cc0d1079935 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3006,7 +3006,7 @@ int amdgpu_vm_init(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 	}
 	DRM_DEBUG_DRIVER("VM update mode is %s\n",
 			 vm->use_cpu_for_update ? "CPU" : "SDMA");
-	WARN_ONCE((vm->use_cpu_for_update & !amdgpu_gmc_vram_full_visible(&adev->gmc)),
+	WARN_ONCE((vm->use_cpu_for_update && !amdgpu_gmc_vram_full_visible(&adev->gmc)),
 		  "CPU update of VM recommended only for large BAR system\n");
 	vm->last_update = NULL;
 
@@ -3136,7 +3136,7 @@ int amdgpu_vm_make_compute(struct amdgpu_device *adev, struct amdgpu_vm *vm, uns
 	vm->pte_support_ats = pte_support_ats;
 	DRM_DEBUG_DRIVER("VM update mode is %s\n",
 			 vm->use_cpu_for_update ? "CPU" : "SDMA");
-	WARN_ONCE((vm->use_cpu_for_update & !amdgpu_gmc_vram_full_visible(&adev->gmc)),
+	WARN_ONCE((vm->use_cpu_for_update && !amdgpu_gmc_vram_full_visible(&adev->gmc)),
 		  "CPU update of VM recommended only for large BAR system\n");
 
 	if (vm->pasid) {
-- 
2.20.1

From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH] drm/amdgpu: Fix wornings while make xmldocs
Date: Thu,  6 Sep 2018 11:10:57 +0900
Message-ID: <20180906021057.22756-1-standby24x7@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, alexander.deucher@amd.com, airlied@linux.ie, andrey.grodzovsky@amd.com
Cc: corbet@lwn.net, linux-doc@vger.kernel.org, Masanari Iida <standby24x7@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

This patch fixes following wornings.

./drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:3011:
warning: Excess function parameter 'dev' description
in 'amdgpu_vm_get_task_info'

./drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:3012:
warning: Function parameter or member 'adev' not
described in 'amdgpu_vm_get_task_info'

./drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c:3012:
warning: Excess function parameter 'dev' description
in 'amdgpu_vm_get_task_info'

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index b17771dd5ce7..861718e2be7a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -3002,7 +3002,7 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 /**
  * amdgpu_vm_get_task_info - Extracts task info for a PASID.
  *
- * @dev: drm device pointer
+ * @adev: drm device pointer
  * @pasid: PASID identifier for VM
  * @task_info: task_info to fill.
  */
-- 
2.19.0.rc2

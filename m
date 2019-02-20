From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amdgpu: remove set but not used variables 'vm, bo'
Date: Wed, 20 Feb 2019 03:31:50 +0000
Message-ID: <20190220033150.163019-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Oded Gabbay <oded.gabbay@gmail.com>, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc: YueHaibing <yuehaibing@huawei.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c: In function 'update_gpuvm_pte':
drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:840:20: warning:
 variable 'bo' set but not used [-Wunused-but-set-variable]

drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c:838:20: warning:
 variable 'vm' set but not used [-Wunused-but-set-variable]

They're never used since introduction in a46a2cd103a8 ("drm/amdgpu: Add GPUVM
memory management functions for KFD")

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index d7b10d79f1de..63daf758cd03 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -837,13 +837,7 @@ static int update_gpuvm_pte(struct amdgpu_device *adev,
 		struct amdgpu_sync *sync)
 {
 	int ret;
-	struct amdgpu_vm *vm;
-	struct amdgpu_bo_va *bo_va;
-	struct amdgpu_bo *bo;
-
-	bo_va = entry->bo_va;
-	vm = bo_va->base.vm;
-	bo = bo_va->base.bo;
+	struct amdgpu_bo_va *bo_va = entry->bo_va;
 
 	/* Update the page tables  */
 	ret = amdgpu_vm_bo_update(adev, bo_va, false);

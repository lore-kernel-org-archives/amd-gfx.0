From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] drm/amdgpu: fix error return code in amdgpu_amdkfd_gpuvm_create_process_vm()
Date: Wed, 28 Mar 2018 13:20:56 +0000
Message-ID: <1522243256-94061-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: oded.gabbay@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, Felix Kuehling <Felix.Kuehling@amd.com>
Cc: Wei Yongjun <weiyongjun1@huawei.com>, dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Fix to return error code -ENOMEM from the eviction fence create fail
error handling case instead of 0, as done elsewhere in this function.

Fixes: a46a2cd103a8 ("drm/amdgpu: Add GPUVM memory management functions for KFD")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index a12a165..c5c9c6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -846,6 +846,7 @@ int amdgpu_amdkfd_gpuvm_create_process_vm(struct kgd_dev *kgd, void **vm,
 						   current->mm);
 		if (!info->eviction_fence) {
 			pr_err("Failed to create eviction fence\n");
+			ret = -ENOMEM;
 			goto create_evict_fence_fail;
 		}

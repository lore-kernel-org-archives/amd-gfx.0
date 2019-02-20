From: "=?UTF-8?q?Christian=20K=C3=B6nig?="
        <ckoenig.leichtzumerken@gmail.com>
Subject: [PATCH] drm/amdgpu: disable bulk moves for now
Date: Wed, 20 Feb 2019 15:16:06 +0100
Message-ID: <20190220141606.8832-1-christian.koenig@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

The changes to fix those are two invasive for backporting.

Just disable the feature in 4.20 and 5.0.

Signed-off-by: Christian König <christian.koenig@amd.com>
Cc: <stable@vger.kernel.org>    [4.20+]
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 0877ff9a9594..c3643dde3e9d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -637,12 +637,14 @@ void amdgpu_vm_move_to_lru_tail(struct amdgpu_device *adev,
 	struct ttm_bo_global *glob = adev->mman.bdev.glob;
 	struct amdgpu_vm_bo_base *bo_base;
 
+#if 0
 	if (vm->bulk_moveable) {
 		spin_lock(&glob->lru_lock);
 		ttm_bo_bulk_move_lru_tail(&vm->lru_bulk_move);
 		spin_unlock(&glob->lru_lock);
 		return;
 	}
+#endif
 
 	memset(&vm->lru_bulk_move, 0, sizeof(vm->lru_bulk_move));
 
-- 
2.14.1

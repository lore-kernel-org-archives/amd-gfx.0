From: Saurav Girepunje <saurav.girepunje@gmail.com>
Subject: [PATCH] drm: amd: amdgpu: Remove NULL check not needed before
 freeing functions
Date: Tue, 29 Oct 2019 14:49:43 +0530
Message-ID: <20191029091943.GA10258@saurav>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, tom.stdenis@amd.com, xywang.sjtu@sjtu.edu.cn, Jack.Xiao@amd.com, sam@ravnborg.org, Kevin1.Wang@amd.com, saurav.girepunje@gmail.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: saurav.girepunje@hotmail.com
List-Id: amd-gfx.lists.freedesktop.org

Remove unneeded NULL check before freeing functions
kfree and debugfs_remove.

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
index 5652cc72ed3a..cb94627fc0f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c
@@ -1077,8 +1077,7 @@ static int amdgpu_debugfs_ib_preempt(void *data, u64 val)
 
 	ttm_bo_unlock_delayed_workqueue(&adev->mman.bdev, resched);
 
-	if (fences)
-		kfree(fences);
+	kfree(fences);
 
 	return 0;
 }
@@ -1103,8 +1102,7 @@ int amdgpu_debugfs_init(struct amdgpu_device *adev)
 
 void amdgpu_debugfs_preempt_cleanup(struct amdgpu_device *adev)
 {
-	if (adev->debugfs_preempt)
-		debugfs_remove(adev->debugfs_preempt);
+	debugfs_remove(adev->debugfs_preempt);
 }
 
 #else
-- 
2.20.1

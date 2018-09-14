From: Peng Hao <peng.hao2@zte.com.cn>
Subject: [PATCH]  amdgpu/gmc : fix compile warning
Date: Fri, 14 Sep 2018 18:05:52 +0800
Message-ID: <1536919552-116245-1-git-send-email-peng.hao2@zte.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Peng Hao <peng.hao2@zte.com.cn>
List-Id: amd-gfx.lists.freedesktop.org

drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:
    In function ‘gmc_v8_0_process_interrupt’:
drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1447:10:
    warning: missing braces around initializer [-Wmissing-braces]

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 9333109..55f4755 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1444,7 +1444,7 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 		gmc_v8_0_set_fault_enable_default(adev, false);
 
 	if (printk_ratelimit()) {
-		struct amdgpu_task_info task_info = { 0 };
+		struct amdgpu_task_info task_info = { {0} };
 
 		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 72f8018..e8b78c5 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -259,7 +259,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	}
 
 	if (printk_ratelimit()) {
-		struct amdgpu_task_info task_info = { 0 };
+		struct amdgpu_task_info task_info = { {0} };
 
 		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
 
-- 
1.8.3.1

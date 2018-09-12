From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] drm/amdgpu: Add braces to initialize task_info subojects
Date: Tue, 11 Sep 2018 17:25:59 -0700
Message-ID: <20180912002559.1853-1-natechancellor@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <natechancellor@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

Clang warns if there are missing braces around a subobject
initializer.

drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c:1447:41: warning: suggest braces
around initialization of subobject [-Wmissing-braces]
                struct amdgpu_task_info task_info = { 0 };
                                                      ^
                                                      {}
1 warning generated.

drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c:262:41: warning: suggest braces
around initialization of subobject [-Wmissing-braces]
                struct amdgpu_task_info task_info = { 0 };
                                                      ^
                                                      {}
1 warning generated.

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
index 9333109b210d..968cc1b8cdff 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v8_0.c
@@ -1444,7 +1444,7 @@ static int gmc_v8_0_process_interrupt(struct amdgpu_device *adev,
 		gmc_v8_0_set_fault_enable_default(adev, false);
 
 	if (printk_ratelimit()) {
-		struct amdgpu_task_info task_info = { 0 };
+		struct amdgpu_task_info task_info = { { 0 } };
 
 		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
index 72f8018fa2a8..a781a5027212 100644
--- a/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gmc_v9_0.c
@@ -259,7 +259,7 @@ static int gmc_v9_0_process_interrupt(struct amdgpu_device *adev,
 	}
 
 	if (printk_ratelimit()) {
-		struct amdgpu_task_info task_info = { 0 };
+		struct amdgpu_task_info task_info = { { 0 } };
 
 		amdgpu_vm_get_task_info(adev, entry->pasid, &task_info);
 
-- 
2.18.0

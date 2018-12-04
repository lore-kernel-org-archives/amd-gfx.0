From: Wei Yongjun <weiyongjun1@huawei.com>
Subject: [PATCH -next] drm/amdgpu: Fix return value check in amdgpu_allocate_static_csa()
Date: Tue, 4 Dec 2018 06:39:36 +0000
Message-ID: <1543905576-38015-1-git-send-email-weiyongjun1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, Rex.Zhu@amd.com, Monk.Liu@amd.com
Cc: Wei Yongjun <weiyongjun1@huawei.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Fix the return value check which testing the wrong variable
in amdgpu_allocate_static_csa().

Fixes: 7946340fa389 ("drm/amdgpu: Move csa related code to separate file")
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
index 0c590dd..a5fbc6f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_csa.c
@@ -43,7 +43,7 @@ int amdgpu_allocate_static_csa(struct amdgpu_device *adev, struct amdgpu_bo **bo
 	r = amdgpu_bo_create_kernel(adev, size, PAGE_SIZE,
 				domain, bo,
 				NULL, &ptr);
-	if (!bo)
+	if (!r)
 		return -ENOMEM;
 
 	memset(ptr, 0, size);

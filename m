From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] drm/amd/amdgpu: validate the shadow BO.
Date: Thu,  1 Dec 2016 11:21:47 -0500
Message-ID: <1480609307-2483-1-git-send-email-alexander.deucher@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Xie <AlexBin.Xie@amd.com>, Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Alex Xie <AlexBin.Xie@amd.com>

Fixes a rare NULL pointer dereference in amdgpu_ttm_bind.

The issue was found by Nicolai Haehnle.
The patch was tested by Nicolai Haehnle.

Signed-off-by: Alex Xie <AlexBin.Xie@amd.com>
Reviewed-by: Chunming Zhou <david1.zhou@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 5a27749..29d6d84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -451,7 +451,7 @@ static int amdgpu_cs_validate(void *param, struct amdgpu_bo *bo)
 		return r;
 
 	if (bo->shadow)
-		r = amdgpu_cs_bo_validate(p, bo);
+		r = amdgpu_cs_bo_validate(p, bo->shadow);
 
 	return r;
 }
-- 
2.5.5

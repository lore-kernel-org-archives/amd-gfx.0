From: Junwei Zhang <Jerry.Zhang@amd.com>
Subject: [PATCH 1/2] drm/amdgpu: read reg in each iterate of psp_wait_for loop
Date: Mon, 17 Jul 2017 17:01:49 +0800
Message-ID: <1500282110-6372-1-git-send-email-Jerry.Zhang@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com, ray.huang@amd.com, stable@vger.kernel.org, "Zhang, Jerry" <Jerry.Zhang@amd.com>
List-Id: amd-gfx.lists.freedesktop.org

From: "Zhang, Jerry" <Jerry.Zhang@amd.com>

Signed-off-by: Junwei Zhang <Jerry.Zhang@amd.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
Acked-by: Huang Rui <ray.huang@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
index c919579..644941d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_psp.c
@@ -98,9 +98,8 @@ int psp_wait_for(struct psp_context *psp, uint32_t reg_index,
 	int i;
 	struct amdgpu_device *adev = psp->adev;
 
-	val = RREG32(reg_index);
-
 	for (i = 0; i < adev->usec_timeout; i++) {
+		val = RREG32(reg_index);
 		if (check_changed) {
 			if (val != reg_val)
 				return 0;
-- 
1.9.1

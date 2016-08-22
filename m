From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] drm/amdgpu: fix IB alignment for UVD
Date: Mon, 22 Aug 2016 16:33:39 -0400
Message-ID: <1471898019-32672-1-git-send-email-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, Peter Fang <peter.fang@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

According to the hw team, it should be 16, not 8.

Cc: Peter Fang <peter.fang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
index 4c8e68a..eab8d73 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c
@@ -292,7 +292,7 @@ static int amdgpu_info_ioctl(struct drm_device *dev, void *data, struct drm_file
 			type = AMD_IP_BLOCK_TYPE_UVD;
 			ring_mask = adev->uvd.ring.ready ? 1 : 0;
 			ib_start_alignment = AMDGPU_GPU_PAGE_SIZE;
-			ib_size_alignment = 8;
+			ib_size_alignment = 16;
 			break;
 		case AMDGPU_HW_IP_VCE:
 			type = AMD_IP_BLOCK_TYPE_VCE;
-- 
2.5.5

From: Kangjie Lu <kjlu@umn.edu>
Subject: [PATCH] gpu: drm: fix an improper check of amdgpu_bo_create_kernel
Date: Wed, 26 Dec 2018 00:23:45 -0600
Message-ID: <20181226062348.75519-1-kjlu@umn.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: kjlu@umn.edu
Cc: pakki001@umn.edu, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Rex Zhu <Rex.Zhu@amd.com>, Huang Rui <ray.huang@amd.com>, Hawking Zhang <Hawking.Zhang@amd.com>, Feifei Xu <Feifei.Xu@amd.com>, Likun Gao <Likun.Gao@amd.com>, David Francis <David.Francis@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

adev->firmware.fw_buf being not NULL may not indicate kernel buffer is
created successful. A better way is to check the status (return value)
of it. The fix does so.

Signed-off-by: Kangjie Lu <kjlu@umn.edu>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 7b33867036e7..ba3c1cfb2c35 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -422,13 +422,19 @@ static int amdgpu_ucode_patch_jt(struct amdgpu_firmware_info *ucode,
 
 int amdgpu_ucode_create_bo(struct amdgpu_device *adev)
 {
+	int ret;
+
 	if (adev->firmware.load_type != AMDGPU_FW_LOAD_DIRECT) {
-		amdgpu_bo_create_kernel(adev, adev->firmware.fw_size, PAGE_SIZE,
-			amdgpu_sriov_vf(adev) ? AMDGPU_GEM_DOMAIN_VRAM : AMDGPU_GEM_DOMAIN_GTT,
-			&adev->firmware.fw_buf,
-			&adev->firmware.fw_buf_mc,
-			&adev->firmware.fw_buf_ptr);
-		if (!adev->firmware.fw_buf) {
+		ret =
+			amdgpu_bo_create_kernel(adev,
+			  adev->firmware.fw_size,
+			  PAGE_SIZE,
+			  amdgpu_sriov_vf(adev) ? AMDGPU_GEM_DOMAIN_VRAM :
+				AMDGPU_GEM_DOMAIN_GTT,
+			  &adev->firmware.fw_buf,
+			  &adev->firmware.fw_buf_mc,
+				&adev->firmware.fw_buf_ptr);
+		if (ret) {
 			dev_err(adev->dev, "failed to create kernel buffer for firmware.fw_buf\n");
 			return -ENOMEM;
 		} else if (amdgpu_sriov_vf(adev)) {
-- 
2.17.2 (Apple Git-113)

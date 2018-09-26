From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] drm/amdgpu: remove set but not used variable 'header'
Date: Wed, 26 Sep 2018 14:15:34 +0000
Message-ID: <1537971334-130152-1-git-send-email-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, Likun.Gao@amd.com, David.Francis@amd.com, ray.huang@amd.com, Feifei.Xu@amd.com, Monk.Liu@amd.com
Cc: YueHaibing <yuehaibing@huawei.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Fixes gcc '-Wunused-but-set-variable' warning:

drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c: In function 'amdgpu_ucode_init_bo':
drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c:431:39: warning:
 variable 'header' set but not used [-Wunused-but-set-variable]

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
index 1fa8bc3..afd5cf3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ucode.c
@@ -428,7 +428,6 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
 	uint64_t fw_offset = 0;
 	int i, err;
 	struct amdgpu_firmware_info *ucode = NULL;
-	const struct common_firmware_header *header = NULL;
 
 	if (!adev->firmware.fw_size) {
 		dev_warn(adev->dev, "No ip firmware need to load\n");
@@ -465,7 +464,6 @@ int amdgpu_ucode_init_bo(struct amdgpu_device *adev)
 	for (i = 0; i < adev->firmware.max_ucodes; i++) {
 		ucode = &adev->firmware.ucode[i];
 		if (ucode->fw) {
-			header = (const struct common_firmware_header *)ucode->fw->data;
 			amdgpu_ucode_init_single_fw(adev, ucode, adev->firmware.fw_buf_mc + fw_offset,
 						    adev->firmware.fw_buf_ptr + fw_offset);
 			if (i == AMDGPU_UCODE_ID_CP_MEC1 &&

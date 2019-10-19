From: Wambui Karuga <wambui@karuga.xyz>
Subject: [PATCH] drm/amd/amdgpu: correct length misspelling
Date: Sat, 19 Oct 2019 10:34:30 +0300
Message-ID: <20191019073430.22093-1-wambui@karuga.xyz>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, outreachy-kernel@googlegroups.com
List-Id: amd-gfx.lists.freedesktop.org

Correct the "_LENTH" mispelling in the AMDGPU_MAX_TIMEOUT_PARAM_LENGTH
constant.

Signed-off-by: Wambui Karuga <wambui@karuga.xyz>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index c5b3c0c9193b..aaab37833659 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -86,7 +86,7 @@
 #define KMS_DRIVER_MINOR	34
 #define KMS_DRIVER_PATCHLEVEL	0
 
-#define AMDGPU_MAX_TIMEOUT_PARAM_LENTH	256
+#define AMDGPU_MAX_TIMEOUT_PARAM_LENGTH	256
 
 int amdgpu_vram_limit = 0;
 int amdgpu_vis_vram_limit = 0;
@@ -100,7 +100,7 @@ int amdgpu_disp_priority = 0;
 int amdgpu_hw_i2c = 0;
 int amdgpu_pcie_gen2 = -1;
 int amdgpu_msi = -1;
-static char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENTH];
+static char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENGTH];
 int amdgpu_dpm = -1;
 int amdgpu_fw_load_type = -1;
 int amdgpu_aspm = -1;
@@ -1327,9 +1327,9 @@ int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 	adev->sdma_timeout = adev->video_timeout = adev->gfx_timeout;
 	adev->compute_timeout = MAX_SCHEDULE_TIMEOUT;
 
-	if (strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENTH)) {
+	if (strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
 		while ((timeout_setting = strsep(&input, ",")) &&
-				strnlen(timeout_setting, AMDGPU_MAX_TIMEOUT_PARAM_LENTH)) {
+				strnlen(timeout_setting, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
 			ret = kstrtol(timeout_setting, 0, &timeout);
 			if (ret)
 				return ret;
-- 
2.23.0

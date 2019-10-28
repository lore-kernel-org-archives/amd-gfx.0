From: Wambui Karuga <wambui.karugax@gmail.com>
Subject: [Outreachy][PATCH 2/2] drm/amd: correct "_LENTH" mispelling in constant
Date: Mon, 28 Oct 2019 12:20:05 +0300
Message-ID: <20191028092005.31121-3-wambui.karugax@gmail.com>
References: <20191028092005.31121-1-wambui.karugax@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191028092005.31121-1-wambui.karugax@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, outreachy-kernel@googlegroups.com
List-Id: amd-gfx.lists.freedesktop.org

Correct the "_LENTH" mispelling in the AMDGPU_MAX_TIMEOUT_PARAM_LENGTH
constant.

Signed-off-by: Wambui Karuga <wambui.karugax@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu.h        | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
index 3610defdfae1..7d1e528cc783 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
@@ -108,7 +108,7 @@ struct amdgpu_mgpu_info
 	uint32_t			num_apu;
 };
 
-#define AMDGPU_MAX_TIMEOUT_PARAM_LENTH	256
+#define AMDGPU_MAX_TIMEOUT_PARAM_LENGTH	256
 
 /*
  * Modules parameters.
@@ -126,7 +126,7 @@ extern int amdgpu_disp_priority;
 extern int amdgpu_hw_i2c;
 extern int amdgpu_pcie_gen2;
 extern int amdgpu_msi;
-extern char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENTH];
+extern char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENGTH];
 extern int amdgpu_dpm;
 extern int amdgpu_fw_load_type;
 extern int amdgpu_aspm;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
index 676cad15239f..4eee40b9d0b0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
@@ -2631,9 +2631,9 @@ static int amdgpu_device_get_job_timeout_settings(struct amdgpu_device *adev)
 	else
 		adev->compute_timeout = MAX_SCHEDULE_TIMEOUT;
 
-	if (strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENTH)) {
+	if (strnlen(input, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
 		while ((timeout_setting = strsep(&input, ",")) &&
-				strnlen(timeout_setting, AMDGPU_MAX_TIMEOUT_PARAM_LENTH)) {
+				strnlen(timeout_setting, AMDGPU_MAX_TIMEOUT_PARAM_LENGTH)) {
 			ret = kstrtol(timeout_setting, 0, &timeout);
 			if (ret)
 				return ret;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
index c685400febe2..16147ca9b851 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
@@ -101,7 +101,7 @@ int amdgpu_disp_priority = 0;
 int amdgpu_hw_i2c = 0;
 int amdgpu_pcie_gen2 = -1;
 int amdgpu_msi = -1;
-char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENTH];
+char amdgpu_lockup_timeout[AMDGPU_MAX_TIMEOUT_PARAM_LENGTH];
 int amdgpu_dpm = -1;
 int amdgpu_fw_load_type = -1;
 int amdgpu_aspm = -1;
-- 
2.17.1

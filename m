From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] drm/amdgpu: don't expose fan attributes on APUs
Date: Wed, 28 Nov 2018 13:52:20 -0500
Message-ID: <20181128185220.32150-1-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

They don't have a fan controller.

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
index 0de8650c5d6e..1f61ed95727c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_pm.c
@@ -1644,6 +1644,19 @@ static umode_t hwmon_attributes_visible(struct kobject *kobj,
 	    attr == &sensor_dev_attr_fan1_enable.dev_attr.attr))
 		return 0;
 
+	/* Skip fan attributes on APU */
+	if ((adev->flags & AMD_IS_APU) &&
+	    (attr == &sensor_dev_attr_pwm1.dev_attr.attr ||
+	     attr == &sensor_dev_attr_pwm1_enable.dev_attr.attr ||
+	     attr == &sensor_dev_attr_pwm1_max.dev_attr.attr ||
+	     attr == &sensor_dev_attr_pwm1_min.dev_attr.attr ||
+	     attr == &sensor_dev_attr_fan1_input.dev_attr.attr ||
+	     attr == &sensor_dev_attr_fan1_min.dev_attr.attr ||
+	     attr == &sensor_dev_attr_fan1_max.dev_attr.attr ||
+	     attr == &sensor_dev_attr_fan1_target.dev_attr.attr ||
+	     attr == &sensor_dev_attr_fan1_enable.dev_attr.attr))
+		return 0;
+
 	/* Skip limit attributes if DPM is not enabled */
 	if (!adev->pm.dpm_enabled &&
 	    (attr == &sensor_dev_attr_temp1_crit.dev_attr.attr ||
-- 
2.13.6

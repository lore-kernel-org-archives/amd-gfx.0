From: Alex Deucher <alexdeucher@gmail.com>
Subject: [PATCH] drm/amdgpu: skip TV/CV in display parsing
Date: Wed, 24 Aug 2016 13:06:42 -0400
Message-ID: <1472058402-24153-1-git-send-email-alexander.deucher@amd.com>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Alex Deucher <alexander.deucher@amd.com>, stable@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

No asics supported by amdgpu support analog TV.

Workaround for bug:
https://bugs.freedesktop.org/show_bug.cgi?id=97460

Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
index 1514223..fe872b8 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c
@@ -321,6 +321,13 @@ bool amdgpu_atombios_get_connector_info_from_object_table(struct amdgpu_device *
 			    (le16_to_cpu(path->usConnObjectId) &
 			     OBJECT_TYPE_MASK) >> OBJECT_TYPE_SHIFT;
 
+			/* Skip TV/CV support */
+			if ((le16_to_cpu(path->usDeviceTag) ==
+			     ATOM_DEVICE_TV1_SUPPORT) ||
+			    (le16_to_cpu(path->usDeviceTag) ==
+			     ATOM_DEVICE_CV_SUPPORT))
+				continue;
+
 			if (con_obj_id >= ARRAY_SIZE(object_connector_convert)) {
 				DRM_ERROR("invalid con_obj_id %d for device tag 0x%04x\n",
 					  con_obj_id, le16_to_cpu(path->usDeviceTag));
-- 
2.5.5

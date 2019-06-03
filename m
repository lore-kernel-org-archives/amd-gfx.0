From: Young Xiao <92siuyang@gmail.com>
Subject: [PATCH] drm/radeon: avoid a possible arrary overflow
Date: Mon,  3 Jun 2019 11:02:37 +0800
Message-ID: <1559530957-11103-1-git-send-email-92siuyang@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Young Xiao <92siuyang@gmail.com>
List-Id: amd-gfx.lists.freedesktop.org

When looking up the connector type make sure the index
is valid.  Avoids a later crash if we read past the end
of the array.

This bug is similar to the issue which was fixed in
commit e1718d97aa88 ("drm/amdgpu: avoid a possible
array overflow").

Signed-off-by: Young Xiao <92siuyang@gmail.com>
---
 drivers/gpu/drm/radeon/radeon_atombios.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/radeon/radeon_atombios.c b/drivers/gpu/drm/radeon/radeon_atombios.c
index f422a8d..971c541 100644
--- a/drivers/gpu/drm/radeon/radeon_atombios.c
+++ b/drivers/gpu/drm/radeon/radeon_atombios.c
@@ -632,6 +632,10 @@ bool radeon_get_atom_connector_info_from_object_table(struct drm_device *dev)
 					connector_object_id = con_obj_id;
 				}
 			} else {
+				if (con_obj_id >= ARRAY_SIZE(object_connector_convert)) {
+					DRM_ERROR("invalid con_obj_id %d\n", con_obj_id);
+					continue;
+				}
 				igp_lane_info = 0;
 				connector_type =
 				    object_connector_convert[con_obj_id];
-- 
2.7.4

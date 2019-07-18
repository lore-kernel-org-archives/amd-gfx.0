From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH] drm/amdgpu/dm: Remove unneeded hotplug event in s3_handle_mst()
Date: Wed, 17 Jul 2019 21:48:56 -0400
Message-ID: <20190718014858.9257-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, David Francis <David.Francis@amd.com>, Mario Kleiner <mario.kleiner.de@gmail.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Anthony Koo <Anthony.Koo@amd.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

The DRM DP MST topology manager will send it's own hotplug events when
connectors are destroyed, so there's no reason to send an additional
hotplug event here.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0242d693f4f6..156eeacee2ae 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -812,7 +812,6 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 	struct drm_connector *connector;
 	struct drm_dp_mst_topology_mgr *mgr;
 	int ret;
-	bool need_hotplug = false;
 
 	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
 
@@ -831,15 +830,15 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 			ret = drm_dp_mst_topology_mgr_resume(mgr);
 			if (ret < 0) {
 				drm_dp_mst_topology_mgr_set_mst(mgr, false);
-				need_hotplug = true;
+				mutex_lock(&aconnector->hpd_lock);
+				aconnector->dc_link->type =
+					dc_connection_single;
+				mutex_unlock(&aconnector->hpd_lock);
 			}
 		}
 	}
 
 	drm_modeset_unlock(&dev->mode_config.connection_mutex);
-
-	if (need_hotplug)
-		drm_kms_helper_hotplug_event(dev);
 }
 
 /**
-- 
2.21.0

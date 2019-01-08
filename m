From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH v2 1/3] drm/amdgpu: Don't ignore rc from drm_dp_mst_topology_mgr_resume()
Date: Tue,  8 Jan 2019 16:11:27 -0500
Message-ID: <20190108211133.32564-2-lyude@redhat.com>
References: <20190108211133.32564-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20190108211133.32564-1-lyude@redhat.com>
Sender: stable-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Jerry Zuo <Jerry.Zuo@amd.com>, stable@vger.kernel.org, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Tony Cheng <Tony.Cheng@amd.com>, David Francis <David.Francis@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Mikita Lipski <mikita.lipski@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, Anthony Koo <Anthony.Koo@amd.com>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

drm_dp_mst_topology_mgr_resume() returns whether or not it managed to
find the topology in question after a suspend resume cycle, and the
driver is supposed to check this value and disable MST accordingly if
it's gone-in addition to sending a hotplug in order to notify userspace
that something changed during suspend.

Currently, amdgpu just makes the mistake of ignoring the return code
from drm_dp_mst_topology_mgr_resume() which means that if a topology was
removed in suspend, amdgpu never notices and assumes it's still
connected which leads to all sorts of problems.

So, fix this by actually checking the rc from
drm_dp_mst_topology_mgr_resume(). Also, reformat the rest of the
function while we're at it to fix the over-indenting.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Cc: Jerry Zuo <Jerry.Zuo@amd.com>
Cc: <stable@vger.kernel.org> # v4.15+
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 32 +++++++++++++------
 1 file changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 8a626d16e8e3..3f326a2c513b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -699,22 +699,36 @@ static void s3_handle_mst(struct drm_device *dev, bool suspend)
 {
 	struct amdgpu_dm_connector *aconnector;
 	struct drm_connector *connector;
+	struct drm_dp_mst_topology_mgr *mgr;
+	int ret;
+	bool need_hotplug = false;
 
 	drm_modeset_lock(&dev->mode_config.connection_mutex, NULL);
 
-	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
-		   aconnector = to_amdgpu_dm_connector(connector);
-		   if (aconnector->dc_link->type == dc_connection_mst_branch &&
-				   !aconnector->mst_port) {
+	list_for_each_entry(connector, &dev->mode_config.connector_list,
+			    head) {
+		aconnector = to_amdgpu_dm_connector(connector);
+		if (aconnector->dc_link->type != dc_connection_mst_branch ||
+		    aconnector->mst_port)
+			continue;
+
+		mgr = &aconnector->mst_mgr;
 
-			   if (suspend)
-				   drm_dp_mst_topology_mgr_suspend(&aconnector->mst_mgr);
-			   else
-				   drm_dp_mst_topology_mgr_resume(&aconnector->mst_mgr);
-		   }
+		if (suspend) {
+			drm_dp_mst_topology_mgr_suspend(mgr);
+		} else {
+			ret = drm_dp_mst_topology_mgr_resume(mgr);
+			if (ret < 0) {
+				drm_dp_mst_topology_mgr_set_mst(mgr, false);
+				need_hotplug = true;
+			}
+		}
 	}
 
 	drm_modeset_unlock(&dev->mode_config.connection_mutex);
+
+	if (need_hotplug)
+		drm_kms_helper_hotplug_event(dev);
 }
 
 /**
-- 
2.20.1

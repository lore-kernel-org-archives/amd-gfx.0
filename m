From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH v2 02/27] drm/dp_mst: Get rid of list clear in destroy_connector_work
Date: Tue,  3 Sep 2019 16:45:40 -0400
Message-ID: <20190903204645.25487-3-lyude@redhat.com>
References: <20190903204645.25487-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190903204645.25487-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

This seems to be some leftover detritus from before the port/mstb kref
cleanup and doesn't do anything anymore, so get rid of it.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 36db66a0ddb1..3054ec622506 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3760,8 +3760,6 @@ static void drm_dp_destroy_connector_work(struct work_struct *work)
 		list_del(&port->next);
 		mutex_unlock(&mgr->destroy_connector_lock);
 
-		INIT_LIST_HEAD(&port->next);
-
 		mgr->cbs->destroy_connector(mgr, port->connector);
 
 		drm_dp_port_teardown_pdt(port, port->pdt);
-- 
2.21.0

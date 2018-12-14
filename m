From: Lyude Paul <lyude@redhat.com>
Subject: [WIP PATCH 14/15] drm/dp_mst: Check payload count in drm_dp_mst_atomic_check()
Date: Thu, 13 Dec 2018 20:25:43 -0500
Message-ID: <20181214012604.13746-15-lyude@redhat.com>
References: <20181214012604.13746-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181214012604.13746-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>, Harry Wentland <harry.wentland@amd.com>, Jerry Zuo <Jerry.Zuo@amd.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

It occurred to me that we never actually check this! So let's start
doing that.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index b9374c981a5b..ebffb834f5d6 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3538,7 +3538,7 @@ drm_dp_mst_atomic_check_topology_state(struct drm_dp_mst_topology_mgr *mgr,
 				       struct drm_dp_mst_topology_state *mst_state)
 {
 	struct drm_dp_vcpi_allocation *vcpi;
-	int avail_slots = 63, ret;
+	int avail_slots = 63, payload_count = 0, ret;
 
 	/* There's no possible scenario where releasing VCPI or keeping it the
 	 * same would make the state invalid
@@ -3575,6 +3575,13 @@ drm_dp_mst_atomic_check_topology_state(struct drm_dp_mst_topology_mgr *mgr,
 			goto port_fail;
 		}
 
+		if (++payload_count > mgr->max_payloads) {
+			DRM_DEBUG_ATOMIC("[MST MGR:%p] state %p has too many payloads (max=%d)\n",
+					 mgr, mst_state, mgr->max_payloads);
+			ret = -EINVAL;
+			goto port_fail;
+		}
+
 		drm_dp_mst_topology_put_port(vcpi->port);
 	}
 	DRM_DEBUG_ATOMIC("[MST MGR:%p] mst state %p VCPI avail=%d used=%d\n",
-- 
2.19.2

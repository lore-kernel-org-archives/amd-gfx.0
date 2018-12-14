From: Lyude Paul <lyude@redhat.com>
Subject: [WIP PATCH 02/15] drm/dp_mst: Refactor drm_dp_update_payload_part1()
Date: Thu, 13 Dec 2018 20:25:31 -0500
Message-ID: <20181214012604.13746-3-lyude@redhat.com>
References: <20181214012604.13746-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181214012604.13746-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>, Harry Wentland <harry.wentland@amd.com>, Jerry Zuo <Jerry.Zuo@amd.com>, Juston Li <juston.li@intel.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <maxime.ripard@bootlin.com>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

There should be no functional changes here

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Juston Li <juston.li@intel.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 71 ++++++++++++++++-----------
 1 file changed, 42 insertions(+), 29 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 9b1b5c9b1fa0..2ab16c9e6243 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1879,39 +1879,48 @@ int drm_dp_update_payload_part1(struct drm_dp_mst_topology_mgr *mgr)
 
 	mutex_lock(&mgr->payload_lock);
 	for (i = 0; i < mgr->max_payloads; i++) {
+		struct drm_dp_vcpi *vcpi = mgr->proposed_vcpis[i];
+		struct drm_dp_payload *payload = &mgr->payloads[i];
+
 		/* solve the current payloads - compare to the hw ones
 		   - update the hw view */
 		req_payload.start_slot = cur_slots;
-		if (mgr->proposed_vcpis[i]) {
-			port = container_of(mgr->proposed_vcpis[i], struct drm_dp_mst_port, vcpi);
+		if (vcpi) {
+			port = container_of(vcpi, struct drm_dp_mst_port,
+					    vcpi);
 			port = drm_dp_get_validated_port_ref(mgr, port);
 			if (!port) {
 				mutex_unlock(&mgr->payload_lock);
 				return -EINVAL;
 			}
-			req_payload.num_slots = mgr->proposed_vcpis[i]->num_slots;
-			req_payload.vcpi = mgr->proposed_vcpis[i]->vcpi;
+			req_payload.num_slots = vcpi->num_slots;
+			req_payload.vcpi = vcpi->vcpi;
 		} else {
 			port = NULL;
 			req_payload.num_slots = 0;
 		}
 
-		mgr->payloads[i].start_slot = req_payload.start_slot;
+		payload->start_slot = req_payload.start_slot;
 		/* work out what is required to happen with this payload */
-		if (mgr->payloads[i].num_slots != req_payload.num_slots) {
+		if (payload->num_slots != req_payload.num_slots) {
 
 			/* need to push an update for this payload */
 			if (req_payload.num_slots) {
-				drm_dp_create_payload_step1(mgr, mgr->proposed_vcpis[i]->vcpi, &req_payload);
-				mgr->payloads[i].num_slots = req_payload.num_slots;
-				mgr->payloads[i].vcpi = req_payload.vcpi;
-			} else if (mgr->payloads[i].num_slots) {
-				mgr->payloads[i].num_slots = 0;
-				drm_dp_destroy_payload_step1(mgr, port, mgr->payloads[i].vcpi, &mgr->payloads[i]);
-				req_payload.payload_state = mgr->payloads[i].payload_state;
-				mgr->payloads[i].start_slot = 0;
+				drm_dp_create_payload_step1(mgr, vcpi->vcpi,
+							    &req_payload);
+				payload->num_slots = req_payload.num_slots;
+				payload->vcpi = req_payload.vcpi;
+
+			} else if (payload->num_slots) {
+				payload->num_slots = 0;
+				drm_dp_destroy_payload_step1(mgr, port,
+							     payload->vcpi,
+							     payload);
+				req_payload.payload_state =
+					payload->payload_state;
+				payload->start_slot = 0;
 			}
-			mgr->payloads[i].payload_state = req_payload.payload_state;
+			payload->payload_state = req_payload.payload_state;
 		}
 		cur_slots += req_payload.num_slots;
 
@@ -1920,22 +1929,26 @@ int drm_dp_update_payload_part1(struct drm_dp_mst_topology_mgr *mgr)
 	}
 
 	for (i = 0; i < mgr->max_payloads; i++) {
-		if (mgr->payloads[i].payload_state == DP_PAYLOAD_DELETE_LOCAL) {
-			DRM_DEBUG_KMS("removing payload %d\n", i);
-			for (j = i; j < mgr->max_payloads - 1; j++) {
-				memcpy(&mgr->payloads[j], &mgr->payloads[j + 1], sizeof(struct drm_dp_payload));
-				mgr->proposed_vcpis[j] = mgr->proposed_vcpis[j + 1];
-				if (mgr->proposed_vcpis[j] && mgr->proposed_vcpis[j]->num_slots) {
-					set_bit(j + 1, &mgr->payload_mask);
-				} else {
-					clear_bit(j + 1, &mgr->payload_mask);
-				}
-			}
-			memset(&mgr->payloads[mgr->max_payloads - 1], 0, sizeof(struct drm_dp_payload));
-			mgr->proposed_vcpis[mgr->max_payloads - 1] = NULL;
-			clear_bit(mgr->max_payloads, &mgr->payload_mask);
+		if (mgr->payloads[i].payload_state != DP_PAYLOAD_DELETE_LOCAL)
+			continue;
+
+		DRM_DEBUG_KMS("removing payload %d\n", i);
+		for (j = i; j < mgr->max_payloads - 1; j++) {
+			mgr->payloads[j] = mgr->payloads[j + 1];
+			mgr->proposed_vcpis[j] = mgr->proposed_vcpis[j + 1];
 
+			if (mgr->proposed_vcpis[j] &&
+			    mgr->proposed_vcpis[j]->num_slots) {
+				set_bit(j + 1, &mgr->payload_mask);
+			} else {
+				clear_bit(j + 1, &mgr->payload_mask);
+			}
 		}
+
+		memset(&mgr->payloads[mgr->max_payloads - 1], 0,
+		       sizeof(struct drm_dp_payload));
+		mgr->proposed_vcpis[mgr->max_payloads - 1] = NULL;
+		clear_bit(mgr->max_payloads, &mgr->payload_mask);
 	}
 	mutex_unlock(&mgr->payload_lock);
 
-- 
2.19.2

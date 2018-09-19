From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH v2 5/6] drm/i915: Fix intel_dp_mst_best_encoder()
Date: Wed, 19 Sep 2018 19:09:02 -0400
Message-ID: <20180919230913.16894-6-lyude@redhat.com>
References: <20180919230913.16894-1-lyude@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180919230913.16894-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Currently, i915 appears to rely on blocking modesets on
no-longer-present MSTB ports by simply returning NULL for
->best_encoder(), which in turn causes any new atomic commits that don't
disable the CRTC to fail. This is wrong however, since we still want to
allow userspace to disable CRTCs on no-longer-present MSTB ports by
changing the DPMS state to off and this still requires that we retrieve
an encoder.

So, fix this by always returning a valid encoder regardless of the state
of the MST port. Additionally, make intel_dp_mst_atomic_check() simply
rely on drm_dp_mst_connector_atomic_check() to prevent new modesets on
no-longer-present MSTB ports.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/i915/intel_dp_mst.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
index a366f32b048a..2b798d4592f0 100644
--- a/drivers/gpu/drm/i915/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/intel_dp_mst.c
@@ -106,14 +106,21 @@ static bool intel_dp_mst_compute_config(struct intel_encoder *encoder,
 }
 
 static int intel_dp_mst_atomic_check(struct drm_connector *connector,
-		struct drm_connector_state *new_conn_state)
+				     struct drm_connector_state *new_conn_state)
 {
 	struct drm_atomic_state *state = new_conn_state->state;
 	struct drm_connector_state *old_conn_state;
 	struct drm_crtc *old_crtc;
 	struct drm_crtc_state *crtc_state;
+	struct drm_dp_mst_topology_mgr *mgr =
+		&to_intel_connector(connector)->mst_port->mst_mgr;
 	int slots, ret = 0;
 
+	ret = drm_dp_mst_connector_atomic_check(connector, new_conn_state,
+						mgr);
+	if (ret)
+		return ret;
+
 	old_conn_state = drm_atomic_get_old_connector_state(state, connector);
 	old_crtc = old_conn_state->crtc;
 	if (!old_crtc)
@@ -122,12 +129,6 @@ static int intel_dp_mst_atomic_check(struct drm_connector *connector,
 	crtc_state = drm_atomic_get_new_crtc_state(state, old_crtc);
 	slots = to_intel_crtc_state(crtc_state)->dp_m_n.tu;
 	if (drm_atomic_crtc_needs_modeset(crtc_state) && slots > 0) {
-		struct drm_dp_mst_topology_mgr *mgr;
-		struct drm_encoder *old_encoder;
-
-		old_encoder = old_conn_state->best_encoder;
-		mgr = &enc_to_mst(old_encoder)->primary->dp.mst_mgr;
-
 		ret = drm_dp_atomic_release_vcpi_slots(state, mgr, slots);
 		if (ret)
 			DRM_DEBUG_KMS("failed releasing %d vcpi slots:%d\n", slots, ret);
@@ -407,8 +408,6 @@ static struct drm_encoder *intel_mst_atomic_best_encoder(struct drm_connector *c
 	struct intel_dp *intel_dp = intel_connector->mst_port;
 	struct intel_crtc *crtc = to_intel_crtc(state->crtc);
 
-	if (intel_connector->mst_port_gone)
-		return NULL;
 	return &intel_dp->mst_encoders[crtc->pipe]->base.base;
 }
 
-- 
2.17.1

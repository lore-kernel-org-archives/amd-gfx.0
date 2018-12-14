From: Lyude Paul <lyude@redhat.com>
Subject: [WIP PATCH 15/15] drm/nouveau: Use atomic VCPI helpers for MST
Date: Thu, 13 Dec 2018 20:25:44 -0500
Message-ID: <20181214012604.13746-16-lyude@redhat.com>
References: <20181214012604.13746-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181214012604.13746-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: Daniel Vetter <daniel@ffwll.ch>, Dave Airlie <airlied@gmail.com>, Harry Wentland <harry.wentland@amd.com>, Jerry Zuo <Jerry.Zuo@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>, Karol Herbst <karolherbst@gmail.com>, Sean Paul <seanpaul@chromium.org>, Ilia Mirkin <imirkin@alum.mit.edu>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Currently, nouveau uses the yolo method of setting up MST displays: it
uses the old VCPI helpers (drm_dp_find_vcpi_slots()) for computing the
display configuration. These helpers don't take care to make sure they
take a reference to the mstb port that they're checking, and
additionally don't actually check whether or not the topology still has
enough bandwidth to provide the VCPI tokens required.

So, drop usage of the old helpers and move entirely over to the atomic
helpers.

Changes since v5:
 - Update nv50_msto_atomic_check() and nv50_mstc_atomic_check() to the
   new requirements for drm_dp_atomic_find_vcpi_slots() and
   drm_dp_atomic_release_vcpi_slots()

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 52 ++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 67f7bf97e5d9..df696008d205 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -762,16 +762,22 @@ nv50_msto_atomic_check(struct drm_encoder *encoder,
 		       struct drm_crtc_state *crtc_state,
 		       struct drm_connector_state *conn_state)
 {
-	struct nv50_mstc *mstc = nv50_mstc(conn_state->connector);
+	struct drm_atomic_state *state = crtc_state->state;
+	struct drm_connector *connector = conn_state->connector;
+	struct nv50_mstc *mstc = nv50_mstc(connector);
 	struct nv50_mstm *mstm = mstc->mstm;
-	int bpp = conn_state->connector->display_info.bpc * 3;
+	int bpp = connector->display_info.bpc * 3;
 	int slots;
 
-	mstc->pbn = drm_dp_calc_pbn_mode(crtc_state->adjusted_mode.clock, bpp);
+	mstc->pbn = drm_dp_calc_pbn_mode(crtc_state->adjusted_mode.clock,
+					 bpp);
 
-	slots = drm_dp_find_vcpi_slots(&mstm->mgr, mstc->pbn);
-	if (slots < 0)
-		return slots;
+	if (crtc_state->connectors_changed || crtc_state->mode_changed) {
+		slots = drm_dp_atomic_find_vcpi_slots(state, &mstm->mgr,
+						      mstc->port, mstc->pbn);
+		if (slots < 0)
+			return slots;
+	}
 
 	return nv50_outp_atomic_check_view(encoder, crtc_state, conn_state,
 					   mstc->native);
@@ -934,12 +940,42 @@ nv50_mstc_get_modes(struct drm_connector *connector)
 	return ret;
 }
 
+static int
+nv50_mstc_atomic_check(struct drm_connector *connector,
+		       struct drm_connector_state *new_conn_state)
+{
+	struct drm_atomic_state *state = new_conn_state->state;
+	struct nv50_mstc *mstc = nv50_mstc(connector);
+	struct drm_dp_mst_topology_mgr *mgr = &mstc->mstm->mgr;
+	struct drm_connector_state *old_conn_state =
+		drm_atomic_get_old_connector_state(state, connector);
+	struct drm_crtc_state *old_crtc_state;
+	struct drm_crtc *new_crtc = new_conn_state->crtc,
+			*old_crtc = old_conn_state->crtc;
+
+	if (!old_crtc)
+		return 0;
+
+	old_crtc_state = drm_atomic_get_old_crtc_state(state, old_crtc);
+	if (!old_crtc_state || !old_crtc_state->enable)
+		return 0;
+
+	if (new_crtc)
+		return 0;
+
+	/* This connector will be left without an enabled CRTC, so its VCPI
+	 * must be released here
+	 */
+	return drm_dp_atomic_release_vcpi_slots(state, mgr, mstc->port);
+}
+
 static const struct drm_connector_helper_funcs
 nv50_mstc_help = {
 	.get_modes = nv50_mstc_get_modes,
 	.mode_valid = nv50_mstc_mode_valid,
 	.best_encoder = nv50_mstc_best_encoder,
 	.atomic_best_encoder = nv50_mstc_atomic_best_encoder,
+	.atomic_check = nv50_mstc_atomic_check,
 };
 
 static enum drm_connector_status
@@ -2121,6 +2157,10 @@ nv50_disp_atomic_check(struct drm_device *dev, struct drm_atomic_state *state)
 			return ret;
 	}
 
+	ret = drm_dp_mst_atomic_check(state);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
-- 
2.19.2

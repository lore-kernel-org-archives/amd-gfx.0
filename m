From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH v2 2/6] drm/nouveau: Unbreak nv50_mstc->best_encoder()
Date: Wed, 19 Sep 2018 19:08:59 -0400
Message-ID: <20180919230913.16894-3-lyude@redhat.com>
References: <20180919230913.16894-1-lyude@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180919230913.16894-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org, Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel.vetter@ffwll.ch>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Sean Paul <seanpaul@chromium.org>, Ilia Mirkin <imirkin@alum.mit.edu>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

As mentioned in the previous commit, we currently prevent new modesets
on recently-removed MST connectors by returning no encoder from our
->best_encoder() callback once the MST port has disappeared. This is
wrong however, because it prevents legacy modesetting users from being
able to disable CRTCs on MST connectors after the connector's respective
topology has disappeared.

So, fix this by instead using the new
drm_dp_mst_connector_atomic_check() helper instead while always
returning a valid encoder from ->best_encoder().

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/nouveau/dispnv50/disp.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/nouveau/dispnv50/disp.c
index 9da0bdfe1e1c..8d6f6ee9bc75 100644
--- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
+++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
@@ -881,22 +881,16 @@ nv50_mstc_atomic_best_encoder(struct drm_connector *connector,
 {
 	struct nv50_head *head = nv50_head(connector_state->crtc);
 	struct nv50_mstc *mstc = nv50_mstc(connector);
-	if (mstc->port) {
-		struct nv50_mstm *mstm = mstc->mstm;
-		return &mstm->msto[head->base.index]->encoder;
-	}
-	return NULL;
+
+	return &mstc->mstm->msto[head->base.index]->encoder;
 }
 
 static struct drm_encoder *
 nv50_mstc_best_encoder(struct drm_connector *connector)
 {
 	struct nv50_mstc *mstc = nv50_mstc(connector);
-	if (mstc->port) {
-		struct nv50_mstm *mstm = mstc->mstm;
-		return &mstm->msto[0]->encoder;
-	}
-	return NULL;
+
+	return &mstc->mstm->msto[0]->encoder;
 }
 
 static enum drm_mode_status
@@ -926,10 +920,21 @@ nv50_mstc_get_modes(struct drm_connector *connector)
 	return ret;
 }
 
+static int
+nv50_mstc_atomic_check(struct drm_connector *connector,
+		       struct drm_connector_state *state)
+{
+	struct nv50_mstc *mstc = nv50_mstc(connector);
+
+	return drm_dp_mst_connector_atomic_check(connector, state,
+						 &mstc->mstm->mgr);
+}
+
 static const struct drm_connector_helper_funcs
 nv50_mstc_help = {
 	.get_modes = nv50_mstc_get_modes,
 	.mode_valid = nv50_mstc_mode_valid,
+	.atomic_check = nv50_mstc_atomic_check,
 	.best_encoder = nv50_mstc_best_encoder,
 	.atomic_best_encoder = nv50_mstc_atomic_best_encoder,
 };
-- 
2.17.1

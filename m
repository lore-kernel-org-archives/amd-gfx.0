From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH v5 02/14] drm/dp_mst: Remove PDT teardown in drm_dp_destroy_port() and refactor
Date: Mon, 21 Oct 2019 22:35:57 -0400
Message-ID: <20191022023641.8026-3-lyude@redhat.com>
References: <20191022023641.8026-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191022023641.8026-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc: Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Sean Paul <sean@poorly.run>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

This will allow us to add some locking for port->* members, in
particular the PDT and ->connector, which can't be done from
drm_dp_destroy_port() since we don't know what locks the caller might be
holding.

Note that we already do this in delayed_destroy_work (renamed from
destroy_connector_work in this patch) for ports, we're just making it so
mstbs are also destroyed in this worker.

Changes since v2:
* Clarify commit message
Changes since v4:
* Clarify commit message more

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Sean Paul <sean@poorly.run>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 40 +++++++++++----------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp=
_mst_topology.c
index 66ff226d8c86..204d0c832c65 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1510,31 +1510,22 @@ static void drm_dp_destroy_port(struct kref *kref)
 =09=09container_of(kref, struct drm_dp_mst_port, topology_kref);
 =09struct drm_dp_mst_topology_mgr *mgr =3D port->mgr;
=20
-=09if (!port->input) {
-=09=09kfree(port->cached_edid);
+=09/* There's nothing that needs locking to destroy an input port yet */
+=09if (port->input) {
+=09=09drm_dp_mst_put_port_malloc(port);
+=09=09return;
+=09}
=20
-=09=09/*
-=09=09 * The only time we don't have a connector
-=09=09 * on an output port is if the connector init
-=09=09 * fails.
-=09=09 */
-=09=09if (port->connector) {
-=09=09=09/* we can't destroy the connector here, as
-=09=09=09 * we might be holding the mode_config.mutex
-=09=09=09 * from an EDID retrieval */
+=09kfree(port->cached_edid);
=20
-=09=09=09mutex_lock(&mgr->delayed_destroy_lock);
-=09=09=09list_add(&port->next, &mgr->destroy_port_list);
-=09=09=09mutex_unlock(&mgr->delayed_destroy_lock);
-=09=09=09schedule_work(&mgr->delayed_destroy_work);
-=09=09=09return;
-=09=09}
-=09=09/* no need to clean up vcpi
-=09=09 * as if we have no connector we never setup a vcpi */
-=09=09drm_dp_port_teardown_pdt(port, port->pdt);
-=09=09port->pdt =3D DP_PEER_DEVICE_NONE;
-=09}
-=09drm_dp_mst_put_port_malloc(port);
+=09/*
+=09 * we can't destroy the connector here, as we might be holding the
+=09 * mode_config.mutex from an EDID retrieval
+=09 */
+=09mutex_lock(&mgr->delayed_destroy_lock);
+=09list_add(&port->next, &mgr->destroy_port_list);
+=09mutex_unlock(&mgr->delayed_destroy_lock);
+=09schedule_work(&mgr->delayed_destroy_work);
 }
=20
 /**
@@ -3981,7 +3972,8 @@ static void drm_dp_tx_work(struct work_struct *work)
 static inline void
 drm_dp_delayed_destroy_port(struct drm_dp_mst_port *port)
 {
-=09port->mgr->cbs->destroy_connector(port->mgr, port->connector);
+=09if (port->connector)
+=09=09port->mgr->cbs->destroy_connector(port->mgr, port->connector);
=20
 =09drm_dp_port_teardown_pdt(port, port->pdt);
 =09port->pdt =3D DP_PEER_DEVICE_NONE;
--=20
2.21.0

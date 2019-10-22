From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH v5 01/14] drm/dp_mst: Destroy MSTBs asynchronously
Date: Mon, 21 Oct 2019 22:35:56 -0400
Message-ID: <20191022023641.8026-2-lyude@redhat.com>
References: <20191022023641.8026-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191022023641.8026-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc: Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>, Daniel Vetter <daniel@ffwll.ch>, Sean Paul <sean@poorly.run>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

When reprobing an MST topology during resume, we have to account for the
fact that while we were suspended it's possible that mstbs may have been
removed from any ports in the topology. Since iterating downwards in the
topology requires that we hold &mgr->lock, destroying MSTBs from this
context would result in attempting to lock &mgr->lock a second time and
deadlocking.

So, fix this by first moving destruction of MSTBs into
destroy_connector_work, then rename destroy_connector_work and friends
to reflect that they now destroy both ports and mstbs.

Note that even though this means that MSTBs will still be accessible for
a short period of time between their removal from the topology and
delayed destruction, we are still protected against referencing a MSTB
with a refcount of 0 since we use kref_get_unless_zero() in most places.

Changes since v1:
* s/destroy_connector_list/destroy_port_list/
  s/connector_destroy_lock/delayed_destroy_lock/
  s/connector_destroy_work/delayed_destroy_work/
  s/drm_dp_finish_destroy_branch_device/drm_dp_delayed_destroy_mstb/
  s/drm_dp_finish_destroy_port/drm_dp_delayed_destroy_port/
  - danvet
* Use two loops in drm_dp_delayed_destroy_work() - danvet
* Better explain why we need to do this - danvet
* Use cancel_work_sync() instead of flush_work() - flush_work() doesn't
  account for work requeing

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel@ffwll.ch>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Sean Paul <sean@poorly.run>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 164 +++++++++++++++++---------
 include/drm/drm_dp_mst_helper.h       |  26 ++--
 2 files changed, 128 insertions(+), 62 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp=
_mst_topology.c
index 9cccc5e63309..66ff226d8c86 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -1398,34 +1398,17 @@ static void drm_dp_destroy_mst_branch_device(struct=
 kref *kref)
 =09struct drm_dp_mst_branch *mstb =3D
 =09=09container_of(kref, struct drm_dp_mst_branch, topology_kref);
 =09struct drm_dp_mst_topology_mgr *mgr =3D mstb->mgr;
-=09struct drm_dp_mst_port *port, *tmp;
-=09bool wake_tx =3D false;
=20
-=09mutex_lock(&mgr->lock);
-=09list_for_each_entry_safe(port, tmp, &mstb->ports, next) {
-=09=09list_del(&port->next);
-=09=09drm_dp_mst_topology_put_port(port);
-=09}
-=09mutex_unlock(&mgr->lock);
-
-=09/* drop any tx slots msg */
-=09mutex_lock(&mstb->mgr->qlock);
-=09if (mstb->tx_slots[0]) {
-=09=09mstb->tx_slots[0]->state =3D DRM_DP_SIDEBAND_TX_TIMEOUT;
-=09=09mstb->tx_slots[0] =3D NULL;
-=09=09wake_tx =3D true;
-=09}
-=09if (mstb->tx_slots[1]) {
-=09=09mstb->tx_slots[1]->state =3D DRM_DP_SIDEBAND_TX_TIMEOUT;
-=09=09mstb->tx_slots[1] =3D NULL;
-=09=09wake_tx =3D true;
-=09}
-=09mutex_unlock(&mstb->mgr->qlock);
+=09INIT_LIST_HEAD(&mstb->destroy_next);
=20
-=09if (wake_tx)
-=09=09wake_up_all(&mstb->mgr->tx_waitq);
-
-=09drm_dp_mst_put_mstb_malloc(mstb);
+=09/*
+=09 * This can get called under mgr->mutex, so we need to perform the
+=09 * actual destruction of the mstb in another worker
+=09 */
+=09mutex_lock(&mgr->delayed_destroy_lock);
+=09list_add(&mstb->destroy_next, &mgr->destroy_branch_device_list);
+=09mutex_unlock(&mgr->delayed_destroy_lock);
+=09schedule_work(&mgr->delayed_destroy_work);
 }
=20
 /**
@@ -1540,10 +1523,10 @@ static void drm_dp_destroy_port(struct kref *kref)
 =09=09=09 * we might be holding the mode_config.mutex
 =09=09=09 * from an EDID retrieval */
=20
-=09=09=09mutex_lock(&mgr->destroy_connector_lock);
-=09=09=09list_add(&port->next, &mgr->destroy_connector_list);
-=09=09=09mutex_unlock(&mgr->destroy_connector_lock);
-=09=09=09schedule_work(&mgr->destroy_connector_work);
+=09=09=09mutex_lock(&mgr->delayed_destroy_lock);
+=09=09=09list_add(&port->next, &mgr->destroy_port_list);
+=09=09=09mutex_unlock(&mgr->delayed_destroy_lock);
+=09=09=09schedule_work(&mgr->delayed_destroy_work);
 =09=09=09return;
 =09=09}
 =09=09/* no need to clean up vcpi
@@ -3085,7 +3068,7 @@ void drm_dp_mst_topology_mgr_suspend(struct drm_dp_ms=
t_topology_mgr *mgr)
 =09=09=09   DP_MST_EN | DP_UPSTREAM_IS_SRC);
 =09mutex_unlock(&mgr->lock);
 =09flush_work(&mgr->work);
-=09flush_work(&mgr->destroy_connector_work);
+=09flush_work(&mgr->delayed_destroy_work);
 }
 EXPORT_SYMBOL(drm_dp_mst_topology_mgr_suspend);
=20
@@ -3995,34 +3978,104 @@ static void drm_dp_tx_work(struct work_struct *wor=
k)
 =09mutex_unlock(&mgr->qlock);
 }
=20
-static void drm_dp_destroy_connector_work(struct work_struct *work)
+static inline void
+drm_dp_delayed_destroy_port(struct drm_dp_mst_port *port)
 {
-=09struct drm_dp_mst_topology_mgr *mgr =3D container_of(work, struct drm_d=
p_mst_topology_mgr, destroy_connector_work);
-=09struct drm_dp_mst_port *port;
-=09bool send_hotplug =3D false;
+=09port->mgr->cbs->destroy_connector(port->mgr, port->connector);
+
+=09drm_dp_port_teardown_pdt(port, port->pdt);
+=09port->pdt =3D DP_PEER_DEVICE_NONE;
+
+=09drm_dp_mst_put_port_malloc(port);
+}
+
+static inline void
+drm_dp_delayed_destroy_mstb(struct drm_dp_mst_branch *mstb)
+{
+=09struct drm_dp_mst_topology_mgr *mgr =3D mstb->mgr;
+=09struct drm_dp_mst_port *port, *tmp;
+=09bool wake_tx =3D false;
+
+=09mutex_lock(&mgr->lock);
+=09list_for_each_entry_safe(port, tmp, &mstb->ports, next) {
+=09=09list_del(&port->next);
+=09=09drm_dp_mst_topology_put_port(port);
+=09}
+=09mutex_unlock(&mgr->lock);
+
+=09/* drop any tx slots msg */
+=09mutex_lock(&mstb->mgr->qlock);
+=09if (mstb->tx_slots[0]) {
+=09=09mstb->tx_slots[0]->state =3D DRM_DP_SIDEBAND_TX_TIMEOUT;
+=09=09mstb->tx_slots[0] =3D NULL;
+=09=09wake_tx =3D true;
+=09}
+=09if (mstb->tx_slots[1]) {
+=09=09mstb->tx_slots[1]->state =3D DRM_DP_SIDEBAND_TX_TIMEOUT;
+=09=09mstb->tx_slots[1] =3D NULL;
+=09=09wake_tx =3D true;
+=09}
+=09mutex_unlock(&mstb->mgr->qlock);
+
+=09if (wake_tx)
+=09=09wake_up_all(&mstb->mgr->tx_waitq);
+
+=09drm_dp_mst_put_mstb_malloc(mstb);
+}
+
+static void drm_dp_delayed_destroy_work(struct work_struct *work)
+{
+=09struct drm_dp_mst_topology_mgr *mgr =3D
+=09=09container_of(work, struct drm_dp_mst_topology_mgr,
+=09=09=09     delayed_destroy_work);
+=09bool send_hotplug =3D false, go_again;
+
 =09/*
 =09 * Not a regular list traverse as we have to drop the destroy
-=09 * connector lock before destroying the connector, to avoid AB->BA
+=09 * connector lock before destroying the mstb/port, to avoid AB->BA
 =09 * ordering between this lock and the config mutex.
 =09 */
-=09for (;;) {
-=09=09mutex_lock(&mgr->destroy_connector_lock);
-=09=09port =3D list_first_entry_or_null(&mgr->destroy_connector_list, stru=
ct drm_dp_mst_port, next);
-=09=09if (!port) {
-=09=09=09mutex_unlock(&mgr->destroy_connector_lock);
-=09=09=09break;
+=09do {
+=09=09go_again =3D false;
+
+=09=09for (;;) {
+=09=09=09struct drm_dp_mst_branch *mstb;
+
+=09=09=09mutex_lock(&mgr->delayed_destroy_lock);
+=09=09=09mstb =3D list_first_entry_or_null(&mgr->destroy_branch_device_lis=
t,
+=09=09=09=09=09=09=09struct drm_dp_mst_branch,
+=09=09=09=09=09=09=09destroy_next);
+=09=09=09if (mstb)
+=09=09=09=09list_del(&mstb->destroy_next);
+=09=09=09mutex_unlock(&mgr->delayed_destroy_lock);
+
+=09=09=09if (!mstb)
+=09=09=09=09break;
+
+=09=09=09drm_dp_delayed_destroy_mstb(mstb);
+=09=09=09go_again =3D true;
 =09=09}
-=09=09list_del(&port->next);
-=09=09mutex_unlock(&mgr->destroy_connector_lock);
=20
-=09=09mgr->cbs->destroy_connector(mgr, port->connector);
+=09=09for (;;) {
+=09=09=09struct drm_dp_mst_port *port;
=20
-=09=09drm_dp_port_teardown_pdt(port, port->pdt);
-=09=09port->pdt =3D DP_PEER_DEVICE_NONE;
+=09=09=09mutex_lock(&mgr->delayed_destroy_lock);
+=09=09=09port =3D list_first_entry_or_null(&mgr->destroy_port_list,
+=09=09=09=09=09=09=09struct drm_dp_mst_port,
+=09=09=09=09=09=09=09next);
+=09=09=09if (port)
+=09=09=09=09list_del(&port->next);
+=09=09=09mutex_unlock(&mgr->delayed_destroy_lock);
+
+=09=09=09if (!port)
+=09=09=09=09break;
+
+=09=09=09drm_dp_delayed_destroy_port(port);
+=09=09=09send_hotplug =3D true;
+=09=09=09go_again =3D true;
+=09=09}
+=09} while (go_again);
=20
-=09=09drm_dp_mst_put_port_malloc(port);
-=09=09send_hotplug =3D true;
-=09}
 =09if (send_hotplug)
 =09=09drm_kms_helper_hotplug_event(mgr->dev);
 }
@@ -4209,12 +4262,13 @@ int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_=
topology_mgr *mgr,
 =09mutex_init(&mgr->lock);
 =09mutex_init(&mgr->qlock);
 =09mutex_init(&mgr->payload_lock);
-=09mutex_init(&mgr->destroy_connector_lock);
+=09mutex_init(&mgr->delayed_destroy_lock);
 =09INIT_LIST_HEAD(&mgr->tx_msg_downq);
-=09INIT_LIST_HEAD(&mgr->destroy_connector_list);
+=09INIT_LIST_HEAD(&mgr->destroy_port_list);
+=09INIT_LIST_HEAD(&mgr->destroy_branch_device_list);
 =09INIT_WORK(&mgr->work, drm_dp_mst_link_probe_work);
 =09INIT_WORK(&mgr->tx_work, drm_dp_tx_work);
-=09INIT_WORK(&mgr->destroy_connector_work, drm_dp_destroy_connector_work);
+=09INIT_WORK(&mgr->delayed_destroy_work, drm_dp_delayed_destroy_work);
 =09init_waitqueue_head(&mgr->tx_waitq);
 =09mgr->dev =3D dev;
 =09mgr->aux =3D aux;
@@ -4255,7 +4309,7 @@ void drm_dp_mst_topology_mgr_destroy(struct drm_dp_ms=
t_topology_mgr *mgr)
 {
 =09drm_dp_mst_topology_mgr_set_mst(mgr, false);
 =09flush_work(&mgr->work);
-=09flush_work(&mgr->destroy_connector_work);
+=09cancel_work_sync(&mgr->delayed_destroy_work);
 =09mutex_lock(&mgr->payload_lock);
 =09kfree(mgr->payloads);
 =09mgr->payloads =3D NULL;
@@ -4267,7 +4321,7 @@ void drm_dp_mst_topology_mgr_destroy(struct drm_dp_ms=
t_topology_mgr *mgr)
 =09drm_atomic_private_obj_fini(&mgr->base);
 =09mgr->funcs =3D NULL;
=20
-=09mutex_destroy(&mgr->destroy_connector_lock);
+=09mutex_destroy(&mgr->delayed_destroy_lock);
 =09mutex_destroy(&mgr->payload_lock);
 =09mutex_destroy(&mgr->qlock);
 =09mutex_destroy(&mgr->lock);
diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helpe=
r.h
index 4a25e0577ae0..b2160c366fb7 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -143,6 +143,12 @@ struct drm_dp_mst_branch {
 =09 */
 =09struct kref malloc_kref;
=20
+=09/**
+=09 * @destroy_next: linked-list entry used by
+=09 * drm_dp_delayed_destroy_work()
+=09 */
+=09struct list_head destroy_next;
+
 =09u8 rad[8];
 =09u8 lct;
 =09int num_ports;
@@ -571,18 +577,24 @@ struct drm_dp_mst_topology_mgr {
 =09struct work_struct tx_work;
=20
 =09/**
-=09 * @destroy_connector_list: List of to be destroyed connectors.
+=09 * @destroy_port_list: List of to be destroyed connectors.
+=09 */
+=09struct list_head destroy_port_list;
+=09/**
+=09 * @destroy_branch_device_list: List of to be destroyed branch
+=09 * devices.
 =09 */
-=09struct list_head destroy_connector_list;
+=09struct list_head destroy_branch_device_list;
 =09/**
-=09 * @destroy_connector_lock: Protects @connector_list.
+=09 * @delayed_destroy_lock: Protects @destroy_port_list and
+=09 * @destroy_branch_device_list.
 =09 */
-=09struct mutex destroy_connector_lock;
+=09struct mutex delayed_destroy_lock;
 =09/**
-=09 * @destroy_connector_work: Work item to destroy connectors. Needed to
-=09 * avoid locking inversion.
+=09 * @delayed_destroy_work: Work item to destroy MST port and branch
+=09 * devices, needed to avoid locking inversion.
 =09 */
-=09struct work_struct destroy_connector_work;
+=09struct work_struct delayed_destroy_work;
 };
=20
 int drm_dp_mst_topology_mgr_init(struct drm_dp_mst_topology_mgr *mgr,
--=20
2.21.0

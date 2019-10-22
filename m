From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH v5 10/14] drm/nouveau: Resume hotplug interrupts earlier
Date: Mon, 21 Oct 2019 22:36:05 -0400
Message-ID: <20191022023641.8026-11-lyude@redhat.com>
References: <20191022023641.8026-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191022023641.8026-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc: Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Sean Paul <sean@poorly.run>, Ben Skeggs <bskeggs@redhat.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Currently, we enable hotplug detection only after we re-enable the
display. However, this is too late if we're planning on sending sideband
messages during the resume process - which we'll need to do in order to
reprobe the topology on resume.

So, enable hotplug events before reinitializing the display.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Sean Paul <sean@poorly.run>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/nouveau/nouveau_display.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_display.c b/drivers/gpu/drm/no=
uveau/nouveau_display.c
index 6f038511a03a..53f9bceaf17a 100644
--- a/drivers/gpu/drm/nouveau/nouveau_display.c
+++ b/drivers/gpu/drm/nouveau/nouveau_display.c
@@ -407,6 +407,17 @@ nouveau_display_init(struct drm_device *dev, bool resu=
me, bool runtime)
 =09struct drm_connector_list_iter conn_iter;
 =09int ret;
=20
+=09/*
+=09 * Enable hotplug interrupts (done as early as possible, since we need
+=09 * them for MST)
+=09 */
+=09drm_connector_list_iter_begin(dev, &conn_iter);
+=09nouveau_for_each_non_mst_connector_iter(connector, &conn_iter) {
+=09=09struct nouveau_connector *conn =3D nouveau_connector(connector);
+=09=09nvif_notify_get(&conn->hpd);
+=09}
+=09drm_connector_list_iter_end(&conn_iter);
+
 =09ret =3D disp->init(dev, resume, runtime);
 =09if (ret)
 =09=09return ret;
@@ -416,14 +427,6 @@ nouveau_display_init(struct drm_device *dev, bool resu=
me, bool runtime)
 =09 */
 =09drm_kms_helper_poll_enable(dev);
=20
-=09/* enable hotplug interrupts */
-=09drm_connector_list_iter_begin(dev, &conn_iter);
-=09nouveau_for_each_non_mst_connector_iter(connector, &conn_iter) {
-=09=09struct nouveau_connector *conn =3D nouveau_connector(connector);
-=09=09nvif_notify_get(&conn->hpd);
-=09}
-=09drm_connector_list_iter_end(&conn_iter);
-
 =09return ret;
 }
=20
--=20
2.21.0

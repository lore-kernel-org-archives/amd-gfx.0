From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH v5 08/14] drm/dp_mst: Lessen indenting in drm_dp_mst_topology_mgr_resume()
Date: Mon, 21 Oct 2019 22:36:03 -0400
Message-ID: <20191022023641.8026-9-lyude@redhat.com>
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

Does what it says on the tin.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Sean Paul <sean@poorly.run>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 59 +++++++++++++--------------
 1 file changed, 29 insertions(+), 30 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp=
_mst_topology.c
index c8e218b902ae..d486d15aa002 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -3212,45 +3212,44 @@ EXPORT_SYMBOL(drm_dp_mst_topology_mgr_suspend);
  */
 int drm_dp_mst_topology_mgr_resume(struct drm_dp_mst_topology_mgr *mgr)
 {
-=09int ret =3D 0;
+=09int ret;
+=09u8 guid[16];
=20
 =09mutex_lock(&mgr->lock);
+=09if (!mgr->mst_primary)
+=09=09goto out_fail;
=20
-=09if (mgr->mst_primary) {
-=09=09int sret;
-=09=09u8 guid[16];
+=09ret =3D drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, mgr->dpcd,
+=09=09=09       DP_RECEIVER_CAP_SIZE);
+=09if (ret !=3D DP_RECEIVER_CAP_SIZE) {
+=09=09DRM_DEBUG_KMS("dpcd read failed - undocked during suspend?\n");
+=09=09goto out_fail;
+=09}
=20
-=09=09sret =3D drm_dp_dpcd_read(mgr->aux, DP_DPCD_REV, mgr->dpcd, DP_RECEI=
VER_CAP_SIZE);
-=09=09if (sret !=3D DP_RECEIVER_CAP_SIZE) {
-=09=09=09DRM_DEBUG_KMS("dpcd read failed - undocked during suspend?\n");
-=09=09=09ret =3D -1;
-=09=09=09goto out_unlock;
-=09=09}
+=09ret =3D drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
+=09=09=09=09 DP_MST_EN |
+=09=09=09=09 DP_UP_REQ_EN |
+=09=09=09=09 DP_UPSTREAM_IS_SRC);
+=09if (ret < 0) {
+=09=09DRM_DEBUG_KMS("mst write failed - undocked during suspend?\n");
+=09=09goto out_fail;
+=09}
=20
-=09=09ret =3D drm_dp_dpcd_writeb(mgr->aux, DP_MSTM_CTRL,
-=09=09=09=09=09 DP_MST_EN | DP_UP_REQ_EN | DP_UPSTREAM_IS_SRC);
-=09=09if (ret < 0) {
-=09=09=09DRM_DEBUG_KMS("mst write failed - undocked during suspend?\n");
-=09=09=09ret =3D -1;
-=09=09=09goto out_unlock;
-=09=09}
+=09/* Some hubs forget their guids after they resume */
+=09ret =3D drm_dp_dpcd_read(mgr->aux, DP_GUID, guid, 16);
+=09if (ret !=3D 16) {
+=09=09DRM_DEBUG_KMS("dpcd read failed - undocked during suspend?\n");
+=09=09goto out_fail;
+=09}
+=09drm_dp_check_mstb_guid(mgr->mst_primary, guid);
=20
-=09=09/* Some hubs forget their guids after they resume */
-=09=09sret =3D drm_dp_dpcd_read(mgr->aux, DP_GUID, guid, 16);
-=09=09if (sret !=3D 16) {
-=09=09=09DRM_DEBUG_KMS("dpcd read failed - undocked during suspend?\n");
-=09=09=09ret =3D -1;
-=09=09=09goto out_unlock;
-=09=09}
-=09=09drm_dp_check_mstb_guid(mgr->mst_primary, guid);
+=09mutex_unlock(&mgr->lock);
=20
-=09=09ret =3D 0;
-=09} else
-=09=09ret =3D -1;
+=09return 0;
=20
-out_unlock:
+out_fail:
 =09mutex_unlock(&mgr->lock);
-=09return ret;
+=09return -1;
 }
 EXPORT_SYMBOL(drm_dp_mst_topology_mgr_resume);
=20
--=20
2.21.0

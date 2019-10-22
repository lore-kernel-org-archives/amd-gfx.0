From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH v5 12/14] drm/amdgpu/dm: Resume short HPD IRQs before resuming MST topology
Date: Mon, 21 Oct 2019 22:36:07 -0400
Message-ID: <20191022023641.8026-13-lyude@redhat.com>
References: <20191022023641.8026-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191022023641.8026-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
Cc: Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Alex Deucher <alexander.deucher@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, David Francis <David.Francis@amd.com>, Mario Kleiner <mario.kleiner.de@gmail.com>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Since we're going to be reprobing the entire topology state on resume
now using sideband transactions, we need to ensure that we actually have
short HPD irqs enabled before calling drm_dp_mst_topology_mgr_resume().
So, do that.

Changes since v3:
* Fix typo in comments

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Acked-by: Alex Deucher <alexander.deucher@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gp=
u/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 887bc1d5d9e2..8f67d301ad81 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1186,15 +1186,15 @@ static int dm_resume(void *handle)
 =09/* program HPD filter */
 =09dc_resume(dm->dc);
=20
-=09/* On resume we need to  rewrite the MSTM control bits to enamble MST*/
-=09s3_handle_mst(ddev, false);
-
 =09/*
 =09 * early enable HPD Rx IRQ, should be done before set mode as short
 =09 * pulse interrupts are used for MST
 =09 */
 =09amdgpu_dm_irq_resume_early(adev);
=20
+=09/* On resume we need to rewrite the MSTM control bits to enable MST*/
+=09s3_handle_mst(ddev, false);
+
 =09/* Do detection*/
 =09drm_connector_list_iter_begin(ddev, &iter);
 =09drm_for_each_connector_iter(connector, &iter) {
--=20
2.21.0

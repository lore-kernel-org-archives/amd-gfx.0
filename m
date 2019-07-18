From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH 23/26] drm/amdgpu/dm: Resume short HPD IRQs before resuming MST topology
Date: Wed, 17 Jul 2019 21:42:46 -0400
Message-ID: <20190718014329.8107-24-lyude@redhat.com>
References: <20190718014329.8107-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190718014329.8107-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org
Cc: Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, David Francis <David.Francis@amd.com>, Mario Kleiner <mario.kleiner.de@gmail.com>, Anthony Koo <Anthony.Koo@amd.com>, amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Since we're going to be reprobing the entire topology state on resume
now using sideband transactions, we need to ensure that we actually have
short HPD irqs enabled before calling drm_dp_mst_topology_mgr_resume().
So, do that.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 0ef49db0f08d..e33e080cf16d 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1041,15 +1041,15 @@ static int dm_resume(void *handle)
 	/* program HPD filter */
 	dc_resume(dm->dc);
 
-	/* On resume we need to  rewrite the MSTM control bits to enamble MST*/
-	s3_handle_mst(ddev, false);
-
 	/*
 	 * early enable HPD Rx IRQ, should be done before set mode as short
 	 * pulse interrupts are used for MST
 	 */
 	amdgpu_dm_irq_resume_early(adev);
 
+	/* On resume we need to  rewrite the MSTM control bits to enamble MST*/
+	s3_handle_mst(ddev, false);
+
 	/* Do detection*/
 	drm_connector_list_iter_begin(ddev, &iter);
 	drm_for_each_connector_iter(connector, &iter) {
-- 
2.21.0

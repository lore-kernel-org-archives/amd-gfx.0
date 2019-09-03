From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH v2 24/27] drm/amdgpu/dm: Resume short HPD IRQs before resuming MST topology
Date: Tue,  3 Sep 2019 16:46:02 -0400
Message-ID: <20190903204645.25487-25-lyude@redhat.com>
References: <20190903204645.25487-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190903204645.25487-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, David Francis <David.Francis@amd.com>, Mario Kleiner <mario.kleiner.de@gmail.com>, Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Since we're going to be reprobing the entire topology state on resume
now using sideband transactions, we need to ensure that we actually have
short HPD irqs enabled before calling drm_dp_mst_topology_mgr_resume().
So, do that.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 73630e2940d4..4d3c8bff77da 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -1185,15 +1185,15 @@ static int dm_resume(void *handle)
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

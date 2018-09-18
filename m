From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH 4/6] drm/i915: Skip vcpi allocation for MSTB ports that are gone
Date: Tue, 18 Sep 2018 19:06:20 -0400
Message-ID: <20180918230637.20700-5-lyude@redhat.com>
References: <20180918230637.20700-1-lyude@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180918230637.20700-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: stable@vger.kernel.org, Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Since we need to be able to allow DPMS on->off prop changes after an MST
port has disappeared from the system, we need to be able to make sure we
can compute a config for the resulting atomic commit. Currently this is
impossible when the port has disappeared, since the VCPI slot searching
we try to do in intel_dp_mst_compute_config() will fail with -EINVAL.

Since the only commits we want to allow on no-longer-present MST ports
are ones that shut off display hardware, we already know that no VCPI
allocations are needed. So, hardcode the VCPI slot count to 0 when
intel_dp_mst_compute_config() is called on an MST port that's gone.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/i915/intel_dp_mst.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/intel_dp_mst.c b/drivers/gpu/drm/i915/intel_dp_mst.c
index fcb9b87b9339..a366f32b048a 100644
--- a/drivers/gpu/drm/i915/intel_dp_mst.c
+++ b/drivers/gpu/drm/i915/intel_dp_mst.c
@@ -42,7 +42,7 @@ static bool intel_dp_mst_compute_config(struct intel_encoder *encoder,
 		to_intel_connector(conn_state->connector);
 	struct drm_atomic_state *state = pipe_config->base.state;
 	int bpp;
-	int lane_count, slots;
+	int lane_count, slots = 0;
 	const struct drm_display_mode *adjusted_mode = &pipe_config->base.adjusted_mode;
 	int mst_pbn;
 	bool reduce_m_n = drm_dp_has_quirk(&intel_dp->desc,
@@ -76,11 +76,16 @@ static bool intel_dp_mst_compute_config(struct intel_encoder *encoder,
 	mst_pbn = drm_dp_calc_pbn_mode(adjusted_mode->crtc_clock, bpp);
 	pipe_config->pbn = mst_pbn;
 
-	slots = drm_dp_atomic_find_vcpi_slots(state, &intel_dp->mst_mgr,
-					      connector->port, mst_pbn);
-	if (slots < 0) {
-		DRM_DEBUG_KMS("failed finding vcpi slots:%d\n", slots);
-		return false;
+	if (!connector->mst_port_gone) {
+		slots = drm_dp_atomic_find_vcpi_slots(state,
+						      &intel_dp->mst_mgr,
+						      connector->port,
+						      mst_pbn);
+		if (slots < 0) {
+			DRM_DEBUG_KMS("failed finding vcpi slots:%d\n",
+				      slots);
+			return false;
+		}
 	}
 
 	intel_link_compute_m_n(bpp, lane_count,
-- 
2.17.1

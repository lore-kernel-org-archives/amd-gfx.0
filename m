From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH v2 06/27] drm/dp_mst: Combine redundant cases in drm_dp_encode_sideband_req()
Date: Tue,  3 Sep 2019 16:45:44 -0400
Message-ID: <20190903204645.25487-7-lyude@redhat.com>
References: <20190903204645.25487-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190903204645.25487-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>, Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Noticed this while working on adding a drm_dp_decode_sideband_req().
DP_POWER_DOWN_PHY/DP_POWER_UP_PHY both use the same struct, so we can
just combine their cases.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
---
 drivers/gpu/drm/drm_dp_mst_topology.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/drm_dp_mst_topology.c b/drivers/gpu/drm/drm_dp_mst_topology.c
index 6f7f449ca12b..1c862749cb63 100644
--- a/drivers/gpu/drm/drm_dp_mst_topology.c
+++ b/drivers/gpu/drm/drm_dp_mst_topology.c
@@ -271,6 +271,8 @@ static void drm_dp_encode_sideband_req(struct drm_dp_sideband_msg_req_body *req,
 
 	switch (req->req_type) {
 	case DP_ENUM_PATH_RESOURCES:
+	case DP_POWER_DOWN_PHY:
+	case DP_POWER_UP_PHY:
 		buf[idx] = (req->u.port_num.port_number & 0xf) << 4;
 		idx++;
 		break;
@@ -358,12 +360,6 @@ static void drm_dp_encode_sideband_req(struct drm_dp_sideband_msg_req_body *req,
 		memcpy(&buf[idx], req->u.i2c_write.bytes, req->u.i2c_write.num_bytes);
 		idx += req->u.i2c_write.num_bytes;
 		break;
-
-	case DP_POWER_DOWN_PHY:
-	case DP_POWER_UP_PHY:
-		buf[idx] = (req->u.port_num.port_number & 0xf) << 4;
-		idx++;
-		break;
 	}
 	raw->cur_len = idx;
 }
-- 
2.21.0

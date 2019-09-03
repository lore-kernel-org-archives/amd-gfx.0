From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH v2 18/27] drm/dp_mst: Remove lies in {up,down}_rep_recv documentation
Date: Tue,  3 Sep 2019 16:45:56 -0400
Message-ID: <20190903204645.25487-19-lyude@redhat.com>
References: <20190903204645.25487-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190903204645.25487-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: Juston Li <juston.li@intel.com>, Imre Deak <imre.deak@intel.com>, =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Harry Wentland <hwentlan@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

These are most certainly accessed from far more than the mgr work. In
fact, up_req_recv is -only- ever accessed from outside the mgr work.

Cc: Juston Li <juston.li@intel.com>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Ville Syrjälä <ville.syrjala@linux.intel.com>
Cc: Harry Wentland <hwentlan@amd.com>
Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 include/drm/drm_dp_mst_helper.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/drm/drm_dp_mst_helper.h b/include/drm/drm_dp_mst_helper.h
index f253ee43e9d9..8ba2a01324bb 100644
--- a/include/drm/drm_dp_mst_helper.h
+++ b/include/drm/drm_dp_mst_helper.h
@@ -489,15 +489,11 @@ struct drm_dp_mst_topology_mgr {
 	int conn_base_id;
 
 	/**
-	 * @down_rep_recv: Message receiver state for down replies. This and
-	 * @up_req_recv are only ever access from the work item, which is
-	 * serialised.
+	 * @down_rep_recv: Message receiver state for down replies.
 	 */
 	struct drm_dp_sideband_msg_rx down_rep_recv;
 	/**
-	 * @up_req_recv: Message receiver state for up requests. This and
-	 * @down_rep_recv are only ever access from the work item, which is
-	 * serialised.
+	 * @up_req_recv: Message receiver state for up requests.
 	 */
 	struct drm_dp_sideband_msg_rx up_req_recv;
 
-- 
2.21.0

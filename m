From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH v2 6/6] drm/amdgpu/dm/mst: Use drm_dp_mst_connector_atomic_check()
Date: Wed, 19 Sep 2018 19:09:03 -0400
Message-ID: <20180919230913.16894-7-lyude@redhat.com>
References: <20180919230913.16894-1-lyude@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180919230913.16894-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: nouveau@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>, Roman Li <Roman.Li@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>, Shirish S <shirish.s@amd.com>, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Hook this into amdgpu's atomic check for their connectors so they never
get modesets on no-longer-present MST connectors. We'll also expand on
this later once we add DP MST fallback retraining support.

As well, turns out that the only atomic DRM driver without the
->best_encoder() bug is amdgpu. Congrats AMD!

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c  | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 9a300732ba37..d011a39f17b2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -294,10 +294,22 @@ static struct drm_encoder *dm_mst_best_encoder(struct drm_connector *connector)
 	return &amdgpu_dm_connector->mst_encoder->base;
 }
 
+static int
+amdgpu_dm_mst_connector_atomic_check(struct drm_connector *connector,
+				     struct drm_connector_state *new_cstate)
+{
+	struct amdgpu_dm_connector *aconnector =
+		to_amdgpu_dm_connector(connector);
+
+	return drm_dp_mst_connector_atomic_check(connector, new_cstate,
+						 &aconnector->mst_mgr);
+}
+
 static const struct drm_connector_helper_funcs dm_dp_mst_connector_helper_funcs = {
 	.get_modes = dm_dp_mst_get_modes,
 	.mode_valid = amdgpu_dm_connector_mode_valid,
 	.best_encoder = dm_mst_best_encoder,
+	.atomic_check = amdgpu_dm_mst_connector_atomic_check,
 };
 
 static void amdgpu_dm_encoder_destroy(struct drm_encoder *encoder)
-- 
2.17.1

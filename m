From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH 1/6] drm/amdgpu/dm/mst: Don't create MST topology managers for eDP ports
Date: Thu, 26 Sep 2019 18:51:03 -0400
Message-ID: <20190926225122.31455-2-lyude@redhat.com>
References: <20190926225122.31455-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926225122.31455-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>, Thomas Lim <Thomas.Lim@amd.com>, David Francis <David.Francis@amd.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 5ec14efd4d8c..185bf0e2bda2 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -417,6 +417,10 @@ void amdgpu_dm_initialize_dp_connector(struct amdgpu_display_manager *dm,
 	drm_dp_aux_register(&aconnector->dm_dp_aux.aux);
 	drm_dp_cec_register_connector(&aconnector->dm_dp_aux.aux,
 				      &aconnector->base);
+
+	if (aconnector->base.connector_type == DRM_MODE_CONNECTOR_eDP)
+		return;
+
 	aconnector->mst_mgr.cbs = &dm_mst_cbs;
 	drm_dp_mst_topology_mgr_init(
 		&aconnector->mst_mgr,
-- 
2.21.0

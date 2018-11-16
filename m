From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH 2/2] drm/amd/dm: Understand why attaching path/tile properties are needed
Date: Fri, 16 Nov 2018 18:24:39 -0500
Message-ID: <20181116232443.1709-3-lyude@redhat.com>
References: <20181116232443.1709-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181116232443.1709-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>, Roman Li <Roman.Li@amd.com>, Tony Cheng <Tony.Cheng@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, Shirish S <shirish.s@amd.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Path property is used for userspace to know what MST connector goes to
what actual DRM DisplayPort connector, the tiling property is for tiling
configurations. Not sure what else there is to figure out.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 0cca1809fdcd..1b0d209d8367 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -345,9 +345,6 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 	drm_connector_attach_encoder(&aconnector->base,
 				     &aconnector->mst_encoder->base);
 
-	/*
-	 * TODO: understand why this one is needed
-	 */
 	drm_object_attach_property(
 		&connector->base,
 		dev->mode_config.path_property,
-- 
2.19.1

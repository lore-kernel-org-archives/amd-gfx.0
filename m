From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH 1/2] drm/amd/dm: Don't forget to attach MST encoders
Date: Fri, 16 Nov 2018 18:24:38 -0500
Message-ID: <20181116232443.1709-2-lyude@redhat.com>
References: <20181116232443.1709-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181116232443.1709-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Jerry Zuo <Jerry.Zuo@amd.com>, Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Roman Li <Roman.Li@amd.com>, Shirish S <shirish.s@amd.com>, Daniel Vetter <daniel.vetter@ffwll.ch>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Drive-by fix, this is bound to cause problems somewhere.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Cc: Jerry Zuo <Jerry.Zuo@amd.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index d02c32a1039c..0cca1809fdcd 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -342,6 +342,8 @@ dm_dp_add_mst_connector(struct drm_dp_mst_topology_mgr *mgr,
 		master->connector_id);
 
 	aconnector->mst_encoder = dm_dp_create_fake_mst_encoder(master);
+	drm_connector_attach_encoder(&aconnector->base,
+				     &aconnector->mst_encoder->base);
 
 	/*
 	 * TODO: understand why this one is needed
-- 
2.19.1

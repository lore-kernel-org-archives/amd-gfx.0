From: Lyude Paul <lyude@redhat.com>
Subject: [PATCH 2/6] drm/amdgpu/dm/mst: Remove unnecessary NULL check
Date: Thu, 26 Sep 2019 18:51:04 -0400
Message-ID: <20190926225122.31455-3-lyude@redhat.com>
References: <20190926225122.31455-1-lyude@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190926225122.31455-1-lyude@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: amd-gfx@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, "Jerry (Fangzhi) Zuo" <Jerry.Zuo@amd.com>, Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>, Thomas Lim <Thomas.Lim@amd.com>, David Francis <David.Francis@amd.com>, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

kfree() checks this automatically.

Signed-off-by: Lyude Paul <lyude@redhat.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
index 185bf0e2bda2..a398ddd1f306 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_mst_types.c
@@ -144,10 +144,8 @@ dm_dp_mst_connector_destroy(struct drm_connector *connector)
 	struct amdgpu_dm_connector *amdgpu_dm_connector = to_amdgpu_dm_connector(connector);
 	struct amdgpu_encoder *amdgpu_encoder = amdgpu_dm_connector->mst_encoder;
 
-	if (amdgpu_dm_connector->edid) {
-		kfree(amdgpu_dm_connector->edid);
-		amdgpu_dm_connector->edid = NULL;
-	}
+	kfree(amdgpu_dm_connector->edid);
+	amdgpu_dm_connector->edid = NULL;
 
 	drm_encoder_cleanup(&amdgpu_encoder->base);
 	kfree(amdgpu_encoder);
-- 
2.21.0

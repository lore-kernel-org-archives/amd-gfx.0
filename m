From: Bo YU <tsu.yubo@gmail.com>
Subject: [PATCH] drm/amdgpu: Error handling issues about CHECKED_RETURN
Date: Wed, 13 Feb 2019 23:46:28 -0500
Message-ID: <20190214044628.26759-1-tsu.yubo@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, Rex.Zhu@amd.com, andrey.grodzovsky@amd.com, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Bo Yu <tsu.yubo@gmail.com>, amd-gfx@lists.freedesktop.org
List-Id: amd-gfx.lists.freedesktop.org

From: Bo Yu <tsu.yubo@gmail.com>

Calling "amdgpu_ring_test_helper" without checking return value

Signed-off-by: Bo Yu <tsu.yubo@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
index 57cb3a51bda7..48465a61516b 100644
--- a/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/gfx_v8_0.c
@@ -4728,7 +4728,9 @@ static int gfx_v8_0_cp_test_all_rings(struct amdgpu_device *adev)
 
 	for (i = 0; i < adev->gfx.num_compute_rings; i++) {
 		ring = &adev->gfx.compute_ring[i];
-		amdgpu_ring_test_helper(ring);
+		r = amdgpu_ring_test_helper(ring);
+		if (r)
+			return r;
 	}
 
 	return 0;
-- 
2.11.0

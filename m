From: xiaolinkui <xiaolinkui@kylinos.cn>
Subject: [PATCH] gpu: drm: use struct_size() in kmalloc()
Date: Fri, 17 May 2019 16:46:00 +0800
Message-ID: <1558082760-4915-1-git-send-email-xiaolinkui@kylinos.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch, xinhui.pan@amd.com, evan.quan@amd.com
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, xiaolinkui@kylinos.cn
List-Id: amd-gfx.lists.freedesktop.org

Use struct_size() helper to keep code simple.

Signed-off-by: xiaolinkui <xiaolinkui@kylinos.cn>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
index 22bd21e..4717a64 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras.c
@@ -1375,8 +1375,7 @@ int amdgpu_ras_init(struct amdgpu_device *adev)
 	if (con)
 		return 0;
 
-	con = kmalloc(sizeof(struct amdgpu_ras) +
-			sizeof(struct ras_manager) * AMDGPU_RAS_BLOCK_COUNT,
+	con = kmalloc(struct_size(con, objs, AMDGPU_RAS_BLOCK_COUNT),
 			GFP_KERNEL|__GFP_ZERO);
 	if (!con)
 		return -ENOMEM;
-- 
2.7.4

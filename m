From: Navid Emamdoost <navid.emamdoost@gmail.com>
Subject: [PATCH] drm/amdgpu: release allocated memory
Date: Fri, 20 Sep 2019 17:49:10 -0500
Message-ID: <20190920224915.2788-1-navid.emamdoost@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: emamd001@umn.edu, smccaman@umn.edu, kjlu@umn.edu, Navid Emamdoost <navid.emamdoost@gmail.com>, Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>, Rex Zhu <Rex.Zhu@amd.com>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

In amdgpu_vmid_grab_idle, fences is being leaked in one execution path.
The missing kfree was added.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
index 57b3d8a9bef3..9063cd36fa94 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -244,6 +244,7 @@ static int amdgpu_vmid_grab_idle(struct amdgpu_vm *vm,
 		r = amdgpu_sync_fence(adev, sync, &array->base, false);
 		dma_fence_put(ring->vmid_wait);
 		ring->vmid_wait = &array->base;
+		kfree(fences);
 		return r;
 	}
 	kfree(fences);
-- 
2.17.1

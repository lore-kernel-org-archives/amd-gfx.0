From: Pan Bian <bianpan2016@163.com>
Subject: [PATCH] drm/amdgpu: fix potential double drop fence reference
Date: Wed,  6 Nov 2019 17:14:45 +0800
Message-ID: <1573031685-25969-1-git-send-email-bianpan2016@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, christian.koenig@amd.com, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Sam Ravnborg <sam@ravnborg.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
List-Id: amd-gfx.lists.freedesktop.org

The object fence is not set to NULL after its reference is dropped. As a
result, its reference may be dropped again if error occurs after that,
which may lead to a use after free bug. To avoid the issue, fence is
explicitly set to NULL after dropping its reference.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
index b66d29d5ffa2..b158230af8db 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_test.c
@@ -138,6 +138,7 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 		}
 
 		dma_fence_put(fence);
+		fence = NULL;
 
 		r = amdgpu_bo_kmap(vram_obj, &vram_map);
 		if (r) {
@@ -183,6 +184,7 @@ static void amdgpu_do_test_moves(struct amdgpu_device *adev)
 		}
 
 		dma_fence_put(fence);
+		fence = NULL;
 
 		r = amdgpu_bo_kmap(gtt_obj[i], &gtt_map);
 		if (r) {
-- 
2.7.4

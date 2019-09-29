From: yu kuai <yukuai3@huawei.com>
Subject: [PATCH] drm/amdgpu: remove set but not used variable 'pipe'
Date: Sun, 29 Sep 2019 20:38:43 +0800
Message-ID: <1569760723-119944-1-git-send-email-yukuai3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="y"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alexander.deucher@amd.com, christian.koenig@amd.com, David1.Zhou@amd.com, airlied@linux.ie, daniel@ffwll.ch
Cc: yukuai3@huawei.com, zhengbin13@huawei.com, yi.zhang@huawei.com, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

Fixes gcc '-Wunused-but-set-variable' warning:

rivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c: In function
‘amdgpu_gfx_graphics_queue_acquire’:
drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c:234:16: warning:
variable ‘pipe’ set but not used [-Wunused-but-set-variable]

It is never used, so can be removed.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: yu kuai <yukuai3@huawei.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index f9bef31..c1035a3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -231,12 +231,10 @@ void amdgpu_gfx_compute_queue_acquire(struct amdgpu_device *adev)
 
 void amdgpu_gfx_graphics_queue_acquire(struct amdgpu_device *adev)
 {
-	int i, queue, pipe, me;
+	int i, queue, me;
 
 	for (i = 0; i < AMDGPU_MAX_GFX_QUEUES; ++i) {
 		queue = i % adev->gfx.me.num_queue_per_pipe;
-		pipe = (i / adev->gfx.me.num_queue_per_pipe)
-			% adev->gfx.me.num_pipe_per_me;
 		me = (i / adev->gfx.me.num_queue_per_pipe)
 		      / adev->gfx.me.num_pipe_per_me;
 
-- 
2.7.4

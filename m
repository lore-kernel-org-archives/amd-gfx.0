From: Pan Bian <bianpan201603@163.com>
Subject: [PATCH 1/1] drm/radeon: check return value of radeon_fence_emit
Date: Mon, 24 Apr 2017 16:45:51 +0800
Message-ID: <1493023551-12003-1-git-send-email-bianpan201603@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie <airlied@linux.ie>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, Pan Bian <bianpan2016@163.com>
List-Id: amd-gfx.lists.freedesktop.org

From: Pan Bian <bianpan2016@163.com>

Function radeon_fence_emit() returns -ENOMEM if there is no enough
memory. And in this case, function radeon_ring_unlock_undo() rather than
function radeon_ring_unlock_commit() should be called. However, in
function radeon_test_create_and_emit_fence(), the return value of
radeon_fence_emit() is ignored. This patch adds the check.

Signed-off-by: Pan Bian <bianpan2016@163.com>
---
 drivers/gpu/drm/radeon/radeon_test.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/radeon/radeon_test.c b/drivers/gpu/drm/radeon/radeon_test.c
index 79181816..623768e 100644
--- a/drivers/gpu/drm/radeon/radeon_test.c
+++ b/drivers/gpu/drm/radeon/radeon_test.c
@@ -298,7 +298,12 @@ static int radeon_test_create_and_emit_fence(struct radeon_device *rdev,
 			DRM_ERROR("Failed to lock ring A %d\n", ring->idx);
 			return r;
 		}
-		radeon_fence_emit(rdev, fence, ring->idx);
+		r = radeon_fence_emit(rdev, fence, ring->idx);
+		if (r) {
+			DRM_ERROR("Failed to emit fence\n");
+			radeon_ring_unlock_undo(rdev, ring);
+			return r;
+		}
 		radeon_ring_unlock_commit(rdev, ring, false);
 	}
 	return 0;
-- 
1.9.1

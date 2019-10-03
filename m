From: Colin King <colin.king@canonical.com>
Subject: [PATCH][next] drm/amdgpu: fix uninitialized variable pasid_mapping_needed
Date: Thu,  3 Oct 2019 22:52:27 +0100
Message-ID: <20191003215227.23540-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Zhou <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

From: Colin Ian King <colin.king@canonical.com>

The boolean variable pasid_mapping_needed is not initialized and
there are code paths that do not assign it any value before it is
is read later.  Fix this by initializing pasid_mapping_needed to
false.

Addresses-Coverity: ("Uninitialized scalar variable")
Fixes: 6817bf283b2b ("drm/amdgpu: grab the id mgr lock while accessing passid_mapping")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index a2c797e34a29..be10e4b9a94d 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -1055,7 +1055,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		id->oa_size != job->oa_size);
 	bool vm_flush_needed = job->vm_needs_flush;
 	struct dma_fence *fence = NULL;
-	bool pasid_mapping_needed;
+	bool pasid_mapping_needed = false;
 	unsigned patch_offset = 0;
 	int r;
 
-- 
2.20.1

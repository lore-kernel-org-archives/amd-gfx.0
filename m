From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] drm/amdgpu_gem: fix error handling path in
 amdgpu_gem_va_update_vm
Date: Wed, 14 Feb 2018 23:20:00 -0600
Message-ID: <20180215052000.GA25691@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, "David (ChunMing) Zhou" <David1.Zhou@amd.com>, David Airlie <airlied@linux.ie>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: amd-gfx.lists.freedesktop.org

Currently, if amdgpu_vm_bo_update() fails, the returned error
is being ignored.

Fix this by properly checking _r_ after calling amdgpu_vm_bo_update.
Also, remove redundant code just before label _error_.

Addresses-Coverity-ID: 1464280 ("Unused value")
Fixes: 0abc6878fc2d ("drm/amdgpu: update VM PDs after the PTs")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
index e48b4ec..db85fc0 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
@@ -523,12 +523,13 @@ static void amdgpu_gem_va_update_vm(struct amdgpu_device *adev,
 		goto error;
 
 	if (operation == AMDGPU_VA_OP_MAP ||
-	    operation == AMDGPU_VA_OP_REPLACE)
+	    operation == AMDGPU_VA_OP_REPLACE) {
 		r = amdgpu_vm_bo_update(adev, bo_va, false);
+		if (r)
+			goto error;
+	}
 
 	r = amdgpu_vm_update_directories(adev, vm);
-	if (r)
-		goto error;
 
 error:
 	if (r && r != -ERESTARTSYS)
-- 
2.7.4

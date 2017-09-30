From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [PATCH 1/2] drm/amdgpu: potential uninitialized variable in
 amdgpu_vce_ring_parse_cs()
Date: Sat, 30 Sep 2017 11:13:28 +0300
Message-ID: <20170930081328.kher7yumqzi2vsrg@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <kernel-janitors-owner@vger.kernel.org>
Content-Disposition: inline
Sender: kernel-janitors-owner@vger.kernel.org
To: Alex Deucher <alexander.deucher@amd.com>, Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Cc: David Airlie <airlied@linux.ie>, Xiangliang Yu <Xiangliang.Yu@amd.com>, Leo Liu <leo.liu@amd.com>, Frank Min <Frank.Min@amd.com>, Junwei Zhang <Jerry.Zhang@amd.com>, Chris Wilson <chris@chris-wilson.co.uk>, amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, kernel-janitors@vger.kernel.org
List-Id: amd-gfx.lists.freedesktop.org

We shifted some code around in commit 9cca0b8e5df0 ("drm/amdgpu: move
amdgpu_cs_sysvm_access_required into find_mapping") and now my static
checker complains that "r" might not be initialized at the end of the
function.  I've reviewed the code, and that seems possible, but it's
also possible I may have missed something.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
index b46280c1279f..2918de2f39ec 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vce.c
@@ -648,7 +648,7 @@ int amdgpu_vce_ring_parse_cs(struct amdgpu_cs_parser *p, uint32_t ib_idx)
 	uint32_t allocated = 0;
 	uint32_t tmp, handle = 0;
 	uint32_t *size = &tmp;
-	int i, r, idx = 0;
+	int i, r = 0, idx = 0;
 
 	p->job->vm = NULL;
 	ib->gpu_addr = amdgpu_sa_bo_gpu_addr(ib->sa_bo);
